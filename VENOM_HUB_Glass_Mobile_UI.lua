-- VENOM HUB | Interface visual Glass Neon para mobile
-- Somente interface: os botões não executam ações de jogo.
-- Coloque este LocalScript em StarterPlayerScripts para testar em um projeto Roblox próprio.

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local old = playerGui:FindFirstChild("VenomGlassUI")
if old then old:Destroy() end

local gui = Instance.new("ScreenGui")
gui.Name = "VenomGlassUI"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.DisplayOrder = 20
gui.Parent = playerGui

local function make(className, props, parent)
    local obj = Instance.new(className)
    for k, v in pairs(props) do obj[k] = v end
    obj.Parent = parent
    return obj
end

local blue = Color3.fromRGB(35, 155, 255)
local white = Color3.fromRGB(238, 246, 255)
local glass = Color3.fromRGB(10, 18, 32)

local panel = make("Frame", {
    Name = "MainPanel",
    AnchorPoint = Vector2.new(0, 0.5),
    Position = UDim2.new(0, 12, 0.5, 0),
    Size = UDim2.new(0, 285, 0, 430),
    BackgroundColor3 = glass,
    BackgroundTransparency = 0.2,
    BorderSizePixel = 0,
}, gui)
make("UICorner", {CornerRadius = UDim.new(0, 18)}, panel)
make("UIStroke", {Color = blue, Thickness = 1.5, Transparency = 0.12}, panel)
make("UIGradient", {
    Rotation = 35,
    Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(14, 32, 55)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(5, 9, 20))
    }),
    Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0.08),
        NumberSequenceKeypoint.new(1, 0.25)
    })
}, panel)

local title = make("TextLabel", {
    Name = "Title",
    Position = UDim2.new(0, 14, 0, 10),
    Size = UDim2.new(1, -56, 0, 48),
    BackgroundTransparency = 1,
    Text = "VENOM HUB",
    TextColor3 = white,
    TextStrokeColor3 = blue,
    TextStrokeTransparency = 0.55,
    Font = Enum.Font.GothamBlack,
    TextSize = 27,
    TextXAlignment = Enum.TextXAlignment.Left,
}, panel)

local close = make("TextButton", {
    Name = "CloseButton",
    AnchorPoint = Vector2.new(1, 0),
    Position = UDim2.new(1, -10, 0, 12),
    Size = UDim2.new(0, 30, 0, 28),
    BackgroundColor3 = Color3.fromRGB(20, 40, 62),
    BackgroundTransparency = 0.15,
    BorderSizePixel = 0,
    Text = "–",
    TextColor3 = white,
    Font = Enum.Font.GothamBold,
    TextSize = 22,
}, panel)
make("UICorner", {CornerRadius = UDim.new(0, 8)}, close)
make("UIStroke", {Color = blue, Transparency = 0.25, Thickness = 1}, close)

local tabs = make("Frame", {
    Name = "Tabs",
    Position = UDim2.new(0, 12, 0, 66),
    Size = UDim2.new(1, -24, 0, 62),
    BackgroundTransparency = 1,
}, panel)
make("UIGridLayout", {
    CellSize = UDim2.new(1/3, -5, 0, 28),
    CellPadding = UDim2.new(0, 6, 0, 6),
    SortOrder = Enum.SortOrder.LayoutOrder,
}, tabs)

local tabNames = {"⚡ SPEED", "⚔ COMBAT", "◉ VISUAL", "⚙ MISC", "♙ PLAYER", "☷ SETTINGS"}
local content = make("Frame", {
    Name = "Content",
    Position = UDim2.new(0, 12, 0, 140),
    Size = UDim2.new(1, -24, 1, -152),
    BackgroundTransparency = 1,
}, panel)

local pages = {}
local selectedTab = nil

