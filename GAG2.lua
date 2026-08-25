local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/CloudyEX/CloudyMain/refs/heads/main/UI.lua"))()

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local TeleportService = game:GetService("TeleportService")
local VirtualInputManager = pcall(function() return game:GetService("VirtualInputManager") end) and game:GetService("VirtualInputManager") or nil
local VirtualUser = pcall(function() return game:GetService("VirtualUser") end) and game:GetService("VirtualUser") or nil

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
local Humanoid = Character:WaitForChild("Humanoid")

LocalPlayer.CharacterAdded:Connect(function(newChar)
    Character = newChar
    HumanoidRootPart = newChar:WaitForChild("HumanoidRootPart")
    Humanoid = newChar:WaitForChild("Humanoid")
end)

local SharedModules = ReplicatedStorage:WaitForChild("SharedModules")
local NetworkingModule = SharedModules:WaitForChild("Networking")
local Networking = typeof(require) == "function" and pcall(require, NetworkingModule) and require(NetworkingModule) or NetworkingModule

local Config = {
    InstantInteraction = true,
    AutoHarvest = false,
    AutoWater = false,
    AutoPlant = false,
    SelectedSeedToPlant = "Bamboo",
    AutoSell = false,
    AutoDailyDeal = false,
    SellInterval = 3,
    HideMyPlotPlants = false,

    AutoSteal = false,
    HitAndRun = false,
    StealSpeed = 1,
    OwnerProximityCheck = false,
    SafeDistance = 45,
    IgnoreFriends = true,

    Mutation_Gold = true,
    Mutation_Rainbow = true,
    Mutation_Electric = true,
    Mutation_Frozen = true,
    Mutation_Bloodlit = true,
    Mutation_Chained = true,
    Mutation_Starstruck = true,

    SelectedSeedToBuy = "Bamboo",
    AutoBuySeeds = false,
    AutoBuyAllSeeds = false,
    BuyInterval = 2,
    HopOnOutOfStock = false,

    Pet_Bee = false,
    Pet_BlackDragon = false,
    Pet_Bunny = false,
    Pet_Deer = false,
    Pet_Dragonfly = false,
    Pet_Frog = false,
    Pet_GoldenDragonfly = false,
    Pet_IceSerpent = false,
    Pet_Monkey = false,
    Pet_Owl = false,
    Pet_Raccoon = false,
    Pet_Robin = false,
    Pet_Unicorn = false,

    LockWalkSpeed = false,
    WalkSpeedValue = 16,
    LockJumpPower = false,
    JumpPowerValue = 50,
    InfiniteJump = false,
    Noclip = false,

    ESPPets = false,
    ESPMutations = false,
    ESPPlots = false,

    FPSBooster = false,
    AntiAFK = true,

    EnableWebhook = false,
    WebhookUrl = "",
    LogStolen = true,
    LogPets = true
}

local SeedList = {
    "Pumpkin",
    "Sunflower",
    "Watermelon",
    "Grape",
    "Mango",
    "DragonFruit",
    "Coconut",
    "Bamboo",
    "Apple",
    "Tomato",
    "Tulip",
    "Blueberry",
    "Strawberry",
    "Carrot"
}

local WildPetList = {
    { Name = "Buy Bee", Key = "Pet_Bee", Pet = "Bee" },
    { Name = "Buy Black Dragon", Key = "Pet_BlackDragon", Pet = "BlackDragon" },
    { Name = "Buy Bunny", Key = "Pet_Bunny", Pet = "Bunny" },
    { Name = "Buy Deer", Key = "Pet_Deer", Pet = "Deer" },
    { Name = "Buy Dragonfly", Key = "Pet_Dragonfly", Pet = "Dragonfly" },
    { Name = "Buy Frog", Key = "Pet_Frog", Pet = "Frog" },
    { Name = "Buy Golden Dragonfly", Key = "Pet_GoldenDragonfly", Pet = "GoldenDragonfly" },
    { Name = "Buy Ice Serpent", Key = "Pet_IceSerpent", Pet = "IceSerpent" },
    { Name = "Buy Monkey", Key = "Pet_Monkey", Pet = "Monkey" },
    { Name = "Buy Owl", Key = "Pet_Owl", Pet = "Owl" },
    { Name = "Buy Raccoon", Key = "Pet_Raccoon", Pet = "Raccoon" },
    { Name = "Buy Robin", Key = "Pet_Robin", Pet = "Robin" },
    { Name = "Buy Unicorn", Key = "Pet_Unicorn", Pet = "Unicorn" }
}

local MutationColors = {
    Gold = Color3.fromRGB(255, 215, 0),
    Rainbow = Color3.fromRGB(185, 80, 255),
    Electric = Color3.fromRGB(0, 255, 255),
    Frozen = Color3.fromRGB(100, 200, 255),
    Bloodlit = Color3.fromRGB(255, 40, 40),
    Chained = Color3.fromRGB(180, 180, 180),
    Starstruck = Color3.fromRGB(255, 105, 180)
}

local function Notify(title, content, duration, icon)
    pcall(function()
        if Fluent and Fluent.Notify then
            Fluent:Notify({
                Title = title or "Cloudy",
                Content = content or "",
                Duration = duration or 3,
                Icon = icon or "solar/info-circle-bold"
            })
        end
    end)
end

