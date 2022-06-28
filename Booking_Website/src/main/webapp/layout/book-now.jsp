<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- ##### Book Now Area Start ##### -->

<fmt:setLocale value="en_US"/>

<div class="book-now-area" style="height: 70px;">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-12 col-lg-10">
                <div class="book-now-form">
                    <form action="<%=request.getContextPath()%>/search-hotel" method="post">
                        <style>
                            #search-hotel-input input {
                                width: 100%;
                                height: 46px;
                                background-color: transparent;
                                border: 2px solid #cb8670;
                                padding: 0 15px;
                                color: #ffffff;
                            }

                            .book-now-form input[type="text"]::placeholder {
                                color: #ffffff;
                            }

                            #search-hotel-input input::placeholder {
                                font-size: 15px;
                            }
                        </style>
                        <div class="form-group col-6" id="search-hotel-input"
                             style="min-width: 40%; flex: none;">
                            <label for="select3">Điểm đến:</label>
                            <input type="text" name="name" placeholder="Nhập Tên chỗ nghỉ / điểm đến ..." id="select3"
                                   value="${sessionScope.name}" required>
                        </div>

                        <!-- Form Group -->
                        <div class="form-group col-3">
                            <label for="select1">Ngày nhận phòng</label>
                            <input type="text" name="datepicker1" name="dateFrom" value="<fmt:formatDate value="${sessionScope.dateFrom}" pattern="dd MMM yyyy"/>"
                                   class="form-control" id="select1"
                                   placeholder="Nhận phòng" autocomplete="off" required readonly>
                        </div>

                        <!-- Form Group -->
                        <div class="form-group col-3">
                            <label for="select2">Ngày trả phòng</label>
                            <input type="text" name="datepicker2" name="dateTo" value="<fmt:formatDate value="${sessionScope.dateTo}" pattern="dd MMM yyyy"/>"
                                   class="form-control" id="select2"
                                   placeholder="Trả phòng" autocomplete="off" required readonly style="cursor: pointer">
                        </div>

                        <!-- Button -->
                        <button type="submit">Tìm Kiếm</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- ##### Book Now Area End ##### -->