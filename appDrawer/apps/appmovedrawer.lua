local composer = require("composer")
local Gesture = require ("dmc_corona.dmc_gestures")
local DragMgr = require 'dmc_corona.dmc_dragdrop'
local DropTarget = require 'appDrawer.apps.drop_target'
local widget = require( "widget" )
local drop_item = require "appDrawer.apps.drop_item"

local scene = composer.newScene()


local background
local dragItemTouchHandler
local applist

local function goToHome()
  --composer.removeScene( "home.home" )
  composer.gotoScene("home.home" ,{effect = "crossFade" ,time = 400})
end

local function goToAppMoveCollection()
  composer.removeScene( "appDrawer.apps.appmovecollection" )
  composer.gotoScene("appDrawer.apps.appmovecollection" ,{effect = "crossFade" ,time = 400})
end


local W, H = display.contentWidth, display.contentHeight
local H_CENTER, V_CENTER = W*0.5, H*0.5

local home, icon, pressOnIcon ,tapOnHome

local dropTarget1 , dropTarget2 , dropTarget3

local dragItemHead

local function createCustomProxyIcon(id)

 --local ran = math.random(8)
 local image = "appDrawer/collection/app_B6.png"

 if(id=="A1" or id == "HomeApp1" or id=="App1" or id=="App7") then
   image = "appDrawer/collection/app_A1.png"
 end

 if(id=="A2" or id == "HomeApp2" or id == "App2") then
   image = "appDrawer/collection/app_A2.png"
 end

 if(id=="A3" or id == "HomeApp3" or id=="App3" or id=="App9") then
   image = "appDrawer/collection/app_A3.png"
 end

 if(id=="A4" or id == "HomeApp4" ) then
   image = "appDrawer/collection/app_A4.png"
 end

 if(id=="A5" or id == "HomeApp5") then
   image = "appDrawer/collection/app_A5.png"
 end

 if(id=="A6" or id == "HomeApp6") then
   image = "appDrawer/collection/app_A6.png"
 end

 if(id=="B1" or id == "HomeApp7" or id=="App4"  or id=="App5" or id=="App8") then
   image = "appDrawer/collection/app_B1.png"
 end

 if(id=="B2" or id == "HomeApp8" or id=="App6") then
   image = "appDrawer/collection/app_B2.png"
 end

 if(id=="B3" or id == "HomeApp9") then
   image = "appDrawer/collection/app_B3.png"
 end

 if(id=="B4" or id == "HomeApp10") then
   image = "appDrawer/collection/app_B4.png"
 end

 if(id == "HomeApp11") then
   image = "appDrawer/apps/button_1.png"
 end

 if(id == "HomeApp12") then
   image = "appDrawer/apps/button_2.png"
 end

 if(id == "HomeApp13") then
   image = "appDrawer/apps/button_3.png"
 end

 if(id == "HomeApp14") then
   image = "appDrawer/apps/button_4.png"
 end

 if(id == "HomeApp15") then
   image = "appDrawer/apps/button_5.png"
 end







 if(id=="G1") then
   image = "appDrawer/apps/movable_app.png"
 end

  local o = display.newImageRect(image, 111, 111 )
  return o
end

-- Function to handle button events
local function handleButtonEvent( event )


    if ( "ended" == event.phase ) then
        print( "Button was pressed and released" )
           goToHome()
    end
end


local function home_handler( event )
  print( "gestureEvent_handler", event.target.id, event.phase ,event.name )
  if event.type == event.target.GESTURE then
     goToHome()

  end
end

local function app_handler( event )
  print( "gestureEvent_handler", event.target.id, event.phase ,event.name )
  if event.type == event.target.GESTURE then
    goToAppMoveCollection()
   end
end



-- ScrollView listener
local function scrollListener( event )

    local phase = event.phase

    if ( phase == "began" ) then print( "Scroll view was touched" )

    elseif ( phase == "moved" ) then print( "Scroll view was moved" )
      --print("timelineSummary.y: " ..timelineSummary.y .."timelineSummary.x " .. timelineSummary.x)

        if(event.limitReached) then

        else

      --   if( timelineSummary.y >1098 ) then

        -- else
            offset = event.y- event.yStart
          --[[  if(event.direction == "up" ) then
          --  timelineSummary.y = timelineSummary.y -1
              dropTarget1.y = dropTarget1.y-3
              dropTarget2.y = dropTarget2.y-3
              dropTarget3.y = dropTarget3.y-3
            elseif ( event.direction == "down" ) then
              dropTarget1.y = dropTarget1.y+3
              dropTarget2.y = dropTarget2.y+3
              dropTarget3.y = dropTarget3.y+3
            end]]
         --end
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

--== create Red Drag Target ==--

