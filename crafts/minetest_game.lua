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

if not minetest.get_modpath("mobs_monster") and minetest.get_modpath("bucket") then
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

if minetest.get_modpath("bucket") and minetest.get_modpath("vessels") then
	minetest.register_craft({
		output = "lavastuff:lava_in_a_bottle",
		recipe = {
			{"", "bucket:bucket_lava"},
			{"", "vessels:glass_bottle"},
		},
		replacements = {{"bucket:bucket_lava", "bucket:bucket_empty"}}
	})
end