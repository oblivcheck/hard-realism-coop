#include <sourcemod>
#include <sdkhooks>
#include <sdktools>
#include <basecomm>
#include <left4dhooks>

#define PLUGIN_NAME             "HRC HUD"
#define PLUGIN_DESCRIPTION      "针对Realism的HUD调整."
#define PLUGIN_VERSION          "2.0 beta"
#define PLUGIN_AUTHOR           "oblivcheck"
#define PLUGIN_URL              ""

/*	>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>变更日志
2024-07-11 (2.0 beta )
  - 基于 1.4.8b (2024-06-02) 的变体

*/

#define HUD_FLAG_NONE                 0     // no flag
#define HUD_FLAG_PRESTR               1     // do you want a string/value pair to start(pre) wit>
#define HUD_FLAG_POSTSTR              2     // do you want a string/value pair to end(post) with>
#define HUD_FLAG_BEEP                 4     // Makes a countdown timer blink
#define HUD_FLAG_BLINK                8     // do you want this field to be blinking
#define HUD_FLAG_AS_TIME              16    // ?
#define HUD_FLAG_COUNTDOWN_WARN       32    // auto blink when the timer gets under 10 seconds
#define HUD_FLAG_NOBG                 64    // dont draw the background box for this UI element
#define HUD_FLAG_ALLOWNEGTIMER        128   // by default Timers stop on 0:00 to avoid briefly g>
#define HUD_FLAG_ALIGN_LEFT           256   // Left justify this text
#define HUD_FLAG_ALIGN_CENTER         512   // Center justify this text
#define HUD_FLAG_ALIGN_RIGHT          768   // Right justify this text
#define HUD_FLAG_TEAM_SURVIVORS       1024  // only show to the survivor team
#define HUD_FLAG_TEAM_INFECTED        2048  // only show to the special infected team
#define HUD_FLAG_TEAM_MASK            3072  // ?
#define HUD_FLAG_UNKNOWN1             4096  // ?
#define HUD_FLAG_TEXT                 8192  // ?
#define HUD_FLAG_NOTVISIBLE           16384 // if you want to keep the slot data but keep it fro>


#define	DELAY_HIDEHUD_TIMER		95.0
#define	ITL_ASK_MSG			15.0

#define	MENU_SHOWHUD_TIMER		65.0
#define	MENU_SHOWHUD_TIMER_TRY		3.0	//对于重新启动BC菜单的菜单，最多允许存在的时间

#define	SENDCHAT_SHOWHUD_TIME		15.0

#define EMSHUD_CHATBUFFER_SIZE		127
char	g_sEMSHUD_ChatHint[EMSHUD_CHATBUFFER_SIZE];
ArrayList g_sEMSHUD_ChatBuffer;
ArrayList g_iEMSHUD_ChatShowTime;
ArrayList g_fEMSHUD_ChatSendTime;
ArrayList g_sEMSHUD_ChatClient;

//1080p最好0.026，720p 0.35 注意！这是约等于
#define EMSHUD_DPI_HEIGHT_BIG			0.021
#define EMSHUD_DPI_HEIGHT_NORMAL		0.016
#define	EMSHUD_FLAG_CHAT			HUD_FLAG_ALIGN_CENTER | HUD_FLAG_TEXT | HUD_FLAG_NOBG

#define PRINT_HP_ITL				6	//按住时，打印生命值的间隔乘子 秒 仅用于静步时
#define ONESHOT_PRINT_MSG_INGAME_TIME_CHECK	300.0	//不重复发送提示的检查连接时间设置

int HUD_Flags = EMSHUD_FLAG_CHAT;

#define EMSHUD_MAX_CHATLOG_BUFFERSIZE		160	//聊天消息最多存储多少

Handle	g_tUpdateInterval;

public Plugin:myinfo ={
        name = PLUGIN_NAME,
        author = PLUGIN_AUTHOR,
        description = PLUGIN_DESCRIPTION,
        version = PLUGIN_VERSION,
        url = PLUGIN_URL
}

ConVar	cHRC_hud_enable;
bool	g_bHRC_hud_enable;

ConVar	cHRC_hud_show_key;
int	g_iHRC_hud_show_key;
int	ShowKey = IN_SPEED;

int	g_iAuthHintCount[MAXPLAYERS+1];
bool	g_bWhenEnableInGame[MAXPLAYERS+1];	//不这么做， 插件启用时在游戏内的玩家不会隐藏HUD

int	g_iServerTickRate;
int	g_iPrintHP_Count;
int	g_iSkip_Count;
int	g_iMenuReShow_Count;
int	g_iReloadBC_Count_Hold;

