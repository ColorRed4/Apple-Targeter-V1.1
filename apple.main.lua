local TargetName = ""
local RotationSpeed = 6
local RotationDistance = 5
local CurrentLanguage = "RU"
local InitialMenuClosed = false

local DARK_COLOR = Color3.fromRGB(10, 10, 10)
local BG_ACCENT = Color3.fromRGB(20, 20, 20)
local TEXT_COLOR = Color3.new(1, 1, 1)
local RED_COLOR = Color3.fromRGB(80, 0, 0)
local DARK_RED = Color3.fromRGB(40, 10, 10)
local ACCENT_FONT = Enum.Font.GothamBold

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "StableTargetGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 100
ScreenGui.Parent = PlayerGui

local function makeCorner(obj, radius)
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, radius or 6)
	corner.Parent = obj
	return corner
end

local function createRGBStroke(parent, thickness)
	local stroke = Instance.new("UIStroke")
	stroke.Name = "RGBStroke"
	stroke.Thickness = thickness or 2
	stroke.Transparency = 0
	stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	stroke.Parent = parent
	return stroke
end

local function makeDraggable(obj)
	local dragging = false
	local dragStart
	local startPos
	local dragInput

	obj.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch then

			dragging = true
			dragStart = input.Position
			startPos = obj.Position

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	obj.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement
			or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if dragging and input == dragInput then
			local delta = input.Position - dragStart

			obj.Position = UDim2.new(
				startPos.X.Scale,
				startPos.X.Offset + delta.X,
				startPos.Y.Scale,
				startPos.Y.Offset + delta.Y
			)
		end
	end)
end

local function pulseColor()
	local t = (math.sin(os.clock() * 3) + 1) / 2
	return Color3.new(t, 0, 0)
end

local LanguageText = {
	RU = {
		initialTitle = "скрипт сделан сообществом Etraxon",
		telegram = "Телеграм-канал",
		mainMenu = "МЕНЮ",
		speed = "Скорость",
		distance = "Дальность",
		target = "ТЕКУЩАЯ ЦЕЛЬ...",
		stick = "Приклеиться",
		spin = "Крутиться",
		orbit = "Орбита",
		float = "Качание",
		antisit = "Анти-сит",
		jitter = "Хаотичный Рывок",
		selectPlayer = "ВЫБРАТЬ ИГРОКА",
		closeList = "ЗАКРЫТЬ СПИСОК",
		refresh = "ОБНОВИТЬ СПИСОК",
		settings = "НАСТРОЙКИ",
		language = "ЯЗЫК",
		russian = "РУССКИЙ",
		english = "АНГЛИЙСКИЙ",
		copied = "Ссылка скопирована"
	},

	EN = {
		initialTitle = "script made by Etraxon community",
		telegram = "Telegram channel",
		mainMenu = "MENU",
		speed = "Speed",
		distance = "Distance",
		target = "CURRENT TARGET...",
		stick = "Stick",
		spin = "Spin",
		orbit = "Orbit",
		float = "Float",
		antisit = "Anti-Sit",
		jitter = "Chaotic Jerk",
		selectPlayer = "SELECT PLAYER",
		closeList = "CLOSE LIST",
		refresh = "REFRESH LIST",
		settings = "SETTINGS",
		language = "LANGUAGE",
		russian = "RUSSIAN",
		english = "ENGLISH",
		copied = "Link copied"
	}
}

local function T(key)
	return LanguageText[CurrentLanguage][key]
end

local InitialFrame = Instance.new("Frame")
InitialFrame.Name = "InitialFrame"
InitialFrame.Size = UDim2.new(0, 400, 0, 270)
InitialFrame.Position = UDim2.new(0.5, -200, 0.42, -135)
InitialFrame.BackgroundColor3 = DARK_COLOR
InitialFrame.BorderSizePixel = 0
InitialFrame.Parent = ScreenGui
makeCorner(InitialFrame, 10)

local InitialStroke = createRGBStroke(InitialFrame, 2)

