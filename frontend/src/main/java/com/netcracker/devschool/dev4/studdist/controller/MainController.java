/*
 This software is the confidential information and copyrighted work of
 NetCracker Technology Corp. ("NetCracker") and/or its suppliers and
 is only distributed under the terms of a separate license agreement
 with NetCracker.
 Use of the software is governed by the terms of the license agreement.
 Any use of this software not in accordance with the license agreement
 is expressly prohibited by law, and may result in severe civil
 and criminal penalties. 
 
 Copyright (c) 1995-2017 NetCracker Technology Corp.
 
 All Rights Reserved.
 
*/
/*
 * Copyright 1995-2017 by NetCracker Technology Corp.,
 * University Office Park III
 * 95 Sawyer Road
 * Waltham, MA 02453
 * United States of America
 * All rights reserved.
 */
package com.netcracker.devschool.dev4.studdist.controller;

import com.netcracker.devschool.dev4.studdist.entity.HeadOfPractice;
import com.netcracker.devschool.dev4.studdist.entity.Student;
import com.netcracker.devschool.dev4.studdist.entity.User;
import com.netcracker.devschool.dev4.studdist.entity.UserRoles;
import com.netcracker.devschool.dev4.studdist.service.FacultyService;
import com.netcracker.devschool.dev4.studdist.service.HeadOfPracticeService;
import com.netcracker.devschool.dev4.studdist.service.StudentService;
import com.netcracker.devschool.dev4.studdist.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * @author anpi0316
 *         Date: 06.10.2017
 *         Time: 14:04
 */
@Controller
public class MainController {

    @Autowired
    private UserService userService;

    @Autowired
    private StudentService studentService;

    @Autowired
    private HeadOfPracticeService headOfPracticeService;

    @Autowired
    private FacultyService facultyService;

    @RequestMapping(value = "/register", method = RequestMethod.GET)
    public String registerPage() {

        return "register";

    }

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public ModelAndView login(@RequestParam(value = "error", required = false) String error,
                              @RequestParam(value = "logout", required = false) String logout) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();

        if (!(auth instanceof AnonymousAuthenticationToken)) {

    /* The user is logged in :) */
            String role = auth.getAuthorities().toString();


            String targetUrl = "";
            if (role.contains("STUDENT")) {
                targetUrl = "/student";
            } else if (role.contains("HOP")) {
                targetUrl = "/hop";
            } else if (role.contains("ADMIN")) {
                targetUrl = "/admin";
            }

            return new ModelAndView("redirect:" + targetUrl);

        }

        ModelAndView model = new ModelAndView();
        if (error != null) {
            model.addObject("error", "Invalid username and password!");
        }

        if (logout != null) {
            model.addObject("msg", "You've been logged out successfully.");
        }
        model.setViewName("login");

