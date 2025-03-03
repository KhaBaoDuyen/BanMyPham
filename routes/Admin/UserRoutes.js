const express = require("express");
const router = express.Router();
const uploadUser = require('../../server').uploadUser;
const UserController = require("../../controllers/Admin/UserController");
const checkRole = require("../../controllers/Admin/checkAuth");

router.get('/admin/user/list', checkRole(), UserController.get);

router.get('/admin/user/update/:id', checkRole(), UserController.updateFrom);
router.patch('/admin/user/update/:id', checkRole(), uploadUser.single("image"), UserController.update);

router.delete('/admin/user/delete/:id', checkRole(), UserController.delete);

module.exports = router;
