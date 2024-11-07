//--------------------------------------------------------------------------------------------------
// ion's Vocalizer: NamVet Response Rules
//--------------------------------------------------------------------------------------------------

// Shared responses

local SurvivorCoughingNamVet =
[
	{ scenename = "scenes/NamVet/Cough01.vcd" }  //(Coughing from smoke)
	{ scenename = "scenes/NamVet/Cough02.vcd" }  //(Coughing from smoke)
	{ scenename = "scenes/NamVet/Cough03.vcd" }  //(Coughing from smoke)
	{ scenename = "scenes/NamVet/Cough04.vcd" }  //(Coughing from smoke)
	{ scenename = "scenes/NamVet/Cough05.vcd" }  //(Coughing from smoke)
	{ scenename = "scenes/NamVet/Cough06.vcd" }  //(Coughing from smoke)
]

local SurvivorMournBikerNamVet =
[
	{ scenename = "scenes/NamVet/GriefBiker01.vcd" }  //Ah, not Francis.
	{ scenename = "scenes/NamVet/GriefBiker02.vcd" }  //Christ, I'm gonna miss that son of a bitch.
	{ scenename = "scenes/NamVet/GriefBiker03.vcd" }  //I am going to miss that man and his gun.
]

local SurvivorMournManagerNamVet =
[
	{ scenename = "scenes/NamVet/GriefManager01.vcd" }  //Ah, Louis.
	{ scenename = "scenes/NamVet/GriefManager02.vcd" }  //Louis didn't make it. Ah, Christ.
	{ scenename = "scenes/NamVet/GriefManager03.vcd" }  //Come on, people. If we make it, he didn't die for nothin'.
]

local SurvivorMournTeenGirlNamVet =
[
	{ scenename = "scenes/NamVet/GriefFemaleGeneric01.vcd" }  //She's dead!
	{ scenename = "scenes/NamVet/GriefFemaleGeneric02.vcd" }  //Ah Christ, she's dead!
	{ scenename = "scenes/NamVet/GriefFemaleGeneric04.vcd" }  //Goddamit, she didn't make it.
	{ scenename = "scenes/NamVet/GriefTeengirl01.vcd" }  //Ah not Zoey.
	{ scenename = "scenes/NamVet/GriefTeengirl02.vcd" }  //Ah jesus. What a waste.
	{ scenename = "scenes/NamVet/GriefTeengirl03.vcd" }  //One of those sick sons of bitches just sealed all a' their death warrants.
]

//--------------------------------------------------------------------------------------------------
// Ellis Stories
//--------------------------------------------------------------------------------------------------

