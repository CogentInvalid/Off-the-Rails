text = class("text", component)

function text:initialize(args)
	--crash(inspect(args.delay))
	self.id = "text"
	self.text = args.text
	self.delay = args.delay or 0
	self.x = args.x
	self.y = args.y
	self.drawLayer = "default"
	self.a = args.a or 0
	self.activated = false
end

function text:offset(args)
	self.x = self.x + args.x
	self.y = self.y + args.y
end

function text:update(dt)
	if self.a < 1 and self.activated then
		if self.delay > 0 then
			self.delay = self.delay - dt
		end
		if self.delay <= 0 then self.a = self.a + 0.4*dt end
	end
end

function text:activate()
	self.activated = true
end

function text:draw(args)
  love.graphics.setColor(255,255,255, 255*self.a)
  love.graphics.print(self.text, self.x, self.y)
end

