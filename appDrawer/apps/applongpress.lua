local composer = require("composer")
local Gesture = require ("dmc_corona.dmc_gestures")
local slideView = require("appDrawer.apps.Zunware_SlideView")
local widget = require ("widget")
local drop_item = require "appDrawer.apps.drop_item"
local launcherAppsStructure = require("appDrawer.appUtils")


local scene = composer.newScene()

local i = 5
local background

--local widgetsTypes ={"Type1" ,"Type2" ,"Type3"}
local widgetsTypes ={"Type3"}

local function goToHome()
  composer.removeScene( "home.home" )
  composer.gotoScene("home.home" ,{effect = "crossFade" ,time = 500})
end

local function goToAppMoveDrawer()

  composer.removeScene( "appDrawer.apps.appmovecollection" )
  composer.gotoScene("appDrawer.apps.appmovecollection" ,{effect = "crossFade" ,time = 400})
  --composer.removeScene("appDrawer.apps.appmovedrawer" )
  --composer.gotoScene("appDrawer.apps.appmovedrawer" ,{effect = "crossFade" ,time = 100})
end

local function goToAllApps()


  composer.removeScene( "appDrawer.appsNavigation" )
  composer.gotoScene("appDrawer.appsNavigation" ,{effect = "slideUp" ,time = 400})

  --composer.removeScene( "appDrawer.appsdrawer" )
  --composer.gotoScene("appDrawer.appsdrawer" ,{effect = "slideUp" ,time = 400})
end


local W, H = display.contentWidth, display.contentHeight
local H_CENTER, V_CENTER = W*0.5, H*0.5

local home, icon, delete, remove,  pressOnIcon ,tapOnHome , tapOnRemove , tapOnDelete

local function home_handler( event )
  print( "gestureEvent_handler", event.target.id, event.phase ,event.name )
  if event.type == event.target.GESTURE then
     goToHome()

  end
end

local function app_handler( event )
  print( "gestureEvent_handler", event.target.id, event.phase ,event.name )
  if event.type == event.target.GESTURE then
    goToAppMoveDrawer()
   end
end

local function remove_handler( event )
  print( "gestureEvent_handler", event.target.id, event.phase ,event.name )
  if event.type == event.target.GESTURE then

   end
end

local function delete_handler( event )
  print( "gestureEvent_handler", event.target.id, event.phase ,event.name )
  if event.type == event.target.GESTURE then

   end
end



local function shuffleWidgets()

  local widgetSpecific = widgetsTypes[math.random(1)]

  local app = drop_item:getTouchedApp()
  local appCount  = tonumber(string.sub( app.id, 4, string.len( app.id )))
  local specificRow = launcherAppsStructure:findAppRow(appCount)

--  print("Specific :" .. appCount)


  local widgetRow = math.ceil(tonumber(appCount)/4)

  local widgetCount = launcherAppsStructure:getWidgetsCount()
  local widgetRowCount = launcherAppsStructure:getWidgetsRowsCount()

  --print(" widgetRowCount " .. widgetRowCount .. "    Total Widget : " ..widgetCount)
  -- if(widgetRowCount>1) then
    -- widgetRow = widgetRow +widgetRowCount
  --end
 --print ("Dropped :" .. app.id .." appvalue : " ..appCount .." app specific Row :"..specificRow .."Specific :" ..widgetSpecific)

