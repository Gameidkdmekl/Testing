-- Создаем основной интерфейс
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "DraconicHubGui"
screenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")

-- Главный контейнер (Красное окно) с ЧЕРНОЙ ЖИРНОЙ ОБВОДКОЙ
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 700, 0, 350)
mainFrame.Position = UDim2.new(0.5, -350, 0.5, -170)
mainFrame.BackgroundColor3 = Color3.fromRGB(220, 20, 20)
mainFrame.BackgroundTransparency = 0.3
mainFrame.BorderSizePixel = 5
mainFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
mainFrame.Active = true
mainFrame.Selectable = true
mainFrame.Parent = screenGui

-- Скругление углов для главного окна
local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 15)
uiCorner.Parent = mainFrame

-- Контейнер для анимированного лого
local logoContainer = Instance.new("Frame")
logoContainer.Name = "LogoContainer"
logoContainer.Size = UDim2.new(0, 180, 0, 180)
logoContainer.Position = UDim2.new(0.5, -90, 0, -100)
logoContainer.BackgroundTransparency = 1
logoContainer.Parent = mainFrame

-- Вращающийся фон
local spinningBackground = Instance.new("ImageLabel")
spinningBackground.Name = "SpinningBackground"
spinningBackground.Size = UDim2.new(1.5, 0, 1.5, 0)
spinningBackground.AnchorPoint = Vector2.new(0.5, 0.5)
spinningBackground.Position = UDim2.new(0.5, 0, 0.5, 0)
spinningBackground.BackgroundTransparency = 1
spinningBackground.Image = "rbxassetid://105848999222798"
spinningBackground.ImageTransparency = 0.3
spinningBackground.ZIndex = 1
spinningBackground.Parent = logoContainer

-- Основное лого
local mainLogo = Instance.new("ImageLabel")
mainLogo.Name = "MainLogo"
mainLogo.Size = UDim2.new(0.8, 0, 0.8, 0)
mainLogo.AnchorPoint = Vector2.new(0.5, 0.5)
mainLogo.Position = UDim2.new(0.5, 0, 0.5, 0)
mainLogo.BackgroundTransparency = 1
mainLogo.Image = "rbxassetid://130570278955508"
mainLogo.ZIndex = 2
mainLogo.Parent = logoContainer

-- Скругление для основного лого
local logoCorner = Instance.new("UICorner")
logoCorner.CornerRadius = UDim.new(0.2, 0)
logoCorner.Parent = mainLogo

-- Заголовок
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(0, 660, 0, 50)
titleLabel.Position = UDim2.new(0.5, -325, 0, 90)
titleLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.Text = "Draconic Hub X Key System"
titleLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.TextSize = 40
titleLabel.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 20)
titleCorner.Parent = titleLabel

-- Поле ввода ключа
local keyInput = Instance.new("TextBox")
keyInput.Size = UDim2.new(0, 660, 0, 50)
keyInput.Position = UDim2.new(0.5, -325, 0, 155)
keyInput.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
keyInput.PlaceholderText = "Enter Key Here"
keyInput.Text = ""
keyInput.TextColor3 = Color3.fromRGB(0, 0, 0)
keyInput.Font = Enum.Font.SourceSans
keyInput.TextSize = 35
keyInput.Parent = mainFrame

local inputCorner = Instance.new("UICorner")
inputCorner.CornerRadius = UDim.new(0, 20)
inputCorner.Parent = keyInput

-- Кнопка Submit
local submitBtn = Instance.new("TextButton")
submitBtn.Size = UDim2.new(0, 260, 0, 60)
submitBtn.Position = UDim2.new(0, 25, 0, 220)
submitBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
submitBtn.Text = "Submit"
submitBtn.Font = Enum.Font.SourceSansBold
submitBtn.TextSize = 35
submitBtn.Parent = mainFrame

local submitCorner = Instance.new("UICorner")
submitCorner.CornerRadius = UDim.new(0, 20)
submitCorner.Parent = submitBtn

