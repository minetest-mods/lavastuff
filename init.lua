lavastuff = {}

lavastuff.enable_lightup = true -- Lights up the area around the player that punches air with the lava sword

function lavastuff.burn_drops(tool)
    local old_handle_node_drops = minetest.handle_node_drops

    function minetest.handle_node_drops(pos, drops, digger)
        if digger:get_wielded_item():get_name() ~= (tool) then -- are we holding Lava Pick?
            return old_handle_node_drops(pos, drops, digger)
        end

        -- reset new smelted drops
        local hot_drops = {}

        -- loop through current node drops
        for _, drop in pairs(drops) do -- get cooked output of current drops
            local stack = ItemStack(drop)
            local output = minetest.get_craft_result({
                method = "cooking",
                width = 1,
                items = {drop}
            })

            -- if we have cooked result then add to new list
            if output and output.item and not output.item:is_empty() then
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
end

lavastuff.burn_drops("lavastuff:sword")
lavastuff.burn_drops("lavastuff:axe")
lavastuff.burn_drops("lavastuff:shovel")

--
-- Crafitems
--

minetest.register_craftitem("lavastuff:ingot", {
    description = "Lava ingot",
    inventory_image = "lavastuff_ingot.png",
})

minetest.register_craft({
    type = "shapeless",
    output = "lavastuff:ingot",
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
        output = "lavastuff:orb",
        recipe = {
            {"", "bucket:bucket_lava", ""},
            {"bucket:bucket_lava", "default:mese_crystal", "bucket:bucket_lava"},
            {"", "bucket:bucket_lava", ""}
        },
        replacements = {{"bucket:bucket_lava", "bucket:bucket_empty 4"}}
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
    on_secondary_use = function(itemstack, user, pointed_thing)
        if lavastuff.enable_lightup == true then
            local pos = user:get_pos()
            
            pos.y = pos.y + 1

            if minetest.get_node(pos).name == "air" then
                minetest.set_node(pos, {name = "lavastuff:light"})
                minetest.after(0.4, minetest.remove_node, pos)
            end
        end
    end,
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
        on_secondary_use = function(itemstack, user, pointed_thing)
            if lavastuff.enable_lightup == true then
                local pos = user:get_pos()
                
                pos.y = pos.y + 1
    
                if minetest.get_node(pos).name == "air" then
                    minetest.set_node(pos, {name = "lavastuff:light"})
                    minetest.after(0.4, minetest.remove_node, pos)
                end
            end
        end,
    })

-- Lava Pick (restores autosmelt functionality)

    lavastuff.burn_drops("lavastuff:pick")
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
    armor:register_armor("lavastuff:helmet", {
        description = "Lava Helmet",
        inventory_image = "lavastuff_inv_helmet.png",
        groups = {armor_head=17, armor_heal=10, armor_use=100, armor_fire=10},
        armor_groups = {fleshy=20},
        damage_groups = {cracky=2, snappy=1, level=3},
        wear = 0,
    })

    armor:register_armor("lavastuff:chestplate", {
        description = "Lava Chestplate",
        inventory_image = "lavastuff_inv_chestplate.png",
        groups = {armor_torso=10, armor_heal=10, armor_use=100, armor_fire=10},
        armor_groups = {fleshy=20},
        damage_groups = {cracky=2, snappy=1, level=3},
        wear = 0,
    })

    armor:register_armor("lavastuff:leggings", {
        description = "Lava Leggings",
        inventory_image = "lavastuff_inv_leggings.png",
        groups = {armor_legs=10, armor_heal=10, armor_use=100, armor_fire=10},
        armor_groups = {fleshy=20},
        damage_groups = {cracky=2, snappy=1, level=3},
        wear = 0,
    })

    armor:register_armor("lavastuff:boots", {
        description = "Lava Boots",
        inventory_image = "lavastuff_inv_boots.png",
        groups = {armor_feet=10, armor_heal=10, armor_use=100, armor_fire=10},
        armor_groups = {fleshy=17},
        damage_groups = {cracky=2, snappy=1, level=3},
        wear = 0,
    })

    armor:register_armor("lavastuff:shield", {
        description = "Lava Shield",
        inventory_image = "lavastuff_inven_shield.png",
        groups = {armor_shield=10, armor_heal=10, armor_use=100, armor_fire=10},
        armor_groups = {fleshy=20},
        damage_groups = {cracky=2, snappy=1, level=3},
        wear = 0,
    })
