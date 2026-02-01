-- NextbotESP.lua - Оптимизированная версия

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- Настройки оптимизации
local BOT_CACHE = {}
local LAST_CACHE_UPDATE = 0
local CACHE_UPDATE_INTERVAL = 1.0  -- Обновляем кэш раз в секунду
local MAX_VISIBLE_BOTS = 8         -- Максимум ESP на экране
local VISIBILITY_DISTANCE = 250    -- Дистанция видимости
local UPDATE_BATCH_SIZE = 2        -- Ботов за кадр
local ESP_UPDATE_RATE = 0.15       -- Частота обновления (сек)

-- Кэш для проверки ботов
local NEXTBOT_PATTERNS = {
    "nextbot", "scp", "monster", "creep", 
    "enemy", "zombie", "ghost", "demon", "bot"
}
local NEXTBOT_NAME_CACHE = {}

-- ESP элементы
local ESP_CACHE = {}
local ACTIVE_BILLBOARDS = {}

-- Получаем имена nextbot'ов из игры
local function getNextbotNames()
    local names = {}
    local success, result = pcall(function()
        local npcs = game:GetService("ReplicatedStorage"):FindFirstChild("NPCs")
        if npcs then
            for _, npc in ipairs(npcs:GetChildren()) do
                table.insert(names, npc.Name)
            end
        end
    end)
    return names
end

local NEXTBOT_NAMES = getNextbotNames()

-- Оптимизированная проверка
local function isNextbotModel(model)
    if not model or not model.Name then return false end
    
    local nameLower = model.Name:lower()
    
    -- Проверяем кэш
    if NEXTBOT_NAME_CACHE[nameLower] ~= nil then
        return NEXTBOT_NAME_CACHE[nameLower]
    end
    
    -- Проверка по известным именам
    for _, name in ipairs(NEXTBOT_NAMES) do
        if nameLower == name:lower() then
            NEXTBOT_NAME_CACHE[nameLower] = true
            return true
        end
    end
    
    -- Проверка по паттернам
    for _, pattern in ipairs(NEXTBOT_PATTERNS) do
        if nameLower:find(pattern) then
            NEXTBOT_NAME_CACHE[nameLower] = true
            return true
        end
    end
    
    NEXTBOT_NAME_CACHE[nameLower] = false
    return false
end

-- Кэширование ботов
local function updateBotCache()
    local currentTime = tick()
    if currentTime - LAST_CACHE_UPDATE < CACHE_UPDATE_INTERVAL then
        return
    end
    
    LAST_CACHE_UPDATE = currentTime
    
    -- Очищаем удаленных ботов
    for bot, data in pairs(BOT_CACHE) do
        if not bot.Parent or not data.hrp or not data.hrp.Parent then
            BOT_CACHE[bot] = nil
            if ACTIVE_BILLBOARDS[bot] then
                ACTIVE_BILLBOARDS[bot]:Destroy()
                ACTIVE_BILLBOARDS[bot] = nil
            end
        end
    end
    
    -- Поиск в Players
    local playersFolder = workspace:FindFirstChild("Game") 
    playersFolder = playersFolder and playersFolder:FindFirstChild("Players")
    
    if playersFolder then
        for _, model in pairs(playersFolder:GetChildren()) do
            if model:IsA("Model") and isNextbotModel(model) then
                local hrp = model:FindFirstChild("HumanoidRootPart")
                if hrp and not BOT_CACHE[model] then
                    BOT_CACHE[model] = {
                        hrp = hrp,
                        lastSeen = currentTime
                    }
                end
            end
        end
    end
    
    -- Поиск в NPCs
    local npcsFolder = workspace:FindFirstChild("NPCs")
    if npcsFolder then
        for _, model in pairs(npcsFolder:GetChildren()) do
            if model:IsA("Model") and isNextbotModel(model) then
                local hrp = model:FindFirstChild("HumanoidRootPart")
                if hrp and not BOT_CACHE[model] then
                    BOT_CACHE[model] = {
                        hrp = hrp,
                        lastSeen = currentTime
                    }
                end
            end
        end
    end
end

