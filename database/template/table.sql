CREATE TABLE states (
    state_id INT AUTO_INCREMENT PRIMARY KEY,
    state_name VARCHAR(255) NOT NULL,
    status TINYINT(1) DEFAULT 1,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE cities (
    city_id INT AUTO_INCREMENT PRIMARY KEY,
    city_name VARCHAR(255) NOT NULL,
    state_id INT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    status TINYINT(1) DEFAULT 1,
    FOREIGN KEY (state_id) REFERENCES states(state_id)
);

CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    mobile VARCHAR(15) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    gender VARCHAR(10),
    birth_date DATE,
    address VARCHAR(255),
    email VARCHAR(255) UNIQUE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    created_by INT NOT NULL,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    status TINYINT(1) DEFAULT 1
);

CREATE TABLE branches (
    branch_id INT AUTO_INCREMENT PRIMARY KEY,
    branch_name VARCHAR(255) NOT NULL,
    branch_short_name VARCHAR(10) NOT NULL,
    alias_name VARCHAR(255),
    address VARCHAR(255),
    city_id INT NOT NULL,
    state_id INT NOT NULL,
    pin_code VARCHAR(10),
    contact_no VARCHAR(15),
    email VARCHAR(255),
    gst_no VARCHAR(50),
    cin_no VARCHAR(50),
    udyam_no VARCHAR(50),
    cgst DOUBLE DEFAULT 0.0,
    sgst DOUBLE DEFAULT 0.0,
    igst DOUBLE DEFAULT 0.0,
    logo VARCHAR(255),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    created_by INT NOT NULL,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    manifest_sires VARCHAR(255) DEFAULT NULL,
    status TINYINT(1) DEFAULT 1,
    UNIQUE(branch_name),
    UNIQUE(branch_short_name),
    INDEX idx_branches_email (email),
    FOREIGN KEY (city_id) REFERENCES cities(city_id),
    FOREIGN KEY (state_id) REFERENCES states(state_id),
    FOREIGN KEY (created_by) REFERENCES users(user_id)
);

