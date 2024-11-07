//--------------------------------------------------------------------------------------------------
// ion's Vocalizer: Biker Response Rules
//--------------------------------------------------------------------------------------------------

// Shared responses

local HateBiker =
[
	{ scenename = "scenes/Biker/C6DLC3JumpingOffBridge03.vcd" }  //I hate suicide missions.
	{ scenename = "scenes/Biker/C6DLC3PreStartLastGen01.vcd" }  //I hate these stupid generators.
	{ scenename = "scenes/Biker/C6DLC3SecondSafeRoom02.vcd" }  //I hate your good feelings.
	{ scenename = "scenes/Biker/C6DLC3SecondSafeRoom20.vcd" }  //I hate fish.
	{ scenename = "scenes/Biker/CommunityGeneric01.vcd" }  //I hate malls.
	{ scenename = "scenes/Biker/CommunityGeneric04.vcd" }  //I hate prisons.
	{ scenename = "scenes/Biker/CommunityGeneric06.vcd" }  //I hate jungles.
	{ scenename = "scenes/Biker/DLC1_C6M3_L4D1FinaleCinematic13.vcd" }  //I hate goodbyes.
	{ scenename = "scenes/Biker/DLC1_CommunityL4D103.vcd" }  //I hate the snow.
	{ scenename = "scenes/Biker/DLC1_CommunityL4D104.vcd" }  //I hate the cold.
	{ scenename = "scenes/Biker/DLC1_CommunityL4D105.vcd" }  //I hate car alarms.
	{ scenename = "scenes/Biker/DLC1_CommunityL4D107.vcd" }  //I hate mountains.
	{ scenename = "scenes/Biker/DLC1_KillFinalTank01.vcd" }  //I hate tanks.
	{ scenename = "scenes/Biker/DLC2BirdHate01.vcd" }  //I hate birds.
	{ scenename = "scenes/Biker/DLC2CanadaHate01.vcd" }  //Oh my god, I hate Canada so much.
	{ scenename = "scenes/Biker/DLC2Intro22.vcd" }  //I hate walking.
	{ scenename = "scenes/Biker/DLC2Intro29.vcd" }  //I hate parades.
	{ scenename = "scenes/Biker/DLC2MagazineRack01.vcd" }  //I hate latest issues.
	{ scenename = "scenes/Biker/DLC2Riverside02.vcd" }  //I hate Riverside.
	{ scenename = "scenes/Biker/DLC2Steam01.vcd" }  //I hate steam. [beat] Pipes.
	{ scenename = "scenes/Biker/WorldAirport0416.vcd" }  //I hate Ayn Rand.
	{ scenename = "scenes/Biker/WorldAirport0425.vcd" }  //I hate vans.
	{ scenename = "scenes/Biker/WorldAirport0513.vcd" }  //I hate planes.
	{ scenename = "scenes/Biker/WorldHospital0201.vcd" }  //I hate subways.
	{ scenename = "scenes/Biker/WorldHospital0308.vcd" }  //I hate sewers.
	{ scenename = "scenes/Biker/WorldHospital0408.vcd" }  //I hate hospitals.
	{ scenename = "scenes/Biker/WorldHospital0409.vcd" }  //I hate elevators.
	{ scenename = "scenes/Biker/WorldHospital0410.vcd" }  //I hate stairs.
	{ scenename = "scenes/Biker/WorldHospital0501.vcd" }  //I hate helicopters.
	{ scenename = "scenes/Biker/WorldFarmHouse0112.vcd" }  //I hate the woods.
	{ scenename = "scenes/Biker/WorldFarmHouse0212.vcd" }  //I hate tunnels.
	{ scenename = "scenes/Biker/WorldSmallTown0204.vcd" }  //I hate trainyards.
	{ scenename = "scenes/Biker/WorldSmallTown0311.vcd" }  //I hate small towns.
	{ scenename = "scenes/Biker/WorldSmallTown0509.vcd" }  //I hate the water.
	{ scenename = "scenes/Biker/WorldSmallTown0511.vcd" }  //I hate lawyers.
]

local SurvivorCoughingBiker =
[
	{ scenename = "scenes/Biker/Cough01.vcd" }  //[Coughing from smoke]
	{ scenename = "scenes/Biker/Cough02.vcd" }  //[Coughing from smoke]
	{ scenename = "scenes/Biker/Cough03.vcd" }  //[Coughing from smoke]
	{ scenename = "scenes/Biker/Cough04.vcd" }  //[Coughing from smoke]
	{ scenename = "scenes/Biker/Cough05.vcd" }  //[Coughing from smoke]
	{ scenename = "scenes/Biker/Cough06.vcd" }  //[Coughing from smoke]
	{ scenename = "scenes/Biker/Cough07.vcd" }  //[Coughing from smoke]
]

local SurvivorMournManagerBiker =
[
	{ scenename = "scenes/Biker/GriefManager01.vcd" }  //Ahhh, the manager's down for the count.
	{ scenename = "scenes/Biker/GriefManager02.vcd" }  //Ah shit, I was just starting to like that guy.
	{ scenename = "scenes/Biker/GriefManager03.vcd" }  //Damn it, he didn't deserve this.
	{ scenename = "scenes/Biker/GriefManager04.vcd" }  //The manager's down for the count.
	{ scenename = "scenes/Biker/GriefManager05.vcd" }  //Shit, I was just starting to like that guy.
]

local SurvivorMournNamVetBiker =
[
	{ scenename = "scenes/Biker/GriefVet01.vcd" }  //Bill's gone!
	{ scenename = "scenes/Biker/GriefVet02.vcd" }  //Rest in peace, old man.
	{ scenename = "scenes/Biker/GriefVet03.vcd" }  //Shit, I'm gonna miss the old guy.
]

local SurvivorMournTeenGirlBiker =
[
	{ scenename = "scenes/Biker/GriefFemaleGeneric03.vcd" }  //Ah hell, she's dead.
	{ scenename = "scenes/Biker/GriefTeengirl01.vcd" }  //Ahh Zoey. No.
	{ scenename = "scenes/Biker/GriefTeengirl02.vcd" }  //Ahh damnit, not Zoey.
]

//--------------------------------------------------------------------------------------------------
// Ellis Stories
//--------------------------------------------------------------------------------------------------