int	g_iHavaBC[MAXPLAYERS+1];
int	g_iClient_Count[MAXPLAYERS+1];
bool	g_bShouldHideHUD[MAXPLAYERS+1];		//只负责打印提示与第一次加入时的隐藏设置，过渡时可能出现重复提示(version < 1.4.0 beta)
bool	g_bPlayerDisconnect[MAXPLAYERS+1];
bool	g_bMenuShowHUD[MAXPLAYERS+1];
bool	g_bShowHUD_SendChat[MAXPLAYERS+1]
bool	g_bShowHUD_SendChat_Allow[MAXPLAYERS+1] = {true, ...};
bool	g_bPrintHPImmed_AlreadySend[MAXPLAYERS+1];
bool	g_bPlayer_TOR_BC[MAXPLAYERS+1];
int	g_iPrintHP_HoldTimer[MAXPLAYERS+1];
int	g_iReloadBC_Count[MAXPLAYERS+1];
bool	g_bTryReStartBcMenu[MAXPLAYERS+1];

int	g_iPrintHint_ButtonsCount[MAXPLAYERS+1]

int	g_iskipped;

char	tlist[32][8];

bool	g_bIsHRC_Server = true;

//关于重置切换武器的动作，参见https://forums.alliedmods.net/showthread.php?t=280143
Handle g_hSwitchWeaponCall = null;
public void OnPluginStart(){


	g_sEMSHUD_ChatBuffer = new ArrayList(EMSHUD_CHATBUFFER_SIZE);
	g_iEMSHUD_ChatShowTime = new ArrayList(1);
	g_fEMSHUD_ChatSendTime = new ArrayList(1);
	g_sEMSHUD_ChatClient = new ArrayList(32);

	delete g_tUpdateInterval;
	if(g_bHRC_hud_enable)
	{
		g_tUpdateInterval = CreateTimer(0.5, TimerUpdateHUD, _, TIMER_REPEAT);
	}

	Handle hConfig = LoadGameConfigFile("sdkhooks.games");

	StartPrepSDKCall(SDKCall_Player);
	PrepSDKCall_SetFromConf(hConfig, SDKConf_Virtual, "Weapon_Switch");
	PrepSDKCall_AddParameter(SDKType_CBaseEntity, SDKPass_Pointer);
	PrepSDKCall_AddParameter(SDKType_PlainOldData, SDKPass_Plain);

	g_hSwitchWeaponCall = EndPrepSDKCall();

	CloseHandle(hConfig);

	AddNormalSoundHook(SoundHook)
	RegAdminCmd("sm_hrchud_debug", Command_Debug, ADMFLAG_ROOT, "");

	static char buffer[128];
	Format(buffer, sizeof(buffer), "@,/" );
	for (int i = 0; i < sizeof tlist; i++)	tlist[i] = "";
	ExplodeString(buffer, ",", tlist, sizeof tlist, sizeof tlist[]);	

	cHRC_hud_enable = CreateConVar("hrc_hud_enable", "1", "Enable or Disable", FCVAR_NOTIFY);
	cHRC_hud_show_key = CreateConVar("hrc_hud_show_key", "1", "0为静步，1为TAB计分板" );
	
	g_bHRC_hud_enable = cHRC_hud_enable.BoolValue;
	g_iHRC_hud_show_key = cHRC_hud_show_key.IntValue;

	cHRC_hud_show_key.AddChangeHook(Event_ConVarChanged);
	cHRC_hud_enable.AddChangeHook(Event_ConVarChanged);

  tAutoTickRate();

	RegConsoleCmd("sm_hrchud_bc", cmd_bc);

//	CreateTimer(0.5, tDelayCheckHostName);	

  for(int i=1; i< MaxClients+1 ;i++)
  {
  	if(!g_bHRC_hud_enable)
  		return;
    if(!IsClientConnected(i) )
      continue
   	if(IsFakeClient(i) )
  		continue;
  	{
  		g_iHavaBC[i] = 1;
  		g_bPlayer_TOR_BC[i] = true;
  	}
  	g_bPlayerDisconnect[i] = false;
  	g_bWhenEnableInGame[i] = false;

  }
}

//Action tAutoTickRate(Handle Timer)
void tAutoTickRate()
{
	g_iServerTickRate = 96;
	g_iPrintHP_Count = g_iServerTickRate * PRINT_HP_ITL;
	g_iSkip_Count = g_iServerTickRate / 5;
	g_iMenuReShow_Count = g_iServerTickRate / 5;
	g_iReloadBC_Count_Hold = g_iServerTickRate * 2;

	if(g_bHRC_hud_enable)
		ServerCommand("sm plugins unload hideHUD");
	
	if(g_bIsHRC_Server)
		CreateTimer(0.2, tDelayChangeHRCCvar)

//	PrintToServer("\n[HRC HUD] 检测服务器tickrate为:%d", g_iServerTickRate);
}

Action tDelayChangeHRCCvar(Handle Timer)
{
	ServerCommand("sm_cvar hrc_hud_enable 1");
	ServerCommand("sm_cvar hrc_hud_show_key 0");
	return Plugin_Continue;
}

