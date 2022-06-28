<%@page buffer="8192kb" autoFlush="true" %>
<%@ page import="java.util.Date" %>
<%@ page import="com.booking.entity.Booking" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.util.concurrent.TimeUnit" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<jsp:include page="../layout/header.jsp"/>
<jsp:useBean id="HotelTypeDAO" scope="page" class="com.booking.dao.DAOImpl.HotelTypeDAOImpl"/>
<jsp:useBean id="HotelDAO" scope="page" class="com.booking.dao.DAOImpl.HotelDAOImpl"/>
<jsp:useBean id="RoomDAO" scope="page" class="com.booking.dao.DAOImpl.RoomDAOImpl"/>
<jsp:useBean id="AccountDAO" scope="page" class="com.booking.dao.DAOImpl.AccountDAOImpl"/>
<jsp:useBean id="BookingStatusDAO" scope="page" class="com.booking.dao.DAOImpl.BookingStatusDAOImpl"/>
<jsp:useBean id="BookingDetailDAO" scope="page" class="com.booking.dao.DAOImpl.BookingDetailDAOIml"/>

<style>
    .contact-form-area .nav .nav-item a {
        height: 50px;
        border-radius: 0;
        font-size: 16px;
        padding-left: 2rem;
    }

    .contact-form-area .nav .nav-item a i {
        margin-bottom: 2px;
        font-size: 18px;
    }

    .nav-pills .nav-link.active,
    .nav-pills .show > .nav-link {
        background-color: darkgray;
    }

    .contact-form-area form input,
    .contact-form-area form textarea {
        font-style: normal;
        color: black;
        font-size: 16px;
        margin-bottom: 0;
        height: 30px;
        border: 0;
        border-bottom: 1px solid #ced4da;
        border-radius: unset;
    }

    .contact-form-area form .form-control:focus {
        box-shadow: none;
    }

    .form-control:disabled,
    .form-control[readonly] {
        background-color: #ffffff;
    }

    .contact-form-area form span {
        font-size: 16px;
    }
</style>

