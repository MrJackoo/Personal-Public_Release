fx_version 'cerulean'
game 'gta5'

author 'DrB1ackBeard'
description 'qb-burgershot for QBCore Created By DrB1ackBeard'
version '2.1.0'

shared_scripts {
    'config.lua',
}

client_scripts {
	'@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/EntityZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
	'client/main.lua'
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server/main.lua'
}