-- Кнопка Get Key
local getKeyBtn = Instance.new("TextButton")
getKeyBtn.Size = UDim2.new(0, 260, 0, 60)
getKeyBtn.Position = UDim2.new(0, 420, 0, 220)
getKeyBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
getKeyBtn.Text = "Get Key"
getKeyBtn.Font = Enum.Font.SourceSansBold
getKeyBtn.TextSize = 35
getKeyBtn.Parent = mainFrame

local getKeyCorner = Instance.new("UICorner")
getKeyCorner.CornerRadius = UDim.new(0, 20)
getKeyCorner.Parent = getKeyBtn

-- Создаем сообщение об ошибке
local errorLabel = Instance.new("TextLabel")
errorLabel.Size = UDim2.new(0, 660, 0, 40)
errorLabel.Position = UDim2.new(0.5, -325, 0, 300)
errorLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
errorLabel.BackgroundTransparency = 0.5
errorLabel.Text = ""
errorLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
errorLabel.Font = Enum.Font.SourceSansBold
errorLabel.TextSize = 25
errorLabel.Visible = false
errorLabel.Parent = mainFrame

local errorCorner = Instance.new("UICorner")
errorCorner.CornerRadius = UDim.new(0, 10)
errorCorner.Parent = errorLabel

--- АНИМАЦИЯ ВРАЩЕНИЯ ЛОГО ---
local rotationSpeed = 0.5
local currentRotation = 0

local function animateLogo()
    while true do
        task.wait()
        currentRotation = (currentRotation + rotationSpeed) % 360
        spinningBackground.Rotation = currentRotation
    end
end

task.spawn(animateLogo)

--- ПРОСТАЯ СИСТЕМА КЛЮЧЕЙ (без Platoboost для тестирования) ---
local FREE_KEYS = {
    "FREE_15336e6fa00455535b9ced0641c88e89",
    "FREE_TEST_KEY_12345",
    "FREE_ACCESS_2024",
    "DRACONIC_FREE_KEY"
}

-- РЕЖИМ ОТЛАДКИ
local DEBUG_MODE = true

-- Утилиты
local HttpService = game:GetService("HttpService")

-- Функция для копирования в буфер обмена
local function copyToClipboard(text)
    local clipboardFuncs = {
        setclipboard,
        toclipboard,
        writeclipboard,
        syn and syn.write_clipboard
    }
    
    for _, func in ipairs(clipboardFuncs) do
        if type(func) == "function" then
            local success = pcall(func, text)
            if success then
                return true
            end
        end
    end
    
    -- Альтернативный метод
    if pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Ссылка для ключа",
            Text = "Скопируйте: " .. string.sub(text, 1, 30) .. "...",
            Duration = 5
        })
    end) then
        -- Сохраняем ссылку в глобальную переменную
        _G.DraconicHubLink = text
        return true
    end
    
    return false
end

-- УПРОЩЕННАЯ ПРОВЕРКА КЛЮЧА
local function verifyKey(key)
    if key == "" or key == nil then
        return false, "Please enter a key"
    end
    
    -- Убираем лишние пробелы
    key = string.gsub(key, "%s+", "")
    
    -- Логируем ключ для отладки
    if DEBUG_MODE then
        print("[DEBUG] Checking key:", key)
        print("[DEBUG] Key length:", string.len(key))
    end
    
    -- ПРОВЕРКА 1: Бесплатные ключи (начинаются с FREE_)
    if string.sub(key, 1, 5):upper() == "FREE_" then
        if DEBUG_MODE then
            print("[DEBUG] Detected FREE key")
        end
        
        -- Простая проверка: любой ключ начинающийся с FREE_ принимается
        if string.len(key) > 10 then
            return true, "Free key accepted! Loading..."
        else
            return false, "Free key is too short"
        end
    end
    
    -- ПРОВЕРКА 2: Проверка в списке известных ключей
    for _, validKey in ipairs(FREE_KEYS) do
        if key == validKey then
            if DEBUG_MODE then
                print("[DEBUG] Key found in whitelist")
            end
            return true, "Key verified! Loading..."
        end
    end
    
    -- ПРОВЕРКА 3: Специальные тестовые ключи
    if key == "TEST123" or key == "DRACONIC" or key == "HUB2024" then
        return true, "Test key accepted! Loading..."
    end
    
    -- ПРОВЕРКА 4: Любой ключ длиной более 8 символов (для тестирования)
    if DEBUG_MODE and string.len(key) >= 8 then
        print("[DEBUG] Accepting key in debug mode (length > 8)")
        return true, "Debug key accepted! Loading..."
    end
    
    return false, "Invalid key. Please check and try again."
