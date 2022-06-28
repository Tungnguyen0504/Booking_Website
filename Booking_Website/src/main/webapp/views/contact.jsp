<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.booking.entity.HotelService" %>
<%@ page import="java.time.LocalTime" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<jsp:include page="../layout/header.jsp"/>

<!-- ##### Breadcumb Area Start ##### -->
<section class="breadcumb-area bg-img d-flex align-items-center justify-content-center" style="background-image: url(<c:url value="/user/assets/img/bg-img/bg-8.jpg"/> );">
    <div class="bradcumbContent">
        <h2>Liên hệ</h2>
    </div>
</section>
<!-- ##### Breadcumb Area End ##### -->

<jsp:include page="../layout/book-now.jsp"/>

<!-- ##### Contact Area Start ##### -->
<section class="contact-information-area">
    <div class="container">
        <div class="row">

            <!-- Single Contact Information -->
            <div class="col-12 col-lg-4">
                <div class="single-contact-information mb-100">
                    <div class="section-text">
                        <h3>Hà Nội</h3>
                    </div>
                    <!-- Single Contact Information -->
                    <div class="contact-content d-flex">
                        <p>Địa chỉ</p>
                        <p>Trường Đại học Tài nguyên và Môi trường Hà Nội, 41A Đ. Phú Diễn, Phú Diễn, Bắc Từ Liêm, Hà Nội</p>
                    </div>
                    <!-- Single Contact Information -->
                    <div class="contact-content d-flex">
                        <p>Điện thoại</p>
                        <p>+123 456 789</p>
                    </div>
                    <!-- Single Contact Information -->
                    <div class="contact-content d-flex">
                        <p>E-mail</p>
                        <p>admin@gmail.com</p>
                    </div>
                </div>
            </div>

            <!-- Single Contact Information -->
            <div class="col-12 col-lg-4">
                <div class="single-contact-information mb-100">
                    <div class="section-text">
                        <h3>Tp. Hồ Chí Minh</h3>
                    </div>
                    <!-- Single Contact Information -->
                    <div class="contact-content d-flex">
                        <p>Địa chỉ</p>
                        <p>73 Trần Não, Phường An Khánh, TP Thủ Đức, Thành Phố Hồ Chí Minh, Việt Nam 70000</p>
                    </div>
                    <!-- Single Contact Information -->
                    <div class="contact-content d-flex">
                        <p>Điện thoại</p>
                        <p>+36 345 7953 4994</p>
                    </div>
                    <!-- Single Contact Information -->
                    <div class="contact-content d-flex">
                        <p>E-mail</p>
                        <p>yourmail@gmail.com</p>
                    </div>
                </div>
            </div>

            <!-- Single Contact Information -->
            <div class="col-12 col-lg-4">
                <div class="single-contact-information mb-100">
                    <div class="section-text">
                        <h3>Cần Thơ</h3>
                    </div>
                    <!-- Single Contact Information -->
                    <div class="contact-content d-flex">
                        <p>Địa chỉ</p>
                        <p>Số 1A/6 - A4, KDC 3A, KV6, Phường An Bình, Quận Ninh Kiều, Thành phố Cần Thơ.</p>
                    </div>
                    <!-- Single Contact Information -->
                    <div class="contact-content d-flex">
                        <p>Điện thoại</p>
                        <p>+77 345 7953 2406</p>
                    </div>
                    <!-- Single Contact Information -->
                    <div class="contact-content d-flex">
                        <p>E-mail</p>
                        <p>yourmail@gmail.com</p>
                    </div>
                </div>
            </div>

        </div>
    </div>
</section>
<!-- ##### Contact Area End ##### -->

<!-- ##### Contact Form Area Start ##### -->
<section class="contact-form-area mb-100">
    <div class="container">
        <div class="row">
            <div class="col-12">
                <div class="section-heading">
                    <div class="line-"></div>
                    <h2>Thông tin liên hệ</h2>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-12">
                <!-- Contact Form -->
                <div class="form-contact">
                    <div class="row">
                        <div class="col-lg-4">
                            <input type="text" class="form-control" name="fullName" placeholder="Họ và tên ...">
                        </div>
                        <div class="col-lg-4">
                            <input type="email" class="form-control" name="email" placeholder="Địa chỉ E-mail ...">
                        </div>
                        <div class="col-lg-4">
                            <input type="text" class="form-control" name="subject" placeholder="Tiêu đề ...">
                        </div>
                        <div class="col-12">
                            <textarea class="form-control" name="message" cols="30" rows="10" placeholder="Nội dung ..."></textarea>
                        </div>
                        <div class="col-12">
                            <button type="submit" class="contact-btn btn palatin-btn mt-50">Gửi tin nhắn</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- ##### Contact Form Area End ##### -->

<script>
    $('.contact-btn').on('click', function (){
        var fullName = $('input[name="fullName"]').val();
        var email = $('input[name="email"]').val();
        var subject = $('input[name="subject"]').val();
        var message = $('textarea[name="message"]').val();

        $.ajax({
            url: "contact",
            type: "post",
            data: {
                fullName: fullName,
                email: email,
                subject: subject,
                message: message
            },
            success: function () {
                swal({
                    title: "Cảm ơn.",
                    text: "Chúng tôi đã nhận được ý kiến đóng góp của bạn!",
                    icon: "success"
                }).then((value) => {
                    location.reload();
                });
            }
        });
    });
</script>

<!-- ##### Google Maps ##### -->
<div class="map-area mb-100">
    <div class="container">
        <div class="row">
            <div class="col-12">
                <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3723.655070024998!2d105.76001421488365!3d21.04648318598871!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x313454c3ce577141%3A0xb1a1ac92701777bc!2zVHLGsOG7nW5nIMSQ4bqhaSBo4buNYyBUw6BpIG5ndXnDqm4gdsOgIE3DtGkgdHLGsOG7nW5nIEjDoCBO4buZaQ!5e0!3m2!1svi!2sbd!4v1651605160087!5m2!1svi!2sbd" width="600" height="450" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../layout/footer.jsp"/>