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

    <script>

        var facultyTable;
        var specialityTable;
        var studentsTable;
        var hopsTable;
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
                '                                        <div id="collapse_' + value.id + '" class="panel-collapse collapse">\n' +
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

        function adminPageInit() {
            $.ajax({
                url: 'practice/getAll',
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
            $('#student_new').ajaxForm({
                dataType: 'json',
                success: function (data) {
                    if (data) {
                        $('#new-student').modal('hide');
                        editStudent(data)
                    } else {
                        alert('Error!')
                    }
                }
            });
            hopsTable = $('#thops').DataTable({
                "processing": true,
                "serverSide": true,
                'autoWidth': false,
                "ajax": "admin/tableHop",
            });
            studentsTable = $('#tstudents').DataTable({
                "processing": true,
                "serverSide": true,
                'autoWidth': false,
                "ajax": "students/tableAllStudents",
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
                        if (selected.length > 0) {
                            $('#delBut').attr('class', 'btn btn-danger');
                        }
                        else {
                            $('#delBut').attr('class', 'btn btn-danger disabled');
                        }
                        if ($('#tstudents').find('input[type="checkbox"]').not('.selectall').length === $('#tstudents').find('input[type="checkbox"]:checked').not('.selectall').length) {
                            $('.selectall').prop('checked', true).iCheck('update');
                        }
                        else {
                            $('.selectall').prop('checked', false).iCheck('update');
                        }
                    });
                    if ($('#tstudents').find('input[type="checkbox"]').not('.selectall').length === $('#tstudents').find('input[type="checkbox"]:checked').not('.selectall').length) {
                        $('.selectall').prop('checked', true).iCheck('update');
                    }
                    else {
                        $('.selectall').prop('checked', false).iCheck('update');
                    }
                }
            });
            facultyTable = $('#tfaculty').DataTable({
                'paging': true,
                'lengthChange': false,
                'searching': true,
                'ordering': true,
                'info': true,
                'autoWidth': false
            });
            specialityTable = $('#tspecialities').DataTable({
                'paging': true,
                'lengthChange': false,
                'searching': true,
                'ordering': true,
                'info': true,
                'autoWidth': false
            });
            $('#facultyForm').ajaxForm({
                dataType: 'json',
                success: function (data) {
                    if (data) {
                        facultyTable.row.add([
                            data.name,
                            '<button onclick="delFaculty(' + data.id + ')" type="button" class="btn btn-block btn-danger">\n' +
                            '                                                                        Удалить\n' +
                            '                                                                    </button>'
                        ]).draw(false);
                        $('#new-faculty').modal('hide');
                    }
                }
            });
        }

        function delFaculty(id) {
            $.ajax({
                url: '/university/delFaculty?${_csrf.parameterName}=${_csrf.token}',
                method: 'post',
                data: {
                    'id': id
                },
                success: function (data) {
                    if (data) {
                        facultyTable.rows('#ftr' + data.id).remove().draw();
                        $.each($('#tspecialities').find('tr'), function (id, value) {
                            if ($(value).find('td:nth-child(2)').text() === data.name) this.remove();
                        })
                    }
                }
            })
        }

        function fillForm(id) {
            $.ajax({
                url: 'students/get/' + id,
                dataType: 'json',
                success: function (data) {
                    $('#f_faculties').val(data.facultyId);
                    refreshSpecialities(data.facultyId, data.specialityId);
                    $('input[name=fname]').val(data.fname);
                    $('input[name=lname]').val(data.lname);
                    $('input[name=group]').val(data.group);
                    if (data.isBudget) $('input[name=isBudget]').iCheck('toggle');
                    $('input[name=avgScore]').val(data.avgScore);
                    $('#student_edit').attr('action', '/students/edit/' + id + '?${_csrf.parameterName}=${_csrf.token}');
                    $('#student_edit').ajaxForm({
                        dataType: 'json',
                        success: function (data) {
                            if (data[0] != null) {
                                $('#success').css('display', 'none');
                                $('#error').css('display', 'block');
                                $('#error').find('h4').html("<i class=\"icon fa fa-ban\"></i> " + data[0].defaultMessage);
                            } else {
                                $('#error').css('display', 'none');
                                $('#success').css('display', 'block');
                                studentsTable.draw();
                            }
                        },
                        error: function (xhr, textStatus, errorThrown) {
                            $('#error').css('display', 'block');
                            $('#error').find('h4').text("<i class=\"icon fa fa-ban\"></i> Неизвестная ошибка");
                        }
                    });
                }
            });
        }

        function editStudent(id) {
            fillForm(id);
            $('#edit-student').modal('show');
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

        function info(id) {
            $.ajax({
                url: 'practice/get/' + id + "?${_csrf.parameterName}=${_csrf.token}",
                success: function (data) {
                    var modal = $('#info');
                    var yesno = ["нет", "да"];
                    modal.find('#p_name').text("Имя: " + data.name);
                    modal.find('#p_faculty').text("Факультет: " + data.faculty);
                    modal.find('#p_speciality').text("Специальность: " + data.speciality);
                    modal.find('#p_number').text("Кол-во: " + data.number);
                    modal.find('#p_minavg').text("Мин. ср. балл: " + data.minAvg);
                    modal.find('#p_isbudget').text("Бюджетник: " + yesno[data.isBudget]);
                    modal.find('#p_daterange').text("Дата: " + customDateConverter(data.start) + " - " + customDateConverter(data.end));
                    modal.modal();
                }
            })
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

        function delStudentCompletely(id) {
            $.ajax({
                url: "/students/delete/" + id + "?${_csrf.parameterName}=${_csrf.token}",
                method: "get",
                success: function () {
                    studentsTable.draw();
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

        function delStudent(stid, id) {
            if (arguments.length == 1) delStudentCompletely(stid); else $.ajax({
                url: 'practice/remove/' + id + '/' + stid + "?${_csrf.parameterName}=${_csrf.token}",
                success: function () {
                    prtables[id].draw();
                }
            })
        }

        function delstudents() {
            $.ajax({
                url: 'students/deleteFew' + "?${_csrf.parameterName}=${_csrf.token}",
                method: 'post',
                data: {
                    "students[]": selected
                },
                success: function (data) {
                    studentsTable.draw();
                    selected = [];
                    $('#delBut').attr('class', 'btn btn-danger disabled');
                }
            })
        }

        function delSpeciality(id) {
            $.ajax({
                url: '/university/delSpeciality?${_csrf.parameterName}=${_csrf.token}',
                method: 'post',
                data: {
                    'id': id
                },
                success: function (data) {
                    if (data) {
                        specialityTable.rows('#str' + data.id).remove().draw();
                    }
                }
            })
        }

    </script>

</head>
<body onload="adminPageInit()" class="hold-transition login-page">
<section class="content">

    <div class="row">
        <!-- /.col -->
        <div class="col-md-12">
            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs">
                    <li class="active"><a href="#activity" data-toggle="tab">Практики</a></li>
                    <li><a href="#new_hop" data-toggle="tab">Руководители практик</a></li>
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
                                <div class="box-group" id="practices">
                                    <!-- we are adding the .panel class so bootstrap.js collapse plugin detects it -->
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
                                <div class="pull-right">
                                    <button type="button" class="btn btn-default"
                                            data-toggle="modal" data-target="#new-hop">
                                        Добавить рук. практики
                                    </button>
                                    <button id="delHopBut" type="button" class="btn btn-danger disabled">
                                        Удалить выделенных
                                    </button>
                                </div>
                            </div>
                            <!-- /.box-header -->
                            <div class="box-body">

                                <table id="thops" class="table table-bordered table-striped">
                                    <thead>
                                    <tr>
                                        <th></th>
                                        <th>Имя</th>
                                        <th>Фамилия</th>
                                        <th>Компания</th>
                                        <th>Редактирование</th>
                                        <th>Удаление</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                    <tfoot>
                                    <tr>
                                        <th></th>
                                        <th>Имя</th>
                                        <th>Фамилия</th>
                                        <th>Компания</th>
                                        <th>Редактирование</th>
                                        <th>Удаление</th>
                                    </tr>
                                    </tfoot>
                                </table>
                            </div>
                            <!-- /.box-body -->
                        </div>

                    </div>
                    <!-- /.tab-pane -->
                    <div class="tab-pane" id="students">
                        <div class="box box-solid">
                            <div class="box-header with-border">
                                <h3 class="box-title">Студенты</h3>
                                <div class="pull-right">
                                    <button type="button" class="btn btn-default"
                                            data-toggle="modal" data-target="#new-student">
                                        Добавить студента
                                    </button>
                                    <button id="delBut" onclick="delstudents()" type="button"
                                            class="btn btn-danger disabled">
                                        Удалить выделенных
                                    </button>
                                </div>
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
                                            <table id="tstudents" class="table table-bordered table-striped">
                                                <thead>
                                                <tr>
                                                    <th><input type="checkbox" class="selectall"></th>
                                                    <th>Имя</th>
                                                    <th>Фамилия</th>
                                                    <th>Факультет</th>
                                                    <th>Специальность</th>
                                                    <th>Группа</th>
                                                    <th>Средний балл</th>
                                                    <th>Редактирование</th>
                                                    <th>Удаление</th>
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
                                                    <th>Редактирование</th>
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
                                                        <c:forEach items="${faculties}" var="item">
                                                            <tr id="ftr${item.getId()}">
                                                                <td>${item.getName()}</td>
                                                                <td>
                                                                    <button onclick="delFaculty(${item.getId()})"
                                                                            type="button"
                                                                            class="btn btn-block btn-danger">
                                                                        Удалить
                                                                    </button>
                                                                </td>
                                                            </tr>
                                                        </c:forEach>
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
                                                    <table id="tspecialities"
                                                           class="table table-bordered table-striped">
                                                        <thead>
                                                        <tr>
                                                            <th>Имя</th>
                                                            <th>Факультет</th>
                                                            <th>Удаление</th>
                                                        </tr>
                                                        </thead>
                                                        <tbody>
                                                        <c:forEach items="${specialities}" var="item">
                                                            <tr id="str${item.getId()}">
                                                                <td>${item.getName()}</td>
                                                                <td>${faculties.stream().filter(faculty -> faculty.getId()==item.getFacultyId()).findFirst().get().getName()}</td>
                                                                <td>
                                                                    <button onclick="delSpeciality(${item.getId()})"
                                                                            type="button"
                                                                            class="btn btn-block btn-danger">
                                                                        Удалить
                                                                    </button>
                                                                </td>
                                                            </tr>
                                                        </c:forEach>
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
                <form role="form" id="facultyForm" action="/university/addFaculty?${_csrf.parameterName}=${_csrf.token}"
                      method="post">
                    <div class="modal-body">
                        <div class="box-body">
                            <div class="form-group">
                                <label>Имя</label>
                                <input type="text" name="name" class="form-control"
                                       placeholder="Введите имя факультета...">
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default pull-left" data-dismiss="modal">Отмена</button>
                        <button type="submit" class="btn btn-primary">Создать</button>
                    </div>
                </form>
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
<div class="modal fade" id="edit-student" data-vivaldi-spatnav-clickable="1" style="display: none;">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span></button>
                <h4 class="modal-title">Редактирование студента</h4>
            </div>
            <div class="modal-body">
                <div id="success" class="alert alert-success alert-dismissible" style="display: none">
                    <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                    <h4><i class="icon fa fa-check"></i> Изменения приняты!</h4>
                </div>

                <div id="error" class="alert alert-danger alert-dismissible" style="display: none">
                    <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                    <h4><i class="icon fa fa-ban"></i> Ошибка!</h4>
                </div>
                <form id="student_edit"
                      action="" method="post"
                      role="form">
                    <div class="box-body">
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
                            <label for="f_faculties">Выберите факультет</label>
                            <select id="f_faculties" name="faculty" class="form-control">
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

                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-default pull-left" data-dismiss="modal">Закрыть
                        </button>
                        <button type="submit" class="btn btn-primary">Сохранить</button>
                    </div>
                </form>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<div class="modal fade" id="new-hop" data-vivaldi-spatnav-clickable="1" style="display: none;">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span></button>
                <h4 class="modal-title">Создать руководителя практики</h4>
            </div>
            <div class="modal-body">
                <div id="hop_success" class="alert alert-success alert-dismissible" style="display: none">
                    <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                    <h4><i class="icon fa fa-check"></i> Изменения приняты!</h4>
                </div>

                <div id="hop_error" class="alert alert-danger alert-dismissible" style="display: none">
                    <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                    <h4><i class="icon fa fa-ban"></i> Ошибка!</h4>
                </div>
                <form id="new_hop_form" role="form">
                    <div class="box-body">
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
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-default pull-left" data-dismiss="modal">Закрыть
                        </button>
                        <button type="submit" class="btn btn-primary">Создать</button>
                    </div>

                </form>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<div class="modal fade" id="new-student" data-vivaldi-spatnav-clickable="1" style="display: none;">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span></button>
                <h4 class="modal-title">Редактирование студента</h4>
            </div>
            <div class="modal-body">
                <form id="student_new"
                      action="/admin/newStudent" method="post"
                      role="form">
                    <div class="box-body">
                        <!-- text input -->
                        <div class="form-group has-feedback">
                            <input type="email" class="form-control" name="username" placeholder="Email">
                            <span class="glyphicon glyphicon-envelope form-control-feedback"></span>
                        </div>
                        <div class="form-group has-feedback">
                            <input type="password" class="form-control" name="password" placeholder="Пароль">
                            <span class="glyphicon glyphicon-lock form-control-feedback"></span>
                        </div>
                        <div class="form-group has-feedback">
                            <input type="password" class="form-control" placeholder="Повторите пароль">
                            <span class="glyphicon glyphicon-log-in form-control-feedback"></span>
                        </div>
                        <input type="hidden" name="${_csrf.parameterName}"
                               value="${_csrf.token}"/>

                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-default pull-left" data-dismiss="modal">Закрыть
                        </button>
                        <button type="submit" class="btn btn-primary">Сохранить</button>
                    </div>
                </form>
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
</body>
</html>
