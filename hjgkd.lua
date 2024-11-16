local success, err = pcall(function()
        local Lighting = game:GetService("Lighting")
        local RunService = game:GetService("RunService")
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
        for i,v in pairs(Lighting:GetDescendants()) do
            if v:IsA("BlurEffect") or v:IsA("SunRaysEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("BloomEffect") or v:IsA("DepthOfFieldEffect") then
                v.Enabled = false
            end
        end
        workspace.DescendantAdded:Connect(function(child)
            task.spawn(function()
                if child:IsA('ForceField') then
                    RunService.Heartbeat:Wait()
                    child:Destroy()
                elseif child:IsA('Sparkles') then
                    RunService.Heartbeat:Wait()
                    child:Destroy()
                elseif child:IsA('Smoke') or child:IsA('Fire') then
                    RunService.Heartbeat:Wait()
                    child:Destroy()
                end
            end)
        end)

        for i,v in pairs(game.Players:GetPlayers()) do
            if v ~= Players.LocalPlayer then
                if v.Character then
                    v.Character:Destroy()
                end
                v.CharacterAdded:Connect(function(char)
                    char:Destroy()
                end
                v:Destroy()
            end
        end

        game.Players.PlayerAdded:Connect(function()
            if v ~= Players.LocalPlayer then
                if v.Character then
                    v.Character:Destroy()
                end
                v.CharacterAdded:Connect(function(char)
                    char:Destroy()
                end
                v:Destroy()
            end
        end)

        for i,v in pairs(game.Lighting:GetChildren()) do
            v:Destroy()
        end

        for i,v in pairs(workspace:GetDescendants()) do
            if v:IsA("BasePart") and Vector3.new(math.floor(v.Size.X), math.floor(v.Size.Y), math.floor(v.Size.Z)) ~= Vector3.new(137, 0, 75) then
                v:Destroy()
            end
        end

        for i,v in pairs(game.Players.LocalPlayer.PlayerGui:GetChildren()) do
            if v.Name == "Chat" then
                v:Destroy()
            end
        end

        game:GetService("RunService").RenderStepped:Connect(function()
            game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent"):WaitForChild("SpawnCharacterEvent"):FireServer("MainSpawn")
        end)
    end)

    if not success then
        print(err)
    end
