Config = {}
Config.Debug = false

Config.Notifications = {
    enter = {
        type = 'success',
        duration = 5000,
        sound = true
    },
    exit = {
        type = 'primary',
        duration = 5000,
        sound = true
    }
}

Config.WarningText = {
    enabled = true,
    text = "SAFE ZONE",
    position = {
        x = 0.5,
        y = 0.01
    },
    scale = 0.7,
    color = {
        r = 0,
        g = 255,
        b = 0
    }
}

-- Police job configuration
Config.PoliceJobs = {
    ['ambulance'] = true,
    ['police'] = true,
    ['lspd'] = true,  
    ['bcso'] = true -- Add any additional police job names here
}

Config.SafeZones = {
    ['Hospital'] = {
        coords = vector3(297.44, -584.14, 43.26),
        radius = 50.0,
        message = "You've entered Hospital Safe Zone"
    },
    ['Police'] = {
        coords = vector3(428.84, -981.87, 30.71),
        radius = 50.0,
        message = "You've entered Police Department Safe Zone"
    },
    ['Spawn'] = {
        coords = vector3(-544.0, -204.0, 37.0),
        radius = 50.0,
        message = "You've entered Spawn Safe Zone"
    },
    ['FoodStore'] = {
      
    },
}