package com.booking.dao.IDAO;

import com.booking.entity.HotelService;

import java.sql.SQLException;
import java.util.List;

public interface HotelServiceDAO {
    HotelService getHotelServiceByHotelId(int id) throws SQLException;
    List<HotelService> getAllHotelService() throws SQLException;
    Boolean addNewHotelService(HotelService hotelService) throws SQLException;
    Boolean updateHotelService(HotelService hotelService) throws SQLException;
    Boolean deleteHotelService(int hotelServiceId) throws SQLException;
}
