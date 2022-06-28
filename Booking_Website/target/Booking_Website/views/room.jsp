<%@page buffer="8192kb" autoFlush="true" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.sql.Date" %>
<%@ page import="com.booking.entity.QtyRoomPassenger" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<jsp:include page="../layout/header.jsp"/>

<!-- ##### Breadcumb Area Start ##### -->
<section class="breadcumb-area bg-img d-flex align-items-center justify-content-center" style="background-image: url(
<c:url value="/user/assets/img/bg-img/bg-7.jpg"/> );">
    <div class="bradcumbContent">
        <h2>Chi tiết phòng</h2>
    </div>
</section>
<!-- ##### Breadcumb Area End ##### -->

<jsp:include page="../layout/book-now.jsp"/>

<!-- usebean -->
<jsp:useBean id="AccountDAO" scope="page" class="com.booking.dao.DAOImpl.AccountDAOImpl"/>
<jsp:useBean id="BookingDAO" scope="page" class="com.booking.dao.DAOImpl.BookingDAOImpl"/>
<jsp:useBean id="HotelTypeDAO" scope="page" class="com.booking.dao.DAOImpl.HotelTypeDAOImpl"/>
<jsp:useBean id="RoomDAO" scope="page" class="com.booking.dao.DAOImpl.RoomDAOImpl"/>
<jsp:useBean id="RatingDAO" scope="page" class="com.booking.dao.DAOImpl.RatingDAOImpl"/>

<style>
    .btn-grey {
        background-color: #D8D8D8;
        color: #FFF;
    }

    .rating-block {
        background-color: #FAFAFA;
        border: 1px solid #EFEFEF;
        padding: 15px 15px 20px 15px;
        border-radius: 3px;
    }

    .bold {
        font-weight: 700;
    }

    .pb-7 {
        padding-bottom: 7px;
    }

    .review-block {
        background-color: #FAFAFA;
        border: 1px solid #EFEFEF;
        padding: 15px;
        border-radius: 3px;
        margin-bottom: 15px;
    }

    .review-block-name {
        font-size: 12px;
        margin: 10px 0;
    }

    .review-block-date {
        font-size: 12px;
    }

    .review-block-rate {
        font-size: 13px;
        margin-bottom: 5px;
    }

    .review-block-title {
        font-size: 17px;
        font-weight: 700;
        margin-bottom: 5px;
    }

    .review-block-description {
        font-size: 13px;
    }

    /* carousel */

    .carousel-indicators {
        position: static;
    }

    .carousel-indicators li {
        width: 200px;
        height: 100%;
        opacity: 0.8;
        border: none;
    }

    .carousel-indicators li.active img {
        /* outline: 3px solid #5bbaff; */
        outline: 3px solid #5bbaff;
    }

    .carousel-indicators li img:hover {
        opacity: 0.5;
    }

    .carousel-control-next,
    .carousel-control-prev {
        bottom: 85px;
    }
</style>

