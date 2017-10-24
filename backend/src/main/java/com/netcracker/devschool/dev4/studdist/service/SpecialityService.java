package com.netcracker.devschool.dev4.studdist.service;

import com.netcracker.devschool.dev4.studdist.entity.Speciality;

import java.util.List;

/**
 * Created by Shaleshka on 24.10.17.
 */
public interface SpecialityService {

    public Speciality create(Speciality speciality);

    public Speciality delete(int id) throws Exception;

    public List<Speciality> findAll();

    public Speciality update(Speciality speciality) throws Exception;

    public Speciality findById(int id);

    public List<Speciality> findByFacultyId(int id);

}
