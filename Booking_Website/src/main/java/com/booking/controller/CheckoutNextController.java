package com.booking.controller;

import com.booking.dao.DAOImpl.BookingDAOImpl;
import com.booking.dao.DAOImpl.HotelDAOImpl;
import com.booking.dao.DAOImpl.RoomDAOImpl;
import com.booking.dao.IDAO.BookingDAO;
import com.booking.dao.IDAO.HotelDAO;
import com.booking.dao.IDAO.RoomDAO;
import com.booking.entity.*;
import com.booking.services.PaymentServices;
import com.booking.util.SendEmail;
import com.paypal.base.rest.PayPalRESTException;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.Collections;
import java.util.List;
import java.util.Properties;

@WebServlet(urlPatterns = "/checkout-next")
public class CheckoutNextController extends HttpServlet {
    static BookingDAO bookingDAO = new BookingDAOImpl();
    static RoomDAO roomDAO = new RoomDAOImpl();
    static HotelDAO hotelDAO = new HotelDAOImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        Booking booking = (Booking) session.getAttribute("booking");
        List<BookingDetail> bookingDetails = (List<BookingDetail>) session.getAttribute("bookingDetails");
        List<Item> items = (List<Item>) session.getAttribute("items");

        String payment = request.getParameter("payment");

        booking.setBookingId(booking.getBookingId());
        booking.setPayment(payment);
        session.setAttribute("booking", booking);

        //paypal
        try {
            PaymentServices paymentServices = new PaymentServices();
            String approvalLink = paymentServices.authorizePayment(booking, bookingDetails, request);

            response.sendRedirect(approvalLink);
        } catch (PayPalRESTException ex) {
            ex.printStackTrace();
            request.getRequestDispatcher("views/error.jsp").forward(request, response);
        }
    }
}
