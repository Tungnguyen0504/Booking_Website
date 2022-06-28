package com.booking.controller;

import com.booking.dao.DAOImpl.BookingDAOImpl;
import com.booking.dao.DAOImpl.BookingDetailDAOIml;
import com.booking.dao.DAOImpl.HotelDAOImpl;
import com.booking.dao.DAOImpl.RoomDAOImpl;
import com.booking.dao.IDAO.BookingDAO;
import com.booking.dao.IDAO.BookingDetailDAO;
import com.booking.dao.IDAO.HotelDAO;
import com.booking.dao.IDAO.RoomDAO;
import com.booking.entity.Booking;
import com.booking.entity.BookingDetail;
import com.booking.entity.Room;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.Comparator;
import java.util.List;

@WebServlet(urlPatterns = "/admin-manage-booking")
public class AdminManageBookingController extends HttpServlet {

    static BookingDAO bookingDAO = new BookingDAOImpl();
    static BookingDetailDAO bookingDetailDAO = new BookingDetailDAOIml();
    static HotelDAO hotelDAO = new HotelDAOImpl();
    static RoomDAO roomDAO = new RoomDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String action = request.getParameter("action");
        if (action == null) {
            doGet_index(request, response);
        }
        if (action != null && action.equals("loadBookingDetailModal")) {
            doGet_loadBookingDetailModal(request, response);
        }
    }

    private void doGet_loadBookingDetailModal(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int bookingId = Integer.parseInt(request.getParameter("bookingId"));

            List<BookingDetail> bookingDetailList = bookingDetailDAO.getAllByBookingId(bookingId);

            PrintWriter out = response.getWriter();
            ObjectMapper mapper = new ObjectMapper();

            String content = "                        <table class=\"table table-hover mb-3\">\n" +
                    "                            <thead>\n" +
                    "                            <tr>\n" +
                    "                                <th>#</th>\n" +
                    "                                <th>Loại phòng</th>\n" +
                    "                                <th>Khách sạn</th>\n" +
                    "                                <th>Loại giường</th>\n" +
                    "                                <th>Số lượng phòng</th>\n" +
                    "                                <th>Tổng giá</th>\n" +
                    "                                <th>Ngày đặt phòng</th>\n" +
                    "                                <th>Ngày nhận phòng</th>\n" +
                    "                                <th>Ngày trả</th>\n" +
                    "                                <th>Phương thức thanh toán</th>\n" +
                    "                            </tr>\n" +
                    "                            </thead>\n" +
                    "                            <tbody>\n";

            NumberFormat format = NumberFormat.getNumberInstance();
            format.setMaximumFractionDigits(0);
            SimpleDateFormat df = new SimpleDateFormat("dd MMM yyyy");

            int index = 0;
            for (BookingDetail detail : bookingDetailList) {
                Room room = roomDAO.getRoomByRoomId(detail.getRoomId());
                Booking booking = bookingDAO.getBookingById(detail.getBookingId());

                content += "                                <tr>\n" +
                        "                                    <td>" + (++index) + "</td>\n" +
                        "                                    <td>\n" +
                        "                                        <div class=\"d-flex align-items-center\">\n" +
                        "                                            <div id=\"carousel-hotel" + index + "\" class=\"carousel slide mr-3\"\n" +
                        "                                                 data-ride=\"carousel\">\n" +
                        "                                                <div class=\"carousel-inner\" style=\"width: 160px;\">\n";

                String[] roomImage = room.getRoomImage().split("\\|");
                for (int i = 0; i < roomImage.length; i++) {
                    content += "                                                        <div class=\"carousel-item " + (i == 0 ? "active" : "") + "\"\n" +
                            "                                                             style=\"width: 160px; border-radius: 0.225rem;\">\n" +
                            "                                                            <img class=\"img-fluid d-block w-100\"\n" +
                            "                                                                 style=\"height: 80px; border-radius: 0.225rem; object-fit: cover;\"\n" +
                            "                                                                 src=\"" + request.getContextPath() + "/uploads/room/" + roomImage[i] + "\">\n" +
                            "                                                        </div>\n";
                }
                content += "                                                </div>\n" +
                        "                                                <a class=\"carousel-control-prev\" href=\"#carousel-hotel" + index + "\"\n" +
                        "                                                   role=\"button\" data-slide=\"prev\"><span\n" +
                        "                                                        class=\"carousel-control-prev-icon\"\n" +
                        "                                                        aria-hidden=\"true\"></span><span\n" +
                        "                                                        class=\"sr-only\">Previous</span></a>\n" +
                        "                                                <a class=\"carousel-control-next\" href=\"#carousel-hotel" + index + "\"\n" +
                        "                                                   role=\"button\" data-slide=\"next\"><span\n" +
                        "                                                        class=\"carousel-control-next-icon\"\n" +
                        "                                                        aria-hidden=\"true\"></span><span class=\"sr-only\">Next</span></a>\n" +
                        "                                            </div>\n" +
                        "                                            <div style=\"width: 180px;\">\n" +
                        "                                                <h5 class=\"hotel-name text-primary hide-col\">" + room.getRoomType() + "</h5>\n" +
                        "                                            </div>\n" +
                        "                                        </div>\n" +
                        "                                    </td>\n" +
                        "                                    <td>\n" +
                        "                                            <div>\n" +
                        "                                                <h6 class=\"hide-col mb-1\"\n" +
                        "                                                    style=\"width: 180px;\">" + room.getHotelName() + "</h6>\n" +
                        "                                                <div style=\"color: #febb02;\">\n";

                for (int i = 0; i < room.getStar(); i++) {
                    content += "                                                        <i class=\"fa-solid fa-star \"></i>\n";
                }

                content += "                                                </div>\n" +
                        "                                            </div>\n" +
                        "                                    </td>\n" +
                        "                                    <td>" + room.getBed() + "</td>\n" +
                        "                                    <td>" + detail.getQuantityRoom() + "</td>\n" +
                        "                                    <td class=\"text-nowrap\">" + format.format(detail.getSubTotal()) + " VND</td>\n" +
                        "                                    <td class=\"text-nowrap\">" + df.format(new java.util.Date(booking.getBookingDate().getTime())) + "</td>\n" +
                        "                                    <td class=\"text-nowrap\">" + df.format(new java.util.Date(booking.getDateFrom().getTime())) + "</td>\n" +
                        "                                    <td class=\"text-nowrap\">" + df.format(new java.util.Date(booking.getDateTo().getTime())) + "</td>\n" +
                        "                                    <td>" + booking.getPayment() + "</td>\n" +
                        "                                </tr>\n";
            }
            content += "                            </tbody>\n" +
                    "                        </table>";

            try {
                out.print(mapper.writeValueAsString(content));
            } catch (JsonProcessingException e) {
                e.printStackTrace();
            }
        } catch (SQLException e) {
            request.getRequestDispatcher("views/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String action = request.getParameter("action");
        if (action != null && action.equals("deleteBooking")) {
            doPost_deleteBooking(request, response);
        }
    }

    private void doPost_deleteBooking(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int bookingId = Integer.parseInt(request.getParameter("bookingId"));

            PrintWriter out = response.getWriter();
            ObjectMapper mapper = new ObjectMapper();

            if (bookingDAO.deleteBooking(bookingId)) {
                out.print(mapper.writeValueAsString(bookingId));
            }
        } catch (SQLException e) {
            request.getRequestDispatcher("views/error.jsp").forward(request, response);
        }
    }

    private void doGet_index(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            List<Booking> bookingList = bookingDAO.getAllBooking();

            request.setAttribute("bookingList", bookingList);
            request.getRequestDispatcher("views/admin-manage-booking.jsp").forward(request, response);
        } catch (SQLException e) {
            request.getRequestDispatcher("views/error.jsp").forward(request, response);
        }
    }
}
