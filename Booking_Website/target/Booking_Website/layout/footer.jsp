<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- ##### Footer Area Start ##### -->
<footer class="footer-area">
    <div class="container">
        <div class="row">

            <!-- Footer Widget Area -->
            <div class="col-12 col-lg-5">
                <div class="footer-widget-area mt-50">
                    <a href="#" class="d-block mb-5"><img src="<c:url value="/user/assets/img/core-img/logo.png"/>"
                                                          alt=""></a>
                    <p>Thepalatin.com là một trang web du lịch trực tuyến cho đặt chỗ, được thành lập vào năm 1996. Công
                        ty được vận hành bởi Booking Holdings, có có trụ sở tại Hoa Kỳ, và là nguồn lợi nhuận chính của
                        tập đoàn này. Booking.com có trụ sở tại Amsterdam, Hà Lan.</p>
                </div>
            </div>

            <!-- Footer Widget Area -->
            <div class="col-12 col-md-6 col-lg-4">
                <div class="footer-widget-area mt-50">
                    <h6 class="widget-title mb-5">Tìm chúng tôi tại:</h6>
                    <img src="<c:url value="/user/assets/img/bg-img/footer-map.png"/>" alt="">
                </div>
            </div>

            <!-- Footer Widget Area -->
            <div class="col-12 col-md-6 col-lg-3">
                <div class="footer-widget-area mt-50">
                    <h6 class="widget-title mb-5">Theo dõi bản tin của chúng tôi</h6>
                    <form action="#" method="post" class="subscribe-form">
                        <input type="email" name="subscribe-email" id="subscribeemail" placeholder="Địa chỉ E-mail">
                        <button type="submit">Đăng ký</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</footer>
<!-- ##### Footer Area End ##### -->

<!-- ##### All Javascript Script ##### -->

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
<!-- lightgallery -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/lightgallery/2.5.0-beta.2/lightgallery.umd.min.js"
        integrity="sha512-e+39qUKXdaNAHHzMx+zHLald62YcdVqJpJGAqs6iIJ6RRWy5/9PKJr1eDAc3SuM/PTpguz9v2d83j6SFgnbTdg=="
        crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/lightgallery/2.5.0-beta.2/lightgallery.min.js"
        integrity="sha512-Z3EF+OVry8EO1N1EFn6/j1v+PQJ3UqRJ3X+PEFHhJRd7sbEbxI2mZ1suHiXPiofaH7GiKrIZewfGpO+G98Kq5Q=="
        crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/lightgallery/2.5.0-beta.2/plugins/thumbnail/lg-thumbnail.min.js"
        integrity="sha512-5iUCnPChYt6WP9Pooi9qAEg71JPENtx7j0Pe+wgNv3IycrpzM91dCx+99amCpKEbz+oiUMV/05N0M1nvn1yFNw=="
        crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<%--input-spinner-bootstrap--%>
<script src="<c:url value="/user/assets/js/input-spinner-bootstrap/bootstrap-input-spinner.js"/> "></script>
<%--datatable--%>
<script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.11.5/js/dataTables.bootstrap4.min.js"></script>
<%--sweet-alert--%>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<%--star-rating--%>
<script src="<c:url value="/user/assets/js/star-rating/starrr.js"/>"></script>
<!-- file-input -->
<script src="https://cdn.jsdelivr.net/gh/kartik-v/bootstrap-fileinput@5.2.5/js/plugins/piexif.min.js" type="text/javascript"></script>
<script src="https://cdn.jsdelivr.net/gh/kartik-v/bootstrap-fileinput@5.2.5/js/plugins/sortable.min.js" type="text/javascript"></script>
<script src="https://cdn.jsdelivr.net/gh/kartik-v/bootstrap-fileinput@5.2.5/js/fileinput.min.js"></script>
<%--script--%>
<script src="<c:url value="/user/assets/js/script.js"/> "></script>
</body>

</html>
