-- Создаем основной интерфейс
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "DraconicHubGui"
screenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")

-- Главный контейнер (Красное окно) с ЧЕРНОЙ ЖИРНОЙ ОБВОДКОЙ
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 700, 0, 350) -- Сделал больше
mainFrame.Position = UDim2.new(0.5, -350, 0.5, -170)
mainFrame.BackgroundColor3 = Color3.fromRGB(220, 20, 20) -- Красный цвет
mainFrame.BackgroundTransparency = 0.3 -- Полупрозрачный фон меню
mainFrame.BorderSizePixel = 5 -- ЖИРНАЯ черная обводка (увеличил до 5)
mainFrame.BorderColor3 = Color3.fromRGB(0, 0, 0) -- Черный цвет обводки
mainFrame.Active = true -- Добавляем возможность активности
mainFrame.Selectable = true -- Делаем выбираемым
mainFrame.Parent = screenGui

-- Скругление углов для главного окна
local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 15)
uiCorner.Parent = mainFrame

-- Контейнер для анимированного лого
local logoContainer = Instance.new("Frame")
logoContainer.Name = "LogoContainer"
logoContainer.Size = UDim2.new(0, 180, 0, 180) -- Увеличил для вращающегося фона
logoContainer.Position = UDim2.new(0.5, -90, 0, -100) -- Центрируем
logoContainer.BackgroundTransparency = 1
logoContainer.Parent = mainFrame

-- Вращающийся фон (изображение 105848999222798)
local spinningBackground = Instance.new("ImageLabel")
spinningBackground.Name = "SpinningBackground"
spinningBackground.Size = UDim2.new(1.5, 0, 1.5, 0) -- Увеличил размер
spinningBackground.AnchorPoint = Vector2.new(0.5, 0.5)
spinningBackground.Position = UDim2.new(0.5, 0, 0.5, 0)
spinningBackground.BackgroundTransparency = 1
spinningBackground.Image = "rbxassetid://105848999222798"
spinningBackground.ImageTransparency = 0.3 -- Немного прозрачный
spinningBackground.ZIndex = 1
spinningBackground.Parent = logoContainer

-- Основное лого (изображение 130570278955508)
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

-- Заголовок (Draconic Hub X Key System)
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(0, 660, 0, 50) -- Сделал больше
titleLabel.Position = UDim2.new(0.5, -325, 0, 90) -- Изменил позицию из-за нового лого
titleLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.Text = "Draconic Hub X Key System"
titleLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.TextSize = 40 -- Увеличил
titleLabel.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 20)
titleCorner.Parent = titleLabel

-- Поле ввода ключа (Enter Key Here)
local keyInput = Instance.new("TextBox")
keyInput.Size = UDim2.new(0, 660, 0, 50) -- Сделал больше
keyInput.Position = UDim2.new(0.5, -325, 0, 155) -- Изменил позицию
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
submitBtn.Size = UDim2.new(0, 260, 0, 60) -- Сделал больше
submitBtn.Position = UDim2.new(0, 25, 0, 220) -- Изменил позицию
submitBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
submitBtn.Text = "Submit"
submitBtn.Font = Enum.Font.SourceSansBold
submitBtn.TextSize = 35 -- Увеличил
submitBtn.Parent = mainFrame

local submitCorner = Instance.new("UICorner")
submitCorner.CornerRadius = UDim.new(0, 20)
submitCorner.Parent = submitBtn

-- Кнопка Get Key
local getKeyBtn = Instance.new("TextButton")
getKeyBtn.Size = UDim2.new(0, 260, 0, 60) -- Сделал больше
getKeyBtn.Position = UDim2.new(0, 420, 0, 220) -- Изменил позицию
getKeyBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
getKeyBtn.Text = "Get Key"
getKeyBtn.Font = Enum.Font.SourceSansBold
getKeyBtn.TextSize = 35 -- Увеличил
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
local rotationSpeed = 0.5 -- Скорость вращения (градусов в кадр)
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