local NamVet =
[

{
	name = "iMT_EllisStoryInterruptNamVet",
	criteria =
	[
		[ "concept", "iMT_EllisStoryInterrupt" ], [ "who", "NamVet" ], [ "world_auto_tellingstory", 1 ], [ "coughing", 0 ], [ "incapacitated", 0 ], [ "speaking", 0], [ IsTalk ], [ IsTalkNamVet ], [ IsWorldTalkNamVet ], [ IssuerCloseEnough ]
	],
	responses =
	[
		{ scenename = "scenes/NamVet/C6DLC3SecondSafeRoom15.vcd", followup = RThen( "Mechanic", "iMT_EllisStoryReac", { from = "NamVet" }, 0.3 ) }  //Noted. Let's go.
	],
	group_params = none
}

{
	name = "iMT_EllisStoryStopNamVet",
	criteria =
	[
		[ "concept", "iMT_EllisStories" ], [ "who", "NamVet" ], [ "world_auto_tellingstory", 1 ]
	],
	responses =
	[
		{
			scenename = "scenes/NamVet/C6DLC3Intro28.vcd", followup = RThen( "all", "iMT_EllisStoryStop", null, 0.3 ),  //Shut your traps, let's move out.
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
	name = "iMT_PlayerAnswerReadyNamVet",
	criteria =
	[
		[ "concept", "iMT_PlayerAnswerReady" ], [ "who", "NamVet" ]
	],
	responses =
	[
		{ scenename = "scenes/NamVet/AnswerReady01.vcd" }  //Ready.
		{ scenename = "scenes/NamVet/AnswerReady02.vcd" }  //Good to go.
		{ scenename = "scenes/NamVet/AnswerReady03.vcd" }  //I'm ready.
		{ scenename = "scenes/NamVet/AnswerReady04.vcd" }  //I said I'm ready!
	],
	group_params = none
}

{
	name = "iMT_PlayerBattleCryNamVet",
	criteria =
	[
		[ "concept", "iMT_PlayerBattleCry" ], [ "who", "NamVet" ]
	],
	responses =
	[
		{ scenename = "scenes/NamVet/Taunt01.vcd" }  //[loud, evil laugh]
		{ scenename = "scenes/NamVet/Taunt02.vcd" }  //[loud, evil laugh]
		{ scenename = "scenes/NamVet/Taunt07.vcd" }  //[loud, evil laugh]
		{ scenename = "scenes/NamVet/Taunt08.vcd" }  //[loud, evil laugh]
		{ scenename = "scenes/NamVet/Taunt09.vcd" }  //[loud, evil laugh]
	],
	group_params = none
}

{
	name = "iMT_PlayerBreathingNamVet",
	criteria =
	[
		[ "concept", "iMT_PlayerBreathing" ], [ "who", "NamVet" ]
	],
	responses =
	[
		{ scenename = "scenes/NamVet/ExertionCritical01.vcd" }  //[frightened freaked out breathing]
		{ scenename = "scenes/NamVet/ExertionCritical02.vcd" }  //[frightened freaked out breathing]
		{ scenename = "scenes/NamVet/ExertionCritical03.vcd" }  //[frightened freaked out breathing]
		{ scenename = "scenes/NamVet/ExertionCritical04.vcd" }  //[frightened freaked out breathing]
		{ scenename = "scenes/NamVet/ExertionMajor01.vcd" }  //[heavy breathing - seriously winded]
		{ scenename = "scenes/NamVet/ExertionMajor02.vcd" }  //[heavy breathing - seriously winded]
		{ scenename = "scenes/NamVet/ExertionMinor01.vcd" }  //[breathing - panting out of breath]
		{ scenename = "scenes/NamVet/ExertionMinor02.vcd" }  //[breathing - panting out of breath]
	],
	group_params = none
}

{
	name = "iMT_PlayerCloseTheDoorNamVet",
	criteria =
	[
		[ "concept", "iMT_PlayerCloseTheDoor" ], [ "who", "NamVet" ]
	],
	responses =
	[
		{ scenename = "scenes/NamVet/CloseTheDoor01.vcd" }  //That door ain't gonna lock itself, people.
		{ scenename = "scenes/NamVet/CloseTheDoor02.vcd" }  //Lock the door. Do it!
		{ scenename = "scenes/NamVet/CloseTheDoor03.vcd" }  //Lock that door.
		{ scenename = "scenes/NamVet/CloseTheDoor04.vcd" }  //Lock the door.
		{ scenename = "scenes/NamVet/CloseTheDoor05.vcd" }  //Lock that door!
		{ scenename = "scenes/NamVet/CloseTheDoor06.vcd" }  //Lock the door.
		{ scenename = "scenes/NamVet/CloseTheDoor07.vcd" }  //Lock that door.
		{ scenename = "scenes/NamVet/CloseTheDoor08.vcd" }  //Lock that door.
		{ scenename = "scenes/NamVet/CloseTheDoor09.vcd" }  //Lock the door.
		{ scenename = "scenes/NamVet/CloseTheDoor10.vcd" }  //That door ain't gonna lock itself, people.
		{ scenename = "scenes/NamVet/CloseTheDoor11.vcd" }  //Secure that door!
		{ scenename = "scenes/NamVet/CloseTheDoor12.vcd" }  //Secure the door!
		{ scenename = "scenes/NamVet/CloseTheDoor13.vcd" }  //Lock the door.
	],
	group_params = none
}

{
	name = "iMT_PlayerCoughingNamVet",
	criteria =
	[
		[ "concept", "iMT_PlayerCoughing" ], [ "who", "NamVet" ]
	],
	responses = SurvivorCoughingNamVet,
	group_params = none
}

{
	name = "iMT_PlayerDeathScreamNamVet",
	criteria =
	[
		[ "concept", "iMT_PlayerDeathScream" ], [ "who", "NamVet" ]
	],
	responses =
	[
		{ scenename = "scenes/NamVet/Fall01.vcd" }  //[Death scream as you fall]
		{ scenename = "scenes/NamVet/Fall02.vcd" }  //[Death scream as you fall]
		{ scenename = "scenes/NamVet/Fall03.vcd" }  //[Death scream as you fall]
		{ scenename = "scenes/NamVet/Fall04.vcd" }  //[Death scream as you fall]
	],
	group_params = none
}

{
	name = "iMT_PlayerFriendlyFireNamVet",
	criteria =
	[
		[ "concept", "iMT_PlayerFriendlyFire" ], [ "who", "NamVet" ]
	],
	responses =
	[
		{ scenename = "scenes/NamVet/FriendlyFire01.vcd" }  //Ahh! That hurt!
		{ scenename = "scenes/NamVet/FriendlyFire02.vcd" }  //Ah! Knock it off!
		{ scenename = "scenes/NamVet/FriendlyFire03.vcd" }  //Do I look like a target?
		{ scenename = "scenes/NamVet/FriendlyFire04.vcd" }  //You know, I would appreciate it IF YOU'D STOP SHOOTING ME!
		{ scenename = "scenes/NamVet/FriendlyFire05.vcd" }  //Watch where you're shooting!
		{ scenename = "scenes/NamVet/FriendlyFire06.vcd" }  //Goddamn it, watch your fire!
		{ scenename = "scenes/NamVet/FriendlyFire07.vcd" }  //Jesus H Christ, I'm on your side.
		{ scenename = "scenes/NamVet/FriendlyFire08.vcd" }  //Watch where you're shooting!
		{ scenename = "scenes/NamVet/FriendlyFire10.vcd" }  //Watch where you point that thing!
		{ scenename = "scenes/NamVet/FriendlyFire11.vcd" }  //Watch where you're shooting!
		{ scenename = "scenes/NamVet/FriendlyFire12.vcd" }  //Do not shoot me!
		{ scenename = "scenes/NamVet/FriendlyFire13.vcd" }  //Goddamit, watch where you're shooting!
		{ scenename = "scenes/NamVet/FriendlyFire14.vcd" }  //Check your fire!
		{ scenename = "scenes/NamVet/FriendlyFire15.vcd" }  //Secure that weapon!
		{ scenename = "scenes/NamVet/FriendlyFire16.vcd" }  //Hold your fire!
		{ scenename = "scenes/NamVet/FriendlyFire17.vcd" }  //Who's side are you on, kid?
	],
	group_params = none
}

{
	name = "iMT_PlayerFriendlyFireFromBikerNamVet",
	criteria =
	[
		[ "concept", "iMT_PlayerFriendlyFire" ], [ "who", "NamVet" ], [ "subject", "Biker" ], [ "dist_from_subject", 0, 799 ]
	],
	responses =
	[
		{ scenename = "scenes/NamVet/NamVet_FriendlyFireFrancis01.vcd" }  //Francis, check your fire!
		{ scenename = "scenes/NamVet/NamVet_FriendlyFireFrancis02.vcd" }  //What the hell are you doin' Francis?
		{ scenename = "scenes/NamVet/NamVet_FriendlyFireFrancis03.vcd" }  //Francis! [through gritted teeth]
		{ soundname = "Player.NamVet_FriendlyFireFrancis01" }  //Jesus H Christ, Francis!
		{ soundname = "Player.NamVet_FriendlyFireFrancis02" }  //Goddamnit, Francis! Watch your fire!
		{ soundname = "Player.NamVet_FriendlyFireFrancis03" }  //Francis! Watch where you're shooting!
	],
	group_params = none
}

{
	name = "iMT_PlayerFriendlyFireFromBiker%NamVet",
	criteria =
	[
		[ "concept", "iMT_PlayerFriendlyFire" ], [ "who", "NamVet" ], [ "subject", "Biker" ], [ "dist_from_subject", 0, 799 ], [ "randomnum", 0, 2 ]
	],
	responses =
	[
		{ scenename = "scenes/NamVet/Generic22.vcd" }  //Close your mouth and open your eyes, Francis. You'll aim better.
	],
	group_params = none
}

{
	name = "iMT_PlayerFriendlyFireFromManagerNamVet",
	criteria =
	[
		[ "concept", "iMT_PlayerFriendlyFire" ], [ "who", "NamVet" ], [ "subject", "Manager" ], [ "dist_from_subject", 0, 799 ]
	],
	responses =
	[
		{ scenename = "scenes/NamVet/NamVet_FriendlyFireLouis01.vcd" }  //Goddamnit Louis, stop shooting me!
		{ scenename = "scenes/NamVet/NamVet_FriendlyFireLouis02.vcd" }  //Knock it off, Louis!
		{ scenename = "scenes/NamVet/NamVet_FriendlyFireLouis03.vcd" }  //Louis! [through gritted teeth]
	],
	group_params = none
}

{
	name = "iMT_PlayerFriendlyFireFromTeenGirlNamVet",
	criteria =
	[
		[ "concept", "iMT_PlayerFriendlyFire" ], [ "who", "NamVet" ], [ "subject", "TeenGirl" ], [ "dist_from_subject", 0, 799 ]
	],
	responses =
	[
		{ scenename = "scenes/NamVet/NamVet_FriendlyFireZoey04.vcd" }  //Zoey! [through gritted teeth]
	],
	group_params = none
}

{
	name = "iMT_PlayerGetToVehicleBoatNamVet",
	criteria =
	[
		[ "concept", "iMT_PlayerGetToVehicleBoat" ], [ "who", "NamVet" ]
	],
	responses =
	[
		{ scenename = "scenes/NamVet/ArriveBoat01.vcd" }  //Run to the boat!
		{ scenename = "scenes/NamVet/ArriveBoat02.vcd" }  //Get to the boat!
		{ scenename = "scenes/NamVet/ArriveBoat03.vcd" }  //To the boat! MOVE!
		{ scenename = "scenes/NamVet/ArriveBoat04.vcd" }  //Haul ass to that boat! RUN!
		{ scenename = "scenes/NamVet/ArriveBoatInitial01.vcd" }  //That's the boat! Time to bug out!
		{ scenename = "scenes/NamVet/ArriveBoatInitial02.vcd" }  //Allright, the boat's here! Let's go!
	],
	group_params = none
}

{
	name = "iMT_PlayerGetToVehicleChopperNamVet",
	criteria =
	[
		[ "concept", "iMT_PlayerGetToVehicleChopper" ], [ "who", "NamVet" ]
	],
	responses =
	[
		{ scenename = "scenes/NamVet/ArriveChopper01.vcd" }  //Get to the chopper! GO!
		{ scenename = "scenes/NamVet/ArriveChopper02.vcd" }  //Get to the chopper!
		{ scenename = "scenes/NamVet/ArriveChopper03.vcd" }  //To the chopper. Come on, MOVE IT, MOVE IT, MOVE IT!
		{ scenename = "scenes/NamVet/ArriveChopper04.vcd" }  //Get to the LZ!
		{ scenename = "scenes/NamVet/ArriveChopperInitial01.vcd" }  //Our chopper's here! Let's get the hell out of dodge.
		{ scenename = "scenes/NamVet/ArriveChopperInitial02.vcd" }  //The bird's here! Let's go!
	],
	group_params = none
}

{
	name = "iMT_PlayerGetToVehicleWheelsNamVet",
	criteria =
	[
		[ "concept", "iMT_PlayerGetToVehicleWheels" ], [ "who", "NamVet" ]
	],
	responses =
	[
		{ scenename = "scenes/NamVet/ArriveTruck01.vcd" }  //Get to the truck! MOVE!
		{ scenename = "scenes/NamVet/ArriveTruck02.vcd" }  //Get to the truck!
		{ scenename = "scenes/NamVet/ArriveTruck03.vcd" }  //Get to that truck on the double!
		{ scenename = "scenes/NamVet/ArriveTruck04.vcd" }  //The truck's waitin'. RUN!
		{ scenename = "scenes/NamVet/ArriveTruckInitial01.vcd" }  //The truck's here! Let's go!
		{ scenename = "scenes/NamVet/ArriveTruckInitial02.vcd" }  //The truck has arrived! Let's move out, people!
	],
	group_params = none
}

{
	name = "iMT_PlayerGoingToDieNamVet",
	criteria =
	[
		[ "concept", "iMT_PlayerGoingToDie" ], [ "who", "NamVet" ]
	],
	responses =
	[
		{ scenename = "scenes/NamVet/GoingToDie01.vcd" }  //I don't feel so good.
		{ scenename = "scenes/NamVet/GoingToDie03.vcd" }  //I feel awful.
		{ scenename = "scenes/NamVet/GoingToDie04.vcd" }  //I am in bad shape, people.
		{ scenename = "scenes/NamVet/GoingToDie05.vcd" }  //I'm gettin' too old for this horseshit.
		{ scenename = "scenes/NamVet/GoingToDie06.vcd" }  //I feel terrible.
		{ scenename = "scenes/NamVet/GoingToDie08.vcd" }  //[to self] Goddamn horseshit.
		{ scenename = "scenes/NamVet/GoingToDie09.vcd" }  //It's not lookin' good for me.
		{ scenename = "scenes/NamVet/GoingToDie10.vcd" }  //I'm not feelin' too hot.
		{ scenename = "scenes/NamVet/GoingToDie11.vcd" }  //Ah shit, I'm not doin' too good here.
		{ scenename = "scenes/NamVet/GoingToDie12.vcd" }  //I'm really hurt, people.
		{ scenename = "scenes/NamVet/GoingToDie13.vcd" }  //Christ, I'm messed up.
		{ scenename = "scenes/NamVet/GoingToDie14.vcd" }  //[sharp intake of breath followed by grunt]
		{ scenename = "scenes/NamVet/GoingToDie16.vcd" }  //I feel awful.
		{ scenename = "scenes/NamVet/GoingToDie17.vcd" }  //God damn it, I am seriously fubar.
		{ scenename = "scenes/NamVet/GoingToDie18.vcd" }  //[pain sound followed by two grunts]
		{ scenename = "scenes/NamVet/GoingToDie21.vcd" }  //[pain sound] I think I'm goin' home in a box.
		{ scenename = "scenes/NamVet/GoingToDie22.vcd" }  //I feel like hell.
		{ scenename = "scenes/NamVet/GoingToDie26.vcd" }  //Dammit, I'm bleeding out.
		{ scenename = "scenes/NamVet/GoingToDieLight01.vcd" }  //This old body ain't gonna make it.
		{ scenename = "scenes/NamVet/GoingToDieLight02.vcd" }  //Ah shit, I ain't feelin' right.
		{ scenename = "scenes/NamVet/GoingToDieLight03.vcd" }  //Something ain't workin' right.
		{ scenename = "scenes/NamVet/GoingToDieLight04.vcd" }  //This just ain't my day...
		{ scenename = "scenes/NamVet/GoingToDieLight06.vcd" }  //Ah. <breath> Dammit.
		{ scenename = "scenes/NamVet/GoingToDieLight07.vcd" }  //<wincing pain noise> Hell with this.
		{ scenename = "scenes/NamVet/GoingToDieLight08.vcd" }  //Hell, I was too old for this shit fifteen years ago.
	],
	group_params = none
}

{
	name = "iMT_PlayerGoingToDie3NamVet",
	criteria =
	[
		[ "concept", "iMT_PlayerGoingToDie" ], [ "who", "NamVet" ], [ "onthirdstrike", 1 ]
	],
	responses =
	[
		{ scenename = "scenes/NamVet/GoingToDie02.vcd" }  //I don't know if I am going to make it.
		{ scenename = "scenes/NamVet/GoingToDie07.vcd" }  //You people might have to go on without me.
		{ scenename = "scenes/NamVet/GoingToDie15.vcd" }  //We gotta find me a medic.
		{ scenename = "scenes/NamVet/GoingToDie20.vcd" }  //I'm just barely hangin' on here.
		{ scenename = "scenes/NamVet/GoingToDie23.vcd" }  //I'm about to buy the farm.
		{ scenename = "scenes/NamVet/GoingToDie24.vcd" }  //If I go down, don't let those bastards eat me.
		{ scenename = "scenes/NamVet/GoingToDie27.vcd" }  //I'm not gonna hold out much longer.
	],
	group_params = none
}

{
	name = "iMT_PlayerGooedBySpitterNamVet",
	criteria =
	[
		[ "concept", "iMT_PlayerGooedBySpitter" ], [ "who", "NamVet" ]
	],
	responses =
	[
		{ scenename = "scenes/NamVet/EmphaticGo04.vcd" }  //MOVE MOVE MOVE!
		{ scenename = "scenes/NamVet/ReactionDisgusted01.vcd" }  //Ewwww...
		{ scenename = "scenes/NamVet/ReactionDisgusted04.vcd" }  //Oh shit.
		{ scenename = "scenes/NamVet/Swears07.vcd" }  //Ah hell.
		{ scenename = "scenes/NamVet/Swears08.vcd" }  //Dammit.
		{ scenename = "scenes/NamVet/Swears10.vcd" }  //Mother of mercy.
		{ scenename = "scenes/NamVet/Swears12.vcd" }  //Ah shit.
	],
	group_params = none
}

{
	name = "iMT_PlayerHelloNamVet",
	criteria =
	[
		[ "concept", "iMT_PlayerHello" ], [ "who", "NamVet" ]
	],
	responses =
	[
		{ scenename = "scenes/NamVet/ScenarioJoin02.vcd" }  //Hello!
	],
	group_params = none
}

{
	name = "iMT_PlayerIncapacitatedHurtNamVet",
	criteria =
	[
		[ "concept", "iMT_PlayerIncapacitatedHurt" ], [ "who", "NamVet" ]
	],
	responses =
	[
		{ scenename = "scenes/NamVet/HurtCritical03.vcd" }  //[pain noise - loud major pain]
		{ scenename = "scenes/NamVet/HurtCritical04.vcd" }  //[pain noise - loud major pain]
		{ scenename = "scenes/NamVet/HurtCritical08.vcd" }  //[pain noise - loud major pain]
		{ scenename = "scenes/NamVet/IncapacitatedInjury01.vcd" }  //[AHHHHH - terrified yell]
		{ scenename = "scenes/NamVet/IncapacitatedInjury02.vcd" }  //[AHHHHH - terrified yell]
		{ scenename = "scenes/NamVet/IncapacitatedInjury03.vcd" }  //[AHHHHH - terrified yell]
		{ scenename = "scenes/NamVet/IncapacitatedInjury04.vcd" }  //[AHHHHH - terrified yell]
		{ scenename = "scenes/NamVet/IncapacitatedInjury05.vcd" }  //[AHHHHH - terrified yell]
	],
	group_params = none
}

{
	name = "iMT_PlayerKillConfirmationNamVet",
	criteria =
	[
		[ "concept", "iMT_PlayerKilledZombie" ], [ "who", "NamVet" ]
	],
	responses =
	[
		{ scenename = "scenes/NamVet/KillConfirmation01.vcd" }  //Got 'em
		{ scenename = "scenes/NamVet/KillConfirmation02.vcd" }  //Got it
		{ scenename = "scenes/NamVet/KillConfirmation03.vcd" }  //He's dead
		{ scenename = "scenes/NamVet/KillConfirmation05.vcd" }  //Got 'em
		{ scenename = "scenes/NamVet/KillConfirmation06.vcd" }  //Got 'em
		{ scenename = "scenes/NamVet/KillConfirmation07.vcd" }  //Got 'em
		{ scenename = "scenes/NamVet/KillConfirmation08.vcd" }  //Got it
	],
	group_params = none
}

{
	name = "iMT_PlayerMeleeNamVet",
	criteria =
	[
		[ "concept", "iMT_PlayerMelee" ], [ "who", "NamVet" ]
	],
	responses =
	[
		{ scenename = "scenes/NamVet/Shoved01.vcd" }  //[Melee grunt]
		{ scenename = "scenes/NamVet/Shoved02.vcd" }  //[Melee grunt]
		{ scenename = "scenes/NamVet/Shoved03.vcd" }  //[Melee grunt]
		{ scenename = "scenes/NamVet/Shoved04.vcd" }  //[Melee grunt]
		{ scenename = "scenes/NamVet/Shoved05.vcd" }  //[Melee grunt]
	],
	group_params = none
}

{
	name = "iMT_PlayerMournBikerAliveNamVet",
	criteria =
	[
		[ "concept", "iMT_PlayerMourn" ], [ "who", "NamVet" ], [ "isbikeralive", 1 ], [ "subject", "Biker" ], [ "dist_from_subject", 0, 199 ]
	],
	responses = SurvivorMournBikerNamVet,
	group_params = none
}

{
	name = "iMT_PlayerMournBikerDeadNamVet",
	criteria =
	[
		[ "concept", "iMT_PlayerMourn" ], [ "who", "NamVet" ], [ "isbikeralive", 0 ], [ "disttobiker", 0, 199 ]
	],
	responses = SurvivorMournBikerNamVet,
	group_params = none
}

{
	name = "iMT_PlayerMournManagerAliveNamVet",
	criteria =
	[
		[ "concept", "iMT_PlayerMourn" ], [ "who", "NamVet" ], [ "ismanageralive", 1 ], [ "subject", "Manager" ], [ "dist_from_subject", 0, 199 ]
	],
	responses = SurvivorMournManagerNamVet,
	group_params = none
}

{
	name = "iMT_PlayerMournManagerDeadNamVet",
	criteria =
	[
		[ "concept", "iMT_PlayerMourn" ], [ "who", "NamVet" ], [ "ismanageralive", 0 ], [ "disttomanager", 0, 199 ]
	],
	responses = SurvivorMournManagerNamVet,
	group_params = none
}

{
	name = "iMT_PlayerMournTeenGirlAliveNamVet",
	criteria =
	[
		[ "concept", "iMT_PlayerMourn" ], [ "who", "NamVet" ], [ "isteengirlalive", 1 ], [ "subject", "TeenGirl" ], [ "dist_from_subject", 0, 199 ]
	],
	responses = SurvivorMournTeenGirlNamVet,
	group_params = none
}

{
	name = "iMT_PlayerMournTeenGirlDeadNamVet",
	criteria =
	[
		[ "concept", "iMT_PlayerMourn" ], [ "who", "NamVet" ], [ "isteengirlalive", 0 ], [ "disttoteengirl", 0, 199 ]
	],
	responses = SurvivorMournTeenGirlNamVet,
	group_params = none
}

{
	name = "iMT_PlayerNearExitNamVet",
	criteria =
	[
		[ "concept", "iMT_PlayerNearExit" ], [ "who", "NamVet" ]
	],
	responses =
	[
		{ scenename = "scenes/NamVet/FinaleAhead01.vcd" }  //This looks like it - we're almost out of here.
		{ scenename = "scenes/NamVet/FinaleAhead02.vcd" }  //We're almost out of here!
		{ scenename = "scenes/NamVet/FinaleAhead03.vcd" }  //Okay, people, we're almost there. Let's keep moving!
		{ scenename = "scenes/NamVet/FinaleAhead04.vcd" }  //Keep it together people. We're almost home free.
		{ scenename = "scenes/NamVet/SafeSpotAhead02.vcd", followup = RThen( "any", "iMT_PlayerNearExitReac", { from = "NamVet" }, 0.3 ) }  //There's a safe spot just ahead.
		{ scenename = "scenes/NamVet/SafeSpotAhead05.vcd", followup = RThen( "any", "iMT_PlayerNearExitReac", { from = "NamVet" }, 0.3 ) }  //There's a safe place up ahead.
		{ scenename = "scenes/NamVet/SafeSpotAhead07.vcd", followup = RThen( "any", "iMT_PlayerNearExitReac", { from = "NamVet" }, 0.3 ) }  //Safe house ahead!
		{ scenename = "scenes/NamVet/SafeSpotAhead08.vcd", followup = RThen( "any", "iMT_PlayerNearExitReac", { from = "NamVet" }, 0.3 ) }  //Safe house!
	],
	group_params = none
}

{
	name = "iMT_PlayerNearExitReacNamVet",
	criteria =
	[
		[ "concept", "iMT_PlayerNearExitReac" ], [ "who", "NamVet" ], [ "coughing", 0 ], [ "incapacitated", 0 ], [ "speaking", 0], [ "randomnum", 0, 10 ], [ IsTalk ], [ IsTalkNamVet ], [ IsWorldTalkNamVet ], [ IssuerClose ]
	],
	responses =
	[
		{ scenename = "scenes/NamVet/SafeSpotAheadReaction01.vcd" }  //Finally!
		{ scenename = "scenes/NamVet/SafeSpotAheadReaction02.vcd" }  //Thank God.
		{ scenename = "scenes/NamVet/SafeSpotAheadReaction03.vcd" }  //'Bout time!
		{ scenename = "scenes/NamVet/SafeSpotAheadReaction04.vcd" }  //Hallelujah!
		{ scenename = "scenes/NamVet/SafeSpotAheadReaction05.vcd" }  //Well it's about damn time.
		{ scenename = "scenes/NamVet/SafeSpotAheadReaction06.vcd" }  //I could use a damn break.
	],
	group_params = none
}

{
	name = "iMT_PlayerNiceShotNamVet",
	criteria =
	[
		[ "concept", "iMT_PlayerNiceShot" ], [ "who", "NamVet" ]
	],
	responses =
	[
		{ scenename = "scenes/NamVet/NiceShot01.vcd" }  //Nice shot!
		{ scenename = "scenes/NamVet/NiceShot02.vcd" }  //Damn, kid, that was a good shot.
		{ scenename = "scenes/NamVet/NiceShot03.vcd" }  //GodDAMN that was a nice shot.
		{ scenename = "scenes/NamVet/NiceShot04.vcd" }  //Nice shot!
		{ scenename = "scenes/NamVet/NiceShot05.vcd" }  //Damn, kid, that was a good shot.
		{ scenename = "scenes/NamVet/NiceShot06.vcd" }  //GodDAMN that was a nice shot.
		{ scenename = "scenes/NamVet/NiceShot07.vcd" }  //Good shot, kid.
		{ scenename = "scenes/NamVet/NiceShot08.vcd" }  //Good shot!
		{ scenename = "scenes/NamVet/NiceShot09.vcd" }  //Damn, now that was a shot!
		{ scenename = "scenes/NamVet/NiceShot13.vcd" }  //Nice shooting.
		{ scenename = "scenes/NamVet/NiceShot14.vcd" }  //Nice.
	],
	group_params = none
}

{
	name = "iMT_PlayerPainNoiseNamVet",
	criteria =
	[
		[ "concept", "iMT_PlayerPainNoise" ], [ "who", "NamVet" ]
	],
	responses =
	[
		{ scenename = "scenes/NamVet/HurtCritical01.vcd" }  //[pain noise - loud major pain]
		{ scenename = "scenes/NamVet/HurtCritical02.vcd" }  //[pain noise - loud major pain]
		{ scenename = "scenes/NamVet/HurtCritical05.vcd" }  //[pain noise - loud major pain]
		{ scenename = "scenes/NamVet/HurtCritical06.vcd" }  //[pain noise - loud major pain]
		{ scenename = "scenes/NamVet/HurtCritical07.vcd" }  //[pain noise - loud major pain]
		{ scenename = "scenes/NamVet/HurtCritical09.vcd" }  //[pain noise - loud major pain]
		{ scenename = "scenes/NamVet/HurtMajor01.vcd" }  //[pain noise - ahh]
		{ scenename = "scenes/NamVet/HurtMajor02.vcd" }  //[pain noise - huh]
		{ scenename = "scenes/NamVet/HurtMajor03.vcd" }  //[pain noise - oy]
		{ scenename = "scenes/NamVet/HurtMajor04.vcd" }  //[pain noise - ugh]
		{ scenename = "scenes/NamVet/HurtMajor05.vcd" }  //[pain noise - ugh]
		{ scenename = "scenes/NamVet/HurtMajor06.vcd" }  //[pain noise - ugh]
		{ scenename = "scenes/NamVet/HurtMajor07.vcd" }  //[pain noise - ugh]
		{ scenename = "scenes/NamVet/HurtMajor08.vcd" }  //[pain noise - oy]
		{ scenename = "scenes/NamVet/HurtMajor09.vcd" }  //[pain noise - ugh]
	],
	group_params = none
}

{
	name = "iMT_PlayerPouncedBikerNamVet",
	criteria =
	[
		[ "concept", "iMT_SurvivorWasPounced" ], [ "who", "NamVet" ], [ "subject", "Biker" ], [ "dist_from_subject", 0, 799 ]
	],
	responses =
	[
		{ scenename = "scenes/NamVet/HunterFrancisPounced01.vcd" }  //Hunter's got Francis!
		{ scenename = "scenes/NamVet/HunterFrancisPounced02.vcd" }  //Hunter pounced Francis!
		{ scenename = "scenes/NamVet/HunterFrancisPounced03.vcd" }  //A Hunter's on Francis!
	],
	group_params = none
}

{
	name = "iMT_PlayerPouncedManagerNamVet",
	criteria =
	[
		[ "concept", "iMT_SurvivorWasPounced" ], [ "who", "NamVet" ], [ "subject", "Manager" ], [ "dist_from_subject", 0, 799 ]
	],
	responses =
	[
		{ scenename = "scenes/NamVet/HunterLouisPounced01.vcd" }  //Hunter's got Louis!
		{ scenename = "scenes/NamVet/HunterLouisPounced02.vcd" }  //Hunter pounced Louis!
		{ scenename = "scenes/NamVet/HunterLouisPounced03.vcd" }  //A Hunter's on Louis!
	],
	group_params = none
}

{
	name = "iMT_PlayerPouncedTeenGirlNamVet",
	criteria =
	[
		[ "concept", "iMT_SurvivorWasPounced" ], [ "who", "NamVet" ], [ "subject", "TeenGirl" ], [ "dist_from_subject", 0, 799 ]
	],
	responses =
	[
		{ scenename = "scenes/NamVet/HunterZoeyPounced01.vcd" }  //Hunter's got Zoey!
		{ scenename = "scenes/NamVet/HunterZoeyPounced02.vcd" }  //Hunter pounced Zoey!
		{ scenename = "scenes/NamVet/HunterZoeyPounced03.vcd" }  //A Hunter's on Zoey!
	],
	group_params = none
}

{
	name = "iMT_PlayerReloadingNamVet",
	criteria =
	[
		[ "concept", "iMT_PlayerReloading" ], [ "who", "NamVet" ]
	],
	responses =
	[
		{ scenename = "scenes/NamVet/Reloading01.vcd" }  //Reloading
		{ scenename = "scenes/NamVet/Reloading02.vcd" }  //Reloading
		{ scenename = "scenes/NamVet/Reloading03.vcd" }  //Reloading
	],
	group_params = none
}

{
	name = "iMT_PlayerSuggestHealthNamVet",
	criteria =
	[
		[ "concept", "iMT_PlayerSuggestHealth" ], [ "who", "NamVet" ]
	],
	responses =
	[
		{ scenename = "scenes/NamVet/PlayerSuggestHealth01.vcd" }  //You should heal up.
	],
	group_params = none
}

{
	name = "iMT_PlayerSuggestHealthBikerNamVet",
	criteria =
	[
		[ "concept", "iMT_PlayerSuggestHealth" ], [ "who", "NamVet" ], [ "subject", "Biker" ], [ "dist_from_subject", 0, 199 ]
	],
	responses =
	[
		{ scenename = "scenes/NamVet/PlayerSuggestHealthFrancis01.vcd" }  //Francis, use your first aid kit.
		{ scenename = "scenes/NamVet/PlayerSuggestHealthFrancis02.vcd" }  //Francis, you should heal up.
		{ scenename = "scenes/NamVet/PlayerSuggestHealthFrancis03.vcd" }  //Heal up, Francis.
		{ scenename = "scenes/NamVet/PlayerSuggestHealthFrancis04.vcd" }  //Francis, heal up.
	],
	group_params = none
}

{
	name = "iMT_PlayerSuggestHealthManagerNamVet",
	criteria =
	[
		[ "concept", "iMT_PlayerSuggestHealth" ], [ "who", "NamVet" ], [ "subject", "Manager" ], [ "dist_from_subject", 0, 199 ]
	],
	responses =
	[
		{ scenename = "scenes/NamVet/PlayerSuggestHealthLouis01.vcd" }  //Louis, use your first aid kit.
		{ scenename = "scenes/NamVet/PlayerSuggestHealthLouis02.vcd" }  //Heal up, Louis.
	],
	group_params = none
}

{
	name = "iMT_PlayerSuggestHealthTeenGirlNamVet",
	criteria =
	[
		[ "concept", "iMT_PlayerSuggestHealth" ], [ "who", "NamVet" ], [ "subject", "TeenGirl" ], [ "dist_from_subject", 0, 199 ]
	],
	responses =
	[
		{ scenename = "scenes/NamVet/PlayerSuggestHealthZoey01.vcd" }  //Zoey, maybe you should heal.
		{ scenename = "scenes/NamVet/PlayerSuggestHealthZoey02.vcd" }  //Zoey, maybe heal up?
		{ scenename = "scenes/NamVet/PlayerSuggestHealthZoey03.vcd" }  //Might want to heal up, Zoey.
	],
	group_params = none
}

{
	name = "iMT_PlayerTeamKillNamVet",
	criteria =
	[
		[ "concept", "iMT_PlayerTeamKill" ], [ "who", "NamVet" ]
	],
	responses =
	[
		{ scenename = "scenes/NamVet/TeamKillAccident01.vcd" }  //Be careful!
		{ scenename = "scenes/NamVet/TeamKillAccident02.vcd" }  //Have you lost your mind?
		{ scenename = "scenes/NamVet/TeamKillAccident03.vcd" }  //What did you just do?
		{ scenename = "scenes/NamVet/TeamKillAccident04.vcd" }  //Watch it, watch it!
	],
	group_params = none
}

{
	name = "iMT_PlayerTransitionNamVet",
	criteria =
	[
		[ "concept", "iMT_PlayerTransition" ], [ "who", "NamVet" ]
	],
	responses =
	[
		{ scenename = "scenes/NamVet/PlayerTransitionClose01.vcd" }  //Jesus H Christ that was close.
		{ scenename = "scenes/NamVet/PlayerTransitionClose02.vcd" }  //This shit's gettin' old.
		{ scenename = "scenes/NamVet/PlayerTransitionClose03.vcd" }  //I've had about enough of this.
		{ scenename = "scenes/NamVet/PlayerTransitionClose04.vcd" }  //That was a little closer than I'da liked.
	],
	group_params = none
}

{
	name = "iMT_PlayerTransitionCloseNamVet",
	criteria =
	[
		[ "concept", "iMT_PlayerTransition" ], [ "who", "NamVet" ], [ "numberofteamdead", 1, null ]
	],
	responses =
	[
		{ scenename = "scenes/NamVet/TransitionClose01.vcd" }  //Well that didn't go so well.
		{ scenename = "scenes/NamVet/TransitionClose02.vcd" }  //We've done better.
		{ scenename = "scenes/NamVet/TransitionClose03.vcd" }  //Thank god that's over.
		{ scenename = "scenes/NamVet/TransitionClose04.vcd" }  //Thank god that's over.
	],
	group_params = none
}

{
	name = "iMT_PlayerTransitionSoloNamVet",
	criteria =
	[
		[ "concept", "iMT_PlayerTransition" ], [ "who", "NamVet" ], [ "numberofteamdead", 1, null ], [ "numberofteamalive", 1 ]
	],
	responses =
	[
		{ scenename = "scenes/NamVet/TransitionClose01.vcd" }  //Well that didn't go so well.
	],
	group_params = none
}

{
	name = "iMT_PlayerWitchChasingNamVet",
	criteria =
	[
		[ "concept", "iMT_PlayerWitchChasing" ], [ "who", "NamVet" ]
	],
	responses =
	[
		{ scenename = "scenes/NamVet/GrabbedBySmoker01b.vcd" }  //No, No, NO, NOOOOOOO!!!!!!!!!
		{ scenename = "scenes/NamVet/IncapacitatedInjury03.vcd" }  //[AHHHHH - terrified yell]
	],
	group_params = none
}

{
	name = "iMT_SurvivorCaughtVomitNamVet",
	criteria =
	[
		[ "concept", "iMT_PlayerVomitInFace" ], [ "who", "NamVet" ]
	],
	responses =
	[
		{ scenename = "scenes/NamVet/ReactionBoomerVomit01.vcd" }
		{ scenename = "scenes/NamVet/ReactionBoomerVomit02.vcd" }
		{ scenename = "scenes/NamVet/ReactionBoomerVomit03.vcd" }
		{ scenename = "scenes/NamVet/ReactionDisgusted01.vcd" }  //Ewwww...
		{ scenename = "scenes/NamVet/ReactionDisgusted02.vcd" }  //Blech...
		{ scenename = "scenes/NamVet/ReactionDisgusted03.vcd" }  //Ehhhh
		{ scenename = "scenes/NamVet/ReactionDisgusted04.vcd" }  //Oh shit.
		{ scenename = "scenes/NamVet/ReactionDisgusted05.vcd" }  //Yech
		{ scenename = "scenes/NamVet/ReactionDisgusted06.vcd" }  //Echh
		{ scenename = "scenes/NamVet/ReactionDisgusted07.vcd" }  //Echh
		{ scenename = "scenes/NamVet/ReactionDisgusted08.vcd" }  //Yech
	],
	group_params = none
}

//--------------------------------------------------------------------------------------------------
// Character-specific
//--------------------------------------------------------------------------------------------------

{
	name = "iMT_10MilesNamVet",
	criteria =
	[
		[ "concept", "iMT_10Miles" ], [ "who", "NamVet" ]
	],
	responses =
	[
		{ scenename = "scenes/NamVet/C6DLC3CommunityLines04.vcd" }  //Back in my day, we walked 10 miles through a blizzard in bare feet to kill zombies.
	],
	group_params = none
}

{
	name = "iMT_AllAboardNamVet",
	criteria =
	[
		[ "concept", "iMT_AllAboard" ], [ "who", "NamVet" ]
	],
	responses =
	[
		{ scenename = "scenes/NamVet/WorldFarmHouse0311.vcd" }  //All aboard!
	],
	group_params = none
}

{
	name = "iMT_BigMouthNamVet",
	criteria =
	[
		[ "concept", "iMT_BigMouth" ], [ "who", "NamVet" ]
	],
	responses =
	[
		{ scenename = "scenes/NamVet/ReviveFriendB13.vcd" }  //Looks like yer big mouth still works.
	],
	group_params = none
}

{
	name = "iMT_ColdNamVet",
	criteria =
	[
		[ "concept", "iMT_Cold" ], [ "who", "NamVet" ]
	],
	responses =
	[
		{ scenename = "scenes/NamVet/C6DLC3CommunityLines02.vcd" }  //That's what you get for not wearing a hat.
		{ scenename = "scenes/NamVet/C6DLC3CommunityLines05.vcd" }  //Ehh... is it too cold for ya cry babies?
	],
	group_params = none
}

{
	name = "iMT_FamilyNamVet",
	criteria =
	[
		[ "concept", "iMT_Family" ], [ "who", "NamVet" ]
	],
	responses =
	[
		{ scenename = "scenes/NamVet/C6DLC3JumpingOffBridge12.vcd" }  //You guys are the only family I got! Take care of each other!
	],
	group_params = none
}

{
	name = "iMT_FirstStepNamVet",
	criteria =
	[
		[ "concept", "iMT_FirstStep" ], [ "who", "NamVet" ]
	],
	responses =
	[
		{ scenename = "scenes/NamVet/WorldHospital0423.vcd" }  //That first step'll kill ya.
		{ scenename = "scenes/NamVet/WorldHospital0424.vcd" }  //Watch out that first step'll kill ya.
	],
	group_params = none
}

{
	name = "iMT_GoodEnoughNamVet",
	criteria =
	[
		[ "concept", "iMT_GoodEnough" ], [ "who", "NamVet" ]
	],
	responses =
	[
		{ scenename = "scenes/NamVet/C6DLC3MovieLine15.vcd" }  //I gotta admit... this ain't how I pictured it. Good enough.
	],
	group_params = none
}

{
	name = "iMT_GoodRunNamVet",
	criteria =
	[
		[ "concept", "iMT_GoodRun" ], [ "who", "NamVet" ]
	],
	responses =
	[
		{ scenename = "scenes/NamVet/C6DLC3MovieLine16.vcd" }  //I had a good run. Knowing they're safe, I wouldn't have changed a thing.
		{ scenename = "scenes/NamVet/C6DLC3MovieLine17.vcd" }  //I had a good run. I wouldn't have changed a thing.
	],
	group_params = none
}

{
	name = "iMT_HallelujahNamVet",
	criteria =
	[
		[ "concept", "iMT_Hallelujah" ], [ "who", "NamVet" ]
	],
	responses =
	[
		{ scenename = "scenes/NamVet/SafeSpotAheadReaction04.vcd" }  //Hallelujah!
	],
	group_params = none
}

{
	name = "iMT_HomeNamVet",
	criteria =
	[
		[ "concept", "iMT_Home" ], [ "who", "NamVet" ]
	],
	responses =
	[
		{ scenename = "scenes/NamVet/WorldFarmHouse0102.vcd" }  //Francis, this look like home to you?
	],
	group_params = none
}

{
	name = "iMT_JobDoneNamVet",
	criteria =
	[
		[ "concept", "iMT_JobDone" ], [ "who", "NamVet" ]
	],
	responses =
	[
		{ scenename = "scenes/NamVet/C6DLC3MovieLine01.vcd" }  //My job's done. Have at me you bastards!
		{ scenename = "scenes/NamVet/C6DLC3MovieLine02.vcd" }  //My job's done. Let's see what you got, you big dumb sons of bitches.
	],
	group_params = none
}

{
	name = "iMT_KnowingLouisNamVet",
	criteria =
	[
		[ "concept", "iMT_KnowingLouis" ], [ "who", "NamVet" ]
	],
	responses =
	[
		{ scenename = "scenes/NamVet/InsideSafeRoom03.vcd" }  //How well do you really know Louis?
	],
	group_params = none
}

{
	name = "iMT_LastFightNamVet",
	criteria =
	[
		[ "concept", "iMT_LastFight" ], [ "who", "NamVet" ]
	],
	responses =
	[
		{ scenename = "scenes/NamVet/C6DLC3MovieLine04.vcd" }  //You monkeys ain't gonna spoil this.
		{ scenename = "scenes/NamVet/C6DLC3MovieLine05.vcd" }  //You shoulda brought more tanks with you.
		{ scenename = "scenes/NamVet/C6DLC3MovieLine08.vcd" }  //You're too late.
		{ scenename = "scenes/NamVet/C6DLC3MovieLine19.vcd" }  //That all you brought?
	],
	group_params = none
}

{
	name = "iMT_LastFight%NamVet",
	criteria =
	[
		[ "concept", "iMT_LastFight" ], [ "who", "NamVet" ], [ "randomnum", 0, 5 ]
	],
	responses =
	[
		{ scenename = "scenes/NamVet/C6DLC3MovieLine10.vcd" }  //I'll see peace back on Earth... if I gotta murder every one of you bastards... with my bare goddamn hands.
	],
	group_params = none
}

{
	name = "iMT_LonelyNamVet",
	criteria =
	[
		[ "concept", "iMT_Lonely" ], [ "who", "NamVet" ]
	],
	responses =
	[
		{ scenename = "scenes/NamVet/ToTheRescueThanks03.vcd" }  //Thanks, I was getting lonely.
	],
	group_params = none
}

{
	name = "iMT_MadNamVet",
	criteria =
	[
		[ "concept", "iMT_Mad" ], [ "who", "NamVet" ]
	],
	responses =
	[
		{ scenename = "scenes/NamVet/C6DLC3Intro26.vcd" }  //Zoey, you still mad?
	],
	group_params = none
}

{
	name = "iMT_NervousHummingNamVet",
	criteria =
	[
		[ "concept", "iMT_NervousHumming" ], [ "who", "NamVet" ]
	],
	responses =
	[
		{ scenename = "scenes/NamVet/NervousHumming01.vcd" }  //[Nervous Humming]
	],
	group_params = none
}

{
	name = "iMT_PhoneNamVet",
	criteria =
	[
		[ "concept", "iMT_Phone" ], [ "who", "NamVet" ]
	],
	responses =
	[
		{ scenename = "scenes/NamVet/C6DLC3CommunityLines06.vcd" }  //No one's going to be answering that phone.
	],
	group_params = none
}

{
	name = "iMT_ShoeLeatherNamVet",
	criteria =
	[
		[ "concept", "iMT_ShoeLeather" ], [ "who", "NamVet" ]
	],
	responses =
	[
		{ scenename = "scenes/NamVet/C6DLC3MovieLine20.vcd" }  //If I'd known how many of you sonsabitches there were when we started out, guess I woulda saved the shoe leather and fought you there.
	],
	group_params = none
}

{
	name = "iMT_ShortLaughNamVet",
	criteria =
	[
		[ "concept", "iMT_ShortLaugh" ], [ "who", "NamVet" ], [ "coughing", 0 ], [ "incapacitated", 0 ], [ "speaking", 0], [ IsTalk ], [ IsTalkNamVet ], [ IsWorldTalkNamVet ], [ IssuerClose ]
	],
	responses =
	[
		{ scenename = "scenes/NamVet/Laughter10.vcd" }  //<Short laugh>
		{ scenename = "scenes/NamVet/Laughter14.vcd" }  //<Short laugh>
	],
	group_params = none
}

{
	name = "iMT_SingingNamVet",
	criteria =
	[
		[ "concept", "iMT_Singing" ], [ "who", "NamVet" ]
	],
	responses =
	[
		{ scenename = "scenes/NamVet/NervousWhislte01.vcd" }  //[Nervous Whistle]
	],
	group_params = none
}

{
	name = "iMT_StinkNamVet",
	criteria =
	[
		[ "concept", "iMT_Stink" ], [ "who", "NamVet" ]
	],
	responses =
	[
		{ scenename = "scenes/NamVet/C6DLC3InTankTrainCar03.vcd" }  //Stinks like shit in here.
	],
	group_params = none
}

{
	name = "iMT_Stink%NamVet",
	criteria =
	[
		[ "concept", "iMT_Stink" ], [ "who", "NamVet" ], [ "randomnum", 0, 50 ]
	],
	responses =
	[
		{ scenename = "scenes/NamVet/WorldHospital0316.vcd", followup = RThen( "Biker", "iMT_StinkReac", { from = "NamVet" }, 0.3 ) }  //Francis, is that you or the sewer?
	],
	group_params = none
}

{
	name = "iMT_WoodsNamVet",
	criteria =
	[
		[ "concept", "iMT_Woods" ], [ "who", "NamVet" ]
	],
	responses =
	[
		{ scenename = "scenes/NamVet/WorldSmallTown0101.vcd" }  //These woods look thicker 'n boomer shit. Nobody wander off.
	],
	group_params = none
}

//--------------------------------------------------------------------------------------------------
// Overrides
//--------------------------------------------------------------------------------------------------

{
	name = "iMT_PlayerAnswerLostCallNamVet",
	criteria =
	[
		[ "concept", "PlayerAnswerLostCall" ], [ "who", "NamVet" ], [ "coughing", 0 ], [ "numberofteamalive", 4, null ], [ "numberofteamdead", 0 ], [ "disttoclosestsurvivor", 0, 499 ], [ "randomnum", 0, 10 ], [ IsTalk ], [ IsTalkNamVet ], [ IsWorldTalkNamVet ]
	],
	responses =
	[
		{ scenename = "scenes/NamVet/ScenarioJoinLast01.vcd" }  //We're all here.
	],
	group_params = none
}

{
	name = "iMT_PlayerAskReadyNamVet",
	criteria =
	[
		[ "concept", "PlayerAskReady" ], [ "who", "NamVet" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkNamVet ], [ IsWorldTalkNamVet ]
	],
	responses =
	[
		{ scenename = "scenes/NamVet/AskReady01.vcd" }  //Ready?
		{ scenename = "scenes/NamVet/AskReady02.vcd" }  //Ready?
		{ scenename = "scenes/NamVet/AskReady03.vcd" }  //Ready for this?
		{ scenename = "scenes/NamVet/AskReady04.vcd" }  //Everyone locked and loaded?
		{ scenename = "scenes/NamVet/AskReady05.vcd" }  //Ready for this?
		{ scenename = "scenes/NamVet/AskReady09.vcd" }  //You people ready?
	],
	group_params = none
}

{
	name = "iMT_PlayerHeardBoomerNamVet",
	criteria =
	[
		[ "concept", "PlayerHeardBoomer" ], [ "who", "NamVet" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkNamVet ], [ IsWorldTalkNamVet ]
	],
	responses =
	[
		{ scenename = "scenes/NamVet/HeardBoomer01.vcd" }  //I hear a boomer out there.
		{ scenename = "scenes/NamVet/HeardBoomer02.vcd" }  //There's a Boomer around here.
		{ scenename = "scenes/NamVet/HeardBoomer03.vcd" }  //Careful, Boomer.
		{ scenename = "scenes/NamVet/HeardBoomer04.vcd" }  //Watch it, Boomer in the vacinity.
		{ scenename = "scenes/NamVet/HeardBoomer05.vcd" }  //Boomer around here.
		{ scenename = "scenes/NamVet/HeardBoomer06.vcd" }  //Boomer nearby.
		{ scenename = "scenes/NamVet/HeardBoomer07.vcd" }  //There's a Boomer trackin' us.
		{ scenename = "scenes/NamVet/HeardBoomer08.vcd" }  //Boomer closeby.
		{ scenename = "scenes/NamVet/HeardBoomer09.vcd" }  //Boomer nearby.
		{ scenename = "scenes/NamVet/HeardBoomer10.vcd" }  //Christ, there's a Boomer around here.
		{ scenename = "scenes/NamVet/HeardBoomer11.vcd" }  //Dammit, Boomer nearby.
	],
	group_params = none
}

{
	name = "iMT_PlayerHeardHunterNamVet",
	criteria =
	[
		[ "concept", "PlayerHeardHunter" ], [ "who", "NamVet" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkNamVet ], [ IsWorldTalkNamVet ]
	],
	responses =
	[
		{ scenename = "scenes/NamVet/HeardHunter01.vcd" }  //There's a Hunter around here.
		{ scenename = "scenes/NamVet/HeardHunter02.vcd" }  //Careful, people, there's a Hunter nearby.
		{ scenename = "scenes/NamVet/HeardHunter03.vcd" }  //There's a Hunter spookin' around out there.
		{ scenename = "scenes/NamVet/HeardHunter04.vcd" }  //There's a Hunter out there.
		{ scenename = "scenes/NamVet/HeardHunter05.vcd" }  //Careful, Hunter around here.
		{ scenename = "scenes/NamVet/HeardHunter06.vcd" }  //Hunter out there.
		{ scenename = "scenes/NamVet/HeardHunter08.vcd" }  //Watch your back - Hunter.
		{ scenename = "scenes/NamVet/HeardHunter09.vcd" }  //Watch your back, there's a Hunter out there.
		{ scenename = "scenes/NamVet/HeardHunter10.vcd" }  //I think I saw a goddamn Hunter.
	],
	group_params = none
}

{
	name = "iMT_PlayerHeardSmokerNamVet",
	criteria =
	[
		[ "concept", "PlayerHeardSmoker" ], [ "who", "NamVet" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkNamVet ], [ IsWorldTalkNamVet ]
	],
	responses =
	[
		{ scenename = "scenes/NamVet/HeardSmoker01.vcd" }  //Smoker, right around here.
		{ scenename = "scenes/NamVet/HeardSmoker02.vcd" }  //There's a Smoker nearby.
		{ scenename = "scenes/NamVet/HeardSmoker03.vcd" }  //We got a Smoker around here.
		{ scenename = "scenes/NamVet/HeardSmoker04.vcd" }  //Heads up, Smoker somewhere around here.
		{ scenename = "scenes/NamVet/HeardSmoker05.vcd" }  //Smoker right around here someplace.
		{ scenename = "scenes/NamVet/HeardSmoker06.vcd" }  //Smoker. And it's close.
		{ scenename = "scenes/NamVet/HeardSmoker07.vcd" }  //There's a Smoker.
	],
	group_params = none
}

{
	name = "iMT_PlayerHeardWitchNamVet",
	criteria =
	[
		[ "concept", "PlayerHeardWitch" ], [ "who", "NamVet" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkNamVet ], [ IsWorldTalkNamVet ]
	],
	responses =
	[
		{ scenename = "scenes/NamVet/HeardWitch01.vcd" }  //Hear that, that's a Witch.
		{ scenename = "scenes/NamVet/HeardWitch02.vcd" }  //Witch around here.
		{ scenename = "scenes/NamVet/HeardWitch03.vcd" }  //Shit, Witch.
		{ scenename = "scenes/NamVet/HeardWitch04.vcd" }  //Quiet, there's a Witch around here.
		{ scenename = "scenes/NamVet/HeardWitch05.vcd" }  //Shhh, Witch near here.
	],
	group_params = none
}

{
	name = "iMT_PlayerHurrahNamVet",
	criteria =
	[
		[ "concept", "PlayerHurrah" ], [ "who", "NamVet" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkNamVet ], [ IsWorldTalkNamVet ]
	],
	responses =
	[
		{ scenename = "scenes/NamVet/Hurrah02.vcd" }  //We're doing pretty goddamn good. Don't let it go to your head.
		{ scenename = "scenes/NamVet/Hurrah03.vcd", followup = RThen( "any", "HurrahAlso", null, 0.3 ) }  //GREAT JOB, PEOPLE!
		{ scenename = "scenes/NamVet/Hurrah05.vcd" }  //We're going to be okay.
		{ scenename = "scenes/NamVet/Hurrah20.vcd", followup = RThen( "any", "HurrahAlso", null, 0.3 ) }  //You people are gettin' good.
	],
	group_params = none
}

{
	name = "iMT_PlayerLaughNamVet",
	criteria =
	[
		[ "concept", "PlayerLaugh" ], [ "who", "NamVet" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkNamVet ], [ IsWorldTalkNamVet ]
	],
	responses =
	[
		{ scenename = "scenes/NamVet/Laughter04.vcd" }  //<Hearty laugh>
		{ scenename = "scenes/NamVet/Laughter09.vcd" }  //<Short laugh>
		{ scenename = "scenes/NamVet/Laughter10.vcd" }  //<Short laugh>
		{ scenename = "scenes/NamVet/Laughter11.vcd" }  //<Short laugh>
		{ scenename = "scenes/NamVet/Laughter14.vcd" }  //<Short laugh>
		{ scenename = "scenes/NamVet/ReactionPositive05.vcd" }  //[chuckles and giggles]
	],
	group_params = none
}

{
	name = "iMT_PlayerLaughAloneNamVet",
	criteria =
	[
		[ "concept", "PlayerLaugh" ], [ "who", "NamVet" ], [ "coughing", 0 ], [ "numberofteamalive", 1 ], [ "onthirdstrike", 1 ], [ IsTalk ], [ IsTalkNamVet ], [ IsWorldTalkNamVet ]
	],
	responses =
	[
		{ scenename = "scenes/NamVet/Laughter02.vcd" }  //<Nervous laugh>
		{ scenename = "scenes/NamVet/Laughter05.vcd" }  //<Nervous laugh>
		{ scenename = "scenes/NamVet/Laughter06.vcd" }  //<Short laugh>
		{ scenename = "scenes/NamVet/Laughter08.vcd" }  //<Short laugh>
	],
	group_params = none
}

{
	name = "iMT_PlayerNegativeNamVet",
	criteria =
	[
		[ "concept", "PlayerNegative" ], [ "who", "NamVet" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkNamVet ], [ IsWorldTalkNamVet ]
	],
	responses =
	[
		{ scenename = "scenes/NamVet/ReactionNegative07.vcd" }  //God dammit
		{ scenename = "scenes/NamVet/ReactionNegative09.vcd" }  //Son of a bitch
		{ scenename = "scenes/NamVet/ReactionNegative10.vcd" }  //Dammit
		{ scenename = "scenes/NamVet/SwearCoupdeGrace02.vcd" }  //Go to hell
		{ scenename = "scenes/NamVet/Swears03.vcd" }  //Son of a bitch.
		{ scenename = "scenes/NamVet/Swears04.vcd" }  //Bull-frickin-horseshit.
		{ scenename = "scenes/NamVet/Swears05.vcd" }  //Mother. Humper.
		{ scenename = "scenes/NamVet/Swears07.vcd" }  //Ah hell.
		{ scenename = "scenes/NamVet/Swears08.vcd" }  //Dammit.
		{ scenename = "scenes/NamVet/Swears09.vcd" }  //God DAMMIT.
		{ scenename = "scenes/NamVet/Swears12.vcd" }  //Ah shit.
		{ scenename = "scenes/NamVet/Swears16.vcd" }  //Ah shit.
		{ scenename = "scenes/NamVet/Swears19.vcd" }  //What a crock a' shit...
	],
	group_params = none
}

{
	name = "iMT_PlayerRelaxedSighNamVet",
	criteria =
	[
		[ "concept", "RelaxedSigh" ], [ "who", "NamVet" ], [ "speaking", 1 ]
	],
	responses =
	[
		{ scenename = "" }
	],
	group_params = none
}

{
	name = "iMT_ResponseSoftDispleasureSwearNamVet",
	criteria =
	[
		[ "concept", "ResponseSoftDispleasureSwear" ], [ "who", "NamVet" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkNamVet ], [ IsWorldTalkNamVet ]
	],
	responses =
	[
		{ scenename = "scenes/NamVet/ReactionApprehensive01.vcd" }  //I have a bad feeling about this.
		{ scenename = "scenes/NamVet/ReactionApprehensive04.vcd" }  //I do not like this one bit.
		{ scenename = "scenes/NamVet/ReactionNegative01.vcd" }  //Uh oh
		{ scenename = "scenes/NamVet/ReactionNegative02.vcd" }  //Christ
		{ scenename = "scenes/NamVet/ReactionNegative03.vcd" }  //Gee-zus
		{ scenename = "scenes/NamVet/ReactionNegative04.vcd" }  //[Frustration sound]
		{ scenename = "scenes/NamVet/ReactionNegative12.vcd" }  //[Frustration sound]
		{ scenename = "scenes/NamVet/Swears10.vcd" }  //Mother of mercy.
		{ scenename = "scenes/NamVet/ViolenceAwe01.vcd" }  //Jee-zus...
		{ scenename = "scenes/NamVet/ViolenceAwe02.vcd" }  //Holy crap.
		{ scenename = "scenes/NamVet/ViolenceAwe07.vcd" }  //Holy Mother of God...
	],
	group_params = none
}

{
	name = "iMT_SurvivorAskForHealthNamVet",
	criteria =
	[
		[ "concept", "AskForHealth2" ], [ "who", "NamVet" ]
	],
	responses =
	[
		{ scenename = "scenes/NamVet/GoingToDieAskForHeal01.vcd" }  //Anyone have some first aid? I ain't feelin' right.
		{ scenename = "scenes/NamVet/GoingToDieAskForHeal02.vcd" }  //Someone gonna heal the old guy about to die?
		{ scenename = "scenes/NamVet/GoingToDieAskForHeal03.vcd" }  //Sure could use some patchin' up.
		{ scenename = "scenes/NamVet/GoingToDieAskForHeal04.vcd" }  //Anyone spare a med kit?
	],
	group_params = none
}

{
	name = "iMT_SurvivorAskForHealthBikerNamVet",
	criteria =
	[
		[ "concept", "AskForHealth2" ], [ "who", "NamVet" ], [ "onthirdstrike", 0 ], [ "subject", "Biker" ], [ "dist_from_subject", 0, 399 ]
	],
	responses =
	[
		{ scenename = "scenes/NamVet/PlayerSuggestHealthSpecific01.vcd" }  //Francis, buddy, you gonna use that health kit?
	],
	group_params = none
}

{
	name = "iMT_SurvivorAskForHealthManagerNamVet",
	criteria =
	[
		[ "concept", "AskForHealth2" ], [ "who", "NamVet" ], [ "onthirdstrike", 0 ], [ "subject", "Manager" ], [ "dist_from_subject", 0, 399 ]
	],
	responses =
	[
		{ scenename = "scenes/NamVet/PlayerSuggestHealthSpecific03.vcd" }  //Louis, mind givin' an old man your health kit?
	],
	group_params = none
}

{
	name = "iMT_SurvivorAskForHealthTeenGirlNamVet",
	criteria =
	[
		[ "concept", "AskForHealth2" ], [ "who", "NamVet" ], [ "onthirdstrike", 0 ], [ "subject", "TeenGirl" ], [ "dist_from_subject", 0, 399 ]
	],
	responses =
	[
		{ scenename = "scenes/NamVet/PlayerSuggestHealthSpecific02.vcd" }  //Zoey, can you spare me a health kit?
	],
	group_params = none
}

{
	name = "iMT_SurvivorCoughingDeathNamVet",
	criteria =
	[
		[ "concept", "PlayerDeath" ], [ "who", "NamVet" ], [ "coughing", 1 ], [ IsTalk ], [ IsTalkNamVet ], [ IsWorldTalkNamVet ]
	],
	responses = SurvivorCoughingNamVet,
	group_params = none
}

{
	name = "iMT_SurvivorDeathNamVet",
	criteria =
	[
		[ "concept", "PlayerDeath" ], [ "who", "NamVet" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkNamVet ], [ IsWorldTalkNamVet ]
	],
	responses =
	[
		{ scenename = "scenes/NamVet/DeathScream01.vcd" }  //[Loud painful death scream]
		{ scenename = "scenes/NamVet/DeathScream02.vcd" }  //[Death rattle]
		{ scenename = "scenes/NamVet/DeathScream03.vcd" }  //[Loud painful death scream]
		{ scenename = "scenes/NamVet/DeathScream04.vcd" }  //[Loud painful death scream]
		{ scenename = "scenes/NamVet/DeathScream05.vcd" }  //[Short quick death scream]
		{ scenename = "scenes/NamVet/DeathScream06.vcd" }  //[Short quick death scream]
		{ scenename = "scenes/NamVet/DeathScream07.vcd" }  //[Death rattle]
		{ scenename = "scenes/NamVet/DeathScream08.vcd" }  //[Death rattle]
	],
	group_params = none
}

{
	name = "iMT_SurvivorSpottedAmmoNamVet",
	criteria =
	[
		[ "concept", "PlayerSpotAmmo" ], [ "who", "NamVet" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkNamVet ], [ IsWorldTalkNamVet ]
	],
	responses =
	[
		{ scenename = "scenes/NamVet/SpotAmmo01.vcd" }  //Ammo here!
	],
	group_params = none
}

{
	name = "iMT_SurvivorSpottedBoomerNamVet",
	criteria =
	[
		[ "concept", "PlayerWarnBoomer" ], [ "who", "NamVet" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkNamVet ], [ IsWorldTalkNamVet ]
	],
	responses =
	[
		{ scenename = "scenes/NamVet/WarnBoomer01.vcd" }  //BOOMER!
		{ scenename = "scenes/NamVet/WarnBoomer02.vcd" }  //BOOMER!
		{ scenename = "scenes/NamVet/WarnBoomer03.vcd" }  //BOOMER!
	],
	group_params = none
}

{
	name = "iMT_SurvivorSpottedChargerNamVet",
	criteria =
	[
		[ "concept", "PlayerWarnCharger" ], [ "who", "NamVet" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkNamVet ], [ IsWorldTalkNamVet ]
	],
	responses =
	[
		{ scenename = "scenes/NamVet/C6DLC3Creatures01.vcd" }  //CHARGER!
		{ scenename = "scenes/NamVet/C6DLC3Creatures02.vcd" }  //CHARGER!
		{ scenename = "scenes/NamVet/C6DLC3Creatures03.vcd" }  //CHARGER!
	],
	group_params = none
}

{
	name = "iMT_SurvivorSpottedHunterNamVet",
	criteria =
	[
		[ "concept", "PlayerWarnHunter" ], [ "who", "NamVet" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkNamVet ], [ IsWorldTalkNamVet ]
	],
	responses =
	[
		{ scenename = "scenes/NamVet/WarnHunter01.vcd" }  //HUNTER!
		{ scenename = "scenes/NamVet/WarnHunter02.vcd" }  //HUNTER!
		{ scenename = "scenes/NamVet/WarnHunter03.vcd" }  //HUNTER!
	],
	group_params = none
}

{
	name = "iMT_SurvivorSpottedInfectedNamVet",
	criteria =
	[
		[ "concept", "PlayerIncoming" ], [ "who", "NamVet" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkNamVet ], [ IsWorldTalkNamVet ]
	],
	responses =
	[
		{ scenename = "scenes/NamVet/Incoming01.vcd" }  //Here they come!
		{ scenename = "scenes/NamVet/Incoming03.vcd" }  //INCOMING!
		{ scenename = "scenes/NamVet/Incoming05.vcd" }  //HERE THEY COME!
		{ scenename = "scenes/NamVet/Incoming07.vcd" }  //INCOMING!
	],
	group_params = none
}

{
	name = "iMT_SurvivorSpottedInfected%NamVet",
	criteria =
	[
		[ "concept", "PlayerIncoming" ], [ "who", "NamVet" ], [ "coughing", 0 ], [ "randomnum", 0, 5 ], [ IsTalk ], [ IsTalkNamVet ], [ IsWorldTalkNamVet ]
	],
	responses =
	[
		{ scenename = "scenes/NamVet/Incoming04.vcd" }  //Bookoo crazies inbound!
	],
	group_params = none
}

{
	name = "iMT_SurvivorSpottedJockeyNamVet",
	criteria =
	[
		[ "concept", "PlayerWarnJockey" ], [ "who", "NamVet" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkNamVet ], [ IsWorldTalkNamVet ]
	],
	responses =
	[
		{ scenename = "scenes/NamVet/C6DLC3Creatures07.vcd" }  //Jockey!
		{ scenename = "scenes/NamVet/C6DLC3Creatures08.vcd" }  //Jockey!
		{ scenename = "scenes/NamVet/C6DLC3Creatures09.vcd" }  //Jockey!
	],
	group_params = none
}

{
	name = "iMT_SurvivorSpottedSmokerNamVet",
	criteria =
	[
		[ "concept", "PlayerWarnSmoker" ], [ "who", "NamVet" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkNamVet ], [ IsWorldTalkNamVet ]
	],
	responses =
	[
		{ scenename = "scenes/NamVet/WarnSmoker01.vcd" }  //SMOKER!
		{ scenename = "scenes/NamVet/WarnSmoker02.vcd" }  //SMOKER!
		{ scenename = "scenes/NamVet/WarnSmoker03.vcd" }  //SMOKER!
		{ scenename = "scenes/NamVet/WarnSmoker04.vcd" }  //SMOKER!
	],
	group_params = none
}

{
	name = "iMT_SurvivorSpottedSpitterNamVet",
	criteria =
	[
		[ "concept", "PlayerWarnSpitter" ], [ "who", "NamVet" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkNamVet ], [ IsWorldTalkNamVet ]
	],
	responses =
	[
		{ scenename = "scenes/NamVet/C6DLC3Creatures04.vcd" }  //Spitter!
		{ scenename = "scenes/NamVet/C6DLC3Creatures05.vcd" }  //Spitter!
		{ scenename = "scenes/NamVet/C6DLC3Creatures06.vcd" }  //Spitter!
	],
	group_params = none
}

{
	name = "iMT_SurvivorSpottedTankNamVet",
	criteria =
	[
		[ "concept", "PlayerWarnTank" ], [ "who", "NamVet" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkNamVet ], [ IsWorldTalkNamVet ]
	],
	responses =
	[
		{ scenename = "scenes/NamVet/WarnTank01.vcd" }  //TANK!
		{ scenename = "scenes/NamVet/WarnTank02.vcd" }  //TANK!
		{ scenename = "scenes/NamVet/WarnTank03.vcd" }  //TANK!
	],
	group_params = none
}

{
	name = "iMT_SurvivorSpottedWeaponsNamVet",
	criteria =
	[
		[ "concept", "PlayerSpotOtherWeapon" ], [ "who", "NamVet" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkNamVet ], [ IsWorldTalkNamVet ]
	],
	responses =
	[
		{ scenename = "scenes/NamVet/SpotWeapons01.vcd" }  //Weapons here!
		{ scenename = "scenes/NamVet/SpotWeapons02.vcd" }  //Weapon over here!
		{ scenename = "scenes/NamVet/SpotWeapons03.vcd" }  //Got a weapon here!
	],
	group_params = none
}

{
	name = "iMT_SurvivorSpottedWitchNamVet",
	criteria =
	[
		[ "concept", "PlayerWarnWitch" ], [ "who", "NamVet" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkNamVet ], [ IsWorldTalkNamVet ]
	],
	responses =
	[
		{ scenename = "scenes/NamVet/WarnWitch01.vcd" }  //WITCH!
		{ scenename = "scenes/NamVet/WarnWitch02.vcd" }  //WITCH!
		{ scenename = "scenes/NamVet/WarnWitch03.vcd" }  //WITCH!
		{ scenename = "scenes/NamVet/WarnWitch04.vcd" }  //WITCH!
	],
	group_params = none
}

{
	name = "iMT_SurvivorTauntResponseNamVet",
	criteria =
	[
		[ "concept", "PlayerTaunt" ], [ "who", "NamVet" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkNamVet ], [ IsWorldTalkNamVet ]
	],
	responses =
	[
		{ scenename = "scenes/NamVet/ReactionPositive07.vcd" }  //[chuckles and giggles]
		{ scenename = "scenes/NamVet/ReactionPositive08.vcd" }  //[chuckles and giggles]
		{ scenename = "scenes/NamVet/Taunt01.vcd" }  //[loud, evil laugh]
		{ scenename = "scenes/NamVet/Taunt02.vcd" }  //[loud, evil laugh]
		{ scenename = "scenes/NamVet/Taunt07.vcd" }  //[loud, evil laugh]
		{ scenename = "scenes/NamVet/Taunt08.vcd" }  //[loud, evil laugh]
		{ scenename = "scenes/NamVet/Taunt09.vcd" }  //[loud, evil laugh]
	],
	group_params = none
}

{
	name = "iMT_SurvivorVocalizeBackUpNamVet",
	criteria =
	[
		[ "concept", "PlayerBackUp" ], [ "who", "NamVet" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkNamVet ], [ IsWorldTalkNamVet ]
	],
	responses =
	[
		{ scenename = "scenes/NamVet/BackUp01.vcd" }  //Back up!
		{ scenename = "scenes/NamVet/BackUp02.vcd" }  //Back up!
		{ scenename = "scenes/NamVet/BackUp03.vcd" }  //Back back back back back back!
		{ scenename = "scenes/NamVet/BackUp04.vcd" }  //Back back back!
		{ scenename = "scenes/NamVet/BackUp05.vcd" }  //Back up!
		{ scenename = "scenes/NamVet/BackUp06.vcd" }  //Move back!
		{ scenename = "scenes/NamVet/BackUp07.vcd" }  //Back it up!
	],
	group_params = none
}

{
	name = "iMT_SurvivorVocalizeBackUpQuietNamVet",
	criteria =
	[
		[ "concept", "PlayerBackUp" ], [ "who", "NamVet" ], [ "coughing", 0 ], [ "tankactive", 0 ], [ "incombatmusic", 0 ], [ IsTalk ], [ IsTalkNamVet ], [ IsWorldTalkNamVet ], [ IsWitchNear ], [ IsNotWitchAggro ]
	],
	responses =
	[
		{ scenename = "scenes/NamVet/BackUpQuiet01.vcd" }  //Back up.
		{ scenename = "scenes/NamVet/BackUpQuiet02.vcd" }  //Back back back.
	],
	group_params = none
}

{
	name = "iMT_SurvivorVocalizeEmphaticGoNamVet",
	criteria =
	[
		[ "concept", "PlayerEmphaticGo" ], [ "who", "NamVet" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkNamVet ], [ IsWorldTalkNamVet ]
	],
	responses =
	[
		{ scenename = "scenes/NamVet/EmphaticGo01.vcd" }  //GO GO GO!
		{ scenename = "scenes/NamVet/EmphaticGo02.vcd" }  //MOVE!
		{ scenename = "scenes/NamVet/EmphaticGo03.vcd" }  //MOVE!
		{ scenename = "scenes/NamVet/EmphaticGo04.vcd" }  //MOVE MOVE MOVE!
		{ scenename = "scenes/NamVet/EmphaticGo05.vcd" }  //MOVE OUT!
		{ scenename = "scenes/NamVet/EmphaticGo06.vcd" }  //GO GO GO!
	],
	group_params = none
}

{
	name = "iMT_SurvivorVocalizeLookOutNamVet",
	criteria =
	[
		[ "concept", "PlayerLookOut" ], [ "who", "NamVet" ], [ "coughing", 0 ], [ "world_auto_finale", 2 ], [ IsTalk ], [ IsTalkNamVet ], [ IsWorldTalkNamVet ]
	],
	responses =
	[
		{ scenename = "scenes/NamVet/LookOut01.vcd" }  //Look out!
		{ scenename = "scenes/NamVet/LookOut02.vcd" }  //Watch out!
		{ scenename = "scenes/NamVet/LookOut03.vcd" }  //Watch out!
		{ scenename = "scenes/NamVet/LookOut04.vcd" }  //Watch your ass!
		{ scenename = "scenes/NamVet/LookOut05.vcd" }  //Heads up!
		{ scenename = "scenes/NamVet/LookOut06.vcd" }  //Behind you!!
	],
	group_params = none
}

//--------------------------------------------------------------------------------------------------
// Start Area
//--------------------------------------------------------------------------------------------------

{
	name = "iMT_EllisStoryInterruptGenericNamVet",
	criteria =
	[
		[ "concept", "EllisInterrupt" ], [ "who", "NamVet" ], [ "world_auto_tellingstory", 1 ], [ _auto_NotDidInterrupt ]
	],
	responses =
	[
		{
			scenename = "scenes/NamVet/C6DLC3SecondSafeRoom15.vcd", followup = RThen( "Mechanic", "EllisStoryReac01", null, 0.3 ),  //Noted. Let's go.
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
	name = "iMT_SafeRoomStartNamVet",
	criteria =
	[
		[ "concept", "TLK_IDLE" ], [ "who", "NamVet" ], [ "instartarea", 1 ], [ IsNotScavenge ], [ IsNotSurvival ], [ _auto_NotSafeRoomStart ]
	],
	responses =
	[
		{
			scenename = "scenes/NamVet/Blank.vcd",
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

rr_ProcessRules( NamVet )