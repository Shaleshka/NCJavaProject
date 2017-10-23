package com.netcracker.devschool.dev4.studdist.controller;

import com.netcracker.devschool.dev4.studdist.entity.Student;
import com.netcracker.devschool.dev4.studdist.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.Objects;

/**
 * Created by Shaleshka on 23.10.17.
 */
@Controller
@RequestMapping(value = "/students")
public class StudentsController {

    @Autowired
    private StudentService studentService;

    @RequestMapping(value = "/edit/{studentId}", method = RequestMethod.POST)
    @ResponseBody
    public Student editStudent(@PathVariable String studentId,
                               @RequestParam(value = "fname", required = false) String fname,
                               @RequestParam(value = "lname", required = false) String lname,
                               @RequestParam(value = "image", required = false) MultipartFile image,
                               @RequestParam(value = "faculty", required = false) String faculty,
                               @RequestParam(value = "speciality", required = false) String speciality,
                               @RequestParam(value = "group", required = false) String group,
                               @RequestParam(value = "isBudget", required = false) String isBudget,
                               @RequestParam(value = "avgScore", required = false) String avgScore
    ) {
        String msg = "";
        String type = "success";
        Student student = studentService.findById(Integer.parseInt(studentId));
        try {
            if (!Objects.equals(fname, "")) student.setFname(fname);
            if (!Objects.equals(lname, "")) student.setLname(lname);
            //TODO: upload file
            if (!Objects.equals(faculty, "")) student.setFacultyId(Integer.parseInt(faculty));
            if (!Objects.equals(speciality, "")) student.setSpecialityId(Integer.parseInt(speciality));
            if (!Objects.equals(group, "")) student.setGroup(Integer.parseInt(group));
            if (isBudget != null) student.setIsBudget(1);
            else student.setIsBudget(0);
            if (!Objects.equals(avgScore, "")) student.setAvgScore(Double.parseDouble(avgScore));
            studentService.update(student);
            msg = "Изменения приняты";
        } catch (Exception e) {
            e.printStackTrace();
            msg = "Ошибка!";
            type = "error";
        }
        return student;
    }

}
