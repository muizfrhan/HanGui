local HttpService = game:GetService("HttpService")

function SaveConfig(name)
    writefile(name..".json", HttpService:JSONEncode({
        toggles = _G.Engine.toggles,
        sliders = _G.Engine.sliders
    }))
end

function LoadConfig(name)
    if not isfile(name..".json") then return end
    local data = HttpService:JSONDecode(readfile(name..".json"))
    _G.Engine.toggles = data.toggles or {}
    _G.Engine.sliders = data.sliders or {}
end

function Preset(mode)
    if mode=="Legit" then
        SetDelay(1.5)
    elseif mode=="Fast" then
        SetDelay(0.3)
    elseif mode=="AFK" then
        SetDelay(2.5)
    end
end
