package com.booking.dao.DAOImpl;

import com.booking.dao.IDAO.RatingDAO;
import com.booking.entity.Booking;
import com.booking.entity.Rating;
import com.booking.jdbc.DBUtils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class RatingDAOImpl implements RatingDAO {

    @Override
    public List<Rating> getListPaginateRatingByHotelId(int hotelId, int index, int size) throws SQLException {
        List<Rating> list = new ArrayList<>();
        String sql = "SELECT rate.* FROM dbo.Rating rate JOIN dbo.Booking b\n" +
                "ON b.BookingId = rate.BookingId JOIN dbo.BookingDetail bd\n" +
                "ON bd.BookingId = b.BookingId JOIN dbo.Room room\n" +
                "ON room.RoomId = bd.RoomId JOIN dbo.Hotel h\n" +
                "ON h.HotelId = room.HotelId\n" +
                "WHERE h.HotelId = ? AND rate.StatusId = 2\n" +
                "ORDER BY rate.CreatedDate DESC\n" +
                "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try (Connection connection = DBUtils.getInstance().getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql);) {
            preparedStatement.setInt(1, hotelId);
            preparedStatement.setInt(2, (index - 1) * size);
            preparedStatement.setInt(3, size);

            ResultSet result = preparedStatement.executeQuery();
            try {
                while (result.next()) {
                    int i = 0;
                    Rating rating = Rating.builder()
                            .ratingId(result.getInt(++i))
                            .bookingId(result.getInt(++i))
                            .starRating(result.getInt(++i))
                            .title(result.getString(++i))
                            .description(result.getString(++i))
                            .createdDate(result.getTimestamp(++i))
                            .ratingStatus(result.getInt(++i))
                            .build();
                    list.add(rating);
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
    public List<Rating> getAllListRatingByHotelId(int hotelId) throws SQLException {
        List<Rating> list = new ArrayList<>();
        String sql = "SELECT rate.* FROM dbo.Rating rate JOIN dbo.Booking b\n" +
                "ON b.BookingId = rate.BookingId JOIN dbo.BookingDetail bd\n" +
                "ON bd.BookingId = b.BookingId JOIN dbo.Room room\n" +
                "ON room.RoomId = bd.RoomId JOIN dbo.Hotel h\n" +
                "ON h.HotelId = room.HotelId\n" +
                "WHERE h.HotelId = ? AND rate.StatusId = 2\n" +
                "ORDER BY rate.CreatedDate DESC";
        try (Connection connection = DBUtils.getInstance().getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql);) {
            preparedStatement.setInt(1, hotelId);

            ResultSet result = preparedStatement.executeQuery();
            try {
                while (result.next()) {
                    int i = 0;
                    Rating rating = Rating.builder()
                            .ratingId(result.getInt(++i))
                            .bookingId(result.getInt(++i))
                            .starRating(result.getInt(++i))
                            .title(result.getString(++i))
                            .description(result.getString(++i))
                            .createdDate(result.getTimestamp(++i))
                            .ratingStatus(result.getInt(++i))
                            .build();
                    list.add(rating);
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
    public Boolean addNewRating(Rating rating) throws SQLException {
        boolean check = false;
        String sql = "INSERT INTO dbo.Rating ( BookingId, StarRating, Title, Description, CreatedDate, StatusId )\n" +
                "VALUES ( ? , ? , ? , ? , GETDATE() , 1 )\n" +
                "SELECT @@ROWCOUNT";
        try (Connection connection = DBUtils.getInstance().getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql);) {
            int i = 0;
            preparedStatement.setInt(++i, rating.getBookingId());
            preparedStatement.setInt(++i, rating.getStarRating());
            preparedStatement.setString(++i, rating.getTitle());
            preparedStatement.setString(++i, rating.getDescription());

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
    public List<Rating> getAllRating() throws SQLException {
        List<Rating> list = new ArrayList<>();
        String sql = "SELECT * FROM dbo.Rating";
        try (Connection connection = DBUtils.getInstance().getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql);) {

            ResultSet result = preparedStatement.executeQuery();
            try {
                while (result.next()) {
                    int i = 0;
                    Rating rating = Rating.builder()
                            .ratingId(result.getInt(++i))
                            .bookingId(result.getInt(++i))
                            .starRating(result.getInt(++i))
                            .title(result.getString(++i))
                            .description(result.getString(++i))
                            .createdDate(result.getTimestamp(++i))
                            .ratingStatus(result.getInt(++i))
                            .build();
                    list.add(rating);
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
    public Boolean updateRatingStatus(int ratingId, int status) throws SQLException {
        boolean check = false;
        String sql = "UPDATE dbo.Rating \n" +
                "SET StatusId = ?\n" +
                "WHERE RatingId = ?\n" +
                "SELECT @@ROWCOUNT";
        try (Connection connection = DBUtils.getInstance().getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql);) {
            int i = 0;
            preparedStatement.setInt(++i, status);
            preparedStatement.setInt(++i, ratingId);

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
