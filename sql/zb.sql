/*
Navicat MySQL Data Transfer

Source Server         : lvbu
Source Server Version : 50628
Source Host           : localhost:3306
Source Database       : zb

Target Server Type    : MYSQL
Target Server Version : 50628
File Encoding         : 65001

Date: 2019-03-03 15:47:11
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `t_cos`
-- ----------------------------
DROP TABLE IF EXISTS `t_cos`;
CREATE TABLE `t_cos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `csid` int(11) DEFAULT NULL COMMENT '消费人员类型  关联  t_cosgrptype',
  `ctime` date DEFAULT NULL COMMENT '日期',
  `stime` int(11) DEFAULT NULL COMMENT '1 上午  2 下午',
  `num` int(11) DEFAULT NULL COMMENT '人数',
  `shopid` int(11) DEFAULT NULL COMMENT '关联店铺',
  `sum` double DEFAULT NULL COMMENT '总额',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_cos
-- ----------------------------
INSERT INTO `t_cos` VALUES ('5', '1', '2019-01-23', '1', '230', '1', '4322.5');
INSERT INTO `t_cos` VALUES ('6', '1', '2019-01-23', '2', '200', '1', '3040');
INSERT INTO `t_cos` VALUES ('7', '2', '2019-01-23', '1', '53', '1', '840');
INSERT INTO `t_cos` VALUES ('8', '2', '2019-01-23', '2', '67', '1', '1200');
INSERT INTO `t_cos` VALUES ('9', '3', '2019-01-23', '1', '2', '1', '58');
INSERT INTO `t_cos` VALUES ('10', '3', '2019-01-23', '2', '1', '1', '23');
INSERT INTO `t_cos` VALUES ('11', '1', '2019-01-24', '1', '232', '1', '4532');
INSERT INTO `t_cos` VALUES ('12', '1', '2019-01-24', '2', '120', '1', '4321');
INSERT INTO `t_cos` VALUES ('13', '2', '2019-01-24', '1', '43', '1', '1234');
INSERT INTO `t_cos` VALUES ('14', '2', '2019-01-24', '2', '32', '1', '1435');
INSERT INTO `t_cos` VALUES ('15', '1', '2019-01-25', '1', '125', '1', '2351');
INSERT INTO `t_cos` VALUES ('16', '1', '2019-01-25', '2', '142', '1', '3245');
INSERT INTO `t_cos` VALUES ('17', '2', '2019-01-25', '1', '32', '1', '1424');
INSERT INTO `t_cos` VALUES ('18', '2', '2019-01-25', '2', '22', '1', '3421');

-- ----------------------------
-- Table structure for `t_cosgrptype`
-- ----------------------------
DROP TABLE IF EXISTS `t_cosgrptype`;
CREATE TABLE `t_cosgrptype` (
  `cosid` int(11) NOT NULL AUTO_INCREMENT COMMENT '消费群体表',
  `costypename` varchar(20) NOT NULL COMMENT '消费群体类型名称',
  PRIMARY KEY (`cosid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_cosgrptype
-- ----------------------------
INSERT INTO `t_cosgrptype` VALUES ('1', '地勤');
INSERT INTO `t_cosgrptype` VALUES ('2', '旅客');
INSERT INTO `t_cosgrptype` VALUES ('3', '美团');

-- ----------------------------
-- Table structure for `t_detail`
-- ----------------------------
DROP TABLE IF EXISTS `t_detail`;
CREATE TABLE `t_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `shopid` int(11) DEFAULT NULL COMMENT '关联店铺',
  `typeid` int(11) DEFAULT NULL COMMENT '关联t_type_del 收支类型',
  `money` double DEFAULT NULL COMMENT '金额',
  `ctime` date DEFAULT NULL COMMENT '日期',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  `typeno` int(11) DEFAULT NULL COMMENT '关联大类型',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_detail
-- ----------------------------
INSERT INTO `t_detail` VALUES ('20', '2', '1', '90', '2019-01-25', '', '1');
INSERT INTO `t_detail` VALUES ('23', '2', '2', '600', '2019-01-25', '', '1');
INSERT INTO `t_detail` VALUES ('24', '3', '3', '900', '2019-01-25', '0', '1');
INSERT INTO `t_detail` VALUES ('25', '4', '11', '300', '2019-01-26', '停车费', '2');

-- ----------------------------
-- Table structure for `t_shop`
-- ----------------------------
DROP TABLE IF EXISTS `t_shop`;
CREATE TABLE `t_shop` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `shopname` varchar(30) DEFAULT NULL COMMENT '店名',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_shop
-- ----------------------------
INSERT INTO `t_shop` VALUES ('1', '机场店__拼哥（米线店）');
INSERT INTO `t_shop` VALUES ('2', '机场店__南湖蒸（蒸菜）\r\n');
INSERT INTO `t_shop` VALUES ('3', '和平村__南湖蒸（蒸菜）');
INSERT INTO `t_shop` VALUES ('4', '玉溪店__拼哥（米线店）');

-- ----------------------------
-- Table structure for `t_type`
-- ----------------------------
DROP TABLE IF EXISTS `t_type`;
CREATE TABLE `t_type` (
  `typeno` int(11) NOT NULL AUTO_INCREMENT COMMENT '类型编号',
  `typename` varchar(10) NOT NULL COMMENT '类型名称',
  PRIMARY KEY (`typeno`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_type
-- ----------------------------
INSERT INTO `t_type` VALUES ('1', '收入');
INSERT INTO `t_type` VALUES ('2', '支出');

-- ----------------------------
-- Table structure for `t_type_del`
-- ----------------------------
DROP TABLE IF EXISTS `t_type_del`;
CREATE TABLE `t_type_del` (
  `typeid` int(11) NOT NULL AUTO_INCREMENT,
  `typename` varchar(20) NOT NULL,
  `typeno` int(11) NOT NULL COMMENT '关联t_type ',
  PRIMARY KEY (`typeid`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_type_del
-- ----------------------------
INSERT INTO `t_type_del` VALUES ('1', '支付宝', '1');
INSERT INTO `t_type_del` VALUES ('2', '微信', '1');
INSERT INTO `t_type_del` VALUES ('3', '现金', '1');
INSERT INTO `t_type_del` VALUES ('4', '美团', '1');
INSERT INTO `t_type_del` VALUES ('5', '食材', '2');
INSERT INTO `t_type_del` VALUES ('6', '调料', '2');
INSERT INTO `t_type_del` VALUES ('7', '米线', '2');
INSERT INTO `t_type_del` VALUES ('8', '杂物', '2');
INSERT INTO `t_type_del` VALUES ('9', '其他', '2');
INSERT INTO `t_type_del` VALUES ('10', '燃料', '2');
INSERT INTO `t_type_del` VALUES ('11', '运输', '2');
INSERT INTO `t_type_del` VALUES ('12', '米油', '2');
INSERT INTO `t_type_del` VALUES ('13', '公摊', '2');

-- ----------------------------
-- Table structure for `t_user`
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user` (
  `userid` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(20) NOT NULL COMMENT '用户名',
  `password` varchar(20) DEFAULT NULL COMMENT '密码',
  PRIMARY KEY (`userid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO `t_user` VALUES ('1', 'admin', 'admin');
INSERT INTO `t_user` VALUES ('2', 'root', 'root');
