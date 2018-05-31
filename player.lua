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

return player