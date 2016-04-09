require "game/collisionManager"
require "game/cameraManager"
require "game/inputManager"
require "game/levelManager"
require "game/trainCar"

--TODO: load all components/entities automatically
require "ent/gameObject"
require "comp/component"

require "ent/player"
require "ent/wall"
require "ent/enemy"
require "ent/bullet"
require "ent/instructions"
require "ent/weapon"
require "ent/corpse"
require "ent/trigger"

require "comp/image"
require "comp/rectangle"
require "comp/physics"
require "comp/topDownController"
require "comp/platformerController"
require "comp/text"
require "comp/person"
require "comp/AI"
require "comp/cameraTrigger"
require "comp/trainCarTrigger"

local game = {}

function game:init()

	--timestep related stuff
	dt = 0.01
	accum = 0
	self.paused = false
	
	self.drawLayers = {"background", "default", "player"}

	--systems
	self.system = {}
	self.colMan = self:addSystem(collisionManager)
	self.camMan = self:addSystem(cameraManager)
	self.inputMan = self:addSystem(inputManager)
	self.levMan = self:addSystem(levelManager)

	--entities
  
  self.ent = {}
  
  self.player = self:addEnt(player, {x=0, y=100}, true)
  
  self.car1 = trainCar:new()
  self.car2 = trainCar:new()
  
  
  self.car1.ents = {
    {class = instructions, args={x=100, y=-50, text="Your date is waiting on you. Dinner will be served. Eventually. Use the arrows keys to move yourself already"}}
    }
  
  self.car2.ents = {
    {class = instructions, args={x=100, y=-50, text="Pick up the weapon"}}
  }
	
	self.levMan:startLevel()
	
	self:addEnt(enemy, {x=200, y=0, w=500, h=50})
	self:addEnt(weapon, {x=150, y=100})
	self:addEnt(instructions, {x=100, y=-50, text="Hello world!"})
	
	self.camMan:setTarget(self.player:getComponent("physics"), 0, 0)
	--self.camMan.lockY = true
	self.camMan:setScale(2)
	self.camMan:setTargetScale(2)

end

function game:enter()
	self:resize(love.graphics.getDimensions())
end

function game:reset()
end

function game:update(delta)
	--timestep stuff
	if self.paused == false then accum = accum + delta end
	if accum > 0.05 then accum = 0.05 end
	while accum >= dt do

		--reverse iterate entities
		for i, entity in lume.ripairs(self.ent) do
			--update entity
			entity:update(dt)

			--if die then is kill
			if entity.die then
				entity:notifyComponents("destroy")
				table.remove(self.ent, i)
			end
		end

		--update systems
		for i, system in ipairs(self.system) do
			system:update(dt)
		end

		accum = accum - 0.01
	end
	if accum>0.1 then accum = 0 end
end

function game:draw()

	--attach camera
	self.camMan.cam:attach()

	--draw world
	for q, layer in ipairs(self.drawLayers) do
		for i, entity in ipairs(self.ent) do
			for j, comp in ipairs(entity.component) do
				if comp.drawLayer ~= nil then
					if comp.drawLayer == layer then
						comp:draw()
					end
				end
			end
		end
	end
	
	self.showHitboxes = false
	if self.showHitboxes then
		love.graphics.setColor(255,0,0,200)
		local cols, len = self.colMan.world:queryRect(-1000, -1000, 2000, 2000)
		for i, phys in ipairs(cols) do
			love.graphics.rectangle("fill", phys.x, phys.y, phys.w, phys.h)
		end
	end
	
	--detach camera
	self.camMan.cam:detach()
	
	--ui stuff goes here

end

function game:keypressed(key)
	self.inputMan:keypressed(key)
	if key == "q" then crash(inspect(self.player.die)) end
end

function game:mousepressed(button)
end

function game:joystickpressed(joystick, button)
	self.inputMan:joystickpressed(button)
end

function game:joystickaxis(joystick, axis, value)
	self.inputMan:joystickaxis(axis, value)
end

function game:addSystem(sys, args)
	args = args or {}
	sys = sys:new(self, args)
	self.system[#self.system+1] = sys
	return sys
end

--TODO: this
function game:getSystem(name)
	
end

function game:addEnt(ent, args, permanent)
	args = args or {}
	args.game = self
	local entity = ent:new(args)
	self.ent[#self.ent+1] = entity
	if not permanent then self.levMan:addToCar(self.levMan.currentCar, entity) end
	return entity
end

function game:resize(w, h)
	self.camMan:setDimensions(w,h)
end

return game