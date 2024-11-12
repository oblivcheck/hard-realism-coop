/*  
*    Ability to intercept music cmds sent to clients in l4d2
*    Copyright (C) 2019  LuxLuma		acceliacat@gmail.com
*
*    This program is free software: you can redistribute it and/or modify
*    it under the terms of the GNU General Public License as published by
*    the Free Software Foundation, either version 3 of the License, or
*    (at your option) any later version.
*
*    This program is distributed in the hope that it will be useful,
*    but WITHOUT ANY WARRANTY; without even the implied warranty of
*    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
*    GNU General Public License for more details.
*
*    You should have received a copy of the GNU General Public License
*    along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

#pragma semicolon 1

#include <sourcemod>
#include <sdktools>
#include <sdkhooks>
#include <dhooks>

#pragma newdecls required

#define GAMEDATA "musiccmdfilter"

#define DEBUG 0

bool bModeEnable;

public APLRes AskPluginLoad2(Handle myself, bool late, char[] error, int err_max)
{
	if(GetEngineVersion() != Engine_Left4Dead2)
	{
		strcopy(error, err_max, "Plugin only supports Left 4 Dead 2");
		return APLRes_SilentFailure;
	}
	return APLRes_Success;
}

public Plugin myinfo =
{
	name = "MusicCmdFilter",
	author = "Lux",
	description = "Ability to intercept music cmds sent to clients in l4d2",
	version = "1.1",
	url = "-"
};

public void OnPluginStart()
{
	Handle hGamedata = LoadGameConfigFile(GAMEDATA);
	if(hGamedata == null) 
		SetFailState("Failed to load \"%s.txt\" gamedata.", GAMEDATA);
	
	Handle hDetour;
	hDetour = DHookCreateFromConf(hGamedata, "Music::Play");
	if(!hDetour)
		SetFailState("Failed to find \"Music::Play\" signature.");
	
	if(!DHookEnableDetour(hDetour, false, MusicFilter))
		SetFailState("Failed to detour \"Music::Play\".");
		
	delete hGamedata;

  CreateTimer(1.0, tDelay);
}

Action tDelay(Handle Timer)
{
  ConVar hModeEnable = FindConVar("rc_gamemode_realism_enable");
  if (hModeEnable != null)
    bModeEnable = hModeEnable.BoolValue;
  return Plugin_Continue;
}

public MRESReturn MusicFilter(Handle hParams)
{
  if(!bModeEnable)
    return MRES_Ignored;

	static char sMusicKey[256];
	DHookGetParamString(hParams, 1, sMusicKey, sizeof(sMusicKey));
#if DEBUG
    PrintToChatAll("%s", sMusicKey);	
#endif
  return MRES_Supercede;
}
