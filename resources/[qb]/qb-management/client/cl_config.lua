-- Zones for Menues
Config = Config or {}

Config.UseTarget = GetConvar('UseTarget', 'false') == 'false' -- Use qb-target interactions (don't change this, go to your server.cfg and add `setr UseTarget true` to use this and just that from true to false or the other way around)

Config.BossMenus = {
    ['police'] = {
        vector3(461.54, -985.6, 30.69),
    },
    ['ambulance'] = {
        vector3(335.46, -594.52, 43.28),
    },
    ['realestate'] = {
        vector3(-716.11, 261.21, 84.14),
    },
    ['taxi'] = {
        vector3(895.11, -178.89, 73),
    },
    ['cardealer'] = {
        vector3(951.31, -968.91, 39.51),
    },
    ['tuner'] = { 
        vector3(125.77, -3008.86, 7.04),
    },
    ['burgershot'] = {
        vector3(-1178.58, -896.91, 13.97),
    },
    ['locker'] = {
        vector3(-2965.85, 23.51, 7.96),
    },
    ['vu'] = {
        vector3(95.99, -1293.08, 29.18),
    },
    ['casino'] = {
        vector3(1110.11, 242.53, -45.83),
    },
    ['jdm'] = {
        vector3(949.61, -1831.74, 21.76),
    },
}

Config.BossMenuZones = {
    ['police'] = {
        { coords = vector3(461.54, -985.6, 30.69), length = 4.8, width = 1.0, heading = 90.0, minZ = 28.49, maxZ = 32.49 } ,
    },
    ['ambulance'] = {
        { coords = vector3(335.46, -594.52, 43.28), length = 1.2, width = 0.6, heading = 341.0, minZ = 43.13, maxZ = 43.73 },
    },
    ['realestate'] = {
        { coords = vector3(-716.11, 261.21, 84.14), length = 0.6, width = 1.0, heading = 25.0, minZ = 83.943, maxZ = 84.74 },
    },
    ['taxi'] = {
        { coords = vector3(895.11, -178.89, 73), length = 1.0, width = 3.4, heading = 327.0, minZ = 73, maxZ = 74 },
    },
    ['cardealer'] = {
        { coords = vector3(937.11, -953.34, 39.5), length = 4.0, width = 4.0, heading = 37.92, minZ = 37.04, maxZ = 41.04 },
    },
    ['tuner'] = {
        { coords = vector3(125.26, -3008.89, 7.04), length = 2.55, width = 1, heading = 33.0, minZ = 6, maxZ = 9 },
    },
    ['burgershot'] = {
        { coords = vector3(-1178.58, -896.91, 13.97), length = 2.2, width = 1, heading = 35.0, minZ = 10.35, maxZ = 14.35 },
    },
    ['locker'] = {
        { coords = vector3(-2965.85, 23.51, 7.96), length = 2.2, width = 0.8, heading = 35.0, minZ = 10.35, maxZ = 14.35 },
    },
    ['arcade'] = {
        { coords = vector3(-1649.57, -1070.0, 13.76), length = 2.2, width = 0.8, heading = 35.0, minZ = 10.35, maxZ = 14.35 },
    },
    ['vu'] = {
        { coords = vector3(95.99, -1293.08, 29.18), length = 2.2, width = 0.8, heading = 35.0, minZ = 10.35, maxZ = 14.35 },
    },
    ['casino'] = {
        { coords = vector3(1110.11, 242.53, -45.83), length = 2.2, width = 0.8, heading = 3.98, minZ = 10.35, maxZ = 14.35 },
    },
    ['jdm'] = {
        { coords = vector3(949.61, -1831.74, 21.76), length = 2.2, width = 0.8, heading = 3.98, minZ = 10.35, maxZ = 14.35 },
    },
}

Config.GangMenus = {
    ['lostmc'] = {
        vector3(0, 0, 0),
    },
    ['ballas'] = {
        vector3(0, 0, 0),
    },
    ['vagos'] = {
        vector3(0, 0, 0),
    },
    ['cartel'] = {
        vector3(0, 0, 0),
    },
    ['yakuza'] = {
        vector3(-645.94, -1242.74, 11.55),
    },
    ['syndicate'] = {
        vector3(1394.18, 1160.54, 114.18),
    },
    ['brotherhood'] = {
        vector3(-79.94, -801.89, 243.33),
    },
    ['prb'] = {
        vector3(-113.4, -1781.65, 28.59),
    },
}

Config.GangMenuZones = {
    ['syndicate'] = {
        { coords = vector3(1394.18, 1160.54, 114.18), length = 2.2, width = 0.8, heading = 3.98, minZ = 113.0, maxZ = 115.0 },
    },
    ['brotherhood'] = {
        { coords = vector3(-79.94, -801.89, 243.33), length = 2.2, width = 0.8, heading = 3.98, minZ = 242.0, maxZ = 244.0 },
    },
    ['prb'] = {
        { coords = vector3(-113.4, -1781.65, 28.59), length = 2.2, width = 0.8, heading = 3.98, minZ = 10.0, maxZ = 13.0 },
    },
    ['yakuza'] = {
        { coords = vector3(-645.94, -1242.74, 11.55), length = 2.2, width = 0.8, heading = 3.98, minZ = 27.0, maxZ = 29.0 },
    },
}
