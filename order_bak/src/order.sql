/*
 Navicat Premium Data Transfer

 Source Server         : root
 Source Server Type    : MySQL
 Source Server Version : 50717
 Source Host           : localhost:3306
 Source Schema         : order

 Target Server Type    : MySQL
 Target Server Version : 50717
 File Encoding         : 65001

 Date: 02/06/2018 20:57:59
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for t_company
-- ----------------------------
DROP TABLE IF EXISTS `t_company`;
CREATE TABLE `t_company`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '公司名称',
  `contacts` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '联系人',
  `address` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '联系地址',
  `business` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '主营业务',
  `level` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '企业星级',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `roleId` int(11) NULL DEFAULT NULL,
  `userName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `card` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tax` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `telphone` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_company
-- ----------------------------
INSERT INTO `t_company` VALUES (1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `t_company` VALUES (2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `t_company` VALUES (4, '4', '4', '4', '4', '4', '4', 3, '321', NULL, NULL, NULL);
INSERT INTO `t_company` VALUES (5, '333333', '6', '7', '1', '1', '1', 1, '123', NULL, NULL, NULL);
INSERT INTO `t_company` VALUES (14, '1', '1', '1', '1', '1', '1', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `t_company` VALUES (15, 'awef', '123', '1', '1', '1', '1', 3, 'test', NULL, NULL, NULL);
INSERT INTO `t_company` VALUES (17, '34q3r', '123', '1', '1', '1', '1', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `t_company` VALUES (18, '132', '123', '123', '123', '123', '123', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `t_company` VALUES (19, 'abcdefg', '123', '123', '123', '123', '123', 2, 'abcd', NULL, NULL, NULL);
INSERT INTO `t_company` VALUES (20, '测试企业', '', '', '', '', '', 2, 'wyj', NULL, NULL, NULL);

-- ----------------------------
-- Table structure for t_confirm
-- ----------------------------
DROP TABLE IF EXISTS `t_confirm`;
CREATE TABLE `t_confirm`  (
  `id` int(11) NOT NULL,
  `confirmDate` int(11) NULL DEFAULT NULL,
  `remark` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `remark2` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for t_order
-- ----------------------------
DROP TABLE IF EXISTS `t_order`;
CREATE TABLE `t_order`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `company_id` int(10) NULL DEFAULT NULL COMMENT '公司id',
  `order_no` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '订单编号',
  `start_date` datetime(0) NULL DEFAULT NULL COMMENT '下单时间',
  `confirm_date` datetime(0) NULL DEFAULT NULL COMMENT '订单确认时间，管理员确认订单',
  `pill_date` datetime(0) NULL DEFAULT NULL COMMENT '付款时间',
  `end_date` datetime(0) NULL DEFAULT NULL COMMENT '结束时间',
  `status` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '订单状态',
  `amount` decimal(10, 5) NULL DEFAULT NULL,
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `companyName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `locked` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `invoice` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `invoice_date` datetime(0) NULL DEFAULT NULL,
  `invoice_get` datetime(0) NULL DEFAULT NULL,
  `percent` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_order
-- ----------------------------
INSERT INTO `t_order` VALUES (2, 1, '1111', '2017-08-21 21:35:15', NULL, NULL, NULL, NULL, 0.00000, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `t_order` VALUES (3, 20, 'customer_Wed Aug 23 21:39:41 CST 2017', '2017-08-23 21:39:42', NULL, NULL, NULL, NULL, 0.00000, NULL, '测试企业', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `t_order` VALUES (4, 5, 'cus_2018-06-01', '2018-06-01 22:24:38', NULL, NULL, NULL, '1', 0.00000, NULL, '333333', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `t_order` VALUES (5, 4, 'KH20180601null', '2018-06-01 23:26:48', NULL, NULL, NULL, '1', 0.00000, NULL, '4', NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for t_order_detail
-- ----------------------------
DROP TABLE IF EXISTS `t_order_detail`;
CREATE TABLE `t_order_detail`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `order_id` int(10) NULL DEFAULT NULL,
  `product_detail_id` int(10) NULL DEFAULT NULL COMMENT '产品小类ID',
  `num` int(10) NULL DEFAULT NULL COMMENT '数量',
  `price` decimal(10, 0) NULL DEFAULT NULL COMMENT '单价',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_order_detail
-- ----------------------------
INSERT INTO `t_order_detail` VALUES (1, 2, 2, 111, 0, NULL);
INSERT INTO `t_order_detail` VALUES (2, 3, 2, 100, 0, NULL);
INSERT INTO `t_order_detail` VALUES (3, 1, 7, 1000, 0, NULL);
INSERT INTO `t_order_detail` VALUES (4, 1, 2, 50, 0, NULL);
INSERT INTO `t_order_detail` VALUES (5, 4, 1, 10, NULL, NULL);
INSERT INTO `t_order_detail` VALUES (6, 5, 2, 10, NULL, NULL);

-- ----------------------------
-- Table structure for t_order_mapping
-- ----------------------------
DROP TABLE IF EXISTS `t_order_mapping`;
CREATE TABLE `t_order_mapping`  (
  `order_id` int(11) NOT NULL COMMENT '客户订单号',
  `supllier_order_id` int(11) NOT NULL COMMENT '供应商订单号',
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for t_product
-- ----------------------------
DROP TABLE IF EXISTS `t_product`;
CREATE TABLE `t_product`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) NULL DEFAULT NULL,
  `product` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '产品大类名称',
  `type` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '种类',
  `unit` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '单位',
  `base` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '基础采购量',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FKA91FC0242CA5FA05`(`parent_id`) USING BTREE,
  CONSTRAINT `FKA91FC0242CA5FA05` FOREIGN KEY (`parent_id`) REFERENCES `t_product` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_product
-- ----------------------------
INSERT INTO `t_product` VALUES (8, NULL, '焊丝', '', '公斤', NULL, NULL);
INSERT INTO `t_product` VALUES (9, NULL, '磨具', '', '片', NULL, NULL);
INSERT INTO `t_product` VALUES (10, 8, '二保焊丝', '二保焊丝', NULL, '1件（72盒）', NULL);
INSERT INTO `t_product` VALUES (11, 8, '埋弧焊丝', '埋弧焊丝', NULL, '5盘以上', NULL);
INSERT INTO `t_product` VALUES (12, 9, '百叶轮', '百叶轮', NULL, '一箱以上', NULL);
INSERT INTO `t_product` VALUES (13, 8, '药芯焊丝', '药芯焊丝', NULL, '1件', NULL);
INSERT INTO `t_product` VALUES (14, 9, '切割片机', '切割片机', NULL, '一箱以上', NULL);

-- ----------------------------
-- Table structure for t_product_detail
-- ----------------------------
DROP TABLE IF EXISTS `t_product_detail`;
CREATE TABLE `t_product_detail`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `product_id` int(10) NULL DEFAULT NULL,
  `sub_product` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '小类名称',
  `format` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '规格',
  `material` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '材质',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `selected` int(11) NOT NULL,
  `productId` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK752CA4CC19BC13A0`(`product_id`) USING BTREE,
  CONSTRAINT `FK752CA4CC19BC13A0` FOREIGN KEY (`product_id`) REFERENCES `t_product` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_product_detail
-- ----------------------------
INSERT INTO `t_product_detail` VALUES (1, 10, '1.2', '20KG/盒', 'ER50-6', NULL, 1, NULL);
INSERT INTO `t_product_detail` VALUES (2, 10, '4.0', '25kg/?', 'HO8A', NULL, 1, NULL);
INSERT INTO `t_product_detail` VALUES (3, 10, '1.2', '15kg/盒', 'HY-E711(Q)', NULL, 1, NULL);
INSERT INTO `t_product_detail` VALUES (4, 12, '60#', '300片/箱', '煅烧砂', NULL, 0, NULL);
INSERT INTO `t_product_detail` VALUES (5, 12, '80#', '300片/箱', '煅烧砂', NULL, 0, NULL);
INSERT INTO `t_product_detail` VALUES (6, 12, '100#', '300片/箱', '煅烧砂', NULL, 0, NULL);
INSERT INTO `t_product_detail` VALUES (7, 12, '120#', '300?/?', '???', NULL, 1, NULL);
INSERT INTO `t_product_detail` VALUES (8, 14, '400#', '25?/?', NULL, NULL, 1, NULL);
INSERT INTO `t_product_detail` VALUES (9, 14, '350#', '25/?', NULL, NULL, 0, NULL);

-- ----------------------------
-- Table structure for t_product_type
-- ----------------------------
DROP TABLE IF EXISTS `t_product_type`;
CREATE TABLE `t_product_type`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) NULL DEFAULT NULL,
  `type_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `unit` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `base` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `remark` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK1797FE757CEC5ADF`(`parent_id`) USING BTREE,
  CONSTRAINT `FK1797FE757CEC5ADF` FOREIGN KEY (`parent_id`) REFERENCES `t_product_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_product_type
-- ----------------------------
INSERT INTO `t_product_type` VALUES (1, NULL, '焊丝', '公斤', '', NULL);
INSERT INTO `t_product_type` VALUES (2, NULL, '磨具', '片', NULL, NULL);
INSERT INTO `t_product_type` VALUES (3, 1, '二保焊丝', NULL, '1件（72盒）', NULL);
INSERT INTO `t_product_type` VALUES (4, 1, '埋弧焊丝', NULL, '5盘以上', NULL);
INSERT INTO `t_product_type` VALUES (5, 1, '药芯焊丝', NULL, '1件', NULL);
INSERT INTO `t_product_type` VALUES (6, 2, '百叶轮', NULL, '一箱以上', NULL);
INSERT INTO `t_product_type` VALUES (7, 2, '切割机片', NULL, '一箱以上', NULL);

-- ----------------------------
-- Table structure for t_supllier_order
-- ----------------------------
DROP TABLE IF EXISTS `t_supllier_order`;
CREATE TABLE `t_supllier_order`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `supplier_order_no` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '供应商订单编号',
  `transport_date` datetime(0) NULL DEFAULT NULL COMMENT '发货时间',
  `status` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '订单状态,  2: 审核',
  `amount` decimal(10, 5) NULL DEFAULT NULL COMMENT '订单总价',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `invoice` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `invoice_date` datetime(0) NULL DEFAULT NULL,
  `invoice_get` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_supllier_order
-- ----------------------------
INSERT INTO `t_supllier_order` VALUES (1, 'S_2017-08-29 13:40:03', NULL, '0', 1261.00000, NULL, NULL, NULL, NULL);
INSERT INTO `t_supllier_order` VALUES (2, 'S_2017-08-29 13:54:23', NULL, '2', 1261.00000, NULL, NULL, NULL, NULL);
INSERT INTO `t_supllier_order` VALUES (3, 'S_2017-08-30 15:28:15', NULL, '0', 1261.00000, NULL, NULL, NULL, NULL);
INSERT INTO `t_supllier_order` VALUES (4, 'S_2017-08-30 15:29:44', NULL, '0', 1261.00000, NULL, NULL, NULL, NULL);
INSERT INTO `t_supllier_order` VALUES (5, 'S_2017-08-30 15:50:25', NULL, '2', 1261.00000, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for t_supllier_order_detail
-- ----------------------------
DROP TABLE IF EXISTS `t_supllier_order_detail`;
CREATE TABLE `t_supllier_order_detail`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `conpany_id` int(10) NULL DEFAULT NULL COMMENT '供应商ID,详情与具体供应商关联，可能出现一个商品从多家供应商采购的情况',
  `supllier_order_id` int(10) NULL DEFAULT NULL COMMENT '供应商订单ID',
  `product_detail_id` int(10) NULL DEFAULT NULL COMMENT '产品分类id',
  `num` int(10) NULL DEFAULT NULL COMMENT '订单数量',
  `initnum` int(11) NULL DEFAULT NULL,
  `price` decimal(10, 3) NULL DEFAULT NULL COMMENT '供应商报价',
  `status` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标注是否为主数据  1代表主数据不可删除，2代表拆分订单，可删除',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_supllier_order_detail
-- ----------------------------
INSERT INTO `t_supllier_order_detail` VALUES (1, 0, 1, 2, 111, NULL, 0.000, NULL, NULL);
INSERT INTO `t_supllier_order_detail` VALUES (2, NULL, 1, 2, 100, NULL, 0.000, NULL, NULL);
INSERT INTO `t_supllier_order_detail` VALUES (3, NULL, 1, 7, 1000, NULL, 0.000, NULL, NULL);
INSERT INTO `t_supllier_order_detail` VALUES (4, NULL, 1, 2, 50, NULL, 0.000, '1', NULL);
INSERT INTO `t_supllier_order_detail` VALUES (5, 15, 2, 2, 261, NULL, 0.000, '1', NULL);
INSERT INTO `t_supllier_order_detail` VALUES (6, 15, 2, 7, 1000, NULL, 0.000, '1', NULL);
INSERT INTO `t_supllier_order_detail` VALUES (7, NULL, 3, 2, 261, 261, 0.000, '1', NULL);
INSERT INTO `t_supllier_order_detail` VALUES (8, NULL, 3, 7, 1000, 1000, 0.000, '1', NULL);
INSERT INTO `t_supllier_order_detail` VALUES (9, NULL, 4, 2, 261, 261, 0.000, '1', NULL);
INSERT INTO `t_supllier_order_detail` VALUES (10, NULL, 4, 7, 1000, 1000, 0.000, '1', NULL);
INSERT INTO `t_supllier_order_detail` VALUES (11, NULL, 5, 2, 261, 261, 0.000, '1', NULL);
INSERT INTO `t_supllier_order_detail` VALUES (12, NULL, 5, 7, 1000, 1000, 0.000, '1', NULL);
INSERT INTO `t_supllier_order_detail` VALUES (13, NULL, 5, 7, NULL, NULL, 0.000, '2', NULL);

-- ----------------------------
-- Table structure for t_user
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `company_id` int(11) NULL DEFAULT NULL,
  `role_id` int(11) NULL DEFAULT NULL COMMENT '1管理员 2供应商 3客户',
  `user_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `user_pwd` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `companyName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO `t_user` VALUES (2, 5, 1, '123', '670b14728ad9902aecba32e22fa4f6bd', '333333');
INSERT INTO `t_user` VALUES (10, 5, 3, 'test', '670b14728ad9902aecba32e22fa4f6bd', '333333');
INSERT INTO `t_user` VALUES (11, 19, 2, 'abcd', '670b14728ad9902aecba32e22fa4f6bd', 'abcdefg');
INSERT INTO `t_user` VALUES (12, NULL, 1, '123', '670b14728ad9902aecba32e22fa4f6bd', NULL);
INSERT INTO `t_user` VALUES (14, NULL, 1, 'admin2', '670b14728ad9902aecba32e22fa4f6bd', NULL);
INSERT INTO `t_user` VALUES (15, NULL, 1, 'wyk', '670b14728ad9902aecba32e22fa4f6bd', NULL);
INSERT INTO `t_user` VALUES (16, 20, 2, 'wyj', '670b14728ad9902aecba32e22fa4f6bd', '测试企业');
INSERT INTO `t_user` VALUES (17, 20, 2, 'tst', '670b14728ad9902aecba32e22fa4f6bd', '测试企业');
INSERT INTO `t_user` VALUES (18, 4, 3, '321', '670b14728ad9902aecba32e22fa4f6bd', 'ceshi');

-- ----------------------------
-- Table structure for t_user_product
-- ----------------------------
DROP TABLE IF EXISTS `t_user_product`;
CREATE TABLE `t_user_product`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `company_id` int(10) NULL DEFAULT NULL COMMENT '公司id ，拟定一家公司关联一个大类',
  `product_detail_id` int(10) NULL DEFAULT NULL COMMENT '产品小类ID',
  `status` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '分类状态。隐藏/显示',
  `role_id` int(10) NULL DEFAULT NULL COMMENT '角色id， 判断是客户还是供应商',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 40 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_user_product
-- ----------------------------
INSERT INTO `t_user_product` VALUES (27, 20, 2, NULL, NULL);
INSERT INTO `t_user_product` VALUES (28, 20, 4, NULL, NULL);
INSERT INTO `t_user_product` VALUES (29, 20, 5, NULL, NULL);
INSERT INTO `t_user_product` VALUES (30, 20, 8, NULL, NULL);
INSERT INTO `t_user_product` VALUES (31, 20, 9, NULL, NULL);
INSERT INTO `t_user_product` VALUES (32, 5, 7, NULL, NULL);
INSERT INTO `t_user_product` VALUES (33, 5, 8, NULL, NULL);
INSERT INTO `t_user_product` VALUES (34, 5, 1, NULL, NULL);
INSERT INTO `t_user_product` VALUES (35, 5, 2, NULL, NULL);
INSERT INTO `t_user_product` VALUES (36, 5, 3, NULL, NULL);
INSERT INTO `t_user_product` VALUES (37, 4, 1, NULL, NULL);
INSERT INTO `t_user_product` VALUES (38, 4, 2, NULL, NULL);
INSERT INTO `t_user_product` VALUES (39, 4, 3, NULL, NULL);

SET FOREIGN_KEY_CHECKS = 1;
