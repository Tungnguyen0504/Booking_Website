package com.booking.dao.IDAO;

import java.sql.SQLException;

public interface RoomStatusDAO {
    String getRoomStatusById(int id) throws SQLException;
}
