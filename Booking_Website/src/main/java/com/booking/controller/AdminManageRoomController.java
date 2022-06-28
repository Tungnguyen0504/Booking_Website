package com.booking.controller;

import com.booking.dao.DAOImpl.HotelDAOImpl;
import com.booking.dao.DAOImpl.HotelTypeDAOImpl;
import com.booking.dao.DAOImpl.RatingDAOImpl;
import com.booking.dao.DAOImpl.RoomDAOImpl;
import com.booking.dao.IDAO.HotelDAO;
import com.booking.dao.IDAO.HotelTypeDAO;
import com.booking.dao.IDAO.RatingDAO;
import com.booking.dao.IDAO.RoomDAO;
import com.booking.entity.Hotel;
import com.booking.entity.Rating;
import com.booking.entity.Room;
import com.booking.util.FunctionUtil;
import com.fasterxml.jackson.databind.ObjectMapper;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.NumberFormat;
import java.util.List;

@WebServlet(urlPatterns = "/admin-manage-room")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
        maxFileSize = 1024 * 1024 * 10,      // 10 MB
        maxRequestSize = 1024 * 1024 * 100   // 100 MB
)
public class AdminManageRoomController extends HttpServlet {

    static HotelDAO hotelDAO = new HotelDAOImpl();
    static RoomDAO roomDAO = new RoomDAOImpl();
    static HotelTypeDAO hotelTypeDAO = new HotelTypeDAOImpl();
    static RatingDAO ratingDAO = new RatingDAOImpl();
    static FunctionUtil functionUtil = new FunctionUtil();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String action = request.getParameter("action");
        if (action == null) {
            doGet_index(request, response);
        }
        if (action != null && action.equals("loadInfor")) {
            doGet_loadInfor(request, response);
        }
        if (action != null && action.equals("addRoom")) {
            doGet_indexAddPage(request, response);
        }
        if (action != null && action.equals("getHotel")) {
            doGet_getHotel(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String action = request.getParameter("action");
        if (action != null && action.equals("deleteRoom")) {
            doPost_deleteRoom(request, response);
        }
        if (action != null && action.equals("updateRoom")) {
            doPost_updateRoom(request, response);
        }
        if (action != null && action.equals("addRoom")) {
            doPost_addRoom(request, response);
        }
    }

    private void doGet_getHotel(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int hotelId = Integer.parseInt(request.getParameter("hotelId"));

            Hotel hotel = hotelDAO.getHotelById(hotelId);

            PrintWriter out = response.getWriter();
            ObjectMapper mapper = new ObjectMapper();

            String html = "                                    <div class=\"d-flex justify-content-between\">\n" +
                    "                                        <div>\n" +
                    "                                            <div class=\"d-flex align-items-center mb-2\">\n" +
                    "                                                <p class=\"text-muted mb-0 mr-2\">" + hotelTypeDAO.getHotelTypeById(hotelId) + "</p>\n" +
                    "                                                <div style=\"color: #febb02; \">\n";
            for (int i = 0; i < hotel.getStar(); i++) {
                html += "                                                        <i class=\"fa-solid fa-star \"></i>\n";
            }
            html += "                                                </div>\n" +
                    "                                            </div>\n" +
                    "\n" +
                    "                                            <div class=\"mb-2\">\n" +
                    "                                                <h3 class=\"mb-0\">" + hotel.getHotelName() + "</h3>\n" +
                    "                                            </div>\n" +
                    "\n" +
                    "                                            <div class=\"mb-2\">\n" +
                    "                                                <p class=\"mb-0\">" + hotel.getAddress() + "</p>\n" +
                    "                                            </div>\n" +
                    "\n";

            int countRate = functionUtil.countRating(ratingDAO.getAllListRatingByHotelId(hotelId));
            double ratingPoint = functionUtil.countRatingPoint(ratingDAO.getAllListRatingByHotelId(hotelId));
            NumberFormat nf = NumberFormat.getNumberInstance();
            nf.setMaximumFractionDigits(1);

            html += "                                            <div class=\"d-flex mb-2\">\n" +
                    "                                                <div class=\"d-flex align-items-center justify-content-center font-weight-bold mr-2\"\n" +
                    "                                                     style=\"background: #003580; height: 28px; width: 28px; border-radius:5.8181818182px 5.8181818182px 5.8181818182px 0; color: #ffffff; font-size: 13px;\">\n" +
                    "                                                    " + nf.format(ratingPoint) + "\n" +
                    "                                                </div>\n" +
                    "                                                <div class=\"d-flex align-items-center mr-2\"\n" +
                    "                                                     style=\"font-weight: 500;\">Tuyệt hảo\n" +
                    "                                                </div>\n" +
                    "                                                <div class=\"d-flex align-items-center text-muted\"\n" +
                    "                                                     style=\"font-size: 13px;\">" + nf.format(countRate) + " đánh giá\n" +
                    "                                                </div>\n" +
                    "                                            </div>\n" +
                    "\n" +
                    "                                            <div>\n" +
                    "                                                <span class=\"rounded\" style=\"border: 1px solid; padding: 0px 3px;\">\n" +
                    "                                                    <i class=\"fa-solid fa-car-side mr-1\"></i> Xe đưa đón sân bay\n" +
                    "                                                </span>\n" +
                    "                                            </div>\n" +
                    "                                        </div>\n" +
                    "                                        <div class=\"mr-3\">\n" +
                    "                                            <div id=\"carousel-room1\" class=\"carousel slide mr-3\"\n" +
                    "                                                 data-ride=\"carousel\">\n" +
                    "                                                <div class=\"carousel-inner\"\n" +
                    "                                                     style=\"width: 320px; border-radius: 0.225rem;\">\n";

            String[] img = hotel.getHotelImage().split("\\|");
            for (int i = 0; i < img.length; i++) {
                html += "                                                        <div class=\"carousel-item " + (i == 0 ? "active" : "") + "\"\n" +
                        "                                                             style=\"width: 320px;\">\n" +
                        "                                                            <img class=\"img-fluid d-block w-100\"\n" +
                        "                                                                 style=\"height: 168px; border-radius: 0.225rem;\"\n" +
                        "                                                                 src=\"" + request.getContextPath() + "/uploads/hotel/" + img[i] + "\">\n" +
                        "                                                        </div>\n";
            }

            html += "                                                </div>\n" +
                    "                                                <a class=\"carousel-control-prev\" href=\"#carousel-room1\"\n" +
                    "                                                   role=\"button\" data-slide=\"prev\"><span\n" +
                    "                                                        class=\"carousel-control-prev-icon\"\n" +
                    "                                                        aria-hidden=\"true\"></span><span\n" +
                    "                                                        class=\"sr-only\">Previous</span></a>\n" +
                    "                                                <a class=\"carousel-control-next\" href=\"#carousel-room1\"\n" +
                    "                                                   role=\"button\" data-slide=\"next\"><span\n" +
                    "                                                        class=\"carousel-control-next-icon\"\n" +
                    "                                                        aria-hidden=\"true\"></span><span class=\"sr-only\">Next</span></a>\n" +
                    "                                            </div>\n" +
                    "                                        </div>\n" +
                    "                                    </div>";
            out.print(mapper.writeValueAsString(html));
        } catch (SQLException e) {
            request.getRequestDispatcher("views/error.jsp").forward(request, response);
        }
    }