local InitialTitle = Instance.new("TextLabel")
InitialTitle.Size = UDim2.new(1, -30, 0, 50)
InitialTitle.Position = UDim2.new(0, 15, 0, 40)
InitialTitle.BackgroundTransparency = 1
InitialTitle.TextColor3 = TEXT_COLOR
InitialTitle.Text = T("initialTitle")
InitialTitle.Font = Enum.Font.Gotham
InitialTitle.TextSize = 18
InitialTitle.TextWrapped = true
InitialTitle.Parent = InitialFrame

local TelegramButton = Instance.new("TextButton")
TelegramButton.Size = UDim2.new(0, 230, 0, 40)
TelegramButton.Position = UDim2.new(0.5, -115, 0, 110)
TelegramButton.BackgroundColor3 = BG_ACCENT
TelegramButton.TextColor3 = TEXT_COLOR
TelegramButton.Text = T("telegram")
TelegramButton.Font = Enum.Font.Gotham
TelegramButton.TextSize = 16
TelegramButton.BorderSizePixel = 0
TelegramButton.Parent = InitialFrame
makeCorner(TelegramButton, 7)

createRGBStroke(TelegramButton, 1)

local InitialClose = Instance.new("TextButton")
InitialClose.Size = UDim2.new(0, 75, 0, 62)
InitialClose.Position = UDim2.new(0.5, -37, 1, -82)
InitialClose.BackgroundColor3 = BG_ACCENT
InitialClose.TextColor3 = Color3.fromRGB(255, 0, 0)
InitialClose.Text = "×"
InitialClose.Font = Enum.Font.GothamBold
InitialClose.TextSize = 50
InitialClose.BorderSizePixel = 0
InitialClose.Parent = InitialFrame
makeCorner(InitialClose, 8)

local InitialMenuButton = Instance.new("TextButton")
InitialMenuButton.Name = "InitialMenuButton"
InitialMenuButton.Size = UDim2.new(0, 110, 0, 38)
InitialMenuButton.Position = UDim2.new(0.5, -340, 0.42, -19)
InitialMenuButton.BackgroundColor3 = DARK_COLOR
InitialMenuButton.TextColor3 = TEXT_COLOR
InitialMenuButton.Text = T("mainMenu")
InitialMenuButton.Font = ACCENT_FONT
InitialMenuButton.TextSize = 14
InitialMenuButton.BorderSizePixel = 0
InitialMenuButton.Parent = ScreenGui
makeCorner(InitialMenuButton, 8)

local InitialMenuStroke = createRGBStroke(InitialMenuButton, 2)

makeDraggable(InitialFrame)
makeDraggable(InitialMenuButton)

InitialMenuButton.MouseButton1Click:Connect(function()
	InitialFrame.Visible = not InitialFrame.Visible
end)

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 420, 0, 285)
MainFrame.Position = UDim2.new(0.5, -210, 0.4, -142)
MainFrame.BackgroundColor3 = DARK_COLOR
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false
MainFrame.Parent = ScreenGui
makeCorner(MainFrame, 9)

local MainStroke = createRGBStroke(MainFrame, 2)

makeDraggable(MainFrame)

local SettingsHolder = Instance.new("Frame")
SettingsHolder.Name = "SettingsHolder"
SettingsHolder.Size = UDim2.new(0, 480, 0, 62)
SettingsHolder.Position = UDim2.new(0, 0, 0, -69)
SettingsHolder.BackgroundTransparency = 1
SettingsHolder.Parent = MainFrame

local SettingsFrame = Instance.new("Frame")
SettingsFrame.Size = UDim2.new(0, 420, 0, 55)
SettingsFrame.Position = UDim2.new(0, 0, 0, 0)
SettingsFrame.BackgroundColor3 = DARK_COLOR
SettingsFrame.BorderSizePixel = 0
SettingsFrame.Parent = SettingsHolder
makeCorner(SettingsFrame, 8)

local SettingsStroke = createRGBStroke(SettingsFrame, 2)

local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Size = UDim2.new(0, 155, 0, 22)
SpeedLabel.Position = UDim2.new(0, 10, 0, 2)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.TextColor3 = TEXT_COLOR
SpeedLabel.Text = T("speed")
SpeedLabel.Font = ACCENT_FONT
SpeedLabel.TextSize = 14
SpeedLabel.Parent = SettingsFrame

