package com.booking.entity;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Builder
public class Item {
    private int qtyRoom;
    private Room room;
}
