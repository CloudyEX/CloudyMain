local Fluent
do
    local raw = game:HttpGet("https://raw.githubusercontent.com/CloudyEX/CloudyMain/refs/heads/main/UI.lua")
    if not raw:find("v%.TitleBar%s*=%s*e%(p%.TitleBar%)") then
        raw = raw:gsub("v%.Root%s*=%s*s%s*%(%s*\"Frame\"%s*,", "v.TitleBar = e(p.TitleBar) { Title = t.Title, SubTitle = t.SubTitle, Icon = t.TitleIcon, TopbarHeight = topbarHeight, Parent = nil }\n            v.Root = s(\"Frame\",")
        raw = raw:gsub("{%s*v%.AcrylicPaint%.Frame%s*,%s*v%.TabDisplay", "{v.AcrylicPaint.Frame, v.TitleBar.Frame, v.TabDisplay")
    end
    raw = raw:gsub("v%.TitleBar%.Frame%.InputBegan", "(v.TitleBar and v.TitleBar.Frame or v.TabDisplay or v.Root).InputBegan")
    Fluent = loadstring(raw)()
end

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local TeleportService = game:GetService("TeleportService")
local VirtualUser = game:GetService("VirtualUser")
local Workspace = game:GetService("Workspace")

local localPlayer = Players.LocalPlayer

local function getRemote(name)
    local folders = {
        ReplicatedStorage:FindFirstChild("GameEvents"),
        ReplicatedStorage:FindFirstChild("Events"),
        ReplicatedStorage:FindFirstChild("Remotes"),
        ReplicatedStorage:FindFirstChild("GameRemotes"),
        ReplicatedStorage
    }
    for _, folder in ipairs(folders) do
        if folder then
            local r = folder:FindFirstChild(name)
                   or folder:FindFirstChild(name .. "_RE")
                   or folder:FindFirstChild(name .. "Remote")
                   or folder:FindFirstChild(string.gsub(name, "_RE", ""))
            if r and (r:IsA("RemoteEvent") or r:IsA("RemoteFunction")) then
                return r
            end
        end
    end
    local ge = ReplicatedStorage:FindFirstChild("GameEvents")
    return ge and ge:FindFirstChild(name)
end

local function getCharacter()
    return localPlayer.Character or localPlayer.CharacterAdded:Wait()
end

local function getHumanoid()
    local char = getCharacter()
    return char and char:FindFirstChildOfClass("Humanoid")
end

local function getRootPart()
    local char = getCharacter()
    return char and char:FindFirstChild("HumanoidRootPart")
end

local function Notify(title, content, duration, icon)
    pcall(function()
        Fluent:Notify({
            Title = title or "Cloudy Hub",
            Content = content or "",
            Duration = duration or 3,
            Icon = icon or "solar/info-circle-bold"
        })
    end)
end

local function setClipboardSafe(text)
    pcall(function()
        if setclipboard then
            setclipboard(text)
        elseif toclipboard then
            toclipboard(text)
        end
    end)
end

local function normalizeStr(str)
    return string.lower(string.gsub(tostring(str or ""), "[%s%_%-%[%]%d%*xX]+", ""))
end

local function findToolSmart(targetName)
    local targetKey = normalizeStr(targetName)
    local char = getCharacter()
    local backpack = localPlayer:FindFirstChild("Backpack")

    if char then
        for _, item in ipairs(char:GetChildren()) do
            if item:IsA("Tool") then
                local itemKey = normalizeStr(item.Name)
                if itemKey == targetKey or string.find(itemKey, targetKey, 1, true) or string.find(targetKey, itemKey, 1, true) then
                    return item, true
                end
            end
        end
    end

    if backpack then
        for _, item in ipairs(backpack:GetChildren()) do
            if item:IsA("Tool") then
                local itemKey = normalizeStr(item.Name)
                if itemKey == targetKey or string.find(itemKey, targetKey, 1, true) or string.find(targetKey, itemKey, 1, true) then
                    return item, false
                end
            end
        end
    end

    return nil, false
end

local function equipTool(targetName)
    local char = getCharacter()
    if not char then return nil end
    local humanoid = getHumanoid()

    local tool, isEquipped = findToolSmart(targetName)
    if not tool then
        return nil
    end

    if isEquipped then
        return tool
    end

    pcall(function()
        if humanoid then
            humanoid:EquipTool(tool)
        else
            tool.Parent = char
        end
    end)

    task.wait(0.15)
    return tool
