package com.booking.entity;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Builder
@Getter
@Setter
public class City {
    private int cityId;
    private String cityName, cityImage;
}
