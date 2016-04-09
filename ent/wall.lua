wall = class("wall", gameObject)

function wall:initialize(args)
	gameObject.initialize(self, args)
	self.id = "wall"
	
	local phys = physics:new({parent=self, x=args.x, y=args.y, w=50, h=50, col=false, solidity="static"})
	
	local img = image:new({parent=self, img="tile1", posParent=phys})
	
	self:addComponent(img)
	self:addComponent(phys)
end