<!-- ##### Rooms Area Start ##### -->
<section class="rooms-area pb-5">
    <div class="container bg-white shadow py-4 rounded">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="#">Trang chủ</a></li>
                <li class="breadcrumb-item"><a href="#">Tất
                    cả ${HotelTypeDAO.getHotelTypeById(hotelService.hotelId)}</a></li>
                <li class="breadcrumb-item active" aria-current="page">Ưu đãi cho ${hotelService.hotelName}</li>
            </ol>
        </nav>

        <div class="hotel-detail-header d-flex align-items-center">
            <h3 class="font-weight-bold m-0 mr-3">
                ${hotelService.hotelName}
            </h3>
            <div style="color: #febb02; ">
                <c:forEach begin="1" end="${hotelService.star}">
                    <i class="fa-solid fa-star "></i>
                </c:forEach>
            </div>
        </div>
        <p class="mb-2">
            ${hotelService.address}
        </p>

        <div class="d-flex flex-wrap gallery-img mb-5 wow fadeInUp">
            <div class="gallery-container row" id="animated-thumbnails-gallery" style="margin: 0 -0.25rem;">
                <c:forTokens items="${hotelService.hotelImage}" delims="|" var="img" varStatus="loop">
                    <c:if test="${loop.index == 0}">
                        <a class="col-6 p-1" style="width: 100%; height: 300px;"
                           href="<c:url value="/uploads/hotel/${img}"/>">
                            <img class="img-fluid rounded" style="width: 100%; height: 100%; object-fit: cover;"
                                 src="<c:url value="/uploads/hotel/${img}"/>">
                        </a>
                    </c:if>
                    <c:if test="${loop.index >= 1 && loop.index <=2}">
                        <a class="col-3 p-1" style="width: 100%; height: 300px;"
                           href="<c:url value="/uploads/hotel/${img}"/>">
                            <img class="img-fluid rounded" style="width: 100%; height: 100%; object-fit: cover;"
                                 src="<c:url value="/uploads/hotel/${img}"/>">
                        </a>
                    </c:if>
                    <c:if test="${loop.index >= 3 && loop.index <=4}">
                        <a class="col-3 p-1" style="width: 100%; height: 150px;"
                           href="<c:url value="/uploads/hotel/${img}"/>">
                            <img class="img-fluid rounded" style="width: 100%; height: 100%; object-fit: cover;"
                                 src="<c:url value="/uploads/hotel/${img}"/>">
                        </a>
                    </c:if>
                    <c:if test="${loop.index >= 5 && loop.index <=6}">
                        <a class="col-2 p-1" style="width: 100%; height: 150px;"
                           href="<c:url value="/uploads/hotel/${img}"/>">
                            <img class="img-fluid rounded" style="width: 100%; height: 100%; object-fit: cover;"
                                 src="<c:url value="/uploads/hotel/${img}"/>">
                        </a>
                    </c:if>

                    <c:if test="${loop.index == 7}">
                        <a class="d-flex position-relative col-2 p-1" style="width: 100%; height: 150px;"
                           href="<c:url value="/uploads/hotel/${img}"/>">
                            <img class="img-fluid rounded"
                                 style="height: 100%; width:100%; opacity: 0.2; background-color: rgba(0,0,0,0.40);"
                                 src="<c:url value="/uploads/hotel/${img}"/>">
                            <span class="font-weight-bold rounded d-flex justify-content-center align-items-center"
                                  style="background-color: rgba(0,0,0,0.40); width: 94%; height: 94%; position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); font-size: 1.25em; color: #ffffff;">
                            <span>+ ${loop.count - 7} ảnh</span>
                        </span>
                        </a>
                    </c:if>

                    <!-- example -->
                    <c:if test="${loop.index > 7}">
                        <a class="gallery-item invisible position-absolute"
                           data-src="<c:url value="/uploads/hotel/${img}"/>">
                            <img alt="layers of blue." class="img-responsive"
                                 src="<c:url value="/uploads/hotel/${img}"/>"/>
                        </a>
                    </c:if>
                </c:forTokens>
            </div>
        </div>

        <style>
            .icon-diamond svg {
                width: 50px;
                height: 50px;
                fill: rgb(0, 113, 194)
            }
        </style>
        <div class="col border py-3 mb-5">
            <div class="row">
                <div class="icon-diamond px-3">
                    <svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg"
                         xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 64 64"
                         enable-background="new 0 0 64 64" xml:space="preserve">
                        <path id="Diamond" d="M63.6870499,18.5730648L48.7831497,4.278266c-0.1855011-0.1758003-0.4316025-0.4813001-0.6870003-0.4813001
                        H15.9037514c-0.2553005,0-0.5014,0.3054998-0.6870003,0.4813001l-14.9038,14.1908998
                        c-0.374,0.3535004-0.4184,0.9855995-0.1025,1.3917999c0.21,0.2703991,30.8237991,39.7256012,31.0517006,39.9812012
                        c0.1022987,0.1149979,0.2402992,0.2215996,0.3428001,0.266098c0.2763996,0.1206017,0.5077,0.1296997,0.7900982,0.0065002
                        c0.1025009-0.0444984,0.2404022-0.1348991,0.3428001-0.2499008c0.0151024-0.0168991,0.0377007-0.0224991,0.0517006-0.0404968
                        L63.789547,19.9121666C64.1054459,19.5058651,64.0610504,18.9265652,63.6870499,18.5730648z M15.6273508,6.4344659
                        l4.9945002,11.3625011H3.6061509L15.6273508,6.4344659z M24.0795517,17.7969666l7.9203987-11.2617006l7.9204979,11.2617006
                        H24.0795517z M40.7191467,19.7969666l-8.7191963,34.8769989l-8.719099-34.8769989H40.7191467z M33.9257507,5.7969656h12.5423012
                        l-4.8240013,10.9746008L33.9257507,5.7969656z M22.3559513,16.7715664L17.53195,5.7969656h12.5423012L22.3559513,16.7715664z
                        M21.2191505,19.7969666l8.6596012,34.638401L2.975451,19.7969666H21.2191505z M42.7808495,19.7969666h18.2436981
                        l-26.9032974,34.638401L42.7808495,19.7969666z M43.3781471,17.7969666l4.9944992-11.3625011l12.0212021,11.3625011H43.3781471z"/>
                    </svg>
                </div>
                <div>
                    <h4 class="font-weight-bold">Thường xuyên hết phòng - bạn may mắn lắm đó!</h4>
                    <p class="mb-0">Spring Garden Homestay thường xuyên hết phòng trên trang web của chúng tôi. Đặt
                        phòng ngay trước khi phòng được bán hết!</p>
                </div>
            </div>
        </div>

        <style>
            #qty-people-room.dropdown-toggle::after {
                display: none;
            }

            #qty-people-room.dropdown-toggle:focus,
            #qty-people-room.dropdown-toggle:hover {
                background-color: #ffffff;
                color: #cb8670;
            }

            #passenger-box .dropdown-item:focus,
            #passenger-box .dropdown-item:hover,
            #passenger-box .dropdown-item:active {
                background-color: #ffffff;
                color: black;
            }

            #passenger-box .form-control:focus {
                border-color: #ced4da;
                box-shadow: none;
            }

            #passenger-box .form-control:disabled,
            #passenger-box .form-control[readonly] {
                background-color: #ffffff;
            }

            #room-modal a:hover {
                font-size: initial;
            }
        </style>

        <form action="<%=request.getContextPath()%>/room?action=updateRoomByQty" method="post">
            <div class="row wow fadeInUp mb-4">
                <div class="col-8 d-flex">
                    <div class="col-8 px-0">
                        <div class="dropdown">
                            <button class="btn palatin-btn dropdown-toggle btn-3 w-100" type="button"
                                    id="qty-people-room"
                                    data-toggle="dropdown" aria-expanded="false ">
                                <label class="float-left">
                                    <span id="room-lbl">${sessionScope.qtyRoomPassenger.qtyRoom}</span>
                                    phòng,
                                    <span id="person-lbl">${sessionScope.qtyRoomPassenger.qtyPassenger}</span>
                                    người
                                </label>
                                <label class="float-right">
                                    <i class="fa-solid fa-user-group"></i>
                                </label>
                            </button>
                            <div class="dropdown-menu w-100" aria-labelledby="qty-people-room" id="passenger-box">
                                <div class="dropdown-item d-flex align-items-center">
                                    <div class="col-5">
                                        <span>Phòng</span>
                                    </div>
                                    <div class="col-7">
                                        <input type="number" id="room-input" name="qtyRoom"
                                               value="${sessionScope.qtyRoomPassenger.qtyRoom}"
                                               min="1" max="${maxRoomQtyAvailable}">
                                    </div>
                                </div>
                                <div class="dropdown-item d-flex align-items-center">
                                    <div class="col-5">
                                        <span>Người lớn</span>
                                    </div>
                                    <div class="col-7">
                                        <input type="number" id="person-input" name="qtyPassenger"
                                               value="${sessionScope.qtyRoomPassenger.qtyPassenger}"
                                               min="1">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-4 pr-0">
                        <input type="hidden" value="${hotelService.hotelId}" name="hotelId">
                        <button type="submit" class="btn palatin-btn w-100" style="height: 49px;">Cập nhật</button>
                    </div>
                </div>
            </div>
        </form>
    </div>
