// -------------------------------------
//  尽可能的阻止通过跳跃来秒杀常见感染者
// --------------------------------------  

#define MAXENTITY 2048

int   g_ijumpCount[MAXPLAYERS+1];
float g_fjumpTimer[MAXPLAYERS+1];
bool  g_bAllowStumble[MAXPLAYERS+1]
bool  g_bRocketJumpExploit[MAXENTITY+1]

public void OnConfigsExecuted()
{
	for(int i = 1; i <= MAXPLAYERS - 1; i++)
	{
		g_ijumpCount[i] = 0;
		g_fjumpTimer[i] = 0.00;
	}
}

public void OnClientConnected(int client)
{
	g_ijumpCount[client] = 0;	
	g_fjumpTimer[client] = 0.00;
	g_bAllowStumble[client] = false;
}

public Action OnPlayerRunCmd(int client)
{
  if(IsClientInGame(client) && GetClientTeam(client) != 1 && IsPlayerAlive(client))
  {
    if(IsFakeClient(client)) return Plugin_Continue;
    int entity = GetEntPropEnt(client, Prop_Data, "m_hGroundEntity");
    if (entity > MaxClients && g_bRocketJumpExploit[entity])
    {
      if(!g_bAllowStumble[client])
      {
        int userid = GetClientUserId(client);
        static float vPos[3];
        StaggerClient(userid, vPos);
        g_bAllowStumble[client] = true;
        CreateTimer(0.5, tStumbleTimer, client)
      }
    }
  }
  return Plugin_Continue;
}

public void OnEntityCreated(int entity, const char[] classname)
{
	if(MaxClients < entity && entity < 2048)
	{
		if(IsValidEntity(entity) )
		{
			if(!strcmp(classname, "infected", false) )
			{
        SDKHook(entity, SDKHook_OnTakeDamage, OnTakeDamage_Infected)
        g_bRocketJumpExploit[entity] = true;
			}	
		}
	}
}

public void OnEntityDestroyed(int entity)
{
  if (!IsValidEntityIndex(entity))
    return;

  g_bRocketJumpExploit[entity] = false;
}

Action OnTakeDamage_Infected(int victim, int& attacker, int& inflictor, float& damage, int& damagetype, int& weapon, float damageForce[3], float damagePosition[3])
{
  if(weapon != -1)	return Plugin_Continue;
  if(damage != 50.00)        return Plugin_Continue;
  if(attacker > MaxClients || !attacker)
    return Plugin_Continue;
  if(GetClientTeam(attacker) != 2)
    return Plugin_Continue;

  if(damagetype & DMG_CLUB)
  {
    if(attacker == inflictor)
    {
      static float test;
      for(int i = 0; i< 3; i++)
      {test = test + damagePosition[i] + damageForce[i];}

      if(test == 0.0)
      {
        damagetype |= DMG_BUCKSHOT;
        damage = 0.0;
        return Plugin_Changed;
      }			
    }
  }
  return Plugin_Continue;
}

bool IsValidEntityIndex(int entity)
{
    return (MaxClients+1 <= entity <= GetMaxEntities());
}

Action tStumbleTimer(Handle Timer, any attacker)
{
	g_bAllowStumble[attacker] = false;
	return Plugin_Continue;
}

// taken from:
// [L4D & L4D2] Survivor Shove (1.15) [04-Aug-2022]
// https://forums.alliedmods.net/showthread.php?p=2667050
// Author = "Silvers"
//===================================================================================================
//		Stumble Client	
//===================================================================================================
void StaggerClient(int userid, const float vPos[3])
{
        static int iScriptLogic = INVALID_ENT_REFERENCE;
        if(iScriptLogic == INVALID_ENT_REFERENCE || !IsValidEntity(iScriptLogic))
        {
                iScriptLogic = EntIndexToEntRef(CreateEntityByName("logic_script"));
                if(iScriptLogic == INVALID_ENT_REFERENCE || !IsValidEntity(iScriptLogic))
                        LogError("Could not create 'logic_script");

                DispatchSpawn(iScriptLogic);
        }

        char sBuffer[96];
        Format(sBuffer, sizeof(sBuffer), "GetPlayerFromUserID(%d).Stagger(Vector(%d,%d,%d))", userid, RoundFloat(vPos[0]), RoundFloat(vPos[1]), RoundFloat(vPos[2]));
        SetVariantString(sBuffer);
        AcceptEntityInput(iScriptLogic, "RunScriptCode");
        RemoveEntity(iScriptLogic);
}
