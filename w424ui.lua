local W424 = {}
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local HttpService = game:GetService("HttpService")
local TextService = game:GetService("TextService")
local RunService = game:GetService("RunService")

local Config = {
    Name = "W424",
    DefaultVersion = "1.0",
    DefaultTheme = "Dark",
    CornerRadius = 10,
    ElementCorner = 6,
    SidebarWidth = 150,
    TopbarHeight = 40,
    MinWindowSize = Vector2.new(360, 240),
    Themes = {
        Dark = {
            Background = Color3.fromRGB(12, 12, 12),
            Sidebar = Color3.fromRGB(5, 5, 5),
            Accent = Color3.fromRGB(0, 140, 255),
            Text = Color3.fromRGB(240, 240, 245),
            SubText = Color3.fromRGB(120, 120, 130),
            Element = Color3.fromRGB(12, 12, 12),
            ElementHover = Color3.fromRGB(20, 20, 20),
            ToggleOn = Color3.fromRGB(0, 140, 255),
            ToggleOff = Color3.fromRGB(40, 40, 45),
            Border = Color3.fromRGB(30, 30, 35),
            Shadow = Color3.fromRGB(0, 0, 0),
            Overlay = Color3.fromRGB(0, 0, 0),
            Success = Color3.fromRGB(0, 140, 255)
        }
    }
}
Config.Themes.QuantumDark = Config.Themes.Dark
Config.Themes.W424Dark = Config.Themes.Dark

local LegacyIcons = {
    Custom = "rbxassetid://109818941157555",
    Home = "rbxassetid://7733960981",
    Settings = "rbxassetid://7734053495",
    User = "rbxassetid://7743875962",
    Eye = "rbxassetid://7733774602",
    EyeOff = "rbxassetid://7733774495",
    Shield = "rbxassetid://7734056608",
    ShieldCheck = "rbxassetid://7734056411",
    Search = "rbxassetid://7734052925",
    ChevronDown = "rbxassetid://7733717447",
    ChevronRight = "rbxassetid://7733717755",
    ChevronUp = "rbxassetid://7733919605",
    ChevronLeft = "rbxassetid://7733717651",
    X = "rbxassetid://7743878857",
    Minus = "rbxassetid://7734000129",
    Maximize = "rbxassetid://7733992982",
    Maximize2 = "rbxassetid://7733992901",
    Minimize = "rbxassetid://7733997941",
    Minimize2 = "rbxassetid://7733997870",
    Moon = "rbxassetid://7743870134",
    Sun = "rbxassetid://7734068495",
    Palette = "rbxassetid://7734021595",
    Sliders = "rbxassetid://7734058803",
    ToggleLeft = "rbxassetid://7734091286",
    ToggleRight = "rbxassetid://7743873539",
    Type = "rbxassetid://7743874740",
    MousePointer = "rbxassetid://7743870392",
    Layers = "rbxassetid://7743868936",
    Command = "rbxassetid://7733924046",
    Star = "rbxassetid://7734068321",
    Bell = "rbxassetid://7733911828",
    Folder = "rbxassetid://7733799185",
    Terminal = "rbxassetid://7743872929",
    Activity = "rbxassetid://7733655755",
    Target = "rbxassetid://7743872758",
    Anchor = "rbxassetid://7733911490",
    Compass = "rbxassetid://7733924216",
    Cpu = "rbxassetid://7733765045",
    Globe = "rbxassetid://7733954760",
    Hash = "rbxassetid://7733955906",
    Key = "rbxassetid://7733965118",
    Lock = "rbxassetid://7733992528",
    Unlock = "rbxassetid://7743875263",
    Move = "rbxassetid://7743870731",
    Power = "rbxassetid://7734042493",
    RefreshCw = "rbxassetid://7734051052",
    Trash = "rbxassetid://7743873871",
    Trash2 = "rbxassetid://7743873772",
    Wifi = "rbxassetid://7743878148",
    Wrench = "rbxassetid://7743878358",
    Check = "rbxassetid://7733715400",
    AlertCircle = "rbxassetid://7733911490",
    Info = "rbxassetid://7733960981",
    AlertTriangle = "rbxassetid://7733911490",
    ["bot"] = "rbxassetid://7733924046",
    ["fish"] = "rbxassetid://7733954760",
    ["droplets"] = "rbxassetid://7733924216",
    ["map-pin"] = "rbxassetid://7743872758",
    ["shopping-cart"] = "rbxassetid://7733799185",
    ["calendar"] = "rbxassetid://7733911828",
    ["settings"] = "rbxassetid://7734053495",
    ["repeat"] = "rbxassetid://7734051052",
    ["scroll"] = "rbxassetid://7743874740",
    ["check"] = "rbxassetid://7733715400",
    ["alert-triangle"] = "rbxassetid://7733911490",
    ["x"] = "rbxassetid://7743878857",
    ["refresh-cw"] = "rbxassetid://7734051052",
    ["user-x"] = "rbxassetid://7743875962",
    ["bar-chart-2"] = "rbxassetid://7734058803",
    ["smile"] = "rbxassetid://7743875962",
    ["sword"] = "rbxassetid://7743872758",
    ["gem"] = "rbxassetid://7734068321",
    ["sparkles"] = "rbxassetid://7734068321",
    ["egg"] = "rbxassetid://7733911828",
    ["heart"] = "rbxassetid://7734068321",
    ["cloud"] = "rbxassetid://7733954760",
    ["flame"] = "rbxassetid://7733911490",
    ["leaf"] = "rbxassetid://7733924216",
    ["candy"] = "rbxassetid://7733911828",
    ["rainbow"] = "rbxassetid://7734068321",
    ["code"] = "rbxassetid://7743872929",
    ["wand"] = "rbxassetid://7733965118",
    ["dna"] = "rbxassetid://7733765045",
    ["clover"] = "rbxassetid://7733924216",
    ["coins"] = "rbxassetid://7733954760",
    ["skull"] = "rbxassetid://7733911490",
    ["zap"] = "rbxassetid://7733765045",
    ["telescope"] = "rbxassetid://7733924216",
    ["cloud-lightning"] = "rbxassetid://7733911490",
    ["trending-up"] = "rbxassetid://7734058803",
    ["lock"] = "rbxassetid://7733992528",
    ["bug"] = "rbxassetid://7733924046",
    ["waves"] = "rbxassetid://7733954760",
    ["camera"] = "rbxassetid://7733774602",
    ["box"] = "rbxassetid://7733799185",
    ["layers"] = "rbxassetid://7743868936",
    ["clock"] = "rbxassetid://7733911828",
    ["rotate-ccw"] = "rbxassetid://7734051052",
    ["moon"] = "rbxassetid://7743870134",
    ["sun"] = "rbxassetid://7734068495",
    ["thumbs-up"] = "rbxassetid://7733715400",
    ["info"] = "rbxassetid://7733960981",
    ["user"] = "rbxassetid://7743875962",
    ["star"] = "rbxassetid://7734068321",
    ["target"] = "rbxassetid://7743872758",
    ["anchor"] = "rbxassetid://7733911490",
    ["shield"] = "rbxassetid://7734056608",
    ["cpu"] = "rbxassetid://7733765045",
    ["hash"] = "rbxassetid://7733955906",
    ["key"] = "rbxassetid://7733965118",
    ["move"] = "rbxassetid://7743870731",
    ["trash"] = "rbxassetid://7743873871",
    ["wifi"] = "rbxassetid://7743878148",
    ["wrench"] = "rbxassetid://7743878358",
    ["alert-circle"] = "rbxassetid://7733911490",
    ["shrub"] = "rbxassetid://7733924216",
    ["droplet"] = "rbxassetid://7733924216",
    ["plus"] = "rbxassetid://7734042493",
    ["eye"] = "rbxassetid://7733774602",
    ["eye-off"] = "rbxassetid://7733774495",
    ["shield-check"] = "rbxassetid://7734056411",
    ["toggle-left"] = "rbxassetid://7734091286",
    ["toggle-right"] = "rbxassetid://7743873539",
    ["mouse-pointer"] = "rbxassetid://7743870392",
    ["globe"] = "rbxassetid://7733954760",
    ["compass"] = "rbxassetid://7733924216",
    ["activity"] = "rbxassetid://7733655755",
    ["command"] = "rbxassetid://7733924046",
    ["terminal"] = "rbxassetid://7743872929",
    ["folder"] = "rbxassetid://7733799185",
    ["bell"] = "rbxassetid://7733911828",
    ["trash-2"] = "rbxassetid://7743873772",
    ["unlock"] = "rbxassetid://7743875263",
    ["minimize-2"] = "rbxassetid://7733997870",
    ["maximize-2"] = "rbxassetid://7733992901",
    ["chevron-left"] = "rbxassetid://7733717651",
    ["chevron-right"] = "rbxassetid://7733717755",
    ["chevron-up"] = "rbxassetid://7733919605",
    ["chevron-down"] = "rbxassetid://7733717447",
    ["search"] = "rbxassetid://7734052925",
    ["minus"] = "rbxassetid://7734000129",
    ["power"] = "rbxassetid://7734042493",
    ["atom"] = "rbxassetid://7733765045",
    ["refreshCw"] = "rbxassetid://7734051052",
    ["alertTriangle"] = "rbxassetid://7733911490",
    ["alertCircle"] = "rbxassetid://7733911490",
    ["barChart2"] = "rbxassetid://7734058803",
    ["userX"] = "rbxassetid://7743875962",
    ["mapPin"] = "rbxassetid://7743872758",
    ["shoppingCart"] = "rbxassetid://7733799185",
    ["rotateCcw"] = "rbxassetid://7734051052",
    ["cloudLightning"] = "rbxassetid://7733911490",
    ["trendingUp"] = "rbxassetid://7734058803",
}






local IconModule = {
    IconsType = "lucide",
    New = nil,
    IconThemeTag = nil,
    Icons = {},
}

local function FetchIconPack(url)
    local success, result = pcall(function()
        if typeof(game.HttpGet) == "function" then
            return game:HttpGet(url)
        elseif typeof(syn) == "table" and typeof(syn.request) == "function" then
            local response = syn.request({Url = url, Method = "GET"})
            return response and response.Body
        elseif typeof(http_request) == "function" then
            local response = http_request({Url = url, Method = "GET"})
            return response and response.Body
        else
            return HttpService:GetAsync(url)
        end
    end)
    if success and result and type(result) == "string" and result ~= "" then
        local ok, loaded = pcall(loadstring, result)
        if ok and type(loaded) == "function" then
            local ok2, pack = pcall(loaded)
            if ok2 and type(pack) == "table" then
                return pack
            end
        end
    end
    return nil
end

local function parseIconString(iconString)
    if type(iconString) == "string" then
        local splitIndex = iconString:find(":")
        if splitIndex then
            local iconType = iconString:sub(1, splitIndex - 1)
            local iconName = iconString:sub(splitIndex + 1)
            return iconType, iconName
        end
    end
    return nil, iconString
end

function IconModule.AddIcons(packName, iconsData)
    if type(packName) ~= "string" or type(iconsData) ~= "table" then
        warn("AddIcons: packName must be string, iconsData must be table")
        return
    end
    if not IconModule.Icons[packName] then
        IconModule.Icons[packName] = {
            Icons = {},
            Spritesheets = {},
        }
    end
    for iconName, iconValue in pairs(iconsData) do
        if type(iconValue) == "number" or (type(iconValue) == "string" and iconValue:match("^rbxassetid://")) then
            local imageId = iconValue
            if type(iconValue) == "number" then
                imageId = "rbxassetid://" .. tostring(iconValue)
            end
            IconModule.Icons[packName].Icons[iconName] = {
                Image = imageId,
                ImageRectSize = Vector2.new(0, 0),
                ImageRectPosition = Vector2.new(0, 0),
                Parts = nil,
            }
            IconModule.Icons[packName].Spritesheets[imageId] = imageId
        elseif type(iconValue) == "table" then
            if iconValue.Image and iconValue.ImageRectSize and iconValue.ImageRectPosition then
                local imageId = iconValue.Image
                if type(imageId) == "number" then
                    imageId = "rbxassetid://" .. tostring(imageId)
                end
                IconModule.Icons[packName].Icons[iconName] = {
                    Image = imageId,
                    ImageRectSize = iconValue.ImageRectSize,
                    ImageRectPosition = iconValue.ImageRectPosition,
                    Parts = iconValue.Parts,
                }
                if not IconModule.Icons[packName].Spritesheets[imageId] then
                    IconModule.Icons[packName].Spritesheets[imageId] = imageId
                end
            else
                warn("AddIcons: Invalid spritesheet data format for icon '" .. iconName .. "'")
            end
        else
            warn("AddIcons: Unsupported data type for icon '" .. iconName .. "': " .. type(iconValue))
        end
    end
end

function IconModule.SetIconsType(iconType)
    IconModule.IconsType = iconType
end

function IconModule.Icon(Icon, Type, DefaultFormat)
    DefaultFormat = DefaultFormat ~= false
    local iconType, iconName = parseIconString(Icon)
    local targetType = iconType or Type or IconModule.IconsType
    local targetName = iconName
    local iconSet = IconModule.Icons[targetType]

    if iconSet and iconSet.Icons and iconSet.Icons[targetName] then
        return {
            iconSet.Spritesheets[tostring(iconSet.Icons[targetName].Image)],
            iconSet.Icons[targetName],
        }
    elseif iconSet and iconSet[targetName] and type(iconSet[targetName]) == "string" and string.find(iconSet[targetName], "rbxassetid://") then
        if DefaultFormat then
            return {
                iconSet[targetName],
                { ImageRectSize = Vector2.new(0, 0), ImageRectPosition = Vector2.new(0, 0) },
            }
        else
            return iconSet[targetName]
        end
    end
    return nil
end

function IconModule.GetIcon(Icon, Type)
    return IconModule.Icon(Icon, Type, false)
end

function IconModule.Icon2(Icon, Type, DefaultFormat)
    return IconModule.Icon(Icon, Type, true)
end


local packUrls = {
    lucide = "https://raw.githubusercontent.com/Footagesus/Icons/refs/heads/main/lucide/dist/Icons.lua",
    solar = "https://raw.githubusercontent.com/Footagesus/Icons/refs/heads/main/solar/dist/Icons.lua",
    craft = "https://raw.githubusercontent.com/Footagesus/Icons/refs/heads/main/craft/dist/Icons.lua",
    geist = "https://raw.githubusercontent.com/Footagesus/Icons/refs/heads/main/geist/dist/Icons.lua",
    sfsymbols = "https://raw.githubusercontent.com/Footagesus/Icons/refs/heads/main/sfsymbols/dist/Icons.lua",
    gravity = "https://raw.githubusercontent.com/Footagesus/Icons/refs/heads/main/gravity/dist/Icons.lua",
}

for packName, url in pairs(packUrls) do
    local pack = FetchIconPack(url)
    if pack and type(pack) == "table" then
        IconModule.Icons[packName] = pack
    end
end



local function Create(className, properties)
    local instance = Instance.new(className)
    for prop, value in pairs(properties or {}) do
        if prop == "Image" and type(value) == "table" then
            instance.Image = value.Image
            if value.ImageRectSize then
                instance.ImageRectSize = value.ImageRectSize
            end
            if value.ImageRectOffset then
                instance.ImageRectOffset = value.ImageRectOffset
            end
        else
            instance[prop] = value
        end
    end
    return instance
end

local function Tween(instance, properties, duration, easingStyle, easingDirection)
    if not instance or not instance.Parent then return end
    local tween = TweenService:Create(instance, TweenInfo.new(
        duration or 0.25,
        easingStyle or Enum.EasingStyle.Quart,
        easingDirection or Enum.EasingDirection.Out
    ), properties)
    tween:Play()
    return tween
end

local function Round(number, precision)
    precision = precision or 2
    return math.round(number * 10^precision) / 10^precision
end

local function ConnectButton(btn, callback)
    local lastTrigger = 0
    local function SafeTrigger(...)
        local now = os.clock()
        if now - lastTrigger < 0.15 then return end
        lastTrigger = now
        callback(...)
    end
    if btn:IsA("GuiButton") then
        btn.MouseButton1Click:Connect(SafeTrigger)
    else
        btn.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                SafeTrigger(input)
            end
        end)
    end
end

local function GetIcon(name, iconType)
    if not name then return {Image = LegacyIcons.Info} end

    
    local iconData = IconModule.Icon2(name, iconType)
    if iconData then
        if type(iconData) == "string" then
            return {Image = iconData}
        else
            return {
                Image = iconData[1],
                ImageRectSize = iconData[2].ImageRectSize,
                ImageRectOffset = iconData[2].ImageRectPosition
            }
        end
    end

    
    if LegacyIcons[name] then 
        return {Image = LegacyIcons[name]} 
    end

    
    if type(name) == "string" and (name:sub(1, 13) == "rbxassetid://" or name:sub(1, 4) == "http") then
        return {Image = name}
    end

    return {Image = LegacyIcons.Info}
end

local function NormalizeOption(opt)
    if type(opt) == "table" then
        return opt.Title or opt.title or tostring(opt), opt.Icon or opt.icon
    end
    return tostring(opt), nil
end

local CurrentTheme = Config.Themes[Config.DefaultTheme]
local ThemeListeners = {}
local OpenDropdowns = {}
local DropdownConnections = {}
local CurrentDropdownState = {
    IsOpen = false,
    IsMulti = false,
    Selected = nil,
    Options = {},
    Callback = nil,
    Arrow = nil,
    Button = nil,
    Rebuild = nil,
    OptionButtons = {},
}

local DropdownPanel = nil
local DropdownOverlay = nil
local DropdownPanelTitle = nil
local DropdownPanelSearch = nil
local DropdownPanelScroll = nil
local ResizeHandle = nil
local ActiveColorModal = nil
local ActiveConfigManager = nil


local function ListenTheme(callback)
    table.insert(ThemeListeners, callback)
    pcall(callback, CurrentTheme)
end

function W424:SetTheme(themeName)
    local newTheme = type(themeName) == "table" and themeName or Config.Themes[themeName]
    if newTheme then
        CurrentTheme = newTheme
        for i = #ThemeListeners, 1, -1 do
            local cb = ThemeListeners[i]
            pcall(cb, CurrentTheme)
        end
    end
end

local function CloseAllDropdowns()
    if ActiveColorModal then
        ActiveColorModal.Visible = false
        ActiveColorModal = nil
    end
    if CurrentDropdownState and CurrentDropdownState.IsOpen then
        CurrentDropdownState.IsOpen = false
        if DropdownPanel then
            DropdownPanel.Visible = false
        end
        if CurrentDropdownState.Arrow then
            CurrentDropdownState.Arrow.Rotation = 0
        end
        if CurrentDropdownState.OptionButtons then
            for _, btn in ipairs(CurrentDropdownState.OptionButtons) do
                if btn and btn.Parent then btn:Destroy() end
            end
        end
        CurrentDropdownState.OptionButtons = {}
        CurrentDropdownState.Selected = nil
        CurrentDropdownState.Options = {}
        CurrentDropdownState.Callback = nil
        CurrentDropdownState.Arrow = nil
        CurrentDropdownState.Button = nil
        CurrentDropdownState.Rebuild = nil
    end

    if DropdownOverlay then
        DropdownOverlay.Visible = false
        DropdownOverlay.BackgroundTransparency = 1
    end
    if ResizeHandle then
        ResizeHandle.Visible = true
    end

    for _, data in ipairs(OpenDropdowns) do
        if data and data.Menu and data.Menu.Parent then
            data.Menu.Visible = false
            data.Menu.Size = UDim2.new(0, data.Menu.Size.X.Offset, 0, 0)
            if data.Arrow then
                data.Arrow.Rotation = 0
            end
            data.IsOpen = false
            if data.HeartbeatConn then
                pcall(function() data.HeartbeatConn:Disconnect() end)
                data.HeartbeatConn = nil
            end
        end
    end
end


local function RegisterDropdown(menu, arrow, btnRef)
    local data = {Menu = menu, Arrow = arrow, Button = btnRef, IsOpen = false, HeartbeatConn = nil}
    table.insert(OpenDropdowns, data)
    return data
end


local ConfigManager = {}
ConfigManager.__index = ConfigManager

function ConfigManager.new(windowName)
    local self = setmetatable({}, ConfigManager)
    self.WindowName = windowName or "W424"
    self.CleanWindow = tostring(self.WindowName):gsub("[^%w%-_]", "_")
    if self.CleanWindow == "" then self.CleanWindow = "W424" end

    self.Data = {}
    self.SavedConfigs = {}
    self.AutoSave = false
    self.AutoSaveInterval = 2
    self.Thread = nil
    self.Elements = {}
    self.SelectedConfig = nil
    self.InputConfigName = ""

    self:EnsureFolder()
    self.Path = self:GetAutoSavePath()
    self:LoadIndex()
    return self
end

function ConfigManager:EnsureFolder()
    if typeof(makefolder) == "function" and typeof(isfolder) == "function" then
        pcall(function()
            if not isfolder("W424_Configs") then
                makefolder("W424_Configs")
            end
            local sub = "W424_Configs/" .. self.CleanWindow
            if not isfolder(sub) then
                makefolder(sub)
            end
        end)
    end
end

function ConfigManager:GetFolder()
    if typeof(isfolder) == "function" then
        local sub = "W424_Configs/" .. self.CleanWindow
        if isfolder(sub) then
            return sub
        elseif isfolder("W424_Configs") then
            return "W424_Configs"
        end
    end
    return nil
end

function ConfigManager:GetAutoSavePath()
    local folder = self:GetFolder()
    if folder == "W424_Configs/" .. self.CleanWindow then
        return folder .. "/_default.json"
    elseif folder == "W424_Configs" then
        return "W424_Configs/" .. self.CleanWindow .. "_default.json"
    end
    return "W424_" .. self.CleanWindow .. "_default.json"
end

function ConfigManager:GetConfigFilePath(name)
    local clean = tostring(name or ""):gsub("[^%w%-_]", "_")
    if clean == "" then return nil end
    local folder = self:GetFolder()
    if folder == "W424_Configs/" .. self.CleanWindow then
        return folder .. "/" .. clean .. ".json"
    elseif folder == "W424_Configs" then
        return "W424_Configs/" .. self.CleanWindow .. "_" .. clean .. ".json"
    end
    return "W424_" .. self.CleanWindow .. "_" .. clean .. ".json"
end

function ConfigManager:GetIndexPath()
    local folder = self:GetFolder()
    if folder == "W424_Configs/" .. self.CleanWindow then
        return folder .. "/_index.json"
    elseif folder == "W424_Configs" then
        return "W424_Configs/" .. self.CleanWindow .. "_index.json"
    end
    return "W424_" .. self.CleanWindow .. "_index.json"
end

function ConfigManager:SaveIndex()
    if typeof(writefile) ~= "function" then return end
    self:EnsureFolder()
    local names = {}
    for n, _ in pairs(self.SavedConfigs) do
        if n and n ~= "" and not n:find("^_") then
            table.insert(names, n)
        end
    end
    table.sort(names)
    pcall(function()
        local content = HttpService:JSONEncode(names)
        writefile(self:GetIndexPath(), content)
    end)
end

