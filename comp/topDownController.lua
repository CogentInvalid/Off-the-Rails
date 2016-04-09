topDownController = class("topDownController", component)

function topDownController:initialize(args)
	component.initialize(self, args)
	self.type = "topDownController"
	
	--TODO: actually use these
	self.speed = args.speed or 300
	self.friction = args.friction or 2
	
	self.phys = self.parent:getComponent("physics")
end

function topDownController:update(dt)
	if not self.phys then self.phys = self.parent:getComponent("physics") end
	if self.phys == nil then crash("topDownController error: No physics component found") end
	
	--TODO: replace with actually-good movement
	--TODO TODO: maybe don't use keyDown
	self.phys.vx = 0
	self.phys.vy = 0
	
	if keyDown("left") then self.phys.vx = -200 end
	if keyDown("right") then self.phys.vx = 200 end
	if keyDown("up") then self.phys.vy = -200 end
	if keyDown("down") then self.phys.vy = 200 end
	
	--debug
	if keyDown("e") then self.phys.col = false else self.phys.col = true end
	
	--friction
	self.phys.vx = self.phys.vx - self.phys.vx*dt
	self.phys.vy = self.phys.vy - self.phys.vy*dt
	
end