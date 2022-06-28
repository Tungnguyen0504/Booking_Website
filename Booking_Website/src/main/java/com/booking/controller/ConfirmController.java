package com.booking.controller;

import com.booking.dao.DAOImpl.BookingDAOImpl;
import com.booking.dao.DAOImpl.BookingDetailDAOIml;
import com.booking.dao.DAOImpl.HotelDAOImpl;
import com.booking.dao.DAOImpl.RoomDAOImpl;
import com.booking.dao.IDAO.BookingDAO;
import com.booking.dao.IDAO.BookingDetailDAO;
import com.booking.dao.IDAO.HotelDAO;
import com.booking.dao.IDAO.RoomDAO;
import com.booking.entity.*;
import com.booking.services.PaymentServices;
import com.booking.util.SendEmail;
import com.paypal.api.payments.PayerInfo;
import com.paypal.api.payments.Payment;
import com.paypal.api.payments.Transaction;
import com.paypal.base.rest.PayPalRESTException;

import javax.mail.MessagingException;
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

@WebServlet(urlPatterns = {"/confirm"})
public class ConfirmController extends HttpServlet {

    static BookingDAO bookingDAO = new BookingDAOImpl();
    static BookingDetailDAO bookingDetailDAO = new BookingDetailDAOIml();
    static RoomDAO roomDAO = new RoomDAOImpl();
    static HotelDAO hotelDAO = new HotelDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();