end

-- Функция для показа сообщения
local function showMessage(text, color)
    errorLabel.Text = text
    errorLabel.TextColor3 = color
    errorLabel.Visible = true
    
    task.spawn(function()
        task.wait(3)
        errorLabel.Visible = false
    end)
end

-- Функция для запуска скрипта
local function executeScript()
    rotationSpeed = 0
    screenGui.Enabled = false
    
    -- Показываем сообщение о загрузке
    task.spawn(function()
        task.wait(0.5)
        showMessage("Loading Draconic Hub...", Color3.fromRGB(0, 255, 0))
    end)
    
    local success, errorMsg = pcall(function()
        -- Загружаем скрипт хаба
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Gameidkdmekl/Testing/refs/heads/main/Overhaul.lua"))()
    end)
    
    if not success then
        screenGui.Enabled = true
        rotationSpeed = 0.5
        showMessage("Script error: " .. tostring(errorMsg), Color3.fromRGB(255, 50, 50))
        
        -- Сбрасываем кнопку Submit
        submitBtn.Text = "Submit"
        submitBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    end
end

--- ФУНКЦИОНАЛ КНОПОК ---

-- Автоматическая вставка тестового ключа (если включен режим отладки)
if DEBUG_MODE then
    task.spawn(function()
        task.wait(0.5)
        keyInput.Text = FREE_KEYS[1]  -- Первый ключ из списка
        showMessage("Test key inserted! Click Submit to continue.", Color3.fromRGB(0, 255, 0))
        
        -- Показываем уведомление
        pcall(function()
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Draconic Hub Debug Mode",
                Text = "Test key inserted automatically",
                Duration = 3
            })
        end)
    end)
end

-- Кнопка Submit
submitBtn.MouseButton1Click:Connect(function()
    if DEBUG_MODE then
        print("[DEBUG] Submit button clicked!")
    end
    
    local enteredKey = keyInput.Text
    
    if enteredKey == "" then
        showMessage("Please enter a key!", Color3.fromRGB(255, 255, 0))
        return
    end
    
    submitBtn.Text = "Checking..."
    submitBtn.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    submitBtn.TextSize = 30
    
    task.spawn(function()
        -- Небольшая задержка для визуального эффекта
        task.wait(0.5)
        
        local success, message = verifyKey(enteredKey)
        
        if success then
            showMessage(message, Color3.fromRGB(50, 255, 50))
            rotationSpeed = 3
            
            -- Анимация успеха
            for i = 1, 10 do
                submitBtn.BackgroundColor3 = Color3.fromRGB(50, 255 - i*10, 50)
                task.wait(0.05)
            end
            
            task.wait(1)
            executeScript()
        else
            showMessage("Error: " .. message, Color3.fromRGB(255, 50, 50))
            
            -- Сбрасываем кнопку
            submitBtn.Text = "Submit"
            submitBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            submitBtn.TextSize = 35
            rotationSpeed = 0.5
            
            -- Эффект тряски при ошибке
            local originalPos = keyInput.Position
            for i = 1, 8 do
                keyInput.Position = UDim2.new(0.5, -325 + math.random(-8, 8), 0, 155 + math.random(-3, 3))
                task.wait(0.04)
            end
            keyInput.Position = originalPos
            
            -- Подсвечиваем поле красным
            keyInput.BackgroundColor3 = Color3.fromRGB(255, 150, 150)
            task.wait(0.5)
            keyInput.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        end
    end)
end)

