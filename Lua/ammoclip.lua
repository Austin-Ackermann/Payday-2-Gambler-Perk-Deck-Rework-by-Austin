Hooks:PostHook(AmmoClip, "init", "ammoclip_init_byp", function(self, unit) 
    self.gambler_lucky_dodge_stacks = 0
    self.gambler_max_lucky_dodge_stacks = tweak_data.upgrades.gambler_max_lucky_dodge_stacks
    self.gambler_lucky_dodge_incriment = tweak_data.upgrades.gambler_lucky_dodge_incriment
    self.gambler_lucky_dodge_decriment = tweak_data.upgrades.gambler_lucky_dodge_decriment
    self.gambler_unlucky_chance_cap = tweak_data.upgrades.gambler_unlucky_chance_cap
    self.gambler_unlucky_chance_position = tweak_data.upgrades.gambler_unlucky_chance_position
end)

Hooks:PostHook(AmmoClip, "_pickup", "gambl_pickup", function(self, unit) 
    local player_manager = managers.player
    local inventory = unit:inventory()

    if not unit:character_damage():is_downed() and player_manager:has_category_upgrade("temporary", "loose_ammo_restore_health") and player_manager:has_category_upgrade("player", "passive_loot_drop_multiplier") then
        local new_dodge_difference = 0
        local unlucky_grace_period = self.gambler_unlucky_chance_position - self.gambler_unlucky_chance_cap -- the ammo floor, below which you are safe from being unlucky.  A.K.A,grace period.
        
        -- -- Gets the average of both weapons after picked up ammo is added to inventory
        local current_player_ammo_calc = 0
        local current_player_num_weapons = 0    
        for id, weapon in pairs(inventory:available_selections()) do
            local weapon_ammo = weapon.unit:base():get_ammo_ratio()
            current_player_num_weapons = current_player_num_weapons + 1
            current_player_ammo_calc = current_player_ammo_calc + weapon_ammo 
        end
        local current_player_ammo_percentage = (current_player_ammo_calc / current_player_num_weapons) - unlucky_grace_period

        -- -- the higher the current ammo, the higher the chance of being unlucky.
        local player_unlucky_chance = 0
        if current_player_ammo_percentage > self.gambler_unlucky_chance_cap then
            player_unlucky_chance = self.gambler_unlucky_chance_cap
        else
            player_unlucky_chance = current_player_ammo_percentage
        end 

        -- Dodge luck calculation
        local rand = 0
        if player_unlucky_chance > 0 then 
            rand = math.random(0, 100) / 100 -- generates a random number between 0 and 1
        end
        if rand > player_unlucky_chance then
            -- lucky
            new_dodge_difference = self.gambler_lucky_dodge_incriment
        else
            -- unlucky
            new_dodge_difference = self.gambler_lucky_dodge_decriment
        end
            
        -- check
        local temp_lucky_dodge_stacks = self.gambler_lucky_dodge_stacks + new_dodge_difference
        -- if the new value is higher than the cap, the dodge difference must make bring the current stacks to the cap
        if temp_lucky_dodge_stacks > self.gambler_max_lucky_dodge_stacks then 
            new_dodge_difference = self.gambler_max_lucky_dodge_stacks - self.gambler_lucky_dodge_stacks
        end
        if temp_lucky_dodge_stacks < 0 then
            -- if the buff is less than zero, the dodge difference must make bring the current stacks to zero
            new_dodge_difference = -self.gambler_lucky_dodge_stacks 
        end

        managers.player:update_perm_dodge_buff(new_dodge_difference)
        self.gambler_lucky_dodge_stacks = self.gambler_lucky_dodge_stacks + new_dodge_difference

    end
end)
    