local QBCore = exports[Config.CoreName]:GetCoreObject()
local Harvested = {}

QBCore.Functions.CreateCallback('rv_weed:server:HasKeycard', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local item = Player.Functions.GetItemByName(Config.WeedLabCardItem)
    if item == nil then
        TriggerClientEvent('QBCore:Notify', src, Locale.Error.need_a_lab_card, 'error')
        cb(false)
        return
    end
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.WeedLabCardItem], 'use')
    cb(true)
end)

QBCore.Functions.CreateCallback('rv_weed:server:HasHarvestingSupplies', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local item = Player.Functions.GetItemByName(Config.ScissorsItem)
    if item == nil then
        TriggerClientEvent('QBCore:Notify', src, Locale.Error.need_scissors, 'error')
        cb(false)
        return
    end
    local item = Player.Functions.GetItemByName(Config.GlovesItem)
    if item == nil then
        TriggerClientEvent('QBCore:Notify', src, Locale.Error.need_gloves, 'error')
        cb(false)
        return
    end
    cb(true)
end)

QBCore.Functions.CreateCallback('rv_weed:server:GetUnprocessedWeed', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local item = Player.Functions.GetItemByName(Config.UnprocessedWeedItem)
    if item == nil then
        TriggerClientEvent('QBCore:Notify', src, Locale.Error.need_unprocessed_weed, 'error')
        cb(0)
        return
    end
    cb(item.amount)
end)

QBCore.Functions.CreateCallback('rv_weed:server:GetProcessedWeed', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local weed = Player.Functions.GetItemByName(Config.CleanedWeedItem)
    if weed == nil then
        TriggerClientEvent('QBCore:Notify', src, Locale.Error.need_cleaned_weed, 'error')
        cb(0)
        return
    end
    if weed.amount < Config.WeedPerBaggy then
        TriggerClientEvent('QBCore:Notify', src, string.gsub(Locale.Error.need_atleast_weed, 'amount', tostring(Config.WeedPerBaggy)), 'error')
        cb(0)
        return
    end
    local item = Player.Functions.GetItemByName(Config.PlasticBagsItem)
    if item == nil then
        TriggerClientEvent('QBCore:Notify', src, Locale.Error.no_baggys, 'error')
        cb(0)
        return
    end
    if item.amount < math.floor(weed.amount / Config.WeedPerBaggy) then
        TriggerClientEvent('QBCore:Notify', src, string.gsub(Locale.Error.need_baggys, 'amount', tostring(math.floor(weed.amount / 3))), 'error')
        cb(0)
        return
    end
    cb(weed.amount)
end)

QBCore.Functions.CreateCallback('rv_weed:server:IsPlantHarvested', function(source, cb, plant)
    for k,v in pairs(Harvested) do
        if v == plant then
            cb(true)
        end
    end
    cb(false)
end)

RegisterNetEvent('rv_weed:server:HarvestedPlant', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.AddItem(Config.UnprocessedWeedItem, math.random(1, 3))
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.UnprocessedWeedItem], 'add')
end)

RegisterNetEvent('rv_weed:server:ProcessWeed', function(amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local item = Player.Functions.GetItemByName(Config.UnprocessedWeedItem)
    if item == nil or item.amount < amount then
        TriggerClientEvent('QBCore:Notify', src, Locale.Error.need_unprocessed_weed, 'error')
        return
    end
    Player.Functions.RemoveItem(Config.UnprocessedWeedItem, amount)
    Player.Functions.AddItem(Config.CleanedWeedItem, amount)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.CleanedWeedItem], 'add')
end)

RegisterNetEvent('rv_weed:server:PackageWeed', function(amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local item = Player.Functions.GetItemByName(Config.CleanedWeedItem)
    if item == nil or item.amount < amount then
        TriggerClientEvent('QBCore:Notify', src, Locale.Error.need_cleaned_weed, 'error')
        return
    end
    Wait(100)
    Player.Functions.RemoveItem(Config.CleanedWeedItem, amount)
    local given = math.floor(amount / Config.WeedPerBaggy)
    Player.Functions.RemoveItem(Config.PlasticBagsItem, given)
    Player.Functions.AddItem(Config.WeedBaggyItem, given)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.WeedBaggyItem], 'add')
end)


RegisterNetEvent('rv_weed:server:SetPlantHarvested', function(plant, harvest)
    if harvest then
        table.insert(Harvested, plant)
        return
    end
    for k,v in pairs(Harvested) do
        if v == plant then
            table.remove(Harvested, k)
        end
    end
end)