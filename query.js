
var bcrypt     = require('bcryptjs');
var mysql      = require('mysql');

var connection;
function init (cred) {
    // Créer la connection avec la BDD mysql.
    connection = mysql.createConnection({
        host     : 'localhost',
        user     : cred.user,
        password : cred.password,
        database : 'strange_day'
    });
    console.log("> BDD MySQL connecté.");
};

// Arrondis les operations de float
function roundPrice(x) {
    return parseFloat(x.toFixed(10));
}

// ============================================= QUERY ===================================================

_getAllUser    = `SELECT * FROM user`;
_getAllBaseProduct = `SELECT * FROM product`;
_getAllProduct = `SELECT p.id, p.name, description, price, available, p.type, cover_image, collection, composition, size, weight, a.type as acc_type FROM product p
            LEFT JOIN accessory a ON a.product_id = p.id
            LEFT JOIN clothe ON clothe.product_id = p.id
			LEFT JOIN print ON print.product_id = p.id`;
_getAllClothe = `SELECT p.id, p.name, description, price, available, type, cover_image, collection, composition FROM product p, clothe
            WHERE clothe.product_id = p.id`
_getAllPrint = `SELECT p.id, p.name, description, price, available, type, cover_image, collection, size, weight FROM product p, print
            WHERE print.product_id = p.id`
_getAllAcc = `SELECT p.id, p.name, description, price, available, p.type, cover_image, collection, a.type as acc_type FROM product p, accessory a
            WHERE a.product_id = p.id`

_getAllOrder   = `SELECT * FROM \`order\``;
_getAllOrderUser = `SELECT o.id, u.name, total_cost, shipping_address, o.state, p.id as product_id, p.name as product, oc.option, oc.nb
				FROM \`order\` o, user u, order_content oc, product p
				WHERE o.user_id = u.id AND oc.product_id = p.id AND oc.order_id = o.id`;
_getUser       = `SELECT * FROM user WHERE id = ?`;
_getUserFromEmail = `SELECT * FROM user WHERE email = ?`;
_getProduct = `SELECT p.id, p.name, description, price, available, p.type, image.name as image, composition, collection, size, weight, a.type as acc_type FROM product p
			INNER JOIN product_image pi ON pi.product_id = p.id
			INNER JOIN image ON image.id = pi.image_id
			LEFT JOIN clothe ON clothe.product_id = p.id
			LEFT JOIN print ON print.product_id = p.id
            LEFT JOIN accessory a ON a.product_id = p.id
			WHERE p.id = ?`;
_getOrder      = `SELECT o.id, date, subtotal_cost, shipping_cost, total_cost, billing_address, shipping_address, payment_method, shipping_method, state, p.id as product_id, p.name as product, oc.option, oc.nb, p.price as product_price, cover_image 
			FROM \`order\` o, order_content oc, product p 
			WHERE o.id = ? AND oc.product_id = p.id AND oc.order_id = o.id`;
_getOrderEmail = `SELECT email FROM \`order\` o, user WHERE o.user_id = user.id AND o.id = ?`;
_getUserOrder  = `SELECT * FROM \`order\` WHERE user_id = ?`;
_getUserEmail  = `SELECT email FROM user WHERE id = ?`;

_addUser     = `INSERT INTO user (name, password, email, tel, address1, address2, city, postal_code, state, country, newsletter) 
               VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`;
_addOrder = `INSERT INTO \`order\` (user_id, date, total_cost, subtotal_cost, shipping_cost, shipping_address, billing_address, payment_method, shipping_method) 
               VALUES (?, NOW(), ?, ?, ?, ?, ?, ?, ?)`;
_addProduct  = `INSERT INTO product (name, description, price, type, cover_image, collection) VALUES (?, ?, ?, ?, ?, ?)`;
_addClothe   = `INSERT INTO clothe (product_id, composition) VALUES (?, ?)`;
_addPrint    = `INSERT INTO print (product_id, size, weight) VALUES (?, ?, ?)`;
_addAcc      = `INSERT INTO accessory (product_id, type) VALUES (?, ?)`;

