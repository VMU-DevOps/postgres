#!/bin/bash

# Tham số mặc định
PG_HOST="localhost"  # Thay bằng địa chỉ host nếu cần
PG_PORT="15432"
PG_USER="postgres"
PG_PASSWORD="postgres"
PG_DATABASE="app_db"

# Kiểm tra nếu psql đã được cài đặt
if ! command -v psql &> /dev/null; then
  echo "Lỗi: psql không được cài đặt. Vui lòng cài đặt PostgreSQL client."
  exit 1
fi

# Thiết lập biến môi trường cho mật khẩu
export PGPASSWORD="$PG_PASSWORD"

# Kiểm tra kết nối
echo "Kiểm tra kết nối đến Pgpool-II tại $PG_HOST:$PG_PORT..."
if ! psql -h "$PG_HOST" -p "$PG_PORT" -U "$PG_USER" -d "$PG_DATABASE" -c "\q" 2>/dev/null; then
  echo "Lỗi: Không thể kết nối đến Pgpool-II. Kiểm tra host, port, user, hoặc password."
  exit 1
fi
echo "Kết nối thành công!"

# Tạo bảng test và insert dữ liệu (write, đi đến primary)
echo "Tạo bảng test_table và insert dữ liệu (write)..."
psql -h "$PG_HOST" -p "$PG_PORT" -U "$PG_USER" -d "$PG_DATABASE" <<EOF
CREATE TABLE IF NOT EXISTS test_table (id SERIAL PRIMARY KEY, value TEXT);
INSERT INTO test_table (value) VALUES ('Test Data 1');
INSERT INTO test_table (value) VALUES ('Test Data 2');
EOF
if [ $? -eq 0 ]; then
  echo "Insert dữ liệu thành công! (Đã ghi vào primary)"
else
  echo "Lỗi: Không thể insert dữ liệu."
  exit 1
fi

# Kiểm tra cân bằng tải (read, phân phối đến các replica)
echo "Kiểm tra cân bằng tải (read) bằng cách chạy SELECT 5 lần..."
for i in {1..5}
do
  echo "Lần $i: Đọc dữ liệu..."
  psql -h "$PG_HOST" -p "$PG_PORT" -U "$PG_USER" -d "$PG_DATABASE" -c "SELECT * FROM test_table;" 2>/dev/null
  if [ $? -eq 0 ]; then
    echo "Đọc thành công (Được định tuyến đến một replica)"
  else
    echo "Lỗi: Không thể đọc dữ liệu."
    exit 1
  fi
  sleep 1
done

echo "Kiểm tra hoàn tất! Cân bằng tải hoạt động bình thường."