local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TeleportService = game:GetService("TeleportService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

-- Wait for PlayerGui to be ready with extended timeout
local player = Players.LocalPlayer
local playerGui
local attempts = 0
local maxAttempts = 20

while attempts < maxAttempts do
    playerGui = player:FindFirstChild("PlayerGui")
    if playerGui then break end
    attempts = attempts + 1
    wait(0.5)
end

if not playerGui then
    error("Failed to find PlayerGui after " .. maxAttempts .. " attempts. Executor compatibility issue or Roblox anti-cheat blocking.")
end

-- Create Welcome Screen
local WelcomeScreen = Instance.new("ScreenGui")
WelcomeScreen.Name = "ChescoWelcome"
WelcomeScreen.ResetOnSpawn = false
WelcomeScreen.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
WelcomeScreen.Parent = playerGui

local WelcomeFrame = Instance.new("Frame")
WelcomeFrame.Size = UDim2.new(1, 0, 1, 0)
WelcomeFrame.BackgroundColor3 = Color3.fromRGB(26, 42, 68)
WelcomeFrame.Parent = WelcomeScreen

local WelcomeGradient = Instance.new("UIGradient")
WelcomeGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(26, 42, 68)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(46, 72, 122))
})
WelcomeGradient.Rotation = 45
WelcomeGradient.Parent = WelcomeFrame

local WelcomeTitle = Instance.new("TextLabel")
WelcomeTitle.Size = UDim2.new(0, 400, 0, 50)
WelcomeTitle.Position = UDim2.new(0.5, -200, 0.3, 0)
WelcomeTitle.BackgroundTransparency = 1
WelcomeTitle.Text = "Welcome to Chesco's GUI"
WelcomeTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
WelcomeTitle.TextSize = 36
WelcomeTitle.Font = Enum.Font.SourceSansBold
WelcomeTitle.TextStrokeTransparency = 0.7
WelcomeTitle.Parent = WelcomeFrame

local WelcomeSubtitle = Instance.new("TextLabel")
WelcomeSubtitle.Size = UDim2.new(0, 400, 0, 30)
WelcomeSubtitle.Position = UDim2.new(0.5, -200, 0.4, 0)
WelcomeSubtitle.BackgroundTransparency = 1
WelcomeSubtitle.Text = "Blox Fruits v4.3 - Max Power"
WelcomeSubtitle.TextColor3 = Color3.fromRGB(200, 200, 200)
WelcomeSubtitle.TextSize = 20
WelcomeSubtitle.Font = Enum.Font.SourceSans
WelcomeSubtitle.Parent = WelcomeFrame

local AvatarImage = Instance.new("ImageLabel")
AvatarImage.Size = UDim2.new(0, 100, 0, 100)
AvatarImage.Position = UDim2.new(0.5, -50, 0.5, -50)
AvatarImage.BackgroundTransparency = 1
AvatarImage.Image = "rbxthumb://type=Avatar&id=" .. player.UserId .. "&w=420&h=420"
AvatarImage.Parent = WelcomeFrame
local AvatarCorner = Instance.new("UICorner")
AvatarCorner.CornerRadius = UDim.new(0, 50)
AvatarCorner.Parent = AvatarImage

local EnterButton = Instance.new("TextButton")
EnterButton.Size = UDim2.new(0, 150, 0, 40)
EnterButton.Position = UDim2.new(0.5, -75, 0.7, 0)
EnterButton.BackgroundColor3 = Color3.fromRGB(66, 92, 142)
EnterButton.Text = "Enter"
EnterButton.TextColor3 = Color3.fromRGB(255, 255, 255)
EnterButton.TextSize = 20
EnterButton.Font = Enum.Font.SourceSansBold
EnterButton.Parent = WelcomeFrame
local EnterCorner = Instance.new("UICorner")
EnterCorner.CornerRadius = UDim.new(0, 8)
EnterCorner.Parent = EnterButton

-- Welcome Screen Animation
local function playWelcomeAnimation()
    WelcomeTitle.Position = UDim2.new(0.5, -200, 0.2, 0)
    WelcomeTitle.TextTransparency = 1
    WelcomeSubtitle.TextTransparency = 1
    AvatarImage.ImageTransparency = 1
    EnterButton.TextTransparency = 1
    EnterButton.BackgroundTransparency = 1

    local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
    TweenService:Create(WelcomeTitle, tweenInfo, {Position = UDim2.new(0.5, -200, 0.3, 0), TextTransparency = 0}):Play()
    TweenService:Create(WelcomeSubtitle, tweenInfo, {TextTransparency = 0}):Play()
    wait(0.5)
    TweenService:Create(AvatarImage, tweenInfo, {ImageTransparency = 0}):Play()
    wait(0.5)
    TweenService:Create(EnterButton, tweenInfo, {TextTransparency = 0, BackgroundTransparency = 0}):Play()
end

-- Create Main GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ChescoGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Enabled = false
ScreenGui.Parent = playerGui

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 500, 0, 400)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(26, 42, 68)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui
MainFrame.ClipsDescendants = true

-- Rounded Corners
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

