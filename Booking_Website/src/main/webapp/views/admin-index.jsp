<%@page buffer="8192kb" autoFlush="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.booking.util.FunctionUtil" %>

<jsp:include page="../layout/admin-header-sidebar.jsp"/>
<jsp:useBean id="AccountDAO" scope="page" class="com.booking.dao.DAOImpl.AccountDAOImpl"/>
<jsp:useBean id="HotelDAO" scope="page" class="com.booking.dao.DAOImpl.HotelDAOImpl"/>
<jsp:useBean id="BookingDAO" scope="page" class="com.booking.dao.DAOImpl.BookingDAOImpl"/>
<jsp:useBean id="BookingDetailDAO" scope="page" class="com.booking.dao.DAOImpl.BookingDetailDAOIml"/>
<jsp:useBean id="RoomDAO" scope="page" class="com.booking.dao.DAOImpl.RoomDAOImpl"/>
<jsp:useBean id="FunctionUtil" scope="page" class="com.booking.util.FunctionUtil"/>

<fmt:setLocale value="vi_VN"/>

<!-- [ Main Content ] start -->
<div class="pcoded-main-container">
    <div class="pcoded-content">
        <!-- [ breadcrumb ] start -->
        <div class="page-header">
            <div class="page-block">
                <div class="row align-items-center">
                    <div class="col-md-12">
                        <div class="page-header-title">
                            <h5 class="m-b-10">Dashboard Analytics</h5>
                        </div>
                        <ul class="breadcrumb">
                            <li class="breadcrumb-item"><a href="index.html"><i class="feather icon-home"></i></a></li>
                            <li class="breadcrumb-item"><a href="#!">Dashboard Analytics</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <!-- [ breadcrumb ] end -->
        <!-- [ Main Content ] start -->
        <div class="row">
            <!-- table card-1 start -->

            <jsp:include page="../layout/admin-widget.jsp"/>

            <!-- Widget primary-success card end -->


            <style>
                #available-room-chart .apexcharts-datalabels-group {
                    display: none;
                }
            </style>


            <div class="col-md-4">
                <div class=" card text-center">
                    <div class="card-body position-relative" style="min-height: 242px;">
                        <div id="available-room-chart" style=" position: relative; bottom: 25px;"></div>
                        <div style="position: absolute; top: 78%; left: 50%; transform: translate(-50%, -50%); width: fit-content;">
                            <h3>${countRoom}</h3>
                            <h6>Phòng trống hôm nay</h6>
                        </div>
                    </div>
                </div>


                <script>
                    $(document).ready(function () {
                        setTimeout(function () {
                            $(function () {
                                var options = {
                                    series: [${(countRoom / (RoomDAO.allRoom.size() * 15) * 100)}],
                                    colors: ["#1abc9c"],
                                    chart: {
                                        height: 210,
                                        type: 'radialBar',
                                    },
                                    plotOptions: {
                                        radialBar: {
                                            hollow: {
                                                size: '40%',
                                            }
                                        },
                                    },
                                    labels: ['Checkout'],
                                };

                                var chart = new ApexCharts(document.querySelector("#available-room-chart"), options);
                                chart.render();
                            });
                        }, 700);
                    });
                </script>


                <style>
                    .progress-booking .progress {
                        height: 0.8rem;
                        border-radius: 10px;
                    }

                    .marker span {
                        height: 12px;
                        width: 12px;
                        margin-right: 10px;
                        border-radius: 12px;
                        display: inline-block;
                    }
                </style>
                <div class="card progress-booking" style="min-height: 245px;">
                    <div class="card-header py-2">
                        <h5>
                            Trạng thái đặt phòng
                        </h5>
                    </div>

                    <c:set var="countTotalBookingStatus" value="${BookingDAO.allBooking.size()}"/>

                    <div class="card-body position-relative">
                        <div class="progress mb-4">
                            <div class="progress-bar" role="progressbar"
                                 style="width: ${(countPaid / countTotalBookingStatus) * 100}%; background: linear-gradient(45deg, #9ce89d, #cdfa7e) !important;"
                                 aria-valuenow="${(countPaid / countTotalBookingStatus) * 100}"
                                 aria-valuemin="0" aria-valuemax="100"></div>
                        </div>
                        <div class="progress mb-4">
                            <div class="progress-bar" role="progressbar"
                                 style="width: ${(countReturned / countTotalBookingStatus) * 100}%; background: linear-gradient(45deg, #72c2ff, #86f0ff) !important;"
                                 aria-valuenow="${(countReturned / countTotalBookingStatus) * 100}"
                                 aria-valuemin="0" aria-valuemax="100"></div>
                        </div>
                        <div class="progress mb-4">
                            <div class="progress-bar" role="progressbar"
                                 style="width: ${(countCanceled / countTotalBookingStatus) * 100}%; background: linear-gradient(45deg, #fda582, #f7cf68) !important;"
                                 aria-valuenow="${(countCanceled / countTotalBookingStatus) * 100}" aria-valuemin="0"
                                 aria-valuemax="100"></div>
                        </div>
                        <div class="d-flex justify-content-between">
                            <div class="d-flex">
                                <div class="marker">
                                    <span class="progress-bar"
                                          style="background: linear-gradient(45deg, #9ce89d, #cdfa7e) !important;"></span>
                                </div>
                                <div>
                                    <p class="mb-1">Đã xác nhận</p>
                                    <p class="font-weight-bold mb-0" style="font-size: 17px;">${countPaid}</p>
                                </div>
                            </div>
                            <div class="d-flex">
                                <div class="marker">
                                    <span class="progress-bar"
                                          style="background: linear-gradient(45deg, #72c2ff, #86f0ff) !important;"></span>
                                </div>
                                <div>
                                    <p class="mb-1">Đã trả phòng</p>
                                    <p class="font-weight-bold mb-0" style="font-size: 17px;">${countReturned}</p>
                                </div>
                            </div>
                            <div class="d-flex">
                                <div class="marker">
                                    <span class="progress-bar"
                                          style="background: linear-gradient(45deg, #fda582, #f7cf68) !important;"></span>
                                </div>
                                <div>
                                    <p class="mb-1">Đã Hủy</p>
                                    <p class="font-weight-bold mb-0" style="font-size: 17px;">${countCanceled}</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-8">
                <div class="card">
                    <div class="card-header">
                        <h5>Quản lý doanh thu</h5>
                    </div>
                    <div class="card-body" style="min-height: 455px;">
                        <div id="booking-chart"></div>
                    </div>
                </div>
            </div>
            <div class="col-xl-8 col-md-12">
                <div class="card table-card">
                    <div class="card-header">
                        <h5>Quản lý đặt phòng</h5>
                        <div class="card-header-right">
                            <div class="btn-group card-option">
                                <button type="button" class="btn dropdown-toggle" data-toggle="dropdown"
                                        aria-haspopup="true" aria-expanded="false">
                                    <i class="feather icon-more-horizontal"></i>
                                </button>
                                <ul class="list-unstyled card-option dropdown-menu dropdown-menu-right">
                                    <li class="dropdown-item">
                                        <a href="<%=request.getContextPath()%>/admin-manage-booking">
                                            <span><i class="feather icon-info"></i>Xem Đơn</span>
                                        </a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>

                    <style>
                        .table .badge {
                            font-size: 14px;
                            font-weight: normal;
                        }

                        .table thead th {
                            white-space: nowrap;
                        }

                        .table div.dataTables_wrapper div.dataTables_info {
                            color: #868e96 !important;
                        }

                        .table #booking-index-table_length {
                            display: none;
                        }
                    </style>

                    <div class="card-body p-3">
                        <div class="table table-responsive">
                            <table class="table table-hover mb-0" id="booking-index-table">
                                <thead>
                                <tr>
                                    <th>Họ và tên</th>
                                    <th>Khách sạn</th>
                                    <th>Ngày đặt</th>
                                    <th>Trạng thái</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${bookingList}" var="book">
                                    <c:forEach items="${BookingDetailDAO.getAllByBookingId(book.bookingId)}" var="bd" end="0">
                                        <c:set var="bookingDetail" value="${bd}"/>
                                    </c:forEach>
                                    <tr>
                                        <td>
                                            <div class="d-flex">
                                                <img src="<c:url value="/admin/assets/images/user/${AccountDAO.getAccountById(book.accountId).image}"/>"
                                                     alt="user image" width="45" height="45"
                                                     class="img-radius align-top m-r-15" style="object-fit: cover;">
                                                <div class="d-flex flex-column">
                                                    <h6>${AccountDAO.getAccountById(book.accountId).fullName}</h6>
                                                    <p class="text-muted m-b-0 text-truncate"
                                                       style="max-width: 150px;">${AccountDAO.getAccountById(book.accountId).email}</p>
                                                </div>
                                            </div>
                                        </td>
                                        <td class="text-break"
                                            style="max-width: 250px;">${HotelDAO.getHotelById(RoomDAO.getRoomByRoomId(bookingDetail.roomId).hotelId).hotelName}</td>
                                        <td><fmt:formatDate value="${book.bookingDate}" pattern="dd MMM yyyy"/></td>
                                        <td class="text-center">
                                            <label class="badge ${book.bookingStatusId == 1 ? "badge-warning" : book.bookingStatusId == 2 ? "badge-success" : book.bookingStatusId == 3 ? "badge-info" : "badge-danger"}">
                                                    ${book.bookingStatusId == 1 ? "Chưa thanh toán" : book.bookingStatusId == 2 ? "Xác nhận" : book.bookingStatusId == 3 ? "Trả phòng" : "Đã hủy"}
                                            </label>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <div class="card table-card review-card">
                    <div class="card-header borderless ">
                        <h5>Quản lý đánh giá</h5>
                        <div class="card-header-right">
                            <div class="btn-group card-option">
                                <button type="button" class="btn dropdown-toggle" data-toggle="dropdown"
                                        aria-haspopup="true" aria-expanded="false">
                                    <i class="feather icon-more-horizontal"></i>
                                </button>
                                <ul class="list-unstyled card-option dropdown-menu dropdown-menu-right">
                                    <li class="dropdown-item full-card"><a href="#!"><span><i
                                            class="feather icon-maximize"></i> maximize</span><span
                                            style="display:none"><i
                                            class="feather icon-minimize"></i> Restore</span></a></li>
                                    <li class="dropdown-item minimize-card"><a href="#!"><span><i
                                            class="feather icon-minus"></i> collapse</span><span style="display:none"><i
                                            class="feather icon-plus"></i> expand</span></a></li>
                                    <li class="dropdown-item reload-card"><a href="#!"><i
                                            class="feather icon-refresh-cw"></i> reload</a></li>
                                    <li class="dropdown-item close-card"><a href="#!"><i class="feather icon-trash"></i>
                                        remove</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>


                    <style>
                        .review-block .btn.btn-icon {
                            width: 35px;
                            height: 35px;
                        }
                    </style>


                    <div class="card-body pb-0">
                        <div class="review-block" style="height: 380px; overflow-y: auto;">

                            <c:forEach items="${ratingList}" var="rate">
                                <div class="row border-bottom rating-row">
                                    <div class="col-sm-1 p-r-0">
                                        <img src="<c:url value="/admin/assets/images/user/${AccountDAO.getAccountById(BookingDAO.getBookingById(rate.bookingId).accountId).image}"/>"
                                             alt="user image"
                                             class="img-radius profile-img cust-img m-b-15">
                                    </div>
                                    <div class="col-8">
                                        <h5 class="mb-0"
                                            style="font-size: 17px;">${AccountDAO.getAccountById(BookingDAO.getBookingById(rate.bookingId).accountId).fullName} </h5>
                                        <small class="f-13 text-muted">Đã đăng vào ${rate.createdDateFormat}</small>
                                        <p class="m-t-15 m-b-15 text-muted">${rate.description}.</p>
                                    </div>
                                    <div class="col-sm-3 text-center py-3">
                                        <div>
                                            <c:forEach begin="1" end="${rate.starRating}">
                                                <a href="#!"><i class="feather icon-star-on f-18 text-c-yellow"></i></a>
                                            </c:forEach>
                                            <c:forEach begin="${rate.starRating + 1}" end="5">
                                                <a href="#!"><i class="feather icon-star f-18 text-muted"></i></a>
                                            </c:forEach>
                                        </div>
                                        <div class="mt-2">
                                            <input type="hidden" value="${rate.ratingId}" name="ratingId">
                                            <a type="button"
                                               class="accept-rating btn btn-icon btn-primary text-white m-2"><i
                                                    class="feather icon-check-circle"></i></a>
                                            <a type="button"
                                               class="reject-rating btn btn-icon btn-danger text-white m-2"><i
                                                    class="feather icon-slash"></i></a>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-12 col-xl-4">
                <div class="card">
                    <div class="card-header">
                        <h5>Biểu đồ checkin & checkout</h5>
                    </div>
                    <div class="card-body d-flex" style="height: 235px;">
                        <div class="col-6 p-0" id="checkin-chart"></div>
                        <div class="col-6 p-0" id="checkout-chart"></div>
                    </div>
                </div>
            </div>
        </div>
        <!-- [ Main Content ] end -->
    </div>
