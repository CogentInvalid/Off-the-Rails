Ai = class("Ai", component)

function Ai:initialize(args)
  component.initialize(self, args)
  self.type = "Ai"
  self.target = args.target
  self.phys = self.parent:getComponent("physics")
end

function Ai:isVisible()
  if (math.abs(self.phys.x - self.target.x) < 500) then
    return true
  end
end


    