SpreadMod ={
    BulletSpread = {
        Enabled = false,
        Amount = 100 -- // Max Spread \\ --
    }
}



local old; old = hookfunction(math.random, function(...)
    local args = {...}

    if checkcaller() then
        return old(...)
    end

    if (#args == 0) or 
       (args[1] == -0.05 and args[2] == 0.05) or 
       (args[1] == -0.1) or
       (args[1] == -0.05) then

        if SpreadMod.BulletSpread.Enabled then
            local spread = SpreadMod.BulletSpread.Amount
            return old(...) * (spread / 100)
        else
            return old(...)
        end
    end
    
    return old(...)
end)
