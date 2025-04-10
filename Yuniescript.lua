-- Yunie Script for Blox Fruit
-- Version 1.0.0

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local VirtualUser = game:GetService("VirtualUser")

-- Cài đặt script
local Settings = {
    AimSkill = {
        Enabled = false,
        SilentAim = false,
        FOVRadius = 150,
        HitboxSize = 5
    },
    AutoKill = {
        Enabled = false,
        Range = 1000
    },
    AutoFarm = {
        Enabled = false,
        Type = "Level"
    },
    Utility = {
        AntiAFK = true
    }
}

-- Anti AFK
LocalPlayer.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

-- Tạo giao diện
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "YunieScript"
ScreenGui.Parent = game:GetService("CoreGui")

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(255, 209, 220) -- Hồng nhạt
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -175)
MainFrame.Size = UDim2.new(0, 500, 0, 350)
MainFrame.Active = true
MainFrame.Draggable = true

local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Parent = MainFrame
TitleBar.BackgroundColor3 = Color3.fromRGB(255, 182, 193)
TitleBar.BorderSizePixel = 0
TitleBar.Position = UDim2.new(0, 0, 0, 0)
TitleBar.Size = UDim2.new(1, 0, 0, 30)

local TitleText = Instance.new("TextLabel")
TitleText.Name = "TitleText"
TitleText.Parent = TitleBar
TitleText.BackgroundTransparency = 1
TitleText.Position = UDim2.new(0, 10, 0, 0)
TitleText.Size = UDim2.new(1, -20, 1, 0)
TitleText.Font = Enum.Font.GothamBold
TitleText.Text = "Yunie Script"
TitleText.TextColor3 = Color3.fromRGB(33, 33, 33)
TitleText.TextSize = 18
TitleText.TextXAlignment = Enum.TextXAlignment.Left

local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Parent = TitleBar
CloseButton.BackgroundTransparency = 1
CloseButton.Position = UDim2.new(1, -30, 0, 0)
CloseButton.Size = UDim2.new(0, 30, 1, 0)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(33, 33, 33)
CloseButton.TextSize = 18

-- Hàm tạo toggle
local function CreateToggle(parent, text, position, callback)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Name = text .. "Toggle"
    ToggleFrame.Parent = parent
    ToggleFrame.BackgroundTransparency = 1
    ToggleFrame.Position = position
    ToggleFrame.Size = UDim2.new(0, 200, 0, 30)
    
    local ToggleLabel = Instance.new("TextLabel")
    ToggleLabel.Name = "Label"
    ToggleLabel.Parent = ToggleFrame
    ToggleLabel.BackgroundTransparency = 1
    ToggleLabel.Position = UDim2.new(0, 40, 0, 0)
    ToggleLabel.Size = UDim2.new(1, -40, 1, 0)
    ToggleLabel.Font = Enum.Font.Gotham
    ToggleLabel.Text = text
    ToggleLabel.TextColor3 = Color3.fromRGB(33, 33, 33)
    ToggleLabel.TextSize = 14
    ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    local ToggleButton = Instance.new("Frame")
    ToggleButton.Name = "Button"
    ToggleButton.Parent = ToggleFrame
    ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 182, 193)
    ToggleButton.BorderSizePixel = 0
    ToggleButton.Position = UDim2.new(0, 0, 0.5, -10)
    ToggleButton.Size = UDim2.new(0, 30, 0, 20)
    
    local ToggleCircle = Instance.new("Frame")
    ToggleCircle.Name = "Circle"
    ToggleCircle.Parent = ToggleButton
    ToggleCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ToggleCircle.BorderSizePixel = 0
    ToggleCircle.Position = UDim2.new(0, 2, 0.5, -8)
    ToggleCircle.Size = UDim2.new(0, 16, 0, 16)
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(1, 0)
    UICorner.Parent = ToggleCircle
    
    local UICorner2 = Instance.new("UICorner")
    UICorner2.CornerRadius = UDim.new(1, 0)
    UICorner2.Parent = ToggleButton
    
    local enabled = false
    
    local function updateToggle()
        if enabled then
            ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
            ToggleCircle:TweenPosition(UDim2.new(0, 12, 0.5, -8), Enum.EasingDirection.InOut, Enum.EasingStyle.Quad, 0.2, true)
        else
            ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 182, 193)
            ToggleCircle:TweenPosition(UDim2.new(0, 2, 0.5, -8), Enum.EasingDirection.InOut, Enum.EasingStyle.Quad, 0.2, true)
        end
        
        if callback then
            callback(enabled)
        end
    end
    
    ToggleButton.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            enabled = not enabled
            updateToggle()
        end
    end)
    
    ToggleLabel.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            enabled = not enabled
            updateToggle()
        end
    end)
    
    return {
        Frame = ToggleFrame,
        SetEnabled = function(value)
            enabled = value
            updateToggle()
        end
    }