end

local seedList = {
    "Carrot", "Strawberry", "Blueberry", "Buttercup", "Tomato", "Corn",
    "Daffodil", "Orange Tulip", "Tulip", "Watermelon", "Pumpkin", "Apple",
    "Bamboo", "Coconut", "Cactus", "Dragon Fruit", "Mango", "Grape",
    "Mushroom", "Pepper", "Cacao", "Sunflower", "Beanstalk", "Ember Lily",
    "Sugar Apple", "Crimson Thorn", "Zebrazinkle", "Octobloom", "Alien Apple",
    "Eggsnapper", "Mandrake", "Olive", "Moon Blossom", "Candy Blossom",
    "Nectar Thorn", "Lotus", "Bone Blossom", "Golden Peach", "Pineapple",
    "Kiwi", "Starfruit", "Cherry Blossom", "Glowberry", "Nightshade",
    "Firefly Fern", "Frostcap", "Sunburst"
}

local defaultPlantPositions = {
    Vector3.new(7.8571605682373, 0.13552570343018, -87.393127441406),
    Vector3.new(11.219266891479, 0.13552665710449, -101.79133605957),
    Vector3.new(11.560945510864, 0.13552761077881, -112.53707885742),
    Vector3.new(13.584851264954, 0.13552761077881, -126.44728088379),
    Vector3.new(11.751163482666, 0.13552665710449, -141.24307250977),
    Vector3.new(10.345237731934, 0.13552665710449, -153.76657104492),
    Vector3.new(-42.770553588867, 0.13552761077881, -155.90672302246),
    Vector3.new(-39.547367095947, 0.13552761077881, -142.91548156738),
    Vector3.new(-39.134246826172, 0.13552665710449, -115.01598358154),
    Vector3.new(-45.840881347656, 0.13552665710449, -97.656661987305),
    Vector3.new(-41.398277282715, 0.13552761077881, -77.988845825195)
}

local defaultSprinklerPositions = {
    CFrame.new(8.3942251205444, 0.13552665710449, -155.31227111816, -0.72725117206573, 0.47651925683022, -0.49399915337563, 0, 0.71972572803497, 0.69425851106644, 0.68637150526047, 0.50490033626556, -0.52342134714127),
    CFrame.new(6.9497289657593, 0.13552665710449, -140.36685180664, -0.9610515832901, 0.18363271653652, -0.20654062926769, 0, 0.74733573198318, 0.66444677114487, 0.27636933326721, 0.63856762647629, -0.7182280421257),
    CFrame.new(7.8946342468262, 0.13552665710449, -127.27557373047, -0.97686350345612, 0.14103965461254, -0.16076567769051, -7.4505805969238e-09, 0.75171941518784, 0.65948307514191, 0.21386393904686, 0.6442249417305, -0.73432719707489),
    CFrame.new(7.4540514945984, 0.13552665710449, -112.03926849365, -0.90846419334412, -0.31201297044754, 0.27810209989548, 1.4901161193848e-08, 0.66537535190582, 0.74650901556015, -0.4179627597332, 0.67817670106888, -0.60446965694427),
    CFrame.new(9.8455181121826, 0.13552665710449, -96.387405395508, -0.90190064907074, -0.25321963429451, 0.34993597865105, 0, 0.81014263629913, 0.58623296022415, -0.43194371461868, 0.52872389554977, -0.73066806793213),
    CFrame.new(11.487975120544, 5.473578453064, -86.639358520508, -0.9047509431839, -0.31430864334106, 0.28746461868286, -1.4901161193848e-08, 0.67489296197891, 0.73791569471359, -0.42594110965729, 0.66762989759445, -0.6106099486351),
    CFrame.new(-42.687835693359, 0.13552665710449, -154.5539855957, -0.96156191825867, 0.17559729516506, -0.21110236644745, -1.4901159417491e-08, 0.76879644393921, 0.63949358463287, 0.27458807826042, 0.61491268873215, -0.73924547433853),
    CFrame.new(-41.90795135498, 0.13552665710449, -144.51066589355, -0.21204476058483, 0.88437914848328, -0.4158253967762, 0, 0.42550134658813, 0.90495789051056, 0.97725999355316, 0.19189158082008, -0.090225324034691),
    CFrame.new(-41.543315887451, 0.13552665710449, -126.38514709473, -0.98609209060669, -0.099116913974285, 0.13341075181961, 0, 0.80270999670029, 0.59636968374252, -0.16620045900345, 0.5880753993988, -0.79154580831528),
    CFrame.new(-43.281829833984, 0.13552570343018, -111.65612792969, -0.9560729265213, -0.15531522035599, 0.248599588871, 1.4901162970204e-08, 0.84808951616287, 0.52985292673111, -0.29312896728516, 0.50657802820206, -0.81083542108536),
    CFrame.new(-46.53844833374, 0.13552665710449, -97.026664733887, -0.98660600185394, -0.068783223628998, 0.14791069924831, -3.7252902984619e-09, 0.90675044059753, 0.42166796326637, -0.16312175989151, 0.416020154953, -0.89460527896881)
}

