<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.booking.util.FunctionUtil" %>

<jsp:include page="../layout/admin-header-sidebar.jsp"/>

<jsp:include page="../layout/admin-footer.jsp"/>

<jsp:useBean id="AccountDAO" scope="page" class="com.booking.dao.DAOImpl.AccountDAOImpl"/>
<jsp:useBean id="BookingDAO" scope="page" class="com.booking.dao.DAOImpl.BookingDAOImpl"/>
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
                            <h5 class="m-b-10">Quản lý người dùng</h5>
                        </div>
                        <ul class="breadcrumb">
                            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin-index"><i
                                    class="feather icon-home"></i></a></li>
                            <li class="breadcrumb-item active" aria-current="page">Quản lý người dùng</li>
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
                        <h5>Quản lý Người dùng</h5>
                        <div>
                            <a href="<%=request.getContextPath()%>/admin-manage-account?action=addAccount"
                               class="btn btn-primary" style="padding: 9px 35px;">Thêm tài khoản</a>
                        </div>
                    </div>

                    <style>
                        .table td, .table th {
                            white-space: nowrap;
                            vertical-align: middle;
                        }

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

                        #account-table_wrapper {
                            margin-bottom: 15px;
                        }
                    </style>

                    <div class="card-body p-3">
                        <div class="table table-responsive">
                            <table class="table table-hover mb-0" id="account-table">
                                <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Họ và tên</th>
                                    <th>Email</th>
                                    <th>Địa chỉ</th>
                                    <th>Số điện thoại</th>
                                    <th>Ngày sinh</th>
                                    <th>Quốc tịch</th>
                                    <th>Admin</th>
                                    <th>Thao tác</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${accountList}" var="acc" varStatus="loop">
                                    <tr class="row${acc.accountId}">
                                        <td>${acc.accountId}</td>
                                        <td>
                                            <div class="d-flex">
                                                <img src="<c:url value="/uploads/accounts/${acc.image}"/>"
                                                     alt="user image" width="45" height="45"
                                                     class="img-radius align-top m-r-15" style="object-fit: cover;">
                                                <div class="d-flex align-items-center">
                                                    <h6 class="mb-0">${acc.fullName}</h6>
                                                </div>
                                            </div>
                                        </td>
                                        <td>${acc.email}</td>
                                        <td>${acc.address}</td>
                                        <td>${acc.phone}</td>
                                        <td><fmt:formatDate value="${acc.dateOfBirth}" pattern="dd MMM yyyy"/></td>
                                        <td>${acc.country}</td>
                                        <td class="text-center">
                                            <div class="custom-control custom-checkbox">
                                                <input type="checkbox" class="custom-control-input"
                                                       id="customCheck1" readonly ${acc.role eq 0 ? "" : "checked"}>
                                                <label class="custom-control-label" for="customCheck1"></label>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="action-btn d-flex align-items-center">
                                                <input type="hidden" value="${acc.accountId}" name="accountId">
                                                <a href="<%=request.getContextPath()%>/admin-manage-account?action=getInfor&accountId=${acc.accountId}"
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
                <h5 class="modal-title" id="exampleModalLabel">Xoá tài khoản</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                Bạn có chắc sẽ xóa người dùng này không?
                Mọi hành động sẽ không thể khôi phục lại.
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Đóng</button>
                <button type="button" class="btn-delete-account btn btn-primary">Xóa</button>
            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function () {
        $('#account-table').DataTable({
            lengthMenu: [
                [5, 10, 25, -1],
                [5, 10, 25, "All"]
            ],
        });
    });

    var accountId;
    $('.btn-delete-modal').on('click', function () {
        accountId = $(this).parent().find('input[name="accountId"]').val();
    });

    $('.btn-delete-account').on('click', function () {
        $.ajax({
            url: "admin-manage-account",
            dataType: 'json',
            type: "post",
            data: {
                action: 'deleteAccount',
                accountId: accountId
            },
            success: function (result) {
                swal("Xoá thành công!", "Bạn đã xóa thành công người dùng " + result + "!", "success");
                $('.row' + accountId).hide();
                $('#delete-modal').modal('hide');
            }, error: function (e) {
                console.log(e);
            }
        });
    })
</script>
</body>

</html>