<%--
    Document   : login
    Created on : May 22, 2025, 9:44:23 AM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Đăng Nhập</title>
        <link rel="stylesheet" href="customer/customer.css" />
        <link rel="stylesheet" href="components/component.css" />
    </head>
    <body>
        <jsp:include page="components/header.jsp"/>

        <div class="form-container">
            <div class="form">
                <h2>Đăng Nhập</h2>
                <div id="loginTabs" class="login-tabs"> <%-- Thêm ID và class 'login-tabs' --%>
                    <span id="emailLoginTab" onclick="showLoginMethod('email')">Email/Tên đăng nhập</span>
                    <span id="phoneLoginTab" onclick="showLoginMethod('phone')">Số điện thoại</span>
                </div>

                <form id="method1" action="login" method="post">
                    <input type="hidden" name="method" value="1"/>
                    <input type="text" name="stringlog" placeholder="Mail hoặc tên đăng nhập" required />
                    <input type="password" name="password" placeholder="Mật khẩu" required />
                    <i style="color: red">${mess}</i>
                    <div class="remember-me">
                        <div>
                            <input type="checkbox" id="rememberMethod1" name="rememberMe" />
                            <label for="rememberMethod1">Ghi nhớ đăng nhập</label>
                        </div>
                        <a href="resetPassword.jsp">Quên mật khẩu</a>
                    </div>

                    <button type="submit">Đăng Nhập</button>
                    <p>Bạn chưa có tài khoản? <a href="register.jsp">Đăng ký</a></p>
                </form>

                <form id="method2" action="login" method="post">
                    <input type="hidden" name="method" value="2"/>
                    <input type="text" name="stringlog" placeholder="Số điện thoại" required />
                    <input type="password" name="password" placeholder="Mật khẩu" required />
                    <div class="remember-me">
                        <div>
                            <input type="checkbox" id="rememberMethod2" name="rememberMe" />
                            <label for="rememberMethod2">Ghi nhớ đăng nhập</label>
                        </div>
                        <a href="resetPassword.jsp">Quên mật khẩu</a>
                    </div>

                    <button type="submit">Đăng Nhập</button>
                    <p>Bạn chưa có tài khoản? <a href="register.jsp">Đăng ký</a></p>
                </form>
            </div>
        </div>

        <script>
            // Hàm để hiển thị form và cập nhật trạng thái active
            function showLoginMethod(methodType) {
                var method1Form = document.getElementById('method1');
                var method2Form = document.getElementById('method2');
                var emailLoginTab = document.getElementById('emailLoginTab');
                var phoneLoginTab = document.getElementById('phoneLoginTab');
                var loginTabsContainer = document.getElementById('loginTabs'); // Lấy container của các tab

                if (methodType === 'email') {
                    method1Form.classList.remove('hidden');
                    method2Form.classList.add('hidden');
                    emailLoginTab.classList.add('active-method');
                    phoneLoginTab.classList.remove('active-method');
                    loginTabsContainer.classList.remove('active-phone'); // Xóa class để underline về vị trí email
                } else if (methodType === 'phone') {
                    method1Form.classList.add('hidden');
                    method2Form.classList.remove('hidden');
                    emailLoginTab.classList.remove('active-method');
                    phoneLoginTab.classList.add('active-method');
                    loginTabsContainer.classList.add('active-phone'); // Thêm class để underline chuyển sang phone
                }
            }

            // Gọi hàm này khi trang được tải lần đầu để đặt trạng thái ban đầu
            document.addEventListener('DOMContentLoaded', function () {
                // Mặc định hiển thị form Email/Tên đăng nhập
                showLoginMethod('email');
            });
        </script>
    </body>
</html>