local sellPosition = CFrame.new(36.4154243, 2.99999976, -1.23027813, -0.14637351, -9.66091762e-10, -0.989229381, -2.06320632e-08, 1, 2.0762585e-09, 0.989229381, 2.07137525e-08, -0.14637351)

local sprinklerList = {
    "Basic Sprinkler", "Advanced Sprinkler", "Godly Sprinkler", "Master Sprinkler",
    "Grandmaster Sprinkler", "Tropical Mist Sprinkler", "Flower Froster Sprinkler",
    "Spice Spritzer Sprinkler", "Stalk Sprout Sprinkler", "Sweet Soaker Sprinkler",
    "Berry Blusher Sprinkler", "Honey Sprinkler"
}

local gearList = {
    "Watering Can", "Trowel", "Recall Wrench", "Trading Ticket", "Favorite Tool",
    "Harvest Tool", "Cleaning Spray", "Magnifying Glass", "Cleaning Pet Shard",
    "Lightning Rod", "Tanning Mirror", "Medium Toy", "Pet Name Reroller",
    "Pet Lead", "Medium Treat", "Small Treat", "Big Treat", "Friendship Pot",
    "Level Up Lollipop", "Rainbow Lollipop", "Pet Whistle", "Basic Sprinkler",
    "Advanced Sprinkler", "Godly Sprinkler", "Master Sprinkler", "Grandmaster Sprinkler",
    "Tropical Mist Sprinkler", "Flower Froster Sprinkler", "Spice Spritzer Sprinkler",
    "Stalk Sprout Sprinkler", "Sweet Soaker Sprinkler", "Berry Blusher Sprinkler", "Honey Sprinkler"
}

local eggList = {
    "Common Egg", "Uncommon Egg", "Rare Egg", "Legendary Egg", "Mythical Egg",
    "Bug Egg", "Jungle Egg", "Zen Egg", "Moon Egg", "Primal Egg", "Dinosaur Egg",
    "Gem Egg", "Ocean Egg", "Desert Egg", "Volcano Egg", "Cosmic Egg",
    "Enchanted Egg", "Ancient Egg", "Premium Bird Egg"
}

local plantPosition = nil
local selectedSeed = "Strawberry"
local plantMode = "Default"
local autoPlantEnabled = false
local autoPlantTask = nil

local sprinklerPosition = nil
local selectedSprinkler = "Basic Sprinkler"
local sprinklerMode = "Default"
local autoSprinklerEnabled = false
local autoSprinklerTask = nil

local autoSellInventoryEnabled = false
local autoSellInventoryTask = nil
local sellDelay = 5

local autoSellPetEnabled = false
local autoSellPetTask = nil
local sellPetDelay = 10

local buySeedSelected = {}
local autoBuySeedEnabled = false
local autoBuySeedTask = nil

local buyGearSelected = {}
local autoBuyGearEnabled = false
local autoBuyGearTask = nil

local buyEggSelected = {}
local autoBuyEggEnabled = false
local autoBuyEggTask = nil

local antiAFKEnabled = false
local antiAFKTask = nil
local autoReconnectEnabled = false

local fpsSettings = {
    lighting = {},
    terrain = {},
    qualityLevel = nil
}

local function getPlantTargetPositions()
    if plantMode == "Custom" and plantPosition then
        local list = {}
        for x = -2, 2 do
            for z = -2, 2 do
                table.insert(list, plantPosition + Vector3.new(x * 3.5, 0, z * 3.5))
            end
        end
        return list
    elseif plantMode == "Custom" then
        local root = getRootPart()
        if root then
            local list = {}
            for x = -2, 2 do
                for z = -2, 2 do
                    table.insert(list, root.Position + Vector3.new(x * 3.5, 0, z * 3.5))
                end
            end
            return list
        end
    end

    local root = getRootPart()
    if root then
        local list = {}
        local cp = root.Position
        for x = -2, 2 do
            for z = -2, 2 do
                table.insert(list, Vector3.new(cp.X + x * 3.5, cp.Y, cp.Z + z * 3.5))
            end
        end
        return list
    end

    return defaultPlantPositions
