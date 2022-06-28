package com.booking.services;

import com.booking.dao.DAOImpl.HotelDAOImpl;
import com.booking.dao.DAOImpl.RoomDAOImpl;
import com.booking.dao.IDAO.HotelDAO;
import com.booking.dao.IDAO.RoomDAO;
import com.booking.entity.Account;
import com.booking.entity.Booking;
import com.booking.entity.BookingDetail;
import com.booking.entity.Room;
import com.paypal.api.payments.*;
import com.paypal.base.rest.APIContext;
import com.paypal.base.rest.PayPalRESTException;

import javax.servlet.http.HttpServletRequest;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;

public class PaymentServices {
    private static final String CLIENT_ID = "AVx5C-wMG71dl7EbOFkSU4dnJOp7e3TXgVSPIGKio-d_bDrc3vgHWUUdpXuCfQZ8qWBWxBhPY3bfM3fd";
    private static final String CLIENT_SECRET = "EGLOlERWudeTcoWiZ-dfFyO-AD1wk_bdeORfphdYuC4BejNTyQ3Xq_ajftKmTUnmDtd5qTIstLIkQrkv";
    private static final String MODE = "sandbox";

    private static HotelDAO hotelDAO = new HotelDAOImpl();
    private static RoomDAO roomDAO = new RoomDAOImpl();

    public String authorizePayment(Booking booking, List<BookingDetail> bookingDetails, HttpServletRequest request)
            throws PayPalRESTException {
        Payer payer = getPayerInformation(request, booking);
        RedirectUrls redirectUrls = getRedirectURLs(request, bookingDetails);
        List<Transaction> listTransaction = getTransactionInformation(booking, bookingDetails, request);

        Payment requestPayment = new Payment();
        requestPayment.setTransactions(listTransaction);
        requestPayment.setRedirectUrls(redirectUrls);
        requestPayment.setPayer(payer);
        requestPayment.setIntent("authorize");

        APIContext apiContext = new APIContext(CLIENT_ID, CLIENT_SECRET, MODE);

        Payment approvedPayment = requestPayment.create(apiContext);
        System.out.println("=== CREATED PAYMENT: ====");
        System.out.println(approvedPayment);
        return getApprovalLink(approvedPayment);
    }

    private Payer getPayerInformation(HttpServletRequest request, Booking booking) {
        Account account = (Account) request.getSession().getAttribute("account");
        Payer payer = new Payer();
        payer.setPaymentMethod(booking.getPayment());

        String[] name = account.getFullName().split("\\s+");
        PayerInfo payerInfo = new PayerInfo();
        payerInfo.setFirstName(name[0])
                .setLastName(name[1])
                .setEmail(account.getEmail());

        payer.setPayerInfo(payerInfo);

        return payer;
    }

    private RedirectUrls getRedirectURLs(HttpServletRequest request, List<BookingDetail> bookingDetails) {
        RedirectUrls redirectUrls = new RedirectUrls();
        String url = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath();
        try {
            redirectUrls.setCancelUrl(url + "/checkout?hotelId=" + roomDAO.getRoomByRoomId(bookingDetails.get(0).getRoomId()).getHotelId());
        } catch (SQLException e) {
            e.printStackTrace();
        }
        redirectUrls.setReturnUrl(url + "/confirm");

        return redirectUrls;
    }

    private List<Transaction> getTransactionInformation(Booking booking, List<BookingDetail> bookingDetails, HttpServletRequest request) {
        try {
            double rateConvert = 23810;

            DecimalFormat format = new DecimalFormat("#0.00");
            Details details = new Details();

            Amount amount = new Amount();
            amount.setCurrency("USD");
            amount.setDetails(details);

            Transaction transaction = new Transaction();
            transaction.setAmount(amount);
            transaction.setDescription("Reservation for " + hotelDAO.getHotelById(roomDAO.getRoomByRoomId(bookingDetails.get(0).getRoomId()).getHotelId()).getHotelName());

            ItemList itemList = new ItemList();
            List<Item> items = new ArrayList<>();

            long subDate = (long) request.getSession().getAttribute("subDate");

            double totalPrice = 0;
            for (BookingDetail detail : bookingDetails) {
                Room room = roomDAO.getRoomByRoomId(detail.getRoomId());
                double price = (room.getPrice() * (100 - room.getDiscountPercent()) / 100 * subDate) / rateConvert;

                Item item = new Item();
                item.setCurrency("USD");
                item.setName(room.getRoomType() + " x " + detail.getQuantityRoom());
                item.setPrice(format.format(price));
                item.setQuantity(detail.getQuantityRoom() + "");

                items.add(item);
                price = Double.parseDouble(format.format(price)) * detail.getQuantityRoom();
                totalPrice += price;
            }

            itemList.setItems(items);
            transaction.setItemList(itemList);

            details.setSubtotal(format.format(totalPrice));
            amount.setTotal(format.format(totalPrice));

            List<Transaction> listTransaction = new ArrayList<>();
            listTransaction.add(transaction);

            return listTransaction;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    private String getApprovalLink(Payment approvedPayment) {
        List<Links> links = approvedPayment.getLinks();
        String approvalLink = null;

        for (Links link : links) {
            if (link.getRel().equalsIgnoreCase("approval_url")) {
                approvalLink = link.getHref();
                break;
            }
        }

        return approvalLink;
    }

    public void executePayment(String paymentId, String payerId) throws PayPalRESTException {
        PaymentExecution paymentExecution = new PaymentExecution();
        paymentExecution.setPayerId(payerId);

        Payment payment = new Payment().setId(paymentId);

        APIContext apiContext = new APIContext(CLIENT_ID, CLIENT_SECRET, MODE);

        payment.execute(apiContext, paymentExecution);
    }

    public Payment getPaymentDetails(String paymentId) throws PayPalRESTException {
        APIContext apiContext = new APIContext(CLIENT_ID, CLIENT_SECRET, MODE);
        return Payment.get(apiContext, paymentId);
    }
}
