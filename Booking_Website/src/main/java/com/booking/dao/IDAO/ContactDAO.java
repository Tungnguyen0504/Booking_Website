package com.booking.dao.IDAO;

import com.booking.entity.Contact;

import java.sql.SQLException;
import java.util.List;

public interface ContactDAO {
    Boolean addNewContact(Contact contact) throws SQLException;
    boolean checkEmailUnique(String email) throws SQLException;
    List<Contact> getAll() throws SQLException;
    Contact getContactById(int contactId) throws SQLException;
    Boolean deleteContact(int contactId) throws SQLException;
}
