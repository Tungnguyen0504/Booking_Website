<%@page buffer="8192kb" autoFlush="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.booking.util.FunctionUtil" %>

<jsp:include page="../layout/admin-header-sidebar.jsp"/>

<jsp:useBean id="AccountDAO" scope="page" class="com.booking.dao.DAOImpl.AccountDAOImpl"/>
<jsp:useBean id="RatingDAO" scope="page" class="com.booking.dao.DAOImpl.RatingDAOImpl"/>
<jsp:useBean id="BookingDAO" scope="page" class="com.booking.dao.DAOImpl.BookingDAOImpl"/>
<jsp:useBean id="BookingDetailDAO" scope="page" class="com.booking.dao.DAOImpl.BookingDetailDAOIml"/>
<jsp:useBean id="RoomDAO" scope="page" class="com.booking.dao.DAOImpl.RoomDAOImpl"/>
<jsp:useBean id="CityDAO" scope="page" class="com.booking.dao.DAOImpl.CityDAOImpl"/>
<jsp:useBean id="HotelTypeDAO" scope="page" class="com.booking.dao.DAOImpl.HotelTypeDAOImpl"/>
<jsp:useBean id="HotelDAO" scope="page" class="com.booking.dao.DAOImpl.HotelDAOImpl"/>
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
                            <h5 class="m-b-10">Quản lý đặt phòng</h5>
                        </div>
                        <ul class="breadcrumb">
                            <li class="breadcrumb-item"><a href="<%=request.getContextPath()%>/admin-index"><i
                                    class="feather icon-home"></i></a></li>
                            <li class="breadcrumb-item">Quản lý đặt phòng</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <!-- [ breadcrumb ] end -->
        <!-- [ Main Content ] start -->
        <div class="row">

            <jsp:include page="../layout/admin-widget.jsp"/>

            <div class="col-md-12">
                <div class="card table-card">
                    <div class="card-header d-flex align-items-center justify-content-between px-3">
                        <h5>Quản lý khách sạn</h5>
                        <div>
                            <button type="button" id="export_button" class="btn btn-primary text-white"
                                    style="padding: 5px 25px;">Export
                            </button>
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

                        .table td, .table th {
                            vertical-align: middle;
                        }

                        .table div.dataTables_wrapper div.dataTables_info {
                            color: #868e96 !important;
                        }

                        .table #booking-index-table_length {
                            display: none;
                        }

                        .action-btn a {
                            width: 34px !important;
                            height: 34px !important;
                            color: white !important;
                            margin: 0 5px;
                            cursor: pointer;
                        }

                        .action-btn a i {
                            font-size: 16px;
                        }

                        #hotel-table_wrapper {
                            margin-bottom: 15px;
                        }

                        .hide-col {
                            overflow: hidden;
                            display: -webkit-box;
                            -webkit-line-clamp: 2;
                            -webkit-box-orient: vertical;
                        }
                    </style>

                    <div class="card-body p-3">
                        <div class="table">
                            <table class="table table-hover mb-3" id="booking-table">
                                <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Họ và tên</th>
                                    <th>Khách sạn</th>
                                    <th>Giờ checkin</th>
                                    <th>Số khách</th>
                                    <th>Số phòng</th>
                                    <th>Ghi chú</th>
                                    <th>Ngày đặt phòng</th>
                                    <th>Ngày checkin</th>
                                    <th>Ngày checkout</th>
                                    <th>Tổng cộng</th>
                                    <th>Hình thức thanh toán</th>
                                    <th>Trạng thái</th>
                                    <th>Thao tác</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${bookingList}" var="book" varStatus="loop">
                                    <c:set var="countRoom" value="${0}"/>
                                    <c:forEach items="${BookingDetailDAO.getAllByBookingId(book.bookingId)}" var="bd"
                                               end="0">
                                        <c:set var="countRoom" value="${countRoom + bd.quantityRoom}"/>
                                        <c:set var="bookingDetail" value="${bd}"/>
                                    </c:forEach>
                                    <c:set value="${AccountDAO.getAccountById(book.accountId)}" var="account"/>
                                    <c:set value="${RoomDAO.getRoomByRoomId(bookingDetail.roomId)}" var="room"/>
                                    <c:set value="${HotelDAO.getHotelById(room.hotelId)}" var="hotel"/>

                                    <tr class="row${book.bookingId}">
                                        <td>${book.bookingId}</td>
                                        <td>
                                            <div class="d-flex">
                                                <img src="<c:url value="/uploads/accounts/${account.image}"/>"
                                                     alt="user image" width="45" height="45"
                                                     class="img-radius align-top m-r-15" style="object-fit: cover;">
                                                <div class="d-flex align-items-center">
                                                    <h6 class="mb-0">${account.fullName}</h6>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <div>
                                                <h5 class="text-primary hide-col mb-1"
                                                    style="width: 180px;">${hotel.hotelName}</h5>
                                                <div style="color: #febb02;">
                                                    <c:forEach begin="1" end="${hotel.star}">
                                                        <i class="fa-solid fa-star "></i>
                                                    </c:forEach>
                                                </div>
                                            </div>
                                        </td>
                                        <td class="text-center">${book.timeCheckin}</td>
                                        <td class="text-center">${book.guestNumber} khách</td>
                                        <td class="text-center">${countRoom} phòng</td>
                                        <td>
                                            <div class="hide-col" style="width: 200px;">
                                                    ${book.note}
                                            </div>
                                        </td>
                                        <td class="text-center" style="white-space: nowrap"><fmt:formatDate
                                                value="${book.bookingDate}"
                                                pattern="dd MMM yyyy"/></td>
                                        <td class="text-center" style="white-space: nowrap"><fmt:formatDate
                                                value="${book.dateFrom}"
                                                pattern="dd MMM yyyy"/></td>
                                        <td class="text-center" style="white-space: nowrap"><fmt:formatDate
                                                value="${book.dateTo}"
                                                pattern="dd MMM yyyy"/></td>
                                        <td style="white-space: nowrap;">
                                            <fmt:formatNumber value="${book.totalPrice}" type="number"/> VND
                                        </td>
                                        <td class="text-center">${book.payment}</td>
                                        <td class="text-center">
                                            <label class="badge ${book.bookingStatusId == 1 ? "badge-warning" : book.bookingStatusId == 2 ? "badge-success" : book.bookingStatusId == 3 ? "badge-info" : "badge-danger"}"
                                                   style="font-size: 14px; font-weight: normal;">
                                                    ${book.bookingStatusId == 1 ? "Chưa thanh toán" : book.bookingStatusId == 2 ? "Xác nhận" : book.bookingStatusId == 3 ? "Trả phòng" : "Đã hủy"}
                                            </label>
                                        </td>
                                        <td>
                                            <div class="action-btn d-flex align-items-center">
                                                <input type="hidden" value="${book.bookingId}" name="bookingId">
                                                <a class="booking-detail-modal btn btn-icon btn-info" data-toggle="modal" data-target="#booking-detail">
                                                    <i class="fa-solid fa-info"></i>
                                                </a>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- [ Main Content ] end -->
    </div>
