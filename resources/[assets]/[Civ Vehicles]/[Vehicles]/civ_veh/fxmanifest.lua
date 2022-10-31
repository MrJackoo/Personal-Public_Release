fx_version 'cerulean'
games { 'gta5' }

data_file 'HANDLING_FILE' 'data/**/handling.meta'
data_file 'VEHICLE_LAYOUTS_FILE' 'data/**/vehiclelayouts.meta'
data_file 'VEHICLE_METADATA_FILE' 'data/**/vehicles.meta'
data_file 'CARCOLS_FILE' 'data/**/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'data/**/carvariations.meta'
data_file 'DLCTEXT_FILE' 'data/**/dlctext.meta'
data_file 'CARCONTENTUNLOCKS_FILE' 'data/**/carcontentunlocks.meta'


files {
  'data/**/handling.meta',
  'data/**/vehicles.meta',
  'data/**/carvariations.meta',
  'data/**/carcols.meta',
  'data/**/vehiclelayouts.meta'
}

client_scripts {
  'client.lua',
}




