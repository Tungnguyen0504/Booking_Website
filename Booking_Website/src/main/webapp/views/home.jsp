<%@page buffer="8192kb" autoFlush="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.booking.util.FunctionUtil" %>

<jsp:include page="../layout/header.jsp"/>

<style>
    p {
        color: #7d7d7d;
        font-size: 14px;
        line-height: 2.1;
        font-weight: 400;
    }
</style>

<jsp:useBean id="HotelTypeDAO" scope="page" class="com.booking.dao.DAOImpl.HotelTypeDAOImpl"/>
<jsp:useBean id="HotelDAO" scope="page" class="com.booking.dao.DAOImpl.HotelDAOImpl"/>
<jsp:useBean id="RoomDAO" scope="page" class="com.booking.dao.DAOImpl.RoomDAOImpl"/>
<jsp:useBean id="RatingDAO" scope="page" class="com.booking.dao.DAOImpl.RatingDAOImpl"/>
<jsp:useBean id="CityDAO" scope="page" class="com.booking.dao.DAOImpl.CityDAOImpl"/>
<jsp:useBean id="FunctionUtil" scope="page" class="com.booking.util.FunctionUtil"/>

<!-- ##### Hero Area Start ##### -->
<section class="hero-area">
    <div class="hero-slides owl-carousel">

        <!-- Single Hero Slide -->
        <div class="single-hero-slide d-flex align-items-center justify-content-center">
            <!-- Slide Img -->
            <div class="slide-img bg-img" style="background-image: url(
            <c:url value="/user/assets/img/bg-img/bg-1.jpg"/> );"></div>
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-12 col-lg-9">
                        <!-- Slide Content -->
                        <div class="hero-slides-content" data-animation="fadeInUp" data-delay="100ms">
                            <div class="line" data-animation="fadeInUp" data-delay="300ms"></div>
                            <h2 data-animation="fadeInUp" data-delay="500ms">Thiên đường du lịch</h2>
                            <p data-animation="fadeInUp" data-delay="700ms">
                                Luôn gắn các giá trị văn hóa bản địa với mọi hoạt động kinh doanh để
                                tạo ra chuỗi giá trị mang thương hiệu The Palatin trong nỗ lực quảng bá hình ảnh du
                                lịch Việt Nam đến với bạn bè quốc tế, góp phần đưa du lịch trở thành ngành kinh tế mũi
                                nhọn. </p>
                            <a href="#" class="btn palatin-btn mt-50" data-animation="fadeInUp" data-delay="900ms">Xem
                                thêm</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Single Hero Slide -->
        <div class="single-hero-slide d-flex align-items-center justify-content-center">
            <!-- Slide Img -->
            <div class="slide-img bg-img"
                 style="background-image: url(<c:url value="/user/assets/img/bg-img/bg-2.jpg"/>);"></div>
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-12 col-lg-9">
                        <!-- Slide Content -->
                        <div class="hero-slides-content" data-animation="fadeInUp" data-delay="100ms">
                            <div class="line" data-animation="fadeInUp" data-delay="300ms"></div>
                            <h2 data-animation="fadeInUp" data-delay="500ms">Một nơi để nhớ</h2>
                            <p data-animation="fadeInUp" data-delay="700ms">Triết lý kinh doanh của chúng tôi là động
                                lực thúc đẩy hướng đi thống nhất của tập
                                thể The Palatin Group, với mục tiêu doanh nghiệp luôn đồng hành cùng xã hội, cộng đồng
                                để phát triển kinh tế và các giá trị tinh thần, nhân văn.</p>
                            <a href="#" class="btn palatin-btn mt-50" data-animation="fadeInUp" data-delay="900ms">Xem
                                thêm</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Single Hero Slide -->
        <div class="single-hero-slide d-flex align-items-center justify-content-center">
            <!-- Slide Img -->
            <div class="slide-img bg-img"
                 style="background-image: url(<c:url value="/user/assets/img/bg-img/bg-3.jpg"/>);"></div>
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-12 col-lg-9">
                        <!-- Slide Content -->
                        <div class="hero-slides-content" data-animation="fadeInUp" data-delay="100ms">
                            <div class="line" data-animation="fadeInUp" data-delay="300ms"></div>
                            <h2 data-animation="fadeInUp" data-delay="500ms">Hưởng thụ cuộc sống</h2>
                            <p data-animation="fadeInUp" data-delay="700ms">Với biểu tượng bông mai vàng 5 cánh bao
                                quanh quả địa cầu, The Palatin Group được tượng trưng cho sứ mệnh nâng tầm vị thế du
                                lịch Việt Nam, mang hình ảnh Việt Nam đến khắp năm châu thông qua việc cung cấp các trải
                                nghiệm, sản phẩm, dịch vụ độc đáo, chứa đựng giá trị văn hóa tinh thần với chất lượng
                                quốc tế.</p>
                            <a href="#" class="btn palatin-btn mt-50" data-animation="fadeInUp" data-delay="900ms">Xem
                                thêm</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
