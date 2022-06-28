<%@page buffer="8192kb" autoFlush="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.booking.util.FunctionUtil" %>

<jsp:include page="../layout/admin-header-sidebar.jsp"/>

<jsp:useBean id="AccountDAO" scope="page" class="com.booking.dao.DAOImpl.AccountDAOImpl"/>
<jsp:useBean id="RatingDAO" scope="page" class="com.booking.dao.DAOImpl.RatingDAOImpl"/>
<jsp:useBean id="BookingDAO" scope="page" class="com.booking.dao.DAOImpl.BookingDAOImpl"/>
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
                            <h5 class="m-b-10">Quản lý phòng</h5>
                        </div>
                        <ul class="breadcrumb">
                            <li class="breadcrumb-item"><a href="<%=request.getContextPath()%>/admin-index"><i
                                    class="feather icon-home"></i></a></li>
                            <li class="breadcrumb-item">Quản lý phòng</li>
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
                        <h5>Quản lý phòng</h5>
                        <div>
                            <a href="<%=request.getContextPath()%>/admin-manage-room?action=addRoom"
                               class="btn btn-primary" style="padding: 9px 35px;">Thêm phòng mới</a>
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
                            <table class="table table-hover mb-3" id="room-table">
                                <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Loại phòng</th>
                                    <th>Khách sạn</th>
                                    <th>Diện tích</th>
                                    <th>Phù hợp cho</th>
                                    <th>Phòng bếp</th>
                                    <th>Phòng tắm</th>
                                    <th>Dịch vụ Phòng</th>
                                    <th>Hút thuốc</th>
                                    <th>View</th>
                                    <th>Giá/1 đêm</th>
                                    <th>Giảm giá</th>
                                    <th>Số lượng phòng</th>
                                    <th>Trạng thái</th>
                                    <th>Thao tác</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:set value="${0}" var="i"/>
                                <c:forEach items="${roomList}" var="room" varStatus="loop">
                                    <c:set value="${i + 1}" var="i"/>
                                    <c:set value="${HotelDAO.getHotelById(room.hotelId)}" var="hotel"/>

                                    <tr class="row${room.roomId}">
                                        <td>${room.roomId}</td>
                                        <td>
                                            <div class="d-flex align-items-center">
                                                <div id="carousel-hotel${i}" class="carousel slide mr-3"
                                                     data-ride="carousel">
                                                    <div class="carousel-inner" style="width: 160px;">
                                                        <c:forTokens items="${room.roomImage}" delims="|" var="img"
                                                                     varStatus="loop">
                                                            <div class="carousel-item ${loop.index eq 0 ? "active" : ""}"
                                                                 style="width: 160px; border-radius: 0.225rem;">
                                                                <img class="img-fluid d-block w-100"
                                                                     style="height: 80px; border-radius: 0.225rem; object-fit: cover;"
                                                                     src="<c:url value="/uploads/room/${img}"/>">
                                                            </div>
                                                        </c:forTokens>
                                                    </div>
                                                    <a class="carousel-control-prev" href="#carousel-hotel${i}"
                                                       role="button" data-slide="prev"><span
                                                            class="carousel-control-prev-icon"
                                                            aria-hidden="true"></span><span
                                                            class="sr-only">Previous</span></a>
                                                    <a class="carousel-control-next" href="#carousel-hotel${i}"
                                                       role="button" data-slide="next"><span
                                                            class="carousel-control-next-icon"
                                                            aria-hidden="true"></span><span class="sr-only">Next</span></a>
                                                </div>
                                                <div style="width: 180px;">
                                                    <h5 class="hotel-name text-primary hide-col">${room.roomType}</h5>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <div>
                                                <h5 class="hide-col mb-1"
                                                    style="width: 180px;">${hotel.hotelName}</h5>
                                                <div style="color: #febb02;">
                                                    <c:forEach begin="1" end="${hotel.star}">
                                                        <i class="fa-solid fa-star "></i>
                                                    </c:forEach>
                                                </div>
                                            </div>
                                        </td>
                                        <td class="text-center">
                                                ${room.area} m<sup>2</sup>
                                        </td>
                                        <td class="text-center">
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
                                        </td>
                                        <td>
                                                ${empty room.dinningroom ? "0" : fn:length(fn:split(room.dinningroom, '|'))}
                                            Dịch vụ
                                        </td>
                                        <td>
                                                ${empty room.bathroom ? "0" : fn:length(fn:split(room.bathroom, '|'))}
                                            Dịch vụ
                                        </td>
                                        <td>
                                                ${empty room.roomService ? "0" : fn:length(fn:split(room.roomService, '|'))}
                                            Dịch vụ
                                        </td>
                                        <td>
                                                ${room.smoke ? "Có" : "không"}
                                        </td>
                                        <td style="white-space: nowrap">
                                                ${empty room.view ? "0" : fn:length(fn:split(room.view, '|'))} Cảnh quan
                                        </td>
                                        <td class="text-center" style="white-space: nowrap;">
                                            <fmt:formatNumber value="${room.price}" type="number"/> VND
                                        </td>
                                        <td class="text-center">${room.discountPercent}%</td>
                                        <td class="text-center">${room.quantity} phòng</td>
                                        <td class="text-center">
                                            <label class="badge ${room.statusId == 0 ? "badge-secondary" : "badge-info"}"
                                                   style="font-size: 14px; font-weight: normal;">
                                                    ${room.statusId == 0 ? "Hết phòng" : "Còn phòng"}
                                            </label>
                                        </td>
                                        <td>
                                            <div class="action-btn d-flex align-items-center">
                                                <input type="hidden" value="${room.roomId}" name="roomId">
                                                <a href="<%=request.getContextPath()%>/admin-manage-room?action=loadInfor&roomId=${room.roomId}"
                                                   class="btn btn-icon btn-warning">
                                                    <i class="fa-regular fa-pen-to-square"></i>
                                                </a>
                                                <a class="btn-delete-modal btn btn-icon btn-danger"
                                                   data-toggle="modal" data-target="#delete-modal">
                                                    <i class="fa-solid fa-trash-can"></i>
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
                Bạn có chắc sẽ xóa đơn phòng này không?
                Mọi hành động sẽ không thể khôi phục lại.
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Đóng</button>
                <button type="button" class="btn-delete-room btn btn-primary">Xóa</button>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../layout/admin-footer.jsp"/>

