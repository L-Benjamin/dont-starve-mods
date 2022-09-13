-- GARDEN LIGHT

local function turnoff(inst, light)
    if light then
        light:Enable(false)
    end
    inst:Hide()
end

local phasefunctions = 
{
    day = function(inst, instant)
        inst.Light:Enable(true)
        local time = 2 
        if instant then 
            time = 0
        end
        inst.components.lighttweener:StartTween(nil, 10, .8, .7, {180/255, 195/255, 150/255}, time)
    end,

    dusk = function(inst, instant) 
        inst.Light:Enable(true)
        local time = 2
        if instant then 
            time = 0
        end
        inst.components.lighttweener:StartTween(nil, 5, .8, .7, {100/255, 100/255, 100/255}, time)
    end,

    night = function(inst, instant) 
        local time = 6 
        if instant then 
            time = 0
        end
        inst.components.lighttweener:StartTween(nil, 0, 0, 1, {0,0,0}, time, turnoff)  
    end,
}

local function timechange(inst, instant)
    if not inst:HasTag("INTERIOR_LIMBO") then
        phasefunctions[GetClock():GetPhase()](inst, instant)        
    end
end

local function UpdateIsInInterior(inst)
    timechange(inst,true)
end 

local function light()
    local inst = CreateEntity()
    local trans = inst.entity:AddTransform()

    inst.UpdateIsInInterior = UpdateIsInInterior

    inst:ListenForEvent("daytime", function() timechange(inst) end, GetWorld())
    inst:ListenForEvent("dusktime", function() timechange(inst) end, GetWorld())
    inst:ListenForEvent("nighttime", function() timechange(inst) end, GetWorld())

    inst:AddComponent("lighttweener")
    inst.components.lighttweener:StartTween(inst.entity:AddLight(), 10, .8, .7, {180/255, 195/255, 150/255}, 0)

    return inst
end

-- GARDEN LAMP

local function lamp()
    local inst = SpawnPrefab("city_lamp")

    inst:RemoveComponent("lootdropper")
    inst:RemoveComponent("workable")

    inst:RemoveTag("city_hammerable")

    return inst
end

-- FOUNTAIN 

local function fountain()
	local inst = SpawnPrefab("pugalisk_fountain")

	inst:RemoveComponent("activatable")
    inst:RemoveComponent("fixable")
    inst:RemoveComponent("gridnudger")

	inst:RemoveTag("pugalisk_fountain")
	inst:RemoveTag("pugalisk_avoids")

	inst.OnSave = nil 
    inst.OnLoad = nil

    inst:AddComponent("named")
    inst.components.named.possiblenames = {"Majestic Fountain"}
    inst.components.named:PickNewName()

	return inst
end

-- FRIDGE

local function addFoodItem(inst, slotID, foodlist)
    local fooditem = SpawnPrefab(foodlist[math.random(#foodlist)])
    fooditem.components.inventoryitem:SetOnPutInInventoryFn(function(inst) 
        inst.components.perishable:StartPerishing()
    end)
    inst.shelves[slotID].components.shelfer:AcceptGift(nil, fooditem)
    fooditem.components.perishable:StopPerishing()
end

local function fridge()
	local inst = SpawnPrefab("shelves_fridge")

    inst:ListenForEvent("daytime", function() 
        local starters = {"asparagussoup", "spicyvegstinger", "ratatouille"}
        local dishes   = {"turkeydinner", "honeyham", "honeynuggets"}
        local desserts = {"taffy", "pumpkincookie", "icedtea", "gummy_cake", "butterflymuffin"}

        addFoodItem(inst, 1, starters)
        addFoodItem(inst, 2, desserts)
        addFoodItem(inst, 3, dishes)
        addFoodItem(inst, 4, starters)
        addFoodItem(inst, 5, desserts)
        addFoodItem(inst, 6, dishes)
    end, GetWorld())   
  
    return inst
end

-- HEDGE

local function hedge()
    local inst = SpawnPrefab("hedge_cone")

    inst:RemoveComponent("workable")
    inst:RemoveComponent("lootdropper")
    inst:RemoveComponent("fixable")
    inst:RemoveComponent("gridnudger")
    inst:RemoveComponent("shearable")

    inst.OnSave = nil 
    inst.OnLoad = nil
    inst.shave = nil
    inst.setAgeTask = function(inst) end
    inst.onshear = nil
    inst.canshear = nil

    return inst
end

-- LAWNORNAMENT

local function lawnornament()
    local inst = SpawnPrefab("lawnornament_6")

    inst:RemoveComponent("workable")
    inst:RemoveComponent("lootdropper")
    inst:RemoveComponent("fixable")
    inst:RemoveComponent("gridnudger")

    inst.OnSave = nil 
    inst.OnLoad = nil

    return inst
end

-- RETURNS

return Prefab("palace_garden_light", light),
       Prefab("palace_garden_lamp", lamp),
       Prefab("palace_fountain", fountain),
       Prefab("palace_fridge", fridge),
       Prefab("palace_hedge", hedge),
       Prefab("palace_lawnornament", lawnornament)