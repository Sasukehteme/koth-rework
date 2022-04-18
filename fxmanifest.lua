fx_version 'cerulean'
game 'gta5'

author 'ShadowPeople'
description 'Cant see me'
version '1.0.0'

resource_type 'gametype' { name = 'KOTH' }

client_scripts {
	'client/*.lua',
	'shared/*.lua'
}

server_scripts {
	'server/*.lua',
	'shared/*.lua'
}

ui_page 'ui/index.html'

files {
	'ui/index.html',
	'ui/index.js',
	'ui/index.css',
	'ui/Purista.otf'
}