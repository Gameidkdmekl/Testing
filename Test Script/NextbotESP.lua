-- NextbotESP.lua
-- Внешний ESP для некстботов, загружаемый через Draconic Hub

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local workspace = game:GetService("Workspace")

-- Функции для работы с Drawing API
local drawings = {}
local nextbotData = {}
local espEnabled = false
local loopConnection = nil
local cleanupInterval = 30 -- Очистка старых объектов каждые 30 секунд
local lastCleanup = tick()

-- Настройки ESP
local ESP_CONFIG = {
    BoxColor = Color3.fromRGB(255, 0, 0),     -- Красный для некстботов
    TextColor = Color3.fromRGB(255, 255, 255), -- Белый текст
    TracerColor = Color3.fromRGB(255, 0, 0),   -- Красные трассеры
    MaxDistance = 1000,                       -- Максимальная дистанция
    BoxThickness = 1,
    TracerThickness = 1,
    TextSize = 14,
    ShowDistance = true,
    ShowHealth = true,
    ShowName = true,
    ShowBox = true,
    ShowTracer = true
}

-- Глобальные переменные для управления из основного скрипта
_G.NextbotESPRunning = false
_G.StopNextbotESP = function()
    _G.NextbotESPRunning = false
    if loopConnection then
        loopConnection:Disconnect()
        loopConnection = nil
    end
    clearAllDrawings()
end

-- Создание Drawing объектов
local function createDrawing(type, properties)
    local drawing = Drawing.new(type)
    for prop, value in pairs(properties) do
        drawing[prop] = value
    end
    return drawing
end

-- Очистка всех Drawing объектов
local function clearAllDrawings()
    for _, drawingGroup in pairs(drawings) do
        if drawingGroup then
            for _, drawing in pairs(drawingGroup) do
                if drawing and drawing.Remove then
                    drawing:Remove()
                end
            end
        end
    end
    drawings = {}
    nextbotData = {}
end

-- Функция для получения некстботов из игры
local function getNextbots()
    local nextbots = {}
    
    -- Ищем в Game.Players
    local gamePlayers = workspace:FindFirstChild("Game") and workspace.Game:FindFirstChild("Players")
    if gamePlayers then
        for _, model in pairs(gamePlayers:GetChildren()) do
            if model:IsA("Model") then
                -- Проверяем, является ли модель некстботом
                local isBot = false
                local modelName = model.Name:lower()
                
                -- Проверка по имени
                if modelName:find("nextbot") or 
                   modelName:find("scp") or 
                   modelName:find("monster") or
                   modelName:find("creep") or
                   modelName:find("enemy") or
                   modelName:find("zombie") or
                   modelName:find("ghost") or
                   modelName:find("demon") or
                   modelName:find("bot") then
                    isBot = true
                end
                
                -- Проверка по атрибутам
                if not isBot and model:GetAttribute("IsBot") or model:GetAttribute("IsNPC") then
                    isBot = true
                end
                
                if isBot and model:FindFirstChild("HumanoidRootPart") then
                    table.insert(nextbots, model)
                end
            end
        end
    end
    
    -- Ищем в NPCs
    local npcsFolder = workspace:FindFirstChild("NPCs")
    if npcsFolder then
        for _, model in pairs(npcsFolder:GetChildren()) do
            if model:IsA("Model") and model:FindFirstChild("HumanoidRootPart") then
                table.insert(nextbots, model)
            end
        end
    end
    
    return nextbots
end

-- Получение здоровья некстбота
local function getNextbotHealth(model)
    local humanoid = model:FindFirstChildOfClass("Humanoid")
    if humanoid then
        return math.floor(humanoid.Health), math.floor(humanoid.MaxHealth)
    end
    return 100, 100
end

