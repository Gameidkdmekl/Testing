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
local service = 16094
local secret = "9bfce86e-a6fc-4baf-93d8-4d77a2254e41"
local useNonce = true

-- Утилиты
local HttpService = game:GetService("HttpService")

--! Вспомогательные функции
local fSetClipboard = setclipboard or toclipboard or writeclipboard or (syn and syn.write_clipboard)
local fRequest = request or http_request or (syn and syn.request) or (http and http.request)
local fStringChar = string.char
local fToString = tostring
local fStringSub = string.sub
local fOsTime = os.time
local fMathRandom = math.random
local fMathFloor = math.floor
local fGetHwid = gethwid or function() 
    -- Пробуем разные методы получения HWID
    local hwidFuncs = {
        syn and syn.crypt and syn.crypt.custom_hash and function() 
            return tostring(syn.crypt.custom_hash("md5", tostring(game:GetService("Players").LocalPlayer.UserId)))
        end,
        function() return tostring(game:GetService("Players").LocalPlayer.UserId) end
    }
    
    for _, func in ipairs(hwidFuncs) do
        if type(func) == "function" then
            local success, result = pcall(func)
            if success then
                return result
            end
        end
    end
    
    return tostring(game:GetService("Players").LocalPlayer.UserId)
end

-- JSON функции
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

--! Конфигурация хоста
local host = "https://api.platoboost.com"

-- Проверяем подключение к основному хосту
if fRequest then
    local hostResponse = fRequest({
        Url = host .. "/public/connectivity",
        Method = "GET"
    })
    
    if hostResponse and (hostResponse.StatusCode ~= 200 and hostResponse.StatusCode ~= 429) then
        host = "https://api.platoboost.net"
    end
end

--! Кэширование ссылки
local cachedLink, cachedTime = "", 0
local requestSending = false

local function cacheLink()
    if requestSending then
        return false, "A request is already being sent"
    end
    
    if cachedTime + (10 * 60) > fOsTime() and cachedLink ~= "" then
        return true, cachedLink
    end
    
    requestSending = true
    
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
    
    requestSending = false
    
    if response and response.StatusCode == 200 then
        local decoded = lDecode(response.Body)
        
        if decoded and decoded.success == true then
            cachedLink = decoded.data.url
            cachedTime = fOsTime()
            return true, cachedLink
        else
            return false, decoded and decoded.message or "Failed to get link"
        end
    elseif response and response.StatusCode == 429 then
        return false, "You are being rate limited, please wait 20 seconds"
    else
        return false, "Failed to connect to Platoboost servers"
    end
end

--! Генерация nonce
local function generateNonce()
    local str = ""
    for _ = 1, 16 do
        str = str .. fStringChar(fMathFloor(fMathRandom() * (122 - 97 + 1)) + 97)
    end
    return str
end

--! Проверка nonce (убеждаемся, что каждый раз генерируется новый)
for _ = 1, 5 do
    local oNonce = generateNonce()
    task.wait(0.2)
    if generateNonce() == oNonce then
        error("Platoboost nonce error")
    end
end

--! Проверка ключа
local function verifyKey(key)
    if requestSending == true then
        return false, "A request is already being sent, please slow down"
    end
    
    if key == "" or key == nil then
        return false, "Please enter a key"
    end
    
    requestSending = true
    
    local nonce = generateNonce()
    local endpoint = host .. "/public/whitelist/" .. fToString(service) .. "?identifier=" .. lDigest(fGetHwid()) .. "&key=" .. key
    
    if useNonce then
        endpoint = endpoint .. "&nonce=" .. nonce
    end
    
    local response = fRequest({
        Url = endpoint,
        Method = "GET"
    })
    
    requestSending = false
    
    if not response then
        return false, "Failed to connect to server"
    end
    
    if response.StatusCode == 200 then
        local decoded = lDecode(response.Body)
        
        if decoded and decoded.success == true then
            if decoded.data.valid == true then
                if useNonce then
                    if decoded.data.hash == lDigest("true" .. "-" .. nonce .. "-" .. secret) then
                        return true, "Key verified successfully!"
                    else
                        return false, "Failed to verify integrity"
                    end
                else
                    return true, "Key verified successfully!"
                end
            else
                -- Если ключ начинается с KEY_, пробуем его активировать
                if fStringSub(key, 1, 4) == "KEY_" then
                    -- Функция активации ключа
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
                            
                            if decoded and decoded.success == true then
                                if decoded.data.valid == true then
                                    if useNonce then
                                        if decoded.data.hash == lDigest("true" .. "-" .. nonce .. "-" .. secret) then
                                            return true, "Key activated successfully!"
                                        else
                                            return false, "Failed to verify activation integrity"
                                        end
                                    else
                                        return true, "Key activated successfully!"
                                    end
                                else
                                    return false, "Key is invalid"
                                end
                            else
                                if decoded and fStringSub(decoded.message, 1, 27) == "unique constraint violation" then
                                    return false, "You already have an active key, please wait for it to expire"
                                else
                                    return false, decoded and decoded.message or "Activation failed"
                                end
                            end
                        elseif response and response.StatusCode == 429 then
                            return false, "You are being rate limited, please wait 20 seconds"
                        else
                            return false, "Server returned an invalid status code"
                        end
                    end
                    
                    local success, message = redeemKey(key)
                    return success, message
                else
                    return false, "Key is invalid"
                end
            end
        else
            return false, decoded and decoded.message or "Verification failed"
        end
    elseif response.StatusCode == 429 then
        return false, "You are being rate limited, please wait 20 seconds"
    else
        return false, "Server error: " .. tostring(response.StatusCode)
    end
