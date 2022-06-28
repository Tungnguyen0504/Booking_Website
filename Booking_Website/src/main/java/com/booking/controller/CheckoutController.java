package com.booking.controller;

import com.booking.dao.DAOImpl.*;
import com.booking.dao.IDAO.*;
import com.booking.entity.*;
import com.booking.util.FunctionUtil;
import com.fasterxml.jackson.databind.ObjectMapper;

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
import java.util.Date;
import java.util.List;

@WebServlet(urlPatterns = "/checkout")
public class CheckoutController extends HttpServlet {

    static RoomDAO roomDAO = new RoomDAOImpl();
    static HotelDAO hotelDAO = new HotelDAOImpl();
    static AccountDAO accountDAO = new AccountDAOImpl();
    static BookingDAO bookingDAO = new BookingDAOImpl();
    static BookingDetailDAO bookingDetailDAO = new BookingDetailDAOIml();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        PrintWriter out = response.getWriter();
        ObjectMapper mapper = new ObjectMapper();

        String action = request.getParameter("action");

        try {
            if (action == null) {
                //check quantity
                Hotel hotel = hotelDAO.getHotelById(Integer.parseInt(request.getParameter("hotelId")));

                Date dateFrom = (Date) request.getSession().getAttribute("dateFrom");
                Date dateTo = (Date) request.getSession().getAttribute("dateTo");

                FunctionUtil.SetValueForDateFromAndDateTo(request, response, dateFrom, dateTo);

                //check quantity room and passenger
                List<Item> item = (List<Item>) request.getSession().getAttribute("items");
                if (item == null) {
                    request.setAttribute("alert", "                                    <script>\n" +
                            "                                        swal(\"Vui lòng lựa chọn 1 phòng!\", \"\", \"error\");\n" +
                            "                                    </script>");
                    response.sendRedirect(request.getContextPath() + "/room?hotelId=" + hotel.getHotelId());
                    return;
                }

                request.setAttribute("hotel", hotel);
                request.getRequestDispatcher("views/checkout.jsp").forward(request, response);
            }
            if (action != null && action.equals("cancel")) {
                int bookingId = Integer.parseInt(request.getParameter("bookingId"));
                bookingDAO.checkoutBooking(bookingId, 4);
                for (BookingDetail detail : bookingDetailDAO.getAllByBookingId(bookingId)) {
                    roomDAO.returnQtyRoom(detail.getRoomId(), detail.getQuantityRoom());
                }
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
        HttpSession session = request.getSession();

        try {
            Account account = (Account) request.getSession().getAttribute("account");

            account.setFullName(request.getParameter("fullName"));
            account.setEmail(request.getParameter("email"));
            account.setAddress(request.getParameter("address"));
            account.setPhone(request.getParameter("phone"));

            if (accountDAO.updateAccount(account)) {
                session.setAttribute("account", account);
            }

            List<Item> items = (List<Item>) session.getAttribute("items");

            double totalPrice = 0;
            long subDate = (long) session.getAttribute("subDate");
            for (int i = 0; i < items.size(); i++) {
                double price = items.get(i).getRoom().getPrice() * subDate * items.get(i).getQtyRoom();
                double discount = items.get(i).getRoom().getPrice() * items.get(i).getRoom().getDiscountPercent() / 100 * subDate * items.get(i).getQtyRoom();
                totalPrice += price - discount;
            }
            Booking booking = Booking.builder().build();

            booking.setAccountId(account.getAccountId());
            booking.setTimeCheckin(request.getParameter("timeCheckin"));
            booking.setGuestNumber(((QtyRoomPassenger) session.getAttribute("qtyRoomPassenger")).getQtyPassenger());
            booking.setNote(request.getParameter("note"));
            booking.setBookingDate(new java.sql.Date(System.currentTimeMillis()));

            Date dateFrom = (Date) session.getAttribute("dateFrom");
            Date dateTo = (Date) session.getAttribute("dateTo");
            booking.setDateFrom(new java.sql.Date(dateFrom.getTime()));
            booking.setDateTo(new java.sql.Date(dateTo.getTime()));
            booking.setTotalPrice(totalPrice);
            booking.setBookingStatusId(1);

            Booking lastBooking = bookingDAO.getLastBooking(account.getAccountId());
            List<BookingDetail> bookingDetails;
            if (lastBooking.getBookingStatusId() != 1) {
                bookingDetails = addNewBookingDetail(booking, subDate, items);
            } else {
                booking.setBookingId(lastBooking.getBookingId());
                bookingDetails = addNewBookingDetail(booking, subDate, items);
            }

            request.setAttribute("dateFrom", dateFrom);
            request.setAttribute("dateTo", dateTo);
            request.setAttribute("hotel", hotelDAO.getHotelById(Integer.parseInt(request.getParameter("hotelId"))));
            request.getSession().setAttribute("booking", booking);
            request.getSession().setAttribute("bookingDetails", bookingDetails);
            request.getSession().setMaxInactiveInterval(60 * 60);

            request.getRequestDispatcher("views/checkout-next.jsp").forward(request, response);
        } catch (SQLException e) {
            request.getRequestDispatcher("views/error.jsp").forward(request, response);
        }
    }

    private List<BookingDetail> addNewBookingDetail(Booking booking, long subDate, List<Item> items) {
        List<BookingDetail> list = new ArrayList<>();
        for (Item item : items) {
            double price = item.getRoom().getPrice() * subDate * item.getQtyRoom();
            double discount = item.getRoom().getPrice() * item.getRoom().getDiscountPercent() / 100 * subDate * item.getQtyRoom();

            BookingDetail detail = BookingDetail.builder()
                    .roomId(item.getRoom().getRoomId())
                    .bookingId(booking.getBookingId())
                    .quantityRoom(item.getQtyRoom())
                    .subTotal(price - discount)
                    .build();
            list.add(detail);
        }
        return list;
    }
}
