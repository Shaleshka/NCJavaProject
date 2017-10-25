package com.netcracker.devschool.dev4.studdist.service;

import com.netcracker.devschool.dev4.studdist.entity.Speciality;

import java.util.List;

public interface SpecialityService {

    Speciality create(Speciality speciality);

    Speciality delete(int id) throws Exception;

    List<Speciality> findAll();

    Speciality update(Speciality speciality) throws Exception;

    Speciality findById(int id);

    List<Speciality> findByFacultyId(int id);

}
