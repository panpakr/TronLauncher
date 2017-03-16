local composer = require("composer")
local mui = require( "materialui.mui" )
local widget = require ("widget")
local drop_item = require "appDrawer.apps.drop_item"
local Gesture = require ("dmc_corona.dmc_gestures")
local scrollView = require("home.scrollView")
local backStack = require("backstack")

local scene = composer.newScene()
local physicsEngine = require( "physics" )
physicsEngine.start()
physicsEngine.setGravity(0,0)
physicsEngine.setScale(60)

local IMAGEWIDTH = 1912
local navigationFactor
local constantSpeed
local updatesList
local loopTimer

local MAXIMUM = -300
local MINIMUM
local velocity
local startPoint
local endPoint
local offset
local transition = 0
local transitionOffset
local count = -30
local moves
local fps = 30

local speed

local W, H = display.contentWidth, display.contentHeight
local H_CENTER, V_CENTER = W*0.5, H*0.5

local searchbar,  homegesture  ,appdrawer ,pan

local home_app1,home_app2,home_app3,home_app4,home_app5
local home_app6,home_app7,home_app8,home_app9,home_app10
local hotseat1,hotseat2,hotseat3,hotseat4,hotseat5

local function goToSearch()
  composer.removeScene( "search.search" )
  composer.gotoScene("search.search" ,{effect = "slideDown" ,time = 400})
end

local function goToAllUpdates()
  --composer.removeScene("allUpdates.allupdates" )
  composer.gotoScene("allUpdates.allupdates" ,{effect = "crossFade" ,time = 500})
end

local function goToTimeLine()
  composer.removeScene( "timeline.timeline" )
    composer.gotoScene( "timeline.timeline" ,{effect = "slideRight" ,time = 200})
end

local function goToAllApps()

  --composer.removeScene( "appDrawer.appsNavigation" )
  --composer.recycleOnSceneChange = false
--  composer.gotoScene("appDrawer.appsNavigation" ,{effect = "slideUp" ,time = 800})

  composer.removeScene( "appDrawer.appsdrawer" )
  composer.gotoScene("appDrawer.appsdrawer" ,{effect = "slideUp" ,time = 400})
end

local function goToActivity()
  composer.removeScene( "appDrawer.activity" )
  composer.gotoScene("appDrawer.activity" ,{effect = "crossFade" ,time = 400})
end

local function goToAppFeatures()
  composer.removeScene( "appDrawer.apps.applongpress" )
  composer.gotoScene("appDrawer.apps.applongpress" ,{effect = "crossFade" ,time = 200})
end



   local function timeline_handler( event )
     -- print( "gestureEvent_handler", event.target.id, event.phase )
     if event.type == event.target.GESTURE then

       print("Event Started")
       if event.phase=='began' then
         --circle = display.newCircle( event.x, event.y, 10 )

       elseif event.phase=='changed' then
          goToTimeLine()
       --  circle.x, circle.y = event.x, event.y
       else
       --  if circle then circle:removeSelf() ; circle=nil end

       end


     end
   end


   local function search_handler( event )
     print( "gestureEvent_handler", event.target.id, event.phase )
     if event.type == event.target.GESTURE then
         goToSearch()
     end
   end

   local function updates_Event( event )
      if ( "ended" == event.phase ) then
             print( "Button was pressed and released" )
             goToAllUpdates()
         end
   end

   local function allapps_handler( event )
     print( "gestureEvent_handler", event.target.id, event.phase )
     if event.type == event.target.GESTURE then
         goToAllApps()
     end
   end


   local function app_handler( event )
     print( "gestureEvent_handler", event.target.id, event.phase ,event.name )
     if event.type == event.target.GESTURE then
          goToActivity()
         if(event.id =="1 tch 1 tap") then
           goToActivity()
         end

         if(event.id == "1 tch 0 tap") then
           goToAppFeatures()
         end
     end
   end


