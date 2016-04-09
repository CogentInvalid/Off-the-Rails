--misc. helpful functions

function string:split(delimiter) --definitely not stolen from anything else
	local result = {}
	local from  = 1
	local delim_from, delim_to = string.find( self, delimiter, from  )
	while delim_from do
		table.insert( result, string.sub( self, from , delim_from-1 ) )
		from = delim_to + 1
		delim_from, delim_to = string.find( self, delimiter, from  )
	end
	table.insert( result, string.sub( self, from  ) )
	return result
end

function keyDown(key)
	return love.keyboard.isDown(key)
end

function mouseDown(b)
	return love.mouse.isDown(b)
end

function mouseX()
	return love.mouse.getX()
end

function mouseY()
	return love.mouse.getY()
end

function getHue(x) --gets hue from number 0-255
	while x<0 do x = x + 255 end
	x = x * 6
	r=255; g=0; b=0
	while x>0 do
		if x>=255 then g = g + 255; x = x - 255
		else g = g + x; x = 0 end
		if x>=255 then r = r - 255; x = x - 255
		else r = r - x; x = 0 end
		if x>=255 then b = b + 255; x = x - 255
		else b = b + x; x = 0 end
		if x>=255 then g = g - 255; x = x - 255
		else g = g - x; x = 0 end
		if x>=255 then r = r + 255; x = x - 255
		else r = r + x; x = 0 end
		if x>=255 then b = b - 255; x = x - 255
		else b = b - x; x = 0 end
	end
	return r, g, b
end

function desaturate(r,g,b,amt)
	amt = 1 - amt
	r = r + (255-r)*amt
	g = g + (255-g)*amt
	b = b + (255-b)*amt
	return r, g, b
end

function darken(r,g,b,amt)
	r = r * amt
	g = g * amt
	b = b * amt
	return r, g, b
end

function crash(message) --ghetto debugs yo
	message = message or "crash() called"
	assert(false, message)
end