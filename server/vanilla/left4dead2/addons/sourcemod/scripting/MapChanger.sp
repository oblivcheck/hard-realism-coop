#define PLUGIN_VERSION "3.7fork"

#pragma semicolon 1
#pragma newdecls required

#include <sourcemod>
#include <sdktools>
#include <localizer>
#undef REQUIRE_PLUGIN
#tryinclude <hx_stats>
#tryinclude <vip_core>

const int MAX_MARK = 6;
const int MAX_CAMPAIGN_TITLE = 64;
const int MAX_MAP_TITLE = 64;
const int MAX_MAP_NAME = 64;
const int MAP_RATING_ANY = -1;
const int MAP_GROUP_ANY = -1;

#define CVAR_FLAGS 			FCVAR_NOTIFY

public Plugin myinfo = 
{
	name = "[L4D] Map Changer",
	author = "Alex Dragokas",
	description = "Campaign and map chooser with rating system, groups and sorting",
	version = PLUGIN_VERSION,
	url = "https://github.com/dragokas/"
};

enum NEXT_MAP_METHOD
{
	NEXT_MAP_METHOD_STANDARD 		= 0,
	NEXT_MAP_METHOD_STANDARD_RANDOM = 1,
	NEXT_MAP_METHOD_CUSTOM 			= 2,
	NEXT_MAP_METHOD_CUSTOM_RANDOM 	= 3
}

enum
{
	FINALE_CHANGE_NONE 				= 0,
	FINALE_CHANGE_VEHICLE_LEAVE 	= 1,
	FINALE_CHANGE_FINALE_WIN 		= 2,
	FINALE_CHANGE_CREDITS_START 	= 4,
	FINALE_CHANGE_CREDITS_END 		= 8
}

enum GAME_TYPE
{
	GAME_TYPE_NONE 		= -1,
	GAME_TYPE_COOP 		= 0,
	GAME_TYPE_VERSUS 	= 1,
	GAME_TYPE_SURVIVAL 	= 2
};

char GAME_TYPE_STR[][] =
{
	"coop",
	"versus",
	"survival"
};

KeyValues g_kv;
KeyValues g_kvinfo;
KeyValues g_kvdef;

UserMsg StatsCrawlMsgId;

GAME_TYPE g_eGameType;

char g_sMapListPath[PLATFORM_MAX_PATH];
char g_sMapInfoPath[PLATFORM_MAX_PATH];
char g_sVoteBlockPath[PLATFORM_MAX_PATH];
char g_sCycleBlockPath[PLATFORM_MAX_PATH];
char g_sLog[PLATFORM_MAX_PATH];
char g_Campaign[MAXPLAYERS+1][MAX_CAMPAIGN_TITLE];
char g_sCurMap[MAX_MAP_NAME];
char g_sGameMode[32];
char g_sVoteResult[MAX_MAP_NAME];

int g_MapGroup[MAXPLAYERS+1];
int g_Rating[MAXPLAYERS+1];
int g_iMenuPage[MAXPLAYERS+1];
int g_iVoteMark;

float g_fLastTime[MAXPLAYERS+1];
float g_fLastTimeMark[MAXPLAYERS+1];

int iNumCampaignsGroup[3];
int iNumCampaignsCustom;

bool g_RatingMenu[MAXPLAYERS+1];
bool g_bLeft4Dead2;
bool g_bVeto;
bool g_bVotepass;
bool g_bVoteInProgress;
bool g_bVoteDisplayed;
bool g_bUMHooked;
bool g_bLateload;
bool g_bDedicated;
bool g_bVipCoreLib;
bool g_bEmptyMapCycleCustom;
bool g_bMapStarted;
bool g_iAsyncAwaitCount;
bool g_bIsFinale;

StringMap g_hNameByMap;
StringMap g_hNameByMapCustom;
StringMap g_hCampaignByMap;
StringMap g_hCampaignByMapCustom;
StringMap g_hMapStamp;

ArrayList g_aMapOrder;
ArrayList g_aMapCustomOrder;
ArrayList g_aMapStandardFirst;
ArrayList g_aMapCustomFirst;
ArrayList g_hArrayVoteBlock;
ArrayList g_hArrayCycleBlock;

ConVar g_hConVarGameMode;
ConVar g_hCvarDelay;
ConVar g_hCvarTimeout;
ConVar g_hCvarAnnounceDelay;
ConVar g_hCvarServerNameShort;
ConVar g_hCvarVoteMarkMinPlayers;
ConVar g_hCvarVoteMarkFlag;
ConVar g_hCvarMapVoteAccessDef;
ConVar g_hCvarMapVoteAccessCustom;
ConVar g_hCvarMapVoteAccessVip;
ConVar g_hConVarHostName;
ConVar g_hCvarAllowDefault;
ConVar g_hCvarAllowCustom;
ConVar g_hCvarNextMapOnStandard;
ConVar g_hCvarNextMapOnCustom;
ConVar g_hCvarVetoFlag;
ConVar g_hCvarRemoveMarkFlag;
ConVar g_hCvarChapterList;
ConVar g_hCvarFinaleChangeType;
ConVar g_hCvarServerPrintInfo;
ConVar g_hCvarNativeVoteChangeMissionAllow;
ConVar g_hCvarNativeVoteChangeChapterAllow;
ConVar g_hCvarNativeVoteRestartGameAllow;
ConVar g_hCvarNativeVoteReturnLobbyAllow;
ConVar g_hCvarMapChangeNotifyTime;

Localizer loc;

#if defined _hxstats_included
	bool g_bHxStatsAvail;
	ConVar g_hCvarVoteStatPoints;
	ConVar g_hCvarVoteStatPlayTime;
#endif

#if !defined _vip_core_included
	#pragma unused g_bVipCoreLib, g_hCvarMapVoteAccessVip
#endif

public APLRes AskPluginLoad2(Handle myself, bool late, char[] error, int err_max)
{
	EngineVersion test = GetEngineVersion();
	if( test != Engine_Left4Dead && test != Engine_Left4Dead2 )
	{
		strcopy(error, err_max, "Plugin only supports Left 4 Dead 1 & 2.");
		return APLRes_SilentFailure;
	}
	if( test == Engine_Left4Dead2 ) g_bLeft4Dead2 = true;
	g_bLateload = late;
	g_bDedicated = IsDedicatedServer();
	return APLRes_Success;
}

public void OnPluginStart()
{
	LoadTranslations("MapChanger.phrases");
	
	loc = new Localizer();
	loc.Delegate_InitCompleted(OnPhrasesReady);
	
	CreateConVar("mapchanger_version", PLUGIN_VERSION, "MapChanger Version", FCVAR_DONTRECORD | CVAR_FLAGS);
	g_hCvarDelay = CreateConVar(				"l4d_mapchanger_delay",					"60",		"Minimum delay (in sec.) allowed between votes", CVAR_FLAGS );
	g_hCvarTimeout = CreateConVar(				"l4d_mapchanger_timeout",				"10",		"How long (in sec.) does the vote last", CVAR_FLAGS );
	g_hCvarAnnounceDelay = CreateConVar(		"l4d_mapchanger_announcedelay",			"2.0",		"Delay (in sec.) between announce and vote menu appearing", CVAR_FLAGS );
	g_hCvarAllowDefault = CreateConVar(			"l4d_mapchanger_allow_default",			"1",		"Display standard maps menu items? (1 - Yes, 0 - No)", CVAR_FLAGS );
	g_hCvarAllowCustom = CreateConVar(			"l4d_mapchanger_allow_custom",			"1",		"Display custom maps menu items? (1 - Yes, 0 - No)", CVAR_FLAGS );
	g_hCvarServerNameShort = CreateConVar(		"l4d_mapchanger_servername_short", 		"", 		"Short name of your server (specify it, if you want custom campaign name will be prepended to it)", CVAR_FLAGS);
	g_hCvarVoteMarkMinPlayers = CreateConVar(	"l4d_mapchanger_votemark_minplayers", 	"3", 		"Minimum number of players to allow starting the vote for mark (rating)", CVAR_FLAGS);
	g_hCvarVoteMarkFlag = CreateConVar(			"l4d_mapchanger_votemark_access",		"",			"Flag(s) allowed to start the vote for mark (rating). Leave empty to allow everybody.", CVAR_FLAGS );
	g_hCvarRemoveMarkFlag = CreateConVar(		"l4d_mapchanger_remove_mark_access",	"z",		"Flag(s) allowed to remove the mark (rating)", CVAR_FLAGS );
	g_hCvarMapVoteAccessDef = CreateConVar(		"l4d_mapchanger_default_voteaccess", 	"kp", 		"Flag(s) allowed to access the vote for change to standard maps. Leave empty to allow everybody.", CVAR_FLAGS);
	g_hCvarMapVoteAccessCustom = CreateConVar(	"l4d_mapchanger_custom_voteaccess", 	"k", 		"Flag(s) allowed to access the vote for change to custom maps. Leave empty to allow everybody.", CVAR_FLAGS);
	g_hCvarMapVoteAccessVip = CreateConVar(		"l4d_mapchanger_vip_voteaccess", 		"1", 		"Allow VIP players to change the map? (1 - Yes, 0 - No)", CVAR_FLAGS);
	g_hCvarVetoFlag = CreateConVar(				"l4d_mapchanger_vetoaccess",			"d",		"Flag(s) allowed to veto/votepass the vote", CVAR_FLAGS );
	g_hCvarNextMapOnStandard = CreateConVar(	"l4d_mapchanger_nextmap_on_standard", 	"1", 		"Which next campaign to use (on finale chapter of standard campaign)? (0 - next standard, 1 - random standard)", CVAR_FLAGS);
	g_hCvarNextMapOnCustom = CreateConVar(		"l4d_mapchanger_nextmap_on_custom", 	"3", 		"Which next campaign to use (on finale chapter of custom campaign)? (0 - next standard, 1 - random standard, 2 - next custom, 3 - random custom)", CVAR_FLAGS);
	g_hCvarChapterList = CreateConVar(			"l4d_mapchanger_show_chapter_list", 	"1", 		"Show the list of chapters within campaign? (1 - Yes, 0 - No)", CVAR_FLAGS);
	g_hCvarFinaleChangeType = CreateConVar(		"l4d_mapchanger_finale_change_type", 	"12", 		"0 - Don't change finale map (drop to lobby); 1 - instant on vehicle leaving; 2 - instant on finale win; 4 - Wait till credits screen appear; 8 - Wait till credits screen ends", CVAR_FLAGS);
	g_hCvarServerPrintInfo = CreateConVar(		"l4d_mapchanger_server_print_info", 	"1", 		"Print map change info to server console? (1 - Yes, 0 - No)", CVAR_FLAGS);
	g_hCvarMapChangeNotifyTime = CreateConVar(	"l4d_mapchanger_mapchange_notify_time", "2", 		"Number of seconds to display notify message before the actual change map", CVAR_FLAGS);
	
	g_hCvarNativeVoteChangeMissionAllow = CreateConVar(	"l4d_native_vote_allow_change_mission", 	"0", 	"Allow to use native votes to change mission? (0 - No, replace by MapChanger menu; 1 - Yes). Disable it to improve security!", CVAR_FLAGS);
	g_hCvarNativeVoteChangeChapterAllow = CreateConVar(	"l4d_native_vote_allow_change_chapter", 	"0", 	"Allow to use native votes to change chapter? (0 - No, replace by MapChanger menu; 1 - Yes). Disable it to improve security!", CVAR_FLAGS);
	g_hCvarNativeVoteRestartGameAllow = CreateConVar(	"l4d_native_vote_allow_restart_game", 		"0", 	"Allow to use native votes to restart game? (0 - No, replace by MapChanger menu; 1 - Yes). Disable it to improve security!", CVAR_FLAGS);
	g_hCvarNativeVoteReturnLobbyAllow = CreateConVar(	"l4d_native_vote_allow_return_lobby", 		"0", 	"Allow to use native votes to return to lobby? (0 - No, replace by MapChanger menu; 1 - Yes). Disable it to improve security!", CVAR_FLAGS);
	
	#if defined _hxstats_included
		g_hCvarVoteStatPoints = CreateConVar(		"l4d_mapchanger_vote_stat_points",		"10000",	"Minimum points in statistics system required to allow start the vote", CVAR_FLAGS );
		g_hCvarVoteStatPlayTime = CreateConVar(		"l4d_mapchanger_vote_stat_playtime",	"600",		"Minimum play time (in minutes) in statistics system required to allow start the vote", CVAR_FLAGS );
		
		if( g_bLateload )
		{
			g_bHxStatsAvail = (GetFeatureStatus(FeatureType_Native, "HX_GetPoints") == FeatureStatus_Available);
		}
	#endif
	
	if( g_bLateload )
	{
		g_bVipCoreLib = LibraryExists("vip_core");
	}
	
	AutoExecConfig(true, "l4d_mapchanger");
	
	SetNativeVotesCvars();
	
	g_hCvarNativeVoteChangeMissionAllow.AddChangeHook(ConVarHook_NativeVotes);
	g_hCvarNativeVoteChangeChapterAllow.AddChangeHook(ConVarHook_NativeVotes);
	g_hCvarNativeVoteRestartGameAllow.AddChangeHook(ConVarHook_NativeVotes);
	g_hCvarNativeVoteReturnLobbyAllow.AddChangeHook(ConVarHook_NativeVotes);
	
	StatsCrawlMsgId = view_as<UserMsg>(g_bLeft4Dead2 ? 43 : 39);
	
	g_hConVarGameMode = FindConVar("mp_gamemode");
	g_hConVarHostName = FindConVar("hostname");
	
	g_hConVarGameMode.AddChangeHook(ConVarChanged_GameMode);
	GetGameType();
	
	g_hCvarServerNameShort.AddChangeHook(ConVarChanged_ServerNameCustom);
	
	RegConsoleCmd("sm_maps", 		Command_MapChoose, 					"Show map list to begin vote for changelevel / set mark (rating) etc.");
	//TODO
	//RegConsoleCmd("sm_rtv", 		Command_VoteNext, 					"Start vote for the next campaign");
	//RegConsoleCmd("sm_vnext", 	Command_VoteNext, 					"Start vote for the next campaign"); // alias
	//RegConsoleCmd("sm_votenext", 	Command_VoteNext, 					"Start vote for the next campaign"); // alias
	
	RegConsoleCmd("sm_veto", 		Command_Veto, 		 				"Allow admin to veto current vote.");
	RegConsoleCmd("sm_votepass", 	Command_Votepass, 	 				"Allow admin to bypass current vote.");
	
	RegAdminCmd("sm_mapnext", 		CmdNextMap, 		ADMFLAG_ROOT, 	"Force change level to the next map");
	RegAdminCmd("sm_next", 			CmdNextMap, 		ADMFLAG_ROOT, 	"Force change level to the next map"); // alias
	RegAdminCmd("sm_maps_reload", 	Command_ReloadMaps, ADMFLAG_ROOT, 	"Refresh the list of maps");
	
	HookEvent("round_start", 			Event_RoundStart, 		EventHookMode_PostNoCopy);
	HookEvent("finale_win", 			Event_FinaleWin, 		EventHookMode_PostNoCopy);
	HookEvent("finale_vehicle_leaving",	Event_VehicleLeaving,	EventHookMode_PostNoCopy);
	
	BuildPath(Path_SM, g_sMapListPath, 		PLATFORM_MAX_PATH, "configs/%s", g_bLeft4Dead2 ? "MapChanger.l4d2.txt" : "MapChanger.l4d1.txt");
	BuildPath(Path_SM, g_sMapInfoPath, 		PLATFORM_MAX_PATH, "configs/MapChanger_info.txt");
	BuildPath(Path_SM, g_sVoteBlockPath, 	PLATFORM_MAX_PATH, "data/mapchanger_vote_block.txt");
	BuildPath(Path_SM, g_sCycleBlockPath, 	PLATFORM_MAX_PATH, "data/mapchanger_black_cycle.txt");
	BuildPath(Path_SM, g_sLog, 				PLATFORM_MAX_PATH, "logs/vote_map.log");
	
	g_aMapOrder 		= new ArrayList(ByteCountToCells(MAX_MAP_NAME));
	g_aMapCustomOrder 	= new ArrayList(ByteCountToCells(MAX_MAP_NAME));
	g_aMapStandardFirst = new ArrayList(ByteCountToCells(MAX_MAP_NAME));
	g_aMapCustomFirst 	= new ArrayList(ByteCountToCells(MAX_MAP_NAME));
	g_hArrayVoteBlock 	= new ArrayList(ByteCountToCells(MAX_NAME_LENGTH));
	g_hArrayCycleBlock  = new ArrayList(ByteCountToCells(MAX_MAP_NAME));
	
	g_hNameByMap 			= new StringMap();
	g_hNameByMapCustom 		= new StringMap();
	g_hCampaignByMap 		= new StringMap();
	g_hCampaignByMapCustom 	= new StringMap();
	g_hMapStamp 			= new StringMap();
	
	GetMissions();
	
	HookUserMessage(GetUserMessageId("DisconnectToLobby"), OnDisconnectToLobby, true);
}

