local MaintenanceEnabled = false

if MaintenanceEnabled then
    local _pl=game:GetService("Players").LocalPlayer
    local _pg=_pl:WaitForChild("PlayerGui")
    local _li=game:GetService("Lighting")
    local _ts=game:GetService("TweenService")
    local _blur=Instance.new("BlurEffect"); _blur.Size=14; _blur.Parent=_li
    local _sg=Instance.new("ScreenGui"); _sg.Name="x7sMain"
    _sg.IgnoreGuiInset=true; _sg.ResetOnSpawn=false; _sg.Parent=_pg
    local _m=Instance.new("Frame"); _m.AnchorPoint=Vector2.new(0.5,0.5)
    _m.Position=UDim2.new(0.5,0,0.5,0); _m.Size=UDim2.new(0,520,0,300)
    _m.BackgroundColor3=Color3.fromRGB(8,6,12); _m.BackgroundTransparency=0.1
    _m.BorderSizePixel=0; _m.Parent=_sg
    Instance.new("UICorner",_m).CornerRadius=UDim.new(0,16)
    local _ms=Instance.new("UIStroke",_m)
    _ms.Color=Color3.fromRGB(141,122,174); _ms.Transparency=0.65; _ms.Thickness=1
    local _mg=Instance.new("UIGradient",_m)
    _mg.Color=ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(13,9,20)),ColorSequenceKeypoint.new(1,Color3.fromRGB(5,4,8))})
    _mg.Rotation=30
    local function _lbl(txt,sz,col,y,h)
        local l=Instance.new("TextLabel",_m); l.BackgroundTransparency=1
        l.Size=UDim2.new(1,-60,0,h or 36); l.Position=UDim2.new(0,30,0,y)
        l.Text=txt; l.TextColor3=col; l.Font=Enum.Font.GothamBold
        l.TextSize=sz; l.TextWrapped=true; l.TextXAlignment=Enum.TextXAlignment.Center
        return l
    end
    _lbl("✝  Sistema en Mantenimiento  ✝",22,Color3.fromRGB(141,122,174),40)
    local _div=Instance.new("Frame",_m); _div.Size=UDim2.new(1,-60,0,1)
    _div.Position=UDim2.new(0,30,0,90); _div.BackgroundColor3=Color3.fromRGB(141,122,174)
    _div.BackgroundTransparency=0.6; _div.BorderSizePixel=0
    _lbl("El sistema fue deshabilitado temporalmente.\nVolveremos cuando sea seguro utilizarlo.",15,Color3.fromRGB(180,165,205),104,60)
    local _sc=Instance.new("Frame",_m); _sc.Size=UDim2.new(1,-60,0,56)
    _sc.Position=UDim2.new(0,30,0,188); _sc.BackgroundColor3=Color3.fromRGB(18,14,26)
    _sc.BackgroundTransparency=0.1; _sc.BorderSizePixel=0
    Instance.new("UICorner",_sc).CornerRadius=UDim.new(0,12)
    local _dot=Instance.new("Frame",_sc); _dot.Size=UDim2.fromOffset(14,14)
    _dot.Position=UDim2.new(0,18,0.5,-7); _dot.BackgroundColor3=Color3.fromRGB(200,80,80)
    _dot.BorderSizePixel=0; Instance.new("UICorner",_dot).CornerRadius=UDim.new(1,0)
    local _sl=Instance.new("TextLabel",_sc); _sl.BackgroundTransparency=1
    _sl.Size=UDim2.new(1,-50,0,18); _sl.Position=UDim2.new(0,46,0,9)
    _sl.Text="ESTADO DEL SISTEMA"; _sl.TextColor3=Color3.fromRGB(90,80,110)
    _sl.Font=Enum.Font.GothamMedium; _sl.TextSize=11; _sl.TextXAlignment=Enum.TextXAlignment.Left
    local _sm=Instance.new("TextLabel",_sc); _sm.BackgroundTransparency=1
    _sm.Size=UDim2.new(1,-50,0,24); _sm.Position=UDim2.new(0,46,0,28)
    _sm.Text="OFFLINE"; _sm.TextColor3=Color3.fromRGB(200,80,80)
    _sm.Font=Enum.Font.GothamBold; _sm.TextSize=20; _sm.TextXAlignment=Enum.TextXAlignment.Left
    local _cb=Instance.new("TextButton",_m); _cb.Size=UDim2.fromOffset(30,30)
    _cb.Position=UDim2.new(1,-40,0,10); _cb.BackgroundColor3=Color3.fromRGB(30,22,42)
    _cb.BorderSizePixel=0; _cb.Text="x"; _cb.TextColor3=Color3.fromRGB(200,170,220)
    _cb.Font=Enum.Font.GothamBold; _cb.TextSize=13
    Instance.new("UICorner",_cb).CornerRadius=UDim.new(1,0)
    _cb.MouseButton1Click:Connect(function()
        _ts:Create(_m,TweenInfo.new(0.18,Enum.EasingStyle.Quad),{BackgroundTransparency=1,Size=UDim2.new(0,490,0,280)}):Play()
        for _,v in ipairs(_m:GetDescendants()) do
            if v:IsA("TextLabel") or v:IsA("TextButton") then _ts:Create(v,TweenInfo.new(0.15),{TextTransparency=1}):Play() end
        end
        task.wait(0.2); if _blur then _blur:Destroy() end; _sg:Destroy()
    end)
    return
end

local Players          = game:GetService("Players")
local TweenService     = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService       = game:GetService("RunService")
local Workspace        = game:GetService("Workspace")
local HttpService      = game:GetService("HttpService")

local player    = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local camera    = Workspace.CurrentCamera

local _hbxOriginals = {}  -- declarado aquí para que esté disponible en toda la GUI

local HAS_DRAWING = pcall(function() return Drawing.new end) and true or false



local CONFIG_FILE = "x7s_config.json"

local function mkDefault()
    return {
        esp_on=false, esp_names=false, esp_lines=false, esp_key="T",
        esp_char_r=100, esp_char_g=220, esp_char_b=100,  -- Color del Character ESP (verde por defecto)
        esp_avatar=true,   -- Mostrar thumbnail del avatar en el ESP
        esp_rainbow=false, -- Modo arcoíris RGB (cicla el color automáticamente)
        hbx_on=false, hbx_size=5, hbx_show=false, hbx_show2=false, hbx_key="G",
        hbx_vis_check=true,
        stream_mode=false,
        summer_on=false,
        panel_bg=true, notifs=true, lang="English", gui_key="L",
        -- ✨ WHITELIST (nuevo sistema)
        Whitelist={},
        -- === CAM LOCK ===
        CamLockEnabled = false,
        CamLockStrength = 30,
        CamLockRange = 150,
        CamLockWallCheck = true,
        camlock_key = "F",
        fov_on = false, fov_visible = true, fov_radius = 120,
        CamLockSafeZone = true,
        -- === TARGET ===
        TargetPart = "Random",
        -- === SILENT AIM (migrado de SyyClient) ===
        SilentAimEnabled = false,
        HitChance        = 100,
        Manipulation     = false,
        VisibleCheck     = true,












        -- === EXTRAS ===
        InfStamina   = false,
        EspHealthBar = false,
        EspDistance  = false,
        ItemInHand   = false,
    }
end
local S = mkDefault()
pcall(function()
    local d = HttpService:JSONDecode(readfile(CONFIG_FILE))
    for k,v in pairs(S) do if d[k]~=nil then S[k]=d[k] end end
end)
local function save() pcall(function() writefile(CONFIG_FILE,HttpService:JSONEncode(S)) end) end

-- ══════════════════════════════════════════════════════════════
-- WHITELIST SYSTEM (Migrado de SyyClient mejorado)
-- ══════════════════════════════════════════════════════════════

-- Set O(1) para búsqueda rápida sin iterar la lista entera
local wlSet = {}

local function rebuildWlSet()
    wlSet = {}
    for _, n in ipairs(S.Whitelist) do 
        if type(n) == "string" and n ~= "" then  -- Validación de tipo
            wlSet[n:lower()] = true 
        end
    end
end

-- Ejecutar al cargar la config
rebuildWlSet()

local function isWhitelisted(p)
    if not p or not p.Parent then return false end  -- Validación defensiva
    return wlSet[p.Name:lower()] == true
end

local function addWhitelist(name)
    if name == "" then return false end
    local nl = name:lower()
    if wlSet[nl] then return false end
    table.insert(S.Whitelist, name)
    wlSet[nl] = true
    save()
    return true
end

local function removeWhitelist(name)
    local nl = name:lower()
    if not wlSet[nl] then return false end
    for i, n in ipairs(S.Whitelist) do
        if n:lower() == nl then 
            table.remove(S.Whitelist, i)
            break 
        end
    end
    wlSet[nl] = nil
    save()
    return true
end

-- Función auxiliar para saltarse en loops
local function shouldSkipPlayer(p)
    if not p or not p.Parent then return true end  -- Validación
    if p == player then return true end            -- Tu personaje
    if isWhitelisted(p) then return true end       -- En whitelist
    return false
end

local Locale = {
    English = {
        tab_esp="ESP", tab_hbx="HBX", tab_trg="TRG", tab_cfg="CFG",

        esp_on="Enable ESP",        esp_on_d="Show enemies through walls.",
        esp_names="Show Enemy Name",
        esp_lines="ESP Lines",      esp_lines_d="Draw lines from your character to enemy positions.",
        esp_key="ESP Keybind",
        esp_color="ESP Color",      esp_color_d="Customize the character highlight color.",
        esp_avatar="Show Avatar",   esp_avatar_d="Show player avatar thumbnail above ESP.",
        esp_rainbow="Rainbow Aura", esp_rainbow_d="Cycle through all colors automatically.",

        hbx_on="Enable Hitbox",     hbx_on_d="Show and expand enemy hitboxes.",
        hbx_size="Hitbox Size",
        hbx_show="Show Hitbox",
        hbx_show2="Show Hitbox (Always)",  hbx_show2_d="Shows the hitbox box at the selected size regardless of whether the player is hidden.",
        hbx_key="Hitbox Keybind",
        hbx_vis="Visible Check",    hbx_vis_d="Only register hits when the enemy is actually visible. Prevents kills through walls.",

        camlock_on="Enable Cam Lock",      camlock_on_d="Automatically locks camera on the closest enemy.",
        camlock_key="Cam Lock Keybind",

        fov_on="Enable FOV Circle",    fov_on_d="Only lock enemies inside the FOV circle.",
        fov_visible="Show FOV Circle",  fov_visible_d="Draw the FOV circle on screen.",
        fov_radius="FOV Radius",        fov_radius_d="Size of the FOV circle in pixels.",

        camlock_strength="Cam Lock Strength", camlock_strength_d="How smoothly the camera follows (1-100).",
        camlock_range="Cam Lock Range",     camlock_range_d="Maximum distance to target (50-500).",
        camlock_wallcheck="Wall Check",     camlock_wallcheck_d="Only lock on visible enemies.",
        camlock_safezone="Safe Zone",       camlock_safezone_d="Don't lock on players inside a safe zone.",

        whitelist_title="Whitelist Manager", whitelist_add="Add Player", whitelist_remove="Remove",

        target_part="Target Part",
        extras_title="Extras",
        ext_inf_stamina="Inf Stamina",       ext_inf_stamina_d="Keeps your stamina always full.",
        ext_health_bar="Health Bar",          ext_health_bar_d="Draws a health bar next to each enemy.",
        ext_distance="Distance",              ext_distance_d="Shows the distance to each enemy in meters.",
        ext_item_hand="Item in Hand",         ext_item_hand_d="Shows what item the enemy is holding.",

        summer_on="Summer 2026",    summer_on_d="Collects Summer 2026 drops automatically. Only in matches.",

        st_bg="Toggle Panel Background",
        st_notif="Enable Notifications",
        st_lang="Language",
        st_key="Toggle UI",
        st_stream="Stream Mode",       st_stream_d="Hides GUI and disables all ESP visuals. Hotkey: RightAlt.",
        st_r1="Reset Toggle UI Keybind",  st_r1_d="Reset this keybind to its default value.",
        st_r2="Reset All Keybinds",       st_r2_d="Reset all keybinds to their default values.",


        silent_on="Silent Aim",      silent_on_d="Redirects your shots to the closest enemy automatically.",
        silent_vis="Visible Check",   silent_vis_d="Only target enemies that are actually visible (no wallbang).",
        silent_man="Manipulation",    silent_man_d="Forces raycasts to ignore walls so hits register through them.",
        silent_hc="Hit Chance %",     silent_hc_d="Percentage of shots that get redirected to the target.",

        n_on="Enabled", n_off="Disabled", n_reset="Keybind reset",
    },
    ["Español"] = {
        tab_esp="ESP", tab_hbx="HBX", tab_trg="TRG", tab_cfg="CFG",
        esp_on="Activar ESP",        esp_on_d="Muestra enemigos a través de paredes.",
        esp_names="Nombre del Enemigo",
        esp_lines="Líneas ESP",      esp_lines_d="Dibuja líneas desde tu personaje hasta los enemigos.",
        esp_key="Tecla ESP",
        esp_color="Color ESP",       esp_color_d="Personaliza el color del resaltado del personaje.",
        esp_avatar="Mostrar Avatar", esp_avatar_d="Muestra el avatar del jugador sobre el ESP.",
        esp_rainbow="Aura Arcoíris", esp_rainbow_d="Cicla automáticamente por todos los colores.",
        hbx_on="Activar Hitbox",    hbx_on_d="Muestra y expande las hitboxes enemigas.",
        hbx_size="Tamaño Hitbox",
        hbx_show="Mostrar Hitbox",
        hbx_show2="Mostrar Hitbox (Siempre)",  hbx_show2_d="Muestra la caja de hitbox al tamaño seleccionado sin importar si el jugador está oculto.",
        hbx_key="Tecla Hitbox",
        hbx_vis="Visible Check",    hbx_vis_d="Solo registra el hit si el enemigo está a la vista. Evita matar a través de paredes.",
        camlock_on="Activar Cam Lock",      camlock_on_d="Bloquea automáticamente la cámara en el enemigo más cercano.",
        camlock_key="Tecla Cam Lock",

        fov_on="Activar Círculo FOV",   fov_on_d="Solo bloquea enemigos dentro del círculo FOV.",
        fov_visible="Mostrar Círculo",   fov_visible_d="Dibuja el círculo FOV en pantalla.",
        fov_radius="Radio FOV",          fov_radius_d="Tamaño del círculo FOV en píxeles.",

        camlock_strength="Fuerza Cam Lock", camlock_strength_d="Qué tan suavemente sigue la cámara (1-100).",
        camlock_range="Rango Cam Lock",     camlock_range_d="Distancia máxima al objetivo (50-500).",
        camlock_wallcheck="Wall Check",     camlock_wallcheck_d="Solo bloquea enemigos visibles.",
        camlock_safezone="Safe Zone",       camlock_safezone_d="No bloquea a jugadores dentro de una zona segura.",

        whitelist_title="Gestor de Whitelist", whitelist_add="Añadir Jugador", whitelist_remove="Eliminar",
        target_part="Parte Objetivo",
        extras_title="Extras",
        ext_inf_stamina="Inf Stamina",       ext_inf_stamina_d="Mantiene tu stamina siempre llena.",
        ext_health_bar="Barra de Salud",      ext_health_bar_d="Dibuja una barra de vida junto a cada enemigo.",
        ext_distance="Distancia",             ext_distance_d="Muestra la distancia a cada enemigo en metros.",
        ext_item_hand="Ítem en la Mano",      ext_item_hand_d="Muestra qué ítem sostiene el enemigo.",
        summer_on="Summer 2026",     summer_on_d="Recolecta los drops del Summer 2026 automáticamente. Solo en partidas.",
        st_bg="Fondo del Panel",
        st_notif="Activar Notificaciones",
        st_lang="Idioma",
        st_key="Alternar UI",
        st_stream="Stream Mode",       st_stream_d="Oculta la GUI y desactiva el ESP visual. Tecla: RightAlt.",
        st_r1="Restablecer Tecla UI",     st_r1_d="Restablece esta tecla a su valor predeterminado.",
        st_r2="Restablecer Todas",        st_r2_d="Restablece todas las teclas a sus valores predeterminados.",

        silent_on="Silent Aim",      silent_on_d="Redirige tus disparos al enemigo más cercano automáticamente.",
        silent_vis="Visible Check",   silent_vis_d="Solo apunta a enemigos que estén realmente a la vista (sin paredes).",
        silent_man="Manipulation",    silent_man_d="Fuerza los raycasts a ignorar paredes para que el hit registre.",
        silent_hc="Hit Chance %",     silent_hc_d="Porcentaje de disparos que se redirigen al objetivo.",

        n_on="Activado", n_off="Desactivado", n_reset="Tecla restablecida",
    }
}
local function L(k)
    local tbl = Locale[S.lang] or Locale.English
    return tbl[k] or (Locale.English[k] or k)
end

local C = {
    BG      = Color3.fromRGB(5,   5,   7),
    CARD    = Color3.fromRGB(14,  12,  20),
    HEADER  = Color3.fromRGB(8,   6,   13),
    TABBAR  = Color3.fromRGB(6,   5,   9),
    TEXT    = Color3.fromRGB(212, 202, 228),
    DIM     = Color3.fromRGB(102, 92,  120),
    ACCENT  = Color3.fromRGB(141, 122, 174),
    ACCENT2 = Color3.fromRGB(170, 148, 210),
    DIV     = Color3.fromRGB(28,  24,  40),
    TOG_ON  = Color3.fromRGB(141, 122, 174),
    TOG_OFF = Color3.fromRGB(38,  32,  54),
    THUMB   = Color3.fromRGB(228, 220, 240),
    KEY_BG  = Color3.fromRGB(22,  18,  32),
    KEY_TXT = Color3.fromRGB(141, 122, 174),
    BORDER  = Color3.fromRGB(58,  50,  80),
    RED     = Color3.fromRGB(180, 60,  70),
    GREEN   = Color3.fromRGB(90,  180, 100),
}
local TI  = TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local TIF = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

local oldGui = playerGui:FindFirstChild("x7sV1")
if oldGui then oldGui:Destroy() end
pcall(function()
    local cg = game:GetService("CoreGui"):FindFirstChild("x7sV1")
    if cg then cg:Destroy() end
end)

local gui = Instance.new("ScreenGui")
gui.Name = "x7sV1"; gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true; gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.DisplayOrder = 99
local _protected = false
pcall(function() if syn and syn.protect_gui then syn.protect_gui(gui) end end)
pcall(function() gui.Parent = game:GetService("CoreGui"); _protected = true end)
if not _protected then pcall(function() gui.Parent = gethui(); _protected = true end) end
if not _protected then gui.Parent = playerGui end

local _notifQueue = {}
local _notifActive = false

