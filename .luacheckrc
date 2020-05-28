std = "lua51"
max_line_length = false
exclude_files = {
	".luacheckrc"
}
ignore = {
	"211", -- Unused local variable
	"212", -- Unused argument
	"213", -- Unused loop variable
	"311", -- Value assigned to a local variable is unused
	"43.", -- Shadowing an upvalue, an upvalue argument, an upvalue loop variable.
	"542", -- An empty if branch
}
globals = {
	"_G",

	-- DeadlyBossMods
	"DBM",
	"DBM_GUI",
	"DBM_GUI_OptionsFrame",
	"DBM_GUI_OptionsFramePanelContainer",
	"DBM_SpellTimers_Settings",
	"DBM_SpellsUsed_Translations",

	-- WoW
	"GameFontDisableSmall",
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