<!-- ##### Contact Form Area Start ##### -->
<section class="contact-form-area mb-100" style="margin-top: 160px;">
    <div class="container shadow py-4">
        <div class="row">
            <div class="col-3 border-right px-0">
                <ul class="nav flex-column nav-pills">
                    <li class="nav-item">
                        <a class="nav-link ${action == 'update' ? 'active' : ''} d-flex align-items-center"
                           href="<%=request.getContextPath()%>/my-account?action=loadInfor">
                            <i class="fa-solid fa-user mr-2"></i>
                            <span>Thông tin cá nhân</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link ${action == 'changePassword' ? 'active' : ''} d-flex align-items-center"
                           href="<%=request.getContextPath()%>/my-account?action=changePassword">
                            <i class="fa-solid fa-lock mr-2"></i>
                            <span>Đổi mật khẩu</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link ${action == 'bookingHistory' ? 'active' : ''} d-flex align-items-center"
                           href="<%=request.getContextPath()%>/my-account?action=bookingHistory&accountId=${sessionScope.account.accountId}">
                            <i class="fa-solid fa-clock mr-2"></i>
                            <span>Lịch sử đặt phòng</span>
                        </a>
                    </li>
                </ul>
            </div>

            <c:if test='${action == "update"}'>

                <style>
                    .date-input:disabled,
                    .date-input[readonly] {
                        background-color: transparent;
                    }

                    /*file-input*/
                    .file-drop-zone {
                        min-height: 238px;
                    }

                    .krajee-default.file-preview-frame {
                        height: 210px;
                        width: 210px;
                    }

                    .krajee-default.file-preview-frame .kv-file-content {
                        height: 100%;
                        width: 100%;
                    }

                    .file-preview-image {
                        width: 100% !important;
                        height: 100% !important;
                        object-fit: cover;
                    }

                    .file-thumbnail-footer {
                        display: none;
                    }

                    .file-caption {
                        display: none;
                    }

                    .file-preview .fileinput-remove {
                        top: 10px;
                        right: 10px;
                    }
                </style>

                <div class="col-9 pl-5">
                    <div class="w-100 mb-5">
                    <span class="h4 font-weight-bold"
                          style="border-bottom: 2px solid #ff8917;">Thông tin các nhân</span>
                    </div>
                    <form action="<%=request.getContextPath()%>/my-account?action=update" method="post"
                          enctype="multipart/form-data">
                        <div class="form-group row mb-5">
                            <div class="col-lg-2 d-flex align-items-center">
                                <span>Họ và tên</span>
                            </div>
                            <div class="col-lg-9">
                                <input type="text" class="form-control" name="fullName"
                                       value="${sessionScope.account.fullName}" placeholder="Họ và tên" required>
                            </div>
                        </div>
                        <div class="form-group row mb-5">
                            <div class="col-lg-2 d-flex align-items-center">
                                <span>Email</span>
                            </div>
                            <div class="col-lg-9">
                                <input type="text" class="form-control" name="email"
                                       value="${sessionScope.account.email}"
                                       placeholder="Địa chỉ email" required>
                            </div>
                        </div>
                        <div class="form-group row mb-5">
                            <div class="col-lg-2 d-flex align-items-center">
                                <span>Địa chỉ</span>
                            </div>
                            <div class="col-lg-9">
                                <input type="text" class="form-control" name="address"
                                       value="${sessionScope.account.address}" placeholder="Địa chỉ của bạn" required>
                            </div>
                        </div>
                        <div class="form-group row mb-5">
                            <div class="col-lg-2 d-flex align-items-center">
                                <span>Số điện thoại</span>
                            </div>
                            <div class="col-lg-9">
                                <input type="text" class="form-control" name="phone"
                                       value="${sessionScope.account.phone}"
                                       placeholder="Số điện thoại" required>
                            </div>
                        </div>
                        <div class="form-group row mb-5">
                            <div class="col-lg-2 d-flex align-items-center">
                                <span>Ngày sinh</span>
                            </div>
                            <div class="col-lg-9">
                                <input type="text" class="form-control" name="dateOfBirth"
                                       value="<fmt:formatDate value="${sessionScope.account.dateOfBirth}" pattern="dd MMM yyyy"/>"
                                       placeholder="Ngày sinh" required>
                            </div>
                        </div>
                        <div class="form-group row mb-5">
                            <div class="col-lg-2 d-flex align-items-center">
                                <span>Quốc tịch</span>
                            </div>
                            <div class="col-lg-9">
                                <input type="text" class="form-control" name="country"
                                       value="${sessionScope.account.country}" placeholder="Quốc tịch" required>
                            </div>
                        </div>
                        <div class="col-12 mb-3 px-0">
                            <span class="control-label">Ảnh đại diện</span>
                            <input name="image" id="avatar" type="file" class="file"
                                   data-browse-on-zone-click="true">
                        </div>
                        <div class="col-12 d-flex align-items-end px-0">
                            <button type="submit" class="btn palatin-btn mt-50 mr-4" style="width: 210px;">Cập nhật
                            </button>
                                ${success}
                        </div>
                    </form>
                </div>

                <script>
                    $(document).ready(function () {
                        $('#avatar').fileinput({
                            allowedFileTypes: ["image"],
                            initialPreview: ['<c:url value="/uploads/accounts/${sessionScope.account.image}"/>'],
                            initialPreviewAsData: true
                        });
                    });
                </script>
            </c:if>

            <c:if test="${action == 'changePassword'}">
                <div class="col-9 pl-5">
                    <div class="w-100 mb-5">
                    <span class="h4 font-weight-bold"
                          style="border-bottom: 2px solid #ff8917;">Đổi mật khẩu</span>
                    </div>
                    <form action="<%=request.getContextPath()%>/my-account?action=changePassword" method="post"
                          class="form-account" id="form-password">
                        <div class="form-group row mb-5">
                            <div class="col-lg-3 d-flex align-items-center">
                                <span>Email</span>
                            </div>
                            <div class="col-lg-8">
                                <input type="text" class="form-control" name="email"
                                       value="${sessionScope.account.email}"
                                       placeholder="Địa chỉ email" readonly>
                            </div>
                        </div>
                        <div class="form-group row mb-5">
                            <div class="col-lg-3 d-flex align-items-center">
                                <span>Mật khẩu hiện tại</span>
                            </div>
                            <div class="col-lg-8">
                                <input type="password" class="form-control" name="currentPassword" id="currentPassword"
                                       placeholder="Nhập mật khẩu hiện tại" required>
                            </div>
                        </div>
                        <div class="form-group row mb-5">
                            <div class="col-lg-3 d-flex align-items-center">
                                <span>Mật khẩu mới</span>
                            </div>
                            <div class="col-lg-8">
                                <input type="password" class="form-control" name="newPassword" id="newPassword"
                                       placeholder="Nhập mật khẩu mới" required>
                            </div>
                        </div>
                        <div class="form-group row mb-5">
                            <div class="col-lg-3 d-flex align-items-center">
                                <span>Xác nhận mật khẩu</span>
                            </div>
                            <div class="col-lg-8">
                                <input type="password" class="form-control" name="confirmPassword" id="confirmPassword"
                                       placeholder="Nhập lại mật khẩu mới" required>
                            </div>
                        </div>
                        <div class="col-12 d-flex align-items-end">
                            <button type="submit" class="btn palatin-btn mt-50 mr-4" style="width: 210px;">Cập nhật
                            </button>
                                ${msg}
                        </div>
                    </form>
                </div>
            </c:if>

            <c:if test="${action == 'bookingHistory'}">

                <style>
                    .booking-card .booking-card-img img {
                        object-fit: cover;
                        max-height: 164px;
                    }

                    .booking-card .booking-btn a {
                        height: 40px;
                        line-height: 40px;
                        padding: 0;
                    }
                </style>
                <div class="col-9 pl-5">
                    <div class="w-100 mb-3">
                        <span class="h4 font-weight-bold"
                              style="border-bottom: 2px solid #ff8917;">Lịch sử đặt phòng</span>
                    </div>
                    <%
                        Date[] subDateFromNow = new Date[100];
                        long[] dateDiff = new long[100];
                        int i = 0;
                        List<Booking> bookingList = (List<Booking>) request.getAttribute("bookingList");
                        for (Booking booking : bookingList) {
                            Date dateFrom = new Date(booking.getDateFrom().getTime());
                            long tmp = dateFrom.getTime() - new Date().getTime();
                            dateDiff[i] = TimeUnit.MILLISECONDS.toDays(tmp);

                            Calendar c = Calendar.getInstance();
                            c.setTime(dateFrom);
                            c.add(Calendar.DATE, -2);
                            subDateFromNow[i] = c.getTime();

                            i++;
                        }

                        request.setAttribute("dateDiff", dateDiff);
                        request.setAttribute("subDateFromNow", subDateFromNow);
                    %>
                    <c:forEach items="${bookingList}" var="o" varStatus="loop">
                        <c:forEach items="${BookingDetailDAO.getAllByBookingId(o.bookingId)}" var="bd" end="0">
                            <c:set var="room" value="${RoomDAO.getRoomByRoomId(bd.roomId)}"/>
                        </c:forEach>
                        <c:set var="hotel" value="${HotelDAO.getHotelById(room.hotelId)}"/>

                        <div class="card mb-3 booking-card">
                            <input type="hidden" value="${o.bookingId}" class="bookingId">
                            <div class="row g-0">
                                <div class="col-md-4 pr-0">
                                    <div class="booking-card-img w-100 h-100" style="padding: 1.25rem;">
                                        <a type="button" class="booking-history-btn text-primary font-weight-bold"
                                           data-toggle="modal"
                                           data-target="#booking-history-detail">
                                            <c:forTokens items="${hotel.hotelImage}" delims="|" var="img" end="0">
                                                <img class="rounded w-100 h-100"
                                                     src="<c:url value="/uploads/hotel/${img}"/>"
                                                     class="img-fluid rounded-start" alt="...">
                                            </c:forTokens>
                                        </a>
                                    </div>
                                </div>
                                <div class="col-md-5 pl-0">
                                    <div class="card-body px-0">
                                        <div>
                                            <a type="button" class="booking-history-btn text-primary font-weight-bold"
                                               data-toggle="modal"
                                               data-target="#booking-history-detail">
                                                <h5 class="hide-col text-primary card-title font-weight-bold mb-1 w-100">${hotel.hotelName}</h5>
                                            </a>
                                        </div>
                                        <p class="card-text mb-1">Ngày đặt: <fmt:formatDate value="${o.bookingDate}"
                                                                                            pattern="dd MMM yyyy"/></p>
                                        <p class="card-text mb-1">Đặt từ <span class="text-success"><fmt:formatDate
                                                value="${o.dateFrom}" pattern="dd MMM yyyy"/></span>
                                            đến <span class="text-success"><fmt:formatDate value="${o.dateTo}"
                                                                                           pattern="dd MMM yyyy"/></span>
                                        </p>
                                        <p class="card-text mb-2">Tổng giá tiền: <span
                                                class="font-weight-bold text-danger"><fmt:formatNumber
                                                value="${o.totalPrice}" type="number"/> VND</span></p>
                                        <p class="card-text mb-1">Trạng thái:
                                            <span class="${o.bookingStatusId == 1 ? "waiting" : o.bookingStatusId == 2 ? "confirmed" : o.bookingStatusId == 3 ? "refunded" : "canceled"}">
                                                    ${o.bookingStatusId == 1 ? "Chưa thanh toán" : o.bookingStatusId == 2 ? "Đã xác nhận" : o.bookingStatusId == 3 ? "Đã trả phòng" : "Đã hủy"}
                                            </span>
                                        </p>

                                        <c:if test="${dateDiff[loop.index] > 2}">
                                            <small class="text-muted">Miễn phí hủy đến
                                                <fmt:formatDate value="${subDateFromNow[loop.index]}"
                                                                pattern="dd MMM yyyy"/>
                                            </small>
                                        </c:if>
                                        <c:if test="${dateDiff[loop.index] >= 0 && dateDiff[loop.index] <= 2}">
                                            <small class="text-muted">
                                                Đã qua thời gian hủy đặt phòng
                                            </small>
                                        </c:if>
                                    </div>
                                </div>
                                <div class="col-md-3 booking-btn">
                                    <div class="px-3 py-4">
                                        <input type="hidden" value="${o.bookingId}" name="bookingId">
                                        <c:if test="${o.bookingStatusId == 1}">
                                            <a href="<%=request.getContextPath()%>/checkout?action=checkoutAgain&bookingId=${o.bookingId}"
                                               class="btn palatin-btn bg-info w-100 mb-1">Thanh toán</a>
                                        </c:if>
                                        <c:if test="${dateDiff[loop.index] > 2 && (o.bookingStatusId == 1 || o.bookingStatusId == 2)}">
                                            <a class="canceled-btn btn palatin-btn bg-secondary w-100 mb-1">Huỷ
                                                đặt</a>
                                        </c:if>
                                        <c:if test="${o.bookingStatusId == 3}">
                                            <a class="rating-btn btn palatin-btn bg-warning w-100 mb-1"
                                               data-toggle="modal"
                                               data-target="#rating-modal">Đánh giá</a>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:if>
        </div>
    </div>
