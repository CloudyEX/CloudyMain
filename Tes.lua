local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/QuantumPH2/UI/refs/heads/main/NewEraUI.lua"))()

local MarketplaceService = game:GetService("MarketplaceService")
local TeleportService = game:GetService("TeleportService")
local supportedMaps = {["121864768012064"] = "Fish it"}
local success, info = pcall(function() return MarketplaceService:GetProductInfo(game.PlaceId) end)
local mapName = success and info.Name or "Unknown"
local isSupported = supportedMaps[tostring(game.PlaceId)] ~= nil

local Window = Fluent:CreateWindow({
    Title = "Cloudy",
    TitleIcon = "lucide/cloud",
    SubTitle = "versi 1.0.4.0 Fish it",
    MinWindowSize = Vector2.new(440, 250),
    Size = UDim2.fromOffset(525, 290),
    Acrylic = false,
    Theme = "Cloudy",
    MinimizeKey = Enum.KeyCode.LeftControl,
    MinimizeIcon = "rbxassetid://109388426525855"
})

pcall(function()
    if Window.SetMinimizeIcon then
        Window:SetMinimizeIcon("rbxassetid://109388426525855")
    end
end)

local InfoTab      = Window:AddTab({ Title = "Info", Icon = "solar/info-circle-bold" })
local PlayersTab   = Window:AddTab({ Title = "Players", Icon = "solar/user-bold" })
local KaitunTab    = Window:AddTab({ Title = "Kaitun", Icon = "solar/crown-star-bold" })
local MainTab      = Window:AddTab({ Title = "Automation", Icon = "solar/fire-bold" })
local ExclusiveTab = Window:AddTab({ Title = "QH Fishing", Icon = "solar/water-bold" })
local CraftAbilityTab = nil
local AquariumTab  = nil
local FlyTab       = Window:AddTab({ Title = "Teleport", Icon = "solar/map-point-bold" })
local ShopTab      = Window:AddTab({ Title = "Shop", Icon = "solar/shop-bold" })
local EventTab     = nil
local MiscTab      = Window:AddTab({ Title = "Misc", Icon = "solar/settings-minimalistic-bold" })
local QuestTab     = Window:AddTab({ Title = "Quest", Icon = "solar/notes-bold" })
local VisualTab    = Window:AddTab({ Title = "Visual", Icon = "solar/eye-bold" })
local ConfigTab    = Window:AddTab({ Title = "Configuration", Icon = "solar/settings-bold" })

pcall(function()
    if Fluent.SaveManager then
        Fluent.SaveManager:SetLibrary(Fluent)
        Fluent.SaveManager:SetFolder("CloudyHUB/FishDawg")
        Fluent.SaveManager:BuildConfigSection(ConfigTab)
    end
    if Fluent.InterfaceManager then
        Fluent.InterfaceManager:SetLibrary(Fluent)
        Fluent.InterfaceManager:SetFolder("CloudyHUB/FishDawg")
        Fluent.InterfaceManager:BuildInterfaceSection(ConfigTab)
    end
end)

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local Stats = game:GetService("Stats")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")

local LocalPlayer
repeat task.wait() until Players.LocalPlayer
LocalPlayer = Players.LocalPlayer

_G.S = _G.S or {}
_G.S.Players = Players
_G.S.ReplicatedStorage = ReplicatedStorage
_G.S.RunService = RunService
_G.S.UserInputService = UserInputService
_G.S.HttpService = HttpService
_G.S.Stats = Stats
_G.S.Lighting = Lighting
_G.S.Workspace = Workspace
_G.S.CoreGui = CoreGui
_G.S.TweenService = TweenService
_G.S.LocalPlayer = LocalPlayer
_G.S.isMobile = UserInputService.TouchEnabled

local _scriptInitialized = false
local function NotifySuccess(title, text)
    if not _scriptInitialized then return end
    pcall(function() if Fluent and Fluent.Notify then Fluent:Notify({ Title = "[OK] "   .. title, Content = text, Duration = 3, Icon = "solar/check-circle-bold" }) end end)
end
local function NotifyWarning(title, text)
    if not _scriptInitialized then return end
    pcall(function() if Fluent and Fluent.Notify then Fluent:Notify({ Title = "[WARN] " .. title, Content = text, Duration = 3, Icon = "solar/danger-triangle-bold" }) end end)
end
local function NotifyError(title, text)
    if not _scriptInitialized then return end
    pcall(function() if Fluent and Fluent.Notify then Fluent:Notify({ Title = "[ERR] "  .. title, Content = text, Duration = 3, Icon = "solar/close-circle-bold" }) end end)
end
local function NotifyInfo(title, text)
    if not _scriptInitialized then return end
    pcall(function() if Fluent and Fluent.Notify then Fluent:Notify({ Title = "[INFO] " .. title, Content = text, Duration = 3, Icon = "solar/info-circle-bold" }) end end)
end
local cloneref = (cloneref or clonereference or function(i) return i end)
local net
pcall(function()
    net = ReplicatedStorage:WaitForChild("Packages", 10)
        :WaitForChild("_Index", 10)
        :WaitForChild("sleitnick_net@0.2.0", 10)
        :WaitForChild("net", 10)
end)
if net then pcall(function() print("[QH] Remotes: " .. #net:GetChildren()) end) end

local function GetServerRemote(targetName)
    if not net then return nil end
    local allRemotes = net:GetChildren()
    for i, remote in ipairs(allRemotes) do
        if remote.Name == targetName then
            if allRemotes[i + 1] then return allRemotes[i + 1] end
        end
    end
    return nil
end

local function GetServerRemoteReverse(targetName)
    if not net then return nil end
    local allRemotes = net:GetChildren()
    for i, remote in ipairs(allRemotes) do
        if remote.Name == targetName then
            if allRemotes[i - 1] then return allRemotes[i - 1] end
        end
    end
    return nil
end

local function CallRemote(remote, ...)
    if not remote then return false end
    local ok = false
    if remote:IsA("RemoteFunction") then
        ok = pcall(function(...) remote:InvokeServer(...) end, ...)
    elseif remote:IsA("RemoteEvent") then
        ok = pcall(function(...) remote:FireServer(...) end, ...)
    end
    return ok
end

local PingMonitor = {History={}, MaxSamples=10, CurrentPing=50, AveragePing=50, Jitter=0, LastSample=tick()}
function PingMonitor:GetPing()
    local networkStats = Stats:FindFirstChild("Network")
    if networkStats and networkStats:FindFirstChild("ServerStatsItem") then
        local pingData = networkStats.ServerStatsItem:FindFirstChild("Data Ping")
        if pingData then local val = pingData:GetValue(); if val then return math.floor(val) end end
    end
    return 50
end
function PingMonitor:Update()
    local now = tick()
    if now - self.LastSample < 0.5 then return end
    self.LastSample = now
    local currentPing = self:GetPing()
    self.CurrentPing = currentPing
    table.insert(self.History, currentPing)
    if #self.History > self.MaxSamples then table.remove(self.History, 1) end
    local total, minP, maxP = 0, math.huge, 0
    for _, p in ipairs(self.History) do
        total = total + p
        if p < minP then minP = p end
        if p > maxP then maxP = p end
    end
    self.AveragePing = math.floor(total / #self.History)
    self.Jitter = maxP - minP
end
function PingMonitor:IsStable() return self.Jitter < 30 and self.AveragePing < 150 end

local Replion, PlayerData, ItemUtility, TierUtility
local Controllers = {}

local function FindReplionModule()
    local packages = ReplicatedStorage:FindFirstChild("Packages")
    if not packages then return nil end
    local direct = packages:FindFirstChild("Replion")
    if direct then return direct end
    local idx = packages:FindFirstChild("_Index")
    if idx then
        for _, child in ipairs(idx:GetChildren()) do
            if child.Name:find("ytrev_replion") or child.Name:find("replion") then
                local mod = child:FindFirstChild("replion")
                if mod then return mod end
            end
        end
    end
    return nil
end

pcall(function()
    local replionModule = FindReplionModule()
    if replionModule then
        Replion = require(replionModule)
        PlayerData = Replion.Client:WaitReplion("Data")
    end
    ItemUtility = require(ReplicatedStorage.Shared.ItemUtility)
    TierUtility = require(ReplicatedStorage:WaitForChild("Shared", 5):WaitForChild("TierUtility", 5))
end)

if isMobile then
    pcall(function()
        local ctrl = ReplicatedStorage:WaitForChild("Controllers", 5)
        if ctrl then
            local notifCtrl = ctrl:FindFirstChild("NotificationController")
            if notifCtrl then Controllers.Notification = require(notifCtrl) end
            local vfxCtrl = ctrl:FindFirstChild("VFXController")
            if vfxCtrl then Controllers.VFX = require(vfxCtrl) end
            local fishCtrl = ctrl:FindFirstChild("FishingController")
            if fishCtrl then Controllers.Fishing = require(fishCtrl) end
            local backCtrl = ctrl:FindFirstChild("BackpackController")
            if backCtrl then Controllers.Backpack = require(backCtrl) end
        end
    end)
end

local origPlaySmallItemObtained
pcall(function()
    if isMobile and Controllers.Notification and Controllers.Notification.PlaySmallItemObtained then
        origPlaySmallItemObtained = Controllers.Notification.PlaySmallItemObtained
    end
end)

local Events = {}
local function loadRemotes()
    local loaded, failed = 0, 0
    local remoteList = {
    cancel_fishing_input    = "CancelFishingInputs",
    cancel_fishing_input    = "CancelFishingInputs",
    minigame_remote         = "RequestFishingMinigameStarted",
    finish_remote           = "CatchFishCompleted",
    equip_tool_remote       = "EquipToolFromHotbar",
    equip_item              = "EquipItem",
    charge_rod_remote       = "ChargeFishingRod",
    sell_all_items          = "SellAllItems",
    un_equip_tool           = "UnequipToolFromHotbar",
    favorite_item           = "FavoriteItem",
    purchase_weather        = "PurchaseWeatherEvent",
    activate_enchant        = "ActivateEnchantingAltar",
    second_active_enchant   = "ActivateSecondEnchantingAltar",
    spawn_totem             = "SpawnTotem",
    get_drops               = "GetDrops",
    claim_relic             = "ClaimRelic",
    search_pickup           = "SearchPickup",
    gain_access_to_maze     = "GainAccessToMaze",
    pirate_chest            = "ClaimPirateChest",
    unequip_item            = "UnequipItem",
    consume_potion          = "ConsumePotion",
    consume_cave_crystal    = "ConsumeCaveCrystal",
    purchase_bait_remote    = "PurchaseBait",
    purchase_rod_remote     = "PurchaseFishingRod",
    purchase_charm          = "PurchaseCharm",
    equip_charm             = "EquipCharm",
    unequip_charm           = "UnequipCharm",
    purchase_merchant_item  = "PurchaseMarketItem",
    fishing_radar           = "UpdateFishingRadar",
    diving_gear             = "EquipOxygenTank",
    update_auto_fishing     = "UpdateAutoFishingState",
    fishing_stopped         = "FishingStopped",
    bait_cast_visual        = "BaitCastVisual",
    bait_destroyed          = "BaitDestroyed",
    ability_roll_remote     = "RequestAbilityRoll",
    rod_crafting_click      = "RodCraftingMinigameClick",
    start_rod_crafting      = "StartRodCraftingMinigame",
    finish_rod_crafting     = "FinishRodCraftingMinigame",
    play_rod_crafting       = "PlayRodCraftingMinigame",
    equip_pet               = "Pets/Equip",
    unequip_pet             = "Pets/Unequip",
    caught_pet_fish_visual  = "Pets/CaughtFishVisual",
    instant_craft           = "InstantCraft",
    sell_item               = "SellItem",
    start_crafting          = "StartCrafting",
    confirm_crafting        = "ConfirmCrafting",
    fishNotif               = "ObtainedNewFishNotification",
    fish_caught             = "FishCaught",
    }
    for key, remoteName in pairs(remoteList) do
        local remote = GetServerRemote(remoteName) or GetServerRemote("RF/" .. remoteName) or GetServerRemote("RE/" .. remoteName)
        Events[key] = remote
        if remote then loaded = loaded + 1
        else failed = failed + 1; warn("[QH] Remote gagal: " .. remoteName) end
    end
    Events.UpdateAutoFishing = Events.update_auto_fishing or GetServerRemote("RF/UpdateAutoFishingState")
    Events.equip = Events.equip_tool_remote or GetServerRemote("RF/EquipToolFromHotbar")
    Events.equipToolRemote = Events.equip_tool_remote or GetServerRemote("RF/EquipToolFromHotbar")
    Events.equipItemRemote = Events.equip_item or GetServerRemote("RF/EquipItem")
    Events.cancel_fishing_input = Events.cancel_fishing_input or GetServerRemote("RF/CancelFishingInputs")
    print("[QH] Loaded: " .. loaded .. " | Failed: " .. failed)
    return loaded, failed
end
local loadedCount, failedCount = loadRemotes()

local Config = {
    AutoCatch = false, CatchDelay = 0.7,
    UB = {Active = false, UseCastMode = true, CastMode = "Perfect", Settings = {CastDelay = 0.3, HookDelay = 0.3}, Remotes = {}, Stats = {castCount = 0, startTime = 0.0}},
    CloudyV1 = {Active = false, UseCastMode = true, CastMode = "Perfect", CastDelay = 0.3, HookDelay = 2.8671},
    Cloudy1N = {Active = false, UseCastMode = true, CastMode = "Perfect", CastDelay = 0.3, HookDelay = 2.8671},
    InstantFishing = {Active = false, UseCastMode = true, CastMode = "Perfect", CastDelay = 0.3, HookDelay = 0.05},
    amblatant = false, antiOKOK = false, autoFishing = false, PerfectionEnchant = false,
    AutoSellState = false, AutoSellMethod = "Delay", AutoSellValue = 50,
    AutoFavoriteState = false, AutoUnfavoriteState = false,
    SelectedRarities = {}, SelectedMutations = {},
    AutoTotem = false, SelectedTotemID = 0,
    CustomWebhook = false, CustomWebhookUrl = "", CustomWebhookRarities = {"Common", "Uncommon", "Rare", "Epic", "Legendary", "Mythic", "Secret", "Forgotten"},
    WebhookDiscordId = "", WebhookMentionTiers = {},
    DisableAnimations = false, HookNotif = false,
    DisableObtained = false, DisablePopUp = false,
    WalkOnWater = false,
    AutoEvent = false, NotifDelay = 0.1,
    NotifCount = 1, UBNotifDurationMult = 2.0,
    CastMode = "Perfect",
    CatchQuality = "Perfect",

    AutoSpin = false,
    AutoConsumePotion = false,
    AutoClaimBounty = false,
    FishingRadar = false,

    DropCollectRadius = 50,

    autoForgotten = false,
    autoSecret = false,

    YTTA = {Active = false, Settings = {QHDelay = 0.3}, NotifCount = 3, NotifDelay = 0.1},
}

_G.QHBetaAnimSpeed = false

local _instanceId = math.random(1, 999999)
local _logPrefix = "[QH_" .. _instanceId .. "]"

local Tasks = {}
local needCast = true
local skip = false
local isCaught = false
local lastTimeFishCaught = nil
local blatantFishCycleCount = 1

local function GetCatchQuality(castMode)
    if castMode == "Perfect" then
        return "Perfect"
    end
    return "Good"
end

local function GetCastingQualityParam(useCastMode, castMode)
    if not useCastMode then return 0 end
    if castMode == "Perfect" then return 1 end
    return 0
end

local function GetCastingWait(castDelay)
    return math.max(castDelay or 0.2, 0.001)
end
local function GetNewestFishFromInventory()
    local newest = nil
    pcall(function()
        local replion = PlayerData
        if not replion then return end
        local invData
        pcall(function() invData = replion:GetExpect("Inventory") end)
        if not invData or not invData.Items then return end
        local newUUIDs = {}
        for _, item in ipairs(invData.Items) do
            local key = tostring(item.UUID or item.Id or "")
            newUUIDs[key] = true
            if item.Id and not _prevInventoryUUIDs[key] then
                newest = item
            end
        end
        _prevInventoryUUIDs = newUUIDs
    end)
    return newest
end

local function ExtractFishNotifArgs(raw)
    if not raw or #raw == 0 then return nil end
    local id, meta, inv = nil, nil, nil
    if type(raw[1]) == "string" then
        if type(raw[2]) == "table" then
            inv = raw[2]
            id = inv.Id or inv.id or inv.ItemId
            meta = inv.Metadata or inv.metadata
        elseif type(raw[2]) == "number" or type(raw[2]) == "string" then
            id = raw[2]
            if type(raw[3]) == "table" then meta = raw[3] end
            if type(raw[4]) == "table" then inv = raw[4] end
        end
    elseif type(raw[1]) == "number" or type(raw[1]) == "string" then
        id = raw[1]
        if type(raw[2]) == "table" then meta = raw[2] end
        if type(raw[3]) == "table" then inv = raw[3] end
    elseif type(raw[1]) == "table" then
        inv = raw[1]
        id = inv.Id or inv.id or inv.ItemId
        meta = inv.Metadata or inv.metadata
    end
    if not id then return nil end
    return {id, meta or {}, inv or {Id = id, Metadata = meta or {}}}
end

local TextNotificationController = nil
pcall(function()
    TextNotificationController = require(ReplicatedStorage.Controllers.TextNotificationController)
end)

pcall(function()
    local AnimationController = require(ReplicatedStorage.Controllers.AnimationController)
    if not AnimationController or not AnimationController.PlayAnimation then return end
    local oldPlay = AnimationController.PlayAnimation
    AnimationController.PlayAnimation = function(self, animName, ...)
        local track, info = oldPlay(self, animName, ...)
        local speedUp = _G.QHBetaAnimSpeed or Config.InstantFishing.Active or Config.InstantV2.Active or Config.amblatant
        if speedUp and animName == "FishCaught" and track then
            pcall(function() track:AdjustSpeed(7) end)
        end
        return track, info
    end
end)

local FishCaughtRemote = Events.fish_caught or GetServerRemote("RE/FishCaught")

if _G.FishCaughtConn then
    pcall(function() _G.FishCaughtConn:Disconnect() end)
    _G.FishCaughtConn = nil
end

if FishCaughtRemote and FishCaughtRemote:IsA("RemoteEvent") then
    _G.FishCaughtConn = FishCaughtRemote.OnClientEvent:Connect(function(fishId, _, _, fishData)
        task.spawn(function()
            task.wait(0.1)

            local quantity = 1
            if type(fishData) == "table" and fishData.Quantity then
                quantity = fishData.Quantity
            end

            local notifTable = {
                Type = "Item",
                ItemType = "Fish",
                ItemId = fishId,
                Quantity = quantity,
            }

            pcall(function()
                if TextNotificationController and TextNotificationController.DeliverNotification then
                    TextNotificationController:DeliverNotification(notifTable)
                end
            end)
        end)
    end)
else
    warn("[QH] Remote RE/FishCaught tidak ditemukan untuk hook notifikasi!")
end

    pcall(function()
        local ctrlFolder = ReplicatedStorage:FindFirstChild("Controllers")
        if not ctrlFolder then return end
        local m = ctrlFolder:FindFirstChild("TextNotificationController")
        if not m then return end
        local ctrl = require(m)
        if ctrl and ctrl.DeliverNotification then
            local id = notifArgs[1]
            local meta = type(notifArgs[2]) == "table" and notifArgs[2] or {}
            ctrl:DeliverNotification({Type = "Item", Id = id, Metadata = meta})
        end
    end)

_G.QHInstances = _G.QHInstances or {}
_G.QHInstances[_instanceId] = _G.QHInstances[_instanceId] or {
    SavedData = {FishCaught = {}, CaughtVisual = {}, FishNotif = {}},
    NotifQueue = {},
    NotifActive = 0
}

_G.SavedData = _G.SavedData or {FishCaught = {}, CaughtVisual = {}, FishNotif = {}}
_G.NotifQueue = _G.NotifQueue or {}
_G.NotifActive = _G.NotifActive or 0

local FreeCam = {}
do
    local Camera = workspace.CurrentCamera
    local isActive = false
    local savedState = {}
    local cameraPos = Vector3.zero
    local yaw = 0
    local pitch = 0
    local deltaYaw = 0
    local deltaPitch = 0

    local inputState = {
        W = 0, A = 0, S = 0, D = 0,
        E = 0, Q = 0, Space = 0, Ctrl = 0,
        Shift = 0
    }
    local rotating = false
    local activeTouches = {}

    local renderConn = nil
    local inputBeganConn = nil
    local inputEndedConn = nil
    local inputChangedConn = nil

    _G.FreeCamSpeed = _G.FreeCamSpeed or 5
    _G.FreeCamSensitivity = _G.FreeCamSensitivity or 5

    local function resetInput()
        inputState.W = 0
        inputState.A = 0
        inputState.S = 0
        inputState.D = 0
        inputState.E = 0
        inputState.Q = 0
        inputState.Space = 0
        inputState.Ctrl = 0
        inputState.Shift = 0
        rotating = false
        activeTouches = {}
        deltaYaw = 0
        deltaPitch = 0
    end

    local function onInputBegan(input, gameProcessed)
        if input.UserInputType == Enum.UserInputType.Keyboard then
            if input.KeyCode == Enum.KeyCode.W then inputState.W = 1
            elseif input.KeyCode == Enum.KeyCode.S then inputState.S = 1
            elseif input.KeyCode == Enum.KeyCode.A then inputState.A = 1
            elseif input.KeyCode == Enum.KeyCode.D then inputState.D = 1
            elseif input.KeyCode == Enum.KeyCode.E or input.KeyCode == Enum.KeyCode.Space then inputState.E = 1
            elseif input.KeyCode == Enum.KeyCode.Q or input.KeyCode == Enum.KeyCode.LeftControl then inputState.Q = 1
            elseif input.KeyCode == Enum.KeyCode.LeftShift or input.KeyCode == Enum.KeyCode.RightShift then inputState.Shift = 1
            end
        elseif input.UserInputType == Enum.UserInputType.MouseButton2 then
            rotating = true
        elseif input.UserInputType == Enum.UserInputType.Touch then
            local vp = Camera.ViewportSize
            local pos = Vector2.new(input.Position.X, input.Position.Y)
            if pos.X < vp.X * 0.45 then
                activeTouches[input] = { Type = "Move", StartPos = pos }
            else
                activeTouches[input] = { Type = "Look", StartPos = pos }
            end
        end
    end

    local function onInputEnded(input, gameProcessed)
        if input.UserInputType == Enum.UserInputType.Keyboard then
            if input.KeyCode == Enum.KeyCode.W then inputState.W = 0
            elseif input.KeyCode == Enum.KeyCode.S then inputState.S = 0
            elseif input.KeyCode == Enum.KeyCode.A then inputState.A = 0
            elseif input.KeyCode == Enum.KeyCode.D then inputState.D = 0
            elseif input.KeyCode == Enum.KeyCode.E or input.KeyCode == Enum.KeyCode.Space then inputState.E = 0
            elseif input.KeyCode == Enum.KeyCode.Q or input.KeyCode == Enum.KeyCode.LeftControl then inputState.Q = 0
            elseif input.KeyCode == Enum.KeyCode.LeftShift or input.KeyCode == Enum.KeyCode.RightShift then inputState.Shift = 0
            end
        elseif input.UserInputType == Enum.UserInputType.MouseButton2 then
            rotating = false
        elseif input.UserInputType == Enum.UserInputType.Touch then
            local data = activeTouches[input]
            if data and data.Type == "Move" then
                inputState.W = 0
                inputState.S = 0
                inputState.A = 0
                inputState.D = 0
            end
            activeTouches[input] = nil
        end
    end

    local function onInputChanged(input, gameProcessed)
        local sensFactor = (_G.FreeCamSensitivity or 5) / 5
        if rotating and input.UserInputType == Enum.UserInputType.MouseMovement then
            local sens = 0.003 * sensFactor
            deltaYaw = deltaYaw - input.Delta.X * sens
            deltaPitch = deltaPitch - input.Delta.Y * sens
        elseif input.UserInputType == Enum.UserInputType.Touch then
            local data = activeTouches[input]
            if data then
                if data.Type == "Look" then
                    local sens = 0.004 * sensFactor
                    deltaYaw = deltaYaw - input.Delta.X * sens
                    deltaPitch = deltaPitch - input.Delta.Y * sens
                elseif data.Type == "Move" and data.StartPos then
                    local curr = Vector2.new(input.Position.X, input.Position.Y)
                    local diff = curr - data.StartPos
                    local deadzone = 8
                    local maxDist = 50

                    if math.abs(diff.Y) > deadzone then
                        inputState.W = math.clamp(-diff.Y / maxDist, 0, 1)
                        inputState.S = math.clamp(diff.Y / maxDist, 0, 1)
                    else
                        inputState.W = 0
                        inputState.S = 0
                    end

                    if math.abs(diff.X) > deadzone then
                        inputState.D = math.clamp(diff.X / maxDist, 0, 1)
                        inputState.A = math.clamp(-diff.X / maxDist, 0, 1)
                    else
                        inputState.D = 0
                        inputState.A = 0
                    end
                end
            end
        elseif input.UserInputType == Enum.UserInputType.MouseWheel then
            local change = input.Position.Z > 0 and 1 or -1
            _G.FreeCamSpeed = math.clamp((_G.FreeCamSpeed or 5) + change, 1, 20)
        end
    end

    local function StepFreecam(dt)
        if not isActive then return end

        pitch = math.clamp(pitch + deltaPitch, -math.rad(89.5), math.rad(89.5))
        yaw = (yaw + deltaYaw) % (2 * math.pi)
        deltaPitch = 0
        deltaYaw = 0

        local rotCF = CFrame.fromEulerAnglesYXZ(pitch, yaw, 0)
        local forwardVec = rotCF.LookVector
        local rightVec = rotCF.RightVector
        local upVec = Vector3.new(0, 1, 0)

        local moveDir = Vector3.zero
        if inputState.W > 0 then moveDir = moveDir + forwardVec * inputState.W end
        if inputState.S > 0 then moveDir = moveDir - forwardVec * inputState.S end
        if inputState.D > 0 then moveDir = moveDir + rightVec * inputState.D end
        if inputState.A > 0 then moveDir = moveDir - rightVec * inputState.A end
        if inputState.E > 0 or inputState.Space > 0 then moveDir = moveDir + upVec end
        if inputState.Q > 0 or inputState.Ctrl > 0 then moveDir = moveDir - upVec end

        if moveDir.Magnitude > 0 then
            moveDir = moveDir.Unit
        end

        local baseSpeed = (_G.FreeCamSpeed or 5) * 16
        local boostMult = (inputState.Shift > 0) and 3 or 1
        cameraPos = cameraPos + moveDir * (baseSpeed * boostMult * dt)

        Camera.CFrame = CFrame.new(cameraPos) * rotCF
        Camera.FieldOfView = savedState.Fov or 70
    end

    function FreeCam.Enable()
        if isActive then return end
        isActive = true

        Camera = workspace.CurrentCamera
        savedState.CameraType = Camera.CameraType
        savedState.CameraCFrame = Camera.CFrame
        savedState.Fov = Camera.FieldOfView
        savedState.MouseBehavior = UserInputService.MouseBehavior
        savedState.MouseIconEnabled = UserInputService.MouseIconEnabled
        savedState.Subject = Camera.CameraSubject

        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if hrp then
            savedState.HrpAnchored = hrp.Anchored
            hrp.Anchored = true
            hrp.AssemblyLinearVelocity = Vector3.zero
            hrp.AssemblyAngularVelocity = Vector3.zero
        end

        pcall(function()
            local PlayerModule = require(LocalPlayer:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule"))
            PlayerModule:GetControls():Disable()
        end)

        Camera.CameraType = Enum.CameraType.Scriptable
        cameraPos = savedState.CameraCFrame.Position

        local rx, ry, rz = savedState.CameraCFrame:ToEulerAnglesYXZ()
        pitch = rx
        yaw = ry
        deltaPitch = 0
        deltaYaw = 0

        UserInputService.MouseBehavior = Enum.MouseBehavior.Default
        UserInputService.MouseIconEnabled = true
        resetInput()

        inputBeganConn = UserInputService.InputBegan:Connect(onInputBegan)
        inputEndedConn = UserInputService.InputEnded:Connect(onInputEnded)
        inputChangedConn = UserInputService.InputChanged:Connect(onInputChanged)
        renderConn = RunService.RenderStepped:Connect(StepFreecam)

        NotifySuccess("FreeCam", "FreeCam aktif!")
    end

    function FreeCam.Disable()
        if not isActive then return end
        isActive = false

        if renderConn then renderConn:Disconnect(); renderConn = nil end
        if inputBeganConn then inputBeganConn:Disconnect(); inputBeganConn = nil end
        if inputEndedConn then inputEndedConn:Disconnect(); inputEndedConn = nil end
        if inputChangedConn then inputChangedConn:Disconnect(); inputChangedConn = nil end

        resetInput()

        pcall(function()
            local PlayerModule = require(LocalPlayer:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule"))
            PlayerModule:GetControls():Enable()
        end)

        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local hum = char and char:FindFirstChildOfClass("Humanoid")

        if hrp then
            hrp.Anchored = savedState.HrpAnchored or false
            hrp.AssemblyLinearVelocity = Vector3.zero
            hrp.AssemblyAngularVelocity = Vector3.zero
        end

        Camera = workspace.CurrentCamera
        if Camera then
            Camera.CameraType = Enum.CameraType.Custom
            if hum then
                Camera.CameraSubject = hum
            elseif hrp then
                Camera.CameraSubject = hrp
            end
            Camera.FieldOfView = savedState.Fov or 70

            if hrp then
                local targetPos = hrp.Position + Vector3.new(0, 2, 0)
                local camPos = targetPos - (hrp.CFrame.LookVector * 12) + Vector3.new(0, 3, 0)
                Camera.CFrame = CFrame.new(camPos, targetPos)
            end
        end

        task.defer(function()
            local currentCam = workspace.CurrentCamera
            if currentCam and not isActive then
                currentCam.CameraType = Enum.CameraType.Custom
                local c = LocalPlayer.Character
                local h = c and c:FindFirstChildOfClass("Humanoid")
                if h then
                    currentCam.CameraSubject = h
                end
            end
        end)

        UserInputService.MouseBehavior = Enum.MouseBehavior.Default
        UserInputService.MouseIconEnabled = true
        NotifyInfo("FreeCam", "FreeCam dinonaktifkan.")
    end

    LocalPlayer.CharacterAdded:Connect(function()
        if isActive then
            FreeCam.Disable()
        end
    end)

    function FreeCam.Toggle()
        if isActive then FreeCam.Disable() else FreeCam.Enable() end
        return isActive
    end

    function FreeCam.IsActive()
        return isActive
    end

    function FreeCam.SetSpeed(speed)
        _G.FreeCamSpeed = math.clamp(speed, 1, 20)
    end

    function FreeCam.SetSensitivity(sens)
        _G.FreeCamSensitivity = math.clamp(sens, 1, 20)
    end
end
_G.FreeCam = FreeCam

local function getHRP()
    local char = LocalPlayer.Character
    if not char then return nil end
    return char:FindFirstChild("HumanoidRootPart")
end

local function findPirateChestPart(chest)
    if not chest then return nil end
    if chest:IsA("BasePart") then
        return chest
    end
    if chest.PrimaryPart and chest.PrimaryPart:IsA("BasePart") then
        return chest.PrimaryPart
    end
    for _, descendant in ipairs(chest:GetDescendants()) do
        if descendant:IsA("BasePart") then
            return descendant
        end
    end
    return nil
end

local function findPirateChestInteraction(chest)
    if not chest then return nil, nil end
    local prompt, click = nil, nil
    for _, descendant in ipairs(chest:GetDescendants()) do
        if descendant:IsA("ProximityPrompt") and descendant.Enabled then
            prompt = descendant
            break
        end
        if not click and descendant:IsA("ClickDetector") then
            click = descendant
        end
    end
    return prompt, click
end

local function interactPirateChest(chest, savedCFrame)
    local hrp = getHRP()
    if not hrp or not chest then return false end

    local chestPart = findPirateChestPart(chest)
    if not chestPart then return false end

    local originalPos = savedCFrame or hrp.CFrame
    local targetPos = chestPart.Position + Vector3.new(0, 1.5, 2.5)
    local targetCFrame = CFrame.lookAt(targetPos, chestPart.Position)

    local teleported = TeleportTo(targetCFrame)
    if not teleported then
        pcall(function() hrp.CFrame = targetCFrame end)
    end
    task.wait(0.35)

    -- Remote claim with RE/ClaimPirateChest
    local claimRemote = Events.pirate_chest or GetServerRemote("RE/ClaimPirateChest") or GetServerRemote("ClaimPirateChest") or GetServerRemote("RF/ClaimPirateChest")
    if claimRemote then
        pcall(function()
            if claimRemote:IsA("RemoteEvent") then
                claimRemote:FireServer(chest)
                claimRemote:FireServer()
            elseif claimRemote:IsA("RemoteFunction") then
                claimRemote:InvokeServer(chest)
                claimRemote:InvokeServer()
            end
        end)
    end

    local prompt, click = findPirateChestInteraction(chest)
    if prompt then
        pcall(function()
            prompt.RequiresLineOfSight = false
            prompt.MaxActivationDistance = math.max(prompt.MaxActivationDistance or 10, 35)
        end)
        local hold = (prompt.HoldDuration and prompt.HoldDuration > 0) and prompt.HoldDuration or 0.7
        if typeof(fireproximityprompt) == "function" then
            pcall(function() fireproximityprompt(prompt, 0) end)
            pcall(function() fireproximityprompt(prompt, hold) end)
            pcall(function() fireproximityprompt(prompt) end)
        end
        pcall(function() prompt:InputHoldBegin() end)
        local startTime = tick()
        while tick() - startTime < (hold + 0.25) do
            if not prompt or not prompt.Parent or not prompt.Enabled then break end
            task.wait(0.1)
        end
        pcall(function() prompt:InputHoldEnd() end)
        if typeof(fireproximityprompt) == "function" and prompt and prompt.Parent and prompt.Enabled then
            pcall(function() fireproximityprompt(prompt) end)
        end
    elseif click then
        pcall(function()
            if typeof(fireclickdetector) == "function" then
                fireclickdetector(click)
            else
                click:MouseClick()
            end
        end)
    end

    task.wait(0.6)
    return true
end

local _lastEquipTime = 0
local function ensureRodEquipped(force)
    local lp = Players.LocalPlayer
    local char = lp and lp.Character
    if not char then return false end

    local held = char:FindFirstChildOfClass("Tool")
    if held then return true end

    local now = os.clock()
    if not force and (now - _lastEquipTime < 1.2) then
        return false
    end
    _lastEquipTime = now

    -- 1. Check Backpack
    local bp = lp:FindFirstChild("Backpack")
    if bp then
        local tool = bp:FindFirstChildOfClass("Tool")
        if tool and char:FindFirstChild("Humanoid") then
            pcall(function() char.Humanoid:EquipTool(tool) end)
            task.wait(0.05)
            if char:FindFirstChildOfClass("Tool") then return true end
        end
    end

    -- 2. Call Hotbar equip remote
    local eq = Events.equip or Events.equipToolRemote or Events.equip_tool_remote or (Config.UB and Config.UB.Remotes and Config.UB.Remotes.equip) or GetServerRemote("RF/EquipToolFromHotbar")
    if eq then
        pcall(function() CallRemote(eq, 1) end)
        task.wait(0.05)
        if char:FindFirstChildOfClass("Tool") then return true end
    end

    -- 3. If still not holding, equip best rod from Replion Inventory
    pcall(function()
        local replion = GetPlayerDataReplion and GetPlayerDataReplion()
        if replion then
            local ok, inv = pcall(function() return replion:GetExpect("Inventory") end)
            if ok and inv and inv["Fishing Rods"] and #inv["Fishing Rods"] > 0 then
                local priority = {257, 169, 126, 5, 7, 6, 80, 4, 78, 77, 85, 76, 79, 1}
                local bestRod = nil
                for _, id in ipairs(priority) do
                    for _, r in ipairs(inv["Fishing Rods"]) do
                        if tonumber(r.Id) == id then bestRod = r; break end
                    end
                    if bestRod then break end
                end
                if not bestRod then bestRod = inv["Fishing Rods"][1] end

                local equipItem = Events.equipItemRemote or Events.equip_item or GetServerRemote("RF/EquipItem")
                if bestRod and bestRod.UUID and equipItem then
                    CallRemote(equipItem, bestRod.UUID, "Fishing Rods")
                    task.wait(0.08)
                    if eq then CallRemote(eq, 1) end
                end
            end
        end
    end)

    return char:FindFirstChildOfClass("Tool") ~= nil
end

local function equipRod()
    ensureRodEquipped(true)
    if Config.autoFishing or Config.AutoCatch or Config.PerfectionEnchant then
        pcall(function()
            local r = Events.UpdateAutoFishing or Events.update_auto_fishing or (Config.UB and Config.UB.Remotes and Config.UB.Remotes.UpdateAutoFishing) or GetServerRemote("RF/UpdateAutoFishingState")
            if r then CallRemote(r, true) end
        end)
    end
end

pcall(function()
    LocalPlayer.CharacterAdded:Connect(function(newChar)
        task.wait(0.5)
        local isAnyFishingActive = Config.AutoCatch or (Config.UB and Config.UB.Active) or (Config.CloudyV1 and Config.CloudyV1.Active) or (Config.Cloudy1N and Config.Cloudy1N.Active) or (Config.InstantFishing and Config.InstantFishing.Active) or (Config.InstantV2 and Config.InstantV2.Active) or (_G.Kaitun and _G.Kaitun.Active)
        if isAnyFishingActive then
            equipRod()
        end
    end)
end)

local function safeFire(func)
    task.spawn(function()
        local ok, err = pcall(func)
        if not ok then warn("[QH] safeFire error: " .. tostring(err)) end
    end)
end

local function FireLocalEvent(remote, ...)
    if not remote then return end
    local args = {...}
    pcall(function()
        local signal = remote.OnClientEvent
        if not signal then return end
        local conns = {}
        pcall(function() conns = getconnections(signal) end)
        for _, connection in ipairs(conns) do
            if connection and connection.Function then
                task.spawn(function() pcall(function() connection.Function(unpack(args)) end) end)
            end
        end
    end)
end

local function deepCopyArr(t)
    local out = {}
    for i, v in ipairs(t) do
        if type(v) == "table" then local c = {}; for k, val in pairs(v) do c[k] = val end; out[i] = c
        else out[i] = v end
    end
    return out
end
local function SafeUpdateParagraph(paragraphObj, newText)
    if not paragraphObj then return false end
    local success = pcall(function()
        if paragraphObj.SetDesc and typeof(paragraphObj.SetDesc) == "function" then
            paragraphObj:SetDesc(newText)
        elseif paragraphObj.SetContent and typeof(paragraphObj.SetContent) == "function" then
            paragraphObj:SetContent(newText)
        elseif paragraphObj.SetText and typeof(paragraphObj.SetText) == "function" then
            paragraphObj:SetText(newText)
        elseif paragraphObj.Update and typeof(paragraphObj.Update) == "function" then
            paragraphObj:Update(newText)
        elseif paragraphObj.Content ~= nil then
            paragraphObj.Content = newText
        elseif paragraphObj.Desc ~= nil then
            paragraphObj.Desc = newText
        elseif paragraphObj.Text ~= nil then
            paragraphObj.Text = newText
        end
    end)
    return success
end

local function IsLocalPlayerCatch(arg1)
    if arg1 == nil then return true end
    if arg1 == LocalPlayer or arg1 == LocalPlayer.UserId or arg1 == LocalPlayer.Name or arg1 == LocalPlayer.DisplayName then return true end
    if type(arg1) == "string" then
        if arg1 == LocalPlayer.Name or arg1 == LocalPlayer.DisplayName or arg1 == tostring(LocalPlayer.UserId) then
            return true
        end
        local otherPlayer = Players:FindFirstChild(arg1)
        if otherPlayer and otherPlayer ~= LocalPlayer then
            return false
        end
        return true
    end
    if type(arg1) == "number" then
        if arg1 == LocalPlayer.UserId then return true end
        local otherPlayer = Players:GetPlayerByUserId(arg1)
        if otherPlayer and otherPlayer ~= LocalPlayer then
            return false
        end
        return true
    end
    return true
end

local function HookRemote(humanName, storageKey)
    if _hookedRemotes[humanName] then return true end
    local remote = GetServerRemote(humanName)
    if remote then
        _hookedRemotes[humanName] = true
        pcall(function()
            remote.OnClientEvent:Connect(function(...)
                _G.SavedData[storageKey] = {...}
                local args = {...}
                if storageKey == "FishCaught" then
                    lastValidFishCaught = deepCopyArr(args)
                    if IsLocalPlayerCatch(args[1]) then
                        saveCount = saveCount + 1
                        _sessionCatchCount = _sessionCatchCount + 1
                        table.insert(_lastCatchTimestamps, tick())
                        if #_lastCatchTimestamps > 60 then table.remove(_lastCatchTimestamps, 1) end
                    end
                elseif storageKey == "CaughtVisual" then
                    lastValidCaughtVisual = deepCopyArr(args)
                elseif storageKey == "FishNotif" then
                    lastValidFishNotif = deepCopyArr(args)
                    _lastRealFishNotifTime = tick()
                    isCaught = true
                    lastTimeFishCaught = os.clock()
                    table.insert(_fishNotifHistory, deepCopyArr(args))
                    if #_fishNotifHistory > _maxFishHistory then table.remove(_fishNotifHistory, 1) end
                end
            end)
        end)
        return true
    end
    return false
end

task.spawn(function()
    task.wait(1)
    pcall(function()
        if PlayerData then
            local invData
            pcall(function() invData = PlayerData:GetExpect("Inventory") end)
            if invData and invData.Items then
                for _, item in ipairs(invData.Items) do
                    local key = tostring(item.UUID or item.Id or "")
                    _prevInventoryUUIDs[key] = true
                end
            end
        end
    end)
    pcall(function()
        HookRemote("RE/FishCaught", "FishCaught")
        HookRemote("RE/CaughtFishVisual", "CaughtVisual")
    end)
    task.wait(0.5)
    pcall(SetupFishCaughtNotifListener)
end)

local function CalculateCPM()
    local now = tick()
    local recentCatches = 0
    for _, timestamp in ipairs(_lastCatchTimestamps) do
        if now - timestamp < 60 then recentCatches = recentCatches + 1 end
    end
    return recentCatches
end

local InstantBobberState = {
    instantOverrideActive = false, instantOverrideSetupDone = false,
    activeBaitsByUserId = nil, cosmeticFolder = nil,
    baitCastConn = nil, baitDestroyedConn = nil, renderConn = nil,
}

local function patchInstantBaitOverrideToCastPosition(enabled)
    if not enabled then
        InstantBobberState.instantOverrideActive = false
        if InstantBobberState.activeBaitsByUserId then table.clear(InstantBobberState.activeBaitsByUserId) end
        return
    end
    InstantBobberState.instantOverrideActive = true
    InstantBobberState.activeBaitsByUserId = InstantBobberState.activeBaitsByUserId or {}
    table.clear(InstantBobberState.activeBaitsByUserId)
    if InstantBobberState.instantOverrideSetupDone then return end
    InstantBobberState.instantOverrideSetupDone = true
    local okCosmetic, cosmeticFolder = pcall(function() return workspace:WaitForChild("CosmeticFolder", 5) end)
    if not okCosmetic or not cosmeticFolder then InstantBobberState.instantOverrideSetupDone = false; InstantBobberState.instantOverrideActive = false; return end
    InstantBobberState.cosmeticFolder = cosmeticFolder
    local baitCastVisual = GetServerRemote("RE/BaitCastVisual") or GetServerRemote("BaitCastVisual")
    local baitDestroyed = GetServerRemote("RE/BaitDestroyed") or GetServerRemote("BaitDestroyed")
    if not baitCastVisual or not baitCastVisual:IsA("RemoteEvent") then InstantBobberState.instantOverrideSetupDone = false; InstantBobberState.instantOverrideActive = false; return end
    if not baitDestroyed or not baitDestroyed:IsA("RemoteEvent") then InstantBobberState.instantOverrideSetupDone = false; InstantBobberState.instantOverrideActive = false; return end
    local function safeConnect(signal, callback)
        if not signal then return nil end
        local ok, conn = pcall(function() return signal:Connect(callback) end)
        if not ok then return nil end
        return conn
    end
    InstantBobberState.baitCastConn = safeConnect(baitCastVisual.OnClientEvent, function(player, data)
        if not InstantBobberState.instantOverrideActive then return end
        if not player or not player.UserId then return end
        if not data or not data.CastPosition or typeof(data.CastPosition) ~= "Vector3" then return end
        InstantBobberState.activeBaitsByUserId[player.UserId] = {pivot = CFrame.new(data.CastPosition), expiresAt = tick() + 0.8}
    end)
    InstantBobberState.baitDestroyedConn = safeConnect(baitDestroyed.OnClientEvent, function(player)
        if not InstantBobberState.instantOverrideActive then return end
        if not player or not player.UserId then return end
        InstantBobberState.activeBaitsByUserId[player.UserId] = nil
    end)
    InstantBobberState.renderConn = RunService.RenderStepped:Connect(function()
        if not InstantBobberState.instantOverrideActive then return end
        local now = tick()
        local cf = InstantBobberState.cosmeticFolder
        if not cf then return end
        for userId, entry in pairs(InstantBobberState.activeBaitsByUserId) do
            if now > entry.expiresAt then InstantBobberState.activeBaitsByUserId[userId] = nil
            else
                local model = cf:FindFirstChild(tostring(userId))
                if model and model.PivotTo then
                    model:PivotTo(entry.pivot)
                    if model:IsA("Model") and model.PrimaryPart then model.PrimaryPart.AssemblyLinearVelocity = Vector3.new(0, -75, 0)
                    elseif model:IsA("BasePart") then model.AssemblyLinearVelocity = Vector3.new(0, -75, 0) end
                end
            end
        end
    end)
end

local SkinAnimation = (function()
    local player = game:GetService("Players").LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    local humanoid = char:WaitForChild("Humanoid", 5)
    if not humanoid then return {SwitchSkin=function() return false end, Enable=function() return false end, Disable=function() return true end} end
    local Animator = humanoid:FindFirstChildOfClass("Animator") or Instance.new("Animator", humanoid)
    local SkinDatabase = {
        ["Eclipse"]="rbxassetid://107940819382815", ["HolyTrident"]="rbxassetid://128167068291703",
        ["SoulScythe"]="rbxassetid://82259219343456", ["OceanicHarpoon"]="rbxassetid://76325124055693",
        ["BinaryEdge"]="rbxassetid://109653945741202", ["Vanquisher"]="rbxassetid://93884986836266",
        ["KrampusScythe"]="rbxassetid://134934781977605", ["BanHammer"]="rbxassetid://96285280763544",
        ["CorruptionEdge"]="rbxassetid://126613975718573", ["PrincessParasol"]="rbxassetid://99143072029495"
    }
    local CurrentSkin, AnimationPool, IsEnabled = nil, {}, false
    local function LoadAnimationPool(skinId)
        local animId = SkinDatabase[skinId]
        if not animId then return false end
        for _, track in ipairs(AnimationPool) do pcall(function() track:Destroy() end) end
        AnimationPool = {}
        local anim = Instance.new("Animation"); anim.AnimationId = animId
        for i = 1, 4 do
            local track = Animator:LoadAnimation(anim)
            if track then track.Priority = Enum.AnimationPriority.Action4; track.Name = "SKIN_POOL_" .. i; table.insert(AnimationPool, track) end
        end
        return #AnimationPool > 0
    end
    local function IsFishCaughtAnimation(track)
        local name = string.lower(track.Name or "")
        return name:find("fishcaught") or name:find("caught")
    end
    local function InstantReplace(originalTrack)
        local nextTrack = AnimationPool[math.random(1, #AnimationPool)]
        if nextTrack then pcall(function() originalTrack:Stop(0); nextTrack:Play(0, 1, 1) end) end
    end

    pcall(function()
    humanoid.AnimationPlayed:Connect(function(track)
        local animName = string.lower(track.Name or "")
        if animName:find("fishcaught") or animName:find("caught") or animName:find("reel") then
            if IsEnabled and IsFishCaughtAnimation(track) then InstantReplace(track) end
        end   -- <-- this was missing
    end)
end)

    local API = {}
    function API.SwitchSkin(id) CurrentSkin = id; return IsEnabled and LoadAnimationPool(id) or true end
    function API.Enable() if not CurrentSkin then return false end; IsEnabled = LoadAnimationPool(CurrentSkin); return IsEnabled end
    function API.Disable() IsEnabled = false; return true end
    return API
end)()

local LOCATIONS = {
    ["Elemental Volcano"]=CFrame.new(-729.789978, 107.056473, 5347.83008, -0.639170587, 9.75507248e-08, 0.769065022, 8.95694043e-08, 1, -5.24020685e-08, -0.769065022, 3.53908334e-08, -0.639170587),
    ["Elemental Storm"]=CFrame.new(-936.080017, 54.3766861, 5238.54004, -0.82114917, 7.46646656e-09, -0.57071358, 4.19588417e-08, 1, -4.7288168e-08, 0.57071358, -6.27771186e-08, -0.82114917),
    ["Elemental Blizzard"]=CFrame.new(-981.890015, 45.8336372, 5302.85986, -0.855183363, 5.27788089e-08, 0.518325567, 3.18231095e-08, 1, -4.93207679e-08, -0.518325567, -2.5683569e-08, -0.855183363),
    ["Fisherman"]=CFrame.new(-64.5500031, 3.26205373, 2851.48999, 0.0899373069, -2.41764408e-09, 0.995947421, -4.68269228e-08, 1, 6.65610589e-09, -0.995947421, -4.72357868e-08, 0.0899373069),
    ["Sisyphus Statue"]=CFrame.new(-3751.08008, -135.073944, -1006.51001, -0.893841445, -2.6164253e-09, -0.448383212, -3.06272674e-09, 1, 2.70230366e-10, 0.448383212, 1.61481828e-09, -0.893841445),
    ["Coral Reefs"]=Vector3.new(-3299.224853515625,123.38948059082031,2223.6123046875),
    ["Esoteric Depths"]=Vector3.new(3271.66064453125,-1301.5306396484375,1381.4456787109375),
    ["Crater Island 1"]=Vector3.new(1060.8260498046875,2.5815768241882324,5131.58740234375),
    ["Crater Island 2"]=Vector3.new(1040.036,55.714,5131.443),
    ["Lost Isle"]=Vector3.new(-3618.157,240.837,-1317.458),
    ["Weather Machine"]=Vector3.new(-1488.512,83.173,1876.303),
    ["Tropical Grove"]=Vector3.new(-2152.160888671875,53.48600769042969,3619.32861328125),
    ["Treasure Room"]=Vector3.new(-3648.86328125,-268.6123352050781,-1662.415283203125),
    ["Kohana 1"]=CFrame.new(-603.369995, 3.09488416, 557.099976, 0.267742842, -7.86244527e-08, 0.963490427, -2.35978455e-08, 1, 8.8161336e-08, -0.963490427, -4.63408654e-08, 0.267742842),
    ["Kohana 2"]=CFrame.new(-835.256653, 18.6894932, 401.163788, -0.879029095, 4.39071286e-08, 0.476768106, 5.09194464e-08, 1, 1.78817849e-09, -0.476768106, 2.58486281e-08, -0.879029095),
    ["Kohana Volcano"]=Vector3.new(-424.0745544433594,7.2453107833862305,124.14938354492188),
    ["Underground Cellar"]=Vector3.new(2139.544677734375,-91.19776916503906,-766.829833984375),
    ["Ancient Jungle"]=Vector3.new(1484.5361328125,11.14309024810791,-300.48779296875),
    ["Sacred Temple"]=Vector3.new(1421.6331787109375,4.8749680519104,-659.717041015625),
    ["Ancient Ruins"]=Vector3.new(6096.15966796875,-585.9248046875,4664.01611328125),
    ["Pirate Cove"]=Vector3.new(3399.018798828125,4.191970348358154,3475.293701171875),
    ["Pirate Treasure Room"]=Vector3.new(3324.074,-306.476,3087.999),
    ["Crystal Depth"]=Vector3.new(5504.767578125,-904.9680786132812,15290.484375),
    ["Lava Basin"]=Vector3.new(950.876,85.282,-10199.427),
    ["Planetary Observatory"]=Vector3.new(460.5227966308594,24.145477294921875,2204.85546875),
    ["Underwater City"]=Vector3.new(-3100.5361328125,-644.4927978515625,-10585.369140625),
    ["sewer"]=Vector3.new(-1387.8677978515625,-1041.593994140625,-10436.0390625),
    ["Copper Canyon"]=CFrame.new(-4147.4873046875, 6.7726263999938965, 614.3461303710938, 0.3586901128292084, 0.030515363439917564, 0.9329577684402466, -1.9739960777087617e-09, 0.9994655251502991, -0.032690711319446564, -0.9334567189216614, 0.011725833639502525, 0.3584984242916107),
    ["Copper Canyon Cave"]=CFrame.new(-4074.307, -546.936, 525.506, -0.156717, 0, -0.987644, 0, 1, 0, 0.987644, 0, -0.156717),
    ["Enchanting Altar"]=CFrame.new(3244.42138671875, -1301.1806640625, 1395.0330810546875, -0.4685245156288147, -3.482493937667641e-08, 0.8834505081176758, -5.064358532536062e-08, 1, 1.2561176987446743e-08, -0.8834505081176758, -3.885588384378025e-08, -0.4685245156288147),
    ["Stingray Shores"]=CFrame.new(-2139.04541015625, 16.6846866607666, -908.5401000976562, -0.992554247379303, 5.33271737879204e-09, -0.12180322408676147, -7.216977238044819e-09, 1, 1.0259136473678154e-07, 0.12180322408676147, 1.0270655081967561e-07, -0.992554247379303),
    ["Mariana Trench"]=CFrame.new(-9273.7177734375, -245.5157470703125, -2.428925037384033, 0.9994439482688904, 1.0629108704307555e-09, 0.03334302082657814, -1.8924104505657624e-09, 1, 2.4846197987926644e-08, -0.03334302082657814, -2.4895481232078964e-08, 0.9994439482688904),
    ["Deeper Mariana Trench"]=CFrame.new(-9124.98046875, -269.54022216796875, 813.3509521484375, 0.9547055959701538, -1.5112282980567215e-08, -0.29755207896232605, 2.008871291536707e-08, 1, 1.3666594966821322e-08, 0.29755207896232605, -1.9025012676365805e-08, 0.9547055959701538),
    ["Black Market"]=CFrame.new(-9029.9609375, -269.54022216796875, 786.406494140625, 0.46099039912223816, 1.19627179273607e-08, -0.8874050974845886, -1.4245764567988317e-08, 1, 6.080151049303595e-09, 0.8874050974845886, 9.838872827572231e-09, 0.46099039912223816),
    ["Starfall Garden"]=CFrame.new(-22193.46875, -251.7716064453125, -7988.5947265625, -0.9948872923851013, -3.658737668388312e-08, 0.10099118947982788, -3.739847542760799e-08, 1, -6.138063390892512e-09, -0.10099118947982788, -9.883597940074651e-09, -0.9948872923851013),
    ["Gloomcap Grotto"]=CFrame.new(5921.02832, -864.522766, 12339.3037, -0.981406987, 7.42360342e-08, 0.19193837, 6.78514027e-08, 1, -3.98367028e-08, -0.19193837, -2.60727315e-08, -0.981406987),
    ["Elemental Island (Storm Area)"]=CFrame.new(-853.494629, 93.8661575, 5541.74609, 0.68788904, -3.32617915e-08, 0.725815892, 2.66287898e-08, 1, 2.05894359e-08, -0.725815892, 5.1643525e-09, 0.68788904),
    ["Elemental Island (Volcano Area)"]=CFrame.new(-619.441223, 107.02948, 5522.54736, -0.351876795, 4.22376578e-09, 0.936046302, 3.75576299e-08, 1, 9.60624735e-09, -0.936046302, 3.85358945e-08, -0.351876795),
    ["Elemental Island (Blizzard Area)"]=CFrame.new(-1082.68604, 124.093239, 5538.86182, -0.394805819, 5.95509704e-08, -0.918764591, -6.92057398e-08, 1, 9.45550127e-08, 0.918764591, 1.00914647e-07, -0.394805819),
}

local function NormalizeTargetCFrame(targetCFrame)
    if typeof(targetCFrame) == "CFrame" then
        return targetCFrame
    end

    if typeof(targetCFrame) == "Vector3" then
        return CFrame.new(targetCFrame)
    end

    local ok, result = pcall(function()
        return CFrame.new(targetCFrame)
    end)

    if ok and typeof(result) == "CFrame" then
        return result
    end

    return nil
end

local function SafeSetCharacterCFrame(char, hrp, targetCF)
    if hrp then
        local ok = pcall(function()
            hrp.CFrame = targetCF
        end)
        if ok then
            return true
        end
    end

    if char and char.PivotTo then
        local ok = pcall(function()
            char:PivotTo(targetCF)
        end)
        if ok then
            return true
        end
    end

    return false
end

local function RestoreCharacterCollision(char)
    if not char then
        char = LocalPlayer.Character
    end
    if not char then return end

    local humanoid = char:FindFirstChildOfClass("Humanoid")
    local isR15 = humanoid and (humanoid.RigType == Enum.HumanoidRigType.R15 or char:FindFirstChild("UpperTorso") ~= nil)

    for _, part in ipairs(char:GetDescendants()) do
        if part:IsA("BasePart") then
            pcall(function()
                if part.Name == "HumanoidRootPart" then
                    part.CanCollide = false
                elseif part.Parent and part.Parent:IsA("Accessory") then
                    part.CanCollide = false
                elseif isR15 then
                    if part.Name == "UpperTorso" or part.Name == "LowerTorso" or part.Name == "Head" then
                        part.CanCollide = true
                    else
                        part.CanCollide = false
                    end
                else
                    if part.Name == "Torso" or part.Name == "Head" then
                        part.CanCollide = true
                    else
                        part.CanCollide = false
                    end
                end
            end)
        end
    end

    if humanoid then
        pcall(function()
            humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, true)
            humanoid:SetStateEnabled(Enum.HumanoidStateType.Running, true)
            humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
        end)
    end
end

local function TeleportTo(targetCFrame, speed, options)
    local char = LocalPlayer.Character
    if not char then return false end
    local hrp = char:FindFirstChild("HumanoidRootPart") or char.PrimaryPart
    if not hrp then return false end
    local targetCF = NormalizeTargetCFrame(targetCFrame)
    if not targetCF then return false end

    pcall(function()
        hrp.AssemblyLinearVelocity = Vector3.zero
        hrp.AssemblyAngularVelocity = Vector3.zero
    end)

    local ok = pcall(function()
        hrp.CFrame = targetCF
        char:PivotTo(targetCF)
    end)

    pcall(function()
        hrp.AssemblyLinearVelocity = Vector3.zero
        hrp.AssemblyAngularVelocity = Vector3.zero
    end)

    return ok
end

local function SmoothFlyTo(targetCFrame, duration, easingStyle)
    return TeleportTo(targetCFrame)
end

local function FlyTo(targetCFrame, speed, options)
    return TeleportTo(targetCFrame)
end

local function FlySlowlyTo(targetCFrame, speed, options)
    return TeleportTo(targetCFrame)
end

local function teleportTo(locationName)
    local pos = LOCATIONS[locationName]
    local hrp = getHRP()
    if not hrp or not pos then return end

    local targetCFrame
    if typeof(pos) == "CFrame" then
        targetCFrame = pos
    else
        targetCFrame = CFrame.new(pos + Vector3.new(0, 3, 0))
    end

    local success = TeleportTo(targetCFrame)
    if success then
        task.wait(0.2)
        NotifySuccess("Teleport", "Teleported to " .. locationName .. "!")
    else
        NotifyError("Teleport", "Failed to teleport to " .. locationName)
    end
end

local function UB_init()
    Config.UB.Remotes.ChargeFishingRod = GetServerRemote("RF/ChargeFishingRod")
    Config.UB.Remotes.RequestMinigame = GetServerRemote("RF/RequestFishingMinigameStarted")
    Config.UB.Remotes.CancelFishingInputs = GetServerRemote("RF/CancelFishingInputs")
    Config.UB.Remotes.UpdateAutoFishing = GetServerRemote("RF/UpdateAutoFishingState")
    Config.UB.Remotes.FishingCompleted = GetServerRemote("RF/CatchFishCompleted")
    Config.UB.Remotes.FishingCompletedRE = GetServerRemote("RE/CatchFishCompleted")
    Config.UB.Remotes.equip = GetServerRemote("RF/EquipToolFromHotbar")
    return true
end

local NOTIF_DELAY_DURATION = 18
local NOTIF_DELAY_DURATION_V1 = 6.2
local _currentNotifDelayDuration = 18
local _notifDelayActive = false
local _notifHooksApplied = false

local function setupNotifDelayHooks()
    if _notifHooksApplied then return end
    _notifHooksApplied = true
    pcall(function()
        local ctrlFolder = ReplicatedStorage:FindFirstChild("Controllers")
        if not ctrlFolder then return end
        local TextNotifCtrl = require(ctrlFolder:WaitForChild("TextNotificationController", 5))
        if TextNotifCtrl and TextNotifCtrl.DeliverNotification then
            local oldDeliver = TextNotifCtrl.DeliverNotification
            TextNotifCtrl.DeliverNotification = function(self, data, ...)
                if _G.QH_EnableFishNotif == false and data and type(data) == "table" and (data.Type == "Item" or data.Type == "Fish") then
                    return
                end
                if _notifDelayActive and data and type(data) == "table" then
                    data.Duration = _currentNotifDelayDuration
                    data.CustomDuration = _currentNotifDelayDuration
                end
                return oldDeliver(self, data, ...)
            end
        end
    end)
end

local function enableNotifDelay() if not _notifHooksApplied then setupNotifDelayHooks() end; _notifDelayActive = true end
local function disableNotifDelay() _notifDelayActive = false end

_G._QHBetaBlockNotif = false
local function enableBlockNotif() _G._QHBetaBlockNotif = false end
local function disableBlockNotif() _G._QHBetaBlockNotif = false end

local function updateReplionInventory(notifData)
    pcall(function()
        if PlayerData and notifData and #notifData > 0 then
            local data = PlayerData:GetValue()
            if data and data.Inventory then
                if not data.Inventory[notifData[1]] then
                    data.Inventory[notifData[1]] = 0
                end
                data.Inventory[notifData[1]] = data.Inventory[notifData[1]] + 1
            end
        end
    end)
end

local function triggerRainbowGoldenUpdate(notifData)
    if not notifData or #notifData == 0 then return end

    local isRainbow = false
    local isGolden = false
    local fishName = ""

    for idx = 1, math.min(5, #notifData) do
        local val = tostring(notifData[idx]):lower()
        if val:find("palette") then isRainbow = true end
        if val:find("golden") or val:find("gold") then isGolden = true end

        if idx <= 3 then fishName = val end
    end

    local replionSetEvent = nil
    pcall(function()
        local replionFolder = ReplicatedStorage:FindFirstChild("Packages")
        if replionFolder then
            local idx = replionFolder:FindFirstChild("_Index")
            if idx then
                for _, child in ipairs(idx:GetChildren()) do
                    if child.Name:find("ytrev_replion") then
                        local replionMod = child:FindFirstChild("replion")
                        if replionMod then
                            local remotes = replionMod:FindFirstChild("Remotes")
                            if remotes then
                                replionSetEvent = remotes:FindFirstChild("Set")
                                break
                            end
                        end
                    end
                end
            end
        end
    end)

    if isRainbow and replionSetEvent and LocalPlayer then
        pcall(function()
            FireLocalEvent(replionSetEvent, LocalPlayer, {"Modifiers", "Rainbow"})
        end)
    end

    if isGolden and replionSetEvent and LocalPlayer then
        pcall(function()
            FireLocalEvent(replionSetEvent, LocalPlayer, {"Modifiers", "Golden"})
        end)
    end

    if replionSetEvent and LocalPlayer then
        pcall(function()
            FireLocalEvent(replionSetEvent, LocalPlayer, {"InventoryNotifications", "Fish"})
        end)
    end
end

local function replayAmblatantNotif()
    if _G.QH_EnableFishNotif == false then return end
    local isCloudySpecial = (Config.amblatant == true) or (Config.Cloudy1N and Config.Cloudy1N.Active == true)
    if not isCloudySpecial then return end

    task.spawn(function()
        if _G.QH_EnableFishNotif == false then return end
        if not ((Config.amblatant == true) or (Config.Cloudy1N and Config.Cloudy1N.Active == true)) then return end

        local xr_visual = GetServerRemote("RE/CaughtFishVisual")

        if #lastValidFishCaught == 0 and #(_G.SavedData.FishCaught or {}) > 0 then
            lastValidFishCaught = deepCopyArr(_G.SavedData.FishCaught)
        end
        if #lastValidCaughtVisual == 0 and #(_G.SavedData.CaughtVisual or {}) > 0 then
            lastValidCaughtVisual = deepCopyArr(_G.SavedData.CaughtVisual)
        end
        if #lastValidFishNotif == 0 and #(_G.SavedData.FishNotif or {}) > 0 then
            lastValidFishNotif = deepCopyArr(_G.SavedData.FishNotif)
        end

        local notifData = #lastValidFishNotif > 0 and lastValidFishNotif or nil
        if not notifData and #lastValidFishCaught > 0 then
            notifData = ExtractFishNotifArgs(lastValidFishCaught)
        end

        if notifData then
            pcall(function() triggerRainbowGoldenUpdate(notifData) end)
            local repeatCount = math.max(1, Config.YTTA.NotifCount or 3)
            for i = 1, repeatCount do
                if not ((Config.amblatant == true) or (Config.Cloudy1N and Config.Cloudy1N.Active == true)) then break end
                local nd = notifData
                if #_fishNotifHistory > 0 then
                    nd = _fishNotifHistory[((i - 1) % #_fishNotifHistory) + 1]
                end

                PlayCatchAnimationMotion()

                if xr_visual and #lastValidCaughtVisual > 0 then
                    pcall(function() FireLocalEvent(xr_visual, unpack(lastValidCaughtVisual)) end)
                end

                TriggerFishNotif(nd, true)
                updateReplionInventory(nd)
                if i < repeatCount and (Config.YTTA.NotifDelay or 0.1) > 0 then
                    task.wait(Config.YTTA.NotifDelay or 0.1)
                end
            end
        end
    end)
end

local function CompleteFishing(quality)
    local q = quality or Config.CatchQuality or "Perfect"
    if Config.UB.Remotes.FishingCompletedRE and Config.UB.Remotes.FishingCompletedRE.Parent then
        pcall(function() Config.UB.Remotes.FishingCompletedRE:FireServer(q) end)
    elseif Config.UB.Remotes.FishingCompleted and Config.UB.Remotes.FishingCompleted.Parent then
        pcall(function() Config.UB.Remotes.FishingCompleted:InvokeServer(q) end)
    end
end

local function legit_fishing_loop()
    UB_init()
    local charge = (Config.UB and Config.UB.Remotes and Config.UB.Remotes.ChargeFishingRod) or GetServerRemote("RF/ChargeFishingRod")
    local reqMinigame = (Config.UB and Config.UB.Remotes and Config.UB.Remotes.RequestMinigame) or GetServerRemote("RF/RequestFishingMinigameStarted")
    local completedRE = (Config.UB and Config.UB.Remotes and Config.UB.Remotes.FishingCompletedRE) or GetServerRemote("RE/CatchFishCompleted")
    local completedRF = (Config.UB and Config.UB.Remotes and Config.UB.Remotes.FishingCompleted) or GetServerRemote("RF/CatchFishCompleted")

    while Config.AutoCatch do
        local ok, err = pcall(function()
            ensureRodEquipped()
            local currentTime = tick()
            if charge and charge.Parent then
                pcall(function() charge:InvokeServer({[1] = currentTime}) end)
            end
            local qualityParam = 1
            if reqMinigame and reqMinigame.Parent then
                pcall(function() reqMinigame:InvokeServer(1, qualityParam, currentTime) end)
            end

            local catchDelay = math.clamp(Config.CatchDelay or 0.7, 0.05, 10)
            task.wait(catchDelay)

            if not Config.AutoCatch then return end

            local q = Config.CatchQuality or "Perfect"
            if completedRE and completedRE.Parent then
                pcall(completedRE.FireServer, completedRE, q)
            elseif completedRF and completedRF.Parent then
                pcall(completedRF.InvokeServer, completedRF, q)
            end

            task.wait(0.35)
        end)
        if not ok then task.wait(0.1) end
    end
end

local function onToggleLegitFishing(val)
    Config.AutoCatch = val
    Config.autoFishing = val
    if val then
        equipRod()
        task.wait(0.1)
        pcall(function()
            local r = Events.UpdateAutoFishing or Events.update_auto_fishing or (Config.UB and Config.UB.Remotes and Config.UB.Remotes.UpdateAutoFishing) or GetServerRemote("RF/UpdateAutoFishingState")
            if r then
                if r:IsA("RemoteFunction") then
                    task.spawn(function() pcall(r.InvokeServer, r, true) end)
                elseif r:IsA("RemoteEvent") then
                    r:FireServer({ Active = true })
                end
            end
        end)
        pcall(function()
            local m = GetServerRemote("RF/MarkAutoFishingUsed") or GetServerRemote("RE/MarkAutoFishingUsed")
            if m then
                if m:IsA("RemoteFunction") then
                    task.spawn(function() pcall(m.InvokeServer, m) end)
                elseif m:IsA("RemoteEvent") then
                    m:FireServer()
                end
            end
        end)
        pcall(function()
            if Controllers.Fishing then
                if Controllers.Fishing.ToggleAutoFishing then
                    Controllers.Fishing:ToggleAutoFishing(true)
                elseif Controllers.Fishing.StartAutoFishing then
                    Controllers.Fishing:StartAutoFishing()
                elseif Controllers.Fishing.SetAutoFishing then
                    Controllers.Fishing:SetAutoFishing(true)
                end
            end
        end)
        if Tasks.legitFishingTask then
            pcall(task.cancel, Tasks.legitFishingTask)
            Tasks.legitFishingTask = nil
        end
        Tasks.legitFishingTask = task.spawn(legit_fishing_loop)
        NotifySuccess("Legit Fishing", "Auto Fishing diaktifkan! Catch Delay: " .. tostring(Config.CatchDelay or 0.7) .. "s")
    else
        Config.AutoCatch = false
        Config.autoFishing = false
        if Tasks.legitFishingTask then
            pcall(task.cancel, Tasks.legitFishingTask)
            Tasks.legitFishingTask = nil
        end
        pcall(function()
            local r = Events.UpdateAutoFishing or Events.update_auto_fishing or (Config.UB and Config.UB.Remotes and Config.UB.Remotes.UpdateAutoFishing) or GetServerRemote("RF/UpdateAutoFishingState")
            if r then
                if r:IsA("RemoteFunction") then
                    task.spawn(function() pcall(r.InvokeServer, r, false) end)
                elseif r:IsA("RemoteEvent") then
                    r:FireServer({ Active = false })
                end
            end
        end)
        pcall(function()
            if Controllers.Fishing then
                if Controllers.Fishing.ToggleAutoFishing then
                    Controllers.Fishing:ToggleAutoFishing(false)
                elseif Controllers.Fishing.StopAutoFishing then
                    Controllers.Fishing:StopAutoFishing()
                elseif Controllers.Fishing.SetAutoFishing then
                    Controllers.Fishing:SetAutoFishing(false)
                end
            end
        end)
        safeFire(function()
            local cancel = Events.cancel_fishing_input or (Config.UB and Config.UB.Remotes and Config.UB.Remotes.CancelFishingInputs) or GetServerRemote("RF/CancelFishingInputs")
            if cancel then CallRemote(cancel) end
        end)
        NotifyWarning("Legit Fishing", "Auto Fishing dimatikan.")
    end
end

local function ub_loop()
    while Config.UB.Active do
        local ok, err = pcall(function()
            ensureRodEquipped()
            local currentTime = tick()
            task.wait(GetCastingWait(Config.UB.Settings.CastDelay))
            needCast = false
            pcall(function() if Config.UB.Remotes.ChargeFishingRod and Config.UB.Remotes.ChargeFishingRod.Parent then Config.UB.Remotes.ChargeFishingRod:InvokeServer({[1] = currentTime}) end end)
            local qualityParam = GetCastingQualityParam(Config.UB.UseCastMode, Config.UB.CastMode)
            pcall(function() if Config.UB.Remotes.RequestMinigame and Config.UB.Remotes.RequestMinigame.Parent then Config.UB.Remotes.RequestMinigame:InvokeServer(1, qualityParam, currentTime) end end)
            local hookDelay = Config.amblatant and Config.YTTA.Settings.QHDelay or (Config.UB.Settings.HookDelay or 0.3)
            task.wait(math.max(hookDelay, 0.001))
            Config.CatchQuality = GetCatchQuality(Config.UB.CastMode or Config.CastMode)
            CompleteFishing(Config.CatchQuality)
            if Config.amblatant then
                replayAmblatantNotif()
            end
            blatantFishCycleCount = blatantFishCycleCount + 1
        end)
        if not ok then warn("[QH] UB error: " .. tostring(err)); task.wait(0.02) end
    end
end

local function cloudy_v1_loop()
    while Config.CloudyV1.Active do
        local ok, err = pcall(function()
            ensureRodEquipped()
            local currentTime = tick()
            task.wait(GetCastingWait(Config.CloudyV1.CastDelay))
            needCast = false
            pcall(function() if Config.UB.Remotes.ChargeFishingRod and Config.UB.Remotes.ChargeFishingRod.Parent then Config.UB.Remotes.ChargeFishingRod:InvokeServer({[1] = currentTime}) end end)
            local qualityParam = GetCastingQualityParam(Config.CloudyV1.UseCastMode, Config.CloudyV1.CastMode)
            pcall(function() if Config.UB.Remotes.RequestMinigame and Config.UB.Remotes.RequestMinigame.Parent then Config.UB.Remotes.RequestMinigame:InvokeServer(1, qualityParam, currentTime) end end)
            task.wait(math.max(Config.CloudyV1.HookDelay, 0.001))
            Config.CatchQuality = GetCatchQuality(Config.CloudyV1.CastMode or Config.CastMode)
            CompleteFishing(Config.CatchQuality)
            blatantFishCycleCount = blatantFishCycleCount + 1
        end)
        if not ok then warn("[QH] Cloudy V1 error: " .. tostring(err)); task.wait(0.02) end
    end
end

local function cloudy_1n_loop()
    while Config.Cloudy1N.Active do
        local ok, err = pcall(function()
            ensureRodEquipped()
            local currentTime = tick()
            task.wait(GetCastingWait(Config.Cloudy1N.CastDelay))
            needCast = false
            pcall(function() if Config.UB.Remotes.ChargeFishingRod and Config.UB.Remotes.ChargeFishingRod.Parent then Config.UB.Remotes.ChargeFishingRod:InvokeServer({[1] = currentTime}) end end)
            local qualityParam = GetCastingQualityParam(Config.Cloudy1N.UseCastMode, Config.Cloudy1N.CastMode)
            pcall(function() if Config.UB.Remotes.RequestMinigame and Config.UB.Remotes.RequestMinigame.Parent then Config.UB.Remotes.RequestMinigame:InvokeServer(1, qualityParam, currentTime) end end)
            task.wait(math.max(Config.Cloudy1N.HookDelay, 0.001))
            Config.CatchQuality = GetCatchQuality(Config.Cloudy1N.CastMode or Config.CastMode)
            CompleteFishing(Config.CatchQuality)
            replayAmblatantNotif()
        end)
        if not ok then warn("[QH] Cloudy 1N error: " .. tostring(err)); task.wait(0.02) end
    end
end

local function onToggleCloudy1N(value)
    if value then
        if Config.AutoCatch then onToggleLegitFishing(false) end
        if Config.UB.Active then onToggleUB(false) end
        if Config.amblatant then onToggleYTTA(false) end
        if Config.CloudyV1.Active then onToggleCloudyV1(false) end
        if Config.InstantFishing and Config.InstantFishing.Active then Config.InstantFishing.Active = false end
        if Config.InstantV2 and Config.InstantV2.Active then stopInstantV2() end

        _currentNotifDelayDuration = 1
        enableNotifDelay()
        patchInstantBaitOverrideToCastPosition(false)
        _G.QHBetaAnimSpeed = false
        equipRod()
        task.wait(0.5)
        UB_init()
        Config.Cloudy1N.Active = true
        needCast = true
        _G.NotifQueue = {}
        _G.NotifActive = 0
        isCaught = false
        Config.UB.Stats.startTime = tick()
        Tasks.cloudy1ntask = task.spawn(cloudy_1n_loop)
        NotifySuccess("Cloudy 1N", "Aktif!")
    else
        Config.Cloudy1N.Active = false
        _G.NotifQueue = {}
        _G.NotifActive = 0
        _currentNotifDelayDuration = NOTIF_DELAY_DURATION
        disableNotifDelay()
        safeFire(function() if Config.UB.Remotes.CancelFishingInputs then CallRemote(Config.UB.Remotes.CancelFishingInputs) end end)
        task.wait(0.3)
        if Tasks.cloudy1ntask then pcall(function() task.cancel(Tasks.cloudy1ntask) end); Tasks.cloudy1ntask = nil end
        NotifyWarning("Cloudy 1N", "Dimatikan.")
    end
end

local function UB_start()
    if Config.UB.Active then return end
    Config.UB.Settings.HookDelay = Config.UB.Settings.HookDelay or 0.3
    _G.QHBetaAnimSpeed = true
    UB_init(); Config.UB.Active = true; needCast = true
    _G.NotifQueue = {}; _G.NotifActive = 0; isCaught = false
    Config.UB.Stats.startTime = tick()
    Tasks.ubtask = task.spawn(ub_loop)
    NotifySuccess("Cloudy Fishing", "Aktif!")
end

local function UB_stop()
    if not Config.UB.Active then return end
    _G.QHBetaAnimSpeed = false
    Config.UB.Active = false; _G.NotifQueue = {}; _G.NotifActive = 0

    pcall(function() SkinAnimation.DisconnectSpeedUp() end)
    safeFire(function() if Config.UB.Remotes.CancelFishingInputs then CallRemote(Config.UB.Remotes.CancelFishingInputs) end end)
    task.wait(0.3)
    if Tasks.ubtask then pcall(function() task.cancel(Tasks.ubtask) end); Tasks.ubtask = nil end
    NotifyWarning("Cloudy Fishing", "Dimatikan.")
end

local function onToggleUB(value)
    if value then
        if Config.AutoCatch then onToggleLegitFishing(false) end
        if Config.Cloudy1N and Config.Cloudy1N.Active then onToggleCloudy1N(false) end
        if Config.amblatant then onToggleYTTA(false) end
        if Config.CloudyV1 and Config.CloudyV1.Active then onToggleCloudyV1(false) end
        if Config.InstantFishing and Config.InstantFishing.Active then Config.InstantFishing.Active = false end
        if Config.InstantV2 and Config.InstantV2.Active then stopInstantV2() end

        _currentNotifDelayDuration = NOTIF_DELAY_DURATION
        enableNotifDelay()
        patchInstantBaitOverrideToCastPosition(true); equipRod(); task.wait(0.3); UB_start()
    else
        UB_stop(); patchInstantBaitOverrideToCastPosition(false); disableNotifDelay()
    end
end

local function onToggleYTTA(value)
    Config.amblatant = value
    if value then
        if Config.AutoCatch then onToggleLegitFishing(false) end
        if Config.Cloudy1N and Config.Cloudy1N.Active then onToggleCloudy1N(false) end
        if Config.CloudyV1 and Config.CloudyV1.Active then onToggleCloudyV1(false) end
        if Config.InstantFishing and Config.InstantFishing.Active then Config.InstantFishing.Active = false end
        if Config.InstantV2 and Config.InstantV2.Active then stopInstantV2() end

        _currentNotifDelayDuration = NOTIF_DELAY_DURATION
        enableNotifDelay()
        patchInstantBaitOverrideToCastPosition(true); equipRod(); task.wait(0.3)
        saveCount = 0; needCast = true
        UB_init(); Config.UB.Active = true; needCast = true
        _G.NotifQueue = {}; _G.NotifActive = 0; isCaught = false
        Config.UB.Stats.startTime = tick()
        Tasks.ubtask = task.spawn(ub_loop)
        NotifySuccess("Cloudy Max", "Aktif!")
    else
        Config.amblatant = false
        Config.UB.Active = false; _G.NotifQueue = {}; _G.NotifActive = 0
        patchInstantBaitOverrideToCastPosition(false); disableNotifDelay()
        safeFire(function() if Config.UB.Remotes.CancelFishingInputs then CallRemote(Config.UB.Remotes.CancelFishingInputs) end end)
        task.wait(0.3)
        if Tasks.ubtask then pcall(function() task.cancel(Tasks.ubtask) end); Tasks.ubtask = nil end
        NotifyWarning("Cloudy Max", "Dimatikan.")
    end
end

local function onToggleCloudyV1(value)
    if value then
        if Config.AutoCatch then onToggleLegitFishing(false) end
        if Config.UB.Active then onToggleUB(false) end
        if Config.amblatant then onToggleYTTA(false) end
        if Config.Cloudy1N and Config.Cloudy1N.Active then onToggleCloudy1N(false) end
        if Config.InstantFishing and Config.InstantFishing.Active then Config.InstantFishing.Active = false end
        if Config.InstantV2 and Config.InstantV2.Active then stopInstantV2() end

        _currentNotifDelayDuration = NOTIF_DELAY_DURATION_V1
        enableNotifDelay()
        equipRod()
        task.wait(0.5)
        UB_init()
        Config.CloudyV1.Active = true
        needCast = true
        _G.NotifQueue = {}
        _G.NotifActive = 0
        isCaught = false
        Config.UB.Stats.startTime = tick()
        Tasks.cloudyv1task = task.spawn(cloudy_v1_loop)
        NotifySuccess("Cloudy V1", "Aktif!")
    else
        Config.CloudyV1.Active = false
        _G.NotifQueue = {}
        _G.NotifActive = 0
        _currentNotifDelayDuration = NOTIF_DELAY_DURATION
        disableNotifDelay()
        safeFire(function() if Config.UB.Remotes.CancelFishingInputs then CallRemote(Config.UB.Remotes.CancelFishingInputs) end end)
        task.wait(0.3)
        if Tasks.cloudyv1task then pcall(function() task.cancel(Tasks.cloudyv1task) end); Tasks.cloudyv1task = nil end
        NotifyWarning("Cloudy V1", "Dimatikan.")
    end
end

UB_init()

task.spawn(function()
    while true do
        task.wait(5)
        local anyActive = Config.UB.Active or Config.CloudyV1.Active
        if anyActive and lastTimeFishCaught ~= nil and os.clock() - lastTimeFishCaught >= 20 and blatantFishCycleCount > 1 then
            needCast = true; saveCount = 0; blatantFishCycleCount = 1; lastTimeFishCaught = os.clock()
            safeFire(function() if Config.UB.Remotes.CancelFishingInputs then CallRemote(Config.UB.Remotes.CancelFishingInputs) end end)
            task.wait(0.3)
            equipRod()
        end
    end
end)

local function RunAutoSellLoop()
    if Tasks.AutoSellThread then pcall(function() task.cancel(Tasks.AutoSellThread) end); Tasks.AutoSellThread = nil end
    Tasks.AutoSellThread = task.spawn(function()
        while Config.AutoSellState do
            if not Events.sell or not Events.sell.Parent then
                Events.sell = GetServerRemote("RF/SellAllItems")
                if not Events.sell then NotifyError("Auto Sell", "Remote tidak ditemukan!"); task.wait(3); continue end
            end
            if Config.AutoSellMethod == "Delay" then
                local delaySeconds = math.clamp(Config.AutoSellValue, 1, 9999)
                local startTime = tick()
                while Config.AutoSellState and (tick() - startTime) < delaySeconds do
                    task.wait(0.1)
                end
                if Config.AutoSellState then
                    local ok = pcall(function()
                        if Events.sell:IsA("RemoteFunction") then Events.sell:InvokeServer()
                        elseif Events.sell:IsA("RemoteEvent") then Events.sell:FireServer() end
                    end)

                    if ok then pcall(function() if Window and Window.Notify then Fluent:Notify({ Title = "[OK] Auto Sell", Content = "Executed", Duration = 1, Icon = "lucide:circle-check" }) end end) end
                end
            elseif Config.AutoSellMethod == "Count" then
                local targetCount = math.clamp(Config.AutoSellValue, 1, 9999)
                local startCount = _sessionCatchCount or 0
                local lastCount = startCount
                local timeout = 0
                while Config.AutoSellState and (_sessionCatchCount - startCount) < targetCount and timeout < 3600 do
                    task.wait(0.3)
                    timeout = timeout + 0.3
                    local currentCount = _sessionCatchCount - startCount
                    if currentCount ~= lastCount then
                        lastCount = currentCount
                        timeout = 0
                    end
                end
                if Config.AutoSellState and (_sessionCatchCount - startCount) >= targetCount then
                    local ok = pcall(function()
                        if Events.sell:IsA("RemoteFunction") then Events.sell:InvokeServer()
                        elseif Events.sell:IsA("RemoteEvent") then Events.sell:FireServer() end
                    end)

                    if ok then pcall(function() if Window and Window.Notify then Fluent:Notify({ Title = "[OK] Auto Sell", Content = "Sold " .. targetCount .. " fish", Duration = 1, Icon = "lucide:circle-check" }) end end) end
                end
            else task.wait(1) end
        end
    end)
end

local function GetPlayerDataReplion()
    local result = nil
    pcall(function()
        local replionModule = FindReplionModule()
        if replionModule then
            result = require(replionModule).Client:WaitReplion("Data", 5)
        end
    end)
    return result or PlayerData or nil
end

local function IsFishItem(item)
    local isFish = false
    pcall(function()

        if item.Metadata and item.Metadata.Weight then isFish = true end

        if ItemUtility then
            local data = ItemUtility:GetItemData(item.Id)
            if data and data.Probability then isFish = true end
            if data and data.Data and data.Data.Type and string.lower(tostring(data.Data.Type)) == "fish" then isFish = true end
        end
    end)
    return isFish
end

local function GetFishNameAndRarity(item)
    local name = item.Identifier or "Unknown"
    local rarity = item.Metadata and item.Metadata.Rarity or "COMMON"
    local itemID = item.Id
    local itemData = nil
    pcall(function()
        if ItemUtility then
            itemData = ItemUtility:GetItemData(itemID)
            if not itemData then local numericID = tonumber(item.Id) or tonumber(item.Identifier); if numericID then itemData = ItemUtility:GetItemData(numericID) end end
        end
    end)
    if itemData and itemData.Data and itemData.Data.Name then name = itemData.Data.Name end
    if item.Metadata and item.Metadata.Rarity then rarity = item.Metadata.Rarity
    elseif itemData and itemData.Probability and itemData.Probability.Chance and TierUtility then
        local tierObj = nil
        pcall(function() tierObj = TierUtility:GetTierFromRarity(itemData.Probability.Chance) end)
        if tierObj and tierObj.Name then rarity = tierObj.Name end
    end
    return name, rarity
end

local function GetItemMutationString(item)
    if item.Metadata and item.Metadata.Shiny == true then return "Shiny" end
    return item.Metadata and item.Metadata.VariantId or ""
end

local function RunAutoFavLoop(isUnfavorite)
    local replion = GetPlayerDataReplion()
    if not replion then return end
    if not Events.favorite then Events.favorite = GetServerRemote("RE/FavoriteItem"); if not Events.favorite then NotifyError("Auto Fav", "Remote tidak ditemukan!"); return end end
    local ok, invData = pcall(function() return replion:GetExpect("Inventory") end)
    if not ok or not invData or not invData.Items then return end
    local targets = {}
    for _, item in ipairs(invData.Items) do
        local isAlreadyFav = (item.IsFavorite or item.Favorited)
        local shouldProcess = isUnfavorite and isAlreadyFav or (not isUnfavorite and not isAlreadyFav)
        if shouldProcess then
            local _, rarity = GetFishNameAndRarity(item)
            local mutation = GetItemMutationString(item)
            local match = false
            if #Config.SelectedRarities > 0 then for _, r in ipairs(Config.SelectedRarities) do if string.lower(rarity) == string.lower(r) then match = true; break end end end
            if not match and #Config.SelectedMutations > 0 then if table.find(Config.SelectedMutations, mutation) then match = true end end
            if match and item.UUID then table.insert(targets, item.UUID) end
        end
    end
    if #targets > 0 then
        NotifyInfo(isUnfavorite and "Unfavoriting" or "Favoriting", "Memproses " .. #targets .. " ikan...")
        for _, uuid in ipairs(targets) do
            if (isUnfavorite and not Config.AutoUnfavoriteState) or (not isUnfavorite and not Config.AutoFavoriteState) then break end
            pcall(function() if Events.favorite then Events.favorite:FireServer(uuid) end end)
            task.wait(0.3)
        end
    else NotifyInfo(isUnfavorite and "Unfavoriting" or "Favoriting", "Tidak ada ikan yang cocok.") end
end

local STONE_IDS = {["Enchant Stones"]=10, ["Evolved Enchant Stone"]=558}
local enchantIdMap = {
    ["Big Hunter 1"]=3,["Cursed 1"]=12,["Empowered 1"]=9,["Glistening 1"]=1,["Gold Digger 1"]=4,
    ["Leprechaun 1"]=5,["Leprechaun 2"]=6,["Mutation Hunter 1"]=7,["Mutation Hunter 2"]=14,
    ["Prismatic 1"]=13,["Reeler 1"]=2,["Stargazer 1"]=8,["Stormhunter 1"]=11,["XPerienced 1"]=10,
    ["SECRET Hunter"]=16,["Shark Hunter"]=20,["Stargazer II"]=17,["Stormhunter II"]=19,
    ["Leprechaun II"]=6,["Reeler II"]=21,["Mutation Hunter III"]=22,["Fairy Hunter 1"]=15
}

_G.SelectedStoneType = _G.SelectedStoneType or "Enchant Stones"
_G.TargetEnchantBasic = _G.TargetEnchantBasic or "Big Hunter 1"
_G.TargetEnchantEvolved = _G.TargetEnchantEvolved or "Prismatic 1"
_G.AutoEnchant = _G.AutoEnchant or false

local function findEnchantStones()
    local stones = {}
    pcall(function()
        local replion = GetPlayerDataReplion()
        local inv = replion and replion:GetExpect("Inventory")
        if not inv or not inv.Items then return end
        local targetId = STONE_IDS[_G.SelectedStoneType]
        for _, item in ipairs(inv.Items) do if item.Id == targetId then table.insert(stones, {UUID=item.UUID, Id=item.Id}) end end
    end)
    return stones
end

local function countHotbarSlots()
    local count = 5
    pcall(function()
        local backpackGui = LocalPlayer.PlayerGui:FindFirstChild("Backpack")
        if not backpackGui then return end
        local display = backpackGui:FindFirstChild("Display"); if not display then return end
        local c = 0
        for _, child in ipairs(display:GetChildren()) do if child:IsA("ImageButton") then c = c + 1 end end
        count = c
    end)
    return count
end

local function getCurrentRodEnchant()
    local enchantId = nil
    pcall(function()
        local replion = GetPlayerDataReplion()
        if not replion then return end
        local equipped = replion:Get("EquippedItems"); if not equipped then return end
        local rods = replion:GetExpect("Inventory")
        if not rods or not rods["Fishing Rods"] then return end
        for _, uuid in pairs(equipped) do
            for _, rod in ipairs(rods["Fishing Rods"]) do
                if rod.UUID == uuid and rod.Metadata and rod.Metadata.EnchantId then enchantId = rod.Metadata.EnchantId end
            end
        end
    end)
    return enchantId
end

local megCheckRadius = 150
local autoEventTPEnabled = false
local autoEventThread = nil
local selectedEvents = {}
local createdEventPlatform = nil

local eventData = {
    ["Worm Hunt"]          = {TargetName="Model",             Locations={Vector3.new(2190.85,-1.4,97.575),Vector3.new(-2450.679,-1.4,139.731),Vector3.new(-267.479,-1.4,5188.531),Vector3.new(-327,-1.4,2422)}, PlatformY=5, Priority=1},
    ["Megalodon Hunt"]     = {TargetName="Megalodon Hunt",    Locations={Vector3.new(-1076.3,-1.4,1676.2),Vector3.new(-1191.8,-1.4,3597.3),Vector3.new(412.7,-1.4,4134.4)}, PlatformY=5, Priority=2},
    ["Dark Megalodon Hunt"]= {TargetName="Dark Megalodon Hunt",Locations={Vector3.new(-1076.3,-1.4,1676.2),Vector3.new(-1191.8,-1.4,3597.3),Vector3.new(412.7,-1.4,4134.4)}, PlatformY=5, Priority=3, ScanChildren=32},
    ["Ghost Shark Hunt"]   = {TargetName="Ghost Shark Hunt",  Locations={Vector3.new(489.559,-1.35,25.406),Vector3.new(-1358.216,-1.35,4100.556),Vector3.new(627.859,-1.35,3798.081)}, PlatformY=5, Priority=4},
    ["Shark Hunt"]         = {TargetName="Shark Hunt",         Locations={Vector3.new(1.65,-1.35,2095.725),Vector3.new(1369.95,-1.35,930.125),Vector3.new(-1585.5,-1.35,1242.875),Vector3.new(-1896.8,-1.35,2634.375)}, PlatformY=5, Priority=5},
    ["Glacial Serpent Hunt"]= {TargetName="Glacial Serpent Hunt",Locations={Vector3.new(-1076.3,-1.4,1676.2),Vector3.new(-1191.8,-1.4,3597.3),Vector3.new(412.7,-1.4,4134.4),Vector3.new(2190.85,-1.4,97.575),Vector3.new(-2450.679,-1.4,139.731),Vector3.new(-267.479,-1.4,5188.531),Vector3.new(-327,-1.4,2422),Vector3.new(1.65,-1.35,2095.725),Vector3.new(1369.95,-1.35,930.125),Vector3.new(-1585.5,-1.35,1242.875),Vector3.new(-1896.8,-1.35,2634.375)}, PlatformY=5, Priority=6, WideSearch=true},
    ["Thunderzilla Hunt"]  = {TargetName="Shocked",            Locations={Vector3.new(2071.847,-2.673,15.144)}, PlatformY=5, Priority=7},
}

local function destroyEventPlatform()
    if createdEventPlatform then pcall(function() createdEventPlatform:Destroy() end); createdEventPlatform = nil end
end

local function createAndTeleportToPlatform(targetPos, y)
    local character = game.Players.LocalPlayer.Character
    local hrp = character and character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local desiredPos = Vector3.new(targetPos.X, y or 5, targetPos.Z)
    if createdEventPlatform and createdEventPlatform.Parent then
        createdEventPlatform.Position = desiredPos
    else
        destroyEventPlatform()
        local platform = Instance.new("Part")
        platform.Size = Vector3.new(8, 0.5, 8)
        platform.Position = desiredPos
        platform.Anchored = true
        platform.Transparency = 0.8
        platform.CanCollide = true
        platform.Color = Color3.fromRGB(0, 170, 255)
        platform.Name = "EventPlatform"
        platform.Parent = Workspace
        createdEventPlatform = platform
    end

    pcall(function() SetWalkOnWater(true) end)

    TeleportTo(CFrame.new(createdEventPlatform.Position + Vector3.new(0, 2, 0)))
end

local function runMultiEventTP()
    while autoEventTPEnabled do
        local sorted = {}
        for _, e in ipairs(selectedEvents) do if eventData[e] then table.insert(sorted, eventData[e]) end end
        table.sort(sorted, function(a, b) return a.Priority < b.Priority end)
        local didTP = false
        for _, config in ipairs(sorted) do
            if not autoEventTPEnabled then break end
            local foundTarget, foundPos = nil, nil

            if config.TargetName == "Model" then
                local menuRings = Workspace:FindFirstChild("!!! MENU RINGS")
                if menuRings then
                    for _, props in ipairs(menuRings:GetChildren()) do
                        if props.Name == "Props" then
                            local model = props:FindFirstChild("Model")
                            if model and model.PrimaryPart then
                                local modelPos = model.PrimaryPart.Position
                                for _, loc in ipairs(config.Locations) do
                                    if (modelPos - loc).Magnitude <= megCheckRadius then
                                        foundTarget, foundPos = model, modelPos; break
                                    end
                                end
                            end
                        end
                        if foundTarget then break end
                    end
                end
            elseif config.ScanChildren then
                local wsChildren = Workspace:GetChildren()
                local targetChild = wsChildren[config.ScanChildren]
                if targetChild then
                    local function checkObj(obj)
                        if not obj then return end
                        local pos = nil
                        if obj:IsA("BasePart") then pos = obj.Position
                        elseif obj.PrimaryPart then pos = obj.PrimaryPart.Position end
                        if pos then
                            foundTarget, foundPos = obj, pos
                        end
                    end
                    if targetChild.Name == config.TargetName then
                        checkObj(targetChild)
                    else
                        for _, child in ipairs(targetChild:GetChildren()) do
                            if child.Name == config.TargetName then checkObj(child); break end
                        end
                    end
                end

                if not foundTarget then
                    for _, d in ipairs(Workspace:GetDescendants()) do
                        if d.Name == config.TargetName then
                            local pos = nil
                            if d:IsA("BasePart") then pos = d.Position
                            elseif d.PrimaryPart then pos = d.PrimaryPart.Position end
                            if pos then foundTarget, foundPos = d, pos; break end
                        end
                    end
                end
            elseif config.WideSearch then
                for _, d in ipairs(Workspace:GetDescendants()) do
                    if d.Name == config.TargetName then
                        local pos = nil
                        if d:IsA("BasePart") then pos = d.Position
                        elseif d.PrimaryPart then pos = d.PrimaryPart.Position end
                        if pos then foundTarget, foundPos = d, pos; break end
                    end
                end

                if not foundTarget then
                    for _, child in ipairs(Workspace:GetChildren()) do
                        if child.Name == config.TargetName then
                            local pos = nil
                            if child:IsA("BasePart") then pos = child.Position
                            elseif child.PrimaryPart then pos = child.PrimaryPart.Position end
                            if pos then foundTarget, foundPos = child, pos; break end
                        end
                    end
                end
            else

                for _, d in ipairs(Workspace:GetDescendants()) do
                    if d.Name == config.TargetName then
                        local pos = nil
                        if d:IsA("BasePart") then pos = d.Position
                        elseif d.PrimaryPart then pos = d.PrimaryPart.Position end
                        if pos then
                            for _, loc in ipairs(config.Locations) do
                                if (pos - loc).Magnitude <= megCheckRadius then
                                    foundTarget, foundPos = d, pos; break
                                end
                            end
                        end
                    end
                    if foundTarget then break end
                end

                if not foundTarget then
                    for _, child in ipairs(Workspace:GetChildren()) do
                        if child.Name == config.TargetName then
                            local pos = nil
                            if child:IsA("BasePart") then pos = child.Position
                            elseif child.PrimaryPart then pos = child.PrimaryPart.Position end
                            if pos then
                                for _, loc in ipairs(config.Locations) do
                                    if (pos - loc).Magnitude <= megCheckRadius then
                                        foundTarget, foundPos = child, pos; break
                                    end
                                end
                            end
                        end
                        if foundTarget then break end
                    end
                end
            end

            if foundTarget and foundPos then
                createAndTeleportToPlatform(foundPos, config.PlatformY)
                didTP = true
                break
            end
        end
        task.wait(0.5)
    end
    destroyEventPlatform()
end

local function CreateCloudyPanel()
    pcall(function()
        local old = (gethui and gethui():FindFirstChild("CloudyPanelV4")) or CoreGui:FindFirstChild("CloudyPanelV4") or (LocalPlayer and LocalPlayer:FindFirstChild("PlayerGui") and LocalPlayer.PlayerGui:FindFirstChild("CloudyPanelV4"))
        if old then old:Destroy() end
    end)

    local gui = Instance.new("ScreenGui")
    gui.Name = "CloudyPanelV4"
    gui.IgnoreGuiInset = true
    gui.ResetOnSpawn = false
    gui.Enabled = true
    pcall(function()
        if gethui then
            gui.Parent = gethui()
        elseif CoreGui then
            gui.Parent = CoreGui
        else
            gui.Parent = LocalPlayer:WaitForChild("PlayerGui")
        end
    end)

    local main = Instance.new("Frame")
    main.Name = "Main"
    main.Size = UDim2.new(0, 230, 0, 58)
    main.Position = UDim2.new(0.5, -115, 0, 14)
    main.BackgroundColor3 = Color3.fromRGB(20, 24, 32)
    main.BackgroundTransparency = 0.25
    main.BorderSizePixel = 0
    main.Active = true
    main.ClipsDescendants = true
    main.Parent = gui

    local corner = Instance.new("UICorner", main)
    corner.CornerRadius = UDim.new(0, 10)

    local stroke = Instance.new("UIStroke", main)
    stroke.Color = Color3.fromRGB(80, 100, 130)
    stroke.Transparency = 0.6
    stroke.Thickness = 1

    local bgGradient = Instance.new("UIGradient", main)
    bgGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(28, 34, 46)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(16, 20, 28))
    })
    bgGradient.Rotation = 90

    local topHeader = Instance.new("Frame")
    topHeader.Name = "TopHeader"
    topHeader.Size = UDim2.new(1, -16, 0, 20)
    topHeader.Position = UDim2.new(0, 8, 0, 6)
    topHeader.BackgroundTransparency = 1
    topHeader.Parent = main

    local headerLayout = Instance.new("UIListLayout")
    headerLayout.FillDirection = Enum.FillDirection.Horizontal
    headerLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
    headerLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    headerLayout.Padding = UDim.new(0, 6)
    headerLayout.Parent = topHeader

    local logo = Instance.new("ImageLabel")
    logo.Name = "Logo"
    logo.Size = UDim2.new(0, 16, 0, 16)
    logo.BackgroundTransparency = 1
    logo.Image = "rbxassetid://134255722754338"
    logo.ScaleType = Enum.ScaleType.Fit
    logo.Parent = topHeader

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "TitleLabel"
    titleLabel.Size = UDim2.new(0, 0, 1, 0)
    titleLabel.AutomaticSize = Enum.AutomaticSize.X
    titleLabel.BackgroundTransparency = 1
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 11
    titleLabel.Text = "Cloudy Project Panel"
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.Parent = topHeader

    local titleGradient = Instance.new("UIGradient", titleLabel)
    titleGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(170, 178, 192))
    })

    local divider = Instance.new("Frame")
    divider.Name = "Divider"
    divider.Size = UDim2.new(1, -16, 0, 1)
    divider.Position = UDim2.new(0, 8, 0, 28)
    divider.BackgroundColor3 = Color3.fromRGB(80, 100, 130)
    divider.BackgroundTransparency = 0.7
    divider.BorderSizePixel = 0
    divider.Parent = main

    local bottomStats = Instance.new("Frame")
    bottomStats.Name = "BottomStats"
    bottomStats.Size = UDim2.new(1, -16, 0, 22)
    bottomStats.Position = UDim2.new(0, 8, 0, 31)
    bottomStats.BackgroundTransparency = 1
    bottomStats.Parent = main

    local statsLayout = Instance.new("UIListLayout")
    statsLayout.FillDirection = Enum.FillDirection.Horizontal
    statsLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    statsLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    statsLayout.Padding = UDim.new(0, 16)
    statsLayout.Parent = bottomStats

    local function makeStatItem(tag)
        local lbl = Instance.new("TextLabel")
        lbl.Name = tag
        lbl.Size = UDim2.new(0, 0, 1, 0)
        lbl.AutomaticSize = Enum.AutomaticSize.X
        lbl.BackgroundTransparency = 1
        lbl.Font = Enum.Font.GothamMedium
        lbl.TextSize = 10
        lbl.RichText = true
        lbl.Text = string.format("<font color='#8A96A8'>%s</font> <font color='#D0E0FF'>--</font>", tag)
        lbl.Parent = bottomStats
        return lbl
    end

    local pingLabel = makeStatItem("PING")
    local notifLabel = makeStatItem("NOTIF")
    local fpsLabel = makeStatItem("FPS")

    local dragging = false
    local dragStart, startPos
    main.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = main.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        pcall(function()
            if dragging and startPos and dragStart and
               (input.UserInputType == Enum.UserInputType.MouseMovement or
                input.UserInputType == Enum.UserInputType.Touch) then
                local delta = input.Position - dragStart
                main.Position = UDim2.new(
                    startPos.X.Scale, startPos.X.Offset + delta.X,
                    startPos.Y.Scale, startPos.Y.Offset + delta.Y
                )
            end
        end)
    end)

    local frames = 0
    local fps = 0
    local last = tick()

    local fpsConn = RunService.RenderStepped:Connect(function()
        pcall(function()
            frames = (frames or 0) + 1
            if tick() - last >= 1 then
                fps = frames
                frames = 0
                last = tick()
            end
        end)
    end)

    local function getPing()
        local networkStats = Stats:FindFirstChild("Network")
        if networkStats and networkStats:FindFirstChild("ServerStatsItem") then
            local pingData = networkStats.ServerStatsItem:FindFirstChild("Data Ping")
            if pingData then
                local val = pingData:GetValue()
                if val then return math.floor(val) end
            end
        end
        return 0
    end

    local function getTotalNotifications()
        local count = 0
        pcall(function()
            local playerGui = LocalPlayer:WaitForChild("PlayerGui", 2)
            local textNotifications = playerGui and playerGui:FindFirstChild("Text Notifications")
            if textNotifications then
                local frame = textNotifications:FindFirstChild("Frame")
                if frame then
                    for _, child in ipairs(frame:GetChildren()) do
                        if child.Name == "Tile" then
                            count = count + 1
                        end
                    end
                end
            end
        end)
        return count
    end

    local updateThread = task.spawn(function()
        while gui and gui.Parent do
            pcall(function()
                if PingMonitor and PingMonitor.Update then PingMonitor:Update() end
                local ping = getPing()
                local notifCount = getTotalNotifications()

                local pingColor
                if ping < 80 then
                    pingColor = "#A0E0A0"
                elseif ping < 150 then
                    pingColor = "#FFD166"
                else
                    pingColor = "#FF8080"
                end

                local fpsColor
                if fps >= 50 then
                    fpsColor = "#D0E0FF"
                elseif fps >= 30 then
                    fpsColor = "#FFD166"
                else
                    fpsColor = "#FF8080"
                end

                local notifColor = notifCount > 0 and "#FFD166" or "#A0C4FF"

                pingLabel.Text = string.format("<font color='#8A96A8'>PING</font> <font color='%s'>%dms</font>", pingColor, ping)
                notifLabel.Text = string.format("<font color='#8A96A8'>NOTIF</font> <font color='%s'>%d</font>", notifColor, notifCount)
                fpsLabel.Text = string.format("<font color='#8A96A8'>FPS</font> <font color='%s'>%d</font>", fpsColor, fps)
            end)
            task.wait(0.5)
        end
    end)

    gui.Destroying:Connect(function()
        pcall(function() fpsConn:Disconnect() end)
        pcall(function() task.cancel(updateThread) end)
    end)

    return gui
end
local statsPanelGui = CreateCloudyPanel()

pcall(function()
    for _, v in pairs(getconnections(LocalPlayer.Idled)) do
        if v.Disable then v.Disable() elseif v.Disconnect then v.Disconnect() end
    end
end)

local STONE_IDS = {
    ["Enchant Stones"]        = 10,
    ["Evolved Enchant Stone"] = 558
}

local enchantIdMap = {
    ["Big Hunter 1"] = 3, ["Cursed 1"] = 12, ["Empowered 1"] = 9,
    ["Glistening 1"] = 1, ["Gold Digger 1"] = 4, ["Leprechaun 1"] = 5,
    ["Leprechaun 2"] = 6, ["Mutation Hunter 1"] = 7, ["Mutation Hunter 2"] = 14,
    ["Prismatic 1"] = 13, ["Reeler 1"] = 2, ["Stargazer 1"] = 8,
    ["Stormhunter 1"] = 11, ["XPerienced 1"] = 10,
    ["SECRET Hunter"] = 16, ["Shark Hunter"] = 20, ["Stargazer II"] = 17,
    ["Stormhunter II"] = 19, ["Mutation Hunter II"] = 14, ["Leprechaun II"] = 6,
    ["Reeler II"] = 21, ["Mutation Hunter III"] = 22, ["Fairy Hunter 1"] = 15
}

_G.SelectedStoneType     = _G.SelectedStoneType or "Enchant Stones"
_G.TargetEnchantBasic    = _G.TargetEnchantBasic or "Big Hunter 1"
_G.TargetEnchantEvolved  = _G.TargetEnchantEvolved or "Prismatic 1"
_G.AutoEnchant           = _G.AutoEnchant or false

local basicEnchantNames = {
    "Big Hunter 1", "Cursed 1", "Empowered 1", "Glistening 1",
    "Gold Digger 1", "Leprechaun 1", "Leprechaun 2",
    "Mutation Hunter 1", "Mutation Hunter 2", "Prismatic 1",
    "Reeler 1", "Stargazer 1", "Stormhunter 1", "XPerienced 1"
}

local evolvedEnchantNames = {
    "Prismatic 1", "Cursed 1", "Gold Digger 1", "Empowered 1",
    "SECRET Hunter", "Shark Hunter", "Stargazer II", "Stormhunter II",
    "Mutation Hunter II", "Leprechaun II", "Reeler II", "Mutation Hunter III",
    "Fairy Hunter 1"
}

local function gStone()
    local replion = GetPlayerDataReplion()
    local it = replion and replion:GetExpect("Inventory")
    if not it or not it.Items then return 0 end
    local targetId = STONE_IDS[_G.SelectedStoneType]
    local total = 0
    for _, v in ipairs(it.Items) do
        if v.Id == targetId then
            total = total + (v.Quantity or 1)
        end
    end
    return total
end

local function countDisplayImageButtons()
    local backpackGui = LocalPlayer.PlayerGui:FindFirstChild("Backpack")
    if not backpackGui then return 0 end
    local display = backpackGui:FindFirstChild("Display")
    if not display then return 0 end
    local count = 0
    for _, child in ipairs(display:GetChildren()) do
        if child:IsA("ImageButton") then
            count += 1
        end
    end
    return count
end

local function findEnchantStones()
    local replion = GetPlayerDataReplion()
    local inv = replion and replion:GetExpect("Inventory")
    if not inv or not inv.Items then return {} end
    local targetId = STONE_IDS[_G.SelectedStoneType]
    local stones = {}
    for _, item in ipairs(inv.Items) do
        if item.Id == targetId then
            table.insert(stones, {
                UUID = item.UUID,
                Quantity = item.Quantity or 1,
                Id = item.Id
            })
        end
    end
    return stones
end

local function getEquippedRodName()
    local replion = GetPlayerDataReplion()
    local equipped = replion and replion:Get("EquippedItems")
    if not equipped then return "None" end
    local rods = replion:GetExpect("Inventory")
    if not rods or not rods["Fishing Rods"] then return "None" end
    for _, uuid in pairs(equipped) do
        for _, rod in ipairs(rods["Fishing Rods"]) do
            if rod.UUID == uuid then
                local itemData = ItemUtility and ItemUtility:GetItemData(rod.Id)
                return (itemData and itemData.Data and itemData.Data.Name) or rod.ItemName or "None"
            end
        end
    end
    return "None"
end

local function getCurrentRodEnchant()
    local replion = GetPlayerDataReplion()
    local equipped = replion and replion:Get("EquippedItems")
    if not equipped then return nil end
    local rods = replion:GetExpect("Inventory")
    if not rods or not rods["Fishing Rods"] then return nil end
    for _, uuid in pairs(equipped) do
        for _, rod in ipairs(rods["Fishing Rods"]) do
            if rod.UUID == uuid and rod.Metadata and rod.Metadata.EnchantId then
                return rod.Metadata.EnchantId
            end
        end
    end
    return nil
end

local function gEvolvedStone()
    local replion = GetPlayerDataReplion()
    local it = replion and replion:GetExpect("Inventory")
    if not it or not it.Items then return 0 end
    local total = 0
    for _, v in ipairs(it.Items) do
        if v.Id == 558 then
            total = total + (v.Quantity or 1)
        end
    end
    return total
end

local AtlantisConfig = {
    AutoAtlantisMachine = false,
    IsRunning = false,
    MachineThread = nil,
    LastFishingPosition = nil
}

local ATLANTIS_MACHINE_CF = CFrame.new(-3173.55419921875, -640.4428100585938, -10449.6025390625, 0.044499535113573074, -6.89831125555429e-08, -0.9990094304084778, 5.832494665014565e-08, 1, -6.645350936196337e-08, 0.9990094304084778, -5.5310017899046215e-08, 0.044499535113573074)

local ATLANTIS_UI_REMOTE_NAME = "RF/a97637c7fad3ffe5a38c68ae066f2812042e83694e259976a4f3b39d0ff82bd1"

local function OpenAtlantisUI()
    local remote = GetServerRemote(ATLANTIS_UI_REMOTE_NAME)
    if remote then
        pcall(function() remote:InvokeServer() end)
        return true
    end
    return false
end

local function GetAtlantisFishCount()
    local count = 0
    pcall(function()
        local replion = GetPlayerDataReplion()
        if not replion then return end
        local inv = replion:GetExpect("Inventory")
        if not inv or not inv.Items then return end
        for _, item in ipairs(inv.Items) do
            local _, rarity = GetFishNameAndRarity(item)
            if rarity and (
                rarity == "Rare" or rarity == "Epic" or
                rarity == "Legendary" or rarity == "Mythic" or
                rarity == "SECRET"
            ) then count = count + 1 end
        end
    end)
    return count
end

local function SacrificeAllFishToAtlantis()
    local hrp = getHRP()
    if not hrp then return false end

    AtlantisConfig.LastFishingPosition = hrp.CFrame

    NotifyInfo("Atlantis", "Teleport langsung ke Atlantis Machine...")
    local hrp2 = getHRP()
    if hrp2 then
        TeleportTo(CFrame.new(ATLANTIS_MACHINE_CF + Vector3.new(0, 5, 0)))
    end
    task.wait(0.5)

    local uiOpened = OpenAtlantisUI()
    if uiOpened then
        NotifyInfo("Atlantis", "UI Atlantis terbuka!")
        task.wait(0.3)
    else
        NotifyWarning("Atlantis", "UI remote gagal, lanjut sacrifice...")
    end

    local sacrificeRemote = GetServerRemote("RF/SacrificeAtlantisFish")
    local sellAllRemote   = GetServerRemote("RF/SacrificeAtlantisSellAll")
    local effectRemote    = GetServerRemote("RE/AtlantisMachineEffect")

    if not sacrificeRemote then
        NotifyError("Atlantis", "Remote Sacrifice tidak ditemukan!")
        local h = getHRP()
        if h and AtlantisConfig.LastFishingPosition then
            h.CFrame = AtlantisConfig.LastFishingPosition
        end
        return false
    end

    local fishToSacrifice = {}
    pcall(function()
        local replion = GetPlayerDataReplion()
        if not replion then return end
        local inv = replion:GetExpect("Inventory")
        if not inv or not inv.Items then return end
        for _, item in ipairs(inv.Items) do
            local _, rarity = GetFishNameAndRarity(item)
            if rarity and (
                rarity == "Rare" or rarity == "Epic" or
                rarity == "Legendary" or rarity == "Mythic" or
                rarity == "SECRET"
            ) then
                if item.UUID then table.insert(fishToSacrifice, item.UUID) end
            end
        end
    end)

    if #fishToSacrifice == 0 then
        NotifyWarning("Atlantis", "Tidak ada ikan (Rare+) untuk di-sacrifice!")
        local h = getHRP()
        if h and AtlantisConfig.LastFishingPosition then
            h.CFrame = AtlantisConfig.LastFishingPosition
        end
        return false
    end

    NotifyInfo("Atlantis", "Sacrifice " .. #fishToSacrifice .. " ikan...")

    local sacrificedCount = 0
    for _, uuid in ipairs(fishToSacrifice) do
        if not AtlantisConfig.IsRunning then break end
        local ok = pcall(function() sacrificeRemote:InvokeServer(uuid) end)
        if ok then sacrificedCount = sacrificedCount + 1 end
        task.wait(0.25)
    end

    task.wait(1)

    if sellAllRemote then
        pcall(function() sellAllRemote:InvokeServer() end)
        NotifyInfo("Atlantis", "Sell all dikirim!")
        task.wait(0.5)
    end

    if effectRemote then
        pcall(function() FireLocalEvent(effectRemote) end)
    end

    NotifySuccess("Atlantis", "✓ Sacrifice " .. sacrificedCount .. " ikan berhasil!")
    task.wait(1.5)

    return sacrificedCount > 0
end

local function RunAutoAtlantisMachine()
    if AtlantisConfig.MachineThread then
        pcall(function() task.cancel(AtlantisConfig.MachineThread) end)
        AtlantisConfig.MachineThread = nil
    end
    AtlantisConfig.IsRunning = true

    local originalPos = nil
    local hrp = getHRP()
    if hrp then originalPos = hrp.CFrame end

    AtlantisConfig.MachineThread = task.spawn(function()
        while AtlantisConfig.AutoAtlantisMachine and AtlantisConfig.IsRunning do
            local ok, err = pcall(function()
                local fishCount = GetAtlantisFishCount()
                if fishCount < 5 then
                    NotifyInfo("Atlantis", "Fish kurang (" .. fishCount .. "/5). Menunggu...")
                    task.wait(5)
                    return
                end
                NotifyInfo("Atlantis", "Fish cukup! (" .. fishCount .. ") Mulai sacrifice...")
                SacrificeAllFishToAtlantis()
            end)
            if not ok then
                warn("[QH] Atlantis error: " .. tostring(err))
            end
            if not AtlantisConfig.AutoAtlantisMachine then break end
            task.wait(5)
        end

        if originalPos then
            local h = getHRP()
            if h then
                TeleportTo(originalPos)
                NotifySuccess("Atlantis", "Kembali ke posisi semula!")
            end
        end
        AtlantisConfig.IsRunning = false
        NotifyInfo("Atlantis", "Auto Atlantis Machine berhenti.")
    end)
end

local function StopAutoAtlantisMachine()
    AtlantisConfig.AutoAtlantisMachine = false
    AtlantisConfig.IsRunning = false
    if AtlantisConfig.MachineThread then
        pcall(function() task.cancel(AtlantisConfig.MachineThread) end)
        AtlantisConfig.MachineThread = nil
    end
    NotifyWarning("Atlantis", "Dimatikan.")
end

local function GetFishList()
    local list = {}
    local groups = {}
    pcall(function()
        local replion = GetPlayerDataReplion()
        if not replion then return end
        local inv = replion:GetExpect("Inventory")
        if not inv or not inv.Items then return end
        for _, item in ipairs(inv.Items) do
            if item.UUID and IsFishItem(item) then
                local name, rarity = GetFishNameAndRarity(item)

                local allowed = {SECRET=true, FORGOTTEN=true, MYTHIC=true, Mythic=true}
                if not allowed[rarity] then continue end
                local key = name .. "|" .. rarity
                if not groups[key] then
                    groups[key] = {
                        UUID    = item.UUID,
                        Name    = name,
                        Rarity  = rarity,
                        Count   = 0,
                        Items   = {},
                    }
                end
                groups[key].Count = groups[key].Count + 1
                table.insert(groups[key].Items, item.UUID)
            end
        end
    end)
    for key, group in pairs(groups) do
        group.Display = group.Name .. " [" .. group.Rarity .. "] x" .. group.Count
        table.insert(list, group)
    end

    local rarityOrder = {FORGOTTEN=8,SECRET=7,MYTHIC=6,Mythic=6,Legendary=5,Epic=4,Rare=3,Uncommon=2,Common=1}
    table.sort(list, function(a,b)
        local ra = rarityOrder[a.Rarity] or 0
        local rb = rarityOrder[b.Rarity] or 0
        if ra ~= rb then return ra > rb end
        return a.Name < b.Name
    end)
    return list
end

local walkOnWaterConn, waterPlatform = nil, nil
local function SetWalkOnWater(val)
    Config.WalkOnWater = val
    if walkOnWaterConn then walkOnWaterConn:Disconnect(); walkOnWaterConn = nil end
    if waterPlatform then pcall(function() waterPlatform:Destroy() end); waterPlatform = nil end
    if val then
        waterPlatform = Instance.new("Part")
        waterPlatform.Name = "QH_WaterWalkPlatform"; waterPlatform.Size = Vector3.new(12, 0.5, 12)
        waterPlatform.Transparency = 1; waterPlatform.CanCollide = true; waterPlatform.Anchored = true
        waterPlatform.Parent = Workspace
        local rayParams = RaycastParams.new()
        rayParams.FilterType = Enum.RaycastFilterType.Blacklist
        rayParams.IgnoreWater = false
        walkOnWaterConn = RunService.Heartbeat:Connect(function()
            local char = LocalPlayer.Character; if not char then return end
            local hrp = char:FindFirstChild("HumanoidRootPart"); if not hrp then return end
            rayParams.FilterDescendantsInstances = {char, waterPlatform}

            local result = Workspace:Raycast(hrp.Position + Vector3.new(0, 5, 0), Vector3.new(0, -25, 0), rayParams)
            local isOnWater, waterY = false, nil
            if result then
                local hit = result.Instance
                if hit then
                    local hitName = hit.Name:lower()

                    if hitName:find("water") or hitName:find("ocean") or hitName:find("sea") or hitName:find("lake") then
                        isOnWater = true; waterY = result.Position.Y
                    elseif result.Material == Enum.Material.Water then
                        isOnWater = true; waterY = result.Position.Y
                    elseif hit.Transparency > 0.7 and hit.CanCollide == false then
                        isOnWater = true; waterY = result.Position.Y
                    end
                end
            end

            if not isOnWater and hrp.Position.Y <= 5 then
                isOnWater = true; waterY = 0
            end
            if isOnWater and waterY then
                waterPlatform.Position = Vector3.new(hrp.Position.X, waterY + 0.3, hrp.Position.Z)
                waterPlatform.CanCollide = true
            else
                waterPlatform.CanCollide = false
                waterPlatform.Position = Vector3.new(0, -500, 0)
            end
        end)
        NotifySuccess("Walk on Water", "Aktif! Platform akan muncul di atas air.")
    else
        NotifyInfo("Walk on Water", "Nonaktif.")
    end
end

local _hiddenTag = false
_G.NoAnimationEnabled = false
local noAnimConnection, noAnimCharConnection = nil, nil
local function StopAllAnimations(char)
    local hum = char:FindFirstChildOfClass("Humanoid"); if not hum then return end
    local anim = hum:FindFirstChildOfClass("Animator")
    if anim then for _, track in ipairs(anim:GetPlayingAnimationTracks()) do pcall(function() track:Stop(0) end) end end
end
local function SetupNoAnimation(char)
    if not _G.NoAnimationEnabled then return end
    local hum = char:WaitForChild("Humanoid", 5); if not hum then return end
    StopAllAnimations(char)
    if noAnimConnection then pcall(function() noAnimConnection:Disconnect() end) end
    pcall(function()
        noAnimConnection = hum.AnimationPlayed:Connect(function(track)
            if _G.NoAnimationEnabled then pcall(function() track:Stop(0) end) end
        end)
    end)
end

local function RunAutoEvent()
    Tasks.AutoEventThread = task.spawn(function()
        while Config.AutoEvent do
            pcall(function()
                local hrp = getHRP(); if not hrp then return end
                local zones = workspace:FindFirstChild("Zones"); if not zones then return end
                local lev = zones:FindFirstChild("Leviathan's Den")
                if lev then TeleportTo(CFrame.new(3474.053, -287.775, 3472.634)); task.wait(1) end
                local thunder = zones:FindFirstChild("Ancient Jungle")
                if thunder then TeleportTo(CFrame.new(2067.866, 2.028, 10.831)); task.wait(1) end
            end)
            task.wait(5)
        end
    end)
end

local function SetDisableObtained(val)
    Config.DisableObtained = val
    if val then
        pcall(function() if origPlaySmallItemObtained and Controllers.Notification then Controllers.Notification.PlaySmallItemObtained = function() return end end end)
        NotifySuccess("Disable Obtained", "Notif obtained diblokir!")
    else
        pcall(function() if origPlaySmallItemObtained and Controllers.Notification then Controllers.Notification.PlaySmallItemObtained = origPlaySmallItemObtained end end)
        NotifyInfo("Disable Obtained", "Notif obtained normal.")
    end
end

if InfoTab then
    pcall(function()
        local Section_InfoTab_1 = InfoTab:AddSection("Informasi Script")
        Section_InfoTab_1:AddButton({
            Title = "Discord Server", Description = "Klik untuk copy link",
            Callback = function()
                pcall(function() if typeof(setclipboard) == "function" then setclipboard("https://discord.gg/CZVDHgHR"); NotifySuccess("Discord", "Link dicopy!") end end)
            end
        })
        local Section_InfoTab_2 = InfoTab:AddSection("Map Info")
        Section_InfoTab_2:AddParagraph({ Title = "Map: " .. (isSupported and supportedMaps["121864768012064"] or mapName) , Content = "" })
        Section_InfoTab_2:AddParagraph({ Title = "Toggle RightShift untuk Show/Hide UI" , Content = "" })
        Section_InfoTab_2:AddParagraph({ Title = "Script FREE - Jangan diperjualbelikan!" , Content = "" })
    end)
end

if PlayersTab then
    pcall(function()

_G.AutoReconnect = false
_G.AutoReconnectThread = nil

function ServerHop(reason, forcePublic)
    reason = reason or "Server hopping..."
    forcePublic = forcePublic or false

    local isPrivateServer = game.PrivateServerId ~= "" and game.PrivateServerOwnerId ~= 0

    -- Notifikasi (gunakan NotifyInfo, NotifyWarning, dll. yang sudah ada)
    pcall(function()
        Fluent:Notify({
            Title = "Server Hop",
            Content = reason .. (isPrivateServer and " (Private)" or ""),
            Duration = 2,
            Icon = "lucide:refresh-cw"
        })
    end)

    task.wait(0.5)

    local HttpService = game:GetService("HttpService")
    local TeleportService = game:GetService("TeleportService")
    local LocalPlayer = game:GetService("Players").LocalPlayer

    local success, result = pcall(function()
        local url = "https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Desc&limit=100"
        local response = game:HttpGet(url)
        local serverList = HttpService:JSONDecode(response)

        if serverList and serverList.data then
            for _, server in ipairs(serverList.data) do
                if server.id ~= game.JobId and server.playing < server.maxPlayers then
                    print("[ServerHop] Found public server:", server.id)
                    TeleportService:TeleportToPlaceInstance(game.PlaceId, server.id, LocalPlayer)
                    return true
                end
            end
        end
        return false
    end)

    if not success or not result then
        print("[ServerHop] Primary method failed, using fallback...")

        if forcePublic then
            local paginationSuccess = pcall(function()
                local servers = {}
                local cursor = ""
                local pageCount = 0
                local maxPages = 5

                repeat
                    pageCount = pageCount + 1
                    local url = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
                    if cursor ~= "" then url = url .. "&cursor=" .. cursor end

                    local response = game:HttpGet(url)
                    local serverData = HttpService:JSONDecode(response)

                    for _, server in pairs(serverData.data) do
                        if server.id ~= game.JobId and server.playing < server.maxPlayers then
                            table.insert(servers, server.id)
                        end
                    end
                    cursor = serverData.nextPageCursor or ""
                until #servers > 0 or cursor == "" or pageCount >= maxPages

                if #servers > 0 then
                    local selectedServer = servers[math.random(1, #servers)]
                    TeleportService:TeleportToPlaceInstance(game.PlaceId, selectedServer, LocalPlayer)
                    return true
                end
                return false
            end)

            if paginationSuccess then
                print("[ServerHop] Hopped to public server.")
                return
            else
                print("[ServerHop] CRITICAL: No public server found.")
                return
            end
        end

        -- Fallback rejoin (tetap di server yang sama)
        print("[ServerHop] Attempting rejoin fallback...")
        local rejoinSuccess = pcall(function()
            if isPrivateServer then
                local teleportOptions = Instance.new("TeleportOptions")
                teleportOptions.ServerInstanceId = game.JobId
                teleportOptions.ReservedServerAccessCode = game.PrivateServerId
                TeleportService:TeleportAsync(game.PlaceId, {LocalPlayer}, teleportOptions)
            else
                TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
            end
        end)

        if not rejoinSuccess then
            print("[ServerHop] Rejoin failed, using random teleport.")
            task.wait(0.5)
            pcall(function()
                TeleportService:Teleport(game.PlaceId, LocalPlayer)
            end)
        end
    end
end

function RejoinServer()
    local isPrivate = game.PrivateServerId ~= "" and game.PrivateServerOwnerId ~= 0
    local TeleportService = game:GetService("TeleportService")
    local LocalPlayer = game:GetService("Players").LocalPlayer

    pcall(function()
        Fluent:Notify({
            Title = "Rejoin",
            Content = "Rejoining server...",
            Duration = 2,
            Icon = "lucide:refresh-cw"
        })
    end)

    local success = pcall(function()
        if isPrivate then
            local teleportOptions = Instance.new("TeleportOptions")
            teleportOptions.ServerInstanceId = game.JobId
            teleportOptions.ReservedServerAccessCode = game.PrivateServerId
            TeleportService:TeleportAsync(game.PlaceId, {LocalPlayer}, teleportOptions)
        else
            TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
        end
    end)

    if not success then
        task.wait(0.5)
        pcall(function()
            TeleportService:Teleport(game.PlaceId, LocalPlayer)
        end)
    end
end

        local Section_PlayersTab_Server = PlayersTab:AddSection("Server")
        
        Section_PlayersTab_Server:AddButton({
            Title = "Server Hop",
            Description = "Pindah ke server publik lain",
            Callback = function()
                ServerHop("Switching to another server...", false)
            end
        })
        
        Section_PlayersTab_Server:AddButton({
            Title = "Rejoin Server",
            Description = "Kembali ke server yang sama (reconnect)",
            Callback = function()
                RejoinServer()
            end
        })
        
        Section_PlayersTab_Server:AddToggle("Toggle_AutoReconnect", {
            Title = "Auto Reconnect",
            Description = "Otomatis klik tombol reconnect jika terputus",
            Default = false,
            Callback = function(val)
                _G.AutoReconnect = val
                if val then
                    if _G.AutoReconnectThread then
                        task.cancel(_G.AutoReconnectThread)
                        _G.AutoReconnectThread = nil
                    end
                    _G.AutoReconnectThread = task.spawn(function()
                        while _G.AutoReconnect do
                            task.wait(2)
                            local reconnectUI = game:GetService("CoreGui"):FindFirstChild("RobloxPromptGui")
                            if reconnectUI then
                                local prompt = reconnectUI:FindFirstChild("promptOverlay")
                                if prompt then
                                    local button = prompt:FindFirstChild("ButtonPrimary")
                                    if button and button.Visible then
                                        pcall(function()
                                            -- Coba beberapa metode klik
                                            if typeof(firesignal) == "function" then
                                                firesignal(button.MouseButton1Click)
                                            elseif button.MouseButton1Click and typeof(button.MouseButton1Click.Fire) == "function" then
                                                button.MouseButton1Click:Fire()
                                            elseif button.Click then
                                                button:Click()
                                            end
                                        end)
                                    end
                                end
                            end
                        end
                    end)
                else
                    if _G.AutoReconnectThread then
                        task.cancel(_G.AutoReconnectThread)
                        _G.AutoReconnectThread = nil
                    end
                end
            end
        })

        local Section_PlayersTab_1 = PlayersTab:AddSection("Character Controls")
        Section_PlayersTab_1:AddSlider("Slider_WalkSpeed", { Title = "Walk Speed", Min = 16, Max = 200, Default = 16 , Rounding = 0, Callback = function(val) local char = LocalPlayer.Character; if char then local hum = char:FindFirstChildOfClass("Humanoid"); if hum then hum.WalkSpeed = val end end end })
        Section_PlayersTab_1:AddSlider("Slider_JumpPower", { Title = "Jump Power", Min = 50, Max = 500, Default = 50 , Rounding = 0, Callback = function(val) local char = LocalPlayer.Character; if char then local hum = char:FindFirstChildOfClass("Humanoid"); if hum then hum.UseJumpPower = true; hum.JumpPower = val end end end })
        Section_PlayersTab_1:AddButton({ Title = "Reset Speed & Jump", Callback = function() local char = LocalPlayer.Character; if char then local hum = char:FindFirstChildOfClass("Humanoid"); if hum then hum.WalkSpeed = 16; hum.UseJumpPower = true; hum.JumpPower = 50 end end; NotifySuccess("Reset", "Speed & Jump normal!") end })

        local Section_PlayersTab_2 = PlayersTab:AddSection("Special Abilities")
        Section_PlayersTab_2:AddToggle("Toggle_InfiniteJump", {
            Title = "Infinite Jump", Default = false,
            Callback = function(val) _G.InfiniteJump = val end
        })
        UserInputService.JumpRequest:Connect(function()
            if _G.InfiniteJump then
                local char = LocalPlayer.Character
                if char then local hum = char:FindFirstChildOfClass("Humanoid"); if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end end
            end
        end)
        Section_PlayersTab_2:AddToggle("Toggle_Noclip", {
            Title = "Noclip", Default = false,
            Callback = function(val)
                _G.Noclip = val
                if val then
                    task.spawn(function()
                        while _G.Noclip do
                            task.wait(0.05)
                            local char = LocalPlayer.Character
                            if char then for _, part in pairs(char:GetDescendants()) do if part:IsA("BasePart") and part.CanCollide then part.CanCollide = false end end end
                        end
                    end)
                else
                    RestoreCharacterCollision(LocalPlayer.Character)
                end
            end
        })
        local freezeConnP, frozenCFrameP
        Section_PlayersTab_2:AddToggle("Toggle_FreezeCharacter", {
            Title = "Freeze Character", Default = false,
            Callback = function(val)
                if val then
                    local hrp = getHRP()
                    if hrp then
                        frozenCFrameP = hrp.CFrame; _G.FreezeCharacter = true
                        freezeConnP = RunService.Heartbeat:Connect(function() if _G.FreezeCharacter and hrp then hrp.CFrame = frozenCFrameP end end)
                    end
                else
                    _G.FreezeCharacter = false
                    if freezeConnP then pcall(function() freezeConnP:Disconnect() end); freezeConnP = nil end
                end
            end
        })
        Section_PlayersTab_2:AddToggle("Toggle_WalkonWater", { Title = "Walk on Water", Default = false, Callback = function(val) SetWalkOnWater(val) end })
        
        local Section_PlayersTab_3 = PlayersTab:AddSection("Custom Name")

-- Konfigurasi default (gunakan LocalPlayer yang sudah ada)
local FakeName = "discord.gg/cloudy"
local FakeLevel = "MAX"
local ScriptName = "Cloudy one top"
local HideStatsEnabled = false

-- Storage untuk teks asli dan thread gradien
local OriginalTexts = {}
local ActiveGradientThreads = {}

-- Fungsi membuat gradien bergerak (shimmer)
local function createMovingGradient(label)
    if not label or not label:IsA("TextLabel") then return end
    local oldGradient = label:FindFirstChild("ShimmerGradient")
    if oldGradient then oldGradient:Destroy() end
    local gradient = Instance.new("UIGradient")
    gradient.Name = "ShimmerGradient"
    gradient.Parent = label
    local colorKeypoints = {}
    local basePattern = {
        {0.00, Color3.fromRGB(35, 40, 55)},    -- Abu gelap (charcoal)
        {0.10, Color3.fromRGB(95, 110, 135)},  -- Abu sedang (mid-slate)
        {0.20, Color3.fromRGB(185, 200, 220)}, -- Abu terang (light-silver)
        {0.30, Color3.fromRGB(255, 255, 255)}, -- Putih
        {0.40, Color3.fromRGB(185, 200, 220)}, -- Abu terang
        {0.50, Color3.fromRGB(95, 110, 135)},  -- Abu sedang
        {0.60, Color3.fromRGB(35, 40, 55)},    -- Abu gelap
        {0.70, Color3.fromRGB(95, 110, 135)},  -- Abu sedang
        {0.80, Color3.fromRGB(185, 200, 220)}, -- Abu terang
        {0.90, Color3.fromRGB(255, 255, 255)}, -- Putih
        {1.00, Color3.fromRGB(35, 40, 55)},    -- Abu gelap
    }
    for _, data in ipairs(basePattern) do
        table.insert(colorKeypoints, ColorSequenceKeypoint.new(data[1], data[2]))
    end
    gradient.Color = ColorSequence.new(colorKeypoints)
    local threadId = tostring(label)
    ActiveGradientThreads[threadId] = true
    spawn(function()
        local offset = 0
        while label and label.Parent and ActiveGradientThreads[threadId] do
            offset = offset + 0.015
            if offset >= 1 then offset = 0 end
            gradient.Offset = Vector2.new(offset, 0)
            task.wait(0.02)
        end
    end)
    return gradient
end

-- Fungsi menambahkan label nama script di atas kepala
local function createScriptNameLabel(nameLabel, billboard)
    if not nameLabel or not billboard then return end
    local existingFrame = billboard:FindFirstChild("NodeXFrame")
    if existingFrame then return existingFrame end
    local nameFrame = nameLabel.Parent
    if not nameFrame or not nameFrame:IsA("Frame") then return end
    local originalNamePos = nameFrame.Position
    nameFrame.Position = UDim2.new(
        originalNamePos.X.Scale,
        originalNamePos.X.Offset,
        originalNamePos.Y.Scale + 0.25,
        originalNamePos.Y.Offset
    )
    local voraFrame = Instance.new("Frame")
    voraFrame.Name = "NodeXFrame"
    voraFrame.Size = nameFrame.Size
    voraFrame.Position = originalNamePos
    voraFrame.BackgroundTransparency = 1
    voraFrame.Parent = billboard
    local scriptLabel = nameLabel:Clone()
    scriptLabel.Name = "NodeXLabel"
    scriptLabel.Text = ScriptName
    scriptLabel.TextScaled = true
    scriptLabel.Font = Enum.Font.GothamBold
    scriptLabel.TextStrokeTransparency = 0.5
    scriptLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    scriptLabel.Parent = voraFrame
    createMovingGradient(scriptLabel)
    return voraFrame
end

-- Hapus label script
local function removeAllScriptNames()
    local character = LocalPlayer.Character
    if not character then return end
    local hrp = character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local overhead = hrp:FindFirstChild("Overhead")
    if not overhead then return end
    local voraFrame = overhead:FindFirstChild("NodeXFrame")
    if voraFrame then
        for threadId, _ in pairs(ActiveGradientThreads) do
            ActiveGradientThreads[threadId] = nil
        end
        local nameLabel = overhead:FindFirstChild("Header", true)
        if nameLabel then
            local nameFrame = nameLabel.Parent
            if nameFrame and nameFrame:IsA("Frame") then
                local currentPos = nameFrame.Position
                nameFrame.Position = UDim2.new(
                    currentPos.X.Scale,
                    currentPos.X.Offset,
                    currentPos.Y.Scale - 0.25,
                    currentPos.Y.Offset
                )
            end
        end
        voraFrame:Destroy()
    end
end

-- Fungsi utama update stats (ganti teks)
local function updateStats()
    if not HideStatsEnabled then
        removeAllScriptNames()
        return
    end
    local character = LocalPlayer.Character
    if not character then return end
    local hrp = character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local overhead = hrp:FindFirstChild("Overhead")
    if not overhead or not overhead:IsA("BillboardGui") then return end
    for _, obj in pairs(overhead:GetDescendants()) do
        if obj:IsA("TextLabel") then
            local fullPath = obj:GetFullName()
            if not OriginalTexts[fullPath] then
                OriginalTexts[fullPath] = obj.Text
            end
            local originalText = OriginalTexts[fullPath]
            if originalText and originalText ~= "" then
                if obj.Name == "Header" then
                    if not overhead:FindFirstChild("NodeXFrame") then
                        createScriptNameLabel(obj, overhead)
                    end
                    obj.Text = FakeName
                elseif string.find(string.lower(originalText), "lvl") then
                    obj.Text = string.gsub(originalText, "%d+", FakeLevel)
                end
            end
        end
    end
end

-- Loop update
local updateLoopActive = false
local function startUpdateLoop()
    if updateLoopActive then return end
    updateLoopActive = true
    spawn(function()
        while updateLoopActive and task.wait(0.2) do
            if HideStatsEnabled then
                updateStats()
            end
        end
    end)
end

-- Handler saat karakter ganti
local function onCharacterAdded(char)
    task.wait(0.5)
    if HideStatsEnabled then updateStats() end
end
LocalPlayer.CharacterAdded:Connect(onCharacterAdded)
if LocalPlayer.Character then onCharacterAdded(LocalPlayer.Character) end

-- === UI Elements dengan ID (diperbaiki) ===
Section_PlayersTab_3:AddInput("HideNameInput", {
    Title = "Hide Name",
    Description = "Nama samaran yang akan muncul di atas kepala.",
    Placeholder = "Input Name",
    Default = FakeName,
    Callback = function(value)
        FakeName = value
        if HideStatsEnabled then updateStats() end
    end,
    Finished = true
})

Section_PlayersTab_3:AddInput("HideLevelInput", {
    Title = "Hide Level",
    Description = "Level samaran (contoh: 'Lvl. 100' atau 'Max').",
    Placeholder = "Input Level",
    Default = FakeLevel,
    Callback = function(value)
        FakeLevel = value
        if HideStatsEnabled then updateStats() end
    end,
    Finished = true
})

Section_PlayersTab_3:AddToggle("HideIdentityToggle", {
    Title = "Hide Identity",
    Description = "Aktifkan untuk mengganti nama & level, serta menambahkan label script.",
    Default = false,
    Callback = function(state)
        HideStatsEnabled = state
        if state then
            startUpdateLoop()
            updateStats()
           -- HAPUS atau KOMENTAR baris ini:
            -- loadstring(game:HttpGet("https://raw.githubusercontent.com/CF-Trail/NameHider/main/MainScript.lua"))()
        else
            -- Restore original texts
            for path, originalText in pairs(OriginalTexts) do
                local obj = game
                for part in string.gmatch(path, "[^.]+") do
                    obj = obj:FindFirstChild(part)
                    if not obj then break end
                end
                if obj and obj:IsA("TextLabel") then
                    obj.Text = originalText
                end
            end
            removeAllScriptNames()
        end
    end
})
    

        local Section_PlayersTab_6 = PlayersTab:AddSection("Custom Skin Animation")
        local customSkinNames = {"Eclipse","HolyTrident","SoulScythe","OceanicHarpoon","BinaryEdge","Vanquisher","KrampusScythe","BanHammer","CorruptionEdge","PrincessParasol"}
        local skinDropdownValues = customSkinNames
        Section_PlayersTab_6:AddDropdown("Dropdown_PilihCustomSkin", { Title = "Pilih Custom Skin", Values = skinDropdownValues, Default = skinDropdownValues[1],  Callback = function(val) SkinAnimation.SwitchSkin(val) end, Multi = false })
        Section_PlayersTab_6:AddToggle("Toggle_EnableCustomSkinAnimation", { Title = "Enable Custom Skin Animation", Default = false, Callback = function(val) if val then SkinAnimation.Enable() else SkinAnimation.Disable() end end })

        local Section_PlayersTab_7 = PlayersTab:AddSection("Local Aura Visual")

        local localAura = nil
        local localAuraName = nil
        local availableAuras = {}
        local auraDropdownRef = nil

        local function scanAuras()
            availableAuras = {}
            local aurasFolder = ReplicatedStorage:FindFirstChild("Assets")
            aurasFolder = aurasFolder and aurasFolder:FindFirstChild("Auras")
            if aurasFolder then
                for _, aura in ipairs(aurasFolder:GetChildren()) do
                    table.insert(availableAuras, aura.Name)
                end
            end
            table.sort(availableAuras)
            return availableAuras
        end

        local function applyLocalAura(auraName)
            if localAura then
                if type(localAura) == "table" then
                    for _, inst in ipairs(localAura) do pcall(function() inst:Destroy() end) end
                else
                    pcall(function() localAura:Destroy() end)
                end
                localAura = nil
            end
            if not auraName or auraName == "" then return end
            pcall(function()
                local aurasFolder = ReplicatedStorage:FindFirstChild("Assets")
                aurasFolder = aurasFolder and aurasFolder:FindFirstChild("Auras")
                if not aurasFolder then warn("[Aura] ReplicatedStorage.Assets.Auras not found") return end
                local template = aurasFolder:FindFirstChild(auraName)
                if not template then warn("[Aura] Aura not found: " .. tostring(auraName)) return end
                local char = LocalPlayer.Character
                if not char then return end
                local instances = {}
                for _, child in ipairs(template:GetChildren()) do
                    if child.Name == "AttachTo" then
                        local torso = char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso")
                        if torso then
                            local clone = child:Clone()
                            if clone:IsA("BasePart") then
                                clone.Transparency = 1
                                clone.CanCollide = false
                                clone.CanTouch = false
                                clone.CastShadow = false
                                clone.Massless = true
                            end
                            local weld = Instance.new("Weld")
                            weld.Part0 = clone
                            weld.Part1 = torso
                            weld.Parent = clone
                            clone.Parent = char
                            table.insert(instances, clone)
                        end
                    else
                        local charPart = char:FindFirstChild(child.Name)
                        if charPart then
                            for _, fx in ipairs(child:GetChildren()) do
                                local clone = fx:Clone()
                                clone.Parent = charPart
                                table.insert(instances, clone)
                            end
                        end
                    end
                end
                if #instances > 0 then
                    localAura = instances
                    NotifySuccess("Aura", "Applied: " .. auraName)
                else
                    NotifyWarning("Aura", "Template had no applicable children: " .. auraName)
                end
            end)
        end

        local function removeLocalAura()
            if localAura then
                if type(localAura) == "table" then
                    for _, inst in ipairs(localAura) do pcall(function() inst:Destroy() end) end
                else
                    pcall(function() localAura:Destroy() end)
                end
                localAura = nil
                localAuraName = nil
                NotifyInfo("Aura", "Aura removed!")
            else
                NotifyWarning("Aura", "No aura is currently active.")
            end
        end

        LocalPlayer.CharacterAdded:Connect(function()
            task.delay(1, function()
                if localAuraName then applyLocalAura(localAuraName) end
            end)
        end)

        local auraDropdownValues = {"-- Refresh dulu --"}
        auraDropdownRef = Section_PlayersTab_7:AddDropdown("Dropdown_PilihAura", {
            Title = "Pilih Aura",
            Description = "Klik Refresh untuk scan aura dari game",
            Values = auraDropdownValues,
            Default = auraDropdownValues[1],

            Callback = function(val)
                if val ~= "-- Refresh dulu --" and val ~= "Tidak ada aura" then
                    _G.SelectedAuraName = val
                    NotifyInfo("Aura", "Selected: " .. val)
                end
            end, Multi = false
        })

        Section_PlayersTab_7:AddButton({
            Title = "Refresh Aura List",
            Description = "Scan semua aura di ReplicatedStorage.Assets.Auras",
            Callback = function()
                local auras = scanAuras()
                if #auras == 0 then
                    NotifyWarning("Aura", "Tidak ada aura ditemukan! Pastikan di game yang benar.")
                    local emptyValues = {{ Title = "Tidak ada aura", Icon = "lucide:circle-x" }}
                    pcall(function() if auraDropdownRef and auraDropdownRef.SetValues then auraDropdownRef:SetValues({"Tidak ada aura"}); auraDropdownRef:SetValue("Tidak ada aura") end end)
                    return
                end
                local newValues = {}
                for _, name in ipairs(auras) do
                    table.insert(newValues, { Title = name, Icon = "lucide:sparkles" })
                end
                pcall(function() if auraDropdownRef and auraDropdownRef.SetValues then auraDropdownRef:SetValues(auras); auraDropdownRef:SetValue(auras[1]) end end)
                NotifySuccess("Aura", "Ditemukan " .. #auras .. " aura! Pilih dari dropdown.")
            end
        })

        Section_PlayersTab_7:AddButton({
            Title = "Apply Aura",
            Description = "Pasang aura yang dipilih ke karakter (Client-Side Only)",
            Callback = function()
                if not _G.SelectedAuraName or _G.SelectedAuraName == "" then
                    NotifyError("Aura", "Pilih aura dulu dari dropdown!")
                    return
                end
                localAuraName = _G.SelectedAuraName
                applyLocalAura(localAuraName)
            end
        })

        Section_PlayersTab_7:AddButton({
            Title = "Remove Aura",
            Description = "Hapus aura yang sedang aktif",
            Callback = function()
                removeLocalAura()
            end
        })

        local Section_PlayersTab_8 = PlayersTab:AddSection("Teleport to Player")
        local selectedPlayerInPlayersTab = nil
        local playersTabDropdownRef = nil
        local pMapPlayersTab = {}

        local function getPlayerListPlayersTab()
            local list = {}
            local map = {}
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= LocalPlayer then
                    local label = p.DisplayName .. " (@" .. p.Name .. ")"
                    table.insert(list, label)
                    map[label] = p
                    map[p.Name] = p
                    map[p.DisplayName] = p
                end
            end
            table.sort(list)
            if #list == 0 then
                table.insert(list, "Tidak ada player lain")
            end
            return list, map
        end

        local pListPlayersTab
        pListPlayersTab, pMapPlayersTab = getPlayerListPlayersTab()
        selectedPlayerInPlayersTab = pListPlayersTab[1]

        local function refreshPlayersTabDropdown()
            local newList, newMap = getPlayerListPlayersTab()
            pListPlayersTab = newList
            pMapPlayersTab = newMap
            if playersTabDropdownRef and playersTabDropdownRef.SetValues then
                pcall(function()
                    playersTabDropdownRef:SetValues(pListPlayersTab)
                    if not pMapPlayersTab[selectedPlayerInPlayersTab] then
                        selectedPlayerInPlayersTab = pListPlayersTab[1]
                        playersTabDropdownRef:SetValue(selectedPlayerInPlayersTab)
                    end
                end)
            end
        end

        playersTabDropdownRef = Section_PlayersTab_8:AddDropdown("Dropdown_PilihPlayer_PlayersTab", {
            Title = "Pilih Player",
            Values = pListPlayersTab,
            Default = pListPlayersTab[1],
            Callback = function(val)
                selectedPlayerInPlayersTab = val
            end,
            Multi = false
        })

        Section_PlayersTab_8:AddButton({
            Title = "Teleport to Player",
            Description = "Teleport langsung ke samping player yang dipilih",
            Callback = function()
                if not selectedPlayerInPlayersTab or selectedPlayerInPlayersTab == "Tidak ada player lain" then
                    NotifyError("Teleport", "Pilih player yang valid!")
                    return
                end

                local targetPlayer = pMapPlayersTab[selectedPlayerInPlayersTab]
                if not targetPlayer then
                    for _, p in ipairs(Players:GetPlayers()) do
                        if p ~= LocalPlayer and (p.Name == selectedPlayerInPlayersTab or p.DisplayName == selectedPlayerInPlayersTab or selectedPlayerInPlayersTab:find(p.Name, 1, true)) then
                            targetPlayer = p
                            break
                        end
                    end
                end

                if not targetPlayer then
                    NotifyError("Teleport", "Player tidak ditemukan di server!")
                    refreshPlayersTabDropdown()
                    return
                end

                local targetChar = targetPlayer.Character
                if not targetChar then
                    NotifyError("Teleport", "Character " .. targetPlayer.DisplayName .. " belum spawn!")
                    return
                end

                local targetPart = targetChar:FindFirstChild("HumanoidRootPart") or targetChar.PrimaryPart or targetChar:FindFirstChild("Head") or targetChar:FindFirstChild("UpperTorso") or targetChar:FindFirstChild("Torso") or targetChar:FindFirstChildWhichIsA("BasePart")

                if not targetPart then
                    NotifyError("Teleport", "Target part tidak ditemukan!")
                    return
                end

                local hrp = getHRP()
                if not hrp then
                    NotifyError("Teleport", "HumanoidRootPart kamu tidak ditemukan!")
                    return
                end

                local targetCF = targetPart.CFrame * CFrame.new(0, 2, 3)
                local ok = TeleportTo(targetCF)
                if not ok then
                    pcall(function()
                        hrp.CFrame = targetCF
                    end)
                end

                NotifySuccess("Teleport", "Teleported to " .. targetPlayer.DisplayName .. " (@" .. targetPlayer.Name .. ")!")
            end
        })

        Section_PlayersTab_8:AddButton({
            Title = "Refresh Player List",
            Description = "Update daftar player di dalam server",
            Callback = function()
                refreshPlayersTabDropdown()
                NotifyInfo("Teleport", "Daftar player diperbarui!")
            end
        })

        Players.PlayerAdded:Connect(function()
            task.wait(0.5)
            refreshPlayersTabDropdown()
        end)

        Players.PlayerRemoving:Connect(function()
            task.wait(0.5)
            refreshPlayersTabDropdown()
        end)
    end)
end
if KaitunTab then
    pcall(function()
        _G.Kaitun = {
            Active = false,
            Thread = nil,
            Stage = 1,
            Status = "IDLE",
            SubStatus = "Menunggu perintah...",
            ProgressPct = 0,
            TargetRod = "Element Rod (Endgame)",
            StarterRod = "Carbon Rod",
            AutoSell = true,
            SellMethod = "Berdasarkan Jumlah Ikan di Tas",
            SellThreshold = 15,
            SellInterval = 60,
            LastSellTime = 0,
            CatchDelay = 0.7,
            CatchQuality = "Perfect",
            Stage1Loc = "Fisherman",
            Stage2Loc = "Coral Reefs",
            Stage3Loc = "Sisyphus Statue",
            Stage4Loc = "Ancient Jungle",
            Stage5Loc = "Esoteric Depths",
            StartTime = 0,
            ElapsedSec = 0,
            FishSold = 0,
            CoinsEarned = 0,
            DarkOverlay = true,
            SelectedEnchants = {"Leprechaun II", "Mutation Hunter II", "Perfection", "Cursed I"},
        }

        local KaitunOverlay = {
            Gui = nil,
            MainFrame = nil,
            StageBadge = nil,
            GoalLabel = nil,
            ProgressBar = nil,
            ProgressFill = nil,
            CoinsVal = nil,
            RodVal = nil,
            FishVal = nil,
            TimerVal = nil,
            LogLabel = nil,
            Logs = {},
            IsDimmed = true,
        }

        local function Kaitun_AddLog(msg)
            local tStr = os.date("%X")
            table.insert(KaitunOverlay.Logs, string.format("<font color='#00FFCC'>[%s]</font> %s", tStr, msg))
            if #KaitunOverlay.Logs > 3 then table.remove(KaitunOverlay.Logs, 1) end
            if KaitunOverlay.LogLabel then
                KaitunOverlay.LogLabel.Text = table.concat(KaitunOverlay.Logs, "\n")
            end
        end

        local function InitKaitunOverlay()
            if KaitunOverlay.Gui then return KaitunOverlay.Gui end
            local lp = Players.LocalPlayer
            local pGui = (lp and lp:FindFirstChildOfClass("PlayerGui")) or game:GetService("CoreGui")

            local sg = Instance.new("ScreenGui")
            sg.Name = "QH_KaitunOverlay"
            sg.ResetOnSpawn = false
            sg.DisplayOrder = 999999
            sg.IgnoreGuiInset = true
            sg.Enabled = false
            pcall(function() sg.Parent = pGui end)

            local bg = Instance.new("Frame")
            bg.Name = "Background"
            bg.Size = UDim2.fromScale(1, 1)
            bg.Position = UDim2.new(0, 0, 0, 0)
            bg.BackgroundColor3 = Color3.fromRGB(8, 10, 15)
            bg.BackgroundTransparency = 0.05
            bg.BorderSizePixel = 0
            bg.Parent = sg

            local card = Instance.new("Frame")
            card.Name = "Card"
            card.Size = UDim2.fromOffset(470, 240)
            card.AnchorPoint = Vector2.new(0.5, 0.5)
            card.Position = UDim2.fromScale(0.5, 0.5)
            card.BackgroundColor3 = Color3.fromRGB(12, 16, 23)
            card.BorderSizePixel = 0
            card.Parent = bg

            local cCorner = Instance.new("UICorner")
            cCorner.CornerRadius = UDim.new(0, 10)
            cCorner.Parent = card

            local cStroke = Instance.new("UIStroke")
            cStroke.Color = Color3.fromRGB(0, 230, 160)
            cStroke.Thickness = 1.2
            cStroke.Transparency = 0.4
            cStroke.Parent = card

            local header = Instance.new("Frame")
            header.Size = UDim2.new(1, -24, 0, 26)
            header.Position = UDim2.fromOffset(12, 10)
            header.BackgroundTransparency = 1
            header.Parent = card

            local title = Instance.new("TextLabel")
            title.Size = UDim2.new(0.55, 0, 1, 0)
            title.BackgroundTransparency = 1
            title.Text = "⚡ CLOUDY KAITUN"
            title.TextColor3 = Color3.fromRGB(255, 255, 255)
            title.Font = Enum.Font.GothamBold
            title.TextSize = 13
            title.TextXAlignment = Enum.TextXAlignment.Left
            title.Parent = header

            local stageBadge = Instance.new("TextLabel")
            stageBadge.Size = UDim2.new(0.45, 0, 1, 0)
            stageBadge.Position = UDim2.new(0.55, 0, 0, 0)
            stageBadge.BackgroundTransparency = 1
            stageBadge.Text = "STAGE 1: STARTER"
            stageBadge.TextColor3 = Color3.fromRGB(0, 255, 200)
            stageBadge.Font = Enum.Font.GothamBold
            stageBadge.TextSize = 11
            stageBadge.TextXAlignment = Enum.TextXAlignment.Right
            stageBadge.RichText = true
            stageBadge.Parent = header
            KaitunOverlay.StageBadge = stageBadge

            local goalLbl = Instance.new("TextLabel")
            goalLbl.Size = UDim2.new(1, -24, 0, 18)
            goalLbl.Position = UDim2.fromOffset(12, 38)
            goalLbl.BackgroundTransparency = 1
            goalLbl.Text = "🎯 Objective: Farming Coins (0 / 5,000)"
            goalLbl.TextColor3 = Color3.fromRGB(200, 215, 230)
            goalLbl.Font = Enum.Font.Gotham
            goalLbl.TextSize = 11
            goalLbl.TextXAlignment = Enum.TextXAlignment.Left
            goalLbl.RichText = true
            goalLbl.Parent = card
            KaitunOverlay.GoalLabel = goalLbl

            local progBg = Instance.new("Frame")
            progBg.Size = UDim2.new(1, -24, 0, 6)
            progBg.Position = UDim2.fromOffset(12, 60)
            progBg.BackgroundColor3 = Color3.fromRGB(22, 28, 38)
            progBg.BorderSizePixel = 0
            progBg.Parent = card

            local pCorner = Instance.new("UICorner")
            pCorner.CornerRadius = UDim.new(1, 0)
            pCorner.Parent = progBg

            local progFill = Instance.new("Frame")
            progFill.Size = UDim2.new(0, 0, 1, 0)
            progFill.BackgroundColor3 = Color3.fromRGB(0, 230, 160)
            progFill.BorderSizePixel = 0
            progFill.Parent = progBg

            local pfCorner = Instance.new("UICorner")
            pfCorner.CornerRadius = UDim.new(1, 0)
            pfCorner.Parent = progFill
            KaitunOverlay.ProgressFill = progFill

            local statHolder = Instance.new("Frame")
            statHolder.Size = UDim2.new(1, -24, 0, 48)
            statHolder.Position = UDim2.fromOffset(12, 74)
            statHolder.BackgroundTransparency = 1
            statHolder.Parent = card

            local statLayout = Instance.new("UIGridLayout")
            statLayout.CellSize = UDim2.new(0.235, 0, 1, 0)
            statLayout.CellPadding = UDim2.new(0.02, 0, 0, 0)
            statLayout.Parent = statHolder

            local function CreateStatBox(iconText, titleText, defaultVal)
                local box = Instance.new("Frame")
                box.BackgroundColor3 = Color3.fromRGB(18, 23, 33)
                box.BorderSizePixel = 0
                box.Parent = statHolder
                local bCorn = Instance.new("UICorner")
                bCorn.CornerRadius = UDim.new(0, 6)
                bCorn.Parent = box

                local tLbl = Instance.new("TextLabel")
                tLbl.Size = UDim2.new(1, -8, 0, 14)
                tLbl.Position = UDim2.fromOffset(6, 4)
                tLbl.BackgroundTransparency = 1
                tLbl.Text = iconText .. " " .. titleText
                tLbl.TextColor3 = Color3.fromRGB(130, 145, 165)
                tLbl.Font = Enum.Font.Gotham
                tLbl.TextSize = 10
                tLbl.TextXAlignment = Enum.TextXAlignment.Left
                tLbl.Parent = box

                local vLbl = Instance.new("TextLabel")
                vLbl.Size = UDim2.new(1, -8, 0, 22)
                vLbl.Position = UDim2.fromOffset(6, 20)
                vLbl.BackgroundTransparency = 1
                vLbl.Text = defaultVal
                vLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
                vLbl.Font = Enum.Font.GothamBold
                vLbl.TextSize = 12
                vLbl.TextXAlignment = Enum.TextXAlignment.Left
                vLbl.Parent = box
                return vLbl
            end

            KaitunOverlay.CoinsVal = CreateStatBox("💰", "Koin", "0")
            KaitunOverlay.RodVal = CreateStatBox("🎣", "Rod", "Starter")
            KaitunOverlay.FishVal = CreateStatBox("🐟", "Ikan", "0")
            KaitunOverlay.TimerVal = CreateStatBox("⏱️", "Waktu", "00:00:00")

            local logBox = Instance.new("Frame")
            logBox.Size = UDim2.new(1, -24, 0, 52)
            logBox.Position = UDim2.fromOffset(12, 130)
            logBox.BackgroundColor3 = Color3.fromRGB(10, 13, 19)
            logBox.BorderSizePixel = 0
            logBox.Parent = card

            local lCorn = Instance.new("UICorner")
            lCorn.CornerRadius = UDim.new(0, 6)
            lCorn.Parent = logBox

            local logLbl = Instance.new("TextLabel")
            logLbl.Size = UDim2.new(1, -12, 1, -8)
            logLbl.Position = UDim2.fromOffset(6, 4)
            logLbl.BackgroundTransparency = 1
            logLbl.Text = "[LOG] Kaitun Engine Siap..."
            logLbl.TextColor3 = Color3.fromRGB(160, 180, 200)
            logLbl.Font = Enum.Font.RobotoMono
            logLbl.TextSize = 10
            logLbl.TextXAlignment = Enum.TextXAlignment.Left
            logLbl.TextYAlignment = Enum.TextYAlignment.Top
            logLbl.RichText = true
            logLbl.TextWrapped = true
            logLbl.Parent = logBox
            KaitunOverlay.LogLabel = logLbl

            local btnRow = Instance.new("Frame")
            btnRow.Size = UDim2.new(1, -24, 0, 30)
            btnRow.Position = UDim2.fromOffset(12, 192)
            btnRow.BackgroundTransparency = 1
            btnRow.Parent = card

            local toggleDimBtn = Instance.new("TextButton")
            toggleDimBtn.Size = UDim2.new(0.48, 0, 1, 0)
            toggleDimBtn.Position = UDim2.new(0, 0, 0, 0)
            toggleDimBtn.BackgroundColor3 = Color3.fromRGB(22, 30, 44)
            toggleDimBtn.Text = "👁️ Layar Transparan"
            toggleDimBtn.TextColor3 = Color3.fromRGB(180, 215, 255)
            toggleDimBtn.Font = Enum.Font.GothamMedium
            toggleDimBtn.TextSize = 11
            toggleDimBtn.Parent = btnRow
            local tbCorn = Instance.new("UICorner")
            tbCorn.CornerRadius = UDim.new(0, 6)
            tbCorn.Parent = toggleDimBtn

            toggleDimBtn.MouseButton1Click:Connect(function()
                KaitunOverlay.IsDimmed = not KaitunOverlay.IsDimmed
                if KaitunOverlay.IsDimmed then
                    bg.BackgroundTransparency = 0.05
                    toggleDimBtn.Text = "👁️ Layar Transparan"
                else
                    bg.BackgroundTransparency = 0.92
                    toggleDimBtn.Text = "👁️ Layar Gelap (AFK)"
                end
            end)

            local stopBtn = Instance.new("TextButton")
            stopBtn.Size = UDim2.new(0.48, 0, 1, 0)
            stopBtn.Position = UDim2.new(0.52, 0, 0, 0)
            stopBtn.BackgroundColor3 = Color3.fromRGB(110, 28, 28)
            stopBtn.Text = "⛔ Stop Kaitun"
            stopBtn.TextColor3 = Color3.fromRGB(255, 210, 210)
            stopBtn.Font = Enum.Font.GothamBold
            stopBtn.TextSize = 11
            stopBtn.Parent = btnRow
            local sbCorn = Instance.new("UICorner")
            sbCorn.CornerRadius = UDim.new(0, 6)
            sbCorn.Parent = stopBtn

            stopBtn.MouseButton1Click:Connect(function()
                _G.Kaitun.Active = false
                if _G.Kaitun.Thread then pcall(function() task.cancel(_G.Kaitun.Thread) end); _G.Kaitun.Thread = nil end
                sg.Enabled = false
                NotifyInfo("Auto Kaitun", "Dihentikan oleh pengguna.")
            end)

            KaitunOverlay.Gui = sg
            KaitunOverlay.MainFrame = bg
            return sg
        end

        local function Kaitun_GetCoins()
            local replion = GetPlayerDataReplion()
            if replion then
                local ok, c = pcall(function() return replion:Get("Coins") end)
                if ok and type(c) == "number" then return c end
            end
            return 0
        end

        local function Kaitun_GetFishCount()
            local replion = GetPlayerDataReplion()
            if not replion then return 0 end
            local ok, inv = pcall(function() return replion:GetExpect("Inventory") end)
            if not ok or not inv or not inv.Items then return 0 end
            local count = 0
            for _, item in ipairs(inv.Items) do
                local hasWeight = item.Metadata and item.Metadata.Weight
                local isFish = item.Type == "Fish" or (item.Identifier and tostring(item.Identifier):lower():find("fish"))
                if hasWeight or isFish then count = count + 1 end
            end
            return count
        end

        local function Kaitun_HasRod(rodId)
            local replion = GetPlayerDataReplion()
            if not replion then return false end
            local ok, inv = pcall(function() return replion:GetExpect("Inventory") end)
            if not ok or not inv or not inv["Fishing Rods"] then return false end
            for _, rod in ipairs(inv["Fishing Rods"]) do
                if tonumber(rod.Id) == rodId or rod.Name == rodId or rod.Identifier == rodId then return true end
            end
            return false
        end

        local function Kaitun_EnsureRodEquipped()
            UB_init()
            local lp = Players.LocalPlayer
            local char = lp and lp.Character
            if not char then return end

            local held = char:FindFirstChildOfClass("Tool")
            if held then return end

            local replion = GetPlayerDataReplion()
            local rods = nil
            if replion then
                local ok, inv = pcall(function() return replion:GetExpect("Inventory") end)
                if ok and inv and inv["Fishing Rods"] then rods = inv["Fishing Rods"] end
            end

            if rods and #rods > 0 then
                local priority = {257, 169, 126, 5, 7, 6, 80, 4, 78, 77, 85, 76, 79, 1}
                local bestRod = nil
                for _, id in ipairs(priority) do
                    for _, r in ipairs(rods) do
                        if tonumber(r.Id) == id then bestRod = r; break end
                    end
                    if bestRod then break end
                end
                if not bestRod then bestRod = rods[1] end

                if bestRod and bestRod.UUID and Events.equipItemRemote then
                    pcall(function() Events.equipItemRemote:FireServer(bestRod.UUID, "Fishing Rods") end)
                    task.wait(0.2)
                end
            end

            pcall(function()
                if Events.equipToolRemote then Events.equipToolRemote:FireServer(1)
                elseif Events.equip then CallRemote(Events.equip, 1) end
            end)
            task.wait(0.2)
        end

        local function Kaitun_EquipRod(rodId)
            local replion = GetPlayerDataReplion()
            if not replion then return end
            local ok, inv = pcall(function() return replion:GetExpect("Inventory") end)
            if not ok or not inv or not inv["Fishing Rods"] then return end
            for _, rod in ipairs(inv["Fishing Rods"]) do
                if tonumber(rod.Id) == rodId or rod.Name == rodId or rod.Identifier == rodId then
                    if Events.equipItemRemote and rod.UUID then
                        pcall(function() Events.equipItemRemote:FireServer(rod.UUID, "Fishing Rods") end)
                        task.wait(0.2)
                        pcall(function()
                            if Events.equipToolRemote then Events.equipToolRemote:FireServer(1)
                            elseif Events.equip then CallRemote(Events.equip, 1) end
                        end)
                        return true
                    end
                end
            end
            return false
        end

        local function Kaitun_BuyRod(rodId)
            local r = GetServerRemote("RF/PurchaseFishingRod")
            if r then
                return pcall(function() r:InvokeServer(rodId) end)
            end
            return false
        end

        local function Kaitun_EnsureLocation(locationName)
            local targetPos = LOCATIONS[locationName]
            if not targetPos then return end
            local targetVector = typeof(targetPos) == "CFrame" and targetPos.Position or targetPos

            local hrp = getHRP()
            if not hrp then return end

            local dist = (hrp.Position - targetVector).Magnitude
            if dist > 20 then
                teleportTo(locationName)
                task.wait(0.8)
            end
        end

    local function Kaitun_StartLegitFishing()
    Config.AutoCatch = true
    Config.autoFishing = true
    Config.CatchDelay = _G.Kaitun.CatchDelay or 0.7
    Config.PerfectionEnchant = true
    Config.HookNotif = true
    Kaitun_EnsureRodEquipped()
    task.wait(0.1)
    pcall(function()
        local r = Events.UpdateAutoFishing or Events.update_auto_fishing or (Config.UB and Config.UB.Remotes and Config.UB.Remotes.UpdateAutoFishing) or GetServerRemote("RF/UpdateAutoFishingState")
        if r then
            if r:IsA("RemoteFunction") then
                task.spawn(function() pcall(r.InvokeServer, r, true) end)
            elseif r:IsA("RemoteEvent") then
                r:FireServer({ Active = true })
            end
        end
    end)
    pcall(function()
        local m = GetServerRemote("RF/MarkAutoFishingUsed") or GetServerRemote("RE/MarkAutoFishingUsed")
        if m then
            if m:IsA("RemoteFunction") then
                task.spawn(function() pcall(m.InvokeServer, m) end)
            elseif m:IsA("RemoteEvent") then
                m:FireServer()
            end
        end
    end)
    pcall(function()
        if Controllers.Fishing then
            if Controllers.Fishing.ToggleAutoFishing then
                Controllers.Fishing:ToggleAutoFishing(true)
            elseif Controllers.Fishing.StartAutoFishing then
                Controllers.Fishing:StartAutoFishing()
            elseif Controllers.Fishing.SetAutoFishing then
                Controllers.Fishing:SetAutoFishing(true)
            end
        end
    end)
    if not Tasks.legitFishingTask then
        Tasks.legitFishingTask = task.spawn(legit_fishing_loop)
    end
end

local function Kaitun_StopLegitFishing()
    Config.AutoCatch = false
    Config.autoFishing = false
    Config.PerfectionEnchant = false
    Config.HookNotif = false
    if Tasks.legitFishingTask then
        pcall(task.cancel, Tasks.legitFishingTask)
        Tasks.legitFishingTask = nil
    end
    pcall(function()
        local r = Events.UpdateAutoFishing or Events.update_auto_fishing or (Config.UB and Config.UB.Remotes and Config.UB.Remotes.UpdateAutoFishing) or GetServerRemote("RF/UpdateAutoFishingState")
        if r then
            if r:IsA("RemoteFunction") then
                task.spawn(function() pcall(r.InvokeServer, r, false) end)
            elseif r:IsA("RemoteEvent") then
                r:FireServer({ Active = false })
            end
        end
    end)
    pcall(function()
        if Controllers.Fishing then
            if Controllers.Fishing.ToggleAutoFishing then
                Controllers.Fishing:ToggleAutoFishing(false)
            elseif Controllers.Fishing.StopAutoFishing then
                Controllers.Fishing:StopAutoFishing()
            elseif Controllers.Fishing.SetAutoFishing then
                Controllers.Fishing:SetAutoFishing(false)
            end
        end
    end)
end

local function Kaitun_SellAll()
    Kaitun_StopLegitFishing()
    task.wait(0.2)
    local r = GetServerRemote("RF/SellAllItems")
    if r then
        local ok = pcall(function()
            if r:IsA("RemoteFunction") then
                r:InvokeServer()
            elseif r:IsA("RemoteEvent") then
                r:FireServer()
            end
        end)
        task.wait(0.3)
        _G.Kaitun.LastSellTime = tick()
        return ok
    end
    return false
end

        local function Kaitun_ShouldSell()
            if _G.Kaitun.AutoSell == false then return false end
            local count = Kaitun_GetFishCount()
            if count <= 0 then return false end
            if _G.Kaitun.SellMethod == "Berdasarkan Timer Interval (detik)" then
                local elapsed = tick() - (_G.Kaitun.LastSellTime or 0)
                return elapsed >= (_G.Kaitun.SellInterval or 60)
            else
                return count >= (_G.Kaitun.SellThreshold or 15)
            end
        end

        local function UpdateKaitunUI()
            local elapsed = _G.Kaitun.StartTime > 0 and math.floor(tick() - _G.Kaitun.StartTime) or 0
            local hrs = math.floor(elapsed / 3600)
            local mins = math.floor((elapsed % 3600) / 60)
            local secs = elapsed % 60
            local timeFormatted = string.format("%02d:%02d:%02d", hrs, mins, secs)

            local currentCoins = Kaitun_GetCoins()
            local currentFish = Kaitun_GetFishCount()
            local currentRodName = "Starter"
            if Kaitun_HasRod(257) then currentRodName = "Element"
            elseif Kaitun_HasRod(169) then currentRodName = "Ghostfin"
            elseif Kaitun_HasRod(77) then currentRodName = "Demascus"
            elseif Kaitun_HasRod(76) then currentRodName = "Carbon"
            elseif Kaitun_HasRod(79) then currentRodName = "Luck" end

            if KaitunOverlay.CoinsVal then KaitunOverlay.CoinsVal.Text = tostring(currentCoins) end
            if KaitunOverlay.RodVal then KaitunOverlay.RodVal.Text = currentRodName end
            if KaitunOverlay.FishVal then KaitunOverlay.FishVal.Text = tostring(currentFish) end
            if KaitunOverlay.TimerVal then KaitunOverlay.TimerVal.Text = timeFormatted end

            if KaitunOverlay.StageBadge then
                local sNames = {
                    [1] = "STAGE 1: STARTER",
                    [2] = "STAGE 2: GEAR & DIVING",
                    [3] = "STAGE 3: GHOSTFIN QUEST",
                    [4] = "STAGE 4: ELEMENT QUEST",
                    [5] = "STAGE 5: DUAL ENCHANT",
                    [6] = "STAGE MAX: COMPLETED"
                }
                KaitunOverlay.StageBadge.Text = sNames[_G.Kaitun.Stage] or "RUNNING"
            end

            if KaitunOverlay.GoalLabel then
                KaitunOverlay.GoalLabel.Text = _G.Kaitun.SubStatus
            end

            if KaitunOverlay.ProgressFill then
                local pct = math.clamp(_G.Kaitun.ProgressPct or 0, 0, 100) / 100
                KaitunOverlay.ProgressFill.Size = UDim2.new(pct, 0, 1, 0)
            end
        end

        local function RunAutoKaitunLoop()
            UB_init()
            Kaitun_AddLog("Auto Kaitun Engine Dimulai!")
            Kaitun_EnsureRodEquipped()
            _G.Kaitun.LastSellTime = tick()

            while _G.Kaitun.Active do
                task.wait(0.3)
                local currentCoins = Kaitun_GetCoins()

                if Kaitun_HasRod(257) then
                    _G.Kaitun.Stage = 5
                elseif Kaitun_HasRod(169) then
                    _G.Kaitun.Stage = 4
                elseif (Kaitun_HasRod(77) or Kaitun_HasRod(4) or Kaitun_HasRod(80)) and currentCoins >= 75000 then
                    _G.Kaitun.Stage = 3
                elseif Kaitun_HasRod(76) or Kaitun_HasRod(79) or Kaitun_HasRod(77) or Kaitun_HasRod(4) or Kaitun_HasRod(80) then
                    _G.Kaitun.Stage = 2
                else
                    _G.Kaitun.Stage = 1
                end

                if _G.Kaitun.Stage == 1 then
                    _G.Kaitun.Status = "STAGE 1: STARTER FARMING"
                    _G.Kaitun.SubStatus = string.format("🎯 Farming Coins: %d / 5,000", currentCoins)
                    _G.Kaitun.ProgressPct = math.clamp((currentCoins / 5000) * 100, 0, 100)
                    UpdateKaitunUI()

                    if currentCoins >= 5000 then
                        Kaitun_StopLegitFishing()
                        local chosenRodId = _G.Kaitun.StarterRod == "Luck Rod" and 79 or 76
                        local chosenRodName = _G.Kaitun.StarterRod == "Luck Rod" and "Luck Rod" or "Carbon Rod"
                        Kaitun_AddLog("Koin cukup! Membeli " .. chosenRodName .. "...")
                        Kaitun_BuyRod(chosenRodId)
                        task.wait(1)
                        Kaitun_EquipRod(chosenRodId)
                        Kaitun_AddLog(chosenRodName .. " berhasil dipasang!")
                    else
                        Kaitun_EnsureLocation(_G.Kaitun.Stage1Loc or "Fisherman")
                        Kaitun_StartLegitFishing()
                        for sec = 1, 8 do
                            if not _G.Kaitun.Active then break end
                            task.wait(1)
                            if Kaitun_ShouldSell() or Kaitun_GetCoins() >= 5000 then break end
                        end
                        if Kaitun_ShouldSell() then
                            Kaitun_StopLegitFishing()
                            Kaitun_AddLog("Menjual ikan di Merchant...")
                            Kaitun_SellAll()
                            task.wait(0.5)
                            Kaitun_EnsureLocation(_G.Kaitun.Stage1Loc or "Fisherman")
                            Kaitun_StartLegitFishing()
                        end
                    end
                elseif _G.Kaitun.Stage == 2 then
                    _G.Kaitun.Status = "STAGE 2: MID-GAME FARMING"
                    _G.Kaitun.SubStatus = string.format("🎯 Farming Koin & Upgrade Rod: %d / 75,000", currentCoins)
                    _G.Kaitun.ProgressPct = math.clamp((currentCoins / 75000) * 100, 0, 100)
                    UpdateKaitunUI()

                    if currentCoins >= 3000 and not Kaitun_HasRod(77) then
                        Kaitun_StopLegitFishing()
                        Kaitun_BuyRod(77)
                        task.wait(0.5)
                        Kaitun_EquipRod(77)
                        Kaitun_AddLog("Demascus Rod berhasil dibeli!")
                    end

                    if currentCoins >= 15000 and not Kaitun_HasRod(4) then
                        Kaitun_StopLegitFishing()
                        Kaitun_BuyRod(4)
                        task.wait(0.5)
                        Kaitun_EquipRod(4)
                        Kaitun_AddLog("Lucky Rod (15k) berhasil dibeli! Luck meningkat.")
                    end

                    if currentCoins >= 50000 and not Kaitun_HasRod(80) then
                        Kaitun_StopLegitFishing()
                        Kaitun_BuyRod(80)
                        task.wait(0.5)
                        Kaitun_EquipRod(80)
                        Kaitun_AddLog("Midnight Rod (50k) berhasil dibeli! Siap untuk Ghostfin Quest.")
                    end

                    if currentCoins >= 75000 and (Kaitun_HasRod(77) or Kaitun_HasRod(4) or Kaitun_HasRod(80)) then
                        Kaitun_StopLegitFishing()
                        Kaitun_AddLog("Target 75k koin tercapai & Rod siap! Menuju Ghostfin Quest...")
                        _G.Kaitun.Stage = 3
                    else
                        Kaitun_EnsureLocation(_G.Kaitun.Stage2Loc or "Coral Reefs")
                        Kaitun_StartLegitFishing()
                        for sec = 1, 10 do
                            if not _G.Kaitun.Active then break end
                            task.wait(1)
                            if Kaitun_ShouldSell() or (Kaitun_GetCoins() >= 75000 and (Kaitun_HasRod(77) or Kaitun_HasRod(4) or Kaitun_HasRod(80))) then break end
                        end
                        if Kaitun_ShouldSell() then
                            Kaitun_StopLegitFishing()
                            Kaitun_SellAll()
                            task.wait(0.5)
                            Kaitun_EnsureLocation(_G.Kaitun.Stage2Loc or "Coral Reefs")
                            Kaitun_StartLegitFishing()
                        end
                    end
                elseif _G.Kaitun.Stage == 3 then
                    _G.Kaitun.Status = "STAGE 3: GHOSTFIN ROD QUEST"

                    if Kaitun_HasRod(169) then
                        Kaitun_StopLegitFishing()
                        Kaitun_AddLog("Ghostfin Rod OWNED! Menuju Element Quest...")
                        _G.Kaitun.Stage = 4
                    else
                        local sisyphusDone = (_G.Ghostfin_SecretCaught or 0) >= 1 and (_G.Ghostfin_MythicCaught or 0) >= 3
                        local treasureDone = (_G.Ghostfin_RareEpicCaught or 0) >= 300
                        local targetLoc = "Sisyphus Statue"

                        if not sisyphusDone then
                            targetLoc = "Sisyphus Statue"
                            _G.Kaitun.SubStatus = string.format("🎯 Sisyphus Statue: %d/1 Secret | %d/3 Mythic", _G.Ghostfin_SecretCaught or 0, _G.Ghostfin_MythicCaught or 0)
                            _G.Kaitun.ProgressPct = math.clamp((((_G.Ghostfin_SecretCaught or 0) + (_G.Ghostfin_MythicCaught or 0)) / 4) * 45, 0, 45)
                        elseif not treasureDone then
                            targetLoc = "Treasure Room"
                            _G.Kaitun.SubStatus = string.format("🎯 Treasure Room: %d/300 Rare/Epic", _G.Ghostfin_RareEpicCaught or 0)
                            _G.Kaitun.ProgressPct = 45 + math.clamp(((_G.Ghostfin_RareEpicCaught or 0) / 300) * 45, 0, 45)
                        else
                            targetLoc = "Treasure Room"
                            _G.Kaitun.SubStatus = string.format("🎯 Farming 1M Koin Ghostfin: %d / 1,000,000", currentCoins)
                            _G.Kaitun.ProgressPct = 90 + math.clamp((currentCoins / 1000000) * 10, 0, 10)

                            if currentCoins >= 1000000 then
                                Kaitun_StopLegitFishing()
                                Kaitun_AddLog("1M Coins tercapai! Membeli Ghostfin Rod...")
                                Kaitun_BuyRod(169)
                                task.wait(1)
                                Kaitun_EquipRod(169)
                                if Kaitun_HasRod(169) then
                                    Kaitun_AddLog("Ghostfin Rod BERHASIL DIDAPATKAN!")
                                    _G.Kaitun.Stage = 4
                                end
                            end
                        end
                        UpdateKaitunUI()

                        if _G.Kaitun.Stage == 3 then
                            Kaitun_EnsureLocation(targetLoc)
                            Kaitun_StartLegitFishing()
                            for sec = 1, 10 do
                                if not _G.Kaitun.Active then break end
                                task.wait(1)
                                if Kaitun_ShouldSell() or Kaitun_HasRod(169) then break end
                            end
                            if Kaitun_ShouldSell() then
                                Kaitun_StopLegitFishing()
                                Kaitun_SellAll()
                                task.wait(0.5)
                                Kaitun_EnsureLocation(targetLoc)
                                Kaitun_StartLegitFishing()
                            end
                        end
                    end
                elseif _G.Kaitun.Stage == 4 then
                    _G.Kaitun.Status = "STAGE 4: ELEMENT ROD QUEST"
                    _G.Kaitun.SubStatus = "🎯 Ancient Jungle -> Sacred Temple -> Altar"
                    _G.Kaitun.ProgressPct = 85
                    UpdateKaitunUI()

                    if Kaitun_HasRod(257) then
                        Kaitun_StopLegitFishing()
                        Kaitun_AddLog("ELEMENT ROD CLAIMED! Menuju Dual Enchant...")
                        _G.Kaitun.Stage = 5
                    else
                        Kaitun_EnsureLocation(_G.Kaitun.Stage4Loc or "Ancient Jungle")
                        Kaitun_StartLegitFishing()
                        for sec = 1, 10 do
                            if not _G.Kaitun.Active then break end
                            task.wait(1)
                            if Kaitun_ShouldSell() or Kaitun_HasRod(257) then break end
                        end
                        if Kaitun_ShouldSell() then
                            Kaitun_StopLegitFishing()
                            Kaitun_SellAll()
                            task.wait(0.5)
                            Kaitun_EnsureLocation(_G.Kaitun.Stage4Loc or "Ancient Jungle")
                            Kaitun_StartLegitFishing()
                        end
                    end
                elseif _G.Kaitun.Stage == 5 then
                    _G.Kaitun.Status = "STAGE 5: DUAL ENCHANTMENT"
                    _G.Kaitun.SubStatus = "🎯 Rolling Slot 1 & 2 Altar..."
                    _G.Kaitun.ProgressPct = 95
                    UpdateKaitunUI()

                    Kaitun_StopLegitFishing()
                    Kaitun_AddLog("Menuju Altar untuk Enchanting...")
                    Kaitun_EnsureLocation(_G.Kaitun.Stage5Loc or "Esoteric Depths")
                    task.wait(1.5)
                    _G.Kaitun.Stage = 6
                    _G.Kaitun.Status = "STAGE MAX: COMPLETED!"
                    _G.Kaitun.SubStatus = "Semua target Kaitun telah selesai!"
                    _G.Kaitun.ProgressPct = 100
                    UpdateKaitunUI()
                    Kaitun_AddLog("🎉 KAITUN COMPLETED! Akun sudah max rod!")
                    break
                end
            end
        end

        local Section_KaitunTab_1 = KaitunTab:AddSection("Auto Kaitun (1-Click Progression)")

        local KaitunParagraph = Section_KaitunTab_1:AddParagraph({
            Title = "Auto Kaitun Live Monitor",
            Content = "Status: <font color='#84B4B4'>IDLE / READY</font>\nStage: <font color='#00BFFF'>Stage 1: Starter Farming</font>\nTarget: <font color='#FFD700'>Element Rod (Endgame)</font>\nCoins: <font color='#39FF14'>0</font>\nRuntime: <font color='#B4B4B4'>00:00:00</font>"
        })

        task.spawn(function()
            while task.wait(0.5) do
                pcall(function()
                    if _G.Kaitun.Active then
                        UpdateKaitunUI()
                    end
                    if KaitunParagraph then
                        local elapsed = _G.Kaitun.StartTime > 0 and math.floor(tick() - _G.Kaitun.StartTime) or 0
                        local hrs = math.floor(elapsed / 3600)
                        local mins = math.floor((elapsed % 3600) / 60)
                        local secs = elapsed % 60
                        local timeStr = string.format("%02d:%02d:%02d", hrs, mins, secs)

                        local statusColor = _G.Kaitun.Active and "#39FF14" or "#84B4B4"
                        local statusText = _G.Kaitun.Active and "RUNNING" or "IDLE / STOPPED"
                        local currentCoins = Kaitun_GetCoins()
                        local currentFish = Kaitun_GetFishCount()

                        local content = string.format("Status: <font color='%s'>%s</font>\nStage: <font color='#00BFFF'>Stage %d/5 (%s)</font>\nObjective: <font color='#FFD700'>%s</font>\nCoins: <font color='#39FF14'>%d Coins</font> | Fish: <font color='#00FFFF'>%d</font>\nRuntime: <font color='#FFFFFF'>%s</font>",
                            statusColor, statusText, _G.Kaitun.Stage, _G.Kaitun.Status, _G.Kaitun.SubStatus, currentCoins, currentFish, timeStr
                        )
                        UpdateParagraph(KaitunParagraph, content)
                    end
                end)
            end
        end)

        Section_KaitunTab_1:AddToggle("Toggle_EnableAutoKaitun", {
            Title = "Enable Auto Kaitun",
            Description = "Jalankan otomatisasi akun dari pemula sampai endgame",
            Default = false,
            Callback = function(val)
                _G.Kaitun.Active = val
                if val then
                    InitKaitunOverlay()
                    if _G.Kaitun.DarkOverlay and KaitunOverlay.Gui then
                        KaitunOverlay.Gui.Enabled = true
                    end
                    _G.Kaitun.StartTime = tick()
                    _G.Kaitun.Thread = task.spawn(RunAutoKaitunLoop)
                    NotifySuccess("Auto Kaitun", "Engine Auto Kaitun Dimulai!")
                else
                    if _G.Kaitun.Thread then pcall(function() task.cancel(_G.Kaitun.Thread) end); _G.Kaitun.Thread = nil end
                    if KaitunOverlay.Gui then KaitunOverlay.Gui.Enabled = false end
                    Kaitun_StopLegitFishing()
                    _G.Kaitun.Status = "IDLE / STOPPED"
                    NotifyWarning("Auto Kaitun", "Engine Auto Kaitun Dihentikan.")
                end
            end
        })

        Section_KaitunTab_1:AddDropdown("Dropdown_KaitunTargetRod", {
            Title = "Target Final Rod",
            Description = "Pilih target rod tertinggi yang ingin dicapai",
            Values = {"Element Rod (Endgame)", "Ghostfin Rod (Mythic)", "Demascus Rod (Mid)", "Carbon Rod (Early)"},
            Default = "Element Rod (Endgame)",
            Callback = function(val)
                _G.Kaitun.TargetRod = val
            end,
            Multi = false
        })

        Section_KaitunTab_1:AddToggle("Toggle_KaitunDarkOverlay", {
            Title = "Dark AFK Screen Saver",
            Description = "Tampilkan layar gelap penghemat daya saat Kaitun aktif",
            Default = true,
            Callback = function(val)
                _G.Kaitun.DarkOverlay = val
                if KaitunOverlay.Gui and _G.Kaitun.Active then
                    KaitunOverlay.Gui.Enabled = val
                end
            end
        })

        Section_KaitunTab_1:AddButton({
            Title = "Open / Close Dark AFK Overlay",
            Callback = function()
                InitKaitunOverlay()
                if KaitunOverlay.Gui then
                    KaitunOverlay.Gui.Enabled = not KaitunOverlay.Gui.Enabled
                end
            end
        })

        local Section_KaitunTab_2 = KaitunTab:AddSection("Stage Controls & Manual Override")

        Section_KaitunTab_2:AddButton({
            Title = "Force Re-Check Inventory & Stage",
            Callback = function()
                NotifyInfo("Auto Kaitun", "Memindai inventory...")
                local coins = Kaitun_GetCoins()
                if Kaitun_HasRod(257) then _G.Kaitun.Stage = 5
                elseif Kaitun_HasRod(169) then _G.Kaitun.Stage = 4
                elseif Kaitun_HasRod(77) or coins >= 75000 then _G.Kaitun.Stage = 3
                elseif Kaitun_HasRod(76) or Kaitun_HasRod(79) then _G.Kaitun.Stage = 2
                else _G.Kaitun.Stage = 1 end
                NotifySuccess("Auto Kaitun", "Stage diatur ke: Stage " .. _G.Kaitun.Stage)
            end
        })

        Section_KaitunTab_2:AddButton({
            Title = "Skip to Stage 1 (Starter Farming)",
            Callback = function()
                _G.Kaitun.Stage = 1
                NotifyInfo("Auto Kaitun", "Stage disetel ke Stage 1")
            end
        })

        Section_KaitunTab_2:AddButton({
            Title = "Skip to Stage 2 (Mid-Game Economy)",
            Callback = function()
                _G.Kaitun.Stage = 2
                NotifyInfo("Auto Kaitun", "Stage disetel ke Stage 2")
            end
        })

        Section_KaitunTab_2:AddButton({
            Title = "Skip to Stage 3 (Ghostfin Quest)",
            Callback = function()
                _G.Kaitun.Stage = 3
                NotifyInfo("Auto Kaitun", "Stage disetel ke Stage 3")
            end
        })

        Section_KaitunTab_2:AddButton({
            Title = "Skip to Stage 4 (Element Quest)",
            Callback = function()
                _G.Kaitun.Stage = 4
                NotifyInfo("Auto Kaitun", "Stage disetel ke Stage 4")
            end
        })

        Section_KaitunTab_2:AddButton({
            Title = "Skip to Stage 5 (Dual Enchant)",
            Callback = function()
                _G.Kaitun.Stage = 5
                NotifyInfo("Auto Kaitun", "Stage disetel ke Stage 5")
            end
        })

        local Section_KaitunTab_3 = KaitunTab:AddSection("Kaitun Settings & Config")

        Section_KaitunTab_3:AddDropdown("Dropdown_StarterRodChoice", {
            Title = "Pilihan Rod Awal (Stage 1)",
            Values = {"Carbon Rod (Recommended)", "Luck Rod"},
            Default = "Carbon Rod (Recommended)",
            Callback = function(val)
                _G.Kaitun.StarterRod = val:find("Luck") and "Luck Rod" or "Carbon Rod"
            end,
            Multi = false
        })

        Section_KaitunTab_3:AddDropdown("MultiDropdown_TargetEnchantsKaitun", {
            Title = "Target Enchant Slot 1 & 2",
            Values = {"Leprechaun II", "Mutation Hunter II", "Perfection", "Cursed I", "Prismatic I", "Empowered I"},
            Default = {"Leprechaun II", "Mutation Hunter II", "Perfection"},
            Callback = function(vals)
                _G.Kaitun.SelectedEnchants = vals or {}
            end,
            Multi = true
        })

        Section_KaitunTab_3:AddDropdown("Dropdown_Stage1Location", {
            Title = "Lokasi Farming Stage 1",
            Values = {"Fisherman", "Tropical Grove", "Kohana", "Pirate Cove"},
            Default = "Fisherman",
            Callback = function(val) _G.Kaitun.Stage1Loc = val end,
            Multi = false
        })

        Section_KaitunTab_3:AddDropdown("Dropdown_Stage2Location", {
            Title = "Lokasi Farming Stage 2",
            Values = {"Coral Reefs", "Crater Island 1", "Kohana Volcano", "Weather Machine"},
            Default = "Coral Reefs",
            Callback = function(val) _G.Kaitun.Stage2Loc = val end,
            Multi = false
        })

        Section_KaitunTab_3:AddDropdown("Dropdown_Stage3Location", {
            Title = "Lokasi Quest Stage 3",
            Values = {"Sisyphus Statue", "Treasure Room"},
            Default = "Sisyphus Statue",
            Callback = function(val) _G.Kaitun.Stage3Loc = val end,
            Multi = false
        })

        Section_KaitunTab_3:AddDropdown("Dropdown_Stage4Location", {
            Title = "Lokasi Quest Stage 4",
            Values = {"Ancient Jungle", "Sacred Temple", "Underground Cellar", "Ancient Ruins"},
            Default = "Ancient Jungle",
            Callback = function(val) _G.Kaitun.Stage4Loc = val end,
            Multi = false
        })

        local Section_KaitunTab_AutoSell = KaitunTab:AddSection("Auto Sell Settings (Kaitun)")

        Section_KaitunTab_AutoSell:AddToggle("Toggle_KaitunAutoSell", {
            Title = "Enable Auto Sell (Kaitun)",
            Description = "Otomatis menjual ikan ke Merchant saat syarat terpenuhi",
            Default = true,
            Callback = function(val)
                _G.Kaitun.AutoSell = val
                NotifyInfo("Auto Sell", val and "Auto Sell DIAKTIFKAN" or "Auto Sell DINONAKTIFKAN")
            end
        })

        Section_KaitunTab_AutoSell:AddDropdown("Dropdown_KaitunSellMethod", {
            Title = "Metode Auto Sell",
            Description = "Pilih acuan pemicu penjualan otomatis",
            Values = {"Berdasarkan Jumlah Ikan di Tas", "Berdasarkan Timer Interval (detik)"},
            Default = "Berdasarkan Jumlah Ikan di Tas",
            Callback = function(val)
                _G.Kaitun.SellMethod = val
            end,
            Multi = false
        })

        Section_KaitunTab_AutoSell:AddDropdown("Dropdown_KaitunSellThresholdPreset", {
            Title = "Preset Batas Jumlah Ikan (Template)",
            Description = "Kapasitas tas siap pakai untuk memicu sell",
            Values = {"5 Ikan (Fast Cash)", "10 Ikan", "15 Ikan (Recommended)", "20 Ikan", "25 Ikan", "30 Ikan", "50 Ikan (Big Bag)"},
            Default = "15 Ikan (Recommended)",
            Callback = function(val)
                local num = tonumber(val:match("%d+"))
                if num then
                    _G.Kaitun.SellThreshold = num
                    NotifyInfo("Auto Sell", "Batas ikan diatur ke: " .. tostring(num) .. " ikan")
                end
            end,
            Multi = false
        })

        Section_KaitunTab_AutoSell:AddInput("Input_KaitunCustomSellThreshold", {
            Title = "Custom Batas Jumlah Ikan",
            Placeholder = "15",
            Default = "15",
            Callback = function(text)
                local num = tonumber(text)
                if num and num > 0 then
                    _G.Kaitun.SellThreshold = math.clamp(num, 1, 500)
                    NotifyInfo("Auto Sell", "Custom threshold: " .. tostring(_G.Kaitun.SellThreshold) .. " ikan")
                end
            end,
            Finished = true
        })

        Section_KaitunTab_AutoSell:AddDropdown("Dropdown_KaitunSellTimerPreset", {
            Title = "Preset Timer Interval (Template)",
            Description = "Waktu tunggu berkala sebelum menjual ikan",
            Values = {"30 detik", "60 detik (1 Menit)", "120 detik (2 Menit)", "300 detik (5 Menit)"},
            Default = "60 detik (1 Menit)",
            Callback = function(val)
                local num = tonumber(val:match("%d+"))
                if num then
                    _G.Kaitun.SellInterval = num
                    NotifyInfo("Auto Sell", "Interval timer diatur ke: " .. tostring(num) .. " detik")
                end
            end,
            Multi = false
        })

        Section_KaitunTab_AutoSell:AddInput("Input_KaitunCustomSellTimer", {
            Title = "Custom Timer Interval (detik)",
            Placeholder = "60",
            Default = "60",
            Callback = function(text)
                local num = tonumber(text)
                if num and num > 0 then
                    _G.Kaitun.SellInterval = math.clamp(num, 5, 3600)
                    NotifyInfo("Auto Sell", "Custom interval: " .. tostring(_G.Kaitun.SellInterval) .. "s")
                end
            end,
            Finished = true
        })

        Section_KaitunTab_AutoSell:AddButton({
            Title = "Sell All Fish Now (Manual Instant)",
            Description = "Jual semua isi tas ikan ke Merchant sekarang juga",
            Callback = function()
                task.spawn(function()
                    local ok = Kaitun_SellAll()
                    if ok then
                        NotifySuccess("Auto Sell", "Semua ikan berhasil dijual!")
                    else
                        NotifyWarning("Auto Sell", "Gagal menjual atau tas kosong.")
                    end
                end)
            end
        })

        local Section_KaitunTab_Legit = KaitunTab:AddSection("Legit Fishing Settings (Kaitun)")

        Section_KaitunTab_Legit:AddDropdown("Dropdown_KaitunCatchDelayPreset", {
            Title = "Preset Template Catch Delay (detik)",
            Description = "Pilih kecepatan delay mancing legit siap pakai",
            Values = {"2.0 detik", "1.5 detik", "1.0 detik", "0.8 detik", "0.7 detik (Default)", "0.5 detik"},
            Default = "0.7 detik (Default)",
            Callback = function(val)
                local num = tonumber(val:match("[%d%.]+"))
                if num then
                    _G.Kaitun.CatchDelay = num
                    NotifyInfo("Legit Fishing", "Catch Delay diatur ke: " .. tostring(num) .. " detik")
                end
            end,
            Multi = false
        })

        Section_KaitunTab_Legit:AddInput("Input_KaitunCustomCatchDelay", {
            Title = "Custom Catch Delay (detik)",
            Placeholder = "0.7",
            Default = "0.7",
            Callback = function(text)
                local num = tonumber(text)
                if num and num > 0 then
                    _G.Kaitun.CatchDelay = math.clamp(num, 0.05, 10)
                    NotifyInfo("Legit Fishing", "Custom Catch Delay: " .. tostring(_G.Kaitun.CatchDelay) .. "s")
                end
            end,
            Finished = true
        })

        Section_KaitunTab_Legit:AddDropdown("Dropdown_KaitunCatchQuality", {
            Title = "Catch Quality Rating",
            Description = "Kualitas hasil tangkapan minigame",
            Values = {"Perfect", "Good", "Normal"},
            Default = "Perfect",
            Callback = function(val)
                _G.Kaitun.CatchQuality = val
            end,
            Multi = false
        })
    end)
end

if MainTab then
    pcall(function()
        local Section_MainTab_2 = MainTab:AddSection("Auto Enchant")

        local enchantParagraph = Section_MainTab_2:AddParagraph({
            Title = "Enchant Status",
            Content = "Rod Active = <font color='#FFB6C1'>None</font>\nEnchant Now = <font color='#87CEEB'>None</font>\nBasic Stone = <font color='#FFD700'>0</font>\nEvolved Stone = <font color='#00FF7F'>0</font>\nStone Type = <font color='#DDA0DD'>" .. _G.SelectedStoneType .. "</font>"
        })

        task.spawn(function()
            local lastRod, lastEnchant, lastBasicStones, lastEvolvedStones, lastType = "", "", -1, -1, ""
            while task.wait(2) do
                pcall(function()
                    local basicStones = gStone()
                    local evolvedStones = gEvolvedStone()
                    local rod = getEquippedRodName()
                    local enchantId = getCurrentRodEnchant()
                    local enchantName = "None"

                    if enchantId then
                        for name, id in pairs(enchantIdMap) do
                            if id == enchantId then
                                enchantName = name
                                break
                            end
                        end
                    end

                    if rod ~= lastRod or enchantName ~= lastEnchant or basicStones ~= lastBasicStones or evolvedStones ~= lastEvolvedStones or _G.SelectedStoneType ~= lastType then
                        SafeUpdateParagraph(enchantParagraph, string.format(
                            "Rod Active = <font color='#FFB6C1'>%s</font>\n" ..
                            "Enchant Now = <font color='#87CEEB'>%s</font>\n" ..
                            "Basic Stone = <font color='#FFD700'>%d</font>\n" ..
                            "Evolved Stone = <font color='#00FF7F'>%d</font>\n" ..
                            "Stone Type = <font color='#DDA0DD'>%s</font>",
                            rod, enchantName, basicStones, evolvedStones, _G.SelectedStoneType
                        ))
                        lastRod, lastEnchant, lastBasicStones, lastEvolvedStones, lastType = rod, enchantName, basicStones, evolvedStones, _G.SelectedStoneType
                    end
                end)
            end
        end)

        local stoneTypeValues = {"Enchant Stones", "Evolved Enchant Stone"}
        Section_MainTab_2:AddDropdown("Dropdown_EnchantStoneType", { Title = "Enchant Stone Type", Values = stoneTypeValues, Default = stoneTypeValues[1],  Callback = function(val) _G.SelectedStoneType = val end, Multi = false })

        local basicEnchantValues = {"Big Hunter 1", "Cursed 1", "Empowered 1", "Glistening 1", "Gold Digger 1", "Leprechaun 1", "Leprechaun 2", "Mutation Hunter 1", "Mutation Hunter 2", "Prismatic 1", "Reeler 1", "Stargazer 1", "Stormhunter 1", "XPerienced 1"}
        Section_MainTab_2:AddDropdown("Dropdown_TargetEnchantBasicStones", { Title = "Target Enchant (Basic Stones)", Values = basicEnchantValues, Default = basicEnchantValues[1],  Callback = function(val) _G.TargetEnchantBasic = val end, Multi = false })

        local evolvedEnchantValues = {"Prismatic 1", "Cursed 1", "Gold Digger 1", "Empowered 1", "SECRET Hunter", "Shark Hunter", "Stargazer II", "Stormhunter II", "Mutation Hunter II", "Leprechaun II", "Reeler II", "Mutation Hunter III", "Fairy Hunter 1"}
        Section_MainTab_2:AddDropdown("Dropdown_TargetEnchantEvolvedStones", { Title = "Target Enchant (Evolved Stones)", Values = evolvedEnchantValues, Default = evolvedEnchantValues[1],  Callback = function(val) _G.TargetEnchantEvolved = val end, Multi = false })

        Section_MainTab_2:AddToggle("Toggle_AutoEnchant", {
            Title = "Auto Enchant", Default = false,
            Callback = function(val)
                _G.AutoEnchant = val
                if val then
                    task.spawn(function()
                        while _G.AutoEnchant do
                            pcall(function()
                                local targetEnchant = (_G.SelectedStoneType == "Evolved Enchant Stone")
                                    and _G.TargetEnchantEvolved
                                    or _G.TargetEnchantBasic

                                local currentId = getCurrentRodEnchant()
                                local targetId = enchantIdMap[targetEnchant]

                                if currentId == targetId then
                                    _G.AutoEnchant = false
                                    Fluent:Notify({
                                        Title = "Auto Enchant",
                                        Content = "Target Tercapai: " .. targetEnchant,
                                        Duration = 5
                                    })
                                    return
                                end

                                local stones = findEnchantStones()
                                if #stones > 0 then
                                    Events.equipItemRemote:FireServer(stones[1].UUID, "Enchant Stones")
                                    task.wait(0.8)

                                    local slot = countDisplayImageButtons() - 2
                                    if slot < 1 then slot = 1 end

                                    Events.equipToolRemote:FireServer(slot)
                                    task.wait(0.8)
                                    Events.activateAltar:FireServer()
                                end
                            end)
                            task.wait(4)
                        end
                    end)
                end
            end
        })

        Section_MainTab_2:AddButton({ Title = "Teleport to Altar (Main)", Callback = function() teleportTo("Enchanting Altar"); NotifySuccess("Teleport", "Teleported to Enchanting Altar!") end })

        local Section_MainTab_3 = MainTab:AddSection("Second Enchant (Transcended)")

        local TRANSCENDED_STONE_ID = 246
        local SECOND_ALTAR_POS = Vector3.new(1479.587, 128.295, -604.224)
        local SECOND_ALTAR_LOOK = Vector3.new(-0.298, 0.000, -0.955)

        local ENCHANT_ROD_LIST = {
            {Name = "Luck Rod", ID = 79}, {Name = "Carbon Rod", ID = 76}, {Name = "Grass Rod", ID = 85},
            {Name = "Demascus Rod", ID = 77}, {Name = "Ice Rod", ID = 78}, {Name = "Lucky Rod", ID = 4},
            {Name = "Midnight Rod", ID = 80}, {Name = "Steampunk Rod", ID = 6}, {Name = "Chrome Rod", ID = 7},
            {Name = "Flourescent Rod", ID = 255}, {Name = "Astral Rod", ID = 5}, {Name = "Ares Rod", ID = 126},
            {Name = "Angler Rod", ID = 168}, {Name = "Ghostfin Rod", ID = 169}, {Name = "Element Rod", ID = 257},
            {Name = "Hazmat Rod", ID = 256}, {Name = "Bamboo Rod", ID = 258}
        }

        local ENCHANT2_MAPPING = {
            ["Cursed I"] = 12, ["Big Hunter I"] = 3, ["Empowered I"] = 9, ["Glistening I"] = 1,
            ["Gold Digger I"] = 4, ["Leprechaun I"] = 5, ["Leprechaun II"] = 6,
            ["Mutation Hunter I"] = 7, ["Mutation Hunter II"] = 14, ["Perfection"] = 15,
            ["Prismatic I"] = 13, ["Reeler I"] = 2, ["Stargazer I"] = 8,
            ["Stormhunter I"] = 11, ["Experienced I"] = 10,
        }
        local ENCHANT2_NAMES = {}
        for name, _ in pairs(ENCHANT2_MAPPING) do table.insert(ENCHANT2_NAMES, name) end

        local _G_SecondEnchant = {
            selectedRodUUID = nil,
            selectedEnchantNames = {},
            selectedSecretFish = {},
            targetStoneAmount = 1,
            makeStoneState = false,
            secondEnchantState = false,
            makeStoneThread = nil,
            secondEnchantThread = nil,
            tradeDelay = 1.0,
            secretFishUUIDMap = {},
        }

        local function GetUUIDByRodID(targetID)
            local replion = GetPlayerDataReplion()
            if not replion then return nil end
            local ok, inv = pcall(function() return replion:GetExpect("Inventory") end)
            if not ok or not inv or not inv["Fishing Rods"] then return nil end
            for _, rod in ipairs(inv["Fishing Rods"]) do
                if tonumber(rod.Id) == targetID then return rod.UUID end
            end
            return nil
        end

        local function GetSecretFishOptions()
            local options = {}
            local uuidMap = {}
            local replion = GetPlayerDataReplion()
            if not replion then return options, uuidMap end
            local ok, inv = pcall(function() return replion:GetExpect("Inventory") end)
            if not ok or not inv or not inv.Items then return options, uuidMap end
            for _, item in ipairs(inv.Items) do
                local hasWeight = item.Metadata and item.Metadata.Weight
                local isFishType = item.Type == "Fish" or (item.Identifier and tostring(item.Identifier):lower():find("fish"))
                if not hasWeight and not isFishType then continue end
                local _, rarity = GetFishNameAndRarity(item)
                if not rarity or rarity:upper() ~= "SECRET" then continue end
                local name = item.Identifier or "Unknown"
                if ItemUtility then
                    local itemData = ItemUtility:GetItemData(item.Id)
                    if itemData and itemData.Data and itemData.Data.Name then name = itemData.Data.Name end
                end
                if item.Metadata and item.Metadata.Weight then
                    name = string.format("%s (%.1fkg)", name, item.Metadata.Weight)
                end
                if item.IsFavorite or item.Favorited then name = name .. " [⭐]" end
                table.insert(options, name)
                uuidMap[name] = item.UUID
            end
            table.sort(options)
            return options, uuidMap
        end

        local function CheckIfSecondEnchantReached(rodUUID)
            local replion = GetPlayerDataReplion()
            if not replion then return true end
            local ok, inv = pcall(function() return replion:GetExpect("Inventory") end)
            if not ok or not inv or not inv["Fishing Rods"] then return true end
            local targetRod = nil
            for _, rod in ipairs(inv["Fishing Rods"]) do
                if rod.UUID == rodUUID then targetRod = rod; break end
            end
            if not targetRod then return true end
            local metadata = targetRod.Metadata or {}
            local currentEnchant2 = metadata.EnchantId2
            if not currentEnchant2 then return false end
            for _, targetName in ipairs(_G_SecondEnchant.selectedEnchantNames) do
                local targetID = ENCHANT2_MAPPING[targetName]
                if targetID and currentEnchant2 == targetID then return true end
            end
            return false
        end

        local function GetTranscendedStoneUUID()
            local replion = GetPlayerDataReplion()
            if not replion then return nil end
            local ok, inv = pcall(function() return replion:GetExpect("Inventory") end)
            if not ok or not inv or not inv.Items then return nil end
            for _, item in ipairs(inv.Items) do
                if tonumber(item.Id) == TRANSCENDED_STONE_ID and item.UUID then return item.UUID end
            end
            return nil
        end

        local function UnequipAllEquippedItems()
            local RE_UnequipItem = GetServerRemote("RE/UnequipItem")
            if not RE_UnequipItem then
                warn("[QH] RE/UnequipItem tidak ditemukan!")
                return
            end
            local replion = GetPlayerDataReplion()
            if not replion then return end
            local ok, equipped = pcall(function() return replion:GetExpect("EquippedItems") end)
            if ok and equipped then
                for _, uuid in ipairs(equipped) do
                    pcall(function() RE_UnequipItem:FireServer(uuid) end)
                    task.wait(0.05)
                end
            end
            local equippedSkin = replion:Get("EquippedSkinUUID")
            if equippedSkin and equippedSkin ~= "" then
                pcall(function() RE_UnequipItem:FireServer(equippedSkin) end)
                task.wait(0.1)
            end
        end

        local RF_CreateTranscendedStone = GetServerRemote("RF/CreateTranscendedStone")
        local RE_ActivateSecondEnchantingAltar = GetServerRemote("RE/ActivateSecondEnchantingAltar")

        local function RunMakeStoneLoop()
            if _G_SecondEnchant.makeStoneThread then
                pcall(function() task.cancel(_G_SecondEnchant.makeStoneThread) end)
            end
            _G_SecondEnchant.makeStoneThread = task.spawn(function()
                local createdCount = 0

                local hrp = getHRP()
                if hrp then
                    TeleportTo(CFrame.new(SECOND_ALTAR_POS, SECOND_ALTAR_POS + SECOND_ALTAR_LOOK) * CFrame.new(0, 0.5, 0))
                end
                task.wait(1)
                while _G_SecondEnchant.makeStoneState and createdCount < _G_SecondEnchant.targetStoneAmount do
                    local _, currentMap = GetSecretFishOptions()
                    local fishToSacrifice = nil
                    for name, uuid in pairs(currentMap) do
                        if table.find(_G_SecondEnchant.selectedSecretFish, name) then
                            fishToSacrifice = uuid
                            break
                        end
                    end
                    if not fishToSacrifice then
                        NotifyInfo("Make Stone", "Ikan target habis!")
                        break
                    end
                    NotifyInfo("Make Stone", "Sacrificing ikan...")
                    UnequipAllEquippedItems()
                    task.wait(0.3)
                    if Events.equipItemRemote then
                        pcall(function() Events.equipItemRemote:FireServer(fishToSacrifice, "Fish") end)
                    end
                    task.wait(0.5)
                    if Events.equipToolRemote then
                        pcall(function() Events.equipToolRemote:FireServer(2) end)
                    end
                    task.wait(0.8)
                    if RF_CreateTranscendedStone then
                        local ok = pcall(function() RF_CreateTranscendedStone:InvokeServer() end)
                        if ok then
                            createdCount = createdCount + 1
                            NotifySuccess("Make Stone", string.format("Stone %d/%d dibuat!", createdCount, _G_SecondEnchant.targetStoneAmount))
                        else
                            NotifyError("Make Stone", "Gagal buat stone!")
                        end
                    else
                        NotifyError("Make Stone", "Remote CreateTranscendedStone tidak ditemukan!")
                        break
                    end
                    task.wait(1.5)
                end
                _G_SecondEnchant.makeStoneState = false
                if Events.equipToolRemote then
                    pcall(function() Events.equipToolRemote:FireServer(0) end)
                end
            end)
        end

        local function RunSecondEnchantLoop(rodUUID)
            if _G_SecondEnchant.secondEnchantThread then
                pcall(function() task.cancel(_G_SecondEnchant.secondEnchantThread) end)
            end
            _G_SecondEnchant.secondEnchantThread = task.spawn(function()
                UnequipAllEquippedItems()
                task.wait(0.5)
                local hrp = getHRP()
                if hrp then
                    TeleportTo(CFrame.new(SECOND_ALTAR_POS, SECOND_ALTAR_POS + SECOND_ALTAR_LOOK) * CFrame.new(0, 0.5, 0))
                end
                task.wait(1.5)
                NotifySuccess("2nd Enchant", "Rolling slot ke-2...")
                while _G_SecondEnchant.secondEnchantState do
                    if CheckIfSecondEnchantReached(rodUUID) then
                        NotifySuccess("2nd Enchant", "Target enchant didapatkan!")
                        break
                    end
                    local stoneUUID = GetTranscendedStoneUUID()
                    if not stoneUUID then
                        NotifyError("2nd Enchant", "Transcended Stone habis!")
                        break
                    end
                    if Events.equipItemRemote then
                        pcall(function() Events.equipItemRemote:FireServer(rodUUID, "Fishing Rods") end)
                    end
                    task.wait(0.2)
                    if Events.equipItemRemote then
                        pcall(function() Events.equipItemRemote:FireServer(stoneUUID, "Enchant Stones") end)
                    end
                    task.wait(0.2)
                    if Events.equipToolRemote then
                        pcall(function() Events.equipToolRemote:FireServer(2) end)
                    end
                    task.wait(0.3)
                    if RE_ActivateSecondEnchantingAltar then
                        pcall(function() RE_ActivateSecondEnchantingAltar:FireServer() end)
                    else
                        NotifyError("2nd Enchant", "Remote ActivateSecondEnchantingAltar tidak ditemukan!")
                        break
                    end
                    task.wait(_G_SecondEnchant.tradeDelay)
                    if Events.equipToolRemote then
                        pcall(function() Events.equipToolRemote:FireServer(0) end)
                    end
                    task.wait(0.5)
                end
                _G_SecondEnchant.secondEnchantState = false
            end)
        end

        local secretFishOptions, secretFishUUIDMap = GetSecretFishOptions()
        if #secretFishOptions == 0 then
            secretFishOptions = {"(Tidak ada ikan Secret di inventory)"}
        end
        _G_SecondEnchant.secretFishUUIDMap = secretFishUUIDMap

        local secretFishDropdown = nil
        pcall(function()
            secretFishDropdown = Section_MainTab_3:AddDropdown("MultiDropdown_SelectSecretFishSacrifice", {
                Title = "Select Secret Fish (Sacrifice)",
                Description = "Pilih ikan SECRET untuk dijadikan Transcended Stone",
                Values = secretFishOptions,
                Default = {},
                Callback = function(values)
                    local cleanVals = {}
                    for _, v in pairs(values or {}) do
                        if typeof(v) == "string" and not v:find("Tidak ada") then
                            table.insert(cleanVals, v)
                        end
                    end
                    _G_SecondEnchant.selectedSecretFish = cleanVals
                end, Multi = true
            })
        end)

        pcall(function()
            Section_MainTab_3:AddButton({
                Title = "Refresh Secret Fish List",
                Icon = "lucide:refresh-cw",
                Callback = function()
                    local newOptions, newMap = GetSecretFishOptions()
                    _G_SecondEnchant.secretFishUUIDMap = newMap
                    local opts = #newOptions > 0 and newOptions or {"(Tidak ada ikan Secret di inventory)"}
                    pcall(function()
                        if secretFishDropdown and secretFishDropdown.SetValues then
                            secretFishDropdown:SetValues(opts)
                        end
                    end)
                    _G_SecondEnchant.selectedSecretFish = {}
                    NotifySuccess("Secret Fish", #newOptions .. " ikan SECRET ditemukan!")
                end
            })
        end)

        pcall(function()
            Section_MainTab_3:AddInput("Input_AmounttoMake", {
                Title = "Amount to Make",
                Description = "Berapa banyak Transcended Stone yang ingin dibuat?",
                Default = "1",
                Placeholder = "1",
                Callback = function(input)
                    local num = tonumber(input)
                    if num and num > 0 then
                        _G_SecondEnchant.targetStoneAmount = num
                    end
                end, Finished = true
            })
        end)

        pcall(function()
            Section_MainTab_3:AddToggle("Toggle_AutoMakeTranscendedStones", {
                Title = "Auto Make Transcended Stones",
                Description = "Otomatis ubah ikan SECRET terpilih jadi Transcended Stone",
                Default = false,
                Callback = function(state)
                    _G_SecondEnchant.makeStoneState = state
                    if state then
                        if #_G_SecondEnchant.selectedSecretFish == 0 then
                            NotifyError("Make Stone", "Pilih minimal 1 ikan SECRET!")
                            return
                        end
                        RunMakeStoneLoop()
                    else
                        if _G_SecondEnchant.makeStoneThread then
                            pcall(function() task.cancel(_G_SecondEnchant.makeStoneThread) end)
                        end
                        NotifyInfo("Make Stone", "Dihentikan.")
                    end
                end
            })
        end)

        local rodNameList = {}
        for _, v in ipairs(ENCHANT_ROD_LIST) do table.insert(rodNameList, v.Name) end
        if #rodNameList == 0 then rodNameList = {"Luck Rod"} end

        local rodDropdown = nil
        pcall(function()
            rodDropdown = Section_MainTab_3:AddDropdown("Dropdown_SelectRodfor2ndEnchant", {
                Title = "Select Rod for 2nd Enchant",
                Description = "Pilih rod target (pastikan ada di inventory)",
                Values = rodNameList,
                Default = rodNameList[1],
                Callback = function(name)
                    _G_SecondEnchant.selectedRodUUID = nil
                    for _, v in ipairs(ENCHANT_ROD_LIST) do
                        if v.Name == name or v.Title == name then
                            local foundUUID = GetUUIDByRodID(v.ID)
                            if foundUUID then
                                _G_SecondEnchant.selectedRodUUID = foundUUID
                                NotifySuccess("Rod", "Target: " .. name)
                            else
                                NotifyError("Rod", name .. " tidak ditemukan di inventory!")
                            end
                            break
                        end
                    end
                end, Multi = false
            })
        end)

        pcall(function()
            Section_MainTab_3:AddButton({
                Title = "Re-Check Selected Rod",
                Icon = "lucide:refresh-cw",
                Callback = function()
                    NotifyInfo("Rod", "Verifikasi ulang...")
                    if _G_SecondEnchant.selectedRodUUID then
                        NotifySuccess("Rod", "UUID terverifikasi!")
                    else
                        NotifyWarning("Rod", "Belum ada rod yang dipilih atau belum di inventory.")
                    end
                end
            })
        end)

        pcall(function()
            Section_MainTab_3:AddDropdown("MultiDropdown_Target2ndEnchant", {
                Title = "Target 2nd Enchant",
                Description = "Pilih enchant yang diinginkan di slot ke-2",
                Values = ENCHANT2_NAMES,
                Default = {},
                Callback = function(names)
                    local cleanNames = {}
                    for _, n in pairs(names or {}) do
                        if typeof(n) == "string" then
                            table.insert(cleanNames, n)
                        end
                    end
                    _G_SecondEnchant.selectedEnchantNames = cleanNames
                end, Multi = true
            })
        end)

        pcall(function()
            Section_MainTab_3:AddInput("Input_SecondEnchantDelay", {
                Title = "Roll Delay (detik)",
                Description = "Jeda waktu per roll enchant ke-2",
                Default = "1.0",
                Placeholder = "1.0",
                Callback = function(input)
                    local num = tonumber(input)
                    if num and num >= 0.1 then
                        _G_SecondEnchant.tradeDelay = num
                    end
                end, Finished = true
            })
        end)

        pcall(function()
            Section_MainTab_3:AddToggle("Toggle_AutoSecondEnchant", {
                Title = "Auto Second Enchant",
                Description = "Auto roll slot ke-2 pakai Transcended Stone",
                Default = false,
                Callback = function(state)
                    _G_SecondEnchant.secondEnchantState = state
                    if state then
                        if not _G_SecondEnchant.selectedRodUUID then
                            NotifyError("2nd Enchant", "Pilih Rod dulu!")
                            return
                        end
                        if #_G_SecondEnchant.selectedEnchantNames == 0 then
                            NotifyError("2nd Enchant", "Pilih target enchant!")
                            return
                        end
                        RunSecondEnchantLoop(_G_SecondEnchant.selectedRodUUID)
                    else
                        if _G_SecondEnchant.secondEnchantThread then
                            pcall(function() task.cancel(_G_SecondEnchant.secondEnchantThread) end)
                        end
                        NotifyInfo("2nd Enchant", "Dihentikan.")
                    end
                end
            })
        end)

        pcall(function()
            Section_MainTab_3:AddButton({
                Title = "Teleport to Second Altar",
                Description = "TP ke Temple Guardian (Ancient Jungle)",
                Callback = function()
                    local hrp = getHRP()
                    if hrp then
                        TeleportTo(CFrame.new(SECOND_ALTAR_POS, SECOND_ALTAR_POS + SECOND_ALTAR_LOOK) * CFrame.new(0, 0.5, 0))
                        NotifySuccess("TP", "Berhasil ke Second Altar!")
                    end
                end
            })
        end)

        local Section_MainTab_4 = MainTab:AddSection("Cave & Pirate Events")
        Section_MainTab_4:AddButton({
            Title = "Open Mysterious Cave Wall",
            Callback = function()
                task.spawn(function()
                    if not Events.searchItemPickedUp then Events.searchItemPickedUp = GetServerRemote("RF/SearchItemPickedUp") end
                    if not Events.gainAccessToMaze then Events.gainAccessToMaze = GetServerRemote("RE/GainAccessToMaze") end
                    if not Events.searchItemPickedUp or not Events.gainAccessToMaze then NotifyError("Cave", "Remote tidak ditemukan!"); return end
                    for i = 1, 4 do pcall(function() Events.searchItemPickedUp:FireServer("TNT") end); task.wait(0.7) end
                    task.wait(1.5); pcall(function() Events.gainAccessToMaze:FireServer() end)
                    NotifySuccess("Cave Wall", "Berhasil dibuka!")
                end)
            end
        })
        local function getAvailablePirateChests()
            local chests = {}
            local seen = {}
            local storage = workspace:FindFirstChild("PirateChestStorage")
            if storage then
                for _, chest in ipairs(storage:GetChildren()) do
                    if not seen[chest] then
                        local part = findPirateChestPart(chest)
                        if part then
                            seen[chest] = true
                            table.insert(chests, chest)
                        end
                    end
                end
            end
            local treasureFolder = workspace:FindFirstChild("Treasure") or workspace:FindFirstChild("Chests")
            if treasureFolder then
                for _, chest in ipairs(treasureFolder:GetChildren()) do
                    if not seen[chest] then
                        local part = findPirateChestPart(chest)
                        if part then
                            seen[chest] = true
                            table.insert(chests, chest)
                        end
                    end
                end
            end
            return chests
        end

        local function openAllPirateChestsOnce()
            local hrp = getHRP()
            if not hrp then return end
            local savedPos = hrp.CFrame
            local chests = getAvailablePirateChests()
            if #chests == 0 then
                NotifyWarning("Pirate Chest", "Tidak ada pirate chest yang tersedia saat ini.")
                return
            end
            NotifyInfo("Pirate Chest", "Ditemukan " .. #chests .. " chest. Membuka...")
            local claimed = 0
            for i, chest in ipairs(chests) do
                if interactPirateChest(chest, savedPos) then
                    claimed = claimed + 1
                end
                task.wait(0.3)
            end
            TeleportTo(savedPos * CFrame.new(0, 15, 0))
            task.wait(0.2)
            TeleportTo(savedPos)
            NotifySuccess("Pirate Chest", "Selesai! Claim " .. claimed .. " chest & kembali ke posisi semula.")
        end

        Section_MainTab_4:AddButton({
            Title = "Open All Pirate Chests (1x Run)",
            Description = "Teleport ke semua pirate chest yang ada, claim, lalu kembali ke posisi semula",
            Callback = function()
                task.spawn(openAllPirateChestsOnce)
            end
        })

        Section_MainTab_4:AddToggle("Toggle_AutoOpenPirateChest", {
            Title = "Auto Open Pirate Chest",
            Description = "Auto scan berkala, teleport ke chest, claim, dan kembali ke posisi semula",
            Default = false,
            Callback = function(val)
                _G.AutoOpenPirateChest = val
                if val then
                    task.spawn(function()
                        while _G.AutoOpenPirateChest do
                            local hrp = getHRP()
                            if hrp then
                                local savedPos = hrp.CFrame
                                local chests = getAvailablePirateChests()
                                if #chests > 0 then
                                    local claimed = 0
                                    for _, chest in ipairs(chests) do
                                        if not _G.AutoOpenPirateChest then break end
                                        if interactPirateChest(chest, savedPos) then
                                            claimed = claimed + 1
                                        end
                                        task.wait(0.3)
                                    end
                                    TeleportTo(savedPos * CFrame.new(0, 15, 0))
                                    task.wait(0.2)
                                    TeleportTo(savedPos)
                                    if claimed > 0 then
                                        NotifySuccess("Pirate Chest", "Claim " .. claimed .. " chest & kembali ke posisi awal!")
                                    end
                                end
                            end
                            task.wait(4)
                        end
                    end)
                end
            end
        })


        local Section_MainTab_5 = MainTab:AddSection("Crystal & Cave")
        Section_MainTab_5:AddButton({
            Title = "Consume Cave Crystal",
            Callback = function()
                if not Events.ConsumeCaveCrystal then Events.ConsumeCaveCrystal = GetServerRemote("RF/ConsumeCaveCrystal") end
                if Events.ConsumeCaveCrystal then
                    pcall(function() Events.ConsumeCaveCrystal:InvokeServer() end)
                    task.wait(1.5); equipRod(); NotifySuccess("Cave Crystal", "Berhasil!")
                else NotifyError("Cave Crystal", "Remote tidak ditemukan!") end
            end
        })
        Section_MainTab_5:AddToggle("Toggle_AutoConsumeCaveCrystal", {
            Title = "Auto Consume Cave Crystal", Default = false,
            Callback = function(val)
                _G.autoConsumeCaveCrystal = val
                if val then
                    if not Events.ConsumeCaveCrystal then Events.ConsumeCaveCrystal = GetServerRemote("RF/ConsumeCaveCrystal") end
                    _G.caveCrystalTask = task.spawn(function()
                        while _G.autoConsumeCaveCrystal do
                            pcall(function() if Events.ConsumeCaveCrystal then Events.ConsumeCaveCrystal:InvokeServer() end end)
                            task.wait(1.5); equipRod(); task.wait(1800)
                        end
                    end)
                    NotifySuccess("Auto Crystal", "Aktif - setiap 30 menit!")
                else
                    if _G.caveCrystalTask then pcall(function() task.cancel(_G.caveCrystalTask) end) end
                end
            end
        })

        local Section_MainTab_Potion = MainTab:AddSection("Potion Automation")

        local potionMap = {
            ["Aurora Borealis Potion"] = 32,
            ["Carrot 1 Potion"] = 19,
            ["Coin Potion"] = 2,
            ["Dark Megalodon Hunt Potion"] = 36,
            ["Easter 1 Potion"] = 20,
            ["Glacial Serpent Hunt Potion"] = 38,
            ["Love 1 Potion"] = 15,
            ["Luck 1 Potion"] = 1,
            ["Luck 2 Potion"] = 6,
            ["Luck 3 Potion"] = 18,
            ["Luck 4 Potion"] = 29,
            ["Megalodon Hunt Potion"] = 33,
            ["Meteor Shower Potion"] = 34,
            ["Mutation 1 Potion"] = 4,
            ["Mutation 2 Potion"] = 26,
            ["Mutation 3 Potion"] = 27,
            ["Mutation 4 Potion"] = 28,
            ["Reel 3 Potion"] = 30,
            ["Reel 4 Potion"] = 31,
            ["Thunderzilla Hunt Potion"] = 41,
            ["Volcano Eruption Potion"] = 35,
        }

        local potionNames = {}
        for name in pairs(potionMap) do
            table.insert(potionNames, name)
        end
        table.sort(potionNames)

        local selectedPotions = {}

        -- Strictly get RF/ConsumePotion from sleitnick net
        local function getPotionRemote()
            local r = nil
            if net then
                pcall(function()
                    r = net:FindFirstChild("RF/ConsumePotion")
                end)
            end
            if not r then
                pcall(function()
                    local packages = ReplicatedStorage:FindFirstChild("Packages")
                    local index = packages and packages:FindFirstChild("_Index")
                    if index then
                        for _, folder in ipairs(index:GetChildren()) do
                            if folder.Name:find("sleitnick_net") then
                                local netF = folder:FindFirstChild("net")
                                if netF then
                                    r = netF:FindFirstChild("RF/ConsumePotion")
                                    if r then break end
                                end
                            end
                        end
                    end
                end)
            end
            if not r then
                pcall(function()
                    r = ReplicatedStorage:FindFirstChild("RF/ConsumePotion", true)
                end)
            end
            return r
        end

        local function findPotionUUID(potionId, potionName)
            local uuid = nil
            local totalCount = 0
            pcall(function()
                local replion = GetPlayerDataReplion()
                local inv = replion and replion:GetExpect("Inventory")
                if not inv then return end
                
                local function searchIn(list)
                    if list and type(list) == "table" then
                        for _, item in ipairs(list) do
                            if item then
                                local match = false
                                if tonumber(item.Id) == potionId then
                                    match = true
                                elseif item.Identifier and tostring(item.Identifier):lower() == potionName:lower() then
                                    match = true
                                elseif item.Name and tostring(item.Name):lower() == potionName:lower() then
                                    match = true
                                end
                                if match then
                                    if not uuid and item.UUID then
                                        uuid = item.UUID
                                    end
                                    totalCount = totalCount + (tonumber(item.Quantity) or tonumber(item.Count) or 1)
                                end
                            end
                        end
                    end
                end
                
                searchIn(inv.Items)
                searchIn(inv.Potions)
                searchIn(inv.Consumables)
            end)
            return uuid, totalCount
        end

        local function doConsumePotions()
            local r = getPotionRemote()
            if not r then
                NotifyError("Consume Potion", "Remote RF/ConsumePotion tidak ditemukan!")
                return false
            end
            if #selectedPotions == 0 then
                NotifyWarning("Consume Potion", "Pilih potion terlebih dahulu di dropdown!")
                return false
            end

            local successCount = 0
            for _, name in ipairs(selectedPotions) do
                local pId = potionMap[name]
                if pId then
                    local uuid, count = findPotionUUID(pId, name)
                    local consumed = false
                    local errMsg = nil

                    -- 1. Try invoking with inventory item UUID if found
                    if uuid then
                        local ok, res = pcall(function()
                            return r:InvokeServer(uuid)
                        end)
                        if ok and res ~= false then
                            consumed = true
                        elseif not ok then
                            errMsg = tostring(res)
                        end
                    end

                    -- 2. Try invoking with numeric potion ID
                    if not consumed then
                        local ok, res = pcall(function()
                            return r:InvokeServer(pId)
                        end)
                        if ok and res ~= false then
                            consumed = true
                        elseif not ok and not errMsg then
                            errMsg = tostring(res)
                        end
                    end

                    -- 3. Try with string ID
                    if not consumed then
                        local ok, res = pcall(function()
                            return r:InvokeServer(tostring(pId))
                        end)
                        if ok and res ~= false then
                            consumed = true
                        end
                    end

                    -- 4. Try with UUID and ID combination if available
                    if not consumed and uuid then
                        local ok, res = pcall(function()
                            return r:InvokeServer(uuid, pId)
                        end)
                        if ok and res ~= false then
                            consumed = true
                        end
                    end

                    if consumed then
                        successCount = successCount + 1
                        NotifySuccess("Potion", "Berhasil consume: " .. name .. (count > 0 and (" (Sisa: " .. (count - 1) .. ")") or ""))
                    else
                        if count == 0 then
                            NotifyWarning("Potion", name .. " tidak ada di inventory kamu!")
                        else
                            NotifyError("Potion", "Gagal consume " .. name .. (errMsg and (": " .. errMsg) or ""))
                        end
                    end
                    task.wait(0.5)
                end
            end

            if successCount > 0 then
                task.wait(0.5)
                pcall(equipRod)
            end
            return successCount > 0
        end

        Section_MainTab_Potion:AddDropdown("MultiDropdown_SelectPotion", {
            Title = "Select Potion",
            Description = "Pilih satu atau beberapa potion yang ingin digunakan",
            Values = potionNames,
            Default = {},
            Callback = function(val)
                selectedPotions = {}
                if type(val) == "table" then
                    for k, v in pairs(val) do
                        if v then
                            table.insert(selectedPotions, typeof(k) == "string" and k or tostring(k))
                        end
                    end
                elseif type(val) == "string" and val ~= "" then
                    table.insert(selectedPotions, val)
                end
            end,
            Multi = true
        })

        Section_MainTab_Potion:AddButton({
            Title = "Consume Potion",
            Description = "Langsung consume potion yang dipilih sekarang",
            Callback = function()
                doConsumePotions()
            end
        })

        Section_MainTab_Potion:AddToggle("Toggle_AutoConsumePotion", {
            Title = "Auto Consume Potion (Every 30 Mins)",
            Description = "Otomatis consume potion pilihan setiap 30 menit",
            Default = false,
            Callback = function(val)
                Config.AutoConsumePotion = val
                _G.autoConsumePotion = val
                if val then
                    if #selectedPotions == 0 then
                        NotifyWarning("Auto Potion", "Pilih potion terlebih dahulu di dropdown!")
                    end
                    if Tasks.potionTask then
                        pcall(function() task.cancel(Tasks.potionTask) end)
                    end
                    Tasks.potionTask = task.spawn(function()
                        while _G.autoConsumePotion and Config.AutoConsumePotion do
                            if #selectedPotions > 0 then
                                doConsumePotions()
                            end
                            task.wait(1800)
                        end
                    end)
                    NotifySuccess("Auto Potion", "Aktif - berjalan setiap 30 menit!")
                else
                    if Tasks.potionTask then
                        pcall(function() task.cancel(Tasks.potionTask) end)
                        Tasks.potionTask = nil
                    end
                    NotifyInfo("Auto Potion", "Nonaktif.")
                end
            end
        })

        local function ClickTopDialogButton()
            local candidates = {}
            for _, gui in ipairs(LocalPlayer.PlayerGui:GetChildren()) do
                if gui:IsA("ScreenGui") or gui:IsA("BillboardGui") or gui:IsA("SurfaceGui") then
                    for _, obj in ipairs(gui:GetDescendants()) do
                        if (obj:IsA("TextButton") or obj:IsA("ImageButton")) and obj.Visible and obj.Active and obj.Enabled then
                            local text = ""
                            pcall(function() text = obj.Text or "" end)
                            local priority = 2
                            if text:lower():find("claim") or text:lower():find("divine") then
                                priority = 1
                            end
                            table.insert(candidates, { Btn = obj, Priority = priority, Text = text })
                        end
                    end
                end
            end
            table.sort(candidates, function(a, b)
                if a.Priority ~= b.Priority then return a.Priority < b.Priority end
                return a.Text < b.Text
            end)
            if #candidates > 0 then
                pcall(function() candidates[1].Btn:Activate() end)
                return true
            end
            return false
        end

        local function ClaimDivinePower()
            local hrp = getHRP()
            if not hrp then NotifyError("Divine Power", "Character tidak ditemukan!"); return false end
            local savedCFrame = hrp.CFrame
            local lucid = nil
            pcall(function()
                local npcFolder = Workspace:FindFirstChild("NPC")
                if npcFolder then lucid = npcFolder:FindFirstChild("Lucid") end
                if not lucid then
                    for _, obj in ipairs(Workspace:GetDescendants()) do
                        if obj:IsA("Model") and obj.Name == "Lucid" then lucid = obj; break end
                    end
                end
            end)
            if not lucid then NotifyError("Divine Power", "NPC Lucid tidak ditemukan!"); return false end
            local targetPart = lucid.PrimaryPart or lucid:FindFirstChildWhichIsA("BasePart")
            if not targetPart then NotifyError("Divine Power", "NPC Lucid tidak punya primary part!"); return false end
            NotifyInfo("Divine Power", "Teleport ke Lucid...")
            TeleportTo(targetPart.CFrame * CFrame.new(0, 3, 0))
            task.wait(0.6)
            pcall(function()
                local prompt, click = findPirateChestInteraction(lucid)
                if prompt then
                    local hold = prompt.HoldDuration or 0.7
                    if typeof(fireproximityprompt) == "function" then
                        fireproximityprompt(prompt, 1, hold)
                    else
                        prompt:InputHoldBegin()
                        task.wait(hold + 0.2)
                        prompt:InputHoldEnd()
                    end
                elseif click and typeof(fireclickdetector) == "function" then
                    fireclickdetector(click)
                end
            end)
            task.wait(1)
            local claimed = false
            for i = 1, 5 do
                if ClickTopDialogButton() then claimed = true; break end
                task.wait(0.6)
            end
            task.wait(1)
            if savedCFrame then TeleportTo(savedCFrame) end
            if claimed then
                NotifySuccess("Divine Power", "Berhasil claim divine power! Kembali ke posisi semula.")
                return true
            end
            NotifyWarning("Divine Power", "Gagal claim divine power.")
            return false
        end

        local Section_MainTab_Divine = MainTab:AddSection("Divine Power")
        Section_MainTab_Divine:AddButton({
            Title = "Claim Divine Power",
            Description = "Teleport ke NPC Lucid, interaksi, pilih claim, lalu kembali",
            Callback = function()
                ClaimDivinePower()
            end
        })

        Section_MainTab_Divine:AddToggle("Toggle_AutoClaimDivinePower", {
            Title = "Auto Claim Divine Power",
            Description = "Auto claim divine power setiap 5 menit",
            Default = false,
            Callback = function(val)
                _G.autoClaimDivinePower = val
                if val then
                    if _G.autoClaimDivinePowerThread then pcall(function() task.cancel(_G.autoClaimDivinePowerThread) end) end
                    _G.autoClaimDivinePowerThread = task.spawn(function()
                        while _G.autoClaimDivinePower do
                            ClaimDivinePower()
                            task.wait(300)
                        end
                    end)
                    NotifySuccess("Divine Power", "Auto claim aktif")
                else
                    if _G.autoClaimDivinePowerThread then pcall(function() task.cancel(_G.autoClaimDivinePowerThread) end) end
                    NotifyWarning("Divine Power", "Auto claim dimatikan")
                end
            end
        })

        local Section_MainTab_6 = MainTab:AddSection("Fishing Radar")
        Section_MainTab_6:AddToggle("Toggle_EnableFishingRadar", {
            Title = "Enable Fishing Radar", Default = false,
            Callback = function(val)
                Config.FishingRadar = val
                if not Events.UpdateFishingRadar then Events.UpdateFishingRadar = GetServerRemote("RF/UpdateFishingRadar") end
                if Events.UpdateFishingRadar then
                    pcall(function() Events.UpdateFishingRadar:InvokeServer(val) end)
                    NotifyInfo("Fishing Radar", val and "Radar aktif!" or "Radar nonaktif.")
                else NotifyError("Fishing Radar", "Remote tidak ditemukan!") end
            end
        })

        local Section_MainTab_7 = MainTab:AddSection("Auto Atlantis Machine")
        Section_MainTab_7:AddToggle("Toggle_AutoAtlantisMachine", {
            Title = "Auto Atlantis Machine",
            Description = "Auto: Cek ikan → TP → Buka UI → Sacrifice → Sell → Balik fishing",
            Default = false,
            Callback = function(val)
                AtlantisConfig.AutoAtlantisMachine = val
                if val then
                    local hrp = getHRP()
                    if hrp then AtlantisConfig.LastFishingPosition = hrp.CFrame end
                    RunAutoAtlantisMachine()
                    NotifySuccess("Atlantis", "Auto Atlantis Machine aktif!")
                else
                    StopAutoAtlantisMachine()
                end
            end
        })
        Section_MainTab_7:AddButton({
            Title = "Sacrifice Now (Manual)",
            Description = "Sacrifice semua ikan Rare+ sekarang",
            Callback = function()
                local hrp = getHRP()
                if hrp then AtlantisConfig.LastFishingPosition = hrp.CFrame end
                task.spawn(function()
                    local success = SacrificeAllFishToAtlantis()
                    if not success then
                        NotifyError("Atlantis", "Gagal / tidak ada ikan Rare+!")
                    end
                end)
            end
        })

        local Section_MainTab_8 = MainTab:AddSection("Event Teleport")
        Section_MainTab_8:AddButton({ Title = "TP Leviathan", Callback = function() local hrp = getHRP(); if hrp then TeleportTo(CFrame.new(3474.053,-287.775,3472.634)) end end })
        Section_MainTab_8:AddButton({ Title = "TP Thunderzilla", Callback = function() local hrp = getHRP(); if hrp then TeleportTo(CFrame.new(2067.866,2.028,10.831)) end end })

        local Section_MainTab_Elemental = MainTab:AddSection("Auto Event (Elemental Island)")

        local ElementalEventState = {
            ["Storm Elemental Event"] = {
                Active = false,
                StartTime = 0,
                Duration = 3600,
                Keywords = {"storm is accurring", "storm is occurring", "massive storm", "storm elemental", "storm event", "stormshell", "a storm has", "storm started", "storm has started", "strom"},
                EndKeywords = {"storm has ended", "storm has passed", "storm has cleared", "storm is over", "storm cleared", "storm ended"},
                CFrame = LOCATIONS["Elemental Island (Storm Area)"] or CFrame.new(-853.494629, 93.8661575, 5541.74609, 0.68788904, -3.32617915e-08, 0.725815892, 2.66287898e-08, 1, 2.05894359e-08, -0.725815892, 5.1643525e-09, 0.68788904)
            },
            ["Blizzard Elemental Event"] = {
                Active = false,
                StartTime = 0,
                Duration = 3600,
                Keywords = {"blizzard has started", "blizzard is occurring", "blizzard is accurring", "blizzard elemental", "blizzard event", "wintertusk", "a blizzard has", "blizzard started", "blizard"},
                EndKeywords = {"blizzard has ended", "blizzard has passed", "blizzard has cleared", "blizzard is over", "blizzard cleared", "blizzard ended"},
                CFrame = LOCATIONS["Elemental Island (Blizzard Area)"] or CFrame.new(-1082.68604, 124.093239, 5538.86182, -0.394805819, 5.95509704e-08, -0.918764591, -6.92057398e-08, 1, 9.45550127e-08, 0.918764591, 1.00914647e-07, -0.394805819)
            },
            ["Volcano Elemental Event"] = {
                Active = false,
                StartTime = 0,
                Duration = 3600,
                Keywords = {"volcano has erupted", "volcano is erupting", "volcano eruption", "volcano elemental", "volcano event", "volcanic event", "volcanic elemental", "pyrocoil", "the volcano has", "volcano erupted"},
                EndKeywords = {"volcano has stopped", "volcano has calmed", "volcano is over", "volcano cleared", "volcano eruption ended", "volcano ended"},
                CFrame = LOCATIONS["Elemental Island (Volcano Area)"] or CFrame.new(-619.441223, 107.02948, 5522.54736, -0.351876795, 4.22376578e-09, 0.936046302, 3.75576299e-08, 1, 9.60624735e-09, -0.936046302, 3.85358945e-08, -0.351876795)
            }
        }

        local selectedElementalEvents = {
            ["Storm Elemental Event"] = true
        }

        local function resolveCanonicalEventKey(query)
            if not query then return nil end
            local q = tostring(query):lower()
            if q:find("storm") or q:find("strom") or q:find("atmospher") then
                return "Storm Elemental Event"
            elseif q:find("blizzard") or q:find("blizard") or q:find("glacial") or q:find("ice") then
                return "Blizzard Elemental Event"
            elseif q:find("volcano") or q:find("volcanic") or q:find("magma") or q:find("erupt") then
                return "Volcano Elemental Event"
            end
            return nil
        end

        local function processEventText(text)
            if type(text) ~= "string" or text == "" then return end
            local lower = text:lower()

            -- Check end keywords first
            for eventKey, info in pairs(ElementalEventState) do
                for _, ekw in ipairs(info.EndKeywords) do
                    if lower:find(ekw, 1, true) then
                        if info.Active then
                            info.Active = false
                            info.StartTime = 0
                            NotifyInfo("Elemental Event", "Event Selesai: " .. eventKey)
                        end
                        return
                    end
                end
            end

            -- Check start keywords
            for eventKey, info in pairs(ElementalEventState) do
                for _, kw in ipairs(info.Keywords) do
                    if lower:find(kw, 1, true) then
                        if not info.Active then
                            info.Active = true
                            info.StartTime = tick()
                            NotifySuccess("Elemental Event", "Event Terdeteksi: " .. eventKey .. "!")
                        end
                        return
                    end
                end
            end
        end

        local function extractAndProcessAnyData(...)
            local args = {...}
            for _, val in ipairs(args) do
                if type(val) == "string" then
                    processEventText(val)
                elseif type(val) == "table" then
                    for _, k in ipairs({"Text", "Message", "Content", "Title", "Description", "Header", "Body", "EventName", "Name", "Desc", "Weather", "Event"}) do
                        if val[k] and type(val[k]) == "string" then
                            processEventText(val[k])
                        end
                    end
                    for _, sub in pairs(val) do
                        if type(sub) == "string" then
                            processEventText(sub)
                        elseif type(sub) == "table" then
                            for _, sub2 in pairs(sub) do
                                if type(sub2) == "string" then
                                    processEventText(sub2)
                                end
                            end
                        end
                    end
                end
            end
        end

        -- Layer 1: Universal Remote Hook (Net Package)
        pcall(function()
            if net then
                for _, rem in ipairs(net:GetChildren()) do
                    if rem:IsA("RemoteEvent") then
                        rem.OnClientEvent:Connect(function(...)
                            extractAndProcessAnyData(...)
                        end)
                    end
                end
            end
        end)

        -- Layer 2: Universal Controllers Hook
        pcall(function()
            local ctrlFolder = ReplicatedStorage:FindFirstChild("Controllers")
            if ctrlFolder then
                for _, mod in ipairs(ctrlFolder:GetChildren()) do
                    if mod:IsA("ModuleScript") then
                        pcall(function()
                            local req = require(mod)
                            if type(req) == "table" then
                                for _, fnName in ipairs({"DeliverNotification", "Notify", "ShowNotification", "DeliverTextNotification", "SendNotification", "OnNotification"}) do
                                    if type(req[fnName]) == "function" then
                                        local orig = req[fnName]
                                        req[fnName] = function(...)
                                            extractAndProcessAnyData(...)
                                            return orig(...)
                                        end
                                    end
                                end
                            end
                        end)
                    end
                end
            end
        end)

        -- Layer 3: Notification ScreenGuis Listener
        pcall(function()
            local playerGui = LocalPlayer:WaitForChild("PlayerGui", 5)
            if playerGui then
                local function monitorGui(gui)
                    if gui:IsA("ScreenGui") and (gui.Name == "Text Notifications" or gui.Name:lower():find("notif") or gui.Name:lower():find("announc") or gui.Name:lower():find("message")) then
                        local function checkDesc(d)
                            if d:IsA("TextLabel") or d:IsA("TextBox") then
                                processEventText(d.Text)
                                d:GetPropertyChangedSignal("Text"):Connect(function()
                                    processEventText(d.Text)
                                end)
                            end
                        end
                        for _, d in ipairs(gui:GetDescendants()) do checkDesc(d) end
                        gui.DescendantAdded:Connect(checkDesc)
                    end
                end

                for _, g in ipairs(playerGui:GetChildren()) do monitorGui(g) end
                playerGui.ChildAdded:Connect(monitorGui)
            end
        end)

        -- Layer 4: TextChatService Hook
        pcall(function()
            local TextChatService = game:GetService("TextChatService")
            if TextChatService then
                TextChatService.MessageReceived:Connect(function(msg)
                    if msg and msg.Text then
                        processEventText(msg.Text)
                    end
                end)
            end
            LocalPlayer.Chatted:Connect(function(msg)
                if msg then processEventText(msg) end
            end)
        end)

        local function checkControllersForEvents()
            local activeList = {}
            pcall(function()
                local ctrlFolder = ReplicatedStorage:FindFirstChild("Controllers")
                if not ctrlFolder then return end
                for _, cMod in ipairs(ctrlFolder:GetChildren()) do
                    if cMod:IsA("ModuleScript") then
                        local ok2, ctrl = pcall(require, cMod)
                        if ok2 and type(ctrl) == "table" then
                            for _, fnName in ipairs({"GetActiveEvents", "GetEvents", "GetActiveWeather", "GetCurrentEvents", "GetActiveZones"}) do
                                if type(ctrl[fnName]) == "function" then
                                    local ok3, res = pcall(function() return ctrl[fnName](ctrl) end)
                                    if ok3 and type(res) == "table" then
                                        for k, v in pairs(res) do
                                            local s = tostring(type(k) == "string" and k or v):lower()
                                            local key = resolveCanonicalEventKey(s)
                                            if key then activeList[key] = true end
                                        end
                                    end
                                end
                            end
                            for _, propName in ipairs({"ActiveEvents", "Events", "CurrentEvents", "ActiveWeather", "CurrentWeather", "ActiveZones"}) do
                                if type(ctrl[propName]) == "table" then
                                    for k, v in pairs(ctrl[propName]) do
                                        local s = tostring(type(k) == "string" and k or v):lower()
                                        local key = resolveCanonicalEventKey(s)
                                        if key then activeList[key] = true end
                                    end
                                end
                            end
                        end
                    end
                end
            end)
            return activeList
        end

        local function checkDynamicFolders()
            local activeList = {}
            pcall(function()
                for _, parent in ipairs({ ReplicatedStorage, Workspace }) do
                    for _, folderName in ipairs({"ActiveEvents", "RunningEvents", "CurrentEvents", "ActiveWeather", "CurrentWeather", "Weather"}) do
                        local f = parent:FindFirstChild(folderName)
                        if f then
                            for _, child in ipairs(f:GetChildren()) do
                                local key = resolveCanonicalEventKey(child.Name)
                                if key then activeList[key] = true end
                            end
                        end
                    end
                end
            end)
            return activeList
        end

        local function checkReplionForEvents()
            local activeList = {}
            pcall(function()
                local repClient = Replion and Replion.Client
                if not repClient then return end
                for _, repName in ipairs({"Events", "ActiveEvents", "Weather", "World", "Environment", "Zone", "Zones"}) do
                    local ok, r = pcall(function() return repClient:GetReplion(repName) end)
                    if ok and r then
                        local data = r:GetValue() or r:GetExpect()
                        if type(data) == "table" then
                            for k, v in pairs(data) do
                                local s = tostring(type(k) == "string" and k or v):lower()
                                local key = resolveCanonicalEventKey(s)
                                if key then activeList[key] = true end
                            end
                        end
                    end
                end
            end)
            return activeList
        end

        local function checkLightingAndWorld()
            local activeList = {}
            pcall(function()
                local lighting = game:GetService("Lighting")
                if lighting then
                    for _, obj in ipairs(lighting:GetChildren()) do
                        local key = resolveCanonicalEventKey(obj.Name)
                        if key then activeList[key] = true end
                    end
                    for attrName, attrVal in pairs(lighting:GetAttributes()) do
                        local key = resolveCanonicalEventKey(tostring(attrName) .. " " .. tostring(attrVal))
                        if key then activeList[key] = true end
                    end
                end
            end)
            return activeList
        end

        local function isElementalEventActive(eventQuery)
            local eventKey = resolveCanonicalEventKey(eventQuery)
            if not eventKey then return false end
            local info = ElementalEventState[eventKey]
            if not info then return false end

            if info.Active then
                local elapsed = tick() - info.StartTime
                if elapsed <= (info.Duration or 3600) then
                    return true
                else
                    info.Active = false
                    info.StartTime = 0
                end
            end

            if checkControllersForEvents()[eventKey] then
                info.Active = true; info.StartTime = tick(); return true
            end
            if checkDynamicFolders()[eventKey] then
                info.Active = true; info.StartTime = tick(); return true
            end
            if checkReplionForEvents()[eventKey] then
                info.Active = true; info.StartTime = tick(); return true
            end
            if checkLightingAndWorld()[eventKey] then
                info.Active = true; info.StartTime = tick(); return true
            end

            return false
        end

        local elementalAutoTPState = false
        local elementalAutoTPThread = nil
        local elementalSavedCFrame = nil
        local elementalCurrentEvent = nil

        local function runElementalEventLoop()
            while elementalAutoTPState do
                pcall(function()
                    if elementalCurrentEvent then
                        local stillActive = isElementalEventActive(elementalCurrentEvent)
                        if not stillActive then
                            NotifyInfo("Elemental Event", "Event " .. tostring(elementalCurrentEvent) .. " selesai! Kembali ke posisi semula...")
                            if elementalSavedCFrame then
                                task.wait(0.5)
                                TeleportTo(elementalSavedCFrame)
                            end
                            elementalCurrentEvent = nil
                            elementalSavedCFrame = nil
                        end
                    else
                        for evName, isSelected in pairs(selectedElementalEvents) do
                            if isSelected then
                                local canonicalKey = resolveCanonicalEventKey(evName)
                                if canonicalKey and isElementalEventActive(canonicalKey) then
                                    local targetData = ElementalEventState[canonicalKey]
                                    if targetData and targetData.CFrame then
                                        local hrp = getHRP()
                                        if hrp then
                                            elementalSavedCFrame = hrp.CFrame
                                            elementalCurrentEvent = canonicalKey
                                            NotifySuccess("Elemental Event", "Event " .. tostring(canonicalKey) .. " aktif! Teleporting ke lokasi...")
                                            TeleportTo(targetData.CFrame)
                                            break
                                        end
                                    end
                                end
                            end
                        end
                    end
                end)
                task.wait(1)
            end
        end

        Section_MainTab_Elemental:AddDropdown("MultiDropdown_SelectElementalEvent", {
            Title = "Select Elemental Event",
            Values = {"Storm Elemental Event", "Blizzard Elemental Event", "Volcano Elemental Event"},
            Default = {"Storm Elemental Event"},
            Multi = true,
            Callback = function(val)
                selectedElementalEvents = {}
                if typeof(val) == "table" then
                    for k, v in pairs(val) do
                        if v == true then
                            selectedElementalEvents[k] = true
                        elseif typeof(v) == "string" then
                            selectedElementalEvents[v] = true
                        end
                    end
                elseif typeof(val) == "string" then
                    selectedElementalEvents[val] = true
                end
            end
        })

        Section_MainTab_Elemental:AddToggle("Toggle_AutoElementalEvent", {
            Title = "Auto Teleport To Selected Event",
            Description = "Scan event aktif -> Teleport -> Balik ke posisi awal saat selesai",
            Default = false,
            Callback = function(state)
                elementalAutoTPState = state
                if state then
                    local hasSelected = false
                    for _, v in pairs(selectedElementalEvents) do
                        if v then hasSelected = true; break end
                    end
                    if not hasSelected then
                        NotifyWarning("Elemental Event", "Pilih minimal 1 event di dropdown!")
                        elementalAutoTPState = false
                        return
                    end

                    if elementalAutoTPThread then
                        pcall(function() task.cancel(elementalAutoTPThread) end)
                    end
                    elementalAutoTPThread = task.spawn(runElementalEventLoop)
                    NotifySuccess("Elemental Event", "Auto Event Aktif! Memindai event...")
                else
                    if elementalAutoTPThread then
                        pcall(function() task.cancel(elementalAutoTPThread) end)
                        elementalAutoTPThread = nil
                    end
                    if elementalCurrentEvent and elementalSavedCFrame then
                        NotifyInfo("Elemental Event", "Auto Event dimatikan. Kembali ke posisi awal...")
                        TeleportTo(elementalSavedCFrame)
                    end
                    elementalCurrentEvent = nil
                    elementalSavedCFrame = nil
                    NotifyInfo("Elemental Event", "Auto Event Dimatikan.")
                end
            end
        })

        local Section_MainTab_Regulator = MainTab:AddSection("Auto Repair Regulator (Elemental Island)")

        Section_MainTab_Regulator:AddParagraph({
            Title = "📖 Panduan Auto Repair Regulator",
            Content = "1. Pilih Regulator yang ingin diperbaiki di dropdown.\n2. Aktifkan toggle 'Auto Repair Regulator'.\n3. Saat Event terkait aktif, script otomatis teleport ke Area Event & equip rod.\n4. Silakan aktifkan fitur Auto Fishing manual yang ingin kamu gunakan.\n5. Setelah item khusus didapatkan, script otomatis unequip rod, teleport ke mesin regulator, dan berinteraksi dengan ProximityPrompt untuk memperbaiki mesin."
        })

        local REGULATOR_CONFIG = {
            ["Atmospheric Regulator"] = {
                EventName = "Storm Elemental Event",
                AreaCFrame = LOCATIONS["Elemental Island (Storm Area)"] or CFrame.new(-853.494629, 93.8661575, 5541.74609, 0.68788904, -3.32617915e-08, 0.725815892, 2.66287898e-08, 1, 2.05894359e-08, -0.725815892, 5.1643525e-09, 0.68788904),
                MachineCFrame = CFrame.new(-929.786743, 85.3661575, 5554.45117, -0.996223509, -2.47479495e-08, -0.0868259594, -2.45438905e-08, 1, -3.41774364e-09, 0.0868259594, -1.27378985e-09, -0.996223509),
                ItemName = "Stormshell Brute",
                ItemId = 1198
            },
            ["Glacial Regulator"] = {
                EventName = "Blizzard Elemental Event",
                AreaCFrame = LOCATIONS["Elemental Island (Blizzard Area)"] or CFrame.new(-1082.68604, 124.093239, 5538.86182, -0.394805819, 5.95509704e-08, -0.918764591, -6.92057398e-08, 1, 9.45550127e-08, 0.918764591, 1.00914647e-07, -0.394805819),
                MachineCFrame = CFrame.new(-1081.87744, 124.093239, 5547.81152, -0.666997313, -8.72993127e-08, 0.745060146, -5.40679324e-08, 1, 6.87677968e-08, -0.745060146, 5.58407409e-09, -0.666997313),
                ItemName = "Wintertusk Mammofin",
                ItemId = nil
            },
            ["Magma Regulator"] = {
                EventName = "Volcano Elemental Event",
                AreaCFrame = LOCATIONS["Elemental Island (Volcano Area)"] or CFrame.new(-619.441223, 107.02948, 5522.54736, -0.351876795, 4.22376578e-09, 0.936046302, 3.75576299e-08, 1, 9.60624735e-09, -0.936046302, 3.85358945e-08, -0.351876795),
                MachineCFrame = nil,
                ItemName = "Pyrocoil",
                ItemId = 1197
            }
        }

        local selectedRegulators = {
            ["Atmospheric Regulator"] = true
        }

        local regulatorState = false
        local regulatorThread = nil
        local regulatorSavedPos = nil

        local function hasRequiredItemInInventory(targetItemName, targetItemId)
            local count = 0
            local targetNameLower = targetItemName and targetItemName:lower() or nil
            local targetIdNum = tonumber(targetItemId) or nil

            pcall(function()
                local replion = GetPlayerDataReplion and GetPlayerDataReplion()
                if replion then
                    local ok, inv = pcall(function() return replion:GetExpect("Inventory") end)
                    if ok and inv then
                        for categoryName, catItems in pairs(inv) do
                            if type(catItems) == "table" then
                                for _, item in pairs(catItems) do
                                    if type(item) == "table" then
                                        local iId = tonumber(item.Id)
                                        local iName = tostring(item.Name or item.Id or ""):lower()
                                        if (targetIdNum and iId == targetIdNum) or (targetNameLower and iName:find(targetNameLower, 1, true)) then
                                            local q = tonumber(item.Quantity or item.Count or 1) or 1
                                            count = count + q
                                        end
                                    elseif type(item) == "string" or type(item) == "number" then
                                        local iId = tonumber(item)
                                        local iName = tostring(item):lower()
                                        if (targetIdNum and iId == targetIdNum) or (targetNameLower and iName:find(targetNameLower, 1, true)) then
                                            count = count + 1
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end)

            pcall(function()
                local lp = Players.LocalPlayer
                local bp = lp and lp:FindFirstChild("Backpack")
                if bp then
                    for _, tool in ipairs(bp:GetChildren()) do
                        local tName = tool.Name:lower()
                        local tId = tonumber(tool:GetAttribute("ItemId"))
                        if (targetIdNum and tId == targetIdNum) or (targetNameLower and tName:find(targetNameLower, 1, true)) then
                            count = count + 1
                        end
                    end
                end
                local char = lp and lp.Character
                if char then
                    for _, tool in ipairs(char:GetChildren()) do
                        if tool:IsA("Tool") then
                            local tName = tool.Name:lower()
                            local tId = tonumber(tool:GetAttribute("ItemId"))
                            if (targetIdNum and tId == targetIdNum) or (targetNameLower and tName:find(targetNameLower, 1, true)) then
                                count = count + 1
                            end
                        end
                    end
                end
            end)

            return count > 0, count
        end

        local function unequipAllTools()
            pcall(function()
                local char = LocalPlayer.Character
                if char and char:FindFirstChildOfClass("Humanoid") then
                    char.Humanoid:UnequipTools()
                end
                local RE_Unequip = GetServerRemote("RE/UnequipToolFromHotbar") or GetServerRemote("RF/UnequipToolFromHotbar")
                if RE_Unequip then
                    pcall(function()
                        if RE_Unequip:IsA("RemoteEvent") then
                            RE_Unequip:FireServer()
                        elseif RE_Unequip:IsA("RemoteFunction") then
                            RE_Unequip:InvokeServer()
                        end
                    end)
                end
                if Events.unequip then
                    pcall(function() Events.unequip:FireServer() end)
                end
            end)
        end

        local function triggerNearestProximityPrompt(maxDist)
            maxDist = maxDist or 35
            local char = LocalPlayer.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if not hrp then return false end

            local targetPrompt = nil
            local closestDist = maxDist

            for _, desc in ipairs(Workspace:GetDescendants()) do
                if desc:IsA("ProximityPrompt") and desc.Enabled then
                    local pPos = nil
                    if desc.Parent:IsA("BasePart") then
                        pPos = desc.Parent.Position
                    elseif desc.Parent:IsA("Model") and desc.Parent.PrimaryPart then
                        pPos = desc.Parent.PrimaryPart.Position
                    elseif desc.Parent:IsA("Attachment") then
                        pPos = desc.Parent.WorldPosition
                    end

                    if pPos then
                        local d = (hrp.Position - pPos).Magnitude
                        if d < closestDist then
                            closestDist = d
                            targetPrompt = desc
                        end
                    end
                end
            end

            if targetPrompt then
                targetPrompt.RequiresLineOfSight = false
                targetPrompt.MaxActivationDistance = math.max(targetPrompt.MaxActivationDistance or 10, 35)
                local holdTime = (targetPrompt.HoldDuration and targetPrompt.HoldDuration > 0) and targetPrompt.HoldDuration or 0.5

                if typeof(fireproximityprompt) == "function" then
                    pcall(function() fireproximityprompt(targetPrompt, 0) end)
                    pcall(function() fireproximityprompt(targetPrompt, holdTime) end)
                    pcall(function() fireproximityprompt(targetPrompt) end)
                end

                pcall(function() targetPrompt:InputHoldBegin() end)
                task.wait(holdTime + 0.1)
                pcall(function() targetPrompt:InputHoldEnd() end)

                if typeof(fireproximityprompt) == "function" then
                    pcall(function() fireproximityprompt(targetPrompt) end)
                end
                return true
            end
            return false
        end

        local function runAutoRegulatorLoop()
            local activeRegName = nil
            local activePhase = "SCANNING"

            while regulatorState do
                pcall(function()
                    for regName, isSelected in pairs(selectedRegulators) do
                        if isSelected and REGULATOR_CONFIG[regName] then
                            local config = REGULATOR_CONFIG[regName]
                            local hasItem, count = hasRequiredItemInInventory(config.ItemName, config.ItemId)

                            if hasItem and config.MachineCFrame and activePhase ~= "REPAIRING" and activePhase ~= "DONE" then
                                activePhase = "REPAIRING"
                                NotifySuccess("Auto Regulator", config.ItemName .. " terdeteksi di Inventory! Mempersiapkan perbaikan " .. regName .. "...")
                                unequipAllTools()
                                task.wait(0.5)
                                TeleportTo(config.MachineCFrame)
                                task.wait(1)
                                local interacted = triggerNearestProximityPrompt(35)
                                if interacted then
                                    NotifySuccess("Auto Regulator", "Berhasil berinteraksi dengan Mesin " .. regName .. "!")
                                else
                                    task.wait(1)
                                    triggerNearestProximityPrompt(35)
                                end
                                activePhase = "DONE"
                                NotifySuccess("Auto Regulator", "Proses perbaikan " .. regName .. " selesai!")
                                break
                            elseif not hasItem then
                                local isEventActive = isElementalEventActive(config.EventName)
                                if isEventActive then
                                    if activePhase ~= "FISHING" or activeRegName ~= regName then
                                        local hrp = getHRP()
                                        if hrp and not regulatorSavedPos then
                                            regulatorSavedPos = hrp.CFrame
                                        end
                                        activeRegName = regName
                                        activePhase = "FISHING"
                                        NotifySuccess("Auto Regulator", config.EventName .. " aktif! Teleport ke Area " .. regName .. "...")
                                        TeleportTo(config.AreaCFrame)
                                        task.wait(0.5)
                                        ensureRodEquipped(true)
                                        NotifyInfo("Auto Regulator", "Rod ter-equip! Silakan nyalakan fitur Auto Fishing pilihan Anda untuk mendapatkan " .. config.ItemName .. ".")
                                    else
                                        local gotItem = hasRequiredItemInInventory(config.ItemName, config.ItemId)
                                        if gotItem then
                                            activePhase = "REPAIRING"
                                            NotifySuccess("Auto Regulator", config.ItemName .. " berhasil didapatkan! Memperbaiki mesin " .. regName .. "...")
                                            unequipAllTools()
                                            task.wait(0.5)
                                            if config.MachineCFrame then
                                                TeleportTo(config.MachineCFrame)
                                                task.wait(1)
                                                local interacted = triggerNearestProximityPrompt(35)
                                                if interacted then
                                                    NotifySuccess("Auto Regulator", "Berhasil berinteraksi dengan Mesin " .. regName .. "!")
                                                else
                                                    task.wait(1)
                                                    triggerNearestProximityPrompt(35)
                                                end
                                                activePhase = "DONE"
                                                NotifySuccess("Auto Regulator", "Perbaikan " .. regName .. " selesai!")
                                            else
                                                NotifyInfo("Auto Regulator", "Item " .. config.ItemName .. " berhasil didapatkan! Mesin " .. regName .. " belum memiliki CFrame lokasi mesin.")
                                                activePhase = "DONE"
                                            end
                                        end
                                    end
                                    break
                                else
                                    if activePhase == "FISHING" and activeRegName == regName then
                                        NotifyWarning("Auto Regulator", config.EventName .. " telah selesai sebelum mendapatkan " .. config.ItemName .. ". Menunggu event berikutnya...")
                                        activePhase = "SCANNING"
                                        activeRegName = nil
                                        if regulatorSavedPos then
                                            TeleportTo(regulatorSavedPos)
                                        end
                                    end
                                end
                            end
                        end
                    end
                end)
                task.wait(1)
            end
        end

        Section_MainTab_Regulator:AddDropdown("MultiDropdown_SelectRegulator", {
            Title = "Select Regulator",
            Values = {"Atmospheric Regulator", "Glacial Regulator", "Magma Regulator"},
            Default = {"Atmospheric Regulator"},
            Multi = true,
            Callback = function(val)
                selectedRegulators = {}
                if typeof(val) == "table" then
                    for k, v in pairs(val) do
                        if v == true then
                            selectedRegulators[k] = true
                        elseif typeof(v) == "string" then
                            selectedRegulators[v] = true
                        end
                    end
                elseif typeof(val) == "string" then
                    selectedRegulators[val] = true
                end
            end
        })

        Section_MainTab_Regulator:AddToggle("Toggle_AutoRepairRegulator", {
            Title = "Auto Repair Regulator",
            Description = "Auto teleport saat event -> Equip rod -> Deteksi item -> Teleport mesin & klik prompt",
            Default = false,
            Callback = function(state)
                regulatorState = state
                if state then
                    local hasSelected = false
                    for _, v in pairs(selectedRegulators) do
                        if v then hasSelected = true; break end
                    end
                    if not hasSelected then
                        NotifyWarning("Auto Regulator", "Pilih minimal 1 regulator di dropdown!")
                        regulatorState = false
                        return
                    end

                    if regulatorThread then
                        pcall(function() task.cancel(regulatorThread) end)
                    end
                    regulatorThread = task.spawn(runAutoRegulatorLoop)
                    NotifySuccess("Auto Regulator", "Auto Repair Regulator Aktif! Memindai event...")
                else
                    if regulatorThread then
                        pcall(function() task.cancel(regulatorThread) end)
                        regulatorThread = nil
                    end
                    regulatorSavedPos = nil
                    NotifyInfo("Auto Regulator", "Auto Repair Regulator Dimatikan.")
                end
            end
        })

        local Section_MainTab_Artifact = MainTab:AddSection("Auto Complete Artifact")

        local ARTIFACT_DATA = {
            ["Diamond Artifact"] = {
                Id = 267,
                FishSpot = Vector3.new(1763, -3, -406),
                LeverCF = CFrame.new(1822.6333, 7.62499857, -287.22287, -0.922478795, -2.37723281e-08, 0.386047751, 6.27265351e-09, 1, 7.65675168e-08, -0.386047751, 7.30534566e-08, -0.922478795)
            },
            ["Crescent Artifact"] = {
                Id = 266,
                FishSpot = Vector3.new(1478, -3, 117),
                LeverCF = CFrame.new(1416.04443, 30.3749943, 79.3558807, -0.16176784, 1.06205214e-08, -0.986828864, 5.36473053e-08, 1, 1.96803418e-09, 0.986828864, -5.26223438e-08, -0.16176784)
            },
            ["Arrow Artifact"] = {
                Id = 265,
                FishSpot = Vector3.new(981, -3, -374),
                LeverCF = CFrame.new(894.176575, 7.62499857, -361.110962, 0.18843244, -5.4785108e-08, -0.982086182, 6.02529866e-08, 1, -4.42237109e-08, 0.982086182, -5.08404412e-08, 0.18843244)
            },
            ["Hourglass Artifact"] = {
                Id = 271,
                FishSpot = Vector3.new(1440, -3, -762),
                LeverCF = CFrame.new(1485.67529, 7.58990526, -858.379211, 0.934665918, 3.00795797e-08, 0.355527252, -5.52280746e-08, 1, 6.05866859e-08, -0.355527252, -7.62633974e-08, 0.934665918)
            }
        }

        local ARTIFACT_ORDER = {
            "Diamond Artifact",
            "Crescent Artifact",
            "Arrow Artifact",
            "Hourglass Artifact"
        }

        local function scanArtifactsInInventory()
            local counts = {
                ["Diamond Artifact"] = 0,
                ["Crescent Artifact"] = 0,
                ["Arrow Artifact"] = 0,
                ["Hourglass Artifact"] = 0
            }
            local uuids = {
                ["Diamond Artifact"] = {},
                ["Crescent Artifact"] = {},
                ["Arrow Artifact"] = {},
                ["Hourglass Artifact"] = {}
            }
            pcall(function()
                local replion = GetPlayerDataReplion and GetPlayerDataReplion()
                if replion then
                    local ok, inv = pcall(function() return replion:GetExpect("Inventory") end)
                    if ok and inv and inv.Items and type(inv.Items) == "table" then
                        for _, item in ipairs(inv.Items) do
                            for name, data in pairs(ARTIFACT_DATA) do
                                if item.Id == data.Id then
                                    counts[name] = counts[name] + 1
                                    if item.UUID then
                                        table.insert(uuids[name], item.UUID)
                                    end
                                end
                            end
                        end
                    end
                end
            end)
            return counts, uuids
        end

        local function getArtifactUUID(artifactName)
            local _, uuids = scanArtifactsInInventory()
            if uuids[artifactName] and #uuids[artifactName] > 0 then
                return uuids[artifactName][1]
            end
            return nil
        end

        local function formatArtifactStatusText(counts)
            local lines = {}
            table.insert(lines, "Status Artifact Tas:")
            local totalHave = 0
            for _, name in ipairs(ARTIFACT_ORDER) do
                local c = counts[name] or 0
                if c > 0 then
                    totalHave = totalHave + 1
                    table.insert(lines, string.format("- %s: Ada (x%d)", name, c))
                else
                    table.insert(lines, string.format("- %s: Belum ada (x0)", name))
                end
            end
            table.insert(lines, string.format("Total: %d/4 Tersedia", totalHave))
            return table.concat(lines, "\n")
        end

        local initialArtifactCounts, _ = scanArtifactsInInventory()
        local artifactStatusParagraph = Section_MainTab_Artifact:AddParagraph({
            Title = "Status Artifact",
            Content = formatArtifactStatusText(initialArtifactCounts)
        })

        local function updateArtifactParagraphUI()
            local counts, _ = scanArtifactsInInventory()
            local formatted = formatArtifactStatusText(counts)
            SafeUpdateParagraph(artifactStatusParagraph, formatted)
            return counts
        end

        Section_MainTab_Artifact:AddButton({
            Title = "Refresh Artifact Status",
            Description = "Pindai ulang jumlah 4 jenis artifact di dalam tas",
            Callback = function()
                updateArtifactParagraphUI()
                NotifyInfo("Artifact", "Status artifact tas diperbarui.")
            end
        })

        local selectedArtifactName = "Diamond Artifact"
        Section_MainTab_Artifact:AddDropdown("Dropdown_SelectArtifactSpot", {
            Title = "Select Artifact Spot",
            Values = ARTIFACT_ORDER,
            Default = ARTIFACT_ORDER[1],
            Multi = false,
            Callback = function(val)
                if val then selectedArtifactName = val end
            end
        })

        Section_MainTab_Artifact:AddButton({
            Title = "Teleport To Artifact Fishing Spot",
            Description = "Teleport ke spot mancing artifact yang dipilih di dropdown",
            Callback = function()
                local data = ARTIFACT_DATA[selectedArtifactName]
                if data then
                    createAndTeleportToPlatform(data.FishSpot, 4)
                    NotifySuccess("Teleport", "Teleport ke spot mancing: " .. selectedArtifactName)
                end
            end
        })

        Section_MainTab_Artifact:AddButton({
            Title = "Teleport To Artifact Lever Spot",
            Description = "Teleport ke posisi tuas lever artifact yang dipilih di dropdown",
            Callback = function()
                local data = ARTIFACT_DATA[selectedArtifactName]
                if data then
                    destroyEventPlatform()
                    TeleportTo(data.LeverCF)
                    NotifySuccess("Teleport", "Teleport ke tuas: " .. selectedArtifactName)
                end
            end
        })

        local function activateLeverAtLocation(leverCF, artifactName)
            local hrp = getHRP()
            if not hrp then return false end
            TeleportTo(leverCF)
            task.wait(0.5)

            local itemUUID = getArtifactUUID(artifactName)
            local placeRemote = GetServerRemote("RE/PlaceLeverItem") or (net and net:FindFirstChild("RE/PlaceLeverItem")) or GetServerRemoteReverse("RE/PlaceLeverItem")
            if placeRemote and itemUUID then
                pcall(function()
                    placeRemote:FireServer(itemUUID)
                end)
            end

            for _ = 1, 3 do
                pcall(function()
                    for _, desc in ipairs(workspace:GetDescendants()) do
                        if desc:IsA("ProximityPrompt") and desc.Enabled then
                            local parentPart = desc.Parent
                            if parentPart and parentPart:IsA("BasePart") then
                                if (parentPart.Position - hrp.Position).Magnitude <= 18 then
                                    fireproximityprompt(desc)
                                end
                            end
                        end
                    end
                end)
                task.wait(0.3)
            end
            return true
        end

        Section_MainTab_Artifact:AddButton({
            Title = "Activate Lever At Current Spot",
            Description = "Pasang item artifact & klik tuas lever di lokasi saat ini",
            Callback = function()
                local data = ARTIFACT_DATA[selectedArtifactName]
                if data then
                    activateLeverAtLocation(data.LeverCF, selectedArtifactName)
                    NotifySuccess("Artifact", "Mencoba memasang & mengaktifkan tuas: " .. selectedArtifactName)
                    updateArtifactParagraphUI()
                end
            end
        })

        local autoCompleteArtifactActive = false
        local autoCompleteArtifactThread = nil

        local function runAutoCompleteArtifactLoop()
            while autoCompleteArtifactActive do
                local counts, _ = scanArtifactsInInventory()
                local allDone = true

                for _, artName in ipairs(ARTIFACT_ORDER) do
                    if not autoCompleteArtifactActive then break end
                    local data = ARTIFACT_DATA[artName]
                    local currentCount = counts[artName] or 0

                    if currentCount == 0 then
                        allDone = false
                        NotifyInfo("Auto Artifact", "Mancing untuk: " .. artName)
                        local targetPos = data.FishSpot
                        local hrp = getHRP()
                        if hrp then
                            createAndTeleportToPlatform(targetPos, 4)
                        end
                        task.wait(0.6)
                        equipBestFishingRod()
                        task.wait(0.4)

                        local maxFishWait = 180
                        local startWait = tick()
                        while autoCompleteArtifactActive and (tick() - startWait < maxFishWait) do
                            local cCheck, _ = scanArtifactsInInventory()
                            if (cCheck[artName] or 0) > 0 then
                                NotifySuccess("Auto Artifact", "Mendapatkan " .. artName .. "! Teleport ke tuas...")
                                break
                            end
                            task.wait(1)
                        end
                    end

                    local cNow, _ = scanArtifactsInInventory()
                    if (cNow[artName] or 0) > 0 then
                        destroyEventPlatform()
                        task.wait(0.3)
                        NotifyInfo("Auto Artifact", "Memasang " .. artName .. " ke tuas...")
                        activateLeverAtLocation(data.LeverCF, artName)
                        task.wait(1.5)
                        updateArtifactParagraphUI()
                    end
                end

                if allDone then
                    destroyEventPlatform()
                    NotifySuccess("Auto Artifact", "Semua 4 Artifact telah selesai dipasang!")
                    autoCompleteArtifactActive = false
                    break
                end
                task.wait(2)
            end
            destroyEventPlatform()
        end

        Section_MainTab_Artifact:AddToggle("Toggle_AutoCompleteArtifact", {
            Title = "Auto Complete Artifact",
            Description = "Otomatis mancing 4 jenis artifact bergantian lalu teleport & pasang ke tuas",
            Default = false,
            Callback = function(state)
                autoCompleteArtifactActive = state
                if state then
                    if autoCompleteArtifactThread then
                        pcall(function() task.cancel(autoCompleteArtifactThread) end)
                    end
                    autoCompleteArtifactThread = task.spawn(runAutoCompleteArtifactLoop)
                    NotifySuccess("Auto Artifact", "Auto Complete Artifact Aktif!")
                else
                    if autoCompleteArtifactThread then
                        pcall(function() task.cancel(autoCompleteArtifactThread) end)
                        autoCompleteArtifactThread = nil
                    end
                    destroyEventPlatform()
                    NotifyInfo("Auto Artifact", "Auto Complete Artifact Dimatikan.")
                end
            end
        })
    end)
end

if ExclusiveTab then
    pcall(function()
        local Section_ExclusiveTab_1 = ExclusiveTab:AddSection("Cloudy Fishing (Ultra Blatant)")
        Section_ExclusiveTab_1:AddToggle("Toggle_UseCastMode", {
            Title = "Use Cast Mode",
            Description = "Enable Perfect/Normal catch quality mode",
            Default = true,
            Callback = function(val) Config.UB.UseCastMode = val end
        })
        Section_ExclusiveTab_1:AddDropdown("Dropdown_CastMode", {
            Title = "Cast Mode",
            Values = {"Perfect", "Normal"},
            Default = "Perfect",
            Callback = function(val) Config.UB.CastMode = val end, Multi = false
        })
        Section_ExclusiveTab_1:AddInput("Input_CastDelaydetik", {
            Title = "Cast Delay (detik)", Placeholder = "0.3", Default = "0.3",
            Callback = function(text)
                local num = tonumber(text); if not num or num < 0 then return end
                Config.UB.Settings.CastDelay = num
            end, Finished = true
        })
        Section_ExclusiveTab_1:AddInput("Input_HookDelaydetik", {
            Title = "Hook Delay (detik)", Placeholder = "0.3", Default = "0.3",
            Callback = function(text)
                local num = tonumber(text); if not num or num < 0 then return end
                Config.UB.Settings.HookDelay = num
            end, Finished = true
        })
        Section_ExclusiveTab_1:AddToggle("Toggle_CloudyFishingBeta", { Title = "Cloudy Fishing [Beta]", Default = false, Callback = function(val) needCast = true; onToggleUB(val) end })

        local Section_ExclusiveTab_2 = ExclusiveTab:AddSection("Cloudy Max")
        Section_ExclusiveTab_2:AddDropdown("Dropdown_CastMode_2", {
            Title = "Cast Mode",
            Values = {"Perfect", "Normal"},
            Default = "Perfect",
            Callback = function(val) Config.UB.CastMode = val end, Multi = false
        })
        Section_ExclusiveTab_2:AddInput("Input_CastDelaydetik_2", {
            Title = "Cast Delay (detik)", Placeholder = "0.3", Default = "0.3",
            Callback = function(text)
                local num = tonumber(text); if not num or num < 0 then return end
                Config.UB.Settings.CastDelay = num
            end, Finished = true
        })
        Section_ExclusiveTab_2:AddToggle("Toggle_CloudyYTTA", { Title = "Cloudy YTTA", Default = false, Callback = function(val) onToggleYTTA(val) end })
        Section_ExclusiveTab_2:AddSlider("Slider_JumlahNotifCloudyYTTA", { Title = "Jumlah Notif Cloudy YTTA", Min = 1, Max = 30, Default = 3, Rounding = 0, Callback = function(val) Config.YTTA.NotifCount = val end })
        Section_ExclusiveTab_2:AddSlider("Slider_DelayAntarCatch001detik", { Title = "Delay Antar Catch (0.01 detik)", Min = 0, Max = 300, Default = 10, Rounding = 0, Callback = function(val) Config.YTTA.NotifDelay = val / 100 end })

        local Section_ExclusiveTab_3 = ExclusiveTab:AddSection("Legit Fishing")
        Section_ExclusiveTab_3:AddInput("Input_CatchDelaydetik", {
            Title = "Catch Delay (detik)", Placeholder = "0.7", Default = "0.7",
            Callback = function(text)
                local num = tonumber(text); if not num then return end
                Config.CatchDelay = math.clamp(num, 0, 5)
            end, Finished = true
        })
        Section_ExclusiveTab_3:AddToggle("Toggle_LegitFishingAutoCatch", {
            Title = "Legit Fishing (Auto Catch)", Default = false,
            Callback = function(val)
                onToggleLegitFishing(val)
            end
        })
        Section_ExclusiveTab_3:AddToggle("Toggle_PerfectionEnchant", {
            Title = "Perfection Enchant",
            Description = "Spam Perfection secara otomatis",
            Default = false,
            Callback = function(Value)
                Config.PerfectionEnchant = Value
                if Value then
                    Config.HookNotif = true
                    pcall(function() if Events.UpdateAutoFishing then CallRemote(Events.UpdateAutoFishing, true) end end)
                else
                    pcall(function() if Events.UpdateAutoFishing then CallRemote(Events.UpdateAutoFishing, false) end end)
                    Config.HookNotif = false
                end
            end
        })

        local Section_ExclusiveTab_4 = ExclusiveTab:AddSection("Cloudy V1 [NEW]")
        Section_ExclusiveTab_4:AddToggle("Toggle_UseCastMode_2", {
            Title = "Use Cast Mode",
            Description = "Enable Perfect/Normal catch quality",
            Default = true,
            Callback = function(val) Config.CloudyV1.UseCastMode = val end
        })
        Section_ExclusiveTab_4:AddDropdown("Dropdown_CastMode_3", {
            Title = "Cast Mode",
            Values = {"Perfect", "Normal"},
            Default = "Perfect",
            Callback = function(val) Config.CloudyV1.CastMode = val end, Multi = false
        })
        Section_ExclusiveTab_4:AddInput("Input_HookDelaydetik_2", {
            Title = "Hook Delay (detik)", Placeholder = "0.3", Default = "0.3",
            Callback = function(text)
                local num = tonumber(text); if not num or num < 0 then return end
                Config.CloudyV1.HookDelay = num
            end, Finished = true
        })
        Section_ExclusiveTab_4:AddInput("Input_CastDelaydetik_3", {
            Title = "Cast Delay (detik)", Placeholder = "0.3", Default = "0.3",
            Callback = function(text)
                local num = tonumber(text); if not num or num < 0 then return end
                Config.CloudyV1.CastDelay = num
            end, Finished = true
        })
        Section_ExclusiveTab_4:AddToggle("Toggle_CloudyV1NEW", { Title = "Cloudy V1 [NEW]", Default = false, Callback = function(val) needCast = true; onToggleCloudyV1(val) end })

        local Section_ExclusiveTab_5 = ExclusiveTab:AddSection("Cloudy 1N [NEW]")
        Section_ExclusiveTab_5:AddToggle("Toggle_UseCastMode_3", {
            Title = "Use Cast Mode",
            Description = "Enable Perfect/Normal catch quality",
            Default = true,
            Callback = function(val) Config.Cloudy1N.UseCastMode = val end
        })
        Section_ExclusiveTab_5:AddDropdown("Dropdown_CastMode_4", {
            Title = "Cast Mode",
            Values = {"Perfect", "Normal"},
            Default = "Perfect",
            Callback = function(val) Config.Cloudy1N.CastMode = val end, Multi = false
        })
        Section_ExclusiveTab_5:AddInput("Input_HookDelaydetik_3", {
            Title = "Hook Delay (detik)", Placeholder = "0.3", Default = "0.3",
            Callback = function(text)
                local num = tonumber(text); if not num or num < 0 then return end
                Config.Cloudy1N.HookDelay = num
            end, Finished = true
        })
        Section_ExclusiveTab_5:AddInput("Input_CastDelaydetik_4", {
            Title = "Cast Delay (detik)", Placeholder = "0.3", Default = "0.3",
            Callback = function(text)
                local num = tonumber(text); if not num or num < 0 then return end
                Config.Cloudy1N.CastDelay = num
            end, Finished = true
        })
        Section_ExclusiveTab_5:AddToggle("Toggle_Cloudy1NNEW", {
            Title = "Cloudy 1N [NEW]",
            Default = false,
            Callback = function(val)
                needCast = true
                onToggleCloudy1N(val)
            end
        })

        local Section_ExclusiveTab_Instant = ExclusiveTab:AddSection("Instant Fishing")
        Section_ExclusiveTab_Instant:AddToggle("Toggle_UseCastMode_4", {
            Title = "Use Cast Mode",
            Description = "Enable Perfect/Normal catch quality",
            Default = true,
            Callback = function(val) Config.InstantFishing.UseCastMode = val end
        })
        Section_ExclusiveTab_Instant:AddDropdown("Dropdown_CastMode_5", {
            Title = "Cast Mode",
            Values = {"Perfect", "Normal"},
            Default = "Perfect",
            Callback = function(val) Config.InstantFishing.CastMode = val end, Multi = false
        })
        Section_ExclusiveTab_Instant:AddInput("Input_CastDelay", {
            Title = "Cast Delay",
            Placeholder = "0.3", Default = "0.3",
            Callback = function(text)
                local num = tonumber(text)
                if not num or num < 0 then return end
                Config.InstantFishing.CastDelay = num
            end, Finished = true
        })
        Section_ExclusiveTab_Instant:AddInput("Input_HookDelay", {
            Title = "Hook Delay",
            Placeholder = "0.05", Default = "0.05",
            Callback = function(text)
                local num = tonumber(text)
                if not num or num < 0 then return end
                Config.InstantFishing.HookDelay = num
            end, Finished = true
        })
        Section_ExclusiveTab_Instant:AddToggle("Toggle_InstantFishing", {
            Title = "Instant Fishing",
            Default = false,
            Callback = function(val)
                if val then
                    if Config.AutoCatch then onToggleLegitFishing(false) end
                    if Config.UB.Active then onToggleUB(false) end
                    if Config.amblatant then onToggleYTTA(false) end
                    if Config.CloudyV1.Active then onToggleCloudyV1(false) end
                    if Config.Cloudy1N.Active then onToggleCloudy1N(false) end
                    if Config.InstantV2 and Config.InstantV2.Active then stopInstantV2() end
                    _G.QHBetaAnimSpeed = false
                    patchInstantBaitOverrideToCastPosition(false)
                    disableNotifDelay()
                    disableBlockNotif()
                    UB_init()
                    Config.InstantFishing.Active = true
                    needCast = true
                    isCaught = false
                    _G.NotifQueue = {}
                    _G.NotifActive = 0
                    NotifySuccess("Instant Fishing", "Aktif!")
                    Tasks.instantFishingTask = task.spawn(function()
                        while Config.InstantFishing.Active do
                            local ok, err = pcall(function()
                                ensureRodEquipped()
                                local currentTime = tick()
                                task.wait(GetCastingWait(Config.InstantFishing.CastDelay))
                                needCast = false
                                if Config.UB.Remotes.ChargeFishingRod then
                                    pcall(function() Config.UB.Remotes.ChargeFishingRod:InvokeServer({[1] = currentTime}) end)
                                end
                                local qualityParam = GetCastingQualityParam(Config.InstantFishing.UseCastMode, Config.InstantFishing.CastMode)
                                if Config.UB.Remotes.RequestMinigame then
                                    pcall(function() Config.UB.Remotes.RequestMinigame:InvokeServer(1, qualityParam, currentTime) end)
                                end
                                task.wait(math.max(Config.InstantFishing.HookDelay, 0.001))
                                Config.CatchQuality = GetCatchQuality(Config.InstantFishing.CastMode or Config.CastMode)
                                CompleteFishing(Config.CatchQuality)
                            end)
                            if not ok then warn("[QH] InstantFishing error: " .. tostring(err)); task.wait(0.02) end
                        end
                    end)
                else
                    Config.InstantFishing.Active = false
                    _G.NotifQueue = {}
                    _G.NotifActive = 0
                    if Tasks.instantFishingTask then
                        pcall(function() task.cancel(Tasks.instantFishingTask) end)
                        Tasks.instantFishingTask = nil
                    end
                    safeFire(function() if Config.UB.Remotes.CancelFishingInputs then CallRemote(Config.UB.Remotes.CancelFishingInputs) end end)
                    NotifyWarning("Instant Fishing", "Dimatikan.")
                end
            end
        })

Config.InstantV2 = {
    Active = false,
    CastMode = "Fast",
    UseCastMode = true,
    ForcePerfect = true,
    PerfectOffset = 0.0,

    ReduceAnimation = true,
    CompleteDelay = 3.0,
    CastDelay = 0.3,
    ReducedCompleteDelay = 0.001,
    ReducedCastDelay = 0.001,
}

local function getPowerFast()
    return 1
end

local function handleCastModeFast()
    return 1
end

local function instantV2_loop()
    local Charge  = Config.UB.Remotes.ChargeFishingRod
    local Request = Config.UB.Remotes.RequestMinigame
    local Complete = Config.UB.Remotes.FishingCompleted
    local CompleteRE = Config.UB.Remotes.FishingCompletedRE

    local cfg = Config.InstantV2

    local completeDelay = cfg.ReduceAnimation and (cfg.ReducedCompleteDelay or 0.001) or (cfg.CompleteDelay or 3.0)
    local castDelay = cfg.ReduceAnimation and (cfg.ReducedCastDelay or 0.001) or (cfg.CastDelay or 0.3)

    while cfg.Active do
        local success, err = pcall(function()
            ensureRodEquipped()
            local t0 = workspace:GetServerTimeNow()

            if Charge then
                Charge:InvokeServer({[1] = t0})
            end

            local power = 1

            if Request then
                Request:InvokeServer(1, power, t0)
            end

            if completeDelay > 0 then
                task.wait(completeDelay)
            end

            local quality = "Perfect"
            if Complete then
                Complete:InvokeServer(quality)
            end
            if CompleteRE then
                CompleteRE:FireServer(quality)
            end

            if castDelay > 0 then
                task.wait(castDelay)
            end
        end)

        if not success then
            warn("[InstantV2] Error: " .. tostring(err))
            task.wait(0.001)
        end
    end
end


function startInstantV2()
    if Config.InstantV2.Active then return end
    -- Matikan mode lain ...
    enableNotifDelay()
    enableBlockNotif()
    UB_init()
    Config.InstantV2.Active = true
    Tasks.instantV2Task = task.spawn(instantV2_loop)
    NotifySuccess("Instant V2", "Aktif! Mode: " .. Config.InstantV2.CastMode)
end

function stopInstantV2()
    if not Config.InstantV2.Active then return end
    Config.InstantV2.Active = false
    if Tasks.instantV2Task then
        pcall(task.cancel, Tasks.instantV2Task)
        Tasks.instantV2Task = nil
    end
    disableNotifDelay()
    disableBlockNotif()
    safeFire(function()
        if Config.UB.Remotes.CancelFishingInputs then
            CallRemote(Config.UB.Remotes.CancelFishingInputs)
        end
    end)
    NotifyWarning("Instant V2", "Dimatikan.")
end

local Section_InstantV2 = ExclusiveTab:AddSection("Super Instan [BETA]")

local castModes = {"Perfect", "Fast", "Random"}
Section_InstantV2:AddDropdown("Dropdown_CastMode_6", {
    Title = "Cast Mode",
    Values = castModes,
    Default = castModes[2],
    Callback = function(val)
        Config.InstantV2.CastMode = val
    end, Multi = false
})

Section_InstantV2:AddInput("Input_CompleteDelaydetik", {
    Title = "Complete Delay (detik)",
    Placeholder = "3.0",
    Default = "0.3",
    Callback = function(text)
        local num = tonumber(text)
        if num and num >= 0 then Config.InstantV2.CompleteDelay = num end
    end, Finished = true
})

Section_InstantV2:AddInput("Input_CastDelaydetik_5", {
    Title = "Cast Delay (detik)",
    Placeholder = "3.0",
    Default = "0.03",
    Callback = function(text)
        local num = tonumber(text)
        if num and num >= 0 then Config.InstantV2.CastDelay = num end
    end, Finished = true
})

Section_InstantV2:AddToggle("Toggle_EnableInstantFishingV2", {
    Title = "Enable Instant Fishing V2",
    Default = false,
    Callback = function(val)
        if val then startInstantV2() else stopInstantV2() end
    end
})

local InstantBobberState = {
    instantOverrideActive = false,
    instantOverrideSetupDone = false,
    activeBaitsByUserId = {},
    cosmeticFolder = nil,
    connections = {},
    baitDestroyedConn = nil,
    renderConn = nil,
    fallbackConn = nil,
}

local function patchInstantBaitOverrideToCastPosition(enabled)

    if InstantBobberState.renderConn then
        InstantBobberState.renderConn:Disconnect()
        InstantBobberState.renderConn = nil
    end
    if InstantBobberState.baitDestroyedConn then
        InstantBobberState.baitDestroyedConn:Disconnect()
        InstantBobberState.baitDestroyedConn = nil
    end
    if InstantBobberState.fallbackConn then
        InstantBobberState.fallbackConn:Disconnect()
        InstantBobberState.fallbackConn = nil
    end
    for _, conn in ipairs(InstantBobberState.connections) do
        conn:Disconnect()
    end
    table.clear(InstantBobberState.connections)
    table.clear(InstantBobberState.activeBaitsByUserId)

    if not enabled then
        InstantBobberState.instantOverrideActive = false
        return
    end

    InstantBobberState.instantOverrideActive = true

    local ok, cosmeticFolder = pcall(function()
        return workspace:WaitForChild("CosmeticFolder", 3)
    end)
    if ok and cosmeticFolder then
        InstantBobberState.cosmeticFolder = cosmeticFolder
    else
        warn("[InstantBobber] CosmeticFolder not found, bobber reposition may fail.")
    end

    local remoteCandidates = {
        "RE/BaitCastVisual", "BaitCastVisual",
        "RE/CastRod", "CastRod",
        "RE/FishingCast", "FishingCast",
        "RE/RodCast", "RodCast",
        "RE/StartFishing", "StartFishing",
        "RE/FishingStart", "FishingStart",
        "RE/Cast", "Cast",
    }

    local foundRemotes = {}
    for _, name in ipairs(remoteCandidates) do
        local remote = GetServerRemote(name)
        if remote and remote:IsA("RemoteEvent") then
            table.insert(foundRemotes, remote)
        end
    end

    local function onCastEvent(player, data)
        if not InstantBobberState.instantOverrideActive then return end
        if not player or not player.UserId then return end

        local pos
        if typeof(data) == "Vector3" then
            pos = data
        elseif typeof(data) == "table" then
            pos = data.CastPosition or data.Position or data.TargetPosition
        end
        if typeof(pos) ~= "Vector3" then return end

        InstantBobberState.activeBaitsByUserId[player.UserId] = {
            pivot = CFrame.new(pos),
            expiresAt = tick() + 0.8,
        }
    end

    for _, remote in ipairs(foundRemotes) do
        local conn = remote.OnClientEvent:Connect(onCastEvent)
        table.insert(InstantBobberState.connections, conn)
    end

    local baitDestroyed = GetServerRemote("RE/BaitDestroyed") or GetServerRemote("BaitDestroyed")
    if baitDestroyed and baitDestroyed:IsA("RemoteEvent") then
        InstantBobberState.baitDestroyedConn = baitDestroyed.OnClientEvent:Connect(function(player)
            if not InstantBobberState.instantOverrideActive then return end
            if player and player.UserId then
                InstantBobberState.activeBaitsByUserId[player.UserId] = nil
            end
        end)
    end

    if #foundRemotes == 0 then
        warn("[InstantBobber] No casting remote found. Using fallback polling (less instant).")
       
        local player = game.Players.LocalPlayer
        InstantBobberState.fallbackConn = RunService.Heartbeat:Connect(function()
            if not InstantBobberState.instantOverrideActive then return end
            if not player or not player.Character then return end

            local character = player.Character
            local bobber = character:FindFirstChild("Bobber") or character:FindFirstChild("Bait")
            if not bobber then
            
                for _, child in ipairs(workspace:GetChildren()) do
                    if child:IsA("Model") and (child.Name == "Bobber" or child.Name == "Bait") then
                        bobber = child
                        break
                    end
                end
            end
            if bobber and bobber:IsA("BasePart") and bobber.Parent then
             
                local root = character:FindFirstChild("HumanoidRootPart")
                if root then
                    local forward = root.CFrame.LookVector * 10
                    local targetPos = root.Position + forward
                    bobber.Position = targetPos
                    bobber.AssemblyLinearVelocity = Vector3.new(0, -75, 0)
                end
            end
        end)
    end

    InstantBobberState.renderConn = RunService.RenderStepped:Connect(function()
        if not InstantBobberState.instantOverrideActive then return end
        local now = tick()
        local cfolder = InstantBobberState.cosmeticFolder
        if not cfolder then
         
            local ok, folder = pcall(function() return workspace:WaitForChild("CosmeticFolder", 0) end)
            if ok and folder then
                InstantBobberState.cosmeticFolder = folder
                cfolder = folder
            else
                return
            end
        end

        for userId, entry in pairs(InstantBobberState.activeBaitsByUserId) do
            if now > entry.expiresAt then
                InstantBobberState.activeBaitsByUserId[userId] = nil
            else
                local model = cfolder:FindFirstChild(tostring(userId))
                if model and model.PivotTo then
                    model:PivotTo(entry.pivot)
                    if model:IsA("Model") and model.PrimaryPart then
                        model.PrimaryPart.AssemblyLinearVelocity = Vector3.new(0, -75, 0)
                    elseif model:IsA("BasePart") then
                        model.AssemblyLinearVelocity = Vector3.new(0, -75, 0)
                    end
                end
            end
        end
    end)

    InstantBobberState.instantOverrideSetupDone = true
end

local Section_InstantBobber = ExclusiveTab:AddSection("Instant Bobber")

Section_InstantBobber:AddToggle("Toggle_InstantBobber", {
    Title = "Instant Bobber",
    Description = "Bobber instantly moves to cast position without animation (uses BaitCastVisual remote)",
    Default = false,
    Callback = function(val)
        patchInstantBaitOverrideToCastPosition(val)
        if val then
            NotifySuccess("Instant Bobber", "ON - Bobber will snap to cast position")
        else
            NotifyInfo("Instant Bobber", "OFF")
        end
    end
})
    end)
end

   local Section_ShopTab_5 = ExclusiveTab:AddSection("Auto Sell Fish")

-- Dropdown untuk metode
local sellMethodValues = {"Sell items using a loop / With Loop", "Sell items when you reach a certain limit / With Limit"}
Section_ShopTab_5:AddDropdown("Dropdown_MetodeSell", {
    Title = "Metode Sell",
    Values = sellMethodValues,
    Default = sellMethodValues[1],
    Callback = function(val) Config.AutoSellMethod = val end,
    Multi = false
})

-- Input nilai (detik atau jumlah ikan)
Section_ShopTab_5:AddInput("Input_SellValue", {
    Title = "Sell Value",
    Placeholder = "50",
    Default = "50",
    Callback = function(text)
        local num = tonumber(text)
        if num and num > 0 then Config.AutoSellValue = math.clamp(num, 1, 9999) end
    end,
    Finished = true
})

-- Toggle untuk mengaktifkan
Section_ShopTab_5:AddToggle("Toggle_EnableAutoSell", {
    Title = "Enable Auto Sell",
    Default = false,
    Callback = function(val)
        Config.AutoSellState = val
        if val then RunAutoSellLoop()
        else if Tasks.AutoSellThread then pcall(task.cancel, Tasks.AutoSellThread) end end
    end
})

if MainTab then
    pcall(function()
        local Section_MainTab_9 = MainTab:AddSection("Crystal Depth Mining")

        _G.axeUuid = _G.axeUuid or ""
        _G.AutoMining = false
        _G.AutoMiningThread = nil
        _G.isMining = false
        local Toggle_AutoMiningCrystal = nil

        local function getAxeUUID()
            local replion = GetPlayerDataReplion()
            local inv = replion and replion:GetExpect("Inventory")
            if inv and inv.Items then
                for _, item in pairs(inv.Items) do
                    local itemData = ItemUtility and ItemUtility:GetItemData(item.Id)
                    if itemData and itemData.Data and (itemData.Data.Name:match("Axe") or itemData.Data.Name:match("Pickaxe")) then
                        _G.axeUuid = item.UUID
                        return item.UUID
                    end
                end
            end
            return nil
        end

        local function getMineableNormalCrystals()
            local crystals = {}
            pcall(function()
                local seenPrompts = {}
                local searchContainers = {}

                local islandsFolder = Workspace:FindFirstChild("Islands")
                if islandsFolder then
                    local crystalDepth = islandsFolder:FindFirstChild("Crystal Depth")
                    if crystalDepth then
                        table.insert(searchContainers, crystalDepth)
                    end
                end

                local directDepth = Workspace:FindFirstChild("Crystal Depth")
                if directDepth and not table.find(searchContainers, directDepth) then
                    table.insert(searchContainers, directDepth)
                end

                local directCrystals = Workspace:FindFirstChild("Crystals")
                if directCrystals and not table.find(searchContainers, directCrystals) then
                    table.insert(searchContainers, directCrystals)
                end

                if #searchContainers == 0 and islandsFolder then
                    for _, isl in ipairs(islandsFolder:GetChildren()) do
                        local nameLower = isl.Name:lower()
                        if nameLower:find("crystal") and not nameLower:find("lava") then
                            table.insert(searchContainers, isl)
                        end
                    end
                end

                if #searchContainers == 0 then
                    table.insert(searchContainers, Workspace)
                end

                for _, container in ipairs(searchContainers) do
                    for _, desc in ipairs(container:GetDescendants()) do
                        if desc:IsA("ProximityPrompt") and desc.Enabled and not seenPrompts[desc] then
                            local isLava = false
                            local ancestor = desc
                            while ancestor and ancestor ~= Workspace do
                                local aName = ancestor.Name:lower()
                                if aName:find("lava basin") or aName:find("veilshard") then
                                    isLava = true
                                    break
                                end
                                ancestor = ancestor.Parent
                            end

                            if not isLava then
                                local actText = (desc.ActionText or ""):lower()
                                local objText = (desc.ObjectText or ""):lower()

                                local isIgnored = actText:find("talk") or actText:find("shop") or actText:find("buy") or actText:find("sell") or actText:find("boat") or actText:find("chest") or actText:find("peti") or objText:find("chest") or objText:find("merchant") or objText:find("boat") or objText:find("npc")

                                if not isIgnored then
                                    local targetPart = nil
                                    if desc.Parent and desc.Parent:IsA("BasePart") then
                                        targetPart = desc.Parent
                                    elseif desc.Parent and desc.Parent:IsA("Model") then
                                        targetPart = desc.Parent.PrimaryPart or desc.Parent:FindFirstChildWhichIsA("BasePart")
                                    end

                                    if targetPart and targetPart:IsDescendantOf(Workspace) and targetPart.Transparency < 0.95 then
                                        seenPrompts[desc] = true
                                        local model = desc:FindFirstAncestorWhichIsA("Model") or targetPart
                                        local holdDuration = (desc.HoldDuration and desc.HoldDuration > 0) and desc.HoldDuration or 1.0

                                        table.insert(crystals, {
                                            Prompt = desc,
                                            Part = targetPart,
                                            Model = model,
                                            Position = targetPart.Position,
                                            CFrame = targetPart.CFrame,
                                            HoldDuration = holdDuration
                                        })
                                    end
                                end
                            end
                        end
                    end
                end

                local hrp = getHRP()
                if hrp and #crystals > 1 then
                    local myPos = hrp.Position
                    table.sort(crystals, function(a, b)
                        return (a.Position - myPos).Magnitude < (b.Position - myPos).Magnitude
                    end)
                end
            end)
            return crystals
        end

        local function mineNormalCrystal(crystalData, crystalIndex, totalCrystals)
            local hrp = getHRP()
            if not hrp then return false end
            local prompt = crystalData.Prompt
            local targetPart = crystalData.Part

            if not prompt or not prompt.Parent or not prompt.Enabled or not targetPart or not targetPart.Parent then
                return false
            end

            NotifyInfo("Mining", "Mining crystal " .. crystalIndex .. "/" .. totalCrystals .. "...")

            local targetPos = targetPart.Position
            local standPos = targetPos + Vector3.new(0, 1.2, 3.2)
            local lookCF = CFrame.lookAt(standPos, targetPos)

            TeleportTo(lookCF)
            task.wait(0.2)

            if _G.axeUuid and _G.axeUuid ~= "" and Events.equipItem then
                pcall(function() Events.equipItem:FireServer(_G.axeUuid, "Gears") end)
                task.wait(0.2)
            end

            pcall(function()
                prompt.RequiresLineOfSight = false
                prompt.MaxActivationDistance = math.max(prompt.MaxActivationDistance or 10, 35)
            end)

            local holdTime = (prompt.HoldDuration and prompt.HoldDuration > 0) and prompt.HoldDuration or 1.0

            if typeof(fireproximityprompt) == "function" then
                pcall(function() fireproximityprompt(prompt, 0) end)
                pcall(function() fireproximityprompt(prompt, holdTime) end)
                pcall(function() fireproximityprompt(prompt) end)
            end

            pcall(function()
                prompt:InputHoldBegin()
            end)

            local startTime = tick()
            while tick() - startTime < (holdTime + 0.3) do
                if not prompt or not prompt.Parent or not prompt.Enabled then
                    break
                end
                task.wait(0.1)
            end

            pcall(function()
                prompt:InputHoldEnd()
            end)

            if typeof(fireproximityprompt) == "function" and prompt and prompt.Parent and prompt.Enabled then
                pcall(function() fireproximityprompt(prompt) end)
            end

            task.wait(0.6)

            if prompt and prompt.Parent and prompt.Enabled and targetPart and targetPart.Parent then
                if typeof(fireproximityprompt) == "function" then
                    pcall(function() fireproximityprompt(prompt, 0) end)
                    pcall(function() fireproximityprompt(prompt, holdTime) end)
                    pcall(function() fireproximityprompt(prompt) end)
                end
                pcall(function() prompt:InputHoldBegin() end)
                local s2 = tick()
                while tick() - s2 < (holdTime + 0.2) do
                    if not prompt or not prompt.Parent or not prompt.Enabled then break end
                    task.wait(0.1)
                end
                pcall(function() prompt:InputHoldEnd() end)
                task.wait(0.4)
            end

            return true
        end

        local function ensurePickaxeEquipped()
            local lp = Players.LocalPlayer
            local char = lp and lp.Character
            if not char then return false end

            local held = char:FindFirstChildOfClass("Tool")
            if held and (held.Name:lower():find("axe") or held.Name:lower():find("pickaxe") or held.Name:lower():find("drill") or held.Name:lower():find("hammer")) then
                return true
            end

            local bp = lp:FindFirstChild("Backpack")
            if bp then
                for _, t in ipairs(bp:GetChildren()) do
                    if t:IsA("Tool") and (t.Name:lower():find("axe") or t.Name:lower():find("pickaxe") or t.Name:lower():find("drill") or t.Name:lower():find("hammer")) then
                        pcall(function() char.Humanoid:EquipTool(t) end)
                        task.wait(0.1)
                        if char:FindFirstChildOfClass("Tool") then return true end
                    end
                end
            end

            local axeUUID = (_G.veilshardAxeUuid and _G.veilshardAxeUuid ~= "") and _G.veilshardAxeUuid or (_G.axeUuid and _G.axeUuid ~= "" and _G.axeUuid or nil)
            if not axeUUID then
                axeUUID = (getVeilshardAxeUUID and getVeilshardAxeUUID()) or (getAxeUUID and getAxeUUID())
            end

            local equipItem = Events.equipItem or Events.equipItemRemote or GetServerRemote("RF/EquipItem") or GetServerRemote("RE/EquipItem")
            if axeUUID and axeUUID ~= "" and equipItem then
                pcall(function()
                    if equipItem:IsA("RemoteEvent") then
                        equipItem:FireServer(axeUUID, "Gears")
                    elseif equipItem:IsA("RemoteFunction") then
                        equipItem:InvokeServer(axeUUID, "Gears")
                    end
                end)
                task.wait(0.2)
            end

            return true
        end

        local function runCrystalDepthMining(isContinuous)
            if _G.isMining and not isContinuous then return end
            _G.isMining = true

            local hrp = getHRP()
            if not hrp then
                _G.isMining = false
                _G.AutoMining = false
                if Toggle_AutoMiningCrystal and Toggle_AutoMiningCrystal.SetValue then
                    pcall(function() Toggle_AutoMiningCrystal:SetValue(false) end)
                end
                return
            end

            ensurePickaxeEquipped()

            local savedCFrame = hrp.CFrame
            local depthPos = LOCATIONS["Crystal Depth"] or Vector3.new(5504.77, -904.97, 15290.48)
            local hasInitialTeleported = false

            while (isContinuous and _G.AutoMining) or (not isContinuous and _G.isMining) do
                local hrpCurrent = getHRP()
                if not hrpCurrent then task.wait(1); continue end

                if not hasInitialTeleported then
                    hasInitialTeleported = true
                    NotifyInfo("Mining", "Teleporting ke Crystal Depth untuk deteksi awal...")
                    TeleportTo(CFrame.new(depthPos + Vector3.new(0, 5, 0)))
                    task.wait(0.5)
                    ensurePickaxeEquipped()

                    -- Tunggu 5 detik untuk deteksi crystal
                    NotifyInfo("Mining", "Menunggu 5 detik deteksi crystal...")
                    local waited = 0
                    while waited < 5 and ((isContinuous and _G.AutoMining) or (not isContinuous and _G.isMining)) do
                        task.wait(0.5)
                        waited = waited + 0.5
                    end
                    if isContinuous and not _G.AutoMining then break end
                    if not isContinuous and not _G.isMining then break end

                    local crystals = getMineableNormalCrystals()
                    if #crystals > 0 then
                        NotifySuccess("Mining", "Ditemukan " .. #crystals .. " crystal! Mulai mining...")
                        for i, crystalData in ipairs(crystals) do
                            if isContinuous and not _G.AutoMining then break end
                            if not isContinuous and not _G.isMining then break end
                            ensurePickaxeEquipped()
                            mineNormalCrystal(crystalData, i, #crystals)
                            task.wait(0.5)
                        end
                    else
                        NotifyWarning("Mining", "Tidak ada crystal saat ini. Kembali ke posisi awal...")
                    end

                    -- Balik ke tempat semula
                    TeleportTo(savedCFrame * CFrame.new(0, 20, 0))
                    task.wait(0.2)
                    TeleportTo(savedCFrame)

                    if not isContinuous then
                        NotifySuccess("Mining", "Selesai 1x putaran mining Crystal Depth!")
                        break
                    else
                        NotifyInfo("Mining", "Kembali ke posisi semula. Lanjut scan berkala di tempat...")
                    end
                else
                    -- Scan berikutnya: Scan di tempat tanpa teleport
                    local crystals = getMineableNormalCrystals()
                    if #crystals > 0 then
                        NotifySuccess("Mining", "Crystal baru terdeteksi (" .. #crystals .. ")! Teleporting ke Crystal Depth...")
                        TeleportTo(CFrame.new(depthPos + Vector3.new(0, 5, 0)))
                        task.wait(0.5)
                        ensurePickaxeEquipped()

                        for i, crystalData in ipairs(crystals) do
                            if not _G.AutoMining then break end
                            ensurePickaxeEquipped()
                            mineNormalCrystal(crystalData, i, #crystals)
                            task.wait(0.5)
                        end

                        -- Balik ke tempat semula
                        TeleportTo(savedCFrame * CFrame.new(0, 20, 0))
                        task.wait(0.2)
                        TeleportTo(savedCFrame)
                        NotifySuccess("Mining", "Mining selesai! Kembali ke posisi semula & lanjut scan di tempat...")
                    end

                    -- Delay antar scan di tempat
                    local delayCount = 0
                    while delayCount < 5 and _G.AutoMining do
                        task.wait(1)
                        delayCount = delayCount + 1
                    end
                end
            end

            _G.isMining = false
            _G.AutoMining = false
            if Toggle_AutoMiningCrystal and Toggle_AutoMiningCrystal.SetValue then
                pcall(function() Toggle_AutoMiningCrystal:SetValue(false) end)
            end
        end

        Section_MainTab_9:AddButton({
            Title = "Mine Crystal Depth (1x Run)",
            Description = "Scan crystal mineable, hold ProximityPrompt, dan kembali ke posisi semula (1x selesai)",
            Callback = function()
                task.spawn(function()
                    runCrystalDepthMining(false)
                end)
            end
        })

        Toggle_AutoMiningCrystal = Section_MainTab_9:AddToggle("Toggle_AutoMiningCrystal", {
            Title = "Auto Mining Crystal Depth (1x Run)",
            Description = "Aktifkan untuk 1x mining semua crystal di Crystal Depth lalu otomatis mati",
            Default = false,
            Callback = function(state)
                _G.AutoMining = state
                if state then
                    if _G.AutoMiningThread then
                        pcall(function() task.cancel(_G.AutoMiningThread) end)
                        _G.AutoMiningThread = nil
                    end
                    _G.AutoMiningThread = task.spawn(function()
                        runCrystalDepthMining(true)
                        _G.AutoMiningThread = nil
                    end)
                else
                    _G.isMining = false
                    if _G.AutoMiningThread then
                        pcall(function() task.cancel(_G.AutoMiningThread) end)
                        _G.AutoMiningThread = nil
                    end
                    NotifyInfo("Mining", "Auto mining dihentikan.")
                end
            end
        })


        local Section_MainTab_10 = MainTab:AddSection("Veilshard Mining (Lava Basin)")

        _G.veilshardAxeUuid = _G.veilshardAxeUuid or ""
        _G.VeilshardMiningActive = false
        _G.VeilshardMiningThread = nil

        local function getVeilshardAxeUUID()
            local replion = GetPlayerDataReplion()
            local inv = replion and replion:GetExpect("Inventory")
            if inv and inv.Items then
                for _, item in pairs(inv.Items) do
                    local itemData = ItemUtility and ItemUtility:GetItemData(item.Id)
                    if itemData and itemData.Data and (itemData.Data.Name:match("Axe") or itemData.Data.Name:match("Pickaxe")) then
                        _G.veilshardAxeUuid = item.UUID
                        return item.UUID
                    end
                end
            end
            return nil
        end

        local function getMineableVeilshardCrystals()
            local crystals = {}
            pcall(function()
                local lavaBasin = workspace:FindFirstChild("Islands")
                if not lavaBasin then return end
                lavaBasin = lavaBasin:FindFirstChild("Lava Basin")
                if not lavaBasin then return end
                local crystalsFolder = lavaBasin:FindFirstChild("Crystals")
                if not crystalsFolder then return end
                for _, crystal in ipairs(crystalsFolder:GetChildren()) do
                    if crystal:IsA("Model") and crystal.Name == "Crystal" then
                        local isMineable = false
                        for _, child in ipairs(crystal:GetDescendants()) do
                            if child:IsA("BasePart") then
                                local color = child.Color
                                if color.R > 0.4 and color.B > 0.5 and color.G < 0.3 then
                                    isMineable = true
                                    break
                                end
                                if child:FindFirstChild("Mineable") or child:GetAttribute("Mineable") == true then
                                    isMineable = true
                                    break
                                end
                            end
                        end

                        if not isMineable then
                            for _, child in ipairs(crystal:GetDescendants()) do
                                if child:IsA("ProximityPrompt") and child.Enabled then
                                    isMineable = true
                                    break
                                elseif child:IsA("ClickDetector") then
                                    isMineable = true
                                    break
                                end
                            end
                        end
                        if isMineable then
                            local primaryPart = crystal.PrimaryPart or crystal:FindFirstChildWhichIsA("BasePart")
                            if primaryPart then
                                table.insert(crystals, {
                                    Model = crystal,
                                    Position = primaryPart.Position,
                                    CFrame = primaryPart.CFrame
                                })
                            end
                        end
                    end
                end
            end)
            return crystals
        end

        local function mineVeilshardCrystal(crystalData, crystalIndex, totalCrystals)
            local hrp = getHRP()
            if not hrp then return false end

            NotifyInfo("Veilshard", "Teleporting to crystal " .. crystalIndex .. "/" .. totalCrystals .. "...")

            local highTarget = crystalData.CFrame * CFrame.new(0, 12, 0)
            TeleportTo(highTarget)
            task.wait(0.2)

            local mineTarget = crystalData.CFrame * CFrame.new(0, 4, 0)
            TeleportTo(mineTarget)
            task.wait(0.2)

            ensurePickaxeEquipped()

            pcall(function()
                for _, child in ipairs(crystalData.Model:GetDescendants()) do
                    if child:IsA("ClickDetector") and typeof(fireclickdetector) == "function" then
                        pcall(function() fireclickdetector(child) end)
                    elseif child:IsA("ProximityPrompt") and typeof(fireproximityprompt) == "function" then
                        pcall(function() fireproximityprompt(child) end)
                    end
                end
            end)
            task.wait(1.2)
            return true
        end

        local function runVeilshardMining(isContinuous)
            local hrp = getHRP()
            if not hrp then return end

            ensurePickaxeEquipped()

            local savedCFrame = hrp.CFrame
            local lavaBasinPos = CFrame.new(950.876, 85.282, -10199.427)
            local hasInitialTeleported = false

            while (isContinuous and _G.VeilshardMiningActive) or (not isContinuous and _G.isVeilshardMining) do
                local hrpCurrent = getHRP()
                if not hrpCurrent then task.wait(1); continue end

                if not hasInitialTeleported then
                    hasInitialTeleported = true
                    NotifyInfo("Veilshard", "Teleporting ke Lava Basin untuk deteksi awal...")
                    TeleportTo(CFrame.new(950.876, 140, -10199.427))
                    task.wait(0.2)
                    TeleportTo(lavaBasinPos)
                    task.wait(0.5)
                    ensurePickaxeEquipped()

                    -- Tunggu 5 detik untuk deteksi crystal
                    NotifyInfo("Veilshard", "Menunggu 5 detik deteksi crystal...")
                    local waited = 0
                    while waited < 5 and ((isContinuous and _G.VeilshardMiningActive) or (not isContinuous and _G.isVeilshardMining)) do
                        task.wait(0.5)
                        waited = waited + 0.5
                    end
                    if isContinuous and not _G.VeilshardMiningActive then break end
                    if not isContinuous and not _G.isVeilshardMining then break end

                    local crystals = getMineableVeilshardCrystals()
                    if #crystals > 0 then
                        NotifySuccess("Veilshard", "Ditemukan " .. #crystals .. " crystal! Mulai mining...")
                        for i, crystalData in ipairs(crystals) do
                            if isContinuous and not _G.VeilshardMiningActive then break end
                            if not isContinuous and not _G.isVeilshardMining then break end
                            ensurePickaxeEquipped()
                            mineVeilshardCrystal(crystalData, i, #crystals)
                            if i < #crystals then
                                NotifyInfo("Veilshard", "Cooldown 11 detik...")
                                task.wait(11)
                            end
                        end
                    else
                        NotifyWarning("Veilshard", "Tidak ada crystal saat ini. Kembali ke posisi awal...")
                    end

                    -- Balik ke tempat semula
                    TeleportTo(savedCFrame * CFrame.new(0, 50, 0))
                    task.wait(0.2)
                    TeleportTo(savedCFrame)

                    if not isContinuous then
                        NotifySuccess("Veilshard", "Selesai 1x putaran mining Veilshard!")
                        break
                    else
                        NotifyInfo("Veilshard", "Kembali ke posisi semula. Lanjut scan berkala di tempat...")
                    end
                else
                    -- Scan berikutnya: Scan di tempat tanpa teleport
                    local crystals = getMineableVeilshardCrystals()
                    if #crystals > 0 then
                        NotifySuccess("Veilshard", "Veilshard crystal terdeteksi (" .. #crystals .. ")! Teleporting ke Lava Basin...")
                        TeleportTo(CFrame.new(950.876, 140, -10199.427))
                        task.wait(0.2)
                        TeleportTo(lavaBasinPos)
                        task.wait(0.5)
                        ensurePickaxeEquipped()

                        for i, crystalData in ipairs(crystals) do
                            if not _G.VeilshardMiningActive then break end
                            ensurePickaxeEquipped()
                            mineVeilshardCrystal(crystalData, i, #crystals)
                            if i < #crystals then
                                NotifyInfo("Veilshard", "Cooldown 11 detik...")
                                task.wait(11)
                            end
                        end

                        -- Balik ke tempat semula
                        TeleportTo(savedCFrame * CFrame.new(0, 50, 0))
                        task.wait(0.2)
                        TeleportTo(savedCFrame)
                        NotifySuccess("Veilshard", "Mining selesai! Kembali ke posisi semula & lanjut scan di tempat...")
                    end

                    -- Delay antar scan di tempat
                    local delayCount = 0
                    while delayCount < 5 and _G.VeilshardMiningActive do
                        task.wait(1)
                        delayCount = delayCount + 1
                    end
                end
            end

            _G.isVeilshardMining = false
            _G.VeilshardMiningActive = false
        end

        Section_MainTab_10:AddButton({
            Title = "Manual Mine Veilshard",
            Description = "Teleport ke Lava Basin & mining semua crystal (Anti-Detect)",
            Callback = function()
                _G.isVeilshardMining = true
                task.spawn(function()
                    runVeilshardMining(false)
                end)
            end
        })

        Section_MainTab_10:AddToggle("Toggle_AutoMineVeilshard", {
            Title = "Auto Mine Veilshard",
            Description = "Otomatis teleport ke Lava Basin & mining crystal (Anti-Detect loop)",
            Default = false,
            Callback = function(state)
                _G.VeilshardMiningActive = state
                if state then
                    if _G.VeilshardMiningThread then
                        pcall(function() task.cancel(_G.VeilshardMiningThread) end)
                        _G.VeilshardMiningThread = nil
                    end
                    _G.VeilshardMiningThread = task.spawn(function()
                        runVeilshardMining(true)
                        _G.VeilshardMiningThread = nil
                    end)
                    NotifySuccess("Veilshard", "Auto mining aktif! Anti-Detect Teleport Mode.")
                else
                    _G.isVeilshardMining = false
                    if _G.VeilshardMiningThread then
                        pcall(function() task.cancel(_G.VeilshardMiningThread) end)
                        _G.VeilshardMiningThread = nil
                    end
                    NotifyInfo("Veilshard", "Auto mining dihentikan.")
                end
            end
        })

        _G.QH_TreasureHopActive = _G.QH_TreasureHopActive or false
        local function CheckAndHopForTreasure()
            if not _G.QH_TreasureHopActive then return end

            local wreckage = workspace:FindFirstChild("Sunken Wreckage")
            if wreckage then
                NotifySuccess("Treasure Hop", "FOUND! Treasure Hunt event detected in this server!")
                _G.QH_TreasureHopActive = false
                return
            end

            NotifyWarning("Treasure Hop", "No Treasure Hunt here. Hopping to next server...")
            task.wait(2)

            local PlaceID = game.PlaceId
            local AllIDs = {}
            local foundAnything = ""

            local function TPReturner()
                local Site
                if foundAnything == "" then
                    Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
                else
                    Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
                end

                if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
                    foundAnything = Site.nextPageCursor
                end

                for _, server in pairs(Site.data) do
                    local possible = true
                    local ID = tostring(server.id)
                    if tonumber(server.maxPlayers) > tonumber(server.playing) then
                        for _, Existing in pairs(AllIDs) do
                            if ID == tostring(Existing) then
                                possible = false
                            end
                        end
                        if possible then
                            table.insert(AllIDs, ID)
                            task.wait()
                            pcall(function()
                                game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, ID, LocalPlayer)
                            end)
                            task.wait(4)
                        end
                    end
                end
            end

            while _G.QH_TreasureHopActive do
                pcall(TPReturner)
                task.wait(1)
            end
        end

        local function StartAutoHopForTreasure()
            _G.QH_TreasureHopActive = true
            task.spawn(CheckAndHopForTreasure)
        end

        local function StopAutoHopForTreasure()
            _G.QH_TreasureHopActive = false
            NotifyWarning("Treasure Hop", "Auto-hop disabled.")
        end

        do
            local TH = {
                Active = false,
                Thread = nil,
                IsRunning = false,
                LastPosition = nil,
                ScanInterval = 2,
                Debug = true,
            }

            local function thPrint(msg)
                if TH.Debug then
                    print("[QH-Treasure] " .. tostring(msg))
                end
            end

            local function thNotify(title, msg, kind)
                local ok, _ = pcall(function()
                    if kind == "success" and NotifySuccess then
                        NotifySuccess(title, msg)
                    elseif kind == "warn" and NotifyWarning then
                        NotifyWarning(title, msg)
                    elseif kind == "error" and NotifyError then
                        NotifyError(title, msg)
                    elseif kind == "info" and NotifyInfo then
                        NotifyInfo(title, msg)
                    end
                end)
                if not ok then
                    thPrint("[" .. (kind or "?") .. "] " .. title .. ": " .. msg)
                end
            end

            local function safeGetHRP()
                if typeof(getHRP) == "function" then
                    local ok, hrp = pcall(getHRP)
                    if ok and hrp then return hrp end
                end
                local ok, lp = pcall(function() return game:GetService("Players").LocalPlayer end)
                if not ok or not lp then return nil end
                local ok2, char = pcall(function() return lp.Character end)
                if not ok2 or not char then return nil end
                local ok3, hrp = pcall(function() return char:FindFirstChild("HumanoidRootPart") end)
                if ok3 and hrp then return hrp end
                return nil
            end

            local function findWreckage()
                local ok, result = pcall(function()
                    return workspace:FindFirstChild("Sunken Wreckage")
                end)
                if ok then return result end
                return nil
            end

            local function getChest(wreckage)
                if not wreckage then return nil end
                local ok, descs = pcall(function()
                    return wreckage:GetDescendants()
                end)
                if not ok or not descs then return nil end

                local bestChest = nil
                local bestDist = math.huge
                local hrp = safeGetHRP()
                local playerPos = hrp and hrp.Position or Vector3.new()

                for _, obj in ipairs(descs) do
                    local ok2, name = pcall(function() return obj.Name end)
                    if not ok2 or not name then continue end

                    local nameLower = string.lower(name)
                    local isChestName = string.find(nameLower, "chest") or string.find(nameLower, "treasure")
                        or string.find(nameLower, "loot") or string.find(nameLower, "reward") or string.find(nameLower, "peti")
                        or string.find(nameLower, "harta") or string.find(nameLower, "box")

                    local prompt = nil
                    local click = nil
                    local targetObj = obj

                    pcall(function()
                        if obj:IsA("ProximityPrompt") then prompt = obj; targetObj = obj.Parent end
                        if obj:IsA("ClickDetector") then click = obj; targetObj = obj.Parent end
                    end)

                    if not prompt and not click then
                        pcall(function()
                            for _, d in ipairs(obj:GetDescendants()) do
                                if d:IsA("ProximityPrompt") then prompt = d; break end
                                if d:IsA("ClickDetector") then click = d; break end
                            end
                        end)
                    end

                    local isInteractable = (prompt ~= nil) or (click ~= nil)

                    if isChestName or isInteractable then
                        local cf = nil
                        local partPos = nil
                        pcall(function()
                            if targetObj:IsA("BasePart") then
                                cf = targetObj.CFrame
                                partPos = targetObj.Position
                            elseif targetObj.PrimaryPart then
                                cf = targetObj.PrimaryPart.CFrame
                                partPos = targetObj.PrimaryPart.Position
                            else
                                local part = targetObj:FindFirstChildWhichIsA("BasePart")
                                if part then cf = part.CFrame; partPos = part.Position end
                            end
                        end)

                        if cf and partPos then
                            local dist = (partPos - playerPos).Magnitude
                            if isInteractable and dist < bestDist then
                                bestDist = dist
                                bestChest = {
                                    Object = targetObj,
                                    CFrame = cf,
                                    Prompt = prompt,
                                    Click = click,
                                }
                            end
                        end
                    end
                end
                return bestChest
            end

            local function lootChestDirect(chest, savedPos)
                local hrp = safeGetHRP()
                if not hrp or not chest then return false end

                local chestPart = nil
                pcall(function()
                    if chest.Object:IsA("BasePart") then
                        chestPart = chest.Object
                    elseif chest.Object.PrimaryPart then
                        chestPart = chest.Object.PrimaryPart
                    else
                        chestPart = chest.Object:FindFirstChildWhichIsA("BasePart")
                    end
                end)

                if not chestPart then return false end

                local targetPos = chestPart.Position + Vector3.new(0, 1.5, 2.5)
                local targetCF = CFrame.lookAt(targetPos, chestPart.Position)

                local ok = TeleportTo(targetCF)
                if not ok then
                    pcall(function() hrp.CFrame = targetCF end)
                end
                task.wait(0.35)

                local opened = false

                if chest.Prompt and chest.Prompt.Parent then
                    pcall(function()
                        chest.Prompt.RequiresLineOfSight = false
                        chest.Prompt.MaxActivationDistance = math.max(chest.Prompt.MaxActivationDistance or 10, 35)
                    end)

                    local holdTime = (chest.Prompt.HoldDuration and chest.Prompt.HoldDuration > 0) and chest.Prompt.HoldDuration or 0.7

                    if typeof(fireproximityprompt) == "function" then
                        pcall(function() fireproximityprompt(chest.Prompt, 0) end)
                        pcall(function() fireproximityprompt(chest.Prompt, holdTime) end)
                        pcall(function() fireproximityprompt(chest.Prompt) end)
                    end

                    pcall(function()
                        chest.Prompt:InputHoldBegin()
                    end)

                    local startTime = tick()
                    while tick() - startTime < (holdTime + 0.25) do
                        if not chest.Prompt or not chest.Prompt.Parent or not chest.Prompt.Enabled then
                            break
                        end
                        task.wait(0.1)
                    end

                    pcall(function()
                        chest.Prompt:InputHoldEnd()
                    end)

                    if typeof(fireproximityprompt) == "function" and chest.Prompt and chest.Prompt.Parent and chest.Prompt.Enabled then
                        pcall(function() fireproximityprompt(chest.Prompt) end)
                    end

                    opened = true
                end

                if not opened and chest.Click and chest.Click.Parent then
                    pcall(function()
                        if typeof(fireclickdetector) == "function" then
                            fireclickdetector(chest.Click)
                        else
                            chest.Click:MouseClick()
                        end
                        opened = true
                    end)
                end

                thNotify("Treasure", "Peti diklaim! Menunggu 4 detik...", "info")
                task.wait(4)

                if savedPos then
                    thNotify("Treasure", "Kembali ke posisi semula...", "info")
                    local hrp2 = safeGetHRP()
                    if hrp2 then
                        local ok2 = TeleportTo(savedPos * CFrame.new(0, 10, 0))
                        if not ok2 then pcall(function() hrp2.CFrame = savedPos end) end
                        task.wait(0.2)
                        TeleportTo(savedPos)
                    end
                end

                return opened
            end

            local function runHunt()
                if TH.IsRunning then return end
                TH.IsRunning = true

                TH.Thread = task.spawn(function()
                    while TH.Active do
                        local ok, err = pcall(function()
                            local hrp = safeGetHRP()
                            if hrp then
                                TH.LastPosition = hrp.CFrame
                            end

                            local wreckage = findWreckage()
                            if not wreckage then
                                thPrint("Menunggu Sunken Wreckage...")
                                task.wait(TH.ScanInterval)
                                return
                            end

                            local chest = getChest(wreckage)
                            if not chest then
                                thNotify("Treasure", "Wreckage kosong / peti sudah diambil. Scan ulang...", "warn")
                                task.wait(TH.ScanInterval)
                                return
                            end

                            local chestValid = false
                            pcall(function()
                                if chest.Prompt and chest.Prompt.Parent and chest.Prompt.Enabled then
                                    chestValid = true
                                elseif chest.Click and chest.Click.Parent then
                                    chestValid = true
                                end
                            end)
                            if not chestValid then
                                thNotify("Treasure", "Peti sudah tidak aktif. Scan ulang...", "warn")
                                task.wait(TH.ScanInterval)
                                return
                            end

                            thNotify("Treasure", "Peti ditemukan! Teleport ke peti...", "success")

                            local savedPos = TH.LastPosition
                            local opened = lootChestDirect(chest, savedPos)

                            if opened then
                                thNotify("Treasure", "Peti berhasil di-loot & kembali ke posisi semula!", "success")
                                task.wait(5)
                            else
                                thNotify("Treasure", "Gagal loot peti", "warn")
                                task.wait(3)
                            end

                            TH.LastPosition = nil
                            task.wait(3)
                        end)

                        if not ok then
                            warn("[QH-Treasure] ERROR: " .. tostring(err))
                            thNotify("Treasure", "Error: " .. tostring(err):sub(1, 50), "error")
                            task.wait(3)
                        end
                    end

                    TH.IsRunning = false
                    thNotify("Treasure", "Auto Treasure Hunt dihentikan.", "info")
                end)
            end

            local function stopHunt()
                TH.Active = false
                if TH.Thread then
                    pcall(function()
                        if typeof(task.cancel) == "function" then
                            task.cancel(TH.Thread)
                        end
                    end)
                    TH.Thread = nil
                end

                local hrp = safeGetHRP()
                if hrp then
                    pcall(function() hrp.Anchored = false end)
                end
                TH.IsRunning = false
            end

            local Section_MainTab_11 = MainTab:AddSection("Auto Treasure Hunt")

            Section_MainTab_11:AddToggle("Toggle_AutoTreasureHunt", {
                Title = "Auto Treasure Hunt",
                Description = "Auto scan Sunken Wreckage, teleport langsung ke peti, tunggu 4 detik, dan kembali",
                Default = false,
                Callback = function(val)
                    TH.Active = val
                    if val then
                        runHunt()
                        thNotify("Treasure", "Auto aktif! Scanning...", "success")
                    else
                        stopHunt()
                        thNotify("Treasure", "Dimatikan.", "warn")
                    end
                end
            })

            Section_MainTab_11:AddButton({
                Title = "Force Scan & Loot Once",
                Description = "Teleport langsung 1x ke peti Sunken Wreckage, tunggu 4 detik, lalu kembali",
                Callback = function()
                    task.spawn(function()
                        local hrp = safeGetHRP()
                        local savedPos = hrp and hrp.CFrame or nil

                        local wreckage = findWreckage()
                        if not wreckage then
                            thNotify("Treasure", "Sunken Wreckage tidak ada di server ini!", "warn")
                            return
                        end
                        local chest = getChest(wreckage)
                        if not chest then
                            thNotify("Treasure", "Peti tidak ditemukan atau sudah diambil!", "warn")
                            return
                        end

                        thNotify("Treasure", "Teleport langsung ke peti...", "info")
                        local ok = lootChestDirect(chest, savedPos)
                        if ok then
                            thNotify("Treasure", "Manual loot selesai & kembali ke posisi semula!", "success")
                        end
                    end)
                end
            })

            Section_MainTab_11:AddToggle("Toggle_AutoHopServerTreasureHunt", {
                Title = "Auto Hop Server for Treasure Hunt",
                Description = "Hop server terus sampai ketemu event Treasure Hunt (Sunken Wreckage)",
                Default = false,
                Callback = function(val)
                    if val then
                        StartAutoHopForTreasure()
                        NotifySuccess("Treasure Hop", "Auto-hop aktif! Mencari server dengan Treasure Hunt...")
                    else
                        StopAutoHopForTreasure()
                    end
                end
            })

            Section_MainTab_11:AddButton({
                Title = "Hop Server for Treasure Hunt",
                Description = "Hop ke server lain & cek apakah ada Treasure Hunt",
                Callback = function()
                    NotifyInfo("Treasure Hop", "Hopping server...")
                    StartAutoHopForTreasure()
                end
            })
        end

        local Section_MainTab_12 = MainTab:AddSection("Totem Controls")

        local totemData = {
            ["Pilih Totem"] = 0,
            ["Luck Totem"] = 1,
            ["Mutation Totem"] = 2,
            ["Shiny Totem"] = 3,
            ["Super Love Totem"] = 4,
            ["Love Totem"] = 5,
            ["Super Easter Totem"] = 6,
            ["Easter Totem"] = 7,
            ["Noob Totem"] = 8,
            ["Abyssal Totem"] = 9,
            ["Cosmic Totem"] = 10,
            ["Super Cosmic Totem"] = 11
        }
        local totemValues = {
            "Pilih Totem",
            "Luck Totem",
            "Mutation Totem",
            "Shiny Totem",
            "Super Love Totem",
            "Love Totem",
            "Super Easter Totem",
            "Easter Totem",
            "Noob Totem",
            "Abyssal Totem",
            "Cosmic Totem",
            "Super Cosmic Totem"
        }
        Section_MainTab_12:AddDropdown("Dropdown_ChooseTotem", {
            Title = "Choose Totem",
            Values = totemValues,
            Default = totemValues[1],
            Callback = function(val)
                Config.SelectedTotemID = totemData[val] or 0
                Config.SelectedTotemName = val
                NotifyInfo("Totem", "Totem dipilih: " .. val)
            end,
            Multi = false
        })

        Section_MainTab_12:AddToggle("Toggle_AutoSpawnTotem", {
            Title = "Auto Spawn Totem",
            Description = "Spawn otomatis dengan cooldown 1 jam",
            Default = false,
            Callback = function(Value)
                Config.AutoTotem = Value
                if Value then
                    Tasks.totemTask = task.spawn(function()
                        while Config.AutoTotem do
                            pcall(function()
                                if not Events.SpawnTotem then
                                    Events.SpawnTotem = GetServerRemote("RE/SpawnTotem") or GetServerRemote("SpawnTotem")
                                end
                                local totemUUID = nil
                                pcall(function()
                                    local replion = GetPlayerDataReplion()
                                    local inv = replion and replion:GetExpect("Inventory")
                                    if inv and inv.Totems then
                                        for _, item in ipairs(inv.Totems) do
                                            if Config.SelectedTotemID == 0 or tonumber(item.Id) == Config.SelectedTotemID then
                                                totemUUID = item.UUID
                                                break
                                            end
                                        end
                                    end
                                end)
                                if totemUUID and Events.SpawnTotem then
                                    pcall(function() Events.SpawnTotem:FireServer(totemUUID) end)
                                    NotifySuccess("Totem", "Totem berhasil di-spawn!")
                                    task.wait(3)
                                    equipRod()
                                else
                                    if Config.SelectedTotemID ~= 0 then
                                        local totemName = Config.SelectedTotemName or "Totem"
                                        NotifyWarning("Totem", totemName .. " tidak ditemukan di inventory!")
                                    end
                                end
                            end)
                            task.wait(3600)
                        end
                    end)
                else
                    if Tasks.totemTask then pcall(function() task.cancel(Tasks.totemTask) end) end
                end
            end
        })

        local Section_MainTab_13 = MainTab:AddSection("Auto Mix 3 Totem [BETA]")

        local _mixTotemBaseplates = {}
        local MIN_MIX_TOTEM_RADIUS = 78

        local function ClearMixTotemBaseplates()
            for _, bp in ipairs(_mixTotemBaseplates) do
                pcall(function() if bp and bp.Parent then bp:Destroy() end end)
            end
            _mixTotemBaseplates = {}
        end

        local function GetMixTotemSpots(startCFrame)
            local radius = MIN_MIX_TOTEM_RADIUS
            local forward = startCFrame.LookVector
            local right = startCFrame.RightVector
            local origin = startCFrame.Position

            local spot1 = CFrame.new(origin + forward * radius)
            local spot2 = CFrame.new(origin - forward * (radius * 0.5) + right * (radius * 0.866))
            local spot3 = CFrame.new(origin - forward * (radius * 0.5) - right * (radius * 0.866))

            return {
                spot1,
                spot2,
                spot3
            }
        end

        local function MixTotemSmoothFly(targetCF, duration)
            return TeleportTo(targetCF)
        end

        local function DropTotemAtPosition(totemUUID, targetCFrame, index)
            local hrp = getHRP()
            if not hrp then return false end

            local baseplate = Instance.new("Part")
            baseplate.Name = "QH_MixTotemBaseplate_" .. tostring(index)
            baseplate.Size = Vector3.new(14, 0.5, 14)
            baseplate.CFrame = targetCFrame * CFrame.new(0, -2.5, 0)
            baseplate.Anchored = true
            baseplate.Transparency = 1
            baseplate.CanCollide = true
            baseplate.CanTouch = false
            baseplate.CastShadow = false
            baseplate.Parent = Workspace
            table.insert(_mixTotemBaseplates, baseplate)

            local flyTarget = targetCFrame * CFrame.new(0, 0.5, 0)
            TeleportTo(flyTarget)
            task.wait(0.1)

            local movedHrp = getHRP()
            if movedHrp then
                pcall(function()
                    movedHrp.AssemblyLinearVelocity = Vector3.zero
                    movedHrp.AssemblyAngularVelocity = Vector3.zero
                end)
            end

            pcall(function()
                if not Events.SpawnTotem then
                    Events.SpawnTotem = GetServerRemote("RE/SpawnTotem") or GetServerRemote("SpawnTotem")
                end
                if Events.SpawnTotem then
                    Events.SpawnTotem:FireServer(totemUUID)
                elseif Events.equipItemRemote then
                    Events.equipItemRemote:FireServer(totemUUID, "Totems")
                end
            end)
            task.wait(0.3)

            pcall(function()
                if Events.equipToolRemote then
                    Events.equipToolRemote:FireServer(1)
                elseif Events.equip then
                    CallRemote(Events.equip, 1)
                end
            end)
            task.wait(0.15)

            pcall(function()
                if Events.unequip then
                    Events.unequip:FireServer()
                end
            end)
            task.wait(0.1)

            pcall(function()
                local RE_Unequip = GetServerRemote("RE/UnequipToolFromHotbar")
                if RE_Unequip then
                    RE_Unequip:FireServer()
                end
            end)
            task.wait(0.1)

            return true
        end

        Section_MainTab_13:AddToggle("Toggle_AutoMix3TotemBETA", {
            Title = "Auto Mix 3 Totem [BETA]",
            Description = "Fast Teleport -> Pasang 3 totem minimal jarak -> Kembali ke posisi awal",
            Default = false,
            Callback = function(v)
                Config.AutoMixTotem = v
                if v then
                    Tasks.mixTotemThread = task.spawn(function()
                        local MIX_CONFIG = {
                            { name = "Shiny Totem", id = 3 },
                            { name = "Luck Totem", id = 1 },
                            { name = "Mutation Totem", id = 2 }
                        }

                        while Config.AutoMixTotem do
                            local hrp = getHRP()
                            if not hrp then task.wait(5); continue end

                            local startCFrame = hrp.CFrame
                            local RITUAL_SPOTS = GetMixTotemSpots(startCFrame)

                            NotifyInfo("Mix Totem", "Memulai ritual 3 totem (Fast Teleport)...")
                            ClearMixTotemBaseplates()

                            for i, config in ipairs(MIX_CONFIG) do
                                if not Config.AutoMixTotem then break end

                                local uuid = nil
                                pcall(function()
                                    local replion = GetPlayerDataReplion()
                                    if not replion then return end
                                    local inv = replion:GetExpect("Inventory")
                                    if not inv or not inv.Totems then return end
                                    for _, item in ipairs(inv.Totems) do
                                        if tonumber(item.Id) == config.id then
                                            uuid = item.UUID
                                            break
                                        end
                                    end
                                end)

                                if not uuid then
                                    NotifyError("Mix Totem", config.name .. " tidak ditemukan di inventory!")
                                    task.wait(2)
                                    continue
                                end

                                NotifyInfo("Mix Totem", "Memasang " .. config.name .. " di titik " .. i .. "/3...")

                                local success = DropTotemAtPosition(uuid, RITUAL_SPOTS[i], i)
                                if success then
                                    NotifySuccess("Mix Totem", config.name .. " berhasil dipasang!")
                                else
                                    NotifyError("Mix Totem", "Gagal pasang " .. config.name)
                                end

                                task.wait(1)
                            end

                            if Config.AutoMixTotem then
                                NotifyInfo("Mix Totem", "Kembali ke posisi awal...")
                                TeleportTo(startCFrame)
                                ClearMixTotemBaseplates()
                                _G.Noclip = false
                                RestoreCharacterCollision(LocalPlayer.Character)
                                equipRod()
                                NotifySuccess("Mix Totem", "Ritual selesai! Cooldown 1 jam")
                                task.wait(3600)
                            end
                        end
                    end)
                else
                    if Tasks.mixTotemThread then pcall(function() task.cancel(Tasks.mixTotemThread) end) end
                    _G.Noclip = false
                    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        LocalPlayer.Character.HumanoidRootPart.Anchored = false
                        LocalPlayer.Character.HumanoidRootPart.AssemblyLinearVelocity = Vector3.zero
                    end
                    ClearMixTotemBaseplates()
                    RestoreCharacterCollision(LocalPlayer.Character)
                    NotifyWarning("Mix Totem", "Auto Mix dihentikan.")
                end
            end
        })

        local Section_MainTab_AutoFav = MainTab:AddSection("Auto Favorite")
        local rarityValues = {"Common", "Uncommon", "Rare", "Epic", "Legendary", "Mythic", "SECRET"}
        Section_MainTab_AutoFav:AddDropdown("MultiDropdown_FilterRarity", { Title = "Filter Rarity", Values = rarityValues, Default = {},  Callback = function(val) Config.SelectedRarities = {}; for k, v in pairs(val or {}) do if v then table.insert(Config.SelectedRarities, typeof(k) == "string" and k or tostring(k)) end end end, Multi = true })
        local mutationValues = {"Galaxy", "Corrupt", "Gemstone", "Fairy Dust", "Midnight", "Color Burn", "Holographic", "Ghostly", "Abyssal", "Radiant", "Translucent", "Neon", "Electric", "Dark", "Holy", "Frozen", "Amber", "Radioactive", "Festive", "Gold", "Diamond", "Albino"}
        Section_MainTab_AutoFav:AddDropdown("MultiDropdown_FilterMutation", { Title = "Filter Mutation", Values = mutationValues, Default = {},  Callback = function(val) Config.SelectedMutations = {}; for k, v in pairs(val or {}) do if v then table.insert(Config.SelectedMutations, typeof(k) == "string" and k or tostring(k)) end end end, Multi = true })
        Section_MainTab_AutoFav:AddToggle("Toggle_AutoFavorite", {
            Title = "Auto Favorite", Default = false,
            Callback = function(val)
                Config.AutoFavoriteState = val
                if val then Tasks.AutoFavoriteThread = task.spawn(function() while Config.AutoFavoriteState do RunAutoFavLoop(false); task.wait(5) end end)
                else if Tasks.AutoFavoriteThread then pcall(function() task.cancel(Tasks.AutoFavoriteThread) end) end end
            end
        })
        Section_MainTab_AutoFav:AddToggle("Toggle_AutoUnfavorite", {
            Title = "Auto Unfavorite", Default = false,
            Callback = function(val)
                Config.AutoUnfavoriteState = val
                if val then Tasks.AutoUnfavoriteThread = task.spawn(function() while Config.AutoUnfavoriteState do RunAutoFavLoop(true); task.wait(5) end end)
                else if Tasks.AutoUnfavoriteThread then pcall(function() task.cancel(Tasks.AutoUnfavoriteThread) end) end end
            end
        })
end)
end

if FlyTab then
    pcall(function()
        local Section_FlyTab_1 = FlyTab:AddSection("Map Locations")
        local locationNames = {}; for name in pairs(LOCATIONS) do table.insert(locationNames, name) end; table.sort(locationNames)
        local selectedLocation = locationNames[1]
        local locationValues = locationNames
        Section_FlyTab_1:AddDropdown("Dropdown_PilihLokasi", { Title = "Pilih Lokasi", Values = locationValues, Default = locationValues[1],  Callback = function(val) selectedLocation = val end, Multi = false })
        Section_FlyTab_1:AddButton({ Title = "Teleport to Location", Callback = function()
            if selectedLocation and LOCATIONS[selectedLocation] then teleportTo(selectedLocation); NotifySuccess("Teleport", "Teleported to " .. selectedLocation .. "!")
            else NotifyError("Teleport", "Lokasi tidak ditemukan!") end
        end })
        local Section_FlyTab_2 = FlyTab:AddSection("Teleport to Player")
        local selectedPlayerTP = nil
        local playerDropdownRef = nil
        local currentMap = {}

        local function getPlayerList()
            local list = {}
            local map = {}
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= LocalPlayer then
                    local label = p.DisplayName .. " (@" .. p.Name .. ")"
                    table.insert(list, label)
                    map[label] = p
                    map[p.Name] = p
                    map[p.DisplayName] = p
                end
            end
            table.sort(list)
            if #list == 0 then
                table.insert(list, "Tidak ada player lain")
            end
            return list, map
        end

        local currentList
        currentList, currentMap = getPlayerList()
        selectedPlayerTP = currentList[1]

        local function refreshPlayerDropdown()
            local newList, newMap = getPlayerList()
            currentList = newList
            currentMap = newMap
            if playerDropdownRef and playerDropdownRef.SetValues then
                pcall(function()
                    playerDropdownRef:SetValues(currentList)
                    if not currentMap[selectedPlayerTP] then
                        selectedPlayerTP = currentList[1]
                        playerDropdownRef:SetValue(selectedPlayerTP)
                    end
                end)
            end
        end

        playerDropdownRef = Section_FlyTab_2:AddDropdown("Dropdown_PilihPlayer", {
            Title = "Pilih Player",
            Values = currentList,
            Default = currentList[1],
            Callback = function(val)
                selectedPlayerTP = val
            end,
            Multi = false
        })

        Section_FlyTab_2:AddButton({
            Title = "Teleport to Player",
            Description = "Teleport langsung ke samping player yang dipilih",
            Callback = function()
                if not selectedPlayerTP or selectedPlayerTP == "Tidak ada player lain" then
                    NotifyError("Teleport", "Pilih player yang valid!")
                    return
                end

                local targetPlayer = currentMap[selectedPlayerTP]
                if not targetPlayer then
                    for _, p in ipairs(Players:GetPlayers()) do
                        if p ~= LocalPlayer and (p.Name == selectedPlayerTP or p.DisplayName == selectedPlayerTP or selectedPlayerTP:find(p.Name, 1, true)) then
                            targetPlayer = p
                            break
                        end
                    end
                end

                if not targetPlayer then
                    NotifyError("Teleport", "Player tidak ditemukan di server!")
                    refreshPlayerDropdown()
                    return
                end

                local targetChar = targetPlayer.Character
                if not targetChar then
                    NotifyError("Teleport", "Character " .. targetPlayer.DisplayName .. " belum spawn!")
                    return
                end

                local targetPart = targetChar:FindFirstChild("HumanoidRootPart") or targetChar.PrimaryPart or targetChar:FindFirstChild("Head") or targetChar:FindFirstChild("UpperTorso") or targetChar:FindFirstChild("Torso") or targetChar:FindFirstChildWhichIsA("BasePart")

                if not targetPart then
                    NotifyError("Teleport", "Target part tidak ditemukan!")
                    return
                end

                local hrp = getHRP()
                if not hrp then
                    NotifyError("Teleport", "HumanoidRootPart kamu tidak ditemukan!")
                    return
                end

                local targetCF = targetPart.CFrame * CFrame.new(0, 2, 3)
                local ok = TeleportTo(targetCF)
                if not ok then
                    pcall(function()
                        hrp.CFrame = targetCF
                    end)
                end

                NotifySuccess("Teleport", "Teleported to " .. targetPlayer.DisplayName .. " (@" .. targetPlayer.Name .. ")!")
            end
        })

        Section_FlyTab_2:AddButton({
            Title = "Refresh Player List",
            Description = "Update daftar player di dalam server",
            Callback = function()
                refreshPlayerDropdown()
                NotifyInfo("Teleport", "Daftar player diperbarui!")
            end
        })

        Players.PlayerAdded:Connect(function()
            task.wait(0.5)
            refreshPlayerDropdown()
        end)

        Players.PlayerRemoving:Connect(function()
            task.wait(0.5)
            refreshPlayerDropdown()
        end)


        local Section_FlyTab_3 = FlyTab:AddSection("Event Teleport")
        local eventNames = {}; for name in pairs(eventData) do table.insert(eventNames, name) end; table.sort(eventNames)
        local eventValues = eventNames
        Section_FlyTab_3:AddDropdown("MultiDropdown_SelectEvents", { Title = "Select Events", Values = eventValues, Default = {},  Callback = function(val) selectedEvents = {}; for k, v in pairs(val or {}) do if v then table.insert(selectedEvents, typeof(k) == "string" and k or tostring(k)) end end end, Multi = true })
        Section_FlyTab_3:AddToggle("Toggle_HuntTeleport", {
            Title = "Hunt Teleport", Default = false,
            Description = "Auto teleport ke event yang sedang aktif (platform di atas air)",
            Callback = function(state)
                autoEventTPEnabled = state
                if state then
                    if #selectedEvents == 0 then NotifyWarning("Hunt Teleport", "Pilih minimal 1 event!"); autoEventTPEnabled = false; return end
                    if autoEventThread then pcall(function() task.cancel(autoEventThread) end) end
                    autoEventThread = task.spawn(runMultiEventTP)
                    NotifySuccess("Hunt Teleport", "Aktif! Scanning " .. #selectedEvents .. " event...")
                else
                    destroyEventPlatform()
                    if autoEventThread then pcall(function() task.cancel(autoEventThread) end); autoEventThread = nil end
                    NotifyInfo("Hunt Teleport", "Dimatikan.")
                end
            end
        })

        local Section_FlyTab_4 = FlyTab:AddSection("Teleport to NPC")

        local npcTeleportData = {
            SelectedNPC = nil,
            NPCList = {},
            NPCDropdownRef = nil,
        }

        local function ScanNPCs()
            local npcs = {}
            pcall(function()
                local npcFolder = ReplicatedStorage:FindFirstChild("NPC") or Workspace:FindFirstChild("NPC")
                if not npcFolder then return end
                for _, npc in ipairs(npcFolder:GetChildren()) do
                    local targetCFrame = nil
                    pcall(function()
                        if npc:IsA("Model") then
                            if npc.PrimaryPart then
                                targetCFrame = npc.PrimaryPart.CFrame
                            else
                                local hrp = npc:FindFirstChild("HumanoidRootPart")
                                    or npc:FindFirstChild("Head")
                                    or npc:FindFirstChildWhichIsA("BasePart")
                                if hrp then targetCFrame = hrp.CFrame end
                            end
                        elseif npc:IsA("BasePart") then
                            targetCFrame = npc.CFrame
                        end
                    end)
                    if targetCFrame then
                        table.insert(npcs, { Name = npc.Name, CFrame = targetCFrame })
                    end
                end
            end)
            table.sort(npcs, function(a, b) return a.Name:lower() < b.Name:lower() end)
            return npcs
        end

        local npcDropdownValues = {"-- Refresh dulu --"}
        npcTeleportData.NPCDropdownRef = Section_FlyTab_4:AddDropdown("Dropdown_PilihNPC", {
            Title = "Pilih NPC",
            Description = "Klik Refresh untuk scan NPC",
            Values = npcDropdownValues,
            Default = npcDropdownValues[1],

            Callback = function(val)
                if val and val ~= "-- Refresh dulu --" and val ~= "Tidak ada NPC" then
                    for _, npc in ipairs(npcTeleportData.NPCList) do
                        if npc.Name == val then
                            npcTeleportData.SelectedNPC = npc
                            NotifyInfo("NPC", "Selected: " .. npc.Name)
                            break
                        end
                    end
                end
            end,
            Multi = false
        })

        Section_FlyTab_4:AddButton({
            Title = "Refresh NPC List",
            Description = "Scan NPC dari ReplicatedStorage.NPC",
            Callback = function()
                local npcs = ScanNPCs()
                npcTeleportData.NPCList = npcs
                if #npcs == 0 then
                    npcTeleportData.SelectedNPC = nil
                    pcall(function()
                        if npcTeleportData.NPCDropdownRef and npcTeleportData.NPCDropdownRef.SetValues then
                            npcTeleportData.NPCDropdownRef:SetValues({"Tidak ada NPC"})
                            npcTeleportData.NPCDropdownRef:SetValue("Tidak ada NPC")
                        end
                    end)
                    NotifyWarning("NPC", "Tidak ada NPC ditemukan!")
                    return
                end
                local newValues = {}
                for _, npc in ipairs(npcs) do
                    table.insert(newValues, npc.Name)
                end
                pcall(function()
                    if npcTeleportData.NPCDropdownRef and npcTeleportData.NPCDropdownRef.SetValues then
                        npcTeleportData.NPCDropdownRef:SetValues(newValues)
                        npcTeleportData.NPCDropdownRef:SetValue(newValues[1])
                    end
                end)
                npcTeleportData.SelectedNPC = npcs[1]
                NotifySuccess("NPC", "Ditemukan " .. #npcs .. " NPC!")
            end
        })

        Section_FlyTab_4:AddButton({
            Title = "Teleport to NPC",
            Description = "Teleport ke NPC yang dipilih",
            Callback = function()
                if not npcTeleportData.SelectedNPC then
                    NotifyError("NPC", "Pilih NPC dulu!")
                    return
                end
                local hrp = getHRP()
                if not hrp then return end
                TeleportTo(npcTeleportData.SelectedNPC.CFrame * CFrame.new(0, 3, 0))
                NotifySuccess("NPC", "Teleport ke " .. npcTeleportData.SelectedNPC.Name .. "!")
            end
        })
    end)
end

if ShopTab then
    pcall(function()
        local Section_ShopTab_1 = ShopTab:AddSection("Buy Weather Event")
        local weatherMap = {["Windy (10k)"]="Wind",["Foggy (20k)"]="Fog",["Snow (15k)"]="Snow",["Stormy (35k)"]="Storm",["Radiant (50k)"]="Radiant",["Shark Hunt (300k)"]="Shark Hunt",["Treasure Hunt (750k)"]="Treasure Hunt"}
        local weatherNames = {}; for name in pairs(weatherMap) do table.insert(weatherNames, name) end; table.sort(weatherNames)
        local selectedWeathers = {}
        local weatherValues = weatherNames
        Section_ShopTab_1:AddDropdown("MultiDropdown_PilihWeather", { Title = "Pilih Weather", Values = weatherValues, Default = {},  Callback = function(val) selectedWeathers = {}; for k, v in pairs(val or {}) do if v then table.insert(selectedWeathers, typeof(k) == "string" and k or tostring(k)) end end end, Multi = true })
        Section_ShopTab_1:AddButton({ Title = "Buy Selected Weather", Callback = function()
            if #selectedWeathers == 0 then NotifyError("Weather", "Pilih weather dulu!"); return end
            if not Events.BuyWeather then Events.BuyWeather = GetServerRemote("RF/PurchaseWeatherEvent") end
            if not Events.BuyWeather then NotifyError("Weather", "Remote tidak ditemukan!"); return end
            for _, name in ipairs(selectedWeathers) do local key = weatherMap[name]; if key then pcall(function() Events.BuyWeather:InvokeServer(key) end); NotifySuccess("Weather", "Purchased: " .. name); task.wait(0.5) end end
        end })

        Section_ShopTab_1:AddButton({
            Title = "Auto Buy 3 Weather",
            Description = "Langsung beli Foggy, Wind, dan Storm sekaligus",
            Callback = function()
                if not Events.BuyWeather then Events.BuyWeather = GetServerRemote("RF/PurchaseWeatherEvent") end
                if not Events.BuyWeather then NotifyError("Weather", "Remote tidak ditemukan!"); return end
                local threeWeather = {"Fog", "Wind", "Storm"}
                local bought = 0
                for _, w in ipairs(threeWeather) do
                    local ok = pcall(function() Events.BuyWeather:InvokeServer(w) end)
                    if ok then bought = bought + 1; NotifySuccess("3 Weather", "Purchased: " .. w) end
                    task.wait(0.3)
                end
                if bought == 3 then
                    NotifySuccess("3 Weather", "Semua 3 weather berhasil dibeli!")
                else
                    NotifyWarning("3 Weather", "Hanya " .. bought .. "/3 berhasil dibeli.")
                end
            end
        })
        Section_ShopTab_1:AddToggle("Toggle_AutoBuyWeather", {
            Title = "Auto Buy Weather", Default = false,
            Callback = function(val)
                _G.AutoBuyWeather = val
                if val then
                    task.spawn(function()
                        while _G.AutoBuyWeather do
                            if not Events.BuyWeather then Events.BuyWeather = GetServerRemote("RF/PurchaseWeatherEvent") end
                            for _, name in ipairs(selectedWeathers) do local key = weatherMap[name]; if key and Events.BuyWeather then pcall(function() Events.BuyWeather:InvokeServer(key) end) end; task.wait(0.5) end
                            task.wait(5)
                        end
                    end)
                end
            end
        })
        local Section_ShopTab_2 = ShopTab:AddSection("Buy Fishing Rod")
        local rods = {["Luck Rod"]=79,["Carbon Rod"]=76,["Grass Rod"]=85,["Demascus Rod"]=77,["Ice Rod"]=78,["Lucky Rod"]=4,["Midnight Rod"]=80,["Steampunk Rod"]=6,["Chrome Rod"]=7,["Astral Rod"]=5,["Ares Rod"]=126,["Angler Rod"]=168,["Bamboo Rod"]=258}
        local rodNames = {"Luck Rod (350 Coins)","Carbon Rod (900 Coins)","Grass Rod (1.5k)","Demascus Rod (3k)","Ice Rod (5k)","Lucky Rod (15k)","Midnight Rod (50k)","Steampunk Rod (215k)","Chrome Rod (437k)","Astral Rod (1M)","Ares Rod (3M)","Angler Rod (8M)","Bamboo Rod (12M)"}
        local rodKeyMap = {["Luck Rod (350 Coins)"]="Luck Rod",["Carbon Rod (900 Coins)"]="Carbon Rod",["Grass Rod (1.5k)"]="Grass Rod",["Demascus Rod (3k)"]="Demascus Rod",["Ice Rod (5k)"]="Ice Rod",["Lucky Rod (15k)"]="Lucky Rod",["Midnight Rod (50k)"]="Midnight Rod",["Steampunk Rod (215k)"]="Steampunk Rod",["Chrome Rod (437k)"]="Chrome Rod",["Astral Rod (1M)"]="Astral Rod",["Ares Rod (3M)"]="Ares Rod",["Angler Rod (8M)"]="Angler Rod",["Bamboo Rod (12M)"]="Bamboo Rod"}
        local selectedRodName = rodNames[1]
        local rodNameValues = rodNames
        Section_ShopTab_2:AddDropdown("Dropdown_SelectRod", { Title = "Select Rod", Values = rodNameValues, Default = rodNameValues[1],  Callback = function(val) selectedRodName = val end, Multi = false })
        Section_ShopTab_2:AddButton({ Title = "Buy Selected Rod", Callback = function()
            local key = rodKeyMap[selectedRodName]
            if key and rods[key] then
                local r = GetServerRemote("RF/PurchaseFishingRod")
                if not r then NotifyError("Buy Rod", "Remote tidak ditemukan!"); return end
                pcall(function() r:InvokeServer(rods[key]) end); NotifySuccess("Buy Rod", "Purchased: " .. selectedRodName)
            end
        end })
        local Section_ShopTab_3 = ShopTab:AddSection("Buy Bait")
        local baits = {["TopWater Bait"]=10,["Lucky Bait"]=2,["Midnight Bait"]=3,["Chroma Bait"]=6,["Dark Matter Bait"]=8,["Corrupt Bait"]=15,["Aether Bait"]=16,["Floral Bait"]=20}
        local baitNames = {"TopWater Bait","Lucky Bait","Midnight Bait","Chroma Bait","Dark Matter Bait","Corrupt Bait","Aether Bait","Floral Bait"}
        local selectedBaitName = baitNames[1]
        local baitNameValues = baitNames
        Section_ShopTab_3:AddDropdown("Dropdown_SelectBait", { Title = "Select Bait", Values = baitNameValues, Default = baitNameValues[1],  Callback = function(val) selectedBaitName = val end, Multi = false })
        Section_ShopTab_3:AddButton({ Title = "Buy Selected Bait", Callback = function()
            if baits[selectedBaitName] then
                local r = GetServerRemote("RF/PurchaseBait")
                if not r then NotifyError("Buy Bait", "Remote tidak ditemukan!"); return end
                pcall(function() r:InvokeServer(baits[selectedBaitName]) end); NotifySuccess("Buy Bait", "Purchased: " .. selectedBaitName)
            end
        end })
        local Section_ShopTab_4 = ShopTab:AddSection("Buy Boat")
        local boats = {["Small Boat"]=1,["Kayak"]=2,["Jetski"]=3,["Highfield Boat"]=4,["Speed Boat"]=5,["Fish Boat"]=6,["Mini Yach"]=14}
        local boatNames = {"Small Boat (100 Coins)","Kayak (1.1k)","Jetski (7.5k)","Highfield Boat (25k)","Speed Boat (70k)","Fish Boat (180k)","Mini Yach (1.2M)"}
        local boatKeyMap = {["Small Boat (100 Coins)"]="Small Boat",["Kayak (1.1k)"]="Kayak",["Jetski (7.5k)"]="Jetski",["Highfield Boat (25k)"]="Highfield Boat",["Speed Boat (70k)"]="Speed Boat",["Fish Boat (180k)"]="Fish Boat",["Mini Yach (1.2M)"]="Mini Yach"}
        local selectedBoatName = boatNames[1]
        local boatNameValues = boatNames
        Section_ShopTab_4:AddDropdown("Dropdown_SelectBoat", { Title = "Select Boat", Values = boatNameValues, Default = boatNameValues[1],  Callback = function(val) selectedBoatName = val end, Multi = false })
        Section_ShopTab_4:AddButton({ Title = "Buy Selected Boat", Callback = function()
            local key = boatKeyMap[selectedBoatName]
            if key and boats[key] then
                local r = GetServerRemote("RF/PurchaseBoat")
                if not r then NotifyError("Buy Boat", "Remote tidak ditemukan!"); return end
                pcall(function() r:InvokeServer(boats[key]) end); NotifySuccess("Buy Boat", "Purchased: " .. selectedBoatName)
            end
        end })
        local autoBuyBoatState = false
        Section_ShopTab_4:AddToggle("Toggle_AutoBuyBoat", {
            Title = "Auto Buy Boat", Default = false,
            Callback = function(val)
                autoBuyBoatState = val
                if val then
                    task.spawn(function()
                        while autoBuyBoatState do
                            local key = boatKeyMap[selectedBoatName]
                            if key and boats[key] then
                                local r = GetServerRemote("RF/PurchaseBoat")
                                if r then pcall(function() r:InvokeServer(boats[key]) end) end
                            end
                            task.wait(2)
                        end
                    end)
                end
            end
        })

        local Section_ShopTab_BM = ShopTab:AddSection("Buy Black Market")

        local BM = {
            Items = {},
            SelectedItem = nil,
            SelectedItemName = nil,
            AutoBuyActive = false,
            AutoBuyThread = nil,
            Remote = nil,
            ParagraphRef = nil,
            DropdownRef = nil,
        }

        local function FindBMRemote()
            local possible = {
                "RF/PurchaseBlackMarketItem",
                "RF/BuyBlackMarketItem",
                "RE/PurchaseBlackMarketItem",
                "RE/BuyBlackMarketItem",
                "RF/BlackMarketPurchase",
                "RF/PurchaseItem",
                "RE/BlackMarketBuy",
                "RF/BlackMarket/BuyItem",
                "RE/BlackMarket/BuyItem",
            }
            for _, name in ipairs(possible) do
                local r = GetServerRemote(name)
                if r then return r end
            end
            local found = nil
            pcall(function()
                for _, d in ipairs(ReplicatedStorage:GetDescendants()) do
                    if d:IsA("RemoteEvent") or d:IsA("RemoteFunction") then
                        local n = d.Name:lower()
                        if n:find("blackmarket") or n:find("black_market") or n:find("black market") then
                            found = d; break
                        end
                    end
                end
            end)
            return found
        end

        local function ScanBMItems()
            BM.Items = {}
            local itemsFolder = ReplicatedStorage:FindFirstChild("Items")
            if not itemsFolder then return {} end
            local bmFolder = itemsFolder:FindFirstChild("Black Market")
            if not bmFolder then return {} end

            for _, item in ipairs(bmFolder:GetChildren()) do
                local id = nil
                pcall(function()
                    id = item:GetAttribute("Id") or item:GetAttribute("ItemId") or item:GetAttribute("ID")
                    if not id then
                        local idObj = item:FindFirstChild("Id") or item:FindFirstChild("ItemId")
                        if idObj and idObj:IsA("ValueBase") then id = idObj.Value end
                    end
                end)
                table.insert(BM.Items, {
                    Name = item.Name,
                    Id = id or item.Name,
                    Instance = item,
                })
            end
            table.sort(BM.Items, function(a, b) return a.Name < b.Name end)
            return BM.Items
        end

        local function UpdateBMStatus()
            if not BM.ParagraphRef then return end
            local rStatus = BM.Remote and "<font color='#39FF14'>FOUND</font>" or "<font color='#FF4444'>NOT FOUND</font>"
            local iCount = #BM.Items
            local sel = BM.SelectedItemName or "<font color='#B4B4B4'>None</font>"
            local auto = BM.AutoBuyActive and "<font color='#39FF14'>RUNNING</font>" or "<font color='#B4B4B4'>OFF</font>"
            SafeUpdateParagraph(BM.ParagraphRef, string.format(
                "Remote: %s\nItems: <font color='#FFD700'>%d</font>\nSelected: <font color='#00BFFF'>%s</font>\nAuto Buy: %s",
                rStatus, iCount, sel, auto
            ))
        end

        local function RefreshBM()
            BM.Remote = FindBMRemote()
            local items = ScanBMItems()

            local opts = {}
            if #items == 0 then
                table.insert(opts, { Title = "No Items Found", Icon = "lucide:circle-x" })
                NotifyWarning("Black Market", "Folder kosong atau ga ketemu di ReplicatedStorage.Items['Black Market']")
            else
                for _, itm in ipairs(items) do
                    table.insert(opts, { Title = itm.Name, Icon = "lucide:shopping-cart" })
                end
                NotifySuccess("Black Market", "Scanned " .. #items .. " items!")
            end

            pcall(function()
                if BM.DropdownRef and BM.DropdownRef.SetValues then BM.DropdownRef:SetValues(opts); if opts[1] then BM.DropdownRef:SetValue(opts[1]) end end
            end)

            if BM.SelectedItemName then
                local stillExists = false
                for _, itm in ipairs(items) do
                    if itm.Name == BM.SelectedItemName then stillExists = true; break end
                end
                if not stillExists then
                    BM.SelectedItem = nil
                    BM.SelectedItemName = nil
                end
            end

            UpdateBMStatus()
        end

        local function TryPurchaseBMItem(itemData)
            if not BM.Remote or not itemData then return false end
            local tried = {}
            local candidates = {}
            local function add(value)
                if value == nil then return end
                if type(value) ~= "string" and type(value) ~= "number" then return end
                local key = tostring(value)
                if key == "" or tried[key] then return end
                tried[key] = true
                table.insert(candidates, value)
            end

            add(itemData.Id)
            add(itemData.Name)
            if itemData.Instance then
                add(itemData.Instance.Name)
                for _, attrName in ipairs({"Id", "ItemId", "ID"}) do
                    local ok, value = pcall(function() return itemData.Instance:GetAttribute(attrName) end)
                    if ok then add(value) end
                end
            end

            local function tryRemote(...)
                if not BM.Remote then return false end
                local args = {...}
                if BM.Remote:IsA("RemoteFunction") then
                    return pcall(function() BM.Remote:InvokeServer(unpack(args)) end)
                else
                    return pcall(function() BM.Remote:FireServer(unpack(args)) end)
                end
            end

            for _, candidate in ipairs(candidates) do
                if tryRemote(candidate) then
                    return true
                end
                if tryRemote(candidate, 1) then
                    return true
                end
            end

            return false
        end

        local function BuyBMItem(itemData, quantity)
            if not BM.Remote then
                NotifyError("Black Market", "Remote belum ditemukan!")
                return 0
            end
            if not itemData then
                NotifyError("Black Market", "Pilih item dulu dari dropdown!")
                return 0
            end

            local blackMarketCFrame = LOCATIONS["Black Market"]
            if blackMarketCFrame then
                NotifyInfo("Black Market", "Teleporting ke Black Market...")
                TeleportTo(blackMarketCFrame)
                task.wait(0.3)
            end

            quantity = math.clamp(tonumber(quantity) or 1, 1, 99)
            local bought = 0

            for i = 1, quantity do
                if TryPurchaseBMItem(itemData) then
                    bought = bought + 1
                else
                    NotifyError("Black Market", "Gagal beli " .. itemData.Name .. " (ke-" .. i .. ")")
                    break
                end
                if i < quantity then task.wait(0.25) end
            end

            if bought > 0 then
                NotifySuccess("Black Market", "Berhasil beli " .. itemData.Name .. " x" .. bought)
            end
            return bought
        end

        local function StartBMAutoBuy()
            if BM.AutoBuyThread then
                pcall(function() task.cancel(BM.AutoBuyThread) end)
                BM.AutoBuyThread = nil
            end
            BM.AutoBuyThread = task.spawn(function()

                local blackMarketCFrame = LOCATIONS["Black Market"]
                if blackMarketCFrame then
                    NotifyInfo("Black Market", "Teleporting ke Black Market...")
                    TeleportTo(blackMarketCFrame)
                    task.wait(0.3)
                end

                while BM.AutoBuyActive do
                    pcall(function()
                        if BM.SelectedItem then
                            if not BM.Remote then
                                NotifyError("Black Market", "Remote belum ditemukan!")
                                return
                            end
                            if TryPurchaseBMItem(BM.SelectedItem) then
                                pcall(function() if Window and Window.Notify then Fluent:Notify({ Title = "[OK] Auto Buy", Content = BM.SelectedItem.Name, Duration = 0.5, Icon = "lucide:circle-check" }) end end)
                            else
                                NotifyError("Black Market", "Auto Buy gagal untuk " .. BM.SelectedItem.Name)
                            end
                        end
                    end)
                    task.wait(0.6)
                end
            end)
        end

        local function StopBMAutoBuy()
            BM.AutoBuyActive = false
            if BM.AutoBuyThread then
                pcall(function() task.cancel(BM.AutoBuyThread) end)
                BM.AutoBuyThread = nil
            end
            UpdateBMStatus()
        end

        BM.ParagraphRef = Section_ShopTab_BM:AddParagraph({
            Title = "Black Market Status",
            Content = "Remote: <font color='#FF4444'>NOT FOUND</font>\nItems: <font color='#FFD700'>0</font>\nSelected: <font color='#B4B4B4'>None</font>\nAuto Buy: <font color='#B4B4B4'>OFF</font>\n\n<font color='#B4B4B4'>Klik Refresh untuk scan item!</font>"
        })

        Section_ShopTab_BM:AddButton({
            Title = "Refresh Black Market Items",
            Description = "Scan ReplicatedStorage.Items['Black Market']",
            Callback = function()
                RefreshBM()
            end
        })

        local bmDefaultOpts = {"Refresh Required"}
        BM.DropdownRef = Section_ShopTab_BM:AddDropdown("Dropdown_SelectBlackMarketItem", {
            Title = "Select Black Market Item",
            Description = "Klik Refresh dulu agar muncul list item",
            Values = bmDefaultOpts,
            Default = bmDefaultOpts[1],
            Callback = function(val)
                if val == "Refresh Required" or val == "No Items Found" then
                    BM.SelectedItem = nil
                    BM.SelectedItemName = nil
                    UpdateBMStatus()
                    return
                end
                for _, itm in ipairs(BM.Items) do
                    if itm.Title == val then
                        BM.SelectedItem = itm
                        BM.SelectedItemName = itm.Name
                        break
                    end
                end
                UpdateBMStatus()
                NotifyInfo("Black Market", "Selected: " .. (BM.SelectedItemName or "None"))
            end, Multi = false
        })

        Section_ShopTab_BM:AddButton({
            Title = "Buy Selected Item (One)",
            Description = "Beli 1x item yang dipilih",
            Callback = function()
                BuyBMItem(BM.SelectedItem, 1)
            end
        })

        Section_ShopTab_BM:AddButton({
            Title = "Buy All Items",
            Description = "Beli semua item di Black Market masing-masing 1x",
            Callback = function()
                if #BM.Items == 0 then
                    NotifyWarning("Black Market", "Item kosong! Refresh dulu.")
                    return
                end
                task.spawn(function()
                    local successCount = 0
                    for _, itm in ipairs(BM.Items) do
                        local n = BuyBMItem(itm, 1)
                        if n > 0 then successCount = successCount + 1 end
                        task.wait(0.3)
                    end
                    NotifySuccess("Black Market", "Selesai! " .. successCount .. "/" .. #BM.Items .. " item berhasil dibeli.")
                end)
            end
        })

        Section_ShopTab_BM:AddToggle("Toggle_AutoBuySelectedItem", {
            Title = "Auto Buy Selected Item",
            Description = "Loop beli item terus-menerus",
            Default = false,
            Callback = function(val)
                BM.AutoBuyActive = val
                if val then
                    if not BM.SelectedItem then
                        NotifyError("Black Market", "Pilih item dulu!")
                        BM.AutoBuyActive = false
                        UpdateBMStatus()
                        return
                    end
                    StartBMAutoBuy()
                    NotifySuccess("Black Market", "Auto Buy aktif untuk: " .. BM.SelectedItemName)
                else
                    StopBMAutoBuy()
                    NotifyWarning("Black Market", "Auto Buy dimatikan.")
                end
                UpdateBMStatus()
            end
        })

        task.delay(1, function()
            pcall(function()
                BM.Remote = FindBMRemote()
                UpdateBMStatus()
            end)
        end)
 end)
end

if MiscTab then
    pcall(function()
        local Section_MiscTab_1 = MiscTab:AddSection("Visual & Performance")

        Section_MiscTab_1:AddToggle("Toggle_DisableCloudyPanel", {
            Title = "Disable Cloudy Panel",
            Description = "Sembunyikan / matikan tampilan panel Ping, Notif & FPS Cloudy",
            Default = false,
            Callback = function(val)
                _G.DisableCloudyPanel = val
                local targetGui = statsPanelGui or _G.CloudyStatsPanelGui or (gethui and gethui():FindFirstChild("CloudyPanelV4")) or CoreGui:FindFirstChild("CloudyPanelV4") or (LocalPlayer and LocalPlayer:FindFirstChild("PlayerGui") and LocalPlayer.PlayerGui:FindFirstChild("CloudyPanelV4"))
                if targetGui then
                    targetGui.Enabled = not val
                end
                if val then
                    NotifyInfo("Cloudy Panel", "Panel Ping & FPS disembunyikan.")
                else
                    NotifySuccess("Cloudy Panel", "Panel Ping & FPS ditampilkan.")
                end
            end
        })

        Section_MiscTab_1:AddToggle("Toggle_NoAnimation", {
            Title = "No Animation", Default = false,
            Callback = function(val)
                _G.NoAnimationEnabled = val
                if val then
                    local char = LocalPlayer.Character; if char then SetupNoAnimation(char) end
                    pcall(function() noAnimCharConnection = LocalPlayer.CharacterAdded:Connect(function(newChar) task.wait(0.5); SetupNoAnimation(newChar) end) end)
                else
                    if noAnimConnection then pcall(function() noAnimConnection:Disconnect() end); noAnimConnection = nil end
                    if noAnimCharConnection then pcall(function() noAnimCharConnection:Disconnect() end); noAnimCharConnection = nil end
                end
            end
        })

        Section_MiscTab_1:AddToggle("Toggle_UltraBrutalFPSBooster", {
            Title = "Ultra/Brutal FPS Booster", Default = false,
            Callback = function(val)
                _G.UltraFPSActive = val
                if val then
                    -- ... kode FPS booster ...
                    NotifySuccess("Ultra FPS", "BRUTAL MODE AKTIF! FPS maksimal!")
                else
                    NotifyInfo("Ultra FPS", "Dimatikan. Restart game untuk restore visual.")
                end
            end
        })

        local _cleanScreenBackup = {}
        local _cleanScreenActive = false
        local _cleanScreenConn = nil

        local function IsScriptGui(gui)
            if not gui or not gui.Name then return false end
            local name = gui.Name:lower()
            if name:find("windui") then return true end
            if name:find("cloudy") then return true end
            if name:find("qh") then return true end
            if name:find("assets_hub") then return true end
            if name:find("buttonrezise") then return true end
            if name:find("stree") then return true end
            if name:find("screengui_1") then return true end
            if gui:FindFirstChild("ButtonRezise_2") then return true end
            return false
        end

        -- =============================================
-- POTATO MODE - DIADAPTASI UNTUK MISCTAB
-- =============================================
do
    local Terrain = workspace:FindFirstChildOfClass("Terrain")
    local Lighting = game:GetService("Lighting")
    local StarterGui = game:GetService("StarterGui")
    local SoundService = game:GetService("SoundService")
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local UserSettings = game:GetService("UserSettings")

    local E_SMOOTH = Enum.SurfaceType.SmoothNoOutlines
    local E_PLASTIC = Enum.Material.SmoothPlastic
    local E_LEGACY = Enum.Technology.Legacy
    local E_LVL1 = Enum.QualityLevel.Level01
    local E_MESH1 = Enum.MeshPartDetailLevel.Level01
    local E_AUTO = Enum.QualityLevel.Automatic
    local E_DISTBASE = Enum.MeshPartDetailLevel.DistanceBased
    local E_SAVEDAUTO = Enum.SavedQualitySetting.Automatic
    local E_SAVEDQ1 = Enum.SavedQualitySetting.QualityLevel1
    local E_NOREVRB = Enum.ReverbType.NoReverb
    local E_LISTCAM = Enum.ListenerType.Camera
    local WHITE = Color3.new(1, 1, 1)
    local SURFACES = { "TopSurface","BottomSurface","LeftSurface","RightSurface","FrontSurface","BackSurface" }

    local DESTROY_SET = {
        ParticleEmitter=true, Trail=true, Beam=true, Fire=true,
        Smoke=true, Sparkles=true, ForceField=true, Explosion=true,
        BloomEffect=true, BlurEffect=true, ColorCorrectionEffect=true,
        SunRaysEffect=true, DepthOfFieldEffect=true, Atmosphere=true,
        Decal=true, Texture=true, SurfaceAppearance=true,
        SpecialMesh=true, BlockMesh=true, CylinderMesh=true,
        PointLight=true, SpotLight=true, SurfaceLight=true,
        Accessory=true, Hat=true, Shirt=true, Pants=true,
        ShirtGraphic=true, CharacterMesh=true, BodyColors=true,
        Clothing=true, HumanoidDescription=true,
    }

    local _potato = {
        enabled = false,
        connections = {},
        processedObjects = setmetatable({}, { __mode = "k" }),
        origStates = { lighting = {}, water = {}, camera = {} },
        loopThread = nil,
    }

    local function _optimizeObj(obj)
        if _potato.processedObjects[obj] then return end
        _potato.processedObjects[obj] = true
        if DESTROY_SET[obj.ClassName] then
            obj:Destroy()
            return
        end
        if obj:IsA("BasePart") then
            obj.Material = E_PLASTIC
            obj.CastShadow = false
            obj.Reflectance = 0
            for i = 1, 6 do obj[SURFACES[i]] = E_SMOOTH end
        end
    end

    local function _optimizeChar(char)
        if not char or _potato.processedObjects[char] then return end
        _potato.processedObjects[char] = true
        pcall(function()
            local desc = char:GetDescendants()
            for i = 1, #desc do
                local obj = desc[i]
                if DESTROY_SET[obj.ClassName] then
                    obj:Destroy()
                elseif obj:IsA("BasePart") then
                    if obj.Name == "Head" then obj.Transparency = 1 end
                    obj.Material = E_PLASTIC
                    obj.CastShadow = false
                    obj.Reflectance = 0
                    obj.CanCollide = (obj.Name == "HumanoidRootPart" or obj.Name == "Head")
                    for s = 1, 6 do obj[SURFACES[s]] = E_SMOOTH end
                elseif obj:IsA("Humanoid") then
                    local tracks = obj:GetPlayingAnimationTracks()
                    for t = 1, #tracks do tracks[t]:Stop(0) end
                    obj.HealthDisplayDistance = 0
                    obj.NameDisplayDistance = 0
                end
            end
        end)
    end

    local function _potatoCleanup()
        local conns = _potato.connections
        for i = 1, #conns do pcall(conns[i].Disconnect, conns[i]) end
        _potato.connections = {}
        _potato.processedObjects = setmetatable({}, { __mode = "k" })
        if _potato.loopThread then task.cancel(_potato.loopThread); _potato.loopThread = nil end
    end

    local function _applyWorldSettings()
        if Terrain then
            pcall(function()
                _potato.origStates.water = {
                    WaterReflectance = Terrain.WaterReflectance,
                    WaterWaveSize = Terrain.WaterWaveSize,
                    WaterWaveSpeed = Terrain.WaterWaveSpeed,
                    WaterTransparency = Terrain.WaterTransparency,
                }
                Terrain.WaterWaveSize = 0
                Terrain.WaterWaveSpeed = 0
                Terrain.WaterReflectance = 0
                Terrain.WaterTransparency = 1
                Terrain.Decoration = false
            end)
            local clouds = Terrain:FindFirstChildOfClass("Clouds")
            if clouds then clouds:Destroy() end
        end
        pcall(function()
            _potato.origStates.lighting = {
                GlobalShadows = Lighting.GlobalShadows,
                Brightness = Lighting.Brightness,
                Technology = Lighting.Technology,
            }
            Lighting.GlobalShadows = false
            Lighting.FogEnd = 9e9
            Lighting.Brightness = 0
            Lighting.OutdoorAmbient = WHITE
            Lighting.Ambient = WHITE
            Lighting.Technology = E_LEGACY
            Lighting.EnvironmentDiffuseScale = 0
            Lighting.EnvironmentSpecularScale = 0
            Lighting.ShadowSoftness = 0
        end)
        local lchildren = Lighting:GetChildren()
        for i = 1, #lchildren do
            local c = lchildren[i]
            if c:IsA("PostEffect") or c:IsA("Atmosphere") then
                pcall(c.Destroy, c)
            elseif c:IsA("Sky") then
                pcall(function()
                    c.StarCount = 0
                    c.SunAngularSize = 0
                    c.MoonAngularSize = 0
                    c.CelestialBodiesShown = false
                    c.SkyboxBk = ""; c.SkyboxDn = ""; c.SkyboxFt = ""
                    c.SkyboxLf = ""; c.SkyboxRt = ""; c.SkyboxUp = ""
                end)
            end
        end
        pcall(function()
            SoundService.AmbientReverb = E_NOREVRB
            SoundService:SetListener(E_LISTCAM)
        end)
        pcall(function()
            local rs = settings().Rendering
            rs.QualityLevel = E_LVL1
            rs.MeshPartDetailLevel = E_MESH1
            rs.EditQualityLevel = E_LVL1
        end)
        pcall(function()
            local ugs = UserSettings():GetService("UserGameSettings")
            ugs.SavedQualityLevel = E_SAVEDQ1
        end)
        pcall(function()
            local cam = workspace.CurrentCamera
            if cam then
                _potato.origStates.camera = { FieldOfView = cam.FieldOfView }
                cam.FieldOfView = 70
            end
        end)
        pcall(function()
            StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.EmotesMenu, false)
        end)
    end

    local function _restoreWorldSettings()
        if Terrain and _potato.origStates.water.WaterReflectance ~= nil then
            pcall(function()
                local w = _potato.origStates.water
                Terrain.WaterReflectance = w.WaterReflectance
                Terrain.WaterWaveSize = w.WaterWaveSize
                Terrain.WaterWaveSpeed = w.WaterWaveSpeed
                Terrain.WaterTransparency = w.WaterTransparency
                Terrain.Decoration = true
            end)
        end
        pcall(function()
            local l = _potato.origStates.lighting
            if l.GlobalShadows ~= nil then
                Lighting.GlobalShadows = l.GlobalShadows
                Lighting.Brightness = l.Brightness
                Lighting.Technology = l.Technology
            end
        end)
        pcall(function()
            local cam = workspace.CurrentCamera
            if cam and _potato.origStates.camera.FieldOfView then
                cam.FieldOfView = _potato.origStates.camera.FieldOfView
            end
        end)
        pcall(function()
            local rs = settings().Rendering
            rs.QualityLevel = E_AUTO
            rs.MeshPartDetailLevel = E_DISTBASE
        end)
        pcall(function()
            UserSettings():GetService("UserGameSettings").SavedQualityLevel = E_SAVEDAUTO
        end)
        pcall(function()
            StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, true)
            StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.EmotesMenu, true)
        end)
        _potato.origStates = { lighting = {}, water = {}, camera = {} }
    end

    -- ===== TOGGLE DI MISCTAB =====
    Section_MiscTab_1:AddToggle("Toggle_PotatoMode", {
        Title = "Reduce Map (Potato Mode)",
        Description = "Hapus efek, turunkan kualitas, matikan shadow untuk FPS maksimal",
        Default = false,
        Callback = function(on)
            _potato.enabled = on
            _potatoCleanup()
            if not on then
                _restoreWorldSettings()
                NotifyInfo("Potato Mode", "Dimatikan. Visual akan kembali normal.")
                return
            end
            _applyWorldSettings()
            NotifySuccess("Potato Mode", "Diaktifkan! FPS Boost maksimal.")
            _potato.loopThread = task.spawn(function()
                while _potato.enabled do
                    _potato.processedObjects = setmetatable({}, { __mode = "k" })
                    local all = workspace:GetDescendants()
                    local n = #all
                    local BATCH = 50
                    for i = 1, n, BATCH do
                        if not _potato.enabled then break end
                        for j = i, math.min(i + BATCH - 1, n) do
                            _optimizeObj(all[j])
                        end
                        task.wait()
                    end
                    if not _potato.enabled then break end
                    for _, plr in ipairs(Players:GetPlayers()) do
                        if plr.Character then task.defer(_optimizeChar, plr.Character) end
                    end
                    local waitTime = 600
                    while waitTime > 0 and _potato.enabled do
                        task.wait(1)
                        waitTime = waitTime - 1
                    end
                    if _potato.enabled then
                        pcall(_applyWorldSettings)
                    end
                end
            end)
            -- Hook untuk player baru dan objek baru
            table.insert(_potato.connections, Players.PlayerAdded:Connect(function(plr)
                table.insert(_potato.connections, plr.CharacterAdded:Connect(function(char)
                    if not _potato.enabled then return end
                    task.delay(0.2, function()
                        if _potato.enabled then _optimizeChar(char) end
                    end)
                end))
                if plr.Character then task.defer(_optimizeChar, plr.Character) end
            end))
            table.insert(_potato.connections, Players.LocalPlayer.CharacterAdded:Connect(function(char)
                if not _potato.enabled then return end
                task.delay(0.2, function()
                    if _potato.enabled then _optimizeChar(char) end
                end)
            end))
            table.insert(_potato.connections, workspace.DescendantAdded:Connect(function(obj)
                if not _potato.enabled then return end
                _optimizeObj(obj)
            end))
        end,
    })
end

        Section_MiscTab_1:AddToggle("Toggle_CleanScreenToggle", {
            Title = "Clean Screen (Toggle)", Default = false,
            Callback = function(val)
                if val then
                    _cleanScreenActive = true
                    for _, gui in pairs(LocalPlayer.PlayerGui:GetChildren()) do
                        if (gui:IsA("ScreenGui") or gui:IsA("BillboardGui") or gui:IsA("SurfaceGui")) and not IsScriptGui(gui) then
                            if _cleanScreenBackup[gui] == nil then _cleanScreenBackup[gui] = gui.Enabled end
                            gui.Enabled = false
                        end
                    end
                    for _, gui in pairs(CoreGui:GetChildren()) do
                        if (gui:IsA("ScreenGui") or gui:IsA("BillboardGui") or gui:IsA("SurfaceGui")) and not IsScriptGui(gui) then
                            if _cleanScreenBackup[gui] == nil then _cleanScreenBackup[gui] = gui.Enabled end
                            gui.Enabled = false
                        end
                    end
                    if _cleanScreenConn then _cleanScreenConn:Disconnect() end
                    _cleanScreenConn = RunService.Heartbeat:Connect(function()
                        if not _cleanScreenActive then return end
                        pcall(function()
                            for _, gui in pairs(LocalPlayer.PlayerGui:GetChildren()) do
                                if (gui:IsA("ScreenGui") or gui:IsA("BillboardGui") or gui:IsA("SurfaceGui")) and gui.Enabled and not IsScriptGui(gui) then
                                    if _cleanScreenBackup[gui] == nil then _cleanScreenBackup[gui] = true end
                                    gui.Enabled = false
                                end
                            end
                            for _, gui in pairs(CoreGui:GetChildren()) do
                                if (gui:IsA("ScreenGui") or gui:IsA("BillboardGui") or gui:IsA("SurfaceGui")) and gui.Enabled and not IsScriptGui(gui) then
                                    if _cleanScreenBackup[gui] == nil then _cleanScreenBackup[gui] = true end
                                    gui.Enabled = false
                                end
                            end
                        end)
                    end)
                    NotifySuccess("Clean Screen", "Semua UI game di-hidden! Script UI tetap aktif.")
                else
                    _cleanScreenActive = false
                    if _cleanScreenConn then _cleanScreenConn:Disconnect(); _cleanScreenConn = nil end
                    local restoredCount = 0
                    for gui, originalEnabled in pairs(_cleanScreenBackup) do
                        pcall(function()
                            if gui and gui.Parent then
                                gui.Enabled = originalEnabled
                                restoredCount = restoredCount + 1
                            end
                        end)
                    end
                    _cleanScreenBackup = {}
                    NotifySuccess("Clean Screen", "UI game restored! " .. restoredCount .. " GUI diaktifkan kembali.")
                end
            end
        })

     Section_MiscTab_1:AddToggle("Toggle_DisableAllNotifications", {
    Title = "Disable Notifications",
    Default = false,
    Callback = function(state)
        local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui")
        if PlayerGui then
            local NotifyGui = PlayerGui:FindFirstChild("Text Notifications")
            if NotifyGui then
                local Frame = NotifyGui:FindFirstChild("Frame")
                if Frame then
                    Frame.Visible = not state
                end
            end
        end

        if state then
            NotifySuccess("Notifikasi", "Notifikasi ikan diaktifkan!")
        else
            NotifyInfo("Notifikasi", "Notifikasi ikan dimatikan!")
        end
    end
})

        Section_MiscTab_1:AddToggle("Toggle_DisableVFX", {
            Title = "Disable VFX",
            Default = false,
            Callback = function(val)
                if Controllers.VFX then
                    if val then
                        -- disable VFX
                        if not _backupVFX then _backupVFX = {} end
                        for k, v in pairs(Controllers.VFX) do
                            if type(v) == "function" then
                                _backupVFX[k] = v
                                Controllers.VFX[k] = function() end
                            end
                        end
                    else
                        if _backupVFX then
                            for k, v in pairs(_backupVFX) do
                                Controllers.VFX[k] = v
                            end
                            _backupVFX = nil
                        end
                    end
                end
            end
        })

        -- Disable Fish Caught (Small Notification)
        local fishNotifConnection = nil
        local function DisableFishCaught()
            local playerGui = LocalPlayer:WaitForChild("PlayerGui")
            local smallNotif = playerGui:FindFirstChild("Small Notification")
            if smallNotif then smallNotif:Destroy() end
            if not fishNotifConnection then
                fishNotifConnection = playerGui.ChildAdded:Connect(function(child)
                    if child.Name == "Small Notification" or (child:FindFirstChild("Display") and child:FindFirstChildWhichIsA("Frame")) then
                        task.spawn(function()
                            task.wait()
                            if child and child.Parent then child:Destroy() end
                        end)
                    end
                end)
            end
            NotifySuccess("Fish Caught", "Notifikasi ikan dinonaktifkan!")
        end
        local function EnableFishCaught()
            if fishNotifConnection then fishNotifConnection:Disconnect(); fishNotifConnection = nil end
            NotifySuccess("Fish Caught", "Notifikasi ikan diaktifkan kembali!")
        end

        Section_MiscTab_1:AddToggle("Toggle_DisableCutscene", {
            Title = "Disable Fish Caught",
            Default = false,
            Callback = function(val)
                if val then DisableFishCaught() else EnableFishCaught() end
            end
        })

        -- Skip Cutscene
        local skipCutscene = false
        local replicateConn = nil
        local stopConn = nil
        local originalPlay = nil
        local originalStop = nil
        local hooked = false
        Section_MiscTab_1:AddToggle("Toggle_SkipCutscene", {
            Title = "Skip Cutscene",
            Default = false,
            Callback = function(state)
                skipCutscene = state
                if not replicateConn then
                    local RE_ReplicateCutscene = GetServerRemote("RE/ReplicateCutscene") or GetServerRemote("ReplicateCutscene")
                    if RE_ReplicateCutscene then
                        replicateConn = RE_ReplicateCutscene.OnClientEvent:Connect(function(...)
                            if skipCutscene then warn("Blocked ReplicateCutscene event!") end
                        end)
                    end
                end
                if not stopConn then
                    local RE_StopCutscene = GetServerRemote("RE/StopCutscene") or GetServerRemote("StopCutscene")
                    if RE_StopCutscene then
                        stopConn = RE_StopCutscene.OnClientEvent:Connect(function()
                            if skipCutscene then warn("Blocked StopCutscene event!") end
                        end)
                    end
                end
                if hooked then return end
                hooked = true
                task.spawn(function()
                    local ok, CutsceneController = pcall(function()
                        return require(ReplicatedStorage.Controllers.CutsceneController)
                    end)
                    if not ok or not CutsceneController then warn("CutsceneController not found.") return end
                    originalPlay = originalPlay or CutsceneController.Play
                    originalStop = originalStop or CutsceneController.Stop
                    while true do
                        if skipCutscene then
                            CutsceneController.Play = function(...) warn("Cutscene skipped (Play).") end
                            CutsceneController.Stop = function(...) warn("Cutscene skipped (Stop).") end
                        else
                            CutsceneController.Play = originalPlay
                            CutsceneController.Stop = originalStop
                        end
                        task.wait(0.25)
                    end
                end)
            end
        })

        -- Disable Fishing Effect
        local delEffects = false
        local effectsConnection = nil
        local effectsLoopThread = nil
        local function toggleDisableFishingEffect(state)
            delEffects = state
            if state then
                if effectsLoopThread then task.cancel(effectsLoopThread) end
                effectsLoopThread = task.spawn(function()
                    while delEffects do
                        local cosmetic = workspace:FindFirstChild("CosmeticFolder")
                        if cosmetic then
                            for _, child in ipairs(cosmetic:GetChildren()) do
                                local isExactPart = child.Name == "Part"
                                local isPureNumber = string.match(child.Name, "^%d+$")
                                local isModel = child:IsA("Model")
                                if not (isExactPart or isPureNumber or isModel) then
                                    pcall(function() child:Destroy() end)
                                end
                            end
                        end
                        task.wait(0.1)
                    end
                end)
                if not effectsConnection then
                    local cosmetic = workspace:WaitForChild("CosmeticFolder", 5)
                    if cosmetic then
                        effectsConnection = cosmetic.ChildAdded:Connect(function(child)
                            if delEffects then
                                task.wait()
                                local isExactPart = child.Name == "Part"
                                local isPureNumber = string.match(child.Name, "^%d+$")
                                local isModel = child:IsA("Model")
                                if not (isExactPart or isPureNumber or isModel) then
                                    pcall(function() child:Destroy() end)
                                end
                            end
                        end)
                    end
                end
                NotifySuccess("Fishing Effect", "Disabled! (effects hidden)")
            else
                if effectsLoopThread then task.cancel(effectsLoopThread); effectsLoopThread = nil end
                if effectsConnection then effectsConnection:Disconnect(); effectsConnection = nil end
                NotifyInfo("Fishing Effect", "Enabled (effects visible)")
            end
        end
        Section_MiscTab_1:AddToggle("Toggle_DisableFishingEffect", {
            Title = "Disable Fishing Effect",
            Default = false,
            Callback = function(val) toggleDisableFishingEffect(val) end
        })

        -- Fullbright
        local _fullbrightBackup = {}
        Section_MiscTab_1:AddToggle("Toggle_Fullbright", {
            Title = "Fullbright", Default = false,
            Callback = function(val)
                pcall(function()
                    if val then
                        _fullbrightBackup.Brightness = Lighting.Brightness
                        _fullbrightBackup.ClockTime = Lighting.ClockTime
                        _fullbrightBackup.FogEnd = Lighting.FogEnd
                        _fullbrightBackup.GlobalShadows = Lighting.GlobalShadows
                        _fullbrightBackup.EnvironmentDiffuseScale = Lighting.EnvironmentDiffuseScale
                        _fullbrightBackup.EnvironmentSpecularScale = Lighting.EnvironmentSpecularScale
                        Lighting.Brightness = 3
                        Lighting.ClockTime = 12
                        Lighting.FogEnd = 1e10
                        Lighting.GlobalShadows = false
                        Lighting.EnvironmentDiffuseScale = 1
                        Lighting.EnvironmentSpecularScale = 1
                        NotifySuccess("Fullbright", "Aktif!")
                    else
                        if _fullbrightBackup.Brightness ~= nil then Lighting.Brightness = _fullbrightBackup.Brightness end
                        if _fullbrightBackup.ClockTime ~= nil then Lighting.ClockTime = _fullbrightBackup.ClockTime end
                        if _fullbrightBackup.FogEnd ~= nil then Lighting.FogEnd = _fullbrightBackup.FogEnd end
                        if _fullbrightBackup.GlobalShadows ~= nil then Lighting.GlobalShadows = _fullbrightBackup.GlobalShadows end
                        if _fullbrightBackup.EnvironmentDiffuseScale ~= nil then Lighting.EnvironmentDiffuseScale = _fullbrightBackup.EnvironmentDiffuseScale end
                        if _fullbrightBackup.EnvironmentSpecularScale ~= nil then Lighting.EnvironmentSpecularScale = _fullbrightBackup.EnvironmentSpecularScale end
                        NotifySuccess("Fullbright", "Dimatikan!")
                    end
                end)
            end
        })

                -- Anti-AFK
        local Section_MiscTab_3 = MiscTab:AddSection("Anti-AFK")
        Section_MiscTab_3:AddToggle("Toggle_AntiAFK", {
            Title = "Anti-AFK", Default = false,
            Callback = function(value)
                _G.AntiAFKEnabled = value
                local sange = getconnections or get_signal_cons
                if sange then
                    for i, v in next, sange(Players.LocalPlayer.Idled) do
                        if value then v:Disable() else v:Enable() end
                    end
                end
            end
        })

        local Section_DisableNotif = MiscTab:AddSection("Disable All Notifications")
        Section_DisableNotif:AddDropdown("Dropdown_NotifPosition", {
            Title = "Notification Position",
            Description = "Pilih posisi tampilan notifikasi",
            Values = {"Normal (Mid)", "Left", "Right"},
            Default = "Normal (Mid)",
            Callback = function(val)
                local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui")
                if PlayerGui then
                    local NotifyGui = PlayerGui:FindFirstChild("Text Notifications")
                    if NotifyGui then
                        local Frame = NotifyGui:FindFirstChild("Frame")
                        if Frame then
                            if val == "Normal (Mid)" then
                                Frame.Position = UDim2.new(0.5, 0, 0, 110)
                            elseif val == "Left" then
                                Frame.Position = UDim2.new(0.3, 0, 0, 110)
                            elseif val == "Right" then
                                Frame.Position = UDim2.new(0.7, 0, 0, 110)
                            end
                        end
                    end
                end
            end
        })
    end) -- tutup pcall
end -- tutup if MiscTab

if QuestTab then
    pcall(function()

        local function DetectFishRarityFromArgs(args)
            if not args or #args == 0 then return nil end
            local id, metadata = nil, nil

            if type(args[1]) == "number" or type(args[1]) == "string" then
                id = args[1]
                if type(args[2]) == "table" then metadata = args[2] end
            end

            if not id and #args >= 3 then
                if (type(args[2]) == "number" or type(args[2]) == "string") and type(args[3]) == "table" then
                    id = args[2]; metadata = args[3]
                end
            end

            if not id and type(args[1]) == "table" then
                id = args[1].Id or args[1].id
                metadata = args[1].Metadata or args[1].metadata
            end

            if not id then return nil end

            local rarity = "COMMON"
            if metadata and metadata.Rarity then
                rarity = tostring(metadata.Rarity):upper()
            else
                pcall(function()
                    if ItemUtility then
                        local data = ItemUtility:GetItemData(id)
                        if data and data.Probability and data.Probability.Chance and TierUtility then
                            local tierObj = TierUtility:GetTierFromRarity(data.Probability.Chance)
                            if tierObj and tierObj.Name then rarity = tostring(tierObj.Name):upper() end
                        end
                    end
                end)
            end
            return rarity
        end

        local function GetQuestZone()
            local hrp = getHRP()
            if not hrp then return "Unknown" end
            local pos = hrp.Position

            local sisyphusPos = LOCATIONS and LOCATIONS["Sisyphus Statue"] or Vector3.new(-3732.14013671875,-135.07444763183594,-1013.1876831054688)
            local treasurePos = LOCATIONS and LOCATIONS["Treasure Room"] or Vector3.new(-3648.86328125,-268.6123352050781,-1662.415283203125)
            local ancientPos = LOCATIONS and LOCATIONS["Ancient Jungle"] or Vector3.new(1484.5361328125,11.14309024810791,-300.48779296875)
            local sacredPos = LOCATIONS and LOCATIONS["Sacred Temple"] or Vector3.new(1421.6331787109375,4.8749680519104,-659.717041015625)
            local cellarPos = Vector3.new(2139.544677734375,-91.19776916503906,-766.829833984375)

            if typeof(sisyphusPos) == "CFrame" then sisyphusPos = sisyphusPos.Position end
            if typeof(treasurePos) == "CFrame" then treasurePos = treasurePos.Position end
            if typeof(ancientPos) == "CFrame" then ancientPos = ancientPos.Position end
            if typeof(sacredPos) == "CFrame" then sacredPos = sacredPos.Position end

            if (pos - sisyphusPos).Magnitude < 200 then return "Sisyphus" end
            if (pos - treasurePos).Magnitude < 150 then return "TreasureRoom" end
            if (pos - ancientPos).Magnitude < 300 then return "AncientJungle" end
            if (pos - sacredPos).Magnitude < 200 then return "SacredTemple" end
            if (pos - cellarPos).Magnitude < 100 then return "UndergroundCellar" end
            return "Other"
        end

        local function HasRod(rodId)
            local has = false
            pcall(function()
                local replion = GetPlayerDataReplion()
                if not replion then return end
                local inv = replion:GetExpect("Inventory")
                if not inv then return end
                if inv["Fishing Rods"] and type(inv["Fishing Rods"]) == "table" then
                    for _, rod in ipairs(inv["Fishing Rods"]) do
                        if rod and rod.Id and tonumber(rod.Id) == rodId then has = true; break end
                    end
                end
                if not has and inv.Items and type(inv.Items) == "table" then
                    for _, item in ipairs(inv.Items) do
                        if item and item.Id and tonumber(item.Id) == rodId then has = true; break end
                    end
                end
            end)
            return has
        end

        local function CountTranscendedStones()
            local count = 0
            pcall(function()
                local replion = GetPlayerDataReplion()
                if not replion then return end
                local inv = replion:GetExpect("Inventory")
                if not inv or not inv.Items then return end
                for _, item in ipairs(inv.Items) do
                    if item and item.Id and tonumber(item.Id) == 246 then
                        count = count + (item.Quantity or 1)
                    end
                end
            end)
            return count
        end

        local GhostfinQuest = {
            Active = false, Phase = "Idle",
            SecretCaught = 0, MythicCaught = 0, RareEpicCaught = 0,
            Thread = nil, StatusLabel = nil, HooksSetup = false, IsRunning = false,
        }

        local function UpdateGhostfinStatus()
            local hasRod = HasRod(169)
            local txt = ""
            if hasRod then
                txt = "Ghostfin Rod: <font color='#00ff00'>OWNED</font>\nStatus: <font color='#00ff00'>COMPLETE</font>"
            else
                txt = string.format(
                    "Ghostfin Rod: <font color='#ff0000'>NOT OWNED</font>\n" ..
                    "Phase: <font color='#ffff00'>%s</font>\n" ..
                    "Sisyphus: <font color='#00aaff'>%d/1 Secret</font> | <font color='#ff00ff'>%d/3 Mythic</font>\n" ..
                    "Treasure Room: <font color='#00ff00'>%d/300 Rare+Epic</font>",
                    GhostfinQuest.Phase, GhostfinQuest.SecretCaught,
                    GhostfinQuest.MythicCaught, GhostfinQuest.RareEpicCaught
                )
            end
            SafeUpdateParagraph(GhostfinQuest.StatusLabel, txt)
        end

        local function SetupGhostfinHooks()
            if GhostfinQuest.HooksSetup then return end
            GhostfinQuest.HooksSetup = true

            local function OnFish(args)
                if not GhostfinQuest.Active then return end
                local rarity = DetectFishRarityFromArgs(args)
                if not rarity then return end
                local zone = GetQuestZone()
                local updated = false

                if zone == "Sisyphus" then
                    if rarity == "SECRET" and GhostfinQuest.SecretCaught < 1 then
                        GhostfinQuest.SecretCaught = GhostfinQuest.SecretCaught + 1
                        updated = true
                        NotifySuccess("Ghostfin Quest", "SECRET caught! (" .. GhostfinQuest.SecretCaught .. "/1)")
                    elseif rarity == "MYTHIC" and GhostfinQuest.MythicCaught < 3 then
                        GhostfinQuest.MythicCaught = GhostfinQuest.MythicCaught + 1
                        updated = true
                        NotifySuccess("Ghostfin Quest", "MYTHIC caught! (" .. GhostfinQuest.MythicCaught .. "/3)")
                    end
                elseif zone == "TreasureRoom" then
                    if (rarity == "RARE" or rarity == "EPIC") and GhostfinQuest.RareEpicCaught < 300 then
                        GhostfinQuest.RareEpicCaught = GhostfinQuest.RareEpicCaught + 1
                        updated = true
                        if GhostfinQuest.RareEpicCaught % 50 == 0 or GhostfinQuest.RareEpicCaught == 300 then
                            NotifyInfo("Ghostfin Quest", "Rare/Epic: " .. GhostfinQuest.RareEpicCaught .. "/300")
                        end
                    end
                end
                if updated then UpdateGhostfinStatus() end
            end

            local lastNotifCount = 0
            task.spawn(function()
                while true do
                    task.wait(1)
                    if not GhostfinQuest.Active then continue end
                    local currentNotif = _G.SavedData and _G.SavedData.FishNotif
                    if currentNotif and #currentNotif > 0 then
                        if #currentNotif ~= lastNotifCount then
                            lastNotifCount = #currentNotif
                            OnFish(currentNotif)
                        end
                    end
                end
            end)

            if Events.fishNotif then
                pcall(function() Events.fishNotif.OnClientEvent:Connect(function(...) OnFish({...}) end) end)
            end
            local fishCaughtRemote = GetServerRemote("RE/FishCaught")
            if fishCaughtRemote then
                pcall(function() fishCaughtRemote.OnClientEvent:Connect(function(...) OnFish({...}) end) end)
            end
            local caughtVisualRemote = GetServerRemote("RE/CaughtFishVisual")
            if caughtVisualRemote then
                pcall(function() caughtVisualRemote.OnClientEvent:Connect(function(...) OnFish({...}) end) end)
            end

            pcall(function()
                local replionFolder = ReplicatedStorage:FindFirstChild("Packages")
                if not replionFolder then return end
                local idx = replionFolder:FindFirstChild("_Index")
                if not idx then return end
                local replionMod
                for _, child in ipairs(idx:GetChildren()) do
                    if child.Name:find("ytrev_replion") then replionMod = child:FindFirstChild("replion"); break end
                end
                if not replionMod then return end
                local remotes = replionMod:FindFirstChild("Remotes")
                if not remotes then return end
                local Event = remotes:FindFirstChild("Set")
                if not Event then return end
                Event.OnClientEvent:Connect(function(...)
                    local Args = {...}
                    if type(Args[2]) == "table" then
                        local category = Args[2][1]
                        local subCategory = Args[2][2]
                        if category == "InventoryNotifications" and subCategory == "Fish" then
                            if _G.SavedData and _G.SavedData.FishNotif and #_G.SavedData.FishNotif > 0 then
                                task.spawn(function() task.wait(0.1); OnFish(_G.SavedData.FishNotif) end)
                            end
                        end
                    end
                end)
            end)
        end

        local function RunGhostfinQuest()
            if GhostfinQuest.IsRunning then return end
            GhostfinQuest.IsRunning = true
            GhostfinQuest.Active = true
            GhostfinQuest.Phase = "Checking"
            UpdateGhostfinStatus()
            SetupGhostfinHooks()

            if HasRod(169) then
                NotifySuccess("Ghostfin Quest", "Ghostfin Rod already owned! Quest complete.")
                GhostfinQuest.Phase = "Completed"
                UpdateGhostfinStatus()
                GhostfinQuest.IsRunning = false
                return
            end

            GhostfinQuest.Phase = "Sisyphus"
            UpdateGhostfinStatus()
            NotifyInfo("Ghostfin Quest", "Phase 1: Sisyphus Statue. TP + Tracking ON.")
            NotifyInfo("Ghostfin Quest", "Turn on Cloudy Fishing Beta MANUALLY!")
            teleportTo("Sisyphus Statue")

            while GhostfinQuest.Active and not HasRod(169) do
                if GhostfinQuest.SecretCaught >= 1 and GhostfinQuest.MythicCaught >= 3 then
                    NotifySuccess("Ghostfin Quest", "Phase 1 COMPLETE!")
                    break
                end
                task.wait(5)
                UpdateGhostfinStatus()
            end

            if not GhostfinQuest.Active then GhostfinQuest.IsRunning = false; return end

            GhostfinQuest.Phase = "TreasureRoom"
            UpdateGhostfinStatus()
            NotifyInfo("Ghostfin Quest", "Phase 2: Treasure Room. TP + Tracking ON.")
            teleportTo("Treasure Room")

            while GhostfinQuest.Active and not HasRod(169) do
                if GhostfinQuest.RareEpicCaught >= 300 then
                    NotifySuccess("Ghostfin Quest", "Phase 2 COMPLETE! All requirements done.")
                    GhostfinQuest.Phase = "Completed"
                    UpdateGhostfinStatus()
                    break
                end
                task.wait(5)
                UpdateGhostfinStatus()
            end

            GhostfinQuest.IsRunning = false
            if not GhostfinQuest.Active then GhostfinQuest.Phase = "Idle" end
            UpdateGhostfinStatus()
        end

        local ElementQuest = {
            Active = false, Phase = "Idle",
            AncientJungleSecret = 0, SacredTempleSecret = 0,
            Thread = nil, StatusLabel = nil, HooksSetup = false, IsRunning = false,
        }

        local function UpdateElementStatus()
            local hasGhostfin = HasRod(169)
            local hasElement = HasRod(257)
            local stones = CountTranscendedStones()
            local txt = ""

            if hasElement then
                txt = "Element Rod: <font color='#00ff00'>OWNED</font>\nStatus: <font color='#00ff00'>COMPLETE</font>"
            elseif not hasGhostfin then
                txt = "Element Rod: <font color='#ff0000'>LOCKED</font>\nNeed: <font color='#ffff00'>Ghostfin Rod first!</font>"
            else
                txt = string.format(
                    "Element Rod: <font color='#ffaa00'>IN PROGRESS</font>\n" ..
                    "Phase: <font color='#ffff00'>%s</font>\n" ..
                    "Ancient Jungle Secret: <font color='#00aaff'>%d/1</font>\n" ..
                    "Sacred Temple Secret: <font color='#ff00ff'>%d/1</font>\n" ..
                    "Transcended Stones: <font color='#00ff00'>%d/3</font>",
                    ElementQuest.Phase, ElementQuest.AncientJungleSecret,
                    ElementQuest.SacredTempleSecret, stones
                )
            end
            SafeUpdateParagraph(ElementQuest.StatusLabel, txt)
        end

        local function SetupElementHooks()
            if ElementQuest.HooksSetup then return end
            ElementQuest.HooksSetup = true

            local function OnFish(args)
                if not ElementQuest.Active then return end
                local rarity = DetectFishRarityFromArgs(args)
                if not rarity or rarity ~= "SECRET" then return end
                local zone = GetQuestZone()
                local updated = false

                if zone == "AncientJungle" and ElementQuest.AncientJungleSecret < 1 then
                    ElementQuest.AncientJungleSecret = ElementQuest.AncientJungleSecret + 1
                    updated = true
                    NotifySuccess("Element Quest", "Ancient Jungle SECRET caught! (1/1)")
                elseif zone == "SacredTemple" and ElementQuest.SacredTempleSecret < 1 then
                    ElementQuest.SacredTempleSecret = ElementQuest.SacredTempleSecret + 1
                    updated = true
                    NotifySuccess("Element Quest", "Sacred Temple SECRET caught! (1/1)")
                end
                if updated then UpdateElementStatus() end
            end

            local lastNotifCount = 0
            task.spawn(function()
                while true do
                    task.wait(1)
                    if not ElementQuest.Active then continue end
                    local currentNotif = _G.SavedData and _G.SavedData.FishNotif
                    if currentNotif and #currentNotif > 0 then
                        if #currentNotif ~= lastNotifCount then
                            lastNotifCount = #currentNotif
                            OnFish(currentNotif)
                        end
                    end
                end
            end)

            if Events.fishNotif then
                pcall(function() Events.fishNotif.OnClientEvent:Connect(function(...) OnFish({...}) end) end)
            end
            local fishCaughtRemote = GetServerRemote("RE/FishCaught")
            if fishCaughtRemote then
                pcall(function() fishCaughtRemote.OnClientEvent:Connect(function(...) OnFish({...}) end) end)
            end
            local caughtVisualRemote = GetServerRemote("RE/CaughtFishVisual")
            if caughtVisualRemote then
                pcall(function() caughtVisualRemote.OnClientEvent:Connect(function(...) OnFish({...}) end) end)
            end
        end

        local function RunElementQuest()
            if ElementQuest.IsRunning then return end
            ElementQuest.IsRunning = true
            ElementQuest.Active = true
            ElementQuest.Phase = "Checking"
            UpdateElementStatus()
            SetupElementHooks()

            if HasRod(257) then
                NotifySuccess("Element Quest", "Element Rod already owned! Quest complete.")
                ElementQuest.Phase = "Completed"
                UpdateElementStatus()
                ElementQuest.IsRunning = false
                return
            end

            if not HasRod(169) then
                NotifyError("Element Quest", "You need Ghostfin Rod first! Do Ghostfin Quest.")
                ElementQuest.Phase = "Locked"
                UpdateElementStatus()
                ElementQuest.IsRunning = false
                return
            end

            ElementQuest.Phase = "AncientJungle"
            UpdateElementStatus()
            NotifyInfo("Element Quest", "Phase 1: Ancient Jungle. Catch 1 SECRET.")
            NotifyInfo("Element Quest", "Turn on Cloudy Fishing Beta MANUALLY!")
            teleportTo("Ancient Jungle")

            while ElementQuest.Active and not HasRod(257) do
                if ElementQuest.AncientJungleSecret >= 1 then
                    NotifySuccess("Element Quest", "Phase 1 COMPLETE!")
                    break
                end
                task.wait(5)
                UpdateElementStatus()
            end

            if not ElementQuest.Active then ElementQuest.IsRunning = false; return end

            ElementQuest.Phase = "SacredTemple"
            UpdateElementStatus()
            NotifyInfo("Element Quest", "Phase 2: Sacred Temple. Catch 1 SECRET.")
            teleportTo("Sacred Temple")

            while ElementQuest.Active and not HasRod(257) do
                if ElementQuest.SacredTempleSecret >= 1 then
                    NotifySuccess("Element Quest", "Phase 2 COMPLETE!")
                    break
                end
                task.wait(5)
                UpdateElementStatus()
            end

            if not ElementQuest.Active then ElementQuest.IsRunning = false; return end

            ElementQuest.Phase = "TranscendedStones"
            UpdateElementStatus()
            NotifyInfo("Element Quest", "Phase 3: Make 3 Transcended Stones at Temple Guardian.")
            NotifyInfo("Element Quest", "Use 'Auto Make Transcended Stones' in MainTab!")
            teleportTo("Sacred Temple")

            while ElementQuest.Active and not HasRod(257) do
                local stones = CountTranscendedStones()
                if stones >= 3 then
                    NotifySuccess("Element Quest", "Phase 3 COMPLETE! " .. stones .. " stones ready.")
                    break
                end
                task.wait(5)
                UpdateElementStatus()
            end

            if not ElementQuest.Active then ElementQuest.IsRunning = false; return end

            ElementQuest.Phase = "Claim"
            UpdateElementStatus()
            NotifyInfo("Element Quest", "Phase 4: Go to Underground Cellar to claim Element Rod!")
            teleportTo("Underground Cellar")

            while ElementQuest.Active and not HasRod(257) do
                task.wait(5)
                UpdateElementStatus()
            end

            if HasRod(257) then
                ElementQuest.Phase = "Completed"
                NotifySuccess("Element Quest", "ELEMENT ROD CLAIMED! Quest complete!")
            end

            ElementQuest.IsRunning = false
            if not ElementQuest.Active then ElementQuest.Phase = "Idle" end
            UpdateElementStatus()
        end

        local Section_QuestTab_1 = QuestTab:AddSection("Ghostfin Quest")
        Section_QuestTab_1:AddParagraph({
            Title = "Deep Sea Quest Info",
            Content = "Requirements for Ghostfin Rod (ID 169):\n1. Catch 1 SECRET at Sisyphus Statue\n2. Catch 3 MYTHIC at Sisyphus Statue\n3. Catch 300 RARE/EPIC in Treasure Room\n4. Earn 1M Coins (manual)\n\nEnable toggle -> Auto TP + Tracking. Turn on Cloudy Fishing Beta MANUALLY."
        })

        GhostfinQuest.StatusLabel = Section_QuestTab_1:AddParagraph({
            Title = "Ghostfin Status",
            Content = "Ghostfin Rod: <font color='#ff0000'>NOT OWNED</font>\nPhase: Idle\nClick Refresh to check."
        })

        Section_QuestTab_1:AddButton({
            Title = "Refresh Ghostfin Status",
            Callback = function()
                pcall(function()
                    UpdateGhostfinStatus()
                    if HasRod(169) then NotifySuccess("Ghostfin Quest", "Ghostfin Rod OWNED!")
                    else NotifyInfo("Ghostfin Quest", "Not owned yet. Keep fishing!") end
                end)
            end
        })

        Section_QuestTab_1:AddToggle("Toggle_AutoGhostfinQuestBETA", {
            Title = "Auto Ghostfin Quest [BETA]",
            Description = "Auto TP + Tracking. You MUST turn on Cloudy Fishing Beta manually!",
            Default = false,
            Callback = function(val)
                pcall(function()
                    if val then
                        GhostfinQuest.SecretCaught = 0
                        GhostfinQuest.MythicCaught = 0
                        GhostfinQuest.RareEpicCaught = 0
                        GhostfinQuest.Thread = task.spawn(function() pcall(RunGhostfinQuest) end)
                        NotifySuccess("Ghostfin Quest", "Auto Quest ACTIVE! Now turn on Cloudy Fishing Beta!")
                    else
                        GhostfinQuest.Active = false
                        if GhostfinQuest.Thread then pcall(function() task.cancel(GhostfinQuest.Thread) end); GhostfinQuest.Thread = nil end
                        GhostfinQuest.Phase = "Idle"
                        GhostfinQuest.IsRunning = false
                        UpdateGhostfinStatus()
                        NotifyWarning("Ghostfin Quest", "Stopped.")
                    end
                end)
            end
        })

        Section_QuestTab_1:AddButton({
            Title = "TP to Sisyphus Statue",
            Callback = function()
                pcall(function() teleportTo("Sisyphus Statue"); NotifySuccess("Quest", "Teleported!") end)
            end
        })
        Section_QuestTab_1:AddButton({
            Title = "TP to Treasure Room",
            Callback = function()
                pcall(function() teleportTo("Treasure Room"); NotifySuccess("Quest", "Teleported!") end)
            end
        })

        local Section_QuestTab_2 = QuestTab:AddSection("Element Quest")
        Section_QuestTab_2:AddParagraph({
            Title = "Element Rod Info",
            Content = "Best rod in Fish It! (1111% Luck, 130% Speed, 900k kg)\n\n1. Own Ghostfinn Rod\n2. Catch 1 Secret at Ancient Jungle\n3. Catch 1 Secret at Sacred Temple\n4. Create 3 Transcended Stones\n5. Claim at Underground Cellar (NIGHT)\n\nEnable toggle -> Auto TP + Tracking. Turn on Cloudy Fishing Beta MANUALLY."
        })

        ElementQuest.StatusLabel = Section_QuestTab_2:AddParagraph({
            Title = "Element Status",
            Content = "Element Rod: <font color='#ff0000'>LOCKED</font>\nNeed Ghostfin Rod first."
        })

        Section_QuestTab_2:AddButton({
            Title = "Refresh Element Status",
            Callback = function()
                pcall(function()
                    UpdateElementStatus()
                    if HasRod(257) then NotifySuccess("Element Quest", "Element Rod OWNED!")
                    elseif not HasRod(169) then NotifyWarning("Element Quest", "Need Ghostfin Rod first!")
                    else NotifyInfo("Element Quest", "In progress...") end
                end)
            end
        })

        Section_QuestTab_2:AddToggle("Toggle_AutoElementQuestBETA", {
            Title = "Auto Element Quest [BETA]",
            Description = "Auto TP + Tracking. You MUST turn on Cloudy Fishing Beta manually!",
            Default = false,
            Callback = function(val)
                pcall(function()
                    if val then
                        ElementQuest.AncientJungleSecret = 0
                        ElementQuest.SacredTempleSecret = 0
                        ElementQuest.Thread = task.spawn(function() pcall(RunElementQuest) end)
                        NotifySuccess("Element Quest", "Auto Quest ACTIVE! Now turn on Cloudy Fishing Beta!")
                    else
                        ElementQuest.Active = false
                        if ElementQuest.Thread then pcall(function() task.cancel(ElementQuest.Thread) end); ElementQuest.Thread = nil end
                        ElementQuest.Phase = "Idle"
                        ElementQuest.IsRunning = false
                        UpdateElementStatus()
                        NotifyWarning("Element Quest", "Stopped.")
                    end
                end)
            end
        })

        Section_QuestTab_2:AddButton({
            Title = "TP to Ancient Jungle",
            Callback = function()
                pcall(function() teleportTo("Ancient Jungle"); NotifySuccess("Element", "Teleported!") end)
            end
        })
        Section_QuestTab_2:AddButton({
            Title = "TP to Sacred Temple",
            Callback = function()
                pcall(function() teleportTo("Sacred Temple"); NotifySuccess("Element", "Teleported!") end)
            end
        })
        Section_QuestTab_2:AddButton({
            Title = "TP to Underground Cellar",
            Callback = function()
                pcall(function()
                    local hrp = getHRP()
                    if hrp then TeleportTo(CFrame.new(2139.544677734375, -91.19776916503906, -766.829833984375)) end
                    NotifySuccess("Element", "Teleported to Underground Cellar!")
                end)
            end
        })
        Section_QuestTab_2:AddButton({
            Title = "TP to Temple Guardian (Sacred Temple Top)",
            Description = "For making Transcended Stones",
            Callback = function()
                pcall(function()
                    local hrp = getHRP()
                    if hrp then TeleportTo(CFrame.new(1479.587, 128.295, -604.224)) end
                    NotifySuccess("Element", "Teleported to Temple Guardian!")
                end)
            end
        })

        _G.ESP_Master = _G.ESP_Master or false
        if _G.ESP_Treasure == nil then _G.ESP_Treasure = true end
        if _G.ESP_Hunt == nil then _G.ESP_Hunt = true end
        if _G.ESP_Veilshard == nil then _G.ESP_Veilshard = true end
        if _G.ESP_Crystal == nil then _G.ESP_Crystal = true end
        if _G.ESP_Player == nil then _G.ESP_Player = true end

        local ESP_Cache = {}

        local ESP_Colors = {
            Treasure = Color3.fromRGB(255, 215, 0),
            Hunt = Color3.fromRGB(255, 80, 80),
            Veilshard = Color3.fromRGB(190, 80, 255),
            Crystal = Color3.fromRGB(0, 230, 255),
            Player = Color3.fromRGB(50, 255, 126)
        }

        local function ClearAllESP()
            for inst, data in pairs(ESP_Cache) do
                pcall(function()
                    if data.Billboard then data.Billboard:Destroy() end
                end)
            end
            table.clear(ESP_Cache)
        end

        local function GetTargetPart(inst)
            if not inst or not inst.Parent then return nil end
            if inst:IsA("BasePart") then return inst end
            if inst:IsA("Model") then
                if inst.PrimaryPart and inst.PrimaryPart:IsA("BasePart") and inst.PrimaryPart.Parent then
                    return inst.PrimaryPart
                end
                local head = inst:FindFirstChild("Head")
                if head and head:IsA("BasePart") then return head end
                local hrp = inst:FindFirstChild("HumanoidRootPart")
                if hrp and hrp:IsA("BasePart") then return hrp end
                return inst:FindFirstChildWhichIsA("BasePart")
            end
            return nil
        end

        local function CreateESPItem(inst, targetPart, displayName, categoryLabel, color)
            if not targetPart or not targetPart.Parent then return nil end

            local existing = targetPart:FindFirstChild("CloudyESP")
            if existing then pcall(function() existing:Destroy() end) end

            local bb = Instance.new("BillboardGui")
            bb.Name = "CloudyESP"
            bb.Adornee = targetPart
            bb.Size = UDim2.new(0, 190, 0, 28)
            bb.StudsOffset = Vector3.new(0, 2.5, 0)
            bb.AlwaysOnTop = true
            bb.MaxDistance = math.huge
            bb.LightInfluence = 0
            bb.ClipsDescendants = false
            bb.ResetOnSpawn = false

            local textLabel = Instance.new("TextLabel")
            textLabel.Size = UDim2.new(1, 0, 1, 0)
            textLabel.BackgroundTransparency = 1
            textLabel.Font = Enum.Font.GothamBold
            textLabel.TextSize = 13
            textLabel.TextColor3 = color
            textLabel.TextStrokeTransparency = 0
            textLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
            textLabel.Text = "[" .. categoryLabel .. "] " .. displayName
            textLabel.Parent = bb

            bb.Parent = targetPart

            local cacheEntry = {
                Billboard = bb,
                TextLabel = textLabel,
                TargetPart = targetPart,
                TargetInst = inst,
                Category = categoryLabel,
                DisplayName = displayName,
                Color = color
            }
            ESP_Cache[inst] = cacheEntry
            return cacheEntry
        end

        local function UpdateESPEngine()
            if not _G.ESP_Master then
                if next(ESP_Cache) ~= nil then
                    ClearAllESP()
                end
                return
            end

            local char = LocalPlayer.Character
            local localHrp = char and char:FindFirstChild("HumanoidRootPart")
            local localPos = localHrp and localHrp.Position or Vector3.new(0, 0, 0)

            local activeItems = {}

            if _G.ESP_Player then
                for _, p in ipairs(Players:GetPlayers()) do
                    if p ~= LocalPlayer and p.Character and p.Character.Parent then
                        local pChar = p.Character
                        local hum = pChar:FindFirstChildOfClass("Humanoid")
                        if not hum or hum.Health > 0 then
                            local targetPart = pChar:FindFirstChild("HumanoidRootPart") or pChar:FindFirstChild("Head") or pChar.PrimaryPart
                            if targetPart and targetPart.Parent then
                                activeItems[pChar] = {
                                    TargetPart = targetPart,
                                    Category = "Player",
                                    DisplayName = p.DisplayName or p.Name,
                                    Color = ESP_Colors.Player
                                }
                            end
                        end
                    end
                end
            end

            if _G.ESP_Treasure then
                local storage = Workspace:FindFirstChild("PirateChestStorage")
                if storage then
                    for _, chest in ipairs(storage:GetChildren()) do
                        local targetPart = findPirateChestPart(chest) or GetTargetPart(chest)
                        if targetPart and targetPart.Parent then
                            activeItems[chest] = {
                                TargetPart = targetPart,
                                Category = "Treasure",
                                DisplayName = "Pirate Chest",
                                Color = ESP_Colors.Treasure
                            }
                        end
                    end
                end

                local wreckage = Workspace:FindFirstChild("Sunken Wreckage")
                if wreckage then
                    for _, desc in ipairs(wreckage:GetDescendants()) do
                        local nameLower = desc.Name:lower()
                        local isChest = nameLower:find("chest") or nameLower:find("treasure") or nameLower:find("peti") or nameLower:find("loot") or nameLower:find("reward")
                        local hasInteraction = desc:FindFirstChildWhichIsA("ProximityPrompt") or desc:FindFirstChildWhichIsA("ClickDetector") or desc:IsA("ProximityPrompt") or desc:IsA("ClickDetector")
                        if isChest or hasInteraction then
                            local chestModel = desc:IsA("Model") and desc or (desc.Parent:IsA("Model") and desc.Parent or desc)
                            local targetPart = GetTargetPart(chestModel)
                            if targetPart and targetPart.Parent and not activeItems[chestModel] then
                                activeItems[chestModel] = {
                                    TargetPart = targetPart,
                                    Category = "Treasure",
                                    DisplayName = "Sunken Chest",
                                    Color = ESP_Colors.Treasure
                                }
                            end
                        end
                    end
                end

                local treasureFolder = Workspace:FindFirstChild("Treasure") or Workspace:FindFirstChild("Chests")
                if treasureFolder then
                    for _, chest in ipairs(treasureFolder:GetChildren()) do
                        local targetPart = GetTargetPart(chest)
                        if targetPart and targetPart.Parent and not activeItems[chest] then
                            activeItems[chest] = {
                                TargetPart = targetPart,
                                Category = "Treasure",
                                DisplayName = chest.Name,
                                Color = ESP_Colors.Treasure
                            }
                        end
                    end
                end
            end

            if _G.ESP_Hunt then
                local wreckage = Workspace:FindFirstChild("Sunken Wreckage")
                if wreckage and wreckage.Parent then
                    local targetPart = GetTargetPart(wreckage)
                    if targetPart and targetPart.Parent and not activeItems[wreckage] then
                        activeItems[wreckage] = {
                            TargetPart = targetPart,
                            Category = "Hunt",
                            DisplayName = "Sunken Wreckage",
                            Color = ESP_Colors.Hunt
                        }
                    end
                end

                local menuRings = Workspace:FindFirstChild("!!! MENU RINGS")
                if menuRings then
                    local props = menuRings:FindFirstChild("Props")
                    if props then
                        local model = props:FindFirstChild("Model")
                        if model and model.PrimaryPart then
                            activeItems[model] = {
                                TargetPart = model.PrimaryPart,
                                Category = "Hunt",
                                DisplayName = "Worm Hunt",
                                Color = ESP_Colors.Hunt
                            }
                        end
                    end
                end

                local knownHunts = {
                    ["Megalodon Hunt"] = "Megalodon Hunt",
                    ["Dark Megalodon Hunt"] = "Dark Megalodon Hunt",
                    ["Ghost Shark Hunt"] = "Ghost Shark Hunt",
                    ["Shark Hunt"] = "Shark Hunt",
                    ["Glacial Serpent Hunt"] = "Glacial Serpent Hunt",
                    ["Shocked"] = "Thunderzilla Event",
                    ["Thunderzilla"] = "Thunderzilla Event",
                    ["Thunderzilla Hunt"] = "Thunderzilla Event",
                    ["Worm Hunt"] = "Worm Hunt",
                    ["Whirlpool"] = "Whirlpool",
                    ["Meteor"] = "Meteor Event"
                }

                for _, child in ipairs(Workspace:GetChildren()) do
                    local cName = child.Name
                    local matchedTitle = knownHunts[cName]
                    if not matchedTitle then
                        local nameLower = cName:lower()
                        if nameLower:find("megalodon") or nameLower:find("shark hunt") or nameLower:find("serpent hunt") or nameLower:find("ghost shark") or nameLower:find("thunderzilla") then
                            matchedTitle = cName
                        end
                    end

                    if matchedTitle then
                        local targetPart = GetTargetPart(child)
                        if targetPart and targetPart.Parent and not activeItems[child] then
                            activeItems[child] = {
                                TargetPart = targetPart,
                                Category = "Hunt",
                                DisplayName = matchedTitle,
                                Color = ESP_Colors.Hunt
                            }
                        end
                    end
                end

                local zones = Workspace:FindFirstChild("Zones")
                if zones then
                    local levi = zones:FindFirstChild("Leviathan's Den")
                    if levi and not activeItems[levi] then
                        local targetPart = GetTargetPart(levi)
                        if targetPart then
                            activeItems[levi] = {
                                TargetPart = targetPart,
                                Category = "Hunt",
                                DisplayName = "Leviathan's Den",
                                Color = ESP_Colors.Hunt
                            }
                        end
                    end
                end
            end

            if _G.ESP_Veilshard then
                local islands = Workspace:FindFirstChild("Islands")
                if islands then
                    local lavaBasin = islands:FindFirstChild("Lava Basin")
                    if lavaBasin then
                        local crystalsFolder = lavaBasin:FindFirstChild("Crystals")
                        if crystalsFolder then
                            for _, crystal in ipairs(crystalsFolder:GetChildren()) do
                                if crystal:IsA("Model") and (crystal.Name == "Crystal" or crystal.Name:find("Crystal")) then
                                    local isMineable = false
                                    for _, child in ipairs(crystal:GetDescendants()) do
                                        if child:IsA("BasePart") then
                                            local color = child.Color
                                            if (color.R > 0.4 and color.B > 0.5 and color.G < 0.3) or child:FindFirstChild("Mineable") or child:GetAttribute("Mineable") == true then
                                                isMineable = true
                                                break
                                            end
                                        elseif (child:IsA("ProximityPrompt") and child.Enabled) or child:IsA("ClickDetector") then
                                            isMineable = true
                                            break
                                        end
                                    end
                                    if isMineable then
                                        local targetPart = crystal.PrimaryPart or crystal:FindFirstChildWhichIsA("BasePart")
                                        if targetPart and targetPart.Parent and not activeItems[crystal] then
                                            activeItems[crystal] = {
                                                TargetPart = targetPart,
                                                Category = "Veilshard",
                                                DisplayName = "Veilshard Crystal",
                                                Color = ESP_Colors.Veilshard
                                            }
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
            if _G.ESP_Crystal then
                local islandsFolder = Workspace:FindFirstChild("Islands")
                local searchContainers = {}
                if islandsFolder then
                    local crystalDepth = islandsFolder:FindFirstChild("Crystal Depth")
                    if crystalDepth then table.insert(searchContainers, crystalDepth) end
                end
                local directDepth = Workspace:FindFirstChild("Crystal Depth")
                if directDepth and not table.find(searchContainers, directDepth) then
                    table.insert(searchContainers, directDepth)
                end
                local directCrystals = Workspace:FindFirstChild("Crystals")
                if directCrystals and not table.find(searchContainers, directCrystals) then
                    table.insert(searchContainers, directCrystals)
                end

                for _, container in ipairs(searchContainers) do
                    for _, desc in ipairs(container:GetDescendants()) do
                        if desc:IsA("ProximityPrompt") and desc.Enabled then
                            local actText = (desc.ActionText or ""):lower()
                            local objText = (desc.ObjectText or ""):lower()
                            local isIgnored = actText:find("talk") or actText:find("shop") or actText:find("buy") or actText:find("sell") or actText:find("boat") or actText:find("chest") or actText:find("peti") or objText:find("chest") or objText:find("merchant") or objText:find("boat") or objText:find("npc")

                            if not isIgnored then
                                local targetPart = desc.Parent and (desc.Parent:IsA("BasePart") and desc.Parent or (desc.Parent:IsA("Model") and (desc.Parent.PrimaryPart or desc.Parent:FindFirstChildWhichIsA("BasePart"))))
                                if targetPart and targetPart:IsDescendantOf(Workspace) and targetPart.Transparency < 0.95 then
                                    local model = desc:FindFirstAncestorWhichIsA("Model") or targetPart
                                    if not activeItems[model] and not activeItems[targetPart] then
                                        activeItems[model] = {
                                            TargetPart = targetPart,
                                            Category = "Crystal",
                                            DisplayName = "Crystal Depth",
                                            Color = ESP_Colors.Crystal
                                        }
                                    end
                                end
                            end
                        end
                    end
                end
            end



            for inst, info in pairs(activeItems) do
                local entry = ESP_Cache[inst]
                if not entry or not entry.Billboard or not entry.Billboard.Parent or entry.TargetPart ~= info.TargetPart then
                    entry = CreateESPItem(inst, info.TargetPart, info.DisplayName, info.Category, info.Color)
                end
                if entry and entry.TextLabel and entry.TargetPart and entry.TargetPart.Parent then
                    local dist = math.floor((entry.TargetPart.Position - localPos).Magnitude)
                    entry.TextLabel.Text = string.format("[%s] %s [%dm]", info.Category, info.DisplayName, dist)
                end
            end

            for inst, entry in pairs(ESP_Cache) do
                if not activeItems[inst] or not inst.Parent or not entry.TargetPart or not entry.TargetPart.Parent then
                    pcall(function()
                        if entry.Billboard then entry.Billboard:Destroy() end
                    end)
                    ESP_Cache[inst] = nil
                end
            end
        end

        task.spawn(function()
            while true do
                task.wait(0.2)
                pcall(UpdateESPEngine)
            end
        end)

        if VisualTab then
            pcall(function()
                local Section_VisualTab_ESP = VisualTab:AddSection("ESP")

                Section_VisualTab_ESP:AddToggle("Toggle_EnableESP", {
                    Title = "Enable ESP",
                    Description = "Aktifkan master ESP",
                    Default = false,
                    Callback = function(val)
                        _G.ESP_Master = val
                        if not val then
                            ClearAllESP()
                        end
                    end
                })

                Section_VisualTab_ESP:AddToggle("Toggle_ESPTreasureItem", {
                    Title = "ESP Treasure & Item",
                    Description = "Menampilkan lokasi Treasure & Pirate Chest",
                    Default = true,
                    Callback = function(val)
                        _G.ESP_Treasure = val
                    end
                })

                Section_VisualTab_ESP:AddToggle("Toggle_ESPHunt", {
                    Title = "ESP Hunt",
                    Description = "Menampilkan lokasi Sunken Wreckage & Hunt Event",
                    Default = true,
                    Callback = function(val)
                        _G.ESP_Hunt = val
                    end
                })

                Section_VisualTab_ESP:AddToggle("Toggle_ESPCrystalVeilshard", {
                    Title = "ESP Crystal Veilshard",
                    Description = "Menampilkan lokasi Veilshard Crystal",
                    Default = true,
                    Callback = function(val)
                        _G.ESP_Veilshard = val
                    end
                })

                Section_VisualTab_ESP:AddToggle("Toggle_ESPCrystal", {
                    Title = "ESP Crystal",
                    Description = "Menampilkan lokasi Normal Crystal",
                    Default = true,
                    Callback = function(val)
                        _G.ESP_Crystal = val
                    end
                })

                Section_VisualTab_ESP:AddToggle("Toggle_ESPPlayer", {
                    Title = "ESP Player",
                    Description = "Menampilkan lokasi Player lain di server",
                    Default = true,
                    Callback = function(val)
                        _G.ESP_Player = val
                    end
                })

                local Section_VisualTab_ColorRes = VisualTab:AddSection("Color Resolution")

                local function ApplyColorResolution(resName)
                    pcall(function()
                        local Lighting = game:GetService("Lighting")

                        local cc = Lighting:FindFirstChild("QH_ColorResolution_CC")
                        if not cc then
                            cc = Instance.new("ColorCorrectionEffect")
                            cc.Name = "QH_ColorResolution_CC"
                            cc.Parent = Lighting
                        end

                        local bloom = Lighting:FindFirstChild("QH_ColorResolution_Bloom")
                        if not bloom then
                            bloom = Instance.new("BloomEffect")
                            bloom.Name = "QH_ColorResolution_Bloom"
                            bloom.Parent = Lighting
                        end

                        local sunRays = Lighting:FindFirstChild("QH_ColorResolution_SunRays")
                        if not sunRays then
                            sunRays = Instance.new("SunRaysEffect")
                            sunRays.Name = "QH_ColorResolution_SunRays"
                            sunRays.Parent = Lighting
                        end

                        local res = tostring(resName)

                        if string.find(res, "240p") then
                            cc.Enabled = true
                            cc.Brightness = 0
                            cc.Contrast = -0.05
                            cc.Saturation = -0.1
                            cc.TintColor = Color3.fromRGB(240, 240, 240)
                            bloom.Enabled = false
                            sunRays.Enabled = false
                            pcall(function() UserSettings():GetService("UserGameSettings").SavedQualityLevel = Enum.SavedQualitySetting.QualityLevel1 end)
                            pcall(function() if setfpscap then setfpscap(30) end end)
                            NotifyInfo("Color Resolution", "Resolusi diatur ke 240p (Potato Mode)")
                        elseif string.find(res, "360p") then
                            cc.Enabled = true
                            cc.Brightness = 0
                            cc.Contrast = 0
                            cc.Saturation = 0
                            cc.TintColor = Color3.fromRGB(250, 250, 250)
                            bloom.Enabled = false
                            sunRays.Enabled = false
                            pcall(function() UserSettings():GetService("UserGameSettings").SavedQualityLevel = Enum.SavedQualitySetting.QualityLevel2 end)
                            pcall(function() if setfpscap then setfpscap(45) end end)
                            NotifyInfo("Color Resolution", "Resolusi diatur ke 360p (Low)")
                        elseif string.find(res, "480p") then
                            cc.Enabled = false
                            bloom.Enabled = false
                            sunRays.Enabled = false
                            pcall(function() UserSettings():GetService("UserGameSettings").SavedQualityLevel = Enum.SavedQualitySetting.QualityLevel3 end)
                            pcall(function() if setfpscap then setfpscap(60) end end)
                            NotifyInfo("Color Resolution", "Resolusi diatur ke 480p (Standard)")
                        elseif string.find(res, "720p") then
                            cc.Enabled = true
                            cc.Brightness = 0
                            cc.Contrast = 0.05
                            cc.Saturation = 0.05
                            cc.TintColor = Color3.fromRGB(255, 255, 255)
                            bloom.Enabled = true
                            bloom.Intensity = 0.1
                            bloom.Size = 12
                            bloom.Threshold = 0.95
                            sunRays.Enabled = false
                            pcall(function() UserSettings():GetService("UserGameSettings").SavedQualityLevel = Enum.SavedQualitySetting.QualityLevel6 end)
                            pcall(function() if setfpscap then setfpscap(0) end end)
                            NotifyInfo("Color Resolution", "Resolusi diatur ke 720p HD")
                        elseif string.find(res, "1080p") then
                            cc.Enabled = true
                            cc.Brightness = 0
                            cc.Contrast = 0.08
                            cc.Saturation = 0.08
                            cc.TintColor = Color3.fromRGB(255, 255, 255)
                            bloom.Enabled = true
                            bloom.Intensity = 0.15
                            bloom.Size = 14
                            bloom.Threshold = 0.94
                            sunRays.Enabled = true
                            sunRays.Intensity = 0.03
                            sunRays.Spread = 0.6
                            pcall(function() UserSettings():GetService("UserGameSettings").SavedQualityLevel = Enum.SavedQualitySetting.QualityLevel8 end)
                            pcall(function() if setfpscap then setfpscap(0) end end)
                            pcall(function() if sethiddenproperty then sethiddenproperty(Lighting, "Technology", Enum.Technology.ShadowMap) end end)
                            NotifyInfo("Color Resolution", "Resolusi diatur ke 1080p Full HD (Tajam & Jernih)")
                        elseif string.find(res, "1440p") then
                            cc.Enabled = true
                            cc.Brightness = 0
                            cc.Contrast = 0.1
                            cc.Saturation = 0.1
                            cc.TintColor = Color3.fromRGB(255, 255, 255)
                            bloom.Enabled = true
                            bloom.Intensity = 0.18
                            bloom.Size = 16
                            bloom.Threshold = 0.94
                            sunRays.Enabled = true
                            sunRays.Intensity = 0.05
                            sunRays.Spread = 0.7
                            pcall(function() UserSettings():GetService("UserGameSettings").SavedQualityLevel = Enum.SavedQualitySetting.QualityLevel10 end)
                            pcall(function() if setfpscap then setfpscap(0) end end)
                            pcall(function() if sethiddenproperty then sethiddenproperty(Lighting, "Technology", Enum.Technology.Future) end end)
                            NotifyInfo("Color Resolution", "Resolusi diatur ke 1440p 2K Ultra HD")
                        elseif string.find(res, "4K") or string.find(res, "2160p") then
                            cc.Enabled = true
                            cc.Brightness = 0
                            cc.Contrast = 0.12
                            cc.Saturation = 0.12
                            cc.TintColor = Color3.fromRGB(255, 255, 255)
                            bloom.Enabled = true
                            bloom.Intensity = 0.2
                            bloom.Size = 18
                            bloom.Threshold = 0.95
                            sunRays.Enabled = true
                            sunRays.Intensity = 0.06
                            sunRays.Spread = 0.8
                            pcall(function() UserSettings():GetService("UserGameSettings").SavedQualityLevel = Enum.SavedQualitySetting.QualityLevel10 end)
                            pcall(function() if setfpscap then setfpscap(0) end end)
                            pcall(function() if sethiddenproperty then sethiddenproperty(Lighting, "Technology", Enum.Technology.Future) end end)
                            NotifyInfo("Color Resolution", "Resolusi diatur ke 4K True HD (Ultra Clear)")
                        end
                    end)
                end

                local resOptions = {"240p (Potato)", "360p (Low)", "480p (SD)", "720p HD", "1080p Full HD", "1440p 2K HD", "2160p 4K HD"}

                Section_VisualTab_ColorRes:AddDropdown("Dropdown_PilihColorResolution", {
                    Title = "Pilih Color Resolution",
                    Description = "Sesuaikan resolusi & warna visual hingga 4K HD",
                    Values = resOptions,
                    Default = resOptions[5],
                    Callback = function(val)
                        local selName = typeof(val) == "table" and val or tostring(val)
                        ApplyColorResolution(selName)
                    end, Multi = false
                })
            end)
        end

        task.spawn(function()
            while true do
                task.wait(5)
                pcall(function()
                    UpdateGhostfinStatus()
                    UpdateElementStatus()
                end)
            end
        end)

        task.delay(3, function()
            pcall(function()
                UpdateGhostfinStatus()
                UpdateElementStatus()
            end)
        end)
    end)
end
pcall(function()
    Fluent:Notify({
        Title = "Cloudy HUB V 1.0.4",
        Content = "Loaded! Remotes: " .. loadedCount .. " | Failed: " .. failedCount .. " | Map: " .. (isSupported and supportedMaps["121864768012064"] or mapName),
        Duration = 5,
        Icon = "solar/atom-bold"
    })
end)

task.delay(1.5, function()
    _scriptInitialized = true
end)

pcall(function()
    task.wait(5)
    if _G.QH_TreasureHopActive then
        NotifyInfo("Treasure Hop", "Auto-hop masih aktif! Checking server...")
        task.spawn(CheckAndHopForTreasure)
    end
end)
