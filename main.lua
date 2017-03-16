local composer = require( "composer" )
local backStack = require("backstack")

-- Hide the status bar
display.setStatusBar( display.DarkStatusBar)

-- Seed the random number generator
--math.randomseed( os.time() )

-- this will eventually go to the menu scene.
--composer.gotoScene( "prelock.prelock" )
composer.gotoScene("screenlock.lockscreen")
--composer.gotoScene( "home.home" )
--composer.gotoScene( "timeline.timeline" )
--composer.gotoScene( "search.search" )
--composer.gotoScene( "appDrawer.appsdrawer" )
--composer.gotoScene(  "appDrawer.collection.updatedcollection" )
--composer.gotoScene( "allUpdates.allupdates" )
--composer.gotoScene("appDrawer.collection.createcollection"  )
--composer.gotoScene("appDrawer.apps.applongpress"  )
--composer.gotoScene("appDrawer.appsNavigation" )
--composer.gotoScene("appDrawer.apps.appmovecollection" )
--composer.gotoScene("appDrawer.apps.appmovedrawer")
--composer.gotoScene("appDrawer.collection.finalisecollection"  )
--composer.gotoScene("appDrawer.apps.appimpl")



local function goToHome()
  composer.removeScene( "home.home" )
  composer.gotoScene("home.home" ,{effect = "crossFade" ,time = 500})
end


local function goToLockScreen()
  composer.removeScene( "screenlock.lockscreen" )
  composer.gotoScene("screenlock.lockscreen" ,{effect = "crossFade" ,time = 500})
end


local index = 0
local function goBack()

    local lastScene = backStack:peek()
    if(lastScene ~= nil and #backStack > 1) then

  -- index = table.indexOf( backStack, "home.home" )

  print("Table size : " ..#backStack .. " index :" ..lastScene)
  --local curScene = composer.getSceneName( "current" )
  --local prevScene = composer.getSceneName( "previous" )
  --print("scene : " ..prevScene)

  --if((curScene == "search.websearch")and (prevScene =="search.search")) then
  --  goToHome()


--  else
  composer.removeScene(lastScene)
  composer.gotoScene(lastScene ,{effect = "crossFade" ,time = 400})

  backStack:pop()

end
  --end

end

--handle the Android hardware back and menu buttons
local function onKeyEvent( event )
    local keyname = event.keyName;
    print("KeyName  : " ..keyname)
    if (event.phase == "up" and (event.keyName=="back" or event.keyName=="menu")) then
            if keyname == "menu" then
            	--goToMenuScreen()
            elseif keyname == "back" then
            	goBack()

            elseif keyname == "search" then
            	--performSearch();
            end
	end
 if(event.phase == "down" and event.keyName =="volumeUp") then

   --goToLockScreen()
 end
 if(event.phase == "up" and event.keyName =="volumeDown") then

   --goToHome()
 end
    return true
end
 -- Add the key callback
if system.getInfo( "platformName" ) == "Android" then  Runtime:addEventListener( "key", onKeyEvent ) end
