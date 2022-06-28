<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.booking.util.FunctionUtil" %>

<jsp:include page="../layout/admin-header-sidebar.jsp"/>

<jsp:useBean id="AccountDAO" scope="page" class="com.booking.dao.DAOImpl.AccountDAOImpl"/>
<jsp:useBean id="RatingDAO" scope="page" class="com.booking.dao.DAOImpl.RatingDAOImpl"/>
<jsp:useBean id="BookingDAO" scope="page" class="com.booking.dao.DAOImpl.BookingDAOImpl"/>
<jsp:useBean id="RoomDAO" scope="page" class="com.booking.dao.DAOImpl.RoomDAOImpl"/>
<jsp:useBean id="CityDAO" scope="page" class="com.booking.dao.DAOImpl.CityDAOImpl"/>
<jsp:useBean id="HotelTypeDAO" scope="page" class="com.booking.dao.DAOImpl.HotelTypeDAOImpl"/>
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
                            <h5 class="m-b-10">Quản lý khách sạn</h5>
                        </div>
                        <ul class="breadcrumb">
                            <li class="breadcrumb-item"><a href="<%=request.getContextPath()%>/admin-index"><i
                                    class="feather icon-home"></i></a></li>
                            <li class="breadcrumb-item">Quản lý khách sạn</li>
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
                            <a href="<%=request.getContextPath()%>/admin-manage-hotel?action=addHotel"
                               class="btn btn-primary" style="padding: 9px 35px;">Thêm khách sạn</a>
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

                        /*carousel*/
                        .carousel .carousel-item img {
                            width: 160px !important;
                            height: 80px;
                            object-fit: cover;
                        }

                        .carousel .carousel-item {
                            border-radius: 0.625rem;
                        }

                        .td-address p, .hotel-name {
                            overflow: hidden;
                            display: -webkit-box;
                            -webkit-line-clamp: 2;
                            -webkit-box-orient: vertical;
                            border-radius: 0.625rem;
                        }
                    </style>

                    <div class="card-body p-3">
                        <div class="table table-responsive">
                            <table class="table table-hover mb-3" id="hotel-table">
                                <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Khách sạn</th>
                                    <th>Thành phố</th>
                                    <th>Loại khách sạn</th>
                                    <th>Địa chỉ</th>
                                    <th>Số điện thoại</th>
                                    <th>Email</th>
                                    <th>Điểm đánh giá</th>
                                    <th>Ngày thêm</th>
                                    <th>Thao tác</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:set value="${0}" var="i"/>
                                <c:forEach items="${hotelList}" var="hotel" varStatus="loop">

                                    <c:set value="${i + 1}" var="i"/>
                                    <tr class="row${hotel.hotelId}">
                                        <td>${hotel.hotelId}</td>
                                        <td>
                                            <div class="d-flex align-items-center">
                                                <div id="carousel-hotel${i}" class="carousel slide mr-3"
                                                     data-ride="carousel">
                                                    <div class="carousel-inner" style="width: 160px;">
                                                        <c:forTokens items="${hotel.hotelImage}" delims="|" var="img"
                                                                     varStatus="loop">
                                                            <div class="carousel-item ${loop.index eq 0 ? "active" : ""}"
                                                                 style="width: 160px;">
                                                                <img class="img-fluid d-block w-100"
                                                                     src="<c:url value="/uploads/hotel/${img}"/>"
                                                                     alt="<c:url value="/uploads/hotel/${img}"/>">
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
                                                    <h5 class="hotel-name">${hotel.hotelName}</h5>
                                                    <div style="color: #febb02; ">
                                                        <c:forEach begin="1" end="${hotel.star}">
                                                            <i class="fa-solid fa-star "></i>
                                                        </c:forEach>
                                                    </div>
                                                </div>
                                            </div>
                                        </td>
                                        <td class="text-center">${CityDAO.getCityNameById(hotel.cityId)}</td>
                                        <td class="text-center">${HotelTypeDAO.getHotelTypeById(hotel.hotelTypeId)}</td>
                                        <td class="td-address">
                                            <p style="width: 200px; margin-bottom: 0;">${hotel.address}</p>
                                        </td>
                                        <td>${hotel.phone}</td>
                                        <td>${hotel.email}</td>
                                        <td class="text-center">
                                            <fmt:formatNumber
                                                    value="${FunctionUtil.countRatingPoint(RatingDAO.getAllListRatingByHotelId(hotel.hotelId))}"
                                                    type="number" maxFractionDigits="1"/> điểm<br>
                                            (${FunctionUtil.countRating(RatingDAO.getAllListRatingByHotelId(hotel.hotelId))}
                                            đánh giá)
                                        </td>
                                        <td style="white-space: nowrap"><fmt:formatDate value="${hotel.createdDate}"
                                                                                        pattern="dd MMM yyyy"/></td>
                                        <td>
                                            <div class="action-btn d-flex align-items-center">
                                                <input type="hidden" value="${hotel.hotelId}" name="hotelId">
                                                <a href="<%=request.getContextPath()%>/admin-manage-hotel?action=loadInfor&hotelId=${hotel.hotelId}"
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
                Bạn có chắc sẽ xóa khách sạn này không?
                Mọi hành động sẽ không thể khôi phục lại.
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Đóng</button>
                <button type="button" class="btn-delete-hotel btn btn-primary">Xóa</button>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../layout/admin-footer.jsp"/>

<script>
    $(document).ready(function () {
        $('#hotel-table').DataTable({
            lengthMenu: [
                [5, 10, 25, -1],
                [5, 10, 25, "All"]
            ],
        });
    });
</script>

<script>
    var hotelId;
    $('.btn-delete-modal').on('click', function () {
        hotelId = $(this).parent().find('input[name="hotelId"]').val();
    });

    $('.btn-delete-hotel').on('click', function () {
        $.ajax({
            url: "admin-manage-hotel",
            dataType: 'json',
            type: "post",
            data: {
                action: 'deleteHotel',
                hotelId: hotelId
            },
            success: function (result) {
                swal("Xoá thành công!", "Bạn đã xóa thành công khách sạn " + result + "!", "success");
                $('.row' + hotelId).hide();
                $('#delete-modal').modal('hide');
            }, error: function (e) {
                console.log(e);
            }
        });
    })
</script>
</body>

</html>