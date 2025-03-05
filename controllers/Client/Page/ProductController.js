const ProductModel = require('../../../models/ProductModel');
const CategoryModel = require('../../../models/CategoryModel');
// const OrderModel = require('../../../models/OrderModel');
const CommentsModel = require('../../../models/CommentsModel');


const fs = require("fs");
const path = require("path");
const { Sequelize, Op } = require('sequelize');
const { OrderModel, DetailOrderModel, UserModel } = require('../../../models/Associations');

class ProductController {


   //-------------------------[ PRODUCT ]-------------------------

   static async get(req, res) {
      try {
         let page = parseInt(req.query.page) || 1;
         let limit = 15;
         let offset = (page - 1) * limit;

         const { count, rows: products } = await ProductModel.findAndCountAll({
            where: { status: 1, is_deleted:1 },
            include: [{
               model: CategoryModel,
               as: 'category',
               where: { status: 1 },
               attributes: ['id', 'name']
            }],
            limit: limit,
            offset: offset,
            order: [['id', 'DESC']]
         });

         const { count: countProducts } = await ProductModel.findAndCountAll({
            where: { status: 1 }
         });

         const { count: countCategories } = await CategoryModel.findAndCountAll({
            where: {
               status: 1
            }
         });
         const { count: countComment } = await CommentsModel.findAndCountAll({
            where: {
               status: 1
            }
         });

         const { count: countOrder } = await OrderModel.findAndCountAll();

         const categories = await CategoryModel.findAll({
            where: { status: 1, is_deleted: 1 },
            attributes: [
               'id',
               'name',
               [Sequelize.fn('COUNT', Sequelize.col('products.id')), 'productsCount']
            ],
            include: [{
               model: ProductModel,
               as: 'products',
               attributes: []
            }],
            group: ['Category.id'],
            raw: true
         });

         const productsWithImages = products.map(product => ({
            ...product.toJSON(),
            images: Array.isArray(product.images) ? product.images : []
         }));
         console.log(productsWithImages);

         let totalPages = Math.ceil(count / limit);

         return res.status(200).render("Client/Page/Product/product", {
            layout: "Client/layout",
            title: "Sản phẩm",
            products: productsWithImages,
            categories: categories,
            countProducts,
            countCategories,
            countComment,
            countOrder,
            currentPage: page,
            totalPages: totalPages
         });
      } catch (error) {
         console.error("Lỗi truy vấn sản phẩm:", error);
         res.status(500).json({ error: "Lỗi khi lấy danh sách sản phẩm!" });
      }
   }

   //---------------------[ DETAIL ]---------------------------

   static async getProductDetail(req, res) {
      const user = req.cookies.user ? JSON.parse(req.cookies.user) : null;
      const userId = user ? user.id : null;

      try {
         const { id } = req.params;
         const productDetail = await ProductModel.findByPk(id, {
            include: {
               model: CategoryModel,
               as: "category"
            }
         });

         if (!productDetail) {
            req.flash("error", "Sản phẩm không tồn tại!");
            return res.redirect("/product"); 
         }


         const comment = await CommentsModel.findAll({
            where: {
               productId: id,
               status: 1
            },
            include: [
               {
                  model: UserModel,
                  as: "user",
                  attributes: ["name", "image"]
               }
            ],
            order: [["id", "DESC"]]
         });

         const user = await UserModel.findOne({
            where: { id: userId }
         })

         productDetail.images = Array.isArray(productDetail.images) ? productDetail.images : [];

         return res.status(200).render("Client/Page/Product/productDetail", {
            layout: "Client/layout",
            title: "Chi tiết sản phẩm",
            productDetail,
            user,
            comment,
            categoryName: productDetail.category ? productDetail.category.name : "Không có danh mục",
         });
      } catch (error) {
         console.error("Lỗi khi lấy sản phẩm:", error);
         res.status(500).json({ error: error.message });
      }
   }

   //---------------[ SEARCH ]-----------------