local startTime =0
local function onDragDown( event )

    local offsetX,timeGap,offsetY
    if ( event.phase == "began" ) then
        --event.target.alpha = 0.5
        -- Set focus on object

      startTime = event.time
        display.getCurrentStage():setFocus( event.target )

    elseif ( event.phase == "ended" or event.phase == "cancelled" ) then
        --event.target.alpha = 1
        -- Release focus on object

        offsetX = event.xStart - event.x
        offsetY = event.yStart - event.y
        timeGap = event.time - startTime

        print("Time Difference :" ..timeGap .. " offsetX : " ..offsetX .." offsetY : " ..offsetY)

        if(offsetY <-60) then
          goToAllApps()
        end
        display.getCurrentStage():setFocus( nil )
    end
    return true
end




local backgroundGroup




updatesList = nil
-- Create the group
local slider = display.newGroup()

-- Setup a scrollable content group
local scroll

local function moveloop()

--print("updatesList.x : "..updatesList.x .." updatesList.contentWidth" ..updatesList.contentWidth)
  updatesList.x = updatesList.x - 5

if(updatesList.x <-1800) then --1215 = 285 + 570 +360
  --transition.to(updatesList,{time ,x= 2000})
  updatesList:translate(3000,0)
end

end




local function handletouch( event )


    if ( event.phase == "began" ) then
        Runtime:removeEventListener("enterFrame" ,moveloop)

    elseif(event.phase =="moved") then

    elseif ( event.phase == "ended" or event.phase == "cancelled" ) then
          Runtime:addEventListener("enterFrame" ,moveloop)
    end
    return true
end

function scene:create(event)

  local sceneGroup = self.view

  backgroundGroup = display.newGroup()
  sceneGroup:insert(backgroundGroup)
  uiGroup = display.newGroup()
  sceneGroup:insert(uiGroup)

  --physicsEngine.pause()
  local background = display.newImageRect( backgroundGroup , "home/home_background.png", W,H)
  background.x = display.contentCenterX
  background.y = display.contentCenterY