dragItemTouchHandler = function( event )

  if event.phase=='began' then

    --dragItem.isVisible = false
    local target = event.target

  --[[  local custom_proxy = createSquare{
      width=75, height=75,
      fillColor=DragMgr.COLOR_LIGHTRED,
      strokeColor=DragMgr.COLOR_GREY,
      strokeWidth=2
    }
]]
    local custom_proxy = display.newImageRect("appDrawer/apps/movable_app.png",141, 141)

    -- setup info about the drag operation
    local drag_info = {
      proxy = custom_proxy,
      format = 'blue',
      yOffset = -50,
    }

    -- now tell the Drag Manager about it
    DragMgr:doDrag( target, event, drag_info )
  end
--[[
  if(DropTarget:isDragSuccess() == false ) then
    print("Unsuccessful")
    dragItem.isVisible = true
  end
  --dragItem.isVisible = true]]
  return true
end


dragCollectionHandler = function( event )

  if event.phase=='began' then

    --dragItem.isVisible = false
    local target = event.target

  --[[  local custom_proxy = createSquare{
      width=75, height=75,
      fillColor=DragMgr.COLOR_LIGHTRED,
      strokeColor=DragMgr.COLOR_GREY,
      strokeWidth=2
    }
]]
    local custom_proxy = createCustomProxyIcon(target.id)

    -- setup info about the drag operation
    local drag_info = {
      proxy = custom_proxy,
      format = 'red',
      yOffset = -50,
    }

    DropTarget:SetDropItem(target)
    -- now tell the Drag Manager about it
    DragMgr:doDrag( target, event, drag_info )
  end
--[[
  if(DropTarget:isDragSuccess() == false ) then
    print("Unsuccessful")
    dragItem.isVisible = true
  end
  --dragItem.isVisible = true]]
  return true
end

local dragHead =  nil
local dragItem1,dragItem2,dragItem3,dragItem4,dragItem5,dragItem6
local dragItem7,dragItem8,dragItem9,dragItem10,dragItem11,dragItem12

local dragItem13,dragItem14,dragItem15,dragItem16,dragItem17,dragItem18

local dragItem19,dragItem20,dragItem21,dragItem22,dragItem23,dragItem24


function scene:create(event)

  local sceneGroup = self.view

  local top = display.newImageRect( sceneGroup , "appDrawer/apps/move_drawer_top.png", W,288)
  top.x = display.contentCenterX
  top.y = 144




  local cancelButton = widget.newButton(
      {
          width = 95,
          height = 103,
          defaultFile = "appDrawer/apps/cancel.png",
          onEvent = handleButtonEvent
      }
  )

  -- Center the button
  cancelButton.x = 1000
  cancelButton.y = 200

  sceneGroup:insert(cancelButton)

  local applist_height = 1677
  applist= display.newImageRect( sceneGroup , "appDrawer/apps/appList2.png", 756,applist_height )
  applist.x = display.contentCenterX-120
  applist.y = applist_height*0.5 +400


--[[
  -- Create the widget
 scrollView = widget.newScrollView(
      {
          top = 290,
          left = 2,
          width = 840,--display.contentWidth,
          height = display.contentHeight,
          scrollWidth = 0,--display.contentWidth-100,
          scrollHeight = applist_height - applist.y  ,
          horizontalScrollDisabled  = true,
          listener = scrollListener
      }
  )

scrollView:insert(applist)

sceneGroup:insert(scrollView)

]]

local dropArea = display.newImageRect( sceneGroup , "appDrawer/apps/mover_drawer_droparea.png", 212,1632 )
dropArea.x = 960
dropArea.y = display.contentCenterY + 148


dragHead = display.newImageRect(sceneGroup,"appDrawer/apps/movable_app.png",141, 141)
dragHead.x, dragHead.y = 980, V_CENTER
  -- create touch area for gestures
  --home= display.newRect( sceneGroup,H_CENTER, 15,20,20)
  --home.alpha = 1

--  icon= display.newRect( sceneGroup,H_CENTER+150 , V_CENTER +10,50,50)
  --icon.fill = {1,1,0}
--  icon.alpha = 0.0




  dropTarget1 = DropTarget:new{
  format={ 'blue' }}
  dropTarget1.x, dropTarget1.y = H_CENTER-110, 690
  dropTarget1.width = 700
  dropTarget1.height = 440
  DragMgr:register( dropTarget1 )
  --sceneGroup:insert(dropTarget1)

  dropTarget2 = DropTarget:new{
  format={ 'blue' }}
  dropTarget2.x, dropTarget2.y = H_CENTER-110, 1440
  dropTarget2.width = 700
  dropTarget2.height = 800
  DragMgr:register( dropTarget2 )
  --sceneGroup:insert(dropTarget2)

  dropTarget3 = DropTarget:new{
  format={ 'red' }}
  dropTarget3.x, dropTarget3.y = 960, V_CENTER + 140
  dropTarget3.width = 200
  dropTarget3.height = 1600
  DragMgr:register( dropTarget3 )
  --sceneGroup:insert(dropTarget3)


