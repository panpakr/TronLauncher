--====================================================================--
-- OO Drop Target
--
-- Sample code is MIT licensed, the same license which covers Lua itself
-- http://en.wikipedia.org/wiki/MIT_License
-- Copyright (C) 2011-2015 David McCuskey. All Rights Reserved.
--====================================================================--



--===================================================================--
--== Imports

local composer = require("composer")
local DragMgr = require 'dmc_corona.dmc_dragdrop'
local Objects = require 'dmc_corona.dmc_objects'
local Utils = require 'dmc_corona.dmc_utils'
local drop_item = require 'appDrawer.apps.drop_item'


local item
--===================================================================--
--== Setup, Constants

local dropCordinates = {550,700,850,1000,1150,1300,1450,1600}
local occupiedCordinates ={}

local offset = 150
local startY = 300
-- setup some aliases to make code cleaner
local newClass = Objects.newClass
local ComponentBase = Objects.ComponentBase


local appGrouping = display.newGroup()
--===================================================================--
--== Support Functions


local function goToAppMoveCollection()
  composer.removeScene( "appDrawer.apps.appmovecollection" )
  composer.gotoScene("appDrawer.apps.appmovecollection" ,{effect = "crossFade" ,time = 100})
end

-- createSquare()
--
-- function to help create shapes, useful for drag/drop target examples
--
local function createSquare( params )
	params = params or {}
	assert( type(params)=='table', "createSquare requires params" )
	assert( params.height and params.width, "createSquare requires height and width" )
	if params.fillColor==nil then params.fillColor=DragMgr.COLOR_LIGHTGREY end
	if params.strokeColor==nil then params.strokeColor=DragMgr.COLOR_GREY end
	if params.strokeWidth==nil then params.strokeWidth=3 end
	--==--
	local o = display.newRect(0, 0, params.width, params.height )
	o.strokeWidth = params.strokeWidth
  o.alpha = 0.01
	o:setFillColor( unpack( params.fillColor ) )
	o:setStrokeColor( unpack( params.strokeColor ) )
	return o
end




--====================================================================--
--== Drop Target Class
--====================================================================--


local DropTarget = newClass( ComponentBase, {name="Drop Target"} )


--======================================================--
-- Start: Setup DMC Objects

-- __init__()
-- called by new()
-- one of the base methods to override for dmc_objects
-- here we save params, initialize basic properties, etc
--
function DropTarget:__init__( params )
	-- print( "DropTarget:__init__" )
	self:superCall( '__init__', params )
	params = params or {}
	if params.format == nil then params.format = {} end
	if params.color == nil then params.color = DragMgr.COLOR_LIGHTGREY end
	--==--

	if type(params.format) =='string' then
		params.format = { params.format }
	end

	--== Create Properties ==--

	self._score = 0
	self._format = params.format
	self._color = params.color	-- { 255, 25, 255 }
	self._background = nil
	self._scoreboard = nil
  self._dropItem = nil

end


-- __createView__()
--
-- one of the base methods to override for dmc_objects
-- here we put on our display properties
--
function DropTarget:__createView__()
	-- print( "DropTarget:__createView__" )
	self:superCall( '__createView__' )
	--==--

	local o

	-- background

	o = createSquare{
		width=150, height=1610,
		fillColor=self._color
	}
	o.anchorX, o.anchorY = 0.5, 0.5
	o.x, o.y = 0, 0

	self:insert( o )
	self._background = o

	-- scoreboard

	o = display.newText( "", 0, 0, native.systemFont, 24 )
	o:setTextColor( 0, 0, 0, 255 )
	o.anchorX, o.anchorY = 0.5, 0.5
	o.x, o.y = 0, 0

	self:insert( o )
	self._scoreboard = o

end


-- __initComplete__()
--
-- post init actions
-- base dmc_object override
--
function DropTarget:__initComplete__()
	-- print( "DropTarget:__initComplete__" )
	self:superCall( '__initComplete__' )
	--==--

	-- draw initial score
	--self:_updateScore()
end

-- END: Setup DMC Objects
--======================================================--



