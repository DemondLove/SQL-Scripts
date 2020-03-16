/*
Table: Products

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| product_id    | int     |
| new_price     | int     |
| change_date   | date    |
+---------------+---------+
(product_id, change_date) is the primary key of this table.
Each row of this table indicates that the price of some product was changed to a new price at some date.
 

Write an SQL query to find the prices of all products on 2019-08-16. Assume the price of all products before any change is 10.

The query result format is in the following example:

Products table:
+------------+-----------+-------------+
| product_id | new_price | change_date |
+------------+-----------+-------------+
| 1          | 20        | 2019-08-14  |
| 2          | 50        | 2019-08-14  |
| 1          | 30        | 2019-08-15  |
| 1          | 35        | 2019-08-16  |
| 2          | 65        | 2019-08-17  |
| 3          | 20        | 2019-08-18  |
+------------+-----------+-------------+

Result table:
+------------+-------+
| product_id | price |
+------------+-------+
| 2          | 50    |
| 1          | 35    |
| 3          | 10    |
+------------+-------+
*/

SELECT
    tbl.product_id
    , ISNULL(tbl2.new_price, 10) AS price
FROM (
        SELECT *
        FROM (
                SELECT
                    product_id
                    , new_price
                    , change_date
                    , MAX(change_date) OVER(PARTITION BY product_id) AS max_change_date
                FROM Products
                WHERE change_date <= '2019-08-16'
            ) sub_tbl
        WHERE change_date = max_change_date
     ) tbl2
RIGHT JOIN (SELECT DISTINCT product_id FROM Products) tbl ON tbl.product_id = tbl2.product_id