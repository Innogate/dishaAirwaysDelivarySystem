CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    mobile VARCHAR NOT NULL UNIQUE,
    password VARCHAR NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    created_by INT NOT NULL,
    updated_at TIMESTAMP DEFAULT NOW(),
    status BOOLEAN DEFAULT TRUE
);

CREATE TABLE user_info (
    id SERIAL PRIMARY KEY NOT NULL,
    first_name VARCHAR NOT NULL,
    last_name VARCHAR NOT NULL,
    gender VARCHAR NOT NULL,
    birth_date TIMESTAMP NOT NULL,
    address VARCHAR NOT NULL,
    email VARCHAR NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    created_by INT NOT NULL,
    updated_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY (created_by) REFERENCES users(id),
    FOREIGN KEY (id) REFERENCES users(id)
);

CREATE TABLE states (
    id SERIAL PRIMARY KEY NOT NULL,
    name VARCHAR NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE cities (
    id SERIAL PRIMARY KEY NOT NULL,
    name VARCHAR NOT NULL,
    state_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY (state_id) REFERENCES states(id)
);

CREATE TABLE companies (
    id SERIAL PRIMARY KEY NOT NULL,
    name VARCHAR NOT NULL,
    address VARCHAR NOT NULL,
    city_id INT NOT NULL,
    state_id INT NOT NULL,
    pin_code VARCHAR NOT NULL,
    contact_no VARCHAR NOT NULL,
    email VARCHAR NOT NULL,
    gst_no VARCHAR NOT NULL,
    cin_no VARCHAR NOT NULL,
    udyam_no VARCHAR NOT NULL,
    logo VARCHAR NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    created_by INT NOT NULL,
    updated_at TIMESTAMP DEFAULT NOW(),
    status BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (city_id) REFERENCES cities(id),
    FOREIGN KEY (state_id) REFERENCES states(id)
);

CREATE TABLE branches (
    id SERIAL PRIMARY KEY NOT NULL,
    name VARCHAR NOT NULL,
    alias_name VARCHAR NOT NULL,
    address VARCHAR NOT NULL,
    city_id INT NOT NULL,
    state_id INT NOT NULL,
    company_id INT NOT NULL,
    pin_code VARCHAR NOT NULL,
    contact_no VARCHAR NOT NULL,
    email VARCHAR NOT NULL,
    gst_no VARCHAR NOT NULL,
    cin_no VARCHAR NOT NULL,
    udyam_no VARCHAR NOT NULL,
    cgst FLOAT DEFAULT 0.0,
    sgst FLOAT DEFAULT 0.0,
    igst FLOAT DEFAULT 0.0,
    logo VARCHAR NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    created_by INT NOT NULL,
    updated_at TIMESTAMP DEFAULT NOW(),
    status BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (city_id) REFERENCES cities(id),
    FOREIGN KEY (state_id) REFERENCES states(id),
    FOREIGN KEY (company_id) REFERENCES companies(id),
    FOREIGN KEY (created_by) REFERENCES users(id)
);

CREATE TABLE pages (
    id SERIAL PRIMARY KEY NOT NULL,
    name VARCHAR NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    created_by INT NOT NULL,
    updated_at TIMESTAMP DEFAULT NOW(),
    status BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (created_by) REFERENCES users(id)
);

CREATE TABLE permissions (
    id SERIAL PRIMARY KEY NOT NULL,
    page_id INT NOT NULL,
    permission_code VARCHAR NOT NULL,
    user_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    created_by INT NOT NULL,
    updated_at TIMESTAMP DEFAULT NOW(),
    status BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (page_id) REFERENCES pages(id),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (created_by) REFERENCES users(id)
);

CREATE TABLE employees (
    id SERIAL PRIMARY KEY NOT NULL,
    user_id INT NOT NULL,
    address VARCHAR NOT NULL,
    aadhar_no VARCHAR NOT NULL,
    joining_date TIMESTAMP DEFAULT NOW(),
    created_at TIMESTAMP DEFAULT NOW(),
    branch_id INT NOT NULL,
    type VARCHAR NOT NULL,
    created_by INT NOT NULL,
    updated_at TIMESTAMP DEFAULT NOW(),
    status BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (created_by) REFERENCES users(id),
    FOREIGN KEY (branch_id) REFERENCES branches(id)
);

CREATE TABLE containers (
    id SERIAL PRIMARY KEY NOT NULL,
    bag_no VARCHAR NOT NULL,
    name VARCHAR NOT NULL,
    agent_id VARCHAR NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    created_by INT NOT NULL,
    FOREIGN KEY (created_by) REFERENCES users(id)
);

CREATE TABLE packages (
    id SERIAL PRIMARY KEY NOT NULL,
    container_id INT NULL,
    count INTEGER NOT NULL,
    weight FLOAT NOT NULL,
    value FLOAT NOT NULL,
    contents VARCHAR NOT NULL,
    charges INTEGER NOT NULL,
    shipper VARCHAR NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    created_by INT NOT NULL,
    status BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (container_id) REFERENCES containers(id),
    FOREIGN KEY (created_by) REFERENCES users(id)
);

CREATE TABLE bookings (
    id SERIAL PRIMARY KEY NOT NULL,
    branch_id INT NOT NULL,
    slip_no VARCHAR UNIQUE NOT NULL,
    consignee_name VARCHAR NOT NULL,
    consignee_mobile VARCHAR NOT NULL,
    consignor_name VARCHAR NOT NULL,
    consignor_mobile VARCHAR NOT NULL,
    address VARCHAR NOT NULL,
    transport_mode VARCHAR NOT NULL,
    package_id INT NOT NULL,
    paid_type VARCHAR NOT NULL,
    cgst FLOAT DEFAULT 0.0,
    sgst FLOAT DEFAULT 0.0,
    igst FLOAT DEFAULT 0.0,
    total_value FLOAT NOT NULL,
    destination_city_id INT NOT NULL,
    destination_branch_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    created_by INT NOT NULL,
    status BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (branch_id) REFERENCES branches(id),
    FOREIGN KEY (package_id) REFERENCES packages(id),
    FOREIGN KEY (destination_city_id) REFERENCES cities(id),
    FOREIGN KEY (destination_branch_id) REFERENCES branches(id),
    FOREIGN KEY (created_by) REFERENCES users(id)
);
