wall = class("wall", gameObject)

function wall:initialize(args)
	gameObject.initialize(self, args)
	self.id = "wall"
	
	local phys = physics:new({parent=self, x=args.x, y=args.y, w=args.w, h=args.h, col=false, solidity="static"})
	
	local rect = rectangle:new({parent=self, w=args.w, h=args.h, posParent=phys})
	
	self:addComponent(rect)
	self:addComponent(phys)
end