local DistanceLabel = Instance.new("TextLabel")
DistanceLabel.Size = UDim2.new(0, 155, 0, 22)
DistanceLabel.Position = UDim2.new(0, 210, 0, 2)
DistanceLabel.BackgroundTransparency = 1
DistanceLabel.TextColor3 = TEXT_COLOR
DistanceLabel.Text = T("distance")
DistanceLabel.Font = ACCENT_FONT
DistanceLabel.TextSize = 14
DistanceLabel.Parent = SettingsFrame

local SpeedBox = Instance.new("TextBox")
SpeedBox.Size = UDim2.new(0, 155, 0, 27)
SpeedBox.Position = UDim2.new(0, 10, 0, 25)
SpeedBox.BackgroundColor3 = BG_ACCENT
SpeedBox.TextColor3 = TEXT_COLOR
SpeedBox.Text = tostring(RotationSpeed)
SpeedBox.PlaceholderText = tostring(RotationSpeed)
SpeedBox.ClearTextOnFocus = false
SpeedBox.Font = ACCENT_FONT
SpeedBox.TextSize = 11
SpeedBox.BorderSizePixel = 0
SpeedBox.Parent = SettingsFrame
makeCorner(SpeedBox, 6)

local DistanceBox = Instance.new("TextBox")
DistanceBox.Size = UDim2.new(0, 155, 0, 27)
DistanceBox.Position = UDim2.new(0, 210, 0, 25)
DistanceBox.BackgroundColor3 = BG_ACCENT
DistanceBox.TextColor3 = TEXT_COLOR
DistanceBox.Text = tostring(RotationDistance)
DistanceBox.PlaceholderText = tostring(RotationDistance)
DistanceBox.ClearTextOnFocus = false
DistanceBox.Font = ACCENT_FONT
DistanceBox.TextSize = 11
DistanceBox.BorderSizePixel = 0
DistanceBox.Parent = SettingsFrame
makeCorner(DistanceBox, 6)

local GearButton = Instance.new("TextButton")
GearButton.Size = UDim2.new(0, 62, 0, 55)
GearButton.Position = UDim2.new(0, 430, 0, 0)
GearButton.BackgroundColor3 = DARK_COLOR
GearButton.TextColor3 = TEXT_COLOR
GearButton.Text = "⚙"
GearButton.Font = Enum.Font.GothamBold
GearButton.TextSize = 30
GearButton.BorderSizePixel = 0
GearButton.Parent = SettingsHolder
makeCorner(GearButton, 8)

local GearStroke = createRGBStroke(GearButton, 2)

local LanguageFrame = Instance.new("Frame")
LanguageFrame.Name = "LanguageFrame"
LanguageFrame.Size = UDim2.new(0, 210, 0, 135)
LanguageFrame.Position = UDim2.new(0, 205, 0, 62)
LanguageFrame.BackgroundColor3 = DARK_COLOR
LanguageFrame.BorderSizePixel = 0
LanguageFrame.Visible = false
LanguageFrame.ZIndex = 50
LanguageFrame.Parent = SettingsHolder
makeCorner(LanguageFrame, 8)

local LanguageStroke = createRGBStroke(LanguageFrame, 2)

local LanguageTitle = Instance.new("TextLabel")
LanguageTitle.Size = UDim2.new(1, -16, 0, 27)
LanguageTitle.Position = UDim2.new(0, 8, 0, 5)
LanguageTitle.BackgroundTransparency = 1
LanguageTitle.TextColor3 = TEXT_COLOR
LanguageTitle.Text = T("language")
LanguageTitle.Font = ACCENT_FONT
LanguageTitle.TextSize = 13
LanguageTitle.ZIndex = 51
LanguageTitle.Parent = LanguageFrame

local RussianButton = Instance.new("TextButton")
RussianButton.Size = UDim2.new(1, -16, 0, 38)
RussianButton.Position = UDim2.new(0, 8, 0, 36)
RussianButton.BackgroundColor3 = BG_ACCENT
RussianButton.TextColor3 = TEXT_COLOR
RussianButton.Text = T("russian")
RussianButton.Font = ACCENT_FONT
RussianButton.TextSize = 11
RussianButton.BorderSizePixel = 0
RussianButton.ZIndex = 51
RussianButton.Parent = LanguageFrame
makeCorner(RussianButton, 6)

