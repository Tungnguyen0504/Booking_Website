package com.booking.entity;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import lombok.experimental.SuperBuilder;

import java.sql.Date;
import java.sql.Time;

@SuperBuilder
@Getter
@Setter
@ToString
public class Hotel {
    private int hotelId, cityId, hotelTypeId, star;
    private String hotelName, address, phone, email, specialAround, description, hotelImage;
    private Time checkin, checkout;
    private Date createdDate;
}
