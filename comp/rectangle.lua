--rectangle component: handles drawing rectangles to the screen.

rectangle = class("rectangle", component)

function rectangle:initialize(args)
	component.initialize(self, args)
	self.type = "rectangle"
	
	self.r = args.r or 255
	self.g = args.g or 255
	self.b = args.b or 255
	
	self.w = args.w
	self.h = args.h
	
	self.x = args.x or 100; self.y = args.y or 100 --position on screen
	self.ox = args.ox or 0; self.oy = args.oy or 0 --offset
	
	if args.posParent then --a parent component to follow
		self:setPosParent(args.posParent, self.ox, self.oy)
	end
	
	self.drawLayer = args.drawLayer or "default"
end

function rectangle:update(dt)
	if self.posParent then
		self.x = self.posParent.x; self.y = self.posParent.y
	end
end

function rectangle:setPos(x, y)
	self.x = x; self.y = y
end

function rectangle:setOffset(x, y)
	self.ox = x; self.oy = y
end

--set another component as this rectangle's parent, so that it'll automatically match its position onscreen
function rectangle:setPosParent(parent, ox, oy)
	self.posParent = parent
	self.ox = ox; self.oy = oy
end

--set to color to draw the rectangle with
function rectangle:setRGB(r, g, b)
	self.r = r
	self.g = g
	self.b = b
end

--draw the image
function rectangle:draw()
	if self.posParent then
		self.x = self.posParent.x; self.y = self.posParent.y
	end
	love.graphics.setColor(self.r, self.g, self.b)
	love.graphics.rectangle("fill", self.x+self.ox, self.y+self.oy, self.w, self.h)
end