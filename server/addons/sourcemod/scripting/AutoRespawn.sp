#pragma semicolon 1
#pragma newdecls required

#include <sourcemod>
#include <sdktools>
#include <sdkhooks>

#undef REQUIRE_PLUGIN
#include <l4d_sm_respawn>

#define PLUGIN_VERSION "1.20"

#define DEBUG 0
#define MODEL_SHIELD "models/props_unique/airport/atlas_break_ball.mdl"

const int Slot_Primary        = 0;    // Primary weapon slot (weapon_smg, weapon_pumpshotgun, weapon_autoshotgun, weapon_rifle, weapon_hunting_rifle)
const int Slot_Secondary      = 1;    // Secondary weapon slot (weapon_pistol)
const int Slot_Melee          = 2;    // Melee (knife) weapon slot (weapon_first_aid_kit)
const int Slot_Projectile     = 3;    // Projectile weapon slot (weapon_molotov, weapon_pipe_bomb)
const int Slot_Explosive      = 4;    // Explosive (c4) weapon slot (weapon_pain_pills)

int g_iShowShield[2048];

#define SMG_IS_T2 1

float 	g_fDamageMultiplier[MAXPLAYERS+1];

int g_iRespawnCount[MAXPLAYERS+1];
int g_iRespTimeLeft[MAXPLAYERS+1];
int g_iShield[MAXPLAYERS+1];

Handle hTimerRespawn[MAXPLAYERS+1];

ConVar sm_ar_enable;
ConVar ar_respawn_delay;
ConVar ar_respawn_count;
ConVar ar_respawn_msgs;
ConVar ar_melee_enabled;
ConVar ar_melee_chance;
ConVar ar_goodweapon_enabled;
ConVar ar_goodweapon_chance;
ConVar ar_pills_enabled;
ConVar ar_pills_chance;
ConVar ar_barrel_enabled;
ConVar ar_barrel_chance;

int g_iClientToUserId[MAXPLAYERS+1];

bool g_MapEnd = false;
bool g_bRespawnAvail;
bool g_bLate;

public Plugin myinfo = 
{
	name = "[L4D] Auto-Respawn",
	author = "Dragokas",
	description = "Respawns players after their death and give them random item",
	version = PLUGIN_VERSION,
	url = "https://github.com/dragokas"
}

/*
	ChangeLog:
	
	1.20
	 - some little optimizations
	
	1.19
	 - shield is hidden when player is in incapacitated state
	
	1.18
	 - added check in get observed function
	
	1.17
	 - Added checking for stuck
	
	1.16
	 - Fixed UserId function
	 - Added shield model and immortality for 5.0 sec after respawn
	
	1.15
	 - Fixed -1 entity caused by GetObservedClient() func.
	 - Added return bool value to native (true - successfull respawn).
	
	1.14
	 - Added native for manual resurrection.
	
	1.13
	 - Added reliable way to determine empty place for spawning
	
	1.10.
	 - Added statistics fixing.
	 - Replaced client by UserId in timers.
	 - Good weapon is now always checked on spawn.
	 - Added ConVar to control the maximum number of respawns per round.

*/

public APLRes AskPluginLoad2(Handle myself, bool late, char[] error, int err_max)
{
	EngineVersion test = GetEngineVersion();
	if (test != Engine_Left4Dead && test != Engine_Left4Dead2)
	{
		strcopy(error, err_max, "Plugin only supports Left 4 Dead 1 and Left 4 Dead 2.");
		return APLRes_SilentFailure;
	}
	
	CreateNative("AR_RespawnPlayer", NATIVE_RespawnPlayer);
	CreateNative("AR_CreateShield", NATIVE_CreateShield);
	CreateNative("AR_RemoveShield", NATIVE_RemoveShield);
	RegPluginLibrary("autorespawn");
	g_bLate = late;
	return APLRes_Success;
}

public int NATIVE_RespawnPlayer(Handle plugin, int numParams)
{
	if(numParams < 1)
		ThrowNativeError(SP_ERROR_PARAM, "Invalid numParams");
	
	int iClient = GetNativeCell(1);
	return RespawnClient(iClient, false);
}

public int NATIVE_CreateShield(Handle plugin, int numParams)
{
	if(numParams < 3)
		ThrowNativeError(SP_ERROR_PARAM, "Invalid numParams");
	
	int iClient = GetNativeCell(1);
	float delay = GetNativeCell(2);
	float protection = GetNativeCell(3);
	
	return GiveShield(iClient, delay, protection);
}

public int NATIVE_RemoveShield(Handle plugin, int numParams)
{
	if(numParams < 1)
		ThrowNativeError(SP_ERROR_PARAM, "Invalid numParams");
	
	int iClient = GetNativeCell(1);
	vRemoveShield(iClient);
	return 0;
}

