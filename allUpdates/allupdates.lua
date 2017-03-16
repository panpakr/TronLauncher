local composer = require("composer")
local mui = require( "materialui.mui" )
local Gesture = require ("dmc_corona.dmc_gestures")
local widget = require( "widget" )
local backStack = require("backstack")

local scene = composer.newScene()

local W, H = display.contentWidth, display.contentHeight
local H_CENTER, V_CENTER = W*0.5, H*0.5

local scrollView ,updateSummary ,background

local function goToHome()
  composer.removeScene("home.home")
  composer.gotoScene("home.home" ,{effect = "slideRight" ,time = 400})
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
       print("updateSummary : " ..updateSummary.y )
      if(event.limitReached) then

      else

       if( updateSummary.y >1592) then

       else

         if(event.direction == "up" ) then
         updateSummary.y = updateSummary.y -1
         elseif ( event.direction == "down" ) then
         updateSummary.y = updateSummary.y +1
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
    end

    return true
end





function scene:create(event)

  local sceneGroup = self.view

  local summary_height = 3205

  updateSummary = display.newImageRect( sceneGroup , "allUpdates/update_sum.png", W,summary_height)
  updateSummary.x = display.contentCenterX
  updateSummary.y = summary_height* 0.5 -10

  background = display.newImageRect( sceneGroup , "allUpdates/update_top.png", W,278)
  background.x = display.contentCenterX
  background.y = 200


  searchbar = display.newRect( sceneGroup,H_CENTER, 150, W-50,100)
  searchbar.alpha = 0.01
  --searchbar.fill ={1,0,1}


    -- Create the widget
   scrollView = widget.newScrollView(
        {
            top = 280,
            left = 0,
            width = display.contentWidth,
            height = display.contentHeight,
            scrollWidth = display.contentWidth,
            scrollHeight = summary_height - background.y  ,
            horizontalScrollDisabled  = true,
            listener = scrollListener
        }
    )

  scrollView:insert(updateSummary)

  sceneGroup:insert(scrollView)

  homegesture = display.newRect( sceneGroup,40, V_CENTER, H_CENTER, H)
  homegesture.alpha = 0.1



 --[[
  local background = display.newImageRect( sceneGroup , "allUpdates/updates.png", 360,640)
  background.x = display.contentCenterX
  background.y = display.contentCenterY




  sceneGroup:insert(background)
]]

end

function scene:show(event)

  local sceneGroup = self.view
  local phase = event.phase

  if (phase =="will") then


  elseif(phase == "did")  then
    pan = Gesture.newPanGesture( homegesture, { touches=1, id="1 pan" } )
    pan:addEventListener( pan.EVENT, home_handler )

    backStack:push("allUpdates.allupdates")

    tapOnSearch = Gesture.newTapGesture( searchbar, { id="1 tch 1 tap" }  )
  	tapOnSearch:addEventListener( tapOnSearch.EVENT, search_handler )


  end

end

function scene:hide(event)
   local sceneGroup = self.view
   local phase = event.phase

   if (phase =="will") then
    pan:removeEventListener( pan.EVENT,home_handler )
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
