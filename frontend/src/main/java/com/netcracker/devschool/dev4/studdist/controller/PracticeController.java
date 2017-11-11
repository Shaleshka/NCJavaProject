package com.netcracker.devschool.dev4.studdist.controller;

import com.netcracker.devschool.dev4.studdist.dataTableUtility.StudentsConverter;
import com.netcracker.devschool.dev4.studdist.dataTableUtility.TableData;
import com.netcracker.devschool.dev4.studdist.entity.Practice;
import com.netcracker.devschool.dev4.studdist.entity.Student;
import com.netcracker.devschool.dev4.studdist.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

@Controller
@RequestMapping(value = "/practice")
public class PracticeController {

    @Autowired
    private PracticeService practiceService;

    @Autowired
    private StudentService studentService;

    @Autowired
    private FacultyService facultyService;

    @Autowired
    private SpecialityService specialityService;

    @Autowired
    private UserService userService;

    @RequestMapping(value = "/getByHop/{id}", method = RequestMethod.GET)
    @ResponseBody
    private List<Practice> getByHopId(@PathVariable String id) {
        return practiceService.findByHopId(Integer.parseInt(id));
    }

    @RequestMapping(value = "/tableForPractice/{id}", method = RequestMethod.GET)
    @ResponseBody
    private TableData   returnTable(@PathVariable String id,
                                  @RequestParam(value = "start") String start,
                                  @RequestParam(value = "length") String length,
                                  @RequestParam(value = "draw") String draw) {
        List<Student> list = studentService.findByPracticeId(Integer.parseInt(id), Integer.parseInt(start), Integer.parseInt(length));
        TableData result = new TableData();
        result.setDraw(Integer.parseInt(draw));
        for (Student item: list
             ) {
            //passing services is temporary fix, todo: make this somehow normal
            result.addData(StudentsConverter.studentToStringArray(item,facultyService,specialityService));
        }
        return result;
    }

    @RequestMapping(value = "/addRequest", method = RequestMethod.POST)
    @ResponseBody
    private Practice addPractice(@RequestParam(value = "name") String name,
                                 @RequestParam(value = "daterange") String daterange,
                                 @RequestParam(value = "number") String number,
                                 @RequestParam(value = "faculty") String faculty,
                                 @RequestParam(value = "speciality") String speciality,
                                 @RequestParam(value = "isBudget") String isBudget,
                                 @RequestParam(value = "minAvg") String minAvg) {
        //todo validation
        Practice practice = new Practice();
        practice.setName(name);
        practice.setNumber(Integer.parseInt(number));
        practice.setFacultyId(Integer.parseInt(faculty));
        practice.setSpecialityId(Integer.parseInt(speciality));
        if (isBudget != null) practice.setIsBudget(1);
        else practice.setIsBudget(0);
        practice.setMinAvg(Double.parseDouble(minAvg));

        String[] dates = daterange.split(" - ");

        DateFormat format = new SimpleDateFormat("MM/dd/yy", Locale.ENGLISH);
        try {
            Date start = format.parse(dates[0]);
            Date end = format.parse(dates[1]);
            practice.setStart(start);
            practice.setEnd(end);
        } catch (ParseException e) {
            e.printStackTrace();
        }

        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String uname = auth.getName();
        int id = userService.getIdByName(uname);
        practice.setHopId(id);
        return practiceService.create(practice);
    }

}
