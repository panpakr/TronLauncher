local composer = require("composer")
local Gesture = require("libraries.lib_gesture")
local scene = composer.newScene()


--local myText = display.newText("Result: ", 50, 50, native.systemFont, 32)
--myText:setTextColor(255, 255, 255)
-- shows touch location
local circle

local pointsTable = {}
local line


local W, H = display.contentWidth, display.contentHeight
local H_CENTER, V_CENTER = W*0.5, H*0.5

local view, tap

local function drawLine ()

	if (line and #pointsTable > 2) then
		line:removeSelf()
	end

	local numPoints = #pointsTable
	local nl = {}
	local  j, p

	nl[1] = pointsTable[1]

	j = 2
	p = 1

	for  i = 2, numPoints, 1  do
		nl[j] = pointsTable[i]
		j = j+1
		p = i
	end

	if ( p  < numPoints -1 ) then
		nl[j] = pointsTable[numPoints-1]
	end

	if #nl > 2 then
			line = display.newLine(nl[1].x,nl[1].y,nl[2].x,nl[2].y)
			for i = 3, #nl, 1 do
				line:append( nl[i].x,nl[i].y);
			end
			line:setColor(255,255,0)
			line.width=5
	end
end

local function Update(event)
	if "began" == event.phase then
		pointsTable = nil
		pointsTable = {}
		local pt = {}
		pt.x = event.x
		pt.y = event.y
		table.insert(pointsTable,pt)

	elseif "moved" == event.phase then

		local pt = {}
		pt.x = event.x
		pt.y = event.y
		table.insert(pointsTable,pt)

	elseif "ended" == event.phase or "cancelled" == event.phase then
			--drawLine ()
			if (Gesture.GestureResult() =="O") then
        composer.gotoScene( "screenlock.lockscreen" )
      end
	end
end



local function gestureEvent_handler( event )
  -- print( "gestureEvent_handler", event.target.id, event.phase )
  if event.type == event.target.GESTURE then

    print("Event Started")
    if event.phase=='began' then


    elseif event.phase=='changed' then

    else

    end

      composer.gotoScene( "screenlock.lockscreen" )
  end
end



function scene:create(event)


  local sceneGroup = self.view


  background = display.newImageRect( sceneGroup , "prelock/prelock.png", W,H)
  background.x = display.contentCenterX
  background.y = display.contentCenterY


  -- create touch area for gestures
  --view = display.newRect( sceneGroup,H_CENTER+10, V_CENTER-10, 150,250)
	--view.alpha = 0.1


end

function scene:show(event)

  local sceneGroup = self.view
  local phase = event.phase

  if (phase =="will") then

  elseif(phase == "did")  then

     Runtime:addEventListener( "touch"		, Update )
      -- create a gesture, link to touch area
      --pan = Gesture.newPanGesture( view, { touches=1, id="1 pan" })
    --  pan:addEventListener( pan.EVENT, gestureEvent_handler )

  end

end

function scene:hide(event)
   local sceneGroup = self.view
   local phase = event.phase

   if (phase =="will") then
     --line:removeSelf()
     --pan:removeEventListener( pan.EVENT, gestureEvent_handler )

   elseif(phase == "did")  then

   end

end

function scene:destroy(event)
   local sceneGroup = self.view

end

scene:addEventListener("create",scene)
scene:addEventListener("show",scene)
scene:addEventListener("hide",scene)
scene:addEventListener("destroy",scene)

return scene
