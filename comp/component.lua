component = class("component")

function component:initialize(args)
	self.parent = args.parent
	self.game = args.parent.game
	self.type = "unknown"
	--todo: set self.type
	self.name = "unnamed"
	if args.name ~= nil then self.name = args.name end
end

function component:entID()
	return self.parent.id
end

function component:destroy()
end

function component:update(dt)
end

function component:draw()
end

function component:keypressed()
end

function component:mousepressed()
end