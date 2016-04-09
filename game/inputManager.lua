inputManager = class("inputManager")

function inputManager:initialize(parent)
	self.game = parent
	
	self.bind = {
		z = "jump", up = "dodge", w = "jump", space = "jump",
		left = "left", a = "left",
		right = "right", d = "right",
		x = "shoot",
		down = "duck"
	}
	
	self.bind["3"] = "jump"
	
	self.map = {
		jump = self.jump,
		shoot = self.shoot
	}
	
end

function inputManager:update(dt)
end

function inputManager:keypressed(key)
	if self.map[self.bind[key]] ~= nil then
		self.map[self.bind[key]](self)
	end
end

function inputManager:joystickpressed(button)
	if self.map[self.bind["" .. button]] ~= nil then
		self.map[self.bind["" .. button]](self)
	end
	debug(button)
end

function inputManager:joystickaxis(axis, value)
	
end

function inputManager:jump()
	local player = self.game.player
	local controller = player:getComponent("platformerController")
	if controller ~= nil then controller:jump() end
end

function inputManager:shoot()
	local player = self.game.player
	local controller = player:getComponent("platformerController")
	if controller ~= nil then controller:shoot() end
end

--returns true if any of the keys for a particular bind are pressed.
function inputManager:keyDown(bind)
	for key, b in pairs(self.bind) do
		if bind == b then
			if keyDown(key) then return true end
		end
	end
	local joysticks = love.joystick.getJoysticks()
	for i, joy in ipairs(joysticks) do
		--if joy:isDown(3) then crash() end
		for key, b in pairs(self.bind) do
			if bind == b and tonumber(key) ~= nil then
				if joy:isDown(tonumber(key)) then return true end
			end
		end
	end
	return false
end