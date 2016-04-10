bullet = class("bullet", gameObject)

function bullet:initialize(args)
	gameObject.initialize(self, args)
	self.id = "bullet"
	
	self.friendly = args.friendly
	
	local vx = args.vx or 1
	local vy = args.vy or 0
	local speed = 2000
	if self.friendly == false then speed = 800 end
	local phys = physics:new({parent=self, x=args.x, y=args.y, w=6, h=6, col=false})
	phys.vx = speed*vx
	phys.vy = speed*vy
	
	local rect = rectangle:new({parent=self, w=6, h=6, posParent=phys})
	
	self:addComponent(rect)
	self:addComponent(phys)
	self:addComponent(destroyOffscreen:new({parent=self}))
end