-- Glassmorphism Effect
local UIGradient = Instance.new("UIGradient")
UIGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 200, 200))
})
UIGradient.Transparency = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 0.7),
    NumberSequenceKeypoint.new(1, 0.9)
})
UIGradient.Parent = MainFrame

-- Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -100, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = "Chesco's Blox Fruits GUI - v4.3"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 24
Title.Font = Enum.Font.SourceSansBold
Title.TextStrokeTransparency = 0.8
Title.Parent = MainFrame

-- Close Button
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -40, 0, 5)
CloseButton.BackgroundColor3 = Color3.fromRGB(26, 42, 68) -- Updated to match midnight blue theme
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 16
CloseButton.Font = Enum.Font.SourceSans
CloseButton.Parent = MainFrame
local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseButton
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui.Enabled = false
end)

-- Minimize Button
local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
MinimizeButton.Position = UDim2.new(1, -80, 0, 5)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(46, 72, 122) -- Updated to match midnight blue accent
MinimizeButton.Text = "-"
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.TextSize = 16
MinimizeButton.Font = Enum.Font.SourceSans
MinimizeButton.Parent = MainFrame
local MinimizeCorner = Instance.new("UICorner")
MinimizeCorner.CornerRadius = UDim.new(0, 6)
MinimizeCorner.Parent = MinimizeButton

-- Reopen Button
local ReopenButton = Instance.new("TextButton")
ReopenButton.Size = UDim2.new(0, 50, 0, 30)
ReopenButton.Position = UDim2.new(0, 10, 0, 10)
ReopenButton.BackgroundColor3 = Color3.fromRGB(66, 92, 142)
ReopenButton.Text = "Open"
ReopenButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ReopenButton.TextSize = 16
ReopenButton.Font = Enum.Font.SourceSans
ReopenButton.Visible = false
ReopenButton.Parent = ScreenGui
local ReopenCorner = Instance.new("UICorner")
ReopenCorner.CornerRadius = UDim.new(0, 6)
ReopenCorner.Parent = ReopenButton

MinimizeButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    ReopenButton.Visible = true
end)

ReopenButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    ReopenButton.Visible = false
end)

-- Tab Container
local TabContainer = Instance.new("Frame")
TabContainer.Size = UDim2.new(1, -20, 0, 40)
TabContainer.Position = UDim2.new(0, 10, 0, 40)
TabContainer.BackgroundTransparency = 1
TabContainer.Parent = MainFrame

-- Tab Content Frame
local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, -20, 1, -90)
ContentFrame.Position = UDim2.new(0, 10, 0, 80)
ContentFrame.BackgroundColor3 = Color3.fromRGB(46, 72, 122)
ContentFrame.BorderSizePixel = 0
ContentFrame.Parent = MainFrame
local ContentCorner = Instance.new("UICorner")
ContentCorner.CornerRadius = UDim.new(0, 8)
ContentCorner.Parent = ContentFrame

