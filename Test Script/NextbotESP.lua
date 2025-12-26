-- NextbotESP.lua
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Глобальные переменные
_G.NextbotESPRunning = true
local NextbotESPInstances = {}

-- Функция для проверки nextbot
local function isNextbotModel(model)
    if not model or not model.Name then return false end
    
    local nextBotNames = {}
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    if ReplicatedStorage:FindFirstChild("NPCs") then
        for _, npc in ipairs(ReplicatedStorage.NPCs:GetChildren()) do
            table.insert(nextBotNames, npc.Name)
        end
    end
    
    for _, name in ipairs(nextBotNames) do
        if model.Name == name then return true end
    end
    
    return model.Name:lower():find("nextbot") or 
           model.Name:lower():find("scp") or 
           model.Name:lower():find("monster") or
           model.Name:lower():find("creep") or
           model.Name:lower():find("enemy") or
           model.Name:lower():find("zombie") or
           model.Name:lower():find("ghost") or
           model.Name:lower():find("demon")
end

-- Функция остановки
_G.StopNextbotESP = function()
    _G.NextbotESPRunning = false
    
    -- Удаляем все ESP
    for _, esp in pairs(NextbotESPInstances) do
        if esp and esp.Parent then
            esp:Destroy()
        end
    end
    NextbotESPInstances = {}
    
    print("[Nextbot ESP] Stopped")
end

-- Функция обновления
_G.UpdateNextbotESP = function()
    if not _G.NextbotESPRunning then return end
    
    local nextbots = {}
    
    -- Поиск nextbots в Game.Players
    local playersFolder = workspace:FindFirstChild("Game") and workspace.Game:FindFirstChild("Players")
    if playersFolder then
        for _, model in ipairs(playersFolder:GetChildren()) do
            if model:IsA("Model") and isNextbotModel(model) then
                local hrp = model:FindFirstChild("HumanoidRootPart") or model:FindFirstChild("Head")
                if hrp then
                    nextbots[model] = hrp
                end
            end
        end
    end
    
    -- Поиск nextbots в NPCs
    local npcsFolder = workspace:FindFirstChild("NPCs")
    if npcsFolder then
        for _, model in ipairs(npcsFolder:GetChildren()) do
            if model:IsA("Model") and isNextbotModel(model) then
                local hrp = model:FindFirstChild("HumanoidRootPart") or model:FindFirstChild("Head")
                if hrp then
                    nextbots[model] = hrp
                end
            end
        end
    end
    
    -- Удаляем старые ESP
    for model, esp in pairs(NextbotESPInstances) do
        if not nextbots[model] or not model.Parent then
            if esp then
                esp:Destroy()
            end
            NextbotESPInstances[model] = nil
        end
    end
    
    -- Создаем новые ESP
    for model, hrp in pairs(nextbots) do
        if not NextbotESPInstances[model] then
            -- Создаем BillboardGui
            local billboard = Instance.new("BillboardGui")
            billboard.Name = "ExternalNextbotESP"
            billboard.Adornee = hrp
            billboard.Size = UDim2.new(0, 150, 0, 40)
            billboard.StudsOffset = Vector3.new(0, 3, 0)
            billboard.AlwaysOnTop = true
            billboard.MaxDistance = 1000
            billboard.Parent = hrp
            
            local textLabel = Instance.new("TextLabel")
            textLabel.Size = UDim2.new(1, 0, 1, 0)
            textLabel.BackgroundTransparency = 1
            textLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
            textLabel.TextSize = 16
            textLabel.Font = Enum.Font.GothamBold
            textLabel.Parent = billboard
            
            local stroke = Instance.new("UIStroke")
            stroke.Color = Color3.new(0, 0, 0)
            stroke.Thickness = 2
            stroke.Parent = textLabel
            
            NextbotESPInstances[model] = billboard
        end
        
        -- Обновляем текст
        local esp = NextbotESPInstances[model]
        if esp and esp.Parent and esp:FindFirstChildOfClass("TextLabel") then
            local textLabel = esp:FindFirstChildOfClass("TextLabel")
            local distance = 0
            
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                distance = (hrp.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
            end
            
            textLabel.Text = string.format("%s | %d m", model.Name, math.floor(distance))
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
end)

print("[Nextbot ESP] Loaded")
return _G.StopNextbotESP
