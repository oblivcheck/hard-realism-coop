#include <sourcemod>
#include <sdkhooks>
#include <sdktools>
#include <left4dhooks>

#define PLUGIN_NAME       "Gamemode: Realism++"
#define PLUGIN_DESCRIPTION    "Realism++"
#define PLUGIN_VERSION      "1.3.22c"
#define PLUGIN_AUTHOR       "oblivcheck"
#define PLUGIN_URL        "https://github.com/oblivcheck/hard-realism-coop/"

public Plugin:myinfo =
{
  name = PLUGIN_NAME,
  author = PLUGIN_AUTHOR,
  description = PLUGIN_DESCRIPTION,
  version = PLUGIN_VERSION,
  url = PLUGIN_URL
}

ConVar  hCvarModeEnable;
bool  g_bModeEnable;

ConVar  g_hCIDMG_Multi;
float  g_fCIDMG_Multi;

ConVar  g_hCIDMG_Multi_Incap;
float  g_fCIDMG_Multi_Incap;

ConVar  g_hTankHP_Multi;
float  g_fTankHP_Multi;

ConVar  g_hBotFF;
bool  g_bBotFF;

ConVar  hAi;
bool  bAi;
ConVar hDynJump;
bool bDynJump;

ConVar  hWam;
bool  bWam;

public void OnPluginStart()
{
  //https://forums.alliedmods.net/showthread.php?t=337799
  CreateConVar("mat_hdr_manual_tonemap_rate", "1.0", "", FCVAR_NONE);

  hCvarModeEnable = CreateConVar("rc_gamemode_realism_enable", "0");  
  g_hCIDMG_Multi = CreateConVar("rc_gamemode_realism_cidmg", "1.0");
  g_hCIDMG_Multi_Incap = CreateConVar("rc_gamemode_realism_cidmg_incap", "0.75");
  g_hTankHP_Multi = CreateConVar("rc_gamemode_realism_tankhp", "2.0");
  g_hBotFF = CreateConVar("rc_gamemode_realism_bot_friendly_fire", "0");

  g_bModeEnable = hCvarModeEnable.BoolValue;
  g_fCIDMG_Multi = g_hCIDMG_Multi.FloatValue;
  g_fCIDMG_Multi_Incap = g_hCIDMG_Multi_Incap.FloatValue;
  g_fTankHP_Multi = g_hTankHP_Multi.FloatValue;
  g_bBotFF = g_hBotFF.BoolValue;

  g_hCIDMG_Multi.AddChangeHook(Event_ConVarChanged);
  g_hCIDMG_Multi_Incap.AddChangeHook(Event_ConVarChanged);
  hCvarModeEnable.AddChangeHook(Event_ConVarChanged);
  g_hTankHP_Multi.AddChangeHook(Event_ConVarChanged);
  g_hBotFF.AddChangeHook(Event_ConVarChanged);

  //暂时这样了
  hAi = CreateConVar("rc_gamemode_realism_ai", "0");  
  bAi = hAi.BoolValue;
  hAi.AddChangeHook(Event_ConVarChanged);
  hDynJump = CreateConVar("rc_gamemode_realism_dynjump", "0");  
  bDynJump = hAi.BoolValue;
  hDynJump.AddChangeHook(Event_ConVarChanged);


  HookEvent("round_start", Event_RoundStart, EventHookMode_PostNoCopy);

  RegPluginLibrary("rc_gamemode_realism");
}

/*
Action tDelayUnloadPlugin(Handle Timer)
{
  if(!bAi)
  {
  PrintToServer("\n %s : 延迟卸载指定插件\n", PLUGIN_NAME);

  ServerCommand("sm plugins unload l4d2_sb_ai_improver");  
  }
  return Plugin_Continue;  
}
*/
public void Event_ConVarChanged(ConVar convar, const char[] oldValue, const char[] newValue){
    ApplyCvars();
}

bool old_g_bModeEnable;

char  g_sCvar_old_gamemode[32];
char  g_sCvar_old_difficulty[32];

ConVar  g_hBot_die_first;

bool  g_bBot_die_first;
bool  g_bBot_die_pills;
float  g_fBot_first;
float  g_fBot_pills;

