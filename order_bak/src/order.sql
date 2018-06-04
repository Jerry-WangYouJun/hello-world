/*
Navicat MySQL Data Transfer

Source Server         : 127.0.0.1
Source Server Version : 50528
Source Host           : localhost:3306
Source Database       : order

Target Server Type    : MYSQL
Target Server Version : 50528
File Encoding         : 65001

Date: 2018-06-04 14:56:14
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
  `telphone` varchar(20) DEFAULT NULL COMMENT '联系电话',
  `tax` varchar(30) DEFAULT NULL COMMENT '税号',
  `card` varchar(30) DEFAULT NULL COMMENT '银行卡号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_company
-- ----------------------------
INSERT INTO `t_company` VALUES ('19', '供应商1', '123', '123', '123', '123', '123', '2', 'gy1', null, null, null);
INSERT INTO `t_company` VALUES ('21', '客户1', '123', '12', '312', '12', '123123', '3', 'kh1', '3123', '123', '3123');
INSERT INTO `t_company` VALUES ('23', '青岛农1', '1231', '1231', '1231', '12311', '1231', '3', 'gy31', '1231', '1231', '1231');

-- ----------------------------
-- Table structure for t_confirm
-- ----------------------------
DROP TABLE IF EXISTS `t_confirm`;
CREATE TABLE `t_confirm` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `confirmDate` int(2) DEFAULT NULL,
  `remark` varchar(10) DEFAULT NULL,
  `remark2` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_confirm
-- ----------------------------
INSERT INTO `t_confirm` VALUES ('1', '5', '1', '1');

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
  `status` varchar(5) DEFAULT NULL COMMENT '订单状态 1：新订单 2已发布 3已付款 4确认收货',
  `amount` decimal(10,5) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `companyName` varchar(255) DEFAULT NULL,
  `locked` varchar(255) DEFAULT NULL,
  `invoice` varchar(255) DEFAULT NULL,
  `invoice_date` datetime DEFAULT NULL,
  `invoice_get` datetime DEFAULT NULL,
  `percent` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_order
-- ----------------------------
INSERT INTO `t_order` VALUES ('4', '21', 'cus_2018-04-11', '2018-04-11 11:51:56', null, null, '2018-05-31 17:00:59', '1', '0.00000', null, '客户1', null, null, null, null, null);
INSERT INTO `t_order` VALUES ('5', '21', 'cus_2018-04-11', '2018-04-11 12:10:51', null, null, null, '1', '0.00000', null, '客户1', null, null, null, null, null);
INSERT INTO `t_order` VALUES ('6', '21', 'cus_2018-05-28', '2018-05-28 16:10:05', null, null, null, '1', '0.00000', null, '客户1', null, null, null, null, null);
INSERT INTO `t_order` VALUES ('7', '21', 'KH20180531009', '2018-05-28 16:23:40', null, null, null, '1', '0.00000', null, '客户1', null, null, null, null, null);
INSERT INTO `t_order` VALUES ('8', '21', 'KH20180531001', '2018-05-31 10:30:49', null, null, null, '1', '0.00000', null, '客户1', null, null, null, null, null);
INSERT INTO `t_order` VALUES ('9', '21', 'KH20180531010', '2018-05-31 11:45:12', null, null, null, '1', '0.00000', null, '客户1', null, null, null, null, null);
INSERT INTO `t_order` VALUES ('10', '21', 'KH20180531010', '2018-05-31 11:45:40', null, null, null, '3', '0.00000', null, '客户1', null, null, null, null, null);
INSERT INTO `t_order` VALUES ('11', '21', 'KH20180531011', '2018-05-31 11:46:18', null, null, null, '1', '0.00000', null, '客户1', null, null, null, null, null);
INSERT INTO `t_order` VALUES ('12', '21', 'KH20180531012', '2018-05-31 11:46:30', null, null, null, '1', '0.00000', null, '客户1', null, null, null, null, null);
INSERT INTO `t_order` VALUES ('13', '21', 'KH20180531013', '2018-05-31 15:34:34', null, null, null, '1', '0.00000', null, '客户1', null, null, null, null, null);

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
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_order_detail
-- ----------------------------
INSERT INTO `t_order_detail` VALUES ('1', '2', '2', '111', '0', null);
INSERT INTO `t_order_detail` VALUES ('2', '3', '2', '100', '0', null);
INSERT INTO `t_order_detail` VALUES ('3', '1', '7', '1000', '0', null);
INSERT INTO `t_order_detail` VALUES ('4', '1', '2', '50', '0', null);
INSERT INTO `t_order_detail` VALUES ('5', '4', '2', '1000', null, null);
INSERT INTO `t_order_detail` VALUES ('6', '4', '6', '500', null, null);
INSERT INTO `t_order_detail` VALUES ('7', '5', '2', '600', '25', null);
INSERT INTO `t_order_detail` VALUES ('8', '6', '2', '100', null, null);
INSERT INTO `t_order_detail` VALUES ('9', '7', '6', '111', null, null);
INSERT INTO `t_order_detail` VALUES ('10', '8', '6', '100', null, null);
INSERT INTO `t_order_detail` VALUES ('11', '8', '2', '200', null, null);
INSERT INTO `t_order_detail` VALUES ('12', '9', '2', '111', null, null);
INSERT INTO `t_order_detail` VALUES ('13', '9', '2', '0', null, null);
INSERT INTO `t_order_detail` VALUES ('14', '10', '6', '111', null, null);
INSERT INTO `t_order_detail` VALUES ('15', '11', '2', '111', null, null);
INSERT INTO `t_order_detail` VALUES ('16', '12', '6', '1123', null, null);
INSERT INTO `t_order_detail` VALUES ('17', '13', '2', '11', null, null);

-- ----------------------------
-- Table structure for t_order_mapping
-- ----------------------------
DROP TABLE IF EXISTS `t_order_mapping`;
CREATE TABLE `t_order_mapping` (
  `order_id` int(11) NOT NULL COMMENT '客户订单号',
  `supllier_order_id` int(11) NOT NULL COMMENT '供应商订单号',
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=570 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_order_mapping
-- ----------------------------
INSERT INTO `t_order_mapping` VALUES ('4', '1', '568');
INSERT INTO `t_order_mapping` VALUES ('5', '1', '569');

-- ----------------------------
-- Table structure for t_product
-- ----------------------------
DROP TABLE IF EXISTS `t_product`;
CREATE TABLE `t_product` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) DEFAULT NULL,
  `product` varchar(50) DEFAULT NULL COMMENT '产品大类名称',
  `type` varchar(50) DEFAULT NULL COMMENT '种类',
  `unit` varchar(10) DEFAULT NULL COMMENT '单位',
  `base` varchar(10) DEFAULT NULL COMMENT '基础采购量',
  `remark` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FKA91FC0242CA5FA05` (`parent_id`) USING BTREE,
  CONSTRAINT `FKA91FC0242CA5FA05` FOREIGN KEY (`parent_id`) REFERENCES `t_product` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of t_product
-- ----------------------------
INSERT INTO `t_product` VALUES ('8', null, '焊丝', '', '公斤', null, null);
INSERT INTO `t_product` VALUES ('9', null, '磨具', '', '片', null, null);
INSERT INTO `t_product` VALUES ('10', '8', '二保焊丝', '二保焊丝', null, '1件（72盒）', null);
INSERT INTO `t_product` VALUES ('11', '8', '埋弧焊丝', '埋弧焊丝', null, '5盘以上', null);
INSERT INTO `t_product` VALUES ('12', '9', '百叶轮', '百叶轮', null, '一箱以上', null);
INSERT INTO `t_product` VALUES ('13', '8', '药芯焊丝', '药芯焊丝', null, '1件', null);
INSERT INTO `t_product` VALUES ('14', '9', '切割片机', '切割片机', null, '一箱以上', null);

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
  `productId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK752CA4CC19BC13A0` (`product_id`) USING BTREE,
  CONSTRAINT `FK752CA4CC19BC13A0` FOREIGN KEY (`product_id`) REFERENCES `t_product` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of t_product_detail
-- ----------------------------
INSERT INTO `t_product_detail` VALUES ('1', '10', '1.2', '20KG/盒', 'ER50-6', null, '1', null);
INSERT INTO `t_product_detail` VALUES ('2', '10', '4.0', '25kg/盒', 'HO8A', null, '1', null);
INSERT INTO `t_product_detail` VALUES ('3', '10', '1.2', '15kg/盒', 'HY-E711(Q)', null, '1', null);
INSERT INTO `t_product_detail` VALUES ('4', '12', '60#', '300片/箱', '煅烧砂', null, '0', null);
INSERT INTO `t_product_detail` VALUES ('5', '12', '80#', '300片/箱', '煅烧砂', null, '0', null);
INSERT INTO `t_product_detail` VALUES ('6', '12', '100#', '300片/箱', '煅烧砂', null, '0', null);
INSERT INTO `t_product_detail` VALUES ('7', '12', '120#', '300?/?', '???', null, '0', null);
INSERT INTO `t_product_detail` VALUES ('8', '14', '400#', '25?/?', null, null, '0', null);
INSERT INTO `t_product_detail` VALUES ('9', '14', '350#', '25/?', null, null, '0', null);

-- ----------------------------
-- Table structure for t_product_type
-- ----------------------------
DROP TABLE IF EXISTS `t_product_type`;
CREATE TABLE `t_product_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) DEFAULT NULL,
  `type_name` varchar(50) DEFAULT NULL,
  `unit` varchar(50) DEFAULT NULL,
  `base` varchar(50) DEFAULT NULL,
  `remark` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK1797FE757CEC5ADF` (`parent_id`) USING BTREE,
  CONSTRAINT `FK1797FE757CEC5ADF` FOREIGN KEY (`parent_id`) REFERENCES `t_product_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of t_product_type
-- ----------------------------

-- ----------------------------
-- Table structure for t_supllier_order
-- ----------------------------
DROP TABLE IF EXISTS `t_supllier_order`;
CREATE TABLE `t_supllier_order` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `supplier_order_no` varchar(30) DEFAULT NULL COMMENT '供应商订单编号',
  `transport_date` datetime DEFAULT NULL COMMENT '发货时间',
  `status` varchar(5) DEFAULT NULL COMMENT '订单状态, 1新订单 2: 审核  3已付款 4已收货',
  `amount` decimal(10,5) DEFAULT NULL COMMENT '订单总价',
  `remark` varchar(255) DEFAULT NULL,
  `invoice` varchar(255) DEFAULT NULL,
  `invoice_date` datetime DEFAULT NULL,
  `invoice_get` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_supllier_order
-- ----------------------------
INSERT INTO `t_supllier_order` VALUES ('1', 'S_2018-04-11 14:38:31', null, '4', '2100.00000', null, null, null, null);
INSERT INTO `t_supllier_order` VALUES ('2', 'GHT2018-06-01 15:52:05', null, '4', '0.00000', null, null, null, null);

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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_supllier_order_detail
-- ----------------------------
INSERT INTO `t_supllier_order_detail` VALUES ('1', '19', '2', '2', '1000', '1000', '10.000', '1', null);
INSERT INTO `t_supllier_order_detail` VALUES ('2', '19', '2', '6', '500', '500', '20.000', '1', null);
INSERT INTO `t_supllier_order_detail` VALUES ('7', null, '5', '2', '1600', '1600', '0.000', '1', null);
INSERT INTO `t_supllier_order_detail` VALUES ('8', null, '5', '6', '500', '500', '0.000', '1', null);
INSERT INTO `t_supllier_order_detail` VALUES ('9', '19', '1', '2', '600', '1600', '20.000', '1', null);
INSERT INTO `t_supllier_order_detail` VALUES ('10', '19', '1', '6', '500', '500', '10.000', '1', null);
INSERT INTO `t_supllier_order_detail` VALUES ('11', '22', '1', '2', '1000', null, '35.000', '2', null);

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
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO `t_user` VALUES ('14', null, '1', 'admin', '670b14728ad9902aecba32e22fa4f6bd', null);
INSERT INTO `t_user` VALUES ('19', '19', '2', 'gy1', '670b14728ad9902aecba32e22fa4f6bd', '供应商1');
INSERT INTO `t_user` VALUES ('21', '21', '3', 'kh1', '670b14728ad9902aecba32e22fa4f6bd', '客户1');
INSERT INTO `t_user` VALUES ('22', '22', '2', 'gy2', '670b14728ad9902aecba32e22fa4f6bd', '供应商2');
INSERT INTO `t_user` VALUES ('24', '23', '3', 'gy31', '670b14728ad9902aecba32e22fa4f6bd', '青岛农1');
INSERT INTO `t_user` VALUES ('25', '23', '3', 'gy3', '670b14728ad9902aecba32e22fa4f6bd', '青岛农1');
INSERT INTO `t_user` VALUES ('27', '21', '2', 'kh1', '670b14728ad9902aecba32e22fa4f6bd', '客户1');
INSERT INTO `t_user` VALUES ('30', '22', '2', 'gy344', '670b14728ad9902aecba32e22fa4f6bd', '供应商2');

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
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8;

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
INSERT INTO `t_user_product` VALUES ('32', '19', '2', null, null);
INSERT INTO `t_user_product` VALUES ('33', '19', '4', null, null);
INSERT INTO `t_user_product` VALUES ('34', '19', '5', null, null);
INSERT INTO `t_user_product` VALUES ('35', '19', '8', null, null);
INSERT INTO `t_user_product` VALUES ('36', '19', '9', null, null);
INSERT INTO `t_user_product` VALUES ('37', '19', '7', null, null);
INSERT INTO `t_user_product` VALUES ('38', '19', '6', null, null);
INSERT INTO `t_user_product` VALUES ('61', '21', '1', null, null);
INSERT INTO `t_user_product` VALUES ('62', '21', '2', null, null);
INSERT INTO `t_user_product` VALUES ('63', '21', '3', null, null);
