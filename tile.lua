tile = class:new()

function tile:init(x, y, w, h, quad, layer)
    self.x = x
    self.y = y
    self.w = w
    self.h = h
    self.quad = quad
    self.layer = layer 
end
