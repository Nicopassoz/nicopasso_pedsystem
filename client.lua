--Hi, today i'm here to realase a ped sistem which works through db, I hope you like it. I'm sorry for my bad english but i'm italian xD
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

--[[AddEventHandler("playerSpawned", function()
	print('parto')
	Citizen.Wait(12000)
	TriggerServerEvent('nicopasso_checkped', GetPlayerServerId(PlayerId())) 
	print('finisco') --ITA: l'ho commentata perchè io ho il check integrato nel prp-characters, cmq questa sarebbe la funzione che quando un player è spawnato aspetta i secondi nel wait e 
end)--]]			 --poi checca nel db se uno ha un ped e se ce l'ha glielo setta
					--ENG: I commented on it because I have the check integrated in the prp-characters, btw this would be the function that when a player is spawned it waits for the seconds in the citizem.wait and
					--then queer in the db if one has a ped and if he does, he sets it to him


TriggerEvent('chat:addSuggestion', '/setped', 'Setta un ped al player', {
    { name="id", help="Id del player" },
    { name="Model", help="Ped da settare" }
})


TriggerEvent('chat:addSuggestion', '/resetped', 'Resetta un ped ad un player', {
    { name="id", help="Id del player" }
})

--[[RegisterNetEvent('nicopasso_settoilfottutoped')
AddEventHandler('nicopasso_settoilfottutoped', function(ped) --ITA: Funzione per il set del ped con lo smonta armi, dato che quando setti un ped il player perde il loadout, potete adattarla al vostro smonta armi
	local silenziatori = {
		"component_at_pi_supp_02",
		"COMPONENT_AT_PI_SUPP",
		"COMPONENT_AT_AR_SUPP_02",
		"COMPONENT_AT_AR_SUPP",
		"COMPONENT_AT_SR_SUPP"
	}
	
	local torce = {
		"COMPONENT_AT_PI_FLSH",
		"COMPONENT_AT_PI_FLSH_03",
		"COMPONENT_AT_PI_FLSH_02",
		"COMPONENT_AT_AR_FLSH"
	}

	local impugnature = {
		"COMPONENT_AT_AR_AFGRIP",
		"COMPONENT_AT_AR_AFGRIP_02"
	}

	local skin = {
		"COMPONENT_PISTOL_VARMOD_LUXE",
		"COMPONENT_PISTOL50_VARMOD_LUXE",
		"COMPONENT_APPISTOL_VARMOD_LUXE",
		"COMPONENT_HEAVYPISTOL_VARMOD_LUXE",
		"COMPONENT_SMG_VARMOD_LUXE",
		"COMPONENT_MICROSMG_VARMOD_LUXE",
		"COMPONENT_ASSAULTRIFLE_VARMOD_LUXE",
		"COMPONENT_CARBINERIFLE_VARMOD_LUXE",
		"COMPONENT_ADVANCEDRIFLE_VARMOD_LUXE"
	}

	local caricatore = {
		"COMPONENT_PISTOL_CLIP_02",
		"COMPONENT_COMBATPISTOL_CLIP_02",
		"COMPONENT_APPISTOL_CLIP_02",
		"COMPONENT_PISTOL50_CLIP_02",
		"COMPONENT_SNSPISTOL_CLIP_02",
		"COMPONENT_HEAVYPISTOL_CLIP_02",
		"COMPONENT_SNSPISTOL_MK2_CLIP_02",
		"COMPONENT_PISTOL_MK2_CLIP_02",
		"COMPONENT_VINTAGEPISTOL_CLIP_02",
		"COMPONENT_CERAMICPISTOL_CLIP_02",
		"COMPONENT_MICROSMG_CLIP_02",
		"COMPONENT_SMG_CLIP_02",
		"COMPONENT_ASSAULTSMG_CLIP_02",
		"COMPONENT_MINISMG_CLIP_02",
		"COMPONENT_SMG_MK2_CLIP_02",
		"COMPONENT_MACHINEPISTOL_CLIP_02",
		"COMPONENT_COMBATPDW_CLIP_02",
		"COMPONENT_ASSAULTSHOTGUN_CLIP_02",
		"COMPONENT_HEAVYSHOTGUN_CLIP_02",
		"COMPONENT_ASSAULTRIFLE_CLIP_02",
		"COMPONENT_CARBINERIFLE_CLIP_02",
		"COMPONENT_ADVANCEDRIFLE_CLIP_02",
		"COMPONENT_SPECIALCARBINE_CLIP_02",
		"COMPONENT_BULLPUPRIFLE_CLIP_02",
		"COMPONENT_BULLPUPRIFLE_MK2_CLIP_02",
		"COMPONENT_SPECIALCARBINE_MK2_CLIP_02",
		"COMPONENT_ASSAULTRIFLE_MK2_CLIP_02",
		"COMPONENT_CARBINERIFLE_MK2_CLIP_02",
		"COMPONENT_COMPACTRIFLE_CLIP_02",
		"COMPONENT_MG_CLIP_02",
		"COMPONENT_COMBATMG_CLIP_02",
		"COMPONENT_COMBATMG_MK2_CLIP_02",
		"COMPONENT_GUSENBERG_CLIP_02",
		"COMPONENT_MARKSMANRIFLE_MK2_CLIP_02",
		"COMPONENT_HEAVYSNIPER_MK2_CLIP_02",
		"COMPONENT_MARKSMANRIFLE_CLIP_02"
	}

	local mirino = {
		"COMPONENT_AT_SCOPE_MACRO",
		"COMPONENT_AT_SCOPE_MEDIUM",
		"COMPONENT_AT_SCOPE_MAX",
		"COMPONENT_AT_SCOPE_MACRO_02",
		"COMPONENT_AT_SCOPE_LARGE",
		"COMPONENT_AT_SCOPE_SMALL"
	}

    local Weapons = {

		"WEAPON_PISTOL",
		"WEAPON_ASSAULTRIFLE",
		"WEAPON_PUMPSHOTGUN",
		"WEAPON_MICROSMG",
		"WEAPON_SMG",
		"WEAPON_CARBINERIFLE",
		"WEAPON_MARKSMANRIFLE",
		"WEAPON_COMBATPISTOL",
		"WEAPON_APPISTOL",
		"WEAPON_PISTOL50",
		"WEAPON_ASSAULTSMG",
		"WEAPON_VINTAGEPISTOL",
		"WEAPON_MUSKET",
		"WEAPON_SPECIALCARBINE",
		"WEAPON_SNSPISTOL",
		"WEAPON_HEAVYSNIPER",
		"WEAPON_HEAVYPISTOL",
		"WEAPON_STUNGUN",
		"WEAPON_NIGHTSTICK",
		"WEAPON_FLASHLIGHT"

	}

	local White = {

		"WEAPON_SMOKEGRENADE",
		"WEAPON_FLASHLIGHT",
		"WEAPON_PETROLCAN",
		"WEAPON_NIGHTSTICK",
		"WEAPON_STUNGUN",
		"WEAPON_BZGAS",
		"WEAPON_SWITCHBLADE",
		"WEAPON_KNUCKLE"

	}
    

    for i = 1, #Weapons do
		local weapon_t = Weapons[i]
		local weapon = GetHashKey(weapon_t)
		if HasPedGotWeapon(PlayerPedId(), weapon, false) then
          
            
        local playerPed  = PlayerPedId()
        local weaponHash = weapon
        local pedAmmo = GetAmmoInPedWeapon(playerPed, weapon_t)

    for i = 1, #silenziatori do
        if HasWeaponGotWeaponComponent( GetHashKey(weapon_t), GetHashKey(silenziatori[i])) then
            TriggerServerEvent('smontaaccessorio1', 'silencieux')	
        end
    end

    for i = 1, #torce do
        if HasWeaponGotWeaponComponent( GetHashKey(weapon_t), GetHashKey(torce[i])) then
            TriggerServerEvent('smontaaccessorio1', 'flashlight')		
        end
    end

    for i = 1, #impugnature do
        if HasWeaponGotWeaponComponent( GetHashKey(weapon_t), GetHashKey(impugnature[i])) then
            TriggerServerEvent('smontaaccessorio1', 'grip')		
        end
    end

    for i = 1, #skin do
        if HasWeaponGotWeaponComponent( GetHashKey(weapon_t), GetHashKey(skin[i])) then
            TriggerServerEvent('smontaaccessorio1', 'yusuf')		
        end
    end

    for i = 1, #caricatore do
        if HasWeaponGotWeaponComponent( GetHashKey(weapon_t), GetHashKey(caricatore[i])) then
             TriggerServerEvent('smontaaccessorio1', 'caricatore')		
        end
    end

    for i = 1, #mirino do
        if HasWeaponGotWeaponComponent( GetHashKey(weapon_t), GetHashKey(mirino[i])) then
            TriggerServerEvent('smontaaccessorio1', 'mirino')		
        end
    end

    	TriggerServerEvent('smontaarmi1', weapon_t, pedAmmo)
    	end
    Citizen.Wait(0)
    TriggerServerEvent('spaccalarma',weapon_t)
    RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey(weapon_t))
	end
	local hash = GetHashKey(ped)
	RequestModel(hash)
	while not HasModelLoaded(hash)
		do RequestModel(hash)
		Citizen.Wait(0)
	end	
	SetPlayerModel(PlayerId(), hash)
end)--]]													 --ENG: Function for the set of the ped with the dissasemble weapon, since when you set a ped the player loses the loadout, you can adapt it to your dissasemble weapon.

