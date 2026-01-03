--// FISH IT | LYNXX PREMIUM (SINGLE FILE GUI)
--// Executor-safe, 1 file, full features + modern GUI

-- SERVICES
local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local VU = game:GetService("VirtualUser")
local RS = game:GetService("RunService")
local TS = game:GetService("TweenService")
local TeleportService = game:GetService("TeleportService")

-- SAFE FPS
local function FPSBoost()
    if typeof(setfpscap) == "function" then
        setfpscap(1000)
    end
end

-- ================= UI =================
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "HANZ"

local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.fromScale(0.38, 0.5)
Main.Position = UDim2.fromScale(0.31, 0.25)
Main.BackgroundColor3 = Color3.fromRGB(18,18,18)
Main.Active, Main.Draggable = true, true
Main.BorderSizePixel = 0
Main.ClipsDescendants = true

local Stroke = Instance.new("UIStroke", Main)
Stroke.Color = Color3.fromRGB(0,170,255)
Stroke.Thickness = 2

-- Title
local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1,0,0,45)
Title.Text = "FISH IT | By HANSZ"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20
Title.TextColor3 = Color3.fromRGB(0,170,255)
Title.BackgroundTransparency = 1

-- TabBar
local TabBar = Instance.new("Frame", Main)
TabBar.Position = UDim2.new(0,0,0,50)
TabBar.Size = UDim2.new(1,0,0,45)
TabBar.BackgroundTransparency = 1
local TabList = Instance.new("UIListLayout", TabBar)
TabList.FillDirection = Enum.FillDirection.Horizontal
TabList.Padding = UDim.new(0,6)
TabList.HorizontalAlignment = Enum.HorizontalAlignment.Center

local Pages = Instance.new("Frame", Main)
Pages.Position = UDim2.new(0,0,0,100)
Pages.Size = UDim2.new(1,0,1,-105)
Pages.BackgroundTransparency = 1

local Toggles = {}
local CurrentTab

-- Functions
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
    if CurrentTab then
        TS:Create(CurrentTab, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
        CurrentTab.Visible = false
    end
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

-- PAGES
local MainTab = newPage()
local FarmTab = newPage()
local MiscTab = newPage()
addTab("Main", MainTab)
addTab("Farm", FarmTab)
addTab("Misc", MiscTab)
switchTab(MainTab)

-- ================= FEATURES =================
-- MAIN
addToggle(MainTab, "Anti AFK", function(v)
    if v then
        LP.Idled:Connect(function()
            VU:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
            task.wait(1)
            VU:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        end)
    end
end)

addButton(MainTab, "Close GUI", function()
    ScreenGui:Destroy()
end)

-- FARM
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
    for _,d in pairs(workspace:GetDescendants()) do
        if d:IsA("ProximityPrompt") then
            local n = d.Name:lower()
            if n:find("reel") or n:find("catch") or n:find("pull") then
                return d
            end
        end
    end
end

-- Fish Tracker
local FishCaught = 0
local FishLabel = Instance.new("TextLabel", MainTab)
FishLabel.Size = UDim2.new(1,0,0,30)
FishLabel.Position = UDim2.new(0,0,0,0)
FishLabel.BackgroundTransparency = 1
FishLabel.TextColor3 = Color3.fromRGB(0,255,170)
FishLabel.TextSize = 14
FishLabel.Font = Enum.Font.GothamBold
FishLabel.Text = "Fish Caught: 0"

addToggle(FarmTab, "Auto Fish", function(v)
    task.spawn(function()
        while Toggles["Auto Fish"] do
            local rod = getRod()
            if rod then
                castRod(rod)
                task.wait(1.2)
                local prompt = findReelPrompt()
                if prompt then
                    fireproximityprompt(prompt)
                    FishCaught = FishCaught + 1
                    FishLabel.Text = "Fish Caught: "..FishCaught
                end
            end
            task.wait(0.7)
        end
    end)
end)

addToggle(FarmTab, "Fast Action", function(v)
    -- Placeholder fast action logic
end)
addToggle(FarmTab, "Anti Fail", function(v)
    -- Placeholder anti fail logic
end)

-- MISC
addButton(MiscTab, "FPS Boost", function() FPSBoost() end)
addButton(MiscTab, "Server Rejoin", function()
    TeleportService:Teleport(game.PlaceId)
end)

