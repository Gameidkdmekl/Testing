-- NextbotESP.lua - Оптимизированная версия (ТОЧНО как было раньше)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- Оригинальные переменные ESP (ТОЧНО как было)
local NextbotBillboards = {}
local nextbotLoop = nil

-- Оптимизационные переменные (добавлены только для производительности)
local BOT_CACHE = {}
local LAST_CACHE_UPDATE = 0
local CACHE_UPDATE_INTERVAL = 0.7
local MAX_BOTS_PER_FRAME = 5
local ESP_UPDATE_RATE = 0.1
local LAST_ESP_UPDATE = 0

-- Кэш для быстрой проверки nextbot'ов (добавлено только для оптимизации)
local NEXTBOT_NAME_CACHE = {}

-- Функция получения имен nextbot'ов (ТОЧНО как было)
local function getNextbotNames()
    local names = {}
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    if ReplicatedStorage:FindFirstChild("NPCs") then
        for _, npc in ipairs(ReplicatedStorage.NPCs:GetChildren()) do
            table.insert(names, npc.Name)
        end
    end
    return names
end

local nextBotNames = getNextbotNames()

-- Функция проверки nextbot (ТОЧНО как было)
function isNextbotModel(model)
    if not model or not model.Name then return false end
    
    -- Оптимизация: проверка кэша
    local nameLower = model.Name:lower()
    if NEXTBOT_NAME_CACHE[nameLower] ~= nil then
        return NEXTBOT_NAME_CACHE[nameLower]
    end
    
    -- Оригинальный код:
    for _, name in ipairs(nextBotNames) do
        if model.Name == name then 
            NEXTBOT_NAME_CACHE[nameLower] = true
            return true 
        end
    end
    
    local result = model.Name:lower():find("nextbot") or 
                   model.Name:lower():find("scp") or 
                   model.Name:lower():find("monster") or
                   model.Name:lower():find("creep") or
                   model.Name:lower():find("enemy") or
                   model.Name:lower():find("zombie") or
                   model.Name:lower():find("ghost") or
                   model.Name:lower():find("demon")
    
    NEXTBOT_NAME_CACHE[nameLower] = result
    return result
end

