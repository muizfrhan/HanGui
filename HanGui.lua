--// FISH IT | HANSZ SUPER GUI
--// PREMIUM MAX EDITION | 1 FILE | EXECUTOR SAFE

-- ================= SERVICES =================
local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local VU = game:GetService("VirtualUser")
local RS = game:GetService("RunService")
local TS = game:GetService("TweenService")
local TeleportService = game:GetService("TeleportService")
local Workspace = game:GetService("Workspace")
local SoundService = game:GetService("SoundService")

-- ================= FPS BOOST =================
if typeof(setfpscap) == "function" then
    setfpscap(1000)
end

-- ================= GUI SETUP =================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "HANZ_PREMIUM_MAX"
ScreenGui.ResetOnSpawn = false

local parentGui = game:GetService("CoreGui")
if syn and syn.protect_gui then
    syn.protect_gui(ScreenGui)
elseif gethui then
    parentGui = gethui()
end
ScreenGui.Parent = parentGui

-- ================= SOUNDS =================
local ClickSound = Instance.new("Sound", SoundService)
ClickSound.SoundId = "rbxassetid://12221967"
ClickSound.Volume = 0.6

local HoverSound = Instance.new("Sound", SoundService)
HoverSound.SoundId = "rbxassetid://9118823101"
HoverSound.Volume = 0.4

-- ================= THEME =================
local Themes = {
    Blue = Color3.fromRGB(0,170,255),
    Red = Color3.fromRGB(255,80,80),
    Purple = Color3.fromRGB(170,90,255)
}
local CurrentTheme = "Blue"

-- ================= MAIN FRAME =================
local Main = Instance.new("Frame", ScreenGui)
Main.AnchorPoint = Vector2.new(0.5,0.5)
Main.Position = UDim2.fromScale(0.5,0.5)
Main.Size = UDim2.fromScale(0.42,0.56)
Main.BackgroundColor3 = Color3.fromRGB(16,16,22)
Main.BackgroundTransparency = 0.15
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Main.ClipsDescendants = true

-- Responsive scale
local UIScale = Instance.new("UIScale", Main)
UIScale.Scale = math.clamp(workspace.CurrentCamera.ViewportSize.X / 1200, 0.7, 1)
workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
    UIScale.Scale = math.clamp(workspace.CurrentCamera.ViewportSize.X / 1200, 0.7, 1)
end)

-- Corner
Instance.new("UICorner", Main).CornerRadius = UDim.new(0,18)

-- Shadow
local Shadow = Instance.new("ImageLabel", Main)
Shadow.AnchorPoint = Vector2.new(0.5,0.5)
Shadow.Position = UDim2.fromScale(0.5,0.53)
Shadow.Size = UDim2.fromScale(1.12,1.18)
Shadow.Image = "rbxassetid://1316045217"
Shadow.ImageTransparency = 0.45
Shadow.BackgroundTransparency = 1
Shadow.ScaleType = Enum.ScaleType.Slice
Shadow.SliceCenter = Rect.new(10,10,118,118)
Shadow.ZIndex = 0
Main.ZIndex = 2

-- Stroke
local Stroke = Instance.new("UIStroke", Main)
Stroke.Thickness = 2
Stroke.Color = Themes[CurrentTheme]
Stroke.Transparency = 0.2

-- Open animation
Main.Size = UDim2.fromScale(0,0)
TS:Create(Main, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
    Size = UDim2.fromScale(0.42,0.56)
}):Play()

-- ================= TITLE BAR =================
local TitleBar = Instance.new("Frame", Main)
TitleBar.Size = UDim2.new(1,0,0,50)
TitleBar.BackgroundTransparency = 1

local Title = Instance.new("TextLabel", TitleBar)
Title.Size = UDim2.new(1,-90,1,0)
Title.Position = UDim2.new(0,15,0,0)
Title.BackgroundTransparency = 1
Title.Text = "FISH IT"
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 22
Title.TextColor3 = Color3.fromRGB(220,235,255)
Title.TextXAlignment = Enum.TextXAlignment.Left

local Sub = Instance.new("TextLabel", Title)
Sub.Size = UDim2.new(1,0,0,16)
Sub.Position = UDim2.new(0,0,1,-12)
Sub.BackgroundTransparency = 1
Sub.Text = "HANSZ SUPER GUI • PREMIUM MAX"
Sub.Font = Enum.Font.Gotham
Sub.TextSize = 11
Sub.TextColor3 = Themes[CurrentTheme]
Sub.TextXAlignment = Enum.TextXAlignment.Left

-- ================= CONTROL BUTTONS =================
local function ctrlButton(text, posX, callback)
    local b = Instance.new("TextButton", TitleBar)
    b.Size = UDim2.new(0,28,0,28)
    b.Position = UDim2.new(1,posX,0.5,-14)
    b.Text = text
    b.Font = Enum.Font.GothamBold
    b.TextSize = 14
    b.TextColor3 = Color3.new(1,1,1)
    b.BackgroundColor3 = Color3.fromRGB(30,30,35)
    b.AutoButtonColor = false
    Instance.new("UICorner", b).CornerRadius = UDim.new(1,0)
    b.MouseButton1Click:Connect(function()
        ClickSound:Play()
        callback()
    end)
    return b
end

-- Minimize
local Minimized = false
local MinBtn = ctrlButton("—", -70, function()
    Minimized = not Minimized
    TS:Create(Main, TweenInfo.new(0.3), {
        Size = Minimized and UDim2.fromScale(0.42,0.08) or UDim2.fromScale(0.42,0.56)
    }):Play()
end)

