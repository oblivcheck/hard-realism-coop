#if defined _useful_upgrades_included
 #endinput
#endif
#define _useful_upgrades_included

enum // Upgrade bits
{
	LASER_BIT = 0x20000,
	SILENCER_BIT = 0x40000,
	NIGHT_BIT = 0x400000,
	RELOAD_BIT = 0x20000000
}

/**
 *	Called whenever upgrade is changed for specific client.
 *	-
 * @param iClient			Client index
 * @param iUpgrade			Upgrade bits
 *	-
 * @noreturn
*/
forward void OnUpgradeChanged(int iClient, int iUpgrade);

/**
 * Get upgrade bits for specified client
 *
 * @param iClient		Client index
 *  -
 * @error				Wrong number of arguments
 * @return				Upgrade bits
 */
native int UU_GetUpgrades(int iClient);

/**
 * Set upgrade bits for specified client
 *
 * @param iClient		Client index
 * @param iUpgradeBits	Upgrade bits
 *  -
 * @error				Wrong number of arguments
 * @noreturn
 */
native int UU_SetUpgrades(int iClient, int iUpgradeBits);

/**
 * Adds upgrade bits for specified client
 *
 * @param iClient		Client index
 * @param iUpgradeBits	Upgrade bits
 *  -
 * @noerror
 * @noreturn
 */
public void UU_AddUpgrade(int iClient, int iUpgradeBits)
{
	UU_SetUpgrades(iClient, UU_GetUpgrades(iClient) | iUpgradeBits);
}

/**
 * Removes upgrade bits from specified client
 *
 * @param iClient		Client index
 * @param iUpgradeBits	Upgrade bits
 *  -
 * @noerror
 * @noreturn
 */
public void UU_RemoveUpgrade(int iClient, int iUpgradeBits)
{
	UU_SetUpgrades(iClient, UU_GetUpgrades(iClient) &~ iUpgradeBits);
}


public SharedPlugin __pl_useful_upgrades = 
{
	name = "[L4D] Useful Upgrades",
	file = "l4d_useful_upgrades.smx",
	#if defined REQUIRE_PLUGIN
		required = 1
	#else
		required = 0
	#endif
};

#if !defined REQUIRE_PLUGIN
public void __pl_useful_upgrades_SetNTVOptional()
{
	MarkNativeAsOptional("UU_GetUpgrades");
	MarkNativeAsOptional("UU_SetUpgrades");
}
#endif
