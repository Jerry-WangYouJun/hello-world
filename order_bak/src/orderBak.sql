/*
Navicat MySQL Data Transfer

Source Server         : 127.0.0.1
Source Server Version : 50528
Source Host           : localhost:3306
Source Database       : order

Target Server Type    : MYSQL
Target Server Version : 50528
File Encoding         : 65001

Date: 2017-08-30 17:17:00
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for t_company
-- ----------------------------
DROP TABLE IF EXISTS `t_company`;
CREATE TABLE `t_company` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) DEFAULT NULL COMMENT '公司名称',
  `contacts` varchar(20) DEFAULT NULL COMMENT '联系人',
  `address` varchar(100) DEFAULT NULL COMMENT '联系地址',
  `business` varchar(100) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '主营业务',
  `level` varchar(10) DEFAULT NULL COMMENT '企业星级',
  `remark` varchar(255) DEFAULT NULL,
  `roleId` int(11) DEFAULT NULL,
  `userName` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_company
-- ----------------------------
INSERT INTO `t_company` VALUES ('1', null, null, null, null, null, null, null, null);
INSERT INTO `t_company` VALUES ('2', null, null, null, null, null, null, null, null);
INSERT INTO `t_company` VALUES ('4', '4', '4', '4', '4', '4', '4', null, null);
INSERT INTO `t_company` VALUES ('5', '333333', '6', '7', '1', '1', '1', '1', '123');
INSERT INTO `t_company` VALUES ('14', '1', '1', '1', '1', '1', '1', null, null);
INSERT INTO `t_company` VALUES ('15', 'awef', '123', '1', '1', '1', '1', '3', 'test');
INSERT INTO `t_company` VALUES ('17', '34q3r', '123', '1', '1', '1', '1', null, null);
INSERT INTO `t_company` VALUES ('18', '132', '123', '123', '123', '123', '123', null, null);
INSERT INTO `t_company` VALUES ('19', 'abcdefg', '123', '123', '123', '123', '123', '2', 'abcd');
INSERT INTO `t_company` VALUES ('20', '测试企业', '', '', '', '', '', '2', 'wyj');

-- ----------------------------
-- Table structure for t_order
-- ----------------------------
DROP TABLE IF EXISTS `t_order`;
CREATE TABLE `t_order` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `company_id` int(10) DEFAULT NULL COMMENT '公司id',
  `order_no` varchar(50) DEFAULT NULL COMMENT '订单编号',
  `start_date` datetime DEFAULT NULL COMMENT '下单时间',
  `confirm_date` datetime DEFAULT NULL COMMENT '订单确认时间，管理员确认订单',
  `pill_date` datetime DEFAULT NULL COMMENT '付款时间',
  `end_date` datetime DEFAULT NULL COMMENT '结束时间',
  `status` varchar(5) DEFAULT NULL COMMENT '订单状态',
  `amount` decimal(10,5) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_order
-- ----------------------------
INSERT INTO `t_order` VALUES ('2', '1', '1111', '2017-08-21 21:35:15', null, null, null, null, '0.00000', null);
INSERT INTO `t_order` VALUES ('3', '20', 'customer_Wed Aug 23 21:39:41 CST 2017', '2017-08-23 21:39:42', null, null, null, null, '0.00000', null);

-- ----------------------------
-- Table structure for t_order_detail
-- ----------------------------
DROP TABLE IF EXISTS `t_order_detail`;
CREATE TABLE `t_order_detail` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `order_id` int(10) DEFAULT NULL,
  `product_detail_id` int(10) DEFAULT NULL COMMENT '产品小类ID',
  `num` int(10) DEFAULT NULL COMMENT '数量',
  `price` decimal(10,0) DEFAULT NULL COMMENT '单价',
  `remark` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_order_detail
-- ----------------------------
INSERT INTO `t_order_detail` VALUES ('1', '2', '2', '111', '0', null);
INSERT INTO `t_order_detail` VALUES ('2', '3', '2', '100', '0', null);
INSERT INTO `t_order_detail` VALUES ('3', '1', '7', '1000', '0', null);
INSERT INTO `t_order_detail` VALUES ('4', '1', '2', '50', '0', null);

-- ----------------------------
-- Table structure for t_order_mapping
-- ----------------------------
DROP TABLE IF EXISTS `t_order_mapping`;
CREATE TABLE `t_order_mapping` (
  `order_id` int(11) NOT NULL COMMENT '客户订单号',
  `supllier_order_id` int(11) NOT NULL COMMENT '供应商订单号',
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_order_mapping
-- ----------------------------

-- ----------------------------
-- Table structure for t_product
-- ----------------------------
DROP TABLE IF EXISTS `t_product`;
CREATE TABLE `t_product` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `product` varchar(50) NOT NULL COMMENT '产品大类名称',
  `type` varchar(50) DEFAULT NULL COMMENT '种类',
  `unit` varchar(10) DEFAULT NULL COMMENT '单位',
  `base` varchar(10) DEFAULT NULL COMMENT '基础采购量',
  `remark` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_product
-- ----------------------------
INSERT INTO `t_product` VALUES ('1', '焊丝', '二保焊丝', '公斤', '1件(72盒)', null);
INSERT INTO `t_product` VALUES ('2', '焊丝', '埋弧焊丝', '公斤', '5盘以上', null);
INSERT INTO `t_product` VALUES ('3', '焊丝', '药芯焊丝', '公斤', '1件', null);
INSERT INTO `t_product` VALUES ('6', '磨具', '百叶轮', '片', '一箱以上', null);
INSERT INTO `t_product` VALUES ('7', '磨具', '切割机片', '片', '一箱以上', null);

-- ----------------------------
-- Table structure for t_product_detail
-- ----------------------------
DROP TABLE IF EXISTS `t_product_detail`;
CREATE TABLE `t_product_detail` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `product_id` int(10) DEFAULT NULL,
  `sub_product` varchar(50) DEFAULT NULL COMMENT '小类名称',
  `format` varchar(50) DEFAULT NULL COMMENT '规格',
  `material` varchar(20) DEFAULT NULL COMMENT '材质',
  `remark` varchar(255) DEFAULT NULL,
  `selected` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_product_detail
-- ----------------------------
INSERT INTO `t_product_detail` VALUES ('1', '1', '1.2', '20KG/盒', 'ER50-6', null, '0');
INSERT INTO `t_product_detail` VALUES ('2', '1', '4.0', '25kg/?', 'HO8A', null, '1');
INSERT INTO `t_product_detail` VALUES ('3', '1', '1.2', '15kg/盒', 'HY-E711(Q)', null, '0');
INSERT INTO `t_product_detail` VALUES ('4', '6', '60#', '300片/箱', '煅烧砂', null, '1');
INSERT INTO `t_product_detail` VALUES ('5', '6', '80#', '300片/箱', '煅烧砂', null, '1');
INSERT INTO `t_product_detail` VALUES ('6', '6', '100#', '300片/箱', '煅烧砂', null, '0');
INSERT INTO `t_product_detail` VALUES ('7', '6', '120#', '300?/?', '???', null, '0');
INSERT INTO `t_product_detail` VALUES ('8', '7', '400#', '25?/?', null, null, '1');
INSERT INTO `t_product_detail` VALUES ('9', '7', '350#', '25/?', null, null, '1');

-- ----------------------------
-- Table structure for t_supllier_order
-- ----------------------------
DROP TABLE IF EXISTS `t_supllier_order`;
CREATE TABLE `t_supllier_order` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `supplier_order_no` varchar(30) DEFAULT NULL COMMENT '供应商订单编号',
  `transport_date` datetime DEFAULT NULL COMMENT '发货时间',
  `status` varchar(5) DEFAULT NULL COMMENT '订单状态,  2: 审核',
  `amount` decimal(10,5) DEFAULT NULL COMMENT '订单总价',
  `remark` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_supllier_order
-- ----------------------------
INSERT INTO `t_supllier_order` VALUES ('1', 'S_2017-08-29 13:40:03', null, '0', '1261.00000', null);
INSERT INTO `t_supllier_order` VALUES ('2', 'S_2017-08-29 13:54:23', null, '2', '1261.00000', null);
INSERT INTO `t_supllier_order` VALUES ('3', 'S_2017-08-30 15:28:15', null, '0', '1261.00000', null);
INSERT INTO `t_supllier_order` VALUES ('4', 'S_2017-08-30 15:29:44', null, '0', '1261.00000', null);
INSERT INTO `t_supllier_order` VALUES ('5', 'S_2017-08-30 15:50:25', null, '2', '1261.00000', null);

-- ----------------------------
-- Table structure for t_supllier_order_detail
-- ----------------------------
DROP TABLE IF EXISTS `t_supllier_order_detail`;
CREATE TABLE `t_supllier_order_detail` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `conpany_id` int(10) DEFAULT NULL COMMENT '供应商ID,详情与具体供应商关联，可能出现一个商品从多家供应商采购的情况',
  `supllier_order_id` int(10) DEFAULT NULL COMMENT '供应商订单ID',
  `product_detail_id` int(10) DEFAULT NULL COMMENT '产品分类id',
  `num` int(10) DEFAULT NULL COMMENT '订单数量',
  `initnum` int(11) DEFAULT NULL,
  `price` decimal(10,3) DEFAULT NULL COMMENT '供应商报价',
  `status` varchar(1) DEFAULT NULL COMMENT '标注是否为主数据  1代表主数据不可删除，2代表拆分订单，可删除',
  `remark` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_supllier_order_detail
-- ----------------------------
INSERT INTO `t_supllier_order_detail` VALUES ('1', '0', '1', '2', '111', null, '0.000', null, null);
INSERT INTO `t_supllier_order_detail` VALUES ('2', null, '1', '2', '100', null, '0.000', null, null);
INSERT INTO `t_supllier_order_detail` VALUES ('3', null, '1', '7', '1000', null, '0.000', null, null);
INSERT INTO `t_supllier_order_detail` VALUES ('4', null, '1', '2', '50', null, '0.000', '1', null);
INSERT INTO `t_supllier_order_detail` VALUES ('5', '15', '2', '2', '261', null, '0.000', '1', null);
INSERT INTO `t_supllier_order_detail` VALUES ('6', '15', '2', '7', '1000', null, '0.000', '1', null);
INSERT INTO `t_supllier_order_detail` VALUES ('7', null, '3', '2', '261', '261', '0.000', '1', null);
INSERT INTO `t_supllier_order_detail` VALUES ('8', null, '3', '7', '1000', '1000', '0.000', '1', null);
INSERT INTO `t_supllier_order_detail` VALUES ('9', null, '4', '2', '261', '261', '0.000', '1', null);
INSERT INTO `t_supllier_order_detail` VALUES ('10', null, '4', '7', '1000', '1000', '0.000', '1', null);
INSERT INTO `t_supllier_order_detail` VALUES ('11', null, '5', '2', '261', '261', '0.000', '1', null);
INSERT INTO `t_supllier_order_detail` VALUES ('12', null, '5', '7', '1000', '1000', '0.000', '1', null);
INSERT INTO `t_supllier_order_detail` VALUES ('13', null, '5', '7', null, null, '0.000', '2', null);

-- ----------------------------
-- Table structure for t_user
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `company_id` int(11) DEFAULT NULL,
  `role_id` int(11) DEFAULT NULL COMMENT '1管理员 2供应商 3客户',
  `user_name` varchar(30) DEFAULT NULL,
  `user_pwd` varchar(50) DEFAULT NULL,
  `companyName` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO `t_user` VALUES ('2', '5', '1', '123', '670b14728ad9902aecba32e22fa4f6bd', '333333');
INSERT INTO `t_user` VALUES ('10', '5', '3', 'test', '670b14728ad9902aecba32e22fa4f6bd', '333333');
INSERT INTO `t_user` VALUES ('11', '19', '2', 'abcd', '670b14728ad9902aecba32e22fa4f6bd', 'abcdefg');
INSERT INTO `t_user` VALUES ('12', null, '1', '123', '670b14728ad9902aecba32e22fa4f6bd', null);
INSERT INTO `t_user` VALUES ('14', null, '1', 'admin2', '670b14728ad9902aecba32e22fa4f6bd', null);
INSERT INTO `t_user` VALUES ('15', null, '1', 'wyk', '670b14728ad9902aecba32e22fa4f6bd', null);
INSERT INTO `t_user` VALUES ('16', '20', '2', 'wyj', '670b14728ad9902aecba32e22fa4f6bd', '测试企业');
INSERT INTO `t_user` VALUES ('17', '20', '2', 'tst', '670b14728ad9902aecba32e22fa4f6bd', '测试企业');

-- ----------------------------
-- Table structure for t_user_product
-- ----------------------------
DROP TABLE IF EXISTS `t_user_product`;
CREATE TABLE `t_user_product` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `company_id` int(10) DEFAULT NULL COMMENT '公司id ，拟定一家公司关联一个大类',
  `product_detail_id` int(10) DEFAULT NULL COMMENT '产品小类ID',
  `status` varchar(10) DEFAULT NULL COMMENT '分类状态。隐藏/显示',
  `role_id` int(10) DEFAULT NULL COMMENT '角色id， 判断是客户还是供应商',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_user_product
-- ----------------------------
INSERT INTO `t_user_product` VALUES ('18', '5', '2', null, null);
INSERT INTO `t_user_product` VALUES ('19', '5', '7', null, null);
INSERT INTO `t_user_product` VALUES ('20', '5', '8', null, null);
INSERT INTO `t_user_product` VALUES ('27', '20', '2', null, null);
INSERT INTO `t_user_product` VALUES ('28', '20', '4', null, null);
INSERT INTO `t_user_product` VALUES ('29', '20', '5', null, null);
INSERT INTO `t_user_product` VALUES ('30', '20', '8', null, null);
INSERT INTO `t_user_product` VALUES ('31', '20', '9', null, null);
