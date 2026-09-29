local ESX = exports["es_extended"]:getSharedObject()

RegisterNetEvent('ykaa_setped:client:SetPed', function(pedName)
    if pedName:lower() == "reset" then
        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
            TriggerEvent('skinchanger:loadSkin', skin)
        end)
        ESX.ShowNotification("The character has been reset.", "info")
        return
    end

    local model = GetHashKey(pedName)

    if not IsModelInCdimage(model) or not IsModelValid(model) then
        ESX.ShowNotification("Ped '" .. pedName .. "' does not exist!", "error")
        return
    end

    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(0)
    end

    SetPlayerModel(PlayerId(), model)
    SetModelAsNoLongerNeeded(model)
    
    ESX.ShowNotification("Ped changed to: " .. pedName, "info")
end)