-- Theme switch
ctrlButton("🎨", -38, function()
    ClickSound:Play()
    if CurrentTheme == "Blue" then
        CurrentTheme = "Red"
    elseif CurrentTheme == "Red" then
        CurrentTheme = "Purple"
    else
        CurrentTheme = "Blue"
    end
    Stroke.Color = Themes[CurrentTheme]
    Sub.TextColor3 = Themes[CurrentTheme]
end)

-- Close
ctrlButton("X", -6, function()
    ScreenGui:Destroy()
end)

-- ================= TAB BAR =================
local TabBar = Instance.new("Frame", Main)
TabBar.Position = UDim2.new(0,0,0,55)
TabBar.Size = UDim2.new(1,0,0,42)
TabBar.BackgroundTransparency = 1

local TabList = Instance.new("UIListLayout", TabBar)
TabList.FillDirection = Enum.FillDirection.Horizontal
TabList.HorizontalAlignment = Enum.HorizontalAlignment.Center
TabList.Padding = UDim.new(0,6)

-- ================= PAGES =================
local Pages = Instance.new("Frame", Main)
Pages.Position = UDim2.new(0,0,0,100)
Pages.Size = UDim2.new(1,0,1,-105)
Pages.BackgroundTransparency = 1

local Toggles = {}
local CurrentTab

local function newPage()
    local f = Instance.new("Frame", Pages)
    f.Size = UDim2.fromScale(1,1)
    f.Visible = false
    f.BackgroundTransparency = 1
    local l = Instance.new("UIListLayout", f)
    l.Padding = UDim.new(0,6)
    l.HorizontalAlignment = Enum.HorizontalAlignment.Center
    return f
end

local function switchTab(p)
    if CurrentTab then CurrentTab.Visible = false end
    CurrentTab = p
    p.Visible = true
end

-- ================= UI COMPONENTS =================
local function styleButton(b)
    Instance.new("UICorner", b).CornerRadius = UDim.new(0,10)
    local s = Instance.new("UIStroke", b)
    s.Color = Themes[CurrentTheme]
    s.Transparency = 0.7
    b.MouseEnter:Connect(function() HoverSound:Play() end)
end

local function addTab(name, page)
    local b = Instance.new("TextButton", TabBar)
    b.Size = UDim2.new(0,110,1,0)
    b.Text = name
    b.Font = Enum.Font.GothamBold
    b.TextSize = 14
    b.TextColor3 = Color3.new(1,1,1)
    b.BackgroundColor3 = Color3.fromRGB(28,28,34)
    b.AutoButtonColor = false
    styleButton(b)
    b.MouseButton1Click:Connect(function()
        ClickSound:Play()
        switchTab(page)
    end)
end

local function addToggle(parent, text, cb)
    Toggles[text] = false
    local b = Instance.new("TextButton", parent)
    b.Size = UDim2.new(1,-20,0,40)
    b.Text = "◯ "..text
    b.Font = Enum.Font.Gotham
    b.TextSize = 14
    b.TextColor3 = Color3.new(1,1,1)
    b.BackgroundColor3 = Color3.fromRGB(22,22,28)
    b.AutoButtonColor = false
    styleButton(b)

    b.MouseButton1Click:Connect(function()
        ClickSound:Play()
        Toggles[text] = not Toggles[text]
        b.Text = (Toggles[text] and "⬤ " or "◯ ")..text
        TS:Create(b, TweenInfo.new(0.15), {
            BackgroundColor3 = Toggles[text] and Themes[CurrentTheme] or Color3.fromRGB(22,22,28),
            TextColor3 = Toggles[text] and Color3.new(0,0,0) or Color3.new(1,1,1)
        }):Play()
        cb(Toggles[text])
    end)
end

local function addButton(parent, text, cb)
    local b = Instance.new("TextButton", parent)
    b.Size = UDim2.new(1,-20,0,40)
    b.Text = text
    b.Font = Enum.Font.GothamBold
    b.TextSize = 14
    b.TextColor3 = Themes[CurrentTheme]
    b.BackgroundColor3 = Color3.fromRGB(22,22,28)
    b.AutoButtonColor = false
    styleButton(b)
    b.MouseButton1Click:Connect(function()
        ClickSound:Play()
        cb()
    end)
end

-- ================= TABS =================
local MainTab = newPage()
local FarmTab = newPage()
local PlayerTab = newPage()
local MiscTab = newPage()

addTab("Main", MainTab)
addTab("Farm", FarmTab)
addTab("Player", PlayerTab)
addTab("Misc", MiscTab)
switchTab(MainTab)

-- ================= FEATURES (ORIGINAL) =================
addToggle(MainTab, "Anti AFK", function(v)
    task.spawn(function()
        while v do
            VU:Button2Down(Vector2.new(0,0), Workspace.CurrentCamera.CFrame)
            task.wait(1)
            VU:Button2Up(Vector2.new(0,0), Workspace.CurrentCamera.CFrame)
            task.wait(50)
        end
    end)
end)

addButton(MainTab, "Close GUI", function()
    ScreenGui:Destroy()
end)

addToggle(PlayerTab, "Speed Hack", function(v)
    task.spawn(function()
        while v do
            if LP.Character and LP.Character:FindFirstChild("Humanoid") then
                LP.Character.Humanoid.WalkSpeed = 50
            end
            task.wait(0.2)
        end
    end)
end)

addToggle(PlayerTab, "Jump Hack", function(v)
    task.spawn(function()
        while v do
            if LP.Character and LP.Character:FindFirstChild("Humanoid") then
                LP.Character.Humanoid.JumpPower = 100
            end
            task.wait(0.2)
        end
    end)
end)

addButton(MiscTab, "FPS Boost", function()
    if typeof(setfpscap) == "function" then
        setfpscap(1000)
    end
end)

addButton(MiscTab, "Server Rejoin", function()
    TeleportService:Teleport(game.PlaceId)
end)
