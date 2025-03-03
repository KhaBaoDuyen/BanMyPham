const express = require("express");
const router = express.Router();
const uploadCategory = require('../../server').uploadCategory;
const CategoryController = require("../../controllers/Admin/CategoryController");
const checkRole = require("../../controllers/Admin/checkAuth");

router.get('/admin/category/list', checkRole(), CategoryController.get);

router.get('/admin/category/create', checkRole(), CategoryController.createFrom);
router.post("/admin/category/create", checkRole(), uploadCategory.single("image"), CategoryController.create);

router.get('/admin/category/update/:id', checkRole(), CategoryController.updateFrom);
router.patch('/admin/category/update/:id', checkRole(), uploadCategory.single("image"), CategoryController.update);

router.delete('/admin/category/delete/:id', checkRole(), CategoryController.delete);

router.patch('/admin/category/isDelete/:id', checkRole(), CategoryController.isDelete);

module.exports = router;
