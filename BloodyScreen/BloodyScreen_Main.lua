local BS_EventFrame = CreateFrame("Frame", "BS_EventFrame")
BS_EventFrame:RegisterEvent("ADDON_LOADED")

local _, _, _, WowBuildInfo = GetBuildInfo()

--This function is executed when the whole addon is loaded.
function BS_Init()
	SlashCmdList["BLOODYSCREEN"] = BS_ShowConfigMenu
	SLASH_BLOODYSCREEN1 = "/bs"
	SLASH_BLOODYSCREEN2 = "/bloodyscreen"
	BS_EventFrame:UnregisterEvent("ADDON_LOADED")
	BS_EventFrame:RegisterEvent("UNIT_POWER_FREQUENT")
	BS_EventFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	BS_EventFrame:RegisterEvent("PLAYER_REGEN_DISABLED")
	BS_EventFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
	BS_CreateTextures()
	BS_TextureFrame:SetScript("OnUpdate", BS_Textures_OnUpdate)
	BS_AjustTextureFrame()
end

--This function handles the used game events.
function BS_OnEvent(self, event, ...)
	if (event == "ADDON_LOADED") then
		local addon = ...
		if (addon == "BloodyScreen") then
			BS_Init()
		end
	end
	local unitTarget,powerType = ...
	if ((event == "UNIT_POWER_FREQUENT") and (BS_BloodBehaviour == 1) and (unitTarget =="player") and (powerType=="COMBO_POINTS")) or ((event == "COMBAT_LOG_EVENT_UNFILTERED") and (BS_BloodBehaviour > 1)) then
		if (((BS_EnableOnPVP) and (UnitIsPlayer("target"))) or ((BS_EnableOnPVE) and (not UnitIsPlayer("target")))) then
			local _, eventType, sourceGUID, destGUID, swingDamage, otherDamage, swingCrit, otherCrit
			if CombatLogGetCurrentEventInfo then
				_, eventType, _, sourceGUID, _, _, _, destGUID, _, _, _, swingDamage, _, _, otherDamage, _, _, swingCrit, _, _, otherCrit = CombatLogGetCurrentEventInfo()
			elseif WowBuildInfo >= 40200 then
				_, eventType, _, sourceGUID, _, _, _, destGUID, _, _, _, swingDamage, _, _, otherDamage, _, _, swingCrit, _, _, otherCrit = ... 
			elseif WowBuildInfo >= 40100 then
				_, eventType, _, sourceGUID, _, _, destGUID, _, _, _, swingDamage, _, _, otherDamage, _, _, swingCrit, _, _, otherCrit = ...
			else
				_, eventType, sourceGUID, _, _, destGUID, _, _, _, swingDamage, _, _, otherDamage, _, _, swingCrit, _, _, otherCrit = ...
			end
			if (sourceGUID == UnitGUID("player")) and (destGUID == UnitGUID("target")) then
				if (BS_BloodBehaviour == 1) then
					for i = 0, GetComboPoints("player") - 1 do
						if (not BS_Textures[i]:IsVisible()) then
							BS_Textures[i]:Show()
							BS_Texture_OnShow(i, BS_MaximalScalingFactor)
						end
					end
				else
					local scale = BS_MaximalScalingFactor
					local dmg = 0
					if (BS_BloodBehaviour == 2) then
						if ((eventType == "SWING_DAMAGE") and swingCrit and (BS_DisplayOnWhiteCrits)) then
							BS_CritCount = BS_CritCount + 1
							dmg = swingDamage
						elseif ((eventType == "RANGE_DAMAGE") and otherCrit and (BS_DisplayOnWhiteCrits) and (not BS_EnableRangeCheck)) then
							BS_CritCount = BS_CritCount + 1
							dmg = otherDamage
						elseif ((eventType == "SPELL_DAMAGE") and otherCrit and ((not BS_EnableRangeCheck) or (BS_InRange()))) then
							BS_CritCount = BS_CritCount + 1
							dmg = otherDamage
						elseif ((eventType == "SPELL_PERIODIC_DAMAGE") and otherCrit and ((not BS_EnableRangeCheck) or (BS_InRange()))) then
							BS_CritCount = BS_CritCount + 1
							dmg = otherDamage
						end
						if ((BS_MeasurementActive) and (dmg ~= 0)) then
							BS_DamageMeasurement_Evaluate(dmg)
						end
						if (BS_DamageReference) then
							dmg = math.max(BS_DamageReference_LowerDamageLimit,dmg)
							scale = BS_MinimalScalingFactor + (BS_MaximalScalingFactor - BS_MinimalScalingFactor) * (dmg / BS_DamageReference_UpperDamageLimit)
						end
						for i = 0, math.min(BS_CritCount - 1, BS_MaximumTextures - 1) do
							if (not BS_Textures[i]:IsVisible()) then
								BS_Textures[i]:Show()
								BS_Texture_OnShow(i, scale)
							end
						end
					elseif (BS_BloodBehaviour == 3) then
						local CritMatchesConfig = false
						if ((eventType == "SWING_DAMAGE") and swingCrit and (BS_DisplayOnWhiteCrits)) then
							CritMatchesConfig = true
							dmg = swingDamage
						elseif ((eventType == "RANGE_DAMAGE") and otherCrit and (BS_DisplayOnWhiteCrits) and (not BS_EnableRangeCheck)) then
							CritMatchesConfig = true
							dmg = otherDamage
						elseif ((eventType == "SPELL_DAMAGE") and otherCrit and ((not BS_EnableRangeCheck) or (BS_InRange()))) then
							CritMatchesConfig = true
							dmg = otherDamage
						elseif ((eventType == "SPELL_PERIODIC_DAMAGE") and otherCrit and ((not BS_EnableRangeCheck) or (BS_InRange()))) then
							CritMatchesConfig = true
							dmg = otherDamage
						end
						if ((BS_MeasurementActive) and (dmg ~= 0)) then
							BS_DamageMeasurement_Evaluate(dmg)
						end
						if (BS_DamageReference) then
							dmg = math.max(BS_DamageReference_LowerDamageLimit,dmg)
							scale = BS_MinimalScalingFactor + (BS_MaximalScalingFactor - BS_MinimalScalingFactor) * (dmg / BS_DamageReference_UpperDamageLimit)
						end
						if (CritMatchesConfig) then
							BS_LastTextureShown = (BS_LastTextureShown + 1) % BS_MaximumTextures
							BS_Timers[BS_LastTextureShown] = time()
							BS_Textures[BS_LastTextureShown]:Show()
							BS_Texture_OnShow(BS_LastTextureShown, scale)
						end
					elseif (BS_BloodBehaviour == 4) then
						local CritMatchesConfig = false
						if ((eventType == "SWING_DAMAGE") and swingCrit and (BS_DisplayOnWhiteCrits)) then
							CritMatchesConfig = true
							dmg = swingDamage
						elseif ((eventType == "RANGE_DAMAGE") and otherCrit and (BS_DisplayOnWhiteCrits) and (not BS_EnableRangeCheck)) then
							CritMatchesConfig = true
							dmg = otherDamage
						elseif ((eventType == "SPELL_DAMAGE") and otherCrit and ((not BS_EnableRangeCheck) or (BS_InRange()))) then
							CritMatchesConfig = true
							dmg = otherDamage
						elseif ((eventType == "SPELL_PERIODIC_DAMAGE") and otherCrit and ((not BS_EnableRangeCheck) or (BS_InRange()))) then
							CritMatchesConfig = true
							dmg = otherDamage
						end
						if ((BS_MeasurementActive) and (dmg ~= 0)) then
							BS_DamageMeasurement_Evaluate(dmg)
						end
						if (BS_DamageReference) then
							dmg = math.max(BS_DamageReference_LowerDamageLimit,dmg)
							scale = BS_MinimalScalingFactor + (BS_MaximalScalingFactor - BS_MinimalScalingFactor) * (dmg / BS_DamageReference_UpperDamageLimit)
						end
						if (CritMatchesConfig) then
							BS_LastTextureShown = (BS_LastTextureShown + 1) % BS_MaximumTextures
							BS_GlobalTimer = time()
							BS_Textures[BS_LastTextureShown]:Show()
							BS_Texture_OnShow(BS_LastTextureShown, scale)
						end
					end
				end
			end
		end
	end
