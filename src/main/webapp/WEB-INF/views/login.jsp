<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Login Selection | RACL WMS</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', sans-serif;
            background: #f0f2f5;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .login-container {
            text-align: center;
        }

        .login-button {
            display: block;
            width: 300px;
            padding: 20px;
            margin: 20px auto;
            font-size: 1.5rem;
            font-weight: bold;
            color: white;
            background-color: #007bff;
            border: none;
            border-radius: 10px;
            text-decoration: none;
            transition: background-color 0.3s ease;
        }

        .login-button:hover {
            background-color: #0056b3;
        }

        .admin { background-color: #dc3545; }
        .admin:hover { background-color: #a71d2a; }

        .manager { background-color: #28a745; }
        .manager:hover { background-color: #1c7c31; }

        .member { background-color: #17a2b8; }
        .member:hover { background-color: #117a8b; }
    </style>
</head>
<body>
<div class="login-container">
    <a href="${pageContext.request.contextPath}/admin/login" class="login-button admin">관리자 로그인</a>
    <a href="${pageContext.request.contextPath}/manager/login" class="login-button manager">직원 로그인</a>
    <a href="${pageContext.request.contextPath}/member/login" class="login-button member">고객 로그인</a>
</div>
</body>
</html>
