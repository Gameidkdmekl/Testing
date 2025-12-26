-- NextbotESP.lua
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TweenService = game:GetService("TweenService")

-- Глобальные переменные
_G.NextbotESPRunning = true
local NextbotESPInstances = {}
local ESPConfig = {
    MaxDistance = 1500,
    MinTextSize = 12,
    MaxTextSize = 20,
    FadeDistance = 100,
    UpdateRate = 0.1
}

-- Кэш для имен Nextbot
local nextBotNameCache = {}
local lastCacheUpdate = 0
local CACHE_UPDATE_INTERVAL = 5

-- Функция для обновления кэша nextbot имен
local function updateNextbotCache()
    if tick() - lastCacheUpdate < CACHE_UPDATE_INTERVAL then
        return
    end
    
    nextBotNameCache = {}
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    
    -- Проверяем разные возможные места хранения NPC
    local possibleFolders = {
        ReplicatedStorage:FindFirstChild("NPCs"),
        workspace:FindFirstChild("NPCs"),
        ReplicatedStorage:FindFirstChild("Nextbots"),
        workspace:FindFirstChild("Nextbots"),
        ReplicatedStorage:FindFirstChild("Enemies"),
        workspace:FindFirstChild("Enemies")
    }
    
    for _, folder in ipairs(possibleFolders) do
        if folder then
            for _, npc in ipairs(folder:GetChildren()) do
                nextBotNameCache[npc.Name] = true
                -- Также добавляем варианты без номеров (например "Nextbot" вместо "Nextbot1")
                local baseName = npc.Name:gsub("%d+$", "")
                if baseName ~= npc.Name then
                    nextBotNameCache[baseName] = true
                end
            end
        end
    end
    
    lastCacheUpdate = tick()
end

-- Функция для проверки nextbot (улучшенная)
local function isNextbotModel(model)
    if not model or not model.Name then return false end
    
    updateNextbotCache()
    
    local modelName = model.Name
    local lowerName = modelName:lower()
    
    -- Проверка по кэшированным именам
    if nextBotNameCache[modelName] or nextBotNameCache[modelName:gsub("%d+$", "")] then
        return true
    end
    
    -- Ключевые слова для поиска
    local keywords = {
        "nextbot", "scp", "monster", "creep", "enemy", 
        "zombie", "ghost", "demon", "entity", "horror",
        "slender", "creature", "beast", "fiend", "stalker",
        "killer", "murderer", "nightmare", "abomination"
    }
    
    for _, keyword in ipairs(keywords) do
        if lowerName:find(keyword) then
            return true
        end
    end
    
    -- Проверка по тегам или атрибутам
    if model:GetAttribute("IsNextbot") or model:GetAttribute("IsNPC") or model:GetAttribute("IsEnemy") then
        return true
    end
    
    -- Проверка по наличию определенных компонентов
    local hasAI = model:FindFirstChildWhichIsA("AIController") or 
                  model:FindFirstChild("AI") or 
                  model:FindFirstChild("NextbotAI") or
                  model:FindFirstChild("NPCController")
    
    if hasAI then
        return true
    end
    
    return false
end

-- Получение цвета по имени модели
local function getColorForNextbot(modelName)
    local lowerName = modelName:lower()
    
    -- Цвета для разных типов Nextbot
    if lowerName:find("scp") then
        return Color3.fromRGB(255, 0, 0) -- Красный для SCP
    elseif lowerName:find("ghost") or lowerName:find("spirit") then
        return Color3.fromRGB(173, 216, 230) -- Голубой для призраков
    elseif lowerName:find("zombie") then
        return Color3.fromRGB(0, 255, 0) -- Зеленый для зомби
    elseif lowerName:find("demon") then
        return Color3.fromRGB(139, 0, 0) -- Темно-красный для демонов
    elseif lowerName:find("slender") then
        return Color3.fromRGB(0, 0, 0) -- Черный для Слендермена
    else
        -- Генерация цвета на основе имени (консистентный)
        local hash = 0
        for i = 1, #modelName do
            hash = (hash * 31 + string.byte(modelName, i)) % 360
        end
        return Color3.fromHSV(hash / 360, 0.8, 1)
    end
end

-- Функция остановки
_G.StopNextbotESP = function()
    _G.NextbotESPRunning = false
    
    -- Плавное исчезновение ESP
    for model, espData in pairs(NextbotESPInstances) do
        if espData and espData.Billboard then
            local tween = TweenService:Create(espData.Billboard, TweenInfo.new(0.3), {
                Size = UDim2.new(0, 0, 0, 0)
            })
            tween:Play()
            tween.Completed:Connect(function()
                if espData.Billboard then
                    espData.Billboard:Destroy()
                end
            end)
        end
    end
    
    NextbotESPInstances = {}
    
    print("[Nextbot ESP] Stopped")
