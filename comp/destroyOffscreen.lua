destroyOffscreen = class("destroyOffscreen", component)

function destroyOffscreen:initialize(args)
	component.initialize(self, args)
	self.type = "destroyOffscreen"
	
	self.phys = self.parent:getComponent("physics")
	self.phys.collideOrder = {}
end

function destroyOffscreen:update(dt)
	local cam = self.parent.game.camMan.cam
	local border = 550
	if self.phys.x > cam.x + border or self.phys.x < cam.x - border
	or self.phys.y > cam.y + border or self.phys.y < cam.y - border then
		self.parent.die = true
	end
end

function destroyOffscreen:collisionDetected(col)
	if col.other.parent.id == "box" or col.other.parent.id == "wall" then
		self.parent.die = true
	end
end