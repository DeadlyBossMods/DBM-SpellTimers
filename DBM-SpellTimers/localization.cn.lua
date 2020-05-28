if GetLocale() ~= "zhCN" then
	return
end
local L = DBM:GetModLocalization("SpellTimers")

L:SetGeneralLocalization({
	name	= "SpellTimers"
})

L:SetOptionLocalization({
	Enable 					= "开启冷却计时",
	Show_LocalMessage 		= "显示本地提示",
	Enable_inRaid			= "只显示团队成员的冷却信息",
	Enable_inBattleground	= "战场中同样启用",
	Enable_Portals			= "显示时间",
})

L:SetMiscLocalization({
	Reset					= "重置设置",
	Local_CastMessage 		= "检测到施法: %s",
	AreaAuras 				= "技能设置",
	SpellID 				= "法术编号",
	BarText 				= "计时条文字(预设: %spell: %player)",
	Cooldown 				= "冷却时间",
	Error_FillUp			= "请填写完整",
	TabCategory_SpellsUsed	= "冷却助手"
})
