---@diagnostic disable: undefined-global
-- require -- causes this module to just do nothing
-- Hooks:PostHook(PlayerManager, "init", "gambler_playerman_init_byp", function(self) -- causes module to not load
-- end)

function PlayerManager:get_perm_dodge_buff()
    return self.perm_dodge_buff
end

-- function PlayerManager:update_perm_dodge_buff(value) -- unused, but kept for future reference. 
--     if not self.busy then
--         self.busy = true
--         local old_buff = self.perm_dodge_buff or 0
--         local new_buff = old_buff + value
--         self.perm_dodge_buff = new_buff
--     end
-- end

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
PlayerManager.gambler_busy = false
PlayerManager.gambler_lucky_dodge_stacks = 0

function PlayerManager:get_current_lucky_stacks()
    return self.gambler_lucky_dodge_stacks
end

function PlayerManager:set_current_lucky_stacks(stacks)
    self.gambler_lucky_dodge_stacks = stacks
end

function PlayerManager:update_current_lucky_stacks(value, max_allowed_stacks)
    -- check
    if not self.gambler_busy then -- prevents it from updating too many times a tick, which causes the infinite dodge bug.
        self.gambler_busy = true
        local stonks = self:get_current_lucky_stacks()
        local temp_lucky_dodge_stacks = stonks + value
        
        -- if the new value is higher than the cap, the dodge difference must make bring the current stacks to the cap
        if temp_lucky_dodge_stacks >= max_allowed_stacks then
            -- value = max_allowed_stacks - stonks
            self:set_perm_dodge_buff(max_allowed_stacks)
            self:set_current_lucky_stacks(max_allowed_stacks)
            self.gambler_busy = false
            return
        end
        
        -- if the buff is less than zero, the dodge difference must make bring the current stacks to zero
        if temp_lucky_dodge_stacks <= 0 then
            -- value = -stonks -- not needed
            self:set_perm_dodge_buff(0)
            self:set_current_lucky_stacks(0)
            self.gambler_busy = false
            return
        end

        local final_stonks = stonks + value
        -- self.player:update_perm_dodge_buff(value) -- allows for bug bringing dodge to insane levels when proc'd too quickly.
        self:set_perm_dodge_buff(final_stonks)
        self:set_current_lucky_stacks(final_stonks)
        self.gambler_busy = false
    end
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