public void OnPluginStart()
{
	LoadTranslations("l4d_autorespawn.phrases");
	
	CreateConVar("l4d_auto_respawn_version", PLUGIN_VERSION, "Defines the version of AutoRespawn installed on this server", FCVAR_NOTIFY | FCVAR_DONTRECORD);
	
	sm_ar_enable 			= CreateConVar("ar_enable", 			"1", 	"Enables/disables AutoRespawn on this server at any given time", FCVAR_NOTIFY, true, 0.0, true, 1.0);
	ar_respawn_delay 		= CreateConVar("ar_respawn_delay", 		"45", 	"Amount of time (in seconds) after players die before they are automatically respawned", FCVAR_NOTIFY);
	ar_respawn_count 		= CreateConVar("ar_respawn_count", 		"2", 	"Maximum number of respawns per round (0 - to set infinite)", FCVAR_NOTIFY);
	
	ar_respawn_msgs 		= CreateConVar("ar_respawn_msgs", 		"1", 	"Enables/disables notification messages to players after they die that they will be respawned",FCVAR_NOTIFY,true, 0.0, true, 1.0);
	ar_melee_enabled 		= CreateConVar("ar_melee_enabled", 		"1", 	"Enables/disables melee will be given on player respawn",FCVAR_NOTIFY,true, 0.0, true, 1.0);
	ar_melee_chance 		= CreateConVar("ar_melee_chance", 		"20", 	"Chance 0-100 for melee",FCVAR_NOTIFY,true, 0.0, true, 100.0);
	ar_goodweapon_enabled 	= CreateConVar("ar_goodweapon_enabled", "1", 	"Enables/disables good weapon will be given on player respawn",FCVAR_NOTIFY,true, 0.0, true, 1.0);
	ar_goodweapon_chance 	= CreateConVar("ar_goodweapon_chance", 	"100", 	"Chance 0-100 for good weapon",FCVAR_NOTIFY,true, 0.0, true, 100.0);
	ar_pills_enabled 		= CreateConVar("ar_pills_enabled", 		"1", 	"Enables/disables pills will be given on player respawn",FCVAR_NOTIFY,true, 0.0, true, 1.0);
	ar_pills_chance 		= CreateConVar("ar_pills_chance", 		"20", 	"Chance 0-100 for pills",FCVAR_NOTIFY,true, 0.0, true, 100.0);
	ar_barrel_enabled		= CreateConVar("ar_barrel_enabled", 	"1", 	"Enables/disables barrel will be given on player respawn",FCVAR_NOTIFY,true, 0.0, true, 1.0);
	ar_barrel_chance 		= CreateConVar("ar_barrel_chance", 		"20", 	"Chance 0-100 for barrel",FCVAR_NOTIFY,true, 0.0, true, 100.0);
	
	AutoExecConfig(true, "l4d_auto_respawn");
	
	HookEvent("player_death", 			Event_Death);
	HookEvent("survivor_rescued", 		Event_Survivor_Rescued);
	HookEvent("player_disconnect", 		Event_PlayerDisconnect, EventHookMode_Pre);
	HookEvent("player_bot_replace", 	Event_PlayerBotReplace);
	HookEvent("player_spawn", 			Event_PlayerSpawn);
	HookEvent("round_start", 			Event_RoundStart,	EventHookMode_PostNoCopy);
	HookEvent("round_end", 				Event_RoundEnd,		EventHookMode_PostNoCopy);
	HookEvent("finale_win", 			Event_RoundEnd,		EventHookMode_PostNoCopy);
	HookEvent("mission_lost", 			Event_RoundEnd,		EventHookMode_PostNoCopy);
	HookEvent("map_transition", 		Event_RoundEnd,		EventHookMode_PostNoCopy);
	HookEvent("player_incapacitated", 	Event_Incap);
	HookEvent("player_ledge_grab",		Event_Incap);
	HookEvent("revive_success", 		Event_EndRevive);
	HookEvent("heal_success", 			Event_EndRevive);
	
	#if (DEBUG)
		//test staff
		RegAdminCmd	("sm_test", 	Cmd_Test,			ADMFLAG_ROOT,	"");
	#endif
	
	if( g_bLate )
	{
		OnAllPluginsLoaded();
	}
}

public void OnAllPluginsLoaded()
{
	g_bRespawnAvail = (GetFeatureStatus(FeatureType_Native, "SM_Respawn") == FeatureStatus_Available);
}

public Action Cmd_Test(int client, int args)
{
	float pos[3];

	if (!FindEmptyPos(client, client, 15.0, pos)) {
		CPrintToChatAll("%T", "cant_spawn", client, client);
		
		return Plugin_Handled;
	}
	
	TeleportEntity(client, pos, NULL_VECTOR, NULL_VECTOR);
	
	return Plugin_Handled;
}

public void Event_Incap (Event event, const char[] name, bool dontBroadcast)
{
	int client = GetClientOfUserId(event.GetInt("userid"));
	
	int iShield = EntRefToEntIndex(g_iShield[client]);
	
	if (0 < iShield < 2048)
	{
		g_iShowShield[iShield] = false;
	}
}

public void Event_EndRevive (Event event, const char[] name, bool dontBroadcast)
{
	int client = GetClientOfUserId(event.GetInt("subject"));
	
	int iShield = EntRefToEntIndex(g_iShield[client]);
	
	if (0 < iShield < 2048)
	{
		g_iShowShield[iShield] = true;
	}
}

public void Event_RoundStart( Event event, const char[] name, bool dontBroadcast )
{
	OnMapStart();
}

