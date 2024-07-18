local playerName = UnitName("player")
local blessings = {};
blessings[0] = "Blessing of Wisdom";
blessings[1] = "Blessing of Might";
blessings[2] = "Blessing of Salvation";
blessings[3] = "Blessing of Light";
blessings[4] = "Blessing of Kings";
blessings[5] = "Blessing of Sanctuary";
buffed = FindBuff;

local function GetBlessing(class)
	local blessing = nil
	if class=="Warrior" then
		local warAssignedBlessing = PallyPower_Assignments[playerName][0]
		if warAssignedBlessing and warAssignedBlessing ~= -1 then
			blessing = blessings[warAssignedBlessing]
		end
	elseif class=="Rogue" then
		local rogAssignedBlessing = PallyPower_Assignments[playerName][1]
		if rogAssignedBlessing and rogAssignedBlessing ~= -1 then
			blessing = blessings[rogAssignedBlessing]
		end
	elseif class=="Priest" then
		local priAssignedBlessing = PallyPower_Assignments[playerName][2]
		if priAssignedBlessing and priAssignedBlessing ~= -1 then
			blessing = blessings[priAssignedBlessing]
		end
	elseif class=="Druid" then
		local druAssignedBlessing = PallyPower_Assignments[playerName][3]
		if druAssignedBlessing and druAssignedBlessing ~= -1 then
			blessing = blessings[druAssignedBlessing]
		end
	elseif class=="Paladin" then
		local palAssignedBlessing = PallyPower_Assignments[playerName][4]
		if palAssignedBlessing and palAssignedBlessing ~= -1 then
			blessing = blessings[palAssignedBlessing]
		end
	elseif class=="Hunter" then
		local hunAssignedBlessing = PallyPower_Assignments[playerName][5]
		if hunAssignedBlessing and hunAssignedBlessing ~= -1 then
			blessing = blessings[hunAssignedBlessing]
		end
	elseif class=="Mage" then
		local magAssignedBlessing = PallyPower_Assignments[playerName][6]
		if magAssignedBlessing and magAssignedBlessing ~= -1 then
			blessing = blessings[magAssignedBlessing]
		end
	elseif class=="Warlock" then
		local wlkAssignedBlessing = PallyPower_Assignments[playerName][7]
		if wlkAssignedBlessing and wlkAssignedBlessing ~= -1 then
			blessing = blessings[wlkAssignedBlessing]
		end
	elseif class=="Shaman" then
		local shmAssignedBlessing = PallyPower_Assignments[playerName][8]
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

function TWMMissingTankBlessing()
	if not UnitInRaid("player") or UnitClass("player") ~= "Paladin" then return end
	for i = 1, GetNumRaidMembers() do
		local raidUnit = "raid" .. i
		if GetBlessing(UnitClass(raidUnit)) == "Blessing of Salvation"
		and not buffed("Greater Blessing of Salvation", raidUnit) 
		and IsFriendAlive(raidUnit)
		then
			local buffedKings = (buffed("Greater Blessing of Kings", raidUnit) or buffed("Blessing of Kings", raidUnit))
			local buffedMight = (buffed("Greater Blessing of Might", raidUnit) or buffed("Blessing of Might", raidUnit))
			local buffedLight = (buffed("Greater Blessing of Light", raidUnit) or buffed("Blessing of Light", raidUnit))
			local buffedSanct = (buffed("Greater Blessing of Sanctuary", raidUnit) or buffed("Blessing of Sanctuary", raidUnit))

			if buffedKings
			and buffedMight
			and buffedLight
			and	not buffedSanct then	
				BuffTarget(raidUnit, "Blessing of Sanctuary")
			elseif buffedKings
			and buffedMight
			and	not buffedLight then	
				BuffTarget(raidUnit, "Blessing of Light")
			elseif buffedKings
			and not buffedMight then	
				BuffTarget(raidUnit, "Blessing of Might")
			elseif not buffedKings then	
				BuffTarget(raidUnit, "Blessing of Kings")
			end
		end
	end
end

function TWMMissingTankBlessingV2()
	if not UnitInRaid("player") or UnitClass("player") ~= "Paladin" then return end
	for i = 1, GetNumRaidMembers() do
		local raidUnit = "raid" .. i
		if GetBlessing(UnitClass(raidUnit)) == "Blessing of Salvation"
		and not buffed("Greater Blessing of Salvation", raidUnit) 
		and IsFriendAlive(raidUnit)
		then
			local buffedKings = (buffed("Greater Blessing of Kings", raidUnit) or buffed("Blessing of Kings", raidUnit))
			local buffedMight = (buffed("Greater Blessing of Might", raidUnit) or buffed("Blessing of Might", raidUnit))
			local buffedLight = (buffed("Greater Blessing of Light", raidUnit) or buffed("Blessing of Light", raidUnit))
			local buffedSanct = (buffed("Greater Blessing of Sanctuary", raidUnit) or buffed("Blessing of Sanctuary", raidUnit))

			if SpellExists("Blessing of Sanctuary") 
			and buffedKings
			and buffedMight
			and buffedLight
			and	not buffedSanct then	
				BuffTarget(raidUnit, "Blessing of Sanctuary")
			elseif SpellExists("Blessing of Light") 
			and buffedKings
			and buffedMight
			and	not buffedLight then	
				BuffTarget(raidUnit, "Blessing of Light")
			elseif SpellExists("Blessing of Might") 
			and buffedKings
			and not buffedMight then	
				BuffTarget(raidUnit, "Blessing of Might")
			elseif SpellExists("Blessing of Kings") 
			and not buffedKings then	
				BuffTarget(raidUnit, "Blessing of Kings")
			end
		end
	end
end
