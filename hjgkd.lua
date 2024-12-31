local firstTrial = {"SurfaceGui", "ImageLabel", "BodyVelocity", "TextLabel", "BillboardGui", "ScreenGui", "Frame", "Mesh", "SpecialMesh", "Sound", "Pants", "Shirt", "ParticleEmitter", "Trail", "Explosion", "Decal", "FaceControls", "WrapTarget", "Accessory", 'ForceField', 'Sparkles', 'Smoke', 'Fire'}
        local secondTrial = {"Tool","Player","Model","Part","UnionOperation","MeshPart","CornerWedgePart","TrussPart","BasePart"}
        local ancestors = {"CoreGui", "CorePackages", "ReplicatedStorage", "ReplicatedFirst", "StarterGui", "StarterPack", "StarterPlayer", "PlayerGui", "PlayerScripts", "Chat"}

        local function ServiceCheck(child)
            local success,err = pcall(function()
                if game:GetService(child.Name) then
                    return
                end
            end)
            if success then
                return true
            else
                return false
            end
        end

        local function AncestorCheck(child)
            for _,v in pairs(ancestors) do
                if child:FindFirstAncestor(v) then
                    return true
                end
            end
            return false
        end

        local RunService = game:GetService("RunService")
        local Players = game:GetService("Players")
        local Lighting = game:GetService("Lighting")
        local Terrain = workspace:FindFirstChildOfClass('Terrain')
        Terrain.WaterWaveSize = 0
        Terrain.WaterWaveSpeed = 0
        Terrain.WaterReflectance = 0
        Terrain.WaterTransparency = 0
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 9e9
        settings().Rendering.QualityLevel = 1
        for i,v in pairs(game:GetDescendants()) do
            if v:IsA("Part") or v:IsA("UnionOperation") or v:IsA("MeshPart") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
                v.Material = "Plastic"
                v.Reflectance = 0
            elseif v:IsA("Decal") then
                v.Transparency = 1
            elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
                v.Lifetime = NumberRange.new(0)
            elseif v:IsA("Explosion") then
                v.BlastPressure = 1
                v.BlastRadius = 1
            end
        end
        task.wait(0.5)
        for _,child in pairs(game:GetDescendants()) do
            if not AncestorCheck(child) and not ServiceCheck(child) then
                if table.find(firstTrial,child.ClassName) then
                    child:Destroy()
                elseif table.find(secondTrial,child.ClassName) then
                    if child.Name ~= Players.LocalPlayer.Name and not child:FindFirstAncestor(Players.LocalPlayer.Name) and Vector3.new(math.floor(child.Size.X), math.floor(child.Size.Y), math.floor(child.Size.Z)) ~= Vector3.new(137, 0, 75) then
                        if child:IsA("BasePart") and not Vector3.new(math.floor(child.Size.X), math.floor(child.Size.Y), math.floor(child.Size.Z)) ~= Vector3.new(137, 0, 75) then
                            child:Destroy()
                        end
                    end
                end
            end
        end
        for i,v in pairs(Lighting:GetDescendants()) do
            if v:IsA("BlurEffect") or v:IsA("SunRaysEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("BloomEffect") or v:IsA("DepthOfFieldEffect") then
                v.Enabled = false
                v:Destroy()
            end
        end
        game.DescendantAdded:Connect(function(child)
            task.spawn(function()
                pcall(function()
                    if not AncestorCheck(child) and not ServiceCheck(child) then
                        if table.find(firstTrial,child.ClassName) then
                            RunService.Heartbeat:Wait()
                            child:Destroy()
                        elseif table.find(secondTrial,child.ClassName) then
                            if child.Name ~= Players.LocalPlayer.Name and not child:FindFirstAncestor(Players.LocalPlayer.Name) then
                                if child:IsA("BasePart") and not Vector3.new(math.floor(child.Size.X), math.floor(child.Size.Y), math.floor(child.Size.Z)) ~= Vector3.new(137, 0, 75) then
                                    RunService.Heartbeat:Wait()
                                    child:Destroy()
                                end
                            end
                        end
                    end
                end)
            end)
        end)

        task.wait(0.5)

        for i,v in pairs(game.Players.LocalPlayer.PlayerGui:GetChildren()) do
            if v.Name == "Chat" then
                v:Destroy()
            end
        end

        game:GetService("RunService").RenderStepped:Connect(function()
            game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent"):WaitForChild("SpawnCharacterEvent"):FireServer("MainSpawn")
        end)
