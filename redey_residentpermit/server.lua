ESX = exports['es_extended']:getSharedObject()

ESX.RegisterServerCallback('celni:getJob', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then return cb(nil) end
    cb(xPlayer.job.name)
end)

-- Using the item (e.g., when the player "opens" it in inventory)
ESX.RegisterUsableItem('residence_permit', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local inventoryItem = xPlayer.getInventoryItem('residence_permit')

    if inventoryItem and inventoryItem.metadata then
        local data = inventoryItem.metadata
        local msg = ('📄 Permit: %s %s\n📅 Born: %s\nValidity: %s - %s'):format(
            data.jmeno or '-', 
            data.prijmeni or '-', 
            data.narozeni or '-', 
            data.od or '-', 
            data["do"] or '-'
        )
        TriggerClientEvent('esx:showNotification', source, msg)
    else
        TriggerClientEvent('esx:showNotification', source, '❌ Unable to load item metadata.')
    end
end)

-- Granting the item with job check
RegisterNetEvent('celni:residencepermit:addItem', function(data)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return end

    local job = xPlayer.job.name
    if job ~= 'customsoffice' and job ~= 'police' then
        print(('[ANTICHEAT] Player %s (%s) attempted to issue a permit without permission!'):format(xPlayer.getName(), src))
        DropPlayer(src, "Unauthorized attempt to issue a document.") -- optional
        return
    end

    -- Description for the inventory
    local description = ('%s %s\nBorn: %s\nValidity: %s - %s'):format(
        data.jmeno or '-', 
        data.prijmeni or '-', 
        data.narozeni or '-', 
        data.od or '-', 
        data["do"] or '-'
    )

    -- Adding the item with metadata
    xPlayer.addInventoryItem('residence_permit', 1, {
        jmeno = data.jmeno,
        prijmeni = data.prijmeni,
        narozeni = data.narozeni,
        od = data.od,
        ["do"] = data["do"],
        description = description
    })

    TriggerClientEvent('esx:showNotification', src, '✅ Residence permit has been issued.')
end)
