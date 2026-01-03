RegisterLoop("Fishing", function()
    if GetToggle("Auto Fish") then
        _G.FishCount = (_G.FishCount or 0) + 1
        Wait()
    end

    if GetToggle("Fish Assist") then
        Wait()
    end

    if GetToggle("Fish Legit") then
        task.wait(1)
    end
end)
