function max_len_table(t)
    local best = {} 
    for _, v in ipairs(t) do 
        if #v > #best then best = v end  
    end 
    return best 
end 

function is_empty(t)
    return next(t) == nil 
end 