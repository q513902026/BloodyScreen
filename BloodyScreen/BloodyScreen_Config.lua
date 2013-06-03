--This functions sets all settings back to default. It's called through /bs reset or /bs default.
function BS_RestoreDefaultSettings()
	BS_BloodBehaviour = 2
	BS_MaximumTextures = 10
	BS_Timer_RunTime = 10
	BS_DisplayOnWhiteCrits = true
	BS_MaximalScalingFactor = 1
	BS_MinimalScalingFactor = 1
	BS_EnableOnPVP = true
	BS_EnableOnPVE = true
	BS_DamageReference = false
	BS_DamageReference_UpperDamageLimit = 50000
	BS_DamageReference_AverageDamage = 25000
	BS_DrawArea_CornerFrame1:ClearAllPoints()
	BS_DrawArea_CornerFrame1:SetPoint("CENTER", "UIParent", "CENTER", - 250, 250)
	BS_DrawArea_CornerFrame2:ClearAllPoints()
	BS_DrawArea_CornerFrame2:SetPoint("CENTER", "UIParent", "CENTER", 250, - 250)
	BS_AjustTextureFrame()
end

--This function handles all /bs commands. It either resets the settings or opens the config menu.
function BS_ShowConfigMenu(cmd)
	if ((cmd == "reset") or (cmd == "default")) then
		BS_RestoreDefaultSettings()
		print("|cff0000ffBloodyScreen: |cffff0000"..BS_String_Notification_DefaultSettingsRestored.."|r")
	else
		BS_ShowSettings()
		BS_ConfigFrameOpen = true
		BS_ShowAllTextures()
		BS_ConfigMenu:Show()
	end
end

--This function is responsible for the resizing of the texture frame and it's preview frame.
function BS_AjustTextureFrame()
	local Corner1 = ""
	local Corner2 = ""
	if (BS_DrawArea_CornerFrame1:GetTop() > BS_DrawArea_CornerFrame2:GetTop()) then
		Corner1, Corner2 = "TOP", "BOTTOM"
	else
		Corner1, Corner2 = "BOTTOM", "TOP"
	end
	if (BS_DrawArea_CornerFrame1:GetLeft() < BS_DrawArea_CornerFrame2:GetLeft()) then
		Corner1, Corner2 = Corner1.."LEFT", Corner2.."RIGHT"
	else
		Corner1, Corner2 = Corner1.."RIGHT", Corner2.."LEFT"
	end
	BS_DrawArea_PreviewFrame:ClearAllPoints()
	BS_DrawArea_PreviewFrame:SetPoint(Corner1, "BS_DrawArea_CornerFrame1", Corner2, 0, 0)
	BS_DrawArea_PreviewFrame:SetPoint(Corner2, "BS_DrawArea_CornerFrame2", Corner1, 0, 0)
	BS_TextureFrame:ClearAllPoints()
	BS_TextureFrame:SetPoint(Corner1, "BS_DrawArea_CornerFrame1", Corner2, 0, 0)
	BS_TextureFrame:SetPoint(Corner2, "BS_DrawArea_CornerFrame2", Corner1, 0, 0)
end

--This function reads the settings the user made by (un-)checking the checkboxes in the config menu.
function BS_ApplySettings()
	if (BS_GeneralSettings_Trigger_ComboPoints:GetChecked() ~= nil) then
		BS_BloodBehaviour = 1
	else
		if (BS_GeneralSettings_Trigger_Criticals:GetChecked() ~= nil) then
			if (BS_GeneralSettings_Trigger_Criticals_NoTimers:GetChecked() ~= nil) then
				BS_BloodBehaviour = 2
			else 
				if (BS_Timers_Separated:GetChecked() ~= nil) then
					BS_BloodBehaviour = 3
				else
					BS_BloodBehaviour = 4
				end
			end
		end
	end
	if (BS_GeneralSettings_Trigger_Criticals_Swipes:GetChecked() ~= nil) then
		BS_DisplayOnWhiteCrits = true
	else
		BS_DisplayOnWhiteCrits = false
	end
	if (BS_GeneralSettings_Trigger_Criticals_DamageReference:GetChecked() ~= nil) then
		BS_DamageReference = true
	else
		BS_DamageReference = false
	end
	if (BS_GeneralSettings_PVP:GetChecked() ~= nil) then
		BS_EnableOnPVP = true
	else
		BS_EnableOnPVP = false
	end
	if (BS_GeneralSettings_PVE:GetChecked() ~= nil) then
		BS_EnableOnPVE = true
	else
		BS_EnableOnPVE = false
	end	
	if (BS_GeneralSettings_Trigger_Criticals_RangeChecking:GetChecked() ~= nil) then	
		BS_EnableRangeCheck = true
	else
		BS_EnableRangeCheck = false
	end
	BS_EvaluateDamageData()
	if (BS_MeasurementActive) then
		print("|cff0000ffBloodyScreen: |cff00ff00"..BS_String_Notification_MeasurementRunning.."|r")
	end
	if (BS_EnableRangeCheck) then
		local _, class = UnitClass("player")
		if (BS_RangeCheckAction[class] < 0) then
			print("|cff0000ffBloodyScreen: |cffff0000"..BS_String_Notification_RangeCheckCanNotBePerformed.."|r")
			BS_EnableRangeCheck = false
			BS_GeneralSettings_Trigger_Criticals_RangeChecking:SetChecked(nil)
		else
			--local spellname = GetSpellInfo(BS_RangeCheckAction[class])
			--if (BS_SearchSpell(spellname, "spell") == nil) then
			if (IsUsableSpell(BS_RangeCheckAction[class]) == nil) then
				print("|cff0000ffBloodyScreen: |cffff0000"..BS_String_Notification_RangeCheckCanNotBePerformed.."|r")
				BS_EnableRangeCheck = false
				BS_GeneralSettings_Trigger_Criticals_RangeChecking:SetChecked(nil)
			end
		end
	end
