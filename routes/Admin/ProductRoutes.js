const express = require('express');
const router = express.Router();
const uploadProduct = require('../../server').uploadProduct; 
const ProductControllerC = require("../../controllers/Client/Page/ProductController");
const ProductControllerA = require("../../controllers/Admin/ProductController");

const checkRole = require("../../controllers/Admin/checkAuth");

console.log(uploadProduct); 

router.get('/admin',checkRole(), ProductControllerA.getAdmin);


router.get('/admin/product/list',checkRole(), ProductControllerA.get);

router.get('/admin/product/create',checkRole(), ProductControllerA.createForm);
router.post("/admin/product/create",checkRole(), uploadProduct.array("images", 7), ProductControllerA.create);

router.get('/admin/product/edit/:id',checkRole(), ProductControllerA.editForm);
router.put('/admin/product/edit/:id', checkRole(), uploadProduct.array('images',7), ProductControllerA.edit);

router.patch('/admin/product/isDelete/:id', checkRole(), ProductControllerA.isDelete);

router.post("/admin/product/delete-image/:id", checkRole(),ProductControllerA.deleteImage);


module.exports = router;