_removeProduct = `DELETE FROM product WHERE id = ?`;
_removeOrder   = `DELETE FROM \`order\` WHERE id = ?`;
_removeUser    = `DELETE FROM user WHERE id = ?`;

_editUserPassword = `UPDATE user SET password = ? WHERE id = ?`;
_editUserAddress  = `UPDATE user SET address1 = ?, address2 = ?, city = ?, country = ?, state = ?, postal_code = ? WHERE id = ?`;
_editUserInfo     = `UPDATE user SET name = ?, email = ?, tel = ? WHERE id = ?`;
_editUserNewsLet  = `UPDATE user SET newsletter = ? WHERE id = ?`;

_updateOrder   = `UPDATE \`order\` SET state = ? WHERE id = ?`;
_updateProduct = `UPDATE product SET name = ?, description = ?, price = ?, available = ?, type = ?, cover_image = ?, collection = ? WHERE id = ?`;
_updateClothe  = `UPDATE clothe SET composition = ? WHERE product_id = ?`;
_updatePrint   = `UPDATE print SET size = ?, weight = ? WHERE product_id = ?`;
_updateAcc     = `UPDATE accessory SET type = ? WHERE product_id = ?`;

// ========================================= FONCTION =====================================================

// Renvoit les données d'un utilisateur si les informations données sont correct
function login([email, password], callback) {
    connection.query(_getUserFromEmail, [email], function(err, rows, fields) {
    	if (err) throw err;
    	var user = rows[0]
        
        // Si l'email est bien enregistré ...
        if (user) {
            bcrypt.compare(password, user.password, function(err, response) {
                // Si les mots de passe correspondent ...
                if (response) {
                	callback(user);
                } 
                else {
                	callback(false, 'Bad password')
                    req.session.error = "Bad password";
                    res.send('badPassword');
                }
            });
        }
        else {
        	callback(false, 'Unknown email')
            req.session.error = "Unknown email";
            res.send('badEmail');
        }
    }); 
}

function signUp(data, callback) {
    // On hash le mot de passe à enregistrer dansla DB
    bcrypt.hash(data.password, 10, function(err, hashedPassword) {
        // On verifie qu'un utilisateur n'existe pas déjà
        connection.query(_getUserFromEmail, [data.email], function(err, rows, fields) {
            if (err) throw err;

            // Si l'adresse email n'est pas encore utilisé ...
            if (!rows.length) {
                var queryParam = [
                	data.name, hashedPassword, data.email, data.tel, data.address1, data.address2, data.city, 
			  		data.postalCode, data.state, data.country, data.newsletter
			  	];
                connection.query(_addUser, queryParam, function(err, result) {
                    if (err) throw err;

                    // On renvoit les informations de compte en même temps
                    connection.query(_getUser, [result.insertId], function(err, rows, fields) {
                    	callback(rows[0]);
                    })
                });
            }
            else {
            	callback(false, 'badEmail');
            }
        });
    });	
}

// Verifie les données du panier avec la base de données (correction des prix)
function checkCart(cart, callback) {
    // On calcule le prix totale depuis la DB (pour plus de securité)
    var subtotal_cost = 0;
    connection.query(_getAllBaseProduct, function(err, products, fields) {
        if (err) throw err;
        for (product of products) {
            for (cart_product of cart.products) {
                if (cart_product.id == product.id) {
                    subtotal_cost = roundPrice(subtotal_cost + cart_product.cart_qty * product.price); // On refait le prix total
                    cart_product.price = product.price; // On corrige le panier
                }
            }
        }

        // On met à jour les prix totaux du panier
        cart.subtotal_cost = subtotal_cost;
        cart.total_cost = roundPrice(subtotal_cost + cart.shipping_cost);
        callback(cart);
    });
}

// Renvoit une liste de tout les utilisateur (avec leur informations)
function getAllUser(callback) {
    connection.query(_getAllUser, function(err, rows, fields) {
        if (err) throw err;
        callback(rows);
    });
}

