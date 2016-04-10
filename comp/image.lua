--image component: handles drawing images to the screen.

image = class("image", component)

function image:initialize(args)
	component.initialize(self, args)
	self.type = "image"
	
	self.imgName = args.img
	self.img = getImg(args.img) --THIS IS GONNA BREAK SOMEDAY
	self.r = 255; self.g = 255; self.b = 255
	
	self.w, self.h = self.img:getDimensions()
	
	self.x = args.x or 100; self.y = args.y or 100 --position on screen
	self.ox = args.ox or 0; self.oy = args.oy or 0 --offset
	
	self.sx = args.sx or 1; self.sy = args.sy or 1
	
	if args.posParent then --a parent component to follow
		self:setPosParent(args.posParent, self.ox, self.oy)
	end
	
	self.drawLayer = args.drawLayer or "default"
end

function image:update(dt)
	if self.posParent then
		self.x = self.posParent.x; self.y = self.posParent.y
	end
end

--UNFINISHED
function image:setQuad(x, y, w, h)
	self.quad = love.graphics.newQuad((x-1)*w, (y-1)*h, w, h, self.img:getDimensions())
end

function image:setPos(x, y)
	self.x = x; self.y = y
end

function image:setOffset(x, y)
	self.ox = x; self.oy = y
end

--set another component as this image's parent, so that it'll automatically match its position onscreen
function image:setPosParent(parent, ox, oy)
	self.posParent = parent
	self.ox = ox; self.oy = oy
end

--set to color to draw the image with
function image:setRGB(r, g, b)
	self.r = r
	self.g = g
	self.b = b
end

--draw the image
function image:draw()
	if self.posParent then
		self.x = self.posParent.x; self.y = self.posParent.y
	end
	
	love.graphics.setColor(self.r, self.g, self.b)
	love.graphics.draw(self.img, self.x+self.ox, self.y+self.oy, 0, self.sx, self.sy)
end

--UNFINISHED
function image:drawQuad(x, y, sx, sy)
	love.graphics.setColor(self.r, self.g, self.b)
	love.graphics.draw(self.img, self.quad, math.floor(x), math.floor(y), 0, sx, sy)
end