    private void doGet_indexAddPage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            List<Hotel> hotelList = hotelDAO.getAll();

            Hotel hotel = hotelDAO.getHotelById(hotelList.get(0).getHotelId());

            request.setAttribute("hotel", hotel);
            request.setAttribute("hotelList", hotelList);
            request.setAttribute("action", "add");
            request.getRequestDispatcher("views/admin-form-room.jsp").forward(request, response);
        } catch (SQLException e) {
            request.getRequestDispatcher("views/error.jsp").forward(request, response);
        }
    }

    private void doPost_addRoom(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //get image and upload into folder
        String roomImage = "";
        List<Part> fileParts = (List<Part>) request.getParts();

        for (Part filePart : fileParts) {
            if (filePart.getName().equalsIgnoreCase("roomImage")) {
                try {
                    String fileName = filePart.getSubmittedFileName();
                    String tmp = getServletContext().getRealPath("uploads");
                    filePart.write(tmp.substring(0, tmp.indexOf("target")).concat("src\\main\\webapp\\uploads\\room\\") + fileName);
                    roomImage += fileName + "|";
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }

        Room room = Room.builder()
                .hotelId(Integer.parseInt(request.getParameter("hotelId")))
                .roomType(request.getParameter("roomType"))
                .area(Integer.parseInt(request.getParameter("area")))
                .bed(request.getParameter("bed"))
                .suitableFor(Integer.parseInt(request.getParameter("suitableFor")))
                .dinningroom(request.getParameterValues("dinningroom")[1])
                .bathroom(request.getParameterValues("bathroom")[1])
                .roomService(request.getParameterValues("roomService")[1])
                .smoke(Boolean.parseBoolean(request.getParameter("smoke")))
                .view(request.getParameterValues("view")[1])
                .price(Double.parseDouble(request.getParameter("price")))
                .discountPercent(Integer.parseInt(request.getParameter("discountPercent")))
                .quantity(Integer.parseInt(request.getParameter("quantity")))
                .roomImage(roomImage)
                .statusId(1)
                .build();
        try {
            if (roomDAO.addRoom(room)) {
                request.setAttribute("alert", "                            <script>\n" +
                        "                                swal(\"Thành công!\", \"Đã thêm mới phòng.\", \"success\");\n" +
                        "                            </script>");
                doGet_indexAddPage(request, response);
            }
        } catch (SQLException e) {
            request.getRequestDispatcher("views/error.jsp").forward(request, response);
        }
    }

    private void doPost_updateRoom(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //get image and upload into folder
        String roomImage = "";
        List<Part> fileParts = (List<Part>) request.getParts();

        for (Part filePart : fileParts) {
            if (filePart.getName().equalsIgnoreCase("roomImage")) {
                try {
                    String fileName = filePart.getSubmittedFileName();
                    String tmp = getServletContext().getRealPath("uploads");
                    filePart.write(tmp.substring(0, tmp.indexOf("target")).concat("src\\main\\webapp\\uploads\\room\\") + fileName);
                    roomImage += fileName + "|";
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }

        Room room = Room.builder()
                .roomType(request.getParameter("roomType"))
                .area(Integer.parseInt(request.getParameter("area")))
                .bed(request.getParameter("bed"))
                .suitableFor(Integer.parseInt(request.getParameter("suitableFor")))
                .dinningroom(request.getParameterValues("dinningroom")[1])
                .bathroom(request.getParameterValues("bathroom")[1])
                .roomService(request.getParameterValues("roomService")[1])
                .smoke(Boolean.parseBoolean(request.getParameter("smoke")))
                .view(request.getParameterValues("view")[1])
                .price(Double.parseDouble(request.getParameter("price")))
                .discountPercent(Integer.parseInt(request.getParameter("discountPercent")))
                .quantity(Integer.parseInt(request.getParameter("quantity")))
                .roomImage(roomImage)
                .roomId(Integer.parseInt(request.getParameter("roomId")))
                .build();
        try {
            if (roomDAO.updateRoom(room)) {
                request.setAttribute("alert", "                            <script>\n" +
                        "                                swal(\"Thành công!\", \"Đã cập nhật phòng.\", \"success\");\n" +
                        "                            </script>");
                doGet_loadInfor(request, response);
            }
        } catch (SQLException e) {
            request.getRequestDispatcher("views/error.jsp").forward(request, response);
        }
    }

    private void doGet_loadInfor(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int roomId = Integer.parseInt(request.getParameter("roomId"));

            Room room = roomDAO.getRoomByRoomId(roomId);
            request.setAttribute("room", room);
            request.setAttribute("action", "update");
            request.getRequestDispatcher("views/admin-form-room.jsp").forward(request, response);
        } catch (SQLException e) {
            request.getRequestDispatcher("views/error.jsp").forward(request, response);
        }
    }

    private void doPost_deleteRoom(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int roomId = Integer.parseInt(request.getParameter("roomId"));
            String name = roomDAO.getRoomByRoomId(roomId).getRoomType();

            PrintWriter out = response.getWriter();
            ObjectMapper mapper = new ObjectMapper();

            if (roomDAO.deleteRoom(roomId)) {
                out.print(mapper.writeValueAsString(name));
            }
        } catch (SQLException e) {
            request.getRequestDispatcher("views/error.jsp").forward(request, response);
        }
    }

    private void doGet_index(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String hotelIdString = request.getParameter("hotelId");
            if (hotelIdString == null) {
                hotelIdString = String.valueOf(hotelDAO.getAll().get(0).getHotelId());
            }
            int hotelId = 0;
            try {
                hotelId = Integer.parseInt(hotelIdString);
            } catch (NumberFormatException e) {
                request.getRequestDispatcher("views/error.jsp").forward(request, response);
            }

            List<Room> roomList = roomDAO.getListRoomByHotelId(hotelId);

            request.setAttribute("hotelId", hotelId);
            request.setAttribute("roomList", roomList);
            request.getRequestDispatcher("views/admin-manage-room.jsp").forward(request, response);
        } catch (SQLException e) {
            request.getRequestDispatcher("views/error.jsp").forward(request, response);
        }
    }
}
