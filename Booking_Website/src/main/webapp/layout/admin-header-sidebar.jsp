<%@ page import="java.util.List" %>
<%@ page import="com.booking.entity.Booking" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.booking.dao.IDAO.BookingDAO" %>
<%@ page import="com.booking.dao.DAOImpl.BookingDAOImpl" %>
<%@ page import="java.util.concurrent.TimeUnit" %>
<%@ page import="java.util.Date" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <title>Manage Page</title>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimal-ui">
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="description" content=""/>
    <meta name="keywords" content="">
    <meta name="author" content="Phoenixcoded"/>
    <!-- Favicon icon -->
    <link rel="icon" href="<c:url value="/admin/assets/images/favicon.ico"/> " type="image/x-icon">

    <!-- vendor css -->
    <link rel="stylesheet" href="<c:url value="/admin/assets/css/style.css"/>">

    <%--jQuery--%>
    <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
</head>

<body class="">
<!-- [ Pre-loader ] start -->
<div class="loader-bg">
    <div class="loader-track">
        <div class="loader-fill"></div>
    </div>
</div>
<!-- [ Pre-loader ] End -->
<!-- [ navigation menu ] start -->

    <%
        BookingDAO bookingDAO = new BookingDAOImpl();
        List<Booking> bookings30DaysFromNow = new ArrayList<>();
           for (Booking booking : bookingDAO.getAllBooking()) {
               if(TimeUnit.MILLISECONDS.toDays(new Date().getTime() - booking.getBookingDate().getTime()) <= 7) {
                   bookings30DaysFromNow.add(booking);
               }
           }
       request.setAttribute("bookings30DaysFromNow", bookings30DaysFromNow);
    %>

<jsp:useBean id="AccountDAO" scope="page" class="com.booking.dao.DAOImpl.AccountDAOImpl"/>
<jsp:useBean id="HotelDAO" scope="page" class="com.booking.dao.DAOImpl.HotelDAOImpl"/>
<jsp:useBean id="BookingDAO" scope="page" class="com.booking.dao.DAOImpl.BookingDAOImpl"/>
<jsp:useBean id="BookingDetailDAO" scope="page" class="com.booking.dao.DAOImpl.BookingDetailDAOIml"/>
<jsp:useBean id="RoomDAO" scope="page" class="com.booking.dao.DAOImpl.RoomDAOImpl"/>
<jsp:useBean id="FunctionUtil" scope="page" class="com.booking.util.FunctionUtil"/>

<nav class="pcoded-navbar  ">
    <div class="navbar-wrapper  ">
        <div class="navbar-content scroll-div ">
            <ul class="nav pcoded-inner-navbar ">
                <li class="nav-item pcoded-menu-caption">
                    <label>Trang chủ</label>
                </li>
                <li class="nav-item">
                    <a href="<%=request.getContextPath()%>/admin-index" class="nav-link "><span class="pcoded-micon"><i
                            class="feather icon-home"></i></span><span class="pcoded-mtext">Dashboard</span></a>
                </li>
                <li class="nav-item pcoded-menu-caption">
                    <label>Quản lý Website</label>
                </li>
                <li class="nav-item pcoded-hasmenu">
                    <a href="#!" class="nav-link "><span class="pcoded-micon"><i
                            class="feather icon-box"></i></span><span class="pcoded-mtext">Quản lý</span></a>
                    <ul class="pcoded-submenu">
                        <li><a href="<%=request.getContextPath()%>/admin-manage-booking">Đặt phòng</a></li>
                        <li><a href="<%=request.getContextPath()%>/admin-manage-account">Người dùng</a></li>
                        <li><a href="<%=request.getContextPath()%>/admin-manage-hotel">Khách sạn</a></li>
                        <li><a href="<%=request.getContextPath()%>/admin-manage-room">Phòng</a></li>
                        <li><a href="<%=request.getContextPath()%>/admin-manage-contact">Phản hồi</a></li>
                    </ul>
                </li>
                <li class="nav-item pcoded-hasmenu">
                    <a href="#!" class="nav-link "><span class="pcoded-micon"><i
                            class="fa-solid fa-gear"></i></span><span class="pcoded-mtext">Cài đặt</span></a>
                    <ul class="pcoded-submenu">
                        <li><a href="<%=request.getContextPath()%>/admin-manage-city">Thành phố</a></li>
                        <li><a href="<%=request.getContextPath()%>/admin-manage-hotel-type">Loại khách sạn</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>
