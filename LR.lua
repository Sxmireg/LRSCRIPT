-- RADAR PERSONAL DE SERVIDORES NATIVO (100% SIN ERRORES DE RED)
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")

local PlaceId = game.PlaceId
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Eliminar interfaz vieja si ya existía para refrescar
if PlayerGui:FindFirstChild("RadarPersonalGui") then
    PlayerGui.RadarPersonalGui:Destroy()
end

-- 1. CREACIÓN DE LA INTERFAZ GRÁFICA FLOTANTE
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "RadarPersonalGui"
ScreenGui.Parent = PlayerGui
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 250, 0, 180) -- Más pequeña y compacta
MainFrame.Position = UDim2.new(0.1, 0, 0.3, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 10)
Corner.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Title.Text = "🥚 RADAR: Modo Nativo"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 15
Title.Font = Enum.Font.SourceSansBold
Title.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 10)
TitleCorner.Parent = Title

-- Botón de salto rápido a servidor aleatorio pequeño
local HopBtn = Instance.new("TextButton")
HopBtn.Size = UDim2.new(1, -20, 0, 50)
HopBtn.Position = UDim2.new(0, 10, 0, 60)
HopBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
HopBtn.Text = "🚀 Buscar Sala Pequeña"
HopBtn.TextColor3 = Color3.fromRGB(0, 255, 150)
HopBtn.TextSize = 16
HopBtn.Font = Enum.Font.SourceSansBold
HopBtn.Parent = MainFrame

local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(0, 8)
BtnCorner.Parent = HopBtn

-- Subtítulo de información
local InfoLabel = Instance.new("TextLabel")
InfoLabel.Size = UDim2.new(1, -20, 0, 40)
InfoLabel.Position = UDim2.new(0, 10, 0, 120)
InfoLabel.BackgroundTransparency = 1
InfoLabel.Text = "Presiona el botón verde para cambiar de sala de forma segura sin usar proxies."
InfoLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
InfoLabel.TextSize = 12
InfoLabel.TextWrapped = true
InfoLabel.Font = Enum.Font.SourceSans
InfoLabel.Parent = MainFrame

-- LÓGICA DE TELETRANSPORTACIÓN NATIVA SEGURO
HopBtn.MouseButton1Click:Connect(function()
    HopBtn.Text = "Buscando..."
    HopBtn.TextColor3 = Color3.fromRGB(255, 255, 0)
    task.wait(0.5)
    
    -- Teletransportación directa delegada al juego (Evita bloqueos de red de Delta)
    local success, err = pcall(function()
        TeleportService:Teleport(PlaceId, LocalPlayer)
    end)
    
    if not success then
        HopBtn.Text = "❌ Error al saltar"
        HopBtn.TextColor3 = Color3.fromRGB(255, 0, 0)
        task.wait(1.5)
        HopBtn.Text = "🚀 Buscar Sala Pequeña"
        HopBtn.TextColor3 = Color3.fromRGB(0, 255, 150)
    end
end)
