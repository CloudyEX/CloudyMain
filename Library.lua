local cloneref = (cloneref or clonereference or function(instance)
	return instance
end)

local UserInputService = cloneref(game:GetService("UserInputService"))
local TweenService = cloneref(game:GetService("TweenService"))
local CoreGui = cloneref(game:GetService("CoreGui"))
local Players = cloneref(game:GetService("Players"))
local RunService = cloneref(game:GetService("RunService"))
local HttpService = cloneref(game:GetService("HttpService"))
local ReplicatedStorage = cloneref(game:GetService("ReplicatedStorage"))

local LocalPlayer = Players.LocalPlayer

local ConfigFolder = "CloudyConfigs"

local function ensureConfigFolder()
	if type(makefolder) == "function" and type(isfolder) == "function" then
		if not isfolder(ConfigFolder) then
			pcall(makefolder, ConfigFolder)
		end
	end
end

local MemoryConfigs = {}

local function SaveConfigFile(filename, textData)
	ensureConfigFolder()
	local path = ConfigFolder .. "/" .. filename .. ".json"
	if type(writefile) == "function" then
		pcall(writefile, path, textData)
	else
		MemoryConfigs[filename] = textData
	end
end

local function ReadConfigFile(filename)
	ensureConfigFolder()
	local path = ConfigFolder .. "/" .. filename .. ".json"
	if type(readfile) == "function" and type(isfile) == "function" and isfile(path) then
		local ok, data = pcall(readfile, path)
		if ok then return data end
	elseif MemoryConfigs[filename] then
		return MemoryConfigs[filename]
	end
	return nil
end

local function DeleteConfigFile(filename)
	ensureConfigFolder()
	local path = ConfigFolder .. "/" .. filename .. ".json"
	if type(delfile) == "function" and type(isfile) == "function" and isfile(path) then
		pcall(delfile, path)
	end
	MemoryConfigs[filename] = nil
end

local function DeleteAllConfigFiles()
	ensureConfigFolder()
	if type(listfiles) == "function" and type(isfolder) == "function" and isfolder(ConfigFolder) then
		local ok, files = pcall(listfiles, ConfigFolder)
		if ok and type(files) == "table" then
			for _, filePath in ipairs(files) do
				if type(delfile) == "function" then
					pcall(delfile, filePath)
				end
			end
		end
	end
	MemoryConfigs = {}
end

local function ListConfigNames()
	ensureConfigFolder()
	local names = {}
	if type(listfiles) == "function" and type(isfolder) == "function" and isfolder(ConfigFolder) then
		local ok, files = pcall(listfiles, ConfigFolder)
		if ok and type(files) == "table" then
			for _, filePath in ipairs(files) do
				local name = filePath:match("([^/\\]+)%.json$") or filePath:match("([^/\\]+)$")
				if name then
					table.insert(names, name)
				end
			end
		end
	end
	for memName in pairs(MemoryConfigs) do
		if not table.find(names, memName) then
			table.insert(names, memName)
		end
	end
	if #names == 0 then
		table.insert(names, "Default")
	end
	return names
end

local function GetUrlContent(url, mirrors)
	mirrors = mirrors or {}
	local urls = {url}
	for _, m in ipairs(mirrors) do table.insert(urls, m) end

	for _, targetUrl in ipairs(urls) do
		for attempt = 1, 3 do
			local content = nil
			pcall(function()
				if type(request) == "function" then
					local resp = request({Url = targetUrl, Method = "GET"})
					if resp and resp.Body and #resp.Body > 10 then content = resp.Body end
				elseif type(http_request) == "function" then
					local resp = http_request({Url = targetUrl, Method = "GET"})
					if resp and resp.Body and #resp.Body > 10 then content = resp.Body end
				elseif type(syn) == "table" and type(syn.request) == "function" then
					local resp = syn.request({Url = targetUrl, Method = "GET"})
					if resp and resp.Body and #resp.Body > 10 then content = resp.Body end
				elseif typeof(game) == "Instance" and typeof(game.HttpGet) == "function" then
					local ok, res = pcall(function() return game:HttpGet(targetUrl) end)
					if ok and res and #res > 10 then content = res end
				else
					local ok, res = pcall(function() return HttpService:GetAsync(targetUrl) end)
					if ok and res and #res > 10 then content = res end
				end
			end)
			if content then return content end
			task.wait(0.2)
		end
	end
	return nil
end

local function CompileString(src)
	if not src or type(src) ~= "string" or #src < 10 then
		return nil
	end
	local compiledFn = nil
	if type(loadstring) == "function" then
		local ok, res = pcall(loadstring, src)
		if ok and type(res) == "function" then
			compiledFn = res
		end
	elseif type(getgenv) == "function" and type(getgenv().loadstring) == "function" then
		local ok, res = pcall(getgenv().loadstring, src)
		if ok and type(res) == "function" then
			compiledFn = res
		end
	end
	return compiledFn
end

local function FetchIconPack(url, mirrors)
	local rawSrc = GetUrlContent(url, mirrors)
	if rawSrc then
		local fn = CompileString(rawSrc)
		if type(fn) == "function" then
			local ok, pack = pcall(fn)
			if ok and type(pack) == "table" then
				return pack
			end
		end
	end
	return {}
end

local IconModule = {
	IconsType = "solar",
	New = nil,
	IconThemeTag = nil,

	Icons = {
		solar = {},
		gravity = {},
	},
}

task.spawn(function()
	IconModule.Icons.solar = FetchIconPack(
		"https://raw.githubusercontent.com/Footagesus/Icons/refs/heads/main/solar/dist/Icons.lua",
		{"https://cdn.jsdelivr.net/gh/Footagesus/Icons@main/solar/dist/Icons.lua"}
	) or {}

	IconModule.Icons.gravity = FetchIconPack(
		"https://raw.githubusercontent.com/Footagesus/Icons/refs/heads/main/gravity/dist/Icons.lua",
		{"https://cdn.jsdelivr.net/gh/Footagesus/Icons@main/gravity/dist/Icons.lua"}
	) or {}
end)

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
		return
	end

	if not IconModule.Icons[packName] then
		IconModule.Icons[packName] = {
			Icons = {},
			Spritesheets = {},
		}
	end

	for iconName, iconValue in pairs(iconsData) do
		if type(iconValue) ~= "table" then
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
			end
		end
	end
end

function IconModule.SetIconsType(iconType)
	IconModule.IconsType = iconType
end

function IconModule.Init(New, IconThemeTag)
	IconModule.New = New
	IconModule.IconThemeTag = IconThemeTag
	return IconModule
end

function IconModule.Icon(Icon, Type, DefaultFormat)
	DefaultFormat = DefaultFormat ~= false
	local iconType, iconName = parseIconString(Icon)

	local targetType = iconType or Type or IconModule.IconsType
	local targetName = iconName

	if not targetName or targetName == "" then return nil end

	local iconSet = IconModule.Icons[targetType]
	if not iconSet then return nil end

	if type(iconSet.Icons) == "table" and iconSet.Icons[targetName] then
		local item = iconSet.Icons[targetName]
		local sheet = (type(iconSet.Spritesheets) == "table" and iconSet.Spritesheets[tostring(item.Image)]) or item.Image
		return { sheet, item }
	end

	local resolvedAsset = nil

	if type(iconSet[targetName]) == "string" and string.find(iconSet[targetName], "rbxassetid://") then
		resolvedAsset = iconSet[targetName]
	end

	if not resolvedAsset and targetType == "solar" then
		local boldName = (targetName:sub(-5) == "-bold") and targetName or (targetName .. "-bold")
		if type(iconSet[boldName]) == "string" and string.find(iconSet[boldName], "rbxassetid://") then
			resolvedAsset = iconSet[boldName]
		end

		if not resolvedAsset then
			local suffixes = {"-linear", "-outline", "-broken", "-line-duotone", "-bold-duotone"}
			for _, s in ipairs(suffixes) do
				if type(iconSet[targetName .. s]) == "string" and string.find(iconSet[targetName .. s], "rbxassetid://") then
					resolvedAsset = iconSet[targetName .. s]
					break
				end
			end
		end
	end

	if not resolvedAsset then
		local aliases = {
			["minus"] = "minus",
			["maximize"] = "chevrons-expand-up-right",
			["close"] = "xmark",
			["x"] = "xmark",
			["alt-arrow-down"] = "alt-arrow-down-bold",
			["home"] = "home-2-bold",
			["home-2"] = "home-2-bold",
			["user"] = "user-bold",
			["eye"] = "eye-bold",
			["compass"] = "compass-bold",
			["server"] = "server-bold",
			["settings"] = "settings-bold",
			["cloud"] = "cloud-bold",
		}
		if aliases[targetName] and type(iconSet[aliases[targetName]]) == "string" then
			resolvedAsset = iconSet[aliases[targetName]]
		end
	end

	if not resolvedAsset then
		for k, v in pairs(iconSet) do
			if type(k) == "string" and k:find(targetName, 1, true) and type(v) == "string" and string.find(v, "rbxassetid://") then
				resolvedAsset = v
				break
			end
		end
	end

	if resolvedAsset then
		return DefaultFormat
				and {
					resolvedAsset,
					{ ImageRectSize = Vector2.new(0, 0), ImageRectPosition = Vector2.new(0, 0) },
				}
			or resolvedAsset
	end

	return nil
end

function IconModule.GetIcon(Icon, Type)
	return IconModule.Icon(Icon, Type, false)
end

function IconModule.Icon2(Icon, Type, DefaultFormat)
	return IconModule.Icon(Icon, Type, true)
end

local function applyIcon(imageLabel, iconName)
	if not imageLabel or not iconName or iconName == "" then
		if imageLabel then imageLabel.Visible = false end
		return
	end

	for _, child in pairs(imageLabel:GetChildren()) do
		if child:IsA("ImageLabel") then child:Destroy() end
	end

	local iconData = IconModule.Icon2(iconName, "solar")
	if iconData then
		if typeof(iconData) == "string" then
			imageLabel.Image = iconData
			imageLabel.ImageRectSize = Vector2.new(0, 0)
			imageLabel.ImageRectOffset = Vector2.new(0, 0)
			imageLabel.Visible = true
		elseif type(iconData) == "table" and iconData[1] and iconData[2] then
			imageLabel.Image = iconData[1]
			imageLabel.ImageRectSize = iconData[2].ImageRectSize or Vector2.new(0, 0)
			imageLabel.ImageRectOffset = iconData[2].ImageRectPosition or iconData[2].ImageRectOffset or Vector2.new(0, 0)
			imageLabel.Visible = true

			if iconData[2].Parts then
				for idx, part in ipairs(iconData[2].Parts) do
					local partData = IconModule.Icon(part, "solar")
					if partData and partData[1] and partData[2] then
						local partLabel = Instance.new("ImageLabel")
						partLabel.Size = UDim2.new(1, 0, 1, 0)
						partLabel.BackgroundTransparency = 1
						partLabel.Image = partData[1]
						partLabel.ImageRectSize = partData[2].ImageRectSize
						partLabel.ImageRectOffset = partData[2].ImageRectPosition or partData[2].ImageRectOffset
						partLabel.Parent = imageLabel
					end
				end
			end
		end
	elseif type(iconName) == "string" and (iconName:sub(1, 13) == "rbxassetid://" or iconName:sub(1, 4) == "http") then
		imageLabel.Image = iconName
		imageLabel.ImageRectSize = Vector2.new(0, 0)
		imageLabel.ImageRectOffset = Vector2.new(0, 0)
		imageLabel.Visible = true
	else
		imageLabel.Visible = false
	end
end

