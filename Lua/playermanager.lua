-- require -- causes this module to just do nothing
-- Hooks:PostHook(PlayerManager, "init", "gambler_playerman_init_byp", function(self) -- causes module to not load
-- end)

function PlayerManager:get_perm_dodge_buff()
    return self.perm_dodge_buff
end

function PlayerManager:update_perm_dodge_buff(value)
    local old_buff = self.perm_dodge_buff or 0
    local new_buff = old_buff + value
    self.perm_dodge_buff = new_buff
end

PlayerManager.perm_dodge_buff = 0

-- apply the dodge
local orig_calc_dodge = PlayerManager.skill_dodge_chance
function PlayerManager:skill_dodge_chance(...)
    -- causes bug if updated too many times in one frame where dodge rises exponentially. Need a cooldown to prevent this. 
    
    local chance = 0
    chance = chance + orig_calc_dodge(self,...)
    local buffy = self:get_perm_dodge_buff()
    chance = chance + buffy
    return chance
end