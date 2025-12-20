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

--- Platoboost Key System Integration ---
local platoboostService = 16094  -- ЗАМЕНИТЕ НА ВАШ SERVICE ID
local platoboostSecret = "9bfce86e-a6fc-4baf-93d8-4d77a2254e41"  -- ЗАМЕНИТЕ НА ВАШ СЕКРЕТНЫЙ КЛЮЧ
local useNonce = true

-- РЕЖИМ ТЕСТИРОВАНИЯ
local TEST_MODE = true -- поставьте false в финальной версии
local TEST_KEY = "FREE_15336e6fa00455535b9ced0641c88e89"

-- Утилиты
local HttpService = game:GetService("HttpService")

local function lEncode(data)
    return HttpService:JSONEncode(data)
end

local function lDecode(data)
    local success, result = pcall(function()
        return HttpService:JSONDecode(data)
    end)
    return success and result or nil
end

local function lDigest(input)
    local hash = 0
    for i = 1, #input do
        hash = (hash * 31 + string.byte(input, i)) % 2^32
    end
    return tostring(hash)
end

-- Получаем доступные функции HTTP
local function makeRequest(options)
    -- Пробуем разные методы HTTP запросов
    local requestFuncs = {
        request,
        http_request,
        syn and syn.request,
        http and http.request
    }
    
    for _, func in ipairs(requestFuncs) do
        if type(func) == "function" then
            local success, result = pcall(func, options)
            if success then
                return result
            end
        end
    end
    
    -- Если нет доступных методов, пробуем через HttpService
    local success, response = pcall(function()
        if options.Method == "GET" then
            return {
                Body = HttpService:GetAsync(options.Url, true),
                StatusCode = 200
            }
        elseif options.Method == "POST" then
            return {
                Body = HttpService:PostAsync(options.Url, options.Body or "", Enum.HttpContentType.ApplicationJson),
                StatusCode = 200
            }
        end
    end)
    
    if success then
        return response
    end
    
    return nil
end

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

-- Получаем HWID
local function getHWID()
    local hwidFuncs = {
        gethwid,
        syn and syn.crypt and syn.crypt.custom_hash and function() 
            return tostring(syn.crypt.custom_hash("md5", tostring(game:GetService("Players").LocalPlayer.UserId)))
        end
    }
    
    for _, func in ipairs(hwidFuncs) do
        if type(func) == "function" then
            local success, result = pcall(func)
            if success then
                return result
            end
        end
    end
    
    -- Используем UserId как запасной вариант
    return tostring(game:GetService("Players").LocalPlayer.UserId)
end

-- Генерация nonce
local function generateNonce()
    local str = ""
    for _ = 1, 16 do
        str = str .. string.char(math.floor(math.random() * (122 - 97 + 1)) + 97)
    end
    return str
end

-- Кэширование ссылки
local cachedLink, cachedTime = "", 0
local requestSending = false

local function cacheLink()
    if requestSending then
        return false, "Already processing request"
    end
    
    if cachedTime + (10 * 60) > os.time() and cachedLink ~= "" then
        return true, cachedLink
    end
    
    requestSending = true
    
    local hwid = getHWID()
    local data = {
        service = platoboostService,
        identifier = lDigest(hwid)
    }
    
    local response = makeRequest({
        Url = "https://api.platoboost.com/public/start",
        Method = "POST",
        Body = lEncode(data),
        Headers = {
            ["Content-Type"] = "application/json"
        }
    })
    
    requestSending = false
    
    if response and response.StatusCode == 200 then
        local decoded = lDecode(response.Body)
        if decoded and decoded.success then
            cachedLink = decoded.data.url
            cachedTime = os.time()
            return true, cachedLink
        else
            return false, decoded and decoded.message or "Failed to get link"
        end
    elseif response and response.StatusCode == 429 then
        return false, "Rate limited. Please wait 20 seconds."
    else
        -- Пробуем альтернативный хост
        local altResponse = makeRequest({
            Url = "https://api.platoboost.net/public/start",
            Method = "POST",
            Body = lEncode(data),
            Headers = {
                ["Content-Type"] = "application/json"
            }
        })
        
        if altResponse and altResponse.StatusCode == 200 then
            local decoded = lDecode(altResponse.Body)
            if decoded and decoded.success then
                cachedLink = decoded.data.url
                cachedTime = os.time()
                return true, cachedLink
            end
        end
        
        return false, "Failed to connect to Platoboost servers"
    end
end

