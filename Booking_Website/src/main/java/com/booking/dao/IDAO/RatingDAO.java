package com.booking.dao.IDAO;

import com.booking.entity.Rating;

import java.sql.SQLException;
import java.util.List;

public interface RatingDAO {
    List<Rating> getListPaginateRatingByHotelId(int hotelId, int index, int size) throws SQLException;
    List<Rating> getAllListRatingByHotelId(int hotelId) throws SQLException;
    Boolean addNewRating(Rating rating) throws SQLException;
    List<Rating> getAllRating() throws SQLException;
    Boolean updateRatingStatus(int ratingId, int status) throws SQLException;
}
