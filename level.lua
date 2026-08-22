-- all of isometric logic rendering is defined here 

function level_load() 
    game_state = "level"
    level_state = "level" -- "level", "editor"
    screen_w = love.graphics.getWidth()
    screen_h = love.graphics.getHeight()
    tile_size = 16
    diamond_w = 8 
    diamond_h = 4
    layer_elavation = 8
    level_objects = {
        tiles = {},
    } 
    actions = {
    }
    cur_tile = 1
    cur_quad = 1 
    quad_limit = 4
    timer = 0
    origin_x, origin_y = 0, 0 
    depth = 5 
    cur_layer = depth 
    layers = create_layers(origin_x, origin_y, screen_w, screen_h, 5)
    proj_origin_x, proj_origin_y = get_projected_map_origin(screen_w)
    grid_start_x, grid_start_y = get_origin_grid_offset(origin_x, origin_y)

    load_layers()
    tiles_sort(level_objects.tiles)
end 

-- rendering

function level_draw()
    if level_state == "level" then 
        draw_projected_tiles()
    elseif level_state == "editor" then 
        draw_grid(grid_start_x, grid_start_y)
        draw_tiles()
    end 

    -- debug prints 
    love.graphics.print("cur_layer: " .. cur_layer, 0, screen_h-32)
    love.graphics.print("cur_quad: " .. cur_quad, 0, screen_h-16)
end 

function draw_projected_tiles() 
    love.graphics.setColor(1,1,1,1)

    for i=1,#level_objects.tiles do
        local tile = level_objects.tiles[i]
        if tile.visible then
            love.graphics.draw(tile.quad.img, tile.quad.quad, tile.proj_x, tile.proj_y)
        end

        if tile.layer ~= cur_layer then 
            tile.highlight = false 
        else
            local highlight_quad = quads.tiles[6]
            love.graphics.draw(highlight_quad.img, highlight_quad.quad, tile.proj_x, tile.proj_y)
        end 
    end 
end 

function draw_tiles()
    love.graphics.setColor(1,1,1,1)

    for i=1,#level_objects.tiles do
        local tile = level_objects.tiles[i]
        if tile.visible and tile.layer == cur_layer then
            love.graphics.draw(tile.quad.img, tile.quad.quad, tile.x, tile.y)
        end
    end 
end 

function get_origin_grid_offset(origin_x, origin_y)
    --[[ get offsets to draw a grid around origin_x/y.
    this is done by calculating an offset for start_x, start_y
    such that the resulting range [start_x/y, origin_x/y] contains
    an even number of tiles ]]

    local start_x = 0 
    local mod_x = origin_x % tile_size 
    if mod_x ~= 0 then start_x = start_x - (tile_size - mod_x) end 
    local start_y = 0 
    local mod_y = origin_y % tile_size 
    if mod_y ~= 0 then start_y = start_y - (tile_size - mod_y) end 

    return start_x, start_y
end 

function draw_grid(start_x, start_y)
    love.graphics.setColor(1,1,1, 0.33)

    for i=start_x, screen_w-tile_size, tile_size do     
        love.graphics.line(i, 0, i, screen_h)
    end 

    for j=start_y, screen_h-tile_size, tile_size do 
        love.graphics.line(0, j, screen_w, j)
    end 
end 

function load_layers()
    for k=#layers,1,-1 do
        local layer = layers[k]
        for i=1,#layer do 
            for j=1,#layer[i] do 
                local value = layer[i][j]
                if value > 0 then
                    local x = (j - 1) * tile_size + origin_x
                    local y = (i - 1) * tile_size + origin_y
                    local proj_x = ((j - i) * diamond_w) + proj_origin_x
                    local proj_y = ((i + j) * diamond_h) + (k * layer_elavation) + proj_origin_y
                    local quad = quads.tiles[value]
                    local tile_ = tile:new(x, y, proj_x, proj_y, tile_size, tile_size, quad, true, k, false)
                    table.insert(level_objects.tiles, tile_)
                end 
            end 
        end 
    end
end 

