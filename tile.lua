tile = class:new()

function tile:init(x, y,  proj_x, proj_y, w, h, quad, visible, layer)
    --[[
        `x` and `y` - position inside of layer `layer`; 
        `proj_x` and `proj_y` - isometric projection positions of a tile (as it is displayed on a screen);  
    ]]
    self.x = x
    self.y = y
    self.proj_x = proj_x
    self.proj_y = proj_y
    self.w = w
    self.h = h
    self.quad = quad
    self.visible = visible
    self.layer = layer
end
