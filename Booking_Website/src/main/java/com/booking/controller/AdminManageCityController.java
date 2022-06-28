package com.booking.controller;

import com.booking.dao.DAOImpl.CityDAOImpl;
import com.booking.dao.IDAO.CityDAO;
import com.booking.entity.Account;
import com.booking.entity.City;
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

@WebServlet(urlPatterns = "/admin-manage-city")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
        maxFileSize = 1024 * 1024 * 10,      // 10 MB
        maxRequestSize = 1024 * 1024 * 100   // 100 MB
)
public class AdminManageCityController extends HttpServlet {

    static CityDAO cityDAO = new CityDAOImpl();

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
        if (action != null && action.equals("addCity")) {
            doGet_indexAddPage(request,response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String action = request.getParameter("action");
        if (action != null && action.equals("addCity")) {
            doPost_addCity(request, response);
        }
        if (action != null && action.equals("updateCity")) {
            doPost_updateCity(request, response);
        }
        if (action != null && action.equals("deleteCity")) {
            doPost_deleteCity(request, response);
        }
    }

    private void doGet_indexAddPage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("action", "add");
        request.getRequestDispatcher("views/admin-form-city.jsp").forward(request, response);
    }

    private void doPost_deleteCity(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int cityId = Integer.parseInt(request.getParameter("cityId"));
            String name = cityDAO.getCityNameById(cityId);

            PrintWriter out = response.getWriter();
            ObjectMapper mapper = new ObjectMapper();

            if (cityDAO.deleteCity(cityId)) {
                out.print(mapper.writeValueAsString(name));
            }
        } catch (SQLException e) {
            request.getRequestDispatcher("views/error.jsp").forward(request, response);
        }
    }

    private void doPost_updateCity(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int cityId = Integer.parseInt(request.getParameter("cityId"));
            //get image and upload into folder
            String fileName = "";
            boolean check;
            try {
                Part filePart = request.getPart("image");
                fileName = filePart.getSubmittedFileName();
                String tmp = getServletContext().getRealPath("uploads");
                filePart.write(tmp.substring(0, tmp.indexOf("target")).concat("src\\main\\webapp\\uploads\\city\\") + fileName);
                check = true;
            } catch (Exception e) {
                check = false;
            }

            if (!check) {
                fileName = cityDAO.getCityById(cityId).getCityImage();
            }

            City city = City.builder()
                    .cityId(Integer.parseInt(request.getParameter("cityId")))
                    .cityName(request.getParameter("cityName"))
                    .cityImage(fileName)
                    .build();
            if (cityDAO.updateCity(city)) {
                request.setAttribute("alert", "                            <script>\n" +
                        "                                swal(\"Thành công!\", \"Đã cập nhật thành phố\", \"success\");\n" +
                        "                            </script>");
                doGet_getInfor(request, response);
            }
        } catch (SQLException e) {
            request.getRequestDispatcher("views/error.jsp").forward(request, response);
        }
    }

    private void doPost_addCity(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            //get image and upload into folder
            Part filePart = request.getPart("image");
            String fileName = filePart.getSubmittedFileName();
            for (Part part : request.getParts()) {
                String tmp = getServletContext().getRealPath("uploads");
                part.write(tmp.substring(0, tmp.indexOf("target")).concat("src\\main\\webapp\\uploads\\accounts\\") + fileName);
            }

            City city = City.builder()
                    .cityName(request.getParameter("cityName"))
                    .cityImage(fileName)
                    .build();
            if (cityDAO.addCity(city)) {
                request.setAttribute("alert", "                            <script>\n" +
                        "                                swal(\"Thành công!\", \"Đã thêm mới thành phố\", \"success\");\n" +
                        "                            </script>");
                doGet_indexAddPage(request,response);
            }
        } catch (SQLException e) {
            request.getRequestDispatcher("views/error.jsp").forward(request, response);
        }
    }

    private void doGet_getInfor(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int cityId = Integer.parseInt(request.getParameter("cityId"));

            City city = cityDAO.getCityById(cityId);

            request.setAttribute("city", city);
            request.setAttribute("action", "update");
            request.getRequestDispatcher("views/admin-form-city.jsp").forward(request, response);
        } catch (SQLException e) {
            request.getRequestDispatcher("views/error.jsp").forward(request, response);
        }
    }

    private void doGet_index(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            List<City> cityList = cityDAO.getAll();

            request.setAttribute("cityList", cityList);
            request.getRequestDispatcher("views/admin-manage-city.jsp").forward(request, response);
        } catch (SQLException e) {
            request.getRequestDispatcher("views/error.jsp").forward(request, response);
        }
    }
}
