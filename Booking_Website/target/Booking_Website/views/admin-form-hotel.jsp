<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.booking.util.FunctionUtil" %>

<jsp:include page="../layout/admin-header-sidebar.jsp"/>

<%--image--%>
<script>
    $(document).ready(function () {
        $('input[name="image"]').fileinput({
            allowedFileTypes: ["image"],
            <c:if test="${action eq 'update'}">
            initialPreview: [
                <c:forTokens items="${service.hotelImage}" delims="|" var="img">
                '<c:url value="/uploads/hotel/${img}"/>',
                </c:forTokens>
            ],
            </c:if>
            initialPreviewAsData: true
        });
    });
</script>

<jsp:include page="../layout/admin-footer.jsp"/>

<jsp:useBean id="AccountDAO" scope="page" class="com.booking.dao.DAOImpl.AccountDAOImpl"/>
<jsp:useBean id="BookingDAO" scope="page" class="com.booking.dao.DAOImpl.BookingDAOImpl"/>
<jsp:useBean id="RoomDAO" scope="page" class="com.booking.dao.DAOImpl.RoomDAOImpl"/>
<jsp:useBean id="CityDAO" scope="page" class="com.booking.dao.DAOImpl.CityDAOImpl"/>
<jsp:useBean id="HotelTypeDAO" scope="page" class="com.booking.dao.DAOImpl.HotelTypeDAOImpl"/>
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
                            <h5 class="m-b-10">${action eq 'add' ? "Thêm" : "Chỉnh sửa"} thông tin khách sạn</h5>
                        </div>
                        <ul class="breadcrumb">
                            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin-index"><i
                                    class="feather icon-home"></i></a></li>
                            <li class="breadcrumb-item"><a
                                    href="${pageContext.request.contextPath}/admin-manage-hotel">Quản lý khách sạn</a>
                            </li>
                            <li class="breadcrumb-item active">${action eq 'add' ? "Thêm" : "Chỉnh sửa"}
                                thông tin khách sạn
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
                            <form action="<%=request.getContextPath()%>/admin-manage-hotel?action=addHotel"
                                  method="post" enctype="multipart/form-data"
                                  class="needs-validation" novalidate>

                                <ul class="nav nav-tabs mb-3" role="tablist">
                                    <li class="nav-item">
                                        <a class="nav-link active text-uppercase"
                                           data-toggle="tab" href="#hotel1" role="tab" aria-selected="true">Thông tin
                                            khách sạn</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link text-uppercase"
                                           data-toggle="tab" href="#service1" role="tab" aria-selected="false">Chi tiết
                                            dịch vụ</a>
                                    </li>
                                </ul>
                                <div class="tab-content">
                                    <div class="tab-pane fade show active" id="hotel1" role="tabpanel">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label>Tên khách sạn</label>
                                                    <input type="text" class="form-control" name="hotelName"
                                                           placeholder="Nhập tên khách sạn ..." required>
                                                    <div class="invalid-feedback">
                                                        Vui lòng nhập tên khách sạn!
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label>Thành phố</label>
                                                    <select class="form-control" name="cityId">
                                                        <option selected disabled value="">Vui lòng chọn ...</option>
                                                        <c:forEach items="${CityDAO.all}" var="o" varStatus="loop">
                                                            <option value="${o.cityId}">
                                                                    ${o.cityName}
                                                            </option>
                                                        </c:forEach>
                                                    </select>
                                                    <div class="invalid-feedback">
                                                        Vui lòng chọn thành phố!
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label>Loại khách sạn</label>
                                                    <select class="form-control" name="hotelTypeId">
                                                        <option selected disabled value="">Vui lòng chọn ...</option>
                                                        <c:forEach items="${HotelTypeDAO.all}" var="o" varStatus="loop">
                                                            <option value="${o.typeId}">
                                                                    ${o.typeName}
                                                            </option>
                                                        </c:forEach>
                                                    </select>
                                                    <div class="invalid-feedback">
                                                        Vui lòng chọn loại khách sạn
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label>Địa chỉ</label>
                                                    <input type="text" class="form-control" name="address"
                                                           placeholder="Nhập địa chỉ ..." required>
                                                    <div class="invalid-feedback">
                                                        Vui lòng nhập địa chỉ!
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label>Số điện thoại</label>
                                                    <input type="text" class="form-control" name="phone"
                                                           placeholder="Nhập số điện thoại ..." required>
                                                    <div class="invalid-feedback">
                                                        Vui lòng nhập số điện thoại!
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label>Địa chỉ email</label>
                                                    <input type="text" class="form-control" name="email"
                                                           placeholder="Nhập địa chỉ email ..." required>
                                                    <div class="invalid-feedback">
                                                        Vui lòng nhập địa chỉ email!
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label>Mô tả khách sạn</label>
                                                    <textarea class="form-control" rows="5"
                                                              name="description"
                                                              placeholder="Nhập mô tả (dùng dấu | để xuống dòng) ..."
                                                              required
                                                              style="height: 135px;"></textarea>
                                                    <div class="invalid-feedback">
                                                        Vui lòng nhập mô tả!
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label>Giờ checkin</label>
                                                    <input type="text" name="checkin" class="date-input form-control"
                                                           placeholder="Nhập giờ checkin ..." autocomplete="off"
                                                           required>
                                                    <div class="invalid-feedback">
                                                        Vui lòng chọn giờ checkin!
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label>Giờ checkout</label>
                                                    <input type="text" name="checkout" class="date-input form-control"
                                                           placeholder="Nhập giờ checkout ..." autocomplete="off"
                                                           required>
                                                    <div class="invalid-feedback">
                                                        Vui lòng chọn giờ checkout!
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-12 mb-3">
                                                <div class="form-group">
                                                    <label>Xếp hạng sao</label><br>
                                                    <div class="starrr" id="star1"></div>
                                                    <br/>
                                                    <input type="hidden" name="star_input" value="0"/>
                                                    <div class="invalid-feedback">
                                                        Vui lòng chọn xếp hạng!
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-12 mb-3">
                                                <div class="form-group">
                                                    <label class="control-label">Địa điểm xung quanh</label>
                                                    <input name="specialAround" type="text" class="form-control"
                                                           data-role="tagsinput" required>
                                                    <div class="invalid-feedback">
                                                        Vui lòng thêm vào ô trống!
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-12 mb-3">
                                                <label class="control-label">Thêm ảnh khách sạn</label>
                                                <input name="image" type="file" class="file"
                                                       data-browse-on-zone-click="true" multiple>
                                                <div class="invalid-feedback">
                                                    Vui lòng thêm ảnh khách sạn!
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tab-pane fade" id="service1" role="tabpanel">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label class="control-label">Phòng tắm</label>
                                                    <input name="bathroom" type="text" class="form-control"
                                                           data-role="tagsinput">
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label">Phòng ngủ</label>
                                                    <input name="bedroom" type="text" class="form-control"
                                                           data-role="tagsinput">
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label">Phòng ăn</label>
                                                    <input name="dinningroom" type="text" class="form-control"
                                                           data-role="tagsinput">
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label">Ngôn ngữ</label>
                                                    <input name="language" type="text" class="form-control"
                                                           data-role="tagsinput">
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label">Internet</label>
                                                    <input name="internet" type="text" class="form-control"
                                                           data-role="tagsinput">
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label class="control-label">Dịch vụ ăn uống</label>
                                                    <input name="drinkAndFood" type="text" class="form-control"
                                                           data-role="tagsinput">
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label">Dịch vụ lễ tân</label>
                                                    <input name="receptionService" type="text" class="form-control"
                                                           data-role="tagsinput">
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label">Dịch vụ lau dọn</label>
                                                    <input name="cleaningService" type="text" class="form-control"
                                                           data-role="tagsinput">
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label">Bể bơi</label>
                                                    <input name="pool" type="text" class="form-control"
                                                           data-role="tagsinput">
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label">Dịch vụ khác</label>
                                                    <input name="other" type="text" class="form-control"
                                                           data-role="tagsinput">
                                                </div>
                                            </div>
                                            <div class="col-12 mt-3">
                                                <button type="submit" class="btn btn-primary px-5">Cập nhật</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

            </div>

            <%--star-rating--%>
            <script>
                var $s2input = $('input[name="star_input"]');
                $('#star1').starrr({
                    rating: $s2input.val(),
                    change: function (e, value) {
                        $s2input.val(value).trigger('input');
                    }
                });
            </script>

        </c:if>

        <c:if test="${action eq 'update'}">
            <div class="row">
                <div class="col-sm-12">
                    <div class="card">
                        <div class="card-header">
                            <h5>Thông tin khách sạn</h5>
                        </div>
                        <div class="card-body">
                            <form action="<%=request.getContextPath()%>/admin-manage-hotel?action=updateHotel"
                                  method="post" enctype="multipart/form-data"
                                  class="needs-validation" novalidate>
                                <input type="hidden" name="hotelId" value="${service.hotelId}">
                                <input type="hidden" name="serviceId" value="${service.serviceId}">

                                <ul class="nav nav-tabs mb-3" role="tablist">
                                    <li class="nav-item">
                                        <a class="nav-link active text-uppercase"
                                           data-toggle="tab" href="#hotel2" role="tab" aria-selected="true">Thông tin
                                            khách sạn</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link text-uppercase"
                                           data-toggle="tab" href="#service2" role="tab" aria-selected="false">Chi tiết
                                            dịch vụ</a>
                                    </li>
                                </ul>
                                <div class="tab-content">
                                    <div class="tab-pane fade show active" id="hotel2" role="tabpanel">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label>Tên khách sạn</label>
                                                    <input type="text" class="form-control" name="hotelName"
                                                           placeholder="Nhập tên khách sạn ..."
                                                           value="${service.hotelName}" required>
                                                    <div class="invalid-feedback">
                                                        Vui lòng nhập tên khách sạn!
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label>Thành phố</label>
                                                    <select class="form-control" name="cityId">
                                                        <c:forEach items="${CityDAO.all}" var="o" varStatus="loop">
                                                            <option value="${o.cityId}" ${o.cityId eq service.cityId ? "selected" : ""}>
                                                                    ${o.cityName}
                                                            </option>
                                                        </c:forEach>
                                                    </select>
                                                    <div class="invalid-feedback">
                                                        Vui lòng chọn thành phố!
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label>Loại khách sạn</label>
                                                    <select class="form-control" name="hotelTypeId">
                                                        <c:forEach items="${HotelTypeDAO.all}" var="o" varStatus="loop">
                                                            <option value="${o.typeId}" ${o.typeId eq service.hotelTypeId ? "selected" : ""}>
                                                                    ${o.typeName}
                                                            </option>
                                                        </c:forEach>
                                                    </select>
                                                    <div class="invalid-feedback">
                                                        Vui lòng chọn loại khách sạn
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label>Địa chỉ</label>
                                                    <input type="text" class="form-control" name="address"
                                                           placeholder="Nhập địa chỉ ..." value="${service.address}"
                                                           required>
                                                    <div class="invalid-feedback">
                                                        Vui lòng nhập địa chỉ!
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label>Số điện thoại</label>
                                                    <input type="text" class="form-control" name="phone"
                                                           placeholder="Nhập số điện thoại ..." value="${service.phone}"
                                                           required>
                                                    <div class="invalid-feedback">
                                                        Vui lòng nhập số điện thoại!
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label>Địa chỉ email</label>
                                                    <input type="text" class="form-control" name="email"
                                                           placeholder="Nhập địa chỉ email ..." value="${service.email}"
                                                           required>
                                                    <div class="invalid-feedback">
                                                        Vui lòng nhập địa chỉ email!
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label>Mô tả khách sạn</label>
                                                    <textarea class="form-control" rows="5"
                                                              name="description"
                                                              placeholder="Nhập mô tả (dùng dấu | để xuống dòng) ..."
                                                              required
                                                              style="height: 135px;">${service.description}</textarea>
                                                    <div class="invalid-feedback">
                                                        Vui lòng nhập mô tả!
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label>Giờ checkin</label>
                                                    <input type="text" name="checkin"
                                                           value="${service.checkin}"
                                                           class="date-input form-control"
                                                           placeholder="Nhập giờ checkin ..." autocomplete="off"
                                                           required>
                                                    <div class="invalid-feedback">
                                                        Vui lòng chọn giờ checkin!
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label>Giờ checkout</label>
                                                    <input type="text" name="checkout"
                                                           value="${service.checkout}"
                                                           class="date-input form-control"
                                                           placeholder="Nhập giờ checkout ..." autocomplete="off"
                                                           required>
                                                    <div class="invalid-feedback">
                                                        Vui lòng chọn giờ checkout!
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-12 mb-3">
                                                <div class="form-group">
                                                    <label>Xếp hạng sao</label><br>
                                                    <div class='starrr' id='star2'></div>
                                                    <br/>
                                                    <input type='hidden' name='star_input' value='${service.star}'/>
                                                    <div class="invalid-feedback">
                                                        Vui lòng chọn xếp hạng!
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-12 mb-3">
                                                <div class="form-group">
                                                    <label class="control-label">Địa điểm xung quanh</label>
                                                    <input name="specialAround" type="text" class="form-control"
                                                           data-role="tagsinput" value="${service.specialAround}"
                                                           required>
                                                </div>
                                            </div>
                                            <div class="col-12 mb-3">
                                                <label class="control-label">Thêm ảnh khách sạn</label>
                                                <input name="image" type="file" class="file"
                                                       data-browse-on-zone-click="true" multiple>
                                                <div class="invalid-feedback">
                                                    Vui lòng thêm ảnh khách sạn!
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tab-pane fade" id="service2" role="tabpanel">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label class="control-label">Phòng tắm</label>
                                                    <input name="bathroom" type="text" class="form-control"
                                                           data-role="tagsinput" value="${service.bathroom}">
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label">Phòng ngủ</label>
                                                    <input name="bedroom" type="text" class="form-control"
                                                           data-role="tagsinput" value="${service.bedroom}">
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label">Phòng ăn</label>
                                                    <c:if test="${empty service.dinningroom}">
                                                        <input name="dinningroom" type="text" class="form-control"
                                                               data-role="tagsinput">
                                                    </c:if>
                                                    <c:if test="${not empty service.dinningroom}">
                                                        <input name="dinningroom" type="text" class="form-control"
                                                               data-role="tagsinput" value="${service.dinningroom}">
                                                    </c:if>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label">Ngôn ngữ</label>
                                                    <input name="language" type="text" class="form-control"
                                                           data-role="tagsinput" value="${service.language}">
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label">Internet</label>
                                                    <input name="internet" type="text" class="form-control"
                                                           data-role="tagsinput" value="${service.internet}">
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label class="control-label">Dịch vụ ăn uống</label>
                                                    <input name="drinkAndFood" type="text" class="form-control"
                                                           data-role="tagsinput" value="${service.drinkAndFood}">
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label">Dịch vụ lễ tân</label>
                                                    <input name="receptionService" type="text" class="form-control"
                                                           data-role="tagsinput" value="${service.receptionService}">
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label">Dịch vụ lau dọn</label>
                                                    <input name="cleaningService" type="text" class="form-control"
                                                           data-role="tagsinput" value="${service.cleaningService}">
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label">Bể bơi</label>
                                                    <c:if test="${empty service.pool}">
                                                        <input name="pool" type="text" class="form-control"
                                                               data-role="tagsinput">
                                                    </c:if>
                                                    <c:if test="${not empty service.pool}">
                                                        <input name="pool" type="text" class="form-control"
                                                               data-role="tagsinput" value="${service.pool}">
                                                    </c:if>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label">Dịch vụ khác</label>
                                                    <input name="other" type="text" class="form-control"
                                                           data-role="tagsinput" value="${service.other}">
                                                </div>
                                            </div>
                                            <div class="col-12 mt-3">
                                                <button type="submit" class="btn btn-primary px-5">Cập nhật</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

            </div>

            <%--star-rating--%>
            <script>
                var $s2input = $('input[name="star_input"]');
                $('#star2').starrr({
                    rating: $s2input.val(),
                    change: function (e, value) {
                        $s2input.val(value).trigger('input');
                    }
                });
            </script>

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

