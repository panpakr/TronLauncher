local composer = require("composer")
local Gesture = require ("dmc_corona.dmc_gestures")

local scene = composer.newScene()


local background

local function goToHome()
  composer.removeScene( "home.home" )
  composer.gotoScene("home.home" ,{effect = "slideDown" ,time = 400})
end

local function goToCreateCollection()
  composer.removeScene( "appDrawer.collection.createcollection" )
  composer.gotoScene("appDrawer.collection.createcollection" ,{effect = "crossFade" ,time = 100})
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


local W, H = display.contentWidth, display.contentHeight
local H_CENTER, V_CENTER = W*0.5, H*0.5

local home, createButton, tapOnCreate ,tapOnHome

local function home_handler( event )
  print( "gestureEvent_handler", event.target.id, event.phase ,event.name )
  if event.type == event.target.GESTURE then
     goToHome()

  end
end

local function create_handler( event )
  print( "gestureEvent_handler", event.target.id, event.phase ,event.name )
  if event.type == event.target.GESTURE then
    goToCreateCollection()

  end
end

local searchbar,tapOnSearch

function scene:create(event)

  local sceneGroup = self.view

  local background = display.newImageRect( sceneGroup , "appDrawer/appdrawer.png", W,H)
  background.x = display.contentCenterX
  background.y = display.contentCenterY

  -- create touch area for gestures
  home= display.newRect( sceneGroup,H_CENTER+2, 290,110,110)
  --home.fill = {1,0,1}
  home.alpha = 0.01

  createButton= display.newRect( sceneGroup,H_CENTER +10, V_CENTER- 60,H*0.36,70)
  --createButton.fill = {1,0,1}
  createButton.alpha = 0.01

  searchbar = display.newRect( sceneGroup,H_CENTER, 170, W-50,100)
  searchbar.alpha = 0.01
  --searchbar.fill ={1,0,1}



end

function scene:show(event)

  local sceneGroup = self.view
  local phase = event.phase

  if (phase =="will") then

  elseif(phase == "did")  then

    tapOnSearch = Gesture.newTapGesture( searchbar, { id="1 tch 1 tap" }  )
    tapOnSearch:addEventListener( tapOnSearch.EVENT, search_handler )
    -- create a touch gestures, link to shape


--  tapOnHome = Gesture.newTapGesture(   home, { id="1 tch 1 tap" })
	--tapOnHome:addEventListener( tapOnHome.EVENT, home_handler )

  --tapOnHome =Gesture.newPanGesture( home, { touches=1, id="1 pan" } )
  --tapOnHome :addEventListener( tapOnHome.EVENT, home_handler )


  --tapOnCreate = Gesture.newTapGesture(   createButton, { id="1 tch 1 tap" })
  --tapOnCreate:addEventListener( tapOnCreate.EVENT, create_handler)

  end

end

function scene:hide(event)
   local sceneGroup = self.view
   local phase = event.phase

   if (phase =="will") then

     --tapOnHome:removeEventListener( tapOnHome.EVENT, home_handler )
     --tapOnCreate:removeEventListener( tapOnCreate.EVENT, create_handler )

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
