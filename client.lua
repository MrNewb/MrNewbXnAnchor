RegisterKeyMapping("anchor", "Anchor Boat", "keyboard", "")

RegisterCommand("anchor",function(source)
	if IsPedInAnyBoat(cache.ped) then
		if GetPedInVehicleSeat(cache.vehicle, -1) == cache.ped then
			if GetEntitySpeed(cache.ped) <= 10 / 3.6 then
				if IsBoatAnchoredAndFrozen(cache.vehicle) then
					SetBoatAnchor(cache.vehicle, false)
					SetBoatFrozenWhenAnchored(cache.vehicle, false)
					SetForcedBoatLocationWhenAnchored(cache.vehicle, false)
					SendFeedMessage("Anchor Raised")
				else
					if CanAnchorBoatHere(cache.vehicle) then
						SetBoatAnchor(cache.vehicle, true)
						SetBoatFrozenWhenAnchored(cache.vehicle, true)
						SetForcedBoatLocationWhenAnchored(cache.vehicle, true)
						SendFeedMessage("Anchor Lowered")
					else
						SendFeedMessage("You cannot anchor here")
					end
				end
			else
				SendFeedMessage("Slow down to use the anchor")
			end
		end
	end
end, false)

function SendFeedMessage(message)
	lib.notify({title = 'Vehicle Notification',description = message,duration = 6000,position = 'top',icon = 'fa-solid fa-anchor',iconColor = '#ffffff'})
end

lib.onCache('vehicle', function(value)		
	if IsPedInAnyBoat(cache.ped) then
		if GetPedInVehicleSeat(value, -1) == cache.ped then
			if IsBoatAnchoredAndFrozen(value) then
				SendFeedMessage("This boat is anchored")
			end
            lib.addRadialItem({
                {
                    id = 'boat_anchor',
                    label = 'Anchor',
                    icon = 'fa-solid fa-anchor',
                    onSelect = function()
                        ExecuteCommand("anchor")
                    end
                },
            })
        end
    else
        lib.removeRadialItem('boat_anchor')
    end
end)