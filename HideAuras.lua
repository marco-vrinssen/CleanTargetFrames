local MAX_BUFF_DURATION = 30

local GetAuraData = C_UnitAuras.GetAuraDataByAuraInstanceID

local function GetAura(frame)
    if not frame.unit or not frame.auraInstanceID then return nil end
    return GetAuraData(frame.unit, frame.auraInstanceID)
end

local function ShouldHideBuff(data)
    local ok, hide = pcall(function()
        local duration = data.duration or 0
        local isShortTerm = duration > 0 and duration <= MAX_BUFF_DURATION
        return not (isShortTerm or data.isStealable)
    end)
    return ok and hide
end

local function ShouldHideDebuff(data)
    local ok, hide = pcall(function()
        return not data.isFromPlayerOrPlayerPet
    end)
    return ok and hide
end

local function FilterAuras(frame)
    if not frame or not frame.auraPools then return end

    local buffPool = frame.auraPools:GetPool("TargetBuffFrameTemplate")
    if buffPool then
        for auraFrame in buffPool:EnumerateActive() do
            local data = GetAura(auraFrame)
            if data and ShouldHideBuff(data) then
                auraFrame:Hide()
            end
        end
    end

    local debuffPool = frame.auraPools:GetPool("TargetDebuffFrameTemplate")
    if debuffPool then
        for auraFrame in debuffPool:EnumerateActive() do
            local data = GetAura(auraFrame)
            if data and ShouldHideDebuff(data) then
                auraFrame:Hide()
            end
        end
    end
end

local hooked = {}
local function HookFrame(frame)
    if not frame or hooked[frame] then return end
    hooked[frame] = true
    hooksecurefunc(frame, "UpdateAuras", FilterAuras)
    FilterAuras(frame)
end

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_LOGIN")
f:SetScript("OnEvent", function()
    HookFrame(TargetFrame)
    HookFrame(FocusFrame)
end)
