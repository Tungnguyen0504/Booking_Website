package com.booking.dao.IDAO;

import com.booking.entity.Hotel;
import com.booking.entity.HotelService;
import com.booking.entity.Room;

import java.sql.SQLException;
import java.util.List;

public interface HotelDAO {
    List<Hotel> getAll() throws SQLException;
    Hotel getHotelById(int hotelId) throws SQLException;
    int countHotelByCityId(int cityId) throws SQLException;
    int getMinHotelPriceByCityId(int cityId) throws SQLException;
    List<Hotel> getRandomTop9() throws SQLException;
    List<Hotel> searchHotel(String name, String filter, int index, int size) throws SQLException;
    int countSearchHotel(String name, String filter) throws SQLException;
    int getLastHotelId() throws SQLException;
    Boolean addNewHotel(Hotel hotel) throws SQLException;
    Boolean updateHotel(Hotel hotel) throws SQLException;
    Boolean deleteHotel(int hotelId) throws SQLException;
}