Action Command_Debug (int client, int args)
{
//	char arg1[4];
//	GetCmdArg(1, arg1, sizeof(arg1));
//	PrintToChat(client, "共享聊天框显示时间:%d", g_iPlayerChatSend_ShowHUD_Time);
	if(client == 0) return Plugin_Handled;
	for(int i=1;i<=MaxClients;i++)
	{
		if(IsValidClient(i) && !IsFakeClient(i) )
		{
			int mihud = GetEntProp(i, Prop_Send, "m_iHideHUD");
			PrintToChat(client, "名称:%N, iBC:%d, SHUD:%d, DISCONNECT:%d, miHUD:%d, 正在隐藏?:%d", i, g_iHavaBC[i], g_bShouldHideHUD[i], g_bPlayerDisconnect[i], mihud, (mihud & 4) );
			PrintToChat(client, "Should:%d, MenuShow:%d, SendChatShow:%d SendChatShow_Allow:%d, 准入提示次数:%d, 正在验证?:n/a", g_bShouldHideHUD[i], g_bMenuShowHUD[i],  g_bShowHUD_SendChat[i], g_bShowHUD_SendChat_Allow[i], g_iAuthHintCount[i]);
		}
	}

	return Plugin_Handled;
}

public Action cmd_bc(int client, int args)
{
	if(!g_bHRC_hud_enable)	return Plugin_Handled;
	if(g_iHavaBC[client] == 1 && !g_bShouldHideHUD[client])
	{
		if(GetEntProp(client, Prop_Send, "m_iHideHUD") & 4)
		{
			if(GetClientMenu(client) == MenuSource_None)
			{
				ButtonsCheck(client);
				PrintToChat(client, "\x04[%s]\x01已尝试重新启动检查菜单",  g_bIsHRC_Server ? "HRC" : "RC");
			}
			else	PrintToChat(client, "\x04[%s]\x01目前存在菜单，或者先取消存在的其它菜单",  g_bIsHRC_Server ? "HRC" : "RC");
		}
	}
	return Plugin_Handled;
}
//---------------------------------------------------------------------------||
//		阻止用于检查按钮的菜单发出声音
//---------------------------------------------------------------------------||
public Action SoundHook(int clients[64], int& numClients, char sample[PLATFORM_MAX_PATH], int& entity, int& channel, float& volume, int& level, int& pitch, int& flags)
{
	if(!g_bHRC_hud_enable)
		return Plugin_Continue;

        if(!IsValidEntity(entity) )
                return Plugin_Continue;
        if(!IsValidClient(entity) )
                return Plugin_Continue;
        if(IsFakeClient(entity) )
                return Plugin_Continue;
	if(!strcmp(sample, "buttons/button14.wav", false) && g_iHavaBC[entity] == 1)
		return Plugin_Handled;
	return Plugin_Continue;
}
//---------------------------------------------------------------------------||
//		设置用于启动函数判断的标志
//---------------------------------------------------------------------------||
public void OnClientConnected(int client)
{
	if(!g_bHRC_hud_enable)
		return;
	if(IsFakeClient(client) )
		return;
	{
		g_iHavaBC[client] = 1;
		g_bPlayer_TOR_BC[client] = true;
//		CreateTimer(5.0, tBC, client);
	}
	g_bPlayerDisconnect[client] = false;
	g_bWhenEnableInGame[client] = false;

}
/*
Action tBC(Handle Timer, any client)
{
	if(!g_bHRC_hud_enable)
		return Plugin_Continue;
	if(IsClientInGame(client) && !IsFakeClient(client)  )
	{
		g_iHavaBC[client] = 1;
//		ButtonsCheck(client);
	}
	return Plugin_Continue;

}
*/
public void OnClientDisconnect_Post(int client)
{
	g_iHavaBC[client] = 0;
	g_iClient_Count[client] = 0;
	g_bShouldHideHUD[client] = false;
	g_bPlayerDisconnect[client] = true;
	g_bMenuShowHUD[client] = false;
	g_bShowHUD_SendChat[client] = false;
	g_bShowHUD_SendChat_Allow[client] = true;
	g_bPrintHPImmed_AlreadySend[client] = false;
	g_bPlayer_TOR_BC[client] = false;
	g_iPrintHint_ButtonsCount[client] = 0;
	g_iPrintHP_HoldTimer[client] = 0;
	g_iReloadBC_Count[client] = 0;
	g_bTryReStartBcMenu[client] = false;
	g_iAuthHintCount[client] = 0;
	g_bWhenEnableInGame[client] = false;
}

//---------------------------------------------------------------------------||
//		检查按下了哪个数字按键
//---------------------------------------------------------------------------||
void ButtonsCheck(int client)
{
	if(!g_bHRC_hud_enable)
		return;
	
	if(IsValidClient(client) && !IsFakeClient(client) )
	{

		Menu BC = new Menu(BC_MenuHandler);
		BC.SetTitle("用于检查数字键的菜单");
		BC.AddItem("检查装备槽位", "检查装备槽位");
		BC.AddItem("检查装备槽位", "检查装备槽位");
		BC.AddItem("检查装备槽位", "检查装备槽位");
		BC.AddItem("检查装备槽位", "检查装备槽位");
		BC.AddItem("检查装备槽位", "检查装备槽位");
//		BC.AddItem("快速智能语音", "快速智能语音");
		BC.AddItem("占位符", "占位符");		
		BC.AddItem("暂时显示HUD", "暂时显示HUD");
//		BC.AddItem("占位符", "占位符");
//		BC.AddItem("占位符", "占位符");
//		BC.AddItem("第三人称切换, "第三人称切换");
		
		BC.ExitButton = false;
		BC.Display(client, MENU_TIME_FOREVER);
	}
}


