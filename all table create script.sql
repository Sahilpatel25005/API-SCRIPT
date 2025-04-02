-- Users table (Referenced in Cart)
CREATE TABLE Users (
    UserId SERIAL PRIMARY KEY,
    Fname VARCHAR(50) NOT NULL,
    Lname VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    MoNumber VARCHAR(15) UNIQUE NOT NULL,
    Password VARCHAR(255) NOT NULL,
    Address TEXT
);

-- Cart table
CREATE TABLE Cart (
    CartId SERIAL PRIMARY KEY,
    UserId INT NOT NULL,
    FOREIGN KEY (UserId) REFERENCES Users(UserId) ON DELETE CASCADE
);

-- Category table (since Product references it)
CREATE TABLE Category (
    CategoryId SERIAL PRIMARY KEY,
    Name VARCHAR(50) NOT NULL
);

-- Product table
CREATE TABLE Product (
    ProductId SERIAL PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Description TEXT,
    Price DECIMAL(10,2) NOT NULL,
    Image VARCHAR(255),
    CategoryId INT NOT NULL,
    FOREIGN KEY (CategoryId) REFERENCES Category(CategoryId) ON DELETE CASCADE
);

-- CartItem table (Many-to-Many relationship between Cart and Product)
CREATE TABLE CartItem (
    CartItemId SERIAL PRIMARY KEY,
    CartId INT NOT NULL,
    ProductId INT NOT NULL,
    Qty INT NOT NULL CHECK (Qty > 0),
    FOREIGN KEY (CartId) REFERENCES Cart(CartId) ON DELETE CASCADE,
    FOREIGN KEY (ProductId) REFERENCES Product(ProductId) ON DELETE CASCADE
);


-- Order table
CREATE TABLE Orders (
    OrderId SERIAL PRIMARY KEY,
    UserId INT NOT NULL,
    OrderDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Status VARCHAR(20) CHECK (Status IN ('Pending', 'Shipped', 'Delivered', 'Cancelled')) NOT NULL,
    Amount DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (UserId) REFERENCES Users(UserId) ON DELETE CASCADE
);

-- OrderItem table
CREATE TABLE OrderItem (
    OrderItemId SERIAL PRIMARY KEY,
    OrderId INT NOT NULL,
    ProductId INT NOT NULL,
    Qty INT NOT NULL CHECK (Qty > 0),
    Price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (OrderId) REFERENCES Orders(OrderId) ON DELETE CASCADE,
    FOREIGN KEY (ProductId) REFERENCES Product(ProductId) ON DELETE CASCADE
);
