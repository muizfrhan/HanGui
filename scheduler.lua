_G.Scheduler = {
    delay = 1
}

function SetDelay(v)
    _G.Scheduler.delay = v
end

function Wait()
    task.wait(_G.Scheduler.delay)
end
