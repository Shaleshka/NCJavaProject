<%--
  Created by IntelliJ IDEA.
  User: Shaleshka
  Date: 09.10.17
  Time: 11:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page session="true" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Система распределения студентов | Профиль</title>
    <jsp:include page="/jsp/blocks/header.jsp"/>

    <script>
        $(function () {
            // bind 'myForm' and provide a simple callback function
            $('#student_edit').ajaxForm({
                dataType: "json",
                headers: {"${_csrf.parameterName}": "${_csrf.token}"},
                success: function (data) {
                    $('#user_avatar').attr("src", "resources/img/avatars/" + data.imageUrl);
                    $('#user_name').html(data.fname + " " + data.lname);
                    //that's a trick to avoid requests to a faculty table for a name (that'll mean either additional
                    // request from here, or returing something else than student from controller)
                    // we will do such request to fill our select below
                    //(not implemented yet)
                    $('#faculty').text($("#faculties option[value='" + data.facultyId + "']").text());
                    $('#group').text(data.group);
                }
            });
        });
    </script>

</head>
<body class="hold-transition login-page">
<section class="content">

    <div class="row">
        <div class="col-md-3">

            <!-- Profile Image -->
            <div class="box box-primary">
                <div class="box-body box-profile">
                    <img class="profile-user-img img-responsive img-circle" id="user_avatar" src="${imageUrl}"
                         alt="User profile picture">
                    <h3 class="profile-username text-center" id="user_name">${name}</h3>
                    <!-- User role never changes (at least for now) -->
                    <p class="text-muted text-center">Студент</p>

                    <ul class="list-group list-group-unbordered">
                        <li class="list-group-item">
                            <!-- This also never changes for now -->
                            <b>Университет</b> <a class="pull-right">БГУИР</a>
                        </li>
                        <li class="list-group-item">
                            <b>Факультет</b> <a class="pull-right" id="faculty">ФКП</a>
                        </li>
                        <li class="list-group-item">
                            <b>Группа</b> <a class="pull-right" id="group">513803</a>
                        </li>
                    </ul>

                    <a href="/logout" class="btn btn-primary btn-block"><b>Выйти</b></a>
                </div>
                <!-- /.box-body -->
            </div>
            <!-- /.box -->
        </div>
        <!-- /.col -->
        <div class="col-md-9">
            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs">
                    <li class="active"><a href="#activity" data-toggle="tab">Настройки профиля</a></li>
                    <li><a href="#timeline" data-toggle="tab">Практика</a></li>
                </ul>
                <div class="tab-content">
                    <div class="active tab-pane" id="activity">
                        <div class="box box-primary">
                            <div class="box-header with-border">
                                <h3 class="box-title">Пожалуйста, заполните все поля</h3>
                            </div>
                            <!-- /.box-header -->
                            <div class="box-body">
                                <form id="student_edit" action="/students/edit/${id}" method="post" role="form">
                                    <!-- text input -->
                                    <div class="form-group">
                                        <label>Имя</label>
                                        <input type="text" class="form-control" name="fname"
                                               placeholder="Введите имя...">
                                    </div>
                                    <div class="form-group">
                                        <label>Фамилия</label>
                                        <input type="text" class="form-control" name="lname"
                                               placeholder="Введите фамилию...">
                                    </div>

                                    <div class="form-group">
                                        <label for="exampleInputFile">Аватарка</label>
                                        <input type="file" name="image" id="exampleInputFile">

                                        <p class="help-block">Картинка jpg, png, bmp, gif, не более 1024 кбайт</p>
                                    </div>

                                    <div class="form-group">
                                        <label>Выберите факультет</label>
                                        <select id="faculties" name="faculty" class="form-control">
                                            <option value="1">ФКП</option>
                                            <option value="2">ФИТУ</option>
                                            <option value="3">ФРЭ</option>
                                            <option value="4">ФТК</option>
                                            <option value="5">ФКСИС</option>
                                        </select>
                                    </div>

                                    <div class="form-group">
                                        <label>Выберите специальность</label>
                                        <select name="speciality" class="form-control">
                                            <option value="1">ФКП</option>
                                            <option value="2">ФИТУ</option>
                                            <option value="3">ФРЭ</option>
                                            <option value="4">ФТК</option>
                                            <option value="5">ФКСИС</option>
                                        </select>
                                    </div>

                                    <div class="form-group">
                                        <label>Группа</label>
                                        <input type="text" class="form-control" name="group"
                                               placeholder="Введите группу...">
                                    </div>

                                    <div class="form-group">
                                        <label>
                                            <input name="isBudget" type="checkbox">
                                            Бюджетник
                                        </label>
                                    </div>

                                    <div class="form-group">
                                        <label>Средний балл</label>
                                        <input type="text" class="form-control" name="avgScore"
                                               placeholder="Введите ср. балл...">
                                    </div>
                                    <input type="hidden" name="${_csrf.parameterName}"
                                           value="${_csrf.token}"/>
                                    <div class="box-footer">
                                        <button type="submit" class="btn btn-primary">Submit</button>
                                    </div>
                                </form>
                            </div>
                            <!-- /.box-body -->
                        </div>
                    </div>
                    <!-- /.tab-pane -->
                    <div class="tab-pane" id="timeline">
                        <!-- The timeline -->
                        <ul class="timeline timeline-inverse">
                            <!-- timeline time label -->
                            <li class="time-label">
                        <span class="bg-red">
                          10 Февраля 2017
                        </span>
                            </li>
                            <!-- /.timeline-label -->
                            <!-- timeline item -->
                            <li>
                                <i class="fa fa-envelope bg-blue"></i>

                                <div class="timeline-item">
                                    <span class="time"><i class="fa fa-clock-o"></i> 12:05</span>

                                    <h3 class="timeline-header">Ваша практика у руководителя <a href="#">ИНТЕГРАЛ</a>
                                        закончилась</h3>
                                </div>
                            </li>
                            <!-- END timeline item -->
                            <!-- timeline time label -->
                            <li class="time-label">
                        <span class="bg-green">
                          3 января 2017
                        </span>
                            </li>
                            <!-- /.timeline-label -->
                            <!-- timeline item -->
                            <li>
                                <i class="fa fa-envelope bg-blue"></i>

                                <div class="timeline-item">
                                    <span class="time"><i class="fa fa-clock-o"></i> 12:05</span>

                                    <h3 class="timeline-header">Вы назначены на практику у руководителя <a href="#">ИНТЕГРАЛ</a>
                                    </h3>
                                </div>
                            </li>
                            <!-- END timeline item -->
                        </ul>
                    </div>
                    <!-- /.tab-pane -->
                </div>

                <!-- /.tab-content -->
            </div>
            <!-- /.nav-tabs-custom -->
        </div>
        <!-- /.col -->
    </div>
    <!-- /.row -->

</section>
<jsp:include page="/jsp/blocks/scripts.jsp"/>
</body>
</html>