<%--checkin-checkout--%>
<script>
    flatpickr('input[name="checkin"]', {
        enableTime: true,
        noCalendar: true,
        dateFormat: "H:i:S",
        time_24hr: true,
        allowInput: true,
        onReady: function (selectedDates, dateStr, instance) {
            let el = instance.element;

            function preventInput(event) {
                event.preventDefault();
                return false;
            };
            el.onkeypress = el.onkeydown = el.onkeyup = preventInput; // disable key events
            el.onpaste = preventInput; // disable pasting using mouse context menu

            el.style.caretColor = 'transparent'; // hide blinking cursor
            el.style.cursor = 'pointer'; // override cursor hover type text
        },
    });

    flatpickr('input[name="checkout"]', {
        enableTime: true,
        noCalendar: true,
        dateFormat: "H:i:S",
        time_24hr: true,
        allowInput: true,
        onReady: function (selectedDates, dateStr, instance) {
            let el = instance.element;

            function preventInput(event) {
                event.preventDefault();
                return false;
            };
            el.onkeypress = el.onkeydown = el.onkeyup = preventInput; // disable key events
            el.onpaste = preventInput; // disable pasting using mouse context menu

            el.style.caretColor = 'transparent'; // hide blinking cursor
            el.style.cursor = 'pointer'; // override cursor hover type text
        },
    });
</script>

<c:if test="${not empty alert}">${alert}</c:if>

</body>

</html>
