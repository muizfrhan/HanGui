RegisterLoop("Blatant", function()
    if GetToggle("Fast Action") then
        Wait()
    end

    if GetToggle("Instant Mode") then
        Wait()
    end

    if GetToggle("Anti Fail") then
        task.wait(0.5)
    end
end)
