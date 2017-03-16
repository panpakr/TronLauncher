local composer = require("composer")
local Gesture = require ("dmc_corona.dmc_gestures")
local widget = require( "widget" )
local slideView = require("screenlock.Zunware_SlideView")
local backStack = require("backstack")


local scene = composer.newScene()

local function goToHome()
  composer.removeScene("home.home")
  composer.gotoScene("home.home" ,{effect = "crossFade" ,time = 500})
end

  local background
  local widgetPane

  local W, H = display.contentWidth, display.contentHeight
  local H_CENTER, V_CENTER = W*0.5, H*0.5

  local view, tap

  local function gestureEvent_handler( event )
    -- print( "gestureEvent_handler", event.target.id, event.phase )
    if event.type == event.target.GESTURE then

      print("Event Started")
      if event.phase=='began' then

      elseif event.phase=='changed' then

      else

      end
       goToHome()
    end
  end


  -- ScrollView listener
  local function scrollListener( event )

      local phase = event.phase
      if ( phase == "began" ) then print( "Scroll view was touched" )

      elseif ( phase == "moved" ) then print( "Scroll view was moved" )


      elseif ( phase == "ended" ) then print( "Scroll view was released" )
          if(( event.direction == "left" )) then
           --transition.moveTo( widgetPane, {x=200 } )
         end

      end

      -- In the event a scroll limit is reached...
      if ( event.limitReached ) then
          if ( event.direction == "up" ) then print( "Reached bottom limit" )
          elseif ( event.direction == "down" ) then print( "Reached top limit" )
          elseif ( event.direction == "left" ) then print( "Reached right limit" )
          elseif ( event.direction == "right" ) then print( "Reached left limit" )
          end
      end

      return true
  end



  -- Handle press events for the checkbox
  local function onSwitchPress( event )
      local switch = event.target
      print( "Switch with ID '"..switch.id.."' is on: "..tostring(switch.isOn) )
  end

function scene:create(event)

  local sceneGroup = self.view
  local widgetPane_width = 2160

  background = display.newImageRect( sceneGroup , "screenlock/lock_screen.png", 1080,1920)
  background.x = display.contentCenterX
  background.y = display.contentCenterY


  -- Image sheet options and declaration
  local options = {
      width = 40,
      height = 40,
      numFrames = 2,
      sheetContentWidth = 40,
      sheetContentHeight =80
  }
  local checkSheet = graphics.newImageSheet( "appDrawer/collection/checksheet.png", options )
--[[  -- Create the widget
  local checkbox = widget.newSwitch(
      {
          left = 250,
          top = 200,
          style = "checkbox",
          id = "Checkbox",
          width = 40,
          height = 40,
          onPress = onSwitchPress,
          sheet = checkSheet,
          frameOff = 1,
          frameOn = 2
      }
  )
]]
local widgets = {
	"screenlock/widgetPane1.png",
	"screenlock/widgetPane2.png",
}


local widgetPane = slideView.new(widgets, nil)
widgetPane.y = -260

 sceneGroup:insert(widgetPane )

--[[
  -- Create the widget
 scrollView = widget.newScrollView(
      {
          top = 500,
          left = 95,
          width = 890 ,--display.contentWidth -190,
          height = display.contentHeight -1470,
          scrollWidth = 0,--widgetPane_width -600,
          scrollHeight =  display.contentHeight -200  ,
          horizontalScrollDisabled  = false,
          listener = scrollListener
      }
  )

 scrollView:insert(widgetPane)
 scrollView.alpha = 0.85

 sceneGroup:insert(scrollView)

]]
  -- create touch area for gestures
  view = display.newRect( sceneGroup,H_CENTER, H-130, 80,90)
  view.alpha = 0.01


--  background:addEventListener("touch" ,navigate)
end

function scene:show(event)

  local sceneGroup = self.view
  local phase = event.phase

  if (phase =="will") then

  elseif(phase == "did")  then


    -- create a touch gestures, link to shape

	pan = Gesture.newPanGesture( view, { touches=1, id="1 pan" } )
	pan:addEventListener( pan.EVENT, gestureEvent_handler )

  end

end

function scene:hide(event)
   local sceneGroup = self.view
   local phase = event.phase

   if (phase =="will") then
    	pan:removeEventListener( pan.EVENT, gestureEvent_handler )



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
