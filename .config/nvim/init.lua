require("utils")

require("config")
require("misc")

local load_if_exists = require("utils").load_if_exists
load_if_exists("config/local.lua")
load_if_exists("misc/local.lua")
