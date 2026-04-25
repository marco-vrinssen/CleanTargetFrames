local function HideDebuffs(frame)
    if not frame or not frame.auraPools then return end
    local pool = frame.auraPools:GetPool("TargetDebuffFrameTemplate")
    if not pool then return end
    for debuff in pool:EnumerateActive() do
        debuff:Hide()
    end
end

local function HideAll()
    HideDebuffs(TargetFrame)
    HideDebuffs(FocusFrame)
end

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:RegisterEvent("PLAYER_TARGET_CHANGED")
f:RegisterEvent("PLAYER_FOCUS_CHANGED")
f:RegisterUnitEvent("UNIT_AURA", "target", "focus")
f:SetScript("OnEvent", function()
    C_Timer.After(0, HideAll)
end)
