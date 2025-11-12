local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")

local function CreateSection(parent, titleKey, GetText)
    local Section = Instance.new("Frame")
    Section.Name = titleKey .. "Section"
    Section.Size = UDim2.new(0.95, 0, 0, 40)
    Section.BackgroundColor3 = Color3.fromRGB(20, 25, 40)
    Section.BorderSizePixel = 0

    local SectionCorner = Instance.new("UICorner")
    SectionCorner.CornerRadius = UDim.new(0, 8)
    SectionCorner.Parent = Section

    local SectionTitle = Instance.new("TextLabel")
    SectionTitle.Name = "SectionTitle"
    SectionTitle.Size = UDim2.new(1, -20, 1, 0)
    SectionTitle.Position = UDim2.new(0, 10, 0, 0)
    SectionTitle.BackgroundTransparency = 1
    SectionTitle.Text = "🔹 " .. GetText(titleKey)
    SectionTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    SectionTitle.TextSize = 14
    SectionTitle.Font = Enum.Font.GothamBold
    SectionTitle.TextXAlignment = Enum.TextXAlignment.Left

    SectionTitle.Parent = Section
    Section.Parent = parent

    return Section
end

local function CreateToggle(parent, textKey, initialState, callback, GetText, showNotification)
    local translatedText = GetText(textKey)
    
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Name = textKey .. "Toggle"
    ToggleFrame.Size = UDim2.new(0.9, 0, 0, 35)
    ToggleFrame.BackgroundTransparency = 1
    ToggleFrame.BorderSizePixel = 0

    local ToggleLabel = Instance.new("TextLabel")
    ToggleLabel.Name = "Label"
    ToggleLabel.Size = UDim2.new(0.7, 0, 1, 0)
    ToggleLabel.Position = UDim2.new(0, 0, 0, 0)
    ToggleLabel.BackgroundTransparency = 1
    ToggleLabel.Text = " " .. translatedText
    ToggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleLabel.TextSize = 13
    ToggleLabel.Font = Enum.Font.Gotham
    ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left

    local ToggleButton = Instance.new("TextButton")
    ToggleButton.Name = "Toggle"
    ToggleButton.Size = UDim2.new(0, 50, 0, 25)
    ToggleButton.Position = UDim2.new(1, -55, 0.5, -12.5)
    ToggleButton.BackgroundColor3 = initialState and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
    ToggleButton.BorderSizePixel = 0
    ToggleButton.Text = initialState and "ON" or "OFF"
    ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleButton.TextSize = 11
    ToggleButton.Font = Enum.Font.GothamBold
    ToggleButton.AutoButtonColor = false

    local ToggleCorner = Instance.new("UICorner")
    ToggleCorner.CornerRadius = UDim.new(0, 6)
    ToggleCorner.Parent = ToggleButton

    local currentState = initialState

    ToggleButton.MouseButton1Click:Connect(function()
        currentState = not currentState
        ToggleButton.BackgroundColor3 = currentState and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
        ToggleButton.Text = currentState and "ON" or "OFF"

        if callback then
            callback(currentState)
        end
        local statusText = currentState and GetText("notify_enabled") or GetText("notify_disabled")
        showNotification(translatedText .. ": " .. statusText)
    end)

    ToggleLabel.Parent = ToggleFrame
    ToggleButton.Parent = ToggleFrame
    ToggleFrame.Parent = parent

    return ToggleFrame
end

local function CreateToggleWithSettings(parent, textKey, initialState, callback, settingsElements, GetText, showNotification)
    local translatedText = GetText(textKey)
    
    local ControlFrame = Instance.new("Frame")
    ControlFrame.Name = textKey .. "Control"
    ControlFrame.Size = UDim2.new(0.95, 0, 0, 40)
    ControlFrame.BackgroundTransparency = 1
    ControlFrame.Parent = parent

    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Name = "ToggleArea"
    ToggleFrame.Size = UDim2.new(0.75, 0, 1, 0)
    ToggleFrame.BackgroundTransparency = 1
    ToggleFrame.Parent = ControlFrame

    local ToggleLabel = Instance.new("TextLabel")
    ToggleLabel.Name = "Label"
    ToggleLabel.Size = UDim2.new(0.7, 0, 1, 0)
    ToggleLabel.Position = UDim2.new(0, 0, 0, 0)
    ToggleLabel.BackgroundTransparency = 1
    ToggleLabel.Text = " " .. translatedText
    ToggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleLabel.TextSize = 13
    ToggleLabel.Font = Enum.Font.Gotham
    ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
    ToggleLabel.Parent = ToggleFrame

    local ToggleButton = Instance.new("TextButton")
    ToggleButton.Name = "Toggle"
    ToggleButton.Size = UDim2.new(0, 50, 0, 25)
    ToggleButton.Position = UDim2.new(1, -55, 0.5, -12.5)
    ToggleButton.BackgroundColor3 = initialState and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
    ToggleButton.BorderSizePixel = 0
    ToggleButton.Text = initialState and "ON" or "OFF"
    ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleButton.TextSize = 11
    ToggleButton.Font = Enum.Font.GothamBold
    ToggleButton.AutoButtonColor = false
    ToggleButton.Parent = ToggleFrame

    local ToggleCorner = Instance.new("UICorner")
    ToggleCorner.CornerRadius = UDim.new(0, 6)
    ToggleCorner.Parent = ToggleButton

    local currentState = initialState

    ToggleButton.MouseButton1Click:Connect(function()
        currentState = not currentState
        ToggleButton.BackgroundColor3 = currentState and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
        ToggleButton.Text = currentState and "ON" or "OFF"

        if callback then
            callback(currentState)
        end
        local statusText = currentState and GetText("notify_enabled") or GetText("notify_disabled")
        showNotification(translatedText .. ": " .. statusText)
    end)

    local SettingsButton = Instance.new("TextButton")
    SettingsButton.Name = "SettingsButton"
    SettingsButton.Size = UDim2.new(0, 35, 0, 25)
    SettingsButton.Position = UDim2.new(1, -55, 0.5, -12.5)
    SettingsButton.BackgroundColor3 = Color3.fromRGB(40, 45, 60)
    SettingsButton.BorderSizePixel = 0
    SettingsButton.Text = "⚙️"
    SettingsButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    SettingsButton.TextSize = 18
    SettingsButton.Font = Enum.Font.Gotham
    SettingsButton.AutoButtonColor = false
    local SettingsCorner = Instance.new("UICorner")
    SettingsCorner.CornerRadius = UDim.new(0, 6)
    SettingsCorner.Parent = SettingsButton
    SettingsButton.Parent = ControlFrame

    local SettingsContainer = Instance.new("Frame")
    SettingsContainer.Name = textKey .. "_SettingsContainer"
    SettingsContainer.Size = UDim2.new(0.9, 0, 0, 1)
    SettingsContainer.BackgroundTransparency = 1
    SettingsContainer.Visible = false
    SettingsContainer.ClipsDescendants = true
    SettingsContainer.Parent = parent

    local SettingsLayout = Instance.new("UIListLayout")
    SettingsLayout.Parent = SettingsContainer
    SettingsLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    SettingsLayout.SortOrder = Enum.SortOrder.LayoutOrder
    SettingsLayout.Padding = UDim.new(0, 8)

    for _, element in ipairs(settingsElements) do
        element.Parent = SettingsContainer
    end

    SettingsButton.MouseButton1Click:Connect(function()
        local isVisible = SettingsContainer.Visible
        local targetHeight = isVisible and 1 or SettingsLayout.AbsoluteContentSize.Y + 10
        local targetVisibility = not isVisible

        local tween = TweenService:Create(SettingsContainer, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(0.9, 0, 0, targetHeight)
        })

        if targetVisibility then
            SettingsContainer.Visible = true
            tween:Play()
        else
            local connection
            connection = tween.Completed:Connect(function()
                SettingsContainer.Visible = false
                connection:Disconnect()
            end)
            tween:Play()
        end
    end)

    return ControlFrame
