local composer = require("composer")
local Gesture = require ("dmc_corona.dmc_gestures")
local DragMgr = require 'dmc_corona.dmc_dragdrop'
local DropTarget = require 'appDrawer.apps.drop_target_collection'
local drop_item = require "appDrawer.apps.drop_item"

local scene = composer.newScene()

local collectionList ={}
local drawerList ={}

local background
local dragItem1,dragItem2,dragItem3,dragItem4,dragItem5,dragItem6,dragItem7,dragItem8
local home, confirm, cancel, tapOnConfirm ,tapOnHome ,tapOnCancel

local function createCustomProxyIcon(id)

 --local ran = math.random(8)
 local image = "appDrawer/collection/app_B6.png"

 if(id=="A1") then
   image = "appDrawer/collection/app_A1.png"
 end

 if(id=="A2") then
   image = "appDrawer/collection/app_A2.png"
 end

 if(id=="A3") then
   image = "appDrawer/collection/app_A3.png"
 end

 if(id=="A4") then
   image = "appDrawer/collection/app_A4.png"
 end

 if(id=="A5") then
   image = "appDrawer/collection/app_A5.png"
 end

 if(id=="A6") then
   image = "appDrawer/collection/app_A6.png"
 end

 if(id=="B1") then
   image = "appDrawer/collection/app_B1.png"
 end

 if(id=="G1") then
   image = "appDrawer/apps/movable_app.png"
 end

  local o = display.newImageRect(image, 111, 111 )
  return o
end


local function goToHome()
  --composer.removeScene( "home.home" )
  composer.gotoScene("home.home" ,{effect = "crossFade" ,time = 500})
end

local function goToUpdatedCollection()
  composer.removeScene( "appDrawer.collection.finalisecollection" )
  composer.gotoScene("appDrawer.collection.finalisecollection" ,{effect = "crossFade" ,time = 100})
end

local function goToAppMoveDrawer()
  composer.removeScene("appDrawer.apps.appmovedrawer" )
  composer.gotoScene("appDrawer.apps.appmovedrawer" ,{effect = "crossFade" ,time = 100})
end


local W, H = display.contentWidth, display.contentHeight
local H_CENTER, V_CENTER = W*0.5, H*0.5
local scaledApp


local home, confirm, cancel, tapOnConfirm ,tapOnHome ,tapOnCancel
--== create Red Drag Target ==--

dragItemTouchHandler = function( event )


  if event.phase=='began' then

    --dragItem.isVisible = false
    local target = event.target

    print("target :",target.id)
    print("target Type:",target.type)


  --[[  local custom_proxy = createSquare{
      width=75, height=75,
      fillColor=DragMgr.COLOR_LIGHTRED,
      strokeColor=DragMgr.COLOR_GREY,
      strokeWidth=2
    }
]]
    local custom_proxy = createCustomProxyIcon(target.id)--display.newImageRect("appDrawer/apps/movable_app.png",141, 141)

    local drag_info = {
      proxy = custom_proxy,
      format = 'brown',
      yOffset = -50,
    }

   if (target.des == "target1") then
    -- setup info about the drag operation
      drag_info = {
      proxy = custom_proxy,
      format = 'red',
      yOffset = -50,
    }

  elseif (target.des == "target2") then
      drag_info = {
      proxy = custom_proxy,
      format = 'blue',
      yOffset = -50,
    }
    end
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



local function home_handler( event )
  print( "gestureEvent_handler", event.target.id, event.phase ,event.name )
  if event.type == event.target.GESTURE then
     goToHome()

  end
end

local function confirm_handler( event )
  print( "gestureEvent_handler", event.target.id, event.phase ,event.name )
  if event.type == event.target.GESTURE then
    goToUpdatedCollection()
   end
end

local function cancel_handler( event )
  print( "gestureEvent_handler", event.target.id, event.phase ,event.name )
  if event.type == event.target.GESTURE then
    goToHome()
  --  goToAppMoveDrawer()
   end
end

local function app_handler( event )
  print( "gestureEvent_handler", event.target.id, event.phase ,event.name )
  if event.type == event.target.GESTURE then
     dragItem.isVisible = false
     scaledApp=  display.newImageRect("appDrawer/apps/movable_app.png",90, 100)
     scaledApp.x = 760
     scaledApp.y = display.contentCenterY + 120

   end
end

