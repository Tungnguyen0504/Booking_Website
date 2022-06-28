package com.booking.dao.IDAO;

import com.booking.entity.BookingDetail;

import java.sql.SQLException;
import java.util.List;

public interface BookingDetailDAO {
    BookingDetail getBookingDetailById(int bookingDetailId) throws SQLException;
    List<BookingDetail> getAllByBookingId(int bookingId) throws SQLException;
    Boolean addNewBookingDetail(BookingDetail bookingDetail) throws SQLException;
    Boolean deleteBookingDetailByBookingId(int bookingId) throws SQLException;
}
