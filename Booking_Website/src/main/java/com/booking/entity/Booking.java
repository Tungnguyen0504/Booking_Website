package com.booking.entity;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.sql.Date;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.concurrent.TimeUnit;

@Builder
@Getter
@Setter
@ToString
public class Booking {
    private int bookingId, accountId, guestNumber, bookingStatusId;
    private String timeCheckin, note, payment;
    private Date bookingDate, dateFrom, dateTo;
    private double totalPrice;

    public String getBookingDateFormat() {
        String s = "";
        long millis = System.currentTimeMillis();
        Timestamp now = new Timestamp(millis);
        if ((TimeUnit.MILLISECONDS.toDays(now.getTime() - bookingDate.getTime()) <= 7) && (TimeUnit.MILLISECONDS.toDays(now.getTime() - bookingDate.getTime()) > 1)) {
            s = TimeUnit.MILLISECONDS.toDays(now.getTime() - bookingDate.getTime()) + " ngày trước";
        } else if ((TimeUnit.MILLISECONDS.toDays(now.getTime() - bookingDate.getTime()) <= 1) && (TimeUnit.MILLISECONDS.toHours(now.getTime() - bookingDate.getTime()) > 1)) {
            s = TimeUnit.MILLISECONDS.toHours(now.getTime() - bookingDate.getTime()) + " giờ trước";
        } else if (TimeUnit.MILLISECONDS.toHours(now.getTime() - bookingDate.getTime()) <= 1) {
            s = TimeUnit.MILLISECONDS.toMinutes(now.getTime() - bookingDate.getTime()) + " phút trước";
        } else {
            SimpleDateFormat df = new SimpleDateFormat("MMMM dd, yyyy");
            return df.format(bookingDate);
        }
        return s;
    }
}