local function SendWebhook(title, description, color)
    if not Config.EnableWebhook or Config.WebhookUrl == "" then return end
    local req = (syn and syn.request) or (http and http.request) or http_request or request
    if req then
        task.spawn(function()
            pcall(function()
                local payload = HttpService:JSONEncode({
                    embeds = {{
                        title = title or "Cloudy Notification",
                        description = description or "",
                        color = color or 5814783,
                        footer = { text = "Cloudy HUB • Grow a Garden" },
                        timestamp = DateTime.now():ToIsoDate()
                    }}
                })
                req({
                    Url = Config.WebhookUrl,
                    Method = "POST",
                    Headers = { ["Content-Type"] = "application/json" },
                    Body = payload
                })
            end)
        end)
    end
end

local function BypassPrompt(prompt)
    if not prompt or not prompt:IsA("ProximityPrompt") then return end
    if Config.InstantInteraction then
        prompt.RequiresLineOfSight = false
        prompt.MaxActivationDistance = 999999
        prompt.HoldDuration = 0
    end
end

local function SafeFirePrompt(prompt)
    if not prompt then return false end
    BypassPrompt(prompt)
    if typeof(fireproximityprompt) == "function" then
        fireproximityprompt(prompt, 0)
        fireproximityprompt(prompt)
        return true
    elseif prompt.InputHoldBegin then
        prompt:InputHoldBegin()
        task.wait(prompt.HoldDuration or 0)
        prompt:InputHoldEnd()
        return true
    end
    return false
end

local function GetMyPlot()
    local gardens = Workspace:FindFirstChild("Gardens")
    if not gardens then return nil end
    for i = 1, 8 do
        local plot = gardens:FindFirstChild("Plot" .. i)
        if plot and plot:GetAttribute("OwnerUserId") == LocalPlayer.UserId then
            return plot, i
        end
    end
    return nil
end

local function GetAllOtherPlots()
    local gardens = Workspace:FindFirstChild("Gardens")
    local plots = {}
    if not gardens then return plots end
    for i = 1, 8 do
        local plot = gardens:FindFirstChild("Plot" .. i)
        if plot and plot:GetAttribute("OwnerUserId") ~= LocalPlayer.UserId and plot:GetAttribute("OwnerUserId") ~= 0 then
            table.insert(plots, plot)
        end
    end
    return plots
end

local function IsFriend(userId)
    if not userId or userId == 0 then return false end
    local ok, isFr = pcall(function() return LocalPlayer:IsFriendsWith(userId) end)
    return ok and isFr or false
end

local function GetServerFarmStats()
    local totalMutations = 0
    local totalReady = 0
    local gardens = Workspace:FindFirstChild("Gardens")
    if gardens then
        for i = 1, 8 do
            local plot = gardens:FindFirstChild("Plot" .. i)
            if plot and plot:FindFirstChild("Plants") then
                for _, plant in ipairs(plot.Plants:GetChildren()) do
                    local mut = plant:GetAttribute("Mutation")
                    if mut and mut ~= "None" then
                        totalMutations = totalMutations + 1
                    end
                    local isReady = plant:GetAttribute("Harvestable") or plant:GetAttribute("IsReady") or (plant:GetAttribute("PlantStage") and plant:GetAttribute("PlantStage") >= 3)
                    if isReady then
                        totalReady = totalReady + 1
                    end
                end
            end
        end
    end
    local wildPetCount = 0
    local map = Workspace:FindFirstChild("Map")
    local wildPets = map and map:FindFirstChild("WildPetSpawns")
    if wildPets then
        for _, sp in ipairs(wildPets:GetChildren()) do
            if sp:GetAttribute("PetName") then
                wildPetCount = wildPetCount + 1
            end
        end
    end
    return totalMutations, totalReady, wildPetCount
end

local Window = Fluent:CreateWindow({
    Title = "Cloudy",
    TitleIcon = "lucide/cloud",
    SubTitle = "Grow a Garden",
    MinWindowSize = Vector2.new(440, 250),
    Size = UDim2.fromOffset(525, 290),
    Acrylic = false,
    Theme = "Cloudy",
    MinimizeKey = Enum.KeyCode.LeftControl,
    MinimizeIcon = "rbxassetid://109388426525855"
})

local HomeTab = Window:AddTab({ Title = "Home", Icon = "solar/home-2-bold" })
local FarmingTab = Window:AddTab({ Title = "Farming", Icon = "solar/leaf-bold" })
local StealingTab = Window:AddTab({ Title = "Stealing", Icon = "solar/bolt-bold" })
local ShopTab = Window:AddTab({ Title = "Shop", Icon = "solar/cart-2-bold" })
local PetsTab = Window:AddTab({ Title = "Pets", Icon = "solar/shop-2-bold" })
local VisualsTab = Window:AddTab({ Title = "Visuals", Icon = "solar/user-bold" })
local SettingsTab = Window:AddTab({ Title = "Settings", Icon = "solar/settings-minimalistic-bold" })

HomeTab:AddSection("Account & Server Status")

HomeTab:AddParagraph({
    Title = "Player Information",
    Content = "Name: " .. tostring(LocalPlayer.DisplayName) .. "\nUsername: @" .. tostring(LocalPlayer.Name) .. "\nUser ID: " .. tostring(LocalPlayer.UserId)
})

local ServerStatsParagraph = HomeTab:AddParagraph({
    Title = "Live Server Farm Stats",
    Content = "Fetching server statistics..."
})

local function UpdateStatsDisplay()
    local mutCount, readyCount, petCount = GetServerFarmStats()
    local myPlotObj, pIdx = GetMyPlot()
    local plotStr = myPlotObj and ("Plot " .. tostring(pIdx)) or "None"
    ServerStatsParagraph:SetContent("Owned Plot: " .. plotStr .. "\nServer Mutated Crops: " .. tostring(mutCount) .. "\nReady Harvests: " .. tostring(readyCount) .. "\nActive Wild Pets: " .. tostring(petCount))
