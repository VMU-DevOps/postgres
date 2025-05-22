# Cụm PostgreSQL 17 Cân Bằng Tải

Kho này chứa cấu hình Docker Compose để triển khai cụm PostgreSQL 17 với 1 node primary và 3 node replica, được cân bằng tải bằng Pgpool-II. Cấu hình này được thiết kế để triển khai qua Portainer.

## Các Tệp
- `docker-compose.yml`: Định nghĩa các dịch vụ primary, replica và Pgpool-II.
- `pgpool-conf/pgpool.conf`: Cấu hình Pgpool-II để định tuyến write đến primary và read đến các replica.
- `init-primary.sh`: Cấu hình node primary cho replication.
- `init-replica.sh`: Cấu hình các node replica cho streaming replication.

## Hướng Dẫn Cài Đặt
1. Triển khai stack trong Portainer bằng tệp `docker-compose.yml`.
2. Đảm bảo các thư mục `pgpool-conf` (chứa `pgpool.conf`), và các tệp `init-primary.sh`, `init-replica.sh` nằm trong cùng thư mục với tệp Compose.
3. Kết nối đến Pgpool-II qua cổng `9999` để thực hiện các truy vấn được cân bằng tải:
   ```bash
   psql -h <docker-host> -p 15432 -U postgres

## Kiểm Tra Định Tuyến Write/Read
1. Write: Chạy truy vấn qua cổng 9999. Truy vấn này sẽ được định tuyến đến primary. 
INSERT INTO test_table (value) VALUES ('Test');

2. Read: Chạy truy vấn qua cổng 9999. Truy vấn này sẽ được phân phối đến các replica.
SELECT * FROM test_table; 