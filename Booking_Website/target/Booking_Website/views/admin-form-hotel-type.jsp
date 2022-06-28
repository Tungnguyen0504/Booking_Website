<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.booking.util.FunctionUtil" %>

<jsp:include page="../layout/admin-header-sidebar.jsp"/>

<jsp:useBean id="AccountDAO" scope="page" class="com.booking.dao.DAOImpl.AccountDAOImpl"/>
<jsp:useBean id="BookingDAO" scope="page" class="com.booking.dao.DAOImpl.BookingDAOImpl"/>
<jsp:useBean id="RoomDAO" scope="page" class="com.booking.dao.DAOImpl.RoomDAOImpl"/>
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
                            <h5 class="m-b-10">${action eq 'add' ? "Thêm" : "Chỉnh sửa"} thông tin loại khách sạn</h5>
                        </div>
                        <ul class="breadcrumb">
                            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin-index"><i
                                    class="feather icon-home"></i></a></li>
                            <li class="breadcrumb-item"><a
                                    href="${pageContext.request.contextPath}/admin-manage-hotel-type">Quản lý loại khách sạn</a></li>
                            <li class="breadcrumb-item active"
                                aria-current="page">${action eq 'add' ? "Thêm" : "Chỉnh sửa"} thông tin loại khách sạn
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <!-- [ breadcrumb ] end -->
        <!-- [ Main Content ] start -->
        <div class="row">
            <div class="col-sm-12">
                <div class="card">
                    <div class="card-header">
                        <h5>Basic Component</h5>
                    </div>
                    <div class="card-body">

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

                        <c:if test="${action eq 'add'}">
                            <form action="<%=request.getContextPath()%>/admin-manage-hotel-type?action=addHotelType"
                                  method="post" enctype="multipart/form-data"
                                  class="needs-validation" novalidate>
                                <input type="hidden" name="hotelTypeId">
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>Tên loại khách sạn</label>
                                            <input type="text" class="form-control" name="hotelTypeName"
                                                   placeholder="Nhập tên loại khách sạn ..." required>
                                            <div class="invalid-feedback">
                                                Vui lòng nhập tên loại khách sạn!
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-12">
                                        <label class="control-label">Thêm ảnh loại khách sạn</label>
                                        <input name="image" id="image-upload" type="file" class="file"
                                               data-browse-on-zone-click="true" required>
                                        <div class="invalid-feedback">
                                            Vui lòng thêm ảnh loại khách sạn!
                                        </div>
                                    </div>
                                    <div class="col-12 mt-3">
                                        <button type="submit" class="btn btn-primary px-5">Thêm mới</button>
                                    </div>
                                </div>
                            </form>

                            <script>
                                $(document).ready(function () {
                                    $("#image-upload").fileinput({
                                        allowedFileTypes: ["image"]
                                    });
                                });
                            </script>
                        </c:if>

                        <c:if test="${action eq 'update'}">
                            <form action="<%=request.getContextPath()%>/admin-manage-hotel-type?action=updateHotelType"
                                  method="post" enctype="multipart/form-data"
                                  class="needs-validation" novalidate>
                                <input type="hidden" value="${hotelType.typeId}" name="hotelTypeId">
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>Tên loại khách sạn</label>
                                            <input type="text" class="form-control" name="hotelTypeName"
                                                   placeholder="Nhập tên loại khách sạn ..."
                                                   value="${hotelType.typeName}" required>
                                            <div class="invalid-feedback">
                                                Vui lòng nhập tên thành phố!
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-12">
                                        <label class="control-label">Thêm ảnh loại khách sạn</label>
                                        <input name="image" id="image-update" type="file" class="file"
                                               data-browse-on-zone-click="true">
                                        <div class="invalid-feedback">
                                            Vui lòng thêm ảnh loại khách sạn!
                                        </div>
                                    </div>
                                    <div class="col-12 mt-3">
                                        <button type="submit" class="btn btn-primary px-5">Cập nhật</button>
                                    </div>
                                </div>
                            </form>

                            <script>
                                $(document).ready(function () {
                                    $('#image-update').fileinput({
                                        allowedFileTypes: ["image"],
                                        initialPreview: ['<c:url value="/uploads/hotel-type/${hotelType.hotelTypeImage}"/>'],
                                        initialPreviewAsData: true
                                    });
                                });
                            </script>
                        </c:if>
                    </div>
                </div>
            </div>
            <!-- [ form-element ] start -->

            <!-- [ form-element ] end -->
        </div>
        <!-- [ Main Content ] end -->

    </div>
</section>

<jsp:include page="../layout/admin-footer.jsp"/>

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
