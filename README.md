# PostgreSQL High Availability Stack

This repository contains a Docker Compose configuration for deploying a high-availability PostgreSQL 17 cluster with load balancing and connection pooling, manageable via Portainer. The stack includes:

- **1 Primary PostgreSQL node**
- **3 Replica PostgreSQL nodes** (using streaming replication)
- **Pgpool-II** for load balancing read queries and routing write queries to the primary
- **PgBouncer** for connection pooling
- **pgAdmin** for web-based database management

## Prerequisites

- Docker and Docker Compose installed on the host
- Portainer installed for stack deployment
- Git installed to clone the repository
- Basic knowledge of PostgreSQL and Docker

## Setup Instructions

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/your-username/postgres-ha-stack.git
   cd postgres-ha-stack


Update Passwords (Recommended for security):

Edit docker-compose.yml to replace securepassword, pgpool_securepassword, and adminpassword with strong, unique passwords.
Update userlist.txt with MD5-hashed passwords for admin and pgpool_admin. Generate MD5 passwords using:echo -n "yourpassword" | md5sum

Then format as: "username" "md5<hashed_password>"


Deploy via Portainer:

Log in to Portainer.
Navigate to Stacks > Add Stack.
Choose the Git Repository option.
Enter the repository URL: https://github.com/your-username/postgres-ha-stack.git
Set the Compose Path to docker-compose.yml.
Deploy the stack.


Alternative: Deploy via Docker Compose:If not using Portainer, run:
docker-compose up -d



Accessing Services

PostgreSQL: Connect via PgBouncer at localhost:6432 (or host IP) with:postgresql://admin:securepassword@localhost:6432/mydb


pgAdmin: Access at http://localhost:8080 with credentials admin@example.com/adminpassword.
Pgpool-II Admin: Use psql -h localhost -p 9999 -U pgpool_admin pcp (password: pgpool_securepassword).

Verifying Setup

Check Replication:

On the primary node:SELECT * FROM pg_stat_replication;


On replicas (connect directly to their ports if exposed):SELECT pg_is_in_recovery();




Test Load Balancing:

Run read queries (e.g., SELECT * FROM users) through PgBouncer (localhost:6432) to confirm Pgpool-II distributes them across replicas.
Run write queries (e.g., INSERT INTO users) to confirm they go to the primary.


Monitor Pgpool-II:
psql -h localhost -p 9999 -U pgpool_admin pcp -c 'SHOW pool_nodes'


Monitor PgBouncer:
psql -h localhost -p 6432 -U admin pgbouncer -c 'SHOW POOLS'



Notes

Replication Setup: The init-replica.sql is a placeholder. For production, manually set up streaming replication using pg_basebackup or similar to initialize replicas from the primary.
Security: Replace default passwords and use secure ones in production.
Scalability: Adjust PGPOOL_NUM_INIT_CHILDREN and PGBOUNCER_MAX_CLIENT_CONN based on expected load.
High Availability: For production, consider running multiple Pgpool-II instances and using a load balancer like HAProxy.

Troubleshooting

If containers fail to start, check logs with docker logs <container_name>.
Ensure the postgres-net network is created and all services are connected.
Verify that volumes (postgres-primary-data, etc.) are accessible.

License
MIT License```
