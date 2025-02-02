#include <sourcemod>
#include <sdkhooks>
#include <sdktools>
#include <left4dhooks>
#include <rpp/weapon>
#include <rpp/sound>

#define PLUGIN_NAME       "Gamemode: Realism++"
#define PLUGIN_DESCRIPTION    "Realism++"
#define PLUGIN_VERSION      "1.3.27"
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

#define IS_VALID_CLIENT(%1) (%1 > 0 && %1 <= MaxClients)
#define IS_CONNECTED_INGAME(%1) (IsClientConnected(%1) && IsClientInGame(%1))
#define IS_SURVIVOR(%1) (GetClientTeam(%1) == 2)
#define IS_INFECTED(%1) (GetClientTeam(%1) == 3)

#define IS_VALID_INGAME(%1) (IS_VALID_CLIENT(%1) && IS_CONNECTED_INGAME(%1))

#define IS_VALID_SURVIVOR(%1) (IS_VALID_INGAME(%1) && IS_SURVIVOR(%1))
#define IS_VALID_INFECTED(%1) (IS_VALID_INGAME(%1) && IS_INFECTED(%1))

#define IS_SURVIVOR_ALIVE(%1) (IS_VALID_SURVIVOR(%1) && IsPlayerAlive(%1))
#define IS_INFECTED_ALIVE(%1) (IS_VALID_INFECTED(%1) && IsPlayerAlive(%1))

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

int snum[MAXPLAYERS+1];

bool  bAfk;