--- Platoboost Key System Integration ---
local platoboostService = 16094;  -- ваш service id
local platoboostSecret = "9bfce86e-a6fc-4baf-93d8-4d77a2254e41";
local useNonce = true;

-- Platoboost functions
local function lEncode(data)
    return game:GetService("HttpService"):JSONEncode(data)
end

local function lDecode(data)
    return game:GetService("HttpService"):JSONDecode(data)
end

local function lDigest(input)
    -- Простая хеш-функция (можно заменить на более безопасную)
    local hash = 0
    for i = 1, #input do
        hash = (hash * 31 + string.byte(input, i)) % 2^32
    end
    return tostring(hash)
end

-- Основные функции Platoboost
local requestSending = false;
local fSetClipboard = setclipboard or toclipboard or writeclipboard
local fRequest = request or http_request or syn.request or http.request
local fStringChar = string.char
local fToString = tostring
local fStringSub = string.sub
local fOsTime = os.time
local fMathRandom = math.random
local fMathFloor = math.floor
local fGetHwid = gethwid or function() 
    return game:GetService("Players").LocalPlayer.UserId 
end

--! pick host
local host = "https://api.platoboost.com"
local hostResponse = fRequest({
    Url = host .. "/public/connectivity",
    Method = "GET"
})
if hostResponse and hostResponse.StatusCode ~= 200 and hostResponse.StatusCode ~= 429 then
    host = "https://api.platoboost.net"
end

-- Функция для генерации nonce
local function generateNonce()
    local str = ""
    for _ = 1, 16 do
        str = str .. fStringChar(fMathFloor(fMathRandom() * (122 - 97 + 1)) + 97)
    end
    return str
end

