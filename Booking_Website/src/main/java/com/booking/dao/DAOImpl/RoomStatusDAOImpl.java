package com.booking.dao.DAOImpl;

import com.booking.dao.IDAO.RoomStatusDAO;
import com.booking.jdbc.DBUtils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class RoomStatusDAOImpl implements RoomStatusDAO {
    @Override
    public String getRoomStatusById(int id) throws SQLException {
        String status = "";
        String sql = "SELECT Status FROM dbo.RoomStatus\n" +
                "WHERE StatusId = ?";
        try (Connection connection = DBUtils.getInstance().getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql);) {
            preparedStatement.setInt(1, id);

            ResultSet result = preparedStatement.executeQuery();
            try {
                if (result.next()) {
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
