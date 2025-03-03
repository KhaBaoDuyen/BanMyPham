const UserModel = require('../../models/UserModel');

const checkRole = (role) => {
  return async (req, res, next) => {
    console.log("Cookies:", req.cookies);


    if (!req.cookies.user) {
      req.flash("error", "Bạn cần đăng nhập!");
      return res.status(403).redirect('/');
    }

    let userCookie;
    try {
      userCookie = JSON.parse(req.cookies.user);
    } catch (error) {
      req.flash("error", "Lỗi xác thực!");
      return res.status(403).redirect('/');
    }

    console.log("User từ cookie (sau khi parse):", userCookie);

    if (!userCookie.id) {
      console.log("Không tìm thấy ID trong cookie!");
      req.flash("error", "Bạn cần đăng nhập!");
      return res.status(403).redirect('/');
    }

    try {
      const userId = userCookie.id;
      console.log("User Cookie:", userId);

      const user = await UserModel.findByPk(userId);
      if (!user) {
        req.flash("error", "Tài khoản không được phép truy cập!");
        return res.status(403).redirect('/');
      }

      console.log("Role từ database:", user.role, " | Role cần kiểm tra:", role);
      
      if (user.status === 0 ) {
        res.clearCookie("user"); // Xóa cookie trước khi đăng xuất
        req.flash("error", "Tài khoản bị khóa! Vui lòng liên hệ admin.");
        return res.redirect('/');
      }

      if (user.role !== 1) {
        req.flash("error", "Bạn không có quyền truy cập!");
        return res.status(403).redirect('/');
      }

      req.user = user;
      next();
    } catch (error) {
      console.error("Lỗi:", error);
      res.status(500).json({ error: "Lỗi server!" });
    }
  };
};


module.exports = checkRole;
