gameObject = class("gameObject")

function gameObject:initialize(args)
	self.id = "gameObject"
	self.name = args.name or "unnamed"
	self.component = {}
	self.die = false --remove on next frame
	self.game = args.game --the game
end

function gameObject:update(dt)
	--update all components
	for i,comp in ipairs(self.component) do
		comp:update(dt)
	end
end

--add a component, return it.
function gameObject:addComponent(c)
	self.component[#self.component+1] = c
	return self.component[#self.component]
end

--get a component by type
--if there are multiple components of the same type, returns the first one.
function gameObject:getComponent(comp)
	for i, component in ipairs(self.component) do
		if component.type == comp then
			return component
		end
	end
end

--get a component by name
--if multiple components with the same name, returns the first.
function gameObject:getComponentByName(name)
	for i, component in ipairs(self.component) do
		if component.name == name then
			return component
		end
	end
end

--try to call func(args) on every component in the object
function gameObject:notifyComponents(func, args)
	for i, component in ipairs(self.component) do
		if component[func] ~= nil then
			component[func](component, args)
		end
	end
end

--safely remove an entity from the world
function gameObject:destroy()
	self.die = true
	--destroy each component
	for i, component in ipairs(self.component) do
		component:destroy()
	end
end