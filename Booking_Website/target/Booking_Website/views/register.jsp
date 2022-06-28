<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="description" content="">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Title -->
    <title>The Palatin - Hotel &amp; Resort Template</title>

    <!-- Favicon -->
    <link rel="icon" href="<c:url value="/user/assets/img/core-img/favicon.ico"/>">

    <!-- Core Stylesheet -->
    <link rel="stylesheet" href="<c:url value="/user/assets/css/style.css"/> ">


</head>

<body>
<!-- Preloader -->
<div class="preloader d-flex align-items-center justify-content-center">
    <div class="cssload-container">
        <div class="cssload-loading"><i></i><i></i><i></i><i></i></div>
    </div>
</div>

<!-- Image and text -->
<nav class="navbar navbar-primary position-absolute py-3 w-100" style="background: rgba(0, 0, 0, 0.63); z-index: 5; top: 0;">
    <div class="container">
        <img src="<c:url value="/user/assets/img/core-img/logo.png"/> " width="173" class="d-inline-block align-top"
             alt="">
    </div>
</nav>

<div class="bg-wrapper">
</div>

<div class="login-box" style="width: 30%;">
    <div class="card">
        <div class="card-body">
            <div class="card-title m-0">
                <h4 class="card-text text-center font-weight-bold mb-4">Vui lòng đăng ký tài khoản</h4>
            </div>
            <div id="test-form" novalidate>
                <div>
                    <div class="mb-3 input-group">
                        <input type="text" class="form-control" id="fullName" name="fullName"
                               placeholder="Họ và tên ..." required>
                    </div>
                    <div class="mb-3 input-group">
                        <input type="email" class="form-control" id="email" name="email"
                               placeholder="Địa chỉ e-mail ..." required>
                    </div>
                    <div class="mb-3 input-group">
                        <input type="password" class="form-control" id="password" name="password"
                               placeholder="Mật khẩu ..." required>
                    </div>
                    <div class="mb-3 input-group">
                        <input type="password" class="form-control" id="confirm" name="confirm"
                               placeholder="Nhập lại mật khẩu ..." required>
                    </div>
                    <div class="mb-3 text-center">
                        <button type="submit" class="btn palatin-btn btn-block w-100" id="click"
                                style="height: 48px; line-height: 48px;;" onclick="registerAjax()">Đăng ký
                        </button>
                    </div>
                    <div>
                        <a href="<%=request.getContextPath()%>/login" class="link-primary text-decoration-none">Chuyển
                            sang đăng nhập</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- ##### Footer Area End ##### -->

<!-- ##### All Javascript Script ##### -->
<!-- jQuery-2.2.4 js -->
<script src="<c:url value="/user/assets/js/jquery/jquery-2.2.4.min.js"/>"></script>
<!-- Popper js -->
<script src="<c:url value="/user/assets/js/bootstrap/popper.min.js"/>"></script>
<!-- Bootstrap js -->
<script src="<c:url value="/user/assets/js/bootstrap/bootstrap.min.js"/>"></script>
<!-- All Plugins js -->
<script src="<c:url value="/user/assets/js/plugins/plugins.js"/>"></script>
<!-- Active js -->
<script src="<c:url value="/user/assets/js/active.js"/>"></script>
<!-- datepicker -->
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<script src="https://npmcdn.com/flatpickr/dist/l10n/vn.js"></script>
<script src="https://unpkg.com/flatpickr@4.6.11/dist/plugins/rangePlugin.js"></script>
<%--carousel--%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js"
        integrity="sha512-bPs7Ae6pVvhOSiIcyUClR7/q2OAsRiovw4vAkX+zJbw3ShAeeqezq50RIIcIURq7Oa20rW2n2q+fyXBNcU9lrw=="
        crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<%--validation--%>
<script type="text/javascript" src="<c:url value="/user/assets/js/validation/bs4-form-validation.js"/>"></script>
<%--sweet-alert--%>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<script>
    let form = new Validation("test-form");
    // Validation Functions
    form.requireText("fullName", 4, 30, null, []);
    form.requireEmail("email", 4, 30, [" "], []);
    form.registerPassword("password", 6, 20, [" "], [], "confirm");

    function registerAjax() {
        var fullName = $('input[name="fullName"]').val();
        var email = $('input[name="email"]').val();
        var password = $('input[name="password"]').val();

        $.ajax({
            url: "register",
            type: "post",
            dataType: 'json',
            data: {
                fullName: fullName,
                email: email,
                password: password
            },
            success: function (result) {
                if (result == "0") {
                    swal("Địa chỉ email đã tồn tại!", "", "error");
                }
                if (result == "1") {
                    swal("Đăng ký tài khoản thành công!", "", "success")
                        .then(() => {
                            window.location.assign("login");
                        });
                }
            }, error: function (e) {
                console.log(e);
            }
        });
    }
</script>
</body>

</html>