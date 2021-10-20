local S

if minetest.get_translator ~= nil then
	S = minetest.get_translator(minetest.get_current_modname())
else
	S = function(str)
		return(str)
	end
end

-- Armor
--

if minetest.get_modpath("3d_armor") then
	armor.materials.lava = "lavastuff:ingot"
	armor.config.material_lava = true

	armor:register_armor("lavastuff:helmet_lava", {
		description = S("Lava Helmet"),
		inventory_image = "lavastuff_inv_helmet.png",
		light_source = 7, -- Texture will have a glow when dropped
		groups = {armor_head=1, armor_heal=12, armor_use=100, armor_fire=10},
		armor_groups = {fleshy=15},
		damage_groups = {cracky=2, snappy=1, level=3},
		wear = 0,
	})
	minetest.register_alias("lavastuff:helmet", "lavastuff:helmet_lava")

	armor:register_armor("lavastuff:chestplate_lava", {
		description = S("Lava Chestplate"),
		inventory_image = "lavastuff_inv_chestplate.png",
		light_source = 7, -- Texture will have a glow when dropped
		groups = {armor_torso=1, armor_heal=12, armor_use=100, armor_fire=10},
		armor_groups = {fleshy=20},
		damage_groups = {cracky=2, snappy=1, level=3},
		wear = 0,
	})
	minetest.register_alias("lavastuff:chestplate", "lavastuff:chestplate_lava")

	armor:register_armor("lavastuff:leggings_lava", {
		description = S("Lava Leggings"),
		inventory_image = "lavastuff_inv_leggings.png",
		light_source = 7, -- Texture will have a glow when dropped
		groups = {armor_legs=1, armor_heal=12, armor_use=100, armor_fire=10},
		armor_groups = {fleshy=20},
		damage_groups = {cracky=2, snappy=1, level=3},
		wear = 0,
	})
	minetest.register_alias("lavastuff:leggings", "lavastuff:leggings_lava")

	armor:register_armor("lavastuff:boots_lava", {
		description = S("Lava Boots"),
		inventory_image = "lavastuff_inv_boots.png",
		light_source = 7, -- Texture will have a glow when dropped
		groups = {armor_feet=1, armor_heal=12, armor_use=100, armor_fire=10, physics_jump=0.5, physics_speed = 1},
		armor_groups = {fleshy=15},
		damage_groups = {cracky=2, snappy=1, level=3},
		wear = 0,
	})
	minetest.register_alias("lavastuff:boots", "lavastuff:boots_lava")

	if minetest.get_modpath("shields") then
		armor:register_armor("lavastuff:shield_lava", {
			description = S("Lava Shield"),
			inventory_image = "lavastuff_inven_shield.png",
			light_source = 7, -- Texture will have a glow when dropped
			groups = {armor_shield=1, armor_heal=12, armor_use=100, armor_fire=10},
			armor_groups = {fleshy=20},
			damage_groups = {cracky=2, snappy=1, level=3},
			wear = 0,
		})
		minetest.register_alias("lavastuff:shield", "lavastuff:shield_lava")
	end
end

--
-- Ingot craft
--

minetest.register_craft({
	type = "shapeless",
	output = "lavastuff:ingot 2",
	recipe = {"default:mese_crystal", "lavastuff:orb"}
})

--
-- Orb craft
--

if not minetest.get_modpath("mobs_monster") then
	minetest.register_craft({
		output = "lavastuff:orb",
		recipe = {
			{"default:mese_crystal", "default:mese_crystal", "default:mese_crystal"},
			{"default:mese_crystal", "bucket:bucket_lava", "default:mese_crystal"},
			{"default:mese_crystal", "default:mese_crystal", "default:mese_crystal"}
		},
		replacements = {{"bucket:bucket_lava", "bucket:bucket_empty"}}
	})
end

--
-- Tool crafts
--

minetest.register_craft({
	output = "lavastuff:sword",
	recipe = {
		{"lavastuff:ingot"},
		{"lavastuff:ingot"},
		{"default:obsidian_shard"},
	}
})

minetest.register_craft({
	output = "lavastuff:pick",
	recipe = {
		{"lavastuff:ingot", "lavastuff:ingot", "lavastuff:ingot"},
		{"", "default:obsidian_shard", ""},
		{"", "default:obsidian_shard", ""},
	}
})

minetest.register_craft({
	output = "lavastuff:shovel",
	recipe = {
		{"lavastuff:ingot"},
		{"default:obsidian_shard"},
		{"default:obsidian_shard"},
	}
})

minetest.register_craft({
	output = "lavastuff:axe",
	recipe = {
		{"lavastuff:ingot", "lavastuff:ingot", ""},
		{"lavastuff:ingot", "default:obsidian_shard", ""},
		{"", "default:obsidian_shard", ""},
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
		{"", "bucket:bucket_lava"},
		{"", "vessels:glass_bottle"},
	},
	replacements = {{"bucket:bucket_lava", "bucket:bucket_empty"}}
})
