local composer = require("composer")
local Gesture = require ("dmc_corona.dmc_gestures")
local widget = require( "widget" )
local drop_item = require "appDrawer.apps.drop_item"
local scene = composer.newScene()
local scrollView = require("appDrawer.apps.scrollView")
local launcherAppsStructure = require "appDrawer.appUtils"


local appRows= { "Row1","Row2","widget1","Row3","Row4","Row5","Row6","Row7","widget2","Row8","Row9",
                    "Row10","widget3","widget4","Row11","Row12","Row13","Row14","Row15","Row16","Row17","Row18",
                    "Row19","Row20","Row21","Row22","Row23","Row24","Row25","Row26","Row27"}

--local launcherAppsStructure ={}

local appsIcons=
{"appDrawer/collection/app_A1.png",
"appDrawer/collection/app_A2.png",
"appDrawer/collection/app_A3.png",
"appDrawer/collection/app_A4.png",
"appDrawer/collection/app_A5.png",
"appDrawer/collection/app_A6.png",
"appDrawer/collection/app_B1.png",
"appDrawer/collection/app_B2.png",
"appDrawer/collection/app_B3.png",
"appDrawer/collection/app_B4.png",
"appDrawer/collection/app_B5.png",
"appDrawer/collection/app_B6.png",
}


local background
--local scrollView

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

local home, createButton, tapOnCreate
local tapOnHome
local row1,row2,row3,row4,row5,row6
local Y1,Y2,Y3,Y4,Y5,Y6

local searchbar,tapOnSearch

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

-- Create the group
local appDrawer = display.newGroup()

-- Setup a scrollable content group
local scroll

local function printAppTable()

  for i = 1,#launcherAppsStructure do
    for j = 1,4 do
  --  print("Table Contents : " ..launcherAppsStructure[i][j])
  end
  end

end

local function createRows(id)

 local row
  row = display.newRoundedRect( 0, 0, 1000, 200, 6 )
  row.alpha = 0.1
	row:setStrokeColor( 255, 255, 255, 255 )
	row.strokeWidth = 15

  return row
end


local function createWidget(id,pos,type ,height)
--print("Collection :".. id)
 local widget
 local xPos = 0
 local yPos = 0

 --[[if(pos == 1) then
 xPos = -250
 yPos  =
 elseif(pos == 2) then
 xPos = 250
 yPos =  math.floor(height/2) - 110
 end
]]
 if(type == "Type3")then
   widget = display.newRoundedRect( -200, math.floor(height/2) - 110, 500, 150, 6 )
 else
   widget = display.newRoundedRect( xPos,math.floor(height/2) - 110, 350, 150, 6 )
 end
   widget.alpha = 0.8
  return widget
end


