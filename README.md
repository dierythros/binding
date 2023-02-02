# Binding
 Roblox object oriented binder module.

Usage:
local Binding = require((game.ReplicatedStorage.Binding)
local DamageObject = require(game.ReplicatedStorage.DamageObject)

local bind = Binding.new(DamageObject, "Damage")

bind:Destroy()