public void ApplyCvars()
{
  old_g_bModeEnable = g_bModeEnable;
  g_bModeEnable = hCvarModeEnable.BoolValue
  g_fCIDMG_Multi = g_hCIDMG_Multi.FloatValue;
  g_fCIDMG_Multi_Incap = g_hCIDMG_Multi_Incap.FloatValue;
  g_fTankHP_Multi = g_hTankHP_Multi.FloatValue;
  g_bBotFF = g_hBotFF.BoolValue;
  bAi = hAi.BoolValue;
  bDynJump = hDynJump.BoolValue;
  if(bDynJump)
   ServerCommand("sm plugins load l4d2_dynamic_jump"); 
  else  ServerCommand("sm plugins unload l4d2_dynamic_jump");

  if(g_bModeEnable && !old_g_bModeEnable)
  {
    PrintToServer("\n #%s# 变量变更，开始设置...",  PLUGIN_NAME);
    ServerCommand("sm_cvar tongue_break_from_damage_amount 250");
    ServerCommand("sm_cvar smoker_tongue_delay 0.1");
    ServerCommand("sm_cvar boomer_exposed_time_tolerance 1000.0");
    ServerCommand("sm_cvar boomer_vomit_delay 0.1");
    ServerCommand("sm_cvar z_charger_health 900");
    ServerCommand("sm_cvar tongue_health 200");
    ServerCommand("sm_cvar tongue_range 900");
    ServerCommand("sm_cvar z_hunter_health 350");
    ServerCommand("sm_cvar z_jockey_health 500");


    //削弱推挤
    //g_bNerfShove = true;
    ServerCommand("sm_cvar z_gun_swing_duration 0.15");
    ServerCommand("sm_cvar z_gun_swing_interval 0.75");
    ServerCommand("sm_cvar z_gun_swing_vs_max_penalty 4");
    ServerCommand("sm_cvar z_gun_swing_vs_min_penalty 1");
    ServerCommand("sm_cvar z_gun_swing_vs_restore_time 6.0");
    ServerCommand("sm_cvar z_jockey_leap_range 1000");
    //ServerCommand("sm_cvar ");

    ServerCommand("sm_cvar l4d_si_ability_enabled \"1\"");
    ServerCommand("sm_cvar l4d_si_ability_shove \"18\"");

    ServerCommand("sm_cvar z_speed \"300\"");
    ServerCommand("sm_cvar rc_asdl_enable \"0\"");
    ServerCommand("sm_cvar l4d2_lj_enabled 1");
    ServerCommand("sm plugins load l4d_wam");
    ServerCommand("sm_cvar rc_gamemode_realism_dynjump 1");

    ServerCommand("idle_antispam 1");
    ServerCommand("sm_cvar director_afk_timeout 20");
    HookEvent("tank_spawn", Event_Tank_Spawn);
    HookEvent("witch_spawn", Event_Witch_Spawn);
    HookEvent("witch_killed", WitchPanic_Event);
    HookEvent("witch_harasser_set", WitchPanic_Harasse_Event);
    HookEvent("weapon_fire", Event_WeaponFire);

    for(int i=1;i<MaxClients;i++)
    {
      if(IsClientInGame(i) && GetClientTeam(i) == 2)
      SDKHook(i, SDKHook_OnTakeDamage, eOnTakeDamage);
    }
    //L4D2_SetFloatWeaponAttribute("weapon_pistol_magnum", L4D2FWA_CycleTime, 0.45);  
    ServerCommand("sm_cvar Survivor_incapacitated_cycle_time \"0.45\"");
    //与自动射击插件配合，用于降低出现动画&特效错误的概率
    ServerCommand("sm_cvar wh_use_incap_cycle_cvar \"0\"");
    ServerCommand("sm_cvar wh_double_pistol_cycle_rate \"1\"");
    ServerCommand("sm_cvar wh_deploy_animation_speed \"0\"");

    //L4D2_SetFloatWeaponAttribute("weapon_pistol", L4D2FWA_CycleTime, 0.275);  
    //L4D2_SetFloatWeaponAttribute("weapon_pistol_magnum", L4D2FWA_CycleTime, 0.45);  

    //L4D2_SetFloatWeaponAttribute("weapon_rifle_ak47", L4D2FWA_CycleTime, 0.1);
    L4D2_SetIntWeaponAttribute("weapon_rifle", L4D2IWA_Damage, 38);
    L4D2_SetIntWeaponAttribute("weapon_rifle_sg552", L4D2IWA_Damage, 38);

    GetConVarString(FindConVar("mp_gamemode"), g_sCvar_old_gamemode, sizeof(g_sCvar_old_gamemode) );
    GetConVarString(FindConVar("z_difficulty"), g_sCvar_old_difficulty, sizeof(g_sCvar_old_difficulty) );

    ServerCommand("sm_cvar mp_gamemode \"realism\"");
    ServerCommand("sm_cvar z_difficulty \"Impossible\"");
    ServerCommand("sm_cvar sv_vote_issue_change_difficulty_allowed \"0\"");
    //八分之一
    ServerCommand("sm_cvar z_non_head_damage_factor_expert \"0.25\"");
    //友伤
    ServerCommand("sm_cvar survivor_friendly_fire_factor_expert \"1.0\"");
    ServerCommand("sm_cvar z_friendly_fire_forgiveness \"0\"");
    //CI间隔  
    ServerCommand("sm_cvar z_throttle_hit_interval_expert \"0.0\"");
      
    //ServerCommand("sm_cvar l4d2_RealismMagnum_Enabled \"1\"");
    
    ServerCommand("sm_cvar l4d2_fast_melee_fix_enable \"1\"");
    ServerCommand("sm_cvar l4d_wam_enabled \"1\"");
    //bDynJump = false;
    //ServerCommand("sm plugins unload l4d2_dynamic_jump");
 
    ServerCommand("sm_cvar l4d_god_frames_allow \"1\"");  

    ServerCommand("sm_cvar survivor_incap_decay_rate  \"1\"");  
    ServerCommand("sm_cvar z_tank_autoshotgun_dmg_scale  \"1.0\"");  
    ServerCommand("sm_cvar tank_burn_duration_expert \"170\"");  
    ServerCommand("sm_cvar tank_stuck_time_suicide \"60\"");  
    
    ServerCommand("sm_cvar z_shotgun_bonus_damage_range \"50\"");  
    ServerCommand("sm_cvar survivor_damage_speed_factor \"0.3f\"");  

    ServerCommand("sm_cvar upgrade_laser_sight_spread_factor \"0.85\"");
    ServerCommand("sm_cvar l4d_weapon_auto_fire_enable \"1\"");
    ServerCommand("sm_cvar rc_dsp_enable \"1\"");
  
    g_hBot_die_first = FindConVar("l4d_bot_healing_die_first");
    //只是为了确定插件存不存在
    if(g_hBot_die_first != null)
    {
      g_bBot_die_first = GetConVarBool(FindConVar("l4d_bot_healing_die_first"));
      g_bBot_die_pills = GetConVarBool(FindConVar("l4d_bot_healing_die_pills"));
      g_fBot_first = GetConVarFloat(FindConVar("l4d_bot_healing_first"));
      g_fBot_pills = GetConVarFloat(FindConVar("l4d_bot_healing_pills"));

      ServerCommand("sm_cvar l4d_bot_healing_die_first \"1\"");
      ServerCommand("sm_cvar l4d_bot_healing_die_pills \"0\"");
      ServerCommand("sm_cvar l4d_bot_healing_first \"50.0\"");
      ServerCommand("sm_cvar l4d_bot_healing_pills \"50.0\"");
    }
    ServerCommand("sm_cvar hrc_zed_time_enable \"1\"");
    CreateTimer(0.5, tSenMSG1);
  }
  else if(!g_bModeEnable && old_g_bModeEnable)
  {  
    PrintToServer("\n #%s# 变量变更，撤销设置...",  PLUGIN_NAME);
    ServerCommand("sm_cvar tongue_break_from_damage_amount 50");
    ServerCommand("sm_cvar smoker_tongue_delay 1.5");
    ServerCommand("sm_cvar boomer_exposed_time_tolerance 1.0");
    ServerCommand("sm_cvar boomer_vomit_delay 1.0");
    ServerCommand("sm_cvar z_charger_health 600");
    ServerCommand("sm_cvar tongue_health 100");
    ServerCommand("sm_cvar tongue_range 750");
    ServerCommand("sm_cvar z_hunter_health 250");
    ServerCommand("sm_cvar z_jockey_health 325");


    //g_bNerfShove = false;
    ServerCommand("sm_cvar z_gun_swing_duration 0.2");
    ServerCommand("sm_cvar z_gun_swing_interval 0.7");
    ServerCommand("sm_cvar z_gun_swing_vs_max_penalty 6");
    ServerCommand("sm_cvar z_gun_swing_vs_min_penalty 3");
    ServerCommand("sm_cvar z_gun_swing_vs_restore_time 4.0");
    ServerCommand("sm_cvar rc_gamemode_realism_dynjump 0")
  
    //  ServerCommand("sm_cvar hunter_pounce_ready_range 1000");
    //  ServerCommand("sm_cvar hunter_committed_attack_range 10000");
    //  ServerCommand("sm_cvar hunter_leap_away_give_up_range 0");
    //  ServerCommand("sm_cvar hunter_pounce_max_loft_angle 0");
    //  ServerCommand("sm_cvar z_pounce_damage_interrupt 150");
    ServerCommand("sm_cvar z_jockey_leap_range 200");

    ServerCommand("sm_cvar l4d_si_ability_enabled \"0\"");
    ServerCommand("sm_cvar z_speed \"250\"");
    ServerCommand("sm_cvar rc_asdl_enable \"0\"");
    ServerCommand("sm_cvar l4d2_lj_enabled 0");
    ServerCommand("sm_cvar director_afk_timeout 45")
    ServerCommand("idle_antispam 0");
    ServerCommand("sm plugins unload l4d_wam");
    // 这是什么操作？
    if(!g_bModeEnable && old_g_bModeEnable)
    {
      UnhookEvent("witch_spawn", Event_Witch_Spawn);
      UnhookEvent("tank_spawn", Event_Tank_Spawn);
      UnhookEvent("witch_killed", WitchPanic_Event);
      UnhookEvent("witch_harasser_set", WitchPanic_Harasse_Event);
      UnhookEvent("weapon_fire", Event_WeaponFire)
    }
    for(int i=1;i<MaxClients;i++)
    {
      if(IsClientInGame(i) && GetClientTeam(i) == 2)
      SDKUnhook(i, SDKHook_OnTakeDamage, eOnTakeDamage);
    }
    //  L4D2_SetFloatWeaponAttribute("weapon_pistol_magnum", L4D2FWA_CycleTime, 0.3);  
    ServerCommand("sm_cvar survivor_incapacitated_cycle_time \"0.3\"");
    ServerCommand("sm_cvar wh_use_incap_cycle_cvar \"1\"");
    ServerCommand("sm_cvar wh_double_pistol_cycle_rate \"0\"");
    //防止干扰速砍
    ServerCommand("sm_cvar wh_deploy_animation_speed \"-1\"");

    L4D2_SetFloatWeaponAttribute("weapon_pistol", L4D2FWA_CycleTime, 0.175);  

    //  L4D2_SetFloatWeaponAttribute("weapon_rifle_ak47", L4D2FWA_CycleTime, 0.1);
    L4D2_SetIntWeaponAttribute("weapon_rifle", L4D2IWA_Damage, 33);
    L4D2_SetIntWeaponAttribute("weapon_rifle_sg552", L4D2IWA_Damage, 33);

    L4D2_SetIntWeaponAttribute("weapon_sniper_awp", L4D2IWA_Damage, 120);
    L4D2_SetIntWeaponAttribute("weapon_sniper_scout", L4D2IWA_Damage, 100);
    L4D2_SetIntWeaponAttribute("weapon_hunting_rifle", L4D2IWA_Damage, 50);
    //最好检查这个
    //  L4D2_SetFloatWeaponAttribute("weapon_pumpshotgun", L4D2FWA_PenetrationMaxDist, 1);
    //  L4D2_SetFloatWeaponAttribute("weapon_pumpshotgun", L4D2FWA_CharPenetrationMaxDist, 1);


    SetConVarString(FindConVar("mp_gamemode"), g_sCvar_old_gamemode);
    SetConVarString(FindConVar("z_difficulty"), g_sCvar_old_difficulty);

    ServerCommand("sm_cvar mp_gamemode \"%s\"", g_sCvar_old_gamemode);
    ServerCommand("sm_cvar z_difficulty \"%s\"", g_sCvar_old_difficulty);
    ServerCommand("sm_cvar sv_vote_issue_change_difficulty_allowed \"1\"");
    //八分之一
    ServerCommand("sm_cvar z_non_head_damage_factor_expert \"0.5\"");
    //友伤
    ServerCommand("sm_cvar survivor_friendly_fire_factor_expert \"0.5\"");
    ServerCommand("sm_cvar z_friendly_fire_forgiveness \"1\"");
    //CI间隔  
    ServerCommand("sm_cvar z_throttle_hit_interval_expert \"1.0\"");
      
    //  ServerCommand("sm_cvar l4d2_RealismMagnum_Enabled \"0\"");

    // 修正一个cvas名称错误  
    ServerCommand("sm_cvar l4d2_fast_melee_fix_enable \"0\"");
    
    ServerCommand("sm_cvar l4d_wam_enabled \"0\"");
    
    ServerCommand("sm_cvar survivor_incap_decay_rate  \"4\"");  
    ServerCommand("sm_cvar z_tank_autoshotgun_dmg_scale  \"0.85\"");  
    ServerCommand("sm_cvar tank_burn_duration_expert \"85\"");  
    ServerCommand("sm_cvar tank_stuck_time_suicide \"10\"");  
    
    ServerCommand("sm_cvar z_shotgun_bonus_damage_range \"100\"");  
    ServerCommand("sm_cvar survivor_damage_speed_factor \"0.25f\"");  

    ServerCommand("sm_cvar upgrade_laser_sight_spread_factor \"0.4\"");
    ServerCommand("sm_cvar l4d_weapon_auto_fire_enable \"0\"");
    ServerCommand("sm_cvar rc_dsp_enable \"0\"");

    g_hBot_die_first = FindConVar("l4d_bot_healing_die_first");
    //只是为了确定插件存不存在
    if(g_hBot_die_first != null)
    {
      ServerCommand("sm_cvar l4d_bot_healing_die_first \"%d\"", g_bBot_die_first);
      ServerCommand("sm_cvar l4d_bot_healing_die_pills \"%d\"", g_bBot_die_pills);
      ServerCommand("sm_cvar l4d_bot_healing_first \"%f\"", g_fBot_first);
      ServerCommand("sm_cvar l4d_bot_healing_pills \"%f\"", g_fBot_pills);
    }
    ServerCommand("sm_cvar hrc_zed_time_enable \"0\"");
    CreateTimer(0.5, tSenMSG2);
  }
}
Action tSenMSG1(Handle Timer)
{
  PrintToChatAll("所有设置已经完成，重新开始回合以使特定功能生效.");  
  ServerCommand("sm_slay @all");

  return Plugin_Continue;
}
Action tSenMSG2(Handle Timer)
{
  PrintToChatAll("所有变化已经撤销，重新开始回合以完成设置.");
  ServerCommand("sm_slay @all");
  return Plugin_Continue;
}
public void OnClientPutInServer(iClient)
{
  if(g_bModeEnable)
  SDKHook(iClient, SDKHook_OnTakeDamage, eOnTakeDamage);
  if(0< iClient <= MaxClients)
  {
    if(IsFakeClient(iClient) )  return;
    if(!bDynJump)
    {
      PrintToServer("\n%s: 卸载默认不启用的插件", PLUGIN_NAME);
      ServerCommand("sm plugins unload l4d2_dynamic_jump");
    }
    if(!bAi)
    {
      PrintToServer("\n%s: 卸载默认不启用的插件", PLUGIN_NAME);
      ServerCommand("sm plugins unload l4d2_sb_ai_improver");
    }

    hWam = FindConVar("l4d_wam_enabled");  
    if(hWam != null)
      bWam = hWam.BoolValue;
    else  return;
    if(!bWam)
    {
      PrintToServer("\n%s: 卸载默认不启用的插件", PLUGIN_NAME);
      ServerCommand("sm plugins unload l4d_wam");  
    }
  }
}