local function createCustomCloud(parentFrame, size, position, scaleFactor)
	scaleFactor = scaleFactor or 1

	local CloudContainer = Instance.new("Frame")
	CloudContainer.Name = "CustomCloud"
	CloudContainer.Size = size
	CloudContainer.Position = position
	CloudContainer.AnchorPoint = Vector2.new(0.5, 0.5)
	CloudContainer.BackgroundTransparency = 1
	CloudContainer.Parent = parentFrame

	local ShadowLayer = Instance.new("Frame")
	ShadowLayer.Name = "ShadowLayer"
	ShadowLayer.Size = UDim2.new(1, 0, 1, 0)
	ShadowLayer.Position = UDim2.new(0, 4 * scaleFactor, 0, 6 * scaleFactor)
	ShadowLayer.BackgroundTransparency = 1
	ShadowLayer.Parent = CloudContainer

	local shadowPuffs = {
		{UDim2.new(0.72, 0, 0.44, 0), UDim2.new(0.14, 0, 0.5, 0)},
		{UDim2.new(0.42, 0, 0.62, 0), UDim2.new(0.08, 0, 0.3, 0)},
		{UDim2.new(0.52, 0, 0.74, 0), UDim2.new(0.24, 0, 0.08, 0)},
		{UDim2.new(0.44, 0, 0.64, 0), UDim2.new(0.5, 0, 0.22, 0)}
	}

	for _, pData in ipairs(shadowPuffs) do
		local puff = Instance.new("Frame")
		puff.Size = pData[1]
		puff.Position = pData[2]
		puff.BackgroundColor3 = Color3.fromRGB(40, 40, 52)
		puff.BackgroundTransparency = 0.55
		puff.BorderSizePixel = 0
		puff.Parent = ShadowLayer

		local corner = Instance.new("UICorner")
		corner.CornerRadius = UDim.new(1, 0)
		corner.Parent = puff
	end

	local BodyLayer = Instance.new("Frame")
	BodyLayer.Name = "BodyLayer"
	BodyLayer.Size = UDim2.new(1, 0, 1, 0)
	BodyLayer.BackgroundTransparency = 1
	BodyLayer.Parent = CloudContainer

	local bodyPuffs = {
		{UDim2.new(0.74, 0, 0.44, 0), UDim2.new(0.13, 0, 0.5, 0), Color3.fromRGB(240, 242, 248), Color3.fromRGB(200, 204, 218)},
		{UDim2.new(0.42, 0, 0.62, 0), UDim2.new(0.07, 0, 0.3, 0), Color3.fromRGB(245, 246, 252), Color3.fromRGB(210, 215, 228)},
		{UDim2.new(0.54, 0, 0.76, 0), UDim2.new(0.23, 0, 0.06, 0), Color3.fromRGB(255, 255, 255), Color3.fromRGB(225, 230, 242)},
		{UDim2.new(0.46, 0, 0.66, 0), UDim2.new(0.49, 0, 0.2, 0), Color3.fromRGB(248, 250, 255), Color3.fromRGB(215, 220, 234)},
		{UDim2.new(0.36, 0, 0.54, 0), UDim2.new(0.27, 0, 0.08, 0), Color3.fromRGB(255, 255, 255), Color3.fromRGB(235, 240, 250)}
	}

	for _, pData in ipairs(bodyPuffs) do
		local puff = Instance.new("Frame")
		puff.Size = pData[1]
		puff.Position = pData[2]
		puff.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		puff.BorderSizePixel = 0
		puff.Parent = BodyLayer

		local corner = Instance.new("UICorner")
		corner.CornerRadius = UDim.new(1, 0)
		corner.Parent = puff

		local grad = Instance.new("UIGradient")
		grad.Rotation = 90
		grad.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, pData[3]),
			ColorSequenceKeypoint.new(1, pData[4])
		})
		grad.Parent = puff
	end

	return CloudContainer
end

local CloudyLib = {}
CloudyLib.__index = CloudyLib

local function getGuiParent()
	local success, result = pcall(function()
		return CoreGui
	end)
	if success and result then
		return result
	end
	return LocalPlayer:WaitForChild("PlayerGui")
end

