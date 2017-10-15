<%--
  Created by IntelliJ IDEA.
  User: Shaleshka
  Date: 09.10.17
  Time: 10:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Система распределения студетов | Регистрация</title>
    <jsp:include page="/jsp/blocks/header.jsp"/>
</head>
<body class="hold-transition register-page">
<div class="register-box">
    <div class="register-logo">
        <p>Система распределения студентов</p>
    </div>

    <div class="register-box-body">
        <p class="login-box-msg">Регистрация</p>

        <form action="/register_new" method="post">
            <div class="form-group has-feedback">
                <input type="text" class="form-control" placeholder="Имя">
                <span class="glyphicon glyphicon-user form-control-feedback"></span>
            </div>
            <div class="form-group has-feedback">
                <input type="email" class="form-control" placeholder="Email">
                <span class="glyphicon glyphicon-envelope form-control-feedback"></span>
            </div>
            <div class="form-group has-feedback">
                <input type="password" class="form-control" placeholder="Пароль">
                <span class="glyphicon glyphicon-lock form-control-feedback"></span>
            </div>
            <div class="form-group has-feedback">
                <input type="password" class="form-control" placeholder="Повторите пароль">
                <span class="glyphicon glyphicon-log-in form-control-feedback"></span>
            </div>
            <div class="row">
                <!-- /.col -->
                <div class="col-xs-4" style="width: 100%">
                    <button type="submit" class="btn btn-primary btn-block btn-flat">Зарегистрироваться</button>
                </div>
                <!-- /.col -->
            </div>
        </form>

        <a href="/loginpage" class="text-center">Я уже зарегестрирован</a>
    </div>
    <!-- /.form-box -->
</div>
<!-- /.register-box -->

<jsp:include page="/jsp/blocks/scripts.jsp"/>
</body>
</html>
