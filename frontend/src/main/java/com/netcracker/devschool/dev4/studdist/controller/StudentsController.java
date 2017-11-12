package com.netcracker.devschool.dev4.studdist.controller;

import com.netcracker.devschool.dev4.studdist.entity.Student;
import com.netcracker.devschool.dev4.studdist.service.FacultyService;
import com.netcracker.devschool.dev4.studdist.service.SpecialityService;
import com.netcracker.devschool.dev4.studdist.service.StudentService;
import com.netcracker.devschool.dev4.studdist.utils.StudentsConverter;
import com.netcracker.devschool.dev4.studdist.utils.TableData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.Objects;

/**
 * Controller for methods connected with students (info, updating, etc.)
 */
@Controller
@RequestMapping(value = "/students")
public class StudentsController {

    @Autowired
    private StudentService studentService;

    @Autowired
    private FacultyService facultyService;

    @Autowired
    private SpecialityService specialityService;

    //Save the uploaded file to this folder


    @RequestMapping(value = "/edit/{studentId}", method = RequestMethod.POST)
    @ResponseBody
    public Student editStudent(@PathVariable String studentId,
                               @RequestParam(value = "fname", required = false) String fname,
                               @RequestParam(value = "lname", required = false) String lname,
                               @RequestParam(value = "faculty", required = false) String faculty,
                               @RequestParam(value = "speciality", required = false) String speciality,
                               @RequestParam(value = "group", required = false) String group,
                               @RequestParam(value = "isBudget", required = false) String isBudget,
                               @RequestParam(value = "avgScore", required = false) String avgScore
    ) {
        String msg = "";
        Student student = studentService.findById(Integer.parseInt(studentId));
        try {
            if (!Objects.equals(fname, "") && fname != null) student.setFname(fname);
            if (!Objects.equals(lname, "") && lname != null) student.setLname(lname);
            if (!Objects.equals(faculty, "") && faculty != null) student.setFacultyId(Integer.parseInt(faculty));
            if (!Objects.equals(speciality, "") && speciality != null)
                student.setSpecialityId(Integer.parseInt(speciality));
            if (!Objects.equals(group, "") && group != null) student.setGroup(Integer.parseInt(group));
            if (isBudget != null) student.setIsBudget(1);
            else student.setIsBudget(0);
            if (!Objects.equals(avgScore, "") && avgScore != null) student.setAvgScore(Double.parseDouble(avgScore));
            studentService.update(student);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
        return student;
    }

    @RequestMapping(value = "/imageUpload/{id}", method = RequestMethod.POST)
    @ResponseBody
    public Student singleFileUpload(@PathVariable int id,
                                    @RequestParam(value = "file", required = false) MultipartFile file) {
        if ((file != null) && (!file.isEmpty())) {
            try {

                // Get the file and save it somewhere

                byte[] bytes = file.getBytes();
                String UPLOADED_FOLDER = "D:/Programming/NCJavaProject/images/";
                Path path = Paths.get(UPLOADED_FOLDER + file.getOriginalFilename());
                Files.write(path, bytes);

                Student student = studentService.findById(id);
                student.setImageUrl(file.getOriginalFilename());
                studentService.update(student);
                return student;

            } catch (IOException e) {
                return null;
            } catch (Exception e) {
                e.printStackTrace();
                return null;
            }
        } else return null;
    }

    @RequestMapping(value = "/get/{id}", method = RequestMethod.GET)
    @ResponseBody
    public Student getStudent(@PathVariable int id) {
        return studentService.findById(id);
    }

    @RequestMapping(value = "/tableAllStudents", method = RequestMethod.GET)
    @ResponseBody
    private TableData returnTable(
            @RequestParam(value = "start") String start,
            @RequestParam(value = "length") String length,
            @RequestParam(value = "draw") String draw,
            @RequestParam(value = "search[value]", required = false) String key,
            @RequestParam(value = "order[0][column]") String order,
            @RequestParam(value = "order[0][dir]") String orderDir) {
        if (key==null) key="";
        TableData result = new TableData();
        List<Student> list = studentService.findByParams(-1, key, result.getColumnNameForTables(Integer.parseInt(order)), orderDir, Integer.parseInt(start), Integer.parseInt(length));
        result.setDraw(Integer.parseInt(draw));
        StudentsConverter converter = new StudentsConverter();
        for (Student item: list
                ) {
            //passing services is temporary fix, todo: make this somehow normal
            result.addData(converter.studentToStringArrayAdvanced(item,facultyService,specialityService));
        }
        return result;
    }

}
