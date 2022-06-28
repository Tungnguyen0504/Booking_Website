package com.booking.controller;

import com.booking.dao.DAOImpl.BookingDAOImpl;
import com.booking.dao.DAOImpl.HotelDAOImpl;
import com.booking.dao.DAOImpl.RatingDAOImpl;
import com.booking.dao.DAOImpl.RoomDAOImpl;
import com.booking.dao.IDAO.BookingDAO;
import com.booking.dao.IDAO.HotelDAO;
import com.booking.dao.IDAO.RatingDAO;
import com.booking.dao.IDAO.RoomDAO;
import com.booking.entity.Booking;
import com.booking.entity.Rating;
import com.booking.entity.Room;
import com.fasterxml.jackson.databind.ObjectMapper;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.sql.SQLException;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet(urlPatterns = "/admin-index")
public class AdminIndexController extends HttpServlet {
    static HotelDAO hotelDAO = new HotelDAOImpl();
    static BookingDAO bookingDAO = new BookingDAOImpl();
    static RoomDAO roomDAO = new RoomDAOImpl();
    static RatingDAO ratingDAO = new RatingDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        try {
            int countRoom = 0;
            for (Room room : roomDAO.getAllRoom()) {
                countRoom += room.getQuantity();
            }

            int countCheckin = 0;
            int countCheckout = 0;
            for (Booking booking : bookingDAO.getAllBooking()) {
                Date now = new Date(System.currentTimeMillis());
                if (now.compareTo(booking.getDateFrom()) == 1 && now.compareTo(booking.getDateTo()) == -1) {
                    countCheckin++;
                }
                if (now.compareTo(booking.getDateTo()) == 1) {
                    countCheckout++;
                }
            }

            //table
            List<Booking> bookingList = bookingDAO.getAllBooking();
            bookingList.sort(Comparator.comparing(Booking::getBookingDate).reversed());

            //rating
            List<Rating> ratingList = ratingDAO.getAllRating().stream().filter(rating -> rating.getRatingStatus() == 1).collect(Collectors.toList());
            ratingList.sort(Comparator.comparing(Rating::getCreatedDate).reversed());

            request.setAttribute("countCheckin", countCheckin);
            request.setAttribute("countCheckout", countCheckout);
            request.setAttribute("countPaid", bookingDAO.getAllBooking().stream().filter(booking -> booking.getBookingStatusId() == 2).count());
            request.setAttribute("countReturned", bookingDAO.getAllBooking().stream().filter(booking -> booking.getBookingStatusId() == 3).count());
            request.setAttribute("countCanceled", bookingDAO.getAllBooking().stream().filter(booking -> booking.getBookingStatusId() == 4).count());
            request.setAttribute("countRoom", countRoom);
            request.setAttribute("bookingList", bookingList);
            request.setAttribute("ratingList", ratingList);  //rating
            request.getRequestDispatcher("views/admin-index.jsp").forward(request, response);
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
            ObjectMapper mapper = new ObjectMapper();

            String action = request.getParameter("action");

            if (action != null && action.equals("manageRating")) {
                int ratingId = Integer.parseInt(request.getParameter("ratingId"));
                int status = Integer.parseInt(request.getParameter("status"));

                if (status == 2) {
                    if (ratingDAO.updateRatingStatus(ratingId, status)) {
                        out.print(mapper.writeValueAsString(1));
                    }
                }
                if (status == 3) {
                    if (ratingDAO.updateRatingStatus(ratingId, status)) {
                        out.print(mapper.writeValueAsString(2));
                    }
                }
            }
        } catch (SQLException e) {
            request.getRequestDispatcher("views/error.jsp").forward(request, response);
        }

    }
}
