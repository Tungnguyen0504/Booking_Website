package com.booking.entity;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

import java.sql.Date;

@Builder
@Getter
@Setter
public class Contact {
    private int contactId;
    private String fullName, email, subject, message;
    private Date sentDate;
}
