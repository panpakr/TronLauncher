local composer = require("composer")

local scene = composer.newScene()

local physicsEngine = require( "physics" )
physicsEngine.start()
physicsEngine.setGravity(0,0)

local radiusList ={5,9,14,20,8}
local appsList = { myCircle1,myCircle2,myCircle3,myCircle4,
                   myCircle5,myCircle6,myCircle7,myCircle8 }
local widgetDim ={}

local mainGroup
local deltaY

local rows = {}
local radRow1
local radRow2
local radRow3
local radRow4
local radRow5
local radRow6
local radRow7

local iconFirst
local icon48
local groupOffset

local offsetMidTransition = 39
local iconOriginY = 35
local paddingFactor = 80

local isScrollable = true

local function scroll(event)

  local phase = event.phase

  print("iconFirst  y : " ..icon1.y .." Icon40.y :"..icon48.y )
  print("Main Group.y : "..  mainGroup.y)

    if ( event.phase == "began" ) then

    elseif ( event.phase == "moved" ) then

      deltaY = (event.y-event.yStart)
      groupOffset = (icon1.y - mainGroup.y)


   print(" deltaY : " ..deltaY .." groupOffset : " .. groupOffset)
    if((groupOffset <= 10  and deltaY >=0) or
      (groupOffset >= 375 and deltaY <=0))

     then
       isScrollable = false
     else
        isScrollable = true
     end

      if(groupOffset >= offsetMidTransition and groupOffset <=paddingFactor)
      then
             if(deltaY<=0) then
             print(" moving up ")

              --rows = {8,5,9,14,20,14,9,5}
              rows = {8,14,20,14,9,5,8,8}
              radRow1 = radiusList[5] --5-->8
              radRow2 = radiusList[1] --9-->5
              radRow3 = radiusList[2] --14-->9
              radRow4 = radiusList[3]  -->20-->14
              radRow5 = radiusList[4] -->14 -->20
              radRow6 = radiusList[3] -->9 --> 14
              radRow7 = radiusList[2] -->5 --> 9
              radRow8 = radiusList[1] -->8 -->5
              widgetDim = {10,10}

            else
              print(" moving down")
              radRow1 = radiusList[1] --5-->8
              radRow2 = radiusList[2] --9-->5
              radRow3 = radiusList[3] --14-->9
              radRow4 = radiusList[4]  -->20-->14
              radRow5 = radiusList[3] -->14 -->20
              radRow6 = radiusList[2] -->9 --> 14
              radRow7 = radiusList[1] -->5 --> 9
              radRow8 = radiusList[5] -->8 -->5
            end
      end

      if(groupOffset >= offsetMidTransition + paddingFactor --[[1*paddingFactor/2 ]]and groupOffset <= 2*offsetMidTransition + paddingFactor ) --2*paddingFactor/2 )
      then

         if(deltaY<=0) then
          print(" first row gone ")
        radRow1 = radiusList[5] --8-->8
        radRow2 = radiusList[5] --5-->8
        radRow3 = radiusList[1] --9-->5
        radRow4 = radiusList[2]  -->14-->9
        radRow5 = radiusList[3] -->20 -->14
        radRow6 = radiusList[4] -->14 --> 20
        radRow7 = radiusList[3] -->9 --> 14
        radRow8 = radiusList[2] -->5 -->9 ]]
        widgetDim = {15,15}

       else
         print(" first row appeared ")
       radRow1 = radiusList[5] --8-->8
       radRow2 = radiusList[1] --5-->8
       radRow3 = radiusList[2] --9-->5
       radRow4 = radiusList[3]  -->14-->9
       radRow5 = radiusList[4] -->20 -->14
       radRow6 = radiusList[3] -->14 --> 20
       radRow7 = radiusList[2] -->9 --> 14
       radRow8 = radiusList[1] -->5 -->9 ]]
      end


      end

      if(groupOffset >= offsetMidTransition + 2*paddingFactor and groupOffset <= 2*offsetMidTransition + 2*paddingFactor ) then

        if(deltaY<=0) then
         print(" secondt row gone ")
        radRow1 = radiusList[5] --5-->8
        radRow2 = radiusList[5] --9-->5
        radRow3 = radiusList[5] --14-->9
        radRow4 = radiusList[1]  -->20-->14
        radRow5 = radiusList[2] -->14 -->20
        radRow6 = radiusList[3] -->9 --> 14
        radRow7 = radiusList[4] -->5 --> 9
        radRow8 = radiusList[3] -->8 -->5 ]]--
        widgetDim = {20,20}

      else
        print(" secondt row appeared ")
       radRow1 = radiusList[5] --5-->8
       radRow2 = radiusList[5] --9-->5
       radRow3 = radiusList[1] --14-->9
       radRow4 = radiusList[2]  -->20-->14
       radRow5 = radiusList[4] -->14 -->20
       radRow6 = radiusList[3] -->9 --> 14
       radRow7 = radiusList[2] -->5 --> 9
       radRow8 = radiusList[1] -->8 -->5 ]]--
     end

      end

      if(groupOffset >= offsetMidTransition + 3*paddingFactor and groupOffset <= 2*offsetMidTransition + 3*paddingFactor ) then


        if(deltaY<=0) then

         print(" 3rd row gone ")
        radRow1 = radiusList[5] --5-->8
        radRow2 = radiusList[5] --9-->5
        radRow3 = radiusList[5] --14-->9
        radRow4 = radiusList[5]  -->20-->14
        radRow5 = radiusList[1] -->14 -->20
        radRow6 = radiusList[2] -->9 --> 14
        radRow7 = radiusList[3] -->5 --> 9
        radRow8 = radiusList[4] -->8 -->5]]
        widgetDim = {30,30}

      else
        print(" 3rd row  appeared ")
       radRow1 = radiusList[5] --5-->8
       radRow2 = radiusList[5] --9-->5
       radRow3 = radiusList[5] --14-->9
       radRow4 = radiusList[1]  -->20-->14
       radRow5 = radiusList[2] -->14 -->20
       radRow6 = radiusList[3] -->9 --> 14
       radRow7 = radiusList[4] -->5 --> 9
       radRow8 = radiusList[3] -->8 -->5 ]]--
     end



      end

      if(groupOffset >= offsetMidTransition + 4*paddingFactor and groupOffset <= 2*offsetMidTransition + 4*paddingFactor ) then

        if(deltaY<=0) then

          print(" 4th row gone ")
          radRow1 = radiusList[5] --5-->8
          radRow2 = radiusList[5] --9-->5
          radRow3 = radiusList[5] --14-->9
          radRow4 = radiusList[5]  -->20-->14
          radRow5 = radiusList[5] -->14 -->20
          radRow6 = radiusList[1] -->9 --> 14
          radRow7 = radiusList[2] -->5 --> 9
          radRow8 = radiusList[3] -->8 -->5]]
          widgetDim = {40,40}

      else
        print(" 4th row  appeared ")
       radRow1 = radiusList[5] --5-->8
       radRow2 = radiusList[5] --9-->5
       radRow3 = radiusList[5] --14-->9
       radRow4 = radiusList[5]  -->20-->14
       radRow5 = radiusList[1] -->14 -->20
       radRow6 = radiusList[2] -->9 --> 14
       radRow7 = radiusList[3] -->5 --> 9
       radRow8 = radiusList[4] -->8 -->5 ]]--
     end



      end

      if(groupOffset >= offsetMidTransition + 5*paddingFactor and groupOffset <=  2*offsetMidTransition + 5*paddingFactor  ) then

        if(deltaY<=0) then

          print(" 5th row gone ")
          radRow1 = radiusList[5] --5-->8
          radRow2 = radiusList[5] --9-->5
          radRow3 = radiusList[5] --14-->9
          radRow4 = radiusList[5]  -->20-->14
          radRow5 = radiusList[5] -->14 -->20
          radRow6 = radiusList[5] -->9 --> 14
          radRow7 = radiusList[1] -->5 --> 9
          radRow8 = radiusList[2] -->8 -->5]]
          widgetDim = {70,70}
      else
        print(" 5th row appeared ")
       radRow1 = radiusList[5] --5-->8
       radRow2 = radiusList[5] --9-->5
       radRow3 = radiusList[5] --14-->9
       radRow4 = radiusList[5]  -->20-->14
       radRow5 = radiusList[5] -->14 -->20
       radRow6 = radiusList[1] -->9 --> 14
       radRow7 = radiusList[2] -->5 --> 9
       radRow8 = radiusList[3] -->8 -->5 ]]--
     end


      end

      if(groupOffset >= offsetMidTransition + 6*paddingFactor and groupOffset <= 2*offsetMidTransition + 6*paddingFactor ) then

        print(" 6th row gone ")
        radRow1 = radiusList[5] --5-->8
        radRow2 = radiusList[5] --9-->5
        radRow3 = radiusList[5] --14-->9
        radRow4 = radiusList[5]  -->20-->14
        radRow5 = radiusList[5] -->14 -->20
        radRow6 = radiusList[5] -->9 --> 14
        radRow7 = radiusList[5] -->5 --> 9
        radRow8 = radiusList[1] -->8 -->5]]
      end

      if(groupOffset >= offsetMidTransition + 7*paddingFactor and groupOffset <= 2*offsetMidTransition + 7*paddingFactor ) then

        print(" 7th row gone ")
        radRow1 = radiusList[5] --5-->8
        radRow2 = radiusList[5] --9-->5
        radRow3 = radiusList[5] --14-->9
        radRow4 = radiusList[5]  -->20-->14
        radRow5 = radiusList[5] -->14 -->20
        radRow6 = radiusList[5] -->9 --> 14
        radRow7 = radiusList[5] -->5 --> 9
        radRow8 = radiusList[5] -->8 -->5]]
      end

      if(groupOffset >= offsetMidTransition + 8*paddingFactor and groupOffset <= 2*offsetMidTransition + 8*paddingFactor ) then

      end

      if(isScrollable ) then
      transition.to( myCircle1.path, { time=400, radius= rows[1] } )
      transition.to( myCircle2.path, { time=400, radius= rows[1]} )
      transition.to( myCircle3.path, { time=400, radius= rows[1] } )
      transition.to( myCircle4.path, { time=400, radius= rows[1] } )


      transition.to( myCircle5.path, { time=400, radius= radRow2 } )
      transition.to( myCircle6.path, { time=400, radius= radRow2 } )
      transition.to( myCircle7.path, { time=400, radius= radRow2 } )
      transition.to( myCircle8.path, { time=400, radius= radRow2 } )

      transition.to( myCircle9.path, { time=400, radius= radRow3 } )
      transition.to( myCircle10.path, { time=400, radius= radRow3 } )
      transition.to( myCircle11.path, { time=400, radius= radRow3 } )
      transition.to( myCircle12.path, { time=400, radius= radRow3 } )

      transition.to( myCircle13.path, { time=400, radius= radRow4 } )
      transition.to( myCircle14.path, { time=400, radius= radRow4 } )
      transition.to( myCircle15.path, { time=400, radius= radRow4 } )
      transition.to( myCircle16.path, { time=400, radius= radRow4 } )

      transition.to( myCircle17.path, { time=400, radius= radRow5 } )
      transition.to( myCircle18.path, { time=400, radius= radRow5 } )
      transition.to( myCircle19.path, { time=400, radius= radRow5 } )
      transition.to( myCircle20.path, { time=400, radius= radRow5 } )

      transition.to( myCircle21.path, { time=400, radius= radRow6 } )
      transition.to( myCircle22.path, { time=400, radius= radRow6 } )
      transition.to( myCircle23.path, { time=400, radius= radRow6 } )
      transition.to( myCircle24.path, { time=400, radius= radRow6 } )

      transition.to( myCircle25.path, { time=400, radius= radRow7 } )
      transition.to( myCircle26.path, { time=400, radius= radRow7 } )
      transition.to( myCircle27.path, { time=400, radius= radRow7 } )
      transition.to( myCircle28.path, { time=400, radius= radRow7 } )

      transition.to( myCircle29.path, { time=400, radius= radRow8 } )
      transition.to( myCircle30.path, { time=400, radius= radRow8 } )
      transition.to( myCircle31.path, { time=400, radius= radRow8 } )
      transition.to( myCircle32.path, { time=400, radius= radRow8 } )

      --transition.to( myWidget, { time=2000, x=10, y=widgetDim[2] } )


     end

     --[[if(groupOffset <= 50) then
         radRowTwo = radiusList[1]
         --radRowOne = radiusList[1]
      end
      if((50 <= groupOffset) and (groupOffset >=60 )) then
          radRowTwo= radiusList[2]
          if(deltaY<0) then
          radRowOne = radiusList[3]
          else
          radRowOne = radiusList[2]
        end
       end
     if((110 <= groupOffset) and (groupOffset >=150 )) then
         radRowTwo= radiusList[3]
         if(deltaY<0) then
         radRowOne = radiusList[4]
         else
         radRowOne = radiusList[3]
       end
      end
      if((200 <= groupOffset) and (groupOffset >=240 )) then
          radRowTwo= radiusList[4]
          if(deltaY<0) then
          radRowOne = radiusList[5]
          else
          radRowOne = radiusList[4]
       end
     end
       transition.to( myCircle5.path, { time=400, radius= radRowOne } )
       transition.to( myCircle6.path, { time=400, radius= radRowOne} )
       transition.to( myCircle7.path, { time=400, radius= radRowOne } )
       transition.to( myCircle8.path, { time=400, radius= radRowOne} )

      transition.to( myCircle1.path, { time=400, radius= radRowTwo } )
      transition.to( myCircle2.path, { time=400, radius= radRowTwo } )
      transition.to( myCircle3.path, { time=400, radius= radRowTwo } )
      transition.to( myCircle4.path, { time=400, radius= radRowTwo } )
 ]]

  elseif ( event.phase == "ended" ) then

  end