public int BC_MenuHandler(Menu menu, MenuAction action, int param1, int param2)
{
	if(!g_bHRC_hud_enable)
		return 0;

	if(action == MenuAction_Select)
	{
		int weapon = GetPlayerWeaponSlot(param1, param2);
		if(weapon != -1)
		{
			//我现在怀疑存在逻辑问题，如果只是return，那么实际上任何菜单都无法打开，并且也无法使用R快捷键来试图重启
			if(L4D_IsPlayerIncapacitated(param1) )
			{
				ButtonsCheck(param1);
				return 0;
			}
			//主武器
			if(param2 == 0)
			{
				//当存在升级弹药时，Ammo的值会是实际总普通弹药量+特殊弹药量*2和，这会比实际可用弹药量多
				int ammo =  GetEntProp(weapon, Prop_Send, "m_nUpgradedPrimaryAmmoLoaded") + GetEntProp(weapon, Prop_Send, "m_iClip1") + GetClientReservedAmmo(weapon, param1);
//				PrintToChatAll("Ammo:%d", ammo);
				if(ammo <= 0)
				{
					ButtonsCheck(param1);
					return 0;
				}
			}
			SwitchToWeapon(param1, weapon);
		}
//		else	ButtonsCheck(param1);

		//给出一定时间，让绑定在数字键位上的客户端键位命令可以通过再次按下来正确触发
		if(param2 == 5)	
		{
			CreateTimer(0.3, tDelay, param1);
			return 0;
		}
		if(param2 == 6 && !g_bShowHUD_SendChat[param1] && g_bShowHUD_SendChat_Allow[param1])
		{
			CreateTimer(0.3, tDelay, param1);
			
			PrintToChat(param1, "\x04[%s]\x01此快捷键只会让HUD显示15秒，并具备30秒的冷却", g_bIsHRC_Server ? "HRC" : "RC");

			g_bShowHUD_SendChat[param1] = true;
			g_bShowHUD_SendChat_Allow[param1] = false;

			CreateTimer(SENDCHAT_SHOWHUD_TIME, tShowHUD_SendChat, param1);
			CreateTimer(SENDCHAT_SHOWHUD_TIME * 3, tShowHUD_SendChat_Allow, param1);
			return 0;
		}

		ButtonsCheck(param1);

		return 0;
	}


	if(action == MenuAction_Cancel)
	{
		if(param2 == 1 || param2 == 4 || param2 == 5)
		{
			LogError("客户端%N, 遇到意料之中的错误:%d", param1, param2);
			ButtonsCheck(param1);
			return 0;
		}
		//如果有其他菜单占用了位置，那么就不应该重新显示这里的菜单以避免无限递归导致的堆栈溢出
		if(param2 == MenuCancel_Interrupted)
		{
			g_iHavaBC[param1] = -1;
			return 0;
		}
		//给出一定时间，让绑定在数字键位上的客户端键位命令可以通过再次按下来正确触发
		CreateTimer(0.3, tDelay, param1);
	}
	if(action == MenuAction_End)	delete menu;

	return 0;
}

Action tShowHUD_SendChat(Handle Timer, any client)
{
	if(!g_bHRC_hud_enable)	return Plugin_Continue;

	g_bShowHUD_SendChat[client] = false;

	return Plugin_Continue;
}
Action tShowHUD_SendChat_Allow(Handle Timer, any client)
{
	if(!g_bHRC_hud_enable)	return Plugin_Continue;

	g_bShowHUD_SendChat_Allow[client] = true;

	return Plugin_Continue;
}
Action tDelay(Handle Timer, any client)
{
	if(!g_bHRC_hud_enable)	return Plugin_Continue;

	if(IsValidClient(client) && !IsFakeClient(client) )
	{
		ButtonsCheck(client);	
	}
	return Plugin_Continue;
}