local function showNotif(title, body, isGood)
    if not S.notifs then return end
    table.insert(_notifQueue, {title=title, body=body, good=isGood})
    if _notifActive then return end
    _notifActive = true
    task.spawn(function()
        while #_notifQueue > 0 do
            local n = table.remove(_notifQueue, 1)
            local col = n.good and C.ACCENT or C.DIM
            local toast = Instance.new("Frame", gui)
            toast.Size = UDim2.fromOffset(240, 58)
            toast.Position = UDim2.new(1, 260, 1, -80)
            toast.BackgroundColor3 = Color3.fromRGB(12, 10, 18)
            toast.BorderSizePixel = 0; toast.ZIndex = 200
            Instance.new("UICorner", toast).CornerRadius = UDim.new(0, 10)
            local ts = Instance.new("UIStroke", toast); ts.Color = col; ts.Transparency = 0.5; ts.Thickness = 1
            local bar = Instance.new("Frame", toast); bar.Size = UDim2.new(0, 3, 1, -16)
            bar.Position = UDim2.new(0, 0, 0, 8); bar.BackgroundColor3 = col
            bar.BorderSizePixel = 0; Instance.new("UICorner", bar).CornerRadius = UDim.new(1, 0)
            local tl = Instance.new("TextLabel", toast); tl.BackgroundTransparency = 1
            tl.Size = UDim2.new(1, -20, 0, 20); tl.Position = UDim2.fromOffset(14, 8)
            tl.Text = n.title; tl.TextColor3 = col; tl.Font = Enum.Font.GothamBold
            tl.TextSize = 12; tl.TextXAlignment = Enum.TextXAlignment.Left
            local bl = Instance.new("TextLabel", toast); bl.BackgroundTransparency = 1
            bl.Size = UDim2.new(1, -20, 0, 18); bl.Position = UDim2.fromOffset(14, 28)
            bl.Text = n.body; bl.TextColor3 = C.DIM; bl.Font = Enum.Font.Gotham
            bl.TextSize = 11; bl.TextXAlignment = Enum.TextXAlignment.Left
            TweenService:Create(toast, TIF, {Position = UDim2.new(1, -250, 1, -80)}):Play()
            task.wait(2.5)
            TweenService:Create(toast, TIF, {Position = UDim2.new(1, 260, 1, -80)}):Play()
            task.wait(0.3); toast:Destroy()
            task.wait(0.1)
        end
        _notifActive = false
    end)
end

-- ══════════════════════════════════════════════
--  STREAM MODE (igual que SyyPC)
--  Guarda estado de ESP/avatar/nombres/líneas y oculta todo
--  NOTA: panel, glow, espObjects se leen en tiempo de ejecución (definidos más abajo)
-- ══════════════════════════════════════════════
local streamModeOn = false
local streamSaved = {esp_on=nil, esp_avatar=nil, esp_names=nil, esp_lines=nil}
-- La función se asigna más abajo tras definir panel/glow/espObjects
local applyStreamMode  -- forward declaration
local applyHitbox      -- forward declaration


local GW, GH = 660, 520          -- ancho total, alto total
local SB_W   = 160                -- ancho sidebar
local HDR_H  = 34                 -- altura header
local FOOTER_H = 32

-- Accent color global (aplicado por toda la GUI)
local accentColor = C.ACCENT

-- Panel principal
local glow = Instance.new("Frame", gui)
glow.Size = UDim2.fromOffset(GW + 20, GH + 20)
glow.Position = UDim2.new(0.5, -(GW/2 + 10), 0.5, -(GH/2 + 10))
glow.BackgroundColor3 = accentColor; glow.BackgroundTransparency = 0.93
glow.BorderSizePixel = 0; glow.ZIndex = 1
Instance.new("UICorner", glow).CornerRadius = UDim.new(0, 4)

local panel = Instance.new("Frame", gui)
panel.Name = "x7sPanel"
panel.Size = UDim2.fromOffset(GW, GH)
panel.Position = UDim2.new(0.5, -GW/2, 0.5, -GH/2)
panel.BackgroundColor3 = Color3.fromRGB(8, 6, 8)
panel.BorderSizePixel = 0; panel.ClipsDescendants = true; panel.ZIndex = 2
local panelStroke = Instance.new("UIStroke", panel)
panelStroke.Color = Color3.fromRGB(58, 58, 58); panelStroke.Transparency = 0; panelStroke.Thickness = 1

-- == MOBILE ADAPTATION ===========================================
local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
local panelScale = Instance.new("UIScale", panel)
local glowScale  = Instance.new("UIScale", glow)
if isMobile then
    -- Centrar por ancla para que el UIScale escale desde el centro
    panel.AnchorPoint = Vector2.new(0.5, 0.5)
    panel.Position    = UDim2.fromScale(0.5, 0.5)
    glow.AnchorPoint  = Vector2.new(0.5, 0.5)
    glow.Position     = UDim2.fromScale(0.5, 0.5)
    local function fitScale()
        local vp = camera.ViewportSize
        local s  = math.clamp(math.min(vp.X * 0.95 / GW, vp.Y * 0.92 / GH), 0.4, 1)
        panelScale.Scale = s
        glowScale.Scale  = s
    end
    fitScale()
    camera:GetPropertyChangedSignal("ViewportSize"):Connect(fitScale)
end

local scanlines = Instance.new("Frame", panel)
scanlines.Name = "Scanlines"
scanlines.Size = UDim2.new(1, 0, 1, 0)
scanlines.BackgroundTransparency = 1
scanlines.BorderSizePixel = 0
scanlines.ZIndex = 80
scanlines.Active = false
for i = 0, math.floor(GH / 4) do
    local line = Instance.new("Frame", scanlines)
    line.Size = UDim2.new(1, 0, 0, 1)
    line.Position = UDim2.fromOffset(0, i * 4)
    line.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    line.BackgroundTransparency = 0.88
    line.BorderSizePixel = 0
end

local particleLayer = Instance.new("Frame", panel)
particleLayer.Name = "AmbientParticles"
particleLayer.Size = UDim2.new(1, 0, 1, 0)
particleLayer.BackgroundTransparency = 1
particleLayer.BorderSizePixel = 0
particleLayer.Active = false
particleLayer.ZIndex = 3
for i = 1, 14 do
    local dot = Instance.new("Frame", particleLayer)
    local sz = math.random(1, 3)
    dot.Size = UDim2.fromOffset(sz, sz)
    dot.Position = UDim2.fromOffset(math.random(18, GW - 18), math.random(42, GH - 24))
    dot.BackgroundColor3 = accentColor
    dot.BackgroundTransparency = 1
    dot.BorderSizePixel = 0
    dot.ZIndex = 3
    Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)
    task.spawn(function()
        task.wait(math.random() * 2)
        while dot.Parent do
            local startX = math.random(18, GW - 18)
            local startY = math.random(52, GH - 24)
            dot.Position = UDim2.fromOffset(startX, startY)
            dot.BackgroundTransparency = 1
            TweenService:Create(dot, TweenInfo.new(1.1, Enum.EasingStyle.Sine), {
                BackgroundTransparency = 0.42,
            }):Play()
            TweenService:Create(dot, TweenInfo.new(3.2 + math.random(), Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                Position = UDim2.fromOffset(startX + math.random(-16, 16), math.max(40, startY - math.random(24, 58))),
            }):Play()
            task.wait(1.4)
            TweenService:Create(dot, TweenInfo.new(1.1, Enum.EasingStyle.Sine), {
                BackgroundTransparency = 1,
            }):Play()
            task.wait(2.2 + math.random())
        end
    end)
end

TweenService:Create(glow, TweenInfo.new(6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
    BackgroundTransparency = 0.88,
}):Play()
panel.Size = UDim2.fromOffset(GW - 34, GH - 34)
panel.BackgroundTransparency = 1
TweenService:Create(panel, TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Size = UDim2.fromOffset(GW, GH),
    BackgroundTransparency = 0,
}):Play()

-- ── HEADER ─────────────────────────────────────
local header = Instance.new("Frame", panel)
header.Name = "Header"
header.Size = UDim2.new(1, 0, 0, HDR_H)
header.BackgroundColor3 = Color3.fromRGB(4, 3, 4)
header.BorderSizePixel = 0; header.ZIndex = 10
local headerGrad = Instance.new("UIGradient", header)
headerGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(4,3,4)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(13,10,13)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(4,3,4)),
})
local headerBorder = Instance.new("Frame", header)
headerBorder.Size = UDim2.new(1, 0, 0, 1); headerBorder.Position = UDim2.new(0,0,1,-1)
headerBorder.BackgroundColor3 = Color3.fromRGB(42,42,42); headerBorder.BorderSizePixel = 0

-- Título header
local titleLbl = Instance.new("TextLabel", header)
titleLbl.Size = UDim2.new(0.5, 0, 1, 0); titleLbl.Position = UDim2.fromOffset(16, 0)
titleLbl.BackgroundTransparency = 1; titleLbl.Text = "† interfaz oscura v.XIII †"
titleLbl.TextColor3 = Color3.fromRGB(58, 58, 58); titleLbl.Font = Enum.Font.GothamBold
titleLbl.TextSize = 9; titleLbl.TextXAlignment = Enum.TextXAlignment.Left
titleLbl.TextScaled = false

-- Deco: fecha + símbolos
local dateDeco = Instance.new("TextLabel", header)
dateDeco.Size = UDim2.new(0, 180, 1, 0); dateDeco.Position = UDim2.new(1, -220, 0, 0)
dateDeco.BackgroundTransparency = 1
dateDeco.Text = "♥ ★ ✦  "..os.date("%d/%m/%Y")
dateDeco.TextColor3 = Color3.fromRGB(42, 42, 42); dateDeco.Font = Enum.Font.GothamBold
dateDeco.TextSize = 8; dateDeco.TextXAlignment = Enum.TextXAlignment.Right

-- Label tecla toggle GUI (se actualiza tras definir refreshers, abajo)
local guiKeyLbl = Instance.new("TextLabel", header)
guiKeyLbl.Size = UDim2.new(0, 90, 1, 0); guiKeyLbl.Position = UDim2.new(0, 200, 0, 0)
guiKeyLbl.BackgroundTransparency = 1
guiKeyLbl.TextColor3 = Color3.fromRGB(55, 50, 70); guiKeyLbl.Font = Enum.Font.GothamBold
guiKeyLbl.TextSize = 8; guiKeyLbl.TextXAlignment = Enum.TextXAlignment.Left

-- Close button
local closeBtn = Instance.new("TextButton", header)
closeBtn.Size = UDim2.fromOffset(22, 22); closeBtn.Position = UDim2.new(1, -30, 0.5, -11)
closeBtn.BackgroundColor3 = Color3.fromRGB(26, 10, 26)
closeBtn.BorderSizePixel = 0; closeBtn.Text = "x"
closeBtn.TextColor3 = Color3.fromRGB(102, 102, 102)
closeBtn.Font = Enum.Font.GothamBold; closeBtn.TextSize = 11; closeBtn.AutoButtonColor = false
local closeStroke = Instance.new("UIStroke", closeBtn)
closeStroke.Color = Color3.fromRGB(58,58,58); closeStroke.Thickness = 1
closeBtn.MouseEnter:Connect(function() closeBtn.TextColor3 = accentColor; closeStroke.Color = accentColor end)
closeBtn.MouseLeave:Connect(function() closeBtn.TextColor3 = Color3.fromRGB(102,102,102); closeStroke.Color = Color3.fromRGB(58,58,58) end)
closeBtn.MouseButton1Click:Connect(function()
    TweenService:Create(panel, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {BackgroundTransparency=1, Size=UDim2.fromOffset(GW-20,GH-20)}):Play()
    TweenService:Create(glow, TweenInfo.new(0.15), {BackgroundTransparency=1}):Play()
    task.delay(0.16, function() panel.Visible=false; glow.Visible=false; panel.BackgroundTransparency=0; panel.Size=UDim2.fromOffset(GW,GH) end)
end)

-- ── BODY (sidebar + content) ───────────────────
local body = Instance.new("Frame", panel)
body.Size = UDim2.new(1, 0, 1, -(HDR_H + FOOTER_H))
body.Position = UDim2.fromOffset(0, HDR_H)
body.BackgroundTransparency = 1; body.BorderSizePixel = 0

-- ── SIDEBAR ────────────────────────────────────
local sidebar = Instance.new("Frame", body)
sidebar.Size = UDim2.new(0, SB_W, 1, 0)
sidebar.BackgroundColor3 = Color3.fromRGB(4, 3, 4)
sidebar.BorderSizePixel = 0; sidebar.ClipsDescendants = true
local sbGrad = Instance.new("UIGradient", sidebar)
sbGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(4,3,4)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(8,5,8)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(4,3,4)),
})
sbGrad.Rotation = 90
local sbBorder = Instance.new("Frame", sidebar)
sbBorder.Size = UDim2.new(0, 1, 1, 0); sbBorder.Position = UDim2.new(1,-1,0,0)
sbBorder.BackgroundColor3 = Color3.fromRGB(42,42,42); sbBorder.BorderSizePixel = 0

-- Logo x7s
local logoLbl = Instance.new("TextLabel", sidebar)
logoLbl.Size = UDim2.new(1, 0, 0, 56); logoLbl.Position = UDim2.fromOffset(0, 14)
logoLbl.BackgroundTransparency = 1; logoLbl.Text = "x7s"
logoLbl.TextColor3 = Color3.fromRGB(239, 239, 239); logoLbl.Font = Enum.Font.Fantasy
logoLbl.TextSize = 38; logoLbl.TextXAlignment = Enum.TextXAlignment.Center
-- shadow/glow del logo
local logoGlow = Instance.new("UIStroke", logoLbl)
logoGlow.Color = accentColor; logoGlow.Transparency = 0.6; logoGlow.Thickness = 1
TweenService:Create(logoGlow, TweenInfo.new(3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
    Transparency = 0.25,
    Thickness = 2,
}):Play()

local dotsDeco = Instance.new("TextLabel", sidebar)
dotsDeco.Size = UDim2.new(1, 0, 0, 14); dotsDeco.Position = UDim2.fromOffset(0, 70)
dotsDeco.BackgroundTransparency = 1; dotsDeco.Text = "· · · · · · · · ·"
dotsDeco.TextColor3 = Color3.fromRGB(68,68,68); dotsDeco.Font = Enum.Font.GothamBold
dotsDeco.TextSize = 9; dotsDeco.TextXAlignment = Enum.TextXAlignment.Center
TweenService:Create(dotsDeco, TweenInfo.new(2.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
    TextTransparency = 0.35,
}):Play()

-- Chain divider
local function makeSBChain(parent, y)
    local c = Instance.new("Frame", parent)
    c.Size = UDim2.new(1, -20, 0, 1); c.Position = UDim2.new(0, 10, 0, y)
    c.BackgroundTransparency = 1; c.BorderSizePixel = 0
    local cg = Instance.new("UIGradient", c)
    cg.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(0,0,0)),
        ColorSequenceKeypoint.new(0.2, Color3.fromRGB(58,58,58)),
        ColorSequenceKeypoint.new(0.5, accentColor),
        ColorSequenceKeypoint.new(0.8, Color3.fromRGB(58,58,58)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0,0,0)),
    })
    c.BackgroundColor3 = Color3.fromRGB(255,255,255)
    c.BackgroundTransparency = 0
    return c
end
makeSBChain(sidebar, 88)

-- Nav buttons (paginas)
local navArea = Instance.new("Frame", sidebar)
navArea.Size = UDim2.new(1, -16, 0, 300); navArea.Position = UDim2.fromOffset(8, 100)
navArea.BackgroundTransparency = 1; navArea.BorderSizePixel = 0
local navLayout = Instance.new("UIListLayout", navArea)
navLayout.SortOrder = Enum.SortOrder.LayoutOrder; navLayout.Padding = UDim.new(0, 3)

-- Páginas de contenido
local CONTENT_X = SB_W
local CONTENT_W = GW - SB_W
local CONTENT_H2 = GH - HDR_H - FOOTER_H

local pages = {}
local navBtns = {}
local activePage = 1

local function makeContentPage()
    local p = Instance.new("ScrollingFrame", body)
    p.Size = UDim2.fromOffset(CONTENT_W, CONTENT_H2)
    p.Position = UDim2.fromOffset(CONTENT_X, 0)
    p.BackgroundTransparency = 1; p.BorderSizePixel = 0
    p.ScrollBarThickness = 2; p.ScrollBarImageColor3 = accentColor
    p.CanvasSize = UDim2.new(0,0,0,0); p.AutomaticCanvasSize = Enum.AutomaticSize.Y
    p.Visible = false
    local pad = Instance.new("UIPadding", p)
    pad.PaddingTop = UDim.new(0,14); pad.PaddingLeft = UDim.new(0,14)
    pad.PaddingRight = UDim.new(0,14); pad.PaddingBottom = UDim.new(0,16)
    local lay = Instance.new("UIListLayout", p)
    lay.SortOrder = Enum.SortOrder.LayoutOrder; lay.Padding = UDim.new(0, 10)
    return p
end

-- SVG-like icon labels (usando Unicode para los iconos de nav)


local NAV_DATA = {
    { icon = "*", label = "Inicio" },
    { icon = "o", label = "Aim" },
    { icon = "+", label = "Extras" },
    { icon = "#", label = "Ajustes" },
}




local function setPage(idx)
    if activePage == idx then return end
    if pages[activePage] then pages[activePage].Visible = false end
    local old = navBtns[activePage]
    if old then
        old.BackgroundTransparency = 1
        old.BorderSizePixel = 0
        for _, ch in ipairs(old:GetChildren()) do
            if ch:IsA("TextLabel") then ch.TextColor3 = Color3.fromRGB(119,119,119) end
            if ch:IsA("Frame") then ch.BackgroundColor3 = Color3.fromRGB(0,0,0); ch.BackgroundTransparency = 1 end
        end
    end
    activePage = idx
    pages[idx].Visible = true
    local nb = navBtns[idx]
    if nb then
        local nbg = Instance.new("UIGradient")
        nbg.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(0,0,0)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(36,30,46)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(0,0,0)),
        })
        -- active BG
        for _, ch in ipairs(nb:GetChildren()) do
            if ch:IsA("TextLabel") then ch.TextColor3 = Color3.fromRGB(239,239,239) end
        end
        nb.BackgroundColor3 = Color3.fromRGB(36,30,46)
        nb.BackgroundTransparency = 0.5
        local ns = nb:FindFirstChildOfClass("UIStroke")
        if ns then ns.Color = accentColor; ns.Transparency = 0.72 end
    end
end