public void Event_RoundEnd( Event event, const char[] name, bool dontBroadcast )
{
	OnMapEnd();
}

public void OnMapEnd()
{
	g_MapEnd = true;
	
	for (int i = 1; i <= MaxClients; i++)
	{
		KillSpawnTimer(i);
		vRemoveShield(i);
	}
}
public void OnMapStart()
{
	g_MapEnd = false;
	
	for (int i = 1; i <= MaxClients; i++) {
		g_iRespawnCount[i] = 0;
		hTimerRespawn[i] = INVALID_HANDLE;
	}
	
	PrecacheModel(MODEL_SHIELD, true);
}

public void Event_PlayerDisconnect(Event event, const char[] name, bool dontBroadcast)
{
	int client = GetClientOfUserId(event.GetInt("userid"));
	KillSpawnTimer(client);
	vRemoveShield(client);
}

public void Event_PlayerBotReplace(Event event, const char[] name, bool dontBroadcast)
{
	int client = GetClientOfUserId(event.GetInt("player"));
	KillSpawnTimer(client);
	vRemoveShield(client);
}

void GiveItem(int client, char[] sItem)
{
	int flags = GetCommandFlags("give");
	SetCommandFlags("give", flags & ~FCVAR_CHEAT);
	FakeClientCommand(client, "give %s", sItem);
	SetCommandFlags("give", flags);
}

bool ChancePassed(int chance)
{
	return(GetRandomInt(1, 100) <= chance);
}

void GiveWeaponT2(int client)
{
	static char MSG_Got[192];
	bool bGiveT2 = true;

	switch(GetRandomInt(0, 8))
	{
		case 0: { FormatEx(MSG_Got, sizeof(MSG_Got), "%T", "Prize1", client); }
		case 1: { FormatEx(MSG_Got, sizeof(MSG_Got), "%T", "Prize2", client); }
		case 2: { FormatEx(MSG_Got, sizeof(MSG_Got), "%T", "Prize3", client); }
		case 3: { FormatEx(MSG_Got, sizeof(MSG_Got), "%T", "Prize4", client); }
		case 4: { FormatEx(MSG_Got, sizeof(MSG_Got), "%T", "Prize5", client); }
		case 5: { FormatEx(MSG_Got, sizeof(MSG_Got), "%T", "Prize6", client); }
		case 6: { FormatEx(MSG_Got, sizeof(MSG_Got), "%T", "Prize7", client); }
		case 7: { FormatEx(MSG_Got, sizeof(MSG_Got), "%T", "Prize8", client); }
		case 8: { FormatEx(MSG_Got, sizeof(MSG_Got), "%T", "Prize9", client); }
	}
	
	int iEntWeapon = GetPlayerWeaponSlot(client, Slot_Primary);
	
	#if SMG_IS_T2
		if (iEntWeapon != -1)
		{
			char sClassname[32];
			GetEntityClassname(iEntWeapon, sClassname, sizeof(sClassname));
			if (strcmp(sClassname, "weapon_smg") == 0) {
				bGiveT2 = false;
			}
		}
	#endif
	
	if (bGiveT2)
	{
		if (iEntWeapon != -1) {
			RemovePlayerItem(client, iEntWeapon);
		}
		
		if (ar_goodweapon_enabled.BoolValue) {
			if (ChancePassed(ar_goodweapon_chance.IntValue)) {

				switch(GetRandomInt(0, 3)) {
					case 0: {
						GiveItem(client, "rifle");
						Format(MSG_Got, sizeof(MSG_Got), "%s %T.", MSG_Got, "rifle", client);
						CPrintToChat(client, MSG_Got);
					}
					case 1: {
						GiveItem(client, "autoshotgun");
						Format(MSG_Got, sizeof(MSG_Got), "%s %T.", MSG_Got, "autoshotgun", client);
						CPrintToChat(client, MSG_Got);
					}
					case 2: {
						GiveItem(client, "hunting_rifle");
						Format(MSG_Got, sizeof(MSG_Got), "%s %T..", MSG_Got, "hunting_rifle", client);
						CPrintToChat(client, MSG_Got);
					}
					case 3: {
						GiveItem(client, "pumpshotgun");
						Format(MSG_Got, sizeof(MSG_Got), "%s %T.", MSG_Got, "pumpshotgun", client);
						CPrintToChat(client, MSG_Got);
					}
				}
			} else {
				GiveItem(client, "smg");
			}
		} else {
			GiveItem(client, "smg");
		}
	}

	static char MSG_Got_2[256];

	if (ar_melee_enabled.BoolValue) {
		if (ChancePassed(ar_melee_chance.IntValue)) {
			
			iEntWeapon = GetPlayerWeaponSlot(client, Slot_Projectile);
			
			if (iEntWeapon == -1) {
				switch(GetRandomInt(0, 1)) {
					case 0: {
						GiveItem(client, "pipe_bomb");
						switch(GetRandomInt(0,5))
						{
							case 0: { FormatEx(MSG_Got_2, sizeof(MSG_Got_2), "%T", "pipe1", client); }
							case 1: { FormatEx(MSG_Got_2, sizeof(MSG_Got_2), "%T", "pipe2", client); }
							case 2: { FormatEx(MSG_Got_2, sizeof(MSG_Got_2), "%T", "pipe3", client); }
							case 3: { FormatEx(MSG_Got_2, sizeof(MSG_Got_2), "%T", "pipe4", client); }
							case 4: { FormatEx(MSG_Got_2, sizeof(MSG_Got_2), "%T", "pipe5", client); }
							case 5: { FormatEx(MSG_Got_2, sizeof(MSG_Got_2), "%T", "pipe6", client); }
						}
						CPrintToChat(client, MSG_Got_2);
					}
					case 1: {
						GiveItem(client, "molotov");
						switch(GetRandomInt(0,5))
						{
							case 0: { FormatEx(MSG_Got_2, sizeof(MSG_Got_2), "%T", "molotov1", client); }
							case 1: { FormatEx(MSG_Got_2, sizeof(MSG_Got_2), "%T", "molotov2", client); }
							case 2: { FormatEx(MSG_Got_2, sizeof(MSG_Got_2), "%T", "molotov3", client); }
							case 3: { FormatEx(MSG_Got_2, sizeof(MSG_Got_2), "%T", "molotov4", client); }
							case 4: { FormatEx(MSG_Got_2, sizeof(MSG_Got_2), "%T", "molotov5", client); }
							case 5: { FormatEx(MSG_Got_2, sizeof(MSG_Got_2), "%T", "molotov6", client); }
						}
						CPrintToChat(client, MSG_Got_2);
					}
				}
			}
		}
	}

	static char MSG_Got_3[192];

	if (ar_pills_enabled.BoolValue) {
		if (ChancePassed(ar_pills_chance.IntValue)) {

			iEntWeapon = GetPlayerWeaponSlot(client, Slot_Explosive);
			if (iEntWeapon == -1) {
		
				GiveItem(client, "pain_pills");
				switch(GetRandomInt(0,2))
				{
					case 0: { FormatEx(MSG_Got_3, sizeof(MSG_Got_3), "%T", "pills1", client); }
					case 1: { FormatEx(MSG_Got_3, sizeof(MSG_Got_3), "%T", "pills2", client); }
					case 2: { FormatEx(MSG_Got_3, sizeof(MSG_Got_3), "%T", "pills3", client); }
				}
				CPrintToChat(client, MSG_Got_3);
			}
		}
	}

	if (ar_barrel_enabled.BoolValue) {
		if (ChancePassed(ar_barrel_chance.IntValue)) {

			switch(GetRandomInt(0, 2)) {
				case 0: {
					GiveItem(client, "oxygentank");
					CPrintToChat(client, "%t", "oxygentank");
				}
				case 1: {
					GiveItem(client, "gascan");
					CPrintToChat(client, "%t", "gascan");			
				}
				case 2: {
					GiveItem(client, "propanetank");
					CPrintToChat(client, "%t", "propanetank");
				}
			}
		}
	}
}

