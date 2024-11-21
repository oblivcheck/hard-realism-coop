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

int run_timemax, run_timemin;
int counter[MAXPLAYERS+1];
// 看上去原插件这个功能有些问题
int exhaust[MAXPLAYERS+1];
int run[MAXPLAYERS+1][3];
// 跟踪玩家的sm_rpp_run状态
int manual[MAXPLAYERS+1];

void rpp_start()
{
  hTick = FindConVar("sv_minupdaterate");
  iTick = hTick.IntValue;
  CreateTimer(3.0, tDelay);
  RegConsoleCmd("sm_rpp_run", cmd_run);
}
public Action cmd_run(int client, int args)
{
  if(!bRPP)
    return Plugin_Continue;

  if(!IsAliveSurvivor(client))
    return Plugin_Continue;

  if( GetClientRealHealth(client) >= 40 && !L4D_IsPlayerIncapacitated(client) )
  {
    // 针对场景：持续按住rpp_run1
    if(manual[client] == 0)
      manual[client] = 1
    else manual[client] = 0;

    //PrintToChatAll("%d %d", run[client][1], run[client][2]);
    if(run[client][0] == 0 && manual[client] == 1)
    {
      if(run[client][1] > run_timemin)
        run[client][0] = 1;
    }
    else
    {
      SU_SetSpeed(client, SPEED_RUN, 150.0);
      run[client][0] = 0;
    }
  }
  return Plugin_Continue;
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

  hTick.AddChangeHook(CvarChange);

  run_timemax = iTick * 15;
  run_timemin = iTick * 3;
 
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
    SU_SetSpeed(client, SPEED_RUN, 100.0);
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
  run[client][0] = 0;
  run[client][1] = run_timemax
  run[client][2] = 0;
 
  SDKHook(client, SDKHook_WeaponSwitchPost, rpp_OnWeaponSwitch);
}

void rpp_OnClientDisconnect(int client)
{
  run[client][0] = 0;
  run[client][1] = run_timemax
  run[client][2] = 0;
  manual[client] = 0;
  
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
 
//  SU_SetSpeed(client, SPEED_RUN, RoundToNearest(SU_GetSpeed(client, SPEED_RUN) * 0.9) ) ;
 
  SU_SetSpeed(client, SPEED_RUN, 125.0 ) ;
 
  return Plugin_Continue;
}

void rpp_OnClientRunCmd(int client, int buttons)
{
  if(!bRPP)
    return;
  if(run[client][0] != 0) 
  {
    if(run[client][0] == 1)
      counter[client] = 0;
    // 正在奔跑
    if(run[client][0] == 2)
      run[client][1]--;
    
    if(run[client][1] == 0)
    {
      run[client][0] = 0;
      SU_SetSpeed(client, SPEED_RUN, 150.0); 
    }
    // 想要奔跑
    if(run[client][0] == 1)
    {
      run[client][0] = 2;
      SU_SetSpeed(client, SPEED_RUN, 220.0);
    }
    return
  }

  if(run[client][1] < run_timemax)
  {
    run[client][2]++;
    if(run[client][2] == 2)
    {
      run[client][1]++;
      run[client][2]=0;
    }
  }

  if(!IsAliveSurvivor(client) )
  {
    exhaust[client] = 0;
    counter[client] = 0;
    run[client][0] = 0;
    run[client][1] = run_timemax;
    run[client][2] = 0;

    return;
  }

  if(buttons & IN_JUMP)
  {
    // 考虑静步，这里实际上需要已经被减速才会触发
    counter[client] = iTick;
  }
//  if(!bRPP) return;
  if(exhaust[client] > 0)
    exhaust[client]--;

  if(counter[client] < 1)
    return;

  counter[client]--;
  if(counter[client] == 0)
  {
      SU_SetSpeed(client, SPEED_RUN, 150.0);
    }
}
/*
public void SU_OnExhaustEnd(int client)
{
  SU_SetSpeed(client, SPEED_RUN, 220.0);  
  counter[client] = 0;
}
*/

/**
* @brief Will return a survivors health, including also the temporal health.
*
* @client            Client index to retrieve the health from.
*
* @return            Returns the client's health as an integer.
* @error             Will return -1 if there was any problem.
*/
//https://forums.alliedmods.net/showthread.php?t=315826
stock GetClientRealHealth(client)
{
    //First filter -> Must be a valid client, successfully in-game and not an spectator (The dont have health).
    if(!client
    || !IsValidEntity(client)
    || !IsClientInGame(client)
    || !IsPlayerAlive(client)
    || IsClientObserver(client))
    {
        return -1;
    }

    //If the client is not on the survivors team, then just return the normal client health.
    if(GetClientTeam(client) != 2)
    {
        return GetClientHealth(client);
    }

    //First, we get the amount of temporal health the client has
    new Float:buffer = GetEntPropFloat(client, Prop_Send, "m_healthBuffer");

    //We declare the permanent and temporal health variables
    new Float:TempHealth;
    new PermHealth = GetClientHealth(client);

    //In case the buffer is 0 or less, we set the temporal health as 0, because the client has not used any pills or adrenaline yet
    if(buffer <= 0.0)
    {
        TempHealth = 0.0;
    }

    //In case it is higher than 0, we proceed to calculate the temporl health
    else
    {
        //This is the difference between the time we used the temporal item, and the current time
        new Float:difference = GetGameTime() - GetEntPropFloat(client, Prop_Send, "m_healthBufferTime");

        //We get the decay rate from this convar (Note: Adrenaline uses this value)
        new Float:decay = GetConVarFloat(FindConVar("pain_pills_decay_rate"));

        //This is a constant we create to determine the amount of health. This is the amount of time it has to pass
        //before 1 Temporal HP is consumed.
        new Float:constant = 1.0/decay;

        //Then we do the calcs
        TempHealth = buffer - (difference / constant);
    }

    //If the temporal health resulted less than 0, then it is just 0.
    if(TempHealth < 0.0)
    {
        TempHealth = 0.0;
    }

    //Return the value
    return RoundToFloor(PermHealth + TempHealth);
}
