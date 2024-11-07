//--------------------------------------------------------------------------------------------------
// ion's Vocalizer: Functions
//--------------------------------------------------------------------------------------------------

// Conversion functions

local lower_case_table_delegate =
{
	function _get( key )
	{
		local lowerkey = key.tolower()
		if ( lowerkey in this )
			return this[ lowerkey ]
		return 0
	}
}

local case_insensitive =
{
	function _get( key )
	{
		local lower_case_table = {}.setdelegate( lower_case_table_delegate )
		foreach ( crit, val in this )
			lower_case_table[ crit.tolower() ] <- val

		this.setdelegate( lower_case_table )

		local lowerkey = key.tolower()
		if ( lowerkey in lower_case_table )
			return lower_case_table[ lowerkey ]
		return 0
	}
}


// Criteria functions

_auto_NotDidInterrupt <- function( query )
{
	return ResponseCriteria.GetValue( Entities.First(), "world_auto_didinterrupt" ) != "1"
}

_auto_NotInSewer <- function( query )
{
	return !ResponseCriteria.HasCriterion( Entities.First(), "world_auto_insewer" )
}

_auto_NotTellingStory <- function( query )
{
	return ResponseCriteria.GetValue( Entities.First(), "world_auto_tellingstory" ) != "1"
}

_auto_NotSafeRoomStart <- function( query )
{
	return !ResponseCriteria.HasCriterion( Entities.First(), "world_auto_saferoomstart" )
}

AddWeight <- function( query )
{
	return true
}

C1M1orC1M2 <- function( query )
{
	return Director.GetMapName() == "c1m1_hotel" || Director.GetMapName() == "c1m2_streets"
}

IsCampaign4 <- function( query )
{
	return Director.GetMapName() == "c4m3_sugarmill_b" || Director.GetMapName() == "c4m4_milltown_b" || Director.GetMapName() == "c4m5_milltown_escape"
}

IsCampaign5 <- function( query )
{
	return Director.GetMapName() == "c5m2_park" || Director.GetMapName() == "c5m3_cemetery" || Director.GetMapName() == "c5m4_quarter"
}

IsInSugarMill <- function( query )
{
	return Director.GetMapName() == "c4m2_sugarmill_a" || Director.GetMapName() == "c4m3_sugarmill_b"
}

IsInSwamp <- function( query )
{
	return Director.GetMapName() == "c3m2_swamp" || Director.GetMapName() == "c3m3_shantytown"
}

IsNotC1M1 <- function( query )
{
	return Director.GetMapName() != "c1m1_hotel"
}

IsNotC1M2 <- function( query )
{
	return Director.GetMapName() != "c1m2_streets"
}

IsNotFirstKillC1 <- function( query )
{
	return !ResponseCriteria.HasCriterion( Entities.First(), "worldfirstkill" )
}

IsNotHealthy <- function( query )
{
	query.setdelegate( case_insensitive )

	return query.CurrentHealth + query.CurrentTemporaryHealth < 40
}

IsNotSaidc5m3manhole <- function( query )
{
	return !ResponseCriteria.HasCriterion( Entities.First(), "worldsaidc5m3manhole" )
}

IsNotSaidSafeSpotAhead <- function( query )
{
	return !ResponseCriteria.HasCriterion( Entities.First(), "worldsaidsafespotahead" )
}

IsNotSaidWorldC6M2_Tattoo <- function( query )
{
	return !ResponseCriteria.HasCriterion( Entities.First(), "worldsaidworldc6m2_tattoo" )
}

IsNotScavenge <- function( query )
{
	return Director.GetGameModeBase() != "scavenge"
}

IsNotSurvival <- function( query )
{
	return Director.GetGameModeBase() != "survival"
}

IsNotSrcGrp_ELLISSTORY <- function( query )
{
	return !ResponseCriteria.HasCriterion( Entities.First(), "worldsrcgrp_ellisstory" )
}

IsNotWitchAggro <- function( query )
{
	for ( local witch; witch = Entities.FindByClassname( witch, "witch" ); )
	{
		if ( NetProps.GetPropInt( witch, "m_lifeState" ) == 0 && NetProps.GetPropFloat( witch, "m_rage" ) == 1 )
			return false
	}
	return true
}

IssuerClose <- function( query )
{
	query.setdelegate( case_insensitive )
	local targets = rr_GetResponseTargets()

	return ( targets[ query.who ].GetOrigin() - targets[ query.from ].GetOrigin() ).Length() < 399
}

IssuerCloseEnough <- function( query )
{
	query.setdelegate( case_insensitive )
	local targets = rr_GetResponseTargets()

	return ( targets[ query.who ].GetOrigin() - targets[ query.from ].GetOrigin() ).Length() < 676
}

