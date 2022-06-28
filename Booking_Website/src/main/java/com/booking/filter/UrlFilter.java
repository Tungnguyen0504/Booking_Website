package com.booking.filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebFilter(urlPatterns = {"/search-hotel", "/room"})
public class UrlFilter implements javax.servlet.Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;
        String url = "";
        if (request.getSession().getAttribute("account") == null) {
            if (request.getQueryString() == null || request.getQueryString().equals("")) {
                url = request.getRequestURI();
            } else {
                url = request.getRequestURI() + "?" + request.getQueryString();
            }

            if (url.contains("search-hotel") || url.contains("room?hotelId=")) {
                request.getSession().setAttribute("url", url);
            }
        }

        filterChain.doFilter(servletRequest, servletResponse);
    }

    @Override
    public void destroy() {

    }
}
