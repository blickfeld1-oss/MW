-- Mistweaver Hybrid PvP Rotation
-- Aurora Framework implementation

local namespace = "MistweaverHybrid"

-- Units
local player  = Aurora.UnitManager:Get("player")
local target  = Aurora.UnitManager:Get("target")
local ally1   = Aurora.UnitManager:Get("party1")
local ally2   = Aurora.UnitManager:Get("party2")

-- Spellbook shortcuts
local book   = Aurora.SpellHandler.Spellbooks.monk["2"][namespace]
local spells = book.spells
local auras  = book.auras
local state  = Aurora.State[namespace]

-- Helper: return lowest health ally
local function lowestAlly()
    local units = {player, ally1, ally2}
    local lowest, hp = nil, 101
    for _, u in ipairs(units) do
        if u and u.exists and not u.dead and u.health.percent < hp then
            lowest, hp = u, u.health.percent
        end
    end
    return lowest
end

-- Combat logic
local function HybridRotation()
    local ally = lowestAlly()

    if ally then
        -- Emergency tools
        if ally.health.percent < 25 and spells.LifeCocoon:execute(ally) then return true end
        if ally.health.percent < 35 and spells.Revival:execute() then return true end
        if ally == player and player.health.percent < 40 and spells.FortifyingBrew:execute() then return true end
        if ally == player and player.health.percent < 50 and spells.DiffuseMagic:execute() then return true end

        -- Core healing
        if not ally:aura(auras.RenewingMistHoT) and spells.RenewingMist:execute(ally) then return true end
        if ally.health.percent < 60 and spells.EnvelopingMist:execute(ally) then return true end
        if ally.health.percent < 70 then
            if spells.ThunderFocusTea:ready() and spells.ThunderFocusTea:execute(player) then return true end
            if spells.Vivify:execute(ally) then return true end
        end
    end

    -- Self stabilisation
    if player.health.percent < 80 and spells.ExpelHarm:execute(player) then return true end

    -- Fistweaving block when no one is in danger
    if state.fistweave and (not ally or ally.health.percent > 80) and target.exists and target.enemy then
        if spells.RisingSunKick:execute(target) then return true end
        if player:aura(auras.TeachingsOfTheMonastery) == 3 and spells.BlackoutKick:execute(target) then return true end
        if spells.BlackoutKick:execute(target) then return true end
        if spells.TigerPalm:execute(target) then return true end
        if spells.CracklingJadeLightning:execute(target) then return true end
    end

    return false
end

-- Out of combat utility
local function OutOfCombat()
    -- Place statue and maintain renewing mist
    if spells.JadeSerpentStatue:ready() then
        spells.JadeSerpentStatue:execute(player)
    end
    for _, u in ipairs({player, ally1, ally2}) do
        if u and u.exists and not u.dead and not u:aura(auras.RenewingMistHoT) then
            spells.RenewingMist:execute(u)
        end
    end
    return false
end

Aurora:RegisterRoutine(function()
    if player.dead or player:casting() or player:inVehicle() then return end
    if player.combat then
        HybridRotation()
    else
        OutOfCombat()
    end
end, "MONK", 2, namespace)

