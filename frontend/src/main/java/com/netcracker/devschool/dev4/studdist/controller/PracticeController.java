package com.netcracker.devschool.dev4.studdist.controller;

import com.netcracker.devschool.dev4.studdist.entity.HeadOfPractice;
import com.netcracker.devschool.dev4.studdist.entity.Practice;
import com.netcracker.devschool.dev4.studdist.entity.Student;
import com.netcracker.devschool.dev4.studdist.service.*;
import com.netcracker.devschool.dev4.studdist.utils.Event;
import com.netcracker.devschool.dev4.studdist.utils.StudentsConverter;
import com.netcracker.devschool.dev4.studdist.utils.TableData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

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

    @Autowired
    private HeadOfPracticeService headOfPracticeService;

    @RequestMapping(value = "/getByHop/{id}", method = RequestMethod.GET)
    @ResponseBody
    private List<Practice> getByHopId(@PathVariable String id) {
        return practiceService.findByHopId(Integer.parseInt(id));
    }

    @RequestMapping(value = "/getAll", method = RequestMethod.GET)
    @ResponseBody
    private List<Practice> getAll() {
        return practiceService.findAll();
    }

    @RequestMapping(value = "/getByStudent/{id}", method = RequestMethod.GET)
    @ResponseBody
    private List<Event> getByStudentId(@PathVariable String id) {
        List<Practice> list = practiceService.findByStudentId(Integer.parseInt(id));
        List<Event> events = new ArrayList<>();
        for (Practice item : list) {
            HeadOfPractice hop = headOfPracticeService.findById(item.getHopId());
            events.add(new Event(item.getStart(),0,hop.getCompanyName(),hop.getFname()+" "+hop.getLname(),item.getName()));
            events.add(new Event(item.getEnd(),1,hop.getCompanyName(),hop.getFname()+" "+hop.getLname(),item.getName()));
        }
        events.sort(Comparator.comparing(Event::getDate).reversed());
        return events;
    }

    @RequestMapping(value = "/tableForPractice/{id}", method = RequestMethod.GET)
    @ResponseBody
    private TableData   returnTable(@PathVariable String id,
                                    @RequestParam(value = "start") String start,
                                    @RequestParam(value = "length") String length,
                                    @RequestParam(value = "draw") String draw,
                                    @RequestParam(value = "search[value]", required = false) String key,
                                    @RequestParam(value = "order[0][column]") String order,
                                    @RequestParam(value = "order[0][dir]") String orderDir) {
        if (key == null) key = "";
        TableData result = new TableData();
        List<Student> list = studentService.findByParams(Integer.parseInt(id), key, result.getColumnNameForTables(Integer.parseInt(order)), orderDir, Integer.parseInt(start), Integer.parseInt(length));
        result.setDraw(Integer.parseInt(draw));
        StudentsConverter converter = new StudentsConverter();
        for (Student item: list
             ) {
            //passing services is temporary fix, todo: make this somehow normal
            result.addData(converter.studentToStringArray(item,facultyService,specialityService));
        }
        return result;
    }

    @RequestMapping(value = "/addRequest", method = RequestMethod.POST)
    @ResponseBody
    @PreAuthorize("hasAnyAuthority('ROLE_HOP', 'ROLE_ADMIN')")
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