for i, nd in ipairs(NAV_DATA) do
    local nb = Instance.new("TextButton", navArea)
    nb.Size = UDim2.new(1, 0, 0, 30)
    nb.BackgroundTransparency = 1; nb.BorderSizePixel = 0
    nb.Text = ""; nb.AutoButtonColor = false
    local nbs = Instance.new("UIStroke", nb)
    nbs.Color = Color3.fromRGB(0,0,0); nbs.Transparency = 1; nbs.Thickness = 1

    local iconLbl = Instance.new("TextLabel", nb)
    iconLbl.Size = UDim2.fromOffset(18, 30); iconLbl.Position = UDim2.fromOffset(10, 0)
    iconLbl.BackgroundTransparency = 1; iconLbl.Text = nd.icon
    iconLbl.TextColor3 = Color3.fromRGB(119,119,119); iconLbl.Font = Enum.Font.GothamBold
    iconLbl.TextSize = 14; iconLbl.TextXAlignment = Enum.TextXAlignment.Center

    local textLbl = Instance.new("TextLabel", nb)
    textLbl.Size = UDim2.new(1, -36, 1, 0); textLbl.Position = UDim2.fromOffset(34, 0)
    textLbl.BackgroundTransparency = 1; textLbl.Text = nd.label:upper()
    textLbl.TextColor3 = Color3.fromRGB(119,119,119); textLbl.Font = Enum.Font.GothamBold
    textLbl.TextSize = 11; textLbl.TextXAlignment = Enum.TextXAlignment.Left

    nb.MouseEnter:Connect(function()
        if activePage ~= i then
            iconLbl.TextColor3 = Color3.fromRGB(170,170,170)
            textLbl.TextColor3 = Color3.fromRGB(170,170,170)
        end
    end)
    nb.MouseLeave:Connect(function()
        if activePage ~= i then
            iconLbl.TextColor3 = Color3.fromRGB(119,119,119)
            textLbl.TextColor3 = Color3.fromRGB(119,119,119)
        end
    end)
    nb.MouseButton1Click:Connect(function() setPage(i) end)

    navBtns[i] = nb
    pages[i] = makeContentPage()
end

-- Sidebar bottom decorations
local sbChainBot = makeSBChain(sidebar, GH - HDR_H - FOOTER_H - 60)
local sbBottomDeco = Instance.new("TextLabel", sidebar)
sbBottomDeco.Size = UDim2.new(1, 0, 0, 30)
sbBottomDeco.Position = UDim2.new(0, 0, 1, -50)
sbBottomDeco.BackgroundTransparency = 1; sbBottomDeco.Text = "♥ ✝ ♥"
sbBottomDeco.TextColor3 = Color3.fromRGB(46,36,62); sbBottomDeco.Font = Enum.Font.GothamBold
sbBottomDeco.TextSize = 10; sbBottomDeco.TextXAlignment = Enum.TextXAlignment.Center



-- ── FOOTER ─────────────────────────────────────
local footer = Instance.new("Frame", panel)
footer.Size = UDim2.new(1, 0, 0, FOOTER_H); footer.Position = UDim2.new(0, 0, 1, -FOOTER_H)
footer.BackgroundColor3 = Color3.fromRGB(5,4,5); footer.BorderSizePixel = 0
local fBorder = Instance.new("Frame", footer)
fBorder.Size = UDim2.new(1, 0, 0, 1); fBorder.Position = UDim2.new(0,0,0,0)
fBorder.BackgroundColor3 = Color3.fromRGB(26,26,26); fBorder.BorderSizePixel = 0
local footerLayout = Instance.new("UIListLayout", footer)
footerLayout.FillDirection = Enum.FillDirection.Horizontal
footerLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
footerLayout.VerticalAlignment = Enum.VerticalAlignment.Center
footerLayout.Padding = UDim.new(0, 10)

local fc1 = Instance.new("TextLabel", footer); fc1.BackgroundTransparency=1
fc1.Text="✝"; fc1.TextColor3=Color3.fromRGB(42,42,42); fc1.Font=Enum.Font.Fantasy
fc1.TextSize=18; fc1.Size=UDim2.fromOffset(20,FOOTER_H)

local fLine1 = Instance.new("Frame", footer)
fLine1.Size=UDim2.fromOffset(140,1); fLine1.BackgroundColor3=Color3.fromRGB(42,42,42)
fLine1.BorderSizePixel=0; fLine1.LayoutOrder=2
local fLG = Instance.new("UIGradient",fLine1)
fLG.Color=ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(0,0,0)),ColorSequenceKeypoint.new(1,Color3.fromRGB(42,42,42))})

local fTextLbl = Instance.new("TextLabel", footer); fTextLbl.BackgroundTransparency=1
fTextLbl.Text="in darkness we trust"; fTextLbl.TextColor3=Color3.fromRGB(34,34,34)
fTextLbl.Font=Enum.Font.GothamBold; fTextLbl.TextSize=9
fTextLbl.Size=UDim2.fromOffset(130,FOOTER_H); fTextLbl.LayoutOrder=3

local fLine2 = Instance.new("Frame", footer)
fLine2.Size=UDim2.fromOffset(140,1); fLine2.BackgroundColor3=Color3.fromRGB(42,42,42)
fLine2.BorderSizePixel=0; fLine2.LayoutOrder=4
local fLG2 = Instance.new("UIGradient",fLine2)
fLG2.Color=ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(42,42,42)),ColorSequenceKeypoint.new(1,Color3.fromRGB(0,0,0))})

local fc2 = Instance.new("TextLabel", footer); fc2.BackgroundTransparency=1
fc2.Text="✝"; fc2.TextColor3=Color3.fromRGB(42,42,42); fc2.Font=Enum.Font.Fantasy
fc2.TextSize=18; fc2.Size=UDim2.fromOffset(20,FOOTER_H); fc2.LayoutOrder=5

-- ── GUI BUILDER HELPERS ─────────────────────────
local refreshers = {}

-- Actualizar el label de tecla del header (guiKeyLbl ya existe arriba)
local function updateGuiKeyLabel()
    local k = S.gui_key
    if k == "RightShift" then k = "RShift" elseif k == "LeftShift" then k = "LShift" end
    guiKeyLbl.Text = "[" .. k .. "] ocultar"
end
updateGuiKeyLabel()
refreshers["gui_key"] = updateGuiKeyLabel

-- Sistema de traducción en vivo: guarda {label, key} para actualizar al cambiar idioma
local langLabels = {}
local function registerLang(lbl, key)
    table.insert(langLabels, {lbl=lbl, key=key})
end
local function refreshLang()
    for _, e in ipairs(langLabels) do
        pcall(function() e.lbl.Text = L(e.key) or e.key end)
    end
end

-- Función para actualizar el color de acento globalmente
local accentDeps = {}   -- {frame/stroke/label, prop}
local function registerAccent(obj, prop)
    table.insert(accentDeps, {obj=obj, prop=prop})
    obj[prop] = accentColor
end
local function applyAccent(newCol)
    accentColor = newCol
    logoGlow.Color = newCol
    glow.BackgroundColor3 = newCol
    panelStroke.Color = Color3.fromRGB(58,58,58)  -- no cambia
    for _, dot in ipairs(particleLayer:GetChildren()) do
        if dot:IsA("Frame") then dot.BackgroundColor3 = newCol end
    end
    for _, a in ipairs(accentDeps) do
        pcall(function() a.obj[a.prop] = newCol end)
    end
    -- nav active state
    local nb2 = navBtns[activePage]
    if nb2 then
        local ns = nb2:FindFirstChildOfClass("UIStroke")
        if ns then ns.Color = newCol end
    end
    -- Sidebar chain
    for _, ch in ipairs(sidebar:GetChildren()) do
        if ch:IsA("Frame") and ch:FindFirstChildOfClass("UIGradient") then
            local g = ch:FindFirstChildOfClass("UIGradient")
            if g and #g.Color.Keypoints >= 3 then
                g.Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(0,0,0)),
                    ColorSequenceKeypoint.new(0.2, Color3.fromRGB(58,58,58)),
                    ColorSequenceKeypoint.new(0.5, newCol),
                    ColorSequenceKeypoint.new(0.8, Color3.fromRGB(58,58,58)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(0,0,0)),
                })
            end
        end
    end
end

-- Crear card (panel-box en HTML)
local function makeCard(parent)
    local card = Instance.new("Frame", parent)
    card.Size = UDim2.new(1, 0, 0, 0); card.AutomaticSize = Enum.AutomaticSize.Y
    card.BackgroundColor3 = Color3.fromRGB(13,13,13); card.BorderSizePixel = 0
    local cs = Instance.new("UIStroke", card)
    cs.Color = Color3.fromRGB(58,58,58); cs.Transparency = 0; cs.Thickness = 1
    local lay = Instance.new("UIListLayout", card)
    lay.SortOrder = Enum.SortOrder.LayoutOrder; lay.Padding = UDim.new(0,0)
    card.ClipsDescendants = true
    return card
end

-- Section header dentro de una card
local function makeSecHeader(parent, iconChar, titleText)
    local sh = Instance.new("Frame", parent)
    sh.Size = UDim2.new(1, 0, 0, 32); sh.BackgroundTransparency = 1
    local shBG = Instance.new("UIGradient", sh)
    shBG.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(8,6,8)), ColorSequenceKeypoint.new(1, Color3.fromRGB(13,10,13))})

    local dagLbl = Instance.new("TextLabel", sh)
    dagLbl.Size = UDim2.fromOffset(16, 32); dagLbl.Position = UDim2.fromOffset(14, 0)
    dagLbl.BackgroundTransparency = 1; dagLbl.Text = iconChar or "†"
    dagLbl.TextColor3 = accentColor; dagLbl.Font = Enum.Font.GothamBold; dagLbl.TextSize = 10
    registerAccent(dagLbl, "TextColor3")

    local titLbl = Instance.new("TextLabel", sh)
    titLbl.Size = UDim2.new(0, 120, 1, 0); titLbl.Position = UDim2.fromOffset(32, 0)
    titLbl.BackgroundTransparency = 1; titLbl.Text = titleText
    titLbl.TextColor3 = Color3.fromRGB(239,239,239); titLbl.Font = Enum.Font.GothamBlack
    titLbl.TextSize = 14; titLbl.TextXAlignment = Enum.TextXAlignment.Left

    -- Línea decorativa
    local secLine = Instance.new("Frame", sh)
    secLine.Size = UDim2.new(0, 80, 0, 1); secLine.Position = UDim2.new(0, 165, 0.5, 0)
    secLine.BackgroundColor3 = Color3.fromRGB(58,58,58); secLine.BorderSizePixel = 0
    local slG = Instance.new("UIGradient", secLine)
    slG.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(58,58,58)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0,0,0))})

    local shBottom = Instance.new("Frame", sh)
    shBottom.Size = UDim2.new(1, 0, 0, 1); shBottom.Position = UDim2.new(0, 0, 1, -1)
    shBottom.BackgroundColor3 = Color3.fromRGB(26,26,26); shBottom.BorderSizePixel = 0

    return sh
end

-- Divider
local function makeDivider(parent)
    local d = Instance.new("Frame", parent)
    d.Size = UDim2.new(1, 0, 0, 1); d.BackgroundColor3 = Color3.fromRGB(17,17,17); d.BorderSizePixel = 0
    return d
end

-- Section label simple (texto · · · SECCIÓN · · ·)
local function secLabel(parent, text)
    local f = Instance.new("Frame", parent)
    f.Size = UDim2.new(1, 0, 0, 26); f.BackgroundColor3 = Color3.fromRGB(8,6,8); f.BorderSizePixel = 0
    local topLine = Instance.new("Frame", f); topLine.Size = UDim2.new(1,0,0,1)
    topLine.BackgroundColor3 = Color3.fromRGB(26,26,26); topLine.BorderSizePixel = 0
    local botLine = Instance.new("Frame", f); botLine.Size = UDim2.new(1,0,0,1); botLine.Position = UDim2.new(0,0,1,-1)
    botLine.BackgroundColor3 = Color3.fromRGB(17,17,17); botLine.BorderSizePixel = 0
    local l = Instance.new("TextLabel", f)
    l.Size = UDim2.new(1, -28, 1, 0); l.Position = UDim2.fromOffset(14, 0)
    l.BackgroundTransparency = 1; l.Text = text:upper()
    l.TextColor3 = Color3.fromRGB(58,58,58); l.Font = Enum.Font.GothamBold; l.TextSize = 9
    l.TextXAlignment = Enum.TextXAlignment.Left
    return f
end

-- Panel Row (contenedor de un ítem de configuración)
local function makeRow(parent, titleTxt, descTxt)
    local hasDesc = descTxt and descTxt ~= ""
    local rowH = hasDesc and 56 or 42
    local row = Instance.new("Frame", parent)
    row.Size = UDim2.new(1, 0, 0, rowH); row.BackgroundTransparency = 1

    local tl = Instance.new("TextLabel", row)
    tl.Size = UDim2.new(1, -70, 0, 16)
    tl.Position = UDim2.fromOffset(14, hasDesc and 10 or 13)
    tl.BackgroundTransparency = 1; tl.Text = titleTxt
    tl.TextColor3 = Color3.fromRGB(215, 215, 215); tl.Font = Enum.Font.GothamMedium
    tl.TextSize = 12; tl.TextXAlignment = Enum.TextXAlignment.Left
    tl.TextTruncate = Enum.TextTruncate.AtEnd

    if hasDesc then
        local dl = Instance.new("TextLabel", row)
        dl.Size = UDim2.new(1, -70, 0, 20); dl.Position = UDim2.fromOffset(14, 28)
        dl.BackgroundTransparency = 1; dl.Text = descTxt
        dl.TextColor3 = Color3.fromRGB(85,85,85); dl.Font = Enum.Font.Gotham
        dl.TextSize = 9; dl.TextXAlignment = Enum.TextXAlignment.Left; dl.TextWrapped = true
    end
    return row, rowH
end

-- Toggle
local function makeToggle(parent, titleKey, descKey, stateKey, cb)
    local title = L(titleKey) or titleKey
    local desc = descKey and (L(descKey) or descKey) or nil
    local row, rowH = makeRow(parent, title, desc)

    -- Registrar labels para traducción en vivo
    local tl2 = row:FindFirstChildOfClass("TextLabel")
    if tl2 then registerLang(tl2, titleKey) end
    if descKey then
        for _, c in ipairs(row:GetChildren()) do
            if c:IsA("TextLabel") and c ~= tl2 then registerLang(c, descKey) end
        end
    end

    local TW, TH = 44, 24
    local track = Instance.new("Frame", row)
    track.Size = UDim2.fromOffset(TW, TH)
    track.Position = UDim2.new(1, -(TW+14), 0.5, -TH/2)
    track.BorderSizePixel = 0
    Instance.new("UICorner", track).CornerRadius = UDim.new(1, 0)
    local trkStroke = Instance.new("UIStroke", track)
    trkStroke.Color = Color3.fromRGB(58,58,58); trkStroke.Thickness = 1

    local thumb = Instance.new("Frame", track)
    thumb.Size = UDim2.fromOffset(18,18); thumb.BorderSizePixel = 0
    Instance.new("UICorner", thumb).CornerRadius = UDim.new(1, 0)

    local function refresh()
        local on = S[stateKey]
        if on then
            TweenService:Create(track, TI, {BackgroundColor3 = accentColor}):Play()
            trkStroke.Color = accentColor
        else
            TweenService:Create(track, TI, {BackgroundColor3 = Color3.fromRGB(26,26,26)}):Play()
            trkStroke.Color = Color3.fromRGB(58,58,58)
        end
        TweenService:Create(thumb, TI, {
            Position = on and UDim2.fromOffset(TW-20, 3) or UDim2.fromOffset(2, 3),
            BackgroundColor3 = on and Color3.fromRGB(239,239,239) or Color3.fromRGB(58,58,58),
        }):Play()
    end
    refresh(); refreshers[stateKey] = refresh

    local hit = Instance.new("TextButton", row)
    hit.Size = UDim2.new(1, 0, 1, 0); hit.BackgroundTransparency = 1; hit.Text = ""
    hit.MouseButton1Click:Connect(function()
        S[stateKey] = not S[stateKey]; refresh(); save()
        if cb then cb(S[stateKey]) end
        showNotif("✝  "..title, S[stateKey] and L("n_on") or L("n_off"), S[stateKey])
    end)
    hit.MouseEnter:Connect(function() TweenService:Create(row, TI, {BackgroundColor3=Color3.fromRGB(16,12,20)}):Play(); row.BackgroundTransparency=0; Instance.new("UICorner",row).CornerRadius=UDim.new(0,0) end)
    hit.MouseLeave:Connect(function() TweenService:Create(row, TI, {BackgroundTransparency=1}):Play() end)
    return row
end

-- Slider
local function makeSlider(parent, titleKey, stateKey, mn, mx, cb)
    local title = L(titleKey) or titleKey
    local row = Instance.new("Frame", parent)
    row.Size = UDim2.new(1, 0, 0, 52); row.BackgroundTransparency = 1

    local valLbl = Instance.new("TextLabel", row)
    valLbl.Size = UDim2.fromOffset(22, 16); valLbl.Position = UDim2.new(1, -36, 0, 12)
    valLbl.BackgroundTransparency = 1; valLbl.Text = tostring(S[stateKey])
    valLbl.TextColor3 = accentColor; valLbl.Font = Enum.Font.GothamBold; valLbl.TextSize = 11
    valLbl.TextXAlignment = Enum.TextXAlignment.Right
    registerAccent(valLbl, "TextColor3")

    local tl = Instance.new("TextLabel", row)
    tl.Size = UDim2.new(1, -70, 0, 16); tl.Position = UDim2.fromOffset(14, 12)
    tl.BackgroundTransparency = 1; tl.Text = title
    tl.TextColor3 = Color3.fromRGB(215,215,215); tl.Font = Enum.Font.GothamMedium; tl.TextSize = 12
    tl.TextXAlignment = Enum.TextXAlignment.Left

    local trk = Instance.new("Frame", row)
    trk.Size = UDim2.new(1, -28, 0, 4); trk.Position = UDim2.fromOffset(14, 34)
    trk.BackgroundColor3 = Color3.fromRGB(42,42,42); trk.BorderSizePixel = 0
    Instance.new("UICorner", trk).CornerRadius = UDim.new(1,0)

    local fill = Instance.new("Frame", trk)
    fill.BackgroundColor3 = accentColor; fill.BorderSizePixel = 0
    Instance.new("UICorner", fill).CornerRadius = UDim.new(1,0)
    registerAccent(fill, "BackgroundColor3")

    local sThumb = Instance.new("Frame", trk)
    sThumb.Size = UDim2.fromOffset(13,13); sThumb.BackgroundColor3 = accentColor
    sThumb.BorderSizePixel = 0; Instance.new("UICorner", sThumb).CornerRadius = UDim.new(1,0)
    registerAccent(sThumb, "BackgroundColor3")

    local function setVal(v)
        v = math.clamp(math.floor(v+0.5), mn, mx)
        S[stateKey] = v; valLbl.Text = tostring(v); save()
        local pct = (v-mn)/(mx-mn)
        TweenService:Create(fill, TweenInfo.new(0.1), {Size=UDim2.new(pct,0,1,0)}):Play()
        TweenService:Create(sThumb, TweenInfo.new(0.1), {Position=UDim2.new(pct,-6,0.5,-6)}):Play()
        if cb then cb(v) end
    end
    setVal(S[stateKey])

    -- Hit area alto para PC + touch (la barra real es de 4px)
    local hit = Instance.new("TextButton", row)
    hit.BackgroundTransparency = 1; hit.Text = ""
    hit.Size = UDim2.new(1,-28,0,30); hit.Position = UDim2.fromOffset(14,21)
    hit.ZIndex = 6; hit.AutoButtonColor = false

    local sliding = false
    local function setFromInput(inp)
        local abs = trk.AbsolutePosition; local sz = trk.AbsoluteSize
        if sz.X > 0 then setVal(mn + math.clamp((inp.Position.X-abs.X)/sz.X,0,1)*(mx-mn)) end
    end
    hit.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1
        or inp.UserInputType == Enum.UserInputType.Touch then
            sliding = true; setFromInput(inp)
        end
    end)
    UserInputService.InputChanged:Connect(function(inp)
        if sliding and (inp.UserInputType == Enum.UserInputType.MouseMovement
                     or inp.UserInputType == Enum.UserInputType.Touch) then
            setFromInput(inp)
        end
    end)
    UserInputService.InputEnded:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1
        or inp.UserInputType == Enum.UserInputType.Touch then sliding = false end
    end)
    return row
