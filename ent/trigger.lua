trigger = class("trigger", gameObject)

function trigger:initialize(args)
	gameObject.initialize(self, args)
	self.id = "trigger"
	
	local phys = physics:new({parent=self, x=args.x, y=args.y, w=args.w, h=args.h, col=false})
	
	local rect = rectangle:new({parent=self, w=args.w, h=args.h, posParent=phys, r=0, g=100, b=0, a=0})
	
	self:addComponent(rect)
	self:addComponent(phys)
end