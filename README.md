# PostgreSQL HA Cluster with Pgpool-II, PgBouncer and pgAdmin

This project sets up a highly available PostgreSQL cluster using Docker Compose with the following components:

- **PostgreSQL 17**: 1 primary and 3 replicas
- **Pgpool-II**: Load balancer for PostgreSQL with read/write split
- **PgBouncer**: Lightweight connection pooler
- **pgAdmin 4**: Web-based UI for database management

## Structure
```
project-root/
├── docker-compose.yml       # Docker Compose Stack
├── Dockerfile               # Build file for postgres-primary
├── pg_hba.conf              # Config for allowing replication access
└── README.md                # This file
```

## Usage
1. Make sure Docker and Docker Compose are installed.

2. Clone this repository and navigate into the folder:
```bash
git clone <your-repo-url>
cd project-root
```

3. Build and run the stack:
```bash
docker compose up --build -d
```

4. Access pgAdmin:
- URL: http://localhost:8080
- Email: `admin@example.com`
- Password: `123456`

5. Connect through PgBouncer (recommended for clients):
- Host: `localhost`
- Port: `6432`
- User: `admin`
- Password: `123456`

## Notes
- Replication works via streaming replication using `pg_basebackup`.
- Ensure `primary-data` volume is removed if you want to reinitialize primary with new pg_hba.conf.

## License
MIT or your chosen license.
