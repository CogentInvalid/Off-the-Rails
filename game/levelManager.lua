levelManager = class("levelManager")

function levelManager:initialize(parent)
	self.parent = parent
	
	self.width = 0
end

function levelManager:startLevel()
	self:loadTrainCar()
end

function levelManager:loadTrainCar()
	self.parent:addEnt(wall, {x=self.width, y=250, w=800, h=20}) --floor
	self.parent:addEnt(wall, {x=self.width, y=-100, w=800, h=20}) --ceiling
	self.parent:addEnt(wall, {x=self.width, y=-100, w=20, h=200}) --left wall
	self.parent:addEnt(wall, {x=self.width+780, y=-100, w=20, h=200}) --right wall
	
	for i=0, 9 do
		self.parent:addEnt(wall, {x=self.width+800+i*10+1, y=250, w=8, h=10}) --floor
	end
	
	self.parent:addEnt(enemy, {x=self.width+400, y=150}) --an enemy
	self.width = self.width + 750 + 150
end

function levelManager:update(dt)
	local player = self.parent.player:getComponent("physics")
	
	if player.x > self.width-600 then
		self:loadTrainCar()
	end
end