end
task.spawn(function()
    while true do
        pcall(UpdateStatsDisplay)
        task.wait(4)
    end
end)

HomeTab:AddSection("Plot Manager")

local myPlot, plotIndex = GetMyPlot()
local PlotStatusParagraph = HomeTab:AddParagraph({
    Title = "My Plot Status",
    Content = myPlot and ("Owned Plot: Plot " .. tostring(plotIndex)) or "No plots owned currently"
})

HomeTab:AddButton({
    Title = "Teleport to Plot",
    Description = "Teleports character directly to your plot",
    Callback = function()
        local plot = GetMyPlot()
        if plot then
            local primary = plot.PrimaryPart or plot:FindFirstChildWhichIsA("BasePart") or plot:FindFirstChild("Base")
            if primary and Character and Character:FindFirstChild("HumanoidRootPart") then
                Character.HumanoidRootPart.CFrame = primary.CFrame + Vector3.new(0, 4, 0)
                Notify("Teleport", "Teleported to your plot!", 2, "solar/check-circle-bold")
            end
        else
            Notify("Teleport", "You do not own a plot yet!", 3, "solar/danger-triangle-bold")
        end
    end
})

HomeTab:AddButton({
    Title = "Refresh Plot Status",
    Description = "Manually rescans garden plots",
    Callback = function()
        local currentPlot, idx = GetMyPlot()
        PlotStatusParagraph:SetContent(currentPlot and ("Owned Plot: Plot " .. tostring(idx)) or "No plots owned currently")
        Notify("Plot Scanner", "Plot status updated successfully!", 2, "solar/check-circle-bold")
    end
})

FarmingTab:AddSection("Auto Farm")

FarmingTab:AddToggle("InstantInteraction", {
    Title = "Instant Interaction",
    Default = Config.InstantInteraction,
    Callback = function(val)
        Config.InstantInteraction = val
    end
})

FarmingTab:AddToggle("AutoHarvest", {
    Title = "Auto Harvest Crops",
    Default = Config.AutoHarvest,
    Callback = function(val)
        Config.AutoHarvest = val
    end
})

FarmingTab:AddToggle("AutoWater", {
    Title = "Auto Water Crops",
    Default = Config.AutoWater,
    Callback = function(val)
        Config.AutoWater = val
    end
})

FarmingTab:AddToggle("AutoPlant", {
    Title = "Auto Plant Seeds",
    Default = Config.AutoPlant,
    Callback = function(val)
        Config.AutoPlant = val
    end
})

FarmingTab:AddDropdown("SelectedSeedToPlant", {
    Title = "Seed to Plant",
    Values = SeedList,
    Default = Config.SelectedSeedToPlant,
    Multi = false,
    Callback = function(val)
        Config.SelectedSeedToPlant = val
    end
})

FarmingTab:AddToggle("HideMyPlotPlants", {
    Title = "Hide Own Plants",
    Default = Config.HideMyPlotPlants,
    Callback = function(val)
        Config.HideMyPlotPlants = val
        local plot = GetMyPlot()
        if plot and plot:FindFirstChild("Plants") then
            for _, plant in ipairs(plot.Plants:GetDescendants()) do
                if plant:IsA("BasePart") then
                    plant.LocalTransparencyModifier = val and 1 or 0
                end
            end
        end
        Notify("Farming", val and "Plants in your plot hidden" or "Plants in your plot visible", 2, "solar/eye-bold")
    end
})

FarmingTab:AddSection("Auto Sell")

FarmingTab:AddToggle("AutoSell", {
    Title = "Auto Sell Crops",
    Default = Config.AutoSell,
    Callback = function(val)
        Config.AutoSell = val
    end
})

FarmingTab:AddToggle("AutoDailyDeal", {
    Title = "Auto 5x Daily Deal",
    Default = Config.AutoDailyDeal,
    Callback = function(val)
        Config.AutoDailyDeal = val
    end
})

FarmingTab:AddSlider("SellInterval", {
    Title = "Sell Interval",
    Min = 1,
    Max = 30,
    Default = Config.SellInterval,
    Rounding = 0,
    Callback = function(val)
        Config.SellInterval = val
    end
})

StealingTab:AddSection("Auto Steal")

StealingTab:AddToggle("AutoSteal", {
    Title = "Auto Steal Mutations",
    Default = Config.AutoSteal,
    Callback = function(val)
        Config.AutoSteal = val
        Notify("Stealing", val and "Auto Steal enabled" or "Auto Steal disabled", 2, "solar/bolt-bold")
    end
})

StealingTab:AddToggle("HitAndRun", {
    Title = "Hit & Run Mode",
    Default = Config.HitAndRun,
    Callback = function(val)
        Config.HitAndRun = val
        Notify("Stealing", val and "Hit & Run Mode enabled (TP -> Steal -> Return)" or "Hit & Run Mode disabled", 2, "solar/bolt-bold")
    end
})

StealingTab:AddSlider("StealSpeed", {
    Title = "Steal Speed",
    Min = 0.1,
    Max = 5,
    Default = Config.StealSpeed,
    Rounding = 1,
    Callback = function(val)
        Config.StealSpeed = val
    end
})

StealingTab:AddSection("Safety Settings")

