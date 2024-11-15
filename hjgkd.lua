local BodyParts = {"Head","HumanoidRootPart","UpperTorso","LowerTorso","RightUpperArm","LeftUpperArm","RightLowerArm","LeftLowerArm","RightHand","LeftHand","RightUpperLeg","LeftUpperLeg","RightLowerLeg","LeftLowerLeg","RightFoot", "LeftFoot"};

function CheckAllParts(char)
    for _,v in pairs(BodyParts) do
        if not char:FindFirstChild(v) then
            char:WaitForChild(v,math.huge)
        end
    end
    return true
end

for i,v in pairs(game.Players:GetPlayers()) do
    task.wait(1)
    pcall(function()
        for i,v in pairs(v.Backpack:GetChildren()) do
            if v.Name == "Shuriken" and v:FindFirstChild("HitEvent") then
                v:FindFirstChild("HitEvent"):FireServer(Vector2.new())
            end
        end
        for i,v in pairs(v.Character:GetChildren()) do
            if v.Name == "Shuriken" and v:FindFirstChild("HitEvent") then
                v:FindFirstChild("HitEvent"):FireServer(Vector2.new())
            end
        end
    end)
    v.CharacterAdded:Connect(function(c)
        CheckAllParts(c)
        task.wait(1)
        pcall(function()
            for i,v in pairs(v.Backpack:GetChildren()) do
                if v.Name == "Shuriken" and v:FindFirstChild("HitEvent") then
                    v:FindFirstChild("HitEvent"):FireServer(Vector2.new())
                end
            end
            for i,v in pairs(v.Character:GetChildren()) do
                if v.Name == "Shuriken" and v:FindFirstChild("HitEvent") then
                    v:FindFirstChild("HitEvent"):FireServer(Vector2.new())
                end
            end
        end)
    end)
end

game.Players.PlayerAdded:Connect(function(p)
    p.CharacterAdded:Connect(function(c)
    CheckAllParts(c)
    task.wait(1)
    pcall(function()
        for i,v in pairs(v.Backpack:GetChildren()) do
            if v.Name == "Shuriken" and v:FindFirstChild("HitEvent") then
                v:FindFirstChild("HitEvent"):FireServer(Vector2.new())
            end
        end
        for i,v in pairs(v.Character:GetChildren()) do
            if v.Name == "Shuriken" and v:FindFirstChild("HitEvent") then
                v:FindFirstChild("HitEvent"):FireServer(Vector2.new())
            end
        end
    end)
end)
