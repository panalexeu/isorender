action = class:new() 

function action:init(x, y, value, layer)
    self.x = x
    self.y = y 
    self.value = value 
    self.layer = layer 
end 

function action:key() 
    return self.x .. ":" .. self.y .. ":" .. self.value  .. ":" .. self.layer 
end 
