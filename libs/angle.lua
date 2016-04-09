--angle: represents an angle, yo!!!
local angle = class("angle")

function angle:initialize(x, y)
	y = -y
	if x == 0 then x = 0.0001 end --this is so dumb, but it works
	if y == 0 then y = 0.0001 end
	
	--get angle
	local theta = math.atan(y/x)
	if x < 0 then
		theta = -theta + math.pi
	end
	if x > 0 then
		theta = -theta + 2*math.pi
	end
	self.theta = theta
	
	self.xPart = math.cos(self.theta)
	self.yPart = math.sin(self.theta)
	
	self:calibrate()
end

function angle:setTheta(theta)
	self.theta = theta
	self:calibrate()
	self.xPart = math.cos(self.theta)
	self.yPart = math.sin(self.theta)
end

function angle:addTheta(theta)
	self:setTheta(self.theta+theta)
end

function getAngleDistance(t1, t2) --take two angles and find the distance between them on the unit circle (i.e. 2pi/0 -> 0)
	if math.abs(t1-t2) > math.pi then
		if t1 > t2 then t1 = t1 - math.pi*2
		else if t1 < t2 then t2 = t2 - math.pi*2 end end
		return math.abs(t1-t2)
	else
		return math.abs(t1-t2)
	end
end

function getAngleDirection(t1, t2) --get closest direction between t1 and t2 (counterclockwise=1, clockwise=-1)
	if math.abs(t1-t2) > math.pi then
		if t1 >= t2 then return 1
		else return -1 end
	else
		if t1 >= t2 then return -1
		else return 1 end
	end
end

function angle:calibrate() --make sure theta is between 0 and 2pi
	if self.theta >= math.pi*2 then self.theta = self.theta - math.pi*2 end
	if self.theta < 0 then self.theta = self.theta + math.pi*2 end
end

return angle