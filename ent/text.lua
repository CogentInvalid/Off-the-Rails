text = class("text", component)

function text:initialize(args)
  component.initialize(self, args)
	self.id = "text"
  self.text = args.text
end


function text:draw(args)
  love.graphics.setColor(255,255,255)
  love.graphics.print(self.text, x, y)
end

