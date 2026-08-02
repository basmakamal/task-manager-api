-- MariaDB dump 10.19  Distrib 10.4.32-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: task_manager
-- ------------------------------------------------------
-- Server version	10.4.32-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `cache`
--

DROP TABLE IF EXISTS `cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL,
  PRIMARY KEY (`key`),
  KEY `cache_expiration_index` (`expiration`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache`
--

LOCK TABLES `cache` WRITE;
/*!40000 ALTER TABLE `cache` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache_locks`
--

DROP TABLE IF EXISTS `cache_locks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL,
  PRIMARY KEY (`key`),
  KEY `cache_locks_expiration_index` (`expiration`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache_locks`
--

LOCK TABLES `cache_locks` WRITE;
/*!40000 ALTER TABLE `cache_locks` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache_locks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `failed_jobs`
--

LOCK TABLES `failed_jobs` WRITE;
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `job_batches`
--

DROP TABLE IF EXISTS `job_batches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job_batches`
--

LOCK TABLES `job_batches` WRITE;
/*!40000 ALTER TABLE `job_batches` DISABLE KEYS */;
/*!40000 ALTER TABLE `job_batches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) unsigned NOT NULL,
  `reserved_at` int(10) unsigned DEFAULT NULL,
  `available_at` int(10) unsigned NOT NULL,
  `created_at` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobs`
--

LOCK TABLES `jobs` WRITE;
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'0001_01_01_000000_create_users_table',1),(2,'0001_01_01_000001_create_cache_table',1),(3,'0001_01_01_000002_create_jobs_table',1),(4,'2026_08_02_023751_create_personal_access_tokens_table',1),(5,'2026_08_02_025014_create_notifications_table',1),(6,'2026_08_02_030000_create_projects_table',1),(7,'2026_08_02_031500_create_tasks_table',1),(8,'2026_08_02_040000_add_overdue_notified_at_to_tasks_table',1);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notifications` (
  `id` char(36) NOT NULL,
  `type` varchar(255) NOT NULL,
  `notifiable_type` varchar(255) NOT NULL,
  `notifiable_id` bigint(20) unsigned NOT NULL,
  `data` text NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `notifications_notifiable_type_notifiable_id_index` (`notifiable_type`,`notifiable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_reset_tokens`
--

LOCK TABLES `password_reset_tokens` WRITE;
/*!40000 ALTER TABLE `password_reset_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_reset_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personal_access_tokens`
--

DROP TABLE IF EXISTS `personal_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) unsigned NOT NULL,
  `name` text NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`),
  KEY `personal_access_tokens_expires_at_index` (`expires_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personal_access_tokens`
--

LOCK TABLES `personal_access_tokens` WRITE;
/*!40000 ALTER TABLE `personal_access_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `personal_access_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projects`
--

DROP TABLE IF EXISTS `projects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `projects` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `projects_user_id_status_index` (`user_id`,`status`),
  CONSTRAINT `projects_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projects`
--

LOCK TABLES `projects` WRITE;
/*!40000 ALTER TABLE `projects` DISABLE KEYS */;
INSERT INTO `projects` VALUES (1,1,'De-engineered multimedia capacity','Tempore qui dolores autem voluptates perspiciatis dolore officiis nobis. Odit minus modi rerum voluptas. Non laboriosam temporibus officia.','archived','2026-08-01 23:58:44','2026-08-01 23:58:44',NULL),(2,1,'Up-sized client-driven project','Consectetur non nam animi eius ut delectus aut deserunt. Reprehenderit repellendus similique quidem ullam neque amet. Et assumenda unde aut eos enim dolorem.','completed','2026-08-01 23:58:44','2026-08-01 23:58:44',NULL),(3,1,'Organic foreground application',NULL,'active','2026-08-01 23:58:44','2026-08-01 23:58:44',NULL),(4,1,'Facetoface full-range success','Mollitia qui architecto non repudiandae. Numquam et suscipit optio ab.','completed','2026-08-01 23:58:44','2026-08-01 23:58:44',NULL),(5,1,'Synchronised mission-critical knowledgebase','Corporis corporis iste nihil velit dolorum ut. Facere vitae nisi qui laboriosam fuga iste natus. Aliquam quia doloribus omnis consequatur magni quisquam dolores.','archived','2026-08-01 23:58:44','2026-08-01 23:58:44',NULL),(6,2,'Profound asymmetric array','Earum minus ex neque id. Ea nesciunt aut ipsum dolores quam. Ab amet iste dolores ratione. Vel minima autem rerum et nihil perspiciatis.','archived','2026-08-01 23:58:44','2026-08-01 23:58:44',NULL),(7,2,'Fully-configurable multimedia contingency','Incidunt aspernatur laboriosam dignissimos est rerum aut. Molestiae molestiae commodi non minus minima quia. Quae velit quis natus. Alias eum tenetur magnam quos.','archived','2026-08-01 23:58:44','2026-08-01 23:58:44',NULL);
/*!40000 ALTER TABLE `projects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tasks`
--

DROP TABLE IF EXISTS `tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tasks` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `project_id` bigint(20) unsigned NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `priority` varchar(255) NOT NULL DEFAULT 'medium',
  `status` varchar(255) NOT NULL DEFAULT 'todo',
  `due_date` date DEFAULT NULL,
  `overdue_notified_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tasks_project_id_status_index` (`project_id`,`status`),
  KEY `tasks_priority_index` (`priority`),
  KEY `tasks_due_date_index` (`due_date`),
  CONSTRAINT `tasks_project_id_foreign` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tasks`
--

LOCK TABLES `tasks` WRITE;
/*!40000 ALTER TABLE `tasks` DISABLE KEYS */;
INSERT INTO `tasks` VALUES (1,1,'Nulla voluptate minima dolor delectus consequuntur.','Debitis sit libero est corrupti consequatur odio eos numquam. Ut molestias atque tempore excepturi. Numquam veritatis dolorum tempora at ea. Animi voluptatum eveniet reiciendis qui vel consequuntur iste.','medium','done','2026-09-01',NULL,'2026-08-01 23:58:44','2026-08-01 23:58:44',NULL),(2,1,'Deserunt id aut aut molestiae velit.','Facere quos sint ratione fuga. Repellendus est sunt sit molestiae esse culpa enim nihil. Sint doloremque placeat quo incidunt distinctio. Rerum omnis aspernatur dignissimos porro sapiente aspernatur.','high','todo','2026-07-31',NULL,'2026-08-01 23:58:44','2026-08-01 23:58:44',NULL),(3,1,'Optio commodi incidunt aspernatur ex hic.',NULL,'medium','todo',NULL,NULL,'2026-08-01 23:58:44','2026-08-01 23:58:44',NULL),(4,1,'Eum nulla sed qui.','Nam magni iusto dolor recusandae facere accusamus ut. Assumenda consequuntur libero aut quia. Qui dolorem voluptas eos aliquid qui. Perspiciatis ut qui tenetur. Mollitia perferendis consequuntur doloribus a quae consequatur.','medium','todo','2026-08-20',NULL,'2026-08-01 23:58:44','2026-08-01 23:58:44',NULL),(5,1,'Dolore deserunt at voluptatem vel.','Dolores consequatur aut id nostrum dignissimos ducimus. Autem rerum nobis fuga. Impedit aut sequi possimus. Atque quis nam et quia et consequatur qui.','low','done','2026-07-25',NULL,'2026-08-01 23:58:44','2026-08-01 23:58:44',NULL),(6,2,'Qui cupiditate id odio repellendus sed.','Ut soluta perspiciatis in iure inventore itaque. Autem nam eum modi nobis eum. Aut non odit sunt. Tempore dolorum mollitia quidem animi voluptate voluptates asperiores asperiores.','low','todo',NULL,NULL,'2026-08-01 23:58:44','2026-08-01 23:58:44',NULL),(7,2,'Facilis aut voluptatem tempora quo.','Qui ullam dolor quisquam quis molestiae. Qui asperiores expedita occaecati. Reprehenderit dolores distinctio quo in sunt fuga iure provident. Sed voluptas aut enim temporibus qui doloremque.','high','todo','2026-08-06',NULL,'2026-08-01 23:58:44','2026-08-01 23:58:44',NULL),(8,2,'Enim quidem quisquam quos eligendi.','Dolores quam tempora esse perspiciatis. Aut veritatis et et id. Et fugit eius ut eaque voluptatum.','low','in_progress',NULL,NULL,'2026-08-01 23:58:44','2026-08-01 23:58:44',NULL),(9,3,'Ipsa repellat sit omnis sit.','Non sequi optio odio et dolore sunt ipsa. Minus voluptas nemo libero sed sunt minus illo. Enim ducimus molestias dolorem ratione ex.','medium','in_progress','2026-08-17',NULL,'2026-08-01 23:58:44','2026-08-01 23:58:44',NULL),(10,3,'Ullam asperiores esse dignissimos.',NULL,'high','done',NULL,NULL,'2026-08-01 23:58:44','2026-08-01 23:58:44',NULL),(11,3,'Ullam exercitationem voluptatem.','Minima eos possimus dolor dolores ut quo fugiat. Sunt voluptas omnis occaecati rerum veniam. Magnam accusamus voluptatem hic voluptas blanditiis esse.','low','in_progress','2026-08-16',NULL,'2026-08-01 23:58:44','2026-08-01 23:58:44',NULL),(12,4,'Et velit perspiciatis itaque repellat.','Ut aut sit sit quia sed sit corporis. Quas quia aut sed eius. Et ab quia totam occaecati cumque. Corrupti laborum non quis ducimus deserunt corporis quos.','medium','done','2026-08-29',NULL,'2026-08-01 23:58:44','2026-08-01 23:58:44',NULL),(13,4,'Alias voluptate quibusdam saepe.',NULL,'low','todo',NULL,NULL,'2026-08-01 23:58:44','2026-08-01 23:58:44',NULL),(14,4,'Eaque qui quis.',NULL,'low','todo','2026-08-02',NULL,'2026-08-01 23:58:44','2026-08-01 23:58:44',NULL),(15,5,'Nesciunt perferendis deleniti qui.','Quia minima praesentium atque omnis. Numquam laborum earum architecto aut doloremque. Et ut facere nulla odit doloribus est.','high','todo','2026-08-10',NULL,'2026-08-01 23:58:44','2026-08-01 23:58:44',NULL),(16,5,'Nobis quibusdam reprehenderit.','Cum voluptas sapiente nostrum aut eum recusandae officia nisi. Quis a aspernatur voluptatum et autem. Quia atque asperiores quis perferendis. Aspernatur cum ipsum fugiat quas.','medium','in_progress','2026-07-30',NULL,'2026-08-01 23:58:44','2026-08-01 23:58:44',NULL),(17,5,'Molestias enim in dicta ut.','Et rerum aut aut omnis est qui. Itaque sit et eveniet quis saepe voluptatem incidunt. In voluptate maiores non ut quas sapiente.','high','todo','2026-08-30',NULL,'2026-08-01 23:58:44','2026-08-01 23:58:44',NULL),(18,5,'Perspiciatis est et.','Sed laborum corrupti eaque delectus in ut incidunt. Sed nesciunt dolor et quod a. Quam voluptas eum ut ut est aut praesentium voluptatibus. Esse adipisci adipisci magni qui ipsum. Corrupti aut rerum recusandae.','medium','done',NULL,NULL,'2026-08-01 23:58:44','2026-08-01 23:58:44',NULL),(19,5,'Consequatur ut culpa.',NULL,'medium','in_progress','2026-07-24',NULL,'2026-08-01 23:58:44','2026-08-01 23:58:44',NULL),(20,5,'Consequatur voluptatem ea nesciunt et.',NULL,'low','in_progress','2026-08-28',NULL,'2026-08-01 23:58:44','2026-08-01 23:58:44',NULL),(21,1,'Sed reiciendis omnis voluptates amet quo.',NULL,'medium','todo','2026-07-22',NULL,'2026-08-01 23:58:44','2026-08-01 23:58:44',NULL),(22,1,'Sequi ut exercitationem vel officiis in.','Suscipit architecto distinctio et ut. Magnam voluptatem quaerat hic in qui. Veniam quaerat veritatis excepturi officia quas voluptatem.','medium','todo','2026-07-19',NULL,'2026-08-01 23:58:44','2026-08-01 23:58:44',NULL),(23,1,'Perferendis eos pariatur non.','Sunt sint explicabo error omnis odit consectetur aut. Et est sit eligendi modi est aut. Reprehenderit quasi reiciendis sit odit dolores et. Eligendi asperiores officia eligendi repellat ipsum alias.','medium','todo','2026-07-27',NULL,'2026-08-01 23:58:44','2026-08-01 23:58:44',NULL),(24,6,'Qui ullam libero sequi sed.',NULL,'medium','in_progress','2026-07-19',NULL,'2026-08-01 23:58:44','2026-08-01 23:58:44',NULL),(25,6,'Perspiciatis minima in excepturi.','At ut ipsa tempore sequi veniam. Placeat delectus tempore molestias ut quo cum impedit. Doloribus possimus nesciunt id autem. Ratione quia ex in unde aut corrupti. Enim aspernatur ipsa dolor sunt quae placeat porro.','high','done',NULL,NULL,'2026-08-01 23:58:44','2026-08-01 23:58:44',NULL),(26,6,'Numquam saepe voluptatibus alias.','Iste nulla quaerat cupiditate eum minima. Nemo sit qui voluptas non incidunt. Ut aut exercitationem nihil pariatur. Dolores repudiandae magni libero sit aspernatur delectus voluptatum. Et natus pariatur sit.','high','done','2026-08-06',NULL,'2026-08-01 23:58:44','2026-08-01 23:58:44',NULL),(27,7,'Natus est blanditiis alias sunt.',NULL,'low','todo','2026-08-07',NULL,'2026-08-01 23:58:44','2026-08-01 23:58:44',NULL),(28,7,'Quasi excepturi dignissimos quia optio ut.','Earum dolorem qui enim dolorem quia at ut. Doloremque autem voluptatem nisi minus nesciunt enim. Eum magni maiores et laudantium. Sed molestiae perferendis quo quae molestiae.','low','done','2026-08-04',NULL,'2026-08-01 23:58:44','2026-08-01 23:58:44',NULL),(29,7,'Voluptas porro id error repudiandae.','Voluptatibus ipsa facilis animi officiis. Consequatur delectus vel non dolores iusto autem sunt. Voluptatibus accusamus eius magni accusamus voluptates. Aut odit necessitatibus libero nulla.','high','todo','2026-08-21',NULL,'2026-08-01 23:58:44','2026-08-01 23:58:44',NULL);
/*!40000 ALTER TABLE `tasks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Demo User','demo@example.com','2026-08-01 23:58:44','$2y$12$0moNWAYYBExDRWtzh2IireqMq0P6R8pe5JxTdyBjU9FYClKWC.EIW','t863DVaSMt','2026-08-01 23:58:44','2026-08-01 23:58:44'),(2,'Jane Smith','jane@example.com','2026-08-01 23:58:44','$2y$12$0moNWAYYBExDRWtzh2IireqMq0P6R8pe5JxTdyBjU9FYClKWC.EIW','730GUAAKVa','2026-08-01 23:58:44','2026-08-01 23:58:44');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-08-02  6:01:23