RegisterNetEvent('nicopasso_settoilfottutoped')
AddEventHandler('nicopasso_settoilfottutoped', function(ped) --ITA: Funzione per il set del ped senza lo smonta armi, solo che quando setti un ped il player perde il loadout, 
local hash = GetHashKey(ped) 								 --come scritto anche in quello che usavo io sopra potete adattarlo al vostro somnta armi
	RequestModel(hash)										--ENG: Function for the set of the ped without the disassembly weapons, but when you set a ped the player loses the loadout,
	while not HasModelLoaded(hash)							--as written also above you can adapt it to your dissasembly weapons
		do RequestModel(hash)
		Citizen.Wait(0)
	end	
		SetPlayerModel(PlayerId(), hash)
end)

RegisterNetEvent('reset') -- ITA: funzione per il reset del ped -- ENG: funtion for the reset of the ped
AddEventHandler('reset', function()
local pedm = 'mp_m_freemode_01'
local pedf = 'mp_f_freemode_01'
local hashm = GetHashKey(pedm)
local hashf = GetHashKey(pedf)
    TriggerEvent('skinchanger:getSkin', function(skin)
        if skin.sex == 0 then
            RequestModel(hashm)
            while not HasModelLoaded(hashm)
                do RequestModel(hashm)
                    Citizen.Wait(0)
            end
            SetPlayerModel(PlayerId(), hashm)
            TriggerEvent('skinchanger:loadClothes', skin)
        elseif skin.sex == 1 then
            RequestModel(hashf)
            while not HasModelLoaded(hashf)
                do RequestModel(hashf)
                    Citizen.Wait(0)
            end
            SetPlayerModel(PlayerId(), hashf)
            TriggerEvent('skinchanger:loadClothes', skin)
        end
    end)
end)