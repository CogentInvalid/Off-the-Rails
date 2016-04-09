text = class("text", component)

function text:initialize(args)
	component.initialize(self, args)
	self.id = "text"
	self.text = args.text
	self.x = args.x
	self.y = args.y
	self.drawLayer = "default"
end

function text:offset(args)
	self.x = self.x + args.x
	self.y = self.y + args.y
end


function text:draw(args)
  love.graphics.setColor(255,255,255)
  love.graphics.print(self.text, self.x, self.y)
end

