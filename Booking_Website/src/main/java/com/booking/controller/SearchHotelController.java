package com.booking.controller;

import com.booking.dao.DAOImpl.HotelDAOImpl;
import com.booking.dao.IDAO.HotelDAO;
import com.booking.entity.Hotel;
import com.booking.util.FunctionUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

@WebServlet(urlPatterns = "/search-hotel")
public class SearchHotelController extends HttpServlet {
    static HotelDAO hotelDAO = new HotelDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            request.setCharacterEncoding("UTF-8");
            response.setCharacterEncoding("UTF-8");

            HttpSession session = request.getSession();

            //set value for search name and date if empty
            String name = (String) session.getAttribute("name");
            Date dateFrom = (Date) session.getAttribute("dateFrom");
            Date dateTo = (Date) session.getAttribute("dateTo");

            FunctionUtil.SetValueForDateFromAndDateTo(request, response,dateFrom, dateTo);

            if (name == null) {
                name = "";
            }

            //pagination
            String indexString = request.getParameter("index");
            if (indexString == null || indexString.trim().isEmpty()) {
                indexString = "1";
            }
            int index = 0;
            boolean check = false;
            try {
                index = Integer.parseInt(indexString);
                check = true;
            } catch (Exception e) {
                request.setAttribute("error", "Page invalid");
            }

            if (check == true) {
                String filter = "";
                String city = request.getParameter("city");
                if(city != null) {
                    filter += "AND c.CityId = " + city + "\n";
                    request.setAttribute("city", city);
                }
                String hotelTypeId = request.getParameter("type");
                if(hotelTypeId != null) {
                    filter += "AND h.HotelTypeId = " + hotelTypeId + "\n";
                    request.setAttribute("hotelType", hotelTypeId);
                }

                int count = hotelDAO.countSearchHotel(name, filter);

                filter += "ORDER BY h.HotelId\n";

                int size = 5;
                int lastPage = count / size;
                //if total number news search indivisible size then last page add one more
                if (count % size != 0) {
                    lastPage++;
                }

                List<Hotel> listHotel = hotelDAO.searchHotel(name, filter, index, size);
                List<Hotel> listTop9 = hotelDAO.getRandomTop9();

                request.setAttribute("listHotel", listHotel);
                request.setAttribute("listTop9", listTop9);
                request.setAttribute("lastPage", lastPage);
                request.setAttribute("index", index);
                request.setAttribute("count", count);

                session.setAttribute("name", name);
                //pagination
                request.getRequestDispatcher("views/search-result.jsp").forward(request, response);
            }

        } catch (SQLException e) {
            request.getRequestDispatcher("views/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String name = request.getParameter("name");
        Date dateFrom = FunctionUtil.convertStringToUtilDate(request.getParameter("datepicker1"));
        Date dateTo = FunctionUtil.convertStringToUtilDate(request.getParameter("datepicker2"));

        //save value date into session
        HttpSession session = request.getSession();
        session.setAttribute("name", name);
        session.setAttribute("dateFrom", dateFrom);
        session.setAttribute("dateTo", dateTo);

        response.sendRedirect(request.getContextPath() + "/search-hotel");
    }
}
