weapon = class("weapon", gameObject)

function weapon:initialize(args)
  gameObject.initialize(self, args)
	self.id = "weapon"

  local x = args.x
	local y = args.y
  local w = 40
  local h = 40
  
  
  local phys = physics:new({parent=self, x=x, y=y, w=w, h=h})
  local img = image:new({parent=self, img="gun", sx=0.4, sy=0.4, posParent=phys})
	
	self:addComponent(img)
  self:addComponent(phys)
  
end
  