-- Кэширование ссылки
local cachedLink, cachedTime = "", 0
local function cacheLink()
    if cachedTime + (10*60) < fOsTime() then
        local response = fRequest({
            Url = host .. "/public/start",
            Method = "POST",
            Body = lEncode({
                service = platoboostService,
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
                return false, decoded.message or "Failed to get link"
            end
        elseif response and response.StatusCode == 429 then
            return false, "You are being rate limited, please wait 20 seconds and try again."
        end
        return false, "Failed to cache link."
    else
        return true, cachedLink
    end
end

-- Функция для копирования ссылки
local function copyPlatoboostLink()
    local success, link = cacheLink()
    
    if success then
        if fSetClipboard then
            fSetClipboard(link)
        end
        return true, link
    else
        return false, link
    end
end

-- Функция для проверки ключа
local function verifyPlatoboostKey(key)
    if requestSending == true then
        return false, "A request is already being sent, please slow down."
    else
        requestSending = true
    end

    local nonce = generateNonce()
    local endpoint = host .. "/public/whitelist/" .. fToString(platoboostService) .. "?identifier=" .. lDigest(fGetHwid()) .. "&key=" .. key

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
                    if decoded.data.hash == lDigest("true" .. "-" .. nonce .. "-" .. platoboostSecret) then
                        return true, "Key is valid"
                    else
                        return false, "Failed to verify integrity."
                    end
                else
                    return true, "Key is valid"
                end
            else
                return false, "Key is invalid."
            end
        else
            return false, decoded.message or "Verification failed"
        end
    elseif response and response.StatusCode == 429 then
        return false, "You are being rate limited, please wait 20 seconds and try again."
    else
        return false, "Server returned an invalid status code, please try again later."
    end
end

-- Инициализация Platoboost
cacheLink()

-- Функция для показа сообщения
local function showMessage(text, color)
    errorLabel.Text = text
    errorLabel.TextColor3 = color
    errorLabel.Visible = true
    
    task.wait(3) -- Показываем сообщение 3 секунды
    errorLabel.Visible = false
end

-- Функция для запуска скрипта
local function executeScript()
    -- Останавливаем анимацию лого
    rotationSpeed = 0
    
    -- Скрываем интерфейс
    screenGui.Enabled = false
    
    -- Запускаем основной скрипт
    local success, errorMsg = pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Gameidkdmekl/Testing/refs/heads/main/Overhaul.lua"))()
    end)
    
    if not success then
        -- Если скрипт не запустился, показываем интерфейс снова
        screenGui.Enabled = true
        rotationSpeed = 0.5 -- Возвращаем анимацию
        showMessage("Ошибка загрузки скрипта: " .. errorMsg, Color3.fromRGB(255, 50, 50))
    end
end

--- Функционал кнопок ---

submitBtn.MouseButton1Click:Connect(function()
    local enteredKey = keyInput.Text
    
    if enteredKey == "" then
        showMessage("Пожалуйста, введите ключ!", Color3.fromRGB(255, 255, 0))
        return
    end
    
    print("Проверка ключа Platoboost: " .. enteredKey)
    
    -- Проверяем ключ через Platoboost
    local success, message = verifyPlatoboostKey(enteredKey)
    
    if success then
        showMessage("Ключ принят! Запускаю Draconic Hub...", Color3.fromRGB(50, 255, 50))
        
        -- Меняем текст кнопки
        submitBtn.Text = "Loading..."
        submitBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
        
        -- Увеличиваем скорость вращения лого при загрузке
        rotationSpeed = 5
        
        -- Ждем немного для визуального эффекта
        task.wait(1)
        
        -- Запускаем скрипт
        executeScript()
    else
        showMessage("Неверный ключ! " .. message, Color3.fromRGB(255, 50, 50))
        
        -- Эффект тряски при неверном ключе
        local originalPos = keyInput.Position
        for i = 1, 5 do
            keyInput.Position = UDim2.new(0.5, -325 + math.random(-5, 5), 0, 155 + math.random(-2, 2))
            task.wait(0.05)
        end
        keyInput.Position = originalPos
        keyInput.Text = ""
    end
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
    rotationSpeed = 2 -- Увеличиваем скорость при наведении
    mainLogo.ImageTransparency = 0.2 -- Немного затемняем основное лого
end)

logoContainer.MouseLeave:Connect(function()
    rotationSpeed = 0.5 -- Возвращаем нормальную скорость
    mainLogo.ImageTransparency = 0 -- Возвращаем прозрачность
end)

getKeyBtn.MouseButton1Click:Connect(function()
    print("Получение ссылки Platoboost...")
    
    -- Эффект на лого
    local originalSpeed = rotationSpeed
    rotationSpeed = 3 -- Увеличиваем скорость вращения
    
    -- Получаем ссылку от Platoboost
    local success, linkOrMessage = copyPlatoboostLink()
    
    if success then
        showMessage("Ссылка скопирована в буфер обмена!", Color3.fromRGB(50, 150, 255))
        
        -- Показываем уведомление
        local notifySuccess = pcall(function()
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Draconic Hub",
                Text = "Ссылка скопирована!",
                Duration = 3
            })
        end)
    else
        showMessage("Ошибка: " .. linkOrMessage, Color3.fromRGB(255, 50, 50))
    end
    
    -- Возвращаем нормальную скорость через 2 секунды
    task.wait(2)
    rotationSpeed = originalSpeed
end)

-- Перетаскивание окна (ваш существующий код остается без изменений)
-- ... (код перетаскивания остается прежним)

-- Добавляем возможность закрытия интерфейса на ESC
local userInputService = game:GetService("UserInputService")
local guiVisible = true

userInputService.InputBegan:Connect(function(input, gameProcessed)
    if input.KeyCode == Enum.KeyCode.Escape then
        guiVisible = not guiVisible
        screenGui.Enabled = guiVisible
    end
end)

-- Информационное сообщение при запуске
task.spawn(function()
    task.wait(1)
    showMessage("Введите ключ для доступа к Draconic Hub X", Color3.fromRGB(255, 255, 255))
end)

print("Draconic Hub X Key System загружен!")
print("Используется система ключей Platoboost")
print("Service ID: " .. platoboostService)
print("Перетаскивайте меню за любую часть (кроме кнопок и полей ввода)")
print("ESC - скрыть/показать меню")
print("Анимированное лого загружено и вращается!")