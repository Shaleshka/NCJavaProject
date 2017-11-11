package com.netcracker.devschool.dev4.studdist.service;

import com.netcracker.devschool.dev4.studdist.entity.Faculty;
import com.netcracker.devschool.dev4.studdist.repository.FacultyRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Shaleshka on 24.10.17
 */
@Service
public class FacultyServiceImpl implements FacultyService {

    @Resource
    private FacultyRepository facultyRepository;

    @Override
    @Transactional
    public Faculty create(Faculty faculty) {
        return facultyRepository.save(faculty);
    }

    @Override
    @Transactional
    public Faculty delete(int id) throws Exception {
        if (facultyRepository.exists(id)) {
            Faculty deleted = facultyRepository.findOne(id);
            facultyRepository.delete(id);
            return deleted;
        } else {
            throw new Exception("Not found");
        }
    }

    @Override
    @Transactional
    public List<Faculty> findAll() {
        return facultyRepository.findAll();
    }

    @Override
    @Transactional
    public Faculty update(Faculty faculty) throws Exception {
        if (facultyRepository.exists(faculty.getId())) {
            Faculty updated = facultyRepository.findOne(faculty.getId());
            updated.setName(faculty.getName());
            return updated;
        }
        return null;
    }

    @Override
    @Transactional
    public Faculty findById(int id) {
        return facultyRepository.findOne(id);
    }
}
