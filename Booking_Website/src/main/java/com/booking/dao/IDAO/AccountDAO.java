package com.booking.dao.IDAO;

import com.booking.entity.Account;

import java.sql.SQLException;
import java.util.List;

public interface AccountDAO {
    Account login(Account a) throws SQLException;
    Boolean addNewAccount(Account account) throws SQLException;
    Boolean updateAccount(Account account) throws SQLException;
    Boolean deleteAccount(int account) throws SQLException;
    boolean checkEmailUnique(String email) throws SQLException;
    Boolean changePassword(Account account) throws SQLException;
    Account getAccountById(int id) throws SQLException;
    List<Account> getAllAccount() throws SQLException;
}