CREATE TABLE representatives (
    representative_id INT AUTO_INCREMENT PRIMARY KEY,
    branch_id INT NOT NULL,
    user_id INT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    created_by INT NOT NULL,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    status TINYINT(1) DEFAULT 1,
    FOREIGN KEY (branch_id) REFERENCES branches(branch_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (created_by) REFERENCES users(user_id)
);

CREATE TABLE branch_user (
    branch_id INT NOT NULL,
    user_id INT NOT NULL,
    FOREIGN KEY (branch_id) REFERENCES branches(branch_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE bookings (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    consignee_name VARCHAR(255) NOT NULL,
    consignee_mobile VARCHAR(15) NOT NULL,
    consignor_name VARCHAR(255) NOT NULL,
    consignor_mobile VARCHAR(15) NOT NULL,
    branch_id INT NOT NULL,
    slip_no VARCHAR(50) NOT NULL UNIQUE,
    booking_address VARCHAR(255),
    transport_mode VARCHAR(50),
    paid_type VARCHAR(50),
    on_account VARCHAR(50),
    to_pay VARCHAR(50),
    cgst DOUBLE DEFAULT 0.0,
    sgst DOUBLE DEFAULT 0.0,
    igst DOUBLE DEFAULT 0.0,
    total_value DOUBLE NOT NULL,
    package_count INT NOT NULL,
    package_weight DOUBLE NOT NULL,
    package_value DOUBLE NOT NULL,
    package_contents TEXT,
    shipper_charges VARCHAR(255),
    destination_city_id INT NOT NULL,
    destination_branch_id INT NOT NULL,
    xp_branch_id INT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    created_by INT NOT NULL,
    manifest_id VARCHAR(255) DEFAULT NULL,
    other_charges DOUBLE DEFAULT 0.0,
    declared_value DOUBLE DEFAULT 0.0,
    status INT,
    FOREIGN KEY (branch_id) REFERENCES branches(branch_id),
    FOREIGN KEY (destination_branch_id) REFERENCES branches(branch_id),
    FOREIGN KEY (xp_branch_id) REFERENCES branches(branch_id),
    FOREIGN KEY (destination_city_id) REFERENCES cities(city_id),
    FOREIGN KEY (created_by) REFERENCES users(user_id)
);

CREATE TABLE employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_name VARCHAR(255) NOT NULL,
    employee_mobile VARCHAR(15) NOT NULL,
    address VARCHAR(255),
    aadhar_no VARCHAR(12) UNIQUE,
    joining_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    branch_id INT NOT NULL,
    designation VARCHAR(100),
    created_by INT NOT NULL,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    status TINYINT(1) DEFAULT 1,
    FOREIGN KEY (branch_id) REFERENCES branches(branch_id),
    FOREIGN KEY (created_by) REFERENCES users(user_id)
);

CREATE TABLE coloader (
    coloader_id INT AUTO_INCREMENT PRIMARY KEY,
    coloader_name VARCHAR(200),
    coloader_contuct VARCHAR(20),
    coloader_address VARCHAR(50),
    coloader_postal_code VARCHAR(20),
    coloader_email VARCHAR(20),
    coloader_city VARCHAR(20),
    coloader_branch VARCHAR(20)
);

CREATE TABLE credit_node (
    credit_node_id INT AUTO_INCREMENT PRIMARY KEY,
    branch_id INT NOT NULL,
    start_no INT,
    end_no INT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (branch_id) REFERENCES branches(branch_id)
);

CREATE TABLE delivery_list (
    delivery_id INT AUTO_INCREMENT PRIMARY KEY,
    booking_id INT NOT NULL,
    branch_id INT NOT NULL,
    employee_id INT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    created_by INT NOT NULL,
    name VARCHAR(255)
);

-- Create the table with auto-incrementing ID
CREATE TABLE received_booking (
    id INT NOT NULL AUTO_INCREMENT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    booking_id INT NOT NULL,
    branch_id INT NOT NULL,
    status BOOLEAN DEFAULT TRUE NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE manifests (
    manifest_id INT AUTO_INCREMENT PRIMARY KEY,
    coloader_id INT NOT NULL,
    branch_id INT NOT NULL,
    booking_id JSON, -- Storing booking IDs in a JSON array
    destination_id INT NOT NULL,
    deleted TINYINT(1) DEFAULT 0,
    manifests_number VARCHAR(255),
    create_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    bag_count INT DEFAULT 0,
    destination_city_id INT NOT NULL,
    FOREIGN KEY (destination_city_id) REFERENCES cities(city_id)
);

CREATE TABLE pages (
    page_id INT AUTO_INCREMENT PRIMARY KEY,
    page_name VARCHAR(255) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE permissions (
    permission_id INT AUTO_INCREMENT PRIMARY KEY,
    page_id INT NOT NULL,
    permission_code VARCHAR(50) NOT NULL,
    user_id INT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    created_by INT NOT NULL,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    status TINYINT(1) DEFAULT 1,
    FOREIGN KEY (page_id) REFERENCES pages(page_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (created_by) REFERENCES users(user_id)
);

CREATE TABLE tracking (
    tracking_id INT AUTO_INCREMENT PRIMARY KEY,
    current_branch_id INT NOT NULL,
    destination_branch_id INT NOT NULL,
    booking_id INT NOT NULL,
    received TINYINT(1) DEFAULT 0,
    arrived_at DATETIME,
    departed_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE pods (
    pod_id INT AUTO_INCREMENT PRIMARY KEY,
    booking_id INT NOT NULL,
    pod_data BLOB NOT NULL,
    data_formate VARCHAR,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    created_by INT NOT NULL,
    status TINYINT(1) DEFAULT 1,
    FOREIGN KEY (created_by) REFERENCES users(user_id),
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id)
);