end

-- Keybind
local function makeKeybind(parent, titleKey, stateKey)
    local title = L(titleKey) or titleKey
    local row, _ = makeRow(parent, title, nil)
    row.Size = UDim2.new(1, 0, 0, 42)

    local kbBtn = Instance.new("TextButton", row)
    kbBtn.Size = UDim2.fromOffset(28, 28)
    kbBtn.Position = UDim2.new(1, -42, 0.5, -14)
    kbBtn.BackgroundColor3 = Color3.fromRGB(30,30,30)
    kbBtn.BorderSizePixel = 0; kbBtn.AutoButtonColor = false
    local kbs = Instance.new("UIStroke", kbBtn); kbs.Color = Color3.fromRGB(58,58,58); kbs.Thickness = 1

    local function getKeyLabel(k)
        if k == "RightShift" then return "RS"
        elseif k == "LeftShift" then return "LS"
        elseif #k == 1 then return k
        else return k:sub(1,3) end
    end
    local kbLbl = Instance.new("TextLabel", kbBtn)
    kbLbl.Size = UDim2.new(1,0,1,0); kbLbl.BackgroundTransparency = 1
    kbLbl.Text = getKeyLabel(S[stateKey]); kbLbl.TextColor3 = accentColor
    kbLbl.Font = Enum.Font.GothamBold; kbLbl.TextSize = 11
    registerAccent(kbLbl, "TextColor3")

    local listening = false
    kbBtn.MouseButton1Click:Connect(function()
        if listening then return end
        listening = true
        kbLbl.Text = "…"; kbLbl.TextColor3 = accentColor; kbs.Color = accentColor
        local conn; conn = UserInputService.InputBegan:Connect(function(inp, proc)
            if proc then return end
            if inp.UserInputType == Enum.UserInputType.Keyboard then
                local kn = inp.KeyCode.Name
                if kn == "Escape" then
                    kbLbl.Text = getKeyLabel(S[stateKey])
                else
                    S[stateKey] = kn; save()
                    kbLbl.Text = getKeyLabel(kn)
                    -- Si se cambió la tecla de GUI, actualizar el label del header
                    if stateKey == "gui_key" and refreshers["gui_key"] then
                        refreshers["gui_key"]()
                    end
                end
                kbLbl.TextColor3 = accentColor; kbs.Color = Color3.fromRGB(58,58,58)
                listening = false; conn:Disconnect()
            end
        end)
    end)
    kbBtn.MouseEnter:Connect(function() kbs.Color = accentColor end)
    kbBtn.MouseLeave:Connect(function() if not listening then kbs.Color = Color3.fromRGB(58,58,58) end end)

    local function refreshKb()
        kbLbl.Text = getKeyLabel(S[stateKey])
        -- Si es la tecla de GUI, actualizar también el label del header
        if stateKey == "gui_key" then updateGuiKeyLabel() end
    end
    refreshers[stateKey] = refreshKb
    return row
end

-- Reset Button
local function makeResetBtn(parent, titleKey, descKey, cb)
    local title = L(titleKey) or titleKey
    local desc = descKey and (L(descKey) or descKey) or nil
    local row, _ = makeRow(parent, title, desc)
    row.Size = UDim2.new(1, 0, 0, desc and 52 or 42)

    local rBtn = Instance.new("TextButton", row)
    rBtn.Size = UDim2.fromOffset(28, 28)
    rBtn.Position = UDim2.new(1, -42, 0.5, -14)
    rBtn.BackgroundColor3 = Color3.fromRGB(30,30,30); rBtn.BorderSizePixel = 0
    rBtn.Text = "R"; rBtn.TextColor3 = accentColor
    rBtn.Font = Enum.Font.GothamBold; rBtn.TextSize = 16; rBtn.AutoButtonColor = false
    local rbs = Instance.new("UIStroke", rBtn); rbs.Color = Color3.fromRGB(58,58,58); rbs.Thickness = 1
    rBtn.MouseEnter:Connect(function() rbs.Color = accentColor end)
    rBtn.MouseLeave:Connect(function() rbs.Color = Color3.fromRGB(58,58,58) end)
    rBtn.MouseButton1Click:Connect(function()
        TweenService:Create(rBtn, TI, {Rotation=360}):Play()
        task.delay(0.2, function() rBtn.Rotation=0 end)
        if cb then cb() end
        showNotif("✝  "..title, L("n_reset"), true)
    end)
    return row
end

