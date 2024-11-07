//--------------------------------------------------------------------------------------------------
// ion's Vocalizer: Manager Response Rules
//--------------------------------------------------------------------------------------------------

// Shared responses

local SurvivorCoughingManager =
[
	{ scenename = "scenes/Manager/Cough01.vcd" }  //[Coughing from smoke]
	{ scenename = "scenes/Manager/Cough02.vcd" }  //[Coughing from smoke]
	{ scenename = "scenes/Manager/Cough03.vcd" }  //[Coughing from smoke]
	{ scenename = "scenes/Manager/Cough04.vcd" }  //[Coughing from smoke]
	{ scenename = "scenes/Manager/Cough05.vcd" }  //[Coughing from smoke]
]

local SurvivorMournBikerManager =
[
	{ scenename = "scenes/Manager/GriefBiker01.vcd" }  //Francis! NO!
	{ scenename = "scenes/Manager/GriefBiker04.vcd" }  //Francis! NO!
	{ scenename = "scenes/Manager/GriefBiker05.vcd" }  //Jesus, Francis!
	{ scenename = "scenes/Manager/GriefBiker07.vcd" }  //Jesus Christ, Francis, no, Francis!
]

local SurvivorMournNamVetManager =
[
	{ scenename = "scenes/Manager/GriefVet01.vcd" }  //Bill, no!
	{ scenename = "scenes/Manager/GriefVet03.vcd" }  //Ah Bill. Ah, shit.
	{ scenename = "scenes/Manager/GriefVet04.vcd" }  //Bill, Bill, no!
	{ scenename = "scenes/Manager/GriefVet06.vcd" }  //Bill, no!
	{ scenename = "scenes/Manager/GriefVet07.vcd" }  //Oh no, no, not the old man.
	{ scenename = "scenes/Manager/GriefVet08.vcd" }  //Ah Bill. Ah, shit.
]

local SurvivorMournTeenGirlManager =
[
	{ scenename = "scenes/Manager/GriefFemaleGeneric02.vcd" }  //Oh this is bad - she's dead.
	{ scenename = "scenes/Manager/GriefTeenGirl01.vcd" }  //Ah! Zoey!
	{ scenename = "scenes/Manager/GriefTeenGirl02.vcd" }  //ZOEY! Goddamn it.
	{ scenename = "scenes/Manager/GriefTeenGirl03.vcd" }  //Noo, oh ho ho, ZOEY!
	{ scenename = "scenes/Manager/GriefTeenGirl04.vcd" }  //Goddamn it Zoey, wakeup!
	{ scenename = "scenes/Manager/GriefTeenGirl05.vcd" }  //Ah! Zoey!
	{ scenename = "scenes/Manager/GriefTeenGirl06.vcd" }  //Zoey!
	{ scenename = "scenes/Manager/GriefTeenGirl07.vcd" }  //Damn Zoey!
	{ scenename = "scenes/Manager/GriefTeenGirl08.vcd" }  //Zoey, Zoey! Goddamnit!
]

//--------------------------------------------------------------------------------------------------
// Ellis Stories
//--------------------------------------------------------------------------------------------------

