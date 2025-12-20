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

-- Функция для анимации вращения
local function animateLogo()
    while true do
        task.wait()
        currentRotation = (currentRotation + rotationSpeed) % 360
        spinningBackground.Rotation = currentRotation
    end
end

-- Запускаем анимацию в отдельном потоке
task.spawn(animateLogo)

--- PLATOBOOST KEY SYSTEM ---
local service = 16094
local secret = "9bfce86e-a6fc-4baf-93d8-4d77a2254e41"
local useNonce = true

-- Вспомогательные функции для Platoboost
local function lEncode(data)
    return game:GetService("HttpService"):JSONEncode(data)
end

local function lDecode(data)
    return game:GetService("HttpService"):JSONDecode(data)
end

local function lDigest(input)
    return tostring(input)
end

--! callbacks
local onMessage = function(message) 
    print("[Platoboost]: " .. message)
end

--! wait for game to load
repeat task.wait(1) until game:IsLoaded()

--! functions
local requestSending = false
local fSetClipboard, fRequest, fStringChar, fToString, fStringSub, fOsTime, fMathRandom, fMathFloor, fGetHwid = 
    setclipboard or toclipboard, 
    (syn and syn.request) or request or (http and http.request) or http_request,
    string.char, 
    tostring, 
    string.sub, 
    os.time, 
    math.random, 
    math.floor,
    function()
        if syn then
            return syn.crypt.base64.encode(tostring(game:GetService("Players").LocalPlayer.UserId))
        end
        return tostring(game:GetService("Players").LocalPlayer.UserId)
    end

local cachedLink, cachedTime = "", 0

--! pick host
local host = "https://api.platoboost.com"
local hostResponse
local success, hostResult = pcall(function()
    hostResponse = fRequest({
        Url = host .. "/public/connectivity",
        Method = "GET"
    })
    return hostResponse
end)

if not success or (hostResponse and hostResponse.StatusCode ~= 200 and hostResponse.StatusCode ~= 429) then
    host = "https://api.platoboost.net"
end

-- Кэширование ссылки
local function cacheLink()
    if cachedTime + (10*60) < fOsTime() then
        local response = fRequest({
            Url = host .. "/public/start",
            Method = "POST",
            Body = lEncode({
                service = service,
                identifier = lDigest(fGetHwid())
            }),
            Headers = {
                ["Content-Type"] = "application/json"
            }
        })

        if response and response.StatusCode == 200 then
            local decoded = lDecode(response.Body)

            if decoded.success == true then
                cachedLink = decoded.data.url
                cachedTime = fOsTime()
                return true, cachedLink
            else
                onMessage(decoded.message or "Unknown error")
                return false, decoded.message or "Unknown error"
            end
        elseif response and response.StatusCode == 429 then
            local msg = "You are being rate limited, please wait 20 seconds and try again."
            onMessage(msg)
            return false, msg
        end

        local msg = "Failed to cache link."
        onMessage(msg)
        return false, msg
    else
        return true, cachedLink
    end
end

-- Генерация nonce
local function generateNonce()
    local str = ""
    for _ = 1, 16 do
        str = str .. fStringChar(fMathFloor(fMathRandom() * (122 - 97 + 1)) + 97)
    end
    return str
end

-- Проверка nonce
for _ = 1, 5 do
    local oNonce = generateNonce()
    task.wait(0.2)
    if generateNonce() == oNonce then
        local msg = "platoboost nonce error."
        onMessage(msg)
        break
    end
end

-- Копирование ссылки
local function copyLink()
    local success, link = cacheLink()
    
    if success then
        if fSetClipboard then
            fSetClipboard(link)
            return true, "Link copied to clipboard: " .. link
        else
            return false, "Cannot copy to clipboard"
        end
    else
        return false, link
    end
end

-- Проверка ключа через Platoboost
local function verifyKey(key)
    if requestSending == true then
        onMessage("A request is already being sent, please slow down.")
        return false
    else
        requestSending = true
    end

    local nonce = generateNonce()
    local endpoint = host .. "/public/whitelist/" .. fToString(service) .. "?identifier=" .. lDigest(fGetHwid()) .. "&key=" .. key

    if useNonce then
        endpoint = endpoint .. "&nonce=" .. nonce
    end

    local response = fRequest({
        Url = endpoint,
        Method = "GET",
    })

    requestSending = false

    if response and response.StatusCode == 200 then
        local decoded = lDecode(response.Body)

        if decoded.success == true then
            if decoded.data.valid == true then
                if useNonce then
                    if decoded.data.hash == lDigest("true" .. "-" .. nonce .. "-" .. secret) then
                        return true
                    else
                        onMessage("Failed to verify integrity.")
                        return false
                    end
                else
                    return true
                end
            else
                if fStringSub(key, 1, 4) == "KEY_" then
                    -- Попробуем активировать ключ
                    return redeemKey(key)
                else
                    onMessage("Key is invalid.")
                    return false
                end
            end
        else
            onMessage(decoded.message or "Unknown error")
            return false
        end
    elseif response and response.StatusCode == 429 then
        onMessage("You are being rate limited, please wait 20 seconds and try again.")
        return false
    else
        onMessage("Server returned an invalid status code, please try again later.")
        return false
    end
