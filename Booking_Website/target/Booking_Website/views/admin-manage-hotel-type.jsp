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
                            <h5 class="m-b-10">Quản lý loại khách sạn</h5>
                        </div>
                        <ul class="breadcrumb">
                            <li class="breadcrumb-item"><a href="<%=request.getContextPath()%>/admin-index"><i
                                    class="feather icon-home"></i></a></li>
                            <li class="breadcrumb-item">Quản lý loại khách sạn</li>
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
                        <h5>Quản lý loại khách sạn</h5>
                        <div>
                            <a href="<%=request.getContextPath()%>/admin-manage-hotel-type?action=addHotelType"
                               class="btn btn-primary" style="padding: 9px 35px;">Thêm loại khách sạn</a>
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
                            <table class="table table-hover mb-3" id="hotel-type-table">
                                <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Tên loại khách sạn</th>
                                    <th>Ảnh</th>
                                    <th>Thao tác</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${hotelTypeList}" var="ht" varStatus="loop">
                                    <tr class="row${ht.typeId}">
                                        <td>${ht.typeId}</td>
                                        <td>${ht.typeName}</td>
                                        <td>
                                            <div style="width: 160px; height: 100px;">
                                                <img class="w-100 h-100 rounded"
                                                     src="<c:url value="/uploads/hotel-type/${ht.hotelTypeImage}"/>">
                                            </div>
                                        </td>
                                        <td>
                                            <div class="action-btn d-flex align-items-center">
                                                <input type="hidden" value="${ht.typeId}" name="hotelTypeId">
                                                <a href="<%=request.getContextPath()%>/admin-manage-hotel-type?action=getInfor&hotelTypeId=${ht.typeId}"
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
                <h5 class="modal-title" id="exampleModalLabel">Xoá loại khách sạn</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                Bạn có chắc sẽ xóa loại khách sạn này không?
                Mọi hành động sẽ không thể khôi phục lại.
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Đóng</button>
                <button type="button" class="btn-delete-hotel-type btn btn-primary">Xóa</button>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../layout/admin-footer.jsp"/>

<script>
    $(document).ready(function () {
        $('#hotel-type-table').DataTable({
            lengthMenu: [
                [5, 10, 25, -1],
                [5, 10, 25, "All"]
            ],
        });
    });
</script>

<script>
    var hotelTypeId;
    $('.btn-delete-modal').on('click', function () {
        hotelTypeId = $(this).parent().find('input[name="hotelTypeId"]').val();
    });

    $('.btn-delete-hotel-type').on('click', function () {
        $.ajax({
            url: "admin-manage-hotel-type",
            dataType: 'json',
            type: "post",
            data: {
                action: 'deleteHotelType',
                hotelTypeId: hotelTypeId
            },
            success: function (result) {
                swal("Xoá thành công!", "Bạn đã xóa thành công " + result + "!", "success");
                $('.row' + hotelTypeId).hide();
                $('#delete-modal').modal('hide');
            }, error: function (e) {
                console.log(e);
            }
        });
    })
</script>
</body>

</html>