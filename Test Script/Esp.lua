-- Esp.lua (внешний ESP файл)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local ESPEnabled = true
local ESPInstances = {}

-- Функция для отключения ESP
_G.DisableESP = function()
    ESPEnabled = false
    for _, esp in pairs(ESPInstances) do
        pcall(function()
            esp:Destroy()
        end)
    end
    ESPInstances = {}
end

local function createESP(player)
    if not ESPEnabled or player == LocalPlayer then return end
    
    local character = player.Character or player.CharacterAdded:Wait()
    if not character then return end
    
    local head = character:WaitForChild("Head")
    
    -- Создаем BillboardGui для ESP
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ExternalESP"
    billboard.Adornee = head
    billboard.Size = UDim2.new(0, 100, 0, 40)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true
    billboard.MaxDistance = 1000
    billboard.Parent = head
    
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = player.Name
    textLabel.TextColor3 = Color3.fromRGB(0, 255, 0) -- Зеленый
    textLabel.TextSize = 14
    textLabel.Font = Enum.Font.GothamBold
    textLabel.Parent = billboard
    
    -- Добавляем обводку
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.new(0, 0, 0)
    stroke.Thickness = 2
    stroke.Parent = textLabel
    
    ESPInstances[player] = billboard
    
    -- Обновление расстояния
    local function updateESP()
        if not ESPEnabled or not billboard or not billboard.Parent then return end
        
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local distance = (head.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
            textLabel.Text = string.format("%s | %d m", player.Name, math.floor(distance))
            
            -- Меняем цвет если у игрока есть ревайвы
            if character:FindFirstChild("Revives") then
                textLabel.TextColor3 = Color3.fromRGB(255, 255, 0) -- Желтый
            else
                textLabel.TextColor3 = Color3.fromRGB(0, 255, 0) -- Зеленый
            end
        end
    end
    
    -- Обновляем ESP каждый кадр
    local connection
    connection = RunService.Heartbeat:Connect(function()
        if not ESPEnabled or not billboard or not billboard.Parent then
            if connection then
                connection:Disconnect()
            end
            return
        end
        updateESP()
    end)
    
    -- Очистка при удалении персонажа
    player.CharacterRemoving:Connect(function()
        if ESPInstances[player] then
            ESPInstances[player]:Destroy()
            ESPInstances[player] = nil
        end
    end)
end

-- Подключаем ESP для всех игроков
for _, player in pairs(Players:GetPlayers()) do
    if player ~= LocalPlayer then
        task.spawn(createESP, player)
    end
end

-- Подключаем для новых игроков
Players.PlayerAdded:Connect(function(player)
    if player ~= LocalPlayer then
        task.spawn(createESP, player)
    end
end)

-- Удаляем ESP при выходе игрока
Players.PlayerRemoving:Connect(function(player)
    if ESPInstances[player] then
        ESPInstances[player]:Destroy()
        ESPInstances[player] = nil
    end
end)

return _G.DisableESP
