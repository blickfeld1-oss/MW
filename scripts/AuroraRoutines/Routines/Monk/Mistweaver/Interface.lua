-- Interface for MistweaverHybrid rotation
-- Provides simple slash commands for toggles

local namespace = "MistweaverHybrid"
Aurora.State = Aurora.State or {}
Aurora.State[namespace] = { fistweave = true }

-- Commands module may not be available on Aurora by default, so require it if needed
local Commands = Aurora.Commands or Tinkr:require("commands")

Commands:Register("mwhybrid", "Hybrid Mistweaver toggles", function(msg)
    if msg == "fistweave" then
        local st = Aurora.State[namespace]
        st.fistweave = not st.fistweave
        print("[MistweaverHybrid] Fistweave mode: " .. (st.fistweave and "on" or "off"))
    else
        print("Usage: /mwhybrid fistweave")
    end
end)

