local menu = {}

function menu:init()
	self.duck = getImg("ducktective")
	audioManager:setAudio("main")
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
	if focus then
		local w = love.graphics.getFont():getWidth("Off the Rails")
		love.graphics.print("Off the Rails", love.mouse.getX()+math.sin(self.ang*2)*200-w/2, love.mouse.getY()-40, 0)
		love.graphics.setFont(courierCodeBold)
		w = love.graphics.getFont():getWidth("Press Enter")
		love.graphics.print("Press Enter", love.mouse.getX()+math.sin(self.ang*2)*200-w/2, love.mouse.getY()+40, 0)
		love.graphics.setColor(255,255,255)
		love.graphics.draw(self.duck, love.mouse.getX()-20, love.mouse.getY()-800, 0, 0.2, 0.2)
	end
end

function menu:keypressed(key)
	if key=="return" then
		gamestate.switch(gameMode.game)
	end
end

function menu:mousepressed() --todo add button

end

return menu