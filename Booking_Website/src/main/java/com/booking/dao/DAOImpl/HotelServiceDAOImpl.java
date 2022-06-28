package com.booking.dao.DAOImpl;

import com.booking.dao.IDAO.HotelServiceDAO;
import com.booking.entity.HotelService;
import com.booking.jdbc.DBUtils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class HotelServiceDAOImpl implements HotelServiceDAO {
    @Override
    public HotelService getHotelServiceByHotelId(int id) throws SQLException {
        HotelService hotelService = null;
        String sql = "SELECT * FROM dbo.Hotel h JOIN dbo.HotelService hv\n" +
                "ON hv.HotelId = h.HotelId\n" +
                "WHERE hv.HotelId = ?";
        try (Connection connection = DBUtils.getInstance().getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(sql);) {
            preparedStatement.setInt(1, id);

            ResultSet result = preparedStatement.executeQuery();
            try {
                while (result.next()) {
                    hotelService = HotelService.builder()
                            .serviceId(result.getInt("ServiceId"))
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
                            .serviceId(result.getInt("ServiceId"))
                            .bathroom(result.getString("Bathroom"))
                            .bedroom(result.getString("Bedroom"))
                            .dinningroom(result.getString("Dinningroom"))
                            .language(result.getString("Language"))
                            .internet(result.getString("Internet"))
                            .drinkAndFood(result.getString("DrinkAndFood"))
                            .receptionService(result.getString("ReceptionService"))
                            .cleaningService(result.getString("CleaningService"))
                            .pool(result.getString("Pool"))
                            .other(result.getString("Other"))
                            .build();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new SQLException();
        }
        return hotelService;
    }

    @Override
    public List<HotelService> getAllHotelService() throws SQLException {
        List<HotelService> list = new ArrayList<>();
        String sql = "SELECT * FROM dbo.Hotel h JOIN dbo.HotelService hs\n" +
                "ON hs.HotelId = h.HotelId";
        try (Connection connection = DBUtils.getInstance().getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(sql);) {

            ResultSet result = preparedStatement.executeQuery();
            try {
                while (result.next()) {
                    HotelService hotelService = HotelService.builder()
                            .hotelId(result.getInt("HotelId"))
                            .cityId(result.getInt("CityId"))
                            .hotelTypeId(result.getInt("HotelTypeId"))
                            .hotelName(result.getString("HotelName"))
                            .phone(result.getString("Phone"))
                            .email(result.getString("Email"))
                            .address(result.getString("Address"))
                            .star(result.getInt("Star"))
                            .specialAround(result.getString("SpecialAround"))
                            .description(result.getString("Description"))
                            .hotelImage(result.getString("HotelImage"))
                            .checkin(result.getTime("Checkin"))
                            .checkout(result.getTime("Checkout"))
                            .createdDate(result.getDate("CreatedDate"))
                            .serviceId(result.getInt("ServiceId"))
                            .bathroom(result.getString("Bathroom"))
                            .bedroom(result.getString("Bedroom"))
                            .dinningroom(result.getString("Dinningroom"))
                            .language(result.getString("Language"))
                            .internet(result.getString("Internet"))
                            .drinkAndFood(result.getString("DrinkAndFood"))
                            .receptionService(result.getString("ReceptionService"))
                            .cleaningService(result.getString("CleaningService"))
                            .pool(result.getString("Pool"))
                            .other(result.getString("Other"))
                            .build();
                    list.add(hotelService);
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
    public Boolean addNewHotelService(HotelService hotelService) throws SQLException {
        boolean check = false;
        String sql = "INSERT INTO dbo.HotelService ( HotelId, Bathroom, Bedroom, Dinningroom, Language, Internet, DrinkAndFood, ReceptionService, CleaningService, Pool, Other )\n" +
                "VALUES ( ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? )\n" +
                "SELECT @@ROWCOUNT";
        try (Connection connection = DBUtils.getInstance().getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql);) {
            int i = 0;
            preparedStatement.setInt(++i, hotelService.getHotelId());
            preparedStatement.setString(++i, hotelService.getBathroom());
            preparedStatement.setString(++i, hotelService.getBedroom());
            preparedStatement.setString(++i, hotelService.getDinningroom());
            preparedStatement.setString(++i, hotelService.getLanguage());
            preparedStatement.setString(++i, hotelService.getInternet());
            preparedStatement.setString(++i, hotelService.getDrinkAndFood());
            preparedStatement.setString(++i, hotelService.getReceptionService());
            preparedStatement.setString(++i, hotelService.getCleaningService());
            preparedStatement.setString(++i, hotelService.getPool());
            preparedStatement.setString(++i, hotelService.getOther());

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
    public Boolean updateHotelService(HotelService hotelService) throws SQLException {
        boolean check = false;
        String sql = "UPDATE dbo.HotelService \n" +
                "SET Bathroom = ?, Bedroom = ?, Dinningroom = ?, Language = ?, Internet = ?, DrinkAndFood = ?, ReceptionService = ?, CleaningService = ?, Pool = ?, Other = ?\n" +
                "WHERE ServiceId = ?\n" +
                "SELECT @@ROWCOUNT";
        try (Connection connection = DBUtils.getInstance().getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql);) {
            int i = 0;
            preparedStatement.setString(++i, hotelService.getBathroom());
            preparedStatement.setString(++i, hotelService.getBedroom());
            preparedStatement.setString(++i, hotelService.getDinningroom());
            preparedStatement.setString(++i, hotelService.getLanguage());
            preparedStatement.setString(++i, hotelService.getInternet());
            preparedStatement.setString(++i, hotelService.getDrinkAndFood());
            preparedStatement.setString(++i, hotelService.getReceptionService());
            preparedStatement.setString(++i, hotelService.getCleaningService());
            preparedStatement.setString(++i, hotelService.getPool());
            preparedStatement.setString(++i, hotelService.getOther());
            preparedStatement.setInt(++i, hotelService.getServiceId());

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
    public Boolean deleteHotelService(int hotelServiceId) throws SQLException {
        boolean check = false;
        String sql = "DELETE dbo.HotelService\n" +
                "WHERE ServiceId = ?\n" +
                "SELECT @@ROWCOUNT";
        try (Connection connection = DBUtils.getInstance().getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql);) {
            int i = 0;
            preparedStatement.setInt(++i, hotelServiceId);

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

//    public static void main(String[] args) {
//        HotelServiceDAO hotelServiceDAO = new HotelServiceDAOImpl();
//        try {
//            HotelService hotelService = hotelServiceDAO.getAllByHotelId(1);
//            System.out.println(hotelService.getHotelImage());
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//    }
}