-- Создание оптимизированного ESP
local function createESP(bot)
    if ACTIVE_BILLBOARDS[bot] then
        return ACTIVE_BILLBOARDS[bot]
    end
    
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "NextbotESP"
    billboard.AlwaysOnTop = true
    billboard.Size = UDim2.new(0, 100, 0, 40)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.Adornee = BOT_CACHE[bot].hrp
    billboard.Parent = BOT_CACHE[bot].hrp
    
    -- Фон
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    frame.BackgroundTransparency = 0.4
    frame.BorderSizePixel = 0
    frame.Parent = billboard
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 4)
    corner.Parent = frame
    
    -- Текст имени
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, -10, 0.5, 0)
    nameLabel.Position = UDim2.new(0, 5, 0, 2)
    nameLabel.BackgroundTransparency = 1
    nameLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
    nameLabel.Text = bot.Name
    nameLabel.Font = Enum.Font.GothamMedium
    nameLabel.TextSize = 14
    nameLabel.Parent = frame
    
    -- Текст здоровья
    local healthLabel = Instance.new("TextLabel")
    healthLabel.Size = UDim2.new(1, -10, 0.5, 0)
    healthLabel.Position = UDim2.new(0, 5, 0.5, 0)
    healthLabel.BackgroundTransparency = 1
    healthLabel.TextColor3 = Color3.fromRGB(50, 255, 50)
    healthLabel.Font = Enum.Font.GothamMedium
    healthLabel.TextSize = 12
    healthLabel.Parent = frame
    
    ACTIVE_BILLBOARDS[bot] = billboard
    return billboard
end

-- Обновление ESP с батчингом
local function updateESP()
    local playerChar = LocalPlayer.Character
    local playerHRP = playerChar and playerChar:FindFirstChild("HumanoidRootPart")
    
    if not playerHRP then return end
    
    -- Обновляем кэш
    updateBotCache()
    
    local bots = {}
    for bot, data in pairs(BOT_CACHE) do
        if data.hrp and data.hrp.Parent then
            table.insert(bots, {bot = bot, data = data})
        end
    end
    
    local visibleCount = 0
    
    -- Ограничиваем количество обрабатываемых ботов за кадр
    for i = 1, math.min(#bots, UPDATE_BATCH_SIZE * 2) do
        local botData = bots[i]
        if not botData then break end
        
        local bot = botData.bot
        local hrp = botData.data.hrp
        
        -- Проверяем дистанцию
        local distance = (hrp.Position - playerHRP.Position).Magnitude
        local shouldShow = distance <= VISIBILITY_DISTANCE
        
        if shouldShow and visibleCount < MAX_VISIBLE_BOTS then
            visibleCount = visibleCount + 1
            
            -- Создаем/обновляем ESP
            local billboard = createESP(bot)
            if billboard and billboard.Parent then
                -- Обновляем позицию
                billboard.Adornee = hrp
                
                -- Обновляем здоровье
                local humanoid = bot:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    local healthFrame = billboard:FindFirstChild("Frame")
                    if healthFrame then
                        local healthLabel = healthFrame:FindFirstChild("TextLabel")
                        if healthLabel and healthLabel.Name == "HealthLabel" then
                            healthLabel.Text = "HP: " .. math.floor(humanoid.Health)
                        end
                    end
                end
                
                billboard.Enabled = true
            end
        else
            -- Скрываем ESP
            if ACTIVE_BILLBOARDS[bot] then
                ACTIVE_BILLBOARDS[bot].Enabled = false
            end
        end
    end
    
    -- Очистка невидимых ESP
    for bot, billboard in pairs(ACTIVE_BILLBOARDS) do
        if not BOT_CACHE[bot] then
            billboard:Destroy()
            ACTIVE_BILLBOARDS[bot] = nil
        end
    end
end

-- Основной цикл с контролем FPS
local connection = nil
local lastUpdate = 0

local function optimizedLoop()
    if tick() - lastUpdate < ESP_UPDATE_RATE then
        return
    end
    
    lastUpdate = tick()
    
    -- Динамическая регулировка частоты обновления
    local fps = 1 / (tick() - lastUpdate)
    if fps < 30 then
        ESP_UPDATE_RATE = 0.25  -- 4 FPS при низкой производительности
        UPDATE_BATCH_SIZE = 1
    elseif fps > 60 then
        ESP_UPDATE_RATE = 0.1   -- 10 FPS при высокой
        UPDATE_BATCH_SIZE = 3
    else
        ESP_UPDATE_RATE = 0.15  -- ~6.5 FPS нормально
        UPDATE_BATCH_SIZE = 2
    end
    
    -- Обновляем ESP
    pcall(updateESP)
end

-- Публичные функции для управления
local NextbotESP = {}

function NextbotESP.Start()
    if connection then 
        connection:Disconnect() 
    end
    
    -- Очищаем кэши
    BOT_CACHE = {}
    NEXTBOT_NAME_CACHE = {}
    
    -- Запускаем оптимизированный цикл
    connection = RunService.RenderStepped:Connect(optimizedLoop)
    
    print("NextbotESP: Started (Optimized Version)")
end

function NextbotESP.Stop()
    if connection then
        connection:Disconnect()
        connection = nil
    end
    
    -- Очищаем все ESP
    for bot, billboard in pairs(ACTIVE_BILLBOARDS) do
        billboard:Destroy()
    end
    ACTIVE_BILLBOARDS = {}
    BOT_CACHE = {}
    
    print("NextbotESP: Stopped")
end

function NextbotESP.IsRunning()
    return connection ~= nil
end

-- Экспорт
return NextbotESP