function get_projected_map_origin(w)
    local origin_x = (w / 2) - diamond_w / 2 
    local origin_y = 0 

    return  origin_x, origin_y 
end 

function create_layers(origin_x, origin_y, w, h, depth)
    -- todo maybe remove this function later 
    --[[ fills `depth` layers with empty tiles that cover [origin_x,w,tile_size]
    and [origin_y,h,tile_size] range 
    ]]
    local layers = {}
    for k=1,depth do
        layers[k] = {}
        for i=origin_y,h-tile_size,tile_size do
            local row = {}
            for j=origin_x,w-tile_size,tile_size do 
                table.insert(row, 0)
            end 
            table.insert(layers[k], row)
        end
        -- add structure axis 
        layers[k][1][1] = 1
    end

    return layers 
end 

function tiles_sort(tiles)
    -- todo if possible replace bubble sort with something else here 
    -- sorts tiles so that tiles from lower layers come first, and tiles within a layer are sorted by depth (lim->0(y) first)
    for i=1,#tiles do
        local max_j = i
        for j=i,#tiles do
            if tiles[j].y < tiles[max_j].y and tiles[j].layer == tiles[i].layer then
                max_j = j
            end
        end 
        -- swap 
        local temp = tiles[max_j] 
        tiles[max_j] = tiles[i]
        tiles[i] = temp
    end
end

function filter_tiles(tiles)
-- todo implement here function that removes tiles that are not visible from being rendred 
end 

-- collisions: 

function tile_collision(x, y)
    for tile in level_objects.tiles do 
    end 
end 

function mouse_collision(mouse_x, mouse_y, tile)
end 

-- controls: 

function level_keypressed(key, scancode)
    -- switch mode 
    if scancode == 'escape' and level_state == 'level' then
        level_state = 'editor'
    elseif scancode == 'escape' and level_state == 'editor' then 
        level_state = 'level'
    -- cur_layer update 
    elseif scancode == 'w' then 
        incr_layer(-1)
    elseif scancode == 's' then 
        incr_layer(1)
    end

end 

function level_keyreleased(key, scancode)
end

function level_mousepressed(x ,y, button)
end

function level_mousereleased(x, y, button)
end

function level_wheelmoved(x, y)
    if level_state == 'editor' then 
        incr_cur_quad(y)
    end 
end 

function snap_mouse_to_grid(x, y)
    -- + 1 to i/j here cause layer grid indexation starts from 1
    -- returns x and y
    local i = math.floor(y / tile_size) + 1   
    local j = math.floor(x / tile_size) + 1 
    return j, i
end 

function incr_layer(val)
    local sum = cur_layer + val 
    if sum > depth then 
        cur_layer = 1 
    elseif sum < 1 then 
        cur_layer = depth
    else 
        cur_layer = sum
    end 
end 

function incr_cur_quad(val) 
    local sum = cur_quad + val
    if sum > quad_limit then 
        cur_quad = 1 
    elseif sum < 1 then 
        cur_quad = quad_limit
    else 
        cur_quad = sum
    end 
end 

-- update logic 

function level_update(dt) 
    -- handle mousepress/release action queue  
    if level_state == "editor" then
        if love.mouse.isDown(1)then 
            local x, y = snap_mouse_to_grid(love.mouse.getPosition())
            local act = action:new(x,y,cur_quad,cur_layer) 
            actions[act:key()] = act   
        elseif love.mouse.isDown(2) then
            local x, y = snap_mouse_to_grid(love.mouse.getPosition())
            local act = action:new(x,y,0,cur_layer) 
            actions[act:key()] = act   
        -- empty action queue        
        else 
            if not is_empty(actions) then 
                empty_actions()
            end
        end 
    end
end

function insert_tile(i, j, value, depth)
    layers[depth][i][j] = value
end 

function clear_tiles()
    level_objects.tiles = {} 
end 

function empty_actions()
    for _, act in pairs(actions) do 
        insert_tile(act.y, act.x, act.value, act.layer)
        actions[act:key()] = nil 
    end
    clear_tiles()
    load_layers()
end  