</section>

<section class="rooms-area pb-5">
    <div class="container bg-white shadow py-4 rounded">
        <div class="row justify-content-center wow fadeInUp">
            <div class="col-12 col-lg-6">
                <div class="section-heading text-center">
                    <div class="line-"></div>
                    <h2>Chọn phòng cho bạn</h2>
                    <p>${hotelService.hotelName} đã chào đón khách Palatin.com từ <fmt:formatDate
                            value="${hotelService.createdDate}" pattern="dd-MMM-yyyy"/> .</p>
                    <p>Tại đây thường xuyên hết phòng trên trang web của chúng tôi. Đặt phòng ngay trước khi phòng được
                        bán hết!</p>
                </div>
            </div>
        </div>

        <div class="row">

            <!-- Single Rooms Area -->
            <c:if test="${empty roomList}">
                <div class="alert alert-danger" role="alert">
                    Tất cả các phòng trên trang của chúng tôi để đã hết. Xin lỗi quý khách vì sự bất tiện này!
                </div>
            </c:if>

            <c:if test="${not empty roomList}">
                <c:forEach items="${roomList}" var="room">
                    <!-- Single Rooms Area -->
                    <div class="col-12 col-md-6 col-lg-4">
                        <div class="single-rooms-area wow fadeInUp" data-wow-delay="100ms" style="height: 490px;">
                            <a href="#" class="room-detail-btn" data-toggle="modal" data-target="#room-modal">
                                <!-- Thumbnail -->
                                <c:forTokens items="${room.roomImage}" delims="|" begin="0" end="0" var="roomImage">
                                    <div class="bg-thumbnail bg-img" style="background-image: url(<c:url
                                            value="/uploads/room/${roomImage}"/>);"></div>
                                </c:forTokens>
                                <!-- Price -->
                                <p class="price-from" style="width: fit-content;">Từ <fmt:formatNumber
                                        value="${room.price * (100 - room.discountPercent) / 100}"
                                        type="number" maxFractionDigits="0"/>VND/đêm</p>
                                <!-- Rooms Text -->
                                <div class="rooms-text text-left" style="height: 280px;">
                                    <div class="line mb-2"></div>
                                    <h4 class="text-wrap text-truncate"
                                        style="color:burlywood;overflow: hidden; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical;">
                                            ${room.roomType}
                                    </h4>
                                    <p class="mb-2" style="color: tomato;">Phù hợp cho:
                                        <c:set value="${0}" var="countSuitableFor"/>
                                        <c:forEach begin="1" end="${room.suitableFor}">
                                            <c:set value="${countSuitableFor + 1}" var="countSuitableFor"/>
                                        </c:forEach>

                                        <c:if test="${countSuitableFor <= 2}">
                                            <i class="fa-solid fa-user"></i>
                                            <i class="fa-solid fa-user"></i>
                                        </c:if>
                                        <c:if test="${countSuitableFor > 2}">
                                            ${countSuitableFor} x <i class="fa-solid fa-user"></i>
                                        </c:if>
                                    </p>
                                    <p class="mb-2"><i class="fa-solid fa-bed mr-2"></i>${room.bed}</p>
                                    <p class="mb-2">
                                        <i class="fa-solid fa-house mr-1"></i><span class="mr-2">${room.area} m²</span>
                                        <i class="fa-solid fa-wifi mr-1"></i><span class="mr-2">Wifi miễn phí</span><br>
                                        <i class="fa-solid fa-droplet mr-1"></i><span class="mr-2">Điều hòa ...</span>
                                    </p>
                                    <c:if test="${room.quantity < 5}">
                                        <p class="text-warning"><i class="fa-solid fa-hourglass mr-2"></i>Chỉ
                                            còn ${room.quantity}
                                            phòng</p>
                                    </c:if>
                                </div>
                            </a>
                            <!-- Book Room -->
                            <input type="hidden" value="${room.roomId}" name="roomId">
                            <a class="book-room-btn btn palatin-btn">Chọn phòng</a>
                        </div>
                    </div>
                </c:forEach>
            </c:if>

            <script>
                $(document).on('click', '.book-room-btn', function () {
                    var roomId = $(this).parent().find('input[name="roomId"]').val();

                    $.ajax({
                        url: "booking-cart",
                        type: "get",
                        dataType: 'json',
                        data: {
                            action: 'addItem',
                            roomId: roomId
                        },
                        success: function (result) {
                            if (result[0] == "2") {
                                location.replace("login")
                            }
                            if (result[0] == "0") {
                                swal("không đủ phòng trống!", "", "error");
                            }
                            if (result[0] == "1") {
                                swal("Đã thêm phòng!", "", "success");
                                $('.count-cart').html(result[1]);
                            }
                        }
                    });
                });
            </script>

            <div class="col-12">
                <!-- Pagination -->
                <div class="pagination-area wow fadeInUp" data-wow-delay="400ms">
                    <nav>
                        <ul class="pagination">
                            <li class="page-item active"><a class="page-link" href="#">01.</a></li>
                        </ul>
                    </nav>
                </div>
            </div>

            <style>
                #carouselExampleCaptions .carousel-item img {
                    object-fit: cover;
                    width: 100%;
                    height: 425px;
                }

                #carouselExampleCaptions .carousel-indicators img {
                    object-fit: cover;
                    width: 100%;
                    height: 90px;
                }

                .modal-content .modal-header {
                    padding: 10px;
                    border-bottom: 0;
                }
            </style>
            <!-- modal roomdetail -->
            <div class="modal fade" id="room-modal" tabindex="-1" aria-labelledby="exampleModalLabel"
                 aria-hidden="true">
                <div class="modal-dialog modal-xl modal-dialog-scrollable">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close position-absolute" data-dismiss="modal"
                                    aria-label="Close" style="right: 25px;">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body row">
                            <div class="col-7">
                                <div id="carouselExampleCaptions" class="carousel slide" data-ride="carousel">
                                    <div class="carousel-inner mb-2">

                                    </div>
                                    <ol class="carousel-indicators row mx-0">

                                    </ol>
                                    <button class="carousel-control-prev" type="button"
                                            data-target="#carouselExampleCaptions" data-slide="prev">
                                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                        <span class="sr-only">Previous</span>
                                    </button>
                                    <button class="carousel-control-next" type="button"
                                            data-target="#carouselExampleCaptions" data-slide="next">
                                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                        <span class="sr-only">Next</span>
                                    </button>
                                </div>
                            </div>
                            <div class="col-5" id="content">

                            </div>
                        </div>
                        <div class="modal-footer justify-content-between align-items-end">
                            <div>
                                <div class="d-flex flex-column">
                                    <c:if test="${sessionScope.subDateFromNow > 4}">
                                        <span class="text-success">Miễn phí hủy đến 
                                            <fmt:formatDate value="${sessionScope.minusDateFrom}"
                                                            pattern="dd-MMM-yyyy"/>
                                        </span>
                                    </c:if>
                                    <strong class="text-success">Chỉ mất có 2 phút – Xác nhận tức thời</strong>
                                </div>
                            </div>
                            <input type="hidden" value="${sessionScope.subDate}" name="subDate">
                            <div class="d-flex flex-column" id="last-price-right">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- modal roomdetail -->
        </div>
    </div>
