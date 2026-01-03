--// FISH IT | SINGLE FILE GUI + AUTO FISH (FIX)
--// Executor-safe, no globals error

-- SERVICES
local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local VU = game:GetService("VirtualUser")
local RS = game:GetService("RunService")

-- SAFE FPS
local function FPSBoost()
    if typeof(setfpscap) == "function" then
        setfpscap(1000)
    end
end

-- ================= UI =================
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "FishIt_Lynxx"

local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.fromScale(0.36, 0.46)
Main.Position = UDim2.fromScale(0.32, 0.27)
Main.BackgroundColor3 = Color3.fromRGB(18,18,18)
Main.Active, Main.Draggable = true, true

local Stroke = Instance.new("UIStroke", Main)
Stroke.Color = Color3.fromRGB(0,170,255)

local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1,0,0,40)
Title.Text = "FISH IT | LYNXX (SINGLE FILE)"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.TextColor3 = Color3.fromRGB(0,170,255)
Title.BackgroundTransparency = 1

local TabBar = Instance.new("Frame", Main)
TabBar.Position = UDim2.new(0,0,0,45)
TabBar.Size = UDim2.new(1,0,0,40)
TabBar.BackgroundTransparency = 1
local TabList = Instance.new("UIListLayout", TabBar)
TabList.FillDirection = Enum.FillDirection.Horizontal
TabList.Padding = UDim.new(0,6)

local Pages = Instance.new("Frame", Main)
Pages.Position = UDim2.new(0,0,0,90)
Pages.Size = UDim2.new(1,0,1,-95)
Pages.BackgroundTransparency = 1

local Toggles = {}
local CurrentTab

local function newPage()
    local f = Instance.new("Frame", Pages)
    f.Size = UDim2.fromScale(1,1)
    f.BackgroundTransparency = 1
    f.Visible = false
    local l = Instance.new("UIListLayout", f)
    l.Padding = UDim.new(0,6)
    return f
end
local function switchTab(p)
    if CurrentTab then CurrentTab.Visible = false end
    CurrentTab = p; p.Visible = true
end
local function addTab(name, page)
    local b = Instance.new("TextButton", TabBar)
    b.Size = UDim2.new(0,120,1,0)
    b.Text = name
    b.Font = Enum.Font.GothamBold
    b.TextSize = 14
    b.TextColor3 = Color3.new(1,1,1)
    b.BackgroundColor3 = Color3.fromRGB(30,30,30)
    b.MouseButton1Click:Connect(function() switchTab(page) end)
end
local function addToggle(parent, text, cb)
    Toggles[text] = false
    local b = Instance.new("TextButton", parent)
    b.Size = UDim2.new(1,-10,0,36)
    b.Text = "[ OFF ] "..text
    b.Font = Enum.Font.Gotham
    b.TextSize = 14
    b.BackgroundColor3 = Color3.fromRGB(35,35,35)
    b.TextColor3 = Color3.new(1,1,1)
    b.MouseButton1Click:Connect(function()
        Toggles[text] = not Toggles[text]
        b.Text = (Toggles[text] and "[ ON ] " or "[ OFF ] ")..text
        cb(Toggles[text])
    end)
end
local function addButton(parent, text, cb)
    local b = Instance.new("TextButton", parent)
    b.Size = UDim2.new(1,-10,0,36)
    b.Text = text
    b.Font = Enum.Font.GothamBold
    b.TextSize = 14
    b.BackgroundColor3 = Color3.fromRGB(28,28,28)
    b.TextColor3 = Color3.fromRGB(0,170,255)
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

-- ================= FISH IT LOGIC =================
-- Cari tool pancing
local function getRod()
    local char = LP.Character
    if not char then return nil end
    for _,v in pairs(char:GetChildren()) do
        if v:IsA("Tool") and (v.Name:lower():find("rod") or v.Name:lower():find("fish")) then
            return v
        end
    end
end

-- Cast / Use tool
local function castRod(rod)
    if rod and rod.Activate then
        rod:Activate()
    end
end

-- Cari ProximityPrompt "Reel"/"Catch"/"Pull"
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
addToggle(FarmTab, "Auto Fish", function(v)
    task.spawn(function()
        while Toggles["Auto Fish"] do
            local rod = getRod()
            if rod then
                castRod(rod)
                -- tunggu ikan nyangkut
                task.wait(1.2)

                local prompt = findReelPrompt()
                if prompt then
                    fireproximityprompt(prompt)
                end
            end
            task.wait(0.8)
        end
    end)
end)

addToggle(FarmTab, "Fast Action", function(v) end)
addToggle(FarmTab, "Anti Fail", function(v) end)

-- MISC
addButton(MiscTab, "FPS Boost", function()
    FPSBoost()
end)

addButton(MiscTab, "Server Rejoin", function()
    game:GetService("TeleportService"):Teleport(game.PlaceId)
end)
