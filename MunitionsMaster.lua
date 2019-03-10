local _, core = ...;
local MuMaFrame = CreateFrame("Frame", "MuMa_Frame", UIParent, "TranslucentFrameTemplate")
local testTime = 5000
local sinceLastUpdate

SLASH_RELOADUI1 = "/rl";
SlashCmdList.RELOADUI = ReloadUI;

local function SecondsToClock(seconds)
    local seconds = tonumber(seconds)
  
    if seconds <= 0 then
      return "00:00:00";
    else
      hours = string.format("%02.f", math.floor(seconds/3600));
      mins = string.format("%02.f", math.floor(seconds/60 - (hours*60)));
      secs = string.format("%02.f", math.floor(seconds - hours*3600 - mins *60));
      return hours..":"..mins..":"..secs
    end
end

local function initialize() -- event and name were params; self will refer to events frame, not core
    MuMaFrame:SetScript("OnUpdate", function(self, sinceLastUpdate) MuMaFrame:onUpdate(sinceLastUpdate); end);

    MuMaFrame:SetSize(200, 75);
    MuMaFrame:SetPoint("RIGHT", UIParent, "RIGHT") --point, relativeFrame, relativePoint, xOffset, yOffset
    MuMaFrame.text = MuMaFrame:CreateFontString(nil, "ARTWORK")
    MuMaFrame.text:SetFont("Fonts\\ARIALN.ttf", 20, "OUTLINE")
    MuMaFrame.text:SetPoint("CENTER",0,0)
    MuMaFrame.text:SetText('Test text.')
    MuMaFrame.text:SetText('More test text.')

    --MuMaFrame:RegisterForDrag("LeftButton")
end

function MuMaFrame:onUpdate(sinceLastUpdate)
	self.sinceLastUpdate = (self.sinceLastUpdate or 0) + sinceLastUpdate;
	if ( self.sinceLastUpdate >= 1 ) then
        testTime = testTime - 1
        MuMaFrame.text:SetText(SecondsToClock(testTime))
		self.sinceLastUpdate = 0;
	end
end


local function printBagContents()
    print('Begin printing bag contents')
    for bag=0, NUM_BAG_SLOTS do
        for slot=1, GetContainerNumSlots(bag) do
            local texture, count, locked, quality, readable, lootable, link, isFiltered, hasNoValue, itemID = GetContainerItemInfo(bag, slot)
            if(itemID ~= nil) then
                local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType,
                itemSubType, itemStackCount, itemEquipLoc, itemTexture, itemSellPrice = GetItemInfo(itemID)
                local itemFamily = GetItemFamily(itemID)
                if(itemType == "Consumable") then
                    print('Bag: '..tostring(bag)..' Slot: '..tostring(slot)..' Item: '..tostring(itemName)..' Item Type: '..itemType)
                else
                    print('Bag: '..tostring(bag)..' Slot: '..tostring(slot)..'Item: Not Consumable')
                end
            else
                print('Bag: '..tostring(bag)..' Slot: '..tostring(slot)..'Item: Empty')
            end
        end
    end
end

initialize()
--printBagContents()


    --[[MuMaFrame.text:SetAllPoints(true)
    MuMaFrame.text:SetJustifyH("LEFT")
    MuMaFrame.text:SetJustifyV("TOP")
    MuMaFrame.text:SetTextColor(1,1,1,1)]]