end

-- Активация ключа
local function redeemKey(key)
    local nonce = generateNonce()
    local endpoint = host .. "/public/redeem/" .. fToString(service)

    local body = {
        identifier = lDigest(fGetHwid()),
        key = key
    }

    if useNonce then
        body.nonce = nonce
    end

    local response = fRequest({
        Url = endpoint,
        Method = "POST",
        Body = lEncode(body),
        Headers = {
            ["Content-Type"] = "application/json"
        }
    })

    if response and response.StatusCode == 200 then
        local decoded = lDecode(response.Body)

        if decoded.success == true then
            if decoded.data.valid == true then
                if useNonce then
                    if decoded.data.hash == lDigest("true" .. "-" .. nonce .. "-" .. secret) then
                        return true
                    else
                        onMessage("Failed to verify integrity.")
                        return false
                    end    
                else
                    return true
                end
            else
                onMessage("Key is invalid.")
                return false
            end
        else
            if fStringSub(decoded.message or "", 1, 27) == "unique constraint violation" then
                onMessage("You already have an active key, please wait for it to expire before redeeming it.")
                return false
            else
                onMessage(decoded.message or "Unknown error")
                return false
            end
        end
    elseif response and response.StatusCode == 429 then
        onMessage("You are being rate limited, please wait 20 seconds and try again.")
        return false
    else
        onMessage("Server returned an invalid status code, please try again later.")
        return false
    end
end

-- Получение флагов
local function getFlag(name)
    local nonce = generateNonce()
    local endpoint = host .. "/public/flag/" .. fToString(service) .. "?name=" .. name

    if useNonce then
        endpoint = endpoint .. "&nonce=" .. nonce
    end

    local response = fRequest({
        Url = endpoint,
        Method = "GET",
    })

    if response and response.StatusCode == 200 then
        local decoded = lDecode(response.Body)

        if decoded.success == true then
            if useNonce then
                if decoded.data.hash == lDigest(fToString(decoded.data.value) .. "-" .. nonce .. "-" .. secret) then
                    return decoded.data.value
                else
                    onMessage("Failed to verify integrity.")
                    return nil
                end
            else
                return decoded.data.value
            end
        else
            onMessage(decoded.message or "Unknown error")
            return nil
        end
    else
        return nil
    end
end

--- СИСТЕМА СОХРАНЕНИЯ КЛЮЧА ---
local DataStoreService = game:GetService("DataStoreService")
local keyStore = DataStoreService:GetDataStore("DraconicHubKeysPlato")

-- Получаем UserId игрока
local player = game:GetService("Players").LocalPlayer
local userId = tostring(player.UserId)

-- Функция для сохранения ключа
local function saveKey(key)
    local success, errorMessage = pcall(function()
        keyStore:SetAsync(userId, {
            key = key,
            timestamp = os.time()
        })
    end)
    
    if success then
        print("[Save System] Key saved: " .. key)
        return true
    else
        print("[Save System] Error saving key: " .. tostring(errorMessage))
        return false
    end
end

-- Функция для загрузки ключа
local function loadKey()
    local success, savedData = pcall(function()
        return keyStore:GetAsync(userId)
    end)
    
    if success and savedData and savedData.key then
        print("[Save System] Loaded saved key: " .. savedData.key)
        return savedData.key
    else
        print("[Save System] No saved key found")
        return nil
    end
end

-- Функция для очистки ключа
local function clearKey()
    local success, errorMessage = pcall(function()
        keyStore:RemoveAsync(userId)
    end)
    
    if success then
        print("[Save System] Key cleared")
        return true
    else
        print("[Save System] Error clearing key: " .. tostring(errorMessage))
        return false
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
        showMessage("Script load error: " .. tostring(errorMsg), Color3.fromRGB(255, 50, 50))
    end
end

-- Автоматическая проверка сохраненного ключа
local function autoCheckSavedKey()
    local savedKey = loadKey()
    
    if savedKey then
        print("[Auto Check] Found saved key, verifying...")
        showMessage("Found saved key, verifying...", Color3.fromRGB(255, 255, 0))
        
        keyInput.Text = savedKey
        submitBtn.Text = "Verifying..."
        submitBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
        rotationSpeed = 3
        
        local isValid = verifyKey(savedKey)
        
        if isValid then
            showMessage("Key verified! Starting Draconic Hub...", Color3.fromRGB(50, 255, 50))
            task.wait(1.5)
            executeScript()
            return true
        else
            showMessage("Saved key is no longer valid", Color3.fromRGB(255, 50, 50))
            clearKey()
            keyInput.Text = ""
            submitBtn.Text = "Submit"
            submitBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            rotationSpeed = 0.5
            return false
        end
    end
    
    return false