--  print( "event.y :"..event.y .." event.yStart : "..event.yStart .." diff : "..(event.y-event.yStart))


  if(isScrollable) then
    deltaY = (event.y-event.yStart)/10
    mainGroup:translate( 0, deltaY)
  else
    print(" I cant get Scrolled")
   end




    return true  -- Prevents tap/touch propagation to underlying objects

end

local function screenInfo()

  print(" display.contentHeight :" ..display.contentHeight)
  print(" display.contentWidth :" ..display.contentWidth)
  print(" display.actualContentHeight :" ..display.actualContentHeight)
  print(" display.actualContentWidth :" ..display.actualContentWidth)
  print(" display.contentCenterX :" ..display.contentCenterX)
  print(" display.contentCenterY :" ..display.contentCenterY)

  print(" display.contentScaleX :" ..display.contentScaleX)
  print(" display.contentScaleY:" ..display.contentScaleY)
  --print(" display.currentStage :" ..display.currentStage)

  print(" display.fps :" ..display.fps)
  --print(" display.imageSuffix :" ..display.imageSuffix)

  print(" display.pixelHeight :" ..display.pixelHeight)
  print(" display.pixelWidth:" ..display.pixelWidth)
  print(" ddisplay.screenOriginX :" ..display.screenOriginX)
  print(" display.screenOriginY :" ..display.actualContentWidth)
  print(" display.statusBarHeight :" ..display.fps)
  print(" display.topStatusBarContentHeight :" ..display.topStatusBarContentHeight)

  print(" display.viewableContentHeight:" ..display.viewableContentHeight)
  print(" display.viewableContentWidth" ..display.viewableContentWidth)

