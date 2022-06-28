package com.booking.dao.IDAO;

import com.booking.entity.City;
import com.booking.entity.HotelType;

import java.sql.SQLException;
import java.util.List;

public interface HotelTypeDAO {
    List<HotelType> getAll() throws SQLException;
    int getCountHotelTypeById(int id) throws SQLException;
    String getHotelTypeById(int id) throws SQLException;
    HotelType getHotelTypeByTypeId(int typeId) throws SQLException;
    Boolean addHotelType(HotelType hotelType) throws SQLException;
    Boolean updateHotelType(HotelType hotelType) throws SQLException;
    Boolean deleteHotelType(int typeId) throws SQLException;
}