-- Tab System
local Tabs = {}
local function createTab(name, contentCreator)
    local TabButton = Instance.new("TextButton")
    TabButton.Size = UDim2.new(0, 80, 0, 30)
    TabButton.Position = UDim2.new(0, #Tabs * 90, 0, 5)
    TabButton.BackgroundColor3 = Color3.fromRGB(46, 72, 122)
    TabButton.Text = name
    TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabButton.TextSize = 14
    TabButton.Font = Enum.Font.SourceSans
    TabButton.Parent = TabContainer
    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim.new(0, 6)
    ButtonCorner.Parent = TabButton

    local TabContent = Instance.new("Frame")
    TabContent.Size = UDim2.new(1, 0, 1, 0)
    TabContent.BackgroundTransparency = 1
    TabContent.Visible = false
    TabContent.Parent = ContentFrame

    -- Safely call the content creator function
    local success, errorMsg = pcall(contentCreator, TabContent)
    if not success then
        warn("Error creating tab " .. name .. ": " .. errorMsg)
    end

    TabButton.MouseButton1Click:Connect(function()
        for _, tab in pairs(Tabs) do
            tab.Content.Visible = false
            tab.Button.BackgroundColor3 = Color3.fromRGB(46, 72, 122)
        end
        TabContent.Visible = true
        TabButton.BackgroundColor3 = Color3.fromRGB(66, 92, 142)
    end)

    table.insert(Tabs, {Button = TabButton, Content = TabContent})
end

-- Auto-Farm Tab
createTab("Auto-Farm", function(TabContent)
    local ToggleFarm = Instance.new("TextButton")
    ToggleFarm.Size = UDim2.new(0, 150, 0, 40)
    ToggleFarm.Position = UDim2.new(0, 10, 0, 10)
    ToggleFarm.BackgroundColor3 = Color3.fromRGB(66, 92, 142)
    ToggleFarm.Text = "Auto-Farm: OFF"
    ToggleFarm.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleFarm.TextSize = 16
    ToggleFarm.Font = Enum.Font.SourceSans
    ToggleFarm.Parent = TabContent
    local FarmCorner = Instance.new("UICorner")
    FarmCorner.CornerRadius = UDim.new(0, 6)
    FarmCorner.Parent = ToggleFarm

    local isFarming = false
    ToggleFarm.MouseButton1Click:Connect(function()
        isFarming = not isFarming
        ToggleFarm.Text = "Auto-Farm: " .. (isFarming and "ON" or "OFF")
        if isFarming then
            getgenv().Settings = {
                AutoQuest = true,
                AutoKill = true,
                ServerHop = true,
                AntiBan = true,
                MaxLevel = 2650
            }
            spawn(function()
                while isFarming and Settings.AutoQuest and Players.LocalPlayer.Data.Level.Value < Settings.MaxLevel do
                    pcall(function()
                        local playerLevel = Players.LocalPlayer.Data.Level.Value
                        local questNPCs = {}
                        for _, npc in pairs(game:GetService("Workspace").NPCs:GetChildren()) do
                            if npc:IsA("Model") and npc:FindFirstChild("Head") then
                                local questLevel = tonumber(npc.Name:match("%d+")) or 0
                                if questLevel <= playerLevel + 50 and questLevel >= playerLevel - 50 then
                                    table.insert(questNPCs, npc)
                                end
                            end
                        end
                        if #questNPCs > 0 then
                            local targetNPC = questNPCs[math.random(1, #questNPCs)]
                            local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Linear)
                            TweenService:Create(
                                Players.LocalPlayer.Character.HumanoidRootPart,
                                tweenInfo,
                                {CFrame = targetNPC.Head.CFrame + Vector3.new(0, 5, 0)}
                            ):Play()
                            wait(0.4)
                            ReplicatedStorage.Remotes.CommF_:InvokeServer("StartQuest", targetNPC.Name)
                            wait(0.2)
                            for _, mob in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                if mob:IsA("Model") and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
                                    Players.LocalPlayer.Character.HumanoidRootPart.CFrame = mob.HumanoidRootPart.CFrame
                                    wait(0.05)
                                    mob.Humanoid.Health = 0
                                end
                            end
                        end
                        if Settings.ServerHop and math.random() < 0.2 then
                            wait(math.random(3, 7))
                            TeleportService:Teleport(game.PlaceId)
                        end
                    end)
                    wait(2)
                end
            end)
        end
    end)

    local ToggleBoss = Instance.new("TextButton")
    ToggleBoss.Size = UDim2.new(0, 150, 0, 40)
    ToggleBoss.Position = UDim2.new(0, 170, 0, 10)
    ToggleBoss.BackgroundColor3 = Color3.fromRGB(66, 92, 142)
    ToggleBoss.Text = "Auto Boss: OFF"
    ToggleBoss.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleBoss.TextSize = 16
    ToggleBoss.Font = Enum.Font.SourceSans
    ToggleBoss.Parent = TabContent
    local BossCorner = Instance.new("UICorner")
    BossCorner.CornerRadius = UDim.new(0, 6)
    BossCorner.Parent = ToggleBoss

    local isBossFarming = false
    ToggleBoss.MouseButton1Click:Connect(function()
        isBossFarming = not isBossFarming
        ToggleBoss.Text = "Auto Boss: " .. (isBossFarming and "ON" or "OFF")
        if isBossFarming then
            spawn(function()
                while isBossFarming do
                    pcall(function()
                        for _, boss in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                            if boss:IsA("Model") and boss:FindFirstChild("Humanoid") and boss.Name:find("Boss") and boss.Humanoid.Health > 0 then
                                local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Linear)
                                TweenService:Create(
                                    Players.LocalPlayer.Character.HumanoidRootPart,
                                    tweenInfo,
                                    {CFrame = boss.HumanoidRootPart.CFrame}
                                ):Play()
                                wait(0.4)
                                boss.Humanoid.Health = 0
                            end
                        end
                    end)
                    wait(2)
                end
            end)
        end
    end)

    local ToggleRaid = Instance.new("TextButton")
    ToggleRaid.Size = UDim2.new(0, 150, 0, 40)
    ToggleRaid.Position = UDim2.new(0, 330, 0, 10)
    ToggleRaid.BackgroundColor3 = Color3.fromRGB(66, 92, 142)
    ToggleRaid.Text = "Auto Raid: OFF"
    ToggleRaid.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleRaid.TextSize = 16
    ToggleRaid.Font = Enum.Font.SourceSans
    ToggleRaid.Parent = TabContent
    local RaidCorner = Instance.new("UICorner")
    RaidCorner.CornerRadius = UDim.new(0, 6)
    RaidCorner.Parent = ToggleRaid

    local isRaiding = false
    ToggleRaid.MouseButton1Click:Connect(function()
        isRaiding = not isRaiding
        ToggleRaid.Text = "Auto Raid: " .. (isRaiding and "ON" or "OFF")
        if isRaiding then
            spawn(function()
                while isRaiding do
                    pcall(function()
                        ReplicatedStorage.Remotes.CommF_:InvokeServer("RaidsNpc", "Select", "Flame")
                        wait(0.3)
                        local raidIsland = game:GetService("Workspace").Map.RaidMap
                        if raidIsland then
                            local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Linear)
                            TweenService:Create(
                                Players.LocalPlayer.Character.HumanoidRootPart,
                                tweenInfo,
                                {CFrame = raidIsland:GetChildren()[1].CFrame}
                            ):Play()
                            wait(0.4)
                            for _, enemy in pairs(raidIsland:GetDescendants()) do
                                if enemy:IsA("Model") and enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
                                    enemy.HumanoidRootPart.CFrame = Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                                    enemy.Humanoid.Health = 0
                                end
                            end
                        end
                    end)
                    wait(6)
                end
            end)
        end
    end)

    local ToggleMastery = Instance.new("TextButton")
    ToggleMastery.Size = UDim2.new(0, 150, 0, 40)
    ToggleMastery.Position = UDim2.new(0, 10, 0, 60)
    ToggleMastery.BackgroundColor3 = Color3.fromRGB(66, 92, 142)
    ToggleMastery.Text = "Auto Mastery: OFF"
    ToggleMastery.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleMastery.TextSize = 16
    ToggleMastery.Font = Enum.Font.SourceSans
    ToggleMastery.Parent = TabContent
    local MasteryCorner = Instance.new("UICorner")
    MasteryCorner.CornerRadius = UDim.new(0, 6)
    MasteryCorner.Parent = ToggleMastery

    local isMastery = false
    ToggleMastery.MouseButton1Click:Connect(function()
        isMastery = not isMastery
        ToggleMastery.Text = "Auto Mastery: " .. (isMastery and "ON" or "OFF")
        if isMastery then
            spawn(function()
                while isMastery do
                    pcall(function()
                        local equippedTool = Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
                        if equippedTool then
                            for _, mob in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                if mob:IsA("Model") and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
                                    Players.LocalPlayer.Character.HumanoidRootPart.CFrame = mob.HumanoidRootPart.CFrame
                                    wait(0.05)
                                    ReplicatedStorage.Remotes.CommF_:InvokeServer("UseAbility", equippedTool.Name)
                                    mob.Humanoid.Health = 0
                                end
                            end
                        end
                    end)
                    wait(1.5)
                end
            end)
        end
    end)
end)

