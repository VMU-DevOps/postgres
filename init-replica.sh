#!/bin/bash
# Kiểm tra xem primary có sẵn sàng không
until pg_isready -h primary -p 5432 -U postgres; do
  echo "Đang chờ primary sẵn sàng..."
  sleep 2
done

# Xóa dữ liệu cũ và sao chép từ primary
rm -rf /var/lib/postgresql/data/*
if ! pg_basebackup -h primary -D /var/lib/postgresql/data -U postgres -P --wal-method=stream; then
  echo "Lỗi: Không thể chạy pg_basebackup" >&2
  exit 1
fi

# Cấu hình replica
echo "primary_conninfo = 'host=primary port=5432 user=postgres password=postgres'" >> "$PGDATA/postgresql.conf"
echo "hot_standby = on" >> "$PGDATA/postgresql.conf"
echo "recovery_target_timeline = 'latest'" >> "$PGDATA/postgresql.conf"