--home/home_background.png

  --  updatesList = display.newImageRect(uiGroup,"home/update.png",1912,180)
    --updatesList.x = IMAGEWIDTH/2 + display.contentWidth --956 ( half of width of image)
    --updatesList.y = display.contentCenterY - 69
    --updatesList.alpha = 0.01

    local button = widget.newButton(
        {
            width = 177,
            height = 120,
            defaultFile = "home/all_updates.png",
            overFile = "home/all_updates.png",
            onEvent = updates_Event
        }
    )

     button.x = H_CENTER +405
     button.y = 390

     backgroundGroup:insert(button)


    -- create touch area for gestures
    searchbar = display.newRect( sceneGroup,H_CENTER-10, 185, W-50,80)
    searchbar.alpha = 0.01

    home_app1 = drop_item.new("home_app1" , "home/home1.png")
    drop_item:setLocation(home_app1,H_CENTER-420, H-710)
    sceneGroup:insert(home_app1)
    drop_item:setSize(home_app1,125, 125)

    home_app2 = drop_item.new("home_app2" , "home/home2.png")
    drop_item:setLocation(  home_app2,H_CENTER-200, H-710)
    sceneGroup:insert(home_app2)
    drop_item:setSize(home_app2,125, 125)


    home_app3 = drop_item.new("home_app3" , "home/home3.png")
    drop_item:setLocation(  home_app3,H_CENTER, H-710)
    sceneGroup:insert(home_app3)
    drop_item:setSize(home_app3,125, 125)

    home_app4 = drop_item.new("home_app4" , "home/home4.png")
    drop_item:setLocation(home_app4, H_CENTER+220, H-710)
    sceneGroup:insert(home_app4)
    drop_item:setSize(home_app4,125, 125)

    home_app5 = drop_item.new("home_app5" , "home/home5.png")
    drop_item:setLocation(home_app5, H_CENTER+420, H-710)
    sceneGroup:insert(home_app5)
    drop_item:setSize(home_app5,125, 125)

    home_app6 = drop_item.new("home_app6" , "home/home6.png")
    drop_item:setLocation(home_app6, H_CENTER-420, H-470)
    sceneGroup:insert(home_app6)
    drop_item:setSize(home_app6,125, 125)

    home_app7 = drop_item.new("home_app7" , "home/home7.png")
    drop_item:setLocation(home_app7, H_CENTER-200, H-470)
    sceneGroup:insert(home_app7)
    drop_item:setSize(home_app7,125, 125)

    home_app8 = drop_item.new("home_app8" , "home/home8.png")
    drop_item:setLocation(home_app8, H_CENTER, H-470)
    sceneGroup:insert(home_app8)
    drop_item:setSize(home_app8,125, 125)

    home_app9 = drop_item.new("home_app9" , "home/home9.png")
    drop_item:setLocation(home_app9, H_CENTER+210, H-470)
    sceneGroup:insert(home_app9)
    drop_item:setSize(home_app9,125, 125)

    home_app10 = drop_item.new("home_app10" , "home/home10.png")
    drop_item:setLocation(home_app10, H_CENTER+420, H-470)
    sceneGroup:insert(home_app10)
    drop_item:setSize(home_app10,125, 125)



    hotseat1= drop_item.new("hotseat1" , "home/hotseat1.png")
    drop_item:setLocation(hotseat1, H_CENTER-420, H-250)
    sceneGroup:insert(hotseat1)
    drop_item:setSize(hotseat1,125, 125)

    hotseat2= drop_item.new("hotseat2" , "home/hotseat2.png")
    drop_item:setLocation(hotseat2, H_CENTER-200, H-250)
    sceneGroup:insert(hotseat2)
    drop_item:setSize(hotseat2,125, 125)


    appdrawer = display.newRect( sceneGroup,H_CENTER, H-250, 125,125)
    appdrawer.alpha =  0.01


    hotseat3= drop_item.new("hotseat3" , "home/hotseat3.png")
    drop_item:setLocation(hotseat3, H_CENTER, H-250)
    sceneGroup:insert(hotseat3)
    drop_item:setSize(hotseat3,125, 125)


    hotseat4= drop_item.new("hotseat4" , "home/hotseat4.png")
    drop_item:setLocation(hotseat4, H_CENTER+210, H-250)
    sceneGroup:insert(hotseat4)
    drop_item:setSize(hotseat4,125, 125)

    hotseat5= drop_item.new("hotseat5" , "home/hotseat5.png")
    drop_item:setLocation(hotseat5, H_CENTER+420, H-250)
    sceneGroup:insert(hotseat5)
    drop_item:setSize(hotseat5,125, 125)

    --physicsEngine.addBody(updatesList ,"dynamic")

     --constantSpeed = -50
     speed = -60
     velocity = -60





    --mui.init()
if(scroll~= nil )then
print("Display group  on create", scroll)
end

  scroll = scrollView.new{ top=0, bottom=0 }
  scroll.fill = {1,0,1}

  if(scroll~= nil )then
  print("Display group  on create",scroll)
  end
  updatesList = display.newImageRect(sceneGroup,"home/slide.png",4128,564)
  updatesList.x = IMAGEWIDTH/2 +2160--+ display.contentWidth --956 ( half of width of image)
  updatesList.y = display.contentCenterY-180
  updatesList.alpha = 1

  --scroll:insert( updatesList )
  --slider:insert(scroll)

  --background:addEventListener("tap",processOnTap)
  --backgroundGroup:addEventListener("touch" , navigateRightSwipe)
  homegesture = display.newRect( sceneGroup,50, V_CENTER, 100, H)
  homegesture.alpha = 0.6


end

function scene:show(event)

  local sceneGroup = self.view
  local phase = event.phase

  if (phase =="will") then