end

local function getSprinklerTargetPositions()
    if sprinklerMode == "Custom" and sprinklerPosition then
        return {sprinklerPosition}
    elseif sprinklerMode == "Custom" then
        local root = getRootPart()
        if root then return {root.CFrame} end
    end

    local root = getRootPart()
    if root then
        return {root.CFrame}
    end

    return defaultSprinklerPositions
end

local Window = Fluent:CreateWindow({
    Title = "Cloudy Hub",
    TitleIcon = "lucide/cloud",
    SubTitle = "Grow A Garden 1.0",
    TabWidth = 140,
    Size = UDim2.fromOffset(525, 320),
    Acrylic = false,
    Theme = "Cloudy",
    MinimizeKey = Enum.KeyCode.LeftControl,
    MinimizeIcon = "rbxassetid://109388426525855"
})

local Tabs = {
    General     = Window:AddTab({ Title = "General",     Icon = "solar/home-2-bold" }),
    Automation  = Window:AddTab({ Title = "Automation",  Icon = "solar/bolt-bold" }),
    AutoSell    = Window:AddTab({ Title = "Auto Sell",   Icon = "solar/dollar-bold" }),
    Shop        = Window:AddTab({ Title = "Shop",        Icon = "solar/cart-2-bold" }),
    Misc        = Window:AddTab({ Title = "Misc",        Icon = "solar/settings-minimalistic-bold" })
}

local GenInfoSection = Tabs.General:AddSection("Information & Community")
GenInfoSection:AddParagraph({
    Title = "Welcome To Cloudy Hub",
    Content = "Grow A Garden 1.0 Automation Script\nClean, Optimized & Native Fluent UI"
})
GenInfoSection:AddParagraph({
    Title = "Tips Penggunaan",
    Content = "• SCRIPT FREE TIDAK UNTUK DI PERJUAL BELIKAN\n• Tekan Left Control atau klik logo Cloudy untuk minimize UI.\n• Multi-select di tab Shop memungkinkan beli banyak item sekaligus tanpa klik berulang.\n• Auto Plant & Sprinkler otomatis mendeteksi tool di inventory dan posisi plot player."
})
GenInfoSection:AddButton({
    Title = "Copy Discord Invite Link",
    Description = "https://discord.gg/5Vby3xdjT",
    Callback = function()
        setClipboardSafe("https://discord.gg/5Vby3xdjT")
        Notify("DISCORD", "Link Discord berhasil disalin ke clipboard!", 3, "solar/copy-bold")
    end
})

local ProfileSection = Tabs.General:AddSection("Player Profile")
ProfileSection:AddParagraph({
    Title = "Account Details",
    Content = string.format("Display Name : %s\nUsername     : @%s\nUser ID      : %s\nAccount Age  : %d hari",
        tostring(localPlayer.DisplayName),
        tostring(localPlayer.Name),
        tostring(localPlayer.UserId),
        tonumber(localPlayer.AccountAge) or 0
    )
})
ProfileSection:AddButton({
    Title = "Copy User ID",
    Description = "Salin User ID ke clipboard",
    Callback = function()
        setClipboardSafe(tostring(localPlayer.UserId))
        Notify("COPIED", "User ID berhasil disalin!", 2, "solar/copy-bold")
    end
})