end

-- Поиск nextbots во всех возможных местах
local function findAllNextbots()
    local nextbots = {}
    
    -- Список папок для поиска
    local searchFolders = {
        workspace,
        workspace:FindFirstChild("Game"),
        workspace:FindFirstChild("NPCs"),
        workspace:FindFirstChild("Nextbots"),
        workspace:FindFirstChild("Enemies"),
        workspace:FindFirstChild("Entities")
    }
    
    -- Добавляем Game.Players если существует
    if workspace:FindFirstChild("Game") and workspace.Game:FindFirstChild("Players") then
        table.insert(searchFolders, workspace.Game.Players)
    end
    
    for _, folder in ipairs(searchFolders) do
        if folder then
            local function searchInModel(model)
                if model:IsA("Model") and isNextbotModel(model) then
                    local hrp = model:FindFirstChild("HumanoidRootPart") or 
                               model:FindFirstChild("Head") or
                               model:FindFirstChild("Torso") or
                               model:FindFirstChild("UpperTorso")
                    
                    if hrp then
                        nextbots[model] = {
                            Part = hrp,
                            IsAlive = model:FindFirstChildOfClass("Humanoid") and 
                                     model:FindFirstChildOfClass("Humanoid").Health > 0
                        }
                    end
                end
                
                -- Рекурсивно проверяем дочерние объекты
                for _, child in ipairs(model:GetChildren()) do
                    searchInModel(child)
                end
            end
            
            searchInModel(folder)
        end
    end
    
    return nextbots
end

