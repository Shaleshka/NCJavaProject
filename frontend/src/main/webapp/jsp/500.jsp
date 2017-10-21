<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head lang="ru">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Система распределения студетов | Ошибка 403</title>
    <jsp:include page="/jsp/blocks/header.jsp"/>
</head>
<body>
<div class="error-page">
    <h2 class="headline text-red"> 500</h2>

    <div class="error-content" style="padding-top: 20px">
        <h3><i class="fa fa-warning text-red"></i> Что-то пошло не так</h3>
        <p>
            К сожалению, на сервере произошла ошибка
        </p>

    </div>
    <!-- /.error-content -->
</div>
<jsp:include page="/jsp/blocks/scripts.jsp"/>
</body>
</html>