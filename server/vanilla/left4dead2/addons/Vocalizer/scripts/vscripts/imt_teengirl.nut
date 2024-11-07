//--------------------------------------------------------------------------------------------------
// ion's Vocalizer: TeenGirl Response Rules
//--------------------------------------------------------------------------------------------------

// Shared responses

local SurvivorCoughingTeenGirl =
[
	{ scenename = "scenes/TeenGirl/Cough01.vcd" }  //[Coughing from smoke]
	{ scenename = "scenes/TeenGirl/Cough02.vcd" }  //[Coughing from smoke]
	{ scenename = "scenes/TeenGirl/Cough03.vcd" }  //[Coughing from smoke]
	{ scenename = "scenes/TeenGirl/Cough04.vcd" }  //[Coughing from smoke]
	{ scenename = "scenes/TeenGirl/Cough05.vcd" }  //[Coughing from smoke]
	{ scenename = "scenes/TeenGirl/Cough06.vcd" }  //[Coughing from smoke]
]

local SurvivorMournBikerTeenGirl =
[
	{ scenename = "scenes/TeenGirl/GriefBiker01.vcd" }  //Francis!
	{ scenename = "scenes/TeenGirl/GriefBiker02.vcd" }  //Francis! NOOOO!
	{ scenename = "scenes/TeenGirl/GriefBiker04.vcd" }  //Francis!
	{ scenename = "scenes/TeenGirl/GriefBiker06.vcd" }  //God, not Francis!
	{ scenename = "scenes/TeenGirl/GriefBiker07.vcd" }  //Oh God, not Francis!
]

local SurvivorMournManagerTeenGirl =
[
	{ scenename = "scenes/TeenGirl/GriefManager02.vcd" }  //Louis!
	{ scenename = "scenes/TeenGirl/GriefManager03.vcd" }  //Louis, oh god I'm gonna miss you.
	{ scenename = "scenes/TeenGirl/GriefManager08.vcd" }  //Oh no, not Louis!
	{ scenename = "scenes/TeenGirl/GriefManager11.vcd" }  //Oh Louis, oh god I can't believe it.
]

local SurvivorMournNamVetTeenGirl =
[
	{ scenename = "scenes/TeenGirl/GriefVet02.vcd" }  //I ah oh Bill!!!
	{ scenename = "scenes/TeenGirl/GriefVet03.vcd" }  //Oh god. Not Bill!
	{ scenename = "scenes/TeenGirl/GriefVet05.vcd" }  //Bill! No!
	{ scenename = "scenes/TeenGirl/GriefVet07.vcd" }  //Ahh Bill!
	{ scenename = "scenes/TeenGirl/GriefVet09.vcd" }  //Bill!!!
	{ scenename = "scenes/TeenGirl/GriefVet11.vcd" }  //Oh god. Not Bill!
	{ scenename = "scenes/TeenGirl/GriefVet12.vcd" }  //Oh god. Bill!
	{ scenename = "scenes/TeenGirl/GriefVet13.vcd" }  //Bill!
	{ scenename = "scenes/TeenGirl/GriefVet18.vcd" }  //Bill!!!
]

//--------------------------------------------------------------------------------------------------
// Ellis Stories
//--------------------------------------------------------------------------------------------------