-- Dropdown
local function makeDropdown(parent, titleKey, stateKey, options, cb)
    local title = L(titleKey) or titleKey
    local container = Instance.new("Frame", parent)
    container.Size = UDim2.new(1, 0, 0, 42); container.BackgroundTransparency = 1

    local row = Instance.new("Frame", container)
    row.Size = UDim2.new(1, 0, 0, 42); row.BackgroundTransparency = 1

    local tl = Instance.new("TextLabel", row)
    tl.Size = UDim2.new(1, -120, 0, 16); tl.Position = UDim2.fromOffset(14, 13)
    tl.BackgroundTransparency = 1; tl.Text = title
    tl.TextColor3 = Color3.fromRGB(215,215,215); tl.Font = Enum.Font.GothamMedium; tl.TextSize = 12
    tl.TextXAlignment = Enum.TextXAlignment.Left

    local valLbl = Instance.new("TextLabel", row)
    valLbl.Size = UDim2.fromOffset(90, 16); valLbl.Position = UDim2.new(1, -110, 0, 13)
    valLbl.BackgroundTransparency = 1; valLbl.Text = S[stateKey]
    valLbl.TextColor3 = Color3.fromRGB(85,85,85); valLbl.Font = Enum.Font.Gotham; valLbl.TextSize = 11
    valLbl.TextXAlignment = Enum.TextXAlignment.Right

    local arrowLbl = Instance.new("TextLabel", row)
    arrowLbl.Size = UDim2.fromOffset(14, 16); arrowLbl.Position = UDim2.new(1, -18, 0, 13)
    arrowLbl.BackgroundTransparency = 1; arrowLbl.Text = "v"
    arrowLbl.TextColor3 = Color3.fromRGB(85,85,85); arrowLbl.Font = Enum.Font.GothamBold; arrowLbl.TextSize = 10

    local optH = 32
    local dropFrame = Instance.new("Frame", container)
    dropFrame.Size = UDim2.new(1, 0, 0, 0); dropFrame.Position = UDim2.fromOffset(0, 42)
    dropFrame.BackgroundColor3 = Color3.fromRGB(18,14,22); dropFrame.BorderSizePixel = 0
    dropFrame.ClipsDescendants = true; dropFrame.ZIndex = 50; dropFrame.Visible = false
    local dfs = Instance.new("UIStroke", dropFrame); dfs.Color = Color3.fromRGB(58,58,58); dfs.Thickness = 1

    for idx, opt in ipairs(options) do
        local ob = Instance.new("TextButton", dropFrame)
        ob.Size = UDim2.new(1,0,0,optH); ob.Position = UDim2.fromOffset(0,(idx-1)*optH)
        ob.BackgroundTransparency = 1; ob.BorderSizePixel = 0
        ob.Text = opt; ob.Font = Enum.Font.GothamMedium; ob.TextSize = 11
        ob.TextColor3 = S[stateKey] == opt and accentColor or Color3.fromRGB(215,215,215)
        ob.ZIndex = 51; ob.AutoButtonColor = false
        ob.MouseButton1Click:Connect(function()
            S[stateKey] = opt; valLbl.Text = opt
            for _, b in ipairs(dropFrame:GetChildren()) do
                if b:IsA("TextButton") then b.TextColor3 = b.Text==opt and accentColor or Color3.fromRGB(215,215,215) end
            end
            TweenService:Create(dropFrame, TIF, {Size=UDim2.new(1,0,0,0)}):Play()
            task.delay(0.25, function() dropFrame.Visible=false end)
            container.Size = UDim2.new(1,0,0,42); arrowLbl.Text = "v"
            save(); if cb then cb(opt) end
        end)
    end

    local open = false
    local hitArea = Instance.new("TextButton", row)
    hitArea.Size = UDim2.new(1,0,1,0); hitArea.BackgroundTransparency=1; hitArea.Text=""; hitArea.ZIndex=5
    hitArea.MouseButton1Click:Connect(function()
        open = not open
        if open then
            dropFrame.Visible=true; dropFrame.Size=UDim2.new(1,0,0,0)
            TweenService:Create(dropFrame, TIF, {Size=UDim2.new(1,0,0,#options*optH)}):Play()
            container.Size=UDim2.new(1,0,0,42+#options*optH); arrowLbl.Text="^"
        else
            TweenService:Create(dropFrame, TIF, {Size=UDim2.new(1,0,0,0)}):Play()
            task.delay(0.25, function() dropFrame.Visible=false end)
            container.Size=UDim2.new(1,0,0,42); arrowLbl.Text="v"
        end
    end)
    return container
end

-- Color Picker (hex input + swatch click)
local function makeColorPicker(parent, label, getR, getG, getB, setRGB)
    local row = Instance.new("Frame", parent)
    row.Size = UDim2.new(1, 0, 0, 42); row.BackgroundTransparency = 1

    local tl = Instance.new("TextLabel", row)
    tl.Size = UDim2.new(1, -60, 0, 16); tl.Position = UDim2.fromOffset(14, 13)
    tl.BackgroundTransparency = 1; tl.Text = label
    tl.TextColor3 = Color3.fromRGB(215,215,215); tl.Font = Enum.Font.GothamMedium; tl.TextSize = 12
    tl.TextXAlignment = Enum.TextXAlignment.Left

    -- Swatch + R/G/B sliders en popup
    local swatch = Instance.new("Frame", row)
    swatch.Size = UDim2.fromOffset(28, 28); swatch.Position = UDim2.new(1, -42, 0.5, -14)
    swatch.BackgroundColor3 = Color3.fromRGB(getR(), getG(), getB()); swatch.BorderSizePixel = 0
    local swStroke = Instance.new("UIStroke", swatch); swStroke.Color = Color3.fromRGB(58,58,58); swStroke.Thickness = 1

    -- Sub-panel con los 3 sliders R/G/B
    local popup = Instance.new("Frame", parent)
    popup.Size = UDim2.new(1, 0, 0, 130); popup.BackgroundColor3 = Color3.fromRGB(16,12,22)
    popup.BorderSizePixel = 0; popup.Visible = false
    local pps = Instance.new("UIStroke", popup); pps.Color = Color3.fromRGB(58,58,58); pps.Thickness = 1
    local ppLayout = Instance.new("UIListLayout", popup)
    ppLayout.SortOrder = Enum.SortOrder.LayoutOrder; ppLayout.Padding = UDim.new(0,4)
    local ppPad = Instance.new("UIPadding", popup)
    ppPad.PaddingTop=UDim.new(0,8); ppPad.PaddingLeft=UDim.new(0,12)
    ppPad.PaddingRight=UDim.new(0,12); ppPad.PaddingBottom=UDim.new(0,8)

    local rgbVals = {getR(), getG(), getB()}
    local function updateSwatch()
        swatch.BackgroundColor3 = Color3.fromRGB(rgbVals[1], rgbVals[2], rgbVals[3])
        setRGB(rgbVals[1], rgbVals[2], rgbVals[3])
    end

    local LABELS = {"R","G","B"}
    local COLS = {Color3.fromRGB(220,80,80), Color3.fromRGB(80,200,80), Color3.fromRGB(80,120,220)}

    for ci = 1, 3 do
        local sRow = Instance.new("Frame", popup)
        sRow.Size = UDim2.new(1, 0, 0, 28); sRow.BackgroundTransparency = 1

        local lLbl = Instance.new("TextLabel", sRow)
        lLbl.Size = UDim2.fromOffset(16, 28); lLbl.Position = UDim2.fromOffset(0, 0)
        lLbl.BackgroundTransparency=1; lLbl.Text=LABELS[ci]
        lLbl.TextColor3=COLS[ci]; lLbl.Font=Enum.Font.GothamBold; lLbl.TextSize=11

        local vLbl = Instance.new("TextLabel", sRow)
        vLbl.Size = UDim2.fromOffset(28, 28); vLbl.Position = UDim2.new(1,-30,0,0)
        vLbl.BackgroundTransparency=1; vLbl.Text=tostring(rgbVals[ci])
        vLbl.TextColor3=COLS[ci]; vLbl.Font=Enum.Font.GothamBold; vLbl.TextSize=10
        vLbl.TextXAlignment=Enum.TextXAlignment.Right

        local trk2 = Instance.new("Frame", sRow)
        trk2.Size = UDim2.new(1,-52,0,4); trk2.Position=UDim2.fromOffset(22,12)
        trk2.BackgroundColor3=Color3.fromRGB(42,42,42); trk2.BorderSizePixel=0
        Instance.new("UICorner",trk2).CornerRadius=UDim.new(1,0)

        local fill2 = Instance.new("Frame", trk2)
        fill2.BackgroundColor3=COLS[ci]; fill2.BorderSizePixel=0
        Instance.new("UICorner",fill2).CornerRadius=UDim.new(1,0)

        local function setV(v)
            v = math.clamp(math.floor(v+0.5),0,255)
            rgbVals[ci] = v; vLbl.Text=tostring(v)
            fill2.Size = UDim2.new(v/255,0,1,0)
            updateSwatch(); save()
        end
        setV(rgbVals[ci])

        -- Hit area alto para PC + touch (la barra real es de 4px)
        local hit2 = Instance.new("TextButton", sRow)
        hit2.BackgroundTransparency = 1; hit2.Text = ""
        hit2.Size = UDim2.new(1,-52,1,0); hit2.Position = UDim2.fromOffset(22,0)
        hit2.ZIndex = 6; hit2.AutoButtonColor = false

        local sl2 = false
        local function setFromInput(inp)
            local a=trk2.AbsolutePosition; local sz=trk2.AbsoluteSize
            if sz.X>0 then setV((inp.Position.X-a.X)/sz.X*255) end
        end
        hit2.InputBegan:Connect(function(inp)
            if inp.UserInputType==Enum.UserInputType.MouseButton1
            or inp.UserInputType==Enum.UserInputType.Touch then
                sl2=true; setFromInput(inp)
            end
        end)
        UserInputService.InputChanged:Connect(function(inp)
            if sl2 and (inp.UserInputType==Enum.UserInputType.MouseMovement
                     or inp.UserInputType==Enum.UserInputType.Touch) then
                setFromInput(inp)
            end
        end)
        UserInputService.InputEnded:Connect(function(inp)
            if inp.UserInputType==Enum.UserInputType.MouseButton1
            or inp.UserInputType==Enum.UserInputType.Touch then sl2=false end
        end)
    end

    local popOpen = false
    local swBtn = Instance.new("TextButton", swatch)
    swBtn.Size=UDim2.new(1,0,1,0); swBtn.BackgroundTransparency=1; swBtn.Text=""
    swBtn.MouseButton1Click:Connect(function()
        popOpen = not popOpen; popup.Visible = popOpen
    end)
    return row, popup
end

-- Páginas: 1 = Inicio, 2 = Aim, 3 = Extras, 4 = Ajustes
local pg_inicio   = pages[1]
local pg_aim      = pages[2]
local pg_extras   = pages[3]
local pg_ajustes  = pages[4]


-- ══ INICIO PAGE ══════════════════════════════════

-- User Card (avatar + nombre + skin)
local userCard = Instance.new("Frame", pg_inicio)
userCard.Size = UDim2.new(1, 0, 0, 72)
userCard.BackgroundColor3 = Color3.fromRGB(13, 10, 18)
userCard.BorderSizePixel = 0
local ucStroke = Instance.new("UIStroke", userCard); ucStroke.Color=Color3.fromRGB(42,42,42); ucStroke.Thickness=1

-- Avatar circle
local avatarCircle = Instance.new("Frame", userCard)
avatarCircle.Size = UDim2.fromOffset(52, 52); avatarCircle.Position = UDim2.fromOffset(14, 10)
avatarCircle.BackgroundColor3 = Color3.fromRGB(26,16,42); avatarCircle.BorderSizePixel = 0
Instance.new("UICorner", avatarCircle).CornerRadius = UDim.new(1,0)
local avStroke = Instance.new("UIStroke", avatarCircle); avStroke.Color = accentColor; avStroke.Thickness = 2
registerAccent(avStroke, "Color")

local avatarImg = Instance.new("ImageLabel", avatarCircle)
avatarImg.Size = UDim2.new(1,0,1,0); avatarImg.BackgroundTransparency = 1
avatarImg.Image = "https://www.roblox.com/headshot-thumbnail/image?userId="..player.UserId.."&width=150&height=150&format=png"
avatarImg.ScaleType = Enum.ScaleType.Fit
Instance.new("UICorner", avatarImg).CornerRadius = UDim.new(1,0)

-- Info
local uNameLbl = Instance.new("TextLabel", userCard)
uNameLbl.Size = UDim2.new(1,-120,0,22); uNameLbl.Position = UDim2.fromOffset(76, 10)
uNameLbl.BackgroundTransparency=1; uNameLbl.Text=player.Name
uNameLbl.TextColor3=Color3.fromRGB(239,239,239); uNameLbl.Font=Enum.Font.GothamBlack
uNameLbl.TextSize=16; uNameLbl.TextXAlignment=Enum.TextXAlignment.Left

local uSkinLbl = Instance.new("TextLabel", userCard)
uSkinLbl.Size = UDim2.new(1,-120,0,14); uSkinLbl.Position = UDim2.fromOffset(76, 34)
uSkinLbl.BackgroundTransparency=1
-- Skin = nombre del avatar o outfit si existe
local skinText = "Default"
pcall(function()
    local desc = Players:GetHumanoidDescriptionFromUserId(player.UserId)
    if desc and desc.Shirt ~= 0 then skinText = "Custom Outfit" end
end)
uSkinLbl.Text="Skin: "..skinText
uSkinLbl.TextColor3=Color3.fromRGB(85,85,85); uSkinLbl.Font=Enum.Font.Gotham
uSkinLbl.TextSize=10; uSkinLbl.TextXAlignment=Enum.TextXAlignment.Left

local uIdLbl = Instance.new("TextLabel", userCard)
uIdLbl.Size = UDim2.new(1,-120,0,12); uIdLbl.Position = UDim2.fromOffset(76, 50)
uIdLbl.BackgroundTransparency=1; uIdLbl.Text="ID: "..tostring(player.UserId)
uIdLbl.TextColor3=Color3.fromRGB(42,42,42); uIdLbl.Font=Enum.Font.Gotham
uIdLbl.TextSize=9; uIdLbl.TextXAlignment=Enum.TextXAlignment.Left

-- Status dot
local statusDot = Instance.new("Frame", userCard)
statusDot.Size=UDim2.fromOffset(8,8); statusDot.Position=UDim2.new(1,-16,0,10)
statusDot.BackgroundColor3=accentColor; statusDot.BorderSizePixel=0
Instance.new("UICorner",statusDot).CornerRadius=UDim.new(1,0)
registerAccent(statusDot, "BackgroundColor3")
local statusLbl = Instance.new("TextLabel", userCard)
statusLbl.Size=UDim2.fromOffset(40,10); statusLbl.Position=UDim2.new(1,-50,0,0)
statusLbl.BackgroundTransparency=1; statusLbl.Text="ONLINE"
statusLbl.TextColor3=Color3.fromRGB(42,42,42); statusLbl.Font=Enum.Font.GothamBold
statusLbl.TextSize=7; statusLbl.TextXAlignment=Enum.TextXAlignment.Right

-- BUGFIX: espObjects se declara aquí (antes era local más abajo, lo que hacía
-- que estos toggles vieran una variable global distinta y nunca la encontraran).
local espObjects = {}

-- ── ESP + HBX en una sola columna funcional ───────
local espCard = makeCard(pg_inicio)
makeSecHeader(espCard, "†", "ESP")
makeToggle(espCard, "esp_on", "esp_on_d", "esp_on", function(on)
    if not on and espObjects then
        for _, obj in pairs(espObjects) do
            for _, hl in pairs(obj.highlights) do pcall(function() hl.Enabled = false end) end
            if obj.billboard     then obj.billboard.Enabled     = false end
            if obj.nameBillboard then obj.nameBillboard.Enabled = false end
            obj.line.Visible = false
            obj.hbx.Visible  = false
        end
    end
end)
makeDivider(espCard)
makeToggle(espCard, "esp_names",   nil,            "esp_names")
makeDivider(espCard)
makeToggle(espCard, "esp_avatar",  "esp_avatar_d", "esp_avatar")
makeDivider(espCard)
makeToggle(espCard, "esp_lines", "esp_lines_d", "esp_lines", function(on)
    if not on then
        for _, obj in pairs(espObjects) do obj.line.Visible = false end
    end
end)
makeDivider(espCard)
makeToggle(espCard, "esp_rainbow", "esp_rainbow_d","esp_rainbow")
makeDivider(espCard)
local espColorRow, espColorPop = makeColorPicker(espCard, "ESP Color",
    function() return S.esp_char_r end,
    function() return S.esp_char_g end,
    function() return S.esp_char_b end,
    function(r,g,b) S.esp_char_r=r; S.esp_char_g=g; S.esp_char_b=b end
)
makeDivider(espCard)
makeKeybind(espCard, "esp_key", "esp_key")

local hbxCard = makeCard(pg_inicio)
makeSecHeader(hbxCard, "†", "Hitbox")
makeToggle(hbxCard, "hbx_on",  "hbx_on_d",  "hbx_on", function(on)
    if not on then
        for _, p2 in ipairs(Players:GetPlayers()) do
            if p2 ~= player and _hbxOriginals[p2] then
                if _hbxOriginals[p2].proxy then
                    pcall(function() _hbxOriginals[p2].proxy:Destroy() end)
                end
                if _hbxOriginals[p2].weld then
                    pcall(function() _hbxOriginals[p2].weld:Destroy() end)
                end
                _hbxOriginals[p2] = nil
            end
        end
        for _, obj in pairs(espObjects) do
            if obj.selBox2 then obj.selBox2.Visible = false end
        end
    end
end)
makeDivider(hbxCard)
makeToggle(hbxCard, "hbx_vis",  "hbx_vis_d",  "hbx_vis_check")
makeDivider(hbxCard)
makeSlider(hbxCard, "hbx_size", "hbx_size", 1, 20, function()
    -- Re-aplicar tamaño: destruir proxies viejos y crear nuevos con nuevo tamaño
    if S.hbx_on then
        for _, p2 in ipairs(Players:GetPlayers()) do
            if p2 ~= player and p2.Character then
                if _hbxOriginals[p2] then
                    if _hbxOriginals[p2].proxy then
                        pcall(function() _hbxOriginals[p2].proxy:Destroy() end)
                    end
                    if _hbxOriginals[p2].weld then
                        pcall(function() _hbxOriginals[p2].weld:Destroy() end)
                    end
                    _hbxOriginals[p2] = nil
                end
                -- Re-crear con nuevo tamaño
                task.defer(function() applyHitbox(p2, true) end)
            end
        end
    end
end)
makeDivider(hbxCard)
makeToggle(hbxCard, "hbx_show", nil, "hbx_show", function(on)
    if not on and espObjects then
        for _, obj in pairs(espObjects) do obj.hbx.Visible = false end
    end
end)
makeDivider(hbxCard)
makeToggle(hbxCard, "hbx_show2", "hbx_show2_d", "hbx_show2", function(on)
    if not on and espObjects then
        for _, obj in pairs(espObjects) do
            if obj.selBox2 then obj.selBox2.Visible = false end
        end
    end
end)
makeDivider(hbxCard)
makeKeybind(hbxCard, "hbx_key", "hbx_key")

-- ══ SUMMER 2026 ═══════════════════════════════════
local summerCard = makeCard(pg_inicio)
makeSecHeader(summerCard, "*", "Summer 2026")
makeToggle(summerCard, "summer_on", "summer_on_d", "summer_on")


-- ══ AIM PAGE ═══════════════════════════════════════════════════
-- == SILENT AIM CARD ==============================================
local silentCard = makeCard(pg_aim)
makeSecHeader(silentCard, "o", "Silent Aim")
makeToggle(silentCard, "silent_on", "silent_on_d", "SilentAimEnabled", function(on)
    showNotif("✝  Silent Aim", on and L("n_on") or L("n_off"), on)
end)
makeDivider(silentCard)
makeToggle(silentCard, "silent_vis", "silent_vis_d", "VisibleCheck")
makeDivider(silentCard)
makeToggle(silentCard, "silent_man", "silent_man_d", "Manipulation")
makeDivider(silentCard)
makeSlider(silentCard, "silent_hc", "HitChance", 1, 100)

local camLockCard = makeCard(pg_aim)
makeSecHeader(camLockCard, "x", "Cam Lock")
makeToggle(camLockCard, "camlock_on", "camlock_on_d", "CamLockEnabled", function(on)
    showNotif("✝  Cam Lock", on and L("n_on") or L("n_off"), on)
end)
makeDivider(camLockCard)
makeSlider(camLockCard, "camlock_strength", "CamLockStrength", 1, 100)
makeDivider(camLockCard)
makeSlider(camLockCard, "camlock_range", "CamLockRange", 50, 500)
makeDivider(camLockCard)
makeToggle(camLockCard, "camlock_wallcheck", "camlock_wallcheck_d", "CamLockWallCheck")
makeDivider(camLockCard)
makeToggle(camLockCard, "camlock_safezone", "camlock_safezone_d", "CamLockSafeZone")
makeDivider(camLockCard)
makeKeybind(camLockCard, "camlock_key", "camlock_key")

-- ══ FOV CIRCLE CARD ═══════════════════════════════════════════
local fovCard = makeCard(pg_aim)
makeSecHeader(fovCard, "o", "FOV Circle")
makeToggle(fovCard, "fov_on", "fov_on_d", "fov_on", function(on)
    showNotif("✝  FOV Circle", on and L("n_on") or L("n_off"), on)
end)
makeDivider(fovCard)
makeToggle(fovCard, "fov_visible", "fov_visible_d", "fov_visible")
makeDivider(fovCard)
makeSlider(fovCard, "fov_radius", "fov_radius", 20, 400)

-- ══ TARGET (igual a SyyClient - dropdown desplegable) ═════════
local targetCard = makeCard(pg_aim)
makeSecHeader(targetCard, "+", "Target")
makeDivider(targetCard)
makeDropdown(targetCard, "target_part", "TargetPart", {"Head","UpperTorso","LowerTorso","Pierna","Pecho","Combo","Random"})

-- ══ WHITELIST (igual a SyyClient - dropdown con lista del servidor) ══
local whitelistCard = makeCard(pg_aim)
makeSecHeader(whitelistCard, "x", "Whitelist")

do
    -- ── Fila "Jugadores en servidor" + botón Refresh ──────────
    local WL_ENTRY_H = 28
    local headerRow = Instance.new("Frame", whitelistCard)
    headerRow.Size = UDim2.new(1,0,0,WL_ENTRY_H); headerRow.BackgroundTransparency = 1

    local hdrLbl = Instance.new("TextLabel", headerRow)
    hdrLbl.Size = UDim2.new(1,-80,1,0); hdrLbl.Position = UDim2.fromOffset(0,0)
    hdrLbl.BackgroundTransparency=1; hdrLbl.Text="Jugadores en servidor"
    hdrLbl.TextColor3=Color3.fromRGB(102,92,120); hdrLbl.Font=Enum.Font.GothamMedium
    hdrLbl.TextSize=11; hdrLbl.TextXAlignment=Enum.TextXAlignment.Left

    local refreshBtn = Instance.new("TextButton", headerRow)
    refreshBtn.Size = UDim2.fromOffset(68,22); refreshBtn.Position = UDim2.new(1,-72,0.5,-11)
    refreshBtn.BackgroundColor3 = Color3.fromRGB(18,14,24); refreshBtn.BorderSizePixel=0
    refreshBtn.Text=">> Refresh"; refreshBtn.TextColor3=accentColor
    refreshBtn.Font=Enum.Font.GothamBold; refreshBtn.TextSize=9; refreshBtn.AutoButtonColor=false
    local rfStroke=Instance.new("UIStroke",refreshBtn); rfStroke.Color=accentColor; rfStroke.Thickness=1

    -- ── Lista desplegable de jugadores del servidor ──────────
    local serverOpen = false
    local serverContainer = Instance.new("Frame", whitelistCard)
    serverContainer.Size = UDim2.new(1,0,0,0); serverContainer.BackgroundTransparency=1
    serverContainer.BorderSizePixel=0; serverContainer.ClipsDescendants=false

    local serverDropFrame = Instance.new("Frame", serverContainer)
    serverDropFrame.Size = UDim2.new(1,0,0,0); serverDropFrame.BackgroundColor3=Color3.fromRGB(14,10,20)
    serverDropFrame.BorderSizePixel=0; serverDropFrame.ClipsDescendants=true; serverDropFrame.ZIndex=12
    serverDropFrame.Visible=false
    local sdfStroke=Instance.new("UIStroke",serverDropFrame); sdfStroke.Color=Color3.fromRGB(58,50,80); sdfStroke.Thickness=1
    local serverListFrame = Instance.new("Frame", serverDropFrame)
    serverListFrame.Size = UDim2.new(1,0,0,0); serverListFrame.BackgroundTransparency=1
    serverListFrame.AutomaticSize=Enum.AutomaticSize.Y
    local slLay=Instance.new("UIListLayout",serverListFrame); slLay.SortOrder=Enum.SortOrder.LayoutOrder
    slLay.Padding=UDim.new(0,2)
    local slPad=Instance.new("UIPadding",serverListFrame)
    slPad.PaddingTop=UDim.new(0,4); slPad.PaddingBottom=UDim.new(0,4)
    slPad.PaddingLeft=UDim.new(0,4); slPad.PaddingRight=UDim.new(0,4)

    -- Header dropdown toggle button (arrow)
    local arrowLbl = Instance.new("TextLabel", headerRow)
    arrowLbl.Size=UDim2.fromOffset(14,WL_ENTRY_H); arrowLbl.Position=UDim2.new(1,-16,0,0)
    arrowLbl.BackgroundTransparency=1; arrowLbl.Text="v"
    arrowLbl.TextColor3=accentColor; arrowLbl.Font=Enum.Font.GothamBold; arrowLbl.TextSize=10

    -- ── Lista en whitelist (guardada) ──────────────────────────
    local wlSecLbl = Instance.new("TextLabel", whitelistCard)
    wlSecLbl.Size = UDim2.new(1,0,0,16); wlSecLbl.BackgroundTransparency=1
    wlSecLbl.Text="— En Whitelist —"; wlSecLbl.TextColor3=accentColor
    wlSecLbl.Font=Enum.Font.GothamBlack; wlSecLbl.TextSize=9
    wlSecLbl.TextXAlignment=Enum.TextXAlignment.Left

    local wlFrame = Instance.new("Frame", whitelistCard)
    wlFrame.Size = UDim2.new(1,0,0,0); wlFrame.BackgroundTransparency=1
    wlFrame.AutomaticSize=Enum.AutomaticSize.Y
    local wlLay=Instance.new("UIListLayout",wlFrame); wlLay.SortOrder=Enum.SortOrder.LayoutOrder
    wlLay.Padding=UDim.new(0,2)

    -- Forward declarations
    local rebuildWL, rebuildServerList

    rebuildWL = function()
        for _,c in ipairs(wlFrame:GetChildren()) do if c:IsA("Frame") then c:Destroy() end end
        for _, name in ipairs(S.Whitelist) do
            local e = Instance.new("Frame", wlFrame)
            e.Size=UDim2.new(1,0,0,WL_ENTRY_H); e.BackgroundColor3=Color3.fromRGB(14,10,20)
            e.BorderSizePixel=0
            local eStroke=Instance.new("UIStroke",e); eStroke.Color=Color3.fromRGB(58,50,80); eStroke.Thickness=1
            local nl=Instance.new("TextLabel",e)
            nl.Size=UDim2.new(1,-38,1,0); nl.Position=UDim2.fromOffset(6,0)
            nl.BackgroundTransparency=1; nl.Text="+ "..name
            nl.TextColor3=accentColor; nl.Font=Enum.Font.GothamMedium
            nl.TextSize=11; nl.TextXAlignment=Enum.TextXAlignment.Left
            local db=Instance.new("TextButton",e)
            db.Size=UDim2.fromOffset(22,20); db.Position=UDim2.new(1,-26,0.5,-10)
            db.BackgroundColor3=Color3.fromRGB(40,8,8); db.BorderSizePixel=0
            db.Text="x"; db.TextColor3=Color3.fromRGB(255,80,80)
            db.Font=Enum.Font.GothamBold; db.TextSize=11; db.AutoButtonColor=false
            local dbStroke=Instance.new("UIStroke",db); dbStroke.Color=Color3.fromRGB(100,20,20); dbStroke.Thickness=1
            db.MouseButton1Click:Connect(function()
                removeWhitelist(name); rebuildWL(); rebuildServerList()
                showNotif("✝  Whitelist", "Removed: "..name, false)
            end)
        end
    end

    rebuildServerList = function()
        for _,c in ipairs(serverListFrame:GetChildren()) do if c:IsA("Frame") then c:Destroy() end end
        local plrCount = 0
        for _,p in ipairs(Players:GetPlayers()) do
            if p == player then continue end
            plrCount = plrCount + 1
            local e=Instance.new("Frame",serverListFrame)
            e.Size=UDim2.new(1,0,0,WL_ENTRY_H); e.BackgroundColor3=Color3.fromRGB(10,8,14)
            e.BorderSizePixel=0
            local eStroke=Instance.new("UIStroke",e); eStroke.Color=Color3.fromRGB(38,30,54); eStroke.Thickness=1
            local namLbl=Instance.new("TextLabel",e)
            namLbl.Size=UDim2.new(1,-80,1,0); namLbl.Position=UDim2.fromOffset(6,0)
            namLbl.BackgroundTransparency=1; namLbl.Text=p.Name
            namLbl.TextColor3=Color3.fromRGB(215,215,215); namLbl.Font=Enum.Font.GothamMedium
            namLbl.TextSize=11; namLbl.TextXAlignment=Enum.TextXAlignment.Left
            local togBtn=Instance.new("TextButton",e)
            togBtn.Size=UDim2.fromOffset(70,20); togBtn.Position=UDim2.new(1,-74,0.5,-10)
            togBtn.BorderSizePixel=0; togBtn.AutoButtonColor=false
            togBtn.Font=Enum.Font.GothamBold; togBtn.TextSize=9
            local function refreshTogBtn()
                if isWhitelisted(p) then
                    togBtn.BackgroundColor3=Color3.fromRGB(40,8,8)
                    togBtn.TextColor3=Color3.fromRGB(255,80,80); togBtn.Text="x Quitar"
                    local ts=togBtn:FindFirstChildOfClass("UIStroke")
                    if ts then ts.Color=Color3.fromRGB(100,20,20) else
                        local ns=Instance.new("UIStroke",togBtn); ns.Color=Color3.fromRGB(100,20,20); ns.Thickness=1 end
                else
                    togBtn.BackgroundColor3=Color3.fromRGB(18,14,24)
                    togBtn.TextColor3=accentColor; togBtn.Text="+ Añadir"
                    local ts=togBtn:FindFirstChildOfClass("UIStroke")
                    if ts then ts.Color=accentColor else
                        local ns=Instance.new("UIStroke",togBtn); ns.Color=accentColor; ns.Thickness=1 end
                end
            end
            refreshTogBtn()
            togBtn.MouseButton1Click:Connect(function()
                if isWhitelisted(p) then removeWhitelist(p.Name) else addWhitelist(p.Name) end
                refreshTogBtn(); rebuildWL()
                showNotif("✝  Whitelist", isWhitelisted(p) and ("Added: "..p.Name) or ("Removed: "..p.Name), isWhitelisted(p))
            end)
        end
        -- Actualizar altura del dropdown
        local totalH = plrCount * (WL_ENTRY_H + 2) + 8
        serverDropFrame.Size = UDim2.new(1,0,0,0)
        if serverOpen then
            TweenService:Create(serverDropFrame, TIF, {Size=UDim2.new(1,0,0,totalH)}):Play()
            serverContainer.Size = UDim2.new(1,0,0,totalH)
        end
    end

    -- Toggle dropdown del servidor
    local function toggleServerList()
        serverOpen = not serverOpen
        if serverOpen then
            rebuildServerList()
            local plrCount = 0
            for _,p in ipairs(Players:GetPlayers()) do if p~=player then plrCount=plrCount+1 end end
            local totalH = plrCount * (WL_ENTRY_H + 2) + 8
            serverDropFrame.Visible = true; serverDropFrame.Size=UDim2.new(1,0,0,0)
            TweenService:Create(serverDropFrame, TIF, {Size=UDim2.new(1,0,0,totalH)}):Play()
            serverContainer.Size = UDim2.new(1,0,0,totalH)
            arrowLbl.Text = "^"
        else
            TweenService:Create(serverDropFrame, TIF, {Size=UDim2.new(1,0,0,0)}):Play()
            task.delay(0.25, function() serverDropFrame.Visible=false end)
            serverContainer.Size = UDim2.new(1,0,0,0)
            arrowLbl.Text = "v"
        end
    end

    local hitArea = Instance.new("TextButton", headerRow)
    hitArea.Size=UDim2.new(1,-20,1,0); hitArea.BackgroundTransparency=1; hitArea.Text=""; hitArea.ZIndex=5
    hitArea.MouseButton1Click:Connect(toggleServerList)

    rebuildServerList(); rebuildWL()

    refreshBtn.MouseButton1Click:Connect(function()
        rebuildServerList()
        refreshBtn.Text="OK"; task.delay(0.8, function() refreshBtn.Text=">> Refresh" end)
    end)
    Players.PlayerAdded:Connect(function() rebuildServerList() end)
    Players.PlayerRemoving:Connect(function() task.wait(0.05); rebuildServerList() end)
end
-- ══ EXTRAS PAGE ═══════════════════════════════════════════════
-- (Inf Stamina, Item en la Mano, Health Bar, Distancia — copiado de SyyClient)
-- ── INF STAMINA (lógica completa de SyyClient) ────────────────
local extrasCard = makeCard(pg_extras)
makeSecHeader(extrasCard, "+", "Extras")
makeDivider(extrasCard)

do
    -- Inf Stamina
    local staminaConns = {}
    local staminaWatched = {}
    local staminaKeys = {"stamina","sprint","energy","endur","breath"}
    local staminaLoop = false

    local function isStaminaName(name)
        name = tostring(name or ""):lower()
        for _, key in ipairs(staminaKeys) do
            if name:find(key,1,true) then return true end
        end
        return false
    end
    local function hasStaminaContext(obj)
        local cur = obj
        for _ = 1, 4 do
            if not cur or typeof(cur)~="Instance" then break end
            if isStaminaName(cur.Name) then return true end
            cur = cur.Parent
        end
        return false
    end
    local function isStaminaValue(obj)
        return obj and typeof(obj)=="Instance"
            and (obj:IsA("NumberValue") or obj:IsA("IntValue") or obj:IsA("DoubleConstrainedValue"))
            and hasStaminaContext(obj)
    end
    local function staminaMax(stVal)
        if stVal:IsA("DoubleConstrainedValue") then return stVal.MaxValue end
        return stVal:GetAttribute("MaxStamina") or stVal:GetAttribute("StaminaMax")
            or stVal:GetAttribute("MaxSprint") or stVal:GetAttribute("SprintMax")
            or stVal:GetAttribute("MaxEnergy") or stVal:GetAttribute("EnergyMax")
            or stVal:GetAttribute("Max") or 100
    end
    local function keepStaminaFull(stVal)
        if not isStaminaValue(stVal) then return end
        pcall(function() stVal.Value = staminaMax(stVal) end)
    end
    local function watchStaminaValue(stVal)
        if not isStaminaValue(stVal) or staminaWatched[stVal] then return end
        staminaWatched[stVal]=true
        keepStaminaFull(stVal)
        table.insert(staminaConns, stVal.Changed:Connect(function() keepStaminaFull(stVal) end))
    end
    local function keepStaminaAttributes(obj)
        if not obj or typeof(obj)~="Instance" then return end
        pcall(function()
            for attr, val in pairs(obj:GetAttributes()) do
                local attrLower=tostring(attr):lower()
                if type(val)=="number" and (isStaminaName(attr) or (hasStaminaContext(obj) and attrLower=="value"))
                and not attrLower:find("max",1,true) then
                    local maxVal=obj:GetAttribute("Max"..attr) or obj:GetAttribute(attr.."Max")
                        or obj:GetAttribute("MaxStamina") or obj:GetAttribute("StaminaMax") or 100
                    obj:SetAttribute(attr, maxVal)
                end
            end
        end)
    end
    local function watchStaminaAttributes(obj)
        if not obj or typeof(obj)~="Instance" then return end
        keepStaminaAttributes(obj)
        pcall(function()
            for attr, val in pairs(obj:GetAttributes()) do
                local attrLower=tostring(attr):lower()
                if type(val)=="number" and (isStaminaName(attr) or (hasStaminaContext(obj) and attrLower=="value"))
                and not attrLower:find("max",1,true) then
                    table.insert(staminaConns, obj:GetAttributeChangedSignal(attr):Connect(function()
                        keepStaminaAttributes(obj)
                    end))
                end
            end
        end)
    end
    local function scanStamina(container)
        if not container then return end
        watchStaminaValue(container); watchStaminaAttributes(container)
        pcall(function()
            for _, desc in ipairs(container:GetDescendants()) do
                watchStaminaValue(desc)
                if desc:IsA("Humanoid") or isStaminaName(desc.Name) then watchStaminaAttributes(desc) end
            end
        end)
    end
    local function watchStaminaContainer(container)
        if not container then return end
        scanStamina(container)
        table.insert(staminaConns, container.DescendantAdded:Connect(function(desc)
            watchStaminaValue(desc)
            if desc:IsA("Humanoid") or isStaminaName(desc.Name) then watchStaminaAttributes(desc) end
        end))
    end
    local staminaMetaHooked=false
    local function installStaminaMetaHook()
        if staminaMetaHooked then return end; staminaMetaHooked=true
        pcall(function()
            if not hookmetamethod then return end
            local oldNewIndex
            oldNewIndex=hookmetamethod(game,"__newindex",function(self,key,value)
                if S.InfStamina and key=="Value" and type(value)=="number" and isStaminaValue(self) then
                    local maxVal=staminaMax(self)
                    if value<maxVal then return oldNewIndex(self,key,maxVal) end
                end
                return oldNewIndex(self,key,value)
            end)
        end)
    end
    local function disconnectStamina()
        staminaLoop=false
        for _,c in ipairs(staminaConns) do pcall(function() c:Disconnect() end) end
        staminaConns={}; staminaWatched={}
    end
    local function hookStamina(char)
        if not char then return end
        installStaminaMetaHook(); staminaLoop=true
        watchStaminaContainer(char); watchStaminaContainer(player)
        task.spawn(function()
            while staminaLoop and S.InfStamina do
                pcall(function()
                    local c2=player.Character; if not c2 then return end
                    if game.PlaceId==455366377 then watchStaminaValue(c2:FindFirstChild("Stamina",true)) end
                    for stVal in pairs(staminaWatched) do keepStaminaFull(stVal) end
                    local hum=c2:FindFirstChildOfClass("Humanoid")
                    if hum then keepStaminaAttributes(hum) end
                    keepStaminaAttributes(c2)
                end)
                task.wait(0.05)
            end
        end)
        if game.PlaceId==455366377 then
            local stVal=char:WaitForChild("Stamina",4)
            watchStaminaValue(stVal)
            table.insert(staminaConns, char.ChildAdded:Connect(function(child)
                if child.Name=="Stamina" then watchStaminaValue(child) end
            end))
        end
    end

    makeToggle(extrasCard, "ext_inf_stamina", "ext_inf_stamina_d", "InfStamina", function(on)
        if on then hookStamina(player.Character)
        else disconnectStamina() end
    end)
    player.CharacterAdded:Connect(function(char)
        if not S.InfStamina then return end
        disconnectStamina(); task.wait(0.5); hookStamina(char)
    end)
    task.defer(function()
        if S.InfStamina then hookStamina(player.Character or player.CharacterAdded:Wait()) end
    end)
end

makeDivider(extrasCard)

-- Health Bar Drawing
makeToggle(extrasCard, "ext_health_bar", "ext_health_bar_d", "EspHealthBar")
makeDivider(extrasCard)

-- Distance Drawing
makeToggle(extrasCard, "ext_distance",  "ext_distance_d",  "EspDistance")
makeDivider(extrasCard)

-- Item in Hand Drawing
makeToggle(extrasCard, "ext_item_hand", "ext_item_hand_d", "ItemInHand")

-- ══ AJUSTES PAGE ══════════════════════════════════
local cfgCard = makeCard(pg_ajustes)
makeSecHeader(cfgCard, "†", "Settings")

makeDivider(cfgCard)

secLabel(cfgCard, "· · · DISPLAY · · ·")
makeToggle(cfgCard, "st_bg", nil, "panel_bg", function(on)
    panel.BackgroundTransparency = on and 0 or 0.15
end)
makeDivider(cfgCard)
makeToggle(cfgCard, "st_notif", nil, "notifs")
makeDivider(cfgCard)
makeToggle(cfgCard, "st_stream", "st_stream_d", "stream_mode", function(on)
    applyStreamMode(on)
end)

secLabel(cfgCard, "· · · LANGUAGE · · ·")
makeDropdown(cfgCard, "st_lang", "lang", {"English","Español"}, function(opt)
    refreshLang()
    showNotif("Language", opt, true)
end)

secLabel(cfgCard, "· · · KEYBINDS · · ·")
local keyCard2 = makeCard(cfgCard)
makeKeybind(keyCard2, "st_key", "gui_key")
makeDivider(keyCard2)
makeResetBtn(keyCard2, "st_r1", "st_r1_d", function()
    S.gui_key = "L"; if refreshers["gui_key"] then refreshers["gui_key"]() end; save()
end)
makeDivider(keyCard2)
makeResetBtn(keyCard2, "st_r2", "st_r2_d", function()
    S.esp_key="T"; S.hbx_key="G"; S.gui_key="L"
    for k, fn in pairs(refreshers) do if k:find("_key") then fn() end end; save()
end)

secLabel(cfgCard, "· · · COLORES · · ·")
-- Color Global (accent de la GUI)
local guiColorRow, guiColorPop = makeColorPicker(cfgCard, "GUI Accent Color",
    function() return math.floor(accentColor.R*255) end,
    function() return math.floor(accentColor.G*255) end,
    function() return math.floor(accentColor.B*255) end,
    function(r,g,b) applyAccent(Color3.fromRGB(r,g,b)) end
)

-- Activar página 1 por defecto
setPage = setPage  -- referencia correcta (definida arriba con forward)
pages[1].Visible = true
navBtns[1].BackgroundColor3 = Color3.fromRGB(36,30,46)
navBtns[1].BackgroundTransparency = 0.5
local ns1 = navBtns[1]:FindFirstChildOfClass("UIStroke")
if ns1 then ns1.Color = accentColor end
for _, ch in ipairs(navBtns[1]:GetChildren()) do
    if ch:IsA("TextLabel") then ch.TextColor3 = Color3.fromRGB(239,239,239) end
end

-- Expose tabPages alias para compatibilidad con keybinds toggle
local tabPages = {pages[1], pages[2], pages[3], pages[4]}  -- dummy, no se usa con tabs

-- ══════════════════════════════════════════════
--  DRAG — mover panel (por el header)
-- ══════════════════════════════════════════════
do
    local drag, dragStart = false, nil
    local panelAbsStart = nil

    local dh = Instance.new("TextButton", header)
    dh.Size = UDim2.new(1, -30, 1, 0); dh.BackgroundTransparency = 1; dh.Text = ""
    dh.ZIndex = 5

    dh.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 then
            drag = true
            dragStart = inp.Position
            -- Capturar posición absoluta actual del panel (independiente de Scale)
            panelAbsStart = panel.AbsolutePosition
            -- Convertir a posición pura por offset (Scale=0) para que el drag sea estable
            panel.Position = UDim2.fromOffset(panelAbsStart.X, panelAbsStart.Y)
            glow.Position  = UDim2.fromOffset(panelAbsStart.X - 10, panelAbsStart.Y - 10)
        end
    end)

    UserInputService.InputEnded:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 then drag = false end
    end)

    UserInputService.InputChanged:Connect(function(inp)
        if drag and inp.UserInputType == Enum.UserInputType.MouseMovement then
            local d   = inp.Position - dragStart
            local sc  = gui.AbsoluteSize
            local newX = math.clamp(panelAbsStart.X + d.X, 0, sc.X - GW)
            local newY = math.clamp(panelAbsStart.Y + d.Y, 0, sc.Y - GH)
            panel.Position = UDim2.fromOffset(newX, newY)
            glow.Position  = UDim2.fromOffset(newX - 10, newY - 10)
        end
    end)
end



-- ══════════════════════════════════════════════
--  CHARACTER ESP — Highlight por partes + Avatar
-- ══════════════════════════════════════════════
-- (espObjects ya fue declarado arriba, antes de los toggles del ESP)

local BODY_PARTS = {"Head","Torso","UpperTorso","LowerTorso","LeftArm","RightArm",
    "LeftLeg","RightLeg","LeftUpperArm","LeftLowerArm","LeftHand",
    "RightUpperArm","RightLowerArm","RightHand","LeftUpperLeg","LeftLowerLeg",
    "LeftFoot","RightUpperLeg","RightLowerLeg","RightFoot","HumanoidRootPart"}

local HAS_DRAWING = type(Drawing) == "table" and type(Drawing.new) == "function"
local function newDrawingFallback()
    return {
        Visible = false,
        Remove = function() end,
    }
end

local _rainbowHue = 0
local function getEspColor()
    if S.esp_rainbow then
        return Color3.fromHSV(_rainbowHue, 1, 1)
    end
    return Color3.fromRGB(S.esp_char_r, S.esp_char_g, S.esp_char_b)
end

-- Crea/actualiza Highlight aura RGB en el modelo del enemigo (un solo Highlight por personaje)
local function applyHighlights(obj, char, isVis)
    if not char then return end
    local col = getEspColor()
    -- Color invertido/complementario para cuando está detrás de pared
    local hidCol = Color3.fromRGB(255 - col.R*255, 255 - col.G*255, 255 - col.B*255)
    local finalCol = isVis and col or hidCol
    if not obj.highlights["_main"] then
        local hl = Instance.new("Highlight")
        hl.FillColor = finalCol
        hl.OutlineColor = finalCol
        hl.FillTransparency = isVis and 0.55 or 0.75
        hl.OutlineTransparency = isVis and 0.0 or 0.2
        hl.Adornee = char
        hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        hl.Parent = gui
        obj.highlights["_main"] = hl
    else
        local hl = obj.highlights["_main"]
        hl.FillColor = finalCol
        hl.OutlineColor = finalCol
        hl.FillTransparency = isVis and 0.55 or 0.75
        hl.OutlineTransparency = isVis and 0.0 or 0.2
        hl.Adornee = char
        hl.Enabled = S.esp_on
    end
end

-- Nombre como BillboardGui con tamaño fijo y SizeOffset en mundo (no escala con distancia)
local function createNameBillboard(p, char)
    if not char then return nil end
    local head = char:FindFirstChild("Head"); if not head then return nil end
    local bb = Instance.new("BillboardGui")
    bb.Name = "x7sName_"..p.Name
    bb.Size = UDim2.fromOffset(110, 18)
    bb.StudsOffsetWorldSpace = Vector3.new(0, 2.0, 0)
    bb.AlwaysOnTop = true; bb.ResetOnSpawn = false
    bb.LightInfluence = 0
    bb.Adornee = head; bb.Parent = gui
    bb.Enabled = false

    local nameLbl = Instance.new("TextLabel", bb)
    nameLbl.Name = "NameLbl"
    nameLbl.Size = UDim2.new(1, 0, 1, 0)
    nameLbl.BackgroundTransparency = 1
    nameLbl.Text = p.Name
    nameLbl.TextColor3 = Color3.fromRGB(230, 220, 245)
    nameLbl.Font = Enum.Font.GothamBold
    nameLbl.TextSize = 11
    nameLbl.TextXAlignment = Enum.TextXAlignment.Center
    nameLbl.TextStrokeTransparency = 0.4
    nameLbl.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    return bb
end

-- Avatar BillboardGui con tamaño fijo (no escala con distancia)
local function createAvatarBillboard(p, char)
    if not char then return nil end
    local head = char:FindFirstChild("Head"); if not head then return nil end
    local bb = Instance.new("BillboardGui")
    bb.Name = "x7sESP_"..p.Name
    bb.Size = UDim2.fromOffset(34, 34)
    bb.StudsOffsetWorldSpace = Vector3.new(0, 3.8, 0)
    bb.AlwaysOnTop = true; bb.ResetOnSpawn = false
    bb.LightInfluence = 0
    bb.Adornee = head; bb.Parent = gui
    bb.Enabled = false

    local bg = Instance.new("Frame", bb)
    bg.Size = UDim2.new(1, 0, 1, 0)
    bg.BackgroundColor3 = Color3.fromRGB(6, 5, 10)
    bg.BackgroundTransparency = 0.1; bg.BorderSizePixel = 0
    Instance.new("UICorner", bg).CornerRadius = UDim.new(1, 0)
    local bgStroke = Instance.new("UIStroke", bg)
    bgStroke.Name = "AvatarStroke"
    bgStroke.Color = getEspColor(); bgStroke.Transparency = 0.1; bgStroke.Thickness = 1.5

    local avatarImg = Instance.new("ImageLabel", bg)
    avatarImg.Name = "AvatarImg"
    avatarImg.Size = UDim2.new(1, -4, 1, -4)
    avatarImg.Position = UDim2.fromOffset(2, 2)
    avatarImg.BackgroundTransparency = 1
    avatarImg.Image = "https://www.roblox.com/headshot-thumbnail/image?userId="..p.UserId.."&width=150&height=150&format=png"
    avatarImg.ScaleType = Enum.ScaleType.Fit
    Instance.new("UICorner", avatarImg).CornerRadius = UDim.new(1, 0)

    return bb
end

local function newLine()
    if not HAS_DRAWING then return newDrawingFallback() end
    local l = Drawing.new("Line"); l.Visible = false; l.Thickness = 1.5
    l.Color = getEspColor(); return l
end
local function newText()
    if not HAS_DRAWING then return newDrawingFallback() end
    local t = Drawing.new("Text"); t.Visible = false; t.Size = 13
    t.Color = Color3.fromRGB(200, 190, 220); t.Outline = true
    t.OutlineColor = Color3.fromRGB(0, 0, 0); return t
end
local function newBox()
    if not HAS_DRAWING then return newDrawingFallback() end
    local b = Drawing.new("Square"); b.Visible = false; b.Filled = false
    b.Thickness = 1.5; b.Color = getEspColor(); return b
end

-- Crea una SelectionBox 3D para el hitbox visual (caja con color del ESP)
local function createSelectionBox3D(char)
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if not root then return nil end
    local sb = Instance.new("SelectionBox")
    sb.Name          = "x7sHbxBox"
    -- El Adornee se actualizará en el render loop cuando el proxy esté listo
    sb.Color3        = getEspColor()
    sb.LineThickness = 0.04
    sb.SurfaceTransparency = 0.85
    sb.SurfaceColor3 = getEspColor()
    sb.Visible       = false
    sb.Parent        = gui  -- parenting a gui lo hace AlwaysOnTop
    return sb
end

-- SelectionBox independiente: siempre visible sin importar si el jugador está oculto
local function createSelectionBox3D_always(char)
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if not root then return nil end
    local sb = Instance.new("SelectionBox")
    sb.Name          = "x7sHbxBox2"
    sb.Color3        = Color3.fromRGB(255, 200, 0)   -- amarillo por defecto para distinguirla
    sb.LineThickness = 0.05
    sb.SurfaceTransparency = 0.88
    sb.SurfaceColor3 = Color3.fromRGB(255, 200, 0)
    sb.Visible       = false
    sb.Parent        = gui
    return sb
end

local function newFilledRect()
    if not HAS_DRAWING then return newDrawingFallback() end
    local r = Drawing.new("Square"); r.Visible=false; r.Filled=true; r.Thickness=1; return r
end
local function newSmallText(sz)
    if not HAS_DRAWING then return newDrawingFallback() end
    local t = Drawing.new("Text"); t.Visible=false; t.Size=sz or 11; t.Outline=true
    t.OutlineColor=Color3.fromRGB(0,0,0); return t
end

local function createEspObj(p)
    if p == player then return end
    -- SelectionBox 3D real para Show Hitbox
    local selBox3D = nil
    local selBox3D2 = nil
    if p.Character then
        selBox3D = createSelectionBox3D(p.Character)
        selBox3D2 = createSelectionBox3D_always(p.Character)
    end
    espObjects[p] = {
        highlights   = {},
        billboard    = nil,   -- avatar billboard
        nameBillboard = nil,  -- nombre billboard
        box    = newBox(),
        name   = newText(),
        line   = newLine(),
        hbx    = newBox(),
        selBox = selBox3D,   -- SelectionBox 3D Instance (puede ser nil si sin Drawing)
        selBox2 = selBox3D2, -- SelectionBox independiente (siempre visible)
        -- EXTRAS: Health Bar, Distance, Item in Hand
        healthBg  = newFilledRect(),
        healthBar = newFilledRect(),
        distTag   = newSmallText(11),
        itemTag   = newSmallText(11),
    }
    if p.Character then
        espObjects[p].billboard     = createAvatarBillboard(p, p.Character)
        espObjects[p].nameBillboard = createNameBillboard(p, p.Character)
    end
    p.CharacterAdded:Connect(function(char)
        local obj2 = espObjects[p]; if not obj2 then return end
        for _, hl in pairs(obj2.highlights) do pcall(function() hl:Destroy() end) end
        obj2.highlights = {}
        if obj2.billboard then obj2.billboard:Destroy(); obj2.billboard = nil end
        if obj2.nameBillboard then obj2.nameBillboard:Destroy(); obj2.nameBillboard = nil end
        -- Destruir la SelectionBox anterior y crear una nueva
        if obj2.selBox and typeof(obj2.selBox) == "Instance" then
            obj2.selBox:Destroy(); obj2.selBox = nil
        end
        if obj2.selBox2 and typeof(obj2.selBox2) == "Instance" then
            obj2.selBox2:Destroy(); obj2.selBox2 = nil
        end
        task.wait(0.5)
        if espObjects[p] then
            espObjects[p].billboard     = createAvatarBillboard(p, char)
            espObjects[p].nameBillboard = createNameBillboard(p, char)
            espObjects[p].selBox        = createSelectionBox3D(char)
            espObjects[p].selBox2       = createSelectionBox3D_always(char)
        end
    end)
end
local function removeEspObj(p)
    local obj = espObjects[p]; if not obj then return end
    for _, hl in pairs(obj.highlights) do pcall(function() hl:Destroy() end) end
    if obj.billboard then obj.billboard:Destroy() end
    if obj.nameBillboard then obj.nameBillboard:Destroy() end
    -- SelectionBox es una Instance, no un Drawing
    if obj.selBox and typeof(obj.selBox) == "Instance" then
        pcall(function() obj.selBox:Destroy() end)
    elseif obj.selBox and obj.selBox.Remove then
        pcall(function() obj.selBox:Remove() end)
    end
    if obj.selBox2 and typeof(obj.selBox2) == "Instance" then
        pcall(function() obj.selBox2:Destroy() end)
    end
    obj.box:Remove(); obj.name:Remove(); obj.line:Remove(); obj.hbx:Remove()
    -- EXTRAS drawings
    if obj.healthBg  and obj.healthBg.Remove  then pcall(function() obj.healthBg:Remove()  end) end
    if obj.healthBar and obj.healthBar.Remove  then pcall(function() obj.healthBar:Remove() end) end
    if obj.distTag   and obj.distTag.Remove    then pcall(function() obj.distTag:Remove()   end) end
    if obj.itemTag   and obj.itemTag.Remove    then pcall(function() obj.itemTag:Remove()   end) end
    espObjects[p] = nil
end
for _, p in ipairs(Players:GetPlayers()) do createEspObj(p) end
Players.PlayerAdded:Connect(createEspObj)
Players.PlayerRemoving:Connect(removeEspObj)

-- (_hbxOriginals declarado al inicio del script)

-- ══════════════════════════════════════════════
--  STREAM MODE — implementación real (aquí panel, glow y espObjects ya existen)
-- ══════════════════════════════════════════════
applyStreamMode = function(on)
    on = on and true or false
    if streamModeOn == on then return end
    streamModeOn = on
    S.stream_mode = on
    if on then
        -- Guardar y desactivar
        streamSaved.esp_on     = S.esp_on
        streamSaved.esp_avatar = S.esp_avatar
        streamSaved.esp_names  = S.esp_names
        streamSaved.esp_lines  = S.esp_lines
        S.esp_on = false; S.esp_avatar = false; S.esp_names = false; S.esp_lines = false
        -- Ocultar GUI completa
        panel.Visible = false; glow.Visible = false
        -- Ocultar todos los ESP inmediatamente
        if espObjects then
            for _, obj in pairs(espObjects) do
                for _, hl in pairs(obj.highlights) do pcall(function() hl.Enabled = false end) end
                if obj.billboard     then obj.billboard.Enabled     = false end
                if obj.nameBillboard then obj.nameBillboard.Enabled = false end
                obj.line.Visible = false; obj.hbx.Visible = false
                if obj.selBox then obj.selBox.Visible = false end
                -- EXTRAS
                if obj.healthBg  then obj.healthBg.Visible  = false end
                if obj.healthBar then obj.healthBar.Visible = false end
                if obj.distTag   then obj.distTag.Visible   = false end
                if obj.itemTag   then obj.itemTag.Visible   = false end
            end
        end
    else
        -- Restaurar
        if streamSaved.esp_on    ~= nil then S.esp_on     = streamSaved.esp_on    end
        if streamSaved.esp_avatar ~= nil then S.esp_avatar = streamSaved.esp_avatar end
        if streamSaved.esp_names  ~= nil then S.esp_names  = streamSaved.esp_names  end
        if streamSaved.esp_lines  ~= nil then S.esp_lines  = streamSaved.esp_lines  end
        -- Mostrar GUI con animación
        panel.Visible = true; glow.Visible = true
        panel.BackgroundTransparency = 1
        TweenService:Create(panel, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {BackgroundTransparency=0}):Play()
        TweenService:Create(glow,  TweenInfo.new(0.2), {BackgroundTransparency=0.93}):Play()
    end
    -- Actualizar toggles visuales en la GUI
    if refreshers["esp_on"]      then refreshers["esp_on"]()      end
    if refreshers["esp_avatar"]  then refreshers["esp_avatar"]()  end
    if refreshers["esp_names"]   then refreshers["esp_names"]()   end
    if refreshers["esp_lines"]   then refreshers["esp_lines"]()   end
    if refreshers["stream_mode"] then refreshers["stream_mode"]() end
    save()
end


--  Devuelve true si el enemigo NO está tapado por
--  geometría del mundo (paredes, suelo, etc.)
-- ══════════════════════════════════════════════
local function isVisible(targetRoot, myChar)
    if not targetRoot or not myChar then return false end
    local origin = camera.CFrame.Position
    local target = targetRoot.Position
    local direction = (target - origin)
    local dist = direction.Magnitude
    if dist > 2000 then return false end

    -- Intentar primero con GetPartsObscuringTarget (más fiable con hitboxes expandidas)
    local ok, obs = pcall(function()
        return camera:GetPartsObscuringTarget({target}, {myChar, targetRoot.Parent})
    end)
    if ok then
        return #obs == 0
    end

    -- Fallback: raycast excluyendo el personaje local Y el modelo enemigo completo
    local rcParams = RaycastParams.new()
    rcParams.FilterType = Enum.RaycastFilterType.Exclude
    local excludeList = {myChar, targetRoot.Parent}
    -- Excluir también cada parte del enemigo para evitar colisión con hitbox expandida
    for _, part in ipairs(targetRoot.Parent:GetDescendants()) do
        if part:IsA("BasePart") then
            table.insert(excludeList, part)
        end
    end
    rcParams.FilterDescendantsInstances = excludeList

    local result = Workspace:Raycast(origin, direction.Unit * dist, rcParams)
    if result == nil then return true end
    return result.Distance >= dist - 0.5
end

applyHitbox = function(p, on)
    if not p.Character then return end
    local root = p.Character:FindFirstChild("HumanoidRootPart"); if not root then return end

    if on then
        -- NO tocar root.Size (congela al jugador)
        -- Crear un Part proxy invisible soldado al root
        if not _hbxOriginals[p] then
            _hbxOriginals[p] = { proxy = nil, weld = nil }

            local s = S.hbx_size * 2
            local proxy = Instance.new("Part")
            proxy.Name = "x7sHitboxProxy"
            proxy.Shape = Enum.PartType.Block
            proxy.Size = Vector3.new(s, s, s)
            proxy.CanCollide = false  -- No colisiona (es principalmente visual)
            proxy.CanQuery = true     -- Detectable por raycast
            proxy.CFrame = root.CFrame
            proxy.Transparency = 1  -- invisible
            proxy.Massless = true
            proxy.TopSurface = Enum.SurfaceType.Smooth
            proxy.BottomSurface = Enum.SurfaceType.Smooth
            proxy.Parent = p.Character

            local weld = Instance.new("Weld")
            weld.Name = "x7sHbxWeld"
            weld.Part0 = root
            weld.Part1 = proxy
            weld.C0 = CFrame.new(0, 0, 0)
            weld.Parent = root

            _hbxOriginals[p].proxy = proxy
            _hbxOriginals[p].weld = weld
        end
    else
        if _hbxOriginals[p] then
            if _hbxOriginals[p].proxy then
                pcall(function() _hbxOriginals[p].proxy:Destroy() end)
            end
            if _hbxOriginals[p].weld then
                pcall(function() _hbxOriginals[p].weld:Destroy() end)
            end
            _hbxOriginals[p] = nil
        end
    end
end

-- ══════════════════════════════════════════════
--  PLAYER LIST actualizada
-- ══════════════════════════════════════════════
local _plrList = Players:GetPlayers()
Players.PlayerAdded:Connect(function()    _plrList = Players:GetPlayers() end)
Players.PlayerRemoving:Connect(function() task.defer(function() _plrList = Players:GetPlayers() end) end)

-- ══════════════════════════════════════════════
--  RENDER LOOP
-- ══════════════════════════════════════════════
local _frame = 0
RunService.RenderStepped:Connect(function()
    local _ok, _err = pcall(function()
    _frame = _frame + 1
    -- Avanzar el hue del arcoíris cada frame
    if S.esp_rainbow then
        _rainbowHue = (_rainbowHue + 0.004) % 1
    end
    local myChar = player.Character
    local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
    local vpSize = camera.ViewportSize
    local mousePos = UserInputService:GetMouseLocation()
    local now = tick()

    -- Aplicar hitbox solo al activar/desactivar (no cada frame para evitar Player:Move error)
    -- La lógica de "activar si hbx_on, desactivar si no" se gestiona por los keybinds y toggles
    -- Aquí solo nos aseguramos de que jugadores nuevos tengan hitbox si está activo
    if _frame % 30 == 0 and S.hbx_on then
        for _, p in ipairs(_plrList) do
            if p ~= player and p.Character and not _hbxOriginals[p] then
                applyHitbox(p, true)
            end
        end
    end

    if _frame % 2 ~= 0 then return end
    for p, obj in pairs(espObjects) do
        -- BUGFIX: Validar jugador existe y aplicar whitelist
        if shouldSkipPlayer(p) then
            -- Ocultar ESP del jugador en whitelist
            for _, hl in pairs(obj.highlights) do pcall(function() hl.Enabled = false end) end
            if obj.billboard     then obj.billboard.Enabled     = false end
            if obj.nameBillboard then obj.nameBillboard.Enabled = false end
            obj.line.Visible = false
            obj.hbx.Visible = false
            if obj.selBox then obj.selBox.Visible = false end
            if obj.selBox2 then obj.selBox2.Visible = false end
            if obj.healthBg  then obj.healthBg.Visible  = false end
            if obj.healthBar then obj.healthBar.Visible = false end
            if obj.distTag   then obj.distTag.Visible   = false end
            if obj.itemTag   then obj.itemTag.Visible   = false end
            continue
        end

        local char = p.Character
        local function allOff()
            for _, hl in pairs(obj.highlights) do pcall(function() hl.Enabled = false end) end
            if obj.billboard      then obj.billboard.Enabled      = false end
            if obj.nameBillboard  then obj.nameBillboard.Enabled  = false end
            obj.line.Visible = false
            obj.hbx.Visible  = false
            if obj.selBox then obj.selBox.Visible = false end
            -- EXTRAS
            if obj.healthBg  then obj.healthBg.Visible  = false end
            if obj.healthBar then obj.healthBar.Visible = false end
            if obj.distTag   then obj.distTag.Visible   = false end
            if obj.itemTag   then obj.itemTag.Visible   = false end
        end
        if not char then allOff(); continue end
        local root = char:FindFirstChild("HumanoidRootPart")
        local hum  = char:FindFirstChildOfClass("Humanoid")
        if not root or not hum or hum.Health <= 0 then allOff(); continue end

        -- ▸ Highlight aura (a través de paredes) — color cambia si está detrás de pared
        if S.esp_on and not streamModeOn then
            local isVis = myChar and isVisible(root, myChar)
            applyHighlights(obj, char, isVis)
            for _, hl in pairs(obj.highlights) do
                pcall(function() hl.Enabled = true end)
            end
        else
            for _, hl in pairs(obj.highlights) do
                pcall(function() hl.Enabled = false end)
            end
        end

        -- ▸ Ajustar tamaño de hitbox según Visible Check (dinámico cada frame)
        if S.hbx_on and S.hbx_vis_check and _hbxOriginals[p] and _hbxOriginals[p].proxy then
            local isVis2 = myChar and isVisible(root, myChar)
            local targetSize = isVis2 
                and (S.hbx_size * 2)      -- Expandido si está visible
                or  2                      -- Normal si está detrás de pared

            pcall(function()
                local currentSize = _hbxOriginals[p].proxy.Size.X
                if math.abs(currentSize - targetSize) > 0.1 then
                    _hbxOriginals[p].proxy.Size = Vector3.new(targetSize, targetSize, targetSize)
                end
                -- CanCollide siempre false para que puedas pasar (tamaño visual indica estado)
                _hbxOriginals[p].proxy.CanCollide = false
            end)
        end

        -- ▸ Nombre encima del personaje — color dinámico si está detrás de pared
        if obj.nameBillboard then
            local showName = S.esp_on and S.esp_names and not streamModeOn
            obj.nameBillboard.Enabled = showName
            if showName then
                local nameLbl = obj.nameBillboard:FindFirstChild("NameLbl")
                if nameLbl then
                    -- Si hbx_vis_check activo, cambiar color cuando está detrás de pared
                    if S.hbx_vis_check then
                        local isVis3 = myChar and isVisible(root, myChar)
                        nameLbl.TextColor3 = isVis3 
                            and getEspColor()                           -- Color normal si visible
                            or  Color3.fromRGB(220, 80, 80)             -- Rojo si detrás de pared
                    else
                        nameLbl.TextColor3 = getEspColor()
                    end
                end
            end
        end

        -- ▸ Avatar — solo si esp_on Y esp_avatar, color dinámico si está detrás de pared
        if obj.billboard then
            local showAv = S.esp_on and S.esp_avatar and not streamModeOn
            obj.billboard.Enabled = showAv
            if showAv then
                local bg2 = obj.billboard:FindFirstChildOfClass("Frame")
                if bg2 then
                    local st = bg2:FindFirstChild("AvatarStroke")
                    if st then
                        -- Si hbx_vis_check activo, cambiar color cuando está detrás de pared
                        if S.hbx_vis_check then
                            local isVis4 = myChar and isVisible(root, myChar)
                            st.Color = isVis4 
                                and getEspColor()                           -- Color normal si visible
                                or  Color3.fromRGB(220, 80, 80)             -- Rojo si detrás de pared
                        else
                            st.Color = getEspColor()
                        end
                    end
                end
            end
        end

        -- ▸ Drawing: posición en pantalla
        local sp, onS = camera:WorldToViewportPoint(root.Position)
        local sp2 = Vector2.new(sp.X, sp.Y)
        local headPart = char:FindFirstChild("Head")
        local topY = headPart and camera:WorldToViewportPoint(headPart.Position + Vector3.new(0, 0.7, 0)).Y or (sp.Y - 40)
        local height = math.abs(sp2.Y - topY) * 2.2

        -- ESP Lines — requiere Drawing
        if S.esp_on and S.esp_lines and onS and HAS_DRAWING then
            obj.line.Visible   = true
            obj.line.Color     = getEspColor()
            obj.line.Thickness = 1.5
            obj.line.From      = Vector2.new(vpSize.X / 2, vpSize.Y - 2)
            obj.line.To        = sp2
        else
            obj.line.Visible = false
        end

        -- Show Hitbox: SelectionBox 3D real con color del ESP (apunta al proxy, no al root)
        if obj.selBox and typeof(obj.selBox) == "Instance" then
            if S.hbx_on and S.hbx_show and onS and _hbxOriginals[p] and _hbxOriginals[p].proxy then
                local isVis2 = myChar and isVisible(root, myChar)
                -- visible check solo cambia el COLOR de la caja (rojo = detrás de pared)
                local col3d = (S.hbx_vis_check and not isVis2)
                    and Color3.fromRGB(220, 80, 80)
                    or  getEspColor()
                -- Apuntar a la parte proxy (el hitbox invisible)
                obj.selBox.Adornee       = _hbxOriginals[p].proxy
                obj.selBox.Color3        = col3d
                obj.selBox.SurfaceColor3 = col3d
                obj.selBox.Visible       = true
            else
                obj.selBox.Visible = false
            end
        end

        -- Show Hitbox (Always): SelectionBox independiente, sin visible check
        if obj.selBox2 and typeof(obj.selBox2) == "Instance" then
            if S.hbx_on and S.hbx_show2 and _hbxOriginals[p] and _hbxOriginals[p].proxy then
                obj.selBox2.Adornee       = _hbxOriginals[p].proxy
                obj.selBox2.Color3        = Color3.fromRGB(255, 200, 0)
                obj.selBox2.SurfaceColor3 = Color3.fromRGB(255, 200, 0)
                obj.selBox2.Visible       = true
            else
                obj.selBox2.Visible = false
            end
        end

        -- ▸ EXTRAS: Health Bar (Drawing) — igual a SyyClient
        local myRoot2 = myChar and myChar:FindFirstChild("HumanoidRootPart")
        local dist3D  = myRoot2 and (root.Position - myRoot2.Position).Magnitude or 0
        local headPart2 = char:FindFirstChild("Head")
        local footPart  = char:FindFirstChild("LeftFoot") or root

        if onS and headPart2 and footPart and HAS_DRAWING then
            local topSP  = Vector2.new(camera:WorldToViewportPoint(headPart2.Position + Vector3.new(0,0.6,0)).X,
                                       camera:WorldToViewportPoint(headPart2.Position + Vector3.new(0,0.6,0)).Y)
            local botSP  = Vector2.new(camera:WorldToViewportPoint(footPart.Position  - Vector3.new(0,0.2,0)).X,
                                       camera:WorldToViewportPoint(footPart.Position  - Vector3.new(0,0.2,0)).Y)
            local boxH   = math.abs(botSP.Y - topSP.Y)
            local boxW   = boxH * 0.45

            -- Health Bar
            local hp = hum.Health / math.max(hum.MaxHealth, 1)
            if S.EspHealthBar and S.esp_on then
                local bx = sp2.X - boxW * 0.5 - 7
                obj.healthBg.Visible   = true
                obj.healthBg.Position  = Vector2.new(bx, topSP.Y)
                obj.healthBg.Size      = Vector2.new(4, boxH)
                obj.healthBg.Color     = Color3.fromRGB(20, 20, 20)
                local barH = boxH * hp
                local r = hp < 0.5 and 255 or math.floor(255*(1-hp)*2)
                local g = hp > 0.5 and 255 or math.floor(255*hp*2)
                obj.healthBar.Visible  = true
                obj.healthBar.Position = Vector2.new(bx, topSP.Y + boxH - barH)
                obj.healthBar.Size     = Vector2.new(4, barH)
                obj.healthBar.Color    = Color3.fromRGB(r, g, 0)
            else
                obj.healthBg.Visible  = false
                obj.healthBar.Visible = false
            end

            -- Distance
            if S.EspDistance and S.esp_on then
                obj.distTag.Visible   = true
                obj.distTag.Text      = math.floor(dist3D) .. "m"
                obj.distTag.Position  = Vector2.new(sp2.X - boxW * 0.5, botSP.Y + 2)
                obj.distTag.Color     = Color3.fromRGB(70, 160, 210)
            else
                obj.distTag.Visible = false
            end

            -- Item in Hand
            if S.ItemInHand and S.esp_on then
                local iname = nil
                for _, v in ipairs(char:GetChildren()) do
                    if v:IsA("Tool") then iname = v.Name; break end
                end
                if iname then
                    obj.itemTag.Visible   = true
                    obj.itemTag.Text      = "[" .. iname .. "]"
                    obj.itemTag.Position  = Vector2.new(sp2.X, topSP.Y - 16)
                    obj.itemTag.Color     = Color3.fromRGB(255, 215, 0)
                else
                    obj.itemTag.Visible = false
                end
            else
                obj.itemTag.Visible = false
            end
        else
            if obj.healthBg  then obj.healthBg.Visible  = false end
            if obj.healthBar then obj.healthBar.Visible = false end
            if obj.distTag   then obj.distTag.Visible   = false end
            if obj.itemTag   then obj.itemTag.Visible   = false end
        end

        obj.hbx.Visible = false
    end
    end)
    if not _ok then
        warn("[x7s] Error en RenderStepped (frame ".._frame.."): ".. tostring(_err))
    end
end)

-- ══════════════════════════════════════════════
--  CAM LOCK (EXACTAMENTE igual a SyyClient)
-- ══════════════════════════════════════════════
local camLockTarget=nil


-- ══════════════════════════════════════════════
--  FOV CIRCLE (igual a SyyClient)
-- ══════════════════════════════════════════════
-- ===============================================================
--  SILENT AIM (migrado de SyyClient - VisibleCheck/Manipulation/HitChance)
-- ===============================================================
local cachedTargetPos = nil

local wallbreakParams = RaycastParams.new()
wallbreakParams.FilterType = Enum.RaycastFilterType.Include
wallbreakParams.FilterDescendantsInstances = {}

-- Hook __namecall: intercepta Raycast / FindPartOnRay* y redirige al objetivo
pcall(function()
    if not hookmetamethod then return end
    local oldNC
    oldNC = hookmetamethod(game, "__namecall", newcclosure(function(...)
        local method = getnamecallmethod()
        local usePos = cachedTargetPos
        if not (S.SilentAimEnabled and usePos) then return oldNC(...) end
        if checkcaller() then return oldNC(...) end
        if math.random(100) > S.HitChance then return oldNC(...) end

        local args = { ... }
        if args[1] ~= workspace then return oldNC(...) end

        if method == "Raycast" then
            if typeof(args[2]) ~= "Vector3" or typeof(args[3]) ~= "Vector3" then return oldNC(...) end
            args[3] = (usePos - args[2]).Unit * 1000
            if S.Manipulation then args[4] = wallbreakParams end
            return oldNC(table.unpack(args))
        elseif method == "FindPartOnRayWithIgnoreList" or method == "FindPartOnRay" then
            if typeof(args[2]) ~= "Ray" then return oldNC(...) end
            local o = args[2].Origin
            args[2] = Ray.new(o, (usePos - o).Unit * 1000)
            if S.Manipulation and method == "FindPartOnRayWithIgnoreList" then args[3] = {} end
            return oldNC(table.unpack(args))
        end
        return oldNC(...)
    end))
end)

-- Deteccion de disparo (PC: click izq / Movil: lado derecho de pantalla)
local saIsFiring = false
UserInputService.InputBegan:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.MouseButton1 then saIsFiring = true
    elseif inp.UserInputType == Enum.UserInputType.Touch then
        if inp.Position.X > camera.ViewportSize.X * 0.35 then saIsFiring = true end
    end
end)
UserInputService.InputEnded:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.MouseButton1
    or inp.UserInputType == Enum.UserInputType.Touch then
        task.delay(0.08, function() saIsFiring = false end)
    end
end)

