package com.netcracker.devschool.dev4.studdist.service;

import com.netcracker.devschool.dev4.studdist.entity.Student;
import com.netcracker.devschool.dev4.studdist.repository.StudentRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Shaleshka on 23.10.17.
 */
@Service
public class StudentServiceImpl implements StudentService {

    @Resource
    private StudentRepository studentRepository;

    @Override
    @Transactional
    public Student create(Student student) {
        Student createdStudent = student;
        return studentRepository.save(createdStudent);
    }

    @Override
    @Transactional
    public Student delete(int id) throws Exception {
        Student deletedStudent = studentRepository.findOne(id);

        if (deletedStudent == null)
            throw new Exception("Not found");

        studentRepository.delete(deletedStudent);
        return deletedStudent;
    }

    @Override
    @Transactional
    public List<Student> findAll() {
        return studentRepository.findAll();
    }

    @Override
    @Transactional
    public Student update(Student student) throws Exception {
        return null; //TODO:
    }

    @Override
    public Student findById(int id) {
        return studentRepository.findOne(id);
    }
}