public Action eOnTakeDamage(int iVictim, int &iAttacker, int &iInflictor, float &fDamage, int &iDamagetype, int &weapon, float damageForce[3], float damagePosition[3])
{
  if(iAttacker < 1)  return Plugin_Continue;

  if(fDamage == 0.0)  return Plugin_Continue;

  if( 0 < iVictim < MaxClients )
  {
    if( iAttacker > MaxClients)
    {
      if(GetClientTeam(iVictim) == 2)  
      {
        char sClassName[32];
        GetEntityClassname(iAttacker, sClassName, sizeof(sClassName));
        if(strcmp(sClassName, "infected", false) == 0)
        {
          if(L4D_IsPlayerIncapacitated(iVictim) )
          fDamage = fDamage * g_fCIDMG_Multi_Incap;
          else  fDamage = fDamage * g_fCIDMG_Multi;
          return Plugin_Changed;
        }
      }
    }
    // 要追加友军伤害?
    if(iAttacker < MaxClients)
    {
      if(GetClientTeam(iVictim) != 2) return Plugin_Continue;
      // Charger
      if(GetClientTeam(iAttacker) == 3) {
        if(GetEntProp(iAttacker, Prop_Send, "m_zombieClass") == 6) {
          fDamage = fDamage * 2.0;
          return Plugin_Changed;
        }
      }
      if(IsValidEntity(weapon) && weapon > 0)  
      {
        if(!g_bBotFF && IsFakeClient(iVictim) ) return Plugin_Handled;
        // 也许加上fDamage == 0.0 就不需要检查了
        if(GetClientTeam(iAttacker) == 2 && !IsFakeClient(iAttacker) )
        {
          char weaponName[32];
          GetEntityClassname(weapon, weaponName, sizeof(weaponName));
          if(strcmp(weaponName, "weapon_melee") == 0.0) 
          {
            fDamage = 1000.0; 
            return Plugin_Changed;
          }  
          if(strcmp(weaponName, "weapon_pistol_magnum") == 0)
          {
            fDamage = 100.0;
            return Plugin_Changed;
          }  
        }
      }
    }
  }
  return Plugin_Continue;
}

