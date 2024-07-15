//-----------------------------------------------------
Msg("Activating Desperate Hours\n");


DirectorOptions <-
{
	ActiveChallenge = 1

	cm_CommonLimit = 50
	cm_WanderingZombieDensityModifier = 0.05
	MobMinSize = 30
	MobMaxSize = 50
	BileMobSize = 50
	//MobSpawnSize = 50
	//MobSpawnMinTime = 120
	//MobSpawnMaxTime = 210
	MegaMobSize = 100	
	NumReservedWanderers = 15
	//AlwaysAllowWanderers = ture
	//cm_BaseCommonAttackDamage = 0.5
	//PreferredMobDirection = SPAWN_NEAR_POSITION
	//PreferredMobPositionRange = 800.0			//Only works if PreferredMobDirection is set to SPAWN_NEAR_POSITION.

	cm_SpecialRespawnInterval = 40
	cm_MaxSpecials = 4
	cm_DominatorLimit = 4
	HunterLimit = 2
	SmokerLimit = 1
	JockeyLimit = 1
	ChargerLimit = 1
	BoomerLimit = 1
	SpitterLimit = 1
	//cm_AggressiveSpecials = ture
	//PreferredSpecialDirection =  SPAWN_SPECIALS_ANYWHERE

	cm_ProhibitBosses = false
	ZombieTankHealth = 6000
	ShouldAllowMobsWithTank = true
	ShouldAllowSpecialsWithTank = true
	AllowWitchesInCheckpoints = true

	BuildUpMinInterval = 20
	SustainPeakMinTime = 2
	SustainPeakMaxTime = 3
	RelaxMinInterval = 20
	RelaxMaxInterval = 30
	IntensityRelaxThreshold = 0.99
	RelaxMaxFlowTravel	float = 1500
	TempHealthDecayRate = 0.20
	//SurvivorMaxIncapacitatedCount = 1
	//cm_AllowPillConversion = false
}

MutationOptions <-
{
	weaponsToRemove =
	{
	//	weapon_pistol_magnum = 0
	//	weapon_vomitjar = 0
	}

	function AllowWeaponSpawn( classname )
	{
		if ( classname in weaponsToRemove )
		{
			return false;
		}
		return true;
	}

	weaponsToConvert =
	{
	//	weapon_defibrillator = "weapon_pain_pills_spawn"
	//	weapon_pistol_magnum = "weapon_pistol_spawn"
	//	weapon_vomitjar = "weapon_pipe_bomb_spawn"
	}

	function ConvertWeaponSpawn( classname )
	{
		if ( classname in weaponsToConvert )
		{
			return weaponsToConvert[classname];
		}
		return 0;
	}

	DefaultItems =
	[
		"weapon_pistol_magnum",
	]

	function GetDefaultItem( idx )
	{
		if ( idx < DefaultItems.len() )
		{
			return DefaultItems[idx];
		}
		return 0;
	}
}
