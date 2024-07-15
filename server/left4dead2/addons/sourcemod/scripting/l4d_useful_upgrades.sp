#pragma newdecls required
#pragma semicolon 1

#include <sourcemod>
#include <sdktools>
#include <sdkhooks>
#include <clientprefs>
#undef REQUIRE_PLUGIN
#tryinclude <vip_core>

#define DEBUG 0
#define VIP_FEATURE_NAME_LASER			"UPGRADE_LASER"
#define VIP_FEATURE_NAME_SILENCER		"UPGRADE_SILENCER"
#define VIP_FEATURE_NAME_NIGHTVISION	"UPGRADE_NIGHTVISION"
#define VIP_FEATURE_NAME_RELOAD			"UPGRADE_FASTRELOAD"
#define FIX_RARE_BUG_METHOD 0

enum
{
	LASER_BIT = 			0x20000,
	SILENCER_BIT = 			0x40000,
	NIGHT_BIT = 			0x400000,
	RELOAD_BIT = 			0x20000000,
	L4D2_WEPUPGFLAG_LASER = 0x4
}

#define PLUGIN_VERSION "1.7.7"

/*
Fork by Dragokas

1.7.7 (07-Nov-2022)
 - Removed binds.
 - Fixed compilation warnings on SM 1.11.

1.7.6 (22-Nov-2021)
 - Fixed ConVar error in L4D2.

1.7.5 (21-Nov-2021)
 - Integration with VIP Core (by R1KO).

1.7.4 (16-Jun-2021)
 - Updated gamedata for L4D2 2.2.1.3.

1.7.3 (01-Jun-2021)
 - Added ConVar "l4d_upgrades_remove_dropped_laser" - to auto switch off laser on the dropped weapon (L4D2 only).

1.7.2 (04-Oct-2020)
 - Improved compatibility with L4D2.

1.7.1 (19-Jul-2020)
 - Added protection preventing the plugin from throwing an error when listen servers pass an incorrect client index in response to a command.

1.7 (05-May-2020)
 - Prevented award sound from playing while you switch on the laser (memory patch method). Thanks for help to SilverShot and Krivous Anatolii (The Trick).
 - Added GameData file.
 - Updated Windows signatures.
 - Added natives and helper functions (inc):
	* UU_GetUpgrades
	* UU_SetUpgrades
	* UU_AddUpgrade
	* UU_RemoveUpgrade
(usage sample is available in 1-st post under the spoiler).
 - code simplifications.
 - added basic L4D2 support (only laser and night vision).

// TODO: disable annoing instructor hints in L4d2.

1.6.4 (18-Dec-2019)
 - Added forward OnUpgradeChanged(int iClient, int iUpgrade). Upgrade values are identical to enum: use bitwise operators to check for upgrade, e.g.: iUpgrade & LASER_BIT

1.6.3 (16-Dec-2019)
 - Some ConVars removed and splitted to a new one:
 
Always force specific update on spawn:
 
* l4d_force_spawn_silencer
* l4d_force_spawn_laser_sight
* l4d_force_spawn_night_vision
* l4d_force_spawn_fast_reload

Force update only when unique player joined the server first time:
 
* l4d_force_join_silencer
* l4d_force_join_laser_sight
* l4d_force_join_night_vision
* l4d_force_join_fast_reload

It is often new players asked me to see laser, in the same time they still should have ability
to disable it. Now, they can have desired behavior.

Please, remove your cfg/sourcemod/l4d_useful_upgrades.cfg file.

1.6.2 (10-Apr-2019)
 - Fixed "Entity is invalid" in SaveCookie().

1.6.1 (23-Mar-2019)
 - Removed FakeClient check when we reset upgrades (for safe). Thanks to AlexMy.
 - Added "Bot Replace Player" and "Player Disconnect" events to reset upgrades (for safe). Thanks to SilverShot.

1.6 (15-Mar-2019)
 - Added laser to the list of upgrades to be reset on round end (if not, it's possibly could cause server crash sometimes).

1.5 (07-Mar-2019)
 - Added additional delay before activation the laser because sometimes player's netprops have no time to init.

1.4 (01-Mar-2019)
 - Converted to a new syntax and methodmaps
 - Added sdk method to enable laser
 - Added more reliable managing the cookies
 - Added "l4d_useful_upgrades" config file.
 - Added "l4d_force_silencer" ConVar to force Silencer Upgrade on spawn
 - Added "l4d_force_laser_sight" ConVar to force Laser Sight Upgrade on spawn
 - Added "l4d_force_night_vision" ConVar to force Night Vision Upgrade on spawn
 - Added "l4d_force_fast_reload" ConVar to force Fast Reload Upgrade on spawn
 - Added checking for game requirements (L4D1 only).

1.3 (private)
 - Removed laser, because it crash my server

1.2 (based on alternate fork branch)
 - Added saving upgrades state to the cookies
 - Added some safe checkings

============================================================================

Credits:

 - Figa - original author
 - Whosat - for SDK-method of laser activation
 - AlexMy - helping with crash fix
 - SilverShot - helping with crash fix and for patch example
 - Krivous Anatolii (The Trick) - resolving Windows crash in NOP patch
 - dcx2 - for dropped weapon upgrade manipulation code

*/

public Plugin myinfo =
{
	name = "[L4D] Useful Upgrades",
	description = "Include 4 useful upgrades Laser Sight, Silencer, Night Vision and Fast Reload",
	author = "Figa (Fork by Dragokas)",
	version = PLUGIN_VERSION,
	url = "https://forums.alliedmods.net/showthread.php?t=314305"
};

ConVar g_ConVarSilencerEnable;
ConVar g_ConVarLaserEnable;
ConVar g_ConVarNightVisionEnable;
ConVar g_ConVarFastReloadEnable;

ConVar g_ConVarSilencerForce_Spawn;
ConVar g_ConVarLaserForce_Spawn;
ConVar g_ConVarNightVisionForce_Spawn;
ConVar g_ConVarReloadForce_Spawn;

ConVar g_ConVarSilencerForce_Join;
ConVar g_ConVarLaserForce_Join;
ConVar g_ConVarNightVisionForce_Join;
ConVar g_ConVarReloadForce_Join;

