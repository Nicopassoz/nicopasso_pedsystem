ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
local set = true
AddEventHandler("esx:playerLoaded", function(source)
	Citizen.Wait(6000)
	local xPlayer = ESX.GetPlayerFromId(source)
	if not set then
	MySQL.Async.fetchAll("SELECT identifier FROM ped WHERE identifier = @steam", {
		["@steam"] = xPlayer.identifier
	}, function (result)
		if #result ~= 0 then
			local peddamettere = MySQL.Sync.fetchScalar("SELECT ped FROM ped WHERE identifier = @steam", {
				["@steam"] = xPlayer.identifier})
			TriggerClientEvent('nicopasso_settoilfottutoped', source, peddamettere)
		end
end)
  		set = true
	end
end)

RegisterServerEvent('nicopasso_checkped') -- ITA: funzione per il check nel db se un player ha un ped o meno e se lo ha glielo setta --ENG: function to check in the db if a player has a ped or not and if he does, it sets it to the player
AddEventHandler('nicopasso_checkped', function(source)
		local xPlayer = ESX.GetPlayerFromId(source)
		MySQL.Async.fetchAll("SELECT identifier FROM ped WHERE identifier = @steam", {
			["@steam"] = xPlayer.identifier
		}, function (result)
			if #result ~= 0 then
				local peddamettere = MySQL.Sync.fetchScalar("SELECT ped FROM ped WHERE identifier = @steam", {
					["@steam"] = xPlayer.identifier})
				TriggerClientEvent('nicopasso_settoilfottutoped', source, peddamettere)
			end
	end)
end)

RegisterCommand('setped', function(source, args) -- ITA:comando per il set del ped --ENG: command for set a ped to players
		local xPlayer = ESX.GetPlayerFromId(source) 
		id = args[1]
		ped = args[2]
		local xPlayerPed = ESX.GetPlayerFromId(id)
		local trovato = false
		if xPlayer.getGroup() == 'superadmin' or xPlayer.getGroup() == 'admin' then -- ITA: check dei permessi del player che fa il comando ENG: check of the permission for the person that is doing the command
			if id ~= nil and ped ~= nil then
				if GetPlayerName(tonumber(args[1])) ~= nil then
					for i=1, #Config.Ped.Ped, 1 do
						local peddino = Config.Ped.Ped[i]
						if ped == peddino.comando then
							MySQL.Async.fetchAll("SELECT ped FROM ped WHERE identifier = @steam", {
								["@steam"] = xPlayerPed.identifier
							}, function (result) -- ITA: qui checcka se un player ha gia un ped salvato nel db e se lo ha gia aggiorna la colonna del ped nel db, sennò la crea 
								if #result ~= 0 then --ENG: here it check if a player already has a ped saved in the db and if he already has it updates the column of the ped in the db, otherwise he creates it
									if result[1].ped ~= peddino.nome then -- ITA: qui checca invece se il ped che setti è uguale a quello che il player ha gia
										TriggerClientEvent('nicopasso_settoilfottutoped', id, peddino.nome)-- ENG: here it check if the ped that you are setting is equal to the one the player already has
										MySQL.Async.execute("UPDATE ped SET ped = @ped WHERE identifier = @identifier",
										{['@identifier'] = xPlayerPed.identifier, ['@ped'] = peddino.nome}) 
									else
										xPlayer.showNotification('Stai settando il ped che il player già ha!')
									end
								else
									TriggerClientEvent('nicopasso_settoilfottutoped', id, peddino.nome)
									MySQL.Async.execute('INSERT INTO ped (identifier, ped) VALUES (@identifier, @ped)',
									{['@identifier'] = xPlayerPed.identifier, ['@ped'] = peddino.nome})
								end
									end)
							trovato = true
						end
					end
					if not trovato then
						xPlayer.showNotification('Ped non valido')
					end
				else
                	xPlayer.showNotification('Player Non online!')
            	end
			else
				xPlayer.showNotification("Devi specficare l'id e il ped da settare!")
			end
		else 
			xPlayer.showNotification('Non hai i permessi')
		end
end)

RegisterCommand('resetped', function(source, args) -- ITA: COMANDO PER IL RESET DEL PED --ENG: COMMAND FOR RESET PED TO A PLAYER
	local xPlayer = ESX.GetPlayerFromId(source)
	id = args[1]
	local xPlayerPed = ESX.GetPlayerFromId(id)
	if xPlayer.getGroup() == 'superadmin' or xPlayer.getGroup() == 'admin' then -- ITA: check dei permessi del player che fa il comando --ENG: check of the permission for the person that is doing the command
		if id ~= nil then
			if GetPlayerName(tonumber(args[1])) ~= nil then
				MySQL.Async.fetchAll("SELECT identifier FROM ped WHERE identifier = @steam", {
				["@steam"] = xPlayerPed.identifier
				}, function (result) 
					if #result ~= 0 then
						MySQL.Async.execute("DELETE FROM ped WHERE identifier=@identifier", { ["@identifier"] = result[1].identifier })
						TriggerClientEvent('reset', id)
					else 
						xPlayer.showNotification('Errore, sembra che il player non abbia un ped settato')
					end
				end)
			else
				xPlayer.showNotification('Player Non online!')
			end
		else
			xPlayer.showNotification("Devi specficare l'id del player!")
		end
	else 
		xPlayer.showNotification('Non hai i permessi')
	end
end)
