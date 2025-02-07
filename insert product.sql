--  create table script

CREATE TABLE IF NOT EXISTS Product (
    ProductId SERIAL PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Description TEXT,
    Price DECIMAL(10,2) NOT NULL,
    Image VARCHAR(255),
    CategoryId INT NOT NULL,
    FOREIGN KEY (CategoryId) REFERENCES Category(CategoryId) ON DELETE CASCADE
);


-- insert script

INSERT INTO public.product (productid, name, description, price, image, categoryid)
VALUES
    (1, 'Boat Headphone', 'High-quality Boat headphone', 120, 'p-1.jpg', 2),
    (2, 'Rocky Mountain', 'Luxury smartwatch', 4202, 'p-2.jpg', 3),
    (3, 'Goggles', 'Stylish goggles', 320, 'p-3.jpg', 2),
    (4, 'Printed Headphone', 'Unique design', 220, 'p-4.jpg', 2),
    (5, 'Boat Headphone', 'Comfortable fit', 120, 'airbuds2.png', 2),
    (6, 'Rocky Mountain', 'Durable sports headphone', 420, 'airbuds.png', 2),
    (7, 'Goggles', 'Trendy fashion goggles', 320, 'airbuds3.jpg', 3),
    (8, 'Printed Headphone', 'Noise-canceling', 220, 'p-5.jpg', 2),
    (9, 'Boat Headphone', 'Wireless Bluetooth', 120, 'p-7.jpg', 2),
    (10, 'Rocky Mountain', 'Smartwatch with fitness tracking', 4202, 'p-9.jpg', 3),
    (11, 'Goggles', 'Sunglasses with UV protection', 320, 'watch.png', 2),
    (12, 'Printed Headphone', 'Deep bass sound', 220, 'airb.png', 2);
