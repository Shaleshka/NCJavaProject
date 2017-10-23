package com.netcracker.devschool.dev4.studdist.service;

import com.netcracker.devschool.dev4.studdist.entity.Student;

import java.util.List;

/**
 * Created by Shaleshka on 23.10.17.
 */
public interface StudentService {
    public Student create(Student student);

    public Student delete(int id) throws Exception;

    public List<Student> findAll();

    public Student update(Student student) throws Exception;

    public Student findById(int id);
}
