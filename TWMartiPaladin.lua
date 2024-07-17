local playerName = UnitName("player")
local blessings = {};
blessings[0] = "Blessing of Wisdom";
blessings[1] = "Blessing of Might";
blessings[2] = "Blessing of Salvation";
blessings[3] = "Blessing of Light";
blessings[4] = "Blessing of Kings";
blessings[5] = "Blessing of Sanctuary";

local function GetBlessing(class)
	local blessing = nil
	local name = playerName
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

function TM_MissingTankBlessing()
	if not UnitInRaid("player") or UnitClass("player") ~= "Paladin" then return end
	for i = 1, GetNumRaidMembers() do
		local raidUnit = "raid" .. i
		if GetBlessing(UnitClass(raidUnit)) == "Blessing of Salvation"
		and not buffed("Greater Blessing of Salvation", raidUnit) 
		then
			if (buffed("Greater Blessing of Kings", raidUnit) or buffed("Blessing of Kings", raidUnit))
			and (buffed("Greater Blessing of Might", raidUnit) or buffed("Blessing of Might", raidUnit))
			and	not buffed("Greater Blessing of Light", raidUnit) 
			and not buffed("Blessing of Light", raidUnit) then	
				BuffTarget(raidUnit, "Blessing of Light")
			elseif (buffed("Greater Blessing of Kings", raidUnit) or buffed("Blessing of Kings", raidUnit))
			and not buffed("Greater Blessing of Might", raidUnit) 
			and not buffed("Blessing of Might", raidUnit) then	
				BuffTarget(raidUnit, "Blessing of Might")
			elseif not buffed("Greater Blessing of Kings", raidUnit) 
			and not buffed("Blessing of Kings", raidUnit) then	
				BuffTarget(raidUnit, "Blessing of Kings")
			end
		end
	end
end

function TestFctTWM2()
	if not UnitInRaid("player") or UnitClass("player") ~= "Paladin" then return end
	for i = 1, GetNumRaidMembers() do
		local raidUnit = "raid" .. i
		if GetBlessing(UnitClass(raidUnit)) == "Blessing of Salvation"
		and not buffed("Greater Blessing of Salvation", raidUnit) 
		then
			if (buffed("Greater Blessing of Kings", raidUnit) or buffed("Blessing of Kings", raidUnit))
			and (buffed("Greater Blessing of Might", raidUnit) or buffed("Blessing of Might", raidUnit))
			and	not buffed("Greater Blessing of Light", raidUnit) 
			and not buffed("Blessing of Light", raidUnit) then	
				BuffTarget(raidUnit, "Blessing of Light")
			elseif (buffed("Greater Blessing of Kings", raidUnit) or buffed("Blessing of Kings", raidUnit))
			and not buffed("Greater Blessing of Might", raidUnit) 
			and not buffed("Blessing of Might", raidUnit) then	
				BuffTarget(raidUnit, "Blessing of Might")
			elseif not buffed("Greater Blessing of Kings", raidUnit) 
			and not buffed("Blessing of Kings", raidUnit) then	
				BuffTarget(raidUnit, "Blessing of Kings")
			end
		end
	end
end

function TestFctTWM()
	print("test twm")
end