end

function scene:create(event)

local sceneGroup = self.view

mainGroup = display.newGroup()
sceneGroup:insert(mainGroup)

local iconOriginX = 60 --+
--local iconOriginY = 0
local iconHeight  = 75
local iconWidth   = 75
local iconRoundFactor = 4

local radius = 8


 screenInfo()

      icon1  = display.newRoundedRect(mainGroup,iconOriginX + 0*paddingFactor, iconOriginY + 0*paddingFactor, iconWidth, iconHeight, iconRoundFactor)
local icon2  = display.newRoundedRect(mainGroup,iconOriginX + 1*paddingFactor, iconOriginY + 0*paddingFactor, iconWidth, iconHeight, iconRoundFactor)
local icon3  = display.newRoundedRect(mainGroup,iconOriginX + 2*paddingFactor, iconOriginY + 0*paddingFactor, iconWidth, iconHeight, iconRoundFactor)
local icon4  = display.newRoundedRect(mainGroup,iconOriginX + 3*paddingFactor, iconOriginY + 0*paddingFactor, iconWidth, iconHeight, iconRoundFactor)

local icon5  = display.newRoundedRect(mainGroup,iconOriginX + 0*paddingFactor, iconOriginY + 1*paddingFactor, iconWidth, iconHeight, iconRoundFactor)
local icon6  = display.newRoundedRect(mainGroup,iconOriginX + 1*paddingFactor, iconOriginY + 1*paddingFactor, iconWidth, iconHeight, iconRoundFactor)
local icon7  = display.newRoundedRect(mainGroup,iconOriginX + 2*paddingFactor, iconOriginY + 1*paddingFactor, iconWidth, iconHeight, iconRoundFactor)
local icon8  = display.newRoundedRect(mainGroup,iconOriginX + 3*paddingFactor, iconOriginY + 1*paddingFactor, iconWidth, iconHeight, iconRoundFactor)