-- ESP Tab
createTab("ESP", function(TabContent)
    local ToggleESP = Instance.new("TextButton")
    ToggleESP.Size = UDim2.new(0, 150, 0, 40)
    ToggleESP.Position = UDim2.new(0, 10, 0, 10)
    ToggleESP.BackgroundColor3 = Color3.fromRGB(66, 92, 142)
    ToggleESP.Text = "ESP: OFF"
    ToggleESP.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleESP.TextSize = 16
    ToggleESP.Font = Enum.Font.SourceSans
    ToggleESP.Parent = TabContent
    local ESPCorner = Instance.new("UICorner")
    ESPCorner.CornerRadius = UDim.new(0, 6)
    ESPCorner.Parent = ToggleESP

    local isESP = false
    local highlights = {}
    ToggleESP.MouseButton1Click:Connect(function()
        isESP = not isESP
        ToggleESP.Text = "ESP: " .. (isESP and "ON" or "OFF")
        if isESP then
            spawn(function()
                while isESP do
                    pcall(function()
                        for _, obj in pairs(game:GetService("Workspace"):GetChildren()) do
                            if (obj:IsA("Model") and obj:FindFirstChild("Humanoid")) or obj.Name:find("Fruit") then
                                if not highlights[obj] then
                                    local highlight = Instance.new("Highlight")
                                    highlight.FillColor = obj:FindFirstChild("Humanoid") and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(0, 255, 0)
                                    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                                    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                                    highlight.Parent = obj
                                    highlights[obj] = highlight
                                end
                            end
                        end
                    end)
                    wait(0.2)
                end
            end)
        else
            for obj, highlight in pairs(highlights) do
                highlight:Destroy()
            end
            highlights = {}
        end
    end)

    local ToggleFruitSniper = Instance.new("TextButton")
    ToggleFruitSniper.Size = UDim2.new(0, 150, 0, 40)
    ToggleFruitSniper.Position = UDim2.new(0, 170, 0, 10)
    ToggleFruitSniper.BackgroundColor3 = Color3.fromRGB(66, 92, 142)
    ToggleFruitSniper.Text = "Fruit Sniper: OFF"
    ToggleFruitSniper.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleFruitSniper.TextSize = 16
    ToggleFruitSniper.Font = Enum.Font.SourceSans
    ToggleFruitSniper.Parent = TabContent
    local SniperCorner = Instance.new("UICorner")
    SniperCorner.CornerRadius = UDim.new(0, 6)
    SniperCorner.Parent = ToggleFruitSniper

    local isSniping = false
    ToggleFruitSniper.MouseButton1Click:Connect(function()
        isSniping = not isSniping
        ToggleFruitSniper.Text = "Fruit Sniper: " .. (isSniping and "ON" or "OFF")
        if isSniping then
            spawn(function()
                while isSniping do
                    pcall(function()
                        for _, fruit in pairs(game:GetService("Workspace"):GetChildren()) do
                            if fruit:IsA("Model") and fruit.Name:find("Fruit") and fruit:FindFirstChild("Handle") then
                                local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Linear)
                                TweenService:Create(
                                    Players.LocalPlayer.Character.HumanoidRootPart,
                                    tweenInfo,
                                    {CFrame = fruit.Handle.CFrame}
                                ):Play()
                                wait(0.3)
                                ReplicatedStorage.Remotes.CommF_:InvokeServer("StoreFruit", fruit.Name)
                                break
                            end
                        end
                    end)
                    wait(0.8)
                end
            end)
        end
    end)
