-- Crafitems
--

minetest.register_craftitem("lavastuff:ingot", {
description = "Lava ingot",
inventory_image = "lavastuff_ingot.png",
})
minetest.register_craftitem("lavastuff:orb", {
    description = "Lava orb",
    inventory_image = "zmobs_lava_orb.png"
})

--
-- Crafitem Crafts
--

if not minetest.global_exists("mobs_monster") then
minetest.register_craft({
output = 'lavastuff:orb',
recipe = {
{"bucket:bucket_lava", "bucket:bucket_lava", "bucket:bucket_lava"},
{"bucket:bucket_lava", "default:mese_crystal", "bucket:bucket_lava"},
{"bucket:bucket_lava", "bucket:bucket_lava", "bucket:bucket_lava"}
}
})
minetest.register_craft({
type = 'shapeless',
output = 'lavastuff:ingot',
recipe = {"default:mese_crystal", "lavastuff:orb"}
})
end
if minetest.global_exists("mobs_monster") then
minetest.register_craft({
type = 'shapeless',
output = 'lavastuff:ingot',
recipe = {"default:mese_crystal", "mobs:lava_orb"}
})
end

--
-- Tools
--

minetest.register_tool("lavastuff:sword", {
description = "Lava Sword",
inventory_image = "lavastuff_sword.png",
tool_capabilities = {
	full_punch_interval = 0.6,
	max_drop_level=1,
	groupcaps={
		snappy={times={[1]=1.90, [2]=0.90, [3]=0.30}, uses=50, maxlevel=3},
	},
	damage_groups = {fleshy=8},
	},
	sound = {breaks = "default_tool_breaks"},
})
minetest.register_tool("lavastuff:shovel", {
	description = "Lava Shovel",
	inventory_image = "lavastuff_shovel.png",
	wield_image = "lavastuff_shovel.png^[transformR90",
	tool_capabilities = {
		full_punch_interval = 0.7,
		max_drop_level=1,
		groupcaps={
			crumbly = {times={[1]=1.0, [2]=0.40, [3]=0.20}, uses=50, maxlevel=3},
		},
		damage_groups = {fleshy=4},
	},
	sound = {breaks = "default_tool_breaks"},
})
minetest.register_tool("lavastuff:axe", {
	description = "Lava Axe",
	inventory_image = "lavastuff_axe.png",
	tool_capabilities = {
		full_punch_interval = 0.7,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=2.0, [2]=0.80, [3]=0.40}, uses=50, maxlevel=3},
		},
		damage_groups = {fleshy=7},
	},
	sound = {breaks = "default_tool_breaks"},
})

--
-- Tool Crafts
--

minetest.register_craft({
	output = 'lavastuff:sword',
	recipe = {
		{'lavastuff:ingot'},
		{'lavastuff:ingot'},
		{'default:obsidian_shard'},
	}
})
minetest.register_craft({
	output = 'lavastuff:shovel',
	recipe = {
		{'lavastuff:ingot'},
		{'default:obsidian_shard'},
		{'default:obsidian_shard'},
	}
})
minetest.register_craft({
	output = 'lavastuff:axe',
	recipe = {
		{'lavastuff:ingot', 'lavastuff:ingot', ''},
		{'lavastuff:ingot', 'default:obsidian_shard', ''},
		{'', 'default:obsidian_shard', ''},
	}
})

--
-- Armor
--

