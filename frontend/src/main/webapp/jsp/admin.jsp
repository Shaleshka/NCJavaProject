<%--
  Created by IntelliJ IDEA.
  User: Shaleshka
  Date: 09.10.17
  Time: 11:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="sec"
          uri="http://www.springframework.org/security/tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Система распределения студентов | Админская панель</title>
    <jsp:include page="/jsp/blocks/header.jsp"/>
</head>
<body class="hold-transition login-page">
<section class="content">

    <div class="row">
        <!-- /.col -->
        <div class="col-md-12">
            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs">
                    <li class="active"><a href="#activity" data-toggle="tab">Практики</a></li>
                    <li><a href="#new_hop" data-toggle="tab">Создать нового рук. практики</a></li>
                    <li><a href="#students" data-toggle="tab">Студенты</a></li>
                    <li><a href="#faculties" data-toggle="tab">Факультеты и специальности</a></li>
                    <li>
                        <div class="pull-right">
                            <a href="<c:url value="/logout" />" class="btn btn-primary btn-block"><b>Выйти</b></a>
                        </div>
                    </li>
                </ul>
                <div class="tab-content">
                    <div class="active tab-pane" id="activity">
                        <div class="box box-solid">
                            <div class="box-header with-border">
                                <h3 class="box-title">Все заявки на практику</h3>
                            </div>
                            <!-- /.box-header -->
                            <div class="box-body">
                                <div class="box-group" id="accordion">
                                    <!-- we are adding the .panel class so bootstrap.js collapse plugin detects it -->
                                    <div class="panel box box-success">
                                        <div class="box-header with-border">
                                            <h4 class="box-title">
                                                <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
                                                    Java EE Development - практика проходит
                                                </a>
                                            </h4>
                                        </div>
                                        <div id="collapseOne" class="panel-collapse collapse in">
                                            <div class="box">
                                                <div class="box-header">
                                                    <h3 class="box-title">Студенты</h3>
                                                </div>
                                                <!-- /.box-header -->
                                                <div class="box-body">
                                                    <table id="example1" class="table table-bordered table-striped">
                                                        <thead>
                                                        <tr>
                                                            <th>Имя</th>
                                                            <th>Фамилия</th>
                                                            <th>Факультет</th>
                                                            <th>Специальность</th>
                                                            <th>Группа</th>
                                                            <th>Средний балл</th>
                                                            <th>Действие</th>
                                                        </tr>
                                                        </thead>
                                                        <tbody>
                                                        <tr>
                                                            <td>Андрей</td>
                                                            <td>Даниленко</td>
                                                            <td>ФКП</td>
                                                            <td>ПМС</td>
                                                            <td>513803</td>
                                                            <td>-4</td>
                                                            <td>
                                                                <button type="button" class="btn btn-block btn-danger">
                                                                    Снять
                                                                </button>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>Костя</td>
                                                            <td>Новичук</td>
                                                            <td>ФКП</td>
                                                            <td>ПМС</td>
                                                            <td>513803</td>
                                                            <td>-3</td>
                                                            <td>
                                                                <button type="button" class="btn btn-block btn-danger">
                                                                    Снять
                                                                </button>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>Евгений</td>
                                                            <td>Шнейдеров</td>
                                                            <td>ФКП</td>
                                                            <td>ИСИТ(БМ)</td>
                                                            <td>514301</td>
                                                            <td>9.5</td>
                                                            <td>
                                                                <button type="button" class="btn btn-block btn-danger">
                                                                    Снять
                                                                </button>
                                                            </td>
                                                        </tr>
                                                        </tbody>
                                                        <tfoot>
                                                        <tr>
                                                            <th>Имя</th>
                                                            <th>Фамилия</th>
                                                            <th>Факультет</th>
                                                            <th>Специальность</th>
                                                            <th>Группа</th>
                                                            <th>Средний балл</th>
                                                            <th>Действие</th>
                                                        </tr>
                                                        </tfoot>
                                                    </table>
                                                </div>
                                                <!-- /.box-body -->
                                            </div>
                                            <!-- /.box -->

                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- /.box-body -->
                        </div>
                    </div>
                    <!-- /.tab-pane -->
                    <div class="tab-pane" id="new_hop">
                        <!-- The timeline -->
                        <div class="box box-primary">
                            <div class="box-header with-border">
                                <h3 class="box-title">Новый аккаунт рук. практики</h3>
                            </div>
                            <!-- /.box-header -->
                            <div class="box-body">
                                <form role="form">
                                    <!-- text input -->
                                    <div class="form-group">
                                        <label>Электронная почта</label>
                                        <input type="email" class="form-control"
                                               placeholder="Введите электронную почту...">
                                    </div>
                                    <div class="form-group">
                                        <label>Пароль</label>
                                        <input type="password" class="form-control" placeholder="Введите пароль...">
                                    </div>
                                    <div class="form-group">
                                        <label>Повторите пароль</label>
                                        <input type="password" class="form-control" placeholder="Введите пароль...">
                                    </div>

                                    <div class="form-group">
                                        <label>Имя компании</label>
                                        <input type="text" class="form-control" placeholder="Введите имя компании...">
                                    </div>

                                    <div class="box-footer">
                                        <button type="submit" class="btn btn-primary">Создать</button>
                                    </div>

                                </form>
                            </div>
                            <!-- /.box-body -->
                        </div>
                    </div>
                    <!-- /.tab-pane -->
                    <div class="tab-pane" id="students">
                        <div class="box box-solid">
                            <div class="box-header with-border">
                                <h3 class="box-title">Студенты</h3>
                            </div>
                            <!-- /.box-header -->
                            <div class="box-body">
                                <div class="box-group">
                                    <!-- we are adding the .panel class so bootstrap.js collapse plugin detects it -->
                                    <div class="box">
                                        <div class="box-header">
                                            <h3 class="box-title">Студенты</h3>
                                        </div>
                                        <!-- /.box-header -->
                                        <div class="box-body">
                                            <table id="example2" class="table table-bordered table-striped">
                                                <thead>
                                                <tr>
                                                    <th>Имя</th>
                                                    <th>Фамилия</th>
                                                    <th>Факультет</th>
                                                    <th>Специальность</th>
                                                    <th>Группа</th>
                                                    <th>Средний балл</th>
                                                    <th>Назначение</th>
                                                    <th>Редактирование</th>
                                                </tr>
                                                </thead>
                                                <tbody>
                                                <tr>
                                                    <td>Андрей</td>
                                                    <td>Даниленко</td>
                                                    <td>ФКП</td>
                                                    <td>ПМС</td>
                                                    <td>513803</td>
                                                    <td>-4</td>
                                                    <td>
                                                        <button type="button" class="btn btn-default"
                                                                data-toggle="modal" data-target="#modal-default">
                                                            Назначить
                                                        </button>
                                                    </td>
                                                    <td>
                                                        <button type="button" class="btn btn-block btn-primary">
                                                            Редактировать
                                                        </button>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>Костя</td>
                                                    <td>Новичук</td>
                                                    <td>ФКП</td>
                                                    <td>ПМС</td>
                                                    <td>513803</td>
                                                    <td>-3</td>
                                                    <td>
                                                        <button type="button" class="btn btn-default"
                                                                data-toggle="modal" data-target="#modal-default">
                                                            Назначить
                                                        </button>
                                                    </td>
                                                    <td>
                                                        <button type="button" class="btn btn-block btn-primary">
                                                            Редактировать
                                                        </button>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>Евгений</td>
                                                    <td>Шнейдеров</td>
                                                    <td>ФКП</td>
                                                    <td>ИСИТ(БМ)</td>
                                                    <td>514301</td>
                                                    <td>9.5</td>
                                                    <td>
                                                        <button type="button" class="btn btn-default"
                                                                data-toggle="modal" data-target="#modal-default">
                                                            Назначить
                                                        </button>
                                                    </td>
                                                    <td>
                                                        <button type="button" class="btn btn-block btn-primary">
                                                            Редактировать
                                                        </button>
                                                    </td>
                                                </tr>
                                                </tbody>
                                                <tfoot>
                                                <tr>
                                                    <th>Имя</th>
                                                    <th>Фамилия</th>
                                                    <th>Факультет</th>
                                                    <th>Специальность</th>
                                                    <th>Группа</th>
                                                    <th>Средний балл</th>
                                                    <th>Назначение</th>
                                                    <th>Редактирование</th>
                                                </tr>
                                                </tfoot>
                                            </table>
                                        </div>
                                        <!-- /.box-body -->
                                    </div>
                                    <!-- /.box -->

                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="tab-pane" id="faculties">
                        <div class="box box-solid">
                            <div class="box-header with-border">
                                <h3 class="box-title">Факультеты и специальности</h3>
                                <div class="pull-right">
                                    <button type="button" class="btn btn-default"
                                            data-toggle="modal" data-target="#new-faculty">
                                        Создать факультет
                                    </button>
                                    <button type="button" class="btn btn-default"
                                            data-toggle="modal" data-target="#new-speciality">
                                        Создать специальность
                                    </button>
                                </div>
                            </div>
                            <!-- /.box-header -->
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="box-body">
                                        <div class="box-group">
                                            <!-- we are adding the .panel class so bootstrap.js collapse plugin detects it -->
                                            <div class="box">
                                                <div class="box-header">
                                                    <h3 class="box-title">Факультеты</h3>
                                                </div>
                                                <!-- /.box-header -->
                                                <div class="box-body">
                                                    <table id="tfaculty" class="table table-bordered table-striped">
                                                        <thead>
                                                        <tr>
                                                            <th>Имя</th>
                                                            <th>Удаление</th>
                                                        </tr>
                                                        </thead>
                                                        <tbody>
                                                        <tr>
                                                            <td>ФКП</td>
                                                            <td>
                                                                <button type="button" class="btn btn-block btn-danger">
                                                                    Удалить
                                                                </button>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>ФКП</td>
                                                            <td>
                                                                <button type="button" class="btn btn-block btn-danger">
                                                                    Удалить
                                                                </button>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>ФКП</td>
                                                            <td>
                                                                <button type="button" class="btn btn-block btn-danger">
                                                                    Удалить
                                                                </button>
                                                            </td>
                                                        </tr>
                                                        </tbody>
                                                        <tfoot>
                                                        <tr>
                                                            <th>Имя</th>
                                                            <th>Удаление</th>
                                                        </tr>
                                                        </tfoot>
                                                    </table>
                                                </div>
                                                <!-- /.box-body -->
                                            </div>
                                            <!-- /.box -->

                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="box-body">
                                        <div class="box-group">
                                            <!-- we are adding the .panel class so bootstrap.js collapse plugin detects it -->
                                            <div class="box">
                                                <div class="box-header">
                                                    <h3 class="box-title">Специальности</h3>
                                                </div>
                                                <!-- /.box-header -->
                                                <div class="box-body">
                                                    <table id="tgroups" class="table table-bordered table-striped">
                                                        <thead>
                                                        <tr>
                                                            <th>Имя</th>
                                                            <th>Факультет</th>
                                                            <th>Удаление</th>
                                                        </tr>
                                                        </thead>
                                                        <tbody>
                                                        <tr>
                                                            <td>ПМС</td>
                                                            <td>ФКП</td>
                                                            <td>
                                                                <button type="button" class="btn btn-block btn-danger">
                                                                    Удалить
                                                                </button>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>ПМС</td>
                                                            <td>ФКП</td>
                                                            <td>
                                                                <button type="button" class="btn btn-block btn-danger">
                                                                    Удалить
                                                                </button>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>ПМС</td>
                                                            <td>ФКП</td>
                                                            <td>
                                                                <button type="button" class="btn btn-block btn-danger">
                                                                    Удалить
                                                                </button>
                                                            </td>
                                                        </tr>
                                                        </tbody>
                                                        <tfoot>
                                                        <tr>
                                                            <th>Имя</th>
                                                            <th>Факультет</th>
                                                            <th>Удаление</th>
                                                        </tr>
                                                        </tfoot>
                                                    </table>
                                                </div>
                                                <!-- /.box-body -->
                                            </div>
                                            <!-- /.box -->

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- /.box-body -->
                </div>
            </div>
        </div>

        <!-- /.tab-content -->
    </div>
    <!-- /.nav-tabs-custom -->
    <!-- /.col -->
    <!-- /.row -->
    <div class="modal fade" id="modal-default" data-vivaldi-spatnav-clickable="1" style="display: none;">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span></button>
                    <h4 class="modal-title">Назначение на практику</h4>
                </div>
                <div class="modal-body">
                    <form role="form">
                        <div class="box-body">
                            <div class="form-group">
                                <label for="practice">Доступные практики</label>
                                <select id="practice" class="form-control">
                                    <option>Java EE Development</option>
                                    <option>Android Development</option>
                                    <option>DevOps</option>
                                </select>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default pull-left" data-dismiss="modal">Отмена</button>
                    <button type="button" class="btn btn-primary" data-dismiss="modal">Назначить</button>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    <div class="modal fade" id="new-faculty" data-vivaldi-spatnav-clickable="1" style="display: none;">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span></button>
                    <h4 class="modal-title">Новый факультет</h4>
                </div>
                <div class="modal-body">
                    <form role="form">
                        <div class="box-body">
                            <div class="form-group">
                                <label>Имя</label>
                                <input type="text" class="form-control" placeholder="Введите имя факультета...">
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default pull-left" data-dismiss="modal">Отмена</button>
                    <button type="button" class="btn btn-primary" data-dismiss="modal">Создать</button>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    <div class="modal fade" id="new-speciality" data-vivaldi-spatnav-clickable="1" style="display: none;">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span></button>
                    <h4 class="modal-title">Новая специальность</h4>
                </div>
                <div class="modal-body">
                    <form role="form">
                        <div class="box-body">
                            <div class="form-group">
                                <label>Имя</label>
                                <input type="text" class="form-control" placeholder="Введите имя специальности...">
                            </div>
                            <div class="form-group">
                                <label for="faculty">Факультет</label>
                                <select id="faculty" class="form-control">
                                    <option>ФКП</option>
                                    <option>КСИС</option>
                                    <option>ФРЭ</option>
                                </select>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default pull-left" data-dismiss="modal">Отмена</button>
                    <button type="button" class="btn btn-primary" data-dismiss="modal">Создать</button>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>