// Renvoit une liste de tout les produits (avec leur informations)
function getAllProduct(callback, type) {
    switch (type) {
        case 'all': query = _getAllProduct;
            break;

        case 'clothe': query = _getAllClothe;
            break;

        case 'print': query = _getAllPrint;
            break;

        case 'accessory': query = _getAllAcc;
            break;

        default: query = _getAllProduct;
    }
    connection.query(query, function(err, rows, fields) {
        if (err) throw err;
        callback(rows);
    });
}

// Renvoit une liste de toutes les commandes
function getAllOrder(callback) {
    connection.query(_getAllOrder, function(err, rows, fields) {
        if (err) throw err;
        callback(rows);
    });
}

// Renvoit une liste de toutes les commandes, avec le nom d'utilisateur affilié
function getAllOrderUser(callback) {
    connection.query(_getAllOrderUser, function(err, rows, fields) {
        if (err) throw err;

        // La requête renvoit une ligne par produit différente de la commande, on doit donc recomposer en liste
        orderList = [];
        checkedId = [];
        for (order of rows) {
        	// Si la commande a déjà été traité (pour au moins 1 produit)
        	if (!checkedId.includes(order.id)) {
        		order.product = [{
        			id: order.product_id,
        			name: order.product,
        			option: order.option,
        			nb: order.nb
        		}]; // on reconstruit sous forme de liste
				orderList.push(order);
				checkedId.push(order.id);
        	}
        	else {
        		// ... sinon on regarde dans la liste et on modifie
        		for (var i=0; i<orderList.length; i++) {
        			if (order.id == orderList[i].id) {
        				orderList[i].product.push({
        					id: order.product_id,
        					name: order.product,
        					option: order.option,
        					nb: order.nb
        				});
        			}
        		}
        	}
        }
        callback(orderList);
    });
}

// Renvoit un produit selon l'id donné
function getProduct(id, callback) {
    connection.query(_getProduct, [id], function(err, rows, fields) {
        if (err) throw err;
        // La requête renvoit une ligne par image différente du produit, on doit donc recomposer en liste
        imageList = []
        for (product of rows) {
        	imageList.push(product.image);
        }

        rows[0].image = imageList; // On recompose à partir du 1er resultat, par exemple
        callback(rows[0]);
    });
}

// Renvoit le détail d'une commande, par son id
function getOrder(id, callback) {
    connection.query(_getOrder, [id], function(err, rows, fields) {
        if (err) throw err;
        // La requête renvoit une ligne par image différente du produit, on doit donc recomposer en liste
        productList = []
        for (order of rows) {
        	productList.push({
				id: order.product_id,
				name: order.product,
				option: order.option,
				nb: order.nb,
				price: order.product_price,
                image: order.cover_image
			});
        }

        rows[0].product = productList; // On recompose à partir du 1er resultat, par exemple
        callback(rows[0]);
    });
}

// Renvoit l'email de l'utilisateur d'une commande par son id
function getOrderEmail(id, callback) {
    connection.query(_getOrderEmail, [id], function(err, rows, fields) {
        if (err) throw err;
        callback(rows[0]); // on renvoit seulement 1 email (le seul à priori)
    });
}

// Renvoit les commandes passées d'un utilisateur
function getUserOrder(user_id, callback) {
    connection.query(_getUserOrder, [user_id], function(err, rows, fields) {
        if (err) throw err;
        callback(rows); 
    });
}

// Renvoit l'email d'un utilisateur
function getUserEmail(user_id, callback) {
    connection.query(_getUserEmail, [user_id], function(err, rows, fields) {
        if (err) throw err;
        callback(rows[0]); 	
    });
}

