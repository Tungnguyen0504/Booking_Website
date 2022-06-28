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
    <!-- jQuery-2.2.4 js -->
    <script src="<c:url value="/user/assets/js/jquery/jquery-2.2.4.min.js"/>"></script>

</head>

<body>

<!-- Preloader -->
<div class="preloader d-flex align-items-center justify-content-center">
    <div class="cssload-container">
        <div class="cssload-loading"><i></i><i></i><i></i><i></i></div>
    </div>
</div>

<!-- ##### Header Area Start ##### -->
<header class="header-area">
    <!-- Navbar Area -->
    <div class="palatin-main-menu">
        <div class="classy-nav-container breakpoint-off">
            <div class="container">
                <!-- Menu -->
                <nav class="classy-navbar justify-content-between" id="palatinNav">

                    <!-- Nav brand -->
                    <a href="index.html" class="nav-brand"><img
                            src="<c:url value="/user/assets/img/core-img/logo.png"/>"
                            alt=""></a>

                    <!-- Navbar Toggler -->
                    <div class="classy-navbar-toggler">
                        <span class="navbarToggler"><span></span><span></span><span></span></span>
                    </div>

                    <!-- Menu -->
                    <div class="classy-menu">

                        <!-- close btn -->
                        <div class="classycloseIcon">
                            <div class="cross-wrap"><span class="top"></span><span class="bottom"></span></div>
                        </div>

                        <!-- Nav Start -->
                        <div class="classynav">
                            <ul>
                                <li class="active"><a href="<%=request.getContextPath()%>/home">Trang chủ</a></li>
                                <li><a href="<%=request.getContextPath()%>/search-hotel">Lưu trú</a></li>
                                <li><a href="<%=request.getContextPath()%>/views/about-us.jsp">Về chúng tôi</a></li>
                                <li><a href="<%=request.getContextPath()%>/views/services.jsp">Dịch vụ</a></li>
                                <li><a href="<%=request.getContextPath()%>/contact">Liên hệ</a></li>
                            </ul>

                            <!-- Button -->
                            <c:if test="${sessionScope.account == null}">
                                <div class="menu-btn">
                                    <a href="<%=request.getContextPath()%>/register"
                                       class="btn palatin-btn btn-3 bg-transparent text-white">Đăng ký</a>
                                    <a href="<%=request.getContextPath()%>/login"
                                       class="btn palatin-btn btn-3 bg-transparent text-white">Đăng nhập</a>
                                </div>
                            </c:if>
                            <c:if test="${sessionScope.account != null}">
                                <style>
                                    .menu-btn .dropdown-toggle::after {
                                        margin-left: 1em;
                                    }

                                    #ddl-account:hover {
                                        background-color: rgba(192, 192, 192, 0.3) !important;
                                    }
                                </style>
                                <div class="menu-btn">
                                    <div class="dropdown">
                                        <a class="btn btn-secondary dropdown-toggle bg-transparent d-flex align-items-center border-0"
                                           href="#" role="button" id="ddl-account" data-toggle="dropdown"
                                           aria-expanded="false">
                                            <img class="rounded-circle" width="45" height="45"
                                                 src="<c:url value="/uploads/accounts/${sessionScope.account.image}"/>">
                                            <div class="ml-3">
                                                <span class="text-truncate">${sessionScope.account.fullName}</span><br>
                                                <small class="float-left text-warning font-weight-light">Xem chi
                                                    tiết</small>
                                            </div>
                                        </a>
                                        <div class="dropdown-menu dropdown-menu-right" aria-labelledby="ddl-account">
                                            <a class="dropdown-item text-dark"
                                               href="<%=request.getContextPath()%>/my-account?action=loadInfor">Thông
                                                tin cá nhân</a>
                                            <div class="dropdown-divider"></div>
                                            <a class="dropdown-item text-dark" href="login?action=logout">Logout</a>
                                        </div>
                                    </div>
                                </div>
                                <div class="ml-3">
                                    <a type="button"
                                       class="cart js-menu-toggle menu-toggle text-white position-relative">
                                        <i class="fa-solid fa-cart-shopping" style="font-size: 24px;"></i>
                                        <span class="count-cart">${sessionScope.items eq null ? "0" : sessionScope.items.size()}</span>
                                    </a>
                                </div>

                                <script>
                                    $('.cart').on('click', function () {
                                        $.ajax({
                                            url: "booking-cart",
                                            type: "get",
                                            dataType: 'json',
                                            data: {
                                                action: 'openCart'
                                            },
                                            success: function (result) {
                                                $('#list-cart').html(result);
                                                $('#list-cart input[type="number"]').inputSpinner({
                                                    buttonsOnly: true,
                                                    autoInterval: undefined
                                                });
                                            }
                                        });
                                    });

                                    // failed
                                    $(document).on('click', ".btn-remove-cart", function () {
                                        var roomId = $(this).closest('.list-cart').find('input[name="roomId"]').val();

                                        $.ajax({
                                            url: "booking-cart",
                                            type: "get",
                                            dataType: 'json',
                                            data: {
                                                action: 'removeCart',
                                                roomId: roomId
                                            },
                                            success: function (result) {
                                                if (result == '0') {
                                                    swal("Failed!", "", "error");
                                                } else {
                                                    $('#list-cart').html(result);
                                                    $('#list-cart input[type="number"]').inputSpinner({
                                                        buttonsOnly: true,
                                                        autoInterval: undefined
                                                    });
                                                    const a = $('.count-cart').text();
                                                    $('.count-cart').html(a - 1);
                                                }
                                            }
                                        });
                                    });

                                    $(document).on('change', '.qty-room-cart', function (e) {
                                        var roomId = $(this).closest('.list-cart').find('input[name="roomId"]').val();
                                        console.log(roomId)
                                        var qtyRoom = $(e.target).val();

                                        $.ajax({
                                            url: "booking-cart",
                                            type: "get",
                                            dataType: 'json',
                                            data: {
                                                action: 'changeQtyOfRoom',
                                                roomId: roomId,
                                                qtyRoom: qtyRoom
                                            },
                                            success: function (result) {
                                                if (result == '0') {
                                                    swal("Failed!", "", "error");
                                                } else {
                                                    $('#list-cart').html(result);
                                                    $('#list-cart input[type="number"]').inputSpinner({
                                                        buttonsOnly: true,
                                                        autoInterval: undefined
                                                    });
                                                }
                                            }
                                        });
                                    });
                                </script>

                            </c:if>
                        </div>
                        <!-- Nav End -->
                    </div>
                </nav>
            </div>
        </div>
    </div>
