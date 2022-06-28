package com.booking.dao.DAOImpl;

import com.booking.dao.IDAO.BookingDAO;
import com.booking.entity.Booking;
import com.booking.jdbc.DBUtils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BookingDAOImpl implements BookingDAO {
    @Override
    public Boolean addNewBooking(Booking booking) throws SQLException {
        boolean check = false;
        String sql = "INSERT INTO dbo.Booking ( AccountId, TimeCheckin, GuestNumber, Note, BookingDate, DateFrom, DateTo, Totalprice, Payment, BookingStatusId )\n" +
                "VALUES ( ? , ? , ? , ? , ? , ? , ? , ? , ? , ? )\n" +
                "SELECT @@ROWCOUNT";
        try (Connection connection = DBUtils.getInstance().getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql);) {
            int i = 0;
            preparedStatement.setInt(++i, booking.getAccountId());
            preparedStatement.setString(++i, booking.getTimeCheckin());
            preparedStatement.setInt(++i, booking.getGuestNumber());
            preparedStatement.setString(++i, booking.getNote());
            preparedStatement.setDate(++i, booking.getBookingDate());
            preparedStatement.setDate(++i, booking.getDateFrom());
            preparedStatement.setDate(++i, booking.getDateTo());
            preparedStatement.setDouble(++i, booking.getTotalPrice());
            preparedStatement.setString(++i, booking.getPayment());
            preparedStatement.setInt(++i, booking.getBookingStatusId());

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
    public Boolean updateBooking(Booking booking) throws SQLException {
        boolean check = false;
        String sql = "UPDATE dbo.Booking\n" +
                "SET AccountId = ?, TimeCheckin = ?, GuestNumber = ?, Note = ?, BookingDate = ?, DateFrom = ?, DateTo = ?, Totalprice = ?, BookingStatusId = ?\n" +
                "WHERE BookingId = ?\n" +
                "SELECT @@ROWCOUNT";
        try (Connection connection = DBUtils.getInstance().getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql);) {
            int i = 0;
            preparedStatement.setInt(++i, booking.getAccountId());
            preparedStatement.setString(++i, booking.getTimeCheckin());
            preparedStatement.setInt(++i, booking.getGuestNumber());
            preparedStatement.setString(++i, booking.getNote());
            preparedStatement.setDate(++i, booking.getBookingDate());
            preparedStatement.setDate(++i, booking.getDateFrom());
            preparedStatement.setDate(++i, booking.getDateTo());
            preparedStatement.setDouble(++i, booking.getTotalPrice());
            preparedStatement.setInt(++i, booking.getBookingStatusId());
            preparedStatement.setInt(++i, booking.getBookingId());

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
    public Boolean deleteBooking(int bookingId) throws SQLException {
        boolean check = false;
        String sql = "DELETE FROM dbo.Rating WHERE BookingId = ?\n" +
                "DELETE FROM dbo.BookingDetail WHERE BookingId = ?\n" +
                "DELETE FROM dbo.Booking WHERE BookingId = ?\n" +
                "SELECT @@ROWCOUNT";
        try (Connection connection = DBUtils.getInstance().getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql);) {
            int i = 0;
            preparedStatement.setInt(++i, bookingId);
            preparedStatement.setInt(++i, bookingId);
            preparedStatement.setInt(++i, bookingId);

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
    public Booking getLastBooking(int accountId) throws SQLException {
        Booking booking = null;
        String sql = "SELECT TOP 1 * FROM dbo.Booking\n" +
                "WHERE AccountId = ?\n" +
                "ORDER BY BookingId DESC";
        try (Connection connection = DBUtils.getInstance().getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql);) {
            preparedStatement.setInt(1, accountId);

            ResultSet result = preparedStatement.executeQuery();
            try {
                while (result.next()) {
                    int i = 0;
                    booking = Booking.builder()
                            .bookingId(result.getInt(++i))
                            .accountId(result.getInt(++i))
                            .timeCheckin(result.getString(++i))
                            .guestNumber(result.getInt(++i))
                            .note(result.getString(++i))
                            .bookingDate(result.getDate(++i))
                            .dateFrom(result.getDate(++i))
                            .dateTo(result.getDate(++i))
                            .totalPrice(result.getDouble(++i))
                            .payment(result.getString(++i))
                            .bookingStatusId(result.getInt(++i))
                            .build();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new SQLException();
        }
        return booking;
    }

    @Override
    public Boolean finishBooking(Booking booking) throws SQLException {
        boolean check = false;
        String sql = "UPDATE dbo.Booking\n" +
                "SET Payment = ?, BookingStatusId = 2\n" +
                "WHERE BookingId = ?\n" +
                "SELECT @@ROWCOUNT";
        try (Connection connection = DBUtils.getInstance().getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql);) {
            int i = 0;
            preparedStatement.setString(++i, booking.getPayment());
            preparedStatement.setInt(++i, booking.getBookingId());

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
    public Booking getBookingById(int bookingId) throws SQLException {
        Booking booking = null;
        String sql = "SELECT * FROM dbo.Booking WHERE BookingId = ?";
        try (Connection connection = DBUtils.getInstance().getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql);) {
            preparedStatement.setInt(1, bookingId);

            ResultSet result = preparedStatement.executeQuery();
            try {
                while (result.next()) {
                    int i = 0;
                    booking = Booking.builder()
                            .bookingId(result.getInt(++i))
                            .accountId(result.getInt(++i))
                            .timeCheckin(result.getString(++i))
                            .guestNumber(result.getInt(++i))
                            .note(result.getString(++i))
                            .bookingDate(result.getDate(++i))
                            .dateFrom(result.getDate(++i))
                            .dateTo(result.getDate(++i))
                            .totalPrice(result.getDouble(++i))
                            .payment(result.getString(++i))
                            .bookingStatusId(result.getInt(++i))
                            .build();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new SQLException();
        }
        return booking;
    }

    @Override
    public Boolean checkoutBooking(int bookingId, int bookingStatusId) throws SQLException {
        boolean check = false;
        String sql = "UPDATE dbo.Booking \n" +
                "SET BookingStatusId = ?\n" +
                "WHERE BookingId = ?\n" +
                "SELECT @@ROWCOUNT";
        try (Connection connection = DBUtils.getInstance().getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql);) {
            int i = 0;
            preparedStatement.setInt(++i, bookingStatusId);
            preparedStatement.setInt(++i, bookingId);

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
    public List<Booking> getAllBooking() throws SQLException {
        List<Booking> list = new ArrayList<>();
        String sql = "SELECT * FROM dbo.Booking";
        try (Connection connection = DBUtils.getInstance().getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql);) {

            ResultSet result = preparedStatement.executeQuery();
            try {
                while (result.next()) {
                    int i = 0;
                    Booking booking = Booking.builder()
                            .bookingId(result.getInt(++i))
                            .accountId(result.getInt(++i))
                            .timeCheckin(result.getString(++i))
                            .guestNumber(result.getInt(++i))
                            .note(result.getString(++i))
                            .bookingDate(result.getDate(++i))
                            .dateFrom(result.getDate(++i))
                            .dateTo(result.getDate(++i))
                            .totalPrice(result.getDouble(++i))
                            .payment(result.getString(++i))
                            .bookingStatusId(result.getInt(++i))
                            .build();
                    list.add(booking);
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

    public static void main(String[] args) {
        BookingDAO bookingDAO = new BookingDAOImpl();
        try {
            List<Booking> bookingList = bookingDAO.getAllBooking();
            for (Booking b: bookingList
                 ) {
                System.out.println(b);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }
}