end)

-- Stats Tab
createTab("Stats", function(TabContent)
    local StatsLabel = Instance.new("TextLabel")
    StatsLabel.Size = UDim2.new(1, -20, 0, 150)
    StatsLabel.Position = UDim2.new(0, 10, 0, 10)
    StatsLabel.BackgroundTransparency = 1
    StatsLabel.Text = "Level: Loading..."
    StatsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    StatsLabel.TextSize = 16
    StatsLabel.Font = Enum.Font.SourceSans
    StatsLabel.TextWrapped = true
    StatsLabel.TextYAlignment = Enum.TextYAlignment.Top
    StatsLabel.Parent = TabContent

    spawn(function()
        while true do
            pcall(function()
                local player = Players.LocalPlayer
                StatsLabel.Text = string.format(
                    "Level: %d\nBeli: %d\nFragments: %d\nFruit: %s\nHaki: %s\nMastery: %d",
                    player.Data.Level.Value,
                    player.Data.Beli.Value,
                    player.Data.Fragments.Value,
                    player.Data.DevilFruit.Value or "None",
                    player.Data.Haki.Value or "None",
                    player.Data.Mastery.Value or 0
                )
            end)
            wait(0.8)
        end
    end)

    local ToggleAutoStats = Instance.new("TextButton")
    ToggleAutoStats.Size = UDim2.new(0, 150, 0, 40)
    ToggleAutoStats.Position = UDim2.new(0, 10, 0, 170)
    ToggleAutoStats.BackgroundColor3 = Color3.fromRGB(66, 92, 142)
    ToggleAutoStats.Text = "Auto Stats: OFF"
    ToggleAutoStats.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleAutoStats.TextSize = 16
    ToggleAutoStats.Font = Enum.Font.SourceSans
    ToggleAutoStats.Parent = TabContent
    local StatsCorner = Instance.new("UICorner")
    StatsCorner.CornerRadius = UDim.new(0, 6)
    StatsCorner.Parent = ToggleAutoStats

    local isAutoStats = false
    ToggleAutoStats.MouseButton1Click:Connect(function()
        isAutoStats = not isAutoStats
        ToggleAutoStats.Text = "Auto Stats: " .. (isAutoStats and "ON" or "OFF")
        if isAutoStats then
            spawn(function()
                while isAutoStats do
                    pcall(function()
                        ReplicatedStorage.Remotes.CommF_:InvokeServer("AddPoint", "Melee", 10)
                    end)
                    wait(4)
                end
            end)
        end
    end)
end)

