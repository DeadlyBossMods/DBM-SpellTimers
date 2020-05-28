if GetLocale() ~= "koKR" then
	return
end
local L = DBM:GetModLocalization("SpellTimers")

L:SetGeneralLocalization({
	name	= "SpellTimers"
})

L:SetOptionLocalization({
	Enable 					= "쿨다운 타이머 사용",
	Show_LocalMessage 		= "시전 메세지 보기",
	Enable_inRaid			= "공격대 멤버 쿨다운만 보기",
	Enable_inBattleground	= "전장 공격대원 쿨다운 보기",
	Enable_Portals			= "마법사 포탈 지속 시간 보기"
})

L:SetMiscLocalization({
	Local_CastMessage 		= "주문 시전 감지 : %s",
	AreaAuras 				= "주문/스킬 등록",
	SpellID 				= "Spell ID",
	BarText 				= "바 글자 (기본 : 주문이름: %player)",
	Cooldown 				= "쿨다운",
	Error_FillUp			= "새로운 목록을 추가하려면 모든 항목을 입력 하셔야 합니다.",
	TabCategory_SpellsUsed	= "주문/스킬 쿨다운"
})