<!-- [ navigation menu ] end -->
<!-- [ Header ] start -->
<header class="navbar pcoded-header navbar-expand-lg navbar-light header-dark">


    <div class="m-header">
        <a class="mobile-menu" id="mobile-collapse" href="#!"><span></span></a>
        <a href="#!" class="b-brand">
            <!-- ========   change your logo hear   ============ -->
            <img src="<c:url value="/user/assets/img/core-img/logo.png"/>" alt="" class="logo" style="width: 85%;">
            <img src="<c:url value="/admin/assets/images/logo-icon.png"/>" alt="" class="logo-thumb">
        </a>
        <a href="#!" class="mob-toggler">
            <i class="feather icon-more-vertical"></i>
        </a>
    </div>
    <div class="collapse navbar-collapse">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item">
                <a href="#!" class="pop-search"><i class="feather icon-search"></i></a>
                <div class="search-bar">
                    <input type="text" class="form-control border-0 shadow-none" placeholder="Search hear">
                    <button type="button" class="close" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
            </li>
        </ul>
        <ul class="navbar-nav ml-auto">
            <li>
                <div class="dropdown">
                    <a class="dropdown-toggle" href="#" data-toggle="dropdown">
                        <i class="icon feather icon-bell"></i>
                        <span class="badge badge-pill badge-danger">${bookings30DaysFromNow.size()}</span>
                    </a>
                    <div class="dropdown-menu dropdown-menu-right notification">
                        <div class="noti-head">
                            <h6 class="d-inline-block m-b-0">Thông báo</h6>
                        </div>
                        <ul class="noti-body">
                            <li class="n-title">
                                <p class="m-b-0">Mới</p>
                            </li>
                            <c:forEach items="${bookings30DaysFromNow}" var="o">
                                <c:set value="${AccountDAO.getAccountById(o.accountId)}" var="account"/>
                                <li class="notification">
                                    <a href="<%=request.getContextPath()%>/admin-manage-booking">
                                        <div class="media">
                                            <img class="img-radius"
                                                 src="<c:url value="/uploads/accounts/${account.image}"/>"
                                                 alt="Generic placeholder image">
                                            <div class="media-body">
                                                <p><strong>${account.fullName}</strong><span
                                                        class="n-time text-muted"><i
                                                        class="icon feather icon-clock m-r-10"></i>${o.bookingDateFormat}</span>
                                                </p>
                                                <p>Đặt phòng mới</p>
                                            </div>
                                        </div>
                                    </a>
                                </li>
                            </c:forEach>
                        </ul>
                        <div class="noti-footer">
                            <a href="<%=request.getContextPath()%>/admin-manage-booking">Xem tất cả</a>
                        </div>
                    </div>
                </div>
            </li>

            <style>
                .notification:hover {
                    color: black;
                }
                .media:hover {
                    color: black;
                }
            </style>

            <li>
                <div class="dropdown drp-user">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                        <i class="feather icon-user"></i>
                    </a>
                    <div class="dropdown-menu dropdown-menu-right profile-notification">
                        <div class="pro-head">
                            <img src="<c:url value="/uploads/accounts/${sessionScope.account.image}"/>"
                                 class="img-radius"
                                 alt="User-Profile-Image">
                            <span>${sessionScope.account.fullName}</span>
                        </div>
                        <ul class="pro-body" style="padding: 5px 0;">
                            <li><a href="<%=request.getContextPath()%>/my-account?action=loadInfor"
                                   class="dropdown-item"><i class="feather icon-user"></i>Thông tin cá nhân</a></li>
                            <div class="dropdown-divider"></div>
                            <li><a href="<%=request.getContextPath()%>/login?action=logout" class="dropdown-item"><i
                                    class="feather icon-log-out"></i>Đăng xuất</a></li>
                        </ul>
                    </div>
                </div>
            </li>
        </ul>
    </div>

</header>
<!-- [ Header ] end -->