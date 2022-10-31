fx_version "bodacious"
game "gta5"

author "Walshey & Marcus"
description "Server Sided Sirens"
version "1.0.0"

files { 
	"dlc_wmsirens/sirenpack_one.awc",
	"data/wmsirens_sounds.dat54.nametable",
	"data/wmsirens_sounds.dat54.rel"
}

client_scripts {
	'client.lua'
}

server_scripts {
	'server.lua'
}

data_file "AUDIO_WAVEPACK" "dlc_wmsirens"
data_file "AUDIO_SOUNDDATA" "data/wmsirens_sounds.dat"


