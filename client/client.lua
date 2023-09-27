local QBCore = exports[Config.CoreName]:GetCoreObject()
local Harvesting = false

Citizen.CreateThread(function()
    -- DEALER
    RequestModel(GetHashKey(Config.Dealer.Ped.Model))
    while not HasModelLoaded(GetHashKey(Config.Dealer.Ped.Model)) do
        Wait(1)
    end
    local ped = CreatePed(5, GetHashKey(Config.Dealer.Ped.Model), Config.Dealer.Ped.Coords, false, false)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    exports[Config.TargetName]:AddBoxZone('weed-dealer', Config.Dealer.Target.Coords, 1.5, 1.6, {
        name = "weed-dealer",
        heading = Config.Dealer.Target.Heading,
        debugPoly = false
    }, {
        options = {
            {
                type = "client",
                event = "rv_weed:client:DealerShop",
                icon = "fas fa-cannabis",
                label = Locale.Info.dealer_target
            }
        }
    })
    -- SUPPLIES
    RequestModel(GetHashKey(Config.Lab.Supplies.Ped.Model))
    while not HasModelLoaded(GetHashKey(Config.Lab.Supplies.Ped.Model)) do
        Wait(1)
    end
    local ped = CreatePed(5, GetHashKey(Config.Lab.Supplies.Ped.Model), Config.Lab.Supplies.Ped.Coords, false, false)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    exports[Config.TargetName]:AddBoxZone('weed-supplies', Config.Lab.Supplies.Target.Coords, 1.5, 1.6, {
        name = "weed-supplies",
        heading = Config.Lab.Supplies.Target.Heading,
        debugPoly = false
    }, {
        options = {
            {
                type = "client",
                event = "rv_weed:client:SuppliesShop",
                icon = "fas fa-sheet-plastic",
                label = Locale.Info.supplies_target
            }
        }
    })
    -- LAB ENTER
    RequestModel(GetHashKey(Config.Lab.Enter.Ped.Model))
    while not HasModelLoaded(GetHashKey(Config.Lab.Enter.Ped.Model)) do
        Wait(1)
    end
    local ped = CreatePed(5, GetHashKey(Config.Lab.Enter.Ped.Model), Config.Lab.Enter.Ped.Coords, false, false)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    exports[Config.TargetName]:AddBoxZone('weed-lab-enter', Config.Lab.Enter.Target.Coords, 1.5, 1.6, {
        name = "weed-lab-enter",
        heading = Config.Lab.Enter.Target.Heading,
        debugPoly = false
    }, {
        options = {
            {
                type = "client",
                event = "rv_weed:client:EnterLab",
                icon = "fas fa-door-open",
                label = Locale.Info.enter_lab
            }
        }
    })
    -- LAB EXIT
    exports[Config.TargetName]:AddBoxZone('weed-lab-exit', Config.Lab.Exit.Target.Coords, 1.5, 1.6, {
        name = "weed-lab-exit",
        heading = Config.Lab.Exit.Target.Heading,
        debugPoly = false
    }, {
        options = {
            {
                type = "client",
                event = "rv_weed:client:LeaveLab",
                icon = "fas fa-door-open",
                label = Locale.Info.leave_lab
            }
        }
    })
    -- CLEAN WEED
    exports[Config.TargetName]:AddBoxZone('weed-clean', Config.Lab.CleanWeed.Target.Coords, 1.5, 1.6, {
        name = "weed-clean",
        heading = Config.Lab.CleanWeed.Target.Heading,
        debugPoly = false
    }, {
        options = {
            {
                type = "client",
                event = "rv_weed:client:CleanWeed",
                icon = "fas fa-cannabis",
                label = Locale.Info.clean_weed
            }
        }
    })
    -- BAGGY WEED
    exports[Config.TargetName]:AddBoxZone('weed-baggy', Config.Lab.PackageWeed.Target.Coords, 1.5, 1.6, {
        name = "weed-baggy",
        heading = Config.Lab.PackageWeed.Target.Heading,
        debugPoly = false
    }, {
        options = {
            {
                type = "client",
                event = "rv_weed:client:PackageWeed",
                icon = "fas fa-cannabis",
                label = Locale.Info.package_weed
            }
        }
    })
    -- PLANTS
    for k,v in pairs(Config.Lab.Plants.PlantCoords) do
        exports[Config.TargetName]:AddBoxZone('weed-plant-' .. v.x .. v.y .. v.z, v, 0.8, 0.8, {
            name = "weed-plant-" .. v.x .. v.y .. v.z,
            heading = Config.Lab.Exit.Target.Heading,
            debugPoly = false
        }, {
            options = {
                {
                    type = "client",
                    action = function()	
                        if Harvesting then
                            QBCore.Functions.Notify(Locale.Error.already_harvesting, 'error', 5000)
                            return
                        end
                        local p = promise.new()
                        local supplies
                        QBCore.Functions.TriggerCallback('rv_weed:server:HasHarvestingSupplies', function(result)
                            p:resolve(result)
                        end, tostring(v.x .. v.y .. v.z))
                        supplies = Citizen.Await(p)
                        if not supplies then
                            return
                        end
                        local p = promise.new()
                        local harvested
                        QBCore.Functions.TriggerCallback('rv_weed:server:IsPlantHarvested', function(result)
                            p:resolve(result)
                        end, tostring(v.x .. v.y .. v.z))
                        harvested = Citizen.Await(p)
                        if harvested then
                            QBCore.Functions.Notify(Locale.Error.already_harvested, 'error', 5000)
                            return
                        end
                        TriggerServerEvent('rv_weed:server:SetPlantHarvested', tostring(v.x .. v.y .. v.z), true)
                        Harvesting = true
                        local ped = PlayerPedId()		
                        TaskStartScenarioInPlace(ped, "WORLD_HUMAN_GARDENER_PLANT", 0, true)
                        local time = math.random(7500, 15000)
                        QBCore.Functions.Progressbar("harvesting_plant", Locale.Info.harvesting_plant, time, false, true, {
                            disableMovement = true,
                            disableCarMovement = true,
                            disableMouse = false,
                            disableCombat = true
                        }, {
                        }, {}, {}, function() -- Done
                            ClearPedTasks(ped)
                            TriggerServerEvent('rv_weed:server:HarvestedPlant')
                            Harvesting = false
                        end, function() -- Cancel
                        end)
                        Wait(time)
                        local toDo = {}
                        for k2,v2 in pairs(Config.Lab.Plants.Models) do
                            local entity = GetClosestObjectOfType(v, 0.3, v2)
                            if entity ~= nil then
                                local coords = GetEntityCoords(entity)
                                local heading = GetEntityHeading(entity)
                                SetEntityAsMissionEntity(entity, true, true)
                                DeleteEntity(entity)
                                table.insert(toDo, {type = v2, coords = vector3(coords.x, coords.y, -42.6), heading = heading})
                            end
                        end
                        Wait(math.random(20000, 45000))
                        TriggerServerEvent('rv_weed:server:SetPlantHarvested', tostring(v.x .. v.y .. v.z), false)
                        for k3,v3 in pairs(toDo) do
                            CreateObject(v3.type, v3.coords, 1, 1, 0)
                        end
                        
                    end,
                    icon = "fas fa-cannabis",
                    label = Locale.Info.harvest_plant
                }
            }
        })
    end
end)