---  table.indexOf(launcherAppsStructure[][1] , element )

  if(string.starts(launcherAppsStructure[specificRow + 1][1],"widget"))then

    local widgetDetails ={}
    local nextWidgetDetails = {}
    widgetDetails = launcherAppsStructure:findWidgetsRow(specificRow + 1)
    nextWidgetDetails = launcherAppsStructure:findWidgetsRow(specificRow + 2)
    print("Widgets details :" ,widgetDetails[1], " remains : " ..widgetDetails[2] )
    print("Next Widgets details :" ,nextWidgetDetails[1], " remains : " ..nextWidgetDetails[2] )
    if((widgetDetails[1]== true and widgetDetails[2] == 0) and (nextWidgetDetails[1]== true and nextWidgetDetails[2] == 0) )then
      print("both widgets row is full")

      local lastRow = {}
      local AppOne = {}
      local AppTwo = {}
      local AppThree = {}
      local AppFour = {}

      print("Row To be Modified : ".. launcherAppsStructure[specificRow][1] )
      print("Row To be Modified Count  : ".. launcherAppsStructure[specificRow][2] )
      print("Row To be Modified  App : ".. launcherAppsStructure[specificRow][3][1] )
      print("Row To be Modified  App  Icon: ".. launcherAppsStructure[specificRow][3][2] )
      launcherAppsStructure:insert(specificRow+3 ,{"RowNew ",2,{launcherAppsStructure[specificRow][3][1],launcherAppsStructure[specificRow][3][2]},{launcherAppsStructure[specificRow][4][1],launcherAppsStructure[specificRow][4][2]}})
      launcherAppsStructure:constructWidgetsRows(specificRow+3)



    else
    if((widgetSpecific == "Type1" or widgetSpecific == "Type2" ) and widgetDetails[2] == 1 ) then


     local prevCount = launcherAppsStructure[specificRow + 1][3][1]
     local prevSpecific =launcherAppsStructure[specificRow + 1][3][2]
     local preAppId = launcherAppsStructure[specificRow + 1][3][3]
      local rowInfo = {"widgetPane"..widgetRowCount,2,{prevCount,prevSpecific,preAppId},{"widget"..widgetCount,widgetSpecific,app.id}}
      launcherAppsStructure:UpdateWigetsRowTable(specificRow+1,0)
      launcherAppsStructure:insert(specificRow+1,rowInfo)
      launcherAppsStructure:updateWidgetsCount()
    --  print("yes not Type 3")


    else
      local rowInfo = {"widgetPane"..widgetRowCount,1,{"widget"..widgetCount,widgetSpecific,app.id}}
      launcherAppsStructure:insert(specificRow+2,rowInfo)
    --  launcherAppsStructure:UpdateWigetsRowTable(specificRow+2)
      launcherAppsStructure:UpdateWigetsRowTable(specificRow+2,0)

      launcherAppsStructure:updateWidgetsCount()
      launcherAppsStructure:updateWidgetsRowsCount()


      -- = widgetRowCount +1
      --widgetCount =  widgetCount  + 1
    end
  end

  else
    local rowInfo = {"widgetPane"..widgetRowCount,1,{"widget"..widgetCount,widgetSpecific,app.id}}
    launcherAppsStructure:insert(specificRow+1,rowInfo)
    --widgetRowCount = widgetRowCount +1
  --  widgetCount =  widgetCount  + 1
  --launcherAppsStructure:UpdateAppRows(appCount)
--  launcherAppsStructure:UpdateWigetsRowTable(specificRow+1)
       if(widgetSpecific == "Type1" or widgetSpecific == "Type2" ) then

  launcherAppsStructure:UpdateWigetsRowTable(specificRow+1,1)

else
     launcherAppsStructure:UpdateWigetsRowTable(specificRow+1,0)
end
  launcherAppsStructure:updateWidgetsCount()
  launcherAppsStructure:updateWidgetsRowsCount()
  end

launcherAppsStructure:UpdateAppRows(appCount)


