local camera = require "libs/hump/camera"

cameraManager = class("cameraManager")

function cameraManager:initialize(parent)
	self.cam = camera(0,0)
	self.target = nil
	
	self.x = self.cam.x; self.y = self.cam.y
	self.followSpeed = 3
	
	self.screenshake = 0
	
	self.lockY = false
	
	self.targetScale = 1
	self.cam.scale = self.targetScale
	self.scaleSpeed = 1
end

function cameraManager:update(dt)
	if self.target then
		self.x = self.x - (self.x - (self.target.x+self.targetOffset.x))*self.followSpeed*dt
		if not self.lockY then self.y = self.y - (self.y - (self.target.y+self.targetOffset.y))*self.followSpeed*dt end
	end
	
	if self.screenshake > 0 then
		self.screenshake = self.screenshake - dt
		self.x = self.x + (math.random()-0.5)*10000*self.screenshake*dt
		self.y = self.y + (math.random()-0.5)*10000*self.screenshake*dt
	end
	
	self.cam.scale = self.cam.scale - (self.cam.scale - self.targetScale)*self.scaleSpeed*dt
	
	self.cam:lookAt(self.x, self.y)
	
	--self.cam.scale = 0.4
end

function cameraManager:setTarget(target, ox, oy)
	self.target = target
	self.targetOffset = {x=ox or 0, y=oy or 0}
end

function cameraManager:setTargetPos(x, y, ox, oy)
	self.target = {x=x, y=y}
	self.targetOffset = {x=ox or 0, y=oy or 0}
end

function cameraManager:setPos(x, y)
	self.x = x; self.y = y
end

function cameraManager:setDimensions(w, h)
	local x = (w+h)/2
	--self:setScale(x/896)
	self:setScale(1)
	--debug(self.cam.scale .. " = " .. self.targetScale)
end

function cameraManager:setFollowSpeed(speed)
	self.followSpeed = speed
end

function cameraManager:setTargetScale(scale)
	self.targetScale = scale
end

function cameraManager:setScale(scale)
	self.targetScale = scale
	self.cam.scale = scale
end

function cameraManager:getScale()
	return self.cam.scale
end

function cameraManager:worldPos(x, y)
	return self.cam:worldCoords(x, y)
end