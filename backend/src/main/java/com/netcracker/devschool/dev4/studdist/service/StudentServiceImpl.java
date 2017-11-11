package com.netcracker.devschool.dev4.studdist.service;

import com.netcracker.devschool.dev4.studdist.entity.Student;
import com.netcracker.devschool.dev4.studdist.repository.StudentRepository;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

@Service
public class StudentServiceImpl implements StudentService {

    @Resource
    private StudentRepository studentRepository;

    @Override
    @Transactional
    public Student create(Student student) {
        return studentRepository.save(student);
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
        Student updated = studentRepository.findOne(student.getId());
        updated.setFname(student.getFname());
        updated.setLname(student.getLname());
        updated.setImageUrl(student.getImageUrl());
        updated.setFacultyId(student.getFacultyId());
        updated.setSpecialityId(student.getSpecialityId());
        updated.setGroup(student.getGroup());
        updated.setAvgScore(student.getAvgScore());
        updated.setIsBudget(student.getIsBudget());
        updated.setCourse(student.getCourse());
        return updated; //TODO:
    }

    @Override
    public Student findById(int id) {
        return studentRepository.findOne(id);
    }

    @Override
    public List<Student> findByPracticeId(int id, int start, int length) {
        PageRequest pageR = new PageRequest(start, length);
        Page<Student> result = studentRepository.findByPracticeId(id, pageR);
        return result.getContent();
    }
}