end

-- Tạo các tab
local TabContainer = Instance.new("Frame")
TabContainer.Name = "TabContainer"
TabContainer.Parent = MainFrame
TabContainer.BackgroundTransparency = 1
TabContainer.Position = UDim2.new(0, 10, 0, 40)
TabContainer.Size = UDim2.new(0, 480, 0, 30)

local TabContent = Instance.new("Frame")
TabContent.Name = "TabContent"
TabContent.Parent = MainFrame
TabContent.BackgroundTransparency = 0.5
TabContent.BackgroundColor3 = Color3.fromRGB(255, 209, 220)
TabContent.BorderSizePixel = 0
TabContent.Position = UDim2.new(0, 10, 0, 80)
TabContent.Size = UDim2.new(0, 480, 0, 260)

-- Tạo các tab
local tabs = {"Main", "Farm", "Combat", "Misc"}
local tabButtons = {}
local tabFrames = {}

for i, tabName in ipairs(tabs) do
    local TabButton = Instance.new("TextButton")
    TabButton.Name = tabName .. "Tab"
    TabButton.Parent = TabContainer
    TabButton.BackgroundColor3 = i == 1 and Color3.fromRGB(255, 105, 180) or Color3.fromRGB(255, 182, 193)
    TabButton.BorderSizePixel = 0
    TabButton.Position = UDim2.new((i-1) * (1/#tabs), 0, 0, 0)
    TabButton.Size = UDim2.new(1/#tabs, 0, 1, 0)
    TabButton.Font = Enum.Font.Gotham
    TabButton.Text = tabName
    TabButton.TextColor3 = Color3.fromRGB(33, 33, 33)
    TabButton.TextSize = 14
    
    local TabFrame = Instance.new("Frame")
    TabFrame.Name = tabName .. "Frame"
    TabFrame.Parent = TabContent
    TabFrame.BackgroundTransparency = 1
    TabFrame.Size = UDim2.new(1, 0, 1, 0)
    TabFrame.Visible = i == 1
    
    tabButtons[tabName] = TabButton
    tabFrames[tabName] = TabFrame
    
    TabButton.MouseButton1Click:Connect(function()
        for _, btn in pairs(tabButtons) do
            btn.BackgroundColor3 = Color3.fromRGB(255, 182, 193)
        end
        for _, frm in pairs(tabFrames) do
            frm.Visible = false
        end
        TabFrame.Visible = true
        TabButton.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
    end)
end

-- Tạo nội dung cho tab Main
local WelcomeLabel = Instance.new("TextLabel")
WelcomeLabel.Name = "WelcomeLabel"
WelcomeLabel.Parent = tabFrames["Main"]
WelcomeLabel.BackgroundTransparency = 1
WelcomeLabel.Position = UDim2.new(0, 0, 0, 10)
WelcomeLabel.Size = UDim2.new(1, 0, 0, 30)
WelcomeLabel.Font = Enum.Font.GothamBold
WelcomeLabel.Text = "Welcome to Yunie Script"
WelcomeLabel.TextColor3 = Color3.fromRGB(33, 33, 33)
WelcomeLabel.TextSize = 18

local VersionLabel = Instance.new("TextLabel")
VersionLabel.Name = "VersionLabel"
VersionLabel.Parent = tabFrames["Main"]
VersionLabel.BackgroundTransparency = 1
VersionLabel.Position = UDim2.new(0, 0, 0, 40)
VersionLabel.Size = UDim2.new(1, 0, 0, 20)
VersionLabel.Font = Enum.Font.Gotham
VersionLabel.Text = "Version: 1.0.0"
VersionLabel.TextColor3 = Color3.fromRGB(33, 33, 33)
VersionLabel.TextSize = 14

-- Tạo nội dung cho tab Combat
local AimSkillToggle = CreateToggle(tabFrames["Combat"], "Aim Skill V4", UDim2.new(0, 10, 0, 10), function(enabled)
    Settings.AimSkill.Enabled = enabled
    if enabled then
        -- Thực hiện Aim Skill
        local connection
        connection = RunService.RenderStepped:Connect(function()
            if not Settings.AimSkill.Enabled then
                connection:Disconnect()
                return
            end
            
            -- Tìm người chơi gần nhất
            local closestPlayer = nil
            local shortestDistance = math.huge
            
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
                    local magnitude = (player.Character.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                    if magnitude < shortestDistance then
                        closestPlayer = player
                        shortestDistance = magnitude
                    end
                end
            end
            
            -- Ngắm vào người chơi gần nhất
            if closestPlayer and closestPlayer.Character then
                local targetPart = closestPlayer.Character:FindFirstChild("HumanoidRootPart")
                if targetPart then
                    -- Thực hiện ngắm
                    local camera = workspace.CurrentCamera
                    camera.CFrame = CFrame.new(camera.CFrame.Position, targetPart.Position)
                end
            end
        end)
    end
end)

local SilentAimToggle = CreateToggle(tabFrames["Combat"], "Silent Aim", UDim2.new(0, 10, 0, 50), function(enabled)
    Settings.AimSkill.SilentAim = enabled
end)

local AutoKillToggle = CreateToggle(tabFrames["Combat"], "Auto Kill Player", UDim2.new(0, 10, 0, 90), function(enabled)
    Settings.AutoKill.Enabled = enabled
    if enabled then
        -- Thực hiện Auto Kill
        local connection
        connection = RunService.Heartbeat:Connect(function()
            if not Settings.AutoKill.Enabled then
                connection:Disconnect()
                return
            end
            
            -- Tìm người chơi gần nhất
            local closestPlayer = nil
            local shortestDistance = math.huge
            
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
                    local magnitude = (player.Character.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                    if magnitude < shortestDistance and magnitude <= Settings.AutoKill.Range then
                        closestPlayer = player
                        shortestDistance = magnitude
                    end
                end
            end
            
            -- Tấn công người chơi gần nhất
            if closestPlayer and closestPlayer.Character then
                -- Di chuyển đến mục tiêu
                local humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
                if humanoid then
                    humanoid:MoveTo(closestPlayer.Character.HumanoidRootPart.Position)
                end
                
                -- Sử dụng các kỹ năng
                local skills = {"Z", "X", "C", "V", "F"}
                for _, skill in pairs(skills) do
                    game:GetService("VirtualInputManager"):SendKeyEvent(true, skill, false, game)
                    wait(0.1)
                    game:GetService("VirtualInputManager"):SendKeyEvent(false, skill, false, game)
                    wait(0.5)
                end
                
                -- Tấn công cận chiến
                game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, true, game, 1)
                wait(0.1)
                game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, false, game, 1)
            end
        end)
    end
end)

-- Tạo nội dung cho tab Farm
local AutoFarmToggle = CreateToggle(tabFrames["Farm"], "Auto Farm", UDim2.new(0, 10, 0, 10), function(enabled)
    Settings.AutoFarm.Enabled = enabled
    if enabled then
        -- Thực hiện Auto Farm
        local connection
        connection = RunService.Heartbeat:Connect(function()
            if not Settings.AutoFarm.Enabled then
                connection:Disconnect()
                return
            end
            
            -- Tìm NPC gần nhất
            local closestNPC = nil
            local shortestDistance = math.huge
            
            for _, npc in pairs(workspace:GetChildren()) do
                if npc:FindFirstChild("Humanoid") and npc:FindFirstChild("HumanoidRootPart") and npc.Humanoid.Health > 0 and npc:FindFirstChild("Humanoid") and not Players:GetPlayerFromCharacter(npc) then
                    local magnitude = (npc.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                    if magnitude < shortestDistance then
                        closestNPC = npc
                        shortestDistance = magnitude
                    end
                end
            end
            
            -- Tấn công NPC gần nhất
            if closestNPC then
                -- Di chuyển đến mục tiêu
                local humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
                if humanoid then
                    humanoid:MoveTo(closestNPC.HumanoidRootPart.Position)
                end
                
                -- Tấn công
                game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, true, game, 1)
                wait(0.1)
                game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, false, game, 1)
            end
        end)
    end
end)

local BossFarmToggle = CreateToggle(tabFrames["Farm"], "Boss Farm", UDim2.new(0, 10, 0, 50), function(enabled)
    Settings.AutoFarm.Type = enabled and "Boss" or "Level"
end)

local FruitFarmToggle = CreateToggle(tabFrames["Farm"], "Fruit Farm", UDim2.new(0, 10, 0, 90), function(enabled)
    Settings.AutoFarm.Type = enabled and "Fruit" or "Level"
end)

-- Tạo nội dung cho tab Misc
local AntiAFKToggle = CreateToggle(tabFrames["Misc"], "Anti AFK", UDim2.new(0, 10, 0, 10), function(enabled)
    Settings.Utility.AntiAFK = enabled
end)

-- Xử lý sự kiện đóng
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
    
    -- Ngắt kết nối tất cả các sự kiện
    for _, connection in pairs(getconnections(RunService.RenderStepped)) do
        connection:Disconnect()
    end
    
    for _, connection in pairs(getconnections(RunService.Heartbeat)) do
        connection:Disconnect()
    end
end)

-- Xử lý phím tắt ẩn/hiện UI
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.RightControl then
        ScreenGui.Enabled = not ScreenGui.Enabled
    end
end)

-- Thông báo khởi động
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Yunie Script",
    Text = "Script đã được khởi động thành công!",
    Duration = 5
})
