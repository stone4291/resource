Config = {}

-- Debug Mode
Config.Debug = false

Config.Framework = 'qb' -- qbx, qb, esx
Config.Appearance = 'illenium-appearance' -- 'fivem-appearance', 'illenium-appearance', 'qb-clothing', 'skinchanger', 'crm-appearance', 'bl_appearance', 'tgiann-clothing', 'rcore_clothing', 'dx_clothing', 'karma_clothing'
Config.Interaction = 'qb-target' -- 'ox_target', 'qb-target'
Config.EnablePickup = true

Config.Bag = {
    model = 'prop_cs_heist_bag_02', -- The model of the outfit bag
    placementRange = 50.0, -- The range in which players can place the outfit bag
    interactionRange = 2.5, -- The range in which players can interact with the outfit bag

    autoCleanupEnabled = true, -- Whether or not to automatically clean up old outfit bags
    autoCleanupMinutes = 60, -- The interval in minutes at which to clean up old outfit bags
}

Config.Command = {
    enabled = true, -- Whether or not to enable the /outfitbag command
    command = 'outfitbag', -- The command used to open the outfit bag menu
}

Config.Inventory = {
    enabled = true, -- Whether or not to use an inventory system for outfit bags
    bagItem = 'outfit_bag', -- The item name used to represent outfit bags in the inventory system
}

-- Default clothing values when toggling off (removing) clothing
-- Set drawable and texture to what the player should look like when item is "removed"
Config.ClothingDefaults = {
    male = {
        [1] = { drawable = 0, texture = 0 },     -- Mask
        [4] = { drawable = 61, texture = 0 },    -- Pants
        [6] = { drawable = 34, texture = 0 },    -- Shoes
        [11] = { drawable = 15, texture = 0 },   -- Jacket
    },
    female = {
        [1] = { drawable = 0, texture = 0 },     -- Mask
        [4] = { drawable = 14, texture = 0 },    -- Pants
        [6] = { drawable = 35, texture = 0 },    -- Shoes
        [11] = { drawable = 15, texture = 0 },   -- Jacket
    }
}