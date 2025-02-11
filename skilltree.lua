local skill_data = SkillTreeTweakData.init
function SkillTreeTweakData:init(tweak_data)
	skill_data(self, tweak_data)
	
	-- defining common cards
	local deck2 = {
		upgrades = {
			"weapon_passive_headshot_damage_multiplier"
		},
		cost = 300,
		icon_xy = {1, 0},
		name_id = "menu_deckall_2",
		desc_id = "menu_deckall_2_desc"
	}
	local deck4 = {
		upgrades = {
			"passive_player_xp_multiplier",
			"player_passive_suspicion_bonus",
			"player_passive_armor_movement_penalty_multiplier"
		},
		cost = 600,
		icon_xy = {3, 0},
		name_id = "menu_deckall_4",
		desc_id = "menu_deckall_4_desc"
	}
	local deck6 = {
		upgrades = {
			"armor_kit",
			"player_pick_up_ammo_multiplier"
		},
		cost = 1600,
		icon_xy = {5, 0},
		name_id = "menu_deckall_6",
		desc_id = "menu_deckall_6_desc"
	}
	local deck8 = {
		upgrades = {
			"weapon_passive_damage_multiplier",
			"passive_doctor_bag_interaction_speed_multiplier"
		},
		cost = 3200,
		icon_xy = {7, 0},
		name_id = "menu_deckall_8",
		desc_id = "menu_deckall_8_desc"
	}

	-- creating a new Gambler deck
	local newGambler = {
		{
			cost = 200,
			desc_id = "menu_deck10_1_desc",
			short_id = "menu_deck10_1_short",
			name_id = "menu_deck10_1",
			upgrades = {
				"temporary_loose_ammo_restore_health_1",
				"player_gain_life_per_players"
			},
			icon_xy = {
				4,
				5
			}
		},
		deck2,
		{
			cost = 400,
			desc_id = "menu_deck10_3_desc",
			short_id = "menu_deck10_3_short",
			name_id = "menu_deck10_3",
			upgrades = {
				"temporary_loose_ammo_give_team",
				"player_passive_health_multiplier_1",
				"player_passive_health_multiplier_2"
			},
			icon_xy = {
				5,
				5
			}
		},
		deck4,
		{
			cost = 1000,
			desc_id = "menu_deck10_5_desc",
			short_id = "menu_deck10_5_short",
			name_id = "menu_deck10_5",
			upgrades = {
				"player_loose_ammo_restore_health_give_team",
				"player_passive_health_multiplier_3"
			},
			icon_xy = {
				6,
				5
			}
		},
		deck6,
		{
			cost = 2400,
			desc_id = "menu_deck10_7_desc",
			short_id = "menu_deck10_7_short",
			name_id = "menu_deck10_7",
			upgrades = {
				"temporary_loose_ammo_restore_health_2"
			},
			icon_xy = {
				7,
				5
			}
		},
		deck8,
		{
			cost = 4000,
			desc_id = "menu_deck10_9_desc",
			short_id = "menu_deck10_9_short",
			name_id = "menu_deck10_9",
			upgrades = {
				"player_passive_loot_drop_multiplier",
				"temporary_loose_ammo_restore_health_3",
				-- "temporary_armor_break_invulnerable_1", -- invulnerable for 2 seconds when armor broken, for testing.
				-- "player_wild_armor_amount_1",
				"player_armor_health_store_amount_1"
				-- add new dodge gain ability here
			},
			icon_xy = {
				0,
				6
			}
		},
		name_id = "menu_st_spec_10",
		desc_id = "menu_st_spec_10_desc",
		category = "supportive"
	}
	
	-- finding the gambler deck
	-- for deckIndex = i in self.specializations do
	-- 	if i.name_id = "menu_st_spec_10" do
	-- 		-- replacing the old deck with our new one
	-- 		self.specializations[deckIndex] = newGambler
	-- 		break
	-- 	end
	-- end

	-- replacing the grinder deck with our new one
	self.specializations[10] = newGambler -- will always be at index 9 when initialised.
	
	-- table.insert(self.specializations, newGambler)
	
	-- local newDeck = 	{
	-- 	name_id = "menu_st_spec_0",
	-- 	desc_id = "menu_st_spec_0_desc",
	-- 	{
	-- 		upgrades = {
	-- 	 	},
	-- 		cost = 0,
	-- 		icon_xy = {900, 8},
	-- 		name_id = "menu_deck0_1",
	-- 		desc_id = "menu_deck0_1_desc"
	-- 	},			
	-- 	{
	-- 		upgrades = {
	-- 			},
	-- 		cost = 0,
	-- 		icon_xy = {900, 5},
	-- 		name_id = "menu_deck0_2",
	-- 		desc_id = "menu_deck0_2_desc"
	-- 	},
	-- 	{
	-- 		upgrades = {
	-- 		},
	-- 		cost = 0,
	-- 		icon_xy = {900, 8},
	-- 		name_id = "menu_deck0_3",
	-- 		desc_id = "menu_deck0_3_desc"
	-- 	},
	-- 	{
	-- 		upgrades = {
	-- 		},
	-- 		cost = 0,
	-- 		icon_xy = {900, 8},
	-- 		name_id = "menu_deck0_4",
	-- 		desc_id = "menu_deck0_4_desc"
	-- 	},
	-- 	{
	-- 		upgrades = {
	-- 		},
	-- 		cost = 0,
	-- 		icon_xy = {900, 0},
	-- 		name_id = "menu_deck0_5",
	-- 		desc_id = "menu_deck0_5_desc"
	-- 	},

	-- 	{
	-- 		upgrades = {
	-- 		},
	-- 		cost = 0,
	-- 		icon_xy = {900, 8},
	-- 		name_id = "menu_deck0_7",
	-- 		desc_id = "menu_deck0_7_desc"
	-- 	},
	-- 	{
	-- 		upgrades = {
	-- 		},
	-- 		cost = 0,
	-- 		icon_xy = {900, 8},
	-- 		name_id = "menu_deck0_8",
	-- 		desc_id = "menu_deck0_8_desc"
	-- 	},
	-- 	{
	-- 		upgrades = {
	-- 		},
	-- 		cost = 0,
	-- 		icon_xy = {900, 8},
	-- 		name_id = "menu_deck0_9",
	-- 		desc_id = "menu_deck0_9_desc"
	-- 	},
	-- 			{
	-- 		upgrades = {
	-- 		},
	-- 		cost = 0,
	-- 		icon_xy = {900, 8},
	-- 		name_id = "menu_deck0_6",
	-- 		desc_id = "menu_deck0_6_desc"
	-- 	}
	-- 	}
		-- )
			
