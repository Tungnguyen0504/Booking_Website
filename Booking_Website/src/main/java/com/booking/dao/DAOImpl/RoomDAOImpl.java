package com.booking.dao.DAOImpl;

import com.booking.dao.IDAO.RoomDAO;
import com.booking.entity.Room;
import com.booking.jdbc.DBUtils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class RoomDAOImpl implements RoomDAO {
    @Override
    public Room getRoomMinPriceByHotelId(int id) throws SQLException {
        Room room = null;
        String sql = "SELECT TOP 1 * FROM dbo.Room\n" +
                "WHERE HotelId = ?\n" +
                "ORDER BY (Price * (100 - DiscountPercent)/100)";
        try (Connection connection = DBUtils.getInstance().getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql);) {
            preparedStatement.setInt(1, id);

            ResultSet result = preparedStatement.executeQuery();
            try {
                if (result.next()) {
                    room = Room.builder().roomType(result.getString("RoomType"))
                            .bed(result.getString("Bed"))
                            .roomService(result.getString("RoomService"))
                            .price(result.getDouble("Price"))
                            .discountPercent(result.getInt("DiscountPercent"))
                            .quantity(result.getInt("Quantity")).build();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new SQLException();
        }
        return room;
    }

    @Override
    public List<Room> getListRoomByHotelId(int id) throws SQLException {
      List<Room> list = new ArrayList<>();
        String sql = "SELECT r.*, rs.Status FROM dbo.Room r JOIN dbo.RoomStatus rs\n" +
                "ON rs.StatusId = r.StatusId\n" +
                "WHERE HotelId = ?";
        try (Connection connection = DBUtils.getInstance().getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql);) {
            preparedStatement.setInt(1, id);

            ResultSet result = preparedStatement.executeQuery();
            try {
                while (result.next()) {
                    Room room = Room.builder()
                            .roomId(result.getInt("RoomId"))
                            .hotelId(result.getInt("HotelId"))
                            .roomType(result.getString("RoomType"))
                            .area(result.getInt("Area"))
                            .bed(result.getString("Bed"))
                            .suitableFor(result.getInt("SuitableFor"))
                            .dinningroom(result.getString("Dinningroom"))
                            .bathroom(result.getString("Bathroom"))
                            .roomService(result.getString("RoomService"))
                            .smoke(result.getBoolean("Smoke"))
                            .view(result.getString("View"))
                            .price(result.getDouble("Price"))
                            .discountPercent(result.getInt("DiscountPercent"))
                            .quantity(result.getInt("Quantity"))
                            .roomImage(result.getString("RoomImage"))
                            .statusId(result.getInt("StatusId"))
                            .build();
                    list.add(room);
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
    public Room getRoomByRoomId(int id) throws SQLException {
        Room room = null;
        String sql = "SELECT * FROM dbo.Room r JOIN dbo.Hotel h\n" +
                "ON h.HotelId = r.HotelId\n" +
                "WHERE r.RoomId = ?";
        try (Connection connection = DBUtils.getInstance().getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql);) {
            preparedStatement.setInt(1, id);

            ResultSet result = preparedStatement.executeQuery();
            try {
                if (result.next()) {
                    room = Room.builder()
                            .hotelId(result.getInt("HotelId"))
                            .hotelTypeId(result.getInt("HotelTypeId"))
                            .hotelName(result.getString("HotelName"))
                            .address(result.getString("Address"))
                            .phone(result.getString("Phone"))
                            .email(result.getString("Email"))
                            .star(result.getInt("Star"))
                            .hotelImage(result.getString("HotelImage"))
                            .roomType(result.getString("RoomType"))
                            .roomId(result.getInt("RoomId"))
                            .roomType(result.getString("RoomType"))
                            .area(result.getInt("Area"))
                            .bed(result.getString("Bed"))
                            .suitableFor(result.getInt("SuitableFor"))
                            .dinningroom(result.getString("Dinningroom"))
                            .bathroom(result.getString("Bathroom"))
                            .roomService(result.getString("RoomService"))
                            .smoke(result.getBoolean("Smoke"))
                            .view(result.getString("View"))
                            .price(result.getDouble("Price"))
                            .discountPercent(result.getInt("DiscountPercent"))
                            .quantity(result.getInt("Quantity"))
                            .roomImage(result.getString("RoomImage"))
                            .statusId(result.getInt("StatusId"))
                            .build();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new SQLException();
        }
        return room;
    }

    @Override
    public Boolean subtractQuantityRoomBooking(int qtyRoom, int roomId) throws SQLException {
        boolean check = false;
        String sql = "UPDATE dbo.Room \n" +
                "SET Quantity = Quantity - ?\n" +
                "WHERE RoomId = ?\n" +
                "SELECT @@ROWCOUNT";
        try (Connection connection = DBUtils.getInstance().getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql);) {
            int i = 0;
            preparedStatement.setInt(++i, qtyRoom);
            preparedStatement.setInt(++i, roomId);

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
    public List<Room> getAllRoom() throws SQLException {
        List<Room> list = new ArrayList<>();
        String sql = "SELECT * FROM dbo.Room";
        try (Connection connection = DBUtils.getInstance().getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql);) {

            ResultSet result = preparedStatement.executeQuery();
            try {
                while (result.next()) {
                    Room room = Room.builder()
                            .roomId(result.getInt("RoomId"))
                            .hotelId(result.getInt("HotelId"))
                            .roomType(result.getString("RoomType"))
                            .area(result.getInt("Area"))
                            .bed(result.getString("Bed"))
                            .suitableFor(result.getInt("SuitableFor"))
                            .dinningroom(result.getString("Dinningroom"))
                            .bathroom(result.getString("Bathroom"))
                            .roomService(result.getString("RoomService"))
                            .smoke(result.getBoolean("Smoke"))
                            .view(result.getString("View"))
                            .price(result.getDouble("Price"))
                            .discountPercent(result.getInt("DiscountPercent"))
                            .quantity(result.getInt("Quantity"))
                            .roomImage(result.getString("RoomImage"))
                            .statusId(result.getInt("StatusId"))
                            .build();
                    list.add(room);
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
    public Boolean addRoom(Room room) throws SQLException {
        boolean check = false;
        String sql = "INSERT INTO dbo.Room ( HotelId, RoomType, Area, Bed, SuitableFor, Dinningroom, Bathroom, " +
                "RoomService, Smoke, [View], Price, DiscountPercent, Quantity, RoomImage, StatusId )\n" +
                "VALUES ( ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? )\n" +
                "SELECT @@ROWCOUNT";
        try (Connection connection = DBUtils.getInstance().getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql);) {
            int i = 0;
            preparedStatement.setInt(++i, room.getHotelId());
            preparedStatement.setString(++i, room.getRoomType());
            preparedStatement.setInt(++i, room.getArea());
            preparedStatement.setString(++i, room.getBed());
            preparedStatement.setInt(++i, room.getSuitableFor());
            preparedStatement.setString(++i, room.getDinningroom());
            preparedStatement.setString(++i, room.getBathroom());
            preparedStatement.setString(++i, room.getRoomService());
            preparedStatement.setBoolean(++i, room.isSmoke());
            preparedStatement.setString(++i, room.getView());
            preparedStatement.setDouble(++i, room.getPrice());
            preparedStatement.setInt(++i, room.getDiscountPercent());
            preparedStatement.setInt(++i, room.getQuantity());
            preparedStatement.setString(++i, room.getRoomImage());
            preparedStatement.setInt(++i, room.getStatusId());

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
    public Boolean updateRoom(Room room) throws SQLException {
        boolean check = false;
        String sql = "UPDATE dbo.Room\n" +
                "SET RoomType = ?, Area = ?, Bed = ?, SuitableFor = ?, Dinningroom = ?, Bathroom = ?, RoomService = ?, \n" +
                "Smoke = ?, [View] = ?, Price = ?, DiscountPercent = ?, Quantity = ?, RoomImage = ?\n" +
                "WHERE RoomId = ?\n" +
                "SELECT @@ROWCOUNT";
        try (Connection connection = DBUtils.getInstance().getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql);) {
            int i = 0;
            preparedStatement.setString(++i, room.getRoomType());
            preparedStatement.setInt(++i, room.getArea());
            preparedStatement.setString(++i, room.getBed());
            preparedStatement.setInt(++i, room.getSuitableFor());
            preparedStatement.setString(++i, room.getDinningroom());
            preparedStatement.setString(++i, room.getBathroom());
            preparedStatement.setString(++i, room.getRoomService());
            preparedStatement.setBoolean(++i, room.isSmoke());
            preparedStatement.setString(++i, room.getView());
            preparedStatement.setDouble(++i, room.getPrice());
            preparedStatement.setInt(++i, room.getDiscountPercent());
            preparedStatement.setInt(++i, room.getQuantity());
            preparedStatement.setString(++i, room.getRoomImage());
            preparedStatement.setInt(++i, room.getRoomId());

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
    public Boolean deleteRoom(int roomId) throws SQLException {
        boolean check = false;
        String sql = "DELETE dbo.BookingDetail WHERE RoomId = ?\n" +
                "DELETE dbo.Room WHERE RoomId = ?\n" +
                "SELECT @@ROWCOUNT";
        try (Connection connection = DBUtils.getInstance().getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql);) {
            int i = 0;
            preparedStatement.setInt(++i, roomId);
            preparedStatement.setInt(++i, roomId);

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
    public Boolean returnQtyRoom(int roomId, int qtyRoom) throws SQLException {
        boolean check = false;
        String sql = "UPDATE dbo.Room\n" +
                "SET Quantity = Quantity + ?\n" +
                "WHERE RoomId = ?\n" +
                "SELECT @@ROWCOUNT";
        try (Connection connection = DBUtils.getInstance().getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql);) {
            int i = 0;
            preparedStatement.setInt(++i, qtyRoom);
            preparedStatement.setInt(++i, roomId);

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
