package com.booking.controller;

import com.booking.dao.DAOImpl.ContactDAOImpl;
import com.booking.dao.IDAO.ContactDAO;
import com.booking.entity.Contact;
import com.booking.util.SendEmail;

import javax.mail.MessagingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;

@WebServlet(urlPatterns = "/contact")
public class ContactController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("views/contact.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        ContactDAO contactDAO = new ContactDAOImpl();
        try {
            String subject = request.getParameter("subject");
            String message = request.getParameter("message");

            Contact contact = Contact.builder()
                    .fullName(request.getParameter("fullName"))
                    .email(request.getParameter("email"))
                    .subject(subject)
                    .message(message)
                    .sentDate(new Date(System.currentTimeMillis()))
                    .build();
            if (contactDAO.addNewContact(contact)) {
                try {
                    SendEmail.send("user25060504@gmail.com", subject, message, "tungnguyenn050499@gmail.com", "gunskovfuvzocnyv");
                } catch (MessagingException e) {
                    e.printStackTrace();
                }
            }
        } catch (SQLException e) {
            request.getRequestDispatcher("views/error.jsp").forward(request, response);
        }
    }
}
