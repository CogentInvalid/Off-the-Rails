rotate = class("rotate", component)

function rotate:initialize(args)
	component.initialize(self, args)
	self.type = "rotate"
	
	self.speed = args.speed
	self.img = self.parent:getComponent("image")
end

function rotate:update(dt)
	self.img.rotation = self.img.rotation + self.speed
end