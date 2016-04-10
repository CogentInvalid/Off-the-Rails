bullet = class("bullet", gameObject)

function bullet:initialize(args)
	gameObject.initialize(self, args)
	self.id = "bullet"
	
	self.friendly = args.friendly
	
	local vx = args.vx or 1
	local vy = args.vy or 0
	local speed = 2000
	if self.friendly == false then speed = 800 end
	self.phys = physics:new({parent=self, x=args.x, y=args.y, w=6, h=6, col=true})
	self.phys.vx = speed*vx
	self.phys.vy = speed*vy
	
	local rect = rectangle:new({parent=self, w=6, h=6, posParent=self.phys})
	
	self:addComponent(rect)
	self:addComponent(self.phys)
	self:addComponent(destroyOffscreen:new({parent=self}))
end

function bullet:update(dt)
	gameObject.update(self, dt)
	self.game:addEnt(particle, {x=self.phys.x, y=self.phys.y, w=10, h=6})
end