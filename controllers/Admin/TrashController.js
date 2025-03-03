const CategoryModel = require("../../models/CategoryModel");
const ProductModel = require("../../models/ProductModel");
const fs = require("fs");
const path = require("path");

class TrashController {
   static async getTrash(req, res) {
      try {
         let page = parseInt(req.query.page) || 1;
         let limit = 10;
         let offset = (page - 1) * limit;

         let activeTab = req.query.tab || 'products'; // Mặc định là sản phẩm

         let data = [];
         let totalCount = 0;

         if (activeTab === 'products') {
            const { count, rows } = await ProductModel.findAndCountAll({
               where: { is_deleted: 1 },
               limit: limit,
               offset: offset,
               order: [['id', 'DESC']],
               include: [{
                  model: CategoryModel,
                  as: 'category',
                  attributes: ['id', 'name']
               }],
            });
            data = rows;
            totalCount = count;
         } else if (activeTab === 'categories') {
            const { count, rows } = await CategoryModel.findAndCountAll({
               where: { is_deleted: 1 },
               limit: limit,
               offset: offset,
               order: [['id', 'DESC']]
            });
            data = rows;
            totalCount = count;
         }

         const productsWithImages = data.map(product => ({
            ...product.toJSON(), // Chuyển đổi Sequelize  thành  object
            images: Array.isArray(product.images) ? product.images : []
         }));

         let totalPages = Math.ceil(totalCount / limit);

         res.status(200).render("Admin/page/trash", {
            layout: "Admin/layout",
            title: "Thùng rác",
            currentPage: page,
            totalPages: totalPages,
            activeTab: activeTab,
            productsWithImages,
            products: activeTab === 'products' ? data : [],
            categories: activeTab === 'categories' ? data : []
         });

      } catch (error) {
         console.error("Lỗi truy vấn dữ liệu:", error);
         res.status(500).json({ error: "Lỗi khi lấy danh sách dữ liệu!" });
      }
   }


}

module.exports = TrashController;


module.exports = TrashController;
