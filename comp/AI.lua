Ai = class("Ai", component)

function Ai:initialize(args)
  component.initialize(self, args)
  self.type = "Ai"
  self.target = args.target
  self.phys = self.parent:getComponent("physics")
end

function Ai:update(dt)
	local rect = self.parent:getComponent("rectangle")
	if self:targetVisible() then
		rect.r = 255
	else
		rect.r = 255
	end
end

function Ai:targetVisible()
  if (math.abs(self.phys.x - self.target.x) < 500) then
    return true
  end
end


    