//---------------------------------------------------------------------------||
//		隐藏HUD
//---------------------------------------------------------------------------||
public void OnGameFrame() {
	if(!g_bHRC_hud_enable)
		return;
	for(int i = 0; i < g_iEMSHUD_ChatShowTime.Length; i++)
	{
		if(g_iEMSHUD_ChatShowTime.Get(i) > 0)
		{
			g_iEMSHUD_ChatShowTime.Set(i, g_iEMSHUD_ChatShowTime.Get(i) - 1);
			break;
		}
	}

	if (++g_iskipped >= g_iSkip_Count ) {
		g_iskipped = 0;
		for (int client = 1; client <= MaxClients; client++) {
//        PrintToChatAll("%N 0", client)

			if (IsClientInGame(client) && !IsFakeClient(client)) {
				bool HaveMenu = (GetClientMenu(client) != MenuSource_None );
				//临时修复过渡转换后的玩家BC面板必定消失的问题
				if(g_bPlayer_TOR_BC[client] && g_iHavaBC[client] == 1)
				{
					ButtonsCheck(client);
					g_bPlayer_TOR_BC[client] = false;
				}
				if(g_iHavaBC[client] == -1 && !HaveMenu)
				{
					//其它菜单消失后多久，按钮检查菜单重新显示
					if(++g_iClient_Count[client] >= g_iMenuReShow_Count )
					{
						g_bMenuShowHUD[client] = false;
						g_iHavaBC[client] = 1;
						g_iClient_Count[client] = 0;
						ButtonsCheck(client);
					}
				}

				int flags_hud = GetEntProp(client, Prop_Send, "m_iHideHUD");
				int buttons = GetClientButtons(client)
				if(g_bShowHUD_SendChat[client])
				{
						flags_hud = flags_hud & ~4;
						flags_hud = flags_hud & ~64;						
						SetEntProp(client, Prop_Send, "m_iHideHUD", flags_hud);					
				}

				//存在菜单，HUD部分显示
				if(HaveMenu && g_iHavaBC[client] == -1 )
				{
					if(!g_bMenuShowHUD[client] )
					{
						if(g_bTryReStartBcMenu[client])
						{
							CreateTimer(MENU_SHOWHUD_TIMER_TRY, tMenuShowHUD, client);
						}
						else	CreateTimer(MENU_SHOWHUD_TIMER, tMenuShowHUD, client);
						PrintToChat(client, "\x04[菜单总是会在一段时间后关闭]\x01");
						g_bMenuShowHUD[client] = true;
					}
					if(flags_hud & 64 || flags_hud & 4)
					{
						flags_hud = flags_hud & ~4;
						flags_hud = flags_hud & ~64;						
						SetEntProp(client, Prop_Send, "m_iHideHUD", flags_hud);
					}
					continue;
				}
				if(g_bShowHUD_SendChat[client])
					continue;
				if(
					
					((buttons & ShowKey)			||
					(GetEntPropEnt(client, Prop_Send, "m_hZoomOwner") != INVALID_ENT_REFERENCE) ) 
					&& !g_bMenuShowHUD[client]
					&& g_iHavaBC[client] == 1
				)	
				{
					flags_hud = flags_hud & ~4;

					SetEntProp(client, Prop_Send, "m_iHideHUD", flags_hud | 64);
					
					if(buttons & ShowKey && IsPlayerAlive(client) )
					{
						//这受最小检查时间的限制
						g_iPrintHP_HoldTimer[client] =  g_iPrintHP_HoldTimer[client] + g_iSkip_Count;
						bool Incap =  L4D_IsPlayerIncapacitated(client);

						//不应该合并获取生命值的代码，因为不同设置的生命值提示刷新速率是不一样的，避免获取到不正确的数据?
						if(ShowKey == IN_SCORE)
						{
					                int health = GetEntProp(client, Prop_Send, "m_iHealth");
							int realHp = GetClientRealHealth(client);
							if(realHp == -1)
							{        
								realHp = 0;     //我认为需要检查倒地后Temp是否会变成生命值的一部分
								health = 0;
							}
							PrintCenterText(client, "**生命值:%d [%d|%d]", Incap ? health : realHp, health, Incap ? 0 : realHp - health);
						}
						else
						{
							if(!g_bPrintHPImmed_AlreadySend[client])
							{
								if(g_iPrintHP_HoldTimer[client] < g_iPrintHP_Count)
								{
									g_bPrintHPImmed_AlreadySend[client] = true;

							                int health = GetEntProp(client, Prop_Send, "m_iHealth");
									int realHp = GetClientRealHealth(client);
									if(realHp == -1)
									{        
										realHp = 0;     //我认为需要检查倒地后Temp是否会变成生命值的一部分
										health = 0;
									}
									//倒地后Temp还存在哦，但是起身似乎就清空的
									//建议保留，因为中央文本也许存在DPI问题
									PrintToChat(client, "\x04**\x05生命值:\x03%d\x01 [\x05%d\x01|\x04%d\x01]", Incap ? health : realHp, health, Incap ? -23333 : realHp - health);
								}
							}
							else
							{
								if(g_iPrintHP_HoldTimer[client] >= g_iPrintHP_Count)
								{
									g_iPrintHP_HoldTimer[client] = 0;
							                int health = GetEntProp(client, Prop_Send, "m_iHealth");
									int realHp = GetClientRealHealth(client);
									if(realHp == -1)
									{        
										realHp = 0;     //我认为需要检查倒地后Temp是否会变成生命值的一部分
										health = 0;
									}
									//提示框会被关闭，同时TAB计分板遮挡聊天
									PrintToChat(client, "\x04[\01如果无法切换武器，按住重新装填R键一段时间以重启检查菜单\x04]\x01");
									PrintToChat(client, "\x05生命值:\x03%d\x01 [\x05%d\x01|\x04%d\x01]", Incap ? health : realHp, health, Incap ? -23333 : realHp - health);
								}
							}
						}
					}
					else
					{
						g_iPrintHP_HoldTimer[client] = 0;
						g_bPrintHPImmed_AlreadySend[client] = false;
					}
				}
				else
				{	
					g_iPrintHP_HoldTimer[client] = 0;
					g_bPrintHPImmed_AlreadySend[client] = false;

					if(g_iHavaBC[client] == 1)
					{
						if(g_iPrintHP_HoldTimer[client])	g_iPrintHP_HoldTimer[client] = false;
  						flags_hud = flags_hud & ~64;
  						SetEntProp(client, Prop_Send, "m_iHideHUD", flags_hud | 4); 
					}
				}
			}
		}
	}
}
Action tMenuShowHUD(Handle Timer, any client)
{
	if(!g_bHRC_hud_enable)
		return Plugin_Continue;
	if(IsValidClient(client) && !IsFakeClient(client) )
	{
		if(g_iHavaBC[client] == -1 )
		{
			g_iHavaBC[client] = 1;
			g_bMenuShowHUD[client] = false;
			ButtonsCheck(client);
		}
	}
	return Plugin_Continue;
}
//---------------------------------------------------------------------------||
//		用于刷新菜单的新菜单
//---------------------------------------------------------------------------||
void RestartMenu(int client)
{
		Menu Restart = new Menu(Restart_MenuHandler);
		Restart.SetTitle("重启检查菜单");
		Restart.AddItem("按下任意数字键以恢复", "按下任意数字键以恢复");
		Restart.AddItem("按下任意数字键以恢复", "按下任意数字键以恢复");
		Restart.AddItem("按下任意数字键以恢复", "按下任意数字键以恢复");
		Restart.AddItem("按下任意数字键以恢复", "按下任意数字键以恢复");
		Restart.AddItem("按下任意数字键以恢复", "按下任意数字键以恢复");
		Restart.AddItem("按下任意数字键以恢复", "按下任意数字键以恢复");		
		Restart.AddItem("按下任意数字键以恢复", "按下任意数字键以恢复");
		
		Restart.ExitButton = false;
		Restart.Display(client, MENU_TIME_FOREVER);
		CreateTimer(MENU_SHOWHUD_TIMER_TRY, tRestartMenu, client);
//		g_bTryReStartBcMenu[client] = false;
}
Action tRestartMenu(Handle Timer, any client)
{
	if(!g_bHRC_hud_enable)
		return Plugin_Continue;

	if(IsValidClient(client) && !IsFakeClient(client) )
		g_bTryReStartBcMenu[client] = false;

	return Plugin_Continue;	
}
public int Restart_MenuHandler(Menu menu, MenuAction action, int param1, int param2)
{
	return 0;
}
//---------------------------------------------------------------------------||
//		确定玩家已经显示游戏画面
//---------------------------------------------------------------------------||
public Action OnPlayerRunCmd(int client, int& buttons)
{
	if(!g_bHRC_hud_enable)	
		 return Plugin_Continue;
	
	if(!IsFakeClient(client) && GetClientTeam(client) == 2)
	{
		if(buttons & IN_RELOAD  )
		{
			g_iReloadBC_Count[client]++;	
		}
		else	g_iReloadBC_Count[client] = 0;
		//需要按住多长时间
		if(!g_bTryReStartBcMenu[client])
		{
			if(g_iReloadBC_Count[client] >= g_iReloadBC_Count_Hold )
			{
				g_bTryReStartBcMenu[client] = true;
				RestartMenu(client);
				g_iReloadBC_Count[client] = 0;
			}
		}
	}

	if(!g_bShouldHideHUD[client])
		return Plugin_Continue;

	if(buttons & IN_FORWARD || buttons & IN_BACK ||  buttons & IN_LEFT ||  buttons & IN_RIGHT)
	{
		g_iPrintHint_ButtonsCount[client]++;
		if(g_iPrintHint_ButtonsCount[client] > g_iServerTickRate)
		{
			g_iPrintHint_ButtonsCount[client] = 0;
			g_bShouldHideHUD[client] = false;
		}
	}

	return Plugin_Continue;
}

