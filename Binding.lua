local CollectionService = game:GetService("CollectionService")

local Binding = {}
Binding.__index = Binding

function Binding.new(object, tag, predicate)
	local self = setmetatable({}, Binding)
	self.objects = {}
	self._added = CollectionService:GetInstanceAddedSignal(tag):Connect(function(instance)
		if predicate(instance) then
			self.objects[instance] = object.new(instance)
		end
	end)
	self._removed = CollectionService:GetInstanceRemovedSignal(tag):Connect(function(instance)
		if not self.objects[instance] then return end
		self.objects[instance]:destroy()
		self.objects[instance] = nil
	end)
	return self
end

function Binding:destroy()
	self._added:Disconnect()
	self._removed:Disconnect()
	for _, object in self.objects do
		object:destroy()
	end
	setmetatable(self, nil)
	table.clear(self)
end

return Binding