void Event_Tank_Spawn(Event event, const char[] name, bool dontBroadcast)
{
  int index = event.GetInt("tankid");
//  int health = GetClientHealth(index)
  SDKHook(index, SDKHook_OnTakeDamage, eTank_OnTakeDamage);
//  SetEntProp(index, Prop_Send, "m_iHealth", health * 2);
  
//  PrintToChatAll("Tank:%d", health);
//  导演Tank刚生成时的生命值似乎是固定的，下一帧才会被设置
  RequestFrame(SetTankHP, index);
}
public Action eTank_OnTakeDamage(int iVictim, int &iAttacker, int &iInflictor, float &fDamage, int &iDamagetype, int &weapon, float damageForce[3], float damagePosition[3])
{
  //Melee
  if(weapon < 0 || !IsValidEntity(weapon))  return Plugin_Continue;
  
  if(0 < iAttacker < MaxClients)
  {
  if(GetClientTeam(iAttacker) == 2)
  {
    char weaponName[32];
    GetEntityClassname(weapon, weaponName, sizeof(weaponName));
    if(strcmp(weaponName, "weapon_melee") == 0)
    {
    // 实际上Tank Meele伤害不是硬编码的1/20，所以这里的设置实际上是1/80?
    fDamage = fDamage  / 2;
//    PrintToChatAll("Tank:%f Hp%d", fDamage,GetClientHealth(iVictim))
    }
    if(StrContains(weaponName, "shotgun") != -1)
    {
//    PrintToChatAll("shotgun");
    fDamage = fDamage * 0.7;
    }
    return Plugin_Changed;  
  }
  }
  return Plugin_Continue;
}
void SetTankHP(any index)
{
  if(!IsValidEntity(index) )  return;
  int health = GetClientHealth(index)
//  PrintToChatAll("After Tank:%d Multi:%f, HP:%d", GetClientHealth(index), g_fTankHP_Multi, health );
  SetEntProp(index, Prop_Send, "m_iHealth", RoundToFloor(health * g_fTankHP_Multi) );
  
//  PrintToChatAll("After Tank:%d Multi:%f, HP:%d", GetClientHealth(index), g_fTankHP_Multi, health );  
}

