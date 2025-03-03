const express = require("express");
const router = express.Router();
// const uploadUser = require('../../server').uploadUser; 
const OrderController = require("../../controllers/Admin/OrderController");
const checkRole = require("../../controllers/Admin/checkAuth");

router.get('/admin/order/list', checkRole(), OrderController.get);

router.get('/admin/order/update/:id', checkRole(), OrderController.updateFrom);
router.patch('/admin/order/update/:id', checkRole(), OrderController.update);

router.delete('/admin/order/delete/:id', checkRole(), OrderController.delete);

module.exports = router;