require "game/collisionManager"
require "game/cameraManager"
require "game/inputManager"
require "game/levelManager"

--TODO: load all components/entities automatically
require "ent/gameObject"
require "comp/component"

require "ent/player"
require "ent/wall"
require "ent/enemy"
require "ent/bullet"
<<<<<<< Updated upstream
require "ent/instructions"
=======
require "ent/weapon"
>>>>>>> Stashed changes

require "comp/image"
require "comp/rectangle"
require "comp/physics"
require "comp/topDownController"
require "comp/platformerController"
require "comp/text"

local game = {}

function game:init()

	--timestep related stuff
	dt = 0.01
	accum = 0
	self.paused = false

	--systems
	self.system = {}
	self.colMan = self:addSystem(collisionManager)
	self.camMan = self:addSystem(cameraManager)
	self.inputMan = self:addSystem(inputManager)
	self.levMan = self:addSystem(levelManager)

	--entities
	self.ent = {}
<<<<<<< Updated upstream
	self.player = self:addEnt(player, {x=-100, y=100})
	
	self:addEnt(enemy, {x=100, y=0, w=500, h=50})
=======
	self.player = self:addEnt(player, {x=0, y=100})
  self:addEnt(weapon, {x=50, y=100})
>>>>>>> Stashed changes
	
	self:addEnt(wall, {x=-250, y=200, w=500, h=50})
	
	self:addEnt(instructions, {x=0, y=-100, text="Hello world!"})
	
	self.camMan:setTarget(self.player:getComponent("physics"), 0, 0)

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
				table.remove(self.ent, 1)
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
	for i, entity in ipairs(self.ent) do
		for j, comp in ipairs(entity.component) do
			comp:draw()
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
end

function game:mousepressed(button)
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

function game:addEnt(ent, args)
	args = args or {}
	args.game = self
	local entity = ent:new(args)
	self.ent[#self.ent+1] = entity
	return entity
end

function game:resize(w, h)
	self.camMan:setDimensions(w,h)
end

return game