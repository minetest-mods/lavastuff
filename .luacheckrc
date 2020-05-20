unused_args = false
max_line_length = 999

globals = {
    "minetest", "lavastuff",
}

read_globals = {
    string = {fields = {"split"}},
    table = {fields = {"copy", "getn"}},

    -- Builtin
    "vector", "ItemStack",
    "dump", "DIR_DELIM", "VoxelArea", "Settings",

    -- MTG
    "default", "sfinv", "creative", "stairs",

    -- Other mods
    "armor", "stairsplus", "toolranks",
}
