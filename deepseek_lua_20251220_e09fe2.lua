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
mainFrame.Draggable = false -- Отключаем стандартное перетаскивание, сделаем свое
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
-- ВАЖНО: Замените эти значения на ваши реальные данные из Platoboost!
local platoboostService = 16094  -- ВАШ SERVICE ID
local platoboostSecret = "9bfce86e-a6fc-4baf-93d8-4d77a2254e41"  -- ВАШ СЕКРЕТНЫЙ КЛЮЧ
local useNonce = true

-- Отладочный режим (показывает больше информации)
local DEBUG_MODE = true

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

-- Улучшенная функция хеширования для Platoboost
local function lDigest(input)
    -- Platoboost ожидает MD5 хеш, но может работать и с простым хешем
    -- Для тестирования используем простой хеш
    local hash = 0
    for i = 1, #input do
        local char = string.byte(input, i)
        hash = (hash * 31 + char) % (2^32)
        hash = (hash * 17) % (2^32)  -- Добавляем дополнительное перемешивание
    end
    return tostring(math.floor(hash))
end

-- Функция для отладки
local function debugLog(message)
    if DEBUG_MODE then
        print("[Platoboost Debug]", message)
    end
end

-- Получаем доступные функции HTTP
local function makeRequest(options)
    debugLog("Making request to: " .. options.Url)
    
    -- Список возможных функций запроса
    local requestFunctions = {
        request,
        http_request,
        syn and syn.request,
        http and http.request,
        fluxus and fluxus.request,
        krnl and krnl.request,
        sendrequest  -- Для некоторых эксплойтов
    }
    
    for _, func in ipairs(requestFunctions) do
        if type(func) == "function" then
            local success, result = pcall(func, options)
            if success and result then
                debugLog("Request successful using " .. tostring(_))
                debugLog("Status code: " .. tostring(result.StatusCode))
                return result
            end
        end
    end
    
    -- Попробуем использовать стандартный HttpService как запасной вариант
    if options.Method == "GET" then
        local success, body = pcall(function()
            return HttpService:GetAsync(options.Url, true)
        end)
        if success then
            debugLog("Used HttpService:GetAsync")
            return {
                Body = body,
                StatusCode = 200
            }
        end
    end
    
    debugLog("No HTTP function available")
    return nil
end

-- Функция для копирования в буфер обмена
local function copyToClipboard(text)
    local clipboardFunctions = {
        setclipboard,
        toclipboard,
        writeclipboard,
        syn and syn.write_clipboard,
        set_clipboard
    }
    
    for _, func in ipairs(clipboardFunctions) do
        if type(func) == "function" then
            local success = pcall(func, text)
            if success then
                return true
            end
        end
    end
    
    return false
end

-- Получаем HWID (должен совпадать с тем, что видит Platoboost)
local function getHWID()
    debugLog("Getting HWID...")
    
    local hwidFunctions = {
        gethwid,
        syn and syn.crypt and syn.crypt.hash and function() 
            return tostring(syn.crypt.hash("md5", tostring(game:GetService("Players").LocalPlayer.UserId)))
        end
    }
    
    for _, func in ipairs(hwidFunctions) do
        if type(func) == "function" then
            local success, result = pcall(func)
            if success then
                debugLog("HWID obtained: " .. tostring(result):sub(1, 20) .. "...")
                return result
            end
        end
    end
    
    -- Используем UserId как запасной вариант
    local userId = tostring(game:GetService("Players").LocalPlayer.UserId)
    debugLog("Using UserId as HWID: " .. userId)
    return userId
end

