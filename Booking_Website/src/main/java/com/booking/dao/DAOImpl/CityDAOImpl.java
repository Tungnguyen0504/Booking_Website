package com.booking.dao.DAOImpl;

import com.booking.dao.IDAO.CityDAO;
import com.booking.entity.City;
import com.booking.entity.Hotel;
import com.booking.jdbc.DBUtils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CityDAOImpl implements CityDAO {
    @Override
    public List<City> getAll() throws SQLException {
        List<City> list = new ArrayList<>();
        String sql = "SELECT * FROM dbo.City";
        try (Connection connection = DBUtils.getInstance().getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql);) {

            ResultSet result = preparedStatement.executeQuery();
            try {
                while (result.next()) {
                    City city = City.builder()
                            .cityId(result.getInt(1))
                            .cityName(result.getString(2))
                            .cityImage(result.getString(3))
                            .build();
                    list.add(city);
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
    public String getCityNameById(int cityId) throws SQLException {
        String name = "";
        String sql = "SELECT CityName FROM dbo.City WHERE CityId = ?";
        try (Connection connection = DBUtils.getInstance().getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql);) {
            preparedStatement.setInt(1, cityId);

            ResultSet result = preparedStatement.executeQuery();
            try {
                while (result.next()) {
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
    public City getCityById(int cityId) throws SQLException {
        City city = null;
        String sql = "SELECT * FROM dbo.City WHERE CityId = ?";
        try (Connection connection = DBUtils.getInstance().getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql);) {
            preparedStatement.setInt(1, cityId);

            ResultSet result = preparedStatement.executeQuery();
            try {
                while (result.next()) {
                    city = City.builder()
                            .cityId(result.getInt(1))
                            .cityName(result.getString(2))
                            .cityImage(result.getString(3))
                            .build();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new SQLException();
        }
        return city;
    }

    @Override
    public Boolean addCity(City city) throws SQLException {
        boolean check = false;
        String sql = "INSERT INTO dbo.City ( CityName, CityImage )\n" +
                "VALUES ( ? , ?)\n" +
                "SELECT @@ROWCOUNT";
        try (Connection connection = DBUtils.getInstance().getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql);) {
            preparedStatement.setString(1, city.getCityName());
            preparedStatement.setString(2, city.getCityImage());

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
    public Boolean updateCity(City city) throws SQLException {
        boolean check = false;
        String sql = "UPDATE dbo.City \n" +
                "SET CityName = ?, CityImage = ?\n" +
                "WHERE CityId = ?\n" +
                "SELECT @@ROWCOUNT";
        try (Connection connection = DBUtils.getInstance().getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql);) {
            preparedStatement.setString(1, city.getCityName());
            preparedStatement.setString(2, city.getCityImage());
            preparedStatement.setInt(3, city.getCityId());

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
    public Boolean deleteCity(int cityId) throws SQLException {
        boolean check = false;
        String sql = "DELETE dbo.HotelService WHERE HotelId IN (SELECT HotelId FROM dbo.Hotel WHERE CityId = ?)\n" +
                "DELETE dbo.BookingDetail WHERE RoomId IN (SELECT RoomId FROM dbo.Room WHERE HotelId IN (SELECT HotelId FROM dbo.Hotel WHERE CityId = ?))\n" +
                "DELETE dbo.Room WHERE HotelId IN (SELECT HotelId FROM dbo.Hotel WHERE CityId = ?)\n" +
                "DELETE dbo.Hotel WHERE CityId = ?\n" +
                "DELETE dbo.City WHERE CityId= ?\n" +
                "SELECT @@ROWCOUNT";
        try (Connection connection = DBUtils.getInstance().getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql);) {
            int i = 0;
            preparedStatement.setInt(++i, cityId);
            preparedStatement.setInt(++i, cityId);
            preparedStatement.setInt(++i, cityId);
            preparedStatement.setInt(++i, cityId);
            preparedStatement.setInt(++i, cityId);

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
