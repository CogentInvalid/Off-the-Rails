fadeOut = class("fadeOut", component)

function fadeOut:initialize(args)
  
	component.initialize(self, args)
  self.rect = self.parent:getComponent("rectangle")
  self.delay = args.delay

end

function fadeOut:update(dt)
  
  self.delay = self.delay - dt
  
  if (self.delay < 0) then
    self.rect.a = self.rect.a - (200)*dt
    if (self.rect.a < 0) then
      self.parent.die = true
    end
  end

end


