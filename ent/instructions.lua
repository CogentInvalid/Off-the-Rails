instructions = class("instructions", gameObject)

function instructions:initialize(args)
	gameObject.initialize(self, args)
	self.id = "instructions"
	
	local t = text:new({parent=self, text=args.text, x=args.x, y=args.y, delay=args.delay, drawLayer="player"})
	self:addComponent(t)
end