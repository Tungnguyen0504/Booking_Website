package com.booking.entity;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.sql.Date;

@Getter
@Setter
@Builder
@ToString
public class Account {
    private int accountId;
    private String fullName;
    private String email;
    private String password;
    private String address;
    private String phone;
    private Date dateOfBirth;
    private String country;
    private String image;
    private int role;
}
