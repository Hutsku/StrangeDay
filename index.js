
// ============================================= INITALIZATION ============================================

console.log('Initalisation du site web ...')
var config = require('./config.js');

// Si le serveur tourne en local, récupère les cred d'un fichier local. (pas de requête vault)
var path_stripe = 'stripe'; 
var path_paypal = 'paypal';
if (config.local_test) {
    console.log('/!\\ LE SITE EST EN VERSION TEST LOCAL /!\\');
    var cred = require('./local_credentials.js');
}
if (!config.production) {
    console.log("/!\\ LE SITE N'EST PAS EN PRODUCTION /!\\ - Les payements sont désactivés ");
    var path_stripe = 'stripe_test';
    var path_paypal = 'paypal_test';
}

// get new instance of the client
console.log('Configuration de vault');
var vault      = require("node-vault")(config.vault);

// On importe tout les modules necessaires
console.log('Importation des modules ...');
var query      = require('./query.js');
var cart       = require('./cart.js');
const path     = require('path');
var express    = require('express');
var session    = require('express-session');
var bodyParser = require("body-parser");
var multer     = require('multer')
const Stripe   = require('stripe')
const Email    = require('email-templates'); // include nodemailer

var upload;
function multer_init() {
    var storage = multer.diskStorage({
      destination: function (req, file, cb) {
        cb(null, path.resolve(__dirname, './public/img/'))
      },
      filename: function (req, file, cb) {
        cb(null, file.originalname)
      }
    })
    upload = multer({
        storage: storage,
        onFileUploadStart: function (file) {
            console.log('Start uploading file ...')
        },
        onFileUploadComplete: function (file) {
            console.log('Uploading complete !')
        },
        onError: function(err, next) {
            console.log('error', err);
            next(err);
        }
    }).any();
    console.log("> Multer configuré.");
};

var email;
var transporter;
function email_init (cred) {
    // setup transporter (mailtrap for test, gmail for production)
    var transport_mailtrap = config.email.mailtrap;
    var transport_gandi    = config.email.gandi;

    // edit the transporter with real credentials
    transport_gandi.auth = {
        user: cred.user, 
        pass: cred.pass  
    }

    transporter = transport_gandi;
    if (config.email.test) transporter = transport_mailtrap;

    // Build-up the email object (pour les email venant du site)
    email = new Email({
        views: config.email.views,
        message: {
            from: config.email.from
        },
        // uncomment below to send emails in development/test env:
        send: config.email.send,
        preview: config.email.preview,
        transport: transporter,
    });
    console.log("> Connection SMTP configuré.");
};

var stripe;
function stripe_init (cred) {
    stripe = Stripe(cred.secret); // test key
    console.log("> Stripe configuré (secret key).");
};

var admin_user;
function adminUser_init (cred) {
    // Liste des email (utilisateur) ayant accès au droit admin (gestion des articles et commandes)
    admin_user = cred;
    console.log('> Comptes admin reconnus.');
};

var app;
var urlencodedParser;
function app_init () {
    // init app et configure les cookies de session
    app = express();
    urlencodedParser = bodyParser.urlencoded({ extended: false });

    app.use(session(config.cookies));
    app.use(express.static(__dirname + '/public'));
    app.use('/scripts', express.static(__dirname + '/node_modules/'));
    app.use('/static', express.static(__dirname + '/public'));
    app.set('view engine', 'ejs');  

    app.use(function(req, res, next){
        // On met en place les variable de dev pour le frontend
        req.session.debug      = config.debug;
        req.session.production = config.production;
        next();
    });
    console.log("> Création de l'app et cookies de session configurés.");
};

// ---------------------- LAUNCH INIT -------------------