local EnglishButton = Instance.new("TextButton")
EnglishButton.Size = UDim2.new(1, -16, 0, 38)
EnglishButton.Position = UDim2.new(0, 8, 0, 80)
EnglishButton.BackgroundColor3 = BG_ACCENT
EnglishButton.TextColor3 = TEXT_COLOR
EnglishButton.Text = T("english")
EnglishButton.Font = ACCENT_FONT
EnglishButton.TextSize = 11
EnglishButton.BorderSizePixel = 0
EnglishButton.ZIndex = 51
EnglishButton.Parent = LanguageFrame
makeCorner(EnglishButton, 6)

local NameInput = Instance.new("TextBox")
NameInput.Size = UDim2.new(0, 390, 0, 32)
NameInput.Position = UDim2.new(0.5, -195, 0, 13)
NameInput.BackgroundColor3 = BG_ACCENT
NameInput.TextColor3 = TEXT_COLOR
NameInput.Text = ""
NameInput.PlaceholderText = T("target")
NameInput.Font = ACCENT_FONT
NameInput.TextSize = 11
NameInput.BorderSizePixel = 0
NameInput.Parent = MainFrame
makeCorner(NameInput, 6)

NameInput.FocusLost:Connect(function()
	TargetName = NameInput.Text
end)

local ButtonsContainer = Instance.new("Frame")
ButtonsContainer.Name = "ButtonsContainer"
ButtonsContainer.Size = UDim2.new(1, -20, 0, 150)
ButtonsContainer.Position = UDim2.new(0, 10, 0, 55)
ButtonsContainer.BackgroundTransparency = 1
ButtonsContainer.Parent = MainFrame

local ButtonsGrid = Instance.new("UIGridLayout")
ButtonsGrid.CellSize = UDim2.new(0, 185, 0, 38)
ButtonsGrid.CellPadding = UDim2.new(0, 10, 0, 7)
ButtonsGrid.HorizontalAlignment = Enum.HorizontalAlignment.Center
ButtonsGrid.Parent = ButtonsContainer

local ListToggleBtn = Instance.new("TextButton")
ListToggleBtn.Size = UDim2.new(0, 390, 0, 32)
ListToggleBtn.Position = UDim2.new(0.5, -195, 1, -43)
ListToggleBtn.BackgroundColor3 = DARK_RED
ListToggleBtn.Text = T("selectPlayer")
ListToggleBtn.TextColor3 = TEXT_COLOR
ListToggleBtn.Font = ACCENT_FONT
ListToggleBtn.TextSize = 11
ListToggleBtn.BorderSizePixel = 0
ListToggleBtn.Parent = MainFrame
makeCorner(ListToggleBtn, 6)

local PlayerListFrame = Instance.new("Frame")
PlayerListFrame.Size = UDim2.new(0, 390, 0, 170)
PlayerListFrame.Position = UDim2.new(0.5, -195, 0, 55)
PlayerListFrame.BackgroundColor3 = Color3.fromRGB(15, 5, 5)
PlayerListFrame.BorderSizePixel = 0
PlayerListFrame.Visible = false
PlayerListFrame.ZIndex = 20
PlayerListFrame.Parent = MainFrame
makeCorner(PlayerListFrame, 7)

createRGBStroke(PlayerListFrame, 1)

local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Size = UDim2.new(1, -8, 1, -36)
ScrollFrame.Position = UDim2.new(0, 4, 0, 4)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollFrame.ScrollBarThickness = 4
ScrollFrame.ZIndex = 21
ScrollFrame.Parent = PlayerListFrame

local ListLayout = Instance.new("UIListLayout")
ListLayout.Padding = UDim.new(0, 4)
ListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
ListLayout.Parent = ScrollFrame

