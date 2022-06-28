<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<jsp:useBean id="HotelTypeDAO" scope="page" class="com.booking.dao.DAOImpl.HotelTypeDAOImpl"/>

<div class="border p-3 mb-3 d-flex">
    <div class="mr-3">
        <c:forTokens items="${hotel.hotelImage}" delims="|" var="img" begin="1" end="1">
            <img class="image-fluid rounded" src="<c:url value="/uploads/hotel/${img}"/>"
                 style="height: 198px; width: 198px; object-fit: cover;">
        </c:forTokens>
    </div>
    <div>
        <div class="d-flex align-items-center mb-2">
            <p class="text-muted mb-0 mr-2">${HotelTypeDAO.getHotelTypeById(hotel.hotelId)}</p>
            <div style="color: #febb02; ">
                <c:forEach begin="1" end="${hotel.star}">
                    <i class="fa-solid fa-star "></i>
                </c:forEach>
            </div>
        </div>

        <div class="mb-2">
            <h3 class="mb-0">${hotel.hotelName}</h3>
        </div>

        <div class="mb-1">
            <p class="mb-0">${hotel.address}</p>
        </div>

        <c:set var="countRate"
               value="${FunctionUtil.countRating(RatingDAO.getAllListRatingByHotelId(hotel.hotelId))}"/>
        <c:set var="ratingPoint"
               value="${FunctionUtil.countRatingPoint(RatingDAO.getAllListRatingByHotelId(hotel.hotelId))}"/>

        <div class="d-flex mb-1">
            <div class="d-flex align-items-center justify-content-center font-weight-bold mr-1"
                 style="background: #003580; height: 28px; width: 28px; border-radius:5.8181818182px 5.8181818182px 5.8181818182px 0; color: #ffffff; font-size: 13px;">
                <fmt:formatNumber
                        value="${ratingPoint}"
                        type="number" maxFractionDigits="1"/>
            </div>
            <div class="d-flex align-items-center mr-1" style="font-weight: 500;">Tuyệt hảo
            </div>
            <div class="d-flex align-items-center text-muted"
                 style="font-size: 13px;">${ratingPoint} đánh
                giá
            </div>
        </div>

        <div>
            <span class="rounded" style="border: 1px solid; padding: 0px 3px;">
                <i class="fa-solid fa-car-side mr-1"></i> Xe đưa đón sân bay
            </span>
        </div>
    </div>
</div>