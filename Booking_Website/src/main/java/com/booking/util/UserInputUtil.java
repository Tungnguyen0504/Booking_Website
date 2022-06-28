package com.booking.util;


public class UserInputUtil {
    public static boolean inputTypeInt(String value) {
        try {
            Integer.parseInt(value);
            return true;
        } catch (Exception e) {
            return false;
        }
    }
}