// Si on est en test local, on prend les id sur le fichier. Sinon, on utilise vault
var secret_stripe, secret_paypal;
if (config.local_test) {
    email_init(cred.email);
    query.init(cred.mysql);
    stripe_init(cred[path_stripe]);
    adminUser_init(cred.admin);
    secret_stripe = cred[path_stripe].public;
    secret_paypal = cred[path_paypal].client_id;
} 
else {
    vault.read('strangeday/email')
    .then(function(res) {
        email_init(res.data);
    }).catch(console.error);

    vault.read('strangeday/mysql')
    .then(function(res) {
        query.init(res.data);
    }).catch(console.error);

    vault.read(`strangeday/${path_stripe}`)
    .then(function(res) {
        stripe_init(res.data);
        secret_stripe = res.data.public;
    }).catch(console.error);

    vault.read('strangeday/admin')
    .then(function(res) {
        adminUser_init(Object.values(res.data));
    }).catch(console.error);

    vault.read(`strangeday/${path_paypal}`)
    .then(function(res) {
        secret_paypal = res.data.client_id;
    }).catch(console.error);
}

// init the other functionnality (without vault)
multer_init();
app_init();

// ============================================= GLOBAL FUNCTIONS ========================================

function checkAdmin(email) {
    return admin_user.includes(email);
}

// Génère la facture à joindre avec le mail de reçu
function createInvoice(parameter) {
    let user = parameter.user;
    let customerInfos = `
    ====== DETAILS CLIENT ======
    Nom & prenoms: ${user.name}
    Adresse email: ${user.email}
    Numéro téléphone: ${user.tel}

    ====== DETAILS LIVRAISON ======
    Adresse livraison: ${parameter.shipping_address.string}
    Adresse facturation: ${parameter.billing_address}
    Methode de livraison: Colissimo
    `;
    let orderProducts = `
    ====== DETAIL COMMANDE ======
    Date de facturation: ${parameter.date}
    Numéro de commande: ${parameter.order_id}
    Mode de paiement: ${parameter.billing_method}
    `;
    let orderInfos = `
    
    Sous-total: ${parameter.subtotal_cost}€
    Frais de livraison: ${parameter.shipping_cost}€
    TOTAL: ${parameter.total_cost}€
    `;
    let invoiceInfos = `
    TVA non applicable en vertu de l'art. 239B du CGI
    SIRET: 
    `;
    
    // On ajoute à la chaine tout les articles de la commande
    for (product of parameter.products) {
        // la mise en forme étrange est normale
        let textProduct = `
    ${product.name} ${product.option} (x${product.cart_qty}) ${product.price}€`;

        orderProducts += textProduct;
    }

    return customerInfos + orderProducts + orderInfos + invoiceInfos;
}

// Envoit un email avec le template et les paramètres specifiés
function sendEmail(template, emailTo, parameter) {
    email.send({
        template: template,
        message: {
            to: emailTo,
            attachments: [
                {
                  filename: 'invoice.txt',
                  content: createInvoice(parameter)
                }
            ]
        },
        locals: parameter,
    })
    .then()
    .catch(console.error);
}

function contactEmail(emailFrom, parameter) {
    // Email pour communiquer avec le site (via le formulaire)
    var email_contact = new Email({
        views: config.email.views,
        message: {
            from: emailFrom
        },
        send: config.email.send,
        preview: config.email.preview,
        transport: transporter,
    });  
    email_contact.send({
        template: 'contact',
        message: {
            to: 'contact@strangeday.fr'
        },
        locals: parameter,
    })
    .then()
    .catch(console.error);
}

// ================================================ ROUTES ===============================================

console.log('Création des routes POST et GET')
app.use(function(req, res, next) {
    // Main handler, se déclenche à chaque route
    let whitelist = ['/reveal', '/newsletter-success', '/submit-newsletter']

    if (!config.reveal) next()
    else if (whitelist.includes(req.originalUrl)) next() // Si c'est une page speciale, alors on laisse
    else if (req.session.unlock) next() // Si l'accès est debloqué, tout passe
    else if (req.originalUrl == '/unlock') {
        req.session.unlock = true; // On debloque l'accès au site momentanement
        res.redirect('/mainpage') // Et on redirige vers la page principale
    }
    else res.redirect('/countdown') // ... sinon on redirige vers la page de reveal
})

.get('/', function(req, res) {
    // Renvoit par défaut vers la page principale
    res.redirect('/mainpage');
})

.get('/unlock', function(req, res) {
    // Renvoit par défaut vers la page principale
    res.redirect('/mainpage');
})

.get('/login', function(req, res) {
    // Affiche la page complète de connection
    if (req.session.logged) res.redirect('/')
    else res.render('login.ejs', {session: req.session});
})

