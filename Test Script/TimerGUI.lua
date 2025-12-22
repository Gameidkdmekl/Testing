local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local function CreateTimerGUI()
    local MainInterface = Instance.new("ScreenGui")
    local TimerContainer = Instance.new("Frame")
    local TimerDisplay = Instance.new("Frame")
    local CountdownText = Instance.new("TextLabel")
    local StatusText = Instance.new("TextLabel")

    -- Основной экранный GUI
    MainInterface.Name = "MainInterface"
    MainInterface.Parent = PlayerGui
    MainInterface.ResetOnSpawn = false
    MainInterface.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    MainInterface.Enabled = true
    MainInterface.DisplayOrder = 2
    
    -- Контейнер по центру сверху
    TimerContainer.Name = "TimerContainer"
    TimerContainer.Parent = MainInterface
    TimerContainer.AnchorPoint = Vector2.new(0.5, 0)
    TimerContainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TimerContainer.BackgroundTransparency = 1.000
    TimerContainer.BorderColor3 = Color3.fromRGB(27, 42, 53)
    TimerContainer.Position = UDim2.new(0.5, 0, 0.02, 0) -- Чуть ниже верха
    TimerContainer.Size = UDim2.new(0.25, 0, 0.08, 0) -- Компактный размер
    TimerContainer.Visible = true

    -- Простое поле таймера
    TimerDisplay.Name = "TimerDisplay"
    TimerDisplay.Parent = TimerContainer
    TimerDisplay.AnchorPoint = Vector2.new(0.5, 0.5)
    TimerDisplay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    TimerDisplay.BackgroundTransparency = 0.800 -- Полупрозрачный черный фон
    TimerDisplay.BorderColor3 = Color3.fromRGB(27, 42, 53)
    TimerDisplay.BorderSizePixel = 0
    TimerDisplay.Position = UDim2.new(0.5, 0, 0.5, 0)
    TimerDisplay.Size = UDim2.new(1, 0, 1, 0)
    TimerDisplay.ZIndex = 10000

    -- Закругленные углы
    local RoundedCorners = Instance.new("UICorner")
    RoundedCorners.CornerRadius = UDim.new(0, 8)
    RoundedCorners.Parent = TimerDisplay

    -- Черная обводка
    local BorderOutline = Instance.new("UIStroke")
    BorderOutline.Parent = TimerDisplay
    BorderOutline.Thickness = 2
    BorderOutline.Color = Color3.fromRGB(0, 0, 0)
    BorderOutline.Transparency = 0.4

    -- Текст статуса (верхняя строка)
    StatusText.Name = "StatusText"
    StatusText.Parent = TimerDisplay
    StatusText.AnchorPoint = Vector2.new(0.5, 0)
    StatusText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    StatusText.BackgroundTransparency = 1.000
    StatusText.BorderColor3 = Color3.fromRGB(27, 42, 53)
    StatusText.Position = UDim2.new(0.5, 0, 0.05, 0) -- Верх таймера
    StatusText.Size = UDim2.new(0.95, 0, 0.4, 0) -- 40% высоты
    StatusText.ZIndex = 10002
    StatusText.Font = Enum.Font.GothamBold
    StatusText.Text = "ROUND ACTIVE"
    StatusText.TextColor3 = Color3.fromRGB(255, 255, 255) -- Белый текст
    StatusText.TextScaled = true
    StatusText.TextSize = 14.000
    StatusText.TextStrokeColor3 = Color3.fromRGB(0, 0, 0) -- Черная обводка текста
    StatusText.TextStrokeTransparency = 0.3
    StatusText.TextWrapped = true
    StatusText.TextXAlignment = Enum.TextXAlignment.Center
    StatusText.TextYAlignment = Enum.TextYAlignment.Top

    -- Основной таймер (нижняя строка)
    CountdownText.Name = "CountdownText"
    CountdownText.Parent = TimerDisplay
    CountdownText.AnchorPoint = Vector2.new(0.5, 1)
    CountdownText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    CountdownText.BackgroundTransparency = 1.000
    CountdownText.BorderColor3 = Color3.fromRGB(27, 42, 53)
    CountdownText.Position = UDim2.new(0.5, 0, 0.95, 0) -- Низ таймера
    CountdownText.Size = UDim2.new(0.95, 0, 0.5, 0) -- 50% высоты
    CountdownText.ZIndex = 10002
    CountdownText.Font = Enum.Font.GothamBold
    CountdownText.Text = "0:00"
    CountdownText.TextColor3 = Color3.fromRGB(255, 255, 255) -- Белый текст
    CountdownText.TextScaled = true
    CountdownText.TextSize = 20.000 -- Крупнее чем статус
    CountdownText.TextStrokeColor3 = Color3.fromRGB(0, 0, 0) -- Черная обводка текста
    CountdownText.TextStrokeTransparency = 0.3
    CountdownText.TextWrapped = true
    CountdownText.TextXAlignment = Enum.TextXAlignment.Center
    CountdownText.TextYAlignment = Enum.TextYAlignment.Bottom

    return CountdownText, StatusText, MainInterface, TimerContainer
