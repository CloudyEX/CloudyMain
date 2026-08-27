local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local VirtualUser = game:GetService("VirtualUser")
local TextService = game:GetService("TextService")

local TI_FAST = TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local TI_MED = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
local TI_BACK_IN = TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.InOut)
local TI_BACK_OUT = TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local TI_QUAD_OUT = TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local TI_RIPPLE = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

local Custom = {}
do
	Custom.ColorRGB = Color3.fromRGB(0, 162, 255)
	Custom.BgDark = Color3.fromRGB(11, 15, 25)
	Custom.BgHeader = Color3.fromRGB(8, 12, 20)
	Custom.BgCard = Color3.fromRGB(16, 23, 38)
	Custom.BgCardHover = Color3.fromRGB(24, 34, 56)
	Custom.BorderColor = Color3.fromRGB(28, 42, 68)
	Custom.TextMuted = Color3.fromRGB(130, 145, 170)
	Custom.TextBright = Color3.fromRGB(235, 242, 255)

	Custom.GradientBlueWhite = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 162, 255)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
	})

	Custom.DefaultIcon = "rbxassetid://135368942844516"
	Custom.DefaultBg = "rbxassetid://124551712031440"
	Custom.FloatingIcon = "rbxassetid://123520016778632"

	function Custom:Create(Name, Properties, Parent)
		local inst = Instance.new(Name)
		for k, v in pairs(Properties) do
			inst[k] = v
		end
		if Parent then inst.Parent = Parent end
		return inst
	end

	local afkConnection
	function Custom:EnabledAFK()
		if afkConnection then return end
		pcall(function()
			afkConnection = Player.Idled:Connect(function()
				VirtualUser:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
				task.wait(1)
				VirtualUser:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
			end)
		end)
	end

	function Custom:AddGradient(inst, Rotation)
		return Custom:Create("UIGradient", {
			Color = Custom.GradientBlueWhite,
			Rotation = Rotation or 0,
		}, inst)
	end

	function Custom:ResolveIcon(Icon)
		if Icon == nil or Icon == "" or Icon == "rbxassetid://0" or Icon == "rbxassetid://" then
			return Custom.DefaultIcon
		end
		return Icon
	end
end

pcall(function() Custom:EnabledAFK() end)

local function OpenClose()
	local ScreenGui = Custom:Create("ScreenGui", {
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
		ResetOnSpawn = false,
	}, RunService:IsStudio() and Player.PlayerGui or (gethui and gethui() or cloneref and cloneref(game:GetService("CoreGui")) or game:GetService("CoreGui")))

	local Close_ImageButton = Custom:Create("ImageButton", {
		BackgroundColor3 = Custom.BgDark,
		BorderColor3 = Custom.ColorRGB,
		BackgroundTransparency = 0.15,
		Position = UDim2.new(0.1021, 0, 0.0743, 0),
		Size = UDim2.new(0, 52, 0, 52),
		Image = Custom.FloatingIcon,
		ScaleType = Enum.ScaleType.Fit,
		Visible = false,
	}, ScreenGui)

	Custom:Create("UICorner", {
		Name = "MainCorner",
		CornerRadius = UDim.new(1, 0),
	}, Close_ImageButton)

	Custom:Create("UIStroke", {
		Color = Custom.ColorRGB,
		Thickness = 2,
	}, Close_ImageButton)

	Close_ImageButton.MouseEnter:Connect(function()
		TweenService:Create(Close_ImageButton, TI_FAST, {BackgroundTransparency = 0.05, Size = UDim2.new(0, 55, 0, 55)}):Play()
	end)

	Close_ImageButton.MouseLeave:Connect(function()
		TweenService:Create(Close_ImageButton, TI_FAST, {BackgroundTransparency = 0.15, Size = UDim2.new(0, 52, 0, 52)}):Play()
	end)

	local dragging, dragStart, startPos = false, nil, nil

	Close_ImageButton.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			dragStart = input.Position
			startPos = Close_ImageButton.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then dragging = false end
			end)
		end
	end)

	Close_ImageButton.InputChanged:Connect(function(input)
		if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			local delta = input.Position - dragStart
			Close_ImageButton.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
	end)

	return Close_ImageButton
end

local Open_Close = OpenClose()

local function MakeDraggable(topbar, object)
	local dragging, dragStart, startPos = false, nil, nil

	topbar.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = object.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then dragging = false end
			end)
		end
	end)

	topbar.InputChanged:Connect(function(input)
		if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			local delta = input.Position - dragStart
			object.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
	end)
end

local function CircleClick(Button, X, Y)
	task.spawn(function()
		Button.ClipsDescendants = true
		local Circle = Instance.new("ImageLabel")
		Circle.Image = "rbxassetid://106471194043211"
		Circle.ImageColor3 = Custom.ColorRGB
		Circle.ImageTransparency = 0.7
		Circle.BackgroundTransparency = 1
		Circle.ZIndex = 10
		Circle.Name = "Circle"
		Circle.Parent = Button

		local NewX = X - Button.AbsolutePosition.X
		local NewY = Y - Button.AbsolutePosition.Y
		Circle.Position = UDim2.new(0, NewX, 0, NewY)

		local Size = math.max(Button.AbsoluteSize.X, Button.AbsoluteSize.Y) * 1.5
		local Tween = TweenService:Create(Circle, TI_RIPPLE, {
			Size = UDim2.new(0, Size, 0, Size),
			Position = UDim2.new(0.5, -Size/2, 0.5, -Size/2),
			ImageTransparency = 1
		})
		Tween:Play()
		Tween.Completed:Connect(function()
			Circle:Destroy()
		end)
	end)
end

local w424_Library = {}
w424_Library.Unloaded = false

local NotifGui
local NotifContainer
local NotifCounter = 0
local NOTIF_WIDTH = 260

local function EnsureNotifGui()
	if NotifGui and NotifGui.Parent then return end

	NotifGui = Custom:Create("ScreenGui", {
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
		ResetOnSpawn = false,
	}, RunService:IsStudio() and Player.PlayerGui or (gethui and gethui() or cloneref and cloneref(game:GetService("CoreGui")) or game:GetService("CoreGui")))

	NotifContainer = Custom:Create("Frame", {
		AnchorPoint = Vector2.new(1, 0),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Position = UDim2.new(1, -14, 0, 14),
		Size = UDim2.new(0, NOTIF_WIDTH, 1, -28),
		Name = "NotifContainer"
	}, NotifGui)

	Custom:Create("UIListLayout", {
		SortOrder = Enum.SortOrder.LayoutOrder,
		VerticalAlignment = Enum.VerticalAlignment.Top,
		HorizontalAlignment = Enum.HorizontalAlignment.Right,
		Padding = UDim.new(0, 8),
	}, NotifContainer)
end