local PlantSection = Tabs.Automation:AddSection("Auto Plant Seeds")
PlantSection:AddButton({
    Title = "Set Plant Position",
    Description = "Set koordinat custom plant ke posisi player sekarang",
    Callback = function()
        local root = getRootPart()
        if root then
            plantPosition = root.Position
            Notify("PLANT POSITION", "Posisi tanam berhasil diset ke koordinat player!", 3, "solar/check-circle-bold")
        else
            Notify("ERROR", "Karakter belum termuat!", 3, "solar/danger-triangle-bold")
        end
    end
})
PlantSection:AddDropdown("PlantSeedDropdown", {
    Title = "Pilih Seed",
    Values = seedList,
    Default = "Strawberry",
    Callback = function(value)
        selectedSeed = value
        Notify("SEED UPDATED", "Seed aktif: " .. tostring(value), 2)
    end
})
PlantSection:AddDropdown("PlantModeDropdown", {
    Title = "Pilih Mode Plant",
    Values = {"Default", "Custom"},
    Default = "Default",
    Callback = function(value)
        plantMode = value
        Notify("MODE UPDATED", "Mode plant: " .. tostring(value), 2)
    end
})
local AutoPlantToggle
AutoPlantToggle = PlantSection:AddToggle("AutoPlantToggle", {
    Title = "Auto Plant ON/OFF",
    Description = "Otomatis equip seed & menanam di plot player",
    Default = false,
    Callback = function(enabled)
        autoPlantEnabled = enabled
        if autoPlantTask then
            task.cancel(autoPlantTask)
            autoPlantTask = nil
        end
        if enabled then
            local plantRemote = getRemote("Plant_RE") or getRemote("Plant")
            if not plantRemote then
                Notify("ERROR", "Remote Plant_RE tidak ditemukan!", 4, "solar/danger-triangle-bold")
                autoPlantEnabled = false
                if AutoPlantToggle then AutoPlantToggle:SetValue(false) end
                return
            end

            autoPlantTask = task.spawn(function()
                while autoPlantEnabled do
                    local equippedTool = equipTool(selectedSeed)
                    if not equippedTool then
                        Notify("INFO", "Seed " .. tostring(selectedSeed) .. " tidak ada di Backpack/Karakter!", 3, "solar/info-circle-bold")
                        task.wait(2)
                    else
                        local seedParam = equippedTool.Name
                        local positions = getPlantTargetPositions()

                        for _, pos in ipairs(positions) do
                            if not autoPlantEnabled then break end
                            pcall(function()
                                plantRemote:FireServer(pos, seedParam)
                            end)
                            pcall(function()
                                plantRemote:FireServer(pos, selectedSeed)
                            end)
                            task.wait(0.1)
                        end
                        task.wait(0.8)
                    end
                end
            end)
        end
    end
})

local SprinklerSection = Tabs.Automation:AddSection("Auto Sprinkler")
SprinklerSection:AddButton({
    Title = "Set Sprinkler Position",
    Description = "Set koordinat custom sprinkler ke posisi player sekarang",
    Callback = function()
        local root = getRootPart()
        if root then
            sprinklerPosition = root.CFrame
            Notify("SPRINKLER POSITION", "Posisi sprinkler berhasil diset ke koordinat player!", 3, "solar/check-circle-bold")
        else
            Notify("ERROR", "Karakter belum termuat!", 3, "solar/danger-triangle-bold")
        end
    end
})
SprinklerSection:AddDropdown("SprinklerSelectDropdown", {
    Title = "Pilih Sprinkler",
    Values = sprinklerList,
    Default = "Basic Sprinkler",
    Callback = function(value)
        selectedSprinkler = value
        Notify("SPRINKLER UPDATED", "Sprinkler aktif: " .. tostring(value), 2)
    end
})
SprinklerSection:AddDropdown("SprinklerModeDropdown", {
    Title = "Pilih Mode Sprinkler",
    Values = {"Default", "Custom"},
    Default = "Default",
    Callback = function(value)
        sprinklerMode = value
        Notify("MODE UPDATED", "Mode sprinkler: " .. tostring(value), 2)
    end
})
local AutoSprinklerToggle
AutoSprinklerToggle = SprinklerSection:AddToggle("AutoSprinklerToggle", {
    Title = "Auto Sprinkler ON/OFF",
    Description = "Otomatis equip sprinkler & menempatkan di plot player",
    Default = false,
    Callback = function(enabled)
        autoSprinklerEnabled = enabled
        if autoSprinklerTask then
            task.cancel(autoSprinklerTask)
            autoSprinklerTask = nil
        end
        if enabled then
            local sprinklerRemote = getRemote("PlaceSprinkler_RE") or getRemote("PlaceSprinkler")
            if not sprinklerRemote then
                Notify("ERROR", "Remote PlaceSprinkler_RE tidak ditemukan!", 4, "solar/danger-triangle-bold")
                autoSprinklerEnabled = false
                if AutoSprinklerToggle then AutoSprinklerToggle:SetValue(false) end
                return
            end

            autoSprinklerTask = task.spawn(function()
                while autoSprinklerEnabled do
                    local equippedTool = equipTool(selectedSprinkler)
                    if not equippedTool then
                        Notify("INFO", "Sprinkler " .. tostring(selectedSprinkler) .. " tidak ada di Backpack/Karakter!", 3, "solar/info-circle-bold")
                        task.wait(2)
                    else
                        local sprinklerParam = equippedTool.Name
                        local positions = getSprinklerTargetPositions()

                        for _, pos in ipairs(positions) do
                            if not autoSprinklerEnabled then break end
                            pcall(function()
                                sprinklerRemote:FireServer(pos, sprinklerParam)
                            end)
                            pcall(function()
                                sprinklerRemote:FireServer(pos, selectedSprinkler)
                            end)
                            task.wait(0.15)
                        end
                        task.wait(1.2)
                    end
                end
            end)
        end
    end
})

