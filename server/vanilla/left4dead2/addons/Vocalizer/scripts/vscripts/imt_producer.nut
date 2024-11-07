//--------------------------------------------------------------------------------------------------
// ion's Vocalizer: Producer Response Rules
//--------------------------------------------------------------------------------------------------

// Shared responses

local PlayerHeardSpecialC1Producer =
[
	{ scenename = "scenes/Producer/HeardSpecialC101.vcd" }  //That doesn't sound right.
	{ scenename = "scenes/Producer/HeardSpecialC102.vcd" }  //Okay, that doesn't sound right.
	{ scenename = "scenes/Producer/HeardSpecialC103.vcd" }  //I don't like the sound of that.
	{ scenename = "scenes/Producer/HeardSpecialC104.vcd" }  //Oh what the hell is that!?
	{ scenename = "scenes/Producer/HeardSpecialC105.vcd", speakonce = true, followup = RThen( "Mechanic", "Player.C1WorseThanZombies", { from = "Producer" }, 0.3 ) }  //There were reports of stuff worse than zombies.
	{ scenename = "scenes/Producer/HeardSpecialC106.vcd" }  //You hear that? Some of these things mutated.
]

local PlayerNiceShotProducer =
[
	{ scenename = "scenes/Producer/NiceShot01.vcd" }  //Nice shot.
	{ scenename = "scenes/Producer/NiceShot02.vcd" }  //Cool.
	{ scenename = "scenes/Producer/NiceShot03.vcd" }  //Great shot!
	{ scenename = "scenes/Producer/NiceShot04.vcd" }  //Nice shot!
	{ scenename = "scenes/Producer/NiceShot05.vcd" }  //Good one!
]

local PlayerPouncedProducer =
[
	{ scenename = "scenes/Producer/HunterPouncedC101.vcd" }  //Hunter's on him!
	{ scenename = "scenes/Producer/HunterPouncedC102.vcd" }  //Get the Hunter off him!
	{ scenename = "scenes/Producer/HunterPouncedC103.vcd" }  //Hunter's got him!
	{ scenename = "scenes/Producer/HunterPouncedC104.vcd" }  //Get that Hunter off him!
	{ scenename = "scenes/Producer/HunterPouncedC105.vcd" }  //Hunter's on him!
]

local PlayerPouncedC1Producer =
[
	{ scenename = "scenes/Producer/HunterPouncedC106.vcd" }  //That thing's on him!
	{ scenename = "scenes/Producer/HunterPouncedC107.vcd" }  //Get that thing off him!
	{ scenename = "scenes/Producer/HunterPouncedC108.vcd" }  //That thing has got him!
]

local PlayerSuggestHealthProducer =
[
	{ scenename = "scenes/Producer/SuggestHealth01.vcd" }  //You should heal up.
	{ scenename = "scenes/Producer/SuggestHealth02.vcd" }  //You should heal up.
	{ scenename = "scenes/Producer/SuggestHealth03.vcd" }  //You should heal up.
	{ scenename = "scenes/Producer/SuggestHealth04.vcd" }  //Heal up!
	{ scenename = "scenes/Producer/SuggestHealth05.vcd" }  //We should heal.
	{ scenename = "scenes/Producer/SuggestHealth06.vcd" }  //Heal if you need to!
	{ scenename = "scenes/Producer/SuggestHealth07.vcd" }  //Heal up!
	{ scenename = "scenes/Producer/SuggestHealth08.vcd" }  //We should heal.
	{ scenename = "scenes/Producer/SuggestHealth09.vcd" }  //Heal if you need to!
]

local PlayerThanksProducer =
[
	{ scenename = "scenes/Producer/Thanks01.vcd" }  //Thanks for that.
	{ scenename = "scenes/Producer/Thanks02.vcd" }  //Hey, thanks!
	{ scenename = "scenes/Producer/Thanks03.vcd" }  //Thanks!
	{ scenename = "scenes/Producer/Thanks04.vcd" }  //Thanks I owe you one.
	{ scenename = "scenes/Producer/Thanks05.vcd" }  //Thanks.
]

local SurvivorCoughingProducer =
[
	{ scenename = "scenes/Producer/Cough01.vcd" }  //[Coughing from smoke]
	{ scenename = "scenes/Producer/Cough02.vcd" }  //[Coughing from smoke]
	{ scenename = "scenes/Producer/Cough03.vcd" }  //[Coughing from smoke]
	{ scenename = "scenes/Producer/Cough04.vcd" }  //[Coughing from smoke]
	{ scenename = "scenes/Producer/Cough05.vcd" }  //[Coughing from smoke]
	{ scenename = "scenes/Producer/Cough06.vcd" }  //[Coughing from smoke]
	{ scenename = "scenes/Producer/Cough07.vcd" }  //[Coughing from smoke]
]

local SurvivorMournCoachProducer =
[
	{ scenename = "scenes/Producer/SurvivorMournCoach01.vcd" }  //Gonna miss you Coach.
	{ scenename = "scenes/Producer/SurvivorMournCoach02.vcd" }  //Do you think Coach was his first or last name?
	{ scenename = "scenes/Producer/SurvivorMournCoach03.vcd" }  //Goodbye coach?
	{ scenename = "scenes/Producer/SurvivorMournCoach04.vcd" }  //Damn, didn't even get to know you coach.
]

local SurvivorMournCoachC1Producer =
[
	{ scenename = "scenes/Producer/SurvivorMournCoach04.vcd" }  //Damn, didn't even get to know you coach.
]

local SurvivorMournGamblerProducer =
[
	{ scenename = "scenes/Producer/SurvivorMournGamblerC101.vcd" }  //Not much to say my friend, goodbye.
	{ scenename = "scenes/Producer/SurvivorMournNick01.vcd" }  //Ahh Nick, at least you are dressed for a funeral.
	{ scenename = "scenes/Producer/SurvivorMournNick02.vcd" }  //Goodbye Nick, going to miss you.
]

local SurvivorMournGamblerC1Producer =
[
	{ scenename = "scenes/Producer/SurvivorMournGamblerC101.vcd" }  //Not much to say my friend, goodbye.
]

local SurvivorMournMechanicProducer =
[
	{ scenename = "scenes/Producer/SurvivorMournEllis01.vcd" }  //Ellis, what did you go and do?
	{ scenename = "scenes/Producer/SurvivorMournEllis02.vcd" }  //Oh Ellis, Ellis, Ellis...
	{ scenename = "scenes/Producer/SurvivorMournEllis03.vcd" }  //Oh Ellis, I am going to miss you.
	{ scenename = "scenes/Producer/SurvivorMournMechanicC101.vcd" }  //Gonna miss our little mechanic.
]

local SurvivorMournMechanicC1Producer =
[
	{ scenename = "scenes/Producer/SurvivorMournMechanicC101.vcd" }  //Gonna miss our little mechanic.
]

local SurvivorReloadingQuietProducer =
[
	{ scenename = "scenes/Producer/ReloadingQuiet01.vcd" }  //Reloading.
	{ scenename = "scenes/Producer/ReloadingQuiet02.vcd" }  //Reloading.
	{ scenename = "scenes/Producer/ReloadingQuiet03.vcd" }  //Wait, reloading.
	{ scenename = "scenes/Producer/ReloadingQuiet04.vcd" }  //I'm reloading.
	{ scenename = "scenes/Producer/ReloadingQuiet05.vcd" }  //Reloading.
]

local SurvivorSpottedBoomerC1Producer =
[
	{ scenename = "scenes/Producer/WarnBoomerC101.vcd" }  //OH SHIT, FAT GUY!
	{ scenename = "scenes/Producer/WarnBoomerC102.vcd" }  //BIG GUY!
	{ scenename = "scenes/Producer/WarnBoomerC103.vcd" }  //FAT GUY!
	{ scenename = "scenes/Producer/WarnBoomerC104.vcd" }  //BIG GUY!
	{ scenename = "scenes/Producer/WarnBoomerC105.vcd" }  //OH, THERE'S A FAT GUY!
	{ scenename = "scenes/Producer/WarnBoomerC106.vcd" }  //BARF BAG!
	{ scenename = "scenes/Producer/WarnBoomerC107.vcd" }  //BARF BAG!
]

local SurvivorSpottedChargerC1Producer =
[
	{ scenename = "scenes/Producer/WarnChargerC101.vcd" }  //ONE OF THOSE CHARGING THINGS!
	{ scenename = "scenes/Producer/WarnChargerC102.vcd" }  //ONE OF THOSE CHARGING THINGS!
	{ scenename = "scenes/Producer/WarnChargerC103.vcd" }  //ONE OF THOSE CHARGING THINGS!
]

local SurvivorSpottedHunterC1Producer =
[
	{ scenename = "scenes/Producer/WarnHunterC101.vcd" }  //ONE OF THOSE POUNCING THINGS!
	{ scenename = "scenes/Producer/WarnHunterC102.vcd" }  //HOODIE!
	{ scenename = "scenes/Producer/WarnHunterC103.vcd" }  //HOODIE BASTARD!
	{ scenename = "scenes/Producer/WarnHunterC104.vcd" }  //JUMPER!
	{ scenename = "scenes/Producer/WarnHunterC105.vcd" }  //LEAPER!
]

local SurvivorSpottedJockeyC1Producer =
[
	{ scenename = "scenes/Producer/WarnJockey02.vcd" }  //RIDER!
	{ scenename = "scenes/Producer/WarnJockey04.vcd" }  //RIDER!
]

local SurvivorSpottedSmokerC1Producer =
[
	{ scenename = "scenes/Producer/WarnSmokerC101.vcd" }  //TONGUE GUY!
	{ scenename = "scenes/Producer/WarnSmokerC102.vcd" }  //TONGUE!
	{ scenename = "scenes/Producer/WarnSmokerC103.vcd" }  //ONE OF THOSE SMOKING GUYS!
	{ scenename = "scenes/Producer/WarnSmokerC104.vcd" }  //ONE OF THOSE SMOKING GUYS!
	{ scenename = "scenes/Producer/WarnSmokerC105.vcd" }  //TONGUE GUY!
	{ scenename = "scenes/Producer/WarnSmokerC106.vcd" }  //TONGUE!
]

local SurvivorSpottedSpitterC1Producer =
[
	{ scenename = "scenes/Producer/WarnSpitterC101.vcd" }  //GREEN GUY!
	{ scenename = "scenes/Producer/WarnSpitterC102.vcd" }  //CRAZY NECK!
	{ scenename = "scenes/Producer/WarnSpitterC103.vcd" }  //GREEN GUY!
]

local SurvivorVocalizeBackUpQuietProducer =
[
	{ scenename = "scenes/Producer/BackUpQuiet01.vcd" }  //Back up.
	{ scenename = "scenes/Producer/BackUpQuiet02.vcd" }  //Move back.
	{ scenename = "scenes/Producer/BackUpQuiet03.vcd" }  //Get back.
	{ scenename = "scenes/Producer/BackUpQuiet04.vcd" }  //Get back, get back.
]

local SurvivorVocalizeEmphaticGoQuietProducer =
[
	{ scenename = "scenes/Producer/EmphaticGoQuiet01.vcd" }  //No time to stop, go.
	{ scenename = "scenes/Producer/EmphaticGoQuiet02.vcd" }  //Keep moving.
	{ scenename = "scenes/Producer/EmphaticGoQuiet03.vcd" }  //Keep going.
]

//--------------------------------------------------------------------------------------------------
// Ellis Stories
//--------------------------------------------------------------------------------------------------

