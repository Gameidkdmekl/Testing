-- NextbotESP.lua - Оптимизированная версия (оригинальный стиль сохранен)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- Оригинальные переменные ESP
local NextbotBillboards = {}
local nextbotLoop = nil

-- Оптимизационные переменные
local BOT_CACHE = {}
local LAST_CACHE_UPDATE = 0
local CACHE_UPDATE_INTERVAL = 0.7  -- Обновление кэша раз в 0.7 секунд
local VISIBILITY_DISTANCE = 1500000    -- Максимальная дистанция видимости ESP
local MAX_BOTS_PER_FRAME = 4       -- Максимум ботов обрабатываем за кадр
local ESP_UPDATE_RATE = 0.12       -- Частота обновления ESP
local LAST_ESP_UPDATE = 0

-- Кэш для быстрой проверки nextbot'ов
local NEXTBOT_NAME_CACHE = {}
local NEXTBOT_PATTERNS = {
    "nextbot", "scp", "monster", "creep", 
    "enemy", "zombie", "ghost", "demon"
}

-- Получаем имена nextbot'ов из ReplicatedStorage (оригинальная функция)
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

local NEXTBOT_NAMES = getNextbotNames()

-- Оптимизированная функция проверки nextbot (оригинальная логика + кэширование)
local function isNextbotModel(model)
    if not model or not model.Name then return false end
    
    local nameLower = model.Name:lower()
    
    -- Проверка кэша
    if NEXTBOT_NAME_CACHE[nameLower] ~= nil then
        return NEXTBOT_NAME_CACHE[nameLower]
    end
    
    -- Проверка по известным именам из ReplicatedStorage
    for _, name in ipairs(NEXTBOT_NAMES) do
        if nameLower == name:lower() then
            NEXTBOT_NAME_CACHE[nameLower] = true
            return true
        end
    end
    
    -- Проверка по ключевым словам (оригинальная логика)
    for _, pattern in ipairs(NEXTBOT_PATTERNS) do
        if nameLower:find(pattern) then
            NEXTBOT_NAME_CACHE[nameLower] = true
            return true
        end
    end
    
    NEXTBOT_NAME_CACHE[nameLower] = false
    return false
end

