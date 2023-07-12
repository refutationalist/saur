
var settings = {
	host:  window.location.hostname,
	encrypt: (window.location.protocol === "https:"),
	path: "/console/socket",
	port: 0,
	
	compression: 2,
	shared: true,
	view_clip: false,
	quality: 6,
	view_only: false,
	show_dot: true,
	resize: "remote",
	repeaterID: '',
	reconnect: true,
	reconnect_delay: 5000,

	autoconnect: true
}

settings.port = window.location.port;
if (!settings.port) {
	if (window.location.protocol.substring(0, 5) == 'https') {
		settings.port = 443;
	} else if (window.location.protocol.substring(0, 4) == 'http') {
		settings.port = 80;
	}
}

export { settings as "local_settings" }
