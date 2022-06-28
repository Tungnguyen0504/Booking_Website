<%@page buffer="8192kb" autoFlush="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.booking.util.FunctionUtil" %>

<jsp:include page="../layout/header.jsp"/>

<!-- ##### Breadcumb Area Start ##### -->
<section class="breadcumb-area bg-img d-flex align-items-center justify-content-center" style="background-image: url(
<c:url value="/user/assets/img/bg-img/bg-9.jpg"/> );">
    <div class="bradcumbContent">
        <h2>Kết quả tìm kiếm</h2>
    </div>
</section>
<!-- ##### Breadcumb Area End ##### -->

<jsp:include page="../layout/book-now.jsp"/>

<!-- usebean -->
<jsp:useBean id="HotelTypeDAO" scope="page" class="com.booking.dao.DAOImpl.HotelTypeDAOImpl"/>
<jsp:useBean id="RoomDAO" scope="page" class="com.booking.dao.DAOImpl.RoomDAOImpl"/>
<jsp:useBean id="RatingDAO" scope="page" class="com.booking.dao.DAOImpl.RatingDAOImpl"/>
<jsp:useBean id="CityDAO" scope="page" class="com.booking.dao.DAOImpl.CityDAOImpl"/>
<jsp:useBean id="FunctionUtil" scope="page" class="com.booking.util.FunctionUtil"/>

<fmt:setLocale value="en_US"/>

