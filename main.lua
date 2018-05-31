function love.load()
    -- window
    width = 1280
    height = 720
    love.window.setMode(width, height)

    -- environmental vairables
    gravity = .5
    love.keyboard.setKeyRepeat(false)

    ground = {}
    ground.y = 600

    -- player
    player_height = 100

    player = {}
    player.x = 50
    player.y = 500
    player.height = player_height
    player.width = 40
    player.y_change = 0
    player.fire_available = true
    player.jump_available = true
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

    -- enemies
    enemies = {}
    last_spawned = love.timer.getTime()

    -- projectiles
    player.bullets = {}

    --functions
    check_collision = function(x1, y1, w1, h1, x2, y2, w2, h2)
        return x1 < (x2 + w2) and
               x2 < (x1 + w1) and
               y1 < (y2 + h2) and
               y2 < (y1 + h1)
    end
end

function love.update(dt)
    player.height = player_height
    -- controls
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

    for _,v in pairs(player.bullets) do
        v.x = v.x + v.speed
    end

    player.y = player.y + player.y_change

    if (love.timer.getTime() - last_spawned) >= 2 then
        base_enemy = {}
        base_enemy.x = 1200
        base_enemy.y = 400 + love.math.random() * 100
        base_enemy.width = 50
        base_enemy.height = 200
        base_enemy.speed = 5
        table.insert(enemies, base_enemy)
        last_spawned = love.timer.getTime()
    end

    for _,v in pairs(enemies) do
        v.x = v.x - v.speed
    end

    if (player.y - 100) > ground.y then
        player.y = ground.y - 100
    end
end

function love.draw()
    love.graphics.setColor(255, 255, 255)
    love.graphics.print(love.timer.getFPS(), 1250, 700)
    love.graphics.rectangle("line", player.x, player.y, player.width, player.height)
    love.graphics.setColor(255, 0, 0)
    for _,v in pairs(player.bullets) do
        love.graphics.rectangle("fill", v.x, v.y, v.width, v.height)
    end

    love.graphics.setColor(255, 0, 255)
    for _,v in pairs(enemies) do
        love.graphics.rectangle("fill", v.x, v.y, v.width, v.height)
    end
    -- ground
    love.graphics.setColor(255, 255, 255)
    love.graphics.rectangle("fill", 20, ground.y, 1240, 10)
    love.graphics.setColor(0, 0, 0)
    --love.graphics.rectangle("fill", 0, ground.y + 10, 1280, 110)
end