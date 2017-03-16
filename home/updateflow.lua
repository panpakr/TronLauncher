local composer = require("composer")

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
local function cycle()

  if (updatesList.x < -956) then
  updatesList.x = display.contentWidth +636
  end

end




local function loop()

    cycle()
    local xVelocity ,yVelocity = updatesList:getLinearVelocity()
    print(" Loop Velocity : " ..xVelocity)
     if(velocity ~= speed) then

        if(-30 < velocity and  velocity >-90 ) then
              velocity = speed
        end

        if(velocity > speed ) then -- 300-50
          velocity = velocity- 30
        else
          velocity = velocity + 30
        end
         updatesList:setLinearVelocity(velocity,0)
     else

     --transmissionVelocity(speed)
     updatesList:setLinearVelocity(speed,0)

   end

   end


local function transmissionVelocity(velocity)

  updatesList:setLinearVelocity(velocity,0)
end


local function navigate(event)

  local phase = event.phase


  local  xVelocity ,yVelocity
  print(" Entering  Velocity : " ..velocity)
    if ( event.phase == "began" ) then

    timer.pause(loopTimer)
    --updatesList.linearDamping = 10


    xVelocity ,yVelocity = updatesList:getLinearVelocity()
   print(" Began Phase  Velocity : " ..xVelocity)
   --updatesList:setLinearVelocity(0,0)
    --[[move = 0
    print ("moved : began "..move )
    startPoint = event.xStart
    print ("Event start point :  " .. startPoint .. " ListX : " .. updatesList.x )
 ]]--
    elseif ( event.phase == "moved" ) then


    cycle()
    transitionOffset = event.x-event.xStart
    if(transitionOffset == 0) then
      velocity = 0
    updatesList:setLinearVelocity(velocity,0)

    elseif(transitionOffset  > 0) then

    updatesList.linearDamping = 0.5
    velocity = velocity + 10

  else
    velocity = velocity - 10
   end

   xVelocity ,yVelocity = updatesList:getLinearVelocity()
   print(" Move phase Velocity : " ..xVelocity)
   if(velocity > MAXIMUM) then

  else
    velocity = MAXIMUM

    --print ("moved :  "..move )
  end
 updatesList:setLinearVelocity(velocity,0)

    elseif ( event.phase == "ended" ) then


      move = 0
      print ("moved : reset  "..move )



      offset =  event.x-event.xStart

      if(offset > 0) then
      updatesList.linearDamping = 0.75
      velocity = velocity - 30
      end

      updatesList:setLinearVelocity(velocity,0)

      xVelocity ,yVelocity = updatesList:getLinearVelocity()
      print(" End  phase Velocity : " ..xVelocity)
    --[[  print ("Event endpoint  :  " .. endPoint .. " ListX : " .. updatesList.x .. " total difference :" ..offset)

      if(offset < 0 ) then

        --  count = count -20
        velocity = updatesList:getLinearVelocity()-2*fps
        if (velocity < -500) then velocity = -250 end
        updatesList:setLinearVelocity(velocity,0)
        speed = velocity
      --updatesList:applyLinearImpulse( -0.1, 0, updatesList.x, updatesList.y )
      else
        --updatesList.linearDamping = 3
         if (updatesList:getLinearVelocity() <= 0) then
           velocity = updatesList:getLinearVelocity()+1*fps
           if (velocity >= 10) then velocity = -10 end
           updatesList:setLinearVelocity(velocity,0)
           speed = velocity
          end
         --count = count +40
        --updatesList:applyLinearImpulse( 0.01, 0, updatesList.x, updatesList.y )
      end
      --updatesList.linearDamping = 1
      move = 0
      print ("moved : reset  "..move )]]--



  end
timer.resume( loopTimer )
xVelocity ,yVelocity = updatesList:getLinearVelocity()
print(" Leaving  Velocity : " ..xVelocity)


    return true  -- Prevents tap/touch propagation to underlying objects


end

function scene:create(event)

  local sceneGroup = self.view

  physicsEngine.pause()

  local background = display.newImageRect( sceneGroup,"background.png",360,570)
  background.x = display.contentCenterX
  background.y = display.contentCenterY


  local platformCeil = display.newImageRect(sceneGroup,"platform.png", 360, 0.5)
  platformCeil.x = display.contentCenterX
  platformCeil.y = display.contentCenterY - 60


  local platformFloor = display.newImageRect(sceneGroup,"platform.png", 360, 0.5)
  platformFloor.x = display.contentCenterX
  platformFloor.y = display.contentCenterY + 60



  updatesList = display.newImageRect(sceneGroup,"update.png",1912,110)
  updatesList.x = IMAGEWIDTH/2 + display.contentWidth --956 ( half of width of image)
  updatesList.y = display.contentCenterY
  updatesList.alpha = 0.8

  physicsEngine.addBody(platformCeil ,"static")
  physicsEngine.addBody(platformFloor ,"static")

  physicsEngine.addBody(  updatesList ,"dynamic")

   --constantSpeed = -50
   speed = -60
   velocity = -60


end

function scene:show(event)

  local sceneGroup = self.view
  local phase = event.phase

  if (phase =="will") then

  elseif(phase == "did")  then
     physicsEngine.start()
    loopTimer = timer.performWithDelay( 500,loop ,0)
     updatesList:addEventListener("touch" , navigate)
  end

end

function scene:hide(event)
   local sceneGroup = self.view
   local phase = event.phase

   if (phase =="will") then

   elseif(phase == "did")  then

     physicsEngine.pause()
     timer.cancel( loopTimer)
     updatesList:removeEventListener("touch" , navigate)
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
