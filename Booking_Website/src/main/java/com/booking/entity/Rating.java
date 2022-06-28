package com.booking.entity;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.concurrent.TimeUnit;

@Builder
@Getter
@Setter
public class Rating {
    private int ratingId, bookingId, starRating, ratingStatus;
    private String title, description;
    private Timestamp createdDate;

    public String getCreatedDateFormat() {
        String s = "";
        long millis = System.currentTimeMillis();
        Timestamp now = new Timestamp(millis);
        if ((TimeUnit.MILLISECONDS.toDays(now.getTime() - createdDate.getTime()) <= 7) && (TimeUnit.MILLISECONDS.toDays(now.getTime() - createdDate.getTime()) > 1)) {
            s = TimeUnit.MILLISECONDS.toDays(now.getTime() - createdDate.getTime()) + " ngày trước";
        } else if ((TimeUnit.MILLISECONDS.toDays(now.getTime() - createdDate.getTime()) <= 1) && (TimeUnit.MILLISECONDS.toHours(now.getTime() - createdDate.getTime()) > 1)) {
            s = TimeUnit.MILLISECONDS.toHours(now.getTime() - createdDate.getTime()) + " giờ trước";
        } else if (TimeUnit.MILLISECONDS.toHours(now.getTime() - createdDate.getTime()) <= 1) {
            s = TimeUnit.MILLISECONDS.toMinutes(now.getTime() - createdDate.getTime()) + " phút trước";
        } else {
            SimpleDateFormat df = new SimpleDateFormat("MMMM dd, yyyy");
            return df.format(createdDate);
        }
        return s;
    }
}