public void ConVarHook_NativeVotes(ConVar convar, const char[] oldValue, const char[] newValue)
{
	SetNativeVotesCvars();
}

void SetNativeVotesCvars()
{
	bool bChangeMapAllow = g_hCvarNativeVoteChangeMissionAllow.BoolValue || g_hCvarNativeVoteChangeChapterAllow.BoolValue;
	
	SetCvarSilent(FindConVar("sv_vote_issue_change_map_now_allowed"), bChangeMapAllow ? "1" : "0");
	SetCvarSilent(FindConVar("sv_vote_issue_change_map_later_allowed"), bChangeMapAllow ? "1" : "0");
	SetCvarSilent(FindConVar("sv_vote_issue_change_mission_allowed"), bChangeMapAllow ? "1" : "0");
	SetCvarSilent(FindConVar("sv_vote_issue_restart_game_allowed"), g_hCvarNativeVoteRestartGameAllow.BoolValue ? "1" : "0");
}

stock void SetCvarSilent(ConVar cv, char[] value)
{
	int flags = cv.Flags;
	cv.Flags &= ~FCVAR_NOTIFY;
	cv.SetString(value, false, false);
	cv.Flags = flags;
}

public Action CmdNextMap(int client, int args)
{
	g_bMapStarted = true;
	GotoNextMap();
	return Plugin_Handled;
}

#if defined _hxstats_included
public void OnLibraryAdded(const char[] name)
{
	if( strcmp(name, "hx_stats") == 0 )
	{
		g_bHxStatsAvail = true;
	}
}
#endif

#if defined _vip_core_included
public void VIP_OnVIPLoaded()
{
	g_bVipCoreLib = true;
}
#endif

public void OnLibraryRemoved(const char[] name)
{
	#if defined _hxstats_included
	if( strcmp(name, "hx_stats") == 0 )
	{
		g_bHxStatsAvail = false;
	}
	#endif
	#if defined _vip_core_included
	if( strcmp(name, "vip_core") == 0 )
	{
		g_bVipCoreLib = false;
	}
	#endif
}

public void OnPhrasesReady()
{
	PrecachePhrasesKV(g_kv);
	PrecachePhrasesKV(g_kvdef);
}

void PrecachePhrasesKV(KeyValues kv)
{
	kv.Rewind();
	if( kv.GotoFirstSubKey() )
	{
		RequestFrame(PrecachePhrasesKV_Frame, kv);
		++ g_iAsyncAwaitCount;
	}
}

void PrecachePhrasesKV_Frame(KeyValues kv)
{
	char sCampaign[MAX_CAMPAIGN_TITLE], DisplayName[MAX_MAP_TITLE];
	//do
	{
		kv.GetSectionName(sCampaign, sizeof(sCampaign));
		if( sCampaign[0] == '#' )
		{
			loc.PrecachePhrase(sCampaign);
		}
		
		if( kv.GotoFirstSubKey() ) // game mode
		{
			do
			{
				if( kv.GotoFirstSubKey() ) { // index
					do
					{
						kv.GetString("DisplayName", DisplayName, sizeof(DisplayName));
						if( DisplayName[0] == '#' )
						{
							loc.PrecachePhrase(DisplayName);
						}
					} while( kv.GotoNextKey() );
					kv.GoBack();
				}
			} while( kv.GotoNextKey() );
			kv.GoBack();
			if( kv.GotoNextKey() )
			{
				RequestFrame(PrecachePhrasesKV_Frame, kv);
			}
			else {
				-- g_iAsyncAwaitCount;
			}
		}
		else {
			-- g_iAsyncAwaitCount;
		}
	} //while( kv.GotoNextKey() );
}

public void Event_RoundStart(Event event, const char[] name, bool dontBroadcast)
{
	if( g_hCvarServerPrintInfo.BoolValue )
	{
		PrintToServer("[MapChanger] Current map is: %s (new round)", g_sCurMap);
	}
}

public void Event_FinaleWin(Event event, const char[] name, bool dontBroadcast)
{
	if( g_hCvarFinaleChangeType.IntValue & FINALE_CHANGE_FINALE_WIN )
	{
		FinaleMapChange();
	}
	if( !g_bUMHooked )
	{
		HookUserMessageCredits();
	}
}

public void Event_VehicleLeaving(Event event, const char[] name, bool dontBroadcast)
{
	if( g_hCvarFinaleChangeType.IntValue & FINALE_CHANGE_VEHICLE_LEAVE )
	{
		FinaleMapChange();
	}
	if( !g_bUMHooked )
	{
		HookUserMessageCredits();
	}
}

void HookUserMessageCredits()
{
	if( g_hCvarFinaleChangeType.IntValue & FINALE_CHANGE_CREDITS_START )
	{
		g_bUMHooked = true;
		HookUserMessage(StatsCrawlMsgId, OnCreditsScreen, false);
	}
}

public Action OnCreditsScreen(UserMsg msg_id, BfRead hMsg, const int[] players, int playersNum, bool reliable, bool init)
{
	UnhookUserMessage(StatsCrawlMsgId, OnCreditsScreen, false);
	g_bUMHooked = false;
	FinaleMapChange_Frame(); // walkaround for "Could not send a usermessage" in PrintToChat
	return Plugin_Continue;
}

void FinaleMapChange_Frame()
{
	RequestFrame(FinaleMapChange);
}

public Action OnDisconnectToLobby(UserMsg msg_id, BfRead hMsg, const int[] players, int playersNum, bool reliable, bool init)
{
	if( g_hCvarFinaleChangeType.IntValue & FINALE_CHANGE_CREDITS_END )
	{
		GotoNextMap(true);
		return Plugin_Handled;
	}
	return Plugin_Continue;
}

void ReadFileToArrayList(char[] sPath, ArrayList list)
{
	static char str[MAX_NAME_LENGTH];
	File hFile = OpenFile(sPath, "r");
	if( hFile == null )
	{
		SetFailState("Failed to open file: \"%s\". You are missing at installing!", sPath);
	}
	else {
		list.Clear();
		while( !hFile.EndOfFile() && hFile.ReadLine(str, sizeof(str)) )
		{
			TrimString(str);
			if( str[0] != '/' )
			{
				list.PushString(str);
			}
		}
		delete hFile;
	}
}

public void OnMapStart()
{
	static int ft_block, ft_blackcycle, ft_addonlist;
	
	g_bMapStarted = true;
	
	int ft = GetFileTime(g_sVoteBlockPath, FileTime_LastChange);
	if( ft != ft_block )
	{
		ft_block = ft;
		ReadFileToArrayList(g_sVoteBlockPath, g_hArrayVoteBlock);
	}
	
	ft = GetFileTime(g_sCycleBlockPath, FileTime_LastChange);
	if( ft != ft_blackcycle )
	{
		ft_blackcycle = ft;
		ReadFileToArrayList(g_sCycleBlockPath, g_hArrayCycleBlock);
	}
	
	bool bForceReload = false;
	static bool bFirstUpdate = true;
	if( FileExists("addonlist.txt") )
	{
		ft = GetFileTime("addonlist.txt", FileTime_LastChange);
		if( ft != ft_addonlist )
		{
			ft_addonlist = ft;
			if( !bFirstUpdate )
			{
				bForceReload = true; // force full map list re-read & check if user de/activated it
			}
		}
		bFirstUpdate = false;
	}
	
	ReloadMaps(bForceReload);
	GetCurrentMap(g_sCurMap, sizeof(g_sCurMap));
	
	if( g_hCvarServerPrintInfo.BoolValue )
	{
		PrintToServer("[MapChanger] Current map is: %s", g_sCurMap);
	}
	CreateTimer(5.0, Timer_ChangeHostName, _, TIMER_FLAG_NO_MAPCHANGE);
	g_bUMHooked = false;
	
	g_bIsFinale = IsFinaleMap(g_sCurMap); // assume, database is already populated
}

public Action Timer_ChangeHostName(Handle timer)
{
	static char sSrv[64];
	static char sShort[48];
	char sCampaign[MAX_CAMPAIGN_TITLE], sCampaignTr[MAX_CAMPAIGN_TITLE];
	bool bCustom = false;
	
	g_hCvarServerNameShort.GetString(sShort, sizeof(sShort));
	if( sShort[0] == '\0' )
		return Plugin_Stop;
	
	if( g_hCampaignByMap.GetString(g_sCurMap, sCampaign, sizeof(sCampaign)) ) {
	}
	else {
		g_hCampaignByMapCustom.GetString(g_sCurMap, sCampaignTr, sizeof(sCampaignTr));
		bCustom = true;
	}
	
	if( bCustom ) {
		FormatEx(sSrv, sizeof(sSrv), "%s | %s", sShort, sCampaignTr);
	}
	else {
		strcopy(sSrv, sizeof(sSrv), sShort);
	}
	g_hConVarHostName.SetString(sSrv);
	return Plugin_Continue;
}

public void OnAllPluginsLoaded()
{
	AddCommandListener(CheckVote, "callvote");
}

public Action CheckVote(int client, char[] command, int args)
{
	static char s[32];
	if( args >= 2 ) {
		GetCmdArg(1, s, sizeof(s));
		if( strcmp(s, "ChangeMission", false) == 0 ) {
			if( !g_hCvarNativeVoteChangeMissionAllow.BoolValue )
			{
				Command_MapChoose(client, 0);
				return Plugin_Stop;
			}
		}
		else if( strcmp(s, "ChangeChapter", false) == 0 ) {
			if( !g_hCvarNativeVoteChangeChapterAllow.BoolValue )
			{
				Command_MapChoose(client, 0);
				return Plugin_Stop;
			}
		}
	}
	if( args >= 1 ) {
		GetCmdArg(1, s, sizeof(s));
		if( strcmp(s, "RestartGame", false) == 0 ) {
			if( !g_hCvarNativeVoteRestartGameAllow.BoolValue )
			{
				Command_MapChoose(client, 0);
				return Plugin_Stop;
			}
		}
		else if( strcmp(s, "ReturnToLobby", false) == 0 ) {
			if( !g_hCvarNativeVoteReturnLobbyAllow.BoolValue )
			{
				Command_MapChoose(client, 0);
				return Plugin_Stop;
			}
		}
	}
	return Plugin_Continue;
}

public void ConVarChanged_ServerNameCustom (ConVar convar, const char[] oldValue, const char[] newValue)
{
	Timer_ChangeHostName(null);
}

public void ConVarChanged_GameMode (ConVar convar, const char[] oldValue, const char[] newValue)
{
	if( strcmp(g_sGameMode, newValue, false) != 0 )
	{
		GetGameType();
		ReloadMaps(true);
		GetMissions();
	}
}

void GetGameType()
{
	g_hConVarGameMode.GetString(g_sGameMode, sizeof(g_sGameMode));
	
	if( strcmp(g_sGameMode, "coop", false) == 0 )
	{
		g_eGameType = GAME_TYPE_COOP;
	}
	else if( strcmp(g_sGameMode, "versus", false) == 0 )
	{
		g_eGameType = GAME_TYPE_VERSUS;
	}
	else if( strcmp(g_sGameMode, "survival", false) == 0 )
	{
		g_eGameType = GAME_TYPE_SURVIVAL;
	}
}