-- Calculo del objetivo cada 2 frames (misma logica que SyyClient)
local _saFrame = 0
RunService.RenderStepped:Connect(function()
    _saFrame = _saFrame + 1
    if _saFrame % 2 ~= 0 then return end

    if not S.SilentAimEnabled then cachedTargetPos = nil; return end

    local myChar = player.Character
    local vp = camera.ViewportSize
    local center = Vector2.new(vp.X * 0.5, vp.Y * 0.5)
    local fovLimit = streamModeOn and math.huge or S.fov_radius

    -- wallbreakParams solo se refresca si Manipulation esta ON
    if S.Manipulation then
        local chars = {}
        for _, p in ipairs(_plrList) do
            if p ~= player and p.Character then chars[#chars+1] = p.Character end
        end
        wallbreakParams.FilterDescendantsInstances = chars
    end

    local bestD, bestPos = math.huge, nil
    for _, p in ipairs(_plrList) do
        if shouldSkipPlayer(p) then continue end
        local char = p.Character; if not char then continue end
        local hum  = char:FindFirstChildOfClass("Humanoid")
        local root = char:FindFirstChild("HumanoidRootPart")
        if not hum or hum.Health <= 0 or not root then continue end

        local sp2, onS = camera:WorldToViewportPoint(root.Position)
        local d2 = (Vector2.new(sp2.X, sp2.Y) - center).Magnitude

        if S.VisibleCheck then
            if not onS then continue end
            if d2 > fovLimit then continue end
            if not S.Manipulation then
                local ok, obs = pcall(function()
                    return camera:GetPartsObscuringTarget({root.Position}, {myChar, char})
                end)
                if ok and #obs > 0 then continue end
            end
        else
            if not streamModeOn and d2 > fovLimit then continue end
            if not onS then continue end
            if not S.Manipulation then
                local ok, obs = pcall(function()
                    return camera:GetPartsObscuringTarget({root.Position}, {myChar, char})
                end)
                if ok and #obs > 0 then continue end
            end
        end

        if d2 < bestD then
            bestD = d2
            local pn = S.TargetPart
            if pn == "Random" then
                local r = math.random(100)
                pn = r <= 30 and "Head" or (r <= 80 and "UpperTorso" or "LowerTorso")
            elseif pn == "Pierna" then pn = "LowerTorso"
            elseif pn == "Pecho"  then pn = "UpperTorso"
            elseif pn == "Combo"  then
                local r = math.random(100)
                pn = r <= 35 and "LowerTorso" or (r <= 85 and "UpperTorso" or "Head")
            end
            local hp = char:FindFirstChild(pn) or root
            bestPos = hp.Position
        end
    end
    cachedTargetPos = bestPos
end)


local fovCircle = Drawing.new("Circle")
fovCircle.Visible      = false
fovCircle.Thickness    = 1.5
fovCircle.Filled       = false
fovCircle.NumSides     = 64
fovCircle.Color        = Color3.fromRGB(141, 122, 174)  -- morado acento

local function getFovCenter()
    -- Centro de pantalla, igual que SyyClient
    local vp = camera.ViewportSize
    return Vector2.new(vp.X * 0.5, vp.Y * 0.5)
end

local function isInFov(root)
    if not S.fov_on then return true end
    local sp, onScreen = camera:WorldToViewportPoint(root.Position)
    if not onScreen then return false end
    local center = getFovCenter()
    local dx = sp.X - center.X
    local dy = sp.Y - center.Y
    return (dx*dx + dy*dy) <= (S.fov_radius * S.fov_radius)
end

RunService.RenderStepped:Connect(function()
    -- Visible solo cuando fov_visible está ON (independiente del filtro)
    fovCircle.Visible = S.fov_visible
    if S.fov_visible then
        fovCircle.Position = getFovCenter()
        fovCircle.Radius   = S.fov_radius
        -- Morado cuando filtro ON, gris cuando solo visual
        fovCircle.Color = S.fov_on
            and Color3.fromRGB(141, 122, 174)   -- morado
            or  Color3.fromRGB(110, 110, 110)    -- gris
    end
end)


RunService:BindToRenderStep("x7sCamLock", Enum.RenderPriority.Camera.Value+1, function()
    pcall(function()
    if not S.CamLockEnabled then camLockTarget=nil; return end

    local myChar=player.Character
    local myRoot=myChar and myChar:FindFirstChild("HumanoidRootPart")
    local bestRoot=nil; local bestDist=math.huge

    for _,p in ipairs(_plrList) do
        if shouldSkipPlayer(p) then continue end
        local char=p.Character; if not char then continue end
        local hum=char:FindFirstChildOfClass("Humanoid")
        local root=char:FindFirstChild("HumanoidRootPart")
        if not hum or hum.Health<=0 or not root then continue end
        if S.CamLockSafeZone and char:FindFirstChild("SafeZoneShield") then continue end
        local dist3D=myRoot and (root.Position-myRoot.Position).Magnitude or math.huge
        if dist3D>S.CamLockRange then continue end
        if S.CamLockWallCheck and myChar then
            local ok,obs=pcall(function()
                return camera:GetPartsObscuringTarget({root.Position},{myChar,char})
            end)
            if ok and #obs>0 then continue end
        end
        -- FOV check
        if not isInFov(root) then continue end
        if dist3D<bestDist then bestDist=dist3D; bestRoot=root end
    end

    camLockTarget=bestRoot
    if not bestRoot then return end

    local camPos=camera.CFrame.Position
    local targetPos=Vector3.new(bestRoot.Position.X,bestRoot.Position.Y+1.5,bestRoot.Position.Z)
    local rawDir=targetPos-camPos
    if rawDir.Magnitude<0.1 then return end
    local strength=math.clamp(S.CamLockStrength,1,100)*0.003
    local newLook=camera.CFrame.LookVector:Lerp(rawDir.Unit,strength)
    if newLook.Magnitude>0.01 then
        camera.CFrame=CFrame.lookAt(camPos,camPos+newLook.Unit)
    end
    end)
end)


-- ══════════════════════════════════════════════
--  KEYBINDS globales
-- ══════════════════════════════════════════════
UserInputService.InputBegan:Connect(function(inp, proc)
    if proc then return end
    if inp.UserInputType ~= Enum.UserInputType.Keyboard then return end
    local kn = inp.KeyCode.Name

    -- Toggle GUI
    if kn == S.gui_key then
        if streamModeOn then return end  -- No mostrar GUI en stream mode
        if panel.Visible then
            TweenService:Create(panel, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {BackgroundTransparency=1}):Play()
            TweenService:Create(glow,  TweenInfo.new(0.15), {BackgroundTransparency=1}):Play()
            task.delay(0.16, function()
                panel.Visible = false; glow.Visible = false
                panel.BackgroundTransparency = 0; glow.BackgroundTransparency = 0.93
            end)
        else
            panel.Visible = true; glow.Visible = true
            panel.BackgroundTransparency = 1
            TweenService:Create(panel, TweenInfo.new(0.2, Enum.EasingStyle.Back), {BackgroundTransparency=0}):Play()
            TweenService:Create(glow,  TweenInfo.new(0.2), {BackgroundTransparency=0.93}):Play()
        end
        return
    end

    -- Stream Mode (RightAlt)
    if kn == "RightAlt" then
        applyStreamMode(not streamModeOn)
        showNotif("✝  Stream Mode", streamModeOn and L("n_on") or L("n_off"), streamModeOn)
        return
    end

    -- Toggle ESP
    if kn == S.esp_key then
        S.esp_on = not S.esp_on; save()
        if refreshers["esp_on"] then refreshers["esp_on"]() end
        showNotif("✝  ESP", S.esp_on and L("n_on") or L("n_off"), S.esp_on)
        if not S.esp_on then
            for _, obj in pairs(espObjects) do
                for _, hl in pairs(obj.highlights) do pcall(function() hl.Enabled = false end) end
                if obj.billboard     then obj.billboard.Enabled     = false end
                if obj.nameBillboard then obj.nameBillboard.Enabled = false end
                obj.line.Visible = false
                obj.hbx.Visible  = false
                if obj.selBox then obj.selBox.Visible = false end
            end
        end
        return
    end

    -- Toggle Cam Lock
    if kn == S.camlock_key then
        S.CamLockEnabled = not S.CamLockEnabled; save()
        if refreshers["CamLockEnabled"] then refreshers["CamLockEnabled"]() end
        showNotif("✝  Cam Lock", S.CamLockEnabled and L("n_on") or L("n_off"), S.CamLockEnabled)
        return
    end

    -- Toggle Hitbox
    if kn == S.hbx_key then
        S.hbx_on = not S.hbx_on; save()
        if refreshers["hbx_on"] then refreshers["hbx_on"]() end
        -- Si apagamos, destruir proxies y ocultar cajas
        if not S.hbx_on then
            for _, ep in ipairs(Players:GetPlayers()) do
                if ep ~= player and _hbxOriginals[ep] then
                    if _hbxOriginals[ep].proxy then
                        pcall(function() _hbxOriginals[ep].proxy:Destroy() end)
                    end
                    if _hbxOriginals[ep].weld then
                        pcall(function() _hbxOriginals[ep].weld:Destroy() end)
                    end
                    _hbxOriginals[ep] = nil
                end
            end
            for _, obj in pairs(espObjects) do
                obj.hbx.Visible = false
                if obj.selBox then obj.selBox.Visible = false end
                if obj.selBox2 then obj.selBox2.Visible = false end
            end
        end
        showNotif("✝  Hitbox", S.hbx_on and L("n_on") or L("n_off"), S.hbx_on)
        return
    end

end)

player.CharacterAdded:Connect(function()
    task.wait(0.5)
    _hbxOriginals = {}
end)

task.defer(function()
    panel.BackgroundTransparency = S.panel_bg and 0 or 0.15
end)


-- == BOTON FLOTANTE (abrir/cerrar GUI en movil) - drag estable ===
if isMobile then
    local FB_SZ = 54
    local fb = Instance.new("TextButton", gui)
    fb.Name = "x7sToggle"; fb.Size = UDim2.fromOffset(FB_SZ, FB_SZ)
    fb.Position = UDim2.fromOffset(16, math.floor(camera.ViewportSize.Y * 0.4))
    fb.BackgroundColor3 = Color3.fromRGB(12, 9, 18); fb.BorderSizePixel = 0
    fb.Text = "x7s"; fb.TextColor3 = accentColor
    fb.Font = Enum.Font.GothamBlack; fb.TextSize = 15; fb.ZIndex = 250
    fb.AutoButtonColor = false; fb.Active = true
    Instance.new("UICorner", fb).CornerRadius = UDim.new(1, 0)
    local fbs = Instance.new("UIStroke", fb); fbs.Color = accentColor; fbs.Thickness = 1.5; fbs.Transparency = 0.3

    local DRAG_THRESHOLD = 8           -- px antes de considerarlo arrastre (no tap)
    local dragInput, dragStart, startPos, moved = nil, nil, nil, false

    fb.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.Touch
        or inp.UserInputType == Enum.UserInputType.MouseButton1 then
            dragInput = inp
            dragStart = inp.Position
            startPos  = fb.Position       -- UDim2 en offset puro
            moved = false
            fbs.Transparency = 0          -- feedback al presionar
            inp.Changed:Connect(function()
                if dragInput == inp and inp.UserInputState == Enum.UserInputState.End then
                    dragInput = nil
                    fbs.Transparency = 0.3
                    if not moved then
                        -- tap = toggle del panel
                        local show = not panel.Visible
                        panel.Visible = show; glow.Visible = show
                        if show then panel.BackgroundTransparency = 0 end
                    end
                end
            end)
        end
    end)

    -- Sigue el dedo SOLO tras cruzar el umbral (un tap NO mueve la burbuja)
    UserInputService.InputChanged:Connect(function(inp)
        if dragInput ~= inp then return end
        if inp.UserInputType ~= Enum.UserInputType.Touch
       and inp.UserInputType ~= Enum.UserInputType.MouseMovement then return end
        local delta = inp.Position - dragStart
        if not moved then
            if delta.Magnitude < DRAG_THRESHOLD then return end  -- ignora jitter del tap
            moved = true
        end
        local vp = camera.ViewportSize
        fb.Position = UDim2.fromOffset(
            math.clamp(startPos.X.Offset + delta.X, 0, vp.X - FB_SZ),
            math.clamp(startPos.Y.Offset + delta.Y, 0, vp.Y - FB_SZ))
    end)
end

task.spawn(function()
    local remote = game:GetService("ReplicatedStorage").Packages.Networking:WaitForChild("RE/Events/CollectEventSpawnable")
    local folder = workspace:WaitForChild("Spawnables"):WaitForChild("SpawnablesClient")
    while task.wait(0.3) do
        if not S.summer_on then continue end
        for _, spawn in ipairs(folder:GetChildren()) do
            -- Intenta con "Touch", si no existe usa cualquier BasePart del modelo
            local touch = spawn:FindFirstChild("Touch")
                       or spawn:FindFirstChildOfClass("Part")
                       or spawn:FindFirstChildOfClass("MeshPart")
                       or (spawn:IsA("BasePart") and spawn)
            if touch then
                pcall(function()
                    remote:FireServer(touch)
                    spawn:Destroy()
                end)
                task.wait(0.05)
            end
        end
    end
end)