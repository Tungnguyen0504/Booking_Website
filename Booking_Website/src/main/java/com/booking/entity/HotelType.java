package com.booking.entity;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Builder
@Getter
@Setter
@ToString
public class HotelType {
    private int typeId;
    private String typeName;
    private String hotelTypeImage;
}