local SellInvSection = Tabs.AutoSell:AddSection("Auto Sell Inventory")
SellInvSection:AddSlider("SellInvDelaySlider", {
    Title = "Interval Jual Inventory",
    Description = "Jeda waktu antar teleport jual inventory",
    Min = 1,
    Max = 30,
    Default = 5,
    Rounding = 0,
    Callback = function(value)
        sellDelay = value
    end
})
SellInvSection:AddToggle("AutoSellInvToggle", {
    Title = "Auto Sell Inventory ON/OFF",
    Description = "Teleport jual inventory lalu otomatis kembali ke posisi kebun",
    Default = false,
    Callback = function(enabled)
        autoSellInventoryEnabled = enabled
        if autoSellInventoryTask then
            task.cancel(autoSellInventoryTask)
            autoSellInventoryTask = nil
        end
        if enabled then
            local sellRemote = getRemote("Sell_Inventory") or getRemote("SellInventory")
            autoSellInventoryTask = task.spawn(function()
                while autoSellInventoryEnabled do
                    pcall(function()
                        local root = getRootPart()
                        if root then
                            local prevCFrame = root.CFrame
                            root.CFrame = sellPosition
                            task.wait(0.7)
                            if sellRemote then
                                sellRemote:FireServer()
                            end
                            task.wait(0.4)
                            local curRoot = getRootPart()
                            if curRoot and prevCFrame then
                                curRoot.CFrame = prevCFrame
                            end
                        else
                            if sellRemote then
                                sellRemote:FireServer()
                            end
                        end
                    end)
                    task.wait(sellDelay)
                end
            end)
        end
    end
})

local SellPetSection = Tabs.AutoSell:AddSection("Auto Sell Pets")
SellPetSection:AddSlider("SellPetDelaySlider", {
    Title = "Interval Jual Pet",
    Description = "Jeda waktu antar eksekusi jual pet",
    Min = 2,
    Max = 60,
    Default = 10,
    Rounding = 0,
    Callback = function(value)
        sellPetDelay = value
    end
})
SellPetSection:AddToggle("AutoSellPetToggle", {
    Title = "Auto Sell Pet ON/OFF",
    Description = "Otomatis menjual seluruh pet sesuai interval",
    Default = false,
    Callback = function(enabled)
        autoSellPetEnabled = enabled
        if autoSellPetTask then
            task.cancel(autoSellPetTask)
            autoSellPetTask = nil
        end
        if enabled then
            local sellPetRemote = getRemote("SellAllPets_RE") or getRemote("SellAllPets")
            autoSellPetTask = task.spawn(function()
                while autoSellPetEnabled do
                    if sellPetRemote then
                        pcall(function()
                            sellPetRemote:FireServer()
                        end)
                    end
                    task.wait(sellPetDelay)
                end
            end)
        end
    end
})

local SeedShopSection = Tabs.Shop:AddSection("Seed Shop")
SeedShopSection:AddDropdown("MultiSeedDropdown", {
    Title = "Pilih Seed yang Ingin Dibeli",
    Values = seedList,
    Default = {},
    Multi = true,
    Callback = function(values)
        buySeedSelected = values or {}
    end
})
local AutoBuySeedToggle
AutoBuySeedToggle = SeedShopSection:AddToggle("AutoBuySeedToggle", {
    Title = "Auto Buy Seed ON/OFF",
    Description = "Otomatis membeli seluruh seed yang dicentang",
    Default = false,
    Callback = function(enabled)
        autoBuySeedEnabled = enabled
        if autoBuySeedTask then
            task.cancel(autoBuySeedTask)
            autoBuySeedTask = nil
        end
        if enabled then
            local buySeedRemote = getRemote("BuySeedStock") or getRemote("BuySeed")
            autoBuySeedTask = task.spawn(function()
                while autoBuySeedEnabled do
                    local count = 0
                    for seedName, isSelected in pairs(buySeedSelected) do
                        if isSelected and autoBuySeedEnabled and buySeedRemote then
                            count = count + 1
                            pcall(function()
                                buySeedRemote:FireServer("Shop", seedName)
                            end)
                            pcall(function()
                                buySeedRemote:FireServer(seedName)
                            end)
                            task.wait(0.1)
                        end
                    end
                    if count == 0 then
                        Notify("INFO", "Pilih minimal 1 seed di dropdown untuk auto buy!", 3, "solar/info-circle-bold")
                        task.wait(2)
                    else
                        task.wait(0.5)
                    end
                end
            end)
        end
    end
})

