Citizen.CreateThread(function()
	RegisterCommand("traction", function(source, args, rawCommand)
		tc = true
		TC()
	end)
end)



Citizen.CreateThread(function()
	RegisterCommand("tractionoff", function(source, args, rawCommand)
		tc = false
		TC()
	end)
end)

cruse = false
Citizen.CreateThread(function()
	if Config.CCon == true then
		while true do
		Wait(20)
		local playerped = GetPlayerPed(-1)
			if IsPedSittingInAnyVehicle(playerped) then 
			local veh =	GetVehiclePedIsIn(playerped,false)
				if playerped == GetPedInVehicleSeat(veh,-1) then
					if IsControlPressed(0,Config.CCkey) then
					cruse = true
					Cruse()
					end
				end
			else
			Wait(2500)	
			end
		end
	end
end)



function TC()
		if not HasStreamedTextureDictLoaded('cctcimages') then
			RequestStreamedTextureDict('cctcimages', true)
			while not HasStreamedTextureDictLoaded('cctcimages') do
				Wait(0)
			end
			end
playerped = GetPlayerPed(-1)
local veh =	GetVehiclePedIsIn(playerped,false)
local drivebias = GetVehicleHandlingFloat(veh,"CHandlingData", "fDriveBiasFront")

oldvalue = GetVehicleHandlingFloat(vehicle,'CHandlingData','fLowSpeedTractionLossMult')		
repeat
Wait(0)
if IsPedGettingIntoAVehicle(playerped) then
Wait(2000)
veh =	GetVehiclePedIsIn(playerped,false)
drivebias = GetVehicleHandlingFloat(veh,"CHandlingData", "fDriveBiasFront")
oldvalue = GetVehicleHandlingFloat(vehicle,'CHandlingData','fLowSpeedTractionLossMult')	
end


if IsPedInAnyVehicle(playerped) then
	if tcacting == true then
	--	SetVehicleHandlingField(vehicle,'CHandlingData','fLowSpeedTractionLossMult',newvalue5)	
	--SetVehicleEngineTorqueMultiplier(veh, var1)
	else
	SetVehicleHandlingField(vehicle,'CHandlingData','fLowSpeedTractionLossMult',oldvalue)	
	SetVehicleEngineTorqueMultiplier(veh, 1.0)
	end
var1 = 1.0		
mod1 = 0.0	
newvalue5 = oldvalue

tcacting = false	


