-- liquibase formatted sql

-- changeset changelog:1
ALTER TABLE students ADD COLUMN city VARCHAR(255);
-- rollback ALTER TABLE students DROP COLUMN city;

-- changeset changelog:2
CREATE TABLE departments (
    id VARCHAR(36) PRIMARY KEY, -- H2 doesn't support UUID directly
    name VARCHAR(100) NOT NULL UNIQUE,
    code VARCHAR(10) NOT NULL UNIQUE,
    description VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- rollback DROP TABLE departments;

-- changeset changelog:3
ALTER TABLE teachers ADD COLUMN departments_id VARCHAR(36);

ALTER TABLE teachers
ADD CONSTRAINT fk_teachers_departments
FOREIGN KEY (departments_id)
REFERENCES departments(id);

-- rollback ALTER TABLE teachers DROP CONSTRAINT fk_teachers_departments;
-- rollback ALTER TABLE teachers DROP COLUMN departments_id;

-- changeset changelog:4
CREATE TABLE sessions (
    id UUID PRIMARY KEY,
    student_id UUID NOT NULL,
    teacher_id UUID NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT unique_sessions UNIQUE (student_id, teacher_id)
);

-- rollback DROP TABLE sessions;

-- changeset changelog:5
ALTER TABLE sessions
ADD CONSTRAINT fk_student
FOREIGN KEY (student_id)
REFERENCES students(id);

ALTER TABLE sessions
ADD CONSTRAINT fk_teacher
FOREIGN KEY (teacher_id)
REFERENCES teachers(id);

-- rollback ALTER TABLE sessions DROP CONSTRAINT fk_student;
-- rollback ALTER TABLE sessions DROP CONSTRAINT fk_teacher;


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
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_loan_user FOREIGN KEY (user_id) REFERENCES users(id)
);
-- rollback DROP TABLE loan;
