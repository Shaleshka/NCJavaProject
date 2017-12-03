package com.netcracker.devschool.dev4.studdist.converters;

import com.netcracker.devschool.dev4.studdist.entity.Student;
import com.netcracker.devschool.dev4.studdist.service.FacultyService;
import com.netcracker.devschool.dev4.studdist.service.SpecialityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class StudentsConverter {

    @Autowired
    private FacultyService facultyService;

    @Autowired
    private SpecialityService specialityService;

    private String[] studentToStringArray(Student student, String facultyName, String specialityName) {
        String[] result = new String[6];
        result[0] = student.getFname();
        result[1] = student.getLname();
        result[2] = facultyName;
        result[3] = specialityName;
        result[4] = String.valueOf(student.getGroup());
        String s = String.valueOf(student.getAvgScore());
        result[5] = s.substring(0, Math.min(4, s.length()));
        return result;
    }

    public String[] studentToStringArray(Student student,
                                         boolean chekbox, boolean deleteButton, boolean editButton) {
        String facultyName = facultyService.findById(student.getFacultyId()).getName();
        String specialityName = specialityService.findById(student.getSpecialityId()).getName();
        int i = 0, offset = 0;
        if (chekbox) {
            i++;
            offset++;
        }
        if (deleteButton) i++;
        if (editButton) i++;
        String[] result = new String[6 + i];
        System.arraycopy(studentToStringArray(student, facultyName, specialityName), 0, result, offset, 6);
        if (chekbox) {
            result[0] = "<label>\n" +
                    "                                            <input name=\"isBudget\" class=\"" + i + "table_cb" + "\" id=\"cb" + student.getId() + "\" type=\"checkbox\">\n" +
                    "                                            \n" +
                    "                                        </label>\n";
        }
        i = offset + 6;
        if (editButton) {
            result[i] = "<button type=\"button\" class=\"btn btn-primary\" onclick=\"editStudent(" + student.getId() + ")\">\n" +
                    "                                                            Редактировать\n" +
                    "                                                        </button>";
            i++;
        }
        if (deleteButton) {
            result[i] = "<button type=\"button\" class=\"btn btn-danger\" onclick=\"delStudent(" + student.getId() + ")\">\n" +
                    "                                                            Удалить\n" +
                    "                                                        </button>";
        }
        return result;
    }

}
