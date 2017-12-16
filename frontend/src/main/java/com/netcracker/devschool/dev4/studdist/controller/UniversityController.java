package com.netcracker.devschool.dev4.studdist.controller;

import com.netcracker.devschool.dev4.studdist.entity.Faculty;
import com.netcracker.devschool.dev4.studdist.entity.Speciality;
import com.netcracker.devschool.dev4.studdist.service.FacultyService;
import com.netcracker.devschool.dev4.studdist.service.SpecialityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

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
    public List<Speciality> getSpecialitiesByFacultyId(@PathVariable int id) {
        return specialityService.findByFacultyId(id);
    }

    @RequestMapping(value = "/addFaculty", method = RequestMethod.POST)
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    @ResponseBody
    public Faculty addFaculty(@RequestParam(value = "name") String name) {
        if (name.length() > 1 && name.length() < 46) {
            Faculty faculty = new Faculty();
            faculty.setName(name);
            return facultyService.create(faculty);
        }
        return null;
    }

    @RequestMapping(value = "/addSpeciality", method = RequestMethod.POST)
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    @ResponseBody
    public Speciality addSpecaility(
            @RequestParam(value = "name") String name,
            @RequestParam(value = "faculty") String fid) {
        if (name.length() > 1 && name.length() < 46 && facultyService.findById(Integer.parseInt(fid)) != null) {
            Speciality speciality = new Speciality();
            speciality.setName(name);
            speciality.setFacultyId(Integer.parseInt(fid));
            return specialityService.create(speciality);
        }
        return null;
    }

    @RequestMapping(value = "/delFaculty", method = RequestMethod.POST)
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    @ResponseBody
    public Faculty delFaculty(@RequestParam(value = "id") String id) {
        try {
            specialityService.deleteByFacultyId(Integer.parseInt(id));
            return facultyService.delete(Integer.parseInt(id));
        } catch (Exception e) {
            return null;
        }
    }

    @RequestMapping(value = "/delSpeciality", method = RequestMethod.POST)
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    @ResponseBody
    public Speciality delSpeciality(@RequestParam(value = "id") String id) {
        try {
            return specialityService.delete(Integer.parseInt(id));
        } catch (Exception e) {
            return null;
        }
    }

}
