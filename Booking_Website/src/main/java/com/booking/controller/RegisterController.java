package com.booking.controller;

import com.booking.dao.DAOImpl.AccountDAOImpl;
import com.booking.dao.IDAO.AccountDAO;
import com.booking.entity.Account;
import com.fasterxml.jackson.databind.ObjectMapper;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

@WebServlet(urlPatterns = "/register")
public class RegisterController extends HttpServlet {
    static AccountDAO accountDAO = new AccountDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("views/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            PrintWriter out = response.getWriter();
            ObjectMapper mapper = new ObjectMapper();

            String fullName = request.getParameter("fullName");
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            if (accountDAO.checkEmailUnique(email)) {
                out.print(mapper.writeValueAsString("0"));
            } else {
                Account account = Account.builder()
                        .fullName(fullName)
                        .email(email)
                        .password(password)
                        .build();
                if (accountDAO.addNewAccount(account)) {
                    out.print(mapper.writeValueAsString("1"));
                }
            }
        } catch (SQLException e) {
            request.getRequestDispatcher("views/error.jsp").forward(request, response);
        }
    }
}
