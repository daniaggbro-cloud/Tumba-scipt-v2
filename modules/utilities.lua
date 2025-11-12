local HttpService = game:GetService("HttpService")
local Lighting = game:GetService("Lighting")
local TextChatService = game:GetService("TextChatService")
local RunService = game:GetService("RunService")

local function showNotification(Mega, message)
    local notification = Instance.new("TextLabel")
    notification.Size = UDim2.new(0, 300, 0, 50)
    notification.Position = UDim2.new(0.5, -150, 0, 50)
    notification.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    notification.TextColor3 = Color3.new(1, 1, 1)
    notification.Font = Enum.Font.SourceSansBold
    notification.TextSize = 20
    notification.Text = message
    notification.AnchorPoint = Vector2.new(0.5, 0)
    notification.Parent = Mega.Objects.GUI

    game.Debris:AddItem(notification, 3)
end

local function Cleanup(Mega)
    for _, conn in pairs(Mega.Objects.Connections) do
        pcall(function() conn:Disconnect() end)
    end

    for _, esp in pairs(Mega.Objects.ESP) do
        for _, drawing in pairs(esp) do
            pcall(function() drawing:Remove() end)
        end
    end

    Mega.Objects.GUI:Destroy()
    showNotification(Mega, Mega.Localization.GetText("notify_cleanup"))
end

local function ClearChat(GetText, showNotification)
    task.spawn(function()
        for i = 1, 100 do
            pcall(function()
                TextChatService.TextChannels.RBXGeneral:SendAsync(" ")
            end)
            task.wait(0.1)
        end
    end)
    showNotification(GetText("notify_chat_cleared"))
end

local function TakeScreenshot(GetText, showNotification)
    showNotification(GetText("notify_screenshot"))
    -- Добавь реальную логику скриншота, если нужно (Roblox не поддерживает напрямую)
end

local function ServerInfo(GetText)
    local players = #game.Players:GetPlayers()
    local maxPlayers = game.Players.MaxPlayers
    local gameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name

    print("🔍 " .. GetText("button_server_info"))
    print("🎮 Game: " .. gameName)
    print("👥 Players: " .. players .. "/" .. maxPlayers)
    print("🆔 Place ID: " .. game.PlaceId)
end

