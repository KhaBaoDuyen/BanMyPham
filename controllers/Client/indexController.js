const ProductModel = require('../../models/ProductModel');
const CategoryModel = require('../../models/CategoryModel');
const UserModel = require('../../models/UserModel');
const OrderModel = require('../../models/OrderModel');
const DetailOrderModel = require('../../models/DetailOrderModel');

const fs = require("fs");
const path = require("path");
const { Sequelize } = require('sequelize');

class indexController {

   static async getClient(req, res) {
      try {
         const products = await ProductModel.findAll({
            include: [{
               model: CategoryModel,
               as: 'category',
               attributes: ['id', 'name']
            }],
            where: {
               status: 1,
               is_deleted: 0
            },
            order: [['id', 'DESC']]
         });
         const categories = await CategoryModel.findAll({
            where: { status: 1 }
         });

         if (!Array.isArray(products)) {
            console.error("Lỗi: products không phải là mảng!", products);
            return res.status(500).json({ error: "Lỗi khi lấy danh sách sản phẩm!" });
         }

         const productsWithImages = products.map(product => ({
            ...product.toJSON(),
            images: Array.isArray(product.images) ? product.images : []
         }));


         res.status(200).render("Client/page/index", {
            layout: "Client/layout",
            title: "Trang chủ",
            products: productsWithImages,
            categories: categories,
         });
      } catch (error) {
         console.error("Lỗi truy vấn sản phẩm:", error);
         res.status(500).json({ error: error.message });
      }

   }

   static async getAbout(req, res) {
      res.status(200).render("Client/Page/about", {
         layout: "Client/layout",
         title: "Giới thiệu",
      });
   }

   static async getContact(req, res) {
      res.status(200).render("Client/Page/contact", {
         layout: "Client/layout",
         title: "Liên hệ"
      });
   }

   //--------------------[ HISTORY ]-------------------------
   static async history(req, res) {
      try {
         const user = req.cookies.user ? JSON.parse(req.cookies.user) : null;
         if (!user || !user.id) {
            return res.status(401).json({ error: "Người dùng chưa đăng nhập!" });
         }
         const userId = user ? user.id : null;

         if (!userId) {
            return res.status(401).json({ error: "Người dùng chưa đăng nhập!" });
         }

         const history = await OrderModel.findAll({
            where: { user_id: userId },
            attributes: ['id', 'status', 'total', 'createdAt', 'address', 'pay', 'payment_status'],
            include: [
               {
                  model: DetailOrderModel,
                  as: 'details',
                  include: [
                     {
                        model: ProductModel,
                        as: 'product',
                        attributes: ['id', 'name', 'price', 'images', 'discount_price'],
                     }
                  ],
                 
               }
            ] ,order: [['id', 'DESC']]
         });

         history.forEach(order => {
            order.details.forEach(detail => {
               if (detail.product && detail.product.images) {
                  try {
                     if (typeof detail.product.images === "string") {
                        detail.product.images = JSON.parse(detail.product.images);
                     }
                  } catch (error) {
                     console.error("Lỗi JSON:", error);
                     detail.product.images = [];
                  }
               } else {
                  detail.product.images = [];
               }
            });
         });

         res.render("Client/Page/Cart/history", {
            layout: "Client/layout",
            title: "Lịch sử đơn hàng",
            history: history,
         });

      } catch (error) {
         console.error("Lỗi truy vấn đơn hàng:", error);
         res.status(500).json({ error: "Lỗi khi lấy danh sách đơn hàng!" });
      }
   }

  //----------------
}
module.exports = indexController;