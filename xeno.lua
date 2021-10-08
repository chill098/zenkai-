wait(3) 
local function console_print(text,color)
    rconsoleprint(color)
    rconsoleprint(text)
end

local VIM = game:GetService('VirtualInputManager')
local RunService = game:GetService('RunService')

rconsoleclear()
console_print('*** Script maded by ','@@GREEN@@')
console_print('Kurumi#1234, but edited by the chill guy ','@@RED@@')
console_print('***\n','@@GREEN@@')
console_print('Waiting for spawn player...\n','@@YELLOW@@')

if game.PlaceId == 6797669494 then
    console_print('Join to any world.','@@RED@@')
    script.Disabled = true 
end

wait(3)
local Player = game.Players.LocalPlayer
local PlayerGui = Player.PlayerGui
local Player_Character = workspace:WaitForChild(Player.Name)
Player_Character:WaitForChild('Config')
repeat
    RunService.Heartbeat:Wait()
until not Player.PlayerGui:FindFirstChild('LoadingScreen')

local function discord_hook(text)
        if not _G.Webhook then return end
        syn.request(
        {
            Url = _G.Webhook,  -- This website helps debug HTTP requests
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"  -- When sending JSON, set this!
            },
            Body = game:GetService("HttpService"):JSONEncode({content = text})
        }
    )
    end

local Working = true
local lasttp_hits = 0
local total_hits = 0
local lasthit = 0

Player.CharacterRemoving:Connect(function()
    Working = false
end)

spawn(function() -- Bugs executor
    for _=1,12000 do    
        wait(.1)
        if not Working then
            break        
        end
        
        if Player_Character then
            if Player_Character:FindFirstChild('HumanoidRootPart') then
                Player_Character.Config.Flying.Value = true
                if Player_Character.HumanoidRootPart.CFrame.Y <= -250 then break end
            end
        end
    end
    
    Working = false
    
    wait(3)
    game:GetService('TeleportService'):Teleport(game.PlaceId, game.Players.LocalPlayer)
    discord_hook("End session with BP: "..Player_Character.Config.BattlePower.Value)
    console_print('Making new session...\n','@@LIGHT_GREEN@@')
    while RunService.Heartbeat:Wait() do
       if Player.Character then
            if Player.Character:FindFirstChild('HumanoidRootPart') then
                Player.Character.HumanoidRootPart.CFrame = CFrame.new(0,200,0)
            end
        end
    end
end)

console_print('Player spawned!\n','@@GREEN@@')
local function get_lf()
    local MainFrame = PlayerGui.MainFrame
    local LifeForce = tonumber(string.split(MainFrame.LongevityLabel.Text," ")[3])
    return LifeForce
end
for i,v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") then
            v.CanCollide = false
        end
end

console_print('Your BP now: ','@@MAGENTA@@')
console_print(Player.Character.Config.BattlePower.Value.."\n",'@@LIGHT_GRAY@@')
wait(1)
game.Players.LocalPlayer.Character.HumanoidRootPart.FlyingPosition.Position = Vector3.new(10000,50000,10000)
game.Players.LocalPlayer.Character.HumanoidRootPart.FlyingPosition.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
wait(5)
if get_lf() < 20 then
    Player_Character.Client.Events.Rest:FireServer()
    wait(3)
    if not Player_Character.Config.FullyStunned.Value then Player_Character.Client.Events.Rest:FireServer() end
    repeat
        wait()
    until Player_Character.Config.FullyStunned.Value
    Player_Character.HumanoidRootPart.Anchored = true
    console_print('Resting.....\n','@@YELLOW@@')
    discord_hook('Resting...')
    repeat
        wait()
    until get_lf() >= 100
    Working = false
end

if get_lf() >= 10 then
    Player_Character.Client.Events['Shadow Spar']:FireServer("SecretCode")
    workspace:WaitForChild(Player.Name.."'s Shadow Image"):WaitForChild('HumanoidRootPart')
    game.Players.LocalPlayer.Character.HumanoidRootPart.FlyingPosition.Position = workspace[Player.Name.."'s Shadow Image"].HumanoidRootPart.Position
    game.Players.LocalPlayer.Character.HumanoidRootPart.FlyingPosition.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
    console_print('Shadow clone spawned!\n','@@LIGHT_GREEN@@')
    console_print('Farming started\n','@@LIGHT_GREEN@@')
    for i,v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") then
            v.CanCollide = false
        end
    end
    local part = Instance.new('Part',workspace)
    part.Anchored = true
    part.Size = Vector3.new(1000,1000,1000)
    part.Position = Vector3.new(0,-500,0)
    spawn(function()
        while RunService.Heartbeat:Wait() and Working do
            if not Player_Character then break end
            if Player_Character:FindFirstChild('HumanoidRootPart') then
                part.Position = Vector3.new(Player_Character.HumanoidRootPart.CFrame.X,-500,Player_Character.HumanoidRootPart.CFrame.Z)
            end
        end
    end)
    
    Player_Character.Config.CurrentTarget.Value = workspace[Player.Name.."'s Shadow Image"]
    Player_Character.Config.LockedOn.Value = true
    
    discord_hook("Start session with BP: "..Player_Character.Config.BattlePower.Value)
    
    while Working do
            RunService.Heartbeat:Wait()
            if not workspace:FindFirstChild(Player.Name.."'s Shadow Image") then break end
            if not workspace[Player.Name.."'s Shadow Image"]:FindFirstChild('HumanoidRootPart') then break end
            if get_lf() < 10 then break end
            VIM:SendKeyEvent(true,Enum.KeyCode.W,false,game)
            if Player_Character.Config.Hits.Value > lasthit then
                total_hits = total_hits + (Player_Character.Config.Hits.Value - lasthit)
                lasthit = Player_Character.Config.Hits.Value
            end
            
            if total_hits >= 250 then
                console_print('Getting BP..\n','@@MAGENTA@@')
                Player_Character.Client.Events.StopBlocking:InvokeServer()
                VIM:SendKeyEvent(false,Enum.KeyCode.W,false,game)
                wait()
                VIM:SendKeyEvent(true,Enum.KeyCode.W,false,game)
                wait(5)
                
                total_hits = 0
                
                console_print('Your BP now: '..Player.Character.Config.BattlePower.Value..'\n','@@LIGHT_MAGENTA@@')
                discord_hook("BP updated: "..Player_Character.Config.BattlePower.Value)
            end
            if Player_Character.Config.Hits.Value == 0 then
                lasttp_hits = 0
                lasthit = 0
            end 
            Player_Character.Client.Events.Block:InvokeServer()
            Player_Character.Config.Stunned.Value = false
            Player_Character.Config.Attacking.Value = false
            Player_Character.Config.FullyStunned.Value = false
            Player_Character.Config.CAttackCooldown.Value = false
            Player_Character.Config.Blocking.Value = false
            Player_Character.Client.Events.LightAttack:FireServer("SecretCode")
            Player_Character.Client.Events['Zenkai Vanish']:FireServer("SecretCode")
    end
    
    Working = false
end