local function playIntroAnimation(screenGui, titleText, onComplete)
	local IntroFrame = Instance.new("Frame")
	IntroFrame.Name = "CloudyIntro"
	IntroFrame.Size = UDim2.new(1, 0, 1, 0)
	IntroFrame.Position = UDim2.new(0, 0, 0, 0)
	IntroFrame.BackgroundTransparency = 1
	IntroFrame.ClipsDescendants = true
	IntroFrame.ZIndex = 999
	IntroFrame.Parent = screenGui

	local cloud1 = createCustomCloud(IntroFrame, UDim2.new(0, 110, 0, 70), UDim2.new(1, 100, 0, -100), 1)
	local cloud2 = createCustomCloud(IntroFrame, UDim2.new(0, 110, 0, 70), UDim2.new(0, -100, 1, 100), 1)
	local cloud3 = createCustomCloud(IntroFrame, UDim2.new(0, 110, 0, 70), UDim2.new(0, -100, 0, -100), 1)

	local centerGroup
	local okCanvas, canvasInst = pcall(function()
		return Instance.new("CanvasGroup")
	end)
	if okCanvas and canvasInst then
		centerGroup = canvasInst
	else
		centerGroup = Instance.new("Frame")
	end

	centerGroup.Name = "CenterCloudGroup"
	centerGroup.Size = UDim2.new(0, 30, 0, 20)
	centerGroup.Position = UDim2.new(0.5, 0, 0.5, 0)
	centerGroup.AnchorPoint = Vector2.new(0.5, 0.5)
	centerGroup.BackgroundTransparency = 1
	if centerGroup:IsA("CanvasGroup") then
		centerGroup.GroupTransparency = 0
	end
	centerGroup.Visible = false
	centerGroup.Parent = IntroFrame

	local centerCloud = createCustomCloud(centerGroup, UDim2.new(1, 0, 1, 0), UDim2.new(0.5, 0, 0.5, 0), 1.5)

	local splashText = Instance.new("TextLabel")
	splashText.Size = UDim2.new(0, 260, 0, 70)
	splashText.Position = UDim2.new(0.5, 40, 0.5, -35)
	splashText.BackgroundTransparency = 1
	splashText.Text = titleText
	splashText.Font = Enum.Font.GothamBold
	splashText.TextSize = 44
	splashText.TextColor3 = Color3.fromRGB(255, 255, 255)
	splashText.TextTransparency = 1
	splashText.TextXAlignment = Enum.TextXAlignment.Left
	splashText.Parent = IntroFrame

	local textGradient = Instance.new("UIGradient")
	textGradient.Rotation = 45
	textGradient.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(150, 150, 180))
	})
	textGradient.Parent = splashText

	local tweenInfoMerge = TweenInfo.new(0.75, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
	TweenService:Create(cloud1, tweenInfoMerge, {Position = UDim2.new(0.5, 0, 0.5, 0)}):Play()
	TweenService:Create(cloud2, tweenInfoMerge, {Position = UDim2.new(0.5, 0, 0.5, 0)}):Play()
	TweenService:Create(cloud3, tweenInfoMerge, {Position = UDim2.new(0.5, 0, 0.5, 0)}):Play()

	task.delay(0.7, function()
		cloud1:Destroy()
		cloud2:Destroy()
		cloud3:Destroy()

		centerGroup.Visible = true
		centerGroup.Size = UDim2.new(0, 30, 0, 20)

		local tweenInfoGrow = TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
		TweenService:Create(centerGroup, tweenInfoGrow, {Size = UDim2.new(0, 170, 0, 110)}):Play()

		task.delay(0.5, function()
			local tweenInfoMoveLeft = TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
			TweenService:Create(centerGroup, tweenInfoMoveLeft, {Position = UDim2.new(0.5, -135, 0.5, 0)}):Play()
			TweenService:Create(splashText, tweenInfoMoveLeft, {TextTransparency = 0, Position = UDim2.new(0.5, -25, 0.5, -35)}):Play()

			task.delay(0.9, function()
				local tweenInfoFadeOut = TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
				
				if centerGroup:IsA("CanvasGroup") then
					TweenService:Create(centerGroup, tweenInfoFadeOut, {
						GroupTransparency = 1,
						Size = UDim2.new(0, 145, 0, 90)
					}):Play()
				else
					for _, child in pairs(centerGroup:GetDescendants()) do
						if child:IsA("Frame") then
							TweenService:Create(child, tweenInfoFadeOut, {BackgroundTransparency = 1}):Play()
						end
					end
					TweenService:Create(centerGroup, tweenInfoFadeOut, {
						Size = UDim2.new(0, 145, 0, 90)
					}):Play()
				end

				TweenService:Create(splashText, tweenInfoFadeOut, {TextTransparency = 1}):Play()

				task.delay(0.5, function()
					IntroFrame:Destroy()
					if onComplete then
						onComplete()
					end
				end)
			end)
		end)
	end)
end

function CloudyLib:CreateWindow(options)
	options = options or {}
	local titleText = options.Title or "Cloudy"
	local versionText = options.Version or "v2.5.0 Premium"
	local logoIcon = options.Logo or "cloud-bold"

	local parentFolder = getGuiParent()
	if parentFolder:FindFirstChild("CloudyUI") then
		parentFolder:FindFirstChild("CloudyUI"):Destroy()
	end

	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Name = "CloudyUI"
	ScreenGui.ResetOnSpawn = false
	ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	ScreenGui.Parent = parentFolder

	local MainFrame = Instance.new("Frame")
	MainFrame.Name = "MainFrame"
	MainFrame.Size = UDim2.new(0, 540, 0, 340)
	MainFrame.Position = UDim2.new(0.5, -270, 0.5, -170)
	MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 26)
	MainFrame.BorderSizePixel = 0
	MainFrame.ClipsDescendants = true
	MainFrame.Visible = false
	MainFrame.Parent = ScreenGui

	local MainCorner = Instance.new("UICorner")
	MainCorner.CornerRadius = UDim.new(0, 10)
	MainCorner.Parent = MainFrame

	local MainStroke = Instance.new("UIStroke")
	MainStroke.Color = Color3.fromRGB(38, 38, 50)
	MainStroke.Thickness = 1
	MainStroke.Parent = MainFrame

	local Sidebar = Instance.new("Frame")
	Sidebar.Name = "Sidebar"
	Sidebar.Size = UDim2.new(0, 155, 1, 0)
	Sidebar.Position = UDim2.new(0, 0, 0, 0)
	Sidebar.BackgroundColor3 = Color3.fromRGB(16, 16, 22)
	Sidebar.BorderSizePixel = 0
	Sidebar.ClipsDescendants = true
	Sidebar.Parent = MainFrame

	local SidebarCorner = Instance.new("UICorner")
	SidebarCorner.CornerRadius = UDim.new(0, 10)
	SidebarCorner.Parent = Sidebar

	local SidebarHeader = Instance.new("Frame")
	SidebarHeader.Name = "SidebarHeader"
	SidebarHeader.Size = UDim2.new(1, 0, 0, 44)
	SidebarHeader.Position = UDim2.new(0, 0, 0, 0)
	SidebarHeader.BackgroundTransparency = 1
	SidebarHeader.Parent = Sidebar

	local HeaderContainer = Instance.new("Frame")
	HeaderContainer.Size = UDim2.new(1, -16, 1, 0)
	HeaderContainer.Position = UDim2.new(0, 12, 0, 0)
	HeaderContainer.BackgroundTransparency = 1
	HeaderContainer.Parent = SidebarHeader

	local HeaderLayout = Instance.new("UIListLayout")
	HeaderLayout.FillDirection = Enum.FillDirection.Horizontal
	HeaderLayout.VerticalAlignment = Enum.VerticalAlignment.Center
	HeaderLayout.SortOrder = Enum.SortOrder.LayoutOrder
	HeaderLayout.Padding = UDim.new(0, 8)
	HeaderLayout.Parent = HeaderContainer

	local LogoImage = Instance.new("ImageLabel")
	LogoImage.Size = UDim2.new(0, 24, 0, 24)
	LogoImage.BackgroundTransparency = 1
	LogoImage.ImageColor3 = Color3.fromRGB(255, 255, 255)
	LogoImage.LayoutOrder = 1
	LogoImage.Parent = HeaderContainer
	applyIcon(LogoImage, logoIcon)

	local TitleContainer = Instance.new("Frame")
	TitleContainer.Size = UDim2.new(1, -34, 1, 0)
	TitleContainer.BackgroundTransparency = 1
	TitleContainer.LayoutOrder = 2
	TitleContainer.Parent = HeaderContainer

	local TitleVLayout = Instance.new("UIListLayout")
	TitleVLayout.FillDirection = Enum.FillDirection.Vertical
	TitleVLayout.VerticalAlignment = Enum.VerticalAlignment.Center
	TitleVLayout.SortOrder = Enum.SortOrder.LayoutOrder
	TitleVLayout.Padding = UDim.new(0, 0)
	TitleVLayout.Parent = TitleContainer

	local TitleLabel = Instance.new("TextLabel")
	TitleLabel.Size = UDim2.new(1, 0, 0, 16)
	TitleLabel.BackgroundTransparency = 1
	TitleLabel.Text = titleText
	TitleLabel.Font = Enum.Font.GothamBold
	TitleLabel.TextSize = 15
	TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
	TitleLabel.LayoutOrder = 1
	TitleLabel.Parent = TitleContainer

	local TitleGradient = Instance.new("UIGradient")
	TitleGradient.Rotation = 45
	TitleGradient.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(150, 150, 170))
	})
	TitleGradient.Parent = TitleLabel

	local VersionLabel = Instance.new("TextLabel")
	VersionLabel.Size = UDim2.new(1, 0, 0, 12)
	VersionLabel.BackgroundTransparency = 1
	VersionLabel.Text = versionText
	VersionLabel.Font = Enum.Font.GothamBold
	VersionLabel.TextSize = 9
	VersionLabel.TextColor3 = Color3.fromRGB(140, 140, 175)
	VersionLabel.TextXAlignment = Enum.TextXAlignment.Left
	VersionLabel.LayoutOrder = 2
	VersionLabel.Parent = TitleContainer

	local VersionGradient = Instance.new("UIGradient")
	VersionGradient.Rotation = 45
	VersionGradient.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 170, 230)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(110, 110, 160))
	})
	VersionGradient.Parent = VersionLabel

	local SidebarDivider = Instance.new("Frame")
	SidebarDivider.Name = "SidebarDivider"
	SidebarDivider.Size = UDim2.new(0, 1, 1, 0)
	SidebarDivider.Position = UDim2.new(0, 155, 0, 0)
	SidebarDivider.BackgroundColor3 = Color3.fromRGB(38, 38, 50)
	SidebarDivider.BorderSizePixel = 0
	SidebarDivider.ZIndex = 3
	SidebarDivider.Parent = MainFrame

	local MainContent = Instance.new("Frame")
	MainContent.Name = "MainContent"
	MainContent.Size = UDim2.new(1, -156, 1, 0)
	MainContent.Position = UDim2.new(0, 156, 0, 0)
	MainContent.BackgroundTransparency = 1
	MainContent.ClipsDescendants = true
	MainContent.Parent = MainFrame

	local Topbar = Instance.new("Frame")
	Topbar.Name = "Topbar"
	Topbar.Size = UDim2.new(1, 0, 0, 44)
	Topbar.Position = UDim2.new(0, 0, 0, 0)
	Topbar.BackgroundColor3 = Color3.fromRGB(16, 16, 22)
	Topbar.BorderSizePixel = 0
	Topbar.Parent = MainContent

	local TopbarCorner = Instance.new("UICorner")
	TopbarCorner.CornerRadius = UDim.new(0, 10)
	TopbarCorner.Parent = Topbar

	local RightContainer = Instance.new("Frame")
	RightContainer.Size = UDim2.new(0, 110, 1, 0)
	RightContainer.Position = UDim2.new(1, -118, 0, 0)
	RightContainer.BackgroundTransparency = 1
	RightContainer.Parent = Topbar

	local RightLayout = Instance.new("UIListLayout")
	RightLayout.FillDirection = Enum.FillDirection.Horizontal
	RightLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
	RightLayout.VerticalAlignment = Enum.VerticalAlignment.Center
	RightLayout.SortOrder = Enum.SortOrder.LayoutOrder
	RightLayout.Padding = UDim.new(0, 8)
	RightLayout.Parent = RightContainer

	local MinimizeBtn = Instance.new("TextButton")
	MinimizeBtn.Size = UDim2.new(0, 26, 0, 26)
	MinimizeBtn.BackgroundTransparency = 1
	MinimizeBtn.Text = ""
	MinimizeBtn.AutoButtonColor = false
	MinimizeBtn.LayoutOrder = 1
	MinimizeBtn.Parent = RightContainer

	local MinimizeIcon = Instance.new("ImageLabel")
	MinimizeIcon.Size = UDim2.new(0, 16, 0, 16)
	MinimizeIcon.Position = UDim2.new(0.5, -8, 0.5, -8)
	MinimizeIcon.BackgroundTransparency = 1
	MinimizeIcon.ImageColor3 = Color3.fromRGB(200, 200, 215)
	MinimizeIcon.Parent = MinimizeBtn
	applyIcon(MinimizeIcon, "gravity:minus")

	local ResizeBtn = Instance.new("TextButton")
	ResizeBtn.Size = UDim2.new(0, 26, 0, 26)
	ResizeBtn.BackgroundTransparency = 1
	ResizeBtn.Text = ""
	ResizeBtn.AutoButtonColor = false
	ResizeBtn.LayoutOrder = 2
	ResizeBtn.Parent = RightContainer

	local ResizeIcon = Instance.new("ImageLabel")
	ResizeIcon.Size = UDim2.new(0, 16, 0, 16)
	ResizeIcon.Position = UDim2.new(0.5, -8, 0.5, -8)
	ResizeIcon.BackgroundTransparency = 1
	ResizeIcon.ImageColor3 = Color3.fromRGB(200, 200, 215)
	ResizeIcon.Parent = ResizeBtn
	applyIcon(ResizeIcon, "gravity:chevrons-expand-up-right")

	local CloseBtn = Instance.new("TextButton")
	CloseBtn.Size = UDim2.new(0, 26, 0, 26)
	CloseBtn.BackgroundTransparency = 1
	CloseBtn.Text = ""
	CloseBtn.AutoButtonColor = false
	CloseBtn.LayoutOrder = 3
	CloseBtn.Parent = RightContainer

	local CloseIcon = Instance.new("ImageLabel")
	CloseIcon.Size = UDim2.new(0, 16, 0, 16)
	CloseIcon.Position = UDim2.new(0.5, -8, 0.5, -8)
	CloseIcon.BackgroundTransparency = 1
	CloseIcon.ImageColor3 = Color3.fromRGB(200, 200, 215)
	CloseIcon.Parent = CloseBtn
	applyIcon(CloseIcon, "gravity:xmark")

	local dragging, dragInput, dragStart, startPos
	local function onDragBegan(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = MainFrame.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end

	Topbar.InputBegan:Connect(onDragBegan)
	SidebarHeader.InputBegan:Connect(onDragBegan)

	Topbar.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)

	SidebarHeader.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			local delta = input.Position - dragStart
			MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
	end)

	local RestoreBtn = Instance.new("ImageButton")
	RestoreBtn.Name = "CloudyRestoreBtn"
	RestoreBtn.Size = UDim2.new(0, 80, 0, 80)
	RestoreBtn.Position = UDim2.new(0, 20, 0.5, -40)
	RestoreBtn.BackgroundTransparency = 1
	RestoreBtn.Image = "rbxassetid://88244237473485"
	RestoreBtn.AutoButtonColor = false
	RestoreBtn.Visible = true
	RestoreBtn.ZIndex = 9999
	RestoreBtn.Parent = ScreenGui

	local floatDragging, floatDragInput, floatDragStart, floatStartPos
	local floatDragMoved = false

	RestoreBtn.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			floatDragging = true
			floatDragMoved = false
			floatDragStart = input.Position
			floatStartPos = RestoreBtn.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					floatDragging = false
				end
			end)
		end
	end)

	RestoreBtn.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			floatDragInput = input
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if input == floatDragInput and floatDragging then
			local delta = input.Position - floatDragStart
			if math.abs(delta.X) > 3 or math.abs(delta.Y) > 3 then
				floatDragMoved = true
			end
			RestoreBtn.Position = UDim2.new(floatStartPos.X.Scale, floatStartPos.X.Offset + delta.X, floatStartPos.Y.Scale, floatStartPos.Y.Offset + delta.Y)
		end
	end)

	local function toggleMinimize()
		MainFrame.Visible = not MainFrame.Visible
	end

	MinimizeBtn.MouseButton1Click:Connect(toggleMinimize)
	RestoreBtn.MouseButton1Up:Connect(function()
		if not floatDragMoved then
			toggleMinimize()
		end
	end)

	local isExpanded = false
	ResizeBtn.MouseButton1Click:Connect(function()
		isExpanded = not isExpanded
		local targetSize = isExpanded and UDim2.new(0, 700, 0, 430) or UDim2.new(0, 540, 0, 340)
		local targetPos = isExpanded and UDim2.new(0.5, -350, 0.5, -215) or UDim2.new(0.5, -270, 0.5, -170)

		local tweenInfo = TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
		TweenService:Create(MainFrame, tweenInfo, {
			Size = targetSize,
			Position = targetPos
		}):Play()
	end)

	local ConfirmOverlay = Instance.new("Frame")
	ConfirmOverlay.Name = "ExitConfirmOverlay"
	ConfirmOverlay.Size = UDim2.new(1, 0, 1, 0)
	ConfirmOverlay.Position = UDim2.new(0, 0, 0, 0)
	ConfirmOverlay.BackgroundColor3 = Color3.fromRGB(8, 8, 12)
	ConfirmOverlay.BackgroundTransparency = 1
	ConfirmOverlay.ZIndex = 9999
	ConfirmOverlay.Visible = false
	ConfirmOverlay.Parent = MainFrame

	local OverlayCorner = Instance.new("UICorner")
	OverlayCorner.CornerRadius = UDim.new(0, 10)
	OverlayCorner.Parent = ConfirmOverlay

	local ConfirmCard = Instance.new("Frame")
	ConfirmCard.Name = "ExitConfirmCard"
	ConfirmCard.Size = UDim2.new(0, 310, 0, 160)
	ConfirmCard.Position = UDim2.new(0.5, 0, 0.5, 0)
	ConfirmCard.AnchorPoint = Vector2.new(0.5, 0.5)
	ConfirmCard.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
	ConfirmCard.BorderSizePixel = 0
	ConfirmCard.ClipsDescendants = true
	ConfirmCard.ZIndex = 10000
	ConfirmCard.Parent = ConfirmOverlay

	local CardCorner = Instance.new("UICorner")
	CardCorner.CornerRadius = UDim.new(0, 12)
	CardCorner.Parent = ConfirmCard

	local CardStroke = Instance.new("UIStroke")
	CardStroke.Color = Color3.fromRGB(55, 55, 75)
	CardStroke.Thickness = 1.5
	CardStroke.Parent = ConfirmCard

	local CardTopGlow = Instance.new("Frame")
	CardTopGlow.Size = UDim2.new(1, 0, 0, 3)
	CardTopGlow.Position = UDim2.new(0, 0, 0, 0)
	CardTopGlow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	CardTopGlow.BorderSizePixel = 0
	CardTopGlow.ZIndex = 10001
	CardTopGlow.Parent = ConfirmCard

	local GlowGradient = Instance.new("UIGradient")
	GlowGradient.Rotation = 0
	GlowGradient.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
		ColorSequenceKeypoint.new(0.5, Color3.fromRGB(200, 200, 220)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(130, 130, 150))
	})
	GlowGradient.Parent = CardTopGlow

	local ConfirmTitle = Instance.new("TextLabel")
	ConfirmTitle.Size = UDim2.new(1, -32, 0, 26)
	ConfirmTitle.Position = UDim2.new(0, 16, 0, 18)
	ConfirmTitle.BackgroundTransparency = 1
	ConfirmTitle.Text = "Konfirmasi Keluar"
	ConfirmTitle.Font = Enum.Font.GothamBold
	ConfirmTitle.TextSize = 16
	ConfirmTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
	ConfirmTitle.TextXAlignment = Enum.TextXAlignment.Center
	ConfirmTitle.ZIndex = 10001
	ConfirmTitle.Parent = ConfirmCard

	local TitleGradient = Instance.new("UIGradient")
	TitleGradient.Rotation = 45
	TitleGradient.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(160, 160, 180))
	})
	TitleGradient.Parent = ConfirmTitle

	local ConfirmDesc = Instance.new("TextLabel")
	ConfirmDesc.Size = UDim2.new(1, -32, 0, 36)
	ConfirmDesc.Position = UDim2.new(0, 16, 0, 48)
	ConfirmDesc.BackgroundTransparency = 1
	ConfirmDesc.Text = "Apakah kamu yakin ingin menutup CloudyUI?"
	ConfirmDesc.Font = Enum.Font.GothamMedium
	ConfirmDesc.TextSize = 12
	ConfirmDesc.TextColor3 = Color3.fromRGB(170, 170, 195)
	ConfirmDesc.TextWrapped = true
	ConfirmDesc.TextXAlignment = Enum.TextXAlignment.Center
	ConfirmDesc.ZIndex = 10001
	ConfirmDesc.Parent = ConfirmCard

	local BtnContainer = Instance.new("Frame")
	BtnContainer.Size = UDim2.new(1, -24, 0, 38)
	BtnContainer.Position = UDim2.new(0, 12, 1, -50)
	BtnContainer.BackgroundTransparency = 1
	BtnContainer.ZIndex = 10001
	BtnContainer.Parent = ConfirmCard

	local CancelBtn = Instance.new("TextButton")
	CancelBtn.Size = UDim2.new(0.5, -6, 1, 0)
	CancelBtn.Position = UDim2.new(0, 0, 0, 0)
	CancelBtn.BackgroundColor3 = Color3.fromRGB(32, 32, 44)
	CancelBtn.Text = "Batal"
	CancelBtn.Font = Enum.Font.GothamBold
	CancelBtn.TextSize = 12
	CancelBtn.TextColor3 = Color3.fromRGB(200, 200, 220)
	CancelBtn.AutoButtonColor = false
	CancelBtn.ZIndex = 10002
	CancelBtn.Parent = BtnContainer

	local CancelCorner = Instance.new("UICorner")
	CancelCorner.CornerRadius = UDim.new(0, 8)
	CancelCorner.Parent = CancelBtn

	local CancelStroke = Instance.new("UIStroke")
	CancelStroke.Color = Color3.fromRGB(50, 50, 65)
	CancelStroke.Thickness = 1
	CancelStroke.Parent = CancelBtn

	local ExitBtn = Instance.new("Frame")
	ExitBtn.Size = UDim2.new(0.5, -6, 1, 0)
	ExitBtn.Position = UDim2.new(0.5, 6, 0, 0)
	ExitBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ExitBtn.ZIndex = 10002
	ExitBtn.Parent = BtnContainer

	local ExitCorner = Instance.new("UICorner")
	ExitCorner.CornerRadius = UDim.new(0, 8)
	ExitCorner.Parent = ExitBtn

	local ExitGradient = Instance.new("UIGradient")
	ExitGradient.Rotation = 45
	ExitGradient.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(160, 160, 180))
	})
	ExitGradient.Parent = ExitBtn

	local ExitActionBtn = Instance.new("TextButton")
	ExitActionBtn.Size = UDim2.new(1, 0, 1, 0)
	ExitActionBtn.BackgroundTransparency = 1
	ExitActionBtn.Text = "Ya, Keluar"
	ExitActionBtn.Font = Enum.Font.GothamBold
	ExitActionBtn.TextSize = 12
	ExitActionBtn.TextColor3 = Color3.fromRGB(20, 20, 26)
	ExitActionBtn.ZIndex = 10003
	ExitActionBtn.Parent = ExitBtn

	local isModalAnimating = false

	local function openExitModal()
		if isModalAnimating then return end
		isModalAnimating = true

		ConfirmOverlay.Visible = true
		ConfirmOverlay.BackgroundTransparency = 1
		ConfirmCard.Size = UDim2.new(0, 260, 0, 135)

		TweenService:Create(ConfirmOverlay, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
			BackgroundTransparency = 0.55
		}):Play()

		local tweenGrow = TweenService:Create(ConfirmCard, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
			Size = UDim2.new(0, 310, 0, 160)
		})
		tweenGrow:Play()
		tweenGrow.Completed:Connect(function()
			isModalAnimating = false
		end)
	end

	local function closeExitModal()
		if isModalAnimating then return end
		isModalAnimating = true

		TweenService:Create(ConfirmOverlay, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
			BackgroundTransparency = 1
		}):Play()

		local tweenShrink = TweenService:Create(ConfirmCard, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
			Size = UDim2.new(0, 260, 0, 135)
		})
		tweenShrink:Play()
		tweenShrink.Completed:Connect(function()
			ConfirmOverlay.Visible = false
			isModalAnimating = false
		end)
	end

	CloseBtn.MouseButton1Click:Connect(openExitModal)
	CancelBtn.MouseButton1Click:Connect(closeExitModal)

	ExitActionBtn.MouseButton1Click:Connect(function()
		ScreenGui:Destroy()
	end)

	CancelBtn.MouseEnter:Connect(function()
		TweenService:Create(CancelBtn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(42, 42, 58)}):Play()
	end)
	CancelBtn.MouseLeave:Connect(function()
		TweenService:Create(CancelBtn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(32, 32, 44)}):Play()
	end)

	ExitActionBtn.MouseEnter:Connect(function()
		TweenService:Create(ExitGradient, TweenInfo.new(0.15), {Rotation = 90}):Play()
	end)
	ExitActionBtn.MouseLeave:Connect(function()
		TweenService:Create(ExitGradient, TweenInfo.new(0.15), {Rotation = 45}):Play()
	end)

	CloseBtn.MouseEnter:Connect(function()
		TweenService:Create(CloseIcon, TweenInfo.new(0.15), {ImageColor3 = Color3.fromRGB(255, 75, 75)}):Play()
	end)
	CloseBtn.MouseLeave:Connect(function()
		TweenService:Create(CloseIcon, TweenInfo.new(0.15), {ImageColor3 = Color3.fromRGB(200, 200, 215)}):Play()
	end)

	MinimizeBtn.MouseEnter:Connect(function()
		TweenService:Create(MinimizeIcon, TweenInfo.new(0.15), {ImageColor3 = Color3.fromRGB(255, 255, 255)}):Play()
	end)
	MinimizeBtn.MouseLeave:Connect(function()
		TweenService:Create(MinimizeIcon, TweenInfo.new(0.15), {ImageColor3 = Color3.fromRGB(200, 200, 215)}):Play()
	end)

	ResizeBtn.MouseEnter:Connect(function()
		TweenService:Create(ResizeIcon, TweenInfo.new(0.15), {ImageColor3 = Color3.fromRGB(255, 255, 255)}):Play()
	end)
	ResizeBtn.MouseLeave:Connect(function()
		TweenService:Create(ResizeIcon, TweenInfo.new(0.15), {ImageColor3 = Color3.fromRGB(200, 200, 215)}):Play()
	end)

	local TabIndicator = Instance.new("Frame")
	TabIndicator.Name = "TabIndicator"
	TabIndicator.Size = UDim2.new(0, 139, 0, 36)
	TabIndicator.Position = UDim2.new(0, 8, 0, 52)
	TabIndicator.BackgroundColor3 = Color3.fromRGB(30, 30, 42)
	TabIndicator.BackgroundTransparency = 0.2
	TabIndicator.BorderSizePixel = 0
	TabIndicator.Visible = false
	TabIndicator.ZIndex = 1
	TabIndicator.Parent = Sidebar

	local IndCorner = Instance.new("UICorner")
	IndCorner.CornerRadius = UDim.new(0, 8)
	IndCorner.Parent = TabIndicator

	local IndLine = Instance.new("Frame")
	IndLine.Name = "WhiteIndicatorLine"
	IndLine.Size = UDim2.new(0, 3, 0, 18)
	IndLine.Position = UDim2.new(0, 2, 0.5, -9)
	IndLine.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	IndLine.BorderSizePixel = 0
	IndLine.Parent = TabIndicator

	local LineCorner = Instance.new("UICorner")
	LineCorner.CornerRadius = UDim.new(1, 0)
	LineCorner.Parent = IndLine

	local TabScroll = Instance.new("ScrollingFrame")
	TabScroll.Size = UDim2.new(1, 0, 1, -96)
	TabScroll.Position = UDim2.new(0, 0, 0, 44)
	TabScroll.BackgroundTransparency = 1
	TabScroll.BorderSizePixel = 0
	TabScroll.ScrollBarThickness = 2
	TabScroll.ScrollBarImageColor3 = Color3.fromRGB(45, 45, 58)
	TabScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
	TabScroll.ZIndex = 2
	TabScroll.Parent = Sidebar

	local TabListLayout = Instance.new("UIListLayout")
	TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	TabListLayout.Padding = UDim.new(0, 4)
	TabListLayout.Parent = TabScroll

	local TabPadding = Instance.new("UIPadding")
	TabPadding.PaddingTop = UDim.new(0, 6)
	TabPadding.PaddingLeft = UDim.new(0, 8)
	TabPadding.PaddingRight = UDim.new(0, 8)
	TabPadding.PaddingBottom = UDim.new(0, 6)
	TabPadding.Parent = TabScroll

	TabListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		TabScroll.CanvasSize = UDim2.new(0, 0, 0, TabListLayout.AbsoluteContentSize.Y + 12)
	end)

	local SidebarProfile = Instance.new("Frame")
	SidebarProfile.Name = "SidebarProfile"
	SidebarProfile.Size = UDim2.new(1, 0, 0, 52)
	SidebarProfile.Position = UDim2.new(0, 0, 1, -52)
	SidebarProfile.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
	SidebarProfile.BorderSizePixel = 0
	SidebarProfile.ZIndex = 3
	SidebarProfile.Parent = Sidebar

	local ProfileTopDivider = Instance.new("Frame")
	ProfileTopDivider.Size = UDim2.new(1, 0, 0, 1)
	ProfileTopDivider.Position = UDim2.new(0, 0, 0, 0)
	ProfileTopDivider.BackgroundColor3 = Color3.fromRGB(34, 34, 46)
	ProfileTopDivider.BorderSizePixel = 0
	ProfileTopDivider.Parent = SidebarProfile

	local AvatarFrame = Instance.new("Frame")
	AvatarFrame.Size = UDim2.new(0, 30, 0, 30)
	AvatarFrame.Position = UDim2.new(0, 10, 0.5, -15)
	AvatarFrame.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
	AvatarFrame.BorderSizePixel = 0
	AvatarFrame.Parent = SidebarProfile

	local AvatarCorner = Instance.new("UICorner")
	AvatarCorner.CornerRadius = UDim.new(1, 0)
	AvatarCorner.Parent = AvatarFrame

	local AvatarStroke = Instance.new("UIStroke")
	AvatarStroke.Color = Color3.fromRGB(50, 50, 68)
	AvatarStroke.Thickness = 1
	AvatarStroke.Parent = AvatarFrame

	local AvatarImage = Instance.new("ImageLabel")
	AvatarImage.Size = UDim2.new(1, 0, 1, 0)
	AvatarImage.BackgroundTransparency = 1
	local playerUserId = (LocalPlayer and LocalPlayer.UserId) or 1
	AvatarImage.Image = "rbxthumb://type=AvatarHeadShot&id=" .. tostring(playerUserId) .. "&w=150&h=150"
	AvatarImage.Parent = AvatarFrame

	local AvatarImgCorner = Instance.new("UICorner")
	AvatarImgCorner.CornerRadius = UDim.new(1, 0)
	AvatarImgCorner.Parent = AvatarImage

	local StatusDot = Instance.new("Frame")
	StatusDot.Size = UDim2.new(0, 9, 0, 9)
	StatusDot.Position = UDim2.new(0, 31, 0.5, 6)
	StatusDot.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
	StatusDot.BorderSizePixel = 0
	StatusDot.ZIndex = 4
	StatusDot.Parent = SidebarProfile

	local StatusCorner = Instance.new("UICorner")
	StatusCorner.CornerRadius = UDim.new(1, 0)
	StatusCorner.Parent = StatusDot

	local StatusStroke = Instance.new("UIStroke")
	StatusStroke.Color = Color3.fromRGB(18, 18, 24)
	StatusStroke.Thickness = 1.5
	StatusStroke.Parent = StatusDot

	local rawUsername = (LocalPlayer and (LocalPlayer.DisplayName ~= "" and LocalPlayer.DisplayName or LocalPlayer.Name)) or "CloudyUser"

	local function maskName(str)
		str = tostring(str or "CloudyUser")
		if #str <= 3 then
			return str:sub(1, 1) .. string.rep("*", math.max(2, #str - 1))
		else
			return str:sub(1, 3) .. "***"
		end
	end

	local isCensored = true
	local ProfileBtn = Instance.new("TextButton")
	ProfileBtn.Size = UDim2.new(1, -48, 1, -12)
	ProfileBtn.Position = UDim2.new(0, 44, 0, 6)
	ProfileBtn.BackgroundTransparency = 1
	ProfileBtn.Text = ""
	ProfileBtn.Parent = SidebarProfile

	local UsernameLabel = Instance.new("TextLabel")
	UsernameLabel.Size = UDim2.new(1, 0, 0, 16)
	UsernameLabel.Position = UDim2.new(0, 0, 0, 2)
	UsernameLabel.BackgroundTransparency = 1
	UsernameLabel.Text = maskName(rawUsername)
	UsernameLabel.Font = Enum.Font.GothamBold
	UsernameLabel.TextSize = 12
	UsernameLabel.TextColor3 = Color3.fromRGB(240, 240, 255)
	UsernameLabel.TextXAlignment = Enum.TextXAlignment.Left
	UsernameLabel.TextTruncate = Enum.TextTruncate.AtEnd
	UsernameLabel.Parent = ProfileBtn

	local UserRoleLabel = Instance.new("TextLabel")
	UserRoleLabel.Size = UDim2.new(1, 0, 0, 14)
	UserRoleLabel.Position = UDim2.new(0, 0, 0, 18)
	UserRoleLabel.BackgroundTransparency = 1
	UserRoleLabel.Text = "Premium User"
	UserRoleLabel.Font = Enum.Font.GothamMedium
	UserRoleLabel.TextSize = 9
	UserRoleLabel.TextColor3 = Color3.fromRGB(130, 130, 160)
	UserRoleLabel.TextXAlignment = Enum.TextXAlignment.Left
	UserRoleLabel.TextTruncate = Enum.TextTruncate.AtEnd
	UserRoleLabel.Parent = ProfileBtn

	ProfileBtn.MouseButton1Click:Connect(function()
		isCensored = not isCensored
		local targetText = isCensored and maskName(rawUsername) or rawUsername
		TweenService:Create(UsernameLabel, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 0.5}):Play()
		task.delay(0.15, function()
			UsernameLabel.Text = targetText
			TweenService:Create(UsernameLabel, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
		end)
	end)

	local ContentContainer = Instance.new("Frame")
	ContentContainer.Name = "ContentContainer"
	ContentContainer.Size = UDim2.new(1, -156, 1, -44)
	ContentContainer.Position = UDim2.new(0, 156, 0, 44)
	ContentContainer.BackgroundTransparency = 1
	ContentContainer.Parent = MainFrame

	-- Dropdown Side Drawer Frame
	local DropdownDrawer = Instance.new("Frame")
	DropdownDrawer.Name = "DropdownDrawer"
	DropdownDrawer.Size = UDim2.new(0, 230, 1, -48)
	DropdownDrawer.Position = UDim2.new(1, 0, 0, 48)
	DropdownDrawer.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
	DropdownDrawer.BorderSizePixel = 0
	DropdownDrawer.ZIndex = 50
	DropdownDrawer.Visible = false
	DropdownDrawer.Parent = MainFrame

	local DrawerCorner = Instance.new("UICorner")
	DrawerCorner.CornerRadius = UDim.new(0, 10)
	DrawerCorner.Parent = DropdownDrawer

	local DrawerStroke = Instance.new("UIStroke")
	DrawerStroke.Color = Color3.fromRGB(45, 45, 60)
	DrawerStroke.Thickness = 1
	DrawerStroke.Parent = DropdownDrawer

	local DrawerHeader = Instance.new("Frame")
	DrawerHeader.Name = "DrawerHeader"
	DrawerHeader.Size = UDim2.new(1, 0, 0, 42)
	DrawerHeader.Position = UDim2.new(0, 0, 0, 0)
	DrawerHeader.BackgroundTransparency = 1
	DrawerHeader.Parent = DropdownDrawer

	local DrawerTitle = Instance.new("TextLabel")
	DrawerTitle.Size = UDim2.new(1, -48, 1, 0)
	DrawerTitle.Position = UDim2.new(0, 14, 0, 0)
	DrawerTitle.BackgroundTransparency = 1
	DrawerTitle.Text = "Opsi Dropdown"
	DrawerTitle.Font = Enum.Font.GothamBold
	DrawerTitle.TextSize = 13
	DrawerTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
	DrawerTitle.TextXAlignment = Enum.TextXAlignment.Left
	DrawerTitle.TextTruncate = Enum.TextTruncate.AtEnd
	DrawerTitle.Parent = DrawerHeader

	local DrawerCloseBtn = Instance.new("TextButton")
	DrawerCloseBtn.Size = UDim2.new(0, 28, 0, 28)
	DrawerCloseBtn.Position = UDim2.new(1, -34, 0.5, -14)
	DrawerCloseBtn.BackgroundTransparency = 1
	DrawerCloseBtn.Text = ""
	DrawerCloseBtn.Parent = DrawerHeader

	local DrawerCloseIcon = Instance.new("ImageLabel")
	DrawerCloseIcon.Size = UDim2.new(0, 14, 0, 14)
	DrawerCloseIcon.Position = UDim2.new(0.5, -7, 0.5, -7)
	DrawerCloseIcon.BackgroundTransparency = 1
	DrawerCloseIcon.ImageColor3 = Color3.fromRGB(200, 200, 215)
	DrawerCloseIcon.Parent = DrawerCloseBtn
	applyIcon(DrawerCloseIcon, "gravity:xmark")

	local DrawerDivider = Instance.new("Frame")
	DrawerDivider.Size = UDim2.new(1, 0, 0, 1)
	DrawerDivider.Position = UDim2.new(0, 0, 0, 42)
	DrawerDivider.BackgroundColor3 = Color3.fromRGB(38, 38, 50)
	DrawerDivider.BorderSizePixel = 0
	DrawerDivider.Parent = DropdownDrawer

	local DrawerScroll = Instance.new("ScrollingFrame")
	DrawerScroll.Size = UDim2.new(1, 0, 1, -44)
	DrawerScroll.Position = UDim2.new(0, 0, 0, 44)
	DrawerScroll.BackgroundTransparency = 1
	DrawerScroll.BorderSizePixel = 0
	DrawerScroll.ScrollBarThickness = 3
	DrawerScroll.ScrollBarImageColor3 = Color3.fromRGB(45, 45, 58)
	DrawerScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
	DrawerScroll.Parent = DropdownDrawer

	local DrawerLayout = Instance.new("UIListLayout")
	DrawerLayout.SortOrder = Enum.SortOrder.LayoutOrder
	DrawerLayout.Padding = UDim.new(0, 6)
	DrawerLayout.Parent = DrawerScroll

	local DrawerPadding = Instance.new("UIPadding")
	DrawerPadding.PaddingTop = UDim.new(0, 8)
	DrawerPadding.PaddingLeft = UDim.new(0, 10)
	DrawerPadding.PaddingRight = UDim.new(0, 10)
	DrawerPadding.PaddingBottom = UDim.new(0, 8)
	DrawerPadding.Parent = DrawerScroll

	DrawerLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		DrawerScroll.CanvasSize = UDim2.new(0, 0, 0, DrawerLayout.AbsoluteContentSize.Y + 16)
	end)

	local currentActiveDrawerOwner = nil

	local function closeDrawer()
		if not DropdownDrawer.Visible then return end
		local ownerToReset = currentActiveDrawerOwner
		currentActiveDrawerOwner = nil

		local tweenOut = TweenService:Create(DropdownDrawer, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
			Position = UDim2.new(1, 0, 0, 48)
		})
		tweenOut:Play()
		tweenOut.Completed:Connect(function()
			if currentActiveDrawerOwner == nil then
				DropdownDrawer.Visible = false
			end
		end)

		if ownerToReset and ownerToReset.ArrowIcon then
			TweenService:Create(ownerToReset.ArrowIcon, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Rotation = 0}):Play()
		end
	end

	DrawerCloseBtn.MouseButton1Click:Connect(function()
		closeDrawer()
	end)

	playIntroAnimation(ScreenGui, titleText, function()
		MainFrame.Visible = true
	end)

	local WindowObj = {
		Tabs = {},
		ActiveTab = nil,
		TabCount = 0,
		Flags = {},
		Elements = {},
	}

	function WindowObj:SaveConfig(configName)
		if not configName or configName == "" then configName = "Default" end
		local textData = HttpService:JSONEncode(WindowObj.Flags)
		SaveConfigFile(configName, textData)
	end

	function WindowObj:LoadConfig(configName)
		if not configName or configName == "" then configName = "Default" end
		local textData = ReadConfigFile(configName)
		if textData then
			local ok, decoded = pcall(function() return HttpService:JSONDecode(textData) end)
			if ok and type(decoded) == "table" then
				for flagKey, val in pairs(decoded) do
					if WindowObj.Elements[flagKey] and WindowObj.Elements[flagKey].Set then
						WindowObj.Elements[flagKey]:Set(val)
					end
				end
			end
		end
	end

	function WindowObj:DeleteConfig(configName)
		DeleteConfigFile(configName)
	end

	function WindowObj:DeleteAllConfigs()
		DeleteAllConfigFiles()
	end

	function WindowObj:GetConfigList()
		return ListConfigNames()
	end

	function WindowObj:CreateTab(tabName, iconName)
		WindowObj.TabCount = WindowObj.TabCount + 1
		iconName = iconName or "settings-bold"

		local TabBtn = Instance.new("TextButton")
		TabBtn.Name = "Tab_" .. tabName
		TabBtn.Size = UDim2.new(1, 0, 0, 38)
		TabBtn.BackgroundColor3 = Color3.fromRGB(28, 28, 36)
		TabBtn.BackgroundTransparency = 1
		TabBtn.Text = ""
		TabBtn.AutoButtonColor = false
		TabBtn.ZIndex = 3
		TabBtn.LayoutOrder = WindowObj.TabCount
		TabBtn.Parent = TabScroll

		local TabCorner = Instance.new("UICorner")
		TabCorner.CornerRadius = UDim.new(0, 8)
		TabCorner.Parent = TabBtn

		local TabContentLayout = Instance.new("UIListLayout")
		TabContentLayout.FillDirection = Enum.FillDirection.Horizontal
		TabContentLayout.VerticalAlignment = Enum.VerticalAlignment.Center
		TabContentLayout.Padding = UDim.new(0, 10)
		TabContentLayout.Parent = TabBtn

		local TabContentPadding = Instance.new("UIPadding")
		TabContentPadding.PaddingLeft = UDim.new(0, 10)
		TabContentPadding.Parent = TabBtn

		local TabIcon = Instance.new("ImageLabel")
		TabIcon.Size = UDim2.new(0, 18, 0, 18)
		TabIcon.BackgroundTransparency = 1
		TabIcon.ImageColor3 = Color3.fromRGB(160, 160, 175)
		TabIcon.LayoutOrder = 1
		TabIcon.ZIndex = 3
		TabIcon.Parent = TabBtn
		applyIcon(TabIcon, iconName)

		local TabText = Instance.new("TextLabel")
		TabText.Size = UDim2.new(1, -30, 1, 0)
		TabText.BackgroundTransparency = 1
		TabText.Text = tabName
		TabText.Font = Enum.Font.GothamMedium
		TabText.TextSize = 13
		TabText.TextColor3 = Color3.fromRGB(160, 160, 175)
		TabText.TextXAlignment = Enum.TextXAlignment.Left
		TabText.LayoutOrder = 2
		TabText.ZIndex = 3
		TabText.Parent = TabBtn

		local TabPage = Instance.new("ScrollingFrame")
		TabPage.Name = "Page_" .. tabName
		TabPage.Size = UDim2.new(1, 0, 1, 0)
		TabPage.BackgroundTransparency = 1
		TabPage.BorderSizePixel = 0
		TabPage.ScrollBarThickness = 3
		TabPage.ScrollBarImageColor3 = Color3.fromRGB(45, 45, 58)
		TabPage.Visible = false
		TabPage.Parent = ContentContainer

		local PageLayout = Instance.new("UIListLayout")
		PageLayout.SortOrder = Enum.SortOrder.LayoutOrder
		PageLayout.Padding = UDim.new(0, 8)
		PageLayout.Parent = TabPage

		local PagePadding = Instance.new("UIPadding")
		PagePadding.PaddingTop = UDim.new(0, 12)
		PagePadding.PaddingLeft = UDim.new(0, 14)
		PagePadding.PaddingRight = UDim.new(0, 14)
		PagePadding.PaddingBottom = UDim.new(0, 12)
		PagePadding.Parent = TabPage

		PageLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			TabPage.CanvasSize = UDim2.new(0, 0, 0, PageLayout.AbsoluteContentSize.Y + 24)
		end)

		local TabObj = {
			Button = TabBtn,
			Page = TabPage,
			ElementCount = 0
		}

		local function selectTab(animated)
			local prevTab = WindowObj.ActiveTab
			WindowObj.ActiveTab = TabObj

			closeDrawer()

			local targetY = TabBtn.AbsolutePosition.Y - Sidebar.AbsolutePosition.Y
			local targetPos = UDim2.new(0, 8, 0, targetY)

			TabIndicator.Visible = true

			if animated ~= false and prevTab then
				TweenService:Create(TabIndicator, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
					Position = targetPos
				}):Play()
			else
				TabIndicator.Position = targetPos
			end

			for _, t in pairs(WindowObj.Tabs) do
				local isSelected = (t == TabObj)
				local icon = t.Button:FindFirstChildOfClass("ImageLabel")
				local text = t.Button:FindFirstChildOfClass("TextLabel")

				local targetIconColor = isSelected and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(160, 160, 175)
				local targetTextColor = isSelected and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(160, 160, 175)

				if icon then
					TweenService:Create(icon, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {ImageColor3 = targetIconColor}):Play()
				end
				if text then
					TweenService:Create(text, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextColor3 = targetTextColor}):Play()
				end

				if not isSelected then
					t.Page.Visible = false
				end
			end

			TabPage.Position = UDim2.new(0, 10, 0, 0)
			TabPage.Visible = true
			TweenService:Create(TabPage, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
				Position = UDim2.new(0, 0, 0, 0)
			}):Play()
		end

		TabBtn.MouseButton1Click:Connect(function()
			selectTab(true)
		end)

		if WindowObj.TabCount == 1 then
			task.delay(0.1, function()
				selectTab(false)
			end)
		end

		table.insert(WindowObj.Tabs, TabObj)

		function TabObj:AddSection(text, defaultOpen)
			TabObj.ElementCount = TabObj.ElementCount + 1
			local isOpen = (defaultOpen == nil) and true or defaultOpen

			local SectionHolder = Instance.new("Frame")
			SectionHolder.Size = UDim2.new(1, 0, 0, 32)
			SectionHolder.BackgroundTransparency = 1
			SectionHolder.LayoutOrder = TabObj.ElementCount
			SectionHolder.ClipsDescendants = true
			SectionHolder.Parent = TabPage

			local HeaderBtn = Instance.new("TextButton")
			HeaderBtn.Size = UDim2.new(1, 0, 0, 28)
			HeaderBtn.BackgroundTransparency = 1
			HeaderBtn.Text = ""
			HeaderBtn.Parent = SectionHolder

			local SectionText = Instance.new("TextLabel")
			SectionText.Size = UDim2.new(1, -30, 1, 0)
			SectionText.BackgroundTransparency = 1
			SectionText.Text = text
			SectionText.Font = Enum.Font.GothamBold
			SectionText.TextSize = 14
			SectionText.TextColor3 = Color3.fromRGB(255, 255, 255)
			SectionText.TextXAlignment = Enum.TextXAlignment.Left
			SectionText.Parent = HeaderBtn

			local ArrowIcon = Instance.new("ImageLabel")
			ArrowIcon.Name = "ArrowIcon"
			ArrowIcon.Size = UDim2.new(0, 16, 0, 16)
			ArrowIcon.Position = UDim2.new(1, -20, 0.5, -8)
			ArrowIcon.BackgroundTransparency = 1
			ArrowIcon.ImageColor3 = Color3.fromRGB(200, 200, 215)
			ArrowIcon.Rotation = isOpen and 0 or -90
			ArrowIcon.Parent = HeaderBtn
			applyIcon(ArrowIcon, "alt-arrow-down-bold")

			local Underline = Instance.new("Frame")
			Underline.Size = UDim2.new(1, 0, 0, 1)
			Underline.Position = UDim2.new(0, 0, 1, -1)
			Underline.BackgroundColor3 = Color3.fromRGB(38, 38, 50)
			Underline.BorderSizePixel = 0
			Underline.Parent = SectionHolder

			local ItemsContainer = Instance.new("Frame")
			ItemsContainer.Size = UDim2.new(1, 0, 0, 0)
			ItemsContainer.Position = UDim2.new(0, 0, 0, 32)
			ItemsContainer.BackgroundTransparency = 1
			ItemsContainer.ClipsDescendants = true
			ItemsContainer.Visible = isOpen
			ItemsContainer.Parent = SectionHolder

			local ItemsLayout = Instance.new("UIListLayout")
			ItemsLayout.SortOrder = Enum.SortOrder.LayoutOrder
			ItemsLayout.Padding = UDim.new(0, 8)
			ItemsLayout.Parent = ItemsContainer

			local activeSectionTween = nil

			local function updateSectionState(animated)
				local targetContentHeight = ItemsLayout.AbsoluteContentSize.Y
				local targetHolderHeight = isOpen and (32 + targetContentHeight + 6) or 32
				local targetItemsHeight = isOpen and targetContentHeight or 0
				local targetRotation = isOpen and 0 or -90

				if animated ~= false then
					if activeSectionTween then
						activeSectionTween:Cancel()
					end

					ItemsContainer.Visible = true

					local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)

					TweenService:Create(ArrowIcon, tweenInfo, {Rotation = targetRotation}):Play()
					TweenService:Create(ItemsContainer, tweenInfo, {Size = UDim2.new(1, 0, 0, targetItemsHeight)}):Play()

					activeSectionTween = TweenService:Create(SectionHolder, tweenInfo, {Size = UDim2.new(1, 0, 0, targetHolderHeight)})
					activeSectionTween:Play()

					activeSectionTween.Completed:Connect(function()
						if not isOpen then
							ItemsContainer.Visible = false
						end
					end)
				else
					ArrowIcon.Rotation = targetRotation
					ItemsContainer.Size = UDim2.new(1, 0, 0, targetItemsHeight)
					SectionHolder.Size = UDim2.new(1, 0, 0, targetHolderHeight)
					ItemsContainer.Visible = isOpen
				end
			end

			ItemsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
				if isOpen then
					updateSectionState(false)
				end
			end)

			HeaderBtn.MouseButton1Click:Connect(function()
				isOpen = not isOpen
				updateSectionState(true)
			end)

			if not isOpen then
				updateSectionState(false)
			end

			local SectionObj = {}

			function SectionObj:AddButton(btnText, callback)
				local res = TabObj:AddButton(btnText, callback, ItemsContainer)
				if isOpen then updateSectionState(false) end
				return res
			end

			function SectionObj:AddButtonGroup2x2(buttonsData)
				local res = TabObj:AddButtonGroup2x2(buttonsData, ItemsContainer)
				if isOpen then updateSectionState(false) end
				return res
			end

			function SectionObj:AddToggle(toggleText, defaultVal, callback, flagName)
				local res = TabObj:AddToggle(toggleText, defaultVal, callback, flagName, ItemsContainer)
				if isOpen then updateSectionState(false) end
				return res
			end

			function SectionObj:AddSlider(sliderText, minV, maxV, defV, callback, flagName)
				local res = TabObj:AddSlider(sliderText, minV, maxV, defV, callback, flagName, ItemsContainer)
				if isOpen then updateSectionState(false) end
				return res
			end

			function SectionObj:AddDropdown(dropText, optList, defOpt, callback, flagName)
				local res = TabObj:AddDropdown(dropText, optList, defOpt, callback, flagName, ItemsContainer)
				if isOpen then updateSectionState(false) end
				return res
			end

			function SectionObj:AddMultiDropdown(text, optionsList, defaultSelected, callback, flagName)
				local res = TabObj:AddMultiDropdown(text, optionsList, defaultSelected, callback, flagName, ItemsContainer)
				if isOpen then updateSectionState(false) end
				return res
			end

			function SectionObj:AddTextBox(text, placeholder, callback, flagName)
				local res = TabObj:AddTextBox(text, placeholder, callback, flagName, ItemsContainer)
				if isOpen then updateSectionState(false) end
				return res
			end

			return SectionObj
		end

		function TabObj:AddButton(text, callback, targetParent)
			TabObj.ElementCount = TabObj.ElementCount + 1
			callback = callback or function() end
			targetParent = targetParent or TabPage

			local BtnFrame = Instance.new("Frame")
			BtnFrame.Size = UDim2.new(1, 0, 0, 38)
			BtnFrame.BackgroundColor3 = Color3.fromRGB(28, 28, 36)
			BtnFrame.LayoutOrder = TabObj.ElementCount
			BtnFrame.Parent = targetParent

			local Corner = Instance.new("UICorner")
			Corner.CornerRadius = UDim.new(0, 8)
			Corner.Parent = BtnFrame

			local Stroke = Instance.new("UIStroke")
			Stroke.Color = Color3.fromRGB(42, 42, 54)
			Stroke.Thickness = 1
			Stroke.Parent = BtnFrame

			local ActionBtn = Instance.new("TextButton")
			ActionBtn.Size = UDim2.new(1, 0, 1, 0)
			ActionBtn.BackgroundTransparency = 1
			ActionBtn.Text = text
			ActionBtn.Font = Enum.Font.GothamMedium
			ActionBtn.TextSize = 13
			ActionBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
			ActionBtn.Parent = BtnFrame

			ActionBtn.MouseEnter:Connect(function()
				BtnFrame.BackgroundColor3 = Color3.fromRGB(36, 36, 46)
			end)
			ActionBtn.MouseLeave:Connect(function()
				BtnFrame.BackgroundColor3 = Color3.fromRGB(28, 28, 36)
			end)
			ActionBtn.MouseButton1Click:Connect(function()
				pcall(callback)
			end)
		end

		function TabObj:AddButtonGroup2x2(buttonsData, targetParent)
			TabObj.ElementCount = TabObj.ElementCount + 1
			buttonsData = buttonsData or {}
			targetParent = targetParent or TabPage

			local GridContainer = Instance.new("Frame")
			GridContainer.Size = UDim2.new(1, 0, 0, 82)
			GridContainer.BackgroundTransparency = 1
			GridContainer.LayoutOrder = TabObj.ElementCount
			GridContainer.Parent = targetParent

			local Row1 = Instance.new("Frame")
			Row1.Size = UDim2.new(1, 0, 0, 38)
			Row1.Position = UDim2.new(0, 0, 0, 0)
			Row1.BackgroundTransparency = 1
			Row1.Parent = GridContainer

			local Row2 = Instance.new("Frame")
			Row2.Size = UDim2.new(1, 0, 0, 38)
			Row2.Position = UDim2.new(0, 0, 0, 44)
			Row2.BackgroundTransparency = 1
			Row2.Parent = GridContainer

			local function createGridBtn(btnData, rowParent, posXScale)
				local btnFrame = Instance.new("Frame")
				btnFrame.Size = UDim2.new(0.5, -4, 1, 0)
				btnFrame.Position = UDim2.new(posXScale, posXScale == 0 and 0 or 4, 0, 0)
				btnFrame.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
				btnFrame.Parent = rowParent

				local corner = Instance.new("UICorner")
				corner.CornerRadius = UDim.new(0, 8)
				corner.Parent = btnFrame

				local stroke = Instance.new("UIStroke")
				stroke.Color = Color3.fromRGB(48, 48, 65)
				stroke.Thickness = 1
				stroke.Parent = btnFrame

				local grad = Instance.new("UIGradient")
				grad.Rotation = 45
				grad.Color = ColorSequence.new({
					ColorSequenceKeypoint.new(0, Color3.fromRGB(42, 42, 58)),
					ColorSequenceKeypoint.new(1, Color3.fromRGB(22, 22, 32))
				})
				grad.Parent = btnFrame

				local textBtn = Instance.new("TextButton")
				textBtn.Size = UDim2.new(1, 0, 1, 0)
				textBtn.BackgroundTransparency = 1
				textBtn.Text = btnData.Text or "Button"
				textBtn.Font = Enum.Font.GothamBold
				textBtn.TextSize = 12
				textBtn.TextColor3 = Color3.fromRGB(240, 240, 255)
				textBtn.Parent = btnFrame

				textBtn.MouseEnter:Connect(function()
					TweenService:Create(stroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(120, 120, 180)}):Play()
					TweenService:Create(textBtn, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
				end)
				textBtn.MouseLeave:Connect(function()
					TweenService:Create(stroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(48, 48, 65)}):Play()
					TweenService:Create(textBtn, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(240, 240, 255)}):Play()
				end)

				textBtn.MouseButton1Click:Connect(function()
					if btnData.Callback then
						pcall(btnData.Callback)
					end
				end)
			end

			if buttonsData[1] then createGridBtn(buttonsData[1], Row1, 0) end
			if buttonsData[2] then createGridBtn(buttonsData[2], Row1, 0.5) end
			if buttonsData[3] then createGridBtn(buttonsData[3], Row2, 0) end
			if buttonsData[4] then createGridBtn(buttonsData[4], Row2, 0.5) end
		end

		function TabObj:AddToggle(text, defaultState, callback, flagName, targetParent)
			TabObj.ElementCount = TabObj.ElementCount + 1
			flagName = flagName or text
			local state = defaultState or false
			callback = callback or function() end
			targetParent = targetParent or TabPage

			WindowObj.Flags[flagName] = state

			local ToggleFrame = Instance.new("Frame")
			ToggleFrame.Size = UDim2.new(1, 0, 0, 40)
			ToggleFrame.BackgroundColor3 = Color3.fromRGB(28, 28, 36)
			ToggleFrame.LayoutOrder = TabObj.ElementCount
			ToggleFrame.Parent = targetParent

			local Corner = Instance.new("UICorner")
			Corner.CornerRadius = UDim.new(0, 8)
			Corner.Parent = ToggleFrame

			local Stroke = Instance.new("UIStroke")
			Stroke.Color = Color3.fromRGB(42, 42, 54)
			Stroke.Thickness = 1
			Stroke.Parent = ToggleFrame

			local Label = Instance.new("TextLabel")
			Label.Size = UDim2.new(1, -70, 1, 0)
			Label.Position = UDim2.new(0, 12, 0, 0)
			Label.BackgroundTransparency = 1
			Label.Text = text
			Label.Font = Enum.Font.GothamMedium
			Label.TextSize = 13
			Label.TextColor3 = Color3.fromRGB(255, 255, 255)
			Label.TextXAlignment = Enum.TextXAlignment.Left
			Label.Parent = ToggleFrame

			local SwitchBg = Instance.new("Frame")
			SwitchBg.Size = UDim2.new(0, 42, 0, 20)
			SwitchBg.Position = UDim2.new(1, -54, 0.5, -10)
			SwitchBg.BackgroundColor3 = state and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(48, 48, 62)
			SwitchBg.Parent = ToggleFrame

			local SwitchCorner = Instance.new("UICorner")
			SwitchCorner.CornerRadius = UDim.new(1, 0)
			SwitchCorner.Parent = SwitchBg

			local Dot = Instance.new("Frame")
			Dot.Size = UDim2.new(0, 14, 0, 14)
			Dot.Position = state and UDim2.new(1, -17, 0.5, -7) or UDim2.new(0, 3, 0.5, -7)
			Dot.BackgroundColor3 = state and Color3.fromRGB(20, 20, 26) or Color3.fromRGB(255, 255, 255)
			Dot.Parent = SwitchBg

			local DotCorner = Instance.new("UICorner")
			DotCorner.CornerRadius = UDim.new(1, 0)
			DotCorner.Parent = Dot

			local ClickArea = Instance.new("TextButton")
			ClickArea.Size = UDim2.new(1, 0, 1, 0)
			ClickArea.BackgroundTransparency = 1
			ClickArea.Text = ""
			ClickArea.Parent = ToggleFrame

			local function updateToggle(animated)
				WindowObj.Flags[flagName] = state
				local switchColor = state and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(48, 48, 62)
				local dotPos = state and UDim2.new(1, -17, 0.5, -7) or UDim2.new(0, 3, 0.5, -7)
				local dotColor = state and Color3.fromRGB(20, 20, 26) or Color3.fromRGB(255, 255, 255)

				if animated ~= false then
					TweenService:Create(SwitchBg, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
						BackgroundColor3 = switchColor
					}):Play()
					TweenService:Create(Dot, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
						Position = dotPos,
						BackgroundColor3 = dotColor
					}):Play()
				else
					SwitchBg.BackgroundColor3 = switchColor
					Dot.Position = dotPos
					Dot.BackgroundColor3 = dotColor
				end
			end

			ClickArea.MouseButton1Click:Connect(function()
				state = not state
				updateToggle(true)
				pcall(callback, state)
			end)

			local toggleElement = {}
			function toggleElement:Set(val, skipCallback)
				state = not not val
				updateToggle(true)
				if not skipCallback then
					pcall(callback, state)
				end
			end

			WindowObj.Elements[flagName] = toggleElement
			return toggleElement
		end

		function TabObj:AddSlider(text, minVal, maxVal, defaultVal, callback, flagName, targetParent)
			TabObj.ElementCount = TabObj.ElementCount + 1
			flagName = flagName or text
			minVal = minVal or 0
			maxVal = maxVal or 100
			defaultVal = defaultVal or minVal
			callback = callback or function() end
			targetParent = targetParent or TabPage

			local currentVal = math.clamp(defaultVal, minVal, maxVal)
			WindowObj.Flags[flagName] = currentVal

			local SliderFrame = Instance.new("Frame")
			SliderFrame.Size = UDim2.new(1, 0, 0, 50)
			SliderFrame.BackgroundColor3 = Color3.fromRGB(28, 28, 36)
			SliderFrame.LayoutOrder = TabObj.ElementCount
			SliderFrame.Parent = targetParent

			local Corner = Instance.new("UICorner")
			Corner.CornerRadius = UDim.new(0, 8)
			Corner.Parent = SliderFrame

			local Stroke = Instance.new("UIStroke")
			Stroke.Color = Color3.fromRGB(42, 42, 54)
			Stroke.Thickness = 1
			Stroke.Parent = SliderFrame

			local Label = Instance.new("TextLabel")
			Label.Size = UDim2.new(1, -80, 0, 22)
			Label.Position = UDim2.new(0, 12, 0, 4)
			Label.BackgroundTransparency = 1
			Label.Text = text
			Label.Font = Enum.Font.GothamMedium
			Label.TextSize = 13
			Label.TextColor3 = Color3.fromRGB(255, 255, 255)
			Label.TextXAlignment = Enum.TextXAlignment.Left
			Label.Parent = SliderFrame

			local ValLabel = Instance.new("TextLabel")
			ValLabel.Size = UDim2.new(0, 60, 0, 22)
			ValLabel.Position = UDim2.new(1, -72, 0, 4)
			ValLabel.BackgroundTransparency = 1
			ValLabel.Text = tostring(currentVal)
			ValLabel.Font = Enum.Font.GothamBold
			ValLabel.TextSize = 13
			ValLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
			ValLabel.TextXAlignment = Enum.TextXAlignment.Right
			ValLabel.Parent = SliderFrame

			local Track = Instance.new("Frame")
			Track.Size = UDim2.new(1, -24, 0, 6)
			Track.Position = UDim2.new(0, 12, 0, 33)
			Track.BackgroundColor3 = Color3.fromRGB(48, 48, 62)
			Track.Parent = SliderFrame

			local TrackCorner = Instance.new("UICorner")
			TrackCorner.CornerRadius = UDim.new(1, 0)
			TrackCorner.Parent = Track

			local Fill = Instance.new("Frame")
			Fill.Size = UDim2.new((currentVal - minVal) / (maxVal - minVal), 0, 1, 0)
			Fill.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Fill.Parent = Track

			local FillCorner = Instance.new("UICorner")
			FillCorner.CornerRadius = UDim.new(1, 0)
			FillCorner.Parent = Fill

			local Knob = Instance.new("Frame")
			Knob.Size = UDim2.new(0, 12, 0, 12)
			Knob.AnchorPoint = Vector2.new(0.5, 0.5)
			Knob.Position = UDim2.new((currentVal - minVal) / (maxVal - minVal), 0, 0.5, 0)
			Knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Knob.Parent = Track

			local KnobCorner = Instance.new("UICorner")
			KnobCorner.CornerRadius = UDim.new(1, 0)
			KnobCorner.Parent = Knob

			local isDragging = false

			local function updateSliderVisual(val)
				currentVal = math.clamp(val, minVal, maxVal)
				WindowObj.Flags[flagName] = currentVal
				ValLabel.Text = tostring(currentVal)
				local ratio = (currentVal - minVal) / (maxVal - minVal)
				Fill.Size = UDim2.new(ratio, 0, 1, 0)
				Knob.Position = UDim2.new(ratio, 0, 0.5, 0)
			end

			local function updateSlider(input)
				local trackAbsPos = Track.AbsolutePosition.X
				local trackAbsSize = Track.AbsoluteSize.X
				local mouseX = input.Position.X
				local ratio = math.clamp((mouseX - trackAbsPos) / trackAbsSize, 0, 1)
				local val = math.floor(minVal + (maxVal - minVal) * ratio)
				updateSliderVisual(val)
				pcall(callback, currentVal)
			end

			Track.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					isDragging = true
					updateSlider(input)
				end
			end)

			UserInputService.InputChanged:Connect(function(input)
				if isDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
					updateSlider(input)
				end
			end)

			UserInputService.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					isDragging = false
				end
			end)

			local sliderElement = {}
			function sliderElement:Set(val, skipCallback)
				updateSliderVisual(val)
				if not skipCallback then
					pcall(callback, currentVal)
				end
			end

			WindowObj.Elements[flagName] = sliderElement
			return sliderElement
		end

		function TabObj:AddDropdown(text, optionsList, defaultOpt, callback, flagName, targetParent)
			TabObj.ElementCount = TabObj.ElementCount + 1
			flagName = flagName or text
			optionsList = optionsList or {}
			defaultOpt = defaultOpt or optionsList[1] or ""
			callback = callback or function() end
			targetParent = targetParent or TabPage

			local selectedOption = defaultOpt
			WindowObj.Flags[flagName] = selectedOption

			local DropdownFrame = Instance.new("Frame")
			DropdownFrame.Size = UDim2.new(1, 0, 0, 40)
			DropdownFrame.BackgroundColor3 = Color3.fromRGB(28, 28, 36)
			DropdownFrame.LayoutOrder = TabObj.ElementCount
			DropdownFrame.Parent = targetParent

			local Corner = Instance.new("UICorner")
			Corner.CornerRadius = UDim.new(0, 8)
			Corner.Parent = DropdownFrame

			local Stroke = Instance.new("UIStroke")
			Stroke.Color = Color3.fromRGB(42, 42, 54)
			Stroke.Thickness = 1
			Stroke.Parent = DropdownFrame

			local HeaderBtn = Instance.new("TextButton")
			HeaderBtn.Size = UDim2.new(1, 0, 1, 0)
			HeaderBtn.BackgroundTransparency = 1
			HeaderBtn.Text = ""
			HeaderBtn.Parent = DropdownFrame

			local Label = Instance.new("TextLabel")
			Label.Size = UDim2.new(0.4, 0, 1, 0)
			Label.Position = UDim2.new(0, 12, 0, 0)
			Label.BackgroundTransparency = 1
			Label.Text = text
			Label.Font = Enum.Font.GothamMedium
			Label.TextSize = 13
			Label.TextColor3 = Color3.fromRGB(255, 255, 255)
			Label.TextXAlignment = Enum.TextXAlignment.Left
			Label.Parent = HeaderBtn

			local ValueBox = Instance.new("Frame")
			ValueBox.Size = UDim2.new(0, 160, 0, 26)
			ValueBox.Position = UDim2.new(1, -172, 0.5, -13)
			ValueBox.BackgroundColor3 = Color3.fromRGB(20, 20, 26)
			ValueBox.Parent = HeaderBtn

			local ValCorner = Instance.new("UICorner")
			ValCorner.CornerRadius = UDim.new(0, 6)
			ValCorner.Parent = ValueBox

			local ValText = Instance.new("TextLabel")
			ValText.Size = UDim2.new(1, -24, 1, 0)
			ValText.Position = UDim2.new(0, 8, 0, 0)
			ValText.BackgroundTransparency = 1
			ValText.Text = selectedOption
			ValText.Font = Enum.Font.Gotham
			ValText.TextSize = 12
			ValText.TextColor3 = Color3.fromRGB(255, 255, 255)
			ValText.TextXAlignment = Enum.TextXAlignment.Left
			ValText.TextTruncate = Enum.TextTruncate.AtEnd
			ValText.Parent = ValueBox

			local ArrowIcon = Instance.new("ImageLabel")
			ArrowIcon.Name = "ArrowIcon"
			ArrowIcon.Size = UDim2.new(0, 14, 0, 14)
			ArrowIcon.Position = UDim2.new(1, -18, 0.5, -7)
			ArrowIcon.BackgroundTransparency = 1
			ArrowIcon.ImageColor3 = Color3.fromRGB(200, 200, 215)
			ArrowIcon.Rotation = 0
			ArrowIcon.Parent = ValueBox
			applyIcon(ArrowIcon, "alt-arrow-down-bold")

			local dropdownOwner = { ArrowIcon = ArrowIcon }

			local function openThisDropdownDrawer()
				if currentActiveDrawerOwner == dropdownOwner then
					closeDrawer()
					return
				end

				currentActiveDrawerOwner = dropdownOwner
				DrawerTitle.Text = text

				for _, child in pairs(DrawerScroll:GetChildren()) do
					if child:IsA("TextButton") then child:Destroy() end
				end

				for idx, opt in ipairs(optionsList) do
					local isSelected = (opt == selectedOption)
					local ItemBtn = Instance.new("TextButton")
					ItemBtn.Size = UDim2.new(1, 0, 0, 32)
					ItemBtn.BackgroundColor3 = isSelected and Color3.fromRGB(45, 45, 60) or Color3.fromRGB(28, 28, 38)
					ItemBtn.Text = "  " .. opt
					ItemBtn.Font = Enum.Font.GothamMedium
					ItemBtn.TextSize = 12
					ItemBtn.TextColor3 = isSelected and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(180, 180, 195)
					ItemBtn.TextXAlignment = Enum.TextXAlignment.Left
					ItemBtn.LayoutOrder = idx
					ItemBtn.Parent = DrawerScroll

					local ItemCorner = Instance.new("UICorner")
					ItemCorner.CornerRadius = UDim.new(0, 6)
					ItemCorner.Parent = ItemBtn

					ItemBtn.MouseEnter:Connect(function()
						if opt ~= selectedOption then
							ItemBtn.BackgroundColor3 = Color3.fromRGB(36, 36, 48)
						end
					end)
					ItemBtn.MouseLeave:Connect(function()
						if opt ~= selectedOption then
							ItemBtn.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
						end
					end)

					ItemBtn.MouseButton1Click:Connect(function()
						selectedOption = opt
						WindowObj.Flags[flagName] = selectedOption
						ValText.Text = selectedOption
						closeDrawer()
						pcall(callback, selectedOption)
					end)
				end

				DropdownDrawer.Visible = true
				DropdownDrawer.Position = UDim2.new(1, 0, 0, 48)
				TweenService:Create(DropdownDrawer, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
					Position = UDim2.new(1, -230, 0, 48)
				}):Play()

				TweenService:Create(ArrowIcon, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Rotation = 180}):Play()
			end

			HeaderBtn.MouseButton1Click:Connect(openThisDropdownDrawer)

			local dropdownElement = {}
			function dropdownElement:Set(val, skipCallback)
				selectedOption = val
				WindowObj.Flags[flagName] = selectedOption
				ValText.Text = selectedOption
				if not skipCallback then
					pcall(callback, selectedOption)
				end
			end

			function dropdownElement:Refresh(newList, newDefault)
				optionsList = newList or optionsList
				if newDefault then
					selectedOption = newDefault
					WindowObj.Flags[flagName] = selectedOption
					ValText.Text = selectedOption
				end
			end

			WindowObj.Elements[flagName] = dropdownElement
			return dropdownElement
		end

		function TabObj:AddMultiDropdown(text, optionsList, defaultSelected, callback, flagName, targetParent)
			TabObj.ElementCount = TabObj.ElementCount + 1
			flagName = flagName or text
			optionsList = optionsList or {}
			defaultSelected = defaultSelected or {}
			callback = callback or function() end
			targetParent = targetParent or TabPage

			local selectedMap = {}
			for _, val in ipairs(defaultSelected) do
				selectedMap[val] = true
			end

			local DropdownFrame = Instance.new("Frame")
			DropdownFrame.Size = UDim2.new(1, 0, 0, 40)
			DropdownFrame.BackgroundColor3 = Color3.fromRGB(28, 28, 36)
			DropdownFrame.LayoutOrder = TabObj.ElementCount
			DropdownFrame.Parent = targetParent

			local Corner = Instance.new("UICorner")
			Corner.CornerRadius = UDim.new(0, 8)
			Corner.Parent = DropdownFrame

			local Stroke = Instance.new("UIStroke")
			Stroke.Color = Color3.fromRGB(42, 42, 54)
			Stroke.Thickness = 1
			Stroke.Parent = DropdownFrame

			local HeaderBtn = Instance.new("TextButton")
			HeaderBtn.Size = UDim2.new(1, 0, 1, 0)
			HeaderBtn.BackgroundTransparency = 1
			HeaderBtn.Text = ""
			HeaderBtn.Parent = DropdownFrame

			local Label = Instance.new("TextLabel")
			Label.Size = UDim2.new(0.4, 0, 1, 0)
			Label.Position = UDim2.new(0, 12, 0, 0)
			Label.BackgroundTransparency = 1
			Label.Text = text
			Label.Font = Enum.Font.GothamMedium
			Label.TextSize = 13
			Label.TextColor3 = Color3.fromRGB(255, 255, 255)
			Label.TextXAlignment = Enum.TextXAlignment.Left
			Label.Parent = HeaderBtn

			local ValueBox = Instance.new("Frame")
			ValueBox.Size = UDim2.new(0, 160, 0, 26)
			ValueBox.Position = UDim2.new(1, -172, 0.5, -13)
			ValueBox.BackgroundColor3 = Color3.fromRGB(20, 20, 26)
			ValueBox.Parent = HeaderBtn

			local ValCorner = Instance.new("UICorner")
			ValCorner.CornerRadius = UDim.new(0, 6)
			ValCorner.Parent = ValueBox

			local ValText = Instance.new("TextLabel")
			ValText.Size = UDim2.new(1, -24, 1, 0)
			ValText.Position = UDim2.new(0, 8, 0, 0)
			ValText.BackgroundTransparency = 1
			ValText.Font = Enum.Font.Gotham
			ValText.TextSize = 12
			ValText.TextColor3 = Color3.fromRGB(255, 255, 255)
			ValText.TextXAlignment = Enum.TextXAlignment.Left
			ValText.TextTruncate = Enum.TextTruncate.AtEnd
			ValText.Parent = ValueBox

			local ArrowIcon = Instance.new("ImageLabel")
			ArrowIcon.Name = "ArrowIcon"
			ArrowIcon.Size = UDim2.new(0, 14, 0, 14)
			ArrowIcon.Position = UDim2.new(1, -18, 0.5, -7)
			ArrowIcon.BackgroundTransparency = 1
			ArrowIcon.ImageColor3 = Color3.fromRGB(200, 200, 215)
			ArrowIcon.Rotation = 0
			ArrowIcon.Parent = ValueBox
			applyIcon(ArrowIcon, "alt-arrow-down-bold")

			local function getSelectedList()
				local result = {}
				for _, opt in ipairs(optionsList) do
					if selectedMap[opt] then
						table.insert(result, opt)
					end
				end
				return result
			end

			local function updateHeaderLabel()
				local list = getSelectedList()
				WindowObj.Flags[flagName] = list
				if #list == 0 then
					ValText.Text = "Pilih..."
				else
					ValText.Text = table.concat(list, ", ")
				end
			end

			updateHeaderLabel()

			local dropdownOwner = { ArrowIcon = ArrowIcon }

			local function renderDrawerItems()
				for _, child in pairs(DrawerScroll:GetChildren()) do
					if child:IsA("TextButton") then child:Destroy() end
				end

				for idx, opt in ipairs(optionsList) do
					local isSel = selectedMap[opt] or false

					local ItemBtn = Instance.new("TextButton")
					ItemBtn.Size = UDim2.new(1, 0, 0, 32)
					ItemBtn.BackgroundColor3 = isSel and Color3.fromRGB(45, 45, 60) or Color3.fromRGB(28, 28, 38)
					ItemBtn.Text = (isSel and "  [x]  " or "  [  ]  ") .. opt
					ItemBtn.Font = Enum.Font.GothamMedium
					ItemBtn.TextSize = 12
					ItemBtn.TextColor3 = isSel and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(180, 180, 195)
					ItemBtn.TextXAlignment = Enum.TextXAlignment.Left
					ItemBtn.LayoutOrder = idx
					ItemBtn.Parent = DrawerScroll

					local ItemCorner = Instance.new("UICorner")
					ItemCorner.CornerRadius = UDim.new(0, 6)
					ItemCorner.Parent = ItemBtn

					ItemBtn.MouseButton1Click:Connect(function()
						selectedMap[opt] = not selectedMap[opt]
						updateHeaderLabel()
						renderDrawerItems()
						pcall(callback, getSelectedList())
					end)
				end
			end

			local function openThisMultiDropdownDrawer()
				if currentActiveDrawerOwner == dropdownOwner then
					closeDrawer()
					return
				end

				currentActiveDrawerOwner = dropdownOwner
				DrawerTitle.Text = text

				renderDrawerItems()

				DropdownDrawer.Visible = true
				DropdownDrawer.Position = UDim2.new(1, 0, 0, 48)
				TweenService:Create(DropdownDrawer, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
					Position = UDim2.new(1, -230, 0, 48)
				}):Play()

				TweenService:Create(ArrowIcon, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Rotation = 180}):Play()
			end

			HeaderBtn.MouseButton1Click:Connect(openThisMultiDropdownDrawer)

			local multiElement = {}
			function multiElement:Set(valList, skipCallback)
				selectedMap = {}
				if type(valList) == "table" then
					for _, opt in ipairs(valList) do
						selectedMap[opt] = true
					end
				end
				updateHeaderLabel()
				if not skipCallback then
					pcall(callback, getSelectedList())
				end
			end

			WindowObj.Elements[flagName] = multiElement
			return multiElement
		end

		function TabObj:AddTextBox(text, placeholder, callback, flagName, targetParent)
			TabObj.ElementCount = TabObj.ElementCount + 1
			flagName = flagName or text
			placeholder = placeholder or "Ketik di sini..."
			callback = callback or function() end
			targetParent = targetParent or TabPage

			WindowObj.Flags[flagName] = ""

			local BoxFrame = Instance.new("Frame")
			BoxFrame.Size = UDim2.new(1, 0, 0, 40)
			BoxFrame.BackgroundColor3 = Color3.fromRGB(28, 28, 36)
			BoxFrame.LayoutOrder = TabObj.ElementCount
			BoxFrame.Parent = targetParent

			local Corner = Instance.new("UICorner")
			Corner.CornerRadius = UDim.new(0, 8)
			Corner.Parent = BoxFrame

			local Stroke = Instance.new("UIStroke")
			Stroke.Color = Color3.fromRGB(42, 42, 54)
			Stroke.Thickness = 1
			Stroke.Parent = BoxFrame

			local Label = Instance.new("TextLabel")
			Label.Size = UDim2.new(0.4, 0, 1, 0)
			Label.Position = UDim2.new(0, 12, 0, 0)
			Label.BackgroundTransparency = 1
			Label.Text = text
			Label.Font = Enum.Font.GothamMedium
			Label.TextSize = 13
			Label.TextColor3 = Color3.fromRGB(255, 255, 255)
			Label.TextXAlignment = Enum.TextXAlignment.Left
			Label.Parent = BoxFrame

			local InputBox = Instance.new("TextBox")
			InputBox.Size = UDim2.new(0, 160, 0, 26)
			InputBox.Position = UDim2.new(1, -172, 0.5, -13)
			InputBox.BackgroundColor3 = Color3.fromRGB(20, 20, 26)
			InputBox.Text = ""
			InputBox.PlaceholderText = placeholder
			InputBox.PlaceholderColor3 = Color3.fromRGB(130, 130, 145)
			InputBox.Font = Enum.Font.Gotham
			InputBox.TextSize = 12
			InputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
			InputBox.ClearTextOnFocus = false
			InputBox.Parent = BoxFrame

			local InputCorner = Instance.new("UICorner")
			InputCorner.CornerRadius = UDim.new(0, 6)
			InputCorner.Parent = InputBox

			InputBox.FocusLost:Connect(function(enterPressed)
				WindowObj.Flags[flagName] = InputBox.Text
				pcall(callback, InputBox.Text, enterPressed)
			end)

			local boxElement = {}
			function boxElement:Set(val, skipCallback)
				InputBox.Text = tostring(val or "")
				WindowObj.Flags[flagName] = InputBox.Text
				if not skipCallback then
					pcall(callback, InputBox.Text, true)
				end
			end

			WindowObj.Elements[flagName] = boxElement
			return boxElement
		end

		return TabObj
	end

	return WindowObj
end

if type(getgenv) == "function" then
	getgenv().CloudyLib = CloudyLib
end

return CloudyLib
