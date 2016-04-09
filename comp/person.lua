person = class("person", component)

function person:initialize(args)
	component.initialize(self, args)
	self.friendly = args.friendly
end

function person:collisionDetected(col)
	local phys = self.parent:getComponent("physics")
	if col.other.parent.id == "bullet" then
		if col.other.parent.friendly ~= self.friendly and col.other.inBackground == phys.inBackground then
			self.parent.die = true
			col.other.parent.die = true
			
			local phys = col.other.parent:getComponent("physics")
			local dir = 1
			if phys.vx < 0 then dir = -1 end
			
			phys = self.parent:getComponent("physics")
			local r = 100; local g = 50; local b = 50
			if self.friendly then r = 50; g = 50; b = 100 end
			local corpse = self.parent.game:addEnt(corpse, {x=phys.x-phys.w/2, y=phys.y+10, r=r, g=g, b=b})
			corpse:getComponent("physics"):setVel(250*dir, -50)
		end
	end
end