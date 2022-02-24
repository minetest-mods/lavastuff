lavastuff = {}

local MODNAME = minetest.get_current_modname()
local MODPATH = minetest.get_modpath(MODNAME)

local COOLDOWN = dofile(MODPATH.."/cooldowns.lua")
local S

if minetest.get_translator ~= nil then
	S = minetest.get_translator(MODNAME)
else
	if minetest.get_modpath("intllib") then
		dofile(minetest.get_modpath("intllib").."/init.lua")
		if intllib.make_gettext_pair then
			-- New method using gettext.
			gettext, ngettext = intllib.make_gettext_pair()
		else
			-- Old method using text files.
			gettext = intllib.Getter()
		end
		S = gettext
	else
		-- mock the translator function for MT 0.4
		function minetest.translate(textdomain, str, ...)
			local arg = {n=select('#', ...), ...}
			return str:gsub("@(.)", function(matched)
				local c = string.byte(matched)
				if string.byte("1") <= c and c <= string.byte("9") then
					return arg[c - string.byte("0")]
				else
					return matched
				end
			end)
		end
		function minetest.get_translator(textdomain)
			return function(str, ...) return  minetest.translate(textdomain or "", str, ...) end
		end
		S = minetest.get_translator(MODNAME)
	end
end

lavastuff.enable_tool_fire = minetest.settings:get_bool("lavastuff_enable_tool_fire")
-- Places fire where the player rightclicks with a lava tool

lavastuff.cook_limit = minetest.settings:get("lavastuff_cook_limit")
-- Tools will not smelt dug items if their cooking time is too long

if lavastuff.cook_limit ~= false then
	lavastuff.cook_limit = 15
end

if lavastuff.enable_tool_fire ~= false then
	lavastuff.enable_tool_fire = true
end

minetest.log("action",
	"[lavastuff]: Settings loaded"..
	"\n\tenable_tool_fire = "..dump(lavastuff.enable_tool_fire) ..
	"\n\tcook_limit = "..dump(lavastuff.cook_limit)
)

lavastuff.blacklisted_items = { -- Items lava tools will not smelt
	"default:mese_crystal",
	"default:mese",
}

if minetest.get_modpath("default") then
	lavastuff.game = "minetest_game"
elseif minetest.get_modpath("mcl_core") then
	lavastuff.game = "mineclone"
elseif minetest.get_modpath("nc_api_all") then
	lavastuff.game = "nodecore"
end

if not lavastuff.game then
	minetest.log("error", "[lavastuff]: No supported game found! Proceed with caution")
else
	minetest.log("action", "[lavastuff]: Game detected: "..lavastuff.game)
end

if minetest.get_modpath("fire") then
	lavastuff.fire_node = "fire:basic_flame"
elseif minetest.get_modpath("mcl_fire") then
	lavastuff.fire_node = "mcl_fire:fire"
elseif minetest.get_modpath("nc_fire") then
	lavastuff.fire_node = "nc_fire:fire"
else
	minetest.log("error", "[lavastuff]: No fire mod found! Tool fire will be disabled")
end

if lavastuff.enable_tool_fire == true and lavastuff.fire_node then
	local function activate_func(user, pointedname, pointeddef, pointed)
		if pointeddef.on_ignite then
			pointeddef.on_ignite(pointed.under, user)
		elseif lavastuff.fire_node and minetest.registered_nodes[lavastuff.fire_node] and
		minetest.get_item_group(pointedname, "flammable") >= 1 and
		minetest.get_node(pointed.above).name == "air" then
			minetest.set_node(pointed.above, {name = lavastuff.fire_node})

			if lavastuff.game == "nodecore" then
				nodecore.fire_check_ignite(pointed.under)
			end
		end
	end

	function lavastuff.tool_fire_func(itemstack, user, pointed)
		local name = user:get_player_name()

		if pointed.type == "node" then
			local node = minetest.get_node(pointed.under)
			local def = minetest.registered_nodes[node.name]

			if def.on_rightclick then
				return def.on_rightclick(pointed.under, node, user, itemstack, pointed)
			end

			if minetest.is_protected(pointed.under, name) then return end

			-- Only allow fire every 1+ second(s)
			if not COOLDOWN:get(user) then
				activate_func(user, node.name, def, pointed)
				COOLDOWN:set(user, 1)
			end
		end
	end
end

