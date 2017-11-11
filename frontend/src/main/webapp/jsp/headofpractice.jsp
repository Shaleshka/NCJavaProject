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
        var id = '${id}';
        function hopPageInit() {
            $.ajax({
                url: 'practice/getByHop/' + id,
                dataType: 'json',
                success: function (data) {
                    $.each(data, function (index, value) {
                        $('#practices').append('<div class="panel box box-primary">\n' +
                            '                                        <div class="box-header with-border">\n' +
                            '                                            <h4 class="box-title">\n' +
                            '                                                <a data-toggle="collapse" data-parent="#accordion" href="#collapse_'+value.id+'">\n' +
                            '                                                    '+value.name+'\n' +
                            '                                                </a>\n' +
                            '                                            </h4>\n' +
                            '                                        </div>\n' +
                            '                                        <div id="collapse_'+value.id+'" class="panel-collapse collapse in">\n' +
                            '                                            <div class="box">\n' +
                            '                                                <div class="box-header">\n' +
                            '                                                    <h3 class="box-title">Студенты</h3>\n' +
                            '                                                </div>\n' +
                            '                                                <!-- /.box-header -->\n' +
                            '                                                <div class="box-body">\n' +
                            '                                                    <table id="practice_'+value.id+'" class="table table-bordered table-striped">\n' +
                            '                                                        <thead>\n' +
                            '                                                        <tr>\n' +
                            '                                                            <th>Имя</th>\n' +
                            '                                                            <th>Фамилия</th>\n' +
                            '                                                            <th>Факультет</th>\n' +
                            '                                                            <th>Специальность</th>\n' +
                            '                                                            <th>Группа</th>\n' +
                            '                                                            <th>Средний балл</th>\n' +
                            '                                                        </tr>\n' +
                            '                                                        </thead>\n' +
                            '                                                        <tbody>\n' +
                            '                                                        </tbody>\n' +
                            '                                                        <tfoot>\n' +
                            '                                                        <tr>\n' +
                            '                                                            <th>Имя</th>\n' +
                            '                                                            <th>Фамилия</th>\n' +
                            '                                                            <th>Факультет</th>\n' +
                            '                                                            <th>Специальность</th>\n' +
                            '                                                            <th>Группа</th>\n' +
                            '                                                            <th>Средний балл</th>\n' +
                            '                                                        </tr>\n' +
                            '                                                        </tfoot>\n' +
                            '                                                    </table>\n' +
                            '                                                </div>\n' +
                            '                                                <!-- /.box-body -->\n' +
                            '                                            </div>\n' +
                            '                                            <!-- /.box -->\n' +
                            '\n' +
                            '                                        </div>\n' +
                            '                                    </div>');
                        $('#practice_'+value.id).DataTable({
                            'paging': true,
                            'lengthChange': false,
                            'searching': false,
                            'ordering': false,
                            'info': false,
                            'autoWidth': false
                        })

                    })
                }
            });
        }
    </script>

</head>
<body onload="hopPageInit()" class="hold-transition login-page">
<section class="content">

    <div class="row">
        <div class="col-md-3">

            <!-- Profile Image -->
            <div class="box box-primary">
                <div class="box-body box-profile">
                    <img class="profile-user-img img-responsive img-circle" src="${imageUrl}"
                         alt="User profile picture">
                    <h3 class="profile-username text-center">${name}</h3>

                    <p class="text-muted text-center">Руководитель практики</p>

                    <ul class="list-group list-group-unbordered">
                        <li class="list-group-item">

                            <b>Компания</b> <a class="pull-right">${company}</a>
                        </li>
                        <li class="list-group-item">
                            <b>Действующих практик</b> <a class="pull-right">3</a>
                        </li>
                        <li class="list-group-item">
                            <b>Заявок</b> <a class="pull-right">1</a>
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
                    <li class="active"><a href="#activity" data-toggle="tab">Практики</a></li>
                    <li><a href="#timeline" data-toggle="tab">Создать заявку</a></li>
                </ul>
                <div class="tab-content">
                    <div class="active tab-pane" id="activity">
                        <div class="box box-solid">
                            <div class="box-header with-border">
                                <h3 class="box-title">Все заявки на практику</h3>
                            </div>
                            <!-- /.box-header -->
                            <div class="box-body">
                                <div class="box-group" id="practices">
                                    <!-- collapsing boxes with tables -->
                                </div>
                            </div>
                            <!-- /.box-body -->
                        </div>
                    </div>
                    <!-- /.tab-pane -->
                    <div class="tab-pane" id="timeline">
                        <!-- The timeline -->
                        <div class="box box-primary">
                            <div class="box-header with-border">
                                <h3 class="box-title">Создание заявки</h3>
                            </div>
                            <!-- /.box-header -->
                            <div class="box-body">
                                <form role="form">
                                    <!-- text input -->
                                    <div class="form-group">
                                        <label>Название практики</label>
                                        <input type="text" class="form-control" placeholder="Введите имя...">
                                    </div>
                                    <div class="form-group">
                                        <label for="reservation">Дата практики:</label>
                                        <div class="input-group">
                                            <div class="input-group-addon">
                                                <i class="fa fa-calendar"></i>
                                            </div>
                                            <input type="text" class="form-control pull-right" id="reservation">
                                        </div>
                                        <!-- /.input group -->
                                    </div>

                                    <div class="form-group">
                                        <label>Количество</label>
                                        <input type="text" class="form-control" placeholder="Введите кол-во...">
                                    </div>

                                    <div class="form-group">
                                        <label for="faculties">Выберите факультет</label>
                                        <select id="faculties" class="form-control">
                                            <option>Любой</option>
                                            <option>ФКП</option>
                                            <option>ФИТУ</option>
                                            <option>ФРЭ</option>
                                            <option>ФТК</option>
                                            <option>ФКСИС</option>
                                        </select>
                                    </div>

                                    <div class="form-group">
                                        <label for="specialities">Выберите специальность</label>
                                        <select id="specialities" class="form-control">
                                            <option>Любая</option>
                                            <option>ПМС</option>
                                            <option>ИСИТ (БМ)</option>
                                            <option>ИПОИТ</option>
                                            <option>МИКПРЭС</option>
                                            <option>МЕДЭ</option>
                                        </select>
                                    </div>

                                    <div class="form-group">
                                        <label>
                                            <input type="checkbox">
                                            Бюджетник
                                        </label>
                                    </div>

                                    <div class="form-group">
                                        <label>Минимальный средний балл</label>
                                        <input type="text" class="form-control" placeholder="Введите ср. балл...">
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
<script>
    $(function () {

        //Datemask dd/mm/yyyy
        $('#datemask').inputmask('dd/mm/yyyy', {'placeholder': 'dd/mm/yyyy'});
        //Datemask2 mm/dd/yyyy
        $('#datemask2').inputmask('mm/dd/yyyy', {'placeholder': 'mm/dd/yyyy'});
        //Money Euro
        $('[data-mask]').inputmask();

        //Date range picker
        $('#reservation').daterangepicker();
        //Date range picker with time picker
        $('#reservationtime').daterangepicker({timePicker: true, timePickerIncrement: 30, format: 'MM/DD/YYYY h:mm A'});
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
    })
</script>
</body>
</html>