local function createOption(parent, label, order, kind)
    local row = make("Frame", {
        Name = "Option" .. order,
        LayoutOrder = order,
        Size = UDim2.new(1, 0, 0, 42),
        BackgroundColor3 = Color3.fromRGB(9, 20, 35),
        BackgroundTransparency = 0.22,
        BorderSizePixel = 0,
    }, parent)
    make("UICorner", {CornerRadius = UDim.new(0, 10)}, row)
    make("UIStroke", {Color = blue, Thickness = 0.8, Transparency = 0.58}, row)
    make("TextLabel", {
        Position = UDim2.new(0, 10, 0, 0),
        Size = UDim2.new(1, -75, 1, 0),
        BackgroundTransparency = 1,
        Text = label,
        TextColor3 = white,
        Font = Enum.Font.GothamSemibold,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, row)
    if kind == "toggle" then
        local toggle = make("TextButton", {
            Name = "VisualToggle",
            AnchorPoint = Vector2.new(1, 0.5),
            Position = UDim2.new(1, -8, 0.5, 0),
            Size = UDim2.new(0, 42, 0, 22),
            BackgroundColor3 = Color3.fromRGB(45, 60, 80),
            BorderSizePixel = 0,
            Text = "",
            AutoButtonColor = true,
        }, row)
        make("UICorner", {CornerRadius = UDim.new(1, 0)}, toggle)
        local dot = make("Frame", {
            Name = "Dot",
            Position = UDim2.new(0, 3, 0, 3),
            Size = UDim2.new(0, 16, 0, 16),
            BackgroundColor3 = white,
            BorderSizePixel = 0,
        }, toggle)
        make("UICorner", {CornerRadius = UDim.new(1, 0)}, dot)
        local on = false
        toggle.Activated:Connect(function()
            on = not on
            TweenService:Create(toggle, TweenInfo.new(0.15), {
                BackgroundColor3 = on and blue or Color3.fromRGB(45, 60, 80)
            }):Play()
            TweenService:Create(dot, TweenInfo.new(0.15), {
                Position = on and UDim2.new(1, -19, 0, 3) or UDim2.new(0, 3, 0, 3)
            }):Play()
        end)
    else
        make("TextLabel", {
            AnchorPoint = Vector2.new(1, 0.5),
            Position = UDim2.new(1, -10, 0.5, 0),
            Size = UDim2.new(0, 54, 0, 25),
            BackgroundColor3 = Color3.fromRGB(13, 48, 82),
            BackgroundTransparency = 0.1,
            BorderSizePixel = 0,
            Text = "OPEN",
            TextColor3 = white,
            Font = Enum.Font.GothamBold,
            TextSize = 11,
        }, row)
    end
end

local pageOptions = {
    ["⚡ SPEED"] = {{"Movement speed", "toggle"}, {"Smooth movement", "toggle"}, {"Speed preset", "button"}},
    ["⚔ COMBAT"] = {{"Combat settings", "button"}, {"Training mode", "toggle"}, {"Input options", "button"}},
    ["◉ VISUAL"] = {{"Interface glow", "toggle"}, {"Glass transparency", "toggle"}, {"Show status", "toggle"}},
    ["⚙ MISC"] = {{"Interface effects", "toggle"}, {"Reset visual layout", "button"}, {"About this UI", "button"}},
    ["♙ PLAYER"] = {{"Player display", "button"}, {"Control layout", "button"}, {"Mobile layout", "toggle"}},
    ["☷ SETTINGS"] = {{"Blue neon theme", "toggle"}, {"Compact panel", "toggle"}, {"Close interface", "button"}},
}

for i, name in ipairs(tabNames) do
    local button = make("TextButton", {
        Name = "Tab" .. i,
        LayoutOrder = i,
        BackgroundColor3 = Color3.fromRGB(8, 18, 31),
        BackgroundTransparency = 0.12,
        BorderSizePixel = 0,
        Text = name,
        TextColor3 = white,
        Font = Enum.Font.GothamBold,
        TextSize = 10,
        AutoButtonColor = true,
    }, tabs)
    make("UICorner", {CornerRadius = UDim.new(0, 8)}, button)
    make("UIStroke", {Color = blue, Thickness = 0.8, Transparency = 0.48}, button)

    local page = make("ScrollingFrame", {
        Name = "Page" .. i,
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 3,
        ScrollBarImageColor3 = blue,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        Visible = false,
    }, content)
    make("UIListLayout", {
        Padding = UDim.new(0, 7),
        SortOrder = Enum.SortOrder.LayoutOrder,
    }, page)
    local layout = page:FindFirstChildOfClass("UIListLayout")
    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        page.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 4)
    end)

    for idx, option in ipairs(pageOptions[name]) do
        createOption(page, option[1], idx, option[2])
    end
    pages[name] = page

    button.Activated:Connect(function()
        selectedTab = name
        for tabName, tabPage in pairs(pages) do
            tabPage.Visible = tabName == name
        end
        for _, sibling in ipairs(tabs:GetChildren()) do
            if sibling:IsA("TextButton") then
                sibling.BackgroundColor3 = sibling == button and Color3.fromRGB(10, 93, 170) or Color3.fromRGB(8, 18, 31)
            end
        end
    end)
end

local function hidePanel()
    panel.Visible = not panel.Visible
end
close.Activated:Connect(hidePanel)

-- Começa na aba Speed; o botão flutuante reabre o painel após minimizar.
tabs:FindFirstChild("Tab1"):Activate()
local mini = make("TextButton", {
    Name = "ReopenButton",
    AnchorPoint = Vector2.new(0, 0.5),
    Position = UDim2.new(0, 12, 0.5, 0),
    Size = UDim2.new(0, 96, 0, 34),
    BackgroundColor3 = glass,
    BackgroundTransparency = 0.12,
    BorderSizePixel = 0,
    Text = "VENOM  ◈",
    TextColor3 = white,
    Font = Enum.Font.GothamBlack,
    TextSize = 14,
    Visible = false,
}, gui)
make("UICorner", {CornerRadius = UDim.new(1, 0)}, mini)
make("UIStroke", {Color = blue, Thickness = 1.2, Transparency = 0.1}, mini)
close.Activated:Connect(function()
    mini.Visible = not panel.Visible
end)
mini.Activated:Connect(function()
    panel.Visible = true
    mini.Visible = false
end)
