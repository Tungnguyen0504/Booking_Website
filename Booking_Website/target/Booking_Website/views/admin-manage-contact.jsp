<%@page buffer="8192kb" autoFlush="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.booking.util.FunctionUtil" %>

<jsp:include page="../layout/admin-header-sidebar.jsp"/>

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
                            <h5 class="m-b-10">Quản lý phản hồi</h5>
                        </div>
                        <ul class="breadcrumb">
                            <li class="breadcrumb-item"><a href="<%=request.getContextPath()%>/admin-index"><i
                                    class="feather icon-home"></i></a></li>
                            <li class="breadcrumb-item">Quản lý phản hồi</li>
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
                        <h5>Quản lý phản hồi</h5>
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
                            <table class="table table-hover mb-3" id="contact-table">
                                <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Họ và tên</th>
                                    <th>Email</th>
                                    <th>Tiêu đề</th>
                                    <th>Nội dung</th>
                                    <th>Ngày gửi</th>
                                    <th>Thao tác</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${contactList}" var="contact" varStatus="loop">
                                    <tr class="row${contact.contactId}">
                                        <td>${contact.contactId}</td>
                                        <td>${contact.fullName}</td>
                                        <td>${contact.email}</td>
                                        <td>${contact.subject}</td>
                                        <td>${contact.message}</td>
                                        <td style="white-space: nowrap">
                                            <fmt:formatDate value="${contact.sentDate}" pattern="dd MMM yyyy"/>
                                        </td>
                                        <td>
                                            <div class="action-btn d-flex align-items-center">
                                                <input type="hidden" value="${contact.contactId}" name="contactId">
                                                <a class="btn-reply-modal btn btn-icon btn-info"
                                                   data-toggle="modal" data-target="#reply-modal">
                                                    <i class="fa-solid fa-envelope"></i>
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

<div class="modal fade" id="reply-modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Trả lời tin nhắn</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <textarea class="form-control w-100" name="message" rows="5" placeholder="Nhập lời nhắn ..."></textarea>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Đóng</button>
                <button type="button" class="btn-reply btn btn-primary">Gửi</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="delete-modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Xoá phản hồi</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                Bạn có chắc sẽ xóa phản hồi này không?
                Mọi hành động sẽ không thể khôi phục lại.
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Đóng</button>
                <button type="button" class="btn-delete-contact btn btn-primary">Xóa</button>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../layout/admin-footer.jsp"/>

<script>
    $(document).ready(function () {
        $('#contact-table').DataTable({
            lengthMenu: [
                [5, 10, 25, -1],
                [5, 10, 25, "All"]
            ],
        });
    });
</script>

<script>
    var contactId;
    $('.btn-reply-modal').on('click', function () {
        contactId = $(this).parent().find('input[name="contactId"]').val();
    });

    $('.btn-reply').on('click', function () {
        $.ajax({
            url: "admin-manage-contact",
            dataType: 'json',
            type: "post",
            data: {
                action: 'reply',
                contactId: contactId,
                message: $('textarea[name="message"]').val()
            },
            success: function (result) {
                if(result[0] == '0') {
                    swal("Gửi thất bại!", "Chưa gửi được tin nhắn tới địa chỉ email " + result[1] + "!", "error");
                }
                if(result[0] == '1') {
                    swal("Gửi thành công!", "Bạn đã gửi phản hồi tới địa chỉ email " + result[1] + "!", "success");
                }
            }, error: function (e) {
                console.log(e);
            }
        });
    })
</script>

<script>
    var contactId;
    $('.btn-delete-modal').on('click', function () {
        contactId = $(this).parent().find('input[name="contactId"]').val();
    });

    $('.btn-delete-contact').on('click', function () {
        $.ajax({
            url: "admin-manage-contact",
            dataType: 'json',
            type: "post",
            data: {
                action: 'deleteContact',
                contactId: contactId
            },
            success: function (result) {
                swal("Xoá thành công!", "Bạn đã xóa thành công phản hồi của người dùng " + result + "!", "success");
                $('.row' + contactId).hide();
                $('#delete-modal').modal('hide');
            }, error: function (e) {
                console.log(e);
            }
        });
    })
</script>
</body>

</html>