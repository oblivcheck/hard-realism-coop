// 完全阻止声音CMD命令由另一个插件负责

void SOUND_CreateHook()
{
  AddNormalSoundHook(NormalHook);
  AddAmbientSoundHook(AmbientHook);
}

void SOUND_UnHook()
{ 
  RemoveNormalSoundHook(NormalHook);
  RemoveAmbientSoundHook(AmbientHook);  
}

// - npc/mega_mob
#define BLOCK "_mob"

public Action NormalHook(int clients[MAXPLAYERS], int& numClients, char sample[PLATFORM_MAX_PATH], int& entity, int& channel, float& volume, int& level, int& pitch, int& flags, char soundEntry[PLATFORM_MAX_PATH], int& seed)
{  
  if(StrContains(sample, BLOCK) != -1 )
    return Plugin_Handled;

  return Plugin_Continue;
}
public Action AmbientHook(char sample[PLATFORM_MAX_PATH], int& entity, float& volume, int& level, int& pitch, float pos[3], int& flags, float& delay)
{
  if(StrContains(sample, BLOCK) != -1 )
    return Plugin_Handled;

  return Plugin_Continue;
}
