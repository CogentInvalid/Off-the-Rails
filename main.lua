--libraries
class = require "libs/middleclass"
require "libs/misc"
angle = require "libs/angle"
inspect = require "libs/inspect"
lume = require "libs/lume"
gamestate = require "libs/hump/gamestate"

--ehhhhh
require "imgManager"
require "audio"

--gamestates
gameMode = {}
gameMode.menu = require "menu/menu"
gameMode.game = require "game/game"
gameMode.win = require "menu/win"

--other things
require "debugger"

function love.load()
	
	focus = true
	
	--setup ZeroBrane IDE debugger
	if arg[#arg] == "-debug" then require("mobdebug").start() end
	
	love.graphics.setDefaultFilter("linear", "linear")

	math.randomseed(os.time())
  
  audioManager = audio:new()
	
	--TODO remove
	courierCodeBold = love.graphics.newFont("courier.ttf", 20)
	courierCodeBoldBig = love.graphics.newFont("courier.ttf", 60)
	love.graphics.setFont(courierCodeBold)

	imgMan = imgManager:new() --tood: mayb remvov, replace to with cargo or love-loader

	debugger = debugger:new() --tood: totlaly remvov

	gamestate.registerEvents()
	gamestate.switch(gameMode.menu)

end

function love.update(dt)

	debugger:update(dt)

end

function love.draw()

	debugger:draw()

end

function love.keypressed(key)
	--if key == "q" then debug("lol!!!!! u got flummoxed!!", 4, true) end
	if key == "escape" then love.event.quit() end
end

function debug(msg, dur, cat)
	dur = dur or 5
	if cat then debugger:cat(msg, dur)
	else debugger:print(msg, dur) end
end

function getImg(name)
	return imgMan:getImage(name)
end