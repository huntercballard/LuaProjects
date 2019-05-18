SLASH_RELOADUI1 = "/rlui";
SlashCmdList.RELOADUI = ReloadUI;
local repairManFrame = CreateFrame("FRAME", "repairManFrame")
repairManFrame:RegisterEvent("MERCHANT_SHOW")

local function merchantShowHandler()
    if(CanMerchantRepair()) then
        RepairAllItems()
    end 
end

repairManFrame:SetScript("OnEvent", merchantShowHandler)