//-----------------------------------------------------------`----------------||
//		检查消息
//---------------------------------------------------------------------------||
public Action OnClientSayCommand(int client, const char[] command, const char[] sArgs) 
{
//	PrintToServer("\n== %s\n命令:%s", sArgs, command);
	if(!g_bHRC_hud_enable)
		return Plugin_Continue;

	if(client <= 0)
		return Plugin_Continue;
//	if(strcmp(command, "say_team", false) != 0)
//		return Plugin_Continue;

	//只是为了防止进入EMS HUD聊天缓冲区
	if(BaseComm_IsClientGagged(client) )
		return Plugin_Continue;

	//去掉带有特殊前缀的聊天
	for (int i = 0; i < sizeof tlist; i++)
	{
		if ( tlist[i][0] != EOS && strncmp(sArgs, tlist[i], strlen(tlist[i])) == 0 ) 
		{
			return Plugin_Continue;
		}
	}

	g_sEMSHUD_ChatBuffer.PushString(sArgs);
	//显示似乎是有延迟的
//	int time= g_iServerTickRate * 8;	//不是很能理解为什么HRC服务器没有用
//	也许是TIckRate的问题，内存补丁曾被我修改过，并且还是测试版本，RC服务器没有问题
	if(g_bIsHRC_Server)	g_iEMSHUD_ChatShowTime.Push(800);
	else			g_iEMSHUD_ChatShowTime.Push(480);

	g_fEMSHUD_ChatSendTime.Push(GetGameTime());

	char name[32];
	Format(name, sizeof(name), "%N", client);
	g_sEMSHUD_ChatClient.PushString(name);

	return Plugin_Continue;		
}

