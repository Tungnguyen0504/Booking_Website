<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.booking.entity.Booking" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.concurrent.TimeUnit" %>
<%@ page import="com.booking.dao.IDAO.*" %>
<%@ page import="com.booking.dao.DAOImpl.*" %>
<%@ page import="com.booking.util.FunctionUtil" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- table card-1 start -->


<jsp:useBean id="FunctionUtil" scope="page" class="com.booking.util.FunctionUtil"/>


<%
    BookingDAO bookingDAO = new BookingDAOImpl();
    HotelDAO hotelDAO = new HotelDAOImpl();
    AccountDAO accountDAO = new AccountDAOImpl();
    CityDAO cityDAO = new CityDAOImpl();
    ContactDAO contactDAO = new ContactDAOImpl();
    RatingDAO ratingDAO = new RatingDAOImpl();


    //earning this month
    double earningThisMonth = 0;
    double earningLastMonth = 0;
    int countNewBooking = 0;
    for (Booking booking : bookingDAO.getAllBooking()) {
        java.util.Date currentDate = new java.util.Date();
        long subtractDate = TimeUnit.MILLISECONDS.toDays(currentDate.getTime() - booking.getBookingDate().getTime());

        if (booking.getBookingStatusId() != 4) {
            if (subtractDate <= 30) {
                earningThisMonth += booking.getTotalPrice();
            }

            if (subtractDate >= 30 && subtractDate <= 60) {
                earningLastMonth += booking.getTotalPrice();
            }
        }

        if(subtractDate >= 0 && subtractDate <= 1) {
            countNewBooking++;
        }
    }


    request.setAttribute("countAccount", accountDAO.getAllAccount().size());  //count Account
    request.setAttribute("countCity", cityDAO.getAll().size());
    request.setAttribute("countAllHotel", hotelDAO.countSearchHotel("", ""));  //count hotel
    request.setAttribute("earningThisMonth", earningThisMonth);  //earning
    request.setAttribute("earningLastMonth", earningLastMonth);
    request.setAttribute("countNewBooking", countNewBooking);
    request.setAttribute("countContact", contactDAO.getAll().size());  //count contact
    request.setAttribute("countRating", ratingDAO.getAllRating().size());  //count rating
    request.setAttribute("listBooking", bookingDAO.getAllBooking());
%>


<div class="col-md-12 col-xl-4">
    <div class="card flat-card">
        <div class="row-table">
            <div class="col-sm-6 card-body br">
                <div class="row">
                    <div class="col-sm-4">
                        <i class="fa-solid fa-users text-c-green mb-1 d-block" style="font-size: 26px;"></i>
                    </div>
                    <div class="col-sm-8 text-md-center">
                        <h5>${countAccount}</h5>
                        <span>Người dùng</span>
                    </div>
                </div>
            </div>
            <div class="col-sm-6 card-body">
                <div class="row">
                    <div class="col-sm-4">
                        <i class="fa-solid text-c-red fa-hotel mb-1 d-block" style="font-size: 26px;"></i>
                    </div>
                    <div class="col-sm-8 text-md-center">
                        <h5>${countAllHotel}</h5>
                        <span>Khách sạn</span>
                    </div>
                </div>
            </div>
        </div>
        <div class="row-table">
            <div class="col-sm-6 card-body br">
                <div class="row">
                    <div class="col-sm-4">
                        <i class="text-c-blue fa-solid fa-city mb-1 d-block" style="font-size: 25px;"></i>
                    </div>
                    <div class="col-sm-8 text-md-center">
                        <h5>${countCity}</h5>
                        <span>Thành Phố</span>
                    </div>
                </div>
            </div>
            <div class="col-sm-6 card-body">
                <div class="row">
                    <div class="col-sm-4">
                        <i class="icon feather icon-mail text-c-yellow mb-1 d-block" style="font-size: 31px;"></i>
                    </div>
                    <div class="col-sm-8 text-md-center">
                        <h5>${countContact}</h5>
                        <span>Emails</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- widget primary card start -->
    <div class="card flat-card widget-primary-card">
        <div class="row-table">
            <div class="col-sm-3 card-body">
                <i class="fa-solid fa-briefcase"></i>
            </div>
            <div class="col-sm-9">
                <h4>${countNewBooking} +</h4>
                <h6>Đặt phòng mới</h6>
            </div>
        </div>
    </div>
    <!-- widget primary card end -->
