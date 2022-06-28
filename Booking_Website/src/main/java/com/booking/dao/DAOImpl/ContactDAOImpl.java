package com.booking.dao.DAOImpl;

import com.booking.dao.IDAO.ContactDAO;
import com.booking.entity.Contact;
import com.booking.jdbc.DBUtils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ContactDAOImpl implements ContactDAO {
    @Override
    public Boolean addNewContact(Contact contact) throws SQLException {
        boolean check = false;
        String sql = "INSERT INTO dbo.Contact ( FullName, Email, Subject, Message, SentDate )\n" +
                "VALUES ( N'" + contact.getFullName() + "' , N'" + contact.getEmail() + "' , N'" + contact.getSubject() + "' , N'" + contact.getMessage() + "', N'" + contact.getSentDate() + "')\n" +
                "SELECT @@ROWCOUNT";
        try (Connection connection = DBUtils.getInstance().getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql);) {

            ResultSet result = preparedStatement.executeQuery();
            try {
                while (result.next()) {
                    if (result.getInt(1) == 1) {
                        check = true;
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new SQLException();
        }
        return check;
    }

    @Override
    public boolean checkEmailUnique(String email) throws SQLException {
        boolean check = false;
        String sql = "SELECT * FROM dbo.Contact WHERE Email LIKE '%" + email + "%'";
        try (Connection connection = DBUtils.getInstance().getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql);) {

            ResultSet result = preparedStatement.executeQuery();
            try {
                if (result.next()) {
                    check = true;
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new SQLException();
        }
        return check;
    }

    @Override
    public List<Contact> getAll() throws SQLException {
        List<Contact> list = new ArrayList<>();
        String sql = "SELECT * FROM dbo.Contact";
        try (Connection connection = DBUtils.getInstance().getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql);) {

            ResultSet result = preparedStatement.executeQuery();
            try {
                while (result.next()) {
                    Contact contact = Contact.builder()
                            .contactId((result.getInt(1)))
                            .fullName(result.getString(2))
                            .email(result.getString(3))
                            .subject(result.getString(4))
                            .message(result.getString(5))
                            .sentDate(result.getDate(6))
                            .build();
                    list.add(contact);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new SQLException();
        }
        return list;
    }

    @Override
    public Contact getContactById(int contactId) throws SQLException {
        Contact contact = null;
        String sql = "SELECT * FROM dbo.Contact WHERE ContactId = ?";
        try (Connection connection = DBUtils.getInstance().getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql);) {
            preparedStatement.setInt(1, contactId);

            ResultSet result = preparedStatement.executeQuery();
            try {
                while (result.next()) {
                    contact = Contact.builder()
                            .contactId((result.getInt(1)))
                            .fullName(result.getString(2))
                            .email(result.getString(3))
                            .subject(result.getString(4))
                            .message(result.getString(5))
                            .sentDate(result.getDate(6))
                            .build();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new SQLException();
        }
        return contact;
    }

    @Override
    public Boolean deleteContact(int contactId) throws SQLException {
        boolean check = false;
        String sql = "DELETE FROM dbo.Contact WHERE ContactId = ?\n" +
                "SELECT @@ROWCOUNT";
        try (Connection connection = DBUtils.getInstance().getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql);) {
            int i = 0;
            preparedStatement.setInt(++i, contactId);

            ResultSet result = preparedStatement.executeQuery();
            try {
                while (result.next()) {
                    if (result.getInt(1) == 1) {
                        check = true;
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new SQLException();
        }
        return check;
    }
}
