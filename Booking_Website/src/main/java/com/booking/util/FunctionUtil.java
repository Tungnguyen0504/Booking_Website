package com.booking.util;

import com.booking.dao.DAOImpl.BookingDAOImpl;
import com.booking.dao.DAOImpl.RatingDAOImpl;
import com.booking.dao.DAOImpl.RoomDAOImpl;
import com.booking.dao.IDAO.BookingDAO;
import com.booking.dao.IDAO.RatingDAO;
import com.booking.dao.IDAO.RoomDAO;
import com.booking.entity.Booking;
import com.booking.entity.Rating;
import com.booking.entity.Room;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.concurrent.TimeUnit;

public class FunctionUtil {

    //date generic
    public static void SetValueForDateFromAndDateTo(HttpServletRequest request, HttpServletResponse response, Date dateFrom, Date dateTo) throws ServletException {

        HttpSession session = request.getSession();

        if (dateFrom == null && dateTo == null) {
            Date date = new Date();

            Calendar c = Calendar.getInstance();
            c.setTime(date);
            c.add(Calendar.DATE, 1);
            dateFrom = c.getTime();

            c.add(Calendar.DATE, 1);
            dateTo = c.getTime();
        }

        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");

        //if dateFrom is today => add a day for dateFrom
        if(df.format(dateFrom).compareTo(df.format(new Date())) == 0) {
            Calendar c = Calendar.getInstance();
            c.setTime(dateFrom);
            c.add(Calendar.DATE, 1);
            dateFrom = c.getTime();
        }

        //compare dataFrom and dateTo, if equal => add a day for dateTo
        if(df.format(dateFrom).compareTo(df.format(dateTo)) >= 0) {
            dateTo = dateFrom;
            Calendar c = Calendar.getInstance();
            c.setTime(dateTo);
            c.add(Calendar.DATE, 1);
            dateTo = c.getTime();
        }

        session.setAttribute("dateFrom", dateFrom);
        session.setAttribute("dateTo", dateTo);

        //get date diff from now to dateFrom
        long diff1 = dateFrom.getTime() - new java.util.Date().getTime();
        long subDateFromNow = TimeUnit.MILLISECONDS.toDays(diff1);

        session.setAttribute("subDateFromNow", subDateFromNow);

        //if subDateFromNow > 2 => it will display subDateFromNow
        if (subDateFromNow > 2) {
            Calendar c = Calendar.getInstance();
            c.setTime(dateFrom);
            c.add(Calendar.DATE, -3);

            java.util.Date minusDateFrom = c.getTime();

            session.setAttribute("minusDateFrom", minusDateFrom);  //display date before dateFrom
            //get date before dateFrom -3
        }

        //subtract between dateFrom and dateTo
        long diff2 = dateTo.getTime() - dateFrom.getTime();
        long subDate = TimeUnit.MILLISECONDS.toDays(diff2);
        session.setAttribute("subDate", subDate);
    }

    public static String getDateFromNow(int month) {
        Locale locale = new Locale("vi", "VN");
        SimpleDateFormat df = new SimpleDateFormat("MMM yyyy", locale);
        Date begin = new Date();
        Calendar c = Calendar.getInstance();
        c.setTime(begin);
        c.add(Calendar.MONTH, month);
        Date dateFrom = c.getTime();
        return df.format(dateFrom);
    }

    public static double earningMonthly(int month) throws SQLException {
        double earn = 0;
        Date now = new Date();
        BookingDAO bookingDAO = new BookingDAOImpl();
        for (Booking booking : bookingDAO.getAllBooking()) {
            if (TimeUnit.MILLISECONDS.toDays(now.getTime() - booking.getBookingDate().getTime()) >= (month * 30 - 30) && TimeUnit.MILLISECONDS.toDays(now.getTime() - booking.getBookingDate().getTime()) <= (month * 30)) {
                earn += booking.getTotalPrice();
            }
        }
//        NumberFormat numberFormat = NumberFormat.getNumberInstance();
//        numberFormat.setMaximumFractionDigits(0);
        return earn;
    }

    public static int countBookingMonthly(int month) throws SQLException {
        int count = 0;
        Date now = new Date();
        BookingDAO bookingDAO = new BookingDAOImpl();
        for (Booking booking : bookingDAO.getAllBooking()) {
            if (TimeUnit.MILLISECONDS.toDays(now.getTime() - booking.getBookingDate().getTime()) >= (month * 30 - 30) && TimeUnit.MILLISECONDS.toDays(now.getTime() - booking.getBookingDate().getTime()) <= (month * 30)) {
                count++;
            }
        }
        return count;
    }

    public static Date convertStringToUtilDate(String date) {
        Date dateConvert = null;
        try {
            dateConvert = new Date((new SimpleDateFormat("dd MMM yyyy").parse(date)).getTime());
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return dateConvert;
    }

    public static int countRating(List<Rating> ratingList) {
        return ratingList.size();
    }

    public static double countRatingPoint(List<Rating> ratingList) {
        int countRate = ratingList.size(); //6
        double countStar = 0;

        if (countRate != 0) {
            countStar = ratingList.stream().mapToInt(Rating::getStarRating).sum();
            return countStar / countRate * 2;
        }

        return (countStar == 0 ? 10 : countStar);
    }

}