end

--! Получение флага
local function getFlag(name)
    local nonce = generateNonce()
    local endpoint = host .. "/public/flag/" .. fToString(service) .. "?name=" .. name
    
    if useNonce then
        endpoint = endpoint .. "&nonce=" .. nonce
    end
    
    local response = fRequest({
        Url = endpoint,
        Method = "GET"
    })
    
    if response and response.StatusCode == 200 then
        local decoded = lDecode(response.Body)
        
        if decoded and decoded.success == true then
            if useNonce then
                if decoded.data.hash == lDigest(fToString(decoded.data.value) .. "-" .. nonce .. "-" .. secret) then
                    return decoded.data.value
                else
                    return nil
                end
            else
                return decoded.data.value
            end
        end
    end
    
    return nil
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
    
    -- Получаем флаг для ссылки на скрипт
    local scriptUrl = getFlag("script_url")
    if not scriptUrl then
        scriptUrl = "https://raw.githubusercontent.com/Gameidkdmekl/Testing/refs/heads/main/Overhaul.lua"
    end
    
    showMessage("Loading Draconic Hub...", Color3.fromRGB(0, 255, 0))
    
    local success, errorMsg = pcall(function()
        -- Загружаем скрипт хаба
        loadstring(game:HttpGet(scriptUrl))()
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

-- Кнопка Submit
submitBtn.MouseButton1Click:Connect(function()
    local enteredKey = keyInput.Text
    
    if enteredKey == "" then
        showMessage("Please enter a key!", Color3.fromRGB(255, 255, 0))
        return
    end
    
    submitBtn.Text = "Checking..."
    submitBtn.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    submitBtn.TextSize = 30
    
    task.spawn(function()
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
            for i = 1, 5 do
                keyInput.Position = UDim2.new(0.5, -325 + math.random(-5, 5), 0, 155 + math.random(-2, 2))
                task.wait(0.05)
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
    getKeyBtn.Text = "Getting Link..."
    getKeyBtn.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    getKeyBtn.TextSize = 30
    rotationSpeed = 2
    
    task.spawn(function()
        task.wait(0.5)
        
        local success, link = cacheLink()
        
        if success then
            -- Пробуем открыть ссылку
            local opened = false
            
            if fSetClipboard then
                fSetClipboard(link)
                showMessage("Link copied to clipboard!", Color3.fromRGB(50, 150, 255))
                opened = true
            end
            
            -- Показываем уведомление
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Draconic Hub",
                Text = "Key link copied! Paste in browser",
                Duration = 5
            })
            
            -- Также показываем ссылку в сообщении
            if not opened then
                showMessage("Link: " .. link, Color3.fromRGB(50, 150, 255))
            end
        else
            showMessage("Error: " .. link, Color3.fromRGB(255, 50, 50))
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
    end
end)

-- Информационное сообщение
task.spawn(function()
    task.wait(1)
    showMessage("Click 'Get Key' to obtain an access key", Color3.fromRGB(255, 255, 255))
end)

-- Обработка нажатия Enter в поле ввода
keyInput.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        submitBtn.MouseButton1Click:Fire()
    end
end)

-- Предзагрузка ссылки
task.spawn(function()
    task.wait(2)
    cacheLink()
end)

print("=======================================")
print("DRACONIC HUB X - PLATOBOOST INTEGRATION")
print("=======================================")
print("Service ID:", service)
print("Host:", host)
print("=======================================")
print("Key system ready!")
print("=======================================")