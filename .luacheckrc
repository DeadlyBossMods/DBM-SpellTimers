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
	"DBT",

	-- WoW
	"UIParent",
	"WOW_PROJECT_BURNING_CRUSADE_CLASSIC",
	"WOW_PROJECT_CLASSIC",
	"WOW_PROJECT_ID",

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
