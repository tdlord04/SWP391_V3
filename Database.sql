Create database Project_Ver3;
GO

USE Project_Ver3;
GO

CREATE TABLE Users (
    id INT IDENTITY(1,1) PRIMARY KEY, -- IDENTITY(seed, increment) tự động tăng, id là khóa chính
    user_name NVARCHAR(50) NOT NULL UNIQUE, -- Tên người dùng, không được để trống và phải là duy nhất
    pass NVARCHAR(255) NOT NULL, -- Mật khẩu (đã được hash), không được để trống. NVARCHAR để hỗ trợ Unicode.
    full_name NVARCHAR(100), -- Tên đầy đủ
    birth DATE, -- Ngày sinh, chỉ lưu ngày tháng năm
    gender NVARCHAR(10), -- Giới tính
    email NVARCHAR(100) UNIQUE, -- Email, phải là duy nhất
    phone NVARCHAR(20), -- Số điện thoại
    address NVARCHAR(255), -- Địa chỉ
    role NVARCHAR(50) NOT NULL DEFAULT 'customer', -- Vai trò của người dùng. Mặc định là 'customer'. Không được để trống.
    isDeleted BIT DEFAULT 0 -- Cờ để đánh dấu xóa mềm (soft delete). BIT là kiểu Boolean trong SQL Server, 0 là FALSE, 1 là TRUE. Mặc định là 0 (chưa xóa).
);
GO

-- Tạo bảng RoomTypes
CREATE TABLE RoomTypes (
    id INT PRIMARY KEY IDENTITY(1,1),
    room_type NVARCHAR(100) NOT NULL
);

-- Tạo bảng Rooms
CREATE TABLE Rooms (
    id INT PRIMARY KEY IDENTITY(1,1),
    room_number NVARCHAR(50) NOT NULL,
    room_type_id INT NOT NULL,
    room_price DECIMAL(10,2) NOT NULL,
    room_status NVARCHAR(50) NOT NULL,
    capacity INT NOT NULL,
    description NVARCHAR(MAX),
    image_url NVARCHAR(255),
    isDelete BIT NOT NULL DEFAULT 0,
    FOREIGN KEY (room_type_id) REFERENCES RoomTypes(id)
);


-- Thêm dữ liệu vào bảng User
INSERT INTO Users (user_name, pass, full_name, birth, gender, email, phone, address, role, isDeleted)
VALUES ('customer01', 'Customerpass01', N'Nguyễn Thị Thu', '1995-03-10', N'Nữ', 'customer01@gmail.com', '0901234567', N'150 Đường Lý Tự Trọng, Quận 1, TP.HCM', N'customer', 0);
GO
INSERT INTO Users (user_name, pass, full_name, birth, gender, email, phone, address, role, isDeleted)
VALUES ('staff01', 'Staffpass01', N'Trần Văn Bình', '1992-07-25', N'Nam', 'staff01@gmail.com', '0987654321', N'200 Phố Xã Đàn, Quận Đống Đa, Hà Nội', N'staff', 0);
GO
INSERT INTO Users (user_name, pass, full_name, birth, gender, email, phone, address, role, isDeleted)
VALUES ('admin01', 'Adminpass01', N'Lê Hồng Anh', '1988-11-01', N'Nữ', 'admin01@gmail.com', '0977889900', N'300 Đại Lộ Thăng Long, Quận Nam Từ Liêm, Hà Nội', N'admin', 0);
GO

-- Thêm dữ liệu vào bảng RoomTypes
INSERT INTO RoomTypes (room_type)
VALUES 
    (N'Phòng đơn'),
    (N'Phòng đôi'),
    (N'Phòng Suite'),
    (N'Phòng gia đình');

-- Thêm dữ liệu vào bảng Rooms
INSERT INTO Rooms (room_number, room_type_id, room_price, room_status, capacity, description, image_url, isDelete)
VALUES 
    (N'101', 1, 500000.00, N'Khả dụng', 1, N'Phòng đơn tiện nghi cơ bản', N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQmlrca0DkaSMa6XLs3BUQM3nagyapOnkGIhA&s', 0),
    (N'102', 2, 750000.00, N'Đang sử sụng', 2, N'Phòng đôi với view thành phố', N'https://example.com/room102.jpghttps://noithatchauanh.com/uploaded/thiet-ke-noi-that-khach-san-hoi-an-07(1).jpg', 0),
    (N'201', 3, 1200000.00, N'Khả dụng', 3, N'Phòng suite cao cấp với ban công', N'https://ezcloud.vn/wp-content/uploads/2018/05/khong-gian-can-phong-executive-suite.webp', 0),
    (N'202', 4, 1000000.00, N'Bảo trì', 4, N'Phòng gia đình với 2 giường lớn', N'https://ezcloud.vn/wp-content/uploads/2023/10/family-suite-la-gi.webp', 0);