end

local function CreateDropdown(parent, textKey, options, initialValue, callback, optionsAreKeys, GetText)
    local DropdownFrame = Instance.new("Frame")
    DropdownFrame.Name = textKey .. "Dropdown"
    DropdownFrame.Size = UDim2.new(0.9, 0, 0, 35)
    DropdownFrame.BackgroundTransparency = 1
    DropdownFrame.Parent = parent

    local DropdownLabel = Instance.new("TextLabel")
    DropdownLabel.Name = "Label"
    DropdownLabel.Size = UDim2.new(0.5, 0, 1, 0)
    DropdownLabel.Position = UDim2.new(0, 0, 0, 0)
    DropdownLabel.BackgroundTransparency = 1
    DropdownLabel.Text = GetText("dropdown_label", GetText(textKey))
    DropdownLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    DropdownLabel.TextSize = 13
    DropdownLabel.Font = Enum.Font.Gotham
    DropdownLabel.TextXAlignment = Enum.TextXAlignment.Left
    DropdownLabel.Parent = DropdownFrame

    local DropdownButton = Instance.new("TextButton")
    DropdownButton.Name = "Button"
    DropdownButton.Size = UDim2.new(0.4, 0, 1, 0)
    DropdownButton.Position = UDim2.new(0.6, 0, 0, 0)
    DropdownButton.BackgroundColor3 = Color3.fromRGB(40, 45, 60)
    DropdownButton.BorderSizePixel = 0
    DropdownButton.Text = optionsAreKeys and GetText(initialValue) or initialValue
    DropdownButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    DropdownButton.TextSize = 11
    DropdownButton.Font = Enum.Font.GothamBold
    DropdownButton.AutoButtonColor = false
    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim.new(0, 6)
    ButtonCorner.Parent = DropdownButton
    DropdownButton.Parent = DropdownFrame

    local DropdownList = Instance.new("ScrollingFrame")
    DropdownList.Name = "List"
    DropdownList.Size = UDim2.new(0.4, 0, 0, 1)
    DropdownList.Position = UDim2.new(0.6, 0, 1, 5)
    DropdownList.BackgroundTransparency = 0.1
    DropdownList.BackgroundColor3 = Color3.fromRGB(40, 45, 60)
    DropdownList.BorderSizePixel = 0
    DropdownList.ScrollBarThickness = 4
    DropdownList.ScrollBarImageColor3 = Color3.fromRGB(0, 180, 255)
    DropdownList.Visible = false
    DropdownList.ZIndex = 3
    DropdownList.Parent = DropdownFrame

    local ListLayout = Instance.new("UIListLayout")
    ListLayout.Parent = DropdownList
    ListLayout.FillDirection = Enum.FillDirection.Vertical
    ListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    ListLayout.Padding = UDim.new(0, 1)

    local listHeight = 0

    for i, optionKey in ipairs(options) do
        local translatedOption = optionsAreKeys and GetText(optionKey) or optionKey

        local ListItem = Instance.new("TextButton")
        ListItem.Name = "Item" .. i
        ListItem.Size = UDim2.new(1, 0, 0, 30)
        ListItem.BackgroundColor3 = Color3.fromRGB(40, 45, 60)
        ListItem.BorderSizePixel = 0
        ListItem.Text = translatedOption
        ListItem.TextColor3 = Color3.fromRGB(255, 255, 255)
        ListItem.TextSize = 11
        ListItem.Font = Enum.Font.Gotham
        ListItem.AutoButtonColor = false
        ListItem.Parent = DropdownList

        listHeight = listHeight + 30 + 1

        ListItem.MouseButton1Click:Connect(function()
            DropdownButton.Text = translatedOption

            local tween = TweenService:Create(DropdownList, TweenInfo.new(0.3), {
                Size = UDim2.new(0.4, 0, 0, 1)
            })
            tween:Play()
            tween.Completed:Connect(function()
                DropdownList.Visible = false
            end)

            if callback then
                callback(optionKey)
            end
        end)
    end

    DropdownList.CanvasSize = UDim2.new(0, 0, 0, listHeight)

    DropdownButton.MouseButton1Click:Connect(function()
        local isVisible = DropdownList.Visible
        local targetHeight = isVisible and 1 or math.min(listHeight, 4 * 31) 

        DropdownList.Visible = not isVisible

        local tween = TweenService:Create(DropdownList, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(0.4, 0, 0, targetHeight)
        })
        tween:Play()
    end)

    return DropdownFrame
end

local function CreateButton(parent, textKey, callback, GetText)
    local Button = Instance.new("TextButton")
    Button.Name = textKey .. "Button"
    Button.Size = UDim2.new(0.9, 0, 0, 40)
    Button.BackgroundColor3 = Color3.fromRGB(10, 10, 25)
    Button.BorderSizePixel = 0
    Button.Text = GetText(textKey)
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.TextSize = 13
    Button.Font = Enum.Font.GothamSemibold
    Button.AutoButtonColor = false

    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim.new(0, 8)
    ButtonCorner.Parent = Button

    Button.MouseButton1Click:Connect(function()
        if callback then
            callback()
        end
    end)

    Button.Parent = parent
    return Button
end

