audio = class("audio")

function audio:initialize(args)
	self.sources = {}
end


function audio:setAudio(name)
  
  local source = love.audio.newSource("res/audio/"..name..".ogg")
	self.sources[#self.sources+1] = source
  love.audio.play(source)
  source:setLooping(true)
  
end

function audio:clearAudio()
	for i, source in ipairs(self.sources) do
		source:stop()
	end
	self.sources = {}
end

function audio:playAudio(name)
  
  local source = love.audio.newSource("res/audio/"..name..".ogg")
  love.audio.play(source)
  
end