</div>
<!-- table card-1 end -->
<!-- table card-2 start -->
<div class="col-md-12 col-xl-4">
    <div class="card flat-card">
        <div class="row-table">
            <div class="card border-0 mb-0">
                <div class="card-body py-4 px-4" style="height: 170px;">
                    <div>
                        <h5 class="text-muted mb-2">Doanh thu tháng này<i class="fa fa-caret-up text-c-green m-l-10"
                                                                          style="position: relative; top: 2px; font-size: 26px;"></i>
                        </h5>
                        <h4 class="mb-2"><fmt:formatNumber value="${earningThisMonth}" type="number"/> VND</h4>
                        <div class="progress mb-3">
                            <div class="progress-bar" role="progressbar"
                                 style="width: ${earningThisMonth >= earningLastMonth ? (earningLastMonth / earningThisMonth) * 100 : (earningThisMonth / earningLastMonth) * 100}%; background: ${earningThisMonth >= earningLastMonth ? "linear-gradient(45deg, #72c2ff, #86f0ff) !important" : "linear-gradient(45deg, #ff0000, bisque) !important"};"
                                 aria-valuenow="25"
                                 aria-valuemin="0" aria-valuemax="100"></div>
                        </div>
                        <div>
                            <c:if test="${earningThisMonth > earningLastMonth}">
                                <h5>Tăng <fmt:formatNumber value="${((earningThisMonth / earningLastMonth) * 100)}"
                                                           maxFractionDigits="1"/> % so với tháng trước</h5>
                            </c:if>
                            <c:if test="${earningThisMonth < earningLastMonth}">
                                <h5>Giảm <fmt:formatNumber value="${((earningLastMonth / earningThisMonth) * 100)}"
                                                           maxFractionDigits="1"/> % so với tháng trước</h5>
                            </c:if>
                            <c:if test="${earningThisMonth eq earningLastMonth}">
                                <h5>Tăng 0 % so với tháng trước</h5>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- widget-success-card start -->
    <div class="card flat-card widget-purple-card">
        <div class="row-table">
            <div class="col-sm-3 card-body">
                <i class="feather icon-star-on"></i>
            </div>
            <div class="col-sm-9">
                <h4>${countRating}</h4>
                <h6>Số lượt đánh giá</h6>
            </div>
        </div>
    </div>
    <!-- widget-success-card end -->
</div>
<!-- table card-2 end -->
<!-- Widget primary-success card start -->
<div class="col-md-12 col-xl-4">
    <div class="card support-bar overflow-hidden">
        <div class="card-body pb-0">
            <h2 class="m-0">${listBooking.size()}</h2>
            <span class="text-c-blue">Tổng số lượt đặt phòng</span>
            <p class="mb-3 mt-3">Tổng tất cả số lượt đặt phòng tại trang web.</p>
        </div>
        <div id="widget-booking-chart"></div>
        <div class="card-footer bg-primary text-white">
            <div class="row text-center">
                <c:set value="${0}" var="countCorfimed"/>
                <c:set value="${0}" var="countsucceeded"/>
                <c:set value="${0}" var="countFailed"/>
                <c:forEach items="${listBooking}" var="o" varStatus="loop">
                    <c:if test="${o.bookingStatusId == 2}">
                        <c:set value="${countCorfimed + 1}" var="countCorfimed"/>
                    </c:if><c:if test="${o.bookingStatusId == 3}">
                        <c:set value="${countsucceeded + 1}" var="countsucceeded"/>
                    </c:if>
                    <c:if test="${o.bookingStatusId == 4}">
                        <c:set value="${countFailed + 1}" var="countFailed"/>
                    </c:if>
                </c:forEach>
                <div class="col">
                    <h4 class="m-0 text-white">${countCorfimed}</h4>
                    <span>Xác nhận</span>
                </div><div class="col">
                    <h4 class="m-0 text-white">${countsucceeded}</h4>
                    <span>Thành công</span>
                </div>
                <div class="col">
                    <h4 class="m-0 text-white">${countFailed}</h4>
                    <span>Đã hủy</span>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Widget primary-success card end -->
<script>
    'use strict';
    $(document).ready(function () {
        setTimeout(function () {
            floatchart1()
        }, 100);
    });

    function floatchart1() {
        // [ support-chart ] start
        $(function () {
            var options1 = {
                chart: {
                    type: 'area',
                    height: 65,
                    sparkline: {
                        enabled: true
                    }
                },
                colors: ["#1abc9c"],
                stroke: {
                    curve: 'smooth',
                    width: 2,
                },
                series: [{
                    data: [${FunctionUtil.countBookingMonthly(9)}, ${FunctionUtil.countBookingMonthly(8)}, ${FunctionUtil.countBookingMonthly(7)}, ${FunctionUtil.countBookingMonthly(6)}, ${FunctionUtil.countBookingMonthly(5)}, ${FunctionUtil.countBookingMonthly(4)}, ${FunctionUtil.countBookingMonthly(3)}, ${FunctionUtil.countBookingMonthly(2)}, ${FunctionUtil.countBookingMonthly(1)}]
                }],
                xaxis: {
                    type: 'string',
                    categories: ["${FunctionUtil.getDateFromNow(-8)}", "${FunctionUtil.getDateFromNow(-7)}", "${FunctionUtil.getDateFromNow(-6)}", "${FunctionUtil.getDateFromNow(-5)}", "${FunctionUtil.getDateFromNow(-4)}", "${FunctionUtil.getDateFromNow(-3)}", "${FunctionUtil.getDateFromNow(-2)}", "${FunctionUtil.getDateFromNow(-1)}", "${FunctionUtil.getDateFromNow(0)}"]
                },
                tooltip: {
                    x: {
                        format: 'MMM yyyy'
                    },
                    y: {
                        title: {
                            formatter: function (seriesName) {
                                return 'Tổng số đơn'
                            }
                        }
                    },
                },
            }
            new ApexCharts(document.querySelector("#widget-booking-chart"), options1).render();
        });
    }

</script>