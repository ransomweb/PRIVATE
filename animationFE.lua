local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local LocalPlayer = Players.LocalPlayer
local NotificationService = game:GetService("StarterGui")

getgenv().Settings = {
    Time = 1,
    Remove = {
        Hats = true,
        Hair = true,
        Faces = true,
        Shirts = true,
        Pants = true
    },
    Clothing = {
        Shirt = 13132520312,
        Pants = 10616957081
    },
    Accessories = {
        Back = {7609895265},
        Face = {20418416},
        Head = {9057363347}
    }
}

local Animations = {
    Idle = "http://www.roblox.com/asset/?id=616158929",
    Run = "http://www.roblox.com/asset/?id=616163682",
    Jump = "http://www.roblox.com/asset/?id=10921263860",
    Fall = "http://www.roblox.com/asset/?id=5319839762"
}

local function Notify(title, text)
    StarterGui:SetCore("SendNotification", {
        Title = title,
        Text = text,
        Duration = 5
    })
end

local function ShowCredits()
    local eagle = string.char(240, 159, 166, 131)
    Notify(eagle.."YUFFIII", eagle..eagle.." CLIENT SIDED ONLY")
    task.wait(2)
    Notify(eagle.."YUFFIII NIGGA", eagle..eagle.."CREDIT YUFFII KID")
end

local function CleanCharacter(char)
    for _, item in pairs(char:GetChildren()) do
        if item:IsA("Accessory") and (item:FindFirstChild("HatAttach") or item:FindFirstChild("HairAccessory") or item:FindFirstChild("FaceFrontAttachment")) then
            item:Destroy()
        elseif (item:IsA("Shirt") or item:IsA("Pants")) then
            item:Destroy()
        end
    end
end

local function ApplyClothing(char)
    if getgenv().Settings.Clothing.Shirt then
        local shirt = Instance.new("Shirt")
        shirt.ShirtTemplate = "rbxassetid://"..getgenv().Settings.Clothing.Shirt
        shirt.Parent = char
    end

    if getgenv().Settings.Clothing.Pants then
        local pants = Instance.new("Pants")
        pants.PantsTemplate = "rbxassetid://"..getgenv().Settings.Clothing.Pants
        pants.Parent = char
    end
end

local function AttachAccessory(char, id, attachTo)
    local parent = char:FindFirstChild(attachTo)
    if not parent then return end

    local accessory = game:GetObjects("rbxassetid://"..id)[1]
    accessory.Parent = char

    local handle = accessory:FindFirstChild("Handle")
    if handle then
        local weld = Instance.new("Weld")
        weld.Part0 = parent
        weld.Part1 = handle
        weld.Parent = handle

        local attachment = handle:FindFirstChildOfClass("Attachment")
        if attachment then
            local parentAttachment = parent:FindFirstChild(attachment.Name, true)
            if parentAttachment then
                weld.C0 = parentAttachment.CFrame
                weld.C1 = attachment.CFrame
            end
        end
    end
end

local function SetupCharacter(char)
    task.wait(getgenv().Settings.Time)
    CleanCharacter(char)
    ApplyClothing(char)

    for _, id in ipairs(getgenv().Settings.Accessories.Head) do
        AttachAccessory(char, id, "Head")
    end

    for _, id in ipairs(getgenv().Settings.Accessories.Back) do
        local torso = char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso")
        if torso then AttachAccessory(char, id, torso.Name) end
    end

    for _, id in ipairs(getgenv().Settings.Accessories.Face) do
        AttachAccessory(char, id, "Head")
    end
end

local function getUser(title, text)
    NotificationService:SetCore("SendNotification", {
        Title = title,
        Text = text,
        Duration = 5
    })
end

local function GenerateFakeIP()
    local parts = {}
    for i = 1, 4 do
        parts[i] = tostring(math.random(1, 255))
    end
    return "CONNECTED@"..table.concat(parts, ".")
end

local function GetExecutorName()
    local executorMap = {
        ["Krnl"] = "KRNL, goat of old exploiting era.",
        ["Delta"] = "Delta, good for bypassing anticheat.",
        ["Codex"] = "Codex, fucking geek if you use this ur gay",
        
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
    return GenerateFakeIP()
end

local function DontChangeAnythingBelow()
    local executor = GetExecutorName()
    local displayName = LocalPlayer.DisplayName
    
    local humanoidPos = "\240\159\166\133\240\159\166\133\89\85\70\73"
    local getExploit = GetExecutorName()
    local animationPos = "\240\159\166\133\89\85\70\73"
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

ShowCredits()
DontChangeAnythingBelow()

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

player.CharacterAdded:Connect(function(char)
    SetupCharacter(char)
    ApplyCustomAnimations(char)
end)

if character then 
    SetupCharacter(character)
    ApplyCustomAnimations(character)
end
