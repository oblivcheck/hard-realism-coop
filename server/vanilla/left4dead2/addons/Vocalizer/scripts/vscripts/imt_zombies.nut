//--------------------------------------------------------------------------------------------------
// ion's Vocalizer: Zombies Response Rules
//--------------------------------------------------------------------------------------------------

local Zombies =
[

// Shared

{
	name = "iMT_ZombieFakeTank",
	criteria =
	[
		[ "concept", "iMT_ZombieFakeTank" ], [ "team", "Infected" ]
	],
	responses =
	[
		{ soundname = "HulkZombie.Breathe" }
	],
	group_params = none
}

{
	name = "iMT_ZombieFakeWitch1",
	criteria =
	[
		[ "concept", "iMT_ZombieFakeWitch1" ], [ "team", "Infected" ]
	],
	responses =
	[
		{ soundname = "WitchZombie.Scream" }
	],
	group_params = none
}

{
	name = "iMT_ZombieFakeWitch2",
	criteria =
	[
		[ "concept", "iMT_ZombieFakeWitch2" ], [ "team", "Infected" ]
	],
	responses =
	[
		{ soundname = "WitchZombie.Despair" }
	],
	group_params = none
}

// Boomer

{
	name = "iMT_ZombieAlertBoomer",
	criteria =
	[
		[ "concept", "iMT_ZombieAlert" ], [ "who", "Boomer" ]
	],
	responses =
	[
		{ soundname = "BoomerZombie.Alert" }
	],
	group_params = none
}

{
	name = "iMT_ZombieDeathBoomer",
	criteria =
	[
		[ "concept", "iMT_ZombieDeath" ], [ "who", "Boomer" ]
	],
	responses =
	[
		{ soundname = "BoomerZombie.Detonate" }
	],
	group_params = none
}

{
	name = "iMT_ZombiePainBoomer",
	criteria =
	[
		[ "concept", "iMT_ZombiePain" ], [ "who", "Boomer" ]
	],
	responses =
	[
		{ soundname = "BoomerZombie.Pain" }
	],
	group_params = none
}

{
	name = "iMT_ZombieSpecialBoomer",
	criteria =
	[
		[ "concept", "iMT_ZombieSpecial" ], [ "who", "Boomer" ]
	],
	responses =
	[
		{ soundname = "BoomerZombie.Fall" }
	],
	group_params = none
}

{
	name = "iMT_ZombieWarnBoomer",
	criteria =
	[
		[ "concept", "iMT_ZombieWarn" ], [ "who", "Boomer" ]
	],
	responses =
	[
		{ soundname = "BoomerZombie.Warn" }
	],
	group_params = none
}

// Charger

{
	name = "iMT_ZombieAlertCharger",
	criteria =
	[
		[ "concept", "iMT_ZombieAlert" ], [ "who", "Charger" ]
	],
	responses =
	[
		{ soundname = "ChargerZombie.Alert" }
	],
	group_params = none
}

{
	name = "iMT_ZombieDeathCharger",
	criteria =
	[
		[ "concept", "iMT_ZombieDeath" ], [ "who", "Charger" ]
	],
	responses =
	[
		{ soundname = "ChargerZombie.Death" }
	],
	group_params = none
}

{
	name = "iMT_ZombiePainCharger",
	criteria =
	[
		[ "concept", "iMT_ZombiePain" ], [ "who", "Charger" ]
	],
	responses =
	[
		{ soundname = "ChargerZombie.Pain" }
	],
	group_params = none
}

{
	name = "iMT_ZombieSpecialCharger",
	criteria =
	[
		[ "concept", "iMT_ZombieSpecial" ], [ "who", "Charger" ]
	],
	responses =
	[
		{ soundname = "ChargerZombie.Melee" }
	],
	group_params = none
}

{
	name = "iMT_ZombieWarnCharger",
	criteria =
	[
		[ "concept", "iMT_ZombieWarn" ], [ "who", "Charger" ]
	],
	responses =
	[
		{ soundname = "ChargerZombie.Warn" }
	],
	group_params = none
}

// Hunter

{
	name = "iMT_ZombieAlertHunter",
	criteria =
	[
		[ "concept", "iMT_ZombieAlert" ], [ "who", "Hunter" ]
	],
	responses =
	[
		{ soundname = "HunterZombie.Alert" }
	],
	group_params = none
}

{
	name = "iMT_ZombieDeathHunter",
	criteria =
	[
		[ "concept", "iMT_ZombieDeath" ], [ "who", "Hunter" ]
	],
	responses =
	[
		{ soundname = "HunterZombie.Death" }
	],
	group_params = none
}

{
	name = "iMT_ZombiePainHunter",
	criteria =
	[
		[ "concept", "iMT_ZombiePain" ], [ "who", "Hunter" ]
	],
	responses =
	[
		{ soundname = "HunterZombie.Pain" }
	],
	group_params = none
}

{
	name = "iMT_ZombieSpecialHunter",
	criteria =
	[
		[ "concept", "iMT_ZombieSpecial" ], [ "who", "Hunter" ]
	],
	responses =
	[
		{ soundname = "HunterZombie.LungeLand" }
	],
	group_params = none
}

{
	name = "iMT_ZombieWarnHunter",
	criteria =
	[
		[ "concept", "iMT_ZombieWarn" ], [ "who", "Hunter" ]
	],
	responses =
	[
		{ soundname = "HunterZombie.Warn" }
	],
	group_params = none
}

// Jockey

{
	name = "iMT_ZombieAlertJockey",
	criteria =
	[
		[ "concept", "iMT_ZombieAlert" ], [ "who", "Jockey" ]
	],
	responses =
	[
		{ soundname = "JockeyZombie.Alert" }
	],
	group_params = none
}

{
	name = "iMT_ZombieDeathJockey",
	criteria =
	[
		[ "concept", "iMT_ZombieDeath" ], [ "who", "Jockey" ]
	],
	responses =
	[
		{ soundname = "JockeyZombie.Death" }
	],
	group_params = none
}

{
	name = "iMT_ZombiePainJockey",
	criteria =
	[
		[ "concept", "iMT_ZombiePain" ], [ "who", "Jockey" ]
	],
	responses =
	[
		{ soundname = "JockeyZombie.Pain" }
	],
	group_params = none
}

{
	name = "iMT_ZombieSpecialJockey",
	criteria =
	[
		[ "concept", "iMT_ZombieSpecial" ], [ "who", "Jockey" ]
	],
	responses =
	[
		{ soundname = "JockeyZombie.Pounce" }
	],
	group_params = none
}

{
	name = "iMT_ZombieWarnJockey",
	criteria =
	[
		[ "concept", "iMT_ZombieWarn" ], [ "who", "Jockey" ]
	],
	responses =
	[
		{ soundname = "JockeyZombie.Warn" }
	],
	group_params = none
}

// Smoker

{
	name = "iMT_ZombieAlertSmoker",
	criteria =
	[
		[ "concept", "iMT_ZombieAlert" ], [ "who", "Smoker" ]
	],
	responses =
	[
		{ soundname = "SmokerZombie.Alert" }
	],
	group_params = none
}

{
	name = "iMT_ZombieDeathSmoker",
	criteria =
	[
		[ "concept", "iMT_ZombieDeath" ], [ "who", "Smoker" ]
	],
	responses =
	[
		{ soundname = "SmokerZombie.Death" }
	],
	group_params = none
}

{
	name = "iMT_ZombiePainSmoker",
	criteria =
	[
		[ "concept", "iMT_ZombiePain" ], [ "who", "Smoker" ]
	],
	responses =
	[
		{ soundname = "SmokerZombie.Pain" }
	],
	group_params = none
}

{
	name = "iMT_ZombieSpecialSmoker",
	criteria =
	[
		[ "concept", "iMT_ZombieSpecial" ], [ "who", "Smoker" ]
	],
	responses =
	[
		{ soundname = "SmokerZombie.TongueStrain" }
	],
	group_params = none
}

{
	name = "iMT_ZombieWarnSmoker",
	criteria =
	[
		[ "concept", "iMT_ZombieWarn" ], [ "who", "Smoker" ]
	],
	responses =
	[
		{ soundname = "SmokerZombie.Warn" }
	],
	group_params = none
}

// Spitter

{
	name = "iMT_ZombieAlertSpitter",
	criteria =
	[
		[ "concept", "iMT_ZombieAlert" ], [ "who", "Spitter" ]
	],
	responses =
	[
		{ soundname = "SpitterZombie.Alert" }
	],
	group_params = none
}

{
	name = "iMT_ZombieDeathSpitter",
	criteria =
	[
		[ "concept", "iMT_ZombieDeath" ], [ "who", "Spitter" ]
	],
	responses =
	[
		{ soundname = "SpitterZombie.Death" }
	],
	group_params = none
}

{
	name = "iMT_ZombiePainSpitter",
	criteria =
	[
		[ "concept", "iMT_ZombiePain" ], [ "who", "Spitter" ]
	],
	responses =
	[
		{ soundname = "SpitterZombie.Pain" }
	],
	group_params = none
}

{
	name = "iMT_ZombieSpecialSpitter",
	criteria =
	[
		[ "concept", "iMT_ZombieSpecial" ], [ "who", "Spitter" ]
	],
	responses =
	[
		{ soundname = "SpitterZombie.Spit" }
	],
	group_params = none
}

{
	name = "iMT_ZombieWarnSpitter",
	criteria =
	[
		[ "concept", "iMT_ZombieWarn" ], [ "who", "Spitter" ]
	],
	responses =
	[
		{ soundname = "SpitterZombie.Recognize" }
	],
	group_params = none
}

// Tank

{
	name = "iMT_ZombieAlertTank",
	criteria =
	[
		[ "concept", "iMT_ZombieAlert" ], [ "who", "Tank" ]
	],
	responses =
	[
		{ soundname = "HulkZombie.Growl" }
	],
	group_params = none
}

{
	name = "iMT_ZombieDeathTank",
	criteria =
	[
		[ "concept", "iMT_ZombieDeath" ], [ "who", "Tank" ]
	],
	responses =
	[
		{ soundname = "HulkZombie.Die" }
	],
	group_params = none
}

{
	name = "iMT_ZombiePainTank",
	criteria =
	[
		[ "concept", "iMT_ZombiePain" ], [ "who", "Tank" ]
	],
	responses =
	[
		{ soundname = "HulkZombie.Pain" }
		{ soundname = "HulkZombie.PainFire" }
	],
	group_params = none
}

{
	name = "iMT_ZombieSpecialTank",
	criteria =
	[
		[ "concept", "iMT_ZombieSpecial" ], [ "who", "Tank" ]
	],
	responses =
	[
		{ soundname = "HulkZombie.Throw.Pickup" }
	],
	group_params = none
}

{
	name = "iMT_ZombieWarnTank",
	criteria =
	[
		[ "concept", "iMT_ZombieWarn" ], [ "who", "Tank" ]
	],
	responses =
	[
		{ soundname = "HulkZombie.Yell" }
	],
	group_params = none
}

]

rr_ProcessRules( Zombies )