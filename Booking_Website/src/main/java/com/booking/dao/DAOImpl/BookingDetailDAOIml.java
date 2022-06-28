package com.booking.dao.DAOImpl;

import com.booking.dao.IDAO.BookingDetailDAO;
import com.booking.entity.Booking;
import com.booking.entity.BookingDetail;
import com.booking.jdbc.DBUtils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BookingDetailDAOIml implements BookingDetailDAO {
    @Override
    public BookingDetail getBookingDetailById(int bookingDetailId) throws SQLException {
        BookingDetail bookingDetail = null;
        String sql = "SELECT * FROM dbo.BookingDetail WHERE BookingDetailId = ?";
        try (Connection connection = DBUtils.getInstance().getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql);) {
            preparedStatement.setInt(1, bookingDetailId);

            ResultSet result = preparedStatement.executeQuery();
            try {
                while (result.next()) {
                    int i = 0;
                    bookingDetail = BookingDetail.builder()
                            .roomId(result.getInt(++i))
                            .bookingId(result.getInt(++i))
                            .quantityRoom(result.getInt(++i))
                            .subTotal(result.getDouble(++i))
                            .build();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new SQLException();
        }
        return bookingDetail;
    }

    @Override
    public List<BookingDetail> getAllByBookingId(int bookingId) throws SQLException {
        List<BookingDetail> list = new ArrayList<>();
        String sql = "SELECT * FROM BookingDetail WHERE BookingId = ?";
        try (Connection connection = DBUtils.getInstance().getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql);) {
            preparedStatement.setInt(1, bookingId);

            ResultSet result = preparedStatement.executeQuery();
            try {
                while (result.next()) {
                    int i = 0;
                    BookingDetail bookingDetail = BookingDetail.builder()
                            .roomId(result.getInt(++i))
                            .bookingId(result.getInt(++i))
                            .quantityRoom(result.getInt(++i))
                            .subTotal(result.getDouble(++i))
                            .build();
                    list.add(bookingDetail);
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
    public Boolean addNewBookingDetail(BookingDetail bookingDetail) throws SQLException {
        boolean check = false;
        String sql = "INSERT INTO dbo.BookingDetail ( RoomId, BookingId, QuantityRoom, SubTotal )\n" +
                "VALUES ( ? , ? , ? , ? )\n" +
                "SELECT @@ROWCOUNT";
        try (Connection connection = DBUtils.getInstance().getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql);) {
            int i = 0;
            preparedStatement.setInt(++i, bookingDetail.getRoomId());
            preparedStatement.setInt(++i, bookingDetail.getBookingId());
            preparedStatement.setInt(++i, bookingDetail.getQuantityRoom());
            preparedStatement.setDouble(++i, bookingDetail.getSubTotal());

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
    public Boolean deleteBookingDetailByBookingId(int bookingId) throws SQLException {
        boolean check = false;
        String sql = "DELETE FROM BookingDetail WHERE BookingId IN (?)\n" +
                "SELECT @@ROWCOUNT";
        try (Connection connection = DBUtils.getInstance().getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql);) {
            preparedStatement.setInt(1, bookingId);

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