public Action Command_Veto(int client, int args)
{
	if( g_bVoteInProgress ) // IsVoteInProgress() is not working here, sm bug?
	{
		client = iGetListenServerHost(client, g_bDedicated);
	
		if( !HasVetoAccessFlag(client) )
		{
			ReplyToCommand(client, "%t", "no_access");
			return Plugin_Handled;
		}
		g_bVeto = true;
		CPrintToChatAll("%t", "veto", client);
		if( g_bVoteDisplayed ) CancelVote();
		LogVoteAction(client, "[VETO]");
	}
	return Plugin_Handled;
}

public Action Command_Votepass(int client, int args)
{
	if( g_bVoteInProgress )
	{
		client = iGetListenServerHost(client, g_bDedicated);
	
		if( !HasVetoAccessFlag(client) )
		{
			ReplyToCommand(client, "%t", "no_access");
			return Plugin_Handled;
		}
		g_bVotepass = true;
		CPrintToChatAll("%t", "votepass", client);
		if( g_bVoteDisplayed ) CancelVote();
		LogVoteAction(client, "[PASS]");
	}
	return Plugin_Handled;
}

public Action Command_ReloadMaps(int client, int args)
{
	client = iGetListenServerHost(client, g_bDedicated);
	
	if( !loc.IsReady() || g_iAsyncAwaitCount )
	{
		ReplyToCommand(client, "\x03[MapChanger]\x05 Sorry, database is not yet ready. Wait 1 minute more.");
		return Plugin_Handled;
	}
	ReloadMaps(false);
	ReplyToCommand(client, "\x03[MapChanger]\x05 Maps reloaded.");
	return Plugin_Handled;
}

void ReloadMaps(bool bForce)
{
	if( bForce || IsAddonChanged() )
	{
		GetAddonMissions();
	}
	if( !g_kv )
	{
		g_kv = new KeyValues("campaigns");
	}
	g_kvinfo = new KeyValues("info");
	if( FileExists(g_sMapInfoPath) )
	{
		if( !g_kvinfo.ImportFromFile(g_sMapInfoPath) )
		{
			SetFailState("[SM] ERROR: MapChanger - Incorrectly formatted file, '%s'", g_sMapInfoPath);
		}
	}
	Actualize_MapChangerInfo();
}

bool IsAddonChanged()
{
	char addonFile[PLATFORM_MAX_PATH];
	FileType fileType;
	int iLen, iStamp, iOldStamp;
	DirectoryListing hDir;
	bool bChanged;
	char Paths[][] = {
		"addons", "addons/workshop"
	};
	for( int i = 0; i < sizeof(Paths); i++ )
	{
		hDir = OpenDirectory(Paths[i], false);
		if( hDir )
		{
			while( hDir.GetNext(addonFile, PLATFORM_MAX_PATH, fileType) )
			{
				if( fileType == FileType_File )
				{
					iLen = strlen(addonFile);
					
					if( iLen >= 4 && strcmp(addonFile[iLen - 4], ".vpk") == 0 )
					{
						Format(addonFile, sizeof(addonFile), "%s/%s", Paths[i], addonFile);
						iStamp = GetFileTime(addonFile, FileTime_Created);
						
						if( !g_hMapStamp.GetValue(addonFile, iOldStamp) || iStamp != iOldStamp )
						{
							bChanged = true;
						}
						g_hMapStamp.SetValue(addonFile, iStamp);
					}
				}
			}
			delete hDir;
		}
	}
	return bChanged;
}

void Actualize_MapChangerInfo()
{
	g_kv.Rewind();
	g_kv.GotoFirstSubKey();
	
	static char sCampaign[MAX_CAMPAIGN_TITLE], map[MAX_MAP_NAME], DisplayName[MAX_MAP_TITLE];
	ArrayList Compaigns = new ArrayList(50, 50);
	bool fWrite = false;

	g_kvinfo.Rewind();
	{
		if( g_kvinfo.GotoFirstSubKey() )
		{
			do
			{
				g_kvinfo.GetSectionName(sCampaign, sizeof(sCampaign)); // retrieve campaign names
				Compaigns.PushString(sCampaign);
				
			} while( g_kvinfo.GotoNextKey() );
		}
	}
	
	int iGrp;
	static char sGrp[4];
	iNumCampaignsCustom = 0;
	for( int i = 0; i < sizeof(iNumCampaignsGroup); i++ )
		iNumCampaignsGroup[i] = 0;
	
	g_aMapOrder.Clear();
	g_aMapCustomOrder.Clear();
	g_aMapCustomFirst.Clear();
	g_aMapStandardFirst.Clear();
	
	// fill standard
	g_kvdef.Rewind();
	g_kvdef.GotoFirstSubKey();
	do
	{
		if( IsValidMapKv(g_kvdef) )
		{
			FillStandardCampaignOrder();
		}
	} while( g_kvdef.GotoNextKey() );
	
	// fill custom
	do
	{
		g_kv.GetSectionName(sCampaign, sizeof(sCampaign)); // compare to full list
		
		g_kvinfo.GoBack();
		g_kvinfo.JumpToKey(sCampaign, true);
		
		if( -1 == Compaigns.FindString(sCampaign) )
		{
			g_kvinfo.SetString("group", "0");
			g_kvinfo.SetString("mark", "0");
			iGrp = 0;
			fWrite = true;
		}
		else {
			g_kvinfo.GetString("group", sGrp, sizeof(sGrp), "0");
			iGrp = StringToInt(sGrp);
		}
		
		if( IsValidMapKv(g_kv) )
		{
			FillCustomCampaignOrder();
			iNumCampaignsGroup[iGrp]++;
		}
		
	} while( g_kv.GotoNextKey() );
	delete Compaigns;
	
	g_bEmptyMapCycleCustom = g_aMapCustomFirst.Length == 0;
	
	if( fWrite )
	{
		g_kvinfo.Rewind();
		g_kvinfo.ExportToFile(g_sMapInfoPath);
	}
	
	for( int i = 0; i < sizeof(iNumCampaignsGroup); i++ )
		iNumCampaignsCustom += iNumCampaignsGroup[i];
	
	// fill StringMaps
	g_kv.Rewind();
	g_kv.GotoFirstSubKey();
	do
	{
		g_kv.GetSectionName(sCampaign, sizeof(sCampaign));
		
		if( !g_kv.JumpToKey(g_sGameMode) )
		{
			if( !g_kv.JumpToKey("coop") ) // default
				continue;
		}
		
		if( g_kv.GotoFirstSubKey() ) {
			do
			{
				g_kv.GetString("Map", map, sizeof(map), "@");
				if( strcmp(map, "@") != 0 )
				{
					g_kv.GetString("DisplayName", DisplayName, sizeof(DisplayName), "@");
					if( strcmp(DisplayName, "@") != 0 )
					{
						g_hNameByMapCustom.SetString(map, DisplayName, false);
						g_hCampaignByMapCustom.SetString(map, sCampaign, false);
					}
				}
			} while( g_kv.GotoNextKey() );
			g_kv.GoBack();
		}
		g_kv.GoBack();
		
	} while( g_kv.GotoNextKey() );
}

stock char[] Translate(int client, const char[] format, any ...)
{
	static char buffer[192];
	SetGlobalTransTarget(client);
	VFormat(buffer, sizeof(buffer), format, 3);
	return buffer;
}

public Action Command_MapChoose(int client, int args)
{
	client = iGetListenServerHost(client, g_bDedicated);
	if(client == 0)
		return Plugin_Handled;

	PrintToChat(client, "\x05按下数字键0（非小键盘）来退出大多数菜单");
	
	Menu_ChooseMap(client);
	return Plugin_Handled;
}

void Menu_ChooseMap(int client)
{
	if( !loc.IsReady() || g_iAsyncAwaitCount )
	{
		ReplyToCommand(client, "\x03[MapChanger]\x05 Sorry, database is not yet ready. Wait 1 minute more.");
		return;
	}
	
	static char sMapDisplay[MAX_CAMPAIGN_TITLE], sMapDisplayTr[MAX_CAMPAIGN_TITLE], sCampaign[MAX_CAMPAIGN_TITLE], sCampaignTr[MAX_CAMPAIGN_TITLE];
	int iCurMapNumber, iTotalMapsNumber;
	
	Menu menu = new Menu(Menu_MapTypeHandler, MENU_ACTIONS_DEFAULT);

	if( g_hCampaignByMap.GetString(g_sCurMap, sCampaign, sizeof(sCampaign)) )
	{
		g_hNameByMap.GetString(g_sCurMap, sMapDisplay, sizeof(sMapDisplay));
	}
	else { // custom map
		g_hCampaignByMapCustom.GetString(g_sCurMap, sCampaign, sizeof(sCampaign));
		g_hNameByMapCustom.GetString(g_sCurMap, sMapDisplay, sizeof(sMapDisplay));
	}
	if( sCampaign[0] == '#' )
	{
		loc.PhraseTranslateToLang(sCampaign, sCampaignTr, sizeof(sCampaignTr), client, _, _, sCampaign);
	}
	else {
		strcopy(sCampaignTr, sizeof(sCampaignTr), sCampaign);
	}
	if( sMapDisplay[0] == '#' )
	{
		loc.PhraseTranslateToLang(sMapDisplay, sMapDisplayTr, sizeof(sMapDisplayTr), client, _, _, sMapDisplay);
		ClearDisplayName(sMapDisplayTr, sizeof(sMapDisplayTr));
	}
	else {
		strcopy(sMapDisplayTr, sizeof(sMapDisplayTr), sMapDisplay);
	}
	
	GetMapNumber(sCampaign, g_sCurMap, iCurMapNumber, iTotalMapsNumber);
	NormalizeName(sCampaignTr);
	NormalizeName(sMapDisplayTr);
	
	menu.SetTitle("%T: [%i/%i] %s - %s", "Current_map", client, iCurMapNumber, iTotalMapsNumber, sCampaignTr, sMapDisplayTr);
	
	if( g_hCvarAllowDefault.BoolValue )
	{
		menu.AddItem("default", Translate(client, "%t", "Default_maps")); 	// Стандартные карты
	}
	
	if( g_hCvarAllowCustom.BoolValue )
	{
		if( iNumCampaignsGroup[1] != 0 )
			menu.AddItem("group1", Translate(client, "%t", "Custom_maps_1")); 	// Доп. карты  << набор № 1 >>
			
		if( iNumCampaignsGroup[2] != 0 )
			menu.AddItem("group2", Translate(client, "%t", "Custom_maps_2")); 	// Доп. карты  << набор № 2 >>
		
		if( iNumCampaignsGroup[0] != 0 )
			menu.AddItem("group0", Translate(client, "%t", "Test_maps")); 		// Тестовые карты
		
		if( iNumCampaignsGroup[0] || iNumCampaignsGroup[1] || iNumCampaignsGroup[2] )
			menu.AddItem("group_all", Translate(client, "%t", "All_maps")); 		// Все карты
		
		if( iNumCampaignsCustom != 0 )
			menu.AddItem("rating", Translate(client, "%t", "By_rating")); 		// По рейтингу
	}
	
	menu.ExitButton = false;
	menu.DisplayAt(client, 0, MENU_TIME_FOREVER);
}

public int Menu_MapTypeHandler(Menu menu, MenuAction action, int client, int ItemIndex)
{
	switch( action )
	{
		case MenuAction_End:
			delete menu;
		
		case MenuAction_Select:
		{
			static char sgroup[32];
			menu.GetItem(ItemIndex, sgroup, sizeof(sgroup));

			if( strcmp(sgroup, "default") == 0 ) {
				g_MapGroup[client] = MAP_GROUP_ANY;
				g_Rating[client] = MAP_RATING_ANY;
				g_RatingMenu[client] = false;
				CreateMenu_DefCampaign(client);
			}
			else if( strcmp(sgroup, "rating") == 0 ) {
				g_MapGroup[client] = MAP_GROUP_ANY;
				g_RatingMenu[client] = true;
				CreateMenuRating(client);
			}
			else if( strcmp(sgroup, "group0") == 0 ) {
				g_MapGroup[client] = 0;
				g_Rating[client] = MAP_RATING_ANY;
				g_RatingMenu[client] = false;
				CreateMenuCampaigns(client, 0, MAP_RATING_ANY);
			}
			else if( strcmp(sgroup, "group1") == 0 ) {
				g_MapGroup[client] = 1;
				g_Rating[client] = MAP_RATING_ANY;
				g_RatingMenu[client] = false;
				CreateMenuCampaigns(client, 1, MAP_RATING_ANY);
			}
			else if( strcmp(sgroup, "group2") == 0 ) {
				g_MapGroup[client] = 2;
				g_Rating[client] = MAP_RATING_ANY;
				g_RatingMenu[client] = false;
				CreateMenuCampaigns(client, 2, MAP_RATING_ANY);
			}
			else if( strcmp(sgroup, "group_all") == 0 ) {
				g_MapGroup[client] = MAP_GROUP_ANY;
				g_Rating[client] = MAP_RATING_ANY;
				g_RatingMenu[client] = false;
				CreateMenuCampaigns(client, -1, MAP_RATING_ANY);
			}
		}
	}
	return 0;
}

void CreateMenuRating(int client)
{
	Menu menu = new Menu(Menu_RatingHandler, MENU_ACTIONS_DEFAULT);
	menu.SetTitle("%T", "Rating_value_ask", client); 			// - Кампании с каким рейтингом показать? -
	menu.AddItem("1", Translate(client, "%t", "Rating_1")); 	// балл (отвратительная)
	menu.AddItem("2", Translate(client, "%t", "Rating_2")); 	// балла (не очень)
	menu.AddItem("3", Translate(client, "%t", "Rating_3")); 	// балла (средненькая)
	menu.AddItem("4", Translate(client, "%t", "Rating_4")); 	// балла (неплохая)
	menu.AddItem("5", Translate(client, "%t", "Rating_5")); 	// баллов (очень хорошая)
	menu.AddItem("6", Translate(client, "%t", "Rating_6")); 	// баллов (блестящая)
	menu.AddItem("0", Translate(client, "%t", "Rating_No")); 	// Ещё без оценки
	menu.ExitBackButton = true;	
	menu.ExitButton = false;
	menu.DisplayAt( client, 0, MENU_TIME_FOREVER);
}

