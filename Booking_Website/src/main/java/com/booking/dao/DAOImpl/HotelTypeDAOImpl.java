package com.booking.dao.DAOImpl;

import com.booking.dao.IDAO.HotelTypeDAO;
import com.booking.entity.City;
import com.booking.entity.HotelType;
import com.booking.jdbc.DBUtils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class HotelTypeDAOImpl implements HotelTypeDAO {
    @Override
    public List<HotelType> getAll() throws SQLException {
        List<HotelType> list = new ArrayList<>();
        String sql = "SELECT * FROM dbo.HotelType";
        try (Connection connection = DBUtils.getInstance().getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql);) {

            ResultSet result = preparedStatement.executeQuery();
            try {
                while (result.next()) {
                    int i = 0;
                    HotelType hotelType = HotelType.builder()
                            .typeId(result.getInt(1))
                            .typeName(result.getString(2))
                            .hotelTypeImage(result.getString(3))
                            .build();
                    list.add(hotelType);
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
    public int getCountHotelTypeById(int id) throws SQLException {
        int count = 0;
        String sql = "SELECT COUNT(*) AS count FROM dbo.HotelType ht JOIN dbo.Hotel h\n" +
                "ON h.HotelTypeId = ht.TypeId\n" +
                "WHERE ht.TypeId = ?";
        try (Connection connection = DBUtils.getInstance().getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql);) {
            preparedStatement.setInt(1, id);

            ResultSet result = preparedStatement.executeQuery();
            try {
                if (result.next()) {
                    count = result.getInt(1);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new SQLException();
        }
        return count;
    }

    @Override
    public String getHotelTypeById(int id) throws SQLException {
        String name = "";
        String sql = "SELECT TypeName FROM dbo.HotelType WHERE TypeId = ?";
        try (Connection connection = DBUtils.getInstance().getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql);) {
            preparedStatement.setInt(1, id);

            ResultSet result = preparedStatement.executeQuery();
            try {
                if (result.next()) {
                    name = result.getString(1);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new SQLException();
        }
        return name;
    }

    @Override
    public HotelType getHotelTypeByTypeId(int typeId) throws SQLException {
        HotelType hotelType = null;
        String sql = "SELECT * FROM dbo.HotelType WHERE TypeId = ?";
        try (Connection connection = DBUtils.getInstance().getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql);) {
            preparedStatement.setInt(1, typeId);

            ResultSet result = preparedStatement.executeQuery();
            try {
                while (result.next()) {
                    hotelType = HotelType.builder()
                            .typeId(result.getInt(1))
                            .typeName(result.getString(2))
                            .hotelTypeImage(result.getString(3))
                            .build();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new SQLException();
        }
        return hotelType;
    }

    @Override
    public Boolean addHotelType(HotelType hotelType) throws SQLException {
        boolean check = false;
        String sql = "INSERT INTO dbo.HotelType ( TypeName, TypeImage )\n" +
                "VALUES ( ? , ?)\n" +
                "SELECT @@ROWCOUNT";
        try (Connection connection = DBUtils.getInstance().getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql);) {
            preparedStatement.setString(1, hotelType.getTypeName());
            preparedStatement.setString(2, hotelType.getHotelTypeImage());

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
    public Boolean updateHotelType(HotelType hotelType) throws SQLException {
        boolean check = false;
        String sql = "UPDATE dbo.HotelType\n" +
                "SET TypeName = ?, TypeImage = ?\n" +
                "WHERE TypeId = ?\n" +
                "SELECT @@ROWCOUNT";
        try (Connection connection = DBUtils.getInstance().getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql);) {
            preparedStatement.setString(1, hotelType.getTypeName());
            preparedStatement.setString(2, hotelType.getHotelTypeImage());
            preparedStatement.setInt(3, hotelType.getTypeId());

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
    public Boolean deleteHotelType(int typeId) throws SQLException {
        boolean check = false;
        String sql = "DELETE FROM dbo.HotelService WHERE HotelId IN (SELECT HotelId FROM dbo.Hotel WHERE HotelTypeId = ?)\n" +
                "DELETE FROM dbo.BookingDetail WHERE RoomId IN (SELECT RoomId FROM dbo.Room WHERE HotelId IN (SELECT HotelId FROM dbo.Hotel WHERE HotelTypeId = ?))\n" +
                "DELETE FROM dbo.Room WHERE HotelId IN (SELECT HotelId FROM dbo.Hotel WHERE HotelTypeId = ?)\n" +
                "DELETE FROM dbo.Hotel WHERE HotelTypeId = ?\n" +
                "DELETE FROM dbo.HotelType WHERE TypeId = ?\n" +
                "SELECT @@ROWCOUNT";
        try (Connection connection = DBUtils.getInstance().getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql);) {
            int i = 0;
            preparedStatement.setInt(++i, typeId);
            preparedStatement.setInt(++i, typeId);
            preparedStatement.setInt(++i, typeId);
            preparedStatement.setInt(++i, typeId);
            preparedStatement.setInt(++i, typeId);

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
