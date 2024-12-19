#include <sourcemod>
#include <sdktools>
#include <clientprefs>
#include <l4d2_nativevote>

#define PLUGIN_NAME             "RC Menu"
#define PLUGIN_DESCRIPTION      "服务器内置菜单"
#define PLUGIN_VERSION          "2.0"
#define PLUGIN_AUTHOR           "oblivcheck"
#define PLUGIN_URL              ""


#define VOTE_DISPLAY_DELAY      2.0  

#define VOTETYPE_VOTE           0
#define VOTETYPE_MODE           1

int g_iVoteType;

public Plugin:myinfo ={
        name = PLUGIN_NAME,
        author = PLUGIN_AUTHOR,
        description = PLUGIN_DESCRIPTION  ,
        version = PLUGIN_VERSION,
        url = PLUGIN_URL
}
//#define SETTINGS_VOTE   1 <<  1
//#define SETTINGS_GAME   1 <<  2

//#define CONNECT_SERER_HINT  SETTINGS_GAME | 1 << 11

Cookie cConnectServerHint;
Cookie cStatiGameTime;

public void OnPluginStart()
{
  RegConsoleCmd("sm_rc", CMD_rc);
  RegConsoleCmd("sm_menu", CMD_rc);
  
  cConnectServerHint = RegClientCookie("rc_menu_connectserverhint", "",CookieAccess_Protected);
  CreateTimer(5.0, tCookie)
}

Action tCookie(Handle Timer)
{
  cStatiGameTime = FindClientCookie("rc_stati_playtime_default_re2");
  return Plugin_Continue;
}

Action CMD_rc(int client, int args)
{
  Menu rc = CreateMenu(Menu_rc);
  rc.ExitButton = false;
  rc.SetTitle("服务器菜单 v%s", PLUGIN_VERSION);
  rc.AddItem("内置投票", "内置投票");
  rc.AddItem("模式设置", "模式设置");
  rc.Display(client, MENU_TIME_FOREVER);
  PrintToChat(client, "\x04[RC]\x01 可以按下\x05数字键0\x01来退出菜单.");
  return Plugin_Handled;
}
//---------------------------------------------------------------------------||
//              RC菜单回调
//---------------------------------------------------------------------------||
public int Menu_rc(Menu menu, MenuAction action, int param1, int param2)
{
  if(action == MenuAction_Select)
  {
    switch(param2)
    {
      case  0:  RC_CreateVote(param1);
      case  1:  Mode_CreateVote(param1);
    } 
    return 0;
  }

  if(action == MenuAction_End)
  {
    if(!IsValidHandle(menu) ) 
      return 0;
    delete menu;
  }
  return 0;
}
//---------------------------------------------------------------------------||
//              内置菜单显示
//---------------------------------------------------------------------------||
int VoteType;
public int Menu_rc_createvote(Menu menu, MenuAction action, int param1, int param2)
{
  if(action == MenuAction_Select)
  {
    g_iVoteType = param2;
    StartVote(param1);
    return 0;
  }

  if(action == MenuAction_End)
  {
    if(!IsValidHandle(menu) ) 
      return 0;
    delete menu;
  }
  return 0;
}

static char sVoteName[][]={
"杀死所有玩家",
"传送幸存者机器人",
"传送幸存者至起始区域",
"强制进入下一个脚本阶段",
"设置幸存者机器人自瞄",
"设置语音标记辅助"
};
// 内置投票
void RC_CreateVote(int client)
{
  Menu rc_createvote = CreateMenu(Menu_rc_createvote);
  rc_createvote.ExitButton = false;
  rc_createvote.SetTitle("投票选择菜单");
  rc_createvote.AddItem("杀死所有玩家", "杀死所有玩家");
  rc_createvote.AddItem("传送幸存者机器人", "传送幸存者机器人");
  rc_createvote.AddItem("传送幸存者至起始区域", "传送幸存者至起始区域");
  rc_createvote.AddItem("强制进入下一个脚本阶段", "强制进入下一个脚本阶段");
  rc_createvote.AddItem("设置幸存者机器人自瞄", "设置幸存者机器人自瞄");
  rc_createvote.AddItem("设置语音标记辅助", "设置语音标记辅助");
  rc_createvote.Display(client, MENU_TIME_FOREVER);
}