local Producer =
[

{
	name = "iMT_EllisStoryInterruptProducer",
	criteria =
	[
		[ "concept", "iMT_EllisStoryInterrupt" ], [ "who", "Producer" ], [ "world_auto_tellingstory", 1 ], [ "coughing", 0 ], [ "incapacitated", 0 ], [ "speaking", 0], [ IsTalk ], [ IsTalkProducer ], [ IsWorldTalkProducer ], [ IssuerCloseEnough ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/EllisInterrupt05.vcd", followup = RThen( "Mechanic", "iMT_EllisStoryReac", { from = "Producer" }, 0.3 ) }  //Ellis? Ellis? Ellis, sweetie? ELLIS!
		{ scenename = "scenes/Producer/EllisInterrupt06.vcd", followup = RThen( "Mechanic", "iMT_EllisStoryReac", { from = "Producer" }, 0.3 ) }  //Ellis, sweetie, can this wait?
		{ scenename = "scenes/Producer/EllisInterrupt07.vcd", followup = RThen( "Mechanic", "iMT_EllisStoryReac", { from = "Producer" }, 0.3 ) }  //Okay, Ellis, this is really not the best time.
		{ scenename = "scenes/Producer/EllisInterrupt15.vcd", followup = RThen( "Mechanic", "iMT_EllisStoryReac", { from = "Producer" }, 0.3 ) }  //Sweety, I normally like your stories, I do. But not now, okay?
	],
	group_params = none
}

{
	name = "iMT_EllisStoryInterrupt%Producer",
	criteria =
	[
		[ "concept", "iMT_EllisStoryInterrupt" ], [ "who", "Producer" ], [ "world_auto_tellingstory", 1 ], [ "coughing", 0 ], [ "incapacitated", 0 ], [ "speaking", 0], [ "randomnum", 0, 10 ], [ IsTalk ], [ IsTalkProducer ], [ IsWorldTalkProducer ], [ IssuerCloseEnough ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/EllisInterrupt14.vcd" }  //You should tell that story to Nick.
	],
	group_params = none
}

{
	name = "iMT_EllisStoryInterruptC1Producer",
	criteria =
	[
		[ "concept", "iMT_EllisStoryInterrupt" ], [ "who", "Producer" ], [ "world_auto_tellingstory", 1 ], [ "coughing", 0 ], [ "incapacitated", 0 ], [ "speaking", 0], [ "map", "c1m1_hotel" ], [ IsTalk ], [ IsTalkProducer ], [ IsWorldTalkProducer ], [ IssuerCloseEnough ], [ NoKnowNames ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/EllisInterrupt15.vcd", followup = RThen( "Mechanic", "iMT_EllisStoryReac", { from = "Producer" }, 0.3 ) }  //Sweety, I normally like your stories, I do. But not now, okay?
	],
	group_params = none
}

{
	name = "iMT_EllisStoryInterruptC1M2Producer",
	criteria =
	[
		[ "concept", "iMT_EllisStoryInterrupt" ], [ "who", "Producer" ], [ "world_auto_tellingstory", 1 ], [ "worldellisstoryspecific", 1 ], [ "coughing", 0 ], [ "incapacitated", 0 ], [ "speaking", 0], [ "map", "c1m2_streets" ], [ IsTalk ], [ IsTalkProducer ], [ IsWorldTalkProducer ], [ IssuerCloseEnough ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/EllisInterrupt01.vcd" }  //Uh huh.
		{ scenename = "scenes/Producer/EllisInterrupt02.vcd" }  //Uh huh.
		{ scenename = "scenes/Producer/EllisInterrupt03.vcd" }  //Uh huh.
		{ scenename = "scenes/Producer/EllisInterrupt04.vcd" }  //Uh huh.
	],
	group_params = none
}

{
	name = "iMT_EllisStoryInterruptC3M2Producer",
	criteria =
	[
		[ "concept", "iMT_EllisStoryInterrupt" ], [ "who", "Producer" ], [ "world_auto_tellingstory", 1 ], [ "worldellisstoryspecific", 1 ], [ "coughing", 0 ], [ "incapacitated", 0 ], [ "speaking", 0], [ "map", "c3m2_swamp" ], [ IsTalk ], [ IsTalkProducer ], [ IsWorldTalkProducer ], [ IssuerCloseEnough ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/EllisInterrupt11.vcd", followup = RThen( "Mechanic", "PlayerYes", null, 0.3 ) }  //Ninety percent?
		{ scenename = "scenes/Producer/EllisInterrupt12.vcd", followup = RThen( "Mechanic", "PlayerYes", null, 0.3 ) }  //His whole body?
	],
	group_params = none
}

{
	name = "iMT_EllisStoryInterruptC6M3Producer",
	criteria =
	[
		[ "concept", "iMT_EllisStoryInterrupt" ], [ "who", "Producer" ], [ "world_auto_tellingstory", 1 ], [ "worldellisstoryspecific", 1 ], [ "coughing", 0 ], [ "incapacitated", 0 ], [ "speaking", 0], [ "map", "c6m3_port" ], [ IsTalk ], [ IsTalkProducer ], [ IsWorldTalkProducer ], [ IssuerCloseEnough ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/DLC1_C6M3_FinaleChat32.vcd" }  //Ellis, quit bothering these poor people. I'm so sorry.
	],
	group_params = none
}

{
	name = "iMT_EllisStoryStopProducer",
	criteria =
	[
		[ "concept", "iMT_EllisStories" ], [ "who", "Producer" ], [ "world_auto_tellingstory", 1 ]
	],
	responses =
	[
		{
			scenename = "scenes/Producer/EllisInterrupt05.vcd", followup = RThen( "all", "iMT_EllisStoryStop", null, 0.3 ),  //Ellis? Ellis? Ellis, sweetie? ELLIS!
			applycontext =
			{
				c1 = { context = "_auto_tellingstory", value = 0, duration = 0 }
				c2 = { context = "_auto_didinterrupt", value = 1, duration = 0 }
			},
			applycontexttoworld = true
		}

		{
			scenename = "scenes/Producer/EllisInterrupt06.vcd", followup = RThen( "all", "iMT_EllisStoryStop", null, 0.3 ),  //Ellis, sweetie, can this wait?
			applycontext =
			{
				c1 = { context = "_auto_tellingstory", value = 0, duration = 0 }
				c2 = { context = "_auto_didinterrupt", value = 1, duration = 0 }
			},
			applycontexttoworld = true
		}
	],
	group_params = none
}

{
	name = "iMT_EllisStoryStopC1Producer",
	criteria =
	[
		[ "concept", "iMT_EllisStories" ], [ "who", "Producer" ], [ "world_auto_tellingstory", 1 ], [ "map", "c1m1_hotel" ], [ NoKnowNames ]
	],
	responses =
	[
		{
			scenename = "scenes/Producer/EllisInterrupt15.vcd", followup = RThen( "all", "iMT_EllisStoryStop", null, 0.3 ),  //Sweety, I normally like your stories, I do. But not now, okay?
			applycontext =
			{
				c1 = { context = "_auto_tellingstory", value = 0, duration = 0 }
				c2 = { context = "_auto_didinterrupt", value = 1, duration = 0 }
			},
			applycontexttoworld = true
		}
	],
	group_params = none
}

//--------------------------------------------------------------------------------------------------
// Miscellaneous
//--------------------------------------------------------------------------------------------------

{
	name = "iMT_PlayerAnswerReadyProducer",
	criteria =
	[
		[ "concept", "iMT_PlayerAnswerReady" ], [ "who", "Producer" ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/TakeMelee03.vcd" }  //Oh yeah, gonna wack some heads.
		{ scenename = "scenes/Producer/TakeMelee06.vcd" }  //Oh yeah, gonna wack some heads.
		{ scenename = "scenes/Producer/TakeMelee07.vcd" }  //This is what I'm talking about.
	],
	group_params = none
}

{
	name = "iMT_PlayerBattleCryProducer",
	criteria =
	[
		[ "concept", "iMT_PlayerBattleCry" ], [ "who", "Producer" ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/BattleCry01.vcd" }  //[Yell while firing a gun for an extended period of time]
		{ scenename = "scenes/Producer/BattleCry02.vcd" }  //[Yell while firing a gun for an extended period of time]
	],
	group_params = none
}

{
	name = "iMT_PlayerBreathingProducer",
	criteria =
	[
		[ "concept", "iMT_PlayerBreathing" ], [ "who", "Producer" ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/Defibrillator18.vcd" }  //[gasp for breath]
	],
	group_params = none
}

{
	name = "iMT_PlayerCloseTheDoorProducer",
	criteria =
	[
		[ "concept", "iMT_PlayerCloseTheDoor" ], [ "who", "Producer" ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/CloseTheDoor01.vcd" }  //Close the door.
		{ scenename = "scenes/Producer/CloseTheDoor02.vcd" }  //Can we close that door?
		{ scenename = "scenes/Producer/CloseTheDoor04.vcd" }  //Let's close that door.
		{ scenename = "scenes/Producer/CloseTheDoor05.vcd" }  //Someone want to close that door?
		{ scenename = "scenes/Producer/WorldGenericProducer43.vcd" }  //Just close the door.
		{ scenename = "scenes/Producer/WorldGenericProducer90.vcd" }  //I think we should keep that door closed.
		{ scenename = "scenes/Producer/WorldGenericProducer91.vcd" }  //Hey I think we should close that door.
	],
	group_params = none
}

{
	name = "iMT_PlayerCloseTheDoor%Producer",
	criteria =
	[
		[ "concept", "iMT_PlayerCloseTheDoor" ], [ "who", "Producer" ], [ "randomnum", 0, 5 ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/CloseTheDoor03.vcd" }  //Close that door, were you born in a... Oh yeah, you were. Sorry, my bad.
	],
	group_params = none
}

{
	name = "iMT_PlayerCloseTheDoorC1Producer",
	criteria =
	[
		[ "concept", "iMT_PlayerCloseTheDoor" ], [ "who", "Producer" ], [ "map", "c1m1_hotel" ], [ AddWeight ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/CloseTheDoorC101.vcd" }  //Okay, well close the door now!
		{ scenename = "scenes/Producer/CloseTheDoorC102.vcd" }  //Well close the door now!
		{ scenename = "scenes/Producer/CloseTheDoorC103.vcd" }  //We should close that door.
		{ scenename = "scenes/Producer/CloseTheDoorC104.vcd" }  //We oughta close that door.
	],
	group_params = none
}

{
	name = "iMT_PlayerCoughingProducer",
	criteria =
	[
		[ "concept", "iMT_PlayerCoughing" ], [ "who", "Producer" ]
	],
	responses = SurvivorCoughingProducer,
	group_params = none
}

{
	name = "iMT_PlayerDeathScreamProducer",
	criteria =
	[
		[ "concept", "iMT_PlayerDeathScream" ], [ "who", "Producer" ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/LedgeHangFall01.vcd" }  //HEEEEEEEELLLLLPPPPP!!!!!
		{ scenename = "scenes/Producer/LedgeHangFall02.vcd" }  //NOOOOOOOOOOOOOOOO!!!!
	],
	group_params = none
}

{
	name = "iMT_PlayerFriendlyFireProducer",
	criteria =
	[
		[ "concept", "iMT_PlayerFriendlyFire" ], [ "who", "Producer" ], [ "tankactive", 0 ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/FriendlyFire01.vcd" }  //That better have been an accident!
		{ scenename = "scenes/Producer/FriendlyFire02.vcd" }  //Try shooting some damn zombies!
		{ scenename = "scenes/Producer/FriendlyFire03.vcd" }  //Okay, you have some serious issues with that gun!
		{ scenename = "scenes/Producer/FriendlyFire04.vcd" }  //Have you lost your mind?
		{ scenename = "scenes/Producer/FriendlyFire05.vcd" }  //Oh no you didn't just shoot me!
		{ scenename = "scenes/Producer/FriendlyFire06.vcd" }  //Hey!
		{ scenename = "scenes/Producer/FriendlyFire07.vcd" }  //Stop shooting me!
		{ scenename = "scenes/Producer/FriendlyFire08.vcd" }  //What the hell are you doing?
		{ scenename = "scenes/Producer/FriendlyFire09.vcd" }  //Ow! HEY!
		{ scenename = "scenes/Producer/FriendlyFire10.vcd" }  //What is up with you shooting me?
		{ scenename = "scenes/Producer/FriendlyFire11.vcd" }  //Watch it!
		{ scenename = "scenes/Producer/FriendlyFire12.vcd" }  //Hey, hey, hey, hey, seriously?
		{ scenename = "scenes/Producer/FriendlyFire13.vcd" }  //Watch where you're shooting!
		{ scenename = "scenes/Producer/FriendlyFire14.vcd" }  //STOP IT!
		{ scenename = "scenes/Producer/FriendlyFire15.vcd" }  //Oh sweet Jesus, you shot me!
		{ scenename = "scenes/Producer/FriendlyFire16.vcd" }  //Somebody shot me!
		{ scenename = "scenes/Producer/FriendlyFire17.vcd" }  //Did you shoot me?
		{ scenename = "scenes/Producer/FriendlyFire18.vcd" }  //Who in the hell just shot me?
		{ scenename = "scenes/Producer/FriendlyFire19.vcd" }  //Stop shooing me!
		{ scenename = "scenes/Producer/FriendlyFire20.vcd" }  //DO NOT SHOOT ME!
		{ scenename = "scenes/Producer/FriendlyFire21.vcd" }  //STOP SHOOTING ME!
		{ scenename = "scenes/Producer/FriendlyFire22.vcd" }  //Who in the hell shot me?
		{ scenename = "scenes/Producer/FriendlyFire23.vcd" }  //We cannot be shooting each other!
		{ scenename = "scenes/Producer/FriendlyFire24.vcd" }  //Don't make me get ugly with you!
		{ scenename = "scenes/Producer/FriendlyFire25.vcd" }  //Who do you think you are shootin' me?
		{ scenename = "scenes/Producer/FriendlyFire26.vcd" }  //Okay, I can not believe that you just shot me?
	],
	group_params = none
}

{
	name = "iMT_PlayerFriendlyFireC1Producer",
	criteria =
	[
		[ "concept", "iMT_PlayerFriendlyFire" ], [ "who", "Producer" ], [ "tankactive", 0 ], [ "map", "c1m1_hotel" ], [ NoKnowNames ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/FriendlyFire02.vcd" }  //Try shooting some damn zombies!
		{ scenename = "scenes/Producer/FriendlyFire03.vcd" }  //Okay, you have some serious issues with that gun!
		{ scenename = "scenes/Producer/FriendlyFire08.vcd" }  //What the hell are you doing?
		{ scenename = "scenes/Producer/FriendlyFire23.vcd" }  //We cannot be shooting each other!
		{ scenename = "scenes/Producer/FriendlyFireC101.vcd" }  //Hey! What's your name. Don't shoot me!
		{ scenename = "scenes/Producer/FriendlyFireC102.vcd" }  //Dude, don't shoot me!
	],
	group_params = none
}

{
	name = "iMT_PlayerFriendlyFireFromGamblerC1Producer",
	criteria =
	[
		[ "concept", "iMT_PlayerFriendlyFire" ], [ "who", "Producer" ], [ "tankactive", 0 ], [ "subject", "Gambler" ], [ "dist_from_subject", 0, 799 ], [ "map", "c1m1_hotel" ], [ NoKnowNames ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/FriendlyFireC1Nick01.vcd" }  //Hey - in the suit, STOP SHOOTING ME!
	],
	group_params = none
}

{
	name = "iMT_PlayerFriendlyFireTankProducer",
	criteria =
	[
		[ "concept", "iMT_PlayerFriendlyFire" ], [ "who", "Producer" ], [ "tankactive", 1 ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/FriendlyFireTank01.vcd" }  //Whoa, whoa! Shoot the Tank!
		{ scenename = "scenes/Producer/FriendlyFireTank05.vcd" }  //Shoot the Tank!
		{ scenename = "scenes/Producer/FriendlyFireTank06.vcd" }  //Shoot the TANK, please.
		{ scenename = "scenes/Producer/FriendlyFireTank07.vcd" }  //Ugh, shoot the Tank, not me!
		{ scenename = "scenes/Producer/FriendlyFireTank08.vcd" }  //Can you shoot the Tank instead of me?
	],
	group_params = none
}

{
	name = "iMT_PlayerFriendlyFireTankC1Producer",
	criteria =
	[
		[ "concept", "iMT_PlayerFriendlyFire" ], [ "who", "Producer" ], [ "tankactive", 1 ], [ C1M1orC1M2 ], [ IsNotSurvival ], [ NoKnowTank ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/ReactionNegative18.vcd" }  //Goddamnit!
		{ scenename = "scenes/Producer/ReactionNegative20.vcd" }  //Argghh! (disgusted)
	],
	group_params = none
}

{
	name = "iMT_PlayerFriendlyFireTankCoachProducer",
	criteria =
	[
		[ "concept", "iMT_PlayerFriendlyFire" ], [ "who", "Producer" ], [ "tankactive", 1 ], [ "subject", "Coach" ], [ "dist_from_subject", 0, 799 ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/FriendlyFireTank03.vcd" }  //Shoot the TANK, Coach!
	],
	group_params = none
}

{
	name = "iMT_PlayerFriendlyFireTankGamblerProducer",
	criteria =
	[
		[ "concept", "iMT_PlayerFriendlyFire" ], [ "who", "Producer" ], [ "tankactive", 1 ], [ "subject", "Gambler" ], [ "dist_from_subject", 0, 799 ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/FriendlyFireTank04.vcd" }  //Ah, shoot the TANK, Nick!
	],
	group_params = none
}

{
	name = "iMT_PlayerFriendlyFireTankMechanicProducer",
	criteria =
	[
		[ "concept", "iMT_PlayerFriendlyFire" ], [ "who", "Producer" ], [ "tankactive", 1 ], [ "subject", "Mechanic" ], [ "dist_from_subject", 0, 799 ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/FriendlyFireTank02.vcd" }  //Ellis! Shoot the Tank!
	],
	group_params = none
}

{
	name = "iMT_PlayerGetToVehicleBoatProducer",
	criteria =
	[
		[ "concept", "iMT_PlayerGetToVehicleBoat" ], [ "who", "Producer" ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/WorldC3M423.vcd" }  //Run to the boat!
		{ scenename = "scenes/Producer/WorldC3M424.vcd" }  //To the boat! To the boat!
		{ scenename = "scenes/Producer/WorldC3M425.vcd" }  //Get your asses on the boat!
		{ scenename = "scenes/Producer/WorldC3M426.vcd" }  //Get to the boat!
		{ scenename = "scenes/Producer/WorldC4M4B22.vcd" }  //LET'S GET TO THE BOAT!
		{ scenename = "scenes/Producer/WorldC4M4B23.vcd" }  //GET TO THE BOAT!
	],
	group_params = none
}

{
	name = "iMT_PlayerGetToVehicleChopperProducer",
	criteria =
	[
		[ "concept", "iMT_PlayerGetToVehicleChopper" ], [ "who", "Producer" ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/WorldC2M5B48.vcd" }  //Let's go! Get to the helicopter!
		{ scenename = "scenes/Producer/WorldC2M5B49.vcd" }  //Everybody get to the chopper!
		{ scenename = "scenes/Producer/WorldC2M5B50.vcd" }  //Let's go, guys, let's go! Get to the chopper!
		{ scenename = "scenes/Producer/WorldC2M5B51.vcd" }  //Chopper's leaving, let's go!
		{ scenename = "scenes/Producer/WorldC2M5B52.vcd" }  //Let's go, let's go! Chopper's here!
		{ scenename = "scenes/Producer/WorldC5M5B19.vcd" }  //Get to the chopper!
		{ scenename = "scenes/Producer/WorldC5M5B22.vcd" }  //Get to the chopper!
	],
	group_params = none
}

{
	name = "iMT_PlayerGetToVehicleWheelsProducer",
	criteria =
	[
		[ "concept", "iMT_PlayerGetToVehicleWheels" ], [ "who", "Producer" ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/DLC1_C6M3_FinaleBridgeRun01.vcd" }  //Get to the car!
		{ scenename = "scenes/Producer/DLC1_C6M3_FinaleBridgeRun02.vcd" }  //Come on, let's get to the car!
	],
	group_params = none
}

{
	name = "iMT_PlayerGoingToDieProducer",
	criteria =
	[
		[ "concept", "iMT_PlayerGoingToDie" ], [ "who", "Producer" ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/GoingToDie01.vcd" }  //Okay this was a mistake.
		{ scenename = "scenes/Producer/GoingToDie02.vcd" }  //Okay, this seriously hurts.
		{ scenename = "scenes/Producer/GoingToDie03.vcd" }  //Okay, okay, that one hurt.
		{ scenename = "scenes/Producer/GoingToDie04.vcd" }  //Girl, you should have stayed with Jacob. (to self)
		{ scenename = "scenes/Producer/GoingToDie05.vcd" }  //By the beard of Zeus this hurts!
		{ scenename = "scenes/Producer/GoingToDie06.vcd" }  //Son of a bee-sting. This hurts.
		{ scenename = "scenes/Producer/GoingToDie07.vcd" }  //Where is the love? I can use some.
		{ scenename = "scenes/Producer/GoingToDie08.vcd" }  //This is not happening, This is not happening. This is not happening. (to self)
		{ scenename = "scenes/Producer/GoingToDie09.vcd" }  //Did this ever seem like a good idea?
		{ scenename = "scenes/Producer/GoingToDie10.vcd" }  //Knights of Columbus this hurts.
		{ scenename = "scenes/Producer/GoingToDie11.vcd" }  //I am too young to feel this old.
		{ scenename = "scenes/Producer/GoingToDie13.vcd" }  //This is not going well.
		{ scenename = "scenes/Producer/GoingToDie14.vcd" }  //One of you fellas want to carry the cute girl?
		{ scenename = "scenes/Producer/GoingToDie15.vcd" }  //I think I really hurt something.
		{ scenename = "scenes/Producer/GoingToDie16.vcd" }  //Anyone else feel like crap right now?
		{ scenename = "scenes/Producer/GoingToDie17.vcd" }  //This is some grim shit we got ourselves into.
		{ scenename = "scenes/Producer/GoingToDie18.vcd" }  //This is some grim shit we got ourselves into.
		{ scenename = "scenes/Producer/GoingToDie19.vcd" }  //I haven't fought through all of this to die now.
		{ scenename = "scenes/Producer/GoingToDie20.vcd" }  //Something's got to break our way.
		{ scenename = "scenes/Producer/GoingToDie21.vcd" }  //So this is how it's going to be.
		{ scenename = "scenes/Producer/GoingToDie25.vcd" }  //Girl, you should have stayed at home. (to self)
		{ scenename = "scenes/Producer/GoingToDie26.vcd" }  //You have got to be kidding me.
		{ scenename = "scenes/Producer/GoingToDie27.vcd" }  //I got a plan, let's kill all the zombies. Sound good?
	],
	group_params = none
}

{
	name = "iMT_PlayerGoingToDie3Producer",
	criteria =
	[
		[ "concept", "iMT_PlayerGoingToDie" ], [ "who", "Producer" ], [ "onthirdstrike", 1 ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/GoingToDie301.vcd" }  //Tonight's top story, Rochelle isn't going to make it.
		{ scenename = "scenes/Producer/GoingToDie302.vcd" }  //In case anyone is wondering, I am about to die!
		{ scenename = "scenes/Producer/GoingToDie303.vcd" }  //Hey guys, unlike Ellis, I'm not a complainer, but I'm about to die.
		{ scenename = "scenes/Producer/GoingToDie304.vcd" }  //I am too young and too beautiful to die.
		{ scenename = "scenes/Producer/GoingToDie305.vcd" }  //I need to find some health.
		{ scenename = "scenes/Producer/GoingToDie306.vcd" }  //In case anyone is wondering, I am about to die!
	],
	group_params = none
}

{
	name = "iMT_PlayerGoingToDie3C1Producer",
	criteria =
	[
		[ "concept", "iMT_PlayerGoingToDie" ], [ "who", "Producer" ], [ "onthirdstrike", 1 ], [ "map", "c1m1_hotel" ], [ NoKnowNames ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/GoingToDie302.vcd" }  //In case anyone is wondering, I am about to die!
		{ scenename = "scenes/Producer/GoingToDie304.vcd" }  //I am too young and too beautiful to die.
		{ scenename = "scenes/Producer/GoingToDie305.vcd" }  //I need to find some health.
		{ scenename = "scenes/Producer/GoingToDie306.vcd" }  //In case anyone is wondering, I am about to die!
	],
	group_params = none
}

{
	name = "iMT_PlayerGooedBySpitterProducer",
	criteria =
	[
		[ "concept", "iMT_PlayerGooedBySpitter" ], [ "who", "Producer" ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/GooedBySpitter01.vcd" }  //Ahhhh! What is this shit?
		{ scenename = "scenes/Producer/GooedBySpitter02.vcd" }  //Get out of this goo.
		{ scenename = "scenes/Producer/GooedBySpitter03.vcd" }  //Get out of the goo.
		{ scenename = "scenes/Producer/GooedBySpitter04.vcd" }  //Damn this stuff hurts.
		{ scenename = "scenes/Producer/GooedBySpitter05.vcd" }  //Ow! Move!
	],
	group_params = none
}

{
	name = "iMT_PlayerGooedBySpitterC1Producer",
	criteria =
	[
		[ "concept", "iMT_PlayerGooedBySpitter" ], [ "who", "Producer" ], [ C1M1orC1M2 ], [ IsNotSurvival ], [ NoKnowSpitter ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/GooedBySpitterC101.vcd" }  //Oh Jesus, this zombie spits burning shit!
		{ scenename = "scenes/Producer/GooedBySpitterC102.vcd" }  //BURNING SHIT!
		{ scenename = "scenes/Producer/GooedBySpitterC103.vcd" }  //Don't step in this shit!
	],
	group_params = none
}

{
	name = "iMT_PlayerHelloProducer",
	criteria =
	[
		[ "concept", "iMT_PlayerHello" ], [ "who", "Producer" ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/ScenarioJoin01.vcd" }  //What's up?
		{ scenename = "scenes/Producer/ScenarioJoin02.vcd" }  //Hello!
		{ scenename = "scenes/Producer/ScenarioJoin03.vcd" }  //Hello!
		{ scenename = "scenes/Producer/ScenarioJoin04.vcd" }  //Hey.
	],
	group_params = none
}

{
	name = "iMT_PlayerIncapacitatedHurtProducer",
	criteria =
	[
		[ "concept", "iMT_PlayerIncapacitatedHurt" ], [ "who", "Producer" ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/IncapacitatedInjury01.vcd" }  //AHHHHH [terrified yell]
		{ scenename = "scenes/Producer/IncapacitatedInjury02.vcd" }  //AHHHHH [terrified yell]
		{ scenename = "scenes/Producer/IncapacitatedInjury03.vcd" }  //AHHHHH [terrified yell]
		{ scenename = "scenes/Producer/IncapacitatedInjury04.vcd" }  //AHHHHH [terrified yell]
	],
	group_params = none
}

{
	name = "iMT_PlayerKillConfirmationProducer",
	criteria =
	[
		[ "concept", "iMT_PlayerKilledZombie" ], [ "who", "Producer" ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/KillConfirmation01.vcd" }  //Got it!
		{ scenename = "scenes/Producer/KillConfirmation02.vcd" }  //Taken care of.
		{ scenename = "scenes/Producer/KillConfirmation03.vcd" }  //That was mine.
		{ scenename = "scenes/Producer/KillConfirmation04.vcd" }  //Dead.
		{ scenename = "scenes/Producer/KillConfirmation05.vcd" }  //Got 'em.
		{ scenename = "scenes/Producer/KillConfirmation06.vcd" }  //Got 'em.
		{ scenename = "scenes/Producer/KillConfirmation07.vcd" }  //Kicked it.
		{ scenename = "scenes/Producer/KillConfirmation08.vcd" }  //Kicked it's ass.
	],
	group_params = none
}

{
	name = "iMT_PlayerKillConfirmationC1Producer",
	criteria =
	[
		[ "concept", "iMT_PlayerKilledZombie" ], [ "who", "Producer" ], [ "map", "c1m1_hotel" ], [ IsNotFirstKillC1 ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/WorldC1M1B45.vcd" }  //All right. I just did that.
		{ scenename = "scenes/Producer/WorldC1M1B46.vcd" }  //Okay. Now I'm killing zombies.
	],
	group_params = none
}

{
	name = "iMT_PlayerKillStealProducer",
	criteria =
	[
		[ "concept", "iMT_PlayerKilledZombie" ], [ "who", "Producer" ], [ "coughing", 0 ], [ "incapacitated", 0 ], [ "ismechanicalive", 1 ], [ "disttomechanic", 0, 399 ], [ "tankactive", 0 ], [ "randomnum", 0, 5 ], [ IsTalk ], [ IsTalkProducer ], [ IsWorldTalkProducer ], [ IsNotC1M1 ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/Blank.vcd", followup = RThen( "Mechanic", "iMT_PlayerKillSteal", { from = "Producer" }, 0 ) }
	],
	group_params = none
}

{
	name = "iMT_PlayerKillStealReacProducer",
	criteria =
	[
		[ "concept", "iMT_PlayerKillStealReac" ], [ "who", "Producer" ], [ "coughing", 0 ], [ "incapacitated", 0 ], [ IsTalk ], [ IsTalkProducer ], [ IsWorldTalkProducer ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/KillConfirmationEllis01.vcd", followup = RThen( "Mechanic", "iMT_PlayerKillStealInsist", { from = "Producer" }, 0 ) }  //Ellis, that was me.
	],
	group_params = none
}

{
	name = "iMT_PlayerKillStealInsistReacProducer",
	criteria =
	[
		[ "concept", "iMT_PlayerKillStealInsistReac" ], [ "who", "Producer" ], [ "coughing", 0 ], [ "incapacitated", 0 ], [ IsTalk ], [ IsTalkProducer ], [ IsWorldTalkProducer ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/ReactionNegative01.vcd" }  //Nooooo oo ooo ohhhhh.
	],
	group_params = none
}

{
	name = "iMT_PlayerMeleeProducer",
	criteria =
	[
		[ "concept", "iMT_PlayerMelee" ], [ "who", "Producer" ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/MeleeSwing01.vcd" }  //[Melee grunt]
		{ scenename = "scenes/Producer/MeleeSwing02.vcd" }  //[Melee grunt]
		{ scenename = "scenes/Producer/MeleeSwing03.vcd" }  //[Melee grunt]
		{ scenename = "scenes/Producer/MeleeSwing04.vcd" }  //[Melee grunt]
		{ scenename = "scenes/Producer/MeleeSwing05.vcd" }  //[Melee grunt]
		{ scenename = "scenes/Producer/MeleeSwing06.vcd" }  //[Melee grunt]
		{ scenename = "scenes/Producer/MeleeSwing07.vcd" }  //[Melee grunt]
		{ scenename = "scenes/Producer/MeleeSwing08.vcd" }  //[Melee grunt]
		{ scenename = "scenes/Producer/MeleeSwing09.vcd" }  //[Melee grunt]
	],
	group_params = none
}

{
	name = "iMT_PlayerMournCoachAliveProducer",
	criteria =
	[
		[ "concept", "iMT_PlayerMourn" ], [ "who", "Producer" ], [ "iscoachalive", 1 ], [ "subject", "Coach" ], [ "dist_from_subject", 0, 199 ]
	],
	responses = SurvivorMournCoachProducer,
	group_params = none
}

{
	name = "iMT_PlayerMournCoachAliveC1Producer",
	criteria =
	[
		[ "concept", "iMT_PlayerMourn" ], [ "who", "Producer" ], [ "iscoachalive", 1 ], [ "subject", "Coach" ], [ "dist_from_subject", 0, 199 ], [ "map", "c1m1_hotel" ], [ NoKnowNames ]
	],
	responses = SurvivorMournCoachC1Producer,
	group_params = none
}

{
	name = "iMT_PlayerMournCoachDeadProducer",
	criteria =
	[
		[ "concept", "iMT_PlayerMourn" ], [ "who", "Producer" ], [ "iscoachalive", 0 ], [ "disttocoach", 0, 199 ]
	],
	responses = SurvivorMournCoachProducer,
	group_params = none
}

{
	name = "iMT_PlayerMournCoachDeadC1Producer",
	criteria =
	[
		[ "concept", "iMT_PlayerMourn" ], [ "who", "Producer" ], [ "iscoachalive", 0 ], [ "disttocoach", 0, 199 ], [ "map", "c1m1_hotel" ], [ NoKnowNames ]
	],
	responses = SurvivorMournCoachC1Producer,
	group_params = none
}

{
	name = "iMT_PlayerMournGamblerAliveProducer",
	criteria =
	[
		[ "concept", "iMT_PlayerMourn" ], [ "who", "Producer" ], [ "isgambleralive", 1 ], [ "subject", "Gambler" ], [ "dist_from_subject", 0, 199 ]
	],
	responses = SurvivorMournGamblerProducer,
	group_params = none
}

{
	name = "iMT_PlayerMournGamblerAliveC1Producer",
	criteria =
	[
		[ "concept", "iMT_PlayerMourn" ], [ "who", "Producer" ], [ "isgambleralive", 1 ], [ "subject", "Gambler" ], [ "dist_from_subject", 0, 199 ], [ "map", "c1m1_hotel" ], [ NoKnowNames ]
	],
	responses = SurvivorMournGamblerC1Producer,
	group_params = none
}

{
	name = "iMT_PlayerMournGamblerDeadProducer",
	criteria =
	[
		[ "concept", "iMT_PlayerMourn" ], [ "who", "Producer" ], [ "isgambleralive", 0 ], [ "disttogambler", 0, 199 ]
	],
	responses = SurvivorMournGamblerProducer,
	group_params = none
}

{
	name = "iMT_PlayerMournGamblerDeadC1Producer",
	criteria =
	[
		[ "concept", "iMT_PlayerMourn" ], [ "who", "Producer" ], [ "isgambleralive", 0 ], [ "disttogambler", 0, 199 ], [ "map", "c1m1_hotel" ], [ NoKnowNames ]
	],
	responses = SurvivorMournGamblerC1Producer,
	group_params = none
}

{
	name = "iMT_PlayerMournMechanicAliveProducer",
	criteria =
	[
		[ "concept", "iMT_PlayerMourn" ], [ "who", "Producer" ], [ "ismechanicalive", 1 ], [ "subject", "Mechanic" ], [ "dist_from_subject", 0, 199 ]
	],
	responses = SurvivorMournMechanicProducer,
	group_params = none
}

{
	name = "iMT_PlayerMournMechanicAliveC1Producer",
	criteria =
	[
		[ "concept", "iMT_PlayerMourn" ], [ "who", "Producer" ], [ "ismechanicalive", 1 ], [ "subject", "Mechanic" ], [ "dist_from_subject", 0, 199 ], [ "map", "c1m1_hotel" ], [ NoKnowNames ]
	],
	responses = SurvivorMournMechanicC1Producer,
	group_params = none
}

{
	name = "iMT_PlayerMournMechanicDeadProducer",
	criteria =
	[
		[ "concept", "iMT_PlayerMourn" ], [ "who", "Producer" ], [ "ismechanicalive", 0 ], [ "disttomechanic", 0, 199 ]
	],
	responses = SurvivorMournMechanicProducer,
	group_params = none
}

{
	name = "iMT_PlayerMournMechanicDeadC1Producer",
	criteria =
	[
		[ "concept", "iMT_PlayerMourn" ], [ "who", "Producer" ], [ "ismechanicalive", 0 ], [ "disttomechanic", 0, 199 ], [ "map", "c1m1_hotel" ], [ NoKnowNames ]
	],
	responses = SurvivorMournMechanicC1Producer,
	group_params = none
}

{
	name = "iMT_PlayerMournBikerProducer",
	criteria =
	[
		[ "concept", "iMT_PlayerMourn" ], [ "who", "Producer" ], [ "subject", "Biker" ], [ "dist_from_subject", 0, 199 ]
	],
	responses = SurvivorMournGamblerC1Producer,
	group_params = none
}

{
	name = "iMT_PlayerMournManagerProducer",
	criteria =
	[
		[ "concept", "iMT_PlayerMourn" ], [ "who", "Producer" ], [ "subject", "Manager" ], [ "dist_from_subject", 0, 199 ]
	],
	responses = SurvivorMournGamblerC1Producer,
	group_params = none
}

{
	name = "iMT_PlayerMournNamVetProducer",
	criteria =
	[
		[ "concept", "iMT_PlayerMourn" ], [ "who", "Producer" ], [ "subject", "NamVet" ], [ "dist_from_subject", 0, 199 ]
	],
	responses = SurvivorMournGamblerC1Producer,
	group_params = none
}

{
	name = "iMT_PlayerMournTeenGirlProducer",
	criteria =
	[
		[ "concept", "iMT_PlayerMourn" ], [ "who", "Producer" ], [ "subject", "TeenGirl" ], [ "dist_from_subject", 0, 199 ]
	],
	responses = SurvivorMournGamblerC1Producer,
	group_params = none
}

{
	name = "iMT_PlayerNearExitProducer",
	criteria =
	[
		[ "concept", "iMT_PlayerNearExit" ], [ "who", "Producer" ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/SafeSpotAhead01.vcd" }  //Safe house ahead.
		{ scenename = "scenes/Producer/SafeSpotAhead02.vcd" }  //Safe house up here.
		{ scenename = "scenes/Producer/SafeSpotAhead03.vcd" }  //Safe house this way!
		{ scenename = "scenes/Producer/SafeSpotAhead04.vcd" }  //I see a safe house this way!
		{ scenename = "scenes/Producer/SafeSpotAhead05.vcd" }  //Safe house up ahead!
		{ scenename = "scenes/Producer/SafeSpotAhead06.vcd" }  //Oh, a safe house up ahead!
	],
	group_params = none
}

{
	name = "iMT_PlayerNiceShotProducer",
	criteria =
	[
		[ "concept", "iMT_PlayerNiceShot" ], [ "who", "Producer" ]
	],
	responses = PlayerNiceShotProducer,
	group_params = none
}

{
	name = "iMT_PlayerNiceShotCoachProducer",
	criteria =
	[
		[ "concept", "iMT_PlayerNiceShot" ], [ "who", "Producer" ], [ "subject", "Coach" ], [ "dist_from_subject", 0, 799 ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/NiceShotCoach01.vcd" }  //Nice shot Coach.
	],
	group_params = none
}

{
	name = "iMT_PlayerNiceShotCoachC1Producer",
	criteria =
	[
		[ "concept", "iMT_PlayerNiceShot" ], [ "who", "Producer" ], [ "subject", "Coach" ], [ "dist_from_subject", 0, 799 ], [ "map", "c1m1_hotel" ], [ NoKnowNames ]
	],
	responses = PlayerNiceShotProducer,
	group_params = none
}

{
	name = "iMT_PlayerNiceShotMechanicProducer",
	criteria =
	[
		[ "concept", "iMT_PlayerNiceShot" ], [ "who", "Producer" ], [ "subject", "Mechanic" ], [ "dist_from_subject", 0, 799 ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/NiceShotEllis01.vcd" }  //Nice shot, Hee-Haw.
		{ scenename = "scenes/Producer/NiceShotEllis02.vcd" }  //Wow, Ellis got 'er done.
	],
	group_params = none
}

{
	name = "iMT_PlayerNiceShotMechanicC1Producer",
	criteria =
	[
		[ "concept", "iMT_PlayerNiceShot" ], [ "who", "Producer" ], [ "subject", "Mechanic" ], [ "dist_from_subject", 0, 799 ], [ "map", "c1m1_hotel" ], [ NoKnowNames ]
	],
	responses = PlayerNiceShotProducer,
	group_params = none
}

{
	name = "iMT_PlayerNiceShotBikerProducer",
	criteria =
	[
		[ "concept", "iMT_PlayerNiceShot" ], [ "who", "Producer" ], [ "subject", "Biker" ], [ "dist_from_subject", 0, 799 ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/DLC1_C6M3_FinaleL4D1Killing05.vcd" }  //Nice shot Francis!
	],
	group_params = none
}

{
	name = "iMT_PlayerNiceShotBikerC1Producer",
	criteria =
	[
		[ "concept", "iMT_PlayerNiceShot" ], [ "who", "Producer" ], [ "subject", "Biker" ], [ "dist_from_subject", 0, 799 ], [ "map", "c1m1_hotel" ], [ NoKnowNames ]
	],
	responses = PlayerNiceShotProducer,
	group_params = none
}

{
	name = "iMT_PlayerNiceShotManagerProducer",
	criteria =
	[
		[ "concept", "iMT_PlayerNiceShot" ], [ "who", "Producer" ], [ "subject", "Manager" ], [ "dist_from_subject", 0, 799 ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/DLC1_C6M3_FinaleL4D1Killing01.vcd" }  //Nice Louis!
		{ scenename = "scenes/Producer/DLC1_C6M3_FinaleL4D1Killing02.vcd" }  //Nice shooting Louis!
		{ scenename = "scenes/Producer/DLC1_C6M3_FinaleL4D1Killing03.vcd" }  //All right Louis!
	],
	group_params = none
}

{
	name = "iMT_PlayerNiceShotManagerC1Producer",
	criteria =
	[
		[ "concept", "iMT_PlayerNiceShot" ], [ "who", "Producer" ], [ "subject", "Manager" ], [ "dist_from_subject", 0, 799 ], [ "map", "c1m1_hotel" ], [ NoKnowNames ]
	],
	responses = PlayerNiceShotProducer,
	group_params = none
}

{
	name = "iMT_PlayerNiceShotTeenGirlProducer",
	criteria =
	[
		[ "concept", "iMT_PlayerNiceShot" ], [ "who", "Producer" ], [ "subject", "TeenGirl" ], [ "dist_from_subject", 0, 799 ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/DLC1_C6M3_FinaleL4D1Killing08.vcd" }  //Nice shot Zoey!
	],
	group_params = none
}

{
	name = "iMT_PlayerNiceShotTeenGirlC1Producer",
	criteria =
	[
		[ "concept", "iMT_PlayerNiceShot" ], [ "who", "Producer" ], [ "subject", "TeenGirl" ], [ "dist_from_subject", 0, 799 ], [ "map", "c1m1_hotel" ], [ NoKnowNames ]
	],
	responses = PlayerNiceShotProducer,
	group_params = none
}

{
	name = "iMT_PlayerPainNoiseProducer",
	criteria =
	[
		[ "concept", "iMT_PlayerPainNoise" ], [ "who", "Producer" ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/HurtCritical01.vcd" }  //[pain noise - loud major pain]
		{ scenename = "scenes/Producer/HurtCritical02.vcd" }  //[pain noise - loud major pain]
		{ scenename = "scenes/Producer/HurtCritical03.vcd" }  //[pain noise - loud major pain]
		{ scenename = "scenes/Producer/HurtCritical04.vcd" }  //[pain noise - loud major pain]
		{ scenename = "scenes/Producer/HurtMajor01.vcd" }  //[pain noise - huh]
		{ scenename = "scenes/Producer/HurtMajor02.vcd" }  //[pain noise - ahh]
		{ scenename = "scenes/Producer/HurtMajor03.vcd" }  //[pain noise - oy]
		{ scenename = "scenes/Producer/HurtMajor04.vcd" }  //[pain noise - ugh]
	],
	group_params = none
}

{
	name = "iMT_PlayerPouncedCoachProducer",
	criteria =
	[
		[ "concept", "iMT_SurvivorWasPounced" ], [ "who", "Producer" ], [ "subject", "Coach" ], [ "dist_from_subject", 0, 799 ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/HunterCoachPounced01.vcd" }  //Hunter's got Coach!
		{ scenename = "scenes/Producer/HunterCoachPounced02.vcd" }  //Hunter on Coach!
	],
	group_params = none
}

{
	name = "iMT_PlayerPouncedCoachC1Producer",
	criteria =
	[
		[ "concept", "iMT_SurvivorWasPounced" ], [ "who", "Producer" ], [ "subject", "Coach" ], [ "dist_from_subject", 0, 799 ], [ C1M1orC1M2 ], [ IsNotSurvival ], [ NoKnowHunter ]
	],
	responses = PlayerPouncedC1Producer,
	group_params = none
}

{
	name = "iMT_PlayerPouncedCoachGenericProducer",
	criteria =
	[
		[ "concept", "iMT_SurvivorWasPounced" ], [ "who", "Producer" ], [ "subject", "Coach" ], [ "dist_from_subject", 0, 799 ], [ "randomnum", 0, 20 ]
	],
	responses = PlayerPouncedProducer,
	group_params = none
}

{
	name = "iMT_PlayerPouncedGamblerProducer",
	criteria =
	[
		[ "concept", "iMT_SurvivorWasPounced" ], [ "who", "Producer" ], [ "subject", "Gambler" ], [ "dist_from_subject", 0, 799 ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/HunterNickPounced01.vcd" }  //Hunter's got Nick!
		{ scenename = "scenes/Producer/HunterNickPounced02.vcd" }  //Hunter's on Nick!
	],
	group_params = none
}

{
	name = "iMT_PlayerPouncedGamblerC1Producer",
	criteria =
	[
		[ "concept", "iMT_SurvivorWasPounced" ], [ "who", "Producer" ], [ "subject", "Gambler" ], [ "dist_from_subject", 0, 799 ], [ C1M1orC1M2 ], [ IsNotSurvival ], [ NoKnowHunter ]
	],
	responses = PlayerPouncedC1Producer,
	group_params = none
}

{
	name = "iMT_PlayerPouncedGamblerGenericProducer",
	criteria =
	[
		[ "concept", "iMT_SurvivorWasPounced" ], [ "who", "Producer" ], [ "subject", "Gambler" ], [ "dist_from_subject", 0, 799 ], [ "randomnum", 0, 20 ]
	],
	responses = PlayerPouncedProducer,
	group_params = none
}

{
	name = "iMT_PlayerPouncedMechanicProducer",
	criteria =
	[
		[ "concept", "iMT_SurvivorWasPounced" ], [ "who", "Producer" ], [ "subject", "Mechanic" ], [ "dist_from_subject", 0, 799 ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/HunterEllisPounced01.vcd" }  //Hunter's got Ellis!
		{ scenename = "scenes/Producer/HunterEllisPounced02.vcd" }  //Hunter on Ellis!
	],
	group_params = none
}

{
	name = "iMT_PlayerPouncedMechanicC1Producer",
	criteria =
	[
		[ "concept", "iMT_SurvivorWasPounced" ], [ "who", "Producer" ], [ "subject", "Mechanic" ], [ "dist_from_subject", 0, 799 ], [ C1M1orC1M2 ], [ IsNotSurvival ], [ NoKnowHunter ]
	],
	responses = PlayerPouncedC1Producer,
	group_params = none
}

{
	name = "iMT_PlayerPouncedMechanicGenericProducer",
	criteria =
	[
		[ "concept", "iMT_SurvivorWasPounced" ], [ "who", "Producer" ], [ "subject", "Mechanic" ], [ "dist_from_subject", 0, 799 ], [ "randomnum", 0, 20 ]
	],
	responses = PlayerPouncedProducer,
	group_params = none
}

{
	name = "iMT_PlayerPouncedBikerProducer",
	criteria =
	[
		[ "concept", "iMT_SurvivorWasPounced" ], [ "who", "Producer" ], [ "subject", "Biker" ], [ "dist_from_subject", 0, 799 ]
	],
	responses = PlayerPouncedProducer,
	group_params = none
}

{
	name = "iMT_PlayerPouncedBikerC1Producer",
	criteria =
	[
		[ "concept", "iMT_SurvivorWasPounced" ], [ "who", "Producer" ], [ "subject", "Biker" ], [ "dist_from_subject", 0, 799 ], [ C1M1orC1M2 ], [ IsNotSurvival ], [ NoKnowHunter ]
	],
	responses = PlayerPouncedC1Producer,
	group_params = none
}

{
	name = "iMT_PlayerPouncedManagerProducer",
	criteria =
	[
		[ "concept", "iMT_SurvivorWasPounced" ], [ "who", "Producer" ], [ "subject", "Manager" ], [ "dist_from_subject", 0, 799 ]
	],
	responses = PlayerPouncedProducer,
	group_params = none
}

{
	name = "iMT_PlayerPouncedManagerC1Producer",
	criteria =
	[
		[ "concept", "iMT_SurvivorWasPounced" ], [ "who", "Producer" ], [ "subject", "Manager" ], [ "dist_from_subject", 0, 799 ], [ C1M1orC1M2 ], [ IsNotSurvival ], [ NoKnowHunter ]
	],
	responses = PlayerPouncedC1Producer,
	group_params = none
}

{
	name = "iMT_PlayerPouncedNamVetProducer",
	criteria =
	[
		[ "concept", "iMT_SurvivorWasPounced" ], [ "who", "Producer" ], [ "subject", "NamVet" ], [ "dist_from_subject", 0, 799 ]
	],
	responses = PlayerPouncedProducer,
	group_params = none
}

{
	name = "iMT_PlayerPouncedNamVetC1Producer",
	criteria =
	[
		[ "concept", "iMT_SurvivorWasPounced" ], [ "who", "Producer" ], [ "subject", "NamVet" ], [ "dist_from_subject", 0, 799 ], [ C1M1orC1M2 ], [ IsNotSurvival ], [ NoKnowHunter ]
	],
	responses = PlayerPouncedC1Producer,
	group_params = none
}

{
	name = "iMT_PlayerPouncedTeenGirlProducer",
	criteria =
	[
		[ "concept", "iMT_SurvivorWasPounced" ], [ "who", "Producer" ], [ "subject", "TeenGirl" ], [ "dist_from_subject", 0, 799 ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/ReactionNegative13.vcd" }  //Holy shit!
	],
	group_params = none
}

{
	name = "iMT_PlayerReloadingProducer",
	criteria =
	[
		[ "concept", "iMT_PlayerReloading" ], [ "who", "Producer" ], [ "tankactive", 0 ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/Reloading01.vcd" }  //Reloading!
		{ scenename = "scenes/Producer/Reloading02.vcd" }  //Reloading!
		{ scenename = "scenes/Producer/Reloading03.vcd" }  //I'm reloading!
		{ scenename = "scenes/Producer/Reloading04.vcd" }  //Reloading!
		{ scenename = "scenes/Producer/Reloading05.vcd" }  //Reloading!
		{ scenename = "scenes/Producer/Reloading06.vcd" }  //Reloading!
	],
	group_params = none
}

{
	name = "iMT_PlayerReloadingC4M2Producer",
	criteria =
	[
		[ "concept", "iMT_PlayerReloading" ], [ "who", "Producer" ], [ "tankactive", 0 ], [ "map", "c4m2_sugarmill_a" ], [ "world_auto_producerinwitchville", 1 ], [ IsNotSaidSafeSpotAhead ]
	],
	responses = SurvivorReloadingQuietProducer,
	group_params = none
}

{
	name = "iMT_PlayerReloadingIntenseProducer",
	criteria =
	[
		[ "concept", "iMT_PlayerReloading" ], [ "who", "Producer" ], [ "tankactive", 0 ], [ "incombatmusic", 1 ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/ReloadIntense01.vcd" }  //Reloading!
		{ scenename = "scenes/Producer/ReloadIntense02.vcd" }  //Reloading!
		{ scenename = "scenes/Producer/ReloadIntense03.vcd" }  //Reloading here!
	],
	group_params = none
}

{
	name = "iMT_PlayerReloadingQuietProducer",
	criteria =
	[
		[ "concept", "iMT_PlayerReloading" ], [ "who", "Producer" ], [ "tankactive", 0 ], [ "incombatmusic", 0 ], [ IsWitchNear ], [ IsNotWitchAggro ]
	],
	responses = SurvivorReloadingQuietProducer,
	group_params = none
}

{
	name = "iMT_PlayerReloadingTankProducer",
	criteria =
	[
		[ "concept", "iMT_PlayerReloading" ], [ "who", "Producer" ], [ "tankactive", 1 ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/BattleCryTank01.vcd" }  //Shoot it! Shoot it!
		{ scenename = "scenes/Producer/BattleCryTank05.vcd" }  //Don't stop shooting!
		{ scenename = "scenes/Producer/BattleCryTank06.vcd" }  //Kill it! Kill it!
		{ scenename = "scenes/Producer/BattleCryTank07.vcd" }  //Shoot the shit out of that thing.
		{ scenename = "scenes/Producer/BattleCryTank08.vcd" }  //Okay, shoot the shit out of that thing.
	],
	group_params = none
}

{
	name = "iMT_PlayerReloadingTankC1Producer",
	criteria =
	[
		[ "concept", "iMT_PlayerReloading" ], [ "who", "Producer" ], [ "tankactive", 1 ], [ C1M1orC1M2 ], [ IsNotSurvival ], [ NoKnowTank ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/HeardTanklC101.vcd" }  //HOLY SHIT! WHAT IN THE HELL IS THAT??!!
		{ scenename = "scenes/Producer/HeardTanklC102.vcd" }  //WE GOTTA FIGHT THAT THING?!!?
		{ scenename = "scenes/Producer/HeardTanklC103.vcd" }  //SHOOT IT SHOOT IT!!
	],
	group_params = none
}

{
	name = "iMT_PlayerSuggestHealthProducer",
	criteria =
	[
		[ "concept", "iMT_PlayerSuggestHealth" ], [ "who", "Producer" ]
	],
	responses = PlayerSuggestHealthProducer,
	group_params = none
}

{
	name = "iMT_PlayerSuggestHealthCoachProducer",
	criteria =
	[
		[ "concept", "iMT_PlayerSuggestHealth" ], [ "who", "Producer" ], [ "subject", "Coach" ], [ "dist_from_subject", 0, 199 ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/SuggestHealthCoach01.vcd" }  //Hey old man, heal up.
		{ scenename = "scenes/Producer/SuggestHealthCoach02.vcd" }  //Hey Coach, you should use that health kit.
		{ scenename = "scenes/Producer/SuggestHealthCoach03.vcd" }  //Time to heal up Coach.
	],
	group_params = none
}

{
	name = "iMT_PlayerSuggestHealthCoachC1Producer",
	criteria =
	[
		[ "concept", "iMT_PlayerSuggestHealth" ], [ "who", "Producer" ], [ "subject", "Coach" ], [ "dist_from_subject", 0, 199 ], [ "map", "c1m1_hotel" ], [ NoKnowNames ]
	],
	responses = PlayerSuggestHealthProducer,
	group_params = none
}

{
	name = "iMT_PlayerSuggestHealthGamblerProducer",
	criteria =
	[
		[ "concept", "iMT_PlayerSuggestHealth" ], [ "who", "Producer" ], [ "subject", "Gambler" ], [ "dist_from_subject", 0, 199 ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/SuggestHealthNick01.vcd" }  //Nick, you might want to heal now.
		{ scenename = "scenes/Producer/SuggestHealthNick02.vcd" }  //Smoke 'em if you got 'em Nick.
		{ scenename = "scenes/Producer/SuggestHealthNick03.vcd" }  //Nick, you might want to heal now.
		{ scenename = "scenes/Producer/SuggestHealthNick04.vcd" }  //Nick. Healing time.
	],
	group_params = none
}

{
	name = "iMT_PlayerSuggestHealthGamblerC1Producer",
	criteria =
	[
		[ "concept", "iMT_PlayerSuggestHealth" ], [ "who", "Producer" ], [ "subject", "Gambler" ], [ "dist_from_subject", 0, 199 ], [ "map", "c1m1_hotel" ], [ NoKnowNames ]
	],
	responses = PlayerSuggestHealthProducer,
	group_params = none
}

{
	name = "iMT_PlayerSuggestHealthMechanicProducer",
	criteria =
	[
		[ "concept", "iMT_PlayerSuggestHealth" ], [ "who", "Producer" ], [ "subject", "Mechanic" ], [ "dist_from_subject", 0, 199 ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/SuggestHealthEllis01.vcd" }  //Ellis baby, time to heal up.
		{ scenename = "scenes/Producer/SuggestHealthEllis02.vcd" }  //Ellis honey, you should use your first aid.
		{ scenename = "scenes/Producer/SuggestHealthEllis03.vcd" }  //Ellis, come on heal up already.
	],
	group_params = none
}

{
	name = "iMT_PlayerSuggestHealthMechanicC1Producer",
	criteria =
	[
		[ "concept", "iMT_PlayerSuggestHealth" ], [ "who", "Producer" ], [ "subject", "Mechanic" ], [ "dist_from_subject", 0, 199 ], [ "map", "c1m1_hotel" ], [ NoKnowNames ]
	],
	responses = PlayerSuggestHealthProducer,
	group_params = none
}

{
	name = "iMT_PlayerTeamKillProducer",
	criteria =
	[
		[ "concept", "iMT_PlayerTeamKill" ], [ "who", "Producer" ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/TeamKillAccident01.vcd" }  //Did you seriously think that was a good idea?
		{ scenename = "scenes/Producer/TeamKillAccident02.vcd" }  //What is going on inside that head of yours?
		{ scenename = "scenes/Producer/TeamKillAccident03.vcd" }  //JESUS! We are on the same team here!
		{ scenename = "scenes/Producer/TeamKillAccident04.vcd" }  //What the?
	],
	group_params = none
}

{
	name = "iMT_PlayerTransitionProducer",
	criteria =
	[
		[ "concept", "iMT_PlayerTransition" ], [ "who", "Producer" ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/TransitionClose01.vcd" }  //Woah, that was close!
		{ scenename = "scenes/Producer/TransitionClose02.vcd" }  //Okay, that was a little too close.
		{ scenename = "scenes/Producer/TransitionClose03.vcd" }  //Did we all make it, OH YES WE DID!
		{ scenename = "scenes/Producer/TransitionClose04.vcd" }  //Woah, that was close!
		{ scenename = "scenes/Producer/TransitionClose05.vcd" }  //That was close.
		{ scenename = "scenes/Producer/TransitionClose06.vcd" }  //Live and in the flesh!
		{ scenename = "scenes/Producer/TransitionClose07.vcd" }  //All bark, no bite!
		{ scenename = "scenes/Producer/TransitionClose08.vcd" }  //We made it uh huh. We made it oh yeah (sung)
		{ scenename = "scenes/Producer/TransitionClose10.vcd" }  //Whoa, that's about as close as I like to cut it…
	],
	group_params = none
}

{
	name = "iMT_PlayerTransitionCloseProducer",
	criteria =
	[
		[ "concept", "iMT_PlayerTransition" ], [ "who", "Producer" ], [ "numberofteamdead", 1, null ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/TransitionClose11.vcd" }  //We're going to have to do better.
		{ scenename = "scenes/Producer/TransitionClose12.vcd" }  //We almost didn't make it...
		{ scenename = "scenes/Producer/TransitionClose13.vcd" }  //I KNOW we can do better than that.
		{ scenename = "scenes/Producer/TransitionClose14.vcd" }  //Well. That was embarrassing.
	],
	group_params = none
}

{
	name = "iMT_PlayerTransitionSoloProducer",
	criteria =
	[
		[ "concept", "iMT_PlayerTransition" ], [ "who", "Producer" ], [ "numberofteamdead", 1, null ], [ "numberofteamalive", 1 ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/TransitionClose15.vcd" }  //What happened to us?
	],
	group_params = none
}

{
	name = "iMT_PlayerWitchChasingProducer",
	criteria =
	[
		[ "concept", "iMT_PlayerWitchChasing" ], [ "who", "Producer" ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/WitchChasing01.vcd" }  //My bad, my bad, my bad!
		{ scenename = "scenes/Producer/WitchChasing02.vcd" }  //Out of my way!
		{ scenename = "scenes/Producer/WitchChasing03.vcd" }  //Out of my way!
		{ scenename = "scenes/Producer/WitchChasing04.vcd" }  //Kill the damn thing!
		{ scenename = "scenes/Producer/WitchChasing05.vcd" }  //Kill the damn thing!
		{ scenename = "scenes/Producer/WitchChasing06.vcd" }  //Shoot her! Shoot her!
		{ scenename = "scenes/Producer/WitchChasing07.vcd" }  //Oh shit! She's on my ass!
		{ scenename = "scenes/Producer/WitchChasing08.vcd" }  //My bad!
		{ scenename = "scenes/Producer/WitchChasing09.vcd" }  //My bad, my bad, my bad!
	],
	group_params = none
}

{
	name = "iMT_PlayerWitchChasingC6M1Producer",
	criteria =
	[
		[ "concept", "iMT_PlayerWitchChasing" ], [ "who", "Producer" ], [ "map", "c6m1_riverbank" ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/DLC1_C6M1_WeddingWitchAttacking03.vcd" }  //Get this bride off me!
		{ scenename = "scenes/Producer/DLC1_C6M1_WeddingWitchChasing01.vcd" }  //Ahh I pissed off another bride!
		{ scenename = "scenes/Producer/DLC1_C6M1_WeddingWitchChasing02.vcd" }  //Kill the bride! Kill the bride!
		{ scenename = "scenes/Producer/DLC1_C6M1_WeddingWitchChasing03.vcd" }  //Kill the bride!
	],
	group_params = none
}

{
	name = "iMT_SurvivorCaughtVomitProducer",
	criteria =
	[
		[ "concept", "iMT_PlayerVomitInFace" ], [ "who", "Producer" ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/BoomerReaction01.vcd" }  //Damn it, I just washed this!
		{ scenename = "scenes/Producer/BoomerReaction02.vcd" }  //Oh god!
		{ scenename = "scenes/Producer/BoomerReaction03.vcd" }  //Ahhh ugh! Jesus! Eww ugh!
		{ scenename = "scenes/Producer/BoomerReaction04.vcd" }  //Oh bleh, shit!
		{ scenename = "scenes/Producer/BoomerReaction05.vcd" }  //Oh, ugh! Oh, not again!
	],
	group_params = none
}

//--------------------------------------------------------------------------------------------------
// Character-specific
//--------------------------------------------------------------------------------------------------

{
	name = "iMT_AllAboardProducer",
	criteria =
	[
		[ "concept", "iMT_AllAboard" ], [ "who", "Producer" ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/DLC1_CommunityR13.vcd" }  //All aboard! Toot toot!
	],
	group_params = none
}

{
	name = "iMT_AngelProducer",
	criteria =
	[
		[ "concept", "iMT_Angel" ], [ "who", "Producer" ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/DLC1_C6M1_WeddingWitch10.vcd" }  //Hey Ellis look, it's another angel.
		{ scenename = "scenes/Producer/DLC1_C6M1_WeddingWitch11.vcd" }  //Ellis look, it's another angel.
	],
	group_params = none
}

{
	name = "iMT_AyeProducer",
	criteria =
	[
		[ "concept", "iMT_Aye" ], [ "who", "Producer" ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/DLC1_C6M2_StartingJukeBox03.vcd" }  //(FONZIE) AYYYYYEEEE!
	],
	group_params = none
}

{
	name = "iMT_BotheringProducer",
	criteria =
	[
		[ "concept", "iMT_Bothering" ], [ "who", "Producer" ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/DLC1_C6M3_FinaleChat32.vcd" }  //Ellis, quit bothering these poor people. I'm so sorry.
	],
	group_params = none
}

{
	name = "iMT_CharmingProducer",
	criteria =
	[
		[ "concept", "iMT_Charming" ], [ "who", "Producer" ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/DLC1_C6M1_InitialMeeting17.vcd" }  //Oh, Nick, charming is not a word I would use to describe you.
	],
	group_params = none
}

{
	name = "iMT_HateProducer",
	criteria =
	[
		[ "concept", "iMT_Hate" ], [ "who", "Producer" ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/DLC1_C6M3_FinaleChat05.vcd" }  //Sure, never really thought about it but yeah I hate things.
		{ scenename = "scenes/Producer/DLC1_C6M3_FinaleChat06.vcd" }  //Sure, never really thought about it but yeah I hate stuff.
	],
	group_params = none
}

{
	name = "iMT_HoneymoonProducer",
	criteria =
	[
		[ "concept", "iMT_Honeymoon" ], [ "who", "Producer" ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/DLC1_C6M1_WeddingWitchDead03.vcd" }  //Honeymoon's over.
	],
	group_params = none
}

{
	name = "iMT_KitchenProducer",
	criteria =
	[
		[ "concept", "iMT_Kitchen" ], [ "who", "Producer" ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/TakeFryingPan01.vcd" }  //No one better make a crack about me in the kitchen.
	],
	group_params = none
}

{
	name = "iMT_LearningProducer",
	criteria =
	[
		[ "concept", "iMT_Learning" ], [ "who", "Producer" ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/DLC1_C6M2_Phase206.vcd" }  //I've never had so much fun learning.
		{ scenename = "scenes/Producer/DLC1_C6M2_Phase207.vcd" }  //I've never had so much fun learning.
	],
	group_params = none
}

{
	name = "iMT_LoveGunsProducer",
	criteria =
	[
		[ "concept", "iMT_LoveGuns" ], [ "who", "Producer" ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/WorldC1M2B24.vcd" }  //I don't know if it's the feel, or the weight, or the thousand zombies trying to kill me. But I am really starting to like these guns.
		{ scenename = "scenes/Producer/WorldC1M2B25.vcd" }  //Why didn't anyone TELL me shooting these things felt like this?
		{ scenename = "scenes/Producer/WorldC1M2B26.vcd" }  //Oh, it feels so wrong, but is just so right. I love guns. There I said it. I love guns.
		{ scenename = "scenes/Producer/WorldGenericProducer31.vcd" }  //Okay, killing is wrong. But killing zombies is... actually pretty badass.
	],
	group_params = none
}

{
	name = "iMT_LoveGuns%Producer",
	criteria =
	[
		[ "concept", "iMT_LoveGuns" ], [ "who", "Producer" ], [ "randomnum", 0, 10 ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/WorldC1M2B42.vcd" }  //Okay, my new favorite's the shotgun!
		{ scenename = "scenes/Producer/WorldC1M2B43.vcd" }  //Okay, now I want to try the sniper rifle!
	],
	group_params = none
}

{
	name = "iMT_NewVoicesProducer",
	criteria =
	[
		[ "concept", "iMT_NewVoices" ], [ "who", "Producer" ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/DLC1_C6M3_Elevator05.vcd" }  //After a few hours in the car with you guys, it's nice to hear some new voices.
	],
	group_params = none
}

{
	name = "iMT_NickOCDProducer",
	criteria =
	[
		[ "concept", "iMT_NickOCD" ], [ "who", "Producer" ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/NickOCD01.vcd" }  //Nick, catching a cold isn't high up on my list of concerns right now.
		{ scenename = "scenes/Producer/NickOCD02.vcd", followup = RThen( "Gambler", "iMT_NickOCDReac", { from = "Producer" }, 0.3 ) }  //You want us to cover you from zombie attacks while you wash your hands, Nick?
		{ scenename = "scenes/Producer/NickOCD03.vcd" }  //Okay, I haven't caught zombie. I'm not gonna worry about cooties, Nick.
	],
	group_params = none
}

{
	name = "iMT_NoNoNoProducer",
	criteria =
	[
		[ "concept", "iMT_NoNoNo" ], [ "who", "Producer" ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/DLC1_C6M3_FinaleChat17.vcd" }  //NO no no no no no.
		{ scenename = "scenes/Producer/DLC1_C6M3_FinaleChat18.vcd" }  //NO no no no no no.
		{ scenename = "scenes/Producer/DLC1_C6M3_FinaleChat20.vcd" }  //NO no no no no no.
	],
	group_params = none
}

{
	name = "iMT_NoSexProducer",
	criteria =
	[
		[ "concept", "iMT_NoSex" ], [ "who", "Producer" ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/Generic01.vcd" }  //Not if you were the last man on earth.
		{ scenename = "scenes/Producer/Generic02.vcd" }  //Oh god, I hope I'm not the last woman on earth.
	],
	group_params = none
}

{
	name = "iMT_NotDieProducer",
	criteria =
	[
		[ "concept", "iMT_NotDie" ], [ "who", "Producer" ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/GoingToDie19.vcd" }  //I haven't fought through all of this to die now.
	],
	group_params = none
}

{
	name = "iMT_PopcornProducer",
	criteria =
	[
		[ "concept", "iMT_Popcorn" ], [ "who", "Producer" ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/DLC1_CommunityR15.vcd" }  //Ooh, popcorn! Popcorn! I love popcorn! You Coach?
		{ scenename = "scenes/Producer/DLC1_CommunityR16.vcd" }  //Popcorn, I love popcorn! You Coach?
	],
	group_params = none
}

{
	name = "iMT_PrayReacProducer",
	criteria =
	[
		[ "concept", "iMT_PrayReac" ], [ "who", "Producer" ], [ "coughing", 0 ], [ "incapacitated", 0 ], [ "speaking", 0], [ IsTalk ], [ IsTalkProducer ], [ IsWorldTalkProducer ], [ IssuerClose ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/WorldC1M3B03.vcd" }  //Amen.
		{ scenename = "scenes/Producer/WorldC1M3B04.vcd" }  //Amen.
		{ scenename = "scenes/Producer/WorldC1M3B05.vcd" }  //Lord, have mercy on Coach and spare the food court.
	],
	group_params = none
}

{
	name = "iMT_SingingProducer",
	criteria =
	[
		[ "concept", "iMT_Singing" ], [ "who", "Producer" ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/TransitionClose08.vcd" }  //We made it uh huh. We made it oh yeah! (sing)
	],
	group_params = none
}

{
	name = "iMT_SomethingProducer",
	criteria =
	[
		[ "concept", "iMT_Something" ], [ "who", "Producer" ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/DLC1_C6M1_WeddingWitch15.vcd" }  //Something old, something new, something about to rip your guts out.
	],
	group_params = none
}

{
	name = "iMT_StomachProducer",
	criteria =
	[
		[ "concept", "iMT_Stomach" ], [ "who", "Producer" ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/WorldC1M3B10.vcd", followup = RThen( "Coach", "iMT_StomachReac", { from = "Producer" }, 0.3 ) }  //I HEAR A HUN- Coach, is that your stomach?
	],
	group_params = none
}

{
	name = "iMT_TitsProducer",
	criteria =
	[
		[ "concept", "iMT_Tits" ], [ "who", "Producer" ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/World04.vcd" }  //We're here. Crescent City. I'll tell you now, I'm not showing anyone my tits.
	],
	group_params = none
}

{
	name = "iMT_TurdProducer",
	criteria =
	[
		[ "concept", "iMT_Turd" ], [ "who", "Producer" ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/DLC1_C6M2_InWaterFindLadder01.vcd" }  //Nick, you've got a turd on your shoulder.
		{ scenename = "scenes/Producer/DLC1_C6M2_InWaterFindLadder02.vcd" }  //Nick, you've got a turd on your shoulder.
		{ scenename = "scenes/Producer/DLC1_C6M2_InWaterFindLadder03.vcd" }  //Nick, there's something on your shoulder.
	],
	group_params = none
}

{
	name = "iMT_WeddingProducer",
	criteria =
	[
		[ "concept", "iMT_Wedding" ], [ "who", "Producer" ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/DLC1_C6M1_WeddingWitch03.vcd" }  //(whispered) Hey Ellis, it's a nice day for a white wedding.
		{ scenename = "scenes/Producer/DLC1_C6M1_WeddingWitch04.vcd" }  //(whispered) Hey Ellis, it's a nice day for a white wedding.
	],
	group_params = none
}

{
	name = "iMT_WhereFromProducer",
	criteria =
	[
		[ "concept", "iMT_WhereFrom" ], [ "who", "Producer" ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/DLC1_C6M3_FinaleChat25.vcd" }  //Wow, where the hell did you come from?
	],
	group_params = none
}

//--------------------------------------------------------------------------------------------------
// Overrides
//--------------------------------------------------------------------------------------------------

{
	name = "iMT_PlayerAnswerLostCallProducer",
	criteria =
	[
		[ "concept", "PlayerAnswerLostCall" ], [ "who", "Producer" ], [ "coughing", 0 ], [ "numberofteamalive", 4, null ], [ "numberofteamdead", 0 ], [ "disttoclosestsurvivor", 0, 499 ], [ "randomnum", 0, 10 ], [ IsTalk ], [ IsTalkProducer ], [ IsWorldTalkProducer ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/ScenarioJoinLast01.vcd" }  //We're all here.
		{ scenename = "scenes/Producer/ScenarioJoinLast02.vcd" }  //We're all here.
	],
	group_params = none
}

{
	name = "iMT_PlayerAreaClearProducer",
	criteria =
	[
		[ "concept", "PlayerAreaClear" ], [ "who", "Producer" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkProducer ], [ IsWorldTalkProducer ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/Defibrillator07.vcd" }  //Clear!
	],
	group_params = none
}

{
	name = "iMT_PlayerHeardBoomerProducer",
	criteria =
	[
		[ "concept", "PlayerHeardBoomer" ], [ "who", "Producer" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkProducer ], [ IsWorldTalkProducer ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/HeardBoomer01.vcd" }  //Careful I can hear a boomer.
		{ scenename = "scenes/Producer/HeardBoomer02.vcd" }  //Boomer's around.
		{ scenename = "scenes/Producer/HeardBoomer03.vcd" }  //Careful I hear a boomer.
	],
	group_params = none
}

{
	name = "iMT_PlayerHeardBoomerC1Producer",
	criteria =
	[
		[ "concept", "PlayerHeardBoomer" ], [ "who", "Producer" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkProducer ], [ IsWorldTalkProducer ], [ C1M1orC1M2 ], [ IsNotSurvival ], [ NoKnowBoomer ]
	],
	responses = PlayerHeardSpecialC1Producer,
	group_params = none
}

{
	name = "iMT_PlayerHeardChargerProducer",
	criteria =
	[
		[ "concept", "PlayerHeardCharger" ], [ "who", "Producer" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkProducer ], [ IsWorldTalkProducer ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/HeardCharger01.vcd" }  //Careful there's a charger around.
		{ scenename = "scenes/Producer/HeardCharger02.vcd" }  //I hear a charger.
		{ scenename = "scenes/Producer/HeardCharger03.vcd" }  //Watch out, charger!
		{ scenename = "scenes/Producer/HeardCharger04.vcd" }  //Watch out, charger!
		{ scenename = "scenes/Producer/HeardCharger05.vcd" }  //Careful there's a charger around.
	],
	group_params = none
}

{
	name = "iMT_PlayerHeardChargerC1Producer",
	criteria =
	[
		[ "concept", "PlayerHeardCharger" ], [ "who", "Producer" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkProducer ], [ IsWorldTalkProducer ], [ C1M1orC1M2 ], [ IsNotSurvival ], [ NoKnowCharger ]
	],
	responses = PlayerHeardSpecialC1Producer,
	group_params = none
}

{
	name = "iMT_PlayerHeardHunterProducer",
	criteria =
	[
		[ "concept", "PlayerHeardHunter" ], [ "who", "Producer" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkProducer ], [ IsWorldTalkProducer ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/HeardHunter01.vcd" }  //I hear a Hunter.
		{ scenename = "scenes/Producer/HeardHunter02.vcd" }  //Careful, a Hunter's around.
		{ scenename = "scenes/Producer/HeardHunter03.vcd" }  //Oaohhh, hunter. (disgusted)
		{ scenename = "scenes/Producer/HeardHunter04.vcd" }  //There's a Hunter out there.
		{ scenename = "scenes/Producer/HeardHunter05.vcd" }  //A hunter's around, don't get pounced.
		{ scenename = "scenes/Producer/HeardHunter06.vcd" }  //I hear a Hunter.
	],
	group_params = none
}

{
	name = "iMT_PlayerHeardHunterC1Producer",
	criteria =
	[
		[ "concept", "PlayerHeardHunter" ], [ "who", "Producer" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkProducer ], [ IsWorldTalkProducer ], [ C1M1orC1M2 ], [ IsNotSurvival ], [ NoKnowHunter ]
	],
	responses = PlayerHeardSpecialC1Producer,
	group_params = none
}

{
	name = "iMT_PlayerHeardJockeyProducer",
	criteria =
	[
		[ "concept", "PlayerHeardJockey" ], [ "who", "Producer" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkProducer ], [ IsWorldTalkProducer ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/HeardJockey01.vcd" }  //I hear a jockey.
		{ scenename = "scenes/Producer/HeardJockey02.vcd" }  //Oh shit, I hear a jockey.
		{ scenename = "scenes/Producer/HeardJockey03.vcd" }  //I hear one of those little things.
		{ scenename = "scenes/Producer/HeardJockey04.vcd" }  //Jockey around.
	],
	group_params = none
}

{
	name = "iMT_PlayerHeardJockeyC1Producer",
	criteria =
	[
		[ "concept", "PlayerHeardJockey" ], [ "who", "Producer" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkProducer ], [ IsWorldTalkProducer ], [ C1M1orC1M2 ], [ IsNotSurvival ], [ NoKnowJockey ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/HeardJockeyC101.vcd" }  //Uh oh, I hear one of those, what do you call it? A jockey?
	],
	group_params = none
}

{
	name = "iMT_PlayerHeardSmokerProducer",
	criteria =
	[
		[ "concept", "PlayerHeardSmoker" ], [ "who", "Producer" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkProducer ], [ IsWorldTalkProducer ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/HeardSmoker01.vcd" }  //There's a Smoker around here.
		{ scenename = "scenes/Producer/HeardSmoker02.vcd" }  //Careful, Smoker.
		{ scenename = "scenes/Producer/HeardSmoker03.vcd" }  //I hear a smoker.
		{ scenename = "scenes/Producer/HeardSmoker04.vcd" }  //Oh lord, not another smoker.
		{ scenename = "scenes/Producer/HeardSmoker05.vcd" }  //Careful, Smoker.
	],
	group_params = none
}

{
	name = "iMT_PlayerHeardSmokerC1Producer",
	criteria =
	[
		[ "concept", "PlayerHeardSmoker" ], [ "who", "Producer" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkProducer ], [ IsWorldTalkProducer ], [ C1M1orC1M2 ], [ IsNotSurvival ], [ NoKnowSmoker ]
	],
	responses = PlayerHeardSpecialC1Producer,
	group_params = none
}

{
	name = "iMT_PlayerHeardSpitterProducer",
	criteria =
	[
		[ "concept", "PlayerHeardSpitter" ], [ "who", "Producer" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkProducer ], [ IsWorldTalkProducer ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/HeardSpitter01.vcd" }  //Spitter around.
		{ scenename = "scenes/Producer/HeardSpitter02.vcd" }  //I hear a spitter.
		{ scenename = "scenes/Producer/HeardSpitter03.vcd" }  //I hear one of those spitter things.
		{ scenename = "scenes/Producer/HeardSpitter04.vcd" }  //Spitter around.
		{ scenename = "scenes/Producer/HeardSpitter05.vcd" }  //I hear a spitter.
		{ scenename = "scenes/Producer/HeardSpitter06.vcd" }  //I hear one of those spitting things.
	],
	group_params = none
}

{
	name = "iMT_PlayerHeardSpitterC1Producer",
	criteria =
	[
		[ "concept", "PlayerHeardSpitter" ], [ "who", "Producer" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkProducer ], [ IsWorldTalkProducer ], [ C1M1orC1M2 ], [ IsNotSurvival ], [ NoKnowSpitter ]
	],
	responses = PlayerHeardSpecialC1Producer,
	group_params = none
}

{
	name = "iMT_PlayerHeardWitchProducer",
	criteria =
	[
		[ "concept", "PlayerHeardWitch" ], [ "who", "Producer" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkProducer ], [ IsWorldTalkProducer ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/HeardWitch01.vcd" }  //That sounds like a Witch.
		{ scenename = "scenes/Producer/HeardWitch02.vcd" }  //I hear a witch crying.
		{ scenename = "scenes/Producer/HeardWitch03.vcd" }  //I'm gonna give that witch something to cry about.
		{ scenename = "scenes/Producer/HeardWitch04.vcd" }  //Listen up, a witch!
	],
	group_params = none
}

{
	name = "iMT_PlayerHeardWitchC1Producer",
	criteria =
	[
		[ "concept", "PlayerHeardWitch" ], [ "who", "Producer" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkProducer ], [ IsWorldTalkProducer ], [ C1M1orC1M2 ], [ IsNotSurvival ], [ NoKnowWitch ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/HeardWitchC102.vcd" }  //What the hell's with that crying?
	],
	group_params = none
}

{
	name = "iMT_PlayerLaughProducer",
	criteria =
	[
		[ "concept", "PlayerLaugh" ], [ "who", "Producer" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkProducer ], [ IsWorldTalkProducer ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/Laughter01.vcd" }  //<Short laugh>
		{ scenename = "scenes/Producer/Laughter02.vcd" }  //[Laughter]
		{ scenename = "scenes/Producer/Laughter04.vcd" }  //<Hearty laugh>
		{ scenename = "scenes/Producer/Laughter05.vcd" }  //[Laughter]
		{ scenename = "scenes/Producer/Laughter06.vcd" }  //[Laughter]
		{ scenename = "scenes/Producer/Laughter08.vcd" }  //[Laughter]
		{ scenename = "scenes/Producer/Laughter12.vcd" }  //<Short laugh>
		{ scenename = "scenes/Producer/Laughter13.vcd" }  //<Hearty laugh>
		{ scenename = "scenes/Producer/Laughter16.vcd" }  //[Laughter]
	],
	group_params = none
}

{
	name = "iMT_PlayerLaughAloneProducer",
	criteria =
	[
		[ "concept", "PlayerLaugh" ], [ "who", "Producer" ], [ "coughing", 0 ], [ "numberofteamalive", 1 ], [ "onthirdstrike", 1 ], [ IsTalk ], [ IsTalkProducer ], [ IsWorldTalkProducer ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/Laughter07.vcd" }  //[Laughter]
		{ scenename = "scenes/Producer/Laughter10.vcd" }  //[Laughter]
	],
	group_params = none
}

{
	name = "iMT_PlayerRelaxedSighProducer",
	criteria =
	[
		[ "concept", "RelaxedSigh" ], [ "who", "Producer" ], [ "speaking", 1 ]
	],
	responses =
	[
		{ scenename = "" }
	],
	group_params = none
}

{
	name = "iMT_PlayerThanksCoachProducer",
	criteria =
	[
		[ "concept", "PlayerThanks" ], [ "who", "Producer" ], [ "coughing", 0 ], [ "subject", "Coach" ], [ "dist_from_subject", 0, 99 ], [ "randomnum", 0, 30 ], [ IsTalk ], [ IsTalkProducer ], [ IsWorldTalkProducer ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/ThanksCoach01.vcd" }  //Thanks, my brother.
		{ scenename = "scenes/Producer/ThanksCoach02.vcd" }  //Thanks, Coach!
	],
	group_params = none
}

{
	name = "iMT_PlayerThanksCoachC1Producer",
	criteria =
	[
		[ "concept", "PlayerThanks" ], [ "who", "Producer" ], [ "coughing", 0 ], [ "subject", "Coach" ], [ "dist_from_subject", 0, 99 ], [ "map", "c1m1_hotel" ], [ "randomnum", 0, 30 ], [ IsTalk ], [ IsTalkProducer ], [ IsWorldTalkProducer ], [ NoKnowNames ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/NameCoach201.vcd" }  //You're a heart of gold, fat man.
	],
	group_params = none
}

{
	name = "iMT_PlayerThanksGamblerProducer",
	criteria =
	[
		[ "concept", "PlayerThanks" ], [ "who", "Producer" ], [ "coughing", 0 ], [ "subject", "Gambler" ], [ "dist_from_subject", 0, 99 ], [ "randomnum", 0, 5 ], [ IsTalk ], [ IsTalkProducer ], [ IsWorldTalkProducer ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/ThanksNick01.vcd" }  //Look at you Nick, you have a heart, A HEART OF GOLD!
	],
	group_params = none
}

{
	name = "iMT_PlayerThanksGamblerC1Producer",
	criteria =
	[
		[ "concept", "PlayerThanks" ], [ "who", "Producer" ], [ "coughing", 0 ], [ "subject", "Gambler" ], [ "dist_from_subject", 0, 99 ], [ "map", "c1m1_hotel" ], [ IsTalk ], [ IsTalkProducer ], [ IsWorldTalkProducer ], [ NoKnowNames ]
	],
	responses = PlayerThanksProducer,
	group_params = none
}

{
	name = "iMT_PlayerThanksMechanicProducer",
	criteria =
	[
		[ "concept", "PlayerThanks" ], [ "who", "Producer" ], [ "coughing", 0 ], [ "subject", "Mechanic" ], [ "dist_from_subject", 0, 99 ], [ "randomnum", 0, 30 ], [ IsTalk ], [ IsTalkProducer ], [ IsWorldTalkProducer ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/ThanksEllis01.vcd" }  //Thanks Ellis, I guess I will keep you.
	],
	group_params = none
}

{
	name = "iMT_PlayerThanksMechanicC1Producer",
	criteria =
	[
		[ "concept", "PlayerThanks" ], [ "who", "Producer" ], [ "coughing", 0 ], [ "subject", "Mechanic" ], [ "dist_from_subject", 0, 99 ], [ "map", "c1m1_hotel" ], [ IsTalk ], [ IsTalkProducer ], [ IsWorldTalkProducer ], [ NoKnowNames ]
	],
	responses = PlayerThanksProducer,
	group_params = none
}

{
	name = "iMT_PlayerThanksBikerProducer",
	criteria =
	[
		[ "concept", "PlayerThanks" ], [ "who", "Producer" ], [ "coughing", 0 ], [ "subject", "Biker" ], [ "dist_from_subject", 0, 599 ], [ "randomnum", 0, 30 ], [ IsTalk ], [ IsTalkProducer ], [ IsWorldTalkProducer ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/DLC1_C6M3_FinaleL4D1Items06.vcd" }  //Thanks Francis.
		{ scenename = "scenes/Producer/DLC1_C6M3_FinaleL4D1Killing06.vcd" }  //Thanks Francis!
	],
	group_params = none
}

{
	name = "iMT_PlayerThanksBiker%Producer",
	criteria =
	[
		[ "concept", "PlayerThanks" ], [ "who", "Producer" ], [ "coughing", 0 ], [ "subject", "Biker" ], [ "dist_from_subject", 0, 599 ], [ "randomnum", 31, 35 ], [ IsTalk ], [ IsTalkProducer ], [ IsWorldTalkProducer ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/DLC1_C6M3_FinaleL4D1Items08.vcd" }  //Thanks sexy guy in the vest.
	],
	group_params = none
}

{
	name = "iMT_PlayerThanksBikerC1Producer",
	criteria =
	[
		[ "concept", "PlayerThanks" ], [ "who", "Producer" ], [ "coughing", 0 ], [ "subject", "Biker" ], [ "dist_from_subject", 0, 599 ], [ "map", "c1m1_hotel" ], [ IsTalk ], [ IsTalkProducer ], [ IsWorldTalkProducer ], [ NoKnowNames ]
	],
	responses = PlayerThanksProducer,
	group_params = none
}

{
	name = "iMT_PlayerThanksTeenGirlProducer",
	criteria =
	[
		[ "concept", "PlayerThanks" ], [ "who", "Producer" ], [ "coughing", 0 ], [ "subject", "TeenGirl" ], [ "dist_from_subject", 0, 599 ], [ "randomnum", 0, 30 ], [ IsTalk ], [ IsTalkProducer ], [ IsWorldTalkProducer ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/DLC1_C6M3_FinaleL4D1Items01.vcd" }  //Thanks Zoey!
		{ scenename = "scenes/Producer/DLC1_C6M3_FinaleL4D1Items02.vcd" }  //Thanks Zoey!
		{ scenename = "scenes/Producer/DLC1_C6M3_FinaleL4D1Items03.vcd" }  //Thanks for the help Zoey!
		{ scenename = "scenes/Producer/DLC1_C6M3_FinaleL4D1Killing07.vcd" }  //Thanks Zoey!
	],
	group_params = none
}

{
	name = "iMT_PlayerThanksTeenGirlC1Producer",
	criteria =
	[
		[ "concept", "PlayerThanks" ], [ "who", "Producer" ], [ "coughing", 0 ], [ "subject", "TeenGirl" ], [ "dist_from_subject", 0, 599 ], [ "map", "c1m1_hotel" ], [ IsTalk ], [ IsTalkProducer ], [ IsWorldTalkProducer ], [ NoKnowNames ]
	],
	responses = PlayerThanksProducer,
	group_params = none
}

{
	name = "iMT_PlayerToTheRescueHurtProducer",
	criteria =
	[
		[ "concept", "PlayerToTheRescue" ], [ "who", "Producer" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkProducer ], [ IsWorldTalkProducer ], [ IsNotHealthy ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/GoingToDie22.vcd" }  //Movin' as fast as I can.
		{ scenename = "scenes/Producer/GoingToDie23.vcd" }  //Sorry guys, I can't go any faster.
		{ scenename = "scenes/Producer/GoingToDie24.vcd" }  //Going as fast as I can.
	],
	group_params = none
}

{
	name = "iMT_PlayerYouAreWelcomeCoachProducer",
	criteria =
	[
		[ "concept", "PlayerYouAreWelcome" ], [ "who", "Producer" ], [ "coughing", 0 ], [ "subject", "Coach" ], [ "dist_from_subject", 0, 99 ], [ "randomnum", 0, 30 ], [ IsTalk ], [ IsTalkProducer ], [ IsWorldTalkProducer ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/YouAreWelcomeCoach01.vcd" }  //Anything for a brother.
		{ scenename = "scenes/Producer/YouAreWelcomeCoach02.vcd" }  //Anything for a brother.
	],
	group_params = none
}

{
	name = "iMT_PlayerYouAreWelcomeCoachC1Producer",
	criteria =
	[
		[ "concept", "PlayerYouAreWelcome" ], [ "who", "Producer" ], [ "coughing", 0 ], [ "subject", "Coach" ], [ "dist_from_subject", 0, 99 ], [ "map", "c1m1_hotel" ], [ "randomnum", 0, 30 ], [ IsTalk ], [ IsTalkProducer ], [ IsWorldTalkProducer ], [ NoKnowNames ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/NameCoach202.vcd" }  //It's okay, ya know? You got a heart of gold, fat man.
	],
	group_params = none
}

{
	name = "iMT_PlayerYouAreWelcomeGamblerProducer",
	criteria =
	[
		[ "concept", "PlayerYouAreWelcome" ], [ "who", "Producer" ], [ "coughing", 0 ], [ "subject", "Gambler" ], [ "dist_from_subject", 0, 99 ], [ "randomnum", 0, 30 ], [ IsTalk ], [ IsTalkProducer ], [ IsWorldTalkProducer ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/YouAreWelcomeNick01.vcd" }  //No problem suit.
	],
	group_params = none
}

{
	name = "iMT_PlayerYouAreWelcomeMechanicProducer",
	criteria =
	[
		[ "concept", "PlayerYouAreWelcome" ], [ "who", "Producer" ], [ "coughing", 0 ], [ "subject", "Mechanic" ], [ "dist_from_subject", 0, 99 ], [ "randomnum", 0, 30 ], [ IsTalk ], [ IsTalkProducer ], [ IsWorldTalkProducer ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/YouAreWelcomeEllis01.vcd" }  //No problem shorty.
	],
	group_params = none
}

{
	name = "iMT_ResponseSoftDispleasureSwearProducer",
	criteria =
	[
		[ "concept", "ResponseSoftDispleasureSwear" ], [ "who", "Producer" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkProducer ], [ IsWorldTalkProducer ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/WorldC1M2B18.vcd" }  //Oh... my... GOD.
		{ scenename = "scenes/Producer/WorldC1M3B28.vcd" }  //Oh, damn it, I knew it.
	],
	group_params = none
}

{
	name = "iMT_ResponseSoftDispleasureSwear%Producer",
	criteria =
	[
		[ "concept", "ResponseSoftDispleasureSwear" ], [ "who", "Producer" ], [ "coughing", 0 ], [ "randomnum", 0, 30 ], [ IsTalk ], [ IsTalkProducer ], [ IsWorldTalkProducer ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/MeleeResponse03.vcd" }  //Damn!
	],
	group_params = none
}

{
	name = "iMT_SurvivorCoughingDeathProducer",
	criteria =
	[
		[ "concept", "PlayerDeath" ], [ "who", "Producer" ], [ "coughing", 1 ], [ IsTalk ], [ IsTalkProducer ], [ IsWorldTalkProducer ]
	],
	responses = SurvivorCoughingProducer,
	group_params = none
}

{
	name = "iMT_SurvivorDeathProducer",
	criteria =
	[
		[ "concept", "PlayerDeath" ], [ "who", "Producer" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkProducer ], [ IsWorldTalkProducer ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/DeathScream01.vcd" }  //[Short quick death scream]
		{ scenename = "scenes/Producer/DeathScream02.vcd" }  //[Loud painful death scream]
	],
	group_params = none
}

{
	name = "iMT_SurvivorSpottedAmmoProducer",
	criteria =
	[
		[ "concept", "PlayerSpotAmmo" ], [ "who", "Producer" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkProducer ], [ IsWorldTalkProducer ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/SpotAmmo01.vcd" }  //Ammo!
		{ scenename = "scenes/Producer/SpotAmmo02.vcd" }  //Ammo here!
		{ scenename = "scenes/Producer/SpotAmmo03.vcd" }  //Ammo here!
		{ scenename = "scenes/Producer/SpotAmmo04.vcd" }  //Ammo here!
		{ scenename = "scenes/Producer/SpotAmmo05.vcd" }  //Ammunition!
	],
	group_params = none
}

{
	name = "iMT_SurvivorSpottedBoomerProducer",
	criteria =
	[
		[ "concept", "PlayerWarnBoomer" ], [ "who", "Producer" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkProducer ], [ IsWorldTalkProducer ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/WarnBoomer01.vcd" }  //BOOMER!
		{ scenename = "scenes/Producer/WarnBoomer02.vcd" }  //BOOMER!
		{ scenename = "scenes/Producer/WarnBoomer03.vcd" }  //BOOMER!
	],
	group_params = none
}

{
	name = "iMT_SurvivorSpottedBoomer%Producer",
	criteria =
	[
		[ "concept", "PlayerWarnBoomer" ], [ "who", "Producer" ], [ "coughing", 0 ], [ "randomnum", 0, 20 ], [ IsTalk ], [ IsTalkProducer ], [ IsWorldTalkProducer ]
	],
	responses = SurvivorSpottedBoomerC1Producer,
	group_params = none
}

{
	name = "iMT_SurvivorSpottedBoomerC1Producer",
	criteria =
	[
		[ "concept", "PlayerWarnBoomer" ], [ "who", "Producer" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkProducer ], [ IsWorldTalkProducer ], [ C1M1orC1M2 ], [ IsNotSurvival ], [ NoKnowBoomer ]
	],
	responses = SurvivorSpottedBoomerC1Producer,
	group_params = none
}

{
	name = "iMT_SurvivorSpottedChargerProducer",
	criteria =
	[
		[ "concept", "PlayerWarnCharger" ], [ "who", "Producer" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkProducer ], [ IsWorldTalkProducer ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/WarnCharger01.vcd" }  //CHARGER!
		{ scenename = "scenes/Producer/WarnCharger02.vcd" }  //CHARGER!
		{ scenename = "scenes/Producer/WarnCharger03.vcd" }  //CHARGER!
	],
	group_params = none
}

{
	name = "iMT_SurvivorSpottedCharger%Producer",
	criteria =
	[
		[ "concept", "PlayerWarnCharger" ], [ "who", "Producer" ], [ "coughing", 0 ], [ "randomnum", 0, 20 ], [ IsTalk ], [ IsTalkProducer ], [ IsWorldTalkProducer ]
	],
	responses = SurvivorSpottedChargerC1Producer,
	group_params = none
}

{
	name = "iMT_SurvivorSpottedChargerC1Producer",
	criteria =
	[
		[ "concept", "PlayerWarnCharger" ], [ "who", "Producer" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkProducer ], [ IsWorldTalkProducer ], [ C1M1orC1M2 ], [ IsNotSurvival ], [ NoKnowCharger ]
	],
	responses = SurvivorSpottedChargerC1Producer,
	group_params = none
}

{
	name = "iMT_SurvivorSpottedHunterProducer",
	criteria =
	[
		[ "concept", "PlayerWarnHunter" ], [ "who", "Producer" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkProducer ], [ IsWorldTalkProducer ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/WarnHunter01.vcd" }  //HUNTER!
		{ scenename = "scenes/Producer/WarnHunter02.vcd" }  //HUNTER!
		{ scenename = "scenes/Producer/WarnHunter03.vcd" }  //HUNTER!
	],
	group_params = none
}

{
	name = "iMT_SurvivorSpottedHunter%Producer",
	criteria =
	[
		[ "concept", "PlayerWarnHunter" ], [ "who", "Producer" ], [ "coughing", 0 ], [ "randomnum", 0, 20 ], [ IsTalk ], [ IsTalkProducer ], [ IsWorldTalkProducer ]
	],
	responses = SurvivorSpottedHunterC1Producer,
	group_params = none
}

{
	name = "iMT_SurvivorSpottedHunterC1Producer",
	criteria =
	[
		[ "concept", "PlayerWarnHunter" ], [ "who", "Producer" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkProducer ], [ IsWorldTalkProducer ], [ C1M1orC1M2 ], [ IsNotSurvival ], [ NoKnowHunter ]
	],
	responses = SurvivorSpottedHunterC1Producer,
	group_params = none
}

{
	name = "iMT_SurvivorSpottedInfectedProducer",
	criteria =
	[
		[ "concept", "PlayerIncoming" ], [ "who", "Producer" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkProducer ], [ IsWorldTalkProducer ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/Incoming01.vcd" }  //They're coming!
		{ scenename = "scenes/Producer/Incoming02.vcd" }  //Get ready!
		{ scenename = "scenes/Producer/Incoming03.vcd" }  //Here they come!
		{ scenename = "scenes/Producer/Incoming04.vcd" }  //Ah, it's on now!
		{ scenename = "scenes/Producer/Incoming05.vcd" }  //Party time!
		{ scenename = "scenes/Producer/Incoming06.vcd" }  //Time to kick some ass.
		{ scenename = "scenes/Producer/Incoming07.vcd" }  //Incoming!
		{ scenename = "scenes/Producer/Incoming08.vcd" }  //This is it!
	],
	group_params = none
}

{
	name = "iMT_SurvivorSpottedJockeyProducer",
	criteria =
	[
		[ "concept", "PlayerWarnJockey" ], [ "who", "Producer" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkProducer ], [ IsWorldTalkProducer ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/WarnJockey01.vcd" }  //JOCKEY!
		{ scenename = "scenes/Producer/WarnJockey03.vcd" }  //JOCKEY!
	],
	group_params = none
}

{
	name = "iMT_SurvivorSpottedJockey%Producer",
	criteria =
	[
		[ "concept", "PlayerWarnJockey" ], [ "who", "Producer" ], [ "coughing", 0 ], [ "randomnum", 0, 20 ], [ IsTalk ], [ IsTalkProducer ], [ IsWorldTalkProducer ]
	],
	responses = SurvivorSpottedJockeyC1Producer,
	group_params = none
}

{
	name = "iMT_SurvivorSpottedJockeyC1Producer",
	criteria =
	[
		[ "concept", "PlayerWarnJockey" ], [ "who", "Producer" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkProducer ], [ IsWorldTalkProducer ], [ C1M1orC1M2 ], [ IsNotSurvival ], [ NoKnowJockey ]
	],
	responses = SurvivorSpottedJockeyC1Producer,
	group_params = none
}

{
	name = "iMT_SurvivorSpottedSmokerProducer",
	criteria =
	[
		[ "concept", "PlayerWarnSmoker" ], [ "who", "Producer" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkProducer ], [ IsWorldTalkProducer ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/WarnSmoker01.vcd" }  //SMOKER!
		{ scenename = "scenes/Producer/WarnSmoker02.vcd" }  //SMOKER!
		{ scenename = "scenes/Producer/WarnSmoker03.vcd" }  //SMOKER!
	],
	group_params = none
}

{
	name = "iMT_SurvivorSpottedSmoker%Producer",
	criteria =
	[
		[ "concept", "PlayerWarnSmoker" ], [ "who", "Producer" ], [ "coughing", 0 ], [ "randomnum", 0, 20 ], [ IsTalk ], [ IsTalkProducer ], [ IsWorldTalkProducer ]
	],
	responses = SurvivorSpottedSmokerC1Producer,
	group_params = none
}

{
	name = "iMT_SurvivorSpottedSmokerC1Producer",
	criteria =
	[
		[ "concept", "PlayerWarnSmoker" ], [ "who", "Producer" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkProducer ], [ IsWorldTalkProducer ], [ C1M1orC1M2 ], [ IsNotSurvival ], [ NoKnowSmoker ]
	],
	responses = SurvivorSpottedSmokerC1Producer,
	group_params = none
}

{
	name = "iMT_SurvivorSpottedSpitterProducer",
	criteria =
	[
		[ "concept", "PlayerWarnSpitter" ], [ "who", "Producer" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkProducer ], [ IsWorldTalkProducer ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/WarnSpitter01.vcd" }  //SPITTER!
		{ scenename = "scenes/Producer/WarnSpitter02.vcd" }  //SPITTER!
		{ scenename = "scenes/Producer/WarnSpitter03.vcd" }  //SPITTER!
	],
	group_params = none
}

{
	name = "iMT_SurvivorSpottedSpitter%Producer",
	criteria =
	[
		[ "concept", "PlayerWarnSpitter" ], [ "who", "Producer" ], [ "coughing", 0 ], [ "randomnum", 0, 20 ], [ IsTalk ], [ IsTalkProducer ], [ IsWorldTalkProducer ]
	],
	responses = SurvivorSpottedSpitterC1Producer,
	group_params = none
}

{
	name = "iMT_SurvivorSpottedSpitterC1Producer",
	criteria =
	[
		[ "concept", "PlayerWarnSpitter" ], [ "who", "Producer" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkProducer ], [ IsWorldTalkProducer ], [ C1M1orC1M2 ], [ IsNotSurvival ], [ NoKnowSpitter ]
	],
	responses = SurvivorSpottedSpitterC1Producer,
	group_params = none
}

{
	name = "iMT_SurvivorSpottedTankProducer",
	criteria =
	[
		[ "concept", "PlayerWarnTank" ], [ "who", "Producer" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkProducer ], [ IsWorldTalkProducer ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/HeardHulk01.vcd" }  //Ahhh SHIT TANK!!!
		{ scenename = "scenes/Producer/HeardHulk02.vcd" }  //TANK! Light it up!
		{ scenename = "scenes/Producer/HeardHulk03.vcd" }  //TANK!
		{ scenename = "scenes/Producer/HeardHulk04.vcd" }  //Tank! Tank!
		{ scenename = "scenes/Producer/WarnTank01.vcd" }  //TANK!
		{ scenename = "scenes/Producer/WarnTank02.vcd" }  //TANK!
		{ scenename = "scenes/Producer/WarnTank03.vcd" }  //TANK!
		{ scenename = "scenes/Producer/WarnTank04.vcd" }  //TANK!
	],
	group_params = none
}

{
	name = "iMT_SurvivorSpottedTank%Producer",
	criteria =
	[
		[ "concept", "PlayerWarnTank" ], [ "who", "Producer" ], [ "coughing", 0 ], [ "randomnum", 0, 10 ], [ IsTalk ], [ IsTalkProducer ], [ IsWorldTalkProducer ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/WarnTankC101.vcd" }  //Why can't that thing be on our side?
		{ scenename = "scenes/Producer/WarnTankC103.vcd" }  //OH GODDAMN that thing's big!
	],
	group_params = none
}

{
	name = "iMT_SurvivorSpottedTankC1Producer",
	criteria =
	[
		[ "concept", "PlayerWarnTank" ], [ "who", "Producer" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkProducer ], [ IsWorldTalkProducer ], [ C1M1orC1M2 ], [ IsNotSurvival ], [ NoKnowTank ], [ AddWeight ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/WarnTankC101.vcd" }  //Why can't that thing be on our side?
		{ scenename = "scenes/Producer/WarnTankC102.vcd" }  //HOLY SHIT WHAT'S THAT?!?!
		{ scenename = "scenes/Producer/WarnTankC103.vcd" }  //OH GODDAMN that thing's big!
		{ scenename = "scenes/Producer/WarnTankC104.vcd" }  //HOLY SHIT WHAT'S THAT?!?!
	],
	group_params = none
}

{
	name = "iMT_SurvivorSpottedTanksProducer",
	criteria =
	[
		[ "concept", "PlayerWarnTank" ], [ "who", "Producer" ], [ "coughing", 0 ], [ "tankactive", 1 ], [ IsTalk ], [ IsTalkProducer ], [ IsWorldTalkProducer ], [ IsZombiePresentTanks ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/DLC1_L4D1Tank04.vcd" }  //Boys we got tanks!
		{ scenename = "scenes/Producer/DLC1_L4D1Tank07.vcd" }  //TANKS!
	],
	group_params = none
}

{
	name = "iMT_SurvivorSpottedTanks2Producer",
	criteria =
	[
		[ "concept", "PlayerWarnTank" ], [ "who", "Producer" ], [ "coughing", 0 ], [ "tankactive", 1 ], [ "randomnum", 0, 66 ], [ IsTalk ], [ IsTalkProducer ], [ IsWorldTalkProducer ], [ IsZombiePresentTanks2 ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/DLC1_L4D1Tank03.vcd" }  //Two tanks!
		{ scenename = "scenes/Producer/DLC1_L4D1Tank06.vcd" }  //We got two too many tanks.
	],
	group_params = none
}

{
	name = "iMT_SurvivorSpottedWeaponsProducer",
	criteria =
	[
		[ "concept", "PlayerSpotOtherWeapon" ], [ "who", "Producer" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkProducer ], [ IsWorldTalkProducer ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/SpotWeapons01.vcd" }  //Weapons over here!
		{ scenename = "scenes/Producer/SpotWeapons02.vcd" }  //Weapons over here!
		{ scenename = "scenes/Producer/SpotWeapons03.vcd" }  //All right weapons!
		{ scenename = "scenes/Producer/SpotWeapons04.vcd" }  //We have guns here!
	],
	group_params = none
}

{
	name = "iMT_SurvivorSpottedWitchProducer",
	criteria =
	[
		[ "concept", "PlayerWarnWitch" ], [ "who", "Producer" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkProducer ], [ IsWorldTalkProducer ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/WarnWitch01.vcd" }  //WITCH!
		{ scenename = "scenes/Producer/WarnWitch02.vcd" }  //WITCH!
		{ scenename = "scenes/Producer/WarnWitch03.vcd" }  //WITCH!
		{ scenename = "scenes/Producer/WarnWitch04.vcd" }  //WITCH!
	],
	group_params = none
}

{
	name = "iMT_SurvivorSpottedWitchC1Producer",
	criteria =
	[
		[ "concept", "PlayerWarnWitch" ], [ "who", "Producer" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkProducer ], [ IsWorldTalkProducer ], [ C1M1orC1M2 ], [ IsNotSurvival ], [ NoKnowWitch ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/HeardWitchC101.vcd" }  //She doesn't sound happy.
		{ scenename = "scenes/Producer/HeardWitchC103.vcd" }  //We should steer clear of her.
	],
	group_params = none
}

{
	name = "iMT_SurvivorTauntResponseProducer",
	criteria =
	[
		[ "concept", "PlayerTaunt" ], [ "who", "Producer" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkProducer ], [ IsWorldTalkProducer ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/Taunt01.vcd" }  //Who's barking now?
		{ scenename = "scenes/Producer/Taunt02.vcd" }  //Oh hell yes!
		{ scenename = "scenes/Producer/Taunt03.vcd" }  //What's up with that?
		{ scenename = "scenes/Producer/Taunt04.vcd" }  //Where's the love, where's the love?!
		{ scenename = "scenes/Producer/Taunt05.vcd" }  //Yeah right.
		{ scenename = "scenes/Producer/Taunt06.vcd" }  //Yeah, thats right. [grim, determined]
		{ scenename = "scenes/Producer/Taunt07.vcd" }  //Forget about it.
		{ scenename = "scenes/Producer/Taunt08.vcd" }  //Ohhh shut up!
	],
	group_params = none
}

{
	name = "iMT_SurvivorVocalizeBackUpProducer",
	criteria =
	[
		[ "concept", "PlayerBackUp" ], [ "who", "Producer" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkProducer ], [ IsWorldTalkProducer ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/BackUp01.vcd" }  //Back back back!
		{ scenename = "scenes/Producer/BackUp02.vcd" }  //Come on move, move back.
		{ scenename = "scenes/Producer/BackUp03.vcd" }  //Back it up! Back it up!
		{ scenename = "scenes/Producer/BackUp04.vcd" }  //Let's back it up!
	],
	group_params = none
}

{
	name = "iMT_SurvivorVocalizeBackUpC4M2Producer",
	criteria =
	[
		[ "concept", "PlayerBackUp" ], [ "who", "Producer" ], [ "coughing", 0 ], [ "tankactive", 0 ], [ "map", "c4m2_sugarmill_a" ], [ "world_auto_producerinwitchville", 1 ], [ IsTalk ], [ IsTalkProducer ], [ IsWorldTalkProducer ], [ IsNotSaidSafeSpotAhead ]
	],
	responses = SurvivorVocalizeBackUpQuietProducer,
	group_params = none
}

{
	name = "iMT_SurvivorVocalizeBackUpQuietProducer",
	criteria =
	[
		[ "concept", "PlayerBackUp" ], [ "who", "Producer" ], [ "coughing", 0 ], [ "tankactive", 0 ], [ "incombatmusic", 0 ], [ IsTalk ], [ IsTalkProducer ], [ IsWorldTalkProducer ], [ IsWitchNear ], [ IsNotWitchAggro ]
	],
	responses = SurvivorVocalizeBackUpQuietProducer,
	group_params = none
}

{
	name = "iMT_SurvivorVocalizeEmphaticGoProducer",
	criteria =
	[
		[ "concept", "PlayerEmphaticGo" ], [ "who", "Producer" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkProducer ], [ IsWorldTalkProducer ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/EmphaticGo01.vcd" }  //What are you doing? GO!
		{ scenename = "scenes/Producer/EmphaticGo02.vcd" }  //Come on, come on, let's move!
		{ scenename = "scenes/Producer/EmphaticGo03.vcd" }  //Come on, come on, let's move!
		{ scenename = "scenes/Producer/EmphaticGo04.vcd" }  //Well, go!
		{ scenename = "scenes/Producer/EmphaticGo05.vcd" }  //Go go go!
		{ scenename = "scenes/Producer/EmphaticGo06.vcd" }  //Go!
		{ scenename = "scenes/Producer/EmphaticGo07.vcd" }  //GO!
	],
	group_params = none
}

{
	name = "iMT_SurvivorVocalizeEmphaticGoC4M2Producer",
	criteria =
	[
		[ "concept", "PlayerEmphaticGo" ], [ "who", "Producer" ], [ "coughing", 0 ], [ "tankactive", 0 ], [ "map", "c4m2_sugarmill_a" ], [ "world_auto_producerinwitchville", 1 ], [ IsTalk ], [ IsTalkProducer ], [ IsWorldTalkProducer ], [ IsNotSaidSafeSpotAhead ]
	],
	responses = SurvivorVocalizeEmphaticGoQuietProducer,
	group_params = none
}

{
	name = "iMT_SurvivorVocalizeEmphaticGoQuietProducer",
	criteria =
	[
		[ "concept", "PlayerEmphaticGo" ], [ "who", "Producer" ], [ "coughing", 0 ], [ "tankactive", 0 ], [ "incombatmusic", 0 ], [ IsTalk ], [ IsTalkProducer ], [ IsWorldTalkProducer ], [ IsWitchNear ], [ IsNotWitchAggro ]
	],
	responses = SurvivorVocalizeEmphaticGoQuietProducer,
	group_params = none
}

{
	name = "iMT_SurvivorVocalizeLookOutProducer",
	criteria =
	[
		[ "concept", "PlayerLookOut" ], [ "who", "Producer" ], [ "coughing", 0 ], [ "world_auto_finale", 2 ], [ IsTalk ], [ IsTalkProducer ], [ IsWorldTalkProducer ]
	],
	responses =
	[
		{ scenename = "scenes/Producer/LookOut01.vcd" }  //Look out!
		{ scenename = "scenes/Producer/LookOut02.vcd" }  //Watch out!
		{ scenename = "scenes/Producer/LookOut03.vcd" }  //Heads up!
	],
	group_params = none
}

//--------------------------------------------------------------------------------------------------
// Start Area
//--------------------------------------------------------------------------------------------------

{
	name = "iMT_SafeRoomStartProducer",
	criteria =
	[
		[ "concept", "TLK_IDLE" ], [ "who", "Producer" ], [ "instartarea", 1 ], [ IsNotScavenge ], [ IsNotSurvival ], [ _auto_NotSafeRoomStart ]
	],
	responses =
	[
		{
			scenename = "scenes/Producer/Blank.vcd",
			applycontext =
			{
				c1 = { context = "_auto_saferoomstart", value = 1, duration = 0 }
				c2 = { context = "_auto_saferoomquiet", value = 1, duration = 5 }
				c3 = { context = "saidbotattention", value = 1, duration = 60 }
				c4 = { context = "suggestedhealth", value = 1, duration = 60 }
			},
			applycontexttoworld = true
		}
	],
	group_params = none
}

]

rr_ProcessRules( Producer )