ConVar g_ConVarLaserVipOnly;
ConVar g_ConVarNightVisionVipOnly;
ConVar g_ConVarSilencerVipOnly;
ConVar g_ConVarReloadVipOnly;

ConVar g_ConVarRemoveLaserDropped;

ConVar g_ConVarSurvivorUpgrades;

Handle g_hCookie = INVALID_HANDLE;
Handle sdkAddUpgrade = INVALID_HANDLE;
Handle sdkRemoveUpgrade = INVALID_HANDLE;

int g_cl_upgrades[MAXPLAYERS+1];
bool g_bLaserEnabled[MAXPLAYERS + 1];
bool g_bLeft4dead2;
bool g_Proto;
bool g_bLockForward;
bool g_bLateload;
bool g_bRoundStart;
bool g_bVipAvail;
bool g_bVipFeatureEnabled_Laser[MAXPLAYERS+1];
bool g_bVipFeatureEnabled_Silencer[MAXPLAYERS+1];
bool g_bVipFeatureEnabled_NightVision[MAXPLAYERS+1];
bool g_bVipFeatureEnabled_Reload[MAXPLAYERS+1];

Handle g_UpgradeChanged;

ArrayList g_ByteSaved_Sound;
Address g_Address_Sound;

public APLRes AskPluginLoad2(Handle myself, bool late, char[] error, int err_max)
{
	EngineVersion test = GetEngineVersion();
	if( test != Engine_Left4Dead && test != Engine_Left4Dead2 )
	{
		strcopy(error, err_max, "Plugin only supports Left 4 Dead 1 & 2.");
		return APLRes_SilentFailure;
	}
	
	g_bLeft4dead2 = (test == Engine_Left4Dead2 );
	g_bLateload = late;
	CreateNative("UU_SetUpgrades", NATIVE_SetUpgrades);
	CreateNative("UU_GetUpgrades", NATIVE_GetUpgrades);
	return APLRes_Success;
}

public void OnPluginStart()
{
	LoadTranslations("l4d_luu.phrases");
	
	CreateConVar("l4d_useful_upgrades_version", PLUGIN_VERSION, "Plugin version", FCVAR_DONTRECORD | FCVAR_NOTIFY | FCVAR_SPONLY);

	g_UpgradeChanged = CreateGlobalForward("OnUpgradeChanged", ET_Ignore, Param_Cell, Param_Cell);

	HookEvent("player_death", 			Event_PlayerDeath);
	HookEvent("player_spawn", 			Event_PlayerSpawn);
	HookEvent("round_end", 				Event_RoundEnd, EventHookMode_Pre);
	HookEvent("map_transition", 		Event_RoundEnd, EventHookMode_Pre);
	HookEvent("player_bot_replace", 	Event_PlayerBotReplace, EventHookMode_Pre);
	HookEvent("player_disconnect", 		Event_PlayerDisconnect, EventHookMode_Pre);
	
	if( g_bLeft4dead2 )
	{
		HookEvent("round_start", 		Event_RoundStart, EventHookMode_PostNoCopy);
		HookEvent("weapon_drop", 		Event_WeaponDrop);
	}
	
	RegConsoleCmd("sm_laser", CmdLaser, "Toggle Laser Sight");
	RegConsoleCmd("sm_laseron", CmdLaser, "Turn on the laser");
	RegConsoleCmd("sm_laseroff", CmdLaser, "Turn off the laser");
	
	RegConsoleCmd("sm_night", CmdNightVision, "Toggle Night Vision");
	
	if( !g_bLeft4dead2 )
	{
		RegConsoleCmd("sm_silent", CmdSilencer, "Toggle Silencer");
		RegConsoleCmd("sm_silencer", CmdSilencer, "Toggle Silencer");
		
		RegConsoleCmd("sm_reload", CmdFastReload, "Toggle Fast Reload");
	}

	g_ConVarLaserEnable = CreateConVar( "l4d_enable_laser_sight", "1", "1 - Enable Toggle Laser Sight Upgrade; 0 - Disable This Upgrade", FCVAR_NOTIFY);
	g_ConVarLaserForce_Spawn = CreateConVar( "l4d_force_spawn_laser_sight", "0", "Force Laser Sight Upgrade on spawn (0 - No, 1 - Yes)", FCVAR_NOTIFY);
	g_ConVarLaserForce_Join = CreateConVar( "l4d_force_join_laser_sight", "1", "Force Laser Sight Upgrade on first join (0 - No, 1 - Yes)", FCVAR_NOTIFY);
	g_ConVarLaserVipOnly = CreateConVar( "l4d_laser_viponly", "1", "Laser Sight can use VIP players only? (0 - No, 1 - Yes)", FCVAR_NOTIFY);
	
	g_ConVarNightVisionEnable = CreateConVar( "l4d_enable_night_vision", "1", "1 - Enable Toggle Night Vision Upgrade; 0 - Disable This Upgrade", FCVAR_NOTIFY);
	g_ConVarNightVisionForce_Spawn = CreateConVar( "l4d_force_spawn_night_vision", "0", "Force Night Vision Upgrade on spawn (0 - No, 1 - Yes)", FCVAR_NOTIFY);
	g_ConVarNightVisionForce_Join = CreateConVar( "l4d_force_join_night_vision", "0", "Force Night Vision Upgrade on first join (0 - No, 1 - Yes)", FCVAR_NOTIFY);
	g_ConVarNightVisionVipOnly = CreateConVar( "l4d_night_vision_viponly", "1", "Night Vision can use VIP players only? (0 - No, 1 - Yes)", FCVAR_NOTIFY);
	
	if( g_bLeft4dead2 )
	{
		g_ConVarRemoveLaserDropped = CreateConVar( "l4d_upgrades_remove_dropped_laser", "1", "Auto switch off laser on the dropped weapon (0 - No, 1 - Yes)", FCVAR_NOTIFY);
	}
	else
	{
		g_ConVarSilencerEnable = CreateConVar( "l4d_enable_silencer", "1", "1 - Enable Toggle Silencer Upgrade; 0 - Disable This Upgrade", FCVAR_NOTIFY);
		g_ConVarSilencerForce_Spawn = CreateConVar( "l4d_force_spawn_silencer", "0", "Force Silencer Upgrade on spawn (0 - No, 1 - Yes)", FCVAR_NOTIFY);
		g_ConVarSilencerForce_Join = CreateConVar( "l4d_force_join_silencer", "1", "Force Silencer Upgrade on first join (0 - No, 1 - Yes)", FCVAR_NOTIFY);
		g_ConVarSilencerVipOnly = CreateConVar( "l4d_silencer_viponly", "1", "Silencer Upgrade can use VIP players only? (0 - No, 1 - Yes)", FCVAR_NOTIFY);
		
		g_ConVarFastReloadEnable = CreateConVar( "l4d_enable_fast_reload", "1", "1 - Enable Toggle Fast Reload Upgrade; 0 - Disable This Upgrade", FCVAR_NOTIFY);
		g_ConVarReloadForce_Spawn = CreateConVar( "l4d_force_spawn_fast_reload", "1", "Force Fast Reload Upgrade on spawn (0 - No, 1 - Yes)", FCVAR_NOTIFY);
		g_ConVarReloadForce_Join = CreateConVar( "l4d_force_join_fast_reload", "1", "Force Fast Reload Upgrade on first join (0 - No, 1 - Yes)", FCVAR_NOTIFY);
		g_ConVarReloadVipOnly = CreateConVar( "l4d_fast_reload_viponly", "1", "Fast Reload can use VIP players only? (0 - No, 1 - Yes)", FCVAR_NOTIFY);
	}

	AutoExecConfig(true, "l4d_useful_upgrades");
	
	if( !g_bLeft4dead2 )
	{
		g_ConVarSurvivorUpgrades = FindConVar("survivor_upgrades");
	}
	
	g_Proto = CanTestFeatures() && GetFeatureStatus(FeatureType_Native, "GetUserMessageType") == FeatureStatus_Available && GetUserMessageType() == UM_Protobuf;
	HookUserMessage(GetUserMessageId("SayText"), SayTextHook, true);
	
	g_hCookie = RegClientCookie("cookie_useful_upgrades", "0", CookieAccess_Private);
	
	ReloadSDK();
	
	if( g_bLateload && g_bLeft4dead2 )
	{
		g_bRoundStart = true;
	
		for( int i = 1; i <= MaxClients; i++ )
		{
			if( IsClientInGame(i) && !IsFakeClient(i) )
			{
				SetSDKHooks(i);
			}
		}
	}
	
	AddCommandListener(CmdReloadConfig, "sm_reload_vip_cfg");
	
	if( LibraryExists("vip_core") )
	{
		g_bVipAvail = true;
	}
	
	if( g_bVipAvail )
	{
		#if defined _vip_core_included
		if( VIP_IsVIPLoaded() )
		{
			VIP_OnVIPLoaded();
		}
		#endif
	}
}