-- Extras Tab
createTab("Extras", function(TabContent)
    local TPFruit = Instance.new("TextButton")
    TPFruit.Size = UDim2.new(0, 150, 0, 40)
    TPFruit.Position = UDim2.new(0, 10, 0, 10)
    TPFruit.BackgroundColor3 = Color3.fromRGB(66, 92, 142)
    TPFruit.Text = "Teleport to Fruit"
    TPFruit.TextColor3 = Color3.fromRGB(255, 255, 255)
    TPFruit.TextSize = 16
    TPFruit.Font = Enum.Font.SourceSans
    TPFruit.Parent = TabContent
    local FruitCorner = Instance.new("UICorner")
    FruitCorner.CornerRadius = UDim.new(0, 6)
    FruitCorner.Parent = TPFruit

    TPFruit.MouseButton1Click:Connect(function()
        pcall(function()
            for _, fruit in pairs(game:GetService("Workspace"):GetChildren()) do
                if fruit:IsA("Model") and fruit.Name:find("Fruit") and fruit:FindFirstChild("Handle") then
                    local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Linear)
                    TweenService:Create(
                        Players.LocalPlayer.Character.HumanoidRootPart,
                        tweenInfo,
                        {CFrame = fruit.Handle.CFrame}
                    ):Play()
                    wait(0.3)
                    break
                end
            end
        end)
    end)

    local AutoAwaken = Instance.new("TextButton")
    AutoAwaken.Size = UDim2.new(0, 150, 0, 40)
    AutoAwaken.Position = UDim2.new(0, 170, 0, 10)
    AutoAwaken.BackgroundColor3 = Color3.fromRGB(66, 92, 142)
    AutoAwaken.Text = "Auto Awaken: OFF"
    AutoAwaken.TextColor3 = Color3.fromRGB(255, 255, 255)
    AutoAwaken.TextSize = 16
    AutoAwaken.Font = Enum.Font.SourceSans
    AutoAwaken.Parent = TabContent
    local AwakenCorner = Instance.new("UICorner")
    AwakenCorner.CornerRadius = UDim.new(0, 6)
    AwakenCorner.Parent = AutoAwaken

    local isAwakening = false
    AutoAwaken.MouseButton1Click:Connect(function()
        isAwakening = not isAwakening
        AutoAwaken.Text = "Auto Awaken: " .. (isAwakening and "ON" or "OFF")
        if isAwakening then
            spawn(function()
                while isAwakening do
                    pcall(function()
                        ReplicatedStorage.Remotes.CommF_:InvokeServer("Awakener", "Check")
                        ReplicatedStorage.Remotes.CommF_:InvokeServer("Awakener", "Awaken")
                    end)
                    wait(6)
                end
            end)
        end
    end)

    local AutoHaki = Instance.new("TextButton")
    AutoHaki.Size = UDim2.new(0, 150, 0, 40)
    AutoHaki.Position = UDim2.new(0, 330, 0, 10)
    AutoHaki.BackgroundColor3 = Color3.fromRGB(66, 92, 142)
    AutoHaki.Text = "Auto Haki V2: OFF"
    AutoHaki.TextColor3 = Color3.fromRGB(255, 255, 255)
    AutoHaki.TextSize = 16
    AutoHaki.Font = Enum.Font.SourceSans
    AutoHaki.Parent = TabContent
    local HakiCorner = Instance.new("UICorner")
    HakiCorner.CornerRadius = UDim.new(0, 6)
    HakiCorner.Parent = AutoHaki

    local isHaki = false
    AutoHaki.MouseButton1Click:Connect(function()
        isHaki = not isHaki
        AutoHaki.Text = "Auto Haki V2: " .. (isHaki and "ON" or "OFF")
        if isHaki then
            spawn(function()
                while isHaki do
                    pcall(function()
                        ReplicatedStorage.Remotes.CommF_:InvokeServer("KenTalk", "Start")
                        wait(0.3)
                        ReplicatedStorage.Remotes.CommF_:InvokeServer("KenTalk", "Buy")
                    end)
                    wait(10)
                end
            end)
        end
    end)

    local AutoGear5 = Instance.new("TextButton")
    AutoGear5.Size = UDim2.new(0, 150, 0, 40)
    AutoGear5.Position = UDim2.new(0, 10, 0, 60)
    AutoGear5.BackgroundColor3 = Color3.fromRGB(66, 92, 142)
    AutoGear5.Text = "Auto Gear 5: OFF"
    AutoGear5.TextColor3 = Color3.fromRGB(255, 255, 255)
    AutoGear5.TextSize = 16
    AutoGear5.Font = Enum.Font.SourceSans
    AutoGear5.Parent = TabContent
    local Gear5Corner = Instance.new("UICorner")
    Gear5Corner.CornerRadius = UDim.new(0, 6)
    Gear5Corner.Parent = AutoGear5

    local isGear5 = false
    AutoGear5.MouseButton1Click:Connect(function()
        isGear5 = not isGear5
        AutoGear5.Text = "Auto Gear 5: " .. (isGear5 and "ON" or "OFF")
        if isGear5 then
            spawn(function()
                while isGear5 do
                    pcall(function()
                        if Players.LocalPlayer.Data.DevilFruit.Value == "Gomu-Gomu" then
                            ReplicatedStorage.Remotes.CommF_:InvokeServer("Awakener", "Gear5")
                        end
                    end)
                    wait(12)
                end
            end)
        end
    end)

    local TPSafeZone = Instance.new("TextButton")
    TPSafeZone.Size = UDim2.new(0, 150, 0, 40)
    TPSafeZone.Position = UDim2.new(0, 170, 0, 60)
    TPSafeZone.BackgroundColor3 = Color3.fromRGB(66, 92, 142)
    TPSafeZone.Text = "Safe Zone TP"
    TPSafeZone.TextColor3 = Color3.fromRGB(255, 255, 255)
    TPSafeZone.TextSize = 16
    TPSafeZone.Font = Enum.Font.SourceSans
    TPSafeZone.Parent = TabContent
    local SafeZoneCorner = Instance.new("UICorner")
    SafeZoneCorner.CornerRadius = UDim.new(0, 6)
    SafeZoneCorner.Parent = TPSafeZone

    TPSafeZone.MouseButton1Click:Connect(function()
        pcall(function()
            local safeZones = game:GetService("Workspace").SafeZones
            if safeZones and safeZones:GetChildren()[1] then
                local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Linear)
                TweenService:Create(
                    Players.LocalPlayer.Character.HumanoidRootPart,
                    tweenInfo,
                    {CFrame = safeZones:GetChildren()[1].CFrame}
                ):Play()
            end
        end)
    end)

    local ToggleFastAttack = Instance.new("TextButton")
    ToggleFastAttack.Size = UDim2.new(0, 150, 0, 40)
    ToggleFastAttack.Position = UDim2.new(0, 330, 0, 60)
    ToggleFastAttack.BackgroundColor3 = Color3.fromRGB(66, 92, 142)
    ToggleFastAttack.Text = "Fast Attack: OFF"
    ToggleFastAttack.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleFastAttack.TextSize = 16
    ToggleFastAttack.Font = Enum.Font.SourceSans
    ToggleFastAttack.Parent = TabContent
    local FastAttackCorner = Instance.new("UICorner")
    FastAttackCorner.CornerRadius = UDim.new(0, 6)
    FastAttackCorner.Parent = ToggleFastAttack

    local isFastAttack = false
    ToggleFastAttack.MouseButton1Click:Connect(function()
        isFastAttack = not isFastAttack
        ToggleFastAttack.Text = "Fast Attack: " .. (isFastAttack and "ON" or "OFF")
        if isFastAttack then
            spawn(function()
                while isFastAttack do
                    pcall(function()
                        local equippedTool = Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
                        if equippedTool then
                            ReplicatedStorage.Remotes.CommF_:InvokeServer("UseAbility", equippedTool.Name)
                            wait(0.05)
                        end
                    end)
                    wait(0.1)
                end
            end)
        end
    end)

    local ToggleRaceV4 = Instance.new("TextButton")
    ToggleRaceV4.Size = UDim2.new(0, 150, 0, 40)
    ToggleRaceV4.Position = UDim2.new(0, 10, 0, 110)
    ToggleRaceV4.BackgroundColor3 = Color3.fromRGB(66, 92, 142)
    ToggleRaceV4.Text = "Race V4: OFF"
    ToggleRaceV4.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleRaceV4.TextSize = 16
    ToggleRaceV4.Font = Enum.Font.SourceSans
    ToggleRaceV4.Parent = TabContent
    local RaceV4Corner = Instance.new("UICorner")
    RaceV4Corner.CornerRadius = UDim.new(0, 6)
    RaceV4Corner.Parent = ToggleRaceV4

    local isRaceV4 = false
    ToggleRaceV4.MouseButton1Click:Connect(function()
        isRaceV4 = not isRaceV4
        ToggleRaceV4.Text = "Race V4: " .. (isRaceV4 and "ON" or "OFF")
        if isRaceV4 then
            spawn(function()
                while isRaceV4 do
                    pcall(function()
                        ReplicatedStorage.Remotes.CommF_:InvokeServer("Alchemist", "1")
                        wait(0.3)
                        ReplicatedStorage.Remotes.CommF_:InvokeServer("Alchemist", "2")
                        wait(0.3)
                        ReplicatedStorage.Remotes.CommF_:InvokeServer("Alchemist", "3")
                        wait(0.3)
                        ReplicatedStorage.Remotes.CommF_:InvokeServer("RaceV4Progress", "Check")
                        wait(0.3)
                        ReplicatedStorage.Remotes.CommF_:InvokeServer("RaceV4Progress", "Start")
                    end)
                    wait(15)
                end
            end)
        end
    end)
