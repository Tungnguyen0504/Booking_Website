package com.booking.dao.IDAO;

import java.sql.SQLException;

public interface BookingStatusDAO {
    String getBookingStatusByStatusId(int id) throws SQLException;
}
