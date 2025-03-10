const CategoryModel = require("../../models/CategoryModel");
const ProductModel = require("../../models/ProductModel");
const validatorCategory = require("../../validator/validateCategory");
class CategoryController {


   static async get(req, res) {
      try {
         const categories = await CategoryModel.findAll({
            where: { is_deleted: 0 },
            order: [['id', 'DESC']]
         });
         res.status(200).render("Admin/page/Categories/category", {
            // status: 200,
            // message: "Thành công",
            // data: categories
            layout: "Admin/layout",
            title: "Quản lý danh mục",
            category: categories,
         });
      } catch (error) {
         res.status(500).json({ error: error.message });
      }
   }


   // ------------------------[ CREATE ]---------------------------
   static async createFrom(req, res) {
      res.render("Admin/page/Categories/Create", {
         layout: "Admin/layout",
         title: "Thêm mới danh mục",
         errors: {},
         category: { name: "", status: "", image: "" }
      });
   }

   static async create(req, res) {
      try {
         const { name, status } = req.body;
         const image = req.file ? req.file.filename : null;
         const { errors, isValid } = validatorCategory({ name, image });

         if (!isValid) {
            return res.render("Admin/page/Categories/Create", {
               layout: "Admin/layout",
               title: "Thêm mới danh mục",
               errors,
               category: { name, status, image }
            });
         }

         const category = await CategoryModel.create({
            name,
            image,
            status
         });

         req.flash("success", "Danh mục thêm thành công!");
         return res.redirect("/admin/category/list");

      } catch (error) {
         console.error("Lỗi:", error.message);
         req.flash("error", "Lỗi server. Vui lòng thử lại sau!");
         return res.render("Admin/page/Categories/Create", {
            layout: "Admin/layout",
            title: "Thêm mới danh mục",
            errors: { server: "Lỗi server. Vui lòng thử lại sau!" },
            category: { name: req.body.name, status: req.body.status, image: req.file ? req.file.filename : null }
         });
      }
   }

   // ------------------------[ UPDATE ]---------------------------
   static async updateFrom(req, res) {
      try {
         const categoryId = req.params.id;
         const category = await CategoryModel.findByPk(categoryId);

         if (!category) {
            return res.status(404).json({ error: "Danh mục không tồn tại" });
         }

         res.render("Admin/page/Categories/Edit", {
            layout: "Admin/layout",
            title: "Cập nhật danh mục",
            calog: category,
            errors: {}
         });
      } catch (error) {
         console.error("Lỗi:", error.message);
         res.status(500).json({ error: error.message });
      }
   }

   static async update(req, res) {
      try {
         const categoryId = req.params.id;
         const { name, status, image_old } = req.body;

         const category = await CategoryModel.findByPk(categoryId);

         if (!category) {
            return res.status(404).json({ error: "Danh mục không tồn tại" });
         }

         const image = req.file ? req.file.filename : image_old;

         const { errors, isValid } = validatorCategory({ name, image });

         if (!isValid) {
            return res.render("Admin/page/Categories/Edit", {
               layout: "Admin/layout",
               title: "Cập nhật danh mục",
               calog: { ...category.toJSON(), name, status, image },
               errors
            });
         }

         await category.update({
            name,
            image,
            status
         });

         req.flash("success", "Cập nhật danh mục thành công!");
         return res.redirect("/admin/category/list");

      } catch (error) {
         console.error("Lỗi:", error.message);
         req.flash("error", "Lỗi server. Vui lòng thử lại sau!");
         return res.render("Admin/page/Categories/Edit", {
            layout: "Admin/layout",
            title: "Cập nhật danh mục",
            calog: { ...req.body, id: req.params.id, image: req.file ? req.file.filename : req.body.image_old },
            errors: { server: "Lỗi server. Vui lòng thử lại sau!" }
         });
      }
   }

   // ------------------------[ DELETE ]---------------------------

   static async isDelete(req, res) {
      try {
         const { id } = req.params;
         const category = await CategoryModel.findByPk(id);

         if (!category) {
            return res.status(404).json({
               message: "Không tìm danh mục"
            });
         }
         await category.update({ is_deleted: 1 }); //1: an , 0 hien thi

         req.flash("success", "Danh mục xóa thành công!");
         return res.redirect("/admin/category/list");

      } catch (error) {
         console.error("Lỗi khi cập nhật trạng thái danh mục:", error);
         req.flash("error", "Danh mục xóa thất bại!");
         return res.status(500).redirect("/admin/category/list")
      }
   }


   static async delete(req, res) {
      try {
         const {
            id
         } = req.params
         const category = await CategoryModel.findByPk(id);

         if (!category) {
            return res.status(404).json({ error: "Danh mục không tồn tại" });
         }
         if (id == 19) {
            req.flash("error", "Không thể xóa danh mục mặc định!");
            return res.status(400).redirect("/admin/category/list");
         }

         if (!category) {
            return res.status(404).json({ error: "Danh mục không tồn tại" });
         }

         await ProductModel.update({ category_id: 19 }, { where: { category_id: id } });

         await category.destroy();

         req.flash("success", "Xóa danh mục thành công!");
         return res.status(200).redirect("/admin/category/list");
      } catch (error) {
         req.flash("error", "Xóa danh mục thất bại!");
         return res.status(500).redirect("/admin/category/list");
      }
   }

   // ---------------------[ RESTORE ]---------------------------
   static async restore(req, res) {
      try {
         const categoryId = req.params.id;
         const category = await CategoryModel.findByPk(categoryId);


         await category.update({
            is_deleted: 0
         });

         req.flash("success", "Khôi phục danh mục thành công!");
         return res.redirect("/admin/trash?tab=categories;");

      } catch (error) {
         console.error("Lỗi:", error.message);
         req.flash("error", "Lỗi server. Vui lòng thử lại sau!");
         return res.redirect("/admin/trash?tab=categories;");

      }
   }
}
module.exports = CategoryController;