public Action Event_Death( Event Death_Event, const char[] Death_Name, bool dontBroadcast )
{
	if( sm_ar_enable.BoolValue )
	{
		int UserId = Death_Event.GetInt("userid");
		int client = GetClientOfUserId( UserId );

		if ( client && IsClientInGame(client) && GetClientTeam(client) == 2)
		{
			vRemoveShield(client);
		
			int iRespMaxCount = ar_respawn_count.IntValue;
		
			if (g_iRespawnCount[client] < iRespMaxCount || iRespMaxCount == 0) {
		
				float respawndelaytime = ar_respawn_delay.FloatValue;
				
				hTimerRespawn[client] = CreateTimer(respawndelaytime, Timer_RespawnClient, UserId);
				g_iClientToUserId[client] = UserId;
				
				if( !IsFakeClient(client) && ar_respawn_msgs.BoolValue )
				{
					int respawndelaytimeint = RoundFloat (respawndelaytime);
					
					if (iRespMaxCount != 0) {
						CPrintToChat(client, "\x05[AutoRespawn] %t", "respawn_in_progress", respawndelaytimeint, iRespMaxCount - g_iRespawnCount[client] - 1, iRespMaxCount);
					}
					else
					{
						CPrintToChat(client, "\x05[AutoRespawn] %t", "respawn_in_progress_unlimit", respawndelaytimeint);
					}
					
					g_iRespTimeLeft[client] = respawndelaytimeint - 1;
					CreateTimer(1.0, Timer_RespawnHint, UserId, TIMER_REPEAT | TIMER_FLAG_NO_MAPCHANGE);
				}
			}
			else {
				if (!IsFakeClient(client)) {
					CPrintToChat(client, "%t", "depleted");
					CPrintToChat(client, "%t", "ask_help");
				}
			}
		}
	}
	return Plugin_Continue;
}

public Action Timer_RespawnHint(Handle timer, int UserId )
{
	int client = GetClientOfUserId(UserId);
	
	if (client && IsClientInGame(client) && !IsPlayerAlive(client)) {
		PrintCenterText(client, "%t", "elapsed", g_iRespTimeLeft[client]);
		g_iRespTimeLeft[client] -= 1;
		if (g_iRespTimeLeft[client] <= 0) {
			return Plugin_Stop;
		}
		else {
			return Plugin_Continue;
		}
	}
	else {
		return Plugin_Stop;
	}
}


