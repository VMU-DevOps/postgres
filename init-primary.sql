-- Create replication role
CREATE ROLE replicator WITH REPLICATION PASSWORD 'replicatorpassword' LOGIN;

-- Configure pg_hba.conf for replication
COPY (SELECT 'host    replication    replicator    172.19.0.0/16    md5') TO '/var/lib/postgresql/data/pg_hba.conf' WITH (FORMAT text, DELIMITER ' ', HEADER false);
SELECT pg_reload_conf();

-- Create a sample table for testing
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL
);

-- Insert sample data
INSERT INTO users (username, email) VALUES ('testuser', 'testuser@example.com');