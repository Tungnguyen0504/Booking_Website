<%@ page import="com.booking.entity.HotelService" %>
<%@ page import="java.time.LocalTime" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<jsp:include page="../layout/header.jsp"/>

<!-- ##### Breadcumb Area Start ##### -->
<section class="breadcumb-area bg-img d-flex align-items-center justify-content-center" style="background-image: url(
<c:url value="/user/assets/img/bg-img/bg-2.jpg"/> );">
    <div class="bradcumbContent">
        <h2>Về chúng tôi</h2>
    </div>
</section>
<!-- ##### Breadcumb Area End ##### -->

<jsp:include page="../layout/book-now.jsp"/>

<!-- ##### About Us Area Start ##### -->
<section class="about-us-area">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-12 col-lg-6">
                <div class="about-text mb-100">
                    <div class="section-heading">
                        <div class="line-"></div>
                        <h2>Về The Palatin</h2>
                    </div>
                    <p>Được thành lập vào năm 1996 ở Amsterdam, Thepalatin.com đã phát triển từ một nhóm khởi nghiệp nhỏ
                        ở
                        Hà Lan để trở thành một trong các công ty hàng đầu thế giới cung cấp các dịch vụ du lịch dựa
                        trên nền tảng số hóa. Là một phần của Booking Holdings Inc. (NASDAQ: BKNG), sứ mệnh của
                        Thepalatin.com là giúp mọi người trải nghiệm thế giới dễ dàng hơn.</p>
                    <a href="#" class="btn palatin-btn mt-50">Xem thêm</a>
                </div>
            </div>

            <div class="col-12 col-lg-6">
                <div class="about-thumbnail mb-100">
                    <img src="img/bg-img/2.jpg" alt="">
                </div>
            </div>
        </div>
    </div>
</section>
<!-- ##### About Us Area End ##### -->

<!-- ##### Milestones Area Start ##### -->
<section class="our-milestones section-padding-100-0 bg-img bg-overlay bg-fixed"
         style="background-image: url(<c:url value="/user/assets/img/bg-img/bg-4.jpg"/>);">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-12 col-lg-8">
                <div class="section-heading text-center white">
                    <div class="line-"></div>
                    <h2>Các thông tin quan trọng</h2>
                    <p>Thương hiệu Thepalatin.com hiện cũng là đối tác của Tổng cục Du lịch Việt Nam, thực hiện công tác
                        quốc
                        gia quảng bá Du lịch Việt Nam. Điển hình là hai chương trình “Super Selfie” – chụp ảnh tự sướng
                        toàn cảnh lớn nhất Châu Á và “#WHYVIETNAM” tận dụng sức mạnh của mạng xã hội và hoạt động tiếp
                        thị trực tuyến để lan tỏa hình ảnh đẹp nhất về Việt Nam tới bạn bè quốc tế.</p>
                </div>
            </div>
        </div>

        <div class="row">

            <!-- Single Cool Facts -->
            <div class="col-12 col-sm-6 col-lg-3">
                <div class="single-cool-fact mb-100 wow fadeInUp" data-wow-delay="300ms">
                    <div class="scf-text">
                        <i class="icon-cocktail-1"></i>
                        <h2><span class="counter">65</span></h2>
                        <p>Dịch vụ/ ngày</p>
                    </div>
                </div>
            </div>

            <!-- Single Cool Facts -->
            <div class="col-12 col-sm-6 col-lg-3">
                <div class="single-cool-fact mb-100 wow fadeInUp" data-wow-delay="500ms">
                    <div class="scf-text">
                        <i class="icon-swimming-pool"></i>
                        <h2><span class="counter">3</span></h2>
                        <p>Bể bơi</p>
                    </div>
                </div>
            </div>

            <!-- Single Cool Facts -->
            <div class="col-12 col-sm-6 col-lg-3">
                <div class="single-cool-fact mb-100 wow fadeInUp" data-wow-delay="700ms">
                    <div class="scf-text">
                        <i class="icon-resort"></i>
                        <h2><span class="counter">70</span></h2>
                        <p>Phòng</p>
                    </div>
                </div>
            </div>

            <!-- Single Cool Facts -->
            <div class="col-12 col-sm-6 col-lg-3">
                <div class="single-cool-fact mb-100 wow fadeInUp" data-wow-delay="900ms">
                    <div class="scf-text">
                        <i class="icon-restaurant"></i>
                        <h2><span class="counter">25</span></h2>
                        <p>Căn hộ</p>
                    </div>
                </div>
            </div>

        </div>
    </div>
