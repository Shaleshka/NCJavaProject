package com.netcracker.devschool.dev4.studdist.service;

import com.netcracker.devschool.dev4.studdist.entity.Speciality;
import com.netcracker.devschool.dev4.studdist.repository.SpecialityRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

@Service
public class SpecialityServiceImpl implements SpecialityService {

    @Resource
    private SpecialityRepository specialityRepository;

    @Override
    @Transactional
    public Speciality create(Speciality speciality) {
        return specialityRepository.save(speciality);
    }

    @Override
    @Transactional
    public Speciality delete(int id) throws Exception {
        if (specialityRepository.exists(id)) {
            Speciality deleted = specialityRepository.findOne(id);
            specialityRepository.delete(id);
            return deleted;
        } else {
            throw new Exception("Not found");
        }
    }

    @Override
    @Transactional
    public List<Speciality> findAll() {
        return specialityRepository.findAll();
    }

    @Override
    @Transactional
    public Speciality update(Speciality speciality) throws Exception {
        if (specialityRepository.exists(speciality.getId())) {
            Speciality updated = specialityRepository.findOne(speciality.getId());
            updated.setName(speciality.getName());
            updated.setFacultyId(speciality.getFacultyId());
            return updated;
        }
        return null;
    }

    @Override
    @Transactional
    public Speciality findById(int id) {
        return specialityRepository.findOne(id);
    }

    @Override
    @Transactional
    public List<Speciality> findByFacultyId(int id) {
        return specialityRepository.findByFacultyId(id);
    }
}
