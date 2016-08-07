Game:defineObject("control_end_game",
	function(object)

		function object:onCreate(args)
			self.color = args.color
			self.color_text = {}
			self.color_text[ 0xff0000 ] = "Red"
			self.color_text[ 0x00ff00 ] = "Green"
			self.color_text[ 0x0000ff ] = "Blue"
			self.color_text[ 0xffff00 ] = "Yellow"
		end

		function object:onDrawBegin()
			local center_x = love.graphics.getWidth()/2
			local center_y = love.graphics.getHeight()/2
			control_gameplay = Game:getInstanceByName("control_gameplay")
			if self.color == 0xff0000 then
				love.graphics.setColor(255, 0, 0, 255)
			elseif self.color == 0x00ff00 then
				love.graphics.setColor(0, 255, 0, 255)
			elseif self.color == 0x0000ff then
				love.graphics.setColor(0, 0, 255, 255)
			elseif self.color == 0xffff00 then
				love.graphics.setColor(255, 255, 0, 255)
			end
			love.graphics.print(self.color_text[self.color].." Wins!", center_x, center_y-50)
		end

	end
)