end

--- ПЕРЕТАСКИВАНИЕ ИНТЕРФЕЙСА ---
local dragging = false
local dragInput
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
local function setupDragging(frame)
    frame.InputBegan:Connect(function(input)
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
    
    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
end

setupDragging(mainFrame)
setupDragging(titleLabel)
setupDragging(logoContainer)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        updateDrag(input)
    end
end)

--- ФУНКЦИОНАЛ КНОПОК ---

submitBtn.MouseButton1Click:Connect(function()
    local enteredKey = keyInput.Text
    
    if enteredKey == "" then
        showMessage("Please enter a key!", Color3.fromRGB(255, 255, 0))
        return
    end
    
    print("[Submit] Verifying key: " .. enteredKey)
    
    submitBtn.Text = "Verifying..."
    submitBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    rotationSpeed = 3
    
    local isValid = verifyKey(enteredKey)
    
    if isValid then
        -- Сохраняем ключ
        local saveSuccess = saveKey(enteredKey)
        
        if saveSuccess then
            showMessage("Key accepted and saved! Starting Draconic Hub...", Color3.fromRGB(50, 255, 50))
        else
            showMessage("Key accepted! Starting Draconic Hub...", Color3.fromRGB(50, 255, 50))
        end
        
        task.wait(1.5)
        executeScript()
    else
        showMessage("Invalid key! Get a key by clicking Get Key", Color3.fromRGB(255, 50, 50))
        
        local originalPos = keyInput.Position
        for i = 1, 5 do
            keyInput.Position = UDim2.new(0.5, -325 + math.random(-5, 5), 0, 155 + math.random(-2, 2))
            task.wait(0.05)
        end
        keyInput.Position = originalPos
        
        submitBtn.Text = "Submit"
        submitBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        rotationSpeed = 0.5
    end
end)

-- Кнопка Get Key
getKeyBtn.MouseButton1Click:Connect(function()
    print("[Get Key] Requesting key link...")
    
    local originalSpeed = rotationSpeed
    rotationSpeed = 3
    
    local success, result = copyLink()
    
    if success then
        showMessage("Link copied to clipboard!", Color3.fromRGB(50, 150, 255))
        
        pcall(function()
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Draconic Hub",
                Text = "Key link copied to clipboard!",
                Duration = 3
            })
        end)
    else
        showMessage("Error: " .. tostring(result), Color3.fromRGB(255, 50, 50))
    end
    
    task.wait(2)
    rotationSpeed = originalSpeed
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

-- Эффекты лого
logoContainer.MouseEnter:Connect(function()
    rotationSpeed = 2
    mainLogo.ImageTransparency = 0.2
end)

logoContainer.MouseLeave:Connect(function()
    rotationSpeed = 0.5
    mainLogo.ImageTransparency = 0
end)

-- Кнопка очистки ключа
local clearKeyBtn = Instance.new("TextButton")
clearKeyBtn.Size = UDim2.new(0, 50, 0, 30)
clearKeyBtn.Position = UDim2.new(1, -60, 0, 10)
clearKeyBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
clearKeyBtn.Text = "X"
clearKeyBtn.Font = Enum.Font.SourceSansBold
clearKeyBtn.TextSize = 20
clearKeyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
clearKeyBtn.Visible = false
clearKeyBtn.Parent = mainFrame

local clearKeyCorner = Instance.new("UICorner")
clearKeyCorner.CornerRadius = UDim.new(0, 10)
clearKeyCorner.Parent = clearKeyBtn

clearKeyBtn.MouseButton1Click:Connect(function()
    local success = clearKey()
    
    if success then
        showMessage("Saved key cleared!", Color3.fromRGB(255, 150, 50))
        keyInput.Text = ""
        clearKeyBtn.Visible = false
    else
        showMessage("Error clearing key", Color3.fromRGB(255, 50, 50))
    end
end)

-- Управление интерфейсом с ESC
local userInputService = game:GetService("UserInputService")
local guiVisible = true

userInputService.InputBegan:Connect(function(input, gameProcessed)
    if input.KeyCode == Enum.KeyCode.Escape then
        guiVisible = not guiVisible
        screenGui.Enabled = guiVisible
    end
end)

-- Автоматическая проверка при запуске
task.spawn(function()
    task.wait(1)
    local savedKey = loadKey()
    if savedKey then
        clearKeyBtn.Visible = true
        keyInput.Text = savedKey
    end
    
    task.wait(1)
    if not autoCheckSavedKey() then
        showMessage("Enter your key to access Draconic Hub X", Color3.fromRGB(255, 255, 255))
    end
end)

print("=== Draconic Hub X Key System ===")
print("Integrated with Platoboost Key System")
print("Service ID: " .. service)
print("Auto-save system: Enabled")
print("ESC - Hide/Show menu")
print("=================================")