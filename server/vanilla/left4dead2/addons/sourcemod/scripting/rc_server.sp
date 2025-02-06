#include <sourcemod>
#include <sdkhooks>
#include <sdktools>
#include <left4dhooks>
#include <multicolors>
#include <clientprefs>

#define PLUGIN_NAME             "RC Server"
#define PLUGIN_DESCRIPTION      "Realism Coop 服务器上的小功能集合"
#define PLUGIN_VERSION          "1.5.4a"
#define PLUGIN_AUTHOR           "oblivcheck"
#define PLUGIN_URL              ""

public Plugin:myinfo =
{
  name = PLUGIN_NAME,
  author = PLUGIN_AUTHOR,
  description = PLUGIN_DESCRIPTION,
  version = PLUGIN_VERSION,
  url = PLUGIN_URL
}

int	g_iServerTickRate;
char ServerName[128];
bool g_bAvaCmd[MAXPLAYERS+1];

ConVar g_hGamemode;
ConVar g_hDifficulty;
ConVar g_hModeRealism;

//Cookie  cConnectServerHint;
Cookie cStatiGameTime;
bool AllowSettings_ConnectServerHint[MAXPLAYERS+1];

#define ZS_Sound  "weapons/magnum/gunfire/magnum_shoot.wav"

bool g_bPlayerAwayPre[MAXPLAYERS+1];
//---------------------------------------------------------------------------||
//		检查其他插件是否已经加载并挂钩Cvar变化
//---------------------------------------------------------------------------||
bool g_bModeRealism_Load;
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
Handle hCreate, hSpec, hSwitch, hRespawn, hGoAway;
//ConVar hGameData;
public void OnPluginStart()
{
  // ?
  // l4dtoolz相关
  GameData hGameData = new GameData("l4d2_rmc");
  if(!hGameData) SetFailState("Failed to load 'l4d2_rmc.txt' gamedata.");
  StartPrepSDKCall(SDKCall_Static);
  if(!PrepSDKCall_SetFromConf(hGameData, SDKConf_Signature, "CreatePlayerBot")) SetFailState("Failed to find signature: CreatePlayerBot");
  PrepSDKCall_AddParameter(SDKType_String, SDKPass_Pointer);
  PrepSDKCall_SetReturnInfo(SDKType_CBaseEntity, SDKPass_Pointer);
  hCreate = EndPrepSDKCall();
  if(!hCreate) SetFailState("CreateBot Signature broken.");

  StartPrepSDKCall(SDKCall_Player);
  if(!PrepSDKCall_SetFromConf(hGameData, SDKConf_Signature, "SetHumanSpec")) SetFailState("Failed to find signature: SetHumanSpec");
  PrepSDKCall_AddParameter(SDKType_CBasePlayer, SDKPass_Pointer);
  PrepSDKCall_SetReturnInfo(SDKType_Bool, SDKPass_Plain);
  hSpec = EndPrepSDKCall();
  if(!hSpec) SetFailState("Spectator Signature broken.");

  StartPrepSDKCall(SDKCall_Player);
  if(!PrepSDKCall_SetFromConf(hGameData, SDKConf_Signature, "TakeOverBot")) SetFailState("Failed to find signature: TakeOverBot");
  PrepSDKCall_AddParameter(SDKType_Bool, SDKPass_Plain);
  PrepSDKCall_SetReturnInfo(SDKType_Bool, SDKPass_Plain);
  hSwitch = EndPrepSDKCall();
  if(!hSwitch) SetFailState("TakeOver Signature broken.");

  StartPrepSDKCall(SDKCall_Player);
  if(!PrepSDKCall_SetFromConf(hGameData, SDKConf_Signature, "RoundRespawn")) SetFailState("Failed to find signature: Respawn");
  hRespawn = EndPrepSDKCall();
  if(!hRespawn) SetFailState("Respawn Signature broken.");

  StartPrepSDKCall(SDKCall_Player);
  if(!PrepSDKCall_SetFromConf(hGameData, SDKConf_Signature, "GoAwayFromKeyboard")) SetFailState("Failed to find signature: GoAwayFromKeyboard");
  PrepSDKCall_SetReturnInfo(SDKType_Bool, SDKPass_Plain);
  hGoAway = EndPrepSDKCall();
  if(!hGoAway) SetFailState("GoAwayFromKeyboard Signature broken.");

  GM_Create()
  //	如果需要生成，需要删除服务器上残留的配置文件
  //	AutoExecConfig(true, "rc_server");		
  //	AddGameLogHook(OnGameLogWrite);
  HookEvent("player_disconnect", Event_PlayerDisconnect);
  // 服务器初始名称
  ConVar hHostName = FindConVar("hostname");
  int flags = GetConVarFlags(hHostName)
  SetConVarFlags(hHostName, flags &~ FCVAR_NOTIFY);
  char sHostName[128];
  hHostName.GetString(sHostName, sizeof(sHostName) );
  SetConVarString(hHostName, sHostName);

  char path[PLATFORM_MAX_PATH];
  BuildPath(Path_SM, path, PLATFORM_MAX_PATH, "hostname.txt");
  bool hasHostName = FileExists(path);
  if (hasHostName)
  {
    File hFile;
    hFile = OpenFile(path, "rb");	
    if(hFile != null )
    {
      int len = FileSize(path);
      if(hFile.ReadString(ServerName, sizeof(ServerName), len-1) != -1)
      ServerCommand("hostname \"%s\"", ServerName);
      PrintToServer("读取:%s 字节长度:%d", ServerName, len);
    }
    delete hFile;
  }

  // 追踪难度&游戏模式变化	
  g_hGamemode = FindConVar("mp_gamemode");
  g_hDifficulty = FindConVar("z_difficulty");

  g_hGamemode.AddChangeHook(Event_ConVarChanged);
  g_hDifficulty.AddChangeHook(Event_ConVarChanged);

  CreateTimer(0.5, tAutoTickRate);
  AddCommandListener(fuc_CommandListener);
  AddCommandListener(Listener_CallVote, "callvote");

  RegConsoleCmd("sm_zs", cmd_zs);
  RegConsoleCmd("sm_kill", cmd_zs);
//  RegConsoleCmd("sm_jg", Cmd_Join);
//  RegConsoleCmd("sm_away", Cmd_Away);

  // 懒惰方法
  CreateTimer(5.0, tCookie);
  HookEvent("bot_player_replace", OnTakeOver);
}