<section class="rooms-area pb-5">
    <div class="container py-4 rounded shadow wow fadeInUp">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="<%=request.getContextPath()%>/home">Trang chủ</a></li>
                <li class="breadcrumb-item"><a href="#">${empty sessionScope.name ? "Tất cả" : sessionScope.name}</a>
                </li>
                <li class="breadcrumb-item active" aria-current="page">Kết quả tìm kiếm</li>
            </ol>
        </nav>
        <div class="row px-3">
            <div id="filter" class="col-12 col-lg-3 border rounded wow fadeInUp bg-white" style="height: fit-content;">
                <div class="border-bottom p-3">
                    <h4 class="m-0">
                        Chọn lọc theo:
                    </h4>
                </div>
                <div class="p-3 border-bottom">
                    <div class="filter-title mb-2">
                            <span class="font-weight-bold" style="font-size: 17px;">
                                Loại chỗ ở
                            </span>
                    </div>
                    <c:forEach items="${HotelTypeDAO.all}" var="ht" varStatus="loop">
                        <div class="filter-option form-check d-flex align-items-center">
                            <input class="form-check-input filter-check" type="checkbox" value="type${ht.typeId}"
                                   id="type${loop.index}" ${(loop.index + 1) == hotelTypeId ? "checked" : ""}>
                            <label class="form-check-label" for="type${loop.index}">
                                    ${ht.typeName}
                            </label>
                        </div>
                    </c:forEach>
                </div>

                <div class="p-3 border-bottom">
                    <div class="filter-title mb-2">
                            <span class="font-weight-bold" style="font-size: 17px;">
                                Thành phố
                            </span>
                    </div>
                    <c:forEach items="${CityDAO.all}" var="c" varStatus="loop">
                        <div class="filter-option form-check d-flex align-items-center">
                            <input class="form-check-input filter-check" type="checkbox" value="city${c.cityId}"
                                   id="city${loop.index}" ${(loop.index + 1) == city ? "checked" : ""}>
                            <label class="form-check-label" for="city${loop.index}">
                                    ${c.cityName}
                            </label>
                        </div>
                    </c:forEach>
                </div>

                <div class="p-3 border-bottom">
                    <div class="filter-title mb-2">
                            <span class="font-weight-bold" style="font-size: 17px;">
                                Xếp hạng sao
                            </span>
                    </div>
                    <c:forEach begin="1" end="5" var="i" varStatus="loop">
                        <div class="filter-option form-check d-flex align-items-center">
                            <input class="form-check-input filter-check" type="checkbox" value="star${loop.end - i + 1}"
                                   id="s${loop.end - i + 1}">
                            <label class="form-check-label" for="s${loop.end - i + 1}">
                                    ${loop.end - i + 1} sao
                            </label>
                        </div>
                    </c:forEach>
                </div>

                <div class="p-3 border-bottom">
                    <div class="filter-title mb-2">
                            <span class="font-weight-bold" style="font-size: 17px;">
                                Điểm đánh giá của khách
                            </span>
                    </div>
                    <c:forEach begin="1" end="4" var="i" varStatus="loop">
                        <div class="filter-option form-check d-flex align-items-center">
                            <input class="form-check-input filter-check" type="checkbox" id="rate${loop.end - i + 6}"
                                   value="rate${loop.end - i + 6}">
                            <label class="form-check-label" for="rate${loop.end - i + 6}">
                                    ${loop.end - i + 6} điểm trở lên
                                : ${loop.end - i + 6 == 9 ? "Tuyệt hảo" : loop.end - i + 6 == 8 ? "Rất tốt" : loop.end - i + 6 == 7 ? "Tốt" : "Dễ chịu"}
                            </label>
                        </div>
                    </c:forEach>
                </div>
            </div>
            <div class="col-12 col-lg-9 pr-0 wow fadeInUp">
                <div data-wow-delay="100ms">
                    <div class="d-flex align-items-center justify-content-between mb-4">
                        <div class="count-result">
                            <h3 class="m-0 font-weight-bold">
                                ${empty sessionScope.name ? "Kết quả" : sessionScope.name}: tìm thấy ${count} chỗ nghỉ
                            </h3>
                        </div>
                        <style>
                            .btn-group .nice-select span {
                                font-size: 17px;
                                color: #0071c2;
                                width: 250px;
                            }

                            .btn-group .nice-select:hover {
                                background-color: rgba(0, 113, 194, .06) !important;
                                border-radius: 0;
                            }

                            .btn-group .nice-select:after {
                                width: 8px;
                                height: 8px;
                                margin-top: -7px;
                            }

                            .btn-group .nice-select .list {
                                left: auto;
                                right: 10px;
                            }
                        </style>
                        <div class="btn-group">
                            <select class="form-select bg-transparent border-0 filter-sort">
                                <option selected disabled>Các lựa chọn cho bạn</option>
                                <option value="dbo.UF_CalculateRoomPrice(h.HotelId) ASC">Giá (Từ thấp đến cao)</option>
                                <option value="dbo.UF_CalculateRoomPrice(h.HotelId) DESC">Giá (Từ cao đến thấp)</option>
                                <option value="h.Star DESC">Hạng sao (Ưu tiên cao nhất)</option>
                                <option value="h.Star ASC">Hạng sao (Ưu tiên thấp nhất)</option>
                                <option value="dbo.UF_RatingPoint(h.HotelId) DESC">Được đánh giá hàng đầu</option>
                            </select>
                        </div>
                    </div>
                    <div class="list-search-result">
                        <c:forEach items="${listHotel}" var="hotel">
                            <div class="card mb-3 wow fadeInUp">
                                <div class="card-body">
                                    <div class="row no-gutters">
                                        <div class="col-3">
                                            <c:forTokens items="${hotel.hotelImage}" delims="|" var="image" begin="0"
                                                         end="0">
                                                <img style="width: 193px; height: 193px; object-fit: cover; margin-top: 10px;"
                                                     class="rounded" src="<c:url value="/uploads/hotel/${image}"/>">
                                            </c:forTokens>
                                        </div>
                                        <div class="col-9">
                                            <div class="card-body product-box" style="padding: 0.25rem 1.25rem;">
                                                <div class=" d-flex align-items-start justify-content-between ">
                                                    <div class="d-flex flex-column">
                                                        <a href="<%=request.getContextPath()%>/room?hotelId=${hotel.hotelId}">
                                                            <h5 class="card-title m-0 font-weight-bold text-truncate"
                                                                style="color: #0071c2; max-width: 400px;">${hotel.hotelName }</h5>
                                                        </a>
                                                        <c:if test="${hotel.star > 0}">
                                                            <div style="color: #febb02; margin-bottom: 2px;">
                                                                <c:forEach begin="1" end="${hotel.star}">
                                                                    <i class="fa-solid fa-star "></i>
                                                                </c:forEach>
                                                            </div>
                                                        </c:if>
                                                        <p class="mb-2" style="width:70%; font-size: 14px;">
                                                                ${hotel.address}
                                                        </p>
                                                    </div>
                                                    <div>
                                                        <div class="text-right">
                                                            <span class="text-title font-weight-bold">${HotelTypeDAO.getHotelTypeById(hotel.hotelTypeId)}</span>
                                                        </div>

                                                        <c:set var="countRate"
                                                               value="${FunctionUtil.countRating(RatingDAO.getAllListRatingByHotelId(hotel.hotelId))}"/>
                                                        <c:set var="ratingPoint"
                                                               value="${FunctionUtil.countRatingPoint(RatingDAO.getAllListRatingByHotelId(hotel.hotelId))}"/>

                                                        <div class="d-flex align-items-center border-top pt-1">
                                                            <div style="width: 90px;">
                                                                <p class="mb-0 text-right">${countRate} đánh giá</p>
                                                            </div>
                                                            <div class="d-flex align-items-center justify-content-center font-weight-bold"
                                                                 style="background: #003580; height: 31px; width: 31px; border-radius:5.8181818182px 5.8181818182px 5.8181818182px
                                            0; color: #ffffff; margin: 2px 0 0 9px; ">
                                                                <fmt:formatNumber
                                                                        value="${ratingPoint}"
                                                                        type="number" maxFractionDigits="1"/>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <c:set value="${RoomDAO.getRoomMinPriceByHotelId(hotel.hotelId)}"
                                                       var="room"/>

                                                <c:set value="${0}" var="countService"/>
                                                <c:forTokens items="${room.roomService}" delims="|">
                                                    <c:set value="${countService + 1}" var="countService"/>
                                                </c:forTokens>

                                                <p class="mb-0 text-success" style="font-size: 16px;">
                                                    <i class="fa-solid fa-ban-smoking mr-1"></i>
                                                    <i class="fa-solid fa-wifi mr-1"></i>
                                                        ${countService} tiện ích
                                                </p>
                                                <div class="border-left p-2"
                                                     style="width: 70%; float: left; font-size: 12px;">
                                                    <span class="font-weight-bold">${room.roomType}</span><br> ${room.bed}
                                                    <div class="text-success mt-1">
                                                        <span class="font-weight-bold">Miễn phí hủy</span><br> Bạn có
                                                        thể
                                                        hủy sau, nên hãy đặt ngay hôm nay để có giá tốt.
                                                    </div>
                                                </div>
                                                <div class="position-relative"
                                                     style="width: 30%; float: right; bottom: 30px; height: 105px;">
                                                    <div class="text-right">
                                                        <small class="text-muted">${sessionScope.subDate} đêm, 1 người
                                                            lớn</small><br>
                                                        <span class="text-danger"
                                                              style="text-decoration: line-through;">VND <fmt:formatNumber
                                                                value="${room.price * subDate}"
                                                                type="number" maxFractionDigits="0"/></span><br>
                                                        <span style="font-size: 20px; font-weight: bold;">VND <fmt:formatNumber
                                                                value="${room.price * sessionScope.subDate * ((100-room.discountPercent) / 100)}"
                                                                type="number" maxFractionDigits="0"/></span>
                                                    </div>
                                                    <div class="d-flex justify-content-end">
                                                        <a class="btn palatin-btn btn-3"
                                                           href="<%=request.getContextPath()%>/room?hotelId=${hotel.hotelId}"
                                                           role="button"
                                                           style="padding: 0 20px;">Xem chỗ trống</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>

        <style>
            .page-link {
                cursor: pointer;
            }
        </style>
        <div class="col-12 ">
            <!-- Pagination -->
            <div id="result-pagination">
                <div class="pagination-area wow fadeInUp search-result-pagination" data-wow-delay="400ms ">
                    <nav>
                        <ul class="pagination ">
                            <c:if test="${lastPage<1 || lastPage < index }">
                                <h1>Not found</h1>
                            </c:if>
                            <c:if test="${lastPage>=1}">
                                <c:forEach begin="1" end="${lastPage}" var="i">
                                    <li class="page-item ${i == index ? "active" : ""} ">
                                        <input type="hidden" name="index" value="${i}">
                                        <a class="page-link " href="#">0${i}.</a>
                                    </li>
                                </c:forEach>
                            </c:if>
                        </ul>
                    </nav>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- ##### Rooms Area End ##### -->

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

            .owl-theme .owl-nav {
                display: none;
            }
        </style>

        <div id="relate-hotel" class="carousel slide" data-ride="carousel">
            <div class="carousel-inner">
                <div class="owl-carousel owl-theme" id="random-hotel2">
                    <c:forEach items="${listTop9}" var="o" varStatus="loop">
                        <!-- Single Rooms Area -->
                        <div class="col item">
                            <a href="<%=request.getContextPath()%>/room?hotelId=${o.hotelId}">
                                <div class="single-rooms-area mb-5" data-wow-delay="200ms">
                                    <c:forTokens items="${o.hotelImage}" delims="|" var="splitImage" begin="0"
                                                 end="0">
                                        <div class="bg-thumbnail bg-img"
                                             style="background-image: url(<c:url value="/uploads/hotel/${splitImage}"/>);"></div>
                                    </c:forTokens>
                                    <div class="rooms-text text-left">
                                        <div class="line"></div>
                                        <div class="mb-1">
                                            <span class="text-white">${HotelTypeDAO.getHotelTypeById(o.hotelTypeId)}</span>
                                        </div>
                                        <h4 class="text-truncate text-white mb-1">${o.hotelName}</h4>

                                        <c:set value="${RoomDAO.getRoomMinPriceByHotelId(o.hotelId)}" var="r"/>
                                        <div class="mb-2">
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
<jsp:include page="../layout/footer.jsp"/>