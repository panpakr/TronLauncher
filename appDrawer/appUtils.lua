--local appUtils ={}
local appRows= { "Row1","Row2","Row3","Row4","Row5","Row6","Row7","Row8","Row9",
                    "Row10","Row11","Row12","Row13","Row14","Row15","Row16","Row17","Row18",
                    "Row19","Row20","Row21","Row22","Row23","Row24","Row25","Row26","Row27"}

local widgetCount = 1
local widgetRowCount = 1

local appsRowsTable = {}
local widgetsRowsTable = {}

local launcherAppsStructure = {}

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

function launcherAppsStructure:constructAppRows(rowValue)

table.insert( appsRowsTable,  rowValue)
end


function launcherAppsStructure:UpdateWigetsRowTable(rowValue,remainingWidgets)
  table.insert( widgetsRowsTable,  rowValue ,{true ,remainingWidgets})
end

function launcherAppsStructure:constructWidgetsRows(rowValue)

table.insert( widgetsRowsTable,  rowValue ,{false,0})
end


function launcherAppsStructure:findAppRow(appID)

--  print("app Row Value  " ,appsRowsTable[appID])
  return appsRowsTable[appID]
end

local function display()

  for i = 1,#appsRowsTable do

  print("App # "..i .." Position " .. appsRowsTable[i] )
  end


  for i = 1,#widgetsRowsTable do
 print("Widgets # "..i .." value  " ,widgetsRowsTable[i][1]," remainingWidgets :"..widgetsRowsTable[i][2])
  end

  for i = 1,#launcherAppsStructure do

  print("Row # "..i .." Type "..launcherAppsStructure[i][1].. " count "..launcherAppsStructure[i][2])
   if(string.starts(launcherAppsStructure[i][1] ,"Row")) then
   --print("Apps  " ..launcherAppsStructure[i][3][1] )--.. "icon" ..launcherAppsStructure[i][3][2] )
   else
    print("widgets " ..launcherAppsStructure[i][3][1] .. " Type " ..launcherAppsStructure[i][3][2]  .." App "..launcherAppsStructure[i][3][3])
  end

  end



end

function launcherAppsStructure:findWidgetsRow(pos)

  --print("app Row Value  " ,appsRowsTable[appID])
  return widgetsRowsTable[pos]
end

function launcherAppsStructure:UpdateAppRows(appID)

  local count = 1
  local bottomLimit = appID - math.fmod(appID,4)
  local topLimit =  appID + (4-math.fmod(appID,4))
  display()
  --local rows = appsRowsTable/4
  local totalRows = #launcherAppsStructure

  for i = 1 ,totalRows do

     if(widgetsRowsTable[i][1] == true )then



      --  for j = count ,#appsRowsTable do
        --appsRowsTable[j] = appsRowsTable[j]+1
      --  end

      -- appsRowsTable[count]
      --appsRowsTable[count+1]
      --appsRowsTable[count+2]
      --appsRowsTable[count+3]

     else
       if(launcherAppsStructure[i][2] == 4)then
       appsRowsTable[count] = i
       appsRowsTable[count+1] = i
       appsRowsTable[count+2] = i
       appsRowsTable[count+3] = i
      else
        appsRowsTable[count] = i
        appsRowsTable[count+1] = i
      end

      count = count +launcherAppsStructure[i][2]
     end

  end


  display()

end



--[[
    for i = 1 ,#appsRowsTable do


    --  if(appsRowsTable[i]~=appsRowsTable[i-1])then


      if(appsRowsTable[i]==widgetRowsTable[count]) then
           if(i == topLimit +1)then
             count =count +1
           end

         appsRowsTable[i] = appsRowsTable[i]+1


       end

     if(i > bottomLimit  )then

     appsRowsTable[i] = appsRowsTable[i]+widgetRowCount
    end
  end
]]


function launcherAppsStructure:insert(pos,rowInfo)
 table.insert(launcherAppsStructure,pos,rowInfo)
end

function launcherAppsStructure:getWidgetsCount()
return widgetCount
end

function launcherAppsStructure:getWidgetsRowsCount()
return widgetRowCount
end

function launcherAppsStructure:updateWidgetsRowsCount()
 widgetRowCount = widgetRowCount +1
end

function launcherAppsStructure:updateWidgetsCount()
 widgetCount = widgetCount +1
end

return launcherAppsStructure
