-- RADAR PERSONAL DE SERVIDORES CON HUEVOS GRANDES (KEYLESS)
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")

local PlaceId = game.PlaceId
local LocalPlayer = Players.LocalPlayer

-- 1. CREACIÓN DE LA INTERFAZ GRÁFICA FLOTANTE
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "RadarPersonalGui"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

-- Contenedor Principal
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 250, 0, 300)
MainFrame.Position = UDim2.new(0.1, 0, 0.3, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true -- Puedes mover la tabla por toda la pantalla de tu celular
MainFrame.Parent = ScreenGui

-- Esquinas redondeadas
local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 10)
Corner.Parent = MainFrame

-- Título del Radar
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Title.Text = "🥚 RADAR: Huevos Grandes"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.Font = Enum.Font.SourceSansBold
Title.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 10)
TitleCorner.Parent = Title

-- Lista con sistema de desplazamiento (Scrolling)
local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Size = UDim2.new(1, -20, 1, -60)
ScrollFrame.Position = UDim2.new(0, 10, 0, 50)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollFrame.ScrollBarThickness = 4
ScrollFrame.Parent = MainFrame

-- Alineador automático de botones
local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = ScrollFrame
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 5)

-- 2. LÓGICA DE ESCANEO DE SERVIDORES IDEALES (CORREGIDO)
print("🔍 Buscando salas libres para huevos grandes...")
local url = string.format("https://roblox.com", PlaceId)

local success, result = pcall(function()
    return game:HttpGet(url)
end)

if success then
    local data = HttpService:JSONDecode(result)
    if data and data.data then
        local count = 0
        for _, server in pairs(data.data) do
            -- Filtramos salas con 1 a 5 jugadores donde hay menos competencia
            if server.playing >= 1 and server.playing <= 5 and server.id ~= game.JobId then
                count = count + 1
                
                -- Crear botón para este servidor
                local ServerBtn = Instance.new("TextButton")
                ServerBtn.Size = UDim2.new(1, -5, 0, 35)
                ServerBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                ServerBtn.Text = string.format("Sala #%d (%d/%d Jugadores)", count, server.playing, server.maxPlayers)
                ServerBtn.TextColor3 = Color3.fromRGB(0, 255, 150) -- Color verde indicando sala óptima
                ServerBtn.TextSize = 14
                ServerBtn.Font = Enum.Font.SourceSans
                ServerBtn.Parent = ScrollFrame
                
                local BtnCorner = Instance.new("UICorner")
                BtnCorner.CornerRadius = UDim.new(0, 5)
                BtnCorner.Parent = ServerBtn
                
                -- Ajustar el tamaño del scroll automáticamente
                ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y)
                
                -- Evento al presionar el botón de la tabla
                ServerBtn.MouseButton1Click:Connect(function()
                    ServerBtn.Text = "Teletransportando..."
                    ServerBtn.TextColor3 = Color3.fromRGB(255, 255, 0)
                    task.wait(0.5)
                    TeleportService:TeleportToPlaceInstance(PlaceId, server.id, LocalPlayer)
                end)
                
                -- Límite de la tabla para uso personal (muestra los mejores 8 servidores encontrados)
                if count >= 8 then
                    break
                end
            end
        end
        
        if count == 0 then
            Title.Text = "❌ No hay salas pequeñas"
        end
    end
else
    Title.Text = "❌ Error de Conexión API"
end