.get('/quit', function(req, res) {
    req.session.username = '';
    req.session.logged = false;
    req.session.admin = false;
    req.session.account = false;

    // On met à jour le panier si jamais
    req.session.cart = cart.refreshCart(req.session);

    res.redirect('/');
})

.get('/subscribe', function(req, res) {
    // Affiche la page d'inscription, de création de compte
    if (req.session.logged) res.render('/', {session: req.session});
    else res.render('subscribe.ejs', {session: req.session});
})

.get('/shop', function(req, res) {
    // Redirige vers la liste de tout articles du site
    res.redirect('/shop/all');
})

.get('/shop/:link', function(req, res) {
    // Affiche la liste des articles indiquées
    query.getAllProduct(function(products) {
        res.render('shop.ejs', {session: req.session, products: products, link: req.params.link});
    }, req.params.link);  
})

.get('/lookbook', function(req, res) {
    // Affiche la liste des articles indiquées
    res.render('lookbook.ejs', {session: req.session});
})

.get('/kezako', function(req, res) {
    // Affiche la liste des articles indiquées
    res.render('kezako.ejs', {session: req.session});
})

.get('/faq', function(req, res) {
    // Affiche la liste des articles indiquées
    res.render('faq.ejs', {session: req.session});
})

.get('/product/:id', function(req, res) {
    // Affiche la page d'un produit, selon l'id indiqué
    query.getProduct(req.params.id, function (product) {
        if (!product) {
            res.redirect('back');
        }
        else {
            // On envoit les données du produit à la page
            res.render('product.ejs', {
                product: product,
                session: req.session
            });  
        }     
    });
})

.get('/order-detail/:id', function(req, res) {
    // Affiche le détail d'un commande, par son id
    query.getOrder(req.params.id, function (order, error) {
        // On verifie que l'utilisateur est connecté et que la commande existe
        if (order) {
            res.render('order-detail.ejs', {
                order: order,
                session: req.session
            });
        }
        else {
            // sinon on recharge la page
            req.session.alert = error;
            res.redirect('back');
        }
    });
})

.get('/cart', function(req, res) {
    // Affiche la page du panier, avec bouton de validation et posibilité de modifier
    if (!req.session.cart) {
        req.session.cart = {
            products: [],
            nb_products: 0,
            subtotal_cost: 0,
            shipping_cost: 4.95, // valeur par défaut si non connecté
            total_cost: 4.95,
        }
    }
    if (req.session.account) {
        req.session.cart.shipping_cost = cart.getShippingCost(req.session.account.country, req.session.account.postal_code);
    }
    res.render('cart.ejs', {session: req.session});
})

.get('/mainpage', function(req, res) {
    // Affiche la page principale (avec tout les produits)
    query.getAllProduct(function(products) {

        // On envoit les données du produit à la page
        res.render('mainpage.ejs', {
            products: products, 
            session: req.session
        });
    });
})

.get('/account', function(req, res) {
    // Affiche la page principale du compte utilisateur
    res.redirect('/account/overview');
})

.get('/account/:link', function(req, res) {
    // on vérifie que l'utilisateur est bien connecté
    if (req.session.logged) {
        if (req.params.link == "order") {
            // On va chercher toutes les commandes de l'utilisateur
            query.getUserOrder(req.session.account.id, function(data, error) {
                res.render('account.ejs', {session: req.session, link: req.params.link, orders: data});  
            });
        }
        else if (req.params.link == "newsletter") {
            query.getUserNewsletter(req.session.account.id, function(data) {
                res.render('account.ejs', {session: req.session, link: req.params.link, newsletter: !!data});
            })
        }
        else res.render('account.ejs', {session: req.session, link: req.params.link});
    }
    else {
        // sinon on redirige vers l'écran de connexion
        res.redirect('/login');
    }
})

.get('/contact', function(req, res) {
    // Affiche la page "contact" du site, avec les referencements etc.
    res.render('contact.ejs', {session: req.session});
})

.get('/test-dev', function (req, res) {
    createInvoice(req.session.account)
    res.redirect('back');
})

