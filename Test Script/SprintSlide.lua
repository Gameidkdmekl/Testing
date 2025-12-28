-- SprintSlide.lua
-- Внешний модуль для бесконечного скольжения

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local SprintSlide = {}
SprintSlide.Enabled = false
SprintSlide.FrictionValue = -8

-- Внутренние переменные
local movementTables = {}
local heartbeatConnection = nil
local characterConnection = nil
local playerModelPath = nil

-- Требуемые поля
local requiredKeys = {
    "Friction","AirStrafeAcceleration","JumpHeight","RunDeaccel",
    "JumpSpeedMultiplier","JumpCap","SprintCap","WalkSpeedMultiplier",
    "BhopEnabled","Speed","AirAcceleration","RunAccel","SprintAcceleration"
}

-- Проверка таблицы
local function hasRequiredFields(tbl)
    if typeof(tbl) ~= "table" then return false end
    for _, key in ipairs(requiredKeys) do
        if rawget(tbl, key) == nil then return false end
    end
    return true
end

-- Поиск таблиц
local function findMovementTables()
    movementTables = {}
    for _, obj in ipairs(getgc(true)) do
        if hasRequiredFields(obj) then
            table.insert(movementTables, {obj = obj, original = obj.Friction})
        end
    end
    return #movementTables > 0
end

-- Установка трения
local function setSlideFriction(value)
    local appliedCount = 0
    for _, tbl in ipairs(movementTables) do
        pcall(function()
            tbl.obj.Friction = value
            appliedCount = appliedCount + 1
        end)
    end
    if appliedCount == 0 then
        for _, obj in ipairs(getgc(true)) do
            if hasRequiredFields(obj) then
                pcall(function()
                    obj.Friction = value
                end)
            end
        end
    end
end

-- Получение модели игрока
local function updatePlayerModel()
    if playerModelPath and playerModelPath.Parent then
        return playerModelPath
    end
    
    local gameFolder = workspace:FindFirstChild("Game")
    if not gameFolder then 
        playerModelPath = nil
        return nil 
    end
    
    local playersFolder = gameFolder:FindFirstChild("Players")
    if not playersFolder then 
        playerModelPath = nil
        return nil 
    end
    
    playerModelPath = playersFolder:FindFirstChild(player.Name)
    return playerModelPath
end

-- Основная логика
local function infiniteSlideHeartbeatFunc()
    if not SprintSlide.Enabled then return end
    
    local playerModel = updatePlayerModel()
    if not playerModel then return end
    
    local state = playerModel:GetAttribute("State")
    
    -- КРИТИЧЕСКАЯ ЧАСТЬ
    if state == "Slide" then
        pcall(function()
            playerModel:SetAttribute("State", "EmotingSlide")
        end)
        setSlideFriction(SprintSlide.FrictionValue)
    elseif state == "EmotingSlide" then
        setSlideFriction(SprintSlide.FrictionValue)
    else
        setSlideFriction(5)
    end
end

-- Обработка нового персонажа
local function onCharacterAddedSlide(character)
    if not SprintSlide.Enabled then return end
    
    playerModelPath = nil
    
    for i = 1, 5 do
        task.wait(0.5)
        if updatePlayerModel() then
            break
        end
    end
    
    task.wait(0.5)
    findMovementTables()
end

-- Включение/выключение
function SprintSlide:SetEnabled(enabled)
    if self.Enabled == enabled then return end
    self.Enabled = enabled
    
    if enabled then
        -- Инициализация
        findMovementTables()
        updatePlayerModel()
        
        -- Подключение обработчиков
        if not characterConnection then
            characterConnection = player.CharacterAdded:Connect(onCharacterAddedSlide)
        end
        
        -- Запуск heartbeat
        if heartbeatConnection then
            heartbeatConnection:Disconnect()
        end
        heartbeatConnection = RunService.Heartbeat:Connect(infiniteSlideHeartbeatFunc)
        
        -- Применяем к текущему персонажу
        if player.Character then
            task.spawn(function()
                onCharacterAddedSlide(player.Character)
            end)
        end
        
    else
        -- Отключение
        if heartbeatConnection then
            heartbeatConnection:Disconnect()
            heartbeatConnection = nil
        end
        
        if characterConnection then
            characterConnection:Disconnect()
            characterConnection = nil
        end
        
        -- Восстановление трения
        setSlideFriction(5)
        movementTables = {}
        playerModelPath = nil
    end
end

-- Установка значения трения
function SprintSlide:SetFriction(value)
    self.FrictionValue = value
    if self.Enabled then
        setSlideFriction(value)
    end
end

-- Очистка
function SprintSlide:Destroy()
    self:SetEnabled(false)
    movementTables = nil
    playerModelPath = nil
end

return SprintSlide
