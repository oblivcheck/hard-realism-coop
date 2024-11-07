//--------------------------------------------------------------------------------------------------
// ion's Vocalizer: Gambler Response Rules
//--------------------------------------------------------------------------------------------------

// Shared responses

local PlayerHeardSpecialC1Gambler =
[
	{ scenename = "scenes/Gambler/HeardSpecialC101.vcd" }  //Is someone beating a horse?
	{ scenename = "scenes/Gambler/HeardSpecialC102.vcd" }  //What is that? Is somebody beating a horse or what?
	{ scenename = "scenes/Gambler/HeardSpecialC103.vcd" }  //What in the hell is that noise?
	{ scenename = "scenes/Gambler/HeardSpecialC104.vcd" }  //You hear that? I guess zombies weren't bad enough.
	{ scenename = "scenes/Gambler/HeardSpecialC105.vcd" }  //You hear that?
	{ scenename = "scenes/Gambler/HeardSpecialC106.vcd" }  //Can you hear that?
	{ scenename = "scenes/Gambler/HeardSpecialC107.vcd" }  //What is that noise?
	{ scenename = "scenes/Gambler/HeardSpecialC108.vcd" }  //I have no idea what that noise is.
	{ scenename = "scenes/Gambler/HeardSpecialC109.vcd" }  //Something we're gonna have to kill.
]

local PlayerNiceShotGambler =
[
	{ scenename = "scenes/Gambler/NiceShot01.vcd" }  //Nice shot.
	{ scenename = "scenes/Gambler/NiceShot02.vcd" }  //Nice shot.
	{ scenename = "scenes/Gambler/NiceShot03.vcd" }  //How'dja do that?
	{ scenename = "scenes/Gambler/NiceShot04.vcd" }  //Nice shot.
	{ scenename = "scenes/Gambler/NiceShot05.vcd" }  //Good shooting.
	{ scenename = "scenes/Gambler/NiceShot06.vcd" }  //Nice shooting.
	{ scenename = "scenes/Gambler/NiceShot07.vcd" }  //Nice shot!
	{ scenename = "scenes/Gambler/NiceShot08.vcd" }  //Nice shot Ace.
	{ scenename = "scenes/Gambler/NiceShot09.vcd" }  //Impressive.
]

local PlayerPouncedC1Gambler =
[
	{ scenename = "scenes/Gambler/HunterPouncedC101.vcd" }  //Zombie's got him!
	{ scenename = "scenes/Gambler/HunterPouncedC102.vcd" }  //Zombie's got him!
	{ scenename = "scenes/Gambler/HunterPouncedC103.vcd" }  //Zombie on him!
]

local PlayerPouncedProducerC1Gambler =
[
	{ scenename = "scenes/Gambler/HunterPouncedC1Producer01.vcd" }  //Zombie on her!
	{ scenename = "scenes/Gambler/HunterPouncedC1Producer02.vcd" }  //Get that zombie off her!
]

local PlayerSuggestHealthC1Gambler =
[
	{ scenename = "scenes/Gambler/SuggestHealthC101.vcd" }  //This might be a good time to heal.
	{ scenename = "scenes/Gambler/SuggestHealthC102.vcd" }  //Time for people to heal.
	{ scenename = "scenes/Gambler/SuggestHealthC103.vcd" }  //Don't forget you can heal yourself.
	{ scenename = "scenes/Gambler/SuggestHealthC104.vcd" }  //This is a good time to heal.
	{ scenename = "scenes/Gambler/SuggestHealthC105.vcd" }  //Time for people to heal.
]

local SurvivorCoughingGambler =
[
	{ scenename = "scenes/Gambler/Cough01.vcd" }  //[Coughing from smoke]
	{ scenename = "scenes/Gambler/Cough02.vcd" }  //[Coughing from smoke]
	{ scenename = "scenes/Gambler/Cough03.vcd" }  //[Coughing from smoke]
	{ scenename = "scenes/Gambler/Cough04.vcd" }  //[Coughing from smoke]
]

local SurvivorMournCoachGambler =
[
	{ scenename = "scenes/Gambler/SurvivorMournCoach01.vcd" }  //Ahh Coach.
	{ scenename = "scenes/Gambler/SurvivorMournCoach02.vcd" }  //Later Coach.
	{ scenename = "scenes/Gambler/SurvivorMournCoach03.vcd" }  //Shit Coach, I'll miss you.
	{ scenename = "scenes/Gambler/SurvivorMournCoachC101.vcd" }  //I am going to miss you big guy.
	{ scenename = "scenes/Gambler/SurvivorMournCoachC102.vcd" }  //Goddamn it coach, what'd you leave me with?
	{ scenename = "scenes/Gambler/SurvivorMournCoachC103.vcd" }  //Goddamn it coach, what'd you leave me with?
]

local SurvivorMournCoachC1Gambler =
[
	{ scenename = "scenes/Gambler/SurvivorMournCoachC101.vcd" }  //I am going to miss you big guy.
	{ scenename = "scenes/Gambler/SurvivorMournCoachC102.vcd" }  //Goddamn it coach, what'd you leave me with?
	{ scenename = "scenes/Gambler/SurvivorMournCoachC103.vcd" }  //Goddamn it coach, what'd you leave me with?
]

local SurvivorMournMechanicGambler =
[
	{ scenename = "scenes/Gambler/SurvivorMournEllis01.vcd" }  //Ellis.
	{ scenename = "scenes/Gambler/SurvivorMournEllis02.vcd" }  //Ahh Ellis.
	{ scenename = "scenes/Gambler/SurvivorMournEllis03.vcd" }  //Ellis, I am surprised you lasted as long as you did.
	{ scenename = "scenes/Gambler/SurvivorMournMechanicC101.vcd" }  //He was annoying but he could shoot a gun.
	{ scenename = "scenes/Gambler/SurvivorMournMechanicC102.vcd" }  //No time for mourning, let's go.
	{ scenename = "scenes/Gambler/SurvivorMournMechanicC103.vcd" }  //He was annoying but he could shoot a gun.
]

local SurvivorMournMechanicC1Gambler =
[
	{ scenename = "scenes/Gambler/SurvivorMournMechanicC101.vcd" }  //He was annoying but he could shoot a gun.
	{ scenename = "scenes/Gambler/SurvivorMournMechanicC102.vcd" }  //No time for mourning, let's go.
	{ scenename = "scenes/Gambler/SurvivorMournMechanicC103.vcd" }  //He was annoying but he could shoot a gun.
]

local SurvivorMournProducerGambler =
[
	{ scenename = "scenes/Gambler/SurvivorMournProducerC101.vcd" }  //I can think of two other people I would have rather seen go first.
	{ scenename = "scenes/Gambler/SurvivorMournProducerC102.vcd" }  //Guys, what are we going to do now?
	{ scenename = "scenes/Gambler/SurvivorMournRochelle01.vcd" }  //Rochelle.
	{ scenename = "scenes/Gambler/SurvivorMournRochelle02.vcd" }  //Ahh shit Rochelle.
	{ scenename = "scenes/Gambler/SurvivorMournRochelle03.vcd" }  //Goodnight Rochelle.
	{ scenename = "scenes/Gambler/SurvivorMournRochelle04.vcd" }  //There goes repopulating the earth.
]

local SurvivorMournProducerC1Gambler =
[
	{ scenename = "scenes/Gambler/SurvivorMournProducerC101.vcd" }  //I can think of two other people I would have rather seen go first.
	{ scenename = "scenes/Gambler/SurvivorMournProducerC102.vcd" }  //Guys, what are we going to do now?
]

local SurvivorReloadingQuietGambler =
[
	{ scenename = "scenes/Gambler/ReloadingQuiet01.vcd" }  //Reloading.
	{ scenename = "scenes/Gambler/ReloadingQuiet02.vcd" }  //Reloading.
	{ scenename = "scenes/Gambler/ReloadingQuiet03.vcd" }  //Reloading.
]

local SurvivorSpottedBoomerC1Gambler =
[
	{ scenename = "scenes/Gambler/WarnBoomerC101.vcd" }  //Fat guy!
	{ scenename = "scenes/Gambler/WarnBoomerC102.vcd" }  //Goiter man!
	{ scenename = "scenes/Gambler/WarnBoomerC103.vcd" }  //Aunt bee.
	{ scenename = "scenes/Gambler/WarnBoomerC104.vcd" }  //Fatty!
	{ scenename = "scenes/Gambler/WarnBoomerC105.vcd" }  //Fat guy!
	{ scenename = "scenes/Gambler/WorldC1M1B71.vcd", speakonce = true }  //Watch out for the... the big fat thing!
	{ scenename = "scenes/Gambler/WorldC1M1B72.vcd", speakonce = true }  //It's the fat barf-bag!
]

local SurvivorSpottedChargerC1Gambler =
[
	{ scenename = "scenes/Gambler/WarnChargerC101.vcd" }  //One Arm!
	{ scenename = "scenes/Gambler/WarnChargerC102.vcd" }  //Overalls!
	{ scenename = "scenes/Gambler/WarnChargerC103.vcd" }  //Hillbilly!
	{ scenename = "scenes/Gambler/WorldC1M1B76.vcd", speakonce = true }  //It's that thing that runs at ya!
]

local SurvivorSpottedHunterC1Gambler =
[
	{ scenename = "scenes/Gambler/WarnHunterC101.vcd" }  //Jumper!
	{ scenename = "scenes/Gambler/WarnHunterC102.vcd" }  //Leaper!
	{ scenename = "scenes/Gambler/WarnHunterC103.vcd" }  //Scrawny little bitch I'm gonna kill.
	{ scenename = "scenes/Gambler/WorldC1M1B74.vcd", speakonce = true }  //It's that fast bastard that jumps at ya!
]

local SurvivorSpottedJockeyC1Gambler =
[
	{ scenename = "scenes/Gambler/WarnJockeyC101.vcd" }  //Little guy!
	{ scenename = "scenes/Gambler/WarnJockeyC102.vcd" }  //Little freak!
	{ scenename = "scenes/Gambler/WarnJockeyC103.vcd" }  //Little guy!
]

local SurvivorSpottedSmokerC1Gambler =
[
	{ scenename = "scenes/Gambler/WarnSmokerC101.vcd" }  //TONGUE!
	{ scenename = "scenes/Gambler/WarnSmokerC102.vcd" }  //The smoking thing!
]

local SurvivorSpottedSpitterC1Gambler =
[
	{ scenename = "scenes/Gambler/WarnSpitterC101.vcd" }  //Green thing!
	{ scenename = "scenes/Gambler/WarnSpitterC102.vcd" }  //Neck!
	{ scenename = "scenes/Gambler/WorldC1M1B78.vcd", speakonce = true }  //It's that bug-spitting bitch...
]

local SurvivorSpottedTankC1Gambler =
[
	{ scenename = "scenes/Gambler/WarnTankC101.vcd" }  //We have a problem!
	{ scenename = "scenes/Gambler/WarnTankC102.vcd" }  //HOLY SHIT! BIG FREAKING ZOMBIE!
	{ scenename = "scenes/Gambler/WarnTankC103.vcd" }  //We have a problem!
	{ scenename = "scenes/Gambler/WarnTankC104.vcd" }  //HOLY SHIT! BIG FREAKING ZOMBIE!
]

local SurvivorVocalizeBackUpQuietGambler =
[
	{ scenename = "scenes/Gambler/BackUpQuiet01.vcd" }  //Back up.
	{ scenename = "scenes/Gambler/BackUpQuiet02.vcd" }  //Everyone back.
	{ scenename = "scenes/Gambler/BackUpQuiet03.vcd" }  //Let's get back.
	{ scenename = "scenes/Gambler/BackUpQuiet04.vcd" }  //Back up, back up.
]

local SurvivorVocalizeEmphaticGoQuietGambler =
[
	{ scenename = "scenes/Gambler/EmphaticGoQuiet01.vcd" }  //Everybody keep moving.
	{ scenename = "scenes/Gambler/EmphaticGoQuiet02.vcd" }  //Just go.
	{ scenename = "scenes/Gambler/EmphaticGoQuiet03.vcd" }  //Just go. Go.
	{ scenename = "scenes/Gambler/EmphaticGoQuiet04.vcd" }  //Don't stop, don't stop.
	{ scenename = "scenes/Gambler/EmphaticGoQuiet05.vcd" }  //Keep moving.
]

//--------------------------------------------------------------------------------------------------
// Ellis Stories
//--------------------------------------------------------------------------------------------------

