Text = Class {}


function Text:init(font_path, font_size, x, y, w, text, align, blink, blink_speed)
    self.font = love.graphics.newFont(font_path, font_size)
    self.x = x
    self.y = y
    self.w = w
    self.text = text
    self.align = align
    self.blink = blink
    self.speed = blink_speed == nil and 0 or blink_speed
    self.count = self.speed
end

function Text:render()
    if (self.blink) then
        if (self.count == self.speed) then
            self.count = self.count + 1
            love.graphics.setFont(self.font)
            love.graphics.printf(self.text, self.x, self.y, self.w, self.align)
        elseif (self.count == self.speed * 2) then
            self.count = 0
        elseif (self.count > self.speed) then
            self.count = self.count + 1
            love.graphics.setFont(self.font)
            love.graphics.printf(self.text, self.x, self.y, self.w, self.align)
        else
            self.count = self.count + 1
        end
    else
        love.graphics.setFont(self.font)
        love.graphics.printf(self.text, self.x, self.y, self.w, self.align)
    end
end
