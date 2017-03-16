local composer = require("composer")
local Gesture = require ("dmc_corona.dmc_gestures")

local scene = composer.newScene()


local background

local function goToHome()
  composer.removeScene( "home.home" )
  composer.gotoScene("home.home" ,{effect = "crossFade" ,time = 100})
end

local W, H = display.contentWidth, display.contentHeight
local H_CENTER, V_CENTER = W*0.5, H*0.5

local home ,tapOnHome

local function home_handler( event )
  print( "gestureEvent_handler", event.target.id, event.phase ,event.name )
  if event.type == event.target.GESTURE then
     goToHome()

  end
end




function scene:create(event)

  local sceneGroup = self.view

  local background = display.newImageRect( sceneGroup , "appDrawer/activity.png", W,H)
  background.x = display.contentCenterX
  background.y = display.contentCenterY

  -- create touch area for gestures
  home= display.newRect( sceneGroup,140, 170,200,150)
  --home.fill = {1,0,1}
  home.alpha = 0.01





end

function scene:show(event)

  local sceneGroup = self.view
  local phase = event.phase

  if (phase =="will") then

  elseif(phase == "did")  then

    -- create a touch gestures, link to shape


   tapOnHome = Gesture.newTapGesture(home, { id="1 tch 1 tap" })
	 tapOnHome:addEventListener( tapOnHome.EVENT, home_handler )


  end

end

function scene:hide(event)
   local sceneGroup = self.view
   local phase = event.phase

   if (phase =="will") then

    -- tapOnHome:removeEventListener( tapOnHome.EVENT, home_handler )


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
