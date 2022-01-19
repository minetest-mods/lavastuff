return function(cooldown, S)

local function finish(self)
	local pos = self.object:get_pos()

	if pos then
		minetest.after(0.1, function()
			if minetest.get_node(pos).name == "air" then
				minetest.set_node(pos, {name = "nc_optics:glass_hot_source"})
			end
		end)
	end
	self.object:remove()
end

minetest.register_entity("lavastuff:shoveling_glass", {
	is_visible = true,
	visual = "wielditem",
	textures = {"nc_optics:glass_hot_source"},
	visual_size = vector.new(0.66, 0.66, 0.66), -- scale to just under regular node size
	collisionbox = {-0.48, -0.48, -0.48, 0.48, 0.48, 0.48},
	physical = true,
	collide_with_objects = false,
	makes_footstep_sound = false,
	backface_culling = true,
	static_save = true,
	pointable = false,
	glow = minetest.LIGHT_MAX,
	on_punch = function() return true end,
	on_step = function(self, dtime)
		if not self.player then return finish(self) end

		local player = minetest.get_player_by_name(self.player)
		if not player then return finish(self) end

		if player:get_player_control().dig or player:get_wielded_item():get_name() ~= "lavastuff:shovel" then
			cooldown:set(player) -- remove cooldown that was set when the glass was picked up
			return finish(self)
		end

		local phead = vector.add(player:get_pos(), {x=0,z=0, y = player:get_properties().eye_height or 0})
		local targpos = vector.round(vector.add(phead, vector.multiply(player:get_look_dir(), 4)))
		local objpos = self.object:get_pos()

		local objtargpos = minetest.raycast(phead, targpos, false, true)
		local next = objtargpos:next()

		objtargpos = (next and next.type == "node" and next.above) or targpos

		local dist = vector.distance(objpos, objtargpos)

		if dist >= 0.4 then
			self.object:set_velocity(vector.multiply(vector.direction(objpos, objtargpos), dist * 5))
		elseif vector.length(self.object:get_velocity()) ~= 0 then
			self.object:set_velocity(vector.new(0, 0, 0))
			self.object:set_pos(objtargpos)
		end
	end,
})

minetest.override_item("lavastuff:sword", {
	sound = {breaks = "nc_api_toolbreak"},
})

minetest.override_item("lavastuff:pick", {
	tool_capabilities = minetest.registered_tools["nc_lux:tool_pick_tempered"].tool_capabilities,
	sound = {breaks = "nc_api_toolbreak"},
})

minetest.override_item("lavastuff:shovel", {
	tool_capabilities = minetest.registered_tools["nc_lux:tool_spade_tempered"].tool_capabilities,
	on_place = function(itemstack, user, pointed_thing, ...)
		if not pointed_thing or pointed_thing.type ~= "node" then return end

		local node = minetest.get_node(pointed_thing.under)
		local def = minetest.registered_nodes[node.name]

		if not cooldown:get(user) and (def.groups.sand or (def.groups.silica_molten and def.liquidtype == "source")) then
			cooldown:set(user, 0)
			minetest.remove_node(pointed_thing.under)
			local ent = minetest.add_entity(pointed_thing.under, "lavastuff:shoveling_glass")
			ent:get_luaentity().player = user:get_player_name()
		else
			return lavastuff.tool_fire_func(itemstack, user, pointed_thing, ...)
		end
	end,
	sound = {breaks = "nc_api_toolbreak"},
})

minetest.override_item("lavastuff:axe", {
	tool_capabilities = minetest.registered_tools["nc_lux:tool_hatchet_tempered"].tool_capabilities,
	on_place = lavastuff.tool_fire_func,
	sound = {breaks = "nc_api_toolbreak"},
})

end