void Event_Witch_Spawn(Event event, const char[] name, bool dontBroadcast)
{
  int index = event.GetInt("witchid");
  SDKHook(index, SDKHook_OnTakeDamage, eWitch_OnWitchDamage);
}
public Action eWitch_OnWitchDamage(int iVictim, int &iAttacker, int &iInflictor, float &fDamage, int &iDamagetype, int &weapon, float damageForce[3], float damagePosition[3])
{
  if(weapon < 0 || !IsValidEntity(weapon))  return Plugin_Continue;
  
  if(0 < iAttacker < MaxClients)
  {
  if(GetClientTeam(iAttacker) == 2)
  {
    char weaponName[32];
    GetEntityClassname(weapon, weaponName, sizeof(weaponName));
    if(strcmp(weaponName, "weapon_melee") == 0)
    {
    fDamage = fDamage  * 0.8;
    }
    return Plugin_Changed;  
  }
  }
  return Plugin_Continue;
}

#define PANIC_SOUND "npc/mega_mob/mega_mob_incoming.wav"
public void OnMapStart()
{
  PrecacheSound(PANIC_SOUND, true);
  LoadVScript();
}

// 由于投票会重启回合，所以我们不需要在投票时手动加载
void LoadVScript(bool vote=false)
{
  if(g_bModeEnable || vote)
  {
    PrintToServer("\n正在加载 Realism++ VScript\n");
    int flag = GetCommandFlags("script_execute");
    if(flag != INVALID_FCVAR_FLAGS)
    {
      if(flag & FCVAR_CHEAT)
      {
        SetCommandFlags("script_execute", flag & ~FCVAR_CHEAT);
        PrintToServer("正在执行 Realism++ VScript\n");

        ServerCommand("script_execute rpp/manacat_tank");
        ServerCommand("script_execute rpp/manacat_hunter");
        ServerCommand("script_execute rpp/paicdevlos_");
        ServerCommand("script_execute rpp/spitfix");

        ServerExecute();
        RequestFrame(rDelay, flag);
      }
    }
  }
}