end
  --
  -- Armor Crafts
  --

if minetest.get_modpath("3d_armor") then
    minetest.register_craft({
        output = "lavastuff:helmet",
        recipe = {
            {"lavastuff:ingot", "lavastuff:ingot", "lavastuff:ingot"},
            {"lavastuff:ingot", "", "lavastuff:ingot"},
            {"", "", ""},
        }
    })

    minetest.register_craft({
        output = "lavastuff:chestplate",
        recipe = {
            {"lavastuff:ingot", "", "lavastuff:ingot"},
            {"lavastuff:ingot", "lavastuff:ingot", "lavastuff:ingot"},
            {"lavastuff:ingot", "lavastuff:ingot", "lavastuff:ingot"},
        }
    })

    minetest.register_craft({
        output = "lavastuff:leggings",
        recipe = {
            {"lavastuff:ingot", "lavastuff:ingot", "lavastuff:ingot"},
            {"lavastuff:ingot", "", "lavastuff:ingot"},
            {"lavastuff:ingot", "", "lavastuff:ingot"},
        }
    })

    minetest.register_craft({
        output = "lavastuff:boots",
        recipe = {
            {"lavastuff:ingot", "", "lavastuff:ingot"},
            {"lavastuff:ingot", "", "lavastuff:ingot"},
        }
    })

    minetest.register_craft({
        output = "lavastuff:shield",
        recipe = {
            {"lavastuff:ingot", "lavastuff:ingot", "lavastuff:ingot"},
            {"lavastuff:ingot", "lavastuff:ingot", "lavastuff:ingot"},
            {"", "lavastuff:ingot", ""},
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
    groups = {cracky = 2, level = 2},
    light_source = default.LIGHT_MAX,
})

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

if not minetest.get_modpath("moreblocks") then
    stairs.register_stair_and_slab(
        "lava",
        "lavastuff:block",
        {cracky = 2, level = 2},
        {"lavastuff_block.png"},
        "Lava Stair",
        "Lava Slab",
        default.node_sound_stone_defaults(),
        true
    )
else
    stairsplus:register_all("lavastuff", "lava", "lavastuff:ingot", {
        description = "Lava",
        tiles = {"lavastuff_block.png"},
        groups = {cracky = 2, level = 2},
        light_source = default.LIGHT_MAX,
        sounds = default.node_sound_wood_defaults(),
    })
end

--
--Toolranks support
--

if minetest.get_modpath("toolranks") then
    minetest.override_item("lavastuff:sword", {
        description = toolranks.create_description("Lava Sword", 0, 1),
        original_description = "Lava Sword",
        after_use = toolranks.new_afteruse
    })

    minetest.override_item("lavastuff:pick", {
        description = toolranks.create_description("Lava Pickaxe", 0, 1),
        original_description = "Lava Pickaxe",
        after_use = toolranks.new_afteruse
    })

    minetest.override_item("lavastuff:axe", {
        description = toolranks.create_description("Lava Axe", 0, 1),
        original_description = "Lava Axe",
        after_use = toolranks.new_afteruse
    })

    minetest.override_item("lavastuff:shovel", {
        description = toolranks.create_description("Lava Shovel", 0, 1),
        original_description = "Lava Shovel",
        after_use = toolranks.new_afteruse
    })
end

--
-- Light node
--

minetest.register_node("lavastuff:light", {
	description = minetest.colorize("red", "You shouldnt be holding this!!"),
	drawtype = "airlike",
	paramtype = "light",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	sunlight_propagates = true,
	light_source = 15,
    inventory_image = "air.png^default_mese_crystal.png",
    groups = {not_in_creative_inventory = 1}
})
