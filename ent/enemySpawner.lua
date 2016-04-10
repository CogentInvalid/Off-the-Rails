enemySpawner = class("enemySpawner", gameObject)

function enemySpawner:initialize(args)
	gameObject.initialize(self, args)
	self.name = "enemySpawner"
	
	local x = -100
	if args.side == 1 then x = 850 end --TODO adjust
	self.phys = physics:new({parent=self, x=x, y=150, w=1, h=1, col=false})
	
	self.shootSoon = args.shootSoon
	
	self:addComponent(self.phys)
	
	self.delay = args.delay
end

function enemySpawner:update(dt)
	gameObject.update(self, dt)
	if self.active then
		self.delay = self.delay - dt
		if self.delay < 0 then
			local enemy = self.game:addEnt(enemy, {x=self.phys.x, y=self.phys.y})
			enemy:getComponent("Ai").active = true
			enemy:getComponent("Ai").currentAction = "walkForward"
			if self.shootSoon then enemy:getComponent("Ai").nextAction = "shoot" end
			enemy:getComponent("Ai").actionTimer = 0.8
			self.die = true
		end
	end
end

function enemySpawner:notifyComponents(func, args)
	gameObject.notifyComponents(self, func, args)
	if func == "activate" then
		self.active = true
	end
end