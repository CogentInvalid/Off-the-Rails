enemy = class("enemy", gameObject)

function enemy:initialize(args)
	gameObject.initialize(self, args)
	self.id = "enemy"
	
	local x = args.x or 100
	local y = args.y or 100
  
	local phys = physics:new({parent=self, x=x, y=y, w=48, h=48, gravity=true})

	local img = image:new({parent=self, name="image", img="player", posParent=phys, ox=-2, oy=-2})
		
	self:addComponent(phys)
	self:addComponent(img)
end