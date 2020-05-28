-- **********************************************************
-- **             Deadly Boss Mods - SpellsUsed            **
-- **             http://www.deadlybossmods.com            **
-- **********************************************************
--
-- This addon is written and copyrighted by:
--    * Martin Verges (Nitram @ EU-Azshara)
--    * Paul Emmerich (Tandanu @ EU-Aegwynn)
--
-- The localizations are written by:
--    * enGB/enUS: Nitram/Tandanu        http://www.deadlybossmods.com
--    * deDE: Nitram/Tandanu             http://www.deadlybossmods.com
--    * zhCN: yleaf(yaroot@gmail.com)
--    * zhTW: yleaf(yaroot@gmail.com)/Juha
--    * koKR: BlueNyx(bluenyx@gmail.com)/nBlueWiz(everfinale@gmail.com)
--    * esES: Interplay/1nn7erpLaY       http://www.1nn7erpLaY.com
--
-- This work is licensed under a Creative Commons Attribution-Noncommercial-Share Alike 3.0 License. (see license.txt)
--
--  You are free:
--    * to Share - to copy, distribute, display, and perform the work
--    * to Remix - to make derivative works
--  Under the following conditions:
--    * Attribution. You must attribute the work in the manner specified by the author or licensor (but not in any way that suggests that they endorse you or your use of the work).
--    * Noncommercial. You may not use this work for commercial purposes.
--    * Share Alike. If you alter, transform, or build upon this work, you may distribute the resulting work only under the same or similar license to this one.
--

local mod	= DBM:NewMod("SpellTimers", "DBM-SpellTimers")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetZone(DBM_DISABLE_ZONE_DETECTION)

mod:AddBoolOption("Enable", true, "General")
mod:AddBoolOption("Show_LocalMessage", true, "General")
mod:AddBoolOption("Enable_inRaid", true, "General")
mod:AddBoolOption("Enable_inBattleground", true, "General")
mod:AddBoolOption("Enable_Portals", true, "General")

local pairs, type = pairs, type

