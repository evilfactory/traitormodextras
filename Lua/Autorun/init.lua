if CLIENT then return end

Traitormod.Extras = {}
Traitormod.Extras.Path = ...

Traitormod.Extras.NeurotraumaEnabled = false

for package in ContentPackageManager.EnabledPackages.All do
    if package.UgcId == "2776270649" then
        Traitormod.Extras.NeurotraumaEnabled = true
    end
end

Hook.Add("Traitormod.InitialConfig", "Traitormod.Extras.Config", function ()
    if Traitormod.Extras.NeurotraumaEnabled then
        table.insert(Traitormod.Config.PointShopConfig.ItemCategories, dofile(Traitormod.Extras.Path .. "/Lua/pointshop/neurotrauma.lua"))
    end
end)

local function GetCargoPosition()
    local position = Submarine.MainSub.WorldPosition

    for key, value in pairs(Submarine.MainSub.GetWaypoints(true)) do
        if value.SpawnType == SpawnType.Cargo then
            position = value.WorldPosition
            break
        end
    end

    return position
end

Hook.Add("roundStart", "Traitormod.Extras.RoundStart", function ()
    for i = 1, 5, 1 do
        Entity.Spawner.AddItemToSpawnQueue(ItemPrefab.GetItemPrefab("medstartercrate"), GetCargoPosition())
    end
end)