fx_version 'cerulean'
game 'gta5'
version '1.0.0'

ui_page 'web/build/index.html'

files {
    'web/build/*.*',
    'web/build/**/*.*',
}

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua',
}

client_scripts {
    'client/*.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/*.lua',
}

escrow_ignore {
    'config.lua',
    'client/cl_customize.lua',
    'server/sv_customize.lua',
}

dependency '/assetpacks'