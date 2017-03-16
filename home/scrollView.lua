-- scrollView.lua Scroll View Library
-- Version 0.2

module(..., package.seeall)

-- set some global values for width and height of the screen
local screenW, screenH = display.contentWidth, display.contentHeight
local viewableScreenW, viewableScreenH = display.viewableContentWidth, display.viewableContentHeight
local screenOffsetW, screenOffsetH = display.contentWidth -  display.viewableContentWidth, display.contentHeight - display.viewableContentHeight

local prevTime = 0

function new(params)
	-- setup a group to be the scrolling screen
	local scrollView = display.newGroup()

  --scrollView.start = params.top or 0
	scrollView.top = params.top or 0
  scrollView.x = 0
  --scrollView.width = 900
	scrollView.bottom = params.bottom or 0

	function scrollView:touch(event)
	        local phase = event.phase
	       -- print(phase)

	        if( phase == "began" ) then
	                self.startPos = event.x
	                self.prevPos = event.x
	                self.delta, self.velocity = 0, 0
		            if self.tween then transition.cancel(self.tween) end

	                Runtime:removeEventListener("enterFrame", scrollView )

					self.prevTime = 0
					self.prevX = 0

					-- Start tracking velocity
					Runtime:addEventListener("enterFrame", trackVelocity)

	                -- Subsequent touch events will target button even if they are outside the stageBounds of button
	               -- display.getCurrentStage():setFocus( self )
	                self.isFocus = true

	        elseif( self.isFocus ) then

	                if( phase == "moved" ) then
					        local bottomLimit = screenH - self.height - self.bottom

	                        self.delta = event.x - self.prevPos
	                        self.prevPos = event.x
	                       if ( self.x > self.top or self.x < bottomLimit ) then
                                self.x  = self.x + self.delta/2
	                        else
                                self.x = self.x + self.delta
	                        end
	                elseif( phase == "ended" or phase == "cancelled" ) then
	                        local dragDistance = event.x - self.startPos
							self.lastTime = event.time

	                        Runtime:addEventListener("enterFrame", scrollView )
	                        Runtime:removeEventListener("enterFrame", trackVelocity)


	                        -- Allow touch events to be sent normally to the objects they "hit"
	                      --  display.getCurrentStage():setFocus( nil )
	                        self.isFocus = false
	                end
	        end

	        return true
	end

	function scrollView:enterFrame(event)
		local friction = 2
		local timePassed = event.time - self.lastTime
		self.lastTime = self.lastTime + timePassed

        --turn off scrolling if velocity is near zero
       if math.abs(self.velocity) < .01 then
              self.velocity = 0
	            Runtime:removeEventListener("enterFrame", scrollView )
       end

        self.velocity = self.velocity*friction

        self.x = math.floor(self.x + self.velocity*timePassed)

        local upperLimit = self.top
	      local bottomLimit = screenH - self.height - self.bottom

        if ( self.x > upperLimit ) then
                self.velocity = 0
                Runtime:removeEventListener("enterFrame", scrollView )
                self.tween = transition.to(self, { time=400, y=upperLimit, transition=easing.outQuad})
        elseif ( self.x < bottomLimit and bottomLimit < 0 ) then
                self.velocity = 0
                Runtime:removeEventListener("enterFrame", scrollView )
                self.tween = transition.to(self, { time=400, y=bottomLimit, transition=easing.outQuad})
        elseif ( self.x < bottomLimit ) then
                self.velocity = 0
                Runtime:removeEventListener("enterFrame", scrollView )
                self.tween = transition.to(self, { time=400, y=upperLimit, transition=easing.outQuad})
        end

	    return true
	end


	function trackVelocity(event)
		local timePassed = event.time - scrollView.prevTime
		scrollView.prevTime = scrollView.prevTime + timePassed

		if scrollView.prevX then
			scrollView.velocity = (scrollView.x - scrollView.prevX)/timePassed
		end
		scrollView.prevX = scrollView.x
	end


	scrollView.x = scrollView.start

	-- setup the touch listener
	Runtime:addEventListener( "touch", scrollView )

	function scrollView:cleanUp()
    Runtime:removeEventListener("enterFrame", trackVelocity)
		Runtime:removeEventListener( "touch", scrollView )
		Runtime:removeEventListener("enterFrame", scrollView )
	end

	return scrollView
end