local Gambler =
[

{
	name = "iMT_EllisStoryInterruptGambler",
	criteria =
	[
		[ "concept", "iMT_EllisStoryInterrupt" ], [ "who", "Gambler" ], [ "world_auto_tellingstory", 1 ], [ "coughing", 0 ], [ "incapacitated", 0 ], [ "speaking", 0], [ IsTalk ], [ IsTalkGambler ], [ IsWorldTalkGambler ], [ IssuerCloseEnough ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/EllisInterrupt06.vcd", followup = RThen( "Mechanic", "iMT_EllisStoryReac", { from = "Gambler" }, 0.3 ) }  //Ellis... Ellis. ELLIS!
		{ scenename = "scenes/Gambler/EllisInterrupt07.vcd", followup = RThen( "Mechanic", "iMT_EllisStoryReac", { from = "Gambler" }, 0.3 ) }  //Hey. ELLIS. Why don't you tell us all about the time you SHUT UP?
		{ scenename = "scenes/Gambler/EllisInterrupt08.vcd", followup = RThen( "Mechanic", "iMT_EllisStoryReac", { from = "Gambler" }, 0.3 ) }  //Ellis. Is now the best time?
		{ scenename = "scenes/Gambler/EllisInterrupt09.vcd", followup = RThen( "Mechanic", "iMT_EllisStoryReac", { from = "Gambler" }, 0.3 ) }  //Uhhh. I don't CARE. NOBODY cares.
		{ scenename = "scenes/Gambler/EllisInterrupt10.vcd", followup = RThen( "Mechanic", "iMT_EllisStoryReac", { from = "Gambler" }, 0.3 ) }  //Ellis. If I listen to this, will this be the last one?
		{ scenename = "scenes/Gambler/EllisInterrupt12.vcd" }  //Ohhh, not again...
		{ scenename = "scenes/Gambler/EllisInterrupt19.vcd" }  //You know what I like best about your stories, Ellis? The sound they make when they stop.
		{ scenename = "scenes/Gambler/EllisInterrupt20.vcd" }  //You know what I like best about your stories, Ellis? NOTHING.
	],
	group_params = none
}

{
	name = "iMT_EllisStoryInterrupt%Gambler",
	criteria =
	[
		[ "concept", "iMT_EllisStoryInterrupt" ], [ "who", "Gambler" ], [ "world_auto_tellingstory", 1 ], [ "coughing", 0 ], [ "incapacitated", 0 ], [ "speaking", 0], [ "randomnum", 0, 10 ], [ IsTalk ], [ IsTalkGambler ], [ IsWorldTalkGambler ], [ IssuerCloseEnough ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/EllisInterrupt15.vcd" }  //Glad you shared that, Ellis.
	],
	group_params = none
}

{
	name = "iMT_EllisStoryInterruptC1Gambler",
	criteria =
	[
		[ "concept", "iMT_EllisStoryInterrupt" ], [ "who", "Gambler" ], [ "world_auto_tellingstory", 1 ], [ "coughing", 0 ], [ "incapacitated", 0 ], [ "speaking", 0], [ IsTalk ], [ IsTalkGambler ], [ IsWorldTalkGambler ], [ IssuerCloseEnough ], [ C1M1orC1M2 ], [ IsNotSurvival ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/EllisInterrupt09.vcd", followup = RThen( "Mechanic", "iMT_EllisStoryReac", { from = "Gambler" }, 0.3 ) }  //Uhhh. I don't CARE. NOBODY cares.
		{ scenename = "scenes/Gambler/EllisInterrupt12.vcd" }  //Ohhh, not again...
	],
	group_params = none
}

{
	name = "iMT_EllisStoryInterruptC1M2Gambler",
	criteria =
	[
		[ "concept", "iMT_EllisStoryInterrupt" ], [ "who", "Gambler" ], [ "world_auto_tellingstory", 1 ], [ "worldellisstoryspecific", 1 ], [ "coughing", 0 ], [ "incapacitated", 0 ], [ "speaking", 0], [ "map", "c1m2_streets" ], [ IsTalk ], [ IsTalkGambler ], [ IsWorldTalkGambler ], [ IssuerCloseEnough ], [ AddWeight ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/EllisInterrupt04.vcd" }  //Uh huh.
		{ scenename = "scenes/Gambler/EllisInterrupt05.vcd" }  //Uh huh.
		{ scenename = "scenes/Gambler/EllisInterrupt18.vcd" }  //And your point... is...
	],
	group_params = none
}

{
	name = "iMT_EllisStoryInterruptC1M3Gambler",
	criteria =
	[
		[ "concept", "iMT_EllisStoryInterrupt" ], [ "who", "Gambler" ], [ "world_auto_tellingstory", 1 ], [ "worldellisstoryspecific", 1 ], [ "coughing", 0 ], [ "incapacitated", 0 ], [ "speaking", 0], [ "map", "c1m3_mall" ], [ IsTalk ], [ IsTalkGambler ], [ IsWorldTalkGambler ], [ IssuerCloseEnough ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/EllisInterrupt21.vcd" }  //Why don't we just try quiet time for a while?
		{ scenename = "scenes/Gambler/EllisInterrupt22.vcd" }  //Hey, Ellis. Shut-up contest, ready? One, two, three, go!
	],
	group_params = none
}

{
	name = "iMT_EllisStoryInterruptC2M5Gambler",
	criteria =
	[
		[ "concept", "iMT_EllisStoryInterrupt" ], [ "who", "Gambler" ], [ "world_auto_tellingstory", 1 ], [ "worldellisstoryspecific", 1 ], [ "coughing", 0 ], [ "incapacitated", 0 ], [ "speaking", 0], [ "map", "c2m5_concert" ], [ IsTalk ], [ IsTalkGambler ], [ IsWorldTalkGambler ], [ IssuerCloseEnough ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/EllisInterrupt01.vcd", followup = RThen( "Mechanic", "iMT_EllisStoryReac", { from = "Gambler" }, 0.3 ) }  //Ellis, why don't you tell us this in the chopper?
	],
	group_params = none
}

{
	name = "iMT_EllisStoryInterruptC4M3Gambler",
	criteria =
	[
		[ "concept", "iMT_EllisStoryInterrupt" ], [ "who", "Gambler" ], [ "world_auto_tellingstory", 1 ], [ "worldellisstoryspecific", 1 ], [ "coughing", 0 ], [ "incapacitated", 0 ], [ "speaking", 0], [ "map", "c4m3_sugarmill_b" ], [ IsTalk ], [ IsTalkGambler ], [ IsWorldTalkGambler ], [ IssuerCloseEnough ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/EllisInterrupt11.vcd" }  //Jesus, is there a witch around here we can piss off?
	],
	group_params = none
}

{
	name = "iMT_EllisStoryStopGambler",
	criteria =
	[
		[ "concept", "iMT_EllisStories" ], [ "who", "Gambler" ], [ "world_auto_tellingstory", 1 ]
	],
	responses =
	[
		{
			scenename = "scenes/Gambler/EllisInterrupt06.vcd", followup = RThen( "all", "iMT_EllisStoryStop", null, 0.3 ),  //Ellis... Ellis. ELLIS!
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
	name = "iMT_EllisStoryStop%Gambler",
	criteria =
	[
		[ "concept", "iMT_EllisStories" ], [ "who", "Gambler" ], [ "world_auto_tellingstory", 1 ], [ "randomnum", 0, 10 ]
	],
	responses =
	[
		{
			scenename = "scenes/Gambler/World132.vcd", followup = RThen( "all", "iMT_EllisStoryStop", null, 0.3 ),  //Ellis! ELLIS! We don't have time for that right now!
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
	name = "iMT_EllisStoryStopC1Gambler",
	criteria =
	[
		[ "concept", "iMT_EllisStories" ], [ "who", "Gambler" ], [ "world_auto_tellingstory", 1 ], [ C1M1orC1M2 ], [ IsNotSurvival ]
	],
	responses =
	[
		{
			scenename = "scenes/Gambler/EllisInterrupt09.vcd", followup = RThen( "all", "iMT_EllisStoryStop", null, 0.3 ),  //Uhhh. I don't CARE. NOBODY cares.
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
	name = "iMT_PlayerAnswerReadyGambler",
	criteria =
	[
		[ "concept", "iMT_PlayerAnswerReady" ], [ "who", "Gambler" ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/TakeMelee01.vcd" }  //Hell yeah.
		{ scenename = "scenes/Gambler/TakeMelee02.vcd" }  //This feels good.
		{ scenename = "scenes/Gambler/WorldC1M1B34.vcd" }  //Now we're talking.
	],
	group_params = none
}

{
	name = "iMT_PlayerBattleCryGambler",
	criteria =
	[
		[ "concept", "iMT_PlayerBattleCry" ], [ "who", "Gambler" ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/BattleCry01.vcd" }  //YEEEAAAAH!
		{ scenename = "scenes/Gambler/BattleCry02.vcd" }  //DIE! DIE!
		{ scenename = "scenes/Gambler/BattleCry03.vcd" }  //SUCK ON THIS!
		{ scenename = "scenes/Gambler/BattleCry04.vcd" }  //YEAH! DIE!
	],
	group_params = none
}

{
	name = "iMT_PlayerBreathingGambler",
	criteria =
	[
		[ "concept", "iMT_PlayerBreathing" ], [ "who", "Gambler" ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/Defibrillator10.vcd" }  //[gasp for breath]
		{ scenename = "scenes/Gambler/Defibrillator11.vcd" }  //[gasp for breath]
		{ scenename = "scenes/Gambler/Defibrillator14.vcd" }  //[gasp for breath]
	],
	group_params = none
}

{
	name = "iMT_PlayerCloseTheDoorGambler",
	criteria =
	[
		[ "concept", "iMT_PlayerCloseTheDoor" ], [ "who", "Gambler" ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/CloseTheDoor01.vcd" }  //Close the door.
		{ scenename = "scenes/Gambler/CloseTheDoor02.vcd" }  //Close the door.
		{ scenename = "scenes/Gambler/CloseTheDoor03.vcd" }  //Don't forget to the close the door.
		{ scenename = "scenes/Gambler/CloseTheDoor04.vcd" }  //Somebody got the door?
		{ scenename = "scenes/Gambler/CloseTheDoor05.vcd" }  //Close the door.
		{ scenename = "scenes/Gambler/CloseTheDoor06.vcd" }  //Don't forget to the close the door.
		{ scenename = "scenes/Gambler/CloseTheDoor07.vcd" }  //Somebody got the door?
		{ scenename = "scenes/Gambler/CloseTheDoor08.vcd" }  //Close that door.
		{ scenename = "scenes/Gambler/CloseTheDoor09.vcd" }  //Close that door.
	],
	group_params = none
}

{
	name = "iMT_PlayerCloseTheDoorC1Gambler",
	criteria =
	[
		[ "concept", "iMT_PlayerCloseTheDoor" ], [ "who", "Gambler" ], [ "map", "c1m1_hotel" ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/CloseTheDoorC101.vcd" }  //I think we should be closing doors.
		{ scenename = "scenes/Gambler/CloseTheDoorC102.vcd" }  //Let's try closing doors behind us.
	],
	group_params = none
}

{
	name = "iMT_PlayerCoughingGambler",
	criteria =
	[
		[ "concept", "iMT_PlayerCoughing" ], [ "who", "Gambler" ]
	],
	responses = SurvivorCoughingGambler,
	group_params = none
}

{
	name = "iMT_PlayerDeathScreamGambler",
	criteria =
	[
		[ "concept", "iMT_PlayerDeathScream" ], [ "who", "Gambler" ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/LedgeHangFall01.vcd" }  //HEEEEEEEELLLLLPPPPP!!!!!
		{ scenename = "scenes/Gambler/LedgeHangFall02.vcd" }  //NOOOOOOOOOOOOOOOO!!!!
		{ scenename = "scenes/Gambler/LedgeHangFall03.vcd" }  //WOOOOOAAAAAHHHHHH!!!!
	],
	group_params = none
}

{
	name = "iMT_PlayerFriendlyFireGambler",
	criteria =
	[
		[ "concept", "iMT_PlayerFriendlyFire" ], [ "who", "Gambler" ], [ "tankactive", 0 ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/FriendlyFire01.vcd" }  //Do that again and I'll bury you alive.
		{ scenename = "scenes/Gambler/FriendlyFire02.vcd" }  //I don't want to hear any excuses, just stop shooting me.
		{ scenename = "scenes/Gambler/FriendlyFire03.vcd" }  //STOP SHOOTING ME!
		{ scenename = "scenes/Gambler/FriendlyFire04.vcd" }  //Can you stop shooting me?
		{ scenename = "scenes/Gambler/FriendlyFire05.vcd" }  //You know, it's not all right that you are SHOOTING ME!
		{ scenename = "scenes/Gambler/FriendlyFire06.vcd" }  //DAMN! You suck at shooting.
		{ scenename = "scenes/Gambler/FriendlyFire07.vcd" }  //Stop shooting me.
		{ scenename = "scenes/Gambler/FriendlyFire08.vcd" }  //Well thank you for ventilating my suit.
		{ scenename = "scenes/Gambler/FriendlyFire09.vcd" }  //You. Are. Shooting. Me.
		{ scenename = "scenes/Gambler/FriendlyFire10.vcd" }  //You do realize you are shooting me right?
		{ scenename = "scenes/Gambler/FriendlyFire11.vcd" }  //Shoot me again. Shoot me again, I dare you.
		{ scenename = "scenes/Gambler/FriendlyFire12.vcd" }  //You want to watch where you're shooting?
		{ scenename = "scenes/Gambler/FriendlyFire13.vcd" }  //Stop! Shooting me doesn't get us anywhere.
		{ scenename = "scenes/Gambler/FriendlyFire14.vcd" }  //Let's not mess this up by shooting each other, okay?
		{ scenename = "scenes/Gambler/FriendlyFire15.vcd" }  //Can we not shoot each other?
		{ scenename = "scenes/Gambler/FriendlyFire16.vcd" }  //Question: Can we not shoot each other?
		{ scenename = "scenes/Gambler/FriendlyFire17.vcd" }  //You're shooting me again.
		{ scenename = "scenes/Gambler/FriendlyFire18.vcd" }  //You shoot me again, and I will drop you.
		{ scenename = "scenes/Gambler/FriendlyFire19.vcd" }  //Shoot me again, I'll drop you.
		{ scenename = "scenes/Gambler/FriendlyFire20.vcd" }  //Are you really going to shoot a guy in a $3000 suit? Come on!
		{ scenename = "scenes/Gambler/FriendlyFire21.vcd" }  //Are you really going to shoot a guy in a $3000 suit? Come on!
		{ scenename = "scenes/Gambler/FriendlyFire22.vcd" }  //Stop shooting me.
		{ scenename = "scenes/Gambler/FriendlyFire23.vcd" }  //Do not shoot me.
		{ scenename = "scenes/Gambler/FriendlyFire24.vcd" }  //Stop shooting each other.
		{ scenename = "scenes/Gambler/FriendlyFire25.vcd" }  //Can we stop shooting each other?
		{ scenename = "scenes/Gambler/FriendlyFire26.vcd" }  //Can we stop shooting each other?
		{ scenename = "scenes/Gambler/FriendlyFire27.vcd" }  //Don't shoot each other.
		{ scenename = "scenes/Gambler/FriendlyFire28.vcd" }  //Can we not shoot each other?
		{ scenename = "scenes/Gambler/FriendlyFire29.vcd" }  //Can we not shoot each other, please?
		{ scenename = "scenes/Gambler/FriendlyFire30.vcd" }  //You are shooting - ME!
		{ scenename = "scenes/Gambler/FriendlyFire31.vcd" }  //Unless you want to be picking your teeth up off the floor, stop shooting me!
	],
	group_params = none
}

{
	name = "iMT_PlayerFriendlyFireC1Gambler",
	criteria =
	[
		[ "concept", "iMT_PlayerFriendlyFire" ], [ "who", "Gambler" ], [ "tankactive", 0 ], [ C1M1orC1M2 ], [ IsNotSurvival ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/FriendlyFireC101.vcd" }  //I don't know who started this shit, but lets just stop the friendly right now, 'kay?
		{ scenename = "scenes/Gambler/FriendlyFireC102.vcd" }  //I don't know who started this shit, 'kay? But lets just stop the friendly right now.
		{ scenename = "scenes/Gambler/FriendlyFireC103.vcd" }  //Never shoot me again.
		{ scenename = "scenes/Gambler/FriendlyFireC104.vcd" }  //You do not want to be shooting me!
		{ scenename = "scenes/Gambler/FriendlyFireC105.vcd" }  //Why would you think shooting me is a good idea?
		{ scenename = "scenes/Gambler/FriendlyFireC106.vcd" }  //Let's try shooting zombies instead of people, okay?
		{ scenename = "scenes/Gambler/FriendlyFireMechanic02.vcd" }  //Y'all wanna stop shootin me?
	],
	group_params = none
}

{
	name = "iMT_PlayerFriendlyFireFromCoachGambler",
	criteria =
	[
		[ "concept", "iMT_PlayerFriendlyFire" ], [ "who", "Gambler" ], [ "tankactive", 0 ], [ "subject", "Coach" ], [ "dist_from_subject", 0, 799 ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/FriendlyFireC1Coach01.vcd" }  //Coach! Don't shoot me.
		{ scenename = "scenes/Gambler/FriendlyFireC1Coach02.vcd" }  //Coach! Come on.
	],
	group_params = none
}

{
	name = "iMT_PlayerFriendlyFireFromCoachC1Gambler",
	criteria =
	[
		[ "concept", "iMT_PlayerFriendlyFire" ], [ "who", "Gambler" ], [ "tankactive", 0 ], [ "subject", "Coach" ], [ "dist_from_subject", 0, 799 ], [ C1M1orC1M2 ], [ IsNotSurvival ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/FriendlyFireC103.vcd" }  //Never shoot me again.
		{ scenename = "scenes/Gambler/FriendlyFireC104.vcd" }  //You do not want to be shooting me!
	],
	group_params = none
}

{
	name = "iMT_PlayerFriendlyFireFromMechanicGambler",
	criteria =
	[
		[ "concept", "iMT_PlayerFriendlyFire" ], [ "who", "Gambler" ], [ "tankactive", 0 ], [ "subject", "Mechanic" ], [ "dist_from_subject", 0, 799 ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/FriendlyFireEllis01.vcd" }  //Hey sport, watch where you're shooting!
		{ scenename = "scenes/Gambler/FriendlyFireMechanic01.vcd" }  //Ellis, come on man.
	],
	group_params = none
}

{
	name = "iMT_PlayerFriendlyFireFromMechanicC1Gambler",
	criteria =
	[
		[ "concept", "iMT_PlayerFriendlyFire" ], [ "who", "Gambler" ], [ "tankactive", 0 ], [ "subject", "Mechanic" ], [ "dist_from_subject", 0, 799 ], [ C1M1orC1M2 ], [ IsNotSurvival ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/FriendlyFireEllis01.vcd" }  //Hey sport, watch where you're shooting!
		{ scenename = "scenes/Gambler/NoEllis01.vcd" }  //Try again, champ.
		{ scenename = "scenes/Gambler/NoEllis02.vcd" }  //Try again, little man.
	],
	group_params = none
}

{
	name = "iMT_PlayerFriendlyFireFromProducerGambler",
	criteria =
	[
		[ "concept", "iMT_PlayerFriendlyFire" ], [ "who", "Gambler" ], [ "tankactive", 0 ], [ "subject", "Producer" ], [ "dist_from_subject", 0, 799 ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/FriendlyFireC1Producer01.vcd" }  //ROCHELLE!
		{ scenename = "scenes/Gambler/FriendlyFireC1Producer02.vcd" }  //Ro! Just... just stop okay?
		{ scenename = "scenes/Gambler/FriendlyFireC1Producer03.vcd" }  //ROCHELLE!
		{ scenename = "scenes/Gambler/FriendlyFireFemale01.vcd" }  //Sweetheart? Don't shoot me.
	],
	group_params = none
}

{
	name = "iMT_PlayerFriendlyFireFromProducerC1Gambler",
	criteria =
	[
		[ "concept", "iMT_PlayerFriendlyFire" ], [ "who", "Gambler" ], [ "tankactive", 0 ], [ "subject", "Producer" ], [ "dist_from_subject", 0, 799 ], [ C1M1orC1M2 ], [ IsNotSurvival ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/FriendlyFireFemale01.vcd" }  //Sweetheart? Don't shoot me.
	],
	group_params = none
}

{
	name = "iMT_PlayerFriendlyFireTankGambler",
	criteria =
	[
		[ "concept", "iMT_PlayerFriendlyFire" ], [ "who", "Gambler" ], [ "tankactive", 1 ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/FriendlyFireTank01.vcd" }  //Not ME! Shoot the TANK!
		{ scenename = "scenes/Gambler/FriendlyFireTank02.vcd" }  //Hey! Shoot the Tank!
		{ scenename = "scenes/Gambler/FriendlyFireTank03.vcd" }  //Aggghh! The TANK!
		{ scenename = "scenes/Gambler/FriendlyFireTank04.vcd" }  //The Tank, hotshot! Shoot the TANK!
		{ scenename = "scenes/Gambler/FriendlyFireTank05.vcd" }  //It's twelve feet tall and six feet wide! How are you shooting ME?
		{ scenename = "scenes/Gambler/FriendlyFireTank06.vcd" }  //It's the size of a truck! How are you MISSING?
		{ scenename = "scenes/Gambler/FriendlyFireTank07.vcd" }  //Come on! Shoot the TANK, not ME.

	],
	group_params = none
}

{
	name = "iMT_PlayerFriendlyFireTankC1Gambler",
	criteria =
	[
		[ "concept", "iMT_PlayerFriendlyFire" ], [ "who", "Gambler" ], [ "tankactive", 1 ], [ C1M1orC1M2 ], [ IsNotSurvival ], [ NoKnowTank ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/FriendlyFireTank05.vcd" }  //It's twelve feet tall and six feet wide! How are you shooting ME?
		{ scenename = "scenes/Gambler/FriendlyFireTank06.vcd" }  //It's the size of a truck! How are you MISSING?
	],
	group_params = none
}

{
	name = "iMT_PlayerGetToVehicleBoatGambler",
	criteria =
	[
		[ "concept", "iMT_PlayerGetToVehicleBoat" ], [ "who", "Gambler" ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/WorldC3M4B23.vcd" }  //Everyone to the boat!
		{ scenename = "scenes/Gambler/WorldC3M4B24.vcd" }  //Get to the boat!
		{ scenename = "scenes/Gambler/WorldC3M4B25.vcd" }  //To the boat!
		{ scenename = "scenes/Gambler/WorldC4M442.vcd" }  //Everyone to the boat!
		{ scenename = "scenes/Gambler/WorldC4M4B22.vcd" }  //GET TO THE BOAT!
		{ scenename = "scenes/Gambler/WorldC4M4B23.vcd" }  //GET TO THE BOAT!
	],
	group_params = none
}

{
	name = "iMT_PlayerGetToVehicleChopperGambler",
	criteria =
	[
		[ "concept", "iMT_PlayerGetToVehicleChopper" ], [ "who", "Gambler" ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/World425.vcd" }  //Get to the chopper!
		{ scenename = "scenes/Gambler/WorldC2M5B49.vcd" }  //Get on the helicopter!
		{ scenename = "scenes/Gambler/WorldC2M5B50.vcd" }  //Everyone to the copter!
		{ scenename = "scenes/Gambler/WorldC2M5B52.vcd" }  //Copter's landed, let's go!
		{ scenename = "scenes/Gambler/WorldC2M5B53.vcd" }  //Let's go, let's go to the copter!
		{ scenename = "scenes/Gambler/WorldC5M5B15.vcd" }  //GET TO THE COPTER!
	],
	group_params = none
}

{
	name = "iMT_PlayerGetToVehicleChopperReacGambler",
	criteria =
	[
		[ "concept", "iMT_PlayerGetToVehicleChopperReac" ], [ "who", "Gambler" ], [ "coughing", 0 ], [ "incapacitated", 0 ], [ "speaking", 0], [ IsTalk ], [ IsTalkGambler ], [ IsWorldTalkGambler ], [ IssuerClose ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/WorldC1M1B116.vcd" }  //HELICOPTER. It is a HELICOPTER. You call that thing a whirlybird one more time, I'll beat you SO hard, your sister's gonna wish she never gave birth to you.
	],
	group_params = none
}

{
	name = "iMT_PlayerGetToVehicleWheelsGambler",
	criteria =
	[
		[ "concept", "iMT_PlayerGetToVehicleWheels" ], [ "who", "Gambler" ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/DLC1_C6M3_FinaleBridgeRun01.vcd" }  //Everyone to the car!
		{ scenename = "scenes/Gambler/DLC1_C6M3_FinaleBridgeRun04.vcd" }  //GET TO THE CAR, GET TO THE CAR!
		{ scenename = "scenes/Gambler/WorldC1M4B36.vcd" }  //Get to the car!
		{ scenename = "scenes/Gambler/WorldC1M4B37.vcd" }  //Would you get to the goddamn car?
		{ scenename = "scenes/Gambler/WorldC1M4B39.vcd" }  //Everyone to the car!
	],
	group_params = none
}

{
	name = "iMT_PlayerGoingToDieGambler",
	criteria =
	[
		[ "concept", "iMT_PlayerGoingToDie" ], [ "who", "Gambler" ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/GoingToDie01.vcd" }  //I really screwed the pooch back there.
		{ scenename = "scenes/Gambler/GoingToDie02.vcd" }  //I gotta take better care of myself.
		{ scenename = "scenes/Gambler/GoingToDie03.vcd" }  //Not dead yet, but not exactly healthy.
		{ scenename = "scenes/Gambler/GoingToDie04.vcd" }  //God damn it! God damn it. God damn it.
		{ scenename = "scenes/Gambler/GoingToDie05.vcd" }  //If I go, you guys gonna miss me.
		{ scenename = "scenes/Gambler/GoingToDie06.vcd" }  //I have seriously felt better.
		{ scenename = "scenes/Gambler/GoingToDie07.vcd" }  //Pull yourself together man, you're falling apart.
		{ scenename = "scenes/Gambler/GoingToDie08.vcd" }  //Don't worry about me, I'll be okay.
		{ scenename = "scenes/Gambler/GoingToDie09.vcd" }  //This is not how it's going to end.
		{ scenename = "scenes/Gambler/GoingToDie10.vcd" }  //I'm not dead yet!
		{ scenename = "scenes/Gambler/GoingToDie11.vcd" }  //You're going to have to do better than that to kill me!
		{ scenename = "scenes/Gambler/GoingToDie12.vcd" }  //Quit being a baby, you've felt worse after a night of drinking.
		{ scenename = "scenes/Gambler/GoingToDie13.vcd" }  //Ain't this a bitch.
		{ scenename = "scenes/Gambler/GoingToDie14.vcd" }  //God damn it I can't believe this.
		{ scenename = "scenes/Gambler/GoingToDie15.vcd" }  //Well at least I didn't catch the flu.
		{ scenename = "scenes/Gambler/GoingToDie16.vcd" }  //This is some crap.
		{ scenename = "scenes/Gambler/GoingToDie17.vcd" }  //Don't worry. I'm not done yet.
		{ scenename = "scenes/Gambler/GoingToDie18.vcd" }  //I am sick and tired of being sick and tired.
		{ scenename = "scenes/Gambler/GoingToDie23.vcd" }  //What was I thinking coming down here?
		{ scenename = "scenes/Gambler/GoingToDie24.vcd" }  //Okay, all right, I can do this. I can do this.
		{ scenename = "scenes/Gambler/GoingToDie25.vcd" }  //I'm not going to die down here.
		{ scenename = "scenes/Gambler/GoingToDie26.vcd" }  //I am not dying in the middle of nowhere.
	],
	group_params = none
}

{
	name = "iMT_PlayerGoingToDie3Gambler",
	criteria =
	[
		[ "concept", "iMT_PlayerGoingToDie" ], [ "who", "Gambler" ], [ "onthirdstrike", 1 ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/GoingToDie301.vcd" }  //I am not going to make it much longer my friends, I am seriously screwed up.
		{ scenename = "scenes/Gambler/GoingToDie302.vcd" }  //All right, I gotta call uncle here. I need some help.
		{ scenename = "scenes/Gambler/GoingToDie303.vcd" }  //Well boys, this looks like its for me.
		{ scenename = "scenes/Gambler/GoingToDie304.vcd" }  //Doesn't this beat all. I am about to die.
		{ scenename = "scenes/Gambler/GoingToDie305.vcd" }  //Man, man... It has been a long time since I have felt this bad.
	],
	group_params = none
}

{
	name = "iMT_PlayerGooedBySpitterGambler",
	criteria =
	[
		[ "concept", "iMT_PlayerGooedBySpitter" ], [ "who", "Gambler" ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/GooedBySpitter01.vcd" }  //I got hit by the burning goo shit.
		{ scenename = "scenes/Gambler/GooedBySpitter02.vcd" }  //I got hit by the burning goo shit.
		{ scenename = "scenes/Gambler/GooedBySpitter03.vcd" }  //Goddamn it, I'm covered in goo.
		{ scenename = "scenes/Gambler/GooedBySpitter04.vcd" }  //I got hit by the burning goo shit.
		{ scenename = "scenes/Gambler/GooedBySpitter05.vcd" }  //Let's get out of the goo!
		{ scenename = "scenes/Gambler/GooedBySpitter06.vcd" }  //Get out of the goo!
	],
	group_params = none
}

{
	name = "iMT_PlayerGooedBySpitterC1Gambler",
	criteria =
	[
		[ "concept", "iMT_PlayerGooedBySpitter" ], [ "who", "Gambler" ], [ C1M1orC1M2 ], [ IsNotSurvival ], [ NoKnowSpitter ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/GooedBySpitterC101.vcd" }  //Ugh, what in the hell did that thing just do?
		{ scenename = "scenes/Gambler/GooedBySpitterC102.vcd" }  //What is this shit on me?
		{ scenename = "scenes/Gambler/GooedBySpitterC103.vcd" }  //What am I covered in?

	],
	group_params = none
}

{
	name = "iMT_PlayerHelloGambler",
	criteria =
	[
		[ "concept", "iMT_PlayerHello" ], [ "who", "Gambler" ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/ScenarioJoin01.vcd" }  //Hello!
		{ scenename = "scenes/Gambler/ScenarioJoin04.vcd" }  //Hello!
		{ scenename = "scenes/Gambler/ScenarioJoin05.vcd" }  //Y'ello!
		{ scenename = "scenes/Gambler/ScenarioJoin06.vcd" }  //Hello!
	],
	group_params = none
}

{
	name = "iMT_PlayerIncapacitatedHurtGambler",
	criteria =
	[
		[ "concept", "iMT_PlayerIncapacitatedHurt" ], [ "who", "Gambler" ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/HurtCritical01.vcd" }  //[pain noise - loud major pain]
		{ scenename = "scenes/Gambler/HurtCritical02.vcd" }  //[pain noise - loud major pain]
		{ scenename = "scenes/Gambler/HurtCritical03.vcd" }  //[pain noise - loud major pain]
		{ scenename = "scenes/Gambler/HurtCritical04.vcd" }  //[pain noise - loud major pain]
		{ scenename = "scenes/Gambler/HurtCritical05.vcd" }  //[pain noise - loud major pain]
		{ scenename = "scenes/Gambler/HurtCritical06.vcd" }  //[pain noise - loud major pain]
		{ scenename = "scenes/Gambler/HurtCritical07.vcd" }  //[pain noise - loud major pain]
		{ scenename = "scenes/Gambler/IncapacitatedInjury01.vcd" }  //AHHHHH [terrified yell]
		{ scenename = "scenes/Gambler/IncapacitatedInjury02.vcd" }  //AHHHHH [terrified yell]
		{ scenename = "scenes/Gambler/IncapacitatedInjury03.vcd" }  //AHHHHH [terrified yell]
		{ scenename = "scenes/Gambler/IncapacitatedInjury04.vcd" }  //AHHHHH [terrified yell]
		{ scenename = "scenes/Gambler/IncapacitatedInjury05.vcd" }  //AHHHHH [terrified yell]
	],
	group_params = none
}

{
	name = "iMT_PlayerKillConfirmationGambler",
	criteria =
	[
		[ "concept", "iMT_PlayerKilledZombie" ], [ "who", "Gambler" ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/KillConfirmation01.vcd" }  //Got it!
		{ scenename = "scenes/Gambler/KillConfirmation02.vcd" }  //It's dead!
		{ scenename = "scenes/Gambler/KillConfirmation03.vcd" }  //Got it!
		{ scenename = "scenes/Gambler/KillConfirmation04.vcd" }  //Dead.
		{ scenename = "scenes/Gambler/KillConfirmation05.vcd" }  //Got 'em.
		{ scenename = "scenes/Gambler/KillConfirmation06.vcd" }  //Got 'em.
		{ scenename = "scenes/Gambler/KillConfirmation07.vcd" }  //Done like dinner!
		{ scenename = "scenes/Gambler/KillConfirmation08.vcd" }  //Bull's-eye.
		{ scenename = "scenes/Gambler/KillConfirmation09.vcd" }  //That's a hit.
		{ scenename = "scenes/Gambler/KillConfirmation10.vcd" }  //Dead.
		{ scenename = "scenes/Gambler/KillConfirmation11.vcd" }  //Hit.
		{ scenename = "scenes/Gambler/KillConfirmation12.vcd" }  //Bull's-eye.
		{ scenename = "scenes/Gambler/KillConfirmation13.vcd" }  //Got it!
	],
	group_params = none
}

{
	name = "iMT_PlayerKillConfirmationC1Gambler",
	criteria =
	[
		[ "concept", "iMT_PlayerKilledZombie" ], [ "who", "Gambler" ], [ "map", "c1m1_hotel" ], [ IsNotFirstKillC1 ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/WorldC1M1B141.vcd" }  //Well, they DIE like anything else...
		{ scenename = "scenes/Gambler/WorldC1M1B142.vcd" }  //Ugh. They smell worse dead!
	],
	group_params = none
}

{
	name = "iMT_PlayerKillStealGambler",
	criteria =
	[
		[ "concept", "iMT_PlayerKilledZombie" ], [ "who", "Gambler" ], [ "coughing", 0 ], [ "incapacitated", 0 ], [ "ismechanicalive", 1 ], [ "disttomechanic", 0, 399 ], [ "tankactive", 0 ], [ "randomnum", 0, 5 ], [ IsTalk ], [ IsTalkGambler ], [ IsWorldTalkGambler ], [ IsNotC1M1 ], [ IsNotC1M2 ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/Blank.vcd", followup = RThen( "Mechanic", "iMT_PlayerKillSteal", { from = "Gambler" }, 0 ) }
	],
	group_params = none
}

{
	name = "iMT_PlayerKillStealReacGambler",
	criteria =
	[
		[ "concept", "iMT_PlayerKillStealReac" ], [ "who", "Gambler" ], [ "coughing", 0 ], [ "incapacitated", 0 ], [ IsTalk ], [ IsTalkGambler ], [ IsWorldTalkGambler ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/KillConfirmationEllis01.vcd", followup = RThen( "Mechanic", "iMT_PlayerKillStealInsist", { from = "Gambler" }, 0 ) }  //I don't think so Ellis.
	],
	group_params = none
}

{
	name = "iMT_PlayerKillStealInsistReacGambler",
	criteria =
	[
		[ "concept", "iMT_PlayerKillStealInsistReac" ], [ "who", "Gambler" ], [ "coughing", 0 ], [ "incapacitated", 0 ], [ IsTalk ], [ IsTalkGambler ], [ IsWorldTalkGambler ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/ReactionNegative05.vcd" }  //Bullshit!
		{ scenename = "scenes/Gambler/ReactionNegative11.vcd" }  //Oh bullshit!
		{ scenename = "scenes/Gambler/ReactionNegative17.vcd" }  //Bullshit!
		{ scenename = "scenes/Gambler/ReactionNegative22.vcd" }  //Oh bullshit!
	],
	group_params = none
}

{
	name = "iMT_PlayerMeleeGambler",
	criteria =
	[
		[ "concept", "iMT_PlayerMelee" ], [ "who", "Gambler" ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/MeleeSwing01.vcd" }  //[Melee grunt]
		{ scenename = "scenes/Gambler/MeleeSwing02.vcd" }  //[Melee grunt]
		{ scenename = "scenes/Gambler/MeleeSwing03.vcd" }  //[Melee grunt]
		{ scenename = "scenes/Gambler/MeleeSwing04.vcd" }  //[Melee grunt]
		{ scenename = "scenes/Gambler/MeleeSwing05.vcd" }  //[Melee grunt]
		{ scenename = "scenes/Gambler/MeleeSwing06.vcd" }  //[Melee grunt]
		{ scenename = "scenes/Gambler/MeleeSwing07.vcd" }  //[Melee grunt]
	],
	group_params = none
}

{
	name = "iMT_PlayerMeleeIntenseGambler",
	criteria =
	[
		[ "concept", "iMT_PlayerMelee" ], [ "who", "Gambler" ], [ "incombatmusic", 1 ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/MeleeSwing08.vcd" }  //[Intense melee grunt]
		{ scenename = "scenes/Gambler/MeleeSwing09.vcd" }  //[Intense melee grunt]
		{ scenename = "scenes/Gambler/MeleeSwing10.vcd" }  //[Intense melee grunt]
		{ scenename = "scenes/Gambler/MeleeSwing11.vcd" }  //[Intense melee grunt]
		{ scenename = "scenes/Gambler/MeleeSwing12.vcd" }  //[Intense melee grunt]
		{ scenename = "scenes/Gambler/MeleeSwing13.vcd" }  //[Intense melee grunt]
		{ scenename = "scenes/Gambler/MeleeSwing14.vcd" }  //[Intense melee grunt]
		{ scenename = "scenes/Gambler/MeleeSwing15.vcd" }  //[Intense melee grunt]
	],
	group_params = none
}

{
	name = "iMT_PlayerMournCoachAliveGambler",
	criteria =
	[
		[ "concept", "iMT_PlayerMourn" ], [ "who", "Gambler" ], [ "iscoachalive", 1 ], [ "subject", "Coach" ], [ "dist_from_subject", 0, 199 ]
	],
	responses = SurvivorMournCoachGambler,
	group_params = none
}

{
	name = "iMT_PlayerMournCoachAliveC1Gambler",
	criteria =
	[
		[ "concept", "iMT_PlayerMourn" ], [ "who", "Gambler" ], [ "iscoachalive", 1 ], [ "subject", "Coach" ], [ "dist_from_subject", 0, 199 ], [ C1M1orC1M2 ], [ IsNotSurvival ]
	],
	responses = SurvivorMournCoachC1Gambler,
	group_params = none
}

{
	name = "iMT_PlayerMournCoachDeadGambler",
	criteria =
	[
		[ "concept", "iMT_PlayerMourn" ], [ "who", "Gambler" ], [ "iscoachalive", 0 ], [ "disttocoach", 0, 199 ]
	],
	responses = SurvivorMournCoachGambler,
	group_params = none
}

{
	name = "iMT_PlayerMournCoachDeadC1Gambler",
	criteria =
	[
		[ "concept", "iMT_PlayerMourn" ], [ "who", "Gambler" ], [ "iscoachalive", 0 ], [ "disttocoach", 0, 199 ], [ C1M1orC1M2 ], [ IsNotSurvival ]
	],
	responses = SurvivorMournCoachC1Gambler,
	group_params = none
}

{
	name = "iMT_PlayerMournMechanicAliveGambler",
	criteria =
	[
		[ "concept", "iMT_PlayerMourn" ], [ "who", "Gambler" ], [ "ismechanicalive", 1 ], [ "subject", "Mechanic" ], [ "dist_from_subject", 0, 199 ]
	],
	responses = SurvivorMournMechanicGambler,
	group_params = none
}

{
	name = "iMT_PlayerMournMechanicAliveC1Gambler",
	criteria =
	[
		[ "concept", "iMT_PlayerMourn" ], [ "who", "Gambler" ], [ "ismechanicalive", 1 ], [ "subject", "Mechanic" ], [ "dist_from_subject", 0, 199 ], [ C1M1orC1M2 ], [ IsNotSurvival ]
	],
	responses = SurvivorMournMechanicC1Gambler,
	group_params = none
}

{
	name = "iMT_PlayerMournMechanicDeadGambler",
	criteria =
	[
		[ "concept", "iMT_PlayerMourn" ], [ "who", "Gambler" ], [ "ismechanicalive", 0 ], [ "disttomechanic", 0, 199 ]
	],
	responses = SurvivorMournMechanicGambler,
	group_params = none
}

{
	name = "iMT_PlayerMournMechanicDeadC1Gambler",
	criteria =
	[
		[ "concept", "iMT_PlayerMourn" ], [ "who", "Gambler" ], [ "ismechanicalive", 0 ], [ "disttomechanic", 0, 199 ], [ C1M1orC1M2 ], [ IsNotSurvival ]
	],
	responses = SurvivorMournMechanicC1Gambler,
	group_params = none
}

{
	name = "iMT_PlayerMournProducerAliveGambler",
	criteria =
	[
		[ "concept", "iMT_PlayerMourn" ], [ "who", "Gambler" ], [ "isproduceralive", 1 ], [ "subject", "Producer" ], [ "dist_from_subject", 0, 199 ]
	],
	responses = SurvivorMournProducerGambler,
	group_params = none
}

{
	name = "iMT_PlayerMournProducerAliveC1Gambler",
	criteria =
	[
		[ "concept", "iMT_PlayerMourn" ], [ "who", "Gambler" ], [ "isproduceralive", 1 ], [ "subject", "Producer" ], [ "dist_from_subject", 0, 199 ], [ C1M1orC1M2 ], [ IsNotSurvival ]
	],
	responses = SurvivorMournProducerC1Gambler,
	group_params = none
}

{
	name = "iMT_PlayerMournProducerDeadGambler",
	criteria =
	[
		[ "concept", "iMT_PlayerMourn" ], [ "who", "Gambler" ], [ "isproduceralive", 0 ], [ "disttoproducer", 0, 199 ]
	],
	responses = SurvivorMournProducerGambler,
	group_params = none
}

{
	name = "iMT_PlayerMournProducerDeadC1Gambler",
	criteria =
	[
		[ "concept", "iMT_PlayerMourn" ], [ "who", "Gambler" ], [ "isproduceralive", 0 ], [ "disttoproducer", 0, 199 ], [ C1M1orC1M2 ], [ IsNotSurvival ]
	],
	responses = SurvivorMournProducerC1Gambler,
	group_params = none
}

{
	name = "iMT_PlayerMournBikerGambler",
	criteria =
	[
		[ "concept", "iMT_PlayerMourn" ], [ "who", "Gambler" ], [ "subject", "Biker" ], [ "dist_from_subject", 0, 199 ]
	],
	responses = SurvivorMournMechanicC1Gambler,
	group_params = none
}

{
	name = "iMT_PlayerMournManagerGambler",
	criteria =
	[
		[ "concept", "iMT_PlayerMourn" ], [ "who", "Gambler" ], [ "subject", "Manager" ], [ "dist_from_subject", 0, 199 ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/SurvivorMournProducerC102.vcd" }  //Guys, what are we going to do now?
	],
	group_params = none
}

{
	name = "iMT_PlayerMournNamVetGambler",
	criteria =
	[
		[ "concept", "iMT_PlayerMourn" ], [ "who", "Gambler" ], [ "subject", "NamVet" ], [ "dist_from_subject", 0, 199 ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/SurvivorMournProducerC101.vcd" }  //I can think of two other people I would have rather seen go first.
	],
	group_params = none
}

{
	name = "iMT_PlayerMournTeenGirlGambler",
	criteria =
	[
		[ "concept", "iMT_PlayerMourn" ], [ "who", "Gambler" ], [ "subject", "TeenGirl" ], [ "dist_from_subject", 0, 199 ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/SurvivorMournRochelle04.vcd" }  //There goes repopulating the earth.
	],
	group_params = none
}

{
	name = "iMT_PlayerNearExitGambler",
	criteria =
	[
		[ "concept", "iMT_PlayerNearExit" ], [ "who", "Gambler" ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/SafeSpotAhead01.vcd" }  //Safe house!
		{ scenename = "scenes/Gambler/SafeSpotAhead02.vcd" }  //We got a safe house!
		{ scenename = "scenes/Gambler/SafeSpotAhead03.vcd" }  //Safe house ahead!
		{ scenename = "scenes/Gambler/SafeSpotAhead04.vcd" }  //There's the safe house!
	],
	group_params = none
}

{
	name = "iMT_PlayerNiceShotGambler",
	criteria =
	[
		[ "concept", "iMT_PlayerNiceShot" ], [ "who", "Gambler" ]
	],
	responses = PlayerNiceShotGambler,
	group_params = none
}

{
	name = "iMT_PlayerNiceShotCoachGambler",
	criteria =
	[
		[ "concept", "iMT_PlayerNiceShot" ], [ "who", "Gambler" ], [ "subject", "Coach" ], [ "dist_from_subject", 0, 799 ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/NiceShotCoach01.vcd" }  //All right Coach.
		{ scenename = "scenes/Gambler/NiceShotCoach02.vcd" }  //All right Coach.
	],
	group_params = none
}

{
	name = "iMT_PlayerNiceShotCoachC1Gambler",
	criteria =
	[
		[ "concept", "iMT_PlayerNiceShot" ], [ "who", "Gambler" ], [ "subject", "Coach" ], [ "dist_from_subject", 0, 799 ], [ C1M1orC1M2 ], [ IsNotSurvival ]
	],
	responses = PlayerNiceShotGambler,
	group_params = none
}

{
	name = "iMT_PlayerNiceShotMechanicGambler",
	criteria =
	[
		[ "concept", "iMT_PlayerNiceShot" ], [ "who", "Gambler" ], [ "subject", "Mechanic" ], [ "dist_from_subject", 0, 799 ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/NiceShotMechanic01.vcd" }  //You're getting the hang of this Ellis.
		{ scenename = "scenes/Gambler/NiceShotMechanic02.vcd" }  //You're getting the hang of this Ellis.
	],
	group_params = none
}

{
	name = "iMT_PlayerNiceShotMechanicC1Gambler",
	criteria =
	[
		[ "concept", "iMT_PlayerNiceShot" ], [ "who", "Gambler" ], [ "subject", "Mechanic" ], [ "dist_from_subject", 0, 799 ], [ C1M1orC1M2 ], [ IsNotSurvival ]
	],
	responses = PlayerNiceShotGambler,
	group_params = none
}

{
	name = "iMT_PlayerNiceShotProducerGambler",
	criteria =
	[
		[ "concept", "iMT_PlayerNiceShot" ], [ "who", "Gambler" ], [ "subject", "Producer" ], [ "dist_from_subject", 0, 799 ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/NiceShotProducer01.vcd" }  //Damn, Rochelle...
		{ scenename = "scenes/Gambler/NiceShotProducer02.vcd" }  //Rochelle... damn!
		{ scenename = "scenes/Gambler/NiceShotProducer03.vcd" }  //Damn, Rochelle. Nice.
	],
	group_params = none
}

{
	name = "iMT_PlayerNiceShotProducerC1Gambler",
	criteria =
	[
		[ "concept", "iMT_PlayerNiceShot" ], [ "who", "Gambler" ], [ "subject", "Producer" ], [ "dist_from_subject", 0, 799 ], [ C1M1orC1M2 ], [ IsNotSurvival ]
	],
	responses = PlayerNiceShotGambler,
	group_params = none
}

{
	name = "iMT_PlayerNiceShotBikerGambler",
	criteria =
	[
		[ "concept", "iMT_PlayerNiceShot" ], [ "who", "Gambler" ], [ "subject", "Biker" ], [ "dist_from_subject", 0, 799 ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/DLC1_C6M3_FinaleL4D1Killing06.vcd" }  //Nice shot, Francis!
	],
	group_params = none
}

{
	name = "iMT_PlayerNiceShotBikerC1Gambler",
	criteria =
	[
		[ "concept", "iMT_PlayerNiceShot" ], [ "who", "Gambler" ], [ "subject", "Biker" ], [ "dist_from_subject", 0, 799 ], [ C1M1orC1M2 ], [ IsNotSurvival ]
	],
	responses = PlayerNiceShotGambler,
	group_params = none
}

{
	name = "iMT_PlayerNiceShotManagerGambler",
	criteria =
	[
		[ "concept", "iMT_PlayerNiceShot" ], [ "who", "Gambler" ], [ "subject", "Manager" ], [ "dist_from_subject", 0, 799 ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/DLC1_C6M3_FinaleL4D1Killing08.vcd" }  //Louis, I am beginning to like you and your gun.
		{ scenename = "scenes/Gambler/DLC1_C6M3_FinaleL4D1Killing09.vcd" }  //Louis, you are a badass with that gun.
		{ scenename = "scenes/Gambler/DLC1_C6M3_FinaleL4D1Killing11.vcd" }  //Louis, you are a badass with that gun.
	],
	group_params = none
}

{
	name = "iMT_PlayerNiceShotManagerC1Gambler",
	criteria =
	[
		[ "concept", "iMT_PlayerNiceShot" ], [ "who", "Gambler" ], [ "subject", "Manager" ], [ "dist_from_subject", 0, 799 ], [ C1M1orC1M2 ], [ IsNotSurvival ]
	],
	responses = PlayerNiceShotGambler,
	group_params = none
}

{
	name = "iMT_PlayerNiceShotTeenGirlGambler",
	criteria =
	[
		[ "concept", "iMT_PlayerNiceShot" ], [ "who", "Gambler" ], [ "subject", "TeenGirl" ], [ "dist_from_subject", 0, 799 ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/DLC1_C6M3_FinaleL4D1Killing05.vcd" }  //Zoey, all right!
		{ scenename = "scenes/Gambler/DLC1_C6M3_FinaleL4D1Killing07.vcd" }  //Nice shot, Zoey!
	],
	group_params = none
}

{
	name = "iMT_PlayerNiceShotTeenGirlC1Gambler",
	criteria =
	[
		[ "concept", "iMT_PlayerNiceShot" ], [ "who", "Gambler" ], [ "subject", "TeenGirl" ], [ "dist_from_subject", 0, 799 ], [ C1M1orC1M2 ], [ IsNotSurvival ]
	],
	responses = PlayerNiceShotGambler,
	group_params = none
}

{
	name = "iMT_PlayerPainNoiseGambler",
	criteria =
	[
		[ "concept", "iMT_PlayerPainNoise" ], [ "who", "Gambler" ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/HurtMajor01.vcd" }  //[pain noise - huh]
		{ scenename = "scenes/Gambler/HurtMajor02.vcd" }  //[pain noise - ahh]
		{ scenename = "scenes/Gambler/HurtMajor03.vcd" }  //[pain noise - oy]
		{ scenename = "scenes/Gambler/HurtMajor04.vcd" }  //[pain noise - ugh]
		{ scenename = "scenes/Gambler/HurtMajor05.vcd" }  //[pain noise - ugh]
		{ scenename = "scenes/Gambler/HurtMajor06.vcd" }  //[pain noise - ugh]
		{ scenename = "scenes/Gambler/HurtMajor07.vcd" }  //[pain noise - ugh]
		{ scenename = "scenes/Gambler/HurtMajor08.vcd" }  //[pain noise - ugh]
		{ scenename = "scenes/Gambler/HurtMajor09.vcd" }  //[pain noise - ugh]
		{ scenename = "scenes/Gambler/HurtMajor10.vcd" }  //[pain noise - ugh]
		{ scenename = "scenes/Gambler/HurtMajor11.vcd" }  //[pain noise - ugh]
	],
	group_params = none
}

{
	name = "iMT_PlayerPouncedCoachGambler",
	criteria =
	[
		[ "concept", "iMT_SurvivorWasPounced" ], [ "who", "Gambler" ], [ "subject", "Coach" ], [ "dist_from_subject", 0, 799 ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/HunterCoachPounced01.vcd" }  //Hunter's got Coach!
		{ scenename = "scenes/Gambler/HunterCoachPounced02.vcd" }  //Hunter on Coach!
	],
	group_params = none
}

{
	name = "iMT_PlayerPouncedCoachC1Gambler",
	criteria =
	[
		[ "concept", "iMT_SurvivorWasPounced" ], [ "who", "Gambler" ], [ "subject", "Coach" ], [ "dist_from_subject", 0, 799 ], [ C1M1orC1M2 ], [ IsNotSurvival ]
	],
	responses = PlayerPouncedC1Gambler,
	group_params = none
}

{
	name = "iMT_PlayerPouncedMechanicGambler",
	criteria =
	[
		[ "concept", "iMT_SurvivorWasPounced" ], [ "who", "Gambler" ], [ "subject", "Mechanic" ], [ "dist_from_subject", 0, 799 ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/HunterEllisPounced01.vcd" }  //Hunter's got Ellis!
		{ scenename = "scenes/Gambler/HunterEllisPounced02.vcd" }  //Hunter on Ellis!
		{ scenename = "scenes/Gambler/HunterEllisPounced03.vcd" }  //Hunter on Ellis!
		{ scenename = "scenes/Gambler/HunterEllisPounced04.vcd" }  //Hunter's got Ellis!
	],
	group_params = none
}

{
	name = "iMT_PlayerPouncedMechanicC1Gambler",
	criteria =
	[
		[ "concept", "iMT_SurvivorWasPounced" ], [ "who", "Gambler" ], [ "subject", "Mechanic" ], [ "dist_from_subject", 0, 799 ], [ C1M1orC1M2 ], [ IsNotSurvival ]
	],
	responses = PlayerPouncedC1Gambler,
	group_params = none
}

{
	name = "iMT_PlayerPouncedProducerGambler",
	criteria =
	[
		[ "concept", "iMT_SurvivorWasPounced" ], [ "who", "Gambler" ], [ "subject", "Producer" ], [ "dist_from_subject", 0, 799 ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/HunterRochellePounced01.vcd" }  //Hunter's got Rochelle!
		{ scenename = "scenes/Gambler/HunterRochellePounced02.vcd" }  //Hunter on Rochelle!
	],
	group_params = none
}

{
	name = "iMT_PlayerPouncedProducerC1Gambler",
	criteria =
	[
		[ "concept", "iMT_SurvivorWasPounced" ], [ "who", "Gambler" ], [ "subject", "Producer" ], [ "dist_from_subject", 0, 799 ], [ C1M1orC1M2 ], [ IsNotSurvival ]
	],
	responses = PlayerPouncedProducerC1Gambler,
	group_params = none
}

{
	name = "iMT_PlayerPouncedBikerGambler",
	criteria =
	[
		[ "concept", "iMT_SurvivorWasPounced" ], [ "who", "Gambler" ], [ "subject", "Biker" ], [ "dist_from_subject", 0, 799 ]
	],
	responses = PlayerPouncedC1Gambler,
	group_params = none
}

{
	name = "iMT_PlayerPouncedManagerGambler",
	criteria =
	[
		[ "concept", "iMT_SurvivorWasPounced" ], [ "who", "Gambler" ], [ "subject", "Manager" ], [ "dist_from_subject", 0, 799 ]
	],
	responses = PlayerPouncedC1Gambler,
	group_params = none
}

{
	name = "iMT_PlayerPouncedNamVetGambler",
	criteria =
	[
		[ "concept", "iMT_SurvivorWasPounced" ], [ "who", "Gambler" ], [ "subject", "NamVet" ], [ "dist_from_subject", 0, 799 ]
	],
	responses = PlayerPouncedC1Gambler,
	group_params = none
}

{
	name = "iMT_PlayerPouncedTeenGirlGambler",
	criteria =
	[
		[ "concept", "iMT_SurvivorWasPounced" ], [ "who", "Gambler" ], [ "subject", "TeenGirl" ], [ "dist_from_subject", 0, 799 ]
	],
	responses = PlayerPouncedProducerC1Gambler,
	group_params = none
}

{
	name = "iMT_PlayerReloadingGambler",
	criteria =
	[
		[ "concept", "iMT_PlayerReloading" ], [ "who", "Gambler" ], [ "tankactive", 0 ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/Reloading01.vcd" }  //Reloading!
		{ scenename = "scenes/Gambler/Reloading02.vcd" }  //Reloading!
		{ scenename = "scenes/Gambler/Reloading03.vcd" }  //Reloading!
		{ scenename = "scenes/Gambler/Reloading04.vcd" }  //Reloading!
		{ scenename = "scenes/Gambler/Reloading05.vcd" }  //Reloading!
		{ scenename = "scenes/Gambler/Reloading06.vcd" }  //Reloading!
		{ scenename = "scenes/Gambler/Reloading07.vcd" }  //Reloading!
	],
	group_params = none
}

{
	name = "iMT_PlayerReloadingC4M2Gambler",
	criteria =
	[
		[ "concept", "iMT_PlayerReloading" ], [ "who", "Gambler" ], [ "tankactive", 0 ], [ "map", "c4m2_sugarmill_a" ], [ "world_auto_gamblerinwitchville", 1 ], [ IsNotSaidSafeSpotAhead ]
	],
	responses = SurvivorReloadingQuietGambler,
	group_params = none
}

{
	name = "iMT_PlayerReloadingIntenseGambler",
	criteria =
	[
		[ "concept", "iMT_PlayerReloading" ], [ "who", "Gambler" ], [ "tankactive", 0 ], [ "incombatmusic", 1 ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/ReloadIntense01.vcd" }  //Reloading!
		{ scenename = "scenes/Gambler/ReloadIntense02.vcd" }  //Reloading here!
		{ scenename = "scenes/Gambler/ReloadIntense03.vcd" }  //Gotta reload!
		{ scenename = "scenes/Gambler/ReloadIntense04.vcd" }  //Reloading!
		{ scenename = "scenes/Gambler/ReloadIntense05.vcd" }  //Reloading!
	],
	group_params = none
}

{
	name = "iMT_PlayerReloadingQuietGambler",
	criteria =
	[
		[ "concept", "iMT_PlayerReloading" ], [ "who", "Gambler" ], [ "tankactive", 0 ], [ "incombatmusic", 0 ], [ IsWitchNear ], [ IsNotWitchAggro ]
	],
	responses = SurvivorReloadingQuietGambler,
	group_params = none
}

{
	name = "iMT_PlayerReloadingTankGambler",
	criteria =
	[
		[ "concept", "iMT_PlayerReloading" ], [ "who", "Gambler" ], [ "tankactive", 1 ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/BattleCryTank01.vcd" }  //Kill the tank!
		{ scenename = "scenes/Gambler/BattleCryTank02.vcd" }  //Shoot the tank!
		{ scenename = "scenes/Gambler/BattleCryTank03.vcd" }  //Shoot the damn tank!
		{ scenename = "scenes/Gambler/BattleCryTank04.vcd" }  //Shoot it! Shoot it!
		{ scenename = "scenes/Gambler/BattleCryTank05.vcd" }  //Everyone shoot the tank!
		{ scenename = "scenes/Gambler/BattleCryTank06.vcd" }  //You, SHOOT THE TANK!
		{ scenename = "scenes/Gambler/BattleCryTank07.vcd" }  //KEEP SHOOTING!
	],
	group_params = none
}

{
	name = "iMT_PlayerReloadingTankC1Gambler",
	criteria =
	[
		[ "concept", "iMT_PlayerReloading" ], [ "who", "Gambler" ], [ "tankactive", 1 ], [ C1M1orC1M2 ], [ IsNotSurvival ], [ NoKnowTank ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/HeardTanklC101.vcd" }  //I hope that's not bullet proof.
		{ scenename = "scenes/Gambler/HeardTanklC102.vcd" }  //We are screwed.
		{ scenename = "scenes/Gambler/HeardTanklC103.vcd" }  //Maybe if we don't move it won't see us.
		{ scenename = "scenes/Gambler/HeardTanklC104.vcd" }  //Okay, that's reason to panic.
		{ scenename = "scenes/Gambler/HeardTanklC105.vcd" }  //What in the hell sign of the apocalypse is that?
		{ scenename = "scenes/Gambler/HeardTanklC106.vcd" }  //I hope that's not bullet proof.
		{ scenename = "scenes/Gambler/HeardTanklC107.vcd" }  //What in the hell sign of the apocalypse is that?
		{ scenename = "scenes/Gambler/HeardTanklC108.vcd" }  //Okay, that's reason to panic.
		{ scenename = "scenes/Gambler/HeardTanklC109.vcd" }  //Maybe if we don't move it won't see us.
		{ scenename = "scenes/Gambler/HeardTanklC110.vcd" }  //We are screwed.
	],
	group_params = none
}

{
	name = "iMT_PlayerSuggestHealthGambler",
	criteria =
	[
		[ "concept", "iMT_PlayerSuggestHealth" ], [ "who", "Gambler" ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/SuggestHealth01.vcd" }  //Heal up!
		{ scenename = "scenes/Gambler/SuggestHealth02.vcd" }  //Heal up!
		{ scenename = "scenes/Gambler/SuggestHealth03.vcd" }  //Good time to heal.
		{ scenename = "scenes/Gambler/SuggestHealth04.vcd" }  //This would be a good time to heal.
		{ scenename = "scenes/Gambler/SuggestHealth05.vcd" }  //Maybe you could heal up now.
		{ scenename = "scenes/Gambler/SuggestHealth06.vcd" }  //Heal if you need to.
		{ scenename = "scenes/Gambler/SuggestHealthC101.vcd" }  //This might be a good time to heal.
		{ scenename = "scenes/Gambler/SuggestHealthC102.vcd" }  //Time for people to heal.
		{ scenename = "scenes/Gambler/SuggestHealthC103.vcd" }  //Don't forget you can heal yourself.
		{ scenename = "scenes/Gambler/SuggestHealthC104.vcd" }  //This is a good time to heal.
		{ scenename = "scenes/Gambler/SuggestHealthC105.vcd" }  //Time for people to heal.
	],
	group_params = none
}

{
	name = "iMT_PlayerSuggestHealthC1Gambler",
	criteria =
	[
		[ "concept", "iMT_PlayerSuggestHealth" ], [ "who", "Gambler" ], [ C1M1orC1M2 ], [ IsNotSurvival ]
	],
	responses = PlayerSuggestHealthC1Gambler,
	group_params = none
}

{
	name = "iMT_PlayerSuggestHealthCoachGambler",
	criteria =
	[
		[ "concept", "iMT_PlayerSuggestHealth" ], [ "who", "Gambler" ], [ "subject", "Coach" ], [ "dist_from_subject", 0, 199 ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/SuggestHealthCoach01.vcd" }  //Coach, you should heal.
		{ scenename = "scenes/Gambler/SuggestHealthCoach02.vcd" }  //Coach, don't forget about that health kit.
		{ scenename = "scenes/Gambler/SuggestHealthCoach03.vcd" }  //Hey Coach, heal.
		{ scenename = "scenes/Gambler/SuggestHealthCoach04.vcd" }  //Hey Coach, heal.
		{ scenename = "scenes/Gambler/SuggestHealthCoach05.vcd" }  //Coach, you should maybe heal.
		{ scenename = "scenes/Gambler/SuggestHealthCoach06.vcd" }  //Coach, you should heal.
	],
	group_params = none
}

{
	name = "iMT_PlayerSuggestHealthCoachC1Gambler",
	criteria =
	[
		[ "concept", "iMT_PlayerSuggestHealth" ], [ "who", "Gambler" ], [ "subject", "Coach" ], [ "dist_from_subject", 0, 199 ], [ C1M1orC1M2 ], [ IsNotSurvival ]
	],
	responses = PlayerSuggestHealthC1Gambler,
	group_params = none
}

{
	name = "iMT_PlayerSuggestHealthMechanicGambler",
	criteria =
	[
		[ "concept", "iMT_PlayerSuggestHealth" ], [ "who", "Gambler" ], [ "subject", "Mechanic" ], [ "dist_from_subject", 0, 199 ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/SuggestHealthEllis01.vcd" }  //Ellis, heal up.
		{ scenename = "scenes/Gambler/SuggestHealthEllis02.vcd" }  //Time to heal Ellis.
		{ scenename = "scenes/Gambler/SuggestHealthEllis03.vcd" }  //Come on Ellis, don't be a hero. Use your health kit.
		{ scenename = "scenes/Gambler/SuggestHealthEllis04.vcd" }  //Come on Ellis, don't be a hero. Use your health kit.
	],
	group_params = none
}

{
	name = "iMT_PlayerSuggestHealthMechanicC1Gambler",
	criteria =
	[
		[ "concept", "iMT_PlayerSuggestHealth" ], [ "who", "Gambler" ], [ "subject", "Mechanic" ], [ "dist_from_subject", 0, 199 ], [ C1M1orC1M2 ], [ IsNotSurvival ]
	],
	responses = PlayerSuggestHealthC1Gambler,
	group_params = none
}

{
	name = "iMT_PlayerSuggestHealthProducerGambler",
	criteria =
	[
		[ "concept", "iMT_PlayerSuggestHealth" ], [ "who", "Gambler" ], [ "subject", "Producer" ], [ "dist_from_subject", 0, 199 ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/SuggestHealthRochell01.vcd" }  //Rochelle, you don't look so good.
		{ scenename = "scenes/Gambler/SuggestHealthRochell02.vcd" }  //Rochelle, we need you, heal up.
		{ scenename = "scenes/Gambler/SuggestHealthRochell03.vcd" }  //Hey Ro, don't forget that health kit.
		{ scenename = "scenes/Gambler/SuggestHealthRochell04.vcd" }  //Hey Ro, don't forget that health kit.
		{ scenename = "scenes/Gambler/SuggestHealthRochell05.vcd" }  //Rochelle, you don't look so good.
		{ scenename = "scenes/Gambler/SuggestHealthRochell06.vcd" }  //Rochelle, we need you, heal up.
	],
	group_params = none
}

{
	name = "iMT_PlayerSuggestHealthProducerC1Gambler",
	criteria =
	[
		[ "concept", "iMT_PlayerSuggestHealth" ], [ "who", "Gambler" ], [ "subject", "Producer" ], [ "dist_from_subject", 0, 199 ], [ C1M1orC1M2 ], [ IsNotSurvival ]
	],
	responses = PlayerSuggestHealthC1Gambler,
	group_params = none
}

{
	name = "iMT_PlayerTeamKillGambler",
	criteria =
	[
		[ "concept", "iMT_PlayerTeamKill" ], [ "who", "Gambler" ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/TeamKillAccident01.vcd" }  //Don't you think we should be killing the zombies instead?
		{ scenename = "scenes/Gambler/TeamKillAccident02.vcd" }  //What in the hell kind of strategy is that?
		{ scenename = "scenes/Gambler/TeamKillAccident03.vcd" }  //What?!!? This is hard enough without you helping the freaks!
	],
	group_params = none
}

{
	name = "iMT_PlayerTransitionGambler",
	criteria =
	[
		[ "concept", "iMT_PlayerTransition" ], [ "who", "Gambler" ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/TransitionClose01.vcd" }  //That was WAY too close!
		{ scenename = "scenes/Gambler/TransitionClose02.vcd" }  //That was way, WAY too close!
		{ scenename = "scenes/Gambler/TransitionClose04.vcd" }  //That my friends, is how you do it!
		{ scenename = "scenes/Gambler/TransitionClose05.vcd" }  //Happy New Year!
		{ scenename = "scenes/Gambler/TransitionClose07.vcd" }  //God DAMN, that was close!
		{ scenename = "scenes/Gambler/TransitionClose08.vcd" }  //That was a close one.
		{ scenename = "scenes/Gambler/TransitionClose12.vcd" }  //That was a little too close.
	],
	group_params = none
}

{
	name = "iMT_PlayerTransitionCloseGambler",
	criteria =
	[
		[ "concept", "iMT_PlayerTransition" ], [ "who", "Gambler" ], [ "numberofteamdead", 1, null ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/TransitionClose03.vcd" }  //Man, we got lucky!
		{ scenename = "scenes/Gambler/TransitionClose06.vcd" }  //We got lucky!
		{ scenename = "scenes/Gambler/TransitionClose10.vcd" }  //Well, that was unpleasant.
		{ scenename = "scenes/Gambler/TransitionClose11.vcd" }  //We made that by the skin of our teeth.
	],
	group_params = none
}

{
	name = "iMT_PlayerTransitionSoloGambler",
	criteria =
	[
		[ "concept", "iMT_PlayerTransition" ], [ "who", "Gambler" ], [ "numberofteamdead", 1, null ], [ "numberofteamalive", 1 ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/TransitionClose09.vcd" }  //At least I made it.
	],
	group_params = none
}

{
	name = "iMT_PlayerWitchChasingGambler",
	criteria =
	[
		[ "concept", "iMT_PlayerWitchChasing" ], [ "who", "Gambler" ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/WitchChasing01.vcd" }  //Ahhh I pissed the witch off!
		{ scenename = "scenes/Gambler/WitchChasing02.vcd" }  //This bitch is chasing me!
		{ scenename = "scenes/Gambler/WitchChasing03.vcd" }  //Witch coming! Witch coming!
		{ scenename = "scenes/Gambler/WitchChasing04.vcd" }  //Shoot the witch! Shoot the witch! Shoot the witch!
		{ scenename = "scenes/Gambler/WitchChasing05.vcd" }  //Shoot the witch! Shoot the witch! Shoot the witch! What are you doing? Shoot her!
		{ scenename = "scenes/Gambler/WitchChasing06.vcd" }  //Ahhh I pissed the witch off!
	],
	group_params = none
}

{
	name = "iMT_PlayerWitchChasingC1Gambler",
	criteria =
	[
		[ "concept", "iMT_PlayerWitchChasing" ], [ "who", "Gambler" ], [ C1M1orC1M2 ], [ IsNotSurvival ], [ NoKnowWitch ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/WitchChasing02.vcd" }  //This bitch is chasing me!
	],
	group_params = none
}

{
	name = "iMT_PlayerWitchChasingC6M1Gambler",
	criteria =
	[
		[ "concept", "iMT_PlayerWitchChasing" ], [ "who", "Gambler" ], [ "map", "c6m1_riverbank" ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/DLC1_C6M1_WeddingWitchChasing01.vcd" }  //Here comes the bride!
	],
	group_params = none
}

{
	name = "iMT_SurvivorCaughtVomitGambler",
	criteria =
	[
		[ "concept", "iMT_PlayerVomitInFace" ], [ "who", "Gambler" ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/BoomerReaction01.vcd" }  //Ohh god damn it!
		{ scenename = "scenes/Gambler/BoomerReaction02.vcd" }  //Ahhh this is some nasty shit.
		{ scenename = "scenes/Gambler/BoomerReaction04.vcd" }  //I'm blind.
	],
	group_params = none
}

{
	name = "iMT_SurvivorCaughtVomit%Gambler",
	criteria =
	[
		[ "concept", "iMT_PlayerVomitInFace" ], [ "who", "Gambler" ], [ "randomnum", 0, 5 ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/BoomerReaction03.vcd" }  //God damn it! I am covered in vomit again.
	],
	group_params = none
}

//--------------------------------------------------------------------------------------------------
// Character-specific
//--------------------------------------------------------------------------------------------------

{
	name = "iMT_AllAboardGambler",
	criteria =
	[
		[ "concept", "iMT_AllAboard" ], [ "who", "Gambler" ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/Cmty_LineSend02.vcd" }  //Hey Ellis, all aboard! Toot! Toot!
		{ scenename = "scenes/Gambler/Cmty_LineSend03.vcd" }  //All aboard! Toot! Toot!
	],
	group_params = none
}

{
	name = "iMT_AngelGambler",
	criteria =
	[
		[ "concept", "iMT_Angel" ], [ "who", "Gambler" ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/DLC1_C6M1_WeddingWitch09.vcd" }  //Ellis look, it's another angel.
		{ scenename = "scenes/Gambler/DLC1_C6M1_WeddingWitch10.vcd" }  //Hey, Ellis look, it's another angel.
	],
	group_params = none
}

{
	name = "iMT_AttractiveGambler",
	criteria =
	[
		[ "concept", "iMT_Attractive" ], [ "who", "Gambler" ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/DLC1_C6M1_InitialMeeting11.vcd" }  //Or: I could try is being more attractive to grease ball bikers.
		{ scenename = "scenes/Gambler/DLC1_C6M1_InitialMeeting12.vcd" }  //Or: I could try is being more attractive to grease ball bikers.
	],
	group_params = none
}

{
	name = "iMT_BreakReacGambler",
	criteria =
	[
		[ "concept", "iMT_BreakReac" ], [ "who", "Gambler" ], [ "coughing", 0 ], [ "incapacitated", 0 ], [ "speaking", 0], [ "randomnum", 0, 40 ], [ IsTalk ], [ IsTalkGambler ], [ IsWorldTalkGambler ], [ IssuerClose ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/DLC1_C6M2_Phase2InWater19.vcd" }  //Bad advice. BAD advice.
	],
	group_params = none
}

{
	name = "iMT_DepressingGambler",
	criteria =
	[
		[ "concept", "iMT_Depressing" ], [ "who", "Gambler" ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/DLC1_C6M1_Wedding03.vcd" }  //Oh Christ, this is more depressing than the zombies.
	],
	group_params = none
}

{
	name = "iMT_FantasyGambler",
	criteria =
	[
		[ "concept", "iMT_Fantasy" ], [ "who", "Gambler" ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/DLC1_C6M1_WeddingWitchDead01.vcd" }  //That has been a fantasy of mine for a long time.
	],
	group_params = none
}

{
	name = "iMT_FishGambler",
	criteria =
	[
		[ "concept", "iMT_Fish" ], [ "who", "Gambler" ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/DLC1_C6M3_FinaleCinematic03.vcd" }  //Don't worry, Ellis, plenty of fish in the sea.
		{ scenename = "scenes/Gambler/DLC1_C6M3_FinaleCinematic05.vcd" }  //Ellis, don't worry. Plenty of fish in the sea.
	],
	group_params = none
}

{
	name = "iMT_GameGambler",
	criteria =
	[
		[ "concept", "iMT_Game" ], [ "who", "Gambler" ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/World304.vcd" }  //Okay, anyone up for a game?
		{ scenename = "scenes/Gambler/WorldC2M206.vcd" }  //These are not games of chance.
	],
	group_params = none
}

{
	name = "iMT_GetRoomGambler",
	criteria =
	[
		[ "concept", "iMT_GetRoom" ], [ "who", "Gambler" ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/DLC1_C6M3_FinaleChat09.vcd" }  //Should we leave you two alone?
		{ scenename = "scenes/Gambler/DLC1_C6M3_FinaleChat10.vcd" }  //Maybe we should leave you two alone?
		{ scenename = "scenes/Gambler/DLC1_C6M3_FinaleChat11.vcd" }  //Should we leave you two alone?
		{ scenename = "scenes/Gambler/DLC1_C6M3_FinaleChat12.vcd" }  //Get a room.
		{ scenename = "scenes/Gambler/DLC1_C6M3_FinaleChat13.vcd" }  //Maybe you two should get a room.
	],
	group_params = none
}

{
	name = "iMT_HavingFunGambler",
	criteria =
	[
		[ "concept", "iMT_HavingFun" ], [ "who", "Gambler" ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/Cmty_Frostbite04.vcd" }  //Ellis, do not look like you're having fun.
		{ scenename = "scenes/Gambler/Cmty_Frostbite05.vcd" }  //Ellis, do not look like you're having fun.
	],
	group_params = none
}

{
	name = "iMT_HippieGambler",
	criteria =
	[
		[ "concept", "iMT_Hippie" ], [ "who", "Gambler" ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/WorldC2M441.vcd" }  //What are you, an unfriendly hippie? I thought you all had to be friendly?
		{ scenename = "scenes/Gambler/WorldC2M456.vcd" }  //Always a stinking hippie. I swear to god, it always come back to making a stinking hippie happy.
		{ scenename = "scenes/Gambler/WorldC2M487.vcd" }  //Goodbye, my hippie friend!
		{ scenename = "scenes/Gambler/WorldC2M488.vcd" }  //Goodbye, Mr. Hippie!
	],
	group_params = none
}

{
	name = "iMT_HoneymoonGambler",
	criteria =
	[
		[ "concept", "iMT_Honeymoon" ], [ "who", "Gambler" ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/DLC1_C6M1_WeddingWitchDead11.vcd" }  //Honeymoon's over. Bitch.
	],
	group_params = none
}

{
	name = "iMT_LazyAssGambler",
	criteria =
	[
		[ "concept", "iMT_LazyAss" ], [ "who", "Gambler" ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/DLC1_C6M3_FinaleChat03.vcd" }  //That's funny. I knew your lazy ass would still be here.
	],
	group_params = none
}

{
	name = "iMT_MarriageReacGambler",
	criteria =
	[
		[ "concept", "iMT_MarriageReac" ], [ "who", "Gambler" ], [ "coughing", 0 ], [ "incapacitated", 0 ], [ "speaking", 0], [ "randomnum", 0, 40 ], [ IsTalk ], [ IsTalkGambler ], [ IsWorldTalkGambler ], [ IssuerClose ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/DLC1_C6M1_WeddingPostWitch02.vcd" }  //Marrying her is the last thing you should do.
	],
	group_params = none
}

{
	name = "iMT_NickOCDReacGambler",
	criteria =
	[
		[ "concept", "iMT_NickOCDReac" ], [ "who", "Gambler" ], [ "coughing", 0 ], [ "incapacitated", 0 ], [ "speaking", 0], [ "randomnum", 0, 40 ], [ IsTalk ], [ IsTalkGambler ], [ IsWorldTalkGambler ], [ IssuerClose ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/DLC1_C6M2_SafeRoomConvo21.vcd" }  //Yeah, hahaha a little bit more hand sanitizer and we wouldn't be in this mess.
	],
	group_params = none
}

{
	name = "iMT_NotDieGambler",
	criteria =
	[
		[ "concept", "iMT_NotDie" ], [ "who", "Gambler" ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/WorldC5MGoingToDie02.vcd" }  //I have not come this far to die now.
	],
	group_params = none
}

{
	name = "iMT_NotDieC3Gambler",
	criteria =
	[
		[ "concept", "iMT_NotDie" ], [ "who", "Gambler" ], [ IsInSwamp ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/WorldC3MGoingToDie01.vcd" }  //I am not dying in this swamp.
		{ scenename = "scenes/Gambler/WorldC3MGoingToDie02.vcd" }  //I am not going to be gator food.
	],
	group_params = none
}

{
	name = "iMT_NotDieC4Gambler",
	criteria =
	[
		[ "concept", "iMT_NotDie" ], [ "who", "Gambler" ], [ IsCampaign4 ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/WorldC4MGoingToDie01.vcd" }  //Never get out of the boat. Never get out of the boat. Never get out of the boat.
		{ scenename = "scenes/Gambler/WorldC4MGoingToDie02.vcd" }  //I cannot believe I am looking forward to getting back on that boat.
		{ scenename = "scenes/Gambler/WorldC4MGoingToDie03.vcd" }  //Some milk run this turned out to be.
		{ scenename = "scenes/Gambler/WorldC4MGoingToDie04.vcd" }  //Should have just kept floating down the damn river.
		{ scenename = "scenes/Gambler/WorldC4MGoingToDie05.vcd" }  //What in the hell were we thinking stopping here?
	],
	group_params = none
}

{
	name = "iMT_NotDieC5Gambler",
	criteria =
	[
		[ "concept", "iMT_NotDie" ], [ "who", "Gambler" ], [ IsCampaign5 ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/WorldC5MGoingToDie01.vcd" }  //I am not going to die in this city.
		{ scenename = "scenes/Gambler/WorldC5MGoingToDie02.vcd" }  //I have not come this far to die now.
	],
	group_params = none
}

{
	name = "iMT_QuietGambler",
	criteria =
	[
		[ "concept", "iMT_Quiet" ], [ "who", "Gambler" ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/EllisInterrupt21.vcd" }  //Why don't we just try quiet time for a while?
		{ scenename = "scenes/Gambler/EllisInterrupt22.vcd" }  //Hey, Ellis. Shut-up contest, ready? One, two, three, go!
	],
	group_params = none
}

{
	name = "iMT_Quiet%Gambler",
	criteria =
	[
		[ "concept", "iMT_Quiet" ], [ "who", "Gambler" ], [ "randomnum", 0, 30 ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/WorldC5M3B13.vcd" }  //Shut up, Ellis.
	],
	group_params = none
}

{
	name = "iMT_ScrewYouGambler",
	criteria =
	[
		[ "concept", "iMT_ScrewYou" ], [ "who", "Gambler" ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/DLC1_C6M3_FinaleChat07.vcd" }  //You know what? Screw the both of you. Okay? So what are we doing here?
	],
	group_params = none
}

{
	name = "iMT_SevensomeGambler",
	criteria =
	[
		[ "concept", "iMT_Sevensome" ], [ "who", "Gambler" ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/DLC1_C6M3_Loss08.vcd" }  //Should we join forces?
		{ scenename = "scenes/Gambler/DLC1_C6M3_Loss09.vcd" }  //You want to make this a... sevensome?
	],
	group_params = none
}

{
	name = "iMT_ShitAirGambler",
	criteria =
	[
		[ "concept", "iMT_ShitAir" ], [ "who", "Gambler" ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/DLC1_C6M2_Phase2InWater04.vcd" }  //I am breathing shit air into my lungs, it is being absorbed into my bloodstream. I am literally full of shit.
	],
	group_params = none
}

{
	name = "iMT_TattoosReacGambler",
	criteria =
	[
		[ "concept", "iMT_TattoosReac" ], [ "who", "Gambler" ], [ "coughing", 0 ], [ "incapacitated", 0 ], [ "speaking", 0], [ IsTalk ], [ IsTalkGambler ], [ IsWorldTalkGambler ], [ IssuerClose ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/DLC1_C6M2_Tattoo11.vcd" }  //That is never going to happen, Ellis.
		{ scenename = "scenes/Gambler/DLC1_C6M2_Tattoo12.vcd", followup = RThen( "Mechanic", "iMT_Tattoos2", null, 0.3 ) }  //I'm gonna get a tattoo that says "no".
	],
	group_params = none
}

{
	name = "iMT_TestGambler",
	criteria =
	[
		[ "concept", "iMT_Test" ], [ "who", "Gambler" ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/DLC1_C6M2_Bridge2Up01.vcd" }  //Hey Ellis... you test it.
		{ scenename = "scenes/Gambler/DLC1_C6M2_Bridge2Up02.vcd" }  //Looks real safe. Ellis, you go first.
		{ scenename = "scenes/Gambler/DLC1_C6M2_Bridge2Up03.vcd" }  //Ellis... you test it.
	],
	group_params = none
}

{
	name = "iMT_TrickedGambler",
	criteria =
	[
		[ "concept", "iMT_Tricked" ], [ "who", "Gambler" ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/WorldC2M1B15.vcd" }  //I can't believe you fell for that.
	],
	group_params = none
}

//--------------------------------------------------------------------------------------------------
// Overrides
//--------------------------------------------------------------------------------------------------

{
	name = "iMT_PlayerAnswerLostCallGambler",
	criteria =
	[
		[ "concept", "PlayerAnswerLostCall" ], [ "who", "Gambler" ], [ "coughing", 0 ], [ "numberofteamalive", 4, null ], [ "numberofteamdead", 0 ], [ "disttoclosestsurvivor", 0, 499 ], [ "randomnum", 0, 10 ], [ IsTalk ], [ IsTalkGambler ], [ IsWorldTalkGambler ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/ScenarioJoinLast01.vcd" }  //We're all here.
	],
	group_params = none
}

{
	name = "iMT_PlayerAreaClearGambler",
	criteria =
	[
		[ "concept", "PlayerAreaClear" ], [ "who", "Gambler" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkGambler ], [ IsWorldTalkGambler ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/Defibrillator06.vcd" }  //Clear!
	],
	group_params = none
}

{
	name = "iMT_PlayerHeardBoomerGambler",
	criteria =
	[
		[ "concept", "PlayerHeardBoomer" ], [ "who", "Gambler" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkGambler ], [ IsWorldTalkGambler ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/HeardBoomer01.vcd" }  //Keep a lookout. I hear a boomer.
		{ scenename = "scenes/Gambler/HeardBoomer02.vcd" }  //I hear a boomer.
		{ scenename = "scenes/Gambler/HeardBoomer03.vcd" }  //You hear that boomer?
		{ scenename = "scenes/Gambler/HeardBoomer04.vcd" }  //You hear that boomer?
		{ scenename = "scenes/Gambler/HeardBoomer05.vcd" }  //You hear that boomer? Don't let him spew on you.
		{ scenename = "scenes/Gambler/HeardBoomer06.vcd" }  //Boomer around. Don't shoot him if he's near me! OKAY?
	],
	group_params = none
}

{
	name = "iMT_PlayerHeardBoomerC1Gambler",
	criteria =
	[
		[ "concept", "PlayerHeardBoomer" ], [ "who", "Gambler" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkGambler ], [ IsWorldTalkGambler ], [ C1M1orC1M2 ], [ IsNotSurvival ], [ NoKnowBoomer ]
	],
	responses = PlayerHeardSpecialC1Gambler,
	group_params = none
}

{
	name = "iMT_PlayerHeardChargerGambler",
	criteria =
	[
		[ "concept", "PlayerHeardCharger" ], [ "who", "Gambler" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkGambler ], [ IsWorldTalkGambler ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/HeardCharger01.vcd" }  //Keep your eyes peeled, I hear a charger.
		{ scenename = "scenes/Gambler/HeardCharger02.vcd" }  //I hear a charger.
		{ scenename = "scenes/Gambler/HeardCharger03.vcd" }  //Charger around, get ready.
		{ scenename = "scenes/Gambler/HeardCharger04.vcd" }  //Charger around, get ready.
		{ scenename = "scenes/Gambler/HeardCharger05.vcd" }  //Do you hear that charger?
		{ scenename = "scenes/Gambler/HeardCharger06.vcd" }  //I hear a charger.
		{ scenename = "scenes/Gambler/HeardCharger07.vcd" }  //You hear that charger?
	],
	group_params = none
}

{
	name = "iMT_PlayerHeardChargerC1Gambler",
	criteria =
	[
		[ "concept", "PlayerHeardCharger" ], [ "who", "Gambler" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkGambler ], [ IsWorldTalkGambler ], [ C1M1orC1M2 ], [ IsNotSurvival ], [ NoKnowCharger ]
	],
	responses = PlayerHeardSpecialC1Gambler,
	group_params = none
}

{
	name = "iMT_PlayerHeardHunterGambler",
	criteria =
	[
		[ "concept", "PlayerHeardHunter" ], [ "who", "Gambler" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkGambler ], [ IsWorldTalkGambler ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/HeardHunter01.vcd" }  //You hear that hunter?
		{ scenename = "scenes/Gambler/HeardHunter02.vcd" }  //Pay attention, hunter's around.
		{ scenename = "scenes/Gambler/HeardHunter03.vcd" }  //I hear a hunter.
	],
	group_params = none
}

{
	name = "iMT_PlayerHeardHunterC1Gambler",
	criteria =
	[
		[ "concept", "PlayerHeardHunter" ], [ "who", "Gambler" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkGambler ], [ IsWorldTalkGambler ], [ C1M1orC1M2 ], [ IsNotSurvival ], [ NoKnowHunter ]
	],
	responses = PlayerHeardSpecialC1Gambler,
	group_params = none
}

{
	name = "iMT_PlayerHeardJockeyGambler",
	criteria =
	[
		[ "concept", "PlayerHeardJockey" ], [ "who", "Gambler" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkGambler ], [ IsWorldTalkGambler ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/HeardJockey01.vcd" }  //I can hear a jockey.
		{ scenename = "scenes/Gambler/HeardJockey02.vcd" }  //Jockey's around.
		{ scenename = "scenes/Gambler/HeardJockey03.vcd" }  //One of those little jockey bastards is around.
		{ scenename = "scenes/Gambler/HeardJockey04.vcd" }  //I can hear a jockey.
		{ scenename = "scenes/Gambler/HeardJockey05.vcd" }  //Jockey's around.
		{ scenename = "scenes/Gambler/HeardJockey06.vcd" }  //One of those little jockey bastards is around.
	],
	group_params = none
}

{
	name = "iMT_PlayerHeardJockeyC1Gambler",
	criteria =
	[
		[ "concept", "PlayerHeardJockey" ], [ "who", "Gambler" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkGambler ], [ IsWorldTalkGambler ], [ C1M1orC1M2 ], [ IsNotSurvival ], [ NoKnowJockey ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/HeardSpecialC103.vcd" }  //What in the hell is that noise?
		{ scenename = "scenes/Gambler/HeardSpecialC104.vcd" }  //You hear that? I guess zombies weren't bad enough.
		{ scenename = "scenes/Gambler/HeardSpecialC105.vcd" }  //You hear that?
		{ scenename = "scenes/Gambler/HeardSpecialC106.vcd" }  //Can you hear that?
		{ scenename = "scenes/Gambler/HeardSpecialC107.vcd" }  //What is that noise?
		{ scenename = "scenes/Gambler/HeardSpecialC108.vcd" }  //I have no idea what that noise is.
		{ scenename = "scenes/Gambler/HeardSpecialC109.vcd" }  //Something we're gonna have to kill.
	],
	group_params = none
}

{
	name = "iMT_PlayerHeardSmokerGambler",
	criteria =
	[
		[ "concept", "PlayerHeardSmoker" ], [ "who", "Gambler" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkGambler ], [ IsWorldTalkGambler ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/HeardSmoker01.vcd" }  //There's a smoker around here.
		{ scenename = "scenes/Gambler/HeardSmoker02.vcd" }  //Smoker's around.
		{ scenename = "scenes/Gambler/HeardSmoker03.vcd" }  //I hear a smoker.
		{ scenename = "scenes/Gambler/HeardSmoker04.vcd" }  //There's a smoker around here.
	],
	group_params = none
}

{
	name = "iMT_PlayerHeardSmokerC1Gambler",
	criteria =
	[
		[ "concept", "PlayerHeardSmoker" ], [ "who", "Gambler" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkGambler ], [ IsWorldTalkGambler ], [ C1M1orC1M2 ], [ IsNotSurvival ], [ NoKnowSmoker ]
	],
	responses = PlayerHeardSpecialC1Gambler,
	group_params = none
}

{
	name = "iMT_PlayerHeardSpitterGambler",
	criteria =
	[
		[ "concept", "PlayerHeardSpitter" ], [ "who", "Gambler" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkGambler ], [ IsWorldTalkGambler ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/HeardSpitter01.vcd" }  //Spitter around.
		{ scenename = "scenes/Gambler/HeardSpitter02.vcd" }  //I hear a spitter.
		{ scenename = "scenes/Gambler/HeardSpitter03.vcd" }  //There's a spitter around.
		{ scenename = "scenes/Gambler/HeardSpitter04.vcd" }  //There's a spitter around.
		{ scenename = "scenes/Gambler/HeardSpitter05.vcd" }  //I hear a spitter.
		{ scenename = "scenes/Gambler/HeardSpitter06.vcd" }  //There's a spitter around.
	],
	group_params = none
}

{
	name = "iMT_PlayerHeardSpitterC1Gambler",
	criteria =
	[
		[ "concept", "PlayerHeardSpitter" ], [ "who", "Gambler" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkGambler ], [ IsWorldTalkGambler ], [ C1M1orC1M2 ], [ IsNotSurvival ], [ NoKnowSpitter ]
	],
	responses = PlayerHeardSpecialC1Gambler,
	group_params = none
}

{
	name = "iMT_PlayerHeardWitchGambler",
	criteria =
	[
		[ "concept", "PlayerHeardWitch" ], [ "who", "Gambler" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkGambler ], [ IsWorldTalkGambler ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/HeardWitch01.vcd" }  //Sounds like a witch.
		{ scenename = "scenes/Gambler/HeardWitch02.vcd" }  //Sounds like a witch.
		{ scenename = "scenes/Gambler/HeardWitch03.vcd" }  //I think I hear my ex-wife...
		{ scenename = "scenes/Gambler/HeardWitch04.vcd" }  //Everybody hear that witch?
		{ scenename = "scenes/Gambler/HeardWitch05.vcd" }  //I hear a witch.
	],
	group_params = none
}

{
	name = "iMT_PlayerHeardWitchC1Gambler",
	criteria =
	[
		[ "concept", "PlayerHeardWitch" ], [ "who", "Gambler" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkGambler ], [ IsWorldTalkGambler ], [ C1M1orC1M2 ], [ IsNotSurvival ], [ NoKnowWitch ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/HeardWitchC101.vcd" }  //Oh there's a sound that's familiar.
		{ scenename = "scenes/Gambler/HeardWitchC102.vcd" }  //That sound is familiar.
		{ scenename = "scenes/Gambler/HeardWitchC103.vcd" }  //I don't like the sound of this crying.
		{ scenename = "scenes/Gambler/HeardWitchC104.vcd" }  //I don't like the sound of this crying.
	],
	group_params = none
}

{
	name = "iMT_PlayerLaughGambler",
	criteria =
	[
		[ "concept", "PlayerLaugh" ], [ "who", "Gambler" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkGambler ], [ IsWorldTalkGambler ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/Laughter01.vcd" }  //<Hearty Laugh>
		{ scenename = "scenes/Gambler/Laughter02.vcd" }  //[Laughter]
		{ scenename = "scenes/Gambler/Laughter03.vcd" }  //<Hearty Laugh>
		{ scenename = "scenes/Gambler/Laughter11.vcd" }  //[Laughter]
		{ scenename = "scenes/Gambler/Laughter12.vcd" }  //[Laughter]
		{ scenename = "scenes/Gambler/Laughter15.vcd" }  //<Short laugh>
		{ scenename = "scenes/Gambler/Laughter16.vcd" }  //<Short laugh>
		{ scenename = "scenes/Gambler/Laughter17.vcd" }  //<Short laugh>
	],
	group_params = none
}

{
	name = "iMT_PlayerLaughAloneGambler",
	criteria =
	[
		[ "concept", "PlayerLaugh" ], [ "who", "Gambler" ], [ "coughing", 0 ], [ "numberofteamalive", 1 ], [ "onthirdstrike", 1 ], [ IsTalk ], [ IsTalkGambler ], [ IsWorldTalkGambler ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/Laughter04.vcd" }  //[Laughter]
		{ scenename = "scenes/Gambler/Laughter07.vcd" }  //[Laughter]
		{ scenename = "scenes/Gambler/Laughter13.vcd" }  //[Laughter]
		{ scenename = "scenes/Gambler/Laughter14.vcd" }  //[Laughter]
	],
	group_params = none
}

{
	name = "iMT_PlayerLaughMechanicGambler",
	criteria =
	[
		[ "concept", "PlayerLaugh" ], [ "who", "Gambler" ], [ "coughing", 0 ], [ "subject", "Mechanic" ], [ "dist_from_subject", 0, 99 ], [ "randomnum", 0, 30 ], [ IsTalk ], [ IsTalkGambler ], [ IsWorldTalkGambler ], [ IsNotC1M1 ], [ IsNotC1M2 ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/NameEllis01.vcd" }  //Are you kidding me, Ellis? Come on.
	],
	group_params = none
}

{
	name = "iMT_PlayerRelaxedSighGambler",
	criteria =
	[
		[ "concept", "RelaxedSigh" ], [ "who", "Gambler" ], [ "speaking", 1 ]
	],
	responses =
	[
		{ scenename = "" }
	],
	group_params = none
}

{
	name = "iMT_PlayerThanksCoachGambler",
	criteria =
	[
		[ "concept", "PlayerThanks" ], [ "who", "Gambler" ], [ "coughing", 0 ], [ "subject", "Coach" ], [ "dist_from_subject", 0, 99 ], [ "randomnum", 0, 30 ], [ IsTalk ], [ IsTalkGambler ], [ IsWorldTalkGambler ], [ IsNotC1M1 ], [ IsNotC1M2 ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/Thanks04.vcd" }  //Thanks, man, I owe you.
		{ scenename = "scenes/Gambler/ThanksCoach01.vcd" }  //Thanks bro.
	],
	group_params = none
}

{
	name = "iMT_PlayerThanksMechanicGambler",
	criteria =
	[
		[ "concept", "PlayerThanks" ], [ "who", "Gambler" ], [ "coughing", 0 ], [ "subject", "Mechanic" ], [ "dist_from_subject", 0, 99 ], [ "randomnum", 0, 30 ], [ IsTalk ], [ IsTalkGambler ], [ IsWorldTalkGambler ], [ IsNotC1M1 ], [ IsNotC1M2 ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/Thanks04.vcd" }  //Thanks, man, I owe you.
		{ scenename = "scenes/Gambler/ThanksEllis01.vcd" }  //Thanks killer.
	],
	group_params = none
}

{
	name = "iMT_PlayerThanksProducerGambler",
	criteria =
	[
		[ "concept", "PlayerThanks" ], [ "who", "Gambler" ], [ "coughing", 0 ], [ "subject", "Producer" ], [ "dist_from_subject", 0, 99 ], [ "randomnum", 0, 30 ], [ IsTalk ], [ IsTalkGambler ], [ IsWorldTalkGambler ], [ IsNotC1M1 ], [ IsNotC1M2 ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/ThanksRochelle01.vcd" }  //Thanks Ro.
	],
	group_params = none
}

{
	name = "iMT_PlayerThanksBikerGambler",
	criteria =
	[
		[ "concept", "PlayerThanks" ], [ "who", "Gambler" ], [ "coughing", 0 ], [ "subject", "Biker" ], [ "dist_from_subject", 0, 599 ], [ "randomnum", 0, 30 ], [ IsTalk ], [ IsTalkGambler ], [ IsWorldTalkGambler ], [ IsNotC1M1 ], [ IsNotC1M2 ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/DLC1_C6M3_FinaleL4D1Items05.vcd" }  //Thanks, greaseball!
		{ scenename = "scenes/Gambler/DLC1_C6M3_FinaleL4D1Items07.vcd" }  //Thanks, pal!
		{ scenename = "scenes/Gambler/DLC1_C6M3_FinaleL4D1Killing01.vcd" }  //I owe you one, Francis!
	],
	group_params = none
}

{
	name = "iMT_PlayerThanksManagerGambler",
	criteria =
	[
		[ "concept", "PlayerThanks" ], [ "who", "Gambler" ], [ "coughing", 0 ], [ "subject", "Manager" ], [ "dist_from_subject", 0, 599 ], [ "randomnum", 0, 30 ], [ IsTalk ], [ IsTalkGambler ], [ IsWorldTalkGambler ], [ IsNotC1M1 ], [ IsNotC1M2 ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/DLC1_C6M3_FinaleL4D1Killing02.vcd" }  //Thanks, Louis!
	],
	group_params = none
}

{
	name = "iMT_PlayerThanksTeenGirlGambler",
	criteria =
	[
		[ "concept", "PlayerThanks" ], [ "who", "Gambler" ], [ "coughing", 0 ], [ "subject", "TeenGirl" ], [ "dist_from_subject", 0, 599 ], [ "randomnum", 0, 30 ], [ IsTalk ], [ IsTalkGambler ], [ IsWorldTalkGambler ], [ IsNotC1M1 ], [ IsNotC1M2 ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/DLC1_C6M3_FinaleL4D1Items06.vcd" }  //Hey thanks, babe!
		{ scenename = "scenes/Gambler/DLC1_C6M3_FinaleL4D1Killing03.vcd" }  //Thanks, Zoey!
	],
	group_params = none
}

{
	name = "iMT_PlayerToTheRescueHurtGambler",
	criteria =
	[
		[ "concept", "PlayerToTheRescue" ], [ "who", "Gambler" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkGambler ], [ IsWorldTalkGambler ], [ IsNotHealthy ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/GoingToDie20.vcd" }  //Can you see I'm limping here?
		{ scenename = "scenes/Gambler/GoingToDie21.vcd" }  //I'm trying to hurry!
		{ scenename = "scenes/Gambler/GoingToDie22.vcd" }  //I'm going as fast as I can.
	],
	group_params = none
}

{
	name = "iMT_PlayerYouAreWelcomeCoachGambler",
	criteria =
	[
		[ "concept", "PlayerYouAreWelcome" ], [ "who", "Gambler" ], [ "coughing", 0 ], [ "subject", "Coach" ], [ "dist_from_subject", 0, 99 ], [ "randomnum", 0, 30 ], [ IsTalk ], [ IsTalkGambler ], [ IsWorldTalkGambler ], [ IsNotC1M1 ], [ IsNotC1M2 ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/YouAreWelcomeCoach01.vcd" }  //No problem, Coach.
		{ scenename = "scenes/Gambler/YouAreWelcomeCoach02.vcd" }  //No problem, Coach.
	],
	group_params = none
}

{
	name = "iMT_PlayerYouAreWelcomeMechanicGambler",
	criteria =
	[
		[ "concept", "PlayerYouAreWelcome" ], [ "who", "Gambler" ], [ "coughing", 0 ], [ "subject", "Mechanic" ], [ "dist_from_subject", 0, 99 ], [ "randomnum", 0, 30 ], [ IsTalk ], [ IsTalkGambler ], [ IsWorldTalkGambler ], [ IsNotC1M1 ], [ IsNotC1M2 ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/YouAreWelcomeMechanic01.vcd" }  //You owe me, Ellis.
		{ scenename = "scenes/Gambler/YouAreWelcomeMechanic02.vcd" }  //You owe me, Ellis.
	],
	group_params = none
}

{
	name = "iMT_PlayerYouAreWelcomeProducerGambler",
	criteria =
	[
		[ "concept", "PlayerYouAreWelcome" ], [ "who", "Gambler" ], [ "coughing", 0 ], [ "subject", "Producer" ], [ "dist_from_subject", 0, 99 ], [ "randomnum", 0, 30 ], [ IsTalk ], [ IsTalkGambler ], [ IsWorldTalkGambler ], [ IsNotC1M1 ], [ IsNotC1M2 ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/YouAreWelcomeProducer01.vcd" }  //Sure thing, Ro.
		{ scenename = "scenes/Gambler/YouAreWelcomeProducer02.vcd" }  //Sure thing, Ro.
	],
	group_params = none
}

{
	name = "iMT_ResponseSoftDispleasureSwearGambler",
	criteria =
	[
		[ "concept", "ResponseSoftDispleasureSwear" ], [ "who", "Gambler" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkGambler ], [ IsWorldTalkGambler ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/DoubleDeathResponse03.vcd" }  //Ahhh SHIT!
		{ scenename = "scenes/Gambler/World219.vcd" }  //WHAT THE F...!
		{ scenename = "scenes/Gambler/WorldC5M4B06.vcd" }  //SHIT!
		{ scenename = "scenes/Gambler/WorldC5M4B07.vcd" }  //SHIT!
	],
	group_params = none
}

{
	name = "iMT_SurvivorCoughingDeathGambler",
	criteria =
	[
		[ "concept", "PlayerDeath" ], [ "who", "Gambler" ], [ "coughing", 1 ], [ IsTalk ], [ IsTalkGambler ], [ IsWorldTalkGambler ]
	],
	responses = SurvivorCoughingGambler,
	group_params = none
}

{
	name = "iMT_SurvivorDeathGambler",
	criteria =
	[
		[ "concept", "PlayerDeath" ], [ "who", "Gambler" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkGambler ], [ IsWorldTalkGambler ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/DeathScream01.vcd" }  //[Loud painful death scream]
		{ scenename = "scenes/Gambler/DeathScream02.vcd" }  //[Loud painful death scream]
		{ scenename = "scenes/Gambler/DeathScream03.vcd" }  //[Short quick death scream]
		{ scenename = "scenes/Gambler/DeathScream04.vcd" }  //[Short quick death scream]
		{ scenename = "scenes/Gambler/DeathScream05.vcd" }  //[Short quick death scream]
		{ scenename = "scenes/Gambler/DeathScream06.vcd" }  //[Short quick death scream]
		{ scenename = "scenes/Gambler/DeathScream07.vcd" }  //[Short quick death scream]
	],
	group_params = none
}

{
	name = "iMT_SurvivorSpottedAmmoGambler",
	criteria =
	[
		[ "concept", "PlayerSpotAmmo" ], [ "who", "Gambler" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkGambler ], [ IsWorldTalkGambler ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/SpotAmmo01.vcd" }  //Ammo here!
		{ scenename = "scenes/Gambler/SpotAmmo02.vcd" }  //Ammo here!
		{ scenename = "scenes/Gambler/SpotAmmo03.vcd" }  //Ammo!
		{ scenename = "scenes/Gambler/SpotAmmo04.vcd" }  //Ammo here!
		{ scenename = "scenes/Gambler/SpotAmmo05.vcd" }  //Ammo!
	],
	group_params = none
}

{
	name = "iMT_SurvivorSpottedBoomerGambler",
	criteria =
	[
		[ "concept", "PlayerWarnBoomer" ], [ "who", "Gambler" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkGambler ], [ IsWorldTalkGambler ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/WarnBoomer01.vcd" }  //BOOMER!
		{ scenename = "scenes/Gambler/WarnBoomer02.vcd" }  //WE GOT A BOOMER!
		{ scenename = "scenes/Gambler/WarnBoomer03.vcd" }  //BOOMER!
		{ scenename = "scenes/Gambler/WarnBoomer04.vcd" }  //BOOMER!
		{ scenename = "scenes/Gambler/WarnBoomer05.vcd" }  //BOOMER!
		{ scenename = "scenes/Gambler/WarnBoomer06.vcd" }  //WE GOT A BOOMER!
	],
	group_params = none
}

{
	name = "iMT_SurvivorSpottedBoomer%Gambler",
	criteria =
	[
		[ "concept", "PlayerWarnBoomer" ], [ "who", "Gambler" ], [ "coughing", 0 ], [ "randomnum", 0, 20 ], [ IsTalk ], [ IsTalkGambler ], [ IsWorldTalkGambler ]
	],
	responses = SurvivorSpottedBoomerC1Gambler,
	group_params = none
}

{
	name = "iMT_SurvivorSpottedBoomerC1Gambler",
	criteria =
	[
		[ "concept", "PlayerWarnBoomer" ], [ "who", "Gambler" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkGambler ], [ IsWorldTalkGambler ], [ C1M1orC1M2 ], [ IsNotSurvival ], [ NoKnowBoomer ]
	],
	responses = SurvivorSpottedBoomerC1Gambler,
	group_params = none
}

{
	name = "iMT_SurvivorSpottedChargerGambler",
	criteria =
	[
		[ "concept", "PlayerWarnCharger" ], [ "who", "Gambler" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkGambler ], [ IsWorldTalkGambler ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/WarnCharger01.vcd" }  //CHARGER!
		{ scenename = "scenes/Gambler/WarnCharger02.vcd" }  //WE GOT A CHARGER!
		{ scenename = "scenes/Gambler/WarnCharger03.vcd" }  //CHARGER!
		{ scenename = "scenes/Gambler/WarnCharger04.vcd" }  //CHARGER!
	],
	group_params = none
}

{
	name = "iMT_SurvivorSpottedCharger%Gambler",
	criteria =
	[
		[ "concept", "PlayerWarnCharger" ], [ "who", "Gambler" ], [ "coughing", 0 ], [ "randomnum", 0, 20 ], [ IsTalk ], [ IsTalkGambler ], [ IsWorldTalkGambler ]
	],
	responses = SurvivorSpottedChargerC1Gambler,
	group_params = none
}

{
	name = "iMT_SurvivorSpottedChargerC1Gambler",
	criteria =
	[
		[ "concept", "PlayerWarnCharger" ], [ "who", "Gambler" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkGambler ], [ IsWorldTalkGambler ], [ C1M1orC1M2 ], [ IsNotSurvival ], [ NoKnowCharger ]
	],
	responses = SurvivorSpottedChargerC1Gambler,
	group_params = none
}

{
	name = "iMT_SurvivorSpottedHunterGambler",
	criteria =
	[
		[ "concept", "PlayerWarnHunter" ], [ "who", "Gambler" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkGambler ], [ IsWorldTalkGambler ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/WarnHunter01.vcd" }  //WE GOT A HUNTER!
		{ scenename = "scenes/Gambler/WarnHunter02.vcd" }  //HUNTER!
		{ scenename = "scenes/Gambler/WarnHunter03.vcd" }  //HUNTER!
		{ scenename = "scenes/Gambler/WarnHunter04.vcd" }  //HUNTER!
		{ scenename = "scenes/Gambler/WarnHunter05.vcd" }  //WE GOT A HUNTER!
	],
	group_params = none
}

{
	name = "iMT_SurvivorSpottedHunter%Gambler",
	criteria =
	[
		[ "concept", "PlayerWarnHunter" ], [ "who", "Gambler" ], [ "coughing", 0 ], [ "randomnum", 0, 20 ], [ IsTalk ], [ IsTalkGambler ], [ IsWorldTalkGambler ]
	],
	responses = SurvivorSpottedHunterC1Gambler,
	group_params = none
}

{
	name = "iMT_SurvivorSpottedHunterC1Gambler",
	criteria =
	[
		[ "concept", "PlayerWarnHunter" ], [ "who", "Gambler" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkGambler ], [ IsWorldTalkGambler ], [ C1M1orC1M2 ], [ IsNotSurvival ], [ NoKnowHunter ]
	],
	responses = SurvivorSpottedHunterC1Gambler,
	group_params = none
}

{
	name = "iMT_SurvivorSpottedInfectedGambler",
	criteria =
	[
		[ "concept", "PlayerIncoming" ], [ "who", "Gambler" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkGambler ], [ IsWorldTalkGambler ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/Incoming01.vcd" }  //This is why we've got guns!
		{ scenename = "scenes/Gambler/Incoming02.vcd" }  //It's about to get serious!
		{ scenename = "scenes/Gambler/Incoming03.vcd" }  //We got inbound!
		{ scenename = "scenes/Gambler/Incoming04.vcd" }  //They're coming!
		{ scenename = "scenes/Gambler/Incoming05.vcd" }  //Here they come!
		{ scenename = "scenes/Gambler/Incoming06.vcd" }  //God damn, it's gettin' good.
		{ scenename = "scenes/Gambler/Incoming07.vcd" }  //They're coming!
		{ scenename = "scenes/Gambler/Incoming08.vcd" }  //Get ready!
	],
	group_params = none
}

{
	name = "iMT_SurvivorSpottedJockeyGambler",
	criteria =
	[
		[ "concept", "PlayerWarnJockey" ], [ "who", "Gambler" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkGambler ], [ IsWorldTalkGambler ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/WarnJockey01.vcd" }  //Jockey!
		{ scenename = "scenes/Gambler/WarnJockey02.vcd" }  //Jockey!
		{ scenename = "scenes/Gambler/WarnJockey03.vcd" }  //Jockey!
	],
	group_params = none
}

{
	name = "iMT_SurvivorSpottedJockey%Gambler",
	criteria =
	[
		[ "concept", "PlayerWarnJockey" ], [ "who", "Gambler" ], [ "coughing", 0 ], [ "randomnum", 0, 20 ], [ IsTalk ], [ IsTalkGambler ], [ IsWorldTalkGambler ]
	],
	responses = SurvivorSpottedJockeyC1Gambler,
	group_params = none
}

{
	name = "iMT_SurvivorSpottedJockeyC1Gambler",
	criteria =
	[
		[ "concept", "PlayerWarnJockey" ], [ "who", "Gambler" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkGambler ], [ IsWorldTalkGambler ], [ C1M1orC1M2 ], [ IsNotSurvival ], [ NoKnowJockey ]
	],
	responses = SurvivorSpottedJockeyC1Gambler,
	group_params = none
}

{
	name = "iMT_SurvivorSpottedSmokerGambler",
	criteria =
	[
		[ "concept", "PlayerWarnSmoker" ], [ "who", "Gambler" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkGambler ], [ IsWorldTalkGambler ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/WarnSmoker01.vcd" }  //WE GOT A SMOKER!
		{ scenename = "scenes/Gambler/WarnSmoker02.vcd" }  //SMOKER!
		{ scenename = "scenes/Gambler/WarnSmoker03.vcd" }  //SMOKER!
		{ scenename = "scenes/Gambler/WarnSmoker04.vcd" }  //SMOKER!
	],
	group_params = none
}

{
	name = "iMT_SurvivorSpottedSmoker%Gambler",
	criteria =
	[
		[ "concept", "PlayerWarnSmoker" ], [ "who", "Gambler" ], [ "coughing", 0 ], [ "randomnum", 0, 20 ], [ IsTalk ], [ IsTalkGambler ], [ IsWorldTalkGambler ]
	],
	responses = SurvivorSpottedSmokerC1Gambler,
	group_params = none
}

{
	name = "iMT_SurvivorSpottedSmokerC1Gambler",
	criteria =
	[
		[ "concept", "PlayerWarnSmoker" ], [ "who", "Gambler" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkGambler ], [ IsWorldTalkGambler ], [ C1M1orC1M2 ], [ IsNotSurvival ], [ NoKnowSmoker ]
	],
	responses = SurvivorSpottedSmokerC1Gambler,
	group_params = none
}

{
	name = "iMT_SurvivorSpottedSpitterGambler",
	criteria =
	[
		[ "concept", "PlayerWarnSpitter" ], [ "who", "Gambler" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkGambler ], [ IsWorldTalkGambler ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/WarnSpitter01.vcd" }  //Spitter
		{ scenename = "scenes/Gambler/WarnSpitter02.vcd" }  //Spitter
		{ scenename = "scenes/Gambler/WarnSpitter03.vcd" }  //We got a spitter
	],
	group_params = none
}

{
	name = "iMT_SurvivorSpottedSpitter%Gambler",
	criteria =
	[
		[ "concept", "PlayerWarnSpitter" ], [ "who", "Gambler" ], [ "coughing", 0 ], [ "randomnum", 0, 20 ], [ IsTalk ], [ IsTalkGambler ], [ IsWorldTalkGambler ]
	],
	responses = SurvivorSpottedSpitterC1Gambler,
	group_params = none
}

{
	name = "iMT_SurvivorSpottedSpitterC1Gambler",
	criteria =
	[
		[ "concept", "PlayerWarnSpitter" ], [ "who", "Gambler" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkGambler ], [ IsWorldTalkGambler ], [ C1M1orC1M2 ], [ IsNotSurvival ], [ NoKnowSpitter ]
	],
	responses = SurvivorSpottedSpitterC1Gambler,
	group_params = none
}

{
	name = "iMT_SurvivorSpottedTankGambler",
	criteria =
	[
		[ "concept", "PlayerWarnTank" ], [ "who", "Gambler" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkGambler ], [ IsWorldTalkGambler ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/HeardHulk01.vcd" }  //Tank! Tank!
		{ scenename = "scenes/Gambler/HeardHulk02.vcd" }  //Tank inbound!
		{ scenename = "scenes/Gambler/HeardHulk03.vcd" }  //Man up! We got a Tank!
		{ scenename = "scenes/Gambler/HeardHulk04.vcd" }  //Get ready, we got a TANK!
		{ scenename = "scenes/Gambler/HeardHulk05.vcd" }  //Hold steady, TANK!
		{ scenename = "scenes/Gambler/HeardHulk06.vcd" }  //Get ready, TANK!
		{ scenename = "scenes/Gambler/WarnTank01.vcd" }  //WE GOT A TANK!
		{ scenename = "scenes/Gambler/WarnTank02.vcd" }  //TANK!
		{ scenename = "scenes/Gambler/WarnTank03.vcd" }  //TANK!
		{ scenename = "scenes/Gambler/WarnTank04.vcd" }  //TANK!
	],
	group_params = none
}

{
	name = "iMT_SurvivorSpottedTank%Gambler",
	criteria =
	[
		[ "concept", "PlayerWarnTank" ], [ "who", "Gambler" ], [ "coughing", 0 ], [ "randomnum", 0, 10 ], [ IsTalk ], [ IsTalkGambler ], [ IsWorldTalkGambler ]
	],
	responses = SurvivorSpottedTankC1Gambler,
	group_params = none
}

{
	name = "iMT_SurvivorSpottedTankC1Gambler",
	criteria =
	[
		[ "concept", "PlayerWarnTank" ], [ "who", "Gambler" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkGambler ], [ IsWorldTalkGambler ], [ C1M1orC1M2 ], [ IsNotSurvival ], [ NoKnowTank ]
	],
	responses = SurvivorSpottedTankC1Gambler,
	group_params = none
}

{
	name = "iMT_SurvivorSpottedTanksGambler",
	criteria =
	[
		[ "concept", "PlayerWarnTank" ], [ "who", "Gambler" ], [ "coughing", 0 ], [ "tankactive", 1 ], [ IsTalk ], [ IsTalkGambler ], [ IsWorldTalkGambler ], [ IsZombiePresentTanks ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/HeardTanklC110.vcd" }  //We are screwed.
		{ scenename = "scenes/Gambler/WarnTankC101.vcd" }  //We have a problem!
		{ scenename = "scenes/Gambler/WarnTankC103.vcd" }  //We have a problem!
	],
	group_params = none
}

{
	name = "iMT_SurvivorSpottedWeaponGambler",
	criteria =
	[
		[ "concept", "PlayerSpotOtherWeapon" ], [ "who", "Gambler" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkGambler ], [ IsWorldTalkGambler ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/SpotWeapons01.vcd" }  //Weapons over here!
		{ scenename = "scenes/Gambler/SpotWeapons02.vcd" }  //Everyone grab a weapon!
		{ scenename = "scenes/Gambler/SpotWeapons03.vcd" }  //Guns here!
	],
	group_params = none
}

{
	name = "iMT_SurvivorSpottedWitchGambler",
	criteria =
	[
		[ "concept", "PlayerWarnWitch" ], [ "who", "Gambler" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkGambler ], [ IsWorldTalkGambler ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/WarnWitch01.vcd" }  //We got a witch.
		{ scenename = "scenes/Gambler/WarnWitch02.vcd" }  //Witch.
		{ scenename = "scenes/Gambler/WarnWitch03.vcd" }  //Witch.
		{ scenename = "scenes/Gambler/WarnWitch04.vcd" }  //Witch.
	],
	group_params = none
}

{
	name = "iMT_SurvivorSpottedWitchC1Gambler",
	criteria =
	[
		[ "concept", "PlayerWarnWitch" ], [ "who", "Gambler" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkGambler ], [ IsWorldTalkGambler ], [ C1M1orC1M2 ], [ IsNotSurvival ], [ NoKnowWitch ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/HeardWitchC105.vcd" }  //A crying woman, what do you think she's sad the mall's closed?
		{ scenename = "scenes/Gambler/HeardWitchC106.vcd" }  //A crying woman, you think she's sad the mall's closed?
	],
	group_params = none
}

{
	name = "iMT_SurvivorTauntResponseGambler",
	criteria =
	[
		[ "concept", "PlayerTaunt" ], [ "who", "Gambler" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkGambler ], [ IsWorldTalkGambler ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/Taunt01.vcd" }  //Suck on that!
		{ scenename = "scenes/Gambler/Taunt02.vcd" }  //Stick that where the sun don't shine!
		{ scenename = "scenes/Gambler/Taunt03.vcd" }  //Take that you mealy-mouthed bastards.
		{ scenename = "scenes/Gambler/Taunt04.vcd" }  //Stick it up your ass!
		{ scenename = "scenes/Gambler/Taunt05.vcd" }  //Stick that up your ass!
		{ scenename = "scenes/Gambler/Taunt06.vcd" }  //We are wiping the floor with you.
		{ scenename = "scenes/Gambler/Taunt07.vcd" }  //You don't stand a chance.
		{ scenename = "scenes/Gambler/Taunt08.vcd" }  //Give up now!
		{ scenename = "scenes/Gambler/Taunt09.vcd" }  //Candyasses!
	],
	group_params = none
}

{
	name = "iMT_SurvivorVocalizeBackUpGambler",
	criteria =
	[
		[ "concept", "PlayerBackUp" ], [ "who", "Gambler" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkGambler ], [ IsWorldTalkGambler ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/BackUp01.vcd" }  //Back it up!
		{ scenename = "scenes/Gambler/BackUp02.vcd" }  //Back, back, back!
		{ scenename = "scenes/Gambler/BackUp03.vcd" }  //Come on back.
		{ scenename = "scenes/Gambler/BackUp04.vcd" }  //Back it up!
	],
	group_params = none
}

{
	name = "iMT_SurvivorVocalizeBackUpC4M2Gambler",
	criteria =
	[
		[ "concept", "PlayerBackUp" ], [ "who", "Gambler" ], [ "coughing", 0 ], [ "tankactive", 0 ], [ "map", "c4m2_sugarmill_a" ], [ "world_auto_gamblerinwitchville", 1 ], [ IsTalk ], [ IsTalkGambler ], [ IsWorldTalkGambler ], [ IsNotSaidSafeSpotAhead ]
	],
	responses = SurvivorVocalizeBackUpQuietGambler,
	group_params = none
}

{
	name = "iMT_SurvivorVocalizeBackUpQuietGambler",
	criteria =
	[
		[ "concept", "PlayerBackUp" ], [ "who", "Gambler" ], [ "coughing", 0 ], [ "tankactive", 0 ], [ "incombatmusic", 0 ], [ IsTalk ], [ IsTalkGambler ], [ IsWorldTalkGambler ], [ IsWitchNear ], [ IsNotWitchAggro ]
	],
	responses = SurvivorVocalizeBackUpQuietGambler,
	group_params = none
}

{
	name = "iMT_SurvivorVocalizeEmphaticGoGambler",
	criteria =
	[
		[ "concept", "PlayerEmphaticGo" ], [ "who", "Gambler" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkGambler ], [ IsWorldTalkGambler ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/EmphaticGo01.vcd" }  //Go!
		{ scenename = "scenes/Gambler/EmphaticGo02.vcd" }  //GO!
		{ scenename = "scenes/Gambler/EmphaticGo03.vcd" }  //GOOO!
		{ scenename = "scenes/Gambler/EmphaticGo04.vcd" }  //Go go go!
		{ scenename = "scenes/Gambler/EmphaticGo05.vcd" }  //Let's go. Let's go.
		{ scenename = "scenes/Gambler/EmphaticGo06.vcd" }  //GO!
		{ scenename = "scenes/Gambler/EmphaticGo07.vcd" }  //Let's go.
	],
	group_params = none
}

{
	name = "iMT_SurvivorVocalizeEmphaticGoC4M2Gambler",
	criteria =
	[
		[ "concept", "PlayerEmphaticGo" ], [ "who", "Gambler" ], [ "coughing", 0 ], [ "tankactive", 0 ], [ "map", "c4m2_sugarmill_a" ], [ "world_auto_gamblerinwitchville", 1 ], [ IsTalk ], [ IsTalkGambler ], [ IsWorldTalkGambler ], [ IsNotSaidSafeSpotAhead ]
	],
	responses = SurvivorVocalizeEmphaticGoQuietGambler,
	group_params = none
}

{
	name = "iMT_SurvivorVocalizeEmphaticGoQuietGambler",
	criteria =
	[
		[ "concept", "PlayerEmphaticGo" ], [ "who", "Gambler" ], [ "coughing", 0 ], [ "tankactive", 0 ], [ "incombatmusic", 0 ], [ IsTalk ], [ IsTalkGambler ], [ IsWorldTalkGambler ], [ IsWitchNear ], [ IsNotWitchAggro ]
	],
	responses = SurvivorVocalizeEmphaticGoQuietGambler,
	group_params = none
}

{
	name = "iMT_SurvivorVocalizeLookOutGambler",
	criteria =
	[
		[ "concept", "PlayerLookOut" ], [ "who", "Gambler" ], [ "coughing", 0 ], [ "world_auto_finale", 2 ], [ IsTalk ], [ IsTalkGambler ], [ IsWorldTalkGambler ]
	],
	responses =
	[
		{ scenename = "scenes/Gambler/LookOut01.vcd" }  //Look out!
		{ scenename = "scenes/Gambler/LookOut02.vcd" }  //Watch out!
		{ scenename = "scenes/Gambler/LookOut03.vcd" }  //Heads up!
	],
	group_params = none
}

//--------------------------------------------------------------------------------------------------
// Start Area
//--------------------------------------------------------------------------------------------------

{
	name = "iMT_SafeRoomStartGambler",
	criteria =
	[
		[ "concept", "TLK_IDLE" ], [ "who", "Gambler" ], [ "instartarea", 1 ], [ IsNotScavenge ], [ IsNotSurvival ], [ _auto_NotSafeRoomStart ]
	],
	responses =
	[
		{
			scenename = "scenes/Gambler/Blank.vcd",
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

rr_ProcessRules( Gambler )