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
                <form action="/login" method="POST">
                    <input type="text" name="username" placeholder="Tên đăng nhập" required />
                    <input type="password" name="password" placeholder="Mật khẩu" required />

                    <div class="remember-me">
                        <div>
                            <label for="remember">Ghi nhớ đăng nhập</label>
                            <input type="checkbox" id="remember" name="remember" />
                        </div>
                        <a href="resetPassword.jsp">Quên mật khẩu</a>
                    </div>

                    <button type="submit">Đăng Nhập</button>
                    <p>Bạn chưa có tài khoản? <a href="register.jsp">Đăng ký</a></p>
                </form>
            </div>
        </div>
    </body>
</html>