local icon9  = display.newRoundedRect(mainGroup,iconOriginX + 0*paddingFactor, iconOriginY + 2*paddingFactor, iconWidth, iconHeight, iconRoundFactor)
local icon10 = display.newRoundedRect(mainGroup,iconOriginX + 1*paddingFactor, iconOriginY + 2*paddingFactor, iconWidth, iconHeight, iconRoundFactor)
local icon11 = display.newRoundedRect(mainGroup,iconOriginX + 2*paddingFactor, iconOriginY + 2*paddingFactor, iconWidth, iconHeight, iconRoundFactor)
local icon12 = display.newRoundedRect(mainGroup,iconOriginX + 3*paddingFactor, iconOriginY + 2*paddingFactor, iconWidth, iconHeight, iconRoundFactor)

local icon13 = display.newRoundedRect(mainGroup,iconOriginX + 0*paddingFactor, iconOriginY + 3*paddingFactor, iconWidth, iconHeight, iconRoundFactor)
local icon14 = display.newRoundedRect(mainGroup,iconOriginX + 1*paddingFactor, iconOriginY + 3*paddingFactor, iconWidth, iconHeight, iconRoundFactor)
local icon15 = display.newRoundedRect(mainGroup,iconOriginX + 2*paddingFactor, iconOriginY + 3*paddingFactor, iconWidth, iconHeight, iconRoundFactor)
local icon16 = display.newRoundedRect(mainGroup,iconOriginX + 3*paddingFactor, iconOriginY + 3*paddingFactor, iconWidth, iconHeight, iconRoundFactor)

