package com.booking.dao.IDAO;

import com.booking.entity.City;

import java.sql.SQLException;
import java.util.List;

public interface CityDAO {
    List<City> getAll() throws SQLException;
    String getCityNameById(int cityId) throws SQLException;
    City getCityById(int cityId) throws SQLException;
    Boolean addCity(City city) throws SQLException;
    Boolean updateCity(City city) throws SQLException;
    Boolean deleteCity(int cityId) throws SQLException;
}