end

BS_EventFrame:SetScript("OnEvent", BS_OnEvent)

--This function is called, whenever the texture frame is updated. It determines, which textures have to be hidden.
function BS_Textures_OnUpdate()
	if (math.min(BS_TextureFrame:GetWidth(), BS_TextureFrame:GetHeight()) < 0) then
		BS_AjustTextureFrame()
	end
	if (not BS_ConfigFrameOpen) then
		if (BS_BloodBehaviour == 1) then
			for i = 0, BS_MaximumTextures - 1 do
				if ((i >= GetComboPoints("player")) and ((BS_Textures[i]:IsVisible()) and (BS_FadingIterator[i] <= 0))) then
					BS_FadingIterator[i] = 1
				end
			end
		elseif (BS_BloodBehaviour == 2) then
			if (UnitAffectingCombat("player") == nil) then
				for i = 0, BS_MaximumTextures - 1 do
					if ((BS_Textures[i]:IsVisible()) and (BS_FadingIterator[i] <= 0)) then
						BS_FadingIterator[i] = 1
					end
				end
			end
		elseif (BS_BloodBehaviour == 3) then
			for i = 0, BS_MaximumTextures - 1 do
				if ((BS_Timers[i] > 0) or (BS_Textures[i]:IsVisible())) then
					if ((BS_Timers[i] < time() - BS_Timer_RunTime) and (BS_FadingIterator[i] <= 0)) then
						BS_Timers[i] = 0
						BS_FadingIterator[i] = 1
					end
				end
			end
		elseif (BS_BloodBehaviour == 4) then
			if (BS_GlobalTimer > 0) then
				if (BS_GlobalTimer < time() - BS_Timer_RunTime) then
					BS_GlobalTimer = 0
					for i = 0, BS_MaximumTextures - 1 do
						BS_FadingIterator[i] = 1
					end
				end
			end
		end
		BS_Textures_Hide()
	end
