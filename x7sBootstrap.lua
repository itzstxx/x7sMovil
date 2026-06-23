local URL = "https://raw.githubusercontent.com/itzstxx/x7s/refs/heads/main/x7s.lua"

local compiler = loadstring or load
if type(compiler) ~= "function" then
    error("[x7s] Tu executor no tiene loadstring/load habilitado.", 2)
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
    error("[x7s] Tu executor no tiene game:HttpGet/httpget disponible.", 2)
end

local okGet, source = pcall(getSource, URL)
if not okGet then
    error("[x7s] Error descargando el script:\n" .. tostring(source), 2)
    return
end

if type(source) ~= "string" or #source < 100 then
    error("[x7s] La descarga no devolvio codigo valido. Tipo: " .. typeof(source) .. " Largo: " .. tostring(#tostring(source)), 2)
    return
end

source = source:gsub("^" .. string.char(0xEF, 0xBB, 0xBF), "")

local fn, compileErr = compiler(source, "x7s")
if not fn then
    error("[x7s] Error compilando x7s.lua:\n" .. tostring(compileErr), 2)
    return
end

local okRun, runtimeErr = pcall(fn)
if not okRun then
    error("[x7s] Error ejecutando x7s.lua:\n" .. tostring(runtimeErr), 2)
    return
end

print("[x7s] Cargado correctamente")
