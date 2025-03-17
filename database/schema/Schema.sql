CREATE TABLE states (
    id SERIAL PRIMARY KEY NOT NULL,
    name VARCHAR NULL,
    status BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE cities (
    id SERIAL PRIMARY KEY NOT NULL,
    name VARCHAR NULL,
    state_id INT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    status BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (state_id) REFERENCES states(id)
);

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    mobile VARCHAR NULL UNIQUE,
    password VARCHAR NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    created_by INT NULL,
    updated_at TIMESTAMP DEFAULT NOW(),
    status BOOLEAN DEFAULT TRUE
);

CREATE TABLE user_info (
    id SERIAL PRIMARY KEY NOT NULL,
    first_name VARCHAR NULL,
    last_name VARCHAR NULL,
    gender VARCHAR NULL,
    birth_date TIMESTAMP NULL,
    address VARCHAR NULL,
    email VARCHAR NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    created_by INT NULL,
    updated_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY (created_by) REFERENCES users(id),
    FOREIGN KEY (id) REFERENCES users(id)
);

CREATE TABLE credit_node (
    id SERIAL PRIMARY KEY NOT NULL,
    branch_id INTEGER NOT NULL,
    start_no INTEGER,
    end_no INTEGER,
    unused INTEGER,
    user_id INTEGER,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (branch_id) REFERENCES branches(id)
);


CREATE TABLE companies (
    id SERIAL PRIMARY KEY NOT NULL,
    name VARCHAR NULL,
    address VARCHAR NULL,
    city_id INT NULL,
    state_id INT NULL,
    pin_code VARCHAR NULL,
    contact_no VARCHAR NULL,
    email VARCHAR NULL,
    gst_no VARCHAR NULL,
    cin_no VARCHAR NULL,
    udyam_no VARCHAR NULL,
    logo VARCHAR NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    created_by INT NULL,
    updated_at TIMESTAMP DEFAULT NOW(),
    status BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (city_id) REFERENCES cities(id),
    FOREIGN KEY (state_id) REFERENCES states(id)
);

CREATE TABLE branches (
    id SERIAL PRIMARY KEY NOT NULL,
    name VARCHAR NULL,
    alias_name VARCHAR NULL,
    address VARCHAR NULL,
    city_id INT NULL,
    state_id INT NULL,
    company_id INT NULL,
    pin_code VARCHAR NULL,
    contact_no VARCHAR NULL,
    email VARCHAR NULL,
    gst_no VARCHAR NULL,
    cin_no VARCHAR NULL,
    udyam_no VARCHAR NULL,
    cgst FLOAT DEFAULT 0.0,
    sgst FLOAT DEFAULT 0.0,
    igst FLOAT DEFAULT 0.0,
    logo VARCHAR NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    created_by INT NULL,
    updated_at TIMESTAMP DEFAULT NOW(),
    status BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (city_id) REFERENCES cities(id),
    FOREIGN KEY (state_id) REFERENCES states(id),
    FOREIGN KEY (company_id) REFERENCES companies(id),
    FOREIGN KEY (created_by) REFERENCES users(id)
);

CREATE TABLE pages (
    id SERIAL PRIMARY KEY NOT NULL,
    name VARCHAR NULL,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE permissions (
    id SERIAL PRIMARY KEY NOT NULL,
    page_id INT NULL,
    permission_code VARCHAR NULL,
    user_id INT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    created_by INT NULL,
    updated_at TIMESTAMP DEFAULT NOW(),
    status BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (page_id) REFERENCES pages(id),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (created_by) REFERENCES users(id)
);

CREATE TABLE employees (
    id SERIAL PRIMARY KEY NOT NULL,
    user_id INT NULL,
    address VARCHAR NULL,
    aadhar_no VARCHAR NULL,
    joining_date TIMESTAMP DEFAULT NOW(),
    created_at TIMESTAMP DEFAULT NOW(),
    branch_id INT NULL,
    type VARCHAR NULL,
    created_by INT NULL,
    updated_at TIMESTAMP DEFAULT NOW(),
    status BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (created_by) REFERENCES users(id),
    FOREIGN KEY (branch_id) REFERENCES branches(id)
);

CREATE TABLE containers (
    id SERIAL PRIMARY KEY NOT NULL,
    bag_no VARCHAR NULL,
    name VARCHAR NULL,
    agent_id VARCHAR NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    created_by INT NULL,
    FOREIGN KEY (created_by) REFERENCES users(id)
);

CREATE TABLE packages (
    id SERIAL PRIMARY KEY NOT NULL,
    container_id INT NULL,
    count INTEGER NULL,
    weight FLOAT NULL,
    value FLOAT NULL,
    contents VARCHAR,
    charges INTEGER NULL,
    shipper VARCHAR NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    created_by INT NULL,
    status BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (container_id) REFERENCES containers(id),
    FOREIGN KEY (created_by) REFERENCES users(id)
);

CREATE TABLE consignee (
    id SERIAL PRIMARY KEY NOT NULL,
    consignee_name VARCHAR NULL,
    consignee_mobile VARCHAR NULL,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE consignor (
    id SERIAL PRIMARY KEY NOT NULL,
    consignor_name VARCHAR NULL,
    consignor_mobile VARCHAR NULL,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE bookings (
    id SERIAL PRIMARY KEY NOT NULL,
    consignee_id SERIAL NOT NULL,
    consignor_id SERIAL NOT NULL,
    branch_id INT NULL,
    slip_no VARCHAR UNIQUE NULL,
    address VARCHAR NULL,
    transport_mode VARCHAR NULL,
    package_id INT NULL,
    paid_type VARCHAR NULL,
    cgst FLOAT DEFAULT 0.0,
    sgst FLOAT DEFAULT 0.0,
    igst FLOAT DEFAULT 0.0,
    total_value FLOAT NULL,
    destination_city_id INT NULL,
    destination_branch_id INT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    created_by INT NULL,
    status BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (branch_id) REFERENCES branches(id),
    FOREIGN KEY (package_id) REFERENCES packages(id),
    FOREIGN KEY (destination_city_id) REFERENCES cities(id),
    FOREIGN KEY (destination_branch_id) REFERENCES branches(id),
    FOREIGN KEY (consignee_id) REFERENCES consignee(id),
    FOREIGN KEY (consignor_id) REFERENCES consignor(id),
    FOREIGN KEY (created_by) REFERENCES users(id)
);
