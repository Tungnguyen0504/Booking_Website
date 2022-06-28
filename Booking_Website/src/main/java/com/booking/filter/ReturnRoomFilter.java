package com.booking.filter;


import com.booking.dao.DAOImpl.BookingDAOImpl;
import com.booking.dao.DAOImpl.BookingDetailDAOIml;
import com.booking.dao.DAOImpl.RoomDAOImpl;
import com.booking.dao.IDAO.BookingDAO;
import com.booking.dao.IDAO.BookingDetailDAO;
import com.booking.dao.IDAO.RoomDAO;
import com.booking.entity.Booking;
import com.booking.entity.BookingDetail;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebFilter(urlPatterns = {"/*"})
public class ReturnRoomFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;

        if (!request.getRequestURI().contains("assets")) {
            try {
                BookingDAO bookingDAO = new BookingDAOImpl();
                BookingDetailDAO bookingDetailDAO = new BookingDetailDAOIml();
                RoomDAO roomDAO = new RoomDAOImpl();

                List<Booking> bookingListReturn = new ArrayList<>();
                List<Booking> bookingListCancel = new ArrayList<>();
                for (Booking booking : bookingDAO.getAllBooking()) {
                    if (booking.getDateTo().compareTo(new Date(System.currentTimeMillis())) == -1 && booking.getBookingStatusId() == 2) {
                        bookingListReturn.add(booking);
                    }
                }

                int bookingStatusId;
                //checkout room
                for (Booking booking : bookingListReturn) {
                    bookingStatusId = 3;
                    int bookingId = booking.getBookingId();
                    if (bookingDAO.checkoutBooking(bookingId, bookingStatusId)) {
                        for (BookingDetail detail : bookingDetailDAO.getAllByBookingId(bookingId)) {
                            roomDAO.returnQtyRoom(detail.getRoomId(), detail.getQuantityRoom());
                        }
                    }

                }
            } catch (SQLException e) {
                request.getRequestDispatcher("views/error.jsp").forward(request, response);
            }
        }

        filterChain.doFilter(servletRequest, servletResponse);

    }

    @Override
    public void destroy() {

    }
}
