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
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import com.google.gson.JsonObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.stream.Collectors;

@WebServlet(urlPatterns = {"/filter-search"})
public class FilterSearchHotelController extends HttpServlet {

    static HotelDAO hotelDAO = new HotelDAOImpl();
    static HotelTypeDAO hotelTypeDAO = new HotelTypeDAOImpl();
    static RatingDAO ratingDAO = new RatingDAOImpl();
    static RoomDAO roomDAO = new RoomDAOImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        try {

            PrintWriter out = response.getWriter();
            HttpSession session = request.getSession();

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
                String name = (String) session.getAttribute("name");
                if (name == null) {
                    name = "";
                }

                //filter
                String filter = "";

                String[] filterCheck = request.getParameterValues("filterCheck[]");
                String filterSort = request.getParameter("filterSort");

                //check filter if null => response to ajax
                if (filterCheck != null) {
                    List<String> listFilterType = Arrays.asList(filterCheck).stream()  //convert list to stream
                            .filter(s -> s.contains("type"))
                            .collect(Collectors.toList());
                    if (listFilterType != null && listFilterType.size() != 0) {
                        filter += "AND (";
                        int i = 0;
                        for (String str : listFilterType) {
                            filter += " h.HotelTypeId = " + str.substring(str.length() - 1);
                            if (i != listFilterType.size() - 1) {
                                filter += " OR";
                            } else {
                                filter += " ) ";
                            }
                            i++;
                        }
                    }

                    List<String> listFilterCity = Arrays.asList(filterCheck).stream()  //convert list to stream
                            .filter(s -> s.contains("city"))
                            .collect(Collectors.toList());
                    if (listFilterCity != null && listFilterCity.size() != 0) {
                        filter += "AND (";
                        int i = 0;
                        for (String str : listFilterCity) {
                            filter += " c.CityId = " + str.substring(str.length() - 1);
                            if (i != listFilterCity.size() - 1) {
                                filter += " OR";
                            } else {
                                filter += " ) ";
                            }
                            i++;
                        }
                    }

                    List<String> listFilterStar = Arrays.asList(filterCheck).stream()  //convert list to stream
                            .filter(s -> s.contains("star"))  //filter contain "type"
                            .collect(Collectors.toList());  //convert stream to list
                    if (listFilterStar != null && listFilterStar.size() != 0) {
                        filter += "AND (";
                        int i = 0;
                        for (String str : listFilterStar) {
                            filter += " h.Star = " + str.substring(str.length() - 1);
                            if (i != listFilterStar.size() - 1) {
                                filter += " OR";
                            } else {
                                filter += " ) ";
                            }
                            i++;
                        }
                    }

                    List<String> listFilterRate = Arrays.asList(filterCheck).stream()  //convert list to stream
                            .filter(s -> s.contains("rate"))  //filter contain "type"
                            .collect(Collectors.toList());  //convert stream to list
                    if (listFilterRate != null && listFilterRate.size() != 0) {
                        filter += "AND (";
                        int i = 0;
                        for (String str : listFilterRate) {
                            filter += " dbo.UF_RatingPoint(h.HotelId) >= " + str.substring(str.length() - 1);
                            if (i != listFilterRate.size() - 1) {
                                filter += " OR";
                            } else {
                                filter += " ) ";
                            }
                            i++;
                        }
                    }

                    filter += "\n";
                }

                int count = hotelDAO.countSearchHotel(name, filter);

                if (filterSort != null) {
                    filter += "ORDER BY " + filterSort + "\n";
                }

                if (filterSort == null && filterCheck != null) {
                    filter += "ORDER BY h.HotelId\n";
                }

                int size = 5;
                int lastPage = count / size;
                //if total number news search indivisible size then last page add one more
                if (count % size != 0) {
                    lastPage++;
                }

                List<Hotel> listHotel = hotelDAO.searchHotel(name, filter, index, size);
                String content = "";

                for (Hotel hotel : listHotel) {
                    content += "                            <div class=\"card mb-3 wow fadeInUp\">\n" +
                            "                                <div class=\"card-body\">\n" +
                            "                                    <div class=\"row no-gutters\">\n" +
                            "                                        <div class=\"col-3\">\n" +
                            "                                                <img style=\"height: 193px; object-fit: cover; margin-top: 10px;\"\n" +
                            "                                                     class=\"rounded\" src=\"" + (request.getContextPath() + "/uploads/hotel/" + hotel.getHotelImage().split("\\|")[0]) + "\">\n" +
                            "                                        </div>\n" +
                            "                                        <div class=\"col-9\">\n" +
                            "                                            <div class=\"card-body product-box\" style=\"padding: 0.25rem 1.25rem;\">\n" +
                            "                                                <div class=\" d-flex align-items-start justify-content-between \">\n" +
                            "                                                    <div class=\"d-flex flex-column\">\n" +
                            "                                                        <a href=\"" + request.getContextPath() + "/room?hotelId=" + hotel.getHotelId() + "\">\n" +
                            "                                                            <h5 class=\"card-title m-0 font-weight-bold text-truncate\"\n" +
                            "                                                                style=\"color: #0071c2; max-width: 400px;\">" + hotel.getHotelName() + "</h5>\n" +
                            "                                                        </a>\n";

                    if (hotel.getStar() > 0) {
                        content += "\n<div style=\"color: #febb02; margin-bottom: 2px;\">";
                        for (int i = 0; i < hotel.getStar(); i++) {
                            content += "<i class=\"fa-solid fa-star \"></i>";
                        }
                        content += "\n</div>\n";
                    }

                    content += "                                                        <p class=\"mb-2\" style=\"width:70%; font-size: 14px;\">\n" +
                            "                                                                " + hotel.getAddress() + "\n" +
                            "                                                        </p>\n" +
                            "                                                    </div>\n" +
                            "                                                    <div>\n" +
                            "                                                        <div class=\"text-right\">\n" +
                            "                                                            <span class=\"text-title font-weight-bold\">" + hotelTypeDAO.getHotelTypeById(hotel.getHotelTypeId()) + "</span>\n" +
                            "                                                        </div>";


                    List<Rating> ratingList = ratingDAO.getAllListRatingByHotelId(hotel.getHotelId());

                    double countStar = 0;
                    for (Rating rate : ratingList) {
                        countStar += rate.getStarRating();
                    }

                    int countRating = ratingList.size();

                    content += "                                                        <div class=\"d-flex align-items-center border-top pt-1\">\n" +
                            "                                                            <div style=\"width: 90px;\">\n" +
                            "                                                                <p class=\"mb-0 text-right\">" + ratingList.size() + " đánh giá</p>\n" +
                            "                                                            </div>\n" +
                            "                                                            <div class=\"d-flex align-items-center justify-content-center font-weight-bold\"\n" +
                            "                                                                 style=\"background: #003580; height: 31px; width: 31px; border-radius:5.8181818182px 5.8181818182px 5.8181818182px\n" +
                            "                                            0; color: #ffffff; margin: 2px 0 0 9px; \">\n" +
                            "                                                                " + (countRating == 0 ? "0" : Math.round((countStar / countRating) * 2 * 10.0) / 10.0) + "\n" +
                            "                                                            </div>\n" +
                            "                                                        </div>\n" +
                            "                                                    </div>\n" +
                            "                                                </div>";

                    Room room = roomDAO.getRoomMinPriceByHotelId(hotel.getHotelId());
                    String[] roomService = room.getRoomService().split("\\|");

                    NumberFormat numberFormat = NumberFormat.getNumberInstance();
                    numberFormat.setMaximumFractionDigits(0);

                    long subDate = (long) session.getAttribute("subDate");

                    content += "                                                <p class=\"mb-0 text-success\" style=\"font-size: 16px;\">\n" +
                            "                                                    <i class=\"fa-solid fa-ban-smoking mr-1\"></i>\n" +
                            "                                                    <i class=\"fa-solid fa-wifi mr-1\"></i>\n" +
                            "                                                        " + roomService.length + " tiện ích\n" +
                            "                                                </p>\n" +
                            "                                                <div class=\"border-left p-2\"\n" +
                            "                                                     style=\"width: 70%; float: left; font-size: 12px;\">\n" +
                            "                                                    <span class=\"font-weight-bold\">" + room.getRoomType() + "</span><br> " + room.getBed() + "\n" +
                            "                                                    <div class=\"text-success mt-1\">\n" +
                            "                                                        <span class=\"font-weight-bold\">Miễn phí hủy</span><br> Bạn có\n" +
                            "                                                        thể\n" +
                            "                                                        hủy sau, nên hãy đặt ngay hôm nay để có giá tốt.\n" +
                            "                                                    </div>\n" +
                            "                                                </div>\n" +
                            "                                                <div class=\"position-relative\"\n" +
                            "                                                     style=\"width: 30%; float: right; bottom: 30px; height: 105px;\">\n" +
                            "                                                    <div class=\"text-right\">\n" +
                            "                                                        <small class=\"text-muted\">" + subDate + " đêm, 1 người\n" +
                            "                                                            lớn</small><br>\n" +
                            "                                                        <span class=\"text-danger\"\n" +
                            "                                                              style=\"text-decoration: line-through;\">VND " + numberFormat.format(room.getPrice() * subDate) + "</span><br>\n" +
                            "                                                        <span style=\"font-size: 20px; font-weight: bold;\">VND " + numberFormat.format(room.getPrice() * subDate * (100 - room.getDiscountPercent()) / 100) + "</span>\n" +
                            "                                                    </div>\n" +
                            "                                                    <div class=\"d-flex justify-content-end\">\n" +
                            "                                                        <a class=\"btn palatin-btn btn-3\"\n" +
                            "                                                           href=\"" + request.getContextPath() + "/room?hotelId=" + hotel.getHotelId() + "\"\n" +
                            "                                                           role=\"button\"\n" +
                            "                                                           style=\"padding: 0 20px;\">Xem chỗ trống</a>\n" +
                            "                                                    </div>\n" +
                            "                                                </div>\n" +
                            "                                            </div>\n" +
                            "                                        </div>\n" +
                            "                                    </div>\n" +
                            "                                </div>\n" +
                            "                            </div>";
                }

                JsonObject jsonObject = new JsonObject();
                jsonObject.addProperty("content", content);
                jsonObject.addProperty("index", index);
                jsonObject.addProperty("lastPage", lastPage);
                jsonObject.addProperty("countResult", count);
                jsonObject.addProperty("url", request.getContextPath());

                out.print(jsonObject);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
