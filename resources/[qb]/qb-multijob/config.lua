Config = {}

Config.Icons = { --Icons for jobs in the menu. Use job name(Case sensitive). Can use FontAwsome or Bootstrap Icons
    ['police'] = 'bi bi-shield-shaded',
    ['ambulance'] = 'fas fa-ambulance',
    ['tow'] = 'bi bi-truck-flatbed',
    ['taxi'] = 'fas fa-taxi',
    ['lawyer'] = 'bi bi-briefcase',
    ['judge'] = 'fas fa-gavel',
    ['realestate'] = 'bi bi-house',
    ['cardealer'] = 'fas fa-car',
    ['tuner'] = 'bi bi-tools',
    ['reporter'] = 'bi bi-newspaper',
    ['trucker'] = 'fas fa-truck-moving',
    ['garbage'] = 'fas fa-recycle',
    ['locker'] = 'fas fa-warehouse',
    ['arcade'] = 'fas fa-gamepad',
    ['casino'] = 'fab fa-gg',
    ['jdm'] = 'fab fa-car',
}

Config.DefaultIcon = "fas fa-briefcase" --The default icon shown if the job isn't defined above

Config.BlackListedJobs = { --jobs that won't automatically be added to the multijob menu. EG Can use cityhall jobs if you want them to go to city hall each time
    'unemployed',
    'examplejob2'
}

Config.Keybind = "END" --Keybind used to open the menu