local ManualRefreshBtn = Instance.new("TextButton")
ManualRefreshBtn.Size = UDim2.new(1, -8, 0, 29)
ManualRefreshBtn.Position = UDim2.new(0, 4, 1, -33)
ManualRefreshBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ManualRefreshBtn.Text = T("refresh")
ManualRefreshBtn.TextColor3 = TEXT_COLOR
ManualRefreshBtn.Font = ACCENT_FONT
ManualRefreshBtn.TextSize = 9
ManualRefreshBtn.ZIndex = 22
ManualRefreshBtn.BorderSizePixel = 0
ManualRefreshBtn.Parent = PlayerListFrame
makeCorner(ManualRefreshBtn, 5)

local function updatePlayerList()
	for _, child in ipairs(ScrollFrame:GetChildren()) do
		if child:IsA("TextButton") then
			child:Destroy()
		end
	end

	for _, player in ipairs(Players:GetPlayers()) do
		if player ~= LocalPlayer then
			local pBtn = Instance.new("TextButton")
			pBtn.Size = UDim2.new(0, 370, 0, 28)
			pBtn.BackgroundColor3 = BG_ACCENT
			pBtn.Text = player.Name
			pBtn.TextColor3 = TEXT_COLOR
			pBtn.Font = Enum.Font.SourceSansBold
			pBtn.TextSize = 13
			pBtn.BorderSizePixel = 0
			pBtn.ZIndex = 22
			pBtn.Parent = ScrollFrame
			makeCorner(pBtn, 5)

			pBtn.MouseButton1Click:Connect(function()
				TargetName = player.Name
				NameInput.Text = player.Name
				PlayerListFrame.Visible = false
				ListToggleBtn.Text = T("selectPlayer")
			end)
		end
	end

	ScrollFrame.CanvasSize = UDim2.new(
		0,
		0,
		0,
		ListLayout.AbsoluteContentSize.Y + 5
	)
end

ListToggleBtn.MouseButton1Click:Connect(function()
	PlayerListFrame.Visible = not PlayerListFrame.Visible

	if PlayerListFrame.Visible then
		ListToggleBtn.Text = T("closeList")
		updatePlayerList()
	else
		ListToggleBtn.Text = T("selectPlayer")
	end
end)

ManualRefreshBtn.MouseButton1Click:Connect(updatePlayerList)

local states = {
	Stick = false,
	Spin = false,
	Orbit = false,
	Float = false,
	AntiSit = false,
	Jitter = false
}

local angle = 0
local waveTime = 0
local lastJitter = 0

local buttonObjects = {}

local function getButtonName(key)
	if key == "Stick" then
		return T("stick")
	elseif key == "Spin" then
		return T("spin")
	elseif key == "Orbit" then
		return T("orbit")
	elseif key == "Float" then
		return T("float")
	elseif key == "AntiSit" then
		return T("antisit")
	elseif key == "Jitter" then
		return T("jitter")
	end

	return key
end

local function updateActionButtons()
	local onText = CurrentLanguage == "RU" and "ВКЛ" or "ON"
	local offText = CurrentLanguage == "RU" and "ВЫКЛ" or "OFF"

	for key, button in pairs(buttonObjects) do
		button.Text = getButtonName(key):upper() .. ": " .. (states[key] and onText or offText)
		button.BackgroundColor3 = states[key] and RED_COLOR or BG_ACCENT
	end
end

local function createButton(key)
	local btn = Instance.new("TextButton")
	btn.BackgroundColor3 = BG_ACCENT
	btn.TextColor3 = TEXT_COLOR
	btn.Text = getButtonName(key):upper() .. ": " .. (CurrentLanguage == "RU" and "ВЫКЛ" or "OFF")
	btn.Font = ACCENT_FONT
	btn.TextSize = 10
	btn.BorderSizePixel = 0
	btn.Parent = ButtonsContainer
	makeCorner(btn, 6)

	btn.MouseButton1Click:Connect(function()
		states[key] = not states[key]

		if key ~= "AntiSit" and states[key] then
			for otherKey in pairs(states) do
				if otherKey ~= key and otherKey ~= "AntiSit" then
					states[otherKey] = false
				end
			end
		end

		updateActionButtons()
	end)

	buttonObjects[key] = btn
end

createButton("Stick")
createButton("Spin")
createButton("Orbit")
createButton("Float")
createButton("AntiSit")
createButton("Jitter")

