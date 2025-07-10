-- Move mini trains right after engines, and only require automation science packs
local minitrains = data.raw["technology"]["mini-trains"]
minitrains.prerequisites = {"engine"}
minitrains.unit = {ingredients = {{"automation-science-pack", 1}}, count = 120, time = 30}
minitrains.effects = {
    {type = "unlock-recipe", recipe = "rail"},
    {type = "unlock-recipe", recipe = "mini-locomotive"},
    {type = "unlock-recipe", recipe = "mini-cargo-wagon"},
    {type = "unlock-recipe", recipe = "mini-fluid-wagon"},
}

-- Move automated rail transportation after mini trains
local signals = data.raw["technology"]["automated-rail-transportation"]
signals.prerequisites = {"mini-trains"}
signals.unit.ingredients = {{"automation-science-pack", 1}}

-- Move regular trains after mini trains, and delete rails from its unlocks
local trains = data.raw["technology"]["railway"]
table.insert(trains.prerequisites, "mini-trains")
for k, v in pairs(trains.effects) do
    if v.type == "unlock-recipe" and v.recipe == "rail" then
        table.remove(trains.effects, k)
    end
end

local elevated = data.raw["technology"]["elevated-rail"]
for k, v in pairs(elevated.unit.ingredients) do
    if v[1] == "logistic-science-pack" then
        table.remove(elevated.unit.ingredients, k)
    end
end