//---------------------------------------------------------------------------||
//              内置投票处理程序
//---------------------------------------------------------------------------||
enum rcVoteType
{
  rcVoteType_KillAllPlayer,
  rcVoteType_WarpAllSurvivorsToSelf,
  rcVoteType_WarpAllSurvivorBotsToSelf,
  rcVoteType_WarpSurvivorToStartArea,
  rcVoteType_ForceSkipScriptPhase,
  rcVoteType_SetSurvivorBotAutoAim,
  rcVoteType_SetVoiceMark,
  rcVoteType_MAXVOTENUM
};

char rc_VoteTitle[][]={
  "杀死所有的玩家",
  "传送所有玩家到自己的位置",
  "传送所有生还者机器人到自己的位置",
  "传送所有幸存者到起始安全区域/安全屋",
  "强制进入下一个脚本阶段，防止卡关",
  "设置生还者机器人辅助瞄准",
  "设置生还者语音标记功能"
};

void GetrcVoteTypeTitle(const char [] buf)
{
  Format(buf, sizeof(buf), "%s", rc_VoteTitle[rcVoteType]);
}


void StartVote(int client)
{
  if( L4D2NativeVote_IsAllowNewVote() )
  {
    L4D2NativeVote hVote = L4D2NativeVote(@VoteHandler);
    vote.Initiator(client);
    hVote.SetTitle(rc_VoteTitle[g_iVoteType-1]);
    hVote.SetDisplayText("Test Displayer text");
    static int clinets[MAXPLAYERS+1], num;
    GetInGamePlayers(&clients, &num);
    
    if( ! hVote.DisplayVote(clients, num, 30) )
      LogError("无法发起投票! 发起人：%N; 投票标题:%s", client, rc_VoteTitle[g_iVoteType-1]);
  }
  else PrintToChat(client, "请稍候...");
}

void VoteHandler(L4D2NativeVote vote, VoteAction action, int param1, int param2)
{
	switch(action)
  {
    case VoteAction_Start:
      PrintToChatAll("%N 发起了一项投票", vote.Initiator);
    case VoteAction_PlayerVoted:
      PrintToChatAll("%N 投出了%s票.", param1, param2 == VOTE_YES ? "赞成" : "反对")
    case VoteAction_End:
    {
      if( vote.YesCount > vote.NoCount )
      {
        switch(g_iVoteType)
        {
          case rcVoteType_KillAllPlayer:
              ExecVote_KillAllPlayer();
          case rcVoteType_WarpAllSurvivorsToSelf:
              ExecVote_WarpAllSurvivorsToSelf();
          case rcVoteType_WarpSurvivorToStartArea:
              ExecVote_WarpSurvivorToStartArea();
          case rcVoteType_ForceSkipScriptPhase:
              ExecVote_ForceSkipScriptPhase();
          case rcVoteType_SetSurvivorBotAutoAim:
              ExecVote_SetSurvivorBotAutoAim();
          case rcVoteType_SetVoiceMark:
              ExecVote_SetVoiceMark();
        }
      }
      else
      {
        // 加点什么？
        Vote.SetFail();
      }
    }
  }
}

void ExecVote_KillAllPlayer()
{
}
void ExecVote_WarpAllSurvivorsToSelf()
{
}
void ExecVote_WarpSurvivorToStartArea()
{
}
void ExecVote_ForceSkipScriptPhase()
{
}
void ExecVote_SetSurvivorBotAutoAim()
{
}
void ExecVote_SetVoiceMark()
{
}
//---------------------------------------------------------------------------||
//              内置投票功能执行
//---------------------------------------------------------------------------||
void Vote_KillAllPlayers()
{
  ServerCommand("sm_slay @all");
}

