package com.netcracker.devschool.dev4.studdist.service;

import com.netcracker.devschool.dev4.studdist.entity.Student;

import java.util.List;

public interface StudentService {
    Student create(Student student);

    Student delete(int id) throws Exception;

    List<Student> findAll();

    List<Student> findByParams(int practiceId, String searchKey, String sortBy, String order, int start, int length);

    List<Student> findForRequest(int facultyId, int specialityId, double minAvg, String sortBy, String order, int start, int length);

    Student update(Student student) throws Exception;

    Student findById(int id);

}
