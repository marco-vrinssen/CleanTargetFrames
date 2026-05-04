-- Setting maxBuffs/maxDebuffs to 0 prevents the frame from displaying any auras.
local function DisableAuraDisplay(unitFrame)
    unitFrame.maxBuffs = 0
    unitFrame.maxDebuffs = 0
end

local function OnPlayerLogin()
    DisableAuraDisplay(TargetFrame)
    DisableAuraDisplay(FocusFrame)
end

local loginListener = CreateFrame("Frame")
loginListener:RegisterEvent("PLAYER_LOGIN")
loginListener:SetScript("OnEvent", OnPlayerLogin)
