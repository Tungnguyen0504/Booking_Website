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

<body style="background-image: url(<c:url value="/user/assets/img/core-img/pattern.png"/> ); ">
<!-- Preloader -->
<div class="preloader d-flex align-items-center justify-content-center">
    <div class="cssload-container">
        <div class="cssload-loading"><i></i><i></i><i></i><i></i></div>
    </div>
</div>

<!-- ##### Testimonial Area Start ##### -->
<section class="testimonial-area bg-img"
         style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); width: 1000px;">
    <div class="container">
        <div class="row">
            <div class="col-12">
                <div class="testimonial-content">
                    <div class="section-heading text-center">
                        <div class="line-"></div>
                        <h2>Đơn đặt phòng đã được xác nhận</h2>
                    </div>

                    <!-- Testimonial Slides -->
                    <div class="">

                        <!-- Single Testimonial -->
                        <div class="single-testimonial ">
                            <p class="text-dark font-weight-normal" style="font-style: normal; margin-bottom: 50px;">Đơn
                                hàng của quý khách đã được thanh toán thành công. Chúng tôi đã gửi một email xác nhận
                                tới địa chỉ email <strong>${sessionScope.account.email}</strong>.<br> Quý khách có thể tra
                                cứu đơn hàng của mình theo link
                                <a style="font-size: 16px;" class="text-primary"
                                   href="<%=request.getContextPath()%>/my-account?action=bookingHistory&accountId=${sessionScope.account.accountId}">https://vntrip.vn/tra-cuu-don-hang</a>.
                            </p>
                            <img src="<c:url value="/user/assets/img/core-img/trip.png"/>" alt=" ">
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- ##### Testimonial Area End ##### -->


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
<script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js" integrity="sha512-bPs7Ae6pVvhOSiIcyUClR7/q2OAsRiovw4vAkX+zJbw3ShAeeqezq50RIIcIURq7Oa20rW2n2q+fyXBNcU9lrw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<%--validation--%>
<script type="text/javascript" src="<c:url value="/user/assets/js/validation/bs4-form-validation.js"/>"></script>
<!-- lightgallery -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/lightgallery/2.5.0-beta.2/lightgallery.umd.min.js" integrity="sha512-e+39qUKXdaNAHHzMx+zHLald62YcdVqJpJGAqs6iIJ6RRWy5/9PKJr1eDAc3SuM/PTpguz9v2d83j6SFgnbTdg==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/lightgallery/2.5.0-beta.2/lightgallery.min.js" integrity="sha512-Z3EF+OVry8EO1N1EFn6/j1v+PQJ3UqRJ3X+PEFHhJRd7sbEbxI2mZ1suHiXPiofaH7GiKrIZewfGpO+G98Kq5Q==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/lightgallery/2.5.0-beta.2/plugins/thumbnail/lg-thumbnail.min.js" integrity="sha512-5iUCnPChYt6WP9Pooi9qAEg71JPENtx7j0Pe+wgNv3IycrpzM91dCx+99amCpKEbz+oiUMV/05N0M1nvn1yFNw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<%--input-spinner-bootstrap--%>
<script src="<c:url value="/user/assets/js/input-spinner-bootstrap/bootstrap-input-spinner.js"/> "></script>
<%--script--%>
<script src="<c:url value="/user/assets/js/script.js"/> "></script>

</body>

</html>