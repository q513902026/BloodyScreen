--Version Info / Texture files.
BS_Version = " 1.13.2"
BS_TexturePath = "Interface\\AddOns\\BloodyScreen\\Textures\\Splatter"
BS_NumberOfTextureFiles = 5

--Unconfigurable variables used by BloodyScreen
BS_DamageMeasurement_NumberOfHits = 100
BS_DamageMeasurement_HitsCounted = 0
BS_DamageMeasurement_AverageDamage = 0
BS_DamageMeasurement_MaximalDamage = 0
BS_CritCount = 0
BS_GlobalTimer = 0
BS_Timers = { }
BS_Textures = { }
BS_Alpha = { }
BS_FadingIterator = { }
BS_FadingTime = 0.5
BS_LastTextureShown = - 1
BS_ConfigFrameOpen = false
BS_MeasurementActive = false

--Actions for the range check option.
BS_RangeCheckAction = {
	["DEATHKNIGHT"] = 45902,
	["DRUID"] = 779,
	["HUNTER"] = 2973,
	["MAGE"] = -1,				--Mages have no adequate spells.
	["PALADIN"] = 20271,
	["PRIEST"] = -1,			--Priests neither.
	["ROGUE"] = 1776,
	["SHAMAN"] = 32175,			--On shamans, the range check only works, if stormstrike is skilled.
	["WARLOCK"] = -1,			--Same as mages and priests.
	["WARRIOR"] = 772
}

--Variables which can be changed through the config menu (Set for first run after installation only).
BS_BloodBehaviour = 2
BS_MaximumTextures = 10
BS_Timer_RunTime = 10
BS_DisplayOnWhiteCrits = true
BS_MaximalScalingFactor = 1
BS_MinimalScalingFactor = 1
BS_EnableOnPVP = true
BS_EnableOnPVE = true
BS_EnableRangeCheck = false
BS_DamageReference = false
BS_DamageReference_UpperDamageLimit = 50000
BS_DamageReference_LowerDamageLimit = 0
BS_DamageReference_AverageDamage = 25000