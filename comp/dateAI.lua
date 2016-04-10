dateAI = class("dateAI", component)

function dateAI:initialize(args)
  component.initialize(self, args)
  self.type = "dateAI"
  self.target = args.target
  self.phys = self.parent:getComponent("physics")
	self.shotTimer = 0.05
	self.friendly = false
	self.actions = {["shoot"]=2.2, ["jump"]=1, ["swap"]=1}
	self.currentAction = lume.weightedchoice(self.actions)
	self.actionTimer = 2
	
	self.side = 1
	
	self.hp = 5
	
	self.active = false
	self.shooting = false
	
	self.dodging = false
	self.undodgeTimer = 0
	
	self[self.currentAction](self, true)
	
end

function dateAI:update(dt)
	if self.active then
		self[self.currentAction](self)
		self.actionTimer = self.actionTimer - dt
		if self.actionTimer <= 0 then
			if self.phys.vx < 0 then self.side = 0 else self.side = 1 end
			self.currentAction = lume.weightedchoice(self.actions)
			if self.nextAction ~= nil then
				self.currentAction = self.nextAction
				self.nextAction = nil
			end
			self[self.currentAction](self, true)
		end
	end
	
	self.undodgeTimer = self.undodgeTimer - dt
	if self.undodgeTimer <= 0 then
		self.dodging = false
	end
	
	local r = 200; local g = 50; local b = 200
	if self.dodging and not self.shooting then
		r = 80; g = 40; b = 80
	end
	if self.shooting and not self.dodging then
		r = 200; g = 50; b = 100
	end
	if self.shooting and self.dodging then
		r = 80; g = 40; b = 40
	end
	local rect = self.parent:getComponent("rectangle")
	rect.r = rect.r - (rect.r-r)*20*dt
	rect.g = rect.g - (rect.g-g)*20*dt
	rect.b = rect.b - (rect.b-b)*20*dt
	
	if self.dodging then
		self.phys.inBackground = true
		local rect = self.parent:getComponent("rectangle")
		rect.drawLayer = "background"
	else
		self.phys.inBackground = false
		local rect = self.parent:getComponent("rectangle")
		rect.drawLayer = "default"
	end
	
	self.phys:addVel(-(self.phys.vx)*3*dt, 0)
end

function dateAI:activate()
	self.active = true
end

function dateAI:shoot(start)
	local rect = self.parent:getComponent("rectangle")
	if start then
		self.actionTimer = 1.5
	else
		if self:targetVisible() then
			self.shotTimer = self.shotTimer - dt
			if self.actionTimer > 0.9 and self.actionTimer < 1.2 then
				self.shooting = true
			end
			if self.shotTimer <= 0 and self.actionTimer < 0.9 and self.actionTimer > 0.4 then
				self.shooting = true
				self.shotTimer = 0.05
				self:shootPlayer()
			end
			if self.actionTimer < 0.4 then
				self.shooting = false
			end
		end
	end
end

function dateAI:jump(start)
	if start then
		self.actionTimer = 2
		self.phys.vy = -300
		self.phys.y = self.phys.y - 4
	else
		self.shotTimer = self.shotTimer - dt
		if self.actionTimer > 1 and self.actionTimer < 1.3 then
			self.shooting = true
		end
		if self.actionTimer < 1 and self.actionTimer > 0.5 and self.shotTimer <= 0 then
			self.shotTimer = 0.05
			self:shootPlayer()
			self.shooting = true
		end
		if self.actionTimer < 0.5 then
			self.shooting = false
		end
	end
end

function dateAI:swap(start)
	if start then
		self.actionTimer = 3
	else
		if self.actionTimer > 2.2 then
			if self.side == 1 then
				self.phys:addVel(-(self.phys.vx+1000)*3*dt, 0)
			else
				self.phys:addVel(-(self.phys.vx-1000)*3*dt, 0)
			end
		end
	end
end

function dateAI:dodge(start)
	if start then
		self.actionTimer = math.random()*2+1.5
		self.dodgeTimer = self.actionTimer - 0.8
		self.dodging = true
	else
	
	self.dodgeTimer = self.dodgeTimer - dt
	if self.dodgeTimer <= 0 then
		self.dodging = false
	end
	end
end

function dateAI:shootPlayer()
	local ang = angle:new(self.target.x-self.phys.x, self.target.y-self.phys.y)
	ang:addTheta(math.random()*0.2-0.1)
	self.parent.game:addEnt(bullet, {x=self.phys.x+self.phys.w/2, y=self.phys.y+self.phys.h/2-10, vx=ang.xPart, vy=ang.yPart, friendly=false})
	self.parent.game.camMan.screenshake = 0.2
  audioManager:playAudio("gunShot")
end

function dateAI:targetVisible()
  if (math.abs(self.phys.x - self.target.x) < 5000) then
    return true
  end
end

function dateAI:distToPlayer()
	return math.abs(self.phys.x - self.target.x)
end

function dateAI:collisionDetected(col)
	local phys = self.parent:getComponent("physics")
	if col.other.parent.id == "bullet" then
		if col.other.parent.friendly ~= self.friendly and col.other.inBackground == phys.inBackground then
			self.hp = self.hp - 1
			self.dodging = true
			self.undodgeTimer = 8
			col.other.parent.die = true
			audioManager:playAudio("bodyShotImpact")
			
			if self.hp <= 0 then
				self.parent.die = true
				local phys = col.other.parent:getComponent("physics")
				local dir = 1
				if phys.vx < 0 then dir = -1 end
				
				phys = self.parent:getComponent("physics")
				local r = 100; local g = 50; local b = 50
				if self.friendly then r = 50; g = 50; b = 100 end
				local corpse = self.parent.game:addEnt(corpse, {x=phys.x-phys.w/2, y=phys.y+10, r=r, g=g, b=b})
				corpse:getComponent("physics"):addVel(250*dir, -50)
			end
		end
	end
end


    