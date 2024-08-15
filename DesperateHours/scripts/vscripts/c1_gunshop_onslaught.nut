Msg("Initiating Desperate Hours[HRC] Onslaught\n");

DirectorOptions <-
{
	// This turns off tanks and witches.
	ProhibitBosses = true

	PreferredMobDirection = SPAWN_BEHIND_SURVIVORS
	MobSpawnMinTime = 3
	MobSpawnMaxTime = 5
	MobMaxPending = 30
	MobMinSize = 30
	MobMaxSize = 50
	SustainPeakMinTime = 2
	SustainPeakMaxTime = 3
	IntensityRelaxThreshold = 0.99
	RelaxMinInterval = 5
	RelaxMaxInterval = 8
	RelaxMaxFlowTravel = 200

	SpecialRespawnInterval = 60
	MusicDynamicMobSpawnSize = 30
	MusicDynamicMobStopSize = 12
	MusicDynamicMobScanStopSize = 5
}

Director.ResetMobTimer()
Director.PlayMegaMobWarningSounds()
