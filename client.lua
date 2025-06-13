local QBCore = exports['qb-core']:GetCoreObject()

CreateThread(function()
    exports['qb-target']:AddBoxZone("pearls_fridge1", vector3(-1838.28, -1188.18, 15.66), 1.5, 1.5, {
        name = "pearls_fridge1",
        heading = 120,
        debugPoly = false,
        minZ = 10.0,
        maxZ = 18.5,
    }, {
        options = {
            {
                type = "client",
                event = "janiel-pearls:client:jobFridge1",
                icon = "fas fa-box",
                label = "Pearls Fridge",
            },
        },
        distance = 2.0
    })

    exports['qb-target']:AddBoxZone("pearls_shop", vector3(-1838.62, -1183.37, 15.33), 1.5, 1.5, {
        name = "pearls_shop",
        heading = 120,
        debugPoly = false,
        minZ = 10.0,
        maxZ = 18.5,
    }, {
        options = {
            {
                type = "client",
                event = "janiel-pearls:client:ingredientStore",
                icon = "fas fa-store",
                label = "Pearls Market",
            },
        },
        distance = 2.0
    })

    exports['qb-target']:AddBoxZone("pearls_cook", vector3(-1843.62, -1185.98, 15.38), 1.5, 1.0, {
        name = "pearls_cook",
        heading = 0,
        debugPoly = false,
        minZ = 13.0,
        maxZ = 18.5
    }, {
        options = {
            {
                type = "client",
                event = "pearls:client:openCookMenu",
                icon = "fas fa-utensils",
                label = "Cook Food",
            }
        },
        distance = 2.0
    })

    --exports['qb-target']:AddBoxZone("pearls_drinks", vector3(-1836.27, -1185.93, 15.66), 1.5, 1.0, {
    --    name = "pearls_drinks",
    --    heading = 0,
    --    debugPoly = false,
    --    minZ = 13.0,
    --    maxZ = 18.5
    --}, {
    --    options = {
    --        {
    --            type = "client",
    --            event = "pearls:client:getDrinks",
    --            icon = "fas fa-glass-martini",
    --            label = "Drink [MACHINE IS BROKEN, BUY FROM MARKET]",
    --        }
    --    },
    --    distance = 2.0
    --})
end)

RegisterNetEvent('pearls:client:getIngredients', function()
    TriggerServerEvent('pearls:server:giveIngredients')
end)

RegisterNetEvent('pearls:client:getDrinks', function()
    TriggerServerEvent('pearls:server:giveDrinks')
end)

RegisterNetEvent('pearls:client:openCookMenu', function()
    local Menu = {
        {
            header = "🍽️ Pearls Menü",
            isMenuHeader = true
        }
    }

    for k, v in pairs(Config.CookRecipes) do
        local ingredientsText = ""
        for _, item in pairs(v.required) do
            local itemData = QBCore.Shared.Items[item.item]
            if itemData then
                ingredientsText = ingredientsText .. item.amount .. "x " .. itemData.label .. "\n"
            else
                ingredientsText = ingredientsText .. item.amount .. "x " .. item.item .. "\n"
            end
        end

        Menu[#Menu + 1] = {
            header = k,
            txt = "Required materials:\n" .. ingredientsText,
            params = {
                event = "pearls:client:craftItem",
                args = { recipe = k }
            }
        }
    end

    exports['qb-menu']:openMenu(Menu)
end)



RegisterNetEvent('pearls:client:craftItem', function(data)
    local recipeKey = data.recipe
    local recipe = Config.CookRecipes[recipeKey]
    if not recipe then return end

    QBCore.Functions.Progressbar("cooking_food", "Food is being prepared...", 5000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "amb@prop_human_bbq@male@idle_a",
        anim = "idle_c",
        flags = 49,
    }, {}, {}, function()
        ClearPedTasks(PlayerPedId())
        TriggerServerEvent("pearls:server:craft", { recipe = recipeKey })
    end, function()
        ClearPedTasks(PlayerPedId())
        QBCore.Functions.Notify("Preparation has been canceled", "error")
    end)
end)

RegisterNetEvent('pearls:client:cutFishMenu', function()
    local Menu = {
        {
            header = "🐟 Fish Cutting Menu",
            isMenuHeader = true
        }
    }

    local availableFish = {
        "trout", "salmon", "shark", "killerwhale",
        "tuna", "bass", "cod", "mackerel", "dolphin"
    }

    for _, fish in pairs(availableFish) do
        Menu[#Menu + 1] = {
            header = fish,
            txt = "Click to cut",
            params = {
                event = "pearls:client:cutFish",
                args = fish  
            }
        }
    end


    exports['qb-menu']:openMenu(Menu)
end)


