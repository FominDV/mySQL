use net_shop;
#1
SELECT 
    u.id,
    u.user_name 'name',
    (SELECT 
            COUNT(user_liked_id) - 1
        FROM
            like_for_user
        WHERE
            user_liked_id = u.id) 'have likes',
    (SELECT 
            COUNT(user_id) - 1
        FROM
            like_for_user
        WHERE
            user_id = u.id) 'likes was made',
    (SELECT 
            COUNT(like_for_user.id) - 1
        FROM
            like_for_user
        WHERE
            user_liked_id IN (SELECT 
                    user_id
                FROM
                    like_for_user
                WHERE
                    user_liked_id = u.id)
                AND user_id = u.id) 'mutual likes'
FROM
    users u
        INNER JOIN
    like_for_user l ON u.id = l.user_id
        OR u.id = l.user_liked_id
GROUP BY u.id;
#2
#В примере мы ищем пользоватлей, которые поставили like id=(6,7) и не поставили id=8
SELECT DISTINCT
    u.id, user_name 'name'
FROM
    users u
        INNER JOIN
    like_for_user l ON u.id = l.user_id
WHERE
    l.user_id IN (SELECT 
            user_id
        FROM
            like_for_user
        WHERE
            enabled != FALSE
                AND user_liked_id IN (6 , 7)
        GROUP BY user_id
        HAVING COUNT(user_liked_id) = 2)
        AND l.user_id NOT IN (SELECT 
            user_id
        FROM
            like_for_user
        WHERE
            enabled != FALSE AND user_liked_id = 8);
#3
#3.1
#Данная попытка второй раз лайкнуть не пройдёт, так как стоит состовной уникальный индекс на id фото и id пользователя, который лайкает
#INSERT INTO `net_shop`.`like_for_photo` (`photo_id`, `user_id`) VALUES ('4', '3');
#3.2
#Отзываем лайк
UPDATE like_for_photo 
SET 
    enabled = '0'
WHERE
    user_id = 7 AND photo_id = 4;
#3.3.1
#Выводим колиесво лайков для коментария с id=3
SELECT 
    COUNT(user_id)
FROM
    like_for_comment
WHERE
    comment_id = 3 AND enabled != FALSE;
#3.3.2
#Выводим пользователей, которые лайкнули фото с id=4
SELECT 
    u.id, user_name
FROM
    users u
        INNER JOIN
    like_for_photo l
WHERE
    u.id = l.user_id AND l.enabled != FALSE
        AND l.photo_id = 4;
#3.4
#С такой структурой нет проблем добавить новую сущность и лайкать её, так как таблицы максимально упрощены