public Action cmd_zs(int client, int args)
{

  if(IsPlayerAlive(client) )
  {
    PrefetchSound(ZS_Sound);
    PrecacheSound(ZS_Sound, true);
    EmitSoundToAll(ZS_Sound);
    ForcePlayerSuicide(client);
    CPrintToChatAll("{blue}%N 结束了自己的生命...", client);
  }

  return Plugin_Continue;
}

Action tCookie(Handle Timer)
{
  //cConnectServerHint = FindClientCookie("rc_menu_connectserverhint");
  cStatiGameTime = FindClientCookie("rc_stati_playtime_default_re2");

  ServerCommand("l4d2_infected_marker_announce_type \"1\"");
  ServerCommand("l4d2_item_hint_announce_type \"1\"");
  ServerCommand("l4d2_infected_marker_glow_color \"\"");
  ServerCommand("l4d2_item_hint_glow_color \"\"");
  ServerCommand("l4d2_item_instructorhint_enable \"0\"");
  ServerCommand("l4d2_spot_marker_color \"\"");
  ServerCommand("l4d2_spot_marker_instructorhint_enable \"0\"");
  ServerCommand("l4d2_spot_marker_sprite_model \"\"");     
  ServerExecute();

  return Plugin_Continue;
}

Action tAutoTickRate(Handle Timer)
{
  g_iServerTickRate = GetConVarInt(FindConVar("sv_minupdaterate") );
  return Plugin_Continue;
}
//---------------------------------------------------------------------------||
//		Cvar变更
//---------------------------------------------------------------------------||
public void Event_ConVarChanged(ConVar convar, const char[] oldValue, const char[] newValue){
  // 命令更改有延迟
  CreateTimer(1.0, tDelayApplyCvars);
}

Action tDelayApplyCvars(Handle Timer)
{
  ApplyCvars();
  return Plugin_Continue;
}

