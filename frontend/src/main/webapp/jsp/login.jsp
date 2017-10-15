<%--
  Created by IntelliJ IDEA.
  User: anpi0316
  Date: 06.10.2017
  Time: 15:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Система распределения студентов | Вход</title>
    <jsp:include page="/jsp/blocks/header.jsp"/>
</head>
<body class="hold-transition login-page">
<div class="login-box">
    <div class="login-logo">
        <p>Система распределения студентов</p>
    </div>
    <!-- /.login-logo -->
    <div class="login-box-body">
        <p class="login-box-msg">Войдите, чтобы начать</p>

        <form action="/login" method="post">
            <div class="form-group has-feedback">
                <input type="email" class="form-control" aria-describedby="emailHelp" name="email" placeholder="Email">
                <span class="glyphicon glyphicon-envelope form-control-feedback"></span>
            </div>
            <div class="form-group has-feedback">
                <input type="password" class="form-control" placeholder="Пароль" name="password">
                <span class="glyphicon glyphicon-lock form-control-feedback"></span>
            </div>
            <div class="row">
                <div class="col-xs-8">
                    <div class="checkbox icheck">
                        <label>
                            <input type="checkbox"> Запомнить меня
                        </label>
                    </div>
                </div>
                <!-- /.col -->
                <div class="col-xs-4">
                    <button type="submit" class="btn btn-primary btn-block btn-flat">Войти</button>
                </div>
                <!-- /.col -->
            </div>
        </form>


        <a href="#">Я забыл пароль</a><br>
        <a href="/register" class="text-center">Регистрация</a>

    </div>
    <!-- /.login-box-body -->
</div>
<!-- /.login-box -->

<jsp:include page="/jsp/blocks/scripts.jsp"/>
</body>
</html>