int GetClientOfUserIdEx(int UserId)
{
	for (int i = 1; i <= MaxClients; i++)
		if (g_iClientToUserId[i] == UserId)
			return i;
		
	return 0;
}

public Action Timer_RespawnClient(Handle timer, int UserId )
{
	int client = GetClientOfUserId(UserId);
	
	if (client == 0) { // safe, just in case
		client = GetClientOfUserIdEx(UserId);
		hTimerRespawn[client] = INVALID_HANDLE;
		return Plugin_Stop;
	}
	
	hTimerRespawn[client] = INVALID_HANDLE;
	
	RespawnClient(client, true);

	return Plugin_Continue;
}

bool RespawnClient(int client, bool IncSpawnCount)
{
	if( !g_MapEnd )
	{
		if (client && IsClientInGame(client))
		{
			if ( !IsPlayerAlive(client) )
			{
				float pos[3];
				int targ;
				
				if (IsFakeClient(client))
				{
					targ = GetAnyValidClient();
				}
				else {
					targ = GetObservedClient(client);
					if (targ <= 0)
						targ = GetAnyValidClient();
				}
				
				int UserId = GetClientUserId(client);
				
				// no alive players
				if (targ <= 0) {
					return false;
				}
				
				if (!FindEmptyPos(targ, client, 15.0, pos)) {
					CPrintToChat(client, "%t", "cant_spawn", client);
					CreateTimer(1.0, Timer_RespawnClient, UserId, TIMER_FLAG_NO_MAPCHANGE);
					return true;
				}
				
				//SDKCall(hRoundRespawn, client);
				
				#if DEBUG
					PrintToChat(client, "Lib avail? %b", g_bRespawnAvail);
				#endif
				
				if( g_bRespawnAvail )
				{
					SM_Respawn(client);
					
					#if DEBUG
					PrintToChat(client, "Alive? %b", IsPlayerAlive(client));
					#endif
					
					if( IsPlayerAlive(client) )
					{
						if (IncSpawnCount) {
							g_iRespawnCount[client]++;
						}
						
						CreateTimer(0.5, Timer_GiveWeaponT2, UserId, TIMER_FLAG_NO_MAPCHANGE);

						TeleportEntity(client, pos, NULL_VECTOR, NULL_VECTOR);
						CheckStuck(client);
						GiveShield(client, 5.0, 1.0);
						
						return true;
					}
				}
				
			}
		}
	}
	return false;
}

int GiveShield(int client, float delay, float protection = 1.0)
{
	if (!IsClientInGame(client))
		return -1;
	
	if (GetClientTeam(client) != 2)
		return -1;
	
	if (!IsPlayerAlive(client))
		return -1;
	
	if (g_iShield[client] != -1 && g_iShield[client] != 0)
		return -1;
	
	int iShield = vShield(client);
	
	if (protection == 1.0)
	{
		SetEntProp(client, Prop_Data, "m_takedamage", 0, 1);
	}
	else {
		if (iShield != -1)
		{
			g_fDamageMultiplier[client] = 1.0 - protection;
			SDKUnhook(client, SDKHook_OnTakeDamage, OnTakeDamage);
			SDKHook(client, SDKHook_OnTakeDamage, OnTakeDamage);
		}
	}
	
	CreateTimer(delay, Timer_MakeMortal, GetClientUserId(client), TIMER_FLAG_NO_MAPCHANGE);
	return iShield;
}

public Action OnTakeDamage(int victim, int &attacker, int &inflictor, float &damage, int &damagetype, int &weapon, float damageForce[3], float damagePosition[3])
{
	damage *= g_fDamageMultiplier[victim];
	return Plugin_Changed;
}

public Action Timer_MakeMortal(Handle timer, int UserId )
{
	int client = GetClientOfUserId(UserId);
	
	if (client && IsClientInGame(client))
	{
		vRemoveShield(client);	
	}
	return Plugin_Continue;
}

void vRemoveShield(int client)
{
	int iShield = EntRefToEntIndex(g_iShield[client]);
	
	if (iShield && iShield != INVALID_ENT_REFERENCE && IsValidEntity(iShield))
	{
		AcceptEntityInput(iShield, "Kill");
	}
	g_iShield[client] = -1;
	
	if (client && IsClientInGame(client))
	{
		SDKUnhook(client, SDKHook_OnTakeDamage, OnTakeDamage);
		SetEntProp(client, Prop_Data, "m_takedamage", 2, 1);
	}
}

int vShield(int client)
{
	float flOrigin[3];
	GetClientAbsOrigin(client, flOrigin);
	flOrigin[2] -= 120.0;
	
	int iShield = CreateEntityByName("prop_dynamic");
	
	if (iShield != -1)
	{
		SetEntityModel(iShield, MODEL_SHIELD);

		DispatchKeyValueVector(iShield, "origin", flOrigin);
		DispatchSpawn(iShield);
		vSetEntityParent(iShield, client, true);

		SetEntityRenderMode(iShield, RENDER_TRANSTEXTURE);
		SetEntityRenderColor(iShield, 25, 125, 125, 50);

		SetEntProp(iShield, Prop_Send, "m_CollisionGroup", 1);
		
		g_iShowShield[iShield] = true;
		SDKHook(iShield, SDKHook_SetTransmit, Hook_SetTransmitShield);
		
		g_iShield[client] = EntIndexToEntRef(iShield);
	}
	return iShield;
}

