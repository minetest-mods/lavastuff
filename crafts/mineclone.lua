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
