minetest.register_craftitem("lavastuff:orb", {
    description = "Lava orb",
    inventory_image = "zmobs_lava_orb.png"
})
minetest.register_craft({
type = 'shapeless',
output = 'mobs:lava_orb',
recipe = {"lavastuff:orb"}
})
minetest.register_craft({
type = 'shapeless',
output = 'mobs:lava_orb 9',
recipe = {'lavastuff:block'}
})
minetest.register_tool("lavastuff:sword", {
description = "Lava Sword",
inventory_image = "lavastuff_sword.png",
tool_capabilities = {
	full_punch_interval = 0.6,
	max_drop_level=1,
	groupcaps={
		snappy={times={[1]=1.90, [2]=0.90, [3]=0.30}, uses=40, maxlevel=3},
	},
	damage_groups = {fleshy=8},
	},
	sound = {breaks = "default_tool_breaks"},
})
minetest.register_craft({
	output = 'lavastuff:sword',
	recipe = {
		{'mobs:lava_orb'},
		{'mobs:lava_orb'},
		{'default:obsidian_shard'},
	}
})
minetest.register_node ("lavastuff:block", {
	description = "Lava Block",
	tiles = {"lavastuff_block.png"},
	paramtype = "light",
	sunglight_propagates = true,
	is_ground_content = false,
	sounds = default.node_sound_stone_defaults(),
	groups = {cracky = 1, level = 2},
	light_source = default.LIGHT_MAX,
})
minetest.register_craft({
	output = 'lavastuff:block',
	recipe = {
		{'mobs:lava_orb', 'mobs:lava_orb', 'mobs:lava_orb'},
		{'mobs:lava_orb', 'mobs:lava_orb', 'mobs:lava_orb'},
		{'mobs:lava_orb', 'mobs:lava_orb', 'mobs:lava_orb'},
	}
})
minetest.register_tool("lavastuff:helmet", {
		description = "Lava Helmet",
		inventory_image = "lavastuff_inv_helmet.png",
		groups = {armor_head=10, armor_heal=10, armor_use=100, armor_fire=1},
		wear = 0,
	})
	minetest.register_tool("lavastuff:chestplate", {
		description = "Lava Chestplate",
		inventory_image = "lavastuff_inv_chestplate.png",
		groups = {armor_torso=10, armor_heal=10, armor_use=100, armor_fire=1},
		wear = 0,
	})
	minetest.register_tool("lavastuff:leggings", {
		description = "Lava Leggings",
		inventory_image = "lavastuff_inv_leggings.png",
		groups = {armor_legs=10, armor_heal=10, armor_use=100, armor_fire=1},
		wear = 0,
	})
	minetest.register_tool("lavastuff:boots", {
		description = "Lava Boots",
		inventory_image = "lavastuff_inv_boots.png",
		groups = {armor_feet=10, armor_heal=10, armor_use=100, armor_fire=1},
		wear = 0,
        })
        minetest.register_tool("lavastuff:shield", {
		description = "Lava Shield",
		inventory_image = "lavastuff_inven_shield.png",
		groups = {armor_shield=10, armor_heal=10, armor_use=100, armor_fire=1},
		wear = 0,
	})
minetest.register_craft({
	output = 'lavastuff:helmet',
	recipe = {
		{'mobs:lava_orb', 'mobs:lava_orb', 'mobs:lava_orb'},
		{'mobs:lava_orb', '', 'mobs:lava_orb'},
		{'', '', ''},
	}
})
minetest.register_craft({
	output = 'lavastuff:chestplate',
	recipe = {
		{'mobs:lava_orb', '', 'mobs:lava_orb'},
		{'mobs:lava_orb', 'mobs:lava_orb', 'mobs:lava_orb'},
		{'mobs:lava_orb', 'mobs:lava_orb', 'mobs:lava_orb'},
	}
})
minetest.register_craft({
	output = 'lavastuff:leggings',
	recipe = {
		{'mobs:lava_orb', 'mobs:lava_orb', 'mobs:lava_orb'},
		{'mobs:lava_orb', '', 'mobs:lava_orb'},
		{'mobs:lava_orb', '', 'mobs:lava_orb'},
	}
})
minetest.register_craft({
	output = 'lavastuff:boots',
	recipe = {
		{'', '', ''},
		{'mobs:lava_orb', '', 'mobs:lava_orb'},
		{'mobs:lava_orb', '', 'mobs:lava_orb'},
	}
})
minetest.register_craft({
	output = 'lavastuff:shield',
	recipe = {
		{'mobs:lava_orb', 'mobs:lava_orb', 'mobs:lava_orb'},
		{'mobs:lava_orb', 'mobs:lava_orb', 'mobs:lava_orb'},
		{'', 'mobs:lava_orb', ''},
	}
})
if not minetest.global_exists("mobs_monster") then
minetest.register_craftitem("lavastuff:orb", {
    description = "Lava orb",
    inventory_image = "zmobs_lava_orb.png"
})
minetest.register_craft({
output = 'lavastuff:orb',
recipe = {
{'', 'bucket:bucket_lava', ''},
{'bucket:bucket_lava', 'bucket:bucket_lava', 'bucket:bucket_lava'},
{'', 'bucket:bucket_lava', ''},
}
})
minetest.register_craft({
	output = 'lavastuff:helmet',
	recipe = {
		{'lavastuff:orb', 'lavastuff:orb', 'lavastuff:orb'},
		{'lavastuff:orb', '', 'lavastuff:orb'},
		{'', '', ''},
	}
})
minetest.register_craft({
	output = 'lavastuff:chestplate',
	recipe = {
		{'lavastuff:orb', '', 'lavastuff:orb'},
		{'lavastuff:orb', 'lavastuff:orb', 'lavastuff:orb'},
		{'lavastuff:orb', 'lavastuff:orb', 'lavastuff:orb'},
	}
})
minetest.register_craft({
	output = 'lavastuff:leggings',
	recipe = {
		{'lavastuff:orb', 'lavastuff:orb', 'lavastuff:orb'},
		{'lavastuff:orb', '', 'lavastuff:orb'},
		{'lavastuff:orb', '', 'lavastuff:orb'},
	}
})
minetest.register_craft({
	output = 'lavastuff:boots',
	recipe = {
		{'', '', ''},
		{'lavastuff:orb', '', 'lavastuff:orb'},
		{'lavastuff:orb', '', 'lavastuff:orb'},
	}
})
minetest.register_craft({
	output = 'lavastuff:shield',
	recipe = {
		{'lavastuff:orb', 'lavastuff:orb', 'lavastuff:orb'},
		{'lavastuff:orb', 'lavastuff:orb', 'lavastuff:orb'},
		{'', 'lavastuff:orb', ''},
	}
})
minetest.register_craft({
type = 'shapeless',
output = 'lavastuff:orb 9',
recipe = {'lavastuff:block'}
})
minetest.register_craft({
	output = 'lavastuff:sword',
	recipe = {
		{'lavastuff:orb'},
		{'lavastuff:orb'},
		{'default:obsidian_shard'},
	}
})
minetest.register_craft({
	output = 'lavastuff:block',
	recipe = {
		{'lavastuff:orb', 'lavastuff:orb', 'lavastuff:orb'},
		{'lavastuff:orb', 'lavastuff:orb', 'lavastuff:orb'},
		{'lavastuff:orb', 'lavastuff:orb', 'lavastuff:orb'},
	}
})
end