public void ApplyCvars()
{
  char sMode[24], sDiff[24];
  // sPrefix[24], suffix[32];

  int iWhatMode;

  g_hGamemode.GetString(sMode, sizeof(sMode) );
  g_hDifficulty.GetString(sDiff, sizeof(sDiff) );

  ServerCommand("l4d2_infected_marker_announce_type \"1\"");
  ServerCommand("l4d2_item_hint_announce_type \"1\"");
  ServerCommand("l4d2_infected_marker_glow_color \"\"");
  ServerCommand("l4d2_item_hint_glow_color \"\"");
  ServerCommand("l4d2_item_instructorhint_enable \"0\"");
  ServerCommand("l4d2_spot_marker_color \"\"");
  ServerCommand("l4d2_spot_marker_instructorhint_enable \"0\"");
  ServerCommand("l4d2_spot_marker_sprite_model \"\"");     
  ServerExecute();

  if(strcmp(sMode, "coop", false) == 0)
    Format(sMode, sizeof(sMode), "Campaign");
  else if(strcmp(sMode, "realism", false) == 0)
  {
    Format(sMode, sizeof(sMode), "Realism");
  }
  else if(strcmp(sMode, "survival", false) == 0)
  {
    Format(sMode, sizeof(sMode), "Survivor");		
    iWhatMode = 1;
  }
  else iWhatMode = 2;

  if(iWhatMode == 0)
  {
    // 高级，专家，在游戏中强制更改cvar必须是完整的名称：hard/Hard...
    // 而不是： h/H i/I ha/har...
    // 否则游戏的实际难度不会改变
    switch(sDiff[1])
    {
      case	'a':	Format(sDiff, sizeof(sDiff), "|Easy");
      case	'A':	Format(sDiff, sizeof(sDiff), "|Easy");
      case	'o':	Format(sDiff, sizeof(sDiff), "|Normal");
      case	'O':	Format(sDiff, sizeof(sDiff), "|Normal");
      case	'd':	Format(sDiff, sizeof(sDiff), "|Advanced");
      case	'D':	Format(sDiff, sizeof(sDiff), "|Advanced");
      case	'm':	Format(sDiff, sizeof(sDiff), "|Expert");
      case	'M':	Format(sDiff, sizeof(sDiff), "|Expert");
    }
  }
  else	if(iWhatMode == 2)
    Format(sDiff, sizeof(sDiff), "|Unknow");
  else	Format(sDiff, sizeof(sDiff), "Mode");

  char sHostName[64], sServerMode[16];
  GetConVarString(FindConVar("hostname"), sHostName, sizeof(sHostName) );
  if(g_bModeRealism_Load)
  {
    if(g_hModeRealism.IntValue == 1)
    {
      Format(sServerMode, sizeof(sServerMode), "Realism++");
      // 是不是两位数的服务器编号
      if(IsCharSpace(sHostName[3]) )
      {
        ServerCommand("hostname \"[GF]#%c %s%s|%s\"", sHostName[5], sMode, sDiff, sServerMode);
        Format(ServerName, sizeof(ServerName), "[GF]#%c %s%s|%s", sHostName[5], sMode, sDiff, sServerMode);
      }
      else
      {
        ServerCommand("hostname \"[GF]#%c%c %s%s|%s\"", sHostName[5], sHostName[6], sMode, sDiff, sServerMode);
        Format(ServerName, sizeof(ServerName), "[GF]#%c%c %s%s|%s", sHostName[5], sHostName[6],  sMode, sDiff, sServerMode);
      }
    }
  }
  // 既然关闭模式时会触发，那么不需要检查是否已经加载
  if(!sServerMode[0])
  {
    if(IsCharSpace(sHostName[6]) )
    {
      ServerCommand("hostname \"[GF]#%c %s%s|Vanilla\"", sHostName[5], sMode, sDiff);
      Format(ServerName, sizeof(ServerName), "[GF]#%c %s%s|Vanilla", sHostName[5], sMode, sDiff);
    }
    else
    {
      ServerCommand("hostname \"[GF]#%c%c %s%s|Vanilla\"", sHostName[5], sHostName[6], sMode, sDiff);
      Format(ServerName, sizeof(ServerName), "[GF]#%c%c %s%s|Vanilla", sHostName[5], sHostName[6], sMode, sDiff);      
    }
  }

}
//---------------------------------------------------------------------------||
//		阻止特定游戏模式
//---------------------------------------------------------------------------||
public bool OnClientConnect( int client, char []rejectmsg, int maxlen)
{
  ConVar hGameMode = FindConVar("mp_gamemode");
  char sGameMode[32];
  hGameMode.GetString(sGameMode, sizeof(sGameMode) );

  if(
    strcmp(sGameMode, "versus") == 0 
    ||	strcmp(sGameMode, "mutation12") == 0
    ||	strcmp(sGameMode, "mutation13") == 0
    ||	strcmp(sGameMode, "mutation15") == 0
    ||	strcmp(sGameMode, "mutation18") == 0
    ||	strcmp(sGameMode, "l4d1vs") == 0
  )
  {
    Format(rejectmsg, maxlen, "连接中断：不允许的游戏模式。");
    return false;
  }
  else	return true;
}
//---------------------------------------------------------------------------||
//		打印提示
//---------------------------------------------------------------------------||
bool PrintLobbyIsReservedHint[MAXPLAYERS+1];
bool PrintServerHint[MAXPLAYERS+1];

