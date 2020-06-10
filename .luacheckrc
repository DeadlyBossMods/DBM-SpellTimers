std = "lua51"
max_line_length = false
exclude_files = {
	".luacheckrc"
}
globals = {
	"_G",

	-- DeadlyBossMods
	"DBM",
	"DBM_SpellTimers_Settings",
	"DBM_SpellsUsed_Translations",

	-- WoW
	"UIParent",
	"WOW_PROJECT_ID",
	"WOW_PROJECT_CLASSIC",

	-- API functions
	"CombatLogGetCurrentEventInfo",
	"CreateFrame",
	"GetLocale",
	"GetSpellTexture",
	"IsInInstance",
	"IsInRaid",
	"UnitFactionGroup",
	"table.wipe"
}
