package com.booking.filter;

import com.booking.entity.Account;

import javax.servlet.*;
import javax.servlet.Filter;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebFilter(urlPatterns = {"/*"})
public class LoginFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;

        String url = request.getServletPath();
        Account account = (Account) request.getSession().getAttribute("account");

        if ((url.startsWith("/admin") || url.startsWith("/checkout") || url.startsWith("/checkout-next") ||
                url.startsWith("/confirm") || url.startsWith("/my-account")) && request.getSession().getAttribute("account") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
        } else if (url.startsWith("/admin") && account.getRole() != 1) {
            response.sendRedirect(request.getContextPath() + "/home");
        } else {
            filterChain.doFilter(servletRequest, servletResponse);
        }
    }

    @Override
    public void destroy() {

    }
}