function w424_Library:SetNotification(Config)
	EnsureNotifGui()

	if type(Config) == "string" then Config = {Text = Config} end
	local Title = Config.Title or ""
	local Text = Config.Text or Config.Content or Config[1] or ""
	if Title ~= "" and Text ~= "" then
		Text = Title .. " | " .. Text
	elseif Title ~= "" and Text == "" then
		Text = Title
	end
	local Delay = tonumber(Config.Delay or Config.Duration or Config[6]) or 3
	local AnimT = tonumber(Config.Time or Config[5]) or 0.25

	NotifCounter += 1

	local Closed = false
	local BarTween = nil
	local NotifFuncs = {}

	local TextSize = TextService:GetTextSize(
		Text, 13, Enum.Font.GothamBold,
		Vector2.new(NOTIF_WIDTH - 24, 1000)
	)
	local CardH = math.max(TextSize.Y + 22, 34)

	local Slot = Custom:Create("Frame", {
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		LayoutOrder = NotifCounter,
		Size = UDim2.new(1, 0, 0, CardH),
		Name = "NotifSlot"
	}, NotifContainer)

	local Card = Custom:Create("Frame", {
		BackgroundColor3 = Custom.BgCard,
		BackgroundTransparency = 0.05,
		BorderSizePixel = 0,
		Position = UDim2.new(1, NOTIF_WIDTH + 20, 0, 0),
		Size = UDim2.new(1, 0, 1, 0),
		Name = "Card"
	}, Slot)
	Custom:Create("UICorner", {CornerRadius = UDim.new(0, 6)}, Card)
	Custom:Create("UIStroke", {Color = Custom.BorderColor, Thickness = 1}, Card)

	Custom:Create("TextLabel", {
		Font = Enum.Font.GothamBold,
		Text = Text,
		TextColor3 = Custom.TextBright,
		TextSize = 13,
		TextWrapped = true,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Center,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Position = UDim2.new(0, 12, 0, 0),
		Size = UDim2.new(1, -20, 1, -8),
		Name = "Label"
	}, Card)

	local BarTrack = Custom:Create("Frame", {
		AnchorPoint = Vector2.new(0, 1),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 0.9,
		BorderSizePixel = 0,
		Position = UDim2.new(0, 8, 1, -4),
		Size = UDim2.new(1, -16, 0, 2),
		Name = "BarTrack"
	}, Card)
	Custom:Create("UICorner", {CornerRadius = UDim.new(1, 0)}, BarTrack)

	local Bar = Custom:Create("Frame", {
		BackgroundColor3 = Custom.ColorRGB,
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 1, 0),
		Name = "Bar"
	}, BarTrack)
	Custom:Create("UICorner", {CornerRadius = UDim.new(1, 0)}, Bar)

	local animInfo = TweenInfo.new(AnimT, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	TweenService:Create(Card, animInfo, {
		Position = UDim2.new(0, 0, 0, 0)
	}):Play()

	task.spawn(function()
		BarTween = TweenService:Create(Bar, TweenInfo.new(Delay, Enum.EasingStyle.Linear), {
			Size = UDim2.new(0, 0, 1, 0)
		})
		BarTween:Play()
		BarTween.Completed:Connect(function(State)
			if State == Enum.PlaybackState.Completed and not Closed then
				NotifFuncs:Close()
			end
		end)
	end)

	local function DoClose()
		if Closed then return end
		Closed = true
		if BarTween then pcall(function() BarTween:Cancel() end) end

		local Out = TweenService:Create(Card, TweenInfo.new(AnimT, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
			Position = UDim2.new(1, NOTIF_WIDTH + 20, 0, 0)
		})
		Out:Play()
		Out.Completed:Wait()
		if Slot and Slot.Parent then Slot:Destroy() end
	end

	function NotifFuncs:Close()
		task.spawn(DoClose)
	end

	return NotifFuncs
end

w424_Library.Notify = w424_Library.SetNotification

function w424_Library:CreateWindow(Config)
	if type(Config) == "string" then Config = {Title = Config} end
	local Title = Config[1] or Config.Title or "w424"
	local Description = Config[2] or Config.Description or "v1.0"
	local TabWidth = Config[3] or Config["Tab Width"] or Config.TabWidth or 110
	local SizeUi = Config[4] or Config.SizeUi or UDim2.fromOffset(500, 290)
	local Keybind = Config[5] or Config.Keybind or Enum.KeyCode.RightControl
	local Icon = Config[6] or Config.Icon or "rbxassetid://135368942844516"
	local BackgroundImageId = Config.BackgroundImage or Config.Background or Custom.DefaultBg

	local Funcs = {}
	local SearchRegistry = {}
	local ActiveConnections = {}

	local MugiHubGui = Custom:Create("ScreenGui", {
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
		ResetOnSpawn = false,
	}, RunService:IsStudio() and Player.PlayerGui or (gethui and gethui() or cloneref and cloneref(game:GetService("CoreGui")) or game:GetService("CoreGui")))

	local DropShadowHolder = Custom:Create("Frame", {
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.new(0, 400, 0, 310),
		ZIndex = 0,
		Name = "DropShadowHolder",
		Position = UDim2.new(0, (MugiHubGui.AbsoluteSize.X // 2 - 400 // 2), 0, (MugiHubGui.AbsoluteSize.Y // 2 - 310 // 2))
	}, MugiHubGui)

	local DropShadow = Custom:Create("ImageLabel", {
		Image = "",
		ImageColor3 = Color3.fromRGB(0, 5, 12),
		ImageTransparency = 0.5,
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(49, 49, 450, 450),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Position = UDim2.new(0.5, 0, 0.5, 0),
		Size = SizeUi,
		ZIndex = 0,
		Name = "DropShadow"
	}, DropShadowHolder)

	local Main = Custom:Create("Frame", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = Custom.BgDark,
		BackgroundTransparency = 0.1,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		Position = UDim2.new(0.5, 0, 0.5, 0),
		Size = SizeUi,
		Name = "Main"
	}, DropShadow)

	Custom:Create("UICorner", {CornerRadius = UDim.new(0, 8)}, Main)
	Custom:Create("UIStroke", {Color = Custom.BorderColor, Thickness = 1.4}, Main)

	if BackgroundImageId and BackgroundImageId ~= "" then
		local BgImage = Custom:Create("ImageLabel", {
			Image = BackgroundImageId,
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Position = UDim2.new(0.5, 0, 0.5, 0),
			Size = UDim2.new(1, 0, 1, 0),
			ScaleType = Enum.ScaleType.Crop,
			ImageTransparency = Config.BackgroundTransparency or 0.35,
			ZIndex = 0,
			Name = "CustomBackground"
		}, Main)
		Custom:Create("UICorner", {CornerRadius = UDim.new(0, 8)}, BgImage)
	end

	local Top = Custom:Create("Frame", {
		BackgroundColor3 = Custom.BgHeader,
		BackgroundTransparency = 0.35,
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 0, 38),
		ZIndex = 2,
		Name = "Top"
	}, Main)
	Custom:Create("UICorner", {CornerRadius = UDim.new(0, 8)}, Top)

	local TextLabel = Custom:Create("TextLabel", {
		Font = Enum.Font.GothamBold,
		Text = Title,
		TextColor3 = Custom.ColorRGB,
		TextSize = 14,
		TextXAlignment = Enum.TextXAlignment.Left,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ZIndex = 3,
		Size = UDim2.new(1, -100, 1, 0),
		Position = UDim2.new(0, 10, 0, 0)
	}, Top)

	local IconWidth = 0
	if Icon ~= "" then
		IconWidth = 34
		Custom:Create("ImageLabel", {
			Image = Icon,
			AnchorPoint = Vector2.new(0, 0.5),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Position = UDim2.new(0, 8, 0.5, 0),
			Size = UDim2.new(0, 24, 0, 24),
			ZIndex = 3,
			Name = "Icon"
		}, Top)
		TextLabel.Position = UDim2.new(0, 10 + IconWidth, 0, 0)
	end

	local Separator = Custom:Create("TextLabel", {
		Font = Enum.Font.GothamBold,
		Text = "|",
		TextColor3 = Color3.fromRGB(50, 70, 100),
		TextSize = 14,
		TextXAlignment = Enum.TextXAlignment.Left,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ZIndex = 3,
		Size = UDim2.new(0, 12, 1, 0),
		Position = UDim2.new(0, 10 + IconWidth + TextLabel.TextBounds.X + 8, 0, 0),
		Name = "Separator"
	}, Top)

	local TextLabel1 = Custom:Create("TextLabel", {
		Font = Enum.Font.Gotham,
		Text = Description,
		TextColor3 = Custom.TextMuted,
		TextSize = 12,
		TextXAlignment = Enum.TextXAlignment.Left,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ZIndex = 3,
		Size = UDim2.new(0, 300, 1, 0),
		Position = UDim2.new(0, Separator.Position.X.Offset + 14, 0, 0)
	}, Top)

	local Close, Min
	local TagsFuncs = {}
	local TagList = {}
	local MAX_TAGS = 3

	local function RelayoutTags()
		local TotalWidth = 0
		for i, d in ipairs(TagList) do
			TotalWidth = TotalWidth + d.Frame.Size.X.Offset
			if i < #TagList then TotalWidth = TotalWidth + 6 end
		end
		local DescEndX = TextLabel1.Position.X.Offset + TextLabel1.TextBounds.X + 12
		local MinLeftX = Min and ((Min.AbsolutePosition.X - Top.AbsolutePosition.X) - 10) or (DescEndX + TotalWidth)
		local StartX = math.max(DescEndX, MinLeftX - TotalWidth)
		local OffsetX = StartX
		for _, d in ipairs(TagList) do
			d.Frame.Position = UDim2.new(0, OffsetX, 0.5, 0)
			OffsetX = OffsetX + d.Frame.Size.X.Offset + 6
		end
	end

	function TagsFuncs:Add(Text)
		if #TagList >= MAX_TAGS then return {Frame = nil, Set = function() end, Remove = function() end} end
		Text = Text or "Tag"
		local TagFrame = Custom:Create("Frame", {
			AnchorPoint = Vector2.new(0, 0.5),
			BackgroundColor3 = Custom.BgCard,
			BackgroundTransparency = 0.3,
			BorderSizePixel = 0,
			Position = UDim2.new(0, 0, 0.5, 0),
			Size = UDim2.new(0, 10, 0, 20),
			ZIndex = 3,
			Name = "Tag"
		}, Top)
		Custom:Create("UICorner", {CornerRadius = UDim.new(1, 0)}, TagFrame)
		Custom:Create("UIStroke", {Color = Custom.BorderColor, Thickness = 1}, TagFrame)
		local TagLabel = Custom:Create("TextLabel", {
			Font = Enum.Font.GothamBold,
			Text = Text,
			TextColor3 = Custom.TextBright,
			TextSize = 11,
			BackgroundTransparency = 1,
			ZIndex = 4,
			Size = UDim2.new(1, 0, 1, 0),
			Name = "TagLabel"
		}, TagFrame)
		local TagEntry = {Frame = TagFrame, Label = TagLabel}
		table.insert(TagList, TagEntry)
		local TagItemFuncs = {Frame = TagFrame}
		function TagItemFuncs:Set(NewText)
			TagLabel.Text = NewText
			local function Resize()
				TagFrame.Size = UDim2.new(0, TagLabel.TextBounds.X + 16, 0, 20)
				RelayoutTags()
			end
			Resize(); task.defer(Resize)
		end
		function TagItemFuncs:Remove()
			for i, v in ipairs(TagList) do
				if v == TagEntry then table.remove(TagList, i); break end
			end
			TagFrame:Destroy(); RelayoutTags()
		end
		TagItemFuncs:Set(Text)
		return TagItemFuncs
	end

	function TagsFuncs:AddDynamic(Label, ValueFn, RefreshInterval)
		Label = Label or ""; ValueFn = ValueFn or function() return "" end
		local function ComputeText()
			local Ok, Value = pcall(ValueFn)
			Value = (Ok and Value ~= nil and tostring(Value)) or "Unknown"
			return (Label ~= "" and (Label .. ": " .. Value)) or Value
		end
		local TagItemFuncs = TagsFuncs:Add("● " .. ComputeText())
		if RefreshInterval then
			task.spawn(function()
				while TagItemFuncs.Frame and TagItemFuncs.Frame.Parent and not w424_Library.Unloaded do
					task.wait(RefreshInterval)
					if not (TagItemFuncs.Frame and TagItemFuncs.Frame.Parent) then break end
					TagItemFuncs:Set("● " .. ComputeText())
				end
			end)
		end
		return TagItemFuncs
	end

	function TagsFuncs:AddExecutorTag(RefreshInterval)
		return TagsFuncs:AddDynamic("Executor", function()
			if identifyexecutor then return identifyexecutor() or "Unknown" end
			return "Unknown"
		end, RefreshInterval)
	end

	Funcs.Tags = TagsFuncs

	function Funcs:SetTitle(NewTitle)
		TextLabel.Text = NewTitle
		Separator.Position = UDim2.new(0, 10 + IconWidth + TextLabel.TextBounds.X + 8, 0, 0)
		TextLabel1.Position = UDim2.new(0, Separator.Position.X.Offset + 14, 0, 0)
		RelayoutTags()
	end

	function Funcs:SetDescription(NewDescription)
		TextLabel1.Text = NewDescription
		RelayoutTags()
	end

	Close = Custom:Create("TextButton", {
		Font = Enum.Font.GothamBold,
		Text = "X",
		TextColor3 = Custom.TextBright,
		TextSize = 14,
		AnchorPoint = Vector2.new(1, 0.5),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ZIndex = 4,
		Position = UDim2.new(1, -8, 0.5, 0),
		Size = UDim2.new(0, 28, 0, 24),
		Name = "Close"
	}, Top)
	Custom:Create("UICorner", {CornerRadius = UDim.new(0, 5)}, Close)

	Min = Custom:Create("TextButton", {
		Font = Enum.Font.GothamBold,
		Text = "—",
		TextColor3 = Custom.TextBright,
		TextSize = 14,
		AnchorPoint = Vector2.new(1, 0.5),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ZIndex = 4,
		Position = UDim2.new(1, -42, 0.5, 0),
		Size = UDim2.new(0, 32, 0, 24),
		Name = "Min"
	}, Top)
	Custom:Create("UICorner", {CornerRadius = UDim.new(0, 5)}, Min)

	if Config.Tags or Config[7] then
		for _, TagText in ipairs(Config.Tags or Config[7]) do
			TagsFuncs:Add(TagText)
		end
	end

	local LayersTab = Custom:Create("Frame", {
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Position = UDim2.new(0, 9, 0, 48),
		Size = UDim2.new(0, TabWidth, 1, -56),
		ZIndex = 2,
		Name = "LayersTab"
	}, Main)

	local SearchBoxContainer = Custom:Create("Frame", {
		BackgroundColor3 = Custom.BgCard,
		BackgroundTransparency = 0.25,
		BorderSizePixel = 0,
		Position = UDim2.new(0, 0, 0, 0),
		Size = UDim2.new(1, 0, 0, 26),
		ZIndex = 2,
		Name = "SearchBoxContainer"
	}, LayersTab)
	Custom:Create("UICorner", {CornerRadius = UDim.new(0, 4)}, SearchBoxContainer)
	Custom:Create("UIStroke", {Color = Custom.BorderColor, Thickness = 1}, SearchBoxContainer)

	local SearchIcon = Custom:Create("Frame", {
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Position = UDim2.new(0, 7, 0.5, 0),
		Size = UDim2.new(0, 11, 0, 11),
		ZIndex = 3,
		Name = "SearchIcon"
	}, SearchBoxContainer)
	local SearchIconLens = Custom:Create("Frame", {
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Position = UDim2.new(0, 0, 0, 0),
		Size = UDim2.new(0, 8, 0, 8),
		ZIndex = 3,
		Name = "Lens"
	}, SearchIcon)
	Custom:Create("UICorner", {CornerRadius = UDim.new(1, 0)}, SearchIconLens)
	local LensStroke = Custom:Create("UIStroke", {Color = Custom.TextMuted, Thickness = 1.3}, SearchIconLens)
	local SearchHandle = Custom:Create("Frame", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = Custom.TextMuted,
		BorderSizePixel = 0,
		Rotation = 45,
		Position = UDim2.new(0, 9, 0, 9),
		Size = UDim2.new(0, 1.6, 0, 5),
		ZIndex = 3,
		Name = "Handle"
	}, SearchIcon)
	Custom:Create("UICorner", {CornerRadius = UDim.new(1, 0)}, SearchHandle)

	local SearchBox = Custom:Create("TextBox", {
		Font = Enum.Font.GothamBold,
		PlaceholderText = "Search...",
		PlaceholderColor3 = Custom.TextMuted,
		Text = "",
		TextColor3 = Custom.TextBright,
		TextSize = 12,
		TextXAlignment = Enum.TextXAlignment.Left,
		ClearTextOnFocus = false,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ZIndex = 3,
		Position = UDim2.new(0, 24, 0, 0),
		Size = UDim2.new(1, -30, 1, 0),
		Name = "SearchBox"
	}, SearchBoxContainer)

	SearchBox.Focused:Connect(function()
		TweenService:Create(LensStroke, TI_FAST, {Color = Custom.ColorRGB}):Play()
		TweenService:Create(SearchHandle, TI_FAST, {BackgroundColor3 = Custom.ColorRGB}):Play()
	end)
	SearchBox.FocusLost:Connect(function()
		TweenService:Create(LensStroke, TI_FAST, {Color = Custom.TextMuted}):Play()
		TweenService:Create(SearchHandle, TI_FAST, {BackgroundColor3 = Custom.TextMuted}):Play()
	end)

	Custom:Create("Frame", {
		AnchorPoint = Vector2.new(0.5, 0),
		BackgroundColor3 = Custom.BorderColor,
		BackgroundTransparency = 0.5,
		BorderSizePixel = 0,
		Position = UDim2.new(0.5, 0, 0, 38),
		Size = UDim2.new(1, 0, 0, 1),
		ZIndex = 2,
		Name = "DecideFrame"
	}, Main)

	local Layers = Custom:Create("Frame", {
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Position = UDim2.new(0, TabWidth + 18, 0, 48),
		Size = UDim2.new(1, -(TabWidth + 9 + 18), 1, -56),
		ZIndex = 2,
		Name = "Layers"
	}, Main)

	local NameTab = Custom:Create("TextLabel", {
		Font = Enum.Font.GothamBold,
		Text = "",
		TextColor3 = Custom.TextBright,
		TextSize = 20,
		TextWrapped = true,
		TextXAlignment = Enum.TextXAlignment.Left,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ZIndex = 2,
		Size = UDim2.new(1, 0, 0, 26),
		Name = "NameTab"
	}, Layers)

	local LayersReal = Custom:Create("Frame", {
		AnchorPoint = Vector2.new(0, 1),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		Position = UDim2.new(0, 0, 1, 0),
		Size = UDim2.new(1, 0, 1, -30),
		ZIndex = 2,
		Name = "LayersReal"
	}, Layers)

	local LayersFolder = Custom:Create("Folder", {Name = "LayersFolder"}, LayersReal)
	local LayersPageLayout = Custom:Create("UIPageLayout", {
		SortOrder = Enum.SortOrder.LayoutOrder,
		Name = "LayersPageLayout",
		TweenTime = 0.35,
		EasingDirection = Enum.EasingDirection.InOut,
		EasingStyle = Enum.EasingStyle.Quad
	}, LayersFolder)

	local ScrollTab = Custom:Create("ScrollingFrame", {
		CanvasSize = UDim2.new(0, 0, 2.1, 0),
		ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0),
		ScrollBarThickness = 0,
		Active = true,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Position = UDim2.new(0, 0, 0, 32),
		Size = UDim2.new(1, 0, 1, -80),
		ZIndex = 2,
		Name = "ScrollTab"
	}, LayersTab)

	Custom:Create("UIListLayout", {
		Padding = UDim.new(0, 3),
		SortOrder = Enum.SortOrder.LayoutOrder
	}, ScrollTab)

	local AvatarFooter = Custom:Create("Frame", {
		AnchorPoint = Vector2.new(0, 1),
		BackgroundColor3 = Custom.BgCard,
		BackgroundTransparency = 0.3,
		BorderSizePixel = 0,
		Position = UDim2.new(0, 0, 1, 0),
		Size = UDim2.new(1, 0, 0, 38),
		ZIndex = 2,
		Name = "AvatarFooter"
	}, LayersTab)
	Custom:Create("UICorner", {CornerRadius = UDim.new(0, 4)}, AvatarFooter)
	Custom:Create("UIStroke", {Color = Custom.BorderColor, Thickness = 1}, AvatarFooter)

	local AvatarImage = Custom:Create("ImageLabel", {
		Image = "rbxasset://textures/ui/GuiImagePlaceholder.png",
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundColor3 = Custom.BgDark,
		BorderSizePixel = 0,
		Position = UDim2.new(0, 5, 0.5, 0),
		Size = UDim2.new(0, 26, 0, 26),
		ZIndex = 3,
		Name = "AvatarImage"
	}, AvatarFooter)
	Custom:Create("UICorner", {CornerRadius = UDim.new(1, 0)}, AvatarImage)
	Custom:Create("UIStroke", {Color = Custom.ColorRGB, Thickness = 1.2}, AvatarImage)

	local function CensorName(Name)
		if #Name <= 3 then return Name end
		return Name:sub(1, 3) .. "***"
	end

	Custom:Create("TextLabel", {
		Font = Enum.Font.GothamBold,
		Text = CensorName(Player and Player.Name or "Player"),
		TextColor3 = Custom.TextBright,
		TextSize = 11,
		TextWrapped = true,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Center,
		BackgroundTransparency = 1,
		ZIndex = 3,
		Position = UDim2.new(0, 38, 0, 0),
		Size = UDim2.new(1, -42, 1, 0),
		Name = "WelcomeLabel"
	}, AvatarFooter)

	task.spawn(function()
		if Player then
			local ok, url = pcall(function()
				return Players:GetUserThumbnailAsync(Player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100)
			end)
			if ok and url then AvatarImage.Image = url end
		end
	end)

	local SearchPopup = Custom:Create("Frame", {
		BackgroundColor3 = Custom.BgDark,
		BackgroundTransparency = 0.02,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		Position = UDim2.new(0, 0, 0, 32),
		Size = UDim2.new(1, 0, 0, 0),
		Visible = false,
		ZIndex = 20,
		Name = "SearchPopup"
	}, LayersTab)
	Custom:Create("UICorner", {CornerRadius = UDim.new(0, 4)}, SearchPopup)
	Custom:Create("UIStroke", {Color = Custom.BorderColor, Thickness = 1}, SearchPopup)
	Custom:Create("UIListLayout", {Padding = UDim.new(0, 0), SortOrder = Enum.SortOrder.LayoutOrder}, SearchPopup)

	local scrollUpdateQueued = false
	local function UpdateScrollSize()
		if scrollUpdateQueued then return end
		scrollUpdateQueued = true
		task.defer(function()
			scrollUpdateQueued = false
			local total = 0
			for _, v in pairs(ScrollTab:GetChildren()) do
				if v.Name ~= "UIListLayout" then total = total + 3 + v.Size.Y.Offset end
			end
			ScrollTab.CanvasSize = UDim2.new(0, 0, 0, total)
		end)
	end
	ScrollTab.ChildAdded:Connect(UpdateScrollSize)
	ScrollTab.ChildRemoved:Connect(UpdateScrollSize)

	function Custom:Highlight(Frame)
		local Ring = Custom:Create("UIStroke", {Color = Custom.ColorRGB, Thickness = 2, Transparency = 0, Parent = Frame})
		Custom:AddGradient(Ring)
		task.spawn(function()
			task.wait(0.8)
			local ft = TweenService:Create(Ring, TI_FAST, {Transparency = 1})
			ft:Play()
			ft.Completed:Wait()
			Ring:Destroy()
		end)
	end

	local function ScrollIntoView(SF, TF)
		task.wait(0.1)
		local ry = (TF.AbsolutePosition.Y - SF.AbsolutePosition.Y) + SF.CanvasPosition.Y
		TweenService:Create(SF, TI_QUAD_OUT, {
			CanvasPosition = Vector2.new(0, math.max(ry - 20, 0))
		}):Play()
	end

	local function RegisterSearch(Title, TargetFrame, Subtitle, SelectTabFn, EnsureOpenFn, ScrollFrameRef)
		if Title == "" then return end
		table.insert(SearchRegistry, {
			Title = Title,
			_lowerTitle = string.lower(Title),
			Subtitle = Subtitle or "",
			TargetFrame = TargetFrame,
			SelectTab = SelectTabFn,
			EnsureOpen = EnsureOpenFn,
			ScrollFrame = ScrollFrameRef
		})
	end

	local function ClearSearchPopup()
		for _, v in pairs(SearchPopup:GetChildren()) do
			if v.Name == "ResultRow" then v:Destroy() end
		end
	end

	local function HideSearchPopup()
		SearchPopup.Visible = false
		SearchPopup.Size = UDim2.new(1, 0, 0, 0)
		ScrollTab.Visible = true
		ClearSearchPopup()
	end

	local function RunSearch(Query)
		Query = string.lower(Query)
		HideSearchPopup()
		if Query == "" then return end
		local Matches = {}
		for _, e in ipairs(SearchRegistry) do
			if string.find(e._lowerTitle, Query, 1, true) then
				table.insert(Matches, e)
				if #Matches >= 8 then break end
			end
		end
		if #Matches == 0 then return end
		ScrollTab.Visible = false
		for i, Entry in ipairs(Matches) do
			local Row = Custom:Create("TextButton", {
				Font = Enum.Font.SourceSans, Text = "", AutoButtonColor = false,
				BackgroundTransparency = 1, BorderSizePixel = 0,
				LayoutOrder = i, Size = UDim2.new(1, 0, 0, 38), Name = "ResultRow"
			}, SearchPopup)
			if i < #Matches then
				Custom:Create("Frame", {
					AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Custom.BorderColor,
					BorderSizePixel = 0, Position = UDim2.new(0, 8, 1, 0), Size = UDim2.new(1, -16, 0, 1), Name = "Divider"
				}, Row)
			end
			local Accent = Custom:Create("Frame", {
				BackgroundColor3 = Custom.ColorRGB, BorderSizePixel = 0,
				Position = UDim2.new(0, 2, 0, 13), Size = UDim2.new(0, 2, 0, 12), Name = "ResultAccent"
			}, Row)
			Custom:AddGradient(Accent, 90)
			Custom:Create("TextLabel", {
				Font = Enum.Font.GothamBold, Text = Entry.Title, TextColor3 = Custom.TextBright,
				TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left, BackgroundTransparency = 1,
				Position = UDim2.new(0, 10, 0, 5), Size = UDim2.new(1, -14, 0, 15), Name = "ResultTitle"
			}, Row)
			Custom:Create("TextLabel", {
				Font = Enum.Font.Gotham, Text = Entry.Subtitle, TextColor3 = Custom.TextMuted,
				TextSize = 10, TextXAlignment = Enum.TextXAlignment.Left, BackgroundTransparency = 1,
				Position = UDim2.new(0, 10, 0, 20), Size = UDim2.new(1, -14, 0, 12), Name = "ResultSubtitle"
			}, Row)
			local HL = Custom:Create("Frame", {
				BackgroundColor3 = Custom.ColorRGB, BackgroundTransparency = 1,
				BorderSizePixel = 0, Size = UDim2.new(1, 0, 1, 0), ZIndex = Row.ZIndex - 1, Name = "RowHighlight"
			}, Row)
			Row.MouseEnter:Connect(function() TweenService:Create(HL, TI_FAST, {BackgroundTransparency = 0.9}):Play() end)
			Row.MouseLeave:Connect(function() TweenService:Create(HL, TI_FAST, {BackgroundTransparency = 1}):Play() end)
			Row.Activated:Connect(function()
				SearchBox.Text = ""; HideSearchPopup()
				if Entry.SelectTab then Entry.SelectTab() end
				task.spawn(function()
					task.wait(0.1)
					if Entry.EnsureOpen then Entry.EnsureOpen() end
					if Entry.ScrollFrame and Entry.TargetFrame then ScrollIntoView(Entry.ScrollFrame, Entry.TargetFrame) end
					task.wait(0.2)
					if Entry.TargetFrame then Custom:Highlight(Entry.TargetFrame) end
				end)
			end)
		end
		SearchPopup.Size = UDim2.new(1, 0, 0, math.min(#Matches * 38, 220))
		SearchPopup.Visible = true
	end

	SearchBox:GetPropertyChangedSignal("Text"):Connect(function() RunSearch(SearchBox.Text) end)

	Min.Activated:Connect(function()
		CircleClick(Min, Player:GetMouse().X, Player:GetMouse().Y)
		DropShadowHolder.Visible = false
		if not Open_Close.Visible then Open_Close.Visible = true end
	end)

	Open_Close.Activated:Connect(function()
		DropShadowHolder.Visible = true
		if Open_Close.Visible then Open_Close.Visible = false end
	end)

	local ExitBackdrop = Custom:Create("Frame", {
		BackgroundColor3 = Color3.fromRGB(0, 0, 0),
		BackgroundTransparency = 0.5,
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 1, 0),
		Visible = false,
		ZIndex = 49,
		Name = "ExitBackdrop"
	}, Main)

	local ExitConfirm = Custom:Create("Frame", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = Custom.BgDark,
		BorderSizePixel = 0,
		Position = UDim2.new(0.5, 0, 0.5, 0),
		Size = UDim2.new(0, 260, 0, 118),
		Visible = false,
		ZIndex = 50,
		Name = "ExitConfirm"
	}, Main)
	Custom:Create("UICorner", {CornerRadius = UDim.new(0, 8)}, ExitConfirm)
	Custom:Create("UIStroke", {Color = Custom.BorderColor, Thickness = 1.5}, ExitConfirm)

	local ExitHeader = Custom:Create("Frame", {
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 0, 34),
		ZIndex = 51,
		Name = "ExitHeader"
	}, ExitConfirm)

	Custom:Create("TextLabel", {
		Font = Enum.Font.GothamBold,
		Text = "Close w424",
		TextColor3 = Custom.TextBright,
		TextSize = 14,
		TextXAlignment = Enum.TextXAlignment.Center,
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 1, 0),
		ZIndex = 51,
		Name = "ExitTitle"
	}, ExitHeader)

	local ExitCloseX = Custom:Create("TextButton", {
		Font = Enum.Font.GothamBold,
		Text = "×",
		TextColor3 = Custom.TextMuted,
		TextSize = 18,
		AnchorPoint = Vector2.new(1, 0.5),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Position = UDim2.new(1, -10, 0.5, 0),
		Size = UDim2.new(0, 24, 0, 24),
		ZIndex = 52,
		Name = "ExitCloseX"
	}, ExitHeader)

	Custom:Create("TextLabel", {
		Font = Enum.Font.GothamBold,
		Text = "Want to close this script?",
		TextColor3 = Custom.TextMuted,
		TextSize = 12,
		TextWrapped = true,
		TextXAlignment = Enum.TextXAlignment.Center,
		TextYAlignment = Enum.TextYAlignment.Center,
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 12, 0, 38),
		Size = UDim2.new(1, -24, 0, 30),
		ZIndex = 51,
		Name = "ExitDesc"
	}, ExitConfirm)

	local CancelButton = Custom:Create("TextButton", {
		Font = Enum.Font.GothamBold,
		Text = "Cancel",
		TextColor3 = Custom.TextBright,
		TextSize = 13,
		BackgroundColor3 = Custom.BgCard,
		BorderSizePixel = 0,
		ZIndex = 51,
		Position = UDim2.new(0, 12, 1, -42),
		Size = UDim2.new(0.5, -18, 0, 30),
		Name = "CancelButton"
	}, ExitConfirm)
	Custom:Create("UICorner", {CornerRadius = UDim.new(0, 6)}, CancelButton)
	Custom:Create("UIStroke", {Color = Custom.BorderColor, Thickness = 1}, CancelButton)

	local ExitButton = Custom:Create("TextButton", {
		Font = Enum.Font.GothamBold,
		Text = "Close",
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextSize = 13,
		BackgroundColor3 = Custom.ColorRGB,
		BorderSizePixel = 0,
		ZIndex = 51,
		Position = UDim2.new(0.5, 6, 1, -42),
		Size = UDim2.new(0.5, -18, 0, 30),
		Name = "ExitButton"
	}, ExitConfirm)
	Custom:Create("UICorner", {CornerRadius = UDim.new(0, 6)}, ExitButton)

	local function ShowExitConfirm()
		ExitBackdrop.Visible = true
		ExitConfirm.Visible = true
		ExitBackdrop.BackgroundTransparency = 1
		ExitConfirm.Size = UDim2.new(0, 0, 0, 0)
		TweenService:Create(ExitBackdrop, TI_MED, {BackgroundTransparency = 0.5}):Play()
		TweenService:Create(ExitConfirm, TI_BACK_OUT, {Size = UDim2.new(0, 260, 0, 118)}):Play()
	end

	local function HideExitConfirm()
		TweenService:Create(ExitBackdrop, TI_FAST, {BackgroundTransparency = 1}):Play()
		local Shrink = TweenService:Create(ExitConfirm, TI_FAST, {Size = UDim2.new(0, 0, 0, 0)})
		Shrink:Play()
		Shrink.Completed:Wait()
		ExitConfirm.Visible = false
		ExitBackdrop.Visible = false
	end

	CancelButton.Activated:Connect(function()
		CircleClick(CancelButton, Player:GetMouse().X, Player:GetMouse().Y)
		task.spawn(HideExitConfirm)
	end)

	ExitCloseX.Activated:Connect(function()
		CircleClick(ExitCloseX, Player:GetMouse().X, Player:GetMouse().Y)
		task.spawn(HideExitConfirm)
	end)

	ExitButton.Activated:Connect(function()
		CircleClick(ExitButton, Player:GetMouse().X, Player:GetMouse().Y)
		task.spawn(function()
			HideExitConfirm()
			for _, conn in ipairs(ActiveConnections) do
				pcall(function() conn:Disconnect() end)
			end
			if MugiHubGui then MugiHubGui:Destroy() end
			if Open_Close and Open_Close.Parent then Open_Close.Parent:Destroy() end
			if NotifGui and NotifGui.Parent then NotifGui:Destroy() end
			w424_Library.Unloaded = true
		end)
	end)

	Close.Activated:Connect(function()
		CircleClick(Close, Player:GetMouse().X, Player:GetMouse().Y)
		ShowExitConfirm()
	end)

	DropShadowHolder.Size = UDim2.new(0, 115 + TextLabel.TextBounds.X + 1 + TextLabel1.TextBounds.X, 0, 310)
	MakeDraggable(Top, DropShadowHolder)

	local keyConn = UserInputService.InputBegan:Connect(function(input, gameProcessed)
		if gameProcessed then return end
		if input.KeyCode == Keybind then
			DropShadowHolder.Visible = not DropShadowHolder.Visible
			Open_Close.Visible = not DropShadowHolder.Visible
		end
	end)
	table.insert(ActiveConnections, keyConn)

	local MoreBlur = Custom:Create("Frame", {
		AnchorPoint = Vector2.new(1, 1), BackgroundColor3 = Color3.fromRGB(0, 0, 0),
		BackgroundTransparency = 1, BorderSizePixel = 0, ClipsDescendants = true,
		Position = UDim2.new(1, 8, 1, 8), Size = UDim2.new(1, 154, 1, 54),
		Visible = false, Name = "MoreBlur"
	}, Layers)

	Custom:Create("UICorner", {}, MoreBlur)

	local ConnectButton = Custom:Create("TextButton", {
		Font = Enum.Font.SourceSans, Text = "", BackgroundTransparency = 1,
		BorderSizePixel = 0, Size = UDim2.new(1, 0, 1, 0), Name = "ConnectButton"
	}, MoreBlur)

	local DropdownSelect = Custom:Create("Frame", {
		AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Custom.BgDark,
		BorderSizePixel = 0, LayoutOrder = 1, Position = UDim2.new(1, 172, 0.5, 0),
		Size = UDim2.new(0, 160, 1, -16), Name = "DropdownSelect", ClipsDescendants = true
	}, MoreBlur)
	Custom:Create("UICorner", {CornerRadius = UDim.new(0, 6)}, DropdownSelect)
	Custom:Create("UIStroke", {Color = Custom.BorderColor, Thickness = 1.5}, DropdownSelect)

	ConnectButton.Activated:Connect(function()
		if MoreBlur.Visible then
			TweenService:Create(MoreBlur, TI_MED, {BackgroundTransparency = 1}):Play()
			TweenService:Create(DropdownSelect, TI_MED, {Position = UDim2.new(1, 172, 0.5, 0)}):Play()
			task.wait(0.2); MoreBlur.Visible = false
		end
	end)

	local DropdownSelectReal = Custom:Create("Frame", {
		AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1,
		BorderSizePixel = 0, Position = UDim2.new(0.5, 0, 0.5, 0),
		Size = UDim2.new(1, -10, 1, -10), Name = "DropdownSelectReal", Parent = DropdownSelect
	})
	local DropdownFolder = Custom:Create("Folder", {Name = "DropdownFolder", Parent = DropdownSelectReal})
	local DropPageLayout = Custom:Create("UIPageLayout", {
		EasingDirection = Enum.EasingDirection.InOut, EasingStyle = Enum.EasingStyle.Quad,
		TweenTime = 0.01, SortOrder = Enum.SortOrder.LayoutOrder,
		Archivable = false, Name = "DropPageLayout", Parent = DropdownFolder
	})

	local Tabs = {}
	local CountTab = 0
	local CountDropdown = 0

	function Tabs:CreateTab(Config, Config2)
		if type(Config) == "string" and type(Config2) == "string" then
			Config = {Name = Config, Icon = Config2}
		elseif type(Config) == "string" and type(Config2) == "table" then
			Config = Config2
		elseif type(Config) == "string" then
			Config = {Name = Config}
		end

		local _Name = Config[1] or Config.Name or Config.Title or ""
		local Icon = Custom:ResolveIcon(Config[2] or Config.Icon)

		local ScrolLayers = Custom:Create("ScrollingFrame", {
			ScrollBarImageColor3 = Custom.ColorRGB,
			ScrollBarThickness = 2, Active = true,
			LayoutOrder = CountTab, BackgroundTransparency = 1,
			BorderSizePixel = 0, Size = UDim2.new(1, 0, 1, 0),
			Name = "ScrolLayers", Parent = LayersFolder
		})
		Custom:Create("UIListLayout", {Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder, Parent = ScrolLayers})

		local Tab = Custom:Create("Frame", {
			BackgroundColor3 = Custom.BgCard,
			BackgroundTransparency = CountTab == 0 and 0.2 or 0.9,
			BorderSizePixel = 0, LayoutOrder = CountTab,
			Size = UDim2.new(1, 0, 0, 30), Name = "Tab", Parent = ScrollTab
		})
		Custom:Create("UICorner", {CornerRadius = UDim.new(0, 4), Parent = Tab})

		local TabButton = Custom:Create("TextButton", {
			Font = Enum.Font.GothamBold, Text = "", TextColor3 = Custom.TextBright,
			TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left,
			BackgroundTransparency = 1, BorderSizePixel = 0, ZIndex = 1,
			Size = UDim2.new(1, 0, 1, 0), Name = "TabButton"
		}, Tab)

		Custom:Create("TextLabel", {
			Font = Enum.Font.GothamBold, Text = _Name, TextColor3 = Custom.TextBright,
			TextSize = 12, TextXAlignment = Enum.TextXAlignment.Left,
			BackgroundTransparency = 1, BorderSizePixel = 0, ZIndex = 2,
			Size = UDim2.new(1, 0, 1, 0), Position = UDim2.new(0, 30, 0, 0), Name = "TabName"
		}, Tab)

		local TabIconImg = Custom:Create("ImageLabel", {
			Image = Icon,
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			AnchorPoint = Vector2.new(0, 0.5),
			Position = UDim2.new(0, 8, 0.5, 0),
			Size = UDim2.new(0, 15, 0, 15),
			ZIndex = 2,
			ScaleType = Enum.ScaleType.Fit,
			Name = "FeatureImg"
		}, Tab)

		task.defer(function()
			if TabIconImg.Image == "" or TabIconImg.Image == "rbxasset://textures/ui/GuiImagePlaceholder.png" then
				TabIconImg.Image = Custom.DefaultIcon
			end
		end)

		local function SelectTab()
			local FrameChoose = nil
			for _, s in pairs(ScrollTab:GetChildren()) do
				for _, v in pairs(s:GetChildren()) do
					if v.Name == "ChooseFrame" then FrameChoose = v; break end
				end
				if FrameChoose then break end
			end
			if FrameChoose and Tab.LayoutOrder ~= LayersPageLayout.CurrentPage.LayoutOrder then
				for _, tf in pairs(ScrollTab:GetChildren()) do
					if tf.Name == "Tab" then
						TweenService:Create(tf, TI_FAST, {BackgroundTransparency = 0.9}):Play()
					end
				end
				TweenService:Create(Tab, TI_FAST, {BackgroundTransparency = 0.2}):Play()
				local TargetY = (Tab.AbsolutePosition.Y - FrameChoose.Parent.AbsolutePosition.Y) + 9
				TweenService:Create(FrameChoose, TI_QUAD_OUT, {Position = UDim2.new(0, 2, 0, TargetY)}):Play()
				LayersPageLayout:JumpToIndex(Tab.LayoutOrder)
				NameTab.Text = _Name
				TweenService:Create(FrameChoose, TI_FAST, {Size = UDim2.new(0, 2, 0, 18)}):Play()
				task.wait(0.15)
				TweenService:Create(FrameChoose, TI_FAST, {Size = UDim2.new(0, 2, 0, 12)}):Play()
			end
		end

		if CountTab == 0 then
			LayersPageLayout:JumpToIndex(0); NameTab.Text = _Name
			local CF = Custom:Create("Frame", {
				BackgroundColor3 = Custom.ColorRGB, BorderSizePixel = 0,
				Position = UDim2.new(0, 2, 0, 9), Size = UDim2.new(0, 2, 0, 12), Name = "ChooseFrame"
			}, Tab)
			Custom:AddGradient(CF, 90)
			Custom:Create("UICorner", {}, CF)
		end

		TabButton.Activated:Connect(function()
			CircleClick(TabButton, Player:GetMouse().X, Player:GetMouse().Y); SelectTab()
		end)

		local Sections, CountSection = {}, 0

		function Sections:AddSection(Title, OpenSection)
			Title = Title or ""
			if OpenSection == nil then OpenSection = true end
			local SectionTitleText = Title
			local SearchSubtitle = _Name .. " · " .. SectionTitleText

			local Section = Custom:Create("Frame", {
				BackgroundTransparency = 1, BorderSizePixel = 0,
				ClipsDescendants = true, LayoutOrder = CountSection,
				Size = UDim2.new(1, 0, 0, 30), Name = "Section"
			}, ScrolLayers)

			local SectionReal = Custom:Create("Frame", {
				AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Custom.BgCard,
				BackgroundTransparency = 0.25, BorderSizePixel = 0,
				LayoutOrder = 1, Position = UDim2.new(0.5, 0, 0, 0),
				Size = UDim2.new(1, 0, 0, 30), Name = "SectionReal"
			}, Section)
			Custom:Create("UICorner", {CornerRadius = UDim.new(0, 4)}, SectionReal)
			Custom:Create("UIStroke", {Color = Custom.BorderColor, Thickness = 1}, SectionReal)

			local SectionButton = Custom:Create("TextButton", {
				Font = Enum.Font.SourceSans, Text = "", BackgroundTransparency = 1,
				BorderSizePixel = 0, Size = UDim2.new(1, 0, 1, 0), Name = "SectionButton"
			}, SectionReal)

			local FeatureFrame = Custom:Create("Frame", {
				AnchorPoint = Vector2.new(1, 0.5), BackgroundTransparency = 1,
				BorderSizePixel = 0, Position = UDim2.new(1, -5, 0.5, 0),
				Size = UDim2.new(0, 20, 0, 20), Name = "FeatureFrame"
			}, SectionReal)

			local FeatureImg = Custom:Create("ImageLabel", {
				Image = "rbxassetid://125609963478878",
				ImageColor3 = Custom.ColorRGB,
				AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1,
				BorderSizePixel = 0, Position = UDim2.new(0.5, 0, 0.5, 0),
				Rotation = OpenSection and 90 or -90, Size = UDim2.new(1, 4, 1, 4), Name = "FeatureImg"
			}, FeatureFrame)

			Custom:Create("TextLabel", {
				Font = Enum.Font.GothamBold, Text = Title,
				TextColor3 = Custom.TextBright, TextSize = 13,
				TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Center,
				AnchorPoint = Vector2.new(0, 0.5), BackgroundTransparency = 1,
				BorderSizePixel = 0, Position = UDim2.new(0, 10, 0.5, 0),
				Size = UDim2.new(1, -50, 0, 16), Name = "SectionTitle"
			}, SectionReal)

			local SectionDecideFrame = Custom:Create("Frame", {
				BackgroundColor3 = Custom.ColorRGB, BorderSizePixel = 0,
				AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 32),
				Size = UDim2.new(0, 0, 0, 1), Name = "SectionDecideFrame"
			}, Section)
			Custom:Create("UICorner", {}, SectionDecideFrame)
			Custom:Create("UIGradient", {
				Color = ColorSequence.new{
					ColorSequenceKeypoint.new(0, Custom.BgDark),
					ColorSequenceKeypoint.new(0.5, Custom.ColorRGB),
					ColorSequenceKeypoint.new(1, Custom.BgDark)
				}
			}, SectionDecideFrame)

			local SectionAdd = Custom:Create("Frame", {
				AnchorPoint = Vector2.new(0.5, 0), BackgroundTransparency = 1,
				BorderSizePixel = 0, ClipsDescendants = true,
				LayoutOrder = 1, Position = UDim2.new(0.5, 0, 0, 36),
				Size = UDim2.new(1, 0, 0, 100), Name = "SectionAdd"
			}, Section)
			Custom:Create("UICorner", {CornerRadius = UDim.new(0, 2)}, SectionAdd)
			Custom:Create("UIListLayout", {Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder}, SectionAdd)

			local sizeUpdateQueued = false
			local function UpdateSizeScroll()
				local oy = 0
				for _, c in pairs(ScrolLayers:GetChildren()) do
					if c.Name ~= "UIListLayout" then oy = oy + 4 + c.Size.Y.Offset end
				end
				ScrolLayers.CanvasSize = UDim2.new(0, 0, 0, oy)
			end

			local function UpdateSizeSection()
				if sizeUpdateQueued then return end
				sizeUpdateQueued = true
				task.defer(function()
					sizeUpdateQueued = false
					if OpenSection then
						local h = 38
						for _, v in pairs(SectionAdd:GetChildren()) do
							if v.Name ~= "UIListLayout" and v.Name ~= "UICorner" then h = h + v.Size.Y.Offset + 4 end
						end
						TweenService:Create(FeatureFrame, TI_FAST, {Rotation = 90}):Play()
						TweenService:Create(Section, TI_FAST, {Size = UDim2.new(1, 0, 0, h)}):Play()
						TweenService:Create(SectionAdd, TI_FAST, {Size = UDim2.new(1, 0, 0, h - 38)}):Play()
						TweenService:Create(SectionDecideFrame, TI_FAST, {Size = UDim2.new(1, 0, 0, 1)}):Play()
						task.wait(0.15)
						UpdateSizeScroll()
					end
				end)
			end

			local function ToggleSection()
				CircleClick(SectionButton, Player:GetMouse().X, Player:GetMouse().Y)
				if OpenSection then
					TweenService:Create(FeatureFrame, TI_FAST, {Rotation = 0}):Play()
					TweenService:Create(Section, TI_FAST, {Size = UDim2.new(1, 0, 0, 30)}):Play()
					TweenService:Create(SectionDecideFrame, TI_FAST, {Size = UDim2.new(0, 0, 0, 1)}):Play()
					OpenSection = false; task.wait(0.1); UpdateSizeScroll()
				else
					OpenSection = true; UpdateSizeSection()
				end
			end

			SectionButton.Activated:Connect(ToggleSection)
			SectionAdd.ChildAdded:Connect(UpdateSizeSection)
			SectionAdd.ChildRemoved:Connect(UpdateSizeSection)
			UpdateSizeScroll()

			local function EnsureSectionOpen()
				if not OpenSection then OpenSection = true; UpdateSizeSection() end
			end

			local Item, ItemCount = {}, 0

			function Item:AddParagraph(Config, Config2)
				if type(Config) == "string" and type(Config2) == "table" then Config = Config2 end
				local Title = Config[1] or Config.Title or ""
				local Content = Config[2] or Config.Content or Config.Description or ""
				local SF = {}
				local P = Custom:Create("Frame", {
					BackgroundColor3 = Custom.BgCard, BackgroundTransparency = 0.35,
					BorderSizePixel = 0, LayoutOrder = ItemCount, Size = UDim2.new(1, 0, 0, 35), Name = "Paragraph"
				}, SectionAdd)
				Custom:Create("UICorner", {CornerRadius = UDim.new(0, 4)}, P)
				Custom:Create("UIStroke", {Color = Custom.BorderColor, Thickness = 0.8}, P)

				local PT = Custom:Create("TextLabel", {
					Font = Enum.Font.GothamBold, Text = Title, TextColor3 = Custom.TextBright,
					TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top,
					BackgroundTransparency = 1, BorderSizePixel = 0,
					Position = UDim2.new(0, 10, 0, 10), Size = UDim2.new(1, -16, 0, 13), Name = "ParagraphTitle"
				}, P)
				local PC = Custom:Create("TextLabel", {
					Font = Enum.Font.Gotham, Text = Content, TextColor3 = Custom.TextMuted,
					TextSize = 12, TextXAlignment = Enum.TextXAlignment.Left,
					TextYAlignment = Enum.TextYAlignment.Bottom, BackgroundTransparency = 1,
					BorderSizePixel = 0, Position = UDim2.new(0, 10, 0, 23), Name = "ParagraphContent"
				}, P)

				local function UpdateP()
					PC.TextWrapped = false
					local lc = math.ceil(PC.TextBounds.X / PC.AbsoluteSize.X)
					PC.Size = UDim2.new(1, -16, 0, 12 + (12 * lc))
					P.Size = UDim2.new(1, 0, 0, PC.AbsoluteSize.Y + 33)
					PC.TextWrapped = true; UpdateSizeSection()
				end
				UpdateP()
				PC:GetPropertyChangedSignal("AbsoluteSize"):Connect(UpdateP)
				RegisterSearch(Title, P, SearchSubtitle, SelectTab, EnsureSectionOpen, ScrolLayers)
				function SF:Set(cfg)
					if type(cfg) == "table" then
						if cfg.Title or cfg[1] then PT.Text = cfg.Title or cfg[1] or "" end
						if cfg.Content or cfg.Description or cfg[2] then PC.Text = cfg.Content or cfg.Description or cfg[2] or "" end
					elseif type(cfg) == "string" then
						PC.Text = cfg
					end
					UpdateP()
				end
				function SF:SetTitle(t) PT.Text = tostring(t or ""); UpdateP() end
				function SF:SetDesc(d) PC.Text = tostring(d or ""); UpdateP() end
				function SF:SetContent(c) PC.Text = tostring(c or ""); UpdateP() end
				function SF:Update(c) PC.Text = tostring(c or ""); UpdateP() end

				ItemCount += 1; return SF
			end

			function Item:AddSeperator(Config, Config2)
				if type(Config) == "string" and type(Config2) == "table" then Config = Config2 end
				local Title = (type(Config) == "string" and Config) or Config[1] or Config.Title or ""
				local SF = {}
				local S = Custom:Create("Frame", {
					BackgroundColor3 = Custom.BgCard, BackgroundTransparency = 0.2,
					BorderSizePixel = 0, LayoutOrder = ItemCount, Size = UDim2.new(1, 0, 0, 28), Name = "Seperator"
				}, SectionAdd)
				Custom:Create("UICorner", {CornerRadius = UDim.new(0, 4)}, S)
				Custom:Create("UIStroke", {Color = Custom.BorderColor, Thickness = 1}, S)

				local SL = Custom:Create("TextLabel", {
					Font = Enum.Font.GothamBold, Text = Title,
					TextColor3 = Custom.ColorRGB,
					TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Center,
					BackgroundTransparency = 1, BorderSizePixel = 0,
					Position = UDim2.new(0, 10, 0, 0), Size = UDim2.new(1, -16, 1, 0), Name = "SeperatorTitle"
				}, S)
				function SF:Set(cfg)
					SL.Text = (type(cfg) == "string" and cfg) or cfg[1] or cfg.Title or ""
				end
				ItemCount += 1; return SF
			end

			function Item:AddLine()
				local L = Custom:Create("Frame", {
					BackgroundColor3 = Custom.BorderColor, BackgroundTransparency = 0.3,
					BorderSizePixel = 0, LayoutOrder = ItemCount, Size = UDim2.new(1, 0, 0, 2), Name = "Line"
				}, SectionAdd)
				Custom:Create("UICorner", {CornerRadius = UDim.new(1, 0)}, L)
				ItemCount += 1; return {}
			end

			function Item:AddButton(Config, Config2)
				if type(Config) == "string" and type(Config2) == "table" then Config = Config2 end
				local Title = Config[1] or Config.Title or ""
				local Content = Config[2] or Config.Content or Config.Description or ""
				local Icon = Custom:ResolveIcon(Config[3] or Config.Icon)
				if Icon == Custom.DefaultIcon and not (Config[3] or Config.Icon) then
					Icon = "rbxassetid://7734010488"
				end
				local Callback = Config[4] or Config.Callback or function() end
				local SF = {}

				local B = Custom:Create("Frame", {
					BackgroundColor3 = Custom.BgCard, BackgroundTransparency = 0.35,
					BorderSizePixel = 0, LayoutOrder = ItemCount, Size = UDim2.new(1, 0, 0, 35), Name = "Button"
				}, SectionAdd)
				Custom:Create("UICorner", {CornerRadius = UDim.new(0, 4)}, B)
				Custom:Create("UIStroke", {Color = Custom.BorderColor, Thickness = 0.8}, B)

				Custom:Create("TextLabel", {
					Font = Enum.Font.GothamBold, Text = Title, TextColor3 = Custom.TextBright,
					TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top,
					BackgroundTransparency = 1, BorderSizePixel = 0,
					Position = UDim2.new(0, 10, 0, 10), Size = UDim2.new(1, -100, 0, 13), Name = "ButtonTitle"
				}, B)
				local BC = Custom:Create("TextLabel", {
					Font = Enum.Font.Gotham, Text = Content, TextColor3 = Custom.TextMuted,
					TextSize = 12, TextXAlignment = Enum.TextXAlignment.Left,
					TextYAlignment = Enum.TextYAlignment.Bottom, BackgroundTransparency = 1,
					BorderSizePixel = 0, Position = UDim2.new(0, 10, 0, 23), Size = UDim2.new(1, -100, 0, 12), Name = "ButtonContent"
				}, B)

				local function UpdateB()
					local h = 12 + (12 * (BC.TextBounds.X // BC.AbsoluteSize.X))
					BC.Size = UDim2.new(1, -100, 0, h); B.Size = UDim2.new(1, 0, 0, BC.AbsoluteSize.Y + 33)
				end
				BC.TextWrapped = true; UpdateB()
				BC:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
					BC.TextWrapped = false; UpdateB(); BC.TextWrapped = true; UpdateSizeSection()
				end)

				local BB = Custom:Create("TextButton", {
					Font = Enum.Font.SourceSans, Text = "", BackgroundTransparency = 1,
					BorderSizePixel = 0, Size = UDim2.new(1, 0, 1, 0), Name = "ButtonButton"
				}, B)

				local FF = Custom:Create("Frame", {
					AnchorPoint = Vector2.new(1, 0.5), BackgroundTransparency = 1,
					BorderSizePixel = 0, Position = UDim2.new(1, -15, 0.5, 0),
					Size = UDim2.new(0, 20, 0, 20), Name = "FeatureFrame"
				}, B)

				Custom:Create("ImageLabel", {
					Image = Icon, ImageColor3 = Custom.ColorRGB, AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1,
					BorderSizePixel = 0, Position = UDim2.new(0.5, 0, 0.5, 0),
					Size = UDim2.new(1, 0, 1, 0), Name = "FeatureImg"
				}, FF)

				BB.Activated:Connect(function()
					CircleClick(BB, Player:GetMouse().X, Player:GetMouse().Y); Callback()
				end)

				RegisterSearch(Title, B, SearchSubtitle, SelectTab, EnsureSectionOpen, ScrolLayers)
				ItemCount += 1; return SF
			end

			function Item:AddToggle(Config, Config2)
				if type(Config) == "string" and type(Config2) == "table" then Config = Config2 end
				local Title = Config[1] or Config.Title or ""
				local Content = Config[2] or Config.Content or Config.Description or ""
				local Default = Config[3] or Config.Default or false
				local Callback = Config[4] or Config.Callback or function() end
				local FT = {Value = Default}

				local T = Custom:Create("Frame", {
					BackgroundColor3 = Custom.BgCard, BackgroundTransparency = 0.35,
					BorderSizePixel = 0, LayoutOrder = ItemCount, Size = UDim2.new(1, 0, 0, 35), Name = "Toggle"
				}, SectionAdd)
				Custom:Create("UICorner", {CornerRadius = UDim.new(0, 4)}, T)
				Custom:Create("UIStroke", {Color = Custom.BorderColor, Thickness = 0.8}, T)

				local TT = Custom:Create("TextLabel", {
					Font = Enum.Font.GothamBold, Text = Title, TextSize = 13,
					TextColor3 = Custom.TextBright, TextXAlignment = Enum.TextXAlignment.Left,
					TextYAlignment = Enum.TextYAlignment.Top, BackgroundTransparency = 1,
					BorderSizePixel = 0, Position = UDim2.new(0, 10, 0, 10),
					Size = UDim2.new(1, -100, 0, 13), Name = "ToggleTitle"
				}, T)

				local TC = Custom:Create("TextLabel", {
					Font = Enum.Font.Gotham, Text = Content, TextSize = 12,
					TextColor3 = Custom.TextMuted,
					TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Bottom,
					BackgroundTransparency = 1, BorderSizePixel = 0,
					Position = UDim2.new(0, 10, 0, 23), Size = UDim2.new(1, -100, 0, 12), Name = "ToggleContent"
				}, T)

				local function UpdateT()
					TC.TextWrapped = false
					local r = TC.TextBounds.X / TC.AbsoluteSize.X
					TC.Size = UDim2.new(1, -100, 0, 12 + (12 * math.ceil(r)))
					T.Size = UDim2.new(1, 0, 0, TC.AbsoluteSize.Y + 33); TC.TextWrapped = true
				end
				UpdateT()
				TC:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() UpdateT(); UpdateSizeSection() end)

				local TB = Custom:Create("TextButton", {
					Font = Enum.Font.SourceSans, Text = "", BackgroundTransparency = 1,
					BorderSizePixel = 0, Size = UDim2.new(1, 0, 1, 0), Name = "ToggleButton"
				}, T)

				local FF2 = Custom:Create("Frame", {
					AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Custom.BgDark,
					BackgroundTransparency = 0.2, BorderSizePixel = 0,
					Position = UDim2.new(1, -15, 0.5, 0), Size = UDim2.new(0, 30, 0, 16), Name = "FeatureFrame2"
				}, T)
				Custom:Create("UICorner", {CornerRadius = UDim.new(0, 8)}, FF2)
				local TS8 = Custom:Create("UIStroke", {Color = Custom.BorderColor, Thickness = 1.2}, FF2)

				local TC2 = Custom:Create("Frame", {
					BackgroundColor3 = Custom.TextBright, BorderSizePixel = 0,
					Size = UDim2.new(0, 12, 0, 12), Position = UDim2.new(0, 2, 0.5, -6), Name = "ToggleCircle"
				}, FF2)
				Custom:Create("UICorner", {CornerRadius = UDim.new(1, 0)}, TC2)

				local function ToggleAnim(on)
					TweenService:Create(TT, TI_FAST, {TextColor3 = on and Custom.ColorRGB or Custom.TextBright}):Play()
					TweenService:Create(TC2, TI_FAST, {
						Position = on and UDim2.new(1, -14, 0.5, -6) or UDim2.new(0, 2, 0.5, -6),
						BackgroundColor3 = on and Color3.fromRGB(255, 255, 255) or Custom.TextMuted
					}):Play()
					TweenService:Create(TS8, TI_FAST, {Color = on and Custom.ColorRGB or Custom.BorderColor}):Play()
					TweenService:Create(FF2, TI_FAST, {
						BackgroundColor3 = on and Custom.ColorRGB or Custom.BgDark,
						BackgroundTransparency = on and 0.1 or 0.2
					}):Play()
				end

				TB.Activated:Connect(function()
					CircleClick(TB, Player:GetMouse().X, Player:GetMouse().Y)
					FT.Value = not FT.Value; FT:Set(FT.Value)
				end)

				function FT:Set(Value)
					FT.Value = Value
					ToggleAnim(Value)
					pcall(function() Callback(Value) end)
				end

				function FT:SetValue(Value)
					FT:Set(Value)
				end

				function FT:OnChanged(cb)
					Callback = cb
				end

				ToggleAnim(Default)
				RegisterSearch(Title, T, SearchSubtitle, SelectTab, EnsureSectionOpen, ScrolLayers)
				ItemCount += 1; return FT
			end

			function Item:AddSlider(Config, Config2)
				if type(Config) == "string" and type(Config2) == "table" then Config = Config2 end
				local Title = Config[1] or Config.Title or ""
				local Content = Config[2] or Config.Content or Config.Description or ""
				local Increment = Config[3] or Config.Increment or Config.Rounding or 1
				local Min = Config[4] or Config.Min or 0
				local Max = Config[5] or Config.Max or 100
				local Default = Config[6] or Config.Default or 50
				local Callback = Config[7] or Config.Callback or function() end
				local FS = {Value = Default}

				local S = Custom:Create("Frame", {
					BackgroundColor3 = Custom.BgCard, BackgroundTransparency = 0.35,
					BorderSizePixel = 0, LayoutOrder = ItemCount, Size = UDim2.new(1, 0, 0, 35), Name = "Slider"
				}, SectionAdd)
				Custom:Create("UICorner", {CornerRadius = UDim.new(0, 4)}, S)
				Custom:Create("UIStroke", {Color = Custom.BorderColor, Thickness = 0.8}, S)

				Custom:Create("TextLabel", {
					Font = Enum.Font.GothamBold, Text = Title, TextColor3 = Custom.TextBright,
					TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top,
					BackgroundTransparency = 1, BorderSizePixel = 0,
					Position = UDim2.new(0, 10, 0, 10), Size = UDim2.new(1, -180, 0, 13), Name = "SliderTitle"
				}, S)

				local SC = Custom:Create("TextLabel", {
					Font = Enum.Font.Gotham, Text = Content, TextColor3 = Custom.TextMuted,
					TextSize = 12, TextXAlignment = Enum.TextXAlignment.Left,
					TextYAlignment = Enum.TextYAlignment.Bottom, BackgroundTransparency = 1,
					BorderSizePixel = 0, Position = UDim2.new(0, 10, 0, 23), Size = UDim2.new(1, -180, 0, 12), Name = "SliderContent"
				}, S)

				local function UpdateSl()
					SC.TextWrapped = false
					SC.Size = UDim2.new(1, -180, 0, 12 + (12 * math.floor(SC.TextBounds.X / SC.AbsoluteSize.X)))
					S.Size = UDim2.new(1, 0, 0, SC.AbsoluteSize.Y + 33); SC.TextWrapped = true
				end
				SC:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() UpdateSl(); UpdateSizeSection() end)
				UpdateSl()

				local SI = Custom:Create("Frame", {
					AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Custom.BgDark,
					BorderSizePixel = 0, Position = UDim2.new(1, -155, 0.5, 0),
					Size = UDim2.new(0, 30, 0, 20), Name = "SliderInput"
				}, S)
				Custom:Create("UICorner", {CornerRadius = UDim.new(0, 3)}, SI)
				Custom:Create("UIStroke", {Color = Custom.BorderColor, Thickness = 1}, SI)

				local TB = Custom:Create("TextBox", {
					Font = Enum.Font.GothamBold, Text = tostring(Default), TextColor3 = Custom.TextBright,
					TextSize = 12, TextWrapped = true, BackgroundTransparency = 1,
					BorderSizePixel = 0, Position = UDim2.new(0, 0, 0, 0), Size = UDim2.new(1, 0, 1, 0)
				}, SI)

				local SF2 = Custom:Create("Frame", {
					AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Custom.BgDark,
					BackgroundTransparency = 0.2, BorderSizePixel = 0,
					Position = UDim2.new(1, -15, 0.5, 0), Size = UDim2.new(0, 100, 0, 4), Name = "SliderFrame"
				}, S)
				Custom:Create("UICorner", {CornerRadius = UDim.new(1, 0)}, SF2)

				local SD = Custom:Create("Frame", {
					AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Custom.ColorRGB,
					BorderSizePixel = 0, Position = UDim2.new(0, 0, 0.5, 0),
					Size = UDim2.new(0.5, 0, 1, 0), Name = "SliderDraggable"
				}, SF2)
				Custom:Create("UICorner", {CornerRadius = UDim.new(1, 0)}, SD)
				Custom:AddGradient(SD)

				local SC2 = Custom:Create("Frame", {
					AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BorderSizePixel = 0, Position = UDim2.new(1, 3, 0.5, 0),
					Size = UDim2.new(0, 8, 0, 8), Name = "SliderCircle"
				}, SD)
				Custom:Create("UICorner", {CornerRadius = UDim.new(1, 0)}, SC2)

				local Dragging = false
				local function Round(n, f)
					local r = math.floor(n / f + (math.sign(n) * 0.5)) * f
					if r < 0 then r = r + f end; return r
				end

				function FS:Set(Value, Animate)
					Value = math.clamp(Round(Value, Increment), Min, Max)
					FS.Value = Value
					if TB.Text ~= tostring(Value) then TB.Text = tostring(Value) end
					local TS = UDim2.fromScale((Value - Min) / (Max - Min), 1)
					if Animate then
						TweenService:Create(SD, TI_FAST, {Size = TS}):Play()
					else
						SD.Size = TS
					end
				end

				function FS:SetValue(Value, Animate)
					FS:Set(Value, Animate)
					pcall(function() Callback(FS.Value) end)
				end

				function FS:OnChanged(cb)
					Callback = cb
				end

				SF2.InputBegan:Connect(function(i)
					if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
						Dragging = true
					end
				end)

				SF2.InputEnded:Connect(function(i)
					if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
						Dragging = false; pcall(function() Callback(FS.Value) end)
					end
				end)

				local _LastX = nil
				UserInputService.InputChanged:Connect(function(i)
					if Dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
						local cx = i.Position.X
						if cx ~= _LastX then
							_LastX = cx
							local sc = math.clamp((cx - SF2.AbsolutePosition.X) / SF2.AbsoluteSize.X, 0, 1)
							FS:Set(Min + ((Max - Min) * sc), false)
						end
					end
				end)

				TB:GetPropertyChangedSignal("Text"):Connect(function()
					local v = TB.Text:gsub("[^%d]", "")
					if v ~= "" then
						local n = math.min(tonumber(v) or 0, Max)
						if TB.Text ~= tostring(n) then TB.Text = tostring(n) end
					else TB.Text = "0" end
				end)

				TB.FocusLost:Connect(function()
					FS:Set(tonumber(TB.Text) or 0, true); pcall(function() Callback(FS.Value) end)
				end)

				FS:Set(tonumber(Default), true)
				RegisterSearch(Title, S, SearchSubtitle, SelectTab, EnsureSectionOpen, ScrolLayers)
				ItemCount += 1; return FS
			end

			function Item:AddInput(Config, Config2)
				if type(Config) == "string" and type(Config2) == "table" then Config = Config2 end
				local Title = Config[1] or Config.Title or ""
				local Content = Config[2] or Config.Content or Config.Description or ""
				local Default = Config[3] or Config.Default or ""
				local Callback = Config[4] or Config.Callback or function() end
				local FI = {Value = Default}

				local I = Custom:Create("Frame", {
					BackgroundColor3 = Custom.BgCard, BackgroundTransparency = 0.35,
					BorderSizePixel = 0, LayoutOrder = ItemCount, Size = UDim2.new(1, 0, 0, 35), Name = "Input"
				}, SectionAdd)
				Custom:Create("UICorner", {CornerRadius = UDim.new(0, 4)}, I)
				Custom:Create("UIStroke", {Color = Custom.BorderColor, Thickness = 0.8}, I)

				Custom:Create("TextLabel", {
					Font = Enum.Font.GothamBold, Text = Title, TextColor3 = Custom.TextBright,
					TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top,
					BackgroundTransparency = 1, BorderSizePixel = 0,
					Position = UDim2.new(0, 10, 0, 10), Size = UDim2.new(1, -180, 0, 13), Name = "InputTitle"
				}, I)

				local IC = Custom:Create("TextLabel", {
					Font = Enum.Font.Gotham, Text = Content, TextColor3 = Custom.TextMuted,
					TextSize = 12, TextWrapped = true,
					TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Bottom,
					BackgroundTransparency = 1, BorderSizePixel = 0,
					Position = UDim2.new(0, 10, 0, 23), Size = UDim2.new(1, -180, 0, 12),
					Name = "InputContent", Parent = I
				})

				local function UpdateI()
					local r = IC.TextBounds.X / IC.AbsoluteSize.X
					IC.Size = UDim2.new(1, -180, 0, 12 + (12 * math.floor(r)))
					I.Size = UDim2.new(1, 0, 0, IC.AbsoluteSize.Y + 33)
				end
				UpdateI()
				IC:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
					IC.TextWrapped = false; UpdateI(); IC.TextWrapped = true; UpdateSizeSection()
				end)

				local IF2 = Custom:Create("Frame", {
					AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Custom.BgDark,
					BackgroundTransparency = 0.3, BorderSizePixel = 0, ClipsDescendants = true,
					Position = UDim2.new(1, -7, 0.5, 0), Size = UDim2.new(0, 148, 0, 26), Name = "InputFrame"
				}, I)
				Custom:Create("UICorner", {CornerRadius = UDim.new(0, 4)}, IF2)
				Custom:Create("UIStroke", {Color = Custom.BorderColor, Thickness = 1}, IF2)

				local ITB = Custom:Create("TextBox", {
					CursorPosition = -1, Font = Enum.Font.GothamBold,
					PlaceholderColor3 = Custom.TextMuted,
					PlaceholderText = "Write your input...", Text = "",
					TextColor3 = Custom.TextBright, TextSize = 12,
					TextXAlignment = Enum.TextXAlignment.Left, AnchorPoint = Vector2.new(0, 0.5),
					BackgroundTransparency = 1, BorderSizePixel = 0,
					Position = UDim2.new(0, 6, 0.5, 0), Size = UDim2.new(1, -12, 1, 0), Name = "InputTextBox"
				}, IF2)

				function FI:Set(Value)
					ITB.Text = Value; FI.Value = Value
					pcall(function() Callback(Value) end)
				end

				function FI:SetValue(Value)
					FI:Set(Value)
				end

				function FI:OnChanged(cb)
					Callback = cb
				end

				ITB.FocusLost:Connect(function() FI:Set(ITB.Text) end)

				ITB.Text = Default
				FI.Value = Default
				RegisterSearch(Title, I, SearchSubtitle, SelectTab, EnsureSectionOpen, ScrolLayers)
				ItemCount += 1; return FI
			end

			function Item:AddDropdown(Config, Config2)
				if type(Config) == "string" and type(Config2) == "table" then Config = Config2 end
				local Title = Config[1] or Config.Title or ""
				local Content = Config[2] or Config.Content or Config.Description or ""
				local Multi = Config[3] or Config.Multi or false
				local Options = Config[4] or Config.Options or Config.Values or Config.List or {}
				local Default = Config[5] or Config.Default or {}
				local Callback = Config[6] or Config.Callback or function() end

				if type(Default) == "string" then Default = {Default}
				elseif type(Default) ~= "table" then Default = {} end
				if type(Options) ~= "table" then Options = {} end

				local FD = {Value = Default, Options = Options}

				local D = Custom:Create("Frame", {
					BackgroundColor3 = Custom.BgCard, BackgroundTransparency = 0.35,
					BorderSizePixel = 0, LayoutOrder = ItemCount, Size = UDim2.new(1, 0, 0, 35), Name = "Dropdown"
				}, SectionAdd)
				local DB = Custom:Create("TextButton", {
					Font = Enum.Font.SourceSans, Text = "", BackgroundTransparency = 1,
					BorderSizePixel = 0, Size = UDim2.new(1, 0, 1, 0), Name = "ToggleButton"
				}, D)
				Custom:Create("UICorner", {CornerRadius = UDim.new(0, 4)}, D)
				Custom:Create("UIStroke", {Color = Custom.BorderColor, Thickness = 0.8}, D)

				Custom:Create("TextLabel", {
					Font = Enum.Font.GothamBold, Text = Title, TextColor3 = Custom.TextBright,
					TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top,
					BackgroundTransparency = 1, BorderSizePixel = 0,
					Position = UDim2.new(0, 10, 0, 10), Size = UDim2.new(1, -180, 0, 13),
					Name = "DropdownTitle", Parent = D
				})

				local DC = Custom:Create("TextLabel", {
					Font = Enum.Font.Gotham, Text = Content, TextColor3 = Custom.TextMuted,
					TextSize = 12, TextWrapped = true,
					TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Bottom,
					BackgroundTransparency = 1, BorderSizePixel = 0,
					Position = UDim2.new(0, 10, 0, 23), Size = UDim2.new(1, -180, 0, 12),
					Name = "DropdownContent", Parent = D
				})
				DC.Size = UDim2.new(1, -180, 0, 12 + (12 * (DC.TextBounds.X // DC.AbsoluteSize.X)))
				DC.TextWrapped = true; D.Size = UDim2.new(1, 0, 0, DC.AbsoluteSize.Y + 33)
				DC:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
					DC.TextWrapped = false
					DC.Size = UDim2.new(1, -180, 0, 12 + (12 * (DC.TextBounds.X // DC.AbsoluteSize.X)))
					D.Size = UDim2.new(1, 0, 0, DC.AbsoluteSize.Y + 33)
					DC.TextWrapped = true; UpdateSizeSection()
				end)

				local SOF = Custom:Create("Frame", {
					AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Custom.BgDark,
					BackgroundTransparency = 0.3, BorderSizePixel = 0,
					Position = UDim2.new(1, -7, 0.5, 0), Size = UDim2.new(0, 148, 0, 26),
					Name = "SelectOptionsFrame", LayoutOrder = CountDropdown
				}, D)
				Custom:Create("UICorner", {CornerRadius = UDim.new(0, 4)}, SOF)
				Custom:Create("UIStroke", {Color = Custom.BorderColor, Thickness = 1}, SOF)

				DB.Activated:Connect(function()
					if not MoreBlur.Visible then
						MoreBlur.Visible = true
						DropPageLayout:JumpToIndex(SOF.LayoutOrder)
						TweenService:Create(MoreBlur, TI_MED, {BackgroundTransparency = 0.5}):Play()
						TweenService:Create(DropdownSelect, TI_MED, {Position = UDim2.new(1, -11, 0.5, 0)}):Play()
					end
				end)

				local OS = Custom:Create("TextLabel", {
					Font = Enum.Font.GothamBold, Text = "", TextColor3 = Custom.TextBright,
					TextSize = 12, TextWrapped = true,
					TextXAlignment = Enum.TextXAlignment.Left, AnchorPoint = Vector2.new(0, 0.5),
					BackgroundTransparency = 1, BorderSizePixel = 0,
					Position = UDim2.new(0, 8, 0.5, 0), Size = UDim2.new(1, -30, 1, -8), Name = "OptionSelecting"
				}, SOF)
				Custom:Create("ImageLabel", {
					Image = "rbxassetid://90200523188815", ImageColor3 = Custom.TextMuted,
					AnchorPoint = Vector2.new(1, 0.5), BackgroundTransparency = 1,
					BorderSizePixel = 0, Position = UDim2.new(1, -2, 0.5, 0), Size = UDim2.new(0, 18, 0, 18)
				}, SOF)

				local SS = Custom:Create("ScrollingFrame", {
					CanvasSize = UDim2.new(0, 0, 0, 0), ScrollBarImageColor3 = Custom.ColorRGB,
					ScrollBarThickness = 2, Active = true, LayoutOrder = CountDropdown,
					BackgroundTransparency = 1, BorderSizePixel = 0,
					Size = UDim2.new(1, 0, 1, 0), Name = "ScrollSelect", Parent = DropdownFolder
				})
				Custom:Create("UIListLayout", {Padding = UDim.new(0, 3), SortOrder = Enum.SortOrder.LayoutOrder}, SS)

				local SB = Custom:Create("TextBox", {
					Font = Enum.Font.GothamBold, PlaceholderText = "Search...",
					PlaceholderColor3 = Custom.TextMuted, Text = "",
					TextColor3 = Custom.TextBright, TextSize = 12,
					BackgroundColor3 = Custom.BgDark, BackgroundTransparency = 0.5,
					BorderSizePixel = 0, Size = UDim2.new(1, 0, 0, 24), Name = "SearchBar", Parent = SS
				})
				Custom:Create("UICorner", {CornerRadius = UDim.new(0, 4)}, SB)
				Custom:Create("UIStroke", {Color = Custom.BorderColor, Thickness = 1}, SB)

				SB:GetPropertyChangedSignal("Text"):Connect(function()
					local q = string.lower(SB.Text)
					for _, v in pairs(SS:GetChildren()) do
						if v:IsA("Frame") and v.Name == "Option" then
							local ot = v:FindFirstChild("OptionText")
							if ot then v.Visible = string.find(string.lower(ot.Text), q) ~= nil end
						end
					end
				end)

				local DropCount = 0
				function FD:Clear()
					for _, f in pairs(SS:GetChildren()) do
						if f.Name == "Option" then FD.Value = {}; FD.Options = {}; OS.Text = "Select Options"; f:Destroy() end
					end
				end

				function FD:Set(Value)
					Value = Value or FD.Value
					if type(Value) == "string" then Value = {Value}
					elseif type(Value) ~= "table" then Value = {} end
					FD.Value = Value
					for _, Drop in pairs(SS:GetChildren()) do
						if Drop.Name ~= "UIListLayout" and Drop.Name ~= "SearchBar" then
							local found = table.find(FD.Value, Drop.OptionText.Text) ~= nil
							local ChooseFrame = Drop.ChooseFrame
							TweenService:Create(ChooseFrame, TI_FAST, {Size = found and UDim2.new(0, 2, 0, 12) or UDim2.new(0, 0, 0, 0)}):Play()
							TweenService:Create(ChooseFrame.UIStroke, TI_FAST, {Transparency = found and 0 or 1}):Play()
							TweenService:Create(Drop, TI_FAST, {
								BackgroundColor3 = found and Custom.ColorRGB or Color3.fromRGB(255, 255, 255),
								BackgroundTransparency = found and 0.85 or 1
							}):Play()
						end
					end
					local dv = table.concat(FD.Value, ", ")
					OS.Text = dv ~= "" and dv or "Select Options"
					pcall(function()
						if Multi then
							Callback(FD.Value)
						else
							Callback(FD.Value[1] or "")
						end
					end)
				end

				function FD:SetValue(Value)
					FD:Set(Value)
				end

				function FD:SetValues(List, Sel)
					FD:Refresh(List, Sel)
				end

				function FD:OnChanged(cb)
					Callback = cb
				end

				function FD:AddOption(OptionName)
					OptionName = OptionName or "Option"
					local O = Custom:Create("Frame", {
						BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1,
						BorderSizePixel = 0, LayoutOrder = DropCount,
						Size = UDim2.new(1, 0, 0, 28), Name = "Option", Parent = SS
					})
					Custom:Create("UICorner", {CornerRadius = UDim.new(0, 4)}, O)

					local OB = Custom:Create("TextButton", {
						Font = Enum.Font.GothamBold, Text = "", TextColor3 = Custom.TextBright,
						TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left,
						BackgroundTransparency = 1, BorderSizePixel = 0,
						Size = UDim2.new(1, 0, 1, 0), Name = "OptionButton", Parent = O
					})
					Custom:Create("TextLabel", {
						Font = Enum.Font.GothamBold, Text = OptionName, TextSize = 12,
						TextColor3 = Custom.TextBright, TextXAlignment = Enum.TextXAlignment.Left,
						TextYAlignment = Enum.TextYAlignment.Center, BackgroundTransparency = 1,
						BorderSizePixel = 0, Position = UDim2.new(0, 10, 0, 0),
						Size = UDim2.new(1, -20, 1, 0), Name = "OptionText", Parent = O
					})

					local CF = Custom:Create("Frame", {
						AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Custom.ColorRGB,
						BorderSizePixel = 0, Position = UDim2.new(0, 2, 0.5, 0),
						Size = UDim2.new(0, 0, 0, 0), Name = "ChooseFrame", Parent = O
					})
					Custom:AddGradient(CF, 90)
					Custom:AddGradient(Custom:Create("UIStroke", {Color = Custom.ColorRGB, Thickness = 1.2, Transparency = 1}, CF), 90)
					Custom:Create("UICorner", {}, CF)

					OB.Activated:Connect(function()
						CircleClick(OB, Player:GetMouse().X, Player:GetMouse().Y)
						local currentlySelected = table.find(FD.Value, OptionName) ~= nil
						if Multi then
							if currentlySelected then
								for i, v in ipairs(FD.Value) do
									if v == OptionName then table.remove(FD.Value, i); break end
								end
							else
								table.insert(FD.Value, OptionName)
							end
						else
							FD.Value = currentlySelected and {} or {OptionName}
						end
						FD:Set(FD.Value)
					end)

					local function UpdateCanvas()
						local oy = 0
						for _, c in ipairs(SS:GetChildren()) do
							if c.Name ~= "UIListLayout" and c.Name ~= "SearchBar" then oy = oy + 4 + c.Size.Y.Offset end
						end
						SS.CanvasSize = UDim2.new(0, 0, 0, oy + 28)
					end
					UpdateCanvas(); DropCount += 1
				end

				function FD:Refresh(List, Sel)
					List = type(List) == "table" and List or {}
					Sel = Sel or FD.Value
					FD:Clear()
					for _, v in ipairs(List) do FD:AddOption(v) end
					FD.Options = List
					if type(Sel) == "string" then Sel = {Sel}
					elseif type(Sel) ~= "table" then Sel = {} end
					FD.Value = Sel
					for _, Drop in pairs(SS:GetChildren()) do
						if Drop.Name ~= "UIListLayout" and Drop.Name ~= "SearchBar" then
							local found = table.find(FD.Value, Drop.OptionText.Text) ~= nil
							local ChooseFrame = Drop.ChooseFrame
							ChooseFrame.Size = found and UDim2.new(0, 2, 0, 12) or UDim2.new(0, 0, 0, 0)
							ChooseFrame.UIStroke.Transparency = found and 0 or 1
							Drop.BackgroundColor3 = found and Custom.ColorRGB or Color3.fromRGB(255, 255, 255)
							Drop.BackgroundTransparency = found and 0.85 or 1
						end
					end
					local dv = table.concat(FD.Value, ", ")
					OS.Text = dv ~= "" and dv or "Select Options"
				end

				FD:Refresh(FD.Options, FD.Value)
				RegisterSearch(Title, D, SearchSubtitle, SelectTab, EnsureSectionOpen, ScrolLayers)
				ItemCount += 1; CountDropdown += 1; return FD
			end

			function Item:AddKeybind(Config, Config2)
				if type(Config) == "string" and type(Config2) == "table" then Config = Config2 end
				local Title = Config[1] or Config.Title or ""
				local Content = Config[2] or Config.Content or Config.Description or ""
				local Default = Config[3] or Config.Default or Enum.KeyCode.Unknown
				local Callback = Config[4] or Config.Callback or function() end
				local FK = {Value = Default}

				local K = Custom:Create("Frame", {
					BackgroundColor3 = Custom.BgCard, BackgroundTransparency = 0.35,
					BorderSizePixel = 0, LayoutOrder = ItemCount, Size = UDim2.new(1, 0, 0, 35), Name = "Keybind"
				}, SectionAdd)
				Custom:Create("UICorner", {CornerRadius = UDim.new(0, 4)}, K)
				Custom:Create("UIStroke", {Color = Custom.BorderColor, Thickness = 0.8}, K)

				Custom:Create("TextLabel", {
					Font = Enum.Font.GothamBold, Text = Title, TextColor3 = Custom.TextBright,
					TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top,
					BackgroundTransparency = 1, BorderSizePixel = 0,
					Position = UDim2.new(0, 10, 0, 10), Size = UDim2.new(1, -100, 0, 13), Name = "KeybindTitle"
				}, K)

				Custom:Create("TextLabel", {
					Font = Enum.Font.Gotham, Text = Content, TextColor3 = Custom.TextMuted,
					TextSize = 12, TextXAlignment = Enum.TextXAlignment.Left,
					TextYAlignment = Enum.TextYAlignment.Bottom, BackgroundTransparency = 1,
					BorderSizePixel = 0, Position = UDim2.new(0, 10, 0, 23),
					Size = UDim2.new(1, -100, 0, 12), Name = "KeybindContent"
				}, K)

				local KB = Custom:Create("TextButton", {
					Font = Enum.Font.GothamBold, Text = Default and Default.Name or "None",
					TextColor3 = Custom.TextBright, TextSize = 12,
					AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Custom.BgDark,
					BackgroundTransparency = 0.2, BorderSizePixel = 0,
					Position = UDim2.new(1, -10, 0.5, 0), Size = UDim2.new(0, 70, 0, 22), Name = "KeybindButton"
				}, K)
				Custom:Create("UICorner", {CornerRadius = UDim.new(0, 4)}, KB)
				Custom:Create("UIStroke", {Color = Custom.BorderColor, Thickness = 1}, KB)

				local Listening = false
				function FK:Set(NewKey)
					FK.Value = NewKey
					KB.Text = (NewKey and NewKey ~= Enum.KeyCode.Unknown) and NewKey.Name or "None"
				end

				function FK:SetValue(NewKey)
					FK:Set(NewKey)
				end

				function FK:OnChanged(cb)
					Callback = cb
				end

				KB.Activated:Connect(function()
					CircleClick(KB, Player:GetMouse().X, Player:GetMouse().Y)
					Listening = true; KB.Text = "..."
				end)

				local bindConn = UserInputService.InputBegan:Connect(function(Input, GP)
					if Listening then
						if Input.UserInputType == Enum.UserInputType.Keyboard then
							Listening = false; FK:Set(Input.KeyCode)
						end
					elseif not GP and Input.UserInputType == Enum.UserInputType.Keyboard then
						if FK.Value and Input.KeyCode == FK.Value then pcall(function() Callback(FK.Value) end) end
					end
				end)
				table.insert(ActiveConnections, bindConn)

				FK:Set(Default)
				RegisterSearch(Title, K, SearchSubtitle, SelectTab, EnsureSectionOpen, ScrolLayers)
				ItemCount += 1; return FK
			end

			function Item:AddSocial(Config, Config2)
				if type(Config) == "string" and type(Config2) == "table" then Config = Config2 end
				local PlatformIcon = Config[1] or Config.Icon or ""
				local Title = Config[2] or Config.Title or ""
				local Code = Config[3] or Config.Code or ""
				local FS = {}

				local S = Custom:Create("Frame", {
					BackgroundColor3 = Custom.BgCard, BackgroundTransparency = 0.35,
					BorderSizePixel = 0, LayoutOrder = ItemCount, Size = UDim2.new(1, 0, 0, 38), Name = "Social"
				}, SectionAdd)
				Custom:Create("UICorner", {CornerRadius = UDim.new(0, 4)}, S)
				Custom:Create("UIStroke", {Color = Custom.BorderColor, Thickness = 0.8}, S)

				local IconGap = 0
				if PlatformIcon ~= "" then
					IconGap = 26
					Custom:Create("ImageLabel", {
						Image = PlatformIcon, BackgroundTransparency = 1,
						AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 10, 0.5, 0),
						Size = UDim2.new(0, 18, 0, 18), Name = "PlatformIcon", Parent = S
					})
				end

				Custom:Create("TextLabel", {
					Font = Enum.Font.GothamBold, Text = Title, TextColor3 = Custom.TextBright,
					TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left, BackgroundTransparency = 1,
					AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 10 + IconGap, 0.5, 0),
					Size = UDim2.new(1, -(94 + IconGap), 0, 18), Name = "SocialTitle", Parent = S
				})

				local CB2 = Custom:Create("TextButton", {
					Font = Enum.Font.GothamBold, Text = "Copy",
					TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 12,
					BackgroundColor3 = Custom.ColorRGB, BackgroundTransparency = 0.1,
					BorderSizePixel = 0, AnchorPoint = Vector2.new(1, 0.5),
					Position = UDim2.new(1, -8, 0.5, 0), Size = UDim2.new(0, 60, 0, 24), Name = "CopyButton", Parent = S
				})
				Custom:Create("UICorner", {CornerRadius = UDim.new(0, 4)}, CB2)

				local CG = 0
				CB2.Activated:Connect(function()
					CircleClick(CB2, Player:GetMouse().X, Player:GetMouse().Y)
					pcall(function() if setclipboard then setclipboard(Code) end end)
					CG += 1; local TG = CG
					CB2.Text = "Copied!"
					task.delay(2, function() if TG == CG then CB2.Text = "Copy" end end)
				end)

				function FS:SetCode(c) Code = c end
				RegisterSearch(Title, S, SearchSubtitle, SelectTab, EnsureSectionOpen, ScrolLayers)
				ItemCount += 1; return FS
			end

			function Item:AddReadMe(Config, Config2)
				if type(Config) == "string" and type(Config2) == "table" then Config = Config2 end
				local Title = Config[1] or Config.Title or "README"
				local Content = Config[2] or Config.Content or Config.Description or ""
				local Style = Config[3] or Config.Style or "Accordion"
				local RF = {}

				if Style == "Badge" then
					local Badge = Custom:Create("Frame", {
						BackgroundColor3 = Custom.BgCard, BackgroundTransparency = 0.4,
						BorderSizePixel = 0, LayoutOrder = ItemCount, Size = UDim2.new(1,0,0,26), Name = "ReadMeBadge"
					}, SectionAdd)
					Custom:Create("UICorner", {CornerRadius = UDim.new(1,0)}, Badge)
					Custom:Create("UIStroke", {Color = Custom.BorderColor, Thickness = 1}, Badge)

					local BI = Custom:Create("Frame", {AnchorPoint = Vector2.new(0,0.5), BackgroundColor3 = Custom.ColorRGB,
						BorderSizePixel = 0, Position = UDim2.new(0,8,0.5,0), Size = UDim2.new(0,6,0,6), Parent = Badge})
					Custom:Create("UICorner", {CornerRadius = UDim.new(1,0)}, BI)

					local BL = Custom:Create("TextLabel", {
						Font = Enum.Font.GothamBold, Text = Title .. (Content ~= "" and (" | "..Content) or ""),
						TextColor3 = Custom.TextBright, TextSize = 11, TextXAlignment = Enum.TextXAlignment.Left,
						BackgroundTransparency = 1, Position = UDim2.new(0,20,0,0), Size = UDim2.new(1,-25,1,0), Parent = Badge
					})

					function RF:Set(nc) BL.Text = Title..(nc ~= "" and (" | "..nc) or "") end
					function RF:SetTitle(nt) Title = nt; BL.Text = nt..(Content ~= "" and (" | "..Content) or "") end
					RegisterSearch(Title, Badge, SearchSubtitle, SelectTab, EnsureSectionOpen, ScrolLayers)
					ItemCount += 1; return RF
				end

				local IsAcc = Style ~= "Plain"
				local Expanded = IsAcc and (Config.Open or false) or true

				local RM = Custom:Create("Frame", {
					BackgroundColor3 = Custom.BgCard, BackgroundTransparency = 0.35,
					BorderSizePixel = 0, ClipsDescendants = true,
					LayoutOrder = ItemCount, Size = UDim2.new(1,0,0,30), Name = "ReadMe"
				}, SectionAdd)
				Custom:Create("UICorner", {CornerRadius = UDim.new(0,4)}, RM)
				Custom:Create("UIStroke", {Color = Custom.BorderColor, Thickness = 0.8}, RM)

				local HB = Custom:Create("TextButton", {
					Font = Enum.Font.SourceSans, Text = "", BackgroundTransparency = 1,
					BorderSizePixel = 0, Size = UDim2.new(1,0,0,30), Visible = IsAcc, Name = "HeaderButton", Parent = RM
				})

				local RMT = Custom:Create("TextLabel", {
					Font = Enum.Font.GothamBold, Text = Title, TextColor3 = Custom.ColorRGB,
					TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left, BackgroundTransparency = 1,
					BorderSizePixel = 0, Position = UDim2.new(0,10,0,0), Size = UDim2.new(1,-40,0,30), Parent = RM
				})

				local Chev
				if IsAcc then
					Chev = Custom:Create("ImageLabel", {
						Image = "rbxassetid://125609963478878", ImageColor3 = Custom.ColorRGB,
						AnchorPoint = Vector2.new(1,0.5), BackgroundTransparency = 1, BorderSizePixel = 0,
						Position = UDim2.new(1,-10,0,15), Rotation = Expanded and 90 or -90,
						Size = UDim2.new(0,12,0,12), Name = "Chevron", Parent = RM
					})
				end

				local RMC = Custom:Create("TextLabel", {
					Font = Enum.Font.Gotham, Text = Content, TextColor3 = Custom.TextMuted,
					TextSize = 12, TextWrapped = true,
					TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top,
					BackgroundTransparency = 1, BorderSizePixel = 0,
					Position = UDim2.new(0,10,0,IsAcc and 30 or 24), Size = UDim2.new(1,-20,0,13), Parent = RM
				})

				local function UpdateRM()
					RMC.TextWrapped = false
					local lc = math.max(math.ceil(RMC.TextBounds.X / RMC.AbsoluteSize.X), 1)
					RMC.Size = UDim2.new(1,-20,0,14*lc); RMC.TextWrapped = true
					local hh = IsAcc and 30 or 24
					local fh = hh + RMC.AbsoluteSize.Y + 10
					RM.Size = UDim2.new(1,0,0,Expanded and fh or hh); UpdateSizeSection()
				end
				UpdateRM()
				RMC:GetPropertyChangedSignal("AbsoluteSize"):Connect(UpdateRM)

				if IsAcc then
					HB.Activated:Connect(function()
						CircleClick(HB, Player:GetMouse().X, Player:GetMouse().Y)
						Expanded = not Expanded
						TweenService:Create(Chev, TI_FAST, {Rotation = Expanded and 90 or -90}):Play()
						UpdateRM()
					end)
				end

				function RF:Set(nc) Content = nc; RMC.Text = nc; UpdateRM() end
				function RF:SetTitle(nt) Title = nt; RMT.Text = nt end
				function RF:SetOpen(io)
					if IsAcc and Expanded ~= io then
						Expanded = io
						if Chev then TweenService:Create(Chev, TI_FAST, {Rotation = io and 90 or -90}):Play() end
						UpdateRM()
					end
				end

				RegisterSearch(Title, RM, SearchSubtitle, SelectTab, EnsureSectionOpen, ScrolLayers)
				ItemCount += 1; return RF
			end

			ItemCount += 1
			return Item
		end

		CountTab += 1
		return Sections
	end

	Funcs.CreateTab = Tabs.CreateTab
	Funcs.AddTab = Tabs.CreateTab
	Funcs.Notify = w424_Library.SetNotification
	Funcs.SetNotification = w424_Library.SetNotification

	function Funcs:Dialog(Config)
		return {}
	end

	function Funcs:SelectTab(Index)
		pcall(function()
			LayersPageLayout:JumpToIndex(Index)
		end)
	end

	return Funcs
end

getgenv = getgenv or function() return _G end
getgenv().w424 = w424_Library
getgenv().w424_Library = w424_Library

return w424_Library
