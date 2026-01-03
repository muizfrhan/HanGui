--// FISH IT | HANSZ SUPER GUI V1.0
--// Executor-safe, 1 file, full features + modern 3D GUI + Fast Action + Anti Fail + Auto Collect + Player Mods

-- SERVICES
local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local VU = game:GetService("VirtualUser")
local RS = game:GetService("RunService")
local TS = game:GetService("TweenService")
local TeleportService = game:GetService("TeleportService")
local Workspace = game:GetService("Workspace")

-- SAFE FPS
local function FPSBoost()
    if typeof(setfpscap) == "function" then
        setfpscap(1000)
    end
end

-- ================= UI =================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "HANZ_GUI"

-- CoreGui fix for executors
local parentGui = game:GetService("CoreGui")
if syn and syn.protect_gui then
    syn.protect_gui(ScreenGui)
elseif gethui then
    parentGui = gethui()
end
ScreenGui.Parent = parentGui
ScreenGui.ResetOnSpawn = false

-- MAIN FRAME
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.fromScale(0.38, 0.5)
Main.Position = UDim2.fromScale(0.31, 0.25)
Main.BackgroundColor3 = Color3.fromRGB(18,18,18)
Main.BackgroundTransparency = 0.5 -- semi transparan
Main.Active, Main.Draggable = true, true
Main.BorderSizePixel = 0
Main.ClipsDescendants = true

-- Neon stroke
local Stroke = Instance.new("UIStroke", Main)
Stroke.Color = Color3.fromRGB(0,170,255)
Stroke.Thickness = 2
Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

-- TITLE
local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1,0,0,45)
Title.Text = "FISH IT | By HANSZ"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20
Title.TextColor3 = Color3.fromRGB(0,170,255)
Title.BackgroundTransparency = 1

-- TAB BAR
local TabBar = Instance.new("Frame", Main)
TabBar.Position = UDim2.new(0,0,0,50)
TabBar.Size = UDim2.new(1,0,0,45)
TabBar.BackgroundTransparency = 1
local TabList = Instance.new("UIListLayout", TabBar)
TabList.FillDirection = Enum.FillDirection.Horizontal
TabList.Padding = UDim.new(0,6)
TabList.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- PAGES
local Pages = Instance.new("Frame", Main)
Pages.Position = UDim2.new(0,0,0,100)
Pages.Size = UDim2.new(1,0,1,-105)
Pages.BackgroundTransparency = 1

-- TABLES
local Toggles = {}
local CurrentTab

-- FUNCTIONS FOR PAGES
local function newPage()
    local f = Instance.new("Frame", Pages)
    f.Size = UDim2.fromScale(1,1)
    f.BackgroundTransparency = 1
    f.Visible = false
    local l = Instance.new("UIListLayout", f)
    l.Padding = UDim.new(0,6)
    l.HorizontalAlignment = Enum.HorizontalAlignment.Center
    l.SortOrder = Enum.SortOrder.LayoutOrder
    return f
end

local function switchTab(p)
    if CurrentTab then CurrentTab.Visible = false end
    CurrentTab = p
    p.Visible = true
end

local function addTab(name, page)
    local b = Instance.new("TextButton", TabBar)
    b.Size = UDim2.new(0,120,1,0)
    b.Text = name
    b.Font = Enum.Font.GothamBold
    b.TextSize = 14
    b.TextColor3 = Color3.new(1,1,1)
    b.BackgroundColor3 = Color3.fromRGB(30,30,30)
    b.AutoButtonColor = false
    -- hover anim
    b.MouseEnter:Connect(function()
        TS:Create(b, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0,170,255)}):Play()
        b.TextColor3 = Color3.new(0,0,0)
    end)
    b.MouseLeave:Connect(function()
        TS:Create(b, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30,30,30)}):Play()
        b.TextColor3 = Color3.new(1,1,1)
    end)
    b.MouseButton1Click:Connect(function() switchTab(page) end)
end

local function addToggle(parent, text, cb)
    Toggles[text] = false
    local b = Instance.new("TextButton", parent)
    b.Size = UDim2.new(1,-20,0,38)
    b.Text = "[ OFF ] "..text
    b.Font = Enum.Font.Gotham
    b.TextSize = 14
    b.BackgroundColor3 = Color3.fromRGB(35,35,35)
    b.TextColor3 = Color3.new(1,1,1)
    b.AutoButtonColor = false
    b.MouseButton1Click:Connect(function()
        Toggles[text] = not Toggles[text]
        b.Text = (Toggles[text] and "[ ON ] " or "[ OFF ] ")..text
        cb(Toggles[text])
    end)
end

