# Binding
 Roblox object oriented binder module.

Usage:  
local Ability = require(game.ReplicatedStorage.AbilityClass)  
local Binding = require((game.ReplicatedStorage.Binding)  

local bind = Binding.new(AbilityClass, "Ability", function() return true end)  

local ability = bind.objects[abilityInstance]  

bind:destroy()

Watch this to see benefits of using this pattern:
https://youtu.be/Db3LooLQM1Q?t=1866

Or read this:
https://create.roblox.com/docs/reference/engine/classes/CollectionService
