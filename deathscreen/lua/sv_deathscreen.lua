--[[
	sv_deathscreen.lua
	Handles networking events for sharing death info with the client and death
	hooks
]]--

include("sh_deathscreen_config.lua")
util.AddNetworkString("Deathscreen_msg")

function SendDeathString(ply, str)
	net.Start("Deathscreen_msg")
		net.WriteString(str)
	net.Send(ply)
end

function GetWeaponNameMapping(Wep)
	if (DeathScreen.WeaponMapping[Wep]) then
		return DeathScreen.WeaponMapping[Wep]
	end

	-- No weapon mapping found, attempt to remove any known prefixes or suffixes
	-- and return the wep string
	local WeaponName = Wep
	local WeaponName_Orig = WeaponName
	
	local startpos, endpos, matchstr = string.find(Wep, "_")
	if (startpos) then
		for _, prefix in pairs(DeathScreen.WeaponPrefixes) do
			WeaponName = string.Replace(WeaponName, prefix, "")
			if WeaponName != WeaponName_Orig then
				break
			end
		end
	end

	startpos, endpos, matchstr = string.find(WeaponName, "_")
	if (startpos) then
		WeaponName_Orig = WeaponName
		for suffix in DeathScreen.WeaponSuffixes do
			WeaponName = string.Replace(WeaponName, suffix, "")
			if WeaponName != WeaponName_Orig then
				break
			end
		end	
	end

	return WeaponName
end

function PlayerDeath_Handler(Victim, Weapon, Attacker)
	if (Victim == Attacker) then
		SendDeathString(Victim, GetWeaponNameMapping("Suicide"))
	else
		if (IsPlayer(Attacker)) then
			SendDeathString(Victim, 
				"You were killed by "
				.. Attacker:GetName()
				.. " using " 
				.. GetWeaponNameMapping(Attacker:GetActiveWeapon():GetClass()))
		else
			SendDeathString(Victim, GetWeaponNameMapping("Physics")) 
		end
	end
end

function PlayerSilentDeath_Handler(ply)
	SendDeathString("You were killed")
end

hook.Add("PlayerDeath", "Deathscreen_PlayerDeath", PlayerDeath_Handler)
hook.Add("PlayerSilentDeath", "Deathscreen_PlayerSilentDeath",
		PlayerSilentDeath_Handler)
