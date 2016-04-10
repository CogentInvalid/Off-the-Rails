particle = class("particle", gameObject)

function particle:initialize(args)
	gameObject.initialize(self, args)
	self.id = "particle"
	
	self.rect = rectangle:new({parent=self, x=args.x, y=args.y, w=args.w, h=args.h, drawLayer="default", a=255})
	
	self:addComponent(rect)
end

function particle:update(dt)
end