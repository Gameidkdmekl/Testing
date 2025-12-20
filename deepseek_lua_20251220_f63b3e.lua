-- Создаем основной интерфейс
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "DraconicHubGui"
screenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")

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

local function animateLogo()
    while true do
        task.wait()
        currentRotation = (currentRotation + rotationSpeed) % 360
        spinningBackground.Rotation = currentRotation
    end
end

task.spawn(animateLogo)

--- Platoboost Key System Integration ---
-- ВАЖНО: Замените эти значения на ваши реальные данные из кабинета Platoboost!
local PlatoboostService = 16094  -- Ваш Service ID
local PlatoboostSecret = "9bfce86e-a6fc-4baf-93d8-4d77a2254e41"  -- Ваш Secret Key
local UseNonce = true

-- Создаем глобальную функцию для уведомлений
_G.PlatoboostMessage = function(message)
    print("[Platoboost]", message)
    -- Можно добавить вывод в GUI если нужно
end

-- Получаем HttpService
local HttpService = game:GetService("HttpService")

-- Функции кодирования/декодирования
local function lEncode(data)
    return HttpService:JSONEncode(data)
end

local function lDecode(data)
    local success, result = pcall(function()
        return HttpService:JSONDecode(data)
    end)
    return success and result or nil
end

-- Простая хеш-функция (Platoboost использует MD5, но эта должна работать)
local function lDigest(input)
    local hash = 5381
    for i = 1, #input do
        hash = ((hash << 5) + hash) + string.byte(input, i)
        hash = hash & 0xFFFFFFFF
    end
    return tostring(hash)
end

-- Ищем доступные HTTP функции
local function getHttpFunction()
    -- Проверяем все возможные функции
    if type(syn) == "table" and type(syn.request) == "function" then
        return syn.request
    elseif type(request) == "function" then
        return request
    elseif type(http_request) == "function" then
        return http_request
    elseif type(http) == "table" and type(http.request) == "function" then
        return http.request
    elseif type(fluxus) == "table" and type(fluxus.request) == "function" then
        return fluxus.request
    end
    
    -- Используем HttpService как запасной вариант
    return nil
end

-- Функция для выполнения HTTP запросов
local httpRequest = getHttpFunction()
local function makeHttpRequest(options)
    if httpRequest then
        local success, response = pcall(httpRequest, options)
        if success and response then
            return response
        end
    end
    
    -- Запасной вариант через HttpService
    if options.Method == "GET" then
        local success, body = pcall(function()
            return HttpService:GetAsync(options.Url, true)
        end)
        if success then
            return {StatusCode = 200, Body = body}
        end
    end
    
    return nil
end

-- Функция для копирования в буфер обмена
local function copyToClipboard(text)
    if type(setclipboard) == "function" then
        pcall(setclipboard, text)
        return true
    elseif type(toclipboard) == "function" then
        pcall(toclipboard, text)
        return true
    elseif type(syn) == "table" and type(syn.write_clipboard) == "function" then
        pcall(syn.write_clipboard, text)
        return true
    end
    return false
end

-- Получаем HWID
local function getHWID()
    if type(gethwid) == "function" then
        local success, hwid = pcall(gethwid)
        if success then
            return tostring(hwid)
        end
    end
    
    -- Используем UserId как запасной вариант
    return tostring(game:GetService("Players").LocalPlayer.UserId)
end

-- Генерация nonce
local function generateNonce()
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

-- Основные функции Platoboost
local requestSending = false
local cachedLink = ""
local cacheTime = 0

-- 1. Функция для получения ссылки
local function getLink()
    if requestSending then
        return false, "Please wait..."
    end
    
    requestSending = true
    
    -- Проверяем кэш (10 минут)
    if cacheTime + 600 > os.time() and cachedLink ~= "" then
        requestSending = false
        return true, cachedLink
    end
    
    local hwid = getHWID()
    local identifier = lDigest(hwid)
    
    local response = makeHttpRequest({
        Url = "https://api.platoboost.com/public/start",
        Method = "POST",
        Body = lEncode({
            service = PlatoboostService,
            identifier = identifier
        }),
        Headers = {
            ["Content-Type"] = "application/json"
        }
    })
    
    requestSending = false
    
    if not response then
        return false, "Failed to connect to server"
    end
    
    if response.StatusCode == 200 then
        local data = lDecode(response.Body)
        if data and data.success then
            cachedLink = data.data.url
            cacheTime = os.time()
            return true, cachedLink
        else
            return false, data and data.message or "Unknown error"
        end
    elseif response.StatusCode == 429 then
        return false, "Rate limited. Wait 20 seconds."
    else
        return false, "Server error: " .. tostring(response.StatusCode)
    end
end

