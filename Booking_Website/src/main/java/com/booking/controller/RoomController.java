package com.booking.controller;

import com.booking.dao.DAOImpl.*;
import com.booking.dao.IDAO.*;
import com.booking.entity.*;
import com.booking.util.FunctionUtil;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.JsonObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.Date;
import java.util.List;

@WebServlet(urlPatterns = "/room")
public class RoomController extends HttpServlet {
    static HotelServiceDAO hotelServiceDAO = new HotelServiceDAOImpl();
    static RoomDAO roomDAO = new RoomDAOImpl();
    static RatingDAO ratingDAO = new RatingDAOImpl();
    static AccountDAO accountDAO = new AccountDAOImpl();
    static BookingDAO bookingDAO = new BookingDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();

        try {
            PrintWriter out = response.getWriter();
            ObjectMapper mapper = new ObjectMapper();

            int hotelId = Integer.parseInt(request.getParameter("hotelId"));

            HotelService hotelService = hotelServiceDAO.getHotelServiceByHotelId(hotelId);

            List<Room> roomList = new ArrayList<>();

            //set qtyBookingDetail session
            QtyRoomPassenger qtyRoomPassenger = (QtyRoomPassenger) session.getAttribute("qtyRoomPassenger");
            if (qtyRoomPassenger == null) {
                qtyRoomPassenger = QtyRoomPassenger.builder().qtyRoom(1).qtyPassenger(1).build();
            }
            session.setAttribute("qtyRoomPassenger", qtyRoomPassenger);
            int roomQty = qtyRoomPassenger.getQtyRoom();

            for (Room room : roomDAO.getListRoomByHotelId(hotelId)) {
                if (room.getQuantity() >= roomQty) {
                    roomList.add(room);
                }
            }
            //set qtyBookingDetail session

            //get hour checkin checkout
            int checkin = 0;
            int checkout = 0;

            try {
                checkin = hotelService.getCheckin().toLocalTime().getHour();
                checkout = hotelService.getCheckout().toLocalTime().getHour();
            } catch (Exception e) {
                e.printStackTrace();
            }
            //get hour checkin checkout

            //get date before dateFrom
            Date dateFrom = (Date) session.getAttribute("dateFrom");
            Date dateTo = (Date) session.getAttribute("dateTo");

            FunctionUtil.SetValueForDateFromAndDateTo(request, response, dateFrom, dateTo);

            //Rating
            String indexString = request.getParameter("index");
            if (indexString == null || indexString.trim().isEmpty()) {
                indexString = "1";
            }
            int index = 0;
            boolean check = false;
            try {
                index = Integer.parseInt(indexString);
                check = true;
            } catch (Exception e) {
                request.setAttribute("error", "Page invalid");
            }
            if (check) {
                int countRating = ratingDAO.getAllListRatingByHotelId(hotelId).size();

                int size = 5;
                int lastPage = countRating / size;
                //if total number news search indivisible size then last page add one more
                if (countRating % size != 0) {
                    lastPage++;
                }

                List<Rating> ratingList = ratingDAO.getListPaginateRatingByHotelId(hotelId, index, size);

                //paginate rating
                String action = request.getParameter("action");
                if (action != null && action.equals("paginateRating")) {
                    String content = "";

                    for (Rating rating : ratingList) {
                        content += "                        <div class=\"row mb-4\">\n" +
                                "                            <div class=\"d-flex align-items-center col-sm-3\">\n" +
                                "                                <img style=\"border-radius: 10px;\"\n" +
                                "                                     width=\"85\"\n" +
                                "                                     src=\"" + request.getContextPath() + "/uploads/accounts/" + accountDAO.getAccountById(bookingDAO.getBookingById(rating.getBookingId()).getAccountId()).getImage() + "\"\n" +
                                "                                     class=\"img-rounded\">\n" +
                                "                                <div class=\"ml-3\">\n" +
                                "                                    <div class=\"review-block-name\"><a style=\"font-size: 16px;\"\n" +
                                "                                                                      href=\"#\">" + accountDAO.getAccountById(bookingDAO.getBookingById(rating.getBookingId()).getAccountId()).getFullName() + "</a>\n" +
                                "                                    </div>\n" +
                                "                                    <div class=\"review-block-date\">" + rating.getCreatedDateFormat() + "</div>\n" +
                                "                                </div>\n" +
                                "                            </div>\n" +
                                "                            <div class=\"col-sm-9\">\n" +
                                "                                <div class=\"review-block-rate\">\n";

                        for (int i = 0; i < rating.getStarRating(); i++) {
                            content += "                            <span class=\"fa-solid fa-star\" aria-hidden=\"true\"\n" +
                                    "                                  style=\"color: #febb02; font-size: 22px;\"></span>\n";
                        }

                        content += "                                </div>\n" +
                                "                                <div class=\"review-block-title\">" + rating.getTitle() + "</div>\n" +
                                "                                <div class=\"review-block-description\">\n" +
                                "                                        " + rating.getDescription() + "\n" +
                                "                                </div>\n" +
                                "                            </div>\n" +
                                "                        </div>\n";
                    }

                    out.print(mapper.writeValueAsString(content));
                } else {

                    request.setAttribute("index", index);
                    request.setAttribute("lastPage", lastPage);
                    request.setAttribute("ratingList", ratingList);

                    request.setAttribute("checkin", checkin);  //get hour checkin checkout
                    request.setAttribute("checkout", checkout);
                    request.setAttribute("maxRoomQtyAvailable", roomList.stream().max(Comparator.comparing(room -> room.getQuantity())).get().getQuantity());
                    request.setAttribute("hotelService", hotelService);
                    request.setAttribute("roomList", roomList);
                    request.getRequestDispatcher("views/room.jsp").forward(request, response);
                }
            }
            //Rating

        } catch (SQLException e) {
            request.getRequestDispatcher("views/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        try {
            PrintWriter out = response.getWriter();
            RoomDAO roomDAO = new RoomDAOImpl();
            ObjectMapper mapper = new ObjectMapper();

            String action = request.getParameter("action");
            if (action != null && action.equals("loadRoomByAjax")) {
                int roomId = Integer.parseInt(request.getParameter("roomId"));
                Room room = roomDAO.getRoomByRoomId(roomId);

                String roomJson = "";
                try {
                    roomJson = mapper.writeValueAsString(room);
                } catch (JsonProcessingException e) {
                    e.printStackTrace();
                }

                out.print(roomJson);
            }

            if (action != null && action.equals("updateRoomByQty")) {
                int hotelId = Integer.parseInt(request.getParameter("hotelId"));

                int qtyRoom = Integer.parseInt(request.getParameter("qtyRoom"));
                int qtyPassenger = Integer.parseInt(request.getParameter("qtyPassenger"));

                QtyRoomPassenger qtyRoomPassenger = QtyRoomPassenger.builder()
                        .qtyRoom(qtyRoom)
                        .qtyPassenger(qtyPassenger)
                        .build();
                request.getSession().setAttribute("qtyRoomPassenger", qtyRoomPassenger);

                response.sendRedirect(request.getContextPath() + "/room?hotelId=" + hotelId);
            }
        } catch (SQLException e) {
            request.getRequestDispatcher("views/error.jsp").forward(request, response);
        }
    }
}
