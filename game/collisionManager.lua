local bump = require "libs/bump"

collisionManager = class("collisionManager")

function collisionManager:initialize(parent)
	self.game = parent
	self.world = bump.newWorld()
end

--add a physics component to the world
function collisionManager:addToWorld(comp)
	self.world:add(comp, comp.x, comp.y, comp.w, comp.h)
	return self.world
end

function collisionManager:update(dt)
	
	--for each thing with a physics component
	--TODO: instead of checking entities for physics components, just iterate through self.world
	for i, entity in ipairs(self.game.ent) do
		if entity:getComponent("physics") ~= nil then
			local phys = entity:getComponent("physics")
			--collide that thing
			if phys.col then
				self:collide(entity)
			end
			self.world:update(phys, phys.x, phys.y)
		end
	end
	
end

function collisionManager:collide(entity)
	--queryRect
	local e1 = entity:getComponent("physics")
	local cols, len = self.world:queryRect(e1.x-8, e1.y-8, e1.w+16, e1.h+16) --todo: see how small you can make the border
	
	local sideHit = false
	
	--all: a table of collisions.
	--stores the entity collided with, the collision direction, and the number of collisions
	--counter = 1 -> side collision, counter = 2 -> corner collision
	local all = {}
	
	--for each entry in collideOrder:
	for q, cond in ipairs(e1.collideOrder) do
		
		for i, e2 in lume.ripairs(cols) do --TODO: lume.ripairs
			if e1 ~= e2 and cond(e2) then
				-- remove from queryRect collection
				table.remove(cols, i)
				
				local col = self:detectCollisions(e1, e2)
				if col ~= nil then
					all[#all+1] = col
					if col.counter == 1 then sideHit = true end
				end
				
			end
		end
		
		-- for each detected collision:
		for i, col in ipairs(all) do
			--ignore all corner collisions as long as there's at least one side collision
			if col.counter == 1 or sideHit == false then
				-- resolve collisions (hitSide)
				e1:hitSide(col.other, col.side)
			end
			-- call collisionDetected
			--TODO: call collisionDetected with aaaaallllll the collisions
			entity:notifyComponents("collisionDetected", col)
			entity:notifyComponents("sideHit", col)
		end
		
		
	end
	
	--for remaining entities in queryRect:
	for i, e2 in ipairs(cols) do
		-- detect collisions
		local col = self:detectCollisions(e1, e2)
		-- call collisionDetected
		if col ~= nil then
			entity:notifyComponents("collisionDetected", col)
			--TODO: add to all
		end
	end
	
	--TODO: call collisionDetected with everything from all

end

function collisionManager:detectCollisions(e1, e2)
	-- detect collisions w/other objects
	local other = nil; local side = nil; local counter = 0

	--find collision direction
	if e1.y+e1.h>e2.y and e1.y<e2.y+e2.h then --left/right
		if e1.px+e1.w-0.1 <= e2.px and e1.x+e1.w > e2.x then --left
			other = e2; side = "left"; counter = counter + 1
		end
		if e1.px+0.1 >= e2.px+e2.w and e1.x < e2.x+e2.w then --right
			other = e2; side = "right"; counter = counter + 1
		end
	end
	if e1.x+e1.w>e2.x and e1.x<e2.x+e2.w then --up/down
		if e1.py+e1.h-0.1 <= e2.py and e1.y+e1.h > e2.y then --from above
			other = e2; side = "up"; counter = counter + 1
		end
		if e1.py+0.1 >= e2.py+e2.h and e1.y < e2.y+e2.h then --below
			other = e2; side = "down"; counter = counter + 1
		end
	end
	if other == nil then
		if e1.y+e1.h>e2.y and e1.y<e2.y+e2.h and e1.x+e1.w>e2.x and e1.x<e2.x+e2.w then
			--if they were already colliding last frame, it's an "in" collision
			other = e2; side = "in"
		end
	end
	
	if other ~= nil then
		return {other=other, side=side, counter=counter}
	end
end








--OLD FUNCTIONS


function collisionManager:collidex(entity)
	--detect collisions
	local cols = self:detectCollisions(entity)
	--pass collisions to components
	if #cols > 0 then entity:notifyComponents("collisionDetected", cols) end
end

function collisionManager:detectCollisionsx(ent1) --collisions for all the things* (*that are rectangles)
	--all: a table of collisions.
	--stores the entity collided with, the collision direction, and the number of collisions
	--counter = 1 -> side collision, counter = 2 -> corner collision
	local all = {}
	local e1 = ent1:getComponent("physics")
	local cols, len = self.world:queryRect(e1.x-8, e1.y-8, e1.w+16, e1.h+16)
	--TODO: sort cols based on e1.collideOrder
	--hint: use lume.sort or something
	
	local i = 1
	for q, e2 in ipairs(cols) do
		if e1 ~= e2 then
			
			local other = nil; local side = nil; local counter = 0

			--find collision direction
			if e1.y+e1.h>e2.y and e1.y<e2.y+e2.h then --left/right
				if e1.px+e1.w-0.1 <= e2.px and e1.x+e1.w > e2.x then --left
					other = e2; side = "left"; counter = counter + 1
				end
				if e1.px+0.1 >= e2.px+e2.w and e1.x < e2.x+e2.w then --right
					other = e2; side = "right"; counter = counter + 1
				end
			end
			if e1.x+e1.w>e2.x and e1.x<e2.x+e2.w then --up/down
				if e1.py+e1.h-0.1 <= e2.py and e1.y+e1.h > e2.y then --from above
					other = e2; side = "up"; counter = counter + 1
				end
				if e1.py+0.1 >= e2.py+e2.h and e1.y < e2.y+e2.h then --below
					other = e2; side = "down"; counter = counter + 1
				end
			end
			if other == nil then
				if e1.y+e1.h>e2.y and e1.y<e2.y+e2.h and e1.x+e1.w>e2.x and e1.x<e2.x+e2.w then
					--if they were already colliding last frame, it's an "in" collision
					other = e2; side = "in"
				end
			end
			
			if other ~= nil then
				all[#all+1] = {other=other, side=side, counter=counter}
			end
			
		end
	end
	
	return all
end