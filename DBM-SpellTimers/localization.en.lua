local L = DBM:GetModLocalization("SpellTimers")

L:SetGeneralLocalization({
	name	= "SpellTimers"
})

L:SetOptionLocalization({
	Enable 					= "Enable cooldown timers",
	Show_LocalMessage 		= "Show local message on cast",
	Enable_inRaid			= "Show cooldowns only from raid members",
	Enable_inBattleground	= "Show cooldowns also in battlegrounds",
	Enable_Portals			= "Show portal durations",
})

L:SetMiscLocalization({
	SpellID 				= "Spell ID",
	Local_CastMessage 		= "Detected cast: %s",
	AreaAuras 				= "Setup spells/skills",
	BarText 				= "Bar Text (default: %spell: %player)",
	Cooldown 				= "Cooldown",
	Error_FillUp			= "Please fill all fields before adding a new one",
	TabCategory_SpellsUsed	= "Spell/Skill Cooldowns"
})