</section>
<!-- ##### Milestones Area End ##### -->

<!-- ##### Hotels Area Start ##### -->
<section class="our-hotels-area section-padding-100-0">
    <div class="container">
        <div class="row">
            <div class="col-12">
                <div class="section-heading text-center">
                    <div class="line-"></div>
                    <h2>Các khách sạn của chúng tôi</h2>
                </div>
            </div>
        </div>

        <div class="row justify-content-center">
            <!-- Single Hotel Info -->
            <div class="col-12 col-md-6 col-lg-4">
                <div class="single-hotel-info mb-100">
                    <div class="hotel-info-text">
                        <h6><span class="fa fa-check"></span>Hình ảnh chất lượng, bắt mắt.</h6>
                        <h6><span class="fa fa-check"></span>Chức năng đặt phòng trực tuyến.</h6>
                        <h6><span class="fa fa-check"></span>Thân thiện, dễ dàng sử dụng.</h6>
                    </div>
                    <div class="hotel-img">
                        <img src="img/bg-img/3.jpg" alt="">
                    </div>
                </div>
            </div>
            <!-- Single Hotel Info -->
            <div class="col-12 col-md-6 col-lg-4">
                <div class="single-hotel-info mb-100">
                    <div class="hotel-info-text">
                        <h6><span class="fa fa-check"></span>Hỗ trợ đa ngôn ngữ.</h6>
                        <h6><span class="fa fa-check"></span>Nhiều loại hình dịch vụ độc đáo.</h6>
                        <h6><span class="fa fa-check"></span>Thông tin liên hệ, tư vấn trực tuyến.</h6>
                    </div>
                    <div class="hotel-img">
                        <img src="img/bg-img/10.jpg" alt="">
                    </div>
                </div>
            </div>
            <!-- Single Hotel Info -->
            <div class="col-12 col-md-6 col-lg-4">
                <div class="single-hotel-info mb-100">
                    <div class="hotel-info-text">
                        <h6><span class="fa fa-check"></span>Tích hợp bản đồ chi tiết.</h6>
                        <h6><span class="fa fa-check"></span>Đánh giá và nhận xét cho du khách xác thực nhất.</h6>
                        <h6><span class="fa fa-check"></span>Internet miễn phí mọi lúc.</h6>
                    </div>
                    <div class="hotel-img">
                        <img src="img/bg-img/11.jpg" alt="">
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- ##### Hotels Area End ##### -->

<!-- ##### Testimonial Area Start ##### -->
<section class="testimonial-area section-padding-100 bg-img"
         style="background-image: url(<c:url value="/user/assets/img/core-img/pattern.png"/>);">
    <div class="container">
        <div class="row">
            <div class="col-12">
                <div class="testimonial-content">
                    <div class="section-heading text-center">
                        <div class="line-"></div>
                        <h2>Đánh giá của khách hàng</h2>
                    </div>

                    <!-- Testimonial Slides -->
                    <div class="testimonial-slides owl-carousel">

                        <!-- Single Testimonial -->
                        <div class="single-testimonial">
                            <p>The location, the food, the excellent breakfast, the skybar (what a blast to enjoy a good
                                cocktail with this view), the comfort of the room, the kindness of the employees.
                                Everything! We were lucky to be upgraded (how to make our stay even more enjoyable!) and
                                a special THANK YOU to Nam who did everything to ease our life and gave us some real
                                good tips for Ho Chi Minh. Just go and stop worrying!</p>
                            <h6>Michael Smith, <span>Client</span></h6>
                            <img src="img/core-img/trip.png" alt="">
                        </div>

                        <!-- Single Testimonial -->
                        <div class="single-testimonial">
                            <p>Everything connected to this property was beyond our expectations! The stuff is extremely
                                nice, rooms are incredible, breakfast is just amazing and the location is superb!
                                Definitely to recommend to anyone travelling to Hanoi! Thanks to all the personnel at
                                the hotel for the heart-warm welcome and excellent service throughout our stay 😀.</p>
                            <h6>Nazrul Islam, <span>Developer</span></h6>
                            <img src="img/core-img/trip.png" alt="">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- ##### Testimonial Area End ##### -->
<jsp:include page="../layout/footer.jsp"/>