</section>
<!-- ##### Rooms Area End ##### -->

<section class="rooms-area pb-5">
    <div class="container bg-white shadow py-4 rounded wow fadeInUp">
        <h3 class="font-weight-bold mb-4">
            Thông tin về ${hotelService.hotelName}
        </h3>

        <div class="d-flex mb-4">
            <div class="col-3 p-0">
                <span style="font-size: 26px;">Mô tả khách sạn</span>
            </div>
            <div class="col-9 pt-2">
                <c:forTokens items="${hotelService.description}" delims="|" var="des">
                    <p class="text-dark mb-2">${des}</p>
                </c:forTokens>
            </div>
        </div>

        <style>
            .service-right {
                column-count: 3;
            }

            .service-right .service-detail {
                display: inline-block;
                margin-bottom: 1.2rem !important;
            }

            .service-right .service-detail p {
                font-size: 20px;
                font-weight: 600;
                margin-bottom: 0.5rem !important;
            }

            .service-right .service-detail ul li {
                margin-bottom: 0.75rem;
            }
        </style>

        <div class="d-flex mb-4">
            <div class="col-3 p-0">
                <span style="font-size: 26px;">Xung quanh đây</span>
            </div>
            <div class="service-right col-9 pt-2">
                <c:forTokens items="${hotelService.specialAround}" delims="|" var="around">
                    <div>
                        <p>${around}</p>
                    </div>
                </c:forTokens>
            </div>
        </div>

        <div class="d-flex mb-4">
            <div class="col-3 p-0">
                <span style="font-size: 26px;">Dịch vụ của khách sạn</span>
            </div>
            <div class="service-right col-9 pt-2">
                <div class="service-detail p-0">
                    <p class="text-dark"><i
                            class="fa-solid fa-bath mr-3"></i>Phòng tắm</p>
                    <ul>
                        <c:forTokens items="${hotelService.bathroom}" delims="|" var="bathroom">
                            <li><i class="fa-solid fa-check mr-4 text-success"></i>${bathroom}</li>
                        </c:forTokens>
                    </ul>
                </div>
                <div class="service-detail p-0">
                    <p class="text-dark"><i
                            class="fa-solid fa-bed mr-3"></i>Phòng ngủ</p>
                    <ul>
                        <c:forTokens items="${hotelService.bedroom}" delims="|" var="bedroom">
                            <li><i class="fa-solid fa-check mr-4 text-success"></i>${bedroom}</li>
                        </c:forTokens>
                    </ul>
                </div>
                <div class="service-detail p-0">
                    <p class="text-dark "><i
                            class="fa-solid fa-utensils mr-3"></i>Đồ ăn & thức uống</p>
                    <ul>
                        <c:forTokens items="${hotelService.drinkAndFood}" delims="|" var="drinkAndFood">
                            <li><i class="fa-solid fa-check mr-4 text-success"></i>${drinkAndFood}</li>
                        </c:forTokens>
                    </ul>
                </div>
                <div class="service-detail p-0">
                    <p class="text-dark "><i
                            class="fa-solid fa-wifi mr-3"></i>Internet</p>
                    <ul>
                        <c:forTokens items="${hotelService.internet}" delims="|" var="internet">
                            <li><i class="fa-solid fa-check mr-4 text-success"></i>${internet}</li>
                        </c:forTokens>
                    </ul>
                </div>
                <div class="service-detail p-0">
                    <p class="text-dark "><i
                            class="fa-solid fa-soap mr-3"></i>Dịch vụ lau dọn</p>
                    <ul>
                        <c:forTokens items="${hotelService.cleaningService}" delims="|" var="cleaningService">
                            <li><i class="fa-solid fa-check mr-4 text-success"></i>${cleaningService}</li>
                        </c:forTokens>
                    </ul>
                </div>

                <c:if test="${not empty hotelService.pool}">
                    <div class="service-detail p-0">
                        <p class="text-dark "><i
                                class="fa-solid fa-person-swimming mr-3"></i>Bể bơi</p>
                        <ul>
                            <c:forTokens items="${hotelService.pool}" delims="|" var="pool">
                                <li><i class="fa-solid fa-check mr-4 text-success"></i>${pool}</li>
                            </c:forTokens>
                        </ul>
                    </div>
                </c:if>

                <div class="service-detail p-0">
                    <p class="text-dark "><i
                            class="fa-solid fa-language mr-3"></i>Ngôn ngữ được sử dụng</p>
                    <ul>
                        <c:forTokens items="${hotelService.language}" delims="|" var="language">
                            <li><i class="fa-solid fa-check mr-4 text-success"></i>${language}</li>
                        </c:forTokens>
                    </ul>
                </div>

                <c:if test="${not empty hotelService.dinningroom}">
                    <div class="service-detail p-0">
                        <p class="text-dark "><i
                                class="fa-solid fa-bath mr-3"></i>Nhà bếp</p>
                        <ul>
                            <c:forTokens items="${hotelService.dinningroom}" delims="|" var="dinningroom">
                                <li><i class="fa-solid fa-check mr-4 text-success"></i>${dinningroom}</li>
                            </c:forTokens>
                        </ul>
                    </div>
                </c:if>
                <div class="service-detail p-0">
                    <p class="text-dark "><i
                            class="fa-solid fa-bell-concierge mr-3"></i>Dịch vụ lễ tân</p>
                    <ul>
                        <c:forTokens items="${hotelService.receptionService}" delims="|" var="receptionService">
                            <li><i class="fa-solid fa-check mr-4 text-success"></i>${receptionService}</li>
                        </c:forTokens>
                    </ul>
                </div>

                <div class="service-detail p-0">
                    <p class="text-dark "><i
                            class="fa-solid fa-circle-info mr-3"></i>Tổng quát</p>
                    <ul>
                        <c:forTokens items="${hotelService.other}" delims="|" var="other">
                            <li><i class="fa-solid fa-check mr-4 text-success"></i>${other}</li>
                        </c:forTokens>
                    </ul>
                </div>
            </div>
        </div>
        <div class="d-flex mb-4">
            <div class="col-3 p-0">
                <span style="font-size: 26px;">Quy tắc chung</span>
            </div>
            <div class="col-9 pt-2">
                <div class="row align-items-center position-relative p-0 mb-4">
                    <div class="col-3 d-flex align-items-center">
                        <i class="fa-solid fa-calendar-days mr-3" style="font-size: 16px;"></i>
                        <p class="text-dark mb-0" style="font-size: 16px; font-weight: 500; line-height: normal;">
                            Checkin</p>
                    </div>
                    <div class="col-9">
                        <div class="progress w-50">
                            <div class="progress-bar bg-success ml-auto" role="progressbar"
                                 style="width: ${(24 - checkin) / 24 * 100}%"></div>
                            <label style="position: absolute; left: 29.7%; top: -8px; transform: translate(-50%, -50%);">14:00</label>
                        </div>
                    </div>
                </div>
                <div class="row align-items-center position-relative p-0 mb-4">
                    <div class="col-3 d-flex align-items-center">
                        <i class="fa-solid fa-calendar-days mr-3" style="font-size: 16px;"></i>
                        <p class="text-dark mb-0" style="font-size: 16px; font-weight: 500; line-height: normal;">
                            Checkout</p>
                    </div>
                    <div class="col-9">
                        <div class="progress w-50">
                            <div class="progress-bar bg-success" role="progressbar"
                                 style="width: ${checkout / 24 * 100}%"></div>
                            <label style="position: absolute; left: 25%; top: -8px; transform: translate(-50%, -50%);">12:00</label>
                        </div>
                    </div>
                </div>
                <div class="row align-items-center position-relative p-0 mb-4">
                    <div class="col-3 d-flex align-items-center">
                        <i class="fa-solid fa-scale-balanced mr-3" style="font-size: 16px; margin-left: -2px;"></i>
                        <p class="text-dark mb-0" style="font-size: 16px; font-weight: 500; line-height: normal;">Hủy
                            đặt phòng/<br>Trả trước</p>
                    </div>
                    <div class="col-9">
                        <p class="mb-0" style="line-height: normal;">Các chính sách hủy và thanh toán trước có khác biệt
                            dựa trên loại chỗ nghỉ. Vui lòng kiểm tra các <a href="#" class="text-primary">điều kiện</a>
                            có thể được áp dụng cho mỗi lựa chọn của bạn.</p>
                    </div>
                </div>
                <div class="row align-items-center position-relative p-0 mb-4">
                    <div class="col-3 d-flex align-items-center">
                        <i class="fa-solid fa-dog mr-3" style="font-size: 16px;"></i>
                        <p class="text-dark mb-0" style="font-size: 16px; font-weight: 500; line-height: normal;">Vật
                            nuôi</p>
                    </div>
                    <div class="col-9">
                        <p class="mb-0 text-dark" style="line-height: normal;">Vật nuôi không được phép.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Rating -->
