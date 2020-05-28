if GetLocale() ~= "zhTW" then
	return
end
local L = DBM:GetModLocalization("SpellTimers")

L:SetGeneralLocalization({
	name	= "SpellTimers"
})

L:SetOptionLocalization({
	Enable 					= "開啟冷卻計時",
	Show_LocalMessage 		= "顯示本地提示",
	Enable_inRaid			= "僅顯示團隊成員的冷卻訊息",
	Enable_inBattleground	= "戰場中依然啟用",
	Enable_Portals			= "顯示時間"
})

L:SetMiscLocalization({
	Local_CastMessage 		= "檢測到施法: %s",
	AreaAuras 				= "技能設定",
	SpellID 				= "法術編號",
	BarText 				= "計時條文字(預設: %spell: %player)",
	Cooldown 				= "冷卻時間",
	Error_FillUp			= "請填寫完整",
	TabCategory_SpellsUsed	= "冷卻助手"
})
