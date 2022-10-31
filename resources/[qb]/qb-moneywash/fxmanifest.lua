fx_version 'cerulean'
game 'gta5'

author 'Devyn'
description 'Money Laundry'


server_scripts { 
    '@oxmysql/lib/MySQL.lua',
    "server.lua",
}

client_scripts { 
    "client.lua",
}