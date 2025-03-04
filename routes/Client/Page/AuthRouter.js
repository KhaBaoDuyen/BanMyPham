const express = require('express');
const { body } = require("express-validator");
const router = express.Router();
const uploadProduct = require('../../../server').uploadProduct;
const AuthController = require("../../../controllers/Client/Page/AuthController");
const checkRole = require("../../../controllers/Admin/checkAuth");

router.get('/resgister', AuthController.getRegister);

router.post('/resgister', AuthController.create);

router.get('/login',AuthController.getLogin);

router.post("/login", AuthController.login);

router.get("/logout", AuthController.logout);

router.get("/resetPassword", AuthController.getReset);
router.post("/resetPassword", AuthController.resetPasswod);

router.get('/resetPassword/:id/:token', AuthController.getResetPassword);

router.post('/updatePassword/:id/:token', AuthController.updatePassword)

module.exports = router;
