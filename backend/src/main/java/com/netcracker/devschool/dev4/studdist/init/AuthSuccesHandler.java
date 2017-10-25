package com.netcracker.devschool.dev4.studdist.init;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Handles different redirects after login for different users
 */
class AuthSuccessHandler extends SavedRequestAwareAuthenticationSuccessHandler {
    @Override
    protected String determineTargetUrl(HttpServletRequest request, HttpServletResponse response) {
        // Get the role of logged in user
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String role = auth.getAuthorities().toString();

        String targetUrl = "";
        if (role.contains("STUDENT")) {
            targetUrl = "/student";
        } else if (role.contains("HOP")) {
            targetUrl = "/hop";
        } else if (role.contains("ADMIN")) {
            targetUrl = "/admin";
        }
        return targetUrl;
    }
}