# pgAdmin + PostgreSQL Docker Stack with Backup Symlink

## ✅ Features

- PostgreSQL with configurable version and timezone
- pgAdmin 4 auto-creates symlink to `/backups`
- Can restore `.backup` files directly from pgAdmin UI

## 🧾 Environment Variables

| Variable | Default | Description |
|----------|---------|-------------|
| POSTGRES_VERSION | 17 | PostgreSQL version |
| POSTGRES_USER | admin | DB username |
| POSTGRES_PASSWORD | 1 | DB password |
| POSTGRES_DB | system | DB name |
| POSTGRES_PORT | 5432 | Host port for PostgreSQL |
| TZ | Asia/Ho_Chi_Minh | Timezone |
| PGADMIN_EMAIL | admin@vimaru.edu.vn | pgAdmin login email |
| PGADMIN_PASSWORD | 1 | pgAdmin password |
| PGADMIN_PORT | 5431 | Host port for pgAdmin |
| POSTGRESUS_PORT | 5430 | Host port for Postgresus |

## 🔧 Khởi tạo & phân quyền thư mục backup Postgres / PgAdmin

Sau khi deploy `docker compose`, cần tạo thư mục backup và cấp quyền để PgAdmin / Postgres ghi dữ liệu.
```bash
# 1️⃣ Tạo thư mục backup (nếu chưa có)
sudo mkdir -p /data/backups/postgres

# 2️⃣ Copy hoặc tạo script init (nếu cần)
sudo nano /data/backups/postgres/.pgadmin-init.sh

# 3️⃣ Cấp quyền execute cho script
sudo chmod +x /data/backups/postgres/.pgadmin-init.sh

# 4️⃣ Gán ownership cho user pgadmin trong container (UID 5050)
sudo chown -R 5050:5050 /data/backups/postgres

# 5️⃣ Cấp quyền đọc/ghi/thực thi
sudo chmod -R 775 /data/backups/postgres

# 6️⃣ Chạy script init trong container PgAdmin
sudo docker exec -u 0 -it postgres-ui /bin/sh /pgadmin-init.sh

# 7️⃣ Kiểm tra lại thư mục backup
ls -lah /data/backups/postgres
```

## 🚀 Usage

```bash
docker compose --env-file .env up -d
docker logs postgres-ui
```

## 🔁 Restore in pgAdmin

In the Restore dialog, browse to:

```
/var/lib/pgadmin/storage/admin_vimaru.edu.vn/backups_link/
```

Then select `.backup` files located in `./data/backups`
