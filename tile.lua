tile = class:new()

function tile:init(x, y, w, h, quad, visible, layer)
    self.x = x
    self.y = y
    self.w = w
    self.h = h
    self.quad = quad
    self.visible = visible
    self.layer = layer
end
