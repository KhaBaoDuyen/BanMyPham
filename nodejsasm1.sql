-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Mar 05, 2025 at 01:01 PM
-- Server version: 8.0.39
-- PHP Version: 8.2.18

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `nodejsasm1`
--

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `product_id` int NOT NULL,
  `quantity` int NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `image` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `createdAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_deleted` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `image`, `status`, `createdAt`, `updatedAt`, `is_deleted`) VALUES
(19, 'Mỹ phẩm', '1741014603342-885c15cf33b39ec5a4fe4a3063ff6ce5.jpg', 1, '2025-03-03 15:10:03', '2025-03-05 06:11:26', 0),
(20, 'Tẩy trang', '1741016823843-9f6e1b57c2e49c534ce35c53d8cae2bb.jpg', 1, '2025-03-03 15:47:03', '2025-03-03 15:49:33', 0),
(21, 'Rửa mặt', '1741017019649-0c1872599f86d0608be91737b08222b7.jpg', 1, '2025-03-03 15:50:19', '2025-03-03 15:50:19', 0),
(22, 'Son môi', '1741017032470-b19e5d710741f1b209957646b5b18394.jpg', 1, '2025-03-03 15:50:32', '2025-03-03 15:50:32', 0),
(23, 'Chống nắng', '1741017056193-f8b5a2a03810fe6ab3f49a8a5758fd76.jpg', 1, '2025-03-03 15:50:56', '2025-03-03 15:50:56', 0),
(24, 'Dưỡng thể', '1741017528568-c1897-duong-the_img_120x120_17b03c_fit_center.jpg', 1, '2025-03-03 15:58:48', '2025-03-03 15:58:48', 0),
(25, 'Mặt nạ', '1741017643673-a7f1106c1ec22dbdfd5683f064d3371a.jpg', 1, '2025-03-03 16:00:43', '2025-03-03 16:00:43', 0),
(26, 'Dưỡng tóc', '1741017891610-f6b0857f96c178af2c6865f4e5476df5.jpg', 1, '2025-03-03 16:04:51', '2025-03-03 22:56:33', 0);

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `id` int NOT NULL,
  `userId` int NOT NULL,
  `productId` int NOT NULL,
  `comment` text COLLATE utf8mb4_general_ci NOT NULL,
  `status` tinyint NOT NULL DEFAULT '1',
  `createAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `comments`
--

INSERT INTO `comments` (`id`, `userId`, `productId`, `comment`, `status`, `createAt`) VALUES
(4, 16, 31, 'Kem chống nắng giá rẻ mà xài thấy Ok ghê luôn ak . Nâng tông trắng da mà ko lo bị mọc mụn nữa , Xài lên da mặt đẹp mịn luôn . Trước mình có xài cell fushion hồng cũng đẹp da mà giá hơi mắc, nên xài qua em này thì ngon bổ rẻ !!! Hiii', 1, '2025-03-05 07:20:21');

-- --------------------------------------------------------

--
-- Table structure for table `detailorder`
--

CREATE TABLE `detailorder` (
  `id` int NOT NULL,
  `orderId` int NOT NULL,
  `productId` int NOT NULL,
  `quantity` int NOT NULL,
  `price` decimal(10,0) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `detailorder`
--

INSERT INTO `detailorder` (`id`, `orderId`, `productId`, `quantity`, `price`) VALUES
(168, 152, 31, 1, 476000),
(169, 153, 31, 1, 476000),
(170, 154, 35, 1, 250000),
(171, 155, 39, 2, 66000);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int NOT NULL,
  `user_id` int DEFAULT NULL,
  `name` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `phone` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  `status` tinyint(1) DEFAULT '1',
  `total` decimal(10,0) DEFAULT NULL,
  `address` text COLLATE utf8mb4_general_ci,
  `pay` tinyint(1) DEFAULT '1',
  `note` text COLLATE utf8mb4_general_ci,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `txnRef` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT '0',
  `payment_status` tinyint DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `user_id`, `name`, `phone`, `status`, `total`, `address`, `pay`, `note`, `createdAt`, `updatedAt`, `txnRef`, `is_deleted`, `payment_status`) VALUES
(152, 16, 'Baoduyen', '0337019197', 3, 505001, 'nhà số 8 hẻm 7, Phường 12, Quận 5, Hồ Chí Minh', 2, '', '2025-03-04 11:34:37', '2025-03-04 18:03:14', '70a50e7a09', 0, 1),
(153, 16, 'Baoduyen', '0337019197', 0, 505001, 'nhà số 8 hẻm 7, Phường Thảo Điền, Quận 2, Hồ Chí Minh', 1, 'Tìm thấy giá tốt hơn', '2025-03-04 12:02:19', '2025-03-04 12:09:38', '7434a26a97', 0, 0),
(154, 17, 'Baoduyen', '0337019197', 1, 279001, 'nhà số 8 hẻm 7, Phường 10, Quận 3, Hồ Chí Minh', 2, '', '2025-03-05 08:44:29', '2025-03-05 08:45:28', '8b8384a467', 0, 1),
(155, 16, 'Baoduyen', '0337019197', 1, 161001, 'nhà số 8 hẻm 7, Phường 5, Quận 4, Hồ Chí Minh', 2, '', '2025-03-05 11:03:04', '2025-03-05 11:03:34', 'b709ed9897', 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `images` json NOT NULL,
  `price` decimal(10,0) NOT NULL,
  `category_id` int DEFAULT NULL,
  `discount_price` decimal(10,0) DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `short_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `status` tinyint NOT NULL DEFAULT '1',
  `weight` float DEFAULT NULL,
  `stock` int DEFAULT NULL,
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `is_deleted` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `images`, `price`, `category_id`, `discount_price`, `description`, `short_description`, `status`, `weight`, `stock`, `updatedAt`, `createdAt`, `is_deleted`) VALUES
(31, 'Sữa Chống Nắng Anessa Dưỡng Da Kiềm Dầu 60ml (Bản Mới) Perfect UV Sunscreen Skincare Milk N SPF50+ PA++++', '[\"1741021057958-d9d327521cef758d3d276a235bd1a196.jpg\", \"1741158292950-Screenshot 2025-03-05 at 14-04-18 Sá»¯a Chá»ng Náº¯ng Anessa DÆ°á»¡ng Da Kiá»m Dáº§u 60ml (Báº£n Má»i) Hasaki.vn.png\", \"1741158292953-Screenshot 2025-03-05 at 14-04-23 Sá»¯a Chá»ng Náº¯ng Anessa DÆ°á»¡ng Da Kiá»m Dáº§u 60ml (Báº£n Má»i) Hasaki.vn.png\", \"1741158292958-Screenshot 2025-03-05 at 14-04-26 Sá»¯a Chá»ng Náº¯ng Anessa DÆ°á»¡ng Da Kiá»m Dáº§u 60ml (Báº£n Má»i) Hasaki.vn.png\", \"1741158292961-Screenshot 2025-03-05 at 14-04-30 Sá»¯a Chá»ng Náº¯ng Anessa DÆ°á»¡ng Da Kiá»m Dáº§u 60ml (Báº£n Má»i) Hasaki.vn.png\"]', 715000, 23, 476000, '<p><strong>Sữa Chống Nắng Anessa Perfect UV Sunscreen Skincare Milk N SPF50+ PA++++ Dưỡng Da Kiềm Dầu (Mới)</strong> là dòng sản phẩm <a href=\"https://hasaki.vn/danh-muc/chong-nang-da-mat-c11.html\">chống nắng da mặt</a> đến từ thương hiệu <a href=\"https://hasaki.vn/thuong-hieu/anessa.html\">Anessa</a> - Nhật Bản. Sản phẩm với công nghệ Auto Veil mới giúp cho lớp màng chống UV trở nên bền vững hơn khi gặp nhiệt độ cao, nước và ma sát.</p><figure class=\"table\"><table><tbody><tr><td><strong>Barcode &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;</strong></td><td>4909978147105</td></tr><tr><td><strong>Thương Hiệu</strong></td><td>Anessa</td></tr><tr><td><strong>Xuất xứ thương hiệu</strong></td><td>Nhật bản</td></tr><tr><td><strong>Nơi sản xuất</strong></td><td>Japan</td></tr><tr><td><strong>Loại da</strong></td><td>Da dầu/Hỗn hợp dầu</td></tr><tr><td><strong>Đặc tính</strong></td><td>Chống nắng phổ rộng</td></tr></tbody></table></figure><figure class=\"table\"><table><tbody><tr><td>&nbsp;</td></tr></tbody></table></figure><p><strong>Thành phần chi tiết:</strong></p><p>Dimethicone,Water (Aqua),Zinc Oxide,Alcohol,Diisopropyl Sebacate,Isododecane,Octocrylene,Ethylhexyl Salicylate,C12-15 Alkyl Benzoate,Peg/Ppg-9/2 Dimethyl Ether,Zea Mays (Corn) Starch,Talc,Silica,Isopropyl Myristate,Diethylamino Hydroxybenzoyl Hexyl Benzoate,Titanium Dioxide,Peg-9 Polydimethylsiloxyethyl Dimethicone,Dextrin Palmitate,Glycerin,Homosalate,Bis-Ethylhexyloxyphenol Methoxyphenyl Triazine,Sodium Chloride,Peg/Ppg-14/7 Dimethyl Ether,Trimethylsiloxysilicate,Dipotassium Glycyrrhizate,Camellia Sinensis Leaf Extract,Potentilla Erecta Root Extract,Citrus Unshiu Peel Extract,Sodium Acetylated Hyaluronate,Lauryl Betaine,Soluble Collagen,Ethylhexyl Triazone,Disteardimonium Hectorite,Peg-10 Dimethicone,Isostearic Acid,Triethoxycaprylylsilane,Polyglyceryl-6 Polyricinoleate,Aluminum Hydroxide,Stearic Acid,Trisodium Edta,Peg-6,Tocopherol,Bht,Butylene Glycol,Bis-Butyldimethicone Polyglyceryl-3,Sodium Metabisulfite,Synthetic Fluorphlogopite,Phenoxyethanol,Sodium Benzoate,Fragrance (Parfum),</p><h4><strong>Hướng dẫn sử dụng</strong></h4><ul><li>Lắc thật kỹ trước khi sử dụng.</li><li>Dùng sau bước dưỡng da buổi sáng, xịt đều lên vùng da cần được bảo vệ. Để đạt hiệu quả cao nhất, nên xịt lại sau khi tiếp xúc nhiều với nước hoặc lau bằng khăn.Thích hợp sử dụng cho mặt, cơ thể &amp; tóc.</li><li>Dùng cho cơ thể và tóc: giữ sản phẩm cách 10-15 cm và xịt đều các vùng da, tóc.</li><li>Dùng cho mặt: xịt sản phẩm lên lòng bàn tay và thoa nhẹ nhàng lên mặt, không xịt trực tiếp lên da mặt.</li><li>Lượng sử dụng: 2mg/1cm2 da.</li><li>Thích hợp sử dụng hàng ngày và trong các hoạt động ngoài trời.</li><li>Dễ dàng làm sạch với sữa rửa mặt.</li></ul><h4><strong>Lưu ý:</strong></h4><ul><li>Tránh tiếp xúc với mắt. Nếu có, rửa ngay bằng nước lạnh hoặc nước ấm.</li><li>Không sử dụng cho vùng da bị tổn thương như trầy xước, sưng tấy và chàm.</li><li>Ngưng sử dụng khi có biểu hiện kích ứng và tham khảo ý kiến bác sĩ da liễu.</li></ul>', 'Kem Chống Nắng Skin1004 Cho Da Nhạy Cảm là sản phẩm kem chống nắng da mặt đến từ thương hiệu mỹ phẩm Skin1004 của Hàn Quốc, là kem chống nắng vật lý với chiết xuất rau má và chất kem mỏng nhẹ có màu giúp che phủ nhẹ khuyết điểm cho da. Công thức đa năng vừa chống nắng vừa đều màu da lại dưỡng ẩm chính là sản phẩm mà những cô nàng da mụn hay da dầu nhạy cảm cần vì không cần sử dụng', 1, 500, 8, '2025-03-05 07:18:44', '2025-03-03 16:23:31', 0),
(33, 'Sữa Rửa Mặt CeraVe Sạch Sâu Cho Da Thường Đến Da Dầu 473ml', '[\"1741155841805-sua-rua-mat-cerave-cho-da-thuong-den-kho-1 - Copy.jpg\", \"1741155841807-sua-rua-mat-cerave-cho-da-thuong-den-kho-2 - Copy.jpg\", \"1741155841810-sua-rua-mat-cerave-sach-sau-1.jpg\", \"1741155841813-sua-rua-mat-cerave-sach-sau-cho-da-thuong-den-da-dau.jpg\", \"1741155841815-sua-rua-mat-cerave-tao-bot-cho-da-thuong-den-da-dau-1 - Copy.jpg\"]', 345000, 21, NULL, '<figure class=\"table\"><table><tbody><tr><td>Barcode</td><td>&nbsp;</td><td>3337875597357</td></tr><tr><td>Thương Hiệu</td><td>&nbsp;</td><td>CeraCeraVe</td></tr><tr><td>Xuất xứ thương hiệu</td><td>&nbsp;</td><td>Mỹ</td></tr><tr><td>Loại da</td><td>&nbsp;</td><td>Da dầu/Hỗn hợp dầu</td></tr></tbody></table></figure><h2>hành phần sản phẩm</h2><p>&nbsp;</p><h3><strong>1. Sữa Rửa Mặt Cerave Sạch Sâu Cho Da Thường Đến Da Dầu</strong></h3><p><strong>Thành phần chính:&nbsp;</strong></p><p><strong>3 loại Ceramides (1, 3, 6-II):</strong>&nbsp;thiết yếu giúp khôi phục hàng rào độ ẩm da.&nbsp;</p><p><strong>Hyaluronic Acid:</strong>&nbsp;giúp duy trì độ ẩm tự nhiên của da.</p><p><strong>Niacinamide:</strong>&nbsp;giúp làm dịu, nuôi dưỡng, củng cố hàng rào da.</p><p><strong>Thành phần đầy đủ:&nbsp;</strong></p><p>Purified Water (Aqua), Cocamidopropyl Hydroxysultaine, Glycerin, Sodium Lauroyl Sarcosinate, Peg-150 Pentaerythrityl Tetrastearate (And) Peg-6 Caprylic/Capric Glycerides, Niacinamide, Propylene Glycol, Sodium Methyl Cocoyl Taurate, Ceramide 3, Ceramide 6-Ii, Ceramide 1, Hyaluronic Acid, Cholesterol, Sodium Chloride, Phytosphingosine, Citric Acid, Edetate Disodium Dihydrate, Sodium Lauroyl Lactylate, Methylparaben, Propylparaben, Carbomer, Xanthan Gum.&nbsp;</p><h3>2.&nbsp;Sữa Rửa Mặt Cerave Cho Da Thường Đến Khô</h3><p><strong>Thành phần chính:&nbsp;</strong></p><p><strong>3 loại Ceramides (1, 3, 6-II):</strong>&nbsp;thiết yếu giúp khôi phục hàng rào độ ẩm da.&nbsp;</p><p><strong>Công nghệ MVE độc quyền:</strong>&nbsp;khoá ẩm cho da suốt 24 giờ.&nbsp;</p><p><strong>Hyaluronic Acid:</strong>&nbsp;giúp duy trì độ ẩm tự nhiên của da.</p><p><strong>Thành phần đầy đủ:&nbsp;</strong></p><p>Purified Water, Glycerin, Behentrimonium Methosulfate, Cetearyl Alcohol, Ceramide 3, Ceramide 6-Ii, Ceramide 1, Hyaluronic Acid, Cholesterol, Polyoxyl 40 Stearate, Glyceryl Monostearate, Stearyl Alcohol, Polysorbate 20, Potassium Phosphate, Dipotassium Phosphate, Sodium Lauroyl Lactylate, Cetyl Alcohol, Disodium Edta, Phytosphingosine, Methylparaben, Propylparaben, Carbomer, Xanthan Gum.&nbsp;</p><h2>Hướng dẫn sử dụng</h2><ol><li>Làm ướt da.</li><li>Mát xa sữa rửa mặt theo chuyển động tròn.</li><li>Nhẹ nhàng rửa sạch lại với nước.</li></ol>', 'Sữa Rửa Mặt Cerave&nbsp;Foaming Cleanser&nbsp;kết cấu dạng gel tạo bọt rất lý tưởng để loại bỏ dầu thừa, bụi bẩn và lớp trang điểm với công thức nhẹ nhàng, không phá vỡ hàng rào bảo vệ tự nhiên của da và chứa các thành phần giúp duy trì độ ẩm cân bằng da. Cerave Foaming Cleanser chứa Ceramides, Axit Hyaluronic và Niacinamide  giúp duy trì hàng rào bảo vệ da, khóa ẩm và làm dịu làn da của bạn. ', 1, 700, 10, '2025-03-05 06:43:47', '2025-03-05 06:24:01', 0),
(34, 'Mặt Nạ Caryophy Làm Giảm Mụn, Thâm & Dưỡng Ẩm Da 22g Portulaca Mask Sheet 3in1', '[\"1741156087175-mat-na-caryophy-lam-giam-mun-tham-duong-am-da-2.jpg\", \"1741156327363-mat-na-caryophy-lam-giam-mun-tham-duong-am-da-1.jpg\"]', 25000, 19, 0, '<figure class=\"table\"><table><tbody><tr><td>Barcode</td><td>&nbsp;</td><td>8809501251087</td></tr><tr><td>Thương Hiệu</td><td>&nbsp;</td><td>Caryophy</td></tr><tr><td>Xuất xứ thương hiệu</td><td>&nbsp;</td><td>Hàn Quốc</td></tr><tr><td>Loại da</td><td>&nbsp;</td><td>Da thường/Mọi loại da</td></tr></tbody></table></figure><h2>Thành phần sản phẩm</h2><ol><li>Dipropylene Glycol: Tăng cường hấp thu dưỡng chất qua da và tăng hiệu quả khi sử dụng sản phẩm, giúp mặt nạ không nhờn rít, tạo sự mềm mịn và dễ chịu.</li><li>Glycerin: Là một bậc thầy trong việc cấp nước, dưỡng da và phục hồi da.</li><li>Centella Asiatica Extract (rau má): Tăng sự liên kết giữa các mô tế bào, giúp nhanh chóng làm lành vết thương và làm giảm mụn hiệu quả. Giúp da được thải độc, làm mờ vết thâm, nám. Có khả năng làm ức chế sự tăng trưởng của các loại vi khuẩn, giúp da sạch hơn, ngăn ngừa viêm nhiễm ở các vùng da đang bị mụn nhờ đó làm giảm khả năng hình thành sẹo. Cải thiện bề mặt da, tăng độ đàn hồi giúp da thêm phần căng mịn và tươi trẻ.</li><li>Portulaca Oleracea Extract (rau sam): Chứa nhiều chất chống oxy hoá, các chất này tăng cường tác dụng bảo vệ các axit béo Omega 3 ở tế bào bằng cách tách các gốc tự do, ngăn ngừa lão hóa.</li><li>Beta-Glucan: Củng cố hệ miễn dịch, có khả năng cấp ẩm cao. Đồng thời giúp bảo vệ da khỏi tia UV, giảm ửng đỏ, tạo hàng rào tự nhiên bảo vệ làn da nhạy cảm khỏi các tác động của môi trường, giúp da trở nên căng mọng hơn.</li><li>Betaine Salicylate: giảm mụn, mờ thâm, giúp da trở nên mịn màng và tránh hình thành sẹo sau mụn.</li><li>Butylene Glycol: Giúp cho các dưỡng chất thấm sâu vào da nhanh hơn, tốt hơn.</li><li>Caprylic/Capric triglyceride: Là một dạng este đặc biệt của dầu dừa, có tác dụng làm ẩm và giúp tái tạo da, chống viêm và làm giảm nguy cơ nổi mụn.</li><li>Adenosine: Đào thải các tế bào có chứa melanin, giúp làn da sáng mịn hơn trông thấy. Adenosine cũng làm tăng sự sản xuất của các sợi ellastin và collagen, giúp giảm hiện tượng chảy xệ, làm tăng lưu thông máu trên da, chống lão hóa, giúp hồi phục các hư hại và làm đầy các rãnh nhăn.</li></ol><p>Ngoài ra trong mặt nạ Caryophy còn có: Water, Depropylene Glycol,&nbsp; Asiaticoside, Madecassic Acid, Asiatic Acid, Sodium Shale Oil Sulfonate, Betaine Salicylate, Caprylic/Capric triglyceride, Cetearyl Alcohol, Xanthan Gum, Allantoin,....</p><p>&nbsp;</p><h2>Hướng dẫn sử dụng</h2><ul><li>Bước 1: Làm sạch da. Cắt mép trên của gói và nhẹ nhàng kéo mặt nạ ra ngoài, sau đó đắp lên và trải đều khắp mặt. Nên kéo mặt nạ sao cho vừa với trán và hai bên má, chỉ hở mắt, mũi và miệng. Lấy ngón tay nhấn nhẹ để mặt nạ được ôm khít mặt.</li><li>Bước 2: Nằm thư giãn từ 10-20 phút.</li><li>Bước 3: Tháo mặt nạ và dùng các ngón tay vỗ hoặc massage nhẹ nhàng cho tinh chất thấm sâu vào da tốt hơn.&nbsp;Không cần rửa lại với nước.</li><li>Lưu ý:&nbsp;</li><li>Có thể tận dụng tinh chất còn thừa để sử dụng dưỡng ẩm cho vùng da cổ, tay.</li><li>Hãy sử dụng kết hợp với những sản phẩm cho dòng da mụn của Caryophy để có kết quả tốt hơn.&nbsp;</li></ul>', 'Mặt Nạ Caryophy Làm Giảm Mụn, Thâm & Dưỡng Ẩm Da 22g  là sản phẩm đến từ thương hiệu mỹ phẩm Caryođược nhập khẩu trực tiếp từ Hàn Quốc, chứa chiết xuất từ các thành phần thiên nhiên như rau má, rau sam giúp hỗ trợ làm giảm mụn và thâm mụn, đồng thời dưỡng ẩm cho da mịn màng, mang lại làn da tươi sáng khỏe mạnh.', 1, 25, 1, '2025-03-05 06:42:30', '2025-03-05 06:28:07', 0),
(35, 'Combo 10 Mặt Nạ Sinh Học Emmié Phục Hồi, Dịu Da 25g B5 Complex Mask', '[\"1741156643601-mat-na-sinh-hoc-emmie-by-happy-skin-phuc-hoi-da-23g-1.jpg\", \"1741156643605-mat-na-sinh-hoc-emmie-by-happy-skin-phuc-hoi-da-23g-3.jpg\", \"1741156687588-Screenshot 2025-03-05 at 13-33-17 Combo 10 Máº·t Náº¡ Sinh Há»c EmmiÃ© Phá»¥c Há»i Dá»u Da 25g Hasaki.vn.png\", \"1741156687591-Screenshot 2025-03-05 at 13-33-28 Combo 10 Máº·t Náº¡ Sinh Há»c EmmiÃ© Phá»¥c Há»i Dá»u Da 25g Hasaki.vn.png\", \"1741156687593-Screenshot 2025-03-05 at 13-33-34 Combo 10 Máº·t Náº¡ Sinh Há»c EmmiÃ© Phá»¥c Há»i Dá»u Da 25g Hasaki.vn.png\"]', 590000, 25, 250000, '<figure class=\"table\"><table><tbody><tr><td>Thương Hiệu</td><td>&nbsp;</td><td>Emmié by Happy Skin</td></tr><tr><td>Xuất xứ thương hiệu</td><td>&nbsp;</td><td>Việt Nam</td></tr><tr><td>Nơi sản xuất</td><td>&nbsp;</td><td>&nbsp;&nbsp;&nbsp;&nbsp;Vietnam</td></tr><tr><td>Loại da</td><td>&nbsp;</td><td>Da thường/Mọi loại da</td></tr></tbody></table></figure><h3>Thành phần sản phẩm</h3><p>Aqua, Butylene Glycol, Glycerin, Panthenol, Beta-Glucan, Ceramide Np, Ceramide Ap, Ceramide Eop, Cholesterol, Saccharide Isomerate, Allantoin, Sodium Hyaluronate, Placental Protein, Hydrolyzed Royal Jelly Protein, Ammonium Glycyrrhizate, Kappaphycus Alvarezii Extract, Seawater, Centella Asiatica Extract, Acetyl Tetrapeptide-15, Aesculus Hippocastanum Seed Extract, Undaria Pinnatifida Extract, Peg-60 Hydrogenated Castor Oil, Polyacrylate Crosspolymer-11, Xanthan Gum, Disodium Edta, Mannitol, Pentylene Glycol, Sodium Citrate, 1,2-Hexanediol, Caffeine, Caprylic/Capric Triglyceride, Caprylyl Glycol, Carbomer, Hydrogenated Lecithin, Phytosphingosine, Sodium Lauroyl Lactylate, Phenoxyethanol, Zinc Gluconate, Citric Acid</p><h3>Loại da phù hợp:&nbsp;</h3><p>Sản phẩm thích hợp với mọi loại da.&nbsp;</p><h3>Giải pháp cho tình trạng da:&nbsp;</h3><ul><li>Da <a href=\"https://hasaki.vn/danh-muc/thieu-am-thieu-nuoc-c1883.html\">thiếu nước, thiếu ẩm</a>.&nbsp;</li><li>Da <a href=\"https://hasaki.vn/danh-muc/nhay-cam-kich-ung-c1885.html\">nhạy cảm, kích ứng</a>.&nbsp;&nbsp;</li></ul><h3>Ưu thế nổi bật:&nbsp;</h3><ul><li><strong>Dexpanthenol (Vitamin B5)</strong> sửa chữa làn da nhạy cảm, dưỡng ẩm sâu và phục hồi đa tầng.</li><li><strong>Actosome Centella</strong> chiết xuất rau má với công nghệ Nano Liposome với hiệu quả&nbsp; chống viêm và kháng khuẩn ưu việt.</li><li><strong>Acetyl tetrapeptide-15</strong> được chứng minh lâm sàng giúp làm giảm đau rát, khó chịu và các tổn thương da khác do yếu tố môi trường hoặc mỹ phẩm.</li><li><strong>NMF complex</strong> phức hợp chứa các ceramides và cholesterol giúp xây dựng lại hàng rào bảo vệ da, giúp tăng đề kháng và bảo vệ da khỏi tình trạng mất nước qua da.</li><li>Chất liệu<strong> bio-cellulose t</strong>hân thiện với da và môi trường, ôm khít khuôn mặt.</li></ul><h3>Hướng dẫn sử dụng</h3><ol><li>Làm sạch da.</li><li>Tháo 2 lớp màng bảo vệ và đắp mặt nạ trong vòng 15-30 phút.</li><li>Không cần rửa lại với nước, mát xa nhẹ cho phần tinh chất thẩm thấu hết vào da.</li><li>Sử dụng sau khi làm các liệu trình không xâm lấn, để cấp ẩm chuyên sâu hàng tuần hoặc bất kỳ khi nào cần làm dịu da. Hiệu quả tốt hơn khi sử dụng với Kem nước B5.</li></ol><p><i><strong>Lưu ý:</strong> </i>Tránh tiếp xúc với mắt.</p>', 'Mặt Nạ Sinh Học Emmié by Happy Skin Phục Hồi Da là sản phẩm mặt nạ giấy đến từ thương hiệu mỹ phẩm Emmié by Happy Skin của Việt Nam, với chất liệu bio-cellulose thân thiện với da và môi trường, ngậm đến 95% dưỡng chất cho da phục hồi và cải thiện tình trạng da thiếu ẩm, mẩn đỏ chỉ trong một bước. Mặt nạ ôm khít khuôn mặt, giúp làm dịu da mụn, phục hồi da nhạy cảm và cải thiện tức thì', 1, 250, 19, '2025-03-05 08:45:28', '2025-03-05 06:37:23', 0),
(36, 'Gel Rửa Mặt La Roche-Posay Dành Cho Da Dầu, Nhạy Cảm 400ml', '[\"1741157553354-Screenshot 2025-03-05 at 13-51-23 Gel Rá»­a Máº·t La Roche-Posay DÃ nh Cho Da Dáº§u Nháº¡y Cáº£m 400ml Hasaki.vn.png\", \"1741157553360-Screenshot 2025-03-05 at 13-51-32 Gel Rá»­a Máº·t La Roche-Posay DÃ nh Cho Da Dáº§u Nháº¡y Cáº£m 400ml Hasaki.vn.png\", \"1741157553364-Screenshot 2025-03-05 at 13-51-40 Gel Rá»­a Máº·t La Roche-Posay DÃ nh Cho Da Dáº§u Nháº¡y Cáº£m 400ml Hasaki.vn.png\", \"1741157553367-Screenshot 2025-03-05 at 13-51-47 Gel Rá»­a Máº·t La Roche-Posay DÃ nh Cho Da Dáº§u Nháº¡y Cáº£m 400ml Hasaki.vn.png\", \"1741157553375-Screenshot 2025-03-05 at 13-52-03 Gel Rá»­a Máº·t La Roche-Posay DÃ nh Cho Da Dáº§u Nháº¡y Cáº£m 400ml Hasaki.vn.png\"]', 656000, 21, 465000, '<figure class=\"table\"><table><tbody><tr><td>Barcode</td><td>&nbsp;</td><td>3337872411991</td></tr><tr><td>Thương Hiệu</td><td>&nbsp;</td><td>La Roche-Posay</td></tr><tr><td>Xuất xứ thương hiệu</td><td>&nbsp;</td><td>Pháp</td></tr><tr><td>Nơi sản xuất</td><td>&nbsp;</td><td>France</td></tr></tbody></table></figure><h3>Thành phần sản phẩm</h3><p><strong>Thành phần chính:&nbsp;</strong></p><ul><li><strong>Nước khoáng thiên nhiên La Roche-Posay:</strong> có tác dụng làm dịu da và giảm kích ứng.</li><li><strong>ZinC PCA:</strong> giúp điều tiết lượng dầu tiết ra trên da, từ đó kiểm soát bóng dầu và bã nhờn dư thừa hiệu quả, giảm hình thành mụn đầu đen.</li><li>Không chứa Paraben, chất tạo màu, xà phòng, cồn, an toàn cho làn da nhạy cảm.</li><li>Công thức không chứa dầu (oil-free) nên rất thích hợp cho da dầu.</li></ul><p><strong>Thành phần chi tiết:&nbsp;</strong></p><p>Aqua / Water, Sodium Laureth Sulfate, Peg-8, Coco-Betaine, Hexylene Glycol, Sodium Chloride, Peg-120 Methyl Glucose Dioleate, Zinc Pca, Sodium Hydroxide, Citric Acid, Sodium Benzoate, Phenoxyethanol, Caprylyl Glycol, Parfum / Fragrance</p><h3>Hướng dẫn sử dụng</h3><ol><li>Làm ẩm da với nước ấm, cho một lượng vừa đủ sản phẩm ra tay, tạo bọt, thoa sản phẩm lên mặt, tránh vùng da quanh mắt.</li><li>Massage nhẹ nhàng, sau đó rửa sạch lại với nước và thấm khô da.</li><li>Sử dụng hằng ngày vào buổi sáng và tối.</li></ol><p><strong>Lưu ý:&nbsp;</strong></p><p>Tránh tiếp xúc với mắt.</p><p>Trong quá trình sử dụng nếu thấy da có các biểu hiện khác thường như: xuất hiện các vết đỏ, ngứa, hay bị kích ứng thì phải ngưng sử dụng ngay và hỏi ý kiến tư vấn từ chuyên gia da liễu.</p>', 'Gel Rửa Mặt La Roche-Posay Effaclar Purifying Foaming Gel For Oily Sensitive Skin là dòng sản phẩm sữa rửa mặt chuyên biệt dành cho làn da dầu, mụn, nhạy cảm đến từ thương hiệu dược mỹ phẩm La Roche-Posay nổi tiếng của Pháp, với kết cấu dạng gel tạo bọt nhẹ nhàng giúp loại bỏ bụi bẩn, tạp chất và bã nhờn dư thừa trên da hiệu quả, mang đến làn da sạch mịn, thoáng nhẹ và tươi mát.', 1, 800, 5, '2025-03-05 07:19:49', '2025-03-05 06:52:33', 0),
(37, 'Bộ Gội Xả L\'Oreal Dưỡng Tóc Suôn Mượt Tóc Cao Cấp 440mlx2 Extraordinary Oil Sleek Silicone-free Shampoo & Conditioner', '[\"1741157790796-Screenshot 2025-03-05 at 13-54-29 Bá» Gá»i Xáº£ L\'Oreal DÆ°á»¡ng TÃ³c SuÃ´n MÆ°á»£t TÃ³c Cao Cáº¥p 440mlx2 Hasaki.vn.png\", \"1741157790803-Screenshot 2025-03-05 at 13-54-37 Bá» Gá»i Xáº£ L\'Oreal DÆ°á»¡ng TÃ³c SuÃ´n MÆ°á»£t TÃ³c Cao Cáº¥p 440mlx2 Hasaki.vn.png\", \"1741157790805-Screenshot 2025-03-05 at 13-54-41 Bá» Gá»i Xáº£ L\'Oreal DÆ°á»¡ng TÃ³c SuÃ´n MÆ°á»£t TÃ³c Cao Cáº¥p 440mlx2 Hasaki.vn.png\", \"1741157790809-Screenshot 2025-03-05 at 13-54-46 Bá» Gá»i Xáº£ L\'Oreal DÆ°á»¡ng TÃ³c SuÃ´n MÆ°á»£t TÃ³c Cao Cáº¥p 440mlx2 Hasaki.vn.png\", \"1741157790812-Screenshot 2025-03-05 at 13-54-51 Bá» Gá»i Xáº£ L\'Oreal DÆ°á»¡ng TÃ³c SuÃ´n MÆ°á»£t TÃ³c Cao Cáº¥p 440mlx2 Hasaki.vn.png\"]', 518000, 26, 275000, '<p><strong>Bộ Chăm Sóc Tóc L\'Oreal Paris Extraordinary&nbsp;</strong>hiện đã có tại&nbsp;<a href=\"https://hasaki.vn/\"><strong>Hasaki</strong></a><strong>&nbsp;</strong>bao gồm 2 món:</p><ul><li><strong>01 x Dầu&nbsp;Gội Dưỡng Tóc Suôn Mượt Tóc Cao Cấp L\'Oreal Paris Extraordinary Oil Smooth 440ml</strong></li><li><strong>01 x Dầu</strong>&nbsp;<strong>Xả Dưỡng Tóc Suôn Mượt Tóc Cao Cấp&nbsp;L\'Oreal Paris Extraordinary </strong>Thành phần sản phẩm</li></ul><h3><strong>1.&nbsp;Dầu&nbsp;Gội Dưỡng Tóc Suôn Mượt Tóc Cao Cấp L\'Oreal Paris Extraordinary Oil Sleek Silicone-free Shampoo 440ml</strong></h3><p><strong>Thành phần chính:</strong></p><ul><li><strong>Chiết xuất từ 100% tinh dầu gỗ tuyết tùng tự nhiên từ Pháp:&nbsp;</strong>giúp phục hồi các lớp biểu bì tóc bị hư tổn.</li></ul><p><strong>Bảng thành phần:&nbsp;</strong>Aqua / Water, Sodium Laureth Sulfate, Citric Acid, Cocamidopropyl Betaine, Sodium Chloride, Ammonium Hydroxide, Hexylene Glycol, Ci 15985 / Yellow 6, Ci 19140 / Yellow 5, Sodium Benzoate, Sodium Hydroxide, Sodium Acetate, Cedrus Atlantica Bark Oil, Polyquaternium-10, Salicylic Acid, Limonene, Menthol, Linalool, Propylene Glycol, Isopropyl Alcohol, 2-Oleamido-1,3-Octadecanediol , Parfum, Piroctone Olamine, Coumarin, Lavandula Angustifolia Oil / Lavender Oil, Hexyl Cinnamal.</p><h3><strong>2.&nbsp;Dầu&nbsp;</strong>Xả Dưỡng Tóc Suôn Mượt Tóc Cao Cấp&nbsp;<strong>L\'Oreal Paris Extraordinary Oil Sleek Nourishing Conditioner 440ml</strong></h3><p><strong>Thành phần chính:</strong></p><ul><li><strong>Chiết xuất từ 100% tinh dầu gỗ tuyết tùng tự nhiên từ Pháp:&nbsp;</strong>giúp phục hồi các lớp biểu bì tóc bị hư tổn.</li></ul><p><strong>Bảng thành phần:&nbsp;</strong>Aqua / Water, Cetearyl Alcohol, Amodimethicone, Behentrimonium Chloride, Cetyl Esters, Ci 77891 / Titanium Dioxide, Ci 77491 / Iron Oxides, Ci 15985 / Yellow 6, Ci 19140 / Yellow 5, Mica, Tocopheryl Acetate, Cedrus Atlantica Bark Oil, Phenoxyethanol, Ethylhexyl Salicylate, Trideceth-6,Chlorhexidine Dihydrochloride, Limonene, Linalool, Isopropyl Alcohol, 2-Oleamido-1,3-Octadecanediol, Caramel, Cetrimonium Chloride,Coumarin, Lavandula Angustifolia Oil / Lavender Oil, Hexyl Cinnamal, Parfum / Fragrance.</p><h2>Hướng dẫn sử dụng</h2><h4><strong>1.&nbsp;Dầu gội dưỡng tóc suôn mượt tóc cao cấp L\'Oreal Paris Extraordinary Oil Sleek Silicone-free Shampoo 440ml</strong></h4><ul><li>Nhẹ nhàng cho dầu gội lên tóc và massage nhẹ nhàng da đầu tạo bọt.</li><li>Xả sạch dầu gội với nước lạnh.</li><li>Tiếp tục sử dụng dầu xả&nbsp;<strong>Extraordinary Oil Sleek </strong>để đạt hiệu quả tối ưu.</li></ul><h4><strong>2.&nbsp;Dầu xả dưỡng tóc suôn mượt tóc cao cấp L\'Oreal Paris Extraordinary Oil Sleek Nourishing Conditioner 440ml</strong></h4><ul><li>Sau khi gội đầu với <strong>dầu gội&nbsp;Extraordinary Oil Sleek</strong>,</li></ul>', '<p>Chiết xuất từ 100%tinh dầu gỗ tuyết tùng tự nhiên từ Pháp: Được biết đến với đặc tính chữa bệnh, tinh dầu gỗ tuyết tùng 100% tự nhiên và tinh khiết của Pháp có tác dụng phục hồi và hàn gắn các lớp biểu bì tóc bị hư tổn, mang lại mái tóc suôn mượt, thẳng và bóng mượt hơn mà không bị xơ rối.</p>', 1, 900, 10, '2025-03-05 06:56:30', '2025-03-05 06:56:30', 0),
(38, 'Tinh Chất Mọc Tóc L\'Oréal Professionnel Dạng Xịt 90ml (Mới) Serioxyl Advanced', '[\"1741158021673-Screenshot 2025-03-05 at 13-59-42 Tinh Cháº¥t Má»c TÃ³c L\'OrÃ©al Professionnel Dáº¡ng Xá»t 90ml (Má»i) Hasaki.vn.png\", \"1741158021677-Screenshot 2025-03-05 at 13-59-48 Tinh Cháº¥t Má»c TÃ³c L\'OrÃ©al Professionnel Dáº¡ng Xá»t 90ml (Má»i) Hasaki.vn.png\", \"1741158021678-Screenshot 2025-03-05 at 13-59-52 Tinh Cháº¥t Má»c TÃ³c L\'OrÃ©al Professionnel Dáº¡ng Xá»t 90ml (Má»i) Hasaki.vn.png\", \"1741158021678-Screenshot 2025-03-05 at 13-59-56 Tinh Cháº¥t Má»c TÃ³c L\'OrÃ©al Professionnel Dáº¡ng Xá»t 90ml (Má»i) Hasaki.vn.png\", \"1741158021680-Screenshot 2025-03-05 at 14-00-05 Tinh Cháº¥t Má»c TÃ³c L\'OrÃ©al Professionnel Dáº¡ng Xá»t 90ml (Má»i) Hasaki.vn.png\"]', 1225000, 26, 821000, '<figure class=\"table\"><table><tbody><tr><td>Barcode</td><td>&nbsp;</td><td>3474637106348</td></tr><tr><td>Thương Hiệu</td><td>&nbsp;</td><td>L\'Oreal Professionnel</td></tr><tr><td>Xuất xứ thương hiệu</td><td>&nbsp;</td><td>Pháp</td></tr><tr><td>Nơi sản xuất</td><td>&nbsp;</td><td>France</td></tr><tr><td>Giới tính</td><td>&nbsp;</td><td>Nam và Nữ</td></tr></tbody></table></figure><h4>Thành phần sản phẩm</h4><p><strong>Thành phần chính:</strong></p><p><strong>5% Stemoxydine:</strong>&nbsp;là một phân tử được cấp bằng sáng chế, có khả năng \"đánh thức\" các nang tóc không hoạt động, từ đó kích thích mọc tóc mới.<br>&nbsp;</p><p><strong>Resveratrol:&nbsp;</strong>hoạt chất chống oxy hoá mạnh mẽ, giúp tăng cường tác dụng của&nbsp;Stemoxydine khi hoạt động trên da đầu, từ đó mang đến hiệu quả rõ rệt.</p><p><strong>Thành phần chi tiết:</strong></p><p>Alcohol Denat., Aqua / Water, Diethyllutidinate, Resveratrol, Ethyl Ester Of Pvm/ma Copolymer, Linalool, Geraniol, Citronellol, Benzyl Salicylate, Benzyl Alcohol, Limonene, Parfum / Fragrance.</p><h4>Hướng dẫn sử dụng</h4><p>Khuyến khích sử dụng vào buổi tối sau khi đã làm sạch tóc.</p><p>Sử dụng sản phẩm vào phần da đầu &amp; chân tóc để đạt hiệu quả tối đa.</p><p>Massage nhẹ nhàng bằng phần mềm của các đầu ngón tay để dưỡng chất thẩm thấu&nbsp;(Không cần xả lại với nước).</p>', '<p>Tinh chất mọc tóc L\'Oréal Professionnel Serioxyl Advanced 90ml là sản phẩm serum dưỡng tóc đến từ thương hiệu chăm sóc tóc chuyên nghiệp L\'Oreal Professionnel với công thức chứa 5% Stemoxydine và Resveratrol giúp duy trì hoạt động thích hợp của tế bào gốc và tối ưu hóa chu kỳ tóc, từ đó cải thiện chu trình nang tóc thay mới, giúp làm tăng mật độ tóc. Tóc dày hơn chỉ sau 6 tuần sử dụng*.</p>', 1, 400, 10, '2025-03-05 07:00:21', '2025-03-05 07:00:21', 0),
(39, 'Son Dưỡng Môi Mediheal Mềm Mại, Mịn Màng Ban Đêm 10ml Pantenolips Healbalm', '[\"1741158214606-Screenshot 2025-03-05 at 14-01-36 Son DÆ°á»¡ng MÃ´i Mediheal Má»m Máº¡i Má»n MÃ ng Ban ÄÃªm 10ml Hasaki.vn.png\", \"1741158214608-Screenshot 2025-03-05 at 14-01-40 Son DÆ°á»¡ng MÃ´i Mediheal Má»m Máº¡i Má»n MÃ ng Ban ÄÃªm 10ml Hasaki.vn.png\", \"1741158214610-Screenshot 2025-03-05 at 14-01-44 Son DÆ°á»¡ng MÃ´i Mediheal Má»m Máº¡i Má»n MÃ ng Ban ÄÃªm 10ml Hasaki.vn.png\", \"1741158214613-Screenshot 2025-03-05 at 14-01-49 Son DÆ°á»¡ng MÃ´i Mediheal Má»m Máº¡i Má»n MÃ ng Ban ÄÃªm 10ml Hasaki.vn.png\", \"1741158214615-Screenshot 2025-03-05 at 14-01-55 Son DÆ°á»¡ng MÃ´i Mediheal Má»m Máº¡i Má»n MÃ ng Ban ÄÃªm 10ml Hasaki.vn.png\"]', 143000, 22, 66000, '<figure class=\"table\"><table><tbody><tr><td>Barcode</td><td>&nbsp;</td><td>8809335481056</td></tr><tr><td>Thương Hiệu</td><td>&nbsp;</td><td>Mediheal</td></tr><tr><td>Xuất xứ thương hiệu</td><td>&nbsp;</td><td>Hàn Quốc</td></tr><tr><td>Nơi sản xuất</td><td>&nbsp;</td><td>Korea</td></tr><tr><td>Đặc tính</td><td>&nbsp;</td><td>Không màu</td></tr></tbody></table></figure><h3>Thành phần sản phẩm</h3><h4><strong>1. Labocare Pantenolips Healssence Coral (màu hồng)</strong></h4><p><strong>Thành phần chính:</strong></p><p><strong>10% Panthenol</strong>&nbsp;(được chuyển hóa từ Vitamin B5): có tác dụng phục hồi làn môi đang bị tổn thương, cải thiện rãnh môi, ngăn ngừa các dấu hiệu lão hóa.</p><p><strong>Chiết xuất&nbsp;rau má:</strong>&nbsp;có tác dụng làm dịu, giảm viêm và kích ứng.</p><p><strong>Chiết xuất từ các loại tinh dầu:&nbsp;Dầu hạt hướng dương, Dầu argan, Dầu hạt macadamia và Dầu Olive:</strong>&nbsp;có độ ẩm tối ưu, giảm thiểu tối đa tình trạng nứt nẻ và khô môi, kích thích tái tạo collagen, để bờ môi luôn mềm mịn, căng bóng.</p><h4><strong>2. Labocare Pantenolips Healssence (màu xanh)</strong></h4><p><strong>Thành phần chính</strong>:</p><p><strong>10% Panthenol</strong>&nbsp;(được chuyển hóa từ Vitamin B5): có tác dụng phục hồi làn môi đang bị tổn thương, cải thiện rãnh môi, ngăn ngừa các dấu hiệu lão hóa.</p><p><strong>Chiết xuất&nbsp;rau má:</strong>&nbsp;có tác dụng làm dịu, giảm viêm và kích ứng.</p><p><strong>Chiết xuất từ các loại tinh dầu:&nbsp;Dầu hạt hướng dương, Dầu argan, Dầu hạt macadamia và Dầu Olive:</strong>&nbsp;có độ ẩm tối ưu, giảm thiểu tối đa tình trạng nứt nẻ và khô môi, kích thích tái tạo collagen, để bờ môi luôn mềm mịn, căng bóng.</p><p><strong>Thành phần chi tiết:&nbsp;</strong>Water, Sorbitol, Panthenol, Phytosteryl Sunflowerseedate, Isohexadecane, Glycerin, Caprylic/Capric Triglyceride, Cetearyl Alcohol, Diisostearyl Malate, PEG/PPG-17/6 Copolymer, Beeswax, Hydrogenated Palm Glycerides, Polysorbate 60, Glyceryl …</p><h4><strong>3. Labocare Paneno Lips Healbalm (màu đỏ)</strong></h4><p><strong>Thành phần chính:</strong></p><p><strong>10% Panthenol</strong>&nbsp;(được chuyển hóa từ Vitamin B5): có tác dụng phục hồi làn môi đang bị tổn thương, cải thiện rãnh môi, ngăn ngừa các dấu hiệu lão hóa.</p><p><strong>Chiết xuất&nbsp;rau má:</strong>&nbsp;có tác dụng làm dịu, giảm viêm và kích ứng.</p><p><strong>Chiết xuất từ các loại tinh dầu:&nbsp;Dầu hạt hướng dương, Dầu argan, Dầu hạt macadamia và Dầu Olive:</strong>&nbsp;có độ ẩm tối ưu, giảm thiểu tối đa tình trạng nứt nẻ và khô môi, kích thích tái tạo collagen, để bờ môi luôn mềm mịn, căng bóng.</p><p><strong>Thành phần chi tiết:&nbsp;</strong></p><p>Water, Panthenol, Sorbitol, Isohexadecane, Caprylic/Capric Triglyceride, Glycerin, Dilinoleic Acid/Propanediol Copolymer, Cetearyl Alcohol, Diisostearyl Malate, Macadamia Ternifolia Seed Oil, PEG/PPG-17/6 Copolymer, Phytosteryl Sunflowerseedate, Beeswax, Polysorbate 60, Glyceryl Stearate, Methyl Glucose Sesquistearate, Sorbitan Sesquioleate, Hydrogenated Vegetable Glycerides, Dimethicone, 1,2-Hexanediol, Tocopheryl Acetate, PEG-100 Stearate, Arginine, Carbomer, Butylene Glycol, Caprylhydroxamic Acid, Sodium Acrylate/Sodium Acryloyldimethyl Taurate Copolymer, Allantoin, Fragrance, Polysorbate 80, Disodium EDTA, Sodium Hyaluronate, Helianthus Annuus Seed Oil, Olea Europaea Fruit Oil, Argania Spinosa Kernel Oil, Sorbitan Oleate</p><h4>Hướng dẫn sử dụng</h4><ol><li>Thoa son để dưỡng ẩm và làm mềm làn môi, thoa son thường xuyên để thấy hiệu quả rõ rệt.</li><li>Sử dụng son dưỡng để bảo vệ và làm căng bóng môi trước khi thoa son màu.</li><li>Không thoa lên vết thương, vùng da viêm nhiễm, lở loét.</li></ol>', '<p>Son Dưỡng Môi Mediheal 10ml là sản phẩm son dưỡng môi đến từ thương hiệu mỹ phẩm Mediheal của Hàn Quốc, chứa thành phần Dexpanthenol (tiền chất Vitamin B5), Vitamin B5, tinh chất cây tầm xuân, Ceramide cải thiện tình trạng khô ráp của môi giúp cho đôi môi trở nên mềm mại, cải thiện sắc tố môi, hạn chế các tế bào melanin làm môi trở nên thâm sạm môi, giúp môi sáng màu hơn.</p>', 1, 25, 5, '2025-03-05 11:08:30', '2025-03-05 07:03:34', 0),
(40, 'Kem Dưỡng Thể Paula’s Choice 10% AHA Làm Sáng Da 210ml Resist Skin Revealing Body Lotion with 10% AHA', '[\"1741158710611-1.png\", \"1741158722519-2.png\", \"1741158722521-4.png\", \"1741158722522-6.png\", \"1741158722523-8.png\"]', 694000, 24, 0, '<h4>Thông số sản phẩm</h4><figure class=\"table\"><table><tbody><tr><td>Barcode</td><td>0655439059008</td></tr><tr><td>Thương Hiệu</td><td>Paula\'s Choice</td></tr><tr><td>Xuất xứ thương hiệu</td><td>Mỹ</td></tr><tr><td>Nơi sản xuất</td><td>United States</td></tr><tr><td>Loại da</td><td>Da thường/Mọi loại da</td></tr></tbody></table></figure><h4>Thành phần sản phẩm</h4><p><strong>Thành phần chính:&nbsp;</strong></p><ul><li><strong>Chiết Xuất Cúc La Mã:</strong> Nuôi dưỡng làn da toàn diện</li><li><strong>Chiết Xuất Nho, Trà Xanh:</strong> Chống oxy hóa hiệu quả</li></ul><p><strong>Thành phần chính:&nbsp;</strong>Water, Glycolic Acid (alpha hydroxy acid/exfoliant), Cyclopentasiloxane (hydration), Dimethicone (hydration), Glycerin (hydration/skin replenishing), Glyceryl Stearate (texture-enhancing), Stearic Acid (texture-enhancing), Cetyl Alcohol (texture-enhancing), Butyrospermum Parkii (shea butter/emollient/antioxidant), Sodium Hydroxide (pH adjuster), PEG-100 Stearate (texture-enhancing), Tetrahexyldecyl Ascorbate (stabilized vitamin C/antioxidant), Tocopheryl Acetate (vitamin E/antioxidant), Chamomilla Recutita Matricaria Flower Extract (chamomile extract/skin-soothing), Vitis Vinifera Seed Oil (grape extract/non-fragrant oil/emollient/antioxidant), Camellia Oleifera Extract (green tea extract/antioxidant), Epilobium Angustifolium Flower/Leaf/Stem Extract (willow herb extract (skin-soothing), Allantoin (skin-soothing), Butylene Glycol (hydration), Xanthan Gum (texture-enhancing), Disodium EDTA (stabilizer), sodium benzoate (preservative), phenoxyethanol (preservative).</p><h4>Hướng dẫn sử dụng</h4><p>Lấy một lượng nhỏ sản phẩm để làm sạch da. Có thể được sử dụng hàng ngày đối với toàn bộ cơ thể hoặc loại bỏ tại chỗ với một vùng da khi cần thiết. Hãy kết hợp với các sản phẩm dưỡng ẩm tốt khác để đạt hiệu quả tốt nhất.</p>', '<p>Kem Dưỡng Thể Paula’s Choice Resist Skin Revealing Body Lotion with 10% AHA là sản phẩm dưỡng thể tẩy tế bào chết đến từ thương hiệu dược mỹ phẩm Paula\'s Choice, chứa nồng độ 10% AHA có khả năng loại bỏ tế bào chết nhẹ nhàng trên cơ thể, hoàn toàn không gây mài mòn da, giúp mang lại làn da sáng mịn, tươi trẻ và rạng rỡ hơn.</p>', 1, 200, 1, '2025-03-05 07:12:02', '2025-03-05 07:10:09', 0),
(42, 'Kem Chống Nắng Skin1004 Cho Da Nhạy Cảm SPF 50+ 50ml Madagascar Centella Air-Fit Suncream Plus SPF50+ PA++++', '[\"1741159092069-Screenshot 2025-03-05 at 14-17-45 .png\", \"1741159092072-Screenshot 2025-03-05 at 14-17-51 .png\", \"1741159092075-Screenshot 2025-03-05 at 14-17-55 .png\", \"1741159092077-Screenshot 2025-03-05 at 14-17-59 .png\"]', 205000, 23, NULL, '<h4>Thông số sản phẩm</h4><figure class=\"table\"><table><tbody><tr><td>Barcode</td><td>8809576261301</td></tr><tr><td>Thương Hiệu</td><td>Skin1004</td></tr><tr><td>Xuất xứ thương hiệu</td><td>Hàn Quốc</td></tr><tr><td>Nơi sản xuất</td><td>&nbsp;</td></tr><tr><td>Loại da</td><td>Da nhạy cảm</td></tr></tbody></table></figure><h4>Thành phần sản phẩm</h4><p><strong>Thành phần chính:</strong></p><ul><li><strong>Thêm 20% chiết xuất rau má so với phiên bản trước,&nbsp;rau má vùng Madagascar:</strong> giàu vitamin B,C và polyphenols có khả năng chống oxi hóa, phục hồi, làm dịu da, kháng viêm, giảm thâm, giúp da trắng sáng mịn màng, hỗ trợ giảm mụn.</li><li><strong>Kem chống nắng vật lý không chứa khoáng chất nano cùng với độ SPF 50+ PA++++:</strong> giúp bảo vệ làn da tối ưu.</li><li><strong>Chứa thành phần Multiex BASAM với 7 chiết xuất từ thực vật:</strong> giúp dưỡng ẩm da nhẹ nhàng, bảo vệ da luôn khoẻ mạnh, củng cố khả năng tái tạo da.</li><li><strong>Madewhite:</strong> thành phần nâng tông từ chiết xuất rau má có khả năng nâng tông da tự nhiên, dưỡng sáng da tự nhiên.&nbsp;</li></ul><p><strong>Thành phần đầy đủ:</strong></p><p>Centella Asiatica Extract (35.8%), Cyclopentasiloxane, Zinc Oxide, Butyl Octyl Salicylate, Titanium Dioxide, Propanediol, Benzotriazolyldodecyl P-cresol, Coptis Root Extract, Peg-10 Dime Ticon, Niacinamide, Disteadimonium Hectorite, Butylene Glycol, Magnesium Sulfate, 1,2-hexanediol, Caprylic/Capric Glyceride, Dimethicone, Vp/Hexadecene Copolymer, Poly Methylsilsesquioxane, Aluminum Hydroxide, Stearic Acid, Sorbitan Sesquioleate, Triethoxycaprylylsilane, Dimethicone Crosspolymer, Dimethicone/Vinyldimethicone Crosspolymer, Dextrin, Cacao Extract, Scented Geranium Flower Oil, Purified Water, Bergamot Oil, Betaine, Golden Extract, Hojanggae Root Extract, Spanish Licorice Root Extract, Green Tea Extract, | Sodium Hyaluronate, Rosemary Leaf Extract, Matricaria Flower Extract, Damask Rose Oil, Pentylene Glycol, Madecassoside, Citronellol, Geraniol, Linalool</p><h4>Hướng dẫn sử dụng</h4><ol><li>Lấy 1 lượng kem vừa đủ lên toàn khuôn mặt ở bước cuối cùng trong quá trình chăm sóc da, vỗ nhẹ để kem thấm qua da. bạn sẽ thấy da sáng lên và mịn màng trông thấy.</li><li>Thoa kem trước khi ra đường 15 phút để có hiệu quả chống nắng cao.</li></ol>', 'Kem Chống Nắng Skin1004 Cho Da Nhạy Cảm là sản phẩm kem chống nắng da mặt đến từ thương hiệu mỹ phẩm Skin1004 của Hàn Quốc, là kem chống nắng vật lý với chiết xuất rau má và chất kem mỏng nhẹ có màu giúp che phủ nhẹ khuyết điểm cho da. Công thức đa năng vừa chống nắng vừa đều màu da lại dưỡng ẩm chính là sản phẩm mà những cô nàng da mụn hay da dầu nhạy cảm cần vì không cần sử dụng', 1, 300, 4, '2025-03-05 07:19:11', '2025-03-05 07:18:12', 0);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL,
  `name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `phone` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `email` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `role` tinyint(1) DEFAULT '1',
  `status` tinyint(1) DEFAULT '1',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `image`, `phone`, `email`, `password`, `role`, `status`, `createdAt`, `updatedAt`) VALUES
(16, 'DuyenKha', '1741039996114-monnhungfrydekmow-768x768.jpg', '0337019197', 'Duyenktbpc08750@gmail.com', '$2b$10$a.W6JuShnvdmLc4oPZimXuCnmisaxovvwiLp0HQ5f6rMAdDFo/lVG', 1, 1, '2025-03-03 10:12:03', '2025-03-05 11:02:14'),
(17, 'Admin', NULL, NULL, 'khathibaoduyen9@gmail.com', '$2b$10$Fz3u/xTgWbk/Ox8msiYv.u/AmM0aAD2WS00Lo0l7BFTurUPMH963O', 1, 1, '2025-03-05 05:42:41', '2025-03-05 05:42:41'),
(18, 'Baoduyen', NULL, NULL, 'frgtrtytjyt@gmail.com', '$2b$10$uUq4/pqFhaQlo.lwKj4jrecyknxaPL0zfOImzCOP26K3PRjrvEm9m', 1, 1, '2025-03-05 10:59:26', '2025-03-05 10:59:26');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`id`),
  ADD KEY `CartByProduct` (`product_id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `detailorder`
--
ALTER TABLE `detailorder`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_Order_OrderDetail` (`orderId`),
  ADD KEY `Fk_detailOder_Product` (`productId`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `txnRef` (`txnRef`),
  ADD KEY `FK_User_Orders` (`user_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `productByCategogy` (`category_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cart`
--
ALTER TABLE `cart`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=125;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `detailorder`
--
ALTER TABLE `detailorder`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=172;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=156;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cart`
--
ALTER TABLE `cart`
  ADD CONSTRAINT `CartByProduct` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `detailorder`
--
ALTER TABLE `detailorder`
  ADD CONSTRAINT `Fk_detailOder_Product` FOREIGN KEY (`productId`) REFERENCES `products` (`id`),
  ADD CONSTRAINT `FK_Order_OrderDetail` FOREIGN KEY (`orderId`) REFERENCES `orders` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `FK_User_Orders` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `productByCategogy` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