public int Menu_RatingHandler(Menu menu, MenuAction action, int client, int ItemIndex)
{
	switch( action )
	{
		case MenuAction_End:
			delete menu;

		case MenuAction_Cancel:
			if( ItemIndex == MenuCancel_ExitBack )
				Menu_ChooseMap(client);
		
		case MenuAction_Select:
		{
			static char sMark[8];
			menu.GetItem(ItemIndex, sMark, sizeof(sMark));
			int mark = StringToInt(sMark);
			
			g_Rating[client] = mark;
			CreateMenuCampaigns(client, MAP_GROUP_ANY, mark);
		}
	}
	return 0;
}

void CreateMenuCampaigns(int client, int ChosenGroup, int ChosenRating, int menuIndex = 0)
{
	static char BlackStar[] = "★";
	static char WhiteStar[] = "☆";
	
	int LEN_BLACK_STAR = strlen(BlackStar);
	int LEN_WHITE_STAR = strlen(WhiteStar);
	
	Menu menu = new Menu(Menu_CampaignHandler, MENU_ACTIONS_DEFAULT);
	menu.ExitBackButton = true;

	static char Value[MAX_CAMPAIGN_TITLE];
	FormatEx(Value, sizeof(Value), "%T", "Choose_campaign", client); // - Выберите кампанию -
	menu.SetTitle(Value);
	
	ArrayList asort, arand;
	asort = new ArrayList(ByteCountToCells(MAX_CAMPAIGN_TITLE));
	arand = new ArrayList(ByteCountToCells(MAX_CAMPAIGN_TITLE));
	
	static char campaign[MAX_CAMPAIGN_TITLE];
	static char campaign_current[MAX_CAMPAIGN_TITLE];
	static char name[MAX_MAP_TITLE];
	
	GetCampaignDisplay(g_sCurMap, campaign_current, sizeof(campaign_current), _, _, false);
	
	int group = 0, mark = 0;
	bool bAtLeastOne = false;
	g_kv.Rewind();
	g_kv.GotoFirstSubKey();
	do
	{
		g_kv.GetSectionName(campaign, sizeof(campaign));
		NormalizeName(campaign);
		asort.PushString(campaign);
	} while( g_kv.GotoNextKey() );
	
	asort.Sort(Sort_Ascending, Sort_String); // Sort list of campaigns by alphabet
	
	g_kvinfo.Rewind();
	//g_kvinfo.JumpToKey("campaigns");
	
	for( int i = 0; i < asort.Length; i++ )
	{
		asort.GetString(i, campaign, sizeof(campaign));
		
		if( g_kvinfo.JumpToKey(campaign) )
		{
			group = g_kvinfo.GetNum("group", 0);
			mark = g_kvinfo.GetNum("mark", 0);
			g_kvinfo.GoBack();
		}
		if( (ChosenGroup == -1 || group == ChosenGroup) && (ChosenRating == -1 || mark == ChosenRating) )
		{
			g_kv.Rewind();
			if( g_kv.JumpToKey(campaign) )
			{
				if( IsValidMapKv(g_kv) ) {
					loc.Format(name, sizeof(name), "%s%s   %s", StrRepeat(BlackStar, LEN_BLACK_STAR, mark), StrRepeat(WhiteStar, LEN_WHITE_STAR, MAX_MARK - mark), campaign);
					
					if( strcmp(campaign, campaign_current, false) != 0 )
					{
						arand.PushString(campaign);
					}
					menu.AddItem(campaign, name);
					bAtLeastOne = true;
				}
			}
		}
	}
	
	if( arand.Length != 0 )
	{
		arand.GetString(GetRandomInt(0, arand.Length - 1), campaign, sizeof(campaign));
		menu.InsertItem(0, campaign, Translate(client, "%t", "random_map"));
	}
	
	delete asort;
	delete arand;
	
	if( bAtLeastOne )
	{
	  menu.ExitButton = false;
		menu.DisplayAt(client, menuIndex, MENU_TIME_FOREVER);
	}
	else {
		if( g_RatingMenu[client] )
		{
			FormatEx(Value, sizeof(Value), "%T", "No_maps_rating", client); // Карт с такой оценкой ещё нет.
			PrintToChat(client, "\x03[MapChanger]\x05 %s", Value);
			CreateMenuRating(client);
		} else {
			FormatEx(Value, sizeof(Value), "%T", "No_maps_in_group", client); // В этой группе ещё нет карт.
			PrintToChat(client, "\x03[MapChanger]\x05 %s", Value);
			Menu_ChooseMap(client);
		}
	}
}

// in. - KeyValue in position of concrete campaign section
bool IsValidMapKv(KeyValues kv)
{
	char map[MAX_MAP_NAME];
	bool bValid = false;
	
	// get the first map of campaign to check is it exist
	if( !kv.JumpToKey(g_sGameMode) )
	{
		if( !kv.JumpToKey("coop") ) // default
			return false;
	}
	if( kv.GotoFirstSubKey() ) {
		kv.GetString("Map", map, sizeof(map), "@");
		if ( strcmp(map, "@") != 0 )
		{
			if ( IsMapValidEx(map) )
				bValid = true;
		}
		kv.GoBack();
	}
	kv.GoBack();
	return bValid;
}

void FillStandardCampaignOrder()
{
	char map[MAX_MAP_NAME];
	bool bFirstMap = true;

	// get the first map of campaign to check is it exist
	if( !g_kvdef.JumpToKey(g_sGameMode) )
	{
		if( !g_kvdef.JumpToKey("coop") ) // default
			return;
	}
	if( g_kvdef.GotoFirstSubKey() )
	{
		do
		{
			g_kvdef.GetString("Map", map, sizeof(map), "@");
			if( strcmp(map, "@") != 0 )
			{
				if( IsMapValidEx(map) )
				{
					g_aMapOrder.PushString(map);

					if( bFirstMap )
					{
						bFirstMap = false;
						if( !IsBlackListedCycleMap(map) )
						{
							g_aMapStandardFirst.PushString(map);
						}
					}
				}
			}
		} while( g_kvdef.GotoNextKey() );
		g_kvdef.GoBack();
	}
	g_kvdef.GoBack();
}

void FillCustomCampaignOrder()
{
	char map[MAX_MAP_NAME];
	bool bFirstMap = true;

	// get the first map of campaign to check is it exist
	if( !g_kv.JumpToKey(g_sGameMode) )
	{
		if( !g_kv.JumpToKey("coop") ) // default
			return;
	}
	if( g_kv.GotoFirstSubKey() )
	{
		do
		{
			g_kv.GetString("Map", map, sizeof(map), "@");
			if( strcmp(map, "@") != 0 )
			{
				if( IsMapValidEx(map) )
				{
					g_aMapCustomOrder.PushString(map);

					if( bFirstMap )
					{
						bFirstMap = false;
						if( !IsBlackListedCycleMap(map) )
						{
							g_aMapCustomFirst.PushString(map);
						}
					}
				}
			}
		} while( g_kv.GotoNextKey() );
		g_kv.GoBack();
	}
	g_kv.GoBack();
}

char[] StrRepeat(char[] text, int maxlength, int times)
{
	char NewStr[MAX_MAP_TITLE];
//	char[] NewStr = new char[times*maxlength];
	for( int i = 0; i < times*maxlength; i+= maxlength )
		for( int j = 0; j < maxlength; j++ ) {
			NewStr[i + j] = text[j];
		}
	if( times < 0 )
		NewStr[0] = '\0';
	else
		NewStr[times*maxlength] = '\0';
	return NewStr;
}

void CreateMenu_DefCampaign(int client, int itemIndex = 0)
{
	static char sCampaign[MAX_CAMPAIGN_TITLE], sCampaignTr[MAX_CAMPAIGN_TITLE];

	Menu menu = new Menu(Menu_DefCampaignHandler, MENU_ACTIONS_DEFAULT);
	menu.SetTitle("%T", "Choose_campaign", client); // - Выберите кампанию -
	
	g_kvdef.Rewind();
	g_kvdef.GotoFirstSubKey();
	do
	{
		g_kvdef.GetSectionName(sCampaign, sizeof(sCampaign));
		loc.PhraseTranslateToLang(sCampaign, sCampaignTr, sizeof(sCampaignTr), client, _, _, sCampaign);
		NormalizeName(sCampaignTr);
		menu.AddItem(sCampaign, sCampaignTr);
		
	} while( g_kvdef.GotoNextKey() );
	
	menu.ExitBackButton = true;
	menu.ExitButton = false;
	menu.DisplayAt(client, itemIndex, MENU_TIME_FOREVER);
}

public int Menu_DefCampaignHandler(Menu menu, MenuAction action, int client, int ItemIndex)
{
	switch( action )
	{
		case MenuAction_End:
			delete menu;

		case MenuAction_Cancel:
			if( ItemIndex == MenuCancel_ExitBack )
				Menu_ChooseMap(client);
		
		case MenuAction_Select:
		{
			static char campaign[MAX_CAMPAIGN_TITLE];
			static char campaign_title[MAX_MAP_TITLE];
			menu.GetItem(ItemIndex, campaign, sizeof(campaign), _, campaign_title, sizeof(campaign_title));
			
			CreateMenu_DefMaps(client, campaign, campaign_title);
			g_iMenuPage[client] = menu.Selection;
		}
	}
	return 0;
}

void CreateMenu_DefMaps(int client, char[] campaign, char[] campaign_title)
{
	g_kvdef.Rewind();
	if( g_kvdef.JumpToKey(campaign) )
	{
		if( !g_kvdef.JumpToKey(g_sGameMode) )
		{
			if( !g_kvdef.JumpToKey("coop") ) { // default
				CPrintToChat(client, "\x03[MapChanger]\x05 %T %s!", "no_maps_for_mode", client, g_sGameMode); // Не найдено карт в кофигурации для режима
				return;
			}
		}
		static char map[MAX_MAP_NAME];
		static char DisplayName[MAX_MAP_TITLE];
		
		if( !g_hCvarChapterList.BoolValue )
		{
			g_kvdef.GotoFirstSubKey();
			g_kvdef.GetString("Map", map, sizeof(map), "@");
			CheckVoteMap(client, map, false);
			return;
		}
		
		Menu menu = new Menu(Menu_DefMapHandler, MENU_ACTIONS_DEFAULT);
		menu.SetTitle("- %T [%s] -", "Choose_map", client, campaign_title);  // Выберите карту
		
		g_kvdef.GotoFirstSubKey();
		do
		{
			g_kvdef.GetString("Map", map, sizeof(map), "@");
			if( strcmp(map, "@") != 0 )
			{
				g_kvdef.GetString("DisplayName", DisplayName, sizeof(DisplayName), "@");
				if( strcmp(DisplayName, "@") != 0 )
				{
					if( DisplayName[0] == '#' )
					{
						strcopy(DisplayName, sizeof(DisplayName), Loc_Translate(client, DisplayName));
						ClearDisplayName(DisplayName, sizeof(DisplayName));
					}
					NormalizeName(DisplayName);
					menu.AddItem(map, DisplayName, ITEMDRAW_DEFAULT);
				}
			}
		} while( g_kvdef.GotoNextKey() );
		
		menu.ExitBackButton = true;		
		menu.ExitButton = false;
		menu.DisplayAt(client, 0, MENU_TIME_FOREVER);
	}
}

public int Menu_DefMapHandler(Menu menu, MenuAction action, int client, int ItemIndex)
{
	switch( action )
	{
		case MenuAction_End:
			delete menu;

		case MenuAction_Cancel:
			if( ItemIndex == MenuCancel_ExitBack )
				CreateMenu_DefCampaign(client, g_iMenuPage[client]);
		
		case MenuAction_Select:
		{
			static char map[MAX_MAP_NAME];
			menu.GetItem(ItemIndex, map, sizeof(map));
			CheckVoteMap(client, map, false);
		}
	}
	return 0;
}

/*
public void OnConfigsExecuted() // after server.cfg !
{
	// set survival mode for "The Last Stand"
	if (StrEqual(g_sCurMap, "l4d_sv_lighthouse"))
	{
		g_GameMode.SetString("survival");
	}
}
*/

void CreateMenuGroup(int client)
{
	Menu menu = new Menu(Menu_GroupHandler, MENU_ACTIONS_DEFAULT);
	menu.SetTitle( "- %T [%s] ? -", "choose_new_map_type", client, g_Campaign[client]); // Какой тип присвоить
	menu.AddItem("1", Translate(client, "%t", "new_type_1")); // Тип: < набор № 1 >
	menu.AddItem("2", Translate(client, "%t", "new_type_2")); // Тип: < набор № 2 >
	menu.AddItem("0", Translate(client, "%t", "new_type_test")); // Тип: < тестовая карта >
	menu.ExitBackButton = true;
	menu.DisplayAt(client, 0, MENU_TIME_FOREVER);
}

public int Menu_GroupHandler(Menu menu, MenuAction action, int client, int ItemIndex)
{
	switch( action )
	{
		case MenuAction_End:
			delete menu;

		case MenuAction_Cancel:
			if( ItemIndex == MenuCancel_ExitBack )
				CreateMenuCampaigns(client, g_MapGroup[client], g_Rating[client]);
		
		case MenuAction_Select:
		{
			static char sGroup[8];
			menu.GetItem(ItemIndex, sGroup, sizeof(sGroup));
			int group = StringToInt(sGroup);
			
			g_kvinfo.Rewind();
			//if( g_kvinfo.JumpToKey("campaigns") )
			{
				if( g_kvinfo.JumpToKey(g_Campaign[client], true) )
				{
					g_kvinfo.SetNum("group", group);
				}
			}
			g_kvinfo.Rewind();
			g_kvinfo.ExportToFile(g_sMapInfoPath);
			Actualize_MapChangerInfo();
			CreateMenuCampaigns(client, g_MapGroup[client], g_Rating[client]);
		}
	}
	return 0;
}

void CreateMenuMark(int client)
{
	Menu menu = new Menu(Menu_MarkHandler, MENU_ACTIONS_DEFAULT);
	menu.SetTitle( "- %T [%s] -", "set_rating", client, g_Campaign[client]); // Поставьте оценку кампании
	menu.AddItem("1", Translate(client, "%t", "Rating_1")); // балл (отвратительная)
	menu.AddItem("2", Translate(client, "%t", "Rating_2")); // балла (не очень)
	menu.AddItem("3", Translate(client, "%t", "Rating_3")); // балла (средненькая)
	menu.AddItem("4", Translate(client, "%t", "Rating_4")); // балла (неплохая)
	menu.AddItem("5", Translate(client, "%t", "Rating_5")); // баллов (очень хорошая)
	menu.AddItem("6", Translate(client, "%t", "Rating_6")); // баллов (блестящая)
	if( HasRemoveRatingAccess(client) )
		menu.AddItem("0", Translate(client, "%t", "Rating_remove")); // Удалить рейтинг
	menu.ExitBackButton = true;	
	menu.ExitButton = false;
	menu.DisplayAt( client, 0, MENU_TIME_FOREVER);
}

