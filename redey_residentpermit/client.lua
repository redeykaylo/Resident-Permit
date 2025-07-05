local ESX = nil

-- Load ESX
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(10)
    end
end)

RegisterCommand('residence', function()
    if ESX == nil then
        print('ESX is not loaded yet, please wait a moment.')
        return
    end

    ESX.TriggerServerCallback('celni:getJob', function(jobName)
        if jobName ~= 'customsoffice' and jobName ~= 'police' then
            ESX.ShowNotification('❌ You do not have permission to use this command.')
            return
        end

        ExecuteCommand('e clipboard')

        local input = lib.inputDialog('📋 Residence Permit', {
            {type = 'input', label = 'First Name', placeholder = 'John'},
            {type = 'input', label = 'Last Name', placeholder = 'Doe'},
            {type = 'input', label = 'Date of Birth', placeholder = '01.01.1990'},
            {type = 'input', label = 'Valid From', placeholder = '01.07.2025'},
            {type = 'input', label = 'Valid Until', placeholder = '01.07.2026'},
        })

        if not input then return end

        TriggerServerEvent('celni:residencepermit:addItem', {
            jmeno = input[1],
            prijmeni = input[2],
            narozeni = input[3],
            od = input[4],
            ["do"] = input[5]
        })
    end)
end, false)
