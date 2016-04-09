cameraTrigger = class("cameraTrigger", component)

function cameraTrigger:initialize(args)
	component.initialize(self, args)
	self.name = "trigger"
	self.camx = args.camx
	self.camy = args.camy
end

function cameraTrigger:triggered() --TW: triggers
	--TODO: set camera position
	self.parent.game.camMan:setTargetPos(self.camx, self.camy)
	self.parent.die = true
end