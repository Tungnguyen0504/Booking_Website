package com.booking.entity;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Builder
public class QtyRoomPassenger {
    private int qtyRoom, qtyPassenger;
}
