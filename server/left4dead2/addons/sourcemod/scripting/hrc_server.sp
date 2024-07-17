#include <sourcemod>
#include <sdkhooks>
#include <sdktools>
#include <left4dhooks>

#define PLUGIN_NAME             "Hard Realism Coop Server"
#define PLUGIN_DESCRIPTION      ""
#define PLUGIN_VERSION          "2.0 beta"
#define PLUGIN_AUTHOR           "oblivcheck"
#define PLUGIN_URL              "https://github.com/oblivcheck/hard-realism-coop"

//#include "hrc/hud.sp"
//#include "hrc/switch++.sp"
#include "hrc/anti_jumpinskill.sp"

/***** 更新日志
2024-07-17 (2.0 beta)
  - 基本只是重名的插件
    -重写自版本 1.1b

*****/

public Plugin:myinfo =
{
        name = PLUGIN_NAME,
        author = PLUGIN_AUTHOR,
        description = PLUGIN_DESCRIPTION,
        version = PLUGIN_VERSION,
        url = PLUGIN_URL
}


int	g_iServerTickRate;

public void OnPluginStart()
{
  HookEvent("round_start", Event_RoundStart, EventHookMode_PostNoCopy);
  CreateTimer(0.5, tAutoTickRate);
}

Action tAutoTickRate(Handle Timer)
{
	g_iServerTickRate = GetConVarInt(FindConVar("sv_minupdaterate") );
	return Plugin_Continue;
}

public void OnMapStart()
{
  LoadVScript()
}

void Event_RoundStart(Event event, const char[] name, bool dontBroadcast)
{
  LoadVScript();
}

void LoadVScript()
{
  PrintToServer("#%s Loading VScript...\n", PLUGIN_NAME);

  int flag = GetCommandFlags("script_execute");

  if(flag != INVALID_FCVAR_FLAGS)
  {
    if(flag & FCVAR_CHEAT)
    {
      SetCommandFlags("script_execute", flag & ~FCVAR_CHEAT);
      PrintToServer("#%s LoadVScript() START\n", PLUGIN_NAME);

      ServerCommand("script_execute hrc/manacat_tank");
//        ServerCommand("script_execute hrc/manacat_hunter");
      ServerCommand("script_execute hrc/paicdevlos_");
      ServerCommand("script_execute hrc/spitfix");
//      ServerCommand("script_execute hrc/legacy/");

      ServerExecute();
      RequestFrame(rDelay, flag);
    }
  }
}

void rDelay(int flag)
{
  SetCommandFlags("script_execute", flag | FCVAR_CHEAT);
}
