Hooks:PostHook(AmmoClip, "init", "ammoclip_init_byp", function(self, unit) 
    self.gambler_lucky_dodge_stacks = 0
    self.gambler_max_lucky_dodge_stacks = tweak_data.upgrades.gambler_max_lucky_dodge_stacks
    self.gambler_lucky_dodge_incriment = tweak_data.upgrades.gambler_lucky_dodge_incriment
    self.gambler_lucky_dodge_decriment = tweak_data.upgrades.gambler_lucky_dodge_decriment
    self.gambler_unlucky_chance_cap = tweak_data.upgrades.gambler_unlucky_chance_cap
    self.gambler_unlucky_chance_position = tweak_data.upgrades.gambler_unlucky_chance_position
end)

function AmmoClip:getCurrentPlayerAmmoPercentage(player_manager, inventory)
    -- Gets the average of both weapons after picked up ammo is added to inventory, if picking up ammo. 
    local current_player_ammo = 0
    local current_player_ammo_calc = 0
    local current_player_num_weapons = 0    
    for id, weapon in pairs(inventory:available_selections()) do
        local weapon_ammo = weapon.unit:base():get_ammo_ratio()
        current_player_num_weapons = current_player_num_weapons + 1
        current_player_ammo_calc = current_player_ammo_calc + weapon_ammo 
    end
    current_player_ammo = current_player_ammo_calc / current_player_num_weapons

    return current_player_ammo
end

Hooks:PostHook(AmmoClip, "_pickup", "gambl_pickup", function(self, unit) 
    local player_manager = managers.player
    local inventory = unit:inventory()
    
    -- if player_manager:has_category_upgrade("temporary", "gam_luk") then -- couldn't get this working in upgradesTweak. Effects are the same using the below instead.
    if not unit:character_damage():is_downed() and player_manager:has_category_upgrade("temporary", "loose_ammo_restore_health") and player_manager:upgrade_value("temporary", "loose_ammo_restore_health") = 3 then
        local old_lucky_dodge_stacks = self.gambler_lucky_dodge_stacks
        local new_dodge_difference = 0
        local unlucky_grace_period = self.gambler_unlucky_chance_position - self.gambler_unlucky_chance_cap -- the ammo floor, below which you are safe from being unlucky.  A.K.A,grace period.
        local current_player_ammo_percentage = self:getCurrentPlayerAmmoPercentage(player_manager, inventory) - unlucky_grace_period
    
        -- the higher the current ammo, the higher the chance of being unlucky.
        local player_unlucky_chance = 0
        if current_player_ammo_percentage >= self.gambler_unlucky_chance_cap then
            player_unlucky_chance = self.gambler_unlucky_chance_cap
        else
            player_unlucky_chance = current_player_ammo_percentage
        end 
        
        -- Dodge luck calculation
        local rand = 0
        if player_unlucky_chance > 0 then 
            rand = math.random()  -- generates a random number between 0 and 1
        end
        
        -- local new_lucky_dodge_stacks = old_lucky_dodge_stacks
        if rand > player_unlucky_chance then
            -- lucky
            new_dodge_difference = self.gambler_lucky_dodge_incriment
        else
            -- unlucky
            new_dodge_difference = self.gambler_lucky_dodge_decriment
        end
            
        -- check
        local new_lucky_dodge_stacks = self.gambler_lucky_dodge_stacks + new_dodge_difference
        
        -- if the new value is higher than the cap, the dodge difference must make bring the current stacks to the cap
        if (new_lucky_dodge_stacks > self.gambler_max_lucky_dodge_stacks) then 
            new_dodge_difference = self.gambler_max_lucky_dodge_stacks - self.gambler_lucky_dodge_stacks
        
        -- if the buff is less than zero, the dodge difference must make bring the current stacks to zero
        else if (new_lucky_dodge_stacks < 0) then
            new_dodge_difference = -self.gambler_lucky_dodge_stacks 
        end
        
        managers.player:update_perm_dodge_buff(new_dodge_difference)
    end
end)
    