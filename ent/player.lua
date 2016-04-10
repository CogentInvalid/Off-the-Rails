player = class("player", gameObject)

function player:initialize(args)
	gameObject.initialize(self, args)
	self.id = "player"

	self.timer = 0
	self.angle = angle:new(0,1)
	
	local x = args.x or 100
	local y = args.y or 100
	local phys = physics:new({parent=self, x=x, y=y, w=50, h=100, gravity=true})
	phys.collideOrder = {physics.isSolid, physics.isStatic, physics.thirdThing}

	local rect = rectangle:new({parent=self, w=50, h=100, posParent=phys, r=100, g=100, b=200, drawLayer="player", name="hitbox"})
	local reload = rectangle:new({parent=self, w=50, h=10, posParent=phys, oy=-30, r=255, g=255, b=255, drawLayer="player", name="reloadBar"})
	self:addComponent(reload)
	
	local controller = platformerController:new({parent=self})
	
	self:addComponent(controller)
	self:addComponent(phys)
	self:addComponent(rect)
	self:addComponent(person:new({parent=self, friendly=true}))
end