        return model;

    }

    @RequestMapping(value = "/student", method = RequestMethod.GET)
    @PreAuthorize("hasRole('ROLE_STUDENT')")
    public ModelAndView pageStudent() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        ModelAndView model = new ModelAndView();
        String name = auth.getName();
        int id = userService.getIdByName(name);
        Student student = studentService.findById(id);
        if (student != null) {
            model.addObject("name", student.getFname() + " " + student.getLname());
            model.addObject("imageUrl", "images/" + student.getImageUrl());
            model.addObject("id", student.getId());
            model.addObject("faculties", facultyService.findAll());
        }
        model.setViewName("student");
        return model;
    }

    @RequestMapping(value = "/hop", method = RequestMethod.GET)
    @PreAuthorize("hasRole('ROLE_HOP')")
    public ModelAndView pageHop() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        ModelAndView model = new ModelAndView();
        String name = auth.getName();
        int id = userService.getIdByName(name);
        HeadOfPractice headOfPractice = headOfPracticeService.findById(id);
        if (headOfPractice != null) {
            model.addObject("name", headOfPractice.getFname() + " " + headOfPractice.getLname());
            model.addObject("imageUrl", "images/" + headOfPractice.getImageUrl());
            model.addObject("company", headOfPractice.getCompanyName());
            model.addObject("id",id);
            model.addObject("faculties", facultyService.findAll());
        }
        model.setViewName("headofpractice");
        return model;
    }

    @RequestMapping(value = "/admin", method = RequestMethod.GET)
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public String pageAdmin() {
        return "admin";
    }

    //for 403 access denied page
    @RequestMapping(value = "/403", method = RequestMethod.GET)
    public String accesssDenied() {

        return "403";

    }

    @RequestMapping(value = "/logout", method = RequestMethod.GET)
    public String logoutPage(HttpServletRequest request, HttpServletResponse response) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null) {
            new SecurityContextLogoutHandler().logout(request, response, auth);
        }
        return "redirect:/login?logout";//You can redirect wherever you want, but generally it's a good practice to show login screen again.
    }

    @RequestMapping(value = "errors", method = RequestMethod.GET)
    public String renderErrorPage(HttpServletRequest httpRequest) {

        String error = "";
        int httpErrorCode = getErrorCode(httpRequest);

        switch (httpErrorCode) {
            case 404: {
                error = "404";
                break;
            }
            case 500: {
                error = "500";
                break;
            }
        }
        return error;
    }

    private int getErrorCode(HttpServletRequest httpRequest) {
        return (Integer) httpRequest
                .getAttribute("javax.servlet.error.status_code");
    }

    @RequestMapping(value = "/register", method = RequestMethod.POST)
    public ModelAndView registerStudent(@RequestParam(value = "username") String username,
                                        @RequestParam(value = "password") String password) {
        User user = new User();
        user.setUsername(username);
        password = org.apache.commons.codec.digest.DigestUtils.sha256Hex(password);
        user.setPassword(password);
        user.setEnabled(1);
        UserRoles userRoles = new UserRoles();
        userRoles.setUsername(username);
        userRoles.setRole("ROLE_STUDENT");
        int id = userService.create(user, userRoles).getUser_role_id();
        Student student = new Student();
        student.setId(id);
        student.setFname("");
        student.setLname("");
        student.setImageUrl("student_default_avatar.png");
        student.setGroup(100000);
        student.setAvgScore(10);
        student.setFacultyId(1);
        student.setSpecialityId(1);
        student.setCourse(1);
        studentService.create(student);
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("msg", "Вы были успешно зарегистрированы. Теперь вы можете войти с ипользованием указанного логина и пароля");
        modelAndView.setViewName("login");
        return modelAndView;
    }
}
/*
 WITHOUT LIMITING THE FOREGOING, COPYING, REPRODUCTION, REDISTRIBUTION,
 REVERSE ENGINEERING, DISASSEMBLY, DECOMPILATION OR MODIFICATION
 OF THE SOFTWARE IS EXPRESSLY PROHIBITED, UNLESS SUCH COPYING,
 REPRODUCTION, REDISTRIBUTION, REVERSE ENGINEERING, DISASSEMBLY,
 DECOMPILATION OR MODIFICATION IS EXPRESSLY PERMITTED BY THE LICENSE
 AGREEMENT WITH NETCRACKER. 
 
 THIS SOFTWARE IS WARRANTED, IF AT ALL, ONLY AS EXPRESSLY PROVIDED IN
 THE TERMS OF THE LICENSE AGREEMENT, EXCEPT AS WARRANTED IN THE
 LICENSE AGREEMENT, NETCRACKER HEREBY DISCLAIMS ALL WARRANTIES AND
 CONDITIONS WITH REGARD TO THE SOFTWARE, WHETHER EXPRESS, IMPLIED
 OR STATUTORY, INCLUDING WITHOUT LIMITATION ALL WARRANTIES AND
 CONDITIONS OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE,
 TITLE AND NON-INFRINGEMENT.
 
 Copyright (c) 1995-2017 NetCracker Technology Corp.
 
 All Rights Reserved.
*/