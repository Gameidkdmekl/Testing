-- SprintSlide.lua
-- Внешний модуль для функции Sprint Slide

local SprintSlide = {}

-- Локальные переменные
local infiniteSlideEnabled = false
local slideFrictionValue = -8
local movementTables = {}
local infiniteSlideHeartbeat = nil
local infiniteSlideCharacterConn = nil
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Создание градиентной кнопки
function SprintSlide.createGradientButton(parent, position, size, text)
    local button = Instance.new("Frame")
    button.Name = "GradientBtn"
    button.BackgroundTransparency = 0.7
    button.Size = size
    button.Position = position
    button.Draggable = true
    button.Active = true
    button.Selectable = true
    button.Parent = parent

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = button

    -- Анимированный градиент
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 255)),   -- Голубой
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 100, 255)), -- Пурпурный
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 255, 255))    -- Голубой
    }
    gradient.Rotation = 0
    gradient.Parent = button

    -- Анимация вращения градиента
    local gradientAnimation
    gradientAnimation = RunService.RenderStepped:Connect(function(delta)
        gradient.Rotation = (gradient.Rotation + 90 * delta) % 360
    end)

    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(0, 85, 255)
    stroke.Thickness = 2
    stroke.Parent = button

    local label = Instance.new("TextLabel")
    label.Text = text
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextSize = 16
    label.Font = Enum.Font.GothamBold
    label.Parent = button

    local clicker = Instance.new("TextButton")
    clicker.Size = UDim2.new(1, 0, 1, 0)
    clicker.BackgroundTransparency = 1
    clicker.Text = ""
    clicker.ZIndex = 5
    clicker.Active = false
    clicker.Selectable = false
    clicker.Parent = button

    -- Очистка анимации при уничтожении кнопки
    button.Destroying:Connect(function()
        if gradientAnimation then
            gradientAnimation:Disconnect()
        end
    end)

    -- Эффекты при наведении
    clicker.MouseEnter:Connect(function()
        stroke.Color = Color3.fromRGB(0, 170, 255)
    end)

    clicker.MouseLeave:Connect(function()
        stroke.Color = Color3.fromRGB(0, 85, 255)
    end)

    return button, clicker, stroke
end

-- Поиск таблиц движения
function SprintSlide.findMovementTables()
    movementTables = {}
    local requiredKeys = {
        "Friction","AirStrafeAcceleration","JumpHeight","RunDeaccel",
        "JumpSpeedMultiplier","JumpCap","SprintCap","WalkSpeedMultiplier",
        "BhopEnabled","Speed","AirAcceleration","RunAccel","SprintAcceleration"
    }

    local function hasRequiredFields(tbl)
        if typeof(tbl) ~= "table" then return false end
        for _, key in ipairs(requiredKeys) do
            if rawget(tbl, key) == nil then return false end
        end
        return true
    end

    for _, obj in ipairs(getgc(true)) do
        if hasRequiredFields(obj) then
            table.insert(movementTables, obj)
        end
    end
    return #movementTables > 0
end

-- Установка трения слайда
function SprintSlide.setSlideFriction(value)
    local appliedCount = 0
    for _, tbl in ipairs(movementTables) do
        pcall(function()
            tbl.Friction = value
            appliedCount = appliedCount + 1
        end)
    end
    if appliedCount == 0 then
        for _, obj in ipairs(getgc(true)) do
            local requiredKeys = {
                "Friction","AirStrafeAcceleration","JumpHeight","RunDeaccel",
                "JumpSpeedMultiplier","JumpCap","SprintCap","WalkSpeedMultiplier",
                "BhopEnabled","Speed","AirAcceleration","RunAccel","SprintAcceleration"
            }
            local function hasRequiredFields(tbl)
                if typeof(tbl) ~= "table" then return false end
                for _, key in ipairs(requiredKeys) do
                    if rawget(tbl, key) == nil then return false end
                end
                return true
            end
            if hasRequiredFields(obj) then
                pcall(function()
                    obj.Friction = value
                end)
            end
        end
    end
end

-- Обновление модели игрока
function SprintSlide.updatePlayerModel()
    local gameFolder = workspace:FindFirstChild("Game")
    if not gameFolder then return false end
    
    local playersFolder = gameFolder:FindFirstChild("Players")
    if not playersFolder then return false end
    
    local playerModel = playersFolder:FindFirstChild(player.Name)
    return playerModel
end

-- Основной heartbeat функции
function SprintSlide.infiniteSlideHeartbeatFunc()
    if not infiniteSlideEnabled then return end
    
    local playerModel = SprintSlide.updatePlayerModel()
    if not playerModel then return end
    
    local state = playerModel:GetAttribute("State")
    
    if state == "Slide" then
        pcall(function()
            playerModel:SetAttribute("State", "EmotingSlide")
        end)
    elseif state == "EmotingSlide" then
        SprintSlide.setSlideFriction(slideFrictionValue)
    else
        SprintSlide.setSlideFriction(5)
    end
end

-- При добавлении персонажа
function SprintSlide.onCharacterAddedSlide(character)
    if not infiniteSlideEnabled then return end
    
    for i = 1, 5 do
        task.wait(0.5)
        if SprintSlide.updatePlayerModel() then
            break
        end
    end
    
    task.wait(0.5)
    SprintSlide.findMovementTables()
end

-- Включение/выключение Sprint Slide
function SprintSlide.setInfiniteSlide(enabled)
    infiniteSlideEnabled = enabled

    if enabled then
        SprintSlide.findMovementTables()
        SprintSlide.updatePlayerModel()
        
        if not infiniteSlideCharacterConn then
            infiniteSlideCharacterConn = player.CharacterAdded:Connect(SprintSlide.onCharacterAddedSlide)
        end
        
        if player.Character then
            task.spawn(function()
                SprintSlide.onCharacterAddedSlide(player.Character)
            end)
        end
        
        if infiniteSlideHeartbeat then infiniteSlideHeartbeat:Disconnect() end
        infiniteSlideHeartbeat = RunService.Heartbeat:Connect(SprintSlide.infiniteSlideHeartbeatFunc)
        
    else
        if infiniteSlideHeartbeat then
            infiniteSlideHeartbeat:Disconnect()
            infiniteSlideHeartbeat = nil
        end
        
        if infiniteSlideCharacterConn then
            infiniteSlideCharacterConn:Disconnect()
            infiniteSlideCharacterConn = nil
        end
        
        SprintSlide.setSlideFriction(5)
        movementTables = {}
    end
end

-- Получение текущего состояния
function SprintSlide.getState()
    return infiniteSlideEnabled
end

-- Установка значения трения
function SprintSlide.setFriction(value)
    slideFrictionValue = value
    if infiniteSlideEnabled then
        SprintSlide.setSlideFriction(slideFrictionValue)
    end
end

-- Получение значения трения
function SprintSlide.getFriction()
    return slideFrictionValue
end

-- Переключение состояния
function SprintSlide.toggle()
    SprintSlide.setInfiniteSlide(not infiniteSlideEnabled)
    return infiniteSlideEnabled
end

return SprintSlide
