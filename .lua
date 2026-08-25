local Scripts = {
    [92416421522960]  = { name = "Slime RNG",        url = "" },
    [121864768012064] = { name = "Fish It",          url = "https://raw.githubusercontent.com/CloudyEX/CloudyMain/refs/heads/main/Fishit.lua" },
    [93978595733734]  = { name = "Violence District", url = "" },
    [126884695634066] = { name = "QH Community",     url = "" },
    [83369512629707]  = { name = "Quantum Sawah",    url = "" },
    [139802517550914] = { name = "99 Night At Sea",  url = "https://raw.githubusercontent.com/CloudyEX/CloudyMain/refs/heads/main/99inthesea.lua" },
    [10200395747] = { name = "Grow a Garden 2", url = "https://raw.githubusercontent.com/CloudyEX/CloudyMain/refs/heads/main/GAG2.lua" },
}

local PlaceId = game.PlaceId
local GameInfo = Scripts[PlaceId]

if not GameInfo then
    warn("[QH] Map tidak support:", PlaceId)
    return
end

local Cache = getgenv().QH_Cache or {}
getgenv().QH_Cache = Cache

if Cache[PlaceId] then
    local ok, err = pcall(loadstring(Cache[PlaceId]))
    
    if not ok then
        warn("[QH] Execute error:", err)
    end
    
    return
end

local source
local maxRetries = 3

for i = 1, maxRetries do
    local ok, result = pcall(game.HttpGet, game, GameInfo.url)
    
    if ok and result then
        source = result
        break
    end
    
    if tostring(result):find("429") then
        warn("[QH] Rate limit, retry", i, "/", maxRetries)
        task.wait(i * 2)
    else
        warn("[QH] Fetch error:", result)
        return
    end
end

if not source then
    warn("[QH] Gagal fetch setelah", maxRetries, "x retry")
    return
end

Cache[PlaceId] = source

local ok, err = pcall(loadstring(source))

if ok then
    print("[QH] Loaded:", GameInfo.name)
else
    warn("[QH] Execute error:", err)
end
