const express = require("express");
const router = express.Router();
const uploadUser = require('../../server').uploadUser;
const UserController = require("../../controllers/Admin/UserController");
const TrashController = require("../../controllers/Admin/TrashController");
const ProductControllerA = require("../../controllers/Admin/ProductController");
const checkRole = require("../../controllers/Admin/checkAuth");
const CategoryController = require("../../controllers/Admin/CategoryController");


router.get('/admin/trash', checkRole(), TrashController.getTrash);

router.delete('/admin/product/delete/:id', checkRole(0), ProductControllerA.delete);

router.patch('/admin/category/restore/:id', checkRole(), CategoryController.restore);
router.patch('/admin/product/restore/:id', checkRole(), ProductControllerA.restore);


module.exports = router;
