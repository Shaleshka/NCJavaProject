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

            $('#fileupload').ajaxForm({
                success: function (data) {
                    $('#user_avatar').attr("src", "images/" + data.imageUrl);
                }
            });

            $('#faculties').on('change', function () {
                refreshSpecialities(this.value, 0);
            })

        });
        function refreshSpecialities(id, val) {
            $.ajax({
                url: 'university/getSpecialitiesByFacultyId/' + id,
                dataType: 'json',
                success: function (data) {
                    $('#specs').find('option').remove();
                    var options = "";
                    $.each(data, function (index, value) {
                        options += '<option value="' + value.id + '">' + value.name + '</option>';
                    });
                    $('#specs').html(options);
                    if (val) {
                        $('#specs').val(val);
                    }
                }
            });
        }
        function fillForm() {
            $.ajax({
                url: 'students/get/${id}',
                dataType: 'json',
                success: function (data) {
                    $('#user_avatar').attr("src", "images/" + data.imageUrl);
                    $('#user_name').html(data.fname + " " + data.lname);
                    $('#faculties').val(data.facultyId);
                    refreshSpecialities(data.facultyId, data.specialityId);
                    $('#faculty').text($("#faculties option[value='" + data.facultyId + "']").text());
                    $('#group').text(data.group);
                    $('input[name=fname]').val(data.fname);
                    $('input[name=lname]').val(data.lname);
                    $('input[name=group]').val(data.group);
                    if (data.isBudget) $('input[name=isBudget]').iCheck('toggle');
                    $('input[name=avgScore]').val(data.avgScore);
                }
            });
            $('#student_edit').ajaxForm({
                dataType: 'json',
                success: function (data) {
                    if (data) {
                        $('#user_avatar').attr("src", "images/" + data.imageUrl);
                        $('#user_name').html(data.fname + " " + data.lname);
                        //that's a trick to avoid requests to a faculty table for a name (that'll mean either additional
                        // request from here, or returing something else than student from controller)
                        // we will do such request to fill our select below
                        //(not implemented yet)
                        $('#faculty').text($("#faculties option[value='" + data.facultyId + "']").text());
                        $('#group').text(data.group);
                        $('#success').css('display', 'block');
                    } else {
                        $('#error').css('display', 'block');
                    }
                }
            });
            $.validate({
                lang: 'ru'
            });

        }
    </script>

</head>
<body onload="fillForm()" class="hold-transition login-page">
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
                            <b>Факультет</b> <a class="pull-right" id="faculty"></a>
                        </li>
                        <li class="list-group-item">
                            <b>Группа</b> <a class="pull-right" id="group"></a>
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

                            <div id="success" class="alert alert-success alert-dismissible" style="display: none">
                                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                                <h4><i class="icon fa fa-check"></i> Изменения приняты!</h4>
                            </div>

                            <div id="error" class="alert alert-danger alert-dismissible" style="display: none">
                                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                                <h4><i class="icon fa fa-ban"></i> Ошибка!</h4>
                            </div>


                            <!-- /.box-header -->
                            <div class="box-body">
                                <form id="student_edit"
                                      action="/students/edit/${id}?${_csrf.parameterName}=${_csrf.token}" method="post"
                                      role="form">
                                    <!-- text input -->
                                    <div class="form-group">
                                        <label>Имя</label>
                                        <input data-validation="length letternumeric" data-validation-length="2-45"
                                               type="text" class="form-control" name="fname"
                                               placeholder="Введите имя...">
                                    </div>
                                    <div class="form-group">
                                        <label>Фамилия</label>
                                        <input data-validation="length letternumeric" data-validation-length="2-45"
                                               type="text" class="form-control" name="lname"
                                               placeholder="Введите фамилию...">
                                    </div>

                                    <div class="form-group">
                                        <button type="button" class="btn btn-default" data-toggle="modal"
                                                data-target="#picture_upload">
                                            Загрузка картинки
                                        </button>
                                    </div>

                                    <div class="form-group">
                                        <label for="faculties">Выберите факультет</label>
                                        <select id="faculties" name="faculty" class="form-control">
                                            <c:forEach items="${faculties}" var="item">
                                                <option value="${item.getId()}">${item.getName()}</option>
                                            </c:forEach>
                                        </select>
                                    </div>

                                    <div class="form-group">
                                        <label for="specs">Выберите специальность</label>
                                        <select id="specs" name="speciality" class="form-control">

                                        </select>
                                    </div>

                                    <div class="form-group">
                                        <label>Группа</label>
                                        <input data-validation="length number" data-validation-length="6"
                                               data-validation-error-msg="Группа должна быть шестизначным числом"
                                               type="text" class="form-control" name="group"
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
                                        <input data-validation="number" data-validation-allowing="range[4.0;10.0],float"
                                               data-validation-error-msg="Значение выходит за диапазон возможных оценок"
                                               type="text" class="form-control" name="avgScore"
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
<div class="modal fade" id="picture_upload">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span></button>
                <h4 class="modal-title">Загрузка картинки</h4>
            </div>
            <div class="modal-body">
                <form id="fileupload" role="form"
                      action="/students/imageUpload/${id}?${_csrf.parameterName}=${_csrf.token}" method="post"
                      enctype="multipart/form-data">
                    <div class="box-body">
                        <div class="form-group">
                            <label for="exampleInputFile">Загрузка файла</label>
                            <input type="file" name="file" id="exampleInputFile">

                            <p class="help-block">Картинка png, jpg, gif, bmp, не более 1мб</p>
                        </div>
                    </div>
                    <!-- /.box-body -->
                    <div class="box-footer">
                        <button type="submit" class="btn btn-primary">Загрузить</button>
                    </div>
                </form>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<jsp:include page="/jsp/blocks/scripts.jsp"/>
</body>
</html>