local GearShopSection = Tabs.Shop:AddSection("Gear Shop")
GearShopSection:AddDropdown("MultiGearDropdown", {
    Title = "Pilih Gear yang Ingin Dibeli",
    Values = gearList,
    Default = {},
    Multi = true,
    Callback = function(values)
        buyGearSelected = values or {}
    end
})
local AutoBuyGearToggle
AutoBuyGearToggle = GearShopSection:AddToggle("AutoBuyGearToggle", {
    Title = "Auto Buy Gear ON/OFF",
    Description = "Otomatis membeli seluruh gear yang dicentang",
    Default = false,
    Callback = function(enabled)
        autoBuyGearEnabled = enabled
        if autoBuyGearTask then
            task.cancel(autoBuyGearTask)
            autoBuyGearTask = nil
        end
        if enabled then
            local buyGearRemote = getRemote("BuyGearStock") or getRemote("BuyGear")
            autoBuyGearTask = task.spawn(function()
                while autoBuyGearEnabled do
                    local count = 0
                    for gearName, isSelected in pairs(buyGearSelected) do
                        if isSelected and autoBuyGearEnabled and buyGearRemote then
                            count = count + 1
                            pcall(function()
                                buyGearRemote:FireServer(gearName)
                            end)
                            task.wait(0.1)
                        end
                    end
                    if count == 0 then
                        Notify("INFO", "Pilih minimal 1 gear di dropdown untuk auto buy!", 3, "solar/info-circle-bold")
                        task.wait(2)
                    else
                        task.wait(0.5)
                    end
                end
            end)
        end
    end
})

local EggShopSection = Tabs.Shop:AddSection("Egg Shop")
EggShopSection:AddDropdown("MultiEggDropdown", {
    Title = "Pilih Egg yang Ingin Dibeli",
    Values = eggList,
    Default = {},
    Multi = true,
    Callback = function(values)
        buyEggSelected = values or {}
    end
})
local AutoBuyEggToggle
AutoBuyEggToggle = EggShopSection:AddToggle("AutoBuyEggToggle", {
    Title = "Auto Buy Egg ON/OFF",
    Description = "Otomatis membeli seluruh egg yang dicentang",
    Default = false,
    Callback = function(enabled)
        autoBuyEggEnabled = enabled
        if autoBuyEggTask then
            task.cancel(autoBuyEggTask)
            autoBuyEggTask = nil
        end
        if enabled then
            local buyEggRemote = getRemote("BuyPetEgg") or getRemote("BuyEgg")
            autoBuyEggTask = task.spawn(function()
                while autoBuyEggEnabled do
                    local count = 0
                    for eggName, isSelected in pairs(buyEggSelected) do
                        if isSelected and autoBuyEggEnabled and buyEggRemote then
                            count = count + 1
                            pcall(function()
                                buyEggRemote:FireServer(eggName)
                            end)
                            task.wait(0.1)
                        end
                    end
                    if count == 0 then
                        Notify("INFO", "Pilih minimal 1 egg di dropdown untuk auto buy!", 3, "solar/info-circle-bold")
                        task.wait(2)
                    else
                        task.wait(0.5)
                    end
                end
            end)
        end
    end
})

