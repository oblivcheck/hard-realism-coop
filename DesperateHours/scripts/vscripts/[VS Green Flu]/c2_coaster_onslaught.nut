Msg("[VS]Initiating Green Flu Onslaught\n");

DirectorOptions <-
{
	// This turns off tanks and witches.
	ProhibitBosses = true
	
	//LockTempo = true
	MobSpawnMinTime = 1
	MobSpawnMaxTime = 1
	MobMinSize = 5
	MobMaxSize = 8
	MobMaxPending = 30
	SustainPeakMinTime = 8
	SustainPeakMaxTime = 16
	IntensityRelaxThreshold = 0.99
	RelaxMinInterval = 5
	RelaxMaxInterval = 15
	RelaxMaxFlowTravel = 200
	BoomerLimit = 0
	SmokerLimit = 3
	HunterLimit = 2
	SpecialRespawnInterval = 5.0
	PreferredMobDirection = SPAWN_ABOVE_SURVIVORS
	ZombieSpawnRange = 1000
}

Director.PlayMegaMobWarningSounds()
Director.ResetMobTimer()
