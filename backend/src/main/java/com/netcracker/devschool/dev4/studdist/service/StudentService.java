package com.netcracker.devschool.dev4.studdist.service;

import com.netcracker.devschool.dev4.studdist.entity.Student;

import java.util.List;

public interface StudentService {
    Student create(Student student);

    Student delete(int id) throws Exception;

    List<Student> findAll();

    Student update(Student student) throws Exception;

    Student findById(int id);

    List<Student> findByPracticeId(int id, int start, int length);
}
