Game:defineObject("playground_button",
	function(object)

		function object:onCreate(args)
			self.flash = {
				timer = Timer.new(),
				frequency = 100,
				count = 0,
				current_count = 0
			}
			self.input = args.input
			self.color = 0xffffff
			self.active = true
		end

		function Object:onKeyPress(key)
			if key == self.input then
				local control_gameplay = Game:getInstanceByName("control_gameplay")
				control_gameplay:IncrementScore(self.color)
				control_gameplay:ChangeButtonColors()
			end
		end

		function object:onDrawBegin()
		end

		function object:onUpdate(dt)
			-- Handle flashing if necessary
			if self.flash.current_count < self.flash.count then
				if self.active then
					if self.flash.timer:getTotalMilliseconds() >= self.flash.frequency/2 then
						self:LightActive(false)
					end
				else
					if self.flash.timer:getTotalMilliseconds() >= self.flash.frequency then
						self:LightActive(true)
						self.flash.current_count = self.flash.current_count+1
						self.flash.timer:mark()
					end
				end
			end
		end

		function object:Flash(count, frequency)
			self.flash.timer:mark()
			self.flash.current_count = 0
			self.flash.count = count or 3
			self.flash.frequency = frequency or 100
		end

		function object:SetColor(color)
			self.color = color
			-- Some code to change the light color here
		end

		function object:LightActive(active)
			self.active = active
			if active then
				-- Some code to turn the light on here
			else
				-- Some code to turn the light off here
			end
		end



	end
)