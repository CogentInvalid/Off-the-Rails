Ai = class("Ai", component)

function Ai:initialize(args)
  component.initialize(self, args)
  self.type = "Ai"
  self.target = args.target
  self.phys = self.parent:getComponent("physics")
	self.shootTimer = 1
	
	self.actions = {["walkForward"]=1, ["shoot"]=2, ["dodge"]=1}
	self.currentAction = "shoot"
	self.actionTimer = 2
	
	self.active = false
	
end

function Ai:update(dt)
	if self.active then
		self[self.currentAction](self)
		self.actionTimer = self.actionTimer - dt
		if self.actionTimer <= 0 then
			self.currentAction = lume.weightedchoice(self.actions)
			self[self.currentAction](self, true)
		end
	end
	self.phys:addVel(-(self.phys.vx)*3*dt, 0)
end

function Ai:activate()
	self.active = true
end

function Ai:shoot(start)
	if start then self.actionTimer = 2 end
	if self:targetVisible() then
		self.shootTimer = self.shootTimer - dt
		if self.shootTimer <= 0 then
			self.shootTimer = 1
			self:shootPlayer()
		end
	end
end

function Ai:walkForward(start)
	if start then self.actionTimer = math.random()+1.5 end
	if self:targetVisible() and self:distToPlayer() > 150 then
		local dir = 1
		if self.phys.x > self.target.x then dir = -1 end
		self.phys:addVel(-(self.phys.vx-(150*dir))*5*dt, 0)
	end
end

function Ai:dodge(start)
	if start then self.actionTimer = 2 end
end

function Ai:shootPlayer()
	local ang = angle:new(self.target.x-self.phys.x, self.target.y-self.phys.y)
	self.parent.game:addEnt(bullet, {x=self.phys.x+self.phys.w/2, y=self.phys.y+self.phys.h/2, vx=ang.xPart, vy=ang.yPart, friendly=false})
	self.parent.game.camMan.screenshake = 0.2
end

function Ai:targetVisible()
  if (math.abs(self.phys.x - self.target.x) < 5000) then
    return true
  end
end

function Ai:distToPlayer()
	return math.abs(self.phys.x - self.target.x)
end


    