local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Глобальные переменные
local timerEnabled = false
local MainInterface, TimerContainer, TimerLabel, StatusLabel
local statsFolder, timerConnection, folderAddedConnection

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
    MainInterface.Enabled = false -- По умолчанию выключен
    MainInterface.DisplayOrder = 2
    
    -- Контейнер с позицией как у прошлого таймера
    TimerContainer.Name = "TimerContainer"
    TimerContainer.Parent = MainInterface
    TimerContainer.AnchorPoint = Vector2.new(0.5, 0)
    TimerContainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TimerContainer.BackgroundTransparency = 1.000
    TimerContainer.BorderColor3 = Color3.fromRGB(27, 42, 53)
    TimerContainer.Position = UDim2.new(0.5, 0, 0.04, 0)
    TimerContainer.Size = UDim2.new(0.25, 0, 0.1, 0)
    TimerContainer.Visible = true

    -- Поле таймера - сплошной черный фон
    TimerDisplay.Name = "TimerDisplay"
    TimerDisplay.Parent = TimerContainer
    TimerDisplay.AnchorPoint = Vector2.new(0.5, 0)
    TimerDisplay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    TimerDisplay.BackgroundTransparency = 0.000
    TimerDisplay.BorderColor3 = Color3.fromRGB(27, 42, 53)
    TimerDisplay.BorderSizePixel = 0
    TimerDisplay.Position = UDim2.new(0.5, 0, 0, 0)
    TimerDisplay.Size = UDim2.new(1, 0, 1, 0)
    TimerDisplay.ZIndex = 10000

    -- Закругленные углы
    local RoundedCorners = Instance.new("UICorner")
    RoundedCorners.CornerRadius = UDim.new(0, 4)
    RoundedCorners.Parent = TimerDisplay

    -- Черная обводка
    local BorderOutline = Instance.new("UIStroke")
    BorderOutline.Parent = TimerDisplay
    BorderOutline.Thickness = 1
    BorderOutline.Color = Color3.fromRGB(0, 0, 0)
    BorderOutline.Transparency = 0.8

    -- Текст статуса
    StatusText.Name = "StatusText"
    StatusText.Parent = TimerDisplay
    StatusText.AnchorPoint = Vector2.new(0.5, 0.5)
    StatusText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    StatusText.BackgroundTransparency = 1.000
    StatusText.BorderColor3 = Color3.fromRGB(27, 42, 53)
    StatusText.Position = UDim2.new(0.5, 0, 0.25, 0)
    StatusText.Size = UDim2.new(0.8, 0, 0.25, 0)
    StatusText.ZIndex = 10002
    StatusText.Font = Enum.Font.GothamBold
    StatusText.Text = "ROUND ACTIVE"
    StatusText.TextColor3 = Color3.fromRGB(165, 194, 255)
    StatusText.TextScaled = true
    StatusText.TextSize = 14.000
    StatusText.TextStrokeTransparency = 0.950
    StatusText.TextWrapped = true
    StatusText.TextXAlignment = Enum.TextXAlignment.Center

    -- Основной таймер
    CountdownText.Name = "CountdownText"
    CountdownText.Parent = TimerDisplay
    CountdownText.AnchorPoint = Vector2.new(0.5, 0.5)
    CountdownText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    CountdownText.BackgroundTransparency = 1.000
    CountdownText.BorderColor3 = Color3.fromRGB(27, 42, 53)
    CountdownText.Position = UDim2.new(0.5, 0, 0.65, 0)
    CountdownText.Size = UDim2.new(0.5, 0, 0.5, 0)
    CountdownText.ZIndex = 10002
    CountdownText.Font = Enum.Font.GothamBold
    CountdownText.Text = "0:00"
    CountdownText.TextColor3 = Color3.fromRGB(165, 194, 255)
    CountdownText.TextScaled = true
    CountdownText.TextSize = 14.000
    CountdownText.TextStrokeTransparency = 0.950
    CountdownText.TextWrapped = true
    CountdownText.TextXAlignment = Enum.TextXAlignment.Center

    return CountdownText, StatusText, MainInterface, TimerContainer
end

local function formatTime(seconds)
    if not seconds then return "0:00" end
    
    seconds = math.floor(tonumber(seconds) or 0)
    local minutes = math.floor(seconds / 60)
    local remainingSeconds = seconds % 60
    
    return string.format("%d:%02d", minutes, remainingSeconds)
end

local function updateTimerDisplay(timerValue, roundStarted)
    if not TimerLabel or not StatusLabel then return end
    
    TimerLabel.Text = formatTime(timerValue)
    
    StatusLabel.Text = roundStarted and "ROUND ACTIVE" or "INTERMISSION"
    
    if timerValue and timerValue <= 5 then
        TimerLabel.TextColor3 = Color3.fromRGB(215, 100, 100)
    else
        TimerLabel.TextColor3 = Color3.fromRGB(165, 194, 255)
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
        
        local initialTimer = statsFolder:GetAttribute("Timer")
        local initialRoundStarted = statsFolder:GetAttribute("RoundStarted")
        
        updateTimerDisplay(initialTimer, initialRoundStarted)
    end
end

local function findStatsFolder()
    local gameFolder = workspace:FindFirstChild("Game")
    if gameFolder then
        statsFolder = gameFolder:FindFirstChild("Stats")
        if statsFolder and timerEnabled then
            setupTimerConnection()
        end
    end
end

local function initTimer()
    if not TimerLabel then
        TimerLabel, StatusLabel, MainInterface, TimerContainer = CreateTimerGUI()
    end
end

-- Функция включения таймера (вызывается из TimerDisplayToggle)
local function startTimer()
    if timerEnabled then return end
    
    timerEnabled = true
    initTimer()
    
    if MainInterface then
        MainInterface.Enabled = true
    end
    
    findStatsFolder()
    
    if not statsFolder then
        folderAddedConnection = workspace.ChildAdded:Connect(function(child)
            if child.Name == "Game" then
                task.wait(1)
                findStatsFolder()
            end
        end)
    end
end

-- Функция выключения таймера
local function stopTimer()
    if not timerEnabled then return end
    
    timerEnabled = false
    
    if MainInterface then
        MainInterface.Enabled = false
    end
    
    if timerConnection then
        timerConnection:Disconnect()
        timerConnection = nil
    end
    
    if folderAddedConnection then
        folderAddedConnection:Disconnect()
        folderAddedConnection = nil
    end
end

-- Таймер НЕ запускается автоматически, только при включении через GUI
print("Timer GUI loaded. It will only start when Show Timer is enabled.")