--[[  local container = display.newContainer( 800, 440 )
  container.id = "home"
  container.x = H_CENTER-110
  container.y = 690
  --container.fill = {1,0,1}
  container.alpha = 0.01
  sceneGroup:insert(container)

--  container:translate( 160, 240 )]]


dragItem1 = drop_item.new("HomeApp1" ,"appDrawer/collection/app_A1.png","red","home")
drop_item:setSize(dragItem1,81,81)
drop_item:setLocation(dragItem1,150,550)
sceneGroup:insert(dragItem1)

--container:insert( dragItem1,true)

dragItem2 = drop_item.new("HomeApp2" ,"appDrawer/collection/app_A2.png","red","home")
drop_item:setLocation(dragItem2,290,550)
drop_item:setSize(dragItem2,81,81)
sceneGroup:insert(dragItem2)

--container:insert( dragItem2,true)

dragItem3 = drop_item.new("HomeApp3" ,"appDrawer/collection/app_A3.png","red","home")
drop_item:setLocation(dragItem3,430,550)
drop_item:setSize(dragItem3,81,81)
sceneGroup:insert(dragItem3)

dragItem4 = drop_item.new("HomeApp4" ,"appDrawer/collection/app_A4.png","red","home")
drop_item:setLocation(dragItem4,570,550)
drop_item:setSize(dragItem4,81,81)
sceneGroup:insert(dragItem4)


dragItem5 = drop_item.new("HomeApp5" ,"appDrawer/collection/app_A5.png","red","home")
drop_item:setLocation(dragItem5,700,550)
drop_item:setSize(dragItem5,81,81)
sceneGroup:insert(dragItem5)


dragItem6 = drop_item.new("HomeApp6" ,"appDrawer/collection/app_A6.png","red","home")
drop_item:setSize(dragItem6,81,81)
drop_item:setLocation(dragItem6,150,700)
sceneGroup:insert(dragItem6)

dragItem7 = drop_item.new("HomeApp7" ,"appDrawer/collection/app_B1.png","red","home")
drop_item:setLocation(dragItem7,290,700)
drop_item:setSize(dragItem7,81,81)
sceneGroup:insert(dragItem7)

dragItem8 = drop_item.new("HomeApp8" ,"appDrawer/collection/app_B2.png","red","home")
drop_item:setLocation(dragItem8,430,700)
drop_item:setSize(dragItem8,81,81)
sceneGroup:insert(dragItem8)

dragItem9 = drop_item.new("HomeApp9" ,"appDrawer/collection/app_B3.png","red","home")
drop_item:setLocation(dragItem9,570,700)
drop_item:setSize(dragItem9,81,81)
sceneGroup:insert(dragItem9)


dragItem10 = drop_item.new("HomeApp10" ,"appDrawer/collection/app_B4.png","red","home")
drop_item:setLocation(dragItem10,700,700)
drop_item:setSize(dragItem10,81,81)
sceneGroup:insert(dragItem10)

dragItem11 = drop_item.new("HomeApp11" ,"appDrawer/apps/button_1.png","red","home")
drop_item:setLocation(dragItem11,150,850)
drop_item:setSize(dragItem11,81,81)
sceneGroup:insert(dragItem11)

dragItem12 = drop_item.new("HomeApp12" ,"appDrawer/apps/button_2.png","red","home")
drop_item:setSize(dragItem12,81,81)
drop_item:setLocation(dragItem12,290,850)
sceneGroup:insert(dragItem12)

--dragItem13 = drop_item.new("HomeApp13" ,"appDrawer/apps/button_3.png","red","home")
--drop_item:setLocation(dragItem13,430,850)
--drop_item:setSize(dragItem13,81,81)
--sceneGroup:insert(dragItem13)

dragItem14 = drop_item.new("HomeApp14" ,"appDrawer/apps/button_4.png","red","home")
drop_item:setLocation(dragItem14,570,850)
drop_item:setSize(dragItem14,81,81)
sceneGroup:insert(dragItem14)

dragItem15 = drop_item.new("HomeApp15" ,"appDrawer/apps/button_5.png","red","home")
drop_item:setLocation(dragItem15,700,850)
drop_item:setSize(dragItem15,81,81)
sceneGroup:insert(dragItem15)


dragItem16 = drop_item.new("App1" ,"appDrawer/collection/app_A1.png","red","custom1")
drop_item:setLocation(dragItem16,165,1110)
sceneGroup:insert(dragItem16)

dragItem17 = drop_item.new("App2" ,"appDrawer/collection/app_A2.png","red","custom1")
drop_item:setLocation(dragItem17,335,1110)
sceneGroup:insert(dragItem17)