-- Генерация nonce
local function generateNonce()
    local chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    local str = ""
    for _ = 1, 16 do
        local rand = math.random(1, #chars)
        str = str .. string.sub(chars, rand, rand)
    end
    return str
end

-- Инициализируем random seed
math.randomseed(tick())

-- Кэширование ссылки
local cachedLink, cachedTime = "", 0
local requestSending = false

local function cacheLink()
    if requestSending then
        debugLog("Request already in progress")
        return false, "Already processing request"
    end
    
    -- Проверяем кэш (10 минут)
    local currentTime = os.time()
    if cachedTime + 600 > currentTime and cachedLink ~= "" then
        debugLog("Using cached link")
        return true, cachedLink
    end
    
    requestSending = true
    debugLog("Requesting new link from Platoboost...")
    
    local hwid = getHWID()
    local identifier = lDigest(hwid)
    debugLog("Identifier (digested HWID): " .. identifier)
    
    local data = {
        service = platoboostService,
        identifier = identifier
    }
    
    debugLog("Sending data: service=" .. platoboostService .. ", identifier=" .. identifier)
    
    local response = makeRequest({
        Url = "https://api.platoboost.com/public/start",
        Method = "POST",
        Body = lEncode(data),
        Headers = {
            ["Content-Type"] = "application/json"
        }
    })
    
    requestSending = false
    
    if not response then
        debugLog("No response received")
        return false, "Failed to connect to server"
    end
    
    debugLog("Response status: " .. tostring(response.StatusCode))
    debugLog("Response body: " .. tostring(response.Body):sub(1, 200))
    
    if response.StatusCode == 200 then
        local decoded = lDecode(response.Body)
        if decoded then
            if decoded.success then
                cachedLink = decoded.data.url
                cachedTime = currentTime
                debugLog("Link obtained successfully: " .. cachedLink)
                return true, cachedLink
            else
                local msg = decoded.message or "Unknown error"
                debugLog("API error: " .. msg)
                return false, msg
            end
        else
            debugLog("Failed to decode JSON response")
            return false, "Invalid server response"
        end
    else
        debugLog("HTTP error: " .. tostring(response.StatusCode))
        return false, "Server error: " .. tostring(response.StatusCode)
    end
end

-- Проверка ключа (исправленная версия)
local function verifyKey(key)
    if requestSending then
        return false, "Already processing request"
    end
    
    if key == "" or not key then
        return false, "Please enter a key"
    end
    
    debugLog("Verifying key: " .. key)
    
    -- Очищаем ключ от лишних пробелов
    key = string.gsub(key, "%s+", "")
    
    requestSending = true
    
    local hwid = getHWID()
    local identifier = lDigest(hwid)
    local nonce = useNonce and generateNonce() or ""
    
    debugLog("HWID: " .. tostring(hwid))
    debugLog("Identifier: " .. identifier)
    debugLog("Nonce: " .. nonce)
    
    -- Строим URL для проверки ключа
    local url = string.format(
        "https://api.platoboost.com/public/whitelist/%d?identifier=%s&key=%s",
        platoboostService,
        identifier,
        key
    )
    
    if useNonce and nonce ~= "" then
        url = url .. "&nonce=" .. nonce
    end
    
    debugLog("Request URL: " .. url)
    
    local response = makeRequest({
        Url = url,
        Method = "GET"
    })
    
    requestSending = false
    
    if not response then
        debugLog("No response from server")
        return false, "Failed to connect to verification server"
    end
    
    debugLog("Verification response status: " .. tostring(response.StatusCode))
    
    if response.StatusCode == 200 then
        local decoded = lDecode(response.Body)
        
        if decoded then
            debugLog("Decoded response: success=" .. tostring(decoded.success))
            
            if decoded.success then
                if decoded.data.valid then
                    debugLog("Key is valid!")
                    
                    if useNonce and nonce ~= "" and decoded.data.hash then
                        local expectedHash = lDigest("true" .. "-" .. nonce .. "-" .. platoboostSecret)
                        debugLog("Expected hash: " .. expectedHash)
                        debugLog("Received hash: " .. decoded.data.hash)
                        
                        if decoded.data.hash == expectedHash then
                            return true, "Key verified successfully!"
                        else
                            debugLog("Hash mismatch!")
                            return false, "Security verification failed"
                        end
                    else
                        return true, "Key verified successfully!"
                    end
                else
                    debugLog("Key is marked as invalid in response")
                    return false, "Invalid key"
                end
            else
                local msg = decoded.message or "Verification failed"
                debugLog("API error: " .. msg)
                
                -- Проверяем, может быть это ключ для активации
                if string.sub(msg, 1, 27) == "unique constraint violation" then
                    return false, "You already have an active key. Please wait for it to expire."
                end
                
                return false, msg
            end
        else
            debugLog("Failed to decode verification response")
            return false, "Invalid server response format"
        end
    elseif response.StatusCode == 429 then
        debugLog("Rate limited")
        return false, "Rate limited. Please wait 20 seconds."
    else
        debugLog("Server error: " .. tostring(response.StatusCode))
        return false, "Server error: " .. tostring(response.StatusCode)
    end
end

-- Функция для показа сообщения
local function showMessage(text, color)
    errorLabel.Text = text
    errorLabel.TextColor3 = color
    errorLabel.Visible = true
    
    task.wait(3)
    errorLabel.Visible = false
end

-- Функция для запуска скрипта
local function executeScript()
    debugLog("Executing main script...")
    rotationSpeed = 0
    screenGui.Enabled = false
    
    local success, errorMsg = pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Gameidkdmekl/Testing/refs/heads/main/Overhaul.lua"))()
    end)
    
    if not success then
        screenGui.Enabled = true
        rotationSpeed = 0.5
        showMessage("Load error: " .. tostring(errorMsg):sub(1, 100), Color3.fromRGB(255, 50, 50))
    end
end

--- СИСТЕМА ПЕРЕТАСКИВАНИЯ ОКНА ---
local dragging = false
local dragStart = Vector2.new(0, 0)
local startPos = UDim2.new(0, 0, 0, 0)

local function updateDrag(input)
    if not dragging then return end
    
    local delta = input.Position - dragStart
    mainFrame.Position = UDim2.new(
        startPos.X.Scale, 
        startPos.X.Offset + delta.X,
        startPos.Y.Scale, 
        startPos.Y.Offset + delta.Y
    )
end

-- Функция для настройки перетаскивания элемента
local function setupDragging(element)
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
    
    element.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            if dragging then
                updateDrag(input)
            end
        end
    end)
end

-- Настраиваем перетаскивание для разных элементов
setupDragging(mainFrame)
setupDragging(titleLabel)
setupDragging(logoContainer)

