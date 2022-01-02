return function(cooldown, S)

for _, item in pairs({"lavastuff:sword", "lavastuff:pick", "lavastuff:axe", "lavastuff:shovel"}) do
	local itype = item:sub(item:find(":")+1)
	local mcldef = table.copy(minetest.registered_items[("mcl_tools:%s_diamond"):format(itype)])

	mcldef.tool_capabilities.damage_groups.fleshy = mcldef.tool_capabilities.damage_groups.fleshy + 1
	mcldef.tool_capabilities.full_punch_interval = mcldef.tool_capabilities.full_punch_interval - 0.1

	minetest.override_item(item, {
		tool_capabilities = mcldef.tool_capabilities,
		groups = mcldef.groups,
		wield_scale = mcldef.wield_scale,
		sound = mcldef.sound,
		_repair_material = "lavastuff:ingot",
		_mcl_toollike_wield = true,
		_doc_items_longdesc = mcldef._doc_items_longdesc,
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

for item, desc in pairs({
	["lavastuff:helmet"   ] = "Lava Helmet"    ,
	["lavastuff:chestplate"] = "Lava Chestplate",
	["lavastuff:leggings"  ] = "Lava Leggings"  ,
	["lavastuff:boots"     ] = "Lava Boots"     ,
}) do
	local itype = item:match(":(.+)")
	minetest.log(dump(("mcl_armor:%s_diamond"):format(itype)))
	local mcldef = table.copy(minetest.registered_items[("mcl_armor:%s_diamond"):format(itype)])

	mcldef.groups.mcl_armor_uses = mcldef.groups.mcl_armor_uses * 2
	mcldef.groups.armor_fire = 10
	mcldef.groups.physics_jump   = 0.5
	mcldef.groups.physics_speed  = 1

	minetest.register_tool(item, {
		description = S(desc),
		texture = ("lavastuff_%s_lava"):format(itype),
		_doc_items_longdesc = mcldef._doc_items_longdesc,
		_doc_items_usagehelp = mcldef._doc_items_longdesc,
		inventory_image = "lavastuff_inv_"..itype..".png",
		light_source = 7, -- Texture will have a glow when dropped
		groups = mcldef.groups,
		_repair_material = "lavastuff:ingot",
		sounds = mcldef.sounds,
		on_place = mcldef.on_place,
		on_secondary_use = mcldef.on_place,
	})
end

end