local FpsSection = Tabs.Misc:AddSection("FPS & Performance Booster")
FpsSection:AddToggle("FpsBoosterToggle", {
    Title = "FPS Booster ON/OFF",
    Description = "Optimasi rendering, lighting, dan efek air untuk performa maksimal",
    Default = false,
    Callback = function(enabled)
        local terrain = Workspace:FindFirstChild("Terrain")
        if enabled then
            fpsSettings.lighting = {
                GlobalShadows = Lighting.GlobalShadows,
                FogEnd = Lighting.FogEnd,
                Brightness = Lighting.Brightness,
                Ambient = Lighting.Ambient,
                EnvironmentDiffuseScale = Lighting.EnvironmentDiffuseScale,
                EnvironmentSpecularScale = Lighting.EnvironmentSpecularScale,
                ClockTime = Lighting.ClockTime
            }
            fpsSettings.qualityLevel = settings().Rendering.QualityLevel
            if terrain then
                fpsSettings.terrain = {
                    WaterWaveSize = terrain.WaterWaveSize,
                    WaterWaveSpeed = terrain.WaterWaveSpeed,
                    WaterReflectance = terrain.WaterReflectance,
                    WaterTransparency = terrain.WaterTransparency
                }
            end
            Lighting.GlobalShadows = false
            Lighting.FogEnd = 999999999
            Lighting.Brightness = 1
            Lighting.Ambient = Color3.fromRGB(80, 80, 80)
            Lighting.EnvironmentDiffuseScale = 0
            Lighting.EnvironmentSpecularScale = 0
            Lighting.ClockTime = 12
            settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
            if terrain then
                terrain.WaterWaveSize = 0
                terrain.WaterWaveSpeed = 0
                terrain.WaterReflectance = 0
                terrain.WaterTransparency = 1
            end
            pcall(function()
                for _, effect in pairs(Lighting:GetChildren()) do
                    if effect:IsA("PostEffect") then
                        effect.Enabled = false
                    end
                end
            end)
            Notify("FPS BOOSTER", "FPS Booster diaktifkan! Grafik dioptimasi secara maksimal.", 4, "solar/check-circle-bold")
        else
            if next(fpsSettings.lighting) then
                for key, value in pairs(fpsSettings.lighting) do
                    if Lighting[key] ~= nil then
                        Lighting[key] = value
                    end
                end
            end
            if fpsSettings.qualityLevel then
                settings().Rendering.QualityLevel = fpsSettings.qualityLevel
            end
            if terrain and next(fpsSettings.terrain) then
                for key, value in pairs(fpsSettings.terrain) do
                    if terrain[key] ~= nil then
                        terrain[key] = value
                    end
                end
            end
            Notify("FPS BOOSTER", "FPS Booster dimatikan. Grafik kembali normal!", 3, "solar/info-circle-bold")
        end
    end
})

local AfkSection = Tabs.Misc:AddSection("Anti AFK & Reconnect")
AfkSection:AddToggle("AntiAfkToggle", {
    Title = "Anti AFK ON/OFF",
    Description = "Mencegah idle kick setelah 20 menit tidak ada input",
    Default = false,
    Callback = function(enabled)
        antiAFKEnabled = enabled
        if antiAFKTask then
            task.cancel(antiAFKTask)
            antiAFKTask = nil
        end
        if enabled then
            antiAFKTask = task.spawn(function()
                while antiAFKEnabled do
                    pcall(function()
                        VirtualUser:CaptureController()
                        VirtualUser:ClickButton2(Vector2.new())
                    end)
                    task.wait(45)
                end
            end)
        end
    end
})
AfkSection:AddToggle("AutoReconnectToggle", {
    Title = "Auto Reconnect ON/OFF",
    Description = "Otomatis reconnect jika terjadi disconnect atau error kick",
    Default = false,
    Callback = function(enabled)
        autoReconnectEnabled = enabled
    end
})

task.spawn(function()
    while true do
        task.wait(0.5)
        if autoReconnectEnabled then
            pcall(function()
                local coreGui = game:GetService("CoreGui")
                local promptGui = coreGui:FindFirstChild("RobloxPromptGui")
                if promptGui then
                    local promptMessage = promptGui:FindFirstChild("promptMessage")
                    if promptMessage then
                        local textLabel = promptMessage:FindFirstChildWhichIsA("TextLabel")
                        if textLabel then
                            local text = string.lower(textLabel.Text or "")
                            if string.find(text, "disconnected") or string.find(text, "kicked") or string.find(text, "error") then
                                task.wait(1.5)
                                pcall(function()
                                    TeleportService:Teleport(game.PlaceId)
                                end)
                            end
                        end
                    end
                end
            end)
        end
    end
end)

task.defer(function()
    Window:SelectTab(1)
    Notify("Cloudy Hub", "Grow A Garden 1.0 Loaded Successfully!", 4, "solar/check-circle-bold")
end)