local function CreateSlider(parent, textKey, min, max, current, callback, GetText)
    local translatedText = GetText(textKey)
    
    local SliderFrame = Instance.new("Frame")
    SliderFrame.Name = textKey .. "Slider"
    SliderFrame.Size = UDim2.new(0.9, 0, 0, 60)
    SliderFrame.BackgroundTransparency = 1

    local SliderLabel = Instance.new("TextLabel")
    SliderLabel.Name = "Label"
    SliderLabel.Size = UDim2.new(1, 0, 0, 20)
    SliderLabel.Position = UDim2.new(0, 0, 0, 0)
    SliderLabel.BackgroundTransparency = 1
    SliderLabel.Text = GetText("slider_label", translatedText, current)
    SliderLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    SliderLabel.TextSize = 12
    SliderLabel.Font = Enum.Font.Gotham
    SliderLabel.TextXAlignment = Enum.TextXAlignment.Left

    local SliderTrack = Instance.new("Frame")
    SliderTrack.Name = "Track"
    SliderTrack.Size = UDim2.new(1, 0, 0, 6)
    SliderTrack.Position = UDim2.new(0, 0, 0, 35)
    SliderTrack.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    SliderTrack.BorderSizePixel = 0

    local TrackCorner = Instance.new("UICorner")
    TrackCorner.CornerRadius = UDim.new(0, 3)
    TrackCorner.Parent = SliderTrack

    local SliderFill = Instance.new("Frame")
    SliderFill.Name = "Fill"
    SliderFill.Size = UDim2.new((current - min) / (max - min), 0, 1, 0)
    SliderFill.Position = UDim2.new(0, 0, 0, 0)
    SliderFill.BackgroundColor3 = Color3.fromRGB(0, 180, 255)
    SliderFill.BorderSizePixel = 0

    local FillCorner = Instance.new("UICorner")
    FillCorner.CornerRadius = UDim.new(0, 3)
    FillCorner.Parent = SliderFill

    local SliderButton = Instance.new("TextButton")
    SliderButton.Name = "Button"
    SliderButton.Size = UDim2.new(0, 16, 0, 16)
    SliderButton.Position = UDim2.new((current - min) / (max - min), -8, 0, -5)
    SliderButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    SliderButton.BorderSizePixel = 0
    SliderButton.Text = ""
    SliderButton.AutoButtonColor = false

    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim.new(0, 8)
    ButtonCorner.Parent = SliderButton

    local dragging = false

    SliderButton.MouseButton1Down:Connect(function()
        dragging = true
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local mousePos = UserInputService:GetMouseLocation()
            local relPos = mousePos - SliderTrack.AbsolutePosition
            local fraction = math.clamp(relPos.X / SliderTrack.AbsoluteSize.X, 0, 1)
            local value = min + fraction * (max - min)
            value = math.round(value * 10) / 10

            SliderFill.Size = UDim2.new(fraction, 0, 1, 0)
            SliderButton.Position = UDim2.new(fraction, -8, 0, -5)
            SliderLabel.Text = GetText("slider_label", translatedText, value)

            if callback then
                callback(value)
            end
        end
    end)

    SliderLabel.Parent = SliderFrame
    SliderTrack.Parent = SliderFrame
    SliderFill.Parent = SliderTrack
    SliderButton.Parent = SliderTrack
    SliderFrame.Parent = parent

    return SliderFrame
end

local function CreateKeybindButton(parent, textKey, initialKey, callback, GetText, showNotification)
    local KeybindFrame = Instance.new("Frame")
    KeybindFrame.Name = textKey .. "Keybind"
    KeybindFrame.Size = UDim2.new(0.9, 0, 0, 35)
    KeybindFrame.BackgroundTransparency = 1

    local KeybindLabel = Instance.new("TextLabel")
    KeybindLabel.Name = "Label"
    KeybindLabel.Size = UDim2.new(0.6, 0, 1, 0)
    KeybindLabel.Position = UDim2.new(0, 0, 0, 0)
    KeybindLabel.BackgroundTransparency = 1
    KeybindLabel.Text = GetText(textKey)
    KeybindLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    KeybindLabel.TextSize = 13
    KeybindLabel.Font = Enum.Font.Gotham
    KeybindLabel.TextXAlignment = Enum.TextXAlignment.Left

    local KeybindButton = Instance.new("TextButton")
    KeybindButton.Name = "Keybind"
    KeybindButton.Size = UDim2.new(0.3, 0, 1, 0)
    KeybindButton.Position = UDim2.new(0.7, 0, 0, 0)
    KeybindButton.BackgroundColor3 = Color3.fromRGB(40, 45, 60)
    KeybindButton.BorderSizePixel = 0
    KeybindButton.Text = GetText("keybind_current", GetText(textKey), initialKey or GetText("keybind_none"))
    KeybindButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    KeybindButton.TextSize = 11
    KeybindButton.Font = Enum.Font.GothamBold
    KeybindButton.AutoButtonColor = false

    local KeyCorner = Instance.new("UICorner")
    KeyCorner.CornerRadius = UDim.new(0, 6)
    KeyCorner.Parent = KeybindButton

    local listening = false

    KeybindButton.MouseButton1Click:Connect(function()
        listening = true
        KeybindButton.Text = GetText("keybind_listening")
    end)

    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if listening and not gameProcessed and input.KeyCode ~= Enum.KeyCode.Unknown then
            local keyName = input.KeyCode.Name
            KeybindButton.Text = GetText("keybind_current", GetText(textKey), keyName)
            listening = false
            if callback then
                callback(keyName)
            end
            showNotification(GetText("notify_keybind_set", GetText(textKey), keyName))
        end
    end)

    KeybindLabel.Parent = KeybindFrame
    KeybindButton.Parent = KeybindFrame
    KeybindFrame.Parent = parent

    return KeybindFrame
end