.get('/countdown', function (req, res) {
    // Affiche une page défaut avant que le site soit disponible
    res.render('countdown.ejs', {session: req.session});
})

// ----------------------- ADMIN PAGE ------------------------

.get('/admin-products-list', function(req, res) {
    // on vérifie que l'utilisateur est bien admin (double verification si jamais)
    if (req.session.admin && checkAdmin(req.session.account.email)) {
        query.getAllProduct(function(products) {
            res.render('admin-products-list.ejs', {session: req.session, products: products});
        });
    }
    else {
        // sinon on redirige vers l'écran de connexion
        res.redirect('/mainpage');
    } 
})

.get('/admin-edit-product/:id', function(req, res) {
    // on vérifie que l'utilisateur est bien admin (double verification si jamais)
    if (req.session.admin && checkAdmin(req.session.account.email)) {
        query.getProduct(req.params.id, function(product) {
            res.render('admin-edit-product.ejs', {
                product: product,
                session: req.session
            });
        });
    }
    else {
        // sinon on redirige vers l'écran de connexion
        res.redirect('/admin-products-list');
    } 
})

.get('/admin-add-product', function(req, res) {
    // on vérifie que l'utilisateur est bien admin (double verification si jamais)
    if (req.session.admin && checkAdmin(req.session.account.email)) {
        res.render('admin-add-product.ejs', {session: req.session});
    }
    else {
        // sinon on redirige vers l'écran de connexion
        res.redirect('/admin-products-list');
    } 
})

.get('/admin-remove-product/:id', function(req, res) {  
    // on vérifie que l'utilisateur est bien admin (double verification si jamais)
    if (req.session.admin && checkAdmin(req.session.account.email)) {
        query.removeProduct(req.params.id);
        req.session.alert = "remove product";
        res.redirect('back');
    }
    else {
        // sinon on redirige vers l'écran de connexion
        res.send('no admin');
    }
})

.get('/admin-orders-list', function(req, res) {
    // on vérifie que l'utilisateur est bien admin (double verification si jamais)
    if (req.session.admin && checkAdmin(req.session.account.email)) {
        query.getAllOrderUser(function(orders) {
            res.render('admin-orders-list.ejs', {session: req.session, orders: orders});
        });
    }
    else {
        // sinon on redirige vers l'écran de connexion
        res.redirect('/mainpage');
    } 
})

.get('/admin-update-order/:id', function(req, res) {
    // on vérifie que l'utilisateur est bien admin (double verification si jamais)
    if (req.session.admin && checkAdmin(req.session.account.email)) {
        query.getOrder(req.params.id, function(order) {
            // on definit le nouveau statut de la commande selon son état précédant
            switch (order.state){
                case 'waiting': 
                    var state = 'confirmed';
                    break;
                case 'confirmed': 
                    var state = 'shipped';
                    break;
                default: 
                    var state = 'waiting';
            }

            // Si la commande est envoyée, on récupère l'email du client et on lui envoit un email de confirmation
            if (state == "shipped") {
                query.getUserEmail(order.user_id, function(email) {
                    sendEmail('order-shipped', email.email, {
                        order_id: req.params.id,
                        track_id: req.query.trackNumber
                    });
                });
            }
 
            query.updateOrder(state, req.params.id, req.query.trackNumber);
            req.session.alert = "order updated";
            res.redirect('back');
        });
    }
})

.get('/admin-remove-order/:id', function(req, res) {
    // on vérifie que l'utilisateur est bien admin (double verification si jamais)
    if (req.session.admin && checkAdmin(req.session.account.email)) {
        // On envois un email d'explication à l'utilisateur de la commande
        query.getOrderEmail(req.params.id, function(email) {
            sendEmail('order-removed', email.email);

            // Puis on supprime la commande de la BDD
            query.removeOrder(req.params.id)
            req.session.alert = "order removed";
            res.redirect('back');
        });
    }
})

.get('/admin-stat', function(req, res) {
    // on vérifie que l'utilisateur est bien admin (double verification si jamais)
    if (req.session.admin && checkAdmin(req.session.account.email)) {
        query.getStat(function(data) {
            res.render('admin-stat.ejs', {session: req.session, data: data});
        });
    }
    else {
        // sinon on redirige vers l'écran de connexion
        res.redirect('/mainpage');
    } 
})