public Action Hook_SetTransmitShield(int entity, int client) // hide shield when incapped, because too hard to see player
{
	if( g_iShowShield[entity] )
		return Plugin_Continue;
	return Plugin_Handled;
}

stock void vSetEntityParent(int entity, int parent, bool owner = false)
{
	SetVariantString("!activator");
	AcceptEntityInput(entity, "SetParent", parent);

	if (owner)
	{
		SetEntPropEnt(entity, Prop_Send, "m_hOwnerEntity", parent);
	}
}

int GetObservedClient(int client)
{
	int iSpecMode = GetEntProp(client, Prop_Send, "m_iObserverMode");
	if (iSpecMode != 0)
	{
		int target = GetEntPropEnt(client, Prop_Send, "m_hObserverTarget");
		if (target > 0 && target <= MaxClients && IsClientInGame(target) && IsPlayerAlive(target))
			return target;
	}
	return 0;
}

int GetAnyValidClient()
{
	for (int i = 1; i <= MaxClients; i++)
	{
		if (IsClientInGame(i) && GetClientTeam(i) == 2 && IsPlayerAlive(i))
			return i;
	}
	return 0;
}

public Action Event_Survivor_Rescued( Event event, const char[] name, bool dontBroadcast )
{
	int UserId = event.GetInt("victim");
	int client = GetClientOfUserId( UserId );

	if ( (0 < client <= MaxClients) && IsClientInGame(client))
	{
		KillSpawnTimer(client);
		CreateTimer(0.5, Timer_GiveWeaponT2, UserId, TIMER_FLAG_NO_MAPCHANGE);
	}
	return Plugin_Continue;
}

public Action Event_PlayerSpawn(Event event, const char[] name, bool dontBroadcast)
{
	int UserId = event.GetInt("userid");
	int client = GetClientOfUserId(UserId);
	
	if ((0 < client <= MaxClients) && IsClientInGame(client) && (GetClientTeam(client) == 2) && IsPlayerAlive(client) )
	{
		KillSpawnTimer(client);
		CreateTimer(0.5, Timer_GiveWeapon, UserId, TIMER_FLAG_NO_MAPCHANGE);
		CreateTimer(1.0, Timer_CheckStuck, UserId, TIMER_FLAG_NO_MAPCHANGE);
	}
	return Plugin_Continue;
}

void KillSpawnTimer(int client)
{
	if (hTimerRespawn[client] != INVALID_HANDLE) {
		KillTimer(hTimerRespawn[client]);
		hTimerRespawn[client] = INVALID_HANDLE;
	}
}

public Action Timer_GiveWeapon(Handle timer, int UserId)
{
	int client = GetClientOfUserId(UserId);

	if ((0 < client <= MaxClients) && IsClientInGame(client) && (GetClientTeam(client) == 2) && IsPlayerAlive(client) )
	{
		GivePrimaryWeapon(client);
	}
	return Plugin_Continue;
}

public Action Timer_GiveWeaponT2(Handle timer, int UserId)
{
	int client = GetClientOfUserId(UserId);

	if ((0 < client <= MaxClients) && IsClientInGame(client) && (GetClientTeam(client) == 2) && IsPlayerAlive(client) )
	{
		GiveWeaponT2(client);
	}
	return Plugin_Continue;
}

void GivePrimaryWeapon(int client)
{
	int EntWeapon;

	/*
	if (!g_bGotFirstPills[client]) {
		g_bGotFirstPills = true;
	
		EntWeapon = GetPlayerWeaponSlot(client, Slot_Explosive);
		if (EntWeapon == -1)
		{
			GiveItem(client, "pain_pills");
		}
	}
	*/

	EntWeapon = GetPlayerWeaponSlot(client, Slot_Secondary);
	if (EntWeapon == -1)
	{
		GiveItem(client, "pistol");
	}

	EntWeapon = GetPlayerWeaponSlot(client, Slot_Primary);
	if (EntWeapon == -1)
	{
		GiveItem(client, "pumpshotgun");
	
		/*
		if (GetRandomInt(0, 1) == 0) {
			GiveItem(client, "pumpshotgun");
		} else {
			GiveItem(client, "smg");
		}
		*/
	}

	/*
	char classname[64];
	if (EntWeapon != -1)
        GetEdictClassname(EntWeapon, classname, sizeof(classname));
	*/
}

