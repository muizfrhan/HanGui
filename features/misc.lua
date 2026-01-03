local vu = game:GetService("VirtualUser")

RegisterLoop("Misc", function()
    if GetToggle("Anti AFK") then
        vu:Button2Down(Vector2.zero, workspace.CurrentCamera.CFrame)
        task.wait(0.1)
        vu:Button2Up(Vector2.zero, workspace.CurrentCamera.CFrame)
    end
end)
