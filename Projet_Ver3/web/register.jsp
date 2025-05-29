<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Đăng Ký</title>
        <link rel="stylesheet" href="customer/customer.css" />
        <link rel="stylesheet" href="components/component.css" />
    </head>
    <body>
        <jsp:include page="components/header.jsp"/>
        <div class="form-container">
            <div class="register-container" id="formContainer">
                <div class="form-wrapper">

                    <!-- Step 1: Tài khoản -->
                    <div class="form-section">
                        <h2>Tạo tài khoản</h2>
                        <form id="step1">
                            <input type="text" name="username" placeholder="Tên đăng nhập..." required />
                            <input type="password" name="password" placeholder="Mật khẩu..." required />
                            <input type="password" name="confirm_password" placeholder="Xác nhận mật khẩu..." required />
                            <button type="button" onclick="goToStep2()">Tiếp tục</button>
                            <p>Bạn đã có tài khoản? <a href="login.jsp">Đăng nhập</a></p>
                        </form>
                    </div>

                    <!-- Step 2: Thông tin cá nhân -->
                    <div class="form-section">
                        <h2>Thông tin cá nhân</h2>
                        <form id="step2" action="/register" method="POST">
                            <!-- Hidden fields from step 1 -->
                            <input type="hidden" name="username" />
                            <input type="hidden" name="password" />

                            <input type="text" name="fullName" placeholder="Họ và tên..." required />
                            <input type="date" name="birth" required />
                            <select name="gender" required>
                                <option value="">Chọn giới tính</option>
                                <option value="male">Nam</option>
                                <option value="female">Nữ</option>
                                <option value="orther">Khác</option>
                            </select>
                            <input type="email" name="email" placeholder="Email @gmail.com" pattern="^[a-zA-Z0-9._%+-]+@gmail\.com$" required />
                            <input type="text" name="phone" placeholder="Số điện thoại..." required />
                            <input type="text" name="address" placeholder="Địa chỉ..." required />

                            <input type="hidden" name="role" value="customer" />
                            <input type="hidden" name="isActive" value="true" />
                            <input type="hidden" name="isDeleted" value="false" />

                            <button type="submit">Tạo tài khoản</button>
                            <button type="button" onclick="goBack()">Quay lại</button>

                        </form>
                    </div>

                </div>
            </div>
        </div>

        <script>
            function goToStep2() {
                const form1 = document.getElementById('step1');
                const username = form1.username.value.trim();
                const password = form1.password.value;
                const confirm = form1.confirm_password.value;

                if (!username || !password || !confirm) {
                    alert("Vui lòng điền đầy đủ thông tin.");
                    return;
                }

                if (checkPassword(password) !== true) {
                    alert("Mật khẩu dài 8-16 ký tự và phải bao gồm chữ hoa, chữ thường và số.");
                    return;
                }
                if (password !== confirm) {
                    alert("Mật khẩu xác nhận không khớp.");
                    return;
                }

                // Đổ dữ liệu sang step 2
                const form2 = document.getElementById('step2');
                form2.username.value = username;
                form2.password.value = password;

                // Chuyển form
                document.getElementById('formContainer').classList.add('shift-left');
            }
            function goBack() {
                document.getElementById('formContainer').classList.remove('shift-left');
            }
            function checkPassword(pass) {
                const hasUpper = /[A-Z]/.test(pass);
                const hasLower = /[a-z]/.test(pass);
                const hasNumber = /[0-9]/.test(pass);
                const isLongEnough = pass.length >= 8 && pass.length <= 16;

                return hasUpper && hasLower && hasNumber && isLongEnough;
            }
        </script>
    </body>
</html>
