#include <sourcemod>
#include <sdktools>
#include <sdkhooks>
#include <fastdl_list>
#include <left4dhooks>
//#include <attachments_api>

#define SF_PHYSPROP_PREVENT_PICKUP		(1 << 9)
#define EFL_DONTBLOCKLOS		(1 << 25)
#define EF_BONEMERGE			(1 << 0)
#define EF_NOSHADOW				(1 << 4)
#define EF_BONEMERGE_FASTCULL	(1 << 7)
#define EF_PARENT_ANIMATES		(1 << 9)
#define INDEX_VIEWS				0				// Indexes for g_iEntSaved
#define INDEX_WORLD				1
#define INDEX_ARMS				2

int g_iEntSaved[MAXPLAYERS+1][3];
int g_iEntBones[MAXPLAYERS+1];	
bool g_bExternalView[MAXPLAYERS+1];

bool g_bModeRealism_Load, ModeEnable;
ConVar g_hModeRealism;
int g_iHeadcrabList[MAXPLAYERS+1];
int g_iOffset_ViewModel;
int GetSendPropOffset(const char[] serverClass, const char[] propName) {
    int offset = FindSendPropInfo(serverClass, propName);

    if (!offset) {
        SetFailState("Fatal Error: Unable to find offset: \"%s::%s\"!", serverClass, propName);
    }

    return offset;
}
public void OnLibraryAdded(const char[] name)
{
  if(strcmp("rc_gamemode_realism", name) == 0)
  {
    g_bModeRealism_Load = true;
    g_hModeRealism = FindConVar("rc_gamemode_realism_enable");
    g_hModeRealism.AddChangeHook(Event_ConVarChanged);
  }
}
public void OnLibraryRemoved(const char[] name)
{
  if(strcmp("rc_gamemode_realism", name) == 0)
  {
    g_bModeRealism_Load = false;
    g_hModeRealism.RemoveChangeHook(Event_ConVarChanged);
  }
}

native bool FastDL_IsHeadcrab(int entity);

public void OnPluginStart()
{
  HookEvent("player_spawn", Event_PlayerSpawn);
  //DownloadFilesFromArray(Fastdl_Files, sizeof(Fastdl_Files) );
  //DownloadFilesFromArray_Sound(Fastdl_Sounds, sizeof(Fastdl_Sounds) );

  // CreateNative("FastDL_IsHeadcrab", Native_IsHeadcrab);
  RegAdminCmd("sm_dl", cmd_dl, ADMFLAG_ROOT);
}

public Action cmd_dl(int client, int args)
{
  SetEntityModel(client, "models/kancolle/survivors/survivor_biker.mdl");

  //int idx = PrecacheModel("models/kancolle/survivors/survivor_biker.mdl");
  //PrintToChatAll("%d", idx);
  return Plugin_Continue;
  // kancolle
  int viewmodel = GetEntPropEnt(client, Prop_Data, "m_hViewModel");
  
  int ent_arms = CreateEntityByName("prop_dynamic_override");
  DispatchKeyValue(ent_arms, "model", "models/weapons/arms/v_arms_francis.mdl");
  DispatchKeyValue(ent_arms, "solid", "0");
  DispatchKeyValue(ent_arms, "spawnflags", "256");
  DispatchKeyValue(ent_arms, "disablereceiveshadows", "1");
  DispatchKeyValue(ent_arms, "disableshadows", "1");
  DispatchSpawn(ent_arms);
  //SetEntProp(ent_arms, Prop_Send, "m_nSkin", m_nSkin);
  g_iOffset_ViewModel = GetSendPropOffset("CBasePlayer", "m_hViewModel");
  g_iEntSaved[client][INDEX_ARMS] = EntIndexToEntRef(ent_arms);
  viewmodel =  GetViewModel(client, 1); 
  // Attach to real viewmodel
  SetAttached(ent_arms, viewmodel);

  SDKHook(ent_arms, SDKHook_SetTransmit, Hook_SetTransmitViews);
	// SetEntProp(client, Prop_Send, "m_bDrawViewmodel", 0);

  SetEntProp(ent_arms, Prop_Data, "m_iEFlags", GetEntProp(ent_arms, Prop_Data, "m_iEFlags") | EFL_DONTBLOCKLOS | SF_PHYSPROP_PREVENT_PICKUP);
  SetEntProp(ent_arms, Prop_Send, "m_nSolidType", 6, 1);
  return Plugin_Continue;
}

public int Native_IsHeadcrab(Handle plugin, int numParams)
{
	int entity = GetNativeCell(1);
  for(int i=1; i<=MaxClients; i++)
  {
    if(g_iHeadcrabList[i] == entity)
      return true;
  }
  return false;
}

