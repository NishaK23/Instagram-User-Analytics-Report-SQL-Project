USE ig_clone;

SELECT 
    id AS user_id, username, created_at
FROM
    users
ORDER BY created_at ASC
LIMIT 5;

SELECT 
    id AS user_id, username
FROM
    users
WHERE
    id NOT IN (SELECT DISTINCT
            user_id
        FROM
            photos);

SELECT 
    p.id AS photo_id, p.user_id, COUNT(l.user_id) AS like_count
FROM
    photos p
        JOIN
    likes l ON p.id = l.photo_id
GROUP BY p.id
ORDER BY like_count DESC
LIMIT 1;

SELECT 
    t.tag_name, COUNT(*) AS usage_count
FROM
    tags t
        JOIN
    photo_tags pt ON t.id = pt.tag_id
GROUP BY t.tag_name
ORDER BY usage_count DESC
LIMIT 5;

SELECT 
    DAYNAME(created_at) AS day_of_week, COUNT(*) AS signups
FROM
    users
GROUP BY day_of_week
ORDER BY signups DESC
LIMIT 1;

SELECT 
    ROUND(COUNT(*) / (SELECT 
                    COUNT(*)
                FROM
                    users),
            2) AS avg_posts_per_user
FROM
    photos;

SELECT 
    l.user_id, COUNT(DISTINCT l.photo_id) AS liked_photos
FROM
    likes l
GROUP BY l.user_id
HAVING liked_photos = (SELECT 
        COUNT(*)
    FROM
        photos);

SELECT 
    t.tag_name, COUNT(*) AS usage_count
FROM
    tags t
        JOIN
    photo_tags pt ON t.id = pt.tag_id
GROUP BY t.tag_name
ORDER BY usage_count DESC
LIMIT 5;