-- Проверка ключа (обновленная версия с поддержкой FREE ключей)
local function verifyKey(key)
    if requestSending then
        return false, "Already processing request"
    end
    
    if key == "" then
        return false, "Please enter a key"
    end
    
    -- ПРОВЕРКА ДЛЯ БЕСПЛАТНЫХ ТЕСТОВЫХ КЛЮЧЕЙ (начинаются с FREE_)
    if string.sub(key, 1, 5) == "FREE_" then
        -- Простая проверка формата бесплатного ключа
        if string.len(key) == 36 and string.match(key, "^FREE_[a-f0-9]+$") then
            -- Дополнительная проверка: убедимся, что это не пустой ключ
            if key == "FREE_00000000000000000000000000000000" then
                return false, "Invalid test key"
            end
            
            -- Проверяем, что ключ соответствует тестовому
            if TEST_MODE and key == TEST_KEY then
                return true, "Test key accepted! Loading..."
            end
            
            -- Для других FREE ключей тоже разрешаем (в тестовом режиме)
            if TEST_MODE then
                return true, "Free key accepted! Loading..."
            else
                -- В продакшене проверяем через API
                -- (оставьте этот код, если хотите проверять бесплатные ключи через API)
            end
        else
            return false, "Invalid free key format"
        end
    end
    
    -- Оригинальная проверка через Platoboost для платных ключей
    requestSending = true
    
    local hwid = getHWID()
    local nonce = useNonce and generateNonce() or ""
    
    local url = "https://api.platoboost.com/public/whitelist/" .. platoboostService .. 
                "?identifier=" .. lDigest(hwid) .. "&key=" .. key
    if useNonce and nonce ~= "" then
        url = url .. "&nonce=" .. nonce
    end
    
    local response = makeRequest({
        Url = url,
        Method = "GET"
    })
    
    requestSending = false
    
    if not response then
        return false, "Failed to connect to server"
    end
    
    if response.StatusCode == 200 then
        local decoded = lDecode(response.Body)
        if decoded and decoded.success then
            if decoded.data.valid then
                if useNonce and nonce ~= "" then
                    local expectedHash = lDigest("true" .. "-" .. nonce .. "-" .. platoboostSecret)
                    if decoded.data.hash == expectedHash then
                        return true, "Key verified successfully!"
                    else
                        return false, "Security verification failed"
                    end
                else
                    return true, "Key verified successfully!"
                end
            else
                return false, "Invalid key"
            end
        else
            return false, decoded and decoded.message or "Verification failed"
        end
    elseif response.StatusCode == 429 then
        return false, "Rate limited. Please wait 20 seconds."
    else
        return false, "Server error: " .. tostring(response.StatusCode)
    end
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

-- Функция для проверки кнопок
local function testButtons()
    print("Testing buttons...")
    print("Submit button exists:", submitBtn ~= nil)
    print("GetKey button exists:", getKeyBtn ~= nil)
end

-- Автоматическая вставка тестового ключа (если включен тестовый режим)
if TEST_MODE then
    task.spawn(function()
        task.wait(0.5)
        keyInput.Text = TEST_KEY
        showMessage("Test key inserted! Enter your own key or click Submit.", Color3.fromRGB(0, 255, 0))
    end)
end

-- Кнопка Submit
submitBtn.MouseButton1Click:Connect(function()
    print("Submit button clicked!")
    
    local enteredKey = keyInput.Text
    
    if enteredKey == "" then
        showMessage("Please enter a key!", Color3.fromRGB(255, 255, 0))
        return
    end
    
    submitBtn.Text = "Checking..."
    submitBtn.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    
    task.spawn(function()
        local success, message = verifyKey(enteredKey)
        
        if success then
            showMessage(message, Color3.fromRGB(50, 255, 50))
            rotationSpeed = 3
            
            task.wait(1.5)
            executeScript()
        else
            showMessage("Error: " .. message, Color3.fromRGB(255, 50, 50))
            submitBtn.Text = "Submit"
            submitBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            rotationSpeed = 0.5
            
            -- Эффект тряски при ошибке
            local originalPos = keyInput.Position
            for i = 1, 5 do
                keyInput.Position = UDim2.new(0.5, -325 + math.random(-5, 5), 0, 155 + math.random(-2, 2))
                task.wait(0.05)
            end
            keyInput.Position = originalPos
        end
    end)
end)

-- Кнопка Get Key
getKeyBtn.MouseButton1Click:Connect(function()
    print("Get Key button clicked!")
    
    getKeyBtn.Text = "Getting link..."
    getKeyBtn.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    rotationSpeed = 2
    
    task.spawn(function()
        local success, linkOrMessage = cacheLink()
        
        if success then
            local copied = copyToClipboard(linkOrMessage)
            
            if copied then
                showMessage("Link copied to clipboard!", Color3.fromRGB(50, 150, 255))
                
                -- Показываем уведомление
                pcall(function()
                    game:GetService("StarterGui"):SetCore("SendNotification", {
                        Title = "Draconic Hub",
                        Text = "Key link copied!",
                        Duration = 3
                    })
                end)
            else
                showMessage("Link: " .. linkOrMessage, Color3.fromRGB(50, 150, 255))
            end
        else
            showMessage("Error: " .. linkOrMessage, Color3.fromRGB(255, 50, 50))
        end
        
        getKeyBtn.Text = "Get Key"
        getKeyBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        rotationSpeed = 0.5
    end)
end)

-- Анимация наведения на кнопки
local function setupButtonHover(button)
    local originalColor = button.BackgroundColor3
    
    button.MouseEnter:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(200, 200, 255)
    end)
    
    button.MouseLeave:Connect(function()
        button.BackgroundColor3 = originalColor
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
    end
end)

-- Информационное сообщение
task.spawn(function()
    task.wait(1)
    if not TEST_MODE then
        showMessage("Enter key to access Draconic Hub X", Color3.fromRGB(255, 255, 255))
    end
end)

print("Draconic Hub X Key System loaded!")
print("Test Mode:", TEST_MODE)
print("Test Key:", TEST_KEY)
print("Using Platoboost key system")
print("Service ID:", platoboostService)