--[[
    if(scroll~= nil )then
    print("Display group  on show:will",scroll)
    --scroll = scrollView.new{ top=0, bottom=0 }
    end

    if(scroll== nil )then
    print("created Scroll Display group  on show:will",scroll)
    scroll = scrollView.new{ top=0, bottom=0 }
    end
]]
slider:toFront()
slider.isVisible = true



    Runtime:addEventListener("enterFrame" ,moveloop)
    --updatesList:addEventListener("tap",handletouch)


  elseif(phase == "did")  then

      backStack:push("home.home")

    --table.insert( backStack, "home.home" )
    backStack:display()

  drop_item:registerTouchGrestures(home_app1)
  drop_item:registerTouchGrestures(home_app2)
  drop_item:registerTouchGrestures(home_app3)
  drop_item:registerTouchGrestures(home_app4)
  drop_item:registerTouchGrestures(home_app5)
  drop_item:registerTouchGrestures(home_app6)
  drop_item:registerTouchGrestures(home_app7)
  drop_item:registerTouchGrestures(home_app8)
  drop_item:registerTouchGrestures(home_app9)
  drop_item:registerTouchGrestures(home_app10)
  drop_item:registerTouchGrestures(hotseat1)
  drop_item:registerTouchGrestures(hotseat2)
  drop_item:registerTouchGrestures(hotseat4)
  drop_item:registerTouchGrestures(hotseat5)

  if(scroll~= nil )then
  print("Display group  on show:Did",scroll)
  end

      -- physicsEngine.start()
       --loopTimer = timer.performWithDelay( 500,loop ,0)
       --updatesList:addEventListener("touch" , navigate)
       -- create a gesture, link to touch area

  pan = Gesture.newPanGesture( homegesture, { touches=1, id="1 pan" } )
  pan:addEventListener( pan.EVENT, timeline_handler )

  appdrawer:addEventListener("touch" ,onDragDown)

	tapOnSearch = Gesture.newTapGesture( searchbar, { id="1 tch 1 tap" }  )
	tapOnSearch:addEventListener( tapOnSearch.EVENT, search_handler )

  --tapOnApps =Gesture.newPanGesture( appdrawer, { touches=1, id="1 pan" } )
  --tapOnApps :addEventListener( tapOnApps.EVENT, allapps_handler )

  end

end

function scene:hide(event)
   local sceneGroup = self.view
   local phase = event.phase

   if (phase =="will") then
--scroll:cleanUp()


    slider:toBack()
    slider.isVisible = false
   --[[if(updatesList ~= nil)then
   updatesList:removeSelf()
   updatesList = nil
   end

   if(scroll ~= nil)then
   scroll:removeSelf()
   scroll = nil
   end
]]
   --timer.cancel( loopTimer)
  --[[ pan:removeEventListener( pan.EVENT,timeline_handler )
   tapOnSearch:removeEventListener( tapOnSearch.EVENT, search_handler )
  -- tapOnAllUpdates:removeEventListener( tapOnAllUpdates.EVENT, updates_handler )
]]

   elseif(phase == "did")  then

     drop_item:unregisterTouchGrestures(home_app1)
     drop_item:unregisterTouchGrestures(home_app2)
     drop_item:unregisterTouchGrestures(home_app3)
     drop_item:unregisterTouchGrestures(home_app4)
     drop_item:unregisterTouchGrestures(home_app5)
     drop_item:unregisterTouchGrestures(home_app6)
     drop_item:unregisterTouchGrestures(home_app7)
     drop_item:unregisterTouchGrestures(home_app8)
     drop_item:unregisterTouchGrestures(home_app9)
     drop_item:unregisterTouchGrestures(home_app10)
     drop_item:unregisterTouchGrestures(hotseat1)
     drop_item:unregisterTouchGrestures(hotseat2)
     drop_item:unregisterTouchGrestures(hotseat4)
     drop_item:unregisterTouchGrestures(hotseat5)
      physicsEngine.pause()
       Runtime:removeEventListener("enterFrame" ,moveloop)
     if(scroll~= nil )then
     print("Display group  on hide:will",scroll)
     end
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
