/*
Navicat MySQL Data Transfer

Source Server         : 127.0.0.1
Source Server Version : 50726
Source Host           : 127.0.0.1:3306
Source Database       : blog_db

Target Server Type    : MYSQL
Target Server Version : 50726
File Encoding         : 65001

Date: 2019-12-10 14:18:33
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `article`
-- ----------------------------
DROP TABLE IF EXISTS `article`;
CREATE TABLE `article` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '文章id',
  `original` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否原创，1：是，0：否',
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `avatar` varchar(255) DEFAULT NULL COMMENT '作者头像，原创时为当前用户头像，转载时为空',
  `category_name` varchar(50) NOT NULL COMMENT '分类名称-冗余字段',
  `category_id` int(11) NOT NULL COMMENT '文章分类id',
  `title` varchar(100) NOT NULL COMMENT '文章标题',
  `summary` longtext NOT NULL COMMENT '文章摘要',
  `content` longtext NOT NULL COMMENT '文章内容',
  `cover` varchar(255) NOT NULL COMMENT '文章封面',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '文章状态：0为正常，1为待发布，2为回收站',
  `view_count` int(11) NOT NULL DEFAULT '0' COMMENT '文章浏览次数',
  `comment_count` int(11) NOT NULL DEFAULT '0' COMMENT '评论数-冗余字段',
  `like_count` int(11) NOT NULL DEFAULT '0' COMMENT '点赞数-冗余字段',
  `collect_count` int(11) NOT NULL DEFAULT '0' COMMENT '收藏数',
  `publish_time` datetime NOT NULL COMMENT '发布时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `reproduce` varchar(1) DEFAULT NULL COMMENT '转载地址',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '已删除，1：是，0否',
  PRIMARY KEY (`id`),
  KEY `index_user_id` (`user_id`) USING BTREE,
  KEY `index_title` (`title`),
  KEY `index_publish_time` (`publish_time`) USING BTREE,
  KEY `index_category_id` (`category_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='文章表';

-- ----------------------------
-- Records of article
-- ----------------------------

-- ----------------------------
-- Table structure for `article_collect`
-- ----------------------------
DROP TABLE IF EXISTS `article_collect`;
CREATE TABLE `article_collect` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `article_id` int(11) NOT NULL COMMENT '文章id',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_index` (`user_id`,`article_id`) USING BTREE,
  KEY `index_article_id` (`article_id`) USING BTREE,
  KEY `index_user_id` (`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='文章收藏表';

-- ----------------------------
-- Records of article_collect
-- ----------------------------

-- ----------------------------
-- Table structure for `article_comment`
-- ----------------------------
DROP TABLE IF EXISTS `article_comment`;
CREATE TABLE `article_comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `article_id` int(11) NOT NULL COMMENT '文章id',
  `from_user_id` int(11) NOT NULL COMMENT '评论者id',
  `content` varchar(255) NOT NULL COMMENT '评论内容',
  `comment_time` datetime NOT NULL COMMENT '评论时间',
  `deleted` tinyint(1) DEFAULT '0' COMMENT '是否已删除，1：是，0：否',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='文章评论表';

-- ----------------------------
-- Records of article_comment
-- ----------------------------

-- ----------------------------
-- Table structure for `article_like`
-- ----------------------------
DROP TABLE IF EXISTS `article_like`;
CREATE TABLE `article_like` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `article_id` int(11) NOT NULL COMMENT '文章id',
  `user_id` int(11) NOT NULL COMMENT '用户id',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_index` (`article_id`,`user_id`),
  KEY `index_article_id` (`article_id`) USING BTREE,
  KEY `index_user_id` (`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='文章点赞表';

-- ----------------------------
-- Records of article_like
-- ----------------------------

-- ----------------------------
-- Table structure for `article_reply`
-- ----------------------------
DROP TABLE IF EXISTS `article_reply`;
CREATE TABLE `article_reply` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `article_id` int(11) NOT NULL COMMENT '文章id',
  `comment_id` int(11) NOT NULL COMMENT '评论id',
  `from_user_id` int(11) NOT NULL COMMENT '评论者id',
  `to_user_id` int(11) NOT NULL COMMENT '被评论者id',
  `content` varchar(255) NOT NULL COMMENT '回复内容',
  `reply_time` datetime NOT NULL COMMENT '回复时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否已删除，1:是，0:否',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='文章回复表';

-- ----------------------------
-- Records of article_reply
-- ----------------------------

-- ----------------------------
-- Table structure for `article_tag`
-- ----------------------------
DROP TABLE IF EXISTS `article_tag`;
CREATE TABLE `article_tag` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `article_id` int(11) NOT NULL COMMENT '文章id',
  `tag_id` int(11) NOT NULL COMMENT '标签id',
  PRIMARY KEY (`id`),
  KEY `index_article_id` (`article_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='文章-标签 关联表';

-- ----------------------------
-- Records of article_tag
-- ----------------------------

-- ----------------------------
-- Table structure for `category`
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(50) NOT NULL COMMENT '名称',
  `parent_id` int(11) DEFAULT '0' COMMENT '父类id',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '已删除，1：是，0：否',
  PRIMARY KEY (`id`),
  KEY `index_parent_id` (`parent_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='目录分类表';

-- ----------------------------
-- Records of category
-- ----------------------------

-- ----------------------------
-- Table structure for `client`
-- ----------------------------
DROP TABLE IF EXISTS `client`;
CREATE TABLE `client` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `client_id` varchar(50) NOT NULL COMMENT '客户端id，客户端唯一标识',
  `client_secret` varchar(255) NOT NULL COMMENT '客户端密码',
  `access_token_expire` bigint(20) DEFAULT NULL COMMENT 'access_token有效时长',
  `refresh_token_expire` bigint(20) DEFAULT NULL COMMENT 'refresh_token_expire有效时长',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_client_id` (`client_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='客户端表';

-- ----------------------------
-- Records of client
-- ----------------------------
INSERT INTO `client` VALUES ('1', 'pc', '123456', '7200', '2592000');

-- ----------------------------
-- Table structure for `friend_link`
-- ----------------------------
DROP TABLE IF EXISTS `friend_link`;
CREATE TABLE `friend_link` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(50) DEFAULT NULL COMMENT '名称',
  `url` varchar(255) DEFAULT NULL COMMENT '链接',
  `icon` varchar(255) DEFAULT NULL COMMENT '图标',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='友链表';

-- ----------------------------
-- Records of friend_link
-- ----------------------------

-- ----------------------------
-- Table structure for `leave_message`
-- ----------------------------
DROP TABLE IF EXISTS `leave_message`;
CREATE TABLE `leave_message` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `pid` int(11) DEFAULT NULL COMMENT '父id',
  `from_user_id` int(11) NOT NULL COMMENT '留言者id',
  `to_user_id` int(11) DEFAULT NULL,
  `content` varchar(255) NOT NULL COMMENT '内容',
  `create_time` datetime NOT NULL COMMENT '时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除，1：是，0：否',
  PRIMARY KEY (`id`),
  KEY `index_pid` (`pid`) USING BTREE,
  KEY `index_from_user` (`from_user_id`) USING BTREE,
  KEY `index_to_user` (`to_user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='留言表';

-- ----------------------------
-- Records of leave_message
-- ----------------------------

-- ----------------------------
-- Table structure for `tag`
-- ----------------------------
DROP TABLE IF EXISTS `tag`;
CREATE TABLE `tag` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(30) NOT NULL COMMENT '标签名',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '已删除,1:是，0否',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='标签表';

-- ----------------------------
-- Records of tag
-- ----------------------------

-- ----------------------------
-- Table structure for `user`
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户id',
  `username` varchar(20) NOT NULL COMMENT '用户名',
  `password` varchar(255) NOT NULL COMMENT '密码',
  `mobile` bigint(11) NOT NULL COMMENT '手机号',
  `nickname` varchar(50) NOT NULL COMMENT '昵称',
  `gender` tinyint(1) NOT NULL DEFAULT '1' COMMENT '性别，1：男，0：女，默认为1',
  `birthday` date DEFAULT NULL COMMENT '生日',
  `email` varchar(254) DEFAULT NULL COMMENT '电子邮箱',
  `brief` varchar(255) DEFAULT NULL COMMENT '简介|个性签名',
  `avatar` varchar(255) DEFAULT NULL COMMENT '用户头像',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态，0：正常，1：锁定，2：禁用，3：过期',
  `admin` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否管理员，1：是，0：否',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `index_username` (`username`) USING BTREE,
  KEY `index` (`mobile`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COMMENT='用户表';

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', 'admin', '$2a$10$55zCoSkaWI2IBZ6CGOcHEe9FFhtmuelHSYdp1k60DorKIKXhpPpvi', '15625295093', '小管家', '0', '2019-07-08', '726856005@qq.com', '简23介', 'https://poile-img.nos-eastchina1.126.net/me.png', '0', '1', '2019-10-23 16:29:49');
