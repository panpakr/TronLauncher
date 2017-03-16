local Gesture = require ("dmc_corona.dmc_gestures")
local composer = require("composer")
local drop_item = {}
local drop_item_mt = { __index = drop_item}	-- metatable

-------------------------------------------------
-- PRIVATE FUNCTIONS
-------------------------------------------------

-------------------------------------------------
-- PUBLIC FUNCTIONS
-------------------------------------------------


function drop_item.new( id, image ,type,row)	-- constructor

	local drag_item= display.newImageRect(image,111, 111 ,type)
  drag_item.id = id
  drag_item.type = type
  drag_item.des = "target1"
	drag_item.row = row or 0


  table.insert( drop_item,drag_item)
	return drag_item
end

function drop_item.new( id, image ,type,container,row)	-- constructor

	local drag_item= display.newImageRect(image,111, 111 ,type)
  drag_item.id = id
  drag_item.type = type
  drag_item.des = "target1"
	drag_item.conatiner = container
	drag_item.row = row or 0


  table.insert( drop_item,drag_item)
	return drag_item
end




--[[function drop_item.new( id,image)	-- constructor

	local drag_item= display.newImageRect(image,111, 111)
  drag_item.id = id

  --table.insert( drop_item,drag_item)
	return drag_item
end
-------------------------------------------------
]]
function drop_item:setLocation(drag_item,x, y )
	--print(" setLocation : X :" .. x .. "  Y :" ..y .. "  type :",drag_item.type)
  drag_item.x = x
  drag_item.y = y


end
local touchedApp
function drop_item:getTouchedApp()
	--print(" setLocation : X :" .. x .. "  Y :" ..y .. "  type :",drag_item.type)
return touchedApp
end

function drop_item:settTouchedApp(app)
	--print(" setLocation : X :" .. x .. "  Y :" ..y .. "  type :",drag_item.type)
	touchedApp = app
end


function drop_item:setSize(drag_item,width, height )
	--print(" setLocation : X :" .. x .. "  Y :" ..y .. "  type :",drag_item.type)
  drag_item.width = width
  drag_item.height = height


end


function drop_item:setType(drag_item)
	print("  type :",drag_item.type)
  if(drag_item.type =="red") then
    drag_item.type ="blue"
    drag_item.des = "target2"
 elseif(drag_item.type =="blue") then
    drag_item.type ="red"
    drag_item.des = "target1"
  end
    print("  type Changed :",drag_item.type ,drag_item.des)
end



function drop_item:getType( )
	--print(" type :",drag_item.type)

  print("getType")
  for i = 1, #drop_item do

    print ("Item :",drop_item [type])
	end
 --return drag_item.type

end

local function goToActivity()
  composer.removeScene( "appDrawer.activity" )
  composer.gotoScene("appDrawer.activity" ,{effect = "crossFade" ,time = 400})
end

local function goToAppFeatures()
  composer.removeScene( "appDrawer.apps.applongpress" )
  composer.gotoScene("appDrawer.apps.applongpress" ,{effect = "crossFade" ,time = 200})
end

local function goToAppMoveDrawer()
  composer.removeScene("appDrawer.apps.appmovedrawer" )
  composer.gotoScene("appDrawer.apps.appmovedrawer" ,{effect = "crossFade" ,time = 200})
end



local startTime =0
local ishold = false
local heldCounter = 0
local function checkHolding()

	heldCounter = heldCounter +1
	--print("Counter " ..heldCounter)
	if heldCounter > 25 then
		Runtime:removeEventListener("enterFrame" ,checkHolding )
		heldCounter = 0

		goToAppFeatures()
	 end

end

local pinned = false

 function drop_item:ispinned(bool)

	if(bool == true) then
		pinned = true
	end
	return pinned
end

local function app_touch_handler( event )
	print( "gestureEvent_handler", event.target.id, event.phase ,event.name )


	--if event.type == event.target.GESTURE then

		 local offsetX,timeGap,offsetY

      print("targetid "..event.target.id)
		  if event.phase=='began' then


				startTime = event.time
				touchedApp = event.target
				--setTouchedApp(event.target)

      -- ishold = true
			 print("Began : start Time :" ..startTime)

       Runtime:addEventListener("enterFrame" ,checkHolding )

		 elseif event.phase=='moved' then


					 offsetX = math.abs( event.xStart - event.x)
 	  			 offsetY = math.abs( event.yStart - event.y)
					 timeGap = event.time - startTime

           print(" offsetX : " ..offsetX .." offsetY : " ..offsetY .. " timeGap : " ..timeGap)

					 if(timeGap > 300 and (offsetX >50 or offsetY >50) )then
						 print("Moved : Time gap : " ..timeGap)
						goToAppMoveDrawer()
						Runtime:removeEventListener("enterFrame" ,checkHolding )
						heldCounter = 0

					 else

						Runtime:removeEventListener("enterFrame" ,checkHolding )
 						heldCounter = 0

					 end


				 elseif event.phase == 'ended' then
          print("Ended")
			  -- ishold = false
				 Runtime:removeEventListener("enterFrame" ,checkHolding )
				 heldCounter = 0
				 print("ending held : counter " ..heldCounter)
				 end
	--end
end

local function app_tap_handler( event )
	print( "gestureEvent_handler", event.target.id, event.phase ,event.name )
	--if event.type == event.target.GESTURE then

		--	if(event.id =="1 tch 1 tap") then
				goToActivity()
		--	end
--	end
end




local tapOnApp =nil
local panApp = nil
local longPressOnApp = nil

function drop_item:registerTouchGrestures(app)

panApp = app
--  print("app Id Touch "..app.id .."Row :")
	panApp:addEventListener("touch" ,app_touch_handler)
	--panApp:addEventListener("tap" ,app_tap_handler)
	--[[tapOnApp = Gesture.newTapGesture( app, { id="1 tch 1 tap" })
	tapOnApp :addEventListener( tapOnApp.EVENT, app_tap_handler )

	panApp =  Gesture.newLongPressGesture( app, { id="1 tch 0 tap", taps=0 }  )
	panApp:addEventListener( panApp.EVENT, app_touch_handler )

	longPressOnApp = Gesture.newLongPressGesture( app, { id="1 tch 0 tap", taps=0 }  )
  longPressOnApp:addEventListener( longPressOnApp.EVENT, app_touch_handler )
]]
end

function drop_item:unregisterTouchGrestures(app)
panApp = app
	panApp:removeEventListener("touch" ,app_touch_handler)
	--panApp:removeEventListener("tap" ,app_tap_handler)
--[[

	tapOnApp :removeEventListener( tapOnApp.EVENT, app_tap_handler )
	panApp:removeEventListener( panApp.EVENT, app_touch_handler )
  longPressOnApp:removeEventListener( longPressOnApp.EVENT, app_touch_handler )]]
end


-------------------------------------------------

-------------------------------------------------

return drop_item
