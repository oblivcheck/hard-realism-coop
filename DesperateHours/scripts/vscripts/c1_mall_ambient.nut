Msg("Initiating Desperate Hours[HRC] Updated Ambient Mall\n");

DirectorOptions <-
{
	AlwaysAllowWanderers = true
	MobSpawnMinTime = 90
	MobSpawnMaxTime = 120
	MobMinSize = 30
	MobMaxSize = 50
	MobMaxPending = 30
	SustainPeakMinTime = 3
	SustainPeakMaxTime = 5
	IntensityRelaxThreshold = 0.99
	RelaxMinInterval = 15
	RelaxMaxInterval = 20
	RelaxMaxFlowTravel = 1200
	SmokerLimit = 1
	HunterLimit = 2
	ChargerLimit = 1
	SpecialRespawnInterval = 60
	ZombieSpawnRange = 1200
	NumReservedWanderers = 30
}

Director.ResetMobTimer()