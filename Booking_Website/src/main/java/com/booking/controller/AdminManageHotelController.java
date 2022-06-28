package com.booking.controller;

import com.booking.dao.DAOImpl.HotelDAOImpl;
import com.booking.dao.DAOImpl.HotelServiceDAOImpl;
import com.booking.dao.IDAO.HotelDAO;
import com.booking.dao.IDAO.HotelServiceDAO;
import com.booking.entity.Hotel;
import com.booking.entity.HotelService;
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
import java.sql.Time;
import java.util.*;

@WebServlet(urlPatterns = "/admin-manage-hotel")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
        maxFileSize = 1024 * 1024 * 10,      // 10 MB
        maxRequestSize = 1024 * 1024 * 100   // 100 MB
)
public class AdminManageHotelController extends HttpServlet {
    static HotelDAO hotelDAO = new HotelDAOImpl();
    static HotelServiceDAO hotelServiceDAO = new HotelServiceDAOImpl();

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
        if (action != null && action.equals("addHotel")) {
            doGet_addHotel(request, response);
        }
    }

    private void doGet_addHotel(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("action", "add");
        request.getRequestDispatcher("views/admin-form-hotel.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String action = request.getParameter("action");
        if (action != null && action.equals("updateHotel")) {
            doPost_updateHotel(request, response);
        }
        if (action != null && action.equals("addHotel")) {
            doPost_addHotel(request, response);
        }
        if (action != null && action.equals("deleteHotel")) {
            doPost_deleteHotel(request, response);
        }
    }

    private void doPost_deleteHotel(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
        try {
            int hotelId = Integer.parseInt(request.getParameter("hotelId"));
            String name = hotelDAO.getHotelById(hotelId).getHotelName();

            PrintWriter out = response.getWriter();
            ObjectMapper mapper = new ObjectMapper();

            if (hotelDAO.deleteHotel(hotelId)) {
                out.print(mapper.writeValueAsString(name));
            }
        } catch (SQLException e) {
            request.getRequestDispatcher("views/error.jsp").forward(request, response);
        }
    }

    private void doPost_addHotel(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            //get image and upload into folder
            String hotelImage = "";
            List<Part> fileParts = (List<Part>) request.getParts();

            for (Part filePart : fileParts) {
                if (filePart.getName().equalsIgnoreCase("image")) {
                    try {
                        String fileName = filePart.getSubmittedFileName();
                        String tmp = getServletContext().getRealPath("uploads");
                        filePart.write(tmp.substring(0, tmp.indexOf("target")).concat("src\\main\\webapp\\uploads\\hotel\\") + fileName);
                        hotelImage += fileName + "|";
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            }

            Hotel hotel = Hotel.builder()
                    .cityId(Integer.parseInt(request.getParameter("cityId")))
                    .hotelTypeId(Integer.parseInt(request.getParameter("hotelTypeId")))
                    .hotelName(request.getParameter("hotelName"))
                    .address(request.getParameter("address"))
                    .phone(request.getParameter("phone"))
                    .email(request.getParameter("email"))
                    .star(Integer.parseInt(request.getParameter("star_input")))
                    .specialAround(request.getParameterValues("specialAround")[1])
                    .description(request.getParameter("description"))
                    .hotelImage(hotelImage)
                    .checkin(Time.valueOf(request.getParameter("checkin")))
                    .checkout(Time.valueOf(request.getParameter("checkout")))
                    .build();

            if (hotelDAO.addNewHotel(hotel)) {
                HotelService hotelService = HotelService.builder()
                        .hotelId(hotelDAO.getLastHotelId())
                        .bathroom(request.getParameterValues("bathroom")[1])
                        .bedroom(request.getParameterValues("bedroom")[1])
                        .dinningroom(request.getParameterValues("dinningroom")[1])
                        .language(request.getParameterValues("language")[1])
                        .internet(request.getParameterValues("internet")[1])
                        .drinkAndFood(request.getParameterValues("drinkAndFood")[1])
                        .receptionService(request.getParameterValues("receptionService")[1])
                        .cleaningService(request.getParameterValues("cleaningService")[1])
                        .pool(request.getParameterValues("pool")[1])
                        .other(request.getParameterValues("other")[1])
                        .build();
                if (hotelServiceDAO.addNewHotelService(hotelService)) {
                    request.setAttribute("alert", "                            <script>\n" +
                            "                                swal(\"Thành công!\", \"Đã thêm mới khách sạn\", \"success\");\n" +
                            "                            </script>");
                    request.setAttribute("action", "add");
                    request.getRequestDispatcher("views/admin-form-hotel.jsp").forward(request,response);
                }
            }
        } catch (SQLException e) {
            request.getRequestDispatcher("views/error.jsp").forward(request, response);
        }
    }

    private void doPost_updateHotel(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int hotelId = Integer.parseInt(request.getParameter("hotelId"));
            int serviceId = Integer.parseInt(request.getParameter("serviceId"));
            //get image and upload into folder
            String hotelImage = "";
            List<Part> fileParts = (List<Part>) request.getParts();
            boolean check = false;

            for (Part filePart : fileParts) {
                if (filePart.getName().equalsIgnoreCase("image")) {
                    try {
                        String fileName = filePart.getSubmittedFileName();
                        String tmp = getServletContext().getRealPath("uploads");
                        filePart.write(tmp.substring(0, tmp.indexOf("target")).concat("src\\main\\webapp\\uploads\\hotel\\") + fileName);
                        hotelImage += fileName + "|";
                        check = true;
                    } catch (Exception e) {
                        check = false;
                    }
                }
            }

            if (check == false) {
                hotelImage = hotelServiceDAO.getHotelServiceByHotelId(hotelId).getHotelImage();
            }

            Hotel hotel = Hotel.builder()
                    .hotelId(hotelId)
                    .cityId(Integer.parseInt(request.getParameter("cityId")))
                    .hotelTypeId(Integer.parseInt(request.getParameter("hotelTypeId")))
                    .hotelName(request.getParameter("hotelName"))
                    .address(request.getParameter("address"))
                    .phone(request.getParameter("phone"))
                    .email(request.getParameter("email"))
                    .star(Integer.parseInt(request.getParameter("star_input")))
                    .specialAround(request.getParameterValues("specialAround")[1])
                    .description(request.getParameter("description"))
                    .hotelImage(hotelImage)
                    .checkin(Time.valueOf(request.getParameter("checkin")))
                    .checkout(Time.valueOf(request.getParameter("checkout")))
                    .build();
            HotelService hotelService = HotelService.builder()
                    .bathroom(request.getParameterValues("bathroom")[1])
                    .bedroom(request.getParameterValues("bedroom")[1])
                    .dinningroom(request.getParameterValues("dinningroom")[1])
                    .language(request.getParameterValues("language")[1])
                    .internet(request.getParameterValues("internet")[1])
                    .drinkAndFood(request.getParameterValues("drinkAndFood")[1])
                    .receptionService(request.getParameterValues("receptionService")[1])
                    .cleaningService(request.getParameterValues("cleaningService")[1])
                    .pool(request.getParameterValues("pool")[1])
                    .other(request.getParameterValues("other")[1])
                    .serviceId(serviceId)
                    .build();

            if (hotelDAO.updateHotel(hotel)) {
                if (hotelServiceDAO.updateHotelService(hotelService)) {
                    request.setAttribute("alert", "                            <script>\n" +
                            "                                swal(\"Thành công!\", \"Đã cập nhật khách sạn\", \"success\");\n" +
                            "                            </script>");
                    doGet_loadInfor(request, response);
                }
            }
        } catch (SQLException e) {
            request.getRequestDispatcher("views/error.jsp").forward(request, response);
        }
    }

    private void doGet_loadInfor(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int hotelId = Integer.parseInt(request.getParameter("hotelId"));

            HotelService service = hotelServiceDAO.getHotelServiceByHotelId(hotelId);

            request.setAttribute("service", service);
            request.setAttribute("action", "update");
            request.getRequestDispatcher("views/admin-form-hotel.jsp").forward(request, response);
        } catch (SQLException e) {
            request.getRequestDispatcher("views/error.jsp").forward(request, response);
        }
    }

    private void doGet_index(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            List<Hotel> hotelList = hotelDAO.getAll();

            request.setAttribute("hotelList", hotelList);
            request.getRequestDispatcher("views/admin-manage-hotel.jsp").forward(request, response);
        } catch (SQLException e) {
            request.getRequestDispatcher("views/error.jsp").forward(request, response);
        }
    }
}
