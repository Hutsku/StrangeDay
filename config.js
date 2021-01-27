var config = {};

// on configure les requête au vault (pour les identifiant et token divers)
config.vault = {
	apiVersion: 'v1',
	endpoint: 'http://127.0.0.1:8200', // default
	token: 's.Bra7MjCR9F2XhYBsHmDsxZZV' // don't put the base root key
};

config.email = {
	gmail: {
		host: 'smtp.gmail.com',
		port: 465,
		secure: true,
		auth: {} // need email credentials
	},
	mailtrap: {
		host: "smtp.mailtrap.io",
		port: 2525,
		auth: {
			user: "323b648b0647c7", //generated by Mailtrap
			pass: "0ce4b333f3a9c0"  //generated by Mailtrap
		}
	},
	views: { 
		options: {
			extension: 'ejs'
		} 
	},
	from: 'ydogbe.store@gmail.com',
	send: true,
	preview: false,
	test: true,
}

var timeCookieDefault = 30 // en minute
var timeCookieStayConnected = 30*24*60 // durée de 30 jours
config.cookies = { 
    name: 'ydogbe',
    secret: 'keyboard cat', 
    cookie: { maxAge: timeCookieDefault*60*1000}, // in millisecond
    resave: false,
    saveUninitialized: false
}

config.debug      = false; // active some test button etc.
config.production = false; // Inutile pour l'instant mais bon
config.local_test = false; // Fait la distintion entre la version web et locale. Permet d'éviter le vault entre autre.

module.exports = config;