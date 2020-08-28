// Cave Story+ (Humble) autosplitter by periwinkle
// (Based off of magmapeach's CS freeware Best Ending autosplitter)

state("CaveStory+"){
    uint mapId : 0x001047D4;
    uint musicId : 0x001047D8;
    uint prevMusicId : 0x001047E0;
    uint airMeter : 0x000C1D54;
    
    // For Bad Ending split condition
    uint skyDragon : 0x000C9BE0; // this should be 212 for the dragon
    uint skyDragonActNo: 0x000C9C2C;
    
    // For Normal Ending split condition
    uint vTrigger : 0x000C972C; // should be 46 (H/V trigger)
    byte vTriggerCond : 0x000C9704;
    
    // These store various story progression flags, one flag per bit.
    //byte<1000> flagArray : 0x000C15B0;
    uint flagEgg : 0x000C15BC;     // bit 24: done egg (flag 120)
    uint flagFire : 0x000C15CC;    // bit 17: fireball (flag 241)
    uint flagGum : 0x000C15EC;     // bit 4:  can get gum key (flag 484), 21: gum (flag 501)
    uint flagGrass : 0x000C15F0;   // bit 8:  done grass (flag 520)
    uint flagPanties : 0x000C15F8; // bit 5:  panties (flag 581)
    uint flagToroko : 0x000C15FC;  // bit 15: toroko defeated (flag 623)
    uint flagCureA : 0x000C1608;   // bit 7:  got cure all (flag 711)
    uint flagCureA2 : 0x000C1607;  // bit 6:  gave Cure-All to Gero (flag 702)
    uint flagCore : 0x000C1618;    // bit 0:  defeated Core (water level rose) (flag 832)
    uint flagMomo : 0x000C1630;    // bit 15: momorin outside (flag 1039), 22: got iron bond (flag 1046)
    uint flagPignon : 0x000C1670;  // bit 24: ma pignon (flag 1560)
}
state("Doukutsu"){
    uint mapId : 0x000A57F0;
    uint musicId : 0x000A57F4;
    uint prevMusicId : 0x000A57FC;
    uint airMeter : 0x0009E6DC;
    
    // For Bad Ending split condition
    uint skyDragon : 0x000AE098; // this should be 212 for the dragon
    uint skyDragonActNo: 0x000AE0E4;
    
    // For Normal Ending split condition
    uint vTrigger : 0x000ADBE4; // should be 46 (H/V trigger)
    byte vTriggerCond : 0x000ADBBC;
    
    // These store various story progression flags, one flag per bit.
    uint flagEgg : 0x0009DDAC;    // bit 24: done egg (flag 120)
    uint flagFire : 0x0009DDBC;   // bit 17: fireball (flag 241)
    uint flagGum : 0x0009DDDC;    // bit 4:  can get gum key (flag 484), 21: gum (flag 501)
    uint flagGrass : 0x0009DDE0;  // bit 8:  done grass (flag 520)
    uint flagPanties: 0x0009DDE8; // bit 5:  panties (flag 581)
    uint flagToroko : 0x0009DDEC; // bit 15: toroko defeated (flag 623)
    uint flagCureA : 0x0009DDF8;  // bit 7:  got cure all (flag 711)
    uint flagCureA2 : 0x0009DDF7; // bit 6:  gave Cure-All to Gero (flag 702)
    uint flagCore : 0x0009DE08;   // bit 0:  defeated Core (water level rose) (flag 832)
    uint flagMomo : 0x0009DE20;   // bit 15: momorin outside, 22: got iron bond
    uint flagPignon : 0x0009DE60; // bit 24: ma pignon (flag 1560)
}
init{
    if (game.ProcessName == "Doukutsu")
        refreshRate = 50;
    else
        refreshRate = 60;
    
    Func<uint, int, bool> bitIsSet = (bitMask, bitPos) => {
        return ((bitMask & (1 << bitPos)) != 0);
    };
    vars.bitIsSet = bitIsSet;
    vars.triggeredSplits = new bool[47];
}
startup{
    settings.Add("SplitPolarStar", false, "Obtain Polar Star");
    settings.Add("SplitFirstCave", false, "Exit First Cave");
    settings.Add("SplitEnterEgg", true, "Enter Egg Corridor");
    settings.Add("SplitIgor", false, "Defeat Igor");
    settings.Add("SplitEgg0", true, "Enter Egg 0");
    settings.Add("SplitExitEgg", false, "Exit Egg Corridor");
    settings.Add("SplitEnterGrass", false, "Enter Bushlands");
    settings.Add("SplitFireball", true, "Obtain Fireball");
    settings.Add("SplitCharcoal", false, "Obtain Charcoal");
    settings.Add("SplitBalrog2", false, "Defeat Balrog");
    settings.Add("SplitExitBalrog2", true, "Exit Power Room");
    settings.Add("SplitBalfrog", false, "Defeat Balfrog");
    settings.Add("SplitExitGum", false, "Exit Gum Room");
    settings.Add("SplitBomb", true, "Obtain Bomb");
    settings.Add("SplitExitGrass", false, "Exit Bushlands");
    settings.Add("SplitEnterSand", false, "Enter Sand Zone");
    settings.Add("SplitCurly", false, "Defeat Curly");
    settings.Add("SplitMachineGun", true, "Obtain Machine Gun");
    settings.Add("SplitPanties", false, "Get Panties");
    settings.Add("SplitOmega", false, "Defeat Omega");
    settings.Add("SplitJenka", true, "Enter Jenka's House");
    settings.Add("SplitDogs", true, "Return All* Dogs"); 
    settings.Add("SplitToroko", false, "Defeat Toroko");
    settings.Add("SplitBlade", true, "Obtain Blade");
    settings.Add("SplitExitSand", false, "Exit Sand Zone");
    settings.Add("SplitPoohBlack", false, "Defeat Puu Black");
    settings.Add("SplitCureAll", false, "Give Cure-All to Dr. Gero");
    settings.Add("SplitMonsterX", false, "Defeat Monster X");
    settings.Add("SplitLabW", true, "Exit Labyrinth W");
    settings.Add("SplitLabM", true, "Exit Labyrinth M");
    settings.Add("SplitDrown", true, "Drown");
    settings.Add("SplitIronhead", true, "Defeat Ironhead");
    settings.Add("SplitEgg2", false, "Exit Egg Corridor?");
    settings.Add("SplitBadEnd", true, "Got Bad Ending");
    settings.Add("SplitOuterWall", true, "Exit Outer Wall");
    settings.Add("SplitMushroom", false, "Obtain Ma Pignon");
    settings.Add("SplitLeaveMushroom", true, "Leave Ma Pignon");
    settings.Add("SplitIronBond", false, "Obtain Iron Bond");
    settings.Add("SplitSleep", false, "Sleep");
    settings.Add("SplitEnterFinal", true, "Enter Last Cave");
    settings.Add("SplitFinalCave", true, "Exit Last Cave");
    settings.Add("SplitMisery", true, "Exit Misery's Room");
    settings.Add("SplitDoctor", true, "Exit Doctor's Room");
    settings.Add("SplitUndeadCore", true, "Defeat Undead Core");
    settings.Add("SplitNormalEnd", true, "Got Normal Ending");
    settings.Add("SplitEnterHell", false, "Enter Hell");
    settings.Add("SplitBestEnd", true, "Got Best Ending");
    
    vars.timerModel = new TimerModel { CurrentState = timer };
}

