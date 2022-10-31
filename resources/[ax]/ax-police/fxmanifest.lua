fx_version 'cerulean'
game 'gta5'

description 'Police Resources'
version '1.0.0'

client_script 'client/*.lua'

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server/*.lua'
}
