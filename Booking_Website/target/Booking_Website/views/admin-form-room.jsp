<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.booking.util.FunctionUtil" %>

<jsp:include page="../layout/admin-header-sidebar.jsp"/>

<%--            image--%>
<script>
    $(document).ready(function () {
        $('input[name="roomImage"]').fileinput({
            allowedFileTypes: ["image"],

            <c:if test="${action eq 'update'}">
            initialPreview: [
                <c:forTokens items="${room.roomImage}" delims="|" var="img">
                '<c:url value="/uploads/room/${img}"/>',
                </c:forTokens>
            ],
            initialPreviewAsData: true
            </c:if>
        });
    });
</script>

<jsp:include page="../layout/admin-footer.jsp"/>

<jsp:useBean id="AccountDAO" scope="page" class="com.booking.dao.DAOImpl.AccountDAOImpl"/>
<jsp:useBean id="RatingDAO" scope="page" class="com.booking.dao.DAOImpl.RatingDAOImpl"/>
<jsp:useBean id="BookingDAO" scope="page" class="com.booking.dao.DAOImpl.BookingDAOImpl"/>
<jsp:useBean id="RoomDAO" scope="page" class="com.booking.dao.DAOImpl.RoomDAOImpl"/>
<jsp:useBean id="CityDAO" scope="page" class="com.booking.dao.DAOImpl.CityDAOImpl"/>
<jsp:useBean id="HotelTypeDAO" scope="page" class="com.booking.dao.DAOImpl.HotelTypeDAOImpl"/>
<jsp:useBean id="HotelDAO" scope="page" class="com.booking.dao.DAOImpl.HotelDAOImpl"/>
<jsp:useBean id="FunctionUtil" scope="page" class="com.booking.util.FunctionUtil"/>

<fmt:setLocale value="vi_VN"/>

