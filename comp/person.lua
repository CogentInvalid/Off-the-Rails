person = class("person", component)

function person:initialize(args)
	component.initialize(self, args)
	self.friendly = args.friendly
end

function person:collisionDetected(col)
	if col.other.parent.id == "bullet" then
		if col.other.parent.friendly ~= self.friendly then
			self.parent.die = true
			col.other.parent.die = true
			
			local phys = col.other.parent:getComponent("physics")
			local dir = 1
			if phys.vx < 0 then dir = -1 end
			
			phys = self.parent:getComponent("physics")
			local corpse = self.parent.game:addEnt(corpse, {x=phys.x-phys.w/2, y=phys.y+10})
			corpse:getComponent("physics"):setVel(250*dir, -50)
		end
	end
end