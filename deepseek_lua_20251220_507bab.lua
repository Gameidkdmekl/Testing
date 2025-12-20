-- Создаем основной интерфейс
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "DraconicHubGui"
screenGui.Parent = PlayerGui

-- Главный контейнер
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
mainFrame.Draggable = false
mainFrame.Parent = screenGui

-- Скругление углов
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

task.spawn(function()
    while task.wait() do
        currentRotation = (currentRotation + rotationSpeed) % 360
        spinningBackground.Rotation = currentRotation
    end
end)

--- ПРОСТАЯ И РАБОЧАЯ СИСТЕМА КЛЮЧЕЙ С PLATOBOOST ---

-- ВАШИ НАСТРОЙКИ PLATOBOOST (ОБЯЗАТЕЛЬНО ЗАМЕНИТЕ!)
local PLATOBOOST_SERVICE_ID = 16094
local PLATOBOOST_SECRET = "9bfce86e-a6fc-4baf-93d8-4d77a2254e41"
local USE_NONCE = true

-- Вспомогательные функции
local HttpService = game:GetService("HttpService")

local function JSONEncode(data)
    return HttpService:JSONEncode(data)
end

local function JSONDecode(str)
    local success, result = pcall(function()
        return HttpService:JSONDecode(str)
    end)
    return success and result or nil
end

-- Получаем HWID
local function GetHWID()
    if type(gethwid) == "function" then
        local success, hwid = pcall(gethwid)
        if success then
            return tostring(hwid)
        end
    end
    
    -- Используем комбинацию данных как HWID
    local userId = tostring(game:GetService("Players").LocalPlayer.UserId)
    local accountAge = tostring(game:GetService("Players").LocalPlayer.AccountAge)
    return userId .. "_" .. accountAge
end

-- Простая хеш-функция
local function SimpleHash(input)
    local hash = 0
    for i = 1, #input do
        hash = (hash * 31 + string.byte(input, i)) % (2^32)
    end
    return tostring(hash)
end

-- Функция для выполнения HTTP запросов
local function HttpRequest(options)
    -- Пробуем все доступные методы
    local methods = {
        syn and syn.request,
        request,
        http_request,
        http and http.request,
        fluxus and fluxus.request
    }
    
    for _, method in ipairs(methods) do
        if type(method) == "function" then
            local success, response = pcall(method, options)
            if success and response then
                return response
            end
        end
    end
    
    return nil
end

-- Функция для копирования в буфер обмена
local function CopyToClipboard(text)
    local methods = {
        setclipboard,
        toclipboard,
        writeclipboard,
        syn and syn.write_clipboard
    }
    
    for _, method in ipairs(methods) do
        if type(method) == "function" then
            local success = pcall(method, text)
            if success then
                return true
            end
        end
    end
    
    return false
end