stock float GetDistanceToVec(int client, float vEnd[3]) // credits: Peace-Maker
{ 
	float vMin[3], vMax[3], vOrigin[3], vStart[3], fDistance = 0.0;
	GetClientAbsOrigin(client, vStart);
	vStart[2] += 10.0;
	GetClientMins(client, vMin);
	GetClientMaxs(client, vMax);
	GetClientAbsOrigin(client, vOrigin);
	Handle hTrace = TR_TraceHullFilterEx(vOrigin, vEnd, vMin, vMax, MASK_PLAYERSOLID, TraceRay_NoPlayers, client);
	if ( hTrace != INVALID_HANDLE )
	{
		if(TR_DidHit(hTrace))
		{
			float fEndPos[3];
			TR_GetEndPosition(fEndPos, hTrace);
			vStart[2] -= 10.0;
			fDistance = GetVectorDistance(vStart, fEndPos);
		}
		else {
			vStart[2] -= 10.0;
			fDistance = GetVectorDistance(vStart, vEnd);
		}
		delete hTrace;
	}
	return fDistance; 
}

bool IsEmptyPos(int iClient, float vOrigin[3])
{
	float vMin[3], vMax[3];
	bool bHit;
	GetClientMins(iClient, vMin);
	GetClientMaxs(iClient, vMax);
	Handle hTrace = TR_TraceHullFilterEx(vOrigin, vOrigin, vMin, vMax, MASK_PLAYERSOLID, TraceRay_NoPlayers, iClient);
	if ( hTrace != INVALID_HANDLE )
	{
		bHit = TR_DidHit(hTrace);
		delete hTrace;
	}
	return !bHit;
}

stock float GetDistanceToFloor(int client)
{ 
	float fStart[3], fDistance = 0.0;
	
	if(GetEntPropEnt(client, Prop_Send, "m_hGroundEntity") == 0)
		return 0.0;
	
	GetClientAbsOrigin(client, fStart);
	
	fStart[2] += 10.0;
	
	Handle hTrace = TR_TraceRayFilterEx(fStart, view_as<float>({90.0, 0.0, 0.0}), MASK_PLAYERSOLID, RayType_Infinite, TraceRay_NoPlayers, client); 
	if ( hTrace != INVALID_HANDLE )
	{
		if(TR_DidHit(hTrace))
		{
			float fEndPos[3];
			TR_GetEndPosition(fEndPos, hTrace);
			fStart[2] -= 10.0;
			fDistance = GetVectorDistance(fStart, fEndPos);
		}
		delete hTrace;
	}
	return fDistance; 
}

stock bool ClientCanSeeClient(int client, float pos2[3]) 
{
	float pos1[3];
	bool bHit;
	GetClientEyePosition(client, pos1);
	Handle hTrace = TR_TraceRayFilterEx(pos1, pos2, MASK_SOLID_BRUSHONLY, RayType_EndPoint, TraceFilter_NotSelf); 
	if ( hTrace != INVALID_HANDLE )
	{
		bHit = TR_DidHit(hTrace);
		delete hTrace;
	}
	return !bHit;
}

public bool AimTargetFilter(int entity, int mask)
{
	return (entity > MaxClients || !entity);
}

public bool TraceFilter_NotSelf(int entity, int mask, any data) 
{
	return entity == data;
}

public bool TraceRay_NoPlayers(int entity, int mask, any data)
{
    if(entity == data || (entity >= 1 && entity <= MaxClients))
    {
        return false;
    }
    return true;
}

bool FindEmptyPos(int client, int target, float fSetDist, float vEnd[3])
{
	const float fClientHeight = 71.0;
	const float fMaxAltitude = 110.0;
	
	if (GetDistanceToFloor(client) > fMaxAltitude)
		return false;
	
	float vMin[3], vMax[3], vStart[3];
	
	GetClientAbsOrigin(client, vStart);
	
	GetClientMins(target, vMin);
	GetClientMaxs(target, vMax);
	float fTargetHeigth = vMax[2] - vMin[2];
	
	//to the right + up
	vEnd = vStart;
	vEnd[0] += fSetDist;
	vEnd[2] += (fClientHeight + 15.0);
	if (GetDistanceToVec(client, vEnd) >= fSetDist) {
		vEnd[2] -= fTargetHeigth;
		if (IsEmptyPos(target, vEnd) && ClientCanSeeClient(client, vEnd))
			return true;
	}
	
	//to the left + up
	vEnd = vStart;
	vEnd[0] -= fSetDist;
	vEnd[2] += (fClientHeight + 15.0);
	if (GetDistanceToVec(client, vEnd) >= fSetDist) {
		vEnd[2] -= fTargetHeigth;
		if (IsEmptyPos(target, vEnd) && ClientCanSeeClient(client, vEnd))
			return true;
	}
	
	//to the forward + up
	vEnd = vStart;
	vEnd[1] += fSetDist;
	vEnd[2] += (fClientHeight + 15.0);
	if (GetDistanceToVec(client, vEnd) >= fSetDist) {
		vEnd[2] -= fTargetHeigth;
		if (IsEmptyPos(target, vEnd) && ClientCanSeeClient(client, vEnd))
			return true;
	}
	
	//to the backward + up
	vEnd = vStart;
	vEnd[1] -= fSetDist;
	vEnd[2] += (fClientHeight + 15.0);
	if (GetDistanceToVec(client, vEnd) >= fSetDist) {
		vEnd[2] -= fTargetHeigth;
		if (IsEmptyPos(target, vEnd) && ClientCanSeeClient(client, vEnd))
			return true;
	}
	
	//to the roof;
	vEnd = vStart;
	vEnd[2] += (fClientHeight + 15.0);
	
	if (GetDistanceToVec(client, vEnd) >= (fClientHeight + fSetDist)) {
		vEnd[2] -= fTargetHeigth;
		if (IsEmptyPos(target, vEnd) && ClientCanSeeClient(client, vEnd))
			return true;
	}
	
	//to the backward
	vEnd = vStart;
	vEnd[1] -= fSetDist;
	if (GetDistanceToVec(client, vEnd) >= fSetDist && IsEmptyPos(target, vEnd) && ClientCanSeeClient(client, vEnd))
		return true;
	
	//to the right
	vEnd = vStart;
	vEnd[0] += fSetDist;
	if (GetDistanceToVec(client, vEnd) >= fSetDist && IsEmptyPos(target, vEnd) && ClientCanSeeClient(client, vEnd))
		return true;
	
	//to the left
	vEnd = vStart;
	vEnd[0] -= fSetDist;
	if (GetDistanceToVec(client, vEnd) >= fSetDist && IsEmptyPos(target, vEnd) && ClientCanSeeClient(client, vEnd))
		return true;

	//to the forward
	vEnd = vStart;
	vEnd[1] += fSetDist;
	if (GetDistanceToVec(client, vEnd) >= fSetDist && IsEmptyPos(target, vEnd) && ClientCanSeeClient(client, vEnd))
		return true;
	
	if (fSetDist == 1.0)
		return false;
	
	if (fSetDist >= 30.0) {
		fSetDist = 1.0;
	}
	else {
		fSetDist += 15.0;
	}
	
	FindEmptyPos(client, target, fSetDist, vEnd); // recurse => increase a distance until found appropriate location
	return false;
}

