# Binding
 Roblox object oriented binder module.

Usage:
local Binding = require((game.ReplicatedStorage.Binding)
local DamageObject = require(game.ReplicatedStorage.DamageObject)

local bind = Binding.new(DamageObject, "Damage")

bind:Destroy()

Watch this to see benefits of using this pattern:
https://youtu.be/Db3LooLQM1Q?t=1866

Or read this:
https://create.roblox.com/docs/reference/engine/classes/CollectionService