int	g_iPrintHint_ButtonsCount[MAXPLAYERS+1];

public void OnClientConnected(int client)
{
  g_bPlayerAwayPre[client] = false;

  if(IsFakeClient(client) )
    return;
  g_bAvaCmd[client] = true;

  PrintServerHint[client] = true;

  char tag[32];
  GetConVarString(FindConVar("sv_search_key"), tag, sizeof(tag) );
  if(strcmp(tag, "greenflu") == 0)
  {
    ServerCommand("sv_search_key \"\"");
    PrintToServer("\n %s : 大厅匹配密钥限制设置为空", PLUGIN_NAME);
    ServerCommand("sv_steamgroup_exclusive \"0\"");
    PrintToServer("\n %s : 组成员优先取消", PLUGIN_NAME);
  }
}
public void OnClientPutInServer(int client)
{
  int value = GetPlayerNum();
  if(value >= 4)
    ServerCommand("l4d_multislots_min_survivors %d", value);
}

public void OnClientDisconnect_Post(int client)
{
  PrintLobbyIsReservedHint[client] = false;
  g_iPrintHint_ButtonsCount[client] = 0;
  PrintServerHint[client] = false;
  int value = GetPlayerNum();
  if(value >= 4)
    ServerCommand("l4d_multislots_min_survivors %d", value);
}
public Action OnPlayerRunCmd(int client, int& buttons)
{
  // 目前这样是可以的
  if(!PrintServerHint[client])
    return Plugin_Continue;

  if(buttons & IN_FORWARD || buttons & IN_BACK ||  buttons & IN_LEFT ||  buttons & IN_RIGHT)
  {
    g_iPrintHint_ButtonsCount[client]++;
    if(g_iPrintHint_ButtonsCount[client] > g_iServerTickRate)
    {
      g_iPrintHint_ButtonsCount[client] = 0;
      PrintServerHint[client] = false;
      
      if(AreClientCookiesCached(client) )
      {
        CPrintToChat(client, "{blue}    ========    \x01");
        PrintToChat(client, "\x03  当前服务器    \x05%s", ServerName);
        PrintToChat(client, "\x04  Steam组: \x01");
        PrintToChat(client, "  steamcommunity.com/groups/GreenFluL4d");
        PrintToChat(client, "\x04  QQ群: \x05948265569\x01");
        CPrintToChat(client, "{blue}    ========    \x01");
        char sTime[64];
        GetClientCookie(client, cStatiGameTime, sTime, sizeof(sTime) );
        if(!sTime[0])
        {
          // 也可以在玩家断开连接时重置为false
          AllowSettings_ConnectServerHint[client] = false;
          return Plugin_Continue;
        }
      }
      if(PrintLobbyIsReservedHint[client])
      {
        PrintLobbyIsReservedHint[client] = false;
      }
    }
  }
  return Plugin_Continue;
}

//---------------------------------------------------------------------------||
//              命令白名单
//---------------------------------------------------------------------------||