// ------------------------ PAYOUT  --------------------------

.get('/payout-infos', function(req, res) {
    // Si le client n'a pas de panier, on le renvoit à cet page
    if (!req.session.cart.products.length) {
        res.redirect('/cart');
        return false;
    }

    // Si le client est déjà log, on passe à la 2e étape
    if (req.session.logged) {
        res.redirect('/payout-shipping');
    }
    else {
        res.render('payout-infos.ejs', {
                session: req.session, 
                subtotal_cost: req.session.cart.subtotal_cost,
                shipping_cost: req.session.cart.shipping_cost,
                total_cost: req.session.cart.total_cost,
                user: req.session.account
            }
        );
    }
})

.get('/payout-shipping', function(req, res) {
    // Verifie si les condition du payout sont valides (panier + log)
    if (!req.session.cart) {
        // Si le client n'a pas de panier, on le renvoit à cet page
        res.redirect('/cart');
    }
    else if (!req.session.logged) {
        // Si le client n'est pas connecté, on le renvoie sur la section appropriée
        res.redirect('/payout-infos');
    }
    else {
        res.render('payout-shipping.ejs', {
                session: req.session, 
                user: req.session.account
            }   
        );
    }  
})

.get('/payout-final', function(req, res) {
    if (!req.session.cart) {
        // Si le client n'a pas de panier, on le renvoit à cet page
        res.redirect('/cart');
        return false;
    }
    else if (!req.session.logged) {
        // Si le client n'est pas connecté, on lui renvois sur la section appropriée
        res.redirect('/payout-infos');
        return false;
    }

    if (!config.production) req.session.alert = 'payment disabled'; // Avertissement si mode test

    // On verifie le panier, on corrige les cookies et on valide le prix
    query.checkCart(req.session.cart, function(new_cart) {
        req.session.cart = new_cart;

        // On prépare le payement carte via Stripe
        amount = Math.round(new_cart.total_cost*100); // on converti en valeur prise en charge par stripe
        stripe.paymentIntents.create(
        {
            amount: amount,
            currency: 'eur',
            payment_method_types: ['card'],
        }, 
        function (err, paymentIntent) {
            res.render('payout-final.ejs', {
                session: req.session, 
                client_secret: paymentIntent.client_secret, 
                cred_stripe: secret_stripe,
                cred_paypal: secret_paypal,
                total_cost: new_cart.total_cost,
                subtotal_cost: new_cart.subtotal_cost,
                shipping_cost: new_cart.shipping_cost,
                user: req.session.account,
            });
        });        
    });
})

.get('/payout', function(req, res) {
    // On renvoit vers la 1ère étape par défaut
    res.redirect('/payout-infos');
})

.get('/payment-success', function(req, res) {
    // A afficher lorsque le payement a été effectué
    res.render('payment-success.ejs', {session: req.session});
})

.get('/newsletter-success', function(req, res) {
    // A afficher lorsque le payement a été effectué
    res.render('newsletter-success.ejs', {session: req.session});
})

// ============================================= POST ===================================================

// ----------------------- ADMIN EDIT -------------------------------

.post('/admin-add-product', urlencodedParser, function(req, res) {    
    // on vérifie que l'utilisateur est bien admin (double verification si jamais)
    if (req.session.admin && checkAdmin(req.session.account.email)) {
        query.addProduct(req.body); // On ajoute le produit dans la BDD
        console.log('-> Article ajouté');

        req.session.alert = "add product";
        res.redirect('back');
    }
    else {
        // sinon on redirige vers l'écran de connexion
        res.send('no admin');
    }
})

.post('/admin-edit-product', urlencodedParser, function(req, res) {  
    // on vérifie que l'utilisateur est bien admin (double verification si jamais)
    if (req.session.admin && checkAdmin(req.session.account.email)) {
        query.updateProduct(req.body); // Modifie le produit dans la BDD

        req.session.alert = "edit product";
        res.redirect('back');
    }
    else {
        // sinon on redirige vers l'écran de connexion
        res.send('no admin');
    }
})

