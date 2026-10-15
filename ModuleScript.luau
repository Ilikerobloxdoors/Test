local Players = game:GetService("Players")
local ServerStorage = game:GetService("ServerStorage")
local Workspace = game:GetService("Workspace")

local CONFIG = {
	MIN_DELAY = 60,
	MAX_DELAY = 120,
	DAMAGE = 10,
	DAMAGE_INTERVAL = 0.5,
}

local modelTemplate = ServerStorage:WaitForChild("Nightmare Eyes")

local function getSpawnCFrame()
	local room = Workspace:FindFirstChild("CurrentRoom")
	if room and room:IsA("Model") then
		local part = room.PrimaryPart
			or room:FindFirstChildWhichIsA("BasePart", true)

		if part then
			return part.CFrame + part.CFrame.LookVector * 30
		end
	end

	local character = Players:GetPlayers()[1]
		and Players:GetPlayers()[1].Character

	local root = character
		and character:FindFirstChild("HumanoidRootPart")

	if root then
		return root.CFrame * CFrame.new(0, 0, -30)
	end

	return nil
end

while true do
	task.wait(math.random(CONFIG.MIN_DELAY, CONFIG.MAX_DELAY))

	local spawnCFrame = getSpawnCFrame()
	if not spawnCFrame then
		continue
	end

	if Workspace:FindFirstChild("Nightmare Eyes Active") then
		continue
	end

	local eyes = modelTemplate:Clone()
	eyes.Name = "Nightmare Eyes Active"
	eyes.Parent = Workspace

	if eyes:IsA("Model") then
		eyes:PivotTo(spawnCFrame)
	end

	print("Nightmare Eyes spawned!")
end