function lavastuff.burn_drops(tool)
	local old_handle_node_drops = minetest.handle_node_drops

	function minetest.handle_node_drops(pos, drops, digger, ...)
		if not digger or digger:get_wielded_item():get_name() ~= (tool) then
			return old_handle_node_drops(pos, drops, digger, ...)
		end

		-- reset new smelted drops
		local hot_drops = {}

		-- loop through current node drops
		for _, drop in pairs(drops) do -- get cooked output of current drops
			local stack = ItemStack(drop)
			local safety = 0

			repeat
				local output, leftover = minetest.get_craft_result({
					method = "cooking",
					width = 1,
					items = {stack:to_string()}
				})

				for _, name in pairs(lavastuff.blacklisted_items) do
					if name == drop then
						return old_handle_node_drops(pos, drops, digger, ...)
					end
				end

				-- if we have cooked result then add to new list
				if output and output.item and not output.item:is_empty() and output.time <= lavastuff.cook_limit then
					table.insert(hot_drops,
						ItemStack({
							name = output.item:get_name(),
							count = output.item:to_table().count,
						})
					)

					stack = leftover.items[1]
				else -- if not then return normal drops
					table.insert(hot_drops, stack)
					stack = nil
				end

				safety = safety + 1
			until (safety > 999 or not stack or stack:get_count() <= 0)

			if safety > 999 then
				minetest.log("error", "[lavastuff]: Something went wrong with drop cooking")
			end
		end

		return old_handle_node_drops(pos, hot_drops, digger, ...)
	end
end

lavastuff.burn_drops("lavastuff:sword" )
lavastuff.burn_drops("lavastuff:pick"  )
lavastuff.burn_drops("lavastuff:axe"   )
lavastuff.burn_drops("lavastuff:shovel")

--
-- Crafitem
--

minetest.register_craftitem("lavastuff:ingot", {
	description = S("Lava Ingot"),
	inventory_image = "lavastuff_ingot.png",
	light_source = 7, -- Texture will have a glow when dropped
	groups = {craftitem = 1},
})

--
-- Orb compat and registration
--

if not minetest.get_modpath("mobs_monster") then
	minetest.register_craftitem("lavastuff:orb", {
		description = S("Lava Orb"),
		inventory_image = "zmobs_lava_orb.png",
		light_source = 7, -- Texture will have a glow when dropped
		groups = {craftitem = 1},
	})

	minetest.register_alias("mobs:lava_orb", "lavastuff:orb")
else
	minetest.register_alias("lavastuff:orb", "mobs:lava_orb")
end

--
-- Armor Crafts
--

if minetest.get_modpath("3d_armor") or minetest.get_modpath("mcl_armor") then
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

	if not minetest.get_modpath("mcl_armor") then
		minetest.register_craft({
			output = "lavastuff:shield",
			recipe = {
				{"lavastuff:ingot", "lavastuff:ingot", "lavastuff:ingot"},
				{"lavastuff:ingot", "lavastuff:ingot", "lavastuff:ingot"},
				{"", "lavastuff:ingot", ""},
			}
		})
	end
end

--
--- Tools
--

minetest.register_tool("lavastuff:sword", {
	description = S("Lava Sword"),
	inventory_image = "lavastuff_sword.png",
	groups = {weapon = 1, sword = 1},
	light_source = 7, -- Texture will have a glow when dropped
	tool_capabilities = {
		full_punch_interval = 0.6,
		max_drop_level = 1,
		groupcaps = {
			snappy = {
				times = {1.7, 0.7, 0.25},
				uses = 50,
				maxlevel = 3
			},
		},
		damage_groups = {fleshy = 10, burns = 1},
	},
	on_place = lavastuff.tool_fire_func,
	sound = {breaks = "default_tool_breaks"},
})

minetest.register_alias_force("mobs:pick_lava", "lavastuff:pick")
minetest.register_tool("lavastuff:pick", {
	description = S("Lava Pickaxe"),
	inventory_image = "lavastuff_pick.png",
	groups = {tool = 1, pickaxe = 1},
	light_source = 7, -- Texture will have a glow when dropped
	tool_capabilities = {
		full_punch_interval = 0.7,
		max_drop_level = 3,
		groupcaps={
			cracky = {
				times = {1.8, 0.8, 0.40},
				uses = 40,
				maxlevel = 3
			},
		},
		damage_groups = {fleshy = 6, burns = 1},
	},
	on_place = lavastuff.tool_fire_func,
	sound = {breaks = "default_tool_breaks"},
})

