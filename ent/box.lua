box = class("box", gameObject)

function box:initialize(args)
	gameObject.initialize(self, args)
	self.id = "box"
	
	local phys = physics:new({parent=self, x=args.x, y=args.y, w=50, h=50, col=false, solidity="static"})
	
	local img = image:new({parent=self, img="box", sx=0.4, sy=0.4, posParent=phys})
	
	self:addComponent(img)
	self:addComponent(phys)
end