-- States Table: Stores states -- * DONE NOT CHANGEABLE
CREATE TABLE states (
    state_id SERIAL PRIMARY KEY,
    state_name VARCHAR(255) NOT NULL,
    status BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Cities Table: Stores cities related to states -- * DONE NOT CHANGEABLE
CREATE TABLE cities (
    city_id SERIAL PRIMARY KEY,
    city_name VARCHAR(255) NOT NULL,
    state_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    status BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (state_id) REFERENCES states(state_id) ON DELETE CASCADE
);

-- Users Table: Stores user credentials and personal information -- * DONE NOT CHANGEABLE
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    mobile VARCHAR(15) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    gender VARCHAR(10),
    birth_date DATE,
    address VARCHAR(255),
    email VARCHAR(255) UNIQUE,
    created_at TIMESTAMP DEFAULT NOW(),
    created_by INT NOT NULL,
    updated_at TIMESTAMP DEFAULT NOW(),
    status BOOLEAN DEFAULT TRUE
);

-- Branches Table: Stores branches related to companies
CREATE TABLE branches (
    branch_id SERIAL PRIMARY KEY,
    branch_name VARCHAR(255) NOT NULL UNIQUE,
    branch_short_name VARCHAR(10) NOT NULL UNIQUE,
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
    cgst FLOAT DEFAULT 0.0,
    sgst FLOAT DEFAULT 0.0,
    igst FLOAT DEFAULT 0.0,
    logo VARCHAR(255),
    created_at TIMESTAMP DEFAULT NOW(),
    created_by INT NOT NULL,
    updated_at TIMESTAMP DEFAULT NOW(),
    status BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (city_id) REFERENCES cities(city_id) ON DELETE CASCADE,
    FOREIGN KEY (state_id) REFERENCES states(state_id) ON DELETE CASCADE,
    FOREIGN KEY (created_by) REFERENCES users(user_id) ON DELETE SET NULL
);

CREATE TABLE representatives (
    representative_id SERIAL PRIMARY KEY,
    branch_id INT NOT NULL,
    user_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    created_by INT NOT NULL,
    updated_at TIMESTAMP DEFAULT NOW(),
    status BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (branch_id) REFERENCES branches(branch_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (created_by) REFERENCES users(user_id) ON DELETE SET NULL
)

-- Credit Nodes Table: Stores credit numbers related to branches
CREATE TABLE credit_node (
    credit_node_id SERIAL PRIMARY KEY,
    branch_id INT NOT NULL,
    start_no INT,
    end_no INT,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY (branch_id) REFERENCES branches(branch_id) ON DELETE CASCADE
);

-- Pages Table: Stores pages available for permissions
CREATE TABLE pages (
    page_id SERIAL PRIMARY KEY,
    page_name VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Permissions Table: Stores user permissions related to pages
CREATE TABLE permissions (
    permission_id SERIAL PRIMARY KEY,
    page_id INT NOT NULL,
    permission_code VARCHAR(50) NOT NULL,
    user_id INT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    created_by INT NOT NULL,
    updated_at TIMESTAMP DEFAULT NOW(),
    status BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (page_id) REFERENCES pages(page_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (created_by) REFERENCES users(user_id) ON DELETE SET NULL
);

-- Employees Table: Stores employee-related information
CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    employee_name VARCHAR(255) NOT NULL,
    employee_mobile VARCHAR(15) NOT NULL,
    address VARCHAR(255),
    aadhar_no VARCHAR(12) UNIQUE,
    joining_date TIMESTAMP DEFAULT NOW(),
    created_at TIMESTAMP DEFAULT NOW(),
    branch_id INT NOT NULL,
    designation VARCHAR(100),
    created_by INT NOT NULL,
    updated_at TIMESTAMP DEFAULT NOW(),
    status BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (branch_id) REFERENCES branches(branch_id) ON DELETE CASCADE,
    FOREIGN KEY (created_by) REFERENCES users(user_id) ON DELETE SET NULL
);
-- Bookings Table: Stores booking information including consignee, consignor, and packages
CREATE TABLE bookings (
    booking_id SERIAL PRIMARY KEY,
    consignee_name VARCHAR(255) NOT NULL,
    consignee_mobile VARCHAR(15) NOT NULL,
    consignor_name VARCHAR(255) NOT NULL,
    consignor_mobile VARCHAR(15) NOT NULL,
    branch_id INT NOT NULL,
    slip_no VARCHAR(50) UNIQUE NOT NULL,
    booking_address VARCHAR(255),
    transport_mode VARCHAR(50),
    paid_type VARCHAR(50),
    cgst FLOAT DEFAULT 0.0,
    sgst FLOAT DEFAULT 0.0,
    igst FLOAT DEFAULT 0.0,
    total_value FLOAT NOT NULL,
    package_count INT NOT NULL,
    package_weight FLOAT NOT NULL,
    package_value FLOAT NOT NULL,
    package_contents TEXT,
    shipper_name VARCHAR(255),
    destination_city_id INT NOT NULL,
    destination_branch_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    created_by INT NOT NULL,
    status BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (branch_id) REFERENCES branches(branch_id) ON DELETE CASCADE,
    FOREIGN KEY (destination_city_id) REFERENCES cities(city_id) ON DELETE CASCADE,
    FOREIGN KEY (destination_branch_id) REFERENCES branches(branch_id) ON DELETE CASCADE,
    FOREIGN KEY (created_by) REFERENCES users(user_id) ON DELETE SET NULL
);

-- Tracking Table: Stores tracking information for bookings
CREATE TABLE tracking (
    tracking_id SERIAL PRIMARY KEY,
    slip_no VARCHAR(50) UNIQUE NOT NULL,
    tracking_status VARCHAR(255),
    created_at TIMESTAMP DEFAULT NOW(),
    branch_id INT NOT NULL,
    FOREIGN KEY (branch_id) REFERENCES branches(branch_id) ON DELETE CASCADE,
    FOREIGN KEY (slip_no) REFERENCES bookings(slip_no) ON DELETE CASCADE
);

-- Adding Indexes for faster queries (Optional but recommended for large databases)
CREATE INDEX idx_users_mobile ON users(mobile);
CREATE INDEX idx_branches_email ON branches(email);
CREATE INDEX idx_bookings_slip_no ON bookings(slip_no);