-- Генерация nonce
local function GenerateNonce()
    local chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    local result = ""
    for i = 1, 16 do
        local rand = math.random(1, #chars)
        result = result .. string.sub(chars, rand, rand)
    end
    return result
end

-- Инициализация random
math.randomseed(tick())

-- Кэшированная ссылка
local cachedLink = ""
local linkCacheTime = 0
local isRequesting = false

-- 1. Функция получения ссылки от Platoboost
local function GetPlatoboostLink()
    if isRequesting then
        return false, "Please wait, processing..."
    end
    
    -- Проверяем кэш (5 минут)
    if os.time() - linkCacheTime < 300 and cachedLink ~= "" then
        return true, cachedLink
    end
    
    isRequesting = true
    
    local hwid = GetHWID()
    local identifier = SimpleHash(hwid)
    
    local requestData = {
        service = PLATOBOOST_SERVICE_ID,
        identifier = identifier
    }
    
    local response = HttpRequest({
        Url = "https://api.platoboost.com/public/start",
        Method = "POST",
        Body = JSONEncode(requestData),
        Headers = {
            ["Content-Type"] = "application/json"
        }
    })
    
    isRequesting = false
    
    if not response then
        return false, "Failed to connect to Platoboost server"
    end
    
    if response.StatusCode == 200 then
        local data = JSONDecode(response.Body)
        if data and data.success then
            cachedLink = data.data.url
            linkCacheTime = os.time()
            return true, cachedLink
        else
            return false, data and data.message or "Invalid response from server"
        end
    elseif response.StatusCode == 429 then
        return false, "Rate limited. Please wait 20 seconds."
    else
        return false, "Server error: " .. tostring(response.StatusCode)
    end
end

-- 2. Функция проверки ключа через Platoboost
local function VerifyPlatoboostKey(key)
    if isRequesting then
        return false, "Please wait, processing..."
    end
    
    if not key or string.trim(key) == "" then
        return false, "Please enter a key"
    end
    
    key = string.gsub(key, "%s+", "")
    
    isRequesting = true
    
    local hwid = GetHWID()
    local identifier = SimpleHash(hwid)
    local nonce = USE_NONCE and GenerateNonce() or ""
    
    local url = string.format(
        "https://api.platoboost.com/public/whitelist/%d?identifier=%s&key=%s",
        PLATOBOOST_SERVICE_ID,
        identifier,
        key
    )
    
    if USE_NONCE and nonce ~= "" then
        url = url .. "&nonce=" .. nonce
    end
    
    local response = HttpRequest({
        Url = url,
        Method = "GET"
    })
    
    isRequesting = false
    
    if not response then
        return false, "Cannot connect to verification server"
    end
    
    if response.StatusCode == 200 then
        local data = JSONDecode(response.Body)
        if data and data.success then
            if data.data.valid then
                if USE_NONCE and nonce ~= "" and data.data.hash then
                    local expectedHash = SimpleHash("true-" .. nonce .. "-" .. PLATOBOOST_SECRET)
                    if data.data.hash == expectedHash then
                        return true, "Key verified successfully!"
                    else
                        return false, "Security verification failed"
                    end
                end
                return true, "Key verified successfully!"
            else
                return false, "Invalid key. Please check and try again."
            end
        else
            return false, data and data.message or "Verification failed"
        end
    elseif response.StatusCode == 429 then
        return false, "Rate limited. Please wait 20 seconds."
    else
        return false, "Server error: " .. tostring(response.StatusCode)
    end
end

-- Функция для показа сообщений
local function ShowMessage(text, color)
    errorLabel.Text = text
    errorLabel.TextColor3 = color
    errorLabel.Visible = true
    
    task.wait(3)
    errorLabel.Visible = false
end

-- Функция для запуска основного скрипта
local function ExecuteMainScript()
    rotationSpeed = 0
    screenGui.Enabled = false
    
    local success, errorMsg = pcall(function()
        -- Загружаем ваш основной скрипт
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Gameidkdmekl/Testing/refs/heads/main/Overhaul.lua"))()
    end)
    
    if not success then
        screenGui.Enabled = true
        rotationSpeed = 0.5
        ShowMessage("Error loading script: " .. tostring(errorMsg):sub(1, 100), Color3.fromRGB(255, 50, 50))
    end
end

--- СИСТЕМА ПЕРЕТАСКИВАНИЯ ---
local dragging = false
local dragStart
local startPos

local function UpdateDrag(input)
    if not dragging then return end
    
    local delta = input.Position - dragStart
    mainFrame.Position = UDim2.new(
        startPos.X.Scale,
        startPos.X.Offset + delta.X,
        startPos.Y.Scale,
        startPos.Y.Offset + delta.Y
    )
end

-- Настройка перетаскивания для элементов
local function SetupDragging(element)
    element.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
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
end

SetupDragging(mainFrame)
SetupDragging(titleLabel)
SetupDragging(logoContainer)

-- Обработка движения мыши
game:GetService("UserInputService").InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        UpdateDrag(input)
    end
end)

--- ОБРАБОТКА КНОПОК ---

-- Кнопка Submit
submitBtn.MouseButton1Click:Connect(function()
    local key = keyInput.Text
    
    if key == "" then
        ShowMessage("Please enter a key!", Color3.fromRGB(255, 255, 0))
        return
    end
    
    -- Меняем вид кнопки
    submitBtn.Text = "Checking..."
    submitBtn.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    submitBtn.AutoButtonColor = false
    
    -- Проверяем ключ
    task.spawn(function()
        local success, message = VerifyPlatoboostKey(key)
        
        if success then
            ShowMessage("✓ " .. message, Color3.fromRGB(50, 255, 50))
            rotationSpeed = 3
            
            task.wait(1.5)
            ExecuteMainScript()
        else
            ShowMessage("✗ " .. message, Color3.fromRGB(255, 50, 50))
            rotationSpeed = 0.5
            
            -- Эффект тряски при ошибке
            local originalPos = keyInput.Position
            for i = 1, 5 do
                keyInput.Position = UDim2.new(
                    0.5, -325 + math.random(-5, 5),
                    0, 155 + math.random(-2, 2)
                )
                task.wait(0.05)
            end
            keyInput.Position = originalPos
            keyInput.Text = ""
        end
        
        -- Восстанавливаем кнопку
        submitBtn.Text = "Submit"
        submitBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        submitBtn.AutoButtonColor = true
    end)
end)