start{
    return current.prevMusicId > 0 && old.prevMusicId == 0 && old.mapId == 72;
}

split{
    if (settings["SplitPolarStar"]     && !vars.triggeredSplits[0]  && current.musicId == 10 && old.musicId != 10 && current.mapId == 90)                                            { return vars.triggeredSplits[0]  = true; }
    if (settings["SplitFirstCave"]     && !vars.triggeredSplits[1]  && current.mapId == 18 && old.mapId == 12)                                                                       { return vars.triggeredSplits[1]  = true; }
    if (settings["SplitEnterEgg"]      && !vars.triggeredSplits[2]  && current.mapId == 2 && old.mapId == 1)                                                                         { return vars.triggeredSplits[2]  = true; }
    if (settings["SplitIgor"]          && !vars.triggeredSplits[3]  && current.musicId == 15 && old.musicId != 15 && current.mapId == 2)                                             { return vars.triggeredSplits[3]  = true; }
    if (settings["SplitEgg0"]          && !vars.triggeredSplits[4]  && current.mapId == 3 && old.mapId == 2)                                                                         { return vars.triggeredSplits[4]  = true; }
    if (settings["SplitExitEgg"]       && !vars.triggeredSplits[5]  && current.mapId == 24 && old.mapId == 2 && vars.bitIsSet(current.flagEgg, 24))                                  { return vars.triggeredSplits[5]  = true; }
    if (settings["SplitEnterGrass"]    && !vars.triggeredSplits[6]  && current.mapId == 6 && old.mapId == 1)                                                                         { return vars.triggeredSplits[6]  = true; }
    if (settings["SplitFireball"]      && !vars.triggeredSplits[7]  && current.musicId == 10 && old.musicId != 10 && current.mapId == 7 && !vars.bitIsSet(current.flagFire, 17))     { return vars.triggeredSplits[7]  = true; }
    if (settings["SplitCharcoal"]      && !vars.triggeredSplits[8]  && current.musicId == 10 && old.musicId != 10 && current.mapId == 7 && vars.bitIsSet(current.flagFire, 17))      { return vars.triggeredSplits[8]  = true; }
    if (settings["SplitBalrog2"]       && !vars.triggeredSplits[9]  && current.musicId == 15 && old.musicId != 15 && current.mapId == 25)                                            { return vars.triggeredSplits[9]  = true; }
    if (settings["SplitExitBalrog2"]   && !vars.triggeredSplits[10] && current.mapId == 6 && old.mapId == 25 && vars.bitIsSet(current.flagGum, 4))                                   { return vars.triggeredSplits[10] = true; }
    if (settings["SplitBalfrog"]       && !vars.triggeredSplits[11] && current.musicId == 15 && old.musicId != 15 && current.mapId == 28)                                            { return vars.triggeredSplits[11] = true; }
    if (settings["SplitExitGum"]       && !vars.triggeredSplits[12] && current.mapId == 6 && old.mapId == 28 && vars.bitIsSet(current.flagGum, 21))                                  { return vars.triggeredSplits[12] = true; }
    if (settings["SplitBomb"]          && !vars.triggeredSplits[13] && current.musicId == 10 && old.musicId != 10 && current.mapId == 25)                                            { return vars.triggeredSplits[13] = true; }
    if (settings["SplitExitGrass"]     && !vars.triggeredSplits[14] && current.mapId == 11 && old.mapId == 6 && vars.bitIsSet(current.flagGrass, 8))                                 { return vars.triggeredSplits[14] = true; }
    if (settings["SplitEnterSand"]     && !vars.triggeredSplits[15] && current.mapId == 10 && old.mapId == 1)                                                                        { return vars.triggeredSplits[15] = true; }
    if (settings["SplitCurly"]         && !vars.triggeredSplits[16] && current.musicId == 15 && old.musicId != 15 && current.mapId == 29)                                            { return vars.triggeredSplits[16] = true; }
    if (settings["SplitMachineGun"]    && !vars.triggeredSplits[17] && current.musicId == 10 && old.musicId != 10 && current.mapId == 29)                                            { return vars.triggeredSplits[17] = true; }
    if (settings["SplitPanties"]       && !vars.triggeredSplits[18] && vars.bitIsSet(current.flagPanties, 5) && !vars.bitIsSet(old.flagPanties, 5))                                  { return vars.triggeredSplits[18] = true; }
    if (settings["SplitOmega"]         && !vars.triggeredSplits[19] && current.musicId == 15 && old.musicId != 15 && current.mapId == 10)                                            { return vars.triggeredSplits[19] = true; }
    if (settings["SplitJenka"]         && !vars.triggeredSplits[20] && current.mapId == 33 && old.mapId == 10)                                                                       { return vars.triggeredSplits[20] = true; }
    if (settings["SplitDogs"]          && !vars.triggeredSplits[21] && current.mapId == 36 && old.mapId == 10)                                                                       { return vars.triggeredSplits[21] = true; }
    if (settings["SplitToroko"]        && !vars.triggeredSplits[22] && current.musicId == 0 && old.musicId != 0 && current.mapId == 35 && vars.bitIsSet(current.flagToroko, 15))     { return vars.triggeredSplits[22] = true; }
    if (settings["SplitBlade"]         && !vars.triggeredSplits[23] && current.musicId == 10 && old.musicId != 10 && current.mapId == 35)                                            { return vars.triggeredSplits[23] = true; }
    if (settings["SplitExitSand"]      && !vars.triggeredSplits[24] && current.mapId == 9 && old.mapId == 37)                                                                        { return vars.triggeredSplits[24] = true; }
    if (settings["SplitPoohBlack"]     && !vars.triggeredSplits[25] && current.mapId == 39 && old.mapId == 41 && vars.bitIsSet(current.flagCureA, 7))                                { return vars.triggeredSplits[25] = true; }
    if (settings["SplitCureAll"]       && !vars.triggeredSplits[26] && vars.bitIsSet(current.flagCureA2, 6) && !vars.bitIsSet(old.flagCureA2, 6))                                    { return vars.triggeredSplits[26] = true; }
    if (settings["SplitMonsterX"]      && !vars.triggeredSplits[27] && current.mapId == 39 && current.musicId == 15 && old.musicId != 15)                                            { return vars.triggeredSplits[27] = true; }
    if (settings["SplitLabW"]          && !vars.triggeredSplits[28] && current.mapId == 43 && old.mapId == 39)                                                                       { return vars.triggeredSplits[28] = true; }
    if (settings["SplitLabM"]          && !vars.triggeredSplits[29] && current.mapId == 46 && old.mapId == 45)                                                                       { return vars.triggeredSplits[29] = true; }
    if (settings["SplitDrown"]         && !vars.triggeredSplits[30] && current.mapId == 47 && vars.bitIsSet(current.flagCore, 0) && old.airMeter != 0 && current.airMeter == 0)      { return vars.triggeredSplits[30] = true; }
    if (settings["SplitIronhead"]      && !vars.triggeredSplits[31] && current.mapId == 15 && old.mapId == 31)                                                                       { return vars.triggeredSplits[31] = true; }
    if (settings["SplitEgg2"]          && !vars.triggeredSplits[32] && current.mapId == 52 && old.mapId == 49)                                                                       { return vars.triggeredSplits[32] = true; }
    if (settings["SplitBadEnd"]        && !vars.triggeredSplits[33] && current.mapId == 53 && current.skyDragon == 212 && current.skyDragonActNo >= 10 && old.skyDragonActNo == 1)   { return vars.triggeredSplits[33] = true; }
    if (settings["SplitOuterWall"]     && !vars.triggeredSplits[34] && current.mapId == 55 && old.mapId == 53)                                                                       { return vars.triggeredSplits[34] = true; }
    if (settings["SplitMushroom"]      && !vars.triggeredSplits[35] && current.mapId == 83 && current.musicId == 10 && old.musicId != 10 && vars.bitIsSet(current.flagPignon, 24))   { return vars.triggeredSplits[35] = true; }
    if (settings["SplitLeaveMushroom"] && !vars.triggeredSplits[36] && current.mapId == 16 && old.mapId == 83 && vars.bitIsSet(current.flagPignon, 24))                              { return vars.triggeredSplits[36] = true; }
    if (settings["SplitIronBond"]      && !vars.triggeredSplits[37] && vars.bitIsSet(current.flagMomo, 22) && !vars.bitIsSet(old.flagMomo, 22))                                      { return vars.triggeredSplits[37] = true; }
    if (settings["SplitSleep"]         && !vars.triggeredSplits[38] && current.mapId == 58 && current.musicId == 2 && old.musicId == 0 && vars.bitIsSet(current.flagMomo, 15))       { return vars.triggeredSplits[38] = true; }
    if (settings["SplitEnterFinal"]    && !vars.triggeredSplits[39] && current.musicId == 29 && (old.musicId == 0 || old.musicId == 24))                                             { return vars.triggeredSplits[39] = true; }
    if (settings["SplitFinalCave"]     && !vars.triggeredSplits[40] && current.mapId == 62 && (old.mapId == 67 || old.mapId == 63))                                                  { return vars.triggeredSplits[40] = true; }
    if (settings["SplitMisery"]        && !vars.triggeredSplits[41] && current.mapId == 65 && old.mapId == 64)                                                                       { return vars.triggeredSplits[41] = true; }
    if (settings["SplitDoctor"]        && !vars.triggeredSplits[42] && current.mapId == 68 && old.mapId == 65)                                                                       { return vars.triggeredSplits[42] = true; }
    if (settings["SplitUndeadCore"]    && !vars.triggeredSplits[43] && current.prevMusicId == 0 && old.prevMusicId == 32)                                                            { return vars.triggeredSplits[43] = true; }
    if (settings["SplitNormalEnd"]     && !vars.triggeredSplits[44] && current.mapId == 70 && current.vTrigger == 46 && current.vTriggerCond == 0 && old.vTriggerCond == 128)        { return vars.triggeredSplits[44] = true; }
    if (settings["SplitEnterHell"]     && !vars.triggeredSplits[45] && current.musicId == 36 && old.musicId != 36)                                                                   { return vars.triggeredSplits[45] = true; }
    if (settings["SplitBestEnd"]       && !vars.triggeredSplits[46] && current.mapId == 91 && old.mapId != 91)                                                                       { return vars.triggeredSplits[46] = true; }
    
    return false;
}

reset{
    // This is here just to make the "Reset" checkbox appear in the settings
    return false;
}
exit{
    // Reset on game exit only if the checkbox is ticked and the run hasn't already finished
    if (settings.ResetEnabled && timer.CurrentPhase != TimerPhase.Ended)
        vars.timerModel.Reset();
}
