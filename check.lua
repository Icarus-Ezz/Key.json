repeat wait() until game:IsLoaded() and game.Players.LocalPlayer

local HttpService = game:GetService("HttpService")
local hwid = gethwid and gethwid() or "Unknown"
local key = getgenv().Key or nil

if not key then
    game.Players.LocalPlayer:Kick("⚠️ You must enter a key!")
    return
end

local keyVerifyUrl = "http://de1.bot-hosting.net:20328/check_key_ez?key=" .. key
local hwidCheckUrl = "http://de1.bot-hosting.net:20328/Checkhwid?hwid=" .. hwid .. "&key=" .. key

local function getData(url)
    local success, response = pcall(function()
        return game:HttpGet(url)
    end)

    if success and response and response ~= "" then
        return HttpService:JSONDecode(response)
    end
    return nil
end

-- 🟨 Bước 1: Kiểm tra key trước
local verifyResponse = getData(keyVerifyUrl)
if not verifyResponse or verifyResponse.status ~= "true" then
    game.Players.LocalPlayer:Kick(verifyResponse and verifyResponse.msg or "⚠️ Invalid or expired key.")
    return
end

-- 🟩 Bước 2: Kiểm tra HWID nếu key hợp lệ
local hwidResponse = getData(hwidCheckUrl)
if hwidResponse and hwidResponse.status == "true" then
    print("✅ Success - HWID matched")

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
        game.Players.LocalPlayer:Kick("⚠️ This game is not supported.")
    end
else
    game.Players.LocalPlayer:Kick(hwidResponse and hwidResponse.message or "⚠️ Invalid HWID.")
end
