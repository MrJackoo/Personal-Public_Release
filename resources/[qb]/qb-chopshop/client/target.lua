Citizen.CreateThread(function()
  if Config.Target == "qb" then
    exports['qb-target']:AddBoxZone("ChopShopParts", vector3(483.93, -1325.96, 29.21), 10.0, 1, {
      name=StartChopJob,
      heading=297,
      debugPoly=false,
      minZ=28.21,
      maxZ=32.21
    },
    {
      options = {
        {
          type = "client",
          event = "qb-chopshop:StartMenu",
          icon = "fas fa-hammer",
          label = "Chop Parts"
        },
      },
      distance = 3,
    })
  elseif Config.Target == "berkie" then
    exports['berkie-target']:AddBoxZone("ChopShopParts", vector3(471.5797, -1312.1295, 30.2579), 1.40, 1.35, {
      name="ChopShopParts",
      heading=113.1992,
      debugPoly=false,
      minZ=28.77834,
      maxZ=29.87834,
      }, {
    options = {
      {
        type = "client",
        event = "qb-chopshop:StartMenu",
        icon = "fas fa-hammer",
        label = "Chop Parts",
        job = all,
      },
    },
    distance = 3.5
    })
  
    exports['berkie-target']:SpawnPed({
      [2328] = {
          model = 'csb_prologuedriver',
          coords = Config.StartLoc,
          minusOne = true,
          freeze = true,
          invincible = true,
          blockevents = true,
          scenario = 'WORLD_HUMAN_CLIPBOARD',
          target = {
            options = {
              {
                type = "client",
                event = "qb-chopshop:jobaccept",
                icon = 'fas fa-car',
                label = 'Locate A Vehicle',
              }
            },
            distance = 1.5,
          }
      }
      })
    elseif Config.Target == "bt" then
      exports['bt-target']:AddBoxZone("ChopShopParts", vector3(471.5797, -1312.1295, 30.2579), 1.40, 1.35, {
        name="ChopShopParts",
        heading=113.1992,
        debugPoly=false,
        minZ=28.77834,
        maxZ=29.87834,
        }, {
      options = {
        {
          type = "client",
          event = "qb-chopshop:StartMenu",
          icon = "fas fa-hammer",
          label = "Chop Parts",
          job = {"all"},
        },
      },
      distance = 3.5
      })
      exports['bt-target']:AddBoxZone("StartChopJob", vector3(Config.StartLoc.x, Config.StartLoc.y, Config.StartLoc.z), 1, 1, {
        name="StartChopJob",
        heading=113.1992,
        debugPoly=false,
        minZ = Config.StartLoc.z - 1,
        maxZ = Config.StartLoc.z + 1,
        }, {
      options = {
        {
          type = "client",
          event = "qb-chopshop:jobaccept",
          icon = "fas fa-car",
          label = "Locate A Vehicle",
          job = {"all"},
        },
      },
      distance = 3.5
      })
    end
end)

Citizen.CreateThread(function()
  modelHash = GetHashKey("s_m_y_xmech_01")
  RequestModel(modelHash)
  while not HasModelLoaded(modelHash) do
    Wait(2000)
    print("DEVELOPMENT NOTICE: ATTEMPTING TO SPAWN: "..modelHash)
  end
  CreateChopPed()
end)

function CreateChopPed()

  MechanicNPC = CreatePed(0, modelHash, Config.StartLoc.x, Config.StartLoc.y, Config.StartLoc.z, Config.StartLoc.w, false, false)
  SetBlockingOfNonTemporaryEvents(MechanicNPC, true)	
  FreezeEntityPosition(MechanicNPC, true)
  SetEntityInvincible(MechanicNPC, true)
  SetPedCanPlayAmbientAnims(MechanicNPC, true)
  TaskStartScenarioInPlace(MechanicNPC, "WORLD_HUMAN_CLIPBOARD", 0, true)

  exports['qb-target']:AddTargetEntity(MechanicNPC, {
      options = {
          {
            type = "client", 
            event = "qb-chopshop:jobaccept", 
            icon = 'fas fa-wrench', 
            label = 'Locate A Vehicle'
          }
      },
      distance = 2.0
  })
end