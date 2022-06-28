package com.booking.entity;

import lombok.Builder;
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
public class Room extends Hotel {
    private int roomId, area, suitableFor,  discountPercent, quantity, statusId;
    private String roomType, bed, dinningroom, bathroom, roomService, view, roomImage;
    private boolean smoke;
    private double price;
}
