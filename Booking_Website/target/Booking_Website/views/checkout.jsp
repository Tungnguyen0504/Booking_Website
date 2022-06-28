<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="../layout/header.jsp"/>

<!-- ##### Rooms Area Start ##### -->
<section class="rooms-area pb-5" style="padding-top: 140px;">
    <div class="container shadow bg-white pb-4 pt-5 rounded">
        <!-- progress bar -->
        <style>
            .progress-indicator > li .bubble {
                width: 30px;
                height: 30px;
            }

            .progress-indicator > li .bubble:after,
            .progress-indicator > li .bubble:before {
                height: 3px;
                top: 14px;
            }

            .progress-indicator li {
                font-weight: 600;
                font-size: 14px;
            }

            .progress-indicator li i,
            .progress-indicator li label {
                position: absolute;
                top: 28%;
                left: 50%;
                transform: translate(-50%, -50%);
                z-index: 5;
                color: white;
                font-size: 16px;
            }
        </style>
        <ul class="progress-indicator">
            <li class="completed">
                <i class="fa-solid fa-check text-white"></i>
                <span class="bubble"></span> Bạn chọn.
            </li>
            <li class="active">
                <label>2</label>
                <span class="bubble"></span> Chi tiết về bạn.
            </li>
            <li>
                <label>3</label>
                <span class="bubble"></span> Bước cuối cùng.
            </li>
        </ul>
        <!-- progress bar -->

        <div class="row">
            <div class="col-md-4 mb-4 pr-0">
                <jsp:include page="../layout/checkout/detail-checkout.jsp"/>
            </div>

            <div class="col-md-8">
                <form action="<%=request.getContextPath()%>/checkout" method="post" class="needs-validation" novalidate>
                    <jsp:include page="../layout/checkout/card-hotel.jsp"/>

                    <c:forEach items="${sessionScope.items}" var="item">
                        <div class="border p-3 mb-3" style="background: #ebf3ff">
                            <h4 class="mb-3">${item.room.roomType}</h4>
                            <c:if test="${sessionScope.subDateFromNow > 2}">
                                <div class="mb-3 d-flex align-items-center">
                                    <i class="fa-regular fa-circle-check text-success mr-2"
                                       style="font-size: 20px;"></i>
                                    <p class="mb-0 text-success"><strong>Miễn phí hủy</strong> đến <fmt:formatDate
                                            value="${sessionScope.minusDateFrom}" pattern="dd-MMM-yyyy"/>
                                    </p>
                                </div>
                            </c:if>
                            <c:if test="${sessionScope.subDateFromNow <= 2}">
                                <div class="mb-3 d-flex align-items-center">
                                    <i class="fa-solid fa-circle-exclamation text-warning mr-2"
                                       style="font-size: 20px;"></i>
                                    <p class="mb-0 text-warning">Không hỗ trợ hủy phòng sau khi đặt</p>
                                </div>
                            </c:if>

                            <div class="mb-3 d-flex align-items-center">
                                <i class="fa-solid fa-ban-smoking mr-2" style="font-size: 20px;"></i>
                                <span>${item.room.smoke == false ? "Không" : "Có"} hút thuốc</span>
                            </div>

                            <div class="mb-3">
                                <style>
                                    .service-box {
                                        display: inline-flex;
                                        margin-bottom: 3px;
                                    }

                                    .service-box span {
                                        padding: 0px 2px;
                                        border: 1px solid #949494;
                                        border-radius: 2px;
                                    }
                                </style>
                                <div class="mb-3">
                                    <div class="service-box">
                                <span class="text-success"><i
                                        class="fa-solid fa-house"></i>${item.room.area} m<sup>2</sup></span>
                                    </div>
                                    <div class="service-box">
                                    <span class="text-success"><i
                                            class="fa-solid fa-droplet"></i>Điều hòa không khí</span>
                                    </div>
                                    <div class="service-box">
                                        <span class="text-success"><i
                                                class="fa-solid fa-bath"></i>Phòng tắm riêng</span>
                                    </div>
                                    <div class="service-box">
                                        <span class="text-success"><i
                                                class="fa-solid fa-tv"></i>TV màn hình phẳng</span>
                                    </div>
                                    <div class="service-box">
                                <span class="text-success"><i
                                        class="fa-solid fa-volume-xmark"></i>Hệ thống cách âm</span>
                                    </div>
                                    <div class="service-box">
                                        <span class="text-success"><i class="fa-solid fa-wifi"></i>WiFi miễn phí</span>
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <p class="text-dark m-0" style="font-size: 15px;"><strong>Phù hợp cho: </strong>
                                        <c:if test="${item.room.suitableFor > 2}">
                                            ${item.room.suitableFor} x <i class="fa-solid fa-user"></i>
                                        </c:if>
                                        <c:if test="${item.room.suitableFor <= 2}">
                                            <i class="fa-solid fa-user"></i><i class="fa-solid fa-user"></i>
                                        </c:if>
                                    </p>
                                </div>

                                <div>
                                    <a class="text-primary font-weight-bold"
                                       href="<%=request.getContextPath()%>/room?hotelId=${item.room.hotelId}">Đổi lựa chọn
                                        của
                                        bạn</a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>

                    <div class="border p-3 mb-3" style="background: #ebf3ff">
                        <h4 class="mb-3">Nhập thông tin chi tiết của bạn</h4>
                        <div class="mb-3">
                            <span class="text-success mb-2" style="background: #d2edd5; padding: .4em .8em;">Gần xong rồi! Chỉ cần điền phần thông tin * bắt buộc</span>
                        </div>
                        <div class="mb-3">
                            <label for="fullName">Họ tên *</label>
                            <input type="text" class="form-control" id="fullName" name="fullName"
                                   value="${sessionScope.account.fullName}" placeholder="Nhập họ và tên" required>
                            <div class="invalid-feedback">
                                Họ tên không được để trống.
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="email">Địa chỉ email * </label>
                            <input type="email" class="form-control" id="email" name="email"
                                   value="${sessionScope.account.email}"
                                   placeholder="you@example.com" required>
                            <div class="invalid-feedback">
                                Địa chỉ email không hợp lệ.
                            </div>
                            <label class="text-muted" style="font-size: 13px;">
                                Email xác nhận đặt phòng sẽ được gửi đến địa chỉ này
                            </label>
                        </div>

                        <div class="mb-3">
                            <label for="phone">Số điện thoại * </label>
                            <input type="text" class="form-control" id="phone" name="phone"
                                   value="${sessionScope.account.phone}"
                                   placeholder="Nhập số điện thoại"
                                   required>
                            <div class="invalid-feedback">
                                Số điện thoại không hợp lệ.
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="address">Địa chỉ *</label>
                            <input type="text" class="form-control" id="address" name="address"
                                   value="${sessionScope.account.address}"
                                   placeholder="Nhập địa chỉ" required>
                            <div class="invalid-feedback">
                                Địa chỉ không hợp lệ.
                            </div>
                        </div>
                    </div>

                    <div class="border p-3 mb-3" style="background: #ebf3ff">
                        <h4 class="mb-3">Các Yêu Cầu Đặc Biệt</h4>
                        <div class="mb-3">
                            <p class="mb-0">
                                Các yêu cầu đặc biệt không đảm bảo sẽ được đáp ứng – tuy nhiên, chỗ nghỉ sẽ cố gắng hết
                                sức
                                để thực hiện. Bạn luôn có thể gửi yêu cầu đặc biệt sau khi hoàn tất đặt phòng của mình!
                            </p>
                        </div>

                        <div class="mb-3">
                            <div class="mb-2">
                                <strong>Vui lòng ghi yêu cầu của bạn tại đây. <small>(không bắt buộc)</small></strong>
                            </div>
                            <div class="form-floating">
                                <textarea class="form-control" id="floatingTextarea2" rows="4" name="note"></textarea>
                            </div>
                        </div>
                    </div>

                    <div class="border p-3 mb-3" style="background: #ebf3ff">
                        <h4 class="mb-3">Thời gian đến của bạn</h4>

                        <div class="mb-3 d-flex align-items-center">
                            <i class="fa-regular fa-circle-check text-success mr-2" style="font-size: 20px;"></i>
                            <p class="mb-0 text-success">Các phòng của bạn sẽ sẵn sàng để nhận vào lúc 14:00 </p>
                        </div>

                        <div class="mb-3 d-flex align-items-center">
                            <i class="fa-solid fa-bell-concierge text-success mr-2" style="font-size: 20px;"></i>
                            <p class="mb-0 text-success">Lễ tân 24 giờ - Luôn có trợ giúp mỗi khi bạn cần! </p>
                        </div>

                        <div class="mb-3">
                            <div class="mb-2">
                                <strong>Thêm thời gian đến dự kiến của bạn. </strong>
                            </div>
                            <div>
                                <style>
                                    .nice-select {
                                        width: 100%;
                                        height: 38px;
                                        line-height: 38px;
                                    }

                                    .nice-select:after {
                                        display: none;
                                    }

                                    .nice-select .list {
                                        max-height: 300px;
                                        overflow: auto;
                                    }
                                </style>
                                <div class="d-flex flex-column">
                                    <select class="col w-50" name="timeCheckin" required>
                                        <option selected disabled value="">Vui lòng chọn ...</option>
                                        <option value="Tôi không biết">Tôi không biết</option>
                                        <option value="00:00 - 01:00">00:00 - 01:00</option>
                                        <option value="01:00 - 02:00">01:00 - 02:00</option>
                                        <option value="02:00 - 03:00">02:00 - 03:00</option>
                                        <option value="03:00 - 04:00">03:00 - 04:00</option>
                                        <option value="04:00 - 05:00">04:00 - 05:00</option>
                                        <option value="05:00 - 06:00">05:00 - 06:00</option>
                                        <option value="06:00 - 07:00">06:00 - 07:00</option>
                                        <option value="07:00 - 08:00">07:00 - 08:00</option>
                                        <option value="08:00 - 09:00">08:00 - 09:00</option>
                                        <option value="09:00 - 10:00">09:00 - 10:00</option>
                                        <option value="10:00 - 11:00">10:00 - 11:00</option>
                                        <option value="11:00 - 12:00">11:00 - 12:00</option>
                                        <option value="12:00 - 13:00">12:00 - 13:00</option>
                                        <option value="13:00 - 14:00">13:00 - 14:00</option>
                                        <option value="14:00 - 15:00">14:00 - 15:00</option>
                                        <option value="15:00 - 16:00">15:00 - 16:00</option>
                                        <option value="16:00 - 17:00">16:00 - 17:00</option>
                                        <option value="17:00 - 18:00">17:00 - 18:00</option>
                                        <option value="18:00 - 19:00">18:00 - 19:00</option>
                                        <option value="19:00 - 20:00">19:00 - 20:00</option>
                                        <option value="20:00 - 21:00">20:00 - 21:00</option>
                                        <option value="21:00 - 22:00">21:00 - 22:00</option>
                                        <option value="22:00 - 23:00">22:00 - 23:00</option>
                                        <option value="23:00 - 24:00">23:00 - 24:00</option>
                                    </select>
                                    <div class="invalid-feedback">
                                        Vui lòng hêm thời gian đến dự kiến của bạn.
                                    </div>
                                    <div>
                                        <small style="margin-left: 10px;;">Thời gian theo múi giờ của Hà Nội</small>
                                    </div>
                                </div>
                            </div>

                        </div>

                    </div>

                    <div class="float-right">
                        <input type="hidden" name="hotelId" value="${hotel.hotelId}">
                        <button type="submit" class="btn palatin-btn">Tiếp theo: chi tiết cuối cùng</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</section>
<!-- ##### Rooms Area End ##### -->

<jsp:include page="../layout/footer.jsp"/>