public void OnPluginStart()
{
  //https://forums.alliedmods.net/showthread.php?t=337799
  CreateConVar("mat_hdr_manual_tonemap_rate", "1.0", "", FCVAR_NONE);

  hCvarModeEnable = CreateConVar("rc_gamemode_realism_enable", "0");  
  g_hCIDMG_Multi = CreateConVar("rc_gamemode_realism_cidmg", "1.0");
  g_hCIDMG_Multi_Incap = CreateConVar("rc_gamemode_realism_cidmg_incap", "0.50");
  g_hTankHP_Multi = CreateConVar("rc_gamemode_realism_tankhp", "2.5");
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
    ServerCommand("sm_cvar rc_gamemode_realism_ai 1");
    ServerCommand("sm plugins load l4d2_sb_ai_improver");

    ServerCommand("sm_cvar tongue_break_from_damage_amount 250");
    ServerCommand("sm_cvar smoker_tongue_delay 0.1");
    ServerCommand("sm_cvar boomer_exposed_time_tolerance 1000.0");
    ServerCommand("sm_cvar boomer_vomit_delay 0.1");
    ServerCommand("sm_cvar z_charger_health 900");
    ServerCommand("sm_cvar tongue_health 200");
    ServerCommand("sm_cvar tongue_range 900");
    ServerCommand("sm_cvar z_hunter_health 350");

    ServerCommand("sm_cvar z_jockey_health 250");
    ServerCommand("sm_cvar z_jockey_area_range_factor 5.0");
    ServerCommand("sm_cvar z_jockey_leap_again_timer 0.5");
    ServerCommand("sm_cvar z_jockey_leap_time 30.0");
    ServerCommand("sm_cvar jockey_pounce_loft_rate 0.0");
    ServerCommand("sm_cvar z_jockey_speed 600");
    ServerCommand("sm_cvar z_jockey_leap_range 1000");
    ServerCommand("sm_cvar jockey_pounce_air_speed 4000");

    // 需要一个加速奔跑的功能
    //ServerCommand("sm_cvar  z_forwardspeed 300");
    //ServerCommand("sm_cvar  sv_accelerate 4");
    //ServerCommand("sm_cvar  z_backspeed 150");
    //ServerCommand("sm_cvar  z_sidespeed 200");
    //ServerCommand("sm_cvar  z_gas_speed 150");

    ServerCommand("sm plugins reload l4d_reservecontrol"); 
    WEAPON_AdjWeaponAttr();
    SOUND_CreateHook();
    ServerCommand("l4d_silenced_enable 1");
    ServerCommand("l4d_infectedbots_allow 1");

    bAfk = true;
    ServerCommand("sm plugins load l4d_afk_commands");

    ServerCommand("sm_cvar z_pounce_stumble_radius 160");
//    ServerCommand("sm_cvar z_max_stagger_duration 1.0");

    //削弱推挤
    //g_bNerfShove = true;
    ServerCommand("sm_cvar z_gun_swing_duration 0.15");
    ServerCommand("sm_cvar z_gun_swing_interval 0.75");
    ServerCommand("sm_cvar z_gun_swing_vs_max_penalty 4");
    ServerCommand("sm_cvar z_gun_swing_vs_min_penalty 1");
    ServerCommand("sm_cvar z_gun_swing_vs_restore_time 6.0");
   //ServerCommand("sm_cvar ");

    ServerCommand("sm_cvar l4d_si_ability_enabled \"1\"");
    ServerCommand("sm_cvar l4d_si_ability_shove \"18\"");
    ServerCommand("sm_cvar l4d_si_ability_cooldown_shove 1.0");

    //ServerCommand("sm_cvar z_speed \"150\"");
    ServerCommand("sm_cvar rc_asdl_enable \"0\"");
    ServerCommand("sm_cvar l4d2_lj_enabled 1");
    ServerCommand("sm plugins load l4d_wam");
    ServerCommand("sm_cvar rc_gamemode_realism_dynjump 1");

    ServerCommand("idle_antispam 1");
   // ServerCommand("sm_cvar director_afk_timeout 20");
    HookEvent("tank_spawn", Event_Tank_Spawn);
    HookEvent("witch_spawn", Event_Witch_Spawn);
    HookEvent("witch_killed", WitchPanic_Event);
    HookEvent("witch_harasser_set", WitchPanic_Harasse_Event);
    HookEvent("weapon_fire", Event_WeaponFire);
    HookEvent("revive_success", Event_Revive);

    HookUserMessage(GetUserMessageId("CloseCaption"), OnCloseCaption, true);
    HookUserMessage(GetUserMessageId("CloseCaptionDirect"), OnCloseCaption, true);

    for(int i=1;i<MaxClients;i++)
    {
      if(IsClientInGame(i) && GetClientTeam(i) == 2)
      {
        SDKHook(i, SDKHook_OnTakeDamage, eOnTakeDamage);
        // SDKHook(i, SDKHook_OnTakeDamagePost, eOnTakeDamagePost);
      }
    }
    ServerCommand("sm_cvar Survivor_incapacitated_cycle_time \"0.45\"");
    //与自动射击插件配合，用于降低出现动画&特效错误的概率
    ServerCommand("sm_cvar wh_use_incap_cycle_cvar \"0\"");
    ServerCommand("sm_cvar wh_double_pistol_cycle_rate \"1\"");
    ServerCommand("sm_cvar wh_deploy_animation_speed \"0\"");
    GetConVarString(FindConVar("mp_gamemode"), g_sCvar_old_gamemode, sizeof(g_sCvar_old_gamemode) );
    GetConVarString(FindConVar("z_difficulty"), g_sCvar_old_difficulty, sizeof(g_sCvar_old_difficulty) );

    ServerCommand("sm_cvar mp_gamemode \"realism\"");
    ServerCommand("sm_cvar z_difficulty \"Impossible\"");
    ServerCommand("sm_cvar sv_vote_issue_change_difficulty_allowed \"0\"");
    ServerCommand("sm_cvar z_non_head_damage_factor_expert \"0.2\"");
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
    ServerCommand("sm_cvar tank_burn_duration_expert \"340\"");  
    ServerCommand("sm_cvar tank_stuck_time_suicide \"60\"");  
    
//    ServerCommand("sm_cvar z_shotgun_bonus_damage_range \"75\"");  
//    ServerCommand("sm_cvar survivor_damage_speed_factor \"0.25f\"");  

    ServerCommand("sm_cvar upgrade_laser_sight_spread_factor \"0.85\"");
    ServerCommand("sm_cvar l4d_weapon_auto_fire_enable \"1\"");
    // ServerCommand("sm_cvar rc_dsp_enable \"1\"");
    // dsp插件不兼容4人以上的服务器  

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
    CreateTimer(2.0, tSendMSG1);
  }
  else if(!g_bModeEnable && old_g_bModeEnable)
  {  
    PrintToServer("\n #%s# 变量变更，撤销设置...",  PLUGIN_NAME);
    ServerCommand("sm_cvar rc_gamemode_realism_ai 0");
    ServerCommand("sm plugins unload l4d2_sb_ai_improver");

    ServerCommand("sm_cvar tongue_break_from_damage_amount 50");
    ServerCommand("sm_cvar smoker_tongue_delay 1.5");
    ServerCommand("sm_cvar boomer_exposed_time_tolerance 1.0");
    ServerCommand("sm_cvar boomer_vomit_delay 1.0");
    ServerCommand("sm_cvar z_charger_health 600");
    ServerCommand("sm_cvar tongue_health 100");
    ServerCommand("sm_cvar tongue_range 750");
    ServerCommand("sm_cvar z_hunter_health 250");

    ServerCommand("sm_cvar  z_forwardspeed 450");
    ServerCommand("sm_cvar  sv_accelerate 5");
    ServerCommand("sm_cvar  z_backspeed 450");
    ServerCommand("sm_cvar  z_sidespeed 450");
    ServerCommand("sm_cvar  z_gas_speed 210");

    ServerCommand("l4d_silenced_enable 0");
    ServerCommand("l4d_infectedbots_allow 0");

    bAfk = false;
    ServerCommand("sm plugins unload l4d_afk_commands");

    ServerCommand("sm_cvar z_pounce_stumble_radius 0");
//    ServerCommand("sm_cvar z_max_stagger_duration 6.0");


    ServerCommand("sm plugins unload l4d_reservecontrol"); 
    WEAPON_ResetWeaponAttr();
    SOUND_UnHook();

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
    ServerCommand("sm_cvar z_jockey_health 325");
    ServerCommand("sm_cvar z_jockey_area_range_factor 2.0");
    ServerCommand("sm_cvar z_jockey_leap_again_timer 5.0");
    ServerCommand("sm_cvar z_jockey_leap_time 1.0");
    ServerCommand("sm_cvar jockey_pounce_loft_rate .035");
    ServerCommand("sm_cvar z_jockey_speed 250");
    ServerCommand("sm_cvar z_jockey_leap_range 200");
    ServerCommand("sm_cvar jockey_pounce_air_speed 1400");


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
      UnhookEvent("revive_success", Event_Revive);
  
      UnhookUserMessage(GetUserMessageId("CloseCaption"), OnCloseCaption, true);
      UnhookUserMessage(GetUserMessageId("CloseCaptionDirect"), OnCloseCaption, true);
   }
    for(int i=1;i<MaxClients;i++)
    {
      if(IsClientInGame(i) && GetClientTeam(i) == 2)
      SDKUnhook(i, SDKHook_OnTakeDamage, eOnTakeDamage);
    }
    ServerCommand("sm_cvar survivor_incapacitated_cycle_time \"0.3\"");
    ServerCommand("sm_cvar wh_use_incap_cycle_cvar \"1\"");
    ServerCommand("sm_cvar wh_double_pistol_cycle_rate \"0\"");
    //防止干扰速砍
    ServerCommand("sm_cvar wh_deploy_animation_speed \"-1\"");
    SetConVarString(FindConVar("mp_gamemode"), g_sCvar_old_gamemode);
    SetConVarString(FindConVar("z_difficulty"), g_sCvar_old_difficulty);

    ServerCommand("sm_cvar mp_gamemode \"%s\"", g_sCvar_old_gamemode);
    ServerCommand("sm_cvar z_difficulty \"%s\"", g_sCvar_old_difficulty);
    ServerCommand("sm_cvar sv_vote_issue_change_difficulty_allowed \"1\"");
    ServerCommand("sm_cvar z_non_head_damage_factor_expert \"0.5\"");
    //友伤
    ServerCommand("sm_cvar survivor_friendly_fire_factor_expert \"0.5\"");
    ServerCommand("sm_cvar z_friendly_fire_forgiveness \"1\"");
    //CI间隔  
    ServerCommand("sm_cvar z_throttle_hit_interval_expert \"1.0\"");
      
    //  ServerCommand("sm_cvar l4d2_RealismMagnum_Enabled \"0\"");

    ServerCommand("sm_cvar l4d2_fast_melee_fix_enable \"0\"");
    
    ServerCommand("sm_cvar l4d_wam_enabled \"0\"");
    
    ServerCommand("sm_cvar survivor_incap_decay_rate  \"4\"");  
    ServerCommand("sm_cvar z_tank_autoshotgun_dmg_scale  \"0.85\"");  
    ServerCommand("sm_cvar tank_burn_duration_expert \"85\"");  
    ServerCommand("sm_cvar tank_stuck_time_suicide \"10\"");  
    
    ServerCommand("sm_cvar z_shotgun_bonus_damage_range \"100\"");  
    ServerCommand("sm_cvar survivor_damage_speed_factor \"0.6f\"");  

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
    CreateTimer(1.0, tSendMSG2);
  }
}
Action tSendMSG1(Handle Timer)
{
  PrintToChatAll("所有设置已经完成，重新开始回合以使特定功能生效."); 
  char name[48]; 
  GetCurrentMap(name, sizeof(name) );
  ForceChangeLevel(name, "Realism++ Enable")
  // ServerCommand("sm_slay @all");
  
  return Plugin_Continue;
}
Action tSendMSG2(Handle Timer)
{
  PrintToChatAll("所有变化已经撤销，重新开始回合以完成设置.");
  ServerCommand("sm_slay @all");
  return Plugin_Continue;
}
public void OnClientPutInServer(iClient)
{
  if(g_bModeEnable)
  SDKHook(iClient, SDKHook_OnTakeDamage, eOnTakeDamage);
  snum[iClient] = 0;
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
    {
      bWam = hWam.BoolValue;   
      if(!bWam)
      {
        PrintToServer("\n%s: 卸载默认不启用的插件", PLUGIN_NAME);
        ServerCommand("sm plugins unload l4d_wam");  
      }
    }
    if(!bAfk)
    {
      PrintToServer("\n%s: 卸载默认不启用的插件", PLUGIN_NAME);
      ServerCommand("sm plugins unload l4d_afk_commands");  
    }
  }
}

