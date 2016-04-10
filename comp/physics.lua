--physics component: handles position, width, height, motion, and some collision stuff.

physics = class("physics", component)

function physics:initialize(args)
	component.initialize(self, args)
	self.type = "physics"
	
	self.collideOrder = {physics.isSolid, physics.isStatic}

	self.x = args.x; self.y = args.y
	self.px = self.x; self.py = self.y
	self.w = args.w; self.h = args.h

	self.vx = 0
	self.vy = 0
	
	self.gravity = args.gravity or false
	self.gravScale = args.gravScale or 300
	self.onGround = nil
	self.friction = args.friction
	
	self.solidity = args.solidity
	self.playerSolid = args.playerSolid
	self.inBackground = false

	self.col = args.col --does this collide with other objects?
	if args.col == nil then self.col = true end
	
	self.world = self.game.colMan:addToWorld(self) 
end

function physics:destroy()
	self.world:remove(self)
end

--UNFINISHED
function physics.isSolid(other)
	return other.solidity == "solid"
end

--ADDITIONAL UNFINISHED FUNCTION
function physics.isStatic(other)
	return other.solidity == "static"
end

function physics.thirdThing(other)
	return other.playerSolid
end

function physics:update(dt)
	
	self.px = self.x
	self.py = self.y
	
	self.x = self.x + self.vx*dt
	self.y = self.y + self.vy*dt
	
	if self.gravity then
		self.vy = self.vy + self.gravScale*dt
	end
	
	if self.friction and self.onGround then
		self:addVel(-self.vx*5*dt, 0)
	end
	
	self.onGround = false
end

function physics:hitSide(other, side)
	if side == "left" then
		self.x = other.x - self.w
		self.vx = 0
	end
	if side == "right" then
		self.x = other.x + other.w
		self.vx = 0
	end
	if side == "up" then
		self.y = other.y - self.h
		if self.gravity == true then self.onGround = true; self.vy = 0.001
		else self.vy = 0 end
	end
	if side == "down" then
		self.y = other.y + other.h
		self.vy = 0
	end
end

function physics:getPos()
	return self.x, self.y
end

function physics:setPos(x,y)
	self.x = x
	self.y = y
end

function physics:addPos(x,y)
	self.x = self.x + x
	self.y = self.y + y
end

function physics:offset(args)
	self.x = self.x + args.x
	self.y = self.y + args.y
end

function physics:setVel(x,y)
	self.vx = x
	self.vy = y
end

function physics:addVel(x,y)
	self.vx = self.vx + x
	self.vy = self.vy + y
end

function physics:setDimensions(w,h)
	self.w = w; self.h = h
end