void Vote_TeleportSurbot()
{
  int player = GetRandomRealPlayer_Alive();
  if(!player)
    return;

  float pos[3]; 
  GetClientAbsOrigin(player, pos);

  for(int i=1;i<=MaxClients;i++)
  {
    if(IsClientInGame(i) )
    {
      if(IsFakeClient(i) )
      {
        if(GetClientTeam(i) == 2)
          TeleportEntity(i, pos, NULL_VECTOR, NULL_VECTOR);
      }
    }
  }
  PrintToChatAll("已传送所有存活的幸存者机器人...");
}

// https://forums.alliedmods.net/showthread.php?t=338572
void Vote_TeleportStartArea()
{
  if(GetRandomFloat(0.00, 100.00) >= 50.00)
    ServerCommand("sm_spawnwarp");
  else  ServerCommand("sm_spawntel");
  PrintToChatAll("尝试传送所有玩家至开始区域...");
  PrintToChatAll("\x04[RC]\x01 一些第三方地图可能会让玩家生成在不应该出现的地方（地下...）");
  PrintToChatAll("如果不成功或是没有传送到开始区域（如消逝/短暂时刻战役）");
  PrintToChatAll("请重新发起投票，此操作会从多种可行方式中随机抽取一个执行.");
}

// https://forums.alliedmods.net/showthread.php?t=334759
void Vote_ForceNextStage()
{
  ServerCommand("sm_nextstage");
  PrintToChatAll("已强制进入下一个导演脚本阶段...但某些关卡可能需要投票多次以达到目的");
  PrintToChatAll("\x04[RC]\x01 这个功能是为了防止卡关而设置的(救援阶段/机关).");
}

void Vote_AiFix()
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

void Vote_VoiceChat()
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
/---------------------------------------------------------------------------||
//              模式设置投票显示
//---------------------------------------------------------------------------||
int Mode_VoteType;  // 也许只需要一个... Sourcemod投票处理程序应该能解决好
public int Menu_mode_createvote(Menu menu, MenuAction action, int param1, int param2)
{
  if(action == MenuAction_Select)
  {
    Mode_VoteType = param2;
    switch(param2)
    {
      case  0:{
            Mode_Change(param1, "coop");
      }
      case  1:{
            Mode_Change(param1, "realism");
      }
      case  2:{
            Mode_Change(param1, "rpp");
      }
      case  3:{
            Mode_Change(param1, "rpp");
      }
      case  4:{
            Mode_Change(param1, "rpp_f");
      }
    }
    return 0;
  }

  if(action == MenuAction_End)
  {
    if(!IsValidHandle(menu) ) 
      return 0;
    delete menu;
  }
  return 0;
}