-- Функция получения расстояния (ТОЧНО как было)
function getDistanceFromPlayer(targetPosition)
    if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then 
        return 0 
    end
    local distance = (targetPosition - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
    return math.floor(distance)
end

-- Функция для обновления кэша ботов (добавлено для оптимизации)
local function updateBotCache()
    local currentTime = tick()
    if currentTime - LAST_CACHE_UPDATE < CACHE_UPDATE_INTERVAL then
        return
    end
    
    LAST_CACHE_UPDATE = currentTime
    
    -- Очищаем удаленных ботов
    for bot, _ in pairs(BOT_CACHE) do
        if not bot.Parent then
            BOT_CACHE[bot] = nil
        end
    end
    
    -- Ищем в папке Game/Players
    local gameFolder = workspace:FindFirstChild("Game")
    if gameFolder then
        local playersFolder = gameFolder:FindFirstChild("Players")
        if playersFolder then
            for _, model in pairs(playersFolder:GetChildren()) do
                if model:IsA("Model") and isNextbotModel(model) then
                    local hrp = model:FindFirstChild("HumanoidRootPart")
                    if hrp and not BOT_CACHE[model] then
                        BOT_CACHE[model] = hrp
                    end
                end
            end
        end
    end
    
    -- Ищем в папке NPCs
    local npcsFolder = workspace:FindFirstChild("NPCs")
    if npcsFolder then
        for _, model in pairs(npcsFolder:GetChildren()) do
            if model:IsA("Model") and isNextbotModel(model) then
                local hrp = model:FindFirstChild("HumanoidRootPart")
                if hrp and not BOT_CACHE[model] then
                    BOT_CACHE[model] = hrp
                end
            end
        end
    end
end

-- Функция обновления ESP (ОПТИМИЗИРОВАНА, но стиль ТОЧНО как был)
local function updateESP()
    local currentTime = tick()
    if currentTime - LAST_ESP_UPDATE < ESP_UPDATE_RATE then
        return
    end
    LAST_ESP_UPDATE = currentTime
    
    -- Обновляем кэш ботов
    updateBotCache()
    
    local character = LocalPlayer.Character
    if not character then return end
    
    local hrp = character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    
    -- Обрабатываем ботов порциями (оптимизация)
    local processed = 0
    for bot, botHrp in pairs(BOT_CACHE) do
        if processed >= MAX_BOTS_PER_FRAME then
            break
        end
        
        if botHrp and botHrp.Parent then
            processed = processed + 1
            
            -- Создаем или обновляем Billboard ESP (ТОЧНО как было)
            if not NextbotBillboards[bot] then
                local billboard = Instance.new("BillboardGui")
                billboard.Name = "NextbotESP"
                billboard.AlwaysOnTop = true
                billboard.Size = UDim2.new(0, 200, 0, 50)
                billboard.StudsOffset = Vector3.new(0, 3, 0)
                billboard.Adornee = botHrp
                billboard.Parent = botHrp
                
                -- Текст ESP (ТОЧНО как было раньше)
                local textLabel = Instance.new("TextLabel")
                textLabel.Size = UDim2.new(1, 0, 1, 0)
                textLabel.BackgroundTransparency = 1
                textLabel.TextColor3 = Color3.fromRGB(255, 0, 0)  -- Красный цвет
                textLabel.Font = Enum.Font.SourceSansBold  -- Как было
                textLabel.TextSize = 18  -- Как было
                textLabel.TextStrokeTransparency = 0.5  -- Как было
                textLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)  -- Черный контур
                textLabel.Parent = billboard
                
                NextbotBillboards[bot] = billboard
            end
            
            -- Обновляем текст (ТОЧНО как было)
            local billboard = NextbotBillboards[bot]
            if billboard and billboard.Parent then
                local textLabel = billboard:FindFirstChild("TextLabel")
                if textLabel then
                    local distance = getDistanceFromPlayer(botHrp.Position)
                    -- Формат текста: [123m] Name
                    textLabel.Text = "[" .. distance .. "m] " .. bot.Name
                end
                billboard.Adornee = botHrp
                billboard.Enabled = true
            end
        end
    end
    
    -- Очищаем ESP для удаленных ботов
    for bot, billboard in pairs(NextbotBillboards) do
        if not BOT_CACHE[bot] then
            pcall(function()
                billboard:Destroy()
            end)
            NextbotBillboards[bot] = nil
        end
    end
end

-- Функция запуска ESP
local function startESP()
    if nextbotLoop then 
        nextbotLoop:Disconnect() 
    end
    
    -- Очищаем кэши при запуске
    BOT_CACHE = {}
    NEXTBOT_NAME_CACHE = {}
    
    -- Очищаем старые ESP
    for bot, billboard in pairs(NextbotBillboards) do
        pcall(function()
            billboard:Destroy()
        end)
    end
    NextbotBillboards = {}
    
    -- Запускаем оптимизированный цикл
    nextbotLoop = RunService.RenderStepped:Connect(function()
        pcall(updateESP)
    end)
    
    print("Nextbot ESP: Started (Optimized)")
end

-- Функция остановки ESP
local function stopESP()
    if nextbotLoop then
        nextbotLoop:Disconnect()
        nextbotLoop = nil
    end
    
    -- Удаляем все ESP (ИСПРАВЛЕНО: теперь точно удаляет)
    for bot, billboard in pairs(NextbotBillboards) do
        pcall(function()
            billboard:Destroy()
        end)
    end
    NextbotBillboards = {}
    BOT_CACHE = {}
    NEXTBOT_NAME_CACHE = {}
    
    print("Nextbot ESP: Stopped (All ESP removed)")
end

-- Экспорт функций
local NextbotESP = {
    Start = startESP,
    Stop = stopESP,
    IsRunning = function() return nextbotLoop ~= nil end
}

return NextbotESP
