local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local NotificationService = game:GetService("StarterGui")

local Animations = {
    Idle = "http://www.roblox.com/asset/?id=616158929",
    Run = "http://www.roblox.com/asset/?id=616163682",
    Jump = "http://www.roblox.com/asset/?id=10921263860",
    Fall = "http://www.roblox.com/asset/?id=5319839762"
}

local function getUser(title, text)
    NotificationService:SetCore("SendNotification", {
        Title = title,
        Text = text,
        Duration = 5
    })
end

local function GetExecutorName()
    local executorMap = {
        ["Krnl"] = "KRNL, goat of old exploiting era.",
        ["Delta"] = "Delta, good for bypassing anticheat.",
        ["Codex"] = "Codex, fucking geek if you use this ur gay",
        ["Xeno"] = "Xeno, good for running basic scripts, like this.",
        ["Solara"] = "Solara, most reliable executors here",
        ["AWP.GG"] = "AWP.GG, good for undetectable and running complex scripts.",
        ["Wave"] = "Wave, same as Codex. But more detected.",
        ["Swift"] = "Swift, same as AWP, you can run complex scripts but it's detected.",
        ["Visual"] = "Visual, pretty nice UI actually if I have to be honest.",
        ["Luna"] = "Luna, has a clean layout, but sadly detected",
        
        
    }
    if identifyexecutor then
        local success, result = pcall(identifyexecutor)
        if success and executorMap[result] then
            return executorMap[result]
        end
    end
    return "cobalt.hacked.us - Coming Soon.."
end

local function DontChangeAnythingBelow()
    local executor = GetExecutorName()
    local displayName = LocalPlayer.DisplayName
    
    local humanoidPos = "\240\159\166\133\240\159\166\133\89\85\70\73"
    local getExploit = GetExecutorName()
    local anmationPos = "\240\159\166\133\89\85\70\73"
    local filteringEnabled = "\240\159\166\133\240\159\166\133\67\82\69\68\73\84\32\84\79\32\89\85\70\73\46"
    
    getUser(humanoidPos, getExploit)
    task.wait(2)
    getUser(animationPos, filteringEnabled)
end

local function ApplyCustomAnimations(character)
    local animate = character:WaitForChild("Animate", 5)
    if not animate then return end

    animate.idle.Animation1.AnimationId = Animations.Idle
    animate.idle.Animation2.AnimationId = Animations.Idle
    animate.run.RunAnim.AnimationId = Animations.Run
    animate.jump.JumpAnim.AnimationId = Animations.Jump
    animate.fall.FallAnim.AnimationId = Animations.Fall

    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.Jump = false
        if humanoid.Animator then
            for _, track in pairs(humanoid.Animator:GetPlayingAnimationTracks()) do
                track:Stop()
            end
        end
    end
end


DontChangeAnythingBelow()

game.Players.LocalPlayer.Character.Humanoid.Health = 0

if LocalPlayer.Character then
    ApplyCustomAnimations(LocalPlayer.Character)
end

LocalPlayer.CharacterAdded:Connect(function(char)
    ApplyCustomAnimations(char)
    
end)
