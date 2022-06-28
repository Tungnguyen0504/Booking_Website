package com.booking.dao.IDAO;

import com.booking.entity.Booking;

import java.sql.SQLException;
import java.util.List;

public interface BookingDAO {
    Booking getLastBooking(int accountId) throws SQLException;
    Boolean finishBooking(Booking booking) throws SQLException;
    Booking getBookingById(int bookingId) throws SQLException;
    Boolean checkoutBooking(int bookingId, int bookingStatusId) throws SQLException;
    List<Booking> getAllBooking() throws SQLException;
    Boolean addNewBooking(Booking booking) throws SQLException;
    Boolean updateBooking(Booking booking) throws SQLException;
    Boolean deleteBooking(int bookingId) throws SQLException;
}
