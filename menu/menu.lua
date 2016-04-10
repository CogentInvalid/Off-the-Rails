local menu = {}

function menu:init()
	
end

function menu:enter()
	love.graphics.setBackgroundColor(0,0,20)
	self.ang = 0
end

function menu:update(dt)
	self.ang = self.ang + love.mouse.getY()*0.01*dt
end

function menu:draw()
	love.graphics.setFont(courierCodeBoldBig)
	love.graphics.setColor(0,115,255)
	local w = love.graphics.getFont():getWidth("Off the Rails")
	love.graphics.print("Off the Rails", love.mouse.getX()+math.sin(self.ang*2)*200-w/2, love.mouse.getY()-40, 0)
	love.graphics.setFont(courierCodeBold)
end

function menu:keypressed(key)
	if key=="return" then
		gamestate.switch(gameMode.game)
	end
end

function menu:mousepressed() --todo add button

end

return menu