local TeenGirl =
[

{
	name = "iMT_EllisStoryInterruptTeenGirl",
	criteria =
	[
		[ "concept", "iMT_EllisStoryInterrupt" ], [ "who", "TeenGirl" ], [ "world_auto_tellingstory", 1 ], [ "coughing", 0 ], [ "incapacitated", 0 ], [ "speaking", 0], [ IsTalk ], [ IsTalkTeenGirl ], [ IsWorldTalkTeenGirl ], [ IssuerCloseEnough ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/C6DLC3FirstSafeRoom01.vcd", followup = RThen( "Mechanic", "iMT_EllisStoryReac", { from = "TeenGirl" }, 0.3 ) }  //I really don't want to hear it.
	],
	group_params = none
}

{
	name = "iMT_EllisStoryStopTeenGirl",
	criteria =
	[
		[ "concept", "iMT_EllisStories" ], [ "who", "TeenGirl" ], [ "world_auto_tellingstory", 1 ]
	],
	responses =
	[
		{
			scenename = "scenes/TeenGirl/C6DLC3Intro08.vcd", followup = RThen( "all", "iMT_EllisStoryStop", null, 0.3 ),  //Whatever, I don't care.
			applycontext =
			{
				c1 = { context = "_auto_tellingstory", value = 0, duration = 0 }
				c2 = { context = "_auto_didinterrupt", value = 1, duration = 0 }
			},
			applycontexttoworld = true
		}

		{
			scenename = "scenes/TeenGirl/C6DLC3Intro09.vcd", followup = RThen( "all", "iMT_EllisStoryStop", null, 0.3 ),  //Whatever, I don't care.
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
	name = "iMT_PlayerAnswerReadyTeenGirl",
	criteria =
	[
		[ "concept", "iMT_PlayerAnswerReady" ], [ "who", "TeenGirl" ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/AnswerReady01.vcd" }  //Ready.
		{ scenename = "scenes/TeenGirl/AnswerReady02.vcd" }  //Yep, I'm ready.
		{ scenename = "scenes/TeenGirl/AnswerReady03.vcd" }  //Yeah, ready.
		{ scenename = "scenes/TeenGirl/AnswerReady04.vcd" }  //Let's go.
		{ scenename = "scenes/TeenGirl/AnswerReady07.vcd" }  //Ready.
		{ scenename = "scenes/TeenGirl/AnswerReady08.vcd" }  //Yep, I'm ready.
		{ scenename = "scenes/TeenGirl/AnswerReady09.vcd" }  //Yeah, ready.
	],
	group_params = none
}

{
	name = "iMT_PlayerAnswerReady%TeenGirl",
	criteria =
	[
		[ "concept", "iMT_PlayerAnswerReady" ], [ "who", "TeenGirl" ], [ "randomnum", 0, 5 ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/AnswerReady05.vcd" }  //Yeah... yeah, I'm ready to bounce. (laughing)
	],
	group_params = none
}

{
	name = "iMT_PlayerBattleCryTeenGirl",
	criteria =
	[
		[ "concept", "iMT_PlayerBattleCry" ], [ "who", "TeenGirl" ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/Taunt02.vcd" }  //Thats right. [grim, determined]
		{ scenename = "scenes/TeenGirl/Taunt20.vcd" }  //YEAH!
		{ scenename = "scenes/TeenGirl/Taunt25.vcd" }  //Oh yeah!
		{ scenename = "scenes/TeenGirl/Taunt28.vcd" }  //Thats right. [grim, determined]
		{ scenename = "scenes/TeenGirl/Taunt29.vcd" }  //Oh yeah, lovely.
		{ scenename = "scenes/TeenGirl/Taunt31.vcd" }  //OH YEAH!
		{ scenename = "scenes/TeenGirl/Taunt34.vcd" }  //Thats right. [grim, determined]
		{ scenename = "scenes/TeenGirl/Taunt39.vcd" }  //YEAHHHH!
	],
	group_params = none
}

{
	name = "iMT_PlayerBreathingTeenGirl",
	criteria =
	[
		[ "concept", "iMT_PlayerBreathing" ], [ "who", "TeenGirl" ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/ExertionCritical01.vcd" }  //[frightened freaked out breathing]
		{ scenename = "scenes/TeenGirl/ExertionCritical02.vcd" }  //[frightened freaked out breathing]
		{ scenename = "scenes/TeenGirl/ExertionCritical03.vcd" }  //[frightened freaked out breathing]
		{ scenename = "scenes/TeenGirl/ExertionCritical04.vcd" }  //[frightened freaked out breathing]
		{ scenename = "scenes/TeenGirl/ExertionMajor01.vcd" }  //[frightened freaked out breathing]
		{ scenename = "scenes/TeenGirl/ExertionMajor02.vcd" }  //[frightened freaked out breathing]
		{ scenename = "scenes/TeenGirl/ExertionMinor01.vcd" }  //[breathing - panting out of breath]
		{ scenename = "scenes/TeenGirl/ExertionMinor02.vcd" }  //[breathing - panting out of breath]
	],
	group_params = none
}

{
	name = "iMT_PlayerCloseTheDoorTeenGirl",
	criteria =
	[
		[ "concept", "iMT_PlayerCloseTheDoor" ], [ "who", "TeenGirl" ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/CloseTheDoor01.vcd" }  //Lock the door.
		{ scenename = "scenes/TeenGirl/CloseTheDoor07.vcd" }  //Close the door.
		{ scenename = "scenes/TeenGirl/CloseTheDoor08.vcd" }  //Please lock the door!
		{ scenename = "scenes/TeenGirl/CloseTheDoor11.vcd" }  //Someone wanna close the door?
		{ scenename = "scenes/TeenGirl/CloseTheDoor16.vcd" }  //Close the door, please! (angry)
		{ scenename = "scenes/TeenGirl/CloseTheDoor17.vcd" }  //Lock that door.
		{ scenename = "scenes/TeenGirl/CloseTheDoor19.vcd" }  //Come on, lock the door.
		{ scenename = "scenes/TeenGirl/CloseTheDoor22.vcd" }  //Can you lock that door?!
	],
	group_params = none
}

{
	name = "iMT_PlayerCloseTheDoorIntenseTeenGirl",
	criteria =
	[
		[ "concept", "iMT_PlayerCloseTheDoor" ], [ "who", "TeenGirl" ], [ "incombatmusic", 1 ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/CloseTheDoor28.vcd" }  //Close the door, please! (angry)
		{ scenename = "scenes/TeenGirl/CloseTheDoor29.vcd" }  //Lock that door.
		{ scenename = "scenes/TeenGirl/CloseTheDoor32.vcd" }  //Come on, lock the door.
		{ scenename = "scenes/TeenGirl/CloseTheDoor33.vcd" }  //Close the door!
		{ scenename = "scenes/TeenGirl/CloseTheDoor41.vcd" }  //Close the door already.
		{ scenename = "scenes/TeenGirl/CloseTheDoor42.vcd" }  //Lock the door.
		{ scenename = "scenes/TeenGirl/CloseTheDoor45.vcd" }  //Can you lock that door?!
		{ scenename = "scenes/TeenGirl/CloseTheDoor50.vcd" }  //Please lock the door!
	],
	group_params = none
}

{
	name = "iMT_PlayerCoughingTeenGirl",
	criteria =
	[
		[ "concept", "iMT_PlayerCoughing" ], [ "who", "TeenGirl" ]
	],
	responses = SurvivorCoughingTeenGirl,
	group_params = none
}

{
	name = "iMT_PlayerDeathScreamTeenGirl",
	criteria =
	[
		[ "concept", "iMT_PlayerDeathScream" ], [ "who", "TeenGirl" ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/Fall01.vcd" }  //[Death scream as you fall]
		{ scenename = "scenes/TeenGirl/Fall02.vcd" }  //[Death scream as you fall]
		{ scenename = "scenes/TeenGirl/Fall03.vcd" }  //[Death scream as you fall]
	],
	group_params = none
}

{
	name = "iMT_PlayerFriendlyFireTeenGirl",
	criteria =
	[
		[ "concept", "iMT_PlayerFriendlyFire" ], [ "who", "TeenGirl" ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/FriendlyFire02.vcd" }  //Hey, that hurt!
		{ scenename = "scenes/TeenGirl/FriendlyFire03.vcd" }  //Watch it!
		{ scenename = "scenes/TeenGirl/FriendlyFire05.vcd" }  //Watch where you're shooting!
		{ scenename = "scenes/TeenGirl/FriendlyFire06.vcd" }  //Stop shooting me!
		{ scenename = "scenes/TeenGirl/FriendlyFire07.vcd" }  //Ow! HEY!
		{ scenename = "scenes/TeenGirl/FriendlyFire08.vcd" }  //Stop it already!
		{ scenename = "scenes/TeenGirl/FriendlyFire10.vcd" }  //Hey!
		{ scenename = "scenes/TeenGirl/FriendlyFire11.vcd" }  //That's not funny.
		{ scenename = "scenes/TeenGirl/FriendlyFire12.vcd" }  //STOP IT!
		{ scenename = "scenes/TeenGirl/FriendlyFire13.vcd" }  //Don't shoot me!
		{ scenename = "scenes/TeenGirl/FriendlyFire14.vcd" }  //Hey, come on! Stop!
		{ scenename = "scenes/TeenGirl/FriendlyFire17.vcd" }  //What the hell?
		{ scenename = "scenes/TeenGirl/FriendlyFire18.vcd" }  //What the!
		{ scenename = "scenes/TeenGirl/FriendlyFire19.vcd" }  //Why would you do that to me?
		{ scenename = "scenes/TeenGirl/FriendlyFire22.vcd" }  //Ow! That hurt!
		{ scenename = "scenes/TeenGirl/FriendlyFire23.vcd" }  //Ow!
		{ scenename = "scenes/TeenGirl/FriendlyFire24.vcd" }  //Why would you do that to me?
	],
	group_params = none
}

{
	name = "iMT_PlayerFriendlyFireFromBikerTeenGirl",
	criteria =
	[
		[ "concept", "iMT_PlayerFriendlyFire" ], [ "who", "TeenGirl" ], [ "subject", "Biker" ], [ "dist_from_subject", 0, 799 ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/TeenGirl_FriendlyFireFrancis02.vcd" }  //Ow. Knock that shit off, Francis.
	],
	group_params = none
}

{
	name = "iMT_PlayerFriendlyFireFromManagerTeenGirl",
	criteria =
	[
		[ "concept", "iMT_PlayerFriendlyFire" ], [ "who", "TeenGirl" ], [ "subject", "Manager" ], [ "dist_from_subject", 0, 799 ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/NameLouis06.vcd" }  //Louis! (loud)
	],
	group_params = none
}

{
	name = "iMT_PlayerFriendlyFireFromNamVetTeenGirl",
	criteria =
	[
		[ "concept", "iMT_PlayerFriendlyFire" ], [ "who", "TeenGirl" ], [ "subject", "NamVet" ], [ "dist_from_subject", 0, 799 ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/TeenGirl_FriendlyFireBill01.vcd" }  //Bill, come on Bill!
		{ scenename = "scenes/TeenGirl/TeenGirl_FriendlyFireBill02.vcd" }  //Ow. Dammit. Bill!
	],
	group_params = none
}

{
	name = "iMT_PlayerGetToVehicleBoatTeenGirl",
	criteria =
	[
		[ "concept", "iMT_PlayerGetToVehicleBoat" ], [ "who", "TeenGirl" ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/ArriveBoat01.vcd" }  //Get to the boat!
		{ scenename = "scenes/TeenGirl/ArriveBoat02.vcd" }  //Come on! To the boat!
		{ scenename = "scenes/TeenGirl/ArriveBoat03.vcd" }  //Run to the boat!
		{ scenename = "scenes/TeenGirl/ArriveBoat04.vcd" }  //We have to make it to the boat!
		{ scenename = "scenes/TeenGirl/ArriveBoat08.vcd" }  //We have to make it to the boat!
		{ scenename = "scenes/TeenGirl/ArriveBoatInitial01.vcd" }  //Boat's here, let's go!
		{ scenename = "scenes/TeenGirl/ArriveBoatInitial02.vcd" }  //The boat's here! Come on, let's go!
		{ scenename = "scenes/TeenGirl/ArriveBoatInitial05.vcd" }  //Boat's here! Come on, let's go!
	],
	group_params = none
}

{
	name = "iMT_PlayerGetToVehicleChopperTeenGirl",
	criteria =
	[
		[ "concept", "iMT_PlayerGetToVehicleChopper" ], [ "who", "TeenGirl" ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/ArriveChopper01.vcd" }  //Everyone in the helicopter!
		{ scenename = "scenes/TeenGirl/ArriveChopper02.vcd" }  //Come on, get to the helicopter!
		{ scenename = "scenes/TeenGirl/ArriveChopperInitial01.vcd" }  //Guys, the helicopter's here. Let's go!
		{ scenename = "scenes/TeenGirl/ArriveChopperInitial02.vcd" }  //The helicopter's here! Come on, let's go!
	],
	group_params = none
}

{
	name = "iMT_PlayerGetToVehicleWheelsTeenGirl",
	criteria =
	[
		[ "concept", "iMT_PlayerGetToVehicleWheels" ], [ "who", "TeenGirl" ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/ArriveTruck01.vcd" }  //Everyone in the truck!
		{ scenename = "scenes/TeenGirl/ArriveTruck02.vcd" }  //Get to the truck!
		{ scenename = "scenes/TeenGirl/ArriveTruckInitial01.vcd" }  //The truck's here! Let's go!
	],
	group_params = none
}

{
	name = "iMT_PlayerGoingToDieTeenGirl",
	criteria =
	[
		[ "concept", "iMT_PlayerGoingToDie" ], [ "who", "TeenGirl" ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/GoingToDie01.vcd" }  //I don't feel so hot.
		{ scenename = "scenes/TeenGirl/GoingToDie04.vcd" }  //I'm not doing so good, guys.
		{ scenename = "scenes/TeenGirl/GoingToDie07.vcd" }  //This is really bad.
		{ scenename = "scenes/TeenGirl/GoingToDie10.vcd" }  //Guys, I'm really torn up.
		{ scenename = "scenes/TeenGirl/GoingToDie27.vcd" }  //I think I hurt something bad, real bad.
		{ scenename = "scenes/TeenGirl/GoingToDie38.vcd" }  //This is not going well.
		{ scenename = "scenes/TeenGirl/GoingToDie42.vcd" }  //Ohh, man, I feel like crap.
		{ scenename = "scenes/TeenGirl/GoingToDie44.vcd" }  //Guys? I'm pretty hurt.
		{ scenename = "scenes/TeenGirl/GoingToDie45.vcd" }  //Ohh... this is really starting to hurt.
		{ scenename = "scenes/TeenGirl/GoingToDie48.vcd" }  //I'm really hurt, guys.
		{ scenename = "scenes/TeenGirl/GoingToDie49.vcd" }  //I think I really hurt something.
		{ scenename = "scenes/TeenGirl/GoingToDie50.vcd" }  //I just wanna go home.
		{ scenename = "scenes/TeenGirl/GoingToDie52.vcd" }  //I'm not feeling real hot.
		{ scenename = "scenes/TeenGirl/GoingToDie53.vcd" }  //Ohh, I feel terrible.
		{ scenename = "scenes/TeenGirl/GoingToDie54.vcd" }  //I feel awful.
		{ scenename = "scenes/TeenGirl/GoingToDie57.vcd" }  //God, this really hurts.
		{ scenename = "scenes/TeenGirl/GoingToDie58.vcd" }  //Ohhhh God, I'm really hurt.
		{ scenename = "scenes/TeenGirl/GoingToDieLight06.vcd" }  //I feel like crap.
		{ scenename = "scenes/TeenGirl/GoingToDieLight07.vcd" }  //Goddammit, this hurts.
		{ scenename = "scenes/TeenGirl/GoingToDieLight11.vcd" }  //Oh, jesus, I've got tooth marks on me.
		{ scenename = "scenes/TeenGirl/GoingToDieLight12.vcd" }  //I hope I'm immune to tetanus too.
		{ scenename = "scenes/TeenGirl/GoingToDieLight13.vcd" }  //Ow, ow ow ow.
	],
	group_params = none
}

{
	name = "iMT_PlayerGoingToDie3TeenGirl",
	criteria =
	[
		[ "concept", "iMT_PlayerGoingToDie" ], [ "who", "TeenGirl" ], [ "onthirdstrike", 1 ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/GoingToDie302.vcd" }  //I don't know if I am going to make it.
		{ scenename = "scenes/TeenGirl/GoingToDie314.vcd" }  //Guys, I don't think I'm going to make it without any help.
		{ scenename = "scenes/TeenGirl/GoingToDie362.vcd" }  //I need some help or I'm going to die.
		{ scenename = "scenes/TeenGirl/GoingToDie363.vcd" }  //I go down again and I'm dead.
		{ scenename = "scenes/TeenGirl/GoingToDie370.vcd" }  //Oh god, I'm gonna die!
	],
	group_params = none
}

{
	name = "iMT_PlayerGooedBySpitterTeenGirl",
	criteria =
	[
		[ "concept", "iMT_PlayerGooedBySpitter" ], [ "who", "TeenGirl" ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/EmphaticGo08.vcd" }  //Go!
		{ scenename = "scenes/TeenGirl/ReactionDisgusted04.vcd" }  //Ewwww...
		{ scenename = "scenes/TeenGirl/ReactionDisgusted09.vcd" }  //Gross!
		{ scenename = "scenes/TeenGirl/Swear02.vcd" }  //Shit.
		{ scenename = "scenes/TeenGirl/Swear06.vcd" }  //Mother.
		{ scenename = "scenes/TeenGirl/Swear09.vcd" }  //Ah bullshit.
		{ scenename = "scenes/TeenGirl/Swear13.vcd" }  //Goddammit.
	],
	group_params = none
}

{
	name = "iMT_PlayerHelloTeenGirl",
	criteria =
	[
		[ "concept", "iMT_PlayerHello" ], [ "who", "TeenGirl" ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/ScenarioJoin02.vcd" }  //Hello!
		{ scenename = "scenes/TeenGirl/ScenarioJoin07.vcd" }  //Hello!
		{ scenename = "scenes/TeenGirl/ScenarioJoin12.vcd" }  //Hello!
	],
	group_params = none
}

{
	name = "iMT_PlayerIncapacitatedHurtTeenGirl",
	criteria =
	[
		[ "concept", "iMT_PlayerIncapacitatedHurt" ], [ "who", "TeenGirl" ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/HurtCritical01.vcd" }  //[pain noise - loud major pain]
		{ scenename = "scenes/TeenGirl/HurtCritical02.vcd" }  //[pain noise - loud major pain]
		{ scenename = "scenes/TeenGirl/HurtCritical03.vcd" }  //[pain noise - loud major pain]
		{ scenename = "scenes/TeenGirl/HurtCritical04.vcd" }  //[pain noise - loud major pain]
		{ scenename = "scenes/TeenGirl/HurtCritical05.vcd" }  //[pain noise - loud major pain]
		{ scenename = "scenes/TeenGirl/HurtCritical06.vcd" }  //[pain noise - loud major pain]
		{ scenename = "scenes/TeenGirl/HurtCritical07.vcd" }  //[pain noise - loud major pain]
		{ scenename = "scenes/TeenGirl/IncapacitatedInjury01.vcd" }  //AHHHHH [terrified yell]
		{ scenename = "scenes/TeenGirl/IncapacitatedInjury02.vcd" }  //AHHHHH [terrified yell]
		{ scenename = "scenes/TeenGirl/IncapacitatedInjury03.vcd" }  //AHHHHH [terrified yell]
		{ scenename = "scenes/TeenGirl/IncapacitatedInjury04.vcd" }  //AHHHHH [terrified yell]
	],
	group_params = none
}

{
	name = "iMT_PlayerKillConfirmationTeenGirl",
	criteria =
	[
		[ "concept", "iMT_PlayerKilledZombie" ], [ "who", "TeenGirl" ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/KillConfirmation01.vcd" }  //Got it!
		{ scenename = "scenes/TeenGirl/KillConfirmation03.vcd" }  //Nailed it!
		{ scenename = "scenes/TeenGirl/KillConfirmation04.vcd" }  //Got 'em!
		{ scenename = "scenes/TeenGirl/KillConfirmation05.vcd" }  //Got it!
		{ scenename = "scenes/TeenGirl/KillConfirmation06.vcd" }  //Got 'em!
		{ scenename = "scenes/TeenGirl/KillConfirmation08.vcd" }  //Got 'em!
	],
	group_params = none
}

{
	name = "iMT_PlayerMeleeTeenGirl",
	criteria =
	[
		[ "concept", "iMT_PlayerMelee" ], [ "who", "TeenGirl" ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/Shoved01.vcd" }  //[Melee grunt]
		{ scenename = "scenes/TeenGirl/Shoved02.vcd" }  //[Melee grunt]
		{ scenename = "scenes/TeenGirl/Shoved03.vcd" }  //[Melee grunt]
		{ scenename = "scenes/TeenGirl/Shoved04.vcd" }  //[Melee grunt]
		{ scenename = "scenes/TeenGirl/Shoved05.vcd" }  //[Melee grunt]
		{ scenename = "scenes/TeenGirl/Shoved06.vcd" }  //[Melee grunt]
		{ scenename = "scenes/TeenGirl/Shoved14.vcd" }  //[Melee grunt]
	],
	group_params = none
}

{
	name = "iMT_PlayerMournBikerAliveTeenGirl",
	criteria =
	[
		[ "concept", "iMT_PlayerMourn" ], [ "who", "TeenGirl" ], [ "isbikeralive", 1 ], [ "subject", "Biker" ], [ "dist_from_subject", 0, 199 ]
	],
	responses = SurvivorMournBikerTeenGirl,
	group_params = none
}

{
	name = "iMT_PlayerMournBikerDeadTeenGirl",
	criteria =
	[
		[ "concept", "iMT_PlayerMourn" ], [ "who", "TeenGirl" ], [ "isbikeralive", 0 ], [ "disttobiker", 0, 199 ]
	],
	responses = SurvivorMournBikerTeenGirl,
	group_params = none
}

{
	name = "iMT_PlayerMournManagerAliveTeenGirl",
	criteria =
	[
		[ "concept", "iMT_PlayerMourn" ], [ "who", "TeenGirl" ], [ "ismanageralive", 1 ], [ "subject", "Manager" ], [ "dist_from_subject", 0, 199 ]
	],
	responses = SurvivorMournManagerTeenGirl,
	group_params = none
}

{
	name = "iMT_PlayerMournManagerDeadTeenGirl",
	criteria =
	[
		[ "concept", "iMT_PlayerMourn" ], [ "who", "TeenGirl" ], [ "ismanageralive", 0 ], [ "disttomanager", 0, 199 ]
	],
	responses = SurvivorMournManagerTeenGirl,
	group_params = none
}

{
	name = "iMT_PlayerMournNamVetAliveTeenGirl",
	criteria =
	[
		[ "concept", "iMT_PlayerMourn" ], [ "who", "TeenGirl" ], [ "isnamvetalive", 1 ], [ "subject", "NamVet" ], [ "dist_from_subject", 0, 199 ]
	],
	responses = SurvivorMournNamVetTeenGirl,
	group_params = none
}

{
	name = "iMT_PlayerMournNamVetDeadTeenGirl",
	criteria =
	[
		[ "concept", "iMT_PlayerMourn" ], [ "who", "TeenGirl" ], [ "isnamvetalive", 0 ], [ "disttonamvet", 0, 199 ]
	],
	responses = SurvivorMournNamVetTeenGirl,
	group_params = none
}

{
	name = "iMT_PlayerNearExitTeenGirl",
	criteria =
	[
		[ "concept", "iMT_PlayerNearExit" ], [ "who", "TeenGirl" ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/FinaleAhead01.vcd" }  //Hey guys, I think we're almost there.
		{ scenename = "scenes/TeenGirl/FinaleAhead02.vcd" }  //Thank god, we're almost outta here!
		{ scenename = "scenes/TeenGirl/FinaleAhead03.vcd" }  //Finally. You see that?  We're almost out of here!
		{ scenename = "scenes/TeenGirl/FinaleAhead04.vcd" }  //This is all going to be over soon.
		{ scenename = "scenes/TeenGirl/SafeSpotAhead01.vcd", followup = RThen( "any", "iMT_PlayerNearExitReac", { from = "TeenGirl" }, 0.3 ) }  //Safe house just ahead.
		{ scenename = "scenes/TeenGirl/SafeSpotAhead06.vcd", followup = RThen( "any", "iMT_PlayerNearExitReac", { from = "TeenGirl" }, 0.3 ) }  //Safe house ahead!
		{ scenename = "scenes/TeenGirl/SafeSpotAhead08.vcd", followup = RThen( "any", "iMT_PlayerNearExitReac", { from = "TeenGirl" }, 0.3 ) }  //There's a safe house ahead.
		{ scenename = "scenes/TeenGirl/SafeSpotAhead09.vcd", followup = RThen( "any", "iMT_PlayerNearExitReac", { from = "TeenGirl" }, 0.3 ) }  //We're near a safe house.
		{ scenename = "scenes/TeenGirl/WorldSmallTown0320.vcd", followup = RThen( "any", "iMT_PlayerNearExitReac", { from = "TeenGirl" }, 0.3 ) }  //Yeah! Safehouse right up ahead, boys! We made it!
	],
	group_params = none
}

{
	name = "iMT_PlayerNearExitReacTeenGirl",
	criteria =
	[
		[ "concept", "iMT_PlayerNearExitReac" ], [ "who", "TeenGirl" ], [ "coughing", 0 ], [ "incapacitated", 0 ], [ "speaking", 0], [ "randomnum", 0, 10 ], [ IsTalk ], [ IsTalkTeenGirl ], [ IsWorldTalkTeenGirl ], [ IssuerClose ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/SafeSpotAheadReaction02.vcd" }  //Finally!
		{ scenename = "scenes/TeenGirl/SafeSpotAheadReaction08.vcd" }  //Thank God!
		{ scenename = "scenes/TeenGirl/SafeSpotAheadReaction10.vcd" }  //Oh thank god!
		{ scenename = "scenes/TeenGirl/SafeSpotAheadReaction14.vcd" }  //Sweet Jesus.
	],
	group_params = none
}

{
	name = "iMT_PlayerNiceShotTeenGirl",
	criteria =
	[
		[ "concept", "iMT_PlayerNiceShot" ], [ "who", "TeenGirl" ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/NiceShot01.vcd" }  //Good one.
		{ scenename = "scenes/TeenGirl/NiceShot04.vcd" }  //Killer shot.
		{ scenename = "scenes/TeenGirl/NiceShot05.vcd" }  //Boom! Nice.
		{ scenename = "scenes/TeenGirl/NiceShot06.vcd" }  //Great shot.
		{ scenename = "scenes/TeenGirl/NiceShot07.vcd" }  //Nice shot.
		{ scenename = "scenes/TeenGirl/NiceShot08.vcd" }  //Nice.
		{ scenename = "scenes/TeenGirl/NiceShot11.vcd" }  //Good one!
		{ scenename = "scenes/TeenGirl/NiceShot12.vcd" }  //Nice shot!
		{ scenename = "scenes/TeenGirl/NiceShot13.vcd" }  //Sweet shot!
		{ scenename = "scenes/TeenGirl/NiceShot14.vcd" }  //Killer shot!
		{ scenename = "scenes/TeenGirl/NiceShot15.vcd" }  //Great shot!
		{ scenename = "scenes/TeenGirl/NiceShot16.vcd" }  //Nice!
	],
	group_params = none
}

{
	name = "iMT_PlayerNiceShotNamVetTeenGirl",
	criteria =
	[
		[ "concept", "iMT_PlayerNiceShot" ], [ "who", "TeenGirl" ], [ "subject", "NamVet" ], [ "dist_from_subject", 0, 799 ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/NiceShot17.vcd" }  //Nice shot, old man!
	],
	group_params = none
}

{
	name = "iMT_PlayerPainNoiseTeenGirl",
	criteria =
	[
		[ "concept", "iMT_PlayerPainNoise" ], [ "who", "TeenGirl" ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/HurtMajor01.vcd" }  //[pain noise - ahh]
		{ scenename = "scenes/TeenGirl/HurtMajor02.vcd" }  //[pain noise - huh]
		{ scenename = "scenes/TeenGirl/HurtMajor03.vcd" }  //[pain noise - oy]
		{ scenename = "scenes/TeenGirl/HurtMajor04.vcd" }  //[pain noise - ugh]
		{ scenename = "scenes/TeenGirl/HurtMajor05.vcd" }  //[pain noise - ugh]
		{ scenename = "scenes/TeenGirl/HurtMajor06.vcd" }  //[pain noise - ugh]
	],
	group_params = none
}

{
	name = "iMT_PlayerPouncedBikerTeenGirl",
	criteria =
	[
		[ "concept", "iMT_SurvivorWasPounced" ], [ "who", "TeenGirl" ], [ "subject", "Biker" ], [ "dist_from_subject", 0, 799 ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/HunterFrancisPounced02.vcd" }  //Hunter's got Francis!
	],
	group_params = none
}

{
	name = "iMT_PlayerPouncedManagerTeenGirl",
	criteria =
	[
		[ "concept", "iMT_SurvivorWasPounced" ], [ "who", "TeenGirl" ], [ "subject", "Manager" ], [ "dist_from_subject", 0, 799 ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/HunterLouisPounced02.vcd" }  //Hunter's got Louis!
	],
	group_params = none
}

{
	name = "iMT_PlayerPouncedNamVetTeenGirl",
	criteria =
	[
		[ "concept", "iMT_SurvivorWasPounced" ], [ "who", "TeenGirl" ], [ "subject", "NamVet" ], [ "dist_from_subject", 0, 799 ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/HunterBillPounced02.vcd" }  //Hunter's got Bill!
	],
	group_params = none
}

{
	name = "iMT_PlayerReloadingTeenGirl",
	criteria =
	[
		[ "concept", "iMT_PlayerReloading" ], [ "who", "TeenGirl" ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/Reloading01.vcd" }  //Reloading!
		{ scenename = "scenes/TeenGirl/Reloading02.vcd" }  //Reloading!
		{ scenename = "scenes/TeenGirl/Reloading03.vcd" }  //Reloading!
		{ scenename = "scenes/TeenGirl/Reloading04.vcd" }  //I'm reloading!
	],
	group_params = none
}

{
	name = "iMT_PlayerSuggestHealthTeenGirl",
	criteria =
	[
		[ "concept", "iMT_PlayerSuggestHealth" ], [ "who", "TeenGirl" ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/PlayerSuggestHealth05.vcd" }  //Might be a good time for a health kit.
		{ scenename = "scenes/TeenGirl/SuggestHealth01.vcd" }  //You should heal up.
		{ scenename = "scenes/TeenGirl/SuggestHealth02.vcd" }  //C'mon man, use your first aid kit.
		{ scenename = "scenes/TeenGirl/SuggestHealth03.vcd" }  //You might want to heal up.
		{ scenename = "scenes/TeenGirl/SuggestHealth04.vcd" }  //Use your first aid kit.
	],
	group_params = none
}

{
	name = "iMT_PlayerSuggestHealthBikerTeenGirl",
	criteria =
	[
		[ "concept", "iMT_PlayerSuggestHealth" ], [ "who", "TeenGirl" ], [ "subject", "Biker" ], [ "dist_from_subject", 0, 199 ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/PlayerSuggestHealthSpecific04.vcd" }  //Francis, you might want to heal.
		{ scenename = "scenes/TeenGirl/PlayerSuggestHealthSpecific05.vcd" }  //Francis, you might want to heal.
		{ scenename = "scenes/TeenGirl/SuggestHealthFrancis01.vcd" }  //Francis, use your first aid kit.
	],
	group_params = none
}

{
	name = "iMT_PlayerSuggestHealthManagerTeenGirl",
	criteria =
	[
		[ "concept", "iMT_PlayerSuggestHealth" ], [ "who", "TeenGirl" ], [ "subject", "Manager" ], [ "dist_from_subject", 0, 199 ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/PlayerSuggestHealthSpecific08.vcd" }  //Louis, come on, patch yourself up.
		{ scenename = "scenes/TeenGirl/SuggestHealthLouis01.vcd" }  //Louis, use your first aid kit.
		{ scenename = "scenes/TeenGirl/SuggestHealthLouis02.vcd" }  //Louis, use your first aid kit.
	],
	group_params = none
}

{
	name = "iMT_PlayerSuggestHealthNamVetTeenGirl",
	criteria =
	[
		[ "concept", "iMT_PlayerSuggestHealth" ], [ "who", "TeenGirl" ], [ "subject", "NamVet" ], [ "dist_from_subject", 0, 199 ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/PlayerSuggestHealthSpecific06.vcd" }  //Bill, might be time to heal up.
		{ scenename = "scenes/TeenGirl/PlayerSuggestHealthSpecific07.vcd" }  //Bill, might be time to heal up.
		{ scenename = "scenes/TeenGirl/SuggestHealthBill01.vcd" }  //Bill, use your first aid kit.
		{ scenename = "scenes/TeenGirl/SuggestHealthBill02.vcd" }  //Bill, use your first aid kit.
	],
	group_params = none
}

{
	name = "iMT_PlayerTeamKillTeenGirl",
	criteria =
	[
		[ "concept", "iMT_PlayerTeamKill" ], [ "who", "TeenGirl" ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/TeamKillAccident03.vcd" }  //You REALLY have to be more careful!
		{ scenename = "scenes/TeenGirl/TeamKillAccident05.vcd" }  //Be careful!
		{ scenename = "scenes/TeenGirl/TeamKillAccident06.vcd" }  //Stop! Stop!
		{ scenename = "scenes/TeenGirl/TeamKillAccident08.vcd" }  //Woah! Careful!
	],
	group_params = none
}

{
	name = "iMT_PlayerTransitionTeenGirl",
	criteria =
	[
		[ "concept", "iMT_PlayerTransition" ], [ "who", "TeenGirl" ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/TransitionClose01.vcd" }  //That was close!
		{ scenename = "scenes/TeenGirl/TransitionClose05.vcd" }  //Close one!
		{ scenename = "scenes/TeenGirl/TransitionClose07.vcd" }  //That was close!
		{ scenename = "scenes/TeenGirl/TransitionClose09.vcd" }  //That was close!
		{ scenename = "scenes/TeenGirl/TransitionClose10.vcd" }  //Close one!
	],
	group_params = none
}

{
	name = "iMT_PlayerWitchChasingTeenGirl",
	criteria =
	[
		[ "concept", "iMT_PlayerWitchChasing" ], [ "who", "TeenGirl" ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/Help07.vcd" }  //Come on guys, I need some help!
		{ scenename = "scenes/TeenGirl/Help13.vcd" }  //Hey! Help!
		{ scenename = "scenes/TeenGirl/GrabbedBySmoker03c.vcd" }  //No, No, No, NO, NO!!!!!!!!
	],
	group_params = none
}

{
	name = "iMT_SurvivorCaughtVomitTeenGirl",
	criteria =
	[
		[ "concept", "iMT_PlayerVomitInFace" ], [ "who", "TeenGirl" ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/BoomerReaction01.vcd" }  //[spitting, disgusted, yech!]
		{ scenename = "scenes/TeenGirl/BoomerReaction02.vcd" }  //[spitting, disgusted, yech!]
		{ scenename = "scenes/TeenGirl/BoomerReaction04.vcd" }  //[spitting, disgusted, yech!]
		{ scenename = "scenes/TeenGirl/BoomerReaction05.vcd" }  //[spitting, disgusted, yech!]
		{ scenename = "scenes/TeenGirl/BoomerReaction06.vcd" }  //Oh god!
		{ scenename = "scenes/TeenGirl/BoomerReaction07.vcd" }  //[spitting, disgusted, yech!]
		{ scenename = "scenes/TeenGirl/BoomerReaction08.vcd" }  //Oh god!
		{ scenename = "scenes/TeenGirl/BoomerReaction09.vcd" }  //Ahhh ugh! Oh god!
		{ scenename = "scenes/TeenGirl/BoomerReaction10.vcd" }  //[spitting, disgusted, yech!]
		{ scenename = "scenes/TeenGirl/BoomerReaction13.vcd" }  //Oh yuck, not again!
		{ scenename = "scenes/TeenGirl/BoomerReaction15.vcd" }  //[spitting, disgusted, yech!]
		{ scenename = "scenes/TeenGirl/BoomerReaction16.vcd" }  //[spitting, disgusted, yech!]
		{ scenename = "scenes/TeenGirl/ReactionBoomerVomit01.vcd" }  //[spitting gross noises]
		{ scenename = "scenes/TeenGirl/ReactionBoomerVomit02.vcd" }  //[spitting gross noises]
		{ scenename = "scenes/TeenGirl/ReactionBoomerVomit03.vcd" }  //[spitting gross noises]
		{ scenename = "scenes/TeenGirl/ReactionDisgusted02.vcd" }  //Achhh...
		{ scenename = "scenes/TeenGirl/ReactionDisgusted04.vcd" }  //Ewwww...
		{ scenename = "scenes/TeenGirl/ReactionDisgusted05.vcd" }  //Ahhchh!
		{ scenename = "scenes/TeenGirl/ReactionDisgusted06.vcd" }  //Oh my god!
		{ scenename = "scenes/TeenGirl/ReactionDisgusted07.vcd" }  //Ohhhhh!
		{ scenename = "scenes/TeenGirl/ReactionDisgusted09.vcd" }  //Gross!
		{ scenename = "scenes/TeenGirl/ReactionDisgusted10.vcd" }  //Ewwww...
		{ scenename = "scenes/TeenGirl/ReactionDisgusted12.vcd" }  //Ohhhhh!
		{ scenename = "scenes/TeenGirl/ReactionDisgusted13.vcd" }  //Ohhhhh!
	],
	group_params = none
}

{
	name = "iMT_SurvivorCaughtVomit%TeenGirl",
	criteria =
	[
		[ "concept", "iMT_PlayerVomitInFace" ], [ "who", "TeenGirl" ], [ "randomnum", 0, 2 ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/GenericResponses35.vcd" }  //It slimed me!
	],
	group_params = none
}

//--------------------------------------------------------------------------------------------------
// Character-specific
//--------------------------------------------------------------------------------------------------

{
	name = "iMT_5000LawyersTeenGirl",
	criteria =
	[
		[ "concept", "iMT_5000Lawyers" ], [ "who", "TeenGirl" ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/WorldAirport0214.vcd" }  //What do you call 5000 infected lawyers?
	],
	group_params = none
}

{
	name = "iMT_CarCallingTeenGirl",
	criteria =
	[
		[ "concept", "iMT_CarCalling" ], [ "who", "TeenGirl" ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/DLC1_C6M3_L4D1FinaleBridgeRun04.vcd" }  //Get to your car Ellis!
		{ scenename = "scenes/TeenGirl/DLC1_C6M3_L4D1FinaleBridgeRun05.vcd" }  //Get to your car Ellis!
		{ scenename = "scenes/TeenGirl/DLC1_C6M3_L4D1FinaleBridgeRun07.vcd" }  //Ellis, the car's calling!
	],
	group_params = none
}

{
	name = "iMT_ChickenshitsTeenGirl",
	criteria =
	[
		[ "concept", "iMT_Chickenshits" ], [ "who", "TeenGirl" ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/C6DLC3OpeningDoor06.vcd" }  //Unbelievable. You guys are the biggest chickenshits.
	],
	group_params = none
}

{
	name = "iMT_Chickenshits%TeenGirl",
	criteria =
	[
		[ "concept", "iMT_Chickenshits" ], [ "who", "TeenGirl" ], [ "randomnum", 0, 30 ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/C6DLC3TankInTrainyard10.vcd", followup = RThen( "Biker", "iMT_ChickenshitsReac", { from = "TeenGirl" }, 0.3 ) }  //So, I'm a girl, right? You guys wouldn't make a lady open up a deathtrap, right?
	],
	group_params = none
}

{
	name = "iMT_ComeBackTeenGirl",
	criteria =
	[
		[ "concept", "iMT_ComeBack" ], [ "who", "TeenGirl" ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/DLC1_C6M3_L4D1FinaleCinematic19.vcd" }  //Y'all come back now!
		{ scenename = "scenes/TeenGirl/DLC1_C6M3_L4D1FinaleCinematic20.vcd" }  //Y'all come back now!
	],
	group_params = none
}

{
	name = "iMT_CopyPaperTeenGirl",
	criteria =
	[
		[ "concept", "iMT_CopyPaper" ], [ "who", "TeenGirl" ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/DLC2CopyPaper01.vcd" }  //Free copy paper? Sweet! The apocalypse was totally worth it.
	],
	group_params = none
}

{
	name = "iMT_GodDamnYouTeenGirl",
	criteria =
	[
		[ "concept", "iMT_GodDamnYou" ], [ "who", "TeenGirl" ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/DLC1_C6M3_L4D1FinaleCinematic16.vcd" }  //(Planet of the apes) You finally really did it. You maniacs! You blew it up! God damn you! God damn you all to hell!
	],
	group_params = none
}

{
	name = "iMT_GodIsDeadTeenGirl",
	criteria =
	[
		[ "concept", "iMT_GodIsDead" ], [ "who", "TeenGirl" ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/WorldAirport0403.vcd" }  //Oh no, the zombies killed god!
		{ scenename = "scenes/TeenGirl/WorldAirport0404.vcd" }  //Oh no, the zombies killed god!
	],
	group_params = none
}

{
	name = "iMT_GreetingTeenGirl",
	criteria =
	[
		[ "concept", "iMT_Greeting" ], [ "who", "TeenGirl" ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/DLC1_C6M3_FinaleChat15.vcd" }  //Hey.
		{ scenename = "scenes/TeenGirl/DLC1_C6M3_FinaleChat16.vcd" }  //Hey.
	],
	group_params = none
}

{
	name = "iMT_LastWomanTeenGirl",
	criteria =
	[
		[ "concept", "iMT_LastWoman" ], [ "who", "TeenGirl" ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/Generic10.vcd" }  //Great, that makes me the last woman on earth.
	],
	group_params = none
}

{
	name = "iMT_LatestIssueTeenGirl",
	criteria =
	[
		[ "concept", "iMT_LatestIssue" ], [ "who", "TeenGirl" ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/DLC2MagazineRack01.vcd", followup = RThen( "Biker", "iMT_LatestIssueReac", { from = "TeenGirl" }, 0.3 ) }  //Hey, Francis. They've got the latest issue of Hating Everything Magazine here.
	],
	group_params = none
}

{
	name = "iMT_MetalSupplyTeenGirl",
	criteria =
	[
		[ "concept", "iMT_MetalSupply" ], [ "who", "TeenGirl" ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/DLC2MetalSupply01.vcd" }  //Metal Supply! Oh thank God. I was running low on metal.
		{ scenename = "scenes/TeenGirl/DLC2MetalSupply02.vcd" }  //Metal Supply! Oh thank God. I was running low on iron.
		{ scenename = "scenes/TeenGirl/DLC2MetalSupply03.vcd" }  //Metal Supply! Oh thank God. I was running low on tungsten.
	],
	group_params = none
}

{
	name = "iMT_MissEllisTeenGirl",
	criteria =
	[
		[ "concept", "iMT_MissEllis" ], [ "who", "TeenGirl" ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/DLC1_C6M3_L4D1FinaleCinematic06.vcd" }  //Ellis! ELLIS!!! Maybe we should have gone with him?
		{ scenename = "scenes/TeenGirl/DLC1_C6M3_L4D1FinaleCinematic07.vcd" }  //Ellis! ELLIS!!! Maybe he should have come with us?
		{ scenename = "scenes/TeenGirl/DLC1_C6M3_L4D1FinaleCinematic23.vcd" }  //I'm going to miss Ellis.
		{ scenename = "scenes/TeenGirl/DLC1_C6M3_L4D1FinaleCinematic24.vcd" }  //Hm. I'm going to miss Ellis.
		{ scenename = "scenes/TeenGirl/DLC1_C6M3_L4D1FinaleCinematic25.vcd" }  //I'm going to miss Ellis.
	],
	group_params = none
}

{
	name = "iMT_MoronsTeenGirl",
	criteria =
	[
		[ "concept", "iMT_Morons" ], [ "who", "TeenGirl" ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/DLC1_C6M3_FinaleChat14.vcd" }  //Hello! Morons. I think we have a bridge to lower.
	],
	group_params = none
}

{
	name = "iMT_MyBuddyEllisTeenGirl",
	criteria =
	[
		[ "concept", "iMT_MyBuddyEllis" ], [ "who", "TeenGirl" ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/DLC1_C6M3_L4D1FinaleCinematic21.vcd" }  //I ever tell you about the time my buddy Ellis stole a race car from the mall and drove it over some zombies?
	],
	group_params = none
}

{
	name = "iMT_NervousHummingTeenGirl",
	criteria =
	[
		[ "concept", "iMT_NervousHumming" ], [ "who", "TeenGirl" ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/NervousHumming01.vcd" }  //[Nervous Humming]
		{ scenename = "scenes/TeenGirl/NervousHumming02.vcd" }  //[Nervous Humming]
		{ scenename = "scenes/TeenGirl/NervousHumming03.vcd" }  //[Nervous Humming]
		{ scenename = "scenes/TeenGirl/NervousHumming04.vcd" }  //[Nervous Humming]
	],
	group_params = none
}

{
	name = "iMT_NiceCarTeenGirl",
	criteria =
	[
		[ "concept", "iMT_NiceCar" ], [ "who", "TeenGirl" ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/DLC1_C6M1_InitialMeeting05.vcd" }  //Nice car!
		{ scenename = "scenes/TeenGirl/DLC1_C6M1_InitialMeeting06.vcd" }  //Nice car, dude!
	],
	group_params = none
}

{
	name = "iMT_ParkingTeenGirl",
	criteria =
	[
		[ "concept", "iMT_Parking" ], [ "who", "TeenGirl" ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/WorldAirport0314.vcd" }  //Oh no! Not short term parking!
	],
	group_params = none
}

{
	name = "iMT_PassingGasTeenGirl",
	criteria =
	[
		[ "concept", "iMT_PassingGas" ], [ "who", "TeenGirl" ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/DLC2GasTanks01.vcd" }  //Hey, Francis, look! We're 'passing gas'... [chuckles]
	],
	group_params = none
}

{
	name = "iMT_PilotLicenseTeenGirl",
	criteria =
	[
		[ "concept", "iMT_PilotLicense" ], [ "who", "TeenGirl" ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/DLC2PilotComment01.vcd" }  //'Pilot's License...revoked.' Dunh-dunh-DUNNNNH...
		{ scenename = "scenes/TeenGirl/DLC2PilotComment02.vcd" }  //'Pilot's License...revoked.' WAAAAAAAAHH!
	],
	group_params = none
}

{
	name = "iMT_ProclaimLibertyTeenGirl",
	criteria =
	[
		[ "concept", "iMT_ProclaimLiberty" ], [ "who", "TeenGirl" ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/DLC1_C6M3_L4D1FinaleCinematic15.vcd" }  //(10 commandments) Go - proclaim liberty throughout all the lands, and to all the inhabitants thereof!
	],
	group_params = none
}

{
	name = "iMT_ReallyTeenGirl",
	criteria =
	[
		[ "concept", "iMT_Really" ], [ "who", "TeenGirl" ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/DLC1_C6M3_FinaleChat05.vcd" }  //(noting flirting) Francis? Him? Are you kidding? REALLY?
		{ scenename = "scenes/TeenGirl/DLC1_C6M3_FinaleChat06.vcd" }  //(noting flirting) Francis? Him? Are you kidding? REALLY?
		{ scenename = "scenes/TeenGirl/DLC1_C6M3_FinaleChat09.vcd" }  //(noting flirting) Francis? Him? Are you kidding? REALLY?
	],
	group_params = none
}

{
	name = "iMT_SexyBrunetteTeenGirl",
	criteria =
	[
		[ "concept", "iMT_SexyBrunette" ], [ "who", "TeenGirl" ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/DLC2BulletinBoard01.vcd" }  //'Funny, sexy brunette zombie killer wanted to lead three helpless men to safety.' Huh.
	],
	group_params = none
}

{
	name = "iMT_ShoesTeenGirl",
	criteria =
	[
		[ "concept", "iMT_Shoes" ], [ "who", "TeenGirl" ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/WorldAirport0409.vcd" }  //Whatever you do, Francis, please don't take off your shoes.
	],
	group_params = none
}

{
	name = "iMT_ShortLaughTeenGirl",
	criteria =
	[
		[ "concept", "iMT_ShortLaugh" ], [ "who", "TeenGirl" ], [ "coughing", 0 ], [ "incapacitated", 0 ], [ "speaking", 0], [ IsTalk ], [ IsTalkTeenGirl ], [ IsWorldTalkTeenGirl ], [ IssuerClose ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/Laughter20.vcd" }  //<Short laugh>
		{ scenename = "scenes/TeenGirl/Laughter21.vcd" } // <Short laugh>
		{ scenename = "scenes/TeenGirl/PositiveNoise02.vcd" }  //[Laugh]
	],
	group_params = none
}

{
	name = "iMT_SingingTeenGirl",
	criteria =
	[
		[ "concept", "iMT_Singing" ], [ "who", "TeenGirl" ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/NervousWhislte01.vcd" }  //[Nervous Whistle]
		{ scenename = "scenes/TeenGirl/NervousWhislte02.vcd" }  //[Nervous Whistle]
		{ scenename = "scenes/TeenGirl/NervousWhislte03.vcd" }  //[Nervous Whistle]
		{ scenename = "scenes/TeenGirl/NervousWhislte04.vcd" }  //[Nervous Whistle]
		{ scenename = "scenes/TeenGirl/NervousWhislte05.vcd" }  //[Nervous Whistle]
	],
	group_params = none
}

{
	name = "iMT_SnowColdTeenGirl",
	criteria =
	[
		[ "concept", "iMT_SnowCold" ], [ "who", "TeenGirl" ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/DLC1_CommunityL4D105.vcd", followup = RThen( "Biker", "iMT_SnowColdReac", { from = "TeenGirl" }, 0.3 ) }  //Francis, what do you hate more: the snow or the cold?
	],
	group_params = none
}

{
	name = "iMT_SoylentGreenTeenGirl",
	criteria =
	[
		[ "concept", "iMT_SoylentGreen" ], [ "who", "TeenGirl" ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/DLC1_C6M3_L4D1FinaleCinematic17.vcd" }  //Remember soylent green is people!
		{ scenename = "scenes/TeenGirl/DLC1_C6M3_L4D1FinaleCinematic18.vcd" }  //Remember soylent green is people!
	],
	group_params = none
}

{
	name = "iMT_StealTeenGirl",
	criteria =
	[
		[ "concept", "iMT_Steal" ], [ "who", "TeenGirl" ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/DLC1_CommunityL4D102.vcd" }  //If no one minds, we can steal a boat.
	],
	group_params = none
}

{
	name = "iMT_YoinkTeenGirl",
	criteria =
	[
		[ "concept", "iMT_Yoink" ], [ "who", "TeenGirl" ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/Generic20.vcd" }  //Yoink!
	],
	group_params = none
}

//--------------------------------------------------------------------------------------------------
// Overrides
//--------------------------------------------------------------------------------------------------

{
	name = "iMT_PlayerAnswerLostCallTeenGirl",
	criteria =
	[
		[ "concept", "PlayerAnswerLostCall" ], [ "who", "TeenGirl" ], [ "coughing", 0 ], [ "numberofteamalive", 4, null ], [ "numberofteamdead", 0 ], [ "disttoclosestsurvivor", 0, 499 ], [ "randomnum", 0, 10 ], [ IsTalk ], [ IsTalkTeenGirl ], [ IsWorldTalkTeenGirl ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/ScenarioJoinLast01.vcd" }  //We're all here.
		{ scenename = "scenes/TeenGirl/ScenarioJoinLast02.vcd" }  //Well, we're all here.
	],
	group_params = none
}

{
	name = "iMT_PlayerHeardBoomerTeenGirl",
	criteria =
	[
		[ "concept", "PlayerHeardBoomer" ], [ "who", "TeenGirl" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkTeenGirl ], [ IsWorldTalkTeenGirl ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/HeardBoomer01.vcd" }  //I think one of those vomit bags is around here.
		{ scenename = "scenes/TeenGirl/HeardBoomer02.vcd" }  //Sounds like a Boomer's around.
		{ scenename = "scenes/TeenGirl/HeardBoomer03.vcd" }  //Ahh, a Boomer. Hear it?
		{ scenename = "scenes/TeenGirl/HeardBoomer05.vcd" }  //Ugh, I can hear a Boomer sloshing around.
		{ scenename = "scenes/TeenGirl/HeardBoomer07.vcd" }  //Ah no... I think I hear a Boomer.
		{ scenename = "scenes/TeenGirl/HeardBoomer08.vcd" }  //I hear a Boomer.
		{ scenename = "scenes/TeenGirl/HeardBoomer09.vcd" }  //Oh god, there's a Boomer around.
		{ scenename = "scenes/TeenGirl/HeardBoomer10.vcd" }  //Hear that Boomer?
		{ scenename = "scenes/TeenGirl/HeardBoomer11.vcd" }  //I think I hear a Boomer.
		{ scenename = "scenes/TeenGirl/HeardBoomer14.vcd" }  //Wait up, I hear a Boomer.
		{ scenename = "scenes/TeenGirl/HeardBoomer15.vcd" }  //Boomer, hear it?
		{ scenename = "scenes/TeenGirl/HeardBoomer16.vcd" }  //Ugh, yuck. Another Boomer. You hear that?
		{ scenename = "scenes/TeenGirl/HeardBoomer17.vcd" }  //Hear that? Boomer.
		{ scenename = "scenes/TeenGirl/HeardBoomer19.vcd" }  //Boomer, don't let it puke on you.
	],
	group_params = none
}

{
	name = "iMT_PlayerHeardHunterTeenGirl",
	criteria =
	[
		[ "concept", "PlayerHeardHunter" ], [ "who", "TeenGirl" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkTeenGirl ], [ IsWorldTalkTeenGirl ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/HeardHunter03.vcd" }  //There's a Hunter around.
		{ scenename = "scenes/TeenGirl/HeardHunter04.vcd" }  //There's a Hunter out there.
		{ scenename = "scenes/TeenGirl/HeardHunter06.vcd" }  //Hunter around, don't get pounced.
		{ scenename = "scenes/TeenGirl/HeardHunter07.vcd" }  //Careful, a Hunter's around.
		{ scenename = "scenes/TeenGirl/HeardHunter08.vcd" }  //Crap, Hunter.
		{ scenename = "scenes/TeenGirl/HeardHunter09.vcd" }  //I think I hear a Hunter.
		{ scenename = "scenes/TeenGirl/HeardHunter10.vcd" }  //Pretty sure I can hear a Hunter. [calm]
		{ scenename = "scenes/TeenGirl/HeardHunter11.vcd" }  //Hear that Hunter? [calm]
		{ scenename = "scenes/TeenGirl/HeardHunter13.vcd" }  //I know that noise, Hunter.
		{ scenename = "scenes/TeenGirl/HeardHunter23.vcd" }  //Hunter, hear it?
		{ scenename = "scenes/TeenGirl/HeardHunter26.vcd" }  //There's a Hunter out there.
		{ scenename = "scenes/TeenGirl/HeardHunter27.vcd" }  //Hunter and it's close.
	],
	group_params = none
}

{
	name = "iMT_PlayerHeardSmokerTeenGirl",
	criteria =
	[
		[ "concept", "PlayerHeardSmoker" ], [ "who", "TeenGirl" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkTeenGirl ], [ IsWorldTalkTeenGirl ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/HeardSmoker06.vcd" }  //There's a Smoker around here.
		{ scenename = "scenes/TeenGirl/HeardSmoker09.vcd" }  //Smoker... don't get hung.
		{ scenename = "scenes/TeenGirl/HeardSmoker10.vcd" }  //Watch the roof tops, there's a Smoker around.
		{ scenename = "scenes/TeenGirl/HeardSmoker11.vcd" }  //I hear a Smoker.
		{ scenename = "scenes/TeenGirl/HeardSmoker12.vcd" }  //Careful, Smoker.
		{ scenename = "scenes/TeenGirl/HeardSmoker13.vcd" }  //There's a Smoker around here.
		{ scenename = "scenes/TeenGirl/HeardSmoker14.vcd" }  //I know that sound - a Smoker!
		{ scenename = "scenes/TeenGirl/HeardSmoker16.vcd" }  //Smoker... don't let him hang you.
	],
	group_params = none
}

{
	name = "iMT_PlayerHeardWitchTeenGirl",
	criteria =
	[
		[ "concept", "PlayerHeardWitch" ], [ "who", "TeenGirl" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkTeenGirl ], [ IsWorldTalkTeenGirl ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/HeardWitch01.vcd" }  //I think I hear a Witch.
		{ scenename = "scenes/TeenGirl/HeardWitch02.vcd" }  //Sounds like a Witch.
		{ scenename = "scenes/TeenGirl/HeardWitch03.vcd" }  //Shhh.... Witch.
		{ scenename = "scenes/TeenGirl/HeardWitch04.vcd" }  //Quiet, listen.
		{ scenename = "scenes/TeenGirl/HeardWitch05.vcd" }  //Quiiii-et, I hear a Witch.
		{ scenename = "scenes/TeenGirl/HeardWitch06.vcd" }  //That sounds like a Witch.
		{ scenename = "scenes/TeenGirl/HeardWitch07.vcd" }  //It's a Witch. Don't disturb her and we'll be okay.
	],
	group_params = none
}

{
	name = "iMT_PlayerHurrahTeenGirl",
	criteria =
	[
		[ "concept", "PlayerHurrah" ], [ "who", "TeenGirl" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkTeenGirl ], [ IsWorldTalkTeenGirl ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/Hurrah07.vcd" }  //I think we're gonna make it.
		{ scenename = "scenes/TeenGirl/Hurrah10.vcd" }  //We're doing all right.
		{ scenename = "scenes/TeenGirl/Hurrah13.vcd" }  //We're gonna be okay.
		{ scenename = "scenes/TeenGirl/Hurrah18.vcd", followup = RThen( "any", "HurrahAlso", null, 0.3 ) }  //We are kickin' ass!
		{ scenename = "scenes/TeenGirl/Hurrah19.vcd", followup = RThen( "any", "HurrahAlso", null, 0.3 ) }  //No stopping us!
		{ scenename = "scenes/TeenGirl/Hurrah20.vcd", followup = RThen( "any", "HurrahAlso", null, 0.3 ) }  //We are unstoppable!
		{ scenename = "scenes/TeenGirl/Hurrah31.vcd" }  //Oh god, we're gonna be okay.
		{ scenename = "scenes/TeenGirl/Hurrah35.vcd" }  //We might actually make it through this.
		{ scenename = "scenes/TeenGirl/Hurrah38.vcd" }  //We're doing all right.
		{ scenename = "scenes/TeenGirl/Hurrah46.vcd" }  //Oh, thank god!
		{ scenename = "scenes/TeenGirl/Hurrah48.vcd" }  //Wow, I can't believe we did that.
		{ scenename = "scenes/TeenGirl/Hurrah53.vcd", followup = RThen( "any", "HurrahAlso", null, 0.3 ) }  //We are awesome together.
		{ scenename = "scenes/TeenGirl/Hurrah54.vcd", followup = RThen( "any", "HurrahAlso", null, 0.3 ) }  //Oh my god, we made that. Can you believe it?
		{ scenename = "scenes/TeenGirl/Hurrah55.vcd" }  //Wow, oh, thank god!
		{ scenename = "scenes/TeenGirl/Hurrah58.vcd" }  //We did it. Can you believe it?
	],
	group_params = none
}

{
	name = "iMT_PlayerLaughTeenGirl",
	criteria =
	[
		[ "concept", "PlayerLaugh" ], [ "who", "TeenGirl" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkTeenGirl ], [ IsWorldTalkTeenGirl ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/Laughter02.vcd" }  //<Hearty Laugh>
		{ scenename = "scenes/TeenGirl/Laughter04.vcd" }  //<Hearty Laugh>
		{ scenename = "scenes/TeenGirl/Laughter06.vcd" }  //<Hearty Laugh>
		{ scenename = "scenes/TeenGirl/Laughter11.vcd" }  //<Hearty Laugh>
		{ scenename = "scenes/TeenGirl/Laughter14.vcd" }  //<Hearty Laugh>
		{ scenename = "scenes/TeenGirl/Laughter18.vcd" }  //<Short laugh>
		{ scenename = "scenes/TeenGirl/Laughter20.vcd" }  //<Short laugh>
		{ scenename = "scenes/TeenGirl/Laughter21.vcd" }  //<Short laugh>
	],
	group_params = none
}

{
	name = "iMT_PlayerLaughAloneTeenGirl",
	criteria =
	[
		[ "concept", "PlayerLaugh" ], [ "who", "TeenGirl" ], [ "coughing", 0 ], [ "numberofteamalive", 1 ], [ "onthirdstrike", 1 ], [ IsTalk ], [ IsTalkTeenGirl ], [ IsWorldTalkTeenGirl ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/Laughter09.vcd" }  //<Nervous laugh>
		{ scenename = "scenes/TeenGirl/Laughter10.vcd" }  //<Nervous laugh>
		{ scenename = "scenes/TeenGirl/Laughter12.vcd" }  //<Nervous laugh>
		{ scenename = "scenes/TeenGirl/Laughter13.vcd" }  //<Nervous laugh>
		{ scenename = "scenes/TeenGirl/Laughter16.vcd" }  //<Nervous laugh>
	],
	group_params = none
}

{
	name = "iMT_PlayerNegativeTeenGirl",
	criteria =
	[
		[ "concept", "PlayerNegative" ], [ "who", "TeenGirl" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkTeenGirl ], [ IsWorldTalkTeenGirl ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/ReactionNegative17.vcd" }  //Shit.
		{ scenename = "scenes/TeenGirl/ReactionNegative18.vcd" }  //This sucks.
		{ scenename = "scenes/TeenGirl/ReactionNegative25.vcd" }  //Crap.
		{ scenename = "scenes/TeenGirl/ReactionNegative31.vcd" }  //Shit.
		{ scenename = "scenes/TeenGirl/Swear02.vcd" }  //Shit.
		{ scenename = "scenes/TeenGirl/Swear06.vcd" }  //Mother.
		{ scenename = "scenes/TeenGirl/Swear09.vcd" }  //Ah bullshit.
		{ scenename = "scenes/TeenGirl/Swear10.vcd" }  //Dammit.
		{ scenename = "scenes/TeenGirl/Swear12.vcd" }  //Shit.
		{ scenename = "scenes/TeenGirl/Swear13.vcd" }  //Goddammit.
		{ scenename = "scenes/TeenGirl/Swear14.vcd" }  //Shit.
		{ scenename = "scenes/TeenGirl/Swear22.vcd" }  //Dammit.
	],
	group_params = none
}

{
	name = "iMT_PlayerRelaxedSighTeenGirl",
	criteria =
	[
		[ "concept", "RelaxedSigh" ], [ "who", "TeenGirl" ], [ "speaking", 1 ]
	],
	responses =
	[
		{ scenename = "" }
	],
	group_params = none
}

{
	name = "iMT_PlayerThanksBikerTeenGirl",
	criteria =
	[
		[ "concept", "PlayerThanks" ], [ "who", "TeenGirl" ], [ "coughing", 0 ], [ "subject", "Biker" ], [ "dist_from_subject", 0, 99 ], [ "randomnum", 0, 30 ], [ IsTalk ], [ IsTalkTeenGirl ], [ IsWorldTalkTeenGirl ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/Thanks41.vcd" }  //Thanks, Francis.
		{ scenename = "scenes/TeenGirl/Thanks44.vcd" }  //Thanks, Francis.
	],
	group_params = none
}

{
	name = "iMT_PlayerThanksManagerTeenGirl",
	criteria =
	[
		[ "concept", "PlayerThanks" ], [ "who", "TeenGirl" ], [ "coughing", 0 ], [ "subject", "Manager" ], [ "dist_from_subject", 0, 99 ], [ "randomnum", 0, 30 ], [ IsTalk ], [ IsTalkTeenGirl ], [ IsWorldTalkTeenGirl ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/Thanks32.vcd" }  //Thanks Louis.
		{ scenename = "scenes/TeenGirl/Thanks42.vcd" }  //Thanks, Louis.
		{ scenename = "scenes/TeenGirl/Thanks43.vcd" }  //Thanks, Louis. I owe you one.
		{ scenename = "scenes/TeenGirl/Thanks45.vcd" }  //Thanks, Louis.
		{ scenename = "scenes/TeenGirl/Thanks46.vcd" }  //Thanks, Louis. I owe you one.
	],
	group_params = none
}

{
	name = "iMT_PlayerThanksManager%TeenGirl",
	criteria =
	[
		[ "concept", "PlayerThanks" ], [ "who", "TeenGirl" ], [ "coughing", 0 ], [ "subject", "Manager" ], [ "dist_from_subject", 0, 99 ], [ "randomnum", 31, 35 ], [ IsTalk ], [ IsTalkTeenGirl ], [ IsWorldTalkTeenGirl ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/Thanks34.vcd" }  //Thank you, Louis. It's about time you helped me.
		{ scenename = "scenes/TeenGirl/Thanks35.vcd" }  //Thanks, Louis. It's about time you were some help.
	],
	group_params = none
}

{
	name = "iMT_PlayerThanksNamVetTeenGirl",
	criteria =
	[
		[ "concept", "PlayerThanks" ], [ "who", "TeenGirl" ], [ "coughing", 0 ], [ "subject", "NamVet" ], [ "dist_from_subject", 0, 99 ], [ "randomnum", 0, 30 ], [ IsTalk ], [ IsTalkTeenGirl ], [ IsWorldTalkTeenGirl ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/Thanks05.vcd" }  //Thanks, Bill.
		{ scenename = "scenes/TeenGirl/Thanks40.vcd" }  //Thanks, Bill.
	],
	group_params = none
}

{
	name = "iMT_PlayerYouAreWelcomeManagerTeenGirl",
	criteria =
	[
		[ "concept", "PlayerYouAreWelcome" ], [ "who", "TeenGirl" ], [ "coughing", 0 ], [ "subject", "Manager" ], [ "dist_from_subject", 0, 99 ], [ "randomnum", 0, 30 ], [ IsTalk ], [ IsTalkTeenGirl ], [ IsWorldTalkTeenGirl ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/YouAreWelcome32.vcd" }  //Anything for you, Louis.
		{ scenename = "scenes/TeenGirl/YouAreWelcome39.vcd" }  //Anything for you, Louis.
	],
	group_params = none
}

{
	name = "iMT_PlayerYouAreWelcomeNamVetTeenGirl",
	criteria =
	[
		[ "concept", "PlayerYouAreWelcome" ], [ "who", "TeenGirl" ], [ "coughing", 0 ], [ "subject", "NamVet" ], [ "dist_from_subject", 0, 99 ], [ "randomnum", 0, 30 ], [ IsTalk ], [ IsTalkTeenGirl ], [ IsWorldTalkTeenGirl ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/YouAreWelcome36.vcd" }  //Glad to be of help, old man.
	],
	group_params = none
}

{
	name = "iMT_ResponseSoftDispleasureSwearTeenGirl",
	criteria =
	[
		[ "concept", "ResponseSoftDispleasureSwear" ], [ "who", "TeenGirl" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkTeenGirl ], [ IsWorldTalkTeenGirl ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/NegativeNoise13.vcd" }  //[Improv non-verbal displeasure sounds]
		{ scenename = "scenes/TeenGirl/ReactionApprehensive18.vcd" }  //I have a bad feeling about this...
		{ scenename = "scenes/TeenGirl/ReactionNegative01.vcd" }  //Uh oh!
		{ scenename = "scenes/TeenGirl/ReactionNegative02.vcd" }  //This is so messed up!
		{ scenename = "scenes/TeenGirl/ReactionNegative03.vcd" }  //This sucks!
		{ scenename = "scenes/TeenGirl/ReactionNegative04.vcd" }  //This sucks big time!
		{ scenename = "scenes/TeenGirl/ReactionNegative05.vcd" }  //Oh damn!
		{ scenename = "scenes/TeenGirl/ReactionNegative06.vcd" }  //This isn't working!
		{ scenename = "scenes/TeenGirl/ReactionNegative08.vcd" }  //What the hell was that?
		{ scenename = "scenes/TeenGirl/ReactionNegative10.vcd" }  //This is so messed up!
		{ scenename = "scenes/TeenGirl/ReactionNegative11.vcd" }  //Are you kidding me?
		{ scenename = "scenes/TeenGirl/ReactionNegative12.vcd" }  //Not again!
		{ scenename = "scenes/TeenGirl/ReactionNegative14.vcd" }  //This is never going to end!
		{ scenename = "scenes/TeenGirl/ReactionNegative15.vcd" }  //This is not going well!
		{ scenename = "scenes/TeenGirl/ReactionNegative16.vcd" }  //Oh man oh man oh man!
		{ scenename = "scenes/TeenGirl/ReactionNegative19.vcd" }  //This sucks big time!
		{ scenename = "scenes/TeenGirl/ReactionNegative21.vcd" }  //Oh no!
		{ scenename = "scenes/TeenGirl/ReactionNegative22.vcd" }  //Ah crap!
		{ scenename = "scenes/TeenGirl/ReactionNegative23.vcd" }  //This is bad!
		{ scenename = "scenes/TeenGirl/ReactionNegative26.vcd" }  //No No No No NO!
		{ scenename = "scenes/TeenGirl/ReactionNegative27.vcd" }  //This is never going to end!
		{ scenename = "scenes/TeenGirl/ReactionNegative28.vcd" }  //This is not going well!
		{ scenename = "scenes/TeenGirl/ReactionNegative29.vcd" }  //Oh man oh man oh man!
		{ scenename = "scenes/TeenGirl/ReactionNegative32.vcd" }  //This is bad!
		{ scenename = "scenes/TeenGirl/ReactionNegative33.vcd" }  //Ah crap!
		{ scenename = "scenes/TeenGirl/ReactionNegativeSpecial03.vcd" }  //[Frustration sound]
		{ scenename = "scenes/TeenGirl/ReactionNegativeSpecial12.vcd" }  //[Frustration sound]
		{ scenename = "scenes/TeenGirl/ReactionNegativeSpecial13.vcd" }  //[Frustration sound]
	],
	group_params = none
}

{
	name = "iMT_SurvivorAskForHealthTeenGirl",
	criteria =
	[
		[ "concept", "AskForHealth2" ], [ "who", "TeenGirl" ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/GoingToDieAskForHeal01.vcd" }  //Anyone have some first aid?
		{ scenename = "scenes/TeenGirl/GoingToDieAskForHeal02.vcd" }  //I need some first aid, now!
		{ scenename = "scenes/TeenGirl/GoingToDieAskForHeal04.vcd" }  //Anyone have some first aid? I'm gonna die.
		{ scenename = "scenes/TeenGirl/GoingToDieAskForHeal05.vcd" }  //I need some first aid, now!
		{ scenename = "scenes/TeenGirl/GoingToDieAskForHeal13.vcd" }  //I can't make it without some help...
	],
	group_params = none
}

{
	name = "iMT_SurvivorAskForHealthBikerTeenGirl",
	criteria =
	[
		[ "concept", "AskForHealth2" ], [ "who", "TeenGirl" ], [ "onthirdstrike", 0 ], [ "subject", "Biker" ], [ "dist_from_subject", 0, 399 ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/PlayerSuggestHealthSpecific09.vcd" }  //Francis, if you aren't gonna use that first aid kit, can I have it?
	],
	group_params = none
}

{
	name = "iMT_SurvivorAskForHealthManagerTeenGirl",
	criteria =
	[
		[ "concept", "AskForHealth2" ], [ "who", "TeenGirl" ], [ "onthirdstrike", 0 ], [ "subject", "Manager" ], [ "dist_from_subject", 0, 399 ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/PlayerSuggestHealthSpecific11.vcd" }  //Louis, if you aren't gonna use that first aid kit, can I have it, please?
	],
	group_params = none
}

{
	name = "iMT_SurvivorAskForHealthNamVetTeenGirl",
	criteria =
	[
		[ "concept", "AskForHealth2" ], [ "who", "TeenGirl" ], [ "onthirdstrike", 0 ], [ "subject", "NamVet" ], [ "dist_from_subject", 0, 399 ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/PlayerSuggestHealthSpecific10.vcd" }  //Bill, if you aren't gonna use that first aid kit, can I have it?
	],
	group_params = none
}

{
	name = "iMT_SurvivorCoughingDeathTeenGirl",
	criteria =
	[
		[ "concept", "PlayerDeath" ], [ "who", "TeenGirl" ], [ "coughing", 1 ], [ IsTalk ], [ IsTalkTeenGirl ], [ IsWorldTalkTeenGirl ]
	],
	responses = SurvivorCoughingTeenGirl,
	group_params = none
}

{
	name = "iMT_SurvivorDeathTeenGirl",
	criteria =
	[
		[ "concept", "PlayerDeath" ], [ "who", "TeenGirl" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkTeenGirl ], [ IsWorldTalkTeenGirl ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/DeathScream01.vcd" }  //[Death rattle]
		{ scenename = "scenes/TeenGirl/DeathScream02.vcd" }  //[Death rattle]
		{ scenename = "scenes/TeenGirl/DeathScream03.vcd" }  //[Death rattle]
		{ scenename = "scenes/TeenGirl/DeathScream04.vcd" }  //[Death rattle]
		{ scenename = "scenes/TeenGirl/DeathScream05.vcd" }  //[Short quick death scream]
		{ scenename = "scenes/TeenGirl/DeathScream06.vcd" }  //[Short quick death scream]
		{ scenename = "scenes/TeenGirl/DeathScream07.vcd" }  //[Short quick death scream]
		{ scenename = "scenes/TeenGirl/DeathScream08.vcd" }  //[Short quick death scream]
		{ scenename = "scenes/TeenGirl/DeathScream09.vcd" }  //[Loud painful death scream]
		{ scenename = "scenes/TeenGirl/DeathScream10.vcd" }  //[Loud painful death scream]
		{ scenename = "scenes/TeenGirl/DeathScream11.vcd" }  //[Loud painful death scream]
	],
	group_params = none
}

{
	name = "iMT_SurvivorSpottedAmmoTeenGirl",
	criteria =
	[
		[ "concept", "PlayerSpotAmmo" ], [ "who", "TeenGirl" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkTeenGirl ], [ IsWorldTalkTeenGirl ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/SpotAmmo01.vcd" }  //Ammo here!
		{ scenename = "scenes/TeenGirl/SpotAmmo02.vcd" }  //Ammo here!
		{ scenename = "scenes/TeenGirl/SpotAmmo03.vcd" }  //Ammo here!
		{ scenename = "scenes/TeenGirl/SpotAmmo04.vcd" }  //Ammo here!
		{ scenename = "scenes/TeenGirl/SpotAmmo05.vcd" }  //Ammo here!
		{ scenename = "scenes/TeenGirl/SpotAmmo06.vcd" }  //Ammo here!
	],
	group_params = none
}

{
	name = "iMT_SurvivorSpottedBoomerTeenGirl",
	criteria =
	[
		[ "concept", "PlayerWarnBoomer" ], [ "who", "TeenGirl" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkTeenGirl ], [ IsWorldTalkTeenGirl ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/WarnBoomer01.vcd" }  //BOOMER!
		{ scenename = "scenes/TeenGirl/WarnBoomer02.vcd" }  //BOOMER!
		{ scenename = "scenes/TeenGirl/WarnBoomer03.vcd" }  //BOOMER!
	],
	group_params = none
}

{
	name = "iMT_SurvivorSpottedChargerTeenGirl",
	criteria =
	[
		[ "concept", "PlayerWarnCharger" ], [ "who", "TeenGirl" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkTeenGirl ], [ IsWorldTalkTeenGirl ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/DLC1_L4D1Charger01.vcd" }  //CHARGER!
		{ scenename = "scenes/TeenGirl/DLC1_L4D1Charger02.vcd" }  //CHARGER!
		{ scenename = "scenes/TeenGirl/DLC1_L4D1Charger03.vcd" }  //CHARGER!
	],
	group_params = none
}

{
	name = "iMT_SurvivorSpottedHunterTeenGirl",
	criteria =
	[
		[ "concept", "PlayerWarnHunter" ], [ "who", "TeenGirl" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkTeenGirl ], [ IsWorldTalkTeenGirl ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/WarnHunter01.vcd" }  //HUNTER!
		{ scenename = "scenes/TeenGirl/WarnHunter02.vcd" }  //HUNTER!
		{ scenename = "scenes/TeenGirl/WarnHunter03.vcd" }  //HUNTER!
	],
	group_params = none
}

{
	name = "iMT_SurvivorSpottedInfectedTeenGirl",
	criteria =
	[
		[ "concept", "PlayerIncoming" ], [ "who", "TeenGirl" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkTeenGirl ], [ IsWorldTalkTeenGirl ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/Incoming02.vcd" }  //Incoming!
		{ scenename = "scenes/TeenGirl/Incoming04.vcd" }  //They're coming!
		{ scenename = "scenes/TeenGirl/Incoming05.vcd" }  //Here they come!
		{ scenename = "scenes/TeenGirl/Incoming06.vcd" }  //Get ready!
		{ scenename = "scenes/TeenGirl/Incoming07.vcd" }  //Oh god, get ready, here they come!
		{ scenename = "scenes/TeenGirl/Incoming12.vcd" }  //They're coming!
		{ scenename = "scenes/TeenGirl/Incoming13.vcd" }  //Here they come!
		{ scenename = "scenes/TeenGirl/Incoming17.vcd" }  //Incoming!
		{ scenename = "scenes/TeenGirl/Incoming18.vcd" }  //Ohhh crap, get ready!
		{ scenename = "scenes/TeenGirl/Incoming21.vcd" }  //Here they come, boys!
		{ scenename = "scenes/TeenGirl/Incoming23.vcd" }  //Get ready!
		{ scenename = "scenes/TeenGirl/Incoming24.vcd" }  //Get ready, here they come!
		{ scenename = "scenes/TeenGirl/Incoming25.vcd" }  //Hold on, here they come!
	],
	group_params = none
}

{
	name = "iMT_SurvivorSpottedJockeyTeenGirl",
	criteria =
	[
		[ "concept", "PlayerWarnJockey" ], [ "who", "TeenGirl" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkTeenGirl ], [ IsWorldTalkTeenGirl ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/DLC1_L4D1Jockey01.vcd" }  //JOCKEY!
		{ scenename = "scenes/TeenGirl/DLC1_L4D1Jockey02.vcd" }  //JOCKEY!
		{ scenename = "scenes/TeenGirl/DLC1_L4D1Jockey03.vcd" }  //JOCKEY!
	],
	group_params = none
}

{
	name = "iMT_SurvivorSpottedSmokerTeenGirl",
	criteria =
	[
		[ "concept", "PlayerWarnSmoker" ], [ "who", "TeenGirl" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkTeenGirl ], [ IsWorldTalkTeenGirl ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/WarnSmoker01.vcd" }  //SMOKER!
		{ scenename = "scenes/TeenGirl/WarnSmoker02.vcd" }  //SMOKER!
		{ scenename = "scenes/TeenGirl/WarnSmoker03.vcd" }  //SMOKER!
	],
	group_params = none
}

{
	name = "iMT_SurvivorSpottedSpitterTeenGirl",
	criteria =
	[
		[ "concept", "PlayerWarnSpitter" ], [ "who", "TeenGirl" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkTeenGirl ], [ IsWorldTalkTeenGirl ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/DLC1_L4D1Spitter01.vcd" }  //SPITTER!
		{ scenename = "scenes/TeenGirl/DLC1_L4D1Spitter02.vcd" }  //SPITTER!
		{ scenename = "scenes/TeenGirl/DLC1_L4D1Spitter03.vcd" }  //SPITTER!
	],
	group_params = none
}

{
	name = "iMT_SurvivorSpottedTankTeenGirl",
	criteria =
	[
		[ "concept", "PlayerWarnTank" ], [ "who", "TeenGirl" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkTeenGirl ], [ IsWorldTalkTeenGirl ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/WarnTank01.vcd" }  //TANK!
		{ scenename = "scenes/TeenGirl/WarnTank02.vcd" }  //TANK!
		{ scenename = "scenes/TeenGirl/WarnTank04.vcd" }  //TANK!
		{ scenename = "scenes/TeenGirl/WarnTank05.vcd" }  //TANK!
	],
	group_params = none
}

{
	name = "iMT_SurvivorSpottedTanks2TeenGirl",
	criteria =
	[
		[ "concept", "PlayerWarnTank" ], [ "who", "TeenGirl" ], [ "coughing", 0 ], [ "tankactive", 1 ], [ IsTalk ], [ IsTalkTeenGirl ], [ IsWorldTalkTeenGirl ], [ IsZombiePresentTanks2 ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/DLC1_L4D1Tank03.vcd" }  //TWO TANKS!
	],
	group_params = none
}

{
	name = "iMT_SurvivorSpottedWeaponsTeenGirl",
	criteria =
	[
		[ "concept", "PlayerSpotOtherWeapon" ], [ "who", "TeenGirl" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkTeenGirl ], [ IsWorldTalkTeenGirl ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/SpotWeapons01.vcd" }  //Weapons here!
		{ scenename = "scenes/TeenGirl/SpotWeapons02.vcd" }  //Weapons here!
		{ scenename = "scenes/TeenGirl/SpotWeapons03.vcd" }  //Weapons here!
		{ scenename = "scenes/TeenGirl/SpotWeapons04.vcd" }  //Weapons here!
		{ scenename = "scenes/TeenGirl/SpotWeapons05.vcd" }  //Weapons over here!
		{ scenename = "scenes/TeenGirl/SpotWeapons06.vcd" }  //Hey, there's weapon' over here!
	],
	group_params = none
}

{
	name = "iMT_SurvivorSpottedWeapons%TeenGirl",
	criteria =
	[
		[ "concept", "PlayerSpotOtherWeapon" ], [ "who", "TeenGirl" ], [ "coughing", 0 ], [ "randomnum", 0, 5 ], [ IsTalk ], [ IsTalkTeenGirl ], [ IsWorldTalkTeenGirl ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/SpotWeapons07.vcd" }  //Guys, better weapons!
		{ scenename = "scenes/TeenGirl/SpotWeapons08.vcd" }  //Guys, better weapons!
	],
	group_params = none
}

{
	name = "iMT_SurvivorSpottedWitchTeenGirl",
	criteria =
	[
		[ "concept", "PlayerWarnWitch" ], [ "who", "TeenGirl" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkTeenGirl ], [ IsWorldTalkTeenGirl ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/WarnWitch01.vcd" }  //WITCH!
		{ scenename = "scenes/TeenGirl/WarnWitch02.vcd" }  //WITCH!
		{ scenename = "scenes/TeenGirl/WarnWitch03.vcd" }  //WITCH!
		{ scenename = "scenes/TeenGirl/WarnWitch04.vcd" }  //WITCH!
	],
	group_params = none
}

{
	name = "iMT_SurvivorTauntResponseTeenGirl",
	criteria =
	[
		[ "concept", "PlayerTaunt" ], [ "who", "TeenGirl" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkTeenGirl ], [ IsWorldTalkTeenGirl ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/Hurrah01.vcd" }  //Cool.
		{ scenename = "scenes/TeenGirl/Hurrah03.vcd" }  //Awesome!
		{ scenename = "scenes/TeenGirl/Hurrah04.vcd" }  //YESSS!
		{ scenename = "scenes/TeenGirl/Hurrah08.vcd" }  //Looks good.
		{ scenename = "scenes/TeenGirl/Hurrah11.vcd" }  //YEAH!
		{ scenename = "scenes/TeenGirl/Hurrah12.vcd" }  //Oh yeah, lovely.
		{ scenename = "scenes/TeenGirl/Hurrah16.vcd" }  //Oh yeah!
		{ scenename = "scenes/TeenGirl/Hurrah17.vcd" }  //Impressive.
		{ scenename = "scenes/TeenGirl/Hurrah22.vcd" }  //Oh yeah, oh yeah, oh yeah!
		{ scenename = "scenes/TeenGirl/Hurrah34.vcd" }  //Okayyy, okayyy, okay.
		{ scenename = "scenes/TeenGirl/Hurrah51.vcd" }  //Oh god!
		{ scenename = "scenes/TeenGirl/Hurrah52.vcd" }  //Whoo!
		{ scenename = "scenes/TeenGirl/Hurrah56.vcd" }  //Oh man, ha!
		{ scenename = "scenes/TeenGirl/Hurrah57.vcd" }  //Wow.
		{ scenename = "scenes/TeenGirl/ReactionPositive01.vcd" }  //Sweet.
		{ scenename = "scenes/TeenGirl/ReactionPositive02.vcd" }  //Killer.
		{ scenename = "scenes/TeenGirl/ReactionPositive13.vcd" }  //Sweet.
		{ scenename = "scenes/TeenGirl/ReactionPositive14.vcd" }  //Killer.
		{ scenename = "scenes/TeenGirl/Taunt02.vcd" }  //Thats right. [grim, determined]
		{ scenename = "scenes/TeenGirl/Taunt13.vcd" }  //Awesome!
		{ scenename = "scenes/TeenGirl/Taunt18.vcd" }  //All right!
		{ scenename = "scenes/TeenGirl/Taunt19.vcd" }  //Awesome!
		{ scenename = "scenes/TeenGirl/Taunt20.vcd" }  //YEAH!
		{ scenename = "scenes/TeenGirl/Taunt21.vcd" }  //YESSS!
		{ scenename = "scenes/TeenGirl/Taunt24.vcd" }  //Lookin good.
		{ scenename = "scenes/TeenGirl/Taunt25.vcd" }  //Oh yeah!
		{ scenename = "scenes/TeenGirl/Taunt26.vcd" }  //Impressive.
		{ scenename = "scenes/TeenGirl/Taunt28.vcd" }  //Thats right. [grim, determined]
		{ scenename = "scenes/TeenGirl/Taunt29.vcd" }  //Oh yeah, lovely.
		{ scenename = "scenes/TeenGirl/Taunt30.vcd" }  //Lookin good.
		{ scenename = "scenes/TeenGirl/Taunt31.vcd" }  //OH YEAH!
		{ scenename = "scenes/TeenGirl/Taunt34.vcd" }  //Thats right. [grim, determined]
		{ scenename = "scenes/TeenGirl/Taunt35.vcd" }  //YESSS!
		{ scenename = "scenes/TeenGirl/Taunt39.vcd" }  //YEAHHHH!
	],
	group_params = none
}

{
	name = "iMT_SurvivorVocalizeBackUpTeenGirl",
	criteria =
	[
		[ "concept", "PlayerBackUp" ], [ "who", "TeenGirl" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkTeenGirl ], [ IsWorldTalkTeenGirl ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/BackUp01.vcd" }  //Back back back!
		{ scenename = "scenes/TeenGirl/BackUp02.vcd" }  //Back back!
		{ scenename = "scenes/TeenGirl/BackUp04.vcd" }  //Move back!
		{ scenename = "scenes/TeenGirl/BackUp08.vcd" }  //Back it up!
		{ scenename = "scenes/TeenGirl/BackUp09.vcd" }  //Back back!
		{ scenename = "scenes/TeenGirl/BackUp15.vcd" }  //Back up!
		{ scenename = "scenes/TeenGirl/BackUp16.vcd" }  //Move back!
		{ scenename = "scenes/TeenGirl/BackUp17.vcd" }  //Get back!
	],
	group_params = none
}

{
	name = "iMT_SurvivorVocalizeBackUpQuietTeenGirl",
	criteria =
	[
		[ "concept", "PlayerBackUp" ], [ "who", "TeenGirl" ], [ "coughing", 0 ], [ "tankactive", 0 ], [ "incombatmusic", 0 ], [ IsTalk ], [ IsTalkTeenGirl ], [ IsWorldTalkTeenGirl ], [ IsWitchNear ], [ IsNotWitchAggro ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/BackUpQuiet01.vcd" }  //Back up!
		{ scenename = "scenes/TeenGirl/BackUpQuiet02.vcd" }  //Move back!
		{ scenename = "scenes/TeenGirl/BackUpQuiet04.vcd" }  //Back up!
		{ scenename = "scenes/TeenGirl/BackUpQuiet05.vcd" }  //Move back!
		{ scenename = "scenes/TeenGirl/BackUpQuiet06.vcd" }  //Get back!
		{ scenename = "scenes/TeenGirl/BackUpQuiet09.vcd" }  //Get back!
	],
	group_params = none
}

{
	name = "iMT_SurvivorVocalizeEmphaticGoTeenGirl",
	criteria =
	[
		[ "concept", "PlayerEmphaticGo" ], [ "who", "TeenGirl" ], [ "coughing", 0 ], [ IsTalk ], [ IsTalkTeenGirl ], [ IsWorldTalkTeenGirl ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/EmphaticGo01.vcd" }  //Go go go!
		{ scenename = "scenes/TeenGirl/EmphaticGo02.vcd" }  //Go go go!
		{ scenename = "scenes/TeenGirl/EmphaticGo04.vcd" }  //Move move move!
		{ scenename = "scenes/TeenGirl/EmphaticGo05.vcd" }  //Move move!
		{ scenename = "scenes/TeenGirl/EmphaticGo06.vcd" }  //GO!
		{ scenename = "scenes/TeenGirl/EmphaticGo07.vcd" }  //GO!
		{ scenename = "scenes/TeenGirl/EmphaticGo08.vcd" }  //Go!
		{ scenename = "scenes/TeenGirl/EmphaticGo09.vcd" }  //MOVE!
		{ scenename = "scenes/TeenGirl/EmphaticGo10.vcd" }  //Come on, move!
		{ scenename = "scenes/TeenGirl/EmphaticGo11.vcd" }  //Let's go, let's go!
		{ scenename = "scenes/TeenGirl/EmphaticGo12.vcd" }  //Go go go!
		{ scenename = "scenes/TeenGirl/EmphaticGo15.vcd" }  //Move move move!
		{ scenename = "scenes/TeenGirl/EmphaticGo21.vcd" }  //Come on, move!
		{ scenename = "scenes/TeenGirl/EmphaticGo22.vcd" }  //Let's go, let's go!
		{ scenename = "scenes/TeenGirl/EmphaticGo23.vcd" }  //Come on, move!
	],
	group_params = none
}

{
	name = "iMT_SurvivorVocalizeLookOutTeenGirl",
	criteria =
	[
		[ "concept", "PlayerLookOut" ], [ "who", "TeenGirl" ], [ "coughing", 0 ], [ "world_auto_finale", 2 ], [ IsTalk ], [ IsTalkTeenGirl ], [ IsWorldTalkTeenGirl ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/LookOut01.vcd" }  //Look out!
		{ scenename = "scenes/TeenGirl/LookOut03.vcd" }  //Watch out!
		{ scenename = "scenes/TeenGirl/LookOut08.vcd" }  //Behind you!!
	],
	group_params = none
}

{
	name = "iMT_SurvivorVocalizeLookOutCoachTeenGirl",
	criteria =
	[
		[ "concept", "PlayerLookOut" ], [ "who", "TeenGirl" ], [ "coughing", 0 ], [ "subject", "Coach" ], [ "dist_from_subject", 0, 799 ], [ "world_auto_finale", 2 ], [ "randomnum", 0, 30 ], [ IsTalk ], [ IsTalkTeenGirl ], [ IsWorldTalkTeenGirl ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/DLC1_C6M3_L4D11stSpot03.vcd" }  //Watch out Coach!
	],
	group_params = none
}

{
	name = "iMT_SurvivorVocalizeLookOutGamblerTeenGirl",
	criteria =
	[
		[ "concept", "PlayerLookOut" ], [ "who", "TeenGirl" ], [ "coughing", 0 ], [ "subject", "Gambler" ], [ "dist_from_subject", 0, 799 ], [ "world_auto_finale", 2 ], [ "randomnum", 0, 30 ], [ IsTalk ], [ IsTalkTeenGirl ], [ IsWorldTalkTeenGirl ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/DLC1_C6M3_L4D11stSpot04.vcd" }  //Watch out Nick!
	],
	group_params = none
}

{
	name = "iMT_SurvivorVocalizeLookOutMechanicTeenGirl",
	criteria =
	[
		[ "concept", "PlayerLookOut" ], [ "who", "TeenGirl" ], [ "coughing", 0 ], [ "subject", "Mechanic" ], [ "dist_from_subject", 0, 799 ], [ "world_auto_finale", 2 ], [ "randomnum", 0, 30 ], [ IsTalk ], [ IsTalkTeenGirl ], [ IsWorldTalkTeenGirl ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/DLC1_C6M3_L4D11stSpot05.vcd" }  //Watch out Ellis!
		{ scenename = "scenes/TeenGirl/DLC1_C6M3_L4D11stSpot06.vcd" }  //Ellis be careful!
	],
	group_params = none
}

{
	name = "iMT_SurvivorVocalizeLookOutProducerTeenGirl",
	criteria =
	[
		[ "concept", "PlayerLookOut" ], [ "who", "TeenGirl" ], [ "coughing", 0 ], [ "subject", "Producer" ], [ "dist_from_subject", 0, 799 ], [ "world_auto_finale", 2 ], [ "randomnum", 0, 30 ], [ IsTalk ], [ IsTalkTeenGirl ], [ IsWorldTalkTeenGirl ]
	],
	responses =
	[
		{ scenename = "scenes/TeenGirl/DLC1_C6M3_L4D11stSpot02.vcd" }  //Watch out Rochelle!
	],
	group_params = none
}

//--------------------------------------------------------------------------------------------------
// Start Area
//--------------------------------------------------------------------------------------------------

{
	name = "iMT_EllisStoryInterruptGenericTeenGirl",
	criteria =
	[
		[ "concept", "EllisInterrupt" ], [ "who", "TeenGirl" ], [ "world_auto_tellingstory", 1 ], [ _auto_NotDidInterrupt ]
	],
	responses =
	[
		{
			scenename = "scenes/TeenGirl/C6DLC3FirstSafeRoom01.vcd", followup = RThen( "Mechanic", "EllisStoryReac01", null, 0.3 ),  //I really don't want to hear it.
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
	name = "iMT_SafeRoomStartTeenGirl",
	criteria =
	[
		[ "concept", "TLK_IDLE" ], [ "who", "TeenGirl" ], [ "instartarea", 1 ], [ IsNotScavenge ], [ IsNotSurvival ], [ _auto_NotSafeRoomStart ]
	],
	responses =
	[
		{
			scenename = "scenes/TeenGirl/Blank.vcd",
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

rr_ProcessRules( TeenGirl )