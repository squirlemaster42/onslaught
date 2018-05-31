function love.load()
    width = 1280
    height = 720
    love.window.setMode(width, height)

    left_player = {}
    left_player.x = 50
    left_player.size = 200
    left_player.y = height / 2 - (left_player.size / 2)

    right_player = {}
    right_player.x = 1190
    right_player.size = 200
    right_player.y = height / 2 - (right_player.size / 2)

    ball = {}
    ball.width = 20
    ball.height = 20
    ball.x = width / 2 - (ball.width / 2)
    ball.y = height / 2 - (ball.height / 2)
    ball.x_speed = 2
    ball.y_speed = 2

    check_collision = function(x1, y1, w1, h1, x2, y2, w2, h2)
        return x1 < (x2 + w2) and
               x2 < (x1 + w1) and
               y1 < (y2 + h2) and
               y2 < (y1 + h1)
    end
end

function love.update(dt)
    if love.keyboard.isDown("w") then
        left_player.y = left_player.y - 3
    end
    if love.keyboard.isDown("s") then
        left_player.y = left_player.y + 3
    end

    if love.keyboard.isDown("up") then
        right_player.y = right_player.y - 3
    end
    if love.keyboard.isDown("down") then
        right_player.y = right_player.y + 3
    end

    if check_collision(ball.x, ball.y, ball.width, ball.height, left_player.x, left_player.y, 40, left_player.size)
    or check_collision(ball.x, ball.y, ball.width, ball.height, right_player.x, right_player.y, 40, right_player.size) then
        ball.x_speed = ball.x_speed * -1
    end

    ball.x = ball.x + ball.x_speed
    ball.y = ball.y + ball.y_speed

    if ball.y + ball.height >= height or ball.y <= 0 then
        ball.y_speed = ball.y_speed * -1
    end
end

function love.draw()
    love.graphics.rectangle("fill", left_player.x, left_player.y, 40, left_player.size)
    love.graphics.rectangle("fill", right_player.x, right_player.y, 40, right_player.size)
    love.graphics.rectangle("fill", ball.x, ball.y, ball.width, ball.height)
end
