platformerController = class("platformerController", component)

function platformerController:initialize(args)
	component.initialize(self, args)
	self.type = "platformerController"
	
	--TODO: actually use these
	self.speed = args.speed or 200
	self.friction = args.friction or 2
	
	self.jumpForce = args.jumpForce or 400
	
	self.phys = self.parent:getComponent("physics")
end

function platformerController:update(dt)
	if not self.phys then self.phys = self.parent:getComponent("physics") end
	if self.phys == nil then crash("platformerController error: No physics component found") end
	
	--movement
	local phys = self.phys
	local input = self.game.inputMan

	--x-movement
	local accel = 2000; local maxSpeed = self.speed
	if not phys.onGround then accel = 1200 end
	
	if input:keyDown("left") and phys.vx > -maxSpeed then
		phys:addVel(-accel*dt, 0)
	end
	if input:keyDown("right") and phys.vx < maxSpeed then
		phys:addVel(accel*dt, 0)
	end

	--jumping/falling
	if phys.vy > 0 then
		phys.gravScale = 500
	else
		if input:keyDown("jump") then phys.gravScale = 500
		else phys.gravScale = 2000 end
		if not self.airControl then phys.gravScale = 500 end
	end
	
	--friction
	--todo: maybe turn off friction if player's moving in same direction as input
	if phys.onGround then
		if phys.vx > 0 then phys.vx = phys.vx - (600*dt)
		else if phys.vx < 0 then phys.vx = phys.vx + (600*dt) end end
		if phys.vx > -(600*dt) and phys.vx < (600*dt) then phys.vx = 0 end
	end
	
	--debug
	--if keyDown("e") then self.phys.col = false else self.phys.col = true end
	
end

function platformerController:jump()
	if self.phys.onGround then self.phys.vy = -self.jumpForce end
end

function platformerController:sideHit(args)
	if args.side == "up" then
		self.airControl = true
	end
end

function platformerController:collisionDetected(col)
	if col.other.parent.id == "pounder" and col.side == "in" then
		self.phys.vx = self.phys.vx/2
		self.phys.vy = self.phys.vy/2
	end
	if col.other.parent:getComponent("gelTile") ~= nil then
		self.vy = -self.jumpForce
	end
end