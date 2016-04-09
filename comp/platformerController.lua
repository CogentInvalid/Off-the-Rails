platformerController = class("platformerController", component)

function platformerController:initialize(args)
	component.initialize(self, args)
	self.type = "platformerController"
	
	self.speed = args.speed or 200
	
	self.jumpForce = args.jumpForce or 300
	
	self.dir = 1 --facing left or right
	
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
	
	if input:keyDown("left") then
		phys:addVel(-(phys.vx+self.speed)*5*dt, 0)
		self.dir = -1
	elseif input:keyDown("right") then
		phys:addVel(-(phys.vx-self.speed)*5*dt, 0)
		self.dir = 1
	else
		phys:addVel(-phys.vx*5*dt, 0)
	end

	--jumping/falling
	if phys.vy > 0 then
		phys.gravScale = 500
	else
		if input:keyDown("jump") then phys.gravScale = 500
		else phys.gravScale = 2000 end
		if not self.airControl then phys.gravScale = 500 end
	end
	
end

function platformerController:jump()
	if self.phys.onGround then self.phys.vy = -self.jumpForce end
end

function platformerController:shoot()
	self.parent.game:addEnt(bullet, {x=self.phys.x+self.phys.w/2, y=self.phys.y+self.phys.h/2, dir=self.dir})
end

function platformerController:sideHit(args)
	if args.side == "up" then
		self.airControl = true
	end
end

function platformerController:collisionDetected(col)
end