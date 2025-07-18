/**
 * FlyAnywhere mod
 * This file declares scripts that run when server loads or when players try to mount
 * @author Abracadaniel22
 */
#include "ScriptMgr.h"
#include "Player.h"
#include "Configuration/Config.h"
#include "AreaDefines.h"

struct FlyAnywhereModule
{
    bool Enabled;
};

FlyAnywhereModule flyAnywhere;

class FlyAnywhereConfigWorldScript : public WorldScript
{
public:
    FlyAnywhereConfigWorldScript() : WorldScript("FlyAnywhereConfig") { }

    void OnBeforeConfigLoad(bool /*reload*/) override
    {
        flyAnywhere.Enabled = sConfigMgr->GetOption<bool>("FlyAnywhere.Enabled", true);
    }
};


class FlyAnywherePlayerScript : public PlayerScript
{
public:
    FlyAnywherePlayerScript() : PlayerScript("FlyAnywhere") { }

    bool OnPlayerCanFlyInZone(Player* player, uint32 mapId, uint32 zoneId, SpellInfo const* bySpell) override
    {
        uint32 v_map = GetVirtualMapForMapAndZone(mapId, zoneId);
        bool isPlayerInOldWorld = v_map == MAP_EASTERN_KINGDOMS || v_map == MAP_KALIMDOR;
        if (isPlayerInOldWorld && !flyAnywhere.Enabled)
        {
            return false;
        }
        // defer to standard logic
        return true;
    }
};

void AddSC_player_fly_anywhere()
{
    new FlyAnywhereConfigWorldScript();
    new FlyAnywherePlayerScript();
}
