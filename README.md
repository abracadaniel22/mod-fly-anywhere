# ![logo](https://raw.githubusercontent.com/azerothcore/azerothcore.github.io/master/images/logo-github.png) AzerothCore

# Fly Anywhere module for AzerothCore

AzerothCore mod that allows players to fly in Eastern Kingdoms and Kalimdor as soon as they can fly in Outlands.

This mod also allows players to fly in the Burning Crusade starter zones, Isle of Quel'danas, and any other Outland area not flyable.

## Overview

When [Expert Riding](https://www.wowhead.com/wotlk/spell=34090/expert-riding) skill is learned, players can fly in the old world continents (Eastern Kingdoms and Kalimdor) and BC starter zones with any mount their skill and level allow them to use. Expert Riding can be learned at level 60.

## How to install

This mod requires both server and client files. The steps below will replace AreaTable.dbc on server and client.

### Server installation

> [!WARNING]
> The installation script will replace AreaTable.dbc on the server. It will attempt to automatically create a backup AreaTable.dbc.backup. This is a must-have requirement for this mod. If you don't want DBC files updated, consider using the [AzerothCoreTomeOfWorldFlying](https://github.com/StygianTheBest/AzerothCore-Content/blob/master/SQL/AzerothCoreTomeOfWorldFlying.sql), which only requires DB modifications but it is not as immersive as this mod.

1. Clone this repository into the modules folder of your AzerothCore installation
```
git clone https://github.com/abracadaniel222/mod-fly-anywhere.git
```
2. Re-run `cmake`
3. Re-build the project. For more information, refer to the [AzerothCore Installation Guide](https://www.azerothcore.org/wiki/installation) and [Installing a Module](https://www.azerothcore.org/wiki/installing-a-module) pages.
4. The DBC file should be automatically installed. If not, you would need to manually copy it from `data/patch/server` into the `build/data/dbc` server folder.
5. Start the server.

#### Server configuration

You can disable flying in old world while keeping the mod installed by setting `FlyAnywhere.Enabled` to `false` in the config file installed by this mod.

### Client installation

1. Copy the Patch-o.mpq file located in the `data/patch/client` folder into your World of Warcraft 3.3.5a client's `Data` folder. This file contains the modified AreaTable.dbc. If you already have a Patch-o.mpq in your Data folder, try using a different suffix.
2. Delete the Cache folder and start the game

## Credits

- WoWDev wiki [AreaTable](https://wowdev.wiki/DB/AreaTable) reference

## Screenshots

TODO

## Extra info

### What was modified in the DBC file? And what is contained in the MPQ file?

- **server/AreaTable.dbc**: for each area in which ContinentID is either `0` or `1`, if `Flags` is greater than `0`, add the `AREA_FLAG_FLYING` (value `0x00000400`) and the `AREA_FLAG_EnableFlightBoundsonMap` (value `0x00004000`) to the bit mask, basically mimicking the flags from the expansion continents. Also done the same for ContinentID `530` (Outlands) to include starter zones.
- **client/Patch-o.mpq**: Contains a DBFilesClient folder with the modified AreaTable.dbc inside.

## Reporting bugs and contributing

Bug reports and contributions are welcome. Please go to the Issues tab to submit a bug or enhancement request, or submit your contribution via Pull Request.