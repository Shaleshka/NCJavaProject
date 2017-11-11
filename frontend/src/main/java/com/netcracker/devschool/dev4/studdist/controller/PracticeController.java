package com.netcracker.devschool.dev4.studdist.controller;

import com.netcracker.devschool.dev4.studdist.dataTableUtility.StudentsConverter;
import com.netcracker.devschool.dev4.studdist.dataTableUtility.TableData;
import com.netcracker.devschool.dev4.studdist.entity.Practice;
import com.netcracker.devschool.dev4.studdist.entity.Student;
import com.netcracker.devschool.dev4.studdist.service.FacultyService;
import com.netcracker.devschool.dev4.studdist.service.PracticeService;
import com.netcracker.devschool.dev4.studdist.service.SpecialityService;
import com.netcracker.devschool.dev4.studdist.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

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

}
