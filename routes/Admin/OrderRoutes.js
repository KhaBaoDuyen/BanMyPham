const express = require("express");
const router = express.Router();
// const uploadUser = require('../../server').uploadUser; 
const OrderController = require("../../controllers/Admin/OrderController");


router.get('/admin/order/list', OrderController.get);

router.get('/admin/order/update/:id', OrderController.updateFrom);
router.patch('/admin/order/update/:id', OrderController.update);

router.delete('/admin/order/delete/:id', OrderController.delete);

module.exports = router;