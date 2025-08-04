-- Interface for MistweaverHybrid rotation
-- Provides simple slash commands for toggles

local namespace = "MistweaverHybrid"
Aurora.State = Aurora.State or {}
Aurora.State[namespace] = { fistweave = true }

Aurora.Commands:Register("mwhybrid", function(msg)
    if msg == "fistweave" then
        local st = Aurora.State[namespace]
        st.fistweave = not st.fistweave
        print("[MistweaverHybrid] Fistweave mode: " .. (st.fistweave and "on" or "off"))
    else
        print("Usage: /mwhybrid fistweave")
    end
end, "Hybrid Mistweaver toggles")

