-- Author: MYH
-- Using Love2D

-- Importing Libraries
Class = require "lib/class"
Push = require "lib/push"

-- Importing Classes
require "src/GameState"
require "src/Paddle"
require "src/Ball"
require "src/Score"
require "src/Text"

-- Declaring Constants --

-- Screen Constants
WINDOW_WIDTH = 1200
WINDOW_HEIGHT = 700
GAME_WIDTH = 700
GAME_HEIGHT = 500
SCREEN_FLAGS = {
    fullscreen = false,
    resizable = true,
    vsync = true,
    canvas = false
}

-- Ball Settings
BALL_SPEED = 300
MAX_REFLECTION_PADDLE_ANGLE = math.pi / 3 -- 60 degree in radians

-- Paddle Settings
MIN_Y_POSITION = 10
PADDLE_SPEED = 300



local function updateScreenSize()
    local width, height = love.window.getMode()
    if (WINDOW_WIDTH == width and WINDOW_HEIGHT == height) then
        return
    end
    WINDOW_WIDTH = width
    WINDOW_HEIGHT = height
    Push:resize(WINDOW_WIDTH, WINDOW_HEIGHT)
end

-- Load Function
function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')

    TheGameSate = GameState("start")

    WelcomeText = Text("assets/font.ttf", 40, 0, GAME_HEIGHT / 2 - 20, GAME_WIDTH, "WELCOME TO PONG!", "center", false)
    StartText = Text("assets/font.ttf", 40, 0, GAME_HEIGHT / 2 + 20, GAME_WIDTH, "PRESS ENTER TO START", "center", true,
        60)
    CreditText = Text("assets/font.ttf", 13, 0, GAME_HEIGHT - 20, GAME_WIDTH, "Made by MYH", "center", false)

    GameBall = Ball(GAME_WIDTH / 2 - 5, GAME_HEIGHT / 2 - 5, 5, { r = 0, g = 1, b = 0, a = 1 })

    Paddle1 = Paddle(1, 30, 20, 10, 60, { r = 0, g = 1, b = 0, a = 1 })
    Paddle2 = Paddle(2, GAME_WIDTH - 30, GAME_HEIGHT - 90, 10, 60, { r = 0, g = 1, b = 0, a = 1 })

    GameScore = Score()

    Push:setupScreen(GAME_WIDTH, GAME_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, SCREEN_FLAGS);
end

function love.draw()
    Push:start()

    love.graphics.clear(0 / 255, 0 / 255, 0 / 255, 1)

    if (TheGameSate.currentState == "play") then
        GameScore:render()
    elseif (TheGameSate.currentState == "start") then
        StartText:render()
        WelcomeText:render()
    end
    CreditText:render()

    GameBall:render()
    Paddle1:render()
    Paddle2:render()


    Push:finish()
end

function love.update(dt)
    updateScreenSize()

    if (TheGameSate.currentState == "play") then
        local scored_id = GameBall:Scored()
        if (scored_id == 1 or scored_id == 2) then
            GameScore:update(scored_id)
        end
        GameBall:collide(Paddle1.x, Paddle1.y, Paddle2.x, Paddle2.y, Paddle1.width, Paddle1.height)
        GameBall:update(dt)
        Paddle1:update(dt)
        Paddle2:update(dt)
    end
end

function love.keypressed(key)
    if (key == 'enter' or key == 'return') then
        TheGameSate:update()
    end
end
