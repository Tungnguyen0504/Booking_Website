package com.booking.controller;

import com.booking.dao.IDAO.AccountDAO;
import com.booking.dao.DAOImpl.AccountDAOImpl;
import com.booking.entity.Account;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;

@WebServlet(urlPatterns = "/login")
public class LoginController extends HttpServlet {

    static AccountDAO dao = new AccountDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action != null && action.equals("logout")) {
            request.getSession().invalidate();
            response.sendRedirect(request.getContextPath() + "/home");
        } else {
            Cookie arr[] = request.getCookies();
            if (arr != null) {
                for (Cookie o : arr) {
                    if (o.getName().equals("emailCook")) {
                        request.setAttribute("email", o.getValue());
                    }
                    if (o.getName().equals("passwordCook")) {
                        request.setAttribute("password", o.getValue());
                    }
                }
            }
            request.getRequestDispatcher("views/login.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            PrintWriter out = response.getWriter();
            ObjectMapper mapper = new ObjectMapper();

            String msg = "";

            String remember = request.getParameter("remember");

            Account account = dao.login(Account.builder()
                    .email(request.getParameter("email"))
                    .password(request.getParameter("password"))
                    .build());

            if (account != null) {
                Cookie emailCook = new Cookie("emailCook", account.getEmail());
                Cookie passwordCook = new Cookie("passwordCook", account.getPassword());
                if (remember != null) {
                    emailCook.setMaxAge(7200);  //maximum - 2 hour
                    passwordCook.setMaxAge(7200);
                } else {
                    emailCook.setMaxAge(0);
                    passwordCook.setMaxAge(0);
                }

                HttpSession session = request.getSession();
                session.setAttribute("account", account);
                response.addCookie(emailCook);
                response.addCookie(passwordCook);

                if (account.getRole() == 0) {
                    String url = (String) request.getSession().getAttribute("url");

                    if (url == null || url.equals("")) {
                        url = request.getContextPath() + "/home";
                    }

                    response.sendRedirect(url);
                }
                if (account.getRole() == 1) {
                    response.sendRedirect(request.getContextPath() + "/admin-index");
                }
            } else {
                request.getSession().setAttribute("msg", "<div id=\"liveAlertPlaceholder\">\n" +
                        "                        <div class=\"alert alert-warning alert-dismissible fade show\" role=\"alert\">\n" +
                        "                            Tài khoản hoặc mật khẩu không hợp lệ!\n" +
                        "                            <button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\">\n" +
                        "                                <span aria-hidden=\"true\">&times;</span>\n" +
                        "                            </button>\n" +
                        "                        </div>\n" +
                        "                    </div>");
                response.sendRedirect(request.getContextPath() + "/login");
            }
        } catch (SQLException e) {
            request.getRequestDispatcher("views/error.jsp").forward(request, response);
        }
    }
}