local icon17 = display.newRoundedRect(mainGroup,iconOriginX + 0*paddingFactor, iconOriginY + 4*paddingFactor, iconWidth, iconHeight, iconRoundFactor)
local icon18 = display.newRoundedRect(mainGroup,iconOriginX + 1*paddingFactor, iconOriginY + 4*paddingFactor, iconWidth, iconHeight, iconRoundFactor)
local icon19 = display.newRoundedRect(mainGroup,iconOriginX + 2*paddingFactor, iconOriginY + 4*paddingFactor, iconWidth, iconHeight, iconRoundFactor)
local icon20 = display.newRoundedRect(mainGroup,iconOriginX + 3*paddingFactor, iconOriginY + 4*paddingFactor, iconWidth, iconHeight, iconRoundFactor)

local icon21 = display.newRoundedRect(mainGroup,iconOriginX + 0*paddingFactor, iconOriginY + 5*paddingFactor, iconWidth, iconHeight, iconRoundFactor)
local icon22 = display.newRoundedRect(mainGroup,iconOriginX + 1*paddingFactor, iconOriginY + 5*paddingFactor, iconWidth, iconHeight, iconRoundFactor)
local icon23 = display.newRoundedRect(mainGroup,iconOriginX + 2*paddingFactor, iconOriginY + 5*paddingFactor, iconWidth, iconHeight, iconRoundFactor)
local icon24 = display.newRoundedRect(mainGroup,iconOriginX + 3*paddingFactor, iconOriginY + 5*paddingFactor, iconWidth, iconHeight, iconRoundFactor)

local icon25 = display.newRoundedRect(mainGroup,iconOriginX + 0*paddingFactor, iconOriginY + 6*paddingFactor, iconWidth, iconHeight, iconRoundFactor)
local icon26 = display.newRoundedRect(mainGroup,iconOriginX + 1*paddingFactor, iconOriginY + 6*paddingFactor, iconWidth, iconHeight, iconRoundFactor)
local icon27 = display.newRoundedRect(mainGroup,iconOriginX + 2*paddingFactor, iconOriginY + 6*paddingFactor, iconWidth, iconHeight, iconRoundFactor)
local icon28 = display.newRoundedRect(mainGroup,iconOriginX + 3*paddingFactor, iconOriginY + 6*paddingFactor, iconWidth, iconHeight, iconRoundFactor)