local function CreateMainGUI(Mega, GetText, showNotification, ToggleMenu, recreateKitESP, resetKit, CreateESP, StartAimLoop, StopAimLoop, StartFollow, StopFollow, Cleanup, UpdatePlayerList)
    local TumbaGUI = Instance.new("ScreenGui")
    TumbaGUI.Name = "TumbaMegaSystem"
    TumbaGUI.Parent = CoreGui
    TumbaGUI.Enabled = false

    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, Mega.Settings.Menu.Width, 0, Mega.Settings.Menu.Height)
    MainFrame.Position = UDim2.new(0.5, -Mega.Settings.Menu.Width / 2, 0.5, -Mega.Settings.Menu.Height / 2)
    MainFrame.BackgroundColor3 = Mega.Settings.Menu.BackgroundColor
    MainFrame.BackgroundTransparency = Mega.Settings.Menu.Transparency
    MainFrame.BorderSizePixel = 0
    MainFrame.Active = true
    MainFrame.Draggable = true

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, Mega.Settings.Menu.CornerRadius)
    UICorner.Parent = MainFrame

    local Shadow = Instance.new("ImageLabel")
    Shadow.Name = "Shadow"
    Shadow.Size = UDim2.new(1, 20, 1, 20)
    Shadow.Position = UDim2.new(0, -10, 0, -10)
    Shadow.BackgroundTransparency = 1
    Shadow.Image = "rbxassetid://1316045217"
    Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    Shadow.ImageTransparency = 0.8
    Shadow.ScaleType = Enum.ScaleType.Slice
    Shadow.SliceCenter = Rect.new(10, 10, 118, 118)
    Shadow.Parent = MainFrame

    local TitleBar = Instance.new("Frame")
    TitleBar.Name = "TitleBar"
    TitleBar.Size = UDim2.new(1, 0, 0, 50)
    TitleBar.Position = UDim2.new(0, 0, 0, 0)
    TitleBar.BackgroundColor3 = Mega.Settings.Menu.TitleBarColor
    TitleBar.BorderSizePixel = 0
    TitleBar.Active = true
    TitleBar.Draggable = true

    local TitleCorner = Instance.new("UICorner")
    TitleCorner.CornerRadius = UDim.new(0, Mega.Settings.Menu.CornerRadius)
    TitleCorner.Parent = TitleBar

    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Size = UDim2.new(1, -100, 1, 0)
    Title.Position = UDim2.new(0, 15, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = GetText("title_bar", Mega.VERSION)
    Title.TextColor3 = Mega.Settings.Menu.TextColor
    Title.TextSize = 18
    Title.Font = Enum.Font.GothamBold
    Title.TextXAlignment = Enum.TextXAlignment.Left

    local CloseButton = Instance.new("TextButton")
    CloseButton.Name = "CloseButton"
    CloseButton.Size = UDim2.new(0, 35, 0, 35)
    CloseButton.Position = UDim2.new(1, -40, 0, 7)
    CloseButton.BackgroundColor3 = Color3.fromRGB(255, 60, 80)
    CloseButton.BorderSizePixel = 0
    CloseButton.Text = "✕"
    CloseButton.TextColor3 = Mega.Settings.Menu.TextColor
    CloseButton.TextSize = 18
    CloseButton.Font = Enum.Font.GothamBold

    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, 8)
    CloseCorner.Parent = CloseButton

    local TabContainer = Instance.new("Frame")
    TabContainer.Name = "TabContainer"
    TabContainer.Size = UDim2.new(1, -20, 0, 40)
    TabContainer.Position = UDim2.new(0, 10, 0, 60)
    TabContainer.BackgroundTransparency = 1

    local TabList = Instance.new("UIListLayout")
    TabList.Parent = TabContainer
    TabList.FillDirection = Enum.FillDirection.Horizontal
    TabList.HorizontalAlignment = Enum.HorizontalAlignment.Center
    TabList.VerticalAlignment = Enum.VerticalAlignment.Center
    TabList.Padding = UDim.new(0, 5)

    local ContentContainer = Instance.new("Frame")
    ContentContainer.Name = "ContentContainer"
    ContentContainer.Size = UDim2.new(1, -20, 1, -120)
    ContentContainer.Position = UDim2.new(0, 10, 0, 110)
    ContentContainer.BackgroundTransparency = 1

    MainFrame.Parent = TumbaGUI
    TitleBar.Parent = MainFrame
    Title.Parent = TitleBar
    CloseButton.Parent = TitleBar
    TabContainer.Parent = MainFrame
    ContentContainer.Parent = MainFrame

    Mega.Objects.GUI = TumbaGUI

    local Tabs = {
        GetText("tab_home"),
        GetText("tab_esp"),
        GetText("tab_aim"),
        GetText("tab_player"),
        GetText("tab_combat"),
        GetText("tab_visuals"),
        GetText("tab_users"),
        GetText("tab_utils"),
        GetText("tab_settings")
    }
    local CurrentTab = GetText("tab_home")
    local TabFrames = {}

    local function CreateTab(tabName)
        local TabButton = Instance.new("TextButton")
        TabButton.Name = tabName .. "Tab"
        TabButton.Size = UDim2.new(0, 100, 0, 35)
        TabButton.BackgroundColor3 = Mega.Settings.Menu.BackgroundColor
        TabButton.BorderSizePixel = 0
        TabButton.Text = tabName
        TabButton.TextColor3 = Mega.Settings.Menu.TextColor
        TabButton.TextSize = 12
        TabButton.Font = Enum.Font.GothamSemibold
        TabButton.AutoButtonColor = false

        local TabCorner = Instance.new("UICorner")
        TabCorner.CornerRadius = UDim.new(0, 8)
        TabCorner.Parent = TabButton

        local ContentFrame = Instance.new("ScrollingFrame")
        ContentFrame.Name = tabName .. "Content"
        ContentFrame.Size = UDim2.new(1, 0, 1, 0)
        ContentFrame.Position = UDim2.new(0, 0, 0, 0)
        ContentFrame.BackgroundTransparency = 1
        ContentFrame.BorderSizePixel = 0
        ContentFrame.ScrollBarThickness = 4
        ContentFrame.ScrollBarImageColor3 = Mega.Settings.Menu.AccentColor
        ContentFrame.Visible = false

        local ContentLayout = Instance.new("UIListLayout")
        ContentLayout.Parent = ContentFrame
        ContentLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
        ContentLayout.Padding = UDim.new(0, 8)

        TabFrames[tabName] = ContentFrame
        ContentFrame.Parent = ContentContainer

        TabButton.MouseButton1Click:Connect(function()
            CurrentTab = tabName

            for name, frame in pairs(TabFrames) do
                frame.Visible = false
            end

            if TabFrames[tabName] then
                TabFrames[tabName].Visible = true
            end

            for _, child in pairs(TabContainer:GetChildren()) do
                if child:IsA("TextButton") then
                    if child.Text == tabName then
                        child.BackgroundColor3 = Mega.Settings.Menu.AccentColor
                    else
                        child.BackgroundColor3 = Mega.Settings.Menu.BackgroundColor
                    end
                end
            end
            
            Title.Text = GetText("title_bar_with_tab", tabName)
        end)

        TabButton.Parent = TabContainer
        return TabButton
    end

    for _, tabName in pairs(Tabs) do
        CreateTab(tabName)
    end

    -- Вкладка Home
    local HomeFrame = TabFrames[GetText("tab_home")]
    local StatusSection = CreateSection(HomeFrame, "section_status", GetText)
    CreateToggle(StatusSection, "toggle_autosave", Mega.Settings.System.AutoSaveConfig, function(state)
        Mega.Settings.System.AutoSaveConfig = state
    end, GetText, showNotification)
    CreateToggle(StatusSection, "toggle_perf_mode", Mega.Settings.System.PerformanceMode, function(state)
        Mega.Settings.System.PerformanceMode = state
    end, GetText, showNotification)

    local QuickAccessSection = CreateSection(HomeFrame, "section_quick_access", GetText)
    CreateButton(QuickAccessSection, "button_esp_toggle", function()
        Mega.States.ESP.Enabled = not Mega.States.ESP.Enabled
        print(Mega.States.ESP.Enabled and GetText("print_esp_on") or GetText("print_esp_off"))
    end, GetText)
    CreateButton(QuickAccessSection, "button_aim_toggle", function()
        Mega.States.AimAssist.Enabled = not Mega.States.AimAssist.Enabled
        print(Mega.States.AimAssist.Enabled and GetText("print_aim_on") or GetText("print_aim_off"))
    end, GetText)
    CreateButton(QuickAccessSection, "button_speed_toggle", function()
        Mega.States.Player.Speed = not Mega.States.Player.Speed
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            if Mega.States.Player.Speed then
                LocalPlayer.Character.Humanoid.WalkSpeed = Mega.States.Player.SpeedValue + math.random(-3, 3)
                print(GetText("print_speed_on", Mega.States.Player.SpeedValue))
            else
                LocalPlayer.Character.Humanoid.WalkSpeed = 16
                print(GetText("print_speed_off"))
            end
        end
    end, GetText)

    local StatsSection = CreateSection(HomeFrame, "section_stats", GetText)
    local StatsLabel = Instance.new("TextLabel")
    StatsLabel.Name = "StatsLabel"
    StatsLabel.Size = UDim2.new(0.9, 0, 0, 100)
    StatsLabel.BackgroundTransparency = 1
    StatsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    StatsLabel.TextSize = 12
    StatsLabel.Font = Enum.Font.Gotham
    StatsLabel.TextXAlignment = Enum.TextXAlignment.Left
    StatsLabel.TextYAlignment = Enum.TextYAlignment.Top
    StatsLabel.TextWrapped = true
    StatsLabel.Text = GetText("stats_label", Mega.Database.Stats.Kills, Mega.Database.Stats.Deaths, Mega.Database.Stats.PlayTime, Mega.Database.Stats.ConfigSaves)
    StatsLabel.Parent = StatsSection

    -- Вкладка ESP
    local ESPFrame = TabFrames[GetText("tab_esp")]
    CreateSection(ESPFrame, "section_esp_main", GetText)
    CreateToggle(ESPFrame, "toggle_esp", Mega.States.ESP.Enabled, function(state)
        Mega.States.ESP.Enabled = state
        print(state and GetText("print_esp_on") or GetText("print_esp_off"))
    end, GetText, showNotification)

    local espVisualSettings = {
        CreateSection(nil, "section_esp_visuals", GetText),
        CreateToggle(nil, "toggle_esp_boxes", Mega.States.ESP.Boxes, function(state)
            Mega.States.ESP.Boxes = state
        end, GetText, showNotification),
        CreateToggle(nil, "toggle_esp_names", Mega.States.ESP.Names, function(state)
            Mega.States.ESP.Names = state
        end, GetText, showNotification),
        CreateToggle(nil, "toggle_esp_health", Mega.States.ESP.Health, function(state)
            Mega.States.ESP.Health = state
        end, GetText, showNotification),
        CreateToggle(nil, "toggle_esp_distance", Mega.States.ESP.Distance, function(state)
            Mega.States.ESP.Distance = state
        end, GetText, showNotification),
        CreateToggle(nil, "toggle_esp_tracers", Mega.States.ESP.Tracers, function(state)
            Mega.States.ESP.Tracers = state
        end, GetText, showNotification),
        CreateToggle(nil, "toggle_esp_team", Mega.States.ESP.ShowTeam, function(state)
            Mega.States.ESP.ShowTeam = state
        end, GetText, showNotification),
        CreateSlider(nil, "slider_esp_max_dist", 100, 5000, Mega.States.ESP.MaxDistance, function(value)
            Mega.States.ESP.MaxDistance = value
        end, GetText),
        CreateSection(nil, "section_esp_colors", GetText),
        CreateButton(nil, "button_team_color", function()
            local newColor = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255))
            Mega.States.ESP.TeamColor = newColor
            showNotification(GetText("notify_team_color_changed"))
        end, GetText),
        CreateButton(nil, "button_enemy_color", function()
            local newColor = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255))
            Mega.States.ESP.EnemyColor = newColor
            showNotification(GetText("notify_enemy_color_changed"))
        end, GetText)
    }

    CreateToggleWithSettings(ESPFrame, "toggle_esp", Mega.States.ESP.Enabled, function(state)
        Mega.States.ESP.Enabled = state
        print(state and GetText("print_esp_on") or GetText("print_esp_off"))
    end, espVisualSettings, GetText, showNotification)

    local kitSettingsElements = {
        CreateSection(nil, "section_kit_filters", GetText),
        CreateToggle(nil, "toggle_kit_iron", Mega.States.KitESP.Filters.Iron, function(state)
            Mega.States.KitESP.Filters.Iron = state
            if Mega.States.KitESP.Enabled then recreateKitESP() end
        end, GetText, showNotification),
        CreateToggle(nil, "toggle_kit_bee", Mega.States.KitESP.Filters.Bee, function(state)
            Mega.States.KitESP.Filters.Bee = state
            if Mega.States.KitESP.Enabled then recreateKitESP() end
        end, GetText, showNotification),
        CreateToggle(nil, "toggle_kit_essence", Mega.States.KitESP.Filters.NatureEssence, function(state)
            Mega.States.KitESP.Filters.NatureEssence = state
            if Mega.States.KitESP.Enabled then recreateKitESP() end
        end, GetText, showNotification),
        CreateToggle(nil, "toggle_kit_thorns", Mega.States.KitESP.Filters.Thorns, function(state)
            Mega.States.KitESP.Filters.Thorns = state
            if Mega.States.KitESP.Enabled then recreateKitESP() end
        end, GetText, showNotification),
        CreateToggle(nil, "toggle_kit_mushrooms", Mega.States.KitESP.Filters.Mushrooms, function(state)
            Mega.States.KitESP.Filters.Mushrooms = state
            if Mega.States.KitESP.Enabled then recreateKitESP() end
        end, GetText, showNotification),
        CreateToggle(nil, "toggle_kit_critstar", Mega.States.KitESP.Filters.CritStar, function(state)
            Mega.States.KitESP.Filters.CritStar = state
            if Mega.States.KitESP.Enabled then recreateKitESP() end
        end, GetText, showNotification),
        CreateToggle(nil, "toggle_kit_vitstar", Mega.States.KitESP.Filters.VitalityStar, function(state)
            Mega.States.KitESP.Filters.VitalityStar = state
            if Mega.States.KitESP.Enabled then recreateKitESP() end
        end, GetText, showNotification),
        CreateButton(nil, "button_kit_esp_apply", function()
            if Mega.States.KitESP.Enabled then
                recreateKitESP()
                showNotification(GetText("notify_kit_esp_updated"))
            end
        end, GetText)
    }

    CreateToggleWithSettings(ESPFrame, "toggle_kit_esp", Mega.States.KitESP.Enabled, function(state)
        Mega.States.KitESP.Enabled = state
        if state then
            recreateKitESP()
            showNotification(GetText("notify_kit_esp_on"))
        else
            resetKit()
            showNotification(GetText("notify_kit_esp_off"))
        end
    end, kitSettingsElements, GetText, showNotification)

    -- Вкладка Aim
    local AimFrame = TabFrames[GetText("tab_aim")]
    local targetPartOptions = {
        "dropdown_aim_target_head",
        "dropdown_aim_target_upper",
        "dropdown_aim_target_lower",
        "dropdown_aim_target_root"
    }

    local initialAimTargetKey = "dropdown_aim_target_head"
    if Mega.States.AimAssist.TargetPart == "UpperTorso" then
        initialAimTargetKey = "dropdown_aim_target_upper"
    elseif Mega.States.AimAssist.TargetPart == "LowerTorso" then
        initialAimTargetKey = "dropdown_aim_target_lower"
    elseif Mega.States.AimAssist.TargetPart == "HumanoidRootPart" then
        initialAimTargetKey = "dropdown_aim_target_root"
    end

    local aimSettingsElements = {
        CreateSection(nil, "section_aim_settings", GetText),
        CreateToggle(nil, "toggle_aim_show_fov", Mega.States.AimAssist.ShowFOV, function(state)
            Mega.States.AimAssist.ShowFOV = state
            -- AimFOVCircle.Visible = state -- Обновление FOV круга перемещено в aim_assist.lua
        end, GetText, showNotification),
        CreateButton(nil, "button_aim_fov_color", function()
            local newColor = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255))
            Mega.States.AimAssist.FOVColor = newColor
            -- AimFOVCircle.Color = newColor -- Обновление в aim_assist.lua
            showNotification(GetText("notify_fov_color_changed"))
        end, GetText),
        CreateDropdown(nil, "dropdown_aim_target", targetPartOptions, initialAimTargetKey, function(selectedKey)
            if selectedKey == "dropdown_aim_target_head" then
                Mega.States.AimAssist.TargetPart = "Head"
            elseif selectedKey == "dropdown_aim_target_upper" then
                Mega.States.AimAssist.TargetPart = "UpperTorso"
            elseif selectedKey == "dropdown_aim_target_lower" then
                Mega.States.AimAssist.TargetPart = "LowerTorso"
            elseif selectedKey == "dropdown_aim_target_root" then
                Mega.States.AimAssist.TargetPart = "HumanoidRootPart"
            end
        end, true, GetText),
        CreateSlider(nil, "slider_aim_fov", 20, 720, Mega.States.AimAssist.FOV, function(value)
            Mega.States.AimAssist.FOV = value
            -- AimFOVCircle.Radius = value -- Обновление в aim_assist.lua
        end, GetText),
        CreateSlider(nil, "slider_aim_smooth", 0.1, 1.0, Mega.States.AimAssist.Smoothness, function(value)
            Mega.States.AimAssist.Smoothness = value
        end, GetText),
        CreateSlider(nil, "slider_aim_range", 10, 500, Mega.States.AimAssist.Range, function(value)
            Mega.States.AimAssist.Range = value
        end, GetText),
        CreateSection(nil, "section_aim_key", GetText),
        CreateKeybindButton(nil, "keybind_aim", Mega.States.Keybinds.AimAssist, function(key)
            Mega.States.Keybinds.AimAssist = key
        end, GetText, showNotification)
    }

    CreateToggleWithSettings(AimFrame, "toggle_aim", Mega.States.AimAssist.Enabled, function(state)
        Mega.States.AimAssist.Enabled = state
        print(state and GetText("print_aim_on") or GetText("print_aim_off"))
    end, aimSettingsElements, GetText, showNotification)

    CreateToggle(AimFrame, "toggle_aim_silent", Mega.States.AimAssist.SilentAim, function(state)
        Mega.States.AimAssist.SilentAim = state
    end, GetText, showNotification)

    CreateToggle(AimFrame, "toggle_aim_prediction", Mega.States.AimAssist.Prediction, function(state)
        Mega.States.AimAssist.Prediction = state
    end, GetText, showNotification)

    -- Вкладка Player
    local PlayerFrame = TabFrames[GetText("tab_player")]
    CreateSection(PlayerFrame, "section_player_movement", GetText)

    local speedSettingsElements = {
        CreateSlider(nil, "slider_speed", 16, 150, Mega.States.Player.SpeedValue, function(value)
            Mega.States.Player.SpeedValue = value
            if Mega.States.Player.Speed and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                LocalPlayer.Character.Humanoid.WalkSpeed = value + math.random(-3, 3)
            end
        end, GetText)
    }

    CreateToggleWithSettings(PlayerFrame, "toggle_speed", Mega.States.Player.Speed, function(state)
        Mega.States.Player.Speed = state
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            if state then
                LocalPlayer.Character.Humanoid.WalkSpeed = Mega.States.Player.SpeedValue + math.random(-3, 3)
                print(GetText("print_speed_on", Mega.States.Player.SpeedValue))
            else
                LocalPlayer.Character.Humanoid.WalkSpeed = 16
                print(GetText("print_speed_off"))
            end
        end
    end, speedSettingsElements, GetText, showNotification)

    CreateToggle(PlayerFrame, "toggle_fly", Mega.States.Player.Fly, function(state)
        Mega.States.Player.Fly = state
        -- Логика полета перемещена в player_manager.lua
    end, GetText, showNotification)
    CreateToggle(PlayerFrame, "toggle_inf_jump", Mega.States.Player.InfiniteJump, function(state)
        Mega.States.Player.InfiniteJump = state
        -- Логика бесконечного прыжка в player_manager.lua
    end, GetText, showNotification)
    CreateSection(PlayerFrame, "section_player_defense", GetText)
    CreateToggle(PlayerFrame, "toggle_godmode", Mega.States.Player.GodMode, function(state)
        Mega.States.Player.GodMode = state
        -- Логика godmode в player_manager.lua
    end, GetText, showNotification)
    CreateToggle(PlayerFrame, "toggle_noclip", Mega.States.Player.NoClip, function(state)
        Mega.States.Player.NoClip = state
        -- Логика noclip в player_manager.lua
    end, GetText, showNotification)

    -- Вкладка Combat
    local CombatFrame = TabFrames[GetText("tab_combat")]
    CreateSection(CombatFrame, "section_combat_auto", GetText)
    CreateToggle(CombatFrame, "toggle_triggerbot", Mega.States.Combat.TriggerBot, function(state)
        Mega.States.Combat.TriggerBot = state
    end, GetText, showNotification)
    CreateToggle(CombatFrame, "toggle_autoshoot", Mega.States.Combat.AutoShoot, function(state)
        Mega.States.Combat.AutoShoot = state
    end, GetText, showNotification)
    CreateToggle(CombatFrame, "toggle_rapidfire", Mega.States.Combat.RapidFire, function(state)
        Mega.States.Combat.RapidFire = state
    end, GetText, showNotification)
    CreateSection(CombatFrame, "section_combat_accuracy", GetText)
    CreateToggle(CombatFrame, "toggle_norecoil", Mega.States.Combat.NoRecoil, function(state)
        Mega.States.Combat.NoRecoil = state
    end, GetText, showNotification)
    CreateToggle(CombatFrame, "toggle_nospread", Mega.States.Combat.NoSpread, function(state)
        Mega.States.Combat.NoSpread = state
    end, GetText, showNotification)

    -- Вкладка Visuals
    local VisualsFrame = TabFrames[GetText("tab_visuals")]
    CreateSection(VisualsFrame, "section_visuals_env", GetText)

    local visualsSettingsElements = {
        CreateToggle(nil, "toggle_nofog", Mega.States.Visuals.NoFog, function(state)
            Mega.States.Visuals.NoFog = state
            -- Логика NoFog в utilities.lua
        end, GetText, showNotification),
        CreateToggle(nil, "toggle_fullbright", Mega.States.Visuals.FullBright, function(state)
            Mega.States.Visuals.FullBright = state
            -- Логика FullBright в utilities.lua
        end, GetText, showNotification),
        CreateToggle(nil, "toggle_nightmode", Mega.States.Visuals.NightMode, function(state)
            Mega.States.Visuals.NightMode = state
            -- Логика NightMode в utilities.lua
        end, GetText, showNotification),
        CreateToggle(nil, "toggle_removeshadows", Mega.States.Visuals.RemoveShadows, function(state)
            Mega.States.Visuals.RemoveShadows = state
            -- Логика RemoveShadows в utilities.lua
        end, GetText, showNotification),
    }

    local VisualsControlFrame = Instance.new("Frame")
    VisualsControlFrame.Name = "VisualsControl"
    VisualsControlFrame.Size = UDim2.new(0.95, 0, 0, 40)
    VisualsControlFrame.BackgroundTransparency = 1
    VisualsControlFrame.Parent = VisualsFrame

    local SettingsButton = Instance.new("TextButton")
    SettingsButton.Name = "SettingsButton"
    SettingsButton.Size = UDim2.new(1, 0, 1, 0)
    SettingsButton.Position = UDim2.new(0, 0, 0, 0)
    SettingsButton.BackgroundColor3 = Color3.fromRGB(20, 25, 40)
    SettingsButton.BorderSizePixel = 0
    SettingsButton.Text = GetText("button_visuals_settings")
    SettingsButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    SettingsButton.TextSize = 13
    SettingsButton.Font = Enum.Font.GothamSemibold
    SettingsButton.AutoButtonColor = false
    local SettingsCorner = Instance.new("UICorner")
    SettingsCorner.CornerRadius = UDim.new(0, 8)
    SettingsCorner.Parent = SettingsButton
    SettingsButton.Parent = VisualsControlFrame

    local SettingsContainer = Instance.new("Frame")
    SettingsContainer.Name = "Visuals_SettingsContainer"
    SettingsContainer.Size = UDim2.new(0.9, 0, 0, 1)
    SettingsContainer.BackgroundTransparency = 1
    SettingsContainer.Visible = false
    SettingsContainer.ClipsDescendants = true
    SettingsContainer.Parent = VisualsFrame

    local SettingsLayout = Instance.new("UIListLayout")
    SettingsLayout.Parent = SettingsContainer
    SettingsLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    SettingsLayout.SortOrder = Enum.SortOrder.LayoutOrder
    SettingsLayout.Padding = UDim.new(0, 8)

    for _, element in ipairs(visualsSettingsElements) do
        element.Parent = SettingsContainer
    end

    SettingsButton.MouseButton1Click:Connect(function()
        local isVisible = SettingsContainer.Visible
        local targetHeight = isVisible and 1 or SettingsLayout.AbsoluteContentSize.Y + 10
        local targetVisibility = not isVisible

        local tween = TweenService:Create(SettingsContainer, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(0.9, 0, 0, targetHeight)
        })

        if targetVisibility then
            SettingsContainer.Visible = true
            tween:Play()
        else
            tween:Play()
            local connection
            connection = tween.Completed:Connect(function()
                SettingsContainer.Visible = false
                connection:Disconnect()
            end)
        end
    end)

    -- Вкладка Utils
    local UtilsFrame = TabFrames[GetText("tab_utils")]
    CreateSection(UtilsFrame, "section_utils_tools", GetText)
    CreateButton(UtilsFrame, "button_clear_chat", function()
        -- Логика очистки чата в utilities.lua
    end, GetText)
    CreateButton(UtilsFrame, "button_screenshot", function()
        -- Логика скриншота в utilities.lua
    end, GetText)
    CreateButton(UtilsFrame, "button_server_info", function()
        -- Логика информации о сервере в utilities.lua
    end, GetText)
    CreateSection(UtilsFrame, "section_utils_fun", GetText)
    CreateToggle(UtilsFrame, "toggle_fame_spam", Mega.States.Misc.FameSpam, function(state)
        Mega.States.Misc.FameSpam = state
        -- Логика спама в utilities.lua
    end, GetText, showNotification)
    CreateButton(UtilsFrame, "button_reload_script", function()
        showNotification(GetText("notify_reload"))
        -- Логика релоада в main.lua или utilities.lua
    end, GetText)

    -- Вкладка Settings
    local SettingsFrame = TabFrames[GetText("tab_settings")]
    CreateSection(SettingsFrame, "section_settings_appearance", GetText)
    CreateButton(SettingsFrame, "button_change_theme", function()
        -- Логика смены темы в utilities.lua
    end, GetText)
    CreateKeybindButton(SettingsFrame, "keybind_menu", Mega.States.Keybinds.Menu, function(key)
        Mega.States.Keybinds.Menu = key
    end, GetText, showNotification)
    CreateSection(SettingsFrame, "section_settings_config", GetText)
    CreateButton(SettingsFrame, "button_config_save", function()
        -- Логика сохранения конфига в utilities.lua
    end, GetText)
    CreateButton(SettingsFrame, "button_config_load", function()
        -- Логика загрузки конфига в utilities.lua
    end, GetText)
    CreateButton(SettingsFrame, "button_config_reset", function()
        -- Логика сброса в utilities.lua
    end, GetText)
    CreateButton(SettingsFrame, "button_cleanup", Cleanup, GetText)

    -- Вкладка Users
    local PlayerListFrame = TabFrames[GetText("tab_users")]
    CreateSection(PlayerListFrame, "section_player_list", GetText)
    CreateButton(PlayerListFrame, "button_stop_follow", StopFollow, GetText)

    local PlayerListContainer = Instance.new("ScrollingFrame")
    PlayerListContainer.Name = "PlayersList"
    PlayerListContainer.Size = UDim2.new(0.95, 0, 1, -100)
    PlayerListContainer.BackgroundTransparency = 1
    PlayerListContainer.BorderSizePixel = 0
    PlayerListContainer.ScrollBarThickness = 4
    PlayerListContainer.ScrollBarImageColor3 = Mega.Settings.Menu.AccentColor
    PlayerListContainer.Parent = PlayerListFrame

    local ListLayout = Instance.new("UIListLayout")
    ListLayout.Parent = PlayerListContainer
    ListLayout.FillDirection = Enum.FillDirection.Vertical
    ListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    ListLayout.Padding = UDim.new(0, 5)

    local PlayerItemTemplate = Instance.new("TextButton")
    PlayerItemTemplate.Name = "PlayerItemTemplate"
    PlayerItemTemplate.Size = UDim2.new(1, 0, 0, 35)
    PlayerItemTemplate.BackgroundColor3 = Color3.fromRGB(30, 35, 50)
    PlayerItemTemplate.BorderSizePixel = 0
    PlayerItemTemplate.Visible = false
    PlayerItemTemplate.Text = ""
    PlayerItemTemplate.AutoButtonColor = false

    local ItemLayout = Instance.new("UIListLayout")
    ItemLayout.Parent = PlayerItemTemplate
    ItemLayout.FillDirection = Enum.FillDirection.Horizontal
    ItemLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    ItemLayout.Padding = UDim.new(0, 5)
    ItemLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left

    local ItemCorner = Instance.new("UICorner")
    ItemCorner.CornerRadius = UDim.new(0, 5)
    ItemCorner.Parent = PlayerItemTemplate

    local NameLabel = Instance.new("TextLabel")
    NameLabel.Name = "Name"
    NameLabel.Size = UDim2.new(0.25, 0, 1, 0)
    NameLabel.BackgroundTransparency = 1
    NameLabel.TextColor3 = Mega.Settings.Menu.TextColor
    NameLabel.TextSize = 12
    NameLabel.Font = Enum.Font.GothamSemibold
    NameLabel.TextXAlignment = Enum.TextXAlignment.Left
    NameLabel.Position = UDim2.new(0, 5, 0, 0)
    NameLabel.Text = GetText("playerlist_name")
    NameLabel.Parent = PlayerItemTemplate

    local TeamLabel = NameLabel:Clone()
    TeamLabel.Name = "Team"
    TeamLabel.Size = UDim2.new(0.25, 0, 1, 0)
    TeamLabel.Text = GetText("playerlist_team")
    TeamLabel.Parent = PlayerItemTemplate

    local HPLabel = NameLabel:Clone()
    HPLabel.Name = "HP"
    HPLabel.Size = UDim2.new(0.2, 0, 1, 0)
    HPLabel.Text = GetText("playerlist_hp")
    HPLabel.Parent = PlayerItemTemplate

    local DistanceLabel = NameLabel:Clone()
    DistanceLabel.Name = "Distance"
    DistanceLabel.Size = UDim2.new(0.25, 0, 1, 0)
    DistanceLabel.Text = GetText("playerlist_dist")
    DistanceLabel.Parent = PlayerItemTemplate

    CloseButton.MouseButton1Click:Connect(ToggleMenu)

    for _, frame in pairs(TabFrames) do
        local layout = frame:FindFirstChild("UIListLayout")
        if layout then
            layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                frame.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 20)
            end)
        end
    end

    CurrentTab = GetText("tab_home")
    TabFrames[GetText("tab_home")].Visible = true
    for _, child in pairs(TabContainer:GetChildren()) do
        if child:IsA("TextButton") then
            if child.Text == GetText("tab_home") then
                child.BackgroundColor3 = Mega.Settings.Menu.AccentColor
            else
                child.BackgroundColor3 = Mega.Settings.Menu.BackgroundColor
            end
        end
    end

    return TumbaGUI