// Ajoute le produit général à la BDD
function addProduct(data) {
    data.images = JSON.parse(data.images)
	var queryParam = [data.name, data.description, data.price, data.type, data.images[0], data.collection]
	connection.query(_addProduct, queryParam, function(err, result) {
	    if (err) throw err;
	    productId = result.insertId;

	    // Ajoute le champ Clothe ou Poster sur la BDD
		switch (data.type) {
			case 'clothe':
				connection.query(_addClothe, [productId, data.composition], function(err, result) {
				    if (err) throw err;
				});
				break;

			case 'print':
				connection.query(_addPrint, [productId, data.size, data.weight], function(err, result) {
				    if (err) throw err;
				});
				break;

            case 'accessory':
                connection.query(_addAcc, [productId, data.acc_type], function(err, result) {
                    if (err) throw err;
                });
                break;
		}	

		// On ajoute une par une les images à la BDD
		for (image of data.images) {
			connection.query(`INSERT INTO image (name) VALUES (?)`, [image], function(err, result) {
			    if (err) throw err;
			    var imageId = result.insertId;

			    // On lie les images au produit dans la BDD
			    var linkImageProduct = `INSERT INTO product_image (product_id, image_id) VALUES (?, ?)`;
			    connection.query(linkImageProduct, [productId, imageId], function(err, result) {
				    if (err) throw err;
				});
			});
		}
	});
}

// On ajoute une commande à l'historique de la BDD
function addOrder(cart, callback) {
    if (!cart.products.length) return;

    // on calcule le prix totale depuis la BDD (pour plus de securité)
    checkCart(cart, function(new_cart) {
    	cart = new_cart;

        // On ajoute la commande à la BDD
        var queryParam = [
        	cart.user_id, cart.total_cost, cart.subtotal_cost, cart.shipping_cost, cart.shipping_address.string, 
			cart.billing_address, cart.payment_method, cart.shipping_method
		];
        connection.query(_addOrder, queryParam, function(err, result) {
            if (err) throw err;
            orderId = result.insertId;

    		// On construit la query de liaison entre produit et commande
    		var queryParam = [];
			var linkOrderContent = `INSERT INTO order_content (order_id, product_id, \`option\`, nb) VALUES `;
			for (i=0; i<cart.products.length; i++) {
				if (i) linkOrderContent += `,`;
				linkOrderContent += `(?, ?, ?, ?)`; // Ajoute le nom à la requête 
				queryParam.push(orderId, cart.products[i].id, cart.products[i].option, cart.products[i].cart_qty)
			}

			// On lie les produits avec la commande
            connection.query(linkOrderContent, queryParam, function(err, result) {
	            if (err) throw err;
	            callback(cart, orderId); // on termine avec la callback
	        });
        });
    });
}

// Change l'adresse d'un utilisateur
function editUserInfo(data, callback) {
    connection.query(_editUserInfo, data, function(err, rows, fields) {
        if (err) throw err;
        callback(rows); 	
    });
}

// Change les infos d'un utilisateur
function editUserAddress(data, callback) {
    connection.query(_editUserAddress, data, function(err, rows, fields) {
        if (err) throw err;
        callback(rows); 	
    });
}

// Change le paramètre newsletter d'un utilisateur
function editUserNewsLet(data, callback) {
    connection.query(_editUserNewsLet, data, function(err, rows, fields) {
        if (err) throw err;
        callback(rows); 	
    });
}

// Change l'ancien mot de passe par un nouveau, après verification
function editUserPassword([user_id, oldPassword, newPassword], callback) {
    // on vérifie d'abord que l'ancien mdp est valide ...
    getUser(connection, user_id, function(user) {
        // on compare les mdp ...
        bcrypt.compare(oldPassword, user.password, function(err, response) {
            if (response) {
                // On hash le nouveau mot de passe à enregistrer dans la DB
                bcrypt.hash(newPassword, 10, function(err, hashedPassword) {                        
                    // on modifie le nouveau mot de passe
                    connection.query(_editUserPassword, [hashedPassword, id], function(err, rows, fields) {
                        if (err) throw err;
                        callback(rows);
                    });
                });
            } 
            else {
            	callback(false);
            }
        });
    });
}

