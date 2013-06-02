--[=[
	Please Note:
	It's great that you want to improve/extend the localisation of this mod, 
	but you have to get straight that this file, for the sake of special characters, is coded in UTF-8.
	So please, if you don't find any mutated vowels in the following test line, please open this file with a text editor that
	is capable of understanding UTF-8 code.
	
	Test line: ÄäÖöÜü
	
	If you don't have a text editor that understands UTF, I personally would advice you to get Notepad++ from the following address:
	notepad-plus.sourceforge.net
]=]--

--English localisation

BS_String_General = "General";
BS_String_Scaling = "Scaling";
BS_String_DrawingArea = "Drawing area";
BS_String_SaveSettings = "Save settings";
BS_String_Exit = "Quit";

BS_String_General_Title = "General settings";
BS_String_General_Trigger = "Set the trigger to display the splatters:";
BS_String_General_ComboPoints = "Display splatters on combo points gain.";
BS_String_General_Criticals = "Display splatters on critical hits.";
BS_String_General_Criticals_Swipes = "Also display splatters on critical swipes (\"white damage\").";
BS_String_General_Criticals_NoTimers = "Hide the splatters after the end of combat.";
BS_String_General_Criticals_Timers = "Hide the splatters after a certain time.";
BS_String_General_Criticals_Timers_Settings = "Settings";
BS_String_General_Criticals_DamageReference = "Scale the splatters depending on the damage done.";
BS_String_General_Criticals_DamageReference_Settings = "Settings";
BS_String_General_Criticals_RangeCheck = "Only show splatters on hits that are done in combat range.";
BS_String_General_NumberOfTextures = "Maximal number of splatters on the screen: ";
BS_String_General_PVP = "Enable BloodyScreen in PVP.";
BS_String_General_PVE = "Enable BloodyScreen in PVE.";

BS_String_Timers_Title = "Timer settings";
BS_String_Timers_Runtime = "Hide the splatters after: ";
BS_String_Timers_Runtime_Unit = "Seconds.";
BS_String_Timers_GlobalTimer = "Use the same timer for every splatter.";
BS_String_Timers_Separated = "Use separated timers.";

BS_String_Scaling_Title = "Splatter size";
BS_String_Scaling_Size = "Splatter size";
BS_String_Scaling_MaximalSize = "Maximal splatter size";
BS_String_Scaling_MinimalSize = "Minimal splatter size";

BS_String_DrawingArea_Title = "Ajust drawing area";
BS_String_DrawingArea_Instruction = "You can ajust the drawing area by moving the corners of this frame.";

BS_String_DamageReference_Title = "Damage reference settings";
BS_String_DamageReference_MaximalValue = "Damage needed for maximal splatter size: ";
BS_String_DamageReference_AverageValue = "Average Damage of your critical hits: ";
BS_String_DamageReference_DamageMeasurement = "Start an automated damage measurement over "..BS_DamageMeasurement_NumberOfHits.." hits:";
BS_String_DamageReference_DamageMeasurement_Start = "Start";
BS_String_DamageReference_AjustScalingSettings = "Please remember to ajust your scaling settings!";
BS_String_DamageReference_AjustScalingSettings_Settings = "Scaling";

BS_String_Notification_MeasurementRunning = "A damage measurement has been started! Please proceed with normal combat.";
BS_String_Notification_MeasurementFinished = "The damage measurement has been finished. The determined values are now used.";

BS_String_Notification_RangeCheckCanNotBePerformed = "It's not possible to perform a combat range check on this character! The splatters will be shown on every crit.";

BS_String_Notification_RangeCheckCanNotBePerformed = "The default settings have been restored.";

BS_String_Error_TextureFrameSize = "ERROR: Your draw area is way to small! Enlarge it! To do so, type /bs into the chat.";

if ( GetLocale() == "deDE" ) then

--German localisation

BS_String_General = "Allgemein";
BS_String_Scaling = "Grösse";
BS_String_DrawingArea = "Zeichenbereich";
BS_String_SaveSettings = "Speichern";
BS_String_Exit = "Schliessen";

BS_String_General_Title = "Allgemein";
BS_String_General_Trigger = "Bitte wählen sie den Auslöser für die Blutflecken:";
BS_String_General_ComboPoints = "Zeige das Blut nach Combopunkten an.";
BS_String_General_Criticals = "Zeige das Blut bei kritischen Schlägen an.";
BS_String_General_Criticals_Swipes = "Zeige das Blut auch bei kritischen Autoschlägen an (\"weisser Schaden\").";
BS_String_General_Criticals_NoTimers = "Verstecke das Blut nach dem Kampf.";
BS_String_General_Criticals_Timers = "Verstecke das Blut nach einer bestimmten Zeit.";
BS_String_General_Criticals_Timers_Settings = "Erweitert";
BS_String_General_Criticals_DamageReference = "Variiere die Fleckengrösse mit dem verursachten Schaden.";
BS_String_General_Criticals_DamageReference_Settings = "Erweitert";
BS_String_General_Criticals_RangeCheck = "Zeige die Blutflecken nur bei Schlägen in Nahkampfreichweite.";
BS_String_General_NumberOfTextures = "Maximale Anzahl Blutflecken auf dem Bildschirm: ";
BS_String_General_PVP = "Verwende BloodyScreen im PVP.";
BS_String_General_PVE = "Verwende BloodyScreen im PVE.";

BS_String_Timers_Title = "Timer";
BS_String_Timers_Runtime = "Verstecke das Blut nach: ";
BS_String_Timers_Runtime_Unit = " Sekunden.";
BS_String_Timers_GlobalTimer = "Verwende den selben Timer für alle Flecken.";
BS_String_Timers_Separated = "Verwende separate Timer.";

