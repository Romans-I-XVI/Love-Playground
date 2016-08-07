Game:defineObject("control_gameplay",
	function(object)

		function object:onCreate(args)
			self.gamestart_timer = Timer.new()
			self.game_active = false
			self.countdown = 10
			self.colors = { 0xff0000, 0x00ff00, 0x0000ff, 0xffff00}
		end

		function object:onDrawBegin()
			local center_x = love.graphics.getWidth()/2
			local center_y = love.graphics.getHeight()/2
			if not self.game_active then
				love.graphics.setColor(255, 255, 255, 255)
				love.graphics.print("Game Starts In", center_x, center_y - 20)
				love.graphics.print(tostring(self.countdown-math.floor(self.gamestart_timer:getTotalSeconds())), center_x, center_y)
			end

			-- This is temporary and will be deleted --
			if self.game_active then
				if #self.buttons > 0 then
					for i=1,4 do
						local color = self.buttons[i].color
						if color == 0xff0000 then
							love.graphics.setColor(255, 0, 0, 255)
						elseif color == 0x00ff00 then
							love.graphics.setColor(0, 255, 0, 255)
						elseif color == 0x0000ff then
							love.graphics.setColor(0, 0, 255, 255)
						elseif color == 0xffff00 then
							love.graphics.setColor(255, 255, 0, 255)
						end
						love.graphics.circle("fill", 50+100*i, 100, 20, 20)
					end
				end

				for i=1,4 do
					color = self.colors[i]
					score = self.scores[color]
					if color == 0xff0000 then
						love.graphics.setColor(255, 0, 0, 255)
					elseif color == 0x00ff00 then
						love.graphics.setColor(0, 255, 0, 255)
					elseif color == 0x0000ff then
						love.graphics.setColor(0, 0, 255, 255)
					elseif color == 0xffff00 then
						love.graphics.setColor(255, 255, 0, 255)
					end
					love.graphics.print(score, 50+100*i, 400)
				end
			end
			-- This is temporary and will be deleted --
		end

		function object:onUpdate(dt)
			if not self.game_active and self.countdown-self.gamestart_timer:getTotalSeconds() <= 0 then
				self:ResetGame()
			end
		end

		function object:CreateButtons()
			local inputs = { "1", "2", "3", "4"}
			for i=1,4 do
				local button = Game:createInstance("playground_button", {input = inputs[i]})
				print(button)
				table.insert(self.buttons, button)
			end
		end

		function object:ResetGame()
			Game:destroyAllInstances("control_end_game")
			self.game_active = true
			self.buttons = {}
			self.scores = {}
			for i=1,#self.colors do
				self.scores[self.colors[i]] = 0
			end
			self:CreateButtons()
			self:ChangeButtonColors()
		end

		function object:ChangeButtonColors()
			local colors = {}
			for i=1,#self.colors do
				table.insert(colors, self.colors[i])
			end

			for i=1,4 do
				local old_color = self.buttons[i].color
				local new_color = old_color
				local index = nil
				local attempts = 0
				-- This is hackish and needs to be reconsidered
				-- It currently tries to make a color always change
				-- to something different and random, but sometimes is not possible
				while old_color == new_color and attempts < 20 do
					index = math.random(#colors)
					new_color = colors[index]
					attempts = attempts + 1
				end
				table.remove(colors, index)
				self.buttons[i]:SetColor(new_color)
			end
		end

		function object:IncrementScore(color)
			self.scores[color] = self.scores[color] + 1
			if self.scores[color] == 10 then
				Game:destroyAllInstances("playground_button")
				Game:createInstance("control_end_game", {color = color})
				self.game_active = false
				self.gamestart_timer:mark()
			end
		end

	end
)