        try {
            String paymentId = request.getParameter("paymentId");
            String payerId = request.getParameter("PayerID");

            try {
                PaymentServices paymentServices = new PaymentServices();
                paymentServices.executePayment(paymentId, payerId);
            } catch (PayPalRESTException ex) {
                request.setAttribute("errorMessage", ex.getMessage());
                ex.printStackTrace();
                request.getRequestDispatcher("error.jsp").forward(request, response);
            }

            Booking booking = (Booking) session.getAttribute("booking");
            List<BookingDetail> bookingDetails = (List<BookingDetail>) session.getAttribute("bookingDetails");
            List<Item> items = (List<Item>) session.getAttribute("items");
            Account account = (Account) session.getAttribute("account");
            Hotel hotel = hotelDAO.getHotelById(items.get(0).getRoom().getHotelId());

            booking.setBookingStatusId(2);
            if (bookingDAO.addNewBooking(booking)) {
                Booking lastBooking = bookingDAO.getLastBooking(account.getAccountId());
                for (BookingDetail detail : bookingDetails) {
                    detail.setBookingId(lastBooking.getBookingId());
                    bookingDetailDAO.addNewBookingDetail(detail);
                    roomDAO.subtractQuantityRoomBooking(detail.getQuantityRoom(), detail.getRoomId());
                }
                SimpleDateFormat df = new SimpleDateFormat("dd-MMM-yyyy");

                long subDate = (long) session.getAttribute("subDate");

                NumberFormat numberFormat = NumberFormat.getNumberInstance();
                numberFormat.setMaximumFractionDigits(0);

                String subject = "Booking Successful!";
                String message = "<!DOCTYPE html>\n" +
                        "<html lang=\"en\">\n" +
                        "\n" +
                        "<head>\n" +
                        "    <meta charset=\"utf-8\">\n" +
                        "    <title>Example 1</title>\n" +
                        "    <style>\n" +
                        "        .clearfix:after {\n" +
                        "            content: \"\";\n" +
                        "            display: table;\n" +
                        "            clear: both;\n" +
                        "        }\n" +
                        "        \n" +
                        "        a {\n" +
                        "            color: #5D6975;\n" +
                        "            text-decoration: underline;\n" +
                        "        }\n" +
                        "        \n" +
                        "        p {\n" +
                        "            margin-top: 0;\n" +
                        "            margin-bottom: 8px;\n" +
                        "            word-break: normal;\n" +
                        "        }\n" +
                        "        \n" +
                        "        .main-all {\n" +
                        "            padding: 35px;\n" +
                        "            border-radius: 4px;\n" +
                        "            position: relative;\n" +
                        "            width: 73%;\n" +
                        "            height: fit-content;\n" +
                        "            margin: 0 auto;\n" +
                        "            color: #001028;\n" +
                        "            background: #FFFFFF;\n" +
                        "            font-family: Arial, sans-serif;\n" +
                        "            font-size: 14px;\n" +
                        "            font-family: Arial;\n" +
                        "            border: 1px solid darkgray;\n" +
                        "        }\n" +
                        "        \n" +
                        "        header {\n" +
                        "            margin-bottom: 15px;\n" +
                        "        }\n" +
                        "        \n" +
                        "        #logo {\n" +
                        "            text-align: center;\n" +
                        "            margin-bottom: 10px;\n" +
                        "        }\n" +
                        "        \n" +
                        "        #logo img {\n" +
                        "            width: 90px;\n" +
                        "        }\n" +
                        "        \n" +
                        "        h2 {\n" +
                        "            border-bottom: 1px solid #5D6975;\n" +
                        "            color: #5D6975;\n" +
                        "            font-size: 2.4em;\n" +
                        "            line-height: 1.4em;\n" +
                        "            font-weight: normal;\n" +
                        "            margin: 0 0 20px 0;\n" +
                        "            background: rgba(222, 225, 230, 255);\n" +
                        "            padding: 5px 20px;\n" +
                        "        }\n" +
                        "        \n" +
                        "        h3 {\n" +
                        "            font-size: 1.65em;\n" +
                        "        }\n" +
                        "        \n" +
                        "        h4 {\n" +
                        "            font-size: 1.45em;\n" +
                        "            margin: 0;\n" +
                        "        }\n" +
                        "        \n" +
                        "        h5 {\n" +
                        "            font-size: 1.2em;\n" +
                        "            margin: 0;\n" +
                        "            margin-bottom: 5px;\n" +
                        "        }\n" +
                        "        \n" +
                        "        .title {\n" +
                        "            float: left;\n" +
                        "        }\n" +
                        "        \n" +
                        "        #project {\n" +
                        "            float: left;\n" +
                        "        }\n" +
                        "        \n" +
                        "        #project span {\n" +
                        "            color: #5D6975;\n" +
                        "            text-align: right;\n" +
                        "            width: 52px;\n" +
                        "            margin-right: 10px;\n" +
                        "            display: inline-block;\n" +
                        "            font-size: 0.8em;\n" +
                        "        }\n" +
                        "        \n" +
                        "        #company {\n" +
                        "            float: right;\n" +
                        "            text-align: right;\n" +
                        "        }\n" +
                        "        \n" +
                        "        table {\n" +
                        "            width: 100%;\n" +
                        "            border-collapse: collapse;\n" +
                        "            border-spacing: 0;\n" +
                        "            margin-bottom: 20px;\n" +
                        "        }\n" +
                        "        \n" +
                        "        table tr:nth-child(2n-1) td {\n" +
                        "            background: #F5F5F5;\n" +
                        "            padding: 12px 20px;\n" +
                        "        }\n" +
                        "        \n" +
                        "        table th,\n" +
                        "        table td {\n" +
                        "            text-align: center;\n" +
                        "        }\n" +
                        "        \n" +
                        "        table th {\n" +
                        "            padding: 5px 20px;\n" +
                        "            color: #5D6975;\n" +
                        "            border-bottom: 1px solid #C1CED9;\n" +
                        "            white-space: nowrap;\n" +
                        "            font-weight: normal;\n" +
                        "        }\n" +
                        "        \n" +
                        "        table .service,\n" +
                        "        table .desc {\n" +
                        "            text-align: left;\n" +
                        "        }\n" +
                        "        \n" +
                        "        table td {\n" +
                        "            padding: 20px;\n" +
                        "            text-align: left;\n" +
                        "            width: 25%;\n" +
                        "        }\n" +
                        "        \n" +
                        "        table td.service,\n" +
                        "        table td.desc {\n" +
                        "            vertical-align: top;\n" +
                        "        }\n" +
                        "        \n" +
                        "        table td.unit,\n" +
                        "        table td.qty,\n" +
                        "        table td.total {\n" +
                        "            font-size: 1.2em;\n" +
                        "        }\n" +
                        "        \n" +
                        "        table td.grand {\n" +
                        "            border-top: 1px solid #5D6975;\n" +
                        "            ;\n" +
                        "        }\n" +
                        "        \n" +
                        "        #notices .notice {\n" +
                        "            color: #5D6975;\n" +
                        "            font-size: 1.2em;\n" +
                        "        }\n" +
                        "        \n" +
                        "        footer {\n" +
                        "            color: #5D6975;\n" +
                        "            width: 100%;\n" +
                        "            height: 30px;\n" +
                        "            position: absolute;\n" +
                        "            bottom: 0;\n" +
                        "            border-top: 1px solid #C1CED9;\n" +
                        "            padding: 8px 0;\n" +
                        "            text-align: center;\n" +
                        "        }\n" +
                        "        \n" +
                        "        .table-2 tr:nth-child(2n-1) td {\n" +
                        "            background-color: white;\n" +
                        "            border-bottom: 1px solid #dee2e6;\n" +
                        "        }\n" +
                        "    </style>\n" +
                        "</head>\n" +
                        "\n" +
                        "<body>\n" +
                        "    <div class=\"main-all\">\n" +
                        "        <header class=\"clearfix\">\n" +
                        "            <div id=\"project\" style=\"margin-left: 15px; margin-right: 60px; width: 280px; float: right;\">\n" +
                        "                <h3 style=\"margin: 0px; margin-bottom: 5px;\">Invoice</h3>\n" +
                        "                <div>\n" +
                        "                    <p>#BBB-10010110101938</p>\n" +
                        "                    <p>" + df.format(booking.getBookingDate()) + "</p>\n" +
                        "                    <p>Hình thức thanh toán: " + booking.getPayment() + "</p>\n" +
                        "                    <p>Trạng thái: <strong>Thành công</strong></p>\n" +
                        "                </div>\n" +
                        "            </div>\n" +
                        "            <div id=\"project\" style=\"margin-left: 15px; width: 230px;\">\n" +
                        "                <h3 style=\"margin: 0px; margin-bottom: 5px;\">" + hotel.getHotelName() + "</h3>\n" +
                        "                <div>\n" +
                        "                    <p>" + hotel.getAddress() + "</p>\n" +
                        "                    <p>Email: " + hotel.getEmail() + "</p>\n" +
                        "                    <p>Số điện thoại: " + hotel.getPhone() + "</p>\n" +
                        "                </div>\n" +
                        "            </div>\n" +
                        "        </header>\n" +
                        "        <main>\n" +
                        "            <table>\n" +
                        "                <tbody>\n" +
                        "                    <tr>\n" +
                        "                        <td colspan=\"4\" style=\"background-color: rgba(222,225,230,255); padding: 8px 20px;\">\n" +
                        "                            <h4 class=\"title\">Chi tiết của khách</h4>\n" +
                        "                        </td>\n" +
                        "                    </tr>\n" +
                        "                    <tr>\n" +
                        "                        <td class=\"service\">\n" +
                        "                            <h5>Họ và tên</h5>\n" +
                        "                            <p>" + account.getFullName() + "</p>\n" +
                        "                        </td>\n" +
                        "                        <td class=\"service\">\n" +
                        "                            <h5>Email</h5>\n" +
                        "                            <p>" + account.getEmail() + "</p>\n" +
                        "                        </td>\n" +
                        "                        <td class=\"service\">\n" +
                        "                            <h5>Số điện thoại</h5>\n" +
                        "                            <p>" + account.getPhone() + "</p>\n" +
                        "                        </td>\n" +
                        "                        <td class=\"qty\"></td>\n" +
                        "                    </tr>\n" +
                        "                    <tr>\n" +
                        "                        <td colspan=\"4\" style=\"background-color: rgba(222,225,230,255); padding: 8px 20px;\">\n" +
                        "                            <h4 class=\"title\">Chi tiết đặt chỗ (" + booking.getGuestNumber() + ")</h4>\n" +
                        "                        </td>\n" +
                        "                    </tr>\n";

                double price = 0;
                double discount = 0;
                for (Item item : items) {
                    price += item.getRoom().getPrice() * subDate * item.getQtyRoom();
                    discount += item.getRoom().getPrice() * item.getRoom().getDiscountPercent() / 100 * subDate * item.getQtyRoom();

                    message += "                    <tr>\n" +
                            "                        <td colspan=\"2\" style=\"background-color: white;\">\n" +
                            "                            <span style=\"margin-right: 8px; font-size: 1.2em;\"><strong>" + item.getRoom().getRoomType() + " x " + item.getQtyRoom() + "</strong></span> (" + session.getAttribute("subDate") + " đêm)\n" +
                            "                            <p style=\"margin-top: 8px;\">Loại giường: " + item.getRoom().getBed() + "</p>\n" +
                            "                        </td>\n" +
                            "                        <td class=\"service\">\n" +
                            "                            <h5>Nhận phòng</h5>\n" +
                            "                            <p>" + df.format(booking.getDateFrom()) + "</p>\n" +
                            "                        </td>\n" +
                            "                        <td class=\"service\">\n" +
                            "                            <h5>Trả phòng</h5>\n" +
                            "                            <p>" + df.format(booking.getDateTo()) + "</p>\n" +
                            "                        </td>\n" +
                            "                    </tr>\n";
                }

                message += "                    <tr style=\"height: 0px;\"></tr>\n" +
                        "                    <tr>\n" +
                        "                        <td colspan=\"4\" style=\"background-color: rgba(222,225,230,255); padding: 8px 20px;\">\n" +
                        "                            <h4 class=\"title\">Chi tiết thanh toán</h4>\n" +
                        "                        </td>\n" +
                        "                    </tr>\n" +
                        "                    <tr>\n" +
                        "                        <td class=\"service\" colspan=\"2\">\n" +
                        "                            <p>Đơn hàng của quý khách đã được thanh toán thành công. Quý khách vui lòng kiểm tra thông tin đơn hàng theo email dưới đây hoặc có thể tra cứu đơn hàng của mình theo link <a href=\"\" style=\"color: blue;\">vntrip.vn/tra-cuu-don-hang</a>.</p>\n" +
                        "                        </td>\n" +
                        "                        <td colspan=\"2\" style=\"padding-top: 8px;\">\n" +
                        "                            <table class=\"table-2\" style=\"float: right; width: 80%;\">\n" +
                        "                                <tbody>\n" +
                        "                                    <tr>\n" +
                        "                                        <td style=\"border-bottom: 1px solid #dee2e6;\">\n" +
                        "                                            <h5>\n" +
                        "                                                Giá ban đầu\n" +
                        "                                            </h5>\n" +
                        "                                        </td>\n" +
                        "                                        <td style=\"border-bottom: 1px solid #dee2e6;\">\n" +
                        "                                            VND " + numberFormat.format(price) + "\n" +
                        "                                        </td>\n" +
                        "                                    </tr>\n" +
                        "                                    <tr>\n" +
                        "                                        <td style=\"border-bottom: 1px solid #dee2e6;\">\n" +
                        "                                            <h5>\n" +
                        "                                                Giá khuyến mãi\n" +
                        "                                            </h5>\n" +
                        "                                        </td>\n" +
                        "                                        <td style=\"border-bottom: 1px solid #dee2e6;\">\n" +
                        "                                           VND " + numberFormat.format(discount) + "\n" +
                        "                                        </td>\n" +
                        "                                    </tr>\n" +
                        "                                    <tr>\n" +
                        "                                        <td style=\"border-bottom: 1px solid #dee2e6;\">\n" +
                        "                                            <h5>\n" +
                        "                                                Tổng cộng\n" +
                        "                                            </h5>\n" +
                        "                                        </td>\n" +
                        "                                        <td style=\"border-bottom: 1px solid #dee2e6;\">\n" +
                        "                                            VND " + numberFormat.format(price - discount) + "\n" +
                        "                                        </td>\n" +
                        "                                    </tr>\n" +
                        "                                </tbody>\n" +
                        "                            </table>\n" +
                        "                        </td>\n" +
                        "                    </tr>\n" +
                        "                </tbody>\n" +
                        "            </table>\n" +
                        "        </main>\n" +
                        "    </div>\n" +
                        "</body>\n" +
                        "\n" +
                        "</html>";
                try {
                    SendEmail.send("user25060504@gmail.com", subject, message, "tungnguyenn050499@gmail.com", "gunskovfuvzocnyv");
                } catch (MessagingException ex) {
                    ex.printStackTrace();
                }

                //remove all session except account
                Account acc = (Account) session.getAttribute("account");

                Collections.list(session.getAttributeNames()).stream().filter(s -> !s.equals("account")).forEach(s -> session.removeAttribute(s));
                //remove all session except account

                request.getRequestDispatcher("views/confirm.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}
