//--------------------------------------------------------------------------------------------------
// ion's Vocalizer: NPCs Response Rules
//--------------------------------------------------------------------------------------------------

local NPCs =
[

// John Slater

{
	name = "iMT_Boatman",
	criteria =
	[
		[ "concept", "iMT_Boatman" ], [ "team", "Survivor" ]
	],
	responses =
	[
		{ soundname = "npc.boatman_RadioButton108" }  //They're gonna swarm when we come in. Stock up and radio back when you're ready.
		{ soundname = "npc.boatman_RadioButton110" }  //We're heading to the military outpost upriver. We can come get you in ten minutes. Arm yourselves for the trip and tell me where to head out.
		{ soundname = "npc.boatman_RadioButton124" }  //Police, radio us back when you are ready for pickup!
		{ soundname = "npc.boatman_RadioButton212" }  //Allright, we're on our way. Make sure you clear the area. I don't want our first act of kindness to be our last.
		{ soundname = "npc.boatman_RadioInitialBroadCast02" }  //If there is anyone out there. This is John and Amanda Slater. We are a small fishing vessel anchored off Riverside.
		{ soundname = "npc.boatman_RadioInitialBroadCast03" }  //If there are any survivors, please respond.
		{ soundname = "npc.boatman_RadioInitialBroadCast05" }  //If you can hear me, please respond!
		{ soundname = "npc.boatman_RadioInitialBroadCast07" }  //Is there anybody out there?
		{ soundname = "npc.boatman_RadioInitialBroadCast08" }  //John and Amanda Slater! We are a fishing vessel anchored off Riverside! Come in please!
		{ soundname = "npc.boatman_RadioInitialBroadCast09" }  //Come in, refugees! If you can hear this.
		{ soundname = "npc.boatman_RadioInitialBroadCast11" }  //Anybody? Come on, please respond.
		{ soundname = "npc.boatman_RadioInitialBroadCast12" }  //We have provisions and a route to safety. We just need to get there alive. Anyone with firepower, respond.
		{ soundname = "npc.boatman_RadioInitialBroadCast13" }  //We will ferry anyone with firearms and ammo. Please respond.
		{ soundname = "npc.boatman_RadioInitialBroadCast14" }  //We are anchored off Riverside. Anyone on this frequency with weapons and ammo, please respond.
		{ soundname = "npc.boatman_RadioInitialBroadCast15" }  //Attention anyone with ammo and firearms. If you can hear me, please respond.
		{ soundname = "npc.boatman_RadioInitialBroadCast16" }  //Anyone with some firepower on this frequency, pick up.
		{ soundname = "npc.boatman_RadioInitialBroadCast17" }  //Come in, anyone armed. Please pick up.
		{ soundname = "npc.boatman_RadioInitialBroadCast18" }  //If you can hear me, pick up!
		{ soundname = "npc.boatman_RadioInitialBroadCast19" }  //If you're out there and you're armed, pick up!
		{ soundname = "npc.boatman_RadioNag01" }  //Tell us when you are ready to be picked up!
		{ soundname = "npc.boatman_RadioNag02" }  //Let us know when you're ready to be picked up!
		{ soundname = "npc.boatman_RadioNag03" }  //Tell us when you are ready to be picked up!
		{ soundname = "npc.boatman_RadioNag04" }  //Let us know when you're ready to be picked up!
		{ soundname = "npc.boatman_RadioNag05" }  //Use the radio to let us know when you're ready for pickup!
		{ soundname = "npc.boatman_RadioNag07" }  //Police: Let us know when you're ready to be picked up.
	],
	group_params = none
}

// Chopper pilot

{
	name = "iMT_ChopperPilot",
	criteria =
	[
		[ "concept", "iMT_ChopperPilot" ], [ "team", "Survivor" ]
	],
	responses =
	[
		{ soundname = "npc.ChopperPilot_hospital_finale_intransit_01" }  //Mercy Hospital, going to be running a bit late, just had a... an incident. News Chopper 5 out.
		{ soundname = "npc.ChopperPilot_hospital_finale_intransit_02" }  //News Chopper 5 to Mercy Hospital, ETA 10 minutes. News Chopper 5 out.
		{ soundname = "npc.ChopperPilot_hospital_finale_intransit_03" }  //News Chopper 5 to Mercy Hospital, ETA 7 minutes. News Chopper 5 out.
		{ soundname = "npc.ChopperPilot_hospital_finale_intransit_04" }  //News Chopper 5 to Mercy Hospital, looks like you are going to be my final run.
		{ soundname = "npc.ChopperPilot_hospital_finale_intransit_05" }  //News Chopper 5 to Mercy Hospital, ETA 5 minutes. 5 Minutes.
		{ soundname = "npc.ChopperPilot_hospital_finale_intransit_06" }  //I have a visual, Mercy Hospital, looks you have your hands full.
		{ soundname = "npc.ChopperPilot_hospital_finale_intransit_07" }  //Mercy Hospital, you need to kill that Tank before I can land!
		{ soundname = "npc.ChopperPilot_hospital_finale_intransit_08" }  //Mercy Hospital, you need to kill any Tanks before I can pick you up.
		{ soundname = "npc.ChopperPilot_hospital_finale_intransit_09" }  //No way I can land, I'm going to have to come in hot next to the pad.
		{ soundname = "npc.ChopperPilot_hospital_finale_intransit_10" }  //Mercy Hospital, get to the landing pad! Repeat. Get to the landing pad!
		{ soundname = "npc.ChopperPilot_hospital_finale_onmyway_01" }  //Okay I am on my way. ETA 15 minutes. Just hang in there. News Chopper 5 out.
		{ soundname = "npc.ChopperPilot_hospital_finale_onmyway_02" }  //I'm on my way. ETA 15 minutes. News Chopper 5 out.
		{ soundname = "npc.ChopperPilot_hospital_finale_onmyway_03" }  //Mercy Hospital, that was quick, I hope you prepared. I'm on my way. ETA 15 minutes. News Chopper 5 out.
		{ soundname = "npc.ChopperPilot_hospital_finale_pickup_01" }  //Mercy Hospital are you there?
		{ soundname = "npc.ChopperPilot_hospital_finale_pickup_02" }  //Mercy Hospital are you there?
		{ soundname = "npc.ChopperPilot_hospital_finale_pickup_03" }  //Pickup Mercy Hospital, Pickup.
		{ soundname = "npc.ChopperPilot_hospital_finale_pickup_04" }  //News Chopper 5 to Mercy Hospital.
		{ soundname = "npc.ChopperPilot_hospital_finale_pickup_05" }  //Mercy Hospital respond if you are there.
		{ soundname = "npc.ChopperPilot_hospital_finale_pickup_06" }  //Mercy Hospital pick up the radio if you are there.
		{ soundname = "npc.ChopperPilot_hospital_finale_pickup_07" }  //Mercy Hospital use the radio if you are there.
	],
	group_params = none
}

// Church guy

{
	name = "iMT_ChurchGuy",
	criteria =
	[
		[ "concept", "iMT_ChurchGuy" ], [ "team", "Survivor" ]
	],
	responses =
	[
		{ soundname = "npc.churchguy_RadioButton101" }  //No one gets in here until I know you're immune!
		{ soundname = "npc.churchguy_RadioButton105" }  //I'm gonna ring this bell. I'm going to ring this bell! And they'll come! And they'll finish the job.
		{ soundname = "npc.churchguy_RadioButton106" }  //No! My safehouse! I've got the bell! You stay the hell out!
		{ soundname = "npc.churchguy_RadioButton107" }  //My safehouse! Come here! No! Stay out! Slide your guns under the door! No! Go away! Better safe than sorry!
		{ soundname = "npc.churchguy_RadioButton1Extended03" }  //Nonono! You said that last time! You said that last time. I trusted you last time!
		{ soundname = "npc.churchguy_RadioButton1Extended10" }  //Only when you can prove you're immune. And I know just how to do it.
		{ soundname = "npc.churchguy_RadioButton1Extended11" }  //Only when I know you're human. Get ready for the test.
		{ soundname = "npc.churchguy_RadioButton1Extended12" }  //I'm the one who decides who gets through this door.
		{ soundname = "npc.churchguy_RadioButton1Extended13" }  //I - I opened the door before, and I got bit for my trouble. Better safe than sorry. Better safe than sorry!
		{ soundname = "npc.churchguy_RadioButton1Extended16" }  //Do you think I care how old you are?
		{ soundname = "npc.churchguy_RadioButton1Extended19" }  //You think you're special with your leather jackets and your fancy blood?
		{ soundname = "npc.churchguy_RadioButton1Extended20" }  //Nobody rides for free! Ding dong!
		{ soundname = "npc.churchguy_RadioButton1Extended21" }  //I am not a mental moron!
		{ soundname = "npc.churchguy_RadioButton1Extended25" }  //You don't sound like cops!
		{ soundname = "npc.churchguy_RadioButton1Extended28" }  //Your word means shit to me!
		{ soundname = "npc.churchguy_RadioButton1Extended34" }  //I'm not letting you in until I'm sure you're immune.
		{ soundname = "npc.churchguy_RadioButton1Extended35" }  //Not infected? Not infected? Prove it!
		{ soundname = "npc.churchguy_RadioButton1Extended40" }  //Ding dong! Ding dong!
		{ soundname = "npc.churchguy_RadioButton1Extended43" }  //Dinner's served! Come and get it!
		{ soundname = "npc.churchguy_RadioInitialBroadCast01" }  //I trusted you. You said you were immune. You said you were immune.
		{ soundname = "npc.churchguy_RadioInitialBroadCast02" }  //I trusted you. You said you were immune. You said you were immune. Better safe than sorry.
		{ soundname = "npc.churchguy_RadioInitialBroadCast03" }  //Better safe than sorry. I can't believe he bit me. Never should have let him in.
		{ soundname = "npc.churchguy_RadioInitialBroadCast04" }  //Won't fool me twice. I can't believe he bit me, I can't believe he bit me.
		{ soundname = "npc.churchguy_RadioInitialBroadCast05" }  //Better safe than sorry. No matter how human they look. Won't be fooled twice.
		{ soundname = "npc.churchguy_RadioInitialBroadCast06" }  //It's been an hour. Been an hour. Must be immune. That's right, must be immune. No. I have to be immune.
		{ soundname = "npc.churchguy_RadioInitialBroadCast07" }  //Better safe than sorry. Better safe than sorry. Better safe than sorry. Better safe than sorry.
		{ soundname = "npc.churchguy_RadioInitialBroadCast24" }  //Better safe than sorry. Better safe than sorry.
	],
	group_params = none
}

// Moustachio

{
	name = "iMT_Moustachio",
	criteria =
	[
		[ "concept", "iMT_Moustachio" ], [ "team", "Survivor" ]
	],
	responses =
	[
		{ soundname = "Moustachio_StrengthAttract01" }  //Yes! YES!
		{ soundname = "Moustachio_StrengthAttract02" }  //[Laughter]
		{ soundname = "Moustachio_StrengthAttract03" }  //Moustachio!
		{ soundname = "Moustachio_StrengthAttract04" }  //Moustachio!
		{ soundname = "Moustachio_StrengthAttract05" }  //[Laughter]
		{ soundname = "Moustachio_StrengthAttract06" }  //[Laughter]
		{ soundname = "Moustachio_StrengthAttract07" }  //Moustachio!
		{ soundname = "Moustachio_StrengthAttract08" }  //Grrrrr!
		{ soundname = "Moustachio_StrengthAttract09" }  //[Laughter]
		{ soundname = "Moustachio_StrengthAttract10" }  //Test Your Strength! Grrrr!
		{ soundname = "Moustachio_StrengthBreakMachine" }  //Moustachio!
		{ soundname = "Moustachio_StrengthLvl1_LittlePeanut" }  //L'il peanut, SO WEAK!
		{ soundname = "Moustachio_StrengthLvl2_BabyPeanut" }  //Baby peanut. WEAK!
		{ soundname = "Moustachio_StrengthLvl3_OldPeanut" }  //Old peanut! HA HA HA HA!
		{ soundname = "Moustachio_StrengthLvl4_NotBad" }  //Not bad, ha ha! Moustachio!
		{ soundname = "Moustachio_StrengthLvl5_SoStrong" }  //So Strong! Grrrr!
	],
	group_params = none
}

// Plane pilot

{
	name = "iMT_PlanePilot",
	criteria =
	[
		[ "concept", "iMT_PlanePilot" ], [ "team", "Survivor" ]
	],
	responses =
	[
		{ soundname = "npc.planepilot_RadioArrived01" }  //Alright, we're fueled up! Get in!
		{ soundname = "npc.planepilot_RadioArrived10" }  //What're you waitin' for, your row to be called? Get in!
		{ soundname = "npc.planepilot_RadioButton104" }  //The pump's gonna make a real racket. So you make sure you're ready for a fight before you start 'er up.
		{ soundname = "npc.planepilot_RadioButton105" }  //Alright! Gas me up, and we can fly out of here!
		{ soundname = "npc.planepilot_RadioButton203" }  //That did it! I can hear the truck pumpin'!
		{ soundname = "npc.planepilot_RadioButton205" }  //Hold 'em off for me while I fuel up!
		{ soundname = "npc.planepilot_RadioCombatColor08" }  //You're doing great!
		{ soundname = "npc.planepilot_RadioCombatColor28" }  //More comin'. Look alive.
		{ soundname = "npc.planepilot_RadioCombatColor29" }  //Look out! More on the way!
		{ soundname = "npc.planepilot_RadioInitialBroadCast06" }  //Hey! You there! Y'all wanna get me fueled up?
		{ soundname = "npc.planepilot_RadioInitialBroadCast07" }  //Hey there! Don't suppose y'all wanna gas me up?
		{ soundname = "npc.planepilot_RadioInitialBroadCast09" }  //Hey! You there! Gas me up, I'll getcha outta here!
		{ soundname = "npc.planepilot_RadioInitialBroadCast10" }  //I get fuelled up, I can git goin here! Come on, you folks with me?
		{ soundname = "npc.planepilot_RadioInitialBroadCast18" }  //You! Yes you! Come talk to me on the radio!
		{ soundname = "npc.planepilot_RadioInTransit01" }  //Gas tank's a quarter full! Sorry, guys, still a ways yet!
		{ soundname = "npc.planepilot_RadioInTransit02" }  //Fuel gauge at halfway, folks! Hang in there!
		{ soundname = "npc.planepilot_RadioInTransit03" }  //Fuel gauge at three-quarters, people! Almost there!
		{ soundname = "npc.planepilot_RadioInTransit04" }  //Fuel gauge near the top! We are just about good to go!
		{ soundname = "npc.planepilot_RadioInTransit05" }  //Gas tank's almost full! We are just about good to go!
		{ soundname = "npc.planepilot_RadioNag04" }  //Hit the fuel button and let's get outta here!
	],
	group_params = none
}

// Military

{
	name = "iMT_Rescue9",
	criteria =
	[
		[ "concept", "iMT_Rescue9" ], [ "team", "Survivor" ]
	],
	responses =
	[
		{ soundname = "npc.soldier_RadioButton101" }  //Holy shit. Captain, someone actually responded!
		{ soundname = "npc.soldier_RadioButton105" }  //We'll come get you! Convoy's gonna stir up the infected, though. Prepare yourselves and advise when ready.
		{ soundname = "npc.soldier_RadioButton108" }  //I do not believe it. Captain, somebody's survived out there!
		{ soundname = "npc.soldier_RadioButton109" }  //Jesus Christ. Captain, we got somebody alive out there!
		{ soundname = "npc.soldier_RadioButton110" }  //Jesus Christ. Captain, we got survivors. They say they're cops!
		{ soundname = "npc.soldier_RadioButton113" }  //We read you loud and clear, survivors! We are prepping an extraction team. Prepare yourselves and radio back when you're ready.
		{ soundname = "npc.soldier_RadioButton201" }  //Read you loud and clear! Get ready, we're on our way!
		{ soundname = "npc.soldier_RadioButton202" }  //We are prepped and good to go. Advise when ready!
		{ soundname = "npc.soldier_RadioButton205" }  //We read you just fine. We're on our way.
		{ soundname = "npc.soldier_RadioButton206" }  //Roger that, survivors. We are on our way.
		{ soundname = "npc.soldier_RadioButton207" }  //Roger, survivors, we are go. ETA in ten minutes.
		{ soundname = "npc.soldier_RadioButton208" }  //That is a go, survivors. Be advised it will take us ten minutes to reach you.
		{ soundname = "npc.soldier_RadioButton209" }  //Copy that, survivors. It'll take us a good ten minutes to reach you. Dig in and hold on, you got me?
		{ soundname = "npc.soldier_RadioButton210" }  //Copy that, survivors. We're coming for you! Hang on!
		{ soundname = "npc.soldier_RadioInitialBroadCast01" }  //This is an emergency broadcast from the American Safety Zone. Please respond.
		{ soundname = "npc.soldier_RadioInitialBroadCast06" }  //This is an emergency broadcast from the US Military. Please respond.
		{ soundname = "npc.soldier_RadioNag01" }  //Please advise when ready!
		{ soundname = "npc.soldier_RadioNag02" }  //Please advise when ready.
	],
	group_params = none
}

// Soldiers

{
	name = "iMT_Soldiers",
	criteria =
	[
		[ "concept", "iMT_Soldiers" ], [ "team", "Survivor" ]
	],
	responses =
	[
		{ soundname = "Soldier1_Chatter01" }  //Rescue Seven, this is Papa Gator. Over.
		{ soundname = "Soldier2_Chatter01" }  //This is Rescue 7. Over.
		{ soundname = "Soldier1_Chatter02" }  //Rescue 7, what is your repair status. Over.
		{ soundname = "Soldier2_Chatter03" }  //Repair ETA is ten minutes. Over.
		{ soundname = "Soldier1_Chatter03" }  //Did not copy. Say again, Rescue 7. Over.
		{ soundname = "Soldier2_Chatter04" }  //Ten minutes. Over.
		{ soundname = "Soldier1_Chatter04" }  //Copy that. All lambs extracted. Last Buzzard starts run in fifteen minutes. Copy that? Over.
		{ soundname = "Soldier2_Chatter05" }  //Roger, Papa Gator. Fifteen minutes. Ah, be advised we have seen flashes on the west bank. Ah, visually confirm west bank is clear. Over.
		{ soundname = "Soldier1_Chatter05" }  //West bank is clear, Rescue 7. Ah, sector is clear. Over.
		{ soundname = "Soldier2_Chatter06" }  //Negative. We are seeing something. Over.
		{ soundname = "Soldier1_Chatter06" }  //Rescue Seven, are you, ah, seeing Whiskey Delta? Or friendly? Over.
		{ soundname = "Soldier2_Chatter08" }  //Ahh, unclear. It-
		{ soundname = "Soldier1_Chatter07" }  //Whisky Delta or, ah, friendly? Over.
		{ soundname = "Soldier2_Chatter09" }  //Papa Gator, we're not sure. We are seeing, ah, multiple personnel and small arms fire. What is our current ROE? Over.
		{ soundname = "Soldier1_Chatter08" }  //Rescue 7, all lost lambs are accounted for. Targets should be considered hostile. Only prosecute targets that are a clear threat. Over.
		{ soundname = "Soldier2_Chatter10" }  //Roger, Papa Gator. All personnel on floating LZ. Clear for last Buzzard run. Over.
		{ soundname = "Soldier1_Chatter09" }  //Affirmative, Rescue 7. Keep the bridge deck clear. Last Buzzard will start run in fifteen minutes. Out.
		{ soundname = "Soldier2_Chatter12" }  //Ah-firmative. Out.
		{ soundname = "Soldier1_SurvivorTalk01" }  //Rescue 7, that's coming from the bridge!
		{ soundname = "Soldier1_SurvivorTalk02" }  //Bridge, identify yourself.
		{ soundname = "Soldier1_SurvivorTalk03" }  //Bridge, who is this?
		{ soundname = "Soldier1_SurvivorTalk04" }  //Bridge, are you immune?
		{ soundname = "Soldier1_SurvivorTalk05" }  //Negative Bridge. Are you IMMUNE? Have you encountered the infected?
		{ soundname = "Soldier1_SurvivorTalk06" }  //Rescue Seven, are you equipped for carriers?
		{ soundname = "Soldier2_SurvivorTalk02" }  //Affirmative, Papa Gator.
		{ soundname = "Soldier1_SurvivorTalk08" }  //Bridge, that sector is clear of friendlies. Your only remaining pickup is on the east bank of the bridge. Our last chopper is leaving in 10 minutes. You need to lower the span and get across to the east end.
		{ soundname = "Soldier1_SurvivorTalk09" }  //Be advised: The bridge is crawling with Whiskey Delta.
		{ soundname = "Soldier1_SurvivorTalk13" }  //God be with you, bridge.
	],
	group_params = sequential
}

// Virgil

{
	name = "iMT_Virgil",
	criteria =
	[
		[ "concept", "iMT_Virgil" ], [ "team", "Survivor" ]
	],
	responses =
	[
		{ soundname = "Virgil_C3End01" }  //Well hello there. I ain't heard another voice out here in three days.
		{ soundname = "Virgil_C3End02" }  //Woo, hello. It's been real real quiet now since my woman got bit.
		{ soundname = "Virgil_C3End03" }  //Woo, hello there. Well, I ain't heard nothin' from nobody in three days. What can I do for ya?
		{ soundname = "Virgil_C3End04" }  //Who dat there? How is y'all are? Where you at?
		{ soundname = "Virgil_C3End05" }  //Woo, hello there. How is y'all are? I ain't heard a nobody out here in a long time. What can I do for ya?
		{ soundname = "Virgil_C3End06" }  //Hello there. It's been real quiet out here on the water, I ain't heard nobody in three days. Tell me what can I do for ya, now?
		{ soundname = "Virgil_C3End07" }  //Well who dat there? Hey now, how is y'all are? Where you at?
		{ soundname = "Virgil_C3End08" }  //Woo, well, how is y'all are? . It's been real quiet out here on the water since my wife got bit. Tell me, what can I do for ya now?
		{ soundname = "Virgil_C3End09" }  //Hey now, where're you at?
		{ soundname = "Virgil_C3End10" }  //Where is y'are?
		{ soundname = "Virgil_C3End11" }  //Tell me now, where is ya?
		{ soundname = "Virgil_C3End12" }  //Where is ya?
		{ soundname = "Virgil_C3End13" }  //Now, where're you at?
		{ soundname = "Virgil_C3End14" }  //What?
		{ soundname = "Virgil_C3End15" }  //Say again now, what?
		{ soundname = "Virgil_C3End16" }  //Now, what, now?
		{ soundname = "Virgil_C3End17" }  //I can't quite hear ya now. Say what, now?
		{ soundname = "Virgil_C3End18" }  //Now how many of y'all is there?
		{ soundname = "Virgil_C3End19" }  //How many of ya is y'all are?
		{ soundname = "Virgil_C3End20" }  //How many is there of y'all?
		{ soundname = "Virgil_C3End21" }  //How many of y'all is ya?
		{ soundname = "Virgil_C3End22" }  //Now tell me now, how many of ya is y'all?
		{ soundname = "Virgil_C3End23" }  //How many of y'all are ya?
		{ soundname = "Virgil_C3End24" }  //Alright now, stay right where you is. I'll come for ya.
		{ soundname = "Virgil_C3End25" }  //Alright now, stay right where you is. I'll be right there for ya.
		{ soundname = "Virgil_C3End26" }  //Alright now, stay right where you is at. I'm be comin' for ya.
		{ soundname = "Virgil_C3End27" }  //Alright now, stay right where's you at. I'm comin' for ya.
		{ soundname = "Virgil_C3End28" }  //Alright now, stay right where y'all are. I'll be right at ya.
		{ soundname = "Virgil_C3End29" }  //Okay now, stay right where you are. I'm comin' for ya now.
		{ soundname = "Virgil_C3End30" }  //Alright, real good. I'm comin' for ya now. Stay right where y'all are.
		{ soundname = "Virgil_C3End31" }  //Woo, bonjour! It's real, real nice to hear another somebody.
		{ soundname = "Virgil_C3End32" }  //Well, bonjour! It's real, real good to hear another somebody. It's real quiet out here.
		{ soundname = "Virgil_C3End33" }  //Bonjour! Oh, it's real, real good to hear from somebody. It's been quiet out here, now.
		{ soundname = "Virgil_C3End34" }  //Alright now, where y'at?
		{ soundname = "Virgil_C3End35" }  //Where y'at?
		{ soundname = "Virgil_C3End36" }  //Where is ya?
		{ soundname = "Virgil_C3End37" }  //Where is y'all?
		{ soundname = "Virgil_C3End38" }  //Where y'all at now?
		{ soundname = "Virgil_C3End39" }  //Alright now tell me, where y'all are?
		{ soundname = "Virgil_C3End40" }  //Where y'all at?
	],
	group_params = none
}

// Whitaker

{
	name = "iMT_Whitaker",
	criteria =
	[
		[ "concept", "iMT_Whitaker" ], [ "team", "Survivor" ]
	],
	responses =
	[
		{ soundname = "Whitaker_ComeUpstairs01" }  //Well, hello there. Why don't you grab yourselves some of my guns and come on upstairs. I got something you can help me with.
		{ soundname = "Whitaker_ComeUpstairs02" }  //Hello there. My name's Whitaker. I own this establishment. Take anything you need and come on upstairs when you're done.
		{ soundname = "Whitaker_ComeUpstairs03" }  //There ain't much time. Grab yourselves a gun and come upstairs, I'll explain on the way.
		{ soundname = "Whitaker_ComeUpstairsLongerA01" }  //Well, now. This might just work out after all.
		{ soundname = "Whitaker_ComeUpstairsLongerA02" }  //Help yourself to the weapons. Take anything you need.
		{ soundname = "Whitaker_ComeUpstairsLongerA03" }  //I'm in a bit of a quandary, you see, and I suspect you're just the people to help me out of it.
		{ soundname = "Whitaker_ComeUpstairsLongerA04" }  //Come on upstairs when you're done.
		{ soundname = "Whitaker_ComeUpstairsLongerB01" }  //Well, now. This might just work out after all.
		{ soundname = "Whitaker_ComeUpstairsLongerB02" }  //Help yourself to MY weapons.
		{ soundname = "Whitaker_ComeUpstairsLongerB03" }  //Take anything you need. I'm in a bit of a quandary, you see, and...
		{ soundname = "Whitaker_ComeUpstairsLongerB04" }  //GET YOUR HANDS OFF MY STORE YOU SON OF A BITCH.
		{ soundname = "Whitaker_ComeUpstairsLongerB05" }  //and I suspect you're just the people to help me out of it.
		{ soundname = "Whitaker_ComeUpstairsLongerB06" }  //Come on upstairs when you're done.
		{ soundname = "Whitaker_ComeUpstairsLongerC01" }  //Hello there. Now, normally when four bloodstained looters break into my store, I would shoot them where they stand.
		{ soundname = "Whitaker_ComeUpstairsLongerC02" }  //But you happen to have caught me at an opportune time.
		{ soundname = "Whitaker_ComeUpstairsLongerC03" }  //Take what weapons you need and come on upstairs. I reckon we can come to an accordance.
		{ soundname = "Whitaker_ComeUpstairsLongerD01" }  //Hello there.
		{ soundname = "Whitaker_ComeUpstairsLongerD02" }  //Now, normally when four bloodstained looters break into my store, I would shoot them where they stand.
		{ soundname = "Whitaker_ComeUpstairsLongerD03" }  //But you happen to have caught me at...
		{ soundname = "Whitaker_ComeUpstairsLongerD04" }  //get your hands off my store.
		{ soundname = "Whitaker_ComeUpstairsLongerD05" }  //caught me at an opportune time.
		{ soundname = "Whitaker_ComeUpstairsLongerD06" }  //Take what weapons you need and come on upstairs. I reckon...
		{ soundname = "Whitaker_ComeUpstairsLongerD07" }  //Climb that, you green-skinned sonofabitch.
		{ soundname = "Whitaker_ComeUpstairsLongerD08" }  //Reckon we can come to an accordance.
		{ soundname = "Whitaker_MissionCompleted11" }  //Much obliged. Now go screw yourselves, I ain't helpin'. [laughs] I just wanted to see the looks on your faces. Here you go.
		{ soundname = "Whitaker_WayBlockedLongerD01" }  //Cola and nuts is a weakness of mine-though I do not love it so much that I'd be fool enough to die in the attempt to procure it.
	],
	group_params = none
}

]

rr_ProcessRules( NPCs )