local icon29 = display.newRoundedRect(mainGroup,iconOriginX + 0*paddingFactor, iconOriginY + 7*paddingFactor, iconWidth, iconHeight, iconRoundFactor)
local icon30 = display.newRoundedRect(mainGroup,iconOriginX + 1*paddingFactor, iconOriginY + 7*paddingFactor, iconWidth, iconHeight, iconRoundFactor)
local icon31 = display.newRoundedRect(mainGroup,iconOriginX + 2*paddingFactor, iconOriginY + 7*paddingFactor, iconWidth, iconHeight, iconRoundFactor)
local icon32 = display.newRoundedRect(mainGroup,iconOriginX + 3*paddingFactor, iconOriginY + 7*paddingFactor, iconWidth, iconHeight, iconRoundFactor)

local icon33 = display.newRoundedRect(mainGroup,iconOriginX + 0*paddingFactor, iconOriginY + 8*paddingFactor, iconWidth, iconHeight, iconRoundFactor)
local icon34 = display.newRoundedRect(mainGroup,iconOriginX + 1*paddingFactor, iconOriginY + 8*paddingFactor, iconWidth, iconHeight, iconRoundFactor)
local icon35 = display.newRoundedRect(mainGroup,iconOriginX + 2*paddingFactor, iconOriginY + 8*paddingFactor, iconWidth, iconHeight, iconRoundFactor)
local icon36 = display.newRoundedRect(mainGroup,iconOriginX + 3*paddingFactor, iconOriginY + 8*paddingFactor, iconWidth, iconHeight, iconRoundFactor)

local icon37 = display.newRoundedRect(mainGroup,iconOriginX + 0*paddingFactor, iconOriginY + 9*paddingFactor, iconWidth, iconHeight, iconRoundFactor)
local icon38 = display.newRoundedRect(mainGroup,iconOriginX + 1*paddingFactor, iconOriginY + 9*paddingFactor, iconWidth, iconHeight, iconRoundFactor)
local icon39 = display.newRoundedRect(mainGroup,iconOriginX + 2*paddingFactor, iconOriginY + 9*paddingFactor, iconWidth, iconHeight, iconRoundFactor)
local icon40 = display.newRoundedRect(mainGroup,iconOriginX + 3*paddingFactor, iconOriginY + 9*paddingFactor, iconWidth, iconHeight, iconRoundFactor)

local icon41 = display.newRoundedRect(mainGroup,iconOriginX + 0*paddingFactor, iconOriginY + 10*paddingFactor, iconWidth, iconHeight, iconRoundFactor)
local icon42 = display.newRoundedRect(mainGroup,iconOriginX + 1*paddingFactor, iconOriginY + 10*paddingFactor, iconWidth, iconHeight, iconRoundFactor)
local icon43 = display.newRoundedRect(mainGroup,iconOriginX + 2*paddingFactor, iconOriginY + 10*paddingFactor, iconWidth, iconHeight, iconRoundFactor)
local icon44 = display.newRoundedRect(mainGroup,iconOriginX + 3*paddingFactor, iconOriginY + 10*paddingFactor, iconWidth, iconHeight, iconRoundFactor)

local icon45 = display.newRoundedRect(mainGroup,iconOriginX + 0*paddingFactor, iconOriginY + 11*paddingFactor, iconWidth, iconHeight, iconRoundFactor)
local icon46 = display.newRoundedRect(mainGroup,iconOriginX + 1*paddingFactor, iconOriginY + 11*paddingFactor, iconWidth, iconHeight, iconRoundFactor)
local icon47 = display.newRoundedRect(mainGroup,iconOriginX + 2*paddingFactor, iconOriginY + 11*paddingFactor, iconWidth, iconHeight, iconRoundFactor)
      icon48 = display.newRoundedRect(mainGroup,iconOriginX + 3*paddingFactor, iconOriginY + 11*paddingFactor, iconWidth, iconHeight, iconRoundFactor)

--row 1
myCircle1 = display.newCircle(mainGroup,iconOriginX + 0*paddingFactor,iconOriginY + 0*paddingFactor,radius)
myCircle1:setFillColor( 0 ,0,1)
myCircle1.path.radius = radiusList[1]

