package com.netcracker.devschool.dev4.studdist.controller;

import com.netcracker.devschool.dev4.studdist.entity.Student;
import com.netcracker.devschool.dev4.studdist.form.StudentEdit;
import com.netcracker.devschool.dev4.studdist.service.StudentService;
import com.netcracker.devschool.dev4.studdist.utils.StudentsConverter;
import com.netcracker.devschool.dev4.studdist.utils.TableData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.Valid;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

/**
 * Controller for methods connected with students (info, updating, etc.)
 */
@Controller
@RequestMapping(value = "/students")
public class StudentsController {

    @Autowired
    private StudentService studentService;

    @Autowired
    private StudentsConverter converter;

    //Save the uploaded file to this folder


    @RequestMapping(value = "/edit/{studentId}", method = RequestMethod.POST)
    @ResponseBody
    public Object editStudent(@PathVariable String studentId,
                              @Valid @ModelAttribute("studentEdit") StudentEdit student, BindingResult result) {
        if (result.hasErrors()) {
            return result.getAllErrors();
        } else {
            Student updated = studentService.findById(Integer.parseInt(studentId));
            updated.setFname(student.getFname());
            updated.setLname(student.getLname());
            updated.setFacultyId(student.getFaculty());
            updated.setSpecialityId(student.getSpeciality());
            updated.setGroup(student.getGroup());
            updated.setAvgScore(student.getAvgScore());
            if (student.getIsBudget() != null) updated.setIsBudget(1);
            else updated.setIsBudget(0);
            studentService.update(updated);
            return updated;
        }
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
        Page<Student> page = studentService.findByParams(-1, key, result.getColumnNameForTables(Integer.parseInt(order) - 1), orderDir, Integer.parseInt(start), Integer.parseInt(length));
        List<Student> list = page.getContent();
        result.setRecordsTotal((int) page.getTotalElements() - page.getNumberOfElements());
        result.setRecordsFiltered((int) page.getTotalElements() - page.getNumberOfElements());
        result.setDraw(Integer.parseInt(draw));
        for (Student item: list
                ) {
            //passing services is temporary fix, todo: make this somehow normal
            result.addData(converter.studentToStringArray(item, true, true, true));
        }
        return result;
    }

    @RequestMapping(value = "/delete/{id}", method = RequestMethod.GET)
    @ResponseBody
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    private Student delete(@PathVariable(value = "id") String id) {
        try {
            return studentService.delete(Integer.parseInt(id));
        } catch (Exception e) {
            return null;
        }
    }

}