function ConfigManager:LoadIndex()
    if typeof(readfile) ~= "function" then return end
    local ok, content = pcall(readfile, self:GetIndexPath())
    if not (ok and content and content ~= "") then
        local legacyPaths = {
            "W424_Configs/" .. self.CleanWindow .. "_index.json",
            "W424_Configs/_index.json",
            self.WindowName .. "_ConfigsIndex.json"
        }
        for _, lp in ipairs(legacyPaths) do
            ok, content = pcall(readfile, lp)
            if ok and content and content ~= "" then break end
        end
    end
    if ok and content and content ~= "" then
        local ok2, names = pcall(function()
            return HttpService:JSONDecode(content)
        end)
        if ok2 and type(names) == "table" then
            for _, n in ipairs(names) do
                if type(n) == "string" and n ~= "" and not n:find("^_") then
                    self.SavedConfigs[n] = true
                end
            end
        end
    end
end

function ConfigManager:CollectAllData()
    for key, elem in pairs(self.Elements) do
        if elem and elem.Get then
            local ok, val = pcall(elem.Get)
            if ok and val ~= nil then
                self.Data[key] = val
            end
        end
    end
    return self.Data
end

function ConfigManager:Load()
    if typeof(readfile) == "function" then
        local targetPath = self.Path or self:GetAutoSavePath()
        local ok, content = pcall(readfile, targetPath)
        if not (ok and content and content ~= "") then
            local legacyPaths = {
                "W424_Configs/" .. self.CleanWindow .. "_default.json",
                "W424_" .. self.CleanWindow .. "_default.json",
                self.WindowName .. "_W424Config.json"
            }
            for _, lp in ipairs(legacyPaths) do
                ok, content = pcall(readfile, lp)
                if ok and content and content ~= "" then break end
            end
        end
        if ok and content and content ~= "" then
            local ok2, data = pcall(function()
                return HttpService:JSONDecode(content)
            end)
            if ok2 and type(data) == "table" then
                self.Data = data
                for key, elem in pairs(self.Elements) do
                    if elem and elem.Set and self.Data[key] ~= nil then
                        pcall(function() elem.Set(self.Data[key]) end)
                    end
                end
                return true
            end
        end
    end
    return false
end

function ConfigManager:Save()
    self:CollectAllData()
    if typeof(writefile) == "function" then
        local ok, content = pcall(function()
            return HttpService:JSONEncode(self.Data)
        end)
        if ok and content then
            self:EnsureFolder()
            local targetPath = self.Path or self:GetAutoSavePath()
            pcall(writefile, targetPath, content)
        end
    end
end

function ConfigManager:StartAutoSave()
    if self.AutoSave then return end
    self.AutoSave = true
    self.Thread = task.spawn(function()
        while self.AutoSave do
            task.wait(self.AutoSaveInterval)
            self:Save()
        end
    end)
end

function ConfigManager:EnableAutoSave(interval)
    self.AutoSaveInterval = interval or 2
    self:StartAutoSave()
end

function ConfigManager:DisableAutoSave()
    self:StopAutoSave()
end

function ConfigManager:IsAutoSaving()
    return self.AutoSave
end

function ConfigManager:SaveNow()
    self:Save()
end

function ConfigManager:SetAutoSaveInterval(interval)
    self.AutoSaveInterval = interval or 2
    if self.AutoSave then
        self:StopAutoSave()
        self:StartAutoSave()
    end
end

function ConfigManager:StopAutoSave()
    self.AutoSave = false
    if self.Thread then
        pcall(function() task.cancel(self.Thread) end)
        self.Thread = nil
    end
end

function ConfigManager:Set(key, value)
    self.Data[key] = value
end

function ConfigManager:Get(key, defaultValue)
    if self.Data[key] ~= nil then
        return self.Data[key]
    end
    return defaultValue
end

function ConfigManager:BindElement(key, elementType, getValueFunc, setValueFunc)
    self.Elements[key] = {
        Type = elementType,
        Get = getValueFunc,
        Set = setValueFunc
    }
    local saved = self:Get(key)
    if saved ~= nil and setValueFunc then
        pcall(function() setValueFunc(saved) end)
    end
end

function ConfigManager:SaveNamedConfig(name)
    if typeof(writefile) ~= "function" then return false end
    name = tostring(name or ""):gsub("^%s*(.-)%s*$", "%1")
    if name == "" or name == "Select Config" or name == "No Configs Available" or name:find("^_") then
        return false
    end

    self:CollectAllData()
    self:EnsureFolder()
    local path = self:GetConfigFilePath(name)
    if not path then return false end

    local ok, content = pcall(function()
        return HttpService:JSONEncode(self.Data)
    end)
    if ok and content then
        local writeOk = pcall(writefile, path, content)
        if writeOk then
            self.SavedConfigs[name] = true
            self:SaveIndex()
            return true
        end
    end
    return false
end

function ConfigManager:LoadNamedConfig(name)
    if typeof(readfile) ~= "function" then return false end
    name = tostring(name or ""):gsub("^%s*(.-)%s*$", "%1")
    if name == "" or name == "Select Config" or name == "No Configs Available" then
        return false
    end

    local path = self:GetConfigFilePath(name)
    local ok, content
    if path then
        ok, content = pcall(readfile, path)
    end
    if not (ok and content and content ~= "") then
        local clean = name:gsub("[^%w%-_]", "_")
        local legacyPaths = {
            "W424_Configs/" .. self.CleanWindow .. "/" .. clean .. ".json",
            "W424_Configs/" .. self.CleanWindow .. "_" .. clean .. ".json",
            "W424_" .. self.CleanWindow .. "_" .. clean .. ".json",
            "W424_Configs/" .. clean .. ".json",
            self.WindowName .. "_" .. clean .. "_W424.json"
        }
        for _, lp in ipairs(legacyPaths) do
            ok, content = pcall(readfile, lp)
            if ok and content and content ~= "" then break end
        end
    end

    if ok and content and content ~= "" then
        local ok2, data = pcall(function()
            return HttpService:JSONDecode(content)
        end)
        if ok2 and type(data) == "table" then
            self.Data = data
            for key, elem in pairs(self.Elements) do
                if elem and elem.Set and self.Data[key] ~= nil then
                    pcall(function() elem.Set(self.Data[key]) end)
                end
            end
            return true
        end
    end
    return false
end

function ConfigManager:DeleteNamedConfig(name)
    name = tostring(name or ""):gsub("^%s*(.-)%s*$", "%1")
    if name == "" then return false end

    self.SavedConfigs[name] = nil
    self:SaveIndex()

    if typeof(delfile) == "function" then
        local clean = name:gsub("[^%w%-_]", "_")
        local path = self:GetConfigFilePath(name)
        if path then pcall(delfile, path) end
        local pathsToDelete = {
            "W424_Configs/" .. self.CleanWindow .. "/" .. clean .. ".json",
            "W424_Configs/" .. self.CleanWindow .. "_" .. clean .. ".json",
            "W424_" .. self.CleanWindow .. "_" .. clean .. ".json",
            "W424_Configs/" .. clean .. ".json",
            self.WindowName .. "_" .. clean .. "_W424.json"
        }
        for _, p in ipairs(pathsToDelete) do
            pcall(delfile, p)
        end
        return true
    end
    return true
end