end


   local function createWidget_Event( event )

    -- print("approws :" ..#launcherAppsStructure )


    -- table.insert( appRows, widgetRow, "widgetPane" )
     --i = i+1
      if ( "ended" == event.phase ) then

        --local app = drop_item:getTouchedApp()
        --local appRow = string.sub( app.id, 4, string.len( app.id ))
        --local widgetRow = math.ceil(tonumber(appRow)/4)

      --  local rowInfo = {"widgetPane",1,{"widget1" ,app.id}}
            -- print( "Button was pressed and released" )
            -- launcherAppsStructure:insert(widgetRow+1,rowInfo)
            -- drop_item:ispinned(true)
              shuffleWidgets()
             goToAllApps()
         end
   end


function scene:create(event)

  local sceneGroup = self.view

  local background = display.newImageRect( sceneGroup , "appDrawer/apps/app_background.png", W,H)
  background.x = display.contentCenterX
  background.y = display.contentCenterY


  local widgets = {
  	"appDrawer/apps/widgetPane1.png",
  	"appDrawer/apps/widgetPane2.png",
    "appDrawer/apps/widgetPane3.png",
    "appDrawer/apps/1x1.png",
    "appDrawer/apps/1x2.png",
    "appDrawer/apps/2x1.png",
    "appDrawer/apps/2x2.png",
    "appDrawer/apps/2x3.png",
    "appDrawer/apps/3x2.png",
    "appDrawer/apps/3x3.png",
    "appDrawer/apps/3x4.png",
    "appDrawer/apps/4x3.png",
    "appDrawer/apps/4x4.png",
  }


  local widgetPane = slideView.new(widgets, nil)
  widgetPane.y = -380

   sceneGroup:insert(widgetPane )

  -- create touch area for gestures
  home= display.newRect( sceneGroup,H_CENTER, 15,20,20)
  home.alpha = 0.01


  local remove = widget.newButton(
      {
          width = 226,
          height = 63,
          defaultFile = "appDrawer/apps/remove_icon.png",
          overFile = "appDrawer/apps/remove_icon.png",
        --  onEvent = createWidget_Event
      }
  )

   remove.x = 200
   remove.y = 200

 sceneGroup:insert(remove )
   local uninstall = widget.newButton(
       {
           width = 236,
           height = 63,
           defaultFile = "appDrawer/apps/uninstall_icon.png",
           overFile = "appDrawer/apps/uninstall_icon.png",
           --onEvent = updates_Event
       }
   )

    uninstall.x = 900
    uninstall.y = 200

    sceneGroup:insert(uninstall )


    backHome= display.newRect( sceneGroup,H_CENTER, V_CENTER +730 ,W,450)
    backHome.alpha = 0.01

    icon = display.newRect( sceneGroup,H_CENTER , V_CENTER+470,150,150)
    --icon.fill = {1,1,0}
    icon.alpha = 0.01


    local pinnedIt = widget.newButton(
        {
            width = 61,
            height = 101,
            defaultFile = "appDrawer/apps/pin.png",
            overFile = "appDrawer/apps/pin.png",
            onEvent = createWidget_Event
        }
    )
    pinnedIt.x = 980
    pinnedIt.y = 400

  sceneGroup:insert(pinnedIt )

    local move = widget.newButton(
        {
            width = 450,
            height = 120,
            defaultFile = "appDrawer/apps/move_and_replace_app.png",
            overFile = "appDrawer/apps/move_and_replace_app.png",
            --onEvent = updates_Event
        }
    )

     move.x = H_CENTER
     move.y = V_CENTER +700

     sceneGroup:insert(move )



end

function scene:show(event)

  local sceneGroup = self.view
  local phase = event.phase

  if (phase =="will") then

  elseif(phase == "did")  then

    -- create a touch gestures, link to shape


  tapOnBackHome = Gesture.newTapGesture(   backHome, { id="1 tch 1 tap" })
	tapOnBackHome:addEventListener( tapOnBackHome.EVENT, home_handler )

  pressOnIcon = Gesture.newPanGesture( icon, { touches=1, id="1 pan" } )
  pressOnIcon:addEventListener( pressOnIcon.EVENT, app_handler )

--  tapOnRemove = Gesture.newTapGesture(remove, { id="1 tch 1 tap" })
--	tapOnRemove:addEventListener( tapOnRemove.EVENT, remove_handler )

--  tapOnDelete = Gesture.newTapGesture(delete, { id="1 tch 1 tap" })
--  tapOnDelete:addEventListener( tapOnDelete.EVENT, delete_handler )

  end

end

function scene:hide(event)
   local sceneGroup = self.view
   local phase = event.phase

   if (phase =="will") then

     tapOnBackHome:removeEventListener( tapOnBackHome.EVENT, home_handler )
--     pressOnIcon:removeEventListener( pressOnIcon.EVENT, app_handler )
--     tapOnRemove:removeEventListener( tapOnRemove.EVENT, remove_handler )
--     tapOnDelete:removeEventListener( tapOnDelete.EVENT, delete_handler )

    -- tapOnDone:removeEventListener( tapOnDone.EVENT, create_handler )

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
