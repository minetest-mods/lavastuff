local S = minetest.get_translator(minetest.get_current_modname())

for _, item in pairs({"lavastuff:sword", "lavastuff:pick", "lavastuff:axe", "lavastuff:shovel"}) do
	local itype = item:sub(item:find(":")+1)
	local mcldef = table.copy(minetest.registered_items[("mcl_tools:%s_diamond"):format(itype)])
	local groups = table.copy(minetest.registered_items[item].groups)

	mcldef.tool_capabilities.damage_groups.fleshy = mcldef.tool_capabilities.damage_groups.fleshy + 1
	mcldef.tool_capabilities.full_punch_interval = mcldef.tool_capabilities.full_punch_interval - 0.1
	groups.dig_speed_class = mcldef.groups.dig_speed_class

	minetest.override_item(item, {
		tool_capabilities = mcldef.tool_capabilities,
		groups = groups,
		wield_scale = vector.new(1.8, 1.8, 1),
		_repair_material = "lavastuff:ingot",
	})
end

minetest.override_item("lavastuff:block", {
	stack_max = 64,
	groups = {pickaxey=3, building_block=1},
	sounds = mcl_sounds.node_sound_stone_defaults(),
	_mcl_blast_resistance = 6,
	_mcl_hardness = 4,
})

for _, item in pairs({"lavastuff:ingot", "lavastuff:orb"}) do
	minetest.override_item(item, {
		stack_max = 64,
	})
end

minetest.register_tool("lavastuff:helmet",{
	description = S("Lava Helmet"),
	inventory_image = "lavastuff_inv_helmet.png",
	light_source = 7, -- Texture will have a glow when dropped
	groups = {armor_head=1, mcl_armor_points=3, mcl_armor_uses=600, mcl_armor_toughness=3},
	_repair_material = "lavastuff:ingot",
	sounds = {
		_mcl_armor_equip = "mcl_armor_equip_diamond",
		_mcl_armor_unequip = "mcl_armor_unequip_diamond",
	},
	on_place = armor.on_armor_use,
	on_secondary_use = armor.on_armor_use,
})

minetest.register_tool("lavastuff:chestplate", {
	description = S("Lava Chestplate"),
	inventory_image = "lavastuff_inv_chestplate.png",
	light_source = 7, -- Texture will have a glow when dropped
	groups = {armor_torso=1, mcl_armor_points=8, mcl_armor_uses=600, mcl_armor_toughness=3},
	_repair_material = "lavastuff:ingot",
	sounds = {
		_mcl_armor_equip = "mcl_armor_equip_diamond",
		_mcl_armor_unequip = "mcl_armor_unequip_diamond",
	},
	on_place = armor.on_armor_use,
	on_secondary_use = armor.on_armor_use,
})

minetest.register_tool("lavastuff:leggings", {
	description = S("Lava Leggings"),
	inventory_image = "lavastuff_inv_leggings.png",
	light_source = 7, -- Texture will have a glow when dropped
	groups = {armor_legs=1, mcl_armor_points=6, mcl_armor_uses=600, mcl_armor_toughness=3},
	_repair_material = "lavastuff:ingot",
	sounds = {
		_mcl_armor_equip = "mcl_armor_equip_diamond",
		_mcl_armor_unequip = "mcl_armor_unequip_diamond",
	},
	on_place = armor.on_armor_use,
	on_secondary_use = armor.on_armor_use,
})

minetest.register_tool("lavastuff:boots", {
	description = S("Lava Boots"),
	inventory_image = "lavastuff_inv_boots.png",
	light_source = 7, -- Texture will have a glow when dropped
	groups = {armor_feet=1, mcl_armor_points=3, mcl_armor_uses=600, mcl_armor_toughness=3},
	_repair_material = "lavastuff:ingot",
	sounds = {
		_mcl_armor_equip = "mcl_armor_equip_diamond",
		_mcl_armor_unequip = "mcl_armor_unequip_diamond",
	},
	on_place = armor.on_armor_use,
	on_secondary_use = armor.on_armor_use,
})

--
-- Ingot craft
--

minetest.register_craft({
	type = "shapeless",
	output = "lavastuff:ingot 2",
	recipe = {"mcl_mobitems:blaze_rod", "lavastuff:orb"}
})

--
-- Orb craft
--

minetest.register_craft({
	output = "lavastuff:orb",
	recipe = {
		{"mcl_mobitems:blaze_powder", "mcl_mobitems:magma_cream", "mcl_mobitems:blaze_powder"},
		{"mcl_mobitems:magma_cream", "mcl_buckets:bucket_lava", "mcl_mobitems:magma_cream"},
		{"", "mcl_mobitems:magma_cream", ""}
	},
	replacements = {{"mcl_buckets:bucket_lava", "mcl_buckets:bucket_empty"}}
})

--
-- Tool crafts
--

minetest.register_craft({
	output = "lavastuff:sword",
	recipe = {
		{"lavastuff:ingot"},
		{"lavastuff:ingot"},
		{"mcl_core:iron_ingot"},
	}
})

minetest.register_craft({
	output = "lavastuff:pick",
	recipe = {
		{"lavastuff:ingot", "lavastuff:ingot", "lavastuff:ingot"},
		{"", "mcl_core:iron_ingot", ""},
		{"", "mcl_core:iron_ingot", ""},
	}
})

minetest.register_craft({
	output = "lavastuff:shovel",
	recipe = {
		{"lavastuff:ingot"},
		{"mcl_core:iron_ingot"},
		{"mcl_core:iron_ingot"},
	}
})

minetest.register_craft({
	output = "lavastuff:axe",
	recipe = {
		{"lavastuff:ingot", "lavastuff:ingot", ""},
		{"lavastuff:ingot", "mcl_core:iron_ingot", ""},
		{"", "mcl_core:iron_ingot", ""},
	}
})

--
-- Block crafts
--

minetest.register_craft({
	type = "shapeless",
	output = "lavastuff:ingot 9",
	recipe = {"lavastuff:block"}
})

minetest.register_craft({
	output = "lavastuff:block",
	recipe = {
		{"lavastuff:ingot", "lavastuff:ingot", "lavastuff:ingot"},
		{"lavastuff:ingot", "lavastuff:ingot", "lavastuff:ingot"},
		{"lavastuff:ingot", "lavastuff:ingot", "lavastuff:ingot"},
	}
})

--
-- Lava in a Bottle craft
--

minetest.register_craft({
	output = "lavastuff:lava_in_a_bottle",
	recipe = {
		{"", "mcl_buckets:bucket_lava"},
		{"", "mcl_potions:glass_bottle"},
	},
	replacements = {{"mcl_buckets:bucket_lava", "mcl_buckets:bucket_empty"}}
})
