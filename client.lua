--Hi, today i'm here to realase a ped sistem which works through db, I hope you like it. I'm sorry for my bad english but i'm italian xD
TriggerEvent('chat:addSuggestion', '/setped', 'Setta ped to a player', {
    { name="id", help="Player Id" },
    { name="Model", help="Ped to set" }
})

TriggerEvent('chat:addSuggestion', '/resetped', 'Resetta un ped ad un player', {
    { name="id", help="Player Id" }
})

RegisterNetEvent('nicopasso:setped')
AddEventHandler('nicopasso:setped', function(ped)
	SetPedToPlayer(ped)
end)

RegisterNetEvent('nicopasso:resetped') 
AddEventHandler('nicopasso:resetped', function()
    TriggerEvent('skinchanger:getSkin', function(skin)
        if skin.sex == 0 then
			SetPedToPlayer('mp_m_freemode_01')
            TriggerEvent('skinchanger:loadClothes', skin)
        elseif skin.sex == 1 then
			SetPedToPlayer('mp_f_freemode_01')
            TriggerEvent('skinchanger:loadClothes', skin)
        end
    end)
end)

function SetPedToPlayer(ped)
	local hash = GetHashKey(ped)
	RequestModel(hash)										
	while not HasModelLoaded(hash)							
		do RequestModel(hash)
		Citizen.Wait(0)
	end	
	SetPlayerModel(PlayerId(), hash)
	TriggerEvent('esx:restoreLoadout')
end