-- Также настраиваем для UserInputService
game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        updateDrag(input)
    end
end)

--- ФУНКЦИОНАЛ КНОПОК ---

-- Кнопка Submit
submitBtn.MouseButton1Click:Connect(function()
    debugLog("Submit button clicked")
    
    local enteredKey = keyInput.Text
    
    if enteredKey == "" then
        showMessage("Please enter a key!", Color3.fromRGB(255, 255, 0))
        return
    end
    
    -- Меняем состояние кнопки
    submitBtn.Text = "Checking..."
    submitBtn.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    submitBtn.AutoButtonColor = false
    
    -- Запускаем проверку в отдельном потоке
    task.spawn(function()
        local success, message = verifyKey(enteredKey)
        
        if success then
            showMessage("✓ Key accepted! Loading Draconic Hub...", Color3.fromRGB(50, 255, 50))
            rotationSpeed = 3
            
            task.wait(1.5)
            executeScript()
        else
            showMessage("✗ " .. message, Color3.fromRGB(255, 50, 50))
            rotationSpeed = 0.5
            
            -- Эффект тряски
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
    debugLog("Get Key button clicked")
    
    -- Меняем состояние кнопки
    getKeyBtn.Text = "Getting link..."
    getKeyBtn.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    getKeyBtn.AutoButtonColor = false
    rotationSpeed = 2
    
    -- Запускаем в отдельном потоке
    task.spawn(function()
        local success, linkOrMessage = cacheLink()
        
        if success then
            local copied = copyToClipboard(linkOrMessage)
            
            if copied then
                showMessage("✓ Link copied to clipboard!", Color3.fromRGB(50, 150, 255))
                
                -- Показываем уведомление
                pcall(function()
                    game:GetService("StarterGui"):SetCore("SendNotification", {
                        Title = "Draconic Hub",
                        Text = "Key link copied! Open in browser.",
                        Duration = 4,
                        Icon = "rbxassetid://4483345998"
                    })
                end)
                
                -- Сохраняем ссылку в глобальную переменную на всякий случай
                _G.DraconicHub_KeyLink = linkOrMessage
                debugLog("Link saved to _G.DraconicHub_KeyLink")
            else
                showMessage("Link: " .. linkOrMessage, Color3.fromRGB(50, 150, 255))
            end
        else
            showMessage("✗ Error: " .. linkOrMessage, Color3.fromRGB(255, 50, 50))
        end
        
        -- Восстанавливаем кнопку
        getKeyBtn.Text = "Get Key"
        getKeyBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        getKeyBtn.AutoButtonColor = true
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

-- Закрытие на ESC
local userInputService = game:GetService("UserInputService")
local guiVisible = true

userInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Escape then
        guiVisible = not guiVisible
        screenGui.Enabled = guiVisible
        debugLog("GUI visibility: " .. tostring(guiVisible))
    end
end)

-- Информационное сообщение
task.spawn(function()
    task.wait(1)
    showMessage("Enter your key to access Draconic Hub X", Color3.fromRGB(255, 255, 255))
end)

-- Автоматически кэшируем ссылку при запуске
task.spawn(function()
    task.wait(2)
    debugLog("Pre-caching Platoboost link...")
    cacheLink()
end)

-- Отладочная информация
debugLog("=== Draconic Hub X Initialized ===")
debugLog("Service ID: " .. platoboostService)
debugLog("HWID: " .. tostring(getHWID()))
debugLog("LocalPlayer UserId: " .. game:GetService("Players").LocalPlayer.UserId)
debugLog("GUI created successfully")
debugLog("Drag system: Active (drag by title, logo, or window)")
debugLog("Debug mode: " .. tostring(DEBUG_MODE))

print("\n=====================================")
print("Draconic Hub X Key System v2.0")
print("=====================================")
print("✓ GUI создан")
print("✓ Система перетаскивания активирована")
print("✓ Platoboost система загружена")
print("✓ Отладка включена")
print("")
print("ИНСТРУКЦИЯ:")
print("1. Нажмите 'Get Key' для получения ссылки")
print("2. Скопируйте ссылку в браузер")
print("3. Получите ключ на сайте Platoboost")
print("4. Вставьте ключ и нажмите 'Submit'")
print("5. ESC - скрыть/показать меню")
print("6. Тащите за заголовок или лого для перемещения")
print("=====================================\n")

-- Тестовый режим (опционально - можно отключить)
if DEBUG_MODE then
    task.spawn(function()
        task.wait(10)
        print("\n[ТЕСТОВАЯ ИНФОРМАЦИЯ]")
        print("Для тестирования убедитесь, что:")
        print("1. Service ID правильный: " .. platoboostService)
        print("2. Секретный ключ правильный")
        print("3. Ключ начинается с 'KEY_' (если используете стандартный формат Platoboost)")
        print("4. Вы активировали ключ для вашего HWID")
        print("\nЕсли проблемы остаются, проверьте:")
        print("- Правильность Service ID в кабинете Platoboost")
        print("- Что ключ активирован для вашего HWID")
        print("- Что в кабинете Platoboost указан правильный секретный ключ")
    end)
end