local default_bartext = "%spell: %player"
local default_settings = {
	enabled			= true,
	showlocal		= true,
	only_from_raid	= true,
	active_in_pvp	= true,
	own_bargroup	= false,
	show_portal		= true,
	spells			= {
		{ spell = 22700, bartext = default_bartext, cooldown = 600 }, 	-- Field Repair Bot 74A
		{ spell = 44389, bartext = default_bartext, cooldown = 600 }, 	-- Field Repair Bot 110G
		{ spell = 54711, bartext = default_bartext, cooldown = 300 }, 	-- Scrapbot Construction Kit
		{ spell = 67826, bartext = default_bartext, cooldown = 600 }, 	-- Jeeves

	},
	portal_alliance	= {
		{ spell = 10059, bartext = default_bartext, cooldown = 60 }, 	-- Portal: Stormwind
		{ spell = 11416, bartext = default_bartext, cooldown = 60 }, 	-- Portal: Ironforge
		{ spell = 11419, bartext = default_bartext, cooldown = 60 }, 	-- Portal: Darnassus
		{ spell = 32266, bartext = default_bartext, cooldown = 60 }, 	-- Portal: Exodar
		{ spell = 33691, bartext = default_bartext, cooldown = 60 }, 	-- Portal: Shattrath
		{ spell = 49360, bartext = default_bartext, cooldown = 60 }, 	-- Portal: Theramore
		{ spell = 53142, bartext = default_bartext, cooldown = 60 }, 	-- Portal: Dalaran (Northrend)
		{ spell = 88345, bartext = default_bartext, cooldown = 60 }, 	-- Portal: Tol Barad
		{ spell = 132620, bartext = default_bartext, cooldown = 60 }, 	-- Portal: Vale of eternal Blossoms
		{ spell = 120146, bartext = default_bartext, cooldown = 60 }, 	-- Ancient Portal: Dalaran
		{ spell = 176246, bartext = default_bartext, cooldown = 60 }, 	-- Portal: Stormshield
		{ spell = 224873, bartext = default_bartext, cooldown = 60 }, 	-- Portal: Dalaran - Broken Isles
		{ spell = 281400, bartext = default_bartext, cooldown = 60 }, 	-- Portal: Boralus
	},
	portal_horde	= {
		{ spell = 11417, bartext = default_bartext, cooldown = 60 }, 	-- Portal: Orgrimmar
		{ spell = 11418, bartext = default_bartext, cooldown = 60 }, 	-- Portal: Undercity
		{ spell = 11420, bartext = default_bartext, cooldown = 60 }, 	-- Portal: Thunder Bluff
		{ spell = 32667, bartext = default_bartext, cooldown = 60 }, 	-- Portal: Silvermoon
		{ spell = 35717, bartext = default_bartext, cooldown = 60 }, 	-- Portal: Shattrath
		{ spell = 49361, bartext = default_bartext, cooldown = 60 }, 	-- Portal: Stonard
		{ spell = 53142, bartext = default_bartext, cooldown = 60 }, 	-- Portal: Dalaran (Northrend)
		{ spell = 88346, bartext = default_bartext, cooldown = 60 }, 	-- Portal: Tol Barad
		{ spell = 132626, bartext = default_bartext, cooldown = 60 }, 	-- Portal: Vale of eternal Blossoms
		{ spell = 120146, bartext = default_bartext, cooldown = 60 }, 	-- Ancient Portal: Dalaran
		{ spell = 176244, bartext = default_bartext, cooldown = 60 }, 	-- Portal: Warspear
		{ spell = 224873, bartext = default_bartext, cooldown = 60 }, 	-- Portal: Dalaran - Broken Isles
		{ spell = 281402, bartext = default_bartext, cooldown = 60 }, 	-- Portal: Dazar'alor
	}
}

local SpellBars
local SpellBarIndex = {}
local SpellIDIndex = {}

local function rebuildSpellIDIndex()
	SpellIDIndex = {}
	for k, v in pairs(mod.Options.spells) do
		if v.spell then
			SpellIDIndex[v.spell] = k
		end
	end
end

local function addDefaultOptions(t1, t2)
	for i, v in pairs(t2) do
		if not t1[i] then
			t1[i] = v
		elseif type(v) == "table" and type(t1[i]) == "table" then
			addDefaultOptions(t1[i], v)
		end
	end
end
addDefaultOptions(mod.Options, default_settings)

