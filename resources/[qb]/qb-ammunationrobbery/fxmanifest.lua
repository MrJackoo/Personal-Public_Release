fx_version 'cerulean'
game 'gta5'

description 'QB-iFruitStore'
version '1.0.0'

ui_page 'html/index.html'

shared_scripts { 
	'config.lua'
}

client_script 'client/main.lua'
server_script 'server/main.lua'

files {
    'html/*'
}