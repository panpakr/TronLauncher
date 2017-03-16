local composer = require("composer")
local Gesture = require ("dmc_corona.dmc_gestures")
local backStack = require("backstack")

local scene = composer.newScene()


local background

local function goToHome()
  composer.removeScene("home.home")
  composer.gotoScene("home.home" ,{effect = "fade" ,time = 500})
end

local function goToWebSearch()
  composer.removeScene("search.websearch")
  composer.gotoScene("search.websearch" ,{effect = "crossFade" ,time = 500})
end

-- shows touch location
local circle

local W, H = display.contentWidth, display.contentHeight
local H_CENTER, V_CENTER = W*0.5, H*0.5

local webview, backview, tap

local function gestureEvent_handler( event )
  print( "gestureEvent_handler", event.target.id, event.phase ,event.name )
  if event.type == event.target.GESTURE then

    --print( "gestureEvent_handler",event.target.id  )
    print("Event Started")
    if event.phase=='began' then


    elseif event.phase=='changed' then

    else


    end

      if(event.target.id == "1 tch 1 tap")then
         goToWebSearch()
      end

      if(event.target.id == "1 pan")then
         goToHome()
      end
  end
end



function scene:create(event)

  local sceneGroup = self.view

  background = display.newImageRect( sceneGroup , "search/local_search.png", W,H)
  background.x = display.contentCenterX
  background.y = display.contentCenterY

  -- create touch area for gestures
  webview= display.newRect( sceneGroup,H_CENTER+265, V_CENTER +330,H*0.28,150)
  webview.alpha = 0.01--0.1

  -- create touch area for gestures
  backview = display.newRect( sceneGroup,H_CENTER, V_CENTER +180, 100,100)
  backview.alpha = 0.5


end

function scene:show(event)

  local sceneGroup = self.view
  local phase = event.phase

  if (phase =="will") then

  elseif(phase == "did")  then
    backStack:push("search.search")
    -- create a touch gestures, link to shape

  pan = Gesture.newPanGesture( backview, { touches=1, id="1 pan" ,name = "backview"})
  pan:addEventListener( pan.EVENT, gestureEvent_handler )

  tap = Gesture.newTapGesture(   webview, { id="1 tch 1 tap" ,name = "webview"})
	tap:addEventListener( tap.EVENT, gestureEvent_handler )

  end

end

function scene:hide(event)
   local sceneGroup = self.view
   local phase = event.phase

   if (phase =="will") then
     pan:removeEventListener( pan.EVENT, gestureEvent_handler )
     tap:removeEventListener( tap.EVENT, gestureEvent_handler )

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
