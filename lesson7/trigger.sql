DELIMITER %
CREATE DEFINER=`root`@`localhost` TRIGGER `users_BEFORE_INSERT` AFTER INSERT ON `users` FOR EACH ROW BEGIN
set @id=NEW.id;
INSERT INTO net_shop.like_for_user (user_liked_id, user_id, enabled) VALUE (@id,@id,false);
END%
DELIMITER ;