local function createApp(id,pos,height,icon,row)


  local app
  local xPos
  --local iconPos =   math.random(1, #appsIcons)
  app = drop_item.new(id , icon,row)

  if(pos == 1) then
  xPos = -350
 elseif(pos == 2) then
  xPos = -100
 elseif(pos == 3) then
  xPos = 150
 elseif(pos == 4) then
  xPos = 400
 end
  drop_item:setLocation(app,xPos, math.floor(height/2) - 110)
  drop_item:registerTouchGrestures(app)

  return app
end

local top,home
local isFirstBoot = true
local isNextBoot = false

local function reconstuctDrawer()

  ---if(appDrawer ==nil)then
  --  appDrawer = display.newGroup()

  --end

  local appCount = 1
  local position = 0
  local widgetPos = 0
  local widgetCount = 1

  scroll = scrollView.new{ top=500, bottom=0}

  for i = 1 ,#launcherAppsStructure do

  local rows = display.newGroup()
  local row = createRows(i)

  --row.id = appUtils[i]
  rows:insert(row)

  rows.x = display.contentWidth*0.5
  rows.y =  math.floor( 20+ (rows.height + 24)*(i-1) + 24 )

  local str= launcherAppsStructure[i][1]
   print ("Array Reconstruct: " ..str)
  --print("content : " ,string.starts(str,"widget"))


  if(string.starts(launcherAppsStructure[i][1],"widget")) then
    for j =1 , launcherAppsStructure[i][2] do

      if(widgetPos ==launcherAppsStructure[i][2])then
        widgetPos = 0
      end

      widgetPos = widgetPos +1
      local type = launcherAppsStructure[i][2+j][2]
    --  local icon =
    --  if(launcherAppsStructure[i][2+j][2] == "Type3")then

  local widget = createWidget("Widget"..widgetCount,widgetPos,type,rows.height)
  rows:insert( widget)
  widgetCount = widgetCount +1
      end
  else

   if(string.starts(launcherAppsStructure[i][1],"RowNew")) then
     position = 0
   end

  local rowArr = {}
  for j = 1 ,launcherAppsStructure[i][2] do

  if(position == launcherAppsStructure[i][2])then
    position = 0
  end

  position = position +1

  local app = createApp(launcherAppsStructure[i][2+j][1] ,position,rows.height,launcherAppsStructure[i][2+j][2])
  rows:insert( app )

--  rowArr[j] = "App"..appCount

  appCount = appCount+1


  end
  --launcherAppsStructure[i] ={str,rowArr}

  end

  scroll:insert( rows )
  end

  appDrawer:insert(scroll)
--  return scroll
end

local rowsCount = 20

local function initialiseAppsDrawer()

   local widgetRow = 0
   local pinnedApp
   local bool = drop_item:ispinned()

   local appCount = 1
   local position = 0
   local widgetPos = 0
   local widgetCount = 1

   scroll = scrollView.new{ top=500, bottom=0}

   print("bool " ,bool)
   if(bool == true)then
      pinnedApp = drop_item:getTouchedApp().id
     rowsCount = rowsCount+1
     widgetRow = string.sub( pinnedApp, 4, string.len( pinnedApp ))

    -- print("widgetRow :  " ..widgetRow)
   end





    for i = 1 ,rowsCount do

    local rows = display.newGroup()
    local row = createRows(i)

    local rowInfo = {}

    row.id = "Row"..i
    rows:insert(row)
    rowInfo[1] = row.id
    rowInfo[2] = 4

    rows.x = display.contentWidth*0.5
    rows.y =  math.floor( 20+ (rows.height + 24)*(i-1) + 24 )

  --  print ("Row #: " ..row.id)

  --  local str= appUtils[i]
  --if(widgetRow ~=0) then

--[[
      if(i == widgetRow + 1) then
      local widget = createWidget("Widget"..widgetCount,widgetPos, rows.height)
      rows:insert( widget)
      widgetCount = widgetCount +1
      widgetRow = 0
]]

     for j = 1 ,4 do

     if(position == 4)then
       position = 0
     end

     position = position +1

     local iconPos =   math.random(1, #appsIcons)
     local icon = appsIcons[iconPos]


     local app = createApp("App"..appCount ,position,rows.height,icon,i)
     app.row = row.id
     rows:insert( app )
     launcherAppsStructure:constructAppRows(i)

    table.insert( rowInfo, 2+j, {"App"..appCount ,icon} )
    appCount = appCount+1

    end
   launcherAppsStructure:constructWidgetsRows(i)
    --table.insert(launcherAppsStructure ,i ,rowInfo)
    launcherAppsStructure:insert(i,rowInfo)

    --launcherAppsStructure[i] ={str,rowArr}

    scroll:insert( rows )
    end

    appDrawer:insert(scroll)
    isNextBoot = true

end

local top = nil
local startTime =0
local function onDragUp( event )

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
          goToHome()
        end
        display.getCurrentStage():setFocus( nil )
    end
    return true
end

local topGroup = display.newGroup()
  --initialiseAppsDrawer()

function scene:create(event)



  local sceneGroup = self.view
if(#launcherAppsStructure == 0 )then
 initialiseAppsDrawer()
else
 reconstuctDrawer()
end

searchbar = display.newRect( sceneGroup,H_CENTER, 150, W-50,100)
searchbar.alpha = 0.5
searchbar.fill ={1,0,1}

  --reconstuctDrawer()
if(isFirstBoot == true and isNextBoot == false) then
 --initialiseAppsDrawer()

end
top = display.newImageRect(topGroup,"appDrawer/app_screen_top.png", W,366)
top.x = display.contentCenterX
top.y =187-- display.contentCenterY
top.alpha = 2


searchbar = display.newRect(topGroup,H_CENTER, 195, W-50,100)
searchbar.alpha = 0.01
--searchbar.fill ={1,0,1}

--scroll = scrollView.new{ top=500, bottom=0}

home= display.newRect(H_CENTER+2, 310,110,110)
--home.fill = {1,0,1}
home.alpha = 0.9
topGroup:insert(home)

end

function scene:show(event)

  local sceneGroup = self.view
  local phase = event.phase

  if (phase =="will") then

    --appDrawer = display.newGroup()

--    if(appDrawer ==nil)then
  --    appDrawer = display.newGroup()

    --end

    appDrawer:toFront()
    topGroup:toFront()
    appDrawer.isVisible = true

    top.isVisible = true
    home.isVisible = true
    searchbar.isVisible = true


     --reconstuctDrawer()
   if(isFirstBoot == false and isNextBoot == true) then
     --scroll = reconstuctDrawer()
    -- reconstuctDrawer()
     --if(scroll ~= nil)then
     --appDrawer:insert(scroll)

  end


  elseif(phase == "did")  then
    isFirstBoot = false

    home:addEventListener("touch" ,onDragUp)
    tapOnSearch = Gesture.newTapGesture( searchbar, { id="1 tch 1 tap" }  )
  	tapOnSearch:addEventListener( tapOnSearch.EVENT, search_handler )

    --scroll:restart()
    -- create a touch gestures, link to shape
--[[
  drop_item:registerTouchGrestures(app1)



  tapOnCreate = Gesture.newTapGesture(   createButton, { id="1 tch 1 tap" })
  tapOnCreate:addEventListener( tapOnCreate.EVENT, create_handler )
]]
  end

end

function scene:hide(event)
   local sceneGroup = self.view
   local phase = event.phase

   if (phase =="will") then
   scroll:cleanUp()
--[[
     if(top ~= nil)then
     top:removeSelf()
     top = nil
     end
]]
  top.isVisible = false
  home.isVisible = false
  searchbar.isVisible = false

  --   if(home ~= nil)then
    -- home:removeSelf()
     --home = nil
     --end
--[[
     if(appDrawer ~= nil)then
     appDrawer:removeSelf()
     appDrawer = nil
     end
]]
     appDrawer:toBack()
     appDrawer.isVisible = false


--[[

     if(scroll~= nil)then
       scroll:cleanUp()
     scroll:removeSelf()
     scroll = nil
    end

    ]]

    -- tapOnCreate:removeEventListener( tapOnCreate.EVENT, create_handler )
    -- drop_item:unregisterTouchGrestures(app1)

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
