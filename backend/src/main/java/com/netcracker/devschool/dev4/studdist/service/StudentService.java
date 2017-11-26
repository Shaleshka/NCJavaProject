package com.netcracker.devschool.dev4.studdist.service;

import com.netcracker.devschool.dev4.studdist.entity.Student;
import org.springframework.data.domain.Page;

import java.util.Date;
import java.util.List;

public interface StudentService {
    Student create(Student student);

    Student delete(int id) throws Exception;

    List<Student> findAll();

    Page<Student> findByParams(int practiceId, String searchKey, String sortBy, String order, int start, int length);

    Page<Student> findForRequest(int facultyId, int specialityId, Date startdate, Date enddate, int isbudget, double minAvg, String sortBy, String order, int start, int length);

    Student update(Student student);

    Student findById(int id);

}