function scene:create(event)

  local sceneGroup = self.view

  local background = display.newImageRect( sceneGroup , "appDrawer/apps/move_background.png",W,H)
  background.x = display.contentCenterX
  background.y = display.contentCenterY

  local collection = display.newImageRect( sceneGroup , "appDrawer/apps/custom_collection.png" ,915,435)
  collection.x = display.contentCenterX-80
  collection.y = display.contentCenterY +80

  dropTarget = DropTarget:new{
  format={ 'red' },
  width =  500}
  dropTarget.x, dropTarget.y = 1000, 1100
  DragMgr:register( dropTarget )

  dropTarget2 = DropTarget:new{
  format={ 'blue' },
  }
  dropTarget2.width = 880
  dropTarget2.height = 360
  dropTarget2.x, dropTarget2.y = H_CENTER-80, 1080
  DragMgr:register( dropTarget2 )

  -- create touch area for gestures
  home= display.newRect( sceneGroup,H_CENTER, 15,20,20)
  home.alpha = 1

  confirm= display.newRect( sceneGroup,1000, 200,100,100)
  --confirm.fill = {1,1,0}
  confirm.alpha = 0.01

  cancel= display.newRect( sceneGroup,850, 200,100,100)
  --cancel.fill = {1,1,0}
  cancel.alpha = 0.01


    dragItem1 = drop_item.new("A1" ,"appDrawer/collection/app_A1.png","red")
    drop_item:setLocation(dragItem1,85, V_CENTER+20)
    sceneGroup:insert(dragItem1)

    --dragItem1 = display.newImageRect(sceneGroup,"appDrawer/collection/app_A1.png", 111, 111 )
    --dragItem1.x, dragItem1.y = 85, V_CENTER+20

    dragItem2 = drop_item.new("A2" ,"appDrawer/collection/app_A2.png","red")
    drop_item:setLocation(dragItem2,333, V_CENTER+20)
    sceneGroup:insert(dragItem2)



    dragItem3 = drop_item.new("A3" ,"appDrawer/collection/app_A3.png","red")
    drop_item:setLocation(dragItem3,593, V_CENTER+20)
    sceneGroup:insert(dragItem3)

    dragItem4 = drop_item.new("A4" ,"appDrawer/collection/app_A4.png","red")
    drop_item:setLocation(dragItem4,836, V_CENTER+20)
    sceneGroup:insert(dragItem4)

    dragItem5 = drop_item.new("A5" ,"appDrawer/collection/app_A5.png","red")
    drop_item:setLocation(dragItem5,85, V_CENTER +190)
    sceneGroup:insert(dragItem5)

    dragItem6 = drop_item.new("A6" ,"appDrawer/collection/app_A6.png","red")
    drop_item:setLocation(dragItem6,333, V_CENTER +190)
    sceneGroup:insert(dragItem6)

    dragItem7 = drop_item.new("B1" ,"appDrawer/collection/app_B1.png","red")
    drop_item:setLocation(dragItem7,593, V_CENTER +190)
    sceneGroup:insert(dragItem7)

    dragItem8 = drop_item.new("G1" ,"appDrawer/apps/movable_app.png","red")
    drop_item:setLocation(dragItem8,836, V_CENTER +190)
    sceneGroup:insert(dragItem8)

    tapOnConfirm = Gesture.newTapGesture(confirm, { id="1 tch 1 tap" })
  	tapOnConfirm:addEventListener( tapOnConfirm.EVENT, confirm_handler )

    tapOnCancel = Gesture.newTapGesture(   cancel, { id="1 tch 1 tap" })
  	tapOnCancel:addEventListener( tapOnCancel.EVENT, cancel_handler )

end

function scene:show(event)

  local sceneGroup = self.view
  local phase = event.phase

  if (phase =="will") then
--[[

]]
  elseif(phase == "did")  then

    -- create a touch gestures, link to shape
    dragItem1:addEventListener( 'touch', dragItemTouchHandler )
    dragItem2:addEventListener( 'touch', dragItemTouchHandler )
    dragItem3:addEventListener( 'touch', dragItemTouchHandler )
    dragItem4:addEventListener( 'touch', dragItemTouchHandler )
    dragItem5:addEventListener( 'touch', dragItemTouchHandler )
    dragItem6:addEventListener( 'touch', dragItemTouchHandler )

    dragItem7:addEventListener( 'touch', dragItemTouchHandler )
    dragItem8:addEventListener( 'touch', dragItemTouchHandler )

--  tapOnHome = Gesture.newTapGesture(   home, { id="1 tch 1 tap" })
	--tapOnHome:addEventListener( tapOnHome.EVENT, home_handler )







  end

end

function scene:hide(event)
   local sceneGroup = self.view
   local phase = event.phase

   if (phase =="will") then
--[[
    -- tapOnHome:removeEventListener( tapOnHome.EVENT, home_handler )
     tapOnConfirm:removeEventListener( tapOnConfirm.EVENT, confirm_handler )
     tapOnCancel:removeEventListener( tapOnCancel.EVENT, cancel_handler )
     --tapOnIcon8:removeEventListener( tapOnIcon8.EVENT, app_handler )
]]     if dropTarget ~= nil then
    dropTarget:removeSelf()
    end
    -- tapOnDone:removeEventListener( tapOnDone.EVENT, create_handler )

   elseif(phase == "did")  then

   end

end

function scene:destroy(event)
   local sceneGroup = self.view

end

local function  dragSucess()

print("Sucess :")
end

scene:addEventListener("create",scene)
scene:addEventListener("show",scene)
scene:addEventListener("hide",scene)
scene:addEventListener("destroy",scene)

return scene
