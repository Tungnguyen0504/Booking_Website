package com.booking.controller;

import com.booking.dao.DAOImpl.AccountDAOImpl;
import com.booking.dao.IDAO.AccountDAO;
import com.booking.entity.Account;
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

@WebServlet(urlPatterns = "/admin-manage-account")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
        maxFileSize = 1024 * 1024 * 10,      // 10 MB
        maxRequestSize = 1024 * 1024 * 100   // 100 MB
)
public class AdminManageAccountController extends HttpServlet {

    static AccountDAO accountDAO = new AccountDAOImpl();

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
        if (action != null && action.equals("addAccount")) {
            request.setAttribute("action", "add");
            request.getRequestDispatcher("views/admin-form-account.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String action = request.getParameter("action");
        if (action != null && action.equals("addAccount")) {
            doPost_addAccount(request, response);
        }
        if (action != null && action.equals("updateAccount")) {
            doPost_updateAccount(request, response);
        }
        if (action != null && action.equals("deleteAccount")) {
            doPost_deleteAccount(request, response);
        }
    }

    private void doPost_deleteAccount(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int accountId = Integer.parseInt(request.getParameter("accountId"));
            String name = accountDAO.getAccountById(accountId).getFullName();

            PrintWriter out = response.getWriter();
            ObjectMapper mapper = new ObjectMapper();

            if (accountDAO.deleteAccount(accountId)) {
                out.print(mapper.writeValueAsString(name));
            }
        } catch (SQLException e) {
            request.getRequestDispatcher("views/error.jsp").forward(request, response);
        }
    }

    private void doPost_updateAccount(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int accountId = Integer.parseInt(request.getParameter("accountId"));
            //get image and upload into folder
            String fileName = "";
            boolean check;
            try {
                Part filePart = request.getPart("image");
                fileName = filePart.getSubmittedFileName();
                String tmp = getServletContext().getRealPath("uploads");
                filePart.write(tmp.substring(0, tmp.indexOf("target")).concat("src\\main\\webapp\\uploads\\accounts\\") + fileName);
                check = true;
            } catch (Exception e) {
                check = false;
            }

            if (!check) {
                fileName = accountDAO.getAccountById(accountId).getImage();
            }

            //convert date
            Date date = FunctionUtil.convertStringToUtilDate(request.getParameter("dateOfBirth"));
            java.sql.Date dateOfBirth = new java.sql.Date(date.getTime());

            Account account = Account.builder()
                    .accountId(accountId)
                    .fullName(request.getParameter("fullName"))
                    .email(request.getParameter("email"))
                    .password(request.getParameter("password"))
                    .address(request.getParameter("address"))
                    .phone(request.getParameter("phone"))
                    .dateOfBirth(dateOfBirth)
                    .country(request.getParameter("country"))
                    .image(fileName)
                    .role(Integer.parseInt(request.getParameter("role")))
                    .build();
            if (accountDAO.updateAccount(account)) {
                request.setAttribute("acc", account);
                request.setAttribute("action", "update");

                request.setAttribute("alert", "                            <script>\n" +
                        "                                swal(\"Thành công!\", \"Đã cập nhật tài khoản\", \"success\");\n" +
                        "                            </script>");
                request.getRequestDispatcher("views/admin-form-account.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            request.getRequestDispatcher("views/error.jsp").forward(request, response);
        }
    }

    private void doPost_addAccount(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            //get image and upload into folder
            Part filePart = request.getPart("image");
            String fileName = filePart.getSubmittedFileName();
            for (Part part : request.getParts()) {
                String tmp = getServletContext().getRealPath("uploads");
                part.write(tmp.substring(0, tmp.indexOf("target")).concat("src\\main\\webapp\\uploads\\accounts\\") + fileName);
            }

            //convert date
            Date date = FunctionUtil.convertStringToUtilDate(request.getParameter("dateOfBirth"));
            java.sql.Date dateOfBirth = new java.sql.Date(date.getTime());

            Account account = Account.builder()
                    .fullName(request.getParameter("fullName"))
                    .email(request.getParameter("email"))
                    .password(request.getParameter("password"))
                    .address(request.getParameter("address"))
                    .phone(request.getParameter("phone"))
                    .dateOfBirth(dateOfBirth)
                    .country(request.getParameter("country"))
                    .image(fileName)
                    .role(Integer.parseInt(request.getParameter("role")))
                    .build();
            if (accountDAO.addNewAccount(account)) {
                request.setAttribute("acc", account);
                request.setAttribute("action", "add");

                request.setAttribute("alert", "                            <script>\n" +
                        "                                swal(\"Thành công!\", \"Đã thêm mới tài khoản\", \"success\");\n" +
                        "                            </script>");
                request.getRequestDispatcher("views/admin-form-account.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            request.getRequestDispatcher("views/error.jsp").forward(request, response);
        }
    }

    private void doGet_getInfor(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int accountId = Integer.parseInt(request.getParameter("accountId"));

            Account account = accountDAO.getAccountById(accountId);

            request.setAttribute("acc", account);
            request.setAttribute("action", "update");
            request.getRequestDispatcher("views/admin-form-account.jsp").forward(request, response);
        } catch (SQLException e) {
            request.getRequestDispatcher("views/error.jsp").forward(request, response);
        }
    }

    private void doGet_index(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            List<Account> accountList = accountDAO.getAllAccount();

            request.setAttribute("accountList", accountList);
            request.getRequestDispatcher("views/admin-manage-account.jsp").forward(request, response);
        } catch (SQLException e) {
            request.getRequestDispatcher("views/error.jsp").forward(request, response);
        }
    }
}
