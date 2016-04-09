Ai = class("Ai", component)

function Ai:initialize(args)
  component.initialize(self, args)
  self.type = "Ai"
  self.target = args.target
  self.phys = self.parent:getComponent("physics")
	self.shootTimer = 2
	self.dir = 1
end

function Ai:update(dt)
	
	if self.phys.x < self.target.x then self.dir = 1 else self.dir = -1 end
	
	local rect = self.parent:getComponent("rectangle")
	if self:targetVisible() then
		rect.r = 255
		if self.shootTimer > 0 then
			self.shootTimer = self.shootTimer - dt
			if self.shootTimer <= 0 then
				self.shootTimer = 2
				self.parent.game:addEnt(bullet, {x=self.phys.x+self.phys.w/2, y=self.phys.y+self.phys.h/2, dir=self.dir, friendly=false})
				self.parent.game.camMan.screenshake = 0.2
			end
		end
	else
		rect.r = 255
		self.shootTimer = 2
	end
end

function Ai:targetVisible()
  if (math.abs(self.phys.x - self.target.x) < 500) then
    return true
  end
end


    