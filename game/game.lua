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
require "ent/playerWall"
require "ent/enemy"
require "ent/bullet"
require "ent/instructions"
require "ent/weapon"
require "ent/corpse"
require "ent/trigger"
require "ent/enemySpawner"
require "ent/background"
require "ent/particle"
require "ent/box"
require "ent/date"

require "comp/image"
require "comp/rectangle"
require "comp/physics"
require "comp/topDownController"
require "comp/platformerController"
require "comp/text"
require "comp/person"
require "comp/AI"
require "comp/dateAI"
require "comp/cameraTrigger"
require "comp/trainCarTrigger"
require "comp/wallTrigger"
require "comp/destroyOffscreen"
require "comp/rotate"
require "comp/fadeOut"

local game = {}

function game:init()

	--timestep related stuff
	dt = 0.01
	accum = 0
	self.paused = false
	
	self.drawLayers = {"actualBackground", "background", "default", "player"}
  
	self.bg_sky_image = love.graphics.newImage("res/img/nightSky.jpg")
	self.bgX1 = 0
	self.bgY1 = -105
	self.bgX2 = 2560/2
	self.bgY2 = -105
  
  self.bg_ground_image = love.graphics.newImage("res/img/groundBackground.png")
	self.bggX1 = 0
	self.bggY1 = -730
	self.bggX2 = 2560
	self.bggY2 = -730
	
	self.duckImg = getImg("bananaduck")
	self.duckAlpha = 0

	--systems
	self.system = {}
	self.colMan = self:addSystem(collisionManager)
	self.camMan = self:addSystem(cameraManager)
	self.inputMan = self:addSystem(inputManager)
	self.levMan = self:addSystem(levelManager)

	--entities
  
  self.ent = {}
  
  self.player = self:addEnt(player, {x=-50, y=150}, true)
  
	self.trainCars = {}
  
  self.trainCars[1] = trainCar:new()
  self.trainCars[2] = trainCar:new()
  self.trainCars[3] = trainCar:new()
  self.trainCars[4] = trainCar:new()
  self.trainCars[5] = trainCar:new()
  self.trainCars[6] = trainCar:new()
  self.trainCars[7] = trainCar:new()
  self.trainCars[8] = trainCar:new()
  self.trainCars[9] = trainCar:new()
  self.trainCars[10] = trainCar:new()
  self.trainCars[11] = trainCar:new()
  self.trainCars[12] = trainCar:new()
  self.trainCars[13] = trainCar:new()
  self.trainCars[14] = trainCar:new()
  self.trainCars[15] = trainCar:new()
  self.trainCars[16] = trainCar:new()
  self.trainCars[17] = trainCar:new()
  
  
  self.trainCars[1].ents = {
    {class = instructions, args={x=100, y=-200, text="Your lovely date is waiting on you. Dinner will be served.\nEventually.\nUse the arrow keys to move yourself already"}},
	--{class = date, args = {x=610, y=150, w=500, h=50}}
  }
  
  self.trainCars[2].ents = {
    {class = instructions, args={x=100, y=-50, text="Pick up the weapon.\nYour date is counting on it."}},
    {class = weapon, args={x=300, y=210}}
  }
  
  self.trainCars[3].ents = {
    {class = instructions, args={x=100, y=-200, text="Kill it. Kill it.\nIt can't stand between you and your date.\nPress X to kill"}},
    {class = enemy, args = {x=600, y=150, w=500, h=50}}
  }
  
  self.trainCars[4].ents = {
    {class = instructions, args={x=100, y=-200, text="They are coming after you."}},
    {class = enemy, args = {x=600, y=150, w=500, h=50}},
  }
  
  self.trainCars[5].ents = {
    {class = instructions, args={x=100, y=-200, text="See I told you...\nPress and hold Arrow Up to dodge QUICKLY!", delay=1.2}},
	{class = enemySpawner, args={side=0, delay=1.2, shootSoon=true}}
  }
  
  self.trainCars[6].ents = {
    {class = instructions, args={x=100, y=-200, text="There are a few losers here.\nDeal with them."}},
    {class = enemy, args = {x=600, y=150, w=500, h=50}}, {class = enemy, args = {x=540, y=50, w=500, h=50}}, {class = enemy, args = {x=480, y=50, w=500, h=50}}
  }
  
  self.trainCars[7].ents = {
    {class = instructions, args={x=100, y=-200, text="Don't kill people.\nWhy would you?\nWhat would your lady think of you?"}},
    {class = enemy, args = {x=600, y=150, w=500, h=50}},
	{class = enemySpawner, args={side=0, delay=1.8}},
	{class = enemySpawner, args={side=1, delay=2.8}},
	{class = enemySpawner, args={side=0, delay=4}},
	{class = enemySpawner, args={side=1, delay=4}}
}


  self.trainCars[8].ents = {
    {class = instructions, args={x=100, y=-200, text="Who are they? Why are they attacking you?"}},
    {class = enemy, args = {x=600, y=150, w=500, h=50}},
	{class = enemySpawner, args={side=1, delay=1.8}},
	{class = enemySpawner, args={side=1, delay=2.8}}
}

  
  self.trainCars[9].ents = {
    {class = instructions, args={x=100, y=-200, text="People? What people?"}},
    {class = enemy, args = {x=600, y=150, w=500, h=50}},
    {class = enemySpawner, args={side=0, delay=1.8}},
    {class = enemySpawner, args={side=0, delay=3}},
    {class = enemySpawner, args={side=1, delay=3}},
    {class = enemySpawner, args={side=0, delay=4}},
    {class = enemySpawner, args={side=1, delay=4.5}}
  }
    
  self.trainCars[10].ents = {
		{class = instructions, args={x=100, y=-200, text="Where did they go??", delay=4}},
		{class = box, args={x=200, y=200}},  
		{class = enemySpawner, args={side=1, delay=1, fadeOut=true, fadeOutDelay=2}},
		{class = enemySpawner, args={side=1, delay=2, fadeOut=true, fadeOutDelay=1.5}},
		{class = enemySpawner, args={side=1, delay=3, fadeOut=true, fadeOutDelay=1}},
		{class = enemySpawner, args={side=1, delay=4, fadeOut=true, fadeOutDelay=0.5}}
  }
  
    self.trainCars[11].ents = {
		{class = instructions, args={x=100, y=-200, text="Come at me!", delay=1}},
		{class = enemy, args = {x=200, y=-300, w=500, h=50}},
		{class = enemy, args = {x=600, y=-300, w=500, h=50}},
		{class = enemySpawner, args={side=1, delay=1}},
		{class = enemySpawner, args={side=1, delay=2}},
		{class = enemySpawner, args={side=1, delay=3}},
		{class = enemySpawner, args={side=1, delay=4}}
  }
	self.trainCars[11].openCeiling = true
  
    self.trainCars[12].ents = {
    {class = instructions, args={x=100, y=-200, text="Oh yeah.", delay=1}},
    {class = box, args={x=200, y=200}},
    {class = box, args={x=250, y=200}},
    {class = box, args={x=300, y=200}},
    {class = box, args={x=250, y=150}},
    {class = box, args={x=300, y=150}},
    {class = box, args={x=300, y=100}},
    {class = box, args={x=300, y=100}},
		{class = enemySpawner, args={side=1, delay=1}},
		{class = enemySpawner, args={side=1, delay=2}},
		{class = enemySpawner, args={side=1, delay=3}}
  }

    self.trainCars[13].ents = {
    {class = instructions, args={x=100, y=-200, text="You are going to die.", delay=1}},
    {class = box, args={x=200, y=200}},
    {class = box, args={x=250, y=200}},
    {class = box, args={x=300, y=200}},
    {class = box, args={x=250, y=150}},
    {class = box, args={x=450, y=200}},
    {class = box, args={x=500, y=200}},
    {class = box, args={x=550, y=200}},
    {class = box, args={x=500, y=150}},
    {class = enemy, args = {x=400, y=150, w=500, h=50}},
		{class = enemySpawner, args={side=0, delay=3}},
    {class = enemySpawner, args={side=0, delay=5}},
		{class = enemySpawner, args={side=1, delay=2}},
		{class = enemySpawner, args={side=1, delay=4}}
  }
  
    self.trainCars[14].ents = {
    {class = instructions, args={x=100, y=-200, text="Food is getting cold. She is waiting.", delay=1}},
    {class = box, args={x=200, y=-68}},
    {class = box, args={x=200, y=-18}},
    {class = box, args={x=200, y=32}},
    {class = box, args={x=200, y=82}},
    {class = box, args={x=200, y=132}},
    {class = box, args={x=500, y=200}},
    {class = box, args={x=550, y=200}},
    {class = box, args={x=550, y=150}},
    {class = box, args={x=550, y=32}},
    {class = box, args={x=550, y=-18}},
    {class = box, args={x=550, y=-68}},
    {class = enemy, args = {x=400, y=150, w=500, h=50}},
		{class = enemySpawner, args={side=0, delay=3}},
		{class = enemySpawner, args={side=1, delay=2}},  
  }
  
    self.trainCars[15].ents = {
    {class = instructions, args={x=100, y=-200, text="Really? What are you doing?\nWhat are you thinking?\nWhy are you making up enemies?", delay=1}},
    {class = box, args={x=100, y=40}},
    {class = box, args={x=200, y=40}},
    {class = box, args={x=300, y=40}},
    {class = box, args={x=400, y=40}},
    {class = box, args={x=500, y=40}},
    {class = box, args={x=600, y=40}},
    {class = box, args={x=700, y=40}},
    {class = enemy, args = {x=100, y=-60, w=500, h=50}},
    {class = enemy, args = {x=200, y=-60, w=500, h=50}},
    {class = enemy, args = {x=300, y=-60, w=500, h=50}},
    {class = enemy, args = {x=400, y=-60, w=500, h=50}},
    {class = enemy, args = {x=500, y=-60, w=500, h=50}},
    {class = enemy, args = {x=600, y=-60, w=500, h=50}},
    {class = enemy, args = {x=700, y=-60, w=500, h=50}},
  }
  
    self.trainCars[16].ents = {
    {class = instructions, args={x=100, y=-200, text="What?", delay=3.5}},
    {class = enemySpawner, args={side=1, delay=1, fadeOut=true, fadeOutDelay=1}},
    {class = enemySpawner, args={side=1, delay=2, fadeOut=true, fadeOutDelay=1}},
    {class = enemySpawner, args={side=0, delay=1, fadeOut=true, fadeOutDelay=1}},
    {class = enemySpawner, args={side=0, delay=2, fadeOut=true, fadeOutDelay=1}},
    {class = enemy, args = {x=500, y=150, w=500, h=50, fadeOut=true, fadeOutDelay=2}},
    {class = enemy, args = {x=600, y=150, w=500, h=50, fadeOut=true, fadeOutDelay=2}},
    {class = enemy, args = {x=700, y=150, w=500, h=50, fadeOut=true, fadeOutDelay=2}},
  }
  
    self.trainCars[17].ents = {
    {class = instructions, args={x=100, y=-200, text="There she is!\n Your love!\n...Your FINAL love...", delay=1}},
    {class = background, args = {img="ChairsAndTable", x=200, y=60, sx=0.5, sy=0.5}},
    {class = date, args = {x=610, y=150, w=500, h=50}}
  }
  
	
	self.levMan:startLevel()
  
	--self:addEnt(weapon, {x=150, y=100})
	--self:addEnt(instructions, {x=100, y=-50, text="Hello world!"})
	
	self.camMan:setTarget(self.player:getComponent("physics"), 0, -150)
	self.camMan:setPos(self.player:getComponent("physics").x,self.player:getComponent("physics").y-150)
	self.camMan.lockY = true
	
	self.deathTimer = 2
	
	self.won = false
  
  audioManager:setAudio("train")

