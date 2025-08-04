if game.CoreGui:FindFirstChild("SaturnScriptSelector") then game.CoreGui.SaturnScriptSelector:Destroy() end

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local ContentProvider = game:GetService("ContentProvider")
local plr = Players.LocalPlayer

local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "SaturnScriptSelector"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true

local main = Instance.new("Frame", gui)
main.Name = "MainFrame"
main.Size = UDim2.new(0, 500, 0, 360)
main.Position = UDim2.new(0.5, 0, 0.5, 0)
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
main.BorderColor3 = Color3.fromRGB(255, 255, 255)
main.BorderSizePixel = 1
main.Active = false
main.Draggable = false
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 4)

local UIStroke = Instance.new("UIStroke", main)
UIStroke.Color = Color3.fromRGB(255, 255, 255)
UIStroke.Thickness = 1.2
UIStroke.Transparency = 0.3

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0, 40)
title.Text = "Saturn Hub - (So Retro)"
title.TextColor3 = Color3.new(1,1,1)
title.TextSize = 26
title.Font = Enum.Font.Code

title.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
title.BorderSizePixel = 1

title.BackgroundTransparency = 0.85

local function notify(msg)
    local n = Instance.new("Frame", gui)
    n.Size = UDim2.new(0, 300, 0, 40)
    n.Position = UDim2.new(1, -310, 1, -60)
    n.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Instance.new("UICorner", n).CornerRadius = UDim.new(0, 6)

    local txt = Instance.new("TextLabel", n)
    txt.Text = msg
    txt.Size = UDim2.new(1, -10, 1, 0)
    txt.Position = UDim2.new(0, 5, 0, 0)
    txt.Font = Enum.Font.Code
    txt.TextSize = 15
    txt.TextColor3 = Color3.fromRGB(255,255,255)
    txt.BackgroundTransparency = 1
    txt.TextXAlignment = Enum.TextXAlignment.Left

    TweenService:Create(n, TweenInfo.new(0.3), {BackgroundTransparency = 0.1}):Play()
    TweenService:Create(txt, TweenInfo.new(0.3), {TextTransparency = 0}):Play()
    wait(3.5)
    TweenService:Create(n, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
    TweenService:Create(txt, TweenInfo.new(0.3), {TextTransparency = 1}):Play()
    wait(0.3)
    n:Destroy()
end

local scripts = {
    {
        TEXT_Thumbnail = "99 Nights In The Forest",
        GAME_ID = 79546208627805,
        SCRIPT = "https://raw.githubusercontent.com/JScripter-Lua/Saturn_Hub_Products/refs/heads/main/Saturn_99NitF.lua"
    },
    {
        TEXT_Thumbnail = "Catch and feed a brainrot",
        GAME_ID = 110931811137535,
        SCRIPT = "https://raw.githubusercontent.com/JScripter-Lua/Saturn_Hub_Products/refs/heads/main/Saturn_Loader.lua"
    },
    {
        TEXT_Thumbnail = "DIG (Discontinue)", -- Open Source
        GAME_ID = 126244816328678,
        SCRIPT = "https://raw.githubusercontent.com/JScripter-Lua/Saturn_Open_Source/refs/heads/main/Saturn_Hub_Discontinued(DIG).lua"
    },
    {
        TEXT_Thumbnail = "Catch and feed a brainrot",
        GAME_ID = 110931811137535,
        SCRIPT = "https://raw.githubusercontent.com/JScripter-Lua/Saturn_Hub_Products/refs/heads/main/Saturn_Loader.lua"
    },
    {
        TEXT_Thumbnail = "Doors",
        GAME_ID = 6516141723,
        SCRIPT = "https://raw.githubusercontent.com/JScripter-Lua/Saturn_Hub_Products/refs/heads/main/Saturn_Hub_Doors.lua"
    },
    {
        TEXT_Thumbnail = "Shrink Hide and Seek", -- Open Source
        GAME_ID = 137541498231955,
        SCRIPT = "https://raw.githubusercontent.com/JScripter-Lua/Saturn_Open_Source/refs/heads/main/Saturn_SnH.lua"
    }
}

local listScroll = Instance.new("ScrollingFrame", main)
listScroll.Size = UDim2.new(1, -20, 1, -100)
listScroll.Position = UDim2.new(0, 10, 0, 50)
listScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
listScroll.ScrollBarThickness = 4
listScroll.BackgroundColor3 = Color3.fromRGB(20,20,20)
listScroll.BorderColor3 = Color3.fromRGB(255,255,255)
listScroll.BorderSizePixel = 1

local UIList = Instance.new("UIListLayout", listScroll)
UIList.SortOrder = Enum.SortOrder.LayoutOrder
UIList.Padding = UDim.new(0, 4)

local selectedScript = nil

for _, data in pairs(scripts) do
    local entry = Instance.new("TextButton", listScroll)
    entry.Size = UDim2.new(1, 0, 0, 60)
    entry.Text = ""
    entry.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    entry.BorderSizePixel = 0
    Instance.new("UICorner", entry).CornerRadius = UDim.new(0, 4)

    local lbl = Instance.new("TextLabel", entry)
    lbl.Text = data.TEXT_Thumbnail
    lbl.Size = UDim2.new(1, -70, 1, 0)
    lbl.Position = UDim2.new(0, 70, 0, 0)
    lbl.Font = Enum.Font.Code
    lbl.TextSize = 15
    lbl.TextColor3 = Color3.new(1,1,1)
    lbl.BackgroundTransparency = 1
    lbl.TextXAlignment = Enum.TextXAlignment.Left

    local thumb = Instance.new("ImageLabel", entry)
    thumb.Size = UDim2.new(0, 60, 0, 60)
    thumb.Position = UDim2.new(0, 5, 0, 0)
    thumb.BackgroundTransparency = 1
    thumb.Image = "https://www.roblox.com/asset-thumbnail/image?assetId="..data.GAME_ID.."&width=420&height=420&format=png"

    entry.MouseButton1Click:Connect(function()
        for _, btn in ipairs(listScroll:GetChildren()) do
            if btn:IsA("TextButton") then
                btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            end
        end
        entry.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        selectedScript = data
        notify("Selected: "..data.TEXT_Thumbnail)
    end)
end

UIList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    listScroll.CanvasSize = UDim2.new(0, 0, 0, UIList.AbsoluteContentSize.Y + 10)
end)

