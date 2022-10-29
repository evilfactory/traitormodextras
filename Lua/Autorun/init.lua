if CLIENT then return end

Traitormod.Extras = {}
Traitormod.Extras.Path = ...

Traitormod.Extras.NeurotraumaEnabled = false

for package in ContentPackageManager.EnabledPackages.All do
    if tostring(package.UgcId) == "2776270649" then
        Traitormod.Extras.NeurotraumaEnabled = true
    end
end

if Traitormod.Extras.NeurotraumaEnabled then
    table.insert(Traitormod.Config.PointShopConfig.ItemCategories, dofile(Traitormod.Extras.Path .. "/Lua/pointshop/neurotrauma.lua"))
end

local function GetMedicalSpawnPosition()
    local position = Submarine.MainSub.WorldPosition

    for key, value in pairs(Submarine.MainSub.GetWaypoints(true)) do
        if value.AssignedJob and value.AssignedJob.Identifier == "medicaldoctor" then
            position = value.WorldPosition
            break
        end
    end

    return position
end

Hook.Add("roundStart", "Traitormod.Extras.RoundStart", function ()
    if Traitormod.Extras.NeurotraumaEnabled then
        for i = 1, 5, 1 do
            Entity.Spawner.AddItemToSpawnQueue(ItemPrefab.GetItemPrefab("medstartercrate"), GetMedicalSpawnPosition())
        end
    end
end)