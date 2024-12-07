#include <sourcemod>
#include <sdktools>
#include <sdkhooks>
#include <fastdl_list>
bool g_bModeRealism_Load, ModeEnable;
ConVar g_hModeRealism;

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

public void OnPluginStart()
{
  HookEvent("player_spawn", Event_PlayerSpawn);
  //DownloadFilesFromArray(Fastdl_Files, sizeof(Fastdl_Files) );
  //DownloadFilesFromArray_Sound(Fastdl_Sounds, sizeof(Fastdl_Sounds) );
}

public void Event_ConVarChanged(ConVar convar, const char[] oldValue, const char[] newValue)
{
  ModeEnable = g_hModeRealism.BoolValue;
}

public void DownloadFilesFromArray(char[][] file, int size)
{
  for ( int i=0; i<size; i++ )
  {
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

  int client = GetClientOfUserId(event.GetInt("userid"));

  if (client == 0)
    return;

  if (GetClientTeam(client) != 3)
    return;

  int zombieclass = GetEntProp(client, Prop_Send, "m_zombieClass");

  if(zombieclass == 5)
  {
    SetEntityModel(client, "models/headcrab/jockey.mdl");
  }
}
