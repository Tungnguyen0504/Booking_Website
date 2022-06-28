package com.booking.controller;

import com.booking.dao.DAOImpl.CityDAOImpl;
import com.booking.dao.DAOImpl.HotelDAOImpl;
import com.booking.dao.DAOImpl.HotelTypeDAOImpl;
import com.booking.dao.IDAO.CityDAO;
import com.booking.dao.IDAO.HotelDAO;
import com.booking.dao.IDAO.HotelTypeDAO;
import com.booking.entity.City;
import com.booking.entity.Hotel;
import com.booking.entity.HotelType;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet(urlPatterns = {"/home"})
public class HomeController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            HotelTypeDAO hotelTypeDAO = new HotelTypeDAOImpl();
            HotelDAO hotelDAO = new HotelDAOImpl();
            CityDAO cityDAO = new CityDAOImpl();

            List<HotelType> listHotelType = hotelTypeDAO.getAll();
            List<Hotel> listTop9 = hotelDAO.getRandomTop9();
            List<City> cityList = cityDAO.getAll();

            request.setAttribute("cityList", cityList);
            request.setAttribute("listHotelType", listHotelType);
            request.setAttribute("listTop9", listTop9);
            request.getRequestDispatcher("views/home.jsp").forward(request,response);
        } catch (SQLException e) {
            request.getRequestDispatcher("views/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
