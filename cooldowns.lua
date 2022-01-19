return {
	players = {},
	set = function(self, player, time)
		local pname = player:get_player_name()

		if self.players[pname] then
			self.players[pname]:cancel()

			if not time then
				self.players[pname] = nil
				return
			end
		end

		if time > 0 then
			self.players[pname] = minetest.after(time, function() self.players[pname] = nil end)
		else
			self.players[pname] = {cancel = function() end}
		end
	end,
	get = function(self, player)
		return self.players[player:get_player_name()]
	end
}