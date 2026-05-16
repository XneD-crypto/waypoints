local WaypointsBtn = createGrayButton("WAYPOINTS")
WaypointsBtn.MouseButton1Click:Connect(function()
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "WaypointGUI"
    screenGui.Parent = player.PlayerGui
    screenGui.ResetOnSpawn = false
 
    local button = Instance.new("ImageButton")
    button.Size = UDim2.new(0, 30, 0, 30)
    button.Position = UDim2.new(0.5, -15, 0.05, 0)
    button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    button.Image = ""
    button.Active = true
    button.Draggable = true
    button.Parent = screenGui
 
    local uICorner = Instance.new("UICorner")
    uICorner.CornerRadius = UDim.new(1, 0)
    uICorner.Parent = button
 
    local uiStroke = Instance.new("UIStroke")
    uiStroke.Color = Color3.fromRGB(100, 100, 100)
    uiStroke.Thickness = 1.5
    uiStroke.Parent = button
 
    local icon = Instance.new("Frame")
    icon.Size = UDim2.new(0, 10, 0, 10)
    icon.Position = UDim2.new(0.5, -5, 0.5, -5)
    icon.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
    icon.BorderSizePixel = 0
    icon.Parent = button
 
    local iconCorner = Instance.new("UICorner")
    iconCorner.CornerRadius = UDim.new(1, 0)
    iconCorner.Parent = icon
 
    local statusRing = Instance.new("Frame")
    statusRing.Size = UDim2.new(1, 0, 1, 0)
    statusRing.BackgroundTransparency = 1
    statusRing.Parent = button
 
    local ringStroke = Instance.new("UIStroke")
    ringStroke.Color = Color3.fromRGB(150, 150, 150)
    ringStroke.Thickness = 2
    ringStroke.Parent = statusRing
 
    local waypointEnabled = false
    local currentWaypoint = nil
    local waypointPosition = nil
 
    local function createStationaryWaypoint()
        if currentWaypoint then
            currentWaypoint:Destroy()
            currentWaypoint = nil
        end
 
        if not player.Character then return end
        local humanoidRootPart = player.Character:FindFirstChild("HumanoidRootPart")
        if not humanoidRootPart then return end
        
        waypointPosition = humanoidRootPart.Position
 
        local anchor = Instance.new("Part")
        anchor.Anchored = true
        anchor.CanCollide = false
        anchor.Size = Vector3.new(0.1, 0.1, 0.1)
        anchor.Transparency = 1
        anchor.Position = waypointPosition
        anchor.Parent = workspace
 
        local billboard = Instance.new("BillboardGui")
        billboard.Size = UDim2.new(0, 150, 0, 80)
        billboard.StudsOffset = Vector3.new(0, 2.5, 0)
        billboard.AlwaysOnTop = true
        billboard.Adornee = anchor
        billboard.Parent = anchor
 
        local distLabel = Instance.new("TextLabel")
        distLabel.Size = UDim2.new(1, 0, 0, 24)
        distLabel.Position = UDim2.new(0, 0, 0, -10)
        distLabel.BackgroundTransparency = 1
        distLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        distLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        distLabel.TextStrokeTransparency = 0.2
        distLabel.TextSize = 18
        distLabel.Font = Enum.Font.GothamBold
        distLabel.Text = "0"
        distLabel.Parent = billboard
 
        local marker = Instance.new("Frame")
        marker.Size = UDim2.new(0, 14, 0, 14)
        marker.Position = UDim2.new(0.5, -7, 0.5, -7)
        marker.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        marker.BorderSizePixel = 0
        marker.Parent = billboard
 
        local markerCorner = Instance.new("UICorner")
        markerCorner.CornerRadius = UDim.new(1, 0)
        markerCorner.Parent = marker
 
        local markerRing = Instance.new("Frame")
        markerRing.Size = UDim2.new(1, 0, 1, 0)
        markerRing.BackgroundTransparency = 1
        markerRing.Parent = marker
 
        local markerStroke = Instance.new("UIStroke")
        markerStroke.Color = Color3.fromRGB(255, 255, 255)
        markerStroke.Thickness = 1.5
        markerStroke.Parent = markerRing
 
        local function updateDistance()
            while anchor and anchor.Parent and task.wait(0.1) do
                if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    local hrp = player.Character.HumanoidRootPart
                    local dist = (hrp.Position - anchor.Position).Magnitude
                    distLabel.Text = string.format("%d", math.floor(dist))
                    
                    if dist < 10 then
                        distLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
                    elseif dist < 50 then
                        distLabel.TextColor3 = Color3.fromRGB(255, 255, 50)
                    else
                        distLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                    end
                end
            end
        end
 
        spawn(updateDistance)
        currentWaypoint = anchor
    end
 
    button.MouseButton1Click:Connect(function()
        waypointEnabled = not waypointEnabled
 
        if waypointEnabled then
            createStationaryWaypoint()
            ringStroke.Color = Color3.fromRGB(80, 255, 80)
            icon.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
            uiStroke.Color = Color3.fromRGB(200, 200, 255)
        else
            if currentWaypoint then
                currentWaypoint:Destroy()
                currentWaypoint = nil
                waypointPosition = nil
            end
            ringStroke.Color = Color3.fromRGB(150, 150, 150)
            icon.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
            uiStroke.Color = Color3.fromRGB(100, 100, 100)
        end
    end)
 
    print("Waypoints запущены.")
end)
