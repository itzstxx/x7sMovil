local RAW_URL = "https://raw.githubusercontent.com/itzstxx/x7s/refs/heads/main/x7s.lua"

local loader = loadstring or load
if type(loader) ~= "function" then
    error("[x7s Loader] Este executor no soporta loadstring/load.", 2)
    return
end

local function getSource(url)
    if game and type(game.HttpGet) == "function" then
        return game:HttpGet(url, true)
    end
    if type(httpget) == "function" then
        return httpget(url)
    end
    if type(HttpGet) == "function" then
        return HttpGet(url)
    end
    error("[x7s Loader] Este executor no soporta game:HttpGet/httpget.", 2)
end

local source do
    local ok, result = pcall(function()
        return getSource(RAW_URL)
    end)
    if not ok or type(result) ~= "string" or #result < 10 then
        error("[x7s Loader] No se pudo descargar NexusV1.\n"..
              "  → URL: "..RAW_URL.."\n"..
              "  → Error: "..tostring(result), 2)
        return
    end
    source = result
end

source = source:gsub("^" .. string.char(0xEF, 0xBB, 0xBF), "")

local fn, compileErr = loader(source, "x7s")
if not fn then
    error("[x7s Loader] Error al compilar:\n  "..tostring(compileErr), 2)
    return
end

local ok2, runtimeErr = pcall(fn)
if not ok2 then
    error("[x7s Loader] Error al ejecutar:\n  "..tostring(runtimeErr), 2)
    return
end

print("[x7s Loader] Cargado — "..game.Players.LocalPlayer.Name)