//---------------------------------------------------------------------------||
//		更新EMS HUD	
//---------------------------------------------------------------------------||
public void OnConfigsExecuted()
{	
	delete g_tUpdateInterval;
	if(g_bHRC_hud_enable)
	{
		g_tUpdateInterval = CreateTimer(0.5, TimerUpdateHUD, _, TIMER_REPEAT);
	}
}

bool	g_bEMSHUD_Blink_Timer;
bool 	g_bEMSHUD_ChatMSG_ShouldShow;
Action TimerUpdateHUD(Handle timer)
{
	if(g_bHRC_hud_enable)	
	{
		if(g_bEMSHUD_ChatMSG_ShouldShow && !g_bEMSHUD_Blink_Timer && (HUD_Flags & HUD_FLAG_BLINK) )	
		{
			g_bEMSHUD_Blink_Timer = true;
			CreateTimer(1.6, tEMSHUD_Blink_Timer);
		}
		UpdateHUD();
	}
	else	return Plugin_Stop;
	return Plugin_Continue;
}
Action tEMSHUD_Blink_Timer(Handle Timer)
{
	g_bEMSHUD_Blink_Timer = false;
	HUD_Flags = HUD_Flags & ~HUD_FLAG_BLINK;
	return Plugin_Continue;
}
void UpdateHUD()
{
	if(!g_bEMSHUD_ChatMSG_ShouldShow)
	{
		HUD_Flags |= HUD_FLAG_NOTVISIBLE;
		if( !(HUD_Flags & HUD_FLAG_BLINK) )
		{
			HUD_Flags |= HUD_FLAG_BLINK;
		}
	}
	else	HUD_Flags = HUD_Flags & ~HUD_FLAG_NOTVISIBLE;

	GameRules_SetProp("m_iScriptedHUDFlags", HUD_Flags, _, 6);
	GameRules_SetProp("m_iScriptedHUDFlags", HUD_Flags & ~HUD_FLAG_BLINK, _, 9);

	//X最好是1-Width的一半，这样就会居中
	if(GameRules_GetPropFloat("m_fScriptedHUDPosX", 6) != 0.1)
	{
		GameRules_SetPropFloat("m_fScriptedHUDPosX", 0.1, 6);
		GameRules_SetPropFloat("m_fScriptedHUDPosY", (1.0 - EMSHUD_DPI_HEIGHT_BIG - EMSHUD_DPI_HEIGHT_NORMAL - 0.02), 6);
		GameRules_SetPropFloat("m_fScriptedHUDWidth", 0.8, 6);
		GameRules_SetPropFloat("m_fScriptedHUDHeight", EMSHUD_DPI_HEIGHT_BIG, 6);
		GameRules_SetPropFloat("m_fScriptedHUDPosX", 0.1, 9);
		GameRules_SetPropFloat("m_fScriptedHUDPosY", (1.0 - EMSHUD_DPI_HEIGHT_NORMAL - 0.01), 9);
		GameRules_SetPropFloat("m_fScriptedHUDWidth", 0.8, 9);
		GameRules_SetPropFloat("m_fScriptedHUDHeight", EMSHUD_DPI_HEIGHT_NORMAL + 0.01, 9);
	}

	static char buffer[EMSHUD_CHATBUFFER_SIZE];
	static char name[32];
	if(g_sEMSHUD_ChatBuffer.Length <= EMSHUD_MAX_CHATLOG_BUFFERSIZE)
	{
		if(g_sEMSHUD_ChatBuffer.Length > 0 )
		{
			for(int i =0; i < g_iEMSHUD_ChatShowTime.Length;i++)
			{
				//找到允许显示时间不为0的最旧的一个聊天记录
				if(g_iEMSHUD_ChatShowTime.Get(i) > 0)
				{
					g_bEMSHUD_ChatMSG_ShouldShow = true;
					g_sEMSHUD_ChatBuffer.GetString(i, buffer, sizeof(buffer));
					g_sEMSHUD_ChatClient.GetString(i, name, sizeof(name))
					//不这么做，剩余时间总是0 >_>
					float oldtime = g_fEMSHUD_ChatSendTime.Get(i);
					//！！一个日志中的错误，存储的客户端id在输出时可能是无效的，我们最好立刻存储客户端的名字而不是id				
					Format(g_sEMSHUD_ChatHint, sizeof(g_sEMSHUD_ChatHint), "按下数字键'7'来聊天 | %.f秒前 [%s] 说道:", GetGameTime() - oldtime, name);	
					GameRules_SetPropString("m_szScriptedHUDStringSet", g_sEMSHUD_ChatHint, true, 6);
					break;
				}
				else	g_bEMSHUD_ChatMSG_ShouldShow = false;
			}
		}
	}
	//允许显示的剩余时间在游戏帧处理并递减至0
	else
	{
		g_sEMSHUD_ChatBuffer.Erase(0);
		g_sEMSHUD_ChatClient.Erase(0);
		g_fEMSHUD_ChatSendTime.Erase(0);
		//也许我们需要释放内存？应该是对齐数组索引
		g_iEMSHUD_ChatShowTime.Erase(0);
	}

	GameRules_SetPropString("m_szScriptedHUDStringSet", buffer, true, 9);
}
//---------------------------------------------------------------------------||
//		Stock
//---------------------------------------------------------------------------||
stock bool IsValidClientIndex(int client)
{
    return (1 <= client <= MaxClients);
}

