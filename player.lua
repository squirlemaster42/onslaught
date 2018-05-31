func = require "functions"
ground = require "ground"

local player = {}

player_height = 100

player.x = 50
player.y = 500
player.height = player_height
player.width = 40
player.y_change = 0
player.fire_available = true
player.jump_available = true

player.bullets = {}

    -- player functions --
player.duck = function()
    player.height = 50
end

player.jump = function()
    player.y_change = -15
end

player.fire = function()
    bullet = {}
    bullet.x = player.x + player.width
    bullet.y = player.y + player.height / 3
    bullet.width = 10
    bullet.height = 10
    bullet.speed = 5

    table.insert(player.bullets, bullet)
end

player.gravity_update = function()
    if not ((player.y + 100) >= ground.y) then
        player.y_change = player.y_change + gravity
    else
        player.y_change = 0
    end

    if (player.y + 100) >= ground.y then
        player.y = ground.y - 100
        player.jump_available = true
    end
end

update_bullet = function(b)
    b.x = b.x + b.speed
end

---- update method ----
player.update = function()
    if love.keyboard.isDown("w") and player.jump_available then
        player.jump()
        player.jump_available = false
    else
        player.gravity_update()
    end
    if love.keyboard.isDown("s") then
        player.duck()
    end
    if love.keyboard.isDown("space") and player.fire_available then
        player.fire()
        player.fire_available = false
    end
    if not love.keyboard.isDown("space") then
        player.fire_available = true
    end

    player.y = player.y + player.y_change

    for _,v in pairs(player.bullets) do
        update_bullet(v)
    end
end

return player