public void OnLibraryAdded(const char[] name)
{
	if( strcmp(name, "vip_core") == 0 )
	{
		g_bVipAvail = true;
	}
}

public void OnLibraryRemoved(const char[] name)
{
	if( strcmp(name, "vip_core") == 0 )
	{
		g_bVipAvail = false;
	}
}

public void OnPluginEnd()
{
	PatchAddress(false);

	#if defined _vip_core_included
	if( CanTestFeatures() && GetFeatureStatus(FeatureType_Native, "VIP_UnregisterFeature") == FeatureStatus_Available )
	{
		if( VIP_IsValidFeature(VIP_FEATURE_NAME_LASER) )
		{
			VIP_UnregisterFeature(VIP_FEATURE_NAME_LASER);
		}
		if( VIP_IsValidFeature(VIP_FEATURE_NAME_SILENCER) )
		{
			VIP_UnregisterFeature(VIP_FEATURE_NAME_SILENCER);
		}
		if( VIP_IsValidFeature(VIP_FEATURE_NAME_NIGHTVISION) )
		{
			VIP_UnregisterFeature(VIP_FEATURE_NAME_NIGHTVISION);
		}
		if( VIP_IsValidFeature(VIP_FEATURE_NAME_RELOAD) )
		{
			VIP_UnregisterFeature(VIP_FEATURE_NAME_RELOAD);
		}
	}
	#endif
}

public void VIP_OnFeatureRegistered(const char[] szFeature)
{
	if( g_bLateload && 
		strcmp(szFeature, VIP_FEATURE_NAME_LASER) == 0 || 
		strcmp(szFeature, VIP_FEATURE_NAME_SILENCER) == 0 || 
		strcmp(szFeature, VIP_FEATURE_NAME_NIGHTVISION) == 0 || 
		strcmp(szFeature, VIP_FEATURE_NAME_RELOAD) == 0 )
	{
		for( int i = 1; i <= MaxClients; i++ )
		{
			if( IsClientInGame(i) )
			{
				UpdatePlayerFeatureVIP(i);
			}
		}
	}
}

public Action CmdReloadConfig(int client, const char[] sCommand, int iArg)
{
	ConVar cvar = FindConVar("sm_vip_admin_flag");
	if( cvar )
	{
		char flags[32];
		cvar.GetString(flags, sizeof(flags));
		if( GetUserFlagBits(client) & ReadFlagString(flags) == 0 )
			return Plugin_Continue;
	}
	CreateTimer(1.0, Timer_ReloadConfig);
	return Plugin_Continue;
}

public Action Timer_ReloadConfig(Handle timer)
{
	for( int i = 1; i <= MaxClients; i++ )
	{
		if( IsClientInGame(i) && !IsFakeClient(i) )
		{
			UpdatePlayerFeatureVIP(i);
		}
	}
	return Plugin_Continue;
}

public void VIP_OnVIPClientLoaded(int client)
{
	UpdatePlayerFeatureVIP(client);
}