</section>

<script>
    $('.booking-history-btn').on('click', function () {
        var bookingId = $(this).closest('.booking-card').find('input[name="bookingId"]').val();

        $.ajax({
            url: "my-account",
            type: "get",
            dataType: 'json',
            data: {
                action: 'loadBookingDetailModal',
                bookingId: bookingId
            },
            success: function (result) {
                $('#history-modal').html(result);
            }
        });
    })
</script>
<!-- ##### Contact Form Area End ##### -->

<script>
    $('.canceled-btn').on('click', function () {
        const bookingId = $(this).parent().find('input[name="bookingId"]').val();
        swal({
            title: "Hủy đặt phòng?",
            text: "Bạn có chắc sẽ hủy đơn đặt phòng này không!",
            buttons: true,
            dangerMode: true,
        })
            .then((willDelete) => {
                if (willDelete) {
                    $.ajax({
                        url: "checkout",
                        type: "get",
                        data: {
                            action: 'cancel',
                            bookingId: bookingId
                        },
                        success: function (result) {
                            swal({
                                title: "Đơn đặt phòng của bạn đã được hủy.",
                                icon: "success"
                            }).then((value) => {
                                location.reload();
                            });
                        }
                    });
                }
            });
    })
</script>


<!-- modal -->
<style>

    .hide-col {
        overflow: hidden;
        display: -webkit-box;
        -webkit-line-clamp: 2;
        -webkit-box-orient: vertical;
    }

    .confirmed,
    .waiting,
    .refunded,
    .canceled {
        padding: 2px 10px;
    }

    .confirmed {
        background: rgba(46, 204, 113, 0.2);
        border-color: #c4f1d7;
        color: #2ecc71;
    }

    .waiting {
        color: #7d6608;
        background-color: #fcf3cf;
        border-color: #fbeebc;
    }

    .refunded {
        color: #1b1e21;
        background-color: #d6d8d9;
        border-color: #c6c8ca;
    }

    .canceled {
        color: #78281f;
        background-color: #fadbd8;
        border-color: #f8cdc8;
    }

    .close-detail a:hover {
        font-size: 1rem;
    }

    .starrr a,
    .starrr a:hover,
    .starrr a:focus,
    .starrr a:active {
        font-size: 36px;
    }

    .starrr a {
        margin: 0 6px;
    }

    /*table*/
    .table thead th {
        white-space: nowrap;
    }

    .table td, .table th {
        vertical-align: middle;
    }