public Action eOnTakeDamagePost(int iVictim, int &iAttacker, int &iInflictor, float &fDamage, int &iDamagetype, int &weapon, float damageForce[3], float damagePosition[3])
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
          if(GetRandomFloat(0.00, 100.00) >= 50.00)
          {
            // 这会导致段错误
            StaggerClient(GetClientUserId(iVictim), damagePosition);   
          }
        }
      }
    }
  }

  return Plugin_Continue;
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
        if(L4D_IsPlayerIncapacitated(iVictim) )
          fDamage = fDamage * g_fCIDMG_Multi_Incap;
        else  fDamage = fDamage * g_fCIDMG_Multi;
        return Plugin_Changed;
      }
    }
    if(iAttacker < MaxClients)
    {
      if(GetClientTeam(iVictim) == 3)
      {
        if (GetClientTeam(iAttacker) == 2)
        {
          bool isTank;
          if(GetEntProp(iAttacker, Prop_Send, "m_zombieClass") == 8)
            isTank = true;

          char buf[24];
          GetClientWeapon(iAttacker, buf, sizeof(buf) );
          if(StrContains(buf, "_smg") != -1 )
          {
            if(!isTank)
              return Plugin_Continue;

            fDamage = fDamage * 0.8

            return Plugin_Changed;
          }
          if(StrContains(buf, "_awp") != -1 )
          {
            fDamage = 400.0;
            return Plugin_Changed;
          }
          if(StrContains(buf, "_hunt") != -1 )
          {
            fDamage = 120.0;
            return Plugin_Changed;
          }
          if(StrContains(buf, "_scout") != -1 )
          {
            if(isTank)
              fDamage = 100.0;
            else fDamage = 125.0;
            return Plugin_Changed;
          }
          if(StrContains(buf, "_mili") != -1 )
          {
            fDamage = 150.0;
            return Plugin_Changed;
          }
          if(StrContains(weaponName, "m60") == 0)
          {
            fDamage = 400.0;            
            return Plugin_Changed;
          }
          if(StrContains(weaponName, "e_launcher") == 0)
          {
            fDamage = fDamage * 8.0;
            if(isTank)
              fDamage = fDamage * 2.0;
              
            return Plugin_Changed;
          }
      }

      if(GetClientTeam(iVictim) != 2) return Plugin_Continue;
      if(GetClientTeam(iAttacker) == 3) {
        int Class = GetEntProp(iAttacker, Prop_Send, "m_zombieClass");
        // charger
        if(Class == 6) {
          fDamage = fDamage * 2.0;
          return Plugin_Changed;
        }
        // jockey
        // 什么时候双生？
        if(Class == 5) {
          fDamage = fDamage * 0.5;
          return Plugin_Changed;
        }
        // hunter
        if(Class == 3) {
          fDamage = fDamage * 1.5;
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
            fDamage = 1000.0;
            iDamagetype = iDamagetype | DMG_FALL;            
            return Plugin_Changed;
          }
          if(StrContains(weaponName, "_awp") != -1 )
          {
            fDamage = 1000.0 ;
            iDamagetype = iDamagetype | DMG_FALL;            
            return Plugin_Changed;
          }
          if(StrContains(weaponName, "_hunt") != -1 )
          {
            fDamage = 80.0 ;
            return Plugin_Changed;
          }
          if(StrContains(weaponName, "_scout") != -1 )
          {
            fDamage = 100.0 ;
            return Plugin_Changed;
          }
          if(StrContains(weaponName, "_mili") != -1 )
          {
            fDamage = 80.0 ;
            return Plugin_Changed;
          }
          if(StrContains(weaponName, "m60") == 0)
          {
            fDamage = 1000.0;
            iDamagetype = iDamagetype | DMG_FALL;            
            return Plugin_Changed;
          }
          if(StrContains(weaponName, "e_launcher") == 0)
          {
            fDamage = fDamage * 4.0;
            if(fDamage >= 100.0)
            {
              fDamage = 1000.0;
              iDamagetype = iDamagetype | DMG_FALL;
            }            
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
//  RequestFrame(SetTankHP, index);
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
    fDamage = fDamage * 0.85;
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
  snum[client] = 0;
  char sWeapon[32];
  event.GetString("weapon", sWeapon, sizeof(sWeapon) );
  if(strcmp(sWeapon, "melee") == 0)
    SetEntProp(client, Prop_Send, "m_iShovePenalty", 6);
}

public void Event_RoundStart(Event event, const char[] name, bool dontBroadcast)
{
  LoadVScript();
}

public void OnEntityCreated(int entity, const char[] classname)
{
  if (g_bModeEnable)
  {
    if (entity <= MaxClients || entity > 2048) return;
    if (StrEqual(classname, "infected"))
    {
        SDKHook(entity, SDKHook_TraceAttack, eOnTraceAttack);
        // CreateTimer(0.5, tDelayChangeSpeed, entity, TIMER_FLAG_NO_MAPCHANGE)
    }
  }
}

Action tDelayChangeSpeed(Handle Timer, any entity)
{
  //int entity = EntRefToEntIndex(ref);
  if(entity == INVALID_ENT_REFERENCE || !IsValidEntity(entity) || !IsValidEdict(entity))
  {
    return Plugin_Stop;
  }
/*
  int num = GetRandomInt(1, 10000);
  if(num > 9000)
      SetEntPropFloat(entity, Prop_Send, "m_flSpeed", 220.0);
  else
    */
  SetEntPropFloat(entity, Prop_Data, "m_flSpeed", 0.5);
 
  return Plugin_Continue;
}

public Action:eOnTraceAttack(int victim, int &attacker, int &inflictor, float &damage, int &damagetype, int &ammotype, int hitbox, int hitgroup)
{

  if (!g_bModeEnable)
    return Plugin_Continue;
  if (!IsClientInGame(attacker))
    return Plugin_Continue;

  if (GetClientTeam(attacker) == 2)
  {
    char buf[24];
    GetClientWeapon(attacker, buf, sizeof(buf) );
/*
    if(StrContains(buf, "_mag") != -1 )
    {
      if(snum[attacker] == 2) return Plugin_Handled;
      snum[attacker]++;
      damage = 300.0;
      ammotype = 1;
      damagetype = 2;
      return Plugin_Changed;
    }
*/
    if(StrContains(buf, "_awp") != -1 )
    {
      if(snum[attacker] == 2) return Plugin_Handled;
      snum[attacker]++;
      damage = 2000.0;
      return Plugin_Changed;
    }
    if(StrContains(buf, "_hunt") != -1 )
    {
      if(snum[attacker] == 2) return Plugin_Handled;
      snum[attacker]++;
      damage = 300.0 ;
      return Plugin_Changed;
    }
    if(StrContains(buf, "_scout") != -1 )
    {
      if(snum[attacker] == 1) return Plugin_Handled;
      snum[attacker]++;
      damage = 600.0;
      return Plugin_Changed;
    }
    if(StrContains(buf, "_mili") != -1 )
    {
      if(snum[attacker] == 2) return Plugin_Handled;
      snum[attacker]++;
      damage = 200.0;
      return Plugin_Changed;
    }
/*  如果近战不明显，那么就可以取消它
    if(StrContains(buf, "shotgun") == -1 || StrContains(buf, "melee") == -1)
      return Plugin_Continue;
    damagetype = damagetype & ~DMG_CLUB;

    return Plugin_Changed;
*/
  }
  return Plugin_Continue;
}

void Event_Revive(Event event, const char[] name, bool dontBroadcast)
{
  int userid;
  if( (userid = event.GetInt("subject")) && event.GetInt("ledge_hang") == 0 )
  {
    int client = GetClientOfUserId(userid);
    if( client )
    {
      RequestFrame(OnFrameRevive, userid);
    }
  }
}

void OnFrameRevive(int client)
{
  client = GetClientOfUserId(client);
  if( client && IsClientInGame(client) && GetClientTeam(client) == 2 && IsPlayerAlive(client) )
  {
    if(GetEntProp(client, Prop_Send, "m_bIsOnThirdStrike") == 1)
      SetEntProp(client, Prop_Send, "m_bIsOnThirdStrike", 0);
  }
}

// taken from:
// [L4D & L4D2] Survivor Shove (1.15) [04-Aug-2022]
// https://forums.alliedmods.net/showthread.php?p=2667050
// Author = "Silvers"
//===================================================================================================
//    Stumble Client
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

public Action OnCloseCaption(UserMsg msg_id, Handle bf, const players[], playersNum, bool reliable, bool init)
{
    // 阻止全部还是一部分警告？
    return Plugin_Handled;
}