CreateThread(function()
    exports['qb-target']:AddBoxZone("pearls_cutfish", vector3(-1842.88, -1184.67, 15.58), 1.5, 1.0, {
        name = "pearls_cutfish",
        heading = 0,
        debugPoly = false,
        minZ = 13.0,
        maxZ = 18.5
    }, {
        options = {
            {
                type = "client",
                event = "pearls:client:cutFishMenu",  
                icon = "fas fa-fish",
                label = "Cut Fish",
            }
        },
        distance = 2.0
    })
end)


RegisterNetEvent('pearls:client:cutFish', function(fishType)
    local PlayerPed = PlayerPedId()

    exports['janiel-progressbar']:Progress({
        name = "cut_fish",
        duration = 3000, 
        label = "Fish is being cut...",
        useWhileDead = false, 
        canCancel = false, 
        controlDisabling = true, 
        anim = { 
            dict = "amb@world_human_stand_fishing@idle_a", 
            clip = "idle_b" 
        },
    }, function() 

        TriggerServerEvent('pearls:server:cutFish', fishType)
    end)
end)



RegisterNetEvent("janiel-pearls:client:jobFridge1", function()
    local PlayerData = QBCore.Functions.GetPlayerData()
   if PlayerData.job.name ~= "pearls" then
       QBCore.Functions.Notify("You can't use this cabinet!", "error")
       return
   end

    TriggerEvent("inventory:client:SetCurrentStash", "pearlsfridge1")
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "pearlsfridge1", {
        maxweight = 3000000,
        slots = 30,
    })
end)


RegisterNetEvent("janiel-pearls:client:ingredientStore", function()
    local PlayerData = QBCore.Functions.GetPlayerData()
    if PlayerData.job.name ~= "pearls" then
        QBCore.Functions.Notify("Only Pearls employees can use this market..", "error")
        return
    end

    TriggerServerEvent("inventory:server:OpenInventory", "shop", "pearls", Config.Items)
end)

-- Blip ekleme işlemi
CreateThread(function()
    local blip = AddBlipForCoord(-1825.39, -1193.69, 26.49) 

    SetBlipSprite(blip, 68) 
    SetBlipDisplay(blip, 4) 
    SetBlipScale(blip, 1.0) 
    SetBlipColour(blip, 3) 
    SetBlipAsShortRange(blip, false) 

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Pearls Restaurant") 
    EndTextCommandSetBlipName(blip)
end)

--Trays

local pearlsTables = {
    vector3(-1836.42, -1198.33, 15.57),
    vector3(-1832.29, -1200.63, 15.38),
    vector3(-1828.30, -1202.92, 15.10),
    vector3(-1822.21, -1201.65, 15.12),
    vector3(-1825.93, -1197.44, 15.19),
    vector3(-1829.05, -1195.38, 15.19),
    vector3(-1832.42, -1193.35, 15.20),
    vector3(-1830.58, -1190.05, 15.19),
    vector3(-1827.46, -1192.06, 15.17),
    vector3(-1823.74, -1194.52, 15.07),
    vector3(-1820.29, -1189.02, 15.28),
    vector3(-1824.61, -1186.60, 15.16),
    vector3(-1828.64, -1184.21, 15.30)
}

CreateThread(function()
    for i = 1, #pearlsTables do
        exports['qb-target']:AddBoxZone("PearlsMasa_"..i, pearlsTables[i], 0.7, 0.7, {
            name = "PearlsMasa_"..i,
            heading = 0,
            debugPoly = false,
            minZ = pearlsTables[i].z - 5.5,
            maxZ = pearlsTables[i].z + 1.0
        }, {
            options = {
                {
                    event = "pearls:client:TableStash",
                    icon = "fas fa-utensils",
                    label = "Masa "..i,
                    stash = "Masa_"..i
                }
            },
            distance = 2.0
        })
    end
end)

RegisterNetEvent('pearls:client:TableStash', function(data)
    local stashName = "Pearls_"..data.stash
    TriggerServerEvent("inventory:server:OpenInventory", "stash", stashName, {
        maxweight = 15000,
        slots = 10
    })
    TriggerEvent("inventory:client:SetCurrentStash", stashName)
end)




