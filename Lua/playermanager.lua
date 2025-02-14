-- require -- causes this module to just do nothing
-- Hooks:PostHook(PlayerManager, "init", "gambler_playerman_init_byp", function(self) -- causes module to not load
-- end)

function PlayerManager:get_perm_dodge_buff()
    return self.perm_dodge_buff
end

function PlayerManager:update_perm_dodge_buff(value)
    if not self.busy then
        self.busy = true
        local old_buff = self.perm_dodge_buff or 0
        local new_buff = old_buff + value
        self.perm_dodge_buff = new_buff
    end
end

function PlayerManager:set_perm_dodge_buff(value)
    if not self.busy then
        self.busy = true
        self.perm_dodge_buff = value
    end
end

PlayerManager.perm_dodge_buff = 0
PlayerManager.perm_dodge_buff = 0
PlayerManager.busy = false

-- Gambler Stuff
PlayerManager.gambler_lucky_dodge_stacks = 0
function PlayerManager:get_current_lucky_stacks()
    return self.gambler_lucky_dodge_stacks
end
function PlayerManager:set_current_lucky_stacks(stacks)
    -- if not self.busy then
        -- self.busy = true
        self.gambler_lucky_dodge_stacks = stacks
    -- end
end

-- apply the dodge
local orig_calc_dodge = PlayerManager.skill_dodge_chance
function PlayerManager:skill_dodge_chance(...)
    -- causes bug if updated too many times in one frame where dodge rises exponentially.Busy prevents this. 
    local chance = 0
    chance = chance + orig_calc_dodge(self,...)
    local buffy = self:get_perm_dodge_buff()
    chance = chance + buffy
    if self.busy then 
        self.busy = false
    end
    return chance
end