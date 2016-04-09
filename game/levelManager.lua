levelManager = class("levelManager")

function levelManager:initialize(parent)
	self.parent = parent
	
	self.width = 250
end

function levelManager:startLevel()
	self.parent:addEnt(wall, {x=-250, y=250, w=500, h=50})
end

function levelManager:update(dt)
	local player = self.parent.player:getComponent("physics")
	
	if player.x > self.width-200 then
		self.parent:addEnt(wall, {x=self.width+50, y=250, w=500, h=50})
		self.width = self.width + 550
	end
end