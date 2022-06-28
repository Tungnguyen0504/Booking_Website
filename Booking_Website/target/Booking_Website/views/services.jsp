<%@ page import="com.booking.entity.HotelService" %>
<%@ page import="java.time.LocalTime" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<jsp:include page="../layout/header.jsp"/>

<!-- ##### Breadcumb Area Start ##### -->
<section class="breadcumb-area bg-img d-flex align-items-center justify-content-center" style="background-image: url(<c:url value="/user/assets/img/bg-img/bg-5.jpg"/> );">
    <div class="bradcumbContent">
        <h2>Dịch vụ</h2>
    </div>
</section>
<!-- ##### Breadcumb Area End ##### -->

<jsp:include page="../layout/book-now.jsp"/>

<!-- ##### Service Intro Area Start ##### -->
<section class="services-intro">
    <div class="container">
        <div class="row align-items-center">
            <!-- Service Intro Text -->
            <div class="col-12 col-lg-6">
                <div class="service-intro-text mb-100">
                    <div class="section-heading">
                        <div class="line-"></div>
                        <h2>Giới thiệu</h2>
                    </div>
                    <p>Làm sao để trước mỗi chuyến đi, bạn không cần phải ngồi hàng giờ để tìm kiếm thông tin, gọi điện từng phòng vé, từng khách sạn để so sánh, thủ tục lôi thôi, thời gian chờ đợi mệt mỏi? Đó là câu hỏi thôi thúc những nhà sáng lập đã gây dựng và phát triển nên ứng dụng du lịch trực tuyến Vntrip.vn, với mong muốn mang lại cho khách hàng trải nghiệm toàn diện và dễ chịu nhất với mức giá tiết kiệm nhất, tất cả trên 1 cú nhấp chuột: Thepalatin.vn.</p>
                    <a href="#" class="btn palatin-btn mt-50">Xem thêm</a>
                </div>
            </div>

            <!-- Services Features -->
            <div class="col-12 col-lg-6">
                <div class="row mb-100">

                    <!-- Single Cool Facts -->
                    <div class="col-12 col-sm-4">
                        <div class="single-cool-fact">
                            <div class="scf-text">
                                <i class="icon-cocktail-1"></i>
                                <p>Ăn uống</p>
                            </div>
                        </div>
                    </div>

                    <!-- Single Cool Facts -->
                    <div class="col-12 col-sm-4">
                        <div class="single-cool-fact">
                            <div class="scf-text">
                                <i class="icon-swimming-pool"></i>
                                <p>Bể bơi</p>
                            </div>
                        </div>
                    </div>

                    <!-- Single Cool Facts -->
                    <div class="col-12 col-sm-4">
                        <div class="single-cool-fact">
                            <div class="scf-text">
                                <i class="icon-beach"></i>
                                <p>Tắm nắng</p>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</section>
<!-- ##### Service Intro Area End ##### -->

<!-- ##### Core Features Start ##### -->
<section class="core-features-area">
    <div class="container">
        <div class="row justify-content-center">

            <!-- Single Core Feature Area -->
            <div class="col-12 col-md-6 col-lg-4">
                <div class="single-core-feature mb-100">
                    <div class="bg-thumbnail bg-img" style="background-image: url(<c:url value="/user/assets/img/bg-img/12.jpg"/>);"></div>
                    <!-- Content -->
                    <div class="feature-content">
                        <i class="icon-camera"></i>
                        <h3>Sức khỏe</h3>
                        <p>Dịch vụ này bao gồm những công việc cơ bản như chăm sóc vấn đề ăn uống, vệ sinh cá nhân, hỗ trợ xoa bóp, nhắc nhở uống thuốc đúng giờ,..</p>
                    </div>
                </div>
            </div>

            <!-- Single Core Feature Area -->
            <div class="col-12 col-md-6 col-lg-4">
                <div class="single-core-feature mb-100">
                    <div class="bg-thumbnail bg-img" style="background-image: url(<c:url value="/user/assets/img/bg-img/13.jpg"/>);"></div>
                    <!-- Content -->
                    <div class="feature-content">
                        <i class="icon-sunset"></i>
                        <h3>Spa center</h3>
                        <p>Các dịch vụ làm đẹp và chăm sóc da tại spa luôn được chị em phụ nữ quan tâm nhờ những công dụng, hiệu quả mang đến cho làn da.</p>
                    </div>
                </div>
            </div>

            <!-- Single Core Feature Area -->
            <div class="col-12 col-md-6 col-lg-4">
                <div class="single-core-feature mb-100">
                    <div class="bg-thumbnail bg-img" style="background-image: url(<c:url value="/user/assets/img/bg-img/14.jpg"/>);"></div>
                    <!-- Content -->
                    <div class="feature-content">
                        <i class="icon-island"></i>
                        <h3>Quầy bar</h3>
                        <p>Quầy bar chill chưa bao giờ là đủ với các tín đồ của rượu, cocktail cũng như những vị khách vãng lai tìm kiếm một nơi chốn thư giãn cho riêng mình.</p>
                    </div>
                </div>
            </div>

        </div>
    </div>
