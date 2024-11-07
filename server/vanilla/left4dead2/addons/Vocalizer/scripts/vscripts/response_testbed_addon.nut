//--------------------------------------------------------------------------------------------------
// ion's Vocalizer: VScript Talker Base
//--------------------------------------------------------------------------------------------------

iMT <-
{
	none = RGroupParams()
	sequential = RGroupParams( { sequential = true } )
}.setdelegate( this )

IncludeScript( "imt_functions", iMT )
IncludeScript( "imt_coach", iMT )
IncludeScript( "imt_gambler", iMT )
IncludeScript( "imt_mechanic", iMT )
IncludeScript( "imt_producer", iMT )
IncludeScript( "imt_biker", iMT )
IncludeScript( "imt_manager", iMT )
IncludeScript( "imt_namvet", iMT )
IncludeScript( "imt_teengirl", iMT )
IncludeScript( "imt_npcs", iMT )
IncludeScript( "imt_zombies", iMT )
IncludeScript( "imt_precache", iMT )