local function FameSpam(Mega)
    if Mega.States.Misc.FameSpam then
        local messages = {
            "GG EZ MY BOG TUMBA",
            "TUMBA CHEAT v5.0 - BEST IN THE WORLD",
            "I.S.-1 PROTECTS ME",
            "GET GOOD GET TUMBA",
            "N.User-1 APPROVED"
        }

        Mega.Objects.Connections.FameSpam = RunService.Heartbeat:Connect(function()
            local message = messages[math.random(1, #messages)]
            local success = pcall(function()
                if TextChatService then
                    local channel = TextChatService.TextChannels:FindFirstChild("RBXGeneral")
                    if channel then
                        channel:SendAsync(message)
                        return true
                    end
                end
            end)

            if not success then
                pcall(function()
                    game.Players.LocalPlayer:Chat(message)
                end)
            end
            wait(2)
        end)
    else
        if Mega.Objects.Connections.FameSpam then
            Mega.Objects.Connections.FameSpam:Disconnect()
        end
    end
end

local function ChangeTheme(Mega, GetText, showNotification)
    local colors = {
        Color3.fromRGB(255, 50, 50),
        Color3.fromRGB(50, 255, 50),
        Color3.fromRGB(50, 150, 255),
        Color3.fromRGB(180, 50, 255),
        Color3.fromRGB(255, 150, 50)
    }

    local newColor = colors[math.random(1, #colors)]
    Mega.Settings.Menu.AccentColor = newColor
    Mega.Objects.GUI.MainFrame.TitleBar.BackgroundColor3 = newColor

    for _, frame in pairs(Mega.Objects.GUI.MainFrame.TabFrames) do
        frame.ScrollBarImageColor3 = newColor
    end
    
    showNotification(GetText("notify_theme_changed"))
end

local function SaveConfig(Mega, GetText, showNotification)
    local configData = {
        Settings = Mega.Settings,
        States = Mega.States,
        Stats = Mega.Database.Stats
    }

    Mega.Database.Configs["default"] = configData
    Mega.Database.Stats.ConfigSaves = Mega.Database.Stats.ConfigSaves + 1
    
    showNotification(GetText("notify_config_saved", Mega.Database.Stats.ConfigSaves))
end

local function LoadConfig(Mega, GetText, showNotification)
    if Mega.Database.Configs["default"] then
        local config = Mega.Database.Configs["default"]

        Mega.Settings = config.Settings or Mega.Settings
        Mega.States = config.States or Mega.States
        Mega.Database.Stats = config.Stats or Mega.Database.Stats

        showNotification(GetText("notify_config_loaded"))
    else
        showNotification(GetText("notify_config_not_found"))
    end
end

local function ResetSettings(Mega, GetText, showNotification)
    Mega.Settings = {
        Menu = {
            Width = 900, Height = 500, BackgroundColor = Color3.fromRGB(10, 10, 25),
            TitleBarColor = Color3.fromRGB(0, 100, 200), AccentColor = Color3.fromRGB(0, 180, 255),
            TextColor = Color3.fromRGB(255, 255, 255), Transparency = 0.05, CornerRadius = 15, AnimationSpeed = 0.3
        },
        System = {
            AntiAFK = true, AutoSaveConfig = true, PerformanceMode = false, DebugMode = false, Logging = true
        }
    }
    
    Mega.Objects.GUI.MainFrame.BackgroundColor3 = Mega.Settings.Menu.BackgroundColor
    Mega.Objects.GUI.MainFrame.BackgroundTransparency = Mega.Settings.Menu.Transparency
    Mega.Objects.GUI.MainFrame.UICorner.CornerRadius = UDim.new(0, Mega.Settings.Menu.CornerRadius)
    Mega.Objects.GUI.MainFrame.TitleBar.BackgroundColor3 = Mega.Settings.Menu.TitleBarColor
    Mega.Objects.GUI.MainFrame.TitleBar.Title.TextColor3 = Mega.Settings.Menu.TextColor
    Mega.Objects.GUI.MainFrame.TitleBar.CloseButton.TextColor3 = Mega.Settings.Menu.TextColor
    for _, frame in pairs(Mega.Objects.GUI.MainFrame.TabFrames) do
        frame.ScrollBarImageColor3 = Mega.Settings.Menu.AccentColor
    end
    
    showNotification(GetText("notify_settings_reset"))
end

local function AutoSaveConfig(Mega)
    if Mega.Settings.System.AutoSaveConfig then
        Mega.Objects.Connections.AutoSave = RunService.Heartbeat:Connect(function()
            if tick() % 300 < 1 then
                local configData = {
                    Settings = Mega.Settings,
                    States = Mega.States,
                    Stats = Mega.Database.Stats
                }
                Mega.Database.Configs["default"] = configData
            end
        end)
    end
end

local function NoFog(Mega)
    if Mega.States.Visuals.NoFog then
        Lighting.FogEnd = 100000
    else
        Lighting.FogEnd = 1000
    end
end

local function FullBright(Mega)
    if Mega.States.Visuals.FullBright then
        Lighting.Ambient = Color3.new(1, 1, 1)
        Lighting.Brightness = 2
    else
        Lighting.Ambient = Color3.new(0.5, 0.5, 0.5)
        Lighting.Brightness = 1
    end
end

local function NightMode(Mega)
    if Mega.States.Visuals.NightMode then
        Lighting.ClockTime = 0
    else
        Lighting.ClockTime = 14
    end
end

local function RemoveShadows(Mega)
    if Mega.States.Visuals.RemoveShadows then
        Lighting.GlobalShadows = false
    else
        Lighting.GlobalShadows = true
    end
end

return {
    showNotification = showNotification,
    Cleanup = Cleanup,
    ClearChat = ClearChat,
    TakeScreenshot = TakeScreenshot,
    ServerInfo = ServerInfo,
    FameSpam = FameSpam,
    ChangeTheme = ChangeTheme,
    SaveConfig = SaveConfig,
    LoadConfig = LoadConfig,
    ResetSettings = ResetSettings,
    AutoSaveConfig = AutoSaveConfig,
    NoFog = NoFog,
    FullBright = FullBright,
    NightMode = NightMode,
    RemoveShadows = RemoveShadows
}