-- Кнопка Get Key
getKeyBtn.MouseButton1Click:Connect(function()
    getKeyBtn.Text = "Getting link..."
    getKeyBtn.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    getKeyBtn.AutoButtonColor = false
    rotationSpeed = 2
    
    task.spawn(function()
        local success, linkOrMessage = GetPlatoboostLink()
        
        if success then
            local copied = CopyToClipboard(linkOrMessage)
            
            if copied then
                ShowMessage("✓ Link copied to clipboard!", Color3.fromRGB(50, 150, 255))
            else
                ShowMessage("Link: " .. linkOrMessage, Color3.fromRGB(50, 150, 255))
            end
            
            -- Показываем уведомление
            pcall(function()
                game:GetService("StarterGui"):SetCore("SendNotification", {
                    Title = "Draconic Hub",
                    Text = "Key link ready! Paste in browser.",
                    Duration = 4
                })
            end)
        else
            ShowMessage("✗ " .. linkOrMessage, Color3.fromRGB(255, 50, 50))
        end
        
        getKeyBtn.Text = "Get Key"
        getKeyBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        getKeyBtn.AutoButtonColor = true
        rotationSpeed = 0.5
    end)
end)

-- Анимация наведения на кнопки
local function SetupButtonHover(button)
    local originalColor = button.BackgroundColor3
    
    button.MouseEnter:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(200, 200, 255)
    end)
    
    button.MouseLeave:Connect(function()
        button.BackgroundColor3 = originalColor
    end)
end

SetupButtonHover(submitBtn)
SetupButtonHover(getKeyBtn)

-- Эффект при наведении на лого
logoContainer.MouseEnter:Connect(function()
    rotationSpeed = 2
    mainLogo.ImageTransparency = 0.2
end)

logoContainer.MouseLeave:Connect(function()
    rotationSpeed = 0.5
    mainLogo.ImageTransparency = 0
end)

-- Закрытие интерфейса на ESC
local UserInputService = game:GetService("UserInputService")
local guiVisible = true

UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Escape then
        guiVisible = not guiVisible
        screenGui.Enabled = guiVisible
    end
end)

-- Начальное сообщение
task.spawn(function()
    task.wait(1)
    ShowMessage("Enter your key to access Draconic Hub X", Color3.fromRGB(255, 255, 255))
end)

-- Автоматически получаем ссылку при запуске
task.spawn(function()
    task.wait(3)
    print("[System] Pre-fetching Platoboost link...")
    GetPlatoboostLink()
end)

-- Вывод информации в консоль
print("\n" .. string.rep("=", 60))
print("DRACONIC HUB X - PLATOBOOST KEY SYSTEM")
print(string.rep("=", 60))
print("✓ GUI loaded successfully")
print("✓ Drag & drop system: ACTIVE")
print("✓ Platoboost API: ENABLED")
print("✓ Service ID:", PLATOBOOST_SERVICE_ID)
print("✓ HWID:", GetHWID())
print("✓ Player:", Player.Name)
print("")
print("INSTRUCTIONS:")
print("1. Click 'Get Key' for key link")
print("2. Get key from Platoboost website")
print("3. Paste key and click 'Submit'")
print("4. Drag window by title or logo")
print("5. ESC to hide/show interface")
print(string.rep("=", 60))

-- Проверка настроек Platoboost
task.spawn(function()
    task.wait(5)
    print("\n[Platoboost Configuration Check]")
    print("Make sure in your Platoboost dashboard:")
    print("1. Service ID matches: " .. PLATOBOOST_SERVICE_ID)
    print("2. Secret Key is correct")
    print("3. Key system is enabled")
    print("4. Your HWID: " .. GetHWID())
    print("\nIf keys don't work, try:")
    print("1. Set USE_NONCE = false")
    print("2. Check Service ID in dashboard")
    print("3. Make sure keys start with 'KEY_'")
end)

-- Временный тестовый ключ для отладки (удалить в продакшене)
task.spawn(function()
    task.wait(7)
    -- Автозаполнение для тестирования
    if keyInput.Text == "" then
        keyInput.Text = "KEY_TEST_DRACONIC_2024"
        print("\n[Test] Test key auto-filled for debugging")
    end
end)