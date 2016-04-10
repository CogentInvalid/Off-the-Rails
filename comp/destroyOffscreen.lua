destroyOffscreen = class("destroyOffscreen", component)

function destroyOffscreen:initialize(args)
	component.initialize(self, args)
	self.type = "destroyOffscreen"
	
	self.phys = self.parent:getComponent("physics")
end

function destroyOffscreen:update(dt)
	local cam = self.parent.game.camMan.cam
	local border = 550
	if self.phys.x > cam.x + border or self.phys.x < cam.x - border
	or self.phys.y > cam.y + border or self.phys.y < cam.y - border then
		self.parent.die = true
	end
end