</div>

<div class="modal fade" id="booking-detail" tabindex="-1" aria-labelledby="exampleModalLabel"
     aria-hidden="true">
    <div class="modal-dialog modal-xl modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Danh sách đặt phòng</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body px-5">
                <div id="booking-list-modal">

                </div>
            </div>
            <div class="close-detail modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Đóng</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="delete-modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Xoá khách sạn</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                Bạn có chắc sẽ xóa đơn đặt phòng này không?
                Mọi hành động sẽ không thể khôi phục lại.
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Đóng</button>
                <button type="button" class="btn-delete-booking btn btn-primary">Xóa</button>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../layout/admin-footer.jsp"/>

<script>
    $(document).ready(function () {
        $('#booking-table').DataTable({
            lengthMenu: [
                [5, 10, 25, -1],
                [5, 10, 25, "All"]
            ],
        });
    });
</script>

<script>
    function html_table_to_excel(type) {
        var data = document.getElementById('booking-table');

        var file = XLSX.utils.table_to_book(data, {sheet: "sheet1"});

        XLSX.write(file, {bookType: type, bookSST: true, type: 'base64'});

        XLSX.writeFile(file, 'file.' + type);
    }

    $('#export_button').on('click', function () {
        html_table_to_excel('xlsx');
    });
</script>

<script>
    var bookingId;
    $('.btn-delete-modal').on('click', function () {
        bookingId = $(this).parent().find('input[name="bookingId"]').val();
    });

    $('.btn-delete-booking').on('click', function () {

        $.ajax({
            url: "admin-manage-booking",
            dataType: 'json',
            type: "post",
            data: {
                action: 'deleteBooking',
                bookingId: bookingId
            },
            success: function (result) {
                swal("Xoá thành công!", "Bạn đã xóa thành công đơn đặt phòng với mã ID " + result + "!", "success");
                $('.row' + bookingId).hide();
                $('#delete-modal').modal('hide');
            }, error: function (e) {
                console.log(e);
            }
        });
    })
</script>

<script>
    $('.booking-detail-modal').on('click', function () {
        var bookingId = $(this).parent().find('input[name="bookingId"]').val();

        $.ajax({
            url: "admin-manage-booking",
            type: "get",
            dataType: 'json',
            data: {
                action: 'loadBookingDetailModal',
                bookingId: bookingId
            },
            success: function (result) {
                $('#booking-list-modal').html(result);
            }
        });
    })
</script>
</body>

</html>