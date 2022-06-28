package com.booking.dao.DAOImpl;

import com.booking.dao.IDAO.BookingStatusDAO;
import com.booking.entity.Booking;
import com.booking.jdbc.DBUtils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class BookingStatusDAOImpl implements BookingStatusDAO {
    @Override
    public String getBookingStatusByStatusId(int id) throws SQLException {
        String status = "";
        String sql = "SELECT StatusName FROM dbo.BookingStatus WHERE StatusId = ?";
        try (Connection connection = DBUtils.getInstance().getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql);) {
            int i = 0;
            preparedStatement.setInt(++i, id);

            ResultSet result = preparedStatement.executeQuery();
            try {
                while (result.next()) {
                    status = result.getString(1);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new SQLException();
        }
        return status;
    }
}
