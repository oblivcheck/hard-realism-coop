#if defined _autorespawn_included_
  #endinput
#endif
#define _autorespawn_included_

/**
 * Get number of money earned during current round.
 *
 * @param iClient		Client index given.
 *
 * @error				Wrong number of arguments.
 * @return				true on success.
 */
native int AR_RespawnPlayer(int iClient);

/**
 * Gives shield to client for specified time interval
 *
 * @param iClient		Client index given.
 * @param fDelay		Life time of the shield (in sec.), 0.0 - infinite
 * @param fProtection	Protection level - 0.0 to 1.0, where 1.0 - is immortal
 *
 * @error				Wrong number of arguments
 * @return				Shield entity reference index, or -1 on failure
 */
native int AR_CreateShield(int iClient, float fDelay, float fProtection);

/**
 * Remove shield of client.
 *
 * @param iClient		Client index given.
 *
 * @error				Wrong number of arguments.
 * @noreturn
 */
native void AR_RemoveShield(int iClient);



public SharedPlugin __pl_autorespawn =
{
	name = "AutoRespawn",
	file = "AutoRespawn.smx",
	#if defined REQUIRE_PLUGIN
	required = 1,
	#else
	required = 0,
	#endif
};

#if !defined REQUIRE_PLUGIN
public void __pl_autorespawn_SetNTVOptional()
{
	MarkNativeAsOptional("AR_RespawnPlayer");
	MarkNativeAsOptional("AR_CreateShield");
	MarkNativeAsOptional("AR_RemoveShield");
}
#endif