void UpdatePlayerFeatureVIP(int client)
{
	#if defined _vip_core_included
	if( g_bVipAvail )
	{
		if( VIP_IsClientVIP(client) )
		{
			g_bVipFeatureEnabled_Laser[client] = VIP_IsClientFeatureUse(client, VIP_FEATURE_NAME_LASER);
			g_bVipFeatureEnabled_NightVision[client] = VIP_IsClientFeatureUse(client, VIP_FEATURE_NAME_NIGHTVISION);
			
			if( !g_bLeft4dead2 )
			{
				g_bVipFeatureEnabled_Silencer[client] = VIP_IsClientFeatureUse(client, VIP_FEATURE_NAME_SILENCER);
				g_bVipFeatureEnabled_Reload[client] = VIP_IsClientFeatureUse(client, VIP_FEATURE_NAME_RELOAD);
			}
		}
		else {
			g_bVipFeatureEnabled_Laser[client] = false;
			g_bVipFeatureEnabled_Silencer[client] = false;
			g_bVipFeatureEnabled_NightVision[client] = false;
			g_bVipFeatureEnabled_Reload[client] = false;
		}
	}
	#else
		#pragma unused client
	#endif
}

#if defined _vip_core_included
public void VIP_OnVIPLoaded()
{
	if( !VIP_IsValidFeature(VIP_FEATURE_NAME_LASER) )
	{
		VIP_RegisterFeature(VIP_FEATURE_NAME_LASER, 		BOOL, 	_, 		OnToggleItemCallback_Laser, 		OnDisplayItem_Vip_Feature_Laser);
		VIP_RegisterFeature(VIP_FEATURE_NAME_NIGHTVISION, 	BOOL, 	_, 		OnToggleItemCallback_NightVision, 	OnDisplayItem_Vip_Feature_NightVision);
		
		if( !g_bLeft4dead2 )
		{
			VIP_RegisterFeature(VIP_FEATURE_NAME_SILENCER, 		BOOL, 	_, 		OnToggleItemCallback_Silencer, 		OnDisplayItem_Vip_Feature_Silencer);
			VIP_RegisterFeature(VIP_FEATURE_NAME_RELOAD, 		BOOL, 	_, 		OnToggleItemCallback_Reload, 		OnDisplayItem_Vip_Feature_Reload);
		}
	}
}

public Action OnToggleItemCallback_Laser(int client, const char[] sFeatureName, VIP_ToggleState OldStatus, VIP_ToggleState &NewStatus)
{
	g_bVipFeatureEnabled_Laser[client] = (NewStatus == ENABLED);
	return Plugin_Continue;
}
public bool OnDisplayItem_Vip_Feature_Laser(int client, const char[] sFeatureName, char[] sDisplay, int maxlen)
{
	FormatEx(sDisplay, maxlen, "%T [%T]", "VIP_Feature_Laser", client, VIP_IsClientFeatureUse(client, VIP_FEATURE_NAME_LASER) ? "Enabled": "Disabled", client);
	return true;
}

public Action OnToggleItemCallback_Silencer(int client, const char[] sFeatureName, VIP_ToggleState OldStatus, VIP_ToggleState &NewStatus)
{
	g_bVipFeatureEnabled_Silencer[client] = (NewStatus == ENABLED);
	return Plugin_Continue;
}
public bool OnDisplayItem_Vip_Feature_Silencer(int client, const char[] sFeatureName, char[] sDisplay, int maxlen)
{
	FormatEx(sDisplay, maxlen, "%T [%T]", "VIP_Feature_Silencer", client, VIP_IsClientFeatureUse(client, VIP_FEATURE_NAME_SILENCER) ? "Enabled": "Disabled", client);
	return true;
}

public Action OnToggleItemCallback_NightVision(int client, const char[] sFeatureName, VIP_ToggleState OldStatus, VIP_ToggleState &NewStatus)
{
	g_bVipFeatureEnabled_NightVision[client] = (NewStatus == ENABLED);
	return Plugin_Continue;
}
public bool OnDisplayItem_Vip_Feature_NightVision(int client, const char[] sFeatureName, char[] sDisplay, int maxlen)
{
	FormatEx(sDisplay, maxlen, "%T [%T]", "VIP_Feature_NightVision", client, VIP_IsClientFeatureUse(client, VIP_FEATURE_NAME_NIGHTVISION) ? "Enabled": "Disabled", client);
	return true;
}

public Action OnToggleItemCallback_Reload(int client, const char[] sFeatureName, VIP_ToggleState OldStatus, VIP_ToggleState &NewStatus)
{
	g_bVipFeatureEnabled_Reload[client] = (NewStatus == ENABLED);
	return Plugin_Continue;
}
public bool OnDisplayItem_Vip_Feature_Reload(int client, const char[] sFeatureName, char[] sDisplay, int maxlen)
{
	FormatEx(sDisplay, maxlen, "%T [%T]", "VIP_Feature_Reload", client, VIP_IsClientFeatureUse(client, VIP_FEATURE_NAME_RELOAD) ? "Enabled": "Disabled", client);
	return true;
}
#endif

