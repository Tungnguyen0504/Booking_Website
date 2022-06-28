package com.booking.dao.IDAO;

import com.booking.entity.Room;

import java.sql.SQLException;
import java.util.List;

public interface RoomDAO {
    Room getRoomMinPriceByHotelId(int id) throws SQLException;
    List<Room> getListRoomByHotelId(int id) throws SQLException;
    Room getRoomByRoomId(int id) throws SQLException;
    Boolean subtractQuantityRoomBooking(int qtyRoom, int roomId) throws SQLException;
    List<Room> getAllRoom() throws SQLException;
    Boolean addRoom(Room room) throws SQLException;
    Boolean updateRoom(Room room) throws SQLException;
    Boolean deleteRoom(int roomId) throws SQLException;
    Boolean returnQtyRoom(int roomId, int qtyRoom) throws SQLException;
}
