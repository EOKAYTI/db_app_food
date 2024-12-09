CREATE DATABASE app_food

USE app_food


CREATE TABLE users(
	user_id INT PRIMARY KEY AUTO_INCREMENT,
	full_name VARCHAR(255),
	email VARCHAR(255),
	password VARCHAR(255)
)

CREATE TABLE food_type(
	type_id INT PRIMARY KEY AUTO_INCREMENT,
	type_name VARCHAR(255)
)

CREATE TABLE food(
	food_id INT PRIMARY KEY AUTO_INCREMENT,
	food_name VARCHAR(255),
	image VARCHAR(255),
	price FLOAT,
	description VARCHAR(255),
	type_id INT ,
	FOREIGN KEY (type_id) REFERENCES food_type(type_id)
)

CREATE TABLE sub_food(
	sub_id INT PRIMARY KEY AUTO_INCREMENT,
	sub_name VARCHAR(255),
	sub_price FLOAT,
	food_id INT,
	FOREIGN KEY (food_id) REFERENCES food(food_id)
)

CREATE TABLE orders(
	user_id INT,
	FOREIGN KEY (user_id) REFERENCES users(user_id),
	
	food_id INT,
	FOREIGN KEY (food_id) REFERENCES food(food_id),
	
	amount INT,
	code VARCHAR(255),
	ar_sub_id VARCHAR(255)
)

CREATE TABLE restaurant(
	res_id INT PRIMARY KEY AUTO_INCREMENT,
	res_name VARCHAR(255),
	image VARCHAR(255),
	description VARCHAR(255)
)

CREATE TABLE rate_res(
	user_id INT,
	FOREIGN KEY (user_id) REFERENCES users(user_id),
	
	res_id INT,
	FOREIGN KEY (res_id) REFERENCES restaurant(res_id),
	
	amount INT,
	date_rate DATETIME
)

CREATE TABLE like_res(
	user_id INT,
	FOREIGN KEY (user_id) REFERENCES users(user_id),
	
	res_id INT,
	FOREIGN KEY (res_id) REFERENCES restaurant(res_id),
	
	date_like DATETIME
)
-- THÊM DỮ LIỆU users
INSERT INTO users (full_name, email, password)
VALUES 
('John Doe', 'john.doe@example.com', 'password123'),
('Jane Smith', 'jane.smith@example.com', 'password456'),
('Alice Johnson', 'alice.johnson@example.com', 'password789'),
('Bob Brown', 'bob.brown@example.com', 'password101'),
('Charlie Black', 'charlie.black@example.com', 'password202');

-- Thêm người dùng không hoạt động
INSERT INTO users (full_name, email, password)
VALUES 
('Inactive User 1', 'inactive1@example.com', 'password123'),
('Inactive User 2', 'inactive2@example.com', 'password456');


-- THÊM DỮ LIỆU food_type
INSERT INTO food_type (type_name)
VALUES 
('Fast Food'),
('Desserts'),
('Beverages'),
('Healthy'),
('Seafood');

-- THÊM DỮ LIỆU food
INSERT INTO food (food_name, image, price, description, type_id)
VALUES 
('Burger', 'burger.jpg', 5.99, 'Delicious beef burger', 1),
('Pizza', 'pizza.jpg', 8.99, 'Cheese pizza with toppings', 1),
('Ice Cream', 'ice_cream.jpg', 2.99, 'Vanilla ice cream', 2),
('Orange Juice', 'orange_juice.jpg', 3.50, 'Freshly squeezed orange juice', 3),
('Grilled Salmon', 'salmon.jpg', 15.99, 'Grilled salmon with herbs', 5);

-- THÊM DỮ LIỆU sub_food
INSERT INTO sub_food (sub_name, sub_price, food_id)
VALUES 
('Cheese', 1.50, 1),
('Bacon', 2.00, 1),
('Extra Cheese', 1.00, 2),
('Chocolate Syrup', 0.50, 3),
('Lemon', 0.25, 4);

-- THÊM DỮ LIỆU orders
INSERT INTO orders (user_id, food_id, amount, code, ar_sub_id)
VALUES 
(1, 1, 2, 'ORD001', '1,2'),
(2, 2, 1, 'ORD002', '3'),
(3, 3, 3, 'ORD003', '4'),
(4, 4, 1, 'ORD004', '5'),
(5, 5, 2, 'ORD005', '');

-- THÊM DỮ LIỆU restaurant
INSERT INTO restaurant (res_id, res_name, image, description)
VALUES 
(1, 'Burger King', 'burger_king.jpg', 'Famous fast food restaurant'),
(2, 'Pizza Hut', 'pizza_hut.jpg', 'Delicious pizza worldwide'),
(3, 'Dairy Queen', 'dairy_queen.jpg', 'Famous for desserts'),
(4, 'Subway', 'subway.jpg', 'Healthy fast food options'),
(5, 'Red Lobster', 'red_lobster.jpg', 'Specialized in seafood dishes');

-- THÊM DỮ LIỆU rate_res
INSERT INTO rate_res (user_id, res_id, amount, date_rate)
VALUES 
(1, 1, 5, '2024-12-08 10:00:00'),
(2, 2, 4, '2024-12-07 14:00:00'),
(3, 3, 3, '2024-12-06 18:00:00'),
(4, 4, 5, '2024-12-05 11:00:00'),
(5, 5, 4, '2024-12-04 09:00:00');

-- THÊM DỮ LIỆU like_res
INSERT INTO like_res (user_id, res_id, date_like)
VALUES 
(1, 1, '2024-12-08 10:15:00'),
(2, 2, '2024-12-07 14:30:00'),
(3, 3, '2024-12-06 18:45:00'),
(4, 4, '2024-12-05 11:15:00'),
(5, 5, '2024-12-04 09:30:00');



-- Tìm 5 người đã like nhà hàng nhiều nhất.
SELECT 
    u.user_id, 
    u.full_name, 
    COUNT(lr.user_id) AS total_likes
FROM 
    users u
JOIN 
    like_res lr ON u.user_id = lr.user_id
GROUP BY 
    u.user_id, u.full_name
ORDER BY 
    total_likes DESC
LIMIT 5;

-- Tìm 2 nhà hàng có lượt like nhiều nhất.
SELECT 
    r.res_id, 
    r.res_name, 
    COUNT(lr.res_id) AS total_likes
FROM 
    restaurant r
JOIN 
    like_res lr ON r.res_id = lr.res_id
GROUP BY 
    r.res_id, r.res_name
ORDER BY 
    total_likes DESC
LIMIT 2;

-- Tìm người đã đặt hàng nhiều nhất.
SELECT 
    u.user_id, 
    u.full_name, 
    COUNT(o.user_id) AS total_orders
FROM 
    users u
JOIN 
    orders o ON u.user_id = o.user_id
GROUP BY 
    u.user_id, u.full_name
ORDER BY 
    total_orders DESC
LIMIT 1;

-- Tìm người dùng không hoạt động trong hệ thống(không đặt hàng, không like, không đánh giá nhà hàng).
SELECT 
    u.user_id, 
    u.full_name, 
    u.email
FROM 
    users u
LEFT JOIN 
    orders o ON u.user_id = o.user_id
LEFT JOIN 
    like_res lr ON u.user_id = lr.user_id
LEFT JOIN 
    rate_res rr ON u.user_id = rr.user_id
WHERE 
    o.user_id IS NULL 
    AND lr.user_id IS NULL 
    AND rr.user_id IS NULL;

