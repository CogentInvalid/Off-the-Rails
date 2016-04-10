dateAI = class("dateAI", component)

function dateAI:initialize(args)
  component.initialize(self, args)
  self.type = "dateAI"
  self.target = args.target
  self.phys = self.parent:getComponent("physics")
	self.shotTimer = 0.05
	
	self.actions = {["shoot"]=2.2, ["jump"]=1, ["swap"]=1}
	self.currentAction = lume.weightedchoice(self.actions)
	self.actionTimer = 2
	
	self.side = 1
	
	self.active = false
	self.dodging = false
	
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
	if not self.dodging then
		self.phys.inBackground = false
		local rect = self.parent:getComponent("rectangle")
		local fadeSpeed = 20
		rect.r = rect.r - (rect.r - 200)*fadeSpeed*dt
		rect.g = rect.g - (rect.g - 50)*fadeSpeed*dt
		rect.b = rect.b - (rect.b - 200)*fadeSpeed*dt
		rect.drawLayer = "default"
	end
	self.phys:addVel(-(self.phys.vx)*3*dt, 0)
end

function dateAI:activate()
	self.active = true
end

function dateAI:shoot(start)
	if start then self.actionTimer = 1.5 else
	if self:targetVisible() then
		self.shotTimer = self.shotTimer - dt
		if self.shotTimer <= 0 and self.actionTimer < 0.9 and self.actionTimer > 0.4 then
			local rect = self.parent:getComponent("rectangle")
			rect.g = 50; rect.b = 200
			self.shotTimer = 0.05
			self:shootPlayer()
		end
	end
	end
end

function dateAI:jump(start)
	if start then
		self.actionTimer = 2
		self.phys.vy = -300
	else
		self.shotTimer = self.shotTimer - dt
		if self.actionTimer < 1 and self.actionTimer > 0.5 and self.shotTimer <= 0 then
			self.shotTimer = 0.05
			self:shootPlayer()
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
	
	if self.dodging then
		self.phys.inBackground = true
		local rect = self.parent:getComponent("rectangle")
		local fadeSpeed = 20
		rect.r = rect.r - (rect.r - 80)*fadeSpeed*dt
		rect.g = rect.g - (rect.g - 40)*fadeSpeed*dt
		rect.b = rect.b - (rect.b - 40)*fadeSpeed*dt
		rect.drawLayer = "background"
	end
	
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


    