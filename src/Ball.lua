Ball = Class {}

local function getRandomPosition(side)
    local y = math.random(20, GAME_HEIGHT - 20)
    local x;
    if (side == "left") then
        x = 30
    elseif (side == "right") then
        x = GAME_WIDTH - 40
    end
    return { x = x, y = y }
end

local function returnAngle(side, ball_x, ball_y)
    local v = getRandomPosition(side)
    local angle = math.atan2(ball_y - v.y, ball_x - v.x);
    return angle
end

function Ball:init(x, y, radius, color)
    self.x = x
    self.y = y
    self.radius = radius
    self.color = color
    local angle = returnAngle(math.random(0, 1) == 0 and "right" or "left", self.x, self.y)
    self.dy = -math.sin(angle)
    self.dx = -math.cos(angle)

end

function Ball:render()
    love.graphics.setColor(self.color.r, self.color.g, self.color.b, self.color.a)
    love.graphics.circle("fill", self.x, self.y, self.radius)
    love.graphics.setColor(1, 1, 1, 1)
end

-- Allows calculating the reflection angle based
-- on the ball y collision position relative to the
-- middle of the paddle
local function returnReflectionAngle(paddle_y, ball_y, ph)
    local paddle_mid_y = paddle_y + (ph / 2)
    local diff = paddle_mid_y - ball_y
    local nomalized_diff = diff / (ph / 2) -- gives value between [-1, 1]
    return MAX_REFLECTION_PADDLE_ANGLE * nomalized_diff
end

function Ball:collide(paddle_x1, paddle_y1, paddle_x2, paddle_y2, pw, ph)
    if (self.x <= paddle_x1 + pw and (self.y >= paddle_y1 and self.y <= paddle_y1 + ph)) then
        --local angle = returnAngle("right", self.x, self.y)
        self.x = paddle_x1 + pw + 5
        local reflection_angle = returnReflectionAngle(paddle_y1, self.y, ph)
        self.dx = math.cos(reflection_angle)
        self.dy = -math.sin(reflection_angle)
    elseif (self.x + 5 >= paddle_x2 and (self.y >= paddle_y2 and self.y <= paddle_y2 + ph)) then
        --local angle = returnAngle("left", self.x, self.y)
        local reflection_angle = returnReflectionAngle(paddle_y2, self.y, ph);
        self.x = GAME_WIDTH - 36
        self.dx = -math.cos(reflection_angle)
        self.dy = -math.sin(reflection_angle)
    end
end

function Ball:Scored()
    if (self.x >= GAME_WIDTH - 30) then
        self:reset()
        return 1;
    elseif (self.x <= 30) then
        self:reset()
        return 2;
    end
    return 0
end

function Ball:update(dt)
    if (love.keyboard.isDown("k")) then
        self:reset()
    end

    if (self.y >= GAME_HEIGHT - 5) then
        self.dy = -self.dy
        self.y = GAME_HEIGHT - 10
    elseif (self.y <= 0) then
        self.dy = -self.dy
        self.y = 10
    end

    self.x = self.x + self.dx * BALL_SPEED * dt
    self.y = self.y + self.dy * BALL_SPEED * dt
end

function Ball:reset()
    self.x = GAME_WIDTH / 2 - 5
    self.y = GAME_HEIGHT / 2 - 5
    local angle = returnAngle(math.random(0, 1) == 0 and "right" or "left", self.x, self.y)
    self.dy = -math.sin(angle)
    self.dx = -math.cos(angle)
end
