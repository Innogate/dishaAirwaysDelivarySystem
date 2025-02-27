CREATE TABLE IF NOT EXISTS users (
    id VARCHAR PRIMARY KEY,
    mobile VARCHAR NOT NULL UNIQUE,
    password VARCHAR NOT NULL,
    createdAt TIMESTAMP DEFAULT now(),
    createdBy VARCHAR NOT NULL,
    updatedAt TIMESTAMP DEFAULT now(),
    status BOOLEAN DEFAULT true
);

CREATE TABLE IF NOT EXISTS usersInfo (
    id VARCHAR PRIMARY KEY REFERENCES users(id),
    firstName VARCHAR NOT NULL,
    lastName VARCHAR NOT NULL,
    address VARCHAR NOT NULL,
    email VARCHAR NOT NULL,
    createdAt TIMESTAMP DEFAULT now(),
    createdBy VARCHAR NOT NULL REFERENCES users(id),
    updatedAt TIMESTAMP DEFAULT now(),
    status BOOLEAN DEFAULT true
);

CREATE TABLE IF NOT EXISTS branches (
    id SERIAL PRIMARY KEY,
    name VARCHAR NOT NULL,
    branchCode VARCHAR NOT NULL,
    branchHead VARCHAR NOT NULL REFERENCES users(id),
    branchCity VARCHAR NOT NULL,
    branchState VARCHAR NOT NULL,
    branchCountry VARCHAR NOT NULL,
    createdAt TIMESTAMP DEFAULT now(),
    createdBy VARCHAR NOT NULL REFERENCES users(id),
    updatedAt TIMESTAMP DEFAULT now(),
    status BOOLEAN DEFAULT true
);

CREATE TABLE IF NOT EXISTS pages (
    id SERIAL PRIMARY KEY,
    name VARCHAR NOT NULL,
    createdAt TIMESTAMP DEFAULT now(),
    createdBy VARCHAR NOT NULL REFERENCES users(id),
    updatedAt TIMESTAMP DEFAULT now(),
    status BOOLEAN DEFAULT true
);

CREATE TABLE IF NOT EXISTS permissions (
    id SERIAL PRIMARY KEY,
    pageId INTEGER NOT NULL REFERENCES pages(id),
    userId VARCHAR NOT NULL REFERENCES users(id),
    permitioncode VARCHAR NOT NULL,
    createdAt TIMESTAMP DEFAULT now(),
    createdBy VARCHAR NOT NULL REFERENCES users(id),
    updatedAt TIMESTAMP DEFAULT now(),
    status BOOLEAN DEFAULT true
);

CREATE TABLE IF NOT EXISTS employees (
    eid SERIAL PRIMARY KEY,
    userId VARCHAR NOT NULL REFERENCES users(id),
    createdAt TIMESTAMP DEFAULT now(),
    createdBy VARCHAR NOT NULL REFERENCES users(id),
    updatedAt TIMESTAMP DEFAULT now(),
    status BOOLEAN DEFAULT true
);

CREATE TABLE IF NOT EXISTS containers (
    id SERIAL PRIMARY KEY,
    bag_no VARCHAR NOT NULL,
    name VARCHAR NOT NULL,
    agentId VARCHAR NOT NULL,
    createdAt TIMESTAMP DEFAULT now(),
    createdBy VARCHAR NOT NULL REFERENCES users(id)
);

CREATE TABLE IF NOT EXISTS packages (
    id VARCHAR PRIMARY KEY,
    container_id SERIAL REFERENCES containers(id),
    count INTEGER NOT NULL,
    value INTEGER NOT NULL,
    contains VARCHAR NOT NULL,
    charges INTEGER NOT NULL,
    shipper VARCHAR NOT NULL,
    CGST INTEGER NOT NULL,
    SGST INTEGER NOT NULL,
    IGST INTEGER NOT NULL,
    createdAt TIMESTAMP DEFAULT now(),
    createdBy VARCHAR NOT NULL REFERENCES users(id),
    status BOOLEAN DEFAULT true
);

CREATE TABLE IF NOT EXISTS booking (
    id SERIAL PRIMARY KEY,
    packages_id VARCHAR NOT NULL REFERENCES packages(id),
    createdAt TIMESTAMP DEFAULT now(),
    createdBy VARCHAR NOT NULL REFERENCES users(id),
    status BOOLEAN DEFAULT true
);