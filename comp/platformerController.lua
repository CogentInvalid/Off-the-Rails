platformerController = class("platformerController", component)

function platformerController:initialize(args)
	component.initialize(self, args)
	self.type = "platformerController"
	
	self.speed = args.speed or 200
	
	self.jumpForce = args.jumpForce or 300
	
	self.dir = 1 --facing left or right
	self.ducking = false
	
	self.dodgeTimer = 0.5
	self.dodgeCooldown = 0.8
	self.canDodge = true
	
	self.shootCooldown = 0
	
	self.phys = self.parent:getComponent("physics")
end

function platformerController:update(dt)
	if not self.phys then self.phys = self.parent:getComponent("physics") end
	if self.phys == nil then crash("platformerController error: No physics component found") end
	
	--movement
	local phys = self.phys
	local input = self.game.inputMan

	--x-movement
	local speed = self.speed
	if self.ducking then speed = speed / 4 end
	
	if input:keyDown("left") then
		phys:addVel(-(phys.vx+speed)*5*dt, 0)
		self.dir = -1
	elseif input:keyDown("right") then
		phys:addVel(-(phys.vx-speed)*5*dt, 0)
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
	
	--ducking
	if input:keyDown("duck") and not self.ducking then
		self.ducking = true
		phys:setDimensions(phys.w, 60)
		phys:addPos(0, 40)
		local rect = self.parent:getComponent("rectangle")
		rect.w = phys.w; rect.h = phys.h
	end
	if (not input:keyDown("duck")) and self.ducking then
		self.ducking = false
		phys:setDimensions(phys.w, 100)
		phys:addPos(0, -phys.h/2)
		local rect = self.parent:getComponent("rectangle")
		rect.w = phys.w; rect.h = phys.h
	end
	
	--dodging
	local fadeSpeed = 20
	if input:keyDown("dodge") and self.canDodge then
		phys.inBackground = true
		local rect = self.parent:getComponent("rectangle")
		rect.r = rect.r - (rect.r - 40)*fadeSpeed*dt
		rect.g = rect.g - (rect.g - 40)*fadeSpeed*dt
		rect.b = rect.b - (rect.b - 80)*fadeSpeed*dt
		rect.drawLayer = "background"
		self.dodgeTimer = self.dodgeTimer - dt
		if self.dodgeTimer < 0 then
			self.canDodge = false
		end
	else
		phys.inBackground = false
		local rect = self.parent:getComponent("rectangle")
		rect.r = rect.r - (rect.r - 100)*fadeSpeed*dt
		rect.g = rect.g - (rect.g - 100)*fadeSpeed*dt
		rect.b = rect.b - (rect.b - 200)*fadeSpeed*dt
		rect.drawLayer = "player"
		self.dodgeTimer = 0.8
	end
	
	if not self.canDodge then
		self.dodgeCooldown = self.dodgeCooldown - dt
		if self.dodgeCooldown <= 0 then
			self.canDodge = true
			self.dodgeCooldown = 0.5
		end
	end
	
	--shoot cooldown
	if self.shootCooldown > 0 then
		self.shootCooldown = self.shootCooldown - dt
	end
	
end

function platformerController:jump()
	if self.phys.onGround then self.phys.vy = -self.jumpForce end
end

function platformerController:shoot()
	if self.shootCooldown <= 0 then
		self.parent.game:addEnt(bullet, {x=self.phys.x+self.phys.w/2, y=self.phys.y+self.phys.h/2, vx=self.dir, friendly=true})
		self.parent.game.camMan.screenshake = 0.2
		self.shootCooldown = 1
	end
end

function platformerController:sideHit(args)
	if args.side == "up" then
		self.airControl = true
	end
end

function platformerController:collisionDetected(col)
	if col.other.parent.id == "trigger" then
		--col.other.parent:getComponentByName("trigger"):triggered()
		col.other.parent:notifyComponents("triggered")
	end
end