local Biker =
[

{
	name = "iMT_EllisStoryInterruptBiker",
	criteria =
	[
		[ "concept", "iMT_EllisStoryInterrupt" ], [ "who", "Biker" ], [ "world_auto_tellingstory", 1 ], [ "coughing", 0 ], [ "incapacitated", 0 ], [ "speaking", 0], [ IsTalk ], [ IsTalkBiker ], [ IsWorldTalkBiker ], [ IssuerCloseEnough ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/DLC1_C6M1_InitialMeeting03.vcd", followup = RThen( "Mechanic", "iMT_EllisStoryReac", { from = "Biker" }, 0.3 ) }  //Nope, not a chance.
		{ scenename = "scenes/Biker/GenericResponses11.vcd" }  //Ah shit, here we go again.
	],
	group_params = none
}

{
	name = "iMT_EllisStoryStopBiker",
	criteria =
	[
		[ "concept", "iMT_EllisStories" ], [ "who", "Biker" ], [ "world_auto_tellingstory", 1 ]
	],
	responses =
	[
		{
			scenename = "scenes/Biker/Generic20.vcd", followup = RThen( "all", "iMT_EllisStoryStop", null, 0.3 ),  //Know what? I just realized I don't care. Lead on.
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
	name = "iMT_PlayerAnswerReadyBiker",
	criteria =
	[
		[ "concept", "iMT_PlayerAnswerReady" ], [ "who", "Biker" ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/AnswerReady01.vcd" }  //Ready.
		{ scenename = "scenes/Biker/AnswerReady02.vcd" }  //Yeah, ready.
		{ scenename = "scenes/Biker/AnswerReady03.vcd" }  //Yeah, let's do it.
		{ scenename = "scenes/Biker/AnswerReady04.vcd" }  //Let's go break stuff!
		{ scenename = "scenes/Biker/AnswerReady05.vcd" }  //Let's go kill somethin'!
	],
	group_params = none
}

{
	name = "iMT_PlayerBattleCryBiker",
	criteria =
	[
		[ "concept", "iMT_PlayerBattleCry" ], [ "who", "Biker" ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/Hurrah19.vcd" }  //Goddamn right!
		{ scenename = "scenes/Biker/Hurrah20.vcd" }  //Hell yeah!
		{ scenename = "scenes/Biker/Taunt01.vcd" }  //That's right!
		{ scenename = "scenes/Biker/Taunt02.vcd" }  //HELL YEAH!
		{ scenename = "scenes/Biker/Taunt03.vcd" }  //OH YEAH!
		{ scenename = "scenes/Biker/Taunt04.vcd" }  //Oh yeah!
		{ scenename = "scenes/Biker/Taunt08.vcd" }  //YEAH! YEAH!
		{ scenename = "scenes/Biker/Taunt09.vcd" }  //Damn straight!
		{ scenename = "scenes/Biker/Taunt10.vcd" }  //HELL YEAH!
	],
	group_params = none
}

{
	name = "iMT_PlayerBreathingBiker",
	criteria =
	[
		[ "concept", "iMT_PlayerBreathing" ], [ "who", "Biker" ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/ExertionCritical01.vcd" }  //[frightened freaked out breathing]
		{ scenename = "scenes/Biker/ExertionCritical02.vcd" }  //[frightened freaked out breathing]
		{ scenename = "scenes/Biker/ExertionCritical03.vcd" }  //[frightened freaked out breathing]
		{ scenename = "scenes/Biker/ExertionMajor01.vcd" }  //[heavy breathing - seriously winded]
		{ scenename = "scenes/Biker/ExertionMajor02.vcd" }  //[heavy breathing - seriously winded]
		{ scenename = "scenes/Biker/ExertionMinor01.vcd" }  //[breathing - panting out of breath]
		{ scenename = "scenes/Biker/ExertionMinor02.vcd" }  //[breathing - panting out of breath]
		{ scenename = "scenes/Biker/ExertionMinor03.vcd" }  //[breathing - panting out of breath]
		{ scenename = "scenes/Biker/ExertionMinor04.vcd" }  //[breathing - panting out of breath]
		{ scenename = "scenes/Biker/ExertionMinor05.vcd" }  //[breathing - panting out of breath]
	],
	group_params = none
}

{
	name = "iMT_PlayerCloseTheDoorBiker",
	criteria =
	[
		[ "concept", "iMT_PlayerCloseTheDoor" ], [ "who", "Biker" ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/CloseTheDoor01.vcd" }  //Lock the damn door.
		{ scenename = "scenes/Biker/CloseTheDoor02.vcd" }  //Lock the door.
		{ scenename = "scenes/Biker/CloseTheDoor03.vcd" }  //Lock that door!
		{ scenename = "scenes/Biker/CloseTheDoor04.vcd" }  //You born in a barn? Lock the goddamn door.
		{ scenename = "scenes/Biker/CloseTheDoor05.vcd" }  //Lock the door.
		{ scenename = "scenes/Biker/CloseTheDoor06.vcd" }  //Lock the freakin' door.
		{ scenename = "scenes/Biker/CloseTheDoor08.vcd" }  //Someone gonna lock that door?
		{ scenename = "scenes/Biker/CloseTheDoor09.vcd" }  //Get that lock.
		{ scenename = "scenes/Biker/CloseTheDoor10.vcd" }  //Lock the goddamn door.
		{ scenename = "scenes/Biker/CloseTheDoor11.vcd" }  //Would you lock that sucker?
		{ scenename = "scenes/Biker/CloseTheDoor12.vcd" }  //Keep 'em out! Lock that door!
	],
	group_params = none
}

{
	name = "iMT_PlayerCloseTheDoor%Biker",
	criteria =
	[
		[ "concept", "iMT_PlayerCloseTheDoor" ], [ "who", "Biker" ], [ "randomnum", 1 ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/CloseTheDoor07.vcd" }  //Personally, I'm happy to keep fighting. But YOU ladies might want to lock the door.
	],
	group_params = none
}

{
	name = "iMT_PlayerCoughingBiker",
	criteria =
	[
		[ "concept", "iMT_PlayerCoughing" ], [ "who", "Biker" ]
	],
	responses = SurvivorCoughingBiker,
	group_params = none
}

{
	name = "iMT_PlayerDeathScreamBiker",
	criteria =
	[
		[ "concept", "iMT_PlayerDeathScream" ], [ "who", "Biker" ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/Fall01.vcd" }  //[Death scream as you fall]
		{ scenename = "scenes/Biker/Fall02.vcd" }  //[Death scream as you fall]
		{ scenename = "scenes/Biker/Fall03.vcd" }  //[Death scream as you fall]
	],
	group_params = none
}

{
	name = "iMT_PlayerFriendlyFireBiker",
	criteria =
	[
		[ "concept", "iMT_PlayerFriendlyFire" ], [ "who", "Biker" ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/FriendlyFire01.vcd" }  //That hurt.
		{ scenename = "scenes/Biker/FriendlyFire02.vcd" }  //Dammit! Will you knock it off!
		{ scenename = "scenes/Biker/FriendlyFire03.vcd" }  //Will you knock it off!
		{ scenename = "scenes/Biker/FriendlyFire04.vcd" }  //Do I look like a target?
		{ scenename = "scenes/Biker/FriendlyFire05.vcd" }  //You know I would appreciate it, IF YOU'D STOP SHOOTING ME.
		{ scenename = "scenes/Biker/FriendlyFire06.vcd" }  //Watch where the hell you're shooting.
		{ scenename = "scenes/Biker/FriendlyFire07.vcd" }  //Watch where you're shooting!
		{ scenename = "scenes/Biker/FriendlyFire08.vcd" }  //Stop. Shooting. Me.
		{ scenename = "scenes/Biker/FriendlyFire09.vcd" }  //Hey! Stop. Shooting. Me.
		{ scenename = "scenes/Biker/FriendlyFire10.vcd" }  //Watch where you're shooting!
		{ scenename = "scenes/Biker/FriendlyFire11.vcd" }  //Don't shoot me!
		{ scenename = "scenes/Biker/FriendlyFire12.vcd" }  //Watch where you point that thing.
		{ scenename = "scenes/Biker/FriendlyFire13.vcd" }  //Dammit! Watch where you're shooting!
		{ scenename = "scenes/Biker/FriendlyFire14.vcd" }  //Don't shoot me!
		{ scenename = "scenes/Biker/FriendlyFire15.vcd" }  //Monsters all over the damn place, and you gotta shoot me.
		{ scenename = "scenes/Biker/FriendlyFire16.vcd" }  //Quit freaking shooting me!
		{ scenename = "scenes/Biker/FriendlyFire18.vcd" }  //Shoot me again, I'm gonna kick your ass.
		{ scenename = "scenes/Biker/FriendlyFire19.vcd" }  //Do that again, and you're gonna be firing that thing outta your ass.
	],
	group_params = none
}

{
	name = "iMT_PlayerFriendlyFireFromManagerBiker",
	criteria =
	[
		[ "concept", "iMT_PlayerFriendlyFire" ], [ "who", "Biker" ], [ "subject", "Manager" ], [ "dist_from_subject", 0, 799 ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/Biker_FriendlyFireLouis03.vcd" }  //OW! Louis!
		{ scenename = "scenes/Biker/Biker_FriendlyFireLouis04.vcd" }  //GODDAMN IT LOUIS! Stop shootin' me.
		{ scenename = "scenes/Biker/Biker_FriendlyFireLouis06.vcd" }  //LOU-IS STOP SHOOTING ME (snarled)
	],
	group_params = none
}

{
	name = "iMT_PlayerFriendlyFireFromNamVetBiker",
	criteria =
	[
		[ "concept", "iMT_PlayerFriendlyFire" ], [ "who", "Biker" ], [ "subject", "NamVet" ], [ "dist_from_subject", 0, 799 ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/Biker_FriendlyFireBill01.vcd" }  //AH! You havin' some kinda flashback Old Man?
		{ scenename = "scenes/Biker/Biker_FriendlyFireBill02.vcd" }  //God DAMMIT, Bill.
		{ scenename = "scenes/Biker/Biker_FriendlyFireBill03.vcd" }  //Bill, quit shootin' me.
		{ scenename = "scenes/Biker/Biker_FriendlyFireBill04.vcd" }  //Watch yer fire, Old Man.
		{ scenename = "scenes/Biker/Biker_FriendlyFireBill05.vcd" }  //Nice shot, Bill. That was my ass.
	],
	group_params = none
}

{
	name = "iMT_PlayerFriendlyFireFromTeenGirlBiker",
	criteria =
	[
		[ "concept", "iMT_PlayerFriendlyFire" ], [ "who", "Biker" ], [ "subject", "TeenGirl" ], [ "dist_from_subject", 0, 799 ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/Biker_FriendlyFireZoey02.vcd" }  //Knock it off, Zoey.
		{ scenename = "scenes/Biker/Biker_FriendlyFireZoey05.vcd" }  //Zoey! Stop shooting me.
	],
	group_params = none
}

{
	name = "iMT_PlayerGetToVehicleBoatBiker",
	criteria =
	[
		[ "concept", "iMT_PlayerGetToVehicleBoat" ], [ "who", "Biker" ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/ArriveBoat01.vcd" }  //Get to the boat!
		{ scenename = "scenes/Biker/ArriveBoat02.vcd" }  //Everyone to the boat!
		{ scenename = "scenes/Biker/ArriveBoat03.vcd" }  //Get your asses on that boat!
		{ scenename = "scenes/Biker/ArriveBoatInitial01.vcd" }  //Our boat's here, all aboard!
		{ scenename = "scenes/Biker/ArriveBoatInitial02.vcd" }  //Our boat's here! Let's go!
	],
	group_params = none
}

{
	name = "iMT_PlayerGetToVehicleChopperBiker",
	criteria =
	[
		[ "concept", "iMT_PlayerGetToVehicleChopper" ], [ "who", "Biker" ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/ArriveChopper01.vcd" }  //Everybody to the chopper!
		{ scenename = "scenes/Biker/ArriveChopper02.vcd" }  //Get to the chopper!
		{ scenename = "scenes/Biker/ArriveChopperInitial01.vcd" }  //The chopper's here! Let's go!
		{ scenename = "scenes/Biker/ArriveChopperInitial02.vcd" }  //The chopper's here! About time, too...
	],
	group_params = none
}

{
	name = "iMT_PlayerGetToVehicleWheelsBiker",
	criteria =
	[
		[ "concept", "iMT_PlayerGetToVehicleWheels" ], [ "who", "Biker" ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/ArriveTruck01.vcd" }  //Run to the truck! Go go go!
		{ scenename = "scenes/Biker/ArriveTruck02.vcd" }  //To the truck!
		{ scenename = "scenes/Biker/ArriveTruck03.vcd" }  //Get to the truck!
		{ scenename = "scenes/Biker/ArriveTruckInitial01.vcd" }  //C'mon, that's the last truck outta this shithole. LET'S GO!
		{ scenename = "scenes/Biker/ArriveTruckInitial02.vcd" }  //The truck's here! Let's go!
	],
	group_params = none
}

{
	name = "iMT_PlayerGoingToDieBiker",
	criteria =
	[
		[ "concept", "iMT_PlayerGoingToDie" ], [ "who", "Biker" ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/GoingToDie01.vcd" }  //I don't feel so good.
		{ scenename = "scenes/Biker/GoingToDie03.vcd" }  //Man, I feel like you guys look.
		{ scenename = "scenes/Biker/GoingToDie04.vcd" }  //I've, I've felt better.
		{ scenename = "scenes/Biker/GoingToDie05.vcd" }  //This is turning into one of those days.
		{ scenename = "scenes/Biker/GoingToDie06.vcd" }  //I have definitely felt better.
		{ scenename = "scenes/Biker/GoingToDie08.vcd" }  //Even my ass hurts.
		{ scenename = "scenes/Biker/GoingToDie09.vcd" }  //This is startin' to get to me.
		{ scenename = "scenes/Biker/GoingToDie11.vcd" }  //I don't wanna sound like a sissy, but I'm hurt bad.
		{ scenename = "scenes/Biker/GoingToDie12.vcd" }  //I think I'm pretty screwed up.
		{ scenename = "scenes/Biker/GoingToDie13.vcd" }  //I'm hurtin'.
		{ scenename = "scenes/Biker/GoingToDie14.vcd" }  //Damnit, I am messed up.
		{ scenename = "scenes/Biker/GoingToDie15.vcd" }  //Shit, this just hurts.
		{ scenename = "scenes/Biker/GoingToDie16.vcd" }  //Oooh mama, this hurts.
		{ scenename = "scenes/Biker/GoingToDie17.vcd" }  //I feel terrible.
		{ scenename = "scenes/Biker/GoingToDie18.vcd" }  //God, I feel awful.
		{ scenename = "scenes/Biker/GoingToDie19.vcd" }  //I think I'm gonna puke.
		{ scenename = "scenes/Biker/GoingToDie20.vcd" }  //I'm feelin' pretty shitty and a little woozy, the woozy is kinda fun.
		{ scenename = "scenes/Biker/GoingToDie22.vcd" }  //Shit, I just hurt.
		{ scenename = "scenes/Biker/GoingToDie23.vcd" }  //I feel like shit.
		{ scenename = "scenes/Biker/GoingToDie24.vcd" }  //I ain't doing so good.
		{ scenename = "scenes/Biker/GoingToDie25.vcd" }  //I feel pretty crappy.
		{ scenename = "scenes/Biker/GoingToDie26.vcd" }  //I feel like guys look after I've punched them in the face.
		{ scenename = "scenes/Biker/GoingToDieLight04.vcd" }  //Ah christ this hurts like hell.
		{ scenename = "scenes/Biker/GoingToDieLight07.vcd" }  //Goddammit, this hurts.
		{ scenename = "scenes/Biker/GoingToDieLight13.vcd" }  //Ah man, somethin' don't feel right.
		{ scenename = "scenes/Biker/GoingToDieLight14.vcd" }  //This [cough] hurts.
	],
	group_params = none
}

{
	name = "iMT_PlayerGoingToDie3Biker",
	criteria =
	[
		[ "concept", "iMT_PlayerGoingToDie" ], [ "who", "Biker" ], [ "onthirdstrike", 1 ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/GoingToDie02.vcd" }  //I don't, I don't know if I am going to make it.
		{ scenename = "scenes/Biker/GoingToDie07.vcd" }  //I need to get patched up.
		{ scenename = "scenes/Biker/GoingToDie10.vcd" }  //I ain't gonna make it much further.
		{ scenename = "scenes/Biker/GoingToDie21.vcd" }  //Shiiit, I ain't gonna make it.
		{ scenename = "scenes/Biker/GoingToDieLight01.vcd" }  //[loud exhale] Shit... [blows air through pursed lips]
		{ scenename = "scenes/Biker/GoingToDieLight11.vcd" }  //I ain't gonna let these goddamn vampires beat me.
		{ scenename = "scenes/Biker/GoingToDieLight15.vcd" }  //I'm pretty hosed.
		{ scenename = "scenes/Biker/GoingToDieLight16.vcd" }  //Killed by vampires. What a goddamn disgrace.
	],
	group_params = none
}

{
	name = "iMT_PlayerGooedBySpitterBiker",
	criteria =
	[
		[ "concept", "iMT_PlayerGooedBySpitter" ], [ "who", "Biker" ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/EmphaticGo02.vcd" }  //MOVE!
		{ scenename = "scenes/Biker/ReactionDisgusted01.vcd" }  //Ewwww...
		{ scenename = "scenes/Biker/ReactionDisgusted06.vcd" }  //Yech...
		{ scenename = "scenes/Biker/Swear01.vcd" }  //Goddammit.
		{ scenename = "scenes/Biker/Swear02.vcd" }  //Shit.
		{ scenename = "scenes/Biker/Swear08.vcd" }  //Ah bullshit.
		{ scenename = "scenes/Biker/Swear12.vcd" }  //Shit.
	],
	group_params = none
}

{
	name = "iMT_PlayerHelloBiker",
	criteria =
	[
		[ "concept", "iMT_PlayerHello" ], [ "who", "Biker" ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/ScenarioJoin04.vcd" }  //Hello!
	],
	group_params = none
}

{
	name = "iMT_PlayerIncapacitatedHurtBiker",
	criteria =
	[
		[ "concept", "iMT_PlayerIncapacitatedHurt" ], [ "who", "Biker" ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/IncapacitatedInjury01.vcd" }  //[Ahhhh - terrified yell]
		{ scenename = "scenes/Biker/IncapacitatedInjury02.vcd" }  //[Ahhhh - terrified yell]
		{ scenename = "scenes/Biker/IncapacitatedInjury03.vcd" }  //[Ahhhh - terrified yell]
		{ scenename = "scenes/Biker/IncapacitatedInjury04.vcd" }  //[Ahhhh - terrified yell]
		{ scenename = "scenes/Biker/IncapacitatedInjury05.vcd" }  //[Ahhhh - terrified yell]
		{ scenename = "scenes/Biker/IncapacitatedInjury06.vcd" }  //[Ahhhh - terrified yell]
	],
	group_params = none
}

{
	name = "iMT_PlayerKillConfirmationBiker",
	criteria =
	[
		[ "concept", "iMT_PlayerKilledZombie" ], [ "who", "Biker" ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/KillConfirmation01.vcd" }  //Got it!
		{ scenename = "scenes/Biker/KillConfirmation02.vcd" }  //Nailed it!
		{ scenename = "scenes/Biker/KillConfirmation03.vcd" }  //Down!
		{ scenename = "scenes/Biker/KillConfirmation04.vcd" }  //That's mine.
		{ scenename = "scenes/Biker/KillConfirmation05.vcd" }  //Dead!
		{ scenename = "scenes/Biker/KillConfirmation06.vcd" }  //Popped it!
		{ scenename = "scenes/Biker/KillConfirmation07.vcd" }  //Popped a cap in his ass!
	],
	group_params = none
}

{
	name = "iMT_PlayerMeleeBiker",
	criteria =
	[
		[ "concept", "iMT_PlayerMelee" ], [ "who", "Biker" ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/Shoved01.vcd" }  //[Melee grunt]
		{ scenename = "scenes/Biker/Shoved02.vcd" }  //[Melee grunt]
		{ scenename = "scenes/Biker/Shoved03.vcd" }  //[Melee grunt]
		{ scenename = "scenes/Biker/Shoved04.vcd" }  //[Melee grunt]
		{ scenename = "scenes/Biker/Shoved05.vcd" }  //[Melee grunt]
		{ scenename = "scenes/Biker/Shoved06.vcd" }  //[Melee grunt]
		{ scenename = "scenes/Biker/Shoved07.vcd" }  //[Melee grunt]
	],
	group_params = none
}

{
	name = "iMT_PlayerMournManagerAliveBiker",
	criteria =
	[
		[ "concept", "iMT_PlayerMourn" ], [ "who", "Biker" ], [ "ismanageralive", 1 ], [ "subject", "Manager" ], [ "dist_from_subject", 0, 199 ]
	],
	responses = SurvivorMournManagerBiker,
	group_params = none
}

{
	name = "iMT_PlayerMournManagerDeadBiker",
	criteria =
	[
		[ "concept", "iMT_PlayerMourn" ], [ "who", "Biker" ], [ "ismanageralive", 0 ], [ "disttomanager", 0, 199 ]
	],
	responses = SurvivorMournManagerBiker,
	group_params = none
}

{
	name = "iMT_PlayerMournNamVetAliveBiker",
	criteria =
	[
		[ "concept", "iMT_PlayerMourn" ], [ "who", "Biker" ], [ "isnamvetalive", 1 ], [ "subject", "NamVet" ], [ "dist_from_subject", 0, 199 ]
	],
	responses = SurvivorMournNamVetBiker,
	group_params = none
}

{
	name = "iMT_PlayerMournNamVetDeadBiker",
	criteria =
	[
		[ "concept", "iMT_PlayerMourn" ], [ "who", "Biker" ], [ "isnamvetalive", 0 ], [ "disttonamvet", 0, 199 ]
	],
	responses = SurvivorMournNamVetBiker,
	group_params = none
}

{
	name = "iMT_PlayerMournTeenGirlAliveBiker",
	criteria =
	[
		[ "concept", "iMT_PlayerMourn" ], [ "who", "Biker" ], [ "isteengirlalive", 1 ], [ "subject", "TeenGirl" ], [ "dist_from_subject", 0, 199 ]
	],
	responses = SurvivorMournTeenGirlBiker,
	group_params = none
}

{
	name = "iMT_PlayerMournTeenGirlDeadBiker",
	criteria =
	[
		[ "concept", "iMT_PlayerMourn" ], [ "who", "Biker" ], [ "isteengirlalive", 0 ], [ "disttoteengirl", 0, 199 ]
	],
	responses = SurvivorMournTeenGirlBiker,
	group_params = none
}

{
	name = "iMT_PlayerNearExitBiker",
	criteria =
	[
		[ "concept", "iMT_PlayerNearExit" ], [ "who", "Biker" ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/FinaleAhead01.vcd" }  //We're almost there!
		{ scenename = "scenes/Biker/FinaleAhead02.vcd" }  //We're almost out of here!
		{ scenename = "scenes/Biker/FinaleAhead03.vcd" }  //Now there's a sight for sore eyes. Looks like we're gonna make it, kids.
		{ scenename = "scenes/Biker/FinaleAhead04.vcd" }  //Hey, we're almost outta this shithole. I told you I'd get you here.
		{ scenename = "scenes/Biker/SafeSpotAhead03.vcd", followup = RThen( "any", "iMT_PlayerNearExitReac", { from = "Biker" }, 0.3 ) }  //We're near a safe spot.
		{ scenename = "scenes/Biker/SafeSpotAhead06.vcd", followup = RThen( "any", "iMT_PlayerNearExitReac", { from = "Biker" }, 0.3 ) }  //Safe house ahead!
		{ scenename = "scenes/Biker/SafeSpotAhead07.vcd", followup = RThen( "any", "iMT_PlayerNearExitReac", { from = "Biker" }, 0.3 ) }  //Safe house!
		{ scenename = "scenes/Biker/SafeSpotAhead08.vcd", followup = RThen( "any", "iMT_PlayerNearExitReac", { from = "Biker" }, 0.3 ) }  //Safe house, let's go!
	],
	group_params = none
}

{
	name = "iMT_PlayerNearExitReacBiker",
	criteria =
	[
		[ "concept", "iMT_PlayerNearExitReac" ], [ "who", "Biker" ], [ "coughing", 0 ], [ "incapacitated", 0 ], [ "speaking", 0], [ "randomnum", 0, 10 ], [ IsTalk ], [ IsTalkBiker ], [ IsWorldTalkBiker ], [ IssuerClose ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/SafeSpotAheadReaction01.vcd" }  //Finally!
		{ scenename = "scenes/Biker/SafeSpotAheadReaction02.vcd" }  //A-men to that!
		{ scenename = "scenes/Biker/SafeSpotAheadReaction03.vcd" }  //Cool!
		{ scenename = "scenes/Biker/SafeSpotAheadReaction04.vcd" }  //Well, all right!
		{ scenename = "scenes/Biker/SafeSpotAheadReaction05.vcd" }  //Finally.
		{ scenename = "scenes/Biker/SafeSpotAheadReaction07.vcd" }  //A-frickin'-men.
	],
	group_params = none
}

{
	name = "iMT_PlayerNiceShotBiker",
	criteria =
	[
		[ "concept", "iMT_PlayerNiceShot" ], [ "who", "Biker" ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/NiceShot01.vcd" }  //Nice shot!
		{ scenename = "scenes/Biker/NiceShot02.vcd" }  //Nice shot!
		{ scenename = "scenes/Biker/NiceShot03.vcd" }  //Good shot!
		{ scenename = "scenes/Biker/NiceShot04.vcd" }  //Good shot!
		{ scenename = "scenes/Biker/NiceShot07.vcd" }  //Whoah. Nice shot.
		{ scenename = "scenes/Biker/NiceShot08.vcd" }  //Good shot. [laughing]
		{ scenename = "scenes/Biker/NiceShot09.vcd" }  //Great shot. [laughing]
		{ scenename = "scenes/Biker/NiceShot10.vcd" }  //Good one!

	],
	group_params = none
}

{
	name = "iMT_PlayerPainNoiseBiker",
	criteria =
	[
		[ "concept", "iMT_PlayerPainNoise" ], [ "who", "Biker" ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/HurtCritical01.vcd" }  //[Pain noise - loud major pain]
		{ scenename = "scenes/Biker/HurtCritical02.vcd" }  //[Pain noise - loud major pain]
		{ scenename = "scenes/Biker/HurtCritical03.vcd" }  //[Pain noise - loud major pain]
		{ scenename = "scenes/Biker/HurtCritical04.vcd" }  //[Pain noise - loud major pain]
		{ scenename = "scenes/Biker/HurtCritical05.vcd" }  //[Pain noise - loud major pain]
		{ scenename = "scenes/Biker/HurtCritical06.vcd" }  //[Pain noise - loud major pain]
		{ scenename = "scenes/Biker/HurtCritical07.vcd" }  //[Pain noise - loud major pain]
		{ scenename = "scenes/Biker/HurtCritical08.vcd" }  //[Pain noise - loud major pain]
		{ scenename = "scenes/Biker/HurtCritical09.vcd" }  //[Pain noise - loud major pain]
		{ scenename = "scenes/Biker/HurtCritical10.vcd" }  //[Pain noise - loud major pain]
		{ scenename = "scenes/Biker/HurtCritical11.vcd" }  //[Pain noise - loud major pain]
		{ scenename = "scenes/Biker/HurtMajor01.vcd" }  //[Pain noise - ahh]
		{ scenename = "scenes/Biker/HurtMajor02.vcd" }  //[Pain noise - huh]
		{ scenename = "scenes/Biker/HurtMajor03.vcd" }  //[Pain noise - oy]
		{ scenename = "scenes/Biker/HurtMajor04.vcd" }  //[Pain noise - ugh]
		{ scenename = "scenes/Biker/HurtMajor05.vcd" }  //[Pain noise - ugh]
		{ scenename = "scenes/Biker/HurtMajor06.vcd" }  //[Pain noise - ugh]
		{ scenename = "scenes/Biker/HurtMajor07.vcd" }  //[Pain noise - ugh]
		{ scenename = "scenes/Biker/HurtMajor08.vcd" }  //[Pain noise - ugh]
		{ scenename = "scenes/Biker/HurtMajor09.vcd" }  //[Pain noise - ugh]
		{ scenename = "scenes/Biker/HurtMajor10.vcd" }  //[Pain noise - ugh]
		{ scenename = "scenes/Biker/HurtMajor11.vcd" }  //[Pain noise - ugh]
	],
	group_params = none
}

{
	name = "iMT_PlayerPouncedManagerBiker",
	criteria =
	[
		[ "concept", "iMT_SurvivorWasPounced" ], [ "who", "Biker" ], [ "subject", "Manager" ], [ "dist_from_subject", 0, 799 ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/HunterLouisPounced01.vcd" }  //Hunter's got Louis!
		{ scenename = "scenes/Biker/HunterLouisPounced02.vcd" }  //Hunter on Louis!
	],
	group_params = none
}

{
	name = "iMT_PlayerPouncedNamVetBiker",
	criteria =
	[
		[ "concept", "iMT_SurvivorWasPounced" ], [ "who", "Biker" ], [ "subject", "NamVet" ], [ "dist_from_subject", 0, 799 ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/HunterBillPounced01.vcd" }  //Hunter's got Bill!
		{ scenename = "scenes/Biker/HunterBillPounced02.vcd" }  //Hunter's on Bill!
	],
	group_params = none
}

{
	name = "iMT_PlayerPouncedTeenGirlBiker",
	criteria =
	[
		[ "concept", "iMT_SurvivorWasPounced" ], [ "who", "Biker" ], [ "subject", "TeenGirl" ], [ "dist_from_subject", 0, 799 ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/HunterZoeyPounced01.vcd" }  //Hunter's got Zoey!
		{ scenename = "scenes/Biker/HunterZoeyPounced02.vcd" }  //Hunter on Zoey!
		{ scenename = "scenes/Biker/HunterZoeyPounced03.vcd" }  //Hey, hunter's got Zoey!
	],
	group_params = none
}

{
	name = "iMT_PlayerReloadingBiker",
	criteria =
	[
		[ "concept", "iMT_PlayerReloading" ], [ "who", "Biker" ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/Reloading01.vcd" }  //Reloading!
		{ scenename = "scenes/Biker/Reloading02.vcd" }  //Reloading!
		{ scenename = "scenes/Biker/Reloading03.vcd" }  //Reloading!
	],
	group_params = none
}

{
	name = "iMT_PlayerSuggestHealthBiker",
	criteria =
	[
		[ "concept", "iMT_PlayerSuggestHealth" ], [ "who", "Biker" ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/PlayerSuggestHealth04.vcd" }  //You should heal up.
		{ scenename = "scenes/Biker/PlayerSuggestHealth05.vcd" }  //Someone should use their health pack...
	],
	group_params = none
}

{
	name = "iMT_PlayerSuggestHealthManagerBiker",
	criteria =
	[
		[ "concept", "iMT_PlayerSuggestHealth" ], [ "who", "Biker" ], [ "subject", "Manager" ], [ "dist_from_subject", 0, 199 ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/PlayerSuggestHealthLouis01.vcd" }  //Hey Louie, use your first aid kit.
		{ scenename = "scenes/Biker/PlayerSuggestHealthLouis02.vcd" }  //Louis, you gotta heal up, man.
		{ scenename = "scenes/Biker/PlayerSuggestHealthLouis03.vcd" }  //Louis, heal fer chrissake.
	],
	group_params = none
}

{
	name = "iMT_PlayerSuggestHealthNamVetBiker",
	criteria =
	[
		[ "concept", "iMT_PlayerSuggestHealth" ], [ "who", "Biker" ], [ "subject", "NamVet" ], [ "dist_from_subject", 0, 199 ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/PlayerSuggestHealthBill01.vcd" }  //Old man - use your health kit.
		{ scenename = "scenes/Biker/PlayerSuggestHealthBill02.vcd" }  //Bill, man, heal up.
		{ scenename = "scenes/Biker/PlayerSuggestHealthBill03.vcd" }  //Bro, heal up.
	],
	group_params = none
}

{
	name = "iMT_PlayerSuggestHealthTeenGirlBiker",
	criteria =
	[
		[ "concept", "iMT_PlayerSuggestHealth" ], [ "who", "Biker" ], [ "subject", "TeenGirl" ], [ "dist_from_subject", 0, 199 ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/PlayerSuggestHealthZoey01.vcd" }  //Zoey, heal up.
		{ scenename = "scenes/Biker/PlayerSuggestHealthZoey02.vcd" }  //Zoey darlin', heal up.
		{ scenename = "scenes/Biker/PlayerSuggestHealthZoey03.vcd" }  //Zoey, patch yerself up.
		{ scenename = "scenes/Biker/PlayerSuggestHealthZoey04.vcd" }  //Hey Zoey, you oughtta heal.
	],
	group_params = none
}

{
	name = "iMT_PlayerTeamKillBiker",
	criteria =
	[
		[ "concept", "iMT_PlayerTeamKill" ], [ "who", "Biker" ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/TeamKillAccident01.vcd" }  //Be careful!
		{ scenename = "scenes/Biker/TeamKillAccident02.vcd" }  //That was not cool.
		{ scenename = "scenes/Biker/TeamKillAccident03.vcd" }  //That was not cool.
		{ scenename = "scenes/Biker/TeamKillAccident04.vcd" }  //Pull yer head outta yer ass.
		{ scenename = "scenes/Biker/TeamKillAccident05.vcd" }  //Careful!
		{ scenename = "scenes/Biker/TeamKillAccident06.vcd" }  //Hey! Careful!
	],
	group_params = none
}

{
	name = "iMT_PlayerTransitionBiker",
	criteria =
	[
		[ "concept", "iMT_PlayerTransition" ], [ "who", "Biker" ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/PlayerTransitionClose01.vcd" }  //Any zombie fight you can crawl away from means you won it.
		{ scenename = "scenes/Biker/PlayerTransitionClose02.vcd" }  //Heh heh, well all right!
		{ scenename = "scenes/Biker/PlayerTransitionClose03.vcd" }  //That was close!
		{ scenename = "scenes/Biker/PlayerTransitionClose04.vcd" }  //Thought we were goners. [laughing]
	],
	group_params = none
}

{
	name = "iMT_PlayerTransitionCloseBiker",
	criteria =
	[
		[ "concept", "iMT_PlayerTransition" ], [ "who", "Biker" ], [ "numberofteamdead", 1, null ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/PlayerTransitionClose05.vcd" }  //This shit ain't easy.
		{ scenename = "scenes/Biker/PlayerTransitionClose06.vcd" }  //Killin' vampires looked easier in the brochure, dinnit?
	],
	group_params = none
}

{
	name = "iMT_PlayerTransitionSoloBiker",
	criteria =
	[
		[ "concept", "iMT_PlayerTransition" ], [ "who", "Biker" ], [ "numberofteamdead", 1, null ], [ "numberofteamalive", 1 ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/PlayerTransitionClose05.vcd" }  //This shit ain't easy.
	],
	group_params = none
}

{
	name = "iMT_PlayerWitchChasingBiker",
	criteria =
	[
		[ "concept", "iMT_PlayerWitchChasing" ], [ "who", "Biker" ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/Help03.vcd" }  //I'm in trouble!
		{ scenename = "scenes/Biker/Help08.vcd" }  //I'm in some trouble!
		{ scenename = "scenes/Biker/IncapacitatedInjury03.vcd" }  //[Ahhhh - terrified yell]
		{ scenename = "scenes/Biker/IncapacitatedInjury04.vcd" }  //[Ahhhh - terrified yell]
		{ scenename = "scenes/Biker/IncapacitatedInjury05.vcd" }  //[Ahhhh - terrified yell]
		{ scenename = "scenes/Biker/IncapacitatedInjury06.vcd" }  //[Ahhhh - terrified yell]
	],
	group_params = none
}

{
	name = "iMT_SurvivorCaughtVomitBiker",
	criteria =
	[
		[ "concept", "iMT_PlayerVomitInFace" ], [ "who", "Biker" ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/ReactionBoomerVomit01.vcd" }  //Shit.
		{ scenename = "scenes/Biker/ReactionBoomerVomit02.vcd" }  //Ah, ewww, ah, yuck.
		{ scenename = "scenes/Biker/ReactionBoomerVomit03.vcd" }  //Holy Jesus! That's bad!
		{ scenename = "scenes/Biker/ReactionBoomerVomit04.vcd" }  //Eh, yech...
		{ scenename = "scenes/Biker/ReactionBoomerVomit05.vcd" }  //Ewwww... ah shit! Yech...
		{ scenename = "scenes/Biker/ReactionDisgusted01.vcd" }  //Ewwww...
		{ scenename = "scenes/Biker/ReactionDisgusted02.vcd" }  //Blech...
		{ scenename = "scenes/Biker/ReactionDisgusted03.vcd" }  //Yech...
		{ scenename = "scenes/Biker/ReactionDisgusted04.vcd" }  //Eh...
		{ scenename = "scenes/Biker/ReactionDisgusted05.vcd" }  //Blech...
		{ scenename = "scenes/Biker/ReactionDisgusted06.vcd" }  //Yech...
		{ scenename = "scenes/Biker/ReactionDisgusted07.vcd" }  //Ah, ewww, ah, yuck.
		{ scenename = "scenes/Biker/ReactionDisgusted08.vcd" }  //Sick...
		{ scenename = "scenes/Biker/ReactionDisgusted09.vcd" }  //Ohhh...
		{ scenename = "scenes/Biker/ReactionDisgusted10.vcd" }  //Oh, that's disgusting.
	],
	group_params = none
}

{
	name = "iMT_SurvivorCaughtVomit%Biker",
	criteria =
	[
		[ "concept", "iMT_PlayerVomitInFace" ], [ "who", "Biker" ], [ "randomnum", 0, 2 ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/Generic03.vcd" } //He puked on me!
	],
	group_params = none
}

//--------------------------------------------------------------------------------------------------
// Character-specific
//--------------------------------------------------------------------------------------------------

{
	name = "iMT_AllAboardBiker",
	criteria =
	[
		[ "concept", "iMT_AllAboard" ], [ "who", "Biker" ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/C6DLC3BridgeAvailable01.vcd" }  //All aboard! The bridge...
	],
	group_params = none
}

{
	name = "iMT_BraveBiker",
	criteria =
	[
		[ "concept", "iMT_Brave" ], [ "who", "Biker" ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/C6DLC3JumpingOffBridge01.vcd" }  //Jesus, I'm brave.
		{ scenename = "scenes/Biker/C6DLC3JumpingOffBridge02.vcd" }  //Guess I better save everybody.
	],
	group_params = none
}

{
	name = "iMT_ChickenshitsReacBiker",
	criteria =
	[
		[ "concept", "iMT_ChickenshitsReac" ], [ "who", "Biker" ], [ "coughing", 0 ], [ "incapacitated", 0 ], [ "speaking", 0], [ IsTalk ], [ IsTalkBiker ], [ IsWorldTalkBiker ], [ IssuerClose ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/C6DLC3TankInTrainYard04.vcd" }  //Fine with me.
	],
	group_params = none
}

{
	name = "iMT_DogBiker",
	criteria =
	[
		[ "concept", "iMT_Dog" ], [ "who", "Biker" ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/DLC1_C6M3_FinaleChat43.vcd" }  //I wonder whatever happened to that dog? Hope he's okay.
	],
	group_params = none
}

{
	name = "iMT_FrozenBeardBiker",
	criteria =
	[
		[ "concept", "iMT_FrozenBeard" ], [ "who", "Biker" ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/DLC1_CommunityL4D101.vcd" }  //Hey Bill, your beard's frozen.
	],
	group_params = none
}

{
	name = "iMT_GodIsDeadBiker",
	criteria =
	[
		[ "concept", "iMT_GodIsDead" ], [ "who", "Biker" ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/WorldAirport0426.vcd" }  //God's dead, huh? Well, join the damn club.
	],
	group_params = none
}

{
	name = "iMT_HateBiker",
	criteria =
	[
		[ "concept", "iMT_Hate" ], [ "who", "Biker" ]
	],
	responses = HateBiker,
	group_params = none
}

{
	name = "iMT_Hate%Biker",
	criteria =
	[
		[ "concept", "iMT_Hate" ], [ "who", "Biker" ], [ "randomnum", 0, 2 ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/WorldHospital0404.vcd" }  //I hate hospitals. And doctors and lawyers and cops...
	],
	group_params = none
}

{
	name = "iMT_HateTooBiker",
	criteria =
	[
		[ "concept", "iMT_HateToo" ], [ "who", "Biker" ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/DLC1_C6M3_FinaleChat11.vcd" }  //Oh my god. I HATE THOSE TOO! I HATE 'EM SO MUCH!
		{ scenename = "scenes/Biker/DLC1_C6M3_FinaleChat12.vcd" }  //Oh my god. You hate stuff too?
		{ scenename = "scenes/Biker/DLC1_C6M3_FinaleChat13.vcd" }  //Oh my god. You hate stuff too?
	],
	group_params = none
}

{
	name = "iMT_HeroBiker",
	criteria =
	[
		[ "concept", "iMT_Hero" ], [ "who", "Biker" ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/WorldAirport05NPC10.vcd" }  //Yeah, yeah, we get it. You're a hero.
	],
	group_params = none
}

{
	name = "iMT_HerschBiker",
	criteria =
	[
		[ "concept", "iMT_Hersch" ], [ "who", "Biker" ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/DLC2Hersch01.vcd" }  //I drove for Hersch once. Till some guy laughed at my little brown shorts. And I beat him to death.
	],
	group_params = none
}

{
	name = "iMT_ImACopBiker",
	criteria =
	[
		[ "concept", "iMT_ImACop" ], [ "who", "Biker" ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/DLC1_C6M3_FinaleChat21.vcd" }  //Nah, I'm a cop.
		{ scenename = "scenes/Biker/DLC1_C6M3_FinaleChat22.vcd" }  //No no no, I am a cop.
	],
	group_params = none
}

{
	name = "iMT_LatestIssueReacBiker",
	criteria =
	[
		[ "concept", "iMT_LatestIssueReac" ], [ "who", "Biker" ], [ "coughing", 0 ], [ "incapacitated", 0 ], [ "speaking", 0], [ IsTalk ], [ IsTalkBiker ], [ IsWorldTalkBiker ], [ IssuerClose ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/DLC2MagazineRack01.vcd" }  //I hate latest issues.
	],
	group_params = none
}

{
	name = "iMT_LoveRoBiker",
	criteria =
	[
		[ "concept", "iMT_LoveRo" ], [ "who", "Biker" ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/DLC1_C6M3_L4D1FinaleCinematic07.vcd" }  //Bye-bye RO! My lovely little angel.
		{ scenename = "scenes/Biker/DLC1_C6M3_L4D1FinaleCinematic16.vcd" }  //Bye RO! I love you!!!!!!!
		{ scenename = "scenes/Biker/DLC1_C6M3_L4D1FinaleCinematic17.vcd" }  //Bye RO! I love you!!!!!!! (sobbing) I love you!
	],
	group_params = none
}

{
	name = "iMT_NervousHummingBiker",
	criteria =
	[
		[ "concept", "iMT_NervousHumming" ], [ "who", "Biker" ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/NervousHumming01.vcd" }  //[Not-So-Nervous Humming]
		{ scenename = "scenes/Biker/NervousHumming06.vcd" }  //[Not-So-Nervous Humming]
		{ scenename = "scenes/Biker/NervousHumming07.vcd" }  //[Not-So-Nervous Humming with lame zombie lyrics]
	],
	group_params = none
}

{
	name = "iMT_PassingGasManagerBiker",
	criteria =
	[
		[ "concept", "iMT_PassingGas" ], [ "who", "Biker" ], [ "subject", "Manager" ], [ "dist_from_subject", 0, 399 ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/DLC2GasTanks02.vcd" }  //Hey, Louis, look! We're 'passing gas'... [chuckles]
	],
	group_params = none
}

{
	name = "iMT_PassingGasNamVetBiker",
	criteria =
	[
		[ "concept", "iMT_PassingGas" ], [ "who", "Biker" ], [ "subject", "NamVet" ], [ "dist_from_subject", 0, 399 ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/DLC2GasTanks03.vcd" }  //Hey, Bill, look! We're 'passing gas'... [chuckles]
	],
	group_params = none
}

{
	name = "iMT_PassingGasTeenGirlBiker",
	criteria =
	[
		[ "concept", "iMT_PassingGas" ], [ "who", "Biker" ], [ "subject", "TeenGirl" ], [ "dist_from_subject", 0, 399 ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/DLC2GasTanks01.vcd" }  //Hey, Zoey, look! We're 'passing gas'... [chuckles]
	],
	group_params = none
}

{
	name = "iMT_PredictBiker",
	criteria =
	[
		[ "concept", "iMT_Predict" ], [ "who", "Biker" ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/C6DLC3LouisDies01.vcd" }  //I could have predicted that.
	],
	group_params = none
}

{
	name = "iMT_RecycleBiker",
	criteria =
	[
		[ "concept", "iMT_Recycle" ], [ "who", "Biker" ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/DLC2Recycling01.vcd" }  //Thanks for saving the planet, recyclers. Mission accomplished.
		{ scenename = "scenes/Biker/DLC2Recycling02.vcd" }  //Copper... aluminum... brass... those guys recycle everything!
	],
	group_params = none
}

{
	name = "iMT_ShortLaughBiker",
	criteria =
	[
		[ "concept", "iMT_ShortLaugh" ], [ "who", "Biker" ], [ "coughing", 0 ], [ "incapacitated", 0 ], [ "speaking", 0], [ IsTalk ], [ IsTalkBiker ], [ IsWorldTalkBiker ], [ IssuerClose ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/Laughter05.vcd" }  //<Short laugh>
		{ scenename = "scenes/Biker/Laughter09.vcd" }  //<Short laugh>
		{ scenename = "scenes/Biker/ReactionPositive01.vcd" }  //[Laugh]
	],
	group_params = none
}

{
	name = "iMT_ShotHimBiker",
	criteria =
	[
		[ "concept", "iMT_ShotHim" ], [ "who", "Biker" ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/DLC1_C6M3_FinaleChat05.vcd" }  //Oh yeah. Bill definitely woulda shot him.
	],
	group_params = none
}

{
	name = "iMT_SlowBiker",
	criteria =
	[
		[ "concept", "iMT_Slow" ], [ "who", "Biker" ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/DLC1_C6M3_FinaleChat33.vcd" }  //Takin' it slow, huh? I can respect that.
	],
	group_params = none
}

{
	name = "iMT_SnowColdReacBiker",
	criteria =
	[
		[ "concept", "iMT_SnowColdReac" ], [ "who", "Biker" ], [ "coughing", 0 ], [ "incapacitated", 0 ], [ "speaking", 0], [ "randomnum", 0, 10 ], [ IsTalk ], [ IsTalkBiker ], [ IsWorldTalkBiker ], [ IssuerClose ]
	],
	responses = HateBiker,
	group_params = none
}

{
	name = "iMT_StinkReacBiker",
	criteria =
	[
		[ "concept", "iMT_StinkReac" ], [ "who", "Biker" ], [ "coughing", 0 ], [ "incapacitated", 0 ], [ "speaking", 0], [ "randomnum", 0, 50 ], [ IsTalk ], [ IsTalkBiker ], [ IsWorldTalkBiker ], [ IssuerClose ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/Generic04.vcd" }  //Oh hey, that is uncalled for!
		{ scenename = "scenes/Biker/TeamKillOnPurpose09.vcd" }  //Hey! Hey!
	],
	group_params = none
}

{
	name = "iMT_TankFactoryReacBiker",
	criteria =
	[
		[ "concept", "iMT_TankFactoryReac" ], [ "who", "Biker" ], [ "coughing", 0 ], [ "incapacitated", 0 ], [ "speaking", 0], [ IsTalk ], [ IsTalkBiker ], [ IsWorldTalkBiker ], [ IssuerCloseEnough ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/C6DLC3InTankTrainCar01.vcd", followup = RThen( "Manager", "iMT_TankFactory2", null, 0.3 ) }  //Tanks?
	],
	group_params = none
}

{
	name = "iMT_ThisFarBiker",
	criteria =
	[
		[ "concept", "iMT_ThisFar" ], [ "who", "Biker" ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/DLC1_C6M3_FinaleChat19.vcd" }  //Hey! Never thought a fancy ass like you would have made it this far.
	],
	group_params = none
}

{
	name = "iMT_WaterworksBiker",
	criteria =
	[
		[ "concept", "iMT_Waterworks" ], [ "who", "Biker" ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/DLC2Waterworks01.vcd" }  //Waterworks. That where you pick up your crying supplies, Bill? Ah ha ha, I'm hilarious.
	],
	group_params = none
}

{
	name = "iMT_WomanOfTasteBiker",
	criteria =
	[
		[ "concept", "iMT_WomanOfTaste" ], [ "who", "Biker" ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/DLC1_C6M3_FinaleChat31.vcd" }  //What? She's a woman of taste.
		{ scenename = "scenes/Biker/DLC1_C6M3_FinaleChat32.vcd" }  //What? Obviously she's a woman of taste.
	],
	group_params = none
}

{
	name = "iMT_YourNameBiker",
	criteria =
	[
		[ "concept", "iMT_YourName" ], [ "who", "Biker" ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/DLC1_C6M3_FinaleChat02.vcd" }  //What's your name again?
		{ scenename = "scenes/Biker/DLC1_C6M3_FinaleChat06.vcd" }  //What's your name again?
	],
	group_params = none
}

//--------------------------------------------------------------------------------------------------
// Overrides
//--------------------------------------------------------------------------------------------------

{
	name = "iMT_PlayerAnswerLostCallBiker",
	criteria =
	[
		[ "concept", "PlayerAnswerLostCall" ], [ "who", "Biker" ], [ "coughing", 0 ], [ "numberofteamalive", 4, null ], [ "numberofteamdead", 0 ], [ "disttoclosestsurvivor", 0, 499 ], [ "randomnum", 0, 10 ], [ IsTalk ], [ IsTalkBiker ], [ IsWorldTalkBiker ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/ScenarioJoinLast01.vcd" }  //We're all here!
	],
	group_params = none
}

{
	name = "iMT_PlayerHeardBoomerBiker",
	criteria =
	[
		[ "concept", "PlayerHeardBoomer" ], [ "who", "Biker" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkBiker ], [ IsWorldTalkBiker ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/HeardBoomer01.vcd" }  //I hear a Boomer out there.
		{ scenename = "scenes/Biker/HeardBoomer02.vcd" }  //Careful, I hear a Boomer.
		{ scenename = "scenes/Biker/HeardBoomer03.vcd" }  //There's a Boomer around here.
		{ scenename = "scenes/Biker/HeardBoomer04.vcd" }  //Watch it, we got a Boomer.
		{ scenename = "scenes/Biker/HeardBoomer05.vcd" }  //Hear that Boomer? I'm gonna kill its ass.
		{ scenename = "scenes/Biker/HeardBoomer06.vcd" }  //I hear a Boomer.
	],
	group_params = none
}

{
	name = "iMT_PlayerHeardBoomerC9M2Biker",
	criteria =
	[
		[ "concept", "PlayerHeardBoomer" ], [ "who", "Biker" ], [ "coughing", 0 ], [ "map", "c9m2_lots" ], [ "randomnum", 0, 10 ], [ IsTalk ], [ IsTalkBiker ], [ IsWorldTalkBiker ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/DLC2CanadaSpecial01.vcd" }  //I HEAR A BOOMER! And it sounded Canadian!
	],
	group_params = none
}

{
	name = "iMT_PlayerHeardHunterBiker",
	criteria =
	[
		[ "concept", "PlayerHeardHunter" ], [ "who", "Biker" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkBiker ], [ IsWorldTalkBiker ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/HeardHunter01.vcd" }  //There's a hunter out there.
		{ scenename = "scenes/Biker/HeardHunter02.vcd" }  //Careful, there's a Hunter around here.
		{ scenename = "scenes/Biker/HeardHunter03.vcd" }  //I hear a Hunter.
		{ scenename = "scenes/Biker/HeardHunter04.vcd" }  //Careful, there's a Hunter around here.
		{ scenename = "scenes/Biker/HeardHunter05.vcd" }  //Sounds like a freakin' Hunter.
		{ scenename = "scenes/Biker/HeardHunter06.vcd" }  //Hunter out there.
		{ scenename = "scenes/Biker/HeardHunter07.vcd" }  //There's a Hunter someplace around here.
		{ scenename = "scenes/Biker/HeardHunter08.vcd" }  //I hear a Hunter. COME ON OUT, WUSSY!
		{ scenename = "scenes/Biker/HeardHunter09.vcd" }  //YEAH, YOU BETTER HIDE! Sweathshirt wearin' little wuss.
	],
	group_params = none
}

{
	name = "iMT_PlayerHeardSmokerBiker",
	criteria =
	[
		[ "concept", "PlayerHeardSmoker" ], [ "who", "Biker" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkBiker ], [ IsWorldTalkBiker ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/HeardSmoker01.vcd" }  //Man, there's a Smoker around here.
		{ scenename = "scenes/Biker/HeardSmoker02.vcd" }  //Smell that Smoker?
		{ scenename = "scenes/Biker/HeardSmoker03.vcd" }  //Smoker. Hear it?
		{ scenename = "scenes/Biker/HeardSmoker04.vcd" }  //I hear a Smoker.
		{ scenename = "scenes/Biker/HeardSmoker05.vcd" }  //Sounds like a Smoker.
		{ scenename = "scenes/Biker/HeardSmoker06.vcd" }  //Smoker. He's gonna have to use that tongue to choke my foot out of his ass.
		{ scenename = "scenes/Biker/HeardSmoker07.vcd" }  //Sounds like a Smoker.
	],
	group_params = none
}

{
	name = "iMT_PlayerHeardWitchBiker",
	criteria =
	[
		[ "concept", "PlayerHeardWitch" ], [ "who", "Biker" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkBiker ], [ IsWorldTalkBiker ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/HeardWitch01.vcd" }  //I hear a Witch.
		{ scenename = "scenes/Biker/HeardWitch02.vcd" }  //Witch, and she's close!
		{ scenename = "scenes/Biker/HeardWitch03.vcd" }  //There's a Witch around here.
		{ scenename = "scenes/Biker/HeardWitch04.vcd" }  //Witch, and she's close!
		{ scenename = "scenes/Biker/HeardWitch05.vcd" }  //Hear that Witch? I'm gonna give her something to cry about.
		{ scenename = "scenes/Biker/HeardWitch06.vcd" }  //Shhh, I hear a Witch.
		{ scenename = "scenes/Biker/HeardWitch07.vcd" }  //There's a Witch around here.
		{ scenename = "scenes/Biker/HeardWitch08.vcd" }  //I hear a Witch.
	],
	group_params = none
}

{
	name = "iMT_PlayerHurrahBiker",
	criteria =
	[
		[ "concept", "PlayerHurrah" ], [ "who", "Biker" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkBiker ], [ IsWorldTalkBiker ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/Hurrah05.vcd", followup = RThen( "any", "HurrahAlso", null, 0.3 ) }  //We just might make it out of here after all.
		{ scenename = "scenes/Biker/Hurrah06.vcd" }  //We're gonna be okay.
		{ scenename = "scenes/Biker/Hurrah07.vcd", followup = RThen( "any", "HurrahAlso", null, 0.3 ) }  //I think we're gonna make it.
		{ scenename = "scenes/Biker/Hurrah08.vcd", followup = RThen( "any", "HurrahAlso", null, 0.3 ) }  //They can't stop us.
		{ scenename = "scenes/Biker/Hurrah09.vcd", followup = RThen( "any", "HurrahAlso", null, 0.3 ) }  //Nothing can stop us.
		{ scenename = "scenes/Biker/Hurrah10.vcd", followup = RThen( "any", "HurrahAlso", null, 0.3 ) }  //We are unstoppable!
		{ scenename = "scenes/Biker/Hurrah12.vcd", followup = RThen( "any", "HurrahAlso", null, 0.3 ) }  //Everybody havin' as much fun as me?
		{ scenename = "scenes/Biker/Hurrah13.vcd", followup = RThen( "any", "HurrahAlso", null, 0.3 ) }  //Everyone havin' fun?
		{ scenename = "scenes/Biker/Hurrah14.vcd", followup = RThen( "any", "HurrahAlso", null, 0.3 ) }  //You know all those monsters? I don't think they're gonna make it.
		{ scenename = "scenes/Biker/Hurrah15.vcd", followup = RThen( "any", "HurrahAlso", null, 0.3 ) }  //We just might make it out of here after all.
		{ scenename = "scenes/Biker/Hurrah21.vcd", followup = RThen( "any", "HurrahAlso", null, 0.3 ) }  //You guys are all right.
		{ scenename = "scenes/Biker/Hurrah22.vcd" }  //I think we gotta chance.
		{ scenename = "scenes/Biker/Hurrah23.vcd" }  //Lookin' good.
		{ scenename = "scenes/Biker/Hurrah24.vcd", followup = RThen( "any", "HurrahAlso", null, 0.3 ) }  //Hey, this is just gettin fun.
	],
	group_params = none
}

{
	name = "iMT_PlayerLaughBiker",
	criteria =
	[
		[ "concept", "PlayerLaugh" ], [ "who", "Biker" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkBiker ], [ IsWorldTalkBiker ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/Laughter04.vcd" }  //<Hearty Laugh>
		{ scenename = "scenes/Biker/Laughter12.vcd" }  //<Hearty Laugh>
		{ scenename = "scenes/Biker/Laughter13.vcd" }  //<Hearty Laugh>
		{ scenename = "scenes/Biker/Laughter14.vcd" }  //<Hearty Laugh>
		{ scenename = "scenes/Biker/Laughter15.vcd" }  //<Hearty Laugh>
	],
	group_params = none
}

{
	name = "iMT_PlayerLaughAloneBiker",
	criteria =
	[
		[ "concept", "PlayerLaugh" ], [ "who", "Biker" ], [ "coughing", 0 ], [ "numberofteamalive", 1 ], [ "onthirdstrike", 1 ], [ IsTalk ], [ IsTalkBiker ], [ IsWorldTalkBiker ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/Laughter02.vcd" }  //<Nervous laugh>
		{ scenename = "scenes/Biker/Laughter05.vcd" }  //<Short laugh>
		{ scenename = "scenes/Biker/Laughter06.vcd" }  //<Nervous laugh>
	],
	group_params = none
}

{
	name = "iMT_PlayerNegativeBiker",
	criteria =
	[
		[ "concept", "PlayerNegative" ], [ "who", "Biker" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkBiker ], [ IsWorldTalkBiker ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/ReactionNegative05.vcd" }  //Shit
		{ scenename = "scenes/Biker/ReactionNegative06.vcd" }  //Ah shit.
		{ scenename = "scenes/Biker/ReactionNegative07.vcd" }  //Damnit.
		{ scenename = "scenes/Biker/ReactionNegative08.vcd" }  //Damnit.
		{ scenename = "scenes/Biker/ReactionNegative10.vcd" }  //Effin hell.
		{ scenename = "scenes/Biker/Swear01.vcd" }  //Goddammit.
		{ scenename = "scenes/Biker/Swear02.vcd" }  //Shit.
		{ scenename = "scenes/Biker/Swear03.vcd" }  //Ah shit.
		{ scenename = "scenes/Biker/Swear04.vcd" }  //Ah hell.
		{ scenename = "scenes/Biker/Swear06.vcd" }  //Crap.
		{ scenename = "scenes/Biker/Swear08.vcd" }  //Ah bullshit.
		{ scenename = "scenes/Biker/Swear09.vcd" }  //Dammit.
		{ scenename = "scenes/Biker/Swear10.vcd" }  //Bullshit.
		{ scenename = "scenes/Biker/Swear12.vcd" }  //Shit.
		{ scenename = "scenes/Biker/Swear14.vcd" }  //Ah hell.
		{ scenename = "scenes/Biker/Swear15.vcd" }  //Son of a bitch.
		{ scenename = "scenes/Biker/Swear16.vcd" }  //Ah bullshit.
		{ scenename = "scenes/Biker/Swear17.vcd" }  //Dammit.
		{ scenename = "scenes/Biker/Swear18.vcd" }  //Bullshit.
		{ scenename = "scenes/Biker/Swear19.vcd" }  //Ah bullshit.
		{ scenename = "scenes/Biker/SwearCoupDeGrace01.vcd" }  //Burn you son of a bitch.
	],
	group_params = none
}

{
	name = "iMT_PlayerRelaxedSighBiker",
	criteria =
	[
		[ "concept", "RelaxedSigh" ], [ "who", "Biker" ], [ "speaking", 1 ]
	],
	responses =
	[
		{ scenename = "" }
	],
	group_params = none
}

{
	name = "iMT_PlayerThanksManagerBiker",
	criteria =
	[
		[ "concept", "PlayerThanks" ], [ "who", "Biker" ], [ "coughing", 0 ], [ "subject", "Manager" ], [ "dist_from_subject", 0, 99 ], [ "randomnum", 0, 30 ], [ IsTalk ], [ IsTalkBiker ], [ IsWorldTalkBiker ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/Thanks13.vcd" }  //Thanks bro.
		{ scenename = "scenes/Biker/Thanks18.vcd" }  //Thanks, Louis.
		{ scenename = "scenes/Biker/Thanks19.vcd" }  //Thanks, Louis. I owe you one.
	],
	group_params = none
}

{
	name = "iMT_PlayerThanksNamVetBiker",
	criteria =
	[
		[ "concept", "PlayerThanks" ], [ "who", "Biker" ], [ "coughing", 0 ], [ "subject", "NamVet" ], [ "dist_from_subject", 0, 99 ], [ "randomnum", 0, 30 ], [ IsTalk ], [ IsTalkBiker ], [ IsWorldTalkBiker ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/Thanks14.vcd" }  //Thanks brother.
		{ scenename = "scenes/Biker/Thanks16.vcd" }  //Thanks, Bill.
	],
	group_params = none
}

{
	name = "iMT_PlayerThanksTeenGirlBiker",
	criteria =
	[
		[ "concept", "PlayerThanks" ], [ "who", "Biker" ], [ "coughing", 0 ], [ "subject", "TeenGirl" ], [ "dist_from_subject", 0, 99 ], [ "randomnum", 0, 30 ], [ IsTalk ], [ IsTalkBiker ], [ IsWorldTalkBiker ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/Thanks17.vcd" }  //Thanks, Zoey.
	],
	group_params = none
}

{
	name = "iMT_ResponseSoftDispleasureSwearBiker",
	criteria =
	[
		[ "concept", "ResponseSoftDispleasureSwear" ], [ "who", "Biker" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkBiker ], [ IsWorldTalkBiker ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/Laughter08.vcd" }  //<Short laugh>
		{ scenename = "scenes/Biker/NegativeNoise08.vcd" }  //[Improv non-verbal displeasure & frustration sounds]
		{ scenename = "scenes/Biker/ReactionApprehensive03.vcd" }  //I don't like this one damn bit.
		{ scenename = "scenes/Biker/ReactionNegative02.vcd" }  //That's bad.
		{ scenename = "scenes/Biker/ReactionNegative03.vcd" }  //Damn
		{ scenename = "scenes/Biker/ReactionNegative04.vcd" }  //Holy jesus.
		{ scenename = "scenes/Biker/ReactionNegative09.vcd" }  //Ahhhhh.
	],
	group_params = none
}

{
	name = "iMT_SurvivorAskForHealthBiker",
	criteria =
	[
		[ "concept", "AskForHealth2" ], [ "who", "Biker" ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/GoingToDieAskForHeal01.vcd" }  //Anyone have some first aid? I'm about to die.
		{ scenename = "scenes/Biker/GoingToDieAskForHeal02.vcd" }  //Sure could use a med kit. Just sayin'.
		{ scenename = "scenes/Biker/GoingToDieAskForHeal03.vcd" }  //Can anyone patch me up?
		{ scenename = "scenes/Biker/GoingToDieAskForHeal04.vcd" }  //Hey, someone wanna patch me up?
	],
	group_params = none
}

{
	name = "iMT_SurvivorAskForHealthManagerBiker",
	criteria =
	[
		[ "concept", "AskForHealth2" ], [ "who", "Biker" ], [ "onthirdstrike", 0 ], [ "subject", "Manager" ], [ "dist_from_subject", 0, 399 ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/PlayerSuggestHealthSpecific06.vcd" }  //Louis, you got a med kit I could have?
		{ scenename = "scenes/Biker/PlayerSuggestHealthSpecific08.vcd" }  //Louis, don't bogard that med kit, man. I'm hurt.
		{ scenename = "scenes/Biker/PlayerSuggestHealthSpecific10.vcd" }  //Louis, while I hate to break that ensemble and all, can I have your health pack?
		{ scenename = "scenes/Biker/PlayerSuggestHealthSpecific12.vcd" }  //Louis, gimme your health pack.
	],
	group_params = none
}

{
	name = "iMT_SurvivorAskForHealthNamVetBiker",
	criteria =
	[
		[ "concept", "AskForHealth2" ], [ "who", "Biker" ], [ "onthirdstrike", 0 ], [ "subject", "NamVet" ], [ "dist_from_subject", 0, 399 ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/PlayerSuggestHealthSpecific05.vcd" }  //Bill, could I borrow your med kit? I just wanna look at it.
		{ scenename = "scenes/Biker/PlayerSuggestHealthSpecific07.vcd" }  //Hey Bill, you got a med kit I could have?
		{ scenename = "scenes/Biker/PlayerSuggestHealthSpecific11.vcd" }  //Old man, you forget you have a health pack, or you just saving that for me?
	],
	group_params = none
}

{
	name = "iMT_SurvivorAskForHealthTeenGirlBiker",
	criteria =
	[
		[ "concept", "AskForHealth2" ], [ "who", "Biker" ], [ "onthirdstrike", 0 ], [ "subject", "TeenGirl" ], [ "dist_from_subject", 0, 399 ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/PlayerSuggestHealthSpecific04.vcd" }  //Zoey, you got a health kit for me?
		{ scenename = "scenes/Biker/PlayerSuggestHealthSpecific09.vcd" }  //Hey little lady, if you ain't gonna use that health kit I could use it.
	],
	group_params = none
}

{
	name = "iMT_SurvivorCoughingDeathBiker",
	criteria =
	[
		[ "concept", "PlayerDeath" ], [ "who", "Biker" ], [ "coughing", 1 ], [ IsTalk ], [ IsTalkBiker ], [ IsWorldTalkBiker ]
	],
	responses = SurvivorCoughingBiker,
	group_params = none
}

{
	name = "iMT_SurvivorDeathBiker",
	criteria =
	[
		[ "concept", "PlayerDeath" ], [ "who", "Biker" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkBiker ], [ IsWorldTalkBiker ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/DeathScream01.vcd" }  //[Death rattle]
		{ scenename = "scenes/Biker/DeathScream02.vcd" }  //[Death rattle]
		{ scenename = "scenes/Biker/DeathScream03.vcd" }  //[Death rattle]
		{ scenename = "scenes/Biker/DeathScream04.vcd" }  //[Death rattle]
		{ scenename = "scenes/Biker/DeathScream05.vcd" }  //[Death rattle] Mama...
		{ scenename = "scenes/Biker/DeathScream06.vcd" }  //[Short quick death scream]
		{ scenename = "scenes/Biker/DeathScream07.vcd" }  //[Short quick death scream]
		{ scenename = "scenes/Biker/DeathScream08.vcd" }  //[Loud painful death scream]
		{ scenename = "scenes/Biker/DeathScream09.vcd" }  //[Loud painful death scream]
		{ scenename = "scenes/Biker/DeathScream10.vcd" }  //[Short quick death scream]
	],
	group_params = none
}

{
	name = "iMT_SurvivorSpottedAmmoBiker",
	criteria =
	[
		[ "concept", "PlayerSpotAmmo" ], [ "who", "Biker" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkBiker ], [ IsWorldTalkBiker ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/SpotAmmo01.vcd" }  //Ammo here!
	],
	group_params = none
}

{
	name = "iMT_SurvivorSpottedBoomerBiker",
	criteria =
	[
		[ "concept", "PlayerWarnBoomer" ], [ "who", "Biker" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkBiker ], [ IsWorldTalkBiker ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/WarnBoomer01.vcd" }  //BOOMER!
		{ scenename = "scenes/Biker/WarnBoomer02.vcd" }  //BOOMER!
		{ scenename = "scenes/Biker/WarnBoomer03.vcd" }  //BOOMER!
	],
	group_params = none
}

{
	name = "iMT_SurvivorSpottedChargerBiker",
	criteria =
	[
		[ "concept", "PlayerWarnCharger" ], [ "who", "Biker" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkBiker ], [ IsWorldTalkBiker ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/DLC1_L4D1Charger01.vcd" }  //CHARGER!
		{ scenename = "scenes/Biker/DLC1_L4D1Charger02.vcd" }  //CHARGER!
		{ scenename = "scenes/Biker/DLC1_L4D1Charger03.vcd" }  //CHARGER!
	],
	group_params = none
}

{
	name = "iMT_SurvivorSpottedCharger%Biker",
	criteria =
	[
		[ "concept", "PlayerWarnCharger" ], [ "who", "Biker" ], [ "coughing", 0 ], [ "randomnum", 0, 20 ], [ IsTalk ], [ IsTalkBiker ], [ IsWorldTalkBiker ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/DLC1_C6M3_L4D11stSpot03.vcd" }  //Big guy!
	],
	group_params = none
}

{
	name = "iMT_SurvivorSpottedHunterBiker",
	criteria =
	[
		[ "concept", "PlayerWarnHunter" ], [ "who", "Biker" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkBiker ], [ IsWorldTalkBiker ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/WarnHunter01.vcd" }  //HUNTER!
		{ scenename = "scenes/Biker/WarnHunter02.vcd" }  //HUNTER!
		{ scenename = "scenes/Biker/WarnHunter03.vcd" }  //HUNTER!
	],
	group_params = none
}

{
	name = "iMT_SurvivorSpottedHunterC9M2Biker",
	criteria =
	[
		[ "concept", "PlayerWarnHunter" ], [ "who", "Biker" ], [ "coughing", 0 ], [ "map", "c9m2_lots" ], [ "randomnum", 0, 10 ], [ IsTalk ], [ IsTalkBiker ], [ IsWorldTalkBiker ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/DLC2CanadaSpecial02.vcd" }  //HUNTER! It looked Canadian!
	],
	group_params = none
}

{
	name = "iMT_SurvivorSpottedInfectedBiker",
	criteria =
	[
		[ "concept", "PlayerIncoming" ], [ "who", "Biker" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkBiker ], [ IsWorldTalkBiker ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/Incoming01.vcd" }  //Here they come!
		{ scenename = "scenes/Biker/Incoming02.vcd" }  //Holy shit, here they come!
		{ scenename = "scenes/Biker/Incoming03.vcd" }  //They're coming!
		{ scenename = "scenes/Biker/Incoming04.vcd" }  //Incoming!
		{ scenename = "scenes/Biker/Incoming05.vcd" }  //Get ready ladies!
		{ scenename = "scenes/Biker/Incoming06.vcd" }  //INCOMING!
		{ scenename = "scenes/Biker/Incoming07.vcd" }  //This is gonna be good.
		{ scenename = "scenes/Biker/Incoming08.vcd" }  //Shit, get ready!
	],
	group_params = none
}

{
	name = "iMT_SurvivorSpottedJockeyBiker",
	criteria =
	[
		[ "concept", "PlayerWarnJockey" ], [ "who", "Biker" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkBiker ], [ IsWorldTalkBiker ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/DLC1_L4D1Jockey01.vcd" }  //JOCKEY!
		{ scenename = "scenes/Biker/DLC1_L4D1Jockey02.vcd" }  //JOCKEY!
		{ scenename = "scenes/Biker/DLC1_L4D1Jockey03.vcd" }  //JOCKEY!
	],
	group_params = none
}

{
	name = "iMT_SurvivorSpottedJockey%Biker",
	criteria =
	[
		[ "concept", "PlayerWarnJockey" ], [ "who", "Biker" ], [ "coughing", 0 ], [ "randomnum", 0, 20 ], [ IsTalk ], [ IsTalkBiker ], [ IsWorldTalkBiker ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/DLC1_C6M3_L4D11stSpot04.vcd" }  //Little guy!
		{ scenename = "scenes/Biker/DLC1_C6M3_L4D11stSpot05.vcd" }  //Little vampire!
	],
	group_params = none
}

{
	name = "iMT_SurvivorSpottedSmokerBiker",
	criteria =
	[
		[ "concept", "PlayerWarnSmoker" ], [ "who", "Biker" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkBiker ], [ IsWorldTalkBiker ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/WarnSmoker01.vcd" }  //SMOKER!
		{ scenename = "scenes/Biker/WarnSmoker02.vcd" }  //SMOKER!
		{ scenename = "scenes/Biker/WarnSmoker03.vcd" }  //SMOKER!
	],
	group_params = none
}

{
	name = "iMT_SurvivorSpottedSpitterBiker",
	criteria =
	[
		[ "concept", "PlayerWarnSpitter" ], [ "who", "Biker" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkBiker ], [ IsWorldTalkBiker ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/DLC1_L4D1Spitter01.vcd" }  //SPITTER!
		{ scenename = "scenes/Biker/DLC1_L4D1Spitter02.vcd" }  //SPITTER!
		{ scenename = "scenes/Biker/DLC1_L4D1Spitter03.vcd" }  //SPITTER!
	],
	group_params = none
}

{
	name = "iMT_SurvivorSpottedTankBiker",
	criteria =
	[
		[ "concept", "PlayerWarnTank" ], [ "who", "Biker" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkBiker ], [ IsWorldTalkBiker ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/WarnTank01.vcd" }  //TANK!
		{ scenename = "scenes/Biker/WarnTank02.vcd" }  //TANK!
		{ scenename = "scenes/Biker/WarnTank03.vcd" }  //TANK!
	],
	group_params = none
}

{
	name = "iMT_SurvivorSpottedTanks2Biker",
	criteria =
	[
		[ "concept", "PlayerWarnTank" ], [ "who", "Biker" ], [ "coughing", 0 ], [ "tankactive", 1 ], [ IsTalk ], [ IsTalkBiker ], [ IsWorldTalkBiker ], [ IsZombiePresentTanks2 ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/DLC1_L4D1Tank02.vcd" }  //Oh shit, two tanks!
	],
	group_params = none
}

{
	name = "iMT_SurvivorSpottedTanks2%Biker",
	criteria =
	[
		[ "concept", "PlayerWarnTank" ], [ "who", "Biker" ], [ "coughing", 0 ], [ "tankactive", 1 ], [ "randomnum", 0, 20 ], [ IsTalk ], [ IsTalkBiker ], [ IsWorldTalkBiker ], [ IsZombiePresentTanks2 ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/DLC1_L4D1Tank03.vcd" }  //TWO TANKS!? I HATE THE SOUTH!
	],
	group_params = none
}

{
	name = "iMT_SurvivorSpottedWeaponsBiker",
	criteria =
	[
		[ "concept", "PlayerSpotOtherWeapon" ], [ "who", "Biker" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkBiker ], [ IsWorldTalkBiker ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/SpotWeapons01.vcd" }  //Weapons here!
		{ scenename = "scenes/Biker/SpotWeapons02.vcd" }  //Weapons over here!
		{ scenename = "scenes/Biker/SpotWeapons03.vcd" }  //Buncha guns over here!
		{ scenename = "scenes/Biker/SpotWeapons04.vcd" }  //Weapons over here!
		{ scenename = "scenes/Biker/SpotWeapons05.vcd" }  //We got weapons over here.
	],
	group_params = none
}

{
	name = "iMT_SurvivorSpottedWitchBiker",
	criteria =
	[
		[ "concept", "PlayerWarnWitch" ], [ "who", "Biker" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkBiker ], [ IsWorldTalkBiker ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/WarnWitch01.vcd" }  //WITCH!
		{ scenename = "scenes/Biker/WarnWitch02.vcd" }  //WITCH!
		{ scenename = "scenes/Biker/WarnWitch03.vcd" }  //WITCH!
	],
	group_params = none
}

{
	name = "iMT_SurvivorTauntResponseBiker",
	criteria =
	[
		[ "concept", "PlayerTaunt" ], [ "who", "Biker" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkBiker ], [ IsWorldTalkBiker ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/Hurrah01.vcd" }  //All right.
		{ scenename = "scenes/Biker/Hurrah02.vcd" }  //Aw riiiight.
		{ scenename = "scenes/Biker/Hurrah03.vcd" }  //Awesome.
		{ scenename = "scenes/Biker/Hurrah04.vcd" }  //Awesome.
		{ scenename = "scenes/Biker/Hurrah11.vcd" }  //YEAH!
		{ scenename = "scenes/Biker/Hurrah16.vcd" }  //Awesome.
		{ scenename = "scenes/Biker/Hurrah17.vcd" }  //Aw riiiight.
		{ scenename = "scenes/Biker/Hurrah18.vcd" }  //Aw riiiight.
		{ scenename = "scenes/Biker/Hurrah19.vcd" }  //Goddamn right!
		{ scenename = "scenes/Biker/Hurrah20.vcd" }  //Hell yeah!
		{ scenename = "scenes/Biker/ReactionPositive03.vcd" }  //Rock-n-roll!
		{ scenename = "scenes/Biker/ReactionPositive06.vcd" }  //Hell yeah!
		{ scenename = "scenes/Biker/ReactionPositive08.vcd" }  //Yeah!
		{ scenename = "scenes/Biker/ReactionPositive10.vcd" }  //Hell yeah!
		{ scenename = "scenes/Biker/ReactionPositive11.vcd" }  //All right!
		{ scenename = "scenes/Biker/Taunt01.vcd" }  //That's right!
		{ scenename = "scenes/Biker/Taunt02.vcd" }  //HELL YEAH!
		{ scenename = "scenes/Biker/Taunt03.vcd" }  //OH YEAH!
		{ scenename = "scenes/Biker/Taunt04.vcd" }  //Oh yeah!
		{ scenename = "scenes/Biker/Taunt05.vcd" }  //[Loud, evil laugh]
		{ scenename = "scenes/Biker/Taunt06.vcd" }  //[Loud, evil laugh]
		{ scenename = "scenes/Biker/Taunt07.vcd" }  //[Loud, evil laugh]
		{ scenename = "scenes/Biker/Taunt08.vcd" }  //YEAH! YEAH!
		{ scenename = "scenes/Biker/Taunt09.vcd" }  //Damn straight!
		{ scenename = "scenes/Biker/Taunt10.vcd" }  //HELL YEAH!
	],
	group_params = none
}

{
	name = "iMT_SurvivorVocalizeBackUpBiker",
	criteria =
	[
		[ "concept", "PlayerBackUp" ], [ "who", "Biker" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkBiker ], [ IsWorldTalkBiker ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/BackUp01.vcd" }  //BackBackBack!
		{ scenename = "scenes/Biker/BackUp02.vcd" }  //Back up!
		{ scenename = "scenes/Biker/BackUp03.vcd" }  //Back up!
		{ scenename = "scenes/Biker/BackUp04.vcd" }  //Get the hell back!
		{ scenename = "scenes/Biker/BackUp05.vcd" }  //Back it up!
	],
	group_params = none
}

{
	name = "iMT_SurvivorVocalizeBackUpQuietBiker",
	criteria =
	[
		[ "concept", "PlayerBackUp" ], [ "who", "Biker" ], [ "coughing", 0 ], [ "tankactive", 0 ], [ "incombatmusic", 0 ], [ IsTalk ], [ IsTalkBiker ], [ IsWorldTalkBiker ], [ IsWitchNear ], [ IsNotWitchAggro ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/BackUpQuiet01.vcd" }  //Back up.
		{ scenename = "scenes/Biker/BackUpQuiet02.vcd" }  //Back up, back up.
		{ scenename = "scenes/Biker/BackUpQuiet03.vcd" }  //Back up.
	],
	group_params = none
}

{
	name = "iMT_SurvivorVocalizeEmphaticGoBiker",
	criteria =
	[
		[ "concept", "PlayerEmphaticGo" ], [ "who", "Biker" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkBiker ], [ IsWorldTalkBiker ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/EmphaticGo01.vcd" }  //GET MOVING!
		{ scenename = "scenes/Biker/EmphaticGo02.vcd" }  //MOVE!
		{ scenename = "scenes/Biker/EmphaticGo03.vcd" }  //Go go go!
		{ scenename = "scenes/Biker/EmphaticGo04.vcd" }  //GO!
		{ scenename = "scenes/Biker/EmphaticGo05.vcd" }  //Get your rear in gear!
		{ scenename = "scenes/Biker/EmphaticGo06.vcd" }  //Get your rear in gear!
	],
	group_params = none
}

{
	name = "iMT_SurvivorVocalizeLookOutBiker",
	criteria =
	[
		[ "concept", "PlayerLookOut" ], [ "who", "Biker" ], [ "coughing", 0 ], [ "world_auto_finale", 2 ], [ IsTalk ], [ IsTalkBiker ], [ IsWorldTalkBiker ]
	],
	responses =
	[
		{ scenename = "scenes/Biker/LookOut01.vcd" }  //Look out!
		{ scenename = "scenes/Biker/LookOut02.vcd" }  //Look out!
		{ scenename = "scenes/Biker/LookOut03.vcd" }  //Watch out!
		{ scenename = "scenes/Biker/LookOut04.vcd" }  //Watch out!
		{ scenename = "scenes/Biker/LookOut05.vcd" }  //Watch your ass!
		{ scenename = "scenes/Biker/LookOut06.vcd" }  //Heads up!
	],
	group_params = none
}

//--------------------------------------------------------------------------------------------------
// Start Area
//--------------------------------------------------------------------------------------------------

{
	name = "iMT_EllisStoryInterruptGenericBiker",
	criteria =
	[
		[ "concept", "EllisInterrupt" ], [ "who", "Biker" ], [ "world_auto_tellingstory", 1 ], [ _auto_NotDidInterrupt ]
	],
	responses =
	[
		{
			scenename = "scenes/Biker/DLC1_C6M1_InitialMeeting03.vcd", followup = RThen( "Mechanic", "EllisStoryReac01", null, 0.3 ),  //Nope, not a chance.
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
	name = "iMT_SafeRoomStartBiker",
	criteria =
	[
		[ "concept", "TLK_IDLE" ], [ "who", "Biker" ], [ "instartarea", 1 ], [ IsNotScavenge ], [ IsNotSurvival ], [ _auto_NotSafeRoomStart ]
	],
	responses =
	[
		{
			scenename = "scenes/Biker/Blank.vcd",
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

rr_ProcessRules( Biker )