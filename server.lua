function IsLicenseInUse(license)
    local players = GetPlayers()
    for _, player in pairs(players) do
        local identifiers = GetPlayerIdentifiers(player)
        for _, id in pairs(identifiers) do
            if string.find(id, 'license') then
                local playerLicense = id
                if playerLicense == license then
                    return true
                end
            end
        end
    end
    return false
end



-- Player Connecting

local function OnPlayerConnecting(name, setKickReason, deferrals)
    local player = source
    local license
    local identifiers = GetPlayerIdentifiers(player)
    deferrals.defer()
    Wait(0)
    deferrals.update(string.format('Hello %s. Validating Your Rockstar License', name))
    for _, v in pairs(identifiers) do
        if string.find(v, 'license') then
            license = v
            break
        end
    end
    Wait(2500)
    local isLicenseAlreadyInUse = IsLicenseInUse(license)
    Wait(2500)
    if isLicenseAlreadyInUse then
        deferrals.done('Duplicate Rockstar License Found')
    else
        deferrals.done()
        Wait(1000)
    end
end

AddEventHandler('playerConnecting', OnPlayerConnecting)
