player = class("player", gameObject)

function player:initialize(args)
	gameObject.initialize(self, args)
	self.id = "player"

	self.timer = 0
	self.angle = angle:new(0,1)
	
	local x = args.x or 100
	local y = args.y or 100
	local phys = physics:new({parent=self, x=x, y=y, w=48, h=48, gravity=true})

	local rect = rectangle:new({parent=self, w=48, h=48, posParent=phys})
	
	--local controller = topDownController:new({parent=self})
	local controller = platformerController:new({parent=self})
	
	self:addComponent(controller)
	self:addComponent(phys)
	self:addComponent(rect)
end