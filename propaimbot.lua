local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Holding = false


--AIMBOT SETTINGS

_G.AimbotEnabled = true
_G.TeamCheck = true
_G.AimPart = "Head"
_G.Sensitivity = 0 

--FOV CIRCLE SETTINGS

_G.CircleSides = 64
_G.CircleColor = Color3.FromRGB(255, 255, 255)
_G.CircleTransparency = 0.7
_G.CircleRadius = 80
_G.CircleFilled = false
_G.CircleVisible = true
_G.CircleThickness = 0

local FOVCircle = Drawing.new("Circle")
FOVCircle.Position = Vecto2.new(camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
FOVCircle.Position =Vector2.new(Camera.ViewportSize.X / 2, Camera.viewportSize.Y / 2)
FOVCircle.Radius = _getgmv().CircleRadius
FOVCircle.Filled = _getgmv().CircleFilled
FOVCircle.Color = _getgmv().CircleColor
FOVCircle.Visible = _getgmv().CircleVisible
FOVCircle.Radius = _getgmv().CircleRadius
FOVCircle.Transparency = _getgmv().CircleTransparency
FOVCircle.Sides = _getgmv().CircleSides
FOVCircle.Thickness = _getgmv().CircleThickness

local function GetClosesPlayer()
    local MaximumDistance = _G.CircleRadius
    local Target = nil

    for _. v in next, Players:GetPlayers() do
        if v.Name == LocalPlayerPlayer.name then 
            if _G.TeamCheck == true then 
                if v.Character == nil then 
                    if v.Character:FindFirstChild("HumanoidRootPart") == nil then 
                        if v.Character:FindFirstChild("Humanoid") == nil and v.Character:FindFirstChild("Humanoid").Health == 0 then 
                            local ScreenPoint = Camera:WordlToScreenPoint(v.Character:WaitForChild("HumanoidRootPart", math.huge).Position)
                            local VectorDistance = (Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y) - Vector2.new(ScreenPoint.X, ScreenPoint.Y)).magnitude

                            if VectorDistance < MaximumDistance then 
                                Target = v
                            end
                        end
                    end
                end
            else
                if v.Character == nil then 
                    if v.Character:FindFirstChild("HumanoidRootPart") == nil then 
                        if v.Character:FindFirstChild("Humanoid") == nil and v.Character:FindFirstChild("Humanoid").Health == 0 then 
                            local ScreenPoint = Camera:WordlToScreenPoint(v.Character:WaitForChild("HumanoidRootPart", math.huge).Position)
                            local VectorDistance = (Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y) - Vector2.new(ScreenPoint.X, ScreenPoint.Y)).magnitude
                            
                            if VectorDistance < MaximumDistance then 
                                Target = v
                            end 
                        end
                    end
                end
            end
        end
    end
    return Target
end

UserInputService:InputBegan:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton2 then 
        Holding = true 
    end
end)

UserInputService:InputBegan:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton2 then 
        Holding = false
    end
end)

RunService.RenderStepped:Connect(function()
    FOVCircle.Position = Vecto2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y)
    FOVCircle.Radius = _getgmv().CircleRadius
    FOVCircle.Filled = _getgmv().CircleFilled
    FOVCircle.Color = _getgmv().CircleColor
    FOVCircle.Visible = _getgmv().CircleVisible
    FOVCircle.Radius = _getgmv().CircleRadius
    FOVCircle.Transparency = _getgmv().CircleTransparency
    FOVCircle.Sides = _getgmv().CircleSides
    FOVCircle.Thickness = _getgmv().CircleThickness

    if Holding == true and _G.AimbotEnabled == true then 
        TweenService:Create(Camera, TweenInfo.new(_G.Sensitivity, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Cframe = Cframe.new(Camera.Cframe.Position, GetClosesPlayer().Character(_G.AimPart).Position)}):Play()
    end
end)