</section>
<!-- ##### Hero Area End ##### -->

<jsp:include page="../layout/book-now.jsp"/>


<!-- ##### Rooms Area Start ##### -->
<section class="rooms-area" style="margin-bottom: 70px;">
    <div class="container wow fadeInUp">
        <div>
            <div class="col-12 col-lg-6 mx-auto">
                <div class="section-heading text-center">
                    <div class="line-"></div>
                    <h2>Khám phá Việt Nam</h2>
                    <p>Điểm du lịch nào có nhiều cảnh quan đẹp, món ăn ngon, đáng đến nhất là điều mà nhiều du khách
                        trong và ngoài nước quan tâm khi lên kế hoạch khám phá Việt Nam.</p>
                </div>
            </div>
        </div>

        <div>

            <style>
                .city-block {
                    padding: 0;
                }

                .city-block {
                    padding-left: 1rem;
                }

                .city-row .city-block:first-child {
                    padding-left: 0;
                }
            </style>

            <div class="row city-row pb-3">
                <c:forEach items="${cityList}" var="city" varStatus="loop" begin="0" end="1">
                    <div class="col-6 city-block">
                        <a class="city-btn" href="<%=request.getContextPath()%>/search-hotel?city=${city.cityId}">
                            <img class="image-fluid rounded w-100 h-100" style="object-fit: cover;"
                                 src="<c:url value="/uploads/city/${city.cityImage}"/>">
                            <div class="position-absolute text-white" style="top: 15px; left: 35px;">
                                <span class="font-weight-bold" style="font-size: 24px;">${city.cityName}</span>
                                <img style="margin-bottom: 8px; margin-left: 2px; border-radius: 2px;" width="24"
                                     src="https://upload.wikimedia.org/wikipedia/commons/thumb/2/21/Flag_of_Vietnam.svg/2560px-Flag_of_Vietnam.svg.png">
                                <br>
                                <span>${HotelDAO.countHotelByCityId(city.cityId)} chỗ ở</span>
                            </div>
                            <div class="position-absolute rounded"
                                 style="background: rgba(0, 0, 0, 0.63); bottom: 40px; right: 35px; padding: 7px;">
                                <p class="mb-0 text-white" style="line-height: normal">Ưu đãi bắt đầu
                                    từ<br><fmt:formatNumber
                                            type="number" value="${HotelDAO.getMinHotelPriceByCityId(city.cityId)}"
                                            maxFractionDigits="0"/> VND</p>
                            </div>
                        </a>
                    </div>
                </c:forEach>
            </div>

            <div class="row city-row">
                <c:forEach items="${cityList}" var="city" varStatus="loop" begin="2" end="4">
                    <div class="col-4 city-block">
                        <input type="hidden" value="city5" name="cityId">
                        <a class="city-btn" href="<%=request.getContextPath()%>/search-hotel?city=${city.cityId}">
                            <img class="image-fluid rounded w-100 h-100" style="object-fit: cover;"
                                 src="<c:url value="/uploads/city/${city.cityImage}"/>">
                            <div class="position-absolute text-white" style="top: 15px; left: 35px;">
                                <span class="font-weight-bold" style="font-size: 24px;">${city.cityName}</span>
                                <img style="margin-bottom: 8px; margin-left: 2px; border-radius: 2px;" width="24"
                                     src="https://upload.wikimedia.org/wikipedia/commons/thumb/2/21/Flag_of_Vietnam.svg/2560px-Flag_of_Vietnam.svg.png">
                                <br>
                                <span>${HotelDAO.countHotelByCityId(city.cityId)} chỗ ở</span>
                            </div>
                            <div class="position-absolute rounded"
                                 style="background: rgba(0, 0, 0, 0.63); bottom: 40px; right: 35px; padding: 7px;">
                                <p class="mb-0 text-white" style="line-height: normal">Ưu đãi bắt đầu
                                    từ<br><fmt:formatNumber
                                            type="number" value="${HotelDAO.getMinHotelPriceByCityId(city.cityId)}"
                                            maxFractionDigits="0"/> VND</p>
                            </div>
                        </a>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</section>
