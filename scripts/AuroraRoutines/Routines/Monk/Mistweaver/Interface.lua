-- Interface for MistweaverHybrid rotation
-- Provides simple slash commands for toggles

local namespace = "MistweaverHybrid"
Aurora.State = Aurora.State or {}
Aurora.State[namespace] = Aurora.State[namespace] or { fistweave = true }
local state = Aurora.State[namespace]

Aurora:RegisterCommand("mwhybrid", function(msg)
    if msg == "fistweave" then
        state.fistweave = not state.fistweave
        print("[MistweaverHybrid] Fistweave mode: " .. (state.fistweave and "on" or "off"))
    else
        print("Usage: /mwhybrid fistweave")
    end
end, "Hybrid Mistweaver toggles")

