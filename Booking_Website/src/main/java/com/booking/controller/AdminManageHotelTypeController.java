package com.booking.controller;

import com.booking.dao.DAOImpl.HotelTypeDAOImpl;
import com.booking.dao.DAOImpl.HotelTypeDAOImpl;
import com.booking.dao.IDAO.HotelTypeDAO;
import com.booking.dao.IDAO.HotelTypeDAO;
import com.booking.entity.Account;
import com.booking.entity.HotelType;
import com.booking.entity.Hotel;
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
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet(urlPatterns = "/admin-manage-hotel-type")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
        maxFileSize = 1024 * 1024 * 10,      // 10 MB
        maxRequestSize = 1024 * 1024 * 100   // 100 MB
)
public class AdminManageHotelTypeController extends HttpServlet {

    static HotelTypeDAO hotelTypeDAO = new HotelTypeDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String action = request.getParameter("action");
        if (action == null) {
            doGet_index(request, response);
        }
        if (action != null && action.equals("getInfor")) {
            doGet_getInfor(request, response);
        }
        if (action != null && action.equals("addHotelType")) {
            doGet_indexAddPage(request,response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String action = request.getParameter("action");
        if (action != null && action.equals("addHotelType")) {
            doPost_addHotelType(request, response);
        }
        if (action != null && action.equals("updateHotelType")) {
            doPost_updateHotelType(request, response);
        }
        if (action != null && action.equals("deleteHotelType")) {
            doPost_deleteHotelType(request, response);
        }
    }

    private void doGet_indexAddPage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("action", "add");
        request.getRequestDispatcher("views/admin-form-hotel-type.jsp").forward(request, response);
    }

    private void doPost_deleteHotelType(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int hotelTypeId = Integer.parseInt(request.getParameter("hotelTypeId"));
            String name = hotelTypeDAO.getHotelTypeById(hotelTypeId);

            PrintWriter out = response.getWriter();
            ObjectMapper mapper = new ObjectMapper();

            if (hotelTypeDAO.deleteHotelType(hotelTypeId)) {
                out.print(mapper.writeValueAsString(name));
            }
        } catch (SQLException e) {
            request.getRequestDispatcher("views/error.jsp").forward(request, response);
        }
    }

    private void doPost_updateHotelType(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int hotelTypeId = Integer.parseInt(request.getParameter("hotelTypeId"));
            //get image and upload into folder
            String fileName = "";
            boolean check;
            try {
                Part filePart = request.getPart("image");
                fileName = filePart.getSubmittedFileName();
                String tmp = getServletContext().getRealPath("uploads");
                filePart.write(tmp.substring(0, tmp.indexOf("target")).concat("src\\main\\webapp\\uploads\\hotel-type\\") + fileName);
                check = true;
            } catch (Exception e) {
                check = false;
            }

            if (!check) {
                fileName = hotelTypeDAO.getHotelTypeByTypeId(hotelTypeId).getHotelTypeImage();
            }

            HotelType hotelType = com.booking.entity.HotelType.builder()
                    .typeId(Integer.parseInt(request.getParameter("hotelTypeId")))
                    .typeName(request.getParameter("hotelTypeName"))
                    .hotelTypeImage(fileName)
                    .build();
            if (hotelTypeDAO.updateHotelType(hotelType)) {
                request.setAttribute("alert", "                            <script>\n" +
                        "                                swal(\"Thành công!\", \"Đã cập nhật loại khách sạn\", \"success\");\n" +
                        "                            </script>");
                doGet_getInfor(request, response);
            }
        } catch (SQLException e) {
            request.getRequestDispatcher("views/error.jsp").forward(request, response);
        }
    }

    private void doPost_addHotelType(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            //get image and upload into folder
            Part filePart = request.getPart("image");
            String fileName = filePart.getSubmittedFileName();
            for (Part part : request.getParts()) {
                String tmp = getServletContext().getRealPath("uploads");
                part.write(tmp.substring(0, tmp.indexOf("target")).concat("src\\main\\webapp\\uploads\\hotel-type\\") + fileName);
            }

            HotelType hotelType = HotelType.builder()
                    .typeName(request.getParameter("hotelTypeName"))
                    .hotelTypeImage(fileName)
                    .build();
            if (hotelTypeDAO.addHotelType(hotelType)) {
                request.setAttribute("alert", "                            <script>\n" +
                        "                                swal(\"Thành công!\", \"Đã thêm mới loại khách sạn\", \"success\");\n" +
                        "                            </script>");
                doGet_indexAddPage(request,response);
            }
        } catch (SQLException e) {
            request.getRequestDispatcher("views/error.jsp").forward(request, response);
        }
    }

    private void doGet_getInfor(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int hotelTypeId = Integer.parseInt(request.getParameter("hotelTypeId"));

            HotelType hotelType = hotelTypeDAO.getHotelTypeByTypeId(hotelTypeId);

            request.setAttribute("hotelType", hotelType);
            request.setAttribute("action", "update");
            request.getRequestDispatcher("views/admin-form-hotel-type.jsp").forward(request, response);
        } catch (SQLException e) {
            request.getRequestDispatcher("views/error.jsp").forward(request, response);
        }
    }

    private void doGet_index(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            List<HotelType> hotelTypeList = hotelTypeDAO.getAll();

            request.setAttribute("hotelTypeList", hotelTypeList);
            request.getRequestDispatcher("views/admin-manage-hotel-type.jsp").forward(request, response);
        } catch (SQLException e) {
            request.getRequestDispatcher("views/error.jsp").forward(request, response);
        }
    }
}
