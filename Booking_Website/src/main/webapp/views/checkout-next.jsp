<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<jsp:include page="../layout/header.jsp"/>
<jsp:useBean id="HotelTypeDAO" scope="page" class="com.booking.dao.DAOImpl.HotelTypeDAOImpl"/>

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
            <li class="completed">
                <i class="fa-solid fa-check text-white"></i>
                <span class="bubble"></span> Chi tiết về bạn.
            </li>
            <li class="active">
                <label>3</label>
                <span class="bubble"></span> Bước cuối cùng.
            </li>
        </ul>
        <!-- progress bar -->

        <div class="row">
            <div class="col-md-4 mb-4 pr-0 order-2">
                <jsp:include page="../layout/checkout/detail-checkout.jsp"/>
            </div>

            <style>
                .payment-check {
                    padding-left: 50px;
                }

                .payment-check input[type="radio"] {
                    transform: scale(1.5)
                }

                .payment-check .payment-img {
                    width: 130px;
                }
            </style>

            <form action="<%=request.getContextPath()%>/checkout-next" method="post" class="needs-validation col-md-8 order-1 position-relative pt-3" novalidate>
                <div class="border-bottom mb-3">
                    <h4 style="border-bottom: 2px solid chocolate; width: fit-content; margin-bottom: 0;">Chọn hình thức
                        thanh toán</h4>
                </div>

                <jsp:include page="../layout/checkout/card-hotel.jsp"/>

                <div class="border p-2 mb-3 d-flex">
                    <div class="payment-check form-check d-flex align-items-center">
                        <input class="form-check-input" type="radio" name="payment" id="shopeepay"
                               value="paypal" required>
                        <label class="form-check-label d-flex align-items-center" for="shopeepay">
                            <div class="p-2 mx-2 payment-img">
                                <img class="rounded"
                                     src="<c:url value="/user/assets/img/core-img/paypal.png"/>">
                            </div>
                            <div>
                                <h5 class="mb-0">Thanh toán bằng Paypal</h5>
                                <p class="mb-0">Phí thanh toán 0đ</p>
                            </div>
                        </label>
                    </div>
                </div>

                <div class="float-right">
                    <input type="hidden" value="${hotel.hotelId}" name="hotelId">
                    <button type="submit" class="btn palatin-btn">Thanh toán</button>
                </div>
            </form>
        </div>
    </div>
</section>
<!-- ##### Rooms Area End ##### -->

<jsp:include page="../layout/footer.jsp"/>