</style>
<!-- Modal -->

<div class="modal fade" id="booking-history-detail" tabindex="-1" aria-labelledby="exampleModalLabel"
     aria-hidden="true">
    <div class="modal-dialog modal-xl modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header border-0 py-0">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body px-5">
                <div id="history-modal">

                </div>
            </div>
            <div class="close-detail modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Đóng</button>
            </div>
        </div>
    </div>
</div>
<!-- modal -->

<!-- modal rating -->
<form>
    <div class="modal fade" id="rating-modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header border-0 py-0">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body px-5">
                    <div class="text-center">
                        <h5>Hãy đánh giá trải nghiệm của bạn?</h5>
                        <div class='starrr' id='star1'></div>
                        <div class="mb-4">
                            <p class='your-choice-was text-warning mt-2' style='display: none;'>
                                <span class='choice'></span>.
                            </p>
                        </div>
                        <div class="text-left">
                            <div class="form-group mb-4">
                                <label>Tiêu đề</label>
                                <input type="text" name="title" class="form-control">
                            </div>
                            <div class="form-group">
                                <label>Nội dung</label>
                                <textarea class="form-control" name="description" rows="4"></textarea>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <input type="hidden" name="bookingId">
                    <button type="button" class="rating-modal-btn btn btn-primary">Gửi đánh giá</button>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Đóng</button>
                </div>
            </div>
        </div>
    </div>
</form>
<!-- modal rating -->

<script>
    swal("Thành công!", "Đã cập nhật tài khoản", "success");
</script>

<!-- ##### Footer Area Start ##### -->
<jsp:include page="../layout/footer.jsp"/>

<script>
    let form = new Validation("form-password");
    // Validation Functions
    form.requireEmail("email", 4, 30, [" "], []);
    form.registerPassword("currentPassword", 6, 20, [" "], [], "currentPassword");
    form.registerPassword("newPassword", 6, 20, [" "], [], "confirmPassword");
</script>

<c:if test="${not empty alert}">${alert}</c:if>