end

local TimerLabel, StatusLabel, MainInterface, TimerContainer = CreateTimerGUI()

-- Инициализируем переменные
local statsFolder
local timerConnection
local folderAddedConnection

local function formatTime(seconds)
    if not seconds then return "0:00" end
    
    seconds = math.floor(tonumber(seconds) or 0)
    local minutes = math.floor(seconds / 60)
    local remainingSeconds = seconds % 60
    
    return string.format("%d:%02d", minutes, remainingSeconds)
end

local function updateTimerDisplay(timerValue, roundStarted)
    if not TimerLabel or not StatusLabel then return end
    
    -- Обновляем текст таймера
    TimerLabel.Text = formatTime(timerValue)
    
    -- Обновляем статус
    StatusLabel.Text = roundStarted and "ROUND ACTIVE" or "INTERMISSION"
    
    -- Меняем цвет текста в зависимости от времени
    if timerValue then
        if timerValue <= 10 then
            TimerLabel.TextColor3 = Color3.fromRGB(255, 150, 150) -- Светло-красный при 10 секундах
            StatusLabel.TextColor3 = Color3.fromRGB(255, 150, 150)
        elseif timerValue <= 30 then
            TimerLabel.TextColor3 = Color3.fromRGB(255, 255, 150) -- Светло-желтый при 30 секундах
            StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 150)
        else
            TimerLabel.TextColor3 = Color3.fromRGB(255, 255, 255) -- Белый при >30 секундах
            StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        end
    else
        TimerLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    end
end

local function setupTimerConnection()
    if timerConnection then
        timerConnection:Disconnect()
        timerConnection = nil
    end
    
    if statsFolder then
        timerConnection = statsFolder:GetAttributeChangedSignal("Timer"):Connect(function()
            local timerValue = statsFolder:GetAttribute("Timer")
            local roundStarted = statsFolder:GetAttribute("RoundStarted")
            
            updateTimerDisplay(timerValue, roundStarted)
        end)
        
        -- Устанавливаем начальные значения
        local initialTimer = statsFolder:GetAttribute("Timer")
        local initialRoundStarted = statsFolder:GetAttribute("RoundStarted")
        
        updateTimerDisplay(initialTimer, initialRoundStarted)
    else
        -- Если папки нет, показываем стандартные значения
        TimerLabel.Text = "0:00"
        StatusLabel.Text = "WAITING"
        TimerLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    end
end

-- Ищем папку Stats
local function findStatsFolder()
    local gameFolder = workspace:FindFirstChild("Game")
    if gameFolder then
        statsFolder = gameFolder:FindFirstChild("Stats")
        if statsFolder then
            setupTimerConnection()
        end
    end
end

-- Инициализация при запуске
task.spawn(function()
    -- Ждем загрузки игры
    task.wait(2)
    
    findStatsFolder()
    
    -- Слушаем создание папки Game
    if not statsFolder then
        folderAddedConnection = workspace.ChildAdded:Connect(function(child)
            if child.Name == "Game" then
                task.wait(1)
                findStatsFolder()
            end
        end)
    end
end)

-- Очистка при уничтожении
local function cleanupTimer()
    if timerConnection then
        timerConnection:Disconnect()
        timerConnection = nil
    end
    if folderAddedConnection then
        folderAddedConnection:Disconnect()
        folderAddedConnection = nil
    end
end

-- Очищаем при выходе игрока
LocalPlayer.CharacterRemoving:Connect(cleanupTimer)
