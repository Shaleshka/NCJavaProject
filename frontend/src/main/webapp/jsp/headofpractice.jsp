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

        var oTable;

        var selected = [];

        function appendPractice(index, value) {
            $('#practices').append('<div class="panel box box-primary">\n' +
                '                                        <div class="box-header with-border">\n' +
                '                                            <h4 class="box-title">\n' +
                '                                                <a data-toggle="collapse" data-parent="#accordion" href="#collapse_' + value.id + '">\n' +
                '                                                    ' + value.name + '\n' +
                '                                                </a>\n' +
                '                                            </h4>\n' +
                '                                        </div>\n' +
                '                                        <div id="collapse_' + value.id + '" class="panel-collapse collapse in">\n' +
                '                                            <div class="box">\n' +
                '                                                <div class="box-header">\n' +
                '                                                    <h3 class="box-title">Студенты</h3>\n' +
                '                                                </div>\n' +
                '                                                <!-- /.box-header -->\n' +
                '                                                <div class="box-body">\n' +
                '                                                    <table id="practice_' + value.id + '" class="table table-bordered table-striped">\n' +
                '                                                        <thead>\n' +
                '                                                        <tr>\n' +
                '                                                            <th> </th>\n' +
                '                                                            <th>Имя</th>\n' +
                '                                                            <th>Фамилия</th>\n' +
                '                                                            <th>Факультет</th>\n' +
                '                                                            <th>Специальность</th>\n' +
                '                                                            <th>Группа</th>\n' +
                '                                                            <th>Средний балл</th>\n' +
                '                                                            <th>Удалить</th>\n' +
                '                                                        </tr>\n' +
                '                                                        </thead>\n' +
                '                                                        <tbody>\n' +
                '                                                        </tbody>\n' +
                '                                                        <tfoot>\n' +
                '                                                        <tr>\n' +
                '                                                            <th> </th>\n' +
                '                                                            <th>Имя</th>\n' +
                '                                                            <th>Фамилия</th>\n' +
                '                                                            <th>Факультет</th>\n' +
                '                                                            <th>Специальность</th>\n' +
                '                                                            <th>Группа</th>\n' +
                '                                                            <th>Средний балл</th>\n' +
                '                                                            <th>Удалить</th>\n' +
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
            $('#practice_' + value.id).DataTable({
                "processing": true,
                "serverSide": true,
                'autoWidth': false,
                "ajax": "practice/tableForPractice/" + value.id
            });


        }

        function hopPageInit() {
            $.ajax({
                url: 'practice/getByHop/' + id,
                dataType: 'json',
                success: function (data) {
                    $.each(data, function (index, value) {
                        appendPractice(index, value)
                    });
                }
            });
            $('#faculties').on('change', function () {
                refreshSpecialities(this.value, 0);
            });
            refreshSpecialities(1, 0);
            $('#request').ajaxForm({
                dataType: 'json',
                success: function (data) {
                    if (data) {
                        appendPractice(0, data);
                        $('#success').css('display', 'block');
                    } else {
                        $('#error').css('display', 'block');
                    }
                }
            });
            $.validate({
                lang: 'ru'
            });
            $('#reservation').daterangepicker();
            oTable = $('#tstudents').DataTable({
                "processing": true,
                "serverSide": true,
                'autoWidth': false,
                "ajax": "practice/tableForRequest/" + getFacultiesVal() + "/" +
                getSpecialityVal() + "?minavg=" + getMinAvgVal() + "&date=" + getDate() + "&budget=" + getIsBudget(),
                "rowCallback": function (row, data) {
                    var cb = $(row).find('td:nth-child(1) > label > input[type="checkbox"]');
                    if ($.inArray(cb.attr('id'), selected) !== -1) {
                        cb.iCheck('check');
                    }
                },
                "drawCallback": function () {
                    $('input[type="checkbox"]').iCheck({
                        checkboxClass: 'icheckbox_square-blue',
                        radioClass: 'iradio_square-blue',
                        increaseArea: '20%' // optional
                    });
                    $('input[type="checkbox"]').on('ifChecked', function () {
                        var id = this.id;
                        var index = $.inArray(id, selected);

                        if (index === -1) {
                            selected.push(id);
                        } else {
                            selected.splice(index, 1);
                        }
                    });

                }
            });
            $('#request').change(function () {
                oTable.ajax.url("practice/tableForRequest/" + getFacultiesVal() + "/" +
                    getSpecialityVal() + "?minavg=" + getMinAvgVal() + "&date=" + getDate() + "&budget=" + getIsBudget());
                oTable.draw();
            });

        }

        function getFacultiesVal() {
            var result = $('#faculties').val();
            if (result === null) result = 1;
            return result;
        }

        function getSpecialityVal() {
            var result = $('#specs').val();
            if (result === null) result = 1;
            return result;
        }

        function getMinAvgVal() {
            var result = $('#mivavg').val();
            if (result === null || result === "" || result < 4 || result > 10) result = 4.0;
            return result;
        }

        function getIsBudget() {
            if ($('#budget').is(":checked")) return "1"; else return "0";
        }

        function getDate() {
            return $('#reservation').val();
        }



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
                    <li><a href="#newrequest" data-toggle="tab">Создать заявку</a></li>
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
                    <div class="tab-pane" id="newrequest">

                        <div id="success" class="alert alert-success alert-dismissible" style="display: none">
                            <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                            <h4><i class="icon fa fa-check"></i> Заявка создана!</h4>
                        </div>

                        <div id="error" class="alert alert-danger alert-dismissible" style="display: none">
                            <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                            <h4><i class="icon fa fa-ban"></i> Ошибка!</h4>
                        </div>

                        <!-- The timeline -->
                        <div class="box box-primary">
                            <div class="box-header with-border">
                                <h3 class="box-title">Создание заявки</h3>
                            </div>
                            <!-- /.box-header -->
                            <div class="box-body">
                                <form role="form" id="request" action="practice/addRequest"
                                      method="post">
                                    <!-- text input -->
                                    <div class="form-group">
                                        <label>Название практики</label>
                                        <input data-validation="length letternumeric" data-validation-length="2-45"
                                               type="text" class="form-control" name="name"
                                               placeholder="Введите имя...">
                                    </div>
                                    <div class="form-group">
                                        <label for="reservation">Дата практики:</label>
                                        <div class="input-group">
                                            <div class="input-group-addon">
                                                <i class="fa fa-calendar"></i>
                                            </div>
                                            <input type="text" name="daterange" class="form-control pull-right"
                                                   id="reservation">
                                        </div>
                                        <!-- /.input group -->
                                    </div>

                                    <div class="form-group">
                                        <label>Количество студентов</label>
                                        <input data-validation="number" data-validation-allowing="range[5;1000]"
                                               data-validation-error-msg="Введите целое число от 5 до 1000" type="text"
                                               class="form-control" name="number" placeholder="Введите кол-во...">
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
                                        <label>
                                            <input name="isBudget" id="budget" type="checkbox">
                                            Бюджетник
                                        </label>
                                    </div>

                                    <div class="form-group">
                                        <label>Минимальный средний балл</label>
                                        <input data-validation="number" data-validation-allowing="range[4.0;10.0],float"
                                               data-validation-error-msg="Значение выходит за диапазон возможных оценок"
                                               type="text" name="minAvg" id="mivavg" class="form-control"
                                               placeholder="Введите ср. балл...">
                                    </div>
                                    <input type="hidden" name="${_csrf.parameterName}"
                                           value="${_csrf.token}"/>
                                    <div class="box-footer">
                                        <button type="submit" class="btn btn-primary">Создать</button>
                                    </div>
                                </form>
                                <table id="tstudents" class="table table-bordered table-striped">
                                    <thead>
                                    <tr>
                                        <th></th>
                                        <th>Имя</th>
                                        <th>Фамилия</th>
                                        <th>Факультет</th>
                                        <th>Специальность</th>
                                        <th>Группа</th>
                                        <th>Средний балл</th>
                                    </tr>
                                    </thead>
                                    <tbody>

                                    </tbody>
                                    <tfoot>
                                    <tr>
                                        <th>Выбрать</th>
                                        <th>Имя</th>
                                        <th>Фамилия</th>
                                        <th>Факультет</th>
                                        <th>Специальность</th>
                                        <th>Группа</th>
                                        <th>Средний балл</th>
                                    </tr>
                                    </tfoot>
                                </table>
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
</body>
</html>
