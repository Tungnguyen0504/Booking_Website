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
                            <h5 class="m-b-10">${action eq 'add' ? "Thêm" : "Chỉnh sửa"} thông tin người dùng</h5>
                        </div>
                        <ul class="breadcrumb">
                            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin-index"><i
                                    class="feather icon-home"></i></a></li>
                            <li class="breadcrumb-item"><a
                                    href="${pageContext.request.contextPath}/admin-manage-account">Quản lý người
                                dùng</a></li>
                            <li class="breadcrumb-item active"
                                aria-current="page">${action eq 'add' ? "Thêm" : "Chỉnh sửa"} thông tin người dùng
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
                            <form action="<%=request.getContextPath()%>/admin-manage-account?action=addAccount"
                                  method="post" enctype="multipart/form-data"
                                  class="needs-validation" novalidate>
                                <input type="hidden" name="accountId">
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>Họ và tên</label>
                                            <input type="text" class="form-control" name="fullName"
                                                   placeholder="Nhập họ và tên ..." required>
                                            <div class="invalid-feedback">
                                                Vui lòng nhập họ và tên!
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label>Địa chỉ Email</label>
                                            <input type="email" class="form-control" name="email"
                                                   placeholder="Nhập địa chỉ email ..." required>
                                            <div class="invalid-feedback">
                                                Vui lòng nhập địa chỉ email!
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label>Mật khẩu</label>
                                            <input type="text" class="form-control" name="password"
                                                   placeholder="Nhập mật khẩu ..." required>
                                            <div class="invalid-feedback">
                                                Vui lòng nhập mật khẩu!
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
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>Số điện thoại</label>
                                            <input type="text" class="form-control" name="phone"
                                                   placeholder="Nhập số điện thoại ..." required>
                                            <div class="invalid-feedback">
                                                Vui lòng nhập số điện thoại
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label>Quốc tịch</label>
                                            <select class="form-control" name="country">
                                                <option value="Vietnam">
                                                    Vietnam
                                                </option>
                                                <option value="Albania">
                                                    Albania
                                                </option>
                                                <option value="China">
                                                    China
                                                </option>
                                                <option value="Brazil">
                                                    Brazil
                                                </option>
                                                <option value="Spain">
                                                    Spain
                                                </option>
                                                <option value="Russia">
                                                    Russia
                                                </option>
                                                <option value="Tuvalu">
                                                    Tuvalu
                                                </option>
                                                <option value="France">
                                                    France
                                                </option>
                                                <option value="Reunion">
                                                    Reunion
                                                </option>
                                            </select>
                                            <div class="invalid-feedback">
                                                Vui lòng chọn quốc tịch
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label>Ngày sinh</label>
                                            <input type="text" name="dateOfBirth" class="date-input form-control"
                                                   placeholder="Nhập ngày sinh của bạn ..." autocomplete="off" required>
                                            <div class="invalid-feedback">
                                                Vui lòng chọn ngày sinh!
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label>Là Admin</label><br>
                                            <div class="mt-2">
                                                <div class="custom-control custom-radio custom-control-inline">
                                                    <input type="radio" id="radio-add-1" name="role" value="1"
                                                           class="custom-control-input" required>
                                                    <label class="custom-control-label"
                                                           for="radio-add-1">Có</label>
                                                </div>
                                                <div class="custom-control custom-radio custom-control-inline">
                                                    <input type="radio" id="radio-add-2" name="role" value="0"
                                                           class="custom-control-input" required>
                                                    <label class="custom-control-label"
                                                           for="radio-add-2">Không</label>
                                                    <div class="invalid-feedback ml-4">
                                                        Tài khoản có phải là admin không?
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-12">
                                        <label class="control-label">Thêm ảnh đại diện</label>
                                        <input name="image" type="file" class="file"
                                               data-browse-on-zone-click="true" required>
                                        <div class="invalid-feedback">
                                            Vui lòng thêm ảnh đại diện!
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
                            <form action="<%=request.getContextPath()%>/admin-manage-account?action=updateAccount"
                                  method="post" enctype="multipart/form-data"
                                  class="needs-validation" novalidate>
                                <input type="hidden" value="${acc.accountId}" name="accountId">
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>Họ và tên</label>
                                            <input type="text" class="form-control" name="fullName"
                                                   placeholder="Nhập họ và tên ..."
                                                   value="${acc.fullName}" required>
                                            <div class="invalid-feedback">
                                                Vui lòng nhập họ và tên!
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label>Địa chỉ Email</label>
                                            <input type="email" class="form-control" name="email"
                                                   placeholder="Nhập địa chỉ email ..."
                                                   value="${acc.email}" required>
                                            <div class="invalid-feedback">
                                                Vui lòng nhập địa chỉ email!
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label>Mật khẩu</label>
                                            <input type="text" class="form-control" name="password"
                                                   placeholder="Nhập mật khẩu ..."
                                                   value="${acc.password}" required>
                                            <div class="invalid-feedback">
                                                Vui lòng nhập mật khẩu!
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label>Địa chỉ</label>
                                            <input type="text" class="form-control" name="address"
                                                   placeholder="Nhập địa chỉ ..."
                                                   value="${acc.address}" required>
                                            <div class="invalid-feedback">
                                                Vui lòng nhập địa chỉ!
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <div class="form-group">
                                                <label>Số điện thoại</label>
                                                <input type="text" class="form-control" name="phone"
                                                       placeholder="Nhập số điện thoại ..."
                                                       value="${acc.phone}" required>
                                                <div class="invalid-feedback">
                                                    Vui lòng nhập số điện thoại
                                                </div>
                                            </div>
                                            <label for="exampleFormControlSelect1">Quốc tịch</label>
                                            <select class="form-control" name="country" id="exampleFormControlSelect1">
                                                <option value="Vietnam" ${acc.country eq "Vietnam" ? "selected" : ""}>
                                                    Vietnam
                                                </option>
                                                <option value="Albania" ${acc.country eq "Albania" ? "selected" : ""}>
                                                    Albania
                                                </option>
                                                <option value="China" ${acc.country eq "China" ? "selected" : ""}>
                                                    China
                                                </option>
                                                <option value="Brazil" ${acc.country eq "Brazil" ? "selected" : ""}>
                                                    Brazil
                                                </option>
                                                <option value="Spain" ${acc.country eq "Spain" ? "selected" : ""}>
                                                    Spain
                                                </option>
                                                <option value="Russia" ${acc.country eq "Russia" ? "selected" : ""}>
                                                    Russia
                                                </option>
                                                <option value="Tuvalu" ${acc.country eq "Tuvalu" ? "selected" : ""}>
                                                    Tuvalu
                                                </option>
                                                <option value="France" ${acc.country eq "France" ? "selected" : ""}>
                                                    France
                                                </option>
                                                <option value="Reunion" ${acc.country eq "Reunion" ? "selected" : ""}>
                                                    Reunion
                                                </option>
                                            </select>
                                            <div class="invalid-feedback">
                                                Vui lòng chọn quốc tịch
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label>Ngày sinh</label>
                                            <input type="text" name="dateOfBirth" class="date-input form-control"
                                                   placeholder="Nhập ngày sinh của bạn ..."
                                                   value="<fmt:formatDate value="${acc.dateOfBirth}" pattern="dd MMM yyyy"/>">
                                            <div class="invalid-feedback">
                                                Vui lòng chọn ngày sinh!
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label>Là Admin</label><br>
                                            <div class="mt-2">
                                                <div class="custom-control custom-radio custom-control-inline">
                                                    <input type="radio" id="customRadioInline1" name="role"
                                                           class="custom-control-input"
                                                           value="1" ${acc.role eq 1 ? "checked" : ""} required>
                                                    <label class="custom-control-label"
                                                           for="customRadioInline1">Có</label>
                                                </div>
                                                <div class="custom-control custom-radio custom-control-inline">
                                                    <input type="radio" id="customRadioInline2" name="role"
                                                           class="custom-control-input"
                                                           value="0" ${acc.role eq 0 ? "checked" : ""} required>
                                                    <label class="custom-control-label"
                                                           for="customRadioInline2">Không</label>
                                                    <div class="invalid-feedback">
                                                        Tài khoản có phải là admin không?
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-12">
                                        <label class="control-label">Thêm đại diện</label>
                                        <input name="image" id="image-update" type="file" class="file"
                                               data-browse-on-zone-click="true" multiple>
                                        <div class="invalid-feedback">
                                            Vui lòng thêm ảnh đại diện!
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
                                        initialPreview: ['<c:url value="/uploads/accounts/${acc.image}"/>'],
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

<script>
    flatpickr("input[name=dateOfBirth", {
        dateFormat: "d M Y",
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
