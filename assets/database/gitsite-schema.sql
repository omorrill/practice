-- MySQL dump 10.13  Distrib 5.1.66, for Win32 (ia32)
--
-- Host: localhost    Database: d7
-- ------------------------------------------------------
-- Server version	5.1.66-community

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `actions`
--

DROP TABLE IF EXISTS `actions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `actions` (
  `aid` varchar(255) NOT NULL DEFAULT '0' COMMENT 'Primary Key: Unique actions ID.',
  `type` varchar(32) NOT NULL DEFAULT '' COMMENT 'The object that that action acts on (node, user, comment, system or custom types.)',
  `callback` varchar(255) NOT NULL DEFAULT '' COMMENT 'The callback function that executes when the action runs.',
  `parameters` longblob NOT NULL COMMENT 'Parameters to be passed to the callback function.',
  `label` varchar(255) NOT NULL DEFAULT '0' COMMENT 'Label of the action.',
  PRIMARY KEY (`aid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores action information.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `advancedqueue`
--

DROP TABLE IF EXISTS `advancedqueue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `advancedqueue` (
  `item_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique item ID.',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The queue name.',
  `uid` int(10) unsigned NOT NULL COMMENT 'The user to which the item belongs.',
  `title` varchar(400) NOT NULL COMMENT 'The title of this item.',
  `data` longblob COMMENT 'The arbitrary data for the item.',
  `result` longblob COMMENT 'The arbitrary result for the item, only significant if advancedqueue.status <> 0',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'Timestamp when the claim lease expires on the item.',
  `status` tinyint(4) NOT NULL DEFAULT '-1' COMMENT 'Indicates whether the item has been processed (-1 = queue, 0 = processing, 1 = successfully processed, 2 = failed).',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'Timestamp when the item was created.',
  `processed` int(11) NOT NULL DEFAULT '0' COMMENT 'Timestamp when the item was processed.',
  PRIMARY KEY (`item_id`),
  KEY `queue` (`name`,`status`,`expire`,`created`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8 COMMENT='Stores items in queues.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `advancedqueue_tags`
--

DROP TABLE IF EXISTS `advancedqueue_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `advancedqueue_tags` (
  `item_id` int(10) unsigned NOT NULL COMMENT 'A advancedqueue.item_id',
  `tag` varchar(255) NOT NULL DEFAULT '' COMMENT 'The queue name.',
  PRIMARY KEY (`item_id`,`tag`),
  KEY `tag` (`tag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores tags of items in queues.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `authmap`
--

DROP TABLE IF EXISTS `authmap`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `authmap` (
  `aid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique authmap ID.',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT 'User’s users.uid.',
  `authname` varchar(128) NOT NULL DEFAULT '' COMMENT 'Unique authentication name.',
  `module` varchar(128) NOT NULL DEFAULT '' COMMENT 'Module which is controlling the authentication.',
  PRIMARY KEY (`aid`),
  UNIQUE KEY `authname` (`authname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores distributed authentication mapping.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `batch`
--

DROP TABLE IF EXISTS `batch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `batch` (
  `bid` int(10) unsigned NOT NULL COMMENT 'Primary Key: Unique batch ID.',
  `token` varchar(64) NOT NULL COMMENT 'A string token generated against the current user’s session id and the batch id, used to ensure that only the user who submitted the batch can effectively access it.',
  `timestamp` int(11) NOT NULL COMMENT 'A Unix timestamp indicating when this batch was submitted for processing. Stale batches are purged at cron time.',
  `batch` longblob COMMENT 'A serialized array containing the processing data for the batch.',
  PRIMARY KEY (`bid`),
  KEY `token` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores details about batches (processes that run in...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `block`
--

DROP TABLE IF EXISTS `block`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `block` (
  `bid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique block ID.',
  `module` varchar(64) NOT NULL DEFAULT '' COMMENT 'The module from which the block originates; for example, ’user’ for the Who’s Online block, and ’block’ for any custom blocks.',
  `delta` varchar(32) NOT NULL DEFAULT '0' COMMENT 'Unique ID for block within a module.',
  `theme` varchar(64) NOT NULL DEFAULT '' COMMENT 'The theme under which the block settings apply.',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Block enabled status. (1 = enabled, 0 = disabled)',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'Block weight within region.',
  `region` varchar(64) NOT NULL DEFAULT '' COMMENT 'Theme region within which the block is set.',
  `custom` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Flag to indicate how users may control visibility of the block. (0 = Users cannot control, 1 = On by default, but can be hidden, 2 = Hidden by default, but can be shown)',
  `visibility` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Flag to indicate how to show blocks on pages. (0 = Show on all pages except listed pages, 1 = Show only on listed pages, 2 = Use custom PHP code to determine visibility)',
  `pages` text NOT NULL COMMENT 'Contents of the "Pages" block; contains either a list of paths on which to include/exclude the block or PHP code, depending on "visibility" setting.',
  `title` varchar(64) NOT NULL DEFAULT '' COMMENT 'Custom title for the block. (Empty string will use block default title, <none> will remove the title, text will cause block to use specified title.)',
  `cache` tinyint(4) NOT NULL DEFAULT '1' COMMENT 'Binary flag to indicate block cache mode. (-2: Custom cache, -1: Do not cache, 1: Cache per role, 2: Cache per user, 4: Cache per page, 8: Block cache global) See DRUPAL_CACHE_* constants in ../includes/common.inc for more detailed information.',
  PRIMARY KEY (`bid`),
  UNIQUE KEY `tmd` (`theme`,`module`,`delta`),
  KEY `list` (`theme`,`status`,`region`,`weight`,`module`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8 COMMENT='Stores block settings, such as region and visibility...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `block_custom`
--

DROP TABLE IF EXISTS `block_custom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `block_custom` (
  `bid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The block’s block.bid.',
  `body` longtext COMMENT 'Block contents.',
  `info` varchar(128) NOT NULL DEFAULT '' COMMENT 'Block description.',
  `format` varchar(255) DEFAULT NULL COMMENT 'The filter_format.format of the block body.',
  PRIMARY KEY (`bid`),
  UNIQUE KEY `info` (`info`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores contents of custom-made blocks.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `block_node_type`
--

DROP TABLE IF EXISTS `block_node_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `block_node_type` (
  `module` varchar(64) NOT NULL COMMENT 'The block’s origin module, from block.module.',
  `delta` varchar(32) NOT NULL COMMENT 'The block’s unique delta within module, from block.delta.',
  `type` varchar(32) NOT NULL COMMENT 'The machine-readable name of this type from node_type.type.',
  PRIMARY KEY (`module`,`delta`,`type`),
  KEY `type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sets up display criteria for blocks based on content types';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `block_role`
--

DROP TABLE IF EXISTS `block_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `block_role` (
  `module` varchar(64) NOT NULL COMMENT 'The block’s origin module, from block.module.',
  `delta` varchar(32) NOT NULL COMMENT 'The block’s unique delta within module, from block.delta.',
  `rid` int(10) unsigned NOT NULL COMMENT 'The user’s role ID from users_roles.rid.',
  PRIMARY KEY (`module`,`delta`,`rid`),
  KEY `rid` (`rid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sets up access permissions for blocks based on user roles';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `blocked_ips`
--

DROP TABLE IF EXISTS `blocked_ips`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blocked_ips` (
  `iid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: unique ID for IP addresses.',
  `ip` varchar(40) NOT NULL DEFAULT '' COMMENT 'IP address',
  PRIMARY KEY (`iid`),
  KEY `blocked_ip` (`ip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores blocked IP addresses.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cache`
--

DROP TABLE IF EXISTS `cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Generic cache table for caching things not separated out...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cache_admin_menu`
--

DROP TABLE IF EXISTS `cache_admin_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_admin_menu` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for Administration menu to store client-side...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cache_block`
--

DROP TABLE IF EXISTS `cache_block`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_block` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for the Block module to store already built...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cache_bootstrap`
--

DROP TABLE IF EXISTS `cache_bootstrap`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_bootstrap` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for data required to bootstrap Drupal, may be...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cache_field`
--

DROP TABLE IF EXISTS `cache_field`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_field` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Generic cache table for caching things not separated out...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cache_filter`
--

DROP TABLE IF EXISTS `cache_filter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_filter` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for the Filter module to store already...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cache_form`
--

DROP TABLE IF EXISTS `cache_form`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_form` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for the form system to store recently built...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cache_image`
--

DROP TABLE IF EXISTS `cache_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_image` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table used to store information about image...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cache_libraries`
--

DROP TABLE IF EXISTS `cache_libraries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_libraries` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table to store library information.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cache_menu`
--

DROP TABLE IF EXISTS `cache_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_menu` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for the menu system to store router...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cache_page`
--

DROP TABLE IF EXISTS `cache_page`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_page` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table used to store compressed pages for anonymous...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cache_path`
--

DROP TABLE IF EXISTS `cache_path`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_path` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for path alias lookup.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cache_rules`
--

DROP TABLE IF EXISTS `cache_rules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_rules` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for the rules engine to store configured items.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cache_update`
--

DROP TABLE IF EXISTS `cache_update`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_update` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for the Update module to store information...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cache_views`
--

DROP TABLE IF EXISTS `cache_views`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_views` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Generic cache table for caching things not separated out...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cache_views_data`
--

DROP TABLE IF EXISTS `cache_views_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_views_data` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '1' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for views to store pre-rendered queries,...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comment` (
  `cid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique comment ID.',
  `pid` int(11) NOT NULL DEFAULT '0' COMMENT 'The comment.cid to which this comment is a reply. If set to 0, this comment is not a reply to an existing comment.',
  `nid` int(11) NOT NULL DEFAULT '0' COMMENT 'The node.nid to which this comment is a reply.',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT 'The users.uid who authored the comment. If set to 0, this comment was created by an anonymous user.',
  `subject` varchar(64) NOT NULL DEFAULT '' COMMENT 'The comment title.',
  `hostname` varchar(128) NOT NULL DEFAULT '' COMMENT 'The author’s host name.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'The time that the comment was created, as a Unix timestamp.',
  `changed` int(11) NOT NULL DEFAULT '0' COMMENT 'The time that the comment was last edited, as a Unix timestamp.',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT 'The published status of a comment. (0 = Not Published, 1 = Published)',
  `thread` varchar(255) NOT NULL COMMENT 'The vancode representation of the comment’s place in a thread.',
  `name` varchar(60) DEFAULT NULL COMMENT 'The comment author’s name. Uses users.name if the user is logged in, otherwise uses the value typed into the comment form.',
  `mail` varchar(64) DEFAULT NULL COMMENT 'The comment author’s e-mail address from the comment form, if user is anonymous, and the ’Anonymous users may/must leave their contact information’ setting is turned on.',
  `homepage` varchar(255) DEFAULT NULL COMMENT 'The comment author’s home page address from the comment form, if user is anonymous, and the ’Anonymous users may/must leave their contact information’ setting is turned on.',
  `language` varchar(12) NOT NULL DEFAULT '' COMMENT 'The languages.language of this comment.',
  PRIMARY KEY (`cid`),
  KEY `comment_status_pid` (`pid`,`status`),
  KEY `comment_num_new` (`nid`,`status`,`created`,`cid`,`thread`),
  KEY `comment_uid` (`uid`),
  KEY `comment_nid_language` (`nid`,`language`),
  KEY `comment_created` (`created`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores comments and associated data.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_calculated_price`
--

DROP TABLE IF EXISTS `commerce_calculated_price`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_calculated_price` (
  `module` varchar(255) NOT NULL DEFAULT '' COMMENT 'The name of the module performing the calculation.',
  `module_key` mediumtext NOT NULL COMMENT 'A module specific key useful for indicating the context of a particular calculation, e.g. the IDs of Rules evaluated to produce the calculated price.',
  `entity_type` varchar(255) NOT NULL DEFAULT '' COMMENT 'The type of entity this price belongs to.',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The entity ID of the object this price belongs to.',
  `field_name` varchar(32) NOT NULL DEFAULT '' COMMENT 'The name of the field the calculated price relates to.',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The languages.language of the entity.',
  `delta` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The sequence number for this data item, used for multi-value fields',
  `amount` int(11) NOT NULL DEFAULT '0' COMMENT 'The price amount.',
  `currency_code` varchar(32) NOT NULL COMMENT 'The currency code for the price.',
  `data` longtext COMMENT 'A serialized array of additional price data.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when the price was calculated.',
  KEY `module` (`module`),
  KEY `entity_type` (`entity_type`),
  KEY `entity_id` (`entity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores pre-calculated dynamic prices.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_checkout_pane`
--

DROP TABLE IF EXISTS `commerce_checkout_pane`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_checkout_pane` (
  `pane_id` varchar(255) NOT NULL COMMENT 'The machine readable name of the order state.',
  `page` varchar(255) NOT NULL DEFAULT '1' COMMENT 'The ID of the checkout page on which this pane appears.',
  `fieldset` tinyint(4) NOT NULL DEFAULT '1' COMMENT 'Boolean value indicating whether or not the pane should appear in a fieldset.',
  `collapsible` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Boolean value indicating whether or not the pane should appear collapsed.',
  `collapsed` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Boolean value indicating whether or not the pane should appear collapsed.',
  `weight` smallint(6) NOT NULL DEFAULT '0' COMMENT 'The sorting weight of the status for lists of statuses.',
  `enabled` tinyint(4) NOT NULL DEFAULT '1' COMMENT 'Boolean value indicating whether or not the pane is enabled.',
  `review` tinyint(4) NOT NULL DEFAULT '1' COMMENT 'Boolean value indicating whether or not the pane should appear on the checkout review.',
  PRIMARY KEY (`pane_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Checkout pane configuration data.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_customer_profile`
--

DROP TABLE IF EXISTS `commerce_customer_profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_customer_profile` (
  `profile_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for a customer profile.',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The current commerce_customer_profile_revision.revision_id version identifier.',
  `type` varchar(255) NOT NULL DEFAULT '' COMMENT 'The commerce_customer_profile_type.type of this profile.',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT 'The users.uid that this profile belongs to.',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether the profile is active or not.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when the profile was created.',
  `changed` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when the profile was most recently saved.',
  `data` longblob COMMENT 'A serialized array of additional data.',
  PRIMARY KEY (`profile_id`),
  UNIQUE KEY `revision_id` (`revision_id`),
  KEY `uid` (`uid`),
  KEY `customer_profile_type` (`type`),
  KEY `uid_by_type` (`uid`,`type`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='The base table for customer profiles.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_customer_profile_revision`
--

DROP TABLE IF EXISTS `commerce_customer_profile_revision`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_customer_profile_revision` (
  `profile_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The commerce_customer_profile.customer_id of the profile this revision belongs to.',
  `revision_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for this revision.',
  `revision_uid` int(11) NOT NULL DEFAULT '0' COMMENT 'The users.uid that created this profile at this revision.',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether the profile is active or not.',
  `log` longtext NOT NULL COMMENT 'The log entry explaining the changes in this version.',
  `revision_timestamp` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when this revision was created.',
  `data` longblob COMMENT 'A serialized array of additional data.',
  PRIMARY KEY (`revision_id`),
  KEY `profile_id` (`profile_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Saves information about each saved revision of a commerce...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_license`
--

DROP TABLE IF EXISTS `commerce_license`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_license` (
  `license_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for a license.',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The current commerce_license_revision.revision_id identifier.',
  `type` varchar(64) NOT NULL COMMENT 'The license type.',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT 'The users.uid that created this license belongs to.',
  `product_id` int(11) NOT NULL DEFAULT '0' COMMENT 'The commerce_product.product_id that is licensed.',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'The license status.',
  `granted` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when the license was granted.',
  `expires` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when the license expires. 0 for never.',
  `expires_automatically` tinyint(4) NOT NULL DEFAULT '1' COMMENT 'Whether the module should expire the license automatically.',
  PRIMARY KEY (`license_id`),
  UNIQUE KEY `revision_id` (`revision_id`),
  KEY `uid` (`uid`),
  KEY `type` (`type`),
  KEY `status` (`status`),
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='The base table for the commerce_license entity type.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_license_revision`
--

DROP TABLE IF EXISTS `commerce_license_revision`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_license_revision` (
  `license_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The commerce_license.license_id of the license this revision belongs to.',
  `revision_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for this revision.',
  `product_id` int(11) NOT NULL DEFAULT '0' COMMENT 'The commerce_product.product_id that is licensed for this revision.',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'The license status for this revision.',
  `revision_created` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when the revision was created.',
  `revision_ended` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when the revision ended.',
  PRIMARY KEY (`revision_id`),
  KEY `license_id` (`license_id`),
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Stores information about each saved revision of a...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_line_item`
--

DROP TABLE IF EXISTS `commerce_line_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_line_item` (
  `line_item_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for a line item.',
  `order_id` int(11) NOT NULL DEFAULT '0' COMMENT 'The unique ID of the order the line item belongs to.',
  `type` varchar(255) NOT NULL DEFAULT '' COMMENT 'The module defined type of this line item.',
  `line_item_label` varchar(255) NOT NULL COMMENT 'The merchant defined label for a line item.',
  `quantity` decimal(10,2) NOT NULL DEFAULT '0.00',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when the line item was created.',
  `changed` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when the line item was most recently saved.',
  `data` longblob COMMENT 'A serialized array of additional data.',
  PRIMARY KEY (`line_item_id`),
  KEY `order_id` (`order_id`),
  KEY `line_item_type` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='The base table for line items.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_order`
--

DROP TABLE IF EXISTS `commerce_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_order` (
  `order_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for an order.',
  `order_number` varchar(255) DEFAULT NULL COMMENT 'The order number displayed to the customer.',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The current commerce_order_revision.revision_id version identifier.',
  `type` varchar(255) NOT NULL DEFAULT '' COMMENT 'The type of this order.',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT 'The users.uid that owns this order.',
  `mail` varchar(255) NOT NULL DEFAULT '' COMMENT 'The e-mail address associated with the order.',
  `status` varchar(255) NOT NULL COMMENT 'The status name of this order.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when the order was created.',
  `changed` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when the order was most recently saved.',
  `hostname` varchar(128) NOT NULL DEFAULT '' COMMENT 'The IP address that created this order.',
  `data` longblob COMMENT 'A serialized array of additional data.',
  PRIMARY KEY (`order_id`),
  UNIQUE KEY `order_number` (`order_number`),
  UNIQUE KEY `revision_id` (`revision_id`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='The base table for orders.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_order_revision`
--

DROP TABLE IF EXISTS `commerce_order_revision`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_order_revision` (
  `order_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The commerce_order.order_id of the order this revision belongs to.',
  `order_number` varchar(255) DEFAULT NULL COMMENT 'The order number displayed to the customer for this revision.',
  `revision_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for this revision.',
  `revision_uid` int(11) NOT NULL DEFAULT '0' COMMENT 'The users.uid that owns the order at this revision.',
  `mail` varchar(255) NOT NULL COMMENT 'The e-mail address associated with the order at this revision.',
  `status` varchar(255) NOT NULL COMMENT 'The status name of this revision.',
  `log` longtext NOT NULL COMMENT 'The log entry explaining the changes in this version.',
  `revision_timestamp` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when this revision was created.',
  `revision_hostname` varchar(128) NOT NULL DEFAULT '' COMMENT 'The IP address that created this order.',
  `data` longblob COMMENT 'A serialized array of additional data.',
  PRIMARY KEY (`revision_id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='Saves information about each saved revision of a commerce...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_payment_transaction`
--

DROP TABLE IF EXISTS `commerce_payment_transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_payment_transaction` (
  `transaction_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for a transaction.',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The current commerce_payment_transaction_revision.revision_id version identifier.',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT 'The users.uid that created this transaction.',
  `order_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The commerce_order.order_id of the order this payment is for.',
  `payment_method` varchar(128) NOT NULL COMMENT 'The payment method method_id for this transaction.',
  `instance_id` varchar(255) NOT NULL COMMENT 'The payment method instance ID for this transaction.',
  `remote_id` varchar(255) NOT NULL COMMENT 'The remote identifier for this transaction.',
  `message` longtext NOT NULL COMMENT 'The human-readable message associated to this transaction.',
  `message_variables` longblob NOT NULL COMMENT 'The variables associated with the human-readable message.',
  `amount` int(11) NOT NULL DEFAULT '0' COMMENT 'The amount of this transaction.',
  `currency_code` varchar(32) NOT NULL COMMENT 'The currency code for the price.',
  `status` varchar(128) NOT NULL COMMENT 'The status of this transaction (pending, success, or failure).',
  `remote_status` varchar(128) NOT NULL COMMENT 'The status of the transaction at the payment provider.',
  `payload` longblob NOT NULL COMMENT 'The payment-gateway specific payload associated with this transaction.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when this transaction was created.',
  `changed` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when this transaction was last changed.',
  `data` longblob COMMENT 'A serialized array of additional data.',
  PRIMARY KEY (`transaction_id`),
  UNIQUE KEY `revision_id` (`revision_id`),
  KEY `payment_method` (`payment_method`),
  KEY `uid` (`uid`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Transaction information for every attempted payment.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_payment_transaction_revision`
--

DROP TABLE IF EXISTS `commerce_payment_transaction_revision`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_payment_transaction_revision` (
  `transaction_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The primary identifier for a transaction.',
  `revision_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The current commerce_payment_transaction_revision.revision_id version identifier.',
  `revision_uid` int(11) NOT NULL DEFAULT '0' COMMENT 'The users.uid that created this revision.',
  `remote_id` varchar(255) NOT NULL COMMENT 'The remote identifier for this transaction.',
  `message` longtext NOT NULL COMMENT 'The human-readable message associated to this transaction.',
  `message_variables` longblob NOT NULL COMMENT 'The variables associated with the human-readable message.',
  `amount` int(11) NOT NULL DEFAULT '0' COMMENT 'The amount of this transaction.',
  `currency_code` varchar(32) NOT NULL COMMENT 'The currency code for the price.',
  `status` varchar(128) NOT NULL COMMENT 'The status of this transaction (pending, success, or failure).',
  `remote_status` varchar(128) NOT NULL COMMENT 'The status of the transaction at the payment provider.',
  `log` longtext NOT NULL COMMENT 'The log entry explaining the changes in this version.',
  `revision_timestamp` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when this revision was created.',
  `data` longblob COMMENT 'A serialized array of additional data.',
  PRIMARY KEY (`revision_id`),
  KEY `transaction_id` (`transaction_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Saves information about each saved revision of a commerce...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_product`
--

DROP TABLE IF EXISTS `commerce_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_product` (
  `product_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for a product, used internally only.',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The current commerce_product_revision.revision_id version identifier.',
  `sku` varchar(255) NOT NULL COMMENT 'The unique, human-readable identifier for a product.',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'The title of this product, always treated as non-markup plain text.',
  `type` varchar(255) NOT NULL DEFAULT '' COMMENT 'The commerce_product_type.type of this product.',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The languages.language of this product.',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT 'The users.uid that created this product.',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT 'Boolean indicating whether or not the product appears in lists and may be added to orders.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when the product was created.',
  `changed` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when the product was most recently saved.',
  `data` longblob COMMENT 'A serialized array of additional data.',
  PRIMARY KEY (`product_id`),
  UNIQUE KEY `sku` (`sku`),
  UNIQUE KEY `revision_id` (`revision_id`),
  KEY `product_type` (`type`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='The base table for products.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_product_revision`
--

DROP TABLE IF EXISTS `commerce_product_revision`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_product_revision` (
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The commerce_product.product_id of the product this revision belongs to.',
  `revision_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for this revision.',
  `sku` varchar(255) NOT NULL COMMENT 'The unique, human-readable identifier of a product for this revision.',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'The title of this product for this revision',
  `revision_uid` int(11) NOT NULL DEFAULT '0' COMMENT 'The users.uid that owns the product at this revision.',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT 'The status of this revision.',
  `log` longtext NOT NULL COMMENT 'The log entry explaining the changes in this version.',
  `revision_timestamp` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when this revision was created.',
  `data` longblob COMMENT 'A serialized array of additional data for this revision.',
  PRIMARY KEY (`revision_id`),
  KEY `product_id` (`product_id`),
  KEY `revision_uid` (`revision_uid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='Saves information about each saved revision of a commerce...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_product_type`
--

DROP TABLE IF EXISTS `commerce_product_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_product_type` (
  `type` varchar(32) NOT NULL DEFAULT '' COMMENT 'The machine-readable name of this type.',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The human-readable name of this type.',
  `description` mediumtext NOT NULL COMMENT 'A brief description of this type.',
  `help` mediumtext NOT NULL COMMENT 'Help information shown to the user when creating a commerce_product of this type.',
  `revision` tinyint(4) NOT NULL DEFAULT '1' COMMENT 'Determine whether to create a new revision when a product of this type is updated.',
  PRIMARY KEY (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores information about commerce_product types created...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_tax_rate`
--

DROP TABLE IF EXISTS `commerce_tax_rate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_tax_rate` (
  `name` varchar(64) NOT NULL DEFAULT '' COMMENT 'The machine-name of this rate.',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'The administrative title of this rate.',
  `display_title` varchar(255) NOT NULL DEFAULT '' COMMENT 'The front end display title of this rate.',
  `description` mediumtext COMMENT 'A brief description of this rate.',
  `rate` varchar(64) NOT NULL DEFAULT '0' COMMENT 'The percentage used to calculate this tax expressed as a decimal.',
  `type` varchar(64) NOT NULL DEFAULT '' COMMENT 'The machine-name of the rate’s commerce_tax_type.',
  `default_rules_component` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether or not this rate should have a default Rules component for applying it to products.',
  `module` varchar(255) NOT NULL DEFAULT '' COMMENT 'The name of the module that defines this tax type.',
  PRIMARY KEY (`name`),
  KEY `type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores information about tax rates created via Tax UI.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_tax_type`
--

DROP TABLE IF EXISTS `commerce_tax_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_tax_type` (
  `name` varchar(64) NOT NULL DEFAULT '' COMMENT 'The machine-name of this type.',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'The administrative title of this type.',
  `display_title` varchar(255) NOT NULL DEFAULT '' COMMENT 'The front end display title of this type.',
  `description` mediumtext COMMENT 'A brief description of this type.',
  `display_inclusive` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether or not taxes of this type display inclusively in product prices.',
  `round_mode` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Integer indicating what type of rounding (if any) should be done for taxes of this type.',
  `module` varchar(255) NOT NULL DEFAULT '' COMMENT 'The name of the module that defines this tax type.',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores information about tax types created via Tax UI.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ctools_css_cache`
--

DROP TABLE IF EXISTS `ctools_css_cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ctools_css_cache` (
  `cid` varchar(128) NOT NULL COMMENT 'The CSS ID this cache object belongs to.',
  `filename` varchar(255) DEFAULT NULL COMMENT 'The filename this CSS is stored in.',
  `css` longtext COMMENT 'CSS being stored.',
  `filter` tinyint(4) DEFAULT NULL COMMENT 'Whether or not this CSS needs to be filtered.',
  PRIMARY KEY (`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='A special cache used to store CSS that must be non-volatile.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ctools_object_cache`
--

DROP TABLE IF EXISTS `ctools_object_cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ctools_object_cache` (
  `sid` varchar(64) NOT NULL COMMENT 'The session ID this cache object belongs to.',
  `name` varchar(128) NOT NULL COMMENT 'The name of the object this cache is attached to.',
  `obj` varchar(32) NOT NULL COMMENT 'The type of the object this cache is attached to; this essentially represents the owner so that several sub-systems can use this cache.',
  `updated` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The time this cache was created or updated.',
  `data` longblob COMMENT 'Serialized data being stored.',
  PRIMARY KEY (`sid`,`obj`,`name`),
  KEY `updated` (`updated`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='A special cache used to store objects that are being...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `date_format_locale`
--

DROP TABLE IF EXISTS `date_format_locale`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `date_format_locale` (
  `format` varchar(100) NOT NULL COMMENT 'The date format string.',
  `type` varchar(64) NOT NULL COMMENT 'The date format type, e.g. medium.',
  `language` varchar(12) NOT NULL COMMENT 'A languages.language for this format to be used with.',
  PRIMARY KEY (`type`,`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores configured date formats for each locale.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `date_format_type`
--

DROP TABLE IF EXISTS `date_format_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `date_format_type` (
  `type` varchar(64) NOT NULL COMMENT 'The date format type, e.g. medium.',
  `title` varchar(255) NOT NULL COMMENT 'The human readable name of the format type.',
  `locked` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Whether or not this is a system provided format.',
  PRIMARY KEY (`type`),
  KEY `title` (`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores configured date format types.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `date_formats`
--

DROP TABLE IF EXISTS `date_formats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `date_formats` (
  `dfid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The date format identifier.',
  `format` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'The date format string.',
  `type` varchar(64) NOT NULL COMMENT 'The date format type, e.g. medium.',
  `locked` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Whether or not this format can be modified.',
  PRIMARY KEY (`dfid`),
  UNIQUE KEY `formats` (`format`,`type`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8 COMMENT='Stores configured date formats.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dnd_character_race`
--

DROP TABLE IF EXISTS `dnd_character_race`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dnd_character_race` (
  `machine_name` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The machine name of the race.',
  `name` varchar(64) NOT NULL DEFAULT '' COMMENT 'The race name.',
  `plural` varchar(64) NOT NULL DEFAULT '' COMMENT 'The plural form of the race name.',
  `ability_mods` varchar(64) NOT NULL DEFAULT '' COMMENT 'The ability mods of the race, serialized.',
  `speed` int(10) unsigned NOT NULL DEFAULT '30' COMMENT 'The racial base speed.',
  `size` varchar(64) NOT NULL DEFAULT 'M' COMMENT 'The intelligence attribute.',
  `racial_traits` mediumtext NOT NULL COMMENT 'Racial traits as a serialized array.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Race data table for D&D characters.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_collection_item`
--

DROP TABLE IF EXISTS `field_collection_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_collection_item` (
  `item_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique field collection item ID.',
  `revision_id` int(11) NOT NULL COMMENT 'Default revision ID.',
  `field_name` varchar(32) NOT NULL COMMENT 'The name of the field on the host entity embedding this entity.',
  `archived` int(11) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether the field collection item is archived.',
  PRIMARY KEY (`item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='Stores information about field collection items.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_collection_item_revision`
--

DROP TABLE IF EXISTS `field_collection_item_revision`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_collection_item_revision` (
  `revision_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique revision ID.',
  `item_id` int(11) NOT NULL COMMENT 'Field collection item ID.',
  PRIMARY KEY (`revision_id`),
  KEY `item_id` (`item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='Stores revision information about field collection items.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_config`
--

DROP TABLE IF EXISTS `field_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for a field',
  `field_name` varchar(32) NOT NULL COMMENT 'The name of this field. Non-deleted field names are unique, but multiple deleted fields can have the same name.',
  `type` varchar(128) NOT NULL COMMENT 'The type of this field.',
  `module` varchar(128) NOT NULL DEFAULT '' COMMENT 'The module that implements the field type.',
  `active` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether the module that implements the field type is enabled.',
  `storage_type` varchar(128) NOT NULL COMMENT 'The storage backend for the field.',
  `storage_module` varchar(128) NOT NULL DEFAULT '' COMMENT 'The module that implements the storage backend.',
  `storage_active` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether the module that implements the storage backend is enabled.',
  `locked` tinyint(4) NOT NULL DEFAULT '0' COMMENT '@TODO',
  `data` longblob NOT NULL COMMENT 'Serialized data containing the field properties that do not warrant a dedicated column.',
  `cardinality` tinyint(4) NOT NULL DEFAULT '0',
  `translatable` tinyint(4) NOT NULL DEFAULT '0',
  `deleted` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `field_name` (`field_name`),
  KEY `active` (`active`),
  KEY `storage_active` (`storage_active`),
  KEY `deleted` (`deleted`),
  KEY `module` (`module`),
  KEY `storage_module` (`storage_module`),
  KEY `type` (`type`),
  KEY `storage_type` (`storage_type`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_config_instance`
--

DROP TABLE IF EXISTS `field_config_instance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_config_instance` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for a field instance',
  `field_id` int(11) NOT NULL COMMENT 'The identifier of the field attached by this instance',
  `field_name` varchar(32) NOT NULL DEFAULT '',
  `entity_type` varchar(32) NOT NULL DEFAULT '',
  `bundle` varchar(128) NOT NULL DEFAULT '',
  `data` longblob NOT NULL,
  `deleted` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `field_name_bundle` (`field_name`,`entity_type`,`bundle`),
  KEY `deleted` (`deleted`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_body`
--

DROP TABLE IF EXISTS `field_data_body`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_body` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `body_value` longtext,
  `body_summary` longtext,
  `body_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `body_format` (`body_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 2 (body)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_cle_api_key`
--

DROP TABLE IF EXISTS `field_data_cle_api_key`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_cle_api_key` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `cle_api_key_value` varchar(255) DEFAULT NULL,
  `cle_api_key_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `cle_api_key_format` (`cle_api_key_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 21 (cle_api_key)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_cle_name`
--

DROP TABLE IF EXISTS `field_data_cle_name`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_cle_name` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `cle_name_value` varchar(255) DEFAULT NULL,
  `cle_name_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `cle_name_format` (`cle_name_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 19 (cle_name)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_comment_body`
--

DROP TABLE IF EXISTS `field_data_comment_body`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_comment_body` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `comment_body_value` longtext,
  `comment_body_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `comment_body_format` (`comment_body_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 1 (comment_body)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_commerce_customer_address`
--

DROP TABLE IF EXISTS `field_data_commerce_customer_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_commerce_customer_address` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `commerce_customer_address_country` varchar(2) DEFAULT '' COMMENT 'Two letter ISO country code of this address.',
  `commerce_customer_address_administrative_area` varchar(255) DEFAULT '' COMMENT 'The administrative area of this address. (i.e. State/Province)',
  `commerce_customer_address_sub_administrative_area` varchar(255) DEFAULT '' COMMENT 'The sub administrative area of this address.',
  `commerce_customer_address_locality` varchar(255) DEFAULT '' COMMENT 'The locality of this address. (i.e. City)',
  `commerce_customer_address_dependent_locality` varchar(255) DEFAULT '' COMMENT 'The dependent locality of this address.',
  `commerce_customer_address_postal_code` varchar(255) DEFAULT '' COMMENT 'The postal code of this address.',
  `commerce_customer_address_thoroughfare` varchar(255) DEFAULT '' COMMENT 'The thoroughfare of this address. (i.e. Street address)',
  `commerce_customer_address_premise` varchar(255) DEFAULT '' COMMENT 'The premise of this address. (i.e. Apartment / Suite number)',
  `commerce_customer_address_sub_premise` varchar(255) DEFAULT '' COMMENT 'The sub_premise of this address.',
  `commerce_customer_address_organisation_name` varchar(255) DEFAULT '' COMMENT 'Contents of a primary OrganisationName element in the xNL XML.',
  `commerce_customer_address_name_line` varchar(255) DEFAULT '' COMMENT 'Contents of a primary NameLine element in the xNL XML.',
  `commerce_customer_address_first_name` varchar(255) DEFAULT '' COMMENT 'Contents of the FirstName element of a primary PersonName element in the xNL XML.',
  `commerce_customer_address_last_name` varchar(255) DEFAULT '' COMMENT 'Contents of the LastName element of a primary PersonName element in the xNL XML.',
  `commerce_customer_address_data` longtext COMMENT 'Additional data for this address.',
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 9 (commerce_customer_address)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_commerce_customer_billing`
--

DROP TABLE IF EXISTS `field_data_commerce_customer_billing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_commerce_customer_billing` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `commerce_customer_billing_profile_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `commerce_customer_billing_profile_id` (`commerce_customer_billing_profile_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 12 (commerce_customer_billing)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_commerce_display_path`
--

DROP TABLE IF EXISTS `field_data_commerce_display_path`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_commerce_display_path` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `commerce_display_path_value` varchar(255) DEFAULT NULL,
  `commerce_display_path_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `commerce_display_path_format` (`commerce_display_path_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 8 (commerce_display_path)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_commerce_license`
--

DROP TABLE IF EXISTS `field_data_commerce_license`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_commerce_license` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `commerce_license_target_id` int(10) unsigned NOT NULL COMMENT 'The id of the target entity.',
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `commerce_license_target_id` (`commerce_license_target_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 16 (commerce_license)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_commerce_license_duration`
--

DROP TABLE IF EXISTS `field_data_commerce_license_duration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_commerce_license_duration` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `commerce_license_duration_value` int(11) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 15 (commerce_license_duration)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_commerce_license_role`
--

DROP TABLE IF EXISTS `field_data_commerce_license_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_commerce_license_role` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `commerce_license_role_value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `commerce_license_role_value` (`commerce_license_role_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 17 (commerce_license_role)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_commerce_license_type`
--

DROP TABLE IF EXISTS `field_data_commerce_license_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_commerce_license_type` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `commerce_license_type_value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `commerce_license_type_value` (`commerce_license_type_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 14 (commerce_license_type)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_commerce_line_items`
--

DROP TABLE IF EXISTS `field_data_commerce_line_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_commerce_line_items` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `commerce_line_items_line_item_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `commerce_line_items_line_item_id` (`commerce_line_items_line_item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 10 (commerce_line_items)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_commerce_order_total`
--

DROP TABLE IF EXISTS `field_data_commerce_order_total`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_commerce_order_total` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `commerce_order_total_amount` int(11) NOT NULL DEFAULT '0' COMMENT 'The price amount.',
  `commerce_order_total_currency_code` varchar(32) NOT NULL COMMENT 'The currency code for the price.',
  `commerce_order_total_data` longtext COMMENT 'A serialized array of additional price data.',
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `commerce_order_total_currency_price` (`commerce_order_total_amount`,`commerce_order_total_currency_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 11 (commerce_order_total)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_commerce_price`
--

DROP TABLE IF EXISTS `field_data_commerce_price`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_commerce_price` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `commerce_price_amount` int(11) NOT NULL DEFAULT '0' COMMENT 'The price amount.',
  `commerce_price_currency_code` varchar(32) NOT NULL COMMENT 'The currency code for the price.',
  `commerce_price_data` longtext COMMENT 'A serialized array of additional price data.',
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `commerce_price_currency_price` (`commerce_price_amount`,`commerce_price_currency_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 13 (commerce_price)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_commerce_product`
--

DROP TABLE IF EXISTS `field_data_commerce_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_commerce_product` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `commerce_product_product_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `commerce_product_product_id` (`commerce_product_product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 7 (commerce_product)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_commerce_total`
--

DROP TABLE IF EXISTS `field_data_commerce_total`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_commerce_total` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `commerce_total_amount` int(11) NOT NULL DEFAULT '0' COMMENT 'The price amount.',
  `commerce_total_currency_code` varchar(32) NOT NULL COMMENT 'The currency code for the price.',
  `commerce_total_data` longtext COMMENT 'A serialized array of additional price data.',
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `commerce_total_currency_price` (`commerce_total_amount`,`commerce_total_currency_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 6 (commerce_total)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_commerce_unit_price`
--

DROP TABLE IF EXISTS `field_data_commerce_unit_price`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_commerce_unit_price` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `commerce_unit_price_amount` int(11) NOT NULL DEFAULT '0' COMMENT 'The price amount.',
  `commerce_unit_price_currency_code` varchar(32) NOT NULL COMMENT 'The currency code for the price.',
  `commerce_unit_price_data` longtext COMMENT 'A serialized array of additional price data.',
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `commerce_unit_price_currency_price` (`commerce_unit_price_amount`,`commerce_unit_price_currency_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 5 (commerce_unit_price)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_caption`
--

DROP TABLE IF EXISTS `field_data_field_caption`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_caption` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_caption_value` varchar(600) DEFAULT NULL,
  `field_caption_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_caption_format` (`field_caption_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 25 (field_caption)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_image`
--

DROP TABLE IF EXISTS `field_data_field_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_image` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_image_fid` int(10) unsigned DEFAULT NULL COMMENT 'The file_managed.fid being referenced in this field.',
  `field_image_alt` varchar(512) DEFAULT NULL COMMENT 'Alternative image text, for the image’s ’alt’ attribute.',
  `field_image_title` varchar(1024) DEFAULT NULL COMMENT 'Image title text, for the image’s ’title’ attribute.',
  `field_image_width` int(10) unsigned DEFAULT NULL COMMENT 'The width of the image in pixels.',
  `field_image_height` int(10) unsigned DEFAULT NULL COMMENT 'The height of the image in pixels.',
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_image_fid` (`field_image_fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 4 (field_image)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_product_reference`
--

DROP TABLE IF EXISTS `field_data_field_product_reference`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_product_reference` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_product_reference_product_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_product_reference_product_id` (`field_product_reference_product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 22 (field_product_reference)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_slideshow`
--

DROP TABLE IF EXISTS `field_data_field_slideshow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_slideshow` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_slideshow_value` int(11) DEFAULT NULL COMMENT 'The field collection item id.',
  `field_slideshow_revision_id` int(11) DEFAULT NULL COMMENT 'The field collection item revision id.',
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_slideshow_revision_id` (`field_slideshow_revision_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 23 (field_slideshow)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_slideshow_img`
--

DROP TABLE IF EXISTS `field_data_field_slideshow_img`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_slideshow_img` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_slideshow_img_fid` int(10) unsigned DEFAULT NULL COMMENT 'The file_managed.fid being referenced in this field.',
  `field_slideshow_img_alt` varchar(512) DEFAULT NULL COMMENT 'Alternative image text, for the image’s ’alt’ attribute.',
  `field_slideshow_img_title` varchar(1024) DEFAULT NULL COMMENT 'Image title text, for the image’s ’title’ attribute.',
  `field_slideshow_img_width` int(10) unsigned DEFAULT NULL COMMENT 'The width of the image in pixels.',
  `field_slideshow_img_height` int(10) unsigned DEFAULT NULL COMMENT 'The height of the image in pixels.',
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_slideshow_img_fid` (`field_slideshow_img_fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 24 (field_slideshow_img)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_field_tags`
--

DROP TABLE IF EXISTS `field_data_field_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_tags` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_tags_tid` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_tags_tid` (`field_tags_tid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 3 (field_tags)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_num_renewals`
--

DROP TABLE IF EXISTS `field_data_num_renewals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_num_renewals` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `num_renewals_value` int(11) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 18 (num_renewals)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_data_sync_status`
--

DROP TABLE IF EXISTS `field_data_sync_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_sync_status` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `sync_status_value` int(11) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `sync_status_value` (`sync_status_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 20 (sync_status)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_body`
--

DROP TABLE IF EXISTS `field_revision_body`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_body` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `body_value` longtext,
  `body_summary` longtext,
  `body_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `body_format` (`body_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 2 (body)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_cle_api_key`
--

DROP TABLE IF EXISTS `field_revision_cle_api_key`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_cle_api_key` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `cle_api_key_value` varchar(255) DEFAULT NULL,
  `cle_api_key_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `cle_api_key_format` (`cle_api_key_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 21 (cle_api_key)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_cle_name`
--

DROP TABLE IF EXISTS `field_revision_cle_name`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_cle_name` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `cle_name_value` varchar(255) DEFAULT NULL,
  `cle_name_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `cle_name_format` (`cle_name_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 19 (cle_name)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_comment_body`
--

DROP TABLE IF EXISTS `field_revision_comment_body`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_comment_body` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `comment_body_value` longtext,
  `comment_body_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `comment_body_format` (`comment_body_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 1 (comment_body)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_commerce_customer_address`
--

DROP TABLE IF EXISTS `field_revision_commerce_customer_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_commerce_customer_address` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `commerce_customer_address_country` varchar(2) DEFAULT '' COMMENT 'Two letter ISO country code of this address.',
  `commerce_customer_address_administrative_area` varchar(255) DEFAULT '' COMMENT 'The administrative area of this address. (i.e. State/Province)',
  `commerce_customer_address_sub_administrative_area` varchar(255) DEFAULT '' COMMENT 'The sub administrative area of this address.',
  `commerce_customer_address_locality` varchar(255) DEFAULT '' COMMENT 'The locality of this address. (i.e. City)',
  `commerce_customer_address_dependent_locality` varchar(255) DEFAULT '' COMMENT 'The dependent locality of this address.',
  `commerce_customer_address_postal_code` varchar(255) DEFAULT '' COMMENT 'The postal code of this address.',
  `commerce_customer_address_thoroughfare` varchar(255) DEFAULT '' COMMENT 'The thoroughfare of this address. (i.e. Street address)',
  `commerce_customer_address_premise` varchar(255) DEFAULT '' COMMENT 'The premise of this address. (i.e. Apartment / Suite number)',
  `commerce_customer_address_sub_premise` varchar(255) DEFAULT '' COMMENT 'The sub_premise of this address.',
  `commerce_customer_address_organisation_name` varchar(255) DEFAULT '' COMMENT 'Contents of a primary OrganisationName element in the xNL XML.',
  `commerce_customer_address_name_line` varchar(255) DEFAULT '' COMMENT 'Contents of a primary NameLine element in the xNL XML.',
  `commerce_customer_address_first_name` varchar(255) DEFAULT '' COMMENT 'Contents of the FirstName element of a primary PersonName element in the xNL XML.',
  `commerce_customer_address_last_name` varchar(255) DEFAULT '' COMMENT 'Contents of the LastName element of a primary PersonName element in the xNL XML.',
  `commerce_customer_address_data` longtext COMMENT 'Additional data for this address.',
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 9 (commerce_customer...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_commerce_customer_billing`
--

DROP TABLE IF EXISTS `field_revision_commerce_customer_billing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_commerce_customer_billing` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `commerce_customer_billing_profile_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `commerce_customer_billing_profile_id` (`commerce_customer_billing_profile_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 12 (commerce_customer...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_commerce_display_path`
--

DROP TABLE IF EXISTS `field_revision_commerce_display_path`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_commerce_display_path` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `commerce_display_path_value` varchar(255) DEFAULT NULL,
  `commerce_display_path_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `commerce_display_path_format` (`commerce_display_path_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 8 (commerce_display_path)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_commerce_license`
--

DROP TABLE IF EXISTS `field_revision_commerce_license`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_commerce_license` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `commerce_license_target_id` int(10) unsigned NOT NULL COMMENT 'The id of the target entity.',
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `commerce_license_target_id` (`commerce_license_target_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 16 (commerce_license)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_commerce_license_duration`
--

DROP TABLE IF EXISTS `field_revision_commerce_license_duration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_commerce_license_duration` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `commerce_license_duration_value` int(11) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 15 (commerce_license...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_commerce_license_role`
--

DROP TABLE IF EXISTS `field_revision_commerce_license_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_commerce_license_role` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `commerce_license_role_value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `commerce_license_role_value` (`commerce_license_role_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 17 (commerce_license...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_commerce_license_type`
--

DROP TABLE IF EXISTS `field_revision_commerce_license_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_commerce_license_type` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `commerce_license_type_value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `commerce_license_type_value` (`commerce_license_type_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 14 (commerce_license...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_commerce_line_items`
--

DROP TABLE IF EXISTS `field_revision_commerce_line_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_commerce_line_items` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `commerce_line_items_line_item_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `commerce_line_items_line_item_id` (`commerce_line_items_line_item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 10 (commerce_line_items)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_commerce_order_total`
--

DROP TABLE IF EXISTS `field_revision_commerce_order_total`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_commerce_order_total` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `commerce_order_total_amount` int(11) NOT NULL DEFAULT '0' COMMENT 'The price amount.',
  `commerce_order_total_currency_code` varchar(32) NOT NULL COMMENT 'The currency code for the price.',
  `commerce_order_total_data` longtext COMMENT 'A serialized array of additional price data.',
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `commerce_order_total_currency_price` (`commerce_order_total_amount`,`commerce_order_total_currency_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 11 (commerce_order_total)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_commerce_price`
--

DROP TABLE IF EXISTS `field_revision_commerce_price`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_commerce_price` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `commerce_price_amount` int(11) NOT NULL DEFAULT '0' COMMENT 'The price amount.',
  `commerce_price_currency_code` varchar(32) NOT NULL COMMENT 'The currency code for the price.',
  `commerce_price_data` longtext COMMENT 'A serialized array of additional price data.',
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `commerce_price_currency_price` (`commerce_price_amount`,`commerce_price_currency_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 13 (commerce_price)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_commerce_product`
--

DROP TABLE IF EXISTS `field_revision_commerce_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_commerce_product` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `commerce_product_product_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `commerce_product_product_id` (`commerce_product_product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 7 (commerce_product)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_commerce_total`
--

DROP TABLE IF EXISTS `field_revision_commerce_total`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_commerce_total` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `commerce_total_amount` int(11) NOT NULL DEFAULT '0' COMMENT 'The price amount.',
  `commerce_total_currency_code` varchar(32) NOT NULL COMMENT 'The currency code for the price.',
  `commerce_total_data` longtext COMMENT 'A serialized array of additional price data.',
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `commerce_total_currency_price` (`commerce_total_amount`,`commerce_total_currency_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 6 (commerce_total)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_commerce_unit_price`
--

DROP TABLE IF EXISTS `field_revision_commerce_unit_price`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_commerce_unit_price` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `commerce_unit_price_amount` int(11) NOT NULL DEFAULT '0' COMMENT 'The price amount.',
  `commerce_unit_price_currency_code` varchar(32) NOT NULL COMMENT 'The currency code for the price.',
  `commerce_unit_price_data` longtext COMMENT 'A serialized array of additional price data.',
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `commerce_unit_price_currency_price` (`commerce_unit_price_amount`,`commerce_unit_price_currency_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 5 (commerce_unit_price)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_caption`
--

DROP TABLE IF EXISTS `field_revision_field_caption`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_caption` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_caption_value` varchar(600) DEFAULT NULL,
  `field_caption_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_caption_format` (`field_caption_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 25 (field_caption)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_image`
--

DROP TABLE IF EXISTS `field_revision_field_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_image` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_image_fid` int(10) unsigned DEFAULT NULL COMMENT 'The file_managed.fid being referenced in this field.',
  `field_image_alt` varchar(512) DEFAULT NULL COMMENT 'Alternative image text, for the image’s ’alt’ attribute.',
  `field_image_title` varchar(1024) DEFAULT NULL COMMENT 'Image title text, for the image’s ’title’ attribute.',
  `field_image_width` int(10) unsigned DEFAULT NULL COMMENT 'The width of the image in pixels.',
  `field_image_height` int(10) unsigned DEFAULT NULL COMMENT 'The height of the image in pixels.',
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_image_fid` (`field_image_fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 4 (field_image)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_product_reference`
--

DROP TABLE IF EXISTS `field_revision_field_product_reference`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_product_reference` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_product_reference_product_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_product_reference_product_id` (`field_product_reference_product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 22 (field_product...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_slideshow`
--

DROP TABLE IF EXISTS `field_revision_field_slideshow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_slideshow` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_slideshow_value` int(11) DEFAULT NULL COMMENT 'The field collection item id.',
  `field_slideshow_revision_id` int(11) DEFAULT NULL COMMENT 'The field collection item revision id.',
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_slideshow_revision_id` (`field_slideshow_revision_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 23 (field_slideshow)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_slideshow_img`
--

DROP TABLE IF EXISTS `field_revision_field_slideshow_img`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_slideshow_img` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_slideshow_img_fid` int(10) unsigned DEFAULT NULL COMMENT 'The file_managed.fid being referenced in this field.',
  `field_slideshow_img_alt` varchar(512) DEFAULT NULL COMMENT 'Alternative image text, for the image’s ’alt’ attribute.',
  `field_slideshow_img_title` varchar(1024) DEFAULT NULL COMMENT 'Image title text, for the image’s ’title’ attribute.',
  `field_slideshow_img_width` int(10) unsigned DEFAULT NULL COMMENT 'The width of the image in pixels.',
  `field_slideshow_img_height` int(10) unsigned DEFAULT NULL COMMENT 'The height of the image in pixels.',
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_slideshow_img_fid` (`field_slideshow_img_fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 24 (field_slideshow_img)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_field_tags`
--

DROP TABLE IF EXISTS `field_revision_field_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_tags` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_tags_tid` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_tags_tid` (`field_tags_tid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 3 (field_tags)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_num_renewals`
--

DROP TABLE IF EXISTS `field_revision_num_renewals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_num_renewals` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `num_renewals_value` int(11) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 18 (num_renewals)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_revision_sync_status`
--

DROP TABLE IF EXISTS `field_revision_sync_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_sync_status` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `sync_status_value` int(11) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `sync_status_value` (`sync_status_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 20 (sync_status)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `file_managed`
--

DROP TABLE IF EXISTS `file_managed`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `file_managed` (
  `fid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'File ID.',
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The users.uid of the user who is associated with the file.',
  `filename` varchar(255) NOT NULL DEFAULT '' COMMENT 'Name of the file with no path components. This may differ from the basename of the URI if the file is renamed to avoid overwriting an existing file.',
  `uri` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'The URI to access the file (either local or remote).',
  `filemime` varchar(255) NOT NULL DEFAULT '' COMMENT 'The file’s MIME type.',
  `filesize` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'The size of the file in bytes.',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A field indicating the status of the file. Two status are defined in core: temporary (0) and permanent (1). Temporary files older than DRUPAL_MAXIMUM_TEMP_FILE_AGE will be removed during a cron run.',
  `timestamp` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'UNIX timestamp for when the file was added.',
  PRIMARY KEY (`fid`),
  UNIQUE KEY `uri` (`uri`),
  KEY `uid` (`uid`),
  KEY `status` (`status`),
  KEY `timestamp` (`timestamp`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='Stores information for uploaded files.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `file_usage`
--

DROP TABLE IF EXISTS `file_usage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `file_usage` (
  `fid` int(10) unsigned NOT NULL COMMENT 'File ID.',
  `module` varchar(255) NOT NULL DEFAULT '' COMMENT 'The name of the module that is using the file.',
  `type` varchar(64) NOT NULL DEFAULT '' COMMENT 'The name of the object type in which the file is used.',
  `id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The primary key of the object using the file.',
  `count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The number of times this file is used by this object.',
  PRIMARY KEY (`fid`,`type`,`id`,`module`),
  KEY `type_id` (`type`,`id`),
  KEY `fid_count` (`fid`,`count`),
  KEY `fid_module` (`fid`,`module`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Track where a file is used.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `filter`
--

DROP TABLE IF EXISTS `filter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `filter` (
  `format` varchar(255) NOT NULL COMMENT 'Foreign key: The filter_format.format to which this filter is assigned.',
  `module` varchar(64) NOT NULL DEFAULT '' COMMENT 'The origin module of the filter.',
  `name` varchar(32) NOT NULL DEFAULT '' COMMENT 'Name of the filter being referenced.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'Weight of filter within format.',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT 'Filter enabled status. (1 = enabled, 0 = disabled)',
  `settings` longblob COMMENT 'A serialized array of name value pairs that store the filter settings for the specific format.',
  PRIMARY KEY (`format`,`name`),
  KEY `list` (`weight`,`module`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Table that maps filters (HTML corrector) to text formats ...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `filter_format`
--

DROP TABLE IF EXISTS `filter_format`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `filter_format` (
  `format` varchar(255) NOT NULL COMMENT 'Primary Key: Unique machine name of the format.',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'Name of the text format (Filtered HTML).',
  `cache` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Flag to indicate whether format is cacheable. (1 = cacheable, 0 = not cacheable)',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT 'The status of the text format. (1 = enabled, 0 = disabled)',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'Weight of text format to use when listing.',
  PRIMARY KEY (`format`),
  UNIQUE KEY `name` (`name`),
  KEY `status_weight` (`status`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores text formats: custom groupings of filters, such as...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `flood`
--

DROP TABLE IF EXISTS `flood`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flood` (
  `fid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique flood event ID.',
  `event` varchar(64) NOT NULL DEFAULT '' COMMENT 'Name of event (e.g. contact).',
  `identifier` varchar(128) NOT NULL DEFAULT '' COMMENT 'Identifier of the visitor, such as an IP address or hostname.',
  `timestamp` int(11) NOT NULL DEFAULT '0' COMMENT 'Timestamp of the event.',
  `expiration` int(11) NOT NULL DEFAULT '0' COMMENT 'Expiration timestamp. Expired events are purged on cron run.',
  PRIMARY KEY (`fid`),
  KEY `allow` (`event`,`identifier`,`timestamp`),
  KEY `purge` (`expiration`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Flood controls the threshold of events, such as the...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `history`
--

DROP TABLE IF EXISTS `history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `history` (
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT 'The users.uid that read the node nid.',
  `nid` int(11) NOT NULL DEFAULT '0' COMMENT 'The node.nid that was read.',
  `timestamp` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp at which the read occurred.',
  PRIMARY KEY (`uid`,`nid`),
  KEY `nid` (`nid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='A record of which users have read which nodes.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `image_effects`
--

DROP TABLE IF EXISTS `image_effects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `image_effects` (
  `ieid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for an image effect.',
  `isid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The image_styles.isid for an image style.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'The weight of the effect in the style.',
  `name` varchar(255) NOT NULL COMMENT 'The unique name of the effect to be executed.',
  `data` longblob NOT NULL COMMENT 'The configuration data for the effect.',
  PRIMARY KEY (`ieid`),
  KEY `isid` (`isid`),
  KEY `weight` (`weight`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Stores configuration options for image effects.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `image_styles`
--

DROP TABLE IF EXISTS `image_styles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `image_styles` (
  `isid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for an image style.',
  `name` varchar(255) NOT NULL COMMENT 'The style machine name.',
  `label` varchar(255) NOT NULL DEFAULT '' COMMENT 'The style administrative name.',
  PRIMARY KEY (`isid`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Stores configuration options for image styles.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `menu_custom`
--

DROP TABLE IF EXISTS `menu_custom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `menu_custom` (
  `menu_name` varchar(32) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique key for menu. This is used as a block delta so length is 32.',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'Menu title; displayed at top of block.',
  `description` text COMMENT 'Menu description.',
  PRIMARY KEY (`menu_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Holds definitions for top-level custom menus (for example...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `menu_links`
--

DROP TABLE IF EXISTS `menu_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `menu_links` (
  `menu_name` varchar(32) NOT NULL DEFAULT '' COMMENT 'The menu name. All links with the same menu name (such as ’navigation’) are part of the same menu.',
  `mlid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The menu link ID (mlid) is the integer primary key.',
  `plid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The parent link ID (plid) is the mlid of the link above in the hierarchy, or zero if the link is at the top level in its menu.',
  `link_path` varchar(255) NOT NULL DEFAULT '' COMMENT 'The Drupal path or external path this link points to.',
  `router_path` varchar(255) NOT NULL DEFAULT '' COMMENT 'For links corresponding to a Drupal path (external = 0), this connects the link to a menu_router.path for joins.',
  `link_title` varchar(255) NOT NULL DEFAULT '' COMMENT 'The text displayed for the link, which may be modified by a title callback stored in menu_router.',
  `options` blob COMMENT 'A serialized array of options to be passed to the url() or l() function, such as a query string or HTML attributes.',
  `module` varchar(255) NOT NULL DEFAULT 'system' COMMENT 'The name of the module that generated this link.',
  `hidden` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag for whether the link should be rendered in menus. (1 = a disabled menu item that may be shown on admin screens, -1 = a menu callback, 0 = a normal, visible link)',
  `external` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate if the link points to a full URL starting with a protocol, like http:// (1 = external, 0 = internal).',
  `has_children` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Flag indicating whether any links have this link as a parent (1 = children exist, 0 = no children).',
  `expanded` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Flag for whether this link should be rendered as expanded in menus - expanded links always have their child links displayed, instead of only when the link is in the active trail (1 = expanded, 0 = not expanded)',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'Link weight among links in the same menu at the same depth.',
  `depth` smallint(6) NOT NULL DEFAULT '0' COMMENT 'The depth relative to the top level. A link with plid == 0 will have depth == 1.',
  `customized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate that the user has manually created or edited the link (1 = customized, 0 = not customized).',
  `p1` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The first mlid in the materialized path. If N = depth, then pN must equal the mlid. If depth > 1 then p(N-1) must equal the plid. All pX where X > depth must equal zero. The columns p1 .. p9 are also called the parents.',
  `p2` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The second mlid in the materialized path. See p1.',
  `p3` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The third mlid in the materialized path. See p1.',
  `p4` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The fourth mlid in the materialized path. See p1.',
  `p5` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The fifth mlid in the materialized path. See p1.',
  `p6` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The sixth mlid in the materialized path. See p1.',
  `p7` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The seventh mlid in the materialized path. See p1.',
  `p8` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The eighth mlid in the materialized path. See p1.',
  `p9` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The ninth mlid in the materialized path. See p1.',
  `updated` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Flag that indicates that this link was generated during the update from Drupal 5.',
  PRIMARY KEY (`mlid`),
  KEY `path_menu` (`link_path`(128),`menu_name`),
  KEY `menu_plid_expand_child` (`menu_name`,`plid`,`expanded`,`has_children`),
  KEY `menu_parents` (`menu_name`,`p1`,`p2`,`p3`,`p4`,`p5`,`p6`,`p7`,`p8`,`p9`),
  KEY `router_path` (`router_path`(128))
) ENGINE=InnoDB AUTO_INCREMENT=552 DEFAULT CHARSET=utf8 COMMENT='Contains the individual links within a menu.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `menu_router`
--

DROP TABLE IF EXISTS `menu_router`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `menu_router` (
  `path` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: the Drupal path this entry describes',
  `load_functions` blob NOT NULL COMMENT 'A serialized array of function names (like node_load) to be called to load an object corresponding to a part of the current path.',
  `to_arg_functions` blob NOT NULL COMMENT 'A serialized array of function names (like user_uid_optional_to_arg) to be called to replace a part of the router path with another string.',
  `access_callback` varchar(255) NOT NULL DEFAULT '' COMMENT 'The callback which determines the access to this router path. Defaults to user_access.',
  `access_arguments` blob COMMENT 'A serialized array of arguments for the access callback.',
  `page_callback` varchar(255) NOT NULL DEFAULT '' COMMENT 'The name of the function that renders the page.',
  `page_arguments` blob COMMENT 'A serialized array of arguments for the page callback.',
  `delivery_callback` varchar(255) NOT NULL DEFAULT '' COMMENT 'The name of the function that sends the result of the page_callback function to the browser.',
  `fit` int(11) NOT NULL DEFAULT '0' COMMENT 'A numeric representation of how specific the path is.',
  `number_parts` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Number of parts in this router path.',
  `context` int(11) NOT NULL DEFAULT '0' COMMENT 'Only for local tasks (tabs) - the context of a local task to control its placement.',
  `tab_parent` varchar(255) NOT NULL DEFAULT '' COMMENT 'Only for local tasks (tabs) - the router path of the parent page (which may also be a local task).',
  `tab_root` varchar(255) NOT NULL DEFAULT '' COMMENT 'Router path of the closest non-tab parent page. For pages that are not local tasks, this will be the same as the path.',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'The title for the current page, or the title for the tab if this is a local task.',
  `title_callback` varchar(255) NOT NULL DEFAULT '' COMMENT 'A function which will alter the title. Defaults to t()',
  `title_arguments` varchar(255) NOT NULL DEFAULT '' COMMENT 'A serialized array of arguments for the title callback. If empty, the title will be used as the sole argument for the title callback.',
  `theme_callback` varchar(255) NOT NULL DEFAULT '' COMMENT 'A function which returns the name of the theme that will be used to render this page. If left empty, the default theme will be used.',
  `theme_arguments` varchar(255) NOT NULL DEFAULT '' COMMENT 'A serialized array of arguments for the theme callback.',
  `type` int(11) NOT NULL DEFAULT '0' COMMENT 'Numeric representation of the type of the menu item, like MENU_LOCAL_TASK.',
  `description` text NOT NULL COMMENT 'A description of this item.',
  `position` varchar(255) NOT NULL DEFAULT '' COMMENT 'The position of the block (left or right) on the system administration page for this item.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'Weight of the element. Lighter weights are higher up, heavier weights go down.',
  `include_file` mediumtext COMMENT 'The file to include for this element, usually the page callback function lives in this file.',
  PRIMARY KEY (`path`),
  KEY `fit` (`fit`),
  KEY `tab_parent` (`tab_parent`(64),`weight`,`title`),
  KEY `tab_root_weight_title` (`tab_root`(64),`weight`,`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Maps paths to various callbacks (access, page and title)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `node`
--

DROP TABLE IF EXISTS `node`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `node` (
  `nid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for a node.',
  `vid` int(10) unsigned DEFAULT NULL COMMENT 'The current node_revision.vid version identifier.',
  `type` varchar(32) NOT NULL DEFAULT '' COMMENT 'The node_type.type of this node.',
  `language` varchar(12) NOT NULL DEFAULT '' COMMENT 'The languages.language of this node.',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'The title of this node, always treated as non-markup plain text.',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT 'The users.uid that owns this node; initially, this is the user that created it.',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT 'Boolean indicating whether the node is published (visible to non-administrators).',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when the node was created.',
  `changed` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when the node was most recently saved.',
  `comment` int(11) NOT NULL DEFAULT '0' COMMENT 'Whether comments are allowed on this node: 0 = no, 1 = closed (read only), 2 = open (read/write).',
  `promote` int(11) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether the node should be displayed on the front page.',
  `sticky` int(11) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether the node should be displayed at the top of lists in which it appears.',
  `tnid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The translation set id for this node, which equals the node id of the source post in each set.',
  `translate` int(11) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this translation page needs to be updated.',
  PRIMARY KEY (`nid`),
  UNIQUE KEY `vid` (`vid`),
  KEY `node_changed` (`changed`),
  KEY `node_created` (`created`),
  KEY `node_frontpage` (`promote`,`status`,`sticky`,`created`),
  KEY `node_status_type` (`status`,`type`,`nid`),
  KEY `node_title_type` (`title`,`type`(4)),
  KEY `node_type` (`type`(4)),
  KEY `uid` (`uid`),
  KEY `tnid` (`tnid`),
  KEY `translate` (`translate`),
  KEY `language` (`language`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='The base table for nodes.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `node_access`
--

DROP TABLE IF EXISTS `node_access`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `node_access` (
  `nid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The node.nid this record affects.',
  `gid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The grant ID a user must possess in the specified realm to gain this row’s privileges on the node.',
  `realm` varchar(255) NOT NULL DEFAULT '' COMMENT 'The realm in which the user must possess the grant ID. Each node access node can define one or more realms.',
  `grant_view` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether a user with the realm/grant pair can view this node.',
  `grant_update` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether a user with the realm/grant pair can edit this node.',
  `grant_delete` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether a user with the realm/grant pair can delete this node.',
  PRIMARY KEY (`nid`,`gid`,`realm`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Identifies which realm/grant pairs a user must possess in...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `node_comment_statistics`
--

DROP TABLE IF EXISTS `node_comment_statistics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `node_comment_statistics` (
  `nid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The node.nid for which the statistics are compiled.',
  `cid` int(11) NOT NULL DEFAULT '0' COMMENT 'The comment.cid of the last comment.',
  `last_comment_timestamp` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp of the last comment that was posted within this node, from comment.changed.',
  `last_comment_name` varchar(60) DEFAULT NULL COMMENT 'The name of the latest author to post a comment on this node, from comment.name.',
  `last_comment_uid` int(11) NOT NULL DEFAULT '0' COMMENT 'The user ID of the latest author to post a comment on this node, from comment.uid.',
  `comment_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The total number of comments on this node.',
  PRIMARY KEY (`nid`),
  KEY `node_comment_timestamp` (`last_comment_timestamp`),
  KEY `comment_count` (`comment_count`),
  KEY `last_comment_uid` (`last_comment_uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Maintains statistics of node and comments posts to show ...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `node_revision`
--

DROP TABLE IF EXISTS `node_revision`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `node_revision` (
  `nid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The node this version belongs to.',
  `vid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for this version.',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT 'The users.uid that created this version.',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'The title of this version.',
  `log` longtext NOT NULL COMMENT 'The log entry explaining the changes in this version.',
  `timestamp` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when this version was created.',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT 'Boolean indicating whether the node (at the time of this revision) is published (visible to non-administrators).',
  `comment` int(11) NOT NULL DEFAULT '0' COMMENT 'Whether comments are allowed on this node (at the time of this revision): 0 = no, 1 = closed (read only), 2 = open (read/write).',
  `promote` int(11) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether the node (at the time of this revision) should be displayed on the front page.',
  `sticky` int(11) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether the node (at the time of this revision) should be displayed at the top of lists in which it appears.',
  PRIMARY KEY (`vid`),
  KEY `nid` (`nid`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='Stores information about each saved version of a node.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `node_type`
--

DROP TABLE IF EXISTS `node_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `node_type` (
  `type` varchar(32) NOT NULL COMMENT 'The machine-readable name of this type.',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The human-readable name of this type.',
  `base` varchar(255) NOT NULL COMMENT 'The base string used to construct callbacks corresponding to this node type.',
  `module` varchar(255) NOT NULL COMMENT 'The module defining this node type.',
  `description` mediumtext NOT NULL COMMENT 'A brief description of this type.',
  `help` mediumtext NOT NULL COMMENT 'Help information shown to the user when creating a node of this type.',
  `has_title` tinyint(3) unsigned NOT NULL COMMENT 'Boolean indicating whether this type uses the node.title field.',
  `title_label` varchar(255) NOT NULL DEFAULT '' COMMENT 'The label displayed for the title field on the edit form.',
  `custom` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this type is defined by a module (FALSE) or by a user via Add content type (TRUE).',
  `modified` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this type has been modified by an administrator; currently not used in any way.',
  `locked` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether the administrator can change the machine name of this type.',
  `disabled` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether the node type is disabled.',
  `orig_type` varchar(255) NOT NULL DEFAULT '' COMMENT 'The original machine-readable name of this node type. This may be different from the current type name if the locked field is 0.',
  PRIMARY KEY (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores information about all defined node types.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `queue`
--

DROP TABLE IF EXISTS `queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `queue` (
  `item_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique item ID.',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The queue name.',
  `data` longblob COMMENT 'The arbitrary data for the item.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'Timestamp when the claim lease expires on the item.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'Timestamp when the item was created.',
  PRIMARY KEY (`item_id`),
  KEY `name_created` (`name`,`created`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8 COMMENT='Stores items in queues.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rdf_mapping`
--

DROP TABLE IF EXISTS `rdf_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rdf_mapping` (
  `type` varchar(128) NOT NULL COMMENT 'The name of the entity type a mapping applies to (node, user, comment, etc.).',
  `bundle` varchar(128) NOT NULL COMMENT 'The name of the bundle a mapping applies to.',
  `mapping` longblob COMMENT 'The serialized mapping of the bundle type and fields to RDF terms.',
  PRIMARY KEY (`type`,`bundle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores custom RDF mappings for user defined content types...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `registry`
--

DROP TABLE IF EXISTS `registry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `registry` (
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The name of the function, class, or interface.',
  `type` varchar(9) NOT NULL DEFAULT '' COMMENT 'Either function or class or interface.',
  `filename` varchar(255) NOT NULL COMMENT 'Name of the file.',
  `module` varchar(255) NOT NULL DEFAULT '' COMMENT 'Name of the module the file belongs to.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'The order in which this module’s hooks should be invoked relative to other modules. Equal-weighted modules are ordered by name.',
  PRIMARY KEY (`name`,`type`),
  KEY `hook` (`type`,`weight`,`module`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Each record is a function, class, or interface name and...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `registry_file`
--

DROP TABLE IF EXISTS `registry_file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `registry_file` (
  `filename` varchar(255) NOT NULL COMMENT 'Path to the file.',
  `hash` varchar(64) NOT NULL COMMENT 'sha-256 hash of the file’s contents when last parsed.',
  PRIMARY KEY (`filename`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Files parsed to build the registry.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role` (
  `rid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique role ID.',
  `name` varchar(64) NOT NULL DEFAULT '' COMMENT 'Unique role name.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'The weight of this role in listings and the user interface.',
  PRIMARY KEY (`rid`),
  UNIQUE KEY `name` (`name`),
  KEY `name_weight` (`name`,`weight`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='Stores user roles.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `role_permission`
--

DROP TABLE IF EXISTS `role_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role_permission` (
  `rid` int(10) unsigned NOT NULL COMMENT 'Foreign Key: role.rid.',
  `permission` varchar(128) NOT NULL DEFAULT '' COMMENT 'A single permission granted to the role identified by rid.',
  `module` varchar(255) NOT NULL DEFAULT '' COMMENT 'The module declaring the permission.',
  PRIMARY KEY (`rid`,`permission`),
  KEY `permission` (`permission`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores the permissions assigned to user roles.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rules_config`
--

DROP TABLE IF EXISTS `rules_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rules_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'The internal identifier for any configuration.',
  `name` varchar(64) NOT NULL COMMENT 'The name of the configuration.',
  `label` varchar(255) NOT NULL DEFAULT 'unlabeled' COMMENT 'The label of the configuration.',
  `plugin` varchar(127) NOT NULL COMMENT 'The name of the plugin of this configuration.',
  `active` int(11) NOT NULL DEFAULT '1' COMMENT 'Boolean indicating whether the configuration is active. Usage depends on how the using module makes use of it.',
  `weight` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Weight of the configuration. Usage depends on how the using module makes use of it.',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT 'The exportable status of the entity.',
  `dirty` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Dirty configurations fail the integrity check, e.g. due to missing dependencies.',
  `module` varchar(255) DEFAULT NULL COMMENT 'The name of the providing module if the entity has been defined in code.',
  `owner` varchar(255) NOT NULL DEFAULT 'rules' COMMENT 'The name of the module via which the rule has been configured.',
  `access_exposed` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Whether to use a permission to control access for using components.',
  `data` longblob COMMENT 'Everything else, serialized.',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `plugin` (`plugin`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rules_dependencies`
--

DROP TABLE IF EXISTS `rules_dependencies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rules_dependencies` (
  `id` int(10) unsigned NOT NULL COMMENT 'The primary identifier of the configuration.',
  `module` varchar(255) NOT NULL COMMENT 'The name of the module that is required for the configuration.',
  PRIMARY KEY (`id`,`module`),
  KEY `module` (`module`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rules_tags`
--

DROP TABLE IF EXISTS `rules_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rules_tags` (
  `id` int(10) unsigned NOT NULL COMMENT 'The primary identifier of the configuration.',
  `tag` varchar(255) NOT NULL COMMENT 'The tag string associated with this configuration',
  PRIMARY KEY (`id`,`tag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rules_trigger`
--

DROP TABLE IF EXISTS `rules_trigger`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rules_trigger` (
  `id` int(10) unsigned NOT NULL COMMENT 'The primary identifier of the configuration.',
  `event` varchar(127) NOT NULL DEFAULT '' COMMENT 'The name of the event on which the configuration should be triggered.',
  PRIMARY KEY (`id`,`event`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `search_dataset`
--

DROP TABLE IF EXISTS `search_dataset`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `search_dataset` (
  `sid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Search item ID, e.g. node ID for nodes.',
  `type` varchar(16) NOT NULL COMMENT 'Type of item, e.g. node.',
  `data` longtext NOT NULL COMMENT 'List of space-separated words from the item.',
  `reindex` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Set to force node reindexing.',
  PRIMARY KEY (`sid`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores items that will be searched.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `search_index`
--

DROP TABLE IF EXISTS `search_index`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `search_index` (
  `word` varchar(50) NOT NULL DEFAULT '' COMMENT 'The search_total.word that is associated with the search item.',
  `sid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The search_dataset.sid of the searchable item to which the word belongs.',
  `type` varchar(16) NOT NULL COMMENT 'The search_dataset.type of the searchable item to which the word belongs.',
  `score` float DEFAULT NULL COMMENT 'The numeric score of the word, higher being more important.',
  PRIMARY KEY (`word`,`sid`,`type`),
  KEY `sid_type` (`sid`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores the search index, associating words, items and...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `search_node_links`
--

DROP TABLE IF EXISTS `search_node_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `search_node_links` (
  `sid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The search_dataset.sid of the searchable item containing the link to the node.',
  `type` varchar(16) NOT NULL DEFAULT '' COMMENT 'The search_dataset.type of the searchable item containing the link to the node.',
  `nid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The node.nid that this item links to.',
  `caption` longtext COMMENT 'The text used to link to the node.nid.',
  PRIMARY KEY (`sid`,`type`,`nid`),
  KEY `nid` (`nid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores items (like nodes) that link to other nodes, used...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `search_total`
--

DROP TABLE IF EXISTS `search_total`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `search_total` (
  `word` varchar(50) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique word in the search index.',
  `count` float DEFAULT NULL COMMENT 'The count of the word in the index using Zipf’s law to equalize the probability distribution.',
  PRIMARY KEY (`word`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores search totals for words.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `semaphore`
--

DROP TABLE IF EXISTS `semaphore`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `semaphore` (
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique name.',
  `value` varchar(255) NOT NULL DEFAULT '' COMMENT 'A value for the semaphore.',
  `expire` double NOT NULL COMMENT 'A Unix timestamp with microseconds indicating when the semaphore should expire.',
  PRIMARY KEY (`name`),
  KEY `value` (`value`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Table for holding semaphores, locks, flags, etc. that...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sequences`
--

DROP TABLE IF EXISTS `sequences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sequences` (
  `value` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The value of the sequence.',
  PRIMARY KEY (`value`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='Stores IDs.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sessions` (
  `uid` int(10) unsigned NOT NULL COMMENT 'The users.uid corresponding to a session, or 0 for anonymous user.',
  `sid` varchar(128) NOT NULL COMMENT 'A session ID. The value is generated by Drupal’s session handlers.',
  `ssid` varchar(128) NOT NULL DEFAULT '' COMMENT 'Secure session ID. The value is generated by Drupal’s session handlers.',
  `hostname` varchar(128) NOT NULL DEFAULT '' COMMENT 'The IP address that last used this session ID (sid).',
  `timestamp` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when this session last requested a page. Old records are purged by PHP automatically.',
  `cache` int(11) NOT NULL DEFAULT '0' COMMENT 'The time of this user’s last post. This is used when the site has specified a minimum_cache_lifetime. See cache_get().',
  `session` longblob COMMENT 'The serialized contents of $_SESSION, an array of name/value pairs that persists across page requests by this session ID. Drupal loads $_SESSION from here at the start of each request and saves it at the end.',
  PRIMARY KEY (`sid`,`ssid`),
  KEY `timestamp` (`timestamp`),
  KEY `uid` (`uid`),
  KEY `ssid` (`ssid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Drupal’s session handlers read and write into the...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `shortcut_set`
--

DROP TABLE IF EXISTS `shortcut_set`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shortcut_set` (
  `set_name` varchar(32) NOT NULL DEFAULT '' COMMENT 'Primary Key: The menu_links.menu_name under which the set’s links are stored.',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'The title of the set.',
  PRIMARY KEY (`set_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores information about sets of shortcuts links.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `shortcut_set_users`
--

DROP TABLE IF EXISTS `shortcut_set_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shortcut_set_users` (
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The users.uid for this set.',
  `set_name` varchar(32) NOT NULL DEFAULT '' COMMENT 'The shortcut_set.set_name that will be displayed for this user.',
  PRIMARY KEY (`uid`),
  KEY `set_name` (`set_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Maps users to shortcut sets.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `system`
--

DROP TABLE IF EXISTS `system`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `system` (
  `filename` varchar(255) NOT NULL DEFAULT '' COMMENT 'The path of the primary file for this item, relative to the Drupal root; e.g. modules/node/node.module.',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The name of the item; e.g. node.',
  `type` varchar(12) NOT NULL DEFAULT '' COMMENT 'The type of the item, either module, theme, or theme_engine.',
  `owner` varchar(255) NOT NULL DEFAULT '' COMMENT 'A theme’s ’parent’ . Can be either a theme or an engine.',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether or not this item is enabled.',
  `bootstrap` int(11) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether this module is loaded during Drupal’s early bootstrapping phase (e.g. even before the page cache is consulted).',
  `schema_version` smallint(6) NOT NULL DEFAULT '-1' COMMENT 'The module’s database schema version number. -1 if the module is not installed (its tables do not exist); 0 or the largest N of the module’s hook_update_N() function that has either been run or existed when the module was first installed.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'The order in which this module’s hooks should be invoked relative to other modules. Equal-weighted modules are ordered by name.',
  `info` blob COMMENT 'A serialized array containing information from the module’s .info file; keys can include name, description, package, version, core, dependencies, and php.',
  PRIMARY KEY (`filename`),
  KEY `system_list` (`status`,`bootstrap`,`type`,`weight`,`name`),
  KEY `type_name` (`type`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='A list of all modules, themes, and theme engines that are...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `taxonomy_index`
--

DROP TABLE IF EXISTS `taxonomy_index`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `taxonomy_index` (
  `nid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The node.nid this record tracks.',
  `tid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The term ID.',
  `sticky` tinyint(4) DEFAULT '0' COMMENT 'Boolean indicating whether the node is sticky.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when the node was created.',
  KEY `term_node` (`tid`,`sticky`,`created`),
  KEY `nid` (`nid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Maintains denormalized information about node/term...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `taxonomy_term_data`
--

DROP TABLE IF EXISTS `taxonomy_term_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `taxonomy_term_data` (
  `tid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique term ID.',
  `vid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The taxonomy_vocabulary.vid of the vocabulary to which the term is assigned.',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The term name.',
  `description` longtext COMMENT 'A description of the term.',
  `format` varchar(255) DEFAULT NULL COMMENT 'The filter_format.format of the description.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'The weight of this term in relation to other terms.',
  PRIMARY KEY (`tid`),
  KEY `taxonomy_tree` (`vid`,`weight`,`name`),
  KEY `vid_name` (`vid`,`name`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores term information.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `taxonomy_term_hierarchy`
--

DROP TABLE IF EXISTS `taxonomy_term_hierarchy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `taxonomy_term_hierarchy` (
  `tid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Primary Key: The taxonomy_term_data.tid of the term.',
  `parent` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Primary Key: The taxonomy_term_data.tid of the term’s parent. 0 indicates no parent.',
  PRIMARY KEY (`tid`,`parent`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores the hierarchical relationship between terms.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `taxonomy_vocabulary`
--

DROP TABLE IF EXISTS `taxonomy_vocabulary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `taxonomy_vocabulary` (
  `vid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique vocabulary ID.',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'Name of the vocabulary.',
  `machine_name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The vocabulary machine name.',
  `description` longtext COMMENT 'Description of the vocabulary.',
  `hierarchy` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'The type of hierarchy allowed within the vocabulary. (0 = disabled, 1 = single, 2 = multiple)',
  `module` varchar(255) NOT NULL DEFAULT '' COMMENT 'The module which created the vocabulary.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'The weight of this vocabulary in relation to other vocabularies.',
  PRIMARY KEY (`vid`),
  UNIQUE KEY `machine_name` (`machine_name`),
  KEY `list` (`weight`,`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Stores vocabulary information.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `url_alias`
--

DROP TABLE IF EXISTS `url_alias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `url_alias` (
  `pid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'A unique path alias identifier.',
  `source` varchar(255) NOT NULL DEFAULT '' COMMENT 'The Drupal path this alias is for; e.g. node/12.',
  `alias` varchar(255) NOT NULL DEFAULT '' COMMENT 'The alias for this path; e.g. title-of-the-story.',
  `language` varchar(12) NOT NULL DEFAULT '' COMMENT 'The language this alias is for; if ’und’, the alias will be used for unknown languages. Each Drupal path can have an alias for each supported language.',
  PRIMARY KEY (`pid`),
  KEY `alias_language_pid` (`alias`,`language`,`pid`),
  KEY `source_language_pid` (`source`,`language`,`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='A list of URL aliases for Drupal paths; a user may visit...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Primary Key: Unique user ID.',
  `name` varchar(60) NOT NULL DEFAULT '' COMMENT 'Unique user name.',
  `pass` varchar(128) NOT NULL DEFAULT '' COMMENT 'User’s password (hashed).',
  `mail` varchar(254) DEFAULT '' COMMENT 'User’s e-mail address.',
  `theme` varchar(255) NOT NULL DEFAULT '' COMMENT 'User’s default theme.',
  `signature` varchar(255) NOT NULL DEFAULT '' COMMENT 'User’s signature.',
  `signature_format` varchar(255) DEFAULT NULL COMMENT 'The filter_format.format of the signature.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'Timestamp for when user was created.',
  `access` int(11) NOT NULL DEFAULT '0' COMMENT 'Timestamp for previous time user accessed the site.',
  `login` int(11) NOT NULL DEFAULT '0' COMMENT 'Timestamp for user’s last login.',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Whether the user is active(1) or blocked(0).',
  `timezone` varchar(32) DEFAULT NULL COMMENT 'User’s time zone.',
  `language` varchar(12) NOT NULL DEFAULT '' COMMENT 'User’s default language.',
  `picture` int(11) NOT NULL DEFAULT '0' COMMENT 'Foreign key: file_managed.fid of user’s picture.',
  `init` varchar(254) DEFAULT '' COMMENT 'E-mail address used for initial account creation.',
  `data` longblob COMMENT 'A serialized array of name value pairs that are related to the user. Any form values posted during user edit are stored and are loaded into the $user object during user_load(). Use of this field is discouraged and it will likely disappear in a future...',
  PRIMARY KEY (`uid`),
  UNIQUE KEY `name` (`name`),
  KEY `access` (`access`),
  KEY `created` (`created`),
  KEY `mail` (`mail`),
  KEY `picture` (`picture`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores user data.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users_roles`
--

DROP TABLE IF EXISTS `users_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_roles` (
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Primary Key: users.uid for user.',
  `rid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Primary Key: role.rid for role.',
  PRIMARY KEY (`uid`,`rid`),
  KEY `rid` (`rid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Maps users to roles.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `variable`
--

DROP TABLE IF EXISTS `variable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `variable` (
  `name` varchar(128) NOT NULL DEFAULT '' COMMENT 'The name of the variable.',
  `value` longblob NOT NULL COMMENT 'The value of the variable.',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Named variable/value pairs created by Drupal core or any...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `views_display`
--

DROP TABLE IF EXISTS `views_display`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `views_display` (
  `vid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The view this display is attached to.',
  `id` varchar(64) NOT NULL DEFAULT '' COMMENT 'An identifier for this display; usually generated from the display_plugin, so should be something like page or page_1 or block_2, etc.',
  `display_title` varchar(64) NOT NULL DEFAULT '' COMMENT 'The title of the display, viewable by the administrator.',
  `display_plugin` varchar(64) NOT NULL DEFAULT '' COMMENT 'The type of the display. Usually page, block or embed, but is pluggable so may be other things.',
  `position` int(11) DEFAULT '0' COMMENT 'The order in which this display is loaded.',
  `display_options` longtext COMMENT 'A serialized array of options for this display; it contains options that are generally only pertinent to that display plugin type.',
  PRIMARY KEY (`vid`,`id`),
  KEY `vid` (`vid`,`position`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores information about each display attached to a view.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `views_view`
--

DROP TABLE IF EXISTS `views_view`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `views_view` (
  `vid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The view ID of the field, defined by the database.',
  `name` varchar(128) NOT NULL DEFAULT '' COMMENT 'The unique name of the view. This is the primary field views are loaded from, and is used so that views may be internal and not necessarily in the database. May only be alphanumeric characters plus underscores.',
  `description` varchar(255) DEFAULT '' COMMENT 'A description of the view for the admin interface.',
  `tag` varchar(255) DEFAULT '' COMMENT 'A tag used to group/sort views in the admin interface',
  `base_table` varchar(64) NOT NULL DEFAULT '' COMMENT 'What table this view is based on, such as node, user, comment, or term.',
  `human_name` varchar(255) DEFAULT '' COMMENT 'A human readable name used to be displayed in the admin interface',
  `core` int(11) DEFAULT '0' COMMENT 'Stores the drupal core version of the view.',
  PRIMARY KEY (`vid`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores the general data for a view.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `watchdog`
--

DROP TABLE IF EXISTS `watchdog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `watchdog` (
  `wid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique watchdog event ID.',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT 'The users.uid of the user who triggered the event.',
  `type` varchar(64) NOT NULL DEFAULT '' COMMENT 'Type of log message, for example "user" or "page not found."',
  `message` longtext NOT NULL COMMENT 'Text of log message to be passed into the t() function.',
  `variables` longblob NOT NULL COMMENT 'Serialized array of variables that match the message string and that is passed into the t() function.',
  `severity` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'The severity level of the event; ranges from 0 (Emergency) to 7 (Debug)',
  `link` varchar(255) DEFAULT '' COMMENT 'Link to view the result of the event.',
  `location` text NOT NULL COMMENT 'URL of the origin of the event.',
  `referer` text COMMENT 'URL of referring page.',
  `hostname` varchar(128) NOT NULL DEFAULT '' COMMENT 'Hostname of the user who triggered the event.',
  `timestamp` int(11) NOT NULL DEFAULT '0' COMMENT 'Unix timestamp of when event occurred.',
  PRIMARY KEY (`wid`),
  KEY `type` (`type`),
  KEY `uid` (`uid`),
  KEY `severity` (`severity`)
) ENGINE=InnoDB AUTO_INCREMENT=181 DEFAULT CHARSET=utf8 COMMENT='Table that contains logs of all system events.';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-07-24 10:46:57
