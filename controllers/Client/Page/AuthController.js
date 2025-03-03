const ProductModel = require('../../../models/ProductModel');
const UserModel = require('../../../models/UserModel');
const validatorUser = require("../../../validator/validatorUser");
const sanitizeInput = require("../../../validator/sanitize");
const bcrypt = require('bcrypt');
const express = require("express");
const { body, validationResult } = require("express-validator");
const fs = require("fs");
const path = require("path");
const { Sequelize } = require('sequelize');

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
         return res.redirect("/reset-password-form"); // Trả về một redirect hoặc trả về lỗi nếu không tìm thấy user
      }

      const secret = JWT_SECRET + user.password;
      const token = jwt.sign({ email: user.email, id: user.id }, secret, {
         expiresIn: "5m",
      });

      const link = `http://localhost:3030/resetPassword/${user.id}/${token}`;
      console.log(link);  // Kiểm tra xem link có in ra không
      
      // Gửi mail cho người dùng hoặc các bước tiếp theo
      // return res.send({ message: "Email sent" }); // Ví dụ trả lời thành công

   } catch (error) {
      console.error("Lỗi xảy ra khi reset password:", error);
      res.status(500).send("Đã xảy ra lỗi khi xử lý yêu cầu reset password.");
   }
}


   static async update(req, res) {
      try {
         const { id } = req.params;
         let userInput = sanitizeInput(req.body);
         const {
            name,
            email,
            password
         } = req.body;
         let { errors, isValid } = validatorUser(userInput);

         if (!isValid) {
            return res.status(400).json({ message: " Du lieu khong hop le!", errors });
         }
         const user = await userModel.findByPk(id);
         if (!user) {
            return res.status(404).json({ message: "Id không tồn tại" });
         }

         user.name = name;
         user.email = email;
         user.password = password;
         await user.save();

         res.status(200).json({
            message: "Cập nhật thành công",
            user
         });
      } catch (error) {
         res.status(500).json({ error: error.message });
      }
   }

}

module.exports = AuthController;