void ReloadSDK()
{
	Handle hGameData = LoadGameConfigFile("l4d_useful_upgrades");
	if( hGameData == null ) SetFailState("Could not find gamedata file at addons/sourcemod/gamedata/l4d_useful_upgrades.txt , you FAILED AT INSTALLING");
	
	StartPrepSDKCall(SDKCall_Player);
	if( PrepSDKCall_SetFromConf(hGameData, SDKConf_Signature, "AddUpgrade") == false )
	{
		LogError("Failed to find signature: AddUpgrade");
	}
	else {
		PrepSDKCall_AddParameter(SDKType_PlainOldData, SDKPass_ByValue);
		sdkAddUpgrade = EndPrepSDKCall();
		if( sdkAddUpgrade == null ) LogError("Failed to create SDKCall: AddUpgrade");
	}
	
	StartPrepSDKCall(SDKCall_Player);
	if( PrepSDKCall_SetFromConf(hGameData, SDKConf_Signature, "RemoveUpgrade") == false )
	{
		LogError("Failed to find signature: RemoveUpgrade");
	}
	else {
		PrepSDKCall_AddParameter(SDKType_PlainOldData, SDKPass_ByValue);
		sdkRemoveUpgrade = EndPrepSDKCall();
		if( sdkRemoveUpgrade == null ) LogError("Failed to create SDKCall: RemoveUpgrade");
	}
	
	// Nop patch (thanks to SilverShot for sample)
	int iOffset = GameConfGetOffset(hGameData, "AddUpgrade_Offset");
	if( iOffset == -1 ) SetFailState("Failed to load \"AddUpgrade_Offset\" offset.");
	
	int iByteMatch = GameConfGetOffset(hGameData, "AddUpgrade_Byte");
	if( iByteMatch == -1 ) SetFailState("Failed to load \"AddUpgrade_Byte\" byte.");

	int iByteCount = GameConfGetOffset(hGameData, "AddUpgrade_Count");
	if( iByteCount == -1 ) SetFailState("Failed to load \"AddUpgrade_Count\" count.");

	g_Address_Sound = GameConfGetAddress(hGameData, "AddUpgrade");
	if( !g_Address_Sound ) SetFailState("Failed to load \"AddUpgrade\" address.");

	g_Address_Sound += view_as<Address>(iOffset);
	g_ByteSaved_Sound = new ArrayList();

	for( int i = 0; i < iByteCount; i++ )
	{
		g_ByteSaved_Sound.Push(LoadFromAddress(g_Address_Sound + view_as<Address>(i), NumberType_Int8));
	}

	if( g_ByteSaved_Sound.Get(0) != iByteMatch ) SetFailState("Failed to load, byte mis-match @ %d (0x%02X != 0x%02X)", iOffset, g_ByteSaved_Sound.Get(0), iByteMatch);
}

void Forward_UpgradeChanged(int client, int iUpgrade)
{
	Action result;
	Call_StartForward(g_UpgradeChanged);
	Call_PushCell(client);
	Call_PushCell(iUpgrade);
	Call_Finish(result);
}

public int NATIVE_SetUpgrades(Handle plugin, int numParams)
{
	if( numParams < 2 )
		ThrowNativeError(SP_ERROR_PARAM, "Invalid numParams");
	
	int iClient = GetNativeCell(1);
	int iUpgradeBits = GetNativeCell(2);
	
	g_cl_upgrades[iClient] = iUpgradeBits;
	SetUpgradeBit(iClient, true);
	return 0;
}

public int NATIVE_GetUpgrades(Handle plugin, int numParams)
{
	if( numParams < 1 )
		ThrowNativeError(SP_ERROR_PARAM, "Invalid numParams");
	
	int iClient = GetNativeCell(1);

	return g_cl_upgrades[iClient];
}

/*
public void OnClientPostAdminCheck(int client)
{
	ClientCommand(client, "bind l sm_laser; bind k sm_silent; bind n sm_night; bind v sm_reload");
}
*/

public void OnConfigsExecuted()
{
	if( g_ConVarSurvivorUpgrades != null )
	{
		#if FIX_RARE_BUG_METHOD
			g_ConVarSurvivorUpgrades.SetInt(1, true, false);
			// Add delay of setting survivor_upgrades second time, fixes rare bug to ensure convar is set. Hopefully fixes weird rare bug.
			CreateTimer(5.0, Timer_SetSurvivorUpgradesCVar, _, TIMER_FLAG_NO_MAPCHANGE);
		#else
			while( g_ConVarSurvivorUpgrades.IntValue != 1 )
			{
				g_ConVarSurvivorUpgrades.SetInt(1, true, false);
			}
		#endif
	}
}

#if FIX_RARE_BUG_METHOD

public Action Timer_SetSurvivorUpgradesCVar(Handle hTimer)
{
	if( g_ConVarSurvivorUpgrades != null )
	{
		if( g_ConVarSurvivorUpgrades.IntValue == 0 )
		{
			g_ConVarSurvivorUpgrades.SetInt(1, true, false);
			
			for( int i = 0; i <= MaxClients; i++ )
			{
				if( IsClientInGame(i) && !IsFakeClient(i) && GetClientTeam(i) == 2 )
				{
					LoadCookie(i);
				}
			}
		}
	}
}
#endif

public void Event_PlayerBotReplace(Event event, const char[] name, bool dontBroadcast)
{
	int client = GetClientOfUserId(event.GetInt("player"));
	
	if( client && IsClientInGame(client) && GetClientTeam(client) == 2 )
	{
		DisableAllUpgrades(client);
	}
}

public void Event_PlayerDisconnect(Event event, const char[] name, bool dontBroadcast)
{
	int client = GetClientOfUserId(event.GetInt("userid"));
	
	if( client && IsClientInGame(client) && GetClientTeam(client) == 2 )
	{
		DisableAllUpgrades(client);
	}
}

public void Event_RoundEnd(Event event, const char[] name, bool dontBroadcast)
{
	g_bRoundStart = false;
	
	for( int i = 1; i <= MaxClients; i++ )
	{
		if( IsClientInGame(i) && GetClientTeam(i) == 2 )
		{
			DisableAllUpgrades(i);
		}
	}
}

public void Event_RoundStart(Event event, const char[] name, bool dontBroadcast)
{
	g_bRoundStart = true;
}

public void Event_PlayerDeath(Event event, const char[] name, bool dontBroadcast)
{
	int client = GetClientOfUserId(event.GetInt("userid"));
	
	if( client && IsClientInGame(client) && GetClientTeam(client) == 2 && !IsFakeClient(client) )
	{
		DisableAllUpgrades(client);
	}
}

public void Event_PlayerSpawn(Event event, const char[] name, bool dontBroadcast)
{
	int UserId = event.GetInt("userid");
	int client = GetClientOfUserId(UserId);
	
	if( client && IsClientInGame(client) && GetClientTeam(client) == 2 && !IsFakeClient(client) )
	{
		DisableAllUpgrades(client);
		CreateTimer(0.3, Timer_LoadCookie, UserId, TIMER_FLAG_NO_MAPCHANGE);
	}
}

