local templates = { "TargetBuffFrameTemplate", "TargetDebuffFrameTemplate" }

local function HideAuraPools(frame)
    if not frame or not frame.auraPools then return end
    for _, template in ipairs(templates) do
        local pool = frame.auraPools:GetPool(template)
        if pool then
            for aura in pool:EnumerateActive() do
                aura:Hide()
            end
        end
    end
end

local hooked = {}
local function HookFrame(frame)
    if not frame or hooked[frame] then return end
    hooked[frame] = true
    hooksecurefunc(frame, "UpdateAuras", HideAuraPools)
    HideAuraPools(frame)
end

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_LOGIN")
f:SetScript("OnEvent", function()
    HookFrame(TargetFrame)
    HookFrame(FocusFrame)
end)
