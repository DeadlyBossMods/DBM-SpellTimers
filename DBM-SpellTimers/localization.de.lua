if GetLocale() ~= "deDE" then
	return
end
local L = DBM:GetModLocalization("SpellTimers")

L:SetGeneralLocalization({
	name	= "SpellTimers"
})

L:SetOptionLocalization({
	Enable					= "Aktiviere Abklingzeitenanzeige",
	Show_LocalMessage 		= "Zeige lokale Nachricht, wenn ein Zauber gewirkt wird",
	Enable_inRaid			= "Zeige nur Abklingzeiten von Schlachtzugmitgliedern",
	Enable_inBattleground	= "Zeige Abklingzeiten auch in Schlachtfeldern",
	Enable_Portals			= "Zeige Dauer von Magierportalen"
})

L:SetMiscLocalization({
	Local_CastMessage		= "Zauber gefunden: %s",
	AreaAuras				= "Konfiguration der Zauber und Fähigkeiten für die Abklingzeitenanzeige",
	SpellID					= "Zauber ID",
	BarText					= "Balkenbeschriftung (z.B.: %spell: %player)",
	Cooldown				= "Abklingzeit",
	Error_FillUp			= "Bitte fülle erst alle Felder aus, bevor du eine neue Zeile hinzufügst.",
	TabCategory_SpellsUsed	= "Zauber/Fähigkeiten-Abklingzeiten"
})
