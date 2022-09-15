Score = Class {}

function Score:init()
    self.score = {
        0,
        0
    }
    self.scoreBigFont = love.graphics.newFont("assets/font.ttf", 32)
    self.scoreSmallFont = love.graphics.newFont("assets/font.ttf", 16)
end

function Score:update(id)
    self.score[id] = self.score[id] + 1
end

function Score:reset()
    self.score = { 0, 0 }
end

function Score:render()
    love.graphics.setFont(self.scoreBigFont)
    love.graphics.printf("SCORE", 0, 30, GAME_WIDTH, "center");
    love.graphics.setFont(self.scoreSmallFont)
    love.graphics.printf("PLAYER 1\n" .. tostring(self.score[1]), 0, 50, GAME_WIDTH / 2, "center");
    love.graphics.printf("PLAYER 2\n" .. tostring(self.score[2]), GAME_WIDTH / 2, 50, GAME_WIDTH / 2, "center");
end