public void Event_ConVarChanged(ConVar convar, const char[] oldValue, const char[] newValue)
{
  ModeEnable = g_hModeRealism.BoolValue;
}

public void DownloadFilesFromArray(char[][] file, int size)
{
  for ( int i=0; i<size; i++ )
  {
    PrintToServer("%d", i);
    AddFileToDownloadsTable(file[i]);
    PrecacheModel(file[i]);
  }
}

public void DownloadFilesFromArray_Sound(char[][] file, int size)
{
  for ( int i=0; i<size; i++ )
  {
    char sound[PLATFORM_MAX_PATH];
    Format(sound, sizeof(sound), "sound/%s", file[i]);
    AddFileToDownloadsTable(sound);
//    PrintToServer("%s", file[i]);
    PrecacheSound(file[i]);
  }
}

public void OnMapStart()
{
  if(!ModeEnable) return;

  DownloadFilesFromArray(Fastdl_Files, sizeof(Fastdl_Files) );
  DownloadFilesFromArray_Sound(Fastdl_Sounds, sizeof(Fastdl_Sounds) );
}

void Event_PlayerSpawn(Event event, const char[] name, bool dontBroadcast)
{
  if(!ModeEnable) return
  // 也许需要设置动画
  //CreateTimer(1.5, tPlayerSpawn, event.GetInt("userid"), TIMER_FLAG_NO_MAPCHANGE);
  RequestFrame(rPlayerSpawn, event.GetInt("userid") );
}

//Action tPlayerSpawn(Handle Timer, any userid)
void rPlayerSpawn(any userid)
{
    int client = GetClientOfUserId(userid);
    if(client == 0)
      return;

    int team = GetClientTeam(client);
  /*
    if(team == 2)
    {
      char modelname[48];
      GetClientModel(client, modelname, sizeof(modelname));
      switch(modelname[29])
      {
      
        // nick
      //  case 'b':
      //  {
      //    modelname = "models/215/survivors/survivor_gambler.mdl";
      //  }
      
        // francis
        case 'e':
        {
          modelname = "models/kancolle/survivors/survivor_biker.mdl";
        }
        // louis
        case 'a':
        {
          modelname = "models/280/survivors/survivor_manager.mdl";
        }
      }
      SetEntityModel(client, modelname);
      return;
    }
*/
    if(team != 3)
      return;

    int zombieclass = GetEntProp(client, Prop_Send, "m_zombieClass");

    if(zombieclass == 5)
    {
      SetEntityModel(client, "models/headcrab/jockey.mdl");
    }

    return;
}

// ====================================================================================================
//					HELPERS
// ====================================================================================================
// Lux: As a note this should only be used for dummy entity other entities need to remove EF_BONEMERGE_FASTCULL flag.
/*
*	Recreated "SetAttached" entity input from "prop_dynamic_ornament"
*/
void SetAttached(int iEntToAttach, int iEntToAttachTo)
{
	SetVariantString("!activator");
	AcceptEntityInput(iEntToAttach, "SetParent", iEntToAttachTo);

	SetEntityMoveType(iEntToAttach, MOVETYPE_NONE);
	//SetEntityRenderMode(iEntToAttach, RENDER_NORMAL); // Make visible, for testing.

	SetEntProp(iEntToAttach, Prop_Send, "m_fEffects", EF_BONEMERGE|EF_NOSHADOW|EF_BONEMERGE_FASTCULL|EF_PARENT_ANIMATES);

	// Thanks smlib for flag understanding
	int iFlags = GetEntProp(iEntToAttach, Prop_Data, "m_usSolidFlags", 2);
	iFlags = iFlags |= 0x0004;
	SetEntProp(iEntToAttach, Prop_Data, "m_usSolidFlags", iFlags, 2);

	TeleportEntity(iEntToAttach, view_as<float>({0.0, 64.0, 0.0}), view_as<float>({0.0, 0.0, 0.0}), NULL_VECTOR);
}

Action Hook_SetTransmitViews(int entity, int client)
{
  //PrintToChatAll("h"r
	// Block view OR entity does not belong to client
	entity = EntIndexToEntRef(entity);
	if( g_bExternalView[client] || (
		entity != g_iEntSaved[client][INDEX_VIEWS] &&
		entity != g_iEntSaved[client][INDEX_ARMS] &&
		entity != g_iEntBones[client] )
	)
	{
		return Plugin_Handled;
	}
	return Plugin_Continue;
}

int GetViewModel(int client, int index) {
    return GetEntDataEnt2(client, g_iOffset_ViewModel + (index * 4));
}