minetest.register_tool("lavastuff:helmet", {
		description = "Lava Helmet",
		inventory_image = "lavastuff_inv_helmet.png",
		groups = {armor_head=10, armor_heal=10, armor_use=100, armor_fire=10},
		wear = 0,
	})
	minetest.register_tool("lavastuff:chestplate", {
		description = "Lava Chestplate",
		inventory_image = "lavastuff_inv_chestplate.png",
		groups = {armor_torso=10, armor_heal=10, armor_use=100, armor_fire=10},
		wear = 0,
	})
	minetest.register_tool("lavastuff:leggings", {
		description = "Lava Leggings",
		inventory_image = "lavastuff_inv_leggings.png",
		groups = {armor_legs=10, armor_heal=10, armor_use=100, armor_fire=10},
		wear = 0,
	})
	minetest.register_tool("lavastuff:boots", {
		description = "Lava Boots",
		inventory_image = "lavastuff_inv_boots.png",
		groups = {armor_feet=10, armor_heal=10, armor_use=100, armor_fire=10},
		wear = 0,
  })
        minetest.register_tool("lavastuff:shield", {
		description = "Lava Shield",
		inventory_image = "lavastuff_inven_shield.png",
		groups = {armor_shield=10, armor_heal=10, armor_use=100, armor_fire=10},
		wear = 0,
	})

  --
  -- Armor Crafts
  --

  minetest.register_craft({
  	output = 'lavastuff:helmet',
  	recipe = {
  		{'lavastuff:ingot', 'lavastuff:ingot', 'lavastuff:ingot'},
  		{'lavastuff:ingot', '', 'lavastuff:ingot'},
  		{'', '', ''},
  	}
  })
  minetest.register_craft({
  	output = 'lavastuff:chestplate',
  	recipe = {
  		{'lavastuff:ingot', '', 'lavastuff:ingot'},
  		{'lavastuff:ingot', 'lavastuff:ingot', 'lavastuff:ingot'},
  		{'lavastuff:ingot', 'lavastuff:ingot', 'lavastuff:ingot'},
  	}
  })
  minetest.register_craft({
  	output = 'lavastuff:leggings',
  	recipe = {
  		{'lavastuff:ingot', 'lavastuff:ingot', 'lavastuff:ingot'},
  		{'lavastuff:ingot', '', 'lavastuff:ingot'},
  		{'lavastuff:ingot', '', 'lavastuff:ingot'},
  	}
  })
  minetest.register_craft({
  	output = 'lavastuff:boots',
  	recipe = {
  		{'', '', ''},
  		{'lavastuff:ingot', '', 'lavastuff:ingot'},
  		{'lavastuff:ingot', '', 'lavastuff:ingot'},
  	}
  })
  minetest.register_craft({
  	output = 'lavastuff:shield',
  	recipe = {
  		{'lavastuff:ingot', 'lavastuff:ingot', 'lavastuff:ingot'},
  		{'lavastuff:ingot', 'lavastuff:ingot', 'lavastuff:ingot'},
  		{'', 'lavastuff:ingot', ''},
  	}
  })

  --
  -- Nodes
  --

  minetest.register_node ("lavastuff:block", {
  	description = "Lava Block",
  	tiles = {"lavastuff_block.png"},
  	is_ground_content = false,
  	sounds = default.node_sound_stone_defaults(),
  	groups = {cracky = 1, level = 2},
  	light_source = default.LIGHT_MAX,
  })
  minetest.register_node("lavastuff:stair", {
    description = 'Lava Stair',
    drawtype = "mesh",
    mesh = "stairs_stair.obj",
    tiles = {"lavastuff_block.png"},
    paramtype = "light",
    paramtype2 = "facedir",
    is_ground_content = false,
    groups = {cracky = 1, level = 2},
    light_source = default.LIGHT_MAX,
    selection_box = {
      type = "fixed",
      fixed = {
        {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
        {-0.5, 0, 0, 0.5, 0.5, 0.5},
      },
    },
    collision_box = {
      type = "fixed",
      fixed = {
        {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
        {-0.5, 0, 0, 0.5, 0.5, 0.5},
      },
    },
  })
  minetest.register_node("lavastuff:slab", {
      description = "Lava Slab",
      drawtype = "nodebox",
      tiles = {"lavastuff_block.png"},
      paramtype = "light",
      groups = {cracky = 1, level = 2},
    	light_source = default.LIGHT_MAX,
      node_box = {
          type = "fixed",
          fixed = {-0.5, -0.5, -0.5, 0.5, 0.0, 0.5}
      }
  })

  --
  -- Node Crafts
  --

  minetest.register_craft({
  	output = 'lavastuff:block',
  	recipe = {
  		{'lavastuff:ingot', 'lavastuff:ingot', 'lavastuff:ingot'},
  		{'lavastuff:ingot', 'lavastuff:ingot', 'lavastuff:ingot'},
  		{'lavastuff:ingot', 'lavastuff:ingot', 'lavastuff:ingot'},
  	}
  })
  minetest.register_craft ({
  output = "lavastuff:stair 6",
  recipe = {
  {'', '', 'lavastuff:block'},
  {'', 'lavastuff:block', 'lavastuff:block'},
  {'lavastuff:block', 'lavastuff:block', 'lavastuff:block'}
  }
  })
  minetest.register_craft ({
  type = 'shapeless',
  output = "lavastuff:slab 4",
  recipe = {'lavastuff:block', 'lavastuff:block'}
  })