-- Получение дистанции до некстбота
local function getDistanceFromPlayer(targetPosition)
    if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        return 0
    end
    local distance = (targetPosition - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
    return math.floor(distance)
end

-- Создание ESP для одного некстбота
local function createNextbotESP(model)
    local hrp = model:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    
    local drawingGroup = {
        Box = createDrawing("Square", {
            Color = ESP_CONFIG.BoxColor,
            Thickness = ESP_CONFIG.BoxThickness,
            Filled = false,
            Visible = false,
            ZIndex = 2
        }),
        Name = createDrawing("Text", {
            Color = ESP_CONFIG.TextColor,
            Size = ESP_CONFIG.TextSize,
            Center = true,
            Outline = true,
            Visible = false,
            ZIndex = 3
        }),
        Distance = createDrawing("Text", {
            Color = ESP_CONFIG.TextColor,
            Size = ESP_CONFIG.TextSize - 2,
            Center = true,
            Outline = true,
            Visible = false,
            ZIndex = 3
        }),
        Health = createDrawing("Text", {
            Color = ESP_CONFIG.TextColor,
            Size = ESP_CONFIG.TextSize - 2,
            Center = true,
            Outline = true,
            Visible = false,
            ZIndex = 3
        }),
        Tracer = createDrawing("Line", {
            Color = ESP_CONFIG.TracerColor,
            Thickness = ESP_CONFIG.TracerThickness,
            Visible = false,
            ZIndex = 1
        })
    }
    
    drawings[model] = drawingGroup
    nextbotData[model] = {
        lastSeen = tick(),
        position = hrp.Position
    }
    
    return drawingGroup
end

-- Обновление ESP для одного некстбота
local function updateNextbotESP(model, drawingGroup)
    if not model or not model.Parent then return false end
    
    local hrp = model:FindFirstChild("HumanoidRootPart")
    if not hrp then return false end
    
    local camera = workspace.CurrentCamera
    if not camera then return false end
    
    -- Получаем позицию на экране
    local position, onScreen = camera:WorldToViewportPoint(hrp.Position)
    
    if not onScreen then
        -- Скрываем ESP если объект не на экране
        for _, drawing in pairs(drawingGroup) do
            drawing.Visible = false
        end
        return false
    end
    
    -- Получаем данные о некстботе
    local distance = getDistanceFromPlayer(hrp.Position)
    local currentHealth, maxHealth = getNextbotHealth(model)
    
    -- Обновляем данные
    nextbotData[model] = {
        lastSeen = tick(),
        position = hrp.Position,
        distance = distance,
        health = currentHealth,
        maxHealth = maxHealth
    }
    
    -- Пропускаем если слишком далеко
    if distance > ESP_CONFIG.MaxDistance then
        for _, drawing in pairs(drawingGroup) do
            drawing.Visible = false
        end
        return false
    end
    
    -- Размеры бокса (зависит от дистанции)
    local boxSize = Vector2.new(50, 80) * (1000 / math.max(distance, 100))
    boxSize = Vector2.new(
        math.clamp(boxSize.X, 20, 100),
        math.clamp(boxSize.Y, 30, 120)
    )
    
    -- Позиция для бокса
    local boxPosition = Vector2.new(position.X, position.Y)
    
    -- Бокс
    if ESP_CONFIG.ShowBox and drawingGroup.Box then
        drawingGroup.Box.Size = boxSize
        drawingGroup.Box.Position = boxPosition - boxSize / 2
        drawingGroup.Box.Visible = true
    else
        drawingGroup.Box.Visible = false
    end
    
    -- Имя
    if ESP_CONFIG.ShowName and drawingGroup.Name then
        drawingGroup.Name.Text = model.Name
        drawingGroup.Name.Position = boxPosition - Vector2.new(0, boxSize.Y / 2 + 15)
        drawingGroup.Name.Visible = true
    else
        drawingGroup.Name.Visible = false
    end
    
    -- Дистанция
    if ESP_CONFIG.ShowDistance and drawingGroup.Distance then
        drawingGroup.Distance.Text = string.format("[%d m]", distance)
        drawingGroup.Distance.Position = boxPosition + Vector2.new(0, boxSize.Y / 2 + 5)
        drawingGroup.Distance.Visible = true
    else
        drawingGroup.Distance.Visible = false
    end
    
    -- Здоровье
    if ESP_CONFIG.ShowHealth and drawingGroup.Health then
        local healthPercent = math.floor((currentHealth / maxHealth) * 100)
        local healthColor = Color3.fromRGB(
            255 - (healthPercent * 2.55),
            healthPercent * 2.55,
            0
        )
        drawingGroup.Health.Text = string.format("%d/%d (%d%%)", currentHealth, maxHealth, healthPercent)
        drawingGroup.Health.Color = healthColor
        drawingGroup.Health.Position = boxPosition + Vector2.new(0, boxSize.Y / 2 + 20)
        drawingGroup.Health.Visible = true
    else
        drawingGroup.Health.Visible = false
    end
    
    -- Трассер (линия от центра экрана к некстботу)
    if ESP_CONFIG.ShowTracer and drawingGroup.Tracer then
        local screenCenter = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y)
        drawingGroup.Tracer.From = screenCenter
        drawingGroup.Tracer.To = Vector2.new(position.X, position.Y)
        drawingGroup.Tracer.Visible = true
    else
        drawingGroup.Tracer.Visible = false
    end
    
    return true