.post('/upload-img', urlencodedParser, function(req, res) {
    // Upload des images sur le serveur
    upload(req, res, function (err) {
        if (err instanceof multer.MulterError) {
            console.log(err)
        } else if (err) {
            console.log(err)
        }

        console.log('-> File uploaded')
        res.end()
    });
})

// ----------------------- PAYOUT OPTION  ---------------------------

.post('/add-cart', urlencodedParser, function(req, res) {
    // On reconstruit et converti les données envoyées
    product = {
        id: parseInt(req.body.id),
        name: req.body.name,
        available: parseInt(req.body.available),
        price: parseFloat(req.body.price),
        option: req.body.option,
        cart_qty: parseInt(req.body.cart_qty),
        image: req.body.img
    }

    req.session.cart = cart.addCart(req.session, product);
    res.send(req.session.cart);
})

.post('/remove-cart', urlencodedParser, function(req, res) {
    // si il n'y a pas de cookies, on ne fait rien
    if (!req.session.cart) res.redirect('back');

    req.session.cart = cart.removeCart(req.session, req.body);
    res.send(req.session.cart);
})

.post('/valid-cart', urlencodedParser, function(req, res) {
    // on remplace le panier par celui envoyé (en le convertissant)
    req.session.cart = cart.convertCart(req.body.cart)
    res.send('ok')
})

.post('/valid-shipping', urlencodedParser, function(req, res) {
    // valide et enregistre les paramètre de livraison
    req.session.cart = cart.validShipping(req.session.cart, req.body);
    res.send('ok')
})

.post('/add-order', urlencodedParser, function(req, res) {
    // On met à jour les infos
    req.session.cart.payment_method = req.body.payment_method;
    req.session.cart.billing_address = req.body.billing_address;
    req.session.cart.user_id = req.session.account.id;

    // On ajoute la commande à la BDD
    query.addOrder(req.session.cart, function(order, orderId) {
        console.log(`-> Nouvelle commande passée ! | ${req.session.username} ${order.total_cost}`)
        let date = new Date()
        // on envoit un email de confirmation de commande
        sendEmail('order', req.session.account.email, {
            user: req.session.account,
            name: req.session.username,
            products: order.products,
            subtotal_cost: order.subtotal_cost,
            shipping_cost: order.shipping_cost,
            total_cost: order.total_cost,
            shipping_address: order.shipping_address,
            billing_address: order.billing_address,
            billing_method: req.body.payment_method,
            date: `${date.getDate()}/${date.getMonth()+1}/${date.getFullYear()}`,
            order_id: orderId
        });

        req.session.alert = "add order";
        req.session.cart = 0;// on vide le panier
        res.send('ok');
    });
})

// ------------------------ ACCOUNT EDIT ---------------------------

.post('/edit-password', urlencodedParser, function(req, res) {
    // Change l'ancien mot de passe d'un utilisateur par un nouveau
    let id = req.session.account.id;
    let oldPassword = req.body.oldPassword;
    let newPassword = req.body.newPassword;

    query.editUserPassword([id, oldPassword, newPassword], function(error) {
        if (error) {
            req.session.error = "Bad password";
            res.send(error);    
        }
        else {
            // on met à jour les cookies
            req.session.alert = "edit account";
            res.send('ok'); // on recharge la page    
        }
    })
})

.post('/edit-address', urlencodedParser, function(req, res) {
    // Change l'adresse d'un utilisateur
    var id = req.session.account.id;
    var address1 = req.body.address1;
    var address2 = req.body.address2;
    var postal_code = req.body.postal_code;
    var city = req.body.city;
    var country = req.body.country;
    var state = req.body.state;

    var queryParam = [address1, address2, city, country, state, postal_code, id]
    query.editUserAddress(queryParam, function(error) {
        if (error) {
            res.send(error);
        }
        else {
            // on met à jour les cookies
            req.session.alert = "edit account";
            req.session.account.address1 = address1;
            req.session.account.address2 = address2;
            req.session.account.postal_code = postal_code;
            req.session.account.city = city;
            req.session.account.state = state;
            req.session.account.country = country;

            res.send('back'); // on recharge la page
        }
    });
})

