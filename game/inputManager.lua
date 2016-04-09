inputManager = class("inputManager")

function inputManager:initialize(parent)
	self.game = parent
	
	self.bind = {
		z = "jump", up = "jump", w = "jump", space = "jump",
		left = "left", a = "left",
		right = "right", d = "right"
	}
	
	self.map = {
		jump = self.jump
	}
	
end

function inputManager:update(dt)
end

function inputManager:keypressed(key)
	if self.map[self.bind[key]] ~= nil then
		self.map[self.bind[key]](self)
	end
end

function inputManager:debuggy()
	debug("HEY BROSE")
end

function inputManager:jump()
	local player = self.game.player
	local controller = player:getComponent("platformerController")
	if controller ~= nil then controller:jump() end
end

--returns true if any of the keys for a particular bind are pressed.
function inputManager:keyDown(bind)
	for key, b in pairs(self.bind) do
		if bind == b then
			if keyDown(key) then return true end
		end
	end
	return false
end