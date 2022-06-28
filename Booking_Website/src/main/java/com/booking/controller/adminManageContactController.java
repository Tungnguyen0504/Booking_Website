package com.booking.controller;

import com.booking.dao.DAOImpl.ContactDAOImpl;
import com.booking.dao.IDAO.ContactDAO;
import com.booking.entity.Contact;
import com.booking.util.FunctionUtil;
import com.booking.util.SendEmail;
import com.fasterxml.jackson.databind.ObjectMapper;

import javax.mail.MessagingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;

@WebServlet(urlPatterns = "/admin-manage-contact")
public class adminManageContactController extends HttpServlet {

    static ContactDAO contactDAO = new ContactDAOImpl();
    static SendEmail sendEmail = new SendEmail();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String action = request.getParameter("action");
        if (action == null) {
            doGet_index(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String action = request.getParameter("action");
        if (action != null && action.equals("reply")) {
            doPost_reply(request, response);
        }
        if (action != null && action.equals("deleteContact")) {
            doPost_deleteContact(request, response);
        }
    }

    private void doPost_deleteContact(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int contactId = Integer.parseInt(request.getParameter("contactId"));

            Contact contact = contactDAO.getContactById(contactId);

            PrintWriter out = response.getWriter();
            ObjectMapper mapper = new ObjectMapper();

            if (contactDAO.deleteContact(contactId)) {
                out.print(mapper.writeValueAsString(contact.getFullName()));
            }
        } catch (SQLException e) {
            request.getRequestDispatcher("views/error.jsp").forward(request, response);
        }
    }

    private void doPost_reply(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int contactId = Integer.parseInt(request.getParameter("contactId"));
            String message = request.getParameter("message");
            Contact contact = contactDAO.getContactById(contactId);

            PrintWriter out = response.getWriter();
            ObjectMapper mapper = new ObjectMapper();
            boolean check;
            String[] msg = new String[2];

            try {
                SendEmail.send("user25060504@gmail.com", contact.getSubject(), message, "tungnguyenn050499@gmail.com", "gunskovfuvzocnyv");
                check = true;
            } catch (MessagingException e) {
                msg[0] = "0";
                msg[1] = contact.getEmail();
                out.print(mapper.writeValueAsString(msg));
                check = false;
            }

            if (check == true) {
                msg[0] = "1";
                msg[1] = contact.getEmail();
                out.print(mapper.writeValueAsString(msg));
            }
        } catch (SQLException e) {
            request.getRequestDispatcher("views/error.jsp").forward(request, response);
        }
    }

    private void doGet_index(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            List<Contact> contactList = contactDAO.getAll();

            request.setAttribute("contactList", contactList);
            request.getRequestDispatcher("views/admin-manage-contact.jsp").forward(request, response);
        } catch (SQLException e) {
            request.getRequestDispatcher("views/error.jsp").forward(request, response);
        }
    }
}