-- 2. Функция для проверки ключа
local function checkKey(key)
    if requestSending then
        return false, "Please wait..."
    end
    
    if not key or key == "" then
        return false, "Please enter a key"
    end
    
    -- Очищаем ключ
    key = string.gsub(key, "%s+", "")
    
    requestSending = true
    
    local hwid = getHWID()
    local identifier = lDigest(hwid)
    local nonce = UseNonce and generateNonce() or ""
    
    -- Строим URL для проверки
    local url = string.format(
        "https://api.platoboost.com/public/whitelist/%d?identifier=%s&key=%s",
        PlatoboostService,
        identifier,
        key
    )
    
    if UseNonce and nonce ~= "" then
        url = url .. "&nonce=" .. nonce
    end
    
    local response = makeHttpRequest({
        Url = url,
        Method = "GET"
    })
    
    requestSending = false
    
    if not response then
        return false, "Cannot connect to server"
    end
    
    if response.StatusCode == 200 then
        local data = lDecode(response.Body)
        if data and data.success then
            if data.data.valid then
                -- Проверяем nonce если используется
                if UseNonce and nonce ~= "" and data.data.hash then
                    local expectedHash = lDigest("true-" .. nonce .. "-" .. PlatoboostSecret)
                    if data.data.hash == expectedHash then
                        return true, "Key verified!"
                    else
                        return false, "Security check failed"
                    end
                end
                return true, "Key verified!"
            else
                return false, "Invalid key"
            end
        else
            return false, data and data.message or "Verification failed"
        end
    elseif response.StatusCode == 429 then
        return false, "Rate limited. Wait 20 seconds."
    else
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
    rotationSpeed = 0
    screenGui.Enabled = false
    
    local success, errorMsg = pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Gameidkdmekl/Testing/refs/heads/main/Overhaul.lua"))()
    end)
    
    if not success then
        screenGui.Enabled = true
        rotationSpeed = 0.5
        showMessage("Error: " .. tostring(errorMsg):sub(1, 100), Color3.fromRGB(255, 50, 50))
    end
end

--- СИСТЕМА ПЕРЕТАСКИВАНИЯ ОКНА ---
local dragging = false
local dragStart
local startPos

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

-- Настройка перетаскивания
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
end

setupDragging(mainFrame)
setupDragging(titleLabel)
setupDragging(logoContainer)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        updateDrag(input)
    end
end)

--- ФУНКЦИОНАЛ КНОПОК ---

-- Кнопка Submit
submitBtn.MouseButton1Click:Connect(function()
    local key = keyInput.Text
    
    if key == "" then
        showMessage("Enter a key!", Color3.fromRGB(255, 255, 0))
        return
    end
    
    submitBtn.Text = "Checking..."
    submitBtn.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    submitBtn.AutoButtonColor = false
    
    task.spawn(function()
        local success, message = checkKey(key)
        
        if success then
            showMessage("✓ " .. message, Color3.fromRGB(50, 255, 50))
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
        
        submitBtn.Text = "Submit"
        submitBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        submitBtn.AutoButtonColor = true
    end)
end)

-- Кнопка Get Key
getKeyBtn.MouseButton1Click:Connect(function()
    getKeyBtn.Text = "Getting..."
    getKeyBtn.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    getKeyBtn.AutoButtonColor = false
    rotationSpeed = 2
    
    task.spawn(function()
        local success, linkOrMessage = getLink()
        
        if success then
            local copied = copyToClipboard(linkOrMessage)
            
            if copied then
                showMessage("✓ Link copied!", Color3.fromRGB(50, 150, 255))
            else
                showMessage("Link: " .. linkOrMessage, Color3.fromRGB(50, 150, 255))
            end
            
            -- Уведомление
            pcall(function()
                game:GetService("StarterGui"):SetCore("SendNotification", {
                    Title = "Draconic Hub",
                    Text = "Key link ready!",
                    Duration = 3
                })
            end)
        else
            showMessage("✗ " .. linkOrMessage, Color3.fromRGB(255, 50, 50))
        end
        
        getKeyBtn.Text = "Get Key"
        getKeyBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        getKeyBtn.AutoButtonColor = true
        rotationSpeed = 0.5
    end)
end)

-- Анимация наведения
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

-- Эффект лого
logoContainer.MouseEnter:Connect(function()
    rotationSpeed = 2
    mainLogo.ImageTransparency = 0.2
end)

logoContainer.MouseLeave:Connect(function()
    rotationSpeed = 0.5
    mainLogo.ImageTransparency = 0
end)

-- ESC для скрытия
local userInputService = game:GetService("UserInputService")
local guiVisible = true

userInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Escape then
        guiVisible = not guiVisible
        screenGui.Enabled = guiVisible
    end
end)

-- Информация при запуске
task.spawn(function()
    task.wait(1)
    showMessage("Enter your key to access Draconic Hub", Color3.fromRGB(255, 255, 255))
end)

-- Отладочная информация
print("\n" .. string.rep("=", 50))
print("DRACONIC HUB X - Platoboost System")
print(string.rep("=", 50))
print("Service ID: " .. PlatoboostService)
print("HWID: " .. getHWID())
print("Player: " .. game:GetService("Players").LocalPlayer.Name)
print("User ID: " .. game:GetService("Players").LocalPlayer.UserId)
print("")
print("Instructions:")
print("1. Click 'Get Key' for key link")
print("2. Get key from Platoboost website")
print("3. Paste key and click 'Submit'")
print("4. ESC to hide/show")
print("5. Drag window by title/logo")
print(string.rep("=", 50))

-- Предварительная загрузка ссылки
task.spawn(function()
    task.wait(3)
    print("[System] Pre-caching Platoboost link...")
    getLink()
end)

-- Тестовый ключ для проверки
task.spawn(function()
    task.wait(5)
    print("\n[Test Info]")
    print("If keys aren't working, check:")
    print("1. Service ID is correct")
    print("2. Secret key matches dashboard")
    print("3. Key starts with 'KEY_' (Platoboost format)")
    print("4. Key is activated for your HWID")
    print("\nMake sure in Platoboost dashboard:")
    print("- Service ID: " .. PlatoboostService)
    print("- HWID matches: " .. getHWID())
end)