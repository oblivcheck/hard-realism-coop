Msg("Initiating Desperate Hours[HRC] Reserved Wanderers\n");

DirectorOptions <-
{
	// Turn always wanderer on
	AlwaysAllowWanderers = 1

	// Set the number of infected that cannot be absorbed
	NumReservedWanderers = 20

	// This turns off tanks and witches.
	ProhibitBosses = true

	SustainPeakMinTime = 3
	SustainPeakMaxTime = 5
	RelaxMinInterval = 15
	RelaxMaxInterval = 20
	RelaxMaxFlowTravel = 1200
	ZombieSpawnRange = 1000
	ZombieDiscardRange = 1500
	CommonLimit = 30
	WanderingZombieDensityModifier = 0.03
	MobMinSize = 20
	MobMaxSize = 30
	BileMobSize = 50
	MobSpawnMinTime = 120
	MobSpawnMaxTime = 240
	MegaMobSize = 80
	MusicDynamicMobSpawnSize = 30
	MusicDynamicMobStopSize = 12
	MusicDynamicMobScanStopSize = 5
}
