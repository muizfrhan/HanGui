_G.Engine = {
    toggles = {},
    sliders = {},
    buttons = {},
    loops = {}
}

function RegisterToggle(name, cb)
    _G.Engine.toggles[name] = false
    cb(false)
end

function SetToggle(name, v)
    _G.Engine.toggles[name] = v
end

function GetToggle(name)
    return _G.Engine.toggles[name]
end

function RegisterSlider(name, def)
    _G.Engine.sliders[name] = def
end

function GetSlider(name)
    return _G.Engine.sliders[name]
end

function RegisterLoop(name, fn)
    _G.Engine.loops[name] = fn
end

function _G.Engine:Start()
    task.spawn(function()
        while true do
            for _,fn in pairs(self.loops) do
                pcall(fn)
            end
            task.wait(0.2)
        end
    end)
end
