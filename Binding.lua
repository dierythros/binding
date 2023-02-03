local CollectionService = game:GetService("CollectionService")

local Binding = {}
Binding.__index = Binding

local function shouldBind(instance)
	-- You can have your own restrictions on what objects should be bound here.
	-- Return false if you want an object to not be bound.
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
		self._objects[instance]:Destroy()
		self._objects[instance] = nil
	end)
	return self
end

function Binding:Destroy()
	self._added:Disconnect()
	self._removed:Disconnect()
	for _, object in self._objects do
		object:Destroy()
	end
	setmetatable(self, nil)
	table.clear(self)
end

return Binding
