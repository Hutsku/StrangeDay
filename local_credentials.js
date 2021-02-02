/* 
	Ce fichier sert à l'utilisation des identifiants sans passer par vault lors des test local du server. 
	Il ne doit pas être publié sur la version de production, le site web passant par un vault.
*/

var cred = {};

cred.admin = ['arouxel@outlook.fr', 'yoann.dogbe@gmail.com'];

cred.email = {
	user: 'arouxel@strangeday.fr', // gandi cred
	pass: '2wOoWwcz6ajUZs8eEfA0'
};

cred.mysql = {
	user: 'root',
	pass: ''
};

cred.paypal_test = {
	client_id: 'AdWx5whAAgzyh6Y_lJ_CgCCMesUotsBePSlMqNshhig6dyCLMmR9fZ07jaNY_ZD8WWV4ICXQxhjPl1W-' 
};
cred.paypal = {
	client_id: 'AbjIp6K4iUasjI-eiNAjVXSbEB6zlmSr19web1st9xdgsF4DGnSth96oWqVxkf3MHWpaUNreOywYoxOk'
};

cred.stripe_test = {
	secret: 'sk_test_0HJaHUkSg3JE8rkO4P4weCJS00cB00h5K9',
	public: 'pk_test_yPzxYfltlnyWe55PR7jjw4PX00vkHy4ywN',
};
cred.stripe = {
	secret: 'sk_live_ikqdQMhaoX1mYAs90qgfknEV00V6PC83VU',
	public: 'pk_live_baFcwuwS0lhEHOZ2GylNjE2d00dVtGYtMI',
};

module.exports = cred;