do
	DBM:RegisterOnGuiLoadCallback(function()
		local createnewentry
		local CurCount = 0
		local auraArea = mod.panel:CreateArea(L.AreaAuras, 20)

		do
			local function onchange_spell(field)
				return function(self)
					mod.Options.spells[self.guikey] = mod.Options.spells[self.guikey] or {}
					if field == "spell" then
						mod.Options.spells[self.guikey][field] = self:GetNumber()
						rebuildSpellIDIndex()
					elseif field == "cooldown" then
						mod.Options.spells[self.guikey][field] = self:GetNumber()
					elseif field == "enabled" then
						mod.Options.spells[self.guikey].enabled = not not self:GetChecked()
					else
						mod.Options.spells[self.guikey][field] = self:GetText()
					end
				end
			end

			local function onshow_spell(field)
				return function(self)
					mod.Options.spells[self.guikey] = mod.Options.spells[self.guikey] or {}
					if field == "bartext" and mod.Options.spells[self.guikey].spell and mod.Options.spells[self.guikey].spell > 0 then
						local spellinfo = DBM:GetSpellInfo(mod.Options.spells[self.guikey].spell)
						if not spellinfo then
							DBM:AddMsg("Illegal SpellID found. Please remove the Spell " .. mod.Options.spells[self.guikey].spell .. " from your DBM Options GUI (spelltimers)");
						else
							self:SetText(string.gsub(mod.Options.spells[self.guikey][field] or "", "%%spell", spellinfo))
						end
					elseif field == "enabled" then
						self:SetChecked(mod.Options.spells[self.guikey].enabled)
					else
						self:SetText(mod.Options.spells[self.guikey][field] or "")
					end
				end
			end

			local getadditionalid = CreateFrame("Button", "GetAdditionalID_Pull", auraArea.frame)
			getadditionalid:SetNormalTexture(130838) -- "Interface\\Buttons\\UI-PlusButton-UP"
			getadditionalid:SetPushedTexture(130836) -- "Interface\\Buttons\\UI-PlusButton-DOWN"
			getadditionalid:SetWidth(15)
			getadditionalid:SetHeight(15)

			function createnewentry()
				CurCount = CurCount + 1
				local spellid = auraArea:CreateEditBox(L.SpellID, "", 65)
				spellid.guikey = CurCount
				spellid:SetPoint("TOPLEFT", auraArea.frame, "TOPLEFT", 40, 15 - (CurCount * 35))
				spellid:SetScript("OnTextChanged", onchange_spell("spell"))
				spellid:SetScript("OnShow", onshow_spell("spell"))
				spellid:SetNumeric(true)

				local bartext = auraArea:CreateEditBox(L.BarText, "", 190)
				bartext.guikey = CurCount
				bartext:SetPoint('TOPLEFT', spellid, "TOPRIGHT", 20, 0)
				bartext:SetScript("OnTextChanged", onchange_spell("bartext"))
				bartext:SetScript("OnShow", onshow_spell("bartext"))

				local cooldown = auraArea:CreateEditBox(L.Cooldown, "", 45)
				cooldown.guikey = CurCount
				cooldown:SetPoint("TOPLEFT", bartext, "TOPRIGHT", 20, 0)
				cooldown:SetScript("OnTextChanged", onchange_spell("cooldown"))
				cooldown:SetScript("OnShow", onshow_spell("cooldown"))
				cooldown:SetNumeric(true)

				local enableit = auraArea:CreateCheckButton("")
				enableit.guikey = CurCount
				enableit:SetScript("OnShow", onshow_spell("enabled"))
				enableit:SetScript("OnClick", onchange_spell("enabled"))
				enableit:SetPoint("LEFT", cooldown, "RIGHT", 5, 0)

				getadditionalid:ClearAllPoints()
				getadditionalid:SetPoint("RIGHT", spellid, "LEFT", -15, 0)

				getadditionalid:SetScript("OnClick", function()
					if spellid:GetNumber() > 0 and bartext:GetText():len() > 0 and cooldown:GetNumber() > 0 then
						createnewentry()
					else
						DBM:AddMsg(L.Error_FillUp)
					end
				end)
			end

			if #mod.Options.spells == 0 then
				createnewentry()
			else
				for i = 1, #mod.Options.spells do
					createnewentry()
				end
			end
		end
	end)
end