-- Кнопка Get Key
getKeyBtn.MouseButton1Click:Connect(function()
    if DEBUG_MODE then
        print("[DEBUG] Get Key button clicked!")
    end
    
    getKeyBtn.Text = "Getting Key..."
    getKeyBtn.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    getKeyBtn.TextSize = 30
    rotationSpeed = 2
    
    task.spawn(function()
        task.wait(0.5)
        
        -- В режиме отладки просто копируем тестовый ключ
        local testKey = FREE_KEYS[1]
        local copied = copyToClipboard(testKey)
        
        if copied then
            -- Также вставляем ключ в поле ввода
            keyInput.Text = testKey
            
            showMessage("Test key copied and inserted!", Color3.fromRGB(50, 150, 255))
            
            -- Показываем уведомление
            pcall(function()
                game:GetService("StarterGui"):SetCore("SendNotification", {
                    Title = "Draconic Hub",
                    Text = "Test key: " .. string.sub(testKey, 1, 15) .. "...",
                    Duration = 3
                })
            end)
        else
            showMessage("Key: " .. testKey, Color3.fromRGB(50, 150, 255))
            keyInput.Text = testKey
        end
        
        getKeyBtn.Text = "Get Key"
        getKeyBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        getKeyBtn.TextSize = 35
        rotationSpeed = 0.5
    end)
end)

-- Анимация наведения на кнопки
local function setupButtonHover(button)
    local originalColor = button.BackgroundColor3
    
    button.MouseEnter:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(200, 200, 255)
        rotationSpeed = 1.5
    end)
    
    button.MouseLeave:Connect(function()
        button.BackgroundColor3 = originalColor
        rotationSpeed = 0.5
    end)
end

setupButtonHover(submitBtn)
setupButtonHover(getKeyBtn)

-- Эффект при наведении на лого
logoContainer.MouseEnter:Connect(function()
    rotationSpeed = 2
    mainLogo.ImageTransparency = 0.2
end)

logoContainer.MouseLeave:Connect(function()
    rotationSpeed = 0.5
    mainLogo.ImageTransparency = 0
end)

-- Код перетаскивания окна
local dragging, dragInput, dragStart, startPos

mainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

mainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if dragging and input == dragInput then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- Закрытие на ESC
local userInputService = game:GetService("UserInputService")
local guiVisible = true

userInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Escape then
        guiVisible = not guiVisible
        screenGui.Enabled = guiVisible
        
        if DEBUG_MODE then
            print("[DEBUG] GUI visibility toggled:", guiVisible)
        end
    end
end)

-- Информационное сообщение
task.spawn(function()
    task.wait(1)
    if DEBUG_MODE then
        showMessage("DEBUG MODE: Use any key starting with FREE_", Color3.fromRGB(255, 255, 0))
    else
        showMessage("Enter key to access Draconic Hub X", Color3.fromRGB(255, 255, 255))
    end
end)

-- Обработка нажатия Enter в поле ввода
keyInput.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        submitBtn.MouseButton1Click:Fire()
    end
end)

-- Вывод отладочной информации
if DEBUG_MODE then
    print("=======================================")
    print("DRACONIC HUB X - DEBUG MODE ENABLED")
    print("=======================================")
    print("Accepted FREE keys:")
    for i, key in ipairs(FREE_KEYS) do
        print(i .. ". " .. key)
    end
    print("=======================================")
    print("Instructions:")
    print("1. Key is automatically inserted")
    print("2. Click 'Submit' or press Enter")
    print("3. Or click 'Get Key' for another key")
    print("=======================================")
end

print("Draconic Hub X Key System loaded successfully!")
print("Debug Mode:", DEBUG_MODE)