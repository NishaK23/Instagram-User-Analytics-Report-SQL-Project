# Instagram User Analytics Report

## 1. Project Description

This project focuses on analyzing user engagement and interaction data from an Instagram-like database, using SQL queries to derive actionable insights. The primary aim is to support data-driven decision-making in marketing, product development, and investor relations by identifying key trends, user behaviors, and engagement metrics. By applying various SQL commands, this project addresses tasks such as identifying loyal users, detecting inactive accounts, evaluating overall user engagement, and more.

## 2. Approach

My approach to this project involved systematically breaking down the analysis into key areas, primarily focusing on marketing analysis and investor-centric metrics. The following steps were executed:

* **Data Setup:** Utilized MySQL Workbench to import and organize the raw data into a structured database (`ig_clone`) with tables representing core Instagram entities like `users`, `photos`, `likes`, `comments`, `tags`, and `photo_tags`.
* **Querying the Database:** For each specific business question or analytical goal, I developed and optimized SQL queries to extract the necessary insights from the dataset.
* **Validating Results:** Each query was thoroughly tested within MySQL Workbench, and the results were interpreted to ensure accuracy and to extract meaningful business insights.
* **Reporting:** The derived insights were compiled, accompanied by explanations of the methodology and the business implications.

## 3. Key SQL Commands Used

This project extensively utilized a range of SQL commands to perform robust data manipulation and analysis:

* **`SELECT`**: To retrieve specific columns or all data from tables.
* **`JOIN`**: To combine rows from two or more tables based on a related column between them (e.g., `users` and `photos`).
* **`GROUP BY`**: To group rows that have the same values in specified columns into a summary row (e.g., grouping by day of the week).
* **`COUNT`**: An aggregate function used to count the number of rows or non-NULL values in a column (e.g., counting likes or posts).
* **`WHERE`**: To filter records based on specified conditions before grouping.
* **`HAVING`**: To filter groups based on specified conditions after aggregation (e.g., filtering groups of users who liked every photo).
* **`ORDER BY`**: To sort the result set in ascending or descending order.
* **`LIMIT`**: To restrict the number of rows returned by a query.
* **`ROUND`**: To round a numeric value to a specified number of decimal places.
* **`DAYNAME`**: To extract the day name from a date column.

## 4. Tech Stack Used

* **MySQL Workbench 8.0:** This powerful visual tool was used for database design, development, management, and querying. Its robust SQL capabilities and intuitive interface were instrumental in organizing data, executing complex queries, and visualizing results.
* **SQL (Structured Query Language):** The core language used for all data manipulation, aggregation, and retrieval tasks within the MySQL database.

## 5. Queries Included

The `SQL Project T.sql` file contains the following analytical queries:

* **Find the 5 Oldest Users:**
    ```sql
    SELECT
        id AS user_id, username, created_at
    FROM
        users
    ORDER BY created_at ASC
    LIMIT 5;
    ```

* **Find Users Who Have Never Posted a Photo:**
    ```sql
    SELECT
        id AS user_id, username
    FROM
        users
    WHERE
        id NOT IN (SELECT DISTINCT
                user_id
            FROM
                photos);
    ```

* **Identify the Most Liked Photo:**
    ```sql
    SELECT
        p.id AS photo_id, p.user_id, COUNT(l.user_id) AS like_count
    FROM
        photos p
            JOIN
        likes l ON p.id = l.photo_id
    GROUP BY p.id
    ORDER BY like_count DESC
    LIMIT 1;
    ```

* **Determine the Top 5 Most Used Hashtags:**
    ```sql
    SELECT
        t.tag_name, COUNT(*) AS usage_count
    FROM
        tags t
            JOIN
        photo_tags pt ON t.id = pt.tag_id
    GROUP BY t.tag_name
    ORDER BY usage_count DESC
    LIMIT 5;
    ```

* **Find the Day of the Week with the Most User Registrations:**
    ```sql
    SELECT
        DAYNAME(created_at) AS day_of_week, COUNT(*) AS signups
    FROM
        users
    GROUP BY day_of_week
    ORDER BY signups DESC
    LIMIT 1;
    ```

* **Calculate the Average Number of Posts Per User:**
    ```sql
    SELECT
        ROUND(COUNT(*) / (SELECT
                        COUNT(*)
                    FROM
                        users),
                2) AS avg_posts_per_user
    FROM
        photos;
    ```

* **Identify Users Who Have Liked Every Single Photo:**
    ```sql
    SELECT
        l.user_id, COUNT(DISTINCT l.photo_id) AS liked_photos
    FROM
        likes l
    GROUP BY l.user_id
    HAVING liked_photos = (SELECT
            COUNT(*)
        FROM
            photos);
    ```

## 6. Insights

This project yielded several valuable insights with direct applications for business strategies:

* **Loyal Users:** Identifying the 5 oldest users provides a basis for potential loyalty programs or targeted engagement initiatives.
* **Inactive Users:** Detecting users who have never posted a photo highlights a segment that may require re-engagement strategies to increase platform participation.
* **Engagement Patterns:** Analysis of the most liked photo and trending hashtags offers direct guidance for content creation and marketing campaigns, indicating what resonates most with the audience.
* **Optimal Ad Timing:** By analyzing user sign-ups by day of the week, we can pinpoint the most effective days to launch new ad campaigns for maximum impact and user acquisition.
* **Suspicious User Activity:** Identifying users who have liked every photo raises a flag for potential bot activity or fake accounts, which is crucial for maintaining user authenticity and platform integrity.

These insights are directly applicable to tailoring marketing strategies, improving user engagement, and identifying potential issues for platforms like Instagram.

## 7. Result & Learnings

This project significantly enhanced my SQL querying skills, allowing me to master advanced commands like `JOIN`, `GROUP BY`, `COUNT`, `WHERE`, and `HAVING` in a practical context. It provided invaluable experience in transforming raw data into actionable business insights that can be applied to real-world problems.

Through this project, I gained hands-on experience in handling and manipulating large datasets, optimizing queries for performance, and creating meaningful reports that can effectively drive business decisions. The analytical findings are valuable for companies to refine their marketing efforts, boost user engagement, and address critical issues such as identifying fake accounts or re-engaging inactive users.

## How to Use

To run these SQL queries and explore the analytics yourself:

1.  **Database Setup:** Ensure you have a MySQL database instance running.
2.  **Schema and Data:** Create a database named `ig_clone` (or modify the `USE ig_clone;` statement in the SQL file to match your database name). You will need to populate this database with a schema that mirrors an Instagram-like structure (e.g., `users`, `photos`, `likes`, `comments`, `tags`, `photo_tags` tables) and some sample data.
3.  **Execute Queries:** Open the `SQL Project T.sql` file in MySQL Workbench (or any compatible SQL client) and execute the queries.
