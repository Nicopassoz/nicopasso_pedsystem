ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler("esx:playerLoaded", function(source)
	Citizen.Wait(6000)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    MySQL.Async.fetchAll("SELECT ped FROM ped WHERE identifier = @identifier", {
        ["@identifier"] = xPlayer.identifier
    }, function(result)
        if result[1] then
            TriggerClientEvent('nicopasso:setped', src, result[1].ped)
        end
    end)
end)

RegisterCommand('setped', function(source, args) -- ITA: COMANDO PER IL SET DEL PED   --ENG: COMMAND FOR SET PED TO A PLAYER
	local xPlayer = ESX.GetPlayerFromId(source)
	local id = args[1]
	local ped = args[2]
	if xPlayer.getGroup() == 'admin' then
		if id ~= nil and ped ~= nil then
			local xPlayerPed = ESX.GetPlayerFromId(id)
			MySQL.Async.fetchAll("SELECT ped FROM ped WHERE identifier = @identifier", {
				["@identifier"] = xPlayerPed.identifier
			}, function (result)
				if not result[1] or ped ~= result[1].ped then
					TriggerClientEvent('nicopasso:setped', id, ped)
					TriggerClientEvent('esx:showNotification', source, 'Ped settato al player con successo')
					if result[1] then
						MySQL.Async.execute("UPDATE ped SET ped = @ped WHERE identifier = @identifier",
						{['@identifier'] = xPlayerPed.identifier, ['@ped'] = ped})
					else
						MySQL.Async.execute('INSERT INTO ped (identifier, ped) VALUES (@identifier, @ped)',
						{['@identifier'] = xPlayerPed.identifier, ['@ped'] = ped})
					end	
				else
					TriggerClientEvent('esx:showNotification', source, 'Stai settando il ped che il player già ha!')
				end
			end)
		end
	end
end)

RegisterCommand('resetped', function(source, args) -- ITA: COMANDO PER IL RESET DEL PED   --ENG: COMMAND FOR RESET PED TO A PLAYER
    local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	id = args[1]
	local xPlayerPed = ESX.GetPlayerFromId(id)
	if xPlayer.getGroup() == 'admin' then
		if id ~= nil then
			if GetPlayerName(tonumber(args[1])) ~= nil then
				MySQL.Async.fetchAll("SELECT identifier FROM ped WHERE identifier = @identifier", {
				["@identifier"] = xPlayerPed.identifier
				}, function (result)
					if result[1] then
						MySQL.Async.execute("DELETE FROM ped WHERE identifier=@identifier", { ["@identifier"] = result[1].identifier })
						TriggerClientEvent('nicopasso:resetped', id)
					else 
						TriggerClientEvent('esx:showNotification', src, 'Errore, sembra che il player non abbia un ped settato')
					end
				end)
			else
				TriggerClientEvent('esx:showNotification', src, 'Player Non online!')
			end
		else
			TriggerClientEvent('esx:showNotification', src, "Devi specficare l'id del player!")
		end
	else 
		TriggerClientEvent('esx:showNotification', src,'Non hai i permessi')
	end
end)
