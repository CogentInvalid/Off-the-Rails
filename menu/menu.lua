local menu = {}

function menu:init()
	
end

function menu:enter()
	love.graphics.setBackgroundColor(0,0,20)
end

function menu:update(dt)
end

function menu:draw()
	love.graphics.setColor(255,255,255)
	local w = love.graphics.getFont():getWidth("THIS IS SOME SORTA MENU SCREEN")
	love.graphics.print("THIS IS SOME SORTA MENU SCREEN", love.graphics.getWidth()/2-w/2, 350)
end

function menu:keypressed(key)
	if key=="return" then
		gamestate.switch(gameMode.game)
	end
end

function menu:mousepressed() --todo add button

end

return menu