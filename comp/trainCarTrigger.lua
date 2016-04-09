trainCarTrigger = class("trainCarTrigger", component)

function trainCarTrigger:initialize(args)
	component.initialize(self, args)
	self.name = "trigger"
	self.car = args.car
end

function trainCarTrigger:triggered() --TW: triggers
	--TODO: set camera position
	self.parent.game.levMan:enterCar(self.car)
	self.parent.die = true
end