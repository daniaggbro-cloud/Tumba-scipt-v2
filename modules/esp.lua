local RunService = game:GetService("RunService")

local function CreateESP(Mega, player)
    if player == game.Players.LocalPlayer then return end

    local esp = {
        box = Drawing.new("Square"),
        name = Drawing.new("Text"),
        distance = Drawing.new("Text"),
        health = Drawing.new("Text"),
        tracer = Drawing.new("Line")
    }

    esp.box.Visible = false
    esp.box.Thickness = 2
    esp.box.Filled = false
    esp.box.ZIndex = 1

    esp.name.Visible = false
    esp.name.Size = 14
    esp.name.Center = true
    esp.name.Outline = true
    esp.name.ZIndex = 1

    esp.distance.Visible = false
    esp.distance.Size = 12
    esp.distance.Center = true
    esp.distance.Outline = true
    esp.distance.ZIndex = 1

    esp.health.Visible = false
    esp.health.Size = 12
    esp.health.Center = true
    esp.health.Outline = true
    esp.health.ZIndex = 1

    esp.tracer.Visible = false
    esp.tracer.Thickness = 1
    esp.tracer.ZIndex = 1

    Mega.Objects.ESP[player] = esp
end

local function RemoveESP(Mega, player)
    if Mega.Objects.ESP[player] then
        for _, drawing in pairs(Mega.Objects.ESP[player]) do
            drawing:Remove()
        end
        Mega.Objects.ESP[player] = nil
    end
end

local function UpdateESPColors(Mega)
    for player, esp in pairs(Mega.Objects.ESP) do
        if player and player.Character and player.Team then
            local isTeam = Mega.States.ESP.ShowTeam and player.Team == game.Players.LocalPlayer.Team
            local isEnemy = player.Team ~= game.Players.LocalPlayer.Team

            if isTeam then
                esp.box.Color = Mega.States.ESP.TeamColor
                esp.name.Color = Mega.States.ESP.TeamColor
                esp.distance.Color = Mega.States.ESP.TeamColor
                esp.health.Color = Mega.States.ESP.TeamColor
                esp.tracer.Color = Mega.States.ESP.TeamColor
            elseif isEnemy then
                esp.box.Color = Mega.States.ESP.EnemyColor
                esp.name.Color = Mega.States.ESP.EnemyColor
                esp.distance.Color = Mega.States.ESP.EnemyColor
                esp.health.Color = Mega.States.ESP.EnemyColor
                esp.tracer.Color = Mega.States.ESP.EnemyColor
            else
                esp.box.Color = Mega.States.ESP.NeutralColor
                esp.name.Color = Mega.States.ESP.NeutralColor
                esp.distance.Color = Mega.States.ESP.NeutralColor
                esp.health.Color = Mega.States.ESP.NeutralColor
                esp.tracer.Color = Mega.States.ESP.NeutralColor
            end
        end
    end
end

local function UpdateESP(Mega, GetText)
    local camera = game.Workspace.CurrentCamera
    local screenCenter = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y)

    for player, esp in pairs(Mega.Objects.ESP) do
        if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local rootPart = player.Character.HumanoidRootPart
            local head = player.Character:FindFirstChild("Head")
            local humanoid = player.Character:FindFirstChild("Humanoid")

            if head and humanoid then
                local screenPos, onScreen = camera:WorldToViewportPoint(rootPart.Position)
                local distance = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - rootPart.Position).Magnitude

                if onScreen and distance <= Mega.States.ESP.MaxDistance then
                    local scale = 1000 / distance
                    local width = scale * 2
                    local height = scale * 3

                    if Mega.States.ESP.Boxes then
                        esp.box.Visible = Mega.States.ESP.Enabled
                        esp.box.Position = Vector2.new(screenPos.X - width / 2, screenPos.Y - height / 2)
                        esp.box.Size = Vector2.new(width, height)
                    else
                        esp.box.Visible = false
                    end

                    if Mega.States.ESP.Names then
                        esp.name.Visible = Mega.States.ESP.Enabled
                        esp.name.Position = Vector2.new(screenPos.X, screenPos.Y - height / 2 - 20)
                        esp.name.Text = player.Name
                    else
                        esp.name.Visible = false
                    end

                    if Mega.States.ESP.Distance then
                        esp.distance.Visible = Mega.States.ESP.Enabled
                        esp.distance.Position = Vector2.new(screenPos.X, screenPos.Y + height / 2 + 10)
                        esp.distance.Text = GetText("esp_studs", math.floor(distance))
                    else
                        esp.distance.Visible = false
                    end

                    if Mega.States.ESP.Health then
                        esp.health.Visible = Mega.States.ESP.Enabled
                        esp.health.Position = Vector2.new(screenPos.X, screenPos.Y + height / 2 + 30)
                        esp.health.Text = GetText("esp_hp", math.floor(humanoid.Health))
                    else
                        esp.health.Visible = false
                    end

                    if Mega.States.ESP.Tracers then
                        esp.tracer.Visible = Mega.States.ESP.Enabled
                        esp.tracer.From = Vector2.new(screenPos.X, screenPos.Y + height / 2)
                        esp.tracer.To = screenCenter
                    else
                        esp.tracer.Visible = false
                    end

                else
                    esp.box.Visible = false
                    esp.name.Visible = false
                    esp.distance.Visible = false
                    esp.health.Visible = false
                    esp.tracer.Visible = false
                end
            end
        else
            esp.box.Visible = false
            esp.name.Visible = false
            esp.distance.Visible = false
            esp.health.Visible = false
            esp.tracer.Visible = false
        end
    end
end

local function InitESP(Mega, GetText)
    for _, player in pairs(game.Players:GetPlayers()) do
        CreateESP(Mega, player)
    end

    game.Players.PlayerAdded:Connect(function(player)
        CreateESP(Mega, player)
    end)

    game.Players.PlayerRemoving:Connect(function(player)
        RemoveESP(Mega, player)
    end)

    RunService.Heartbeat:Connect(function()
        if Mega.States.ESP.Enabled then
            UpdateESP(Mega, GetText)
            UpdateESPColors(Mega)
        else
            for player, esp in pairs(Mega.Objects.ESP) do
                esp.box.Visible = false
                esp.name.Visible = false
                esp.distance.Visible = false
                esp.health.Visible = false
                esp.tracer.Visible = false
            end
        end
    end)
end

return {
    InitESP = InitESP
}