#define	AvaCmdsNum		24
char AvailableCmds[][]=
{
  "sm_maps",
  "sm_hrchud_bc",
  "sm_hrchud_debug",
  "sm_rc",
  "sm_servers",
  "sm_ss",
  "sm_ecc",
  "sm_gm",
  "sm_mtp",
  "sm_mtph",
  "sm_zs",
  "sm_kill",
  "sm_mark",
  "sm_drop",
  "sm_cvar",
  "sm_join",
  "sm_away",
  "sm_ob",
  "sm_kick",
  "sm_ban",
  "sm_slay",
  "sm_slap"
};

public Action fuc_CommandListener(int client, const char[] command, int argc)
{
  if(client == 0)
    return Plugin_Continue;

  if(strncmp(command, "sm_", 3, false) == 0) 
  {
    if(strcmp(command, "sm_isee", false) == 0)
      return Plugin_Continue;

    if(strcmp(command, "sm_maps", false) == 0)
    {
      PrintToChat(client, "\x03   官方地图名称现在可以正常显示啦！");
      return Plugin_Continue;
    }
    for(int i =0; i<AvaCmdsNum; i++)
    {
      if(strcmp(command, "sm_join", false) == 0)
      {
        if(IsClientIdle(client) )
        {
          PrintToChat(client, "  请直接使用鼠标左键来加入游戏");
          break;
        }
      }
      if(strcmp(command, AvailableCmds[i], false) !=0)
      {
        g_bAvaCmd[client] = false;
        continue;
      }
      else
      {
        g_bAvaCmd[client] = true;
        if(i == 1)
        {
          //PrintToChat(client, "\x04[此菜单很快将重新制作]");
        }						
        break;
      }
    }
    if(!g_bAvaCmd[client])
    {
      PrintToChat(client, "查看服务器每日消息来确定哪些命令是可用的");
      PrintToServer("%s : 客户端%N 命令:%s 被阻止.", PLUGIN_NAME, client, command);
      return Plugin_Stop;	
    }
  }

  return Plugin_Continue;
}
//---------------------------------------------------------------------------||
//              离开消息
//---------------------------------------------------------------------------||
Action Event_PlayerDisconnect(Event event, const char[] name, bool dontBroadcast)
{
  int client = GetClientOfUserId(GetEventInt(event,"userid"));

  if (!(1 <= client <= MaxClients))
  return Plugin_Handled;

  if (!IsClientInGame(client))
  return Plugin_Handled;

  if (IsFakeClient(client))
  return Plugin_Handled;

  char reason[64];
  char message[128];
  GetEventString(event, "reason", reason, sizeof(reason));

  if(StrContains(reason, "connection rejected", false) != -1)
    Format(message,sizeof(message),"连接被拒绝");
  else if(StrContains(reason, "timed out", false) != -1)
    Format(message,sizeof(message),"连接超时");
  else if(StrContains(reason, "by user", false) != -1)
    Format(message,sizeof(message),"玩家断开连接");
  else if(StrContains(reason, "No Steam logon", false) != -1)
    Format(message,sizeof(message),"Steam账户验证失败");
  else if(StrContains(reason, "Steam account is being used in another", false) != -1)
    Format(message,sizeof(message),"Steam账户正在被其他人使用");
  else if(StrContains(reason, "Steam Connection lost", false) != -1)
    Format(message,sizeof(message),"与Steam的连接丢失");
  else if(StrContains(reason, "This Steam account does not own this game", false) != -1)
    Format(message,sizeof(message),"游戏所有权验证失败");
  else if(StrContains(reason, "Validation Rejected", false) != -1)
    Format(message,sizeof(message),"游戏文件验证失败");
  else	message = reason;

  PrintToChatAll("%N 已离开游戏，因为 ↓↓↓", client);
  PrintToChatAll("  %s", message);
   //	ServerCommand("say %N 已断开连接：%s", client, message);

  SetEventBroadcast(event, true)

  return Plugin_Continue;
}