wh1 = GetVehicleWheelSpeed(veh,0)
wh1 = (GetVehicleWheelSpeed(veh,1) + wh1) / 2 
wh2 = (GetVehicleWheelSpeed(veh,1) + wh1) / 2 
wh3 = GetVehicleWheelSpeed(veh,2)
wh4 = GetVehicleWheelSpeed(veh,3) 
throttle = 0.0 
wheelave = (GetVehicleWheelSpeed(veh,0) + GetVehicleWheelSpeed(veh,1) + GetVehicleWheelSpeed(veh,2) + GetVehicleWheelSpeed(veh,3)) / 4
if Config.OnScreendisplayTC == true then
DrawRect(UITC.x + 0.01 ,UITC.y + 0.04 ,0.05,0.01,0,0,0,255)
end
steerang = GetVehicleSteeringAngle(veh)
	if steerang > 1 then
	mod1 = steerang / 20
	elseif steerang < -1.0 then
	steerang = steerang - steerang*2
	mod1 = steerang / 20
	end
	if wh1 > (wheelave + 0.05 + mod1) then
	var1 = 1.0 / ((wh1 - (wheelave + 0.00 + mod1) )- 0.04) *Config.action
	newvalue5 = oldvalue * var1
	tcacting = true
	elseif  wh2 > (wheelave + 0.05 + mod1) then
	var1 = 1.0 / ((wh2 - (wheelave + 0.00 + mod1) )- 0.04) *Config.action
	newvalue5 = oldvalue * var1 
	tcacting = true
	elseif  wh3 > (wheelave + 0.05 + mod1) then
	var1 = 1.0 / ((wh3 - (wheelave + 0.00 + mod1) )- 0.04) *Config.action
	newvalue5 = oldvalue * var1
	tcacting = true
	elseif  wh4 > (wheelave + 0.05 + mod1) then
	var1 = 1.0 / ((wh4 - (wheelave + 0.00 + mod1) )- 0.04) *Config.action
	newvalue5 = oldvalue * var1
	tcacting = true
	end
	if tcacting == true then
		if newvalue5 > 0.0 and newvalue5 < oldvalue  then
		SetVehicleHandlingField(vehicle,'CHandlingData','fLowSpeedTractionLossMult',newvalue5)
		newvalue5 = oldvalue * var1
		elseif newvalue5 > oldvalue then
		newvalue5 = oldvalue * var1
		SetVehicleHandlingField(vehicle,'CHandlingData','fLowSpeedTractionLossMult',newvalue5)
		elseif newvalue5 < 0.0 then
		newvalue5 = 0.01
		SetVehicleHandlingField(vehicle,'CHandlingData','fLowSpeedTractionLossMult',newvalue5)
		end
		if var1 < 1.0 then
		SetVehicleEngineTorqueMultiplier(veh, var1)
			if var1 < 0.98 then
			drawbox(UITC.x - 0.01 ,UITC.y + 0.04,0,255)
			end
			if var1 < 0.7 then
			drawbox(UITC.x - 0.00 ,UITC.y + 0.04 ,100,200)
			end
			if var1 < 0.5 then
			drawbox(UITC.x + 0.01 ,UITC.y + 0.04 ,150,200)
			end
			if var1 < 0.3 then
			drawbox(UITC.x + 0.02 ,UITC.y + 0.04 ,150,100)
			end
			if var1 < 0.2 then
			drawbox(UITC.x + 0.03 ,UITC.y + 0.04,233,0)
			end
		else
		var1 = 1.0
		SetVehicleEngineTorqueMultiplier(veh, var1)
		end

	end
	if Config.OnScreenTextTC then
	drawTxta(UITC.x - 0.0 ,UITC.y + 0.0 ,0.55,"~w~TC ~g~ON", 255,50,0,255)
	end
	if Config.SimpleTCimmage then
	if tcacting == true then
	DrawSprite('cctcimages','SRTC1',UITC.x + 0.04 ,UITC.y + 0.02,0.014,0.024,0.0,255,255,255,200)
else
	DrawSprite('cctcimages','SRTC2',UITC.x + 0.04 ,UITC.y + 0.02,0.014,0.024,0.0,255,255,255,200)	
	end
	end
	if Config.Watermark then
	drawTxtb(UITC.x - 0.01 ,UITC.y + 0.041 ,0.27,"By DOJSRC", 255,255,255,255)
	end
	if IsControlJustPressed(0,Config.TCkey) or IsControlJustPressed(0,Config.TCkey) then
	SetVehicleMaxSpeed(veh,300.0)
	tc = false
	elseif IsPedInAnyVehicle(playerped,true) == false and Config.enableTCtoggle == false then
	tc = false
	end
end
until tc == false
SetVehicleHandlingField(vehicle,'CHandlingData','fLowSpeedTractionLossMult',oldvalue)
Wait(500)
end

function drawbox(x,y,r,g)
	if Config.OnScreendisplayTC == true then
	
	DrawRect(x,y,0.01,0.01,r,g,0,255)
	end
end

function round(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    if num >= 0 then return math.floor(num * mult + 0.5) / mult
    else return math.ceil(num * mult - 0.5) / mult end
end

function toint(n)
    local s = tostring(n)
    local i, j = s:find('%.')
    if i then
        return tonumber(s:sub(1, i-1))
    else
        return n
    end
end


function drawTxta(x, y, scale, text, r, g, b, a)
		SetTextFont(4)
		SetTextProportional(0)
		SetTextScale(scale, scale)
		SetTextColour(r, g, b, a)
		SetTextDropShadow(0, 0, 0, 0,255)
		SetTextEdge(1, 0, 0, 0, 255)
		SetTextDropShadow()
		SetTextOutline()
		SetTextEntry("STRING")
		AddTextComponentString(text)
		DrawText(x, y)

end

function drawTxtb(x, y, scale, text, r, g, b, a)
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end

Citizen.CreateThread(function()
	RegisterCommand("traction", function(source, args, rawCommand)
		tc = true
		TC()
	end)
end)