<section class="pcoded-main-container">
    <div class="pcoded-content">
        <!-- [ breadcrumb ] start -->
        <div class="page-header">
            <div class="page-block">
                <div class="row align-items-center">
                    <div class="col-md-12">
                        <div class="page-header-title">
                            <h5 class="m-b-10">${action eq 'add' ? "Thêm" : "Chỉnh sửa"} thông tin phòng</h5>
                        </div>
                        <ul class="breadcrumb">
                            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin-index"><i
                                    class="feather icon-home"></i></a></li>
                            <li class="breadcrumb-item"><a
                                    href="${pageContext.request.contextPath}/admin-manage-room">Quản lý phòng</a>
                            </li>
                            <li class="breadcrumb-item active">${action eq 'add' ? "Thêm" : "Chỉnh sửa"}
                                thông tin phòng
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <!-- [ breadcrumb ] end -->
        <!-- [ Main Content ] start -->
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

            /*star-rating*/
            .starrr a,
            .starrr a:hover,
            .starrr a:focus,
            .starrr a:active {
                font-size: 25px;
            }

            .starrr a {
                margin-right: 8px;
            }

            /*tag-input*/
            .badge {
                font-size: 0.875rem;
                font-weight: normal;
            }

            .bootstrap-tagsinput .badge {
                margin: 2px 3px;
                padding: 7px 12px;
            }

            .bootstrap-tagsinput {
                background: white;
                min-height: 100px;
            }
        </style>

        <c:if test="${action eq 'add'}">
            <div class="row">
                <div class="col-sm-12">
                    <div class="card">
                        <div class="card-header">
                            <h5>Thông tin khách sạn</h5>
                        </div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-3">
                                    <div class="btn-group-vertical d-block" role="group"
                                         aria-label="Button group with nested dropdown"
                                         style="max-height: 168px; overflow-y: auto;">
                                        <c:forEach items="${hotelList}" var="o">
                                            <div>
                                                <input type="hidden" value="${o.hotelId}" name="hotelId">
                                                <button type="button"
                                                        class="btn-choose-hotel btn btn-outline-primary border-0 text-truncate text-left w-100 ${o.hotelId eq hotel.hotelId ? "active" : ""}">${o.hotelName}</button>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                                <div class="col-md-9 hotel-render">
                                    <div class="d-flex justify-content-between">
                                        <div>
                                            <div class="d-flex align-items-center mb-2">
                                                <p class="text-muted mb-0 mr-2">${HotelTypeDAO.getHotelTypeById(hotel.hotelId)}</p>
                                                <div style="color: #febb02; ">
                                                    <c:forEach begin="1" end="${hotel.star}">
                                                        <i class="fa-solid fa-star "></i>
                                                    </c:forEach>
                                                </div>
                                            </div>

                                            <div class="mb-2">
                                                <h3 class="mb-0">${hotel.hotelName}</h3>
                                            </div>

                                            <div class="mb-2">
                                                <p class="mb-0">${hotel.address}</p>
                                            </div>

                                            <c:set var="countRate"
                                                   value="${FunctionUtil.countRating(RatingDAO.getAllListRatingByHotelId(hotel.hotelId))}"/>
                                            <c:set var="ratingPoint"
                                                   value="${FunctionUtil.countRatingPoint(RatingDAO.getAllListRatingByHotelId(hotel.hotelId))}"/>

                                            <div class="d-flex mb-2">
                                                <div class="d-flex align-items-center justify-content-center font-weight-bold mr-2"
                                                     style="background: #003580; height: 28px; width: 28px; border-radius:5.8181818182px 5.8181818182px 5.8181818182px 0; color: #ffffff; font-size: 13px;">
                                                    <fmt:formatNumber value="${ratingPoint}" maxFractionDigits="1"
                                                                      type="number"/>
                                                </div>
                                                <div class="d-flex align-items-center mr-2"
                                                     style="font-weight: 500;">Tuyệt hảo
                                                </div>
                                                <div class="d-flex align-items-center text-muted"
                                                     style="font-size: 13px;">${countRate} đánh giá
                                                </div>
                                            </div>

                                            <div>
                                                <span class="rounded" style="border: 1px solid; padding: 0px 3px;">
                                                    <i class="fa-solid fa-car-side mr-1"></i> Xe đưa đón sân bay
                                                </span>
                                            </div>
                                        </div>
                                        <div class="mr-3">
                                            <div id="carousel-room1" class="carousel slide mr-3"
                                                 data-ride="carousel">
                                                <div class="carousel-inner"
                                                     style="width: 320px; border-radius: 0.225rem;">
                                                    <c:forTokens items="${hotel.hotelImage}" delims="|" var="img"
                                                                 varStatus="loop">
                                                        <div class="carousel-item ${loop.index eq 0 ? "active" : ""}"
                                                             style="width: 320px;">
                                                            <img class="img-fluid d-block w-100"
                                                                 style="height: 168px; border-radius: 0.225rem; object-fit: cover;"
                                                                 src="<c:url value="/uploads/hotel/${img}"/>">
                                                        </div>
                                                    </c:forTokens>
                                                </div>
                                                <a class="carousel-control-prev" href="#carousel-room1"
                                                   role="button" data-slide="prev"><span
                                                        class="carousel-control-prev-icon"
                                                        aria-hidden="true"></span><span
                                                        class="sr-only">Previous</span></a>
                                                <a class="carousel-control-next" href="#carousel-room1"
                                                   role="button" data-slide="next"><span
                                                        class="carousel-control-next-icon"
                                                        aria-hidden="true"></span><span class="sr-only">Next</span></a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <script>
                $('.btn-choose-hotel').on('click', function () {
                    $('.btn-choose-hotel').removeClass('active');
                    $(this).addClass('active');

                    var hotelId = $(this).parent().find('input[name="hotelId"]').val();
                    $('form input[name="hotelId"]').val(hotelId);

                    $.ajax({
                        url: "admin-manage-room",
                        dataType: 'json',
                        type: "get",
                        data: {
                            action: 'getHotel',
                            hotelId: hotelId
                        },
                        success: function (result) {
                            $('.hotel-render').html(result);
                        }, error: function (e) {
                            console.log(e);
                        }
                    });
                });
            </script>

            <div class="row">
                <div class="col-sm-12">
                    <div class="card">
                        <div class="card-header">
                            <h5>Thông tin phòng</h5>
                        </div>
                        <div class="card-body">
                            <form action="<%=request.getContextPath()%>/admin-manage-room?action=addRoom"
                                  method="post" enctype="multipart/form-data"
                                  class="needs-validation" novalidate>
                                <input type="hidden" name="hotelId" value="${hotel.hotelId}">
                                <ul class="nav nav-tabs mb-3" role="tablist">
                                    <li class="nav-item">
                                        <a class="nav-link active text-uppercase"
                                           data-toggle="tab" href="#room1" role="tab" aria-selected="true">Thông tin
                                            phòng</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link text-uppercase"
                                           data-toggle="tab" href="#service1" role="tab" aria-selected="false">Chi tiết
                                            dịch vụ đi kèm</a>
                                    </li>
                                </ul>

                                <div class="tab-content">
                                    <div class="tab-pane fade show active" id="room1" role="tabpanel">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label>Loại phòng</label>
                                                    <input type="text" class="form-control" name="roomType"
                                                           placeholder="Nhập tên loại phòng ..." required>
                                                    <div class="invalid-feedback">
                                                        Vui lòng nhập tên loại phòng!
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label>Diện tích (m2)</label>
                                                    <input type="number" class="form-control" name="area"
                                                           placeholder="Nhập diện tích m2 ..." required>
                                                    <div class="invalid-feedback">
                                                        Vui lòng nhập diện tích!
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label>Loại giường</label>
                                                    <input type="text" class="form-control" name="bed"
                                                           placeholder="Nhập loại giường ..." required>
                                                    <div class="invalid-feedback">
                                                        Vui lòng loại giường!
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label>Phù hợp cho (số người)</label>
                                                    <input type="number" class="form-control" name="suitableFor"
                                                           placeholder="Nhập số người phù hợp ..." required>
                                                    <div class="invalid-feedback">
                                                        Vui lòng nhập số người!
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label>Giá tiền cho 1 đêm</label>
                                                    <input type="number" class="form-control" name="price" min="0"
                                                           placeholder="Nhập giá phòng cho 1 đêm ..." required>
                                                    <div class="invalid-feedback">
                                                        Vui lòng nhập giá tiền!
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label>Giảm giá (%)</label>
                                                    <input type="number" class="form-control" name="discountPercent"
                                                           placeholder="Nhập giảm giá phòng (%) ...">
                                                    <div class="invalid-feedback">
                                                        Vui lòng nhập lại!
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label>Số lượng phòng</label>
                                                    <input type="number" class="form-control" name="quantity"
                                                           placeholder="Nhập số lượng ..." required>
                                                    <div class="invalid-feedback">
                                                        Vui lòng nhập số lượng phòng!
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-12">
                                                <label class="control-label">Thêm ảnh khách sạn</label>
                                                <input name="roomImage" type="file" class="file"
                                                       data-browse-on-zone-click="true" multiple>
                                                <div class="invalid-feedback">
                                                    Vui lòng thêm ảnh!
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="tab-pane fade show" id="service1" role="tabpanel">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label class="control-label">Phòng bếp</label>
                                                    <input name="dinningroom" type="text" class="form-control"
                                                           data-role="tagsinput">
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label">Phòng tắm</label>
                                                    <input name="bathroom" type="text" class="form-control"
                                                           data-role="tagsinput">
                                                </div>
                                                <div class="form-group">
                                                    <label>Hút thuốc</label><br>
                                                    <div class="mt-2">
                                                        <div class="custom-control custom-radio custom-control-inline">
                                                            <input type="radio" id="customRadioInline3" name="smoke"
                                                                   class="custom-control-input"
                                                                   value="true" required>
                                                            <label class="custom-control-label"
                                                                   for="customRadioInline3">Có</label>
                                                        </div>
                                                        <div class="custom-control custom-radio custom-control-inline">
                                                            <input type="radio" id="customRadioInline4" name="smoke"
                                                                   class="custom-control-input"
                                                                   value="false" required>
                                                            <label class="custom-control-label"
                                                                   for="customRadioInline4">Không</label>
                                                            <div class="invalid-feedback">
                                                                Vui lòng chọn 1 lựa chọn?
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label class="control-label">Dịch vụ phòng</label>
                                                    <input name="roomService" type="text" class="form-control"
                                                           data-role="tagsinput">
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label">Tầm nhìn</label>
                                                    <input name="view" type="text" class="form-control"
                                                           data-role="tagsinput">
                                                </div>
                                            </div>
                                            <div class="col-12 mt-3">
                                                <button type="submit" class="btn btn-primary px-5">Thêm phòng</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>

        <c:if test="${action eq 'update'}">
            <div class="row">
                <div class="col-sm-12">
                    <div class="card">
                        <div class="card-header">
                            <h5>Thông tin khách sạn</h5>
                        </div>
                        <div class="card-body">
                            <div class="d-flex px-4">
                                <div class="mr-3">
                                    <div id="carousel-room" class="carousel slide mr-3"
                                         data-ride="carousel">
                                        <div class="carousel-inner" style="width: 350px; border-radius: 0.225rem;">
                                            <c:forTokens items="${room.hotelImage}" delims="|" var="img"
                                                         varStatus="loop">
                                                <div class="carousel-item ${loop.index eq 0 ? "active" : ""}"
                                                     style="width: 350px;">
                                                    <img class="img-fluid d-block w-100"
                                                         style="height: 198px; border-radius: 0.225rem; object-fit: cover;"
                                                         src="<c:url value="/uploads/hotel/${img}"/>">
                                                </div>
                                            </c:forTokens>
                                        </div>
                                        <a class="carousel-control-prev" href="#carousel-room"
                                           role="button" data-slide="prev"><span
                                                class="carousel-control-prev-icon"
                                                aria-hidden="true"></span><span
                                                class="sr-only">Previous</span></a>
                                        <a class="carousel-control-next" href="#carousel-room"
                                           role="button" data-slide="next"><span
                                                class="carousel-control-next-icon"
                                                aria-hidden="true"></span><span class="sr-only">Next</span></a>
                                    </div>
                                </div>
                                <div>
                                    <div class="d-flex align-items-center mb-2">
                                        <p class="text-muted mb-0 mr-2">${HotelTypeDAO.getHotelTypeById(room.hotelId)}</p>
                                        <div style="color: #febb02; ">
                                            <c:forEach begin="1" end="${room.star}">
                                                <i class="fa-solid fa-star "></i>
                                            </c:forEach>
                                        </div>
                                    </div>

                                    <div class="mb-2">
                                        <h3 class="mb-0">${room.hotelName}</h3>
                                    </div>

                                    <div class="mb-2">
                                        <p class="mb-0">${room.address}</p>
                                    </div>

                                    <c:set var="countRate"
                                           value="${FunctionUtil.countRating(RatingDAO.getAllListRatingByHotelId(room.hotelId))}"/>
                                    <c:set var="ratingPoint"
                                           value="${FunctionUtil.countRatingPoint(RatingDAO.getAllListRatingByHotelId(room.hotelId))}"/>

                                    <div class="d-flex mb-2">
                                        <div class="d-flex align-items-center justify-content-center font-weight-bold mr-2"
                                             style="background: #003580; height: 28px; width: 28px; border-radius:5.8181818182px 5.8181818182px 5.8181818182px 0; color: #ffffff; font-size: 13px;">
                                            <fmt:formatNumber value="${ratingPoint}" maxFractionDigits="1"
                                                              type="number"/>
                                        </div>
                                        <div class="d-flex align-items-center mr-2"
                                             style="font-weight: 500;">Tuyệt hảo
                                        </div>
                                        <div class="d-flex align-items-center text-muted"
                                             style="font-size: 13px;">${countRate} đánh giá
                                        </div>
                                    </div>

                                    <div>
                                    <span class="rounded" style="border: 1px solid; padding: 0px 3px;">
                                        <i class="fa-solid fa-car-side mr-1"></i> Xe đưa đón sân bay
                                    </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-sm-12">
                    <div class="card">
                        <div class="card-header">
                            <h5>Thông tin phòng</h5>
                        </div>
                        <div class="card-body">
                            <form action="<%=request.getContextPath()%>/admin-manage-room?action=updateRoom"
                                  method="post" enctype="multipart/form-data"
                                  class="needs-validation" novalidate>
                                <input type="hidden" value="${room.roomId}" name="roomId">
                                <ul class="nav nav-tabs mb-3" role="tablist">
                                    <li class="nav-item">
                                        <a class="nav-link active text-uppercase"
                                           data-toggle="tab" href="#room2" role="tab" aria-selected="true">Thông tin
                                            phòng</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link text-uppercase"
                                           data-toggle="tab" href="#service2" role="tab" aria-selected="false">Chi tiết
                                            dịch vụ đi kèm</a>
                                    </li>
                                </ul>

                                <div class="tab-content">
                                    <div class="tab-pane fade show active" id="room2" role="tabpanel">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label>Loại phòng</label>
                                                    <input type="text" class="form-control" name="roomType"
                                                           value="${room.roomType}"
                                                           placeholder="Nhập tên loại phòng ..." required>
                                                    <div class="invalid-feedback">
                                                        Vui lòng nhập tên loại phòng!
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label>Diện tích (m2)</label>
                                                    <input type="number" class="form-control" name="area"
                                                           value="${room.area}"
                                                           placeholder="Nhập diện tích m2 ..." required>
                                                    <div class="invalid-feedback">
                                                        Vui lòng nhập diện tích!
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label>Loại giường</label>
                                                    <input type="text" class="form-control" name="bed"
                                                           value="${room.bed}"
                                                           placeholder="Nhập loại giường ..." required>
                                                    <div class="invalid-feedback">
                                                        Vui lòng loại giường!
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label>Phù hợp cho (số người)</label>
                                                    <input type="number" class="form-control" name="suitableFor"
                                                           value="${room.suitableFor}"
                                                           placeholder="Nhập số người phù hợp ..." required>
                                                    <div class="invalid-feedback">
                                                        Vui lòng nhập số người!
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label>Giá tiền cho 1 đêm</label>
                                                    <input type="number" class="form-control" name="price"
                                                           value="${room.price}" min="0"
                                                           placeholder="Nhập giá phòng cho 1 đêm ..." required>
                                                    <div class="invalid-feedback">
                                                        Vui lòng nhập giá tiền!
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label>Giảm giá (%)</label>
                                                    <input type="number" class="form-control" name="discountPercent"
                                                           value="${room.discountPercent}"
                                                           placeholder="Nhập giảm giá phòng (%) ...">
                                                    <div class="invalid-feedback">
                                                        Vui lòng nhập lại!
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label>Số lượng phòng</label>
                                                    <input type="number" class="form-control" name="quantity"
                                                           value="${room.quantity}"
                                                           placeholder="Nhập số lượng ..." required>
                                                    <div class="invalid-feedback">
                                                        Vui lòng nhập số lượng phòng!
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-12">
                                                <label class="control-label">Thêm ảnh khách sạn</label>
                                                <input name="roomImage" type="file" class="file"
                                                       data-browse-on-zone-click="true" multiple>
                                                <div class="invalid-feedback">
                                                    Vui lòng thêm ảnh!
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="tab-pane fade show" id="service2" role="tabpanel">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label class="control-label">Phòng bếp</label>
                                                    <c:if test="${not empty room.dinningroom}">
                                                        <input name="dinningroom" type="text" class="form-control"
                                                               data-role="tagsinput" value="${room.dinningroom}">
                                                    </c:if>
                                                    <c:if test="${empty room.dinningroom}">
                                                        <input name="dinningroom" type="text" class="form-control"
                                                               data-role="tagsinput">
                                                    </c:if>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label">Phòng tắm</label>
                                                    <c:if test="${not empty room.bathroom}">
                                                        <input name="bathroom" type="text" class="form-control"
                                                               data-role="tagsinput" value="${room.bathroom}">
                                                    </c:if>
                                                    <c:if test="${empty room.bathroom}">
                                                        <input name="bathroom" type="text" class="form-control"
                                                               data-role="tagsinput">
                                                    </c:if>
                                                </div>
                                                <div class="form-group">
                                                    <label>Hút thuốc</label><br>
                                                    <div class="mt-2">
                                                        <div class="custom-control custom-radio custom-control-inline">
                                                            <input type="radio" id="customRadioInline1" name="smoke"
                                                                   class="custom-control-input"
                                                                   value="true" ${room.smoke eq true ? "checked" : ""}
                                                                   required>
                                                            <label class="custom-control-label"
                                                                   for="customRadioInline1">Có</label>
                                                        </div>
                                                        <div class="custom-control custom-radio custom-control-inline">
                                                            <input type="radio" id="customRadioInline2" name="smoke"
                                                                   class="custom-control-input"
                                                                   value="false" ${room.smoke eq false ? "checked" : ""}
                                                                   required>
                                                            <label class="custom-control-label"
                                                                   for="customRadioInline2">Không</label>
                                                            <div class="invalid-feedback">
                                                                Vui lòng chọn 1 lựa chọn?
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label class="control-label">Dịch vụ phòng</label>
                                                    <c:if test="${not empty room.roomService}">
                                                        <input name="roomService" type="text" class="form-control"
                                                               data-role="tagsinput" value="${room.roomService}">
                                                    </c:if>
                                                    <c:if test="${empty room.roomService}">
                                                        <input name="roomService" type="text" class="form-control"
                                                               data-role="tagsinput">
                                                    </c:if>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label">Tầm nhìn</label>
                                                    <c:if test="${not empty room.view}">
                                                        <input name="view" type="text" class="form-control"
                                                               data-role="tagsinput" value="${room.view}">
                                                    </c:if>
                                                    <c:if test="${empty room.view}">
                                                        <input name="view" type="text" class="form-control"
                                                               data-role="tagsinput">
                                                    </c:if>
                                                </div>
                                            </div>
                                            <div class="col-12 mt-3">
                                                <button type="submit" class="btn btn-primary px-5">Cập nhật phòng
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>

    </div>
</section>

<script>
    // Validation
    (function () {
        'use strict';
        window.addEventListener('load', function () {
            // Fetch all the forms we want to apply custom Bootstrap validation styles to
            var forms = document.getElementsByClassName('needs-validation');
            // Loop over them and prevent submission
            var validation = Array.prototype.filter.call(forms, function (form) {
                form.addEventListener('submit', function (event) {
                    if (form.checkValidity() === false) {
                        event.preventDefault();
                        event.stopPropagation();
                    }
                    form.classList.add('was-validated');
                }, false);
            });
        }, false);
    })();
</script>

<c:if test="${not empty alert}">${alert}</c:if>

</body>

</html>
