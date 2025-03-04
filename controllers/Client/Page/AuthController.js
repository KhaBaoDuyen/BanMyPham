const ProductModel = require('../../../models/ProductModel');
const UserModel = require('../../../models/UserModel');
const validatorUser = require("../../../validator/validatorUser");
const sanitizeInput = require("../../../validator/sanitize");
const bcrypt = require('bcrypt');
const express = require("express");
const { body, validationResult } = require("express-validator");
const fs = require("fs");
const path = require("path");
const jwt = require('jsonwebtoken');
const { Sequelize } = require('sequelize');
const { sendResetPasswordEmail } = require("../../../services/sendMaill");
const { verify } = require('crypto');
const { error } = require('console');

class AuthController {

   static async getRegister(req, res) {
      try {
         res.status(200).render('Client/Page/Auth/register', {
            layout: "Client/layout",
            title: "Đăng ký"
         });
      } catch (error) {
         res.status(500).json({ error: error.message });
      }
   }
   static async create(req, res) {
      try {

         let userInput = sanitizeInput(req.body);

         const { name, email, password } = userInput;

         let validationResult = validatorUser(userInput);

         if (Object.keys(validationResult.errors).length > 0) {
            return res.render("Client/Page/Auth/register", {
               layout: "Client/layout",
               title: "Đăng ký",
               errors: validationResult.errors || {},
               name: userInput.name || "",
               email: userInput.email || "",
               password: ""
            });

         }

         let existingUser = await UserModel.findOne({ where: { email } });
         if (existingUser) {
            return res.render("Client/Page/Auth/register", {
               layout: "Client/layout",
               title: "Đăng ký",
               errors: { email: "Email đã tồn tại!" },
               name: userInput.name || "",
               email: userInput.email || "",
               password: ""
            });
         }

         let user;
         try {
            user = await UserModel.create({ name, email, password });
            console.log(" User đã được tạo:", user);
         } catch (error) {
            console.error(" Lỗi khi tạo user:", error);
            return res.status(500).json({ error: "Lỗi khi tạo người dùng!" });
         }

         if (user) {
            req.flash("success", "Đăng ký thành công!");

            return res.redirect("/login");
         }

         return res.status(500).json({ error: "Không thể tạo tài khoản." });

      } catch (error) {
         console.error("Lỗi server:", error);
         return res.status(500).json({ error: error.message });
      }
   }

   static async getById(req, res) {
      try {
         const { id } = req.params;
         const user = await userModel.findByPk(id);

         if (!user) {
            return res.status(404).json({ message: "Id không tồn tại" });
         }
         res.status(200).json({
            "status": 200,
            "data": user
         });
      } catch (error) {
         res.status(500).json({ error: error.message });
      }
   }

   static async getLogin(req, res) {
      try {
         res.render("Client/Page/Auth/login", {
            layout: "Client/layout",
            title: "Đăng nhập",
            email: "",
            password: "",
            errors: {}
         });
      } catch (error) {
         console.error("Lỗi server:", error);
         res.status(500).json({ error: error.message });
      }
   }

   static async login(req, res) {
      try {
         const { email, password } = req.body;
         let errors = {};

         if (!email) {
            errors.email = "Vui lòng nhập email!";
         }
         if (!password) {
            errors.password = "Vui lòng nhập mật khẩu!";
         }
         if (Object.keys(errors).length > 0) {
            return res.render("Client/Page/Auth/login", {
               layout: "Client/layout",
               title: "Đăng nhập",
               errors,
               email
            });
         }

         const user = await UserModel.findOne({ where: { email } });

         if (!user) {
            req.flash("error", "Đăng nhập thất bại! Tài khoản không tồn tại.");
            return res.redirect("/login");
         }

         const isPasswordValid = await bcrypt.compare(password, user.password);
         if (!isPasswordValid) {
            errors.password = "Mật khẩu không đúng!";
            return res.render("Client/Page/Auth/login", {
               layout: "Client/layout",
               title: "Đăng nhập",
               errors,
               email
            });
         }
         if (user.status != 1) {
            req.flash("error", " Tài khoản của bạn đã bị khóa");
            return res.redirect("/login");
         }
         res.cookie("user", JSON.stringify({
            id: user.id,
            name: user.name
         }), {
            maxAge: 1000 * 60 * 60 * 24,
            httpOnly: true,
            secure: false
         });

         req.flash("success", "Đăng nhập thành công!");
         return res.redirect("/");
      } catch (error) {
         console.error("Lỗi server:", error);
         req.flash("error", "Lỗi server. Vui lòng thử lại sau!");
         return res.redirect("/login");
      }
   }