RegisterNetEvent('rv_weed:client:CleanWeed', function()
    local p = promise.new()
    local amount
    QBCore.Functions.TriggerCallback('rv_weed:server:GetUnprocessedWeed', function(result)
        p:resolve(result)
    end)
    amount = Citizen.Await(p)
    if amount <= 0 then
        return
    end
    local ped = PlayerPedId()
    SetEntityCoords(ped, Config.Lab.CleanWeed.Chair.Coords)
    SetEntityHeading(ped, Config.Lab.CleanWeed.Chair.Heading)
    TriggerEvent('animations:client:EmoteCommandStart', {"sitchair"})
    QBCore.Functions.Progressbar("cleaning", Locale.Info.cleaning_weed, 5000 + (amount * 1500), false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true
    }, {
    }, {}, {}, function() -- Done
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        SetEntityCoords(ped, Config.Lab.CleanWeed.ChairExit)
        TriggerServerEvent('rv_weed:server:ProcessWeed', amount)
    end, function() -- Cancel
    end)
end)

RegisterNetEvent('rv_weed:client:PackageWeed', function()
    local p = promise.new()
    local amount
    QBCore.Functions.TriggerCallback('rv_weed:server:GetProcessedWeed', function(result)
        p:resolve(result)
    end)
    amount = Citizen.Await(p)
    if amount <= 0 then
        return
    end
    local ped = PlayerPedId()
    SetEntityCoords(ped, Config.Lab.PackageWeed.Chair.Coords)
    SetEntityHeading(ped, Config.Lab.PackageWeed.Chair.Heading)
    TriggerEvent('animations:client:EmoteCommandStart', {"sitchair"})
    QBCore.Functions.Progressbar("cleaning", Locale.Info.packaging_weed, 5000 + (amount * 1500), false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true
    }, {
    }, {}, {}, function() -- Done
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        SetEntityCoords(ped, Config.Lab.PackageWeed.ChairExit)
        TriggerServerEvent('rv_weed:server:PackageWeed', amount)
    end, function() -- Cancel
    end)
end)

RegisterNetEvent('rv_weed:client:DealerShop', function()
    local items = {
        label = Config.Dealer.Shop.Label,
        slots = Config.Dealer.Shop.Slots,
        items = Config.Dealer.Shop.Items
    }
    TriggerServerEvent('inventory:server:OpenInventory', 'shop', Config.Dealer.Shop.Label, items)
end)

RegisterNetEvent('rv_weed:client:SuppliesShop', function()
    local items = {
        label = Config.Lab.Supplies.Shop.Label,
        slots = Config.Lab.Supplies.Shop.Slots,
        items = Config.Lab.Supplies.Shop.Items
    }
    TriggerServerEvent('inventory:server:OpenInventory', 'shop', Config.Lab.Supplies.Shop.Label, items)
end)

RegisterNetEvent('rv_weed:client:EnterLab', function()
    local p = promise.new()
    local allowed
    QBCore.Functions.TriggerCallback('rv_weed:server:HasKeycard', function(result)
        p:resolve(result)
    end)
    allowed = Citizen.Await(p)
    if not allowed then
        return
    end
    QBCore.Functions.Progressbar("entering", Locale.Info.entering_lab, 2000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true
    }, {
    }, {}, {}, function() -- Done
        SetEntityCoords(PlayerPedId(), Config.Lab.Enter.Teleport.Coords)
        SetEntityHeading(PlayerPedId(), Config.Lab.Enter.Teleport.Coords.w)
    end, function() -- Cancel
    end)
end)

RegisterNetEvent('rv_weed:client:LeaveLab', function()
    QBCore.Functions.Progressbar("leaving", Locale.Info.leaving_lab, 2000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true
    }, {
    }, {}, {}, function() -- Done
        SetEntityCoords(PlayerPedId(), Config.Lab.Exit.Teleport.Coords)
        SetEntityHeading(PlayerPedId(), Config.Lab.Exit.Teleport.Coords.w)
    end, function() -- Cancel
    end)
end)