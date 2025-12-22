-- Esp.lua (внешний ESP файл с loop)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- Глобальная переменная для управления ESP
_G.ESPEnabled = true
local ESPInstances = {}
local ESPLoop = nil

-- Функция для отключения ESP
_G.DisableESP = function()
    _G.ESPEnabled = false
    
    -- Останавливаем loop
    if ESPLoop then
        ESPLoop:Disconnect()
        ESPLoop = nil
    end
    
    -- Удаляем все ESP
    for _, esp in pairs(ESPInstances) do
        pcall(function()
            esp:Destroy()
        end)
    end
    ESPInstances = {}
    
    print("External ESP disabled")
end

-- Функция для включения ESP
local function enableESP()
    if not _G.ESPEnabled then return end
    
    -- Удаляем старые ESP
    for _, esp in pairs(ESPInstances) do
        pcall(function()
            esp:Destroy()
        end)
    end
    ESPInstances = {}
    
    -- Создаем ESP для всех игроков
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            createPlayerESP(player)
        end
    end
end

local function createPlayerESP(player)
    if not _G.ESPEnabled or player == LocalPlayer then return end
    
    local character = player.Character
    if not character then return end
    
    local head = character:FindFirstChild("Head") or character:FindFirstChild("HumanoidRootPart")
    if not head then return end
    
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
    textLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
    textLabel.TextSize = 14
    textLabel.Font = Enum.Font.GothamBold
    textLabel.Parent = billboard
    
    -- Добавляем обводку
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.new(0, 0, 0)
    stroke.Thickness = 2
    stroke.Parent = textLabel
    
    ESPInstances[player] = billboard
    
    return billboard
end

-- Функция обновления ESP в loop
local function updateESP()
    if not _G.ESPEnabled then return end
    
    for player, esp in pairs(ESPInstances) do
        if not player or not player.Character or not esp or not esp.Parent then
            if esp then
                esp:Destroy()
            end
            ESPInstances[player] = nil
        elseif esp:FindFirstChildOfClass("TextLabel") then
            local character = player.Character
            local head = character:FindFirstChild("Head") or character:FindFirstChild("HumanoidRootPart")
            
            if head and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                local distance = (head.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                local textLabel = esp:FindFirstChildOfClass("TextLabel")
                textLabel.Text = string.format("%s | %d m", player.Name, math.floor(distance))
                
                -- Меняем цвет если у игрока есть ревайвы
                if character:FindFirstChild("Revives") then
                    textLabel.TextColor3 = Color3.fromRGB(255, 255, 0) -- Желтый
                else
                    textLabel.TextColor3 = Color3.fromRGB(0, 255, 0) -- Зеленый
                end
            end
        end
    end
    
    -- Проверяем новых игроков
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and not ESPInstances[player] and player.Character then
            createPlayerESP(player)
        end
    end
end

-- Основной loop ESP
ESPLoop = RunService.Heartbeat:Connect(updateESP)

-- Инициализация ESP при загрузке
task.spawn(function()
    task.wait(1) -- Даем время на загрузку
    enableESP()
end)

-- Обработка новых игроков
Players.PlayerAdded:Connect(function(player)
    if player ~= LocalPlayer then
        player.CharacterAdded:Connect(function()
            if _G.ESPEnabled then
                task.wait(0.5)
                createPlayerESP(player)
            end
        end)
    end
end)

-- Очистка при выходе игрока
Players.PlayerRemoving:Connect(function(player)
    if ESPInstances[player] then
        ESPInstances[player]:Destroy()
        ESPInstances[player] = nil
    end
end)

-- Очистка при удалении персонажа
LocalPlayer.CharacterRemoving:Connect(function()
    if ESPLoop then
        ESPLoop:Disconnect()
        ESPLoop = nil
    end
end)

print("External ESP loaded with loop system")