end

--This function shows all actually used textures.
function BS_ShowAllTextures()
	for i = 0, BS_MaximumTextures - 1 do
		if (not BS_Textures[i]:IsVisible()) then
			BS_Textures[i]:Show()
			BS_Texture_OnShow(i, BS_MaximalScalingFactor)
		end
	end
end

--This function hides all shown textures and sets their timer to zero.
function BS_HideAllTextures()
	BS_GlobalTimer = 0
	BS_CritCount = 0
	for i = 0, BS_MaximumTextures - 1 do
		BS_FadingIterator[i] = 1
		BS_Timers[i] = 0
	end
end

--This function dynamically creates textures for later use.
function BS_CreateTextures()
	for i = 0, BS_MaximumTextures - 1 do
		if (BS_Textures[i] == nil) then
			BS_Textures[i] = BS_TextureFrame:CreateTexture("BS_Splatter"..i, "BACKGROUND")
			BS_Textures[i]:SetTexture(BS_TexturePath..((i % BS_NumberOfTextureFiles) + 1))
			BS_Textures[i]:SetWidth(266)
			BS_Textures[i]:SetHeight(266)
			BS_Textures[i]:SetBlendMode("MOD")
			BS_Textures[i]:Hide()
		end
		if (BS_Timers[i] == nil) then
			BS_Timers[i] = 0
		end
		if (BS_Alpha[i] == nil) then
			BS_Alpha[i] = 1
		end
		if (BS_FadingIterator[i] == nil) then
			BS_FadingIterator[i] = 0
		end
	end
end

