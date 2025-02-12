-- require("lib/units/pickups/AmmoClip")

-- Hooks.PostHook(PlayerManager, "init", "gambler_playerman_init_byp", function()
--     self.gambler_lucky_dodge_stacks = 40
-- 	self.gambler_dodge_difference = 40
-- end)

-- apply the dodge
--v1.1 rewrote this to be future-proof, and it should be extremely less likely to conflict with other mods now,
--since it no longer overwrites the dodge calc function (at least, not really)
local orig_calc_dodge = PlayerManager.skill_dodge_chance
function PlayerManager:skill_dodge_chance(...)
    -- local {stacks, diff} = AmmoClip.getGamblerDodgeInfo()
    -- local stacks = AmmoClip.gambler_lucky_dodge_stacks
    -- local stacks = 0.40
    -- local diff = -0.02
    local chance = 0
    
    if chance < 420 then
        -- chance = chance + stacks + diff
        chance = chance + 1
    end
    chance = chance + orig_calc_dodge(self,...)
    -- local stacks = tweak_data.upgrades.values.player.gambler_lucky_dodge_stacks
    -- local diff = tweak_data.upgrades.values.player.gambler_dodge_difference
    
    return chance
end