-- liquibase formatted sql

-- changeset changelog:users_table
CREATE TABLE users (
    id UUID PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    age INT,
    email VARCHAR(100) NOT NULL UNIQUE,
    document VARCHAR(20) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
-- rollback DROP TABLE users;

-- changeset changelog:loan_table
CREATE TABLE loan (
    id UUID PRIMARY KEY,
    amount DECIMAL(15, 2) NOT NULL,
    approved BOOLEAN DEFAULT FALSE,
    user_id UUID NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
-- rollback DROP TABLE loan;

-- changeset changelog:add_foreign_key_constraint
ALTER TABLE loan
ADD CONSTRAINT fk_loan_user FOREIGN KEY (user_id) REFERENCES users(id);
-- rollback ALTER TABLE loan DROP CONSTRAINT fk_loan_user;

-- changeset changelog:add_records_to_users

INSERT INTO users (id, name, last_name, age, email, document, created_at, updated_at)
VALUES
    ('550e8400-e29b-41d4-a716-446655440001', 'John', 'Doe', 30, 'john.doe@example.com', '1234567890', NOW(), NOW()),
    ('550e8400-e29b-41d4-a716-446655440002', 'Jane', 'Smith', 25, 'jane.smith@example.com', '0987654321', NOW(), NOW()),
    ('550e8400-e29b-41d4-a716-446655440003', 'Alice', 'Johnson', 28, 'alice.johnson@example.com', '1122334455', NOW(), NOW()),
    ('550e8400-e29b-41d4-a716-446655440004', 'Bob', 'Brown', 35, 'bob.brown@example.com', '5566778899', NOW(), NOW()),
    ('550e8400-e29b-41d4-a716-446655440005', 'Charlie', 'Davis', 40, 'charlie.davis@example.com', '9988776655', NOW(), NOW());
--DELETE FROM users WHERE id IN ('550e8400-e29b-41d4-a716-446655440001','550e8400-e29b-41d4-a716-446655440002','550e8400-e29b-41d4-a716-446655440003','550e8400-e29b-41d4-a716-446655440004','550e8400-e29b-41d4-a716-446655440005');

-- changeset changelog:add_records_to_loan

INSERT INTO loan (id, amount, approved, user_id, created_at, updated_at)
VALUES
    ('660e8400-e29b-41d4-a716-446655440001', 1000.00, TRUE, '550e8400-e29b-41d4-a716-446655440001', NOW(), NOW()),
    ('660e8400-e29b-41d4-a716-446655440002', 500.00, FALSE, '550e8400-e29b-41d4-a716-446655440002', NOW(), NOW()),
    ('660e8400-e29b-41d4-a716-446655440003', 1500.00, TRUE, '550e8400-e29b-41d4-a716-446655440003', NOW(), NOW()),
    ('660e8400-e29b-41d4-a716-446655440004', 2000.00, TRUE, '550e8400-e29b-41d4-a716-446655440004', NOW(), NOW()),
    ('660e8400-e29b-41d4-a716-446655440005', 750.00, FALSE, '550e8400-e29b-41d4-a716-446655440005', NOW(), NOW());
--rollback DELETE FROM loan WHERE user_id IN ('550e8400-e29b-41d4-a716-446655440001','550e8400-e29b-41d4-a716-446655440002','550e8400-e29b-41d4-a716-446655440003','550e8400-e29b-41d4-a716-446655440004','550e8400-e29b-41d4-a716-446655440005');

