<%--
  Created by IntelliJ IDEA.
  User: Shaleshka
  Date: 09.10.17
  Time: 11:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Система распределения студентов | Профиль</title>
    <jsp:include page="/jsp/blocks/header.jsp"/>
</head>
<body class="hold-transition login-page">
<section class="content">

    <div class="row">
        <div class="col-md-3">

            <!-- Profile Image -->
            <div class="box box-primary">
                <div class="box-body box-profile">
                    <img class="profile-user-img img-responsive img-circle" src="../../dist/img/user4-128x128.jpg"
                         alt="User profile picture">

                    <h3 class="profile-username text-center">Богдан Шелешко</h3>

                    <p class="text-muted text-center">Студент</p>

                    <ul class="list-group list-group-unbordered">
                        <li class="list-group-item">
                            <b>Университет</b> <a class="pull-right">БГУИР</a>
                        </li>
                        <li class="list-group-item">
                            <b>Факультет</b> <a class="pull-right">ФКП</a>
                        </li>
                        <li class="list-group-item">
                            <b>Группа</b> <a class="pull-right">513803</a>
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
                                <form role="form">
                                    <!-- text input -->
                                    <div class="form-group">
                                        <label>Имя</label>
                                        <input type="text" class="form-control" placeholder="Введите имя...">
                                    </div>
                                    <div class="form-group">
                                        <label>Фамилия</label>
                                        <input type="text" class="form-control" placeholder="Введите фамилию...">
                                    </div>

                                    <div class="form-group">
                                        <label>Выберите факультет</label>
                                        <select class="form-control">
                                            <option>ФКП</option>
                                            <option>ФИТУ</option>
                                            <option>ФРЭ</option>
                                            <option>ФТК</option>
                                            <option>ФКСИС</option>
                                        </select>
                                    </div>

                                    <div class="form-group">
                                        <label>Выберите специальность</label>
                                        <select class="form-control">
                                            <option>ПМС</option>
                                            <option>ИСИТ (БМ)</option>
                                            <option>ИПОИТ</option>
                                            <option>МИКПРЭС</option>
                                            <option>МЕДЭ</option>
                                        </select>
                                    </div>

                                    <div class="form-group">
                                        <label>Группа</label>
                                        <input type="text" class="form-control" placeholder="Введите группу...">
                                    </div>

                                    <div class="form-group">
                                        <label>
                                            <input type="checkbox">
                                            Бюджетник
                                        </label>
                                    </div>

                                    <div class="form-group">
                                        <label>Средний балл</label>
                                        <input type="text" class="form-control" placeholder="Введите ср. балл...">
                                    </div>
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