.post('/edit-infos', urlencodedParser, function(req, res) {
    // Permet de changer les infos d'un utilisateur
    var name = req.body.name;
    var email = req.body.email;
    var tel = req.body.tel;
    var id = req.session.account.id

    query.editUserInfo([name, email, tel, id], function(error) {
        // Si l'utilisateur a été trouvé
        if (error) {
            res.send(error);
        }
        else {
            // on met à jour les cookies
            req.session.alert = "edit account";
            req.session.account.name = name;
            req.session.username = name;
            req.session.account.email = email;
            req.session.account.tel = tel;

            res.send('ok'); // on recharge la page
        }
    });
})

.post('/edit-newsletter', urlencodedParser, function(req, res) {
    // Change l'option de newsleter d'un utilisateur
    var email = req.session.account.email;
    var newsletter = req.body.newsletter == 'true'; // converti en bool

    query.editUserNewsLet([newsletter, email], function(result) {
        // on met à jour les cookies
        req.session.alert = "edit account";
        res.send('ok'); // on recharge la page
    });
})

// ---------------------------- AUTRES ---------------------------

.post('/contact', urlencodedParser, function(req, res) {
    // Envoie un email via le formulaire de contact
    contactEmail(req.body.email, req.body);
    res.render('contact-success.ejs', {session: req.session});
    //sendEmail('contact', config.email.from, req.body)
})

.post('/login', urlencodedParser, function(req, res) {
    // Connection d'un utilisateur grâce à son email
    var password = req.body.password;
    var email = req.body.email;

    query.login([email, password], function(user, error) {
        // Si l'email donné est bien enregistré ...
        if (user) {
            req.session.username = user.name;
            req.session.account = user;
            req.session.logged = true;
            req.session.alert = "login";
            req.session.admin = checkAdmin(email);

            // On met à jour le panier si jamais
            req.session.cart = cart.refreshCart(req.session);
            res.redirect('/');
        } 
        else {
            req.session.error = error;
            res.send(error);
        }
    }); 
})

.post('/sign-up', urlencodedParser, function(req, res) {
    query.signUp(req.body, function(user, error) {
        if (user) {
            // on envoit un email de confirmation
            sendEmail('subscribe', user.email, {name: user.username});
            req.session.username = user.name;
            req.session.account = user;
            req.session.logged = true;
            req.session.alert = "signup";
            req.session.admin = checkAdmin(email);

            // On met à jour le panier si jamais
            req.session.cart = cart.refreshCart(req.session);
            console.log(`-> Nouveau compte inscrit ! ${user.username} ${user.email}`)
            res.redirect('/');
        }
        else {
            req.session.alert = "email already used"; // on stock l'erreur dans la seesion
            res.send(error);
        }
    })
})

.post('/logout', urlencodedParser, function(req, res) {
    req.session.username = '';
    req.session.logged = false;
    req.session.admin = false;
    req.session.account = false;

    // On met à jour le panier si jamais
    req.session.cart = cart.refreshCart(req.session);

    res.redirect('/');
})

.post('/unsubscribe', urlencodedParser, function(req, res) {
    // Efface le compte d'un utilisateur
    query.removeUser(req.session.account.id, function() {
        // On envoit un email d'adieu
        sendEmail('unsubscribe', req.session.account.email, {name: req.session.username});

        // On efface les cookies
        console.log('-> Desincription | '+req.session.username+' '+req.session.account.email)
        req.session.username = '';
        req.session.logged = false;
        req.session.admin = false;
        req.session.account = false;
        req.session.alert = "unsubscribe"

        res.redirect('/');
    }); 
})

.post('/resetNotif', urlencodedParser, function(req, res) {
    req.session.alert = false;
    res.end();
})

.post('/submit-newsletter', urlencodedParser, function(req, res) {
    // Efface le compte d'un utilisateur
    query.addNewsletter(req.body.email, function() {
        res.redirect('/newsletter-success');
    }); 
});

// ========================================================================================================

app.use(function(req, res, next){
    res.setHeader('Content-Type', 'text/plain');
    res.status(404).send('Page introuvable !');
});

// On ouvre le serveur sur le port 8080
console.log('Ouverture du serveur sur le port 8080')
app.listen(8080, 'localhost');