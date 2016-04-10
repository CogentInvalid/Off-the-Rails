date = class("date", gameObject)

function date:initialize(args)
	gameObject.initialize(self, args)
	self.id = "date"
	
	local x = args.x or 100
	local y = args.y or 100
  
	local phys = physics:new({parent=self, x=x, y=y, w=50, h=100, gravity=true})

	local rect = rectangle:new({parent=self, posParent=phys, w=50, h=100, r=200, g=50, b=200})
    
	self:addComponent(phys)
	self:addComponent(rect)
	self:addComponent(dateAI:new({parent=self, target=self.game.player:getComponent("physics")}))

end
