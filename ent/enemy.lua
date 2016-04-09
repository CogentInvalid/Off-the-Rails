enemy = class("enemy", gameObject)

function enemy:initialize(args)
	gameObject.initialize(self, args)
	self.id = "enemy"
	
	local x = args.x or 100
	local y = args.y or 100
  
	local phys = physics:new({parent=self, x=x, y=y, w=50, h=100, gravity=true})

	local rect = rectangle:new({parent=self, posParent=phys, w=50, h=100, r=200, g=50, b=50})
		
	self:addComponent(phys)
	self:addComponent(rect)
	self:addComponent(person:new({parent=self, friendly=false}))
	self:addComponent(Ai:new({parent=self, target=self.game.player:getComponent("physics")}))
end