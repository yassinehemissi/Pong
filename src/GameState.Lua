GameState = Class {}

function GameState:init(state)
    self.currentState = state
end

function GameState:update()
    if (self.currentState == "start") then
        self.currentState = "play"
    elseif (self.currentState == "play") then
        self.currentState = "start"
    end
end