local MainToggleButton = Instance.new("TextButton")
MainToggleButton.Name = "MainToggleButton"
MainToggleButton.Size = UDim2.new(0, 110, 0, 38)
MainToggleButton.Position = UDim2.new(0.5, -340, 0.4, -19)
MainToggleButton.BackgroundColor3 = DARK_COLOR
MainToggleButton.TextColor3 = TEXT_COLOR
MainToggleButton.Text = T("mainMenu")
MainToggleButton.Font = ACCENT_FONT
MainToggleButton.TextSize = 14
MainToggleButton.BorderSizePixel = 0
MainToggleButton.Visible = false
MainToggleButton.Parent = ScreenGui
makeCorner(MainToggleButton, 8)

local MainToggleStroke = createRGBStroke(MainToggleButton, 2)

makeDraggable(MainToggleButton)

MainToggleButton.MouseButton1Click:Connect(function()
	MainFrame.Visible = not MainFrame.Visible

	if MainFrame.Visible then
		LanguageFrame.Visible = false
	else
		PlayerListFrame.Visible = false
	end
end)

GearButton.MouseButton1Click:Connect(function()
	LanguageFrame.Visible = not LanguageFrame.Visible
end)

local function updateLanguage()
	InitialTitle.Text = T("initialTitle")
	TelegramButton.Text = T("telegram")

	if InitialMenuButton and InitialMenuButton.Parent then
		InitialMenuButton.Text = T("mainMenu")
	end

	if MainToggleButton and MainToggleButton.Parent then
		MainToggleButton.Text = T("mainMenu")
	end

	SpeedLabel.Text = CurrentLanguage == "EN" and "Speed" or "Скорость"
	DistanceLabel.Text = CurrentLanguage == "EN" and "Distance" or "Дальность"

	NameInput.PlaceholderText = T("target")

	if PlayerListFrame.Visible then
		ListToggleBtn.Text = T("closeList")
	else
		ListToggleBtn.Text = T("selectPlayer")
	end

	ManualRefreshBtn.Text = T("refresh")

	LanguageTitle.Text = T("language")
	RussianButton.Text = T("russian")
	EnglishButton.Text = T("english")

	updateActionButtons()
end

RussianButton.MouseButton1Click:Connect(function()
	CurrentLanguage = "RU"
	LanguageFrame.Visible = false
	updateLanguage()
end)

EnglishButton.MouseButton1Click:Connect(function()
	CurrentLanguage = "EN"
	LanguageFrame.Visible = false
	updateLanguage()
end)

SpeedBox.FocusLost:Connect(function()
	local value = tonumber(SpeedBox.Text)

	if value then
		RotationSpeed = math.clamp(value, 0.1, 100)
	else
		SpeedBox.Text = tostring(RotationSpeed)
		return
	end

	SpeedBox.Text = tostring(RotationSpeed)
end)

DistanceBox.FocusLost:Connect(function()
	local value = tonumber(DistanceBox.Text)

	if value then
		RotationDistance = math.clamp(value, 0, 200)
	else
		DistanceBox.Text = tostring(RotationDistance)
		return
	end

	DistanceBox.Text = tostring(RotationDistance)
end)

TelegramButton.MouseButton1Click:Connect(function()
	local success = pcall(function()
		if setclipboard then
			setclipboard("https://t.me/Etraxon")
		elseif toclipboard then
			toclipboard("https://t.me/Etraxon")
		else
			error("Clipboard unavailable")
		end
	end)

	if success then
		TelegramButton.Text = T("copied")

		task.delay(1.5, function()
			if TelegramButton and TelegramButton.Parent then
				TelegramButton.Text = T("telegram")
			end
		end)
	end
end)

InitialClose.MouseButton1Click:Connect(function()
	if InitialMenuClosed then
		return
	end

	InitialMenuClosed = true

	InitialFrame:Destroy()
	InitialMenuButton:Destroy()

	MainFrame.Visible = true
	MainToggleButton.Visible = true
end)

RunService.Heartbeat:Connect(function(dt)
	local color = pulseColor()

	if MainFrame and MainFrame.Parent then
		MainStroke.Color = color
	end

	if MainToggle