function ConfigManager:GetAllConfigNames()
    self:LoadIndex()
    local uniqueNames = {}
    local fileToSavedName = {}

    for n, _ in pairs(self.SavedConfigs) do
        if n and n ~= "" and not n:find("^_") then
            uniqueNames[n] = true
            local clean = tostring(n):gsub("[^%w%-_]", "_")
            fileToSavedName[clean] = n
        end
    end

    if typeof(listfiles) == "function" then
        local subFolder = "W424_Configs/" .. self.CleanWindow
        if typeof(isfolder) == "function" and isfolder(subFolder) then
            local ok, files = pcall(listfiles, subFolder)
            if ok and type(files) == "table" then
                for _, file in ipairs(files) do
                    local filename = file:match("([^/\\]+)$") or file
                    if filename:sub(-5) == ".json" and not filename:find("^_") then
                        local cleanName = filename:sub(1, -6)
                        if cleanName ~= "" then
                            local origName = fileToSavedName[cleanName] or cleanName
                            uniqueNames[origName] = true
                        end
                    end
                end
            end
        elseif typeof(isfolder) == "function" and isfolder("W424_Configs") then
            local ok, files = pcall(listfiles, "W424_Configs")
            if ok and type(files) == "table" then
                local prefix = self.CleanWindow .. "_"
                for _, file in ipairs(files) do
                    local filename = file:match("([^/\\]+)$") or file
                    if filename:sub(-5) == ".json" and not filename:find("^_") then
                        if filename:sub(1, #prefix) == prefix then
                            local cleanName = filename:sub(#prefix + 1, -6)
                            if cleanName ~= "" and not cleanName:find("^_") then
                                local origName = fileToSavedName[cleanName] or cleanName
                                uniqueNames[origName] = true
                            end
                        end
                    end
                end
            end
        end
    end

    local result = {}
    for n, _ in pairs(uniqueNames) do
        table.insert(result, n)
    end
    table.sort(result)
    return result
end

function ConfigManager:BuildConfigSection(tab)
    local section = tab:CreateSection({Name = "Configuration", Icon = "Settings", Opened = true})

    section:CreateToggle({
        Name = "Auto Save Config",
        Default = self.AutoSave,
        Desc = "Automatically persist UI changes",
        Callback = function(state)
            if state then
                self:EnableAutoSave(2)
                W424:Notify({Title = "Auto Save", Content = "Auto save enabled (2s)", Duration = 3, Icon = "Check"})
            else
                self:DisableAutoSave()
                W424:Notify({Title = "Auto Save", Content = "Auto save disabled", Duration = 3, Icon = "X"})
            end
        end
    })

    local allConfigNames = self:GetAllConfigNames()
    local defaultVal = (#allConfigNames > 0 and allConfigNames[1]) or "Select Config"
    if self.SelectedConfig and self.SelectedConfig ~= "" then
        defaultVal = self.SelectedConfig
    end

    local configListDropdown
    configListDropdown = section:CreateDropdown({
        Name = "Config List",
        Options = allConfigNames,
        Default = defaultVal,
        Desc = "Select a saved configuration",
        Callback = function(val)
            if val and val ~= "Select Config" and val ~= "No Configs Available" and val ~= "" then
                self.SelectedConfig = val
            end
        end
    })

    local configInput
    configInput = section:CreateInput({
        Name = "Config Name",
        PlaceholderText = "Enter config name...",
        Desc = "Type custom name to save profile",
        Callback = function(val)
            self.InputConfigName = val
        end
    })

    section:CreateButtonRow({
        {
            Name = "Save",
            Callback = function()
                local typed = configInput and configInput:Get() or ""
                local nameToSave = (typed and typed ~= "") and typed or self.InputConfigName or self.SelectedConfig
                if nameToSave and nameToSave ~= "" and nameToSave ~= "Select Config" and nameToSave ~= "No Configs Available" then
                    nameToSave = nameToSave:gsub("^%s*(.-)%s*$", "%1")
                    local success = self:SaveNamedConfig(nameToSave)
                    if success then
                        self.SelectedConfig = nameToSave
                        local updatedList = self:GetAllConfigNames()
                        configListDropdown:Refresh(updatedList, nameToSave)
                        if configInput and configInput.Set then configInput:Set("") end
                        W424:Notify({Title = "Config Saved", Content = "Saved: " .. nameToSave, Duration = 3, Icon = "Check"})
                    else
                        W424:Notify({Title = "Error", Content = "Failed to write config file", Duration = 3, Icon = "AlertTriangle"})
                    end
                else
                    W424:Notify({Title = "Error", Content = "Please enter a config name to save", Duration = 3, Icon = "AlertTriangle"})
                end
            end
        },
        {
            Name = "Load",
            Callback = function()
                local typed = configInput and configInput:Get() or ""
                local nameToLoad = (self.SelectedConfig and self.SelectedConfig ~= "Select Config" and self.SelectedConfig ~= "No Configs Available" and self.SelectedConfig ~= "") and self.SelectedConfig or (typed ~= "" and typed)
                if nameToLoad and nameToLoad ~= "Select Config" and nameToLoad ~= "No Configs Available" and nameToLoad ~= "" then
                    local success = self:LoadNamedConfig(nameToLoad)
                    if success then
                        self.SelectedConfig = nameToLoad
                        configListDropdown:Refresh(self:GetAllConfigNames(), nameToLoad)
                        W424:Notify({Title = "Config Loaded", Content = "Loaded: " .. nameToLoad, Duration = 3, Icon = "Check"})
                    else
                        W424:Notify({Title = "Error", Content = "Failed to load config: " .. nameToLoad, Duration = 3, Icon = "AlertTriangle"})
                    end
                else
                    W424:Notify({Title = "Error", Content = "Please select a config to load", Duration = 3, Icon = "AlertTriangle"})
                end
            end
        },
        {
            Name = "Remove",
            Callback = function()
                if self.SelectedConfig and self.SelectedConfig ~= "Select Config" and self.SelectedConfig ~= "No Configs Available" and self.SelectedConfig ~= "" then
                    local nameToRemove = self.SelectedConfig
                    self:DeleteNamedConfig(nameToRemove)
                    self.SelectedConfig = nil
                    if configInput and configInput.Set then configInput:Set("") end
                    local updatedList = self:GetAllConfigNames()
                    local newDefault = (#updatedList > 0 and updatedList[1]) or "Select Config"
                    configListDropdown:Refresh(updatedList, newDefault)
                    W424:Notify({Title = "Config Removed", Content = "Removed: " .. nameToRemove, Duration = 3, Icon = "Trash"})
                else
                    W424:Notify({Title = "Error", Content = "Please select a config to remove", Duration = 3, Icon = "AlertTriangle"})
                end
            end
        },
        {
            Name = "Clear All",
            Callback = function()
                local allConfigs = self:GetAllConfigNames()
                for _, name in ipairs(allConfigs) do
                    self:DeleteNamedConfig(name)
                end
                self.SelectedConfig = nil
                if configInput and configInput.Set then configInput:Set("") end
                configListDropdown:Refresh({}, "Select Config")
                W424:Notify({Title = "Configs Cleared", Content = "All configs removed", Duration = 3, Icon = "Trash"})
            end
        }
    })
end

local NotifyScreen = nil
local NotifyLayout = nil
local ActiveNotifications = {}

local function InitNotify()
    if NotifyScreen then return end
    NotifyScreen = Create("ScreenGui", {
        Name = "W424Notify",
        Parent = game.CoreGui,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        ResetOnSpawn = false,
    })
    NotifyLayout = Create("Frame", {
        Parent = NotifyScreen,
        Size = UDim2.new(0, 280, 1, -20),
        Position = UDim2.new(1, -290, 0, 10),
        BackgroundTransparency = 1,
        ZIndex = 200,
    })
    Create("UIListLayout", {
        Parent = NotifyLayout,
        Padding = UDim.new(0, 6),
        HorizontalAlignment = Enum.HorizontalAlignment.Right,
        VerticalAlignment = Enum.VerticalAlignment.Top,
        SortOrder = Enum.SortOrder.LayoutOrder,
    })
end

function W424:Notify(data)
    data = data or {}
    local title = data.Title or "Notification"
    local content = data.Content or ""
    local duration = data.Duration or 3
    local icon = data.Icon or "Info"
    local iconId = GetIcon(icon)

    InitNotify()

    local notifFrame = Create("Frame", {
        Parent = NotifyLayout,
        Size = UDim2.new(0, 260, 0, 0),
        BackgroundColor3 = CurrentTheme.Background,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        LayoutOrder = #ActiveNotifications,
        ZIndex = 201,
    })
    Create("UICorner", {CornerRadius = UDim.new(0, 8), Parent = notifFrame})
    local IconImg = Create("ImageLabel", {
        Parent = notifFrame,
        Size = UDim2.new(0, 22, 0, 22),
        Position = UDim2.new(0, 6, 0, 6),
        BackgroundTransparency = 1,
        Image = iconId,
        ImageColor3 = CurrentTheme.Accent,
        ZIndex = 202,
    })

    local TitleLbl = Create("TextLabel", {
        Parent = notifFrame,
        Size = UDim2.new(1, -30, 0, 18),
        Position = UDim2.new(0, 28, 0, 6),
        BackgroundTransparency = 1,
        Text = title,
        TextColor3 = CurrentTheme.Text,
        TextSize = 11,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextWrapped = true,
        ZIndex = 202,
    })

    local ContentLbl = Create("TextLabel", {
        Parent = notifFrame,
        Size = UDim2.new(1, -30, 0, 0),
        Position = UDim2.new(0, 28, 0, 22),
        BackgroundTransparency = 1,
        Text = content,
        TextColor3 = CurrentTheme.SubText,
        TextSize = 11,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextWrapped = true,
        AutomaticSize = Enum.AutomaticSize.Y,
        ZIndex = 202,
    })

    table.insert(ActiveNotifications, notifFrame)

    task.wait()
    local contentHeight = math.max(38, 18 + ContentLbl.AbsoluteSize.Y + 6)
    notifFrame.Size = UDim2.new(0, 240, 0, contentHeight)

    task.delay(duration, function()
        notifFrame.Size = UDim2.new(0, 0, 0, contentHeight)
        task.wait(0.1)
        notifFrame:Destroy()
        for i, n in ipairs(ActiveNotifications) do
            if n == notifFrame then
                table.remove(ActiveNotifications, i)
                break
            end
        end
    end)
end

local FloatingIconScreen = nil
local FloatingIconBtn = nil
local FloatingConnections = {}
local MainWindowScreen = nil
local MainFrame = nil
local IsMinimized = false
local IsClosed = false

local function CreateFloatingIcon(customIcon)
    for _, conn in ipairs(FloatingConnections) do
        if conn then conn:Disconnect() end
    end
    FloatingConnections = {}

    if FloatingIconScreen then
        FloatingIconScreen:Destroy()
    end

    local iconToUse = customIcon and GetIcon(customIcon) or GetIcon("Custom")

    FloatingIconScreen = Create("ScreenGui", {
        Name = "W424FloatingIcon",
        Parent = game.CoreGui,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        ResetOnSpawn = false,
        Enabled = true
    })

    
    local Backdrop = Create("Frame", {
        Name = "Backdrop",
        Parent = FloatingIconScreen,
        Size = UDim2.new(0, 50, 0, 50),
        Position = UDim2.new(0, 14, 0.5, -25),
        BackgroundColor3 = Color3.fromRGB(0, 0, 0),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Active = true,
        ClipsDescendants = true,
        ZIndex = 1000
    })

    Create("UICorner", {
        CornerRadius = UDim.new(0, 12),
        Parent = Backdrop
    })

    local isCustomImage = customIcon ~= nil
    local Icon = Create("ImageLabel", {
        Name = "Icon",
        Parent = Backdrop,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(0, 44, 0, 44),
        BackgroundTransparency = 1,
        Image = iconToUse,
        ImageColor3 = isCustomImage and Color3.fromRGB(255, 255, 255) or CurrentTheme.Text,
        ScaleType = Enum.ScaleType.Fit,
        ZIndex = 1001
    })

    local mouseDownOnIcon = false
    local isDragging = false
    local dragStart = nil
    local startPos = nil
    local hasMoved = false
    local dragThreshold = 5

    local conn1 = Backdrop.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            mouseDownOnIcon = true
            isDragging = true
            hasMoved = false
            dragStart = input.Position
            startPos = Backdrop.Position
        end
    end)

    local conn2 = UserInputService.InputChanged:Connect(function(input)
        if isDragging and mouseDownOnIcon and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            if math.abs(delta.X) > dragThreshold or math.abs(delta.Y) > dragThreshold then
                hasMoved = true
            end
            if Backdrop and Backdrop.Parent then
                Backdrop.Position = UDim2.new(
                    startPos.X.Scale, startPos.X.Offset + delta.X,
                    startPos.Y.Scale, startPos.Y.Offset + delta.Y
                )
            end
        end
    end)

    local conn3 = UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            if mouseDownOnIcon and not hasMoved then
                CloseAllDropdowns()
                if IsClosed then
                    IsClosed = false
                    if MainWindowScreen then
                        MainWindowScreen.Enabled = true
                    end
                    if MainFrame then
                        MainFrame.Visible = true
                        MainFrame.Size = UDim2.new(0, 440, 0, 280)
                        MainFrame.Position = UDim2.new(0.5, -200, 0.5, -130)
                    end
                elseif IsMinimized then
                    IsMinimized = false
                    if MainFrame then
                        MainFrame.Visible = true
                    end
                else
                    CloseAllDropdowns()
                    IsMinimized = true
                    if MainFrame then
                        MainFrame.Visible = false
                    end
                end
            end
            mouseDownOnIcon = false
            isDragging = false
        end
    end)

    table.insert(FloatingConnections, conn1)
    table.insert(FloatingConnections, conn2)
    table.insert(FloatingConnections, conn3)

    ListenTheme(function(theme)
        if Backdrop and Backdrop.Parent then
            Backdrop.BackgroundColor3 = theme.Sidebar
            if not isCustomImage and Icon and Icon.Parent then
                Icon.ImageColor3 = theme.Text
            end
        end
    end)

    FloatingIconBtn = Backdrop
    return FloatingIconScreen
end

function W424:CreateWindow(data)
    data = data or {}
    local RegisteredFeatures = {}
    local RegisteredSections = {}
    local windowName = data.Name or data.Title or data.ScriptName or "W424"
    local windowIcon = data.Icon or data.TitleIcon or data.Logo or "saturn"
    local windowSubtitle = data.SubTitle or data.Subtitle or data.Game or "Fish It"
    local customVersion = data.Version or Config.DefaultVersion
    local discordLink = data.Discord or data.DiscordLink or "discord.gg/w424"
    local floatingIcon = data.FloatingIcon or nil
    local toggleKey = data.ToggleKey

    if MainWindowScreen then
        MainWindowScreen:Destroy()
    end

    CreateFloatingIcon(floatingIcon)

    MainWindowScreen = Create("ScreenGui", {
        Name = "W424UI",
        Parent = game.CoreGui,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        ResetOnSpawn = false,
        Enabled = true
    })

    MainFrame = Create("Frame", {
        Name = "Main",
        Parent = MainWindowScreen,
        Size = UDim2.new(0, 480, 0, 280),
        Position = UDim2.new(0.5, -240, 0.5, -140),
        AnchorPoint = Vector2.new(0, 0),
        BackgroundColor3 = CurrentTheme.Background,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        Active = true,
        ZIndex = 10
    })

    Create("UICorner", {
        CornerRadius = UDim.new(0, Config.CornerRadius),
        Parent = MainFrame
    })

    local Shadow = Create("ImageLabel", {
        Name = "Shadow",
        Parent = MainFrame,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(1, 50, 1, 50),
        BackgroundTransparency = 1,
        Image = "rbxassetid://10806158995",
        ImageColor3 = CurrentTheme.Shadow,
        ImageTransparency = 0.5,
        ZIndex = 0
    })

    local Topbar = Create("Frame", {
        Name = "Topbar",
        Parent = MainFrame,
        Size = UDim2.new(1, 0, 0, Config.TopbarHeight),
        BackgroundColor3 = CurrentTheme.Sidebar,
        BorderSizePixel = 0,
        Active = true,
        ZIndex = 20
    })

    Create("UICorner", {
        CornerRadius = UDim.new(0, Config.CornerRadius),
        Parent = Topbar
    })

    local TopbarFix = Create("Frame", {
        Name = "Fix",
        Parent = Topbar,
        Size = UDim2.new(1, 0, 0.5, 0),
        Position = UDim2.new(0, 0, 0.5, 0),
        BackgroundColor3 = CurrentTheme.Sidebar,
        BorderSizePixel = 0,
        ZIndex = 20
    })

    local TopAccentBar = Create("Frame", {
        Name = "TopAccentBar",
        Parent = Topbar,
        Size = UDim2.new(0, 36, 0, 3),
        Position = UDim2.new(0.5, -18, 0, 3),
        BackgroundColor3 = CurrentTheme.Accent,
        BorderSizePixel = 0,
        ZIndex = 22
    })
    Create("UICorner", {CornerRadius = UDim.new(1, 0), Parent = TopAccentBar})

    local TopbarLeft = Create("Frame", {
        Name = "TopbarLeft",
        Parent = Topbar,
        Size = UDim2.new(1, -210, 1, 0),
        Position = UDim2.new(0, 12, 0, 0),
        BackgroundTransparency = 1,
        ClipsDescendants = true,
        ZIndex = 21
    })

    local LeftLayout = Create("UIListLayout", {
        Parent = TopbarLeft,
        FillDirection = Enum.FillDirection.Horizontal,
        HorizontalAlignment = Enum.HorizontalAlignment.Left,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        Padding = UDim.new(0, 8),
        SortOrder = Enum.SortOrder.LayoutOrder
    })

    local TitleContainer = Create("Frame", {
        Name = "TitleContainer",
        Parent = TopbarLeft,
        Size = UDim2.new(0, 0, 1, 0),
        AutomaticSize = Enum.AutomaticSize.X,
        BackgroundTransparency = 1,
        LayoutOrder = 1,
        ZIndex = 22
    })

    local TitleLayout = Create("UIListLayout", {
        Parent = TitleContainer,
        FillDirection = Enum.FillDirection.Vertical,
        HorizontalAlignment = Enum.HorizontalAlignment.Left,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        Padding = UDim.new(0, -1),
        SortOrder = Enum.SortOrder.LayoutOrder
    })

    local Title = Create("TextLabel", {
        Name = "Title",
        Parent = TitleContainer,
        Size = UDim2.new(0, 0, 0, 16),
        AutomaticSize = Enum.AutomaticSize.X,
        BackgroundTransparency = 1,
        Text = windowName,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 13,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left,
        LayoutOrder = 1,
        ZIndex = 23
    })

    local TitleGradient = Create("UIGradient", {
        Name = "TitleGradient",
        Parent = Title,
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 160, 255)),
            ColorSequenceKeypoint.new(0.6, Color3.fromRGB(0, 100, 210)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 20, 35))
        }),
        Rotation = 0
    })

    local Version = Create("TextLabel", {
        Name = "Version",
        Parent = TitleContainer,
        Size = UDim2.new(0, 0, 0, 12),
        AutomaticSize = Enum.AutomaticSize.X,
        BackgroundTransparency = 1,
        Text = "v" .. customVersion,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 10,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left,
        LayoutOrder = 2,
        ZIndex = 23
    })

    local TitleIcon = Create("ImageLabel", {
        Name = "TitleIcon",
        Parent = TopbarLeft,
        Size = UDim2.new(0, 16, 0, 16),
        BackgroundTransparency = 1,
        Image = GetIcon(windowIcon),
        ImageColor3 = CurrentTheme.Accent,
        ScaleType = Enum.ScaleType.Fit,
        LayoutOrder = 2,
        ZIndex = 22
    })

    local Divider = Create("TextLabel", {
        Name = "Divider",
        Parent = TopbarLeft,
        Size = UDim2.new(0, 4, 0, 16),
        BackgroundTransparency = 1,
        Text = "|",
        TextColor3 = CurrentTheme.SubText,
        TextSize = 12,
        Font = Enum.Font.GothamBold,
        LayoutOrder = 3,
        ZIndex = 22
    })

    local SubTitle = Create("TextLabel", {
        Name = "SubTitle",
        Parent = TopbarLeft,
        Size = UDim2.new(0, 0, 0, 16),
        AutomaticSize = Enum.AutomaticSize.X,
        BackgroundTransparency = 1,
        Text = windowSubtitle,
        TextColor3 = CurrentTheme.Text,
        TextSize = 11,
        Font = Enum.Font.GothamMedium,
        LayoutOrder = 4,
        ZIndex = 22
    })

    local TopbarRight = Create("Frame", {
        Name = "TopbarRight",
        Parent = Topbar,
        Size = UDim2.new(0, 200, 1, 0),
        Position = UDim2.new(1, -208, 0, 0),
        BackgroundTransparency = 1,
        ZIndex = 21
    })

    local RightLayout = Create("UIListLayout", {
        Parent = TopbarRight,
        FillDirection = Enum.FillDirection.Horizontal,
        HorizontalAlignment = Enum.HorizontalAlignment.Right,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        Padding = UDim.new(0, 6),
        SortOrder = Enum.SortOrder.LayoutOrder
    })

    local DiscordBtn = Create("TextButton", {
        Name = "DiscordBtn",
        Parent = TopbarRight,
        Size = UDim2.new(0, 0, 0, 24),
        AutomaticSize = Enum.AutomaticSize.X,
        BackgroundTransparency = 1,
        Text = "",
        AutoButtonColor = false,
        LayoutOrder = 1,
        ZIndex = 22
    })

    local DiscordLayout = Create("UIListLayout", {
        Parent = DiscordBtn,
        FillDirection = Enum.FillDirection.Horizontal,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        Padding = UDim.new(0, 4),
        SortOrder = Enum.SortOrder.LayoutOrder
    })

    local DiscordIcon = Create("ImageLabel", {
        Parent = DiscordBtn,
        Size = UDim2.new(0, 14, 0, 14),
        BackgroundTransparency = 1,
        Image = GetIcon("discord"),
        ImageColor3 = CurrentTheme.SubText,
        LayoutOrder = 1,
        ZIndex = 23
    })

    local DiscordDivider = Create("TextLabel", {
        Parent = DiscordBtn,
        Size = UDim2.new(0, 4, 0, 14),
        BackgroundTransparency = 1,
        Text = "|",
        TextColor3 = CurrentTheme.SubText,
        TextSize = 11,
        Font = Enum.Font.Gotham,
        LayoutOrder = 2,
        ZIndex = 23
    })

    local DiscordText = Create("TextLabel", {
        Parent = DiscordBtn,
        Size = UDim2.new(0, 0, 0, 14),
        AutomaticSize = Enum.AutomaticSize.X,
        BackgroundTransparency = 1,
        Text = discordLink,
        TextColor3 = CurrentTheme.SubText,
        TextSize = 11,
        Font = Enum.Font.Gotham,
        LayoutOrder = 3,
        ZIndex = 23
    })

    DiscordBtn.MouseEnter:Connect(function()
        DiscordIcon.ImageColor3 = CurrentTheme.Accent
        DiscordText.TextColor3 = CurrentTheme.Text
    end)

    DiscordBtn.MouseLeave:Connect(function()
        DiscordIcon.ImageColor3 = CurrentTheme.SubText
        DiscordText.TextColor3 = CurrentTheme.SubText
    end)

    DiscordBtn.MouseButton1Click:Connect(function()
        if typeof(setclipboard) == "function" then
            setclipboard(discordLink)
        elseif typeof(toclipboard) == "function" then
            toclipboard(discordLink)
        elseif typeof(syn) == "table" and typeof(syn.write_clipboard) == "function" then
            syn.write_clipboard(discordLink)
        end
        W424:Notify({
            Title = "Discord Link",
            Content = "Copied " .. discordLink .. " to clipboard!",
            Duration = 3,
            Icon = "Check"
        })
    end)

    local ConfirmOverlay = Create("Frame", {
        Name = "ConfirmOverlay",
        Parent = MainFrame,
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundColor3 = CurrentTheme.Overlay,
        BackgroundTransparency = 0.4,
        BorderSizePixel = 0,
        Visible = false,
        ZIndex = 100
    })
    Create("UICorner", {CornerRadius = UDim.new(0, Config.CornerRadius), Parent = ConfirmOverlay})

    local ConfirmBox = Create("Frame", {
        Name = "ConfirmBox",
        Parent = ConfirmOverlay,
        Size = UDim2.new(0, 220, 0, 100),
        Position = UDim2.new(0.5, -110, 0.5, -50),
        BackgroundColor3 = CurrentTheme.Background,
        BorderSizePixel = 0,
        ZIndex = 101
    })
    Create("UICorner", {CornerRadius = UDim.new(0, 6), Parent = ConfirmBox})

    Create("TextLabel", {
        Parent = ConfirmBox,
        Size = UDim2.new(1, 0, 0, 36),
        Position = UDim2.new(0, 0, 0, 8),
        BackgroundTransparency = 1,
        Text = "Close W424?",
        TextColor3 = CurrentTheme.Text,
        TextSize = 11,
        Font = Enum.Font.GothamBold,
        ZIndex = 102
    })

    Create("TextLabel", {
        Parent = ConfirmBox,
        Size = UDim2.new(1, -20, 0, 30),
        Position = UDim2.new(0, 10, 0, 26),
        BackgroundTransparency = 1,
        Text = "You can reopen using the floating icon.",
        TextColor3 = CurrentTheme.SubText,
        TextSize = 11,
        Font = Enum.Font.Gotham,
        TextWrapped = true,
        ZIndex = 102
    })

    local ConfirmYes = Create("TextButton", {
        Parent = ConfirmBox,
        Size = UDim2.new(0, 80, 0, 26),
        Position = UDim2.new(0.5, 2, 1, -30),
        BackgroundColor3 = Color3.fromRGB(220, 60, 60),
        Text = "Close",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 11,
        Font = Enum.Font.GothamBold,
        ZIndex = 102
    })
    Create("UICorner", {CornerRadius = UDim.new(0, 4), Parent = ConfirmYes})

    local ConfirmNo = Create("TextButton", {
        Parent = ConfirmBox,
        Size = UDim2.new(0, 80, 0, 26),
        Position = UDim2.new(0.5, -82, 1, -30),
        BackgroundColor3 = CurrentTheme.Element,
        Text = "Cancel",
        TextColor3 = CurrentTheme.Text,
        TextSize = 11,
        Font = Enum.Font.GothamBold,
        ZIndex = 102
    })
    Create("UICorner", {CornerRadius = UDim.new(0, 4), Parent = ConfirmNo})

    local Controls = Create("Frame", {
        Name = "Controls",
        Parent = TopbarRight,
        Size = UDim2.new(0, 60, 0, Config.TopbarHeight),
        BackgroundTransparency = 1,
        LayoutOrder = 2,
        ZIndex = 22
    })

    local function MakeControl(name, icon, pos, callback)
        local btn = Create("ImageButton", {
            Name = name,
            Parent = Controls,
            Size = UDim2.new(0, 24, 0, 24),
            Position = pos,
            BackgroundTransparency = 1,
            AutoButtonColor = false,
            Image = GetIcon(icon),
            ImageColor3 = CurrentTheme.SubText,
            ZIndex = 23
        })
        Create("UICorner", {CornerRadius = UDim.new(0, 5), Parent = btn})
        btn.MouseEnter:Connect(function()
            btn.BackgroundColor3 = CurrentTheme.ElementHover
        end)
        btn.MouseLeave:Connect(function()
            btn.BackgroundColor3 = CurrentTheme.Element
        end)
        btn.MouseButton1Click:Connect(callback)
        return btn
    end

    MakeControl("Minimize", "Minus", UDim2.new(0, 4, 0.5, -12), function()
        CloseAllDropdowns()
        IsMinimized = true
        MainFrame.Visible = false
    end)

    MakeControl("Close", "X", UDim2.new(0, 32, 0.5, -12), function()
        CloseAllDropdowns()
        ConfirmOverlay.Visible = true
    end)

    ConfirmYes.MouseButton1Click:Connect(function()
        CloseAllDropdowns()
        IsClosed = true
        IsMinimized = false
        if MainWindowScreen then
            MainWindowScreen:Destroy()
            MainWindowScreen = nil
        end
        if FloatingIconScreen then
            FloatingIconScreen:Destroy()
            FloatingIconScreen = nil
        end
        if NotifyScreen then
            NotifyScreen:Destroy()
            NotifyScreen = nil
        end
        for _, conn in ipairs(FloatingConnections) do
            if conn then pcall(function() conn:Disconnect() end) end
        end
        FloatingConnections = {}
        for _, conn in ipairs(DropdownConnections) do
            if conn then pcall(function() conn:Disconnect() end) end
        end
        DropdownConnections = {}
    end)

    ConfirmNo.MouseButton1Click:Connect(function()
        ConfirmOverlay.Visible = false
    end)

    local Sidebar = Create("Frame", {
        Name = "Sidebar",
        Parent = MainFrame,
        Size = UDim2.new(0, Config.SidebarWidth, 1, -Config.TopbarHeight),
        Position = UDim2.new(0, 0, 0, Config.TopbarHeight),
        BackgroundColor3 = CurrentTheme.Sidebar,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        ZIndex = 15
    })
    Create("UICorner", {CornerRadius = UDim.new(0, Config.CornerRadius), Parent = Sidebar})

    Create("Frame", {
        Name = "Fix",
        Parent = Sidebar,
        Size = UDim2.new(1, 0, 0, 10),
        Position = UDim2.new(0, 0, 0, -10),
        BackgroundColor3 = CurrentTheme.Sidebar,
        BorderSizePixel = 0,
        ZIndex = 15
    })

    local SearchFrame = Create("Frame", {
        Parent = Sidebar,
        Size = UDim2.new(1, -10, 0, 32),
        Position = UDim2.new(0, 5, 0, 6),
        BackgroundColor3 = CurrentTheme.Element,
        BorderSizePixel = 0,
        ZIndex = 16
    })
    Create("UICorner", {CornerRadius = UDim.new(0, 5), Parent = SearchFrame})

    local SearchIcon = Create("ImageLabel", {
        Parent = SearchFrame,
        Size = UDim2.new(0, 14, 0, 14),
        Position = UDim2.new(0, 6, 0.5, -7),
        BackgroundTransparency = 1,
        Image = GetIcon("Search"),
        ImageColor3 = CurrentTheme.SubText,
        ZIndex = 17
    })

    local SearchBox = Create("TextBox", {
        Parent = SearchFrame,
        Size = UDim2.new(1, -24, 1, 0),
        Position = UDim2.new(0, 22, 0, 0),
        BackgroundTransparency = 1,
        Text = "",
        PlaceholderText = "Search features...",
        TextColor3 = CurrentTheme.Text,
        PlaceholderColor3 = CurrentTheme.SubText,
        TextSize = 12,
        Font = Enum.Font.Gotham,
        ClearTextOnFocus = false,
        ZIndex = 17
    })

    local TabList = Create("ScrollingFrame", {
        Name = "TabList",
        Parent = Sidebar,
        Size = UDim2.new(1, -10, 1, -44),
        Position = UDim2.new(0, 5, 0, 44),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 2,
        ScrollBarImageColor3 = CurrentTheme.Accent,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        ZIndex = 16
    })

    Create("UIListLayout", {
        Parent = TabList,
        Padding = UDim.new(0, 3),
        SortOrder = Enum.SortOrder.LayoutOrder
    })

    local Content = Create("Frame", {
        Name = "Content",
        Parent = MainFrame,
        Size = UDim2.new(1, -Config.SidebarWidth + 4, 1, -Config.TopbarHeight),
        Position = UDim2.new(0, Config.SidebarWidth - 4, 0, Config.TopbarHeight),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        ZIndex = 14
    })
    Create("UICorner", {CornerRadius = UDim.new(0, Config.CornerRadius), Parent = Content})

    Create("Frame", {
        Name = "Fix",
        Parent = Content,
        Size = UDim2.new(0, 14, 0, 14),
        Position = UDim2.new(0, -10, 0, 0),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ZIndex = 14
    })

    DropdownOverlay = Create("Frame", {
        Name = "DropdownOverlay",
        Parent = MainFrame,
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundColor3 = Color3.fromRGB(0, 0, 0),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Visible = false,
        ZIndex = 140,
        Active = true,
    })
    Create("UICorner", {CornerRadius = UDim.new(0, Config.CornerRadius), Parent = DropdownOverlay})

    DropdownPanel = Create("Frame", {
        Name = "DropdownPanel",
        Parent = MainFrame,
        Size = UDim2.new(0, 180, 1, -Config.TopbarHeight),
        Position = UDim2.new(1, -180, 0, Config.TopbarHeight),
        BackgroundColor3 = CurrentTheme.Background,
        BorderSizePixel = 0,
        Visible = false,
        ClipsDescendants = true,
        Active = true,
        ZIndex = 150,
    })
    Create("UICorner", {CornerRadius = UDim.new(0, Config.CornerRadius), Parent = DropdownPanel})
    Create("UIStroke", {Color = CurrentTheme.Border, Thickness = 1, Parent = DropdownPanel})

    local DropdownPanelHeader = Create("Frame", {
        Name = "Header",
        Parent = DropdownPanel,
        Size = UDim2.new(1, 0, 0, 36),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Active = true,
        ZIndex = 151,
    })

    DropdownPanelTitle = Create("TextLabel", {
        Parent = DropdownPanelHeader,
        Size = UDim2.new(1, -10, 0, 20),
        Position = UDim2.new(0, 8, 0, 8),
        BackgroundTransparency = 1,
        Text = "Select",
        TextColor3 = CurrentTheme.Text,
        TextSize = 12,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 152,
    })

    DropdownPanelSearch = Create("TextBox", {
        Parent = DropdownPanel,
        Size = UDim2.new(1, -10, 0, 28),
        Position = UDim2.new(0, 5, 0, 32),
        BackgroundColor3 = CurrentTheme.Element,
        Text = "",
        PlaceholderText = "Search...",
        TextColor3 = CurrentTheme.Text,
        PlaceholderColor3 = CurrentTheme.SubText,
        TextSize = 11,
        Font = Enum.Font.Gotham,
        ClearTextOnFocus = false,
        ZIndex = 152,
    })
    Create("UICorner", {CornerRadius = UDim.new(0, 4), Parent = DropdownPanelSearch})

    DropdownPanelScroll = Create("ScrollingFrame", {
        Parent = DropdownPanel,
        Size = UDim2.new(1, -10, 1, -72),
        Position = UDim2.new(0, 5, 0, 64),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 3,
        ScrollBarImageColor3 = CurrentTheme.Accent,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        Active = true,
        ZIndex = 153,
    })
    Create("UIListLayout", {
        Parent = DropdownPanelScroll,
        Padding = UDim.new(0, 3),
        SortOrder = Enum.SortOrder.LayoutOrder,
    })
    Create("UIPadding", {
        Parent = DropdownPanelScroll,
        PaddingBottom = UDim.new(0, 40)
    })

    ResizeHandle = Create("Frame", {
        Name = "ResizeHandle",
        Parent = MainFrame,
        Size = UDim2.new(0, 24, 0, 24),
        Position = UDim2.new(1, -22, 1, -22),
        BackgroundTransparency = 1,
        Active = true,
        ZIndex = 30
    })

    local GripPill = Create("Frame", {
        Name = "GripPill",
        Parent = ResizeHandle,
        Size = UDim2.new(0, 18, 0, 18),
        Position = UDim2.new(0.5, -9, 0.5, -9),
        BackgroundColor3 = Color3.fromRGB(18, 18, 22),
        BackgroundTransparency = 0.4,
        BorderSizePixel = 0,
        ZIndex = 31
    })
    Create("UICorner", {CornerRadius = UDim.new(0, 6), Parent = GripPill})
    local GripStroke = Create("UIStroke", {
        Color = CurrentTheme.Border,
        Thickness = 1,
        Transparency = 0.5,
        Parent = GripPill
    })

    local GripLine1 = Create("Frame", {
        Parent = GripPill,
        Size = UDim2.new(0, 9, 0, 2),
        Position = UDim2.new(1, -12, 1, -5),
        BackgroundColor3 = CurrentTheme.SubText,
        BorderSizePixel = 0,
        Rotation = -45,
        ZIndex = 32
    })
    Create("UICorner", {CornerRadius = UDim.new(1, 0), Parent = GripLine1})

    local GripLine2 = Create("Frame", {
        Parent = GripPill,
        Size = UDim2.new(0, 6, 0, 2),
        Position = UDim2.new(1, -8, 1, -5),
        BackgroundColor3 = CurrentTheme.SubText,
        BorderSizePixel = 0,
        Rotation = -45,
        ZIndex = 32
    })
    Create("UICorner", {CornerRadius = UDim.new(1, 0), Parent = GripLine2})

    local GripLine3 = Create("Frame", {
        Parent = GripPill,
        Size = UDim2.new(0, 3, 0, 2),
        Position = UDim2.new(1, -4, 1, -5),
        BackgroundColor3 = CurrentTheme.SubText,
        BorderSizePixel = 0,
        Rotation = -45,
        ZIndex = 32
    })
    Create("UICorner", {CornerRadius = UDim.new(1, 0), Parent = GripLine3})

    local ResizeLines = {GripLine1, GripLine2, GripLine3}

    local ResizeTrigger = Create("TextButton", {
        Name = "ResizeTrigger",
        Parent = ResizeHandle,
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Text = "",
        AutoButtonColor = false,
        Active = true,
        ZIndex = 33
    })

    local resizing = false
    local resizeStart = nil
    local startSize = nil

    ResizeTrigger.MouseEnter:Connect(function()
        Tween(GripPill, {BackgroundTransparency = 0.1, BackgroundColor3 = Color3.fromRGB(24, 24, 32)}, 0.15)
        Tween(GripStroke, {Color = CurrentTheme.Accent, Transparency = 0.2}, 0.15)
        for _, line in ipairs(ResizeLines) do
            Tween(line, {BackgroundColor3 = CurrentTheme.Accent}, 0.15)
        end
    end)

    ResizeTrigger.MouseLeave:Connect(function()
        if not resizing then
            Tween(GripPill, {BackgroundTransparency = 0.4, BackgroundColor3 = Color3.fromRGB(18, 18, 22)}, 0.15)
            Tween(GripStroke, {Color = CurrentTheme.Border, Transparency = 0.5}, 0.15)
            for _, line in ipairs(ResizeLines) do
                Tween(line, {BackgroundColor3 = CurrentTheme.SubText}, 0.15)
            end
        end
    end)

    ResizeTrigger.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            resizing = true
            resizeStart = input.Position
            startSize = MainFrame.Size
            Tween(GripPill, {BackgroundTransparency = 0, BackgroundColor3 = Color3.fromRGB(15, 25, 45)}, 0.1)
            Tween(GripStroke, {Color = CurrentTheme.Accent, Transparency = 0}, 0.1)
            for _, line in ipairs(ResizeLines) do
                Tween(line, {BackgroundColor3 = CurrentTheme.Accent}, 0.1)
            end
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if resizing and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - resizeStart
            local newWidth = math.max(Config.MinWindowSize.X, startSize.X.Offset + delta.X)
            local newHeight = math.max(Config.MinWindowSize.Y, startSize.Y.Offset + delta.Y)
            MainFrame.Size = UDim2.new(0, newWidth, 0, newHeight)
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            if resizing then
                resizing = false
                Tween(GripPill, {BackgroundTransparency = 0.4, BackgroundColor3 = Color3.fromRGB(18, 18, 22)}, 0.15)
                Tween(GripStroke, {Color = CurrentTheme.Border, Transparency = 0.5}, 0.15)
                for _, line in ipairs(ResizeLines) do
                    Tween(line, {BackgroundColor3 = CurrentTheme.SubText}, 0.15)
                end
            end
        end
    end)

    local dragging = false
    local dragStart = nil
    local startPos = nil

    Topbar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
            local changedConn
            changedConn = input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.Cancel then
                    dragging = false
                    changedConn:Disconnect()
                end
            end)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)

    if toggleKey then
        UserInputService.InputBegan:Connect(function(input, gpe)
            if not gpe and input.KeyCode == toggleKey then
                if MainFrame then
                    if MainFrame.Visible then
                        CloseAllDropdowns()
                    end
                    MainFrame.Visible = not MainFrame.Visible
                    IsMinimized = not MainFrame.Visible
                end
            end
        end)
    end

    DropdownOverlay.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            CloseAllDropdowns()
        end
    end)

    local clickConn = UserInputService.InputBegan:Connect(function(input, gpe)
        if not CurrentDropdownState or not CurrentDropdownState.IsOpen then return end
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            local clickPos = input.Position
            if clickPos then
                local mainPos = MainFrame.AbsolutePosition
                local mainSize = MainFrame.AbsoluteSize
                if clickPos.X < mainPos.X or clickPos.X > mainPos.X + mainSize.X or
                   clickPos.Y < mainPos.Y or clickPos.Y > mainPos.Y + mainSize.Y then
                    CloseAllDropdowns()
                end
            end
        end
    end)
    table.insert(DropdownConnections, clickConn)

    DropdownPanelSearch:GetPropertyChangedSignal("Text"):Connect(function()
        if CurrentDropdownState and CurrentDropdownState.IsOpen and CurrentDropdownState.Rebuild then
            CurrentDropdownState.Rebuild(DropdownPanelSearch.Text)
        end
    end)

    ListenTheme(function(theme)
        if not MainFrame or not MainFrame.Parent then return end
        MainFrame.BackgroundColor3 = theme.Background
        if Shadow and Shadow.Parent then Shadow.ImageColor3 = theme.Shadow end
        if Topbar and Topbar.Parent then Topbar.BackgroundColor3 = theme.Sidebar end
        if TopbarFix and TopbarFix.Parent then TopbarFix.BackgroundColor3 = theme.Sidebar end
        if TopAccentBar and TopAccentBar.Parent then TopAccentBar.BackgroundColor3 = theme.Accent end
        if Sidebar and Sidebar.Parent then Sidebar.BackgroundColor3 = theme.Sidebar end
        if Content and Content.Parent then Content.BackgroundColor3 = theme.Background end
        if TitleIcon and TitleIcon.Parent then TitleIcon.ImageColor3 = theme.Accent end
        if Divider and Divider.Parent then Divider.TextColor3 = theme.SubText end
        if SubTitle and SubTitle.Parent then SubTitle.TextColor3 = theme.Text end
        if DiscordIcon and DiscordIcon.Parent then DiscordIcon.ImageColor3 = theme.SubText end
        if DiscordDivider and DiscordDivider.Parent then DiscordDivider.TextColor3 = theme.SubText end
        if DiscordText and DiscordText.Parent then DiscordText.TextColor3 = theme.SubText end
        if TabList and TabList.Parent then TabList.ScrollBarImageColor3 = theme.Accent end
        if ConfirmOverlay and ConfirmOverlay.Parent then ConfirmOverlay.BackgroundColor3 = theme.Overlay end
        if ConfirmBox and ConfirmBox.Parent then ConfirmBox.BackgroundColor3 = theme.Background end
        if ConfirmNo and ConfirmNo.Parent then
            ConfirmNo.BackgroundColor3 = theme.Element
            ConfirmNo.TextColor3 = theme.Text
        end
        if GripPill and GripPill.Parent then GripPill.BackgroundColor3 = Color3.fromRGB(18, 18, 22) end
        if GripStroke and GripStroke.Parent then GripStroke.Color = theme.Border end
        if ResizeLines then
            for _, line in ipairs(ResizeLines) do
                if line and line.Parent then
                    line.BackgroundColor3 = theme.SubText
                end
            end
        end
        if SearchFrame and SearchFrame.Parent then SearchFrame.BackgroundColor3 = theme.Element end
        if SearchIcon and SearchIcon.Parent then SearchIcon.ImageColor3 = theme.SubText end
        if SearchBox and SearchBox.Parent then
            SearchBox.TextColor3 = theme.Text
            SearchBox.PlaceholderColor3 = theme.SubText
        end
        if DropdownPanel and DropdownPanel.Parent then DropdownPanel.BackgroundColor3 = theme.Background end
        if DropdownPanelTitle and DropdownPanelTitle.Parent then DropdownPanelTitle.TextColor3 = theme.Text end
        if DropdownPanelSearch and DropdownPanelSearch.Parent then
            DropdownPanelSearch.BackgroundColor3 = theme.Element
            DropdownPanelSearch.TextColor3 = theme.Text
            DropdownPanelSearch.PlaceholderColor3 = theme.SubText
        end
        if DropdownPanelScroll and DropdownPanelScroll.Parent then DropdownPanelScroll.ScrollBarImageColor3 = theme.Accent end
    end)

    local WindowAPI = {}
    WindowAPI.Notify = function(selfOrD, maybeD)
        local d
        if maybeD ~= nil then d = maybeD else d = selfOrD end
        W424:Notify(d)
    end
    WindowAPI.SetTitle = function(selfOrText, maybeText)
        local text
        if maybeText ~= nil then text = maybeText else text = selfOrText end
        windowName = text
        if Title and Title.Parent then Title.Text = tostring(text or "") end
    end
    WindowAPI.SetSubtitle = function(selfOrText, maybeText)
        local text
        if maybeText ~= nil then text = maybeText else text = selfOrText end
        windowSubtitle = text
        if SubTitle and SubTitle.Parent then SubTitle.Text = tostring(text or "") end
    end
    WindowAPI.SetVersion = function(selfOrVer, maybeVer)
        local ver
        if maybeVer ~= nil then ver = maybeVer else ver = selfOrVer end
        customVersion = ver
        if Version and Version.Parent then Version.Text = "v" .. tostring(ver or "") end
    end
    WindowAPI.SetIcon = function(selfOrIcon, maybeIcon)
        local icon
        if maybeIcon ~= nil then icon = maybeIcon else icon = selfOrIcon end
        windowIcon = icon
        if TitleIcon and TitleIcon.Parent then TitleIcon.Image = GetIcon(icon) end
    end
    WindowAPI.SetDiscord = function(selfOrLink, maybeLink)
        local link
        if maybeLink ~= nil then link = maybeLink else link = selfOrLink end
        discordLink = link
        if DiscordText and DiscordText.Parent then DiscordText.Text = tostring(link or "") end
    end
    WindowAPI.SetTheme = function(selfOrTheme, maybeTheme)
        local themeName
        if maybeTheme ~= nil then themeName = maybeTheme else themeName = selfOrTheme end
        W424:SetTheme(themeName)
    end
    ActiveConfigManager = ConfigManager.new(windowName)
    WindowAPI.Config = ActiveConfigManager
    ActiveConfigManager:Load()
    ActiveConfigManager:StartAutoSave()

    WindowAPI.EnableAutoSave = function(selfOrInterval, maybeInterval)
        local interval
        if maybeInterval ~= nil then interval = maybeInterval else interval = selfOrInterval end
        WindowAPI.Config:EnableAutoSave(interval)
    end
    WindowAPI.DisableAutoSave = function()
        WindowAPI.Config:DisableAutoSave()
    end
    WindowAPI.SaveConfig = function()
        WindowAPI.Config:SaveNow()
    end
    WindowAPI.LoadConfig = function()
        WindowAPI.Config:Load()
    end
    WindowAPI.SetConfigValue = function(selfOrKey, maybeKey, maybeValue)
        local key, value
        if maybeValue ~= nil then
            key = maybeKey
            value = maybeValue
        else
            key = selfOrKey
            value = maybeKey
        end
        WindowAPI.Config:Set(key, value)
    end
    WindowAPI.GetConfigValue = function(selfOrKey, maybeKey, maybeDefault)
        local key, defaultValue
        if maybeDefault ~= nil or (maybeKey ~= nil and type(selfOrKey) == "table") then
            key = maybeKey
            defaultValue = maybeDefault
        else
            key = selfOrKey
            defaultValue = maybeKey
        end
        return WindowAPI.Config:Get(key, defaultValue)
    end
    WindowAPI.BindConfigElement = function(selfOrKey, maybeKey, maybeType, maybeGet, maybeSet)
        if type(selfOrKey) == "table" and selfOrKey == WindowAPI then
            WindowAPI.Config:BindElement(maybeKey, maybeType, maybeGet, maybeSet)
        else
            WindowAPI.Config:BindElement(selfOrKey, maybeKey, maybeType, maybeGet)
        end
    end
    WindowAPI.SaveNamedConfig = function(selfOrName, maybeName)
        local name
        if maybeName ~= nil then name = maybeName else name = selfOrName end
        return WindowAPI.Config:SaveNamedConfig(name)
    end
    WindowAPI.LoadNamedConfig = function(selfOrName, maybeName)
        local name
        if maybeName ~= nil then name = maybeName else name = selfOrName end
        return WindowAPI.Config:LoadNamedConfig(name)
    end
    WindowAPI.DeleteNamedConfig = function(selfOrName, maybeName)
        local name
        if maybeName ~= nil then name = maybeName else name = selfOrName end
        return WindowAPI.Config:DeleteNamedConfig(name)
    end
    WindowAPI.GetConfigNames = function()
        return WindowAPI.Config:GetAllConfigNames()
    end

    local TabIndicator = Create("Frame", {
        Name = "TabIndicator",
        Parent = Sidebar,
        Size = UDim2.new(0, 3, 0, 22),
        Position = UDim2.new(0, 2, 0, 50),
        BackgroundColor3 = CurrentTheme.Accent,
        BorderSizePixel = 0,
        Visible = false,
        ZIndex = 20
    })
    Create("UICorner", {CornerRadius = UDim.new(1, 0), Parent = TabIndicator})

    local Tabs = {}
    local ActiveTab = nil
    local TabButtons = {}

    function WindowAPI:CreateTab(tabData)
        tabData = tabData or {}
        local tabName = tabData.Name or "Tab"
        local tabIcon = tabData.Icon or "Settings"

        local TabBtn = Create("TextButton", {
            Parent = TabList,
            Size = UDim2.new(1, -6, 0, 36),
            BackgroundTransparency = 1,
            Text = "",
            AutoButtonColor = false,
            LayoutOrder = #Tabs + 1,
            ZIndex = 17
        })
        Create("UICorner", {CornerRadius = UDim.new(0, 5), Parent = TabBtn})

        local TabBtnIcon = Create("ImageLabel", {
            Parent = TabBtn,
            Size = UDim2.new(0, 14, 0, 14),
            Position = UDim2.new(0, 8, 0.5, -7),
            BackgroundTransparency = 1,
            Image = GetIcon(tabIcon),
            ImageColor3 = CurrentTheme.SubText,
            ZIndex = 18
        })

        local TabBtnText = Create("TextLabel", {
            Parent = TabBtn,
            Size = UDim2.new(0, 110, 0, 28),
            Position = UDim2.new(0, 24, 0, 2),
            BackgroundTransparency = 1,
            Text = tabName,
            TextColor3 = CurrentTheme.SubText,
            TextSize = 12,
            Font = Enum.Font.Gotham,
            TextXAlignment = Enum.TextXAlignment.Left,
            ZIndex = 18
        })



        local TabContent = Create("ScrollingFrame", {
            Parent = Content,
            Size = UDim2.new(1, -14, 1, -14),
            Position = UDim2.new(0, 6, 0, 6),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ScrollBarThickness = 2,
            ScrollBarImageColor3 = CurrentTheme.Accent,
            CanvasSize = UDim2.new(0, 0, 0, 0),
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
            Visible = false,
            ZIndex = 15
        })

        Create("UIListLayout", {
            Parent = TabContent,
            Padding = UDim.new(0, 5),
            SortOrder = Enum.SortOrder.LayoutOrder
        })

        local function Activate(instant)
            CloseAllDropdowns()
            if ActiveTab then
                ActiveTab.Content.Visible = false
                ActiveTab.Button.BackgroundColor3 = CurrentTheme.Element
                Tween(ActiveTab.Icon, {ImageColor3 = CurrentTheme.SubText}, 0.2)
                Tween(ActiveTab.Label, {TextColor3 = CurrentTheme.SubText}, 0.2)
            end

            ActiveTab = {
                Button = TabBtn,
                Content = TabContent,
                Icon = TabBtnIcon,
                Label = TabBtnText
            }

            TabContent.Visible = true
            Tween(TabBtnIcon, {ImageColor3 = CurrentTheme.Accent}, 0.2)
            Tween(TabBtnText, {TextColor3 = CurrentTheme.Text}, 0.2)

            task.spawn(function()
                task.wait()
                if TabBtn and TabBtn.Parent and Sidebar and Sidebar.Parent then
                    TabIndicator.Visible = true
                    local targetY = TabBtn.AbsolutePosition.Y - Sidebar.AbsolutePosition.Y + (TabBtn.AbsoluteSize.Y - 22) / 2
                    local targetPos = UDim2.new(0, 2, 0, targetY)
                    if instant == true then
                        TabIndicator.Position = targetPos
                    else
                        Tween(TabIndicator, {Position = targetPos}, 0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
                    end
                end
            end)
        end

        TabBtn.MouseButton1Click:Connect(Activate)
        TabBtn.MouseEnter:Connect(function()
            if ActiveTab and ActiveTab.Button == TabBtn then return end
        end)
        TabBtn.MouseLeave:Connect(function()
            if ActiveTab and ActiveTab.Button == TabBtn then return end
        end)

        table.insert(Tabs, {Activate = Activate, Name = tabName, Button = TabBtn})
        table.insert(TabButtons, {Btn = TabBtn, Name = tabName:lower()})
        if #Tabs == 1 then Activate(true) end

        ListenTheme(function(theme)
            if not TabBtn or not TabBtn.Parent then return end
            if ActiveTab and ActiveTab.Button == TabBtn then
                if TabBtnIcon and TabBtnIcon.Parent then TabBtnIcon.ImageColor3 = theme.Accent end
                if TabBtnText and TabBtnText.Parent then TabBtnText.TextColor3 = theme.Text end
            else
                if TabBtnIcon and TabBtnIcon.Parent then TabBtnIcon.ImageColor3 = theme.SubText end
                if TabBtnText and TabBtnText.Parent then TabBtnText.TextColor3 = theme.SubText end
            end
            if TabContent and TabContent.Parent then TabContent.ScrollBarImageColor3 = theme.Accent end
        end)

        local TabAPI = {}
        TabAPI._CurrentSection = nil
        TabAPI._Sections = {}
        TabAPI._TabContent = TabContent

        function TabAPI:CreateSection(sectionData)
            sectionData = sectionData or {}
            local sectionName = sectionData.Name or "Section"
            local sectionIcon = sectionData.Icon or "Folder"
            local collapsed = sectionData.Collapsed or false
            local opened = sectionData.Opened
            if opened == nil then opened = not collapsed end
            if opened == false then collapsed = true end
            local isCollapsed = collapsed

            local SectionFrame = Create("Frame", {
                Parent = TabContent,
                Size = UDim2.new(1, 0, 0, 44),
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                ClipsDescendants = true,
                LayoutOrder = #TabContent:GetChildren(),
                ZIndex = 16
            })
            Create("UICorner", {CornerRadius = UDim.new(0, Config.ElementCorner), Parent = SectionFrame})

            local SectionHeader = Create("TextButton", {
                Parent = SectionFrame,
                Size = UDim2.new(1, 0, 0, 44),
                BackgroundTransparency = 1,
                Text = "",
                AutoButtonColor = false,
                ZIndex = 17
            })
            Create("UICorner", {CornerRadius = UDim.new(0, Config.ElementCorner), Parent = SectionHeader})

            Create("ImageLabel", {
                Parent = SectionHeader,
                Size = UDim2.new(0, 16, 0, 16),
                Position = UDim2.new(0, 10, 0.5, -8),
                BackgroundTransparency = 1,
                Image = GetIcon(sectionIcon),
                ImageColor3 = CurrentTheme.Accent,
                ZIndex = 18
            })

            Create("TextLabel", {
                Parent = SectionHeader,
                Size = UDim2.new(1, -60, 0, 20),
                Position = UDim2.new(0, 32, 0.5, -10),
                BackgroundTransparency = 1,
                Text = sectionName,
                TextColor3 = CurrentTheme.Text,
                TextSize = 11,
                Font = Enum.Font.GothamBold,
                TextXAlignment = Enum.TextXAlignment.Left,
                ZIndex = 18
            })

            local Arrow = Create("ImageLabel", {
                Parent = SectionHeader,
                Size = UDim2.new(0, 14, 0, 14),
                Position = UDim2.new(1, -30, 0.5, -6),
                BackgroundTransparency = 1,
                Image = GetIcon("ChevronDown"),
                ImageColor3 = CurrentTheme.SubText,
                ZIndex = 18
            })

            local SectionItems = Create("Frame", {
                Parent = SectionFrame,
                Size = UDim2.new(1, -12, 0, 0),
                Position = UDim2.new(0, 8, 0, 42),
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Visible = not isCollapsed,
                ClipsDescendants = false,
                ZIndex = 17
            })

            Create("UIListLayout", {
                Parent = SectionItems,
                Padding = UDim.new(0, 3),
                SortOrder = Enum.SortOrder.LayoutOrder
            })

            local targetHeight = 44
            local sectionDropdowns = {}
            local currentTween = nil
            local currentArrowTween = nil
            local animStepConn = nil

            local function UpdateSize(animate)
                local itemsHeight = SectionItems.UIListLayout.AbsoluteContentSize.Y
                targetHeight = 44 + itemsHeight + 4

                if currentTween then
                    pcall(function() currentTween:Cancel() end)
                    currentTween = nil
                end
                if currentArrowTween then
                    pcall(function() currentArrowTween:Cancel() end)
                    currentArrowTween = nil
                end
                if animStepConn then
                    pcall(function() animStepConn:Disconnect() end)
                    animStepConn = nil
                end

                if isCollapsed then
                    local targetSize = UDim2.new(1, 0, 0, 44)
                    if animate then
                        currentArrowTween = Tween(Arrow, {Rotation = 0}, 0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
                        currentTween = Tween(SectionFrame, {Size = targetSize}, 0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
                        
                        local startTime = os.clock()
                        animStepConn = RunService.Heartbeat:Connect(function()
                            if os.clock() - startTime > 0.28 or not SectionFrame.Parent then
                                if animStepConn then animStepConn:Disconnect() animStepConn = nil end
                                if isCollapsed then
                                    SectionItems.Visible = false
                                end
                                TabContent.CanvasSize = UDim2.new(0, 0, 0, TabContent.UIListLayout.AbsoluteContentSize.Y + 16)
                            else
                                TabContent.CanvasSize = UDim2.new(0, 0, 0, TabContent.UIListLayout.AbsoluteContentSize.Y + 16)
                            end
                        end)
                    else
                        Arrow.Rotation = 0
                        SectionFrame.Size = targetSize
                        SectionItems.Visible = false
                        TabContent.CanvasSize = UDim2.new(0, 0, 0, TabContent.UIListLayout.AbsoluteContentSize.Y + 16)
                    end

                    for _, dd in ipairs(sectionDropdowns) do
                        if dd and dd.Menu and dd.Menu.Parent then
                            dd.Menu.Visible = false
                            dd.Menu.Size = UDim2.new(0, dd.Menu.Size.X.Offset, 0, 0)
                            if dd.Arrow then dd.Arrow.Rotation = 0 end
                            dd.IsOpen = false
                            if dd.HeartbeatConn then
                                pcall(function() dd.HeartbeatConn:Disconnect() end)
                                dd.HeartbeatConn = nil
                            end
                        end
                    end
                else
                    SectionItems.Visible = true
                    local targetSize = UDim2.new(1, 0, 0, targetHeight)
                    SectionItems.Size = UDim2.new(1, -12, 0, itemsHeight + 4)

                    if animate then
                        currentArrowTween = Tween(Arrow, {Rotation = 180}, 0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
                        currentTween = Tween(SectionFrame, {Size = targetSize}, 0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)

                        local startTime = os.clock()
                        animStepConn = RunService.Heartbeat:Connect(function()
                            if os.clock() - startTime > 0.28 or not SectionFrame.Parent then
                                if animStepConn then animStepConn:Disconnect() animStepConn = nil end
                                TabContent.CanvasSize = UDim2.new(0, 0, 0, TabContent.UIListLayout.AbsoluteContentSize.Y + 16)
                            else
                                TabContent.CanvasSize = UDim2.new(0, 0, 0, TabContent.UIListLayout.AbsoluteContentSize.Y + 16)
                            end
                        end)
                    else
                        Arrow.Rotation = 180
                        SectionFrame.Size = targetSize
                        TabContent.CanvasSize = UDim2.new(0, 0, 0, TabContent.UIListLayout.AbsoluteContentSize.Y + 16)
                    end
                end
            end

            SectionItems.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                if not isCollapsed then
                    UpdateSize(false)
                end
            end)

            ConnectButton(SectionHeader, function()
                isCollapsed = not isCollapsed
                UpdateSize(true)
            end)

            SectionHeader.MouseEnter:Connect(function()
                Tween(SectionHeader, {BackgroundTransparency = 0.88, BackgroundColor3 = CurrentTheme.ElementHover}, 0.15)
                Tween(Arrow, {ImageColor3 = CurrentTheme.Accent}, 0.15)
            end)
            SectionHeader.MouseLeave:Connect(function()
                Tween(SectionHeader, {BackgroundTransparency = 1}, 0.15)
                Tween(Arrow, {ImageColor3 = CurrentTheme.SubText}, 0.15)
            end)

            if not collapsed then
                Arrow.Rotation = 180
                task.wait(0.05)
                UpdateSize(false)
            end

            table.insert(RegisteredSections, {
                Frame = SectionFrame,
                Header = SectionHeader,
                Items = SectionItems,
                Name = sectionName,
                Expand = function()
                    if isCollapsed then
                        isCollapsed = false
                        UpdateSize(true)
                    end
                end,
                Collapse = function()
                    if not isCollapsed then
                        isCollapsed = true
                        UpdateSize(true)
                    end
                end,
                UpdateSize = function() UpdateSize(false) end
            })

            ListenTheme(function(theme)
                Arrow.ImageColor3 = theme.SubText
            end)

            SectionItems.ChildAdded:Connect(function()
                task.wait(0.05)
                if not isCollapsed then
                    UpdateSize(false)
                end
            end)

            local SectionAPI = {}
            SectionAPI._SectionItems = SectionItems
            SectionAPI._SectionDropdowns = sectionDropdowns
            SectionAPI._UpdateSize = UpdateSize

            function SectionAPI:CreateToggle(toggleData)
                toggleData = toggleData or {}
                local toggleName = toggleData.Name or "Toggle"
                local toggleIcon = toggleData.Icon or "ToggleLeft"
                local default = toggleData.Default or false
                local callback = toggleData.Callback or function() end
                local desc = toggleData.Desc

                local hasDesc = desc and desc ~= ""
                local frameHeight = hasDesc and 42 or 30

                local ToggleFrame = Create("Frame", {
                    Parent = SectionItems,
                    Size = UDim2.new(1, 0, 0, frameHeight),
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    LayoutOrder = #SectionItems:GetChildren(),
                    ClipsDescendants = true,
                    ZIndex = 18
                })
                Create("UICorner", {CornerRadius = UDim.new(0, 5), Parent = ToggleFrame})

                Create("ImageLabel", {
                    Parent = ToggleFrame,
                    Size = UDim2.new(0, 14, 0, 14),
                    Position = UDim2.new(0, 7, 0, hasDesc and 5 or 7),
                    BackgroundTransparency = 1,
                    Image = GetIcon(toggleIcon),
                    ImageColor3 = CurrentTheme.SubText,
                    ZIndex = 19
                })

                Create("TextLabel", {
                    Parent = ToggleFrame,
                    Size = UDim2.new(0, 150, 0, 14),
                    Position = UDim2.new(0, 22, 0, hasDesc and 1 or 4),
                    BackgroundTransparency = 1,
                    Text = toggleName,
                    TextColor3 = CurrentTheme.Text,
                    TextSize = 11,
                    Font = Enum.Font.Gotham,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    ZIndex = 19
                })

                if hasDesc then
                    Create("TextLabel", {
                        Parent = ToggleFrame,
                        Size = UDim2.new(1, -60, 0, 10),
                        Position = UDim2.new(0, 22, 0, 13),
                        BackgroundTransparency = 1,
                        Text = desc,
                        TextColor3 = CurrentTheme.SubText,
                        TextSize = 11,
                        Font = Enum.Font.Gotham,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        TextWrapped = true,
                        AutomaticSize = Enum.AutomaticSize.Y,
                        ZIndex = 19
                    })
                end

                local ToggleBtn = Create("Frame", {
                    Parent = ToggleFrame,
                    Size = UDim2.new(0, 40, 0, 22),
                    Position = UDim2.new(1, -56, 0.5, -11),
                    BackgroundColor3 = CurrentTheme.ToggleOff,
                    BorderSizePixel = 0,
                    ZIndex = 19
                })
                Create("UICorner", {CornerRadius = UDim.new(1, 0), Parent = ToggleBtn})

                local ToggleCircle = Create("Frame", {
                    Parent = ToggleBtn,
                    Size = UDim2.new(0, 16, 0, 16),
                    Position = UDim2.new(0, 3, 0.5, -8),
                    BackgroundColor3 = CurrentTheme.Text,
                    BorderSizePixel = 0,
                    ZIndex = 20
                })
                Create("UICorner", {CornerRadius = UDim.new(1, 0), Parent = ToggleCircle})

                local ToggleClick = Create("TextButton", {
                    Parent = ToggleFrame,
                    Size = UDim2.new(1, 0, 1, 0),
                    BackgroundTransparency = 1,
                    Text = "",
                    ZIndex = 25
                })

                local state = default
                local flag = toggleData.Flag or toggleData.Name or "Toggle"
                local configKey = sectionName .. "/" .. flag

                local function UpdateToggleVisual(animate)
                    local targetPos = state and UDim2.new(0, 21, 0.5, -8) or UDim2.new(0, 3, 0.5, -8)
                    local targetBg = state and CurrentTheme.ToggleOn or CurrentTheme.ToggleOff
                    if animate then
                        Tween(ToggleCircle, {Position = targetPos}, 0.18, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
                        Tween(ToggleBtn, {BackgroundColor3 = targetBg}, 0.18, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
                    else
                        ToggleCircle.Position = targetPos
                        ToggleBtn.BackgroundColor3 = targetBg
                    end
                end

                UpdateToggleVisual(false)

                if ActiveConfigManager then
                    ActiveConfigManager:BindElement(configKey, "Toggle", function()
                        return state
                    end, function(val)
                        if val ~= nil and val ~= state then
                            state = val
                            UpdateToggleVisual(true)
                            callback(state)
                        end
                    end)
                end

                ConnectButton(ToggleClick, function()
                    state = not state
                    UpdateToggleVisual(true)
                    if ActiveConfigManager then
                        ActiveConfigManager:Set(configKey, state)
                    end
                    callback(state)
                end)

                ListenTheme(function(theme)
                    ToggleFrame.BackgroundColor3 = theme.Background
                    ToggleCircle.BackgroundColor3 = theme.Text
                    UpdateToggleVisual(false)
                end)

                table.insert(RegisteredFeatures, {
                    Name = toggleName,
                    Desc = desc,
                    Frame = ToggleFrame,
                    Section = SectionFrame,
                    SectionItems = SectionItems
                })

                local API = {
                    Set = function(selfOrVal, maybeVal)
                        local val
                        if maybeVal ~= nil then val = maybeVal else val = selfOrVal end
                        state = not not val
                        UpdateToggleVisual(true)
                        if ActiveConfigManager then
                            ActiveConfigManager:Set(configKey, state)
                        end
                        callback(state)
                    end,
                    Get = function() return state end
                }
                API.SetValue = API.Set
                API.GetValue = API.Get
                return API
            end

            function SectionAPI:CreateSlider(sliderData)
                sliderData = sliderData or {}
                local sliderName = sliderData.Name or "Slider"
                local sliderIcon = sliderData.Icon or "Sliders"
                local min = sliderData.Min or 0
                local max = sliderData.Max or 100
                local default = sliderData.Default or min
                local increment = sliderData.Increment or 1
                local callback = sliderData.Callback or function() end
                local desc = sliderData.Desc

                local hasDesc = desc and desc ~= ""
                local frameHeight = hasDesc and 50 or 40

                local SliderFrame = Create("Frame", {
                    Parent = SectionItems,
                    Size = UDim2.new(1, 0, 0, frameHeight),
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    LayoutOrder = #SectionItems:GetChildren(),
                    ClipsDescendants = true,
                    ZIndex = 18
                })
                Create("UICorner", {CornerRadius = UDim.new(0, 5), Parent = SliderFrame})

                Create("ImageLabel", {
                    Parent = SliderFrame,
                    Size = UDim2.new(0, 14, 0, 14),
                    Position = UDim2.new(0, 7, 0, hasDesc and 5 or 5),
                    BackgroundTransparency = 1,
                    Image = GetIcon(sliderIcon),
                    ImageColor3 = CurrentTheme.SubText,
                    ZIndex = 19
                })

                Create("TextLabel", {
                    Parent = SliderFrame,
                    Size = UDim2.new(0, 110, 0, 14),
                    Position = UDim2.new(0, 22, 0, hasDesc and 1 or 3),
                    BackgroundTransparency = 1,
                    Text = sliderName,
                    TextColor3 = CurrentTheme.Text,
                    TextSize = 11,
                    Font = Enum.Font.Gotham,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    ZIndex = 19
                })

                if hasDesc then
                    Create("TextLabel", {
                        Parent = SliderFrame,
                        Size = UDim2.new(1, -14, 0, 10),
                        Position = UDim2.new(0, 22, 0, 13),
                        BackgroundTransparency = 1,
                        Text = desc,
                        TextColor3 = CurrentTheme.SubText,
                        TextSize = 11,
                        Font = Enum.Font.Gotham,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        TextWrapped = true,
                        AutomaticSize = Enum.AutomaticSize.Y,
                        ZIndex = 19
                    })
                end

                local ValueLabel = Create("TextLabel", {
                    Parent = SliderFrame,
                    Size = UDim2.new(0, 38, 0, 14),
                    Position = UDim2.new(1, -42, 0, hasDesc and 1 or 3),
                    BackgroundTransparency = 1,
                    Text = tostring(default),
                    TextColor3 = CurrentTheme.Accent,
                    TextSize = 11,
                    Font = Enum.Font.GothamBold,
                    TextXAlignment = Enum.TextXAlignment.Right,
                    ZIndex = 19
                })

                local Track = Create("Frame", {
                    Parent = SliderFrame,
                    Size = UDim2.new(1, -14, 0, 4),
                    Position = UDim2.new(0, 7, 0, hasDesc and 36 or 26),
                    BackgroundColor3 = Color3.fromRGB(35, 35, 40),
                    BorderSizePixel = 0,
                    ZIndex = 19
                })
                Create("UICorner", {CornerRadius = UDim.new(1, 0), Parent = Track})

                local Fill = Create("Frame", {
                    Parent = Track,
                    Size = UDim2.new((default - min) / (max - min), 0, 1, 0),
                    BackgroundColor3 = CurrentTheme.Accent,
                    BorderSizePixel = 0,
                    ZIndex = 20
                })
                Create("UICorner", {CornerRadius = UDim.new(1, 0), Parent = Fill})

                local Knob = Create("Frame", {
                    Parent = Track,
                    Size = UDim2.new(0, 14, 0, 14),
                    Position = UDim2.new((default - min) / (max - min), -6, 0.5, -6),
                    BackgroundColor3 = CurrentTheme.Text,
                    BorderSizePixel = 0,
                    ZIndex = 21
                })
                Create("UICorner", {CornerRadius = UDim.new(1, 0), Parent = Knob})

                local draggingSlider = false

                local flag = sliderData.Flag or sliderData.Name or "Slider"
                local configKey = sectionName .. "/" .. flag

                local function UpdateSlider(input)
                    local pos = math.clamp((input.Position.X - Track.AbsolutePosition.X) / Track.AbsoluteSize.X, 0, 1)
                    local value = math.clamp(Round(min + (pos * (max - min)), math.log10(1/increment)), min, max)
                    value = math.floor(value / increment + 0.5) * increment
                    Fill.Size = UDim2.new((value - min) / (max - min), 0, 1, 0)
                    Knob.Position = UDim2.new((value - min) / (max - min), -6, 0.5, -6)
                    ValueLabel.Text = tostring(value)
                    if ActiveConfigManager then
                        ActiveConfigManager:Set(configKey, value)
                    end
                    callback(value)
                end

                Knob.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        draggingSlider = true
                    end
                end)

                Track.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        draggingSlider = true
                        UpdateSlider(input)
                    end
                end)

                UserInputService.InputChanged:Connect(function(input)
                    if draggingSlider and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                        UpdateSlider(input)
                    end
                end)

                UserInputService.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        draggingSlider = false
                    end
                end)

                ListenTheme(function(theme)
                    SliderFrame.BackgroundColor3 = theme.Background
                    Track.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
                    Fill.BackgroundColor3 = theme.Accent
                    Knob.BackgroundColor3 = theme.Text
                    ValueLabel.TextColor3 = theme.Accent
                end)

                local API = {
                    Set = function(selfOrVal, maybeVal)
                        local val
                        if maybeVal ~= nil then val = maybeVal else val = selfOrVal end
                        val = tonumber(val) or default
                        val = math.clamp(val, min, max)
                        val = math.floor((val - min) / increment + 0.5) * increment + min
                        Fill.Size = UDim2.new((val - min) / (max - min), 0, 1, 0)
                        Knob.Position = UDim2.new((val - min) / (max - min), -6, 0.5, -6)
                        ValueLabel.Text = tostring(val)
                        if ActiveConfigManager then
                            ActiveConfigManager:Set(configKey, val)
                        end
                        callback(val)
                    end,
                    Get = function() return tonumber(ValueLabel.Text) or default end
                }
                API.SetValue = API.Set
                API.GetValue = API.Get

                if ActiveConfigManager then
                    ActiveConfigManager:BindElement(configKey, "Slider", function()
                        return tonumber(ValueLabel.Text) or default
                    end, function(val)
                        if val ~= nil then
                            local num = tonumber(val)
                            if num then
                                API.Set(num)
                            end
                        end
                    end)
                end

                table.insert(RegisteredFeatures, {
                    Name = sliderName,
                    Desc = desc,
                    Frame = SliderFrame,
                    Section = SectionFrame,
                    SectionItems = SectionItems
                })

                return API
            end

            function SectionAPI:CreateButton(buttonData)
                buttonData = buttonData or {}
                local buttonName = buttonData.Name or "Button"
                local buttonIcon = buttonData.Icon or "Command"
                local callback = buttonData.Callback or function() end
                local desc = buttonData.Desc

                local hasDesc = desc and desc ~= ""
                local frameHeight = hasDesc and 42 or 28

                local Btn = Create("TextButton", {
                    Parent = SectionItems,
                    Size = UDim2.new(1, 0, 0, frameHeight),
                    BackgroundColor3 = Color3.fromRGB(30, 110, 220),
                    Text = "",
                    AutoButtonColor = false,
                    LayoutOrder = #SectionItems:GetChildren(),
                    ClipsDescendants = true,
                    ZIndex = 18
                })
                Create("UICorner", {CornerRadius = UDim.new(0, 5), Parent = Btn})

                Create("ImageLabel", {
                    Parent = Btn,
                    Size = UDim2.new(0, 14, 0, 14),
                    Position = UDim2.new(0, 7, 0, hasDesc and 5 or 5),
                    BackgroundTransparency = 1,
                    Image = GetIcon(buttonIcon),
                    ImageColor3 = CurrentTheme.Text,
                    ZIndex = 19
                })

                Create("TextLabel", {
                    Parent = Btn,
                    Size = UDim2.new(0, 150, 0, 14),
                    Position = UDim2.new(0, 22, 0, hasDesc and 1 or 3),
                    BackgroundTransparency = 1,
                    Text = buttonName,
                    TextColor3 = CurrentTheme.Text,
                    TextSize = 11,
                    Font = Enum.Font.GothamBold,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    ZIndex = 19
                })

                if hasDesc then
                    Create("TextLabel", {
                        Parent = Btn,
                        Size = UDim2.new(1, -26, 0, 10),
                        Position = UDim2.new(0, 22, 0, 13),
                        BackgroundTransparency = 1,
                        Text = desc,
                        TextColor3 = CurrentTheme.Text,
                        TextTransparency = 0.3,
                        TextSize = 11,
                        Font = Enum.Font.Gotham,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        TextWrapped = true,
                        AutomaticSize = Enum.AutomaticSize.Y,
                        ZIndex = 19
                    })
                end

                Btn.MouseEnter:Connect(function()
                    Btn.BackgroundColor3 = Color3.fromRGB(50, 140, 255)
                end)
                Btn.MouseLeave:Connect(function()
                    Btn.BackgroundColor3 = Color3.fromRGB(30, 110, 220)
                end)
                Btn.MouseButton1Down:Connect(function()
                    Btn.BackgroundColor3 = Color3.fromRGB(90, 180, 255)
                end)
                Btn.MouseButton1Up:Connect(function()
                    Btn.BackgroundColor3 = Color3.fromRGB(50, 140, 255)
                end)
                ConnectButton(Btn, callback)

                ListenTheme(function(theme)
                    Btn.BackgroundColor3 = Color3.fromRGB(30, 110, 220)
                end)

                table.insert(RegisteredFeatures, {
                    Name = buttonName,
                    Desc = desc,
                    Frame = Btn,
                    Section = SectionFrame,
                    SectionItems = SectionItems
                })

                return {Click = callback}
            end

            function SectionAPI:CreateButtonRow(buttonsData)
                buttonsData = buttonsData or {}
                local numButtons = #buttonsData
                if numButtons == 0 then return end

                local row1Data = {}
                local row2Data = {}

                if numButtons <= 3 then
                    row1Data = buttonsData
                else
                    local half = math.ceil(numButtons / 2)
                    for i = 1, half do
                        table.insert(row1Data, buttonsData[i])
                    end
                    for i = half + 1, math.min(numButtons, half * 2) do
                        table.insert(row2Data, buttonsData[i])
                    end
                end

                local numRows = #row2Data > 0 and 2 or 1
                local rowContainerHeight = numRows == 1 and 28 or 60

                local MainContainer = Create("Frame", {
                    Parent = SectionItems,
                    Size = UDim2.new(1, 0, 0, rowContainerHeight),
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    LayoutOrder = #SectionItems:GetChildren(),
                    ZIndex = 18
                })

                Create("UIListLayout", {
                    Parent = MainContainer,
                    FillDirection = Enum.FillDirection.Vertical,
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    Padding = UDim.new(0, 4)
                })

                local function MakeRow(bList, parent)
                    local rCount = #bList
                    local RowFrame = Create("Frame", {
                        Parent = parent,
                        Size = UDim2.new(1, 0, 0, 28),
                        BackgroundTransparency = 1,
                        BorderSizePixel = 0,
                        ZIndex = 18
                    })

                    Create("UIListLayout", {
                        Parent = RowFrame,
                        FillDirection = Enum.FillDirection.Horizontal,
                        SortOrder = Enum.SortOrder.LayoutOrder,
                        Padding = UDim.new(0, 5)
                    })

                    local buttonWidth = 1 / rCount
                    local totalPadding = (rCount - 1) * 5
                    local padPerBtn = totalPadding / rCount

                    for _, data in ipairs(bList) do
                        local btn = Create("TextButton", {
                            Parent = RowFrame,
                            Size = UDim2.new(buttonWidth, -padPerBtn, 1, 0),
                            BackgroundColor3 = Color3.fromRGB(30, 110, 220),
                            Text = data.Name or data.Title or "Button",
                            TextColor3 = Color3.fromRGB(255, 255, 255),
                            TextSize = 11,
                            Font = Enum.Font.GothamBold,
                            AutoButtonColor = false,
                            ClipsDescendants = true,
                            ZIndex = 19
                        })
                        Create("UICorner", {CornerRadius = UDim.new(0, 5), Parent = btn})

                        if data.Icon then
                            Create("ImageLabel", {
                                Parent = btn,
                                Size = UDim2.new(0, 14, 0, 14),
                                Position = UDim2.new(0, 6, 0.5, -7),
                                BackgroundTransparency = 1,
                                Image = GetIcon(data.Icon),
                                ImageColor3 = Color3.fromRGB(255, 255, 255),
                                ZIndex = 20
                            })
                        end

                        btn.MouseEnter:Connect(function()
                            Tween(btn, {BackgroundColor3 = Color3.fromRGB(50, 140, 255)}, 0.15)
                        end)
                        btn.MouseLeave:Connect(function()
                            Tween(btn, {BackgroundColor3 = Color3.fromRGB(30, 110, 220)}, 0.15)
                        end)
                        btn.MouseButton1Down:Connect(function()
                            btn.BackgroundColor3 = Color3.fromRGB(90, 180, 255)
                        end)
                        btn.MouseButton1Up:Connect(function()
                            btn.BackgroundColor3 = Color3.fromRGB(50, 140, 255)
                        end)
                        ConnectButton(btn, function() if data.Callback then data.Callback() end end)

                        table.insert(RegisteredFeatures, {
                            Name = data.Name or data.Title or "Button",
                            Desc = nil,
                            Frame = MainContainer,
                            Section = SectionFrame,
                            SectionItems = SectionItems
                        })
                    end
                end

                MakeRow(row1Data, MainContainer)
                if #row2Data > 0 then
                    MakeRow(row2Data, MainContainer)
                end

                ListenTheme(function(theme)
                    for _, row in ipairs(MainContainer:GetChildren()) do
                        if row:IsA("Frame") then
                            for _, child in ipairs(row:GetChildren()) do
                                if child:IsA("TextButton") then
                                    child.BackgroundColor3 = Color3.fromRGB(30, 110, 220)
                                    child.TextColor3 = Color3.fromRGB(255, 255, 255)
                                end
                            end
                        end
                    end
                end)
            end

            function SectionAPI:CreateDropdown(dropdownData)
                dropdownData = dropdownData or {}
                local dropdownName = dropdownData.Name or "Dropdown"
                local dropdownIcon = dropdownData.Icon or "ChevronDown"
                local options = dropdownData.Options or dropdownData.Values or {}
                local default = dropdownData.Default or ""
                local callback = dropdownData.Callback or function() end
                local desc = dropdownData.Desc

                local hasDesc = desc and desc ~= ""
                local frameHeight = hasDesc and 44 or 30

                local DropdownFrame = Create("Frame", {
                    Parent = SectionItems,
                    Size = UDim2.new(1, 0, 0, frameHeight),
                    BackgroundColor3 = CurrentTheme.Element,
                    BorderSizePixel = 0,
                    LayoutOrder = #SectionItems:GetChildren(),
                    ClipsDescendants = true,
                    ZIndex = 18
                })
                Create("UICorner", {CornerRadius = UDim.new(0, 5), Parent = DropdownFrame})

                Create("ImageLabel", {
                    Parent = DropdownFrame,
                    Size = UDim2.new(0, 14, 0, 14),
                    Position = UDim2.new(0, 7, 0, hasDesc and 7 or 8),
                    BackgroundTransparency = 1,
                    Image = GetIcon(dropdownIcon),
                    ImageColor3 = CurrentTheme.SubText,
                    ZIndex = 19
                })

                Create("TextLabel", {
                    Parent = DropdownFrame,
                    Size = UDim2.new(1, -165, 0, 14),
                    Position = UDim2.new(0, 24, 0, hasDesc and 4 or 8),
                    BackgroundTransparency = 1,
                    Text = dropdownName,
                    TextColor3 = CurrentTheme.Text,
                    TextSize = 11,
                    Font = Enum.Font.Gotham,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextTruncate = Enum.TextTruncate.AtEnd,
                    ZIndex = 19
                })

                if hasDesc then
                    Create("TextLabel", {
                        Parent = DropdownFrame,
                        Size = UDim2.new(1, -165, 0, 14),
                        Position = UDim2.new(0, 24, 0, 21),
                        BackgroundTransparency = 1,
                        Text = desc,
                        TextColor3 = CurrentTheme.SubText,
                        TextSize = 10,
                        Font = Enum.Font.Gotham,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        TextTruncate = Enum.TextTruncate.AtEnd,
                        ZIndex = 19
                    })
                end

                local DropdownBtn = Create("TextButton", {
                    Parent = DropdownFrame,
                    Size = UDim2.new(0, 130, 0, 24),
                    Position = UDim2.new(1, -136, 0.5, -12),
                    BackgroundColor3 = Color3.fromRGB(55, 55, 60),
                    Text = "",
                    TextColor3 = CurrentTheme.SubText,
                    TextSize = 11,
                    Font = Enum.Font.Gotham,
                    TextTruncate = Enum.TextTruncate.AtEnd,
                    Active = true,
                    AutoButtonColor = true,
                    ZIndex = 19
                })
                Create("UICorner", {CornerRadius = UDim.new(0, 4), Parent = DropdownBtn})
                Create("UIStroke", {
                    Color = Color3.fromRGB(80, 80, 85),
                    Thickness = 1,
                    Transparency = 0.5,
                    Parent = DropdownBtn
                })
                Create("UIStroke", {
                    Color = Color3.fromRGB(0, 140, 255),
                    Thickness = 1,
                    Transparency = 0.7,
                    Parent = DropdownBtn
                })

                local Arrow = Create("ImageLabel", {
                    Parent = DropdownBtn,
                    Size = UDim2.new(0, 14, 0, 14),
                    Position = UDim2.new(1, -18, 0.5, -7),
                    BackgroundTransparency = 1,
                    Image = GetIcon("ChevronDown"),
                    ImageColor3 = CurrentTheme.SubText,
                    ZIndex = 20
                })

                local selected = default
                local function UpdateButtonText()
                    local selText, _ = NormalizeOption(selected)
                    if selText ~= "" then
                        DropdownBtn.Text = selText
                        DropdownBtn.TextColor3 = CurrentTheme.Text
                    else
                        DropdownBtn.Text = "Select option"
                        DropdownBtn.TextColor3 = CurrentTheme.SubText
                    end
                end
                UpdateButtonText()

                local optionButtons = {}

                local function BuildOptions(filterText)
                    for _, btn in ipairs(optionButtons) do
                        if btn and btn.Parent then btn:Destroy() end
                    end
                    optionButtons = {}

                    for _, child in ipairs(DropdownPanelScroll:GetChildren()) do
                        if child:IsA("GuiObject") and child.Name ~= "UIListLayout" and child.Name ~= "UIPadding" then
                            child:Destroy()
                        end
                    end

                    local count = 0
                    for _, opt in ipairs(options) do
                        local optText, optIcon = NormalizeOption(opt)
                        if not filterText or filterText == "" or string.find(string.lower(optText), string.lower(filterText), 1, true) then
                            count = count + 1
                            local isThisSelected = (optText == NormalizeOption(selected))

                            local optBtn = Create("TextButton", {
                                Parent = DropdownPanelScroll,
                                Size = UDim2.new(1, 0, 0, 30),
                                BackgroundTransparency = isThisSelected and 0 or 1,
                                BackgroundColor3 = isThisSelected and CurrentTheme.ElementHover or CurrentTheme.Element,
                                Text = "",
                                TextColor3 = CurrentTheme.Text,
                                TextSize = 12,
                                Font = Enum.Font.Gotham,
                                Active = true,
                                AutoButtonColor = true,
                                LayoutOrder = count,
                                ZIndex = 155
                            })
                            Create("UICorner", {CornerRadius = UDim.new(0, 4), Parent = optBtn})

                            if optIcon then
                                Create("ImageLabel", {
                                    Parent = optBtn,
                                    Size = UDim2.new(0, 14, 0, 14),
                                    Position = UDim2.new(0, 8, 0.5, -7),
                                    BackgroundTransparency = 1,
                                    Image = GetIcon(optIcon),
                                    ImageColor3 = isThisSelected and CurrentTheme.Accent or CurrentTheme.SubText,
                                    ZIndex = 156
                                })
                            end

                            local optLabel = Create("TextLabel", {
                                Parent = optBtn,
                                Size = UDim2.new(1, optIcon and -32 or -16, 1, 0),
                                Position = UDim2.new(0, optIcon and 28 or 8, 0, 0),
                                BackgroundTransparency = 1,
                                Text = optText,
                                TextColor3 = isThisSelected and CurrentTheme.Accent or CurrentTheme.Text,
                                TextSize = 11,
                                Font = Enum.Font.Gotham,
                                TextXAlignment = Enum.TextXAlignment.Left,
                                TextTruncate = Enum.TextTruncate.AtEnd,
                                ZIndex = 156
                            })

                            local function SelectThisOption()
                                selected = opt
                                UpdateButtonText()
                                CloseAllDropdowns()
                                if ActiveConfigManager then
                                    ActiveConfigManager:Set(configKey, opt)
                                end
                                callback(opt)
                            end

                            ConnectButton(optBtn, SelectThisOption)

                            optBtn.MouseEnter:Connect(function()
                                if not (optText == NormalizeOption(selected)) then
                                    optBtn.BackgroundTransparency = 0
                                    optBtn.BackgroundColor3 = CurrentTheme.ElementHover
                                end
                            end)
                            optBtn.MouseLeave:Connect(function()
                                if not (optText == NormalizeOption(selected)) then
                                    optBtn.BackgroundTransparency = 1
                                end
                            end)

                            table.insert(optionButtons, optBtn)
                        end
                    end

                    if count == 0 then
                        local emptyLabel = Create("TextLabel", {
                            Parent = DropdownPanelScroll,
                            Size = UDim2.new(1, 0, 0, 36),
                            BackgroundTransparency = 1,
                            Text = (filterText and filterText ~= "") and "No matching results" or "No options available",
                            TextColor3 = CurrentTheme.SubText,
                            TextSize = 11,
                            Font = Enum.Font.Gotham,
                            TextXAlignment = Enum.TextXAlignment.Center,
                            ZIndex = 156
                        })
                        table.insert(optionButtons, emptyLabel)
                        DropdownPanelScroll.CanvasSize = UDim2.new(0, 0, 0, 45)
                    else
                        DropdownPanelScroll.CanvasSize = UDim2.new(0, 0, 0, count * 33 + 40)
                    end
                    CurrentDropdownState.OptionButtons = optionButtons
                end

                local function ToggleDropdownMenu()
                    if CurrentDropdownState.IsOpen and CurrentDropdownState.Button == DropdownBtn then
                        CloseAllDropdowns()
                    else
                        CloseAllDropdowns()
                        CurrentDropdownState.IsOpen = true
                        CurrentDropdownState.IsMulti = false
                        CurrentDropdownState.Options = options
                        CurrentDropdownState.Selected = selected
                        CurrentDropdownState.Callback = callback
                        CurrentDropdownState.Button = DropdownBtn
                        CurrentDropdownState.Arrow = Arrow
                        CurrentDropdownState.Rebuild = BuildOptions
                        DropdownPanelTitle.Text = dropdownName
                        DropdownPanelSearch.Text = ""
                        BuildOptions()
                        if ResizeHandle then ResizeHandle.Visible = false end
                        DropdownOverlay.Visible = true
                        DropdownPanel.Visible = true
                        Arrow.Rotation = 180
                    end
                end

                ConnectButton(DropdownBtn, ToggleDropdownMenu)

                table.insert(RegisteredFeatures, {
                    Name = dropdownName,
                    Desc = desc,
                    Frame = DropdownFrame,
                    Section = SectionFrame,
                    SectionItems = SectionItems
                })

                ListenTheme(function(theme)
                    DropdownFrame.BackgroundColor3 = theme.Element
                    DropdownBtn.BackgroundColor3 = Color3.fromRGB(55, 55, 60)
                    Arrow.ImageColor3 = theme.SubText
                    UpdateButtonText()
                end)

                local flag = dropdownData.Flag or dropdownData.Name or "Dropdown"
                local configKey = sectionName .. "/" .. flag

                local DropdownAPI = {}
                function DropdownAPI.Set(selfOrVal, maybeVal)
                    local val
                    if maybeVal ~= nil then val = maybeVal else val = selfOrVal end
                    selected = val
                    UpdateButtonText()
                    if ActiveConfigManager then
                        ActiveConfigManager:Set(configKey, val)
                    end
                    callback(val)
                end
                function DropdownAPI.Refresh(selfOrOptions, maybeOptions, maybeDefault)
                    local newOptions, newDefault
                    if type(selfOrOptions) == "table" and selfOrOptions ~= DropdownAPI then
                        newOptions = selfOrOptions
                        newDefault = maybeOptions
                    else
                        newOptions = maybeOptions
                        newDefault = maybeDefault
                    end
                    options = newOptions or {}
                    if newDefault ~= nil then
                        selected = newDefault
                    elseif not table.find(options, selected) then
                        selected = options[1] or ""
                    end
                    UpdateButtonText()
                    if CurrentDropdownState.IsOpen and CurrentDropdownState.Button == DropdownBtn then
                        BuildOptions(DropdownPanelSearch.Text)
                    end
                end
                function DropdownAPI.Get()
                    return selected
                end
                DropdownAPI.SetValue = DropdownAPI.Set
                DropdownAPI.GetValue = DropdownAPI.Get

                if ActiveConfigManager then
                    ActiveConfigManager:BindElement(configKey, "Dropdown", function()
                        return selected
                    end, function(val)
                        if val ~= nil then
                            selected = val
                            UpdateButtonText()
                            callback(val)
                        end
                    end)
                end

                return DropdownAPI
            end

            function SectionAPI:CreateMultiDropdown(dropdownData)
                dropdownData = dropdownData or {}
                local dropdownName = dropdownData.Name or "MultiDropdown"
                local dropdownIcon = dropdownData.Icon or "CheckSquare"
                local options = dropdownData.Options or dropdownData.Values or {}
                local default = dropdownData.Default or {}
                local callback = dropdownData.Callback or function() end
                local desc = dropdownData.Desc

                local hasDesc = desc and desc ~= ""
                local frameHeight = hasDesc and 44 or 30

                local DropdownFrame = Create("Frame", {
                    Parent = SectionItems,
                    Size = UDim2.new(1, 0, 0, frameHeight),
                    BackgroundColor3 = CurrentTheme.Element,
                    BorderSizePixel = 0,
                    LayoutOrder = #SectionItems:GetChildren(),
                    ClipsDescendants = true,
                    ZIndex = 18
                })
                Create("UICorner", {CornerRadius = UDim.new(0, 5), Parent = DropdownFrame})

                Create("ImageLabel", {
                    Parent = DropdownFrame,
                    Size = UDim2.new(0, 14, 0, 14),
                    Position = UDim2.new(0, 7, 0, hasDesc and 7 or 8),
                    BackgroundTransparency = 1,
                    Image = GetIcon(dropdownIcon),
                    ImageColor3 = CurrentTheme.SubText,
                    ZIndex = 19
                })

                Create("TextLabel", {
                    Parent = DropdownFrame,
                    Size = UDim2.new(1, -165, 0, 14),
                    Position = UDim2.new(0, 24, 0, hasDesc and 4 or 8),
                    BackgroundTransparency = 1,
                    Text = dropdownName,
                    TextColor3 = CurrentTheme.Text,
                    TextSize = 11,
                    Font = Enum.Font.Gotham,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextTruncate = Enum.TextTruncate.AtEnd,
                    ZIndex = 19
                })

                if hasDesc then
                    Create("TextLabel", {
                        Parent = DropdownFrame,
                        Size = UDim2.new(1, -165, 0, 14),
                        Position = UDim2.new(0, 24, 0, 21),
                        BackgroundTransparency = 1,
                        Text = desc,
                        TextColor3 = CurrentTheme.SubText,
                        TextSize = 10,
                        Font = Enum.Font.Gotham,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        TextTruncate = Enum.TextTruncate.AtEnd,
                        ZIndex = 19
                    })
                end

                local DropdownBtn = Create("TextButton", {
                    Parent = DropdownFrame,
                    Size = UDim2.new(0, 130, 0, 24),
                    Position = UDim2.new(1, -136, 0.5, -12),
                    BackgroundColor3 = Color3.fromRGB(55, 55, 60),
                    Text = "",
                    TextColor3 = CurrentTheme.SubText,
                    TextSize = 11,
                    Font = Enum.Font.Gotham,
                    TextTruncate = Enum.TextTruncate.AtEnd,
                    Active = true,
                    AutoButtonColor = true,
                    ZIndex = 19
                })
                Create("UICorner", {CornerRadius = UDim.new(0, 4), Parent = DropdownBtn})
                Create("UIStroke", {
                    Color = Color3.fromRGB(80, 80, 85),
                    Thickness = 1,
                    Transparency = 0.5,
                    Parent = DropdownBtn
                })
                Create("UIStroke", {
                    Color = Color3.fromRGB(0, 140, 255),
                    Thickness = 1,
                    Transparency = 0.7,
                    Parent = DropdownBtn
                })

                local Arrow = Create("ImageLabel", {
                    Parent = DropdownBtn,
                    Size = UDim2.new(0, 14, 0, 14),
                    Position = UDim2.new(1, -18, 0.5, -7),
                    BackgroundTransparency = 1,
                    Image = GetIcon("ChevronDown"),
                    ImageColor3 = CurrentTheme.SubText,
                    ZIndex = 20
                })

                local selected = {}
                if type(default) == "table" then
                    for _, v in ipairs(default) do
                        table.insert(selected, v)
                    end
                elseif default ~= "" then
                    table.insert(selected, default)
                end

                local function UpdateButtonText()
                    if #selected > 0 then
                        local displayNames = {}
                        for _, s in ipairs(selected) do
                            local sText, _ = NormalizeOption(s)
                            table.insert(displayNames, sText)
                        end
                        DropdownBtn.Text = table.concat(displayNames, ", ")
                        DropdownBtn.TextColor3 = CurrentTheme.Text
                    else
                        DropdownBtn.Text = "Select options"
                        DropdownBtn.TextColor3 = CurrentTheme.SubText
                    end
                end
                UpdateButtonText()

                local function IsOptionSelected(opt)
                    for _, s in ipairs(selected) do
                        local sText, _ = NormalizeOption(s)
                        local oText, _ = NormalizeOption(opt)
                        if sText == oText then return true end
                    end
                    return false
                end

                local optionItems = {}

                local function BuildOptions(filterText)
                    for _, item in ipairs(optionItems) do
                        if item and item.Parent then item:Destroy() end
                    end
                    optionItems = {}

                    for _, child in ipairs(DropdownPanelScroll:GetChildren()) do
                        if child:IsA("GuiObject") and child.Name ~= "UIListLayout" and child.Name ~= "UIPadding" then
                            child:Destroy()
                        end
                    end

                    local count = 0
                    for _, opt in ipairs(options) do
                        local optText, optIcon = NormalizeOption(opt)
                        if not filterText or filterText == "" or string.find(string.lower(optText), string.lower(filterText), 1, true) then
                            count = count + 1
                            local isSel = IsOptionSelected(opt)

                            local row = Create("TextButton", {
                                Parent = DropdownPanelScroll,
                                Size = UDim2.new(1, 0, 0, 30),
                                BackgroundTransparency = 1,
                                BackgroundColor3 = CurrentTheme.Element,
                                Text = "",
                                AutoButtonColor = false,
                                Active = true,
                                LayoutOrder = count,
                                ZIndex = 155
                            })
                            Create("UICorner", {CornerRadius = UDim.new(0, 3), Parent = row})

                            local chkBox = Create("Frame", {
                                Parent = row,
                                Size = UDim2.new(0, 16, 0, 16),
                                Position = UDim2.new(0, 5, 0.5, -8),
                                BackgroundColor3 = isSel and CurrentTheme.Accent or CurrentTheme.ElementHover,
                                BorderSizePixel = 0,
                                ZIndex = 156
                            })
                            Create("UICorner", {CornerRadius = UDim.new(0, 3), Parent = chkBox})
                            Create("UIStroke", {Color = isSel and CurrentTheme.Accent or CurrentTheme.Border, Thickness = 1, Parent = chkBox})

                            local chkIcon = Create("ImageLabel", {
                                Parent = chkBox,
                                Size = UDim2.new(0, 12, 0, 12),
                                Position = UDim2.new(0.5, -6, 0.5, -6),
                                BackgroundTransparency = 1,
                                Image = GetIcon("Check"),
                                ImageColor3 = Color3.fromRGB(0, 0, 0),
                                Visible = isSel,
                                ZIndex = 157
                            })

                            if optIcon then
                                Create("ImageLabel", {
                                    Parent = row,
                                    Size = UDim2.new(0, 14, 0, 14),
                                    Position = UDim2.new(0, 26, 0.5, -7),
                                    BackgroundTransparency = 1,
                                    Image = GetIcon(optIcon),
                                    ImageColor3 = CurrentTheme.SubText,
                                    ZIndex = 156
                                })
                            end

                            local optLabel = Create("TextLabel", {
                                Parent = row,
                                Size = UDim2.new(1, optIcon and -50 or -30, 1, 0),
                                Position = UDim2.new(0, optIcon and 44 or 26, 0, 0),
                                BackgroundTransparency = 1,
                                Text = optText,
                                TextColor3 = isSel and CurrentTheme.Accent or CurrentTheme.Text,
                                TextSize = 11,
                                Font = Enum.Font.Gotham,
                                TextXAlignment = Enum.TextXAlignment.Left,
                                TextTruncate = Enum.TextTruncate.AtEnd,
                                ZIndex = 156
                            })

                            local function ToggleThisOption()
                                local found = false
                                for i, s in ipairs(selected) do
                                    local sText, _ = NormalizeOption(s)
                                    if sText == optText then
                                        table.remove(selected, i)
                                        found = true
                                        break
                                    end
                                end
                                if not found then
                                    table.insert(selected, opt)
                                end

                                isSel = not found
                                chkBox.BackgroundColor3 = isSel and CurrentTheme.Accent or CurrentTheme.ElementHover
                                chkIcon.Visible = isSel
                                optLabel.TextColor3 = isSel and CurrentTheme.Accent or CurrentTheme.Text
                                UpdateButtonText()
                                if ActiveConfigManager then
                                    ActiveConfigManager:Set(configKey, selected)
                                end
                                callback(selected)
                            end

                            ConnectButton(row, ToggleThisOption)

                            row.MouseEnter:Connect(function()
                                row.BackgroundTransparency = 0
                                row.BackgroundColor3 = CurrentTheme.ElementHover
                            end)
                            row.MouseLeave:Connect(function()
                                row.BackgroundTransparency = 1
                            end)

                            table.insert(optionItems, row)
                        end
                    end

                    if count == 0 then
                        local emptyLabel = Create("TextLabel", {
                            Parent = DropdownPanelScroll,
                            Size = UDim2.new(1, 0, 0, 36),
                            BackgroundTransparency = 1,
                            Text = (filterText and filterText ~= "") and "No matching results" or "No options available",
                            TextColor3 = CurrentTheme.SubText,
                            TextSize = 11,
                            Font = Enum.Font.Gotham,
                            TextXAlignment = Enum.TextXAlignment.Center,
                            ZIndex = 156
                        })
                        table.insert(optionItems, emptyLabel)
                        DropdownPanelScroll.CanvasSize = UDim2.new(0, 0, 0, 45)
                    else
                        DropdownPanelScroll.CanvasSize = UDim2.new(0, 0, 0, count * 33 + 40)
                    end
                    CurrentDropdownState.OptionButtons = optionItems
                end

                local function ToggleMultiDropdownMenu()
                    if CurrentDropdownState.IsOpen and CurrentDropdownState.Button == DropdownBtn then
                        CloseAllDropdowns()
                    else
                        CloseAllDropdowns()
                        CurrentDropdownState.IsOpen = true
                        CurrentDropdownState.IsMulti = true
                        CurrentDropdownState.Options = options
                        CurrentDropdownState.Selected = selected
                        CurrentDropdownState.Callback = callback
                        CurrentDropdownState.Button = DropdownBtn
                        CurrentDropdownState.Arrow = Arrow
                        CurrentDropdownState.Rebuild = BuildOptions
                        DropdownPanelTitle.Text = dropdownName
                        DropdownPanelSearch.Text = ""
                        BuildOptions()
                        if ResizeHandle then ResizeHandle.Visible = false end
                        DropdownOverlay.Visible = true
                        DropdownPanel.Visible = true
                        Arrow.Rotation = 180
                    end
                end

                ConnectButton(DropdownBtn, ToggleMultiDropdownMenu)

                table.insert(RegisteredFeatures, {
                    Name = dropdownName,
                    Desc = desc,
                    Frame = DropdownFrame,
                    Section = SectionFrame,
                    SectionItems = SectionItems
                })

                ListenTheme(function(theme)
                    DropdownFrame.BackgroundColor3 = theme.Element
                    DropdownBtn.BackgroundColor3 = Color3.fromRGB(55, 55, 60)
                    Arrow.ImageColor3 = theme.SubText
                    UpdateButtonText()
                end)

                local flag = dropdownData.Flag or dropdownData.Name or "MultiDropdown"
                local configKey = sectionName .. "/" .. flag

                local MultiDropdownAPI = {}
                function MultiDropdownAPI.Set(selfOrVal, maybeVal)
                    local val
                    if maybeVal ~= nil then val = maybeVal else val = selfOrVal end
                    selected = type(val) == "table" and val or {val}
                    UpdateButtonText()
                    if ActiveConfigManager then
                        ActiveConfigManager:Set(configKey, selected)
                    end
                    callback(selected)
                end
                function MultiDropdownAPI.Refresh(selfOrOptions, maybeOptions, maybeDefault)
                    local newOptions, newDefault
                    if type(selfOrOptions) == "table" and selfOrOptions ~= MultiDropdownAPI then
                        newOptions = selfOrOptions
                        newDefault = maybeOptions
                    else
                        newOptions = maybeOptions
                        newDefault = maybeDefault
                    end
                    options = newOptions or {}
                    if newDefault ~= nil then
                        selected = type(newDefault) == "table" and newDefault or {newDefault}
                    end
                    UpdateButtonText()
                    if CurrentDropdownState.IsOpen and CurrentDropdownState.Button == DropdownBtn then
                        BuildOptions(DropdownPanelSearch.Text)
                    end
                end
                function MultiDropdownAPI.Get()
                    return selected
                end
                MultiDropdownAPI.SetValue = MultiDropdownAPI.Set
                MultiDropdownAPI.GetValue = MultiDropdownAPI.Get

                if ActiveConfigManager then
                    ActiveConfigManager:BindElement(configKey, "MultiDropdown", function()
                        return selected
                    end, function(val)
                        if val ~= nil then
                            selected = type(val) == "table" and val or {val}
                            UpdateButtonText()
                            callback(selected)
                        end
                    end)
                end

                return MultiDropdownAPI
            end

            function SectionAPI:CreateInput(inputData)
                inputData = inputData or {}
                local inputName = inputData.Name or "Input"
                local inputIcon = inputData.Icon or "Type"
                local placeholder = inputData.Placeholder or "Enter..."
                local default = inputData.Default or ""
                local callback = inputData.Callback or function() end
                local desc = inputData.Desc

                local hasDesc = desc and desc ~= ""
                local frameHeight = hasDesc and 42 or 28

                local InputFrame = Create("Frame", {
                    Parent = SectionItems,
                    Size = UDim2.new(1, 0, 0, frameHeight),
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    LayoutOrder = #SectionItems:GetChildren(),
                    ClipsDescendants = true,
                    ZIndex = 18
                })
                Create("UICorner", {CornerRadius = UDim.new(0, 5), Parent = InputFrame})

                Create("ImageLabel", {
                    Parent = InputFrame,
                    Size = UDim2.new(0, 14, 0, 14),
                    Position = UDim2.new(0, 7, 0, hasDesc and 5 or 5),
                    BackgroundTransparency = 1,
                    Image = GetIcon(inputIcon),
                    ImageColor3 = CurrentTheme.SubText,
                    ZIndex = 19
                })

                Create("TextLabel", {
                    Parent = InputFrame,
                    Size = UDim2.new(0, 76, 0, 14),
                    Position = UDim2.new(0, 22, 0, hasDesc and 1 or 3),
                    BackgroundTransparency = 1,
                    Text = inputName,
                    TextColor3 = CurrentTheme.Text,
                    TextSize = 11,
                    Font = Enum.Font.Gotham,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    ZIndex = 19
                })

                if hasDesc then
                    Create("TextLabel", {
                        Parent = InputFrame,
                        Size = UDim2.new(1, -120, 0, 10),
                        Position = UDim2.new(0, 22, 0, 13),
                        BackgroundTransparency = 1,
                        Text = desc,
                        TextColor3 = CurrentTheme.SubText,
                        TextSize = 11,
                        Font = Enum.Font.Gotham,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        TextWrapped = true,
                        AutomaticSize = Enum.AutomaticSize.Y,
                        ZIndex = 19
                    })
                end

                local InputBox = Create("TextBox", {
                    Parent = InputFrame,
                    Size = UDim2.new(0, 92, 0, 24),
                    Position = UDim2.new(1, -99, 0, hasDesc and 8 or 3),
                    BackgroundColor3 = Color3.fromRGB(55, 55, 60),
                    Text = default,
                    PlaceholderText = placeholder,
                    TextColor3 = CurrentTheme.Text,
                    PlaceholderColor3 = CurrentTheme.SubText,
                    TextSize = 11,
                    Font = Enum.Font.Gotham,
                    ClearTextOnFocus = false,
                    TextTruncate = Enum.TextTruncate.AtEnd,
                    ZIndex = 19
                })
                Create("UICorner", {CornerRadius = UDim.new(0, 4), Parent = InputBox})
                Create("UIStroke", {
                    Color = Color3.fromRGB(80, 80, 85),
                    Thickness = 1,
                    Transparency = 0.5,
                    Parent = InputBox
                })

                local flag = inputData.Flag or inputData.Name or "Input"
                local configKey = sectionName .. "/" .. flag

                InputBox:GetPropertyChangedSignal("Text"):Connect(function()
                    if ActiveConfigManager then
                        ActiveConfigManager:Set(configKey, InputBox.Text)
                    end
                    callback(InputBox.Text, false)
                end)

                InputBox.FocusLost:Connect(function(enterPressed)
                    if ActiveConfigManager then
                        ActiveConfigManager:Set(configKey, InputBox.Text)
                    end
                    callback(InputBox.Text, enterPressed)
                end)

                ListenTheme(function(theme)
                    InputFrame.BackgroundColor3 = theme.Background
                    InputBox.BackgroundColor3 = Color3.fromRGB(55, 55, 60)
                    InputBox.TextColor3 = theme.Text
                    InputBox.PlaceholderColor3 = theme.SubText
                end)

                table.insert(RegisteredFeatures, {
                    Name = inputName,
                    Desc = desc,
                    Frame = InputFrame,
                    Section = SectionFrame,
                    SectionItems = SectionItems
                })

                local API = {
                    Set = function(selfOrText, maybeText)
                        local text
                        if maybeText ~= nil then text = maybeText else text = selfOrText end
                        InputBox.Text = tostring(text or "")
                        if ActiveConfigManager then
                            ActiveConfigManager:Set(configKey, InputBox.Text)
                        end
                    end,
                    Get = function() return InputBox.Text end
                }
                API.SetValue = API.Set
                API.SetText = API.Set
                API.GetValue = API.Get
                API.GetText = API.Get

                if ActiveConfigManager then
                    ActiveConfigManager:BindElement(configKey, "Input", function()
                        return InputBox.Text
                    end, function(val)
                        if val ~= nil then
                            InputBox.Text = tostring(val)
                            callback(InputBox.Text, false)
                        end
                    end)
                end

                return API
            end

            function SectionAPI:CreateKeybind(bindData)
                bindData = bindData or {}
                local bindName = bindData.Name or "Keybind"
                local bindIcon = bindData.Icon or "Key"
                local default = bindData.Default or Enum.KeyCode.LeftShift
                local callback = bindData.Callback or function() end
                local desc = bindData.Desc

                local hasDesc = desc and desc ~= ""
                local frameHeight = hasDesc and 42 or 28

                local BindFrame = Create("Frame", {
                    Parent = SectionItems,
                    Size = UDim2.new(1, 0, 0, frameHeight),
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    LayoutOrder = #SectionItems:GetChildren(),
                    ClipsDescendants = true,
                    ZIndex = 18
                })
                Create("UICorner", {CornerRadius = UDim.new(0, 5), Parent = BindFrame})

                Create("ImageLabel", {
                    Parent = BindFrame,
                    Size = UDim2.new(0, 14, 0, 14),
                    Position = UDim2.new(0, 7, 0, hasDesc and 5 or 5),
                    BackgroundTransparency = 1,
                    Image = GetIcon(bindIcon),
                    ImageColor3 = CurrentTheme.SubText,
                    ZIndex = 19
                })

                Create("TextLabel", {
                    Parent = BindFrame,
                    Size = UDim2.new(0, 110, 0, 14),
                    Position = UDim2.new(0, 22, 0, hasDesc and 1 or 3),
                    BackgroundTransparency = 1,
                    Text = bindName,
                    TextColor3 = CurrentTheme.Text,
                    TextSize = 11,
                    Font = Enum.Font.Gotham,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    ZIndex = 19
                })

                if hasDesc then
                    Create("TextLabel", {
                        Parent = BindFrame,
                        Size = UDim2.new(1, -70, 0, 10),
                        Position = UDim2.new(0, 22, 0, 13),
                        BackgroundTransparency = 1,
                        Text = desc,
                        TextColor3 = CurrentTheme.SubText,
                        TextSize = 11,
                        Font = Enum.Font.Gotham,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        TextWrapped = true,
                        AutomaticSize = Enum.AutomaticSize.Y,
                        ZIndex = 19
                    })
                end

                local BindBtn = Create("TextButton", {
                    Parent = BindFrame,
                    Size = UDim2.new(0, 46, 0, 24),
                    Position = UDim2.new(1, -52, 0, hasDesc and 8 or 3),
                    BackgroundColor3 = CurrentTheme.Element,
                    Text = default.Name,
                    TextColor3 = CurrentTheme.Text,
                    TextSize = 11,
                    Font = Enum.Font.GothamBold,
                    ZIndex = 19
                })
                Create("UICorner", {CornerRadius = UDim.new(0, 4), Parent = BindBtn})

                local flag = bindData.Flag or bindData.Name or "Keybind"
                local configKey = sectionName .. "/" .. flag

                local listening = false
                ConnectButton(BindBtn, function()
                    listening = true
                    BindBtn.Text = "..."
                    local conn
                    conn = UserInputService.InputBegan:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.Keyboard then
                            default = input.KeyCode
                            BindBtn.Text = input.KeyCode.Name
                            listening = false
                            conn:Disconnect()
                            if ActiveConfigManager then
                                ActiveConfigManager:Set(configKey, default.Name)
                            end
                            callback(input.KeyCode)
                        end
                    end)
                end)

                UserInputService.InputBegan:Connect(function(input)
                    if input.KeyCode == default and not listening then
                        callback(default)
                    end
                end)

                ListenTheme(function(theme)
                    if not BindFrame or not BindFrame.Parent then return end
                    BindFrame.BackgroundColor3 = theme.Background
                    if BindBtn and BindBtn.Parent then
                        BindBtn.BackgroundColor3 = theme.Element
                        BindBtn.TextColor3 = theme.Text
                    end
                end)

                table.insert(RegisteredFeatures, {
                    Name = bindName,
                    Desc = desc,
                    Frame = BindFrame,
                    Section = SectionFrame,
                    SectionItems = SectionItems
                })

                local API = {
                    Set = function(selfOrKey, maybeKey)
                        local key
                        if maybeKey ~= nil then key = maybeKey else key = selfOrKey end
                        default = key
                        BindBtn.Text = (key and key.Name) and key.Name or "None"
                        if ActiveConfigManager and default and default.Name then
                            ActiveConfigManager:Set(configKey, default.Name)
                        end
                    end,
                    Get = function() return default end
                }
                API.SetValue = API.Set
                API.GetValue = API.Get

                if ActiveConfigManager then
                    ActiveConfigManager:BindElement(configKey, "Keybind", function()
                        return default and default.Name or ""
                    end, function(val)
                        if val ~= nil and val ~= "" then
                            local ok, kc = pcall(function() return Enum.KeyCode[val] end)
                            if ok and kc then
                                default = kc
                                BindBtn.Text = default.Name
                            end
                        end
                    end)
                end

                return API
            end

            function SectionAPI:CreateLabel(labelData)
                labelData = labelData or {}
                local labelText = labelData.Text or "Label"
                local labelIcon = labelData.Icon or "Type"

                local LabelFrame = Create("Frame", {
                    Parent = SectionItems,
                    Size = UDim2.new(1, 0, 0, 26),
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    LayoutOrder = #SectionItems:GetChildren(),
                    ClipsDescendants = false,
                    ZIndex = 18
                })
                Create("UICorner", {CornerRadius = UDim.new(0, 4), Parent = LabelFrame})

                Create("ImageLabel", {
                    Parent = LabelFrame,
                    Size = UDim2.new(0, 14, 0, 14),
                    Position = UDim2.new(0, 7, 0.5, -8),
                    BackgroundTransparency = 1,
                    Image = GetIcon(labelIcon),
                    ImageColor3 = CurrentTheme.SubText,
                    ZIndex = 19
                })

                local Label = Create("TextLabel", {
                    Parent = LabelFrame,
                    Size = UDim2.new(0, 200, 0, 18),
                    Position = UDim2.new(0, 22, 0, 0),
                    BackgroundTransparency = 1,
                    Text = labelText,
                    TextColor3 = CurrentTheme.Text,
                    TextSize = 11,
                    Font = Enum.Font.Gotham,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    RichText = true,
                    ZIndex = 19
                })

                ListenTheme(function(theme)
                    if not LabelFrame or not LabelFrame.Parent then return end
                    LabelFrame.BackgroundColor3 = theme.Background
                    if Label and Label.Parent then
                        Label.TextColor3 = theme.Text
                    end
                end)

                table.insert(RegisteredFeatures, {
                    Name = labelText,
                    Desc = nil,
                    Frame = LabelFrame,
                    Section = SectionFrame,
                    SectionItems = SectionItems
                })

                local API = {
                    Set = function(selfOrText, maybeText)
                        local text
                        if maybeText ~= nil then text = maybeText else text = selfOrText end
                        Label.Text = tostring(text or "")
                    end,
                    Get = function() return Label.Text end
                }
                API.SetText = API.Set
                API.SetValue = API.Set
                API.GetText = API.Get
                API.GetValue = API.Get
                return API
            end

            function SectionAPI:CreateParagraph(paraData)
                paraData = paraData or {}
                local title = paraData.Title or "Paragraph"
                local content = paraData.Content or paraData.Desc or "Description text goes here..."
                local icon = paraData.Icon or "Type"

                local ParaFrame = Create("Frame", {
                    Parent = SectionItems,
                    Size = UDim2.new(1, 0, 0, 0),
                    AutomaticSize = Enum.AutomaticSize.Y,
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    LayoutOrder = #SectionItems:GetChildren(),
                    ClipsDescendants = false,
                    ZIndex = 18
                })
                Create("UICorner", {CornerRadius = UDim.new(0, 5), Parent = ParaFrame})
                Create("UIStroke", {
                    Color = Color3.fromRGB(0, 140, 255),
                    Thickness = 1,
                    Transparency = 0.85,
                    Parent = ParaFrame
                })

                Create("ImageLabel", {
                    Parent = ParaFrame,
                    Size = UDim2.new(0, 14, 0, 14),
                    Position = UDim2.new(0, 7, 0, 8),
                    BackgroundTransparency = 1,
                    Image = GetIcon(icon),
                    ImageColor3 = CurrentTheme.Accent,
                    ZIndex = 19
                })

                local TitleLabel = Create("TextLabel", {
                    Parent = ParaFrame,
                    Size = UDim2.new(1, -26, 0, 14),
                    Position = UDim2.new(0, 22, 0, 4),
                    BackgroundTransparency = 1,
                    Text = title,
                    TextColor3 = CurrentTheme.Text,
                    TextSize = 11,
                    Font = Enum.Font.GothamBold,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextWrapped = true,
                    ClipsDescendants = true,
                    ZIndex = 19
                })

                local ContentLabel = Create("TextLabel", {
                    Parent = ParaFrame,
                    Size = UDim2.new(1, -14, 0, 0),
                    Position = UDim2.new(0, 7, 0, 24),
                    BackgroundTransparency = 1,
                    Text = content,
                    TextColor3 = CurrentTheme.SubText,
                    TextSize = 11,
                    Font = Enum.Font.Gotham,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextWrapped = true,
                    RichText = true,
                    AutomaticSize = Enum.AutomaticSize.Y,
                    ZIndex = 19
                })

                local function RefreshSize()
                    task.wait()
                    if not ParaFrame or not ParaFrame.Parent then return end
                    local width = math.max(ParaFrame.AbsoluteSize.X - 18, 50)
                    if width > 0 then
                        local bounds = TextService:GetTextSize(ContentLabel.Text, ContentLabel.TextSize, ContentLabel.Font, Vector2.new(width, math.huge))
                        local newHeight = 28 + bounds.Y + 10
                        ParaFrame.Size = UDim2.new(1, 0, 0, newHeight)
                    end
                    UpdateSize(false)
                end

                task.defer(RefreshSize)
                ContentLabel:GetPropertyChangedSignal("Text"):Connect(RefreshSize)
                ParaFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
                    if ParaFrame.AbsoluteSize.X > 0 then
                        RefreshSize()
                    end
                end)

                task.spawn(function()
                    for i = 1, 5 do
                        task.wait(0.1)
                        if not ParaFrame or not ParaFrame.Parent then break end
                        RefreshSize()
                    end
                end)

                ListenTheme(function(theme)
                    if not ParaFrame or not ParaFrame.Parent then return end
                    ParaFrame.BackgroundColor3 = theme.Background
                    if TitleLabel and TitleLabel.Parent then TitleLabel.TextColor3 = theme.Text end
                    if ContentLabel and ContentLabel.Parent then ContentLabel.TextColor3 = theme.SubText end
                end)

                table.insert(RegisteredFeatures, {
                    Name = title,
                    Desc = content,
                    Frame = ParaFrame,
                    Section = SectionFrame,
                    SectionItems = SectionItems
                })

                local API = {
                    SetTitle = function(selfOrT, maybeT)
                        local t
                        if maybeT ~= nil then t = maybeT else t = selfOrT end
                        TitleLabel.Text = tostring(t or "")
                    end,
                    SetContent = function(selfOrC, maybeC)
                        local c
                        if maybeC ~= nil then c = maybeC else c = selfOrC end
                        ContentLabel.Text = tostring(c or "")
                    end,
                    SetDesc = function(selfOrC, maybeC)
                        local c
                        if maybeC ~= nil then c = maybeC else c = selfOrC end
                        ContentLabel.Text = tostring(c or "")
                    end,
                    GetContent = function() return ContentLabel.Text end,
                    GetTitle = function() return TitleLabel.Text end,
                }
                API.Set = API.SetContent
                API.Get = API.GetContent
                return API
            end

            function SectionAPI:CreateColorPicker(pickerData)
                pickerData = pickerData or {}
                local pickerName = pickerData.Name or "Color"
                local pickerIcon = pickerData.Icon or "Palette"
                local default = pickerData.Default or Color3.fromRGB(0, 140, 255)
                local callback = pickerData.Callback or function() end
                local desc = pickerData.Desc

                local hasDesc = desc and desc ~= ""
                local frameHeight = hasDesc and 42 or 28

                local PickerFrame = Create("Frame", {
                    Parent = SectionItems,
                    Size = UDim2.new(1, 0, 0, frameHeight),
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    LayoutOrder = #SectionItems:GetChildren(),
                    ZIndex = 18
                })
                Create("UICorner", {CornerRadius = UDim.new(0, 5), Parent = PickerFrame})

                Create("ImageLabel", {
                    Parent = PickerFrame,
                    Size = UDim2.new(0, 14, 0, 14),
                    Position = UDim2.new(0, 7, 0, hasDesc and 5 or 5),
                    BackgroundTransparency = 1,
                    Image = GetIcon(pickerIcon),
                    ImageColor3 = CurrentTheme.SubText,
                    ZIndex = 19
                })

                Create("TextLabel", {
                    Parent = PickerFrame,
                    Size = UDim2.new(0, 110, 0, 14),
                    Position = UDim2.new(0, 22, 0, hasDesc and 1 or 3),
                    BackgroundTransparency = 1,
                    Text = pickerName,
                    TextColor3 = CurrentTheme.Text,
                    TextSize = 11,
                    Font = Enum.Font.Gotham,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    ZIndex = 19
                })

                if hasDesc then
                    Create("TextLabel", {
                        Parent = PickerFrame,
                        Size = UDim2.new(1, -70, 0, 10),
                        Position = UDim2.new(0, 22, 0, 13),
                        BackgroundTransparency = 1,
                        Text = desc,
                        TextColor3 = CurrentTheme.SubText,
                        TextSize = 11,
                        Font = Enum.Font.Gotham,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        TextWrapped = true,
                        AutomaticSize = Enum.AutomaticSize.Y,
                        ZIndex = 19
                    })
                end

                local ColorPreview = Create("TextButton", {
                    Parent = PickerFrame,
                    Size = UDim2.new(0, 36, 0, 22),
                    Position = UDim2.new(1, -44, 0, hasDesc and 8 or 3),
                    BackgroundColor3 = default,
                    Text = "",
                    AutoButtonColor = false,
                    ZIndex = 19
                })
                Create("UICorner", {CornerRadius = UDim.new(0, 5), Parent = ColorPreview})
                Create("UIStroke", {Color = CurrentTheme.Border, Thickness = 1, Parent = ColorPreview})

                local selectedColor = default

                local ColorModal = Create("Frame", {
                    Name = "ColorPickerModal",
                    Parent = MainFrame,
                    Size = UDim2.new(0, 220, 0, 150),
                    Position = UDim2.new(0.5, -110, 0.5, -75),
                    BackgroundColor3 = CurrentTheme.Background,
                    BorderSizePixel = 0,
                    Visible = false,
                    ClipsDescendants = true,
                    Active = true,
                    ZIndex = 250
                })
                Create("UICorner", {CornerRadius = UDim.new(0, 8), Parent = ColorModal})
                Create("UIStroke", {Color = CurrentTheme.Accent, Thickness = 1, Parent = ColorModal})

                local ModalTitle = Create("TextLabel", {
                    Parent = ColorModal,
                    Size = UDim2.new(1, -20, 0, 22),
                    Position = UDim2.new(0, 10, 0, 6),
                    BackgroundTransparency = 1,
                    Text = pickerName .. " - Color Picker",
                    TextColor3 = CurrentTheme.Text,
                    TextSize = 11,
                    Font = Enum.Font.GothamBold,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    ZIndex = 251
                })

                local PaletteGrid = Create("Frame", {
                    Parent = ColorModal,
                    Size = UDim2.new(1, -20, 0, 48),
                    Position = UDim2.new(0, 10, 0, 30),
                    BackgroundTransparency = 1,
                    ZIndex = 251
                })
                Create("UIGridLayout", {
                    Parent = PaletteGrid,
                    CellSize = UDim2.new(0, 26, 0, 20),
                    CellPadding = UDim2.new(0, 3, 0, 3),
                    SortOrder = Enum.SortOrder.LayoutOrder
                })

                local presetColors = {
                    Color3.fromRGB(255, 255, 255),
                    Color3.fromRGB(180, 180, 185),
                    Color3.fromRGB(50, 50, 55),
                    Color3.fromRGB(0, 0, 0),
                    Color3.fromRGB(240, 60, 60),
                    Color3.fromRGB(255, 140, 0),
                    Color3.fromRGB(255, 215, 0),
                    Color3.fromRGB(40, 200, 80),
                    Color3.fromRGB(0, 140, 255),
                    Color3.fromRGB(120, 80, 255),
                    Color3.fromRGB(230, 60, 200),
                    Color3.fromRGB(0, 220, 220)
                }

                local LiveBox = Create("Frame", {
                    Parent = ColorModal,
                    Size = UDim2.new(0, 30, 0, 24),
                    Position = UDim2.new(0, 10, 0, 84),
                    BackgroundColor3 = default,
                    ZIndex = 251
                })
                Create("UICorner", {CornerRadius = UDim.new(0, 4), Parent = LiveBox})
                Create("UIStroke", {Color = CurrentTheme.Border, Thickness = 1, Parent = LiveBox})

                local RInput = Create("TextBox", {
                    Parent = ColorModal,
                    Size = UDim2.new(0, 45, 0, 24),
                    Position = UDim2.new(0, 46, 0, 84),
                    BackgroundColor3 = CurrentTheme.Element,
                    Text = tostring(math.round(default.R * 255)),
                    PlaceholderText = "R",
                    TextColor3 = CurrentTheme.Text,
                    TextSize = 11,
                    Font = Enum.Font.Gotham,
                    ClearTextOnFocus = false,
                    ZIndex = 251
                })
                Create("UICorner", {CornerRadius = UDim.new(0, 4), Parent = RInput})

                local GInput = Create("TextBox", {
                    Parent = ColorModal,
                    Size = UDim2.new(0, 45, 0, 24),
                    Position = UDim2.new(0, 96, 0, 84),
                    BackgroundColor3 = CurrentTheme.Element,
                    Text = tostring(math.round(default.G * 255)),
                    PlaceholderText = "G",
                    TextColor3 = CurrentTheme.Text,
                    TextSize = 11,
                    Font = Enum.Font.Gotham,
                    ClearTextOnFocus = false,
                    ZIndex = 251
                })
                Create("UICorner", {CornerRadius = UDim.new(0, 4), Parent = GInput})

                local BInput = Create("TextBox", {
                    Parent = ColorModal,
                    Size = UDim2.new(0, 45, 0, 24),
                    Position = UDim2.new(0, 146, 0, 84),
                    BackgroundColor3 = CurrentTheme.Element,
                    Text = tostring(math.round(default.B * 255)),
                    PlaceholderText = "B",
                    TextColor3 = CurrentTheme.Text,
                    TextSize = 11,
                    Font = Enum.Font.Gotham,
                    ClearTextOnFocus = false,
                    ZIndex = 251
                })
                Create("UICorner", {CornerRadius = UDim.new(0, 4), Parent = BInput})

                local function UpdateInputs(c)
                    selectedColor = c
                    LiveBox.BackgroundColor3 = c
                    RInput.Text = tostring(math.round(c.R * 255))
                    GInput.Text = tostring(math.round(c.G * 255))
                    BInput.Text = tostring(math.round(c.B * 255))
                end

                for _, pColor in ipairs(presetColors) do
                    local pBtn = Create("TextButton", {
                        Parent = PaletteGrid,
                        BackgroundColor3 = pColor,
                        Text = "",
                        AutoButtonColor = false,
                        ZIndex = 252
                    })
                    Create("UICorner", {CornerRadius = UDim.new(0, 4), Parent = pBtn})
                    Create("UIStroke", {Color = Color3.fromRGB(40, 40, 45), Thickness = 1, Parent = pBtn})

                    local function ChooseColor()
                        UpdateInputs(pColor)
                    end
                    ConnectButton(pBtn, ChooseColor)
                end

                local function ReadInputs()
                    local r = math.clamp(tonumber(RInput.Text) or 0, 0, 255)
                    local g = math.clamp(tonumber(GInput.Text) or 0, 0, 255)
                    local b = math.clamp(tonumber(BInput.Text) or 0, 0, 255)
                    return Color3.fromRGB(r, g, b)
                end

                RInput.FocusLost:Connect(function() UpdateInputs(ReadInputs()) end)
                GInput.FocusLost:Connect(function() UpdateInputs(ReadInputs()) end)
                BInput.FocusLost:Connect(function() UpdateInputs(ReadInputs()) end)

                local ApplyBtn = Create("TextButton", {
                    Parent = ColorModal,
                    Size = UDim2.new(0, 92, 0, 26),
                    Position = UDim2.new(0, 10, 1, -34),
                    BackgroundColor3 = Color3.fromRGB(30, 110, 220),
                    Text = "Apply",
                    TextColor3 = Color3.fromRGB(255, 255, 255),
                    TextSize = 11,
                    Font = Enum.Font.GothamBold,
                    AutoButtonColor = false,
                    ZIndex = 252
                })
                Create("UICorner", {CornerRadius = UDim.new(0, 5), Parent = ApplyBtn})

                ApplyBtn.MouseEnter:Connect(function()
                    Tween(ApplyBtn, {BackgroundColor3 = Color3.fromRGB(50, 140, 255)}, 0.15)
                end)
                ApplyBtn.MouseLeave:Connect(function()
                    Tween(ApplyBtn, {BackgroundColor3 = Color3.fromRGB(30, 110, 220)}, 0.15)
                end)

                local CancelBtn = Create("TextButton", {
                    Parent = ColorModal,
                    Size = UDim2.new(0, 92, 0, 26),
                    Position = UDim2.new(1, -102, 1, -34),
                    BackgroundColor3 = CurrentTheme.Element,
                    Text = "Cancel",
                    TextColor3 = CurrentTheme.Text,
                    TextSize = 11,
                    Font = Enum.Font.GothamBold,
                    AutoButtonColor = false,
                    ZIndex = 252
                })
                Create("UICorner", {CornerRadius = UDim.new(0, 5), Parent = CancelBtn})

                local function OpenColorPicker()
                    CloseAllDropdowns()
                    UpdateInputs(selectedColor)
                    if ResizeHandle then ResizeHandle.Visible = false end
                    ColorModal.Visible = true
                    ActiveColorModal = ColorModal
                    DropdownOverlay.Visible = true
                    DropdownOverlay.BackgroundTransparency = 0.5
                end

                local function CloseColorPickerModal()
                    ColorModal.Visible = false
                    ActiveColorModal = nil
                    if DropdownOverlay and (not CurrentDropdownState or not CurrentDropdownState.IsOpen) then
                        DropdownOverlay.Visible = false
                        DropdownOverlay.BackgroundTransparency = 1
                    end
                    if ResizeHandle then ResizeHandle.Visible = true end
                end

                ConnectButton(ColorPreview, OpenColorPicker)

                local flag = pickerData.Flag or pickerData.Name or "ColorPicker"
                local configKey = sectionName .. "/" .. flag

                local function DoApplyColor()
                    local finalColor = ReadInputs()
                    selectedColor = finalColor
                    ColorPreview.BackgroundColor3 = finalColor
                    if ActiveConfigManager then
                        ActiveConfigManager:Set(configKey, {R = finalColor.R, G = finalColor.G, B = finalColor.B})
                    end
                    callback(finalColor)
                    CloseColorPickerModal()
                end

                ConnectButton(ApplyBtn, DoApplyColor)

                ConnectButton(CancelBtn, CloseColorPickerModal)

                ListenTheme(function(theme)
                    if not PickerFrame or not PickerFrame.Parent then return end
                    PickerFrame.BackgroundColor3 = theme.Background
                    ColorModal.BackgroundColor3 = theme.Background
                    ModalTitle.TextColor3 = theme.Text
                    RInput.BackgroundColor3 = theme.Element
                    RInput.TextColor3 = theme.Text
                    GInput.BackgroundColor3 = theme.Element
                    GInput.TextColor3 = theme.Text
                    BInput.BackgroundColor3 = theme.Element
                    BInput.TextColor3 = theme.Text
                    CancelBtn.BackgroundColor3 = theme.Element
                    CancelBtn.TextColor3 = theme.Text
                end)

                table.insert(RegisteredFeatures, {
                    Name = pickerName,
                    Desc = desc,
                    Frame = PickerFrame,
                    Section = SectionFrame,
                    SectionItems = SectionItems
                })

                local API = {
                    Set = function(selfOrC, maybeC)
                        local c
                        if maybeC ~= nil then c = maybeC else c = selfOrC end
                        if type(c) == "table" and c.R and c.G and c.B and not c.ClassName then
                            c = Color3.new(c.R, c.G, c.B)
                        end
                        selectedColor = c
                        ColorPreview.BackgroundColor3 = c
                        if ActiveConfigManager then
                            ActiveConfigManager:Set(configKey, {R = c.R, G = c.G, B = c.B})
                        end
                        callback(c)
                    end,
                    Get = function() return selectedColor end
                }
                API.SetValue = API.Set
                API.SetColor = API.Set
                API.GetValue = API.Get
                API.GetColor = API.Get

                if ActiveConfigManager then
                    ActiveConfigManager:BindElement(configKey, "ColorPicker", function()
                        return {R = selectedColor.R, G = selectedColor.G, B = selectedColor.B}
                    end, function(val)
                        if type(val) == "table" and val.R and val.G and val.B then
                            local col = Color3.new(val.R, val.G, val.B)
                            selectedColor = col
                            ColorPreview.BackgroundColor3 = col
                            callback(col)
                        end
                    end)
                end

                return API
            end

            function SectionAPI:CreateDivider()
                local Divider = Create("Frame", {
                    Parent = SectionItems,
                    Size = UDim2.new(1, -8, 0, 1),
                    Position = UDim2.new(0, 4, 0, 0),
                    BackgroundColor3 = CurrentTheme.Border,
                    BorderSizePixel = 0,
                    LayoutOrder = #SectionItems:GetChildren(),
                    ZIndex = 18
                })

                ListenTheme(function(theme)
                    if not Divider or not Divider.Parent then return end
                    Divider.BackgroundColor3 = theme.Border
                end)

                return self
            end

            function SectionAPI:CreateStatus(statusData)
                statusData = statusData or {}
                local statusText = statusData.Text or "Status"
                local statusIcon = statusData.Icon or "Check"
                local statusColor = statusData.Color or CurrentTheme.Success

                local StatusFrame = Create("Frame", {
                    Parent = SectionItems,
                    Size = UDim2.new(1, 0, 0, 26),
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    LayoutOrder = #SectionItems:GetChildren(),
                    ClipsDescendants = true,
                    ZIndex = 18
                })
                Create("UICorner", {CornerRadius = UDim.new(0, 4), Parent = StatusFrame})

                local StatusLayout = Create("UIListLayout", {
                    Parent = StatusFrame,
                    FillDirection = Enum.FillDirection.Horizontal,
                    HorizontalAlignment = Enum.HorizontalAlignment.Left,
                    VerticalAlignment = Enum.VerticalAlignment.Center,
                    Padding = UDim.new(0, 6),
                    SortOrder = Enum.SortOrder.LayoutOrder
                })

                Create("UIPadding", {
                    Parent = StatusFrame,
                    PaddingLeft = UDim.new(0, 8)
                })

                local Dot = Create("Frame", {
                    Parent = StatusFrame,
                    Size = UDim2.new(0, 8, 0, 8),
                    BackgroundColor3 = statusColor,
                    BorderSizePixel = 0,
                    LayoutOrder = 1,
                    ZIndex = 19
                })
                Create("UICorner", {CornerRadius = UDim.new(1, 0), Parent = Dot})

                local IconImg = Create("ImageLabel", {
                    Parent = StatusFrame,
                    Size = UDim2.new(0, 14, 0, 14),
                    BackgroundTransparency = 1,
                    Image = GetIcon(statusIcon),
                    ImageColor3 = statusColor,
                    ScaleType = Enum.ScaleType.Fit,
                    LayoutOrder = 2,
                    ZIndex = 19
                })

                local StatusLabel = Create("TextLabel", {
                    Parent = StatusFrame,
                    Size = UDim2.new(0, 0, 1, 0),
                    AutomaticSize = Enum.AutomaticSize.X,
                    BackgroundTransparency = 1,
                    Text = statusText,
                    TextColor3 = CurrentTheme.Text,
                    TextSize = 11,
                    Font = Enum.Font.GothamMedium,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    LayoutOrder = 3,
                    ZIndex = 19
                })

                table.insert(RegisteredFeatures, {
                    Name = statusText,
                    Desc = nil,
                    Frame = StatusFrame,
                    Section = SectionFrame,
                    SectionItems = SectionItems
                })

                ListenTheme(function(theme)
                    if not StatusFrame or not StatusFrame.Parent then return end
                    StatusFrame.BackgroundColor3 = theme.Background
                    StatusLabel.TextColor3 = theme.Text
                end)

                local StatusAPI = {}
                function StatusAPI.Set(selfOrData, maybeData)
                    local data
                    if maybeData ~= nil then data = maybeData else data = selfOrData end
                    if type(data) == "string" then
                        StatusLabel.Text = data
                    elseif type(data) == "table" then
                        if data.Text then StatusLabel.Text = tostring(data.Text) end
                        if data.Color then
                            Dot.BackgroundColor3 = data.Color
                            IconImg.ImageColor3 = data.Color
                        end
                        if data.Icon then IconImg.Image = GetIcon(data.Icon) end
                    end
                end
                function StatusAPI.SetText(selfOrT, maybeT)
                    local t
                    if maybeT ~= nil then t = maybeT else t = selfOrT end
                    StatusLabel.Text = tostring(t or "")
                end
                function StatusAPI.SetColor(selfOrC, maybeC)
                    local c
                    if maybeC ~= nil then c = maybeC else c = selfOrC end
                    Dot.BackgroundColor3 = c
                    IconImg.ImageColor3 = c
                end
                function StatusAPI.SetIcon(selfOrI, maybeI)
                    local i
                    if maybeI ~= nil then i = maybeI else i = selfOrI end
                    IconImg.Image = GetIcon(i)
                end
                function StatusAPI.Get() return StatusLabel.Text end
                function StatusAPI.GetText() return StatusLabel.Text end
                return StatusAPI
            end

            function SectionAPI:CreateQuestList(questData)
                questData = questData or {}
                local questTitle = questData.Title or "Quests"
                local questIcon = questData.Icon or "Target"
                local quests = questData.Quests or {}
                local callback = questData.Callback or function() end

                local QuestFrame = Create("Frame", {
                    Parent = SectionItems,
                    Size = UDim2.new(1, 0, 0, 44),
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    LayoutOrder = #SectionItems:GetChildren(),
                    ClipsDescendants = true,
                    ZIndex = 18
                })
                Create("UICorner", {CornerRadius = UDim.new(0, 5), Parent = QuestFrame})

                Create("ImageLabel", {
                    Parent = QuestFrame,
                    Size = UDim2.new(0, 16, 0, 16),
                    Position = UDim2.new(0, 7, 0, 8),
                    BackgroundTransparency = 1,
                    Image = GetIcon(questIcon),
                    ImageColor3 = CurrentTheme.Accent,
                    ZIndex = 19
                })

                Create("TextLabel", {
                    Parent = QuestFrame,
                    Size = UDim2.new(1, -30, 0, 18),
                    Position = UDim2.new(0, 24, 0, 4),
                    BackgroundTransparency = 1,
                    Text = questTitle,
                    TextColor3 = CurrentTheme.Text,
                    TextSize = 12,
                    Font = Enum.Font.GothamBold,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    ZIndex = 19
                })

                local QuestList = Create("Frame", {
                    Parent = QuestFrame,
                    Size = UDim2.new(1, -12, 0, 0),
                    Position = UDim2.new(0, 6, 0, 28),
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    ZIndex = 17
                })
                Create("UIListLayout", {
                    Parent = QuestList,
                    Padding = UDim.new(0, 4),
                    SortOrder = Enum.SortOrder.LayoutOrder
                })

                local questItems = {}
                local questHeight = 0

                local function BuildQuests()
                    for _, item in ipairs(questItems) do
                        if item and item.Frame then item.Frame:Destroy() end
                    end
                    questItems = {}
                    questHeight = 0

                    for _, quest in ipairs(quests) do
                        local qName = quest.Name or "Quest"
                        local qIcon = quest.Icon or "Check"
                        local qCompleted = quest.Completed or false

                        local qFrame = Create("Frame", {
                            Parent = QuestList,
                            Size = UDim2.new(1, 0, 0, 28),
                            BackgroundColor3 = CurrentTheme.Element,
                            BorderSizePixel = 0,
                            LayoutOrder = #questItems,
                            ZIndex = 20
                        })
                        Create("UICorner", {CornerRadius = UDim.new(0, 4), Parent = qFrame})

                        local checkBox = Create("Frame", {
                            Parent = qFrame,
                            Size = UDim2.new(0, 18, 0, 18),
                            Position = UDim2.new(0, 6, 0.5, -9),
                            BackgroundColor3 = CurrentTheme.Background,
                            BorderSizePixel = 0,
                            ZIndex = 21
                        })
                        Create("UICorner", {CornerRadius = UDim.new(0, 4), Parent = checkBox})

                        local checkMark = Create("ImageLabel", {
                            Parent = checkBox,
                            Size = UDim2.new(0, 14, 0, 14),
                            Position = UDim2.new(0.5, -7, 0.5, -7),
                            BackgroundTransparency = 1,
                            Image = GetIcon("Check"),
                            ImageColor3 = CurrentTheme.Success,
                            ZIndex = 22,
                            Visible = qCompleted
                        })

                        local qIconImg = Create("ImageLabel", {
                            Parent = qFrame,
                            Size = UDim2.new(0, 16, 0, 16),
                            Position = UDim2.new(0, 28, 0.5, -8),
                            BackgroundTransparency = 1,
                            Image = GetIcon(qIcon),
                            ImageColor3 = qCompleted and CurrentTheme.Success or CurrentTheme.SubText,
                            ZIndex = 21
                        })

                        local qLabel = Create("TextLabel", {
                            Parent = qFrame,
                            Size = UDim2.new(1, -52, 0, 18),
                            Position = UDim2.new(0, 48, 0, 0),
                            BackgroundTransparency = 1,
                            Text = qName,
                            TextColor3 = qCompleted and CurrentTheme.Success or CurrentTheme.Text,
                            TextSize = 11,
                            Font = Enum.Font.Gotham,
                            TextXAlignment = Enum.TextXAlignment.Left,
                            ZIndex = 21
                        })

                        local qBtn = Create("TextButton", {
                            Parent = qFrame,
                            Size = UDim2.new(1, 0, 1, 0),
                            BackgroundTransparency = 1,
                            Text = "",
                            ZIndex = 25
                        })

                        qBtn.MouseButton1Click:Connect(function()
                            qCompleted = not qCompleted
                            checkMark.Visible = qCompleted
                            qLabel.TextColor3 = qCompleted and CurrentTheme.Success or CurrentTheme.Text
                            if qIconImg and qIconImg.Parent then
                                qIconImg.ImageColor3 = qCompleted and CurrentTheme.Success or CurrentTheme.SubText
                            end
                            callback(qName, qCompleted)
                        end)

                        table.insert(questItems, {
                            Frame = qFrame,
                            Name = qName,
                            SetCompleted = function(state)
                                qCompleted = state
                                checkMark.Visible = qCompleted
                                qLabel.TextColor3 = qCompleted and CurrentTheme.Success or CurrentTheme.Text
                                if qIconImg and qIconImg.Parent then
                                    qIconImg.ImageColor3 = qCompleted and CurrentTheme.Success or CurrentTheme.SubText
                                end
                            end,
                            IsCompleted = function() return qCompleted end
                        })
                        questHeight = questHeight + 32
                    end

                    QuestFrame.Size = UDim2.new(1, 0, 0, 36 + questHeight)
                    QuestList.Size = UDim2.new(1, 0, 0, questHeight)
                    UpdateSize(false)
                end

                BuildQuests()

                ListenTheme(function(theme)
                    if not QuestFrame or not QuestFrame.Parent then return end
                    QuestFrame.BackgroundColor3 = theme.Background
                    for _, item in ipairs(questItems) do
                        if item.Frame and item.Frame.Parent then
                            item.Frame.BackgroundColor3 = theme.Element
                        end
                    end
                end)

                local QuestAPI = {}
                function QuestAPI.SetQuests(selfOrQ, maybeQ)
                    local newQuests
                    if maybeQ ~= nil then newQuests = maybeQ else newQuests = selfOrQ end
                    quests = newQuests or {}
                    BuildQuests()
                end
                function QuestAPI.Complete(selfOrName, maybeName)
                    local name
                    if maybeName ~= nil then name = maybeName else name = selfOrName end
                    for _, item in ipairs(questItems) do
                        if item.Name == name then
                            item.SetCompleted(true)
                            break
                        end
                    end
                end
                function QuestAPI.Uncomplete(selfOrName, maybeName)
                    local name
                    if maybeName ~= nil then name = maybeName else name = selfOrName end
                    for _, item in ipairs(questItems) do
                        if item.Name == name then
                            item.SetCompleted(false)
                            break
                        end
                    end
                end
                function QuestAPI.IsComplete(selfOrName, maybeName)
                    local name
                    if maybeName ~= nil then name = maybeName else name = selfOrName end
                    for _, item in ipairs(questItems) do
                        if item.Name == name then
                            return item.IsCompleted()
                        end
                    end
                    return false
                end
                function QuestAPI.GetCompleted()
                    local completed = {}
                    for _, item in ipairs(questItems) do
                        if item.IsCompleted() then
                            table.insert(completed, item.Name)
                        end
                    end
                    return completed
                end
                function QuestAPI.Reset()
                    for _, item in ipairs(questItems) do
                        item.SetCompleted(false)
                    end
                end
                table.insert(RegisteredFeatures, {
                    Name = questTitle,
                    Desc = nil,
                    Frame = QuestFrame,
                    Section = SectionFrame,
                    SectionItems = SectionItems
                })

                return QuestAPI
            end

            SectionAPI.Dropdown = SectionAPI.CreateDropdown
            SectionAPI.MultiDropdown = SectionAPI.CreateMultiDropdown
            SectionAPI.Toggle = SectionAPI.CreateToggle
            SectionAPI.Slider = SectionAPI.CreateSlider
            SectionAPI.Button = SectionAPI.CreateButton
            SectionAPI.ButtonRow = SectionAPI.CreateButtonRow
            SectionAPI.Input = SectionAPI.CreateInput
            SectionAPI.Keybind = SectionAPI.CreateKeybind
            SectionAPI.Label = SectionAPI.CreateLabel
            SectionAPI.Paragraph = SectionAPI.CreateParagraph
            SectionAPI.ColorPicker = SectionAPI.CreateColorPicker
            SectionAPI.Divider = SectionAPI.CreateDivider
            SectionAPI.Status = SectionAPI.CreateStatus
            SectionAPI.QuestList = SectionAPI.CreateQuestList

            return SectionAPI
        end

        
        function TabAPI:Section(data)
            local sec = self:CreateSection(data)
            self._CurrentSection = sec
            return sec
        end

        function TabAPI:Paragraph(data)
            if not self._CurrentSection then self:Section({Name = "Default", Opened = true}) end
            return self._CurrentSection:CreateParagraph(data)
        end

        function TabAPI:Button(data)
            if not self._CurrentSection then self:Section({Name = "Default", Opened = true}) end
            return self._CurrentSection:CreateButton(data)
        end

        function TabAPI:ButtonRow(data)
            if not self._CurrentSection then self:Section({Name = "Default", Opened = true}) end
            return self._CurrentSection:CreateButtonRow(data)
        end

        function TabAPI:Toggle(data)
            if not self._CurrentSection then self:Section({Name = "Default", Opened = true}) end
            return self._CurrentSection:CreateToggle(data)
        end

        function TabAPI:Slider(data)
            if not self._CurrentSection then self:Section({Name = "Default", Opened = true}) end
            return self._CurrentSection:CreateSlider(data)
        end

        function TabAPI:Dropdown(data)
            if not self._CurrentSection then self:Section({Name = "Default", Opened = true}) end
            return self._CurrentSection:CreateDropdown(data)
        end

        function TabAPI:MultiDropdown(data)
            if not self._CurrentSection then self:Section({Name = "Default", Opened = true}) end
            return self._CurrentSection:CreateMultiDropdown(data)
        end

        function TabAPI:Input(data)
            if not self._CurrentSection then self:Section({Name = "Default", Opened = true}) end
            return self._CurrentSection:CreateInput(data)
        end

        function TabAPI:Keybind(data)
            if not self._CurrentSection then self:Section({Name = "Default", Opened = true}) end
            return self._CurrentSection:CreateKeybind(data)
        end

        function TabAPI:Label(data)
            if not self._CurrentSection then self:Section({Name = "Default", Opened = true}) end
            return self._CurrentSection:CreateLabel(data)
        end

        function TabAPI:ColorPicker(data)
            if not self._CurrentSection then self:Section({Name = "Default", Opened = true}) end
            return self._CurrentSection:CreateColorPicker(data)
        end

        function TabAPI:Divider()
            if not self._CurrentSection then self:Section({Name = "Default", Opened = true}) end
            return self._CurrentSection:CreateDivider()
        end

        function TabAPI:Status(data)
            if not self._CurrentSection then self:Section({Name = "Default", Opened = true}) end
            return self._CurrentSection:CreateStatus(data)
        end

        function TabAPI:QuestList(data)
            if not self._CurrentSection then self:Section({Name = "Default", Opened = true}) end
            return self._CurrentSection:CreateQuestList(data)
        end

        TabAPI.CreateDropdown = TabAPI.Dropdown
        TabAPI.CreateMultiDropdown = TabAPI.MultiDropdown
        TabAPI.CreateToggle = TabAPI.Toggle
        TabAPI.CreateSlider = TabAPI.Slider
        TabAPI.CreateButton = TabAPI.Button
        TabAPI.CreateButtonRow = TabAPI.ButtonRow
        TabAPI.CreateInput = TabAPI.Input
        TabAPI.CreateKeybind = TabAPI.Keybind
        TabAPI.CreateLabel = TabAPI.Label
        TabAPI.CreateParagraph = TabAPI.Paragraph
        TabAPI.CreateColorPicker = TabAPI.ColorPicker
        TabAPI.CreateDivider = TabAPI.Divider
        TabAPI.CreateStatus = TabAPI.Status
        TabAPI.CreateQuestList = TabAPI.QuestList

        return TabAPI
    end

    
    SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
        local text = SearchBox.Text:lower():gsub("^%s*(.-)%s*$", "%1")
        if text == "" then
            for _, feat in ipairs(RegisteredFeatures) do
                if feat.Frame and feat.Frame.Parent then
                    feat.Frame.Visible = true
                end
            end
            for _, sec in ipairs(RegisteredSections) do
                if sec.Frame and sec.Frame.Parent then
                    sec.Frame.Visible = true
                    if sec.UpdateSize then sec.UpdateSize() end
                end
            end
        else
            local frameVisibility = {}
            for _, feat in ipairs(RegisteredFeatures) do
                if feat.Frame and feat.Frame.Parent then
                    local match = (feat.Name and tostring(feat.Name):lower():find(text, 1, true) ~= nil) or
                                  (feat.Desc and tostring(feat.Desc):lower():find(text, 1, true) ~= nil)
                    if match then
                        frameVisibility[feat.Frame] = true
                    elseif frameVisibility[feat.Frame] == nil then
                        frameVisibility[feat.Frame] = false
                    end
                end
            end

            for frame, isVis in pairs(frameVisibility) do
                if frame and frame.Parent then
                    frame.Visible = isVis
                end
            end

            for _, sec in ipairs(RegisteredSections) do
                if sec.Frame and sec.Frame.Parent then
                    local anyChildVisible = false
                    for _, child in ipairs(sec.Items:GetChildren()) do
                        if child:IsA("GuiObject") and child.Visible and child.Name ~= "UIListLayout" and child.Name ~= "UIPadding" then
                            anyChildVisible = true
                            break
                        end
                    end
                    sec.Frame.Visible = anyChildVisible
                    if anyChildVisible then
                        if sec.Expand then sec.Expand() end
                        if sec.UpdateSize then sec.UpdateSize() end
                    end
                end
            end
        end
    end)

    WindowAPI.Tab = WindowAPI.CreateTab

    return WindowAPI
end

return W424
