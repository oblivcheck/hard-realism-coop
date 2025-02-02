// 内置投票
void ExecVote_KillAllPlayer()
{
  ServerCommand("sm_slay @all");
}
void ExecVote_WarpAllSurvivorsToSelf(client)
{
  // ?
  int player = client
  if(!player)
  {  
    player = GetRandomRealPlayer_Alive();
    if(!player)
    {
      PrintToChatAll("ERROR 0: ExecVote_WarpAllSurvivorsToSelf()");
      return;
    }
  }
  float pos[3]; 
  GetClientAbsOrigin(player, pos);

  for(int i=1;i<=MaxClients;i++)
  {
    if(IsClientInGame(i) )
    {
      if(GetClientTeam(i) == 2)
      {
        if(L4D_IsPlayerIncapacitated(i) )
        {
          ExecuteCheatCommand(client, "give health");
          SetEntityHealth(i, 1);
          // 你也不想被shooter硬控吧
          //ServerCommand("sm_slap #%d", GetClientUserId(i) );
        }        
        TeleportEntity(player, pos, NULL_VECTOR, NULL_VECTOR);
      }
    }
  }
  /* 
  ServerExecute();
  ServerCommand("sm_freeze @all 1.2");
  ServerExecute();
  ServerCommand("sm_noclip @all");
  CreateTimer(1.0, tDisableNocliplip);
  ServerExecute();
  */
  PrintToChatAll("已传送所有存活的幸存者(Survivors -> %N)", player);
}
/*
Action tDisableNocliplip(Handle Timer)
{  
  ServerCommand("sm_noclip @all");
  return Plugin_Continue;
}
*/
stock bool L4D_IsPlayerIncapacitated(int client)
{
  return view_as<bool>(GetEntProp(client, Prop_Send, "m_isIncapacitated", 1));
}
stock void ExecuteCheatCommand(int client, const char[] cmd)
{
  char buffer[8][16];
  ExplodeString(cmd, " ", buffer, 8, 16);
  int flag = GetCommandFlags(buffer[0]);

  if(flag != INVALID_FCVAR_FLAGS)
  {
    if(flag & FCVAR_CHEAT)
    {
      char cmd_buffer[128];
      Format(cmd_buffer, sizeof(cmd_buffer), "%s %s %s %s %s %s %s %s", buffer[0],
        buffer[1],buffer[2],buffer[3],
        buffer[4],buffer[5],buffer[6],buffer[7]);
      SetCommandFlags(buffer[0], flag & ~FCVAR_CHEAT);
      FakeClientCommand(client, cmd_buffer);
      SetCommandFlags(buffer[0], flag | FCVAR_CHEAT);
      ServerCommand("say 执行作弊命令: %s", cmd_buffer);
    }
  }
  else  PrintToChat(client, "不是有效的命令");
}

void ExecVote_WarpAllSurvivorBotsToSelf(client)
{
  // ?
  int player = client
  if(!player)
  {  
    player = GetRandomRealPlayer_Alive();
    if(!player)
    {
      PrintToChatAll("ERROR 0: ExecVote_WarpAllSurvivorBotsToSelf()");
      return;
    }
  }
  float pos[3]; 
  GetClientAbsOrigin(player, pos);

  for(int i=1;i<=MaxClients;i++)
  {
    if(IsClientInGame(i) )
    {
      if(IsFakeClient(i) )
      {
        if(GetClientTeam(i) == 2)
          TeleportEntity(player, pos, NULL_VECTOR, NULL_VECTOR);
      }
    }
  }
  PrintToChatAll("已传送所有存活的幸存者机器人(Survivor Bots -> %N)", player);
}

