-- WARN: this is not working atm, getting error: `ENOENT: no such file or directory`
require('livepreview.config').set({
	port = 5500,
	browser = 'default',
	dynamic_root = false,
	sync_scroll = true,
	picker = "telescope",
})
