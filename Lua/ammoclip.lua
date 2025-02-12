-- init
Hooks: PostHook(AmmoClip, "init", "ammoclip_init_byp", function(self, unit) 
    self.gambler_lucky_dodge_stacks = 0 
    self.gambler_dodge_difference = 0
    self.gambler_unlucky_cap = tweak_data.upgrades.gambler_unlucky_cap
    self.gambler_max_lucky_dodge_stacks = tweak_data.upgrades.gambler_max_lucky_dodge_stacks
    self.gambler_lucky_dodge_incriment = tweak_data.upgrades.gambler_lucky_dodge_incriment
    self.gambler_lucky_dodge_decriment = tweak_data.upgrades.gambler_lucky_dodge_decriment
end)

local player_manager = managers.player

Hooks: PostHook(AmmoClip, "_pickup", function(self, unit) 
    local inventory = unit:inventory()
    self.gambler_dodge_difference = 0

    if self.picked_up then
        -- when healing from picking up ammo
        if not unit:character_damage():is_downed() and player_manager:has_category_upgrade("temporary", "loose_ammo_restore_health") and not player_manager:has_activate_temporary_upgrade("temporary", "loose_ammo_restore_health") then
            -- if you have my dodge incriment buff
            if player_manager:has_category_upgrade("player", "gambler_dodge") then
                -- Dodge luck calculation
                local old_lucky_dodge_stacks = self.gambler_lucky_dodge_stacks
                
                -- self._ammo_count is the ammo that has been picked up. 
                -- get the average of all weapon ammo
                -- local current_player_ammo = 0
                -- local current_player_ammo_calc = 0
                -- local current_player_num_weapons = 0
                -- for id, weapon in pairs(inventory:available_selections()) do
                --     current_player_num_weapons = current_player_num_weapons + 1
                --     local weapon_ammo = weapon.unit:base():ammo_info() -- is this a number, percentage, an element or what?
                --     current_player_ammo_calc = current_player_ammo_calc + weapon_ammo 
                -- end
                -- current_player_ammo = current_player_ammo_calc / current_player_num_weapons

            -- temp ammo workaround
                -- local weapon_1_ammo_info = 0
                -- for id, weapon in pairs(inventory:available_selections()) do
                --     local weapon_ammo = weapon.unit:base():ammo_info() -- is this a number, percentage, an element or what?
                --     weapon_1_ammo_info = weapon_ammo
                --     break
                -- end
                -- self.gambler_max_lucky_dodge_stacks = weapon_1_ammo_info * 100
            -- end temp ammo


                -- the higher the current ammo, the higher the chance of being unlucky. Caps at 50% chance of being unlucky at 50% or more current_player_ammo
                local player_unlucky_chance = 50
                -- local player_unlucky_chance = 0
                -- if current_player_ammo_percentage >= gambler_unlucky_cap then
                --     player_unlucky_chance = gambler_unlucky_cap
                -- else
                --     player_unlucky_chance = current_player_ammo_percentage
                -- end 

                local rand = 0
                if player_unlucky_chance > 0 then 
                    -- the more ammo you have, the higher the chance for a failure
                    rand = math.random() * 100  -- generates a random number between 0 and 100
                end
                
                -- local new_lucky_dodge_stacks = old_lucky_dodge_stacks
                if rand <= player_unlucky_chance then
                    -- unlucky, remove 10% dodge chance if the buff is greater than 0, otherwise set it to 0. 
                    -- if old_lucky_dodge_stacks > (gambler_lucky_dodge_decriment * -1) then
                        -- new_lucky_dodge_stacks = new_lucky_dodge_stacks + gambler_lucky_dodge_decriment
                        self.gambler_dodge_difference = self.gambler_lucky_dodge_decriment
                    -- else

                        -- new_lucky_dodge_stacks = 0
                else
                    -- lucky, add 5% dodge chance if the buff is less than 0.4, otherwise do nothing
                    -- if new_lucky_dodge_stacks < gambler_max_lucky_dodge_stacks / 100 then
                        -- new_lucky_dodge_stacks = new_lucky_dodge_stacks + gambler_lucky_dodge_incriment
                        self.gambler_dodge_difference = self.gambler_lucky_dodge_incriment
                    -- end
                end

                -- check
                local new_lucky_dodge_stacks = self.gambler_lucky_dodge_stacks + self.gambler_dodge_difference
                -- if the new value is higher than the cap, the dodge difference must make bring the current stacks to the cap
                if (new_lucky_dodge_stacks > self.gambler_max_lucky_dodge_stacks) then 
                    self.gambler_dodge_difference = self.gambler_max_lucky_dodge_stacks - self.gambler_lucky_dodge_stacks
                -- if the buff is less than zero, the dodge difference must make bring the current stacks to zero
                else if (new_lucky_dodge_stacks < 0) then
                    self.gambler_dodge_difference = -self.gambler_lucky_dodge_stacks 
                end
                
                -- todo: 
                -- pass the function correctly. ref: perk deck mod function: 
                -- get the current ammo correctly ref: updating the hud ammo
                -- to test if ammo works correctly, set dodge to be exactly equal to ammo percentage.
                -- apply the current dodge correctly. ref: sicario armor dodge.
            end
        end
    end
end)

-- apply the dodge
--v1.1 rewrote this to be future-proof, and it should be extremely less likely to conflict with other mods now,
--since it no longer overwrites the dodge calc function (at least, not really)
local orig_calc_dodge = player_manager.skill_dodge_chance
function player_manager:skill_dodge_chance(...)
    local chance = 0
    
	chance = chance + orig_calc_dodge(self,...)

    chance = change + self.gambler_lucky_dodge_stacks + self.gambler_dodge_difference
    
    return chance
end