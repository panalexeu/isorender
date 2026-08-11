quad = class:new()

function quad:init(img, x, y, w, h, sw, sh)
    self.img = img 
    self.quad = love.graphics.newQuad(x,y,w,h,sw,sh)
end 