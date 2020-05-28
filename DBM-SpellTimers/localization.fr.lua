if GetLocale() ~= "frFR" then
	return
end
local L = DBM:GetModLocalization("SpellTimers")

L:SetGeneralLocalization({
	name	= "SpellTimers"
})

L:SetOptionLocalization({
	Enable					= "Activer le compteur pour le temps de recharge",
	Show_LocalMessage		= "Voir le message local d'incantation",
	Enable_inRaid			= "Afficher les temps de recharge des membres du raid",
	Enable_inBattleground	= "Afficher les temps de recharge aussi dans les champs de bataille",
	Enable_Portals			= "Dur\195\169es des portails",
})

L:SetMiscLocalization({
	Local_CastMessage		= "D\195\169tecte les incant: %s",
	AreaAuras				= "Syst\195\168me des sorts / compétences",
	SpellID					= "ID du sort",
	BarText					= "Barre de texte (par défaut: %sort: %joueur)",
	Cooldown				= "Temps de recharge",
	Error_FillUp			= "merci de remplir tous les champs avant d'ajouter un nouveau",
	TabCategory_SpellsUsed	= "incantation/Capacit\195\169 temps de recharge"
})
