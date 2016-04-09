player = class("player", gameObject)

function player:initialize(args)
	gameObject.initialize(self, args)
	self.id = "player"

	self.timer = 0
	self.angle = angle:new(0,1)
	
	local x = args.x or 100
	local y = args.y or 100
	local phys = physics:new({parent=self, x=x, y=y, w=50, h=100, gravity=true})

	local rect = rectangle:new({parent=self, w=50, h=100, posParent=phys, r=100, g=100, b=200})
	
	--local controller = topDownController:new({parent=self})
	local controller = platformerController:new({parent=self})
	
	self:addComponent(controller)
	self:addComponent(phys)
	self:addComponent(rect)
end