</div>

<jsp:include page="../layout/admin-footer.jsp"/>

<script>
    $(function () {
        var options = {
            chart: {
                height: 400,
                type: 'bar',
            },
            plotOptions: {
                bar: {
                    horizontal: false,
                    columnWidth: '55%'
                },
            },
            dataLabels: {
                enabled: false
            },
            colors: ["#1abc9c", "#0e9e4a", "#f1c40f", "#e74c3c"],
            stroke: {
                show: true,
                colors: ['transparent']
            },
            series: [{
                name: 'Doanh thu',
                data: [${FunctionUtil.earningMonthly(10)}, ${FunctionUtil.earningMonthly(9)}, ${FunctionUtil.earningMonthly(8)}, ${FunctionUtil.earningMonthly(7)}, ${FunctionUtil.earningMonthly(6)}, ${FunctionUtil.earningMonthly(5)}, ${FunctionUtil.earningMonthly(4)}, ${FunctionUtil.earningMonthly(3)}, ${FunctionUtil.earningMonthly(2)}, ${FunctionUtil.earningMonthly(1)},]
            }],
            xaxis: {
                categories: ["${FunctionUtil.getDateFromNow(-9)}", "${FunctionUtil.getDateFromNow(-8)}", "${FunctionUtil.getDateFromNow(-7)}", "${FunctionUtil.getDateFromNow(-6)}", "${FunctionUtil.getDateFromNow(-5)}", "${FunctionUtil.getDateFromNow(-4)}", "${FunctionUtil.getDateFromNow(-3)}", "${FunctionUtil.getDateFromNow(-2)}", "${FunctionUtil.getDateFromNow(-1)}", "${FunctionUtil.getDateFromNow(0)}"],
            },
            fill: {
                opacity: 1

            },
            tooltip: {
                y: {
                    formatter: function (val) {
                        return Math.trunc(val).toLocaleString('pl-PL') + " VND"
                    }
                }
            },
            title: {
                text: 'Biểu đồ doanh thu của 10 tháng gần nhất',
                align: 'center'
            },
        }
        var chart = new ApexCharts(
            document.querySelector("#booking-chart"),
            options
        );
        chart.render();
    });

    $(function () {
        var value = ${(countCheckin / BookingDAO.allBooking.size()) * 100};
        var options = {
            series: [value.toFixed(1)],
            colors: ["#0e9e4a"],
            chart: {
                height: 230,
                type: 'radialBar',
            },
            plotOptions: {
                radialBar: {
                    hollow: {
                        size: '50%',
                    }
                },
            },
            labels: ['Checkin'],
        };

        var chart = new ApexCharts(document.querySelector("#checkin-chart"), options);
        chart.render();
    });

    $(function () {
        var value = ${(countCheckout / BookingDAO.allBooking.size()) * 100};
        var options = {
            series: [value.toFixed(1)],
            colors: ["#e74c3c"],
            chart: {
                height: 230,
                type: 'radialBar',
            },
            plotOptions: {
                radialBar: {
                    hollow: {
                        size: '50%',
                    }
                },
            },
            labels: ['Checkout'],
        };

        var chart = new ApexCharts(document.querySelector("#checkout-chart"), options);
        chart.render();
    });

    // data-table
    $('#booking-index-table').DataTable({
        ordering: false,
        lengthMenu: [
            [5],
            [5]
        ],
        bFilter: false,
        bInfo: false
    });

    //rating
    $('.accept-rating').on('click', function () {
        var id = $(this).parent().find('input[name="ratingId"]').val();
        $(this).closest('.rating-row').hide();
        $.ajax({
            url: "admin-index",
            type: "post",
            dataType: 'json',
            data: {
                action: 'manageRating',
                status: 2,
                ratingId: id
            },
            success: function () {
                swal("Đã thêm bình luận!");
            }
        });
    });

    $('.reject-rating').on('click', function () {
        var id = $(this).parent().find('input[name="ratingId"]').val();
        $(this).closest('.rating-row').hide();
        $.ajax({
            url: "admin-index",
            type: "post",
            dataType: 'json',
            data: {
                action: 'manageRating',
                status: 3,
                ratingId: id
            },
            success: function () {
                swal("Đã xóa bình luận!");
            }
        });
    });
</script>

</body>

</html>