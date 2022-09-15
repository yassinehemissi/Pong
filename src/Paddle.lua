Paddle = Class {}




CONTROL_KEYS = {
    --PLAYER 1
    {
        UP = "up",
        DOWN = "down"
    },
    --PLAYER 2
    {
        UP = "z",
        DOWN = "s"
    }
}

function Paddle:init(id, x, y, width, height, color)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.dy = 0
    self.color = color
    self.id = id
end

function Paddle:render()
    love.graphics.setColor(self.color.r, self.color.g, self.color.b, self.color.a)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height);
    love.graphics.setColor(1, 1, 1, 1)
end

function Paddle:update(dt)
    if (love.keyboard.isDown(CONTROL_KEYS[self.id].UP)) then
        local new_y = self.y - PADDLE_SPEED * dt;
        self.y = math.max(MIN_Y_POSITION, new_y)
    elseif (love.keyboard.isDown(CONTROL_KEYS[self.id].DOWN)) then
        local new_y = self.y + PADDLE_SPEED * dt;
        self.y = math.min(GAME_HEIGHT - MIN_Y_POSITION - self.height, new_y)
    end
end
