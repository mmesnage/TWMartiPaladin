local pName = UnitName("player")
local blessings = {};
blessings[0] = "Blessing of Wisdom";
blessings[1] = "Blessing of Might";
blessings[2] = "Blessing of Salvation";
blessings[3] = "Blessing of Light";
blessings[4] = "Blessing of Kings";
blessings[5] = "Blessing of Sanctuary";
local buffed = FindBuff;
local autoBoP = false
local bopTarget = nil

TWMPALFRAME = CreateFrame("Button","TWMPALFRAME",UIParent)

TWMPALFRAME:RegisterEvent("CHAT_MSG_WHISPER")

function TWMPALFRAME:OnEvent()
	if event == "CHAT_MSG_WHISPER" then
		if (autoBoP and UnitInRaid("player") and UnitClass("player") == "Paladin" and string.lower(arg1) == string.lower("BOP ME!")) then
			print(arg2.." wants a BoP!")
			if (not OnCooldown("Blessing of Protection")) then
				bopTarget = arg2
			else
				SendChatMessage("BoP on CD, RIP!", "WHISPER", nil, arg2)
			end
		end
	end
end

TWMPALFRAME:SetScript("OnEvent", TWMPALFRAME.OnEvent)

local function IsBlessingClassIndexAssigned(blessing, classIndex)
	for _, assignments in pairs(PallyPower_Assignments) do
		if assignments[classIndex] == blessing then
			return true
		end
	end
	return false
end

local function IsBlessingAssigned(class, blessing)
	if class=="Warrior" then
		return IsBlessingClassIndexAssigned(blessing, 0)
	elseif class=="Rogue" then
		return IsBlessingClassIndexAssigned(blessing, 1)
	elseif class=="Priest" then
		return IsBlessingClassIndexAssigned(blessing, 2)
	elseif class=="Druid" then
		return IsBlessingClassIndexAssigned(blessing, 3)
	elseif class=="Paladin" then
		return IsBlessingClassIndexAssigned(blessing, 4)
	elseif class=="Hunter" then
		return IsBlessingClassIndexAssigned(blessing, 5)
	elseif class=="Mage" then
		return IsBlessingClassIndexAssigned(blessing, 6)
	elseif class=="Warlock" then
		return IsBlessingClassIndexAssigned(blessing, 7)
	elseif class=="Shaman" then
		return IsBlessingClassIndexAssigned(blessing, 8)
	end
	return false
end

local function GetAssignedBlessing(class, name)
	local blessing = nil
	if class=="Warrior" then
		local warAssignedBlessing = PallyPower_Assignments[name][0]
		if warAssignedBlessing and warAssignedBlessing ~= -1 then
			blessing = blessings[warAssignedBlessing]
		end
	elseif class=="Rogue" then
		local rogAssignedBlessing = PallyPower_Assignments[name][1]
		if rogAssignedBlessing and rogAssignedBlessing ~= -1 then
			blessing = blessings[rogAssignedBlessing]
		end
	elseif class=="Priest" then
		local priAssignedBlessing = PallyPower_Assignments[name][2]
		if priAssignedBlessing and priAssignedBlessing ~= -1 then
			blessing = blessings[priAssignedBlessing]
		end
	elseif class=="Druid" then
		local druAssignedBlessing = PallyPower_Assignments[name][3]
		if druAssignedBlessing and druAssignedBlessing ~= -1 then
			blessing = blessings[druAssignedBlessing]
		end
	elseif class=="Paladin" then
		local palAssignedBlessing = PallyPower_Assignments[name][4]
		if palAssignedBlessing and palAssignedBlessing ~= -1 then
			blessing = blessings[palAssignedBlessing]
		end
	elseif class=="Hunter" then
		local hunAssignedBlessing = PallyPower_Assignments[name][5]
		if hunAssignedBlessing and hunAssignedBlessing ~= -1 then
			blessing = blessings[hunAssignedBlessing]
		end
	elseif class=="Mage" then
		local magAssignedBlessing = PallyPower_Assignments[name][6]
		if magAssignedBlessing and magAssignedBlessing ~= -1 then
			blessing = blessings[magAssignedBlessing]
		end
	elseif class=="Warlock" then
		local wlkAssignedBlessing = PallyPower_Assignments[name][7]
		if wlkAssignedBlessing and wlkAssignedBlessing ~= -1 then
			blessing = blessings[wlkAssignedBlessing]
		end
	elseif class=="Shaman" then
		local shmAssignedBlessing = PallyPower_Assignments[name][8]
		if shmAssignedBlessing and shmAssignedBlessing ~= -1 then
			blessing = blessings[shmAssignedBlessing]
		end
	end	
	return blessing
end

local function BuffTarget(raidUnit, buff)
	TargetUnit(raidUnit)
	CastSpellByName(buff)
	TargetUnit("playertarget")
end

local function IsFriendAlive(unitId)
	return 
	UnitIsVisible(unitId)
	and UnitIsConnected(unitId) 
	and not UnitIsDead(unitId)
	and UnitHealth(unitId) > 1 
	and UnitIsFriend("player", unitId)
end

local function SpellExists(findspell)
	if not findspell then return end
	for i = 1, MAX_SKILLLINE_TABS do
		local name, texture, offset, numSpells = GetSpellTabInfo(i);
		if not name then break end
		for s = offset + 1, offset + numSpells do
		local	spell, rank = GetSpellName(s, BOOKTYPE_SPELL);
		if rank then
			local spell = spell.." "..rank;
		end
		if string.find(spell,findspell,nil,true) then
			return true
		end
		end
	end