BS_String_Scaling_Title = "Grösse";
BS_String_Scaling_Size = "Grösse der Flecken";
BS_String_Scaling_MaximalSize = "Maximale Grösse der Flecken";
BS_String_Scaling_MinimalSize = "Minimale Grösse der Flecken";

BS_String_DrawingArea_Title = "Zeichenbereich";
BS_String_DrawingArea_Instruction = "Bitte passen sie den Zeichenbereich durch ziehen der beiden Ecken dieses Fensters an.";


BS_String_DamageReference_Title = "Schadensabhängige Grösse";
BS_String_DamageReference_MaximalValue = "Schaden für maximale Grösse: ";
BS_String_DamageReference_AverageValue = "Durchschnittsschaden der kritischen Schläge: ";
BS_String_DamageReference_DamageMeasurement = "Starte eine automatische Messung über "..BS_DamageMeasurement_NumberOfHits.." Schläge:";
BS_String_DamageReference_DamageMeasurement_Start = "Start";
BS_String_DamageReference_AjustScalingSettings = "Bitte prüfen Sie die Grösseneinstellungen!";
BS_String_DamageReference_AjustScalingSettings_Settings = "Grösse";

BS_String_Notification_MeasurementRunning = "Es wurde eine Schadensmessung gestartet! Bitte fahren sie mit einem normalen Kampf fort.";
BS_String_Notification_MeasurementFinished = "Die Schadensmessung wurde abgeschlossen. Die ermittelten Werte werden nun benutzt.";

BS_String_Notification_RangeCheckCanNotBePerformed = "Mit diesem Charakter ist es leider nicht möglich, die Nahkampfreichweite zu überprüfen. Die Blutflecken werden bei jedem kritischen Treffer angezeigt.";

BS_String_Notification_RangeCheckCanNotBePerformed = "Die Einstellungen wurden zurückgesetzt.";

BS_String_Error_TextureFrameSize = "FEHLER: Der von Ihnen definierte Zeichenbereich ist zu klein! Bitte ändern sie dies, indem sie /bs in den Chat eintippen und die Einstellungen überarbeiten.";
end

if ( GetLocale() == "zhCN" ) then

--Simplified Chinese localisation
--Translation made by xingdvd ( http://my.curse.com/members/xingdvd.aspx )

BS_String_General = "常规";
BS_String_Scaling = "缩放";
BS_String_DrawingArea = "界面";
BS_String_SaveSettings = "保存设置";
BS_String_Exit = "退出";

BS_String_General_Title = "常规设置";
BS_String_General_Trigger = "设置显示血溅效果的触发方式：";
BS_String_General_ComboPoints = "获得连击点时，显示血溅效果。";
BS_String_General_Criticals = "伤害爆击时，显示血溅效果。";
BS_String_General_Criticals_Swipes = "普通攻击爆击时，显示血溅效果。";
BS_String_General_Criticals_NoTimers = "在战斗结束后隐藏血溅效果。";
BS_String_General_Criticals_Timers = "在特定时间后隐藏血溅效果。";
BS_String_General_Criticals_Timers_Settings = "设置";
BS_String_General_Criticals_DamageReference = "根据造成的伤害值大小，决定血溅效果显示的尺寸。";
BS_String_General_Criticals_DamageReference_Settings = "设置";
BS_String_General_Criticals_RangeCheck = "AOE 爆击时，显示血溅效果。";
BS_String_General_NumberOfTextures = "血溅效果显示的最大数: ";
BS_String_General_PVP = "PVP 状态开启 BloodyScreen 。";
BS_String_General_PVE = "PVE 状态开启 BloodyScreen 。";

BS_String_Timers_Title = "时间设置";
BS_String_Timers_Runtime = "血溅效果持续时间: ";
BS_String_Timers_Runtime_Unit = " 秒。";
BS_String_Timers_GlobalTimer = "每种血溅效果使用相同时间设定。";
BS_String_Timers_Separated = "每种血溅效果使用独立时间设定。";

BS_String_Scaling_Title = "血溅效果显示尺寸";
BS_String_Scaling_Size = "血溅效果显示尺寸";
BS_String_Scaling_MaximalSize = "最大尺寸";
BS_String_Scaling_MinimalSize = "最小尺寸";

BS_String_DrawingArea_Title = "调整显示区域";
BS_String_DrawingArea_Instruction = "拖曳框体角落的白点以调整血溅效果显示区域。";

BS_String_DamageReference_Title = "伤害基准设置";
BS_String_DamageReference_MaximalValue = "显示血溅效果最大尺寸的伤害值: ";
BS_String_DamageReference_AverageValue = "爆击伤害平均值: ";
BS_String_DamageReference_DamageMeasurement = "当超过 "..BS_DamageMeasurement_NumberOfHits.." 次攻击时，开启自动伤害测定。";
BS_String_DamageReference_DamageMeasurement_Start = "开始";
BS_String_DamageReference_AjustScalingSettings = "请及时调整缩放设置!";
BS_String_DamageReference_AjustScalingSettings_Settings = "缩放";

BS_String_Notification_MeasurementRunning = "伤害测定已开启！去参加战斗吧！";
BS_String_Notification_MeasurementFinished = "伤害测定已结束。测定值已在使用。";

BS_String_Notification_RangeCheckCanNotBePerformed = "该角色无法使用 AOE 爆击血溅效果！";

BS_String_Error_TextureFrameSize = "错误: 血溅效果显示区域太小！请输入 /bs 调整显示区域。";
end
