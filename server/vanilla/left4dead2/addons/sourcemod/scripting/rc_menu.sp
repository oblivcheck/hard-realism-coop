#include <sourcemod>
#include <sdktools>
#include <clientprefs>
#include <l4d2_nativevote>
#include "rc_menu/exec.sp"

#define PLUGIN_NAME             "RC Menu"
#define PLUGIN_DESCRIPTION      "服务器内置菜单"
#define PLUGIN_VERSION          "2.1"
#define PLUGIN_AUTHOR           "oblivcheck"
#define PLUGIN_URL              ""

public Plugin:myinfo ={
  name = PLUGIN_NAME,
  author = PLUGIN_AUTHOR,
  description = PLUGIN_DESCRIPTION,
  version = PLUGIN_VERSION,
  url = PLUGIN_URL
}


#define VOTE_COOLDOWN  10.0  
// #define VOTE_DISPLAY_DELAY 2.0

int g_iVoteType;
bool gbCooldown;

public void OnPluginStart()
{
  RegConsoleCmd("sm_rc", CMD_rc);
  RegConsoleCmd("sm_menu", CMD_rc); 
}

Action CMD_rc(int client, int args)
{
  Menu rc = CreateMenu(Menu_rc);
  rc.ExitButton = false;
  rc.SetTitle("☦ 服务器菜单 ☦", PLUGIN_VERSION);
  rc.AddItem("内置投票", "内置投票");
  rc.AddItem("模式设置", "模式设置");
  rc.AddItem("地图投票", "地图投票");  rc.Display(client, MENU_TIME_FOREVER);
  PrintToChat(client, "\x04[RC]\x01 可以按下\x05数字键0\x01来退出菜单.");
  return Plugin_Handled;
}
//---------------------------------------------------------------------------||
//              主菜单回调
//---------------------------------------------------------------------------||
public int Menu_rc(Menu menu, MenuAction action, int param1, int param2)
{
  if(action == MenuAction_Select)
  {
    switch(param2)
    {
      case  0:  RC_CreateVote(param1);
      case  1:  Mode_CreateVote(param1);
      case  2:  FakeClientCommand(param1, "sm_maps");
      //case  3:  PrintToChatAll("Test Mode 3");
      //case  4:  PrintToChatAll("Test Mode 4");
      //Mode_CreateVote(param1);
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
public int Menu_rc_createvote(Menu menu, MenuAction action, int param1, int param2)
{
  if(action == MenuAction_Select)
  {
    g_iVoteType = param2;
    switch(param2)
    {
      case rcVoteType_SetSurvivorBotAutoAim:
      {
        ConVar hRpp = FindConVar("rc_gamemode_realism_enable");
        if(IsValidHandle(hRpp) )
        {
          // 以防万一，遵循以前的写法
          bool bRpp = hRpp.BoolValue
          if(bRpp)
          {
            PrintToChat(param1, "Realism++ 模式下不可用");
            return 0;
          }
        }
      }
    }
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
// 内置投票选择菜单
void RC_CreateVote(int client)
{
  Menu rc_createvote = CreateMenu(Menu_rc_createvote);
  rc_createvote.ExitButton = false;
  rc_createvote.SetTitle("选择一个投票类型");
  rc_createvote.AddItem("杀死所有玩家", "杀死所有玩家");
  rc_createvote.AddItem("传送所有幸存者", "传送所有幸存者");
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

void StartVote(int client)
{
  if( !gbCooldown && L4D2NativeVote_IsAllowNewVote() )
  {
    L4D2NativeVote hVote = L4D2NativeVote(VoteHandler);
    hVote.Initiator = client;
    hVote.SetDisplayText("%s", rc_VoteTitle[g_iVoteType]);
    int clients[MAXPLAYERS+1], num;
    GetInGamePlayers(clients, num)
   
    if( ! hVote.DisplayVote(clients, num, 30) )
      LogError("无法发起投票! 发起人：%N; 投票标题:%s", client, rc_VoteTitle[g_iVoteType]);
  }
  else PrintToChat(client, "请稍候...");
}

void VoteHandler(L4D2NativeVote vote, VoteAction action, int param1, int param2)
{
	switch(action)
  {
    case VoteAction_Start:
    {
      PrintToChatAll("\x04====================");
      PrintToChatAll("\x03  %N 发起了一项投票", vote.Initiator);
      PrintToChatAll("  %s", rc_VoteTitle[g_iVoteType] );

      // 关于正在进行的投票的一些说明
      switch(g_iVoteType)
      {
        case rcVoteType_WarpSurvivorToStartArea:
        {
          PrintToChatAll("  一些第三方地图可能会让玩家生成在不应该出现的地方（地下...）");
          PrintToChatAll("  如果不成功或是没有传送到开始区域（如消逝/短暂时刻战役）");
          PrintToChatAll("  请重新发起投票，此操作会从多种可行方式中随机抽取一个执行.");
        }
        case rcVoteType_ForceSkipScriptPhase:
        {
          PrintToChatAll("  适用于大部分的正在进行的救援与少部分机关");
          PrintToChatAll("  进入Vscript中的下一个脚本阶段(如果有)");
          PrintToChatAll("  如果卡关请多次尝试这个");
        }
      }
      
      PrintToChatAll("\x04====================");
    }
    case VoteAction_PlayerVoted:
      PrintToChatAll("\x05%N\x01投出了%s票.", param1, param2 == VOTE_YES ? "赞成" : "反对")
    case VoteAction_End:
    {
      if( vote.YesCount > vote.NoCount )
      {
        vote.SetPass("正在处理...");
        switch(g_iVoteType)
        {
          case rcVoteType_KillAllPlayer:
              ExecVote_KillAllPlayer();
          case rcVoteType_WarpAllSurvivorsToSelf:
              ExecVote_WarpAllSurvivorsToSelf(vote.Initiator);              
          case rcVoteType_WarpAllSurvivorBotsToSelf:
              ExecVote_WarpAllSurvivorBotsToSelf(vote.Initiator);
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
        vote.SetFail();
      }
      gbCooldown = true;
      CreateTimer(VOTE_COOLDOWN, tSetCoolDown);
    }
  }
}
//---------------------------------------------------------------------------||
//              模式设置菜单显示
//---------------------------------------------------------------------------||
public int Menu_mode_createvote(Menu menu, MenuAction action, int param1, int param2)
{
  if(action == MenuAction_Select)
  {
    g_iVoteType = param2;
    ConVar hRpp = FindConVar("rc_gamemode_realism_enable");
    if(IsValidHandle(hRpp) )
    {
      // 以防万一，遵循以前的写法
      bool bRpp = hRpp.BoolValue
      if(bRpp)
      {
        // 还需要额外处理
        //
        //
        
        if(g_iVoteType == ModeVoteType_SwitchToCampaign)
        {
          PrintToChat(param1, "请先关闭 Realism++");
          return 0;
        }
        if(g_iVoteType == ModeVoteType_SwitchToRealism)
        {
          PrintToChat(param1, "请先关闭 Realism++");
          return 0;
        }
      }
      else
      {
        if(g_iVoteType == ModeVoteType_SwitchToRpp_disable)
        {
          PrintToChat(param1, "Realism++ 未启用");
          return 0;
        }
      }
    }

    Mode_StartVote(param1);
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
// 模式设置投票选择菜单
void Mode_CreateVote(int client)
{
  Menu mode_createvote = CreateMenu(Menu_mode_createvote);
  mode_createvote.ExitButton = false;
  mode_createvote.SetTitle("++  模式设置  ++");
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

enum modeVoteType
{
  ModeVoteType_SwitchToCampaign,
  ModeVoteType_SwitchToRealism,
  ModeVoteType_SwitchToRpp,
  ModeVoteType_SwitchToRpp_full,
  ModeVoteType_SwitchToRpp_disable, 
  ModeVoteType_MAXVOTENUM
};

static char mode_VoteTitle[][]={
"切换至战役模式",
"切换至写实模式",
"启用Realism++(半隐藏)",
"启用Realism++(完全隐藏)",
"关闭Realism++"
};

void Mode_StartVote(int client)
{
  if( !gbCooldown && L4D2NativeVote_IsAllowNewVote() )
  {
    L4D2NativeVote hVote = L4D2NativeVote(Mode_VoteHandler);
    hVote.Initiator = client;
    hVote.SetDisplayText("%s", mode_VoteTitle[g_iVoteType]);
    int clients[MAXPLAYERS+1], num;
    GetInGamePlayers(clients, num)
   
    if( ! hVote.DisplayVote(clients, num, 30) )
      LogError("无法发起投票! 发起人：%N; 投票标题:%s", client, mode_VoteTitle[g_iVoteType]);
  }
  else PrintToChat(client, "请稍候...");
}

void Mode_VoteHandler(L4D2NativeVote vote, VoteAction action, int param1, int param2)
{
	switch(action)
  {
    case VoteAction_Start:
    {
      PrintToChatAll("\x04====================");
      PrintToChatAll("\x03  %N 发起了一项投票", vote.Initiator);
      PrintToChatAll("  %s", mode_VoteTitle[g_iVoteType] );

      // 关于正在进行的投票的一些说明
      switch(g_iVoteType)
      {
        case rcVoteType_WarpSurvivorToStartArea:
        {
          PrintToChatAll("  尝试传送所有玩家至开始区域...");
          PrintToChatAll("  一些第三方地图可能会让玩家生成在不应该出现的地方（地下...）");
          PrintToChatAll("  如果不成功或是没有传送到开始区域（如消逝/短暂时刻战役）");
          PrintToChatAll("  请重新发起投票，此操作会从多种可行方式中随机抽取一个执行.");
        }
        case rcVoteType_ForceSkipScriptPhase:
        {
          PrintToChatAll("  适用于大部分的正在进行的救援与少部分机关");
          PrintToChatAll("  进入Vscript中的下一个脚本阶段(如果有)");
          PrintToChatAll("  如果卡关请多次尝试这个");
        }
      }
      
      PrintToChatAll("\x04====================");
    }
    case VoteAction_PlayerVoted:
      PrintToChatAll("\x05%N\x01投出了%s票.", param1, param2 == VOTE_YES ? "赞成" : "反对")
    case VoteAction_End:
    {
      if( vote.YesCount > vote.NoCount )
      {
        vote.SetPass("正在处理...");
        switch(g_iVoteType)
        {
          case ModeVoteType_SwitchToCampaign: ExecVote_SwitchToCampaign();
          case ModeVoteType_SwitchToRealism: ExecVote_SwitchToRealism();
          case ModeVoteType_SwitchToRpp: ExecVote_SwitchToRpp();
          case ModeVoteType_SwitchToRpp_full: ExecVote_SwitchToRpp_full();
          case ModeVoteType_SwitchToRpp_disable: ExecVote_SwitchToRpp_disable();
        }
      }
      else
      {
        vote.SetFail();
      }
      gbCooldown = true;
      CreateTimer(VOTE_COOLDOWN, tSetCoolDown);
    }
  }
}

//---------------------------------------------------------------------------||
//              投票冷却计时器回调
//---------------------------------------------------------------------------||
Action tSetCoolDown(Handle Timer)
{
  gbCooldown = false;
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

void GetInGamePlayers(int clients[MAXPLAYERS+1], int &num)
{
	for (int i = 1; i <= MaxClients; i++)
	{
		if (IsClientInGame(i) && !IsFakeClient(i))
    			  clients[num++] = i;
	}
}
