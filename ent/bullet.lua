bullet = class("bullet", gameObject)

function bullet:initialize(args)
	gameObject.initialize(self, args)
	self.id = "bullet"
	
	self.friendly = args.friendly
	
	local direction = args.dir or 1
	local speed = 2000
	if self.friendly == false then speed = 800 end
	local phys = physics:new({parent=self, x=args.x, y=args.y, w=6, h=6, col=true})
	phys.vx = speed*direction
	
	local rect = rectangle:new({parent=self, w=6, h=6, posParent=phys})
	
	self:addComponent(rect)
	self:addComponent(phys)
end