public void Event_WeaponDrop(Event event, const char[] name, bool dontBroadcast) // Thanks for code to dcx2
{
	if( !g_ConVarRemoveLaserDropped.BoolValue ) 
		return;
	
	int client = GetClientOfUserId(event.GetInt("userid"));
	if( !client || !IsClientInGame(client) || GetClientTeam(client) != 2 )
		return;
	
	int droppedEnt = GetEventInt(event, "propid");					// Grab the dropped weapon
	
	// WeaponDrop is called for all kinds of stuff (pills, melee, etc)
	// Can this dropped weapon have a laser sight?
	// If it can have a laser sight, does it have one?
	if( L4D2_CanWeaponUpgrades(droppedEnt) )
	{
		int droppedUpgrades = GetEntProp(droppedEnt, Prop_Send, "m_upgradeBitVec");
		
		if( droppedUpgrades & L4D2_WEPUPGFLAG_LASER )
		{
			// If the client dies, don't remove laser sights or the gun could disappear
			if( GetClientHealth(client) > 0 )
			{
				SetEntProp(droppedEnt, Prop_Send, "m_upgradeBitVec", droppedUpgrades & ~L4D2_WEPUPGFLAG_LASER);				
			}
		}
	}
}

stock bool L4D2_CanWeaponUpgrades(int weapon)
{
	return (GetEntSendPropOffs(weapon, "m_upgradeBitVec") > -1);
}

public Action Timer_LoadCookie(Handle timer, int UserId)
{
	int client = GetClientOfUserId(UserId);

	if( client && IsClientInGame(client) )
	{
		LoadCookie(client);
	}
	return Plugin_Continue;
}

public void OnClientPutInServer(int client)
{
	if( client == 0 || IsFakeClient(client) ) return;
	DisableAllUpgrades(client);
	
	if( g_bLeft4dead2 )
	{
		SetSDKHooks(client);
	}
	
	g_bVipFeatureEnabled_Laser[client] = false;
	g_bVipFeatureEnabled_Silencer[client] = false;
	g_bVipFeatureEnabled_NightVision[client] = false;
	g_bVipFeatureEnabled_Reload[client] = false;
}

void SetSDKHooks(int client)
{
	SDKHook(client, SDKHook_WeaponEquipPost, OnWeaponEquipPost);
	SDKHook(client, SDKHook_WeaponSwitch, OnWeaponSwitch);
}

public void OnWeaponEquipPost (int client, int weapon)
{
	//PrintToChat(client, "OnWeaponEquipPost");

	RefreshUpgrade(client);
}

public void OnWeaponSwitch (int client, int weapon)
{
	//PrintToChat(client, "OnWeaponSwitch");

	RefreshUpgrade(client);
}

void RefreshUpgrade(int client)
{
	if( g_bLeft4dead2 && !g_bRoundStart )
	{
		return;
	}
	
	g_bLockForward = true;
	SetUpgradeBit(client, true);
	g_bLockForward = false;
}

stock void DisableAllUpgrades(int client)
{
	if( !g_bLeft4dead2 )
	{
		SetEntProp(client, Prop_Send, "m_upgradeBitVec", 0, 4);
	}
	SetEntProp(client, Prop_Send, "m_bNightVisionOn", 0, 4);
	SetEntProp(client, Prop_Send, "m_bHasNightVision", 0, 4);
	SwitchLaser(client, _, true, true);
	g_bLaserEnabled[client] = false;
	g_cl_upgrades[client] = 0;
	Forward_UpgradeChanged(client, 0);
}

void SaveCookie(int client)
{
	if( client && IsClientInGame(client) )
	{
		int bits = g_cl_upgrades[client];
		
		if( bits == 0 )
		{
			bits = -1; // -1 is magik, mean cookies saved but upgrades = 0.
		}
		
		#if DEBUG
			PrintToChat(client, "Saved bits = %i, Laser: %i, silence: %i, night: %i, reload: %i", bits,
			bits & LASER_BIT, bits & SILENCER_BIT, bits & NIGHT_BIT, bits & RELOAD_BIT);
		#endif
		
		static char sCookie[16];
		IntToString(bits, sCookie, sizeof(sCookie));
		if ( g_hCookie != INVALID_HANDLE)
		{
			SetClientCookie(client, g_hCookie, sCookie);
		}
	}
}

/*
public void OnClientCookiesCached(int client)
{
	if(IsClientInGame(client) && !IsFakeClient(client))
	{
		LoadCookie(client);
	}
}
*/

void LoadCookie(int client)
{
	if( IsClientInGame(client) && !IsFakeClient(client) )
	{
		int bits;
		
		if( g_hCookie != INVALID_HANDLE && AreClientCookiesCached(client) )
		{
			static char sCookie[16];
			
			GetClientCookie(client, g_hCookie, sCookie, sizeof(sCookie));
			
			if( strlen(sCookie) && strcmp(sCookie, "0") != 0 )
			{
				bits = StringToInt(sCookie);
			}
			
			if( bits == 0 ) // no cookies
			{
				if( g_ConVarSilencerForce_Join != null && g_ConVarSilencerForce_Join.BoolValue )
					bits |= SILENCER_BIT;
				
				if( g_ConVarLaserForce_Join.BoolValue )
					bits |= LASER_BIT;
				
				if( g_ConVarNightVisionForce_Join.BoolValue )
					bits |= NIGHT_BIT;
				
				if( g_ConVarReloadForce_Join != null && g_ConVarReloadForce_Join.BoolValue )
					bits |= RELOAD_BIT;
			}
			
			if( bits == -1 )
			{
				bits = 0; // -1 is magik, mean cookies saved but upgrades = 0.
			}
		}
		
		if( g_ConVarSilencerForce_Spawn != null && g_ConVarSilencerForce_Spawn.BoolValue )
			bits |= SILENCER_BIT;
		
		if( g_ConVarLaserForce_Spawn.BoolValue )
			bits |= LASER_BIT;
		
		if( g_ConVarNightVisionForce_Spawn.BoolValue )
			bits |= NIGHT_BIT;
		
		if( g_ConVarReloadForce_Spawn != null && g_ConVarReloadForce_Spawn.BoolValue )
			bits |= RELOAD_BIT;
		
		g_cl_upgrades[client] = bits;
		
		if( !IsUpgradeAllowed(client, SILENCER_BIT) ) // if vip only option selected
		{
			g_cl_upgrades[client] &= ~SILENCER_BIT;
		}
		if( !IsUpgradeAllowed(client, LASER_BIT) )
		{
			g_cl_upgrades[client] &= ~LASER_BIT;
		}
		if( !IsUpgradeAllowed(client, NIGHT_BIT) )
		{
			g_cl_upgrades[client] &= ~NIGHT_BIT;
		}
		if( !IsUpgradeAllowed(client, RELOAD_BIT) )
		{
			g_cl_upgrades[client] &= ~RELOAD_BIT;
		}
		
		CreateTimer(0.1, Timer_LoadUpgrades, GetClientUserId(client), TIMER_FLAG_NO_MAPCHANGE);
	}
}