StealingTab:AddToggle("OwnerProximityCheck", {
    Title = "Owner Proximity Check",
    Default = Config.OwnerProximityCheck,
    Callback = function(val)
        Config.OwnerProximityCheck = val
    end
})

StealingTab:AddSlider("SafeDistance", {
    Title = "Safe Distance",
    Min = 15,
    Max = 150,
    Default = Config.SafeDistance,
    Rounding = 0,
    Callback = function(val)
        Config.SafeDistance = val
    end
})

StealingTab:AddToggle("IgnoreFriends", {
    Title = "Ignore Friends",
    Default = Config.IgnoreFriends,
    Callback = function(val)
        Config.IgnoreFriends = val
    end
})

StealingTab:AddSection("Mutation Filter")

local function MakeMutationToggle(title, key)
    StealingTab:AddToggle(key, {
        Title = title,
        Default = Config[key],
        Callback = function(val)
            Config[key] = val
        end
    })
end

MakeMutationToggle("Gold Mutation", "Mutation_Gold")
MakeMutationToggle("Rainbow Mutation", "Mutation_Rainbow")
MakeMutationToggle("Electric Mutation", "Mutation_Electric")
MakeMutationToggle("Frozen Mutation", "Mutation_Frozen")
MakeMutationToggle("Bloodlit Mutation", "Mutation_Bloodlit")
MakeMutationToggle("Chained Mutation", "Mutation_Chained")
MakeMutationToggle("Starstruck Mutation", "Mutation_Starstruck")

ShopTab:AddSection("Auto Buy Seeds")

ShopTab:AddDropdown("SelectedSeedToBuy", {
    Title = "Select Seed",
    Values = SeedList,
    Default = Config.SelectedSeedToBuy,
    Multi = false,
    Callback = function(val)
        Config.SelectedSeedToBuy = val
    end
})

ShopTab:AddToggle("AutoBuySeeds", {
    Title = "Auto Buy Seed",
    Default = Config.AutoBuySeeds,
    Callback = function(val)
        Config.AutoBuySeeds = val
    end
})

ShopTab:AddToggle("AutoBuyAllSeeds", {
    Title = "Auto Buy All Stock",
    Default = Config.AutoBuyAllSeeds,
    Callback = function(val)
        Config.AutoBuyAllSeeds = val
    end
})

ShopTab:AddSlider("BuyInterval", {
    Title = "Buy Interval",
    Min = 0.5,
    Max = 10,
    Default = Config.BuyInterval,
    Rounding = 1,
    Callback = function(val)
        Config.BuyInterval = val
    end
})

ShopTab:AddSection("Stock Management")

ShopTab:AddToggle("HopOnOutOfStock", {
    Title = "Hop When Out of Stock",
    Default = Config.HopOnOutOfStock,
    Callback = function(val)
        Config.HopOnOutOfStock = val
    end
})

PetsTab:AddSection("Auto Buy Wild Pets")

for _, petInfo in ipairs(WildPetList) do
    PetsTab:AddToggle(petInfo.Key, {
        Title = petInfo.Name,
        Default = Config[petInfo.Key],
        Callback = function(val)
            Config[petInfo.Key] = val
        end
    })
end

PetsTab:AddSection("Pet Utilities")

PetsTab:AddButton({
    Title = "Equip Best Pets",
    Description = "Equips your strongest pets",
    Callback = function()
        pcall(function()
            if Networking and Networking.NPCS and Networking.NPCS.EquipBestPets then
                Networking.NPCS.EquipBestPets:Fire()
            elseif Networking and Networking.EquipBestPets then
                Networking.EquipBestPets:Fire()
            end
            Notify("Pets", "Equipped best pets!", 2, "solar/cat-bold")
        end)
    end
})

PetsTab:AddButton({
    Title = "Unequip All Pets",
    Description = "Unequips all active pets",
    Callback = function()
        pcall(function()
            if Networking and Networking.NPCS and Networking.NPCS.UnequipAllPets then
                Networking.NPCS.UnequipAllPets:Fire()
            elseif Networking and Networking.UnequipAllPets then
                Networking.UnequipAllPets:Fire()
            end
            Notify("Pets", "Unequipped all pets!", 2, "solar/cat-bold")
        end)
    end
})

VisualsTab:AddSection("Player Movement")

VisualsTab:AddToggle("LockWalkSpeed", {
    Title = "Lock WalkSpeed",
    Default = Config.LockWalkSpeed,
    Callback = function(val)
        Config.LockWalkSpeed = val
        if not val and Character and Character:FindFirstChild("Humanoid") then
            Character.Humanoid.WalkSpeed = 16
        end
    end
})

VisualsTab:AddSlider("WalkSpeedValue", {
    Title = "WalkSpeed",
    Min = 16,
    Max = 250,
    Default = Config.WalkSpeedValue,
    Rounding = 0,
    Callback = function(val)
        Config.WalkSpeedValue = val
        if Config.LockWalkSpeed and Character and Character:FindFirstChild("Humanoid") then
            Character.Humanoid.WalkSpeed = val
        end
    end
})

VisualsTab:AddToggle("LockJumpPower", {
    Title = "Lock JumpPower",
    Default = Config.LockJumpPower,
    Callback = function(val)
        Config.LockJumpPower = val
        if not val and Character and Character:FindFirstChild("Humanoid") then
            Character.Humanoid.JumpPower = 50
        end
    end
})

VisualsTab:AddSlider("JumpPowerValue", {
    Title = "JumpPower",
    Min = 50,
    Max = 300,
    Default = Config.JumpPowerValue,
    Rounding = 0,
    Callback = function(val)
        Config.JumpPowerValue = val
        if Config.LockJumpPower and Character and Character:FindFirstChild("Humanoid") then
            Character.Humanoid.JumpPower = val
        end
    end
})