<!-- ##### Rooms Area End ##### -->

<style>
    #type-hotel .item div:first-child {
        height: 145px;
    }

    .item div img {
        object-fit: cover;
        width: 100%;
        height: 100%;
        border-radius: 3px;
    }

    .owl-theme .owl-nav {
        display: none;
    }
</style>

<section class="rooms-area pb-5">
    <div class="container bg-white px-3 py-4 shadow rounded wow fadeInUp">
        <div class="px-3">
            <h5 class="font-weight-bold mb-3">Tìm theo loại chỗ nghỉ</h5>

            <div class="owl-carousel owl-theme" id="type-hotel">
                <c:forEach items="${listHotelType}" var="o">
                    <div class="item">
                        <input type="hidden" value="type${o.typeId}" name="hotelTypeId">
                        <a class="hotel-type-btn" href="<%=request.getContextPath()%>/search-hotel?type=${o.typeId}">
                            <div>
                                <img src="<c:url value="/uploads/hotel-type/${o.hotelTypeImage}"/>">
                            </div>
                            <div class="pt-3">
                                <a class="font-weight-bold" style="font-size: 16px" href="">${o.typeName}</a>
                                <p class="mb-0">${HotelTypeDAO.getCountHotelTypeById(o.typeId)} ${o.typeName}</p>
                            </div>
                        </a>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</section>

<!-- ##### About Us Area Start ##### -->
<section class="about-us-area">
    <div class="container">
        <div class="row align-items-center">

            <div class="col-12 col-lg-6">
                <div class="about-text text-center mb-100">
                    <div class="section-heading text-center">
                        <div class="line-"></div>
                        <h2>Một nơi để nhớ</h2>
                    </div>
                    <p>Làm sao để trước mỗi chuyến đi, bạn không cần phải ngồi hàng giờ để tìm kiếm thông tin, gọi điện
                        từng phòng vé, từng khách sạn để so sánh, thủ tục lôi thôi, thời gian chờ đợi mệt mỏi? Đó là câu
                        hỏi thôi thúc những nhà sáng lập đã gây dựng và phát triển nên ứng dụng du lịch trực tuyến
                        The Palatin, với mong muốn mang lại cho khách hàng trải nghiệm toàn diện và dễ chịu nhất với mức
                        giá tiết kiệm nhất, tất cả trên 1 cú nhấp chuột: Thepalatin.vn.</p>
                    <div class="about-key-text">
                        <h6><span class="fa fa-check"></span> Đặt khách sạn RẺ HƠN GIÁ RẺ NHẤT</h6>
                        <h6><span class="fa fa-check"></span> THANH TOÁN LINH HOẠT, BẢO MẬT</h6>
                        <h6><span class="fa fa-check"></span> HỖ TRỢ CHUYÊN NGHIỆP 24/7</h6>
                    </div>
                    <a href="#" class="btn palatin-btn mt-50">Xem thêm</a>
                </div>
            </div>

            <div class="col-12 col-lg-6">
                <div class="about-thumbnail homepage mb-100">
                    <!-- First Img -->
                    <div class="first-img wow fadeInUp" data-wow-delay="100ms">
                        <img src="<c:url value="/user/assets/img/bg-img/5.jpg"/>" alt="">
                    </div>
                    <!-- Second Img -->
                    <div class="second-img wow fadeInUp" data-wow-delay="300ms">
                        <img src="<c:url value="/user/assets/img/bg-img/6.jpg"/>" alt="">
                    </div>
                    <!-- Third Img-->
                    <div class="third-img wow fadeInUp" data-wow-delay="500ms">
                        <img src="<c:url value="/user/assets/img/bg-img/7.jpg"/>" alt="">
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- ##### About Us Area End ##### -->