stock bool IsValidClient(int client)
{
    return (IsValidClientIndex(client) && IsClientInGame(client));
}

stock void SwitchToWeapon(int iClient, int iWeapon)
{
    SDKCall(g_hSwitchWeaponCall, iClient, iWeapon, 0);
    SetEntPropEnt(iClient, Prop_Send, "m_hActiveWeapon", iWeapon);
} 

stock float GetTempHealth(int client)
{
        float fHealth = GetEntPropFloat(client, Prop_Send, "m_healthBuffer");
        fHealth -= GetGameTime() - GetEntPropFloat(client, Prop_Send, "m_healthBufferTime");
        return fHealth < 0.0 ? 0.0 : fHealth;
}

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

//stock bool L4D_IsPlayerIncapacitated(int client)
//{
//        return view_as<bool>(GetEntProp(client, Prop_Send, "m_isIncapacitated", 1));
//}

stock int ammo_offset = -1;
stock int GetClientReservedAmmo(int weapon, int client) {

        if (ammo_offset == -1)
                ammo_offset = FindSendPropInfo("CTerrorPlayer", "m_iAmmo");

        return GetEntData( client, ammo_offset + Weapon_GetPrimaryAmmoType(weapon) * 4 );
}

//---------smlib include/smlib/weapons.inc---------------------||
/**
 * Gets the primary ammo Type (int offset)
 *
 * @param weapon                Weapon Entity.
 * @return                              Primary ammo type value.
 */
stock int Weapon_GetPrimaryAmmoType(int weapon)
{
        return GetEntProp(weapon, Prop_Data, "m_iPrimaryAmmoType");
}

stock void JoninSurTeam(int client)
{
	if(IsValidClient(client) )
	{
		int bot = FindBotToTakeOver(true);
                if (bot==0)
                {
                        bot = FindBotToTakeOver(false);
                }
		if (bot==0) return;

		if(L4D_HasPlayerControlledZombies() == false) //coop/survival
                {
                        if(GetClientTeam(client) == 3) ChangeClientTeam(client,1);

                        if(IsPlayerAlive(bot))
                        {
                                L4D_SetHumanSpec(bot, client);
                                SetEntProp(client, Prop_Send, "m_iObserverMode", 5);
                        }
                        else
                        {
                                L4D_SetHumanSpec(bot, client);
                                L4D_TakeOverBot(client);        
                         //       clientteam[client] = 2; 
                         //       StartChangeTeamCoolDown(client);
                        }
                }

	}	
}

int FindBotToTakeOver(bool alive)
{
        int iClientCount, iClients[MAXPLAYERS+1];
        for (int i = 1; i <= MaxClients; i++)
        {
                if(IsClientInGame(i) && IsFakeClient(i) && GetClientTeam(i)==2 && !HasIdlePlayer(i) && IsPlayerAlive(i) == alive)
                {
                        iClients[iClientCount++] = i;
                }
        }

        return (iClientCount == 0) ? 0 : iClients[GetRandomInt(0, iClientCount - 1)];
}

bool HasIdlePlayer(int bot)
{
        if(IsClientInGame(bot) && IsFakeClient(bot) && GetClientTeam(bot) == 2 && IsPlayerAlive(bot))
        {
                if(HasEntProp(bot, Prop_Send, "m_humanSpectatorUserID"))
                {
                        if(GetEntProp(bot, Prop_Send, "m_humanSpectatorUserID") > 0)
                        {
                                return true;
                        }
                }
        }
        return false;
}

public void Event_ConVarChanged(ConVar convar, const char[] oldValue, const char[] newValue){
  ApplyCvars();
}

public void ApplyCvars()
{
	g_bHRC_hud_enable = cHRC_hud_enable.BoolValue;
	g_iHRC_hud_show_key = cHRC_hud_show_key.IntValue;
	ShowKey = g_iHRC_hud_show_key ? IN_SCORE : IN_SPEED ;
}
