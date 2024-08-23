Msg("Initiating Desperate Hours[HRC] Crescendo Cooldown\n");

DirectorOptions <-
{
	AlwaysAllowWanderers = true
	MobSpawnMinTime = 60
	MobSpawnMaxTime = 90
	MobMinSize = 30
	MobMaxSize = 50
	MobMaxPending = 30
	SustainPeakMinTime = 3
	SustainPeakMaxTime = 5
	IntensityRelaxThreshold = 0.99
	RelaxMinInterval = 15
	RelaxMaxInterval = 20
	RelaxMaxFlowTravel = 1500
	SmokerLimit = 2
	HunterLimit = 2
	ChargerLimit = 3
	SpecialRespawnInterval = 30
	ZombieSpawnRange = 1200
	NumReservedWanderers = 30
}

Director.ResetMobTimer()