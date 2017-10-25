package com.netcracker.devschool.dev4.studdist.controller;

import com.netcracker.devschool.dev4.studdist.entity.Faculty;
import com.netcracker.devschool.dev4.studdist.entity.Speciality;
import com.netcracker.devschool.dev4.studdist.service.FacultyService;
import com.netcracker.devschool.dev4.studdist.service.SpecialityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * Controller for methods connected with managing faculties and specialities
 */
@Controller
@RequestMapping(value = "/university")
public class UniversityController {

    @Autowired
    FacultyService facultyService;

    @Autowired
    SpecialityService specialityService;

    @RequestMapping(value = "/getFaculty/{id}", method = RequestMethod.GET)
    @ResponseBody
    public Faculty getFaculty(@PathVariable int id) {
        return facultyService.findById(id);
    }

    @RequestMapping(value = "/getAllFaculties", method = RequestMethod.GET)
    @ResponseBody
    public List<Faculty> getAllFaculties() {
        return facultyService.findAll();
    }

    @RequestMapping(value = "/getSpecialitiesByFacultyId/{id}", method = RequestMethod.GET)
    @ResponseBody
    public List<Speciality> getSpecilaitiesByFacultyId(@PathVariable int id) {
        return specialityService.findByFacultyId(id);
    }

}
