local CollectionService = game:GetService("CollectionService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local SERVER = RunService:IsServer()

local Binding = {}
Binding.__index = Binding

local function shouldBind(instance)
  -- You can have your own restrictions on what objects should be bound here.
  -- There are simply the ones I use, module will work without them.
	local ownerId = instance:GetAttribute("OwnerId")
	local effect = instance:GetAttribute("Effect")
	local owner = (SERVER and not ownerId) or (ownerId == Players.LocalPlayer.UserId)
	local remote = instance:GetAttribute("Remote")
	local private = instance:GetAttribute("Private")
	if (effect and SERVER) or (remote and owner) or (private and not owner) then
		return false
	end
	return true
end

function Binding.new(object, tag)
	local self = setmetatable({}, Binding)
	self._objects = {}
	self._added = CollectionService:GetInstanceAddedSignal(tag):Connect(function(instance)
		if not shouldBind(instance) then return end
		self._objects[instance] = object.new(instance)
	end)
	self._removed = CollectionService:GetInstanceRemovedSignal(tag):Connect(function(instance)
		if not self._objects[instance] then return end
		self._objects[instance]:destroy()
	end)
	return self
end

function Binding:destroy()
	self._added:Disconnect()
	self._removed:Disconnect()
	for _, object in self._objects do
		object:destroy()
	end
	setmetatable(self, nil)
	table.clear(self)
end

return Binding
