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
                                                        </tr>
                                                        </thead>
                                                        <tbody>
                                                        <tr>
                                                            <td>Андрей</td>
                                                            <td>Даниленко</td>
                                                            </td>
                                                            <td>ФКП</td>
                                                            <td>ПМС</td>
                                                            <td>513803</td>
                                                            <td>-4</td>
                                                        </tr>
                                                        <tr>
                                                            <td>Костя</td>
                                                            <td>Новичук</td>
                                                            </td>
                                                            <td>ФКП</td>
                                                            <td>ПМС</td>
                                                            <td>513803</td>
                                                            <td>-3</td>
                                                        </tr>
                                                        <tr>
                                                            <td>Евгений</td>
                                                            <td>Шнейдеров</td>
                                                            </td>
                                                            <td>ФКП</td>
                                                            <td>ИСИТ(БМ)</td>
                                                            <td>514301</td>
                                                            <td>9.5</td>
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
                                                </tr>
                                                </thead>
                                                <tbody>
                                                <tr>
                                                    <td>Андрей</td>
                                                    <td>Даниленко</td>
                                                    </td>
                                                    <td>ФКП</td>
                                                    <td>ПМС</td>
                                                    <td>513803</td>
                                                    <td>-4</td>
                                                </tr>
                                                <tr>
                                                    <td>Костя</td>
                                                    <td>Новичук</td>
                                                    </td>
                                                    <td>ФКП</td>
                                                    <td>ПМС</td>
                                                    <td>513803</td>
                                                    <td>-3</td>
                                                </tr>
                                                <tr>
                                                    <td>Евгений</td>
                                                    <td>Шнейдеров</td>
                                                    </td>
                                                    <td>ФКП</td>
                                                    <td>ИСИТ(БМ)</td>
                                                    <td>514301</td>
                                                    <td>9.5</td>
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
        </div>

        <!-- /.tab-content -->
    </div>
    <!-- /.nav-tabs-custom -->
    <!-- /.col -->
    <!-- /.row -->

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
    })
</script>
</body>
</html>