<section class="rooms-area" style="padding-bottom: 100px;">
    <div class="container bg-white py-4 shadow rounded wow fadeInUp">
        <h5 class="font-weight-bold pl-3 mb-3">Các chỗ trống có thể bạn muốn xem</h5>

        <style>
            .single-rooms-area {
                height: 475px;
            }

            .rooms-text {
                height: 240px;
            }
        </style>

        <div id="relate-hotel" class="carousel slide" data-ride="carousel">
            <div class="carousel-inner">
                <div class="owl-carousel owl-theme" id="random-hotel1">
                    <c:forEach items="${listTop9}" var="o" varStatus="loop">
                        <!-- Single Rooms Area -->
                        <div class="col item">
                            <a href="<%=request.getContextPath()%>/room?hotelId=${o.hotelId}">
                                <div class="single-rooms-area mb-5" data-wow-delay="200ms">
                                    <c:forTokens items="${o.hotelImage}" delims="|" var="splitImage" begin="0"
                                                 end="0">
                                        <div class="bg-thumbnail bg-img"
                                             style="background-image: url(<c:url
                                                     value="/uploads/hotel/${splitImage}"/>);"></div>
                                    </c:forTokens>
                                    <div class="rooms-text text-left">
                                        <div class="line"></div>
                                        <div class="mb-1">
                                            <span class="text-white">${HotelTypeDAO.getHotelTypeById(o.hotelTypeId)}</span>
                                        </div>
                                        <h4 class="text-truncate text-white mb-1">${o.hotelName}</h4>

                                        <c:set value="${RoomDAO.getRoomMinPriceByHotelId(o.hotelId)}" var="r"/>
                                        <div>
                                            <p class="text-white mb-0" style="font-size: 15px;">Bắt đầu từ<strong
                                                    class="ml-2" style="font-size: 16px;">VND <fmt:formatNumber
                                                    value="${r.price * ((100-r.discountPercent) / 100)}"
                                                    type="number" maxFractionDigits="0"/></strong>
                                            </p>
                                        </div>

                                        <c:set var="countRate"
                                               value="${FunctionUtil.countRating(RatingDAO.getAllListRatingByHotelId(o.hotelId))}"/>
                                        <c:set var="ratingPoint"
                                               value="${FunctionUtil.countRatingPoint(RatingDAO.getAllListRatingByHotelId(o.hotelId))}"/>

                                        <div class="d-flex align-items-center text-white">
                                            <div class="d-flex align-items-center justify-content-center font-weight-bold"
                                                 style="background: #003580; height: 28px; width: 28px; border-radius:5.8181818182px 5.8181818182px 5.8181818182px
                                    0; color: #ffffff; margin: 0px 6px 0px 0px; ">

                                                <fmt:formatNumber
                                                        value="${ratingPoint}"
                                                        type="number" maxFractionDigits="1"/>
                                            </div>
                                            <div>
                                                <small>${countRate} đánh giá</small>
                                            </div>
                                        </div>

                                        <c:if test="${r.quantity < 5}">
                                            <div>
                                                <p class="mb-0" style="font-size: 15px; color: yellowgreen;">Chỉ còn lại
                                                        ${r.quantity}
                                                    phòng</p>
                                            </div>
                                        </c:if>
                                        <!-- Studio Superior -->
                                    </div>
                                </div>
                            </a>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- ##### Pool Area Start ##### -->