//---------------------------------------------------------------------------||
//              阻止特定类型的投票
//---------------------------------------------------------------------------||
public Action Listener_CallVote(int client, const char[] command, int argc)
{
  char sIssue[32];
  GetCmdArg(1, sIssue, sizeof(sIssue));

  if(strcmp(sIssue, "returntolobby", false) == 0)
  {
    PrintToChat(client, "\x04[RC] \x03返回大厅\x01在此服务器上暂时无法正确执行，此操作已被禁用")
    return Plugin_Handled;
  }
  if(strcmp(sIssue, "restartgame", false) == 0)
  {
    PrintToChat(client, "\x04[RC] \x03重启战役\x01会将地图切换到当前战役的\x03第一个章节\x01，而不是重新开始当前的章节");
    return Plugin_Handled;
  }
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



#define ADMIN0  1166595366  // wo
#define ADMIN1  1266097403  // dp

// 此文件用于各种自定义管理员功能
void GM_Create()
{
  RegConsoleCmd("sm_gm", cmd_gm);   // 管理命令
  RegConsoleCmd("sm_ecc", cmd_ecc);   // 作弊命令
  //  RegAdminCmd("sm_mpos", cmd_mpos, ADMFLAG_ROOT);   // 打印自己角色模型基点POS
  //RegAdminCmd("sm_msunpos", cmd_msunpos);   // 设置太阳Pitch与Yaw
  RegAdminCmd("sm_mtp", cmd_mtp, ADMFLAG_ROOT);   // 传送到目标
  RegAdminCmd("sm_mtph", cmd_mtph, ADMFLAG_ROOT);   // 将目标传送到自己
  //  RegAdminCmd("sm_mfe", cmd_mfe, ADMFLAG_ROOT);   // 按规则寻找附近的实体(坐标)
}

public Action cmd_gm(int client, int args)
{
  if(client == 0)
    return Plugin_Continue;

  int id = GetSteamAccountID(client);
  if(!(id == ADMIN0|| id == ADMIN1 ))
    return Plugin_Continue;
  PrintToChat(client, "用法!gm sm_* 参数 参数 ...");

  char args_buffer[128]; 
  GetCmdArgString(args_buffer, sizeof(args_buffer) );
  if(StrContains(args_buffer, "sm_rcon")!= -1 || StrContains(args_buffer, "rc_ping_enable") != -1) 
  {
    return Plugin_Continue;
  }
  ExecuteRootCommand(client, args_buffer);
  ServerCommand("say [%N]# %s", client, args_buffer);

  return Plugin_Continue;
}

public Action cmd_ecc(int client, int args)
{
  if(client == 0)
    return Plugin_Continue;

  int id = GetSteamAccountID(client);
  if(!(id == ADMIN0 || id == ADMIN1 ))
    return Plugin_Continue;
  PrintToChat(client, "用法!ecc 命令 参数 参数 ...");

  char args_buffer[128]; 
  GetCmdArgString(args_buffer, sizeof(args_buffer) );
  if(StrContains(args_buffer, "rcon")!= -1 || StrContains(args_buffer, "rc_ping_enable") != -1) 
  {
    return Plugin_Continue;
  }
  ExecuteCheatCommand(client, args_buffer);
  ServerCommand("say [%N]# %s", client, args_buffer);

  return Plugin_Continue;
}

void ExecuteRootCommand(int client, const char[] cmd)
{
  int flag = GetUserFlagBits(client);
  bool hasFlag;
  if(flag == 0 || !(flag & ADMFLAG_ROOT) )
  {
    hasFlag = true;
    SetUserFlagBits(client, flag | ADMFLAG_ROOT);
	}
  FakeClientCommand(client, cmd);
  if(hasFlag)
	  SetUserFlagBits(client, flag & ~ADMFLAG_ROOT);
}

void ExecuteCheatCommand(int client, const char[] cmd)
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

public Action cmd_mtp(int client, int args)
{
  if(client == 0)
    return Plugin_Continue;

  for(int i=1; i<=MaxClients; i++)
  {
    if(IsClientInGame(i) )
    {
      PrintToChat(client, "%N # UserId: %d", i, GetClientUserId(i) );
    }
  }
  char args_buffer[10];
  char buffer[2][6];
  GetCmdArgString(args_buffer, sizeof(args_buffer) );
  ExplodeString(args_buffer, " ", buffer, 2, 6);
  
  PrintToChat(client, "用法!mtp 目标玩家UserId");
  int userid = StringToInt(buffer[0]);
 // PrintToChatAll("?%s", buffer[0]);
  float pos[3];
  int target = GetClientOfUserId(userid);
  if(userid != 0)
  {
    GetClientAbsOrigin(target, pos);
    TeleportEntity(client, pos, NULL_VECTOR, NULL_VECTOR);
  }
  else PrintToChat(client, "无效的UserId");
  
  return Plugin_Continue;
}

public Action cmd_mtph(int client, int args)
{
  if(client == 0)
    return Plugin_Continue;

  char args_buffer[10];
  char buffer[2][6];
  GetCmdArgString(args_buffer, sizeof(args_buffer) );
  ExplodeString(args_buffer, " ", buffer, 2, 6);
  
  PrintToChat(client, "用法!mtph 参数[0=全部，1=观察者,2=幸存者,3=感染者]");
  int type = StringToInt(buffer[0]);
 
  float pos[3];
  GetClientAbsOrigin(client, pos);
  for(int i=1; i<=MaxClients; i++)
  {
    if(IsClientInGame(i) )
    {
      
      if(type == 0) 
        TeleportEntity(i, pos, NULL_VECTOR, NULL_VECTOR);
    
      else if(GetClientTeam(i) == type)
        TeleportEntity(i, pos, NULL_VECTOR, NULL_VECTOR);
    }
  }
  return Plugin_Continue;
}

#define TEAM_SPECTATOR 2
#define TEAM_SURVIVOR 2
#define TEAM_INFECTED 3
#define isBot(%1) (IsClientInGame(%1) && IsFakeClient(%1))
#define isPlayer(%1) (IsClientInGame(%1) && !IsFakeClient(%1))
#define isSpectator(%1) (GetClientTeam(%1) == TEAM_SPECTATOR)
#define isSurvivor(%1) (GetClientTeam(%1) == TEAM_SURVIVOR)
public Action Cmd_Join(int client, int args) {
	if(client && isPlayer(client)) {
		if(isSpectator(client)) Join(client);
		else PrintToChat(client, "你必须是一名旁观者");
	}
	return Plugin_Handled;
}

public Action Cmd_Away(int client, int args) {
	if(client && isPlayer(client) ) 
  {
    if(g_hModeRealism.IntValue == 1 )
    {
      if(!g_bPlayerAwayPre[client])
      {
      g_bPlayerAwayPre[client] = true;
      PrintToChat(client, "[等待一段时间后，将加入旁观者队伍]");
      CreateTimer( (GetRandomFloat(600.000, 1200.000) / 100), t_PlayerAway, client, TIMER_FLAG_NO_MAPCHANGE);
      }
      else  PrintToChat(client, "[请等待!]");

      return Plugin_Handled;
    }    
    ChangeClientTeam(client, TEAM_SPECTATOR);
	}
	return Plugin_Handled;
}

Action t_PlayerAway(Handle Timer, any client)
{
  if(!isPlayer(client) )
    return Plugin_Continue;

  g_bPlayerAwayPre[client] = false;
  ChangeClientTeam(client, TEAM_SPECTATOR);

  return Plugin_Continue;
}

void Join(int client) {
	if(IsClientDead(client)) {
		PrintToChat(client, "你目前已经死亡");
		return;
	}

	for(int i = 1; i <= MaxClients; i++) {
		if(isBot(i) && IsPlayerAlive(i)) {
			char classname[12];
			GetEntityNetClass(i, classname, 12);
			if(StrEqual(classname, "SurvivorBot") && TakeOverBot(client, i)) return;
		}
	}
	PrintToChat(client, "没有空闲的幸存者机器人");
}
int plList[32][3];  // ArrayStack
public void OnRoundEnd(Event event, const char[] name, bool dontBroadcast) {
	plList[0][i_Id] = 0;  // reset
}

public void OnPlayerAfk(Event event, const char[] name, bool dontBroadcast) {
	int client = GetClientOfUserId(GetEventInt(event, "player", 0));
	if(!client || !isPlayer(client) || !isSurvivor(client)) return;  // 创建bot会触发
	int i = 0;
	for(; i < sizeof(plList) - 1 && plList[i][i_Id]; i++) {
	}  // count
	for(int j = i; j > 0; j--) {
		for(int k = 0; k < 3; k++) {  // Save_Key
			plList[j][k] = plList[j - 1][k];
		}
	}
	plList[0][i_Id] = GetSteamAccountID(client);
	if(IsPlayerAlive(client)) {
		plList[0][i_Hp] = GetClientHealth(client);
		plList[0][i_Rev] = GetEntProp(client, Prop_Send, "m_currentReviveCount");  
	} else {
		plList[0][i_Hp] = 0;
		plList[0][i_Rev] = 0;
	}
	PrintToServer("[DEBUG] 保存数据 id[%d] hp[%d] rev[%d]", plList[0][i_Id], plList[0][i_Hp], plList[0][i_Rev]);
}
enum Save_Key {
	i_Id = 0,
	i_Hp,
	i_Rev
}
public void OnTakeOver(Event event, const char[] name, bool dontBroadcast) {
	int client = GetClientOfUserId(GetEventInt(event, "player", 0));
	if(!client || !isSurvivor(client)) return;
	int id = GetSteamAccountID(client);
	if(!id) {
		ForcePlayerSuicide(client);
		PrintToChat(client, "\x05[提示] \x04无法验证steamid,默认死亡状态");
		return;
	}
	for(int j = 0; j < sizeof(plList) && plList[j][i_Id]; j++) {  // 注意round_end
		if(plList[j][i_Id] == id) {
			PrintToServer("[DEBUG] id[%d] hp[%d] rev[%d]", plList[j][i_Id], plList[j][i_Hp], plList[j][i_Rev]);
			int flag = 0;
			if(GetClientHealth(client) > plList[j][i_Hp]) {
				if(!plList[j][i_Hp]) ForcePlayerSuicide(client);
				else SetEntityHealth(client, plList[j][i_Hp]);
				flag |= 1;
			}
			if(GetEntProp(client, Prop_Send, "m_currentReviveCount") < plList[j][i_Rev]) {
				SetEntProp(client, Prop_Send, "m_currentReviveCount", plList[j][i_Rev]);
				flag |= 2;
			}
			if(flag) PrintToChatAll("\x05[提示] \x03%N \x04重复接管Bot, %s%s%s", client, flag & 1 ? "恢复血量" : "", flag == 3 ? "及" : (flag & 2 ? "恢复" : ""), flag & 2 ? "倒地次数" : "");
			return;
		}
	}
}

bool IsClientDead(int client, bool ignore = true) {
	int id = GetSteamAccountID(client);
	if(!id) return !ignore;
	for(int j = 0; j < sizeof(plList) && plList[j][i_Id]; j++) {
		if(plList[j][i_Id] == id) return !plList[j][i_Hp];
	}
	return false;
}

bool TakeOverBot(int client, int bot) {
	SDKCall(hSpec, bot, client);
	return SDKCall(hSwitch, client, true);
}

stock bool IsClientIdle(client)
{
    for(new i = 1; i <= MaxClients; i++)
    {
        if(!IsClientConnected(i))
            continue
        if(!IsClientInGame(i))
            continue
        if(GetClientTeam(i)!=2)
            continue
        if(!IsFakeClient(i))
            continue
        if(!HasIdlePlayer(i))
            continue
        
        new spectator_userid = GetEntData(i, FindSendPropInfo("SurvivorBot", "m_humanSpectatorUserID"))
        new spectator_client = GetClientOfUserId(spectator_userid)
        
        if(spectator_client == client)
            return true
    }
    return false
}

stock bool HasIdlePlayer(bot)
{
    new userid = GetEntData(bot, FindSendPropInfo("SurvivorBot", "m_humanSpectatorUserID"))
    new client = GetClientOfUserId(userid)
    
    if(client)
    {
        // Do not count bots
        // Do not count 3rd person view players
        if(IsClientInGame(client) && !IsFakeClient(client) && (GetClientTeam(client)!=2))
            return true
    }    
    return false
}

stock int GetPlayerNum()
{
  int count;
  for(int i =1; i<=MaxClients; i++)
  {
    //https://forums.alliedmods.net/archive/index.php/t-132438.html
    if(IsClientConnected(i) )
    {
      if(!IsFakeClient(i) )
        count++;
    }
  }
  return count;
}