void rDelay(int flag)
{
  SetCommandFlags("script_execute", flag | FCVAR_CHEAT);
}

Action WitchPanic_Event(Event event, const char[] name, bool dontBroadcast)
{
  CreateTimer(3.0, PanicEvent, TIMER_FLAG_NO_MAPCHANGE);
  return Plugin_Continue;
}
Action WitchPanic_Harasse_Event(Event event, const char[] name, bool dontBroadcast)
{
  CreateTimer(3.0, PanicEvent, TIMER_FLAG_NO_MAPCHANGE);
  return Plugin_Continue;
}

Action PanicEvent(Handle timer)
{
  EmitSoundToAll(PANIC_SOUND);
  int target = GetAnyClient();
  if(target != -1) SpawntyCommand(target, "z_spawn", "mob auto");
  return Plugin_Stop;
}

stock void SpawntyCommand(int client, char[] command, char[] arguments = "")
{
  if (client)
  {
    int flags = GetCommandFlags(command);
    SetCommandFlags(command, flags & ~FCVAR_CHEAT);
    FakeClientCommand(client, "%s %s", command, arguments);
    SetCommandFlags(command, flags);
  }
}

int GetAnyClient()
{
  for (int target = 1; target <= MaxClients; target++)
  {
    if (IsClientInGame(target)) return target;
  }
  return -1;
}

public Action L4D_OnFirstSurvivorLeftSafeArea(int client) {
  CreateTimer( 2.0, Timer_ForceInfectedAssault, _, TIMER_REPEAT | TIMER_FLAG_NO_MAPCHANGE );
  return Plugin_Continue;
}

public Action Timer_ForceInfectedAssault( Handle timer ) {
  if(!g_bModeEnable) return Plugin_Continue;
  CheatServerCommand("nb_assault");
  return Plugin_Continue;
}

stock void CheatServerCommand(char[] command)
{
  int flags = GetCommandFlags(command);
  SetCommandFlags(command, flags & ~FCVAR_CHEAT);
  ServerCommand("%s", command);
  ServerExecute();
  SetCommandFlags(command, flags);
}

public void Event_WeaponFire(Event event, const char[] name, bool dontBroadcast)
{
  int client = GetClientOfUserId(GetEventInt(event, "userid"));
  char sWeapon[32];
  event.GetString("weapon", sWeapon, sizeof(sWeapon) );
  if(strcmp(sWeapon, "melee") == 0)
    SetEntProp(client, Prop_Send, "m_iShovePenalty", 6);
}

public void Event_RoundStart(Event event, const char[] name, bool dontBroadcast)
{
  LoadVScript();
}