local function addButton(parent, text, cb)
    local b = Instance.new("TextButton", parent)
    b.Size = UDim2.new(1,-20,0,38)
    b.Text = text
    b.Font = Enum.Font.GothamBold
    b.TextSize = 14
    b.BackgroundColor3 = Color3.fromRGB(28,28,28)
    b.TextColor3 = Color3.fromRGB(0,170,255)
    b.AutoButtonColor = false
    b.MouseEnter:Connect(function()
        TS:Create(b, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0,170,255)}):Play()
        b.TextColor3 = Color3.new(0,0,0)
    end)
    b.MouseLeave:Connect(function()
        TS:Create(b, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(28,28,28)}):Play()
        b.TextColor3 = Color3.fromRGB(0,170,255)
    end)
    b.MouseButton1Click:Connect(cb)
end

-- CREATE TABS
local MainTab = newPage()
local FarmTab = newPage()
local PlayerTab = newPage()
local MiscTab = newPage()
addTab("Main", MainTab)
addTab("Farm", FarmTab)
addTab("Player", PlayerTab)
addTab("Misc", MiscTab)
switchTab(MainTab)

-- ================= FEATURES =================
-- MAIN TAB
addToggle(MainTab, "Anti AFK", function(v)
    Toggles["Anti AFK"] = v
    task.spawn(function()
        while Toggles["Anti AFK"] do
            VU:Button2Down(Vector2.new(0,0), Workspace.CurrentCamera.CFrame)
            task.wait(1)
            VU:Button2Up(Vector2.new(0,0), Workspace.CurrentCamera.CFrame)
            task.wait(50)
        end
    end)
end)

-- FISH TRACKER
local FishCaught = 0
local FishLabel = Instance.new("TextLabel", MainTab)
FishLabel.Size = UDim2.new(1,0,0,30)
FishLabel.Position = UDim2.new(0,0,0,0)
FishLabel.BackgroundTransparency = 1
FishLabel.TextColor3 = Color3.fromRGB(0,255,170)
FishLabel.TextSize = 14
FishLabel.Font = Enum.Font.GothamBold
FishLabel.Text = "Fish Caught: 0"

addButton(MainTab, "Close GUI", function()
    ScreenGui:Destroy()
end)

-- FARM TAB
local function getRod()
    local char = LP.Character
    if not char then return nil end
    for _,v in pairs(char:GetChildren()) do
        if v:IsA("Tool") and (v.Name:lower():find("rod") or v.Name:lower():find("fish")) then
            return v
        end
    end
end

local function castRod(rod)
    if rod and rod.Activate then rod:Activate() end
end

local function findReelPrompt()
    for _,d in pairs(Workspace:GetDescendants()) do
        if d:IsA("ProximityPrompt") then
            local n = d.Name:lower()
            if n:find("reel") or n:find("catch") or n:find("pull") then
                return d
            end
        end
    end
end

-- AUTO FISH
addToggle(FarmTab, "Auto Fish", function(v)
    Toggles["Auto Fish"] = v
    task.spawn(function()
        while Toggles["Auto Fish"] do
            local rod = getRod()
            if rod then
                castRod(rod)
                task.wait(Toggles["Fast Action"] and 0.3 or 1)
                local prompt = findReelPrompt()
                if prompt then
                    prompt:InputHoldBegin()
                    task.wait(0.15)
                    prompt:InputHoldEnd()
                    FishCaught += 1
                    FishLabel.Text = "Fish Caught: "..FishCaught
                end
            end
            task.wait(0.3)
        end
    end)
end)

addToggle(FarmTab, "Fast Action", function(v)
    Toggles["Fast Action"] = v
end)

addToggle(FarmTab, "Anti Fail", function(v)
    Toggles["Anti Fail"] = v
    task.spawn(function()
        while Toggles["Anti Fail"] do
            local prompt = findReelPrompt()
            if prompt then
                prompt:InputHoldBegin()
                task.wait(0.1)
                prompt:InputHoldEnd()
            end
            task.wait(0.5)
        end
    end)
end)

-- PLAYER TAB
addToggle(PlayerTab, "Speed Hack", function(v)
    Toggles["Speed Hack"] = v
    task.spawn(function()
        while Toggles["Speed Hack"] do
            if LP.Character and LP.Character:FindFirstChild("Humanoid") then
                LP.Character.Humanoid.WalkSpeed = 50
            end
            task.wait(0.2)
        end
        if LP.Character and LP.Character:FindFirstChild("Humanoid") then
            LP.Character.Humanoid.WalkSpeed = 16
        end
    end)
end)

addToggle(PlayerTab, "Jump Hack", function(v)
    Toggles["Jump Hack"] = v
    task.spawn(function()
        while Toggles["Jump Hack"] do
            if LP.Character and LP.Character:FindFirstChild("Humanoid") then
                LP.Character.Humanoid.JumpPower = 100
            end
            task.wait(0.2)
        end
        if LP.Character and LP.Character:FindFirstChild("Humanoid") then
            LP.Character.Humanoid.JumpPower = 50
        end
    end)
end)

addButton(PlayerTab, "Teleport Spawn", function()
    if LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
        LP.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(0,5,0))
    end
end)

-- MISC TAB
addButton(MiscTab, "FPS Boost", function() FPSBoost() end)
addButton(MiscTab, "Server Rejoin", function()
    TeleportService:Teleport(game.PlaceId)
end)
