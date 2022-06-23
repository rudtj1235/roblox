local folder = script.Parent

local TweenService = game:GetService("TweenService")

for _, platform in pairs(folder:GetChildren()) do
	if platform:IsA("BasePart") then
		local tweenInfo = TweenInfo.new(
			math.random(3,10),
			Enum.EasingStyle.Linear,
			Enum.EasingDirection.Out,
			-1,
			true,
			0
		)
		
		local tween = TweenService:Create(platform, tweenInfo, {Position = platform.Position + Vector3.new(0,10,0)})
		tween:Play()
	end
end