   //---------------------------- [ LOGOUT ]-----------------------------
   static async logout(req, res) {
      try {
         res.clearCookie("user");

         return res.redirect("/");
      } catch (error) {
         console.error("Lỗi server:", error);
         return res.status(500).json({ message: "Lỗi khi đăng xuất", error: error.message });
      }
   }

   //---------------------------- [ resetPassword ]-----------------------------

   static async getReset(req, res) {
      try {
         res.render("Client/Page/Auth/resetPassword", {
            layout: "Client/layout",
            title: "Lấy lại mật khẩu",
            email: "",
            errors: {}
         });

      } catch (error) {
         console.error("Lỗi server:", error);
         res.status(500).json({ error: error.message });
      }
   }

   static async resetPasswod(req, res) {
      const { email } = req.body;
      try {
         const user = await UserModel.findOne({
            where: { email }
         });
         if (!user) {
            req.flash("error", "Email không tồn tại");
            return;
         }

         const secret = process.env.SESSION_SECRET + user.password;
         const token = jwt.sign({ email: user.email, id: user.id }, secret, {
            expiresIn: "5m",
         });

         const link = `http://localhost:3030/resetPassword/${user.id}/${token}`;
         console.log(link);
         await sendResetPasswordEmail(email, link);
         // res.send("gui email");


      } catch (error) {
         console.error("Lỗi xảy ra khi reset password:", error);
         res.status(500).send("Đã xảy ra lỗi khi xử lý yêu cầu reset password.");
      }
   }
   static async getResetPassword(req, res) {
      const { id, token } = req.params;
      console.log("ID:", id);
      console.log("Token:", token);

      const user = await UserModel.findOne({
         where: { id },
      });
      if (!user) {
         req.flash("error", "Người dùng không tồn tại");
         return res.status(400).send("Người dùng không tồn tại");
      }

      const secret = process.env.SESSION_SECRET + user.password;
      try {
         const decoded = jwt.verify(token, secret);
         console.log("Decoded:", decoded);
         if (decoded.email !== user.email) {
            return res.status(400).send("Token không hợp lệ");
         }
         res.render("Client/Page/Auth/password", {
            layout: "Client/layout",
            title: "Cập nhật mật khẩu ",
            email: decoded.email,
            errors: {},
            id: user.id,
            token: token

         });
      } catch (error) {
         res.status(400).send("Token không hợp lệ hoặc đã hết hạn");
      }
   }


   static async updatePassword(req, res) {

      const { id, token } = req.params;
      // let userInput = sanitizeInput(req.body);
      const {
         password
      } = req.body;

      const user = await UserModel.findOne({ id: id });
      if (!user) {
         return res.status(404).json({ message: "Id không tồn tại" });
      }
      const secret = process.env.SESSION_SECRET + user.password;
      try {
         const verify = jwt.verify(token, secret);
         const encryptedPassword = await bcrypt.hash(password, 10);
      await user.update({
         password: encryptedPassword,
      });


         req.flash("success", "Mật khẩu dã được cập");
        return res.status(200).redirect("/login");
      } catch (error) {
         res.status(500).json({ error: error.message });
      }
   }


}

module.exports = AuthController;