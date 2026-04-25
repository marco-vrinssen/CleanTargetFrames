local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_LOGIN")
f:SetScript("OnEvent", function(self)
    TargetFrame.maxDebuffs = 0
    FocusFrame.maxDebuffs = 0
    hooksecurefunc(FocusFrameMixin, "SetSmallSize", function(frame)
        frame.maxDebuffs = 0
    end)
    self:UnregisterAllEvents()
end)