local exec = Instance.new("TextButton", main)
exec.Text = "Execute"
exec.Size = UDim2.new(0, 100, 0, 36)
exec.Position = UDim2.new(1, -220, 1, -44)
exec.AnchorPoint = Vector2.new(0, 0)
exec.Font = Enum.Font.Code
exec.TextSize = 16
exec.TextColor3 = Color3.new(1,1,1)
exec.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
Instance.new("UICorner", exec).CornerRadius = UDim.new(0, 6)

local debounce = false
exec.MouseButton1Click:Connect(function()
    if debounce then return end
    debounce = true
    if selectedScript then
        notify("Executing: "..selectedScript.TEXT_Thumbnail)
        wait(1)
        pcall(function()
            loadstring(game:HttpGet(selectedScript.SCRIPT))()
        end)
        gui:Destroy()
    else
        notify("No script selected")
    end
    wait(1)
    debounce = false
end)

local destroy = exec:Clone()
destroy.Text = "Destroy"
destroy.Position = UDim2.new(1, -110, 1, -44)
destroy.Parent = main

destroy.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

main.Position = UDim2.new(0.5, 0, 1.2, 0)
TweenService:Create(main, TweenInfo.new(0.5, Enum.EasingStyle.Back), {
    Position = UDim2.new(0.5, 0, 0.5, 0)
}):Play()