<section class="pool-area section-padding-100 bg-img bg-fixed"
         style="background-image: url(<c:url value="/user/assets/img/bg-img/4.png"/>); margin-bottom: 100px;">
    <div class="container">
        <div class="row justify-content-end">
            <div class="col-12 col-lg-7">
                <div class="pool-content text-center wow fadeInUp" data-wow-delay="300ms">
                    <div class="section-heading text-center white">
                        <div class="line-"></div>
                        <h2>Hồ bơi vô cực</h2>
                        <p>Với những tính năng và kết cấu như những bể bơi thông thường với phần thành bể được thiết kế
                            không nhìn thấy tạo cảm giác hồ nước kéo dài tới vô cực . Những bể bơi này thường được xây
                            dựng ngoài trời tại các khu nghỉ dưỡng , khách sạn sang trọng gần biển hoặc núi non tăng cảm
                            giác mênh mông , rộng lớn . Du khách đến ngoài việc bơi lội giải trí còn để chụp những bức
                            hình đẹp bên cạnh hồ.</p>
                    </div>

                    <div class="row">
                        <div class="col-12 col-sm-4">
                            <div class="pool-feature">
                                <i class="icon-cocktail-1"></i>
                                <p>Thức uống</p>
                            </div>
                        </div>
                        <div class="col-12 col-sm-4">
                            <div class="pool-feature">
                                <i class="icon-swimming-pool"></i>
                                <p>Hồ bơi</p>
                            </div>
                        </div>
                        <div class="col-12 col-sm-4">
                            <div class="pool-feature">
                                <i class="icon-beach"></i>
                                <p>Tắm nắng</p>
                            </div>
                        </div>
                    </div>
                    <!-- Button -->
                    <a href="#" class="btn palatin-btn mt-50">Xem thêm</a>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- ##### Pool Area End ##### -->

<!-- ##### Contact Area Start ##### -->
<section class="contact-area d-flex flex-wrap align-items-center">
    <div class="home-map-area">
        <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3723.655070024998!2d105.76001421488365!3d21.04648318598871!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x313454c3ce577141%3A0xb1a1ac92701777bc!2zVHLGsOG7nW5nIMSQ4bqhaSBo4buNYyBUw6BpIG5ndXnDqm4gdsOgIE3DtGkgdHLGsOG7nW5nIEjDoCBO4buZaQ!5e0!3m2!1svi!2sbd!4v1651605160087!5m2!1svi!2sbd"
                width="600" height="450" style="border:0;" allowfullscreen="" loading="lazy"
                referrerpolicy="no-referrer-when-downgrade"></iframe>
    </div>
    <!-- Contact Info -->
    <div class="contact-info">
        <div class="section-heading wow fadeInUp" data-wow-delay="100ms">
            <div class="line-"></div>
            <h2>Thông tin liên hệ</h2>
            <p>Nếu có bất kỳ thắc mắc nào, vui lòng liên hệ với tư vấn viên The Palatin theo:</p>
        </div>
        <h5 class="wow fadeInUp" data-wow-delay="300ms">Trường Đại học Tài nguyên và Môi trường Hà Nội, 41A Đ. Phú Diễn,
            Phú Diễn, Bắc Từ Liêm, Hà Nội</h5>
        <h5 class="wow fadeInUp" data-wow-delay="400ms">+123 456 789</h5>
        <h5 class="wow fadeInUp" data-wow-delay="500ms">admin@gmail.com</h5>
        <!-- Social Info -->
        <div class="social-info mt-50 wow fadeInUp" data-wow-delay="600ms">
            <a href="#"><i class="fa fa-pinterest" aria-hidden="true"></i></a>
            <a href="#"><i class="fa fa-facebook" aria-hidden="true"></i></a>
            <a href="#"><i class="fa fa-twitter" aria-hidden="true"></i></a>
            <a href="#"><i class="fa fa-dribbble" aria-hidden="true"></i></a>
            <a href="#"><i class="fa fa-behance" aria-hidden="true"></i></a>
            <a href="#"><i class="fa fa-linkedin" aria-hidden="true"></i></a>
        </div>
    </div>
</section>
<!-- ##### Contact Area End ##### -->

<jsp:include page="../layout/footer.jsp"/>