</section>
<jsp:include page="/jsp/blocks/scripts.jsp"/>
<script>
    $(function () {

        //Datemask dd/mm/yyyy
        $('#datemask').inputmask('dd/mm/yyyy', {'placeholder': 'dd/mm/yyyy'})
        //Datemask2 mm/dd/yyyy
        $('#datemask2').inputmask('mm/dd/yyyy', {'placeholder': 'mm/dd/yyyy'})
        //Money Euro
        $('[data-mask]').inputmask()

        //Date range picker
        $('#reservation').daterangepicker()
        //Date range picker with time picker
        $('#reservationtime').daterangepicker({timePicker: true, timePickerIncrement: 30, format: 'MM/DD/YYYY h:mm A'})
        //Date range as a button
        $('#daterange-btn').daterangepicker(
            {
                ranges: {
                    'Today': [moment(), moment()],
                    'Yesterday': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
                    'Last 7 Days': [moment().subtract(6, 'days'), moment()],
                    'Last 30 Days': [moment().subtract(29, 'days'), moment()],
                    'This Month': [moment().startOf('month'), moment().endOf('month')],
                    'Last Month': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
                },
                startDate: moment().subtract(29, 'days'),
                endDate: moment()
            },
            function (start, end) {
                $('#daterange-btn span').html(start.format('MMMM D, YYYY') + ' - ' + end.format('MMMM D, YYYY'))
            }
        )
    })
</script>
<script>
    $(function () {
        $('#example1').DataTable({
            'paging': true,
            'lengthChange': false,
            'searching': true,
            'ordering': true,
            'info': true,
            'autoWidth': false
        })
        $('#example2').DataTable({
            'paging': true,
            'lengthChange': false,
            'searching': true,
            'ordering': true,
            'info': true,
            'autoWidth': false
        })
        $('#tfaculty').DataTable({
            'paging': true,
            'lengthChange': false,
            'searching': true,
            'ordering': true,
            'info': true,
            'autoWidth': false
        })
        $('#tgroups').DataTable({
            'paging': true,
            'lengthChange': false,
            'searching': true,
            'ordering': true,
            'info': true,
            'autoWidth': false
        })
    })
</script>
</body>
</html>