-- table.insert(self.specializations,
-- 			{
-- 			name_id = "menu_st_spec_00",
-- 			desc_id = "menu_st_spec_00_desc",
-- 			{
-- 				upgrades = {
-- 				},
-- 				cost = 0,
-- 				icon_xy = {900, 7},
-- 				name_id = "menu_deck00_1",
-- 				desc_id = "menu_deck00_1_desc"
-- 			},
-- 	{	
-- 	upgrades = {
-- 			"weapon_passive_headshot_damage_multiplier"
-- 		},
-- 		cost = 300,
-- 		icon_xy = {1, 0},
-- 		name_id = "menu_deckall_2",
-- 		desc_id = "menu_deckall_2_desc"
-- 	},
-- 			{
-- 				upgrades = {
-- 				},
-- 				cost = 0,
-- 				icon_xy = {900, 7},
-- 				name_id = "menu_deck0_3",
-- 				desc_id = "menu_deck0_3_desc"
-- 			},
-- 			{
-- 		upgrades = {
-- 			"passive_player_xp_multiplier",
-- 			"player_passive_suspicion_bonus",
-- 			"player_passive_armor_movement_penalty_multiplier"
-- 		},
-- 		cost = 600,
-- 		icon_xy = {3, 0},
-- 		name_id = "menu_deckall_4",
-- 		desc_id = "menu_deckall_4_desc"
-- 	},
-- 			{
-- 				upgrades = {
-- 				},
-- 				cost = 0,
-- 				icon_xy = {900, 7},
-- 				name_id = "menu_deck0_5",
-- 				desc_id = "menu_deck0_5_desc"
-- 			},
-- 			{
-- 		upgrades = {
-- 			"armor_kit",
-- 			"player_pick_up_ammo_multiplier"
-- 		},
-- 		cost = 1600,
-- 		icon_xy = {5, 0},
-- 		name_id = "menu_deckall_6",
-- 		desc_id = "menu_deckall_6_desc"
-- 	},
-- 			{
-- 				upgrades = {
-- 				},
-- 				cost = 0,
-- 				icon_xy = {900, 7},
-- 				name_id = "menu_deck0_7",
-- 				desc_id = "menu_deck0_7_desc"
-- 			},
-- 			{
-- 		upgrades = {
-- 			"weapon_passive_damage_multiplier",
-- 			"passive_doctor_bag_interaction_speed_multiplier"
-- 		},
-- 		cost = 3200,
-- 		icon_xy = {7, 0},
-- 		name_id = "menu_deckall_8",
-- 		desc_id = "menu_deckall_8_desc"
-- 	},
-- 			{
-- 				upgrades = {
-- 				},
-- 				cost = 0,
-- 				icon_xy = {900, 7},
-- 				name_id = "menu_deck0_9",
-- 				desc_id = "menu_deck0_9_desc"
-- 			}		
-- 		}
-- 		)
end