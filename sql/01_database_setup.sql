CREATE DATABASE retail_analytics;
USE retail_analytics;
CREATE TABLE dim_sku (
    sku_id INT PRIMARY KEY,
    sku_name VARCHAR(150),
    category VARCHAR(100),
    subcategory VARCHAR(100),
    unit_price DECIMAL(10,2),
    cost_price DECIMAL(10,2),
    brand VARCHAR(100)
);
DESCRIBE dim_sku;
CREATE TABLE dim_store (
    store_id INT PRIMARY KEY,
    store_name VARCHAR(150),
    city VARCHAR(100),
    store_type VARCHAR(50),
    opening_date DATE
);
DESCRIBE dim_store;
CREATE TABLE dim_customer (
    cust_id INT PRIMARY KEY,
    age INT,
    gender VARCHAR(20),
    city VARCHAR(100),
    loyalty_segment VARCHAR(50),
    preferred_channel VARCHAR(50),
    registration_date DATE
);
DESCRIBE dim_customer;
CREATE TABLE dim_promotion (
    promo_id INT PRIMARY KEY,
    promo_name VARCHAR(150),
    start_date DATE,
    end_date DATE,
    discount_pct DECIMAL(5,2),
    promo_type VARCHAR(50)
);
DESCRIBE dim_promotion;
CREATE TABLE fact_sales (
    sale_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    sale_date DATE NOT NULL,
    store_id INT NOT NULL,
    sku_id INT NOT NULL,
    cust_id INT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    total_value DECIMAL(12,2) NOT NULL,
    channel VARCHAR(50),
    discount_pct DECIMAL(5,2),

    FOREIGN KEY (store_id) REFERENCES dim_store(store_id),
    FOREIGN KEY (sku_id) REFERENCES dim_sku(sku_id),
    FOREIGN KEY (cust_id) REFERENCES dim_customer(cust_id)
);
DESCRIBE fact_sales;
SHOW CREATE TABLE fact_sales;
CREATE TABLE fact_inventory (
    store_id INT NOT NULL,
    sku_id INT NOT NULL,
    stock_on_hand INT NOT NULL,
    reorder_point INT NOT NULL,
    safety_stock INT NOT NULL,
    last_restock_date DATE NOT NULL,
    snapshot_date DATE NOT NULL,

    PRIMARY KEY (store_id, sku_id, snapshot_date),

    FOREIGN KEY (store_id) REFERENCES dim_store(store_id),
    FOREIGN KEY (sku_id) REFERENCES dim_sku(sku_id)
);
DESCRIBE fact_inventory;
SELECT *
FROM dim_sku;
SELECT COUNT(*) AS store_count
FROM dim_store;
SELECT COUNT(*) AS customer_count
FROM dim_customer;
SELECT COUNT(*) AS promotion_count
FROM dim_promotion;
SELECT COUNT(*) AS current_sales
FROM fact_sales;
USE retail_analytics;

TRUNCATE TABLE fact_sales;
USE retail_analytics;

TRUNCATE TABLE fact_sales;
SELECT COUNT(*) AS sales_count
FROM fact_sales;
SHOW VARIABLES LIKE 'local_infile';
SET GLOBAL local_infile = 1;
SHOW VARIABLES LIKE 'local_infile';
LOAD DATA LOCAL INFILE 'path/to/cleaned_sales_mysql.csv'
INTO TABLE fact_sales
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
    @sale_date,
    @store_id,
    @sku_id,
    @cust_id,
    @quantity,
    @unit_price,
    @total_value,
    @channel,
    @discount_pct
)
SET
    sale_date = STR_TO_DATE(@sale_date, '%Y-%m-%d'),
    store_id = @store_id,
    sku_id = @sku_id,
    cust_id = NULLIF(TRIM(@cust_id), ''),
    quantity = @quantity,
    unit_price = @unit_price,
    total_value = @total_value,
    channel = @channel,
    discount_pct = @discount_pct;
    SHOW VARIABLES LIKE 'local_infile';
LOAD DATA LOCAL INFILE 'path/to/cleaned_sales_mysql.csv'
INTO TABLE fact_sales
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
    @sale_date,
    @store_id,
    @sku_id,
    @cust_id,
    @quantity,
    @unit_price,
    @total_value,
    @channel,
    @discount_pct
)
SET
    sale_date = STR_TO_DATE(@sale_date, '%Y-%m-%d'),
    store_id = @store_id,
    sku_id = @sku_id,
    cust_id = NULLIF(TRIM(@cust_id), ''),
    quantity = @quantity,
    unit_price = @unit_price,
    total_value = @total_value,
    channel = @channel,
    discount_pct = @discount_pct;
    SELECT COUNT(*) FROM fact_sales;
    TRUNCATE TABLE fact_sales;
    SELECT COUNT(*) FROM fact_sales;
    CREATE TABLE staging_sales (
    sale_date VARCHAR(30),
    store_id VARCHAR(30),
    sku_id VARCHAR(30),
    customer_id VARCHAR(30),
    quantity VARCHAR(30),
    unit_price VARCHAR(30),
    total_value VARCHAR(30),
    channel VARCHAR(50),
    discount_pct VARCHAR(30)
);
SELECT USER(), CURRENT_USER(), DATABASE();
