corpse = class("corpse", gameObject)

function corpse:initialize(args)
	gameObject.initialize(self, args)
	self.id = "corpse"
	
	local x = args.x or 100
	local y = args.y or 100
  
	local phys = physics:new({parent=self, x=x, y=y, w=100, h=50, gravity=true, friction=true})

	local rect = rectangle:new({parent=self, posParent=phys, w=100, h=50, r=100, g=50, b=50})
		
	self:addComponent(phys)
	self:addComponent(rect)
end