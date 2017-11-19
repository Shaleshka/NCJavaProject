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

        var prtables = [];

        var prselected = [];

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
                '                                                <div class="box-body"><div class="panel">\n' +
                '<button type="button" id="delBut_' + value.id + '" class="btn btn-danger disabled" onclick="delChecked(' + value.id + ')">\n' +
                '                                                            Удалить выделеных\n' +
                '                                                        </button>' +
                '<button type="button" class="btn btn-primary pull-right" onclick="info(' + value.id + ')">\n' +
                '                                                            Информация\n' +
                '                                                        </button></div>' +
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
            prselected[value.id] = [];
            prtables[value.id] = $('#practice_' + value.id).DataTable({
                "processing": true,
                "serverSide": true,
                'autoWidth': false,
                "ajax": "practice/tableForPractice/" + value.id,
                "rowCallback": function (row, data) {
                    var button = $(row).find('td:nth-child(8) > button');
                    var str = button.attr('onclick');
                    button.attr('onclick', str.substr(0, str.length - 1) + ", " + value.id + ")");
                },
                "drawCallback": function () {
                    var cb = $('#practice_' + value.id).find('input[type="checkbox"]');
                    cb.iCheck({
                        checkboxClass: 'icheckbox_square-blue',
                        radioClass: 'iradio_square-blue',
                        increaseArea: '20%' // optional
                    });
                    cb.on('ifChanged', function () {
                        var id = this.id;
                        var index = $.inArray(id, prselected[value.id]);

                        if (index === -1) {
                            prselected[value.id].push(id);
                        } else {
                            prselected[value.id].splice(index, 1);
                        }

                        if (prselected[value.id].length > 0) {
                            $('#delBut_' + value.id).attr('class', 'btn btn-danger');
                        }
                        else {
                            $('#delBut_' + value.id).attr('class', 'btn btn-danger disabled');
                        }
                    });
                    if ($.inArray(cb.attr('id'), prselected[value.id]) !== -1) {
                        cb.iCheck('check');
                    }
                }
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
            $('#reservation').daterangepicker();
            $('#request').ajaxForm({
                dataType: 'json',
                data: {
                    "checked[]": selected
                },
                success: function (data) {
                    if (data) {
                        appendPractice(0, data);
                        $('#success').css('display', 'block');
                    } else {
                        $('#error').css('display', 'block');
                    }
                },
                error: function (xhr, textStatus, errorThrown) {
                    alert(xhr + " " + textStatus + " " + errorThrown);
                }
            });
            $.validate({
                lang: 'ru'
            });
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
                    $('#tstudents').find('input[type="checkbox"]').not('.selectall').iCheck({
                        checkboxClass: 'icheckbox_square-blue',
                        radioClass: 'iradio_square-blue',
                        increaseArea: '20%' // optional
                    });
                    $('.selectall').iCheck({
                        checkboxClass: 'icheckbox_square-blue',
                        radioClass: 'iradio_square-blue',
                        increaseArea: '20%' // optional
                    });
                    $('.selectall').on('ifChecked', function () {
                        $('#tstudents').find('input[type="checkbox"]').not('.selectall').iCheck('check');
                    });
                    $('.selectall').on('ifUnchecked', function () {
                        $('#tstudents').find('input[type="checkbox"]').not('.selectall').iCheck('uncheck');
                    });
                    $('#tstudents').find('input[type="checkbox"]').not('.selectall').on('ifChanged', function () {
                        var id = this.id;
                        var index = $.inArray(id, selected);

                        if (index === -1) {
                            selected.push(id);
                        } else {
                            selected.splice(index, 1);
                        }
                        if ($('#tstudents').find('input[type="checkbox"]').not('.selectall').length === selected.length) {
                            $('.selectall').prop('checked', true).iCheck('update');
                        }
                        else {
                            $('.selectall').prop('checked', false).iCheck('update');
                        }
                    });

                }
            });
            $('#request').on('change', function () {
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

        function delStudent(stid, id) {
            $.ajax({
                url: 'practice/remove/' + id + '/' + stid + "?${_csrf.parameterName}=${_csrf.token}",
                success: function () {
                    prtables[id].draw();
                }
            })
        }

        function delChecked(id) {
            $.ajax({
                url: 'practice/removeAll/' + id + "?${_csrf.parameterName}=${_csrf.token}",
                method: 'post',
                data: {
                    "students[]": prselected[id]
                },
                success: function (data) {
                    prtables[id].draw();
                    prselected[id] = [];
                    $('#delBut_' + value.id).attr('class', 'btn btn-danger disabled');
                }
            })
        }

        function info(id) {
            $.ajax({
                url: 'practice/get/' + id + "?${_csrf.parameterName}=${_csrf.token}",
                success: function (data) {
                    var modal = $('#info');
                    modal.find('#p_name').text("Имя: " + data.name);
                    modal.find('#p_faculty').text("Факультет: " + data.facultyId);
                    modal.find('#p_speciality').text("Специальность: " + data.specialityId);
                    modal.find('#p_number').text("Кол-во: " + data.number);
                    modal.find('#p_minavg').text("Мин. ср. балл: " + data.minAvg);
                    modal.find('#p_isbudget').text("Бюджетник: " + data.isBudget);
                    modal.find('#p_daterange').text("Дата: " + customDateConverter(data.start) + " - " + customDateConverter(data.end));
                    modal.modal();
                }
            })
        }

        function customDateConverter(date) {
            var dim = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
            var mstrings = ["января", "февраля", "марта", "апреля", "мая", "июня",
                "июля", "августа", "сентября", "октября", "ноября", "декабря"];
            var seconds = date / 1000 + 3 * 3600;
            var i = 0;
            while (seconds > 3600 * 24 * 365) {
                seconds -= 3600 * 24 * 365 + !(i % 4) * 24 * 3600;
                i++;
            }
            year = i + 1970;
            if (year % 4 === 0) dim[2] = 29;
            var month;
            for (i = 0; i < 12; i++) {
                seconds -= dim[i] * 24 * 3600;
                if (seconds < 0) {
                    seconds += dim[i] * 24 * 3600;
                    month = i;
                    break;
                }
            }
            var days = seconds / (24 * 3600) + 1;
            return days.toString() + " " + mstrings[month] + " " + year.toString();
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
                                <form id="request"
                                      action="/practice/addRequest/${id}?${_csrf.parameterName}=${_csrf.token}"
                                      method="post" role="form">
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
                                        <th>
                                            <input type="checkbox" class="selectall">
                                        </th>
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
                                        <th><input type="checkbox" class="selectall"></th>
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

<div class="modal modal-info fade" id="info">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">Информация о практике</h4>
            </div>
            <div class="modal-body">
                <p id="p_name">Имя: жава</p>
                <p id="p_faculty">Факультет: ФКП</p>
                <p id="p_speciality">Специальность: ПМС</p>
                <p id="p_number">Количество студентов: </p>
                <p id="p_minavg">Минимальный средний балл: </p>
                <p id="p_isbudget">Бюджетники: да</p>
                <p id="p_daterange">Дата: 12 февраля 2017 - 15 сентября 2017 </p>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-outline" data-dismiss="modal">Закрыть</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>

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
