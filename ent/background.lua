background = class("background", gameObject)

function background:initialize(args)
	gameObject.initialize(self, args)
	self.id = "background"
	
	local img = image:new({parent=self, img=args.img, x=args.x, y=args.y, sx=args.sx, sy=args.sy, posParent=phys, drawLayer="actualBackground", ox=args.ox, oy=args.oy, offx=args.offx, offy=args.offy})
	
	self:addComponent(img)
end