VisualsTab:AddToggle("InfiniteJump", {
    Title = "Infinite Jump",
    Default = Config.InfiniteJump,
    Callback = function(val)
        Config.InfiniteJump = val
    end
})

VisualsTab:AddToggle("Noclip", {
    Title = "Noclip",
    Default = Config.Noclip,
    Callback = function(val)
        Config.Noclip = val
    end
})

RunService.RenderStepped:Connect(function()
    if Character and Character:FindFirstChild("Humanoid") then
        if Config.LockWalkSpeed then
            Character.Humanoid.WalkSpeed = Config.WalkSpeedValue
        end
        if Config.LockJumpPower then
            Character.Humanoid.JumpPower = Config.JumpPowerValue
        end
    end
    if Config.Noclip and Character then
        for _, part in ipairs(Character:GetChildren()) do
            if part:IsA("BasePart") and part.CanCollide then
                part.CanCollide = false
            end
        end
    end
end)

UserInputService.JumpRequest:Connect(function()
    if Config.InfiniteJump and Character and Character:FindFirstChildOfClass("Humanoid") then
        Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

VisualsTab:AddSection("Visuals & ESP")

local ESPFolder = PlayerGui:FindFirstChild("CloudyESP") or Instance.new("Folder")
ESPFolder.Name = "CloudyESP"
ESPFolder.Parent = PlayerGui

VisualsTab:AddToggle("ESPPets", {
    Title = "ESP Wild Pets",
    Default = Config.ESPPets,
    Callback = function(val)
        Config.ESPPets = val
        if not val then
            for _, tag in ipairs(ESPFolder:GetChildren()) do
                if tag.Name:find("PetESP_") then
                    tag:Destroy()
                end
            end
        end
    end
})

VisualsTab:AddToggle("ESPMutations", {
    Title = "ESP Mutations",
    Default = Config.ESPMutations,
    Callback = function(val)
        Config.ESPMutations = val
        if not val then
            for _, tag in ipairs(ESPFolder:GetChildren()) do
                if tag.Name:find("MutationESP_") then
                    tag:Destroy()
                end
            end
        end
    end
})

VisualsTab:AddToggle("ESPPlots", {
    Title = "ESP Plots",
    Default = Config.ESPPlots,
    Callback = function(val)
        Config.ESPPlots = val
        if not val then
            for _, tag in ipairs(ESPFolder:GetChildren()) do
                if tag.Name:find("PlotESP_") then
                    tag:Destroy()
                end
            end
        end
    end
})

RunService.RenderStepped:Connect(function()
    if not Config.ESPPets and not Config.ESPMutations and not Config.ESPPlots then return end

    if Config.ESPPets then
        local map = Workspace:FindFirstChild("Map")
        local wildPets = map and map:FindFirstChild("WildPetSpawns")
        if wildPets then
            for _, spawnPoint in ipairs(wildPets:GetChildren()) do
                local petName = spawnPoint:GetAttribute("PetName")
                local part = spawnPoint.PrimaryPart or spawnPoint:FindFirstChildWhichIsA("BasePart")
                if petName and part then
                    local espTag = ESPFolder:FindFirstChild("PetESP_" .. spawnPoint.Name)
                    if not espTag then
                        local bb = Instance.new("BillboardGui")
                        bb.Name = "PetESP_" .. spawnPoint.Name
                        bb.AlwaysOnTop = true
                        bb.Size = UDim2.fromOffset(130, 30)
                        bb.Adornee = part
                        local lbl = Instance.new("TextLabel")
                        lbl.Size = UDim2.fromScale(1, 1)
                        lbl.BackgroundTransparency = 1
                        lbl.TextColor3 = Color3.fromRGB(255, 175, 0)
                        lbl.TextStrokeTransparency = 0
                        lbl.TextSize = 13
                        lbl.Font = Enum.Font.SourceSansBold
                        lbl.Text = "[Pet] " .. tostring(petName)
                        lbl.Parent = bb
                        bb.Parent = ESPFolder
                    end
                end
            end
        end
    end

    if Config.ESPMutations then
        local gardens = Workspace:FindFirstChild("Gardens")
        if gardens then
            for i = 1, 8 do
                local plot = gardens:FindFirstChild("Plot" .. i)
                if plot and plot:FindFirstChild("Plants") then
                    for _, plant in ipairs(plot.Plants:GetChildren()) do
                        local mut = plant:GetAttribute("Mutation")
                        local part = plant.PrimaryPart or plant:FindFirstChildWhichIsA("BasePart") or plant:FindFirstChild("Stem")
                        if mut and mut ~= "None" and part then
                            local espTag = ESPFolder:FindFirstChild("MutationESP_" .. tostring(plant.Name))
                            if not espTag then
                                local bb = Instance.new("BillboardGui")
                                bb.Name = "MutationESP_" .. tostring(plant.Name)
                                bb.AlwaysOnTop = true
                                bb.Size = UDim2.fromOffset(150, 30)
                                bb.Adornee = part
                                local lbl = Instance.new("TextLabel")
                                lbl.Size = UDim2.fromScale(1, 1)
                                lbl.BackgroundTransparency = 1
                                lbl.TextColor3 = MutationColors[mut] or Color3.fromRGB(0, 255, 200)
                                lbl.TextStrokeTransparency = 0
                                lbl.TextSize = 13
                                lbl.Font = Enum.Font.SourceSansBold
                                lbl.Text = "[" .. tostring(mut) .. "] " .. tostring(plant.Name)
                                lbl.Parent = bb
                                bb.Parent = ESPFolder
                            end
                        end
                    end
                end
            end
        end
    end

    if Config.ESPPlots then
        local gardens = Workspace:FindFirstChild("Gardens")
        if gardens then
            for i = 1, 8 do
                local plot = gardens:FindFirstChild("Plot" .. i)
                local part = plot and (plot.PrimaryPart or plot:FindFirstChildWhichIsA("BasePart") or plot:FindFirstChild("Base"))
                if plot and part then
                    local ownerId = plot:GetAttribute("OwnerUserId") or 0
                    local isMine = ownerId == LocalPlayer.UserId
                    local espTag = ESPFolder:FindFirstChild("PlotESP_Plot" .. i)
                    if not espTag then
                        local bb = Instance.new("BillboardGui")
                        bb.Name = "PlotESP_Plot" .. i
                        bb.AlwaysOnTop = true
                        bb.Size = UDim2.fromOffset(130, 26)
                        bb.Adornee = part
                        local lbl = Instance.new("TextLabel")
                        lbl.Name = "PlotLabel"
                        lbl.Size = UDim2.fromScale(1, 1)
                        lbl.BackgroundTransparency = 1
                        lbl.TextColor3 = isMine and Color3.fromRGB(50, 255, 120) or Color3.fromRGB(200, 200, 200)
                        lbl.TextStrokeTransparency = 0
                        lbl.TextSize = 12
                        lbl.Font = Enum.Font.SourceSansBold
                        lbl.Text = "Plot " .. i .. (isMine and " (My Plot)" or (ownerId > 0 and " (Occupied)" or " (Empty)"))
                        lbl.Parent = bb
                        bb.Parent = ESPFolder
                    end
                end
            end
        end
    end
end)

VisualsTab:AddSection("Quick Teleports")

VisualsTab:AddButton({
    Title = "Seeds Shop",
    Description = "Teleports directly to Seed Shop",
    Callback = function()
        if Character and Character:FindFirstChild("HumanoidRootPart") then
            Character.HumanoidRootPart.CFrame = CFrame.new(45, 10, -120)
            Notify("Teleport", "Teleported to Seeds Shop!", 2, "solar/check-circle-bold")
        end
    end
})

VisualsTab:AddButton({
    Title = "Pet Shop",
    Description = "Teleports directly to Pet Shop",
    Callback = function()
        if Character and Character:FindFirstChild("HumanoidRootPart") then
            Character.HumanoidRootPart.CFrame = CFrame.new(120, 10, -45)
            Notify("Teleport", "Teleported to Pet Shop!", 2, "solar/check-circle-bold")
        end
    end
})

VisualsTab:AddButton({
    Title = "Sell NPC",
    Description = "Teleports directly to Sell NPC",
    Callback = function()
        if Character and Character:FindFirstChild("HumanoidRootPart") then
            Character.HumanoidRootPart.CFrame = CFrame.new(-80, 10, 60)
            Notify("Teleport", "Teleported to Sell NPC!", 2, "solar/check-circle-bold")
        end
    end
})

SettingsTab:AddSection("Performance & Utilities")

SettingsTab:AddToggle("FPSBooster", {
    Title = "FPS Booster",
    Default = Config.FPSBooster,
    Callback = function(val)
        Config.FPSBooster = val
        if val then
            Notify("Performance", "FPS Booster: Starting optimization...", 3, "solar/rocket-bold")
            Lighting.GlobalShadows = false
            Lighting.FogEnd = 9e9
            for _, item in ipairs(Lighting:GetChildren()) do
                if item:IsA("PostEffect") then
                    item.Enabled = false
                end
            end
        else
            Notify("Performance", "FPS Booster Disabled", 2, "solar/rocket-bold")
        end
    end
})

local antiAfkConnection
SettingsTab:AddToggle("AntiAFK", {
    Title = "Anti-AFK",
    Default = Config.AntiAFK,
    Callback = function(val)
        Config.AntiAFK = val
        if val then
            if not antiAfkConnection then
                antiAfkConnection = LocalPlayer.Idled:Connect(function()
                    if Config.AntiAFK then
                        if VirtualUser then
                            VirtualUser:CaptureController()
                            VirtualUser:ClickButton2(Vector2.new(0, 0))
                        elseif VirtualInputManager then
                            VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 1)
                            task.wait(0.1)
                            VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 1)
                        end
                    end
                end)
            end
            Notify("Settings", "Anti-AFK Enabled", 2, "solar/clock-circle-bold")
        else
            if antiAfkConnection then
                antiAfkConnection:Disconnect()
                antiAfkConnection = nil
            end
            Notify("Settings", "Anti-AFK Disabled", 2, "solar/clock-circle-bold")
        end
    end
})

