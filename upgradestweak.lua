local old_init = UpgradesTweakData.init
function UpgradesTweakData:init(tweak_data)
	old_init(self, tweak_data)

	-- GAMBLER CHANGES --
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

	-- gambler's dodge
	-- When picking up ammo, add 5% dodge chance, up to 40% increase. Chance to lose 10% dodge chance instead (cannot go below 0), which depends on the percentage of ammo you have remaining (max 50% chance).
	self.values.player.gambler_unlucky_cap = 50 -- the unluckiest you could possibly be. default: 50 AKA 50% chance of failure.
	self.values.player.gambler_max_lucky_dodge_stacks = 40 -- default: 40 AKA 40% dodge chance in game
	self.values.player.gambler_lucky_dodge_incriment = 5 -- default: 5 AKA 5% dodge chance in game
	self.values.player.gambler_lucky_dodge_decriment = -10 -- default: -10 AKA 40% dodge chance in game

	self.definitions.player_gambler_dodge = {
		name_id = "player_gambler_dodge",
		category = "feature",
		upgrade = {
			value = 1,
			upgrade = "gambler_dodge",
			category = "player"
		}
	}

	-- /GAMBLER CHANGES --
	
end