IsTalk <- function( query )
{
	return ResponseCriteria.GetValue( Entities.First(), "worldtalk" ) != "1"
}

IsTalkCoach <- function( query )
{
	query.setdelegate( case_insensitive )

	return query.talkcoach != 1
}

IsTalkGambler <- function( query )
{
	query.setdelegate( case_insensitive )

	return query.talkgambler != 1
}

IsTalkMechanic <- function( query )
{
	query.setdelegate( case_insensitive )

	return query.talkmechanic != 1
}

IsTalkProducer <- function( query )
{
	query.setdelegate( case_insensitive )

	return query.talkproducer != 1
}

IsTalkBiker <- function( query )
{
	query.setdelegate( case_insensitive )

	return query.talkbiker != 1
}

IsTalkManager <- function( query )
{
	query.setdelegate( case_insensitive )

	return query.talkmanager != 1
}

IsTalkNamVet <- function( query )
{
	query.setdelegate( case_insensitive )

	return query.talknamvet != 1
}

IsTalkTeenGirl <- function( query )
{
	query.setdelegate( case_insensitive )

	return query.talkteengirl != 1
}

IsWitchNear <- function( query )
{
	query.setdelegate( case_insensitive )
	
	for ( local witch; witch = Entities.FindByClassnameWithin( witch, "witch", rr_GetResponseTargets()[ query.who ].GetOrigin(), 676 ); )
	{
		if ( NetProps.GetPropInt( witch, "m_lifeState" ) == 0 )
			return true
	}
}

IsWorldTalkCoach <- function( query )
{
	return !ResponseCriteria.HasCriterion( Entities.First(), "worldtalkcoach" )
}

IsWorldTalkGambler <- function( query )
{
	return !ResponseCriteria.HasCriterion( Entities.First(), "worldtalkgambler" )
}

IsWorldTalkMechanic <- function( query )
{
	return !ResponseCriteria.HasCriterion( Entities.First(), "worldtalkmechanic" )
}

IsWorldTalkProducer <- function( query )
{
	return !ResponseCriteria.HasCriterion( Entities.First(), "worldtalkproducer" )
}

IsWorldTalkBiker <- function( query )
{
	return !ResponseCriteria.HasCriterion( Entities.First(), "worldtalkbiker" )
}

IsWorldTalkManager <- function( query )
{
	return !ResponseCriteria.HasCriterion( Entities.First(), "worldtalkmanager" )
}

IsWorldTalkNamVet <- function( query )
{
	return !ResponseCriteria.HasCriterion( Entities.First(), "worldtalknamvet" )
}

IsWorldTalkTeenGirl <- function( query )
{
	return !ResponseCriteria.HasCriterion( Entities.First(), "worldtalkteengirl" )
}

IsZombiePresentTanks <- function( query )
{
	local stats = {}.setdelegate( case_insensitive )
	GetInfectedStats( stats )
	return stats.Tanks > 1
}

IsZombiePresentTanks2 <- function( query )
{
	local stats = {}.setdelegate( case_insensitive )
	GetInfectedStats( stats )
	return stats.Tanks == 2
}

NoKnowBoomer <- function( query )
{
	return !ResponseCriteria.HasCriterion( Entities.First(), "worldknowboomer" )
}

NoKnowCharger <- function( query )
{
	return !ResponseCriteria.HasCriterion( Entities.First(), "worldknowcharger" )
}

NoKnowHunter <- function( query )
{
	return !ResponseCriteria.HasCriterion( Entities.First(), "worldknowhunter" )
}

NoKnowJockey <- function( query )
{
	return !ResponseCriteria.HasCriterion( Entities.First(), "worldknowjockey" )
}

NoKnowNames <- function( query )
{
	return !ResponseCriteria.HasCriterion( Entities.First(), "worldknownames" )
}

NoKnowSmoker <- function( query )
{
	return !ResponseCriteria.HasCriterion( Entities.First(), "worldknowsmoker" )
}

NoKnowSpitter <- function( query )
{
	return !ResponseCriteria.HasCriterion( Entities.First(), "worldknowspitter" )
}

NoKnowTank <- function( query )
{
	return !ResponseCriteria.HasCriterion( Entities.First(), "worldknowtank" )
}

NoKnowWitch <- function( query )
{
	return !ResponseCriteria.HasCriterion( Entities.First(), "worldknowwitch" )
}


// Response functions

SingingLady <- function( speaker, query )
{
	DoEntFire( "!self", "SpeakResponseConcept", "iMT_SingingLady", 0.21, null, speaker )
}

SingingMountain <- function( speaker, query )
{
	DoEntFire( "!self", "SpeakResponseConcept", "iMT_SingingMountain", 0.18, null, speaker )
}