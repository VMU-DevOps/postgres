-- Create replication role
CREATE ROLE replicator WITH REPLICATION PASSWORD 'replicatorpassword' LOGIN;

-- Configure pg_hba.conf for replication
SELECT pg_reload_conf();

-- Create a sample table for testing
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL
);

-- Insert sample data
INSERT INTO users (username, email) VALUES ('testuser', 'testuser@example.com');