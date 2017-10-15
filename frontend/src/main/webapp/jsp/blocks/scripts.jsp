<%--
  Created by IntelliJ IDEA.
  User: Shaleshka
  Date: 08.10.17
  Time: 22:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!-- jQuery 3 -->
<script src="resources/js/libs/jquery.min.js"></script>
<script src="resources/js/libs/popper.js"></script>
<!-- Bootstrap 3.3.7 -->
<script src="resources/js/libs/bootstrap.min.js"></script>
<!-- iCheck -->
<script src="resources/js/libs/icheck.min.js"></script>

<!-- InputMask -->
<script src="resources/js/libs/jquery.inputmask.js"></script>
<script src="resources/js/libs/jquery.inputmask.date.extensions.js"></script>
<script src="resources/js/libs/jquery.inputmask.extensions.js"></script>
<!-- date-range-picker -->
<script src="resources/js/libs/moment.min.js"></script>
<script src="resources/js/libs/daterangepicker.js"></script>
<!-- DataTables -->
<script src="resources/js/libs/jquery.dataTables.min.js"></script>
<script src="resources/js/libs/dataTables.bootstrap.min.js"></script>
<script>
    $(function () {
        $('input').iCheck({
            checkboxClass: 'icheckbox_square-blue',
            radioClass: 'iradio_square-blue',
            increaseArea: '20%' // optional
        });
    });
</script>