   static async searchProductsByName(searchTerm) {
      try {
         const products = await ProductModel.findAll({
            where: {
               status: 1,
               is_deleted: 1,
               name: {
                  [Op.like]: `%${searchTerm}%`,
               },
            },
            order: [
               [Sequelize.literal('LENGTH(name)'), 'ASC'],
            ],
            limit: 5,
         });

         return products;
      } catch (error) {
         console.error('Lỗi khi tìm kiếm sản phẩm:', error);
         throw error;
      }
   }

   //-----------------[ COMMENTS ]----------------------
   // static async updateComment(req, res) {
   //    try {
   //       const user = req.cookies.user ? JSON.parse(req.cookies.user) : null;
   //       if (!user) return res.status(403).json({ success: false, message: "Bạn chưa đăng nhập!" });

   //       const hasPurchased = await OrderModel.findOne({
   //          include: {
   //             model: OrderDetailModel,
   //             where: { productId: req.body.productId },
   //          },
   //          where: { userId: user.id, status: "completed" },
   //       });

   //       if (!hasPurchased) {
   //          return res.status(403).json({ success: false, message: "Bạn cần mua hàng trước khi chỉnh sửa bình luận!" });
   //       }

   //       const { content } = req.body;
   //       const comment = await CommentsModel.findOne({ where: { id: req.params.id, userId: user.id } });

   //       if (!comment) return res.status(404).json({ success: false, message: "Không tìm thấy bình luận!" });

   //       comment.comment = content;
   //       await comment.save();

   //       return res.json({ success: true });
   //    } catch (error) {
   //       console.error("Lỗi khi sửa bình luận:", error);
   //       return res.status(500).json({ success: false, message: "Đã xảy ra lỗi!" });
   //    }
   // }


   // static async deleteComment(req, res) {
   //    try {
   //       const user = req.cookies.user ? JSON.parse(req.cookies.user) : null;
   //       if (!user) return res.status(403).json({ success: false, message: "Bạn chưa đăng nhập!" });


   //       const commentOrder = await OrderModel.findOne({
   //          include: {
   //             model: OrderDetailModel,
   //             where: { productId: req.body.productId },
   //          },
   //          where: { userId: user.id, status: "completed" },
   //       });

   //       if (!commentOrder) {
   //          return res.status(403).json({ success: false, message: "Bạn cần mua hàng trước khi xóa bình luận!" });
   //       }

   //       const comment = await CommentsModel.findOne({ where: { id: req.params.id, userId: user.id } });

   //       if (!comment) return res.status(404).json({ success: false, message: "Không tìm thấy bình luận!" });

   //       await comment.destroy();
   //       return res.json({ success: true });
   //    } catch (error) {
   //       console.error("Lỗi khi xóa bình luận:", error);
   //       return res.status(500).json({ success: false, message: "Đã xảy ra lỗi!" });
   //    }
   // }


   static async comments(req, res) {
      try {
         const user = req.cookies.user ? JSON.parse(req.cookies.user) : null;
         const userId = user ? user.id : null;
         const { productId, content } = req.body;

         if (!userId) {
            req.flash("error", "Vui lòng đăng nhập");
            return res.redirect(`/productDetail/${productId}`);
         }

         const usersProduct = await OrderModel.findOne({
            where: { user_id: userId, status: 3 },
            include: [{
               model: DetailOrderModel,
               as: "details",
               where: { productId }
            }]
         });

         if (!usersProduct) {
            req.flash("error", "Bạn cần mua hàng rồi mới được đánh giá");
            return res.redirect(`/productDetail/${productId}`);
         }

         console.log("User đã mua hàng, tiến hành thêm bình luận...");

         await CommentsModel.create({
            userId,
            productId,
            comment: content,
         });

         console.log("Bình luận đã được thêm thành công!");
         req.flash("success", "Bình luận thành công!");
         return res.redirect(`/productDetail/${productId}`);

      } catch (error) {
         console.error("Lỗi khi xử lý bình luận:", error);
         req.flash("error", "Đã xảy ra lỗi, vui lòng thử lại!");
         return res.redirect(`/productDetail/${productId}`);
      }
   }

}
module.exports = ProductController;