end)

-- Config Tab
createTab("Config", function(TabContent)
    local ConfigInput = Instance.new("TextBox")
    ConfigInput.Size = UDim2.new(0, 200, 0, 40)
    ConfigInput.Position = UDim2.new(0, 10, 0, 10)
    ConfigInput.BackgroundColor3 = Color3.fromRGB(66, 92, 142)
    ConfigInput.Text = "Enter Config Name"
    ConfigInput.TextColor3 = Color3.fromRGB(255, 255, 255)
    ConfigInput.TextSize = 16
    ConfigInput.Font = Enum.Font.SourceSans
    ConfigInput.Parent = TabContent
    local InputCorner = Instance.new("UICorner")
    InputCorner.CornerRadius = UDim.new(0, 6)
    InputCorner.Parent = ConfigInput

    local SaveConfig = Instance.new("TextButton")
    SaveConfig.Size = UDim2.new(0, 100, 0, 40)
    SaveConfig.Position = UDim2.new(0, 220, 0, 10)
    SaveConfig.BackgroundColor3 = Color3.fromRGB(66, 92, 142)
    SaveConfig.Text = "Save Config"
    SaveConfig.TextColor3 = Color3.fromRGB(255, 255, 255)
    SaveConfig.TextSize = 16
    SaveConfig.Font = Enum.Font.SourceSans
    SaveConfig.Parent = TabContent
    local SaveCorner = Instance.new("UICorner")
    SaveCorner.CornerRadius = UDim.new(0, 6)
    SaveCorner.Parent = SaveConfig

    local LoadConfig = Instance.new("TextButton")
    LoadConfig.Size = UDim2.new(0, 100, 0, 40)
    LoadConfig.Position = UDim2.new(0, 220, 0, 60)
    LoadConfig.BackgroundColor3 = Color3.fromRGB(66, 92, 142)
    LoadConfig.Text = "Load Config"
    LoadConfig.TextColor3 = Color3.fromRGB(255, 255, 255)
    LoadConfig.TextSize = 16
    LoadConfig.Font = Enum.Font.SourceSans
    LoadConfig.Parent = TabContent
    local LoadCorner = Instance.new("UICorner")
    LoadCorner.CornerRadius = UDim.new(0, 6)
    LoadCorner.Parent = LoadConfig

    local configData = {
        AutoFarm = false,
        AutoBoss = false,
        AutoRaid = false,
        ESP = false,
        AutoAwaken = false,
        AutoHaki = false,
        AutoGear5 = false,
        FruitSniper = false,
        AutoMastery = false,
        AutoStats = false,
        FastAttack = false,
        RaceV4 = false
    }

    SaveConfig.MouseButton1Click:Connect(function()
        pcall(function()
            configData.AutoFarm = isFarming
            configData.AutoBoss = isBossFarming
            configData.AutoRaid = isRaiding
            configData.ESP = isESP
            configData.AutoAwaken = isAwakening
            configData.AutoHaki = isHaki
            configData.AutoGear5 = isGear5
            configData.FruitSniper = isSniping
            configData.AutoMastery = isMastery
            configData.AutoStats = isAutoStats
            configData.FastAttack = isFastAttack
            configData.RaceV4 = isRaceV4
            writefile("ChescoGUI_" .. ConfigInput.Text .. ".json", HttpService:JSONEncode(configData))
        end)
    end)

    LoadConfig.MouseButton1Click:Connect(function()
        pcall(function()
            local configName = ConfigInput.Text
            local data = HttpService:JSONDecode(readfile("ChescoGUI_" .. configName .. ".json"))
            isFarming = data.AutoFarm
            isBossFarming = data.AutoBoss
            isRaiding = data.AutoRaid
            isESP = data.ESP
            isAwakening = data.AutoAwaken
            isHaki = data.AutoHaki
            isGear5 = data.AutoGear5
            isSniping = data.FruitSniper
            isMastery = data.AutoMastery
            isAutoStats = data.AutoStats
            isFastAttack = data.FastAttack
            isRaceV4 = data.RaceV4
            ToggleFarm.Text = "Auto-Farm: " .. (isFarming and "ON" or "OFF")
            ToggleBoss.Text = "Auto Boss: " .. (isBossFarming and "ON" or "OFF")
            ToggleRaid.Text = "Auto Raid: " .. (isRaiding and "ON" or "OFF")
            ToggleESP.Text = "ESP: " .. (isESP and "ON" or "OFF")
            AutoAwaken.Text = "Auto Awaken: " .. (isAwakening and "ON" or "OFF")
            AutoHaki.Text = "Auto Haki V2: " .. (isHaki and "ON" or "OFF")
            AutoGear5.Text = "Auto Gear 5: " .. (isGear5 and "ON" or "OFF")
            ToggleFruitSniper.Text = "Fruit Sniper: " .. (isSniping and "ON" or "OFF")
            ToggleMastery.Text = "Auto Mastery: " .. (isMastery and "ON" or "OFF")
            ToggleAutoStats.Text = "Auto Stats: " .. (isAutoStats and "ON" or "OFF")
            ToggleFastAttack.Text = "Fast Attack: " .. (isFastAttack and "ON" or "OFF")
            ToggleRaceV4.Text = "Race V4: " .. (isRaceV4 and "ON" or "OFF")
        end)
    end)
end)