<section class="section-rating mb-5">
    <div class="container bg-white shadow py-4 rounded wow fadeInUp">
        <h3 class="font-weight-bold mb-4">
            Đánh giá ${hotel.hotelName} từ khách hàng
        </h3>

        <div class="container">
            <c:set var="listRateByHotelId"
                   value="${RatingDAO.getAllListRatingByHotelId(hotelService.hotelId)}"/>

            <c:if test="${empty listRateByHotelId}">
                <h2 class="text-center">Không có đánh giá</h2>
            </c:if>
            <c:if test="${not empty listRateByHotelId}">
                <div class="row justify-content-center">


                    <c:set var="countRate" value="${0}"/>
                    <c:set var="countStar" value="${0}"/>
                    <c:set var="star5" value="${0}"/>
                    <c:set var="star4" value="${0}"/>
                    <c:set var="star3" value="${0}"/>
                    <c:set var="star2" value="${0}"/>
                    <c:set var="star1" value="${0}"/>
                    <c:forEach items="${listRateByHotelId}" var="rate" varStatus="loop">
                        <c:if test="${rate.starRating == 5}"><c:set var="star5" value="${star5 + 1}"/></c:if>
                        <c:if test="${rate.starRating == 4}"><c:set var="star4" value="${star4 + 1}"/></c:if>
                        <c:if test="${rate.starRating == 3}"><c:set var="star3" value="${star3 + 1}"/></c:if>
                        <c:if test="${rate.starRating == 2}"><c:set var="star2" value="${star2 + 1}"/></c:if>
                        <c:if test="${rate.starRating == 1}"><c:set var="star1" value="${star1 + 1}"/></c:if>

                        <c:set var="countRate" value="${loop.count}"/>
                        <c:set var="countStar" value="${countStar + rate.starRating}"/>
                    </c:forEach>


                    <div class="col-sm-3">
                        <div class="rating-block">
                            <h4>Điểm đánh giá</h4>
                            <h2 class="bold pb-7"><fmt:formatNumber value="${(countStar / countRate) * 2}" type="number"
                                                                    maxFractionDigits="1"/> <small>/ 10</small></h2>

                            <fmt:formatNumber value="${countStar / countRate}" maxFractionDigits="0" var="countS"/>
                            <c:forEach begin="1" end="${countS}">
                                <button type="button" class="btn btn-warning btn-sm" aria-label="Left Align">
                                    <span class="fa-solid fa-star" aria-hidden="true"></span>
                                </button>
                            </c:forEach>
                            <c:forEach begin="${countS + 1}" end="5">
                                <button type="button" class="btn btn-default btn-grey btn-sm" aria-label="Left Align">
                                    <span class="fa-solid fa-star" aria-hidden="true"></span>
                                </button>
                            </c:forEach>
                        </div>
                    </div>

                    <style>
                        .progress-bar {
                            background: #cb8670;
                        }
                    </style>

                    <div class="col-sm-3" style="margin: auto 0">
                        <div class="d-flex align-items-center">
                            <div class="float-left" style="width:70px; line-height:1;">
                                Rất tốt
                            </div>
                            <div class="float-left" style="width:180px;">
                                <div class="progress" style="height:9px; margin:8px 0;">
                                    <div class="progress-bar" role="progressbar" aria-valuenow="5"
                                         aria-valuemin="0" aria-valuemax="5" style="width: 100%">
                                        <span class="sr-only">80% Complete (danger)</span>
                                    </div>
                                </div>
                            </div>
                            <div class="float-right" style="margin-left:10px;">${star5}</div>
                        </div>
                        <div class="d-flex align-items-center">
                            <div class="float-left" style="width:70px; line-height:1;">
                                Tốt
                            </div>
                            <div class="float-left" style="width:180px;">
                                <div class="progress" style="height:9px; margin:8px 0;">
                                    <div class="progress-bar" role="progressbar" aria-valuenow="5"
                                         aria-valuemin="0" aria-valuemax="5" style="width: 80%">
                                        <span class="sr-only">80% Complete (danger)</span>
                                    </div>
                                </div>
                            </div>
                            <div class="float-right" style="margin-left:10px;">${star4}</div>
                        </div>
                        <div class="d-flex align-items-center">
                            <div class="float-left" style="width:70px; line-height:1;">
                                Hài Lòng
                            </div>
                            <div class="float-left" style="width:180px;">
                                <div class="progress" style="height:9px; margin:8px 0;">
                                    <div class="progress-bar" role="progressbar" aria-valuenow="5" aria-valuemin="0"
                                         aria-valuemax="5" style="width: 60%">
                                        <span class="sr-only">80% Complete (danger)</span>
                                    </div>
                                </div>
                            </div>
                            <div class="float-right" style="margin-left:10px;">${star3}</div>
                        </div>
                        <div class="d-flex align-items-center">
                            <div class="float-left" style="width:70px; line-height:1;">
                                Kém
                            </div>
                            <div class="float-left" style="width:180px;">
                                <div class="progress" style="height:9px; margin:8px 0;">
                                    <div class="progress-bar" role="progressbar" aria-valuenow="5"
                                         aria-valuemin="0" aria-valuemax="5" style="width: 40%">
                                        <span class="sr-only">80% Complete (danger)</span>
                                    </div>
                                </div>
                            </div>
                            <div class="float-right" style="margin-left:10px;">${star2}</div>
                        </div>
                        <div class="d-flex align-items-center">
                            <div class="float-left" style="width:70px; line-height:1;">
                                Rất kém
                            </div>
                            <div class="float-left" style="width:180px;">
                                <div class="progress" style="height:9px; margin:8px 0;">
                                    <div class="progress-bar" role="progressbar" aria-valuenow="5"
                                         aria-valuemin="0" aria-valuemax="5" style="width: 20%">
                                        <span class="sr-only">80% Complete (danger)</span>
                                    </div>
                                </div>
                            </div>
                            <div class="float-right" style="margin-left:10px;">${star1}</div>
                        </div>
                    </div>
                </div>

                <hr/>
                <div class="review-block">
                    <div class="render-rating mb-3">
                        <c:forEach items="${ratingList}" var="rating">
                            <c:set value="${AccountDAO.getAccountById(BookingDAO.getBookingById(rating.bookingId).accountId)}"
                                   var="acc"/>
                            <div class="row mb-4">
                                <div class="d-flex align-items-center col-sm-3">
                                    <img style="border-radius: 10px;"
                                         width="85"
                                         src="<c:url value="/uploads/accounts/${acc.image}"/>"
                                         class="img-rounded">
                                    <div class="ml-3">
                                        <div class="review-block-name"><a style="font-size: 16px;">${acc.fullName}</a>
                                        </div>
                                        <div class="review-block-date">${rating.createdDateFormat}</div>
                                    </div>
                                </div>
                                <div class="col-sm-9">
                                    <div class="review-block-rate">
                                        <c:forEach begin="1" end="${rating.starRating}">
                                            <i class="bi bi-star-fill" style="color: #febb02; font-size: 22px;"></i>
                                        </c:forEach>
                                        <c:forEach begin="${rating.starRating + 1}" end="5">
                                            <i class="bi bi-star" style="color: #febb02; font-size: 22px;"></i>
                                        </c:forEach>
                                    </div>
                                    <div class="review-block-title">${rating.title}</div>
                                    <div class="review-block-description">
                                            ${rating.description}
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>

                    <div class="col-12 ">
                        <!-- Pagination -->
                        <div id="result-pagination">
                            <div class="pagination-area wow fadeInUp rating-pagination" data-wow-delay="400ms ">
                                <nav>
                                    <ul class="pagination">
                                        <c:if test="${lastPage<1 || lastPage < index }">
                                            <h1>Not found</h1>
                                        </c:if>
                                        <c:if test="${lastPage>=1}">
                                            <c:forEach begin="1" end="${lastPage}" var="i">
                                                <li class="page-item ${i == index ? "active" : ""} ">
                                                    <input type="hidden" name="index" value="${i}">
                                                    <input type="hidden" name="hotelId" value="${hotelService.hotelId}">
                                                    <a class="page-link " href="#">0${i}.</a>
                                                </li>
                                            </c:forEach>
                                        </c:if>
                                    </ul>
                                </nav>
                            </div>
                        </div>
                    </div>


                    <script>
                        $(".rating-pagination .page-link").on('click', function () {
                            var index = $(this).parent().find('input[name="index"]').val();
                            var hotelId = $(this).parent().find('input[name="hotelId"]').val();

                            $.ajax({
                                url: "room",
                                type: "get",
                                dataType: 'json',
                                data: {
                                    index: index,
                                    hotelId: hotelId,
                                    action: 'paginateRating'
                                },
                                success: function (result) {
                                    $('.render-rating').html(result);
                                }, error: function (e) {
                                    console.log(e);
                                }
                            });
                        });

                    </script>


                </div>
            </c:if>
        </div>
        <!-- /container -->
    </div>
</section>
<!-- Rating -->

<jsp:include page="../layout/footer.jsp"/>

<c:if test="${not empty alert}">${alert}</c:if>