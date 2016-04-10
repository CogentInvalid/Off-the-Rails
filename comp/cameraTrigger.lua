cameraTrigger = class("cameraTrigger", component)

function cameraTrigger:initialize(args)
	component.initialize(self, args)
	self.name = "trigger"
	self.camx = args.camx
	self.camy = args.camy
end

function cameraTrigger:triggered() --TW: triggers
	--TODO: set camera position
	self.parent.game.camMan:setTargetPos(self.camx, self.camy, 0, 0)
	self.parent.game.camMan.lockY = false
	self.parent.die = true
end