public Action Timer_LoadUpgrades(Handle timer, int UserId)
{
	int client = GetClientOfUserId(UserId);
	
	if( client && IsClientInGame(client) ) 
	{
		SetUpgradeBit(client, false);
	}
	return Plugin_Continue;
}

void SetUpgradeBit(int client, bool bInstantly)
{
	#if DEBUG
		PrintToChat(client, "Loaded bits = %i. Laser: %i, silence: %i, night: %i, reload: %i", g_cl_upgrades[client],
			g_cl_upgrades[client] & LASER_BIT, g_cl_upgrades[client] & SILENCER_BIT, g_cl_upgrades[client] & NIGHT_BIT, g_cl_upgrades[client] & RELOAD_BIT);
	#endif
	
	if( !g_bLockForward )
	{
		Forward_UpgradeChanged(client, g_cl_upgrades[client]);
	}
	
	int upgrades, bits;
	
	// removed laser from basic upgrade to prevent crash
	upgrades = g_cl_upgrades[client] & ~LASER_BIT;
	
	if( !g_bLeft4dead2 )
	{
		bits = GetEntProp(client, Prop_Send, "m_upgradeBitVec");
		
		if( bits != upgrades )
		{
			SetEntProp(client, Prop_Send, "m_upgradeBitVec", upgrades, 4);
		}
	}
	
	if( g_bLeft4dead2 || (bits != upgrades) )
	{
		if( upgrades & NIGHT_BIT )
		{
			SetEntProp(client, Prop_Send, "m_bNightVisionOn", 1, 4);
			SetEntProp(client, Prop_Send, "m_bHasNightVision", 1, 4);
		}
		else {
			SetEntProp(client, Prop_Send, "m_bNightVisionOn", 0, 4);
			SetEntProp(client, Prop_Send, "m_bHasNightVision", 0, 4);
		}
	}
	if( bInstantly )
	{
		RefreshLaser(client);
	}
	else {
		CreateTimer(1.0, Timer_SetLaserDelayed, GetClientUserId(client), TIMER_FLAG_NO_MAPCHANGE);
	}
}

public Action Timer_SetLaserDelayed(Handle timer, int UserId)
{
	int client = GetClientOfUserId(UserId);
	
	if( client && IsClientInGame(client) )
	{
		RefreshLaser(client);
	}
	return Plugin_Continue;
}

void RefreshLaser(int client)
{
	if( g_cl_upgrades[client] & LASER_BIT )
	{
		SwitchLaser(client, true, _, true);
	}
	else {
		SwitchLaser(client, _, true, true);
	}
}

void UpdateBitVec( int client )
{
	if( !g_bLeft4dead2 )
	{
		SetEntProp(client, Prop_Send, "m_upgradeBitVec", g_cl_upgrades[client] & ~LASER_BIT, 4);
		RefreshLaser(client);
		Forward_UpgradeChanged( client, g_cl_upgrades[client] );
	}
}

public Action CmdSilencer(int client, int args)
{
	if( !client )
	{
		ReplyToCommand(client, "Listen servers are not supported! Enter command directly to chat!");
		return Plugin_Handled;
	}
	SwitchSilencer(client);
	SaveCookie(client);
	return Plugin_Handled;
}
void SwitchSilencer(int client, bool bEnable = false, bool bDisable = false, bool bSilent = false)
{
	if( g_ConVarSilencerEnable.BoolValue && IsClientInGame(client) && !IsFakeClient(client) && GetClientTeam(client) == 2 && IsPlayerAlive(client) )
	{
		if( IsUpgradeAllowed(client, SILENCER_BIT) )
		{
			if( bEnable || ((g_cl_upgrades[client] & SILENCER_BIT) == 0 && !bDisable) )
			{
				g_cl_upgrades[client] |= SILENCER_BIT;
				UpdateBitVec(client);

				if( !bSilent )
					PrintToChat(client, "%t", "Silencer_On");
			}
			else {
				g_cl_upgrades[client] &= ~SILENCER_BIT;
				UpdateBitVec(client);
				
				if( !bSilent )
					PrintToChat(client, "%t", "Silencer_Off");
			}
		}
	}
}

public Action CmdLaser(int client, int args)
{
	if( !client )
	{
		ReplyToCommand(client, "Listen servers are not supported! Enter command directly to chat!");
		return Plugin_Handled;
	}
	SwitchLaser(client);
	SaveCookie(client);
	return Plugin_Handled;
}
void SwitchLaser(int client, bool bEnable = false, bool bDisable = false, bool bSilent = false)
{
	if( g_ConVarLaserEnable.BoolValue && IsClientInGame(client) && GetClientTeam(client) == 2 )
	{
		if( IsUpgradeAllowed(client, LASER_BIT) )
		{
			if( bEnable || (!g_bLaserEnabled[client] && !bDisable) )
			{
				//ReloadSDK();
				PatchAddress(true);
				SDKCall(sdkAddUpgrade, client, g_bLeft4dead2 ? 2 : 17);
				PatchAddress(false);
				
				//ClientCommand(client, "crosshair 0");
				
				g_bLaserEnabled[client] = true;
				g_cl_upgrades[client] |= LASER_BIT;
				Forward_UpgradeChanged(client, g_cl_upgrades[client] );
				
				if( !bSilent )
				{
					PrintToChat(client, "%t", "Laser_On");
				}
			}
			else if( g_bLaserEnabled[client] || g_bLeft4dead2 )
			{
				//ReloadSDK();
				SDKCall(sdkRemoveUpgrade, client, g_bLeft4dead2 ? 2 : 17);
				
				//ClientCommand(client, "crosshair 1"); 
				
				g_bLaserEnabled[client] = false;
				g_cl_upgrades[client] &= ~LASER_BIT;
				Forward_UpgradeChanged(client, g_cl_upgrades[client] );
				
				if( !bSilent )
				{
					PrintToChat(client, "%t", "Laser_Off");
				}
			}
		}
	}
}