stock void ReplaceColor(char[] message, int maxLen)
{
    ReplaceString(message, maxLen, "{white}", "\x01", false);
    ReplaceString(message, maxLen, "{cyan}", "\x03", false);
    ReplaceString(message, maxLen, "{orange}", "\x04", false);
    ReplaceString(message, maxLen, "{green}", "\x05", false);
}

stock void CPrintToChatAll(const char[] format, any ...)
{
    static char buffer[192];
    for( int i = 1; i <= MaxClients; i++ )
    {
        if( IsClientInGame(i) && !IsFakeClient(i) )
        {
            SetGlobalTransTarget(i);
            VFormat(buffer, sizeof(buffer), format, 2);
            ReplaceColor(buffer, sizeof(buffer));
            PrintToChat(i, "\x01%s", buffer);
        }
    }
}

stock void CPrintToChat(int iClient, const char[] format, any ...)
{
    static char buffer[192];
    SetGlobalTransTarget(iClient);
    VFormat(buffer, sizeof(buffer), format, 3);
    ReplaceColor(buffer, sizeof(buffer));
    PrintToChat(iClient, "\x01%s", buffer);
}

void CheckStuck(int client)
{
	CreateTimer(0.3, Timer_CheckStuck, GetClientUserId(client), TIMER_FLAG_NO_MAPCHANGE);
}

Action Timer_CheckStuck(Handle timer, int UserId)
{
	int client = GetClientOfUserId(UserId);
	
	if (client && IsClientInGame(client) && GetClientTeam(client) == 2 && IsPlayerAlive(client))
	{
		UnStuck(client);
	}
	return Plugin_Continue;
}

void UnStuck(int client)
{
	float vOrigin[3];
	
	if (IsClientStuck(client))
	{
		int iNear = GetNearestSurvivorEx(client);
		if (iNear != 0)
		{
			GetClientAbsOrigin(iNear, vOrigin);
			vOrigin[2] += GetRandomFloat(0.0, 10.0);
			TeleportEntity(client, vOrigin, NULL_VECTOR, NULL_VECTOR);
		}
	}
}

int GetNearestSurvivorEx(int client) {
	static float tpos[3], spos[3], dist, mindist;
	static int i, iNearClient;
	mindist = 0.0;
	iNearClient = 0;
	GetClientAbsOrigin(client, tpos);
	
	for (i = 1; i <= MaxClients; i++) {
		if (i != client && IsClientInGame(i) && GetClientTeam(i) == 2 && IsPlayerAlive(i) && !IsClientStuck(i)) {
			GetClientAbsOrigin(i, spos);
			dist = GetVectorDistance(tpos, spos, false);
			if (dist < mindist || mindist < 0.1) {
				mindist = dist;
				iNearClient = i;
			}
		}
	}
	return iNearClient;
}

bool IsClientStuck(int iClient)
{
	float vMin[3], vMax[3], vOrigin[3];
	bool bHit;
	GetClientMins(iClient, vMin);
	GetClientMaxs(iClient, vMax);
	GetClientAbsOrigin(iClient, vOrigin);
	Handle hTrace = TR_TraceHullFilterEx(vOrigin, vOrigin, vMin, vMax, MASK_PLAYERSOLID, TraceRay_NoPlayers, iClient);
	if (hTrace != INVALID_HANDLE)
	{
		bHit = TR_DidHit(hTrace);
		delete hTrace;
	}
	return bHit;
}