end 

--This functions searches a certain spell in the player's spell book. I got the code off wowwiki.com.
function BS_SearchSpell(spellName, bookType)
	local i, s
	local found = false
	for i = 1, MAX_SKILLLINE_TABS do
		local name, _, offset, numSpells = GetSpellTabInfo(i)
		if (not name) then
			break
		end
		for s = offset + 1, offset + numSpells do
			local	spell, rank = GetSpellName(s, bookType)
			if (spell == spellName) then
				found = true
			end
			if (found and spell ~= spellName) then
				return s - 1
			end
		end
	end
	if (found) then
		return s
	end
	return nil
end

--This function does the reverse of BS_ApplySettings: It sets the checkboxes after the saved settings.
function BS_ShowSettings()
	if (BS_BloodBehaviour == 1) then
		BS_GeneralSettings_Trigger_ComboPoints:SetChecked (1)
		BS_GeneralSettings_Trigger_Criticals:SetChecked(nil)
		BS_GeneralSettings_Trigger_Criticals_Timers:SetChecked(1)
		BS_Timers_Separated:SetChecked(1)
		BS_Timers_GlobalTimer:SetChecked(nil)
	else
		BS_GeneralSettings_Trigger_Criticals:SetChecked(1)
		BS_GeneralSettings_Trigger_ComboPoints:SetChecked (nil)
		if (BS_BloodBehaviour == 2) then
			BS_GeneralSettings_Trigger_Criticals_NoTimers:SetChecked(1)
			BS_GeneralSettings_Trigger_Criticals_Timers:SetChecked(nil)
		else
			BS_GeneralSettings_Trigger_Criticals_Timers:SetChecked(1)
			BS_GeneralSettings_Trigger_Criticals_NoTimers:SetChecked(nil)
			if (BS_BloodBehaviour == 3) then
				BS_Timers_Separated:SetChecked(1)
				BS_Timers_GlobalTimer:SetChecked(nil)
			else
				BS_Timers_GlobalTimer:SetChecked(1)
				BS_Timers_Separated:SetChecked(nil)
			end
		end
	end
	if (BS_EnableOnPVP) then
		BS_GeneralSettings_PVP:SetChecked(1)
	else
		BS_GeneralSettings_PVP:SetChecked(nil)
	end
	if (BS_EnableOnPVE) then
		BS_GeneralSettings_PVE:SetChecked(1)
	else
		BS_GeneralSettings_PVE:SetChecked(nil)
	end
	if (BS_DisplayOnWhiteCrits) then
		BS_GeneralSettings_Trigger_Criticals_Swipes:SetChecked(1)
	else
		BS_GeneralSettings_Trigger_Criticals_Swipes:SetChecked(nil)
	end
	if (BS_DamageReference) then
		BS_GeneralSettings_Trigger_Criticals_DamageReference:SetChecked(1)
	else
		BS_GeneralSettings_Trigger_Criticals_DamageReference:SetChecked(nil)
	end
	if (BS_EnableRangeCheck) then
		BS_GeneralSettings_Trigger_Criticals_RangeChecking:SetChecked(1)
	else
		BS_GeneralSettings_Trigger_Criticals_RangeChecking:SetChecked(nil)
	end
end

--This function calculates the lower damage limit after a damage measurement.
function BS_EvaluateDamageData()
	BS_DamageReference_LowerDamageLimit = math.max(0, BS_DamageReference_AverageDamage - (BS_DamageReference_UpperDamageLimit - BS_DamageReference_AverageDamage))
end