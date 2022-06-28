package com.booking.controller;

import com.booking.dao.DAOImpl.RoomDAOImpl;
import com.booking.dao.IDAO.RoomDAO;
import com.booking.entity.Account;
import com.booking.entity.Item;
import com.booking.entity.Room;
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
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.List;

import static java.lang.System.out;

@WebServlet(urlPatterns = "/booking-cart")
public class BookingCartController extends HttpServlet {

    static RoomDAO roomDAO = new RoomDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String action = request.getParameter("action");

        if (action != null && action.equals("addItem")) {
            doGet_addItem(request, response);
        }
        if (action != null && action.equals("openCart")) {
            doGet_openCart(request, response);
        }
        if (action != null && action.equals("removeCart")) {
            doGet_removeCart(request, response);
        }
        if (action != null && action.equals("changeQtyOfRoom")) {
            doGet_changeQtyOfRoom(request, response);
        }
    }

    private void doGet_changeQtyOfRoom(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        ObjectMapper mapper = new ObjectMapper();

        List<Item> items = (List<Item>) request.getSession().getAttribute("items");
        int roomId = Integer.parseInt(request.getParameter("roomId"));
        boolean check = false;

        for (int i = 0; i < items.size(); i++) {
            if (items.get(i).getRoom().getRoomId() == roomId) {
                items.get(i).setQtyRoom(Integer.parseInt(request.getParameter("qtyRoom")));
                check = true;
            }
        }
        if (check == true) {
            doGet_openCart(request, response);
        }
        if (check == false) {
            out.print(mapper.writeValueAsString("0"));
        }
    }


    private void doGet_removeCart(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        PrintWriter out = response.getWriter();
        ObjectMapper mapper = new ObjectMapper();

        List<Item> items = (List<Item>) session.getAttribute("items");
        int roomId = Integer.parseInt(request.getParameter("roomId"));
        boolean check = false;

        for (int i = 0; i < items.size(); i++) {
            if (items.get(i).getRoom().getRoomId() == roomId) {
                items.remove(i);
                check = true;
            }
        }

        if (check == true) {
            doGet_openCart(request, response);
        }
        if (check == false) {
            out.print(mapper.writeValueAsString("0"));
        }
    }

    private void doGet_openCart(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        PrintWriter out = response.getWriter();
        ObjectMapper mapper = new ObjectMapper();

        NumberFormat format = NumberFormat.getInstance();
        format.setMaximumFractionDigits(0);

        String content = "";
        List<Item> items = (List<Item>) session.getAttribute("items");
        if (items == null || items.size() == 0) {
            content += "<h4 class=\"font-weight-bold\">Danh sách chọn phòng đang trống!</h4>";
        } else {
            long subDate = (long) session.getAttribute("subDate");
            content += "                <h4 class=\"font-weight-bold\">Phòng đã chọn</h4>\n" +
                    "                <div>\n";

            int hotelId = 0;
            double price = 0;
            double discount = 0;
            for (Item item : items) {
                hotelId = item.getRoom().getHotelId();
                double subTotal = item.getRoom().getPrice() * item.getQtyRoom() * subDate;
                double subTotalDiscount = item.getRoom().getPrice() * item.getRoom().getDiscountPercent() / 100 * item.getQtyRoom() * subDate;
                price += subTotal;
                discount += subTotalDiscount;
                content += "                <div class=\"list-cart row position-relative mx-0 mt-3 shadow p-4\" id=\"room" + item.getRoom().getRoomId() + "\">\n" +
                        "                        <input type=\"hidden\" value=\"" + item.getRoom().getRoomId() + "\" name=\"roomId\">" +
                        "                       <div class=\"col-3 cart-img\">\n" +
                        "                        <img class=\"w-100 rounded\"\n" +
                        "                             src=\"" + request.getContextPath() + "/uploads/room/" + item.getRoom().getRoomImage().split("\\|")[0] + "\">\n" +
                        "                        <a class=\"btn-remove-cart btn btn-secondary rounded-circle\"><i class=\"fa-solid fa-xmark\"></i></a>\n" +
                        "                    </div>\n" +
                        "                    <div class=\"col-6 cart-title pl-3\">\n" +
                        "                        <h6 class=\"mb-0\">" + item.getRoom().getRoomType() + "</h6>\n" +
                        "                        <p class=\"mb-0\">" + format.format(subTotal - subTotalDiscount) + " VND/ " + subDate + " đêm</p>\n" +
                        "                    </div>\n" +
                        "                    <div class=\"col-3 pt-1 pl-3\">\n" +
                        "                        <input type=\"number\" class=\"qty-room-cart\" value=\"" + item.getQtyRoom() + "\" min=\"1\" max=\"" + item.getRoom().getQuantity() + "\">\n" +
                        "                    </div>\n" +
                        "                </div>";
            }
            content += "                <div class=\"border-top mt-5\"></div>\n" +
                    "                <div class=\"mt-4 d-flex justify-content-between\">\n" +
                    "                    <div class=\"d-flex flex-column\">\n" +
                    "                        <strong style=\"font-size: 20px;\">Tổng cộng:</strong>" +
                    "                        <div>\n" +
                    "                        <span class=\"text-muted mr-2\"\n" +
                    "                              style=\"text-decoration: line-through;\">" + format.format(price) + " VND</span>\n" +
                    "                        </div>\n" +
                    "                        <strong class=\"text-success mb-2\" style=\"font-size: 16px;\">" + format.format(price - discount) + " VND cho " + session.getAttribute("subDate") + "\n" +
                    "                            đêm</strong>\n" +
                    "                    </div>\n" +
                    "    <input type=\"hidden\" name=\"hotelId\" value=\"" + hotelId + "\">" +
                    "                    <a href=\"" + request.getContextPath() + "/checkout?hotelId=" + hotelId + "\" class=\"btn palatin-btn\" style=\"width: 40%;\">Thanh toán</a>\n" +
                    "                </div>";
        }

        out.print(mapper.writeValueAsString(content));
    }

    private void doGet_addItem(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        PrintWriter out = response.getWriter();
        ObjectMapper mapper = new ObjectMapper();

        if (session.getAttribute("account") == null) {
            out.print(mapper.writeValueAsString("2"));
        } else {
            try {
                Room room = roomDAO.getRoomByRoomId(Integer.parseInt(request.getParameter("roomId")));
                if (session.getAttribute("items") == null) {
                    List<Item> items = new ArrayList<>();
                    Item item = Item.builder().qtyRoom(1).room(room).build();
                    items.add(item);
                    session.setAttribute("items", items);

                    out.print(mapper.writeValueAsString(new String[]{"1", items.size() + ""}));
                } else {
                    List<Item> items = (List<Item>) session.getAttribute("items");
                    int index = isExisting(room.getRoomId(), items);
                    if (index == -1) {
                        Item item = Item.builder().qtyRoom(1).room(room).build();
                        items.add(item);
                    } else {
                        if (items.get(index).getQtyRoom() < items.get(index).getRoom().getQuantity()) {
                            items.get(index).setQtyRoom(items.get(index).getQtyRoom() + 1);
                        } else {
                            out.print(mapper.writeValueAsString("0"));
                            return;
                        }
                    }
                    session.setAttribute("items", items);
                    out.print(mapper.writeValueAsString(new String[]{"1", items.size() + ""}));
                }
            } catch (SQLException e) {
                request.getRequestDispatcher("views/error.jsp").forward(request, response);
            }
        }
    }

    private int isExisting(int roomId, List<Item> items) {
        for (int i = 0; i < items.size(); i++) {
            if (items.get(i).getRoom().getRoomId() == roomId) {
                return i;
            }
        }
        return -1;
    }
}