SettingsTab:AddButton({
    Title = "Rejoin Server",
    Description = "Rejoins the current server instance",
    Callback = function()
        Notify("Server", "Rejoining server...", 2, "solar/shield-check-bold")
        pcall(function()
            TeleportService:Teleport(game.PlaceId, LocalPlayer)
        end)
    end
})

SettingsTab:AddButton({
    Title = "Server Hop",
    Description = "Searches for an available public server",
    Callback = function()
        Notify("Server", "Finding new server...", 2, "solar/shield-check-bold")
        pcall(function()
            local url = "https://games.roblox.com/v1/games/" .. tostring(game.PlaceId) .. "/servers/Public?sortOrder=Asc&limit=100"
            local response = game:HttpGet(url)
            local data = HttpService:JSONDecode(response)
            if data and data.data then
                for _, server in ipairs(data.data) do
                    if server.playing and server.maxPlayers and server.playing < server.maxPlayers and server.id ~= game.JobId then
                        TeleportService:TeleportToPlaceInstance(game.PlaceId, server.id, LocalPlayer)
                        break
                    end
                end
            end
        end)
    end
})

SettingsTab:AddSection("Discord Webhook Logger")

SettingsTab:AddToggle("EnableWebhook", {
    Title = "Enable Webhook",
    Default = Config.EnableWebhook,
    Callback = function(val)
        Config.EnableWebhook = val
    end
})