public int Menu_MarkHandler(Menu menu, MenuAction action, int client, int ItemIndex)
{
	switch( action )
	{
		case MenuAction_End:
			delete menu;

		case MenuAction_Cancel:
			if( ItemIndex == MenuCancel_ExitBack )
				CreateMenuCampaigns(client, g_MapGroup[client], g_Rating[client]);
		
		case MenuAction_Select:
		{
			static char sMark[8];
			menu.GetItem(ItemIndex, sMark, sizeof(sMark));
			g_iVoteMark = StringToInt(sMark);
			
			if (g_iVoteMark == 0) {
				SetRating(g_Campaign[client], 0); // "Remove rating" is intended for admin only
				CreateMenuCampaigns(client, g_MapGroup[client], g_Rating[client]);
			}
			else {
				StartVoteMark(client, g_Campaign[client]);
			}
		}
	}
	return 0;
}

public int Menu_CampaignHandler(Menu menu, MenuAction action, int client, int ItemIndex)
{
	switch( action )
	{
		case MenuAction_End:
			delete menu;

		case MenuAction_Cancel:
			if( ItemIndex == MenuCancel_ExitBack )
				if (g_RatingMenu[client])
					CreateMenuRating(client);
				else
					Menu_ChooseMap(client);
		
		case MenuAction_Select:
		{
			static char campaign[MAX_CAMPAIGN_TITLE];
			menu.GetItem(ItemIndex, campaign, sizeof(campaign));
			strcopy(g_Campaign[client], sizeof(g_Campaign[]), campaign);
			CreateCustomMapMenu(client, campaign);
			g_iMenuPage[client] = menu.Selection;
		}
	}
	return 0;
}

void CreateCustomMapMenu(int client, char[] campaign)
{
	g_kv.Rewind();
	if( g_kv.JumpToKey(campaign) )
	{
		if( !g_kv.JumpToKey(g_sGameMode) )
		{
			if( !g_kv.JumpToKey("coop") ) { // default
				CPrintToChat(client, "\x03[MapChanger]\x05 %T %s!", "no_maps_for_mode", client, g_sGameMode); // Не найдено карт в кофигурации для режима
				return;
			}
		}
		char map[MAX_MAP_NAME];
		char DisplayName[MAX_MAP_TITLE];
		
		if( !g_hCvarChapterList.BoolValue )
		{
			g_kv.GotoFirstSubKey();
			g_kv.GetString("Map", map, sizeof(map), "@");
			LogVoteAction(client, "[TRY] Change map to: %s from %s", map, g_sCurMap);
			CheckVoteMap(client, map, true);
			return;
		}
		
		Menu menu = new Menu(Menu_MapHandler, MENU_ACTIONS_DEFAULT);
		menu.SetTitle("- %T [%s] -", "Choose_map", client, campaign);  // Выберите карту
		
		g_kv.GotoFirstSubKey();
		do
		{
			g_kv.GetString("Map", map, sizeof(map), "@");
			if( strcmp(map, "@") != 0 )
			{
				g_kv.GetString("DisplayName", DisplayName, sizeof(DisplayName), "@");
				if( strcmp(DisplayName, "@") != 0 )
				{
					if( DisplayName[0] == '#' )
					{
						strcopy(DisplayName, sizeof(DisplayName), Loc_Translate(client, DisplayName));
						ClearDisplayName(DisplayName, sizeof(DisplayName));
					}
					NormalizeName(DisplayName);
					menu.AddItem(map, DisplayName, ITEMDRAW_DEFAULT);
				}
			}
		} while( g_kv.GotoNextKey() );
		
		if( IsClientRootAdmin(client) ) {
			menu.AddItem("group", Translate(client, "%t", "Move_map_type"));  // Переместить в другую группу
		}
		menu.AddItem("mark", Translate(client, "%t", "set_rating2"));  // Поставить оценку
		menu.ExitBackButton = true;
		menu.ExitButton = false;
		menu.DisplayAt(client, 0, MENU_TIME_FOREVER);
	}
}

int GetRealClientCount() {
	int cnt;
	for( int i = 1; i <= MaxClients; i++ )
		if( IsClientInGame(i) && !IsFakeClient(i) ) cnt++;
	return cnt;
}

public int Menu_MapHandler(Menu menu, MenuAction action, int client, int ItemIndex)
{
	switch( action )
	{
		case MenuAction_End:
			delete menu;

		case MenuAction_Cancel:
			if( ItemIndex == MenuCancel_ExitBack )
				CreateMenuCampaigns(client, g_MapGroup[client], g_Rating[client], g_iMenuPage[client]);
		
		case MenuAction_Select:
		{
			static char map[MAX_MAP_NAME];
			static char DisplayName[MAX_MAP_TITLE];
			menu.GetItem(ItemIndex, map, sizeof(map), _, DisplayName, sizeof(DisplayName));

			if( strcmp(map, "mark") == 0 )
			{
				if( HasVoteRatingAccess(client) )
				{
					if( GetRealClientCount() >= g_hCvarVoteMarkMinPlayers.IntValue || IsClientRootAdmin(client) ) 
					{
						CreateMenuMark(client);
					}
					else {
						CPrintToChat(client, "%t", "Not_enough_votemark_players", g_hCvarVoteMarkMinPlayers.IntValue); // Not enough clients to start vote for mark (should be %i+)
						CreateCustomMapMenu(client, g_Campaign[client]);
					}
				}
				else {
					CPrintToChat(client, "%t", "no_access");
				}
			}
			else if( strcmp(map, "group") == 0 )
			{
				CreateMenuGroup(client);
			} 
			else {
				LogVoteAction(client, "[TRY] Change map to: %s from %s", map, g_sCurMap);
				CheckVoteMap(client, map, true);
			}
		}
	}
	return 0;
}

void CheckVoteMap(int client, char[] map, bool bIsCustom)
{
	if( IsMapValidEx(map) )
	{
		if( IsClientRootAdmin(client) && GetRealClientCount() == 1 )
		{
			strcopy(g_sVoteResult, sizeof(g_sVoteResult), map);
			Handler_PostVoteAction(true);
			return;
		}
	
		if( CanVote(client, bIsCustom) )
		{
			float fCurTime = GetEngineTime();
		
			if( g_fLastTime[client] != 0 && !IsClientRootAdmin(client) )
			{
				if ( g_fLastTime[client] + g_hCvarDelay.FloatValue > fCurTime ) {
					PrintToChat(client, "\x03[MapChanger]\x05 %t", "too_often"); // "You can't vote too often!"
					LogVoteAction(client, "[DELAY] Attempt to vote too often. Time left: %i sec.", (g_fLastTime[client] + g_hCvarDelay.FloatValue) - fCurTime);
					return;
				}
			}
			g_fLastTime[client] = fCurTime;
			
			StartVoteMap(client, map);
		}
		else {
			PrintToChat(client, "\04%t", "no_access");
			LogVoteAction(client, "[DENY] Change map");
		}
	} else {
		if( client ) {
			PrintToChat(client, "\x03[MapChanger]\x05 %t %s %t", "map", map, "not_exist");  // Карта XXX больше не существует на сервере!
		}
		LogVoteAction(client, "[DENY] Map is not exist.");
	}
}

void StartVoteMap(int client, char[] map)
{
	if( g_bVoteInProgress || IsVoteInProgress() ) {
		PrintToChat(client, "%t", "vote_in_progress"); // Другое голосование ещё не закончилось!
		return;
	}
	strcopy(g_sVoteResult, sizeof(g_sVoteResult), map);
	
	g_bVotepass = false;
	g_bVeto = false;
	g_bVoteDisplayed = false;
	LogVoteAction(client, "[STARTED] Change map to: %s", map);
	
	Menu menu = new Menu(Handle_VoteMapMenu, MenuAction_DisplayItem | MenuAction_Display);
	menu.AddItem("", "Yes");
	menu.AddItem("", "No");
	menu.ExitButton = false;
	CreateTimer(g_hCvarAnnounceDelay.FloatValue, Timer_VoteDelayed, menu, TIMER_FLAG_NO_MAPCHANGE);
	
	char campaign[MAX_CAMPAIGN_TITLE], map_display[MAX_MAP_TITLE], display[MAX_CAMPAIGN_TITLE + MAX_MAP_TITLE];
	GetCampaignDisplay(map, campaign, sizeof(campaign), true, client);
	GetMapDisplay(map, map_display, sizeof(map_display), true, client);
	FormatEx(display, sizeof(display), "%s - %s", campaign, map_display);
	CPrintHintTextToAll("%t", "vote_started_announce", display);
}

Action Timer_VoteDelayed(Handle timer, Menu menu)
{
	if( g_bVotepass || g_bVeto ) {
		Handler_PostVoteAction(g_bVotepass);
		delete menu;
	}
	else {
		if( !IsVoteInProgress() ) {
			g_bVoteInProgress = true;			
			menu.ExitButton = false;
			menu.DisplayVoteToAll(g_hCvarTimeout.IntValue);
			g_bVoteDisplayed = true;
		}
		else {
			delete menu;
		}
	}
	return Plugin_Continue;
}

public int Handle_VoteMapMenu(Menu menu, MenuAction action, int param1, int param2)
{
	char display[MAX_CAMPAIGN_TITLE], buffer[MAX_CAMPAIGN_TITLE + MAX_MAP_TITLE];
	int client = param1;

	switch( action )
	{
		case MenuAction_End:
		{
			if( g_bVoteInProgress && g_bVotepass ) { // in case vote is passed with CancelVote(), so MenuAction_VoteEnd is not called.
				Handler_PostVoteAction(true);
			}
			g_bVoteInProgress = false;
			delete menu;
		}
		
		case MenuAction_VoteEnd: // 0=yes, 1=no
		{
			if( (param1 == 0 || g_bVotepass) && !g_bVeto ) {
				Handler_PostVoteAction(true);
			}
			else {
				Handler_PostVoteAction(false);
			}
			g_bVoteInProgress = false;
		}
		case MenuAction_DisplayItem:
		{
			menu.GetItem(param2, "", 0, _, display, sizeof(display));
			FormatEx(buffer, sizeof(buffer), "%T", display, client);
			return RedrawMenuItem(buffer);
		}
		case MenuAction_Display:
		{
			char campaign[MAX_CAMPAIGN_TITLE], map_display[MAX_MAP_TITLE], map[MAX_MAP_NAME];
			strcopy(map, sizeof(map), g_sVoteResult);
			GetCampaignDisplay(map, campaign, sizeof(campaign), true, client);
			GetMapDisplay(map, map_display, sizeof(map_display), true, client);
			FormatEx(display, sizeof(display), "%s - %s", campaign, map_display);
			FormatEx(buffer, sizeof(buffer), "%T", "vote_started_announce", client, display);
			menu.SetTitle(buffer);
		}
	}
	return 0;
}

void ShowChangeLevelNotify(char[] map)
{
	char mapDisplay[MAX_MAP_TITLE], campaignDisplay[MAX_CAMPAIGN_TITLE], sCampaign[MAX_CAMPAIGN_TITLE];
	int iIndexMap, iTotalMaps;
	
	GetCampaignDisplay(map, sCampaign, sizeof(sCampaign), false);
	GetMapNumber(sCampaign, map, iIndexMap, iTotalMaps);
	
	for( int i = 1; i <= MaxClients; i++ )
	{
		if( IsClientInGame(i) && !IsFakeClient(i) )
		{
			GetCampaignDisplay(map, campaignDisplay, sizeof(campaignDisplay), true, i);
			GetMapDisplay(map, mapDisplay, sizeof(mapDisplay), true, i);
			//ClearDisplayName(mapDisplay, sizeof(mapDisplay));
			
			CPrintToChat(i, "%t", "vote_success", campaignDisplay, mapDisplay, iIndexMap, iTotalMaps);
		}
	}
}

void Handler_PostVoteAction(bool bVoteSuccess)
{
	if( bVoteSuccess )
	{
		LogVoteAction(-1, "[ACCEPTED] Vote for map: %s", g_sVoteResult);
		L4D_ChangeLevel(g_sVoteResult);
	}
	else {
		LogVoteAction(-1, "[NOT ACCEPTED] Vote for map.");
		CPrintToChatAll("%t", "vote_failed");
	}
	g_bVoteInProgress = false;
}

void StartVoteMark(int client, char[] sCampaign)
{
	if( g_bVoteInProgress || IsVoteInProgress() ) {
		PrintToChat(client, "%t", "vote_in_progress"); // Другое голосование ещё не закончилось!
		return;
	}
	
	float fCurTime = GetEngineTime();
	
	if( g_fLastTimeMark[client] != 0 && !HasRemoveRatingAccess(client) )
	{
		if ( g_fLastTimeMark[client] + g_hCvarDelay.FloatValue > fCurTime ) {
			PrintToChat(client, "\x03[MapChanger]\x05 %t", "too_often"); // "You can't vote too often!"
			LogVoteAction(client, "[DELAY] Attempt to vote too often. Time left: %i sec.", (g_fLastTimeMark[client] + g_hCvarDelay.FloatValue) - fCurTime);
			return;
		}
	}
	g_fLastTimeMark[client] = fCurTime;
	
	Menu menu = new Menu(Handle_VoteMarkMenu, MenuAction_DisplayItem | MenuAction_Display);
	menu.AddItem(sCampaign, "Yes");
	menu.AddItem("", "No");
	menu.ExitButton = false;
	menu.DisplayVoteToAll(g_hCvarTimeout.IntValue);
	g_bVotepass = false;
	g_bVeto = false;
	LogVoteAction(client, "[STARTED] Vote for mark. Campaign: %s. Mark: %i", sCampaign, g_iVoteMark);
}

