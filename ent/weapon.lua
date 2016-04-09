weapon = class("weapon", gameObject)

function weapon:initialize(args)
  gameObject.initialize(self, args)
	self.id = "weapon"

  local x = args.x
	local y = args.y
  local w = 40
  local h = 40
  
  
  local phys = physics:new({parent=self, x=x, y=y, w=w, h=h})
  local rect = rectangle:new({parent=self, w=w, h=w, posParent=phys, r=200, g=200, b=200})
  
  
  self:addComponent(rect)
  self:addComponent(phys)
  
end
  