</section>
<!-- ##### Core Features End ##### -->

<!-- ##### Services Area Start ##### -->
<section class="services-area">
    <div class="container">
        <div class="row">

            <!-- Single Service Area -->
            <div class="col-12 col-sm-6 col-lg-4">
                <div class="single-service-area mb-100 wow fadeInUp" data-wow-delay="100ms">
                    <i class="icon-trekking"></i>
                    <h4>Trí tuệ nhân tạo</h4>
                    <p>Tự động tìm vé rẻ nhất để đảm bảo giá thành phù hợp cho ngân sách của bạn.</p>
                </div>
            </div>

            <!-- Single Service Area -->
            <div class="col-12 col-sm-6 col-lg-4">
                <div class="single-service-area mb-100 wow fadeInUp" data-wow-delay="200ms">
                    <i class="icon-boat"></i>
                    <h4>Tiết kiệm thời gian</h4>
                    <p>Xác nhận ngay, không cần đợi nhân viên tư vấn tìm phòng và vé mất thời gian.</p>
                </div>
            </div>

            <!-- Single Service Area -->
            <div class="col-12 col-sm-6 col-lg-4">
                <div class="single-service-area mb-100 wow fadeInUp" data-wow-delay="300ms">
                    <i class="icon-restaurant"></i>
                    <h4>Rẻ nhất thị trường</h4>
                    <p>Giá cuối cùng, không thu thêm phí ngoài như các trang khác. Bán đúng giá để bạn yên tâm lựa chọn.</p>
                </div>
            </div>

            <!-- Single Service Area -->
            <div class="col-12 col-sm-6 col-lg-4">
                <div class="single-service-area mb-100 wow fadeInUp" data-wow-delay="400ms">
                    <i class="icon-beach"></i>
                    <h4>HỖ TRỢ CHUYÊN NGHIỆP 24/7</h4>
                    <p>Chuyến đi hay đơn đặt phòng của bạn gặp vấn đề vào lúc 2h sáng? Vntrip.vn sẵn sàng hỗ trợ, tư vấn miễn phí giúp bạn giải quyết vấn đề thông qua tổng đài 0963 266 688. Vì khách quên thân - toàn tâm phục vụ!</p>
                </div>
            </div>

            <!-- Single Service Area -->
            <div class="col-12 col-sm-6 col-lg-4">
                <div class="single-service-area mb-100 wow fadeInUp" data-wow-delay="500ms">
                    <i class="icon-boarding-pass"></i>
                    <h4>ẢNH KHÁCH SẠN 360°</h4>
                    <p>Lo ngại vì thực tế “không như là ảnh mạng”? Lần đầu tiên và duy nhất trên thế giới, Vntrip.vn giúp bạn trải nghiệm khách sạn theo cách chân thực nhất với công nghệ ảnh 360°, giúp bạn an tâm hơn khi đặt phòng.</p>
                </div>
            </div>

            <!-- Single Service Area -->
            <div class="col-12 col-sm-6 col-lg-4">
                <div class="single-service-area mb-100 wow fadeInUp" data-wow-delay="600ms">
                    <i class="icon-sign"></i>
                    <h4>THANH TOÁN LINH HOẠT, BẢO MẬT</h4>
                    <p>Bạn có thể dùng: Thẻ nội địa, Thẻ quốc tế, Chuyển khoản, hay thông qua các cổng và ví thanh toán uy tín như: ZaloPay, AirPay, VnPay, Momo... Đảm bảo linh hoạt, bảo mật thông tin cá nhân, tránh cho khách hàng khỏi nguy cơ bị kẻ xấu lợi dụng.</p>
                </div>
            </div>

        </div>
    </div>
</section>
<!-- ##### Services Area End ##### -->

<jsp:include page="../layout/footer.jsp"/>