end

local function TWMBuffMissingWisdom(raidUnit)
	local raidUnitClass = UnitClass(raidUnit)
	if GetAssignedBlessing(raidUnitClass, pName) == "Blessing of Might"
	and not buffed("Greater Blessing of Might", raidUnit) 
	and IsFriendAlive(raidUnit)
	then

		local isWisdomAssigned = IsBlessingAssigned(raidUnitClass, 0)
		local buffedWisdom = buffed("Greater Blessing of Wisdom", raidUnit) or buffed("Blessing of Wisdom", raidUnit)

		if SpellExists("Blessing of Wisdom") 
		and not isWisdomAssigned and not buffedWisdom and raidUnitClass ~="Warrior" and raidUnitClass ~="Rogue" then	
			BuffTarget(raidUnit, "Blessing of Wisdom")
		end					
	end
end

local function TWMBuffMissingMight(raidUnit)
	local raidUnitClass = UnitClass(raidUnit)
	if GetAssignedBlessing(raidUnitClass, pName) == "Blessing of Wisdom"
	and not buffed("Greater Blessing of Wisdom", raidUnit) 
	and IsFriendAlive(raidUnit)
	then
		
		local isMightAssigned = IsBlessingAssigned(raidUnitClass, 1)
		local buffedMight = buffed("Greater Blessing of Might", raidUnit) or buffed("Blessing of Might", raidUnit)

		if SpellExists("Blessing of Might") 
		and not isMightAssigned and not buffedMight then	
			BuffTarget(raidUnit, "Blessing of Might")
		end					
	end
end

local function TWMBuffTankBlessing(raidUnit)
	local raidUnitClass = UnitClass(raidUnit)
	if GetAssignedBlessing(raidUnitClass, pName) == "Blessing of Salvation"
	and not buffed("Greater Blessing of Salvation", raidUnit) 
	and not buffed("Blessing of Salvation", raidUnit) 
	and IsFriendAlive(raidUnit)
	then
		local isKingAssigned = IsBlessingAssigned(raidUnitClass, 4)
		local isMightAssigned = IsBlessingAssigned(raidUnitClass, 1)
		local isLightAssigned = IsBlessingAssigned(raidUnitClass, 3)
		local isSanctuaryAssigned = IsBlessingAssigned(raidUnitClass, 5)

		local buffedKings = buffed("Greater Blessing of Kings", raidUnit) or buffed("Blessing of Kings", raidUnit)
		local buffedMight = buffed("Greater Blessing of Might", raidUnit) or buffed("Blessing of Might", raidUnit)
		local buffedLight = buffed("Greater Blessing of Light", raidUnit) or buffed("Blessing of Light", raidUnit)
		local buffedSanct = buffed("Greater Blessing of Sanctuary", raidUnit) or buffed("Blessing of Sanctuary", raidUnit)

		if SpellExists("Blessing of Sanctuary") 
		and isKingAssigned
		and isMightAssigned
		and isLightAssigned
		and not isSanctuaryAssigned	and	not buffedSanct then	
			BuffTarget(raidUnit, "Blessing of Sanctuary")
		elseif SpellExists("Blessing of Light") 
		and isKingAssigned
		and isMightAssigned
		and not isLightAssigned	and	not buffedLight then	
			BuffTarget(raidUnit, "Blessing of Light")
		elseif SpellExists("Blessing of Might") 
		and isKingAssigned
		and not isMightAssigned	and not buffedMight then	
			BuffTarget(raidUnit, "Blessing of Might")
		elseif SpellExists("Blessing of Kings") 
		and not isKingAssigned	and not buffedKings then	
			BuffTarget(raidUnit, "Blessing of Kings")
		end
	end
end

function TWMBoP()  
	if not UnitInRaid("player") or UnitClass("player") ~= "Paladin" then return end
	if bopTarget then
		TargetByName(bopTarget)
		if not OnCooldown("Blessing of Protection") and not buffed("Forbearance", "target") then
			CastSpellByName("Blessing of Protection")
		end
		TargetUnit("playertarget")		
		bopTarget = nil
  	end
end

function TWMAutoBoP(bool)
	if (bool == 1) then
		print("TWM Auto BoP Activated!")
		autoBoP = true
	else
		print("TWM Auto BoP Deactivated!")
		autoBoP = false
	end
end

function TWMMissingTankBlessing()
	if not UnitInRaid("player") or UnitClass("player") ~= "Paladin" then return end
	for i = 1, GetNumRaidMembers() do
		local raidUnit = "raid" .. i
		TWMBuffTankBlessing(raidUnit)
	end
end

function TWMMissingSmallBlessing()
	if not UnitInRaid("player") or UnitClass("player") ~= "Paladin" then return end
	for i = 1, GetNumRaidMembers() do
		local raidUnit = "raid" .. i
		TWMBuffMissingWisdom(raidUnit)
		TWMBuffMissingMight(raidUnit)
		TWMBuffTankBlessing(raidUnit)
	end
end

function TWMPalTaunt()
	if not SpellExists("Judgement") or not SpellExists("Seal of Justice") or OnCooldown("Judgement") then return end
	if not buffed("Seal of Justice", "player") then 
		CastSpellByName("Seal of Justice") 
	else
		CastSpellByName("Judgement") 
	end
end