public Action CmdNightVision(int client, int args)
{
	if( !client )
	{
		ReplyToCommand(client, "Listen servers are not supported! Enter command directly to chat!");
		return Plugin_Handled;
	}
	SwitchNightVision(client);
	SaveCookie(client);
	return Plugin_Handled;
}
void SwitchNightVision(int client, bool bEnable = false, bool bDisable = false, bool bSilent = false)
{
	if( g_ConVarNightVisionEnable.BoolValue && IsClientInGame(client) && !IsFakeClient(client) && GetClientTeam(client) == 2 && IsPlayerAlive(client) )
	{
		if( IsUpgradeAllowed(client, NIGHT_BIT) )
		{
			if( bEnable || ((g_cl_upgrades[client] & NIGHT_BIT) == 0 && !bDisable) )
			{
				g_cl_upgrades[client] |= NIGHT_BIT;
				SetEntProp(client, Prop_Send, "m_bNightVisionOn", 1, 4);
				SetEntProp(client, Prop_Send, "m_bHasNightVision", 1, 4);
				UpdateBitVec(client);

				if( !bSilent )
					PrintToChat(client, "%t", "NightVision_On");
			}
			else {
				g_cl_upgrades[client] &= ~NIGHT_BIT;
				SetEntProp(client, Prop_Send, "m_bNightVisionOn", 0, 4);
				SetEntProp(client, Prop_Send, "m_bHasNightVision", 0, 4);
				UpdateBitVec(client);
				
				if( !bSilent )
					PrintToChat(client, "%t", "NightVision_Off");
			}
		}
	}
}

public Action CmdFastReload(int client, int args)
{
	if( !client )
	{
		ReplyToCommand(client, "Listen servers are not supported! Enter command directly to chat!");
		return Plugin_Handled;
	}
	SwitchFastReload(client);
	SaveCookie(client);
	return Plugin_Handled;
}

void SwitchFastReload(int client, bool bEnable = false, bool bDisable = false, bool bSilent = false)
{
	if( g_ConVarFastReloadEnable.BoolValue && IsClientInGame(client) && !IsFakeClient(client) && GetClientTeam(client) == 2 && IsPlayerAlive(client) )
	{
		if( IsUpgradeAllowed(client, RELOAD_BIT) )
		{
			if( bEnable || ((g_cl_upgrades[client] & RELOAD_BIT) == 0 && !bDisable) )
			{
				g_cl_upgrades[client] |= RELOAD_BIT;
				UpdateBitVec(client);
				
				if( !bSilent )
					PrintToChat(client, "%t", "Reload_On");
			}
			else {
				g_cl_upgrades[client] &= ~RELOAD_BIT;
				UpdateBitVec(client);
				
				if( !bSilent )
					PrintToChat(client, "%t", "Reload_Off");
			}
		}
	}
}

public Action SayTextHook(UserMsg msg_id, BfRead msg, const int[] players, int playersNum, bool reliable, bool init)
{
	int iSender = g_Proto ? PbReadInt(msg, "ent_idx") : BfReadByte(msg);
	if( iSender )
	{
		return Plugin_Continue;
	}
	
	g_Proto ? PbReadBool(msg, "chat") : view_as<bool>(BfReadByte(msg));
	
	char message[64];
	
	if( g_Proto )
	{
		PbReadString(msg, "msg_name", message, sizeof message);
	}
	else {
		BfReadString(msg, message, sizeof message);
	}
	
	if( StrContains(message, "_expire") != -1 ) {
		return Plugin_Handled;
	}
	else if( strncmp(message, "L4D_Upgrade", 11) == 0 ) { //&& (StrContains(message, "description") != -1 || StrContains(message, "alert") != -1) ) {
		return Plugin_Handled;
	}
	else if( strcmp(message, "L4D_NOTIFY_VOMIT_ON") == 0 ) {
		return Plugin_Handled;
	}
	else if( strcmp(message, "Cstrike_TitlesTXT_Game_connected") == 0 ) {
		return Plugin_Handled;
	}	
	return Plugin_Continue;
}

void PatchAddress(int patch)
{
	static bool patched;
	
	if( !patched && patch )
	{
		patched = true;

		int len = g_ByteSaved_Sound.Length;
		for( int i = 0; i < len; i++ )
		{
			StoreToAddress(g_Address_Sound + view_as<Address>(i), 0x90, NumberType_Int8); // NOP
		}
	}
	else if( patched && !patch )
	{
		patched = false;

		int len = g_ByteSaved_Sound.Length;
		for( int i = 0; i < len; i++ )
		{
			StoreToAddress(g_Address_Sound + view_as<Address>(i), g_ByteSaved_Sound.Get(i), NumberType_Int8);
		}
	}
}

bool IsUpgradeAllowed(int client, int upgrade_bit)
{
	if( !g_bVipAvail )
	{
		return true;
	}
	if( upgrade_bit & LASER_BIT )
	{
		if( g_ConVarLaserVipOnly.BoolValue )
		{
			return g_bVipFeatureEnabled_Laser[client];
		}
		else {
			return true;
		}
	}
	if( upgrade_bit & NIGHT_BIT )
	{
		if( g_ConVarNightVisionVipOnly.BoolValue )
		{
			return g_bVipFeatureEnabled_NightVision[client];
		}
		else {
			return true;
		}
	}
	if( !g_bLeft4dead2 )
	{
		if( upgrade_bit & SILENCER_BIT )
		{
			if( g_ConVarSilencerVipOnly.BoolValue )
			{
				return g_bVipFeatureEnabled_Silencer[client];
			}
			else {
				return true;
			}
		}
		if( upgrade_bit & RELOAD_BIT )
		{
			if( g_ConVarReloadVipOnly.BoolValue )
			{
				return g_bVipFeatureEnabled_Reload[client];
			}
			else {
				return true;
			}
		}
	}
	return false;
}