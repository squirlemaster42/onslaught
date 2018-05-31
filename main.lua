player = require "player"
func = require "functions"
ground = require "ground"

function love.load()
    -- window
    width = 1280
    height = 720
    love.window.setMode(width, height)

    -- environmental vairables
    gravity = .5

    -- enemies
    enemies = {}
    last_spawned = love.timer.getTime()
end

function love.update(dt)
    player.height = player_height
    -- controls

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

    player.update()

    for a,x in ipairs(enemies) do
        for b,y in ipairs(player.bullets) do
            if func.check_collision(x, y) then
                table.remove(enemies, a)
                table.remove(player.bullets, b)
            end
        end
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
end