dragItem18 = drop_item.new("App3" ,"appDrawer/collection/app_A3.png","red","custom1")
drop_item:setLocation(dragItem18,500,1110)
sceneGroup:insert(dragItem18)

dragItem19 = drop_item.new("App4" ,"appDrawer/collection/app_B1.png","red","custom1")
drop_item:setLocation(dragItem19,165,1240)
sceneGroup:insert(dragItem19)

dragItem20 = drop_item.new("App5" ,"appDrawer/collection/app_B1.png","red","custom2")
drop_item:setLocation(dragItem20,165,1460)
sceneGroup:insert(dragItem20)

dragItem21 = drop_item.new("App6" ,"appDrawer/collection/app_B2.png","red","custom2")
drop_item:setLocation(dragItem21,335,1460)
sceneGroup:insert(dragItem21)

dragItem22 = drop_item.new("App7" ,"appDrawer/collection/app_A1.png","red","custom3")
drop_item:setLocation(dragItem22,165,1830)
sceneGroup:insert(dragItem22)

dragItem23 = drop_item.new("App8" ,"appDrawer/collection/app_B1.png","red","custom3")
drop_item:setLocation(dragItem23,335,1830)
sceneGroup:insert(dragItem23)


dragItem24 = drop_item.new("App9" ,"appDrawer/collection/app_A3.png","red","custom3")
drop_item:setLocation(dragItem24,500,1830)
sceneGroup:insert(dragItem24)



end

function scene:show(event)

  local sceneGroup = self.view
  local phase = event.phase

  if (phase =="will") then


  elseif(phase == "did")  then

    -- create a touch gestures, link to shape

 --print("listener : " ..dragItem:addEventListener( 'touch', dragItemTouchHandler ))
  dragHead:addEventListener( 'touch', dragItemTouchHandler )

  dragItem1:addEventListener( 'touch', dragCollectionHandler )
  dragItem2:addEventListener( 'touch', dragCollectionHandler )
  dragItem3:addEventListener( 'touch', dragCollectionHandler )
  dragItem4:addEventListener( 'touch', dragCollectionHandler )
  dragItem5:addEventListener( 'touch', dragCollectionHandler )
  dragItem6:addEventListener( 'touch', dragCollectionHandler )
  dragItem7:addEventListener( 'touch', dragCollectionHandler )
  dragItem8:addEventListener( 'touch', dragCollectionHandler )
  dragItem9:addEventListener( 'touch', dragCollectionHandler )
  dragItem10:addEventListener( 'touch', dragCollectionHandler )
  dragItem11:addEventListener( 'touch', dragCollectionHandler )
  dragItem12:addEventListener( 'touch', dragCollectionHandler )
--  dragItem13:addEventListener( 'touch', dragCollectionHandler )
  dragItem14:addEventListener( 'touch', dragCollectionHandler )
  dragItem15:addEventListener( 'touch', dragCollectionHandler )
  dragItem16:addEventListener( 'touch', dragCollectionHandler )
  dragItem17:addEventListener( 'touch', dragCollectionHandler )
  dragItem18:addEventListener( 'touch', dragCollectionHandler )
  dragItem19:addEventListener( 'touch', dragCollectionHandler )
  dragItem20:addEventListener( 'touch', dragCollectionHandler )
  dragItem21:addEventListener( 'touch', dragCollectionHandler )
  dragItem22:addEventListener( 'touch', dragCollectionHandler )
  dragItem23:addEventListener( 'touch', dragCollectionHandler )
  dragItem24:addEventListener( 'touch', dragCollectionHandler )




--  tapOnHome = Gesture.newTapGesture(   home, { id="1 tch 1 tap" })
	--tapOnHome:addEventListener( tapOnHome.EVENT, home_handler )

--  pressOnIcon = Gesture.newPanGesture( icon, { touches=1, id="1 pan" } )
--  pressOnIcon:addEventListener( pressOnIcon.EVENT, app_handler )

  end

end

function scene:hide(event)
   local sceneGroup = self.view
   local phase = event.phase

   if (phase =="will") then

     --dragHead:removeEventListener( 'touch', dragItemTouchHandler )

     if dropTarget1 ~= nil then
      dropTarget1:removeSelf()
     end

     if dropTarget2 ~= nil then
      dropTarget2:removeSelf()
     end

     if dropTarget3 ~= nil then
      dropTarget3:removeSelf()
     end


     --tapOnHome:removeEventListener( tapOnHome.EVENT, home_handler )
     --pressOnIcon:removeEventListener( pressOnIcon.EVENT, app_handler )
    -- tapOnDone:removeEventListener( tapOnDone.EVENT, create_handler )

   elseif(phase == "did")  then
  --
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
