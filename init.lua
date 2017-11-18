--
-- Crafitems
--

minetest.register_craftitem("lavastuff:ingot", {
description = "Lava ingot",
inventory_image = "lavastuff_ingot.png",
})

minetest.register_craft({
    type = 'shapeless',
    output = 'lavastuff:ingot',
    recipe = {"default:mese_crystal", "lavastuff:orb"}
})

--
-- Crafitem Crafts
--

if not minetest.get_modpath("mobs_monster") then
    minetest.register_craftitem("lavastuff:orb", {
      description = "Lava orb",
      inventory_image = "zmobs_lava_orb.png"
    })

    minetest.register_alias("mobs:lava_orb", "lavastuff:orb")

    minetest.register_craft({
    output = 'lavastuff:orb',
    recipe = {
    {"bucket:bucket_lava", "bucket:bucket_lava", "bucket:bucket_lava"},
    {"bucket:bucket_lava", "default:mese_crystal", "bucket:bucket_lava"},
    {"bucket:bucket_lava", "bucket:bucket_lava", "bucket:bucket_lava"}
    }
    })
  else
    minetest.register_alias("lavastuff:orb", "mobs:lava_orb")
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
if not minetest.get_modpath("mobs_monster") then
  minetest.register_alias("mobs:pick_lava", "lavastuff:pick")
  minetest.register_tool("lavastuff:pick", {
  	description = ("Lava Pickaxe"),
  	inventory_image = "lavastuff_pick.png",
  	tool_capabilities = {
  		full_punch_interval = 0.7,
  		max_drop_level=3,
  		groupcaps={
  			cracky = {times={[1]=1.80, [2]=0.80, [3]=0.40}, uses=50, maxlevel=3},
  		},
  		damage_groups = {fleshy=5},
  	},
  })
  -- Lava Pick (restores autosmelt functionality)

  local old_handle_node_drops = minetest.handle_node_drops

  function minetest.handle_node_drops(pos, drops, digger)

    -- are we holding Lava Pick?
    if digger:get_wielded_item():get_name() ~= ("lavastuff:pick") then
      return old_handle_node_drops(pos, drops, digger)
    end

    -- reset new smelted drops
    local hot_drops = {}

    -- loop through current node drops
    for _, drop in pairs(drops) do

      -- get cooked output of current drops
      local stack = ItemStack(drop)
      local output = minetest.get_craft_result({
        method = "cooking",
        width = 1,
        items = {drop}
      })

      -- if we have cooked result then add to new list
      if output
      and output.item
      and not output.item:is_empty() then

        table.insert(hot_drops,
          ItemStack({
            name = output.item:get_name(),
            count = output.item:to_table().count,
          })
        )
      else -- if not then return normal drops
        table.insert(hot_drops, stack)
      end
    end

    return old_handle_node_drops(pos, hot_drops, digger)
  end
else
  minetest.register_alias("lavastuff:pick", "mobs:pick_lava")
  minetest.register_tool(":mobs:pick_lava", {
  description = ("Lava Pickaxe"),
  inventory_image = "lavastuff_pick.png",
  tool_capabilities = {
    full_punch_interval = 0.7,
    max_drop_level=3,
    groupcaps={
      cracky = {times={[1]=1.80, [2]=0.80, [3]=0.40}, uses=50, maxlevel=3},
    },
    damage_groups = {fleshy=5},
  },
  })
end
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
	output = "lavastuff:pick",
	recipe = {
		{"lavastuff:ingot", "lavastuff:ingot", "lavastuff:ingot"},
		{"", "default:obsidian_shard", ""},
		{"", "default:obsidian_shard", ""},
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
if minetest.get_modpath("mobs_monster") then
  minetest.clear_craft({
    recipe = {
  		{"mobs:lava_orb", "mobs:lava_orb", "mobs:lava_orb"},
  		{"", "default:obsidian_shard", ""},
  		{"", "default:obsidian_shard", ""},
  	}
  })
end

--
-- Armor
--

if minetest.get_modpath("3d_armor") then
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
end
  --
  -- Armor Crafts
  --

if minetest.get_modpath("3d_armor") then
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
end
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

--
--Toolranks support
--

if minetest.get_modpath("toolranks") then
    minetest.override_item("lavastuff:sword", {
       original_description = "Lava Sword",
       description = toolranks.create_description("Lava Sword", 0, 1),
        after_use = toolranks.new_afteruse})
	minetest.override_item("lavastuff:pick", {
       original_description = "Lava Pickaxe",
       description = toolranks.create_description("Lava Pickaxe", 0, 1),
        after_use = toolranks.new_afteruse})
	minetest.override_item("lavastuff:axe", {
       original_description = "Lava Axe",
       description = toolranks.create_description("Lava Axe", 0, 1),
        after_use = toolranks.new_afteruse})
	minetest.override_item("lavastuff:shovel", {
       original_description = "Lava Shovel",
       description = toolranks.create_description("Lava Shovel", 0, 1),
        after_use = toolranks.new_afteruse})
end
