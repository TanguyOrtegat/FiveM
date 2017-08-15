--
-- Created by IntelliJ IDEA.
-- User: Djyss
-- Date: 24/05/2017
-- Time: 02:37
-- To change this template use File | Settings | File Templates.
--
----------------------------------------------------- INIT DATABASE  ---------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

server_script "resources/essentialmode/lib/MySQL.lua"
MySQL:open(database.host, database.name, database.username, database.password)

-----------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("accessories_switcher:server_wearHat")
RegisterServerEvent("accessories_switcher:server_wearPercing")
RegisterServerEvent("accessories_switcher:server_wearGlasses")
RegisterServerEvent("accessories_switcher:server_wearMask")

AddEventHandler("accessories_switcher:server_wearHat", function()
    TriggerEvent('es:getPlayerFromId', source, function(user)
        local playerSkin_query = MySQL:executeQuery("SELECT * FROM clothes_users_props JOIN clothes_props ON `clothes_users_props`.`prop_id` = `clothes_props`.`id` WHERE identifier = '@username' AND `clothes_users_props`.`category`='hat' AND current='1'", {['@username'] = user.identifier})
        local skin = MySQL:getResults(playerSkin_query, {'id', 'category', 'price', 'item_id', 'prop_txt'}, "id")
        if skin[1] then
            TriggerClientEvent("accessories_switcher:WearHat", source, skin[1])
        end
    end)
end)

AddEventHandler("accessories_switcher:server_wearGlasses", function()
    TriggerEvent('es:getPlayerFromId', source, function(user)
        local playerSkin_query = MySQL:executeQuery("SELECT * FROM clothes_users_props JOIN clothes_props ON `clothes_users_props`.`prop_id` = `clothes_props`.`id` WHERE identifier = '@username' AND `clothes_users_props`.`category`='glasses' AND current='1'", {['@username'] = user.identifier})
        local skin = MySQL:getResults(playerSkin_query,{'id', 'category', 'price', 'item_id', 'prop_txt'}, "id")
        if skin[1] then
            TriggerClientEvent("accessories_switcher:WearGlasses", source, skin[1])
        end
    end)
end)

AddEventHandler("accessories_switcher:server_wearPercing", function()
    TriggerEvent('es:getPlayerFromId', source, function(user)
        local playerSkin_query = MySQL:executeQuery("SELECT * FROM skin WHERE identifier = '@username'", {['@username'] = user.identifier})
        local skin = MySQL:getResults(playerSkin_query, {'identifier','percing', 'percing_txt'}, "identifier")
        if(skin)then
            for k,v in ipairs(skin)do
                if v.percing ~= nil then
                    TriggerClientEvent("accessories_switcher:WearPercing", source, v)
                end
            end
        end
    end)
end)

AddEventHandler("accessories_switcher:server_wearMask", function()
    TriggerEvent('es:getPlayerFromId', source, function(user)
        local playerSkin_query = MySQL:executeQuery("SELECT * FROM clothes_users_outfits JOIN clothes_outfits ON `clothes_users_outfits`.`outfit_id` = `clothes_outfits`.`id` WHERE identifier = '@username' AND current= 1", {['@username'] = user.identifier})
        local skin = MySQL:getResults(playerSkin_query, {'identifier','mask', 'mask_txt'}, "identifier")
        if(skin)then
            for k,v in ipairs(skin)do
                if v.mask ~= nil then
                    TriggerClientEvent("accessories_switcher:WearMask", source, v)
                end
            end
        end
    end)
end)