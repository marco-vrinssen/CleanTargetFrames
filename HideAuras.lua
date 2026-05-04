local function suppress(frame)
    frame.maxBuffs = 0
    frame.maxDebuffs = 0
end

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_LOGIN")
f:SetScript("OnEvent", function()
    suppress(TargetFrame)
    suppress(FocusFrame)
end)