</header>

<style>
    /* side-bar */
    body:before {
        position: absolute;
        content: "";
        z-index: 2000;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background-color: rgba(0, 0, 0, 0.5);
        opacity: 0;
        visibility: hidden;
        -webkit-transition: .3s all ease-in-out;
        -o-transition: .3s all ease-in-out;
        transition: .3s all ease-in-out;
    }

    body.show-sidebar {
        overflow: hidden;
    }

    body.show-sidebar:before {
        opacity: 1;
        visibility: visible;
    }

    .site-section {
        padding: 7rem 0;
    }

    aside,
    main {
        height: 100vh;
        min-height: 580px;
    }

    aside {
        width: 40%;
        right: 0;
        top: 0;
        z-index: 9999;
        position: fixed;
        -webkit-transform: translateX(100%);
        -ms-transform: translateX(100%);
        transform: translateX(100%);
        background-color: #fff;
        -webkit-transition: 1s -webkit-transform cubic-bezier(0.23, 1, 0.32, 1);
        transition: 1s -webkit-transform cubic-bezier(0.23, 1, 0.32, 1);
        -o-transition: 1s transform cubic-bezier(0.23, 1, 0.32, 1);
        transition: 1s transform cubic-bezier(0.23, 1, 0.32, 1);
        transition: 1s transform cubic-bezier(0.23, 1, 0.32, 1), 1s -webkit-transform cubic-bezier(0.23, 1, 0.32, 1);
    }

    .show-sidebar aside {
        -webkit-transform: translateX(0%);
        -ms-transform: translateX(0%);
        transform: translateX(0%);
    }

    aside .toggle {
        padding-right: 30px;
        padding-top: 30px;
        position: absolute;
        left: 0;
        -webkit-transform: translateX(-100%);
        -ms-transform: translateX(-100%);
        transform: translateX(-100%);
    }

    .show-sidebar aside .toggle .burger:before,
    .show-sidebar aside .toggle .burger span,
    .show-sidebar aside .toggle .burger:after {
        background: #fff;
    }

    .show-sidebar aside {
        -webkit-box-shadow: -10px 0 30px 0 rgba(0, 0, 0, 0.5);
        box-shadow: -10px 0 30px 0 rgba(0, 0, 0, 0.5);
    }

    aside .side-inner {
        padding: 20px 0;
        height: 100vh;
        overflow-y: scroll;
        -webkit-overflow-scrolling: touch;
    }

    aside .side-inner .share {
        padding: 20px 30px;
    }

    main {
        width: calc(100%);
    }

    main .post-entry {
        margin-bottom: 30px;
    }

    main .post-entry .custom-thumbnail {
        -webkit-box-flex: 0;
        -ms-flex: 0 0 80px;
        flex: 0 0 80px;
        margin-right: 30px;
    }

    main .post-content h3 {
        font-size: 18px;
    }

    main .post-content .post-meta {
        font-size: 15px;
        color: #ccc;
    }

    /* Toggle */

    .menu-toggle span {
        color: #ccc;
        font-size: 2rem;
    }

    .menu-toggle:hover span,
    .menu-toggle:focus span {
        color: #000;
    }

    .menu-toggle.active span {
        color: #fff;
    }

    /* cart-header */
    .menu-btn .dropdown-toggle::after {
        margin-left: 1em;
    }

    #ddl-account:hover {
        background-color: rgba(192, 192, 192, 0.3) !important;
    }

    .cart span {
        width: 20px;
        height: 20px;
        border-radius: 50px;
        font-size: 12px;
        font-weight: 600;
        color: #202020;
        background-color: #f5d730;
        display: block;
        overflow: hidden;
        text-align: center;
        line-height: 20px;
        margin-top: 5px;
        position: absolute;
        top: -5px;
        left: 30px;
    }

    /* cart-sidebar */

    .list-cart div {
        padding: 0;
    }

    .list-cart .cart-img a {
        position: absolute;
        top: -9px;
        left: -8px;
        padding: 0;
        width: 20px;
        height: 20px;
        font-size: 14px;
    }

    .cart-img img {
        height: 75px;
        object-fit: cover;
    }

    .cart-title h6 {
        overflow: hidden;
        display: -webkit-box;
        -webkit-line-clamp: 2;
        -webkit-box-orient: vertical;
        font-size: 1.1rem;
    }

    .cart-title p {
        font-size: 14px;
        color: burlywood;
    }

    .list-cart button {
        min-width: 0 !important;
        border-radius: 50%;
        width: 36px;
        height: 35px;
        padding: 0;
    }

    .list-cart input {
        background-color: #fff !important;
        border: 0;
        max-width: 80px;
    }
</style>

<aside class="sidebar">
    <div class="side-inner">
        <div class="share" id="list-cart">
        </div>
    </div>
</aside>

<script>
    $(document).ready(function () {
        $('#list-cart input[type="number"]').inputSpinner({
            buttonsOnly: true,
            autoInterval: undefined
        });
    });
</script>
<!-- ##### Header Area End ##### -->