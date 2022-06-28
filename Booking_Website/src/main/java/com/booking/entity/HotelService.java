package com.booking.entity;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import lombok.experimental.SuperBuilder;

@SuperBuilder
@Getter
@Setter
@ToString
public class HotelService extends Hotel{
    private int serviceId;
    private String bathroom, bedroom, dinningroom, language, internet, drinkAndFood, receptionService, cleaningService, pool, other;
}
