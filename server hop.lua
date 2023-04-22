local Players = game:GetService("Players")
local API_URL = string.format("https://games.roblox.com/v1/games/%s/servers/Public?sortOrder=Desc&limit=100", tostring(game.PlaceId))
local Player = Players.LocalPlayer
local TeleportService = game:GetService("TeleportService")
local Http = game:GetService("HttpService")

local function ServerHop()
    function GetServers(cursor)
        cursor = cursor and "&cursor=" .. cursor or ""
        return Http:JSONDecode(game:HttpGet(API_URL .. cursor))
    end

    local cursor = nil
    local teleported = false
    while not teleported do 
        local servers = GetServers(cursor)
        for i,v in next, servers.data do
            if v.playing and v.playing < game.Players.MaxPlayers and v.id ~= game.JobId then
                local success ,_ = pcall(TeleportService.TeleportToPlaceInstance, TeleportService, game.PlaceId, v.id, Player)
                if success then teleported = true break end -- Successfully teleported, break loop
            end
        end

        cursor = servers.nextPageCursor
        if teleported or not cursor then break end
        -- wait so we don't spam roblox api
        wait(0.1)
    end
    if teleported then print("Successfully teleported!") end
end
