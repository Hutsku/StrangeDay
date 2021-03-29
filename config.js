var config = {};

// on configure les requête au vault (pour les identifiant et token divers)
config.vault = {
	apiVersion: 'v1',
	endpoint: 'http://127.0.0.1:8200', // default
	token: 's.elqpt9Wc57Bmh61oMbMkitr9' // don't put the base root key
};

config.email = {
	mailtrap: {
		host: "smtp.mailtrap.io",
		port: 2525,
		auth: {
			user: "323b648b0647c7", //generated by Mailtrap
			pass: "0ce4b333f3a9c0"  //generated by Mailtrap
		}
	},
	gandi: {
		host: 'mail.gandi.net',
		port: 465,

		auth: {} // need email credentials
	},
	views: { 
		options: {
			extension: 'ejs'
		} 
	},
	from: 'Strange Day <contact@strangeday.fr>',
	send: true,
	preview: false,
	test: false,
}

var timeCookieDefault = 180 // en minute (3h)
var timeCookieStayConnected = 30*24*60 // durée de 30 jours
config.cookies = { 
    name: 'strangeday',
    secret: 'keyboard cat', 
    cookie: { maxAge: timeCookieDefault*60*1000}, // in millisecond
    resave: false,
    saveUninitialized: false
}

config.debug      = false; // active quelques boutons de test etc.
config.production = true; // Désactive les paiements
config.reveal     = true; // Active/desactive la page d'attente de reveal du site

module.exports = config;