do
	local UnitFactionGroup, IsInRaid, IsInInstance, CombatLogGetCurrentEventInfo, GetSpellTexture = UnitFactionGroup, IsInRaid, IsInInstance, CombatLogGetCurrentEventInfo, GetSpellTexture

	local function clearAllSpellBars()
		for k, _ in pairs(SpellBarIndex) do
			SpellBars:CancelBar(k)
			SpellBarIndex[k] = nil
		end
	end

	local myportals = {}
	local lastmsg = "";
	local mainframe = CreateFrame("frame", "DBM_SpellTimers", UIParent)
	local spellEvents = {
		["SPELL_CAST_SUCCESS"]	= true,
		["SPELL_RESURRECT"]		= true,
		["SPELL_HEAL"]			= true,
		["SPELL_AURA_APPLIED"]	= true,
		["SPELL_AURA_REFRESH"]	= true,
	}

	mainframe:SetScript("OnEvent", function(self, event, addon)
		if event == "ADDON_LOADED" and addon == "DBM-SpellTimers" then
			self:UnregisterEvent("ADDON_LOADED")
			self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
			self:RegisterEvent("PLAYER_ENTERING_BATTLEGROUND")
			self:RegisterEvent("ENCOUNTER_START")
			self:RegisterEvent("ENCOUNTER_END")
			SpellBars = DBM.Bars
			if UnitFactionGroup("player") == "Alliance" then
				myportals = mod.Options.portal_alliance
			else
				myportals = mod.Options.portal_horde
			end
			for _, v in pairs(mod.Options.spells) do
				if v.enabled == nil then
					v.enabled = true
				end
			end
			rebuildSpellIDIndex()
		elseif mod.Options.enabled and event == "ENCOUNTER_START" then
			clearAllSpellBars()
			-- Reset all CDs that are >= 3 minutes EXCEPT shaman reincarnate (20608)
			self:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
		elseif mod.Options.enabled and event == "ENCOUNTER_END" then--Encounter Ended
			-- Reset all CDs that are > 3 minutes EXCEPT shaman reincarnate (20608)
			self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
		elseif mod.Options.enabled and event == "PLAYER_ENTERING_BATTLEGROUND" then
			-- Spell cooldowns all reset on entering an arena or bg
			clearAllSpellBars()
		elseif mod.Options.enabled and event == "COMBAT_LOG_EVENT_UNFILTERED" then
			local _, event, _, _, sourceName, _, _, _, destName, _, _, extraArg1, extraArg2 = CombatLogGetCurrentEventInfo()
			if spellEvents[event] then
				-- First some exeptions (we don't want to see any skill around the world)
				if mod.Options.only_from_raid and not IsInRaid() then
					return
				end
				local _, instanceType = IsInInstance()
				if not mod.Options.only_in_pvp and (instanceType == "pvp" or instanceType == "arena") then
					return
				end
				if mod.Options.only_from_raid and not DBM:GetRaidUnitId(sourceName) then
					return
				end

				local guikey = SpellIDIndex[extraArg1]
				local v = guikey and mod.Options.spells[guikey]
				if v and v.enabled then
					if v.spell ~= extraArg1 then
						DBM:AddMsg("DBM-SpellTimers Index mismatch error! " .. guikey.. " ".. extraArg1)
					end
					local bartext = v.bartext:gsub("%%spell", extraArg2 or "UNKNOWN SPELL"):gsub("%%player", sourceName or "UNKNOWN SOURCE"):gsub("%%target", destName or "UNKNOWN TARGET")
					SpellBarIndex[bartext] = SpellBars:CreateBar(v.cooldown, bartext, GetSpellTexture(extraArg1), nil, true)
					if mod.Options.showlocal then
						local msg = L.Local_CastMessage:format(bartext)
						if not lastmsg or lastmsg ~= msg then
							DBM:AddMsg(msg)
							lastmsg = msg
						end
					end
				end
			elseif mod.Options.show_portal and event == "SPELL_CREATE" then
				if mod.Options.only_from_raid and not IsInRaid() then
					return
				end
				if mod.Options.only_from_raid and DBM:GetRaidUnitId(sourceName) == "none" then
					return
				end
				for _, v in pairs(myportals) do
					if v.spell == extraArg1 then
						local bartext = v.bartext:gsub("%%spell", extraArg2):gsub("%%player", sourceName):gsub("%%target", destName)
						SpellBarIndex[bartext] = SpellBars:CreateBar(v.cooldown, bartext, GetSpellTexture(extraArg1), nil, true)
						if mod.Options.showlocal then
							local msg = L.Local_CastMessage:format(bartext)
							if not lastmsg or lastmsg ~= msg then
								DBM:AddMsg(msg)
								lastmsg = msg
							end
						end
					end
				end
			end
		end
	end)
	mainframe:RegisterEvent("ADDON_LOADED")
end