void ExecVote_WarpSurvivorToStartArea()
{
  if(GetRandomFloat(0.00, 100.00) >= 50.00)
  {
    ServerCommand("sm_spawnwarp");
    PrintToChatAll("执行方法A");
  }
  else
  {
    ServerCommand("sm_spawntel");
    PrintToChatAll("执行方法B");
  }
}
void ExecVote_ForceSkipScriptPhase()
{
  ServerCommand("sm_nextstage");
  PrintToChatAll("已强制进入下一个导演脚本阶段...但某些关卡可能需要投票多次以达到目的");
}
void ExecVote_SetSurvivorBotAutoAim()
{
  ConVar hStatus = FindConVar("sb_fix_enabled");
  if(IsValidHandle(hStatus) )
  {
    bool bStatus = hStatus.BoolValue
    if(bStatus)
    {
      ServerCommand("sm_cvar sb_fix_enabled 0");
      PrintToChatAll("已关闭幸存者机器人自瞄辅助！");
    }
    else
    {
      ServerCommand("sm_cvar sb_fix_enabled 1");
      PrintToChatAll("幸存者机器人自瞄辅助已开启！");
    }
  }
  else
  {
    PrintToChatAll("\x04[RC]\x01 此功能在当前情况下不可用...");
  }
}
void ExecVote_SetVoiceMark()
{

  ConVar hStatus = FindConVar("l4d2_item_hint_announce_type");
  if(IsValidHandle(hStatus) )
  {
   int Status = hStatus.IntValue;
    if(Status != 0)
    {
     ServerCommand("l4d2_infected_marker_announce_type \"0\"");
      ServerCommand("l4d2_infected_marker_glow_color \"\"");
      ServerCommand("l4d2_infected_marker_witch_enable \"0\"");
      ServerCommand("l4d2_item_hint_announce_type \"0\"");
      ServerCommand("l4d2_item_hint_glow_color \"\"");
      ServerCommand("l4d2_item_instructorhint_enable \"0\"");
      ServerCommand("l4d2_spot_marker_color \"\"");
      ServerCommand("l4d2_spot_marker_instructorhint_enable \"0\"");
      ServerCommand("l4d2_spot_marker_sprite_model \"\"");
      ServerExecute();
      PrintToChatAll("已关闭语音标记辅助！");
    }
    else
    {
      ServerCommand("l4d2_infected_marker_announce_type \"1\"");
      ServerCommand("l4d2_infected_marker_glow_color \"255 120 203\"");
      ServerCommand("l4d2_infected_marker_witch_enable \"1\"");
      ServerCommand("l4d2_item_hint_announce_type \"1\"");
      ServerCommand("l4d2_item_hint_glow_color \"255 120 203\"");
      ServerCommand("l4d2_item_instructorhint_enable \"1\"");
      ServerCommand("l4d2_spot_marker_color \"255 120 203\"");
      ServerCommand("l4d2_spot_marker_instructorhint_enable \"1\"");
      char p[]="materials/vgui/icon_arrow_down.vmt";
      ServerCommand("l4d2_spot_marker_sprite_model \"%s\"", p);

      ServerExecute();
      
      ConVar hRealism = FindConVar("mp_gamemode");
      char bf[32];
      hRealism.GetString(bf, sizeof(bf));
      if(strncmp(bf, "r", 1) == 0 || strncmp(bf, "R", 1) == 0)
      {
        ServerCommand("l4d2_infected_marker_glow_color \"\"");
        ServerCommand("l4d2_item_hint_glow_color \"\"");
        ServerCommand("l4d2_item_instructorhint_enable \"0\"");
        ServerCommand("l4d2_spot_marker_color \"\"");
        ServerCommand("l4d2_spot_marker_instructorhint_enable \"0\"");
        ServerCommand("l4d2_spot_marker_sprite_model \"\"");
        ServerExecute();
        PrintToChatAll("\x04[写实模式中，语音标记的轮廓高亮与悬浮提示将关闭！]");
      }
      PrintToChatAll("语音标记辅助已开启");
    }
  }
  else
  {
    PrintToChatAll("\x04[RC]\x01 此功能在当前情况下不可用...");
  }
}

// 模式投票
void ExecVote_SwitchToCampaign()
{
  ServerExecute();
  ServerCommand("sm_cvar mp_gamemode \"coop\"");
  ServerCommand("sm_slay @all");
  PrintToChatAll("切换至战役模式，重启回合...");
}
void ExecVote_SwitchToRealism()
{
  ServerCommand("sm_cvar mp_gamemode \"realism\"");
  ServerCommand("sm_slay @all");
  PrintToChatAll("切换至写实模式，重启回合...");
}
void ExecVote_SwitchToRpp()
{
  ServerCommand("sm_rpp true");
  ServerExecute()
  CreateTimer(1.5, tDelayEx, 1);
  CreateTimer(1.0, tDelaySetMode, false);
}
void ExecVote_SwitchToRpp_full()
{
  ServerCommand("sm_rpp true");
  ServerExecute()
  CreateTimer(1.5, tDelayEx, 2);
  CreateTimer(1.0, tDelaySetMode, false);
}
void ExecVote_SwitchToRpp_disable()
{
  ServerCommand("sm_cvar rc_gamemode_realism_enable 0");
  ServerCommand("sm_rpp false");
  ServerExecute();
  ServerCommand("sm_cvar hrc_hud_enable 0");
  ServerCommand("sm_cvar hide_hud_enable 0");
}
Action tDelayEx(Handle Timer, any type)
{
  if (type == 1)
  {
    ServerCommand("sm_cvar hrc_hud_enable \"0\""); 
		ServerCommand("sm plugins load hideHUD");
    ServerCommand("sm_cvar hide_hud_enable 1");
    ServerExecute();
    PrintToChatAll("\x05按下\x04静步键\x05来显示HUD");
  }
  else
  {
    ServerCommand("sm_cvar hide_hud_enable 0");
		ServerCommand("sm plugins unload hideHUD");
    ServerExecute();
    CreateTimer(1.0, tDelaySetMode, true);
		ServerCommand("sm_cvar hrc_hud_show_key \"1\"");
    PrintToChatAll("\x04如果无法切换武器，请长按\x03R键\x053秒以上，也请确保聊天框是关闭的(尽管它现在不可见)");
    PrintToChatAll("\x05聊天可以使用开发者控制台say命令，或者按下\x03数字键7\x05(非小键盘)可以短暂显示HUD");
}
  return Plugin_Continue;
}
Action tDelaySetMode(Handle Timer, any hud)
{
	if(hud)
		ServerCommand("sm_cvar hrc_hud_enable \"1\"");
	ServerCommand("sm_cvar rc_gamemode_realism_enable \"1\"");
	return Plugin_Continue;
}
