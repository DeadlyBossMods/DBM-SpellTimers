if GetLocale() ~= "itIT" then
	return
end
local L = DBM:GetModLocalization("SpellTimers")

L:SetGeneralLocalization({
	name	= "SpellTimers"
})

L:SetOptionLocalization({
	Enable 					= "Abilita i Timer di CD",
	Show_LocalMessage 		= "Visualizza un messaggio locale per i lanci delle magie",
	Enable_inRaid			= "Visualizza i CD solo per i membri dell'incursione",
	Enable_inBattleground	= "Visualizza i CD anche nei Campi di Battaglia",
	Enable_Portals			= "Visualizza la durata dei portali"
})

L:SetMiscLocalization({
	Local_CastMessage 		= "Intercettato: %s",
	AreaAuras 				= "Imposta Magie",
	SpellID 				= "ID della Magia",
	BarText 				= "Testo della Barra (default: %spell: %player)",
	Cooldown 				= "Cooldown",
	Error_FillUp			= "Riempi tutti i campi prima di aggiungere una nuova magia",
	TabCategory_SpellsUsed	= "Cooldown"
})
