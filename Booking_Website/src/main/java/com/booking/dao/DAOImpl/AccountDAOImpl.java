package com.booking.dao.DAOImpl;

import com.booking.dao.IDAO.AccountDAO;
import com.booking.entity.Account;
import com.booking.jdbc.DBUtils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AccountDAOImpl implements AccountDAO {
    @Override
    public Account login(Account a) throws SQLException {
        Account account = null;
        String sql = "SELECT * FROM dbo.Account WHERE Email = ? AND Password = ?";
        try (Connection connection = DBUtils.getInstance().getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql);) {
            preparedStatement.setString(1, a.getEmail());
            preparedStatement.setString(2, a.getPassword());

            ResultSet result = preparedStatement.executeQuery();
            try {
                while (result.next()) {
                    int i = 0;
                    account = Account.builder()
                            .accountId(result.getInt(++i))
                            .fullName(result.getString(++i))
                            .email(result.getString(++i))
                            .password(result.getString(++i))
                            .address(result.getString(++i))
                            .phone(result.getString(++i))
                            .dateOfBirth(result.getDate(++i))
                            .country(result.getString(++i))
                            .image(result.getString(++i))
                            .role(result.getInt(++i))
                            .build();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new SQLException();
        }
        return account;
    }

    @Override
    public Boolean addNewAccount(Account account) throws SQLException {
        boolean check = false;
        String sql = "INSERT INTO dbo.Account ( FullName, Email, Password, Address, Phone, DateOfBirth, Country, Image, Role )\n" +
                "VALUES ( ?, ?, ?, ?, ?, ?, ?, ?, ? )\n" +
                "SELECT @@ROWCOUNT";
        try (Connection connection = DBUtils.getInstance().getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql);) {
            int i = 0;
            if (account.getImage().isEmpty()) {
                account.setImage("user-default.png");
            }
            preparedStatement.setString(++i, account.getFullName());
            preparedStatement.setString(++i, account.getEmail());
            preparedStatement.setString(++i, account.getPassword());
            preparedStatement.setString(++i, account.getAddress());
            preparedStatement.setString(++i, account.getPhone());
            preparedStatement.setDate(++i, account.getDateOfBirth());
            preparedStatement.setString(++i, account.getCountry());
            preparedStatement.setString(++i, account.getImage());
            preparedStatement.setInt(++i, account.getRole());

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
    public Boolean updateAccount(Account account) throws SQLException {
        boolean check = false;
        String sql = "UPDATE dbo.Account\n" +
                "SET FullName = ? , Email = ? , Password = ? , Address = ? , Phone = ? , DateOfBirth = ? , Country = ? , Image = ? , Role = ? \n" +
                "WHERE AccountId = ?\n" +
                "SELECT @@ROWCOUNT";
        try (Connection connection = DBUtils.getInstance().getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql);) {
            int i = 0;
            preparedStatement.setString(++i, account.getFullName());
            preparedStatement.setString(++i, account.getEmail());
            preparedStatement.setString(++i, account.getPassword());
            preparedStatement.setString(++i, account.getAddress());
            preparedStatement.setString(++i, account.getPhone());
            preparedStatement.setDate(++i, account.getDateOfBirth());
            preparedStatement.setString(++i, account.getCountry());
            preparedStatement.setString(++i, account.getImage());
            preparedStatement.setInt(++i, account.getRole());
            preparedStatement.setInt(++i, account.getAccountId());

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
    public Boolean deleteAccount(int accountId) throws SQLException {
        boolean check = false;
        String sql = "DELETE FROM dbo.Account\n" +
                "WHERE AccountId = ?\n" +
                "SELECT @@ROWCOUNT";
        try (Connection connection = DBUtils.getInstance().getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql);) {
            int i = 0;
            preparedStatement.setInt(++i, accountId);

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
        String sql = "SELECT * FROM dbo.Account WHERE Email LIKE ?";
        try (Connection connection = DBUtils.getInstance().getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql);) {
            int i = 0;
            preparedStatement.setString(++i, "%" + email + "%");

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
    public Boolean changePassword(Account account) throws SQLException {
        boolean check = false;
        String sql = "UPDATE dbo.Account \n" +
                "SET Password = ?\n" +
                "WHERE AccountId = ?\n" +
                "SELECT @@ROWCOUNT";
        try (Connection connection = DBUtils.getInstance().getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql);) {
            int i = 0;
            preparedStatement.setString(++i, account.getPassword());
            preparedStatement.setInt(++i, account.getAccountId());

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
    public Account getAccountById(int id) throws SQLException {
        Account account = null;
        String sql = "SELECT * FROM dbo.Account WHERE AccountId = ?";
        try (Connection connection = DBUtils.getInstance().getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql);) {
            preparedStatement.setInt(1, id);

            ResultSet result = preparedStatement.executeQuery();
            try {
                while (result.next()) {
                    int i = 0;
                    account = Account.builder()
                            .accountId(result.getInt(++i))
                            .fullName(result.getString(++i))
                            .email(result.getString(++i))
                            .password(result.getString(++i))
                            .address(result.getString(++i))
                            .phone(result.getString(++i))
                            .dateOfBirth(result.getDate(++i))
                            .country(result.getString(++i))
                            .image(result.getString(++i))
                            .role(result.getInt(++i))
                            .build();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new SQLException();
        }
        return account;
    }

    @Override
    public List<Account> getAllAccount() throws SQLException {
        List<Account> list = new ArrayList<>();
        String sql = "SELECT * FROM dbo.Account";
        try (Connection connection = DBUtils.getInstance().getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql);) {

            ResultSet result = preparedStatement.executeQuery();
            try {
                while (result.next()) {
                    int i = 0;
                    Account account = Account.builder()
                            .accountId(result.getInt(++i))
                            .fullName(result.getString(++i))
                            .email(result.getString(++i))
                            .password(result.getString(++i))
                            .address(result.getString(++i))
                            .phone(result.getString(++i))
                            .dateOfBirth(result.getDate(++i))
                            .country(result.getString(++i))
                            .image(result.getString(++i))
                            .role(result.getInt(++i))
                            .build();
                    list.add(account);
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

//    public static void main(String[] args) {
//        Room room = Room.builder().hotelName("asd").build();
//        System.out.println(room.getHotelName());
//    }
}