SettingsTab:AddInput("WebhookUrl", {
    Title = "Webhook URL",
    Default = Config.WebhookUrl,
    Placeholder = "https://discord.com/api/webhooks/...",
    Callback = function(val)
        Config.WebhookUrl = val
    end
})

SettingsTab:AddToggle("LogStolen", {
    Title = "Log Stolen Mutations",
    Default = Config.LogStolen,
    Callback = function(val)
        Config.LogStolen = val
    end
})

SettingsTab:AddToggle("LogPets", {
    Title = "Log Caught Pets",
    Default = Config.LogPets,
    Callback = function(val)
        Config.LogPets = val
    end
})

pcall(function()
    if Fluent.SaveManager then
        Fluent.SaveManager:SetLibrary(Fluent)
        Fluent.SaveManager:SetFolder("Cloudy/GrowAGarden")
        Fluent.SaveManager:BuildConfigSection(SettingsTab)
    end
    if Fluent.InterfaceManager then
        Fluent.InterfaceManager:SetLibrary(Fluent)
        Fluent.InterfaceManager:SetFolder("Cloudy/GrowAGarden")
        Fluent.InterfaceManager:BuildInterfaceSection(SettingsTab)
    end
end)

Window:SelectTab(1)

task.spawn(function()
    while true do
        task.wait(Config.SellInterval or 3)
        if Config.AutoSell then
            pcall(function()
                if Networking and Networking.NPCS and Networking.NPCS.SellAll then
                    Networking.NPCS.SellAll:Fire()
                elseif Networking and Networking.SellAll then
                    Networking.SellAll:Fire()
                end
            end)
        end
    end
end)

task.spawn(function()
    while true do
        task.wait(5)
        if Config.AutoDailyDeal then
            pcall(function()
                if Networking and Networking.NPCS and Networking.NPCS.UseDailyDealAll then
                    Networking.NPCS.UseDailyDealAll:Fire()
                elseif Networking and Networking.UseDailyDealAll then
                    Networking.UseDailyDealAll:Fire()
                end
            end)
        end
    end
end)

task.spawn(function()
    while true do
        task.wait(1)
        if Config.AutoHarvest then
            pcall(function()
                local myPlotObj = GetMyPlot()
                if myPlotObj and myPlotObj:FindFirstChild("Plants") then
                    for _, plant in ipairs(myPlotObj.Plants:GetChildren()) do
                        local isHarvestable = plant:GetAttribute("Harvestable") or plant:GetAttribute("IsReady")
                        if isHarvestable == true or (plant:GetAttribute("PlantStage") and plant:GetAttribute("PlantStage") >= 3) then
                            for _, desc in ipairs(plant:GetDescendants()) do
                                if desc:IsA("ProximityPrompt") then
                                    SafeFirePrompt(desc)
                                end
                            end
                        end
                    end
                end
            end)
        end
    end
end)

task.spawn(function()
    while true do
        task.wait(1.5)
        if Config.AutoWater then
            pcall(function()
                local myPlotObj = GetMyPlot()
                if myPlotObj and myPlotObj:FindFirstChild("Plants") then
                    for _, plant in ipairs(myPlotObj.Plants:GetChildren()) do
                        if plant:GetAttribute("Watered") == false then
                            for _, desc in ipairs(plant:GetDescendants()) do
                                if desc:IsA("ProximityPrompt") and (desc.ActionText:lower():find("water") or desc.ObjectText:lower():find("water")) then
                                    SafeFirePrompt(desc)
                                end
                            end
                            if Networking and Networking.WaterCrop then
                                Networking.WaterCrop:Fire(plant)
                            end
                        end
                    end
                end
            end)
        end
    end
end)

task.spawn(function()
    while true do
        task.wait(2)
        if Config.AutoPlant and Config.SelectedSeedToPlant then
            pcall(function()
                local myPlotObj = GetMyPlot()
                if myPlotObj then
                    local spots = myPlotObj:FindFirstChild("PlantSpots") or myPlotObj:FindFirstChild("Spots") or myPlotObj:FindFirstChild("Soil")
                    if spots then
                        for _, spot in ipairs(spots:GetChildren()) do
                            if spot:GetAttribute("Occupied") == false or not spot:FindFirstChildWhichIsA("Model") then
                                for _, desc in ipairs(spot:GetDescendants()) do
                                    if desc:IsA("ProximityPrompt") then
                                        SafeFirePrompt(desc)
                                    end
                                end
                                if Networking and Networking.PlantSeed then
                                    Networking.PlantSeed:Fire(spot, Config.SelectedSeedToPlant)
                                end
                            end
                        end
                    end
                end
            end)
        end
    end
end)

