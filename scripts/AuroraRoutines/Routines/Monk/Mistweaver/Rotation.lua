-- Get a reference to our namespace
local namespace = "MistweaverHybrid"

-- Get commonly used units
local player = Aurora.UnitManager:Get("player")
local target = Aurora.UnitManager:Get("target")

-- Get the spellbook
local spells = Aurora.SpellHandler.Spellbooks.monk["2"][namespace].spells
local auras = Aurora.SpellHandler.Spellbooks.monk["2"][namespace].auras
local talents = Aurora.SpellHandler.Spellbooks.monk["2"][namespace].talents

-- Define the hybrid rotation logic
local function HybridRotation()
    -- Defensive and Healing
    -- Use Life Cocoon on player if health is very low
    if player.health.percent < 20 and spells.LifeCocoon:execute(player) then return true end

    -- Use Fortifying Brew if health is low
    if player.health.percent < 40 and spells.FortifyingBrew:execute() then return true end

    -- Keep Renewing Mist up on the player
    if not player:aura(auras.RenewingMistHoT) and spells.RenewingMist:execute(player) then return true end

    -- Use Vivify for moderate healing
    if player.health.percent < 70 and spells.Vivify:execute(player) then return true end

    -- Fistweaving DPS Rotation
    -- Use Rising Sun Kick on cooldown
    if spells.RisingSunKick:execute(target) then return true end

    -- Use Blackout Kick to reset Rising Sun Kick
    if spells.BlackoutKick:execute(target) then return true end

    -- Use Tiger Palm to generate Chi and buff Blackout Kick
    if spells.TigerPalm:execute(target) then return true end

    -- Use Crackling Jade Lightning as a filler
    if spells.CracklingJadeLightning:execute(target) then return true end

    return false
end

-- Define out of combat actions
local function OutOfCombat()
    -- Placeholder for out-of-combat logic
    return false
end

-- Register the routine with Aurora
Aurora:RegisterRoutine(function()
    -- Skip if player is dead, casting, or in a vehicle
    if player.dead or player:casting() or player:inVehicle() then return end

    -- Run appropriate function based on combat state
    if player.combat and target.exists and target.enemy then
        HybridRotation()
    else
        OutOfCombat()
    end
end, "MONK", 2, namespace)
