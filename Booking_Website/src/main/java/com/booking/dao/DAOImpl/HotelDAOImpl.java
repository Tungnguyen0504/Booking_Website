package com.booking.dao.DAOImpl;

import com.booking.dao.IDAO.HotelDAO;
import com.booking.entity.Hotel;
import com.booking.jdbc.DBUtils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class HotelDAOImpl implements HotelDAO {

    @Override
    public List<Hotel> getAll() throws SQLException {
        List<Hotel> list = new ArrayList<>();
        String sql = "SELECT * FROM dbo.Hotel";
        try (Connection connection = DBUtils.getInstance().getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql);) {

            ResultSet result = preparedStatement.executeQuery();
            try {
                while (result.next()) {
                    Hotel hotel = Hotel.builder()
                            .hotelId(result.getInt("HotelId"))
                            .cityId(result.getInt("CityId"))
                            .hotelTypeId(result.getInt("HotelTypeId"))
                            .hotelName(result.getString("HotelName"))
                            .address(result.getString("Address"))
                            .phone(result.getString("Phone"))
                            .email(result.getString("Email"))
                            .star(result.getInt("Star"))
                            .specialAround(result.getString("SpecialAround"))
                            .description(result.getString("Description"))
                            .hotelImage(result.getString("HotelImage"))
                            .checkin(result.getTime("Checkin"))
                            .checkout(result.getTime("Checkout"))
                            .createdDate(result.getDate("CreatedDate"))
                            .build();
                    list.add(hotel);
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
    public Hotel getHotelById(int hotelId) throws SQLException {
        Hotel hotel = null;
        String sql = "SELECT * FROM dbo.Hotel WHERE HotelId = ?";
        try (Connection connection = DBUtils.getInstance().getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql);) {
            preparedStatement.setInt(1, hotelId);

            ResultSet result = preparedStatement.executeQuery();
            try {
                while (result.next()) {
                    hotel = Hotel.builder()
                            .hotelId(result.getInt("HotelId"))
                            .cityId(result.getInt("CityId"))
                            .hotelTypeId(result.getInt("HotelTypeId"))
                            .hotelName(result.getString("HotelName"))
                            .address(result.getString("Address"))
                            .phone(result.getString("Phone"))
                            .email(result.getString("Email"))
                            .star(result.getInt("Star"))
                            .specialAround(result.getString("SpecialAround"))
                            .description(result.getString("Description"))
                            .hotelImage(result.getString("HotelImage"))
                            .checkin(result.getTime("Checkin"))
                            .checkout(result.getTime("Checkout"))
                            .createdDate(result.getDate("CreatedDate"))
                            .build();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new SQLException();
        }
        return hotel;
    }

    @Override
    public int countHotelByCityId(int cityId) throws SQLException {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM dbo.Hotel WHERE CityId = ?";
        try (Connection connection = DBUtils.getInstance().getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql);) {
            preparedStatement.setInt(1, cityId);

            ResultSet result = preparedStatement.executeQuery();
            try {
                while (result.next()) {
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
    public int getMinHotelPriceByCityId(int cityId) throws SQLException {
        int price = 0;
        String sql = "SELECT MIN(r.Price * (100 - r.DiscountPercent) / 100) FROM dbo.Hotel h JOIN dbo.Room r\n" +
                "ON r.HotelId = h.HotelId\n" +
                "WHERE h.CityId = ?";
        try (Connection connection = DBUtils.getInstance().getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql);) {
            preparedStatement.setInt(1, cityId);

            ResultSet result = preparedStatement.executeQuery();
            try {
                while (result.next()) {
                    price = result.getInt(1);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new SQLException();
        }
        return price;
    }

    @Override
    public List<Hotel> getRandomTop9() throws SQLException {
        List<Hotel> list = new ArrayList<>();
        String sql = "SELECT TOP 9 * FROM dbo.Hotel\n" +
                "ORDER BY NEWID()";
        try (Connection connection = DBUtils.getInstance().getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql);) {

            ResultSet result = preparedStatement.executeQuery();
            try {
                while (result.next()) {
                    Hotel hotel = Hotel.builder()
                            .hotelId(result.getInt("HotelId"))
                            .hotelTypeId(result.getInt("HotelTypeId"))
                            .hotelName(result.getString("HotelName"))
                            .hotelImage(result.getString("HotelImage")).build();
                    list.add(hotel);
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

    /*
SELECT DISTINCT h.*, dbo.UF_RatingPoint(h.HotelId), dbo.UF_CalculateRoomPrice(h.HotelId)
FROM dbo.Hotel h JOIN dbo.City c
ON c.CityId = h.CityId JOIN dbo.Room ro
ON ro.HotelId = h.HotelId
WHERE (h.HotelName LIKE N'%%' OR Address LIKE N'%%' OR c.CityName LIKE N'%%')
AND h.HotelTypeId = 2
ORDER BY dbo.UF_RatingPoint(h.HotelId) DESC
OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY
    */
    @Override
    public List<Hotel> searchHotel(String name, String filter, int index, int size) throws SQLException {
        List<Hotel> list = new ArrayList<>();
        String sql = "SELECT DISTINCT h.*, dbo.UF_RatingPoint(h.HotelId), dbo.UF_CalculateRoomPrice(h.HotelId)\n" +
                "FROM dbo.Hotel h JOIN dbo.City c\n" +
                "ON c.CityId = h.CityId JOIN dbo.Room ro\n" +
                "ON ro.HotelId = h.HotelId\n" +
                "WHERE (h.HotelName LIKE N'%" + name.trim() + "%' OR Address LIKE N'%" + name.trim() + "%' OR c.CityName LIKE N'%" + name.trim() + "%')\n";
        if (!filter.trim().isEmpty()) {
            sql += filter;
        } else {
            sql += "ORDER BY h.HotelId\n";
        }
        sql += "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try (Connection connection = DBUtils.getInstance().getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql);) {
            preparedStatement.setInt(1, (index - 1) * size);
            preparedStatement.setInt(2, size);

            ResultSet result = preparedStatement.executeQuery();
            try {
                while (result.next()) {
                    Hotel hotel = Hotel.builder()
                            .hotelId(result.getInt("HotelId"))
                            .cityId(result.getInt("CityId"))
                            .hotelTypeId(result.getInt("HotelTypeId"))
                            .hotelName(result.getString("HotelName"))
                            .address(result.getString("Address"))
                            .star(result.getInt("Star"))
                            .hotelImage(result.getString("HotelImage")).build();
                    list.add(hotel);
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
    public int countSearchHotel(String name, String filter) throws SQLException {
        int count = 0;
        String sql = "SELECT COUNT(*)\n" +
                "FROM dbo.Hotel h JOIN dbo.City c\n" +
                "ON c.CityId = h.CityId\n" +
                "WHERE (h.HotelName LIKE N'%" + name.trim() + "%' OR Address LIKE N'%" + name.trim() + "%' OR c.CityName LIKE N'%" + name.trim() + "%')\n";
        if (!filter.trim().isEmpty()) {
            sql += filter;
        }
        try (Connection connection = DBUtils.getInstance().getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql);) {

            ResultSet result = preparedStatement.executeQuery();
            try {
                while (result.next()) {
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
    public int getLastHotelId() throws SQLException {
        int hotelId = 0;
        String sql = "SELECT TOP 1 HotelId FROM dbo.Hotel ORDER BY HotelId DESC";

        try (Connection connection = DBUtils.getInstance().getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql);) {

            ResultSet result = preparedStatement.executeQuery();
            try {
                while (result.next()) {
                    hotelId = result.getInt(1);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new SQLException();
        }
        return hotelId;
    }

    @Override
    public Boolean addNewHotel(Hotel hotel) throws SQLException {
        boolean check = false;
        String sql = "INSERT INTO dbo.Hotel ( CityId, HotelTypeId, HotelName, Address, Phone, Email, Star, SpecialAround, Description, HotelImage, CheckIn, CheckOut, CreatedDate )\n" +
                "VALUES ( ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , GETDATE() )\n" +
                "SELECT @@ROWCOUNT";
        try (Connection connection = DBUtils.getInstance().getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql);) {
            int i = 0;
            preparedStatement.setInt(++i, hotel.getCityId());
            preparedStatement.setInt(++i, hotel.getHotelTypeId());
            preparedStatement.setString(++i, hotel.getHotelName());
            preparedStatement.setString(++i, hotel.getAddress());
            preparedStatement.setString(++i, hotel.getPhone());
            preparedStatement.setString(++i, hotel.getEmail());
            preparedStatement.setInt(++i, hotel.getStar());
            preparedStatement.setString(++i, hotel.getSpecialAround());
            preparedStatement.setString(++i, hotel.getDescription());
            preparedStatement.setString(++i, hotel.getHotelImage());
            preparedStatement.setTime(++i, hotel.getCheckin());
            preparedStatement.setTime(++i, hotel.getCheckout());

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
    public Boolean updateHotel(Hotel hotel) throws SQLException {
        boolean check = false;
        String sql = "UPDATE dbo.Hotel\n" +
                "SET CityId = ?, HotelTypeId = ?, HotelName = ?, Address = ?, Phone = ?, Email = ?, Star = ?, \n" +
                "SpecialAround = ?, Description = ?, HotelImage = ?, CheckIn = ?, CheckOut = ?\n" +
                "WHERE HotelId = ?\n" +
                "SELECT @@ROWCOUNT";
        try (Connection connection = DBUtils.getInstance().getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql);) {
            int i = 0;
            preparedStatement.setInt(++i, hotel.getCityId());
            preparedStatement.setInt(++i, hotel.getHotelTypeId());
            preparedStatement.setString(++i, hotel.getHotelName());
            preparedStatement.setString(++i, hotel.getAddress());
            preparedStatement.setString(++i, hotel.getPhone());
            preparedStatement.setString(++i, hotel.getEmail());
            preparedStatement.setInt(++i, hotel.getStar());
            preparedStatement.setString(++i, hotel.getSpecialAround());
            preparedStatement.setString(++i, hotel.getDescription());
            preparedStatement.setString(++i, hotel.getHotelImage());
            preparedStatement.setTime(++i, hotel.getCheckin());
            preparedStatement.setTime(++i, hotel.getCheckout());
            preparedStatement.setInt(++i, hotel.getHotelId());

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
    public Boolean deleteHotel(int hotelId) throws SQLException {
        boolean check = false;
        String sql = "DELETE dbo.HotelService WHERE HotelId = ?\n" +
                "DELETE dbo.BookingDetail WHERE RoomId IN (SELECT RoomId FROM dbo.Room WHERE HotelId = ?)\n" +
                "DELETE dbo.Room WHERE HotelId = ?\n" +
                "DELETE dbo.Hotel WHERE HotelId = ?\n" +
                "SELECT @@ROWCOUNT";
        try (Connection connection = DBUtils.getInstance().getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql);) {
            int i = 0;
            preparedStatement.setInt(++i, hotelId);
            preparedStatement.setInt(++i, hotelId);
            preparedStatement.setInt(++i, hotelId);
            preparedStatement.setInt(++i, hotelId);
            preparedStatement.setInt(++i, hotelId);

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