public int Handle_VoteMarkMenu(Menu menu, MenuAction action, int param1, int param2)
{
	static char display[MAX_CAMPAIGN_TITLE], buffer[MAX_CAMPAIGN_TITLE*2], sCampaign[MAX_CAMPAIGN_TITLE], sRate[32];
	int client = param1;
	
	switch( action )
	{
		case MenuAction_End:
			delete menu;
		
		case MenuAction_VoteEnd: // 0=yes, 1=no
		{
			if( (param1 == 0 || g_bVotepass) && !g_bVeto ) {
				menu.GetItem(0, sCampaign, sizeof(sCampaign));
				SetRating(sCampaign, g_iVoteMark);
				FormatEx(sRate, sizeof(sRate), "Rating_%i", g_iVoteMark);				
				CPrintToChatAll("%t", "mark_set_success", g_iVoteMark, sRate, sCampaign);
				LogVoteAction(-1, "[ACCEPTED] Vote for mark.");
			}
			else {
				CPrintToChatAll("%t", "vote_mark_failed");
				LogVoteAction(-1, "[NOT ACCEPTED] Vote for mark.");
			}
		}
		case MenuAction_DisplayItem:
		{
			menu.GetItem(param2, "", 0, _, display, sizeof(display));
			FormatEx(buffer, sizeof(buffer), "%T", display, client);
			return RedrawMenuItem(buffer);
		}
		case MenuAction_Display:
		{
			menu.GetItem(0, sCampaign, sizeof(sCampaign));
			FormatEx(sRate, sizeof(sRate), "Rating_%i", g_iVoteMark);
			FormatEx(buffer, sizeof(buffer), "%T", "set_mark_vote_title", client, g_iVoteMark, sRate, client, sCampaign); // "Set mark %i (%t) for the map: %s ?"
			menu.SetTitle(buffer);
		}
	}
	return 0;
}

void SetRating(char[] sCampaign, int iMark)
{
	g_kvinfo.Rewind();
	//if( g_kvinfo.JumpToKey("campaigns") )
	{
		if( g_kvinfo.JumpToKey(sCampaign, true) )
		{
			g_kvinfo.SetNum("mark", iMark);
		}
	}
	g_kvinfo.Rewind();
	g_kvinfo.ExportToFile(g_sMapInfoPath);
}

stock void ReplaceColor(char[] message, int maxLen)
{
	ReplaceString(message, maxLen, "{white}", 	"\x01", false);
	ReplaceString(message, maxLen, "{cyan}", 	"\x03", false);
	ReplaceString(message, maxLen, "{orange}", 	"\x04", false);
	ReplaceString(message, maxLen, "{green}", 	"\x05", false);
}

stock void CPrintToChat(int iClient, const char[] format, any ...)
{
	static char buffer[192];
	SetGlobalTransTarget(iClient);
	VFormat(buffer, sizeof(buffer), format, 3);
	ReplaceColor(buffer, sizeof(buffer));
	PrintToChat(iClient, "\x01%s", buffer);
}

stock void CPrintToChatAll(const char[] format, any ...)
{
	static char buffer[192];
	for( int i = 1; i <= MaxClients; i++ )
	{
		if( IsClientInGame(i) && !IsFakeClient(i) )
		{
			SetGlobalTransTarget(i);
			VFormat(buffer, sizeof(buffer), format, 2);
			ReplaceColor(buffer, sizeof(buffer));
			PrintToChat(i, "\x01%s", buffer);
		}
	}
}

stock void CPrintHintTextToAll(const char[] format, any ...)
{
	static char buffer[192];
	for( int i = 1; i <= MaxClients; i++ )
	{
		if( IsClientInGame(i) && !IsFakeClient(i) )
		{
			SetGlobalTransTarget(i);
			VFormat(buffer, sizeof(buffer), format, 2);
			PrintHintText(i, buffer);
		}
	}
}

stock bool IsClientAdmin(int client)
{
	if( !IsClientInGame(client) ) return false;
	return( GetUserAdmin(client) != INVALID_ADMIN_ID && GetUserFlagBits(client) != 0 );
}
stock bool IsClientRootAdmin(int client)
{
	return( (GetUserFlagBits(client) & ADMFLAG_ROOT) != 0 );
}

void LogVoteAction(int client, const char[] format, any ...)
{
	static char sSteam[64];
	static char sIP[32];
	static char sName[MAX_NAME_LENGTH];
	static char buffer[256];
	
	VFormat(buffer, sizeof(buffer), format, 3);
	
	if( client != -1 ) {
		GetClientAuthId(client, AuthId_Steam2, sSteam, sizeof(sSteam));
		GetClientName(client, sName, sizeof(sName));
		GetClientIP(client, sIP, sizeof(sIP));
		LogToFileEx(g_sLog, "%s %s (%s | %s). Current map is: %s", buffer, sName, sSteam, sIP, g_sCurMap);
	}
	else {
		LogToFileEx(g_sLog, buffer);
	}
}

Action Timer_ChangeLevel(Handle timer, DataPack dp)
{
	char sMapName[MAX_MAP_NAME];
	dp.Reset();
	dp.ReadString(sMapName, sizeof(sMapName));
	
	if( g_hCvarServerPrintInfo.BoolValue )
	{
		PrintToServer("[MapChanger] Changing map to: %s ...", sMapName);
	}
	g_bMapStarted = false;
	ForceChangeLevel(sMapName, "Map Vote");
	return Plugin_Continue;
}

bool L4D_ChangeLevel(char[] sMapName, bool bInstantChange = false)
{
	if( !g_bMapStarted )
	{
		if( !bInstantChange )
		{
			CPrintToChatAll("Cannot change the map when no map is started!");
		}
		return false;
	}

	if( !IsMapValidEx(sMapName) )
	{
		RemoveBrokenMap(sMapName);
		if( !bInstantChange )
		{
			CPrintToChatAll("%t: %s", "invalid_map", sMapName); // Cannot change map. Invalid:
		}
		return false;
	}
	
	if( bInstantChange ) // don't request frame or timer atm of disconnection to lobby
	{
		g_bMapStarted = false;
		ForceChangeLevel(sMapName, "Map Vote");
		return true;
	}
	
	ShowChangeLevelNotify(sMapName);
	
	DataPack dp = new DataPack();
	dp.WriteString(sMapName);
	CreateTimer(g_hCvarMapChangeNotifyTime.FloatValue, Timer_ChangeLevel, dp, TIMER_FLAG_NO_MAPCHANGE);
	return true;
}

void FinaleMapChange()
{
	GotoNextMap();
}

void GotoNextMap(bool bInstantChange = false)
{
	static int iLastTime;
	if( iLastTime != 0 && GetTime() - iLastTime <= 5 ) // don't allow to run faster than 5 sec.
	{
		return;
	}
	
	char sMapName[MAX_MAP_NAME];
	
	int idx = g_aMapOrder.FindString(g_sCurMap); // search default maps

	// 硬编码官方地图顺序
	bool bFix;
	if( idx != -1 ) // is it default map?
	{
		if ( view_as<NEXT_MAP_METHOD>(g_hCvarNextMapOnStandard.IntValue) == NEXT_MAP_METHOD_STANDARD_RANDOM && g_bIsFinale )
		{
			GetRandomFirstMap_Standard(sMapName, sizeof(sMapName));
			bFix = false;
		}
		
		else {
			bFix = true;
			idx++;
			if( idx >= g_aMapOrder.Length )
			{
				idx = 0;
			}
			g_aMapOrder.GetString(idx, sMapName, sizeof(sMapName));
			
			if( IsBlackListedCycleMap(sMapName) ) // temporarily solution
			{
				GetRandomFirstMap_Standard(sMapName, sizeof(sMapName));
			}
		}
	}
	else { // custom map
		idx = g_aMapCustomOrder.FindString(g_sCurMap); // search custom maps
		
		if( idx != -1 )
		{
			if( g_bIsFinale )
			{
				switch( view_as<NEXT_MAP_METHOD>(g_hCvarNextMapOnCustom.IntValue) )
				{
					case NEXT_MAP_METHOD_STANDARD: {
						g_aMapOrder.GetString(0, sMapName, sizeof(sMapName));
						
						if( IsBlackListedCycleMap(sMapName) ) // temporarily solution
						{
							GetRandomFirstMap_Standard(sMapName, sizeof(sMapName));
						}
					}
					case NEXT_MAP_METHOD_STANDARD_RANDOM: {
						GetRandomFirstMap_Standard(sMapName, sizeof(sMapName));
					}
					case NEXT_MAP_METHOD_CUSTOM: {
						idx++;
						if( idx >= g_aMapCustomOrder.Length )
						{
							idx = 0;
						}
						g_aMapCustomOrder.GetString(idx, sMapName, sizeof(sMapName));
						
						if( IsBlackListedCycleMap(sMapName) ) // temporarily solution
						{
							GetRandomFirstMap_Custom(sMapName, sizeof(sMapName));
						}
					}
					case NEXT_MAP_METHOD_CUSTOM_RANDOM: {
						GetRandomFirstMap_Custom(sMapName, sizeof(sMapName));
					}
				}
			}
			else {
				idx++;
				if( idx >= g_aMapCustomOrder.Length )
				{
					idx = 0;
				}
				g_aMapCustomOrder.GetString(idx, sMapName, sizeof(sMapName));
				
				if( IsBlackListedCycleMap(sMapName) ) // temporarily solution
				{
					GetRandomFirstMap_Custom(sMapName, sizeof(sMapName));
				}
			}
		}
		else {
			g_aMapOrder.GetString(0, sMapName, sizeof(sMapName)); // emergency: fallback
		}
	}
	
	if( sMapName[0] == 0 )
	{
		g_aMapOrder.GetString(0, sMapName, sizeof(sMapName)); // emergency: fallback to default map if no suitable custom map found, e.g. everything is deleted.
	}
	
	if( !IsMapValidEx(sMapName) ) // if map removed in mid-game.
	{
		RemoveBrokenMap(sMapName);
		FinaleMapChange();
		return;
	}
	
	iLastTime = GetTime();
	if(bFix)
	{
		char name[32];
		GetCurrentMap(name, sizeof(name) );
		// c10, c11, c12, c13, c14
		//int iNum;
		//char sNum[4];
		PrintToServer("\n!!!! 当前选择: %s\n", name);
		
		if(name[3] == 'm' )
		{
			switch(name[2])
			{		
				case	'0':	Format(name, sizeof(name), "c11m1_greenhouse");
				case	'1':	Format(name, sizeof(name), "c12m1_hilltop");
				case	'2':	Format(name, sizeof(name), "c7m1_docks");
				case	'3':	Format(name, sizeof(name), "c8m1_apartment");
				case	'4':	Format(name, sizeof(name), "c1m1_hotel");
			}
		}
		// c1, c2 ...
		else
		{	
			// 你是对的，但是我们需要完整的地图名...
			/*
			Format(sNum, sizeof(sNum), "%c", name[1] );
			StringToInt(sNum, iNum);
			iNum++;
			Format(sNum, sizeof(sNum), "%d", name)
			*/
			switch(name[1])	
			{
				case	'1':	Format(name, sizeof(name), "c6m1_riverbank");
				case	'2':	Format(name, sizeof(name), "c3m1_plankcountry");
				case	'3':	Format(name, sizeof(name), "c4m1_milltown_a");
				case	'4':	Format(name, sizeof(name), "c5m1_waterfront");
				case	'5':	Format(name, sizeof(name), "c13m1_alpinecreek");

				case	'6':	Format(name, sizeof(name), "c2m1_highway");
				case	'7':	Format(name, sizeof(name), "c14m1_junkyard");
				case	'8':	Format(name, sizeof(name), "c9m1_alleys");
				case	'9':	Format(name, sizeof(name), "c10m1_caves");
				
			}
		}
		PrintToServer("\n!!!! 切换到: %s\n", name);
		L4D_ChangeLevel(name, bInstantChange);
	}
	else	L4D_ChangeLevel(sMapName, bInstantChange);
}

bool GetRandomFirstMap_Custom(char[] map, int maxlen)
{
	static char firstMap[MAX_MAP_NAME];
	static ArrayList uniqMaps;
	
	if( g_bEmptyMapCycleCustom ) return false;
	
	if( !uniqMaps )
	{
		uniqMaps = g_aMapCustomFirst.Clone();
	}
	if( uniqMaps.Length == 0 )
	{
		delete uniqMaps;
		uniqMaps = g_aMapCustomFirst.Clone();
	}
	if( uniqMaps.Length == 0 )
	{
		return false;
	}
	
	GetFirstMap_Custom(g_sCurMap, firstMap, sizeof(firstMap));
	
	int idxFirst = uniqMaps.FindString(firstMap);
	if( idxFirst != -1 )
	{
		uniqMaps.Erase(idxFirst); // exclude current map from cycle to make "random" be a real random.
	}
	if( uniqMaps.Length == 0 ) // no maps elapsed => populate array again.
	{
		delete uniqMaps;
		uniqMaps = g_aMapCustomFirst.Clone();
		
		idxFirst = uniqMaps.FindString(firstMap); // repeat the step which disallowing current map to appear in cycle too early
		if( idxFirst != -1 )
		{
			uniqMaps.Erase(idxFirst);
			
			if( uniqMaps.Length == 0 ) // final check, in case cycle contains only 1 campaign
			{
				delete uniqMaps;
				uniqMaps = g_aMapCustomFirst.Clone();
			}
		}
	}
	if( uniqMaps.Length != 0 )
	{
		int idx = GetRandomInt(0, uniqMaps.Length - 1);
		uniqMaps.GetString(idx, map, maxlen);
		uniqMaps.Erase(idx);
	}
	return map[0] != 0;
}