void GameMode_Rc(int type)
{
  // 关闭Realism++
  if(type == 0)
  {
    ServerCommand("sm_cvar rc_gamemode_realism_enable 0");
    ServerCommand("sm_rpp false");
    ServerExecute();
    ServerCommand("sm_cvar hrc_hud_enable 0");
    ServerCommand("sm_cvar hide_hud_enable 0");
  }
  // HideHUD类型的 Realism++
  else if(type == 1)
  {
    ServerCommand("sm_rpp true");
    ServerExecute()
    CreateTimer(1.5, tDelayEx, 1);
    CreateTimer(1.0, tDelaySetMode, false);		
	
  }
  // HRC HUD类型的 Realism++
  else if(type == 2)
  {
    ServerCommand("sm_rpp true");
    ServerExecute()
    CreateTimer(1.5, tDelayEx, 2);
    CreateTimer(1.0, tDelaySetMode, false);
  }
  PrintToChatAll("\x04[RC]\x01 设置\x05Realism++\x01，重启回合...");
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

//	g_bVoting = false;

	return Plugin_Continue;
}
void Mode_Change(client, const char[] mode)
{
  char sMode[32];
  GetConVarString(FindConVar("mp_gamemode"), sMode, sizeof(sMode) );
  if(strcmp(mode, "rpp") == 0)
  {
    Mode_StartVote(client);
    return;
  }

  bool bRpp;
  ConVar hRpp = FindConVar("rc_gamemode_realism_enable");
  bRpp = hRpp.BoolValue;
  if(strcmp(mode, "rpp_f") != 0 && bRpp)
  {
    PrintToChat(client, "要切换至其它模式，首先需要关闭Realism++");
    return;
  }
  if(strcmp(mode, "rpp_f") == 0 && !bRpp)
  {
    PrintToChat(client, "Realism++ 未启用")
    return;
  }
  if(strcmp(sMode, mode) == 0)
  {
    PrintToChat(client, "选择的模式与当前的游戏模式相同！");
    return;
  }
  else if(strcmp(sMode, "realism") != 0 && strcmp(sMode, "coop") != 0)
  {
    PrintToChat(client, "在当前的游戏模式下，要切换的目标模式是不可用的...");
    return;
  }
  Mode_StartVote(client);
}

static char sMode_VoteName[][]={
"切换至战役模式",
"切换至写实模式",
"启用Realism++(半隐藏)",
"启用Realism++(完全隐藏)",
"关闭Realism++"
};

void Mode_CreateVote(int client)
{
  Menu mode_createvote = CreateMenu(Menu_mode_createvote);
  mode_createvote.ExitButton = false;
  mode_createvote.SetTitle("模式设置");
  mode_createvote.AddItem("切换至战役模式", "切换至战役模式");
  mode_createvote.AddItem("切换至写实模式", "切换至写实模式");
  mode_createvote.AddItem("启用 Realism++(半隐藏)", "启用 Realism++(半隐藏)");
  mode_createvote.AddItem("启用 Realism++(完全隐藏)", "启用 Realism++(完全隐藏)");
  mode_createvote.AddItem("关闭 Realism++", "关闭 Realism++");
  mode_createvote.Display(client, MENU_TIME_FOREVER);
}

//---------------------------------------------------------------------------||
//              模式设置投票处理程序
//---------------------------------------------------------------------------||
void Mode_StartVote(int client)
{
  if(IsVoteInProgress())
  {
    PrintToChat(client, "%N, 现在有一个投票在进行中...", client);
    return;
  }
  PrintToChatAll("\x04[RC] \x03%N\x01 发起了一项\x05模式设置\x01投票！", client);
  CreateTimer(VOTE_DISPLAY_DELAY, tDelayDisplayVote, VOTETYPE_MODE, TIMER_FLAG_NO_MAPCHANGE);
}

