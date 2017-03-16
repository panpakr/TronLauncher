local composer = require("composer")
local mui = require( "materialui.mui" )

local widget = require( "widget" )

local gesture = require("libraries.lib_gesture")
local Gesture = require ("dmc_corona.dmc_gestures")
local backStack = require("backstack")

local scene = composer.newScene()

local circle

local pointsTable = {}
local line

local W, H = display.contentWidth, display.contentHeight
local H_CENTER, V_CENTER = W*0.5, H*0.5

local function goToHome()
  composer.removeScene("home.home")
  composer.gotoScene("home.home" ,{effect = "slideLeft" ,time = 400})
end

local function goToSearch()
  composer.removeScene( "search.search" )
  composer.gotoScene("search.search" ,{effect = "slideDown" ,time = 400})
end

local function search_handler( event )
  print( "gestureEvent_handler", event.target.id, event.phase )
  if event.type == event.target.GESTURE then
      goToSearch()
  end
end

local searchbar,tapOnSearch

local background
local timelineSummary
local pan

--local myText = display.newText("Result: ", 50, 50, native.systemFont, 32)
--myText:setTextColor(255, 255, 255)

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
    --  myText.text = gesture.GestureResult()
			if (gesture.GestureResult() == "SwipeL") then
        goToHome()
        --composer.gotoScene( "screenlock.lockscreen" )
      end
	end
end

local function home_handler( event )
  -- print( "gestureEvent_handler", event.target.id, event.phase )
  if event.type == event.target.GESTURE then

    print("Event Started")
    if event.phase=='began' then
      --circle = display.newCircle( event.x, event.y, 10 )

    elseif event.phase=='changed' then
       goToHome()
    --  circle.x, circle.y = event.x, event.y
    else
    --  if circle then circle:removeSelf() ; circle=nil end

    end

  end
end

-- ScrollView listener
local function scrollListener( event )

    local phase = event.phase

    if ( phase == "began" ) then print( "Scroll view was touched" )

    elseif ( phase == "moved" ) then print( "Scroll view was moved" )
      print("timelineSummary.y: " ..timelineSummary.y .."timelineSummary.x " .. timelineSummary.x)

        if(event.limitReached) then

        else

         if( timelineSummary.y >1098 ) then

         else
            offset = event.y- event.yStart
            if(event.direction == "up" ) then
            timelineSummary.y = timelineSummary.y -1
            elseif ( event.direction == "down" ) then
            timelineSummary.y = timelineSummary.y +1
            end
         end
        end



    elseif ( phase == "ended" ) then print( "Scroll view was released" )

    end


    -- In the event a scroll limit is reached...
    if ( event.limitReached ) then
        if ( event.direction == "up" ) then print( "Reached bottom limit" )
        elseif ( event.direction == "down" ) then print( "Reached top limit" )
        elseif ( event.direction == "left" ) then print( "Reached right limit" )
        elseif ( event.direction == "right" ) then print( "Reached left limit" )
        end


    return true
end
end


local scrollView


function scene:create(event)

  local sceneGroup = self.view
  --mui.init(nil, { parent=self.view })


  local summary_height = 7139

  timelineSummary = display.newImageRect( sceneGroup , "timeline/timeline_summary.png", W,summary_height)
  timelineSummary.x = display.contentCenterX
  timelineSummary.y = summary_height* 0.5 -20

  background = display.newImageRect( sceneGroup , "timeline/timeline_top.png", W,553)
  background.x = display.contentCenterX
  background.y =  260--display.contentCenterY-250

  searchbar = display.newRect( sceneGroup,H_CENTER, 175, W-50,100)
  searchbar.alpha = 0.01
  --searchbar.fill ={1,0,1}


    -- Create the widget
   scrollView = widget.newScrollView(
        {
            top = 538,
            left = 1,
            width = display.contentWidth,
            height = display.contentHeight,
            scrollWidth = 100,--display.contentWidth-100,
            scrollHeight = summary_height - background.y  ,
            horizontalScrollDisabled  = true,
            listener = scrollListener
        }
    )

  scrollView:insert( timelineSummary )

  sceneGroup:insert(scrollView)

  homegesture = display.newRect( sceneGroup,950, V_CENTER, 200, H)
  --homegesture.fill = {1,0,0}
  homegesture.alpha = 0.01


end

function scene:show(event)

  local sceneGroup = self.view
  local phase = event.phase

  if (phase =="will") then

  elseif(phase == "did")  then
  --  Runtime:addEventListener( "touch"		, Update )
    pan = Gesture.newPanGesture( homegesture, { touches=1, id="1 pan" } )
    pan:addEventListener( pan.EVENT, home_handler )
    backStack:push("timeline.timeline")

    tapOnSearch = Gesture.newTapGesture( searchbar, { id="1 tch 1 tap" }  )
  	tapOnSearch:addEventListener( tapOnSearch.EVENT, search_handler )

  end

end

function scene:hide(event)
   local sceneGroup = self.view
   local phase = event.phase

   if (phase =="will") then
   --pan:removeEventListener( pan.EVENT,home_handler )
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
