if GetLocale() ~= "ruRU" then
	return
end
local L = DBM:GetModLocalization("SpellTimers")

L:SetGeneralLocalization({
	name	= "SpellTimers"
})

L:SetOptionLocalization({
	Enable 					= "Включить таймеры восстановлений",
	Show_LocalMessage 		= "Показать локальное сообщение при применении",
	Enable_inRaid			= "Показывать восстановление только от участников рейда",
	Enable_inBattleground	= "Показывать восстановления на полях боя",
	Enable_Portals			= "Показать длительность порталов",
})

L:SetMiscLocalization({
	Local_CastMessage 		= "Обнаружено применение: %s",
	AreaAuras 				= "Настройки заклинаний/навыков",
	SpellID 				= "ID заклинания",
	BarText 				= "Текст полосы (по умолчанию: %spell: %player)",
	Cooldown 				= "Восстановление",
	Error_FillUp			= "Пожалуйста, заполните все поля перед добавлением нового",
	TabCategory_SpellsUsed	= "Восстановления заклинаний/навыков",
})
