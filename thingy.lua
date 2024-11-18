local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local whitelist = {
	"WokeUpWithHostage3",
	"Siuanrehman"
}

local function isWhitelisted()
	for _, id in pairs(whitelist) do
		if type(id) == "string" and player.Name == id then
			return true
		elseif type(id) == "number" and player.UserId == id then
			return true
		end
	end
	return false
end

if not isWhitelisted() then
	return
end

local screenGui = Instance.new("ScreenGui")
screenGui.Parent = playerGui

local frame = Instance.new("Frame")
frame.Parent = screenGui
frame.Size = UDim2.new(0, 300, 0, 250)
frame.Position = UDim2.new(0.5, -150, 0.5, -125)
frame.BackgroundColor3 = Color3.fromRGB(240, 240, 240)

local instructionLabel = Instance.new("TextLabel")
instructionLabel.Parent = frame
instructionLabel.Size = UDim2.new(0, 250, 0, 50)
instructionLabel.Position = UDim2.new(0, 25, 0, 25)
instructionLabel.Text = "Type something below and click the button"
instructionLabel.TextSize = 16
instructionLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
instructionLabel.TextScaled = true

local inputBox = Instance.new("TextBox")
inputBox.Parent = frame
inputBox.Size = UDim2.new(0, 250, 0, 50)
inputBox.Position = UDim2.new(0, 25, 0, 75)
inputBox.TextSize = 18
inputBox.ClearTextOnFocus = true
inputBox.PlaceholderText = "Type here..."
inputBox.TextColor3 = Color3.fromRGB(0, 0, 0)

local sendButton = Instance.new("TextButton")
sendButton.Parent = frame
sendButton.Size = UDim2.new(0, 250, 0, 50)
sendButton.Position = UDim2.new(0, 25, 0, 150)
sendButton.Text = "Send Message"
sendButton.TextSize = 20
sendButton.TextColor3 = Color3.fromRGB(255, 255, 255)
sendButton.BackgroundColor3 = Color3.fromRGB(0, 128, 255)

local resultLabel = Instance.new("TextLabel")
resultLabel.Parent = frame
resultLabel.Size = UDim2.new(0, 250, 0, 50)
resultLabel.Position = UDim2.new(0, 25, 0, 210)
resultLabel.Text = ""
resultLabel.TextSize = 18
resultLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
resultLabel.TextScaled = true

sendButton.MouseButton1Click:Connect(function()
	local userInput = inputBox.Text
	if userInput ~= "" then
		game:GetService("Chat"):Chat(player.Character, userInput, Enum.ChatColor.Blue)
		resultLabel.Text = "You said: " .. userInput
	else
		resultLabel.Text = "Please enter something."
	end
end)

local UserInputService = game:GetService("UserInputService")
local toggleKey = Enum.KeyCode.V

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == toggleKey and not gameProcessed then
		screenGui.Enabled = not screenGui.Enabled
	end
end)

local dragging = false
local dragStart = nil
local startPos = nil

frame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = frame.Position
	end
end)

frame.InputChanged:Connect(function(input)
	if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		local delta = input.Position - dragStart
		frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)

frame.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = false
	end
end)

local mobileButtonGui = Instance.new("ScreenGui")
mobileButtonGui.Parent = playerGui

local mobileButton = Instance.new("TextButton")
mobileButton.Parent = mobileButtonGui
mobileButton.Size = UDim2.new(0, 100, 0, 50)
mobileButton.Position = UDim2.new(1, -120, 1, -120)
mobileButton.Text = "Toggle GUI"
mobileButton.TextSize = 20
mobileButton.TextColor3 = Color3.fromRGB(255, 255, 255)
mobileButton.BackgroundColor3 = Color3.fromRGB(0, 128, 255)

mobileButton.Visible = UserInputService.TouchEnabled

mobileButton.MouseButton1Click:Connect(function()
	screenGui.Enabled = not screenGui.Enabled
end)

local mobileButtonDragging = false
local mobileButtonDragStart = nil
local mobileButtonStartPos = nil

mobileButton.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		mobileButtonDragging = true
		mobileButtonDragStart = input.Position
		mobileButtonStartPos = mobileButton.Position
	end
end)

mobileButton.InputChanged:Connect(function(input)
	if mobileButtonDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		local delta = input.Position - mobileButtonDragStart
		mobileButton.Position = UDim2.new(mobileButtonStartPos.X.Scale, mobileButtonStartPos.X.Offset + delta.X, mobileButtonStartPos.Y.Scale, mobileButtonStartPos.Y.Offset + delta.Y)
	end
end)

mobileButton.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		mobileButtonDragging = false
	end
end)