--====================================================================--
--== Public Methods


-- none



--====================================================================--
--== Private Methods


function DropTarget:_incrementScore()
	self._score = self._score + 1
	--self:_updateScore()
end

function DropTarget:_updateScore()
	self._scoreboard.text = tostring( self._score )
	self._scoreboard.x, self._scoreboard.y = 0, 0
end



--====================================================================--
--== Event Handlers


--== define method handlers for each drag phase


function DropTarget:dragStart( e )

	local data_format = e.format

	-- loop over the data formats and see if we match
	if Utils.propertyIn( self._format, data_format ) then
		--self._background:setStrokeColor( unpack( DragMgr.COLOR_RED ) )
	end

	return true
end
function DropTarget:dragEnter( e )
	-- must accept drag here

	local data_format = e.format
  print("Drag Enter ", data_format )
	-- loop over the data formats and see if we match
	if Utils.propertyIn( self._format, data_format ) then
		--self._background:setFillColor( unpack( DragMgr.COLOR_LIGHTGREY) )
		DragMgr:acceptDragDrop()
	end

	return true
end
function DropTarget:dragOver( e )

	return true
	end


local function shuffle(Ypos)

   table.insert(occupiedCordinates, Ypos )
   table.remove(dropCordinates, 1,Ypos )

  for i=1,#dropCordinates do


        print("DroppPoints " ..dropCordinates[i] )
    end

    for i=1,#occupiedCordinates do

        print( "Occupied Points "..occupiedCordinates[i] )

      end
 end
--local app1,app2,app3,app4,app5,app6,app7
function DropTarget:dragDrop( e )

	self:_incrementScore()

  if(self._score >0) then

    if(item.type == "red" and Utils.propertyIn( self._format, "red" )) then

    local  Ypos =   dropCordinates[1]
    drop_item:setLocation(item ,1000 ,Ypos)
    drop_item:setType(item)

    shuffle(Ypos)

  elseif(item.type == "blue" )then --and Utils.propertyIn( self._format, "blue" ) ) then

        --shuffle(item.y)
        table.insert( dropCordinates, item.y )
        local pos = table.indexOf(occupiedCordinates ,item.y)
        table.remove( occupiedCordinates, pos ,item.y )

        if(item.id =="A1") then
          drop_item:setLocation(item ,85 ,980)
          drop_item:setType(item)
        end
        if(item.id =="A2") then
          drop_item:setLocation(item ,333 ,980)
          drop_item:setType(item)
        end

        if(item.id =="A3") then
          drop_item:setLocation(item ,593 ,980)
          drop_item:setType(item)
        end

        if(item.id =="A4") then
          drop_item:setLocation(item ,836 ,980)
          drop_item:setType(item)
        end

        if(item.id =="A5") then
          drop_item:setLocation(item ,85 ,1150)
          drop_item:setType(item)
        end

        if(item.id =="A6") then
          drop_item:setLocation(item ,333 ,1150)
          drop_item:setType(item)
        end

        if(item.id =="B1") then
          drop_item:setLocation(item ,593 ,1150)
          drop_item:setType(item)
        end

        if(item.id =="G1") then
          drop_item:setLocation(item ,836 ,1150)
          drop_item:setType(item)
        end
	end
end

   --startY = app1.y

	self:dragExit( e )

	return true
end
function DropTarget:dragExit( e )


	self._background:setFillColor( unpack( self._color ) )

	return true
end
function DropTarget:dragStop( e )


	--self._background:setStrokeColor( unpack( DragMgr.COLOR_GREY ) )

	return true
end

function DropTarget:destroyObjects( e )

  print("Destroying Objects")
	--[[if(app1 ~= nil) then
  app1:removeSelf()
	app1 = nil-
  end
]]


	return true
end

function DropTarget:isDragSuccess( )

  if(self._score == 1) then
    return true
  end

	return false
end

function DropTarget:SetDropItem(drop_item)

 print("Drop Item :" ..drop_item.id .."Type :" ,drop_item.type )
  item = drop_item
end



return DropTarget
