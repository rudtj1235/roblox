local playerService = game:GetService("Players")
local runService = game:GetService("RunService")
local characterData = {}
local folder = nil

local CreatePart = function(character)
	local data = characterData[character]
	local part = Instance.new("Part")
	part.Shape = Enum.PartType.Ball
	part.Anchored = true
	part.Size = Vector3.new(2, 2, 2)
	part.TopSurface = Enum.SurfaceType.Smooth
	part.BottomSurface = Enum.SurfaceType.Smooth
	part.Parent = workspace
	table.insert(data.parts, part)
end

local CreateFood = function()
	local food = game.ServerStorage.Apple:Clone()
	food.Position = Vector3.new(math.random(-50, 50),2,math.random(-50, 50))
	food.Parent = folder
end

local Heartbeat = function(deltaTime)
	for character, data in pairs(characterData) do
		if (character.PrimaryPart.Position - data.position).Magnitude < 10 then continue end
		local part = table.remove(data.parts, 1)
		if part == nil then continue end
		table.insert(data.parts, part)
		part.Position = data.position
		data.position = character.PrimaryPart.Position
	end
end

local CharacterAdd = function(character)
	local data = {}
	data.parts = {}
	data.position = character.PrimaryPart.Position
	characterData[character] = data
	local Touched = function(otherPart)
		if otherPart.Parent ~= folder then return end
		otherPart.Position = Vector3.new(math.random(-50, 50), 2, math.random(-50, 50))
		CreatePart(character)
	end
	character.PrimaryPart.Touched:Connect(Touched)
	end

local CharacterRemoving = function(character)
	local data = characterData[character]

	for i, part in ipairs(data.parts) do
		part:Destroy()
	end
	characterData[character] = nil
end

local PlayerAdded = function(player)
	player.CharacterAdded:Connect(CharacterAdd)
	player.CharacterRemoving:Connect(CharacterRemoving)
end

folder = Instance.new("Folder")
folder.Name = "Food"
folder.Parent = workspace
for i = 1, 20 do CreateFood() end

playerService.PlayerAdded:Connect(PlayerAdded)
runService.Heartbeat:Connect(Heartbeat)