// 可以枚举而不是复制一遍
void WEAPON_ResetWeaponAttr()
{
  // L4D2_SetFloatWeaponAttribute("weapon_pistol", L4D2FWA_CycleTime, 0.175);    
  L4D2_SetIntWeaponAttribute("weapon_smg", L4D2IWA_ClipSize, 50);
  L4D2_SetIntWeaponAttribute("weapon_smg_silenced", L4D2IWA_ClipSize, 50);
  L4D2_SetIntWeaponAttribute("weapon_smg_mp5", L4D2IWA_ClipSize, 50);
  L4D2_SetIntWeaponAttribute("weapon_smg", L4D2IWA_DefaultSize, 50);
  L4D2_SetIntWeaponAttribute("weapon_smg_silenced", L4D2IWA_DefaultSize, 50);
  L4D2_SetIntWeaponAttribute("weapon_smg_mp5", L4D2IWA_DefaultSize, 50);
  // L4D2_SetFloatWeaponAttribute("weapon_smg", L4D2FWA_CycleTime, 0.063);
  L4D2_SetFloatWeaponAttribute("weapon_smg_silenced", L4D2FWA_CycleTime, 0.0625);
  //L4D2_SetFloatWeaponAttribute("weapon_smg_mp5", L4D2FWA_CycleTime, 0.1);

  L4D2_SetIntWeaponAttribute("weapon_smg", L4D2IWA_Damage, 20);
  L4D2_SetIntWeaponAttribute("weapon_smg_silenced", L4D2IWA_Damage, 25);
  L4D2_SetIntWeaponAttribute("weapon_smg_mp5", L4D2IWA_Damage, 26);

  // - 步枪
  //L4D2_SetFloatWeaponAttribute("weapon_rifle", L4D2FWA_CycleTime, 0.1);
  L4D2_SetFloatWeaponAttribute("weapon_rifle_sg552", L4D2FWA_CycleTime, 0.0825);
  L4D2_SetFloatWeaponAttribute("weapon_rifle_ak47", L4D2FWA_CycleTime, 0.13);
  L4D2_SetFloatWeaponAttribute("weapon_rifle_desert", L4D2FWA_CycleTime, 0.07);
  L4D2_SetFloatWeaponAttribute("weapon_sniper_military", L4D2FWA_CycleTime, 0.25);


  L4D2_SetIntWeaponAttribute("weapon_rifle", L4D2IWA_ClipSize, 50);
  // L4D2_SetIntWeaponAttribute("weapon_rifle_sg552", L4D2IWA_Tier, 1);
  L4D2_SetIntWeaponAttribute("weapon_rifle_sg552", L4D2IWA_ClipSize, 50);
  L4D2_SetIntWeaponAttribute("weapon_rifle_ak47", L4D2IWA_ClipSize, 40);
  L4D2_SetIntWeaponAttribute("weapon_rifle_desert", L4D2IWA_ClipSize, 60);
  L4D2_SetIntWeaponAttribute("weapon_sniper_military", L4D2IWA_ClipSize, 30);
  L4D2_SetIntWeaponAttribute("weapon_rifle", L4D2IWA_DefaultSize,50);
  L4D2_SetIntWeaponAttribute("weapon_rifle_sg552", L4D2IWA_DefaultSize, 50);
  L4D2_SetIntWeaponAttribute("weapon_rifle_ak47", L4D2IWA_DefaultSize, 40);
  L4D2_SetIntWeaponAttribute("weapon_rifle_desert", L4D2IWA_DefaultSize, 60);
  // 三枪&带穿透*2
  L4D2_SetIntWeaponAttribute("weapon_sniper_military", L4D2IWA_DefaultSize, 30);


  L4D2_SetIntWeaponAttribute("weapon_rifle", L4D2IWA_Damage, 33);
  L4D2_SetIntWeaponAttribute("weapon_rifle_sg552", L4D2IWA_Damage, 33);
  L4D2_SetIntWeaponAttribute("weapon_rifle_ak47", L4D2IWA_Damage, 58);
  // L4D2_SetIntWeaponAttribute("weapon_sniper_military", L4D2IWA_Damage, 300);

  // - 狙击，侦察默认一枪&无穿透，狩猎两枪&有穿透*2，AWP类似原版Magnum
  // 不直接调整武器伤害，备用弹药由其它插件控制
  L4D2_SetIntWeaponAttribute("weapon_sniper_awp", L4D2IWA_ClipSize, 20);
  L4D2_SetIntWeaponAttribute("weapon_sniper_scout", L4D2IWA_ClipSize, 15);
  L4D2_SetIntWeaponAttribute("weapon_hunting_rifle", L4D2IWA_ClipSize, 15);
  
  L4D2_SetIntWeaponAttribute("weapon_sniper_awp", L4D2IWA_DefaultSize, 20);
  L4D2_SetIntWeaponAttribute("weapon_sniper_scout", L4D2IWA_DefaultSize, 15);
  L4D2_SetIntWeaponAttribute("weapon_hunting_rifle", L4D2IWA_DefaultSize, 15);
  // - 霰弹
  L4D2_SetFloatWeaponAttribute("weapon_pumpshotgun", L4D2FWA_PenetrationNumLayers, 2.0);
  L4D2_SetFloatWeaponAttribute("weapon_shotgun_chrome", L4D2FWA_PenetrationNumLayers, 2.0);
  L4D2_SetFloatWeaponAttribute("weapon_autoshotgun", L4D2FWA_PenetrationNumLayers, 2.0);
  L4D2_SetFloatWeaponAttribute("weapon_shotgun_spas", L4D2FWA_PenetrationNumLayers, 2.0);

  L4D2_SetFloatWeaponAttribute("weapon_pumpshotgun", L4D2FWA_CharPenetrationMaxDist, 300.0);
  L4D2_SetFloatWeaponAttribute("weapon_shotgun_chrome", L4D2FWA_CharPenetrationMaxDist, 300.0);
  L4D2_SetFloatWeaponAttribute("weapon_autoshotgun", L4D2FWA_CharPenetrationMaxDist, 300.0);
  L4D2_SetFloatWeaponAttribute("weapon_shotgun_spas", L4D2FWA_CharPenetrationMaxDist, 300.0);

  L4D2_SetFloatWeaponAttribute("weapon_pumpshotgun", L4D2FWA_PenetrationMaxDist, 500.0);
  L4D2_SetFloatWeaponAttribute("weapon_shotgun_chrome", L4D2FWA_PenetrationMaxDist, 500.0);
  L4D2_SetFloatWeaponAttribute("weapon_autoshotgun", L4D2FWA_PenetrationMaxDist, 500.0);
  L4D2_SetFloatWeaponAttribute("weapon_shotgun_spas", L4D2FWA_PenetrationMaxDist, 500.0);

  L4D2_SetIntWeaponAttribute("weapon_pumpshotgun", L4D2IWA_ClipSize, 8);
  L4D2_SetIntWeaponAttribute("weapon_shotgun_chrome", L4D2IWA_ClipSize, 8);
  L4D2_SetIntWeaponAttribute("weapon_autoshotgun", L4D2IWA_ClipSize, 10);
  L4D2_SetIntWeaponAttribute("weapon_shotgun_spas", L4D2IWA_ClipSize, 10);

  L4D2_SetFloatWeaponAttribute("weapon_pumpshotgun", L4D2FWA_PelletScatterPitch, 5.0);
  L4D2_SetFloatWeaponAttribute("weapon_shotgun_chrome", L4D2FWA_PelletScatterPitch, 4.0);
  L4D2_SetFloatWeaponAttribute("weapon_autoshotgun", L4D2FWA_PelletScatterPitch, 4.0);
  L4D2_SetFloatWeaponAttribute("weapon_shotgun_spas", L4D2FWA_PelletScatterPitch, 3.5);

  L4D2_SetFloatWeaponAttribute("weapon_pumpshotgun", L4D2FWA_PelletScatterYaw, 7.5);
  L4D2_SetFloatWeaponAttribute("weapon_shotgun_chrome", L4D2FWA_PelletScatterYaw, 5.0);
  L4D2_SetFloatWeaponAttribute("weapon_autoshotgun", L4D2FWA_PelletScatterYaw, 8.5);
  L4D2_SetFloatWeaponAttribute("weapon_shotgun_spas", L4D2FWA_PelletScatterYaw, 8.0);
}
// 暂时懒得调整后坐力与散布 
void WEAPON_AdjWeaponAttr()
{
  // - 其它
  L4D2_SetFloatWeaponAttribute("weapon_pistol", L4D2FWA_CycleTime, 0.175);    
  L4D2_SetIntWeaponAttribute("weapon_smg", L4D2IWA_ClipSize, 32);
  L4D2_SetIntWeaponAttribute("weapon_smg_silenced", L4D2IWA_ClipSize, 30);
  L4D2_SetIntWeaponAttribute("weapon_smg_mp5", L4D2IWA_ClipSize, 30);

  L4D2_SetIntWeaponAttribute("weapon_smg", L4D2IWA_DefaultSize, 32);
  L4D2_SetIntWeaponAttribute("weapon_smg_silenced", L4D2IWA_DefaultSize, 30);
  L4D2_SetIntWeaponAttribute("weapon_smg_mp5", L4D2IWA_DefaultSize, 30);

  L4D2_SetFloatWeaponAttribute("weapon_smg", L4D2FWA_CycleTime, 0.1);
  //L4D2_SetFloatWeaponAttribute("weapon_smg_silenced", L4D2FWA_CycleTime, 0.055);
  //L4D2_SetFloatWeaponAttribute("weapon_smg_mp5", L4D2FWA_CycleTime, 0.1);

  L4D2_SetIntWeaponAttribute("weapon_smg", L4D2IWA_Damage, 33);
  L4D2_SetIntWeaponAttribute("weapon_smg_silenced", L4D2IWA_Damage, 36);
  L4D2_SetIntWeaponAttribute("weapon_smg_mp5", L4D2IWA_Damage, 33);

  // - 步枪
  //L4D2_SetFloatWeaponAttribute("weapon_rifle", L4D2FWA_CycleTime, 0.1);
  L4D2_SetFloatWeaponAttribute("weapon_rifle_sg552", L4D2FWA_CycleTime, 0.0875);
  L4D2_SetFloatWeaponAttribute("weapon_rifle_ak47", L4D2FWA_CycleTime, 0.095);
  L4D2_SetFloatWeaponAttribute("weapon_rifle_desert", L4D2FWA_CycleTime, 0.13);
  L4D2_SetFloatWeaponAttribute("weapon_sniper_military", L4D2FWA_CycleTime, 0.1);


  L4D2_SetIntWeaponAttribute("weapon_rifle", L4D2IWA_ClipSize, 45);
  // L4D2_SetIntWeaponAttribute("weapon_rifle_sg552", L4D2IWA_Tier, 1);
  L4D2_SetIntWeaponAttribute("weapon_rifle_sg552", L4D2IWA_ClipSize, 40);
  L4D2_SetIntWeaponAttribute("weapon_rifle_ak47", L4D2IWA_ClipSize, 45);
  L4D2_SetIntWeaponAttribute("weapon_rifle_desert", L4D2IWA_ClipSize, 30);

  L4D2_SetIntWeaponAttribute("weapon_sniper_military", L4D2IWA_ClipSize, 20);
  L4D2_SetIntWeaponAttribute("weapon_rifle", L4D2IWA_DefaultSize, 45);
  L4D2_SetIntWeaponAttribute("weapon_rifle_sg552", L4D2IWA_DefaultSize, 40);
  L4D2_SetIntWeaponAttribute("weapon_rifle_ak47", L4D2IWA_DefaultSize, 45);
  L4D2_SetIntWeaponAttribute("weapon_rifle_desert", L4D2IWA_DefaultSize, 30);
  // 三枪&带穿透*2
  L4D2_SetIntWeaponAttribute("weapon_sniper_military", L4D2IWA_DefaultSize, 20);


  L4D2_SetIntWeaponAttribute("weapon_rifle", L4D2IWA_Damage, 38);
  L4D2_SetIntWeaponAttribute("weapon_rifle_sg552", L4D2IWA_Damage, 38);
  L4D2_SetIntWeaponAttribute("weapon_rifle_ak47", L4D2IWA_Damage, 46);
  // L4D2_SetIntWeaponAttribute("weapon_sniper_military", L4D2IWA_Damage, 300);

  // - 狙击，侦察默认一枪&无穿透，狩猎两枪&有穿透*2，AWP类似原版Magnum
  // 不直接调整武器伤害，备用弹药由其它插件控制
  L4D2_SetIntWeaponAttribute("weapon_sniper_awp", L4D2IWA_ClipSize, 5);
  L4D2_SetIntWeaponAttribute("weapon_sniper_scout", L4D2IWA_ClipSize, 10);
  L4D2_SetIntWeaponAttribute("weapon_hunting_rifle", L4D2IWA_ClipSize, 10);
  
  L4D2_SetIntWeaponAttribute("weapon_sniper_awp", L4D2IWA_DefaultSize, 5);
  L4D2_SetIntWeaponAttribute("weapon_sniper_scout", L4D2IWA_DefaultSize, 10);
  L4D2_SetIntWeaponAttribute("weapon_hunting_rifle", L4D2IWA_DefaultSize, 12);
  // - 霰弹
  L4D2_SetFloatWeaponAttribute("weapon_pumpshotgun", L4D2FWA_PenetrationNumLayers, 1.0);
  L4D2_SetFloatWeaponAttribute("weapon_shotgun_chrome", L4D2FWA_PenetrationNumLayers, 1.0);
  L4D2_SetFloatWeaponAttribute("weapon_autoshotgun", L4D2FWA_PenetrationNumLayers, 1.0);
  L4D2_SetFloatWeaponAttribute("weapon_shotgun_spas", L4D2FWA_PenetrationNumLayers, 1.0);

  L4D2_SetFloatWeaponAttribute("weapon_pumpshotgun", L4D2FWA_CharPenetrationMaxDist, 1.0);
  L4D2_SetFloatWeaponAttribute("weapon_shotgun_chrome", L4D2FWA_CharPenetrationMaxDist, 1.0);
  L4D2_SetFloatWeaponAttribute("weapon_autoshotgun", L4D2FWA_CharPenetrationMaxDist, 1.0);
  L4D2_SetFloatWeaponAttribute("weapon_shotgun_spas", L4D2FWA_CharPenetrationMaxDist, 1.0);

  L4D2_SetFloatWeaponAttribute("weapon_pumpshotgun", L4D2FWA_PenetrationMaxDist, 1.0);
  L4D2_SetFloatWeaponAttribute("weapon_shotgun_chrome", L4D2FWA_PenetrationMaxDist, 1.0);
  L4D2_SetFloatWeaponAttribute("weapon_autoshotgun", L4D2FWA_PenetrationMaxDist, 1.0);
  L4D2_SetFloatWeaponAttribute("weapon_shotgun_spas", L4D2FWA_PenetrationMaxDist, 1.0);

  L4D2_SetIntWeaponAttribute("weapon_pumpshotgun", L4D2IWA_ClipSize, 7);
  L4D2_SetIntWeaponAttribute("weapon_shotgun_chrome", L4D2IWA_ClipSize, 7);
  L4D2_SetIntWeaponAttribute("weapon_autoshotgun", L4D2IWA_ClipSize, 6);
  L4D2_SetIntWeaponAttribute("weapon_shotgun_spas", L4D2IWA_ClipSize, 6);

  L4D2_SetFloatWeaponAttribute("weapon_pumpshotgun", L4D2FWA_PelletScatterPitch, 2.5);
  L4D2_SetFloatWeaponAttribute("weapon_shotgun_chrome", L4D2FWA_PelletScatterPitch, 2.0);
  L4D2_SetFloatWeaponAttribute("weapon_autoshotgun", L4D2FWA_PelletScatterPitch, 2.0);
  L4D2_SetFloatWeaponAttribute("weapon_shotgun_spas", L4D2FWA_PelletScatterPitch, 1.75);

  L4D2_SetFloatWeaponAttribute("weapon_pumpshotgun", L4D2FWA_PelletScatterYaw, 3.75);
  L4D2_SetFloatWeaponAttribute("weapon_shotgun_chrome", L4D2FWA_PelletScatterYaw, 2.5);
  L4D2_SetFloatWeaponAttribute("weapon_autoshotgun", L4D2FWA_PelletScatterYaw, 4.25);
  L4D2_SetFloatWeaponAttribute("weapon_shotgun_spas", L4D2FWA_PelletScatterYaw, 4.0);
}