<style>
    #room-table_filter {
        display: flex;
        justify-content: end;
    }

    .filter-room-btn {
        width: auto;
        max-width: 350px;
        margin-left: 10px;
        height: calc(1.5em + 0.5rem + 4px);
        padding: 0.25rem 1rem;
    }

    .filter-room-menu {
        max-width: 350px;
        max-height: 300px;
        overflow-y: auto;
    }
</style>

<script>
    $(document).ready(function () {
        $('#room-table').DataTable({
            lengthMenu: [
                [5, 10, 25, -1],
                [5, 10, 25, "All"]
            ],
        });

        let html = '      <div class="btn-group mb-2 mr-2 ml-2">\n' +
            '       <button class="btn btn-outline-primary dropdown-toggle filter-room-btn text-truncate" type="button" data-toggle="dropdown" aria-expanded="false">${HotelDAO.getHotelById(hotelId).hotelName}</button>\n' +
            '       <div class="dropdown-menu dropdown-menu-right filter-room-menu">\n';
        <c:forEach items="${HotelDAO.all}" var="hotel">
        html += '        <a class="dropdown-item text-truncate" href="<%=request.getContextPath()%>/admin-manage-room?hotelId=${hotel.hotelId}">${hotel.hotelName}</a>\n';
        </c:forEach>
        html += '       </div>\n' +
            '      </div>\n';

        $('#room-table_filter').append(html);
    });
</script>

<script>
    var roomId;
    $('.btn-delete-modal').on('click', function () {
        roomId = $(this).parent().find('input[name="roomId"]').val();
    });

    $('.btn-delete-room').on('click', function () {

        $.ajax({
            url: "admin-manage-room",
            dataType: 'json',
            type: "post",
            data: {
                action: 'deleteRoom',
                roomId: roomId
            },
            success: function (result) {
                swal("Xoá thành công!", "Bạn đã xóa thành công loại phòng " + result + "!", "success");
                $('.row' + roomId).hide();
                $('#delete-modal').modal('hide');
            }, error: function (e) {
                console.log(e);
            }
        });
    })
</script>
</body>

</html>