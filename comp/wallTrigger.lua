wallTrigger = class("wallTrigger", component)

function wallTrigger:initialize(args)
	component.initialize(self, args)
	self.name = "trigger"
	self.x = args.x
	self.y = args.y
end

function wallTrigger:triggered()
	self.parent.game:addEnt(playerWall, {x=self.x, y=self.y, w=20, h=250})
	self.parent.die = true
end

--function wallTrigger:offset(args)
--	self.x = self.x + args.x
--	self.y = self.y + args.y
--end