end

function game:enter()
	self:resize(love.graphics.getDimensions())
	self:init()
end

function game:reset()
end

function game:respawn()
	local currentCar = self.levMan.currentCar
	
	
	for i, entity in lume.ripairs(self.ent) do
		entity:notifyComponents("destroy")
	end
	self.ent = {}
	
	self.levMan = self:addSystem(levelManager)

	self.levMan.carIndex =  currentCar
	self.levMan.currentCar = currentCar
  
	self.player = self:addEnt(player, {x=50, y=150}, true)
	self.player:getComponent("platformerController").hasWeapon = true
	
	self.levMan:startLevel()
	
	self.camMan:setTarget(self.player:getComponent("physics"), 0, 0)
	self.camMan:setPos(400,0)
	
	self.deathTimer = 2
end

function game:update(delta)
	--timestep stuff
	if self.paused == false then accum = accum + delta end
	if accum > 0.05 then accum = 0.05 end
	while accum >= dt do
		
		self.bgX1 = self.bgX1 - 100*dt
		if self.bgX1 < -2560/2 then self.bgX1 = self.bgX1 + 2560 end
		self.bgX2 = self.bgX2 - 100*dt
		if self.bgX2 < -2560/2 then self.bgX2 = self.bgX2 + 2560 end
		
		self.bggX1 = self.bggX1 - 400*dt
		if self.bggX1 < -2560 then self.bggX1 = self.bggX1 + 2560*2 end
		self.bggX2 = self.bggX2 - 400*dt
		if self.bggX2 < -2560 then self.bggX2 = self.bggX2 + 2560*2 end

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
		
		if self.player.die == true then
			self.deathTimer = self.deathTimer - dt
			if self.deathTimer <= 0 then
				self:respawn()
			end
		end

		accum = accum - 0.01
	end
	if accum>0.1 then accum = 0 end
end

function game:draw()
  
  love.graphics.setColor(255,255,255)  

  love.graphics.draw(self.bg_sky_image, self.bgX1, self.bgY1, 0, 0.5, 0.5)
	love.graphics.draw(self.bg_sky_image, self.bgX2, self.bgY2, 0, 0.5, 0.5) 
  
  love.graphics.draw(self.bg_ground_image, self.bggX1, self.bggY1, 0)
	love.graphics.draw(self.bg_ground_image, self.bggX2, self.bggY2, 0) 
  
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
	
	if self.duck then
		self.duckAlpha = self.duckAlpha + 20*dt
		love.graphics.setColor(255,255,255,self.duckAlpha)
		love.graphics.draw(self.duckImg, -60, 150)
	end
	
	--detach camera
	self.camMan.cam:detach()
	
	--ui stuff goes here
	debugger:draw()

end

function game:keypressed(key)
	if not self.player.die then
		self.inputMan:keypressed(key)
	end
	if key == "q" then self:respawn() end
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
	if not permanent then
		if self.levMan.loadedCar ~= nil then
			self.levMan:addToCarX(self.levMan.loadedCar, entity)
		end
	end
	return entity
end

function game:resize(w, h)
	self.camMan:setDimensions(w,h)
end

return game