myCircle2 = display.newCircle(mainGroup,iconOriginX + 1*paddingFactor,iconOriginY + 0*paddingFactor,radius)
myCircle2:setFillColor( 0,0.5,0.5)
myCircle2.path.radius = radiusList[1]

myCircle3 = display.newCircle(mainGroup,iconOriginX + 2*paddingFactor,iconOriginY + 0*paddingFactor,radius)
myCircle3:setFillColor( 0.5,0.5,0.5)
myCircle3.path.radius = radiusList[1]

myCircle4 = display.newCircle( mainGroup,iconOriginX + 3*paddingFactor,iconOriginY + 0*paddingFactor,radius)
myCircle4:setFillColor( 1,0 ,0)
myCircle4.path.radius = radiusList[1]

--row 2
myCircle5 = display.newCircle(mainGroup,iconOriginX + 0*paddingFactor,iconOriginY + 1*paddingFactor,radius)
myCircle5:setFillColor( 0 )
myCircle5.path.radius = radiusList[2]

myCircle6 = display.newCircle(mainGroup,iconOriginX + 1*paddingFactor,iconOriginY + 1*paddingFactor,radius)
myCircle6:setFillColor( 0.20)
myCircle6.path.radius = radiusList[2]

myCircle7 = display.newCircle(mainGroup,iconOriginX + 2*paddingFactor,iconOriginY + 1*paddingFactor,radius)
myCircle7:setFillColor( 0.60)
myCircle7.path.radius = radiusList[2]

myCircle8 = display.newCircle(mainGroup,iconOriginX + 3*paddingFactor,iconOriginY + 1*paddingFactor,radius)
myCircle8:setFillColor( 0.80)
myCircle8.path.radius = radiusList[2]


----row 3
myCircle9 = display.newCircle(mainGroup,iconOriginX + 0*paddingFactor,iconOriginY + 2*paddingFactor,radius)
myCircle9:setFillColor( 0 ,0,1)
myCircle9.path.radius = radiusList[3]

myCircle10 = display.newCircle(mainGroup,iconOriginX + 1*paddingFactor,iconOriginY + 2*paddingFactor,radius)
myCircle10:setFillColor( 0,0.5,0.5)
myCircle10.path.radius = radiusList[3]

myCircle11 = display.newCircle(mainGroup,iconOriginX + 2*paddingFactor,iconOriginY + 2*paddingFactor,radius)
myCircle11:setFillColor( 0.5,0.5,0.5)
myCircle11.path.radius = radiusList[3]

myCircle12 = display.newCircle( mainGroup,iconOriginX + 3*paddingFactor,iconOriginY + 2*paddingFactor,radius)
myCircle12:setFillColor( 1,0 ,0)
myCircle12.path.radius = radiusList[3]


----row 4
myCircle13 = display.newCircle(mainGroup,iconOriginX + 0*paddingFactor,iconOriginY + 3*paddingFactor,radius)
myCircle13:setFillColor( 0 )
myCircle13.path.radius = radiusList[4]

myCircle14 = display.newCircle(mainGroup,iconOriginX + 1*paddingFactor,iconOriginY + 3*paddingFactor,radius)
myCircle14:setFillColor( 0.20)
myCircle14.path.radius = radiusList[4]

myCircle15 = display.newCircle(mainGroup,iconOriginX + 2*paddingFactor,iconOriginY + 3*paddingFactor,radius)
myCircle15:setFillColor( 0.60)
myCircle15.path.radius = radiusList[4]

myCircle16 = display.newCircle(mainGroup,iconOriginX + 3*paddingFactor,iconOriginY + 3*paddingFactor,radius)
myCircle16 :setFillColor( 0.80)
myCircle16 .path.radius = radiusList[4]

----row 5
myCircle17 = display.newCircle(mainGroup,iconOriginX + 0*paddingFactor,iconOriginY + 4*paddingFactor,radius)
myCircle17:setFillColor( 0 ,0,1)
myCircle17.path.radius = radiusList[3]

myCircle18 = display.newCircle(mainGroup,iconOriginX + 1*paddingFactor,iconOriginY + 4*paddingFactor,radius)
myCircle18:setFillColor( 0,0.5,0.5)
myCircle18.path.radius = radiusList[3]