-- Функция получения расстояния (оригинальная)
local function getDistanceFromPlayer(targetPosition)
    if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then 
        return 0 
    end
    local distance = (targetPosition - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
    return math.floor(distance)
end

-- Кэширование ботов (оптимизированный поиск)
local function updateBotCache()
    local currentTime = tick()
    if currentTime - LAST_CACHE_UPDATE < CACHE_UPDATE_INTERVAL then
        return
    end
    
    LAST_CACHE_UPDATE = currentTime
    
    -- Быстрая очистка удаленных ботов
    for bot, data in pairs(BOT_CACHE) do
        if not bot.Parent or not data.hrp or not data.hrp.Parent then
            BOT_CACHE[bot] = nil
            if NextbotBillboards[bot] then
                NextbotBillboards[bot]:Destroy()
                NextbotBillboards[bot] = nil
            end
        end
    end
    
    -- Поиск в папке Players (Game/Players)
    local gameFolder = workspace:FindFirstChild("Game")
    if gameFolder then
        local playersFolder = gameFolder:FindFirstChild("Players")
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
    end
    
    -- Поиск в папке NPCs
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

-- Создание Billboard ESP (оригинальный стиль - просто текст)
local function createBillboardESP(bot, hrp)
    if NextbotBillboards[bot] and NextbotBillboards[bot].Parent then
        return NextbotBillboards[bot]
    end
    
    -- Создаем BillboardGui (просто текст, без фона)
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "NextbotESP"
    billboard.AlwaysOnTop = true
    billboard.Size = UDim2.new(0, 200, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.Adornee = hrp
    billboard.MaxDistance = VISIBILITY_DISTANCE
    billboard.Parent = hrp
    
    -- Текст (просто текст, без фона)
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
    textLabel.Text = bot.Name .. " [" .. getDistanceFromPlayer(hrp.Position) .. "m]"
    textLabel.Font = Enum.Font.GothamBold
    textLabel.TextSize = 16
    textLabel.TextStrokeTransparency = 0.7
    textLabel.Parent = billboard
    
    NextbotBillboards[bot] = billboard
    return billboard
end

-- Обновление ESP с оптимизацией (батчинг и ограничения)
local function updateESP()
    local currentTime = tick()
    
    -- Ограничиваем частоту обновления ESP
    if currentTime - LAST_ESP_UPDATE < ESP_UPDATE_RATE then
        return
    end
    
    LAST_ESP_UPDATE = currentTime
    
    -- Обновляем кэш ботов (только если прошло достаточно времени)
    updateBotCache()
    
    local playerChar = LocalPlayer.Character
    local playerHRP = playerChar and playerChar:FindFirstChild("HumanoidRootPart")
    
    if not playerHRP then return end
    
    -- Собираем ботов для обработки
    local botsToProcess = {}
    local botCount = 0
    
    for bot, data in pairs(BOT_CACHE) do
        if data.hrp and data.hrp.Parent then
            botCount = botCount + 1
            if botCount <= 20 then -- Ограничиваем общее количество
                botsToProcess[bot] = data.hrp
            end
        end
    end
    
    -- Обрабатываем только часть ботов за кадр (батчинг)
    local processed = 0
    for bot, hrp in pairs(botsToProcess) do
        if processed >= MAX_BOTS_PER_FRAME then
            break
        end
        
        processed = processed + 1
        
        -- Проверяем дистанцию
        local distance = (hrp.Position - playerHRP.Position).Magnitude
        local shouldShow = distance <= VISIBILITY_DISTANCE
        
        if shouldShow then
            -- Создаем или обновляем ESP
            local billboard = createBillboardESP(bot, hrp)
            if billboard and billboard.Parent then
                billboard.Enabled = true
                billboard.Adornee = hrp
                
                -- Обновляем текст
                local textLabel = billboard:FindFirstChild("TextLabel")
                if textLabel then
                    textLabel.Text = bot.Name .. " [" .. math.floor(distance) .. "m]"
                end
            end
        else
            -- Скрываем ESP для далеких ботов
            if NextbotBillboards[bot] then
                NextbotBillboards[bot].Enabled = false
            end
        end
    end
    
    -- Быстрая очистка ESP для удаленных ботов
    for bot, billboard in pairs(NextbotBillboards) do
        if not BOT_CACHE[bot] then
            pcall(function()
                billboard:Destroy()
            end)
            NextbotBillboards[bot] = nil
        end
    end
end

-- Основной оптимизированный цикл
local function startESP()
    if nextbotLoop then return end
    
    -- Очищаем кэши при старте
    BOT_CACHE = {}
    NEXTBOT_NAME_CACHE = {}
    NextbotBillboards = {}
    
    -- Динамическая настройка частоты обновления
    local lastFPS = 0
    local frameCount = 0
    local lastTime = tick()
    
    -- Запускаем оптимизированный цикл
    nextbotLoop = RunService.RenderStepped:Connect(function()
        frameCount = frameCount + 1
        local currentTime = tick()
        
        -- Проверяем FPS каждые 2 секунды
        if currentTime - lastTime >= 2 then
            local fps = frameCount / (currentTime - lastTime)
            lastFPS = math.floor(fps)
            frameCount = 0
            lastTime = currentTime
            
            -- Автоматическая настройка частоты обновления
            if lastFPS < 25 then
                ESP_UPDATE_RATE = 0.2  -- 5 FPS ESP
                MAX_BOTS_PER_FRAME = 2
                CACHE_UPDATE_INTERVAL = 1.0
            elseif lastFPS > 60 then
                ESP_UPDATE_RATE = 0.08  -- ~12 FPS ESP
                MAX_BOTS_PER_FRAME = 6
                CACHE_UPDATE_INTERVAL = 0.5
            else
                ESP_UPDATE_RATE = 0.12  -- ~8 FPS ESP
                MAX_BOTS_PER_FRAME = 4
                CACHE_UPDATE_INTERVAL = 0.7
            end
        end
        
        -- Обновляем ESP
        pcall(updateESP)
    end)
    
    print("Nextbot ESP: Started (Optimized, Original Style)")
end

-- Остановка ESP
local function stopESP()
    if nextbotLoop then
        nextbotLoop:Disconnect()
        nextbotLoop = nil
    end
    
    -- Удаляем все ESP
    for bot, billboard in pairs(NextbotBillboards) do
        pcall(function()
            billboard:Destroy()
        end)
    end
    NextbotBillboards = {}
    BOT_CACHE = {}
    
    print("Nextbot ESP: Stopped")
end

-- Публичные функции
local NextbotESP = {}

function NextbotESP.Start()
    startESP()
end

function NextbotESP.Stop()
    stopESP()
end

function NextbotESP.IsRunning()
    return nextbotLoop ~= nil
end

-- Экспорт
return NextbotESP