-- Make GUI Draggable
local dragging, dragInput, dragStart, startPos
MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)
MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
        dragInput = input
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

-- Anti-Ban Measures
spawn(function()
    while true do
        pcall(function()
            local ping = math.random(50, 200)
            wait(ping / 1000)
            ReplicatedStorage.Heartbeat:FireServer()
            if math.random() < 0.15 then
                Players.LocalPlayer.Character.Humanoid.Jump = true
            end
            if math.random() < 0.1 then
                Players.LocalPlayer.Character.Humanoid:Move(Vector3.new(math.random(-1, 1), 0, math.random(-1, 1)))
            end
        end)
        wait(math.random(2, 6))
    end
end)

-- Initialize Welcome Screen with Additional Checks
spawn(function()
    if playerGui then
        WelcomeScreen.Enabled = true
        playWelcomeAnimation()
    else
        warn("PlayerGui not found. GUI may not display correctly.")
    end
end)

EnterButton.MouseButton1Click:Connect(function()
    WelcomeScreen.Enabled = false
    ScreenGui.Enabled = true
    if #Tabs > 0 then
        Tabs[1].Button.BackgroundColor3 = Color3.fromRGB(66, 92, 142)
        Tabs[1].Content.Visible = true
    end
end)

-- Ensure GUI Stability with Enhanced Checks
spawn(function()
    wait(2)
    if not WelcomeScreen.Enabled and not ScreenGui.Enabled then
        WelcomeScreen.Enabled = true
        playWelcomeAnimation()
    end
    RunService:BindToRenderStep("GUICheck", Enum.RenderPriority.Camera.Value, function()
        if not ScreenGui.Parent or ScreenGui.Parent ~= playerGui then
            ScreenGui.Parent = playerGui
            ScreenGui.Enabled = false
            WelcomeScreen.Enabled = true
            playWelcomeAnimation()
        end
        if not WelcomeScreen.Parent or WelcomeScreen.Parent ~= playerGui then
            WelcomeScreen.Parent = playerGui
        end
    end)
end)

-- Debug Log for Executor Compatibility
print("Chesco's Blox Fruits GUI v4.3 loaded successfully at " .. os.date("%Y-%m-%d %H:%M:%S"))