--This function handles the display option of each texture, when it gets visible it rotates them randomly and sets their scaling.
function BS_Texture_OnShow(i, s)
	if (266 * s > math.min(BS_TextureFrame:GetWidth(), BS_TextureFrame:GetHeight())) then
		s = math.floor(math.min(BS_TextureFrame:GetWidth(), BS_TextureFrame:GetHeight()) / 26.6) / 10
	end
	if (s ~= 0) then
		BS_Alpha[i] = 1
		BS_Textures[i]:SetTexture(BS_TexturePath..((i % BS_NumberOfTextureFiles) + 1).."_"..BS_Alpha[i])
		BS_Textures[i]:SetRotation(math.rad(random(360)))
		BS_Textures[i]:ClearAllPoints()
		BS_Textures[i]:SetWidth(266 * s)
		BS_Textures[i]:SetHeight(266 * s)
		local width = BS_TextureFrame:GetWidth() - BS_Textures[i]:GetWidth()
		local height = BS_TextureFrame:GetHeight() - BS_Textures[i]:GetHeight()
		if (width == 0) then
			width = 1
		end 
		if (height == 0) then
			height = 1
		end
		BS_Textures[i]:SetPoint("CENTER", BS_TextureFrame, "CENTER", random(width) - (width / 2), random(height) - (height / 2))
	else
		print("|cff0000ffBloodyScreen: |cffff0000"..BS_String_Error_TextureFrameSize.."|r")
	end
end

--This function handles the fading of the vanishing textures.
function BS_Textures_Hide()
	for i = 0, BS_MaximumTextures - 1 do
		if ((BS_FadingIterator[i] > 0) and (BS_Textures[i]:IsVisible())) then
			BS_FadingIterator[i] = BS_FadingIterator[i] + 1
			local miniteratorvalue = (BS_FadingTime * GetFramerate()) / 10
			if (BS_FadingIterator[i] > miniteratorvalue) then
				BS_FadingIterator[i] = BS_FadingIterator[i] - math.floor(miniteratorvalue)
				BS_Texture_ChangeAlpha(i)
			end
		end
	end
end

--This function reduces the alpha value of the given texture by 10%.
function BS_Texture_ChangeAlpha(i)
	BS_Alpha[i] = BS_Alpha[i] + 1
	if (BS_Alpha[i] > 10) then
		BS_Timers[i] = 0
		BS_FadingIterator[i] = 0
		BS_Textures[i]:Hide()
		if (BS_CritCount > 0) then
			BS_CritCount = 0
		end
	else
		BS_Textures[i]:SetTexture(BS_TexturePath..((i % BS_NumberOfTextureFiles) + 1).."_"..BS_Alpha[i])
	end
end

--This function is used by the damage measurement option.
function BS_DamageMeasurement_Evaluate(dmg)
	BS_DamageMeasurement_AverageDamage = BS_DamageMeasurement_AverageDamage * BS_DamageMeasurement_HitsCounted + dmg
	BS_DamageMeasurement_HitsCounted = BS_DamageMeasurement_HitsCounted + 1
	BS_DamageMeasurement_AverageDamage = BS_DamageMeasurement_AverageDamage / BS_DamageMeasurement_HitsCounted
	BS_DamageMeasurement_MaximalDamage = math.max(BS_DamageMeasurement_MaximalDamage, dmg)
	if (BS_DamageMeasurement_HitsCounted >= BS_DamageMeasurement_NumberOfHits) then
		BS_MeasurementActive = false
		BS_DamageReference_UpperDamageLimit = BS_DamageMeasurement_MaximalDamage
		BS_DamageReference_AverageDamage = BS_DamageMeasurement_AverageDamage
		BS_EvaluateDamageData()
		print("|cff0000ffBloodyScreen: |cff00ff00"..BS_String_Notification_MeasurementFinished.."|r")
	end
end

--This function checks if the target is in combat range. It returns true if the target is in range or a check isn't possible.
function BS_InRange()
	local _, class = UnitClass("player")
	if (BS_RangeCheckAction[class] > 0) then
		local spellname = GetSpellInfo(BS_RangeCheckAction[class])
		if (IsSpellInRange(spellname, "target") == 0) then
			return false
		end
	end
	return true
end
