trainCarTrigger = class("trainCarTrigger", component)

function trainCarTrigger:initialize(args)
	component.initialize(self, args)
	self.type = "trainCarTrigger"
	self.car = args.car
	self.index = args.index
end

function trainCarTrigger:triggered() --TW: triggers
	--TODO: set camera position
	if not self.parent.game.won then
		self.parent.game.levMan:enterCar(self.car, self.index)
		self.parent.die = true
	else
		gamestate.switch(gameMode.win)
	end
end