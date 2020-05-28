if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then
	return
end
local L = DBM:GetModLocalization("SpellTimers")

L:SetGeneralLocalization({
	name	= "SpellTimers"
})

L:SetOptionLocalization({
	Enable 					= "Habilitar temporizadores",
	Show_LocalMessage 		= "Enviar mensaje con el lanzamiento",
	Enable_inRaid			= "Mostrar solo tiempos de reutilización de los miembros de banda",
	Enable_inBattleground	= "Mostrar tiempos de reutilización en campos de batalla",
	Enable_Portals			= "Mostrar duración de portales",
})

L:SetMiscLocalization({
	Local_CastMessage 		= "Lanzamiento detectado: %s",
	AreaAuras 				= "Configuración de hechizos y facultades",
	SpellID 				= "ID",
	BarText 				= "Texto",
	Cooldown 				= "Tiempo de reutilización",
	Error_FillUp			= "Por favor, rellena todos los campos antes de añadir otro hechizo o facultad.",
	TabCategory_SpellsUsed	= "Tiempos de reutilización"
})
