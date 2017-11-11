package com.netcracker.devschool.dev4.studdist.utils;

import com.netcracker.devschool.dev4.studdist.entity.Faculty;
import com.netcracker.devschool.dev4.studdist.entity.Speciality;
import com.netcracker.devschool.dev4.studdist.entity.Student;
import com.netcracker.devschool.dev4.studdist.service.FacultyService;
import com.netcracker.devschool.dev4.studdist.service.SpecialityService;

public class StudentsConverter {

    public static String[] studentToStringArray(Student student, FacultyService facultyService, SpecialityService specialityService) {
        String[] result = new String[6];
        result[0] = student.getFname();
        result[1] = student.getLname();
        Faculty faculty = facultyService.findById(student.getFacultyId());
        if (faculty != null) result[2] = faculty.getName(); else result[2]="undefined";
        Speciality speciality = specialityService.findById(student.getSpecialityId());
        if (speciality != null) result[3] = speciality.getName(); else result[3]="undefined";
        result[4] = String.valueOf(student.getGroup());
        result[5] = String.valueOf(student.getAvgScore());
        return result;
    }

}
