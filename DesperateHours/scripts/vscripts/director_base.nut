//======== Copyright (c) 2009, Valve Corporation, All rights reserved. ========
//
//=============================================================================

printl( "===[VS]Initializing Green Flu Custom c11m* Director's script" );

DirectorOptions <-
{

	finaleStageList = []
	OnChangeFinaleMusic	= ""

	function OnChangeFinaleStage( from, to)
	{
		if ( to > 0 && to < finaleStageList.len() )
		{
			OnChangeFinaleMusic = finaleStageList[to];
		}
	}
	//CI的伤害倍数
//	cm_BaseCommonAttackDamage = 0.25
	//暴风骤雨的汽油罐在背上，用于检测脚本是否生效
	//GasCansOnBacks = true
	//无论SU强度如何，永远生成零散的CI
	//***AlwaysAllowWanderers = true
	//IntensityRelaxAllowWanderersThreshold = 0.98
	//PreferredMobDirection = SPAWN_ANYWHERE
	//零散CI的数量乘子
	//WanderingZombieDensityModifier = 1.5
	//realx阶段的持续时间
	RelaxMaxInterval = 360
	RelaxMinInterval = 240
	/*
	由realx跳转至峰值时SU可以走动多远
	9000为瘸腿速度一直走60s的距离
	9900为正常速度拿出四分之一时间搜索物品的跑图者前进的最远距离
	13200为正常速度跑图的最远距离
	11000为正常速度拿出六分之一的跑图距离
	在瘸腿状态时，拿出一半时间用于清理CI与搜集物品可以获得160s的休息时间
	*/
	RelaxMaxFlowTravel = 36000
	//要多少CI才会触发尸潮音乐
	MusicDynamicMobSpawnSize = 160
	//最高强度时发起攻击的最小间隔
	BuildUpMinInterval = 15
	//维持峰值状态而时间
	SustainPeakMaxTime = 24
	SustainPeakMinTime = 12
	//CI在此范围内发现SU的时间最短
	NearAcquireRange = 400.0
	//最短时间
	NearAcquireTime = 1.0
	//CI可发现SU的最大范围
	FarAcquireRange = 3000
	//CI/SI会被删除的距离
	ZombieDiscardRange = 4000
	//CI的可同时存在的最大数量
	CommonLimit = 80
	//即便尸潮来临，闲逛的感染者数量不应低于
	NumReservedWanderers = 30
	//所有感染者生成的最大距离
	//ZombieSpawnRange = 3000.0 
	//SI重生的时间
	SpecialRespawnInterval = 200
	//导演最多可以同时创建多少SI，不是最大可存在的数量？
	MaxSpecials = 5
//	BoomerLimit = 0
	SmokerLimit = 2
//	SpitterLimit = 0
//	JockeyLimit = 0
	HunterLimit = 2
//	ChargerLimit = 0
	//峰值状态的维持时间？
	//SustainPeakMaxTime
	//固定尸潮，恐慌事件，最多可存在的CI
//	MegaMobSize = 240
	//尸潮生成时间
	MobSpawnMaxTime = 400
	MobSpawnMinTime = 200
	//尸潮的数量
	MobMaxSize = 240
	MobMinSize = 400
	//不允许在威胁区域生成Tank,似乎不影响终局Tank
	DisallowThreatType = ZOMBIE_TANK
	//需要进行游戏难度检测，这是控制零散CI的在SU的什么强度生成
	
}

// temporarily leaving stage strings as diagnostic for gauntlet mode
DirectorOptions.finaleStageList.insert( FINALE_GAUNTLET_1, "FINALE_GAUNTLET_1" );
DirectorOptions.finaleStageList.insert( FINALE_HORDE_ATTACK_1, "Event.FinaleStart" );
DirectorOptions.finaleStageList.insert( FINALE_HALFTIME_BOSS, "Event.TankMidpoint" );
DirectorOptions.finaleStageList.insert( FINALE_GAUNTLET_2, "FINALE_GAUNTLET_2" );
DirectorOptions.finaleStageList.insert( FINALE_HORDE_ATTACK_2, "Event.FinaleWave4" );
DirectorOptions.finaleStageList.insert( FINALE_FINAL_BOSS, "Event.TankBrothers" );
DirectorOptions.finaleStageList.insert( FINALE_HORDE_ESCAPE, "" );
DirectorOptions.finaleStageList.insert( FINALE_CUSTOM_PANIC, "FINALE_CUSTOM_PANIC" );
DirectorOptions.finaleStageList.insert( FINALE_CUSTOM_TANK, "Event.TankMidpoint" );
DirectorOptions.finaleStageList.insert( FINALE_CUSTOM_SCRIPTED, "FINALE_CUSTOM_SCRIPTED" );
DirectorOptions.finaleStageList.insert( FINALE_CUSTOM_DELAY, "FINALE_CUSTOM_DELAY" );
DirectorOptions.finaleStageList.insert( FINALE_CUSTOM_CLEAROUT, "FINALE_CUSTOM_DELAY" );
DirectorOptions.finaleStageList.insert( FINALE_GAUNTLET_START, "Event.FinaleStart" );
DirectorOptions.finaleStageList.insert( FINALE_GAUNTLET_HORDE, "FINALE_GAUNTLET_HORDE" );
DirectorOptions.finaleStageList.insert( FINALE_GAUNTLET_HORDE_BONUSTIME, "FINALE_GAUNTLET_HORDE_BONUSTIME" );
DirectorOptions.finaleStageList.insert( FINALE_GAUNTLET_BOSS_INCOMING, "Event.TankMidpoint" );
DirectorOptions.finaleStageList.insert( FINALE_GAUNTLET_BOSS, "FINALE_GAUNTLET_BOSS" );
DirectorOptions.finaleStageList.insert( FINALE_GAUNTLET_ESCAPE, "" );
	

function GetDirectorOptions()
{
	local result;
	if ( "DirectorOptions" in DirectorScript )
	{
		result = DirectorScript.DirectorOptions;
	}
	
	if ( DirectorScript.MapScript.rawin( "DirectorOptions") )
	{
		if ( result != null )
		{
				DirectorScript.MapScript.DirectorOptions.setdelegate( result );
		}
		result = DirectorScript.MapScript.DirectorOptions;
	}

	if ( DirectorScript.MapScript.LocalScript.rawin( "DirectorOptions") )
	{
		if ( result != null )
		{
			DirectorScript.MapScript.LocalScript.DirectorOptions.setdelegate( result );
		}
		result = DirectorScript.MapScript.LocalScript.DirectorOptions;
	}

	if ( DirectorScript.MapScript.ChallengeScript.rawin( "DirectorOptions" ) )
	{
		if ( result != null )
		{
			DirectorScript.MapScript.ChallengeScript.DirectorOptions.setdelegate( result );
		}
		result = DirectorScript.MapScript.ChallengeScript.DirectorOptions;
	}
	
	return result;
}

