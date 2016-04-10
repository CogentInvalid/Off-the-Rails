local win = {}

function win:init()
	img1 = getImg("cutscene1")
	img2 = getImg("cutscene1")
	
	self.currentImg = img1
	
	self.sx = 1.8; self.sy = 1.8
end

function win:enter()
	audioManager:clearAudio()
	audioManager:playAudio("perfectPerfectEnding")
end

function win:update(dt)
	self.sx = self.sx - 0.02*dt
	self.sy = self.sy - 0.02*dt
	
	if self.sx <= 1 then
		self.sx = 1.8; self.sy = 1.8
		if self.currentImg == img1 then self.currentImg = img2 end
	end
end

function win:draw()
	love.graphics.setColor(255,255,255)
	love.graphics.draw(self.currentImg, 1024/2, 768/2, 0, self.sx, self.sy, 1024/2, 768/2)
end

return win