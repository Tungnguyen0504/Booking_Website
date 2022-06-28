package com.booking.entity;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Builder
@Getter
@Setter
@ToString
public class BookingDetail {
    private int roomId, bookingId, quantityRoom;
    private double subTotal;
}