task.spawn(function()
    while true do
        task.wait(math.max(Config.StealSpeed or 1, 0.1))
        if Config.AutoSteal then
            pcall(function()
                local otherPlots = GetAllOtherPlots()
                for _, plot in ipairs(otherPlots) do
                    local ownerId = plot:GetAttribute("OwnerUserId")
                    local skipPlot = false

                    if Config.IgnoreFriends and IsFriend(ownerId) then
                        skipPlot = true
                    end

                    if not skipPlot and Config.OwnerProximityCheck and ownerId and ownerId > 0 then
                        for _, player in ipairs(Players:GetPlayers()) do
                            if player.UserId == ownerId and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                                local plotPos = plot:GetPivot().Position
                                if (player.Character.HumanoidRootPart.Position - plotPos).Magnitude < (Config.SafeDistance or 45) then
                                    skipPlot = true
                                    break
                                end
                            end
                        end
                    end

                    if not skipPlot and plot:FindFirstChild("Plants") then
                        for _, plant in ipairs(plot.Plants:GetChildren()) do
                            local mut = plant:GetAttribute("Mutation")
                            if mut and mut ~= "None" then
                                local shouldSteal = (mut == "Gold" and Config.Mutation_Gold)
                                    or (mut == "Rainbow" and Config.Mutation_Rainbow)
                                    or (mut == "Electric" and Config.Mutation_Electric)
                                    or (mut == "Frozen" and Config.Mutation_Frozen)
                                    or (mut == "Bloodlit" and Config.Mutation_Bloodlit)
                                    or (mut == "Chained" and Config.Mutation_Chained)
                                    or (mut == "Starstruck" and Config.Mutation_Starstruck)

                                if shouldSteal then
                                    if Config.HitAndRun and Character and Character:FindFirstChild("HumanoidRootPart") then
                                        local prevCFrame = Character.HumanoidRootPart.CFrame
                                        local plantPart = plant.PrimaryPart or plant:FindFirstChildWhichIsA("BasePart") or plant:FindFirstChild("Stem")
                                        if plantPart then
                                            Character.HumanoidRootPart.CFrame = plantPart.CFrame + Vector3.new(0, 3, 0)
                                            task.wait(0.08)
                                            for _, desc in ipairs(plant:GetDescendants()) do
                                                if desc:IsA("ProximityPrompt") then
                                                    SafeFirePrompt(desc)
                                                end
                                            end
                                            task.wait(0.08)
                                            Character.HumanoidRootPart.CFrame = prevCFrame
                                        end
                                    else
                                        for _, desc in ipairs(plant:GetDescendants()) do
                                            if desc:IsA("ProximityPrompt") then
                                                SafeFirePrompt(desc)
                                            end
                                        end
                                    end

                                    if Config.LogStolen then
                                        SendWebhook("Mutated Crop Stolen!", "Successfully stolen **" .. tostring(mut) .. " " .. tostring(plant.Name) .. "** from Plot owned by User ID " .. tostring(ownerId), MutationColors[mut] and tonumber(MutationColors[mut]:ToHex(), 16) or 16766720)
                                    end
                                end
                            end
                        end
                    end
                end
            end)
        end
    end
end)

task.spawn(function()
    while true do
        task.wait(math.max(Config.BuyInterval or 2, 0.5))
        if Config.AutoBuySeeds or Config.AutoBuyAllSeeds then
            pcall(function()
                if Config.AutoBuyAllSeeds then
                    for _, seed in ipairs(SeedList) do
                        if Networking and Networking.Shop and Networking.Shop.BuySeed then
                            Networking.Shop.BuySeed:Fire(seed, 100)
                        elseif Networking and Networking.BuySeed then
                            Networking.BuySeed:Fire(seed, 100)
                        end
                    end
                elseif Config.AutoBuySeeds and Config.SelectedSeedToBuy then
                    if Networking and Networking.Shop and Networking.Shop.BuySeed then
                        Networking.Shop.BuySeed:Fire(Config.SelectedSeedToBuy, 1)
                    elseif Networking and Networking.BuySeed then
                        Networking.BuySeed:Fire(Config.SelectedSeedToBuy, 1)
                    end
                end
            end)
        end
    end
end)

task.spawn(function()
    while true do
        task.wait(1.5)
        local map = Workspace:FindFirstChild("Map")
        local wildPets = map and map:FindFirstChild("WildPetSpawns")
        if wildPets then
            for _, spawnPoint in ipairs(wildPets:GetChildren()) do
                local petName = spawnPoint:GetAttribute("PetName")
                if petName then
                    local isWanted = false
                    for _, pInfo in ipairs(WildPetList) do
                        if pInfo.Pet == petName and Config[pInfo.Key] then
                            isWanted = true
                            break
                        end
                    end

                    if isWanted then
                        for _, desc in ipairs(spawnPoint:GetDescendants()) do
                            if desc:IsA("ProximityPrompt") then
                                SafeFirePrompt(desc)
                            end
                        end
                        if Config.LogPets then
                            SendWebhook("Wild Pet Caught!", "Successfully caught wild pet: **" .. tostring(petName) .. "**!", 65280)
                        end
                    end
                end
            end
        end
    end
end)

task.spawn(function()
    while true do
        task.wait(10)
        if Config.FPSBooster then
            pcall(function()
                Lighting.GlobalShadows = false
                Lighting.FogEnd = 9e9
                for _, item in ipairs(Lighting:GetChildren()) do
                    if item:IsA("PostEffect") then
                        item.Enabled = false
                    end
                end
            end)
        end
    end
end)

Notify("Cloudy", "Cloudy Grow a Garden successfully loaded!", 3, "lucide/cloud")
