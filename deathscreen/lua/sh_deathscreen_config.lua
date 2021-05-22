DeathScreen = DeathScreen or {}

if CLIENT then
	DeathScreen.panel_color = Color(55, 61, 67, 255)
	DeathScreen.text_color = Color(171, 181, 193,  255)
end

if SERVER then
	-- Generic prefixes and suffixes in an attempt to minimise class names
	DeathScreen.WeaponPrefixes = {
		[0] = "weapon_ttt_",
		[1] = "weapon_",
		[2] = "gmod_",
		[3] = "ttt_"
	}

	DeathScreen.WeaponSuffixes = {
		"_new"
	}

	-- Specific mapping for weapons that generics can't parse completely
	-- This may also be faster
	DeathScreen.WeaponMapping = {}
	DeathScreen.WeaponMapping["Suicide"] = "Whoops! You killed yourself!"
	DeathScreen.WeaponMapping["Physics"] = "You died to physics!"
end