// Modifie le produit général à la BDD
function updateProduct (data) {
    data.image = JSON.parse(data.image)
	var queryParam = [data.name, data.description, data.price, data.available, data.type, data.image[0], data.collection, data.id]
	connection.query(_updateProduct, queryParam, function(err, result) {
	    if (err) throw err;

	    // On modifie égalalement les tables clothe ou poster
		switch (data.type) {
			case 'clothe':

				connection.query(_updateClothe, [data.composition, data.id], function(err, result) {
				    if (err) throw err;
				});
				break;

			case 'print':
				connection.query(_updatePrint, [data.size, data.weight, data.id], function(err, result) {
				    if (err) throw err;
				});
				break;

            case 'accessory':
                connection.query(_updateAcc, [data.acc_type, data.id], function(err, result) {
                    if (err) throw err;
                });
                break;
		}

		// On supprime d'avance toutes les connections entre le produits et des images pour les refaire
		connection.query(`DELETE FROM product_image WHERE product_id = ?`, [data.id], function(err, rows, fields) {
			if (err) throw err;

			// On verifie les images une par une
			for (image of data.image) {
				connection.query(`SELECT * FROM image WHERE name = ?`, [image], function(err, rows, fields) {
				    if (err) throw err;

				    // Si l'image n'existe pas, on l'ajoute à la BDD
				    if (!rows.length) {
						// Sinon on ajoute l'image et le lien
						connection.query(`INSERT INTO image (name) VALUES (?)`, [image], function(err, result) {
						    if (err) throw err;
						    // On lie l'image au produit dans la BDD
						    var linkImageProduct = `INSERT INTO product_image (product_id, image_id) VALUES (?, ?)`;
						    connection.query(linkImageProduct, [data.id, result.insertId], function(err, result) {
							    if (err) throw err;
							});
						});
					} 
					else {
					    // On créer le lien entre le produit et l'image			    
					    var linkImageProduct = `INSERT INTO product_image (product_id, image_id) VALUES (?, ?)`;
					    connection.query(linkImageProduct, [data.id, rows[0].id], function(err, result) {
						    if (err) throw err;
						});
					}
				});
			}
		});
	});
}

// Met à jour une commande selon le status passé en paramètre
function updateOrder(status, id) {
    connection.query(_updateOrder, [status, id], function(err, rows, fields) {
        if (err) throw err;
    });
}

// Supprime un produit de la BDD
function removeProduct (id) {
	// On supprime le produit de la BDD
    connection.query(_removeProduct, [id], function(err, rows, fields) {
        if (err) throw err;
    });
    // On supprime les vêtement ou poster dediés
    connection.query(`DELETE FROM clothe WHERE product_id=?`, [id], function(err, rows, fields) {
        if (err) throw err;
    });
    connection.query(`DELETE FROM print WHERE product_id=?`, [id], function(err, rows, fields) {
        if (err) throw err;
    });
    connection.query(`DELETE FROM accessory WHERE product_id=?`, [id], function(err, rows, fields) {
        if (err) throw err;
    });
    // On supprime également les lien entre le produit et leurs images
    connection.query(`DELETE FROM product_image WHERE product_id=?`, [id], function(err, rows, fields) {
        if (err) throw err;
    });
}

// Supprime un produit de la BDD
function removeOrder (id) {
	// On supprime la commande de la BDD
    connection.query(_removeOrder, [id], function(err, rows, fields) {
        if (err) throw err;
    });
    // On supprime les liens entre la commande et les produits
    connection.query(`DELETE FROM order_content WHERE order_id=?`, [id], function(err, rows, fields) {
        if (err) throw err;
    });
}

// Supprime un produit de la BDD
function removeUser (id, callback) {
    connection.query(_removeOrder, [id], function(err, rows, fields) {
        if (err) throw err;
        callback();
    });
}

module.exports = {
	login: login,
	signUp: signUp,
	checkCart: checkCart,

	getAllUser: getAllUser,
	getAllProduct: getAllProduct,
	getAllOrder: getAllOrder,
	getAllOrderUser: getAllOrderUser,
	getProduct: getProduct,
	getOrder: getOrder,
	getOrderEmail: getOrderEmail,
	getUserOrder: getUserOrder,
	getUserEmail: getUserEmail,

	addProduct: addProduct,
	addOrder: addOrder,

	editUserPassword: editUserPassword,
	editUserAddress: editUserAddress,
	editUserInfo: editUserInfo,
	editUserNewsLet: editUserNewsLet,

	updateProduct: updateProduct,
	updateOrder: updateOrder,

	removeProduct: removeProduct,
	removeOrder: removeOrder,
	removeUser: removeUser,

	init: init
};
