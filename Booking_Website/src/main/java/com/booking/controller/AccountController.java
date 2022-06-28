package com.booking.controller;

import com.booking.dao.DAOImpl.*;
import com.booking.dao.IDAO.*;
import com.booking.entity.*;
import com.booking.util.FunctionUtil;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.SQLException;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.Date;
import java.util.List;

@WebServlet(urlPatterns = {"/my-account"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
        maxFileSize = 1024 * 1024 * 10,      // 10 MB
        maxRequestSize = 1024 * 1024 * 100   // 100 MB
)
public class AccountController extends HttpServlet {
    static AccountDAO accountDAO = new AccountDAOImpl();
    static BookingDAO bookingDAO = new BookingDAOImpl();
    static BookingDetailDAO bookingDetailDAO = new BookingDetailDAOIml();
    static BookingStatusDAO bookingStatusDAO = new BookingStatusDAOImpl();
    static RoomDAO roomDAO = new RoomDAOImpl();
    static RatingDAO ratingDAO = new RatingDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String action = request.getParameter("action");
        if (action.equals("loadInfor")) {
            doGet_loadInfor(request, response);
        }
        if (action.equals("changePassword")) {
            doGet_changePassword(request, response);
        }
        if (action.equals("bookingHistory")) {
            doGet_bookingHistory(request, response);
        }
        if (action.equals("loadBookingDetailModal")) {
            doGet_loadBookingDetailModal(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String action = request.getParameter("action");
        if (action.equals("update")) {
            doPost_update(request, response);
        }
        if (action.equals("changePassword")) {
            doPost_changePassword(request, response);
        }
        if (action.equals("addNewRating")) {
            doPost_addNewRating(request, response);
        }
    }

    private void doGet_bookingHistory(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            List<Booking> bookingList = new ArrayList<>();
            for (Booking booking : bookingDAO.getAllBooking()) {
                if (booking.getAccountId() == Integer.parseInt(request.getParameter("accountId"))) {
                    bookingList.add(booking);
                }
            }
            bookingList.sort(Comparator.comparing(Booking::getBookingId).reversed());  //sort by bookingDate descending

            request.setAttribute("action", "bookingHistory");
            request.setAttribute("bookingList", bookingList);
            request.getRequestDispatcher("views/my-account.jsp").forward(request, response);
        } catch (SQLException e) {
            request.getRequestDispatcher("views/error.jsp").forward(request, response);
        }
    }

    private void doGet_changePassword(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("action", "changePassword");
        request.getRequestDispatcher("views/my-account.jsp").forward(request, response);
    }

    private void doGet_loadInfor(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Account a = (Account) request.getSession().getAttribute("account");

            Account account = accountDAO.getAccountById(a.getAccountId());

            request.getSession().setAttribute("account", account);
            request.setAttribute("action", "update");
            request.getRequestDispatcher("views/my-account.jsp").forward(request, response);
        } catch (SQLException e) {
            request.getRequestDispatcher("views/error.jsp").forward(request, response);
        }
    }

    private void doPost_addNewRating(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Rating rating = Rating.builder().bookingId(Integer.parseInt(request.getParameter("bookingId"))).starRating(Integer.parseInt(request.getParameter("rating"))).title(request.getParameter("title")).description(request.getParameter("description")).build();
            if (ratingDAO.addNewRating(rating)) {
            }
        } catch (SQLException e) {
            request.getRequestDispatcher("views/error.jsp").forward(request, response);
        }
    }

    private void doGet_loadBookingDetailModal(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int bookingId = Integer.parseInt(request.getParameter("bookingId"));

            List<BookingDetail> bookingDetailList = bookingDetailDAO.getAllByBookingId(bookingId);

            PrintWriter out = response.getWriter();
            ObjectMapper mapper = new ObjectMapper();

            String content = "                        <table class=\"table table-hover mb-3\">\n" + "                            <thead>\n" + "                            <tr>\n" + "                                <th>#</th>\n" + "                                <th>Loại phòng</th>\n" + "                                <th>Khách sạn</th>\n" + "                                <th>Loại giường</th>\n" + "                                <th>Số lượng phòng</th>\n" + "                                <th>Tổng giá</th>\n" + "                                <th>Ngày đặt phòng</th>\n" + "                                <th>Ngày nhận phòng</th>\n" + "                                <th>Ngày trả</th>\n" + "                                <th>Phương thức thanh toán</th>\n" + "                            </tr>\n" + "                            </thead>\n" + "                            <tbody>\n";

            NumberFormat format = NumberFormat.getNumberInstance();
            format.setMaximumFractionDigits(0);
            SimpleDateFormat df = new SimpleDateFormat("dd MMM yyyy");

            int index = 0;
            for (BookingDetail detail : bookingDetailList) {
                Room room = roomDAO.getRoomByRoomId(detail.getRoomId());
                Booking booking = bookingDAO.getBookingById(detail.getBookingId());

                content += "                                <tr>\n" + "                                    <td>" + (++index) + "</td>\n" + "                                    <td>\n" + "                                        <div class=\"d-flex align-items-center\">\n" + "                                            <div id=\"carousel-hotel" + index + "\" class=\"carousel slide mr-3\"\n" + "                                                 data-ride=\"carousel\">\n" + "                                                <div class=\"carousel-inner\" style=\"width: 160px;\">\n";

                String[] roomImage = room.getRoomImage().split("\\|");
                for (int i = 0; i < roomImage.length; i++) {
                    content += "                                                        <div class=\"carousel-item " + (i == 0 ? "active" : "") + "\"\n" + "                                                             style=\"width: 160px; border-radius: 0.225rem;\">\n" + "                                                            <img class=\"img-fluid d-block w-100\"\n" + "                                                                 style=\"height: 80px; border-radius: 0.225rem; object-fit: cover;\"\n" + "                                                                 src=\"" + request.getContextPath() + "/uploads/room/" + roomImage[i] + "\">\n" + "                                                        </div>\n";
                }
                content += "                                                </div>\n" + "                                                <a class=\"carousel-control-prev\" href=\"#carousel-hotel" + index + "\"\n" + "                                                   role=\"button\" data-slide=\"prev\"><span\n" + "                                                        class=\"carousel-control-prev-icon\"\n" + "                                                        aria-hidden=\"true\"></span><span\n" + "                                                        class=\"sr-only\">Previous</span></a>\n" + "                                                <a class=\"carousel-control-next\" href=\"#carousel-hotel" + index + "\"\n" + "                                                   role=\"button\" data-slide=\"next\"><span\n" + "                                                        class=\"carousel-control-next-icon\"\n" + "                                                        aria-hidden=\"true\"></span><span class=\"sr-only\">Next</span></a>\n" + "                                            </div>\n" + "                                            <div style=\"width: 180px;\">\n" + "                                                <h5 class=\"hotel-name text-primary hide-col\">" + room.getRoomType() + "</h5>\n" + "                                            </div>\n" + "                                        </div>\n" + "                                    </td>\n" + "                                    <td>\n" + "                                            <div>\n" + "                                                <h6 class=\"hide-col mb-1\"\n" + "                                                    style=\"width: 180px;\">" + room.getHotelName() + "</h6>\n" + "                                                <div style=\"color: #febb02;\">\n";

                for (int i = 0; i < room.getStar(); i++) {
                    content += "                                                        <i class=\"fa-solid fa-star \"></i>\n";
                }

                content += "                                                </div>\n" + "                                            </div>\n" + "                                    </td>\n" + "                                    <td>" + room.getBed() + "</td>\n" + "                                    <td>" + detail.getQuantityRoom() + "</td>\n" + "                                    <td class=\"text-nowrap\">" + format.format(detail.getSubTotal()) + " VND</td>\n" + "                                    <td class=\"text-nowrap\">" + df.format(new Date(booking.getBookingDate().getTime())) + "</td>\n" + "                                    <td class=\"text-nowrap\">" + df.format(new Date(booking.getDateFrom().getTime())) + "</td>\n" + "                                    <td class=\"text-nowrap\">" + df.format(new Date(booking.getDateTo().getTime())) + "</td>\n" + "                                    <td>" + booking.getPayment() + "</td>\n" + "                                </tr>\n";
            }
            content += "                            </tbody>\n" + "                        </table>";

            try {
                out.print(mapper.writeValueAsString(content));
            } catch (JsonProcessingException e) {
                e.printStackTrace();
            }
        } catch (SQLException e) {
            request.getRequestDispatcher("views/error.jsp").forward(request, response);
        }
    }

    private void doPost_changePassword(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Account account = (Account) request.getSession().getAttribute("account");

            String currentPassword = request.getParameter("currentPassword");
            String newPassword = request.getParameter("newPassword");
            String confirmPassword = request.getParameter("confirmPassword");

            request.setAttribute("action", "changePassword");

            if (!currentPassword.equals(account.getPassword())) {
                request.setAttribute("alert", "<script>\n" +
                        "    swal(\"Sai mật khẩu hiện tại!\", \"Mời bạn nhập lại\", \"error\");\n" +
                        "</script>");
                request.getRequestDispatcher("views/my-account.jsp").forward(request, response);
            } else if (currentPassword.equals(newPassword)) {
                request.setAttribute("alert", "<script>\n" +
                        "    swal(\"Không hợp lệ!\", \"Vui lòng nhập mật khẩu khác với mật khẩu hiện tại.\", \"error\");\n" +
                        "</script>");
                request.getRequestDispatcher("views/my-account.jsp").forward(request, response);
            } else {
                account.setPassword(newPassword);

                if (accountDAO.changePassword(account)) {
                    request.setAttribute("alert", "<script>\n" +
                            "    swal(\"Cập nhật mật khẩu thành công!\", \"\", \"success\");\n" +
                            "</script>");
                    request.getRequestDispatcher("views/my-account.jsp").forward(request, response);
                }
            }
        } catch (SQLException e) {
            request.getRequestDispatcher("views/error.jsp").forward(request, response);
        }
    }

    private void doPost_update(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Account account = (Account) request.getSession().getAttribute("account");

            //get image and upload into folder
            String fileName = "";
            boolean check;
            try {
                Part filePart = request.getPart("image");
                fileName = filePart.getSubmittedFileName();
                String tmp = getServletContext().getRealPath("uploads");
                filePart.write(tmp.substring(0, tmp.indexOf("target")).concat("src\\main\\webapp\\uploads\\accounts\\") + fileName);
                System.out.println(tmp.substring(0, tmp.indexOf("target")).concat("src\\main\\webapp\\uploads\\accounts\\") + fileName);
                check = true;
            } catch (Exception e) {
                check = false;
            }

            if (!check) {
                fileName = accountDAO.getAccountById(account.getAccountId()).getImage();
            }

            Date dateConvert = FunctionUtil.convertStringToUtilDate(request.getParameter("dateOfBirth"));

            account.setFullName(request.getParameter("fullName"));
            account.setEmail(request.getParameter("email"));
            account.setAddress(request.getParameter("address"));
            account.setPhone(request.getParameter("phone"));
            account.setDateOfBirth(new java.sql.Date(dateConvert.getTime()));
            account.setCountry(request.getParameter("country"));
            account.setImage(fileName);

            request.getSession().setAttribute("account", account);

            AccountDAO accountDAO = new AccountDAOImpl();
            if (accountDAO.updateAccount(account)) {
                request.setAttribute("alert", "<script>\n" +
                        "    swal(\"Cập nhật thông tin thành công!\", \"\", \"success\");\n" +
                        "</script>");
                request.setAttribute("action", "update");
                request.getRequestDispatcher("views/my-account.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            request.getRequestDispatcher("views/error.jsp").forward(request, response);
        }
    }
}