local Manager =
[

{
	name = "iMT_EllisStoryInterruptManager",
	criteria =
	[
		[ "concept", "iMT_EllisStoryInterrupt" ], [ "who", "Manager" ], [ "world_auto_tellingstory", 1 ], [ "coughing", 0 ], [ "incapacitated", 0 ], [ "speaking", 0], [ IsTalk ], [ IsTalkManager ], [ IsWorldTalkManager ], [ IssuerCloseEnough ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/GenericResponses25.vcd", followup = RThen( "Mechanic", "iMT_EllisStoryReac", { from = "Manager" }, 0.3 ) }  //Tell me you ain't serious.
	],
	group_params = none
}

{
	name = "iMT_EllisStoryStopManager",
	criteria =
	[
		[ "concept", "iMT_EllisStories" ], [ "who", "Manager" ], [ "world_auto_tellingstory", 1 ]
	],
	responses =
	[
		{
			scenename = "scenes/Manager/GenericResponses39.vcd", followup = RThen( "all", "iMT_EllisStoryStop", null, 0.3 ),  //Oh no. Ain't no damn way...
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
	name = "iMT_PlayerAnswerReadyManager",
	criteria =
	[
		[ "concept", "iMT_PlayerAnswerReady" ], [ "who", "Manager" ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/AnswerReady01.vcd" }  //Ready!
		{ scenename = "scenes/Manager/AnswerReady02.vcd" }  //Let's do it!
		{ scenename = "scenes/Manager/AnswerReady03.vcd" }  //Hit it!
		{ scenename = "scenes/Manager/AnswerReady04.vcd" }  //Come on, let's do it!
	],
	group_params = none
}

{
	name = "iMT_PlayerBattleCryManager",
	criteria =
	[
		[ "concept", "iMT_PlayerBattleCry" ], [ "who", "Manager" ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/Hurrah14.vcd" }  //YEAH!
		{ scenename = "scenes/Manager/Hurrah15.vcd" }  //YEAH WOO!
		{ scenename = "scenes/Manager/Taunt03.vcd" }  //Yeah, baby, yeah!
		{ scenename = "scenes/Manager/Taunt06.vcd" }  //Hell yeah, hell yeah!
		{ scenename = "scenes/Manager/Taunt07.vcd" }  //[loud, evil laugh]
		{ scenename = "scenes/Manager/Taunt08.vcd" }  //[loud, evil laugh]
		{ scenename = "scenes/Manager/Taunt09.vcd" }  //[loud, evil laugh]
		{ scenename = "scenes/Manager/Taunt10.vcd" }  //[loud, evil laugh]
	],
	group_params = none
}

{
	name = "iMT_PlayerBattleCry%Manager",
	criteria =
	[
		[ "concept", "iMT_PlayerBattleCry" ], [ "who", "Manager" ], [ "randomnum", 0, 2 ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/Taunt05.vcd" }  //Oh yeah, who's your momma, who's your daddy?
	],
	group_params = none
}

{
	name = "iMT_PlayerBreathingManager",
	criteria =
	[
		[ "concept", "iMT_PlayerBreathing" ], [ "who", "Manager" ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/ExertionCritical01.vcd" }  //[frightened freaked out breathing]
		{ scenename = "scenes/Manager/ExertionCritical02.vcd" }  //[frightened freaked out breathing]
		{ scenename = "scenes/Manager/ExertionCritical03.vcd" }  //[frightened freaked out breathing]
		{ scenename = "scenes/Manager/ExertionMajor01.vcd" }  //[heavy breathing - seriously winded]
		{ scenename = "scenes/Manager/ExertionMajor02.vcd" }  //[heavy breathing - seriously winded]
		{ scenename = "scenes/Manager/ExertionMinor01.vcd" }  //[breathing - panting out of breath]
		{ scenename = "scenes/Manager/ExertionMinor02.vcd" }  //[breathing - panting out of breath]
		{ scenename = "scenes/Manager/ExertionMinor03.vcd" }  //[breathing - panting out of breath]
		{ scenename = "scenes/Manager/ExertionMinor04.vcd" }  //[breathing - panting out of breath]
	],
	group_params = none
}

{
	name = "iMT_PlayerCloseTheDoorManager",
	criteria =
	[
		[ "concept", "iMT_PlayerCloseTheDoor" ], [ "who", "Manager" ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/CloseTheDoor01.vcd" }  //Lock that door.
		{ scenename = "scenes/Manager/CloseTheDoor02.vcd" }  //Lock the door.
		{ scenename = "scenes/Manager/CloseTheDoor03.vcd" }  //Lock the door, man!
		{ scenename = "scenes/Manager/CloseTheDoor04.vcd" }  //Go ahead and lock that door.
		{ scenename = "scenes/Manager/CloseTheDoor05.vcd" }  //Lock the damn door.
		{ scenename = "scenes/Manager/CloseTheDoor06.vcd" }  //Did you lock the door?
		{ scenename = "scenes/Manager/CloseTheDoor07.vcd" }  //Lock the door, man!
	],
	group_params = none
}

{
	name = "iMT_PlayerCoughingManager",
	criteria =
	[
		[ "concept", "iMT_PlayerCoughing" ], [ "who", "Manager" ]
	],
	responses = SurvivorCoughingManager,
	group_params = none
}

{
	name = "iMT_PlayerDeathScreamManager",
	criteria =
	[
		[ "concept", "iMT_PlayerDeathScream" ], [ "who", "Manager" ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/Fall01.vcd" }  //[Falling-to-Death scream]
		{ scenename = "scenes/Manager/Fall02.vcd" }  //[Falling-to-Death scream]
		{ scenename = "scenes/Manager/Fall03.vcd" }  //[Falling-to-Death scream]
	],
	group_params = none
}

{
	name = "iMT_PlayerFriendlyFireManager",
	criteria =
	[
		[ "concept", "iMT_PlayerFriendlyFire" ], [ "who", "Manager" ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/FriendlyFire01.vcd" }  //Hey, man, that hurt.
		{ scenename = "scenes/Manager/FriendlyFire02.vcd" }  //AH! Will you knock it off?
		{ scenename = "scenes/Manager/FriendlyFire03.vcd" }  //Do I look like one of them?
		{ scenename = "scenes/Manager/FriendlyFire04.vcd" }  //You know I would appreciate it, IF YOU'D STOP SHOOTING ME.
		{ scenename = "scenes/Manager/FriendlyFire05.vcd" }  //Watch where you're shooting!
		{ scenename = "scenes/Manager/FriendlyFire06.vcd" }  //Hey, man, that's not cool.
		{ scenename = "scenes/Manager/FriendlyFire07.vcd" }  //Man, what the hell, quit shooting me!
		{ scenename = "scenes/Manager/FriendlyFire08.vcd" }  //Whoa, whoa, don't shoot, it's me!
		{ scenename = "scenes/Manager/FriendlyFire09.vcd" }  //Ow man ow! Why you shooting me!
		{ scenename = "scenes/Manager/FriendlyFire10.vcd" }  //Look at my face, do I look like them?
		{ scenename = "scenes/Manager/FriendlyFire11.vcd" }  //Oh what the hell, why you shootin' me?
		{ scenename = "scenes/Manager/FriendlyFire12.vcd" }  //I'm gonna shoot you back next time.
		{ scenename = "scenes/Manager/FriendlyFire13.vcd" }  //Ahhh Mother!
		{ scenename = "scenes/Manager/FriendlyFire14.vcd" }  //Whoa, whoa, don't shoot, it's me!
	],
	group_params = none
}

{
	name = "iMT_PlayerFriendlyFireFromBikerManager",
	criteria =
	[
		[ "concept", "iMT_PlayerFriendlyFire" ], [ "who", "Manager" ], [ "subject", "Biker" ], [ "dist_from_subject", 0, 799 ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/Manager_FriendlyFireFrancis01.vcd" }  //Francis, that's MY ass your shootin'.
		{ scenename = "scenes/Manager/Manager_FriendlyFireFrancis02.vcd" }  //Francis, What the HELL is wrong with you?
		{ scenename = "scenes/Manager/Manager_FriendlyFireFrancis06.vcd" }  //[angry] Francis!
		{ scenename = "scenes/Manager/Manager_FriendlyFireFrancis07.vcd" }  //Go on do it one more time, fat man.
		{ scenename = "scenes/Manager/Manager_FriendlyFireFrancis08.vcd" }  //[angry] Francis!
	],
	group_params = none
}

{
	name = "iMT_PlayerFriendlyFireFromNamVetManager",
	criteria =
	[
		[ "concept", "iMT_PlayerFriendlyFire" ], [ "who", "Manager" ], [ "subject", "NamVet" ], [ "dist_from_subject", 0, 799 ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/Manager_FriendlyFireBill01.vcd" }  //Old man, stop shooting me!
		{ scenename = "scenes/Manager/Manager_FriendlyFireBill02.vcd" }  //Whoah, whoah, whoah! Jesus, Bill, what are you doing?
		{ scenename = "scenes/Manager/Manager_FriendlyFireBill03.vcd" }  //William! Come on, man!
		{ scenename = "scenes/Manager/Manager_FriendlyFireBill04.vcd" }  //Watch it, Bill!
		{ scenename = "scenes/Manager/Manager_FriendlyFireBill05.vcd" }  //[angry] Bill!
		{ scenename = "scenes/Manager/Manager_FriendlyFireBill06.vcd" }  //I cannot BELIEVE you just shot me AGAIN.
		{ scenename = "scenes/Manager/Manager_FriendlyFireBill08.vcd" }  //[angry] Bill!
		{ scenename = "scenes/Manager/Manager_FriendlyFireBill09.vcd" }  //[angry] Bill!
	],
	group_params = none
}

{
	name = "iMT_PlayerFriendlyFireFromTeenGirlManager",
	criteria =
	[
		[ "concept", "iMT_PlayerFriendlyFire" ], [ "who", "Manager" ], [ "subject", "TeenGirl" ], [ "dist_from_subject", 0, 799 ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/Manager_FriendlyFireZoey02.vcd" }  //You gotta stop that shit, Zoey!
		{ scenename = "scenes/Manager/Manager_FriendlyFireZoey05.vcd" }  //[angry] Zoey!
		{ scenename = "scenes/Manager/Manager_FriendlyFireZoey07.vcd" }  //[angry] Zoey!
	],
	group_params = none
}

{
	name = "iMT_PlayerGetToVehicleBoatManager",
	criteria =
	[
		[ "concept", "iMT_PlayerGetToVehicleBoat" ], [ "who", "Manager" ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/ArriveBoat01.vcd" }  //Get to the boat!
		{ scenename = "scenes/Manager/ArriveBoat02.vcd" }  //Get to the boat!
		{ scenename = "scenes/Manager/ArriveBoat03.vcd" }  //Run to the boat!
		{ scenename = "scenes/Manager/ArriveBoatInitial01.vcd" }  //The boat's here! Let's go!
		{ scenename = "scenes/Manager/ArriveBoatInitial02.vcd" }  //Our boat's here! Let's go!
	],
	group_params = none
}

{
	name = "iMT_PlayerGetToVehicleChopperManager",
	criteria =
	[
		[ "concept", "iMT_PlayerGetToVehicleChopper" ], [ "who", "Manager" ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/ArriveChopper01.vcd" }  //Everyone in the helicopter! Go!
		{ scenename = "scenes/Manager/ArriveChopper02.vcd" }  //Get to the helicopter!
		{ scenename = "scenes/Manager/ArriveChopperInitial01.vcd" }  //The heli's here. Let's go!
		{ scenename = "scenes/Manager/ArriveChopperInitial02.vcd" }  //The helicopter's here! Let's go!
	],
	group_params = none
}

{
	name = "iMT_PlayerGetToVehicleWheelsManager",
	criteria =
	[
		[ "concept", "iMT_PlayerGetToVehicleWheels" ], [ "who", "Manager" ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/ArriveTruck01.vcd" }  //Get to the truck! TO THE TRUCK!
		{ scenename = "scenes/Manager/ArriveTruck02.vcd" }  //GET TO THE TRUCK!
		{ scenename = "scenes/Manager/ArriveTruckInitial01.vcd" }  //The truck's here! Let's go!
	],
	group_params = none
}

{
	name = "iMT_PlayerGoingToDieManager",
	criteria =
	[
		[ "concept", "iMT_PlayerGoingToDie" ], [ "who", "Manager" ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/GoingToDie01.vcd" }  //I don't feel so good.
		{ scenename = "scenes/Manager/GoingToDie03.vcd" }  //I feel awful.
		{ scenename = "scenes/Manager/GoingToDie04.vcd" }  //I'm not gonna last much longer.
		{ scenename = "scenes/Manager/GoingToDie06.vcd" }  //Shit, I am really messed up.
		{ scenename = "scenes/Manager/GoingToDie08.vcd" }  //I have to heal up.
		{ scenename = "scenes/Manager/GoingToDie09.vcd" }  //Every part of me hurts.
		{ scenename = "scenes/Manager/GoingToDie10.vcd" }  //This sucks.
		{ scenename = "scenes/Manager/GoingToDie11.vcd" }  //At this rate, I'm not gonna make it.
		{ scenename = "scenes/Manager/GoingToDie12.vcd" }  //I feel terrible.
		{ scenename = "scenes/Manager/GoingToDie13.vcd" }  //This is bad. This is really bad.
		{ scenename = "scenes/Manager/GoingToDie14.vcd" }  //I think I'm hurt bad.
		{ scenename = "scenes/Manager/GoingToDie16.vcd" }  //I feel terrible.
		{ scenename = "scenes/Manager/GoingToDie17.vcd" }  //I feel awful.
		{ scenename = "scenes/Manager/GoingToDie18.vcd" }  //[gasps and sharp intake of breath]
		{ scenename = "scenes/Manager/GoingToDie19.vcd" }  //I think something's broken.
		{ scenename = "scenes/Manager/GoingToDie24.vcd" }  //Oh man, I am in sorry ass shape.
		{ scenename = "scenes/Manager/GoingToDie25.vcd" }  //I feel kinda woozy.
		{ scenename = "scenes/Manager/GoingToDie26.vcd" }  //I'm not gonna make it, man.
		{ scenename = "scenes/Manager/GoingToDie27.vcd" }  //Every part of me hurts.
		{ scenename = "scenes/Manager/GoingToDieLight03.vcd" }  //Man, this hurts.
		{ scenename = "scenes/Manager/GoingToDieLight14.vcd" }  //[pain noise] Oh man, every damn thing hurts.
		{ scenename = "scenes/Manager/GoingToDieLight15.vcd" }  //[blows air out through pursed lips] This is some real bullshit right here.
		{ scenename = "scenes/Manager/GoingToDieLight17.vcd" }  //Ah. [pain noise] Hell, hell.
	],
	group_params = none
}

{
	name = "iMT_PlayerGoingToDie3Manager",
	criteria =
	[
		[ "concept", "iMT_PlayerGoingToDie" ], [ "who", "Manager" ], [ "onthirdstrike", 1 ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/GoingToDie02.vcd" }  //I don't, I don't know if I'm going to make it.
		{ scenename = "scenes/Manager/GoingToDie05.vcd" }  //I really need to get some First Aid.
		{ scenename = "scenes/Manager/GoingToDie07.vcd" }  //I don't think I'm gonnna make it.
		{ scenename = "scenes/Manager/GoingToDie15.vcd" }  //I think I'm dyin'.
		{ scenename = "scenes/Manager/GoingToDie20.vcd" }  //I should have stayed in the damn store...
		{ scenename = "scenes/Manager/GoingToDie21.vcd" }  //I'm not kidding, we need to find me some First Aid.
		{ scenename = "scenes/Manager/GoingToDie22.vcd" }  //[pain sound] Dammit.
		{ scenename = "scenes/Manager/GoingToDie23.vcd" }  //Ah, I might not make it.
		{ scenename = "scenes/Manager/GoingToDieLight12.vcd" }  //[quiet pep talk to self] C'mon Louis, you are NOT dyin' here.
		{ scenename = "scenes/Manager/GoingToDieLight16.vcd" }  //I don't wanna die. I know nobody wants to die, but I'm like, fifty times that.
	],
	group_params = none
}

{
	name = "iMT_PlayerGooedBySpitterManager",
	criteria =
	[
		[ "concept", "iMT_PlayerGooedBySpitter" ], [ "who", "Manager" ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/EmphaticGo05.vcd" }  //MOVE!
		{ scenename = "scenes/Manager/EmphaticGo08.vcd" }  //MOVE IT!
		{ scenename = "scenes/Manager/ReactionDisgusted04.vcd" }  //Yuck
		{ scenename = "scenes/Manager/Swears05.vcd" }  //Shit.
		{ scenename = "scenes/Manager/Swears06.vcd" }  //Ah shit.
	],
	group_params = none
}

{
	name = "iMT_PlayerHelloManager",
	criteria =
	[
		[ "concept", "iMT_PlayerHello" ], [ "who", "Manager" ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/ScenarioJoin02.vcd" }  //Hello!
	],
	group_params = none
}

{
	name = "iMT_PlayerIncapacitatedHurtManager",
	criteria =
	[
		[ "concept", "iMT_PlayerIncapacitatedHurt" ], [ "who", "Manager" ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/IncapacitatedInjury01.vcd" }  //[Ahhhh - terrified yell]
		{ scenename = "scenes/Manager/IncapacitatedInjury02.vcd" }  //[Ahhhh - terrified yell]
		{ scenename = "scenes/Manager/IncapacitatedInjury03.vcd" }  //[Ahhhh - terrified yell]
	],
	group_params = none
}

{
	name = "iMT_PlayerKillConfirmationManager",
	criteria =
	[
		[ "concept", "iMT_PlayerKilledZombie" ], [ "who", "Manager" ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/KillConfirmation01.vcd" }  //Got it!
		{ scenename = "scenes/Manager/KillConfirmation02.vcd" }  //Killed it!
		{ scenename = "scenes/Manager/KillConfirmation03.vcd" }  //Dead!
		{ scenename = "scenes/Manager/KillConfirmation04.vcd" }  //Got it!
		{ scenename = "scenes/Manager/KillConfirmation05.vcd" }  //Killed it!
		{ scenename = "scenes/Manager/KillConfirmation06.vcd" }  //Dead!
	],
	group_params = none
}

{
	name = "iMT_PlayerMeleeManager",
	criteria =
	[
		[ "concept", "iMT_PlayerMelee" ], [ "who", "Manager" ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/Shoved01.vcd" }  //[Melee grunt]
		{ scenename = "scenes/Manager/Shoved02.vcd" }  //[Melee grunt]
		{ scenename = "scenes/Manager/Shoved03.vcd" }  //[Melee grunt]
		{ scenename = "scenes/Manager/Shoved04.vcd" }  //[Melee grunt]
		{ scenename = "scenes/Manager/Shoved05.vcd" }  //[Melee grunt]
	],
	group_params = none
}

{
	name = "iMT_PlayerMournBikerAliveManager",
	criteria =
	[
		[ "concept", "iMT_PlayerMourn" ], [ "who", "Manager" ], [ "isbikeralive", 1 ], [ "subject", "Biker" ], [ "dist_from_subject", 0, 199 ]
	],
	responses = SurvivorMournBikerManager,
	group_params = none
}

{
	name = "iMT_PlayerMournBikerDeadManager",
	criteria =
	[
		[ "concept", "iMT_PlayerMourn" ], [ "who", "Manager" ], [ "isbikeralive", 0 ], [ "disttobiker", 0, 199 ]
	],
	responses = SurvivorMournBikerManager,
	group_params = none
}

{
	name = "iMT_PlayerMournNamVetAliveManager",
	criteria =
	[
		[ "concept", "iMT_PlayerMourn" ], [ "who", "Manager" ], [ "isnamvetalive", 1 ], [ "subject", "NamVet" ], [ "dist_from_subject", 0, 199 ]
	],
	responses = SurvivorMournNamVetManager,
	group_params = none
}

{
	name = "iMT_PlayerMournNamVetDeadManager",
	criteria =
	[
		[ "concept", "iMT_PlayerMourn" ], [ "who", "Manager" ], [ "isnamvetalive", 0 ], [ "disttonamvet", 0, 199 ]
	],
	responses = SurvivorMournNamVetManager,
	group_params = none
}

{
	name = "iMT_PlayerMournTeenGirlAliveManager",
	criteria =
	[
		[ "concept", "iMT_PlayerMourn" ], [ "who", "Manager" ], [ "isteengirlalive", 1 ], [ "subject", "TeenGirl" ], [ "dist_from_subject", 0, 199 ]
	],
	responses = SurvivorMournTeenGirlManager,
	group_params = none
}

{
	name = "iMT_PlayerMournTeenGirlDeadManager",
	criteria =
	[
		[ "concept", "iMT_PlayerMourn" ], [ "who", "Manager" ], [ "isteengirlalive", 0 ], [ "disttoteengirl", 0, 199 ]
	],
	responses = SurvivorMournTeenGirlManager,
	group_params = none
}

{
	name = "iMT_PlayerNearExitManager",
	criteria =
	[
		[ "concept", "iMT_PlayerNearExit" ], [ "who", "Manager" ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/FinaleAhead01.vcd" }  //We're almost out of here!
		{ scenename = "scenes/Manager/FinaleAhead02.vcd" }  //We're almost out of here!
		{ scenename = "scenes/Manager/SafeSpotAhead04.vcd", followup = RThen( "any", "iMT_PlayerNearExitReac", { from = "Manager" }, 0.3 ) }  //Safe house ahead!
		{ scenename = "scenes/Manager/SafeSpotAhead05.vcd", followup = RThen( "any", "iMT_PlayerNearExitReac", { from = "Manager" }, 0.3 ) }  //There's the safe house!
		{ scenename = "scenes/Manager/SafeSpotAhead06.vcd", followup = RThen( "any", "iMT_PlayerNearExitReac", { from = "Manager" }, 0.3 ) }  //Safe house!
		{ scenename = "scenes/Manager/SafeSpotAhead07.vcd", followup = RThen( "any", "iMT_PlayerNearExitReac", { from = "Manager" }, 0.3 ) }  //Safe house up ahead!
	],
	group_params = none
}

{
	name = "iMT_PlayerNearExitReacManager",
	criteria =
	[
		[ "concept", "iMT_PlayerNearExitReac" ], [ "who", "Manager" ], [ "coughing", 0 ], [ "incapacitated", 0 ], [ "speaking", 0], [ "randomnum", 0, 10 ], [ IsTalk ], [ IsTalkManager ], [ IsWorldTalkManager ], [ IssuerClose ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/SafeSpotAheadReaction01.vcd" }  //Finally.
		{ scenename = "scenes/Manager/SafeSpotAheadReaction02.vcd" }  //We made it!
		{ scenename = "scenes/Manager/SafeSpotAheadReaction03.vcd" }  //I KNEW we'd make it!
		{ scenename = "scenes/Manager/SafeSpotAheadReaction05.vcd" }  //Man, I KNEW we were gonna make it.
	],
	group_params = none
}

{
	name = "iMT_PlayerNiceShotManager",
	criteria =
	[
		[ "concept", "iMT_PlayerNiceShot" ], [ "who", "Manager" ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/NiceShot01.vcd" }  //Nice shot!
		{ scenename = "scenes/Manager/NiceShot02.vcd" }  //Oh man, great shot.
		{ scenename = "scenes/Manager/NiceShot03.vcd" }  //Wooo, nice baby!
		{ scenename = "scenes/Manager/NiceShot04.vcd" }  //Whoah. Nice shot.
		{ scenename = "scenes/Manager/NiceShot05.vcd" }  //Nice one!
		{ scenename = "scenes/Manager/NiceShot07.vcd" }  //Nice shot!
		{ scenename = "scenes/Manager/NiceShot08.vcd" }  //Great shot!
		{ scenename = "scenes/Manager/NiceShot09.vcd" }  //POW!
		{ scenename = "scenes/Manager/NiceShot10.vcd" }  //Oh, HELL yes.
	],
	group_params = none
}

{
	name = "iMT_PlayerPainNoiseManager",
	criteria =
	[
		[ "concept", "iMT_PlayerPainNoise" ], [ "who", "Manager" ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/HurtCritical01.vcd" }  //[Pain noise - loud major pain]
		{ scenename = "scenes/Manager/HurtCritical02.vcd" }  //[Pain noise - loud major pain]
		{ scenename = "scenes/Manager/HurtCritical03.vcd" }  //[Pain noise - loud major pain]
		{ scenename = "scenes/Manager/HurtCritical04.vcd" }  //[Pain noise - loud major pain]
		{ scenename = "scenes/Manager/HurtCritical05.vcd" }  //[Pain noise - loud major pain]
		{ scenename = "scenes/Manager/HurtMajor01.vcd" }  //[Pain noise - huh]
		{ scenename = "scenes/Manager/HurtMajor02.vcd" }  //[Pain noise - ahh]
		{ scenename = "scenes/Manager/HurtMajor03.vcd" }  //[Pain noise - oy]
		{ scenename = "scenes/Manager/HurtMajor04.vcd" }  //[Pain noise - oy]
		{ scenename = "scenes/Manager/HurtMajor05.vcd" }  //[Pain noise - ugh]
		{ scenename = "scenes/Manager/HurtMajor06.vcd" }  //[Pain noise - ugh]
		{ scenename = "scenes/Manager/HurtMajor07.vcd" }  //[Pain noise - ugh]
		{ scenename = "scenes/Manager/HurtMajor08.vcd" }  //[Pain noise - ugh]
		{ scenename = "scenes/Manager/HurtMajor09.vcd" }  //[Pain noise - ugh]
		{ scenename = "scenes/Manager/HurtMajor10.vcd" }  //[Pain noise - ugh]
	],
	group_params = none
}

{
	name = "iMT_PlayerPouncedBikerManager",
	criteria =
	[
		[ "concept", "iMT_SurvivorWasPounced" ], [ "who", "Manager" ], [ "subject", "Biker" ], [ "dist_from_subject", 0, 799 ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/HunterFrancisPounced02.vcd" }  //Hunter on Francis!
		{ scenename = "scenes/Manager/HunterFrancisPounced03.vcd" }  //Hunter on Francis!
	],
	group_params = none
}

{
	name = "iMT_PlayerPouncedNamVetManager",
	criteria =
	[
		[ "concept", "iMT_SurvivorWasPounced" ], [ "who", "Manager" ], [ "subject", "NamVet" ], [ "dist_from_subject", 0, 799 ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/HunterBillPounced02.vcd" }  //Hunter on Bill!
		{ scenename = "scenes/Manager/HunterBillPounced03.vcd" }  //Hunter on Bill!
	],
	group_params = none
}

{
	name = "iMT_PlayerPouncedTeenGirlManager",
	criteria =
	[
		[ "concept", "iMT_SurvivorWasPounced" ], [ "who", "Manager" ], [ "subject", "TeenGirl" ], [ "dist_from_subject", 0, 799 ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/HunterZoeyPounced01.vcd" }  //Hunter on Zoey!
		{ scenename = "scenes/Manager/HunterZoeyPounced03.vcd" }  //Hunter on Zoey!
	],
	group_params = none
}

{
	name = "iMT_PlayerReloadingManager",
	criteria =
	[
		[ "concept", "iMT_PlayerReloading" ], [ "who", "Manager" ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/Reloading01.vcd" }  //Reloading!
		{ scenename = "scenes/Manager/Reloading02.vcd" }  //Reloading!
		{ scenename = "scenes/Manager/Reloading03.vcd" }  //Reloading!
	],
	group_params = none
}

{
	name = "iMT_PlayerSuggestHealthManager",
	criteria =
	[
		[ "concept", "iMT_PlayerSuggestHealth" ], [ "who", "Manager" ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/PlayerSuggestHealth01.vcd" }  //Maybe you oughtta heal up.
	],
	group_params = none
}

{
	name = "iMT_PlayerSuggestHealthBikerManager",
	criteria =
	[
		[ "concept", "iMT_PlayerSuggestHealth" ], [ "who", "Manager" ], [ "subject", "Biker" ], [ "dist_from_subject", 0, 199 ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/PlayerSuggestHealthFrancis01.vcd" }  //Francis, you should use your med kit.
		{ scenename = "scenes/Manager/PlayerSuggestHealthFrancis02.vcd" }  //Hey tough guy, heal up.
		{ scenename = "scenes/Manager/PlayerSuggestHealthFrancis03.vcd" }  //Yo Francis, come on buddy, heal up.
		{ scenename = "scenes/Manager/PlayerSuggestHealthFrancis04.vcd" }  //Francis, patch yerself up.
	],
	group_params = none
}

{
	name = "iMT_PlayerSuggestHealthNamVetManager",
	criteria =
	[
		[ "concept", "iMT_PlayerSuggestHealth" ], [ "who", "Manager" ], [ "subject", "NamVet" ], [ "dist_from_subject", 0, 199 ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/PlayerSuggestHealthBill01.vcd" }  //Bill, you might wanna use your med kit.
		{ scenename = "scenes/Manager/PlayerSuggestHealthBill02.vcd" }  //Bill, you oughtta heal.
		{ scenename = "scenes/Manager/PlayerSuggestHealthBill03.vcd" }  //Hey Bill, might be a good time to patch yerself up.
	],
	group_params = none
}

{
	name = "iMT_PlayerSuggestHealthTeenGirlManager",
	criteria =
	[
		[ "concept", "iMT_PlayerSuggestHealth" ], [ "who", "Manager" ], [ "subject", "TeenGirl" ], [ "dist_from_subject", 0, 199 ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/PlayerSuggestHealthZoey01.vcd" }  //Zoey, you really oughtta heal.
		{ scenename = "scenes/Manager/PlayerSuggestHealthZoey02.vcd" }  //Go on and heal up, girl.
		{ scenename = "scenes/Manager/PlayerSuggestHealthZoey03.vcd" }  //Might be a good time to heal, Zoey.
		{ scenename = "scenes/Manager/PlayerSuggestHealthZoey04.vcd" }  //Come on, girl - time to heal up.
		{ scenename = "scenes/Manager/PlayerSuggestHealthZoey05.vcd" }  //Go on and heal up, Zoey.
	],
	group_params = none
}

{
	name = "iMT_PlayerTeamKillManager",
	criteria =
	[
		[ "concept", "iMT_PlayerTeamKill" ], [ "who", "Manager" ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/TeamKillAccident01.vcd" }  //Woah man, you gotta be careful.
		{ scenename = "scenes/Manager/TeamKillAccident02.vcd" }  //Woah man, you gotta be careful.
		{ scenename = "scenes/Manager/TeamKillAccident03.vcd" }  //What the hell man?
		{ scenename = "scenes/Manager/TeamKillAccident04.vcd" }  //Be careful, what are you doing?
	],
	group_params = none
}

{
	name = "iMT_PlayerTransitionManager",
	criteria =
	[
		[ "concept", "iMT_PlayerTransition" ], [ "who", "Manager" ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/PlayerTransitionClose02.vcd" }  //Damn!
		{ scenename = "scenes/Manager/PlayerTransitionClose03.vcd" }  //At least we're safe now!
		{ scenename = "scenes/Manager/PlayerTransitionClose04.vcd" }  //BOOM-diah
	],
	group_params = none
}

{
	name = "iMT_PlayerTransitionCloseManager",
	criteria =
	[
		[ "concept", "iMT_PlayerTransition" ], [ "who", "Manager" ], [ "numberofteamdead", 1, null ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/PlayerTransitionClose01.vcd" }  //Woah Jesus!
		{ scenename = "scenes/Manager/ZombieGenericShort13.vcd" }  //Well, it can only get better, right?
	],
	group_params = none
}

{
	name = "iMT_PlayerTransitionSoloManager",
	criteria =
	[
		[ "concept", "iMT_PlayerTransition" ], [ "who", "Manager" ], [ "numberofteamdead", 1, null ], [ "numberofteamalive", 1 ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/PlayerTransitionClose01.vcd" }  //Woah Jesus!
	],
	group_params = none
}

{
	name = "iMT_PlayerWitchChasingManager",
	criteria =
	[
		[ "concept", "iMT_PlayerWitchChasing" ], [ "who", "Manager" ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/GrabbedBySmoker03b.vcd" }  //No, No, NO, NOOOOOOO!!!!!!!!!
		{ scenename = "scenes/Manager/Help07.vcd" }  //I'm in trouble!
	],
	group_params = none
}

{
	name = "iMT_SurvivorCaughtVomitManager",
	criteria =
	[
		[ "concept", "iMT_PlayerVomitInFace" ], [ "who", "Manager" ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/ReactionBoomerVomit01.vcd" }  //[spitting gross noises]
		{ scenename = "scenes/Manager/ReactionBoomerVomit02.vcd" }  //[spitting gross noises]
		{ scenename = "scenes/Manager/ReactionBoomerVomit03.vcd" }  //[spitting gross noises]
		{ scenename = "scenes/Manager/ReactionBoomerVomit04.vcd" }  //[spitting gross noises]
		{ scenename = "scenes/Manager/ReactionDisgusted01.vcd" }  //Ewwww...
		{ scenename = "scenes/Manager/ReactionDisgusted02.vcd" }  //Blech...
		{ scenename = "scenes/Manager/ReactionDisgusted04.vcd" }  //Yuck
	],
	group_params = none
}

//--------------------------------------------------------------------------------------------------
// Character-specific
//--------------------------------------------------------------------------------------------------

{
	name = "iMT_AlleyManager",
	criteria =
	[
		[ "concept", "iMT_Alley" ], [ "who", "Manager" ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/DLC2Alley01.vcd" }  //Hey, Francis. Wasn't this the alley you were born in?
	],
	group_params = none
}

{
	name = "iMT_ApocalypseManager",
	criteria =
	[
		[ "concept", "iMT_Apocalypse" ], [ "who", "Manager" ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/DLC2SwearCoupDeGrace17.vcd" }  //Oh it's the BITCH apocalypse now, bitch.
	],
	group_params = none
}

{
	name = "iMT_BackToNormalManager",
	criteria =
	[
		[ "concept", "iMT_BackToNormal" ], [ "who", "Manager" ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/ZombieGenericLong15.vcd" }  //When things go back to normal, Zoey, Bill - I'm giving you both jobs. Francis, I'm gonna teach your ass how to read.
	],
	group_params = none
}

{
	name = "iMT_BelchManager",
	criteria =
	[
		[ "concept", "iMT_Belch" ], [ "who", "Manager" ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/Generic14.vcd", followup = RThen( "any", "iMT_ShortLaugh", { from = "Manager" }, 0 ) }  //BELCH - Excuse me
	],
	group_params = none
}

{
	name = "iMT_Belch%Manager",
	criteria =
	[
		[ "concept", "iMT_Belch" ], [ "who", "Manager" ], [ "randomnum", 0, 10 ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/Generic14.vcd", followup = RThen( "self", "iMT_ShortLaugh", null, 0.3 ) }  //BELCH - Excuse me
	],
	group_params = none
}

{
	name = "iMT_BelievingManager",
	criteria =
	[
		[ "concept", "iMT_Believing" ], [ "who", "Manager" ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/DLC1_C6M3_FinaleChat20.vcd" }  //Francis said you weren't goin' to make it. But I said I had a good feelin' about you.
		{ scenename = "scenes/Manager/DLC1_C6M3_FinaleChat21.vcd" }  //Francis said you weren't goin' to make it. But I had a good feelin' about you.
	],
	group_params = none
}

{
	name = "iMT_CounterStrikeManager",
	criteria =
	[
		[ "concept", "iMT_CounterStrike" ], [ "who", "Manager" ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/TakeSubMachineGun03.vcd" }  //Cool, just like Counter-Strike.
	],
	group_params = none
}

{
	name = "iMT_CubScoutsManager",
	criteria =
	[
		[ "concept", "iMT_CubScouts" ], [ "who", "Manager" ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/ZombieGenericLong11.vcd" }  //Any of you guys in the Cub Scouts? Surprisingly ineffective at preparin' you for some shit like this.
	],
	group_params = none
}

{
	name = "iMT_GordonFreemanManager",
	criteria =
	[
		[ "concept", "iMT_GordonFreeman" ], [ "who", "Manager" ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/DLC1_CommunityL4D110.vcd" }  //Man, I feel like I'm Gordon Freeman!
	],
	group_params = none
}

{
	name = "iMT_HeroManager",
	criteria =
	[
		[ "concept", "iMT_Hero" ], [ "who", "Manager" ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/ReviveFriend18.vcd" }  //I never saw nobody take that much abuse and live! Oughtta start callin' you Jason.
		{ scenename = "scenes/Manager/ReviveFriend19.vcd" }  //I never saw nobody take that much abuse and live! Oughtta start callin' you Hercules.
	],
	group_params = none
}

{
	name = "iMT_IntroductionManager",
	criteria =
	[
		[ "concept", "iMT_Introduction" ], [ "who", "Manager" ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/DLC1_C6M3_FinaleChat05.vcd" }  //Hi, I'm Louis!
		{ scenename = "scenes/Manager/DLC1_C6M3_FinaleChat06.vcd" }  //Hi, I'm Louis!
		{ scenename = "scenes/Manager/DLC1_C6M3_FinaleChat23.vcd" }  //Hey guys! My name's Louis.
	],
	group_params = none
}

{
	name = "iMT_ITManager",
	criteria =
	[
		[ "concept", "iMT_IT" ], [ "who", "Manager" ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/C6DLC3SecondSafeRoom04.vcd" }  //You know what I miss? Checking email. Seeing what's new.
		{ scenename = "scenes/Manager/C6DLC3SecondSafeRoom08.vcd" }  //One thing I'm not gonna miss about civilization? I.T. I will never have to tell another human being to reboot their damn computer.
	],
	group_params = none
}

{
	name = "iMT_MadeItManager",
	criteria =
	[
		[ "concept", "iMT_MadeIt" ], [ "who", "Manager" ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/DLC1_C6M3_FinaleChat08.vcd" }  //Hey, you made it!
		{ scenename = "scenes/Manager/DLC1_C6M3_FinaleChat09.vcd" }  //Hey, you made it!
		{ scenename = "scenes/Manager/DLC1_C6M3_FinaleChat10.vcd" }  //Hey, you made it!
	],
	group_params = none
}

{
	name = "iMT_NervousHummingManager",
	criteria =
	[
		[ "concept", "iMT_NervousHumming" ], [ "who", "Manager" ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/NervousHumming01.vcd" }  //[Nervous Humming]
		{ scenename = "scenes/Manager/NervousHumming02.vcd" }  //[Nervous Humming]
	],
	group_params = none
}

{
	name = "iMT_NewManager",
	criteria =
	[
		[ "concept", "iMT_New" ], [ "who", "Manager" ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/DLC1_C6M3_L4D11stSpot01.vcd" }  //Is that a new zombie?
		{ scenename = "scenes/Manager/DLC1_C6M3_L4D11stSpot02.vcd" }  //Is that a new zombie?
		{ scenename = "scenes/Manager/DLC1_C6M3_L4D11stSpot03.vcd" }  //Is that a new zombie?
	],
	group_params = none
}

{
	name = "iMT_New%Manager",
	criteria =
	[
		[ "concept", "iMT_New" ], [ "who", "Manager" ], [ "randomnum", 0, 10 ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/DLC1_CommunityL4D106.vcd" }  //Zombies are driving trucks?
	],
	group_params = none
}

{
	name = "iMT_RecycleManager",
	criteria =
	[
		[ "concept", "iMT_Recycle" ], [ "who", "Manager" ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/DLC2Recycling01.vcd" }  //We get out of this alive? I can't WAIT to have to recycle shit again.
	],
	group_params = none
}

{
	name = "iMT_RifleRangeManager",
	criteria =
	[
		[ "concept", "iMT_RifleRange" ], [ "who", "Manager" ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/GameSpeech01.vcd" }  //The guys used to laugh when I hit the rifle range at lunch. Ain't so funny now, is it?
		{ scenename = "scenes/Manager/Generic20.vcd" }  //Guys at the office used to laugh when I'd hit the rifle range on my lunch break. Ain't so damn funny now, is it?
	],
	group_params = none
}

{
	name = "iMT_SeeingMoreManager",
	criteria =
	[
		[ "concept", "iMT_SeeingMore" ], [ "who", "Manager" ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/DLC1_C6M3_L4D1FinaleCinematic08.vcd" }  //I think we're gonna be seeing more of that guy!
		{ scenename = "scenes/Manager/DLC1_C6M3_L4D1FinaleCinematic09.vcd" }  //I think we're gonna be seeing more of that guy!
	],
	group_params = none
}

{
	name = "iMT_ShortLaughManager",
	criteria =
	[
		[ "concept", "iMT_ShortLaugh" ], [ "who", "Manager" ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/Laughter01.vcd" }  //<Short laugh>
	],
	group_params = none
}

{
	name = "iMT_ShotHimManager",
	criteria =
	[
		[ "concept", "iMT_ShotHim" ], [ "who", "Manager" ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/DLC1_C6M3_FinaleChat02.vcd" }  //You're right, Francis. He's not friendly. I think Bill would have shot him by now.
		{ scenename = "scenes/Manager/DLC1_C6M3_FinaleChat03.vcd" }  //You're right, Francis. He's not friendly. I think Bill would have shot him by now.
	],
	group_params = none
}

{
	name = "iMT_SingingManager",
	criteria =
	[
		[ "concept", "iMT_Singing" ], [ "who", "Manager" ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/NervousWhislte01.vcd" }  //[Nervous Whistle]
	],
	group_params = none
}

{
	name = "iMT_TankFactoryManager",
	criteria =
	[
		[ "concept", "iMT_TankFactory" ], [ "who", "Manager" ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/C6DLC3InTankTrainCar01.vcd", followup = RThen( "Biker", "iMT_TankFactoryReac", { from = "Manager" }, 1 ) }  //Hey Francis what do they make at the tank factory?
		{ scenename = "scenes/Manager/C6DLC3InTankTrainCar02.vcd", followup = RThen( "Biker", "iMT_TankFactoryReac", { from = "Manager" }, 1 ) }  //Hey Francis what do they make at the tank factory?
	],
	group_params = none
}

{
	name = "iMT_TankFactory2Manager",
	criteria =
	[
		[ "concept", "iMT_TankFactory2" ], [ "who", "Manager" ], [ "coughing", 0 ], [ "incapacitated", 0 ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/C6DLC3InTankTrainCar05.vcd" }  //Tanks on a train.
	],
	group_params = none
}

{
	name = "iMT_TankFactory2%Manager",
	criteria =
	[
		[ "concept", "iMT_TankFactory2" ], [ "who", "Manager" ], [ "coughing", 0 ], [ "incapacitated", 0 ], [ "randomnum", 0, 10 ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/C6DLC3InTankTrainCar03.vcd" }  //You're welcome.
		{ scenename = "scenes/Manager/C6DLC3InTankTrainCar04.vcd" }  //You're welcome.
	],
	group_params = none
}

//--------------------------------------------------------------------------------------------------
// Overrides
//--------------------------------------------------------------------------------------------------

{
	name = "iMT_PlayerAnswerLostCallManager",
	criteria =
	[
		[ "concept", "PlayerAnswerLostCall" ], [ "who", "Manager" ], [ "coughing", 0 ], [ "numberofteamalive", 4, null ], [ "numberofteamdead", 0 ], [ "disttoclosestsurvivor", 0, 499 ], [ "randomnum", 0, 10 ], [ IsTalk ], [ IsTalkManager ], [ IsWorldTalkManager ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/ScenarioJoinLast01.vcd" }  //We're all here!
	],
	group_params = none
}

{
	name = "iMT_PlayerHeardBoomerManager",
	criteria =
	[
		[ "concept", "PlayerHeardBoomer" ], [ "who", "Manager" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkManager ], [ IsWorldTalkManager ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/HeardBoomer01.vcd" }  //Watch your fire, I hear a Boomer.
		{ scenename = "scenes/Manager/HeardBoomer02.vcd" }  //I hear a Boomer.
		{ scenename = "scenes/Manager/HeardBoomer03.vcd" }  //Careful, there's a Boomer's around.
		{ scenename = "scenes/Manager/HeardBoomer04.vcd" }  //I hear a Boomer.
		{ scenename = "scenes/Manager/HeardBoomer05.vcd" }  //Careful, I hear a Boomer.
		{ scenename = "scenes/Manager/HeardBoomer06.vcd" }  //Watch it, I hear a Boomer.
		{ scenename = "scenes/Manager/HeardBoomer07.vcd" }  //Heads up, man, I hear a Boomer.
		{ scenename = "scenes/Manager/HeardBoomer08.vcd" }  //Ah, man, that sounds like a Boomer.
		{ scenename = "scenes/Manager/HeardBoomer09.vcd" }  //Look out, we got a Boomer around here.
		{ scenename = "scenes/Manager/HeardBoomer10.vcd" }  //I definitely hear a Boomer.
		{ scenename = "scenes/Manager/HeardBoomer11.vcd" }  //Watch your fire, I hear a Boomer.
		{ scenename = "scenes/Manager/HeardBoomer12.vcd" }  //Careful, there's a Boomer's around.
		{ scenename = "scenes/Manager/HeardBoomer13.vcd" }  //I hear a Boomer.
		{ scenename = "scenes/Manager/HeardBoomer14.vcd" }  //Careful, I hear a Boomer.
		{ scenename = "scenes/Manager/HeardBoomer15.vcd" }  //Watch it, I hear a Boomer.
		{ scenename = "scenes/Manager/HeardBoomer16.vcd" }  //Heads up, man, I hear a Boomer.
		{ scenename = "scenes/Manager/HeardBoomer17.vcd" }  //Ah, man, that sounds like a Boomer.
		{ scenename = "scenes/Manager/HeardBoomer18.vcd" }  //Look out, we got a Boomer around here.
		{ scenename = "scenes/Manager/HeardBoomer19.vcd" }  //I definitely hear a Boomer.
	],
	group_params = none
}

{
	name = "iMT_PlayerHeardHunterManager",
	criteria =
	[
		[ "concept", "PlayerHeardHunter" ], [ "who", "Manager" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkManager ], [ IsWorldTalkManager ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/HeardHunter01.vcd" }  //Watch your back, I hear a Hunter.
		{ scenename = "scenes/Manager/HeardHunter02.vcd" }  //Careful, I hear a Hunter.
		{ scenename = "scenes/Manager/HeardHunter03.vcd" }  //I hear a Hunter.
		{ scenename = "scenes/Manager/HeardHunter04.vcd" }  //There's a Hunter out there.
		{ scenename = "scenes/Manager/HeardHunter05.vcd" }  //Careful now, there's a Hunter around here.
		{ scenename = "scenes/Manager/HeardHunter06.vcd" }  //Watch your back, I hear a Hunter.
		{ scenename = "scenes/Manager/HeardHunter07.vcd" }  //Careful, I hear a Hunter.
		{ scenename = "scenes/Manager/HeardHunter08.vcd" }  //I hear a Hunter.
		{ scenename = "scenes/Manager/HeardHunter09.vcd" }  //There's a Hunter out there.
		{ scenename = "scenes/Manager/HeardHunter10.vcd" }  //Careful now, there's a hunter around here.
	],
	group_params = none
}

{
	name = "iMT_PlayerHeardSmokerManager",
	criteria =
	[
		[ "concept", "PlayerHeardSmoker" ], [ "who", "Manager" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkManager ], [ IsWorldTalkManager ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/HeardSmoker01.vcd" }  //There's a Smoker around here.
		{ scenename = "scenes/Manager/HeardSmoker02.vcd" }  //Smoker - somewhere around here.
		{ scenename = "scenes/Manager/HeardSmoker03.vcd" }  //Careful, I smell a Smoker.
		{ scenename = "scenes/Manager/HeardSmoker04.vcd" }  //I hear a Smoker.
		{ scenename = "scenes/Manager/HeardSmoker05.vcd" }  //There's a Smoker around here.
		{ scenename = "scenes/Manager/HeardSmoker06.vcd" }  //Smoker - somewhere around here.
		{ scenename = "scenes/Manager/HeardSmoker07.vcd" }  //Careful, I smell a Smoker.
		{ scenename = "scenes/Manager/HeardSmoker08.vcd" }  //I hear a Smoker.
	],
	group_params = none
}

{
	name = "iMT_PlayerHeardWitchManager",
	criteria =
	[
		[ "concept", "PlayerHeardWitch" ], [ "who", "Manager" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkManager ], [ IsWorldTalkManager ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/HeardWitch01.vcd" }  //Shhh, I hear a Witch.
		{ scenename = "scenes/Manager/HeardWitch02.vcd" }  //I hear a Witch.
		{ scenename = "scenes/Manager/HeardWitch03.vcd" }  //I hear a damn Witch.
		{ scenename = "scenes/Manager/HeardWitch04.vcd" }  //There's a Witch around here.
		{ scenename = "scenes/Manager/HeardWitch05.vcd" }  //Hold on, hold on, shhh, that's a witch!
		{ scenename = "scenes/Manager/HeardWitch06.vcd" }  //Ahh damn, a witch is around here.
	],
	group_params = none
}

{
	name = "iMT_PlayerHeardWitch%Manager",
	criteria =
	[
		[ "concept", "PlayerHeardWitch" ], [ "who", "Manager" ], [ "coughing", 0 ], [ "randomnum", 0, 5 ], [ IsTalk ], [ IsTalkManager ], [ IsWorldTalkManager ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/HeardWitch07.vcd" }  //Stop, Stop, Stop - I hear a witch.
	],
	group_params = none
}

{
	name = "iMT_PlayerHurrahManager",
	criteria =
	[
		[ "concept", "PlayerHurrah" ], [ "who", "Manager" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkManager ], [ IsWorldTalkManager ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/Hurrah05.vcd", followup = RThen( "any", "HurrahAlso", null, 0.3 ) }  //We're going to be okay.
		{ scenename = "scenes/Manager/Hurrah06.vcd", followup = RThen( "any", "HurrahAlso", null, 0.3 ) }  //We're going to be okay!
		{ scenename = "scenes/Manager/Hurrah07.vcd" }  //Man, I think we're gonna make it.
		{ scenename = "scenes/Manager/Hurrah08.vcd", followup = RThen( "any", "HurrahAlso", null, 0.3 ) }  //They can't stop us now.
		{ scenename = "scenes/Manager/Hurrah09.vcd", followup = RThen( "any", "HurrahAlso", null, 0.3 ) }  //Nothing can stop us.
		{ scenename = "scenes/Manager/Hurrah10.vcd", followup = RThen( "any", "HurrahAlso", null, 0.3 ) }  //Nothing can stop us, do you hear me? Nothing can stop us!
		{ scenename = "scenes/Manager/Hurrah11.vcd", followup = RThen( "any", "HurrahAlso", null, 0.3 ) }  //We are unstoppable.
		{ scenename = "scenes/Manager/Hurrah12.vcd", followup = RThen( "any", "HurrahAlso", null, 0.3 ) }  //That's right, we should call ourselves the unstoppables.
		{ scenename = "scenes/Manager/Hurrah13.vcd", followup = RThen( "any", "HurrahAlso", null, 0.3 ) }  //We are unstoppable.
		{ scenename = "scenes/Manager/Hurrah16.vcd", followup = RThen( "any", "HurrahAlso", null, 0.3 ) }  //I am bad, yes I am bad, YES I AM! WOO!
	],
	group_params = none
}

{
	name = "iMT_PlayerLaughManager",
	criteria =
	[
		[ "concept", "PlayerLaugh" ], [ "who", "Manager" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkManager ], [ IsWorldTalkManager ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/Laughter04.vcd" }  //<Hearty Laugh>
		{ scenename = "scenes/Manager/Laughter05.vcd" }  //<Hearty Laugh>
		{ scenename = "scenes/Manager/Laughter13.vcd" }  //<Hearty Laugh>
		{ scenename = "scenes/Manager/Laughter14.vcd" }  //<Hearty Laugh>
		{ scenename = "scenes/Manager/Laughter16.vcd" }  //<Short laugh>
		{ scenename = "scenes/Manager/Laughter17.vcd" }  //<Short laugh>
		{ scenename = "scenes/Manager/Laughter18.vcd" }  //<Short laugh>
		{ scenename = "scenes/Manager/Laughter20.vcd" }  //<Hearty Laugh>
		{ scenename = "scenes/Manager/Laughter21.vcd" }  //<Hearty Laugh>
	],
	group_params = none
}

{
	name = "iMT_PlayerLaughAloneManager",
	criteria =
	[
		[ "concept", "PlayerLaugh" ], [ "who", "Manager" ], [ "coughing", 0 ], [ "numberofteamalive", 1 ], [ "onthirdstrike", 1 ], [ IsTalk ], [ IsTalkManager ], [ IsWorldTalkManager ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/Laughter02.vcd" }  //<Nervous laugh>
		{ scenename = "scenes/Manager/Laughter06.vcd" }  //<Short laugh>
		{ scenename = "scenes/Manager/Laughter07.vcd" }  //<Short laugh>
	],
	group_params = none
}

{
	name = "iMT_PlayerRelaxedSighManager",
	criteria =
	[
		[ "concept", "RelaxedSigh" ], [ "who", "Manager" ], [ "speaking", 1 ]
	],
	responses =
	[
		{ scenename = "" }
	],
	group_params = none
}

{
	name = "iMT_PlayerThanksBikerManager",
	criteria =
	[
		[ "concept", "PlayerThanks" ], [ "who", "Manager" ], [ "coughing", 0 ], [ "subject", "Biker" ], [ "dist_from_subject", 0, 99 ], [ "randomnum", 0, 30 ], [ IsTalk ], [ IsTalkManager ], [ IsWorldTalkManager ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/ToTheRescueThanks02.vcd" }  //Thanks, man!
	],
	group_params = none
}

{
	name = "iMT_PlayerThanksNamVetManager",
	criteria =
	[
		[ "concept", "PlayerThanks" ], [ "who", "Manager" ], [ "coughing", 0 ], [ "subject", "NamVet" ], [ "dist_from_subject", 0, 99 ], [ "randomnum", 0, 30 ], [ IsTalk ], [ IsTalkManager ], [ IsWorldTalkManager ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/ToTheRescueThanks03.vcd" }  //Yo, thanks, man.
	],
	group_params = none
}

{
	name = "iMT_PlayerThanksTeenGirlManager",
	criteria =
	[
		[ "concept", "PlayerThanks" ], [ "who", "Manager" ], [ "coughing", 0 ], [ "subject", "TeenGirl" ], [ "dist_from_subject", 0, 99 ], [ "randomnum", 0, 30 ], [ IsTalk ], [ IsTalkManager ], [ IsWorldTalkManager ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/Thanks13.vcd" }  //Girl, thanks.
	],
	group_params = none
}

{
	name = "iMT_ResponseSoftDispleasureSwearManager",
	criteria =
	[
		[ "concept", "ResponseSoftDispleasureSwear" ], [ "who", "Manager" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkManager ], [ IsWorldTalkManager ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/FallShort02.vcd" }  //Ohhh nooooo!
		{ scenename = "scenes/Manager/NegativeNoise01.vcd" }  //[Improv non-verbal displeasure & frustration sounds]
		{ scenename = "scenes/Manager/NegativeNoise02.vcd" }  //[Improv non-verbal displeasure & frustration sounds]
		{ scenename = "scenes/Manager/NegativeNoise03.vcd" }  //[Improv non-verbal displeasure & frustration sounds]
		{ scenename = "scenes/Manager/PositiveNoise04.vcd" }  //[Improv non-verbal pleasure & interest sounds]
		{ scenename = "scenes/Manager/ReactionApprehensive01.vcd" }  //I have a bad feeling about this.
		{ scenename = "scenes/Manager/ReactionApprehensive03.vcd" }  //I don't like this one damn bit.
		{ scenename = "scenes/Manager/ReactionNegative01.vcd" }  //Uh oh.
		{ scenename = "scenes/Manager/ReactionNegative04.vcd" }  //Ah, Jesus.
	],
	group_params = none
}

{
	name = "iMT_SurvivorAskForHealthManager",
	criteria =
	[
		[ "concept", "AskForHealth2" ], [ "who", "Manager" ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/GoingToDieAskForHeal01.vcd" }  //Someone got a first aid kit?
		{ scenename = "scenes/Manager/GoingToDieAskForHeal02.vcd" }  //Can anybody spare a kit?
		{ scenename = "scenes/Manager/GoingToDieAskForHeal03.vcd" }  //I could use a first aid kit.
		{ scenename = "scenes/Manager/GoingToDieAskForHeal04.vcd" }  //I could use some first aid.
	],
	group_params = none
}

{
	name = "iMT_SurvivorAskForHealthBikerManager",
	criteria =
	[
		[ "concept", "AskForHealth2" ], [ "who", "Manager" ], [ "onthirdstrike", 0 ], [ "subject", "Biker" ], [ "dist_from_subject", 0, 399 ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/PlayerSuggestHealthSpecific01.vcd" }  //Francis, can you lend me your med kit?
		{ scenename = "scenes/Manager/PlayerSuggestHealthSpecific02.vcd" }  //Francis, mind spottin' me a med kit?
		{ scenename = "scenes/Manager/PlayerSuggestHealthSpecific03.vcd" }  //Francis, health kit?
	],
	group_params = none
}

{
	name = "iMT_SurvivorAskForHealthNamVetManager",
	criteria =
	[
		[ "concept", "AskForHealth2" ], [ "who", "Manager" ], [ "onthirdstrike", 0 ], [ "subject", "NamVet" ], [ "dist_from_subject", 0, 399 ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/PlayerSuggestHealthSpecific06.vcd" }  //Bill, Bill... first aid kit?
		{ scenename = "scenes/Manager/PlayerSuggestHealthSpecific07.vcd" }  //Bill, could I get some first aid?
	],
	group_params = none
}

{
	name = "iMT_SurvivorAskForHealthTeenGirlManager",
	criteria =
	[
		[ "concept", "AskForHealth2" ], [ "who", "Manager" ], [ "onthirdstrike", 0 ], [ "subject", "TeenGirl" ], [ "dist_from_subject", 0, 399 ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/PlayerSuggestHealthSpecific04.vcd" }  //Zoey, are you going to use that med kit?
		{ scenename = "scenes/Manager/PlayerSuggestHealthSpecific05.vcd" }  //Zoey, any chance I could get some first aid?
	],
	group_params = none
}

{
	name = "iMT_SurvivorCoughingDeathManager",
	criteria =
	[
		[ "concept", "PlayerDeath" ], [ "who", "Manager" ], [ "coughing", 1 ], [ IsTalk ], [ IsTalkManager ], [ IsWorldTalkManager ]
	],
	responses = SurvivorCoughingManager,
	group_params = none
}

{
	name = "iMT_SurvivorDeathManager",
	criteria =
	[
		[ "concept", "PlayerDeath" ], [ "who", "Manager" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkManager ], [ IsWorldTalkManager ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/DeathScream01.vcd" }  //[Death rattle and final breath]
		{ scenename = "scenes/Manager/DeathScream02.vcd" }  //[Loud, painful death scream]
		{ scenename = "scenes/Manager/DeathScream03.vcd" }  //[Loud, painful death scream]
		{ scenename = "scenes/Manager/DeathScream05.vcd" }  //[Loud, painful death scream]
		{ scenename = "scenes/Manager/DeathScream06.vcd" }  //[Short quick death scream]
		{ scenename = "scenes/Manager/DeathScream07.vcd" }  //[Short quick death scream]
		{ scenename = "scenes/Manager/DeathScream08.vcd" }  //[Death rattle and final breath]
		{ scenename = "scenes/Manager/DeathScream09.vcd" }  //[Death rattle and final breath]
		{ scenename = "scenes/Manager/DeathScream10.vcd" }  //[Death rattle and final breath]
	],
	group_params = none
}

{
	name = "iMT_SurvivorDeath%Manager",
	criteria =
	[
		[ "concept", "PlayerDeath" ], [ "who", "Manager" ], [ "coughing", 0 ], [ "randomnum", 1 ], [ IsTalk ], [ IsTalkManager ], [ IsWorldTalkManager ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/DeathScream04.vcd" }  //[Loud, painful death scream]
	],
	group_params = none
}

{
	name = "iMT_SurvivorSpottedAmmoManager",
	criteria =
	[
		[ "concept", "PlayerSpotAmmo" ], [ "who", "Manager" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkManager ], [ IsWorldTalkManager ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/SpotAmmo01.vcd" }  //Ammo here!
	],
	group_params = none
}

{
	name = "iMT_SurvivorSpottedBoomerManager",
	criteria =
	[
		[ "concept", "PlayerWarnBoomer" ], [ "who", "Manager" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkManager ], [ IsWorldTalkManager ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/WarnBoomer01.vcd" }  //BOOMER!
		{ scenename = "scenes/Manager/WarnBoomer02.vcd" }  //BOOMER!
		{ scenename = "scenes/Manager/WarnBoomer03.vcd" }  //BOOMER!
	],
	group_params = none
}

{
	name = "iMT_SurvivorSpottedChargerManager",
	criteria =
	[
		[ "concept", "PlayerWarnCharger" ], [ "who", "Manager" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkManager ], [ IsWorldTalkManager ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/DLC1_L4D1Charger01.vcd" }  //CHARGER!
		{ scenename = "scenes/Manager/DLC1_L4D1Charger02.vcd" }  //CHARGER!
		{ scenename = "scenes/Manager/DLC1_L4D1Charger03.vcd" }  //CHARGER!
	],
	group_params = none
}

{
	name = "iMT_SurvivorSpottedHunterManager",
	criteria =
	[
		[ "concept", "PlayerWarnHunter" ], [ "who", "Manager" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkManager ], [ IsWorldTalkManager ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/WarnHunter01.vcd" }  //HUNTER!
		{ scenename = "scenes/Manager/WarnHunter02.vcd" }  //HUNTER!
		{ scenename = "scenes/Manager/WarnHunter03.vcd" }  //HUNTER!
	],
	group_params = none
}

{
	name = "iMT_SurvivorSpottedInfectedManager",
	criteria =
	[
		[ "concept", "PlayerIncoming" ], [ "who", "Manager" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkManager ], [ IsWorldTalkManager ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/Incoming01.vcd" }  //Here they come!
		{ scenename = "scenes/Manager/Incoming02.vcd" }  //They're comin'!
		{ scenename = "scenes/Manager/Incoming03.vcd" }  //Incoming!
	],
	group_params = none
}

{
	name = "iMT_SurvivorSpottedInfected%Manager",
	criteria =
	[
		[ "concept", "PlayerIncoming" ], [ "who", "Manager" ], [ "coughing", 0 ], [ "randomnum", 0, 5 ], [ IsTalk ], [ IsTalkManager ], [ IsWorldTalkManager ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/HordeAttack02.vcd" }  //Oh my god, here they come!
		{ scenename = "scenes/Manager/HordeAttack03.vcd" }  //They're coming! You guys ready?
		{ scenename = "scenes/Manager/Incoming04.vcd" }  //Oh shit, here they come!
	],
	group_params = none
}

{
	name = "iMT_SurvivorSpottedJockeyManager",
	criteria =
	[
		[ "concept", "PlayerWarnJockey" ], [ "who", "Manager" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkManager ], [ IsWorldTalkManager ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/DLC1_L4D1Jockey01.vcd" }  //JOCKEY!
		{ scenename = "scenes/Manager/DLC1_L4D1Jockey02.vcd" }  //JOCKEY!
		{ scenename = "scenes/Manager/DLC1_L4D1Jockey03.vcd" }  //JOCKEY!
	],
	group_params = none
}

{
	name = "iMT_SurvivorSpottedSmokerManager",
	criteria =
	[
		[ "concept", "PlayerWarnSmoker" ], [ "who", "Manager" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkManager ], [ IsWorldTalkManager ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/WarnSmoker01.vcd" }  //SMOKER!
		{ scenename = "scenes/Manager/WarnSmoker02.vcd" }  //SMOKER!
		{ scenename = "scenes/Manager/WarnSmoker03.vcd" }  //SMOKER!
	],
	group_params = none
}

{
	name = "iMT_SurvivorSpottedSpitterManager",
	criteria =
	[
		[ "concept", "PlayerWarnSpitter" ], [ "who", "Manager" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkManager ], [ IsWorldTalkManager ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/DLC1_L4D1Spitter01.vcd" }  //SPITTER!
		{ scenename = "scenes/Manager/DLC1_L4D1Spitter02.vcd" }  //SPITTER!
		{ scenename = "scenes/Manager/DLC1_L4D1Spitter03.vcd" }  //SPITTER!
	],
	group_params = none
}

{
	name = "iMT_SurvivorSpottedTankManager",
	criteria =
	[
		[ "concept", "PlayerWarnTank" ], [ "who", "Manager" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkManager ], [ IsWorldTalkManager ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/WarnTank01.vcd" }  //TANK!
		{ scenename = "scenes/Manager/WarnTank02.vcd" }  //TANK!
		{ scenename = "scenes/Manager/WarnTank03.vcd" }  //TANK!
	],
	group_params = none
}

{
	name = "iMT_SurvivorSpottedTanks2Manager",
	criteria =
	[
		[ "concept", "PlayerWarnTank" ], [ "who", "Manager" ], [ "coughing", 0 ], [ "tankactive", 1 ], [ IsTalk ], [ IsTalkManager ], [ IsWorldTalkManager ], [ IsZombiePresentTanks2 ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/DLC1_L4D1Tank05.vcd" }  //TWO TANKS!
	],
	group_params = none
}

{
	name = "iMT_SurvivorSpottedWeaponsManager",
	criteria =
	[
		[ "concept", "PlayerSpotOtherWeapon" ], [ "who", "Manager" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkManager ], [ IsWorldTalkManager ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/SpotWeapons01.vcd" }  //Weapons here!
		{ scenename = "scenes/Manager/SpotWeapons02.vcd" }  //Weapons over here!
		{ scenename = "scenes/Manager/SpotWeapons03.vcd" }  //Weapons!
	],
	group_params = none
}

{
	name = "iMT_SurvivorSpottedWitchManager",
	criteria =
	[
		[ "concept", "PlayerWarnWitch" ], [ "who", "Manager" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkManager ], [ IsWorldTalkManager ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/WarnWitch01.vcd" }  //WITCH!
		{ scenename = "scenes/Manager/WarnWitch02.vcd" }  //WITCH!
		{ scenename = "scenes/Manager/WarnWitch03.vcd" }  //WITCH!
	],
	group_params = none
}

{
	name = "iMT_SurvivorTauntResponseManager",
	criteria =
	[
		[ "concept", "PlayerTaunt" ], [ "who", "Manager" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkManager ], [ IsWorldTalkManager ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/Hurrah01.vcd" }  //Aw riiiight!
		{ scenename = "scenes/Manager/Hurrah02.vcd" }  //Woo baby, aw riiiight!
		{ scenename = "scenes/Manager/Hurrah03.vcd" }  //Hell yeah.
		{ scenename = "scenes/Manager/Hurrah14.vcd" }  //YEAH!
		{ scenename = "scenes/Manager/Hurrah15.vcd" }  //YEAH WOO!
		{ scenename = "scenes/Manager/PositiveNoise02.vcd" }  //[Improv non-verbal pleasure & interest sounds]
		{ scenename = "scenes/Manager/PositiveNoise03.vcd" }  //[Improv non-verbal pleasure & interest sounds]
		{ scenename = "scenes/Manager/ReactionPositive05.vcd" }  //Allright!
		{ scenename = "scenes/Manager/ReactionPositive06.vcd" }  //Heh hehhhh.
		{ scenename = "scenes/Manager/ReactionPositive07.vcd" }  //Nice!
		{ scenename = "scenes/Manager/ReactionPositive09.vcd" }  //Sweet, baby!
		{ scenename = "scenes/Manager/ReactionPositive10.vcd" }  //That's what I'm talkin' about!
		{ scenename = "scenes/Manager/Taunt01.vcd" }  //That's right!
		{ scenename = "scenes/Manager/Taunt02.vcd" }  //Woo hoo, that's right!
		{ scenename = "scenes/Manager/Taunt03.vcd" }  //Yeah, baby, yeah!
		{ scenename = "scenes/Manager/Taunt04.vcd" }  //Alllright!
		{ scenename = "scenes/Manager/Taunt05.vcd" }  //Oh yeah, who's your momma, who's your daddy?
		{ scenename = "scenes/Manager/Taunt06.vcd" }  //Hell yeah, hell yeah!
		{ scenename = "scenes/Manager/Taunt07.vcd" }  //[loud, evil laugh]
		{ scenename = "scenes/Manager/Taunt08.vcd" }  //[loud, evil laugh]
		{ scenename = "scenes/Manager/Taunt09.vcd" }  //[loud, evil laugh]
		{ scenename = "scenes/Manager/Taunt10.vcd" }  //[loud, evil laugh]
	],
	group_params = none
}

{
	name = "iMT_SurvivorTauntResponse%Manager",
	criteria =
	[
		[ "concept", "PlayerTaunt" ], [ "who", "Manager" ], [ "coughing", 0 ], [ "randomnum", 0, 2 ], [ IsTalk ], [ IsTalkManager ], [ IsWorldTalkManager ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/GenericResponses40.vcd" }  //Hell yeah.
	],
	group_params = none
}

{
	name = "iMT_SurvivorVocalizeBackUpManager",
	criteria =
	[
		[ "concept", "PlayerBackUp" ], [ "who", "Manager" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkManager ], [ IsWorldTalkManager ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/BackUp01.vcd" }  //Back up!
		{ scenename = "scenes/Manager/BackUp02.vcd" }  //Backbackback!
		{ scenename = "scenes/Manager/BackUp03.vcd" }  //Back up!
	],
	group_params = none
}

{
	name = "iMT_SurvivorVocalizeBackUpQuietManager",
	criteria =
	[
		[ "concept", "PlayerBackUp" ], [ "who", "Manager" ], [ "coughing", 0 ], [ "tankactive", 0 ], [ "incombatmusic", 0 ], [ IsTalk ], [ IsTalkManager ], [ IsWorldTalkManager ], [ IsWitchNear ], [ IsNotWitchAggro ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/BackUpQuiet01.vcd" }  //Back up.
		{ scenename = "scenes/Manager/BackUpQuiet02.vcd" }  //Back up, back up.
		{ scenename = "scenes/Manager/BackUpQuiet03.vcd" }  //Move back.
		{ scenename = "scenes/Manager/BackUpQuiet04.vcd" }  //Back up.
	],
	group_params = none
}

{
	name = "iMT_SurvivorVocalizeEmphaticGoManager",
	criteria =
	[
		[ "concept", "PlayerEmphaticGo" ], [ "who", "Manager" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkManager ], [ IsWorldTalkManager ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/EmphaticGo02.vcd" }  //Go go go!
		{ scenename = "scenes/Manager/EmphaticGo03.vcd" }  //Go go GO!
		{ scenename = "scenes/Manager/EmphaticGo04.vcd" }  //GO!
		{ scenename = "scenes/Manager/EmphaticGo05.vcd" }  //MOVE!
		{ scenename = "scenes/Manager/EmphaticGo06.vcd" }  //C'mon go!
		{ scenename = "scenes/Manager/EmphaticGo07.vcd" }  //MOVE!
		{ scenename = "scenes/Manager/EmphaticGo08.vcd" }  //MOVE IT!
		{ scenename = "scenes/Manager/EmphaticGo09.vcd" }  //Move it mooove it!
	],
	group_params = none
}

{
	name = "iMT_SurvivorVocalizeLookOutManager",
	criteria =
	[
		[ "concept", "PlayerLookOut" ], [ "who", "Manager" ], [ "coughing", 0 ], [ "world_auto_finale", 2 ], [ IsTalk ], [ IsTalkManager ], [ IsWorldTalkManager ]
	],
	responses =
	[
		{ scenename = "scenes/Manager/LookOut01.vcd" }  //Look out!
		{ scenename = "scenes/Manager/LookOut02.vcd" }  //Look out!
		{ scenename = "scenes/Manager/LookOut03.vcd" }  //Watch out!
		{ scenename = "scenes/Manager/LookOut04.vcd" }  //Watch out!
		{ scenename = "scenes/Manager/LookOut05.vcd" }  //Heads up!
		{ scenename = "scenes/Manager/LookOut06.vcd" }  //Heads up!
	],
	group_params = none
}

//--------------------------------------------------------------------------------------------------
// Start Area
//--------------------------------------------------------------------------------------------------

{
	name = "iMT_EllisStoryInterruptGenericManager",
	criteria =
	[
		[ "concept", "EllisInterrupt" ], [ "who", "Manager" ], [ "world_auto_tellingstory", 1 ], [ _auto_NotDidInterrupt ]
	],
	responses =
	[
		{
			scenename = "scenes/Manager/GenericResponses25.vcd", followup = RThen( "Mechanic", "EllisStoryReac01", null, 0.3 ),  //Tell me you ain't serious.
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
	name = "iMT_SafeRoomStartManager",
	criteria =
	[
		[ "concept", "TLK_IDLE" ], [ "who", "Manager" ], [ "instartarea", 1 ], [ IsNotScavenge ], [ IsNotSurvival ], [ _auto_NotSafeRoomStart ]
	],
	responses =
	[
		{
			scenename = "scenes/Manager/Blank.vcd",
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

rr_ProcessRules( Manager )