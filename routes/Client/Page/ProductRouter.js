const express = require('express');
const router = express.Router();
const uploadProduct = require('../../../server').uploadProduct; 
const ProductControllerC = require("../../../controllers/Client/Page/ProductController");

console.log(uploadProduct); 

router.get('/product', ProductControllerC.get);
router.get('/productDetail/:id', ProductControllerC.getProductDetail);

router.post("/product/comment",ProductControllerC.comments);
// router.delete("/comment/delete/:id", CommentController.deleteComment);

module.exports = router;
