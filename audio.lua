audio = class("audio")

function audio:initialize(args)
  
end


function audio:setAudio(name)
  
  local source = love.audio.newSource("res/audio/"..name..".ogg")
  love.audio.play(source)
  source.setLooping(true)
  
end



