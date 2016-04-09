levelManager = class("levelManager")

function levelManager:initialize(parent)
	self.parent = parent
	
	self.width = 0
	
	self.cars = {}
	self.currentCar = 1
	self.lastCar = 1
	self.carIndex = 1
end

function levelManager:startLevel()
	self:loadTrainCar()
  
end

function levelManager:loadTrainCar()
	self.lastCar = #self.cars+1
	self.cars[self.lastCar] = {}
	
	self:addToCar(self.lastCar, self.parent:addEnt(wall, {x=self.width, y=250, w=800, h=20}, true)) --floor
	self:addToCar(self.lastCar, self.parent:addEnt(wall, {x=self.width, y=250, w=800, h=20}, true)) --floor
	self:addToCar(self.lastCar, self.parent:addEnt(wall, {x=self.width, y=-100, w=800, h=20}, true)) --ceiling
	self:addToCar(self.lastCar, self.parent:addEnt(wall, {x=self.width, y=-100, w=20, h=200}, true)) --left wall
	self:addToCar(self.lastCar, self.parent:addEnt(wall, {x=self.width+780, y=-100, w=20, h=200}, true)) --right wall
	
	local camTrigger = self.parent:addEnt(trigger, {x=self.width, y=50, w=200, h=200}, true) --trigger
	self:addToCar(self.lastCar, camTrigger)
	camTrigger:addComponent(cameraTrigger:new({parent=camTrigger, camx=self.width+400, camy=0}))
	if #self.cars > 1 then
		camTrigger:addComponent(trainCarTrigger:new({parent=camTrigger}))
	end
	
	for i=0, 9 do
		self:addToCar(self.lastCar, self.parent:addEnt(wall, {x=self.width+800+i*10+1, y=250, w=8, h=10}, true)) --floor
	end
	
	local trainCar = self.parent.trainCars[self.carIndex]
	for i, entity in ipairs(trainCar.ents) do
		local ent = self.parent:addEnt(entity.class, entity.args, true)
		ent:notifyComponents("offset", {x=self.width, y=0})
		self:addToCar(self.lastCar, ent)
	end
	
	--self:addToCar(car, self.parent:addEnt(enemy, {x=self.width+400, y=150}, true)) --an enemy
	self.width = self.width + 750 + 150
end

function levelManager:addToCar(i, ent)
	table.insert(self.cars[i], ent)
end

function levelManager:removeFirstCar()
	local car = self.cars[1]
	if car ~= nil then
		for i, entity in ipairs(car) do
			entity.die = true
		end
		table.remove(self.cars, 1)
		self.lastCar = self.lastCar - 1
		self.currentCar = self.currentCar - 1
	end
end

function levelManager:update(dt)
	local player = self.parent.player:getComponent("physics")
	
	if self.lastCar == 3 and player.x > self.width-1000 then
		self:removeFirstCar()
	end
	if player.x > self.width-1000 then
		self:loadTrainCar()
	end
end

function levelManager:enterNextCar()
	self.currentCar = self.currentCar + 1
end