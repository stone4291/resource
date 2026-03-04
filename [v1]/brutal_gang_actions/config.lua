----------------------------------------------------------------------------------------------
----------------------------------| BRUTAL GANG ACTIONS :) |----------------------------------
----------------------------------------------------------------------------------------------

--[[
Hi, thank you for buying our script, We are very grateful!

For help join our Discord server:     https://discord.gg/85u2u5c8q9
More informations about the script:   https://docs.brutalscripts.com
--]]

Config = {
    Core = 'QBCORE',  -- 'ESX' / 'QBCORE' | Other core setting on the 'core' folder.
    Target = 'qb-target', -- 'false' / 'oxtarget' / 'qb-target' 
    Inventory = 'qb_inventory', -- 'ox_inventory' / 'qb_inventory' / 'quasar_inventory' / 'advanced_quasar_inventory' / 'chezza_inventory' / 'codem_inventory' / 'core_inventory' / 'origen_inventory' / 'ps-inventory' // Custom can be add in the cl_utils.lua!!!
    ProgressBar = 'progressBars', -- 'progressBars' / 'pogressBar' / 'mythic_progbar' // Custom can be add in the cl_utils.lua!!!
    BrutalNotify = false, -- Buy here: (4€+VAT) https://store.brutalscripts.com | Or set up your own notify >> cl_utils.lua
    AllowedJobs = false, -- Set to 'false' to allow it to anybody. | Can only be used if 'BlacklistedJobs' is also set to 'false'.
    BlacklistedJobs = false, -- Set to 'false' to allow it to anybody.
    HandUpAnimation = {'missminuteman_1ig_2', 'handsup_base'},  -- If you use a different hands up animation on your server change these | Anim Dict, Anim Name
    BackgroundBlur = true, -- true / false
    PanelColor = '#C337FB',
    PanelEditingButton = {FivemControl = 244, JsButton = 'm', Character = 'M'}, -- FivemControl: https://docs.fivem.net/docs/game-references/controls/#controls 
    AllowWhileDead = true, -- Allow the menu to be used while dead | true / false

    HeadBag = {
        Use = true,
        AppearInMenu = true,
        BlackFade = true,
        HandsUpRequirement = false,
    },
    
    Hostage = {
        Use = true,
        AppearInMenu = true,
        HandsUpRequirement = true,
        AllowedWeapons = {
            `WEAPON_PISTOL`,
            `WEAPON_COMBATPISTOL`,
        },
        DisableControls = {24,257,25,263,32,34,31,30,45,22,44,37,23,288,289,170,167,73,199,59,71,72,36,47,264,257,140,141,142,143,75},
    },

    PutPlayerInVehicle = {
        Use = true,
        AppearInMenu = true,
        HandsUpRequirement = false,
        CustomVehicleTrunkPos = {
            ["elegy"] = {x = 0.0, y = -2.0, z = 0.5}, -- You can add as many as you wish
        },
    },

    TyreSlash = {
        Use = true,
        AppearInMenu = true,
        AllowedWeapons = {
            `WEAPON_KNIFE`,
            `WEAPON_BOTTLE`,
            `WEAPON_DAGGER`,
            `WEAPON_HATCHET`,
            `WEAPON_MACHETE`,
            `WEAPON_SWITCHBLADE`
        },
    },

    Knockout = {
        Use = true,
        AppearInMenu = true,
        KnockEffect = 'ragdoll', --'animation' or 'ragdoll'
        Cooldown = {use = true, time = 60}, -- time in sec 
        Time = 5, -- time in sec, how much time should be the player passed out
    },

    PullPlayer = {
        Use = true,
        AppearInMenu = true,
    },

    HandCuff = {
        Use = true,
        AppearInMenu = true,
        Freeze = false, -- Do you want to freeze the player while he is cuffed? true / false
        CuffObject = true, -- Do you want to use Cuff Object on the player's hand? true / false
        -- More controls: https://docs.fivem.net/docs/game-references/controls/
        DisableControls = {24,257,25,263,32,34,31,30,45,22,44,37,23,288,289,170,167,73,199,59,71,72,36,47,264,257,140,141,142,143,75}, -- Disabled controls while the player is cuffed.
        Trigger = 'brutal_gang_actions:cuff',
    },

    Rob = {
        Use = true,
        AppearInMenu = true,
        HandsUpRequirement = true,
        AllowedWeapons = {
            `WEAPON_PISTOL`,
            `WEAPON_COMBATPISTOL`,
        },
    },

    Commands = {  -- to turn off a command just simply leave empty the command line, like this: Command = '',
        JobMenu = {
            Command = 'gjobmenu',
            Control = '',  -- Controls list:  https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/
            Suggestion = 'Open Job Menu'
        },

        PutBagOnMyself = {
            Command = 'mebag', 
            Control = '',  -- Controls list:  https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/
            Suggestion = 'Put Bag on your head',
            Item = {'', true, true} -- item name | leave it empty to not use any item, like this: '', remove it when put on head or not, give it when removed from head or not
        },

        PutBagOnOtherPeople = {
            Command = 'bag',
            Control = '',  -- Controls list:  https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/
            Suggestion = 'Put Bag on others head',
            Item = {'', true, true} -- item name | leave it empty to not use any item, like this: '', remove it when put on head or not, give it when removed from head or not
        },

        Hostage = {
            Command = 'hostage',
            Control = '',  -- Controls list:  https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/
            Suggestion = 'Hostage an other people'
        },

        PutPlayerInVehicle = {
            Command = 'putplayerinvehicle',
            Control = '',  -- Controls list:  https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/
            Suggestion = 'Put player in vehicle',
            BlacklistedVehicles = {'bf400'}, -- false =  not in use
        },

        PierceTyre = {
            Command = 'piercetyre',
            Control = '',  -- Controls list:  https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/
            Suggestion = 'Pierce the tyre'
        },

        Knockout = {
            Command = 'knockout',
            Control = '',  -- Controls list:  https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/
            Suggestion = 'Knockout player'
        },

        PullPlayer = {
            Command = 'pull',
            Control = '',  -- Controls list:  https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/
            Suggestion = 'Pull player',
            Item = {'', true, true} -- item name | leave it empty to not use any item, like this: '', remove it when put on head or not, give it when removed from head or not
        },

        HandCuff = {
            Command = 'cuff',
            Control = '',  -- Controls list:  https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/
            Suggestion = 'To cuff a player faster',
            Item = {'', true, true} -- item name | leave it empty to not use any item, like this: '', remove it when put on head or not, give it when removed from head or not
        },

        Rob = {
            Command = 'rob',
            Control = '',  -- Controls list:  https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/
            Suggestion = 'Rob out the player'
        },
    },

    -----------------------------------------------------------
    -----------------------| TRANSLATE |-----------------------
    -----------------------------------------------------------

    Locales = {
        Bag = 'Bag',
        BagDescription = 'Quickly subdue players by placing a bag over their head.',
        Hostage = 'Hostage',
        HostageDescription = 'Take control of the situation by holding a player hostage.',
        PutInVehicle = 'Pick up',
        PutInVehicleDescription = 'Securely place the player in the trunk to transport them.',
        Tyre = 'Slash tyre',
        TyreDescription = 'Disable vehicles by slashing the tire, leaving them stranded.',
        Knockout = 'Knockout',
        KnockoutDescription = 'Knock out players with a swift hit, rendering them unconscious.',
        Pull = 'Pull',
        PullDescription = 'Drag players by a rope tied to their leg, immobilizing them.',
        Cuff = 'Cuff',
        CuffDescription = 'Restrict player movement by cuffing their hands behind their back.',
        Rob = 'Rob',
        RobDescription = 'Rob out a player with a gun or with a knife.',

        Search = 'Searching player'
    },
    
    -- Notify function EDITABLE >> cl_utils.lua
    Notify = { 
        [1] = {"Gang Actions", "There is no player nearby", 5000, "error"},
        [2] = {"Gang Actions", "You need the right weapon", 5000, "error"},
        [3] = {"Gang Actions", "There is no vehicle nearby", 5000, "error"},
        [4] = {"Gang Actions", "The tyre is already slashed", 5000, "error"},
        [5] = {"Gang Actions", "Your hands are not free", 5000, "error"},
        [6] = {"Gang Actions", "This is not a right vehicle for this", 5000, "error"},
        [7] = {"Gang Actions", "Your job is not allove this", 5000, "error"},
        [8] = {"Gang Actions", "You don't have the right item", 5000, "error"},
        [9] = {"Gang Actions", "You have to wait a little", 5000, "error"},
        [10] = {"Gang Actions", "Hands up is needed for this action", 5000, "error"},
        [11] = {"Gang Actions", "You don't have any of the required weapons", 5000, "error"},
        [12] = {"Gang Actions", "None of your weapons have any ammo in them", 5000, "error"},
        [13] = {"Gang Actions", "Your job is on the blacklist.", 5000, "error"},
        [14] = {"Gang Actions", "Your job is not on the allowed list.", 5000, "error"},
    },
    
}
