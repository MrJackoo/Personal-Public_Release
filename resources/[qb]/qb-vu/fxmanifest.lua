fx_version 'cerulean'
game 'gta5'

author 'DrB1ackBeard' edited_and_adapted 'Reborn RP'
description 'Vanilla Unicorn' edited_and_adapted 'Reborn RP'
version '2.1.0'

shared_script 'config.lua'

client_scripts {
	'@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/EntityZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
    'client/*.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/main.lua'
}

ui_page 'html/index.html'

files {
	'html/index.html',
	'html/vue.min.js',
	'html/script.js',
	'html/vcr-ocd.ttf'
}