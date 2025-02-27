CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    mobile VARCHAR NOT NULL UNIQUE,
    password VARCHAR NOT NULL,
    createdAt TIMESTAMP DEFAULT NOW(),
    createdBy VARCHAR NOT NULL,
    updatedAt TIMESTAMP DEFAULT NOW(),
    status BOOLEAN DEFAULT TRUE
);

CREATE TABLE userInfo (
    id SERIAL PRIMARY KEY NOT NULL,
    firstName VARCHAR NOT NULL,
    lastName VARCHAR NOT NULL,
    gender VARCHAR NOT NULL,
    birthDate TIMESTAMP NOT NULL,
    address VARCHAR NOT NULL,
    email VARCHAR NOT NULL,
    createdAt TIMESTAMP DEFAULT NOW(),
    createdBy SERIAL NOT NULL,
    updatedAt TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY (createdBy) REFERENCES users(id),
    FOREIGN KEY (id) REFERENCES users(id)
);


CREATE TABLE states (
    id SERIAL PRIMARY KEY NOT NULL,
    name VARCHAR NOT NULL,
    createdAt TIMESTAMP DEFAULT NOW(),
    createdBy SERIAL NOT NULL,
    FOREIGN KEY (createdBy) REFERENCES users(id)
);

CREATE TABLE cities (
    id SERIAL PRIMARY KEY NOT NULL,
    name VARCHAR NOT NULL,
    state SERIAL NOT NULL,
    createdAt TIMESTAMP DEFAULT NOW(),
    createdBy SERIAL NOT NULL,
    FOREIGN KEY (createdBy) REFERENCES users(id),
    FOREIGN KEY (state) REFERENCES states(id)
);

CREATE TABLE companies (
    id SERIAL PRIMARY KEY NOT NULL,
    name VARCHAR NOT NULL,
    address VARCHAR NOT NULL,
    city SERIAL NOT NULL,
    state SERIAL NOT NULL,
    pinCode VARCHAR NOT NULL,
    companyContactNo VARCHAR NOT NULL,
    companyEmail VARCHAR NOT NULL,
    companyGSTNo VARCHAR NOT NULL,
    companyCINNo VARCHAR NOT NULL,
    companyUdyamNo VARCHAR NOT NULL,
    companyLogo BYTEA NOT NULL,
    createdAt TIMESTAMP DEFAULT NOW(),
    createdBy SERIAL NOT NULL,
    updatedAt TIMESTAMP DEFAULT NOW(),
    status BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (city) REFERENCES cities(id),
    FOREIGN KEY (state) REFERENCES states(id)
);

CREATE TABLE branches (
    id SERIAL PRIMARY KEY NOT NULL,
    branchName VARCHAR NOT NULL,
    branchAliasName VARCHAR NOT NULL,
    branchAddress VARCHAR NOT NULL,
    branchCity SERIAL NOT NULL,
    branchestate SERIAL NOT NULL,
    branchPinCode VARCHAR NOT NULL,
    branchContactNo VARCHAR NOT NULL,
    branchEmailId VARCHAR NOT NULL,
    branchGSTNo VARCHAR NOT NULL,
    branchCINNo VARCHAR NOT NULL,
    branchUdyamNo VARCHAR NOT NULL,
    branchLogo BYTEA NOT NULL,
    createdAt TIMESTAMP DEFAULT NOW(),
    createdBy SERIAL NOT NULL,
    updatedAt TIMESTAMP DEFAULT NOW(),
    status BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (branchCity) REFERENCES cities(id),
    FOREIGN KEY (branchestate) REFERENCES states(id)
);

CREATE TABLE pages (
    id SERIAL PRIMARY KEY NOT NULL,
    name VARCHAR NOT NULL,
    createdAt TIMESTAMP DEFAULT NOW(),
    createdBy SERIAL NOT NULL,
    updatedAt TIMESTAMP DEFAULT NOW(),
    status BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (createdBy) REFERENCES users(id)
);

CREATE TABLE permissions (
    id SERIAL PRIMARY KEY NOT NULL,
    pageId SERIAL NOT NULL,
    permissionCode VARCHAR NOT NULL,
    userId SERIAL NOT NULL,
    createdAt TIMESTAMP DEFAULT NOW(),
    createdBy SERIAL NOT NULL,
    updatedAt TIMESTAMP DEFAULT NOW(),
    status BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (pageId) REFERENCES pages(id),
    FOREIGN KEY (userId) REFERENCES users(id),
    FOREIGN KEY (createdBy) REFERENCES users(id)
);

CREATE TABLE employees (
    eid SERIAL PRIMARY KEY NOT NULL,
    userId SERIAL NOT NULL,
    address VARCHAR NOT NULL,
    aadhaarNo VARCHAR NOT NULL,
    joiningDate TIMESTAMP DEFAULT NOW(),
    createdAt TIMESTAMP DEFAULT NOW(),
    type VARCHAR NOT NULL,
    createdBy SERIAL NOT NULL,
    updatedAt TIMESTAMP DEFAULT NOW(),
    status BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (userId) REFERENCES users(id),
    FOREIGN KEY (createdBy) REFERENCES users(id)
);

CREATE TABLE container (
    id SERIAL PRIMARY KEY NOT NULL,
    bag_no VARCHAR NOT NULL,
    name VARCHAR NOT NULL,
    agentid VARCHAR NOT NULL,
    createdAt TIMESTAMP DEFAULT NOW(),
    createdBy SERIAL NOT NULL,
    FOREIGN KEY (createdBy) REFERENCES users(id)
);

CREATE TABLE packages (
    id SERIAL PRIMARY KEY NOT NULL,
    container_id SERIAL NOT NULL,
    count INTEGER NOT NULL,
    value INTEGER NOT NULL,
    contains VARCHAR NOT NULL,
    charges INTEGER NOT NULL,
    shipper VARCHAR NOT NULL,
    CGST INTEGER NOT NULL,
    SGST INTEGER NOT NULL,
    IGST INTEGER NOT NULL,
    createdAt TIMESTAMP DEFAULT NOW(),
    createdBy SERIAL NOT NULL,
    status BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (container_id) REFERENCES container(id),
    FOREIGN KEY (createdBy) REFERENCES users(id)
);

CREATE TABLE booking (
    id SERIAL PRIMARY KEY NOT NULL,
    branchId SERIAL NOT NULL,
    slipNo VARCHAR NOT NULL,
    consgineeName VARCHAR NOT NULL,
    consgineeMbile VARCHAR NOT NULL,
    consingnorName VARCHAR NOT NULL,
    consingnorMbile VARCHAR NOT NULL,
    transportMode VARCHAR NOT NULL,
    packages_id SERIAL NOT NULL,
    paidType VARCHAR NOT NULL,
    desinationCityId SERIAL NOT NULL,
    destinationBranchId SERIAL NOT NULL,
    createdAt TIMESTAMP DEFAULT NOW(),
    createdBy SERIAL NOT NULL,
    status BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (branchId) REFERENCES branches(id),
    FOREIGN KEY (packages_id) REFERENCES packages(id),
    FOREIGN KEY (desinationCityId) REFERENCES cities(id),
    FOREIGN KEY (destinationBranchId) REFERENCES branches(id),
    FOREIGN KEY (createdBy) REFERENCES users(id)
);