minetest.register_tool("lavastuff:shovel", {
	description = S("Lava Shovel"),
	inventory_image = "lavastuff_shovel.png",
	wield_image = "lavastuff_shovel.png^[transformR90",
	groups = {tool = 1, shovel = 1},
	light_source = 7, -- Texture will have a glow when dropped
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=1,
		groupcaps={
			crumbly = {
				times = {[1]=1.10, [2]=0.50, [3]=0.30},
				uses = 30,
				maxlevel = 3
			},
		},
		damage_groups = {fleshy=4},
	},
	on_place = lavastuff.tool_fire_func,
	sound = {breaks = "default_tool_breaks"},
})

minetest.register_tool("lavastuff:axe", {
	description = S("Lava Axe"),
	inventory_image = "lavastuff_axe.png",
	groups = {tool = 1, axe = 1},
	light_source = 7, -- Texture will have a glow when dropped
	tool_capabilities = {
		full_punch_interval = 0.8,
		max_drop_level = 1,
		groupcaps = {
			choppy = {
				times = {2.00, 0.80, 0.40},
				uses = 40,
				maxlevel = 3
			},
		},
		damage_groups = {fleshy = 7, burns = 1},
	},
	on_place = lavastuff.tool_fire_func,
	sound = {breaks = "default_tool_breaks"},
})

--
-- Tool Craft
--

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
-- Nodes
--

minetest.register_node("lavastuff:block", {
	description = S("Lava Block"),
	tiles = {"lavastuff_block.png"},
	is_ground_content = false,
	sounds = default and default.node_sound_glass_defaults(),
	groups = {cracky = 2, level = 2},
	light_source = 6,
})

if minetest.get_modpath("moreblocks") then
	stairsplus:register_all("lavastuff", "lava", "lavastuff:ingot", {
		description = "Lava",
		tiles = {"lavastuff_block.png"},
		groups = {cracky = 2, level = 2},
		light_source = 6,
		sounds = default and default.node_sound_glass_defaults(),
	})
elseif minetest.get_modpath("stairs") then
	stairs.register_stair_and_slab(
		"lava",
		"lavastuff:block",
		{cracky = 2, level = 2},
		{"lavastuff_block.png"},
		S("Lava Stair"),
		S("Lava Slab"),
		default.node_sound_glass_defaults(),
		true,
		S("Inner Lava Stair"),
		S("Outer Lava Stair")
	)
end

--
--Toolranks support
--

if minetest.get_modpath("toolranks") then
	minetest.override_item("lavastuff:sword", {
		description = toolranks.create_description(S("Lava Sword"), 0, 1),
		original_description = S("Lava Sword"),
		after_use = toolranks.new_afteruse
	})

	minetest.override_item("lavastuff:pick", {
		description = toolranks.create_description(S("Lava Pickaxe"), 0, 1),
		original_description = S("Lava Pickaxe"),
		after_use = toolranks.new_afteruse
	})

	minetest.override_item("lavastuff:axe", {
		description = toolranks.create_description(S("Lava Axe"), 0, 1),
		original_description = S("Lava Axe"),
		after_use = toolranks.new_afteruse
	})

	minetest.override_item("lavastuff:shovel", {
		description = toolranks.create_description(S("Lava Shovel"), 0, 1),
		original_description = S("Lava Shovel"),
		after_use = toolranks.new_afteruse
	})
end

--
-- Lava in a Bottle
--

minetest.register_node("lavastuff:lava_in_a_bottle", {
	description = S("Lava in a Bottle"),
	drawtype = "plantlike",
	tiles = {{
		name = "lavastuff_lava_in_a_bottle.png",
		animation = {
			type = "vertical_frames",
			aspect_w = 16,
			aspect_h = 16,
			length = 2.0
		}
	}},
	inventory_image = "lavastuff_lava_in_a_bottle.png^[verticalframe:2:0",
	wield_image = "lavastuff_lava_in_a_bottle.png^[verticalframe:2:0",
	paramtype = "light",
	light_source = 9,
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	},
	groups = {vessel = 1, dig_immediate = 3, attached_node = 1},
	sounds = default and default.node_sound_glass_defaults(),
})

--
-- Register crafts/tools based on current game
--

minetest.log("action", "[lavastuff]: Base stuff loaded, beginning game compatibility...")

if lavastuff.game == "nodecore" then
	dofile(MODPATH .. "/crafts/nodecore.lua")
	dofile(MODPATH.."/items/nodecore.lua")(COOLDOWN, S)
elseif lavastuff.game == "mineclone" then
	dofile(MODPATH.."/items/mineclone.lua")(COOLDOWN, S)
	dofile(MODPATH .. "/crafts/mineclone.lua")
else
	if lavastuff.game == "minetest_game" then
		dofile(MODPATH .. "/crafts/minetest_game.lua")
	end
end

minetest.log("action", "[lavastuff]: Mod Loaded!")
