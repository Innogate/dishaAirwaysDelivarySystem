CREATE TABLE users (
    id VARCHAR PRIMARY KEY,
    email VARCHAR NOT NULL UNIQUE,
    password VARCHAR NOT NULL,
    createdAt TIMESTAMP DEFAULT now(),
    createdBy VARCHAR NOT NULL,
    updatedAt TIMESTAMP DEFAULT now(),
    status BOOLEAN DEFAULT true
);

CREATE TABLE usersInfo (
    id VARCHAR PRIMARY KEY REFERENCES users(id),
    firstName VARCHAR NOT NULL,
    lastName VARCHAR NOT NULL,
    phone VARCHAR NOT NULL,
    address VARCHAR NOT NULL,
    email VARCHAR NOT NULL,
    createdAt TIMESTAMP DEFAULT now(),
    createdBy VARCHAR NOT NULL REFERENCES users(id),
    updatedAt TIMESTAMP DEFAULT now(),
    status BOOLEAN DEFAULT true
);

CREATE TABLE brachs (
    id SERIAL PRIMARY KEY,
    name VARCHAR NOT NULL,
    brachCode VARCHAR NOT NULL,
    brachHead VARCHAR NOT NULL REFERENCES users(id),
    brachCity VARCHAR NOT NULL,
    brachState VARCHAR NOT NULL,
    brachCountry VARCHAR NOT NULL,
    createdAt TIMESTAMP DEFAULT now(),
    createdBy VARCHAR NOT NULL REFERENCES users(id),
    updatedAt TIMESTAMP DEFAULT now(),
    status BOOLEAN DEFAULT true
);

CREATE TABLE pages (
    id SERIAL PRIMARY KEY,
    name VARCHAR NOT NULL,
    createdAt TIMESTAMP DEFAULT now(),
    createdBy VARCHAR NOT NULL REFERENCES users(id),
    updatedAt TIMESTAMP DEFAULT now(),
    status BOOLEAN DEFAULT true
);

CREATE TABLE permissions (
    id SERIAL PRIMARY KEY,
    pageId INTEGER NOT NULL REFERENCES pages(id),
    userId VARCHAR NOT NULL REFERENCES users(id),
    createdAt TIMESTAMP DEFAULT now(),
    createdBy VARCHAR NOT NULL REFERENCES users(id),
    updatedAt TIMESTAMP DEFAULT now(),
    status BOOLEAN DEFAULT true
);

CREATE TABLE employees (
    eid SERIAL PRIMARY KEY,
    userId VARCHAR NOT NULL REFERENCES users(id),
    createdAt TIMESTAMP DEFAULT now(),
    createdBy VARCHAR NOT NULL REFERENCES users(id),
    updatedAt TIMESTAMP DEFAULT now(),
    status BOOLEAN DEFAULT true
);
