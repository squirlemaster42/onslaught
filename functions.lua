local func = {}

func.check_collision = function(obj1, obj2)
        return obj1.x < (obj2.x + obj2.width) and
               obj2.x < (obj1.x + obj1.width) and
               obj1.y < (obj2.y + obj2.height) and
               obj2.y < (obj1.y + obj1.height)
    end

return func