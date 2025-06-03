<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Account Deleted</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <style>
            body {
                background-color: #f8f9fa;
                padding-top: 50px;
            }
            .delete-container {
                max-width: 600px;
                margin: 0 auto;
                padding: 30px;
                background-color: #fff;
                border-radius: 10px;
                box-shadow: 0 0 20px rgba(0,0,0,0.1);
                text-align: center;
            }
            .icon {
                font-size: 70px;
                color: #28a745;
                margin-bottom: 20px;
            }
            h1 {
                color: #333;
                margin-bottom: 20px;
            }
            p {
                color: #666;
                margin-bottom: 30px;
                font-size: 18px;
            }
            .btn-primary {
                background-color: #007bff;
                border: none;
                padding: 10px 30px;
                font-size: 16px;
                border-radius: 5px;
            }
            .btn-primary:hover {
                background-color: #0069d9;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="delete-container">
                <div class="icon">
                    <i class="fas fa-check-circle"></i>
                </div>
                <h1>Account Successfully Deleted</h1>
                <p>Your account has been permanently deleted from our system</p>
                <a href="${pageContext.request.contextPath}/" class="btn btn-primary">Go to HomePage</a>
            </div>
        </div>

        <!-- FontAwesome for the check icon -->
        <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
    </body>
</html>