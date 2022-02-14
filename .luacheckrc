unused_args = false
max_line_length = 999

globals = {
	"minetest", "lavastuff", "armor",
}

read_globals = {
	string = {fields = {"split"}},
	table = {fields = {"copy", "getn"}},

	-- Builtin
	"vector", "ItemStack",
	"dump", "DIR_DELIM", "VoxelArea", "Settings",

	-- MTG
	"default", "sfinv", "creative", "stairs",

	-- MC2
	"mcl_sounds",

	-- Nodecore
	"nodecore",

	-- Other mods
	"stairsplus", "toolranks", "gettext", "intllib",
}

exclude_files = {
	".luacheckrc",
}