public int Handle_Mode_StartVote(Menu menu, MenuAction action, int param1, int param2)
{
  if(action == MenuAction_End)
  {
      delete menu;
  }
  else if (action == MenuAction_VoteEnd)
  {
    if(param1 == 0)
    {
      switch(Mode_VoteType)
      {
        case  0:  Mode_Vote_Campaign();
        case  1:  Mode_Vote_Realism();
        case  2:  GameMode_Rc(1);
        case  3:  GameMode_Rc(2);
        case  4:  GameMode_Rc(0);
      }
    }
    else
    {
      PrintToChatAll("\x04[RC]\x01 投票未通过...");
    }
  }

  return 0;
}
//---------------------------------------------------------------------------||
//              模式设置功能执行
//---------------------------------------------------------------------------||
void Mode_Vote_Campaign()
{
  ServerExecute();
  ServerCommand("sm_cvar mp_gamemode \"coop\"");
  ServerCommand("sm_slay @all");
  PrintToChatAll("\x04[RC]\x01 切换至\x05战役模式\x01，重启回合...");
}
void Mode_Vote_Realism()
{
  ServerCommand("sm_cvar mp_gamemode \"realism\"");
  ServerCommand("sm_slay @all");
  PrintToChatAll("\x04[RC]\x01 切换至\x05写实模式\x01，重启回合...");
}
//---------------------------------------------------------------------------||
//              延迟显示投票定时器
//---------------------------------------------------------------------------||
Action tDelayDisplayVote(Handle Timer, any votetype)
{
  if(IsVoteInProgress() )
    return Plugin_Continue;

  if(votetype == 0)
  {
    Menu mode_startvote = CreateMenu(Handle_StartVote);
    mode_startvote.SetTitle("%s ?", sVoteName[VoteType]);
    mode_startvote.AddItem("是", "是");
    mode_startvote.AddItem("否", "否");
    mode_startvote.ExitButton = false;
//    mode_startvote.DisplayVoteToAll(30);
    int vClient[4];
    int count;
    for(int client=1;client<=MaxClients;client++)
    {
      if(!IsClientInGame(client) )
        continue;
      if(!(GetClientTeam(client) == 2) )
        continue;
      if(IsFakeClient(client))
        continue;
      for(int p=0;p<4;p++)
      {
        if(vClient[p] == 0)
          vClient[p] = client;
      }
      count++;
    }
    mode_startvote.DisplayVote(vClient, count, 30);
  }
  else
  {
    Menu mode_startvote = CreateMenu(Handle_Mode_StartVote);
    mode_startvote.SetTitle("%s ?", sMode_VoteName[Mode_VoteType]);
    mode_startvote.AddItem("是", "是");
    mode_startvote.AddItem("否", "否");
    mode_startvote.ExitButton = false;
//    mode_startvote.DisplayVoteToAll(30);
    int vClient[4];
    int count;
    for(int client=1;client<=MaxClients;client++)
    {
      if(!IsClientInGame(client) )
        continue;
      if(!(GetClientTeam(client) == 2) )
        continue;
      if(IsFakeClient(client))
        continue;
      for(int p=0;p<4;p++)
      {
        if(vClient[p] == 0)
          vClient[p] = client;
      }
      count++;
    }
    mode_startvote.DisplayVote(vClient, count, 30);
  }
/*
  switch(votetype)
  {
    case  VOTETYPE_VOTE:{
          Menu startvote = CreateMenu(Handle_StartVote);
          startvote.SetTitle("%s ?", sVoteName[VoteType]);
          startvote.AddItem("是", "是");
          startvote.AddItem("否", "否");
          startvote.ExitButton = false;
          startvote.DisplayVoteToAll(30);
    }
    case  VOTETYPE_MODE:{
          Menu mode_startvote = CreateMenu(Handle_Mode_StartVote);
          mode_startvote.SetTitle("%s ?", sMode_VoteName[Mode_VoteType]);
          mode_startvote.AddItem("是", "是");
          mode_startvote.AddItem("否", "否");
          mode_startvote.ExitButton = false;
          mode_startvote.DisplayVoteToAll(30);
    }
  }
  */
  return Plugin_Continue;
}
//---------------------------------------------------------------------------||
//              Stock
//---------------------------------------------------------------------------||
stock bool IsValidClientIndex(int client)
{
    return (1 <= client <= MaxClients);
}

stock bool IsValidClient(int client)
{
    return (IsValidClientIndex(client) && IsClientInGame(client));
}

stock int GetRandomRealPlayer_Alive()
{
  for(int i=1;i<=MaxClients;i++)
  {
    if(IsClientInGame(i) )
    {
      if(!IsFakeClient(i) )
      {
        if(IsPlayerAlive(i) )
          return i;
      }
    }
  }
  return 0;
}

void GetInGamePlayers(int &clients, int &num)
{
	for (int i = 1; i <= MaxClients; i++)
	{
		if (IsClientInGame(i) && !IsFakeClient(i))
		{
			if (GetClientTeam(i) == 2 || GetClientTeam(i) == 3)
			{
			  clients[i] = i;
			}
		}
	}
}
