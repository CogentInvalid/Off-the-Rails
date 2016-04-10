levelManager = class("levelManager")

function levelManager:initialize(parent)
	self.parent = parent
	
	self.rightSide = 0
	
	self.cars = {}
	self.carIndex = 1 --next trainCar to load
	self.currentCar = 1 --trainCar that player's in
end

function levelManager:update()
end

function levelManager:startLevel()
	self:loadTrainCar()
end

function levelManager:loadTrainCar()
	local i = #self.cars+1
	self.cars[i] = {}
	
	local trainCar = self.parent.trainCars[self.carIndex]
	
	--background
	self:addToCar(i, self.parent:addEnt(background, {x=self.rightSide-122, y=-330, img="trainCar", sx=0.41, sy=0.5}, true))
	self:addToCar(i, self.parent:addEnt(background, {x=self.rightSide-122, y=220, img="trainChain", sx=0.2, sy=0.2}, true))
	
	--wheels
	local wheel = self.parent:addEnt(background, {x=self.rightSide, y=250, img="trainCarWheels", sx=0.1, sy=0.1, ox=500, oy=500, offx=50, offy=50}, true)
	wheel:addComponent(rotate:new({parent=wheel, speed=0.1}))
	self:addToCar(i, wheel)
	wheel = self.parent:addEnt(background, {x=self.rightSide+100, y=250, img="trainCarWheels", sx=0.1, sy=0.1, ox=500, oy=500, offx=50, offy=50}, true)
	wheel:addComponent(rotate:new({parent=wheel, speed=0.1}))
	self:addToCar(i, wheel)
	
	wheel = self.parent:addEnt(background, {x=self.rightSide+600, y=250, img="trainCarWheels", sx=0.1, sy=0.1, ox=500, oy=500, offx=50, offy=50}, true)
	wheel:addComponent(rotate:new({parent=wheel, speed=0.1}))
	self:addToCar(i, wheel)
	wheel = self.parent:addEnt(background, {x=self.rightSide+600+100, y=250, img="trainCarWheels", sx=0.1, sy=0.1, ox=500, oy=500, offx=50, offy=50}, true)
	wheel:addComponent(rotate:new({parent=wheel, speed=0.1}))
	self:addToCar(i, wheel)
	
	
	--load walls into self.cars[i]
	self:addToCar(i, self.parent:addEnt(wall, {x=self.rightSide, y=250, w=800, h=20}, true)) --floor
	self:addToCar(i, self.parent:addEnt(wall, {x=self.rightSide, y=250, w=800, h=20}, true)) --floor
	
	if not trainCar.openCeiling then
		self:addToCar(i, self.parent:addEnt(wall, {x=self.rightSide, y=-100, w=800, h=20}, true)) --ceiling
	end
	
	self:addToCar(i, self.parent:addEnt(wall, {x=self.rightSide, y=-100, w=20, h=200}, true)) --left wall
	self:addToCar(i, self.parent:addEnt(wall, {x=self.rightSide+780, y=-100, w=20, h=200}, true)) --right wall
	
	for x=0, 9 do
		self:addToCar(i, self.parent:addEnt(wall, {x=self.rightSide+800+x*10+1, y=250, w=8, h=10}, true)) --floor
	end
	
	for x=0, 9 do
		self:addToCar(i, self.parent:addEnt(wall, {x=self.rightSide-100+x*10+1, y=250, w=8, h=10}, true)) --floor
	end
	
	--load trigger
	local camTrigger = self.parent:addEnt(trigger, {x=self.rightSide, y=50, w=200, h=200}, true) --trigger
	self:addToCar(i, camTrigger)
	camTrigger:addComponent(cameraTrigger:new({parent=camTrigger, camx=self.rightSide+400, camy=0}))
	camTrigger:addComponent(trainCarTrigger:new({parent=camTrigger, car=self.cars[i], index = self.carIndex}))
	
	--wall trigger
	local wTrigger = self.parent:addEnt(trigger, {x=self.rightSide+70, y=50, w=200, h=200}, true) --trigger
	self:addToCar(i, wTrigger)
	wTrigger:addComponent(wallTrigger:new({parent=wTrigger, x=self.rightSide, y=0}))
	
	--load trainCar
	for q, entity in ipairs(trainCar.ents) do
		local ent = self.parent:addEnt(entity.class, entity.args, true)
		ent:notifyComponents("offset", {x=self.rightSide, y=0})
		self:addToCar(i, ent)
	end
	
	self.rightSide = self.rightSide + 750 + 150
	if self.parent.trainCars[self.carIndex+1] ~= nil then self.carIndex = self.carIndex + 1 end
end

function levelManager:addToCar(i, ent)
	table.insert(self.cars[i], ent)
end

function levelManager:addToCarX(t, ent)
	table.insert(t, ent)
end

function levelManager:removeFirstCar()
	local car = self.cars[1]
	if car ~= nil then
		for i, entity in ipairs(car) do
			entity.die = true
		end
		table.remove(self.cars, 1)
	end
end

function levelManager:enterCar(car, index)
	self.currentCar = index
	self.loadedCar = car
	self:loadTrainCar()
	for i, entity in ipairs(car) do
		entity:notifyComponents("activate")
	end
	if #self.cars > 3 then
		self:removeFirstCar()
	end
end