bool GetRandomFirstMap_Standard(char[] map, int maxlen)
{
	static char firstMap[MAX_MAP_NAME];
	static ArrayList uniqMaps;
	
	if( !uniqMaps )
	{
		uniqMaps = g_aMapStandardFirst.Clone();
	}
	if( uniqMaps.Length == 0 )
	{
		delete uniqMaps;
		uniqMaps = g_aMapStandardFirst.Clone();
	}
	if( uniqMaps.Length == 0 )
	{
		return false;
	}
	
	GetFirstMap_Standard(g_sCurMap, firstMap, sizeof(firstMap));
	
	int idxFirst = uniqMaps.FindString(firstMap);
	if( idxFirst != -1 )
	{
		uniqMaps.Erase(idxFirst); // exclude current map from cycle to make "random" be a real random.
	}
	if( uniqMaps.Length == 0 ) // no maps elapsed => populate array again.
	{
		delete uniqMaps;
		uniqMaps = g_aMapCustomFirst.Clone();
		
		idxFirst = uniqMaps.FindString(firstMap); // repeat the step which disallowing current map to appear in cycle too early
		if( idxFirst != -1 )
		{
			uniqMaps.Erase(idxFirst);
			
			if( uniqMaps.Length == 0 ) // final check, in case cycle contains only 1 campaign
			{
				delete uniqMaps;
				uniqMaps = g_aMapCustomFirst.Clone();
			}
		}
	}
	if( uniqMaps.Length != 0 )
	{
		int idx = GetRandomInt(0, uniqMaps.Length - 1);
		uniqMaps.GetString(idx, map, maxlen);
		uniqMaps.Erase(idx);
	}
	return map[0] != 0;
}

void RemoveBrokenMap(char[] sMapName)
{
	int idx = g_aMapOrder.FindString(sMapName);
	if( idx != -1 )
	{
		g_aMapOrder.Erase(idx);
	}
	idx = g_aMapCustomOrder.FindString(sMapName);
	if( idx != -1 )
	{
		g_aMapCustomOrder.Erase(idx);
	}
	idx = g_aMapCustomFirst.FindString(sMapName);
	if( idx != -1 )
	{
		g_aMapCustomFirst.Erase(idx);
	}
}

bool IsMapValidEx(char[] map)
{
	if( map[0] == 0 ) return false;
	static char path[PLATFORM_MAX_PATH];
	return FindMap(map, path, sizeof(path)) == FindMap_Found;
}

void GetMissions()
{
	delete g_kvdef;
	g_kvdef = new KeyValues("campaigns");
	g_hNameByMap.Clear();
	g_hCampaignByMap.Clear();
	g_aMapOrder.Clear();
	
	if( g_bLeft4Dead2 )
	{
		char missionFile[64];
		FileType fileType;
		DirectoryListing hDir = OpenDirectory("missions", true, ".");
		if( hDir )
		{
			while( hDir.GetNext(missionFile, PLATFORM_MAX_PATH, fileType) )
			{
				if( fileType == FileType_File )
				{
					if( strncmp(missionFile, "campaign", 8) == 0 )
					{
						Format(missionFile, sizeof(missionFile), "missions/%s", missionFile);
						ParseMissionFile(missionFile, false);
					}
				}
			}
			delete hDir;
		}
	}
	else {
		ParseMissionFile("missions/hospital.txt", false);
		ParseMissionFile("missions/garage.txt", false);
		ParseMissionFile("missions/smalltown.txt", false);
		ParseMissionFile("missions/airport.txt", false);
		ParseMissionFile("missions/farm.txt", false);
		ParseMissionFile("missions/river.txt", false); // dlc3
		ParseMissionFile("missions/lighthouse.txt", false);
	}
}

void GetAddonMissions()
{
	delete g_kv;
	g_kv = new KeyValues("campaigns");
	
	char missionFile[64];
	StringMap hMapDef = new StringMap();
	FileType fileType;
	DirectoryListing hDir;
	
	if( g_bLeft4Dead2 )
	{
		for( int i = 1; i <= 14; i++ )
		{
			FormatEx(missionFile, sizeof(missionFile), "campaign%i.txt", i);
			hMapDef.SetValue(missionFile, 1);
		}
		hMapDef.SetValue("credits.txt", 1);
		hMapDef.SetValue("holdoutchallenge.txt", 1);
		hMapDef.SetValue("holdouttraining.txt", 1);
		hMapDef.SetValue("parishdash.txt", 1);
		hMapDef.SetValue("shootzones.txt", 1);
	}
	else {
		hDir = OpenDirectory("missions", false);
		if( hDir )
		{
			while( hDir.GetNext(missionFile, PLATFORM_MAX_PATH, fileType) )
			{
				if( fileType == FileType_File )
				{
					hMapDef.SetValue(missionFile, 1);
				}
			}
			delete hDir;
		}
	}
	
	hDir = OpenDirectory("missions", true, ".");
	if( hDir )
	{
		while( hDir.GetNext(missionFile, PLATFORM_MAX_PATH, fileType) )
		{
			if( fileType == FileType_File )
			{
				if( !StringMap_KeyExists(hMapDef, missionFile) )
				{
					Format(missionFile, sizeof(missionFile), "missions/%s", missionFile);
					ParseMissionFile(missionFile, true);
				}
			}
		}
		delete hDir;
	}
	delete hMapDef;
}

bool StringMap_KeyExists(StringMap hMap, char[] key)
{
	int v;
	return hMap.GetValue(key, v);
}

bool ParseMissionFile(char[] missionFile, bool bIsAddon)
{
	File hFile = OpenFile(missionFile, "r", true, NULL_STRING);
	if( hFile == null )
	{
		PrintToServer("Failed to open mission file: \"%s\".", missionFile);
		return false;
	}
	
	static char str[512], sName[MAX_MAP_TITLE], sTitle[MAX_MAP_TITLE], sCampaign[MAX_CAMPAIGN_TITLE];
	static char sMap[MAX_MAP_NAME], sMapDisplay[MAX_MAP_TITLE], sPrevMap[MAX_MAP_NAME], sPrevMapDisplay[MAX_MAP_TITLE];
	sName[0] = 0;
	sTitle[0] = 0;
	sCampaign[0] = 0;
	sPrevMap[0] = 0;
	sPrevMapDisplay[0] = 0;
	
	GAME_TYPE eType, eCurGameType;
	
	while( !hFile.EndOfFile() && hFile.ReadLine(str, sizeof(str)) )
	{
		TrimString(str);
		
		if( sName[0] == 0 )
		{
			KV_GetValue(str, "Name", sName);
		}
		if( sTitle[0] == 0 )
		{
			KV_GetValue(str, "DisplayTitle", sTitle);
		}
		
		eType = KV_FindGameMode(str);
		
		if( eType != GAME_TYPE_NONE )
		{
			if( eCurGameType != GAME_TYPE_NONE && sPrevMap[0] != 0 )
			{
				AddMapTemplate(bIsAddon, sCampaign, eCurGameType, sPrevMap, sPrevMapDisplay);
				sPrevMap[0] = 0;
				sPrevMapDisplay[0] = 0;
			}
			
			eCurGameType = eType;
			
			if( sCampaign[0] == 0 )
			{
				// give preference to "DisplayTitle" (usually, more suitable) if length > 5
				// "$name" is some link, so skip it.
				strcopy(sCampaign, sizeof(sCampaign), sTitle[0] != '$' && ( strlen(sTitle) > 5 || (strlen(sTitle) > strlen(sName)) ) ? sTitle : 
					sName[0] != 0 ? sName : sTitle );
			}
		}
		
		if( eCurGameType != GAME_TYPE_NONE )
		{
			if( KV_GetValue(str, "Map", sMap) )
			{
				if( sPrevMap[0] != 0 ) // dump map info when the next "map" key is met
				{
					AddMapTemplate(bIsAddon, sCampaign, eCurGameType, sPrevMap, sPrevMapDisplay);
					sPrevMapDisplay[0] = 0;
				}
				strcopy(sPrevMap, sizeof(sPrevMap), sMap);
			}
			if( KV_GetValue(str, "DisplayName", sMapDisplay) )
			{
				ClearDisplayName(sMapDisplay, sizeof(sMapDisplay));
				strcopy(sPrevMapDisplay, sizeof(sPrevMapDisplay), sMapDisplay);
			}
		}
	}
	if( sPrevMap[0] != 0 ) // dump the leftover
	{
		AddMapTemplate(bIsAddon, sCampaign, eCurGameType, sPrevMap, sPrevMapDisplay);
	}
	if( bIsAddon )
	{
		g_kv.Rewind();
		g_kv.ExportToFile(g_sMapListPath);
	}
	return true;
}

void AddMapTemplate(bool bIsAddon, char[] sCampaign, GAME_TYPE eType, char[] sMap, char[] sMapDisplay)
{
	if( sCampaign[0] != '#' )
	{
		ClearStringMB(sCampaign);
		NormalizeName(sCampaign);
	}
	if( sMapDisplay[0] != '#' )
	{
		NormalizeName(sMapDisplay);
	}
	
	if( bIsAddon )
	{
		if( IsMapValidEx(sMap) )
		{
			AddMapToKV(g_kv, sCampaign, eType, sMap, sMapDisplay);
		}
	}
	else {
		if( g_eGameType == eType )
		{
			if( IsMapValidEx(sMap) )
			{
				AddMapToKV(g_kvdef, sCampaign, eType, sMap, sMapDisplay);
				g_hNameByMap.SetString(sMap, sMapDisplay, false);
				g_hCampaignByMap.SetString(sMap, sCampaign, false);
				//g_aMapOrder.PushString(sMap); // moded to -> FillStandardCampaignOrder
			}
		}
	}
}

void AddMapToKV(KeyValues kv, char[] sCampaign, GAME_TYPE eType, char[] sMap, char[] sMapDisplay)
{
	int num;
	char sKey[4];
	kv.Rewind();
	
	if( kv.JumpToKey(sCampaign, true) )
	{
		if( kv.JumpToKey(GAME_TYPE_STR[eType], true) )
		{
			if( kv.GotoFirstSubKey(true) )
			{
				// calculate current count in list
				do
				{
					++num;
				} while( kv.GotoNextKey() );
				
				kv.GoBack();
			}
			++num;
			
			IntToString(num, sKey, sizeof(sKey));
			
			if( kv.JumpToKey(sKey, true) )
			{
				kv.SetString("Map", sMap);
				kv.SetString("DisplayName", sMapDisplay);
			}
		}
	}
	//PrintToServer("(%s) Map: \"%s\" (%s)", GAME_TYPE_STR[eType], sMap, sMapDisplay);
}

GAME_TYPE KV_FindGameMode(char[] str)
{
	if( KV_HasKey(str, "coop") )
	{
		return GAME_TYPE_COOP;
	}
	if( KV_HasKey(str, "versus") )
	{
		return GAME_TYPE_VERSUS;
	}
	if( KV_HasKey(str, "survival") )
	{
		return GAME_TYPE_SURVIVAL;
	}
	return GAME_TYPE_NONE;
}

bool KV_HasKey(char[] str, char[] key)
{
	int posKey, posComment;
	char substr[64];
	FormatEx(substr, sizeof(substr), "\"%s\"", key);
	
	posKey = StrContains(str, substr, false);
	if( posKey != -1 )
	{
		posComment = StrContains(str, "//", true);
		if( posComment == -1 || posComment > posKey )
		{
			for( int i = 0; i < posKey; i++ ) // is token first in line, e.g. not "DisplayName" "Coop"
			{
				if( str[i] != 32 && str[i] != 9 )
					return false;
			}
			return true;
		}
	}
	return false;
}

bool KV_GetValue(char[] str, char[] key, char buffer[64])
{
	buffer[0] = 0;
	int posKey, posComment, sizeKey;
	char substr[64];
	FormatEx(substr, sizeof(substr), "\"%s\"", key);
	
	posKey = StrContains(str, substr, false);
	if( posKey != -1 )
	{
		posComment = StrContains(str, "//", true);
		
		if( posComment == -1 || posComment > posKey )
		{
			sizeKey = strlen(substr);
			buffer = UnQuote(str[posKey + sizeKey]);
			return true;
		}
	}
	return false;
}

char[] UnQuote(char[] Str)
{
	int pos;
	static char buf[64];
	strcopy(buf, sizeof(buf), Str);
	TrimString(buf);
	if (buf[0] == '\"') {
		strcopy(buf, sizeof(buf), buf[1]);
	}
	pos = FindCharInString(buf, '\"');
	if( pos != -1 ) {
		buf[pos] = '\x0';
	}
	return buf;
}

void ClearStringMB(char[] sName) // Removes all multi-byte letters, except those from RU & UA ANSI mapping
{
	if( sName[0] == 0 )
		return;
	
	int i = 0, j = 0, bytes;
	
	if( !IsCharAlpha(sName[i]) && !IsCharNumeric(sName[i]) )
	{
		i++;
	}
	while( sName[i] )
	{
		bytes = GetCharBytes(sName[i]);
		
		if( bytes == 1 )
		{
			if( sName[i] >= 32 )
			{
				if( j == 0 && !IsCharAlpha(sName[i]) && !IsCharNumeric(sName[i]) )
				{
					// don't print special character as 1st letter
				}
				else {
					sName[j++] = sName[i];
				}
			}
		}
		else if( bytes == 2 )
		{
			if( sName[i] == 208 || sName[i] == 209 ) // RU, UA & perhaps, other ANSI
			{
				sName[j++] = sName[i++];
				sName[j++] = sName[i];
			}
		}
		i++;
	}
	sName[j] = 0;
}

void ClearDisplayName(char[] str, int size) // trim numbering, like: "1. Mission name" / "1: Mission name"
{
	int pos = 0;
	if( size > 3 )
	{
		if( IsCharNumeric(str[0]) )
		{
			++ pos;
			
			if( IsCharNumeric(str[pos]) )
				++ pos;
			
			//if( str[pos] == '.' || str[pos] == ':' || str[pos] == ')' || str[pos] == '-' )
			if( !IsCharAlpha(str[pos]) )
			{
				++ pos;
				if( str[pos] == ' ' )
				{
					++ pos;
				}
				/*
				if( !IsCharAlpha(str[pos]) )
				{
					++ pos;
				}
				*/
			}
			Format(str, size, str[pos]);
		}
	}
}

void NormalizeName(char[] str)
{
	if( !str[0] )
		return;
	
	UTF8CharToUpper(str, 0, GetCharBytes(str[0]));
	
	int bytesToProcess, startByte = GetCharBytes(str[0]), max_len = strlen(str);
	
	// start from 2nd letter
	for( int i = startByte; i < max_len; i += GetCharBytes(str[i]) )
	{
		if( IsCharSpace(str[i]) )
		{
			if( bytesToProcess )
			{
				UTF8CharToLower(str, startByte, startByte + bytesToProcess);
			}
			// skip first letter of next words
			startByte = i + 1;
			if( startByte < max_len )
			{
				startByte += GetCharBytes(str[i+1]);
			}
			bytesToProcess = 0;
			++i;
		}
		else {
			bytesToProcess += GetCharBytes(str[i]);
		}
	}
	if( bytesToProcess ) // process leftovers
	{
		UTF8CharToLower(str, startByte, startByte + bytesToProcess);
	}
}