end

-- Основной цикл ESP
local function updateNextbotESPList()
    if not espEnabled or not _G.NextbotESPRunning then return end
    
    local currentTime = tick()
    
    -- Очистка старых объектов
    if currentTime - lastCleanup > cleanupInterval then
        for model, data in pairs(nextbotData) do
            if currentTime - data.lastSeen > cleanupInterval * 2 then
                if drawings[model] then
                    for _, drawing in pairs(drawings[model]) do
                        if drawing and drawing.Remove then
                            drawing:Remove()
                        end
                    end
                    drawings[model] = nil
                end
                nextbotData[model] = nil
            end
        end
        lastCleanup = currentTime
    end
    
    -- Получаем текущих некстботов
    local currentNextbots = getNextbots()
    local processedModels = {}
    
    -- Обновляем существующие ESP
    for model, drawingGroup in pairs(drawings) do
        if not model or not model.Parent then
            -- Удаляем ESP для удаленных моделей
            for _, drawing in pairs(drawingGroup) do
                if drawing and drawing.Remove then
                    drawing:Remove()
                end
            end
            drawings[model] = nil
            nextbotData[model] = nil
        else
            -- Обновляем ESP
            local isStillNextbot = false
            for _, nextbot in pairs(currentNextbots) do
                if nextbot == model then
                    isStillNextbot = true
                    break
                end
            end
            
            if isStillNextbot then
                updateNextbotESP(model, drawingGroup)
                processedModels[model] = true
            else
                -- Скрываем ESP если объект больше не некстбот
                for _, drawing in pairs(drawingGroup) do
                    drawing.Visible = false
                end
            end
        end
    end
    
    -- Создаем ESP для новых некстботов
    for _, model in pairs(currentNextbots) do
        if not processedModels[model] then
            local drawingGroup = createNextbotESP(model)
            if drawingGroup then
                updateNextbotESP(model, drawingGroup)
            end
        end
    end
end

-- Функция для запуска ESP
local function startNextbotESP()
    if espEnabled then return end
    
    espEnabled = true
    _G.NextbotESPRunning = true
    
    -- Запускаем цикл обновления
    loopConnection = RunService.RenderStepped:Connect(updateNextbotESPList)
    
    print("Nextbot ESP started successfully!")
end

-- Функция для остановки ESP
local function stopNextbotESP()
    espEnabled = false
    _G.NextbotESPRunning = false
    
    if loopConnection then
        loopConnection:Disconnect()
        loopConnection = nil
    end
    
    clearAllDrawings()
    
    print("Nextbot ESP stopped successfully!")
end

-- Экспортируемые функции
return {
    Start = startNextbotESP,
    Stop = stopNextbotESP,
    UpdateConfig = function(newConfig)
        if newConfig then
            for key, value in pairs(newConfig) do
                if ESP_CONFIG[key] ~= nil then
                    ESP_CONFIG[key] = value
                end
            end
        end
    end,
    GetConfig = function()
        return ESP_CONFIG
    end,
    ClearAll = clearAllDrawings,
    IsRunning = function()
        return espEnabled and _G.NextbotESPRunning
    end
}
