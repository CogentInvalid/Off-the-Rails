playerWall = class("playerWall", gameObject)

function playerWall:initialize(args)
	gameObject.initialize(self, args)
	self.id = "playerWall"
	
	local phys = physics:new({parent=self, x=args.x, y=args.y, w=args.w, h=args.h, col=false, playerSolid = true})
	
	local rect = rectangle:new({parent=self, w=args.w, h=args.h, posParent=phys, a=0})
	
	self:addComponent(rect)
	self:addComponent(phys)
end