bool IsAliveSurvivor(int client)
{
	if( GetClientTeam(client) != 2 ) return false;
	return IsPlayerAlive(client);
}

bool IsValidAliveSurvivor(int client)
{
	if( !IsValidClient(client) ) return false;
	return IsAliveSurvivor(client);
}

bool bRPP;
ConVar hRPP;

int iTick;
ConVar hTick;

int counter[MAXPLAYERS+1];
// 看上去原插件这个功能有些问题
int exhaust[MAXPLAYERS+1];

void rpp_start()
{
  hTick = FindConVar("sv_minupdaterate");
  iTick = hTick.IntValue;
  hTick.AddChangeHook(CvarChange);
  
  CreateTimer(3.0, tDelay);
}
Action tDelay(Handle Timer)
{
  hRPP = FindConVar("rc_gamemode_realism_enable");
  if(hRPP == null)
    bRPP = false;
  else
  {
    bRPP = hRPP.BoolValue;
    hRPP.AddChangeHook(CvarChange);
    HookEvent("weapon_fire", Event_WeaponFire);
  }
  return Plugin_Continue;
}

public void Event_WeaponFire(Event event, const char[] name, bool dontBroadcast)
{
  if(!bRPP) return;

  int client = GetClientOfUserId(GetEventInt(event, "userid"));
  if(!IsAliveSurvivor(client) )
    return;

  if(counter[client] >= iTick )
    return;
  char sWeapon[32];
  event.GetString("weapon", sWeapon, sizeof(sWeapon) );
  if(strcmp(sWeapon, "melee") == 0)
  {
    SU_SetSpeed(client, SPEED_RUN, 150.0);
/*
    exhaust[client] = exhaust[client] + (iTick * 3);
    if(exhaust[client] >= (30 * iTick) )
    {
      SU_AddExhaust(client, 600);
      SU_SetSpeed(client, SPEED_RUN, 115.0);
      exhaust[client] = 0;
      counter[client] = -1;
    }
*/
    counter[client] = iTick;
  }
}

void CvarChange(Handle convar, const char[] oldValue, const char[] newValue)
{
  iTick = hTick.IntValue;
  bRPP = hRPP.BoolValue;
  if(!bRPP)
  {
      for(int i=0; i<= MaxClients+1; i++)
      {
          counter[i] = 0;
          exhaust[i] = 0;
        }
    }
}

void rpp_OnClientPutInServer(int client)
{
  SDKHook(client, SDKHook_WeaponSwitchPost, rpp_OnWeaponSwitch);
}

void rpp_OnClientDisconnect(int client)
{
  counter[client] = 0;
  exhaust[client] = 0;
  SDKUnhook(client, SDKHook_WeaponSwitchPost, rpp_OnWeaponSwitch);
}

Action rpp_OnWeaponSwitch(int client)
{
  if(!IsAliveSurvivor(client) )
    return Plugin_Continue;

  if(!bRPP)  return Plugin_Continue;
  //int Limit = RoundToNearest(iTick * 1.5);
  int Limit = iTick;
  if(counter[client] < Limit)
    counter[client] = Limit;
  
  SU_SetSpeed(client, SPEED_RUN, 115.0);
 
  return Plugin_Continue;
}

void rpp_OnClientRunCmd(int client, int buttons)
{
  if(!IsAliveSurvivor(client) )
  {
    exhaust[client] = 0;
    counter[client] = 0;
    return;
  }

  if(buttons & IN_JUMP)
  {
    counter[client] = iTick;
    SU_SetSpeed(client, SPEED_RUN, 115.0);
  }
//  if(!bRPP) return;
  if(exhaust[client] > 0)
    exhaust[client]--;

  if(counter[client] < 1)
    return;

  counter[client]--;
  if(counter[client] == 0)
  {
      SU_SetSpeed(client, SPEED_RUN, 220.0);
    }
}
/*
public void SU_OnExhaustEnd(int client)
{
  SU_SetSpeed(client, SPEED_RUN, 220.0);  
  counter[client] = 0;
}
*/
