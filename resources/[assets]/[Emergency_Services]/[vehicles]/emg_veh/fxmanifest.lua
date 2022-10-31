fx_version 'cerulean'
games { 'gta5' }

description 'Custom Vehicle Streaming pack Jacko © 2022'

data_file 'HANDLING_FILE' 'data/**/handling.meta'
data_file 'VEHICLE_METADATA_FILE' 'data/**/vehicles.meta'
data_file 'CARCOLS_FILE' 'data/**/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'data/**/carvariations.meta'

files {
  'data/**/handling.meta',
  'data/**/vehicles.meta',
  'data/**/carvariations.meta',
  'data/**/carcols.meta'
}

client_scripts {
  'client.lua',
}