myCircle19 = display.newCircle(mainGroup,iconOriginX + 2*paddingFactor,iconOriginY + 4*paddingFactor,radius)
myCircle19:setFillColor( 0.5,0.5,0.5)
myCircle19.path.radius = radiusList[3]

myCircle20 = display.newCircle( mainGroup,iconOriginX + 3*paddingFactor,iconOriginY + 4*paddingFactor,radius)
myCircle20:setFillColor( 1,0 ,0)
myCircle20.path.radius = radiusList[3]


----row 6
myCircle21 = display.newCircle(mainGroup,iconOriginX + 0*paddingFactor,iconOriginY + 5*paddingFactor,radius)
myCircle21:setFillColor( 0 )
myCircle21.path.radius = radiusList[2]

myCircle22 = display.newCircle(mainGroup,iconOriginX + 1*paddingFactor,iconOriginY + 5*paddingFactor,radius)
myCircle22:setFillColor( 0.20)
myCircle22.path.radius = radiusList[2]

myCircle23 = display.newCircle(mainGroup,iconOriginX + 2*paddingFactor,iconOriginY + 5*paddingFactor,radius)
myCircle23:setFillColor( 0.60)
myCircle23.path.radius = radiusList[2]

myCircle24 = display.newCircle(mainGroup,iconOriginX + 3*paddingFactor,iconOriginY + 5*paddingFactor,radius)
myCircle24 :setFillColor( 0.80)
myCircle24 .path.radius = radiusList[2]

--row 7
myCircle25 = display.newCircle(mainGroup,iconOriginX + 0*paddingFactor,iconOriginY + 6*paddingFactor,radius)
myCircle25:setFillColor( 0 ,0,1)
myCircle25.path.radius = radiusList[1]

myCircle26 = display.newCircle(mainGroup,iconOriginX + 1*paddingFactor,iconOriginY + 6*paddingFactor,radius)
myCircle26:setFillColor( 0,0.5,0.5)
myCircle26.path.radius = radiusList[1]

myCircle27 = display.newCircle(mainGroup,iconOriginX + 2*paddingFactor,iconOriginY + 6*paddingFactor,radius)
myCircle27:setFillColor( 0.5,0.5,0.5)
myCircle27.path.radius = radiusList[1]

myCircle28 = display.newCircle(mainGroup,iconOriginX + 3*paddingFactor,iconOriginY + 6*paddingFactor,radius)
myCircle28:setFillColor( 1,0 ,0)
myCircle28.path.radius = radiusList[1]


----row 8
myCircle29 = display.newCircle(mainGroup,iconOriginX + 0*paddingFactor,iconOriginY + 7*paddingFactor,radius)
myCircle29:setFillColor( 0 )
myCircle29.path.radius = radiusList[5]

myCircle30 = display.newCircle(mainGroup,iconOriginX + 1*paddingFactor,iconOriginY + 7*paddingFactor,radius)
myCircle30:setFillColor( 0.20)
myCircle30.path.radius = radiusList[5]

myCircle31 = display.newCircle(mainGroup,iconOriginX + 2*paddingFactor,iconOriginY + 7*paddingFactor,radius)
myCircle31:setFillColor( 0.60)
myCircle31.path.radius = radiusList[5]

myCircle32 = display.newCircle(mainGroup,iconOriginX + 3*paddingFactor,iconOriginY + 7*paddingFactor,radius)
myCircle32:setFillColor( 0.80)
myCircle32.path.radius = radiusList[5]

myCircle33= display.newCircle(mainGroup,iconOriginX + 0*paddingFactor,iconOriginY + 8*paddingFactor,radius)
myCircle33 :setFillColor( 0.80)
myCircle33 .path.radius = radiusList[5]

myWidget = display.newRect( mainGroup,iconOriginX + 0*paddingFactor, iconOriginY + 9*paddingFactor, 10, 10 )
myWidget:setFillColor(1,0,0.5)
physicsEngine.addBody(mainGroup ,"dynamic")


mainGroup:addEventListener("touch",scroll)

end

function scene:show(event)

  local sceneGroup = self.view
  local phase = event.phase

  if (phase =="will") then

  elseif(phase == "did")  then


  -- Runtime:addEventListener("enterFrame",scroll)
  end

end

function scene:hide(event)
   local sceneGroup = self.view
   local phase = event.phase

   if (phase =="will") then

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
