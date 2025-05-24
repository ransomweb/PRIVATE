game:GetService("StarterGui"):SetCore("SendNotification",{
    Title = "🦅YUFI",
    Text = "🦅🦅🦅 LOADED! IM A TERRORIST NIGGA",
    Duration = 5
})

getgenv().config = {
    enable = true,
    delay = 0.01,
    keybind = Enum.KeyCode.Q
}

local function getGun()
    local char = game.Players.LocalPlayer.Character
    if not char then return end
    for _,v in next, char:GetChildren() do
        if v:IsA("Tool") and v:FindFirstChild("Ammo") then
            return v
        end
    end
end

local isFiring = false

game:GetService("UserInputService").InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        local gun = getGun()
        if config.enable and gun and not isFiring then
            isFiring = true
            while isFiring and config.enable do
                gun:Activate()
                task.wait(config.delay)
            end
        end
    elseif input.KeyCode == config.keybind then
        config.enable = not config.enable
        game:GetService("StarterGui"):SetCore("SendNotification",{
            Title = "🦅YUFI",
            Text = config.enable and "ENABLED 🦅" or "DISABLED 🚫",
            Duration = 2
        })
    end
end)

game:GetService("UserInputService").InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        isFiring = false
    end
end)