-- Функция обновления ESP с оптимизацией
local lastUpdate = 0
_G.UpdateNextbotESP = function()
    if not _G.NextbotESPRunning then return end
    
    -- Ограничение частоты обновления
    if tick() - lastUpdate < ESPConfig.UpdateRate then
        return
    end
    lastUpdate = tick()
    
    local nextbots = findAllNextbots()
    local localCharacter = LocalPlayer.Character
    local localHRP = localCharacter and localCharacter:FindFirstChild("HumanoidRootPart")
    
    -- Удаляем старые ESP
    for model, espData in pairs(NextbotESPInstances) do
        if not nextbots[model] or not model.Parent then
            if espData and espData.Billboard then
                espData.Billboard:Destroy()
            end
            NextbotESPInstances[model] = nil
        end
    end
    
    -- Создаем/обновляем ESP
    for model, data in pairs(nextbots) do
        local hrp = data.Part
        local distance = 0
        
        if localHRP then
            distance = (hrp.Position - localHRP.Position).Magnitude
        end
        
        -- Пропускаем если слишком далеко
        if distance > ESPConfig.MaxDistance then
            if NextbotESPInstances[model] then
                NextbotESPInstances[model].Billboard:Destroy()
                NextbotESPInstances[model] = nil
            end
            continue
        end
        
        if not NextbotESPInstances[model] then
            -- Создаем улучшенный BillboardGui
            local billboard = Instance.new("BillboardGui")
            billboard.Name = "EnhancedNextbotESP"
            billboard.Adornee = hrp
            billboard.Size = UDim2.new(0, 200, 0, 60)
            billboard.StudsOffset = Vector3.new(0, 4, 0)
            billboard.AlwaysOnTop = true
            billboard.MaxDistance = ESPConfig.MaxDistance
            billboard.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
            billboard.Parent = hrp
            
            -- Фон с закругленными углами
            local frame = Instance.new("Frame")
            frame.Size = UDim2.new(1, 0, 1, 0)
            frame.BackgroundColor3 = Color3.new(0, 0, 0)
            frame.BackgroundTransparency = 0.5
            frame.BorderSizePixel = 0
            
            local uicorner = Instance.new("UICorner")
            uicorner.CornerRadius = UDim.new(0, 8)
            uicorner.Parent = frame
            
            -- Главный текст
            local textLabel = Instance.new("TextLabel")
            textLabel.Size = UDim2.new(1, -10, 0.6, 0)
            textLabel.Position = UDim2.new(0, 5, 0, 5)
            textLabel.BackgroundTransparency = 1
            textLabel.TextColor3 = getColorForNextbot(model.Name)
            textLabel.TextSize = 18
            textLabel.Font = Enum.Font.GothamBold
            textLabel.TextStrokeTransparency = 0.5
            textLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
            textLabel.TextXAlignment = Enum.TextXAlignment.Left
            
            -- Текст расстояния
            local distanceLabel = Instance.new("TextLabel")
            distanceLabel.Size = UDim2.new(1, -10, 0.4, 0)
            distanceLabel.Position = UDim2.new(0, 5, 0.6, 0)
            distanceLabel.BackgroundTransparency = 1
            distanceLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
            distanceLabel.TextSize = 14
            distanceLabel.Font = Enum.Font.Gotham
            distanceLabel.TextStrokeTransparency = 0.7
            distanceLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
            distanceLabel.TextXAlignment = Enum.TextXAlignment.Left
            
            -- Индикатор здоровья
            local healthBar = Instance.new("Frame")
            healthBar.Size = UDim2.new(0.8, 0, 0, 4)
            healthBar.Position = UDim2.new(0.1, 0, 0.95, 0)
            healthBar.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            healthBar.BorderSizePixel = 0
            
            local healthFill = Instance.new("Frame")
            healthFill.Size = UDim2.new(1, 0, 1, 0)
            healthFill.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
            healthFill.BorderSizePixel = 0
            
            local healthCorner = Instance.new("UICorner")
            healthCorner.CornerRadius = UDim.new(0, 2)
            healthCorner.Parent = healthFill
            
            healthFill.Parent = healthBar
            
            -- Сборка UI
            frame.Parent = billboard
            textLabel.Parent = frame
            distanceLabel.Parent = frame
            healthBar.Parent = frame
            
            NextbotESPInstances[model] = {
                Billboard = billboard,
                TextLabel = textLabel,
                DistanceLabel = distanceLabel,
                HealthBar = healthFill,
                HealthBarContainer = healthBar
            }
        end
        
        -- Обновляем ESP
        local espData = NextbotESPInstances[model]
        if espData and espData.Billboard and espData.Billboard.Parent then
            -- Динамический размер текста
            local textSize = ESPConfig.MaxTextSize - (distance / 50)
            textSize = math.clamp(textSize, ESPConfig.MinTextSize, ESPConfig.MaxTextSize)
            
            -- Прозрачность на расстоянии
            local transparency = math.clamp((distance - ESPConfig.MaxDistance + ESPConfig.FadeDistance) / ESPConfig.FadeDistance, 0, 0.7)
            
            -- Обновляем текст
            espData.TextLabel.TextSize = textSize
            espData.TextLabel.Text = model.Name
            espData.TextLabel.TextColor3 = getColorForNextbot(model.Name)
            
            espData.DistanceLabel.Text = string.format("Distance: %d m", math.floor(distance))
            espData.DistanceLabel.TextSize = textSize - 2
            
            -- Обновляем прозрачность
            espData.Billboard.Parent = hrp -- Переподключаем к новой части
            
            -- Обновляем здоровье
            local humanoid = model:FindFirstChildOfClass("Humanoid")
            if humanoid then
                local healthPercent = humanoid.Health / humanoid.MaxHealth
                espData.HealthBar.Size = UDim2.new(healthPercent, 0, 1, 0)
                
                -- Цвет здоровья
                if healthPercent > 0.5 then
                    espData.HealthBar.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
                elseif healthPercent > 0.25 then
                    espData.HealthBar.BackgroundColor3 = Color3.fromRGB(255, 255, 0)
                else
                    espData.HealthBar.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
                end
                
                -- Показываем/скрываем бар здоровья
                espData.HealthBarContainer.Visible = humanoid.Health < humanoid.MaxHealth
            else
                espData.HealthBarContainer.Visible = false
            end
            
            -- Обновляем позицию
            espData.Billboard.StudsOffset = Vector3.new(0, 3.5 + (model:GetExtentsSize().Y * 0.5), 0)
        end
    end
end

-- Автоматическое обновление
local connection = RunService.Heartbeat:Connect(function()
    if _G.NextbotESPRunning then
        _G.UpdateNextbotESP()
    end
end)

-- Очистка при выходе
LocalPlayer.CharacterRemoving:Connect(function()
    if connection then
        connection:Disconnect()
    end
    _G.StopNextbotESP()
end)

-- Команда для перезагрузки ESP
_G.RestartNextbotESP = function()
    _G.StopNextbotESP()
    _G.NextbotESPRunning = true
    print("[Nextbot ESP] Restarted")
end

print("[Nextbot ESP] Enhanced version loaded")
return _G.StopNextbotESP
