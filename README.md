# Cụm PostgreSQL 17 Cân Bằng Tải

Kho này chứa cấu hình Docker Compose để triển khai cụm PostgreSQL 17 với 1 node primary và 3 node replica, được cân bằng tải bằng Pgpool-II. Cấu hình này được thiết kế để triển khai qua Portainer.

## Các Tệp
- `docker-compose.yml`: Định nghĩa các dịch vụ primary, replica và Pgpool-II.
- `init-primary.sh`: Cấu hình node primary cho replication.
- `init-replica.sh`: Cấu hình các node replica cho streaming replication.

## Hướng Dẫn Cài Đặt
1. Triển khai stack trong Portainer bằng tệp `docker-compose.yml`.
2. Đảm bảo các tệp `init-primary.sh` và `init-replica.sh` nằm trong cùng thư mục với tệp Compose.
3. Kết nối đến Pgpool-II qua cổng `9999` để thực hiện các truy vấn được cân bằng tải.

## Lưu Ý
- Thay mật khẩu mặc định (`postgres`) bằng mật khẩu an toàn trong môi trường sản xuất.
- Điều chỉnh giá trị `PGPOOL_BACKEND_WEIGHT` trong `docker-compose.yml` để tùy chỉnh phân phối tải.