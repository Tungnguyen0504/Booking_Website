<%@ page import="com.booking.entity.QtyRoomPassenger" %>
<%@ page import="com.booking.entity.Item" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<c:set var="countSuitableFor" value="${0}"/>
<c:set var="countRoom" value="${0}"/>
<c:set var="price" value="${0}"/>
<c:set var="discount" value="${0}"/>
<c:forEach items="${sessionScope.items}" var="o">
    <c:set var="countSuitableFor" value="${countSuitableFor + (o.room.suitableFor * o.qtyRoom)}"/>
    <c:set var="countRoom" value="${countRoom + o.qtyRoom}"/>
    <c:set var="price" value="${price + (o.room.price * o.qtyRoom * sessionScope.subDate)}"/>
    <c:set var="discount"
           value="${discount + (o.room.price * (o.room.discountPercent / 100) * o.qtyRoom * sessionScope.subDate)}"/>
</c:forEach>

    <div class="border p-3 mb-3">
        <h5 class="d-flex justify-content-between align-items-center font-weight-bold mb-3">
            <span class="text-muted">Chi tiết đặt phòng của bạn</span>
        </h5>

        <div class="d-flex mb-3">
            <div class="col-6 pl-0 border-right">
                <div>
                    <p class="mb-1">Nhận phòng</p>
                </div>
                <div>
                    <p class="font-weight-bold mb-1"><fmt:formatDate value="${sessionScope.dateFrom}"
                                                                     pattern="dd MMM yyyy"/></p>
                </div>
                <div>
                    <p class="mb-0 text-muted">Từ 14:00</p>
                </div>
            </div>
            <div class="col-6 pr-0">
                <div>
                    <p class="mb-1">Trả phòng</p>
                </div>
                <div>
                    <p class="font-weight-bold mb-1"><fmt:formatDate value="${sessionScope.dateTo}"
                                                                     pattern="dd MMM yyyy"/></p>
                </div>
                <div>
                    <p class="mb-0 text-muted">Từ 12:00</p>
                </div>
            </div>
        </div>

        <div class="d-flex align-items-center mb-3">
            <i class="fa-solid fa-circle-exclamation mr-2"></i>
            <p class="text-warning mb-0">Chỉ
                còn ${sessionScope.subDateFromNow == 0 ? "1" : sessionScope.subDateFromNow} ngày nữa!</p>
        </div>

        <div class="border-bottom mb-3">
            <p>Tổng thời gian lưu trú: <br><strong>${sessionScope.subDate} đêm</strong></p>
        </div>

        <div class="mb-3">
            <p><strong>Bạn đã chọn:</strong><br>
                <c:forEach items="${sessionScope.items}" var="item">
                    ${item.qtyRoom} x ${item.room.roomType}<br>
                </c:forEach>
            </p>
        </div>

        <div class="mb-3">
            <p><strong>Đủ chỗ ngủ cho (tối đa):</strong> ${countSuitableFor} người lớn</p>
        </div>

        <div class="d-flex align-items-center mb-3">
            <p class="text-success mb-0"><i class="fa-regular fa-circle-check mr-2"></i>Chỗ nghỉ này vừa vặn
                nhất đấy!</p>
        </div>

        <div>
            <a class="text-primary font-weight-bold"
               href="<%=request.getContextPath()%>/room?hotelId=${hotel.hotelId}">Đổi lựa chọn của bạn</a>
        </div>
    </div>

    <div class="border p-3">
        <h5 class="d-flex justify-content-between align-items-center font-weight-bold mb-3">
            <span class="text-muted">Tóm tắt giá của bạn</span>
        </h5>

        <div class="d-flex justify-content-between mb-2">
            <div>
                <p class="mb-0">${countRoom} Phòng</p>
                <p class="mb-0 text-muted" style="font-size: 14px;">(có bao gồm giảm giá Genius)</p>
            </div>
            <div class="">
                VND <fmt:formatNumber
                    value="${price}" type="number"
                    maxFractionDigits="0"/>
            </div>
        </div>

        <div class="d-flex justify-content-between">
            <div>
                <p class="mb-0">Giảm giá</p>
            </div>
            <div>
                VND <fmt:formatNumber
                    value="${discount}"
                    type="number" maxFractionDigits="0"/>
            </div>
        </div>
    </div>

    <%
        QtyRoomPassenger qtyRoomPassenger = (QtyRoomPassenger) session.getAttribute("qtyRoomPassenger");
        List<Item> items = (List<Item>) session.getAttribute("items");

        int qtyPassenger = qtyRoomPassenger.getQtyPassenger();
        int qtyRoom = items.stream().mapToInt(Item::getQtyRoom).sum();
        if(qtyPassenger < qtyRoom) {
            qtyPassenger = qtyRoom;
            qtyRoomPassenger.setQtyPassenger(qtyPassenger);
            session.setAttribute("qtyRoomPassenger", qtyRoomPassenger);
        }
    %>

    <div class="border p-3 mb-3" style="background: #ebf3ff">
        <div class="d-flex justify-content-between">
            <div>
                <p class="font-weight-bold mb-0">Tổng cộng</p>
                <p class="mb-0 text-muted" style="font-size: 12px;">
                    (cho ${sessionScope.qtyRoomPassenger.qtyPassenger} khách và ${sessionScope.subDate} đêm
                    nghỉ)</p>
            </div>
            <div>
                            <span class="font-weight-bold">VND <fmt:formatNumber
                                    value="${price - discount}"
                                    type="number" maxFractionDigits="0"/></span>
            </div>
        </div>
    </div>

    <form>
        <div class="input-group mb-3">
            <input type="text" class="form-control" placeholder="Nhập mã giảm giá"
                   aria-label="Recipient's username" aria-describedby="basic-addon2">
            <div class="input-group-append">
                <button type="submit" class="input-group-text btn btn-primary" id="basic-addon2">Áp dụng
                </button>
            </div>
        </div>
    </form>
