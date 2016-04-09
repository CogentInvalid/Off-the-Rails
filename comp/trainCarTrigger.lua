trainCarTrigger = class("trainCarTrigger", component)

function trainCarTrigger:initialize(args)
	component.initialize(self, args)
	self.name = "trigger"
end

function trainCarTrigger:triggered() --TW: triggers
	--TODO: set camera position
	self.parent.game.levMan:enterNextCar()
	self.parent.die = true
end