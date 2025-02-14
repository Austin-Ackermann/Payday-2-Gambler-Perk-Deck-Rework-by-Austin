---@diagnostic disable: undefined-global
Hooks:PostHook(UpgradesTweakData, "_init_pd2_values", "upgradestweak_init_byp", function(self)
	-- Lowering gambler health and ammo gain but removing the cooldowns. 
	
	-- player healing
	self.values.temporary.loose_ammo_restore_health = {}
	for i, data in ipairs(self.loose_ammo_restore_health_values) do
		local base = self.loose_ammo_restore_health_values.base -- AKA 8 hp in game
		
		table.insert(self.values.temporary.loose_ammo_restore_health, {
			{
				math.ceil((base + data[1]) * 0.2), -- lowering the health regen to compensate for the cooldown change
				math.ceil((base + data[2]) * 0.2)
			},
			0 -- original: self.loose_ammo_restore_health_values.cd AKA 3 seconds in game
		})
	end
	
	-- teammates healing
	for i, data in ipairs(self.loose_ammo_restore_health_values) do
		local base = self.loose_ammo_restore_health_values.base -- AKA 8 hp in game
		
		table.insert(self.values.temporary.loose_ammo_restore_health, {
			{
				math.ceil((base + data[1]) * 0.2), -- lowering the health regen to compensate for the cooldown change
				math.ceil((base + data[2]) * 0.2)
			},
			self.loose_ammo_restore_health_values.cd
		})
		
	end
	
	-- teammates ammo
	self.loose_ammo_give_team_ratio = 0.1 -- default 0.5 AKA 50% of player ammo gain ingame.
	self.loose_ammo_give_team_health_ratio = 0.3 -- default: 0.5 AKA 50% of player hp gain ingame.
	
	-- player ammo 
	self.values.temporary.loose_ammo_give_team = {
		{
			true,
			0 -- default: 5 AKA 5 second cooldown between ammo pickups. 
		}
	}
end)

Hooks:PostHook(UpgradesTweakData, "_temporary_definitions", "upgradestweak_tmp_definitions_byp", function(self)
	-- gambler's dodge
	self.gambler_max_lucky_dodge_stacks = 0.5 -- default: 40 AKA 40% dodge chance in game
	self.gambler_lucky_dodge_incriment = 0.1 -- default: 0.1 AKA 10% dodge chance in game
	self.gambler_lucky_dodge_decriment = -0.05 -- default: -0.05 AKA -5% dodge chance in game
	self.gambler_unlucky_chance_cap = 0.75 -- default: 0.75 AKA 75% chance of failure max.
    self.gambler_unlucky_chance_position = 1 -- default: 1 AKA unluck caps out at 100% ammo remaining.

	-- self.definitions.temporary_gam_luk_1 = { -- attempted to make a skill for the new dodge mechanic, but as soon as it is equiped, the game crashes: tried to index null value in playermanager.
	-- 	name_id = "menu_temporary_gam_luk",
	-- 	category = "temporary",
	-- 	upgrade = {
	-- 		value = 1,
	-- 		upgrade = "gam_luk",
	-- 		category = "temporary"
	-- 	}
	-- }
end)