// Made by komashchenko: https://hlmod.ru/resources/inc-utf8-string.898/
// Forked.
/**
 * Делает с нижнего регистра верхний.
 *
 * @param string			строка для конвертации.
 * @param int				начальный байт обработки.
 * @param end				конечный байт обработки.
 * @return		количество символов которые были переведены в верхний регистр	
 */
stock int UTF8CharToUpper(char[] string, int start = 0, int end = -1)
{
	int I = start, O = end == -1 ? strlen(string) : end, Byte, K;
	while(I < O)
	{
		Byte = string[I];
		if(Byte >= 128)
		{
			if(Byte >= 240)
			{
				if(strlen(string[I]) < 4) break; 
				else I += 4; 
			}
			else if(Byte >= 224)
			{
				if(strlen(string[I]) < 3) break; 
				else I += 3; 
			}
			else if(Byte >= 192)
			{
				if(strlen(string[I]) < 2) break;
				Byte = (Byte % 32) * 64; 
				Byte += (string[I+1] % 64);
				if(1072 <= Byte <= 1103 || Byte == 1105 || 1110 <= Byte <= 1111 || Byte == 1169)
				{
					if(1105 <= Byte <= 1111) Byte = Byte-80;
					else if(Byte != 1169) Byte = Byte-32;
					else Byte--;
					string[I]   = 192 + RoundToFloor(float(Byte / 64));
					string[I+1] = 128 + (Byte % 64);
					K++;
				}
				I += 2;
			}
			else break;
		}
		else
		{
			if(97 <= Byte <= 122)
			{
				string[I] = Byte-32;
				K++;
			}
			I += 1;
		}
	}
	return K;
}

// Made by komashchenko: https://hlmod.ru/resources/inc-utf8-string.898/
// Forked.
/**
 * Делает с верхнего регистра нижний.
 *
 * @param string			строка для конвертации.
 * @param int				начальный байт обработки.
 * @param end				конечный байт обработки.
 * @return		количество символов которые были переведены в нижний регистр	
 */
stock int UTF8CharToLower(char[] string, int start = 0, int end = -1)
{
	int I = start, O = end == -1 ? strlen(string) : end, Byte, K;
	while(I < O)
	{
		Byte = string[I];
		if(Byte >= 128)
		{
			if(Byte >= 240)
			{
				if(strlen(string[I]) < 4) break; 
				else I += 4; 
			}
			else if(Byte >= 224)
			{
				if(strlen(string[I]) < 3) break; 
				else I += 3; 
			}
			else if(Byte >= 192)
			{
				if(strlen(string[I]) < 2) break;
				Byte = (Byte % 32) * 64; 
				Byte += (string[I+1] % 64);
				if(1040 <= Byte <= 1071 || Byte == 1025 || 1030 <= Byte <= 1031 || Byte == 1168) 
				{
					if(1025 <= Byte <= 1031) Byte = Byte+80;
					else if(Byte != 1168) Byte = Byte+32;
					else Byte++;
					string[I]   = 192 + RoundToFloor(float(Byte / 64));
					string[I+1] = 128 + (Byte % 64);
					K++;
				}
				I += 2;
			}
			else break;
		}
		else
		{
			if(65 <= Byte <= 90)
			{
				string[I] = Byte+32;
				K++;
			}
			I++;
		}
	}
	return K;
}

stock bool GetCampaignDisplay(char[] map, char[] name, int maxlen, bool bTranslate = false, int client = 0, bool normalize = true)
{
	if( g_hCampaignByMap.GetString(map, name, maxlen) )
	{
		if( bTranslate )
		{
			//Format(name, maxlen, "%T", name, client);
			strcopy(name, maxlen, Loc_Translate(client, name));
		}
		if( normalize )
		{
			NormalizeName(name);
		}
		return true;
	}
	else {
		g_hCampaignByMapCustom.GetString(map, name, maxlen);
		if( bTranslate )
		{
			strcopy(name, maxlen, Loc_Translate(client, name));
		}
		if( normalize )
		{
			NormalizeName(name);
		}
		return true;
	}
}

stock bool GetMapDisplay(char[] map, char[] name, int maxlen, bool bTranslate = false, int client = 0, bool normalize = true)
{
	if( g_hNameByMap.GetString(map, name, maxlen) )
	{
		if( bTranslate )
		{
			strcopy(name, maxlen, Loc_Translate(client, name));
			ClearDisplayName(name, sizeof(maxlen));
		}
		if( normalize )
		{
			//NormalizeName(name); // overkill
		}
		return true;
	}
	else {
		g_hNameByMapCustom.GetString(map, name, maxlen);
		if( bTranslate )
		{
			strcopy(name, maxlen, Loc_Translate(client, name));
			ClearDisplayName(name, sizeof(maxlen));
		}
		if( normalize )
		{
			//NormalizeName(name); // overkill
		}
		return true;
	}
}

stock bool IsCustomMap(char[] map)
{
	static char sCampaign[MAX_CAMPAIGN_TITLE];
	return !g_hCampaignByMap.GetString(map, sCampaign, sizeof(sCampaign));
}

stock bool GetMapNumber(const char[] campaign, const char[] sMap, int &iCurNumber, int &iTotalNumber)
{
	if( !GetMapNumberEx(g_kv, campaign, sMap, iCurNumber, iTotalNumber) )
	{
		return GetMapNumberEx(g_kvdef, campaign, sMap, iCurNumber, iTotalNumber);
	}
	return true;
}

stock bool GetMapNumberEx(KeyValues kv, const char[] campaign, const char[] checkMap, int &iCurNumber, int &iTotalNumber)
{
	static char map[MAX_MAP_NAME];
	iTotalNumber = 0;
	iCurNumber = 0;
 	kv.Rewind();
	if( kv.JumpToKey(campaign) )
	{
		if( !kv.JumpToKey(g_sGameMode) )
		{
			if( !kv.JumpToKey("coop") ) { // default
				return false;
			}
		}
		kv.GotoFirstSubKey();
		do
		{
			kv.GetString("Map", map, sizeof(map), "@");
			if( strcmp(map, "@") != 0 )
			{
				if( IsMapValidEx(map) )
				{
					iTotalNumber++;
					
					if( strcmp(map, checkMap) == 0 )
					{
						iCurNumber = iTotalNumber;
					}
				}
			}
		} while( kv.GotoNextKey() );
	}
	return iTotalNumber != 0;
}

stock void GetFirstMapEx(KeyValues kv, char[] mapOfCampaign, char[] firstMap, int maxlen)
{
	static char campaign[MAX_CAMPAIGN_TITLE];
	firstMap[0] = 0;

	if( GetCampaignDisplay(mapOfCampaign, campaign, sizeof(campaign)) )
	{
		kv.Rewind();
		if( kv.JumpToKey(campaign) )
		{
			if( kv.JumpToKey(g_sGameMode) )
			{
				kv.GotoFirstSubKey();
				kv.GetString("Map", firstMap, maxlen);
			}
		}
	}
}

stock void GetFirstMap_Standard(char[] mapOfCampaign, char[] firstMap, int maxlen)
{
	GetFirstMapEx(g_kvdef, mapOfCampaign, firstMap, maxlen);
}

stock void GetFirstMap_Custom(char[] mapOfCampaign, char[] firstMap, int maxlen)
{
	GetFirstMapEx(g_kv, mapOfCampaign, firstMap, maxlen);
}

stock void GetLastMapEx(KeyValues kv, char[] mapOfCampaign, char[] lastMap, int maxlen)
{
	static char campaign[MAX_CAMPAIGN_TITLE];
	lastMap[0] = 0;
	
	if( GetCampaignDisplay(mapOfCampaign, campaign, sizeof(campaign)) )
	{
		kv.Rewind();
		if( kv.JumpToKey(campaign) )
		{
			if( kv.JumpToKey(g_sGameMode) )
			{
				kv.GotoFirstSubKey();
				do
				{
					kv.GetString("Map", lastMap, maxlen);
				} while( kv.GotoNextKey() );
			}
		}
	}
}

stock void GetLastMap_Standard(char[] mapOfCampaign, char[] lastMap, int maxlen)
{
	GetLastMapEx(g_kvdef, mapOfCampaign, lastMap, maxlen);
}

stock void GetLastMap_Custom(char[] mapOfCampaign, char[] lastMap, int maxlen)
{
	GetLastMapEx(g_kv, mapOfCampaign, lastMap, maxlen);
}

stock bool IsFinaleMap(char[] map)
{
	char sCampaign[MAX_CAMPAIGN_TITLE];
	int iIndexMap, iTotalMaps;
	GetCampaignDisplay(map, sCampaign, sizeof(sCampaign), false);
	GetMapNumber(sCampaign, map, iIndexMap, iTotalMaps);
	return iIndexMap == iTotalMaps;
}

bool IsBlackListedCycleMap(char[] map)
{
	return g_hArrayCycleBlock.FindString(map) != -1;
}

bool InDenyFile(int client, ArrayList list)
{
	static char sName[MAX_NAME_LENGTH], str[MAX_NAME_LENGTH];
	static char sSteam[64];
	
	GetClientAuthId(client, AuthId_Steam2, sSteam, sizeof(sSteam));
	GetClientName(client, sName, sizeof(sName));
	
	for( int i = 0; i < list.Length; i++ )
	{
		list.GetString(i, str, sizeof(str));
	
		if( strncmp(str, "STEAM_", 6, false) == 0 )
		{
			if( strcmp(sSteam, str, false) == 0 )
			{
				return true;
			}
		}
		else {
			if( StrContains(str, "*") ) // allow masks like "Dan*" to match "Danny and Danil"
			{
				ReplaceString(str, sizeof(str), "*", "");
				if( StrContains(sName, str, false) != -1 )
				{
					return true;
				}
			}
			else {
				if( strcmp(sName, str, false) == 0 )
				{
					return true;
				}
			}
		}
	}
	return false;
}

bool CanVote(int client, bool bIsCustom)
{
	if( InDenyFile(client, g_hArrayVoteBlock) )
	{
		return false;
	}
	int iUserFlag = GetUserFlagBits(client);
	if( iUserFlag & ADMFLAG_ROOT != 0 ) return true;

	static char sReq[32];
	if( !bIsCustom )
	{
		g_hCvarMapVoteAccessDef.GetString(sReq, sizeof(sReq));
	}
	else {
		g_hCvarMapVoteAccessCustom.GetString(sReq, sizeof(sReq));
	}
	if( sReq[0] != 0 )
	{
		int iReqFlags = ReadFlagString(sReq);
		if( iUserFlag & iReqFlags )
			return true;
	}
	
	#if defined _vip_core_included
		if( g_hCvarMapVoteAccessVip.BoolValue )
		{
			if( g_bVipCoreLib )
			{
				if( VIP_IsClientVIP(client) )
				{
					return true;
				}
			}
		}
	#endif
	
	#if defined _hxstats_included
	if( g_bHxStatsAvail && g_hCvarVoteStatPoints.IntValue && g_hCvarVoteStatPlayTime.IntValue && iUserFlag == 0 )
	{
		if( HX_IsClientRegistered(client) )
		{
			int iPoints = HX_GetPoints(client, HX_COUNTING_ACTUAL, HX_POINTS);
			if( iPoints < g_hCvarVoteStatPoints.IntValue ) {
				CPrintToChat(client, "%t: %i/%i", "no_points", iPoints, g_hCvarVoteStatPoints.IntValue); // Not enough points
				return false;
			}
			
			int iTime = HX_GetPoints(client, HX_COUNTING_ACTUAL, HX_TIME);
			if( iTime < g_hCvarVoteStatPlayTime.IntValue ) {
				CPrintToChat(client, "%t: %i/%i", "no_time", iTime, g_hCvarVoteStatPlayTime.IntValue); // Not enough play time
				return false;
			}
		}
		else {
			return false;
		}
	}
	#endif
	return true;
}

bool HasVetoAccessFlag(int client)
{
	int iUserFlag = GetUserFlagBits(client);
	if( iUserFlag & ADMFLAG_ROOT != 0 ) return true;
	
	char sReq[32];
	g_hCvarVetoFlag.GetString(sReq, sizeof(sReq));
	if( strlen(sReq) == 0 ) return true;
	
	int iReqFlags = ReadFlagString(sReq);
	return (iUserFlag & iReqFlags != 0);
}

bool HasVoteRatingAccess(int client)
{
	int iUserFlag = GetUserFlagBits(client);
	if( iUserFlag & ADMFLAG_ROOT != 0 ) return true;
	
	char sReq[32];
	g_hCvarVoteMarkFlag.GetString(sReq, sizeof(sReq));
	if( strlen(sReq) == 0 ) return true;
	
	int iReqFlags = ReadFlagString(sReq);
	return (iUserFlag & iReqFlags != 0);
}

bool HasRemoveRatingAccess(int client)
{
	int iUserFlag = GetUserFlagBits(client);
	if( iUserFlag & ADMFLAG_ROOT != 0 ) return true;
	
	char sReq[32];
	g_hCvarRemoveMarkFlag.GetString(sReq, sizeof(sReq));
	if( strlen(sReq) == 0 ) return true;
	
	int iReqFlags = ReadFlagString(sReq);
	return (iUserFlag & iReqFlags != 0);
}

int iGetListenServerHost(int client, bool dedicated) // Thanks to @Marttt
{
	if( client == 0 && !dedicated )
	{
		int iManager = FindEntityByClassname(-1, "terror_player_manager");
		if( iManager != -1 && IsValidEntity(iManager) )
		{
			int iHostOffset = FindSendPropInfo("CTerrorPlayerResource", "m_listenServerHost");
			if( iHostOffset != -1 )
			{
				bool bHost[MAXPLAYERS + 1];
				GetEntDataArray(iManager, iHostOffset, bHost, (MAXPLAYERS + 1), 1);
				for( int iPlayer = 1; iPlayer < sizeof(bHost); iPlayer++ )
				{
					if( bHost[iPlayer] )
					{
						return iPlayer;
					}
				}
			}
		}
	}
	return client;
}