end

local function CreateLanguagePrompt(OnLanguageSelected)
    local LanguagePrompt = Instance.new("ScreenGui")
    LanguagePrompt.Name = "LanguagePrompt"
    LanguagePrompt.Parent = CoreGui
    LanguagePrompt.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    local Background = Instance.new("Frame")
    Background.Size = UDim2.new(0, 300, 0, 150)
    Background.Position = UDim2.new(0.5, -150, 0.5, -75)
    Background.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    Background.BorderSizePixel = 0
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 10)
    Corner.Parent = Background
    Background.Parent = LanguagePrompt

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 50)
    Title.Position = UDim2.new(0, 0, 0, 10)
    Title.BackgroundTransparency = 1
    Title.TextColor3 = Color3.new(1, 1, 1)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 18
    Title.Text = "TUMBA v5.0 - Select Language"
    Title.TextXAlignment = Enum.TextXAlignment.Center
    Title.Parent = Background

    local ButtonContainer = Instance.new("Frame")
    ButtonContainer.Name = "ButtonContainer"
    ButtonContainer.Size = UDim2.new(1, 0, 0, 60)
    ButtonContainer.Position = UDim2.new(0, 0, 0, 70)
    ButtonContainer.BackgroundTransparency = 1
    ButtonContainer.Parent = Background

    local ButtonLayout = Instance.new("UIListLayout")
    ButtonLayout.FillDirection = Enum.FillDirection.Horizontal
    ButtonLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    ButtonLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    ButtonLayout.Padding = UDim.new(0, 20)
    ButtonLayout.Parent = ButtonContainer

    local EnglishButton = Instance.new("TextButton")
    EnglishButton.Name = "English"
    EnglishButton.Size = UDim2.new(0, 100, 0, 40)
    EnglishButton.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
    EnglishButton.TextColor3 = Color3.new(1, 1, 1)
    EnglishButton.Font = Enum.Font.GothamSemibold
    EnglishButton.Text = "English"
    EnglishButton.Parent = ButtonContainer

    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim.new(0, 6)
    ButtonCorner.Parent = EnglishButton

    local RussianButton = EnglishButton:Clone()
    RussianButton.Name = "Russian"
    RussianButton.Name = "Russian"
    RussianButton.Text = "Русский"
    RussianButton.Parent = ButtonContainer

    EnglishButton.MouseButton1Click:Connect(function()
        OnLanguageSelected("en")
    end)

    RussianButton.MouseButton1Click:Connect(function()
        OnLanguageSelected("ru")
    end)

    return LanguagePrompt
end

return {
    CreateSection = CreateSection,
    CreateToggle = CreateToggle,
    CreateToggleWithSettings = CreateToggleWithSettings,
    CreateDropdown = CreateDropdown,
    CreateButton = CreateButton,
    CreateSlider = CreateSlider,
    CreateKeybindButton = CreateKeybindButton,
    CreateMainGUI = CreateMainGUI,
    CreateLanguagePrompt = CreateLanguagePrompt
}
