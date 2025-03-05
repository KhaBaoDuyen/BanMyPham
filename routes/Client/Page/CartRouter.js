const express = require('express');
const router = express.Router();
const uploadProduct = require('../../../server').uploadProduct;
const CartController = require("../../../controllers/Client/Page/CartController");
const { CartModel } = require('../../../models/Associations');
const OrderController = require('../../../controllers/Client/Page/OrderController')
const { validateCheck } = require("../../../validator/validateCheck");
const { validationResult } = require("express-validator");


router.get("/cart", CartController.getCart);
router.delete('/deleteCart/:id', CartController.delete);
router.post('/addCart', CartController.create);


router.get("/checkout", OrderController.getCheckout);

router.post('/create', OrderController.create);
router.get('/vnpay_return', OrderController.vnpayReturn);

router.get('/thank', OrderController.thank);

module.exports = router;
